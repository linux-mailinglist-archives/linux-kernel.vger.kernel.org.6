Return-Path: <linux-kernel+bounces-310901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584989682A1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720201C21A7B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F6C186E4A;
	Mon,  2 Sep 2024 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8d5KG78"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF9EEC8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267899; cv=none; b=ETCQ9Heb/3f9KMONNIMTJq61R/yb5M4GX7djy9Myk6jxcrqkFqdF97Gwsu/URUdQP27GrUtF/yyOAIn+m12AMpCe9EnRoRPF+Cp34E9puMhM4kyUuwmOozDkBhvPHNlk4V2YHBcsITZDR1IBXXgNNW3lDFFl9WMVzqJh8JF2v0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267899; c=relaxed/simple;
	bh=KvXscvN78Ao8anzOavQBBAUcQkSkV1wlEFUurKNjQcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1kMENAP3IHRmZmfrDvRoZUQxADmWmkCnaHQIeezXxZ00mNn6SMNwE+QW4t+uv8ACdSbypPreVZvpNg4vIFKpB22M0T0UuDez3VNy0qyJnxNklFa6m+Cmt6R9MQS4m2bdA0iHPj1k2vud6cveGfxA5TRuL4kgWCVQMZZGFAHfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8d5KG78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279AEC4CEC2;
	Mon,  2 Sep 2024 09:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725267898;
	bh=KvXscvN78Ao8anzOavQBBAUcQkSkV1wlEFUurKNjQcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8d5KG78lYck5XcL0P3mmh+NRARmGaESQjh9dEqoJFtQSmJmFGi2ONSEXaSd/8UAc
	 Ohn1V/qBdVe8KglC3hTHWkDxt4qu2q6TzNjbQftleV89sp+jsd9ncFQ/Q3XVId+DCl
	 1WSjqfUVRMVDNGgUhCFz4E7lusZ2GAiScXPSFOCgBAM1g7yTGcsuKXPrl9S8YyS3CE
	 JGa3YuN0v63ntQyPRG9xpNSs2hrW0NXptv7PWUgqkCdttmMJCHLmM89fO0Z8zr3uDS
	 BQlrC2/mHY77oISmAO35JTL6PIgDLNubBV/GTd6pVpUiQmirXDZsGbVhN5oFdIA+On
	 hE6rSWUithovQ==
Date: Mon, 2 Sep 2024 17:04:50 +0800
From: Gao Xiang <xiang@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Yiyang Wu <toolmanp@tlmp.cc>, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH V4 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
Message-ID: <ZtV/speqypBt99sE@debian>
Mail-Followup-To: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yiyang Wu <toolmanp@tlmp.cc>, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <20240902083147.450558-1-toolmanp@tlmp.cc>
 <20240902083147.450558-2-toolmanp@tlmp.cc>
 <5783ccbd-34cb-4f1b-8376-d795df2db4e3@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5783ccbd-34cb-4f1b-8376-d795df2db4e3@linux.alibaba.com>

On Mon, Sep 02, 2024 at 04:52:30PM +0800, Gao Xiang wrote:
> 
> 
> On 2024/9/2 16:31, Yiyang Wu wrote:
> > Remove open coding in erofs_fill_symlink.
> > 
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
> > Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> 
> If a patch is unchanged, you have two ways to handle:
>  - resend the patch with new received "Reviewed-by";
>  - just send the updated [PATCH 2/2] with new version
>    and `--in-reply-to=<old message id>`.
> 
> I will apply this patch first.

I applied this patch as

From b3c5375ceb2944a7e4d34a6fb106ecd4614260d7 Mon Sep 17 00:00:00 2001
From: Yiyang Wu <toolmanp@tlmp.cc>
Date: Mon, 2 Sep 2024 16:31:46 +0800
Subject: erofs: use kmemdup_nul in erofs_fill_symlink

Remove open coding in erofs_fill_symlink.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
Link: https://lore.kernel.org/r/20240902083147.450558-2-toolmanp@tlmp.cc
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 82259553d9f641..68ea67e0caf33a 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -179,7 +179,6 @@ static int erofs_fill_symlink(struct inode *inode,
void *kaddr,
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 	unsigned int bsz = i_blocksize(inode);
-	char *lnk;
 
 	/* if it cannot be handled with fast symlink scheme */
 	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
@@ -188,24 +187,18 @@ static int erofs_fill_symlink(struct inode *inode,
void *kaddr,
 		return 0;
 	}
 
-	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
-	if (!lnk)
-		return -ENOMEM;
-
 	m_pofs += vi->xattr_isize;
 	/* inline symlink data shouldn't cross block boundary */
 	if (m_pofs + inode->i_size > bsz) {
-		kfree(lnk);
-		erofs_err(inode->i_sb,
-			  "inline data cross block boundary @ nid %llu",
+		erofs_err(inode->i_sb, "inline data cross block boundary
@ nid %llu",
 			  vi->nid);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
-	memcpy(lnk, kaddr + m_pofs, inode->i_size);
-	lnk[inode->i_size] = '\0';
 
-	inode->i_link = lnk;
+	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size,
GFP_KERNEL);
+	if (!inode->i_link)
+		return -ENOMEM;
 	inode->i_op = &erofs_fast_symlink_iops;
 	return 0;
 }


To fix a redundant tab and a blank line.

Thanks,
Gao Xiang

