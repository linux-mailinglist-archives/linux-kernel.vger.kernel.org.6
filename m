Return-Path: <linux-kernel+bounces-309418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD06966A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C7D2B21601
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4CB1B86D6;
	Fri, 30 Aug 2024 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="ISuipHah";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="DWrfCaEP";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="P7Vd6NkS"
Received: from e3i12.smtp2go.com (e3i12.smtp2go.com [158.120.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9C1BF322
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725048299; cv=none; b=kIMRsW/R5SHy2/qTFdputD37/qkPwHV0DCZHKQUya32vlb5teLiX6N6tgD2dDzkZI6P/9GYCnD7/PNTv8Iul8NipiSoQNvX8KSRMhPnyK59LHtjXuX5AzqKSlReIG1cqADAvPlJVPiF1jd9DzFKFpcm7SUTc3FtUR69OJDJSuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725048299; c=relaxed/simple;
	bh=VrcLFN5tqkfWY7mTHOYKMf0e0KvomCFsMPrfJDAaMSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7YJzLfzrS1XcdPVVTAoD7OHBlXAqccGdNpTynn28qRL7KOAcjMrDOF6glkVcrvUxtobj7++5tA1zrHIHx/lUUl5hGZQKBVLt3aWL2TscbjTCaJlRU1GGUZpbF994YVxq7tinV13T4QmbgvU093UsfT9Zn90yUeDxIi2Al1r34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=ISuipHah; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=DWrfCaEP; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=P7Vd6NkS; arc=none smtp.client-ip=158.120.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1725047642; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=8ffM0oj/VoAWiRvIYhx2YzkqNpRjhG4e8iNPq0uer6M=;
 b=ISuipHahFXFkqFrpJg6bxXhwo9EJtO0k1W3Q6oVnyUbTsfh/xuQP7/PDc7r9cTlRlWpB1
 4Mx8fQk5c5T7PE7rLVoxll7BfYP/Fcw0On+kzglHB6Ah44FSSUOMLRN2UglAYEIAEaAL8xE
 9H9S9heA8CTHei5iIjDvX+Hbdx5WBCD6Kzb8AxgzJ77E+NtAN2mF9/+t9TTLuxXPHxOOKsb
 1m1s0VJi8ZkKZxv/uEx/oM7LScVY6bZ3jlTIbcuFzgYR4igB34SbEs1rD//tSSz3Rtb7PuL
 yDFc7LAVujQmf3qYU2TyAviP9YvLgq/qxNvGeMX4rGvU+r8vm62bmHHINDPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1725047642; h=from : subject :
 to : message-id : date;
 bh=8ffM0oj/VoAWiRvIYhx2YzkqNpRjhG4e8iNPq0uer6M=;
 b=DWrfCaEPVwhMDQMvGXnZtzDzQ77XIqdKdAtUjMv/BPDVT5WiA3LHj5YxEcPHTrIlMHtOt
 E/e3GcR16fgG2rZnpyJ8bN++6edggstqOqnOrUTV5t+n4/2jUZ2Bf/nYWomhR/TvF0kV030
 MU1ufBAHHSuiEEwkfoKAQlmNW4zLkGwEoHTjoGWNpLkEIQFnpOHVzoPijp0mW5N9wusdYH2
 dfHk3FoH7mciotLgC5zbBB31znl3QVkRx7LDD1LfmVV2WyG4u5fMnKs4SmrOWaStuvpL/3K
 Y/K0zxfSPqSUZVYiFLKv1Rqj1r7B32f+eF2xGJQ9ayF9D7QPQs9wrFbgpEVQ==
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <nicolas@fjasle.eu>)
	id 1sk7gj-FnQW0hPpdBf-nWmg;
	Fri, 30 Aug 2024 19:53:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
	t=1725047604; bh=VrcLFN5tqkfWY7mTHOYKMf0e0KvomCFsMPrfJDAaMSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7Vd6NkS50dZUF4ArGNPd4emC0HPqVDT3dc+nak6w/kyFZyIa7wpU0vTqmsiIkRep
	 lFQ7rFhNaD2Mf9eA7RsNhjnIHPRkgubjb0TmusaqfHzYKQpJgQpvZs4tHW5Z4AT4vC
	 fDqmIJfHaxoaJYo+8KfLKLIUurdYOyn4DfkqTbOE=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
	id 423D3449B6; Fri, 30 Aug 2024 21:53:24 +0200 (CEST)
Date: Fri, 30 Aug 2024 21:53:24 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Daniel Gomez <da.gomez@samsung.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	William Hubbs <w.d.hubbs@gmail.com>,
	Chris Brannon <chris@the-brannons.com>,
	Kirk Reiser <kirk@reisers.ca>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"speakup@linux-speakup.org" <speakup@linux-speakup.org>,
	"selinux@vger.kernel.org" <selinux@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	Finn Behrens <me@kloenk.dev>,
	"Daniel Gomez (Samsung)" <d+samsung@kruces.com>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH 08/12] include: add elf.h support
Message-ID: <ZtIjNBhqdxmMBxfM@fjasle.eu>
References: <20240807-macos-build-support-v1-0-4cd1ded85694@samsung.com>
 <20240807-macos-build-support-v1-8-4cd1ded85694@samsung.com>
 <CGME20240807110435eucas1p2eca071b0a0122b8686d43c57bd94dc8c@eucas1p2.samsung.com>
 <2024080717-cross-retiree-862e@gregkh>
 <dxkmmrlhlhsrjulnyabfgcr37ojway2dxaypelf3uchkmhw4jn@z54e33jdpxmr>
 <2024080720-skyline-recapture-d80d@gregkh>
 <20240807-mottled-stoic-degu-d1e4cb@lindesnes>
 <20240823225450.spuvjs5b5ruujim4@AALNPWDAGOMEZ1.aal.scsc.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823225450.spuvjs5b5ruujim4@AALNPWDAGOMEZ1.aal.scsc.local>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286sfGQOlJjcl
X-smtpcorp-track: zrxWjpeScoki.V2SW0FutR6jo.ryJc0AzmZIU

On Sat, Aug 24, 2024 at 12:54:50AM +0200 Daniel Gomez wrote:
> On Wed, Aug 07, 2024 at 05:46:03PM +0200, Nicolas Schier wrote:
> > On Wed, Aug 07, 2024 at 04:18:54PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Aug 07, 2024 at 02:13:57PM +0000, Daniel Gomez wrote:
> > > > > Also, as this is not internal for the kernel, but rather for userspace
> > > > > builds, shouldn't the include/ path be different?
> > > > 
> > > > Can you suggest an alternative path or provide documentation that could help
> > > > identify the correct location? Perhaps usr/include?
> > > 
> > > That is better than the generic include path as you are attempting to
> > > mix userspace and kernel headers in the same directory :(
> > 
> > Please keep in mind, that usr/include/ currently does not hold a single
> > header file but is used for dynamically composing the UAPI header tree.
> > 
> > In general, I do not like the idea of keeping a elf.h file here that
> > possibly is out-of-sync with the actual system's version (even though
> > elf.h should not see that much changes).  Might it be more helpful to
> > provide a "development kit" for Linux devs that need to build on MacOS
> > that provides necessary missing system header files, instead of merging
> > those into upstream?
> 
> I took this suggestion and tried pushing a Homebrew formula/package here [1].
> I think I chose a wrong name and maybe something like "development kit" would
> have been better. However, would it be possible instead to include the *.rb file
> in the scripts/ directory? So users of this can generate the development kit in
> their environments. I would maintain the script to keep it in sync with the
> required glibc version for the latest kernel version.
> 
> [1] https://github.com/Homebrew/homebrew-core/pull/181885

I think it sounds sensible to hold that formula file in the upstream tree.  But
I am not sure if scripts/ is the best location.

Masahiro, what do you think?

Kind regards,
Nicolas

