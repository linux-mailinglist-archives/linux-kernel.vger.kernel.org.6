Return-Path: <linux-kernel+bounces-547687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6235FA50C66
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9689818900A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3674C254AEC;
	Wed,  5 Mar 2025 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isTBI7fP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C642459FC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206109; cv=none; b=hq2WF39N3QuHjbQPY3sgWTYKqyZul/9uElS00q0RrgH3rdz4pgVMeHd1VBh9zkVJH696ga2ZjIt2PJNwoGIo1pEUh1XOJduzq6C2LXXBCPU5Ihc/fOYlPZ68nxr8ky7gNzb0GFPS9NXoKrhZf31mCSkb6yZuq37WTndnwi9QSl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206109; c=relaxed/simple;
	bh=jDRaXhm8nRiJdSpZJOYr6fGiVSUI6l78XMhaxSUVATo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSjNQVwG6dlnpAcvJCPTJ3wq8l15IXkf86ve0OFHF5INHbgP/r6WgUhhZ4vNfiduKrJKRJsXQp+ELDotgyJ50XDc/G8ZEaWyROSMjw/bN7B+Wc+pXbDDi06se/mPb89NVYMM+SibuL5Z9uneMH6kE2DOxHYtamjs3pYDJeHwSqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isTBI7fP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD2BC4CED1;
	Wed,  5 Mar 2025 20:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741206109;
	bh=jDRaXhm8nRiJdSpZJOYr6fGiVSUI6l78XMhaxSUVATo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isTBI7fPMbmhNHUhDth6H9sZSR/8rcHH7bouSMuoViDOB9xSLKEFv+gK3n2oe2Vy/
	 pxeKXDXLz4pz/wwZmhZfi4mSeRy1crj9YgdDBGYZMPNs1laH9MHEXCKcuMkMNbIzqy
	 dmYE3x+R5DR3Ap0wLGIfiOLlfgSULlrKwQgjar0ODhte/+gt47MKZd63YjG1dv48s/
	 HYuowzUfL1FhFam8jyoNqoCjcFpYd8TbAEQiUnNph69yuNP8wZXhGoFsIBXXrBzH6v
	 DJtJG9v/AICrfVa8ol4x/BfpkZ9ba4nYMrGoxWE0y3y+IRirWaCi3x563dkpknWcuD
	 WmUmfJBcxDi7Q==
Date: Wed, 5 Mar 2025 21:21:44 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <Z8iyWHyYt6bfo_mO@gmail.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
 <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
 <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
 <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <Z8isNxBxC9pcG4KL@gmail.com>
 <CAFULd4bDSh7fzm8xmMzn0YzF0pr=mLvzb9dVYhCajyXx=XBrtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4bDSh7fzm8xmMzn0YzF0pr=mLvzb9dVYhCajyXx=XBrtA@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> I simply run the lmbench command, where the benchmark was obtained as 
> .rpm for Fedora 41 [1], assuming that the benchmark itself sets the 
> benchmarked system to the correct state and does enough repetitions 
> to obtain a meaningful result [2].

These assumptions are not valid in a lot of cases - see my other email 
with an example.

Thanks,

	Ingo

