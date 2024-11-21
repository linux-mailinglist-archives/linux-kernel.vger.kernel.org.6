Return-Path: <linux-kernel+bounces-416653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D55F9D484C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14D21F2264D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 07:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C511C9B8E;
	Thu, 21 Nov 2024 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I49OEa1X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356657F48C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732175172; cv=none; b=WQzAJDHiaWcH4EDd8EuxcHt790BQgyseGrtmRLVuqdDF0NFbD2t1PhyqH+fUq9RSOxDFHW1yGyPXsQOTWfbEw/MjYPkKLeo9N2ahZ3n1CH7PKy1X+c1N81iBYgyLcksa5j+LfHqpVCWh8RmO4I5slANRLUx5inZs8x9KPqLr/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732175172; c=relaxed/simple;
	bh=ltlVIXEj72noAMxu0C++nlwvZY2f4jIikbQJXXY6+yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZojyFFXDHyTPw2m4O2k92ABiCAFGu1Fm6E17H/S2SONenxIMXBsaAlXkKQ70/+u3nZjJ9nc3W5XxuQaQGTmwNLiW0bJhijrl3IozWJZCLW1zezzQXcDtkNJ+XGOQb9tHd61IiuRPASELBDP3AQvVUT5EshJA7fd8BCl1l9nV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I49OEa1X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732175169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDdn0M+k8yyKr2FkBT1Y8LYWzdJLNp3idrs1OmCygfk=;
	b=I49OEa1XckFPID6Ga4F9gLu1zYvy9HJi+JFsNclmXsNAyoMbjFUt1jX2Iv/D9hse3IiBmm
	hzHv+3QrMSw4zmT1kDxvXQ1ghirwaUP2URDBPdYUCxNjGqFfyXsDLyGacTbUleU4BdyO5c
	mwXeqY57w8+4o1EOgF9uH4ki7D5ijfw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-jiuHMP1NN2S3t1H0O0oCmg-1; Thu, 21 Nov 2024 02:45:26 -0500
X-MC-Unique: jiuHMP1NN2S3t1H0O0oCmg-1
X-Mimecast-MFC-AGG-ID: jiuHMP1NN2S3t1H0O0oCmg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3822ec50b64so335140f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732175125; x=1732779925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDdn0M+k8yyKr2FkBT1Y8LYWzdJLNp3idrs1OmCygfk=;
        b=IIJPMVj2uLcPAOWW0F0He06o0yv6UbrTYaHETZFwGDRyUSPgI9/VSlVeit1GAJoS+7
         z6GaYQB4GmeGFVXkgyGNSlt42pHp1QONIE6nyo5EuGWl2mIUCVz9hpSDN1cNqXQBD7o6
         IqCAM5uFAvKqjjSZ47t6Z3HLocVGVUaDNCpLC47wnA5maStQ7j7i2fKr0llPmmbheId2
         k0ffGB12hB+3I/9OBUjyrr1fYohSqqDJl/AfdA5OftwYz2HOBSTRqRFZnFoiXdc/NEzD
         nrzfzrF8MWEcRQTrf1BPt5IsoPf8nCfdKC1KgpR5Sfb1idviME4dazsAldYodLBJ+rui
         KnoA==
X-Forwarded-Encrypted: i=1; AJvYcCV55ktyWDRH9NJHWvXvqubeTRhPnSKfK+uZISzk+aAXmUMmu2rOhhRb2JsSopifpDWDPaF7AmFBmZNMsF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRNZN+n2jYgBUWBZkRLCRERNy8WARyxMsGd3/sGL+yYVJizu4I
	Zl1H2hm5Jor8wrQakvMtqkuyc62UXtomO4CSqQIf+TIQcWbKYG53oQE6KqO87C6KrmNDnCxzCmk
	AQ9rz6MQbaVP05CVh2h0ck5jnU7DSfTtiOmmEIZz0aRXsod+ZHxThvW1IcWPgtQ==
X-Received: by 2002:a05:6000:796:b0:382:6d2:2aa9 with SMTP id ffacd0b85a97d-38254b14c09mr4474181f8f.37.1732175124873;
        Wed, 20 Nov 2024 23:45:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENjccaFYv9DnUII4IHVDnz1NtdHN+oocHRHWQvgpwzqO3y5Gm8BoZsAyaTjYXow73ws0CY0g==
X-Received: by 2002:a05:6000:796:b0:382:6d2:2aa9 with SMTP id ffacd0b85a97d-38254b14c09mr4474144f8f.37.1732175124527;
        Wed, 20 Nov 2024 23:45:24 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b4634c9fsm45793895e9.34.2024.11.20.23.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 23:45:24 -0800 (PST)
Message-ID: <d6794550-07f2-46df-aa4f-c728b06d50bd@redhat.com>
Date: Thu, 21 Nov 2024 08:45:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/16] net: stmmac: platform: Fix PTP clock rate
 reading
To: jan.petrous@oss.nxp.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Emil Renner Berthing <kernel@esmil.dk>,
 Minda Chen <minda.chen@starfivetech.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Iyappan Subramanian <iyappan@os.amperecomputing.com>,
 Keyur Chudgar <keyur@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>
References: <20241119-upstream_s32cc_gmac-v5-0-7dcc90fcffef@oss.nxp.com>
 <20241119-upstream_s32cc_gmac-v5-16-7dcc90fcffef@oss.nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241119-upstream_s32cc_gmac-v5-16-7dcc90fcffef@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 16:00, Jan Petrous (OSS) wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> The stmmac driver supports many vendors SoCs using Synopsys-licensed
> Ethernet controller IP. Most of these vendors reuse the stmmac_platform
> codebase, which has a potential PTP clock initialization issue.
> The PTP clock rate reading might require ungating what is not provided.
> 
> Fix the PTP clock initialization by enabling it immediately.
> 
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

Side, process-related note: it would be great if you could trim the
patch series below 16 (currently off-by-one):

https://elixir.bootlin.com/linux/v6.11.8/source/Documentation/process/maintainer-netdev.rst#L14

This patch looks like an independent fix, possibly worth the 'net' tree.
If so, please submit this patch separately, including a suitable fixes
tag and including the 'net' keyword in the patch subj prefix.

Thanks,

Paolo


