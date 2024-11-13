Return-Path: <linux-kernel+bounces-407147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F5A9C6966
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0978B24616
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30F617A922;
	Wed, 13 Nov 2024 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xIUrtFq1"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114314F9FD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731480034; cv=none; b=ZYtq1SeJYad64u0E12idm2AHFeXPWwubL9rLR6MkZYleR3vrpAXy2JpIGLqwncnSSJ2VuHybvDhjFpoLVR9TiyUrgiS+hIjLJKMzvYI9RPawLzClFmpOCtVWInpz0qsmj8zIdXqDeCFij7LxMK8QUPUQ0+qX4vlCBQiRraUhSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731480034; c=relaxed/simple;
	bh=BTQb3Aqzba+VuU8HFuNKP8De0BMaf26ZABtVn+f5J1k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=FBUKXYSe66L2dP5dyyIFSb+GyR5jzOTnp34xYEk+6EmllALuwFUc5USEr/CRGMf68MnP0zyzmNQeyFw3f8J/rh6PaAwk6SVvfis6UHn9PrBhsdn7IuFoIaViXIcEljc5G7a1jsGw0wCpduBpehkjooG4MJaxUFAWLLH0iB+ARxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xIUrtFq1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fc60660dso9979487276.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 22:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731480032; x=1732084832; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zFLURkxgpxBeIaScnMadsMNzUT+ybEKq/kTtVqTyU90=;
        b=xIUrtFq1iLYlQy/S9GbzgvWaATV1gKuRY1n3S1Ts8gWVzVYudjU1b4qZ2idxSW915N
         E9PeS42TXJ8lx0Cky3n2zrelCZ7ZmpG6KNqFis0eoInIcHdMQS82zXbR09jYwiwRpgNW
         PJE/YeLLl3ldYBnYh06zxBFemvxRrf4FPyF5f2cm3hg68xgFYf3F6GlPT91gCLWbRCJw
         SuFzTjFgoy+c6yAZlILEClvMCchhVuI6CvgM+5cssAaL7I0S0sLAbkKYCPk/jXzt9KLU
         h9D70zvWO7IoK0uGg1zYQIRsolKhosOsBWMDb824Fpm/8iNSJ/LNsKAOOM2fGDV4VJV9
         fzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731480032; x=1732084832;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFLURkxgpxBeIaScnMadsMNzUT+ybEKq/kTtVqTyU90=;
        b=rMOdI4o1fqhOp8fR6HXQRmOmICG+JnfkNf0zM/HehcQihh9zS+XkmJASCvlwIxMDlG
         05m+yeBVnDc8OHJBjr2oKVC4SSHjqolAS2vGl+T5W9WXQXqx0Qays+0WSKIWgoWNlG9C
         IZV5tSA9UsEyA9sQESSThY078iHsMNmPh4TK0qVB50t30w0Iu389tRi67J8oveJ1rZ94
         mE2MNgHsyJTkHgpFR68qGa0iN4UCepl+T4QhY2AV4ujrw2g4bKyLf3qX+H4xkSusv6as
         ZUow05GDxe0bKF5/B6tqVBZIzmdrhsHf6sA8+cwQMea3L8IIPvZEJU9BqR64hb7s3sSP
         46ww==
X-Forwarded-Encrypted: i=1; AJvYcCWOpC2FHiUgSXWidzbADBxkEasEmRyQnC/LZ1ZESEoM+DL1iiqTNStkKJkcZOUZZM/3rPDvZJoGfF7TBRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyamz5xMSTbIlmnkiY84nfHcPbffm91UWg8Ml1bsBQKz5QQsWqN
	0+6XdDSh0ik7F5WgHFol3ZmfyMYDsB8a83URSJzgM/vQotu5YdxqHHdqMgUdNFdzfg==
X-Google-Smtp-Source: AGHT+IFM190sQ1yES0a/wzrqtAVZbGHaEHkL/1MT8K0SGihiUhbIc1ChURMy/i/StLTFyRBcAmYJbkU=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a25:aa53:0:b0:e2b:ce2f:787a with SMTP id
 3f1490d57ef6-e337f861f01mr53075276.3.1731480032024; Tue, 12 Nov 2024 22:40:32
 -0800 (PST)
Date: Tue, 12 Nov 2024 22:40:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241113064028.2795128-1-xur@google.com>
Subject: [PATCH v2] MIPS: move _stext definition to vmlinux.lds.S
From: Rong Xu <xur@google.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Klara Modin <klarasmodin@gmail.com>, 
	Rong Xu <xur@google.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The _stext symbol is intended to reference the start of the text section.
However, it currently relies on a fragile link order because the existing
EXPORT(_stext) resides within the .text section, which is not guaranteed
to be placed first.

Move the _stext definition to the linker script to enforce an explicit
ordering.

Signed-off-by: Rong Xu <xur@google.com>
Reported-by: Klara Modin <klarasmodin@gmail.com>
Tested-by: Klara Modin <klarasmodin@gmail.com>
---
V2 Changelog:
Incorporated Masahiro Yamada's suggestions:
1. Refined the commit message
2. Removed unnecessary comments
3. Use a standardized way for _stext definition
---
 arch/mips/kernel/head.S        | 2 --
 arch/mips/kernel/vmlinux.lds.S | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index b825ed4476c7..e90695b2b60e 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -67,8 +67,6 @@
 	.fill	0x400
 #endif
 
-EXPORT(_stext)
-
 #ifdef CONFIG_BOOT_RAW
 	/*
 	 * Give us a fighting chance of running if execution beings at the
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 9ff55cb80a64..d575f945d422 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -60,6 +60,7 @@ SECTIONS
 	. = LINKER_LOAD_ADDRESS;
 	/* read-only */
 	_text = .;	/* Text and read-only data */
+	_stext = .;
 	.text : {
 		TEXT_TEXT
 		SCHED_TEXT

base-commit: 06513ddaf77b8f49ef8540c92d92c9ef0ad49426
-- 
2.47.0.338.g60cca15819-goog


