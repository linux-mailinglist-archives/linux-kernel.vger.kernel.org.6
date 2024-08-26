Return-Path: <linux-kernel+bounces-301846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E4B95F668
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650451C220B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE453197A7E;
	Mon, 26 Aug 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AfR77R93"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F41946A8;
	Mon, 26 Aug 2024 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689385; cv=none; b=tRC797LODHcat8EMxvW0KogaTfYnymRvFT7z+bFtYKxLNQfZDkEr94vymlZNliAP/yMpegbv22tzcz5N0MoKoD/RS1c+uxgAf0Ua5uh1P+6DaxrsEONxaoJj+wrjMwodqfh8ZDwdM5z0y10Fn06O+hXMUHhBHdZtJr/1idDuPA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689385; c=relaxed/simple;
	bh=kXpVi4vJlLaVahPZZkjibwpjGco00IC9EqT5SrVYVwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCpX7/TJy/54a3XZbXxTC1LAbTEDyXyZEJzwaBfdJxAhVP6+CS0SMo4pd9tIV5Q+MgSV5MTWMAnKARKzXz+hDa0f9pmSpt90Mkt1Q00fhTwUmRjp+ENcTti6bPPYP0oqNp5lriqxpbR3uFoEdBU4v0SM40tDYNLm0srRb/m1YzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AfR77R93; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QGMskK114225;
	Mon, 26 Aug 2024 11:22:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724689374;
	bh=2nRV9hXUtzkjtQj/gKcsA0+AQasEZ91LFY0EEWDKbgI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=AfR77R93nquzFq8ETNDWBKYMwCsd3G+RRix+NrJdJuQ5zA7oZd5JjOiBVxkjZEn8O
	 i/mBHEpWqMhTWjWQLP+imgxlp2R7Btppv2HmVs1HwV1p40bF10jPXdT1OxSQYalVDy
	 Gmb3Y9HMBUCLmbXQ5lj3pNu/V3XZ6VsGfcqIDxqY=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QGMscn038533
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 11:22:54 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 11:22:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 11:22:54 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QGMrrB059185;
	Mon, 26 Aug 2024 11:22:53 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>
CC: <s-jain1@ti.com>, <r-donadkar@ti.com>, <devarsht@ti.com>,
        <praneeth@ti.com>
Subject: [PATCH 2/2] arm64: defconfig: Enable E5010 JPEG Encoder
Date: Mon, 26 Aug 2024 21:52:50 +0530
Message-ID: <20240826162250.380005-3-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240826162250.380005-1-devarsht@ti.com>
References: <20240826162250.380005-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This enables E5010 JPEG Encoder which is a stateful JPEG Encoder present in
TI's AM62A SoC [1] and supporting baseline encoding of semiplanar based
YUV420 and YUV422 raw video formats to JPEG encoding, with resolutions
supported from 64x64 to 8kx8k resolution.

Link: https://www.ti.com/lit/pdf/spruj16 [1]
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b9928342418f..067ba9d9406d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -823,6 +823,7 @@ CONFIG_VIDEO_CADENCE_CSI2RX=m
 CONFIG_VIDEO_MEDIATEK_JPEG=m
 CONFIG_VIDEO_MEDIATEK_VCODEC=m
 CONFIG_VIDEO_WAVE_VPU=m
+CONFIG_VIDEO_E5010_JPEG_ENC=m
 CONFIG_VIDEO_IMX7_CSI=m
 CONFIG_VIDEO_IMX_MIPI_CSIS=m
 CONFIG_VIDEO_IMX8_ISI=m
-- 
2.39.1


