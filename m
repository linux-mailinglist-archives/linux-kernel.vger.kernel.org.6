Return-Path: <linux-kernel+bounces-561073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C06A60D41
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46014607D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEC21EC00B;
	Fri, 14 Mar 2025 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/41ClYs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F131C07D9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944457; cv=none; b=ix3pIOXHZSmXGF5st4GJGtDevQoDkbQ67GlOv0dWG4M3pq4UwYm10dKRFOAru3lvuCv/9DIE14B5ngjX3emODDQrW6W46bTFrNHw2qq93CstExdvvofkVtjIjbBaMXPkwyM7yU3O6TchZDp4OUTJ1vsY8o1QviJ6VuPHyltsr7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944457; c=relaxed/simple;
	bh=yU5cXCgArd4W+i42dPtsvZlrXMdhCG7rxzuaU2Hu3e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByfjnXWGaE1+8gEXoZVbVoTUVR31UHjtrhIlP6MXs8FyCELXcGF9kNc0lq5uBxOELSDbfW1TEfhpjblNBtFHSqsE2GqriwhmxL7vHyQT3Oy0Mlw3BiRAWTCNcvtOB03wBZpRANHMj1eEXkyJULsHOZUO8SJc5ZO2pQex2QW1WEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/41ClYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD82AC4CEE3;
	Fri, 14 Mar 2025 09:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741944457;
	bh=yU5cXCgArd4W+i42dPtsvZlrXMdhCG7rxzuaU2Hu3e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/41ClYs49ypIfSGA+QHfi5Ml3BeXPwm6erPeoKo6fkMgrwV2PNJpNbP4qYu4puoi
	 KA2tiyP7KcaMo6Q3XKT+Qso6Y75BZa+MjrjHRqKXnZOWJY7irSvycU9xydi0v0ONzh
	 O9XDSbcHn4Y6DgPEaJhM+i/3CkhOZXkAqGcr1j9/j1eXZQUPwwsvGVywfmiqT35b/T
	 Y1uO+SH4v9fqx6ZrKxAQGceg9e4jduBsHiCnhvl8haHJxcFcTpHS+zuXMF4warfqw0
	 iusf+yXxobuF62WYez0btUo2mXzuJsZx3+/FPqkrzx6ViRmpCi2rsaguagep4o/Bs0
	 GyvwO1Y7JcdeQ==
Date: Fri, 14 Mar 2025 10:27:32 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 2/5] x86/syscall/32: Move 32-bit syscall dispatch code
Message-ID: <Z9P2hDXjZdHYupiv@gmail.com>
References: <20250313182236.655724-1-brgerst@gmail.com>
 <20250313182236.655724-3-brgerst@gmail.com>
 <5ac97442-78b1-40ce-9282-06cd62d97a67@intel.com>
 <CAMzpN2iu5NRe2PE-TYS9beJp7Ze439C9k8AWHjfcibXi_mGuug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzpN2iu5NRe2PE-TYS9beJp7Ze439C9k8AWHjfcibXi_mGuug@mail.gmail.com>


* Brian Gerst <brgerst@gmail.com> wrote:

> On Thu, Mar 13, 2025 at 7:45 PM Sohil Mehta <sohil.mehta@intel.com> wrote:
> >
> > On 3/13/2025 11:22 AM, Brian Gerst wrote:
> >
> > >  SYSCALL_DEFINE0(ni_syscall)
> > >  {
> > >       return -ENOSYS;
> > > diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> > > index 8cc9950d7104..7c286e89fd04 100644
> > > --- a/arch/x86/entry/syscall_32.c
> > > +++ b/arch/x86/entry/syscall_32.c
> > > @@ -1,10 +1,23 @@
> > > -// SPDX-License-Identifier: GPL-2.0
> > > -/* System call table for i386. */
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * 32-bit system call dispatch
> > > + *
> > > + * Copyright (c) 2015 Andrew Lutomirski
> > > + *
> > > + * Based on asm and ptrace code by many authors.  The code here originated
> > > + * in ptrace.c and signal.c.
> >
> > Wondering if we can skip copying over some of these old comments? As the
> > file grows, it's hard to discerne what specific code originated where.
> > For example, the FRED code is all new.
> 
> I wasn't sure what the appropriate thing would be so I just copied it
> over.  The git history is probably a better way to attribute this
> though.

I suppose we could trim some of the old comments in followup patches, 
as they'll be preserved in the Git log and often aren't really accurate 
or particularly informative in the current code context.

Thanks,

	Ingo

