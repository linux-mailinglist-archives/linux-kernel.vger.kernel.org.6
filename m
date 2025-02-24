Return-Path: <linux-kernel+bounces-529644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCE3A428F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 192877A5D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3D92638BE;
	Mon, 24 Feb 2025 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyXMT7+O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537E1146A6F;
	Mon, 24 Feb 2025 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416967; cv=none; b=j7AbAgWf36oqCFRLNYb00s7l1hZSq5xk68iGXI4LDgk/DDs44jvbY9etLYmshzNBfSa0jR43P3r38gttut5M3j5hRyNP4wBsxZIAxYlBGCygGCMj62aQuUjG3MWqrRdU1coHW1rRptz/nbMl8V9Hxu4qNsbN4yRYJN48ynevEWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416967; c=relaxed/simple;
	bh=PqlySbYyMKDngQANnkO11zBqIw/Fq8qCXFRHMY8ig+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRiy96HZ26RZREKVv+HWVZZNwY9RyMmD+jU6NixKLCiijQQ4a2TMRUXhikdLtoze88OQO5G6I6myh0sb88Hr+BbGdp8SAjhsGU4Us260rQCuCOynJ5lsFzHTPPjHhhneJ+blgJc4bA6uABATOlHG+92KbnJzQcD27cHKp/q5KsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyXMT7+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA959C4CED6;
	Mon, 24 Feb 2025 17:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740416966;
	bh=PqlySbYyMKDngQANnkO11zBqIw/Fq8qCXFRHMY8ig+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GyXMT7+OT6qMFl5b6FWqiPBbEYF8PAyw9i3xJ2wsDXbIuty60UPWvwIxLQpCElzci
	 E7vnNKA0sz7wd3fe5LUMJ8vLhc8z+T/CAbpI7V21AyIQVDi3qPgxzlAtw0VLG11y69
	 cgWLC7ZjymdwTn9//eVlNi6ecSWQ3dq9Nr6MFnEQvNRAOiGwH95LV1W5UqBalAvMaF
	 Y6hn+kOqSsA9wkKINnGZX18446mp2xMz8Ri/kzGk0I1SndQOrXIS1rt7OtwLHEUnwS
	 njj4ngcCD+ZzHOmc5D5bT7fuKkOpo7HJTb77G02N7dglqJ6CVJZfpSn1nJgwoT0RO8
	 X9w6mQVcxfi0w==
Date: Mon, 24 Feb 2025 09:09:22 -0800
From: Nathan Chancellor <nathan@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Sathvika Vasireddy <sv@linux.ibm.com>, jpoimboe@kernel.org,
	peterz@infradead.org, npiggin@gmail.com, maddy@linux.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev
Subject: Re: [RFC PATCH] objtool: Skip unannotated intra-function call
 warning for bl+mflr pattern
Message-ID: <20250224170922.GA585841@ax162>
References: <20250219162014.10334-1-sv@linux.ibm.com>
 <3223ec0e-c445-4bbf-ae72-276688e40908@csgroup.eu>
 <d5ada017-1ba2-4a89-8a58-4555f09f9d97@csgroup.eu>
 <8f4ec6d4-2646-4a87-b3a1-edfaecff2a01@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f4ec6d4-2646-4a87-b3a1-edfaecff2a01@csgroup.eu>

On Mon, Feb 24, 2025 at 02:19:14PM +0100, Christophe Leroy wrote:
> Well, this problem already exists on clang 18 it seems:
> 
> 00000004 <btext_map>:
>    4:   7c 08 02 a6     mflr    r0
>    8:   94 21 ff e0     stwu    r1,-32(r1)
>    c:   93 c1 00 18     stw     r30,24(r1)
>   10:   90 01 00 24     stw     r0,36(r1)
>   14:   93 a1 00 14     stw     r29,20(r1)
>   18:   48 00 00 05     bl      1c <btext_map+0x18>
>   1c:   38 a0 00 00     li      r5,0
>   20:   7f c8 02 a6     mflr    r30
> 
> While GCC generates:
> 
> 00000418 <btext_map>:
>  418:   94 21 ff e0     stwu    r1,-32(r1)
>  41c:   7c 08 02 a6     mflr    r0
>  420:   42 9f 00 05     bcl     20,4*cr7+so,424 <btext_map+0xc>
>  424:   39 20 00 00     li      r9,0
>  428:   93 c1 00 18     stw     r30,24(r1)
>  42c:   7f c8 02 a6     mflr    r30
> 
> So lets make the kernel tolerate it allthough it should be fixed on clang at
> the end.
> 
> I can't find any related issue in the clang issues database
> (https://github.com/llvm/llvm-project/issues), should we open one ?

Yes please, especially if you happen to have a simplified reproducer
(but no worries if not). I can make sure it gets labeled for the PowerPC
backend folks to take a look at.

Cheers,
Nathan

