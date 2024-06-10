Return-Path: <linux-kernel+bounces-208719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774B5902871
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD33DB21B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35E014D6E4;
	Mon, 10 Jun 2024 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uCf5d+Qt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447D814B978
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043101; cv=none; b=mHzD1GvBUUStjBsV7rQNAxaGYVlMiLDVws8/I+89KQiUMOaYAY78OkT78aOZ3tsV1NHNhMOYKQlRXa5FA4xR5l9fKmLGvEW0XbSUoCHHlKjU1rRdvltYT2Ku2Z/t44CnKd/mcWv/FbHHCtchIeIGr0IXL/IAFi1Eg1g1dBVKHNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043101; c=relaxed/simple;
	bh=Zyt0Q07VE/fjAXBZsWUk0sLyvaGo1lHLtKHoWXrBxrE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oAU0+CYIxBQQZPZeWWA3mB29qRUorNXRtNcZ6RDug/rML0zbEwiVquRIZwkRayW7VcDAEjh9rdAcMBSIt8RvCP8o4TdOKz1+r9xkjgKUn5ohFuaknXxiGQDU8fMd88bzhEkplOIvj9F6bY1jQN7bVeIC0XX1S08oUA2MmFQoo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uCf5d+Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE2CC2BBFC;
	Mon, 10 Jun 2024 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718043100;
	bh=Zyt0Q07VE/fjAXBZsWUk0sLyvaGo1lHLtKHoWXrBxrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uCf5d+QtExZpXuCpWZUvOrXZvwBkkat207Tiwy2JRip+dPloyEhnTbJe6JWJELXX3
	 YqdbM0HeJLKjjNJcPtjrg1x87nWu0+5UqczOTTR1UnC9E19XnYGG4K+ZDOrqftXpyO
	 mO1WkE1UlMwskW68N+85JxIMS1/f1wwblEigZZBU=
Date: Mon, 10 Jun 2024 11:11:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Rafael Aquini <aquini@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Heiko
 Carstens <hca@linux.ibm.com>, Petr Mladek <pmladek@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Paul McKenney <paulmck@kernel.org>, Samuel Holland
 <samuel.holland@sifive.com>
Subject: Re: [PATCH v2] mm: mmap: allow for the maximum number of bits for
 randomizing mmap_base by default
Message-Id: <20240610111139.1e392360ffe847ea48ffebab@linux-foundation.org>
In-Reply-To: <20240606180622.102099-1-aquini@redhat.com>
References: <20240606170026.101839-1-aquini@redhat.com>
	<20240606180622.102099-1-aquini@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jun 2024 14:06:22 -0400 Rafael Aquini <aquini@redhat.com> wrote:

> An ASLR regression was noticed [1] and tracked down to file-mapped areas
> being backed by THP in recent kernels. The 21-bit alignment constraint
> for such mappings reduces the entropy for randomizing the placement of
> 64-bit library mappings and breaks ASLR completely for 32-bit libraries.
> 
> The reported issue is easily addressed by increasing vm.mmap_rnd_bits
> and vm.mmap_rnd_compat_bits. This patch just provides a simple way to
> set ARCH_MMAP_RND_BITS and ARCH_MMAP_RND_COMPAT_BITS to their maximum
> values allowed by the architecture at build time.
> 
> [1] https://zolutal.github.io/aslrnt/

Are we able to identify a Fixes: target for this?

I assume a cc:stable is appropriate?



