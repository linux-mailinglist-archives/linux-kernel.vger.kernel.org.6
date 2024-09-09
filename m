Return-Path: <linux-kernel+bounces-320988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFA6971311
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3811F23847
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A142C1B2EE7;
	Mon,  9 Sep 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnX9IF+g"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B092F1B29D8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873302; cv=none; b=Pw6eyimz0FZe9BmrZtuysSBpfCX3E7hoj6B3h2Imtgs+knDPYjtgkgNv4oampBq7otdEc/UwqG2pXL/rW/RUW7hD2J7DggL25K43isFnF+Vs6XYiV/KTMw102Jm4Sp3nxJ2qXf8v99NnKRJ9YPOH6d6JFKDDS6k5WwX7sQDBPMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873302; c=relaxed/simple;
	bh=AUGbskrmfvCbMRfyZwjHYJ134pupCetagT3UQ1uZq3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oloQPycGSM8/ATH9e1vizU3UhpAA0PZVQGl/RWPzr/dMsy26fNdAbUJmt7wcp4+nZKhlsaXoAZdIGULJb6J7MTAK3tzztq2RHz2pWFrzYfE+Zjs+GHTLo5R2oF/liyR9Op4cJVdLAwa+nTVrs2yjNvKVDSWjokC5jPjq5SmnS8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnX9IF+g; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-710da656c0bso1031543a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 02:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725873300; x=1726478100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aY38wG8uRg5vqt8oTLPmwNTAVl1r38QXK8R8qBDLkRY=;
        b=AnX9IF+gxJLGJW0jcNWZ4Cc00PvhJTea6CDf5EllD8QfvMAQXiYHjTWP0WdhTTsore
         YadZXAfwNwQ12iZiQxlvwQSlTpe7/vCcuKnbjNriemQAqLAO5Z9hN/5vPqzDgZFw6LPO
         OZZ+h+Ix0B34w92djwbkRPQD7RlSzhBKZ28HRJaRSmiel0uRMbxoWmAELYJLqnMz3Nrx
         mV2M9TyCI3C8d2rknnSanTzY50ibtubIx/nkrTm7hPQYE+D3+ZppS1Yqaify2Ldj7JY+
         LMh19md+cj2sfC4L9vrsS+s8R1lRagnjbeCH8brzMO/PSekX5DNn6zFxGdcr3eW04q6c
         eqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725873300; x=1726478100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aY38wG8uRg5vqt8oTLPmwNTAVl1r38QXK8R8qBDLkRY=;
        b=sP70grLHVL6Ate6qvqoCOtP/Hp38UfZS8GR5BPkJ/cEDZyO1pjLEPMLRix9zKNJ/vT
         1cCXeOFHI8OXuTEvEkCHfWja4mIwC9MnLgoGNlu14XnLUl0SGVDqiiY6Nwp41SR4X26c
         CpMdXGyx5aW68GyjJUdR0DqTTQY5rw44NLJgPc4Eat8NBKUGbulhaG9bgRYON4EKet9r
         FudTS+0A19f0ADkvoiHePV9lo9gtohwS0EmNNqfv5mw085mO8Bndwalm1Z74BPUcjiNF
         kkpaGKWFJLVtiUu0AD1a8Jj0dCRsJjjUUnPkae/iDqAh8kN+XCeOmWj9SJzhIzmGqlFp
         esWA==
X-Forwarded-Encrypted: i=1; AJvYcCVvclmSZnPdXLer9+EtJlmK73Jrmoa4F9gwkPFgUpM50b3Rf1aUqVUXwHDNRItlbJS/COShQLI68fr00B8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx33WN1eXu0YOzTN6S5mBCAg8+4lyM3sKgMDf63VGpC8MZKvAp/
	TFPBHHCvj/zRXphhVvEwz9Che5GA+JWs+CAXetVxhYFYqtDfk4PgYxAL5lYU
X-Google-Smtp-Source: AGHT+IFQNtSa0KUHq0nxQ/Ce96vx5AH5SGtYdj0R/UvOyMgidrZ+WR4/FRxpx0xbeZ8BW/Ye2Atm5w==
X-Received: by 2002:a05:6830:6c17:b0:710:f223:3e32 with SMTP id 46e09a7af769-710f223411bmr466258a34.10.1725873299751;
        Mon, 09 Sep 2024 02:14:59 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e596882esm3120689b3a.135.2024.09.09.02.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:14:59 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: asahi@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 0/2] Disable 32-bit EL0 for Apple A10(X), T2
Date: Mon,  9 Sep 2024 17:09:58 +0800
Message-ID: <20240909091425.16258-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Apple's A10(X), T2 SoCs consists of pairs of performance and efficiency
cores. However, only one of the core types may be active at a given time,
and to software, it appears as logical cores that could switch between
P-mode and E-mode, depending on the p-state.

Unforunately, only the performance cores can execute 32-bit EL0. To
software, this results in logical cores that lose ability to execute
32-bit EL0 when the p-state is below a certain value.

Since these CPU cores only supported 16K pages, many AArch32
executables will not run anyways. This series disables 32-bit EL0 for
these SoCs.

Changes since v1:
  - Drop #ifdef CONFIG_ARCH_APPLE, the code to disable NV1 on M2 does
    not use it either.

  - Added comment to explain why 32-bit EL0 have to be disabled.

v1: https://lore.kernel.org/asahi/20240906171449.324354-1-towinchenmi@gmail.com

Nick Chan
---

Nick Chan (2):
  arm64: cputype: Add CPU types for A7-A11, T2 SoCs
  arm64: cpufeature: Pretend that Apple A10 family does not support
    32-bit EL0

 arch/arm64/include/asm/cputype.h | 42 +++++++++++++++++++++++---------
 arch/arm64/kernel/cpufeature.c   | 27 ++++++++++++++++++++
 2 files changed, 57 insertions(+), 12 deletions(-)


base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
-- 
2.46.0


