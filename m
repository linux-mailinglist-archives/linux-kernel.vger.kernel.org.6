Return-Path: <linux-kernel+bounces-304070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EDD96199F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DEFD1F245B1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19731D4156;
	Tue, 27 Aug 2024 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="fnsRHhGz"
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4B1D365B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795977; cv=none; b=kEOojqxtG3/OZETPlXlZ11RwkQxegkf6pHv10AOasisGuBXlIoi16ToJOzkGEFwWcrjzwURHQojPd2RWjR5GtzBxKiEZeyfo9OSGVZTOtJVEiJwq1x3IDwAoJD++m7rAgTlvL61mBIStpYEk9HYH2nBmrm39WOgElvKdw+UeE1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795977; c=relaxed/simple;
	bh=AluzE7qot99z2jNjiIFCEQrH2MQfJi9fA0czYQ2Q3Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/Xt71WLE51bo36rybiXus9Fz9/jcKOc6MydzzKtMVVLw0L3Agt7aFJ0f5Vdhryg6wS1B3wbGx/3FKnS9h9hf6W5VJ60TE8SH0NsFZEpwMivrB4gdYqJUpQzDkWz0GeLtASDurEY4GrajoTICE56AlF0tHyPbtZ/RUHU8g+l1/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=fnsRHhGz; arc=none smtp.client-ip=17.58.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724795974;
	bh=30VxiSUVs/itezQY+QL9VDeWXfeP3dXU+aE6Ix49Yls=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fnsRHhGzMi3RMoWOw+H4oef1K/3JQftN4+yKizMG7vadaTHWCDD+sl9qZboq1K1+q
	 n2Q8Hv0/WrXK3ADLJ3rhTHVof3MJ7i/CStuGyETy3E9RIRB/hMJ49CvAV+l3c3l2gt
	 +sTycgt4MLSZJJwxajNWfVkbrZWNKxA59UwlFrGfnP+ynxxMaPpj9YovVUhIk8iZ+O
	 w+RYOD5BjhDIsWlz/6N/4oO7x3gt3C+lAx9Sagxy6zY0Ft0dw1xYVf3N1ZwSCs7AOv
	 Mvk74VrI3Hd7FLdULZiJ4k/69vWtrknNNuJtoAZh4f5PLwpuxBTDEjhTLD/WMWSihh
	 MiNNPBHoSQdeA==
Received: from linux-luka.tailf878.ts.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPSA id 667F1305830F;
	Tue, 27 Aug 2024 21:59:33 +0000 (UTC)
From: Theodore Dubois <tblodt@icloud.com>
To: linux-kernel@vger.kernel.org
Cc: Theodore Dubois <tblodt@icloud.com>,
	Ryan Houdek <sonicadvance1@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	David Hildenbrand <david@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH] prctl: allow prctl_set_mm_exe_file without unmapping old exe
Date: Tue, 27 Aug 2024 21:59:30 +0000
Message-ID: <20240827215930.24703-1-tblodt@icloud.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YNBN0bnEFnQnMFl8jpPpGh3CBI8zmDxL
X-Proofpoint-GUID: YNBN0bnEFnQnMFl8jpPpGh3CBI8zmDxL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408270161
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

As far as I can tell, the original purpose of this check was simply as
the easiest way to work with a quirk of /proc/self/exe at the time. From
the original patch[1]:

    Note it allows to change /proc/$pid/exe iif there
    are no VM_EXECUTABLE vmas present for current process,
    simply because this feature is a special to C/R
    and mm::num_exe_file_vmas become meaningless after
    that.

num_exe_file_vmas was created to preserve a quirk of the original
/proc/self/exe implementation: if you unmapped all executable VMAs,
/proc/self/exe would disappear (because it worked by scanning the
address space for the first executable VMA.) Keeping the quirk after
switching to just saving the executable on the mm worked by keeping a
count of executable VMAs in num_exe_file_vmas, and zeroing exe_file when
it reached zero. You can probably see how it would have been annoying to
handle both num_exe_file_vmas and this prctl intending to change
exe_file, and it's easier to only allow changing exe_file after
num_exe_file_vmas has already gone to 0 and made exe_file null.

However, num_exe_file_vmas no longer exists[2]. This quirk was taken out
because it would save a bit in the vma flags, and it seems clear by now
that nobody was relying on it. These days you can simply update exe_file
with no interference.

Recently a use case for this prctl has come up outside of
checkpoint/restore, namely binfmt_misc based emulators such as FEX[3].
Any program that uses /proc/self/exe will, of course, expect it to point
to its own executable. But when executed through binfmt_misc, it will be
the emulator, resulting in compatibility issues. Emulators currently
have to attempting to intercept syscalls targeting /proc/self/exe to
redirect the path, and this is not possible in the general case
considering how flexible path resolution is. For more detail on this see
[3].

The above seems to me like a solid case for simply dropping the check.
It's also worth noting that it is already possible to achieve the same
result by the laborious and complex process of just unmapping all your
code and remapping it again after the switch (just remember to put the
code that does this in a .so!), so this is not strictly allowing
anything that wasn't allowed before. It's just cutting red tape.

[1]: https://lore.kernel.org/lkml/20120316210343.925446961@openvz.org/
[2]: https://lore.kernel.org/lkml/20120731104230.20515.72416.stgit@zurg/
[3]: https://lore.kernel.org/lkml/CABnRqDdzqfB1_ixd-2JnfSocKvXNM+9ivM1hhd1C=ejLQyen8g@mail.gmail.com/

Signed-off-by: Theodore Dubois <tblodt@icloud.com>
Cc: Ryan Houdek <sonicadvance1@gmail.com>
Cc: Guilherme G. Piccoli <gpiccoli@igalia.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
---
 kernel/fork.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f..407e515b9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1430,30 +1430,8 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
  */
 int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 {
-	struct vm_area_struct *vma;
-	struct file *old_exe_file;
 	int ret = 0;
 
-	/* Forbid mm->exe_file change if old file still mapped. */
-	old_exe_file = get_mm_exe_file(mm);
-	if (old_exe_file) {
-		VMA_ITERATOR(vmi, mm, 0);
-		mmap_read_lock(mm);
-		for_each_vma(vmi, vma) {
-			if (!vma->vm_file)
-				continue;
-			if (path_equal(&vma->vm_file->f_path,
-				       &old_exe_file->f_path)) {
-				ret = -EBUSY;
-				break;
-			}
-		}
-		mmap_read_unlock(mm);
-		fput(old_exe_file);
-		if (ret)
-			return ret;
-	}
-
 	get_file(new_exe_file);
 
 	/* set the new file */
-- 
2.46.0


