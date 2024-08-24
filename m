Return-Path: <linux-kernel+bounces-299894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5200C95DBF5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 07:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12930284164
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 05:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92D414D6F9;
	Sat, 24 Aug 2024 05:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pLTM6v2V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EA7811F7;
	Sat, 24 Aug 2024 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724477761; cv=none; b=eWy8M/yVM2TNaZ60UC+pHHNqv8ZHY9nv1wg7uMnRpDch2XU0cAQRxF61ad2rySoOnOqUXJr0P7fwuEsDdgZvf8z2cKIhmI94iVGwCzsq32IFeXv83YvliXQ0fsEpXsH0RiNOveEbTs3LmNTV4vp/O2F39xleIWZfFmouuiJFZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724477761; c=relaxed/simple;
	bh=vtXQXw/8L9O0i6cAOddVaHqj3PWX+5FxjtO9SYBADHU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=V7rJQRys8G7L0gU1FEQOvt+gTHi/6rNgStSWFpZf/BlRQOu0T7Mtnk0Oj1cD50zfS7HNcwwgAx+5JwFplmalYpm2RjQgo2iSfUJDqRDZeFhoswn3spYb9TmC9uQFSWZOkqBZt9cxnDXceEDSBRjH3spczZq8jC6iR93SA+Qxdho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pLTM6v2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CBCC32781;
	Sat, 24 Aug 2024 05:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724477760;
	bh=vtXQXw/8L9O0i6cAOddVaHqj3PWX+5FxjtO9SYBADHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pLTM6v2V+3RtGsuAPNGUUwzYB5ZIshkeajozAWlPTfe3uD9vsCRuYp/Av+2dJ9mgt
	 gQvT4ZkPw5zXkwV98+dvxt5fFrEUVAjlOQ8JjqGjFkyIXjBLmvvBMO32v0BYRPRL0R
	 EP2FXdptBA1kFuWBKOzEosKqQ9/lxzTYxX2R11B4=
Date: Fri, 23 Aug 2024 22:35:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 oe-lkp@lists.linux.dev, lkp@intel.com, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed
 folio
Message-Id: <20240823223559.942b53cea16d5cfc6b70bf2d@linux-foundation.org>
In-Reply-To: <20240823150206.565-1-justinjiang@vivo.com>
References: <20240823150206.565-1-justinjiang@vivo.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 23:02:06 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:

> After CoWed by do_wp_page, the vma established a new mapping relationship
> with the CoWed folio instead of the non-CoWed folio. However, regarding
> the situation where vma->anon_vma and the non-CoWed folio's anon_vma are
> not same, the avc binding relationship between them will no longer be
> needed, so it is issue for the avc binding relationship still existing
> between them.
> 
> This patch will remove the avc binding relationship between vma and the
> non-CoWed folio's anon_vma, which each has their own independent
> anon_vma. It can also alleviates rmap overhead simultaneously.

I assume any performance benefits are unmeasurable?

I'll queue it for testing and shall await reviewer input.

> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1522,6 +1522,59 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
>  #endif
>  }
>  
> +/**
> + * folio_remove_anon_avc - remove the avc binding relationship between
> + * folio and vma with different anon_vmas.
> + * @folio:	The folio with anon_vma to remove the binded avc from
> + * @vma:	The vm area to remove the binded avc with folio's anon_vma
> + *
> + * The caller is currently used for CoWed scene.
> + */
> +void folio_remove_anon_avc(struct folio *folio,
> +		struct vm_area_struct *vma)
> +{
>
> ...
>

In mm-unstable a lot of vma functions have been moved into the new file
mm/vma.c.  I suspect folio_remove_anon_avc() should be there also?

