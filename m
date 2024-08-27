Return-Path: <linux-kernel+bounces-303346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDEC960B06
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FAD1F23519
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9158E1C68AE;
	Tue, 27 Aug 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="WX+766uD"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3C51BD036
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762891; cv=none; b=jfRIg+108gLa/5VAg/lQHcxGlNvI9wtcncieQEm7WOIYUZVpbs1edRgGdlxMD/DyMWfN7RwrNO8CfjpNyeTFvKoY7h3oJ2M/XW2QaTni3VdI3AruWoxBQm1bYvTVRB3zy0Abhqmek38LFi5rrO93AcI52y5ekx2vof79Wk5Zpd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762891; c=relaxed/simple;
	bh=ugX2ONV2WVwJ2dokF95ReYwtciLsRez1uhkDO9pEqOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IN5RfN6UDYCSvzyFV6z506K2AJF4mqowUu2sd5J8QjfOScK8S1hIUyDRYV0yKZ71xLzBPaE5IGD8Tbrri8nn85qblaeTcwWpanwsL86QtIncG4rj5h9aClTj3fYq+G2Z03JdJXZzavm/OgGbBJROCEWs4oI2xyg6nXTBUsIH9RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=WX+766uD; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47RClcnn021451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724762861; bh=ulL9KNB8cPUnmR8hlrRx3E0Z71q9MYe3SG4F8cO4teU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=WX+766uDRkwgWnuMlYRAhZSSCzyTjdCUo4iIzeKUKA0yJw0LEVrS6UyRVy7E8IMtx
	 Aa9QE/uNRfVfXNGa9VA5N9Qa7I4ULoX+73QZy/Bd7YGatvUK7AmYlR1UyqIe5vCp35
	 WEq9aF5E+r6kQtQdbPLuddQbywXWrS15zu/Xs05pVN+xsgAUMmWE5eCdXykXqRTgwz
	 8eC2L7HY8dqvfkMtMH2Sq4XFT6o3qRKwG0U9iQawkkeB6Ksrdmwea1odH84nSAbDLe
	 OQsRqE4wU1gW2vrcPBIyZAZM5MDi5vJxJDQVlTt7J/rw01tKWCnY1swNdZEe6p3Pak
	 r49lBODRgTy0w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B296B15C02C3; Tue, 27 Aug 2024 08:47:38 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
        stable@kernel.org
Subject: Re: [PATCH] jbd2: stop waiting for space when jbd2_cleanup_journal_tail() returns error
Date: Tue, 27 Aug 2024 08:47:23 -0400
Message-ID: <172476284019.635532.18117773418669271542.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718115336.2554501-1-libaokun@huaweicloud.com>
References: <20240718115336.2554501-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 18 Jul 2024 19:53:36 +0800, libaokun@huaweicloud.com wrote:
> In __jbd2_log_wait_for_space(), we might call jbd2_cleanup_journal_tail()
> to recover some journal space. But if an error occurs while executing
> jbd2_cleanup_journal_tail() (e.g., an EIO), we don't stop waiting for free
> space right away, we try other branches, and if j_committing_transaction
> is NULL (i.e., the tid is 0), we will get the following complain:
> 
> ============================================
> JBD2: I/O error when updating journal superblock for sdd-8.
> __jbd2_log_wait_for_space: needed 256 blocks and only had 217 space available
> __jbd2_log_wait_for_space: no way to get more journal space in sdd-8
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 139804 at fs/jbd2/checkpoint.c:109 __jbd2_log_wait_for_space+0x251/0x2e0
> Modules linked in:
> CPU: 2 PID: 139804 Comm: kworker/u8:3 Not tainted 6.6.0+ #1
> RIP: 0010:__jbd2_log_wait_for_space+0x251/0x2e0
> Call Trace:
>  <TASK>
>  add_transaction_credits+0x5d1/0x5e0
>  start_this_handle+0x1ef/0x6a0
>  jbd2__journal_start+0x18b/0x340
>  ext4_dirty_inode+0x5d/0xb0
>  __mark_inode_dirty+0xe4/0x5d0
>  generic_update_time+0x60/0x70
> [...]
> ============================================
> 
> [...]

Applied, thanks!

[1/1] jbd2: stop waiting for space when jbd2_cleanup_journal_tail() returns error
      commit: f5cacdc6f2bb2a9bf214469dd7112b43dd2dd68a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

