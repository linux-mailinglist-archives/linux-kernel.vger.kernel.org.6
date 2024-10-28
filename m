Return-Path: <linux-kernel+bounces-385423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B2B9B3702
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F751C2233F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9812A2746C;
	Mon, 28 Oct 2024 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je6I7XMX"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE891DF75E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133949; cv=none; b=XuX1+CzMc3hrAUK+9hydTw5pXHtbE3mM0vxP3OF/cn+0EduGHv49w14xX4lXMa/Xtr0naw4zAIUn8gWrom780CZAwEV07p5mT1CGp+HtIeUUTKlShxm+xPXaGU31g7G7AzvToax5I/UQQPwmDgFeyXGE6G/owYbU0YNk0rkvpsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133949; c=relaxed/simple;
	bh=ojmokTyZtakRLxuXdkNlzqdgMlpn9pVusX68Zup4+y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmqxeNLbHpfJnBthpBUvPzuweueODuoM/OXrf4Ihf08YF+grPHmYJocKvgqPI4wjeFZVuICE+CvUZ2AQddds3y8I6uEUn6XLDbGh+VbmL8mJ4WmYsKVmd7zIsucB71lCfs4bly2vKuysEa9LTGYVeQ/YlzDkxOMUag3qNOCyO0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je6I7XMX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c97c7852e8so6515300a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730133945; x=1730738745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LuLaC5IU7jaROXQUz4BZyL0Cquw/IPrNXye1UNlLcSg=;
        b=Je6I7XMXeMhQ5wa3DV0xExkz9oP2XKLe9gJR4FBp6wi3aOdkiokKpR8Mf/FI8+7ePi
         XXVl0jOTS8HAG/qQKV0J9xMGPqxuSXD5gYViXaOEJycx/l8+8puRg7ogfgsPpwo0NoDm
         Kz5/1r3GP8hkI/g1aXmG5h0U9OEEcZR+l8vm9O4wPORqiSSOj23SqaapoaZK2DNyPFvW
         T3V28ChPmgdEixCf/SlS0pBCYFyJw9b0f9J5xAuH2Guje7sr44OZAkOih1mXLVl3ri6G
         euuzTRQ0P7aXQXadbkQAkKnrsxVSxrbQEnytwyWCE5mQTLt0xi5W73hTk3u7FPEHOY9y
         34qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133945; x=1730738745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuLaC5IU7jaROXQUz4BZyL0Cquw/IPrNXye1UNlLcSg=;
        b=edb+/PdOugkOqgs5gUeLKbjduBGXRdyzzDUjteAMmSEY1cndQHo6gW6I+yXHRyS4lB
         jOtDMR43fCdxoasLwTz/byuDhgROr4bBwHWr3v+RNcny1hk9BTSjDq8LqRu8RNncoUeg
         9r4JVcBb/GKPCyjZbMTPjpSHLEH7YgOl91wu9RSvPE+rmPZB7jIp89uxo2OhSYPErtXS
         mTlo5qzFGZci6++S3Oj8AIFf1LjRp8CJFJf/V5JdcBARnK88TAEO+WS2UTgpY7vohlbQ
         taQKJkXGSUODVLbw6aMmSi4dx15gNuXOLdnqh3Eg74rUekqWWHOPKGX8zWuYa6bOxsFQ
         BIKw==
X-Forwarded-Encrypted: i=1; AJvYcCUyeZ8u48zmg9ddoJJ4B7kWMilRYuQmQkDy92v3QjhHVO5JgraGqnvPvBkvcisEOf1ioGfNtc+AFATy43k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXenuuvtPTOACdzJI8fmi5bqetM42oVbsTUeTLxwyFVNeKKak3
	Uir8SJalyxm2wBN5NhoBqusMQAQr4w+v2YNJ7UvuSXG7yJXQMxcbopk7DA==
X-Google-Smtp-Source: AGHT+IGux9dMS9ndm0VsBfxmhz/vXhtHIVFXWOY1+ylV2RNZRuGaRt9GNADP/DYzl91WYIJvhUpycQ==
X-Received: by 2002:a05:6402:2b91:b0:5cb:78c4:7942 with SMTP id 4fb4d7f45d1cf-5cbbfa63aefmr6561696a12.29.1730133944937;
        Mon, 28 Oct 2024 09:45:44 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb629d2casm3274387a12.32.2024.10.28.09.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:45:43 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip] x86/percpu: Construct __percpu_seg_override from __percpu_seg
Date: Mon, 28 Oct 2024 17:45:16 +0100
Message-ID: <20241028164535.318303-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Construct __percpu_seg_override macro from __percpu_seg by
concatenating the later with __seg_ prefix to reduce ifdeffery.

The change also simplifies a future follow-up patch that removes
CONFIG_CC_HAS_NAMED_AS when the minimum GCC compiler version
gets raised to 8.1.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/percpu.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c55a79d5feae..c1a21cba70bf 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -28,6 +28,7 @@
 
 #else /* !__ASSEMBLY__: */
 
+#include <linux/args.h>
 #include <linux/build_bug.h>
 #include <linux/stringify.h>
 #include <asm/asm.h>
@@ -41,12 +42,7 @@
 # define __seg_fs		__attribute__((address_space(__seg_fs)))
 #endif
 
-#ifdef CONFIG_X86_64
-# define __percpu_seg_override	__seg_gs
-#else
-# define __percpu_seg_override	__seg_fs
-#endif
-
+#define __percpu_seg_override	CONCATENATE(__seg_, __percpu_seg)
 #define __percpu_prefix		""
 
 #else /* !CONFIG_CC_HAS_NAMED_AS: */
-- 
2.42.0


