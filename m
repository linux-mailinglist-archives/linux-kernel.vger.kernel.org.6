Return-Path: <linux-kernel+bounces-257371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0C8937921
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E4CFB2273B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A03913A276;
	Fri, 19 Jul 2024 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KsomgM3P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kEf7OuaA"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B241E871
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399103; cv=none; b=QsqWGdWLXm9XTeDEgNuH4hNyeHFK78toUzud4v1fNpWxeHSnXGkUxixZa8MiGRa+KQlTTX5dPsK2l5zYcswXaoE0dh0Lqj69uNDCAO8j3dEzQ0MlOpRjkxbhsCaqo8bMj6udPnKX6pPJtpjeQuXOMhvJ8XYwM/YCUccIRrQCZmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399103; c=relaxed/simple;
	bh=FsLFPunMkcH7MYP8a6ZAQdFL1++Ke+lG2ipNg9drAIU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=e3et9zYB+jnWQ8ELiaKcLMG5sCwSsIpyJRUdRdtyhoHr7Q/js0E3tKyDTa+ACsBbSlKhDV/fkiCq0GpNK/YSgzB30MYZloWe1z9eu8HABgcaBaMjVRe396eItJk/BdtDDBy4H0vp1httPYff/b+sA80hDYiJx2sxdpUHjViTL58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KsomgM3P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kEf7OuaA; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3F9D71140374;
	Fri, 19 Jul 2024 10:24:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 19 Jul 2024 10:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721399099; x=1721485499; bh=sSjq0x1Zmo
	BIZ7CuV91beQ+Z2UglWzdGp7NHqt3EvpI=; b=KsomgM3PCMKMpNuWVZLpAkGc+Z
	NsWOhDlVUb+WzLACb8EGNGu0o980cGnH1cC2Jd739hywjkW3XwxIkr7ZikW2Lgb9
	Bz4Hk8HUE2eWeK72yy7SJNCs4m92iKY/ezbQ2mW/PA1bZEAIjhjvO5jF82J6qMAz
	o/QWeMmAs7UNzknqxokuj7b+VJ36jtSnZEuZUIRNXpHiURq3+w552gccjhe5GHoS
	Vm2Ry1IBkLy/SFf55STlKCkGuowocTD5RX8aWb8tTUbHxShUBXjfJ9lFEz4drKFb
	uCzimmSrO/x/29EilLmJC5m5k16Q2AvWRhnrcTsCUHkPS7xqN5gTV3bs/Zxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721399099; x=1721485499; bh=sSjq0x1ZmoBIZ7CuV91beQ+Z2Ugl
	WzdGp7NHqt3EvpI=; b=kEf7OuaAgz9h2xrngqXRyt7JlfXz7gxM2w33+zXg7m+G
	Jir6yP7Ja2mUu4NiCRgjJznDIxeOdm0w/eBAZcplK/dkZyBsBzgJYB1dMUmOOkB/
	yETb46O2OaVeAwts5Zon14nsA0wVIaixueN92KerAYWMJLLpihN06AYkchbJgBgR
	JpXFv2hfL5XFWlQq007kRt0l7SZ41oupvzZL+CxJFvbcEGzzdOWKg2dF2ZwrwLVJ
	Vvdl4pr8jSYL3s5tp7IjPJ67EVS57I1iZC65Yd97TSVB5t9b1gYUMupjm4OQX0Au
	Kpk4GWLVKtiFRuiTYhFHPy35b+O9qlpIDI2mESRyfw==
X-ME-Sender: <xms:OneaZnYwenn1UJMqHp3fx_WO2pPonb2LcIrCqChlOl1xBZ913Rt5DQ>
    <xme:OneaZmbCTsntp0ztX-_C434_e1s2CiOEXtTFkaUjd_u8G2mjCL_-5QhA2vpHlEFRn
    OxqbvLxVrXc95Io7xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrhedugdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:OneaZp_BmBpeNolt_2NQlUlbWwZHHrRKQGIHFKEZrbAUqOMVtMNJCw>
    <xmx:OneaZtq2djazO7J0mEIa99hnU_PCs5f-e27OG0cCucBicTR8UanpmA>
    <xmx:OneaZip7D7JbNKlw3_qtHEHyGIfoWAq3XOxKErBzDrp-ios1yphx6g>
    <xmx:OneaZjTJ3TAb9UVPDNVPNtdJpoIt6sLVdhBp9h3xQHPbm_5oj27zOQ>
    <xmx:O3eaZiKyJQMHcDxzrsFt6jxQ6Ip0RqSeFOn_7V5GnmdPBW-_mjrztl0Z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A621DB6008D; Fri, 19 Jul 2024 10:24:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <158d8c88-0b39-46f2-824a-7b3a52f4ee0a@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wi6RzMFr3zWfkwHh1JwLxQzN0BtH3H7M6JJogVxOat8CA@mail.gmail.com>
References: <20240716234445.a17a40e8d3d7b4ba5cef949e@kernel.org>
 <20240719102824.1e086a40@canb.auug.org.au>
 <CAHk-=wi6RzMFr3zWfkwHh1JwLxQzN0BtH3H7M6JJogVxOat8CA@mail.gmail.com>
Date: Fri, 19 Jul 2024 16:24:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Jeff Johnson" <quic_jjohnson@quicinc.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] probes: Updates for v6.11
Content-Type: text/plain

On Fri, Jul 19, 2024, at 02:49, Linus Torvalds wrote:
> On Thu, 18 Jul 2024 at 17:28, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> There are system calls that are architecture-specific (the whole vdso
> thing), and nothing is ever going to change that.
>
> Others may not be as fundamentally tied to certain architectures -
> like this uprobes thing - but will simply be introduced at different
> times because they still need possibly a lot of architecture support.
>
> So considering that it was added this merge window, and already is
> showing all these issues before the merge window is even over, I'm not
> at all convinced "scripts/syscall.tbl" has a future.
>
> Now, I do think we should strive to unify the system call table
> generation under one syntax. I don't think *that* is a bad idea.
>
> But I'm not AT ALL convinced we should strive to unify the numbering,
> and do it in one file.

The unified syntax is all that is new though, the unified numbering
is what we've been doing since the time32 syscalls (403+) in 2019.

The unified table across all /new/ architectures has been in place
since e64a1617eca3 ("asm-generic: add a generic unistd.h") back
in 2009, so the eight newest architectures, plus a few that have
come and gone again, have been sharing the same numbers for
the past 15 years.

> In fact, I think that the numbering should not exist at all in that
> "unified table syntax", because the number itself is causing problems.
>
> That whole "the numbers themselves are a problem" is not a new issue,
> we've seen all these silly renumbering issues forever, just look at
> something like this:
>
>   git log --oneline --merges --cc arch/x86/entry/syscalls/syscall_64.tbl
>
> and that's with people often _trying_ to work together.  So I think
> 'scripts/syscall.tbl' is actively detrimental, because it introduces
> *new* problems, and it doesn't actually solve that *old* problem.
>
> So I think this needs to be re-visited.

The syscall.tbl file itself is just a replacement for
include/uapi/asm-generic/unistd.h, which I would like to remove
in the next step, it's already unused.

I was planning as one of the future steps to move numbers
403 through 467 into a file that is actually shared, to make
it easier to coordinate the addition of system calls:
any addition would only get added once instead of 19 times.
I have not tried implementing this yet, the open questions
here are how to handle alpha with its different numbers
(offset by 110) and x32 with the preassigned numbers 512-547.

This has always been something that others have asked me
for since we started using the syscall.tbl format on most
architectures, but I don't actually care about this part too
much, compared to other things I would like to implement
based on the syscall.tbl format like a machine-readable
ABI description that contains both the syscall numbers and
the argument types.

> One possible model might be:
>
>  - remove the numbering from the syscall.tbl (because the numbers
> _are_ going to be different)
>
>  - make it really easy to add actual generic new system calls in one
> place, for when the system call is NOT something that needs
> architecture-specific trampolines and stuff
>
>  - make the common infrastructure generate the numbers
>
> because I think the current model of "let's share a table with
> numbers" is already dead in the water before we have even completed a
> single merge window with it.
>
> Other ideas? Arnd?

I don't think we have to abandon the common numbering now, given
that this is the part that has mostly worked out fine, with
architecture specific syscalls being really rare in practice.
We have been dealing with them already for 15 years, and this
hasn't really changed with my recent patches either.

a) numbers 244 through 259 are reserved for architecture specific
   calls. A typical example of this is "cacheflush", which is
   used on four architectures. Architectures with a custom
   syscall.tlb file can instead use the available numbers below
   403 where needed.

b) clone3 is still missing on four architectures but should be
   implemented there. This used to require defining
   __ARCH_WANT_SYS_CLONE3 on all architectures, but I've turned
   it around now so architectures that are missing it instead
   define __ARCH_BROKEN_SYS_CLONE3.

c) memfd_secret is only used only on x86, arm64, riscv and s390.
   With the new table format, this now requires adding the keyword
   in arch*/kernel/Makefile.syscalls, e.g. for riscv as
   syscall_abis_32 += riscv memfd_secret
   syscall_abis_64 += riscv newstat rlimit memfd_secret

I discussed all three methods with Jiri when looking at his
uretprobe patches. I recommended using b) at the time since
I wanted to avoid the extra keyword from c), but it sounds
like you would be happier with a). If you like, I can send
a patch to move it to number 335 for x86, or you can move
it yourself if that addresses the specific problem with
the uretprobe.

      Arnd

