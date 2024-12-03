Return-Path: <linux-kernel+bounces-429909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F779E28A6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5311655AD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703021F9EAB;
	Tue,  3 Dec 2024 17:06:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA1A143759
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245601; cv=none; b=hjrGIWqhFpkGVuzbwF73zYPBO8EI7Vq9H6hqEgl3QWwFDm3shFFuzZ0FqYnVOucrJTC/gwj6tiT7Oxd9NYhQaSmY54wI/LSTcCVTwsKB6FpHBoU04l+Icsl4AMgdRCAJhofbzhsBBJgBfJukm7JZHS+aI0C2uDC2R4KeAwtNRPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245601; c=relaxed/simple;
	bh=SojouC104F7PVMRZr3UxuC8m9mgExn7sRAEXGTCRG1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjfnLB/EnDjQsNrW/ROiwgXHhqw7sVDkh236B4JsnhgZK9MnJnItQhwT52c+O1oI/88W+cxdM7o9ufqAlEhh04JKJfc8CNpIS0ftmWEJ4LwuN9p+tDkkpPvKuKSoTuUqZxO872SMWt6uSIorsyqyIs33CA1DH7PhFngGvXKtKK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2955BFEC;
	Tue,  3 Dec 2024 09:07:06 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55A083F58B;
	Tue,  3 Dec 2024 09:06:37 -0800 (PST)
Date: Tue, 3 Dec 2024 17:06:34 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] arm64/signal: Consistently invalidate the in
 register FP state in restore
Message-ID: <Z086mm/qzNCRB2jH@e133380.arm.com>
References: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
 <20241203-arm64-sme-reenable-v1-4-d853479d1b77@kernel.org>
 <Z08k6QsYRzO8+O4t@e133380.arm.com>
 <f9e297ab-8325-4b48-b8fc-21486ff48cd2@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9e297ab-8325-4b48-b8fc-21486ff48cd2@sirena.org.uk>

Hi,

On Tue, Dec 03, 2024 at 04:53:11PM +0000, Mark Brown wrote:
> On Tue, Dec 03, 2024 at 03:34:01PM +0000, Dave Martin wrote:
> > On Tue, Dec 03, 2024 at 12:45:56PM +0000, Mark Brown wrote:
> > > When restoring the SVE and SME specific floating point register states we
> > > flush the task floating point state, marking the hardware state as stale so
> > > that preemption does not result in us saving register state from the signal
> 
> Now I think about it again this should probably be dropped from the
> series, or at least ordered after the reenablement.
> 
> > > +	 * thread floating point state with preemption enabled, so
> > > +	 * protection is needed to prevent a racing context switch
> > > +	 * from writing stale registers back over the new data. Mark
> > > +	 * the register floating point state as invalid and unbind the
> > > +	 * task from the CPU to force a reload before we return to
> > > +	 * userspace. fpsimd_flush_task_state() has a check for FP
> > > +	 * support.
> > > +	 */
> 
> > Maybe add a comment in fpsimd_flush_task_state() about why the
> > system_supports_fpsimd() check is important?  It's not obvious there
> > why we should ever be calling that function on non-FPSIMD systems.
> 
> There already is a comment in there about it?

There's a comment, but it's not clear that calling that function is
considered correct / useful if there is no FPSIMD.

Not a big deal, anyhow.

> > But would it be a good idea to stick a
> > WARN_ON(!test_thread_flag(TIF_FOREIGN_FPSTATE)) at the start of the
> > functions that rely on this?
> 
> As I mentioned in reply to one of your other messages I want to just gut
> the whole API here and replace it with get/put functions for the state
> which would include the get/put functions making sure they're paired
> with each other.

No argument from me on that, but it would be good to have a way to
check that functions that expect to be called with the FP context held,
actually are (similar to lockdep_assert_held() etc.)

If the number of affected functions is low, I guess comments may be
enough, though.

> 
> Please delete unneeded context from mails when replying.  Doing this
> makes it much easier to find your reply in the message, helping ensure
> it won't be missed by people scrolling through the irrelevant quoted
> material.

Ack, but opinions can differ about what context is unneeded.

I'll try to keep the noise down on these threads.

Cheers
---Dave

