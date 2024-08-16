Return-Path: <linux-kernel+bounces-289573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0EE9547BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553BE1F21D63
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D121A01C3;
	Fri, 16 Aug 2024 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="MZTOoSc1"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9E319A281
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806899; cv=none; b=JR3WOpeOm0dbwc1lTe82QjJ/rrdY0MInOWPDtuguT7Nk1c4iAUFc8PUashcgzNqyqNvXXuAcJDiYi1iBVuGGQ9P4GLbNdC2wHh7D4qkXGy6j2dl0TM7YPkri97fnttOl2bgGjMuK3SQL4D1Qb1iHPMANcGLkF8x7tkksLIcXFt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806899; c=relaxed/simple;
	bh=ZSGr4XqB+y0hjr2trf0mRlq3oYj89whjsNwDeM3EHqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pujGVcHNR+NwXOPLq7Dx/v9Fr/LE1RoBbFytg/3muy3UxYYX3oiBhfz73D3UYM1JKOqodBgbeoTJxPRRYREXpEDveBeqf7t3v0RE5C0V+eTekHkvJiU2gE3XhmLrjdf4CmRgvHYB1BuJ5kMAJPx2LWgXrdEoHBoSyhW8gEepCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=MZTOoSc1; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806855; x=1724411655; i=spasswolf@web.de;
	bh=VPwjhtww3tPPlpRtXDZX8Ow2MnpNsc9bFboKd/hL7S0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MZTOoSc1OOvlWPbJwu0k7w5VaxsGf1UGNQe3x+zcnHoKMHAro3EArIHbO3/gDuNZ
	 oDUNctcCWOIooYBx3vIrg5dLCVfMvxmpgoWZ+L5TeCw5O8YuAtkW338LEX9h37Wsk
	 z5yJ7UU9jmzGHxNUdd5IjpD/QtQrs4SbMEjiSZ4FZUmVJHb0AiI82ID9eFi2oOJ5m
	 9rujpw7O2WTqgbcE6K/RZ0rNO71fsdqfkoZTXF4OM5UqH9s66Oo/ZNZHmmaLfxb0g
	 X2lovkM7VEGTzwPf2z//OZtiV8km9VgYxSD0U48TwNuG0AVI5I3ugH5H76KWi1E/U
	 ijKCI73VweYlw6qaDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MPrLN-1srLWe2cJn-00Thi5; Fri, 16 Aug 2024 13:14:15 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	sidhartha.kumar@oracle.com,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jiri Olsa <olsajiri@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v5.1 00/19] Rebase v5 patchset to next-20240816
Date: Fri, 16 Aug 2024 13:13:41 +0200
Message-ID: <20240816111405.11793-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CUFDoYc++9zo/suM14zb6A1KPLhd554oKzT20ehlOvRLuZYUji3
 JUqAV62LAmS0i+D90DlahMTbsu04Gc8BaV8BBJdpMz8mQJzWqKuMIA0Uw+KdjBv9ENCA3oD
 ZcfTJQL5Gkp0Ncr//+kHZ82WmtJ9BINRhWxEJBjdbJqado1zU8u5WuyDckG7AMFWUJTwmqD
 SFYA8QWUdaIWVYX/ErRaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TfdXJYxdSmA=;ND/yBPCcZRzwZOIKNzrL5nnUofd
 0zRhpPBvXyFqCVan5RlCti+9/RoH2oW7I/yc7qI2h0Dd8WKCpX8vprUTKz5KOXHSmhueSI9Kl
 SL5lXFkcuwMBqmlBVo/NMxNbPhsk/ajMAxIy6uBdsA3lblYXbMaq0jAPsnpjkgNmqbTRgAj/7
 y+5FddNJBQr0izEKh+W500izFE9vzZGLR+CgHPofQJqV0vnq6dKtWfeON1llMF89Q226OPPgz
 I84m9LqGSIJpDvwSIXHqSlEKmRP01ab23d46PxLrZ61cgbGY6FxD8deitamU71AbZzJ3lXE7B
 ERep06nrM3X4qCHZA/BCxcCkHRKg2zO7+yFLUSRDzC/CnnywE+WChiijzZLox8lzS7oQZ+6Os
 njuvO34yUlZQ+1DswrsdXPlfSe3mJT5MHK8bDWb1hBdjFOPG/p5++uhHDcL/MZKOXItbWm0d3
 UmyzOYLUYDUPeeg8mKIl1Wln1FnhWU1huKr7gQvfA9g6j00C8BrubVEFnwbDTgXX8o5JQQs/p
 bOHS2Gh3sC8So6ZT+yfFaTf6BY6M73jIIeQNHbreQIt/JLvdnWrjMBd8VwnPPkcNpaUByried
 M0TWM+IGk3W9QKCKtevMEcPxSk7hNqi2D2zk0IyAInwBpUjV5LTx95v9Sb/E+PHJVfqWzkoUM
 3MvI0MEIvRpjreFLoTtTqfE4xTWrI4FPSEFt6VvZ5MEIVR4Qh/4YrlF8/PUaEhYdn2uTPHJDw
 PNZmHrwC/BFpBRWqOH8PrrR4nqF6ChLGoaHseMwtibzwJUN5li5O4BrxubBM7pG9eByGCKLeP
 ljZD3VVB5MdHe7ggyCoPxUsQ==

Since the v5 patchset some changes have taken place in the linux-next tree
which make it impossible to cleanly apply that patchset. The most importan=
t
of these changes is the splitting of the mm/mmap.c into mm/mmap.c and mm/v=
ma.c
and the splitting of mm/internal.h into mm/internal.h and mm/vma.h. Also
arch_unmap() has already been removed from mm/mmap.c in next-20240816 so
there's no need to take care of that.

When testing this with `stress-ng --vm-segv 1` dmesg show errors like

 [   T3753] coredump: 3753(stress-ng-vm-se): over coredump resource limit,=
 skipping core dump
 [   T3753] coredump: 3753(stress-ng-vm-se): coredump has not been created=
, error -7
 [   T3754] coredump: 3754(stress-ng-vm-se): over coredump resource limit,=
 skipping core dump
 [   T3754] coredump: 3754(stress-ng-vm-se): coredump has not been created=
, error -7
 [...]

this is most likely not a problem of the patchset but instead caused by
a more verbose coredump introduced in the following patch:
https://lore.kernel.org/all/20240718182743.1959160-3-romank@linux.microsof=
t.com/

Changes since v4:
 - rebase on next-20240816
 - some functions which were static in the original v5 patchset
   are now non-static as they're used in both mmap.c and vma.c
   (an alternative approach to this would have been to leave
   them as "static inline" and put them into vma.h (at least if
   they're only used in mmap.c and vma.c))

Bert Karwatzki

Liam R. Howlett (19):
  mm/mmap: Correctly position vma_iterator in __split_vma()
  mm/mmap: Introduce abort_munmap_vmas()
  mm/mmap: Introduce vmi_complete_munmap_vmas()
  mm/mmap: Extract the gathering of vmas from do_vmi_align_munmap()
  mm/mmap: Introduce vma_munmap_struct for use in munmap operations
  mm/mmap: Change munmap to use vma_munmap_struct() for accounting and
    surrounding vmas
  mm/mmap: Extract validate_mm() from vma_complete()
  mm/mmap: Inline munmap operation in mmap_region()
  mm/mmap: Expand mmap_region() munmap call
  mm/mmap: Support vma =3D=3D NULL in init_vma_munmap()
  mm/mmap: Reposition vma iterator in mmap_region()
  mm/mmap: Track start and end of munmap in vma_munmap_struct
  mm/mmap: Clean up unmap_region() argument list
  mm/mmap: Avoid zeroing vma tree in mmap_region()
  mm/mmap: Use PHYS_PFN in mmap_region()
  mm/mmap: Use vms accounted pages in mmap_region()
  mm/mmap: Move can_modify_mm() check down the stack
  ipc/shm, mm: Drop do_vma_munmap()
  mm/mmap: Move may_expand_vm() check in mmap_region()

 include/linux/mm.h |   6 +-
 ipc/shm.c          |   8 +-
 mm/mmap.c          | 146 ++++++++---------
 mm/vma.c           | 397 +++++++++++++++++++++++++++++++--------------
 mm/vma.h           |  61 ++++++-
 5 files changed, 403 insertions(+), 215 deletions(-)

=2D-
2.45.2


