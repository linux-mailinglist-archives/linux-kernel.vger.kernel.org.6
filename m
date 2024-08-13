Return-Path: <linux-kernel+bounces-284702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9975C95043F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4418D1F21C42
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5DF1991C2;
	Tue, 13 Aug 2024 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awrZO4pG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E127E1C20
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550135; cv=none; b=ioFIHqrNmoOAxMOjQ5cW1RxRZj0w8pnYcmF1JDGu6xSBA0AWOlXC2Eqzu+VTexIDcgcaDaEbueJseP25fTiFEjvdgECBY3FBB2hyV+sMQ7ZGnZzBQACnAnCOGb8Dgr7zi2t0Vtfr378/CkPci845ANkAhhKxhRIqP4ubPSUHxWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550135; c=relaxed/simple;
	bh=QlzDjE/o3zMuSfqzgLKkznLr+avzFRJAw68euwFk6ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxbWAs/RCBe4+9Nq/FxoGZxWLYYCKawrW7lqIXZF4Z/rleI95Zb8v+8hUYK8AeMS0w50eMWJ1UcGJlx29vnxm2SiXybiM+rG+TeUMTtcHcfYeWrvR9R6LNuEcaULUecRQDqVkhCYCYXDOSXy1BVvVET4EdbNa3DUFGOTZWzEljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awrZO4pG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723550132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcAwW+DWgb5evcGozYhDmJmyDSaGzLsQ43TzbBLLLSA=;
	b=awrZO4pGSUvVcWmcjJ5H2kZY1cXh2BW1f73cuj8u9JCVWY3zrH9DmKoJs1ubDmK9hwPMYd
	AARlK6X9ZcPacyNbVClMuWOir36nOMIrcWK4pIpsPEl5YXhAHxaON6LGUA9w+kH/L+3WlK
	VcJwtuSOwlPqlAqPTsgU36O/NGsUoYE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-XJXYqomwM5-vsL05VR5e0g-1; Tue, 13 Aug 2024 07:55:31 -0400
X-MC-Unique: XJXYqomwM5-vsL05VR5e0g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4267378f538so10342615e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 04:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550130; x=1724154930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcAwW+DWgb5evcGozYhDmJmyDSaGzLsQ43TzbBLLLSA=;
        b=cj8shvuXMQz5MGwxqHqh+rfc6af5TxLofnewgWzIUQv8O8FOCt3yOlnuwS3X8AxFfd
         FIVAz9pcOHxZ/g/TFlRp63mVz95bnVBGl0tBzzqtPPn3tI2NUYEau/D6VLOr4YlhYGRP
         K5HV1wcZxKGomEwNyUR5F6Lp3QlUCfV21R8eGrUEz2YBp3XUkk+nrlBQ4tBSyq4c2LrE
         CIcH5Szk1kE37K0oXEPAXWrNrkwPTvJYSIEdjnGVCKZnotABFbfzHcq9eSzvHVsXCo4L
         neJm+ivzv55tn41wtjBiDPWRtz1eRgLLEYTMw8c+N9KpN5Koen2mD0Lh3TFOI3vgXIQv
         tF1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIDHeJugIE7QhK1nVBKxv4ONnsYxvSWOjprVKpFcbjxDsmwNyg31gSkDuKl5rLH4licBOLgukFA8LSrbp21r3N8K1RYkA5VlGuX5j/
X-Gm-Message-State: AOJu0YycNv5bJlEu+4jT+Vijg4jceUl6AMX5JUDz+S+pARuwliZxStrC
	FQ/Jyh2PQsaGbPaWn1w69rJuU+yqQ6CxzA1q7TcBdr6wnTeey8A79IYwsjwENWw4oJe0AunFAjy
	9RCIpxjxlDC1Jhpt11cZhlEQqdRTKYQMNt83bh9x3OmZIdDd9qIb1Ega+LckuYYEdLd2X8d2H
X-Received: by 2002:a05:600c:4f07:b0:426:6ea6:383d with SMTP id 5b1f17b1804b1-429d75baf27mr9580265e9.2.1723550130043;
        Tue, 13 Aug 2024 04:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPVpHO+FtXGY3k00qcP/2M/n0q5DTM2+8EAw0FeDSo7/9C3Rec23QDJYX4wCY7iZPXN7Lffw==
X-Received: by 2002:a05:600c:4f07:b0:426:6ea6:383d with SMTP id 5b1f17b1804b1-429d75baf27mr9580095e9.2.1723550129555;
        Tue, 13 Aug 2024 04:55:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1708:9110:151e:7458:b92f:3067? ([2a0d:3344:1708:9110:151e:7458:b92f:3067])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c74ff9fsm224378415e9.28.2024.08.13.04.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 04:55:29 -0700 (PDT)
Message-ID: <6185be94-65b9-466d-ad1a-bded0e4f8356@redhat.com>
Date: Tue, 13 Aug 2024 13:55:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: netconsole: Populate dynamic entry even if
 netpoll fails
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com
Cc: thepacketgeek@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aijay Adams <aijay@meta.com>
References: <20240809161935.3129104-1-leitao@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240809161935.3129104-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 18:19, Breno Leitao wrote:> @@ -1304,8 +1308,6 @@ static int 
__init init_netconsole(void)
>   		while ((target_config = strsep(&input, ";"))) {
>   			nt = alloc_param_target(target_config, count);
>   			if (IS_ERR(nt)) {
> -				if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
> -					continue;
>   				err = PTR_ERR(nt);
>   				goto fail;
>   			}

AFAICS the above introduces a behavior change: if 
CONFIG_NETCONSOLE_DYNAMIC is enabled, and the options parsing fails for 
any targets in the command line, all the targets will be removed.

I think the old behavior is preferable - just skip the targets with 
wrong options.

Side note: I think the error paths in __netpoll_setup() assume the 
struct netpoll will be freed in case of error, e.g. the device refcount 
is released but np->dev is not cleared, I fear we could hit a reference 
underflow on <setup error>, <disable>

Paolo


