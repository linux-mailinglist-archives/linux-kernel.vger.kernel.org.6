Return-Path: <linux-kernel+bounces-409642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D59629C90BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8167B3E2ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8451AE00B;
	Thu, 14 Nov 2024 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LQsagkWD"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1292F1AC887
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601153; cv=none; b=gFaekOSAr5AMlC62d1HR/GUU4NK/7Ojxu7eYT+hl13R+WB8F30QPvgJgDd6AYdCMADVakP8wGZxTstLDZVLVPrpVkqThKOi5hx3amLaOFntEWEWUMcVl/W7kqlgPaxkYfIwJfUKSft9Q548KJlmlE82Xz62QMc1ObJWBeQLosNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601153; c=relaxed/simple;
	bh=ES0TvAxz9/x2ptiDnzIz0eP+Ou6/i+zYJHVn+dCYtjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOmOlweThrFJy6Tv+FcTlzpZ6b6Hpn5yHGtuWlTEgT46SKBYJaIVysVDWsAIUZ3j4wsx08gL4VJy/JjHoXLRCj5xbMthIWxdiAEWBEtygI36jI57OoR5lqv104hw+9Ue2k97IGm6hwitHxbT779RLjLWW8DJGeDbG938BWD0a3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LQsagkWD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43193678216so7731205e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601150; x=1732205950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmqNGe/T2iE9PlV9lB2/3K3MC1TQA7fI1NussKF1DE0=;
        b=LQsagkWDpQ09Orr95W2tYqbVr5m6ZwXuTCLazfrX6HiwLKpF0BBxavxZURIXdq/Wrs
         O/XIT6O+69q5zC8NXSVTiBpJ5lVkg/cT4qJm1wn9VRjDaa/1tN5blgJXCaH8fLWePHeE
         kta4aTjJqZNrE2H9Qsopq8q3PXcG3RvjVh2iBWi12Em5vOdykiEEIlNefwuuStFqwSv5
         D51jsaIiXgD3vKMuKI51T0lGlHsAxA8gdX/zXkgY2RIwj2XhmUdHSfw/WyvDS7YivgYH
         5vd9SiRpfyjJAyhf7/xwtIPW4FnmuVgIPu/uKlNnFPnIBPSpZ88wAHOpZZyjNTcHeA+N
         wqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601150; x=1732205950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmqNGe/T2iE9PlV9lB2/3K3MC1TQA7fI1NussKF1DE0=;
        b=sKoD/+u4NFJgTr8pRG5QVcznSaYp99mfYVF5Uw24y+6wKGiHcNmqkB2qDpLYTrwFyA
         qa8Icm895RJGS3hMfwzD8/aidnhoUF1AmPvBF4LQV6zaq0h9UgbL+huILH9rTMu3ktWp
         kkFOQvZOSDw54V3eRi6xgFenYCG+vKrEWvkad/qnTyTa2F1iU4JqRpJJ5PfdnABLOOBh
         9raZWqv7xKDFwNPN7PQ7qZhjRbGDsuo9Y2NxBzFDwz4S65zH827RBpjtGF0MvEtRWtHc
         gRraRgW3/8qi/wZLDjarQtDXcI92ZFIoHYRecGGyiEqO4iQDV1DjIxGfHMPgrGu5wJLR
         Gbdw==
X-Forwarded-Encrypted: i=1; AJvYcCWx3omikcL5S2H30nDfK/hW8g/uWEFBIP4Vc1kQUqvwWljRGujdJuyKuqk5RKyTlkKor/nb5CN0ehLiz+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv/soHESq98lhpvwRlHepz0eUbAfZhyecFOGzV0UYU2oUlRZse
	XdoMbWgyVv4JgkfJJYuSS5SRQkQXn6UK1iB7/Z3/acpSdhb3G3XovN8LsoM0B74=
X-Google-Smtp-Source: AGHT+IGMbtDDWmvKWsj/Ybdc9TgUB55aFH3ajhr0ZnMlCbsRayCj2n5LaLaeoDlbaJzuEn6VOd9B/g==
X-Received: by 2002:a05:600c:8715:b0:431:93d8:e1a1 with SMTP id 5b1f17b1804b1-432b751bcc2mr209410385e9.27.1731601150428;
        Thu, 14 Nov 2024 08:19:10 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbe779sm1834550f8f.60.2024.11.14.08.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:19:09 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	zong.li@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 14/15] vfio: enable IOMMU_TYPE1 for RISC-V
Date: Thu, 14 Nov 2024 17:18:59 +0100
Message-ID: <20241114161845.502027-31-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114161845.502027-17-ajones@ventanamicro.com>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Enable VFIO support on RISC-V architecture.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/vfio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index ceae52fd7586..ad62205b4e45 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -39,7 +39,7 @@ config VFIO_GROUP
 
 config VFIO_CONTAINER
 	bool "Support for the VFIO container /dev/vfio/vfio"
-	select VFIO_IOMMU_TYPE1 if MMU && (X86 || S390 || ARM || ARM64)
+	select VFIO_IOMMU_TYPE1 if MMU && (X86 || S390 || ARM || ARM64 || RISCV)
 	depends on VFIO_GROUP
 	default y
 	help
-- 
2.47.0


