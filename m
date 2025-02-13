Return-Path: <linux-kernel+bounces-512089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6003A333E8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75BD4188A714
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EF31CF8B;
	Thu, 13 Feb 2025 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J8sW0qAH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D9B8BEE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405902; cv=none; b=lQQVWTXckJq4VMQr6aiPjOSccLbU7ud1UtAKnj1P93cL5PS5u/VU9mSwEe2dVh3QWMZGU3XWNevxjblB9baYF7g7gm9+ysNk3/hEPFBhCSe4gNqtVstx61iWyi3Bo4aLgNfHsfhfZlRqTTi48vhtEfVT/WeJbCRh5Vm23lE6qaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405902; c=relaxed/simple;
	bh=rBKFdICfXC//TwPhUjStYFCCOyfQfVVxwoSt87pnLR4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oMXzCzrZvV6ve+FCJr7L6V8p/Aq7gyx9XcfriRzGt+e1uSWsrYiZfHA+F/k+u18ZfALweC3ECJCzdbJUF0j8uUxzVUxePFsLaI3tXRe0Fzjpeux3eeYJemreGhUWXAku/asTsz4u40gsD1wym0S8YBUeMJ7vGtJvn5sQ3FTh04Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J8sW0qAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F34C4CEDF;
	Thu, 13 Feb 2025 00:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739405901;
	bh=rBKFdICfXC//TwPhUjStYFCCOyfQfVVxwoSt87pnLR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J8sW0qAHXhdqY4iL/ynVFTbeSGqS9ioHNlMnvu2nWpe0KjAOPlzzBTOvRxBivgynl
	 G+FfSFosVTYJsSOF4w6AxXZS3Dr94f78mNmDigm7eLKpQxVfFcTMXAXS/SkYlL7TZl
	 JEKEbHnmK4P5o9sN6glDHNE5xfmyrb5ZKiJVhwZo=
Date: Wed, 12 Feb 2025 16:18:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: gaoxu <gaoxu2@honor.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>, Barry Song <21cnbao@gmail.com>,
 yipengxiang <yipengxiang@honor.com>, Hugh Dickins <hughd@google.com>, Chris
 Li <chrisl@kernel.org>
Subject: Re: [PATCH] mm: Fix possible NULL pointer dereference in
 __swap_duplicate
Message-Id: <20250212161820.4fda79a3333d2345b60cef72@linux-foundation.org>
In-Reply-To: <44655569e3a1419f800952004f07e714@honor.com>
References: <44655569e3a1419f800952004f07e714@honor.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 12 Feb 2025 03:13:46 +0000 gaoxu <gaoxu2@honor.com> wrote:

> swp_swap_info() may return null; it is necessary to check the return value
> to avoid NULL pointer dereference. The code for other calls to
> swp_swap_info() includes checks, and __swap_duplicate() should also
> include checks.

Actually very few of the swp_swap_info() callers check for a NULL return.

> The reason why swp_swap_info() returns NULL is unclear; it may be due to
> CPU cache issues or DDR bit flips.

Quite possibly it's a kernel bug.

> The probability of this issue is very
> small, and the stack info we encountered is as follows：
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000058
>
> ...
>
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3521,6 +3521,8 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
>  	int err, i;
>  
>  	si = swp_swap_info(entry);
> +	if (unlikely(!si))
> +		return -EINVAL;
>  
>  	offset = swp_offset(entry);
>  	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);

OK, I guess avoiding the crash is good.  But please let's include a
WARN so that we can perhaps fix the bug, if one is there.


