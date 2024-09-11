Return-Path: <linux-kernel+bounces-325509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D797975A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DDF1C22BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E4815E5B8;
	Wed, 11 Sep 2024 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWVFt+KF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008B1B533C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080566; cv=none; b=IBBl3mf/S+56pbF/9iVwyXwfuzB8Euy8+LDBsIt3sbMSWR74T6B9uudnQWj9IEdFqhENiPe43bP6ZMPujUtSseOK6vmcjb0e/YmFNeaPx8f3OFAO9uD2X6vy8HaXh8XD5xypMgIJB6ICMiF7suRKEjrR5dBNP7i/kFVOhBZfXSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080566; c=relaxed/simple;
	bh=QkRTtUH1Qx9EeNdcC4BeO8C9YO9X21MwlKIOOxowpH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnHh+HWBXJg+aoub/rzO6D1xzT/UMiQolLq59NLO4k+U7AIkZftfatTf9Wigq3ahSdkgsN0ovIuLG1eIr3j8GgUq5/yUlf2bCF7XKulRXrcNajbbUz7ioruZRAX0xIexHLzMocT9gkSZBc2+zfvmY59l5o0ae6L3jQMwx9cySrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWVFt+KF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53C3C4CEC7;
	Wed, 11 Sep 2024 18:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726080566;
	bh=QkRTtUH1Qx9EeNdcC4BeO8C9YO9X21MwlKIOOxowpH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWVFt+KFkvJ29ZRJipd0lZwZzachVDhgX5+tZy23VA7Hy3sVMVbH8qs8r5Kf7vuj6
	 EpZyfGLlne914dT5Uhsi89Yi3I7IZNSu8nkVGYXocmS/KlNZdVljnzgjk8RyfjjA++
	 8OySos9fOL6fHpgrKGXHvjgTJG1gIGVlGD/6vOs6u382xxJyAcbE3IoDGZaHJH5UwW
	 p2ae4WaH4+KrZrAnOjum7QzlMbhUt+ze/6NglQNUmrvEc9aaF98/kNMtukacKkw7B+
	 Krx6X9NCKXVc8sl6oG9UT3vdU856r6OA8aj5w9MPNJmkY0GyiCOsafy/G/QBDcF3d/
	 WSGk/Fw94ApgA==
Date: Wed, 11 Sep 2024 19:49:20 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
	"Yang, Weijiang" <weijiang.yang@intel.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"bp@alien8.de" <bp@alien8.de>, "rppt@kernel.org" <rppt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>
Subject: Re: [PATCH] x86/shstk: Free the thread shadow stack before
 disassociating from the mm
Message-ID: <ed4bccc1-add2-49fd-8c46-505f0e493fc7@sirena.org.uk>
References: <20240910-x86-fix-shstk-leak-v1-1-43cef0c56b75@kernel.org>
 <d4c68681d9e72a5b841bbbb1af1606b382079ad6.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cca5Ht1IQtErMzzx"
Content-Disposition: inline
In-Reply-To: <d4c68681d9e72a5b841bbbb1af1606b382079ad6.camel@intel.com>
X-Cookie: No Canadian coins.


--Cca5Ht1IQtErMzzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2024 at 06:01:00PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2024-09-10 at 23:56 +0100, Mark Brown wrote:

> > When using shadow stacks the kernel will transparently allocate a shadow
> > stack for each thread. The intention is that this will be freed when the
> > thread exits but currently this doesn't actually happen. The deallocation
> > is done by shstk_free() which is called from exit_thread() and has a guard
> > to check for !tsk->mm due to the use of vm_unmap(). This doesn't actually
> > do anything since in do_exit() we call exit_mm() prior to thread_exit() and
> > exit_mm() disassociates the task from the mm and clears tsk->mm. The result
> > is that no shadow stacks will be freed until the process exits, leaking
> > memory for any process which creates and destroys threads.

...

> > It is entirely possible I am missing something here, I don't have a
> > system that allows me to test shadow stack support directly and have
> > only checked this by inspection and tested with my arm64 GCS series.
> > If this makes sense it'll need to become a dependency for GCS.

> The common cleanup case is via deactivate_mm()->shstk_free(), which happens when
> the MM is still attached. But there is also an exit_thread() caller in the fork
> failure patch (see copy_process()).

Ah, yes - glad I was missing something!  I saw exit_thread() doing the
right thing in the error paths but not deactivate_mm().

> A quick search through the arm series and I don't see deactivate_mm()
> implementation, and instead a separate cleanup solution. Could that be the
> reason why you saw the leak on arm? Considering the trickiness of the auto
> allocated shadow stacks lifecycle, I think it would be great if all the
> implementations had common logic. If possible at least.

Yes, it's because we don't have a deactivate_mm() implementation and I
didn't add one (or lost it at some point), effectively this patch is
just adding deactivate_mm() by another name.  The hook being a macro
definition in the header caught me out I think, I was probably just
using regular grep not git grep when I went looking.

I was actually considering what some factoring out might look like in
the context of the clone3() work, as incremental work on top of landing
the ABI so we try to avoid introducing yet more rounds of discussion to
delay that.  map_shadow_stack() as well.

> BTW, two more notes on this whole area:
> 1. 99% sure glibc has some tests that catch leaks like hypothesized here, by
> watching for memory grown after repeated thread exits. IIRC I introduced a
> shadow stack leak at some point during development that failed the test.

Guess how this was noticed!  It's tst-create-detached.c, with IIRC
tweaks to the environment (I think it was turning overcommit off was the
main thing) to make the test actually detect something itself.

> 2. Weijiang (CCed) is working on a fix for case in the opposite direction. An
> error path that attempts to free the shadow stack twice and triggers a warning.

Ack.

--Cca5Ht1IQtErMzzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbh5jAACgkQJNaLcl1U
h9AZBwf+NTIYpD24UCRf8TQhSUE6wuwUyCXKvX75CO1oLQTUF7bTpIuOjPhkTEjC
mvL6MPtj5xhUnu8O583VTkZNCXLdSRr3j+06xI9WqqGpW0d8eplS94NjL4QQCOxL
/SWXmjGXa2VHokVSCsHkW6B+kh0ZrtRZ5KrH9WPshDcIcZ5gwAOg1WzxuNwYCzsV
/9zyGAMxoZ258YZm922+radIUUYqnqDPoH0BGstDG2I7pRQJRHSR/WwFd7d3wF0D
tXSVVtvRKbs9WmpECAwjpByCbsx0BMOJ3DdvSGiuuSCrVqvMbsOFRa5RXm0pwfCr
OOq4GZrcrhfQp8D94+Cs8No+SZVfVg==
=jHwk
-----END PGP SIGNATURE-----

--Cca5Ht1IQtErMzzx--

