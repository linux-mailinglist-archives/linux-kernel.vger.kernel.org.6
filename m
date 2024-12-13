Return-Path: <linux-kernel+bounces-444263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE929F036C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E420E284DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B3017BB34;
	Fri, 13 Dec 2024 04:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uUrqx2lt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801CC155398;
	Fri, 13 Dec 2024 04:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734063133; cv=none; b=bDl006MjxCJDrb3XoxTL3A+FGQX7OwLZ4bS1Vk10B4W/KwBPBahMPXX33MYuxAVy+6kY4xM+tnoC9Ya+0EpzhUZdckIqDccUhN4OoaHK/9yBkgXBsHkUlfRbFg1OFV6jbWLJdMV7nwXppAgrSWr82Nl8EZQJ34JHsIqW8oUoqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734063133; c=relaxed/simple;
	bh=l7+0soeLZV6Tw88As9C8X85YyYlNicvO0yLGnHWSOIY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s/etrc6sfJ/ZyKcvhIvFmsQIdbKOv4ImS+YtGmXCrFl3KsXG63O96eqdXe0YYaph8JsKyvKlIn6OoYy5xepet2wz/S7IgVaD8KzGuosNkTM5NyPzDI0ywTsxwWEPuF+dx5JXQ4RK6MyR+nlDvqnFMT1gPgqU8i+1XHZXL47EejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uUrqx2lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC82C4CED2;
	Fri, 13 Dec 2024 04:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734063133;
	bh=l7+0soeLZV6Tw88As9C8X85YyYlNicvO0yLGnHWSOIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uUrqx2lt0ci4QISGJJyjYSwwnPMgN93yieOP/7gPivjxgfpBIIpI7WDM+Iqkf+HMb
	 71ZgyDAM0tHo4XDsuoS7Nxa1w2rKX78q+O/OSwMXUE7XCC2HuAHUE0JiCfl0j/mOTA
	 icMhtwsYogA6BKeo60OBca4MMcoRjH7NpAAUVdGM=
Date: Thu, 12 Dec 2024 20:12:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Wang <00107082@163.com>
Cc: surenb@google.com, kent.overstreet@linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lkp@intel.com,
 oe-lkp@lists.linux.dev, oliver.sang@intel.com, yuzhao@google.com
Subject: Re: [PATCH v3] mm/codetag: clear tags before swap
Message-Id: <20241212201212.c61bfebbbdb51b3c8bfeed11@linux-foundation.org>
In-Reply-To: <20241213013332.89910-1-00107082@163.com>
References: <CAJuCfpF2e7niEbR=nX2u0HZHq-7tjRGB=xV397pFpjdzBqUGfQ@mail.gmail.com>
	<20241213013332.89910-1-00107082@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 09:33:32 +0800 David Wang <00107082@163.com> wrote:

> When CONFIG_MEM_ALLOC_PROFILING_DEBUG is set, kernel WARN would be
> triggered when calling __alloc_tag_ref_set() during swap:
> 
> 	alloc_tag was not cleared (got tag for mm/filemap.c:1951)
> 	WARNING: CPU: 0 PID: 816 at ./include/linux/alloc_tag.h...
> 
> Clear code tags before swap can fix the warning. And this patch also fix
> a potential invalid address dereference in alloc_tag_add_check() when
> CONFIG_MEM_ALLOC_PROFILING_DEBUG is set and ref->ct is CODETAG_EMPTY,
> which is defined as ((void *)1).
> 
> Signed-off-by: David Wang <00107082@163.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202412112227.df61ebb-lkp@intel.com

This points at 

51f43d5d82ed ("mm/codetag: swap tags when migrate pages"), which had
	Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")

e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()") had
	Fixes: dcfe378c81f7 ("lib: introduce support for page allocation tagging")
	Cc: <stable@vger.kernel.org>

And I'm thinking that this fix should have
	Fixes: 51f43d5d82ed ("mm/codetag: swap tags when migrate pages")
	Cc: <stable@vger.kernel.org>


