Return-Path: <linux-kernel+bounces-248588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566B192DF53
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F2D1C210F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E53B4EB55;
	Thu, 11 Jul 2024 05:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+FzI6um"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7A95477A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720674801; cv=none; b=kgVvhuA1nYL6h+PLl8dVldZlmn1bYJ6nNyZXl0gJoaWBhQm6irmx87FCB/2slTQ/bWc3tHO4A3+UUScgax/PIfZ7FjZtxZbLGkaho7iLtl9cZiexfFN9ITPJiQf/arIP/3hJOaxQAPN2WMwrMEwVoB9FpZbIZm5tl4/Fw6UbL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720674801; c=relaxed/simple;
	bh=3ICe51SaAt5djViV4CNOeZvsuOCXxxCiY5DHVoQXx74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kSy/s8yiRCd99Q7GwVr1CZlgarb0pY8gqb6+pSW3IxH3G93qdri7+AYaQP3zmWdFysUCJwNUy/28+hOEKKqw6YkUwBlkcWCOwaJrqv4mn74hkX0d94Io2bJ9kN/tabj748gvXfhU3xnRP8kd709Lx9z9/P0zASYShjZ4Y8nxMxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+FzI6um; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-655fa53c64cso4783947b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 22:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720674799; x=1721279599; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQXtYB9XCir9GCdKuowEuKTyQp208kpzJxxFmEuVXk4=;
        b=A+FzI6umFMQ8BYrZXgKTlLrDxbwjYOIrH+Z4cl9tmw8UwcgWoLLcvvntiLGxseSCQ/
         PN68JNkxSZaau78TA3oTfxDftKHYhOdmXO/OUjwXzDXMH5+EApynxXFdgm1EphyFK6oY
         mRMTVj4MrRrLJgcL4KGe8Hf3PiCrH19QGZ6NZs/JgANxBpf3C3WVz9+SqvFvmnPhY4eO
         T0iIjQWMfDIYQh3NMgRQIARWQSX+imEHDdfMb8ByJ7OKE+7C/eNLVIT7vrQkXDhYa5Al
         3WSZzKQZqwMNolQM0ep8kibemJ2mlIj+tySKWcWCb5h3RQo76odVsOiRXoJ8WsiWJmJs
         oKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720674799; x=1721279599;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQXtYB9XCir9GCdKuowEuKTyQp208kpzJxxFmEuVXk4=;
        b=LEsTtpkTtPAsvEnLmcfXu2WPMaXVj67eshO8jZVG6vBLZ5Cy9LZDF1g8qVR67u537e
         w0ORPQR7rROr9Wxndp0Pv6VONt4yj6lY+j1tUlY+jca19BgLRm+h8qy+JSrw56+9B4wJ
         FeMZKIf+XnhPkR8rD+eT6n4BML3N2cF2ggmvUHiJAoJZYjECvPIYYyI4Z692KyIF/Scj
         pLTvVPqTi7TS+0I+zGAALokLFk0DOsyY9NvoiJ7MlIPgRb3n2UxPYhnzn2u0QeX8Q605
         Ypfz1okYQSvgAZRvMHcsejXG7+UwC6PXvGIJ7OvulcAZe1cKwBUvEhftmSRHxYoqQFO5
         Oc9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXX7ktXPRNTugW2fn50HZ0nm3xx63yOwuPI3P14rHsCd5UYIrGa8ZzEYy7xU0Vmxh33cPMQn9Wn3v0SWVc4xhm+MtjmViTUr66RhTNU
X-Gm-Message-State: AOJu0YwSeeU5mNTfTTg9IIZLI3X6NX8Bsf4AnBZcSs/dn4k2YATZPRS1
	gxdl0LiPdbTmUSIe1aHOfDuhUsDquM/kvfOP2M+K9UKtT3UFKWczm7cFjA==
X-Google-Smtp-Source: AGHT+IEyAVKw5Vd18ENIlHU5gmCTPX/H+yQcQCMZso6vu9YM82xH6jarDD3R68xOoUe+H2XjSgqjhA==
X-Received: by 2002:a81:b101:0:b0:62c:fcba:cfeb with SMTP id 00721157ae682-65c0703a2d2mr34072307b3.34.1720674798840;
        Wed, 10 Jul 2024 22:13:18 -0700 (PDT)
Received: from [127.0.1.1] (107-197-105-120.lightspeed.sntcca.sbcglobal.net. [107.197.105.120])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-658e4f18ac1sm9812667b3.47.2024.07.10.22.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 22:13:18 -0700 (PDT)
From: Pei Li <peili.dev@gmail.com>
Date: Wed, 10 Jul 2024 22:13:17 -0700
Subject: [PATCH] mm: Fix mmap_assert_locked() in follow_pte()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-bug12-v1-1-0e5440f9b8d3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOxpj2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0MD3aTSdEMj3bTU5LRUk6Qkg5TkJCWg2oKi1LTMCrA50bG1tQDwdHD
 9VwAAAA==
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com, 
 linux-kernel-mentees@lists.linuxfoundation.org, 
 syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com, 
 Pei Li <peili.dev@gmail.com>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720674797; l=3183;
 i=peili.dev@gmail.com; s=20240625; h=from:subject:message-id;
 bh=3ICe51SaAt5djViV4CNOeZvsuOCXxxCiY5DHVoQXx74=;
 b=7v20EAV87UFY21GDUltDd4EeyRABLCZfR+Cx3h6CHtW1mZm9ikaQaBEWHqW7Ox4T5/FK+bSVJ
 xDafQfayV5QC0fjJZNKTyya6vp2sAYnNbj6lBbTTsxareJMGLm1ZNUA
X-Developer-Key: i=peili.dev@gmail.com; a=ed25519;
 pk=I6GWb2uGzELGH5iqJTSK9VwaErhEZ2z2abryRD6a+4Q=

This patch fixes this warning by acquiring read lock before entering
untrack_pfn() while write lock is not held.

syzbot has tested the proposed patch and the reproducer did not
trigger any issue.

Reported-by: syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=35a4414f6e247f515443
Tested-by: syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com
Signed-off-by: Pei Li <peili.dev@gmail.com>
---
Syzbot reported the following warning in follow_pte():

WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 rwsem_assert_held include/linux/rwsem.h:195 [inline]
WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 mmap_assert_locked include/linux/mmap_lock.h:65 [inline]
WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 follow_pte+0x414/0x4c0 mm/memory.c:5980

This is because we are assuming that mm->mmap_lock should be held when
entering follow_pte(). This is added in commit c5541ba378e3 (mm:
follow_pte() improvements).

However, in the following call stack, we are not acquring the lock:
 follow_phys arch/x86/mm/pat/memtype.c:957 [inline]
 get_pat_info+0xf2/0x510 arch/x86/mm/pat/memtype.c:991
 untrack_pfn+0xf7/0x4d0 arch/x86/mm/pat/memtype.c:1104
 unmap_single_vma+0x1bd/0x2b0 mm/memory.c:1819
 zap_page_range_single+0x326/0x560 mm/memory.c:1920

In zap_page_range_single(), we passed mm_wr_locked as false, as we do
not expect write lock to be held.
In the special case where vma->vm_flags is set as VM_PFNMAP, we are
hitting untrack_pfn() which eventually calls into follow_phys.

This patch fixes this warning by acquiring read lock before entering
untrack_pfn() while write lock is not held. 

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Tested on:

commit:         9d9a2f29 Merge tag 'mm-hotfixes-stable-2024-07-10-13-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13be8021980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3456bae478301dc8
dashboard link: https://syzkaller.appspot.com/bug?extid=35a4414f6e247f515443
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145e3441980000

Note: testing is done by a robot and is best-effort only.
---
 mm/memory.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index d10e616d7389..75d7959b835b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1815,9 +1815,16 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 	if (vma->vm_file)
 		uprobe_munmap(vma, start, end);
 
-	if (unlikely(vma->vm_flags & VM_PFNMAP))
+	if (unlikely(vma->vm_flags & VM_PFNMAP)) {
+		if (!mm_wr_locked)
+			mmap_read_lock(vma->vm_mm);
+
 		untrack_pfn(vma, 0, 0, mm_wr_locked);
 
+		if (!mm_wr_locked)
+			mmap_read_unlock(vma->vm_mm);
+	}
+
 	if (start != end) {
 		if (unlikely(is_vm_hugetlb_page(vma))) {
 			/*

---
base-commit: 734610514cb0234763cc97ddbd235b7981889445
change-id: 20240710-bug12-fecfe4bb0dcb

Best regards,
-- 
Pei Li <peili.dev@gmail.com>


