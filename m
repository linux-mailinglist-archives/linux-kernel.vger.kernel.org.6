Return-Path: <linux-kernel+bounces-427252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C2D9DFEC9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22C5B2CA2B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EB81FBEB5;
	Mon,  2 Dec 2024 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="ddMLzbze"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F11F8EEE
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134634; cv=none; b=h0mOcO2+qflGI7apWB0Y0Osbq7lfl00oET0RLG1rJtFiMzVJWZTbTqzDYnEGdCPdJLkJ0cvvRBX+BAwMYvk6+GDHVI6pYB2ZDKY+mqnQgz/a80636ZL6rwqdrjGGv6Q3pPQTVYDiWpXM4+FU+mqo1WN44wTmn19GwMC7GN2VM7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134634; c=relaxed/simple;
	bh=2r7XimGRWW6H7zYQnhfYnY1sR4668203OHqHzEHk44s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frvsZ6tqhMONkJ+gcjE9m1/Hd8x/9K+wFdosZ1icDRyKK4QcID/2Y3rUWWpRJwWzVanri00sWDKL9a8VnH8C7bGudvLDLOL/mC5xfMAT490U6S3xKJ2fd8pA3kVzceWdwTjvcVuo91QnqIr1ZXRIAirMxyKyIEhHvbOKbr0y8u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=ddMLzbze; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53de035ea13so4075511e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733134630; x=1733739430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFf1RmxuugZ0c4+M7u1ESLX9E9Rswmi2L3SkTIYyIxc=;
        b=ddMLzbzeBgs21gEJOBojGjWAkF24I8WZYLoApFDjaMRm3htgax5gR73P3G1UREgdpr
         95+pCHCkqQLt7sxNCDQXAV0gAo+Sk6+Gt9prHDOcmAI7LaD1I2/glFqG3SCMCdlqL8XF
         oFcEX/fHS5AiD1uieGLw9Hppn++uEGxKYU20XrVXl+U/zG5rFqoRDwHegAheSqbLe8GR
         iCyR/wP/vDKkL9H4nOLZVUx/ZWpmG/HSB9LB59L79OwexTT98Vwgh4Q3u2B0QFcibw8k
         WVavUsuB3GqmTs0zv4eKvyEycS6GMKmdGck/jpzuLqsf0YGISHBGoaqNiJzd1qafNm9Z
         EJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134630; x=1733739430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFf1RmxuugZ0c4+M7u1ESLX9E9Rswmi2L3SkTIYyIxc=;
        b=UPhIQbLIPiNt0QFjptEcZXGGl2ZW20fD9hkua+SmyEUA47FD02QIBR8dsv1QmTelPx
         mqbgR3jPbaupXPR7ewT/ff8PS9jLFWGbeCjHU1bWabukeT6QzO50jQfrO+50fki+LOH2
         cOQkUyBNS4oXpZ9GDb2Lfb+4kCtHadul8OMLb8XJmBmT/H0JKEY2aFmDq2ME5HZKDYv0
         k9luu8ho7R+ag+oBi0xsSLqmoe/o2ria0+cXpYS6bAvM+NbP89CjQeHAHj8WpTl0N0DL
         Cu8SRmn6qfpPDqUNWt4cKNCiZxUFYrAMGcvVwi23mfRE1vAv/gcC0BJocICEEoVNaokO
         rH6w==
X-Forwarded-Encrypted: i=1; AJvYcCX3jOabwmI2NAn8Ntd6wJn9Lo/aLvRPlzd9B3XVfi1trK+XgEnJ7KmUPa/epq+o37q1IwELx6MOdkgGFlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBYgkKt8wa7wg5jEcUdwfeFcxDvz1YvrS7dXTnBOBy8s3VopcX
	ahXqHK/ReMzCsqgo0CD4NwzdhfzqeS8GcTEMHm/qdyUmMP4RGNfIP63GWbbpQD4=
X-Gm-Gg: ASbGncsnzfvxo7ywZa3gbqFh8U++OMeEn9dsYMCAzGDGeTVpNTS3OztEK/4t+01+11W
	gvKDoK9z0N3a1vwDilDhRo3FdEgvkW0u/NF4aFORwEgLaEP6p0Qo1aIQHv4tHDiQT3mysBGabVM
	jJH21tE7TLR6Zoao0IH9sgsfRmeOO97lmrR/nbGdPDFguBWlf8O1F3lKtp1LO+qqYXbnosTnDza
	IT6AwLuMW1M9rpZUW/9w9z4mdYwNU+L22Uz3Gi/OULQRu4nKuSoIigjanbXm7Ufdormaw==
X-Google-Smtp-Source: AGHT+IHRZLPNljfKWkzmQ+x7kFH17iWwmYu0Jkgog3BCYQYYWLKCPRTK8cNKNVMxZlCpSaIAKvpw0A==
X-Received: by 2002:a05:6512:124e:b0:53d:a2a6:ef67 with SMTP id 2adb3069b0e04-53df01121f4mr11899621e87.49.1733134630585;
        Mon, 02 Dec 2024 02:17:10 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df644344esm1420887e87.76.2024.12.02.02.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 02:17:10 -0800 (PST)
Message-ID: <eddde51a-2e0b-48c2-9681-48a95f329f5c@cogentembedded.com>
Date: Mon, 2 Dec 2024 15:17:08 +0500
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
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
 <20241202100334.454599a7@fedora.home>
 <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
 <Z02He-kU6jlH-TJb@shell.armlinux.org.uk>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <Z02He-kU6jlH-TJb@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> To get two such PHYs talk to each other, one of the two has to be manually configured as slave.
>> (e.g. ethtool -s tsn0 master-slave forced-slave).
> 
> I don't see what that has to do with whether AN is enabled or not.
> Forcing master/slave mode is normally independent of whether AN is
> enabled.
> 
> There's four modes for it. MASTER_PREFERRED - this causes the PHY to
> generate a seed that gives a higher chance that it will be chosen as
> the master. SLAVE_PREFERRED - ditto but biased towards being a slace.
> MASTER_FORCE and SLAVE_FORCE does what it says on the tin.
> 
> We may not be implementing this for clause 45 PHYs.

Right now, 'ethtool -s tsn0 master-slave forced-slave' causes a call to driver's ethtool 
set_link_ksettings method. Which does error out for me because at the call time, speed field is 2500.

Do you mean that the actual issue is elsewhere, e.g. the 2.5G PHY driver must not ever allow 
configuration without autoneg?  Also for Base-T1?

Nikita

