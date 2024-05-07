Return-Path: <linux-kernel+bounces-171600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEDF8BE644
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7784028312E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09C15FA9F;
	Tue,  7 May 2024 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DumC/H3K"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A615ECF2
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092998; cv=none; b=QOZr2SZSI+Q3aGg4JSLB/DLjSqgc3CDo8oTnStYNkFMnPZhl8PmHqNOHUT2ONZDdn5Y2UIcnxVfhIa8osy2b1+NyDuKaI5zIPvxniXlerco4cc4E5BO5mJHOZ81Dw9V0RGaafYDU6BbIGAyW5Mfq+4FnQrYxUxvo3PTybOcNKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092998; c=relaxed/simple;
	bh=yMTYiE0yi2WG4jip/daktPxAKElfeIGSd2hHRBT8yE8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n1e7yg7QnIs57nQx2P9X85EwTdPfKrKZ7NTihMLSZkOKmt2hqOqBXu7e7e96mi1WRm4nVbPv7q1pvH8WD/PC/cmjcrjAFJdhqt2Mwjl1i/Oti30mosfmpIj1TPqni4jUjzavzhObO5THBkIEpTiiRaNiKbs+KK2n6LvFLv4V0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DumC/H3K; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 May 2024 10:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715092994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=sha76ykCa1g2wvPF/U7W10Wc8ZjbPd+Jmr0g6Xvn2xk=;
	b=DumC/H3KXeDU9ZS0hQ2zOM9me2PlDRkxJqlgMbzekLZ4hduOp4YQ/GHabXFnf9Dr8rYJ+d
	3M87SayNmH5HsjwHTnaR+Wayzrs+fAaV2rfvEA6gYuWsAS8BvRvKgwKRL6mv8qpQxpKGiM
	g5i85WETeEuW9LMSVFQfx6qMbNFG5vo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.9
Message-ID: <3x4p5h5f4itasrdylf5cldow6anxie6ixop3o4iaqcucqi7ob4@7ewzp7azzj7i>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, another stack of fixes for you.

Apologies for the size of the pull request, it's almost all syzbot stuff
which we just started receiving, and pretty much all simple validation
fixes. One user reported bugfix in here, a fix for an integer overflow
which was preventing returning the full list of extents to filefrag().

The following changes since commit c258c08add1cc8fa7719f112c5db36c08c507f1e:

  bcachefs: fix integer conversion bug (2024-04-28 21:34:29 -0400)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git/ tags/bcachefs-2024-05-07

for you to fetch changes up to 536502fc14db1fd3e12e6871828f773bd1ef854e:

  bcachefs: Add missing sched_annotate_sleep() in bch2_journal_flush_seq_async() (2024-05-06 23:12:09 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.9

- Various syzbot fixes; mainly small gaps in validation
- Fix an integer overflow in fiemap() which was preventing filefrag from
  returning the full list of extents
- Fix a refcounting bug on the device refcount, turned up by new
  assertions in the development branch
- Fix a device removal/readd bug; write_super() was repeatedly dropping
  and retaking bch_dev->io_ref references

----------------------------------------------------------------
Kent Overstreet (20):
      bcachefs: Fix a scheduler splat in __bch2_next_write_buffer_flush_journal_buf()
      bcachefs: don't free error pointers
      bcachefs: bucket_pos_to_bp_noerror()
      bcachefs: Fix early error path in bch2_fs_btree_key_cache_exit()
      bcachefs: Inodes need extra padding for varint_decode_fast()
      bcachefs: Fix refcount put in sb_field_resize error path
      bcachefs: Initialize bch_write_op->failed in inline data path
      bcachefs: Fix bch2_dev_lookup() refcounting
      bcachefs: Fix lifetime issue in device iterator helpers
      bcachefs: Add a better limit for maximum number of buckets
      bcachefs: Fix assert in bch2_alloc_v4_invalid()
      bcachefs: Add missing validation for superblock section clean
      bcachefs: Guard against unknown k.k->type in __bkey_invalid()
      bcachefs: Fix shift-by-64 in bformat_needs_redo()
      bcachefs: Fix snapshot_t() usage in bch2_fs_quota_read_inode()
      bcachefs: Add missing skcipher_request_set_callback() call
      bcachefs: BCH_SB_LAYOUT_SIZE_BITS_MAX
      bcachefs: Fix sb_field_downgrade validation
      bcachefs: Fix race in bch2_write_super()
      bcachefs: Add missing sched_annotate_sleep() in bch2_journal_flush_seq_async()

Reed Riley (1):
      bcachefs: fix overflow in fiemap

 fs/bcachefs/alloc_background.c |  4 ++--
 fs/bcachefs/alloc_background.h |  8 +++++--
 fs/bcachefs/backpointers.c     |  2 +-
 fs/bcachefs/backpointers.h     | 14 ++++++++----
 fs/bcachefs/bcachefs_format.h  |  8 +++++++
 fs/bcachefs/bkey_methods.c     |  4 ++--
 fs/bcachefs/btree_key_cache.c  | 16 +++++++------
 fs/bcachefs/checksum.c         |  1 +
 fs/bcachefs/errcode.h          |  1 +
 fs/bcachefs/fs.c               |  2 +-
 fs/bcachefs/io_write.c         | 30 ++++++++++++++++---------
 fs/bcachefs/journal.c          |  8 +++++++
 fs/bcachefs/move.c             | 22 +++++++++++-------
 fs/bcachefs/quota.c            |  8 +++----
 fs/bcachefs/recovery.c         |  3 ++-
 fs/bcachefs/sb-clean.c         | 14 ++++++++++++
 fs/bcachefs/sb-downgrade.c     | 13 +++++++++--
 fs/bcachefs/sb-members.c       |  6 ++---
 fs/bcachefs/sb-members.h       |  4 ++--
 fs/bcachefs/super-io.c         | 51 ++++++++++++++++++++++++++++--------------
 fs/bcachefs/super.c            | 15 ++++++++-----
 21 files changed, 161 insertions(+), 73 deletions(-)

