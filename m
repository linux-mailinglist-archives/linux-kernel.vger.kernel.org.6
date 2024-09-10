Return-Path: <linux-kernel+bounces-323341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B26973BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C36828255F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A911A0AFE;
	Tue, 10 Sep 2024 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkfjqUH8"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A9199FDE;
	Tue, 10 Sep 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981780; cv=none; b=sFoir1S4AzWmWCBIVOSVC1hDJ2cJXSit6mv7VmDLNd3F8uIMs1Hl7uPMjb0Oh/f48MpmhBQaQymY3WO72uS2MaX871UtqS6xDHganfNfsd9tj1WMUGCm/uFxL5TylLAIdBSCN3fUUlFufyOvFioh5k+aL4otyVIbWUc5vY8PJu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981780; c=relaxed/simple;
	bh=QCNv+Ivh+r5cFkYNhMjifgcULHicF4W+VJSKk2jP/30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HKALi17kEbkoAXnAtrHmgviD9XqdwKU+cV7PwniVt3Q1vnE58ug291vJqtX9QBv1N2hqXDEWSaQ3YGGcoY9yElqIwVJ4jyQlvRxq+mTQ6WrC6FcJdbr3nutP0qjaRq7p35qP7020RvIjbeSJkT9bYtHuo3X5ZxNvI7oS03hFkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkfjqUH8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374c962e5adso3217742f8f.1;
        Tue, 10 Sep 2024 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725981777; x=1726586577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3luWvTJh/XF/9n4++BBfuuXH5dXLi+NDmtvvmGXKaNU=;
        b=nkfjqUH8twg4D0xVo8kON4g3Hw5eOWvDhOjaBPLP8MF5VFSfV7B4VUSCBwIaznxVty
         YQDkAhvYcRigZ53A4JG0J+faBipnkDa8WV72qcRzGl5xijKhLTcTSa32tzIaz9Ns4SQX
         rUcCCHEzFAXWeD+N0EU6uGU374S42ISC3TO/hMhgFZCtuhC1rGqjFnjZqdfo/YH48AUz
         Q210GhUo1EmW595UEDAZ8tXE3F1OmnewsKtPTRxkd2MYRjA8ilqZ3BCJUzguJyMn46je
         k4MUTZToJjVf3SI6NQqrvxHd7tSaYui69GLFX/EUjoSTRIvoUX6+tRhp6gvi+YKSYT4a
         ztIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981777; x=1726586577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3luWvTJh/XF/9n4++BBfuuXH5dXLi+NDmtvvmGXKaNU=;
        b=w0LR0aGuBbRmDNXVqNKZ8j3t82zz2KLjhNBTKfNvxEdmkV4wWsKOQ/Qqxq3el5JwwT
         p38l51sLkWqnDPgwHjIKq6lPVE1hju1OSwvMM5dUkMPRLGEsz85cKg4wfRZUt+ojb2tq
         cYaUUOW2FqP/G4i975lPoaYs7YDsQxPwIIvdfoUmPPXhzCHuEOdN65UsLsehyEeDPy/Z
         pysmUTdxVjHwk8YU6exstKMGW7g52nI1AtKThD8+GLl/MZV+UYI4QL/ykzlyGTDxC4HD
         7KWdLRk+xzbc8YVFnQpJrH1+/l+cesQ2L+mAVKq2nfeaRS1zlBX9Nxgua7Yrw9ZunRxm
         CdDA==
X-Forwarded-Encrypted: i=1; AJvYcCUz/w0RpsB+ONoBEBOcLfTMFkb7cEr5/33JA/TlcS7+hKMRyt4Q1Vngv+dLLuvCb4hVZS3deSvKUDW/@vger.kernel.org
X-Gm-Message-State: AOJu0YyvtUHTr6iFX//MUCA5rp1BTERHgci7z3AY6fk4JRBGLWSSKteS
	v80oTZadA66gNS/K7deWqaZACMnQWhjiH0Z0wKOSbqD6pw5WEvWBYnyFCgQN
X-Google-Smtp-Source: AGHT+IG98HAfB37x0b1vUt+J47mxLsvmOXeg/xNg0KJXFGspW0NVigKyYRNsD9gWlliA3hO1dCZSyQ==
X-Received: by 2002:a5d:5f87:0:b0:374:c400:8556 with SMTP id ffacd0b85a97d-378a8a1b6a6mr2726122f8f.11.1725981776283;
        Tue, 10 Sep 2024 08:22:56 -0700 (PDT)
Received: from emanuele-nb.int.toradex.com ([2001:b07:aac:705d:868b:2b2:ee81:5749])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d372dsm9239225f8f.73.2024.09.10.08.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 08:22:55 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1] arm64: dts: colibri-imx8x: Add ad7879_ts label to touchscreen controller
Date: Tue, 10 Sep 2024 17:22:12 +0200
Message-Id: <20240910152213.2072743-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

The device tree defines the touchscreen controller, but it cannot be
enabled because it lacks a reference label.
This commit adds a label to allow it to be referenced and enabled.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index edba5b582414..4ea47a576b1c 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -166,7 +166,7 @@ sgtl5000_a: audio-codec@a {
 	};
 
 	/* Touch controller */
-	touchscreen@2c {
+	ad7879_ts: touchscreen@2c {
 		compatible = "adi,ad7879-1";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ad7879_int>;
-- 
2.34.1


