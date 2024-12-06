Return-Path: <linux-kernel+bounces-435426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C339E777B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8C6288AB7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EC92206AA;
	Fri,  6 Dec 2024 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYxI9GY+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBF220687
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506291; cv=none; b=PN0uBrh9MPKP1DeVCgg8FBjDd9PgStio0Cn9ooBI82EY/9ff/rRT2SB6foIZqSSTTfnPb1jKuZRwZM/uszo5rqjEEL6zQS/0AnRQzqmuWqw4lGyskxW/Hzbh/5GgMpmR7RTjunBXWc2XUIuz0ao61lG7m295sTeZ0EOq1lL/Zts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506291; c=relaxed/simple;
	bh=cDewpNOZhWDjQMF7Lhzo1b4KrgQhtwV/+6fL7MNxyHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flRvrhGbIVc9YfXKtRhPMiE5nnKzrnmUr4r4JvtJmIzvqeozSDY+Ot3HdbzHKz6vJ6KNHX9ZhkRXYaLyfonAwvrXdYq10PxuOW/UCSVvr5kQpKemOo+PGdJVRq/TkoxWFY0iVJONk5x5uVP3wcUOti99pXeJaayb1o330jtPP90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYxI9GY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5771C4CED1;
	Fri,  6 Dec 2024 17:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733506290;
	bh=cDewpNOZhWDjQMF7Lhzo1b4KrgQhtwV/+6fL7MNxyHA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WYxI9GY+v0cl3lqqvXLiYaPc/ojnMiM0ZDQK0sC2sM8yVYE94eR5nwQEFmF/WWjxl
	 MopF+I8i0SZRk7H5NvOVW0mZjK7w6bvojazvv4eBEkVyH14z6+7OZnzXylHJqkQGTl
	 2SV2JnaSx8ow1XryCWN5PpTthKXbRydiB0IdJK04YpN40LyxiUuA5OTHGrG5rfD3gf
	 NtSx5hiLPEzpETBDJZ0GrzuaY4pY80FsGs5n+2MUxBG0+Qt12KaWT3GqEz1uStyNIx
	 /X6u9UOCtklahP5KFZj0oZ0qn+qSjxaulOR8tKHxbinDwJuxSMinLQZehgUmUfjZ/m
	 VxCi2VFUqbEAQ==
Message-ID: <bc3b86dd-9bb6-4c6e-b6df-35c687375cde@kernel.org>
Date: Fri, 6 Dec 2024 09:31:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: use clear_user_(high)page() for arch with special
 user folio handling
To: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Vlastimil Babka <vbabka@suse.cz>,
 David Hildenbrand <david@redhat.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard
 <jhubbard@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko
 <glider@google.com>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Vineet Gupta <vgupta@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20241206141938.2750393-1-ziy@nvidia.com>
 <Z1Mpfofz45bFawSq@casper.infradead.org>
 <78D4C1B5-3EE7-47F0-A7A2-F1ACFE71CED0@nvidia.com>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <78D4C1B5-3EE7-47F0-A7A2-F1ACFE71CED0@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 09:08, Zi Yan wrote:
> On 6 Dec 2024, at 11:42, Matthew Wilcox wrote:
>
>> On Fri, Dec 06, 2024 at 09:19:38AM -0500, Zi Yan wrote:
>>> For architectures setting ARCH_HAS_CPU_CACHE_ALIASING, which requires
>>> flushing cache and arc, which sets folio->flags after clearing a user
>>> folio
>> I think arc just has some legacy code left that needs to be ripped out.
>> See commit d5272aaa8257 which took away ARCH_HAS_CPU_CACHE_ALIASING
>> from arc.
> The PG_dc_clean bit seems not to be related to cache aliasing.
> See commit eacd0e950dc2 ("ARC: [mm] Lazy D-cache flush (non aliasing VIPT)")

Indeed it is not related to aliasing.

>> Looking at 8690bbcf3b70, I wonder if you want to use
>> cpu_dcache_is_aliasing() here?
> Yeah, this is more precise. Will use this in my next version. Thanks.

Commit 8690bbcf3b70 was wrong for ARC as it assumed aliasing is true. The
aliasing D$ code is all gone and cpu_dcache_is_aliasing() is false for ARC now.

-vineet


