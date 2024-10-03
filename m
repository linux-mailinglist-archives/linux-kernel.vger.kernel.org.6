Return-Path: <linux-kernel+bounces-349266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D56898F36C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0DB1C21628
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3770B19C56A;
	Thu,  3 Oct 2024 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uX2ypOsO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CD31474D9
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971283; cv=none; b=dVxbhbnmQ9FFOP7RL05rNXVmLRqRW3s9hX/eFXbYCAAtLUe91RsKQ5DWgIZpznF5VOrqjZtnHiouhOsjDkd5DzdL0KpAJYqVjeU0j2abXdp9V9/XRWPqBM/9oMmNCBbUbjmHctpHS4FiQtGRBs9ep63oNUDjqty94b3JzAqSAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971283; c=relaxed/simple;
	bh=CX2P0FldUD9UrvNzD9zJjNC6r+EokVwad4+jJnTO4Ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NL/SaiUMf7Vwvn31BOEwu+uO1jOZklWWI1dZD1jSsUXuHON++yP5/oBmGT5bokqgm6Ze5ZtBS9oZmWeWw5++QBOLfVNOxk3qKBK3xVBGgpI1morJT6lAP8LEGqKg+eSx63WJMA0kVyYAtNIAPniBPcw5tBEAZNwKFCWTf52ul2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uX2ypOsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 273DAC4CEC5;
	Thu,  3 Oct 2024 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727971283;
	bh=CX2P0FldUD9UrvNzD9zJjNC6r+EokVwad4+jJnTO4Ts=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=uX2ypOsORADHfL0GISRFpysTyz7sGD+mOYuGsZ+T+3e9PK1sopSXuutARdsDMSb1M
	 KB4BF+8ylaHLeyjhCGJOtE7s02XjZYJMeOubS7KYkS08I6DeK4qjPJTqBDmgWYpaP4
	 W6+l+fyJg5hR4kuOZcChwFa/mwq2iOjBi80Q29z1DfXaBqkukDZSxsSBHU35OHG9D+
	 NeFBwNRNPH98YNG0IVz4SwjpZFnEFWGLHRSQuZSwlcGPvxD8evO+H6mud7zd1YLZcg
	 wQG0rS76IEPrqEgKEyNybZwHqpE/+NhvjOET85n+0omP56yrxXWUoldD5vdQPkepvE
	 YHl+FEPqY9vEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B74CF34B2;
	Thu,  3 Oct 2024 16:01:23 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Thu, 03 Oct 2024 21:31:06 +0530
Subject: [PATCH] Fixes: null pointer dereference in pfnmap_lockdep_assert
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-fix-null-deref-v1-1-0a45df9d016a@iiitd.ac.in>
X-B4-Tracking: v=1; b=H4sIAMG//mYC/x2MSQqAMAwAvyI5G4itKPgV8eCSaKBUaVEKxb9bP
 M7ATIbIQTnCUGUI/GjU0xdo6grWY/Y7o26FwZBpGyKLogn97RxuHFiwW2Qma3uW1UKJriI1/cN
 xet8Pec9y02AAAAA=
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+093d096417e7038a689b@syzkaller.appspotmail.com, 
 Manas <manas18244@iiitd.ac.in>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727971281; l=1475;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=x08Dt4D4CnyqFeKnwiqo7wiyGAvva8Affj+d/SXsW+A=;
 b=Cn/tYNqn5B45YcZhsFYQSPD2ldhhhYgc5XE7ctAhBQhf7vIsn/RfiuzQUe+wgjx4v745x3D2z
 V5tBTMz6vKHBV2y4fcqeEqW0KI/UyEl3xFgDdg3DkuZcC0lzWWna4zG
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
 mm/memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 2366578015ad..b152a95e543f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6346,6 +6346,9 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
 static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
 {
 #ifdef CONFIG_LOCKDEP
+	if (!vma->vm_file)
+		return;
+
 	struct address_space *mapping = vma->vm_file->f_mapping;
 
 	if (mapping)

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241003-fix-null-deref-6bfa0337efc3

Best regards,
-- 
Manas <manas18244@iiitd.ac.in>



