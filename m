Return-Path: <linux-kernel+bounces-340090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 290FD986E77
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C73CB25EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C89D1A38EC;
	Thu, 26 Sep 2024 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="YYTauIqv"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E41925A2
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337814; cv=none; b=QE/463s4ApDZWVk6Y2hM3VEae7bwl0lE5g0IU3SZrMHeWPtg9miyU7SPOgYWNJiByqSQCso4qc8RKX+0OHRGj3lSm9SAyEs2inexL2doyuNcOykfT6yaKtr2XleBQi52XZa2YzsArDxJDvqcZ3RAm+tr8rCyhWvChQglUvI8ny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337814; c=relaxed/simple;
	bh=fXao3CIDyf95noV7duVCG4C1MtQKmAGLFhD5f0MomgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKGHiDR5GYynbk2t+p3OCfqZWFeSWUOVGWr8TB34cuXDdGqR63zcIx+Hp/GTJpxzQfSIiWcu9DYbJAt3u48qcs0vC+mQVWI61Y+0btdPA/yDQ6RKXY1tE/v7M7SQsf/5gLMVUaXovYlCMH5+ZM7kGok+8aRXF/3u5Xpb/IIxGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=YYTauIqv; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so887156e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727337809; x=1727942609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znlor91B2IZ8C7sZbCPoTy3JnLr5Yrwkd/pP2EeuZeY=;
        b=YYTauIqv0QK4amMbcIH86OiHOpPBJ17O6bwp+jplqi4P655QCHEoBsAOArsOcovJe5
         7oxzMhxFvc/o0mmBFITqSDFV5Z4N5BTcdCMW+aZCZ4zf2m5F0konBrm/iGxQ0Q4JI9Y0
         wWN0YnPdXFF1k+8np1j8YR+JJKPawO1JGbAaSyALlYfDo75aB4COProbrzVn1u3IHxZL
         /v9OR212tie3yJCTluGQsprUTLJxD8E1wsIgK411kLE5+6lZdzDJGHHTV913m259/zTc
         rD0wicb1YO5xUCeubMqtmaVxXY+0IPWsCk+7MUdEw+oE8PFIdD+Xe4pxg5j6fEdUKG3o
         1P9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337809; x=1727942609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znlor91B2IZ8C7sZbCPoTy3JnLr5Yrwkd/pP2EeuZeY=;
        b=WL1xoEBD6SqLKBiZqjw1lITERohYB3EYV0AXiZXhQEjE7F13aug8Z1s3WVR4gy4I9C
         E8qy0NN05HZrJ7ZwJU6/3e66HUeHWkJdHSeDzTUZ4FuYtUXkO6RABvJPXccFlGSKnqlI
         J7L8AygG9TMnSjjvP7orFbPTmbFDeQ4qcp7/sT8rBI+xR0xHDpNveEzY0teb9lf08LwG
         vu24J4LSEsyZfr6bg2OxHNk0dGZCN3ZhiYAq2Y0a3L7zA9uqD77xb86lChi2LaGdNggG
         ajpniJgSdUgEhRVSLhS0eGYo2vZrQqvX5HsY0J7nz9oS2NfHLgfOOZCtN42xcQ/Hy7n4
         3vsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlySXjhNEYuR6xyDHwM89Dg0/RrPflGhlziEFa1r5jJJaDcIV3+i01YVPdU1nIJWurpx2uE7OIdITr6JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7C1/FlAetmoUMhMEn1SllS6VVC7MRYj5bz75Ut5zW+YyheVE4
	jUbPnWrouQgG01Tx1UUHdSFLgkNq1XT6attkGD31o6WJM18ZxF9PuR5hhnfp1adNgw0ZyU1l5i+
	S/KU=
X-Google-Smtp-Source: AGHT+IHMIhmfgmAe3U5f3gtwB8rFxcu9T3slLbnMISPl7wAXDk4+febZ1nCXRiowbsDmc9/xOp8e9A==
X-Received: by 2002:a05:6512:158f:b0:536:5515:e9bc with SMTP id 2adb3069b0e04-5387755eee8mr3414752e87.46.1727337808764;
        Thu, 26 Sep 2024 01:03:28 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:03:27 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 31/36] armv8: cpu: Enable ACPI parking protocol
Date: Thu, 26 Sep 2024 09:59:19 +0200
Message-ID: <20240926080021.148031-32-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the generic entry point code to support the ACPI parking protocol.
The ACPI parking protocol can be used when PSCI is not available to bring
up secondary CPU cores.

When enabled secondary CPUs will enter U-Boot proper and spin in their own
4KiB reserved memory page, which also acts as mailbox with the OS to
release the CPU.

TEST: Boots all CPUs on qemu-system-aarch64 -machine raspi4b

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/cpu/armv8/start.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 7461280261..544a4a5364 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -178,6 +178,18 @@ pie_fixup_done:
 	branch_if_master x0, master_cpu
 	b	spin_table_secondary_jump
 	/* never return */
+#elif defined(CONFIG_ACPI_PARKING_PROTOCOL) && !defined(CONFIG_SPL_BUILD)
+	branch_if_master x0, master_cpu
+	/*
+	 * Waits for ACPI parking protocol memory to be allocated and the spin-table
+	 * code to be written. Once ready the secondary CPUs will jump and spin in
+	 * their own 4KiB memory region, which is also used as mailbox, until released
+	 * by the OS.
+	 * The mechanism is similar to the DT enable-method = "spin-table", but works
+	 * with ACPI enabled platforms.
+	 */
+	b	acpi_pp_secondary_jump
+	/* never return */
 #elif defined(CONFIG_ARMV8_MULTIENTRY)
 	branch_if_master x0, master_cpu
 
-- 
2.46.0


