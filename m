Return-Path: <linux-kernel+bounces-405484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB049C51F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBD228616B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998C720DD47;
	Tue, 12 Nov 2024 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9pdjrZE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8864720B204
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403711; cv=none; b=ULlZ1szUZMi2sb0g2MxPovbkIl3QmQ9Gqx7dgmoN2Wu0KjMsvjAcn/1uOnsQna/BodYaYAEcse72zAhVvhBFuu/hkiT/aAfvDPdIVdmiHd5pbfUj+M5IJ2VWfZg2zIAKye8Onm33MeVzLfyW3s1FynV1qoGv+yqE4nTppMC7EzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403711; c=relaxed/simple;
	bh=jpa4XcrWIAvgM08KBz3NroeJWbKeIawyJRNcEeL2+9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENSuhcuLW4Lp+bvq6+M68K16KQ+GhO3KfRQwIiRpRrWs0Ck0csRR7WtWDhFc6sd4PhZGyiOP4048R1snypfmzBqVeZJqTTzYxOkeLCp4tcM64ws4fPCNe1uqoWJWJK8yr0j2W1NykDwiA7TUX7CpPVPFECzN6sNNHI4wk2lOnZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9pdjrZE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731403708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3LRFE7o764/lq/KwAISV7bJ6SwNHRnb2w6OTp6CEmqg=;
	b=E9pdjrZEa+lXfgulWNVr3UF/GEzV2QSqoh5dYx8naO7LTSlZfRRsBLNO6wIzev101uPcTR
	VtF7Q2NEjuE+9pULzhiBou6xcV2tzVGDfcFeQNcPw8gmupKYnkwY4orePaHprz8K9Pm9aN
	ecdorWXqqRzapWWgXkC8HPNNBndgXqk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-BQpeKFnrP7yZ9ATywWB4BQ-1; Tue, 12 Nov 2024 04:28:27 -0500
X-MC-Unique: BQpeKFnrP7yZ9ATywWB4BQ-1
X-Mimecast-MFC-AGG-ID: BQpeKFnrP7yZ9ATywWB4BQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43151a9ea95so33571275e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731403706; x=1732008506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LRFE7o764/lq/KwAISV7bJ6SwNHRnb2w6OTp6CEmqg=;
        b=CS6xrJrSqZ+Iu+6UjFqBDlHBoTw1Uyrmxo2n2RqalUz7+5NXkYz5qSncLiG3kabgje
         ZVW1qBggpOF9JkUExrX4V9iqnsd47rtigYx9Ah6UqSfxPTInTRrKFnblSRkxm+rgF2V2
         7tp/IFryCdYLGx5LrSN1Wa/aksmbz7xBB9W5dWg7p27R9NX+Y8CqJkAupgFzI/GJJtMH
         e44orY5Z4zz9jqs3WGFA/jphvWn9ehErW99rFqd7n/iCfQk00kvfZ8nt71j1BirXt1IB
         OcPQbeyVTFmnQUXiFqy2joyr/qJHY3wxsN6nm7wGoHpWDQFEfrIo/bJgUoRdY+QRlDZn
         URBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwjjYqxYvBIW+uaqwObO3ZHQghpvy6tEnk0/euyFF4s3hz9aKzx4fWSUkAjfmNtXdapPaLXnKhpI7YA40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67OekksOKTOFgB2zCYurxNVy4qDV7f2UI2Gjt3x6DE1vqrbQ6
	i5DShcVEcKMmlGmCZr6ER2wzphuXH8i6pC6gcikuVennbweSZt3cD1YtWbHEZpYeqQQRSd37QZu
	Cuuuaklj7b8x+XCkBTnBiHcOpLcPeO8fCNqrR20DBsIMg2TXWCyXXBtMKKcsfqQ==
X-Received: by 2002:a05:6000:18af:b0:37e:d6b9:a398 with SMTP id ffacd0b85a97d-381f0f58473mr15019437f8f.9.1731403705764;
        Tue, 12 Nov 2024 01:28:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeFow1WF3RCdO19wHgFR4siQkWFoCuOojrbHUtDMVrlBsQ3slzVULhivX2xSddNA9hsGCcXA==
X-Received: by 2002:a05:6000:18af:b0:37e:d6b9:a398 with SMTP id ffacd0b85a97d-381f0f58473mr15019417f8f.9.1731403705441;
        Tue, 12 Nov 2024 01:28:25 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5bddsm206187215e9.38.2024.11.12.01.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 01:28:25 -0800 (PST)
Message-ID: <1b335330-900e-4620-8aaf-a27424f44321@redhat.com>
Date: Tue, 12 Nov 2024 10:28:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/9] net: stmmac: Introduce dwmac1000
 ptp_clock_info and operations
To: Jakub Kicinski <kuba@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241106090331.56519-1-maxime.chevallier@bootlin.com>
 <20241106090331.56519-5-maxime.chevallier@bootlin.com>
 <20241111161205.25c53c62@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241111161205.25c53c62@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 01:12, Jakub Kicinski wrote:
> On Wed,  6 Nov 2024 10:03:25 +0100 Maxime Chevallier wrote:
>> +		mutex_unlock(&priv->aux_ts_lock);
>> +
>> +		/* wait for auxts fifo clear to finish */
>> +		ret = readl_poll_timeout(ptpaddr + PTP_TCR, tcr_val,
>> +					 !(tcr_val & GMAC_PTP_TCR_ATSFC),
>> +					 10, 10000);
> 
> Is there a good reason to wait for the flush to complete outside of 
> the mutex? 

Indeed looking at other `ptpaddr` access use-case, it looks like the
mutex protects both read and write accesses.

@Maxime: is the above intentional? looks race-prone

Thanks,

Paolo


