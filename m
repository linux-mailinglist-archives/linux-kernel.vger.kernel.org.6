Return-Path: <linux-kernel+bounces-365556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C8899E457
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0800B22797
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B08E1E378F;
	Tue, 15 Oct 2024 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KElldYWd"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A4F1E32D0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988917; cv=none; b=Y9JoPFVIw5YcxqX/fdL+k94YqV5tz8+VIT1zZpHOzg+CeUcJGvZRqOa4BhGc3C/bpGaFdvSKWB2uXYEK8GWUM1Nj/aJsSWXNr7RevmG56vkUN6yGWGAKTAZebADq4HezRbgXV18BAve822FAs4l2jwkZwgB1Y9IALxlZUq07+MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988917; c=relaxed/simple;
	bh=4CDxSBNEUNoDsuryRsMxV6AINxQDov0wsGmITwpQQ5Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eY7mNLmISVkM3QnTd6rTksrw7yqaRWOTP9S/3rmDWMjGMJmXvSF3d24eyVACtboDV9vNhJClnVPOojlk6m12SvmIXHelo9VEoNxY/vI3tmhH0WCzIdoaoIMzOvyZO0SNSc3xqkNNjydPvgAM7HFREjj4wzGBBwpHwOVvH5O1p3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KElldYWd; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4311c681dfcso27582605e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728988914; x=1729593714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L+2TeSEOAq3mZA+06DmXhg/TmVjMwFJKq0Mn1/ZAU14=;
        b=KElldYWdXyIKW3iFaMnoeUjNdUgn5H1pBK16kKsz0H0Q3dL6sGvuqfFxlpQeMc0syi
         iYsXRM8xTz0mvsyohWCBddIprWxxVDqrSYCtXyAK4L7vNIaSaaNWA9tNEMPpq1aauAtR
         NYvlAcH69wMp5dAUfYJPqp2zKTKZKyBkjxoy/u6H/1kF4Kt3ZzGV8bvhPMbLLF6kjW0O
         X5Cbx65Mtpo+3irCnqUSE8wXb7gfg6ak7g4O5qtRPixfxQ82165nccm9qLIaW24pgtZ4
         MAP1IW4fItPf5LN7Mpuukgc3sm/2J5PDfUpnfG58RZuTw1s5/3y9qX3ysNGNmiU6oso9
         Gsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728988914; x=1729593714;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+2TeSEOAq3mZA+06DmXhg/TmVjMwFJKq0Mn1/ZAU14=;
        b=VM/fqaxjwf7dXPLvpEMligVxdNcmfSA1C8FR9I2Eyk3NWefrBhBDw9JfAXGDKmpNrw
         UxHjYTnm6F1lpyFhiKKqRAQ7HW/ZtEiQfQByD5ckh5OgAwGVaJzzJdsGMcTaGC0Nbd8/
         zKefWROK0FRsmWI8rb2NrSuBph60fQEvnjeIB1oofGYO9fInwIb0/miTMHlIyacUlzU8
         gmiwBSN7F8HrNJNF6LxadgZHMn46EuJbPMY7sPGZ2dY45WglF9fo0NRvYdRk6SDRoVGX
         //0k+eVE0sMbPtZQuYyVA8C68t3c/+rgiIpBG80Cx3Y2COqSZul01luRTyiSwvwHodEP
         wDcA==
X-Gm-Message-State: AOJu0Yxd7SZuDnng60CVob6o0ADwjxYcAtNCp4l1d+yPUczy3xw4alKe
	hbCzPcdqed/Esg5oP7P9NTLLpBZ+mGeQJzX8tzfjtY0wvbhHoUlNrresZYodomwJDH8jLw==
X-Google-Smtp-Source: AGHT+IE5rC1KQjF0XqZu3kluvpF6mqicCJ7dllaP88Y2Wmm+1tL/LvfGQLVme4ZCXf/c4xYWlRksmYIg
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:600c:4301:b0:42c:ac8c:9725 with SMTP id
 5b1f17b1804b1-4314a3cdd84mr425e9.8.1728988914149; Tue, 15 Oct 2024 03:41:54
 -0700 (PDT)
Date: Tue, 15 Oct 2024 12:41:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=ardb@kernel.org;
 h=from:subject; bh=rQmohYKx9m4loPLy8qUR8hfayoHC17fyhkwhZbzWsrY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ3P7VHN2dDleUs1DvoZnzTIPPCjbV7Cd70jM28YGpdnN
 gXcLFDoKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZZcXIsPXQ6agjR94x9r/Z
 XrZ02pus98kqedblq/1sz1oZy3c4L2f473T0wfpniZFTT72TuzDtj9j29ksJLu/Dj+66vtfz380 4X3YA
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015104138.2875879-4-ardb+git@google.com>
Subject: [PATCH 0/2] arm64: Speed up CRC-32 using PMULL instructions
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, will@kernel.org, catalin.marinas@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The CRC-32 code is library code, and is not part of the crypto
subsystem. This means that callers may not generally be aware of the
kind of implementation that backs it, and so we've refrained from using
FP/SIMD code in the past, as it disables preemption, and this may incur
scheduling latencies that the caller did not anticipate.

This was solved a while ago, and on arm64, kernel mode FP/SIMD no longer
disables preemption.

This means we can happily use PMULL instructions in the CRC-32 library
code, which permits an optimization to be implemented that results in a
speedup of 2 - 2.8x for inputs >1k in size (on Apple M2)

Patch #1 implements some prepwork to handle the scalar CRC-32
alternatives patching in C code.

Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Kees Cook <kees@kernel.org>

Ard Biesheuvel (2):
  arm64/lib: Handle CRC-32 alternative in C code
  arm64/crc32: Implement 4-way interleave using PMULL

 arch/arm64/lib/Makefile      |   2 +-
 arch/arm64/lib/crc32-glue.c  |  70 ++++++
 arch/arm64/lib/crc32-pmull.S | 240 ++++++++++++++++++++
 arch/arm64/lib/crc32.S       |  21 +-
 4 files changed, 317 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/lib/crc32-glue.c
 create mode 100644 arch/arm64/lib/crc32-pmull.S

-- 
2.47.0.rc1.288.g06298d1525-goog


