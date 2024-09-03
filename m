Return-Path: <linux-kernel+bounces-312060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AED67969176
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0211F23368
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 02:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849DF19F100;
	Tue,  3 Sep 2024 02:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi4c1GtO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5480B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725331082; cv=none; b=NA9sA3q68NqBIJDUoImTxv1PxN8tviwZS7U5M/rFAKiI6d7QchyEavhPYQ+Ee/HEc0N1r22KixBa3xC8yC2IWQUuFRqfP8eb0Q8qBGGkOUNYw0uNZmSFDyPQJNWmKqia8TtJsegYs+3WISKPQ0sD9OvoWwdbZDOQxNlNJNYwVko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725331082; c=relaxed/simple;
	bh=s3ixy1Dk0VBO3qFac0eQGqV2MWZpl1pz4srEs/WX2P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=necc7thdPBC+n6ewl0Gw8C6QaNCs9iHfX7CDPJOHzInUxSXuFjN2QX3yFm6HaUgr9FK1IplNBIc2zDwtPfp7pSk8GW2ts8RT7HOr6KhwVk8qdS7QW1LfrM6XL3zePDUBSa2Fvh1kteAcOY2lWsT0awHR2Vm1UhfR5emuGLr1TrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi4c1GtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38B3C4CEC2;
	Tue,  3 Sep 2024 02:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725331081;
	bh=s3ixy1Dk0VBO3qFac0eQGqV2MWZpl1pz4srEs/WX2P8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gi4c1GtOn5/HucTPGizj/UeHFF4sYHJTsoq8PWHPFGJ+qE23qcXYa+aY2bar1EJT/
	 2PcZNxXAvF/zjkv6bUF2tUOVZuAqMCBgC76FT+yLy6aJt2yk4ZNoUO18cwlH2zbTeS
	 ZWZmWgcKWgigzCfk3XSC8QsTLgW4z+5PKfX8GZ9OSX9A6761P6YZzTcbqpdWwsYB+Y
	 Mec+IAau14Q293Ssgo+V4yLpXFt4P7AYs/VWXz2sTTrMp+5fA6cxX/RO+kL9DN5oD4
	 zArRKo/bUzWmuqA/0egxtQJqpjbIxq11LUNPTcPCWvPerfi0i5OWl++R72tG78XHxr
	 WDyPKby28kDYw==
Date: Tue, 3 Sep 2024 10:37:55 +0800
From: Gao Xiang <xiang@kernel.org>
To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/2] erofs: refactor read_inode calling convention
Message-ID: <ZtZ2gygmwGSAuPgS@debian>
Mail-Followup-To: Yiyang Wu <toolmanp@tlmp.cc>,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <ca8dea24-1ef2-46a8-bfca-72aeffa1f6e6@linux.alibaba.com>
 <20240902093412.509083-1-toolmanp@tlmp.cc>
 <94737216-af40-44b0-ab3e-e5bfdbffab5f@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94737216-af40-44b0-ab3e-e5bfdbffab5f@linux.alibaba.com>

On Mon, Sep 02, 2024 at 05:54:22PM +0800, Gao Xiang wrote:
> 
> 
> On 2024/9/2 17:34, Yiyang Wu wrote:
> > Refactor out the iop binding behavior out of the erofs_fill_symlink
> > and move erofs_buf into the erofs_read_inode, so that erofs_fill_inode
> > can only deal with inode operation bindings and can be decoupled from
> > metabuf operations. This results in better calling conventions.
> > 
> > Note that after this patch, we do not need erofs_buf and ofs as
> > parameters any more when calling erofs_read_inode as
> > all the data operations are now included in itself.
> > 
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/
> > Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thanks,
> Gao Xiang

Applied with the following minor cleanups:

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 726a93a0413c..31d811b50291 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -16,9 +16,8 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 
 	/* if it cannot be handled with fast symlink scheme */
 	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= bsz || inode->i_size < 0) {
+	    inode->i_size >= bsz || inode->i_size < 0)
 		return 0;
-	}
 
 	m_pofs += vi->xattr_isize;
 	/* inline symlink data shouldn't cross block boundary */
@@ -204,7 +203,7 @@ static int erofs_read_inode(struct inode *inode)
 static int erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
-	int err = 0;
+	int err;
 
 	trace_erofs_fill_inode(inode);
 


