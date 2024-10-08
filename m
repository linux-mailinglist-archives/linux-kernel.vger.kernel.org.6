Return-Path: <linux-kernel+bounces-354341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7395C993C48
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1131C22783
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081D014A91;
	Tue,  8 Oct 2024 01:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wF94IDHO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8261388;
	Tue,  8 Oct 2024 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728351054; cv=none; b=GKhY3C5dgzcXfjtKAPlsEeNb/Q+nrg9zr27dNnumkcXM/LkjvkOLS+8oLuNt/615EgMu4rBuIUSGb2u8Op4fQsk6EVbtmKlCLGeGT7LJpoE7JfU3FVStB3MYux78s2iY/BqDvBwQ7YVT4I9YkjjBuUOtZwtSrs2jihFgTDfcShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728351054; c=relaxed/simple;
	bh=vxCcy/wP0tEtAiAQ0trrZTIT30svRSVdwkpX1EAEGt4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RlQq/yIi+slRONkmeSU9IHooCy6+7tu+YvlqFLmQocYcBbUQcSD5dm3QtUBQpdjPiKBlSuzfC2eu9GUiHStT2wl/91AW4kpjpSJpmoFKZxFCSZ5lO+MWZo8x0A5M0SueKPql9V0aoDqzFVcvpCyDLYX7cKkKImBg9MKUM05pbik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wF94IDHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B035C4CEC6;
	Tue,  8 Oct 2024 01:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728351053;
	bh=vxCcy/wP0tEtAiAQ0trrZTIT30svRSVdwkpX1EAEGt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wF94IDHOQAeyer+0lJ5Mckea+dNy8krILakDNpJqOzg+tg8ispVGQYFQXOm/FTmJN
	 oW947/ZfzwLHLMvCCxMXdadu5OVEaYMZF2TU4yBjhtl98Z7Mn2Z+4OAzW71vxjHQ0h
	 gAa5NjNqZuy0fz1A78aePnk2FhR1355LE0MRx4yg=
Date: Mon, 7 Oct 2024 18:30:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <lkp@intel.com>
Cc: Jeongjun Park <aha310510@gmail.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, kasong@tencent.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm: swap: prevent possible data-race in
 __try_to_reclaim_swap
Message-Id: <20241007183052.9d87f42e19db5f9777dc8e77@linux-foundation.org>
In-Reply-To: <202410071223.t0yF8vP8-lkp@intel.com>
References: <20241004142504.4379-1-aha310510@gmail.com>
	<202410071223.t0yF8vP8-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 13:06:49 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Jeongjun,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jeongjun-Park/mm-swap-prevent-possible-data-race-in-__try_to_reclaim_swap/20241004-222733
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20241004142504.4379-1-aha310510%40gmail.com
> patch subject: [PATCH] mm: swap: prevent possible data-race in __try_to_reclaim_swap
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241007/202410071223.t0yF8vP8-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241007/202410071223.t0yF8vP8-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410071223.t0yF8vP8-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> mm/swapfile.c:203:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>      203 |         if (!folio_trylock(folio))
>          |             ^~~~~~~~~~~~~~~~~~~~~
>    mm/swapfile.c:254:9: note: uninitialized use occurs here
>      254 |         return ret;

This warning can't be correct?

