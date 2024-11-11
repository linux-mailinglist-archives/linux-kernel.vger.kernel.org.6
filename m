Return-Path: <linux-kernel+bounces-403564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17719C3740
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5F31C20B77
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D4D14A4DF;
	Mon, 11 Nov 2024 04:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tp6C1pux"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634CC6F06B;
	Mon, 11 Nov 2024 04:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731297743; cv=none; b=oNVnHzVrNCmP3x6eE2B/jbzYo3n5b5oKB4h0vX5TeG+MTABwTvh8ZBPIaw5SEI8iHiTDrvzi1doxW84Ww3uPs5lS9FX3Tw8h32WdKHjExrZdjmz8eWUUC/Dlu/CJqT3fkJOoIAB/6aB+62aUULKr21aQxaoS05cjXpGdivXOCS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731297743; c=relaxed/simple;
	bh=iPkYnIO31AuQKCXhK+uEnPJKdf4HdKu6kAS06fDAsMo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b8KZUIvGTCmk7sBS2ezqYoyXzuA+M3TZDPCYZEo2lGueKwUxBqkEyDrXKAVEdVM4x8fO8XOMfCN9i/0HoHa6wNJ6KuT3X1umaESut/o/rI6b51zUP0hYQffWa41TKM2G4l8Lx13PMx5xEQqL+9EmHiF8l0y+M5MRkI9WqnclrnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tp6C1pux; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7187e0041d5so2414024a34.2;
        Sun, 10 Nov 2024 20:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731297741; x=1731902541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjbTWmVjfUhEoQ8d2IpKkdBlmgYXhZxjwlzph6pX4qM=;
        b=Tp6C1puxOiMFXqJtEW+HAK0t5OCpB9jipAaMWcZxVW1lD+ooCBJswE9u9hBH1NKvmg
         GLhWYONVuOEVBCsdkBnNAe0xgWsM8fZ08NtlRwB33Y84XgtuvlluFGa7l5i2PWqBa25x
         MH3EJZidRJoUPKVEhowVcsm16xBZMi/IiAsw8oLwvIMJEETPrOiDDKQMssKVvwsdVrxr
         Ww2dLh2anq2CTilmtTD8a0djtUNpPuOSPVAhDP05n3/IcD/cinC0UjlozkBCXnIxE2ka
         ijuZ1mDWDQuLUoaVVUN9N6CnVg8tqhv+iAhb5HUrpkgQyGN0sYwtBaSY59rT52epzLeG
         ZsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731297741; x=1731902541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjbTWmVjfUhEoQ8d2IpKkdBlmgYXhZxjwlzph6pX4qM=;
        b=a1x2PQJiSTqttvGIIeHfV/hJmYdigECJuN2L5HztSSolb3ufzrzvpVX4qlPWuGVQZ+
         wQ1lHkMcGkraPUDtsTn3GIouL7cZWOkd6NrqxQjdI9K0LHY2Bi0mpu+KBhsgzHnwA6hF
         6d2eaxD/6uGSXz4cdkvdIbLVDHFT+lzWTVBvU00oefr+cf8UasC/KrUhX6wmLqTYjSt6
         kMhWF8nt5tQbfL32U7gYCtp79NlmdM1d2pmcjK2aLbGaLlP+VMJEbLVjaJwCT1KZIaeu
         Xc8gq5x7kcQ+pIkY/4K3KvIh5gI+DO2ZmFHQOypzqq2Fmp6BJsDBR4EnDlfbaP/niGUy
         ez0A==
X-Forwarded-Encrypted: i=1; AJvYcCVcbMtnawVLFe+twg4RLdEB/Keq6SEGyzkerH/WZ2O02WRI65IlFb3YHGZVJMYlxjh1Hb4tSieSUztB@vger.kernel.org, AJvYcCWMlFhyNglp3vPM+2pz3oO4XeVYvWurUQDfhN2/gONkmYlqC8WQCRzHvimqQRYJdXVyxod9rU76X7AxqhBU@vger.kernel.org
X-Gm-Message-State: AOJu0YxXKtBWqk0sAkjcVqO6RP+T+WIw6Ix5bysdYqgGE6TE9eGYxqF7
	pVnquaR1VtYSh9+NIACpwsusjCJ62S485ZNIid3o4SFwEsnkiwO9
X-Google-Smtp-Source: AGHT+IHRYsyTEdBELcqPuXy/sNavXTBAGqMPTcuBIGgQENdK8cQW/SG/AKtr2fmcdqlADupSFPq7ng==
X-Received: by 2002:a05:6830:3c10:b0:718:1cb6:e593 with SMTP id 46e09a7af769-71a1c2b1247mr10068611a34.27.1731297741396;
        Sun, 10 Nov 2024 20:02:21 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a10834aabsm2083654a34.32.2024.11.10.20.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 20:02:20 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	tglx@linutronix.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH 3/3] riscv: sophgo: dts: add msi controller for SG2042
Date: Mon, 11 Nov 2024 12:02:12 +0800
Message-Id: <90bce35ca34b3c9f86f1af89d70ab34b2e497e0e.1731296803.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1731296803.git.unicorn_wang@outlook.com>
References: <cover.1731296803.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add msi-controller node to dts for SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index e62ac51ac55a..35651cbac764 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -173,6 +173,19 @@ pllclk: clock-controller@70300100c0 {
 			#clock-cells = <1>;
 		};
 
+		msi: msi-controller@7030010304 {
+			compatible = "sophgo,sg2042-msi";
+			reg = <0x70 0x30010304 0x0 0x4>;
+			reg-names = "clr";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			msi-controller;
+			sophgo,msi-doorbell-addr = <0x00000070 0x30010300>;
+			sophgo,msi-base-vec = <64>;
+			sophgo,msi-num-vecs = <32>;
+			interrupt-parent = <&intc>;
+		};
+
 		rpgate: clock-controller@7030010368 {
 			compatible = "sophgo,sg2042-rpgate";
 			reg = <0x70 0x30010368 0x0 0x98>;
-- 
2.34.1


