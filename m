Return-Path: <linux-kernel+bounces-555104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AA2A5A567
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574AF17423E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAF71D7994;
	Mon, 10 Mar 2025 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+gWp3ux"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB512B73
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640457; cv=none; b=lLqz3j0vJHPn45dogUWbS5L+PF+CuyA9Dv8kuHxodh58qscbFlOc02duCMqSQ1bs3sEMpldGu/oWLPhwxFUwO29yCi+UoLSoX9E4mVv+YVN1jaE3WpvUa6xllfWOFn3VfPkNof+TfRYXsUHwHVflWhT3n3mGJaXj3eDB/vX7EyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640457; c=relaxed/simple;
	bh=sL+/G+KbKI4+8LPaMvKGb863eWCMC/NxCKTCpR917Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRfDSN59mY1+dJHG5SRYhbe70qJtpaJtP+cg3LJuPMkCJX4nVh74rZr0/d6nZ0PP7TqKMR5uxwGLFWfAwo9vY5xrsX5cUtiW2IJ7HRkVQwyyu1ZsArwpXfblm75CyD4YEOLj5x50eCr8D4bTmahj+agfhgPb1jFHOUtYqVoqHpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+gWp3ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05A1C4CEE5;
	Mon, 10 Mar 2025 21:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741640457;
	bh=sL+/G+KbKI4+8LPaMvKGb863eWCMC/NxCKTCpR917Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+gWp3uxGvfroE61mT855Xkl9Zk0ryFrj6HcSrbrqO14XNtEAjhDecJA5SIaWZAYR
	 q208OvR3kF2b/ELiRp6DIWoEzxcmsGwa3IveHaLertCKnzQC2IyrjDx7gcZXyl86Cu
	 B56yVnc4mQvCa/FOLslBmg2H975eGIzOGtMRL+uQOS4Rwt2dXnv4vt7FGYOTGZrOiE
	 X8aq43toBPOAYgvqWDR9nOWc/T2g5NIaRw8U5YRRFZL1iBsLHtsHmpx8/iuOLNPloi
	 Zevr0zVJio6Wm1UhtZjW5ErRL9zT+j3UCNorbPnUUEEojMo9yi03ql9Y+CudjbhvBw
	 kZFe8MDLsmgPw==
Date: Mon, 10 Mar 2025 22:00:53 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/hweight: Fix and improve __arch_hweight{32,64}()
 assembly
Message-ID: <Z89TBVoRDLy66EuQ@gmail.com>
References: <20250310200817.33581-1-ubizjak@gmail.com>
 <20250310201227.GXZ89Hq5LVWKHjHBeO@fat_crate.local>
 <CAFULd4ZCc08kJU+3ZVdyWhO4s5fu0Y-RDPS-Y-_sPB1R0KrnoA@mail.gmail.com>
 <20250310204454.GYZ89PRl3dBR-9oBIY@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310204454.GYZ89PRl3dBR-9oBIY@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Mar 10, 2025 at 09:35:42PM +0100, Uros Bizjak wrote:
> > On Mon, Mar 10, 2025 at 9:12 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Mon, Mar 10, 2025 at 09:08:04PM +0100, Uros Bizjak wrote:
> > > > a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
> > > > instruction from being scheduled before the frame pointer gets set
> > > > up by the containing function, causing objtool to print a "call
> > > > without frame pointer save/setup" warning.
> > >
> > > The other two are ok but this is new. How do you trigger this? I've never seen
> > > it in my randconfig builds...
> > 
> > It is not triggered now, but without this constraint, nothing prevents
> > the compiler from scheduling the insn in front of frame creation.
> 
> Can you please stop with this silliness?
> 
> When we start doing git archeology months, years from now, it should 
> be perfectly clear why a commit was done. This one is not. So either 
> the compiler is doing the bad scheduling or it isn't. Things can't 
> just work by chance.

So this particular code generation aspect seems to be working by random 
implementational chance right now: objtool is basically a second, 
independent layer of tooling with its own assumptions and expectations, 
which is why objtool warnings are not hard build failures.

But whether unexpected instruction scheduling is known to occur or not 
with current compilers should be included in the changelog and is 
relevant information.

Thanks,

	Ingo

