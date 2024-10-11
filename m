Return-Path: <linux-kernel+bounces-361323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0850B99A6D1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893AB1F23987
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8815B194AD8;
	Fri, 11 Oct 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="n+EEY74D"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFCA19146E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658121; cv=none; b=fFIAIaMdaIT8GO537Xswy1005viOL6SCehYqCRVYGyD11i8Ybppn2WoaA1c/SFBLxGnbjpijroeuQ4Z1qrcfjxRntBUQv1WKK7npK9J9pHOSuI7GgEWNyb/TmYD6rsLGk6+tKraLAdkbrxZtUguT0craiG5uK+5cudIxcutCJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658121; c=relaxed/simple;
	bh=X6LexBBB6VtOhRGYx7Cp48bkQnr5/XCFE+samWsctSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjlY2VZRwhrhFqlJ5U1EC2q2ZeVKQT1ySZU1DdTIQP11qXx+6l+jSeEGZ6yzEeyzKubmnws29QBJ781VsOBxHO6+MNiQNW6j6bcK7ZSWC/dIw0CB2GHSK3wU6qxXDAPeS6qtkYctUvNXv8SCzX+ifqX552yNCxevUY7T1wKtbKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=n+EEY74D; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DF3AB40615
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728658111;
	bh=edTlAYc3Etm4OL8N3s7LjWMKxX64MYHgvFT+kJvdV7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=n+EEY74DTohVzCbCXPye0HnxB89O5QvFYUhE8YXNFd0ABpJ991oktURPDIj7otQoK
	 Y9Jf8J8TPkbL5wiUJg21VwvwX2Q22WVl7W+DV8arIQlxiYHAzJpvs1P3s5xM9Z78WY
	 R1o8Tixv0fmgvZ54ftLlexeR/Bu+eNn0uXBbCEUa8WHZHDmgbIssv+S01JOyQhDMqv
	 ghDQrLLFeVIOWjYwdetAmtdZ4COlsnB6SmMPrGf8oxtwzSTy7UevSbUN1H2e7eX0MB
	 eAtqXoJ2ODlOwTCkygJh9YL2WazckRho3HgdZWFDfa8RkPWGt5fsVRVsVOFAC5jdnH
	 ESr0my6fSL6bA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9953730a3eso145156066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658111; x=1729262911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edTlAYc3Etm4OL8N3s7LjWMKxX64MYHgvFT+kJvdV7k=;
        b=Zui5M9OlU44QmhV4YinUBi7NtcIJIy8WhoTp8cDaC6RZH5cSUC5OvGsmfm8K3tTfrD
         NkbaSO0s4DLw8aWsRT4bBP0tGKyl1m8glnb4PIXYESnSwnQVLhJtZxli5w//jNHih+Kn
         UBvj6Xd5ZxosRJDFv/MAv2gmHem/vQjdgQU2pqxNbXADEfPO8HnNijmCfAxNWeJKYS3G
         0MgnKCKUTVb9y3lUTd0FOXGbD08KDbLbtoD0/hR1RSW11iQHTLdOv1oSsNx1qo2BkeBg
         i4X3Ju3SdluXwT1hcXtRqGa+zA5pacL+w8IJMfk4+/XzfsosWPYe05GLGHnITMqNuqbZ
         +icQ==
X-Gm-Message-State: AOJu0YxCz0W2uIcUmTAUEK28L356fbWW8zAyR3gID+nPFHaARAMJ7lHm
	p6niZDBbCypr3yNBGhVyYT3OjP4zDAnmsg+2q2SH9EQGeSbXnd2dy5i6jvS7vQ+VS6amPphCFFa
	wQnFsAVPBZpMmP6G40f1HNJKoOe2/UyfoNpV81DKU1M8GeKwzcOwmL+fx3IK4YMicUfzWT0hiR0
	HL0FMMsndfsQ==
X-Received: by 2002:a17:907:e287:b0:a77:b01b:f949 with SMTP id a640c23a62f3a-a99b9583aa5mr263419966b.35.1728658111058;
        Fri, 11 Oct 2024 07:48:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkuB7p0e37v0WSrhn4e56VJqCLcOD3kU94S7P3YLvQ43FyUGl3Ul06zTz/mWY0Fzz4R0bA2g==
X-Received: by 2002:a17:907:e287:b0:a77:b01b:f949 with SMTP id a640c23a62f3a-a99b9583aa5mr263417766b.35.1728658110680;
        Fri, 11 Oct 2024 07:48:30 -0700 (PDT)
Received: from stitch.. ([194.62.169.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99c0c89bfasm54134666b.162.2024.10.11.07.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:48:30 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH v1 2/3] pinctrl: th1520: Update pinmux tables
Date: Fri, 11 Oct 2024 16:48:24 +0200
Message-ID: <20241011144826.381104-3-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011144826.381104-1-emil.renner.berthing@canonical.com>
References: <20241011144826.381104-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Drew took over the pinctrl driver it seems like he didn't use the
git tree I pointed him at and thus missed some important fixes to the
tables describing valid pinmux settings.

The documentation has a nice overview table of these settings but
unfortunately it doesn't fully match the register descriptions, which
seem to be the correct version.

Fixes: bed5cd6f8a98 ("pinctrl: Add driver for the T-Head TH1520 SoC")
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/pinctrl/pinctrl-th1520.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-th1520.c b/drivers/pinctrl/pinctrl-th1520.c
index 03326df69668..8bd40cb2f013 100644
--- a/drivers/pinctrl/pinctrl-th1520.c
+++ b/drivers/pinctrl/pinctrl-th1520.c
@@ -221,9 +221,9 @@ static const struct pinctrl_pin_desc th1520_group2_pins[] = {
 	TH1520_PAD(15, UART4_RTSN,    UART, ____, ____, GPIO, ____, ____, 0),
 	TH1520_PAD(16, UART3_TXD,     DBG,  UART, ____, GPIO, ____, ____, 0),
 	TH1520_PAD(17, UART3_RXD,     DBG,  UART, ____, GPIO, ____, ____, 0),
-	TH1520_PAD(18, GPIO0_18,      GPIO, I2C,  ____, ____, ____, ____, 0),
-	TH1520_PAD(19, GPIO0_19,      GPIO, I2C,  ____, ____, ____, ____, 0),
-	TH1520_PAD(20, GPIO0_20,      GPIO, UART, IR,   ____, ____, ____, 0),
+	TH1520_PAD(18, GPIO0_18,      GPIO, I2C,  ____, ____, DPU0, DPU1, 0),
+	TH1520_PAD(19, GPIO0_19,      GPIO, I2C,  ____, ____, DPU0, DPU1, 0),
+	TH1520_PAD(20, GPIO0_20,      GPIO, UART, IR,   ____, DPU0, DPU1, 0),
 	TH1520_PAD(21, GPIO0_21,      GPIO, UART, IR,   ____, DPU0, DPU1, 0),
 	TH1520_PAD(22, GPIO0_22,      GPIO, JTAG, I2C,  ____, DPU0, DPU1, 0),
 	TH1520_PAD(23, GPIO0_23,      GPIO, JTAG, I2C,  ____, DPU0, DPU1, 0),
@@ -241,7 +241,7 @@ static const struct pinctrl_pin_desc th1520_group2_pins[] = {
 	TH1520_PAD(35, GPIO1_3,       GPIO, JTAG, ____, ____, DPU0, DPU1, 0),
 	TH1520_PAD(36, GPIO1_4,       GPIO, JTAG, ____, ____, DPU0, DPU1, 0),
 	TH1520_PAD(37, GPIO1_5,       GPIO, ____, ____, ____, DPU0, DPU1, 0),
-	TH1520_PAD(38, GPIO1_6,       GPIO, ____, ____, ____, DPU0, DPU1, 0),
+	TH1520_PAD(38, GPIO1_6,       GPIO, QSPI, ____, ____, DPU0, DPU1, 0),
 	TH1520_PAD(39, GPIO1_7,       GPIO, QSPI, ____, ____, DPU0, DPU1, 0),
 	TH1520_PAD(40, GPIO1_8,       GPIO, QSPI, ____, ____, DPU0, DPU1, 0),
 	TH1520_PAD(41, GPIO1_9,       GPIO, QSPI, ____, ____, DPU0, DPU1, 0),
@@ -256,11 +256,11 @@ static const struct pinctrl_pin_desc th1520_group2_pins[] = {
 	TH1520_PAD(50, CLK_OUT_1,     BSEL, CLK,  ____, GPIO, ____, ____, 0),
 	TH1520_PAD(51, CLK_OUT_2,     BSEL, CLK,  ____, GPIO, ____, ____, 0),
 	TH1520_PAD(52, CLK_OUT_3,     BSEL, CLK,  ____, GPIO, ____, ____, 0),
-	TH1520_PAD(53, GPIO1_21,      GPIO, ____, ISP,  ____, ____, ____, 0),
-	TH1520_PAD(54, GPIO1_22,      GPIO, ____, ISP,  ____, ____, ____, 0),
-	TH1520_PAD(55, GPIO1_23,      GPIO, ____, ISP,  ____, ____, ____, 0),
-	TH1520_PAD(56, GPIO1_24,      GPIO, ____, ISP,  ____, ____, ____, 0),
-	TH1520_PAD(57, GPIO1_25,      GPIO, ____, ISP,  ____, ____, ____, 0),
+	TH1520_PAD(53, GPIO1_21,      JTAG, ____, ISP,  GPIO, ____, ____, 0),
+	TH1520_PAD(54, GPIO1_22,      JTAG, ____, ISP,  GPIO, ____, ____, 0),
+	TH1520_PAD(55, GPIO1_23,      JTAG, ____, ISP,  GPIO, ____, ____, 0),
+	TH1520_PAD(56, GPIO1_24,      JTAG, ____, ISP,  GPIO, ____, ____, 0),
+	TH1520_PAD(57, GPIO1_25,      JTAG, ____, ISP,  GPIO, ____, ____, 0),
 	TH1520_PAD(58, GPIO1_26,      GPIO, ____, ISP,  ____, ____, ____, 0),
 	TH1520_PAD(59, GPIO1_27,      GPIO, ____, ISP,  ____, ____, ____, 0),
 	TH1520_PAD(60, GPIO1_28,      GPIO, ____, ISP,  ____, ____, ____, 0),
-- 
2.43.0


