Return-Path: <linux-kernel+bounces-350008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409CB98FE9E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF28280124
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF71D146017;
	Fri,  4 Oct 2024 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVWFwtag"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08309142903;
	Fri,  4 Oct 2024 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029200; cv=none; b=uRcgGBcIFH84CyeYkEziC4X9ugXJxXBSqPqeY8E0B65ThzkHgPm5GDrwX8nSiPTcKTODBq9YRPcDf3MJE9ftbM2FUmZDP+YwD0UK8KtKYm5ByaPT1MoAMGX7Q0km8E7mIz9cP01KHy5HXnk98KU4cnqji5X3WrE8UQSn936vB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029200; c=relaxed/simple;
	bh=y73WDyKyJEYsN8PN22hVxCPugmFrQFKaxxQTk+Xrnpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBu9GnAl0xTaJzrENLNsDv/lhlfl8BeLATo0ViE5dLPyZ8dSwduuxxuXacIqVSkiWJizaowcuMKTTHInk4bE2R8KugqScijO3K/UgiSFvYDCuA3EyZUzXyjLrC9VD8Qt9f1bydCNenIkCY7hbl5sGOtwIedjQ+Xr8/rJIZN7tQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVWFwtag; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e082bf1c7fso1362531a91.3;
        Fri, 04 Oct 2024 01:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728029198; x=1728633998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y73WDyKyJEYsN8PN22hVxCPugmFrQFKaxxQTk+Xrnpw=;
        b=DVWFwtagbCdBbO0fSv9a/c7vGcNQ9WMweqZzIq22mAWNHhqdi7z6MYf9Ie7oZePD/T
         1bN6/C9cpeOEQFiE/HVpgZe2kIpc/D8f2eA8nxOfbXaA6JPLNI/vgSHcsCmZ67YammSh
         GeRdxzDmWAryrBP/B2INtXz14WVEBf2yr3k4Rpbr3NgzQFxkLeQYwfoCOoAuTZb50sMP
         qT8nzDB2EdskrSIZ2uhvaudIythGDFEiAR3lpV1ZY7D1uSpW3k/+XRASV38s5NNh/WRR
         206lTCXhnU1aSNB5l4F4vZKlE6l3xwzWtUd8k6KJSF9Djh1ooEMfw8n2osxdxcu/VHlX
         sYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029198; x=1728633998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y73WDyKyJEYsN8PN22hVxCPugmFrQFKaxxQTk+Xrnpw=;
        b=EU78B7kiRGA8NtqZ46Fhb0XUg7+v6MsvnklEGgaD10Vijye57iKZ7ir5cDQOVQvGS1
         prfpFRL7l96pg285HMbY1rqdkw0cDbjXE4PEbhMeynqtxF/EbYS1j+pWYcnV9iBWHGDL
         08xwk01M6ChUF+YM4IaVm5uNNS/chC3e9Ab20UVS+2neUuHM/+PIQaqhsx3nXa2itdfp
         H4hWMrdzPFPzkeW3y6DK8jfhrJkdIAq3Cl8w21xseAFenazcx++TcrPgGUruLTfvTfrV
         nOlJZ4tOSsHC9y4Dzpy4QnDiRjWoery9ahnDPA+o9Sb22ju71kcfBlI6DKQlKhvszcnZ
         Cq5A==
X-Forwarded-Encrypted: i=1; AJvYcCX6pPtGEIauR6XsgIP5ORa0krczs4usdG5WdJgClaL8dqter3tVcuANnS2jr/wYGsiSwrFMldlTNGMQGqrm@vger.kernel.org, AJvYcCXoEYm8s1klFFynP5hPQC/W32RiSHx3ns0be7g5TEz1Xc4R//KrAdX/UBe0bbE1WuKcTQk3EHsVMDsw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4jK2JlEGJTOWzokIgV2n8AXv598PZK6PxKNHbIytVj7WzPP/x
	jeQUi9uabptKTMtafPNY13PKCPtMrJatgLmdkixfAGU8CL2Fpcm5
X-Google-Smtp-Source: AGHT+IF6O1aW5lW097FsX4Qpu8qZu9bKqcaxB0twSRt7bC2I6twpaDw4gXeZNQiDtRGPSVjNOqKEMA==
X-Received: by 2002:a17:90b:504:b0:2e1:dcb5:361d with SMTP id 98e67ed59e1d1-2e1e636f4a2mr2337155a91.30.1728029198222;
        Fri, 04 Oct 2024 01:06:38 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e83cab42sm927448a91.2.2024.10.04.01.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:06:37 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Guo Ren <guoren@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 3/3] riscv: defconfig: Enable T-HEAD C900 ACLINT SSWI drivers
Date: Fri,  4 Oct 2024 16:05:57 +0800
Message-ID: <20241004080557.2262872-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004080557.2262872-1-inochiama@gmail.com>
References: <20241004080557.2262872-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for T-HEAD C900 ACLINT SSWI irqchip.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 2341393cfac1..5b1d6325df85 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -256,6 +256,7 @@ CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_VIRTIO=y
 CONFIG_PM_DEVFREQ=y
 CONFIG_IIO=y
+CONFIG_THEAD_C900_ACLINT_SSWI=y
 CONFIG_PHY_SUN4I_USB=m
 CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
 CONFIG_PHY_STARFIVE_JH7110_PCIE=m
--
2.46.2


