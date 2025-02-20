Return-Path: <linux-kernel+bounces-523787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1BAA3DB45
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E924189B9BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FDD1F8AC0;
	Thu, 20 Feb 2025 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtohReNq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F20433BE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058018; cv=none; b=t82Lny1ONjwQ5sXXBoctnpiMPrhvZDDNqjdkE4r+5sCyRHU83mh0FKx6n31usePOD0fMuVwoJdDIIlLmbW/WotloFL6PGAtK2c5PxBYMRxwpRv70350UPf7R+iWyW1EBZSaramOcmXJM6zfnYbG9qbKo2nT4AOTSfZV3mzZrScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058018; c=relaxed/simple;
	bh=P8j1eigvN7rgKJCZBo2OFS0y3OPpg9zieYnI33IBpKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMxTPz8e7MSdKBzbaE5YwmyHfcS8F7tEDGXQJInYnXQhPUSCTR9f56NGTa1u4AkJusmHkSyECV+c19ZP5jnXyhmyZrWZ1WW1R8YD+iD/RfL0XGKGwI1r22fGdRFkYaYNDA5FK0VKE+2iHuEsSinOegkYRzb3nlQNdU4wOScvRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtohReNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47379C4CED1;
	Thu, 20 Feb 2025 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740058018;
	bh=P8j1eigvN7rgKJCZBo2OFS0y3OPpg9zieYnI33IBpKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtohReNqtYBWFf5m9rELvHj+f1q4VM7eu4mnLTfOWGhooujMFamZfwXRnh1ms0EDX
	 LRyNXtPf9kcz7SBcBXF2BWUZDICuEe4Yicj3SApHJ9H9GHBsSMSISZjE85iYr6r7T9
	 4TMHbYr2fST2CTRmPuiZI4ShAqjrRfd1XN0Y6fmHZhYYCLZfxx3A8REMi4IUp667rn
	 +srDZHdOTcfElyMvM7zUEfSRgR847PNk8I4onfsTKk+hbeITF5WVLEaxH/dMItxuzn
	 9gMsKFZd6xzANucgdSjRzzMRqVbLz1uWHZVL0LK0O+CRwRVZ8kYQ3n+rQh6hBzFNwl
	 Sbfef1DOq1r7A==
Date: Thu, 20 Feb 2025 14:26:48 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
Message-ID: <Z7ctmL3HDGxzyX0g@gmail.com>
References: <20250123190747.745588-1-brgerst@gmail.com>
 <Z7RRZ0jdqsrADMm0@gmail.com>
 <CAFULd4Z_QoOLKCOawyeFtRe6V4+oaaGxfQxav9dS-Di-Ne7tfw@mail.gmail.com>
 <Z7XE0P6ZFHxtlYXw@gmail.com>
 <CAMzpN2gyhEnYsimxLhLNPc4HTpVdRGTiBfm9pXiFTL6_3-O=sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzpN2gyhEnYsimxLhLNPc4HTpVdRGTiBfm9pXiFTL6_3-O=sg@mail.gmail.com>


* Brian Gerst <brgerst@gmail.com> wrote:

> On Wed, Feb 19, 2025 at 6:47 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > > Thank you for doing this series - it all looks pretty good from my
> > > > side and I've applied it experimentally to tip:x86/asm. I fixed up
> > > > the trivial details other reviewers and me noticed.
> > > >
> > > > Note that the merge is tentative, it might still need a rebase if
> > > > some fundamental problem comes up - but let's see how testing goes
> > > > in -next.
> > >
> > > I wonder if there would be any benefit if stack canary is put into
> > > struct pcpu_hot?
> >
> > It should definitely be one of the hottest data structures on x86, so
> > moving it there makes sense even if it cannot be measured explicitly.
> >
> 
> It would have to be done with linker tricks, since you can't make the 
> compiler use a struct member directly.

Probably not worth it then?

Thanks,

	Ingo

