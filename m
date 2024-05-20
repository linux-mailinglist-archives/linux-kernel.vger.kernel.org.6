Return-Path: <linux-kernel+bounces-183440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21508C9918
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4BB2818AC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1698611CBD;
	Mon, 20 May 2024 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="SwmpOU74"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CFED52F;
	Mon, 20 May 2024 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716188702; cv=none; b=tnV5ptjznFvmAIfarIGchZ6xZyX9yM7cs/IFc2OJ7qoPz1wyJkFXvTVs6H+qLW1Xw+Zv9ympt6ASD41XUW+AMyLcgg8ZzGX3syAL0H0jvAIZwDzdXRrD3YZpHtpa+O0VyGtTRhHw0wNzWpzenoclApC7z/7ulsVUvLKL0ftbNps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716188702; c=relaxed/simple;
	bh=WnbEgJrVg99AYuzyNCOFVK0qQHlGCNYi0cLOxUS1aeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XPdc9Yi1G1OdazjwIB1edG8KWH9QhJV8cDYYExF+Uovg2A/SQybvRBqqy/I83XABWB2rOmKFCvFXBJvQn15UePysM7MEzzYc1UtsBXGPkKnXiHca1DpwYU3QCJCY9+Sbqkwf3NlpidbzCR9Nk9Q934+QUDMzNZCyLFL8/3FNxiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=SwmpOU74; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716188696;
	bh=RoV6VIkaAluYtFGJCDi1Z/NPqWiUqa7zI7Xfg4Z2ElY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SwmpOU74v7iueWM0M4jzR0SSrYnUqrg9pTXGUHWbEImhkFE6CCjSQALlemjffjzUS
	 rTJPNL2bYsaI51L9wkKVUxPWjtiSWFiG3hMGQ09uGLLHmuiTEiabqsFD7nvqZPSP6q
	 G6i1Mhg5loGDMEuhFFBVNyeuTbYfGhwS3flwn5rid/8jDwxd5JCseOmRVA4AZZ+/lJ
	 Vu5Zva3Ykzoehr15evLo86ICfPENU3pt3Wbqv5Uo2pqJI0ldiP2xOGX4v70fpOjqio
	 c3w4Gk4Lf1fywLRB8Uwa/5KnKXxjiUB2+qkPgs6ypF6MwBs3KHgCVwKkjkpAhVufiA
	 LeWPLdIuH7G/g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VjT8l5qWsz4wc3;
	Mon, 20 May 2024 17:04:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: cve@kernel.org, linux-kernel@vger.kernel.org,
 linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, Geoff Levand <geoff@infradead.org>
Subject: Re: CVE-2023-52665: powerpc/ps3_defconfig: Disable
 PPC64_BIG_ENDIAN_ELF_ABI_V2
In-Reply-To: <2024051725-CVE-2023-52665-1d6f@gregkh>
References: <2024051725-CVE-2023-52665-1d6f@gregkh>
Date: Mon, 20 May 2024 17:04:55 +1000
Message-ID: <87zfslufoo.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> Description
> ===========
>
> In the Linux kernel, the following vulnerability has been resolved:
>
> powerpc/ps3_defconfig: Disable PPC64_BIG_ENDIAN_ELF_ABI_V2
>
> Commit 8c5fa3b5c4df ("powerpc/64: Make ELFv2 the default for big-endian
> builds"), merged in Linux-6.5-rc1 changes the calling ABI in a way
> that is incompatible with the current code for the PS3's LV1 hypervisor
> calls.
>
> This change just adds the line '# CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2 is not set'
> to the ps3_defconfig file so that the PPC64_ELF_ABI_V1 is used.
>
> Fixes run time errors like these:
>
>   BUG: Kernel NULL pointer dereference at 0x00000000
>   Faulting instruction address: 0xc000000000047cf0
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   Call Trace:
>   [c0000000023039e0] [c00000000100ebfc] ps3_create_spu+0xc4/0x2b0 (unreliable)
>   [c000000002303ab0] [c00000000100d4c4] create_spu+0xcc/0x3c4
>   [c000000002303b40] [c00000000100eae4] ps3_enumerate_spus+0xa4/0xf8
>
> The Linux kernel CVE team has assigned CVE-2023-52665 to this issue.

IMHO this doesn't warrant a CVE. The crash mentioned above happens at
boot, so the system is not vulnerable it's just broken :)

cheers

