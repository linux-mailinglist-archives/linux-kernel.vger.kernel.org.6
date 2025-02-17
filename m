Return-Path: <linux-kernel+bounces-516901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920BBA3797A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4098C7A201A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 01:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDCC2AF0A;
	Mon, 17 Feb 2025 01:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX8+r1ll"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8847B33DF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739756246; cv=none; b=TeV1YnJ09L7WgX/r5Fpc8RsPechnws/RZUVRYJCKrDZwyUd4Ky8O8xQ8JqpisBuAgxjFcyDiaD+qtEA+qzPuGbpniUz4qGB/zGrum6rlswIrbsbtWEAVQLKMgOvjRsYGchwBuN8UK+7e0jBOjiMfBn33Ijxdbx0WgaEVmb2DQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739756246; c=relaxed/simple;
	bh=eLVSF+w4PvW+9xUeDykBSTZYRdr2YQtbOzBbRR4a2P4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=soP3SpO80/d5RNlkdgw1alp7aT7mKfITsnHeVidhACYws2sHiSwUq0o1LkoimMshwLdgxxqRVZr210Ofgi0oXY/cqTYmXCE6VS6YliidaG4fATftt9RWo6MMEVnFhDKT1wSAAlttgG6IYzJS6N52SwTARaHcUCAiPjfZX5G+tnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aX8+r1ll; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c665ef4cso56424935ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 17:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739756245; x=1740361045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uV4L5jUISNpRr6ROGYxEb4g1bNSE7HH22+hTjn/R0r8=;
        b=aX8+r1llAGLtLVC6md78y1DqwLWgQz1H06ef3d7ykcDVgCfHUFWe5NzQ5soclgYkHn
         qY57ehvvbQLBWxHPCdUQMVICr5Kvqz+k27og0hEVntCDXbKjGC7Xg076ZfADzYfk4grd
         7Qb/4154Ag+NRMqsiAiOoAt5+5jERybSEzX0tT9WiLJSqZYO5TxRqnb+hgiQah2yrUrN
         9RW/qB7a/ZxY0490nNO/KmGkwtJn6vPgMLn66vzmzYDpJWwzSCuiGrlhtC0rknIxxRws
         LnPl/f784QzyZJP69NQbHdk2/VPz5Xacb/I70/nexgJwt/DnhvzcKOktVYDP0RjiTFZi
         6I0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739756245; x=1740361045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uV4L5jUISNpRr6ROGYxEb4g1bNSE7HH22+hTjn/R0r8=;
        b=N+F3pukPvasdqsL8c95sx+gCr4vrPh1y31BX+pW8VwHwZ3UKRSxpB+s3vM2aHcY7kz
         tawB6hyAuJM2NnNgC3YMmQH6PPv1EmSUrgQoAOQPeXjUqBfGYaE/wASTMl0Jw3dpKqkC
         BE68/HEdJMSKK/ly8RTZ4rKQS+l9Se65hf82is/dwi2qcZjK6X0FNpQxLGu1dUZmCx9b
         PvTGwSAdxl98u8MNOpu7GSElO2J0Q5hdiSe9CJhEd7b2/jR1N2vwXYeq+ZGMuVSb04dr
         JyySbTLeXogkE8KKDhGoKI7/Cy/3Ag5g6WKoCQnlvd2LFrUMvfGQ3QawAH4e+LCPLIjD
         H6ew==
X-Forwarded-Encrypted: i=1; AJvYcCU0lNdfQLpqPs2bg0qXKJygiD4JyEMaAQiCYq4fug3J6DFDdTqC7pKxn+7ylt0h/D8nNbJLvcwXjrOyoew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm7Q0JOB+TmtI34laEt7gLAFQbEk2olzEykf2PlHn97G+Eb8hu
	zlgl35/BkRvhXE41fwv/2GsKdrRW/17t0+mv0hxxrWUub2K2ucw/
X-Gm-Gg: ASbGnct3hwzw0YaaBs1IKDLcKgIkBkpcSXdtKTWD+WVfnY7nB1umI0cp2beOFqeb0ab
	wB2MzrAfszKUDn4rwxZkw42y42qlwtscfve7CyzkaqiCqqgNBven2rCOdKfBySxeaQocX2GOouj
	L5DXxQoRRbSPYE5cSSB4PTWAARvFuT0pAvn3VxWCDDVTYyKFK0caus8UxqE2qms37aTWKLkLJ9g
	ONKGFaG/QiVm6uqsKogaEG+qAz7YLvWDeIONlqRabN/necKJITh4Jk81DGW8qvRFDF5+h3hxBC5
	s6qKhlQsM0nVmkvtUQS46cs8YYVDHxYGBFflisDDVcMdsQ==
X-Google-Smtp-Source: AGHT+IEc3R7zwoSDQnuMy8iXmbawDrNUKkHjCWCg51IKpm6c13c/5MWkj3/6lYaWg28BLnY8gooisQ==
X-Received: by 2002:a17:903:2286:b0:220:fce7:d3a6 with SMTP id d9443c01a7336-2211c551bdcmr71159795ad.23.1739756244671;
        Sun, 16 Feb 2025 17:37:24 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f8682181sm38167335ad.209.2025.02.16.17.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 17:37:24 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [RFC PATCH] riscv: Optimize gcd() performance by selecting CPU_NO_EFFICIENT_FFS
Date: Mon, 17 Feb 2025 09:37:08 +0800
Message-Id: <20250217013708.1932496-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the Zbb extension is not supported, ffs() falls back to a software
implementation instead of leveraging the hardware ctz instruction for
fast computation. In such cases, selecting CPU_NO_EFFICIENT_FFS
optimizes the efficiency of gcd().

The implementation of gcd() depends on the CPU_NO_EFFICIENT_FFS option.
With hardware support for ffs, the binary GCD algorithm is used.
Without it, the odd-even GCD algorithm is employed for better
performance.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Although selecting NO_EFFICIENT_FFS seems reasonable without ctz
instructions, this patch hasn't been tested on real hardware. We'd
greatly appreciate it if someone could help test and provide
performance numbers!

 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..2dd3699ad09b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -91,6 +91,7 @@ config RISCV
 	select CLINT_TIMER if RISCV_M_MODE
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select CPU_NO_EFFICIENT_FFS if !RISCV_ISA_ZBB
 	select CPU_PM if CPU_IDLE || HIBERNATION || SUSPEND
 	select EDAC_SUPPORT
 	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
-- 
2.34.1


