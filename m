Return-Path: <linux-kernel+bounces-275353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E239483CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3196C1C21EA0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2919F15FA75;
	Mon,  5 Aug 2024 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldT2fBId"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C9149E0A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722891705; cv=none; b=tGE6WxnzTTjRzs6iNiM3TZK+d58WmrO7v10xwhGOA+TjPlpPb/O+PHJccBJSQPGQwll5eiwWeqjGKCkamTvzSxnRuEwNzqGAq/ThlNf3E/Jz7HmzQRvhLThrH/GFguef5lqzqaEVMB2m1LC49ttuvvfrHDjfzyfepvFEiViPaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722891705; c=relaxed/simple;
	bh=eBrA28q49foh0wgACAxBdLtft9vJsjYqIE2PmIgv7xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULoTjGckkVMJCcZW40a8wJ/GCiSqAk3x31iOmtI+Fcf8SeK4KznLHFNud6hNx5WNd/XqJIeXE/9bKQATCiLDCLtSaN53cBw+88oz64zqVZh7+wKjTZY3sfIb8syvppkorZyFZlzEkVppg7wqLyZrwzKIabdrP1B9VNcOaIka9Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldT2fBId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4B2C4AF0E;
	Mon,  5 Aug 2024 21:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722891704;
	bh=eBrA28q49foh0wgACAxBdLtft9vJsjYqIE2PmIgv7xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldT2fBIdEbA7+rP4EImb8EALvzcTKvyS2kmpqufAYYtd6QErBw5HqziIWa75GvDYM
	 tzXq9g2eHSukoyDlOthprUu8gphlsZLWQjhTmsAwNYQdu6FIkLSZAzt1/S12+mRQck
	 NJgXNuY1P18ZKNXNnH0rkXDO0ayTMhZgRT/D9KirNJZTfLkwNmyO4UF0p7gI7h7irI
	 d4Vdl5OsL7OzA2JZBfWUHVlkuGWrDXTKfGrN6Xj7eXtq1IcKsWdunEPQbb2sMJUgBQ
	 TrqfChhBYCuNRP3CcxS0WDMdvg21pY3AAvxsMQu4rNV2pjvnMOAHiMLV1nZSqbl08G
	 Ax9u2flpMZybQ==
Date: Mon, 5 Aug 2024 14:01:44 -0700
From: Kees Cook <kees@kernel.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, jannh@google.com, sroettger@google.com,
	adhemerval.zanella@linaro.org, ojeda@kernel.org,
	adobriyan@gmail.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org
Subject: Re: [RFC PATCH v1 0/1] binfmt_elf: seal address zero
Message-ID: <202408051400.C402BE97E@keescook>
References: <20240801170838.356177-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240801170838.356177-1-jeffxu@google.com>

On Thu, Aug 01, 2024 at 05:08:32PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> In load_elf_binary as part of the execve(),  when the current
> task’s personality has MMAP_PAGE_ZERO set, the kernel allocates
> one page at address 0. According to the comment:
> 
> /* Why this, you ask???  Well SVr4 maps page 0 as read-only,
>     and some applications "depend" upon this behavior.
>     Since we do not have the power to recompile these, we
>      emulate the SVr4 behavior. Sigh. */
> 
> At one point, Linus suggested removing this [1].

For users, I didn't find much in a Debian Code Search:
https://codesearch.debian.net/search?q=MMAP_PAGE_ZERO&literal=1&perpkg=1

I see rr uses it in testing, and some utils have it as an option, so I
think maybe just leave it supported.

> 
> Sealing this is probably safe, the comment doesn’t say 
> the app ever wanting to change the mapping to rwx. Sealing
> also ensures that never happens.

Yeah, this seems fine to me.

> 
> [1] https://lore.kernel.org/lkml/CAHk-=whVa=nm_GW=NVfPHqcxDbWt4JjjK1YWb0cLjO4ZSGyiDA@mail.gmail.com/
> 
> Jeff Xu (1):
>   binfmt_elf: mseal address zero
> 
>  fs/binfmt_elf.c    | 4 ++++
>  include/linux/mm.h | 4 ++++
>  mm/mseal.c         | 2 +-
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> -- 
> 2.46.0.rc1.232.g9752f9e123-goog
> 

-- 
Kees Cook

