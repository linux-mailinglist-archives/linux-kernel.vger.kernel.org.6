Return-Path: <linux-kernel+bounces-173274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858DE8BFE0B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A077285C15
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094AF6A8D2;
	Wed,  8 May 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zli46Lmz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DBF55E58
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715173930; cv=none; b=JaKnBnhX70yhuyG/+XwtchAiEzhmftNJCB7ArpqZi5oiKYiZ++VMd6RYtNwQNZIJIwy5riOUUB7bpldHEKyKinpLXKsTk/20r5rQ7bu3AVdROwDWeVtg1tC541lJ/sZAwcKb6wofWmD/Sif8FxuFn2SYXf/ux83LtfEu20uHT5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715173930; c=relaxed/simple;
	bh=B3TgV7Y3rTI5Noe3tkOwqLHVTgwR6y+7ORa3V8o6LiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFbjsqZEcdclAhI2nDAB8L/1l2SoIXMmicalBG8umMl8vn1/ya0dIbGdgnHtlORor7++wl34GCVj/r5+MFg9s2kTlxU398mRRUobFWuRLKgVzw8k2EzDge3m9iLAULak5qhJIGJWGAUAJxpFKzL2hF6zUMjJRJfd9DvomNiESSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zli46Lmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2004C113CC;
	Wed,  8 May 2024 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715173929;
	bh=B3TgV7Y3rTI5Noe3tkOwqLHVTgwR6y+7ORa3V8o6LiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zli46LmzOgx3rEIiaYn6jn7kCfP0tbqiDDeP6vtA4+26SLGK5dLwu1hROw3mYGJ0f
	 ZRMgeugngdrCNOA6oyS92bQAhpfT499itVEHiXvg+KkQeqLSa7dO3UPgvnVVamFa4U
	 UKZ6/9A6gddDJHKet34th+2MyHYNbMUjYz/s+r4YeZpFTU7mZc4FEZlG7w2CHkNEef
	 Uzcl5LYbZ+qQxPFuXOUgaCVIwtRn4v8Z6ieEtJt05LK0dDpIpcaIOeynKPmWbDFUJP
	 x8TYG/YVTUX+keDYnNIS2SBjvGsQNH1eCxysaCR53TRQeHIXSi3ZjkwEb/m/5+t6lJ
	 2K0KorBaXLr5A==
Message-ID: <39cc1370-a80b-427d-86e7-6903ed1ce868@kernel.org>
Date: Wed, 8 May 2024 21:12:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: Zstandard compression support
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240508090346.2992116-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240508090346.2992116-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/8 17:03, Gao Xiang wrote:
> Add Zstandard compression as the 4th supported algorithm since it
> becomes more popular now and some end users have asked this for
> quite a while [1][2].
> 
> Each EROFS physical cluster contains only one valid standard
> Zstandard frame as described in [3] so that decompression can be
> performed on a per-pcluster basis independently.
> 
> Currently, it just leverages multi-call stream decompression APIs with
> internal sliding window buffers.  One-shot or bufferless decompression
> could be implemented later for even better performance if needed.
> 
> [1] https://github.com/erofs/erofs-utils/issues/6
> [2] https://lore.kernel.org/r/Y08h+z6CZdnS1XBm@B-P7TQMD6M-0146.lan
> [3] https://www.rfc-editor.org/rfc/rfc8478.txt
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

