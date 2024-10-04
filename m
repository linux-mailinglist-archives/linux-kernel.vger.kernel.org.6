Return-Path: <linux-kernel+bounces-350838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA396990A52
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79277B2102C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928B21DACA7;
	Fri,  4 Oct 2024 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2NwM+QZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015DE1DAC95
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063741; cv=none; b=s9veMwJu3q6FjT6xdiSBJ9/IgqB+Z7e0VgU5MeP5tVM/q8ZfUGzYABUkdSxv9vOKlzUTdQ3LTeD6P5UPQiUUMLqJHwye90BH3Dij/8ow9dMyXTwoPZxrFR1Sg94inzOdlua8oTUlDEisG57Y7kd/8D6D/uuRDqNfAQqbPfHEqa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063741; c=relaxed/simple;
	bh=Ci6UDfbEkgVHJ1O4+ijHMWfFl/HnYN5BhA5QGugHCIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JXEADqq2cj+OQpe+6ijYKYWQTZyUXr3Ph7YfPXilUvUt7t0jY6e7n6TOMLgPqLMeP154DhOvUXZCYi7SQd8YlUP/n1SSWlSxUepyUYiiWT2feQ+EFMPf0/vRrZsTFHrKIrlcgiNPuGU+b9dqrO2GhEb6KMeM7P+2tU1bpuSGA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2NwM+QZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 658B7C4CEC6;
	Fri,  4 Oct 2024 17:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728063739;
	bh=Ci6UDfbEkgVHJ1O4+ijHMWfFl/HnYN5BhA5QGugHCIQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=O2NwM+QZbvTbzSsnrATl5bbMRoudsCzXv2DY1qyUHAvYhzasK/Pe9TEDOy3JjNo76
	 USZW9Ok+uAGfQLZhN92Edshlfbts1zjYEcGnpcaa/L2A5BqqwD4KyHJdvIzhLouP9e
	 xRuP/jXF8hhUOA5y/LEIlV9U+apffT2KHDCQYuCevX1EqPRQmNZiLJPuc3ubcoK+d8
	 ZGXYENKP0RHwKk+a2dmq9afgcwYrzFEqmEXWY8sEWq9QXnK7PxedhGU8vW1n5gPcL0
	 PqKN784rkkliPkn10NHfqbWhL+pWlasMdO5Oq5lqsGhfN88SfbmwfDQaMRV1PXgys5
	 Pu/EkfVmPvuZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471CFCF8854;
	Fri,  4 Oct 2024 17:42:19 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Fri, 04 Oct 2024 23:12:16 +0530
Subject: [PATCH v4] Fixes: null pointer dereference in
 pfnmap_lockdep_assert
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-fix-null-deref-v4-1-d0a8ec01ac85@iiitd.ac.in>
X-B4-Tracking: v=1; b=H4sIAPcoAGcC/33MSwrCMBSF4a1Ixqbk1cp15D7EQZqHvVBSSWqol
 O7dtCOl6PA/cL6ZJBfRJXI+zCS6jAmHUEIdD8R0OtwdRVuaCCYUZ0xSjxMNz76n1kXnadN6zaQ
 8OW8kKadHGXHawOutdIdpHOJr8zNf159U5pRTplVtPVjGG31BxNFW2lQYyIpl8QmoHSAKIKS2w
 ADAWL4H5H9AFsCDqqHlxkDtv4FlWd4ZavzqMAEAAA==
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+093d096417e7038a689b@syzkaller.appspotmail.com, 
 Manas <manas18244@iiitd.ac.in>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728063737; l=2269;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=I6Jr34YY5WytSnppfZbbp0DlHGTntvqBvZhYI28pyh8=;
 b=ME9HVvF5BLf+ljmXjMr9EboNjFIhb6RD+gVbB7g2RRx5amHDSoLOzjd2z8J/zMByP+poVufwN
 wdbqRHYDoPoD+JIj9naERulOdKx0/x45vCt8hXKnMzwqnZDLR/Z1MRA
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
Changes in v4:
- v4: simplify ternary conditional
- Link to v3: https://lore.kernel.org/r/20241004-fix-null-deref-v3-1-f9459b1cc95f@iiitd.ac.in

Changes in v3:
- v3: use assigned var instead of accessing member again 
- Link to v2: https://lore.kernel.org/r/20241004-fix-null-deref-v2-1-23ad90999cd1@iiitd.ac.in

Changes in v2:
- v2: use ternary operator according to feedback
- Link to v1: https://lore.kernel.org/r/20241003-fix-null-deref-v1-1-0a45df9d016a@iiitd.ac.in
---
 mm/memory.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2366578015ad..4e4d598496a8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6346,10 +6346,13 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
 static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
 {
 #ifdef CONFIG_LOCKDEP
-	struct address_space *mapping = vma->vm_file->f_mapping;
+	struct address_space *mapping = NULL;
+
+	if (vma->vm_file)
+		mapping = vma->vm_file->f_mapping;
 
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



