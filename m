Return-Path: <linux-kernel+bounces-562808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA54A63338
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 02:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84091891CB1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 01:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5E338DD1;
	Sun, 16 Mar 2025 01:41:58 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0EA125DF
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 01:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742089318; cv=none; b=Dl2maz5Rwor3c8Ls7U3RCXivmalvc3PrE7TEZRAvACWLbzYdwNZagciFO3oI4UFbsmzA3SpRN08wc6+r86xmwwmSEnfwgWYNb3ZcMYfcZkWr1qUgZG+0k4XZtmvJ+hIDESkio9AktEsw9hPyhQP7ZPeD4LlENF0lvA6LXgmLZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742089318; c=relaxed/simple;
	bh=MbbuSQi4mBYrMgsZZxi2rGjp2jWdbktMtR+80A8Jx+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzldSbKz6X62Z0whq/16EwxA+Uq2QY8Fd5WnH1CrFwwBsQBYS2JZTpi1ZmqRidvpmKT3EQmBodgDxFNRKzZfRTL9L7gVQ5E4TQvlch4iegr6qP+peyN9tl7ybYhVVau13qiqk0RNILcGRhlRcwaebPrFnj5CYRpam/RtPCTy7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52G1fSCw024135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Mar 2025 21:41:29 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 70BC42E010B; Sat, 15 Mar 2025 21:41:28 -0400 (EDT)
Date: Sat, 15 Mar 2025 21:41:28 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: cache es->s_journal_inum in ext4_sb_info
Message-ID: <20250316014128.GA787758@mit.edu>
References: <d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com>

On Fri, Mar 14, 2025 at 05:11:43PM +0530, Ojaswin Mujoo wrote:
> Currently, we access journal ino through sbi->s_es->s_journal_inum,
> which directly reads from the ext4 sb buffer head. If someone modifies
> this underneath us then the s_journal_inum field might get corrupted.
> 
> Although direct block device modifications can be expected to cause
> issues in the FS, let's cache s_journal_inum in sbi->s_journal_ino so
> our checks can be more resillient.

The reason why the block validity checks need to check against
s_journal_ino is to exempt the lookups done by ext4_journal_bmap()
from running afoul of the system zone checks, since the journal's data
blocks are considered part of the system zone.

So this is something we need to do if the journal is actived, and if
it's active, then sbi->s_journal will be non-NULL, and so we can just
check to see if inode == sbi->s_journal instead.  This will simplify
the code, without needing to expand the ext4_sb_info structure.

Cheers,

						- Ted

