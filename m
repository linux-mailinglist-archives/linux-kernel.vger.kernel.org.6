Return-Path: <linux-kernel+bounces-310799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BD5968163
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBC11C217B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C85C183063;
	Mon,  2 Sep 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fzTMNd+6"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756417D378
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264519; cv=none; b=oJphlpm9WHizcuVfJXgeYj63CekhIXvO1Ef18v3TzrS5SefDJJfE5SXSris+S6AMkdq0nOAkv7NAobKqOkfzSQqdVLHEO5Pnb3tLf1tnifDeEI0z7INPTJJ4/8ZgJXEWUgEw0LtPVl29780X4ok0MEkfoPC+SruTxVL8+qg6Xtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264519; c=relaxed/simple;
	bh=3+wQZRXWctOBLJs3hLof6xOzsjlhprWSa0lh8OuNVRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4UolEy25wElIVOOe1wg2uP7V+rP0dI8dXRb/YJoZnkkIOKu+dQx8MWW5UZMjmpECJLryvq6Q5imDAYD49bq3qeb5qAb/4Xj8HgEQnd7KbjHEBKsGKb3m0rKe+gsP5lZhIXJCarkxl6D85B0Zzwo5R68hmg+K7YKv1jpUL/aNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fzTMNd+6; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725264513; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vOMkQ7uywlcV9asZwFsNs9q0kmLYDOxSpefUXZ4ipyE=;
	b=fzTMNd+6GjKsXOgLsHb+MrOu7qn5+UikL1TDOS07Gq6e1B45NqMLtJzGPlJ2PrjXqleuOTe8EZ2l7DkaqJdIn9buqz7pszWeOzudqArdGcw+nEKAsNzs0l/YObtZh2BIVWJhQeiKMjGDmdl6sOeY5jqIkl7CSTvyjpDwiN/8ouk=
Received: from 30.221.132.251(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WE5Mz5Z_1725264511)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 16:08:32 +0800
Message-ID: <38095394-b7ea-4aaa-a209-07f4dd6afcd8@linux.alibaba.com>
Date: Mon, 2 Sep 2024 16:08:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>
References: <20240902080417.427993-1-toolmanp@tlmp.cc>
 <20240902080417.427993-2-toolmanp@tlmp.cc>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240902080417.427993-2-toolmanp@tlmp.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/2 16:04, Yiyang Wu wrote:
> Remove open coding in erofs_fill_symlink.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

