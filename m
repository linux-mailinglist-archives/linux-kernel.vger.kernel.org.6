Return-Path: <linux-kernel+bounces-214167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B5490806F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B742840C1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843AB2107;
	Fri, 14 Jun 2024 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNnFKUo8"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EAE63B;
	Fri, 14 Jun 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326830; cv=none; b=W9Nyc79JS3/ZpGHrYiejls7Xj8tDRRR7HWCzxfzkVzd+fQmzgbk92FYJfvjpUivk+ov019GRbfVdCcO7cFLS391bvclWissjYyC7iHFPtcwENe7nUs6Ei+p6AfgKbVGn1kVcWP5vqUS0cOyMS2bbZLB8lC2abPA54Kfwve5XN/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326830; c=relaxed/simple;
	bh=OTjfdaI3mzdJoO6T9GPFqggV9leFgeSDVMyEj4fWHmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQTlx5m+eFvoql5sQD4P0TLwiy/H4vuGJrRoVNyBdCTAT0iSnV47wzkXhC0Y/7sZl1Rtm9kQHJ3rH+ZKNK+ro4i5a5ucQluEa4riE4qWroopEKlLvN20wja08h0o8HkfFtfw0/PSQGZ98LJhLxlOwJJKI9Wr1mOOdIINJ9Z9wFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNnFKUo8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c1def9b4b3so1399031a91.0;
        Thu, 13 Jun 2024 18:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718326829; x=1718931629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJ/24nuKALS4YtDWZus9hHlQ95GOpA8SCv27LW+/XNs=;
        b=BNnFKUo8xQPokbNUqv5X/ZLMr9bnFd/n8ub9Z6Zdl8olI3UwUXlm7tKbuOVsf6sWmQ
         cE70JWjcZ8lcWTldltD9p418BKxW3Ch0kDDA5qF/5X/Ev8bz3R4ZdyA8UfT8T8Dp1DTW
         XMwVYeagvn/RGdy9jIRc0na36KXFjBt9WAxqe9Yl8vsSXaiax4Whm4VdwWcOw4FuCq4x
         mYP1IF487IviMzh+D/5e0auRvmJ8vVMhz1IAl69x26UUs3Vr58B+suVkynC6w2JRAmy7
         Ga+9eh1V3zpSxM4OcQ5jDTVFPKW4WNcg47H9yIYNjZv0IcPu/f7nTRoKDnZDyEFrgx0I
         s8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718326829; x=1718931629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJ/24nuKALS4YtDWZus9hHlQ95GOpA8SCv27LW+/XNs=;
        b=nlzOFEhhkqvmxPDSOfMspEQJ6a3oMvOgyH44qkf3bK4zSpyDS5dzCp2Tpv1ZWp67+X
         OJaR7l5UWw2BWUcCxuPCNgm6b32EypHhRyE5PH0H9BCzesEEEP6pOwwyq2Pa7SEl6gAj
         7wrdDAkEuqLbMQllG/vCGboZ7I8/5fndNGiecKF0LZBsS4lfEFBOMIEc2p/6TtPSzmNO
         GwKHtnof0Lsx3C2z78Aiyo06clx8KjdVQXjdHCA1j2IUhppvIf/y8t3aq1cl6LKKBEK+
         EvCXww1sA9Fx0iSknw3ypxEkCLHtaV4IXD86rzoIa0zfCMNyQJmALFEdMvqnKO04QIAK
         6+2w==
X-Forwarded-Encrypted: i=1; AJvYcCWubpWPQxSI37EO8g1QnMxb7RHH6gG0H/Fm/TAssY0qiYm5D+pouPf6goyfGFGrkHzsmFGuXN5M56Lbew9bEp59ZOF19Oz+c9VbHA==
X-Gm-Message-State: AOJu0YxBJdD6n42j9jDyEz2bKbw5BGgv1WRTR3LCjyQrU0gPXRigAb9o
	unoSF0AQfyPx92pws+ScxeTqT7G5AE9Vz+8E+ZzWeOkWCvpKN+Lu
X-Google-Smtp-Source: AGHT+IH8Z0MnwwwVQMwnV21oMKVbJz/M270qpYiNUouW6yqAg6Ps48QjaX4rz4O3xKXFzw8VzDQkMQ==
X-Received: by 2002:a17:90a:4409:b0:2c2:e2a5:30cb with SMTP id 98e67ed59e1d1-2c4dbb41a7emr1421699a91.39.1718326828680;
        Thu, 13 Jun 2024 18:00:28 -0700 (PDT)
Received: from localhost.localdomain ([240c:c001:1:4300:752c:bb84:7d45:2db])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a5f7d2a0sm2489366a91.0.2024.06.13.18.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 18:00:28 -0700 (PDT)
From: Yanjun Yang <yangyj.ee@gmail.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Yanjun Yang <yangyj.ee@gmail.com>
Subject: [PATCH] ARM: stm32: dts: Missing clocks for stm32f429's syscfg.
Date: Fri, 14 Jun 2024 09:00:12 +0800
Message-ID: <20240614010012.25443-1-yangyj.ee@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without clock definition, SYSCFG will not work, EXTI interrupt for
port other than GPIOA will fail to operate.

Signed-off-by: Yanjun Yang <yangyj.ee@gmail.com>
---
 arch/arm/boot/dts/st/stm32f429.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/st/stm32f429.dtsi b/arch/arm/boot/dts/st/stm32f429.dtsi
index 8efcda9ef8ae..ad91b74ddd0d 100644
--- a/arch/arm/boot/dts/st/stm32f429.dtsi
+++ b/arch/arm/boot/dts/st/stm32f429.dtsi
@@ -579,6 +579,7 @@ spi4: spi@40013400 {
 		syscfg: syscon@40013800 {
 			compatible = "st,stm32-syscfg", "syscon";
 			reg = <0x40013800 0x400>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SYSCFG)>;
 		};
 
 		exti: interrupt-controller@40013c00 {
-- 
2.45.2


