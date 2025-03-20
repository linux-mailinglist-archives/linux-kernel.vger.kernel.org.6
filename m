Return-Path: <linux-kernel+bounces-569084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CEEA69E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE19188B204
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3E11EDA3B;
	Thu, 20 Mar 2025 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="mQBy1bZ9"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF671EB9FF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742438422; cv=none; b=e9M0eJGyh+3EjQXUglKG4Bkdi9UiNzo3XzHFbawxyHjzhIaqJQhM7hEltvppbKvE659/EbcvJrZweIQa+6SPWqRK+fK3mhs2by+MDtp/jItM8OdU6ZkEHrKemNfPKkXLAq3SpccaXToeDsq9VwGvUFW3f3fNoXF7aiVmlaKR2Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742438422; c=relaxed/simple;
	bh=ZFllnhcMh+RIDEs+ibMCOUU4FmP4DOjH+ijouJA0sXY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccUOQlv4KZqaH/SlLLfrlfwOt6gG5Ml7iqlT2zSbe8KpTFfh8yGj4yPSWVaFcoZpGDJ8HEKQMelDr3fLdFgCAbxIFHGOyRqnLwe0nq4AqJpJym9WcpkjQFYsdXL6AXP7SdiDxnuHspHrMLJEu4Vy/AGaY4+hPvfQznbhxJULYYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=mQBy1bZ9; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c547932d2eso20529985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1742438419; x=1743043219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+DVvQh5m1bMCi1clyLtB7PLWg78oPXTQmpuP7ESTF8=;
        b=mQBy1bZ91YnByaXI5OE4/64FCPYgjkCulZlq4z1up4bFAj4EBpfZ+UNWWeAj4OeSyi
         cKoCMezG7vrumWZUMHL0wMIczWya+dsEEIyAgOQJmDZIUSDAwlh3rBq2zXQqMz8Rgr0o
         ebGpPZss9c0CCZQm3MIVQoB9WU32bMvZs5LE7OFXKOdaacQTRB96imy0gtRlOLhZLu29
         Jltagc0aP8beuCKvt/ylQJurr/FVc91t80fPbEuyF1i0mYduFpldYudDfubhvSduH5GO
         i6ecaM7DgGyKn3nlhII1jaLDiuOX3QeDF5YrPMQEqRv6sNFzuWZ3zRvO+LTHbiGWOP/i
         NlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742438419; x=1743043219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+DVvQh5m1bMCi1clyLtB7PLWg78oPXTQmpuP7ESTF8=;
        b=VfZNRJoKqGuXmYexLpYjHcLx12btO5YNly7y+h6vgp+Kpa6Fl+3OXECNL2TnFpd39u
         f/q3iZX+L+oMEes2PsL8UuDSK5oo61Z77T5FWzB15IOpiQj+1CthGmkFLv2CEzqAJIqu
         k08HjuV3ACiWZ4b3Ee5Tv+rrvnAVIQgx6H9izSKsbZmu1zuOM5NGa6BxJGPBYjbqAExC
         sGQdb8vUAXLvHAPURYIoR4C/u7Usoc9xkkTjGVzi5pir78r6uKcMsRtLzD/E0bdirmnp
         E35cMGuJzF6VR4UN0wcJJMmXJH6KQOx2m0bp7AtqJEP/pnlGtxEP8Z74hN+WYbgif+6t
         J/4g==
X-Forwarded-Encrypted: i=1; AJvYcCVVwY9yOrAwQqI0yekWdaJEcS/p0C2YH3B6nZJd/6w5Q7zfe7vNreQlb/6V2ChoJ5JpwbcFNafszTEC5t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjsedpXrqemD2/h7JfmrvTDuXAKxXvKYE/bMrd0CqctezsH6kg
	0MGpr0pTxzaWjnI0eeTwvTXnaLVAT/UtJh6NT8uvFVj+XntVqOT2la1ewHQeKIc=
X-Gm-Gg: ASbGnct30xUh/tC/mfmw0YV3ywKcVqSkV8nZRcW3JFjPSFTRrZ9TUoe0CJLcebB8MHM
	e0UJJSr4Ybe4jrZIXBnegD7op++Owrrm7up7XGqFf7NKIP6kr3/xVSsew8zXowIeOJ/tnXZwUqV
	i3MunEKFMU8sh+DMXDPS3/MwbwVmd7Uw6zRbOb2fbk9+85dL7GqGKKF98RJXQcOQ8NEHX2HsnvA
	6S8vRPrmF7O63Q39951LC/YRFvJJu5I0lpV+OleGRtdMSh/dPe6k4dHZv2gx0mVOzY3d3q+XWCB
	aiILvnSEI8VoHhv+waqxvoQApILTXSiKIXFh+d5t9jC3DLi95O3PTkC8Fn2Xw1+GL0SbJqWmH/f
	n+botZhvOzxiTIbJQ8fJeT/ByfypO6bx0
X-Google-Smtp-Source: AGHT+IHDuFkRUrzcuGCjVMEyO6PXLoUcE3ozt83EY0+kL0J1Oz/yABIc+QBPR+ZBZ9rhjUrcpOOeuw==
X-Received: by 2002:a05:620a:2592:b0:7c5:55f9:4bcb with SMTP id af79cd13be357-7c5b0c94080mr226145985a.31.1742438419303;
        Wed, 19 Mar 2025 19:40:19 -0700 (PDT)
Received: from soleen.c.googlers.com.com (249.60.48.34.bc.googleusercontent.com. [34.48.60.249])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4dd9fsm947815985a.4.2025.03.19.19.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:40:18 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: changyuanl@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	jgowans@amazon.com,
	jgg@nvidia.com
Subject: [RFC v1 3/3] luo: x86: Enable live update support
Date: Thu, 20 Mar 2025 02:40:11 +0000
Message-ID: <20250320024011.2995837-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
References: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the Live Update Orchestrator for the x86 architecture.

It does so by selecting ARCH_SUPPORTS_LIVEUPDATE when KEXEC_HANDOVER is
available, signaling to the LUO core that the architecture provides the
necessary Kexec Handover functionality required for live updates.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index acd180e3002f..a7497cc84fbb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -29,6 +29,7 @@ config X86_64
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
+	select ARCH_SUPPORTS_LIVEUPDATE if KEXEC_HANDOVER
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
-- 
2.49.0.395.g12beb8f557-goog


