Return-Path: <linux-kernel+bounces-543753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D34AA4D961
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A3D77A1F91
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264051FCFDF;
	Tue,  4 Mar 2025 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRaCxbUH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827531F37CE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082151; cv=none; b=dU13/WDbfEoVB4cRxQt0XvkVVCOOGJxHLnY/WYDkSsjKi5CSnJpCroRVGVTX6kgeAL0kWFLnbN7Q44SzlLAAvzRseakITpHlyezxpNiYcQD2xTG2klsvFs7BEV6o1CrDKHHFDXm0J1ITijWcJFTV6Dd6MfKfw4QT+C0jOqBEmYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082151; c=relaxed/simple;
	bh=Vg0JIHG39DDeLKayInuouwopWCmilHvmKYPuJMTkmSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUzz7ztleYiR1DjiS0ZO5We/BVg+oBn0OaNsyH89NX7y3ulKAjSFWIWXNqWNS0vdbanb3e2CfF2BZ/TBMUUcuNqskfBpa2zjx1Q8j0tvYwS013eBj1CHtcmI1hCzkYYPCHR3Dy4Nv81l1lklI3TJ7jlHDkxlKLMlnBBbVt2IMIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRaCxbUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359F5C4CEE5;
	Tue,  4 Mar 2025 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741082151;
	bh=Vg0JIHG39DDeLKayInuouwopWCmilHvmKYPuJMTkmSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TRaCxbUHvz/dBwnYK2JGN4xmuLxPLFUpREo+EeC5RF8PCXfwIomceblSiUaXLcWXX
	 RPXo1UiMPW/+BhZKF7RrWJOTw6iilcTCv+Ko7SvmAp9Ati8cBAxlX5c/LBwq7Uq/3M
	 uNQ0TCC9gYQV09wvTF/Zt1OxOduCF2kMrO4WGoh/WNj3qU17mt38e2QlAOslibAgSO
	 wHX94F2RrNjKIHkCHJeJU5Q2ryFHSFGvvwmqgS1ldVuwdzYCV09dEehb2XLkE90l/M
	 Di9WAG2ddmzeSfHOVR07uybmiaEeBMPuDpCNON4qzrLZaqSv0RuLWP+hsSXrm75CP1
	 vf8aOb88WnlHQ==
Date: Tue, 4 Mar 2025 10:55:45 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 00/11] Add a percpu subsection for cache hot data
Message-ID: <Z8bOIXeWYycUEmp4@gmail.com>
References: <20250303165246.2175811-1-brgerst@gmail.com>
 <Z8YTYWs-DeDHal1Q@gmail.com>
 <CAMzpN2iB4Gv0Fq1pNtk7bpa2z6eYwQGYXT0=p=_wWDBE9Uxa7w@mail.gmail.com>
 <Z8a-NVJs-pm5W-mG@gmail.com>
 <CAMzpN2gpHRtOtRuCJF_TKOFbEJ2xkksndCH+MfntfDuZHC0O1w@mail.gmail.com>
 <Z8bMSr8JrDZtqwK8@gmail.com>
 <CAFULd4YFm-2Sc6NOzyWt4-TPDkwY-=5h-Gb99M+tFf-Mczk0Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4YFm-2Sc6NOzyWt4-TPDkwY-=5h-Gb99M+tFf-Mczk0Ng@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Tue, Mar 4, 2025 at 10:48 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Brian Gerst <brgerst@gmail.com> wrote:
> >
> > > On Tue, Mar 4, 2025 at 3:47 AM Ingo Molnar <mingo@kernel.org> wrote:
> > > >
> > > >
> > > > * Brian Gerst <brgerst@gmail.com> wrote:
> > > >
> > > > > >
> > > > > > -       PERCPU_SECTION(INTERNODE_CACHE_BYTES)
> > > > > > +       PERCPU_SECTION(L1_CACHE_BYTES)
> > > > > >         ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <= 64, "percpu cache hot section too large")
> > > > > >
> > > > > >         RUNTIME_CONST_VARIABLES
> > > > > >
> > > > >
> > > > > That is probably the right call.  The initial percpu section is just
> > > > > used by the boot cpu early and as a template for the dynamically
> > > > > allocated percpu memory, which should account for the proper
> > > > > alignment for NUMA.
> > > >
> > > > Okay.
> > > >
> > > > Randconfig testing found another corner case with the attached config:
> > > >
> > > >     KSYMS   .tmp_vmlinux0.kallsyms.S
> > > >     AS      .tmp_vmlinux0.kallsyms.o
> > > >     LD      .tmp_vmlinux1
> > > >   ld: percpu cache hot section too large
> > > >   make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> > > >
> > > > (I haven't figured out the root cause yet.)
> > >
> > > CONFIG_MPENTIUM4 sets X86_L1_CACHE_SHIFT to 7 (128 bytes).
> >
> > Hm, to resolve this I'd go for the easy out of explicitly using '64' as
> > the size limit - like we did it in the C space.
> 
> Why not simply:
> 
> ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <= L1_CACHE_BYTES, "...")
> 
> ?

I don't think it's a great idea to randomly allow a larger section 
depending on the .config ... The *actual* intended limit is 64, not 128 
and not 4096, so I'd suggest we write it out as before.

Thanks,

	Ingo

