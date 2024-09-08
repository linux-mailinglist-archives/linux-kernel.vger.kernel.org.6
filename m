Return-Path: <linux-kernel+bounces-320429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B35970A30
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 23:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA16B20FD9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEB817AE19;
	Sun,  8 Sep 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6Py0j2I"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579917A590
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725832082; cv=none; b=Llk+aK0YT2NCHjt0lzlbwTGFMN27/twMOcc0SWksAVlfk8JSQIx8c0zW6zJ5fh/Z/N/RDbNiCRdg/mUFLAz4pbaE4GRmoYwAlbMM9mRyeRw/YrWafrmsy+IiDm/Jcs2InlFBM+nhQROrlYgoFrjAz4m7qwNrKzHuPLyCITBDWBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725832082; c=relaxed/simple;
	bh=enP55UdvGXp5F5o/Qt/iN8GCJ3XoOR4JNPqAB/35NGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGcCQlF8PNlX6x2TKGmfJyghSVUQZl/RoidfjltFySgmGKnNPMWF3qVZQpvN2pgfmvjm+4DmPL3zNEJmA/9tYpPA1dJAK+mauMLM+Fryo7G9HIzxmatHHUPvJWVdX0G7KSwviCSMeChAilDhZ1/AkdV7J8qgoOHWgXwV4XvJpuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6Py0j2I; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f763e9e759so7552911fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725832079; x=1726436879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3h/dy8U8KeKo9pl0s6GpX+Ff1bmWBiKnyAT/bdQlUo=;
        b=F6Py0j2IEXEYvGrIgWq+5gsY3OO5lEMwIFfJZ5QUrzeelZ+BerM61DEdqdHhW711F0
         278vVZJmDArPOsUOzL2GH8x163cjWT9JvFbhd+fTK1GKtmgRZ5wS4nzR+7jJ9WZXIfFB
         wn7C8Y1FSzjFva3LQEA0NFDQAHF3Xh5INDQeMaB/ZTstGf5GwGEAzmoXcAJEkH9ktBS7
         PzvscHEc3NvTqnKejyKRabFVO96BzLg92dDGMrnJ4aBPJht+f+r1ueXklPFsOcZLdW4Y
         RRmR1Z+wWgxvzY0NN/Tp7BMbMhNKrNwpZYkb364ePaJGG+CKkIoZvBFMjOW0tjLbDizU
         /J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725832079; x=1726436879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3h/dy8U8KeKo9pl0s6GpX+Ff1bmWBiKnyAT/bdQlUo=;
        b=of253IoBTuEUomOxXunVGvSRjGQZqzyZVweNIlRUFp73aDJ5ZvLOnT+BWcfbpZSQ86
         kaQABvZyoys9H9qsq+Mvv+IXbp4JzaHpzlLfmSwDj9fEBo6LZYwmpo7aa+XneYHjna+T
         x3s7qot7uj72CjIjjAWFk50vKDs2J5aZ08vlCqs/t81CtXLRf4jYImv0gcorLd27cpHy
         QX6Cu1HRNUJTPtCf0M+73a60rmW9JhASb37JWCYIMz4qm9oQEFMwIXsZwCxzr+rcsMl8
         4sfriN2gwoHvPvOPEIOX5o50mDNvKJ+Qkr854smsSZVGPqgNpmYXGZLWu9O1qyMN5jKn
         FlOA==
X-Forwarded-Encrypted: i=1; AJvYcCUN8UYGFjzkUw2VPS9xVQpIlW6gmf+2Xxll0E+DdVjo8DsEmADb9VrIRIPWb314fTpPEWkowQ3eZPHRC7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKl16AlsppWcn5tE12f+Mi7X/tblt/z1nmrbdF/11zpIqp0M8
	VKe8Y/NbZgYvtGwgPpj/eanRAwLeaOJMZELcKEhU1SAB/kAid2hX
X-Google-Smtp-Source: AGHT+IGrW/26G4fqJ55LEXa+E3HPJe1Oq8TWJKGljblgXwZFH5PCcrjxnSDxIUyY7RjRWG/956715A==
X-Received: by 2002:a2e:a58e:0:b0:2f3:d82b:1959 with SMTP id 38308e7fff4ca-2f751f00b02mr77757571fa.23.1725832078203;
        Sun, 08 Sep 2024 14:47:58 -0700 (PDT)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c009a5dsm6094001fa.72.2024.09.08.14.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 14:47:57 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Shoji Keita <awaittrot@shjk.jp>,
	Icenowy Zheng <icenowy@aosc.io>,
	Andre Przywara <andre.przywara@arm.com>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH 1/2] arm64: dts: sun50i-a64-pinephone: Add AF8133J to PinePhone
Date: Mon,  9 Sep 2024 00:47:17 +0300
Message-ID: <20240908214718.36316-2-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240908214718.36316-1-andrej.skvortzov@gmail.com>
References: <20240908214718.36316-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Icenowy Zheng <icenowy@aosc.io>

New batches of PinePhones switched the magnetometer to AF8133J from
LIS3MDL because lack of ST components.

Both chips use the same PB1 pin, but in different modes.
LIS3MDL uses it as an gpio input to handle interrupt.
AF8133J uses it as an gpio output as a reset signal.

It wasn't possible at runtime to enable both device tree nodes and
detect supported sensor at probe time, because both drivers try to
acquire the same gpio in different modes.

Device tree fixup will be done in firmware without introducing new board
revision and new dts.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Link: https://patchwork.ozlabs.org/project/uboot/patch/20240211092824.395155-1-andrej.skvortzov@gmail.com/

---
 .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 6eab61a12cd8f..66fbb35a7fae9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -188,6 +188,18 @@ touchscreen@5d {
 &i2c1 {
 	status = "okay";
 
+	/* Alternative magnetometer */
+	af8133j: magnetometer@1c {
+		compatible = "voltafield,af8133j";
+		reg = <0x1c>;
+		reset-gpios = <&pio 1 1 GPIO_ACTIVE_LOW>;
+		avdd-supply = <&reg_dldo1>;
+		dvdd-supply = <&reg_dldo1>;
+
+		/* status will be fixed up in firmware */
+		status = "disabled";
+	};
+
 	/* Magnetometer */
 	lis3mdl: magnetometer@1e {
 		compatible = "st,lis3mdl-magn";
-- 
2.45.2


