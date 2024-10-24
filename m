Return-Path: <linux-kernel+bounces-379709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9499AE27D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5361F24262
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B944C1C4A0C;
	Thu, 24 Oct 2024 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqNi6gF5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466D1B4F02
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765643; cv=none; b=bsz40erUudDLJXxIhge1oop9L1YISkFvsIfT9gprtTuuaX+QJs1GcsTIou4WF0kmTDNNau8G69TPEJ9aBxmv8eepVKQxp3a4gdBYUvoB+X53dlCS4Q0tJtOplG7U0IiEUjIQ5+Kll7qibQLrL9KC06Y66V8PQvHaEtbUfF+oPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765643; c=relaxed/simple;
	bh=k9LeMgcldza58yDLbsS6ruy8c8qGZneG7cd9tJZWJJY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nfPhlFtanJ2SQceIf5dzLeSHvUBVxq7OpjAFb0u53PAMErunRer0ZNenpiMkhO7DJA+2tDhuJUT+iYZmtPShmDy13YcctHMojl6jjI6XmpPJOYJb7O79oH4cKZ7/MB1lAtUSIrI2ig7wjBICeChtQRO5NgSShlXCdM/VGDVaLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqNi6gF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DA3C4CEC7;
	Thu, 24 Oct 2024 10:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729765642;
	bh=k9LeMgcldza58yDLbsS6ruy8c8qGZneG7cd9tJZWJJY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=RqNi6gF5FYTzi0YI1x5URV20UqoBoNdLDDOjOG7DdolVwoy0wo8uZyt+UHGsre4fn
	 jN2a/QYCLRh9v6MWtv/nZ3lEFsg4rrW6Q+Na08NKZ978GyBfXBPlZJ4LiN385EumR+
	 DGHDT6f3179cudQrO01+IDz0qKC4Y1OmfZwTiWVsPK4GNSW1UuyzYN1y/GNF0Fe98A
	 n0/AURn0Iwu8jJiiuLHH6DaCHwv6qpG+nWgesUJCxunfdil+D2QXGD053Ys5YoKQlS
	 GeS2UAp9md9zdu6aEtXVRW055C+NPK2IG+CVqiDzFzJcDHmu2pTn2jfl3AzPuYcb9u
	 W0go9uAGoDkEw==
Message-ID: <0995728f-7466-464e-a46a-c1ae876b2017@kernel.org>
Date: Thu, 24 Oct 2024 18:27:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, bobo.shaobowang@huawei.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: Fix not used variable 'index'
To: Zeng Heng <zengheng4@huawei.com>, jaegeuk@kernel.org
References: <20241023094850.1680709-1-zengheng4@huawei.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241023094850.1680709-1-zengheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/23 17:48, Zeng Heng wrote:
> Fix the following compilation warning:
> fs/f2fs/data.c:2391:10: warning: variable ‘index’ set but not used
> [-Wunused-but-set-variable]
>   2391 |  pgoff_t index;
> 
> Only define and set the variable index when the CONFIG_F2FS_FS_COMPRESSION
> is enabled.
> 
> Fixes: db92e6c729d8 ("f2fs: convert f2fs_mpage_readpages() to use folio")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

