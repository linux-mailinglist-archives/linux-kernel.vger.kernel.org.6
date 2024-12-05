Return-Path: <linux-kernel+bounces-432899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169979E51AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11ED4166784
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A671D8E12;
	Thu,  5 Dec 2024 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AE3yLg/O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A061D5174
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392062; cv=none; b=SuSn1NJVL7fx2VSYLlQ2F6we7psPDdqKc3iGD65So3bZQmD1NqhlQRkAPIcH2WZQ6Ja51yR5GBCbWSsmuxJ3VRy+nhI9tKLVd2OoWl1PpuUxFe1kXD5Xx9eiyNO+N2gy3xAAuBngbXxQmWRp0ytDRmUejmLNoJOwgAy7ngteDPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392062; c=relaxed/simple;
	bh=wjEAfD6wcnNghAmHkwrxJtWCztMHJQ8MKYIBzuIGluE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NNwvMbObWGrr9EiBsX3ikFv9+AqDjExokpp5jUsadQJ9+daYTu0lMC4NreRnjR6o52xcb4EgtOo+lPhdi3SH7YPE8xii3tGzfO2WBp/ymT8qo28Sbaj5PWEPO5ElPNvDke3UqsTewrmxVhQ+wQA7IY96ZNaZDQ4k1Xt4ZuuQOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=unknown smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AE3yLg/O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733392046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JWUkSRUIv2Qev94E+Vreya1sHRnnDj7AgHzjxrRejBo=;
	b=AE3yLg/O067gikBq2QgxFwwaCrBVRCiuD09P4yYEh61aBSTqC/cVpPm38mtwGl8XcMZmpB
	ka5ssGF/8vDuIwYN0vPZCTsiZQ0sGspDj2jHSgUc9A60ZlyDCxACLjf/9qL2A7jHlgcjde
	REonefU09l1RmjYhr6yI6t2ZsXorTsI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-oU9z5MssPl6zrxv8CB6fNA-1; Thu, 05 Dec 2024 04:47:24 -0500
X-MC-Unique: oU9z5MssPl6zrxv8CB6fNA-1
X-Mimecast-MFC-AGG-ID: oU9z5MssPl6zrxv8CB6fNA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d52591a6so433802f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733392044; x=1733996844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWUkSRUIv2Qev94E+Vreya1sHRnnDj7AgHzjxrRejBo=;
        b=vntSgBwq0RWZ0O87Km2CETDOkRdD755jhtAHeBMGOXNskPe6tGxBwSkysAKQxZpP73
         rs8DX03+HEefEY5IyZKDAoiHdgo5lytLxhtoygELNQPGNOVUMJ6rceO4suHl+10kEYNL
         sK/+1qh0EqDwl5kNR4wAjnc9isN3/HYrT44JUROxHWD3jrPIR1SpoF09R10y1ZauIdeP
         oIjd40Dpy02lvqGwA6vx9XrJdotjGtTXEpFBspx/0rxK6EDCGR+MVfst3Epf6fmCwdWF
         ASYvT6gOQIoGZ0NWj79DWdmQXioJ56ikFT4Sw7Hlv3JDyEGtd4MPd7j08QpgNVOaLGMN
         cG/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzLUUvlramfTlXJcMTKjmX8PT+VfKZa+uF6B188huVTjEQsDl2jlGNWdIgSG6+552QtlmVRdVTDPbPevM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb+6RZjsXcydJ+mJDY393Dq8AS5OvlOQD1harcw15W4kjmW8g0
	TUUc0+2KBMGIdwJlxEUgw9i1BDnh8ipkN9C/3IO0HZncyDR5vlx2faa6YP+r7VTRsa88aBzVRq4
	bCGVasGNd0CvBW6hQiZD/3d5FPCQzOxdrHiAQYK8MeuzvQPYQHDtFzZbN1vNEPA==
X-Gm-Gg: ASbGncvakX+X8iIJGlv+U5V6CpsTfCEmg3uta/SxqOARO2kWa+dQX3PPZIbUVRC6rdM
	k9DR5kUPnazyvf/lozNpaEP9yjWyEax8x60TCx32YMdAcGMY4i1ClDBV5K/ZdzQka4fkuOkWP7P
	xBgPsJWZ7qEx23QBbW2gQmgukszS4Tk4krjWFt1Hcb6qUSKHgqagCKYq8qxPryMno5Kuhjy/I1W
	DFchPEu+JOVmYK00WiBJ2aup3Ngxs2IBEGDJhFIZDw/6YLbTYetLm8ZJMmDkEuYsoGQPVPgCXsz
X-Received: by 2002:a05:6000:2b05:b0:385:ee59:4508 with SMTP id ffacd0b85a97d-385fd3f8e35mr5666661f8f.15.1733392043756;
        Thu, 05 Dec 2024 01:47:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3Mp3k22VB7mLeM0ZR6NDs+ALbdZOCqmImOdXeOZGVFr6niHrWzqW/fDZVe8P+oBZgYroXpA==
X-Received: by 2002:a05:6000:2b05:b0:385:ee59:4508 with SMTP id ffacd0b85a97d-385fd3f8e35mr5666635f8f.15.1733392043282;
        Thu, 05 Dec 2024 01:47:23 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf446esm1462734f8f.20.2024.12.05.01.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 01:47:22 -0800 (PST)
Message-ID: <ec73fe36-978b-4e3a-a5de-5aafb54af9a8@redhat.com>
Date: Thu, 5 Dec 2024 10:47:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/5] net: phy: microchip_ptp : Add ptp library
 for Microchip phys
To: Divya Koppera <divya.koppera@microchip.com>, andrew@lunn.ch,
 arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com,
 vadim.fedorenko@linux.dev
References: <20241203085248.14575-1-divya.koppera@microchip.com>
 <20241203085248.14575-3-divya.koppera@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241203085248.14575-3-divya.koppera@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/24 09:52, Divya Koppera wrote:
> +struct mchp_ptp_clock *mchp_ptp_probe(struct phy_device *phydev, u8 mmd,
> +				      u16 clk_base_addr, u16 port_base_addr)
> +{
> +	struct mchp_ptp_clock *clock;
> +	int rc;
> +
> +	clock = devm_kzalloc(&phydev->mdio.dev, sizeof(*clock), GFP_KERNEL);
> +	if (!clock)
> +		return ERR_PTR(-ENOMEM);
> +
> +	clock->port_base_addr	= port_base_addr;
> +	clock->clk_base_addr	= clk_base_addr;
> +	clock->mmd		= mmd;
> +
> +	/* Register PTP clock */
> +	clock->caps.owner          = THIS_MODULE;
> +	snprintf(clock->caps.name, 30, "%s", phydev->drv->name);
> +	clock->caps.max_adj        = MCHP_PTP_MAX_ADJ;
> +	clock->caps.n_ext_ts       = 0;
> +	clock->caps.pps            = 0;
> +	clock->caps.adjfine        = mchp_ptp_ltc_adjfine;
> +	clock->caps.adjtime        = mchp_ptp_ltc_adjtime;
> +	clock->caps.gettime64      = mchp_ptp_ltc_gettime64;
> +	clock->caps.settime64      = mchp_ptp_ltc_settime64;
> +	clock->ptp_clock = ptp_clock_register(&clock->caps,
> +					      &phydev->mdio.dev);
> +	if (IS_ERR(clock->ptp_clock))
> +		return ERR_PTR(-EINVAL);
> +
> +	/* Initialize the SW */
> +	skb_queue_head_init(&clock->tx_queue);
> +	skb_queue_head_init(&clock->rx_queue);
> +	INIT_LIST_HEAD(&clock->rx_ts_list);
> +	spin_lock_init(&clock->rx_ts_lock);
> +	mutex_init(&clock->ptp_lock);

The s/w initialization is completed after successfully registering the
new ptp clock, is that safe? It looks like it may race with ptp callbacks.

Cheers,

Paolo


