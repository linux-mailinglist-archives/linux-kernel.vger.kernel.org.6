Return-Path: <linux-kernel+bounces-333073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A5497C319
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAEC9B21C22
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706AF12E48;
	Thu, 19 Sep 2024 03:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="VZET/QVX"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B222F28
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726716152; cv=none; b=Q2ry5LctFmot7+a38XMtsrVCqwxZ1dXy5LUxZpNP+jueT6p4K8iWx5LMwxctABFfImmXCYT39jj3+cNF6gOIP3hYJebxD6J2oQHJDF/l/E1FHVUXEvd5JEH4O+/Pd7IrH8/aJNm1JvqSl9PK6stHQhkGz7wKBkMhRU/A3rsb4Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726716152; c=relaxed/simple;
	bh=8goWkivBvW+25XRF0FzoeA/yNueTOWPYuKwnejj18/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IA90bIxez0vfOuU2oTwdFWrdajWSQA1H+7Dw1cFQjdpwWK+cDO48EVMYeJBnTQggd5txNoTF6GFXVw3BCnb6FdveugsXWXVGsFg5Bp8gkGFKTq0Z9nvPQ6W7I0sl7qqz8HlH9fT3kGloGdStOHAyS2OoeicClaYVHOFT8RVESj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=VZET/QVX; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726716145;
	bh=c8VbFbjPDCjQdNyPpd7p1p2RZzRMh7jmSHZ4g7e58ow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VZET/QVX0x8oS3aYNgKSxqmq8PZ7vtmyTG7ucf9sMvtCLJkEghkAhkhPGvtZG+VZN
	 O+PX8AdCfwZqWUT+fPnFkoa+dRa6d4x1UKR9y6SZqDgt/Y6YQlr01LjZP1LbLjBfLX
	 BKd5VD0MMFNUOfWWLcaoDGosfDuEV4snljAr/fUNy8MimHbynSF2BYYf9bpkHy+6vN
	 5JqftDQEtxcgowRDreE8KHUKYfB5t/jHBFFOBfGcQ6wDNsngft20ZfKPsCbEPJD3UM
	 NfbCIRBZ7EkyU1o4fWY97O7AhpNA5BvJKBL8cv8iSpD+3WMz8MN+aSrbXOo7y8YoiF
	 CF/PegYVWUE0Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X8LRj5mQxz4xWZ;
	Thu, 19 Sep 2024 13:22:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Luming Yu <luming.yu@shingroup.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, jialong.yang@shingroup.cn,
 luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: Re: [RFC PATCH] powerpc/tlb: enable arch want batched unmap tlb flush
In-Reply-To: <9BC3D1299ECE8428+20240918092515.2121-2-luming.yu@shingroup.cn>
References: <9BC3D1299ECE8428+20240918092515.2121-2-luming.yu@shingroup.cn>
Date: Thu, 19 Sep 2024 13:22:21 +1000
Message-ID: <87wmj8pbte.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Luming Yu <luming.yu@shingroup.cn> writes:
> From: Yu Luming <luming.yu@gmail.com>
>
> ppc always do its own tracking for batch tlb.

I don't think it does? :)

I think you're referring to the batch handling in 
arch/powerpc/include/asm/book3s/64/tlbflush-hash.h ?

But that's only used for 64-bit Book3S with the HPT MMU.

> By trivially enabling
> the ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH in ppc, ppc arch can re-use
> common code in rmap and reduce overhead and do optimization it could not
> have without a tlb flushing context at low architecture level.
>
> Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
> ---
>  arch/powerpc/Kconfig                |  1 +
>  arch/powerpc/include/asm/tlbbatch.h | 30 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/tlbbatch.h

This doesn't build:

  https://github.com/linuxppc/linux-snowpatch/actions/runs/10919442655

Can you please follow the instructions here:

  https://github.com/linuxppc/wiki/wiki/Testing-with-GitHub-Actions

Which describe how to fork our CI tree that has Github Actions
preconfigured, then you can apply your patches on top and push to github
and it will do some test builds for you. Notably it will do 32-bit
builds which is what broke here.

cheers

