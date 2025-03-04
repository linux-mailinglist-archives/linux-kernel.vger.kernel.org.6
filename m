Return-Path: <linux-kernel+bounces-543737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05C3A4D929
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24CCF7A7661
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6D91FDA83;
	Tue,  4 Mar 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdNN2Fnz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7861FC7DF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081680; cv=none; b=o2fCII+r4Pf1rwdhAd/vc0w9cV+bAkajRRRj13j0L0K6/x5EnDBCq0Ew7MPq4xHPnEmoe1AWuF6KWHnAix8vZQrPW/pCYcT5IXWJti7eboOb3S35K91vqUPjHvG3dVFmMOGKivKjx/morCXW/ZBYVI4Ib41v5z9eYeKLXvJBJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081680; c=relaxed/simple;
	bh=gImyvTcexP/lyuRhXSKmdWAlzArXGEKyRMwPNGsBXew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdMVNvWk4Qov6HGu2QzBpzrK/96PONjSeRAz5d6WcudrwKynwYSLrpcTR25Tk2Uq2bAOBFLZAxyBR/Eh1xTM4BW629UuH8nl5Lm4qEKRlerj4w+rlpBUjsu387R7/J54vLSDgTH69iECl6NqBW9VrhPq6qaXpnWsYXGY8nmd0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdNN2Fnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8E3C4CEE5;
	Tue,  4 Mar 2025 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081680;
	bh=gImyvTcexP/lyuRhXSKmdWAlzArXGEKyRMwPNGsBXew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdNN2FnzsvyeIABCCxwJeiBdVllrUGb7laCdugyYt5y7xuk+2jR42xwl3XS9Ez2Dj
	 oaYhrn4fw/4YJX56p+vnLw7+0JagxVO9ygOsxRIy/DhxRoQWS+8cQtWcxMd0PWXiuG
	 pjObbp6d2QKesd5Lqk+f5V00sJkel6n7RQYBTi4LtMxzpYVPBXlRMo9yuIt9RcXFTI
	 GfWhFMa5JOEQy1yLlBT3LXr1adAW698CfV3bRd4g1qnIkJSNzHn8jfC4wGVZ8niZB5
	 jtxZ8EPGeCz+x0Vu/Kd4rEg9bH67OGkH02onAEWuOi2uNFGiak1ubgBbOFTCb6cJyl
	 oKFJDhIWAH05Q==
Date: Tue, 4 Mar 2025 10:47:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 00/11] Add a percpu subsection for cache hot data
Message-ID: <Z8bMSr8JrDZtqwK8@gmail.com>
References: <20250303165246.2175811-1-brgerst@gmail.com>
 <Z8YTYWs-DeDHal1Q@gmail.com>
 <CAMzpN2iB4Gv0Fq1pNtk7bpa2z6eYwQGYXT0=p=_wWDBE9Uxa7w@mail.gmail.com>
 <Z8a-NVJs-pm5W-mG@gmail.com>
 <CAMzpN2gpHRtOtRuCJF_TKOFbEJ2xkksndCH+MfntfDuZHC0O1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzpN2gpHRtOtRuCJF_TKOFbEJ2xkksndCH+MfntfDuZHC0O1w@mail.gmail.com>


* Brian Gerst <brgerst@gmail.com> wrote:

> On Tue, Mar 4, 2025 at 3:47 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Brian Gerst <brgerst@gmail.com> wrote:
> >
> > > >
> > > > -       PERCPU_SECTION(INTERNODE_CACHE_BYTES)
> > > > +       PERCPU_SECTION(L1_CACHE_BYTES)
> > > >         ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <= 64, "percpu cache hot section too large")
> > > >
> > > >         RUNTIME_CONST_VARIABLES
> > > >
> > >
> > > That is probably the right call.  The initial percpu section is just
> > > used by the boot cpu early and as a template for the dynamically
> > > allocated percpu memory, which should account for the proper
> > > alignment for NUMA.
> >
> > Okay.
> >
> > Randconfig testing found another corner case with the attached config:
> >
> >     KSYMS   .tmp_vmlinux0.kallsyms.S
> >     AS      .tmp_vmlinux0.kallsyms.o
> >     LD      .tmp_vmlinux1
> >   ld: percpu cache hot section too large
> >   make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> >
> > (I haven't figured out the root cause yet.)
> 
> CONFIG_MPENTIUM4 sets X86_L1_CACHE_SHIFT to 7 (128 bytes).

Hm, to resolve this I'd go for the easy out of explicitly using '64' as 
the size limit - like we did it in the C space.

Thanks,

	Ingo

