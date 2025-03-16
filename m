Return-Path: <linux-kernel+bounces-562957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2291A6351E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 128767A5CB4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABDC19E998;
	Sun, 16 Mar 2025 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upn6xrqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6B35968
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742122721; cv=none; b=F1dMiaNFNNZNFNmPhvsEhMnmbctPJrScm8H72aR64+WjpZrcBdYk0qAV5uLNofc/hnfcsW4FFU8rhVx3iykIBAGuPm6GmSblAXSE7mfVpbra1GdFXgZnko1tiLMi1CiFkYTMvYfJStGULHpB/Uqw/oJGdSDsjNg7q6OreEk+Z/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742122721; c=relaxed/simple;
	bh=/1fqhAq2zyyFAdfwpCeGQhrYIy72WkUu40u3s9Mni5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S08RWP/lc7i/H3JIVs5Ojtkmhp9TKs+LbAkckOwwl8Dn2NSa15x4p/eQQxpXbe2HCm+56hWOpl3IpdZD1Qd/+b/c+rPRfIgf2rORFUgOoX3n9UufoYoVNjtqhbMtGkXi9XF6jvF5zaUf6WZSmNzWHAUxjSV+ulHW+XsVLwfyNWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upn6xrqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28968C4CEDD;
	Sun, 16 Mar 2025 10:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742122721;
	bh=/1fqhAq2zyyFAdfwpCeGQhrYIy72WkUu40u3s9Mni5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=upn6xrqKJiXGzZ0zNwCK71HUP1cYarUwJw1jmOZsYJRBUFMpyFpy+uVAbND1W47eq
	 Ecyavdrp7FLwZTYsxCbUG8UJxNwZ2+mHUcY1Eu2NdB9kkx1utSGP/FC18WYNNtfqjs
	 fqZYlgNc1WIK6gMFmWKQJNnNZ7IA2JvCbzCs4AtyEjxQeB+13a8Q8XXNtJsOkSoHng
	 oqCeSPoaeEH9QMDa6VvCGMoVx2Ej+MQQDBKGG0eFUQU3UGpj0WPiq+SPSYpgTyYmCB
	 SjnKkzsJhQs4+MO/UHUFmqqJE2fELoQfqxndCmBDYffgSgAabJzH06JUzbJJ0PGKRZ
	 0rbT7XR10QREQ==
Date: Sun, 16 Mar 2025 11:58:35 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Herton Krzesinski <hkrzesin@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, olichtne@redhat.com,
	atomasov@redhat.com, aokuliar@redhat.com
Subject: Re: [PATCH] x86: add back the alignment of the destination to 8
 bytes in copy_user_generic()
Message-ID: <Z9au20vtMSXCbdXu@gmail.com>
References: <20250314175309.2263997-1-herton@redhat.com>
 <20250314175309.2263997-2-herton@redhat.com>
 <CAHk-=wj2MhDH_zjnyrUhYUf3ZqokC-jKSeRp9G6GnhwFU9z+Hg@mail.gmail.com>
 <CAJmZWFFVL++yU1XJLkXSck=GRQXiim16xVSvdxjq1k=c=Aaiqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJmZWFFVL++yU1XJLkXSck=GRQXiim16xVSvdxjq1k=c=Aaiqg@mail.gmail.com>


* Herton Krzesinski <hkrzesin@redhat.com> wrote:

> On Fri, Mar 14, 2025 at 4:06 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, 14 Mar 2025 at 07:53, Herton R. Krzesinski <herton@redhat.com> wrote:
> > >
> > > --- a/arch/x86/include/asm/uaccess_64.h
> > > +++ b/arch/x86/include/asm/uaccess_64.h
> > > @@ -130,7 +130,7 @@ copy_user_generic(void *to, const void *from, unsigned long len)
> > >                 "2:\n"
> > >                 _ASM_EXTABLE_UA(1b, 2b)
> > >                 :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
> > > -               : : "memory", "rax");
> > > +               : : "memory", "rax", "rdx", "r8");
> >
> > Please don't penalize the caller with the extra clobbers.
> >
> > Maybe it doesn't matter - these functions are marked always_inline,
> > but they aren't inlined in very many places and maybe those places
> > have registers to spare - but let's not penalize the FSRM case anyway.
> >
> > And we do call it "rep_movs_alternative", so let's keep it close to
> > "rep movs" semantics (yes, we already clobber %rax, but let's not make
> > it worse).
> >
> > As to the actual change to rep_movs - that should be done differently
> > too. In particular, I doubt it makes any sense to try to align the
> > destination for small writes or for the ERMS case when we use 'rep
> > movsb', so I think this should all go into just the ".Llarge_movsq"
> > case.
> >
> > .. and then the patch can be further optimized to just do the first -
> > possibly unaligned - destination word unconditionally, and then
> > updating the addresses and counts to make the rest be aligned.
> >
> > Something ENTIRELY UNTESTED like this, in other words. And I wrote it
> > so that it doesn't need any new temporary registers, so no need for
> > clobbers or for some save/restore code.
> >
> > NOTE! The patch below is very intentionally whitespace-damaged.
> > Anybody who applies this needs to look at it very carefully, because I
> > just threw this together with zero testing and only very limited
> > thought.
> >
> > But if it works, and if it actually improves performance, I think it
> > might be a fairly minimal approach to "align destination".
> 
> It does look good in my testing here, I built same kernel I
> was using for testing the original patch (based on
> 6.14-rc6), this is one of the results I got in one of the runs
> testing on the same machine:
> 
>              CPU      RATE          SYS          TIME     sender-receiver
> Server bind   19: 20.8Gbits/sec 14.832313000 20.863476111 75.4%-89.2%
> Server bind   21: 18.0Gbits/sec 18.705221000 23.996913032 80.8%-89.7%
> Server bind   23: 20.1Gbits/sec 15.331761000 21.536657212 75.0%-89.7%
> Server bind none: 24.1Gbits/sec 14.164226000 18.043132731 82.3%-87.1%
> 
> There are still some variations between runs, which is
> expected as was the same when I tested my patch or in
> the not aligned case, but it's consistently better/higher than
> the no align case. Looks really it's sufficient to align for the
> higher than or equal 64 bytes copy case.

Mind sending a v2 patch with a changelog and these benchmark numbers 
added in, and perhaps a Co-developed-by tag with Linus or so?

Thanks,

	Ingo

