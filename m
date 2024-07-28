Return-Path: <linux-kernel+bounces-264883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D1493E9AF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 23:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBB01F21F31
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 21:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4804E78C68;
	Sun, 28 Jul 2024 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LHAyydsJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ABE78B4E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722201532; cv=none; b=P4Uh2qh44m72Yrbk5qt4kBXAQtSjmtFx/zTkLWgx1XIFgNOlrEfkOQN7C90+xYL57DoslTzVAkJWnJ+qsgE8aDCWQuphWeW8YWqCuWYWAM8lo+0jBsgwGMgvQ+YSYy2Ry1sw3Eo8ooBhoEkPGeqBzbFaLPL7bnJ71ElOQOFQHx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722201532; c=relaxed/simple;
	bh=p6ipjOvVqF6sbK1Vn/wHSaHvySBYHhkhbaqXeUP2Q04=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rnIjyIvu9J6iStHQSwpH1WTrYkbGPWgjW8fawBB3q2HKe3oEzbueBCb6+Ki9FGkE6eV87OiVP9/Js8M3+6Pew5jDDSMtS5NlfAt/WTwO4ih03R9n0uyOL2Yh3xsvEBNf+8vPWUy7/FNc67+j0y2vLA9qUZa/SjvvDLe+G5axOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LHAyydsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CF4C4AF0A;
	Sun, 28 Jul 2024 21:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722201532;
	bh=p6ipjOvVqF6sbK1Vn/wHSaHvySBYHhkhbaqXeUP2Q04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LHAyydsJalWoIjxDSMRu97+wFnQ1QVowDjGpa2JbcKo1Gq+JQNt9koZYp5n6dSXCv
	 w5o6M2ftH42gXMsygOgd0M89g1rbIE8/+eDkBQHxceQF+QrlDFwxLrtHuj3rhmCxjm
	 AnHuEU1nA/FAV246WRA/MApyVW/lqsNZiEPQfCJk=
Date: Sun, 28 Jul 2024 14:18:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Baoquan He <bhe@redhat.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Adrian Huang
 <ahuang12@lenovo.com>, Jiwei Sun <sunjw10@lenovo.com>
Subject: Re: [PATCH 1/1] mm/vmalloc: Combine all TLB flush operations of
 KASAN shadow virtual address into one operation
Message-Id: <20240728141851.aece5581f6e13fb6d6280bc4@linux-foundation.org>
In-Reply-To: <20240726165246.31326-1-ahuang12@lenovo.com>
References: <20240726165246.31326-1-ahuang12@lenovo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jul 2024 00:52:46 +0800 Adrian Huang <adrianhuang0701@gmail.com> wrote:

> From: Adrian Huang <ahuang12@lenovo.com>
> 
> When compiling kernel source 'make -j $(nproc)' with the up-and-running
> KASAN-enabled kernel on a 256-core machine, the following soft lockup
> is shown:
> 
> ...
>
>         # CPU  DURATION                  FUNCTION CALLS
>         # |     |   |                     |   |   |   |
>           76) $ 50412985 us |    } /* __purge_vmap_area_lazy */
>
> ...
>
>      # CPU  DURATION                  FUNCTION CALLS
>      # |     |   |                     |   |   |   |
>        23) $ 1074942 us  |    } /* __purge_vmap_area_lazy */
>        23) $ 1074950 us  |  } /* drain_vmap_area_work */
> 
>   The worst execution time of drain_vmap_area_work() is about 1 second.

Cool, thanks.

But that's still pretty dreadful and I bet there are other workloads
which will trigger the lockup detector in this path?

(And "avoiding lockup detector warnings" isn't the objective here - the
detector is merely a tool for identifying issues)


