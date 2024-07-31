Return-Path: <linux-kernel+bounces-268695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073089427F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95BC28A641
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA841A4B45;
	Wed, 31 Jul 2024 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMNp9up5"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767E017580
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411066; cv=none; b=gmk8vA8KcOHs2V8LrHDgWJwD6WkTbdyMFK29rczPLge3AlK9cTCV35EYwD7+aowwuC4E92ygMrJC7N9hs1paMUCCpKp5DmDRDvctIzbrzHxrS+y/+OwkYsp7Z+iO8CHXEloQ+a3+AfTRJghRT9hiimnp2UGedHr9Pt6fCuOouLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411066; c=relaxed/simple;
	bh=oc/bYOw34FirNTEznBwq/5B8ta6p5pVyS+F0YlckeFs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QJlAZZzeBD7e0gCx45dYNCDWLRuU2qNXJfhhSyhueKkf30xY47bJF4zoXKhy5jlz7ScVHx9EgEnZjA8Z0BJhcGK82wg3j7I3RywPpN7BAFIHe2D0nxIE/JBLX78MGSfQ0DS5htasb6I+jAPnEd9HNZnDGilyp0Lnz1bH4gQFxpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UMNp9up5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66a2aee82a0so99052427b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722411064; x=1723015864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T33JV3bEYkV9z3ismY+1zuWXq63agjq2fsiZqjUuS/c=;
        b=UMNp9up5Fu63Xdz4QpYi1h6ZNJOSXlv60w/DaEabRb0vAtzj14dTUG9frttwSUV5M1
         wo8ZYE6sZ+NkTGb6xt5iqBQkW6bNK5otX2WIsqBL1U4AU6tR5Vhx0jo0A9LbvVt/8P9l
         8hTEPHpKyULd/OawyF4WNzdDDyr1U3CcG3tBNBsTKUMISbkI44yvshdAmdmhGGR6O3Gb
         9Lb+KXBT7H9UoY/QHPwTVptLM2EHXfXBBkdoSe0+HH8pV5EOMoqqjD0RHERzzHLSLZIr
         G//6uo2nopO6hThcE4D/K/QCgHvBkC0UvxnulWcPsFR4C3tkO/GVKW9VuzbzVxjUH4J3
         lSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411064; x=1723015864;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T33JV3bEYkV9z3ismY+1zuWXq63agjq2fsiZqjUuS/c=;
        b=O6MrQ48se7MRZMQjMIT5+XSYnp9O/FWcTG7+tbaoZg0o9QYYSkS0vP7mKMP1lDNqxZ
         Kh9kuKkrYzn5FOy9xsmJPjrhD1M8Ad2/Klt1iqK11RQIvfqGa8kmJXpAHlmRjtX9S3F9
         0teJw1ukIht5oRe/exou4nwr2nw+6UXRDImLBKxOLBAftKGwgboAcCpF0OmM+YTaDZVT
         JaMbCS+u8/w0yuDnqgRMxjlpAkzvaQoujb3Z30jy4mcseIifOAfY2OeEK5Cyl/KmwAl8
         o4v0JZ8hyW4NcFbT266N35NUXSmfJA+pxFDyqlFufZA8OHFvBicLZkORnt+9M2cn61jg
         Nm2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2cYR+G9V32yii1jmuFHKNfoIuUEE54rTtxlfnIe+wf/r7NH4qXRQBvqBCCzN2GipKlADi4vxNzXk7XAnA43Hsu9SuJ41KcUg2qq1m
X-Gm-Message-State: AOJu0YyBxCFzAlW92xOEGhFATwYTFva57vMe0puUYRquCsZMMwCignES
	cNDQ9kXJoXX588WMiZSKYpdcuCmuBfiWBosBg1WnSddddeV3ZMi7kj5YVPIZPoI4DO5M/fa2RLE
	RzolBRSu9qQ==
X-Google-Smtp-Source: AGHT+IH6Vma0g+e9JN0NhAlEKs/EmHwXSJ2r+VyiOtazRCuDsunAf9fcOmpsrgz49euq/bsMPGoVriT0pjw2sQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:690c:398:b0:62c:de05:5a78 with SMTP
 id 00721157ae682-67a0a7fc5a2mr336567b3.6.1722411061234; Wed, 31 Jul 2024
 00:31:01 -0700 (PDT)
Date: Wed, 31 Jul 2024 15:30:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240731073031.4045579-1-davidgow@google.com>
Subject: [PATCH] x86/uaccess: Zero the 8-byte get_range case on failure
From: David Gow <davidgow@google.com>
To: Kees Cook <kees@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Borislav Petkov <bp@alien8.de>
Cc: David Gow <davidgow@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

While zeroing the upper 32 bits of an 8-byte getuser on 32-bit x86 was
fixed by commit 8c860ed825cb ("x86/uaccess: Fix missed zeroing of ia32 u64 get_user() range checking")
it was broken again in commit 8a2462df1547 ("x86/uaccess: Improve the 8-byte getuser() case").

This is because the register which holds the upper 32 bits (%ecx) is
being cleared _after_ the check_range, so if the range check fails, %ecx
is never cleared.

This can be reproduced with:
./tools/testing/kunit/kunit.py run --arch i386 usercopy

Instead, clear %ecx _before_ check_range in the 8-byte case. This
reintroduces a bit of the ugliness we were trying to avoid by adding
another #ifndef CONFIG_X86_64, but at least keeps check_range from
needing a separate bad_get_user_8 jump.

Fixes: 8a2462df1547 ("x86/uaccess: Improve the 8-byte getuser() case")
Signed-off-by: David Gow <davidgow@google.com>
---

There are a few other ways we could fix this, but all of them seem to
increase the ugliness a bit. This seemed the best compromise, but if
you'd prefer to have the size=8 special case live in check_range, that's
fine, too.

See also:
https://lore.kernel.org/lkml/CAHk-=whYb2L_atsRk9pBiFiVLGe5wNZLHhRinA69yu6FiKvDsw@mail.gmail.com/

Cheers,
-- David

---
 arch/x86/lib/getuser.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index a314622aa093..d066aecf8aeb 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -88,12 +88,14 @@ SYM_FUNC_END(__get_user_4)
 EXPORT_SYMBOL(__get_user_4)
 
 SYM_FUNC_START(__get_user_8)
+#ifndef CONFIG_X86_64
+	xor %ecx,%ecx
+#endif
 	check_range size=8
 	ASM_STAC
 #ifdef CONFIG_X86_64
 	UACCESS movq (%_ASM_AX),%rdx
 #else
-	xor %ecx,%ecx
 	UACCESS movl (%_ASM_AX),%edx
 	UACCESS movl 4(%_ASM_AX),%ecx
 #endif
-- 
2.46.0.rc1.232.g9752f9e123-goog


