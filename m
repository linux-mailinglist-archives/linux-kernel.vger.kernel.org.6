Return-Path: <linux-kernel+bounces-523988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149F4A3DDC0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8778D17C5B8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81C01FECB7;
	Thu, 20 Feb 2025 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vl+IkqFz"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1113B1FECAA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063781; cv=none; b=qE0Dc9Q8zcvkhEgxF+uSZmCg/LNMdN7IisyVBf8v0Pe8IsMciQSUolt94iPi2wFehdNVasyJalEL36cLqligGOyPEoJ6LnP3NfKY5YYaejqhCR0LfOlSWaZH+NyhM+wNZK3E3yZz4d0dDjHBCzf3fzcMmDtNOFcey1BZABAQQCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063781; c=relaxed/simple;
	bh=wwBHTs+sOXIL4eNZZxmDAA65fFj45C/TjQNtTRxt/Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=amQkT65jFq9nVDVxHeKud8xBJlyEASW0aCHi1lWC440wBuTqawqp7wM7Ma0Ub2hyFAWooxP+pR5UhATGp9HvYKkAclugMTrR7CgHLZNVNiEkNAT6a1arWM6MN9N16gKOPb20a95/+Y38U02DPZek8MXvWPf4K6FItznYPa+StD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vl+IkqFz; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 10:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740063767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=gjisulrcCfnqTrlKqKcHH5By1FD7fBePRehepSr16PA=;
	b=vl+IkqFzSqBd4kyg4xSX0cegw9Uh8rQCrbuopdSseUqYMl/xI/kYcX9STn2cu2ybjtkKCT
	3hgHDSrLllbrQNg7/BbEhqoctSHMV6vrG2ke1FOH8JCiBafBtBVbL0qAIO3Ay8ayZL7wKf
	Rkn051ik5/DKk715Z5u/cDo530TCILU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.14-rc4
Message-ID: <jq44ty6ueeadfnlwsfihsvzzfxv64buipdncrb65q4lgaflezn@at52sul5ngay>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, another small one.

The following changes since commit 406e445b3c6be65ab0ee961145e74bfd7ef6c9e1:

  bcachefs: Reuse transaction (2025-02-12 18:44:50 -0500)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-02-20

for you to fetch changes up to b04974f759ac7574d8556deb7c602a8d01a0dcc6:

  bcachefs: Fix srcu lock warning in btree_update_nodes_written() (2025-02-19 18:52:42 -0500)

----------------------------------------------------------------
bcachefs fixes for 6.14-rc4

Small stuff:

- The fsck code for Hongbo's directory i_size patch was wrong, caught by
  transaction restart injection: we now have the CI running another test
  variant with restart injection enabled

- Another fixup for reflink pointers to missing indirect extents:
  previous fix was for fsck code, this fixes the normal runtime paths

- Another small srcu lock hold time fix, reported by jpsollie

----------------------------------------------------------------
Kent Overstreet (3):
      bcachefs: Fix fsck directory i_size checking
      bcachefs: Fix bch2_indirect_extent_missing_error()
      bcachefs: Fix srcu lock warning in btree_update_nodes_written()

 fs/bcachefs/btree_update_interior.c |  2 +
 fs/bcachefs/fsck.c                  | 78 +++++++++++++++----------------------
 fs/bcachefs/reflink.c               | 18 ++++-----
 fs/bcachefs/sb-downgrade.c          |  2 +-
 4 files changed, 42 insertions(+), 58 deletions(-)

