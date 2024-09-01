Return-Path: <linux-kernel+bounces-310057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FE9967436
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 04:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C741C20F7C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 02:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21482BAE1;
	Sun,  1 Sep 2024 02:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KKTC2J6E"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55001E517
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 02:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725158659; cv=none; b=bdxuh9bkKGTwhNRrGed7hGUeq4RTDbbis9Lj9FVzy50nPGqp2pW9T8xhpdRv3MdHKsXqqdTGx/zjFU707Esf6xT2nFRLURnFwtrvU8VAnCpbeUFYyaoEZd1ZwtTz2gQXu11ASDomfQGllBsOQQONMPNxWOFr1QuDkZNfLGlV2iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725158659; c=relaxed/simple;
	bh=T0vJEr20YR9EI6JvkFASOgeagEnispNIS2R7rjFHidQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q1v3kIUKFPCkNk4j/PGUB+9xgmoBnGxQiRUX+nxlEV1Fuhn949LCaoKFCmeMq091PEryNZaDpdpnQ/jLQG3OSB3UuEQ2Q3qHO4KqiLb9g2pzgxZnxsBu/A4jKSQtpUb/G6ZJjMve8f2YbHLiFtecDxdsbHW2wt13Wr3/pfR9EiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KKTC2J6E; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 31 Aug 2024 22:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725158652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ClXa1gmMCVObHX6r1bSkfS0W6OLKBF4+9diKlyGhcm4=;
	b=KKTC2J6Ef7EIK5vwWYxWuT84ObtZbm97oDZCEO0mw25aFP1+4gvP8eYHL0yDE1oB7lqCsh
	yyZ3lx3C6i/6IIsSRDaEBOJJ1/d7LQuPqKJYh7oIk0QqWiNE3Eb/vciISvOraDW+bIfQpY
	JJ0/MrzjzokfPYA1MjGdmNgq1dgTKRU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.11-rc6
Message-ID: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, just a couple small ones.

the data corruption in the buffered write path is troubling; inode lock
should not have been able to cause that...

Cheers,
Kent

The following changes since commit 49aa7830396bce33b00fa7ee734c35de36521138:

  bcachefs: Fix rebalance_work accounting (2024-08-24 10:16:21 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-21

for you to fetch changes up to 3d3020c461936009dc58702e267ff67b0076cbf2:

  bcachefs: Mark more errors as autofix (2024-08-31 19:27:01 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.11-rc6

- Fix a rare data corruption in the rebalance path, caught as a nonce
  inconsistency on encrypted filesystems
- Revert lockless buffered write path
- Mark more errors as autofix

----------------------------------------------------------------
Kent Overstreet (4):
      bcachefs: Fix failure to return error in data_update_index_update()
      bcachefs: Fix bch2_extents_match() false positive
      bcachefs: Revert lockless buffered IO path
      bcachefs: Mark more errors as autofix

 fs/bcachefs/data_update.c      |   1 +
 fs/bcachefs/errcode.h          |   1 -
 fs/bcachefs/extents.c          |  23 ++++++-
 fs/bcachefs/fs-io-buffered.c   | 149 +++++++++++------------------------------
 fs/bcachefs/sb-errors_format.h |  10 +--
 5 files changed, 68 insertions(+), 116 deletions(-)

