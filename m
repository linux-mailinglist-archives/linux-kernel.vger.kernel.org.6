Return-Path: <linux-kernel+bounces-331143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C419297A91B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFB11F28B16
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF3E15C131;
	Mon, 16 Sep 2024 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yVGBEOxH"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D265214885D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726524967; cv=none; b=eLq5tOCd2DtSsbcrnizjYondgjmfnxgqhIHIg3fLsjuFhZY5Bfrc9jyc5M2d3Dp27H+YoRFpcEFvPz9nPnWknlBBbyM5ZbFWQS80oO4xOEc6C0ZUpYFgAXmKxo8BgtWsZGM/U9QAMnSv1oBLfezdVp6vyAKDfV6PLs8Yz4FW1nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726524967; c=relaxed/simple;
	bh=a/CYzoyiyTYqxyaRI1+XfZbNFCG0nW5mkKxUaYDHDek=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QWfDFzUzvS2MsfpEEpc8juYTBeYZceaZ51RUqNrl9LRV0DiburgdWjB484Q0krSIkbrH6zrxeJd40A3hKA6SSKQk5OD/XWBAzJMly5UTS5sSuRbssOpYCa9I5H57PMdlRBNF7A5z26q4dEDxEkJXf5WppGkteVD6E11O/n/eueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yVGBEOxH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-207302f244aso45965885ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726524965; x=1727129765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8n7Jp6FXHVveLAJZ3oVyHEjTOsFYi1ZJhtN9OuWs38g=;
        b=yVGBEOxH/Ly+H0YeSELrg4XdDySw3e6tgnQcfKifatfrt7k24W+xKuRPlh9HxCRGXJ
         tUvv+qWwG/GZNhAYSk7PXzBPJ39ftm/we+olmLnDb88YkkVWz7fBuYTnbLsv20795HT4
         6thRu0G108/6hgreqqLuxt8qVwncp22LWy0kg+vKLZ6ZigLzeuAxJTkOKe9Xr2FvPkmc
         nzvC4BY9OLjeXGTnjbhYrSRzS0I7AHL+SvDfclmnfYZ6HwSoLYfVm/G7+l/4RlNPKkSQ
         OdHF7kl9NHbylw+kipOPCdLDApFet0RLgdiuTn57k+b9VxfnkP6J+Zsc7zWYxkC49SSH
         HpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726524965; x=1727129765;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8n7Jp6FXHVveLAJZ3oVyHEjTOsFYi1ZJhtN9OuWs38g=;
        b=RCYp9hthrHpeiLpbKJmzZ31Yum41/wsIHjML25kdCi+3A5L498esEpj7I6qxHwPrUi
         YbWd+KOXE+1Y8e/GzijvM6E6gT3B2EXJyV+75DdTjTliYo9GSBrKE7EDT3U1T0FQPnJn
         83f6wg+g4Gzeh2kdT7YPcBPxaAevt7+u8QhHkbcyyYxeXWKPvyQRQmds1aHgt4Z8bKjU
         fA28R93Emj0mI/gnYCGOSzO9PXp0T1NRrbRiZKUaRXZIVlNLzscgippU3QMtWqTYOaDP
         rS09LYRY06h8CqI0UjUM7ACfc4xxQveQ/OEjji9d20WgwIveZ+DzfVQxwvxhIT1G/f8/
         RP4w==
X-Forwarded-Encrypted: i=1; AJvYcCWQWzuNzbXsf1Jv78BNcG70nOmzO6f8nSNs6EFyj8NUIQjovSaUcXfG8Bb2dgz495enbHNDNmNJu1j9ZTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS4nyrXpEEwzwzMUzKwKrOTBavanXLxqcT61IngSQVP0sQN/3B
	dWzVRbvLHNBHJj9pmMjlAVg85EuAAhVOgc9wfMI3gGSReMFohN2ghQ116X+1pbjdJ+4t0DJox1z
	9tv+vpRKDjWHnT7EysaJP4MhleQ==
X-Google-Smtp-Source: AGHT+IFbXOgcMBi5dra7XRoap6d3Flff/7btwVMF42wsUonrECBkq1byGD0+nyRAgMXyuksdh0ANfJQ9psgm5Y9m6RM=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:903:2450:b0:206:9b0f:48d7 with
 SMTP id d9443c01a7336-2076e3f7779mr10596575ad.7.1726524964945; Mon, 16 Sep
 2024 15:16:04 -0700 (PDT)
Date: Mon, 16 Sep 2024 22:15:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=876; i=samitolvanen@google.com;
 h=from:subject; bh=a/CYzoyiyTYqxyaRI1+XfZbNFCG0nW5mkKxUaYDHDek=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDGkv1snW9d7fuZ8ha07VvnNfZv3a+6rK9O565uXXroaHc
 5ik19650lHKwiDGwSArpsjS8nX11t3fnVJffS6SgJnDygQyhIGLUwAmcmgqI8P7Z5qT9p1Ymn97
 73PNK73TTOe/v1DtkWgi33i32dzv3px1jAxNnA/Y+VeyvlNnKMjb+Ln4r5fqi1bBqS82HRf46K1 xcSsjAA==
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240916221557.846853-2-samitolvanen@google.com>
Subject: [PATCH] x86/ftrace: Include <asm/ptrace.h>
From: Sami Tolvanen <samitolvanen@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

<asm/ftrace.h> uses struct pt_regs in several places. Include
<asm/ptrace.h> to ensure it's visible. This is needed to make sure
object files that only include <asm/asm-prototypes.h> compile.

Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/include/asm/ftrace.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 0152a81d9b4a..b4d719de2c84 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_FTRACE_H
 #define _ASM_X86_FTRACE_H
 
+#include <asm/ptrace.h>
+
 #ifdef CONFIG_FUNCTION_TRACER
 #ifndef CC_USING_FENTRY
 # error Compiler does not support fentry?

base-commit: ad060dbbcfcfcba624ef1a75e1d71365a98b86d8
-- 
2.46.0.662.g92d0881bb0-goog


