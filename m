Return-Path: <linux-kernel+bounces-523236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE058A3D401
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E28D18844EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51361EC00E;
	Thu, 20 Feb 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPLqnOPQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70611E102E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041959; cv=none; b=K9cLe4RrQLGSQcjLk05Nf1oe+fh2QdQpKsedB7sNTHvVBdI1JOg14tsrgOhFFPfrty/enKPn4Ea2LIRF3WPSnYYAFSGqb2RCVbIHTooiKH733Myd+4fe6IxaozDZil9PmC6FEcx7/EgwI1fPlt9gsZt3XdpXCALsSFUUh1QaNaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041959; c=relaxed/simple;
	bh=qYR9nKryzm0N+g2oxBJ3pi4x+xx+vSkIm7pClZgHSOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HObY+jkbDQPuSRjEsp4+rp5TPrOkyTBA58MFRkLppqz1EBb6zxrw0j+/udqsX2dK+kAEBv5bV2jec8euRPCf9vm0wMerCe5n52vVCmhmamuNy9pHK14uk8XK/wfoLP4Tlw6YR0OPmgX6qm7pCk3OPZnFwGs6cvJMr+CpO5ziM6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPLqnOPQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740041953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vi69fi8DpFTd/RNozd1wgX4NhzxErJ/nkr6IYJg5tZI=;
	b=YPLqnOPQxjtbUmrqHf6OIWH4m+Cli+6n5WeOu3RiHgDxuAf2ZR4Mqf/KvqBcMr37sbrcxW
	o+EywCwnVGi3qMQbXQTwnWrSB2zMtvGtae+RFymeM3qk2tE6H9kMuzVDHaOJNIYyWi3oCa
	Zbl12CLTAVxg6wYQv9UV7iRjJlYr7AQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-dSMXT3yxMR2ROvDDwH1eWQ-1; Thu, 20 Feb 2025 03:59:12 -0500
X-MC-Unique: dSMXT3yxMR2ROvDDwH1eWQ-1
X-Mimecast-MFC-AGG-ID: dSMXT3yxMR2ROvDDwH1eWQ_1740041951
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f62a0ec3fso350185f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740041951; x=1740646751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vi69fi8DpFTd/RNozd1wgX4NhzxErJ/nkr6IYJg5tZI=;
        b=xPcg12HIgtQuSFpodW2b17hNqGj2z/Uw2CeHM7wPo7SErTOs7tOpi9WkeYXTadn/m+
         Gbd8DkmXaJBW5d8KJf1xOgWPG91LnlrEppEHbCvRf/+z4kqrzrX6579Zge3yAhzGqDj8
         B+jB/g4SUwBVuHphdzZH9SISlxRTOEQ9qOTJodLTb/iU2DS+l3dnLVBOXovYd+qF/Nq3
         IJyN+1BUpq4h2BKdQlofQ7SFDuh8HuHWtgz7eeuhcepS8R7hB0iJ6hBcGQXX7fvMXYx3
         jCRVnGwKzDSUf7RKS6s4OzlUAf9zZm6IC04CXYwlrdGR0wY8JSPbSDmT02vzjhflL9JC
         R1ww==
X-Forwarded-Encrypted: i=1; AJvYcCVDlwB3DlGiYj6e4hjL0UCgkhsIy7KDxL3fdcmB37u+MX36mloOZm3Ds2x845AmBnhRnMf0nXCR64LIpc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUCG+6O+NEIKEwkymlIy822oNKQFetz7819bh4q6dwrC8g3X1Z
	Hq8aPKfdlZ3uEC7RpWTmeyJ06Xt+yAjs/o75eKnhnb5fMVlR13qtz2Tpcrr5Hg5iZ4XhrZwtHKk
	hM4w5kYi1mFTH8BSYvmAGqJqUy7Qf6zhqhy54wAT7B+lg2DYrLP1i6hx57Uzvbw==
X-Gm-Gg: ASbGnctKrlSozPoAc3HMlhvD4OPMpU3psuzKdTCuVhRIcsy4qH2WJdSvB0MyApUuIoC
	eezH6t0+vNxsrajNahMflF/ernrR9rajeDRuhbvVxOAmhFbcJTJvTc2T2bcEqdN8DjsRkXC70pu
	AWdBo1pCd679xBgsoEJPJNG81zmq58jweVwYkwS2Vy4RXUHVq4IKf+oTHmdJL0/eedL4jAZlW1G
	DOX2r6nJ7k3Vcvu4912UN2bgr8Uud2Pw56uwRpGsEbX1zr0xeRbPxE3VWPRaeotsNd77QMimEyQ
	DgyDTnzgCF5ac2jezAmfGx3CJajCI6GtiNM=
X-Received: by 2002:a05:6000:8c:b0:38f:2cec:f3df with SMTP id ffacd0b85a97d-38f33f44f80mr15027991f8f.24.1740041950843;
        Thu, 20 Feb 2025 00:59:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI9cLg9zTTlh2PcmYGIgTxMmZCopbpnVJC7SeH7bbA6kcEpvNnjuVI80LLj0zkozJx/pc/eQ==
X-Received: by 2002:a05:6000:8c:b0:38f:2cec:f3df with SMTP id ffacd0b85a97d-38f33f44f80mr15027962f8f.24.1740041950468;
        Thu, 20 Feb 2025 00:59:10 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915719sm20217153f8f.60.2025.02.20.00.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 00:59:10 -0800 (PST)
Message-ID: <2dba7bb6-23bb-4e05-b126-b147769ad1be@redhat.com>
Date: Thu, 20 Feb 2025 09:59:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] stmmac: Replace deprecated PCI functions
To: Philipp Stanner <phasta@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Yanteng Si <si.yanteng@linux.dev>,
 Huacai Chen <chenhuacai@kernel.org>, Yinggang Gu <guyinggang@loongson.cn>,
 Feiyang Chen <chenfeiyang@loongson.cn>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Philipp Stanner <pstanner@redhat.com>
References: <20250218132120.124038-2-phasta@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250218132120.124038-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 2:21 PM, Philipp Stanner wrote:
> @@ -520,9 +522,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  {
>  	struct plat_stmmacenet_data *plat;
>  	struct stmmac_pci_info *info;
> -	struct stmmac_resources res;
> +	struct stmmac_resources res = {};

I'm sorry for nit picking, but please respect the reverse christmas
tree above - what is relevant is the full line lenght.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> index 352b01678c22..9d45af70d8a2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> @@ -155,7 +155,7 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
>  {
>  	struct stmmac_pci_info *info = (struct stmmac_pci_info *)id->driver_data;
>  	struct plat_stmmacenet_data *plat;
> -	struct stmmac_resources res;
> +	struct stmmac_resources res = {};
>  	int i;
>  	int ret;

Even more nit-picking: since you are touching this code chunck, could
you please fix the variables declaration order above?

Also, please add the target tree in the subj prefix, in this case
'net-next'.

Thanks!

Paolo


