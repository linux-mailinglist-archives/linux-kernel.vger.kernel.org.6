Return-Path: <linux-kernel+bounces-445190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3701A9F127B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71991882BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAE81E5016;
	Fri, 13 Dec 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVsrAqmZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B301E47D9
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108310; cv=none; b=giUP4ZluYRat0g/a2qP18+09zGPyNT3G068F2xk2QvQF3Lf8R+MzPyXl1ATnsrBBJfI8iWYQx/XL2HOLXUVZGdiMq2mxV5RbjqGvwpnl17D82kjlNtNrC1iSrI1vK4bqYHel+GwvsVZpISE+0BI/87GZha2AixHKcMHYding2QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108310; c=relaxed/simple;
	bh=/VD5zNTaEBX+lKylddyxwJmb289UPss9JRnT94+IhTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtfE3zFsO/1nV9zMYogUH9I53csQ3AD2WReGhddjp8kpq10LMdjrKtUjnG5KwB/XXye5JXsNw8K7bg/lErBuxcTae02QTE5YG9BAXrjuSG/rtwAV8fcsME4NqiOU91ng48S0oeyZ4ysboFZNAtb20n+UWMYBEpmDbqH3yeXhexA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVsrAqmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB36C4CEDE;
	Fri, 13 Dec 2024 16:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734108310;
	bh=/VD5zNTaEBX+lKylddyxwJmb289UPss9JRnT94+IhTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVsrAqmZDOmvkun5l6ZiW3gWn0Zmmxyc0Ovkuz2Ebbwdl0wCsZlEjMBL+QORRQ+Ab
	 VUBnwVtgwGXewzXRrVqzP5WWBtnc91wSVJE2I1hX+BG0qiP0fcq36mLjIlEh+RHVsn
	 3CP2wcBszhUT3Co2gBgmmYB35/iomiIocwwnlrjG5YCbW3XXqBBkjQUXtkrWI6gP30
	 b8Luk/o5tJ7OV0I3ItNZSP1hS6p0967HrsiI7VzViOj868MV0OnauS8R0sZdvxEtU2
	 3jrlIyJzjoF/26ctzkzTgQjimxuid5jhSOXdu9fNMJbcSs3DdpECvhU5tyeyYGYaNH
	 NcMp6oqmbFSHw==
Date: Fri, 13 Dec 2024 16:45:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] arm64/signal: Silence sparse warning storing GCSPR_EL0
Message-ID: <418e279e-0628-473f-bd3c-4aa5e2d4dbcc@sirena.org.uk>
References: <20241211-arm64-gcs-signal-sparse-v2-1-c22f37216135@kernel.org>
 <Z1xgQGNZzR6h0Uly@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xOb+W1Cr2FbPnjyx"
Content-Disposition: inline
In-Reply-To: <Z1xgQGNZzR6h0Uly@arm.com>
X-Cookie: Not for human consumption.


--xOb+W1Cr2FbPnjyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2024 at 04:26:40PM +0000, Catalin Marinas wrote:
> On Wed, Dec 11, 2024 at 01:00:35AM +0000, Mark Brown wrote:

> > -static bool gcs_signal_cap_valid(u64 addr, u64 val)
> > +static bool gcs_signal_cap_valid(unsigned long __user *addr, u64 val)
> >  {
> >  	return val == GCS_SIGNAL_CAP(addr);
> >  }

> Another personal preference - addresses should be (unsigned long),
> pointer to be accessed (... __user *). But we could even scrap this
> function, there's a single caller to a one-line function.

I'm not sure I follow what you're saying here - the pointer here is an
unsigned long __user *?  The value in val is not a pointer or address,
it's a cap value derived from a pointer.  But yeah, we could inline and
render it moot.

> > -	write_sysreg_s(gcspr_el0 + 1, SYS_GCSPR_EL0);
> > +	write_sysreg_s((__force u64)(gcspr_el0 + 1), SYS_GCSPR_EL0);

> Looking through the code, do we have a similar problem in
> gcs_signal_entry()? Or do we rely on sparse ignoring (unsigned long)
> casts?

> Whichever way we go, I think we should have consistency between these
> two functions.

It's not coming up since there's a cast to unsigned long in there which
sparse likes, I can adjust that to a cast to __force u64 in there since
people didn't seem to like the cast to unsigned long.

--xOb+W1Cr2FbPnjyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdcZI8ACgkQJNaLcl1U
h9BnXgf9EssxRdLuAawqp39M6YvJ0vp5X5GHdEHBkTgo1jVeUnGmvTL9ppyfHa8G
KXz35/59ISi9u0oi8KEMVnj7AiTSSblwqXTHiw64jkuJYOjUcnNQ8+5HiDt/chDD
KJtaxPmOuHPqm8/iPmGImnBfIz27AD6MKtMpBbwJAz0HSyeVoxTK10F/KpB4Kozy
PB+JaJmDGTDhTy1e1xnX+8nfxqh5cpqw/SygSTBTp9LSFyv4fUdMZpmhOu6XrIfU
znJW590c3fg0sbeka+xJ2phM/QnsyI8e7N4Z16CZ8nRfiugNOJF5zFABmA77YYCI
zkQms/0LzFMjYZzmAvDcpajAhvgNBA==
=7XxV
-----END PGP SIGNATURE-----

--xOb+W1Cr2FbPnjyx--

