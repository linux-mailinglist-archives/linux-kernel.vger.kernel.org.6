Return-Path: <linux-kernel+bounces-281972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC24694DDAB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 18:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A8F1F21966
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 16:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704B515FD08;
	Sat, 10 Aug 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V1LupBcC"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5B4C8D1
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723308413; cv=none; b=XPumL2MdJF63VnxUI1ximQZncMm09Tz1AL2pcr6gVJwA2jvAKOFd12grlpJ4r49zTj8ipzQsZnVNOSYxXt36Z0pneQZuWpxEehdAG720BgZdE/q0lGDPbRjb/gZGuU59I2Xo/ku/2t8jb6fq4MCxRVoEDr1SNqmOhnErPLKB6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723308413; c=relaxed/simple;
	bh=bfnR4igTd31hetD3SeggPVAVK0siUv0Dltv045RMUgs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nOb8lmnbRc+/uXilATI5/0d1qygA+OaQw8abwAqwGIYqMU7H1zgvXIPbxOYOSF/62cxh1k6740iD1NwgJSSlcOcuUVZxjsJHPxc7OWNsgEB1SB7VX3Rk3DVBAXLLdNTlWTXbRYYcLtwlJF8leD+eFR3fx5uu+wgUjAG0l1xs7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V1LupBcC; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 10 Aug 2024 12:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723308408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GTAtiq9a1tDqKGHvnm7aeu0MmXvvOjjkO4tGzjJl3Xk=;
	b=V1LupBcCZH2fJFUqp+7OT6IxfxiWP4AaZqi8hqWJFkXbghB2o8VdwodYRjzULMc7IFJaRM
	8ZYAYbB/Q/0AfPjz7ByU/uhqz9tJpkqeaUAWn0Td8492MNKVUk2doqrsBFA6E+oL1CXwYS
	bYQRrC2jLASkMqaDJX+IPBUnPXvy7H8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.11-rc3, more
Message-ID: <f6bxn2o6l3mt63rjaclzcyl64y4cna5sxpnktlh5ws6ezgtdzd@ga3tq6ak64pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, couple last minute fixes for the new disk accounting.

Cheers,
Kent

The following changes since commit 73dc1656f41a42849e43b945fe44d4e3d55eb6c3:

  bcachefs: Use bch2_wait_on_allocator() in btree node alloc path (2024-08-07 21:04:55 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-10

for you to fetch changes up to 8a2491db7bea6ad88ec568731eafd583501f1c96:

  bcachefs: bcachefs_metadata_version_disk_accounting_v3 (2024-08-09 19:21:28 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.11-rc2, more

- fix a bug that was causing ACLs to seemingly "disappear"
- new on disk format version, bcachefs_metadata_version_disk_accounting_v3
  bcachefs_metadata_version_disk_accounting_v2 accidentally included
  padding in disk_accounting_key; fortunately, 6.11 isn't out yet so we
  can fix this with another version bump.

----------------------------------------------------------------
Kent Overstreet (4):
      bcachefs: Switch to .get_inode_acl()
      bcachefs: bch2_accounting_invalid()
      bcachefs: improve bch2_dev_usage_to_text()
      bcachefs: bcachefs_metadata_version_disk_accounting_v3

 fs/bcachefs/acl.c                    | 11 +++---
 fs/bcachefs/acl.h                    |  2 +-
 fs/bcachefs/alloc_foreground.c       |  2 +-
 fs/bcachefs/bcachefs_format.h        |  3 +-
 fs/bcachefs/buckets.c                | 12 ++++---
 fs/bcachefs/buckets.h                |  2 +-
 fs/bcachefs/disk_accounting.c        | 65 +++++++++++++++++++++++++++++++++++-
 fs/bcachefs/disk_accounting_format.h | 15 ++++-----
 fs/bcachefs/fs.c                     |  8 ++---
 fs/bcachefs/replicas.c               |  1 -
 fs/bcachefs/sb-downgrade.c           | 27 ++++++++++++++-
 fs/bcachefs/sb-errors_format.h       |  6 +++-
 12 files changed, 126 insertions(+), 28 deletions(-)

