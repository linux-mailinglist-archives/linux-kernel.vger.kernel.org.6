Return-Path: <linux-kernel+bounces-262757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E91393CC43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0879C282C42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9D17494;
	Fri, 26 Jul 2024 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rzq8OKTn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DACF6FB6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721956323; cv=none; b=PPhhiFx+3Y3nH9A25KkbJUCokF4At3j9+xfYYZ1jvLHoJXabPku7kchHzwwuQiEKjsGk594lWUxSltw39qHPJYvDJn0sf/7Gcidv92dCJrPUS6eoIRFkOTiKT8hrW5kuaZ97ojHtR7sIu5LM8eU1SXXOQV5/54DHaxU+D0R79Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721956323; c=relaxed/simple;
	bh=xjkTZ5UAPen9/U6tg1G2eBQrpopwtj5Nrz5YhcDI61c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rv5nG2W/96dojviXO7dIXmfIJYa9UH7yaOlq1J7c3CPVmCllDVrj4BWyKBmajc1WNdJvu/gW1fzhOt4t4LrUqRJ6gbVrhtsaUbn828KC/CuoFepju0asMVzG6y9nQtbewIZ9RZpS2eE0wPUOBxeWrR+gM0VyxhR7xqIC7XmAoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rzq8OKTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE76C116B1;
	Fri, 26 Jul 2024 01:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721956322;
	bh=xjkTZ5UAPen9/U6tg1G2eBQrpopwtj5Nrz5YhcDI61c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rzq8OKTnAUBfcar/ecaNbW+7743+wbv39keE/8eot41vGVWD3wzmVlHhqTdjVizVf
	 ON5AVnQnIAi7gyucFtOhD0ZF6+0or1LG/+FWvs7AwCKSPH/2VLLO+z1gvIOSAqGvRf
	 YSyOyg3NYVr1zhkiqjMZUDPJnF39FMeE+pXk5ehz8CCS/a0eFUrqtM+eLU8w2hEK8o
	 ed/1jTwSEy03s5pSG/a8q7ZpO8P96fkuoQ9Xy3xhqTkoD6bOTZA0Si6XMY1FCLoIqb
	 hgNkv5Hgb/ROCbaLrGZ4oWncN5v8wj0yRroaWHpTyQ5lxREzoiaVBVYurNdDabYucc
	 Nswmuw1HzSVKg==
Message-ID: <4c0f1578-09ea-40be-af0d-60ba968b9672@kernel.org>
Date: Fri, 26 Jul 2024 09:11:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "f2fs: use flush command instead of FUA for zoned
 device"
To: Wenjie Cheng <cwjhust@gmail.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qwjhust@gmail.com
References: <20240614004841.103114-1-cwjhust@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240614004841.103114-1-cwjhust@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/14 8:48, Wenjie Cheng wrote:
> This reverts commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1.
> 
> Commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1 ("f2fs: use flush
> command instead of FUA for zoned device") used additional flush
> command to keep write order.
> 
> Since Commit dd291d77cc90eb6a86e9860ba8e6e38eebd57d12 ("block:
> Introduce zone write plugging") has enabled the block layer to
> handle this order issue, there is no need to use flush command.
> 
> Signed-off-by: Wenjie Cheng <cwjhust@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

