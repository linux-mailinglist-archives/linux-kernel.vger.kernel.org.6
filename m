Return-Path: <linux-kernel+bounces-229474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CD9916FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6F11F21356
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1FC17837A;
	Tue, 25 Jun 2024 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z0yofwco"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AED148FE4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339324; cv=none; b=Je+72/2Y2m75ebzRf3l6DXPx9V0a1baEbQB/rhiAWGto6VOY7Rs6Y50r3EmbOHDZf0o4EeE3uSRiw8aMxqy2rSKvlKOWqK5QVO6vxpNy2LTvTeTyWG0rEveC+WSzHfunZSEbMzPZl65dgYs9V9a4y0bk0Hha8G6xd5FsUKLfTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339324; c=relaxed/simple;
	bh=B5hLeC+/MpTqohgqkr15NOeoCPuGPuUmOeXG1p+zKnE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fGpaHchHkH4efLPrC6ju44dgr9OQnBB1Mvf3F+YHqR5g+7l3A33NRccvecZvFLVT2LMcctEm4lHjMXeQtg0N5oHPZWudUaDgo2OSVBbvsc8x2CTLFf3jHyHuB8PGs+BRmASN+q70/wgfnRGJ/K+E3LQcpJzjMlzfCxbjWtApMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z0yofwco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538E0C32781;
	Tue, 25 Jun 2024 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719339323;
	bh=B5hLeC+/MpTqohgqkr15NOeoCPuGPuUmOeXG1p+zKnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z0yofwcoetIvCA88QUtaAgaOW5GMSNgkm+h2T3DXacHAa2VfUqpiHEzic8KRB0QnS
	 VUz0ZvK0ZtVPHlcAS7NRoFrDD9Qsb7kMT68IajoGlCI+ZWKI8rTgps5TQ6UGNj8mcr
	 jexXZFjX20g8sQxJg1FEfdO361T7XfIytA+hQZEM=
Date: Tue, 25 Jun 2024 11:15:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "yongfa.hu" <hushange@163.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove partial comments of kswapd_shrink_node head
Message-Id: <20240625111522.045d2302959ce8dde7f47826@linux-foundation.org>
In-Reply-To: <20240625121547.23613-1-hushange@163.com>
References: <20240625121547.23613-1-hushange@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 20:15:47 +0800 "yongfa.hu" <hushange@163.com> wrote:

> when function kswapd_shrink_node return, it will not check the condition
> mentioned in the removed comments: "if the lack of progress was
> due to pages under writeback", so remove it.

Is this correct?  shrink_folio_list() can skip under-writeback pages?


> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6747,8 +6747,7 @@ static bool prepare_kswapd_sleep(pg_data_t *pgdat, int order,
>   * zone that is currently unbalanced.
>   *
>   * Returns true if kswapd scanned at least the requested number of pages to
> - * reclaim or if the lack of progress was due to pages under writeback.
> - * This is used to determine if the scanning priority needs to be raised.
> + * reclaim. This is used to determine if the scanning priority needs to be raised.
>   */
>  static bool kswapd_shrink_node(pg_data_t *pgdat,
>  			       struct scan_control *sc)
> -- 
> 2.17.1

