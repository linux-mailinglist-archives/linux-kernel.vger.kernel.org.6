Return-Path: <linux-kernel+bounces-408756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AF49C8335
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F17F1F22EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7421E0E13;
	Thu, 14 Nov 2024 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kZJ+0nCE"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7AE14A91
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731566067; cv=none; b=ViGNS/dtTduQm2WVzpc65NifUx4pstwGATSwD4VoOWWtC80nu1GWo5XVu/6G+x/teJ9mSEpRh2ExVYrWgvlRFuLL1eBcSlqPbTsynMM/vbS1ANHIqNB7k7+bwJZHSCGbTim6+253KWy4c1ngZCkoig1Tl/qoE+46srUNlW+LmSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731566067; c=relaxed/simple;
	bh=inb7ktfIF/K/94HAfdWsqmsyfadIn9QS7Q9UHhUHxVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxWqNWnblfZVEw7tUOgJ44xo1WEFzELnQTEyYjwgbjEGhBvQLepIW8m2GvOiYcbG+smWQxhylqBjRIxUL0r98MKc0+WUGub24YjcNZ0EYdKRfxFYZqBhTRKch2/YXFjwyWDwcPjbpS28wjDDaTgDkP4ay+ScJTSRw12y5gw1fj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kZJ+0nCE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=weLT0MTvye6xD6HZw1Bdz27SlRmDyDJkE8ZHqZy6GU8=; b=kZJ+0nCEz6IAjcPIH5Awlq0OTm
	/sYOjJlK4oJ4pL8za0NvOpeExm1cVRpCux+SmOz4QRNEL4gLY4PQsNjEU4q/l/ONyjXjrjL0e0URJ
	3hXeHWaWSVO7/UJATFq+0PR7CRLPKGt9OyxpmbayjcVLZGRh3yBYhryPZsiLSocgQXYmSLJmXF9Tu
	/QmDJgT3FKCBHFOwWFT4ffFO0HsQcRqeG3p0jh0BIGOTR30A5dxilNud3tsIf7eFZkWdtOlgQ1TWz
	nLcex60HNyej7jZukggLOEmT5JDZE387MF42/BOBMRZ3eIlIWtxf6xeL6RXeT3jdebnm2paUpBgI6
	eVDk1mdg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBTQs-0000000EoAm-41Xw;
	Thu, 14 Nov 2024 06:34:23 +0000
Date: Thu, 14 Nov 2024 06:34:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Subject: Re: [PATCH] erofs: fix file-backed mounts over FUSE
Message-ID: <20241114063422.GM3387508@ZenIV>
References: <20241114051957.419551-1-hsiangkao@linux.alibaba.com>
 <20241114060434.GL3387508@ZenIV>
 <61c24337-798d-4a2e-82bf-996e86d0c0fb@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61c24337-798d-4a2e-82bf-996e86d0c0fb@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 14, 2024 at 02:23:27PM +0800, Gao Xiang wrote:

> > 3) AFAICS, (buf->kmap_type == EROFS_KMAP) == (buf->base != NULL).  What's
> > the point of having that as a separate field?
> 
> Once buf->kmap_type has EROFS_KMAP and EROFS_KMAP_ATOMIC, but it
> seems that it can be cleaned up now.
> 
> I will clean up later but it's a seperate story.
> 
> > 
> > 4) Why bother with union?  Just have buf->file serve as your buf->use_fp
> > and be done with that...
> 
> I'd like to leave `struct erofs_buf` as small as possible since
> it's on stack.

enum + bool eats at least as much as a pointer, and if it's on stack...
an extra word is really noise - it's not as if you had a plenty of
those in the current call chain at any given point.

