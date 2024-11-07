Return-Path: <linux-kernel+bounces-399273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15F9BFCE9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F47B225C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C8774E09;
	Thu,  7 Nov 2024 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJYhx2Uh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7017C61
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730949419; cv=none; b=qNSOZo5LEbS/fQuZ5HUPn8ieSexGKRr3wozV/EnWx/UvooJ/E5ZfsumX1WGoMUqiKw8agd5xAgmIuvA0N1FUmIi+WGdwxxV3t/rvv7VOr7PwlzphgRgK60IK2o4dMeO12tfqGYmIostYljqfBwk1avw+WOlOKpfLDcjXIyA+sGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730949419; c=relaxed/simple;
	bh=JpASP94lH28Q5yVILO/aHiYqJ+zhcAvGYpyRu49BgR0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ng+r2Y4UOOCDha2HVt5s6XwnssxqOHyEsWvz17ixZxTNA4Bd52NXpk/mcegEX1f9buC20T7uGt0J8f8pU4mPL1LwvRMFTxtmu/oiVCM050bi+jzR/g97K4pKQiBkQPcmPkf+cuJaX4+o7kP6FkL7sAbO7kXnkewzT+Ri3Z8YkgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJYhx2Uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DFEC4CEC6;
	Thu,  7 Nov 2024 03:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730949419;
	bh=JpASP94lH28Q5yVILO/aHiYqJ+zhcAvGYpyRu49BgR0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=PJYhx2UhrPb8EmIiMUbxMvmFRHDGmuxpMCscO8U6j94hR7ulRF0ajQUay1aiIQrax
	 a6dWtdWSYh+EHxt06h1ebnmHiEN2ZL0a/1TUqEUw4gFTjyymA3YQ82h3yMlTu/pcDU
	 RqbcGif/vj8J/+4BmN61flEgNBa5fzIrIu6UokwDRgVXPfjYhlrxmwWrkGziTVAqe3
	 PlCuoLWjOZFzL7jnCkgKgT2tusHa4LiD8O8xyNZ6beoJgp5PSj48UZ67t9LFycNhQ+
	 mx6IcjBj7YYcjD09UV7WD/jR+JJ+5hmxicjLmX7cvHgG84KXfB1q+KPnqVC0tAr55f
	 mKkSYEmiwg+LQ==
Message-ID: <3e53d2ea-564b-4612-ab46-69b872758381@kernel.org>
Date: Thu, 7 Nov 2024 11:16:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Chunhai Guo <guochunhai@vivo.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] erofs: sunset `struct erofs_workgroup`
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241021035323.3280682-1-hsiangkao@linux.alibaba.com>
 <20241021035323.3280682-3-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241021035323.3280682-3-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/21 11:53, Gao Xiang wrote:
> `struct erofs_workgroup` was introduced to provide a unique header
> for all physically indexed objects.  However, after big pclusters and
> shared pclusters are implemented upstream, it seems that all EROFS
> encoded data (which requires transformation) can be represented with
> `struct z_erofs_pcluster` directly.
> 
> Move all members into `struct z_erofs_pcluster` for simplicity.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

