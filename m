Return-Path: <linux-kernel+bounces-408530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B8E9C800F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495BF1F21F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BFB1D968F;
	Thu, 14 Nov 2024 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T9uOC7wD"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743C02EAE4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731548254; cv=none; b=inW/7ZB8rtae+K9vUGV91htmOmLDGA9s2R05402p32Gn3Y0f1QyadCf5sasSSxE+mh7mQBB+qwwx+pyDKHPZPiUS82ZQfOzKupqhIPMuQFfWF4EQZYxYRxut8GHgMX+lmzNyTtqV3Obo6ukNASkaIrm6skNv6LhYLInVCvQAUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731548254; c=relaxed/simple;
	bh=coDEwrb5mpi19qdw5Tv4kPiDb3BCiVwnSrJgMsHKtXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osYCwSBfIEw5CaMPxk24yEKEgZdnB1sWVRpfLWbXNVTFmDUB4J8xY5ZK34Q3Wd+WrFdNFcRwah95obNS7fa45uWVViube412sDBhGwB55yxlocD/v3jHEQzafZAhEeHA9iRg2Zi0gQ+GXXo7i2c4SFMZBVNfpNOEDRiG5kNNN7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T9uOC7wD; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731548249; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lsAGW9pjTFb8tNFD9mQMBYghnGRdFWUFmaeRR+RpZMA=;
	b=T9uOC7wDMYMcBqodhMHpYRRYzFZ6TdgCJGBdAn3YNYEQZ2B5CDN0uJt9UfJ3BN/19U9GkFg4JtyZ4YnWqgKoewTNSVu76dG0ZWSF+ylRlY9/6QJdeCS+amA3H2nygCdvCm86UGvBtAEh0bfV0DMjVYzxXgwOL6GcgRLHlTuC7ng=
Received: from 30.221.128.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJMVDwZ_1731548247 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 09:37:28 +0800
Message-ID: <3651782b-e65f-4dd3-959b-0b122cd596da@linux.alibaba.com>
Date: Thu, 14 Nov 2024 09:37:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] erofs: simplify definition of the log functions
To: Gou Hao <gouhao@uniontech.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 gouhaojake@163.com
References: <20241114013247.30821-1-gouhao@uniontech.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241114013247.30821-1-gouhao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/14 09:32, Gou Hao wrote:
> Use printk instead of pr_info/err to reduce
> redundant code.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

