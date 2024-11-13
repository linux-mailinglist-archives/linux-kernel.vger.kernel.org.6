Return-Path: <linux-kernel+bounces-407100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72409C68D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB38282F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 05:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1F4176237;
	Wed, 13 Nov 2024 05:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uTJ20A4p"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F383433CE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476528; cv=none; b=Ky3ICiSQohBlcUHlVdbm+xRI4f3ja1WuJJ1K4CgjOGlTXo5DLlqULV7uj+7xN4Yn6WU5XzUCEUQocOBW/PzdaazRv4Ky2qgZun4EsEmmgm3sB1gI+HdgrAcb8d5+j9/roUJ0HI6FewvmLzR8HeyBM/ZFQDqNnPZjcw0qoKReQP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476528; c=relaxed/simple;
	bh=A/wjIhoNwyCJJC/x0dMJA4HJmju6lmB1iTAHoAq1yLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLMB5UgbxBVmvdymRpF7gTYauNlo0F3G/GSrTB0Ts77DZTbAymP+WufWrPOXjctoeUbhaOCZx1fUbmNb8Sj4ewTmVBkTDEx0eBGOUX4DGL2tomXHr4Sp5XzomgjIAcLPKHhcHKoSedmNEqDYxNh9tvOQFkpJIEkqXnX17Bf0YfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uTJ20A4p; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731476524; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yEne0tW+PM6uX2zTa5ft510fXa2tIFH7Fj9dWN3aCt4=;
	b=uTJ20A4pR1inBjDG6B/T8mshy0prN/s3p5vRcdki7iBhG4198pHY2UqJCESRHbbNiQPYmIh55yGklAHqIMeBT/C1UEIRPlDN+MrdVytkJpEZzTlUZWZWVDxQquclAKo+mzX4TAkJfsvBoO4o9Hdjozkmfh773Pvf8uMJnMwjvvY=
Received: from 30.221.129.12(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJJrPli_1731476522 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Nov 2024 13:42:03 +0800
Message-ID: <4e0bd635-c502-4aab-8fdb-1ef4f2230483@linux.alibaba.com>
Date: Wed, 13 Nov 2024 13:42:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: add sysfs node to drop internal caches
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20241113041148.749129-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241113041148.749129-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/13 12:11, Chunhai Guo wrote:
> Add a sysfs node to drop compression-related caches, currently used to
> drop in-memory pclusters and cached compressed folios.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

