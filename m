Return-Path: <linux-kernel+bounces-187948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AF58CDB2A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD1D1C21616
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700B383CC9;
	Thu, 23 May 2024 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oPQ3W4qa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A81401F
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494427; cv=none; b=CxJbOdJKkKHMjke32Ovy4o5FQJfnT4Lky1fC/4ExxzzOkmEWIUFztzf1o9uxODrLTzmrVZg6naLEqlmN6InjWXKPgqjAZ9l7GZLWLmZbiiY2tiKugo3RBrGtmVMWhbJZx0TExdOhFRKOpdSao7rbs6rZN3jW2KzWL75e0nk9AY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494427; c=relaxed/simple;
	bh=ktn25oWNiTamPIaMK1L4gT/pXxd7W73/jJk25eLwhuo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TNlABlBHc+PxDKsv7TtrwwkMDvWGBRFVjS9h6tklJxYhEsZpM83Zwf4vI/dqIhFtmcV7iGCgiH/HsumhyeQj/PnwYaeArAC7W7960WRs5btibduAjsP7K3hD/3eCezvPH53wCeFn2fLzuj3GdeJXle71/IyCoZfcY97SzoS8q1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oPQ3W4qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15FBC2BD10;
	Thu, 23 May 2024 20:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716494427;
	bh=ktn25oWNiTamPIaMK1L4gT/pXxd7W73/jJk25eLwhuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oPQ3W4qannFH4tmvPU0w64NaYJ8KS2tYEJ8Jy1xzM4ZCVlkj83Q48TnLPInc/wb4c
	 rNXomFX/R8j9tqOKeAgfb/nPWta2yODr2qcNLjB1IZ4ur4T8A8NQZ4uRUzhSRvAVDS
	 CZZ5pF8hGnEguirOpnBGZeSExshclwIE+kRzroq8=
Date: Thu, 23 May 2024 13:00:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Masahiro
 Yamada <masahiroy@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Yoann
 Congal <yoann.congal@smile.fr>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Nhat Pham <nphamcs@gmail.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] gcc: disable '-Warray-bounds' for gcc-9
Message-Id: <20240523130026.c57a8e1e7f4140d2642c84d2@linux-foundation.org>
In-Reply-To: <20240522225830.1201778-1-yury.norov@gmail.com>
References: <20240522225830.1201778-1-yury.norov@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 22 May 2024 15:58:30 -0700 Yury Norov <yury.norov@gmail.com> wrote:

> '-Warray-bounds' is already disabled for gcc-10+. Now that we've merged
> bitmap_{read,write), I see the following error when building the kernel
> with gcc-9.4 (Ubuntu 20.04.4 LTS) for x86_64 allmodconfig:
> 
> drivers/pinctrl/pinctrl-cy8c95x0.c: In function ‘cy8c95x0_read_regs_mask.isra.0’:
> include/linux/bitmap.h:756:18: error: array subscript [1, 288230376151711744] is outside array bounds of ‘long unsigned int[1]’ [-Werror=array-bounds]
>   756 |  value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
>       |               ~~~^~~~~~~~~~~
> 
> The immediate reason is that the commit b44759705f7d ("bitmap: make
> bitmap_{get,set}_value8() use bitmap_{read,write}()") switched the
> bitmap_get_value8() to an alias of bitmap_read(); the same for 'set'.

So it seems that all kernels which contain b44759705f7d should have
this change?  If so, and as b44759705f7d appears to be in the net tree
then the net tree is a suitable place to carry this patch?

Or I can send it into Linus this -rc cycle and things will sort themselves out.

Thoughts?


