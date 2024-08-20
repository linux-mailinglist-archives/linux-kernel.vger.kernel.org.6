Return-Path: <linux-kernel+bounces-294691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A23959167
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82436282F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA471C8FD7;
	Tue, 20 Aug 2024 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jddPgudY"
Received: from out199-11.us.a.mail.aliyun.com (out199-11.us.a.mail.aliyun.com [47.90.199.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A55C45BEC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198159; cv=none; b=clpygej79WUjki5TtcJAPiVXu9pfC1Ys9lrWFFv11pTjmhFJsJa4yUrAMdkWsVHjMcWCMR8xSF3TG+KEoHhFqy+h8CVxnzbuDQf6NjaJmyxoyBBYr4+ca6t7WYmBz9KnKUDZTaxgRZhfs8/jqKwOlhYuCzbm9jPKH3sfz1Q0tu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198159; c=relaxed/simple;
	bh=6NP0d5pzDlhfKsMoiY0GMxdxnmKALz0Fx+ak5WzsELo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MstMM0DPEYzzsO0JPf0n6mo6Z5XcWKXdXzPkRNmIgHXak7Mk2dF2Ldadosf2MfECSbo2RrKybUdYgbxER2mULV8B11SW1/Hfsrs0qdZFpe2F8h0Hp1rx0FQHpSavaT7DYD2APw5cbRYQPm6RK+GRLXtG0ZyQVtu85hvPipsEqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jddPgudY; arc=none smtp.client-ip=47.90.199.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724198150; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pdQnvwC2OPWvP4XcVr70GTE2wb0YbxSFUpju1heYibw=;
	b=jddPgudYX+2hy1wYnPCGneP6DpGbmGRpdefHHn2bCJ74R7DXjnW86yAhnrLgko8Impnw6AGBdYaHumNiPjuHfA4jyy55nk7nXU37Ssy7uujfZRUSvBW0Fn5rY4Q2Ijc96Pu8nJgIXF6OL1sVoio4siAAzaYzQl41cksIqnhTIRA=
Received: from 30.171.230.57(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WDJj8yr_1724198149)
          by smtp.aliyun-inc.com;
          Wed, 21 Aug 2024 07:55:50 +0800
Message-ID: <6b5b86fe-ffed-4cc9-b73c-ad6ee7bf68f5@linux.alibaba.com>
Date: Wed, 21 Aug 2024 07:55:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] ocfs2: remove unreasonable unlock
To: Lizhi Xu <lizhi.xu@windriver.com>, heming.zhao@suse.com,
 akpm <akpm@linux-foundation.org>
Cc: jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <980b3f4d-f265-4eb4-96a3-8f1a75588193@suse.com>
 <20240820094512.2228159-1-lizhi.xu@windriver.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240820094512.2228159-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/24 5:45 PM, Lizhi Xu wrote:
> There was a lock release before exiting, so remove the unreasonable unlock.
> 
> Reported-and-tested-by: syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ab134185af9ef88dfed5
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> Reviewed-by: Heming Zhao <heming.zhao@suse.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/buffer_head_io.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
> index cdb9b9bdea1f..e62c7e1de4eb 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -235,7 +235,6 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
>  		if (bhs[i] == NULL) {
>  			bhs[i] = sb_getblk(sb, block++);
>  			if (bhs[i] == NULL) {
> -				ocfs2_metadata_cache_io_unlock(ci);
>  				status = -ENOMEM;
>  				mlog_errno(status);
>  				/* Don't forget to put previous bh! */

