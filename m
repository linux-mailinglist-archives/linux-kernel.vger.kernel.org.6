Return-Path: <linux-kernel+bounces-547517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE4CA50A57
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F54F166F2F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4B61DD9AC;
	Wed,  5 Mar 2025 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsb+J33h"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05179253B6C;
	Wed,  5 Mar 2025 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200774; cv=none; b=o8T6h29wlZHL6Rb0QuhCb75A4EziyZAQklmOR1Kk0uhcMjQa6jlibM1vFpI5PZPpdqKpIZqKd7BESIHCLj/mRjUZAdN/pgRfdp8+2ECDvTFMh3JJ1Zn13z5v+YbZNb1cw6g/zMdQDtgu39yvc3wkfRj0uuVZebGxVxYQ/dESP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200774; c=relaxed/simple;
	bh=axHI+Ss0adljEBF8slC3n/3koLG2QkpC1C+hFdPLV/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A80AS7P9ddRiyrofpuAjZeGm0Fh+gOG3wOp0SEmQPy2zw0s5DNXsF9NOvB9sqABKAjal+04UsxcpSPTZj2elNmmNzTofYMBOtS0H5KUQan1GMo88gndJiaFc6XOVjxnii9yRwIfIBJX47mdYTKbi9DccMmlKzposd7jiyrEDEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsb+J33h; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bc0b8520cso24670395e9.1;
        Wed, 05 Mar 2025 10:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741200771; x=1741805571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCk8RqcIdhP8uF9ql+DEh+iIumM5FUYrLBf68Hu79HM=;
        b=fsb+J33hcYUni6D9uma3BE8r/dChRZ1Kx5SHNYLL2idUE+VqjJLp38jetTmNhGDHkq
         rFPqrbA0IrUmv6f7wSoIZtghlWZr8Tfgytl765gOzFtxyuWvwjK7NzLoFR1IT3066cnN
         jd+6v5NuUelmAoD/716O8ZyT7xK+OhgR97McLy1EOKUoYtwo6gkkq9fKo1AmctHFKiV8
         egWCvm/lmLTlmevmx+kWiv4H23rfgbV4dQre1FidHTjusjmDrBQ0CIzaGjp504D3tczX
         EcdgVSbBrRnXUa3XEbzKBExkQcARo0fHIcc/ljXPmOC/gRIGviT0sdGZfU/TRUVsI7hD
         4myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741200771; x=1741805571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCk8RqcIdhP8uF9ql+DEh+iIumM5FUYrLBf68Hu79HM=;
        b=TWkSwLm00xoS3c1VqpvjoemEam8UouUxYRL9v7XUadlmybQc3aRNzNTMJvEPX+LCkn
         wxNHK4U2npXwe8mbNKEAugcSdapdw1AXVZcy7WEDWvOuxvaDxj3NawhzTaGXsQXrPStp
         Fvvrv5XeNg2+kFlyMQMuD72sIG3AI+w3MX7qyqFdDaJvGWOkbgzu5REk7CnmZOAseS4v
         N8JrWboxr31xzwBXqGXVOyKQCsZT9N/Hnh0AJNHPRx/oX1KH3eT/Wu1MXkHDysVrpvJm
         Q57x58BYcPjnSVixQ6HVmU0Y4sS/KTD0/SEkHY9oyvyjyJO0pH0r9YvSihoHuvUTXGyg
         uNMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1qYnY12+OWwnbWr0ZsDky9gt32wIQPqYUrt4m8144JOauStG6qK4kkVLMK/nMToc3ET4k8hctZiDQW2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXVPFwkPZFW93G98Se0aVinHiIygpufI2xLIvGbX9kBf62uDx6
	t1fdtpBXlm4ji6nYOleUx0h8YT/ia4qUyy364EGlxWvFL8rUXh1K
X-Gm-Gg: ASbGnctm4ZoIs24C4RGh7gFRAB28zbb8stvzBPGnFML0OVNrUaaHRo2B5TBchkanKY8
	vQKZE3uGZW7Pn1zgQx27HUAuhIA/H5uWMSxZh5qDx/gswpl0vFMcpEOqZvQAod/Pm8Um3Eu5AbB
	dWd0Oxbyavxsmy6OCSla1hGesFzmK9z3X/+shypCS22aVkI1iMJBHQ5P91XQ3CnxOwxt1VL/FYk
	b3ZKNzjAO3WbJHzjkpr2alPyhfj0TP6jSmRQ+PvE3RS54PSgd68wFJrWHENCVtq3IMMtBzeeAZm
	72YFJyUzX073FKHqooFqjjWrk7K2i1yuV/Yf9YbJJNw7aaixDaLhno+36vZILR0h+l7ik3BSea7
	eUXuKvz/ohE0Kum1i5I8o
X-Google-Smtp-Source: AGHT+IGuBKbnktunZBzzNzT71sHvzIIvBdO54em+1pB/n3NbwE4YkF3yitXy4CaCKxQdjWZt3gt1lg==
X-Received: by 2002:a05:6000:144c:b0:38f:4d40:358 with SMTP id ffacd0b85a97d-3911f726343mr3775397f8f.9.1741200771124;
        Wed, 05 Mar 2025 10:52:51 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796084sm22209780f8f.19.2025.03.05.10.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:52:50 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 13/15] arm64: dts: allwinner: a523: add Radxa A5E support
Date: Wed, 05 Mar 2025 19:52:49 +0100
Message-ID: <1888259.atdPhlSkOF@jernej-laptop>
In-Reply-To: <20250304222309.29385-14-andre.przywara@arm.com>
References:
 <20250304222309.29385-1-andre.przywara@arm.com>
 <20250304222309.29385-14-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 4. marec 2025 ob 23:23:07 Srednjeevropski standardni =C4=8Das je=
 Andre Przywara napisal(a):
> The Radxa A5E is a development board using the Allwinner A527 SoC, which
> is using the same die as the A523 SoC, just exposing the pins of more
> peripherals (like HDMI or the 2nd MAC). The board features:
>=20
>   - Allwinner A527/T527 SoC: 8 ARM Cortex-A55 cores, Mali-G57 MC1 GPU
>   - 1GiB/2GiB/4GiB LPDDR4 DRAM
>   - AXP717 + AXP323 PMICs
>   - Raspberry-Pi-2 compatible 40pin GPIO header
>   - 1 USB 2.0 type C port (OTG), also power supply
>   - 1 USB 3.0 type A host port (multiplexed with M.2 slot)
>   - 1 M.2 M-key 2230 slot, with 1 PCIe2.1 lane connected (multiplexed
>     with USB 3.0 port)
>   - MicroSD slot
>   - optional eMMC, 8, 16 or 32GB available
>   - optional on-board 16MiB bootable SPI NOR flash
>   - two 1Gbps Ethernet ports (via MAXIO MAE0621A PHYs)
>   - PoE header for optional supply circuit on one Ethernet port
>   - WiFi 802.11 a/b/g/n/ac/ax (LB-Link BL-M8800DS2 module using AIC8800)
>   - HDMI port
>   - camera and LCD connectors
>   - power supply via USB-C connector (but no PD) or GPIO header pins
>=20
> This .dts describes the devices as far as we support them at the moment.
> The PMIC rails have been assigned as per the schematics.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



