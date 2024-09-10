Return-Path: <linux-kernel+bounces-322884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83916973207
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87FF3B27547
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689EB193078;
	Tue, 10 Sep 2024 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DUMJCp6G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sTC9Mk9a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527B18A6D2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963133; cv=none; b=V6j0QaPFk+wQBCz0Iu7dMxK+JJYyZ32zjqlTwtHneDbD9IcKSpoQXrr31oMUl2zqzlf22TKcrJCL2Ym1Zjl5q34OLBqDbos7i5zbilGhilGuikeRKWHUTuOkG7T4udp/yIkYF44NG08oMXQT5ZUXH4dJqMWlwdgAtvqQvLiDHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963133; c=relaxed/simple;
	bh=CPeEQPomon0NN9hvYJGJq0EYPts0p9GT5vjukg23S/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hdBqn7i5jWb3a84OIwAKb49oqNQIh4pNijN/z2rtCtSsVOzV9lJt7+Td+dFFOPehw483bJD6owZWvrtdsoszbB9W6XE0CWfVXKcbU/GtNQ6xjN7RD5Q9r3ka3cLaOps7j6XruZ2cJciTmlhJnrhi+vlL98Xy4+FIZNHsrYQ4g8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DUMJCp6G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sTC9Mk9a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725963130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8g6RfBCA+wrHgvUyJpXjlSeY1WblZvtq0QubmmLmGE=;
	b=DUMJCp6GuJqMeuEgOoMS/uXiZ8i9y+Vwy0Vf8y6OQUZg3Z03wUgdbvkzaan3S/NcLciCiZ
	GFaac2r6ey5LKPqSj5NAkQI7nqGQypQd81aX2RqsUFW/X27hWolKAeGgZ8bpt+ReqYJGR2
	9PBzKtdDiHcuSXWOKq9RFQKD6PkpK0LkxPp8a9da5CEQC+1HmfaYt+RxjQcOEuf9WMNE0+
	AeyCC2vbPojWOhXtFJVNJlUOrYAO2r0UKDNLsjbr3I3RzbKesiFTlP5CV29JQyvD/tuEzO
	H7qiXJgetoatGPKz4qglIlPsw/EduznrZpzxbfjHmAZqwp/orFPOaiFDGxXKog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725963130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8g6RfBCA+wrHgvUyJpXjlSeY1WblZvtq0QubmmLmGE=;
	b=sTC9Mk9aV3zglGwb7YyFbRPPOeOq0+O4vFdendmV63xsimF0jFa93Z0fx9yQQW7CsK0IYa
	tPCJQihsSf5tWVDQ==
Date: Tue, 10 Sep 2024 12:11:36 +0200
Subject: [PATCH 2/2] x86: vdso: Remove redundant ifdeffery around
 in_ia32_syscall()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240910-x86-vdso-ifdef-v1-2-877c9df9b081@linutronix.de>
References: <20240910-x86-vdso-ifdef-v1-0-877c9df9b081@linutronix.de>
In-Reply-To: <20240910-x86-vdso-ifdef-v1-0-877c9df9b081@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725963129; l=1673;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=CPeEQPomon0NN9hvYJGJq0EYPts0p9GT5vjukg23S/E=;
 b=6fIxdpbyKGs151uLINYPcvYcZRrBnUjDTlUtPTWMZXB3yrTogS7CNFivTzA+rsqsxIYTDUal+
 kxO0LL0o9ZpDPswGKcoyBX8tJ0Mg6n1aao+VymNwEg3uQRNNKUq77t4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The ifdefs only guard code that is also guarded by in_ia32_syscall(),
which already contains the same ifdefs itself.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/entry/vdso/vma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 9059b9d96393..ab2b011471e0 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -75,7 +75,6 @@ static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 static void vdso_fix_landing(const struct vdso_image *image,
 		struct vm_area_struct *new_vma)
 {
-#if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 	if (in_ia32_syscall() && image == &vdso_image_32) {
 		struct pt_regs *regs = current_pt_regs();
 		unsigned long vdso_land = image->sym_int80_landing_pad;
@@ -86,7 +85,6 @@ static void vdso_fix_landing(const struct vdso_image *image,
 		if (regs->ip == old_land_addr)
 			regs->ip = new_vma->vm_start + vdso_land;
 	}
-#endif
 }
 
 static int vdso_mremap(const struct vm_special_mapping *sm,
@@ -339,7 +337,6 @@ int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 
 bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
 {
-#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
 	const struct vdso_image *image = current->mm->context.vdso_image;
 	unsigned long vdso = (unsigned long) current->mm->context.vdso;
 
@@ -348,7 +345,6 @@ bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
 		    regs->ip == vdso + image->sym_vdso32_rt_sigreturn_landing_pad)
 			return true;
 	}
-#endif
 	return false;
 }
 

-- 
2.46.0


