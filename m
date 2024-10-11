Return-Path: <linux-kernel+bounces-360344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C399999D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 03:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B376D282093
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 01:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B18717996;
	Fri, 11 Oct 2024 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="Dgnq+EqG"
Received: from mail-108-mta13.mxroute.com (mail-108-mta13.mxroute.com [136.175.108.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD616419
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 01:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728611547; cv=none; b=eFo2rWLji/YiLZ/Lj/vO0uyizE16Au4IuUNm+nIhSG1cwqCrcGtFe6IPyHBFrwFV/6Y3aOuLOHyLXkPZdctz+OOv4TrmxIkJ/hz8z2tAurzBj2d9K1zqJyZ1VDeNbTIxRWKwq+Q9s7kyOeEluZluiz2nLyvLAxkUDeqaRTnooLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728611547; c=relaxed/simple;
	bh=eMEi30HCHoAAv+JpEoZK1ER7d1QkHukLsqPSuZDJKOk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Zd24S07i+aagmzN+0yFkguwxgpj9RI220xhVzmnkkd0ufYi2KnE4103tja7WAy12br3wln+nbKAWGUk0vD7h7UzUjm+BScffgoRUAfHiRcWNCYMxnApdYJjD4yS8dlHqtlGBTJl/7ZovkejRfTTqruGzuQPXCyJaVFphTp2o4b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org; spf=pass smtp.mailfrom=damenly.org; dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b=Dgnq+EqG; arc=none smtp.client-ip=136.175.108.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damenly.org
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta13.mxroute.com (ZoneMTA) with ESMTPSA id 19279421bf90003e01.008
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 11 Oct 2024 01:47:08 +0000
X-Zone-Loop: a75c612f20eebae2a4e2dc3aa3967d6fc3e7dfbe59d0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Type:MIME-Version:Message-ID:In-reply-to:Date:Subject:Cc:To:
	From:References:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pdzEL4cm+5xHpBoIcDQGXqMijQus5IPuZqSbT5JzXiA=; b=Dgnq+EqGvWgMGgCsRfZZK0D65V
	+14hm3ZdjxuNAjEsCQybe9vOSGdflkuUx57no2qIArOPftpNyGLR/jDMD3azilgZBRkark8P/W7x4
	92evQO7sjOd7CpPtS8cj5YECPKIQKvTyxccKrt0RZClJiE/B2154TKXCmIJp9XzLZrTrw5Pd2bA0B
	IeZJ67jH7YHFuKrYj9B2T94ChTIyGC5ueS+i69BAP1Qc1m8RardY/PoOAI2hvhTkBavIn3yVG7VEl
	2y2A9hhwb+7C/5F0gxEyDOYbr1KgwrvfuqYoRewEdJj53bPrt2cCLJefQC4AmxK0LnKPFMibgvxvL
	bmV/bKEw==;
References: <4195446e-2d2b-442c-a1ad-b1498d243a70@linux.alibaba.com>
 <tencent_91D2962236324AA47465761367183C8F3709@qq.com>
User-agent: mu4e 1.7.5; emacs 28.2
From: Su Yue <l@damenly.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: joseph.qi@linux.alibaba.com, jlbec@evilplan.org,
 linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev,
 syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] ocfs2: pass u64 to ocfs2_truncate_inline maybe overflow
Date: Fri, 11 Oct 2024 09:07:09 +0800
In-reply-to: <tencent_91D2962236324AA47465761367183C8F3709@qq.com>
Message-ID: <ed4no1gp.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Authenticated-Id: l@damenly.org


On Thu 10 Oct 2024 at 22:31, Edward Adam Davis <eadavis@qq.com> 
wrote:

> Syzbot reported a kernel BUG in ocfs2_truncate_inline.
> There are two reasons for this: first, the parameter value 
> passed is greater
> than UINT_MAX, second, the start and end parameters of 
> ocfs2_truncate_inline
> are "unsigned int".
>
> So, we need to add a sanity check for byte_start and byte_len 
> right before
> ocfs2_truncate_inline() in ocfs2_remove_inode_range(), if they 
> are greater
> than UINT_MAX return -EFBIG.
>
> Reported-by: 
> syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com
> Closes: 
> https://syzkaller.appspot.com/bug?extid=81092778aac03460d6b7
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> V1 -> V2: move sanity check to ocfs2_remove_inode_range
>
>  fs/ocfs2/file.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index ad131a2fc58e..05d6a8acfcda 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -1784,6 +1784,11 @@ int ocfs2_remove_inode_range(struct inode 
> *inode,
>  		return 0;
>
>  	if (OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL) {
> +		if (byte_start > UINT_MAX || byte_start + byte_len > 
> UINT_MAX) {
>
Why not use ocfs2_max_inline_data_with_xattr() here? Yes, UINT_MAX 
indeed
solves overflow problem Syzbot reported but you can find much 
lowerer
limit if once looked into inline data structures.
Also, ocfs2_truncate_inline() can be enhanced e.g. replace
BUG_ON(start > end) with error out.

--
Su


> +			ret = -EFBIG;
> +			mlog_errno(ret);
> +			goto out;
> +		}
>  		ret = ocfs2_truncate_inline(inode, di_bh, byte_start,
>  					    byte_start + byte_len, 0);
>  		if (ret) {

