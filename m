Return-Path: <linux-kernel+bounces-293990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D93958745
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6915C1F22456
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8CA18FDB1;
	Tue, 20 Aug 2024 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WGh2Cwgb"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484BE18FC9E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157890; cv=none; b=KOCukdteov4zzW7BAyQjc+CDTtOL8KjG/UtkUkvKRmj6Q/8ECh2qXANFochDYVU675WGxKy0LkWF1ZvgtU+UP80CkonsJuYiM8i8TJIzZ2Co50EKKhc2eU5n2Whh7S/VrmVIF8CKrnV7C/xkYdJm6iWGTSfk09harqziUXFHV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157890; c=relaxed/simple;
	bh=MCmWaWGj/nB1UwzulXx/ypO+Lvf91G7f9HziNg3QAYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETCUeqBTCE30KjwEhsk6QfjNfFq68l1XTezZZkKE0aIXx7S4kPguROafRSG8hvXV0jPWPBAg23EOq+YpLjddFNYr/JxnpDD5s4zWp06bp+ng1n9CPf/FK6XQ8xw97hliMJ3QS0LR7Wkwl3VbbNdgSa4ELOWSBwDZybdHGxB15R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WGh2Cwgb; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724157878; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=p6F69Zfp7ApOoK70J6CqbfRGCkiGhKLxfxHTkQWsHbc=;
	b=WGh2CwgbtpL1C/7ymocIvd1ZNYKaDXtVd1HpgDkPIBLFbQOejqvltHJFhvgeDCqDFFzb+GdOwB6gAW+bxq1C2BCBhhQMDkSKErxLyYb8wfJu5Qbcnv+hRTYjvcjYc306zVcKFmLBZrI9pIM7XNwZA/NSwax87ZS0zbyFnSXk0VE=
Received: from 30.221.128.199(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WDIj1pp_1724157877)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 20:44:38 +0800
Message-ID: <205e0d29-2567-4d82-a024-a8e7826d9f18@linux.alibaba.com>
Date: Tue, 20 Aug 2024 20:44:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: Add i_size check for dir
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+5a64828fcc4c2ad9b04f@syzkaller.appspotmail.com
Cc: jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <0000000000005894f3062018caf1@google.com>
 <tencent_EC9ACDC0793A6F742D7D6FA094F0E96AEF0A@qq.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <tencent_EC9ACDC0793A6F742D7D6FA094F0E96AEF0A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/24 8:08 PM, Edward Adam Davis wrote:
> When the i_size of dir is too large, it will cause limit to overflow and
> be less than de_buf, ultimately resulting in last_de not being initialized
> and causing uaf issue.
> 
> Reported-and-tested-by: syzbot+5a64828fcc4c2ad9b04f@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/ocfs2/dir.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
> index d620d4c53c6f..c308dba6d213 100644
> --- a/fs/ocfs2/dir.c
> +++ b/fs/ocfs2/dir.c
> @@ -3343,6 +3343,8 @@ static int ocfs2_find_dir_space_id(struct inode *dir, struct buffer_head *di_bh,
>  	unsigned long offset = 0;
>  	unsigned int rec_len, new_rec_len, free_space;
>  
> +	if (i_size_read(dir) > OCFS2_MAX_BLOCKSIZE)
> +		return -EINVAL;

Why OCFS2_MAX_BLOCKSIZE?
It seems that this is caused by a corrupted dir inode, since this is an
inline case, we may try best to make sure it won't exceeds block size?
i.e. dir->i_sb->s_blocksize.

Thanks,
Joseph

>  	/*
>  	 * This calculates how many free bytes we'd have in block zero, should
>  	 * this function force expansion to an extent tree.

