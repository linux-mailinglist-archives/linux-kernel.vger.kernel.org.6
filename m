Return-Path: <linux-kernel+bounces-405162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4375C9C4DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BDB1F22E98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB1616CD29;
	Tue, 12 Nov 2024 04:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vOUwR8uv"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924CE2076D7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 04:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731385173; cv=none; b=mWbi78xN+acW9R85+KbHkHGKTUhAj01z69X0VS/DrgBNvkR4Sv/AUyaAMTihVx0CH9A6oFO5q7cRJ5FBdw+MrTjdQE5kblxUYxATfIOhINPZGhhiVrzeTYtuQMhVtf7EGyls6jNv7f0/BcLx7QxjBeiN3l157P2N0lCj6GaOEq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731385173; c=relaxed/simple;
	bh=Pjrrgx3ATjeR1rj9wkKMzhKUnI7pq6a5qMVXE57CBC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vF2M1oEonvUNo18ZOo0qlX+xDk0BAzPgFBkus46SvWTACZT5CrHKFAUBdaKfsuTmP7ljCxCHon2a8NTz2cOicZmmSV6gKWTrcqZx8/+xY7YFlLPDWjzQ3kHBg5TedP0RkJbpRBQ7gkfzxCnWvn+Iyr3FDwX0WV7WjAJLzkXmSRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vOUwR8uv; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731385167; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=c7fKyxo/pz++dyvvsWAfAxtkWd5v7tNsGWpTG2MvWsU=;
	b=vOUwR8uvuUkYqJ1Hpw9cYErdPLHSBC9V6LoBoTDegOWdU/EGAEWuyI3k7I2y/sdbQ/rSrbK4yReay+QtavnMV+tneHK1cAhx8rvQa/AqLsGeaQ1kNU66vHtbM+QDb+CN+ug3d73r3/dOlYftUWF6NU5GbDDOPGWQ/CJO3MuXEKY=
Received: from 30.221.128.202(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJFcaxu_1731385166 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 12:19:26 +0800
Message-ID: <7c26a52e-2642-41b8-bc1c-990567dd2109@linux.alibaba.com>
Date: Tue, 12 Nov 2024 12:19:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] erofs: free pclusters if no cached folio is attached
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20241112043235.546164-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241112043235.546164-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/12 12:32, Chunhai Guo wrote:
> Once a pcluster is fully decompressed and there are no attached cached
> folios, its corresponding `struct z_erofs_pcluster` will be freed. This
> will significantly reduce the frequency of calls to erofs_shrink_scan()
> and the memory allocated for `struct z_erofs_pcluster`.
> 
> The tables below show approximately a 96% reduction in the calls to
> erofs_shrink_scan() and in the memory allocated for `struct
> z_erofs_pcluster` after applying this patch. The results were obtained
> by performing a test to copy a 4.1GB partition on ARM64 Android devices
> running the 6.6 kernel with an 8-core CPU and 12GB of memory.
> 
> 1. The reduction in calls to erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (times) |   11390   |   390    | -96.57% |
> +-----------------+-----------+----------+---------+
> 
> 2. The reduction in memory released by erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (Byte)  | 133612656 | 4434552  | -96.68% |
> +-----------------+-----------+----------+---------+
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

