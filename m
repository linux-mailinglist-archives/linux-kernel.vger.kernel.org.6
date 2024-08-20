Return-Path: <linux-kernel+bounces-293115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C5C957AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89161F237FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D246517BB4;
	Tue, 20 Aug 2024 01:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NV0sZ0PI"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E6F9EC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117275; cv=none; b=jpOPFAgePkh3eYpO80h/dEXEUj7LYdkVGonue00CGpPybWLOM3/ewT46xVkfRIzVwetXjtXWSZLut6Ma/Jnk8DPb2PCjBYD72YHt0sqq3UwFyctAdOlCTU8XYNyll1N+MtAz+mVOlFGaUFvAQF7wdg737dp849AVntBK+5IKLDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117275; c=relaxed/simple;
	bh=U6OPtOLWT9dVLk3Bmp1EcGz7PJK137qpqBiRRerePX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITs1r+GyQThHddBydtgHafYCKz4O+5LgOzf4DTA/PryhyEBa4lTtusQK0SE72Hzl83hZb+tyCeqdcr3+P52eefBquzjqjFDy/yPNUtjjGHKDpBzo0f2B/tpL2NXDZMsLcaZZsD75+42KTsLVOSdA/Z8+qyfvZnntJEktfiTyeCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NV0sZ0PI; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724117270; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P7mq3GIp8gwJ2K/StDB46Vk1IsREWtjNtt0AHS1C1MM=;
	b=NV0sZ0PIxXHwmj/B2n8cksJ2J7uB5zf+EUJ8u0FvwKJK5dj25vo5CybjyfFrC62LzvesN9Krvk/guV6OsL3lF7/R0hyLfeFxgZEWlMe+zH+Wd9MwDBnflO+9fiVqBfXe58B8lyCjS737dU9wT1Mq2VNIW1ORevZN9ymRk7T0FnI=
Received: from 30.221.128.199(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WDGX-83_1724117269)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 09:27:49 +0800
Message-ID: <021886f3-a1fd-4de3-a97c-9320009ca29e@linux.alibaba.com>
Date: Tue, 20 Aug 2024 09:27:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: Fix shift-out-of-bounds UBSAN bug in
 ocfs2_verify_volume()
To: qasdev <qasdev00@gmail.com>, mark@fasheh.com, jlbec@evilplan.org,
 akpm <akpm@linux-foundation.org>
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZsPvwQAXd5R/jNY+@hostname>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <ZsPvwQAXd5R/jNY+@hostname>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/24 9:22 AM, qasdev wrote:
> This patch addresses a shift-out-of-bounds error in the
> ocfs2_verify_volume() function, identified by UBSAN. The bug was triggered
> by an invalid s_clustersize_bits value (e.g., 1548), which caused the
> expression "1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits)"
> to exceed the limits of a 32-bit integer,
> leading to an out-of-bounds shift.
> 
> Reported-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=f3fff775402751ebb471
> Tested-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Looks fine.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index afee70125ae3..b704983b2112 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -2357,8 +2357,8 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
>  			     (unsigned long long)bh->b_blocknr);
>  		} else if (le32_to_cpu(di->id2.i_super.s_clustersize_bits) < 12 ||
>  			    le32_to_cpu(di->id2.i_super.s_clustersize_bits) > 20) {
> -			mlog(ML_ERROR, "bad cluster size found: %u\n",
> -			     1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
> +			mlog(ML_ERROR, "bad cluster size bit found: %u\n",
> +			     le32_to_cpu(di->id2.i_super.s_clustersize_bits));
>  		} else if (!le64_to_cpu(di->id2.i_super.s_root_blkno)) {
>  			mlog(ML_ERROR, "bad root_blkno: 0\n");
>  		} else if (!le64_to_cpu(di->id2.i_super.s_system_dir_blkno)) {

