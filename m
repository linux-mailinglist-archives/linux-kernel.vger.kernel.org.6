Return-Path: <linux-kernel+bounces-189610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3528CF2DB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 10:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207521C209E5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 08:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3913D8F40;
	Sun, 26 May 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="VJRvDsOv"
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EAC2F55;
	Sun, 26 May 2024 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716713000; cv=none; b=hI0+KZqO1jcQNkuHqqrG1QsDwWtSUZSwFWG48MQ+0Q9FGenBKYQkshf9g34yFuAYIGujGkAttximA/je6fGlXifabsQwCLN9P1jrEUrr+SPvcfM508tEs08Ud4ZXkouKXmRT38nwUejPV2kV4XkDw7mEMqanZz0ZmxFck3YJ7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716713000; c=relaxed/simple;
	bh=IC8cNWH9MI/jPTfOahj8hMmSz3WbSin55lxR9NVNYpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JD8u890iPIuOpKiltXRXmz6i8vEh1PsoE1G7ltKwzAJSLkJczdZL8Vy9kSCEnvDQxSbN33TU8gHDWC/GV7B1ZNTG1WbH+wUUQ3J5uxFjEw5ZXlSUwzVTlpcZlbxvibV59aTyXAX3lF1g13KoUTycCKnGgiLDP7Wgs7ooV2JoU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=VJRvDsOv; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=ZJfc1vFjtuw6zOYBPDNoLxzMoVqWP91R11+au6coP0c=; b=VJRvDsOvEknEP7i7MzWBmOXhPl
	iwPmB/FqTWfJcrwAQkepgXs0qnloSVr7zZQD+01LCyjv3S/TMYVM5E++FFDn4dfPh9vyZlsK5oIB/
	285Le1DxxT9khpXyWI7f78busZ5FukLtEJz3WEzrlavwbm3MpL41hN7SFQaTXsUt2YdhOJwD3HQvN
	4INRYLiIH1sLBV8qutA8h330w1Mr84g893bRetTi0l7Y3ct++O4VtOfi0BquDA/lMKK7vm1NYSoB8
	m+8znP/qESJFqR7soSg7ATt6s5kv725ZAhnHmsKX+xPE+BunFzsaIi8BZOPVfjpGDpfiMbcCGg6YY
	kvZ9GZUFuStcXnnFNHralzAkc5vzWcmj39Ul/XcaQLw7RLwwXxMcQhDZoV1vg3rr6Ui2lOXE3ktlK
	dtqKJ5DG+5mk/L7CrVU3WGmFxMC+pWtiui+Gbj7U7q1ibvZOpPhWEot6vzvh0ffJyDvGWUBjOr3xT
	33B+ByzfewIeaaK8yrCwjt1ccICFKK5XA6KLVhsWpnN8M7oe4HqNcgWlEe78YhcmO56oICHGG/576
	1FJ55bLJYGpS9IPpCAMrOZhWDtpFNkQUqTeMMW7dFU5hkHOv83GtmmTIo0V9NWsokepbttXFgQhC9
	gQTt3LAGuYD1iLPaRf/tFgaXJVAP3IFNtqsTqum3g=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] 9p: v9fs_fid_find: also lookup by inode if not found dentry
Date: Sun, 26 May 2024 10:43:04 +0200
Message-ID: <4050342.HAUgm3mvAN@silver>
In-Reply-To: <20240523210024.1214386-1-asmadeus@codewreck.org>
References:
 <20240523113638.1196299-1-asmadeus@codewreck.org>
 <20240523210024.1214386-1-asmadeus@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, May 23, 2024 11:00:23 PM CEST Dominique Martinet wrote:
> It's possible for v9fs_fid_find "find by dentry" branch to not turn up
> anything despite having an entry set (because e.g. uid doesn't match),
> in which case the calling code will generally make an extra lookup
> to the server.
> 
> In this case we might have had better luck looking by inode, so fall
> back to look up by inode if we have one and the lookup by dentry failed.

I'm not sure how that's supposed to happen. Both lookups check for (uid, any),
just on two separate fid lists (dentry vs. inode). But OTOH I don't see no
harm either, so:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> v1 -> v2: fix build error
> 
> Sorry, shouldn't send patches without testing even if I'm not planning
> to apply them for a while...
> 
>  fs/9p/fid.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/9p/fid.c b/fs/9p/fid.c
> index de009a33e0e2..f84412290a30 100644
> --- a/fs/9p/fid.c
> +++ b/fs/9p/fid.c
> @@ -131,10 +131,9 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
>  			}
>  		}
>  		spin_unlock(&dentry->d_lock);
> -	} else {
> -		if (dentry->d_inode)
> -			ret = v9fs_fid_find_inode(dentry->d_inode, false, uid, any);
>  	}
> +	if (!ret && dentry->d_inode)
> +		ret = v9fs_fid_find_inode(dentry->d_inode, false, uid, any);
>  
>  	return ret;
>  }
> 



