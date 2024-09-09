Return-Path: <linux-kernel+bounces-320543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 508F6970BC7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D793A1F21C67
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4D5171A1;
	Mon,  9 Sep 2024 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EsRpQGNT"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CDA12E75
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725848856; cv=none; b=ONAkznYd/XLhl9NMRGk7/EsMUYU22alxGX1pYuohqdD0h5rmhsVmgUbFw8cl2SjhzilVKYwMsCzaMf06y4xUA4AAvbKRz/DtQqP1KgoVGiUL6kK6dInSD1z15fQ6sk1ZwGpMKjtZMrbYino5dYkGzg7x+iogwQzNihcTq7vvqEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725848856; c=relaxed/simple;
	bh=j0CAdSqLtsFEGDKYXCx2Nlytm8QHptatcfCF55g1Rmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e03NPW7klaPSfnMmmpnLHWpi/elgMERdbNHUM84d2yQWU46+f+ZNeomzNgGdpXgAT+S5o0ZbfuA+XqXaHxLFH2Do1UVJThl1TriCV5pxnprQAB00fMr7+Oy9jsAT3LAVLkjJ3fHl8TWPUpAxEq5WQUzq21y435uJG8LgXABK+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EsRpQGNT; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725848845; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dsSKiP4wQ7iUhn9nl4tqPadBgTvfs1BkOXJhjTRxYSc=;
	b=EsRpQGNTM6wgJRjQvwydFFpuD8HUBQppujgENPCd/Y8ize7rH34Cuq5XVUgfmSBGyf/a+KRIK77zvdGGHYye9IELRTHvnVk+Ko08bw6RYJUWFTBl4dbdC6tUfGP5G+ffIprGYUMkWWxNX5vKf5IhUD2J1a7ibm8JHqASaGWKfxs=
Received: from 30.221.132.42(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WEVqlx0_1725848844)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 10:27:25 +0800
Message-ID: <4ec6bf01-b031-49c9-a9c7-10e210e14042@linux.alibaba.com>
Date: Mon, 9 Sep 2024 10:27:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: bug fix when bh is null
To: Su Yue <l@damenly.org>, Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, ocfs2-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 syzbot+adfd64e93c46b99c957e@syzkaller.appspotmail.com
References: <20240906221208.136692-1-ghanshyam1898@gmail.com>
 <ikv5ob7f.fsf@damenly.org>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <ikv5ob7f.fsf@damenly.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/24 9:39 AM, Su Yue wrote:
> 
> On Sat 07 Sep 2024 at 03:42, Ghanshyam Agrawal <ghanshyam1898@gmail.com> wrote:
> 
> Commit message please even it's simple in one line.
> 
>> Reported-by: syzbot+adfd64e93c46b99c957e@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=adfd64e93c46b99c957e
>>
> I think it's fixed by https://lore.kernel.org/ocfs2-devel/20240902023636.1843422-1-joseph.qi@linux.alibaba.com/T/#t .
> 
Yes, Lizhi Xu has sent the fixes before and now it's in mm-tree.

Thanks,
Joseph

