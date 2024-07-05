Return-Path: <linux-kernel+bounces-242771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC05928CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA14A1F2606D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E235016B741;
	Fri,  5 Jul 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsTmswnq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D887145B10;
	Fri,  5 Jul 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720199757; cv=none; b=KhudSyTFEO3uDaSIJpXRdsDgefNS2FrFY0U6xehAxBwHKGISK6SauiRid/bgMLfeMlZTEvQuCAxDvYakucBJoIOlbD/nV6eDF6n3Gez1wWeTIzWqOAO/s7WAijm1zBXhQq+98geQucVjqf2ONIVm1oFgTVdoZLk6T28jT3H8QSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720199757; c=relaxed/simple;
	bh=cANfSeFPR/KCm7xUKPG0KOFYYkm6VqitRNLMMx7oG14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoSJqhCLQS6i9/FGUs3CPDMvm6GW0GpY4qdvAHzvxIToAswoiJEMvzUookXsU7Q2iMbLz4aYySFGsTIDDAgo/mknDcKD1aU04w9WjnTMQIw9mP82dxg2rAGzI40L8j37bwwsj3dZC3Qw//B/Q2U/RK4DHaeYUrycdNEQyuoKSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsTmswnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CE8C116B1;
	Fri,  5 Jul 2024 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720199756;
	bh=cANfSeFPR/KCm7xUKPG0KOFYYkm6VqitRNLMMx7oG14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsTmswnqQuNIJd0WL3eoFCisnQdFwGPb7HhwrtLqkbEoCehKYD6t4CqEy6xYcVTPt
	 PnyYECAEUfyHNLwgumidiZFmV5e/hLTwhNhTn7TlMieNMxKC03ZdMGzJh/1wfsSDvj
	 PMh6pq7Yoo9RV6iBop8uOWkZLnOUe3GzJdLcBu2yAC3D1Fc82TSALWkUelzl8byxVY
	 LqhshdxKDFNJy8OILLipGOSkAcncXfDLmp+A16OHbgWC9qYUJcxZ90XwgJHddfuIi4
	 0389dgHe5V04d3ladOocqswFSK8xYNp6Q5aD8jgirbwtkI6MTGCEBDNMy8/UO7P9co
	 FTYyUwJ0RugkQ==
Date: Fri, 5 Jul 2024 10:15:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, minchan@kernel.org,
	willy@infradead.org, senozhatsky@chromium.org, david@redhat.com,
	42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 17/20] mm/zsmalloc: convert get/set_first_obj_offset()
 to take zpdesc
Message-ID: <20240705171554.GE987634@thelio-3990X>
References: <20240703040613.681396-18-alexs@kernel.org>
 <202407052102.qbT7nLMK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407052102.qbT7nLMK-lkp@intel.com>

On Fri, Jul 05, 2024 at 10:43:41PM +0800, kernel test robot wrote:
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/alexs-kernel-org/mm-zsmalloc-add-zpdesc-memory-descriptor-for-zswap-zpool/20240703-182314
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240703040613.681396-18-alexs%40kernel.org
> patch subject: [PATCH v2 17/20] mm/zsmalloc: convert get/set_first_obj_offset() to take zpdesc
> config: i386-randconfig-002-20240705 (https://download.01.org/0day-ci/archive/20240705/202407052102.qbT7nLMK-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240705/202407052102.qbT7nLMK-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407052102.qbT7nLMK-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> mm/zsmalloc.c:471:12: warning: function 'is_first_zpdesc' is not needed and will not be emitted [-Wunneeded-internal-declaration]
>      471 | static int is_first_zpdesc(struct zpdesc *zpdesc)
>          |            ^~~~~~~~~~~~~~~
>    1 warning generated.

I am not sure why the robot thinks that this change introduced this
warning, I think it has been present since patch 2 of this series.

The warning occurs when CONFIG_DEBUG_VM is disabled because
is_first_zpdesc() is used with VM_BUG_ON_PAGE, which ultimately
evaluates to BUILD_BUG_ON_INVALID() / sizeof(), so is_first_zpdesc() is
only used in a compile time context for this configuration. Perhaps this
can just be marked as __maybe_unused?

Cheers,
Nathan

