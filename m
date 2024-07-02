Return-Path: <linux-kernel+bounces-237917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7019C923FE7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB231C239BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7931B5835;
	Tue,  2 Jul 2024 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pd1kgJmj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D971B581A;
	Tue,  2 Jul 2024 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929292; cv=none; b=s52VEheeCmJIxnnRcN/2D/h0U2YSmZYRMMwfjhokn7EGodjcOkXSX06SNSP777OwdW5dlemEycjHEb6rHMwUutujGDMplUGdcFOyh+ZyCsKHP/OWI0bGDnRwzwv62lVYPWIMB2Gxj2xkgNGYerCKYz/LfH4ziEG0mM9xGtPJRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929292; c=relaxed/simple;
	bh=FczaPhMPNC2StePC+oGnLGpU1tRFqdJWKJZyTLhC67U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zr3HgxjrX7fe8A2xHGj/kXXmLpdo2IoslogB9Rp8v2iwhbZEsJmo1+OUK3RMD0VR+bHmVuPviHIYhdnSvWBjVdJuD8omojswVOCdcex7hV8EWUUjkVkR2pcM5x0WChHKeZyNL8XSScCq/O//Zna4TgdoJ0q1HXJFIUw1necMyv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pd1kgJmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4831C2BD10;
	Tue,  2 Jul 2024 14:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719929291;
	bh=FczaPhMPNC2StePC+oGnLGpU1tRFqdJWKJZyTLhC67U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pd1kgJmjphvQZpFYPGN5fWrwFeCN4vdbE37IPda6u/ZDAXOjwNht89sKsRynFIoO5
	 ZN5AATxpTwAdDCt7Yi+IndVIPBtE4s+XjYj+x7ByM74y3HqRiXjZPvXS51qOLCC2lM
	 j17ah0qHZX3Bq3UW5yCU8RuIsteqSG03qgqseXAnspD7LiR+3egEEC0PBoj2jDXKT+
	 6ASk2Ke2SMX9WaI3K94tVueVY/ntVogA1vjm49Hty59Kja+OKIo94w5aNkf5kLTFDC
	 DaPq6hsfupejni532Qx7Ndp4hOvLcVctRKu1jSBihfHGR10tktG3plBWTMCUB0ZO6/
	 G28xOD4jn4paQ==
Date: Tue, 2 Jul 2024 15:08:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Wende Tan <twd2.me@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sami Tolvanen <samitolvanen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 4/4] RISC-V: Use Zkr to seed KASLR base address
Message-ID: <20240702-unissued-dreamlike-badd0fb75ab0@spud>
References: <20240701185132.319995-1-jesse@rivosinc.com>
 <20240701185132.319995-5-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x34tUiPHU+DtDFfq"
Content-Disposition: inline
In-Reply-To: <20240701185132.319995-5-jesse@rivosinc.com>


--x34tUiPHU+DtDFfq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2024 at 02:51:32PM -0400, Jesse Taube wrote:

> +/**
> + *  isa_string_contains - check if isa string contains an extension
> + *
> + * @isa_str: isa string to search
> + * @ext_name: the extension to search for
> + *
> + *  Returns true if the extension is in the given isa string,
> + *  false otherwise
> + */
> +static bool isa_string_contains(const char *isa_str, const char *ext_name)
> +{
> +	size_t i, single_end, len = strlen(ext_name);
> +	char ext_end;
> +
> +	/* Error must contain rv32/64 */
> +	if (strlen(isa_str) < 4)
> +		return false;
> +
> +	if (len == 1) {
> +		single_end = strcspn(isa_str, "sSxXzZ");
> +		/* Search for single chars between rv32/64 and multi-letter extensions */
> +		for (i = 4; i < single_end; i++) {
> +			if (tolower(isa_str[i]) == ext_name[0])
> +				return true;
> +		}
> +		return false;
> +	}
> +
> +	/* Skip to start of multi-letter extensions */
> +	isa_str = strpbrk(isa_str, "sSxXzZ");

Technically this could break with the old QEMUs that had "su" in the
single letter part, but at this point I think enough time has passed
that it does not matter.

> +	while (isa_str) {
> +		if (strncasecmp(isa_str, ext_name, len) == 0) {
> +			ext_end = isa_str[len];
> +			/* Check if matches the whole extension excluding version. */
> +			if (ext_end == '\0' || ext_end == '_' || isdigit(ext_end))

I'm also not entirely sure about the final clause here. If you have an
extension "foo" and "foo32b", you'd match on the latter, right? I don't
think any extensions like that at the minute (foo32b type stuff does,
but the "root" alphabetical part for a foo32b doesn't), but I also don't
wanna have to chase down bugs in a parser this early in the future! The
devicetree binding doesn't actually allow anyone to put version
information in the isa string, so maybe the thing to do is just drop the
isdigit() check, given we only support devicetree right now for this early
probing?

> +				return true;
> +		}
> +		/* Multi-letter extensions must be split from other multi-letter
> +		 * extensions with an "_", the end of a multi-letter extension will
> +		 * either be the null character or the "_" at the start of the next
> +		 * multi-letter extension.
> +		 */
> +		isa_str = strchr(isa_str, '_');
> +		if (isa_str)
> +			isa_str++;
> +	}
> +
> +	return false;
> +}

Otherwise, I think this is fine now. Thanks for the updates.

Cheers,
Conor.

--x34tUiPHU+DtDFfq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoQJxQAKCRB4tDGHoIJi
0k6uAP4h26hzrqUn8SQOtea5MoE7pVfXu05eNbYHvp84e0SVewEAtZqV1yZzenjn
RAoQXWnUc4/VGcwTElosMZrjivWItQY=
=D3gK
-----END PGP SIGNATURE-----

--x34tUiPHU+DtDFfq--

