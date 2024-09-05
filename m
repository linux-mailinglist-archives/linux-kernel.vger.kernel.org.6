Return-Path: <linux-kernel+bounces-316612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86DC96D1EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0FD1F2CA1A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71962192D9E;
	Thu,  5 Sep 2024 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX/XEl58"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7ED13AA2B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524526; cv=none; b=dUqwwBerJauvUaptKRi663rnxcnTSgPsPRsaxQdUxq3k1WRhgprY5/3BO/3XvibqjO2lcpmooHcS956McQcSCrcp1NLthodcflRFrrdNWk7N7raG7h+aiDmt3rx2J4Pd2j1mwe62PB4TzN1tRLIvV/5NxPuEHZqqEqvm6ABYTIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524526; c=relaxed/simple;
	bh=6O+X9dfhS4zYptfRJFP88uQaZ4Yq66gOjR9HYND0g7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIYB3kFt+RAPMwWQmy9ixQzBdB4J3oPgbyslMVZOqC/p+md7XEBLgXlJk7RJkPpAl7Ip86gL4R4P/F86tMwya3PRQZrjy27QmIWAxN8Ox4V8FGsxm5iSLCHfHBnVEncLy1OyIVJBY6Zs5SpsLvb5gf5uUXjTwfYBXBkKLdrukKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX/XEl58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9177EC4CEC4;
	Thu,  5 Sep 2024 08:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725524526;
	bh=6O+X9dfhS4zYptfRJFP88uQaZ4Yq66gOjR9HYND0g7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rX/XEl58dPKRF1VsQ8bD4j8oviaDA9YSMCjJz+w0osDco+qHCSPyHMI+amXUb92pW
	 paeYLsn+WMS32YnIC9luYH3VRkoMoLNYV0U0PaxmC8hw9F1E+28DMuOvZXc/wJYCfl
	 j81N0Oa9ctNOGSAVqvbfh/tP18cFp0Jq6BQRE3rp7YN1oiQMSjx6eLC8+ODNCYRiJk
	 1pa9czZhaWEL3WZQQupZvTmP0HNNoGgevubkGZOQdmYeLLo3MiKYj0GZ0VrKZJr3v5
	 Ub5RQ7Ldp3KaqQBcOlNTi4RJSytcFEGG8an3Q8lUsUyVYPN0V985Pl26K60sxIg87Y
	 44mYVY2kwjaqA==
Message-ID: <e0a6cccc-c982-4d8c-95a4-afa63da6aa7b@kernel.org>
Date: Thu, 5 Sep 2024 16:22:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/30 11:28, Gao Xiang wrote:
> It actually has been around for years: For containers and other sandbox
> use cases, there will be thousands (and even more) of authenticated
> (sub)images running on the same host, unlike OS images.
> 
> Of course, all scenarios can use the same EROFS on-disk format, but
> bdev-backed mounts just work well for OS images since golden data is
> dumped into real block devices.  However, it's somewhat hard for
> container runtimes to manage and isolate so many unnecessary virtual
> block devices safely and efficiently [1]: they just look like a burden
> to orchestrators and file-backed mounts are preferred indeed.  There
> were already enough attempts such as Incremental FS, the original
> ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
> for current EROFS users, ComposeFS, containerd and Android APEXs will
> be directly benefited from it.
> 
> On the other hand, previous experimental feature "erofs over fscache"
> was once also intended to provide a similar solution (inspired by
> Incremental FS discussion [2]), but the following facts show file-backed
> mounts will be a better approach:
>   - Fscache infrastructure has recently been moved into new Netfslib
>     which is an unexpected dependency to EROFS really, although it
>     originally claims "it could be used for caching other things such as
>     ISO9660 filesystems too." [3]
> 
>   - It takes an unexpectedly long time to upstream Fscache/Cachefiles
>     enhancements.  For example, the failover feature took more than
>     one year, and the deamonless feature is still far behind now;
> 
>   - Ongoing HSM "fanotify pre-content hooks" [4] together with this will
>     perfectly supersede "erofs over fscache" in a simpler way since
>     developers (mainly containerd folks) could leverage their existing
>     caching mechanism entirely in userspace instead of strictly following
>     the predefined in-kernel caching tree hierarchy.
> 
> After "fanotify pre-content hooks" lands upstream to provide the same
> functionality, "erofs over fscache" will be removed then (as an EROFS
> internal improvement and EROFS will not have to bother with on-demand
> fetching and/or caching improvements anymore.)
> 
> [1] https://github.com/containers/storage/pull/2039
> [2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com
> [3] https://docs.kernel.org/filesystems/caching/fscache.html
> [4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.com
> 
> Closes: https://github.com/containers/composefs/issues/144
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

