Return-Path: <linux-kernel+bounces-368199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39A49A0C83
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312BF1C2098C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D65207A13;
	Wed, 16 Oct 2024 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X69X+0ij"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF421E3C1;
	Wed, 16 Oct 2024 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088538; cv=none; b=dZzPp3z3DWiQswZls45/oyeQlWUyLdECBxReI7XhqWSsIdP8xglqJf5nADxatGZBqF9yid++UcEYWHEMQC3AMVfZxoNb7TJUcYeKJ4psfK/lbzM1DzC9R1iL66XwnQgrdwyxuCSqBQOD0CRs4fqrCU1AbtyDV/sxakrAG4YNL3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088538; c=relaxed/simple;
	bh=gMskM2GDWGub7qyVinecyjz/vxqKyOtsZPjwLotEZR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctUZS7b358BUF1EwrY4nNlGwmHYeXz+6Q5+epVtTicowp08YDxMdvMBCUgntIET6vz8MVg6dBGEewj9kO+EWaB7UjcBBCPuhAXgq0i9HrlW5fjNcZTf+Cfvr1MjjCwRCa1BklfF8NRmI9eBsR+QBcxyc5/1OcQR3shvqalgvBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X69X+0ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E73C4CEC5;
	Wed, 16 Oct 2024 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729088538;
	bh=gMskM2GDWGub7qyVinecyjz/vxqKyOtsZPjwLotEZR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X69X+0ijrVC+ser2PGOmJE9v3cRx85QfgxDiKE09/hAHwEVQoe6S89mKPkpRl0CCM
	 7Vr1naLKeUa3c2UoYnR5GUz49gvnRxnSiRYKuDIz0nyvsGJMJWgXZomvzLGvFU/5nk
	 c6Ojyrjm++n5PRKHAFwMR/ab0tcu0u4cRzTErL+XVg6fcYsaYvO7lHKnpi4dF9Wwr4
	 U6zXBxN3ux0X8/AMAkvmz0K0VKP1YTr0uiM7Sn0qqAmsi5HdHw3rMpWGVU0E8s6OBE
	 YYZ8+8XD994EybvoMqGGHBLVUgylO/hY8bO4+X6y8fDKptYZ/EBBXOgAU/gwbyVt8S
	 ra78Ua4wQFY1Q==
Date: Wed, 16 Oct 2024 11:22:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>, Howard Chu <howardchu95@gmail.com>,
	Andrea Righi <andrea.righi@linux.dev>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, james.clark@linaro.org,
	alan.maguire@oracle.com
Subject: Re: [PATCH v2 0/2] perf trace: Fix support for the new BPF feature
 in clang 12
Message-ID: <Zw_MFwkejeWC2qbv@x1>
References: <20241011021403.4089793-1-howardchu95@gmail.com>
 <Zw61TUe1V97dKWer@google.com>
 <Zw7D9HXBanPLUO4G@x1>
 <Zw7JgJc0LOwSpuvx@x1>
 <Zw7SkmEaz730uVbL@x1>
 <Zw8fqyCZNqSABMkM@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw8fqyCZNqSABMkM@google.com>

On Tue, Oct 15, 2024 at 07:06:35PM -0700, Namhyung Kim wrote:
> Hi Arnaldo,
> 
> On Tue, Oct 15, 2024 at 05:37:38PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Oct 15, 2024 at 04:58:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > > So I'm trying adding extra bounds checking, marking the index as
> > > volatile, adding compiler barriers, etc, all the fun with the verifier,
> > > but got distracted with other stuff, coming back to this now.
> >  
> > > Ok, the following seems to do the trick:
> >  
> > > [acme@dell-per740-01 perf-tools]$ git diff
> > > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > index 3b30aa74a3ae..ef87a04ff8d0 100644
> > > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > @@ -486,6 +486,7 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
> > >                                 augmented = true;
> > >                 } else if (size < 0 && size >= -6) { /* buffer */
> > >                         index = -(size + 1);
> > > +                       index &= 7; // To satisfy the bounds checking with the verifier in some kernels
> > >                         aug_size = args->args[index];
> > >  
> > >                         if (aug_size > TRACE_AUG_MAX_BUF)
> > > 
> > > I'll now test it without Howard's patch to see if it fixes the RHEL8 +
> > > clang 17 case.
> > 
> > It works with this one-liner + the simplified patch from Howard and also
> > on this other system (RHEL9), as well as with Fedora 40, it would be
> > nice if someone could test with clang 16 and report back the version of
> > the kernel tested as well as the distro name/release, that way I can try
> > to get my hands on such as system and test there as well.
> > 
> > Its all at:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tmp.perf-tools
> > 
> > This is the current set of patches that when further tested will go to
> > Linus for v6.12:
> > 
> > ⬢[acme@toolbox perf-tools]$ git log --oneline torvalds/master..
> > ff14baa7a290bf42 (HEAD -> perf-tools, x1/perf-tools, perf-tools/tmp.perf-tools) perf trace augmented_raw_syscalls: Add more checks to pass the verifier
> > 46180bec048aad85 perf trace augmented_raw_syscalls: Add extra array index bounds checking to satisfy some BPF verifiers
> > 45d1aadac64869a2 perf build: Change the clang check back to 12.0.1
> 
> Wouldn't it be better to have this change after fixing the verifier
> issues in the later commits?

I'm still testing it, this is a one-liner, so I think that the order in
which the patches are applied isn't important. Also Howard's patch (the
simplified one) doesn't clash with it.
 
> > 4e21679eb81b5f0d perf trace: The return from 'write' isn't a pid
> > 2d2314d4b09b5ed9 tools headers UAPI: Sync linux/const.h with the kernel headers
> > ⬢[acme@toolbox perf-tools]$
> 
> I guess you also need the syscalltbl fix from Jiri Slaby.
> 
> https://lore.kernel.org/linux-perf-users/3a592835-a14f-40be-8961-c0cee7720a94@kernel.org/

Right, he provided a report about the patch I sent solving the case, I
have to check if he replied to my question about perf trace actually
_working_ on a 32-bit arch system.

I also want to test it, I'm trying to get hold of such a system.

- Arnaldo

