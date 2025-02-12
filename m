Return-Path: <linux-kernel+bounces-510832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD650A322A1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763701673B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A3B2066E0;
	Wed, 12 Feb 2025 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGS+JINk"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FCB2046BF;
	Wed, 12 Feb 2025 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353334; cv=none; b=cOr8faC3uDM253NlBbk6nra13ZnAXugAtlVT5VHF50HhLCNrRVjm/tI4TMwhOCefLklPcfJj3IncWDX5XLKpMgo4GdpPTksmgcKdAfUZgYcF9R9vpY6fM9OACpAmG2dgv4bCas7HUyxm2t5xTyLVXca4JmU5HSyJiQZs3U3XGNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353334; c=relaxed/simple;
	bh=vqZjphjVCvvimGTjuWEawAa6X4Yyt7LDLgYaLojwoBg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kYmaYlvFw3pd25SwUsnZ0JIFIdcrq9h1qPvLeyMduzqZOUA+pn1Br4sD1ZfWmlwpEI/IPkW/aRkZz5QFuAAt0E23twlNC8uXlPxqLRSEXjyeNYrkszkPYxFskY+0OlkFbvQplKCX5wdlhsqyMSOPj19l3uEHAqNv6ZkMXh9dVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGS+JINk; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f3a6ee569cso968853b6e.0;
        Wed, 12 Feb 2025 01:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739353332; x=1739958132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0SNOa69PLoDhh24/938sy/j/EaHqARH0GqI8xpTJeU=;
        b=OGS+JINkHymS2Ly0FWKM2o5hx4pnaI0kHyW/DJ3bUnO+j87EnI1p6jHWLxaa2kNnJU
         4E4FcwzAp9kZ2C69M6df0XbvvmT4NiMI4mQ3BMkhldVXxplSo3N8nI33hkPVia9vx6/d
         /bKa8VVZ4ZLqt87+3msfC4vWKTvMY1chqgICfxky8Y1eVbIV0e/RmLuW/feKSJoNbQG1
         QAqi4k5iSk6EDvbDOMelQIpBvZj3dDGNgLKoJnYnHXYV5SVTBt2G12YyvH5+LLlYboKU
         WpFUt0JkflUmDRirceaRtyaLsbEmzUk8TGh6NK5nqhGOmN+qxW6mXJce9Q6S0WgeXPZx
         DR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739353332; x=1739958132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0SNOa69PLoDhh24/938sy/j/EaHqARH0GqI8xpTJeU=;
        b=kakenVLXoz2sDvW0V5yDh9TxQIkfKBAGICLZrZc+4GlMZC8fO+EkL8BaTR8QqgEw7B
         FDhAVdbvlcwCZPuGFsPftjhbrKsLE4C+gJofzSGBG7f6htkuGA4SufhsV9uTGwHXUtFi
         CasSII96l1nwLte+mcJGjsd1u9ukB8v/1I9B1k82YfsY9EQ1FVT5ckghhnWdBhYqazpI
         zbyJ5HgCedD1NVpvR4b6fcKhWFs7JKg7TtYDd8LEUS6QpY373Nxmqe+1BH84ROvKH48S
         6hRVfm5/ztCuxGvjhtbRf6EhaLLwrOwgdP+uWKwCcEaeghuH7dp/8sDTvL2X4qbPHl8a
         NuGA==
X-Forwarded-Encrypted: i=1; AJvYcCUS+gx10u4U4y8o6Ib+fh424jr6Y7neOsL1hen4wpyzAuCOIMhEMa6v3HyMjyT1paaTAETsq691HaA5@vger.kernel.org, AJvYcCXr24AooopCv9kvt/qOLzP0DeN7IgVilLuUNQ6KGybomJ4jIjvB328SFpYY550KH3Wqr2dCtH0YZ2YtMDrc@vger.kernel.org
X-Gm-Message-State: AOJu0YzsywQV3rYgIPVWAfPZ+J7aN7JTdpJ1eYh/d6Bh/Xp7hC5q0kNX
	fTmyi5Oj96/PxCZqiexVtxg72t29sdddgXgdqXjjLGPipSUNndkr
X-Gm-Gg: ASbGncudF++piHtoHCi5TwQXPZd564eMXj1ynzhfHwrUUPCG+S6FMo5t4D2RhZ3O+Yb
	MYvppgTQvUrL54LbIDINuozR1BuWQUbCI/y89uSY1pRYbkGA88yGKT1KfIDxpxFgAuhy1NTL5ti
	TNCs4dR5ua5nK+p82APyeXGTc+UUwgvgbS+cZ8UleItsQkR1dMht4C4i4myG20z+uUwuieU7CjD
	7lD4fLBeo1ME3hXedC7tLOtVlj8L4GE6GY/v85gsb+PSB+1NvpIxlbhIDwGQOyf6V3xJn4T7lax
	g+klAjVfy6ykwbZsxAiOzOPiug==
X-Google-Smtp-Source: AGHT+IFY7RRL56SET6zwjdVg9vVDKQYGpxNInNa+Dsu4BPAw+Y3SHcAQvuUvGrIT5JAFo4U62eduNA==
X-Received: by 2002:a05:6808:2187:b0:3f3:ccb0:ad4a with SMTP id 5614622812f47-3f3cd70d9d0mr1961675b6e.31.1739353332373;
        Wed, 12 Feb 2025 01:42:12 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3c4735c24sm1583180b6e.41.2025.02.12.01.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:42:11 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com,
	inochiama@gmail.com,
	sophgo@lists.linux.dev
Subject: [PATCH 1/2] riscv: sophgo: dts: add pwm-fan for Milk-V Pioneer
Date: Wed, 12 Feb 2025 17:42:02 +0800
Message-Id: <dd23362328f77dd91aa9354848bbb0abad0f554b.1739351437.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739351437.git.unicorn_wang@outlook.com>
References: <cover.1739351437.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Milk-V Pioneer uses fan as cooling-device, and speed of the fan is
controlled by the first channel of pwm controller of SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index be596d01ff8d..74c997ed8283 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -73,6 +73,13 @@ &uart0 {
 };
 
 / {
+	pwmfan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <103 128 179 230 255>;
+		pwms = <&pwm 0 40000 0>;
+		#cooling-cells = <2>;
+	};
+
 	thermal-zones {
 		soc-thermal {
 			polling-delay-passive = <1000>;
-- 
2.34.1


