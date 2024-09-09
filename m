Return-Path: <linux-kernel+bounces-320552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 493E6970BE3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F8C1C21A42
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BBC16D9AE;
	Mon,  9 Sep 2024 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OJaD7E19"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08A9125DE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725849469; cv=none; b=EJs8EKu2qEDAsmm5oOGRZtjiiXrvEoQlLxKyLnl825c0B+CPYH56MaVB4rT0/SgJVbbD7bhAx+uwCI3/52GIeS1Uaio2SRPcSVfX64CPPCX+iZHeRYtn6+ioy+bJVqvOIE0GvmOUCoscwTBxNGkvQH+uRR6gl+3uh/Dk0y2oDvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725849469; c=relaxed/simple;
	bh=4y8OHxSXfXvx45QMmCaNWRezZdLmAW268HqLsogE39M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efo+PxdT4V/xyWw8qYG+hYkYJ6txmWM3E1g4K01RtGgYQFal1v7hyzF4LwW2POAsaaSVlxsBJw5McQYw4ZrWSYRi8uKFokcrUzSlDuNsVHOHwR8RaWjeomW0FikxH2M9CJcqne10u9n5X0/VKcg2KKM6KOixKl0mZheByWAZnrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OJaD7E19; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725849458; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=euI2G4wjW/uK4MBJgA0dtsOY2vg04Pc1/WMCn0Xhk/c=;
	b=OJaD7E19mYX9EwdSKDx4f+54+aIXqHWmJFQnvAIIG1hNXM0bcLyUvg9M312y0YlLSNOHM0z4QCyvfl9cR4EkEEz7iHx8Q7AAMmzjyXt/zFCa0Pb2qVy1uQZczLLJKjC+7SeYqF5qcslTvZ1Lxz1/eaFDlp/Fw/a8vNvZVmAOI3w=
Received: from 30.221.130.133(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEW772T_1725849457)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 10:37:37 +0800
Message-ID: <fa6f1972-aa03-47e9-8984-50b57bbf9500@linux.alibaba.com>
Date: Mon, 9 Sep 2024 10:37:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix incorrect symlink detection in fast symlink
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>, Colin Walters <walters@verbum.org>
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/9 10:28, Gao Xiang wrote:
> Fast symlink can be used if the on-disk symlink data is stored
> in the same block as the on-disk inode, so we don’t need to trigger
> another I/O for symlink data.  However, correctly fs correction could be
> reported _incorrectly_ if inode xattrs are too large.
> 
> In fact, these should be valid images although they cannot be handled as
> fast symlinks.
> 
> Many thanks to Colin for reporting this!
> 
> Reported-by: Colin Walters <walters@verbum.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Fixes: 431339ba9042 ("staging: erofs: add inode operations")

Thanks,
Gao Xiang

