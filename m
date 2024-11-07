Return-Path: <linux-kernel+bounces-399537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 198039C0050
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A375CB23312
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98191D9A5F;
	Thu,  7 Nov 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ji9j7QV+"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC6C1D9A41
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969109; cv=none; b=oxBwKNF7d5WIGm2HCFvjAsdYJben3irVUZ3G262ub1BjgzVaUklIIata7GsG4XCImgvHdYIL49hWxTYXBgcc7Eke2gxcqMQVd2wuscS3PvK7Ka1UEoAJFrwxb58OlQ3T9EQKswqYAZAbUw9ddEGEkU3i7FNBvZcbJT0O6AdyB6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969109; c=relaxed/simple;
	bh=9uA4jtAqewGWM09+wgzmWVi5vAHoTeP/t3cHJ6njvGY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=msYRHmHhenJBqV9pAXAkFew91SWgRumIluIzSoWFGDcBaw4PUfMn8lvmkso0a++64soJgmspmraDaYaNea9X1hTiyDcK5WvvkO4tqmh0POnx939Vn/nXplWOXFXZDuh9ZxAfoIwHHxtxjY8+0Efcl+MDv45jPRPJkndqgXxsxWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ji9j7QV+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730969102;
	bh=S8Ka+i9mImv1flw2WDBI2y32Prf/adbg6BktMA4093U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ji9j7QV+46G8MEsSAj3VjkjAOWZd6UM4NdmTUhMRHOna1YH1tMUyt1u9fJoPiYq9O
	 dO5qHdv8wTripRntiFjndmiC9FAwyD9vsJLUJJpWJjX/G9x197HTFt3hZ7FgxT3DaP
	 Dd4sUJITu//HOBTvqCOEdrJG5JUWxMpoIh9QTMZ3Xo7UuqAWHV4zxrcxy39dzpAJK6
	 XKOe/RCn1M+VHrUrZiFFfwhukTpHfCmBkKYby/t7evZIzghhMYkK7jeNZZnoAtlmVH
	 icwSe6J2odIsf9phYPWsnCMlbU1Hg625hetGqNTBEbtTxUQ9/qlK3y1fHjpTSCIjFa
	 F7Aa5isHQKf9Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XkbHL4PvJz4xG4;
	Thu,  7 Nov 2024 19:45:02 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>, Heiko Carstens <hca@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Hari Bathini <hbathini@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Donet Tom <donettom@linux.ibm.com>, Pavithra Prakash <pavrampu@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <cover.1729271995.git.ritesh.list@gmail.com>
References: <cover.1729271995.git.ritesh.list@gmail.com>
Subject: Re: [PATCH v3 00/12] powerpc/kfence: Improve kfence support (mainly Hash)
Message-Id: <173096894640.18315.14301465980059494153.b4-ty@ellerman.id.au>
Date: Thu, 07 Nov 2024 19:42:26 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 22:59:41 +0530, Ritesh Harjani (IBM) wrote:
> v2 -> v3:
> ============
> 1. Addressed review comments from Christophe in patch-1: To check for
>    is_kfence_address before doing search in exception tables.
>    (Thanks for the review!)
> 
> 2. Separate out patch-1, which will need a separate tree for inclusion and
>    review from kfence/kasan folks since it's a kfence kunit test.
> 
> [...]

Applied to powerpc/next.

[01/12] powerpc: mm/fault: Fix kfence page fault reporting
        https://git.kernel.org/powerpc/c/06dbbb4d5f7126b6307ab807cbf04ecfc459b933
[02/12] book3s64/hash: Remove kfence support temporarily
        https://git.kernel.org/powerpc/c/47780e7eae783674b557cc16cf6852c0ce9dbbe9
[03/12] book3s64/hash: Refactor kernel linear map related calls
        https://git.kernel.org/powerpc/c/8b1085523fd22bf29a097d53c669a7dcf017d5ea
[04/12] book3s64/hash: Add hash_debug_pagealloc_add_slot() function
        https://git.kernel.org/powerpc/c/cc5734481b3c24ddee1551f9732d743453bca010
[05/12] book3s64/hash: Add hash_debug_pagealloc_alloc_slots() function
        https://git.kernel.org/powerpc/c/ff8631cdc23ad42f662a8510c57aeb0555ac3d5f
[06/12] book3s64/hash: Refactor hash__kernel_map_pages() function
        https://git.kernel.org/powerpc/c/43919f4154bebbef0a0d3004f1b022643d21082c
[07/12] book3s64/hash: Make kernel_map_linear_page() generic
        https://git.kernel.org/powerpc/c/685d942d00d8b0edf8431869028e23eac6cc4bab
[08/12] book3s64/hash: Disable debug_pagealloc if it requires more memory
        https://git.kernel.org/powerpc/c/47dd2e63d42a7a1b0a9c374d3a236f58b97c19e6
[09/12] book3s64/hash: Add kfence functionality
        https://git.kernel.org/powerpc/c/8fec58f503b296af87ffca3898965e3054f2b616
[10/12] book3s64/radix: Refactoring common kfence related functions
        https://git.kernel.org/powerpc/c/b5fbf7e2c6a403344e83139a14322f0c42911f2d
[11/12] book3s64/hash: Disable kfence if not early init
        https://git.kernel.org/powerpc/c/76b7d6463fc504ac266472f5948b83902dfca4c6
[12/12] book3s64/hash: Early detect debug_pagealloc size requirement
        https://git.kernel.org/powerpc/c/8846d9683884fa9ef5bb160011a748701216e186

cheers

