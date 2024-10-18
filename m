Return-Path: <linux-kernel+bounces-372559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDAE9A4A4C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBEB1F23BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12DD1917E9;
	Fri, 18 Oct 2024 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="s8lYF/8O"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEDA18C93C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729295534; cv=none; b=gP8qLlrnF0NaAYlIvwXI3xrlbj+2d1an/0qxmvmcUQGSILXRJgljU41gBmPns4BjadAdN+B+EWmCOTXhuXC2UP44Nt1ZM0H88nnJqFIG7vCrboXatbIdNWC+Kax9mni/hb4PSkzkZkHFOCAp86XQdlzJ6zjgCFJnXeiJiLZRrMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729295534; c=relaxed/simple;
	bh=OxY9Q1tiKFv9F6E1b4/6a8e/ANMJ02eAI6eokcUakNU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z9hhNTiSqO4DClOX3PM9pWZi2SMnA7fex1NpwOvnRTu1WzDPiw8gzrje3/t3gl7qPmsvbAe+/nq8njziBGF39K3G/5VknIGh3BlekaNyKttksU1LfzcqNLARjUSo/qd4rOHrgB6ewT/R3zEZSTocC3MTKnSpVxV6vuOSiC8WVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=s8lYF/8O; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5396514C1E1;
	Sat, 19 Oct 2024 01:52:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729295523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=YLWxW+rt13XcBnLClpIjcUjwEi7QRMT/CGkxYg0YTAE=;
	b=s8lYF/8OC5lZXqK4Tvf7eNmu76rO4oI9SEO5FT4EcsafQPkSZl7U5cCEG5zEqC0oZCmaw3
	biYs0EDEE9D3JhMNHsCR3/iwJ+Uoyi8SlFPRxxl7cLdXF5+19lzPk7uvBSlxKsbiFf34nQ
	C4RM7FnhQxKCTd78APZWxLYzX21JTYkOBK5P9d2x/i2dC9FoMJLTR/Skf16CivP598kytU
	xGPE3N3avdo7G0ImBMFli6pnehhTBGVlsghOcue2ffhmzNYF9ekL/dQIUBNhc0+RX530Z7
	4eBxl5FlT9JPlNmKylRqhCxUu04Ct1zIBp9pthdJ0YFdxkYbL1gXUFyJhss4dQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e8b7294a;
	Fri, 18 Oct 2024 23:51:59 +0000 (UTC)
Date: Sat, 19 Oct 2024 08:51:44 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [GIT PULL] 9p fixes for 6.12-rc4
Message-ID: <ZxL0kMXLDng3Kw_V@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The following changes since commit 98f7e32f20d28ec452afb208f9cffc08448a2652:

  Linux 6.11 (2024-09-15 16:57:56 +0200)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.12-rc4

for you to fetch changes up to 79efebae4afc2221fa814c3cae001bede66ab259:

  9p: Avoid creating multiple slab caches with the same name (2024-09-23 05:51:27 +0900)

----------------------------------------------------------------
Mashed-up update that I sat on too long:

- fix for multiple slabs created with the same name
- enable multipage folios
- theorical fix to also look for opened fids by inode if none
was found by dentry

----------------------------------------------------------------
David Howells (1):
      9p: Enable multipage folios

Dominique Martinet (1):
      9p: v9fs_fid_find: also lookup by inode if not found dentry

Pedro Falcato (1):
      9p: Avoid creating multiple slab caches with the same name

 fs/9p/fid.c       |  5 ++---
 fs/9p/vfs_inode.c |  1 +
 net/9p/client.c   | 10 +++++++++-
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
Dominique Martinet | Asmadeus

