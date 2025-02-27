Return-Path: <linux-kernel+bounces-535321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C3DA47146
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF2C16DC21
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DDC22D4E4;
	Thu, 27 Feb 2025 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byy/8z38"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0291B5EA4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619411; cv=none; b=P6t0iWwp9j3vjqaj/ds8lnxk6TEvEvc5MQ4SjW0Q2W1JaYZL6+JsaS9lMIbn065EFTJQemVgA2C659iUN+yETxp12A9iG9NhycImgBbUjasGsgX5u7Z5Q3qpBWPTq1VGVCUU6n7GAr462F1ST6oHBQC7FTGoRM6Zb6Je+sS/ES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619411; c=relaxed/simple;
	bh=3rY5qLWrekvjZ4QCc0IKQqcEZOmzHa/KRRYhUhsCevQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4xDNn9Vugt7/Z1LnOyArHMJ6TGTe5nrG1x/XCmWlsn3EfXPtSakmg0odzeg5FSDdfhy8SDtSN4FYyiwBFBCWwT8FCKsS1q3hBSxGv2KiELY3Ar3mRzSK/L0y23lOV2nBUobcDswdVqiyI6TEQCQL7+98UVuzjyR95cZ/mxaGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byy/8z38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F259DC4CED6;
	Thu, 27 Feb 2025 01:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740619411;
	bh=3rY5qLWrekvjZ4QCc0IKQqcEZOmzHa/KRRYhUhsCevQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byy/8z38+SGc55XKHUWJOzsWXTyJj+8fpipjMHNc1ZJWKHh3J9ntGGFK6m/s0M3qE
	 Dl3YezpRJ9DwMBIcAvKabmfKIifHDDAMmrUmJ1CgEjsx+VJVBcqbbk3kgFshdyDHMz
	 c6bbmjVLZVFLtWKP0wyHleM8o1rt0nYbTaWxH5rA8EcQdeHGZHDJTDLCjrZl/sprNj
	 W6cV5BcXZcK/jHHj//d89nVVThgOSO3yskCgSRBa+7HdOtBcw/nGljYMxyWvmcJRsQ
	 ZKcoOWTCad4gfQbl1J00yI/oHiUGfzz395zSpHnnByByRAuD6MaZ1ss/ZKJWT7vhKn
	 ONDw1hLRPmL8A==
Date: Wed, 26 Feb 2025 17:23:29 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250227012329.vbwdmihjlqu6h5da@jpoimboe>
References: <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
 <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
 <20250220220440.ma5yfebhiovkqojt@jpoimboe>
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226201453.jgg6kucaathzmcvs@desk>
 <LV3PR12MB9265F875F52317BBCDF953EC94C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226221324.hq2nevnnnrpgo75n@desk>
 <20250226234440.4dk4t3urkzt4zll7@jpoimboe>
 <20250227003528.hnviwrtzs7jc3juj@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227003528.hnviwrtzs7jc3juj@desk>

On Wed, Feb 26, 2025 at 04:35:28PM -0800, Pawan Gupta wrote:
> On Wed, Feb 26, 2025 at 03:44:40PM -0800, Josh Poimboeuf wrote:
> > On Wed, Feb 26, 2025 at 02:13:24PM -0800, Pawan Gupta wrote:
> > > On Wed, Feb 26, 2025 at 09:03:58PM +0000, Kaplan, David wrote:
> > > > > Extending =auto to take attack vectors is going to be tricky, because it already
> > > > > takes ",nosmt" which would conflict with ",no_cross_thread".
> > > > >
> > > > > How about we keep =off, and =auto as is, and add:
> > > > >
> > > > >   mitigations=selective,no_user_kernel,no_cross_thread,...
> > > > >
> > > > > Requiring the user to explicitly select attack vectors to disable (rather than to
> > > > > enable). This would be more verbose, but it would be clear that the user is explicitly
> > > > > selecting attack vectors to disable. Also, if a new attack vector gets added in future,
> > > > > it would be mitigated by default, without requiring the world to change their cmdline.
> > > > 
> > > > I kind of like that.
> > 
> > While it might be true that we don't necessarily need both opt-in and
> > opt-out options...
> > 
> > I'm missing the point of the "selective" thing vs just
> > "auto,no_whatever"?
> 
> That was my first thought, but then I realized that in "auto,nosmt" nosmt
> is the opposite of disabling the mitigation. It would be cleaner to have
> "=selective,no_whatever" which is self-explanatory.

The "auto,nosmt,no_whatever" is indeed a bit confusing because of the
opposite meanings of the word "no", but least it sort of makes some
kind of sense if you consider the existing "auto,nosmt" option to be the
starting point.

And we could document it from that perspective: start with "auto" or
"auto,smt" and then optionally append the ",no_*" options for the vectors
you want to disable.

IMO "selective" doesn't seem very self-explanatory, it says nothing to
indicate "opting out of defaults", in fact it sounds to me more like
opting in.  At least with "auto,no_whatever" it's more clear that it
starts with the defaults and subtracts from there.

-- 
Josh

