Return-Path: <linux-kernel+bounces-357363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D50997061
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27F02822A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B791D07A3;
	Wed,  9 Oct 2024 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ud0aeFTj"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8001A1A00C9
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488360; cv=none; b=Y7RfURMvpQie5vvQWWvzR5hHxUOnxIoST1UDaVEVvqZPz7QRXdPAlhhjK9FLXPUi4E8drTrJjpJ4igawOTQUViEO3nnYvV75JNP2vv2s7KWnUQKbyrTxKvYsNH18nYEwbkYJCCwrW7YqT8G+SSA/LS1zN03KqmMsOwXQQoNcYvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488360; c=relaxed/simple;
	bh=mTVGohqQhQ+rnWnxvs61IpD872h66PAzmV4rz1Tfg7A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Uft5pjlefuakuwNY7UnUBMRjqVFS89BDXLScbNtqiiFtMmdgKihANiKSpQPE9G2slMFPPzwC+j3bZ99OhrZdijIjEUVEZKnZMJbG+CUCeGk3sbAFXUPwZLe3Hgnv7Jd+qDFn2VkdbZ3sO3cgNdFiX91KA8TBef6NCLvMYa5P7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ud0aeFTj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b5792baaso10076129276.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728488357; x=1729093157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QYyiAS0INs/NWkNBJl2g+1VUV2QV3THsM68JPcVS+YY=;
        b=Ud0aeFTjW6mEXDnspoduv00AmmUnVprhP6pHYvrvvicSI3a8ObdUZEYfkUURXdBow1
         mdmUIV4u0lcZuZt28Wjx81tzAHryo6POP8Xefl3SJ9iRRf4en+YpNWvCJRxm1+4iZY0D
         Y8f+H4UhTnUcC/idxXoS+MgAByBGKaY96LM1wXJfacommtIWd6rgo7KFZNk+Srt5m8+X
         us2FS0tu96VRaJqtYsAv8CtwhUc/JhpXNm9MyT0hGF/BsfndQcMDLg9iOtI+Ibwojbfs
         Xz+Cn/GFHfAdoNupDGYksvPrZ6lUOmZtF8E6KvOCBAvzqdcCtfc0r1wHP5eKZ+7zKasL
         I2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488357; x=1729093157;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYyiAS0INs/NWkNBJl2g+1VUV2QV3THsM68JPcVS+YY=;
        b=eM+BCFddGtBAw+Pz5r+e7fSASKROMra5Z6QkVF3YtIxB2hkK0jVe6S4qCh1vVd9Aet
         PiskQhwVWQmVKD0xU6Akd3iNGlul0+9/Rvd45zeT/PVqbmvC2ucqbUTPf+o3E0kTtGNA
         nkpm7tMkHMZ2pwditimPUJtiaILt57dmvnHL7UayQl1e2fNsqyQFzCBsVwobVPJjixPP
         YnN3sUGPcdjXXZ6zB0kMVMXHq8Ai90Cz9at0ZV9G97UQFrAPoIDtYGEXqcmmQWGuAW9y
         BE5+BHsMGybm1p0bDUjRlCf3vwKbI7nU64HgCDI2bHBk4WqYAKFvQ9LZUWvDRXclPWQd
         VWHg==
X-Gm-Message-State: AOJu0YyY4pCtVFjdyGawOCEyAmpIKua7ozEySqarRn9KJc5lqvC/VMEf
	VFZXwXIjXKt+lQmisTZo+tYLgOWKmYpypPr/Ar4m1El7xHFp4lHm8wj4usb9AFubLTo4yA==
X-Google-Smtp-Source: AGHT+IHIoVogYPJY9awQcFf2XNy4JBbgtfmZhjVVXbqFXh4Tsc5ifrpwAQ3N32DMwXvcP1Og5ZfpFKGu
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:a484:0:b0:e20:210d:4e4e with SMTP id
 3f1490d57ef6-e28fe3fbac7mr30646276.7.1728488357426; Wed, 09 Oct 2024 08:39:17
 -0700 (PDT)
Date: Wed,  9 Oct 2024 17:39:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=ardb@kernel.org;
 h=from:subject; bh=w98mnX5+KZJQ9aIhR0ntKseGofoDBus8uh8cyGitUc8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1t8dSDjw2sF9auaWgwFd7B6yQ14+H0TUqbzq2wXOchX
 TpJgbO6o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwkKovhN8vZwqMJXz/vDtbJ
 yYpf/5/97Vl28aYAJ/Vf5lmi/kf3KTMybNVzqH/S3dgrLNdbs5lB+dlS60+b1U5zfCh8IFRzpTe CAwA=
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009153901.3878233-2-ardb+git@google.com>
Subject: [PATCH] x86/ftrace: Don't bother preserving/restoring R10/R11
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The x86_64 calling convention specifies that R10 and R11 are
caller-save, and are not used to pass function arguments. Given that any
compiler optimizations that may deviate from this rule (e.g., -fipa-ra)
are disabled when profiling is enabled, R10 and R11 are dead when the
ftrace hook is called, and so there is no point in preserving and
restoring them.

Case in point: the code inadvertently never restored R11 to begin with
(added via [0] in 2012)

[0] 08f6fba50311 ("ftrace/x86: Add separate function to save regs")

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/ftrace_64.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 214f30e9f0c0..9e13f9b203d1 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -216,8 +216,6 @@ SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
 	movq %r14, R14(%rsp)
 	movq %r13, R13(%rsp)
 	movq %r12, R12(%rsp)
-	movq %r11, R11(%rsp)
-	movq %r10, R10(%rsp)
 	movq %rbx, RBX(%rsp)
 	/* Copy saved flags */
 	movq MCOUNT_REG_SIZE(%rsp), %rcx
@@ -256,7 +254,6 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	movq R14(%rsp), %r14
 	movq R13(%rsp), %r13
 	movq R12(%rsp), %r12
-	movq R10(%rsp), %r10
 	movq RBX(%rsp), %rbx
 
 	movq ORIG_RAX(%rsp), %rax
-- 
2.47.0.rc0.187.ge670bccf7e-goog


