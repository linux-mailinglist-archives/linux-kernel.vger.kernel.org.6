Return-Path: <linux-kernel+bounces-547507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D926A50A43
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64A51727C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C22225332E;
	Wed,  5 Mar 2025 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwOC/oGB"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A982512C7;
	Wed,  5 Mar 2025 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200544; cv=none; b=s2Ded/ViIYMGk/IbKJQXIZm5shJX9/wamM8WRgTA/hdxdMkRp3ODVrIi8pj4p8GUCgJgvJBiKkxFAoCVmwUBGN8Ain2hFrmbImL9C7f2lg+w31aeZofR7NocpJt/SG/3t3O7lrtIy5kdSwisVxU3AaEkdW6QhjAAOlepg3VWRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200544; c=relaxed/simple;
	bh=ymUZ1FCwcuUyrRhWxt4QnybrFkaPnszRqBqt/ownpms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7eQHVM6EtQDGX0DZhKwiG20KsCe5n70ewvyr/swx+zBTAHlFfklrO0+QNB8Ag/dZyLuiWg9v8PICeeDSqUom9lR44+wbWGbAA2lKTzaAzFoJKwUmX6im+VG3HL8c1saHM5pWFxxbBcWzPKZQQqjLOtABOZ+xadV1ad3JyIpauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwOC/oGB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43996e95114so49131825e9.3;
        Wed, 05 Mar 2025 10:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741200541; x=1741805341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xJE/R5/BnCgol81UrY/cLHMX89sZpiDt1jINbKrX0o=;
        b=IwOC/oGBALG73PbsjutG0z30tmFkJcxD88nMJmMe5YiqwnDJ6Lb+XUXsdPPlkKdO7Z
         y+CcgBaovxvpvNZI9a7mQzUcpUXKatUW0xgrQF7UPVFOo+OEAc2dAvggJN7C7rMlYqin
         DsyzH8WSujOskXirvBLM765xbhfI4dUX84229TQK43RwHJmUY8s9KuPuiep6+QrZXlhu
         WKlvdjL9bUHWIZ1LOmxYlc0cs46snWiqIJbyY2VC8+DDuUrKKRagyZAT0j+WXJ1I9Y2O
         /Yp+Uhf5Riy+iSwz8t7UpSLM8I3ewRoQpFkLmxE9MDR88qP+PS7B23m5k3CgKDESaBKg
         ViOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741200541; x=1741805341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xJE/R5/BnCgol81UrY/cLHMX89sZpiDt1jINbKrX0o=;
        b=seETqWeq3Y5qs+Mb4vc1GstBV8abX4dExwskCl/3GRuEBEv5Slp8JJ2uZa2IKDuYsL
         bdLnNjjhdA6+BnkY5guCNncFA/L4DyP4h94qhC0gCp5eQTGTESZxgdVj1a3fhRdUDN6u
         PeTqNl6srC8R7OyrCl07lqSb/RjRWIjX627dHXntvkC23NgvMAAsi98vQIVEKHb7gmJZ
         edwthchHEp9JuMwX9Htfv14zKxb1SKoh9YMoKDluvF/dacBhJwII6HH5LbdZfM6clqdV
         UC150088XANok72s+xidnl8PkP1Jg2O65iydtHKziskXEAWu8wdtKw5q+r+UBf+pkF8F
         1J+g==
X-Forwarded-Encrypted: i=1; AJvYcCV2zFvKWFXQCq2fPts8HAEWVRA662b6/4ZHxX+CidkLUcT8ehGi7GiPEwIct3DHd1keHNX4ieBKDdzlCUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25NosCF5aZkhLR/zAwRSKtzhdWmyG7bivIxZcTDYtWbRK9lnK
	B2GPVyh9ALE7I/dNH3ow5L8XjJD3nGhPMdN7Nh5R9xf5hSWKnEFa
X-Gm-Gg: ASbGncsOCzvlQP8j/jkp/jFT2r9u8LNNgAzvVQant4l6M64RKzljaPMgisVUTJiXKqR
	+9cDvYwW1ftjH693x2p9jJiLvjoSPhI5v9+/AtPZKscyry74jiT4MdRl38QzldOdU+ZaiSISL+S
	ON6kA+2jITbSkWt8houMK2mkQU6E6BGEoa/slsbz5oqqpG+dm9SbKrg2B0GXjNXulr1ggN9+Xfa
	3lYqTxepCrbOfcO3JMyj4mbym5saRBdcEmN3HQct8QEs/UchaGc274DYD46wEwxeKZBLc+OUsnc
	BQBnMk0H/4PtoNiX0k05a4kzfRM1R2Ds9Ky29fVn581+2LQqhmHj5t5X9h+KpcYCp2YZN0rl2fd
	tc7MzGigVsVZ7bi+N80Nt
X-Google-Smtp-Source: AGHT+IHQsfFe9LIIU1ujnavCZmAwL0R31Bsaw0Zh+cWaDPDDqIrdoQswxVtXfq3deH8/EgbbGU59Qg==
X-Received: by 2002:a05:600c:6b10:b0:43b:d531:ca94 with SMTP id 5b1f17b1804b1-43bd531cc69mr25654365e9.3.1741200540856;
        Wed, 05 Mar 2025 10:49:00 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-391253b3e23sm1928230f8f.76.2025.03.05.10.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:49:00 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 11/15] arm64: dts: allwinner: a523: add Avaota-A1 router
 support
Date: Wed, 05 Mar 2025 19:48:59 +0100
Message-ID: <2224762.Mh6RI2rZIc@jernej-laptop>
In-Reply-To: <20250304222309.29385-12-andre.przywara@arm.com>
References:
 <20250304222309.29385-1-andre.przywara@arm.com>
 <20250304222309.29385-12-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 4. marec 2025 ob 23:23:05 Srednjeevropski standardni =C4=8Das je=
 Andre Przywara napisal(a):
> The Avaota A1 router board is an Open Source hardware board, designed
> by YuzukiHD. Pine64 produces some boards and sells them. It uses the
> Allwinner A527 or T527 SoC, and comes with the following features:
>   - Eight ARM Cortex-A55 cores, Mali-G57 MC1 GPU
>   - 1GiB/2GiB/4GiB LPDDR4 DRAM
>   - AXP717 + AXP323 PMIC
>   - Raspberry-Pi-2 compatible GPIO header
>   - 1 USB 2.0 type A host port, 1 USB 3.0 type A host post
>   - 1 USB 2.0 type C port (OTG + serial debug)
>   - MicroSD slot
>   - eMMC between 16 and 128 GiB
>   - on-board 16MiB bootable SPI NOR flash
>   - two 1Gbps Ethernet ports (via RTL8211F PHYs)
>   - HDMI port
>   - DP port
>   - camera and LCD connectors
>   - 3.5mm headphone jack
>   - (yet) unsupported WiFi/BT chip
>   - 1.3" LC display, connected via SPI
>   - 12 V barrel plug for power supply
>=20
> Add the devicetree file describing the currently supported features.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



