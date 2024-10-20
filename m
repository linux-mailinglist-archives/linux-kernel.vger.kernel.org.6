Return-Path: <linux-kernel+bounces-373228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B199A53FF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 14:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3101F21A2F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 12:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B25B19340C;
	Sun, 20 Oct 2024 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0wcJQG7"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7869158218;
	Sun, 20 Oct 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729426257; cv=none; b=UYq2X4olqQbGLM+BE3zkUOou7bCu9I7n/bGVvHJ9dsThmKVGFVkZ5hgUw8uAxLr+r4WW0bUynucLsFy8hH4C7e7KVXZnxwlxLwT3ql9X0BLWrGdpmwEm2vbo4b/Y0hOkEu/9uTbcunJXdQXd+sMO5MiqFRRiC+Hg4dntgE6SZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729426257; c=relaxed/simple;
	bh=Q9CnyF7t//8HC8h6F6lh1zeH9rMHPCikrgtfjgJg+a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h499ea2j8B0x1cxrTg+RHest+R24nZW4SOn4x0ba2X3iWVuW++3qH5Z75hhIhO1XCn1wKRDWZefvSU9za0aXSjh4joKoqz/aCzyi9+8QTNgjBQEO71sDUD41pTeaqu9J60Y6OZZRMSwt78yaVeKxFa2saPCBfU+XBnPhmZimcJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0wcJQG7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso2567899b3a.2;
        Sun, 20 Oct 2024 05:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729426255; x=1730031055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncgmlyGfcrqHCYKyqt0DRpGIqa2UXUmRq5v7oAb7ZpU=;
        b=S0wcJQG7FzCRfd/pRNeGpNsyo3LWfYG8JZmpifDikovhu2YPqYxnyI2QxWtYFNPrLB
         BeYlXDR/sOm6bisPDP5aEEx/8++ToOLmcI9YruKd8Kxfo8JXcTV/TZYrkatzDwQrPU/R
         FkVHQE1SFdxauJhUMfZF/i4G9vV9hD041jzNgB/SxHU4Hv6KnocxMyP7sv8ffWTdoZ1G
         SKuVT+CE5XRr6YioH4czX1XSxTiPDx0QKx9+4Fa/WvB5QMSD0+Sl5d76U757O2TXacmW
         b5FL21WobzqHWJgOsKnf/8opOJQKFlhazKrL8Wc5tfsb1ZhbSkH4/1RlxvnLssVCS2VO
         s1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729426255; x=1730031055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncgmlyGfcrqHCYKyqt0DRpGIqa2UXUmRq5v7oAb7ZpU=;
        b=hLFC3ntWWTCPE2x3/ExwfHEb18A8kXHk8Z2m71tIn1V4DS0N3gQxFE0+J05ynlASS8
         BHBlw25sr+15LxVZa4CeLkd6wJDsZg+UWEQrc+mb43c+u3gFi9z3vdXKbiXk0Hqy9o72
         hfmhutHWZRLmvGQU4E1hIwgjDMNuBBXXqxWynd8C+bfyZfSz4jA2ZX/xmckl5KCdKeZj
         +AS/IuRP6J+hIRVeRznVx9qEmXGtvYGLC7wSfCM/NsiQ7sp28OPNssBzj6yvsonKEDIJ
         4wyGM3fn93oi/qXw0/YN/hggmkvTjvIaNMYeuhe9dKrBG3uKITaCrt9JZDD8oWX4XD2h
         Q69w==
X-Forwarded-Encrypted: i=1; AJvYcCW19Ega1DDNoEoqHFjupJUg8535gCS3FQeEQtkFynp+F3+82FtQt074x7o+6sRe5WnlyYWg3NcZr5aF@vger.kernel.org, AJvYcCW38Ko7dFTJKjWAVdu5MFREnrJ0n8dbs6UlSY1Bon2U3U0mu4DFoiK7tiPJnLIl4iT0JSPPEI3HzoKN514y@vger.kernel.org
X-Gm-Message-State: AOJu0YxHND+Jd4ClIy2j7zffgs2vE9Ju/nbbsvlHMVbqwBmy/2tXa5ad
	5s7Lk7HUOUJaX5nbYHdrOg5nv4EOv/HlPEcrQWCrzOxbWMtjrX+b
X-Google-Smtp-Source: AGHT+IGOJVHWCtfRuQCFLPUyWlsXcCpbQQtP89MiNUYKDIweHzBMKjNtJAWi17UYeCR7wCE0GUH+jw==
X-Received: by 2002:a05:6a00:b52:b0:71e:74e0:e5fb with SMTP id d2e1a72fcca58-71ea3334772mr11429521b3a.23.1729426254891;
        Sun, 20 Oct 2024 05:10:54 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1356780sm1100991b3a.90.2024.10.20.05.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 05:10:54 -0700 (PDT)
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 3/3] riscv: defconfig: Enable T-HEAD C900 ACLINT SSWI drivers
Date: Sun, 20 Oct 2024 20:10:30 +0800
Message-ID: <20241020121030.1012572-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241020121030.1012572-1-inochiama@gmail.com>
References: <20241020121030.1012572-1-inochiama@gmail.com>
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
2.47.0


