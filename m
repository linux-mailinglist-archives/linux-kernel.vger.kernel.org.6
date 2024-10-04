Return-Path: <linux-kernel+bounces-350408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD7B9904B6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232981F2285E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D651420FAA6;
	Fri,  4 Oct 2024 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kY5smuTo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C5F33D5
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049552; cv=none; b=VrzJ5C8WuxxaJRdtcJeb6FQGXo4Wgmz8Nmvj+TvYs9xGQUgzuKogMZCD3M4MelXA4q0fr/p7o4tr6iB0JHu2BM4X+1BbOeKjsCg/+PvtRuYEfNtXuU0nm2R4DrlsyCJxSe/pY959Mhb9u2RJP3OOjZY5TkrI7n+MAg3kq2bnIqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049552; c=relaxed/simple;
	bh=1RS+17mH4AXNIN1g+vb0r2cDyMfutwB690D0Mhv8Yh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NBlXuszL60Nfw+mqzOGbRoZvrUMhhiPtATms/kpQ3zkhfE41Y6lLxYIUwRMl1UJzdBBJbAVjGQIybcf7eyNQ0dTmLAd73HpyinSUB2SSsNmyEioxtEYAm8cp0hc0rEF8f9sPx6LBqWDkeUqTE6wiPRApfPz1JEGvuz6QMCd+x0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kY5smuTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6B62C4CEC6;
	Fri,  4 Oct 2024 13:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728049551;
	bh=1RS+17mH4AXNIN1g+vb0r2cDyMfutwB690D0Mhv8Yh8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=kY5smuToRMZKl6xm4yZRdHQApYQ3/XOLtSnwsedUdU/Cef+xb1HiPFi64SBlYsCba
	 VJk8LxCL1zCGUEMyhNTlSfC7QtMehfn1KfI6iNaqaWWrWn9/7H0++Ch27GuDPFU1QZ
	 dzrxaFui6BnRPXq1c9lHK5ZSkMA/RgnOHg3uWk8m/LqlLv6C3qpi/LmK0iD4/LI699
	 V8+w/dpS7AGDo1MjeStmezhRKBjqr+HETrNxVVTCfdTn6LvvT2ZFxaIleoR6p/k96b
	 d1VSfJngByDPXxN7JRlq7utRdNgXkZ99otxezBc04F53JV7cZmJWaXPQvIpmf1G39Q
	 TRF7o+2YMggTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB61DCFA775;
	Fri,  4 Oct 2024 13:45:51 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Fri, 04 Oct 2024 19:15:48 +0530
Subject: [PATCH v3] Fixes: null pointer dereference in
 pfnmap_lockdep_assert
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-fix-null-deref-v3-1-f9459b1cc95f@iiitd.ac.in>
X-B4-Tracking: v=1; b=H4sIAIvx/2YC/3XMSwrCMBSF4a2UOzYlj1qJo+5DHMTkxl4oqSQ1V
 Er3btqRIg7/A+dbIGEkTHCuFoiYKdEYSqhDBbY34Y6MXGmQXDaCc8U8zSw8h4E5jOhZe/OGK3V
 CbxWU06OMNO/g5Vq6pzSN8bX7WWzrXyoLJhg3zdF57bhoTUdEk6uNrSnAhmX5CTQ/gCyAVMZpr
 rW2TnwD67q+Ac2cABzvAAAA
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+093d096417e7038a689b@syzkaller.appspotmail.com, 
 Manas <manas18244@iiitd.ac.in>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728049550; l=2095;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=ew+qGxm4Lxxrd6Mo6kl+2EOEGjzE1+x1lwHF41mIdfg=;
 b=8TyYBtUuYhyHZVRpCSzgDVmHLuJkeS15eZxJViSrrKRr3LtHwGkO1VBNGFwq2t3iosIWnHmIn
 SRsaG1T5cwhDUs0SpaHKlXe9E97qDUHK29VN1sdeSx7taszr+x56E9Z
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

syzbot has pointed to a possible null pointer dereference in
pfnmap_lockdep_assert. vm_file member of vm_area_struct is being
dereferenced without any checks.

This fix assigns mapping only if vm_file is not NULL.

Reported-by: syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=093d096417e7038a689b
---
This bug[1] triggers a general protection fault in follow_pfnmap_start
function. An assertion pfnmap_lockdep_assert inside this function
dereferences vm_file member of vm_area_struct. And panic gets triggered
when vm_file is NULL.

This patch assigns mapping only if vm_file is not NULL.

[1] https://syzkaller.appspot.com/bug?extid=093d096417e7038a689b

Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
Changes in v3:
- v3: use assigned var instead of accessing member again 
- Link to v2: https://lore.kernel.org/r/20241004-fix-null-deref-v2-1-23ad90999cd1@iiitd.ac.in

Changes in v2:
- v2: use ternary operator according to feedback
- Link to v1: https://lore.kernel.org/r/20241003-fix-null-deref-v1-1-0a45df9d016a@iiitd.ac.in
---
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2366578015ad..828967a13596 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6346,10 +6346,10 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
 static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
 {
 #ifdef CONFIG_LOCKDEP
-	struct address_space *mapping = vma->vm_file->f_mapping;
+	struct address_space *mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
 
 	if (mapping)
-		lockdep_assert(lockdep_is_held(&vma->vm_file->f_mapping->i_mmap_rwsem) ||
+		lockdep_assert(lockdep_is_held(&mapping->i_mmap_rwsem) ||
 			       lockdep_is_held(&vma->vm_mm->mmap_lock));
 	else
 		lockdep_assert(lockdep_is_held(&vma->vm_mm->mmap_lock));

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241003-fix-null-deref-6bfa0337efc3

Best regards,
-- 
Manas <manas18244@iiitd.ac.in>



