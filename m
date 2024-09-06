Return-Path: <linux-kernel+bounces-318990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 420DC96F642
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CAC1F257E6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C7D1D1753;
	Fri,  6 Sep 2024 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="maSUKp4u"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71741CF7DC
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631523; cv=none; b=RcRNyPpOvWxRKcHwXRJXOTy+IlAWbmTWWjdS5eMJRAEiPYV9Jpl2Ygi1lozwhSwtVg5fqeZfej5D62EoKMDylszqvg5Gt+ClkD0i25H8UDKvheALLdxvRqqO1IgoK/nWd/AZP6Yy+LuSI6Sm3MfoSfYdwfvxdTV1cBplyhPuUMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631523; c=relaxed/simple;
	bh=1gxZd7jfXTJpSVtVW8NQ2hU7R1ZEPlzfguzkm9wMGhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzaUy4fyQecbIq20qANqGhovxk8Tjy27w6f/YdHYyMGwKVj9Sz/qrxKCarSo+SeKFoZn1woly96Cu39NdF31aG0FPuqiZM2Wpf0mfxqe/+YD5u3jl1qpcwPpOpbTY2X5IGvOZC9Y6zYSZAQhd44vLY+DIWA+/XNus45p7EIPIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=maSUKp4u; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a765f980dso15228366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725631520; x=1726236320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sTKA9799tNHggSqxU2/u6jwP6G56MM3BVuVl/Oq12g=;
        b=maSUKp4ucmACX+yQRIF2qwh2es+nh9k6uFVg6QlSfaO5/9MIU03/g8zJrIzqqw6E4x
         ii8q3qBJ8W0ULuZNOnZRLFRv7JobNGhS76cRHjTg4m8mgh2TsNKKg99sf0i9VSRwjjTD
         QjkZTkhO/wpPBafIXu10Xbf9jS7TfQtL+mczgl6slZQdulBdNUtcY5Es88Qp3/F2f7hc
         Fv5PBU0WJDsbxzkTMdO8e5XdURQcrW5qveShGtUalcdydR7s1AKVtYkAyOL9kGpIaE6p
         Asc4zqADqP8UJ8Lw9mmY3zMxA08y1VYUzEqs2PKGaIFEt7BRhhwdu0K587fgR1Eb6AJx
         O92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631520; x=1726236320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sTKA9799tNHggSqxU2/u6jwP6G56MM3BVuVl/Oq12g=;
        b=WMTOybLcPnOLn2kpLqr00IwElD8btd70djICo9MR5Q4FdSlGa+5eG3HWfAjE8POoc5
         xsIF/tEBF/dosb7YoRSvnyRQziSFeshTdSIyJQ7EyCHFFdQQy+1NFgaVn2D9I8TdpkIy
         yAG/bRErQfA4dM7lEh5i08aBU21egxPu8X+PP0COvVRN/nLrq0Ld/Y795KQEH6pjSur0
         p7MVCLguMxnJiY7/beS58nzeodLQruozn5uJkTequO6gvaFe6FAD355hysoMfXdgetKg
         Dlyaj5W0mvCF4Q/EAhXxYAkIztYEYuOiyCe74wiPgLoMwa3PXfxgPJU4PqT3aSULRrtt
         go3A==
X-Forwarded-Encrypted: i=1; AJvYcCVsIHWLgLm+AcgZ3ZMGxpvwD4l3BH1NFdFnldGHICQR6T4I4os6nZy5ZsgAW0D37BSEicFvBeK+aY0QDks=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb528FeoFU3b6GYkMLlJiDp3kbtZnLMleHsQIr3VAYMGJV7xjs
	3e5vU5iCp8xySlf3EaGbl+yTqBF+2YzqClJXubV5GvhH4KcYsy1FL7GdzV0NYoU=
X-Google-Smtp-Source: AGHT+IFKZwtHtV9PO6LP/3lo8dMOMciYzMRKwbxAmyvhPemXsrkNEfo4BYYP6vzoUfeFVdSPS1fmxQ==
X-Received: by 2002:a17:907:25c9:b0:a86:9e3f:fdc8 with SMTP id a640c23a62f3a-a8a885fb901mr127136166b.4.1725631519392;
        Fri, 06 Sep 2024 07:05:19 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a7e223498sm162319666b.196.2024.09.06.07.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:05:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/2] ARM: dts: minor improvements for v6.12
Date: Fri,  6 Sep 2024 16:05:12 +0200
Message-ID: <20240906140513.71307-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240906140513.71307-1-krzysztof.kozlowski@linaro.org>
References: <20240906140513.71307-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-cleanup-6.12

for you to fetch changes up to c7b44ed960ddecb3604d1e273494a932f00f384b:

  ARM: dts: nuvoton: wpcm450: align LED and GPIO keys node name with bindings (2024-08-12 12:07:04 +0200)

----------------------------------------------------------------
Minor improvements in ARM DTS for v6.12

1. Realview: correct unit addresses (e.g. drop when not valid).
2. Nuvoton: correct node name to match bindings.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: dts: nuvoton: wpcm450: align LED and GPIO keys node name with bindings

Rob Herring (Arm) (1):
      arm: dts: realview: Add/drop missing/spurious unit-addreses

 arch/arm/boot/dts/arm/arm-realview-eb-mp.dtsi                       | 2 +-
 arch/arm/boot/dts/arm/arm-realview-pb11mp.dts                       | 2 +-
 arch/arm/boot/dts/arm/arm-realview-pba8.dts                         | 2 +-
 arch/arm/boot/dts/arm/arm-realview-pbx-a9.dts                       | 2 +-
 arch/arm/boot/dts/nuvoton/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

