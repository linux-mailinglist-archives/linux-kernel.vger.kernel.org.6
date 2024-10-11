Return-Path: <linux-kernel+bounces-360291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B90E19997F6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FFE1F207C1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB51863F;
	Fri, 11 Oct 2024 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QmZKdYi8"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D352A846F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606745; cv=none; b=N2tsbwjzpE7vuLawUR1Q3rkFb8ZC2l4zsDp+JxNgoDzOW1ZAPAAnb/G9UvTYz7zTqnJzUHX6qBMpu4gvAey3fCzG4pUMrftq8LrOVYeGB2M77+r/d+rwm7T4qVLgEFgCW1HJimGd/ssNmQKA8LL7B+te9yQxE0k7dnGq8NNrRdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606745; c=relaxed/simple;
	bh=zXJMeVCU0/xR62pDJCipOAYdaSp2CdjUA0XW8sGT2qU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VmSuzi7UoXVKUZyyX3CF+GABsq+l/BbgaU/YdE4R+6b1BcY/2m1Gp+dRyvjqOqPr9Adwl3Ynt9qCsOucPHYTNYLbol8D/RB1vg2yHtc2iVpkY5QQb3yasvFvpv4aFe5UZdauVvzLq74RMcoQ3p3nO9g6pBLxfH4d3rG10cQTgew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QmZKdYi8; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso1113248a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728606743; x=1729211543; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OwXMBbOWCv06xRC7kuAtikxfL3CuNBKfrSTtPkKqEqk=;
        b=QmZKdYi8Oobr87DoDpgpJlggbwIBbx2tWncovpU84JcJJZZwnfE2Rud5K4xm8+iVEa
         fCrX12fzK5Lbn0TmkwFECT2LuNHCqHNUV02Owjj0SSmtP6AE8Uil+GkWwIqy4iEEJLqT
         jD7tfRmzplpNRWKkW3TOkS6fKO9R2fRSreGtAUhBB09zcw8sb4DMlMs/9gNkYrOBNYRL
         XanOBytZkRgrBNHvHZnCxpFYbX45tBR4mwkLZKTG8NOzNK0qIx5QyvK8ggVbBYyCLMsi
         3OwQuIKOkCrvL2iBy1BSckAb7TwnK5NzWi0TymPx/9HYxi2mRz4CwHGqTx/fnY+UoR52
         8F3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728606743; x=1729211543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwXMBbOWCv06xRC7kuAtikxfL3CuNBKfrSTtPkKqEqk=;
        b=J/zsSBi5ZpEeIo/BbkpOVnpO4lKdnivtHt7ttMe7roq/rtIArI3hxRjsI0K7CByq4i
         21OkEWnRAc/M0/ZKp1Qv0T5luaTP3b11NP1051XqXNduR8UcpaMBjzZQCaCGEyxTLP8n
         i/qTQkOnkcGUFIihIaXLyoXivWHO/bbBISSeHdQHHl4VvQZ0rrC+Af48l/wJhZc17sdO
         Rpxjd6Gs4o8q9Y8NZwzc17lYneLlOnV+X2XUa+3UWMgBCco4XFFJXvH/k7sRyZYUMwps
         IDHGKXVwh2GInBFOxnZM0lwFowslSAAmlal+xu9YW2UbN+vhxQxNAkFIVioijj6uo7oq
         aJCg==
X-Gm-Message-State: AOJu0Yw+UbdICM4uFB188RZ0ZjGAxh+AqObvl+qSF2ZZt+nC10tE95a/
	UeAsqVeDbMEkyY+7IMnpfq/ObafTwG3oEGtGiNzDB1Bjy6S6BDTggd1ue6v7Trs=
X-Google-Smtp-Source: AGHT+IHY7zq/7mSxHwSor2mUQedwvphBbojX3qVK+YSVQyO1pCVsaX3K1rupXosm1zq+SyZ3LBJdSg==
X-Received: by 2002:a05:6a20:c997:b0:1d2:e8d8:dd46 with SMTP id adf61e73a8af0-1d8bcf23701mr1509996637.15.1728606743039;
        Thu, 10 Oct 2024 17:32:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4496b1afsm1545600a12.94.2024.10.10.17.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 17:32:22 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 10 Oct 2024 17:32:04 -0700
Subject: [PATCH RFC/RFT 2/3] mm: helper `is_shadow_stack_vma` to check
 shadow stack vma
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-shstk_converge-v1-2-631beca676e7@rivosinc.com>
References: <20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com>
In-Reply-To: <20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-arch@vger.kernel.org, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Mark Brown <broonie@kernel.org>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow
stack). In case architecture doesn't implement shadow stack, it's VM_NONE
Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
or not.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 mm/gup.c |  2 +-
 mm/vma.h | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a82890b46a36..8e6e14179f6c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1282,7 +1282,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		    !writable_file_mapping_allowed(vma, gup_flags))
 			return -EFAULT;
 
-		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
+		if (!(vm_flags & VM_WRITE) || is_shadow_stack_vma(vm_flags)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
diff --git a/mm/vma.h b/mm/vma.h
index 819f994cf727..0f238dc37231 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -357,7 +357,7 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
 }
 
 /*
- * These three helpers classifies VMAs for virtual memory accounting.
+ * These four helpers classifies VMAs for virtual memory accounting.
  */
 
 /*
@@ -368,6 +368,11 @@ static inline bool is_exec_mapping(vm_flags_t flags)
 	return (flags & (VM_EXEC | VM_WRITE | VM_STACK)) == VM_EXEC;
 }
 
+static inline bool is_shadow_stack_vma(vm_flags_t vm_flags)
+{
+	return !!(vm_flags & VM_SHADOW_STACK);
+}
+
 /*
  * Stack area (including shadow stacks)
  *
@@ -376,7 +381,7 @@ static inline bool is_exec_mapping(vm_flags_t flags)
  */
 static inline bool is_stack_mapping(vm_flags_t flags)
 {
-	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
+	return ((flags & VM_STACK) == VM_STACK) || is_shadow_stack_vma(flags);
 }
 
 /*
@@ -387,7 +392,6 @@ static inline bool is_data_mapping(vm_flags_t flags)
 	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE;
 }
 
-
 static inline void vma_iter_config(struct vma_iterator *vmi,
 		unsigned long index, unsigned long last)
 {

-- 
2.45.0


