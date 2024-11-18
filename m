Return-Path: <linux-kernel+bounces-413532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303959D1AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0502831E4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6168B1E7657;
	Mon, 18 Nov 2024 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DQz2+WS4"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B1D14D71A;
	Mon, 18 Nov 2024 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965893; cv=none; b=o+CjacdodQteWr1dgKFMMm4/8D6DjVPzmR3XbT7sK0n3WL3HP9l+KKJU1Se3z8Er3HLIUpcGbUJYhiMDGysJ7pNONlmQJeIyGlbx3fDu1DyECHsuWZbRRz8J2iEnJdMHYA78R1AeXE9da0j50isyMbjTdHoldxoxJ6dbwJ5U7/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965893; c=relaxed/simple;
	bh=UNg6qY2w/vPJZEPaRf1+NeUjUf7xuNclQpzB0R+mkU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cx/gMyQ2Y0KU6UZ3VsvXdz8ZpDYY9gA6jlmhdoxWL4M9YsAhhZnX0MUu6H81jrq2JfHcLGshad7J7GY7bssNIeryu/79/Jeg/320ORFyBk2Mplwq/CT5u1R2pttNi+X+5hfN5VxKMHg/aqBNoqlodtcNCQw9HUOeW2u8gvj2VDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DQz2+WS4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xtGptwAPqUHyxRvP/wAQ+2bFiCnqxRoaLpG+WpTq/e0=; b=DQz2+WS4LWUMHyB52nprtsJARA
	QbsQouioQs0VLOrmQx8/qA7ChTOeRBJIoNazS/4WvuP1rayjV5j+VUPktnzaiAQRHMN/cOSgQA9bY
	7c559BKFnmRT9w+B48A+3ndQq3vxdA25ObOp8B71kxtoUOxu5m3EXW0QBXSezHAP3+1dpTaLLnWEF
	twXIOvO7X9LicR3aY69Ccjo75tTbt9DTriUW7sKUKPPrAGfsoDLaNjacxpj0kCeUTO8k2UQUuhYpi
	guxkQc/cvPBtU0PqbhTp3NFz7VKsUxecWjAVNY6lUHLkreqdffGtlJ8FlDGHn4XU/QwwdzBaGb8oC
	gGg09V8w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tD9Rg-0000000GW0v-3Hot;
	Mon, 18 Nov 2024 21:38:08 +0000
Date: Mon, 18 Nov 2024 21:38:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] statx stuff
Message-ID: <20241118213808.GI3387508@ZenIV>
References: <20241115150806.GU3387508@ZenIV>
 <20241115153344.GW3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115153344.GW3387508@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[now that the part shared with vfs.xattr2 is merged...]

The following changes since commit e896474fe4851ffc4dd860c92daa906783090346:

  getname_maybe_null() - the third variant of pathname copy-in (2024-10-19 20:33:34 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-statx

for you to fetch changes up to 6c056ae4b27575d9230b883498d3cd02315ce6cc:

  libfs: kill empty_dir_getattr() (2024-11-13 11:46:44 -0500)

----------------------------------------------------------------
sanitize struct filename and lookup flags handling in statx
and friends

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (4):
      io_statx_prep(): use getname_uflags()
      kill getname_statx_lookup_flags()
      fs/stat.c: switch to CLASS(fd_raw)
      libfs: kill empty_dir_getattr()

Stefan Berger (1):
      fs: Simplify getattr interface function checking AT_GETATTR_NOSEC flag

 fs/ecryptfs/inode.c        | 12 ++----------
 fs/internal.h              |  1 -
 fs/libfs.c                 | 11 -----------
 fs/overlayfs/inode.c       | 10 +++++-----
 fs/overlayfs/overlayfs.h   |  8 --------
 fs/stat.c                  | 24 +++++++-----------------
 include/uapi/linux/fcntl.h |  4 ----
 io_uring/statx.c           |  3 +--
 8 files changed, 15 insertions(+), 58 deletions(-)

