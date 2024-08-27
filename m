Return-Path: <linux-kernel+bounces-303336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5244A960AED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851A11C22727
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30EB1BFDEF;
	Tue, 27 Aug 2024 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="kISk3PzH"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8345D1BE234
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762873; cv=none; b=OJB4wDEJ1P2SHnev2N0v9HLP2DsNjUErcf8t14ZORz7QEGxR0nz6FGxc1KlcDzbQ8t6VFFIsjm9e/YiKRF/UhMS2nN5VIlr+gUdeNnwriFxyHLNe7SiK7W+YDLjvSRHGxvZ748qdELFnvAel2bKgz6ikM3ZiR2CbQZrw438tCCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762873; c=relaxed/simple;
	bh=lMUQriP8UMLq/T6yewTOmusJHQkjdcZJHucQ45PVsDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0CGZiVX7Z+bmXQqYg0rKp7e7oZbQmzRJnjRLSENx/XTFoUj9xHtpv0as2KXA3VJAsrnJvLyCF/gBLsB36JUQxSgGL9tImts9RF5xMcpz2YYOmwKzziW1vIeaeW1kXCesLJr82dxHSTXDCpSLuKYDk77+jtkzR/UxOLEqGAS9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=kISk3PzH; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47RClftO021551
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724762863; bh=A6/ygQzAVqdVJxlGWdzzmumNiZui9LuRbVG9Wyw27Vk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=kISk3PzH6GEdxE63kKM36FJhh5xQMG7BXgCiu5sFCeklJDl4HKzUnDRkMMTbDOKqf
	 CRaWqVNtY7OjES3rKmXPpWa9TREWwPI5yD6EaULvBptEmYo9SW8MGAHT8g+KvVsvlL
	 N0ezbpVBGxHQML4WKrC0+oU2gMMcfKeN2GHT7+mZLUoRM+mvqWAtlOGBpXx9JucYhZ
	 UljYlygPyW97Q/MLpUuHwLApx5++59bZw2UgVN+P02FAgFx0zWg7PtZaHyy464y87c
	 0ATiPUfN4QR2woWwJQA5nKDBkD11tbMpKMdwtupwEKIeiOKDyhKKvxtfTDqRr3+URW
	 I4rh55eT7wkEA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C6D7E15C1D08; Tue, 27 Aug 2024 08:47:38 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] kernel/ext4: nested locking for xattr inode
Date: Tue, 27 Aug 2024 08:47:34 -0400
Message-ID: <172476284023.635532.2188826848588011043.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801143827.19135-1-wojciech.gladysz@infogain.com>
References: <20240801143827.19135-1-wojciech.gladysz@infogain.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 01 Aug 2024 16:38:27 +0200, Wojciech Gładysz wrote:
> Add nested locking with I_MUTEX_XATTR subclass to avoid lockdep warning
> while handling xattr inode on file open syscall at ext4_xattr_inode_iget.
> 
> Backtrace
> EXT4-fs (loop0): Ignoring removed oldalloc option
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.10.0-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor543/2794 is trying to acquire lock:
> ffff8880215e1a48 (&ea_inode->i_rwsem#7/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:782 [inline]
> ffff8880215e1a48 (&ea_inode->i_rwsem#7/1){+.+.}-{3:3}, at: ext4_xattr_inode_iget+0x42a/0x5c0 fs/ext4/xattr.c:425
> 
> [...]

Applied, thanks!

[1/1] kernel/ext4: nested locking for xattr inode
      commit: d1bc560e9a9c78d0b2314692847fc8661e0aeb99

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

