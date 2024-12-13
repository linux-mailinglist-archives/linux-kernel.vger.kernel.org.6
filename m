Return-Path: <linux-kernel+bounces-444977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCF99F0F76
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED69C1654E0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E801E1C01;
	Fri, 13 Dec 2024 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YrBcLVhV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE00F8F5E;
	Fri, 13 Dec 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101240; cv=none; b=JEGYpyaE01yEQXxbDWuhnpgPgeElsvwLODR3/dc32Zo/UdLOQlxx/WUf7OpcF/CG73upyzVkrRk9DxngrYnZTVVWpMdm5YdRCGCzc1KACL3dFTrsFtbwJBqi1xiUVav9z7fD+PWWHvUJ5vQ0nlDa9/5GMJqYzeS2F1vNvsAoZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101240; c=relaxed/simple;
	bh=hPlLyQyT9q+n+xhlDjjfNeo4Y/HqzccMYlpGK2+cwNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8sheohaH+n6djb3pqPpzAf3P5LWvL1E/pN0GTolrgujSHYO72INRg7joGUJmS0l4bDRy5fMHTZpmn+zQlln77TGYY4nRj94KLOK9VzeuezOf8XwQEt67y6A+v5AFb0z56SyBiUM0RYdNhwcOfYZy8aTr7nsznv6PeeLr5TYBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YrBcLVhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19859C4CED0;
	Fri, 13 Dec 2024 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734101239;
	bh=hPlLyQyT9q+n+xhlDjjfNeo4Y/HqzccMYlpGK2+cwNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrBcLVhVf55qyf4t+A/U94wBTfU7QU8DDJ+tyYZGGP1xHbi+/Hpnek8vao6n9YtGw
	 ISfYubhYVJkJAbNR/xxfpetROzvPILxW6zeXv4EOzuKm+Cj12wQAP0SvJR/2fvbRjt
	 QMH/+N+R8YftXrnMGztKOVKLhaCsgctyY5OyFA8Y=
Date: Fri, 13 Dec 2024 09:47:16 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v11 0/8] Rust support for mm_struct, vm_area_struct, and
 mmap
Message-ID: <jc7vl3ltqage7v3desza5ftav6mrgagbczn6pbzv6c4fnyfgqa@xcsquxientfz>
References: <20241211-vma-v11-0-466640428fc3@google.com>
 <CAH5fLgiB_j=WbTqFs6o9-WaUOHC_-0+nPXT_PYD_1bZ75+2wBg@mail.gmail.com>
 <dvpyp2d4rrxdzdcyu3mh3wdsegi5qcmnp2hitfu4guft2igacg@xfvixz3tsiss>
 <CAH5fLggpBTZ7E4M5W7fN928z82_+zpD3kpvxinG9nfsu07Wkuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH5fLggpBTZ7E4M5W7fN928z82_+zpD3kpvxinG9nfsu07Wkuw@mail.gmail.com>

On Fri, Dec 13, 2024 at 03:42:48PM +0100, Alice Ryhl wrote:
> Could you print an error if the --- is missing, that is, if the number
> of sections is incorrect?

I don't think that's the right way to go, either, because the number of "---"
sections can vary (including having none at all). Throwing an error when that
happens would just annoy a different set of people.

I'll think of something.

-K

