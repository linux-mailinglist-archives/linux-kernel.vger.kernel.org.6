Return-Path: <linux-kernel+bounces-429615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9879E2397
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E4F4B2E2D9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85241F4267;
	Tue,  3 Dec 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="TvSfRQ0+"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220841EC01C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234564; cv=none; b=ce26a9DWE1MQpnfIKkMC2bGS3lxhv0Rqy4nz/mPGl9LjlwXjhpaatp9pNuEnMYsVL/RjA3NX5Y0E5Jj6UGMOD599tslUCealfc+BnTi4IBRG3FKvsPzoWObrWt1GDrLkm9FPCPWIGjTR2u1Z+ioQ3fwUtPm8J3zdKEQLNoOzo7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234564; c=relaxed/simple;
	bh=JphR2ZL5jGAJVJAbP4vcv2rrT5CT9AGb1z3/ovzSqH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCiCSTv4PH1NEV+dHwZHeSAFHOaEZr1b4LKvjpTHdY5xN7DH6eLoszjqFd0WGCyhSM3gyXBk8qx3VgDvEux9CilGHOPW0jwAE0c4UAz69JyvFli4g/DUdu3RBrDMVj8NL8+A58npMEB9R5nv6aqssg1YbM68sl/V7RLHxbiDuxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=TvSfRQ0+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53ded167ae3so6025750e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733234561; x=1733839361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JphR2ZL5jGAJVJAbP4vcv2rrT5CT9AGb1z3/ovzSqH8=;
        b=TvSfRQ0+K5Y3AnPKXaHSNHIwFpMSx7cXAuWn847/MJybR9lEHAXlh2bxja6dAGv8Cs
         7RCO/sNHejDP4GdP2GznHiCALSDyTeQ4DR0o9T1/VpcELJyHNORL1Adr7iD52DxpbA9N
         4qpFT+y8UAufvmuKD59yrDJm5P/Va7Gtv2nVK1gDLhiTfCgmCgmhasBNY1TvybWd0x7x
         B82KXU3264erw7q2c/IVbMWk9hWG3coqXGnru8esNmhpv6sOzV4QGSfZJQsY90E3ScBP
         GZ25C5/lmlrFcV1oFOZ4Rr1jS9lswCblPflyrr+fBoXjevsSKFTExfSxzpBc6tF37C0G
         M/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234561; x=1733839361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JphR2ZL5jGAJVJAbP4vcv2rrT5CT9AGb1z3/ovzSqH8=;
        b=A4XsUvNrd6rVeCOyT1tX1X6uKOpwToMoyqRflyD94ilFtk6BgpXbC+2M+UxDW/Afm2
         o0wFBopPP47iZQfsP2lTyuOrmFscTWrsCIOHlu/u0S2K46QR1HdWDxUP/riWVgHF5lKd
         CYVWnlr8WvLVPqR2VK7tzZWkT3UXK1CptQ5TEJ1IDHXdgT+CMao8l2EMHX4LOn7Lq/rr
         L3pNB3tSdjwXCcuo1WuzwemMlgYR0TlD5afcpI4xCKppn2klp3JbiO1e6nghWRkLdSI3
         492fxSPctaMLT71rj26reoLd36S7gJcZ3F67PouMcWp4rAtDHmMk6EPz3Pr0pkY9mN+K
         eY/g==
X-Forwarded-Encrypted: i=1; AJvYcCX+XA34d5V+GPfuGt5sFAK5BRDcQX5zIc+CqqeH9BjN0occn1NZ6Jw2JwlY+vGT7+UkDt5GPtQG0pciSrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGCxtI5lp7W6eJRAZAyfm8E7A2EEaM0N+aFN9Mr6zQjns4pKLE
	XdFJWXR/SC4x63lc4IgGy8Kz74q/glYKQOs6XREMy4KlI+EnMqumgqqmMdblQDc=
X-Gm-Gg: ASbGnctCVd4cGwaNT7yIegMsHNiuOjCREAfO9Ze70NooCXpUTTVqQLwAz9F7KI6Ob5B
	QBkZ6tfbY6OHqs8NoYzRaKVOezGR+BqDwIrLzPI+Y+mK1onkGQntzPXLDVYF/KPSnir31Ikipq6
	q/T4NoFACnZfU+2ofGGj9bqRaf7pWPlS6CD4HvXm0Y3vQY52xdhuIFV/9+Is/83+lkH4qEWM4wQ
	6Y+jWCIXjx+pLrKgtZZqdF4iPfdAZi6lE4GVDJ0plWcwET4PoXRgU8vW9t0skdmYL8BsA==
X-Google-Smtp-Source: AGHT+IFthPhHBgWWTuy4bv5pfQrn/RUEg3HXOZPUVZODT11J6Bsy1x1LBHaM4rykKQzP6dyUiQP8EQ==
X-Received: by 2002:a05:6512:b97:b0:53d:e8f5:f98a with SMTP id 2adb3069b0e04-53e12a2612cmr1584431e87.46.1733234561059;
        Tue, 03 Dec 2024 06:02:41 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e19a2e7b9sm96883e87.172.2024.12.03.06.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 06:02:40 -0800 (PST)
Message-ID: <d47cd2a9-441a-47ea-b509-f00657dc5495@cogentembedded.com>
Date: Tue, 3 Dec 2024 19:02:38 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
 <Z02GCGMOuiwZ4qvA@shell.armlinux.org.uk>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <Z02GCGMOuiwZ4qvA@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Does IEEE 802.3 allow auto-negotiation to be turned off for speeds
> greater than 1Gbps?

Per 802.3-2022 ch, autoneg is optional:


| 125.2.4.3 Auto-Negotiation, type single differential-pair media
|
| Auto-Negotiation (Clause 98) may be used by 2.5GBASE-T1 and
| 5GBASE-T1 devices to detect the abilities (modes of operation)
| supported by the device at the other end of a link segment,
| determine common abilities, and configure for joint operation.
| Auto-Negotiation is performed upon link startup through the use
| of half-duplex differential Manchester encoding.
|
| The use of Clause 98 Auto-Negotiation is optional for 2.5GBASE-T1
| and 5GBASE-T1 PHYs.

