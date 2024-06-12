Return-Path: <linux-kernel+bounces-211955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B692190595B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A83B27190
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7BB28DB3;
	Wed, 12 Jun 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrKfl4T9"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A216F0F9;
	Wed, 12 Jun 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211631; cv=none; b=QXYbWHtw+9dwY6b1nA9W69ZTp8iblLDxJA7bMlPAaL3c2cicqC4CqxcH7HqUR1qJfCdZH8ejWdbHjofGXWge00PegDkL77evm+mcG0+EjSg8zjkyCydcxcC2XX0rIeSnDgToalIgP9pioNx3DP8gUxD32BV754hQM+qMDiKxc/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211631; c=relaxed/simple;
	bh=wC/ZRCfFY5vjWmMYfF1gYSkwSnPjasf2jexLUUW4OBQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a/kK3OMXAQJ9EsGrOxoKGg2dyn2rXNxYW+mn/6JEjUQJt0a0IJ2GYekHkyB12hspKkZxWf+QYWFsEY0Fg4EKhbPobVWT4iNtDEdoUTcqn0peCwsHe/6lWItuZ2OVgJ21hk/14guyeWyzGWFIbdconYqb2QH/DH6znDjYd2eDy24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrKfl4T9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso10498339a12.3;
        Wed, 12 Jun 2024 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718211628; x=1718816428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JBPnjRpoeQL19VlNh67mH9EedY88vRmitmGmMsPik9k=;
        b=hrKfl4T9LZtM7MuaHWzEfqZ0BcEo9WHDjMbQqzASseEmJHarduzPsrEyNXhtWqVGcQ
         eIu4/vtkMURApsUSrftJCiXPeoM7lwfGoFCFgqspVlIFP+kKlzM9UxTt54Q6xr06q68C
         KyeHomAuDSVvLWAZqSThby8H3yhV8BAwaCsp01WacX0yStnrJKkFpFRMgF9onOjRktqw
         6MQyBbWzFCmfYFIrcxUcqNzDd72opVfQmJFgvoI9ESloV+WxebeHVRg87WgN1nZQaE+O
         iU0SeT2rXIvBHJZcWiJxKw3TrshrG3BP6IkXE6NbmIKmsO9sPPOr9OkkPlYRz1K71mYg
         Dplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718211628; x=1718816428;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBPnjRpoeQL19VlNh67mH9EedY88vRmitmGmMsPik9k=;
        b=OmPlYlYy01aH/mt3zjqlthvyXbS38Y1bKo5oQou82RYHXaoMMCGwNEME7XDkLuH/rP
         JOplPCGWljs8D4U7RjQ8kBucJWBeU5IOMR0cVPSKzpUxFx5zUlYjyq2AFCW9wagW5/jP
         ulKYDnqAItP7GxViba0vZ9ZQmfh8VhfiGbfp9rr1jo73EfbqSkUgo8WAA/QF1U2a58lW
         K7R4WeaRtCs9wE4iQoKBWSwqoOT/eDPAMDoXbbbut3zJy/NZcaBRjsDdB2CRInFXyrOS
         uD9dRIzA4ukBW70xsPb9cF4/XnpgQIEsD8pJDWZXBjyKi7AymT8y1NFOj3zTgsWXgKVO
         w3xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM8sSjXQ1ORz9BQpwu6AFpiOZR7gNrxyTOxfjVQyIxQkL1WIhXC+2sNOjIOaw1wNBWD550Fr8GJCIFyKIN4gBRWyBncXOxW4fStHtpN6Zkvt1ZUb10TvjO1Ltk2/KYttyjw6UKdOvHFA==
X-Gm-Message-State: AOJu0Ywwn206Qc6OXiPaQx3JYAvhqfDZBQ5kmm9R7+j2IL7HHTQYhmNW
	TEeCCvWx9VxLQBV1XukEgAapFxb6YhqHkTJ2ip0dJlsXUE9ayG8VzNqTcA==
X-Google-Smtp-Source: AGHT+IFN3/54A0jx6IfaLj//pybO4I+nOsXSQno7nvS4bnujuBC1BlwBDrJA2dvKJ2z3yR/yAVEWAA==
X-Received: by 2002:a50:a693:0:b0:57c:6461:5c62 with SMTP id 4fb4d7f45d1cf-57caaabf7e6mr1533204a12.37.1718211627936;
        Wed, 12 Jun 2024 10:00:27 -0700 (PDT)
Received: from [192.168.50.203] (83.8.204.47.ipv4.supernova.orange.pl. [83.8.204.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae202396sm11441781a12.74.2024.06.12.10.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 10:00:27 -0700 (PDT)
Message-ID: <e34a1e18-28c9-4aff-827f-d9f11bcb1d49@gmail.com>
Date: Wed, 12 Jun 2024 19:00:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH 0/2] ARM: dts: bcm-mobile: Split out nodes used by both
 BCM21664 and BCM23550
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240605-bcm21664-common-v1-0-6386e9141eb6@gmail.com>
 <ZmRXTgPxrGZIYjQa@standask-GA-A55M-S2HP>
Content-Language: en-US
In-Reply-To: <ZmRXTgPxrGZIYjQa@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8.06.2024 15:06, Stanislav Jakubek wrote:
>> To make development for both platforms easier, split out the common
>> nodes into a separate DTSI, bcm21664-common.dtsi. This only leaves
>> the device-specific nodes - so, CPU and related things - in the SoC-
>> specific DTSIs (bcm21664.dtsi and bcm23550.dtsi).
> 
> The name "bcm21664-common" makes me think that it's a DTSI for common
> properties of multiple BCM21664 *board* DTs, which is obviously not the
> case here. IMO something like "bcm21664-bcm23550-common" makes more sense here.
> 
The "bcm21664-common" name sounds fine to me, though I can certainly see
how it could be interpreted as a board DTSI (I was planning to make a
bcm21664-samsung-common.dtsi for Samsung's BCM21664-based phones, funny
enough...)

The idea of just putting together the two model numbers sounded a bit
awkward to me at first, but I've been thinking about it and I'm starting
to warm up to it. There are a handful of examples of a similar double-
naming scheme: e.g. intel-ixp45x-ixp46x.dtsi, sunxi-h3-h5.dtsi, sun8i-
a23-a33.dtsi. The difference is that these DTSIs have a manufacturer
prefix and no "-common" suffix.

I had many ideas for naming the common DTSI. My initial idea was
"bcm216xx.dtsi", but that would cover the BCM21654 (which has a few more
differences); then "bcm2166x.dtsi" which would cover the BCM21663 and
BCM21664 (which AFAIK are largely the same). We could combine it with
the current name and get "bcm2166x-common.dtsi". That already sounds
less like a board file to me, what do you think?

>> It's worth noting though that some bcm23550 compatibles now go unused,
>> since the bcm21664-common.dtsi file uses bcm21664 compatibles.
> 
> I don't think this is the way to go. While in these cases the Linux drivers
> match only on the generic brcm,kona-* fallback compatible (AFAIK anyway),
> the compatibles in DT should still be (SoC-)specific.
> 
> I think the common DTSI should omit the compatible values altogether
> and instead have the compatible be specified in SoC DTSI. You could keep
> a note in the common DTSI saying that the compatible is in SoC DTSI or
> something similar.

There's plenty of DTSIs in the kernel that have "device-specific"
compatibles in common DTSIs. Off the top of my head I can name the
Exynos 4 DTSIs that do this pretty often[1][2][3] (4210 and 4212
compatibles in DTSIs that are later included from the 4412 DTSI, but
which does not override any of them).

While looking around for examples I stumbled upon some sunxi DTSIs that
actually do *both*: have some compatibles that mention one of the two
models they cover, but leave some compatibles to be set in the child
DTSIs[4][5].

Since as I mentioned the underlying components seem to be the exact
same, the compatibles are really just cosmetic; plus I feel like lots of
such compatible-only nodes could add unnecessary noise to the SoC DTSIs.

With that said, I'm not against the idea, and I suppose it's not too
much extra work. I'm curious what other reviewers will have to say, but
either way I'll try to incorporate this into the next version of this
patchset.

Best regards
Artur

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/samsung/exynos4.dtsi
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/samsung/exynos4x12.dtsi
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/samsung/exynos4412.dtsi
[4] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/allwinner/sunxi-h3-h5.dtsi
[5] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/allwinner/sun8i-a23-a33.dtsi

