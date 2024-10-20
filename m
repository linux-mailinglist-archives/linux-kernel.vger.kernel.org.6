Return-Path: <linux-kernel+bounces-373400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1B29A564A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAFF5B25B20
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945FD198830;
	Sun, 20 Oct 2024 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIXPcXb6"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07388199FB4;
	Sun, 20 Oct 2024 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453250; cv=none; b=roNpOwaGTCYbameFj33QjAPwCsrKdMsxCpJ6cXYZBaiOT+DRwtNuKSM0hBQpQSCh5ifK/6Tcj7BMPEfYgo/9sPlax1udwdrbiDRGVQSiQJ5HZZdoIlOnoxtetS7umzja+wAu5twrJmbbIT7gni3GXUgqKuwfZDmrOgbugNZ1heU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453250; c=relaxed/simple;
	bh=GRIprTk55YoxyAtAqBSmeVlFwn+FJRp9HdXHznTSR8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aM7MYascx1yUufmnkna5xzZW9sECVQZrtdVG+lIosfMfp87yi2upa2wZlmgQ7zXRNBPU8Qs9Wm05RQ0Ex8p8iy+sKACj5SsEFuYl4vv6wlCrc/m2OcQFFLhQK5R5VKOAvHSDMRR33aefyPeOyza5VDtc+oWnqnHCYdTvayvlbk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIXPcXb6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ca0a1fc1aeso437355a12.2;
        Sun, 20 Oct 2024 12:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453246; x=1730058046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vySvn0PrZ5KmWWRcUjB0f7ffbO3G5ojONpptbAIcwaU=;
        b=JIXPcXb6vjx5l9UfSZIuM0iprnXU15ckb3+uEQxXbtTH4/mEzYWVR+mTQLp8lw50+t
         xmkF5sbp9IB/89Eu36SSUPgNumzNIfe22+RV/MZYbFk4rLcFSknY3RqI84j4yE26O/HO
         qXUyKpY4DKqAiIIE2Qo23LX52sDzOGZhJIcTUkZMyg7vpF2Zotpo7kw87+xn771bfDQ5
         Nkj0Oe7mB1b11tyNUl2EJNqVXWND1Nr0/4FJFNajQqrJq26DSBaVt/ZL0phNvBduANCl
         q71ttZ1o5Q7XfN0lPxa88lEU7FLe0ngtvm9tETzP3BxBo/L+BCsrqLn2QF87rW7wsuPU
         RqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453246; x=1730058046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vySvn0PrZ5KmWWRcUjB0f7ffbO3G5ojONpptbAIcwaU=;
        b=riW1lVjfGrF59QXgFBVaQ9ZRZVrSW+HqwY1n0a7nMJW4yuNII9mp7WegYEmO1Sp2FL
         74ZjrN3lZ7N+1CmiZnWMWGTbFaOae69pjXKZJJ+OK2GGseDQ2UdB0GToY5vTfMgoiXY6
         IFCmdmKjAtWa9kpkjh7W35mPWHyxPt1v/zBug3GpKuSaUZUlAzdp4s06Vp3QDVTDmaQ9
         QrcMVit9b+K+Ue13+UMW1Owl3fsA8AqTWtQSGJ6VQfw/l/LSXb6+f50PSnx+Kc2zwdC1
         gKCFzKWOVyk75vA7eBZtaWApqC4QGTfG+keTjFLJcKrfTw7UM9x3EziA8fpfUVxovmnh
         AUgg==
X-Forwarded-Encrypted: i=1; AJvYcCVfpHT/R9CR0RVaMomIM46WewjrP1Li0mlFxOJHMsb/kCDtzRQMB8yBZknygLwoPGWP0wrbqHWzzJDxTxuk@vger.kernel.org, AJvYcCVyUzdZSaZvDZJ9rMN111PVRO7i5Sj28T4F8yJ6dGXR+FTvy2EAkouSRSw4Qc3XnBCtLDVTgmuI6lTp@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTUonsS03F1xWPLjCs1QVurYS/rZJIvMA1ngWWCv74I/sEgXP
	YyDhRq8vsX19tzQIjubgdyvxlUldvXehHpMl39Ly/5iwlEhDXqbS
X-Google-Smtp-Source: AGHT+IEfscwM9JQL3H60yPkVgWVilalHL4+zNcKDM3YY77l5JS1uaBflsxUbryv8FkPvJ5oCEQK7dA==
X-Received: by 2002:a17:907:3d88:b0:a9a:3999:23e9 with SMTP id a640c23a62f3a-a9a69a7668dmr371353866b.6.1729453246148;
        Sun, 20 Oct 2024 12:40:46 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:45 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de
Cc: l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 10/23] ARM: dts: socfpga: remove arria10 reset-names
Date: Sun, 20 Oct 2024 19:40:15 +0000
Message-Id: <20241020194028.2272371-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241020194028.2272371-1-l.rubusch@gmail.com>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
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


