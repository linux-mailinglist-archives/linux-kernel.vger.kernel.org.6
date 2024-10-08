Return-Path: <linux-kernel+bounces-356072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3192C995BD8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05391F2506C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72E22139CB;
	Tue,  8 Oct 2024 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsRykgwA"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DDD18C910
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728431253; cv=none; b=ZrbABHFuEyQ8G/fRca0piFym6a23T0VdBmLjVyaeUYlTirqfUwiIwxLItRNd1uWiT110LOcmTech48V/OagQt+DjFgzrnEADa2juRQHtG1bVEfq3ca4aX4pK2uASNZppzWlTFVBsqRKjBu4kxeOdOIakSS7ubKNDMDb/+zcNCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728431253; c=relaxed/simple;
	bh=SM07LGVIhQad81X2BWBjaUjjnQCOyLcEhQITfPx46Go=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b13JDkfhc9G3mx+CWOtkgkO5ubriYkZzCuXewiBHaPvuLeoM5jhALPucWPZoMCRdJGfLvJdnSGD7hO/4Twm9eb7CSvf9tlaxSpBNlLfTa84ZVGN4J33zHJaVqB41ZhFUrtrtyQYoXseotO4loW4pWZLW8QJDmXrq1X9Ht/xldWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MsRykgwA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e048c1595so2697297b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 16:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728431251; x=1729036051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4FOCtXVViCYbwEjFH995uk0EVt0p8fxybChaadmfmgc=;
        b=MsRykgwAZU6VzNWqkDRAFv0wqLk8RyWDInjljdkyMsb2Ma+qgF4RM5Eb4+VStG+A9D
         Yb/g33GbTk71GZSbOwasnfZaVBRq1Nf3SSKVBTrpTHnarQeLaLvE50BNC0UTtADIjNzj
         M+QEO+ZZLTpn+QP8iKqTKZ53K9oTfB2yr1Lp6fNxE8uhZYHJ2G5475YLvpsaQdbkgtCn
         hQN7VI1tPX/uTr+YP+VqtDANvXPRfGGOiXcb8cMbHD1rHOUHjDGHTGIS3KApWUxgAm/s
         8iuKTooUn3RjNasfIKVuquqqa8nTtp9VX9Ig3IxD6+E+UvP81VXOHCFD9VtnyCHLDrmJ
         J0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728431251; x=1729036051;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4FOCtXVViCYbwEjFH995uk0EVt0p8fxybChaadmfmgc=;
        b=eHqMbtmyMGO2v5qcJgoU5IFGTp8BTKBko24Qwzr+fwjnDUFcDc3a5tyeQTGKbyd5bA
         mtvupvkokSZJTs7hn93NzjPOZQcjcM4FI5idulZc9QcLvyrwA8E4wgT88RFB0FpLOySs
         3Ro3a99de3bUcEBd/NwH3cyeWdbPzNY+YMV+6DEBS2BDKLandQ8X2fo0Vf7uD1Fw/glI
         WI5AkkMvJH+z4RWatGWHb+vZbLg/tQduhAhFU4xV4Tw1veecC85A8seSmFJIAZbRn/VK
         0jffqe0Gq+ZKrINX6oXLYpxe11w7Rg4vXPt6BC1FMFsTQCerxpEanWXz7vs7UeNmsejS
         sN8A==
X-Forwarded-Encrypted: i=1; AJvYcCWA1vd7Mh2cq3rQNsqJdB/YMpKUhI7nbVrcM3FKlcGTMeE5Yilm1SGaeGtjS4c4yiafxdbzlUfb5/kM7KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGl0f/HvbvhAYb8M1ZMlnJtPOUKcoiIyRt5njBQPUTKdTZul3G
	L4V4CcExvEGlsA7VYB5nvDE6lnIRxfrmV9iicBkD57BB3M1DeXgAnt+5WWrRNDUEUhT2Jg==
X-Google-Smtp-Source: AGHT+IECBLQqdj2Apw7/j32hBKWVrOw5HFu7p/O3VtHlpp0gf+ibuVpTEfPMcIxMNU5GUubBmpIcApB2
X-Received: from elsk.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:dbd])
 (user=elsk job=sendgmr) by 2002:a05:6a00:66cd:b0:71e:d00:c7aa with SMTP id
 d2e1a72fcca58-71e1dbfe6acmr1306b3a.6.1728431250789; Tue, 08 Oct 2024 16:47:30
 -0700 (PDT)
Date: Tue,  8 Oct 2024 23:47:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008234718.17127-1-elsk@google.com>
Subject: [PATCH v1 RESEND] objtool: Also include tools/include/uapi
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


