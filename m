Return-Path: <linux-kernel+bounces-331233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E70297AA3A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 03:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C411F2669D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 01:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23599125D5;
	Tue, 17 Sep 2024 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RvDxMLqg"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D473A920
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726536493; cv=none; b=hXAfczuo2krgD6kzVBwWWE9GVo9HZSUDVa8/mwEoG9sVhK6OFbxGHLfSq78Rlz2M+Nivae/+vE/VGZK81CNvVst73zXBRLixOaRW0aaQC6IY5BCDiMC3QiO4SweEnxTU4lHHeKisursU7Aqxl1QP9SHEbZ71aWiduUnvfdpAjBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726536493; c=relaxed/simple;
	bh=SM07LGVIhQad81X2BWBjaUjjnQCOyLcEhQITfPx46Go=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ju7GBza4JBhE8zeM9itPEg/GVYjiBNGveqKtRocT4G2qxvw12mUA4b4lf4NpNXmmAHitdiVuITOpJzcNxv6g8z0bEoLqwrMVOV2lQQwnZEGLxoX74pChMqKfpiwnWW8tFa9x8QvOkX/5y1S152SOBx/R7CBySGF1a+t6HtWFj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RvDxMLqg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-718ea25967eso6407761b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 18:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726536491; x=1727141291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4FOCtXVViCYbwEjFH995uk0EVt0p8fxybChaadmfmgc=;
        b=RvDxMLqgBbbgp0mSpfrXDLeu2rbYg3O2hicM7MV3F5ACrdJLmVFduVQb5NF8Dy76/T
         NfGXJ9OLtHlhMqBIXuyYJ0UeajZXzgiuFr/A+ly8izcls8uOgFxnW1+eGxeUxNdS2oLG
         rX/mOjq7t9jU/tb/APf8IfC/FSQ2Ritx5RWuadpfDnsfgtSOCyHm8zfHLlTizdNVXgKZ
         r8t4ZLYvj5BQJdh0jCSx4kKvjYVKPKhwBkxrLwYmWpVogUCPo8NHh4A5f9DPf5xqLf4q
         ZX6dRHITuHWK5ugzljMGJgrFqpHNJbVhmWRfnFq1k6kRXwiU6pC462T9BKS9tuQc2y3B
         kUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726536491; x=1727141291;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4FOCtXVViCYbwEjFH995uk0EVt0p8fxybChaadmfmgc=;
        b=LasByjUY3RUipmyLf8LJQzPGnoXTBzMEGR80fyGbX0e9Duw1dXyfvEsgJspoP3+y8R
         XHPbzHEqMXKmF2AwIzJGVQsgViDd3kBiAXoMPFTSNRhs/aV6CoXEXMetUWR8VYbmX0V+
         NLrRvGkVY7NncTDntlYfy1F9GlSkQEHWs+3S7dna6X5Wst/4iX3D+1Feyp2slfmC8QRk
         OZF6CqWdx79kRXd+jmHGuI3fLeGSD+O+2PXZSaYA+FAcx33PslQj9DTPLpCPBqCgiZvn
         WtWXjL0fmlEolKX+l/hbgTrOD7pxyrpCZIP5oe6oNLEKxGDhMqVB9lQbmJpUs0Oog9nz
         Ad6g==
X-Forwarded-Encrypted: i=1; AJvYcCUGit41unibLSYUXTYUn+tGh9TVoFev9IxQ/mBEXjl71xeVNUoQF3tknrpu1biE/dHrcCzzXmrd9aokIOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDKcoF43NMtGDzt6I+d4N7s/LhQQTHIihZJmfMC9PvynkBYw/O
	WoNri3xEDvejynqlQrhfoMx+2XtFMQ7Me7DhtAz/j7NtbnVAj4D3ToFJBxb9iZZD5GCtQg==
X-Google-Smtp-Source: AGHT+IHIIQrNzAZxLMW/af3mAH10opfLxjiEABvdXiYnHblHsidRk/RHPP9A70FqDwS/47GJn8xRn0bu
X-Received: from elsk.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:dbd])
 (user=elsk job=sendgmr) by 2002:a05:6a00:6f09:b0:718:dfec:9570 with SMTP id
 d2e1a72fcca58-719263748bbmr34570b3a.6.1726536491037; Mon, 16 Sep 2024
 18:28:11 -0700 (PDT)
Date: Tue, 17 Sep 2024 01:28:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240917012808.24037-1-elsk@google.com>
Subject: [PATCH v1] objtool: Also include tools/include/uapi
From: HONG Yifan <elsk@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: HONG Yifan <elsk@google.com>, kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When building objtool against a sysroot that contains a stripped down
version of the UAPI headers, the following error happens:

    In file included from arch/x86/decode.c:10:
    In file included from .../tools/arch/x86/include/asm/insn.h:10:
    In file included from <sysroot>/include/asm/byteorder.h:9:
    In file included from <sysroot>/include/linux/byteorder/little_endian.h:15:
    In file included from <sysroot>/include/linux/stddef.h:9:
    In file included from .../tools/include/linux/compiler_types.h:36:
    .../tools/include/linux/compiler-gcc.h:3:2: error: "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
        3 | #error "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
        |  ^
    1 error generated.

As hinted by the error, this is because <sysroot>/include/linux/stddef.h
(a stripped-down version of uapi/include/linux/stddef.h) includes
linux/compiler_types.h directly. However, this gets resolved to
tools/include/linux/compiler_types.h, which is not expected to be
included directly.

To resolve this, I added tools/include/uapi to the include paths when
building objtool. With this trick, linux/stddef.h is resolved to
tools/include/uapi/linux/stddef.h, which doesn't include
linux/compiler_types.h.

Signed-off-by: HONG Yifan <elsk@google.com>
---
 tools/objtool/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index bf7f7f84ac62..f56e27727534 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -24,6 +24,7 @@ LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lel
 all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
+	    -I$(srctree)/tools/include/uapi \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/arch/$(SRCARCH)/include	\
 	    -I$(srctree)/tools/objtool/include \
-- 
2.46.0.662.g92d0881bb0-goog


