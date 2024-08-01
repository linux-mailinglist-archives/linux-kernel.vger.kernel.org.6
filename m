Return-Path: <linux-kernel+bounces-270733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39E2944490
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72E71C223AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9381581EA;
	Thu,  1 Aug 2024 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4rMRp/X"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5115747D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494105; cv=none; b=jQ5hdpDlv3AOXQTXFN3Tl6yWGP4s/ykZk/KSKi+raD3s+PD4NPLjgtA51cbM10BH0zF+jnWSpxOJG9y1xUqUevVlQhVIDzsyPytyKadmrcZsKAK5LbP58pMntJU8oQ4d/HThkxZGAzddMAfTtyOAH1Lt3peO9CswG6pyUfxdtag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494105; c=relaxed/simple;
	bh=gWXzFPZlleiNj/yuaH5Ya0Ve6n2qeORP4PJCmoIao7U=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=XVD60Pi05Q1e1Z9qDaWWGpltv7mjxm/64pgUkUrzshkJzZpXrqaNdu/P6Lu48oBdUnKiae5dY2KQhiFWWKFnkFDAcam6ASlQfQgbN80rjkjFA5iW0RJYJ84rINBgVAZzVhYOdV2NnQQtNkvAliXHIvNFRf3Tyx4BKvP3i7TJzcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4rMRp/X; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b3d35ccfbso8288051276.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722494102; x=1723098902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qGf8YGR0qmIcrXytXcaURu6YFSlPASs/1I0L3L1Yn+8=;
        b=I4rMRp/XZhv+Do7EOWKvoD1DV5A8Kd5Ovj40pbApodTEeCvckSabPeeYYpVDMdJl1w
         fWB9YFGGsELtf9rhPiL8kQz5GYYSKlUdhIebwEqDy51ruHhN1Hrx2r1SRN7OTs/9mhGm
         fZ4MI/WsCaPua0RebEYtSerqpeGyFGNxTvPuyM46tRkpFbyyOuzSnzjPBtVrW4ifzAJ4
         pW9dPqdhw9dfhgKZSvMo4CWVVsSKGAjaE47F0iSHlleq/8B5/eulxbQ0Ot3IgmFN7HpH
         Ne8tHNvUrohtEMnK7iyCG6OdH2fjZcyVMT+Eh8SOrwHoO84p7k4bfQQOrmAbirAcuyRN
         VMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722494102; x=1723098902;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGf8YGR0qmIcrXytXcaURu6YFSlPASs/1I0L3L1Yn+8=;
        b=IR4UNHQ5aGQT69xy+ektcpiK17igQkjsc0U2SG41HW2Q8Nnuq+JdVYxkuXuMq0IVKg
         XSe9FbDNvLtpbqFbCZS9yRJ1Ffmm9c17Ct12Wk1mUto/eNFBD9vOwjhrlvPs88xQOdap
         N+X+ONH9EngAvUiA6XViVWlD16ivWm9dg+Bf6gHPn974nSLmRcIOmljlsE1fOi4KLl5f
         9xKptBcA2AgR4mg93xp2O5VBFwR3CfBix1VD06xRH/BDG/345eOIJ8KVCMQKn9em4int
         wj3+m5qK6md1+DMvpxUOvembmYXUlbzyh+lmmTpamXPTI/gXB8rp3WLpwjgH+Qn4F/EN
         6zJA==
X-Forwarded-Encrypted: i=1; AJvYcCVX/7hjvNpNcaFHCnIa1fDmxqiV8/jZ2r1EyEV8mODydV0QiBFt/hK1HSaCO2oU7cIgr148whDvwFQlFU0gl6Yw6JrIm2q2Tqex2xsN
X-Gm-Message-State: AOJu0YxWgDrvGIWA8ihFlDjxfqDgL3n+BPvZACHGgp1zp/2dLDKaMkQ4
	c0jmObesxTgOoWDQ1kXJz3RU/hBar6IL4bfgxmceXQDhKSN2KlN5Gw5COcP8sq04KGmFBi2iTBt
	OoKvstch+9g==
X-Google-Smtp-Source: AGHT+IECn2JN6LPJr8rHzIj0JBARhjVqz0f7IWwHbIZwN0E5D53GDesnSORaaR7AyrVT77RjBEbNnq8SJ9RSAg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:274a:b0:e03:59e2:e82 with SMTP
 id 3f1490d57ef6-e0bcd3e55a2mr1839276.10.1722494102460; Wed, 31 Jul 2024
 23:35:02 -0700 (PDT)
Date: Thu,  1 Aug 2024 14:34:35 +0800
In-Reply-To: <CAHk-=wgPD+=Wi8T0A59muq46LxquhsWQSyPV6KM5xa8V1UPK=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801063442.553090-2-davidgow@google.com>
Subject: Re: [PATCH] x86/uaccess: Zero the 8-byte get_range case on failure
From: David Gow <davidgow@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Gow <davidgow@google.com>, Kees Cook <kees@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 09:38:15 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 31 Jul 2024 at 09:24, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > My bad. My mental model these days is the 64-bit case, where the whole
> > 'check_range' thing is about address masking tricks, not the actual
> > conditional. So I didn't think of the "access_ok fails" case at all.
> 
> Actually, now that I said that out loud, it made me go "why aren't we
> doing that on 32-bit too?"
> 
> IOW, an alternative would be to just unify things more. Something like this?
> 
> *ENTIRELY UNTESTED*.

I tested this on everything I had on hand, and it passes the usercopy
KUnit tests on:
- QEMU, in every config I tried
- A Core i7-4770K (Haswell), under KVM on a 64-bit host kernel
- A Core 2 Duo E6600, bare metal
- A 486/DX2, bare metal

The 486 seemed to treat the wraparound a bit differently: it's triggering
a General Protection Fault, and so giving the WARN() normally reserved
for non-canonical addresses.

> 
> And no, this is not a NAK of David's patch. Last time I said "let's
> unify things", it caused this bug.
> 
> I'm claiming that finishing that unification will fix the bug again,
> and I *think* we leave that top address unmapped on 32-bit x86 too,
> but this whole trick does very much depend on that "access to all-one
> address is guaranteed to fail".
> 
> So this is the "maybe cleaner, but somebody really needs to
> double-check me" patch.
> 
>              Linus
>

I think this is right (there's definitely an unmapped page at the top),
but I'd want someone who knows better to verify that this won't do
something weird with segmentation and/or speculation with the 8-byte case
(if vm.mmap_min_addr is 0 and someone's mapped page 0).

The Intel manuals are very cagey about what happens with wraparound and
segmentation, and definitely seem to suggest that it's implementation
dependent:

"When the effective limit is FFFFFFFFH (4 GBytes), these accesses may or may not
cause the indicated exceptions.  Behavior is implementation-specific and may
vary from one execution to another."

So I'm a little worried that there might be more cases where this works
differently. Does anyone know for sure if it's worth risking it?

Regardless, I tried making the same changes to put_user, and those work
equally well and pass the same tests (including with the WARN() on 486).
Combined patch below.

Cheers,
-- David

---
From 3fd12432efee3bbed26abb347244c5378b7bf7e9 Mon Sep 17 00:00:00 2001
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Aug 2024 09:30:39 +0800
Subject: [PATCH] x86/uaccess: Use address masking for get_size on ia32

On x86_64 get_user and put_user rely on using address masking to force
any invalid addresses to the top of kernel address space, which is
unmapped, and then will trap. The 32-bit case has thus far just used a
comparison and a jump.

Use the address masking technique on ia32 as well (as the top page is
guaranteed to be unmapped here as well), to bring it into alignment with
the x86_64 implementation.

This also fixes the previous cleanup, which didn't zero the high bits if
a 64-bit get_user() was attempted with an invalid address, as in the
usercopy.usercopy_test_invalid KUnit test.

Fixes: 8a2462df1547 ("x86/uaccess: Improve the 8-byte getuser() case")
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/lib/getuser.S | 5 ++---
 arch/x86/lib/putuser.S | 5 +++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index a314622aa093..3ee80b9c4f78 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -44,9 +44,9 @@
 	or %rdx, %rax
 .else
 	cmp $TASK_SIZE_MAX-\size+1, %eax
-	jae .Lbad_get_user
 	sbb %edx, %edx		/* array_index_mask_nospec() */
-	and %edx, %eax
+	not %edx
+	or %edx, %eax
 .endif
 .endm
 
@@ -153,7 +153,6 @@ EXPORT_SYMBOL(__get_user_nocheck_8)
 
 SYM_CODE_START_LOCAL(__get_user_handle_exception)
 	ASM_CLAC
-.Lbad_get_user:
 	xor %edx,%edx
 	mov $(-EFAULT),%_ASM_AX
 	RET
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 975c9c18263d..8896f6bcbf9c 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -39,7 +39,9 @@
 	or %rbx, %rcx
 .else
 	cmp $TASK_SIZE_MAX-\size+1, %ecx
-	jae .Lbad_put_user
+	sbb %ebx, %ebx
+	not %ebx
+	or %ebx, %ecx
 .endif
 .endm
 
@@ -128,7 +130,6 @@ EXPORT_SYMBOL(__put_user_nocheck_8)
 
 SYM_CODE_START_LOCAL(__put_user_handle_exception)
 	ASM_CLAC
-.Lbad_put_user:
 	movl $-EFAULT,%ecx
 	RET
 SYM_CODE_END(__put_user_handle_exception)
-- 
2.46.0.rc1.232.g9752f9e123-goog



