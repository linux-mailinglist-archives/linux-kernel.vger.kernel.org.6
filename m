Return-Path: <linux-kernel+bounces-381576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35E29B0105
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31BC1C21633
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9F11FBF51;
	Fri, 25 Oct 2024 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6NC1LKL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B101B0F38;
	Fri, 25 Oct 2024 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855141; cv=none; b=Mpohzedzbr1z8bqxMzgrzeZlxvDqBwVEHKqXy4BeBWPwLQit978eZcK5oH//76v2llkx988adja6M9NwiNZWpfHDyV9XeiKhWpgu2a77mi59h1ygRRXD6ot87VPUBr6S6+P+Cjyw/cpAU2Z8Ta7KNRAng7QMEImkPMXvT+JK0G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855141; c=relaxed/simple;
	bh=P9pR+q5F91xYr7dOaIvmgSSPbgDYTgm85gUo3kHpsEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVtSoVc7BvZVdhE5aieJt8O6vwrx+/DMlIqRCRwamChXZ0DJTWbalOz9bc4r3231TWmoBdq0+jFidP1k9L95DZVG/yNGtM1BOupO4r57qarbWD7pxkSWVLRU86kgBNcO4oJDUZadkkPWGBhjBHsXos7ObNnYrZsAKn0KTHjAeY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6NC1LKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF55AC4CEC3;
	Fri, 25 Oct 2024 11:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729855140;
	bh=P9pR+q5F91xYr7dOaIvmgSSPbgDYTgm85gUo3kHpsEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O6NC1LKLmOHAu9E8o1L5ht3igVZd2x9mX+zPVeeU2Luh5irtDY/uaDOp41CsxfbI7
	 JrFc/M1NwCrgNVOY2JnPXbDmRkc5VTKb7gzzuHlF7QkqqZc6ej0w0XKbibcjO8N6lh
	 6G6Slnkei7OB9hKIImSJ+l/ug4AL7UW44KVkTXIhtXndtbNTVtTdW6/io3kXZSHot4
	 Lge67qqhNlFrnQC4JoVNa8ArPkbNcEQwonnoQfndZOZ5J2MBiBIKivpC6/Pwrjvr4q
	 x3R6/p3rWtQuTmFg8A+aMDkSnZp+3zjer/tIufzWprInK9514AFI/i6ZgzuLiOXHBa
	 cOkJm2Ar6zPVA==
Date: Fri, 25 Oct 2024 12:18:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <5f03685c-6805-49c5-a22d-4e602f5532f8@sirena.org.uk>
References: <ZxiN3aINYI4u8pRx@infradead.org>
 <20241023042004.405056f5@rorschach.local.home>
 <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
 <20241023051914.7f8cf758@rorschach.local.home>
 <8734km2lt7.fsf@mail.lhotse>
 <20241024010103.238ef40b@rorschach.local.home>
 <07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net>
 <20241024024928.6fb9d892@rorschach.local.home>
 <82eecf18-0a71-4c16-8511-bc52fb61f421@roeck-us.net>
 <20241024211149.4f0b6138@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jrILLbVKO04Qanai"
Content-Disposition: inline
In-Reply-To: <20241024211149.4f0b6138@rorschach.local.home>
X-Cookie: Often things ARE as bad as they seem!


--jrILLbVKO04Qanai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2024 at 09:11:49PM -0400, Steven Rostedt wrote:

> much more focused on code that is already in Linus's tree. Like adding
> a missing mutex_unlock() from an error path. How is it helpful to push
> something like that to linux-next?

How is it helpful to not push things to -next?  Pushing your unsent
fixes to a branch that Stephen can pick up costs you approximately
nothing so there's no meaningful downside but perhaps one of these days
some test system will find some issue and it's setting a good example
for those who don't (or can't) have the same detailed testing you have.

> > Note that I do collect known fixes in my 'fixes' and 'testing' branches,
> > primarily to have something clean available to keep testing. Linus even
> > pulled my fixes branch once directly because the responsible maintainers
> > didn't send pull requests to him for weeks.

> Or are you saying that it's helpful to "fix" linux-next before fixing
> Linus's tree? That way others will have the fixes too?

That's also true, it gets the fixes into the hands of people doing -next
testing faster which is hopefully useful to them.

--jrILLbVKO04Qanai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcbfp8ACgkQJNaLcl1U
h9BqIgf/eX68AlBxcKIgUZGYuP519F2FA70TnudPNI+LBmlem5vP/ipXbiMjI+93
NreFFQD8EDxSMYuFFbyVFxq/jEO67Taskd/GuqLu1MfnIPAT0PTK54O63qW7xtXR
5NTqbWvpsyypjiSTnMx4nBUpDEk/qxwyNcXWfmlvhkwli8pd5ckNxV+BZnNlZEZO
MZ+SodvWOrSvCAE8YrKvVvpJzq150J8M/xXWEkb/NjHPzyHTGk5fOWef6E4O0uB0
LUDunZHv8EexnoumFvMOwA0miQca36MzpAMJjhsRYXFTbmjp6LMKB2QxWZOCp5ep
gDpqFiTL4BLyv3sCbRLeNgef/lXeFg==
=Gw8D
-----END PGP SIGNATURE-----

--jrILLbVKO04Qanai--

