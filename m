Return-Path: <linux-kernel+bounces-391679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 196049B8A28
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 05:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814E71F22918
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 04:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF26137742;
	Fri,  1 Nov 2024 04:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lsJ/B6Z7"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0784E1C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 04:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730434166; cv=none; b=tLvvVO0LKUNrpn+3jzuHEDOMLPz/SUehyr5Fl3ZNdjIT62Y/PuXAuDECKbQlq+8IsOXgILMOHlOJ5WZFJn2RZWSNtzhfkNvB+HOQXWd5jFf5HQOS2nHoHvekvTVYdzpZ/joVEGpWxVphwZwtIol0A7QJILMWgqcP0PFrAixsv1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730434166; c=relaxed/simple;
	bh=TdUIHuVi/9ph7I5q2Va3gRk4gff0Cl8EHEqDPA8RXEs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=awpnTiDeV9BrY7TDLxmgGBVj9pZo9bqVA38NOf/MbZfMIAYTe55nwdK6mVaA7+KtC9MbQow8PRcFbruT3yZm2pG/YxOj8BljTfk0SZUFYvSIEdpd8hB8oBee/iQMb2D60C/4zDFps6UsJO+gIRsE6VS92UlEAL62J6l3voUg83s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lsJ/B6Z7; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 1 Nov 2024 00:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730434161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uTmhfDD80R+n+JEPIjWtz3k33zC9n8sn4NYC1W9JVZ4=;
	b=lsJ/B6Z72gxaNRk9rJwl47qOMUvi4hUDwRqTJg84GE57peuG7fZlHHQUPVCretPX+VGDVB
	rpvuDTqEcVNbde+NvnH/dxb03cRGH2i7w40LVpG3VUEE1rSqtO38ghufhTSI5Y1YtI+kn/
	EdI5jw/c3XyUs9LxF+qsqpUYUm61ssw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.12-rc6
Message-ID: <crtbzb56yioclpibocd7whnjit43dub4hoeycxd5fzvzsnqnou@i22opfzxvitj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Nothing crazy to report...

Test dashboard failures are down 40% from a month ago, critical bug
reports have dropped off dramatically (there are a few still outstanding
I need to get to; apparently there's still a bug with online fsck and
open unlinked files), and we're starting to crank through the syzbot
stuff (also, syzbot seems to have made it past the dumb "whoops, we
forgot to validate that" and is turning up some genuinely interesting
ones).

Been hitting some bugs in compaction (confirmed by users running with it
flipped off), and lately I've been seeing some sporadic test hangs due
to what looks like a block layer writeback throttling bug, ouch.

The following changes since commit a069f014797fdef8757f3adebc1c16416271a599:

  bcachefs: Set bch_inode_unpacked.bi_snapshot in old inode path (2024-10-20 18:09:09 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-10-31

for you to fetch changes up to 3726a1970bd72419aa7a54f574635f855b98d67a:

  bcachefs: Fix NULL ptr dereference in btree_node_iter_and_journal_peek (2024-10-29 06:34:11 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.12-rc6

Various syzbot fixes, and the more notable ones:

- Fix for pointers in an extent overflowing the max (16) on a filesystem
  with many devices: we were creating too many cached copies when moving
  data around. Now, we only create at most one cached copy if there's a
  promote target set.

  Caching will be a bit broken for reflinked data until 6.13: I have
  larger series queued up which significantly improves the plumbing for
  data options down into the extent (bch_extent_rebalance) to fix this.

- Fix for deadlock on -ENOSPC on tiny filesystems

  Allocation from the partial open_bucket list wasn't correctly
  accounting partial open_buckets as free: this fixes the main cause of
  tests timing out in the automated tests.

----------------------------------------------------------------
Gaosheng Cui (1):
      bcachefs: fix possible null-ptr-deref in __bch2_ec_stripe_head_get()

Gianfranco Trad (1):
      bcachefs: Fix invalid shift in validate_sb_layout()

Jeongjun Park (2):
      bcachefs: fix shift oob in alloc_lru_idx_fragmentation
      bcachefs: fix null-ptr-deref in have_stripes()

Kent Overstreet (5):
      bcachefs: Fix UAF in bch2_reconstruct_alloc()
      bcachefs: Fix unhandled transaction restart in fallocate
      bcachefs: Don't keep tons of cached pointers around
      bcachefs: Don't filter partial list buckets in open_buckets_to_text()
      bcachefs: Fix deadlock on -ENOSPC w.r.t. partial open buckets

Piotr Zalewski (2):
      bcachefs: init freespace inited bits to 0 in bch2_fs_initialize
      bcachefs: Fix NULL ptr dereference in btree_node_iter_and_journal_peek

 fs/bcachefs/alloc_background.h |  3 ++
 fs/bcachefs/alloc_foreground.c | 19 ++++++++--
 fs/bcachefs/bcachefs.h         |  1 +
 fs/bcachefs/btree_iter.c       | 13 +++++++
 fs/bcachefs/data_update.c      | 21 ++++++-----
 fs/bcachefs/data_update.h      |  3 +-
 fs/bcachefs/ec.c               |  4 ++
 fs/bcachefs/errcode.h          |  2 +
 fs/bcachefs/extents.c          | 86 ++++++++++++++++++++++++++++++++++--------
 fs/bcachefs/extents.h          |  5 ++-
 fs/bcachefs/fs-io.c            | 17 +++++++--
 fs/bcachefs/move.c             |  2 +-
 fs/bcachefs/recovery.c         | 14 +++++--
 fs/bcachefs/sb-downgrade.c     |  3 ++
 fs/bcachefs/super-io.c         |  5 +++
 15 files changed, 160 insertions(+), 38 deletions(-)

