Return-Path: <linux-kernel+bounces-383660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8369E9B1ED5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197B5B22139
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D5D188006;
	Sun, 27 Oct 2024 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI5LFX5n"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B40118454E;
	Sun, 27 Oct 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039833; cv=none; b=R+xiBF3tVf5sEdPvT9CCsffrp9wXX0qdVVUrs056T4yZGENpifZCIyySCi2a+1285bS3A0WridXVI9Cpo8HxgvyOhfhHlKS14vSF0i5MRioODWn1b2A93vGTP4CiwCgDHIIBPmk/yB0dVEpV2CauMoNiJR5IJYm35IYPDb/SbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039833; c=relaxed/simple;
	bh=GRIprTk55YoxyAtAqBSmeVlFwn+FJRp9HdXHznTSR8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WEfCGH8YCb7UFb22IcHNVVf5z1PPvlpmkf0YCj4N92i2/huXRdzjVa+ThmONYHxbTZfjOSuIuZMGtpogqQIoOYp+a5i/Z2f2m58mMlZFjQSUD1JboPAYdNIoH2xGEYNylh9jcVk8Lebz56Duw8ldBBjHkfj0KYHsFlemcRcMikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI5LFX5n; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a139be16dso60552466b.3;
        Sun, 27 Oct 2024 07:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039830; x=1730644630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vySvn0PrZ5KmWWRcUjB0f7ffbO3G5ojONpptbAIcwaU=;
        b=kI5LFX5nrR/utQGl7IKTN6qzeG4/rqE16+rTVa5apZswBLBTDLujyqsvnqmiU4qhG9
         5yzlAEor000FIrQ/4WlA+Bi2f8UYJHtXQbwPLhXBcfvNcVziUadgozSFcH/077WqgDkw
         Q944eyhO3D+OgfuQB6Ye9AaDQx1LU8tZvnSQPqrG6bwjD8TQlUbn8chO9QblzHR9KTQH
         pUAk3UYjNdhfq7Ug067ieySFrl+jYRCWQid7+22z35EqVDfMbanuPKMkeC1phmgWWevx
         diXpFbBli9ooGB502FTOfzkT0bIzDqmfN6n5aUPUON8ywQFaLAdsNNvxMPKdjEKcPmh0
         Mlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039830; x=1730644630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vySvn0PrZ5KmWWRcUjB0f7ffbO3G5ojONpptbAIcwaU=;
        b=Z5WxsROoBtMH6E9Sahi0tHYfNL/vohqg41tLHHTRigYu41rvlx8jCAFZ4xEQGnLiSg
         CG1fW4SZZR+c2FCtL/z+RPQTxZOW5VigyqTuXQuyduSPqLwQaRJG81H9hv83XMc5TTDZ
         xyJzrrqY29emXvmTJCsYNE77D+bKgjLOPqRBzlkzdZGqfol50dGkSE3gA59s+cEyJQT1
         7i8hAuT4iBMeDcdovFxll6adYJUxtxENzXpov1J64Fjnh6qTMfNtIM7gAUXFOQDIpEZw
         I/9kJqksqxyecpNjQFRnGwUELdU4zqb1N1Jeoo8QPiXc7cdqgJfFT023a3t1Oi7R5s7g
         UI0g==
X-Forwarded-Encrypted: i=1; AJvYcCW1I/eTU3FtqqF3hcm5B2+yxqDpnYKDA9QwfUipdQLohH9rJBw1XljS4B8OxDMDxuilHBibcN7iS5VfbSzi@vger.kernel.org, AJvYcCWWJjQ6iCG4lzESUIdV4sEb7TD5S6aRCUndE6yOFGnYaV2LPWduTgNP6jB6nyUD62xPiZftJlD8vTc6@vger.kernel.org
X-Gm-Message-State: AOJu0YwBT0/mzUVZkDUOzD7bdfBdq4cjlIP4/ONKjYKnRp91iPcJgHo4
	hm4c5FEDPzn5EZVRBNxgglRb0ot4Pcx+xUsFS+6WuHFa+MXqE6zC
X-Google-Smtp-Source: AGHT+IFAXiONUp26yPFBIGRc7AqsUWO14Tji/EirrGd9LrhYWQZ2CsNCNbqO9lsi2MZlqdRDu6d/5w==
X-Received: by 2002:a17:907:7f1b:b0:a9a:762a:e5b with SMTP id a640c23a62f3a-a9de61abe21mr188707966b.13.1730039829537;
        Sun, 27 Oct 2024 07:37:09 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:09 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 10/22] ARM: dts: socfpga: remove arria10 reset-names
Date: Sun, 27 Oct 2024 14:36:42 +0000
Message-Id: <20241027143654.28474-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241027143654.28474-1-l.rubusch@gmail.com>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the reset-names since the binding does not mention them, and they
seem not to be used in arria10 (similarily to agilex).

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 6a2ecc7ed..005c57843 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -818,7 +818,6 @@ timer0: timer0@ffc02700 {
 			clocks = <&l4_sp_clk>;
 			clock-names = "timer";
 			resets = <&rst SPTIMER0_RESET>;
-			reset-names = "timer";
 		};
 
 		timer1: timer1@ffc02800 {
@@ -828,7 +827,6 @@ timer1: timer1@ffc02800 {
 			clocks = <&l4_sp_clk>;
 			clock-names = "timer";
 			resets = <&rst SPTIMER1_RESET>;
-			reset-names = "timer";
 		};
 
 		timer2: timer2@ffd00000 {
@@ -838,7 +836,6 @@ timer2: timer2@ffd00000 {
 			clocks = <&l4_sys_free_clk>;
 			clock-names = "timer";
 			resets = <&rst L4SYSTIMER0_RESET>;
-			reset-names = "timer";
 		};
 
 		timer3: timer3@ffd00100 {
@@ -848,7 +845,6 @@ timer3: timer3@ffd00100 {
 			clocks = <&l4_sys_free_clk>;
 			clock-names = "timer";
 			resets = <&rst L4SYSTIMER1_RESET>;
-			reset-names = "timer";
 		};
 
 		uart0: serial@ffc02000 {
-- 
2.25.1


