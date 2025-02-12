Return-Path: <linux-kernel+bounces-511930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961D3A3319E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F303A8033
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCCC2040B9;
	Wed, 12 Feb 2025 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leX7nYyM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9282040A9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396129; cv=none; b=KfXj9vMVzZLSEEVpRQe46B6zg7KGBm6HZkNSsunS8hJZAfbUSmVLo/lX4P2Msv+6pCWmOyKsb0H1Jxqj1IveaF/nitRzR8T8G75XKKY4FhQ8ZXPpPEUC1GFaVRcp4h2FUgcPv7bzWkYP+Udp1KjTB6AyW7p0plIWxEsTagnG4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396129; c=relaxed/simple;
	bh=dPr+vnBrIM9oQBt9wlCIsEQp6wnBtrVvN0kf7GZNHGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYQT+og/4RXZTCNJQWi+lurg4C1Ei7vD9PPwhwZdk46eQ7/4v4HxpOUvOWm3hAYp3917MRycFsNoEbZMo//JmQiF4Y5ZRAfvhi3FHG8v1BNrW7CuSPdG8lL5sC4zpJwB/fwawE7z3Wl8g7K5U9e5nvbL+yPJBgFEwldonqmejOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leX7nYyM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FD0C4CEDF;
	Wed, 12 Feb 2025 21:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739396128;
	bh=dPr+vnBrIM9oQBt9wlCIsEQp6wnBtrVvN0kf7GZNHGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=leX7nYyMfwkEI/YzNJhoLDthSV3QCZxkapgpaptBqxjaq/ATdfM+h0SiEeVzCtoDG
	 1mNhu3zsUOecDQSjXSoFsRKrrnCTFE6n1Bmr1ZqLA7FSmFc+4TxcW35zTSBuMEkP0X
	 FK4shXPY1etjckJ9ugz/G5maK9PbO4KBWRKrm+DcxYfcHCtQOHz88FhnQX/qHzujBx
	 nW9oMsGEWhCLeZcTJ+Cct/WjY4wauaVT8aDTtAu2eWCVHUp+Asj4rOY7n2TuNkoauc
	 xDzpXW3JpY53V5Tvgm3dao65k2Seu3V44imvunHfcs0m6PLTUyXIh7RFT4IX80BcxZ
	 K1WH9XL9BQEqg==
Date: Wed, 12 Feb 2025 13:35:26 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 13/35] x86/bugs: Restructure spectre_v2_user mitigation
Message-ID: <20250212213526.2ztowz3z4r3lxplk@jpoimboe>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-14-david.kaplan@amd.com>
 <20250211005338.dqj5sg5sj7repdu6@jpoimboe>
 <LV3PR12MB9265E26EEEA0670ABF7E9ABE94FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265E26EEEA0670ABF7E9ABE94FC2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Wed, Feb 12, 2025 at 03:59:39PM +0000, Kaplan, David wrote:
> > On Wed, Jan 08, 2025 at 02:24:53PM -0600, David Kaplan wrote:
> > > -     if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
> > > -         retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
> > > -             if (mode != SPECTRE_V2_USER_STRICT &&
> > > -                 mode != SPECTRE_V2_USER_STRICT_PREFERRED)
> > > +     if (spectre_v2_user_stibp != SPECTRE_V2_USER_NONE &&
> > > +         (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
> > > +         retbleed_mitigation == RETBLEED_MITIGATION_IBPB)) {
> >
> > This adds a hidden dependency on retbleed_update_mitigation()?
> 
> Yeah I guess it does.  I'm not sure of a way to cleanly avoid this if
> the logic is kept as-is, do you think it's ok just to document this
> dependency explicitly?

Yeah, if the dependencies can't be cleanly unwound, at least they should
be explicitly documented with comments at the call sites, similar to
what we attempt to do today.

> The only case I think where this matters is if 'stuff' is selected for
> retbleed, and then retbleed_update_mitigation decides you can't do
> that and it has to re-select and may end up with unret or ibpb.  That
> case doesn't even make much sense since 'retbleed=stuff' isn't a
> mitigation for AMD.

True, though generally we should treat such things as hard dependencies.

It would be really easy for a future person to come along and introduce
a bug when they see the 'retbleed_mitigation' reference and assume the
dependency has already been handled.

So basically any "update" function which references the output of
another "update" function should be treated as a dependency.  Because
even it's not technically a dependency, that could easily change in the
future without being noticed, with a patch to *either* of the functions.

> One idea, which would involve changing the logic vs upstream, is that
> 'retbleed=stuff' should only be allowed on Intel and it should be
> converted to AUTO on AMD.  If that's the case, then there isn't really
> a hidden dependency anymore since the retbleed mitigation will never
> change to unret/ibpb during retbleed_update_mitigation().  Thoughts?

Yeah, I'm strongly in favor of any such simplification.  We spend *way*
too much maintenance effort on all these weird options and combinations
which don't make sense.

-- 
Josh

