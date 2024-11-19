Return-Path: <linux-kernel+bounces-414685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC809D2BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619D128A959
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D30B1D0E34;
	Tue, 19 Nov 2024 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WzjM8rZS"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF5F1CF2B6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035669; cv=none; b=sLnUNY1jKEfiz0YSJ6/LB92+ezKly/XbX6oagX/HMWoCuKPSsieGcUGLSYgT6UVaX4ucKflpS7tdsS/eM8aBB3fSk5pWpVDGUj9mtb0rshCLjqNAelBivJ7LKxU3VKirT8tTdfN+VuA1dr+EB2EThFCBZapMIyLj0pdvTgJpzfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035669; c=relaxed/simple;
	bh=eob+ypc2Lu30cArbOXKdPel5qfMWbBQnnI2bVzIb1Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NA/EoxzwSlHLaKhs/JkX11t3/E/J5XxP7pozzKc59jtKFmCOYwYTw6Wxwgu1pFpYLJapMO18IJpIILsGdLFPCdQ+LOu44m869DU4ynNm3gvN98S/UC8v/vG9dUUY7jTYt5FecNm3vKMTwBqPn2b7IHtP8J+gPdH54CBg2hxb/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WzjM8rZS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=YL26kTDc7pIB+PZioSqpDpd5IgCWpaAm3sHWRfJOSdA=; b=WzjM8rZSQj7PMXrwDeRyRs7vGz
	/Lv9cKqSMXJ7369pDbnc7kbbr4SPuYMMqWFi20Z4btIarPNaWxqNcQhN+dWoDW3/XYXcFyi53FTDW
	oGlv3dfq6yRG5IYU4LSIJoaX6BnqnFhoFZvrLEotbcBRkKEQ8zTSXuuW2bOLAGKWPQm/VxZwiQF4W
	PxakfqyZuVvgfPUoU9uflfKeWqe9sor49k2JumAX79Eoj42pivde4NxXDnJSaHc4KrJ7qg1BEVr/J
	sNBO8+k/xLcjgsMUs4o51XjgD2lcrwssgVkyy2wMxG+cl7jnKzNJr0q5p6RMavSTc/T1UkFbWPXVo
	uO98RtIA==;
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDRb7-0000000D8m6-3k78;
	Tue, 19 Nov 2024 17:01:06 +0000
Date: Tue, 19 Nov 2024 18:01:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Subject: [GIT PULL] configfs updates for Linux 6.13
Message-ID: <ZzzETmfaH0rI6keT@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 0a9b9d17f3a781dea03baca01c835deaa07f7cc3:

  Merge tag 'pm-6.12-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2024-11-13 13:32:51 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-6.13-2024-11-19

for you to fetch changes up to 84147f4e84c4f4822006161c5ad43612ac906407:

  configfs: improve item creation performance (2024-11-14 07:45:20 +0100)

----------------------------------------------------------------
configfs updates for Linux 6.13

 - remove unused code (Dr. David Alan Gilbert)
 - improve item creation performance (Seamus Connor)

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      configfs: remove unused configfs_hash_and_remove

Seamus Connor (1):
      configfs: improve item creation performance

 fs/configfs/configfs_internal.h |  4 ++--
 fs/configfs/dir.c               | 42 +++++++++++++++++++++++++++++++----------
 fs/configfs/inode.c             | 25 ------------------------
 3 files changed, 34 insertions(+), 37 deletions(-)

