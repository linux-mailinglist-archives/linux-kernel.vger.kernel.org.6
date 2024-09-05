Return-Path: <linux-kernel+bounces-317640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AE996E15C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20961F24DF0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4AE1487D6;
	Thu,  5 Sep 2024 17:51:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE15381B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558694; cv=none; b=bLx1SoLo36Ea2iAsDdBRIbB/Tx3OtSOsTeuwMMY+eErVNTAgXbSiru5Z0igUrKpNoY619ZtKFQ7QIeHjhpk4Ro+dpQ0Y4UCe+cEiRWhoYw6fXjw8u0U4rWK3tkTHX96QA6s2KT3eIbLh8UUAjCC3snRA1s+pkQUg4xuRA6twEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558694; c=relaxed/simple;
	bh=SxHtQ/hby62J1QGxBYSph2TkWEJBQ0BADGeDl6/99Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoodwoW5HaWVkkotMZIOgfpsEJnYQHTLiwxow2IjaliZixbur0x9Cdyw9f1OAWHhOSOavqWFe7pIbGunYYsaeJmKr2XrAy7MLROylhA5pyR49O7+S2SCnjbTjAeAy54agBLmI7KvH7PMC2uzXtiWkwuMuOm/2UWVVx/XXiPl7tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8285CC4CEC3;
	Thu,  5 Sep 2024 17:51:32 +0000 (UTC)
Date: Thu, 5 Sep 2024 18:51:30 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/fpsimd: Ensure we don't contend a SMCU from idling
 CPUs
Message-ID: <Ztnvosf0JHsvCf7-@arm.com>
References: <20240618-arm64-sme-no-cpuidle-v1-1-1de872e1691f@kernel.org>
 <Zo7qzWVXRWulVtCT@arm.com>
 <Zo8ZDBisWJonBVqF@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo8ZDBisWJonBVqF@finisterre.sirena.org.uk>

(replying to the previous version as it looks like I haven't followed up
on the discussion)

On Thu, Jul 11, 2024 at 12:28:12AM +0100, Mark Brown wrote:
> On Wed, Jul 10, 2024 at 09:10:53PM +0100, Catalin Marinas wrote:
> > On Tue, Jun 18, 2024 at 02:57:42PM +0100, Mark Brown wrote:
> > > +	/*
> > > +	 * Leaving SME enabled may leave this core contending with
> > > +	 * other cores if we have a SMCU, disable whenever we enter
> > > +	 * idle to avoid this.  Only do this if they're actually
> > > +	 * enabled to avoid overhead in cases where we don't enter a
> > > +	 * low enough power state to loose register state.
> > > +	 */
> > > +	if (system_supports_sme() &&
> > > +	    (read_sysreg_s(SYS_SVCR) & (SVCR_SM_MASK | SVCR_ZA_MASK)))
> > > +		fpsimd_save_and_flush_cpu_state();
> > > +}
> 
> > Do we always enter here via the idle thread? If we already had a thread
> > switch we probably don't need to save the SME state again, only flush
> > the state.
> 
> If we've actually switched the thread then TIF_FOREIGN_FPSTATE has been
> set and we'll just check the flag and return for the save portion rather
> than actually writing any register values out so the overhead should be
> minimal.  It feels safer to check in case we get better at doing the
> save lazily.

OK, so likely the state is already saved, all we need to do here is
flush the state and SMSTOP. But why would switching to idle be any
different than switching to a thread that doesn't used SME? It feels
like we are just trying to optimise a special case only. Could we not
instead issue an SMSTOP in the context switch code?

Also this looks hypothetical until we have some hardware to test it on,
see how it would behave with a shared SME unit.

-- 
Catalin

