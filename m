Return-Path: <linux-kernel+bounces-350324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255D2990379
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6152283513
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8605420FAB0;
	Fri,  4 Oct 2024 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhqf9Wsp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E179F3
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047163; cv=none; b=pNddcBvObF0nacqlnHbJ5dNOwXfQuQnIx1pDBF5lgdfP0LTS8XfdI04MmficVUH7eUDAW2uIDQxb/mNaDaOQ/6cIVz2cOSz+a/j1IvNVd/GusJdXPWddLD73F6qy2W3lsMYEemHH+N77EBdaeddy+Z3KH3MDn7d8EugDoWIopog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047163; c=relaxed/simple;
	bh=kRQQe61Akz7VG5idUgr2NwVMRuIiutrELrCHMyAzh9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LWC9gM/7sh75wBgncSe4CXV5O4+ieVLA9tT0ykkpnREfWEPxpEcl9dH40fEEzV8d08K2gvkiA/OnZKHTIBFiJJ3Hc/6iPIxiQl1A1RnFkaUvym8xlFWyZJMe8XVTJ4fnQLH6q4DOLIsO7opbl6oxv3sijxn7UoenUSOKtz0YpDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhqf9Wsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D87DC4CEC6;
	Fri,  4 Oct 2024 13:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728047162;
	bh=kRQQe61Akz7VG5idUgr2NwVMRuIiutrELrCHMyAzh9U=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=rhqf9WspffTi6HwYv7jz8l7B79VZ1btJkye2i6HpuEglHBzm5yG7Tx0l6yWk5fi6D
	 Xd+kB828npcjY+YQnyiYGvMuUr2TcxNxIfpvyWiFGKm6/NpN1ssRzi5qUJu+KUIaTE
	 yiU2Mr4nJzkXF0UsU4Ywr77J/RWXDApVOky0WaL2wp8jJS5WS/QDk9RqiFJp+hjEST
	 Go6FMQDBlSKVHCeQQPez6P7SItV24KobUJWkqYFbQj46epXRB29VvGB1t5yTw6+aqR
	 0gp1ljKNFHibLd7cuXsVvURyJ7sS+Y1cYffQtFQlS2jVFm3YXMY4Dv2WOlZB0C7JS2
	 s4B7FhWW5Cbmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80567CFA779;
	Fri,  4 Oct 2024 13:06:02 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Fri, 04 Oct 2024 18:35:53 +0530
Subject: [PATCH v2] Fixes: null pointer dereference in
 pfnmap_lockdep_assert
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-fix-null-deref-v2-1-23ad90999cd1@iiitd.ac.in>
X-B4-Tracking: v=1; b=H4sIADDo/2YC/3WMywrCMBAAf6Xs2S151Iqe+h/SQ0w2dqGkktRQK
 fl3Y+8eZ2Bmh0SRKcGt2SFS5sRLqKBODdjJhCchu8qghOqkEBo9bxje84yOInnsH94IrS/krYY
 avark7Rjex8oTp3WJn+Of5c/+XWWJEoXpzs5fnZC9GZh5da2xLQcYSylfcLqDk64AAAA=
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+093d096417e7038a689b@syzkaller.appspotmail.com, 
 Manas <manas18244@iiitd.ac.in>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728047161; l=1777;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=OEwuLRIdbf6uWYdfndo9PjGAmtyN4VZDWmzer8sLYJ8=;
 b=W2C+cObLrtqqTQu9dKflHQD9t3M4Uc2SCrH7g/8NavfEy9xgTNmwfI3B7b6NGxEDyfpNY9+cG
 h6QICQmopUsB4nmk6WjMlgRk/+afkoAWTEZ1bWxFF4UeeekxbyAp8Ag
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

This fix returns if vm_file member in vm_area_struct is NULL.

Reported-by: syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=093d096417e7038a689b
---
This bug[1] triggers a general protection fault in follow_pfnmap_start
function. An assertion pfnmap_lockdep_assert inside this function
dereferences vm_file member of vm_area_struct. And panic gets triggered
when vm_file is NULL.

This patch returns from the assertion pfnmap_lockdep_assert if vm_file
is found to be NULL.

[1] https://syzkaller.appspot.com/bug?extid=093d096417e7038a689b

Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
Changes in v2:
- v2: use ternary operator according to feedback
- Link to v1: https://lore.kernel.org/r/20241003-fix-null-deref-v1-1-0a45df9d016a@iiitd.ac.in
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2366578015ad..5ed109a8f02e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6346,7 +6346,7 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
 static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
 {
 #ifdef CONFIG_LOCKDEP
-	struct address_space *mapping = vma->vm_file->f_mapping;
+	struct address_space *mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
 
 	if (mapping)
 		lockdep_assert(lockdep_is_held(&vma->vm_file->f_mapping->i_mmap_rwsem) ||

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241003-fix-null-deref-6bfa0337efc3

Best regards,
-- 
Manas <manas18244@iiitd.ac.in>



