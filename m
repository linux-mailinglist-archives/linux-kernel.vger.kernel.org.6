Return-Path: <linux-kernel+bounces-228722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78335916603
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA4C281270
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848A814A604;
	Tue, 25 Jun 2024 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dCwmKPgp"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6134C1465B4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719314372; cv=none; b=YUHg5WToap5P7cUimjxJtHMU834qDh1fcx+Ybf+3uuBTklctLP259NCtJzw8d3d+0/uD49D65pmeVNQob35Ckbpef04A01O3Fo/q8yy4g0DGTkylBsRUEqRRtsu5/Y3XPc3PQYPAg+CIf41Q4zOvFBTHCW2/jN68KgwU0ZRshCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719314372; c=relaxed/simple;
	bh=CDpmOqCWIRbeJ9b9NDvzccvmHkf6wYuoSpWeEPBE9D0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKdklxp8sk1dlqvUk1N1LZENcg9ujBo9GQi67UznGen8Q8lflx4e3/HflrHlM+rJiKDxA/42TzVUUEzNeBBcqtMIP6/gMa/7FGKWSizfLPNzQSI56NR2UBpgzH03DpJsfrv4AAz2AGdjn8xXl84o1+ogm/Ua8hKYG9hv60kl9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dCwmKPgp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-363bbd51050so4269430f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719314369; x=1719919169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xo/YdeJtYas2lqY2ggRIqkSo6l044/lTXCgw0Xo9+1Y=;
        b=dCwmKPgpZxTmlZvcfJuw0fXB5JFcb5eIR5648CU/nBeBoDKe8Ebpcqj5Td96eYDv0q
         u80rt1ypzIVnaLs+ma4xZB930xF+z+NKCQNMKrrXd5vOE0dBoANb8GGhYHmL1bgKzEte
         HZUrmkntXqkOCM3U4nyeTgbAl43iSpF9fvdN/06YtRjLPod5fqE4VY4BcRoLm0ysNt0W
         ExLCFBMT0CgB5nxmqBrxfsLnO+mucXhNwBsmBwryrtfAmPbnNgzxQhUB0BHgJo3CZDWt
         JOLfFG7eeGHaFzlr+8/8Ru5dpMawvMuxFiHdctuyvfJRdQmx1+Ajl0p5JoXOOEMCbBCl
         Qzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719314369; x=1719919169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xo/YdeJtYas2lqY2ggRIqkSo6l044/lTXCgw0Xo9+1Y=;
        b=HgFmoFpBMYYHIkPh7Ii9Y/F4THjev7PyXgSzkO0PFfEfHv391yiR/VeRDPUOOo+0x1
         gBOBdNFpm0+63yfrXL8JQFuO2vggt1ppKoUAi41OSMh66gvNTP+ZrgDQuZTrfNoN2GAS
         UZiE0tHSkNDtUADeUpihXVvZul9Dztp55rb2QyGYw0b/+nV08wDasg6/PukFfi0/ksna
         MLATkv8/4Z0F/gIDJtybL4MlG34PcPcQg0cj4vK55Jcv12ZQ2W+J9sjTQ11Ove4hgwOK
         A/xyVQkkXjg+5pVy0nJVrwbOO2Wtz3abfxZU1ucLKvQk6ueyc60mDttMfkKXea9iD0PP
         IaOA==
X-Forwarded-Encrypted: i=1; AJvYcCUhQ2mgUoDPcCME9aermgtl4p/L4Fz7zhARD6Rh++R3c5jnrqZ8NyvU4Jy4oXEGDEXqvloKpr9xI6EpELnEPCtcg4CLMRpORpfVmyRS
X-Gm-Message-State: AOJu0YxhC0tewgx90FVcqpYHjn7weCWid3v/CUtSf9cDGIPQRW4H/lfp
	s0B/GFjKk4IuyGPzylp2vS1vAhzIvD5TIMVSz4QxEQgkc3o/M6O+s34/UcWLOys=
X-Google-Smtp-Source: AGHT+IHia/dXcMfF56czcOAxmNTQqh1jTWwgjJHeOv+ujGlppvG6UAN+tlaLOohOVx9yKWBwzhmzOQ==
X-Received: by 2002:a5d:610c:0:b0:35f:261a:dd8f with SMTP id ffacd0b85a97d-366e4ed2eaamr5110021f8f.20.1719314368678;
        Tue, 25 Jun 2024 04:19:28 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1b57:b4a1:3d50:32a2])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-366383f6717sm12807366f8f.9.2024.06.25.04.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 04:19:28 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH] arm64: dts: amlogic: sm1: fix spdif compatibles
Date: Tue, 25 Jun 2024 13:18:43 +0200
Message-ID: <20240625111845.928192-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

The spdif input and output of g12 and sm1 are compatible but
sm1 should use the related compatible since it exists.

Fixes: 86f2159468d5 ("arm64: dts: meson-sm1: add spdifin and pdifout nodes")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index d13cf5b4aac7..75c8aa815eff 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -335,7 +335,7 @@ tdmin_lb: audio-controller@3c0 {
 		};
 
 		spdifin: audio-controller@400 {
-			compatible = "amlogic,g12a-spdifin",
+			compatible = "amlogic,sm1-spdifin",
 				     "amlogic,axg-spdifin";
 			reg = <0x0 0x400 0x0 0x30>;
 			#sound-dai-cells = <0>;
@@ -349,7 +349,7 @@ spdifin: audio-controller@400 {
 		};
 
 		spdifout_a: audio-controller@480 {
-			compatible = "amlogic,g12a-spdifout",
+			compatible = "amlogic,sm1-spdifout",
 				     "amlogic,axg-spdifout";
 			reg = <0x0 0x480 0x0 0x50>;
 			#sound-dai-cells = <0>;
-- 
2.43.0


