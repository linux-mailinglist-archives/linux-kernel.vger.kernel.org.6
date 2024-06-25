Return-Path: <linux-kernel+bounces-228825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B9916788
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7FE1C20DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6C015EFC8;
	Tue, 25 Jun 2024 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/CFo9UU"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1FD154C0E;
	Tue, 25 Jun 2024 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318050; cv=none; b=PmAK94iWIK9MxdnZkyUboo+LFOu4DuLI5f5sTFjkz4X6EpcRy5Jh3RWvqTHkKCaE2nfcKI5lsgIGRWTZo8C8YzAEXmqMYC+ixL7eB7Arj0Arm4xF3W0Q802t84Em5G/1wu4GV8aF+vu7/aKbCzkU7KKdUhyJMNhWqFcQ9B4Cllc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318050; c=relaxed/simple;
	bh=QvSUSsl7XxoBxAuLDE6cdwKLQkV43TqO4caDj7kNX4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gfHTjEIXvkl3ptvywGhLCd1F+CY+xli68paqHSmG6PJVX/jSvWWDbUAhmD8xyVQ0rxTMazgsgYYYqdUyC+ZfLlQgcrirXUbCX4nRtRp/CW8V/nKDAHuC/70m+TA1uVnemmFZ+N8lIsAFJkFJSTwHBLz2uk4MFi7d9P/ijk1wvQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/CFo9UU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70671ecd334so2103795b3a.0;
        Tue, 25 Jun 2024 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318048; x=1719922848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrtPbGSmykS0cLt2ThwHws1Euel48gln1tDvUnq/Z9E=;
        b=e/CFo9UUhFDfE0e3GYhNGVigNoohudKz+asx2zK3d2SGNR4lQnzHjPp47adWrMpD8R
         Q4vnWGDl6KbaibilRNyJNyDrhHndbxJyqTfFORNbYouhSxOtZ0LczzWxCZ4+Ji4kTYdF
         1hCRbH87UtYNmWY53CieMSPY9EnU0pNfCRyqkZNrarnV8XsBO4pzdJ7cz0O68XZ2Fbaa
         s9bjhrnPsPk1aHwfG6VLvD895f64bE6ZJlw5YxD5w7KQ3hz/FERT9GYXGBLLGE8QXxcH
         ptXthLC9/1L3f7kqr4MAjEr50Usht+9+KEPWLvKZQhvjHgpYGpdV7x4L8nvXE67Qz8+X
         seyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318048; x=1719922848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrtPbGSmykS0cLt2ThwHws1Euel48gln1tDvUnq/Z9E=;
        b=P+RF9OSk0zhP6WZ37B4EL/HrMbo4cKbBsITmZ07ZK2dRjheb2lKSuhyZvvkM/s1APX
         CU5QXY0nyWJs507dZm03A/oPF0CCXhVjq3VgVahyJGE00gXLQbZ6/K9OrCPZH7HZaah1
         1lEYlcUwrp7jPF39xfFDmGVXNfU7yQAv/pLDd6SB2w/jCpQQB+uIWK3QVyWKmvEdwwPw
         V+viBLlquclSbp4kEzpfeO2K6U/U1seN5uJ6m6Q7r136hCR2AkFXjTxnzQT/dd/7WgEe
         9ZxoIiEYOvLqE3KYfPM8Umvtz18ibmGAKQhLif9E4U3gZ2AbKNCPTU0C/yAVfV/HY+4O
         pRyw==
X-Forwarded-Encrypted: i=1; AJvYcCX7La3Wi5xvUZXwvlVagwpIptMz2qrLrKBQZIvTeGbGulzEbqdgS9HOHnmCEQkc4+fSktAu2bbtiX6582BVjF2qmvcpaBn33/tDIp07osSUMlJKo2NcKi5nH2MRmtUBnBfeyQVk2758Xw==
X-Gm-Message-State: AOJu0YxUg+apv3JZHV1hpY8HOQWKt/l+SLdNmVB2ujDGOXZOm550LS3n
	F4ylgIxvmWnbQY+vdTsiUkXXoeD+8UcLF+uQFyX13W/I1qyq5yzf
X-Google-Smtp-Source: AGHT+IGzdeIjPSg2rWQ5ZEg4nniQMEMPO1e67nua4W+EJWyUQjrWionEjpF79ZppKBT76By0UdnM3A==
X-Received: by 2002:aa7:990e:0:b0:705:9748:7bb8 with SMTP id d2e1a72fcca58-70671034a55mr8085919b3a.29.1719318048019;
        Tue, 25 Jun 2024 05:20:48 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:20:47 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com
Subject: [PATCH 04/17] ARM: dts: aspeed: minerva: add eeprom on i2c bus
Date: Tue, 25 Jun 2024 20:18:22 +0800
Message-Id: <20240625121835.751013-5-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Chen <yang.chen@quantatw.com>

Add eeprom on the i2c-9 address 0x50 and i2c-15 address 0x56.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index b0643d1d549b..19f609cfd026 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -324,6 +324,11 @@ &i2c8 {
 
 &i2c9 {
 	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
 };
 
 &i2c10 {
@@ -360,6 +365,11 @@ eeprom@50 {
 		compatible = "atmel,24c128";
 		reg = <0x50>;
 	};
+
+	eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+	};
 };
 
 &adc0 {
-- 
2.34.1


