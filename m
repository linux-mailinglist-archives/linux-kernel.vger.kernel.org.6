Return-Path: <linux-kernel+bounces-316391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B8096CEDC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22811F23BDF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8D2155C9E;
	Thu,  5 Sep 2024 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gvwzpKvW"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B298D38B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725516335; cv=none; b=QoFYzDAOkJHEXq/Jfo/A2U9+c/qmTlnjRKYQArwu1p5fUWuoVdClq5wROtOxPf6I8ockOYwGAjWTuboPeX04bjD5UHEdWOGCPA5QOqSGRmGzG5j7GKsTLwQ/wn6Q7Gbc2fyigWBw4MCBU+GjWiLt/V5QbiFMw2AWL1ltrstqe70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725516335; c=relaxed/simple;
	bh=tkcECoelYRp486BkJ/LDgde/PmiZKpGzSvXsG+m2CUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0T1IuMsF5+hYe39VqpMTyBoxePfmgR4m9z0YWthbctNTpRNu3n5fB2Q6P7vN5OCkQ5GHDy3tnUoMoFC/K7o+Ot8yU6us4JgyvKhbjQah4TcSkgGcBq6Kd6XLTXQDdVAKYGzE3OiFQxAt9QsWJPMxpQ5MWMNzDAxRvpLD+h7dd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gvwzpKvW; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725516330; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eRLJzRL2rOkS1vHShK1v2byBfGd6swOHfIMsG4cLQks=;
	b=gvwzpKvWeViziJx4xGlPXl4Z2BSJ6iyaJKDEDKQCDGgj90+FG1BkRdYvwe3dDtZ38flyS4mlpOEbm0SThQmwdSPd8bfHrUsxC7jGTDVg5zIjTjHFv/nPBGzckfNbn+qJS+qqQFclvz1hfVdKvP1z/sGm1+jhC3ixZonnCFyyVtg=
Received: from 30.221.129.218(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEKEoEF_1725516329)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 14:05:29 +0800
Message-ID: <4bf4fca0-0b97-42bc-9911-25290aa8113f@linux.alibaba.com>
Date: Thu, 5 Sep 2024 14:05:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: fix error handling in z_erofs_init_decompressor
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: kernel-team@android.com, liujinbao1 <liujinbao1@xiaomi.com>,
 linux-kernel@vger.kernel.org
References: <20240905060027.2388893-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240905060027.2388893-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/5 14:00, Sandeep Dhavale wrote:
> If we get a failure at the first decompressor init (i = 0),
> the clean up while loop could enter infinite loop due to wrong while
> check. Check the value of i now to see if we need any clean up at all.
> 
> Fixes: 5a7cce827ee9 ("erofs: refine z_erofs_{init,exit}_subsystem()")
> Reported-by: liujinbao1 <liujinbao1@xiaomi.com>
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

