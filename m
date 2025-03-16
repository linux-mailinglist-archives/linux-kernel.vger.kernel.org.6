Return-Path: <linux-kernel+bounces-562792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD19A632FD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 01:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EA217126F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 00:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB8A8F64;
	Sun, 16 Mar 2025 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi02j6KG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A53FF1
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 00:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742085449; cv=none; b=I1wmoEPLzYQAfJ8ylKCkR12GhhWJ5KM8BJ4Vd5Rl0vh0byHJc48rwKQkFMx1aGudG8HFUTYeihXgqhOTEEgx43eaPGUGO7XjqAP+slGqLdmZaSmG0G7BRIRNskB1PPMrlaAwKL+guglFZyALw9E2Km40rz1l9mKizWRAnryqiyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742085449; c=relaxed/simple;
	bh=MBmBgqbnngo8HUnLzq65XsTk7Hwo9spdEPgpQBpzi7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo14c0Fpp12f1onUMsUfhWt61SZI0CFCd1ViUkjYWpADsd+0eJGIJNlUfL1DCv/mZXVSkEa8QGsbEkCp5WQ9gOwdS4ZVqLdustPo/cUwubajniZgRq6qbMTLgx+jd2Mg99Yx3cenczXZo9QdGSVC63+WQe9rzzPyflSVchuhZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi02j6KG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198A1C4CEE5;
	Sun, 16 Mar 2025 00:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742085448;
	bh=MBmBgqbnngo8HUnLzq65XsTk7Hwo9spdEPgpQBpzi7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zi02j6KG8ZHl9FiRYwcqWdwYpB9xBhQ1kxG4GNgKtsQ/I2Y9ulj/0e4/kJ9aOjke/
	 U4RUmu2j0TpJv5R718fpUaEWnrZiorWrwpoPVKJy1g4WMdsGrXuDd9LcbduCq6cGuA
	 eKckCrtn+Vrfjbm5TrZotE71CAqppfrqGDVp+zxlX6ntUAu2DvE81ZGOtg3S13Dxtn
	 04sOK41xPB+GQqUr6dN+W72CiJhXbTN6joZk/YYyi/VvOFijydDtUg7aiXAj/R0/a6
	 Pk8+AD+kqxUpZpJBKhLgAvpvnAQRKBzC/qZpppyi8jvSCB14qpGfVRFySj+j9Y3gik
	 S9pPlJ8ajsQaA==
Date: Sun, 16 Mar 2025 01:37:23 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/asm: Use asm_inline() instead of asm() in
 amd_clear_divider()
Message-ID: <Z9YdQ9fe4NJ1ciyi@gmail.com>
References: <20250313191828.83855-1-ubizjak@gmail.com>
 <96E2026E-CEF1-4A4C-B107-7FCE2CD9121F@alien8.de>
 <CAFULd4ZTkBwFo3nWXNZKXSKiy4dgPoZ8i95nj3UdtQPApKdj3g@mail.gmail.com>
 <B7AB40CF-165D-448C-963C-787D74BB9042@alien8.de>
 <Z9QB0nP6Mb3ri3mj@gmail.com>
 <Z9QCRydO2yiCq_YR@gmail.com>
 <20250314132306.GDZ9QtukcVVtDmW1V1@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314132306.GDZ9QtukcVVtDmW1V1@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Mar 14, 2025 at 11:17:43AM +0100, Ingo Molnar wrote:
> > Here's a link for those who'd like to view this via the web:
> > 
> >   https://lore.kernel.org/all/174188884263.14745.1542926632284353047.tip-bot2@tip-bot2/
> 
> This is a perf measuring method I got from you, actually, from a long time
> ago:
> 
> :-)
> 
> ./tools/perf/perf stat -a --repeat 5 --sync --pre ~/bin/pre-build-kernel.sh -- make -s -j33 bzImage

Yeah, so that's a suboptimal test for these particular changes really: 
why would a simple CPU-saturated kernel build with low levels of kernel 
use of the affected areas show measurable changes with this commit?

> This is all within the noise.

Should we expect anything else from this test?

Also, see the other figures & analysis within the commit, in particular 
the reduction in the number of function calls, when we have high 
per-function mitigation overhead that is often the top entry in kernel 
profiles:

 Overhead  Shared Object               Symbol
   4.57%  [kernel]                    [k] retbleed_return_thunk
   4.40%  [kernel]                    [k] unmap_page_range
   4.31%  [kernel]                    [k] _copy_to_iter
   2.46%  [kernel]                    [k] memset_orig
   2.31%  libc.so.6                   [.] __cxa_finalize

Each eliminated function call from when GCC's inliner was formerly 
confused by Linux's asm() statements is a win.

I did a test too, with a pipe-scheduling workload of 'perf bench sched 
pipe' locked down to a single CPU, with CPU frequencies fixed and 
nested perf stat instances:

  kepler:~> taskset -c 2 perf stat --null --repeat 5 perf stat --null --repeat 5 perf bench sched pipe

  [ -vanilla ]           19.5514 +- 0.0235 seconds time elapsed  ( +-  0.12% )
  [ +Uros's commit: ]    19.3972 +- 0.0207 seconds time elapsed  ( +-  0.11% )

Notes:

  - Best of 3 runs

  - "+Uros's commit" is the aforementioned one from -tip that you measured too:

      9628d19e91f1 ("x86/locking/atomic: Improve performance by using asm_inline() for atomic locking instructions") applied: ]
      # https://lore.kernel.org/all/174188884263.14745.1542926632284353047.tip-bot2@tip-bot2/

  - The nested perf stat instances allowed further reduction in 
    measurement stddev, while keeping the internal steps easily
    observable, verifiable while the total runtime is still reasonable.

So on my system there appears to be a measurable improvement in 
performance on this particular benchmark on the order of magnitude of 
around ~0.8%, which is outside the measurement noise of around ~0.2%.

Thanks,

	Ingo

