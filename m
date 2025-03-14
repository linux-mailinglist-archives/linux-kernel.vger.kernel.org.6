Return-Path: <linux-kernel+bounces-561480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85578A6127D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B7E1B63025
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF881FF614;
	Fri, 14 Mar 2025 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="divOTzGa"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6552D51C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958606; cv=none; b=MMh+VgorUClDkz6Qlk29CM7aUTb0FVWbO0qDQH5SwDYdeNx5a64P4dglFSYcywdNiKLUPMOCctuo3SYPi5adEFaX681ImzrTOiycY3I4iB/duLYdD5tpj1zbZWcRFkBztfTwPTM9nZZocL7L+eFeU0Jj0sVy1htpuSA74k+DuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958606; c=relaxed/simple;
	bh=zIMf8hEasItX0KL+emYCw1f/rwjDy39YKJwVFryXaGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiIiedeszNvG0Ijtt+cM82yx3RxF/nQGckL4kXvdD8OLGX8MpnE2S+NdVp5zw7KiGIQL+x1yQ+d0154ZwNwY8ljdOnhAtG0yBK+leP5FIF+caysDvhXiLmBFWtyjkIpe8hI0cGrBTMbOtJxkY/LujTU7PT0V6HsBdoNsm7D7bfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=divOTzGa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7C38740E023D;
	Fri, 14 Mar 2025 13:23:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5rnWq24mPXLg; Fri, 14 Mar 2025 13:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741958597; bh=YPXFYtsnxKno/jhWzXm5NHZxiFRGdIHQ2//rr2SaDok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=divOTzGaoU5vz3SnF2U849sNUe7dLkIxmrQUixmxS0uPZEtCMfOytQNJzEEk76Hz/
	 4AxYT/Zz8cCI6q472k+R8OTBGfMMEMTvJET+BPdSpsh4AEZO4ve4THRQEZC/sMK9no
	 0uX1CfXaAdFo2v3NaM9gKthCWF0pb69sT1BoESKAYWiB0fp9pWnbmnWuAlURHdpRB5
	 TQdC0xvoz5DklqKZdDw/Hhawxf1yC6VHxmGAsM3h8ub5grTuPUyGAKUjlADdzemz5J
	 EEEAJJAtvpYN5hW00EnqJd+AIE7ReOewd7mmXCOdXuaUx0eRezmRt/FyLHwKb+82Dv
	 Jq8FFWCfHrQIai6y0y9RKjsiEoId0P+PdIx6V1Zem3sHw/UX3WjxlkHsrPx3c8wLih
	 K0krBsWPKAPcI4//eVDA8fHfAjr19GA6tf4Ls0cnjxkxUT2dyPx6JneZnq/gHLbuBA
	 l+k3vYZyTNCTJgcuT8a4P6GCHbrcvHMjbhFWNNTAEn3w82zDWKNabVWHVutJnMdZPN
	 GXpq26XuPt8IaXRoAQOSvPsVwkO0IcJgpyyKBqytXQ6d1HkDsyy3RngPmSmILiOD46
	 SXWtiV6pQ5ZQ3AWZrMnHjnojc18r+hyNbrLPaUH9a+wG3SE7AzI/ivciJp9WWmsr0n
	 FvmbmQQLMAZbxUI+8OdVe8KE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9AFFB40E015E;
	Fri, 14 Mar 2025 13:23:07 +0000 (UTC)
Date: Fri, 14 Mar 2025 14:23:06 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/asm: Use asm_inline() instead of asm() in
 amd_clear_divider()
Message-ID: <20250314132306.GDZ9QtukcVVtDmW1V1@fat_crate.local>
References: <20250313191828.83855-1-ubizjak@gmail.com>
 <96E2026E-CEF1-4A4C-B107-7FCE2CD9121F@alien8.de>
 <CAFULd4ZTkBwFo3nWXNZKXSKiy4dgPoZ8i95nj3UdtQPApKdj3g@mail.gmail.com>
 <B7AB40CF-165D-448C-963C-787D74BB9042@alien8.de>
 <Z9QB0nP6Mb3ri3mj@gmail.com>
 <Z9QCRydO2yiCq_YR@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9QCRydO2yiCq_YR@gmail.com>

On Fri, Mar 14, 2025 at 11:17:43AM +0100, Ingo Molnar wrote:
> Here's a link for those who'd like to view this via the web:
> 
>   https://lore.kernel.org/all/174188884263.14745.1542926632284353047.tip-bot2@tip-bot2/

This is a perf measuring method I got from you, actually, from a long time
ago:

:-)

./tools/perf/perf stat -a --repeat 5 --sync --pre ~/bin/pre-build-kernel.sh -- make -s -j33 bzImage

* tip/master fdebf9c0efe4 ("Merge branch into tip/master: 'x86/sev'")

 Performance counter stats for 'system wide' (5 runs):

      4,144,101.54 msec cpu-clock                        #   32.000 CPUs utilized               ( +-  0.10% )
           812,478      context-switches                 #  196.056 /sec                        ( +-  0.15% )
            67,201      cpu-migrations                   #   16.216 /sec                        ( +-  0.22% )
        48,228,560      page-faults                      #   11.638 K/sec                       ( +-  0.01% )
 9,473,229,339,058      instructions                     #    1.12  insn per cycle            
                                                  #    0.21  stalled cycles per insn     ( +-  0.00% )
 8,476,070,185,458      cycles                           #    2.045 GHz                         ( +-  0.12% )
 1,988,775,653,131      stalled-cycles-frontend          #   23.46% frontend cycles idle        ( +-  0.14% )
 2,128,585,400,027      branches                         #  513.642 M/sec                       ( +-  0.00% )
    66,681,861,375      branch-misses                    #    3.13% of all branches             ( +-  0.03% )

           129.504 +- 0.127 seconds time elapsed  ( +-  0.10% )

* tip/master with 9628d19e91f1 reverted

 Performance counter stats for 'system wide' (5 runs):

      4,141,057.45 msec cpu-clock                        #   32.000 CPUs utilized               ( +-  0.15% )
           811,299      context-switches                 #  195.916 /sec                        ( +-  0.08% )
            67,644      cpu-migrations                   #   16.335 /sec                        ( +-  0.24% )
        48,209,829      page-faults                      #   11.642 K/sec                       ( +-  0.00% )
 9,465,299,000,193      instructions                     #    1.12  insn per cycle            
                                                  #    0.21  stalled cycles per insn     ( +-  0.00% )
 8,487,239,564,102      cycles                           #    2.050 GHz                         ( +-  0.21% )
 1,992,414,836,889      stalled-cycles-frontend          #   23.48% frontend cycles idle        ( +-  0.08% )
 2,127,019,426,911      branches                         #  513.642 M/sec                       ( +-  0.00% )
    66,698,031,504      branch-misses                    #    3.14% of all branches             ( +-  0.02% )

           129.408 +- 0.195 seconds time elapsed  ( +-  0.15% )

This is all within the noise.

Or maybe building the kernel even with those "optimized" inlining decisions
due the asm being of length 1 for atomic locking insns simply doesn't matter.

Or maybe I need a different benchmark.

At least it ain't breaking anything...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

