Return-Path: <linux-kernel+bounces-562761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C2CA63286
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 21:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1E41893C2C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A2D19DF7A;
	Sat, 15 Mar 2025 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNBwm2Na"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D418FC8F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742071876; cv=none; b=Fap9Y4WGIfChreKDwdy3GPhoLNezXKdzmFBNgwdTyr50kPEfP+rGT33EBKc0SYozAvR1P2OYurziEWuf9Uraao7cg5XLMcAQzHyxbmWhLtXMqQJy+biQwQPui2xgOAOFyrGzrjjh1QVSyhxSYA4lshyaibLu5Y+QBAhs6rDO1A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742071876; c=relaxed/simple;
	bh=rJf0l7DScNLKlkN0N4Vc1obQdLaFIjFYlALSPdjoSt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpn1UUYXK8XZUja7uw/vsHHCEu0g2Ic29EdalJ9KWo92yX3TlXARwy9WuhJVOpwLzDTvAV6L9dW3AJzZELZ4l7YE2yweKTlxnhk7FjsL6xWVDg1LrcEYxXbSaoPGs5hL03vcP4CU4dP4aEGk3wPkGqVsjW1cEZPwDkTogt+mh1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNBwm2Na; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-225e3002dffso23244445ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742071874; x=1742676674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eOQV9UriWir+1uW8IbbnsFj+Wt+a9Lvs4iaFKUTxFLI=;
        b=VNBwm2NaLf/nWCjqNFNQJuyP1T3uO8WJBgasCE+6r5umuqCzL4mhnwF/5vmAXkpHhi
         bLEWtJmxJ9EsgSoxZkHAuKqAFTlLXW9yvQNAeaLfBSa/4YPNbVYHY8dy2WYXOpHorPZt
         ON2j7vDBX22VctAAMFBzgAm2/wVcWZ4WUEIKpba/kK/fnzAscqlznyD8jmR37/mxo3ov
         J7o/Si1IhWPDNPlXH/DLQB8opUQUZmtKzwaAuql6G8Q9+4jRDa22axs3RDAh7VPLfzib
         JTswZlXzBTIUDBJqMxs+apjXKPzgzHPjao4OMfzzTZVzJBPRpflrystN54C7BkV6aLrn
         WCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742071874; x=1742676674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOQV9UriWir+1uW8IbbnsFj+Wt+a9Lvs4iaFKUTxFLI=;
        b=Yd44E13Zr/9AJaL/69JQZ8i+AV0RQD+EBYfupFK1BhDtLyh1oGjLNkf0/jsPw3Edwp
         gWQzda5TtvJ38h2BpS/wYPD33ZoK8LJFjq4r1gNCCvP3SNb/RatJGNZu6GGIXIjx47Zz
         PRB/tWGM08NsCB844NP/S+yfcMRc1PKsBido5VrjLcSTXjOnzvLKiiN/ZEgjYQvJ9JVJ
         +oEz+1iW0PdvpvFfQJ+Aw2wNG6jc87J1MTOivTp+eYWMGvLzfDKxiLsusKkyek6KLAss
         24JF4Z3+0cWijLHgYRli6+fw92559EOidotXmBdodCVBuF1jlfHoSBhYK/kT7ABgd7bl
         cAng==
X-Forwarded-Encrypted: i=1; AJvYcCVaK4rfAv2jejpTtIf22ZIAoczQNaPMC4JP6xJCoRdLZS5U1bv3Fk/xv7kbRXv9OTc5j8cPomp2AnVcvu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTYhNVVTKVHd/6IMusUhif17ivIBEWe3Ns+ZZuPKg1k3PxYWVo
	0mwzjZbk0bgh8XysNdRv34MLhW8U6V3z8Jp1DhwOv9zR5yihFBNr
X-Gm-Gg: ASbGncvSklBQwd4gMEYlqDKUVqmLuOcLki4aOTua9KEGhB1WmLr56yuNZzrI4K0lvrk
	OYojpdZTRtiqTpxWGGsCupKUnNlpShuHHSKMklTA7iHnb6TfLlUOP8iBTLDbV+xFtigCKDzBiSb
	46CyeuqAhy4Auv9vjxeJsQTj1ww5i202dLTDyqCJychPpgRFTu/sopcIGObwGWCnsAA6waoEbEL
	cpfGEILiHb0Ojz1iaLY379zTsholhnHRlk9B1E4pQ1Sp0Up0l5lSzXMwvYBS+l5g9J8Jp5BAuWh
	aemfu0qkUvTBELkqnNtJxoI7LkCGmao6Cq9l0oxnxNK02sdkMQXGD4E=
X-Google-Smtp-Source: AGHT+IFVLYCoZq2pP9Vlw0LnPKrI3zK5MDYfruhyqs9zk9SjGpXA2MPhVVbp34HTKq/Km/vS3INVUA==
X-Received: by 2002:a17:903:2287:b0:223:62f5:fd44 with SMTP id d9443c01a7336-225e0aeeb6fmr90916475ad.40.1742071873809;
        Sat, 15 Mar 2025 13:51:13 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888461sm48416645ad.23.2025.03.15.13.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 13:51:13 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
	Sven Rademakers <sven.rademakers@gmail.com>,
	Joshua Riek <jjriek@verizon.net>,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Allow Turing RK1 cooling fan to spin down
Date: Sat, 15 Mar 2025 13:48:52 -0700
Message-ID: <20250315204852.1247992-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3588 thermal sensor driver only receives interrupts when a
higher-temperature threshold is crossed; it cannot notify when the
sensor cools back off. As a result, the driver must poll for temperature
changes to detect when the conditions for a thermal trip are no longer
met. However, it only does so if the DT enables polling.

Before this patch, the RK1 DT did not enable polling, causing the fan to
continue running at the speed corresponding to the highest temperature
reached.

Follow suit with similar RK3588 boards by setting a polling-delay of
1000ms, enabling the driver to detect when the sensor cools back off,
allowing the fan speed to decrease as appropriate.

Fixes: 7c8ec5e6b9d6 ("arm64: dts: rockchip: Enable automatic fan control on Turing RK1")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
index 6bc46734cc14..0270bffce195 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -214,6 +214,8 @@ rgmii_phy: ethernet-phy@1 {
 };
 
 &package_thermal {
+	polling-delay = <1000>;
+
 	trips {
 		package_active1: trip-active1 {
 			temperature = <45000>;
-- 
2.45.3


