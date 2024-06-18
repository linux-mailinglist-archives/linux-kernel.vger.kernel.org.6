Return-Path: <linux-kernel+bounces-218827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8A190C6C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF333B22CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D986BFC0;
	Tue, 18 Jun 2024 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B6icuYVw"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299AF19F49F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697607; cv=none; b=bUxrgRxK+DqkrAi3Gy+MlRWBOy8AV1sQUwaRTOQnDKj3tBn4TiNYjtGSaEHrcjrmJrZuxTmL0sP65D4ihQ3HLMgFDAz6Dww146+DN9XliLt7rDwGlQhmtNk54nzFNHmExYN0jj7fdy/QYBDlhzRmKrger8tazxTAXfwuwLvoPkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697607; c=relaxed/simple;
	bh=TypPilPKeGN6q26fGqBhQUz75Slne2ceoj8HorDfUoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itPRMgYM6GWd/O21ug0yDGK53+n0CY8q09Yh6dySp1wcO8BM72KKz6I0daJ0PqbR1DVlAZ683XvZ0d2s8dHWaxo69HLbPbpD7oy20AZDlVLKAcM/Z/sG//jkwcnHOZUg1meVPU0Vez56MiYBgTRrGRpioN0ebLCn4Dkll+yFq4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B6icuYVw; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yuzhao@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718697602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mc0QvhK9jGXMdPivHuSTCJOKTEtf+ZVQCpU53OOKO68=;
	b=B6icuYVwIyCgTukBQQOKSjE5ETZ0z78q/moqaK0yaAFnnPZw4DnkgQZ3GMSDW3Vq8KIA4F
	zHENAzUSbsKhk5rb4Thfs+ysB6QP4fSicmDvGJT7ho7kZVvqEQDihrC18pVBtA/ekjX3/7
	0E9bePUrcLcXA7dozjfCBpGStx9B6fs=
X-Envelope-To: minchan@kernel.org
X-Envelope-To: senozhatsky@chromium.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: flintglass@gmail.com
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <62bf4a21-ae1a-4ed0-8b55-9b444d9ca0a7@linux.dev>
Date: Tue, 18 Jun 2024 00:59:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] mm/zswap: use only one pool in zswap
To: Yu Zhao <yuzhao@google.com>
Cc: Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Takero Funaki <flintglass@gmail.com>,
 Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240617-zsmalloc-lock-mm-everything-v1-0-5e5081ea11b3@linux.dev>
 <20240617-zsmalloc-lock-mm-everything-v1-2-5e5081ea11b3@linux.dev>
 <CAOUHufaCYqwZLwCzHbC40KDjSWKYFoVKiPfRxvxr+2Z8JRRXaA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAOUHufaCYqwZLwCzHbC40KDjSWKYFoVKiPfRxvxr+2Z8JRRXaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/17 13:16, Yu Zhao wrote:
> On Mon, Jun 17, 2024 at 6:58 AM Chengming Zhou <chengming.zhou@linux.dev> wrote:
>>
>> Zswap uses 32 pools to workaround the locking scalability problem in
>> zsmalloc,
> 
> Note that zpool can have other backends (zbud, z3fold), and the
> original patch was developed (even before zswap could use zsmalloc) to
> make sure it works for all the backend.
> 
> This patch only makes sense now only because zsmalloc became a lot
> more popular than other backends (even though some distros still
> default to zbud).
> 

Right, we mostly focus on zsmalloc, I just do the same testing using zbud:

                               	real    user    sys
6.10.0-rc3-zbud     		138.23  1239.58 1430.09
6.10.0-rc3-onepool-zbud       	139.64  1241.37 1516.59

Since we don't do any locking optimization for zbud, so performance
is worse than 32 pools as expected.

Actually Yosry did a great testing [1] to compare zsmalloc, zbud and 
z3flod, to support that we can just use zsmalloc in zswap, so we can
drop zpool, zbud and z3flod.

I will include this information in the changelog in the next version.

[1] 
https://lore.kernel.org/lkml/CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com/

Thanks.

