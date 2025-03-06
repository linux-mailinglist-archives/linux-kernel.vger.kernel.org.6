Return-Path: <linux-kernel+bounces-548440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD2A544E1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129D73A5211
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B989205AB8;
	Thu,  6 Mar 2025 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoqzPTcV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B97F1BC20
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249819; cv=none; b=dn4xs8OvP4ZpZ+un+76/0wgq2iC/kr6XZ7rtzRMe6DI83XvSfETiBO61y0ud8yt0ecqzb0yGF3f+f4WWs574+opnm7JL9cAZLeVJDtOB/tnQGH7/wF6W3Wq0F3Rb9ivzCag/xjtmaIuIvyTxmv5t0XcnkYOUAOvt9IqGQxZ64eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249819; c=relaxed/simple;
	bh=VvoSJeZ7MPAkJtonTuw/6n3jfxm0a91F1JYboOommUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oc2NOc49Rm8Nz7z4m4Eq4YiibuB3Wc6+vHPidAZzJ0yiY/sE7MrzwhaxsG+R8USxzZ5u7BHyP5aCEUNVaod5mOtt9BOMrzxQULu5CgYC0Fe+wq9xuD+dUXM3i3/ktGpHAgjhf9akPU9il/8ECVG8oxzTv/HiaeSPnZTa59q9QUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoqzPTcV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741249817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsCMTPwBZxgkhOa7brSI6tFSY0lECBrdeb8WRKOM7b4=;
	b=hoqzPTcVq52JHA95sdn3674KRJh79xMewG090XnIqbQLU/xm3WkOUBPvjAv+uxatubcSCY
	VHGSEL/BbWSaBNO3G56sRAdqk1lmQmfCk/xaAlwh4yxy8nxjhXU0TBaaLulsoPRKXYTCNv
	XNYax9t5no8akgOcXtoZTFbK/VE7U6o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-QiMIVWnLNTacdkF8Hkh34g-1; Thu, 06 Mar 2025 03:30:15 -0500
X-MC-Unique: QiMIVWnLNTacdkF8Hkh34g-1
X-Mimecast-MFC-AGG-ID: QiMIVWnLNTacdkF8Hkh34g_1741249814
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so1489915e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 00:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249814; x=1741854614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsCMTPwBZxgkhOa7brSI6tFSY0lECBrdeb8WRKOM7b4=;
        b=IA/hET3THRMP6liVparkypBs48U+FODWdHy/g4k55B2qeKZvOu1ccXb8o7uJ7boYQ6
         EdVeV1u8RULsU54fximacRSQTEatMSwegW84XgyMfJ0Z4FBXBIHkPs75DWIJe/U1/X7j
         yxxl1j9LF27jseUS1kVZ0S4dIZf/FkdI4wrA5DhaXQ5UWbZFHgJ1brO3M6oWTg7u/wy9
         2zS0c4pCjJb5d8nLGvy/36POXlsNvbWDSAHA6o9QCD0C5oGpdJ1lQLgG98oWCM2jvJXm
         3MJw8fqoFQBJy85jjy9FmZYgQF5kXngDI5luboJRR9FuvhFgRzfULJeKiycgwThEYnrT
         XpOg==
X-Forwarded-Encrypted: i=1; AJvYcCULuWTtsE+Ga8BkpBk5FiP1Fn2cpIPbVt+A+N+cqWgXOLvkvgMEg/bY4yy2gA8SewHQ3UmVScoGeI8x0UE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Rugp8S9UETssFXgxMr3uGaTpxArWU7rzCm908tnct+Nfnh8U
	Bn57D6AR+Bw9BoLIIIGVb4BpzCBdJ5vb5VEnQUQtWEG9oOX44QVkQsl4WPgC7QpSYVsIFY99XSZ
	VRwuKGCC/Khj4NN9t5Z2cj900y/PsRv0Ciykh2Ie6QY/pGfx3zr6yhxzpoQRwUHjrG56apw==
X-Gm-Gg: ASbGnctSdIRCTI4M9UH95xFRCRhVWBDFlg2TktBA9Fw90N8VJkwlPx+UgIQn45L1ZuV
	dsQGQMacrVvj6Xq21fibr7RprfihCkmDmaYKppurnGYEviEvkeZJKrpZO5n+ZP5YURFV93S+JIX
	j4w5UGV3f23jnaAOveA5PgngWtI2zdHVupIWaDdVrldZ7q/hN/HjK2Y+qJ8UyH9Z9hNWt/AYfxJ
	tY7y10/fW2vXlGsvanwM2V5r9RtsIrDbeCNZueK9wKN71GYsoVU8Ces7qZ71wVflhWRTlDG0qes
	dSIjjv7prZqw1vxLYbmYrqNcqwPe1HoX8CRQsmb4gK5vHQ==
X-Received: by 2002:a05:600c:5117:b0:439:a6db:1824 with SMTP id 5b1f17b1804b1-43bd29d6c7fmr59684355e9.16.1741249813962;
        Thu, 06 Mar 2025 00:30:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeiiS7g9xPdRasKEgZd17TDJ4YiUIINUR88fvo+ijeTmx55HfEiBGbbv43iFagWinu4311xw==
X-Received: by 2002:a05:600c:5117:b0:439:a6db:1824 with SMTP id 5b1f17b1804b1-43bd29d6c7fmr59683995e9.16.1741249813597;
        Thu, 06 Mar 2025 00:30:13 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8da097sm12217325e9.17.2025.03.06.00.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 00:30:13 -0800 (PST)
Message-ID: <738bd67c-8688-4902-805f-4e35e6aaed4a@redhat.com>
Date: Thu, 6 Mar 2025 09:30:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 02/13] net: phy: Use an internal, searchable
 storage for the linkmodes
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>,
 Romain Gantois <romain.gantois@bootlin.com>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
 <20250303090321.805785-3-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250303090321.805785-3-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/25 10:03 AM, Maxime Chevallier wrote:
[...]
> +static int speed_duplex_to_capa(int speed, unsigned int duplex)
> +{
> +	if (duplex == DUPLEX_UNKNOWN ||
> +	    (speed > SPEED_1000 && duplex != DUPLEX_FULL))
> +		return -EINVAL;
> +
> +	switch (speed) {
> +	case SPEED_10: return duplex == DUPLEX_FULL ?
> +			      LINK_CAPA_10FD : LINK_CAPA_10HD;
> +	case SPEED_100: return duplex == DUPLEX_FULL ?
> +			       LINK_CAPA_100FD : LINK_CAPA_100HD;
> +	case SPEED_1000: return duplex == DUPLEX_FULL ?
> +				LINK_CAPA_1000FD : LINK_CAPA_1000HD;
> +	case SPEED_2500: return LINK_CAPA_2500FD;
> +	case SPEED_5000: return LINK_CAPA_5000FD;
> +	case SPEED_10000: return LINK_CAPA_10000FD;
> +	case SPEED_20000: return LINK_CAPA_20000FD;
> +	case SPEED_25000: return LINK_CAPA_25000FD;
> +	case SPEED_40000: return LINK_CAPA_40000FD;
> +	case SPEED_50000: return LINK_CAPA_50000FD;
> +	case SPEED_56000: return LINK_CAPA_56000FD;
> +	case SPEED_100000: return LINK_CAPA_100000FD;
> +	case SPEED_200000: return LINK_CAPA_200000FD;
> +	case SPEED_400000: return LINK_CAPA_400000FD;
> +	case SPEED_800000: return LINK_CAPA_800000FD;
> +	}
> +

What about adding some code here to help future patch updating LINK_CAPA
definition as needed?

Something alike:

	pr_err_once("Unknown speed %d, please update LINK_CAPS\n", speed);


> +	return -EINVAL;
> +}
> +
> +/**
> + * phy_caps_init() - Initializes the link_caps array from the link_mode_params.
> + */
> +void phy_caps_init(void)
> +{
> +	const struct link_mode_info *linkmode;
> +	int i, capa;
> +
> +	/* Fill the caps array from net/ethtool/common.c */
> +	for (i = 0; i < __ETHTOOL_LINK_MODE_MASK_NBITS; i++) {
> +		linkmode = &link_mode_params[i];
> +		capa = speed_duplex_to_capa(linkmode->speed, linkmode->duplex);
> +
> +		if (capa < 0)
> +			continue;

Or even error-out here.

/P


