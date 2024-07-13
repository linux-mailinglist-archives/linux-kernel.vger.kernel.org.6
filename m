Return-Path: <linux-kernel+bounces-251336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7730C9303AC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 06:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E691C225E9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 04:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6218E1F;
	Sat, 13 Jul 2024 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IOL5SEQB"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BC2D2F5;
	Sat, 13 Jul 2024 04:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720845852; cv=none; b=bepM7e8oFytlT6tQMkkVCTUAUFI8zrs2xj413kUFVwIuqUJmnqlUUjpqh9zihNO4CbzfAsaesQLTGYfLf813gFsksgRMJylc7GXbyIJe+OfP3NJbUyUumLfdb0EfjxHsilS0aOf0e4L51PDJ+hELPBaQYdPm6KsEXsSedoRXq3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720845852; c=relaxed/simple;
	bh=Oet59IuTJYdMrMQGb2leMg6So4P7oH9pxudco3Jim5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvzoNu/4TYXRNN6iXH+SqbxaD3HMxyqIL8gnIWqt+b4uwYFLKkg26VIM3bW8MFHgLLTRiBA4c3A0/flG9wdG//aLnEIPhTrI2i9O3JY4hIiUXYAomFVOP/hyJYJNqvMxjlkKMBC5+UoYK/EMPGyZwQtDPMUzkuuXEN4B/RBtyio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IOL5SEQB; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720845847; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pbw5HE5q1zUNveorgQOxPxxxjsrNzfWAQYEcqlUSdtk=;
	b=IOL5SEQBkGtGgkNlfyy4QSbY5/7FxYFm8vGX+36XnQpWjK2eSJV6E1WZkExMfNk4Ec2M8WaTuC84OhYS2n0LQkF9LMkq6KnFFLrWy9YKjrTWVOU+9wlUr69Mn1U9g+8ocbqwz/Kg+WaxraNA2lFro8sQKJnoxjV4QSeIeISANDA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0WAQ.gRt_1720845845;
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAQ.gRt_1720845845)
          by smtp.aliyun-inc.com;
          Sat, 13 Jul 2024 12:44:06 +0800
Message-ID: <91b66d05-eeff-4d84-a726-cee087bce967@linux.alibaba.com>
Date: Sat, 13 Jul 2024 12:44:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: silence uninitialized variable warning in
 z_erofs_scan_folio()
To: Dan Carpenter <dan.carpenter@linaro.org>, Gao Xiang <xiang@kernel.org>
Cc: Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <f78ab50e-ed6d-4275-8dd4-a4159fa565a2@stanley.mountain>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <f78ab50e-ed6d-4275-8dd4-a4159fa565a2@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/13 09:04, Dan Carpenter wrote:
> Smatch complains that:
> 
>      fs/erofs/zdata.c:1047 z_erofs_scan_folio()
>      error: uninitialized symbol 'err'.
> 
> The issue is if we hit this (!(map->m_flags & EROFS_MAP_MAPPED)) {
> condition then "err" isn't set.  It's inside a loop so we would have to
> hit that condition on every iteration.  Initialize "err" to zero to
> solve this.
> 
> Fixes: 5b9654efb604 ("erofs: teach z_erofs_scan_folios() to handle multi-page folios")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks, applied.

Thanks,
Gao Xiang

