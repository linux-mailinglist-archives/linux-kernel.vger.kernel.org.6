Return-Path: <linux-kernel+bounces-562804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC81A6332E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 02:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5693D172197
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 01:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C7A40C03;
	Sun, 16 Mar 2025 01:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1go6Nci"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B43739ACC
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 01:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742088431; cv=none; b=tRftA6dzeQuc+SD/s6ylWGsdj3jJhKjJfq0K4QInVfY9BMJZw0IQaTRh+rlTnpdrftZ7kOPgUX/2Bs8bOxpc8eRT6JgYv266DX47aL3wU0P7VV3w02OkM4EcJKKzDZUYzd29x57uT53bWFW6rQobrVU39tzeM9oWqYN7wzSvZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742088431; c=relaxed/simple;
	bh=5TRRFLw+o6yMhZVEtsWaD2Ng0tfLzikBtpEkJuppsGA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l5nDv6N2dGp7frcbjhDX9UKwidQwxUgDfAi4iG58YGiUGaoEsZSTi/H1vGVyv+aFj/8M+50UOjsLEgyHTu6n2u9B2J+0LZtKXS3hJbmiIWUmIHmvjuW2m3SNEBW+/oirEDXLHPkxqaWoMoX8Hg+7kdmnk7HJAHRQJwbZTjFmlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1go6Nci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CCAC4CEEA;
	Sun, 16 Mar 2025 01:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742088430;
	bh=5TRRFLw+o6yMhZVEtsWaD2Ng0tfLzikBtpEkJuppsGA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=c1go6NciCQrZbCxxUUqiEgYYtV8DlwNZGe2pRBX5Mcb++P44cYAk6qOi22rIwmGY2
	 toGaGXwaXSECYQdAkVSlR8oCoUQmYoweoqIhZJB92hAsAiCfsaxdaqV/UG60uBhCNE
	 qAVS2aVCME7BiDFJMzjOXznGxZKfynys1DMw6md8dXSg/2d3kHyalozDGc95fv2HKk
	 ZPX50C8RmmMj7P/o30xqdM7I5/79BLWdxbGX3JfYtEIId0HDEQt65H00/6ja/yVByj
	 H4SgldtldYdsaTlN1z01kOVwJtend8b1MzxtN1bHaPI0pf9G7VWGlU1QKSMZEXOP6R
	 cP9N8Kt73xpOw==
Message-ID: <e9b19fa0-4d07-445a-aed6-e041300425ef@kernel.org>
Date: Sun, 16 Mar 2025 09:27:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: allow 16-byte volume name again
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250225033934.2542635-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250225033934.2542635-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/25 11:39, Gao Xiang wrote:
> Actually, volume name doesn't need to include the NIL terminator if
> the string length matches the on-disk field size as mentioned in [1].
> 
> I tend to relax it together with the upcoming 48-bit block addressing
> (or stable kernels which backport this fix) so that we could have a
> chance to record a 16-byte volume name like ext4.
> 
> Since in-memory `volume_name` has no user, just get rid of the unneeded
> check for now.  `sbi->uuid` is useless and avoid it too.
> 
> Fixes: a64d9493f587 ("staging: erofs: refuse to mount images with malformed volume name")
> [1] https://lore.kernel.org/r/96efe46b-dcce-4490-bba1-a0b00932d1cc@linux.alibaba.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

