Return-Path: <linux-kernel+bounces-449180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D209F4B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026BF188D5CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366321F131B;
	Tue, 17 Dec 2024 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TwAE3ji0"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E22A1F12FA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438958; cv=none; b=TGJJP1EDaUKPuev+C/9+MgUO3b6ZOr0jECvZMT95X6M5vvcLXh0SVWMkLNBA/uzwnxtuDJpUmasf9lHmiuA4dVTMQC2UK7xJDJwLWF0K32JhmYJQ02KynIUrHarXKsrqkRtZL3EzqyoorDoWIw33V03nJj2zJ+GatPpqh5nVEoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438958; c=relaxed/simple;
	bh=sqKkRZksVUeZVFhDKfPmfafbSD6yBYhW5Q/1vVAv5CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToHRyrA0lHVPkx1MTy7mOf94la97DUbytfQ7SbRKD9GcsB+C76FkFuBdVE5ihaixrqmEidOeqe1CwTkx2ttgLew93tNJZWQwmQibNF2jiRFy7MzVwpR7tWOlCeNYIjKrXmQjAP5zanq4nZ2kbRy2THtGEkbqTw4IAcnXMeE8/aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TwAE3ji0; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734438946; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cxpXJZRKPdL3JtCadcEw4asuX7c+VcjU2sev26XlNqA=;
	b=TwAE3ji0lApqbi2Uk7tvhFQ0nf1EA0chyd1hPQyoOi1VR5bPlkBXzs8Up5xDZyjWP2zAqMFvB5zKf/P258c4FsoBzR4suvykKNALgxdCqwS+63xnUN/FIcMa40r7pLccY2ZGnFdorOrFAg86zNU5ZOV6mdxmZd9vdqwqBxN06lA=
Received: from 30.221.145.236(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WLjD.Zq_1734438945 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Dec 2024 20:35:46 +0800
Message-ID: <ac900a5e-9a3d-4e6e-8218-fc56bef8142e@linux.alibaba.com>
Date: Tue, 17 Dec 2024 20:35:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: fix slab-use-after-free due to dangling pointer
 dqi_priv
To: Dennis Lam <dennis.lamerice@gmail.com>, mark@fasheh.com,
 jlbec@evilplan.org
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+d173bf8a5a7faeede34c@syzkaller.appspotmail.com
References: <20241215035828.106936-2-dennis.lamerice@gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20241215035828.106936-2-dennis.lamerice@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/12/15 11:58, Dennis Lam wrote:
> When mounting ocfs2 and then remounting it as read-only, a
> slab-use-after-free occurs after the user uses a syscall to
> quota_getnextquota. Specifically, sb_dqinfo(sb, type)->dqi_priv is the
> dangling pointer.
> 
> During the remounting process, the pointer dqi_priv is freed but is
> never set as null leaving it to to be accessed. Additionally, the
> read-only option for remounting sets the DQUOT_SUSPENDED flag instead of
> setting the DQUOT_USAGE_ENABLED flags. Moreover, later in the process of
> getting the next quota, the function ocfs2_get_next_id is called and
> only checks the quota usage flags and not the quota suspended flags.
> 
> To fix this, I set dqi_priv to null when it is freed after remounting
> with read-only and put a check for DQUOT_SUSPENDED in ocfs2_get_next_id.
> 
> Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
> Reported-by: syzbot+d173bf8a5a7faeede34c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6731d26f.050a0220.1fb99c.014b.GAE@google.com/T/
> ---
>  fs/ocfs2/quota_global.c | 3 ++-
>  fs/ocfs2/quota_local.c  | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
> index 2b0daced98eb..c6d38340d6d4 100644
> --- a/fs/ocfs2/quota_global.c
> +++ b/fs/ocfs2/quota_global.c
> @@ -893,7 +893,8 @@ static int ocfs2_get_next_id(struct super_block *sb, struct kqid *qid)
>  	int status = 0;
>  
>  	trace_ocfs2_get_next_id(from_kqid(&init_user_ns, *qid), type);
> -	if (!sb_has_quota_loaded(sb, type)) {
> +	if (!sb_has_quota_loaded(sb, type) ||
> +			sb_dqopt(sb)->flags & DQUOT_SUSPENDED) {

Looks reasonable.
We can just use !sb_has_quota_active() instead.

Thanks,
Joseph

>  		status = -ESRCH;
>  		goto out;
>  	}
> diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
> index 73d3367c533b..2956d888c131 100644
> --- a/fs/ocfs2/quota_local.c
> +++ b/fs/ocfs2/quota_local.c
> @@ -867,6 +867,7 @@ static int ocfs2_local_free_info(struct super_block *sb, int type)
>  	brelse(oinfo->dqi_libh);
>  	brelse(oinfo->dqi_lqi_bh);
>  	kfree(oinfo);
> +	info->dqi_priv = NULL;
>  	return status;
>  }
>  


