Return-Path: <linux-kernel+bounces-399257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A955C9BFCB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFC61C2108E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B5B2207A;
	Thu,  7 Nov 2024 02:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbLpMboC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F436D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 02:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730947603; cv=none; b=spQ+vkv1IMd+jJ2PnKg/xpq4T4hPyoZsPrSR1Itbh/cVGNlhNz6F4Tkpkxa+o7+TYMeqY/9PKA1n79zVzRzqRMKemtdK2txoj6F5hd/XiFR1nc+BHKF7vz/e87UJ5OVKyoDcMt8Tzqb6Zt8NzkdFOhAcsM1woSgV96dS1NhxIqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730947603; c=relaxed/simple;
	bh=sOfLVR7/GFSxqbczXVx6RK558SO0WB/sj2YsAvwQBwQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QSBSarnUl5xojc9cLjgK5G0FsxoonUMX+Xrje2R5sK8osLUhCU9Ml/BCcYhzPev7oga7bDIZ9i44qZdBI1uUpzON4eyouvbZQKmP8IJ1dj7en+YcFuSIWCPEjwjiF/lRkbVVuh4panHwX3AnQzLMh8qGgTOzg/5riRzyf6AEPPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbLpMboC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7E1C4CEC6;
	Thu,  7 Nov 2024 02:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730947603;
	bh=sOfLVR7/GFSxqbczXVx6RK558SO0WB/sj2YsAvwQBwQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gbLpMboCRzojYnjesVu8OggNdt1imzzUI7HgmoGAZ9gxwlcWucXnT2XqpLnyzmKZ9
	 O0NZFOhw1SdNaXxccL8y+18Ya4CUwpAVFRU+soQZo9xfCvtzYgSGq0ySF5/rTCPFTy
	 2FZjpb68lAb2wuiIwjzkesHyRo4e4Vl5MRFp+z9r6/5tNl2bJLtKI773y+jl5deoi1
	 NfiY0izTPIXxzd3IVB301IIq/XutcVtjsllUka3vDDYymAvxG/iqYKnaykaK4+LbDQ
	 zZVXD117F0V+NP99fheCRA7bpLNQvzqYpbFXIxZqw0Az69zZEvJ9pitTHUElwdPbIl
	 CLBYz+TFpAUBQ==
Message-ID: <60df5036-7db0-426c-b942-d2393d4e5183@kernel.org>
Date: Thu, 7 Nov 2024 10:46:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: add SEEK_{DATA,HOLE} support
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241011065128.2097377-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241011065128.2097377-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/11 14:51, Gao Xiang wrote:
> Many userspace programs (including erofs-utils itself) uses SEEK_DATA /
> SEEK_HOLE to parse hole extents in addition to FIEMAP.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

