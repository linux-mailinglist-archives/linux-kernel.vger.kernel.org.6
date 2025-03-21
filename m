Return-Path: <linux-kernel+bounces-572060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27511A6C609
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC6848180D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C15231A3F;
	Fri, 21 Mar 2025 22:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvPDQUmQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8861F03D9;
	Fri, 21 Mar 2025 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742596686; cv=none; b=a7Io25vqkdumK2N/sOUOuDj5yPxKXMozLWgen7NRCeTnQMwdub6bS7Ksvy2zuHNucGOrJxuaoDdN8Ysi3Qkd5bUkDJQrjpbi57BMLtJcf0NyjhJ2eHaOiFb5PfIC4EU7pEXFQpO+SOqBY3tUteoczZuciBcshqu7fl71Ti7eNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742596686; c=relaxed/simple;
	bh=nrhlOP9d7PiSuMh7n2hu2MfcESZMoqXB6qfA5Gop3ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryGyiO+yOPlHqnkzl32BjQrVcWvY9myvkmJlHONnAZ2OY+1awvC9+vJIYIusZgR4RBjbrHGZ3x/1bJN+xY9+Po9exIXfAFEX/0OknI4RkkC0Pk9UcrBbCnk8zdhT0XpDo2uJWYbJeyJFHEwzP/h0SP2vSlRs0iOS+Pimr1vT8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvPDQUmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0678C4CEE3;
	Fri, 21 Mar 2025 22:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742596686;
	bh=nrhlOP9d7PiSuMh7n2hu2MfcESZMoqXB6qfA5Gop3ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvPDQUmQaW0p9015fBnH8HZXdTLUkmdLADBqQKLbS7FlDRPFGH+4JfV0HVGw6KQAC
	 wmwcwbEGwtCnCydbMEzrSt2Gz+tX8sOLIZwUEKHXNcV+D0Uj31YCyrPOutld6t5/jZ
	 BSA8ezCJJTY0rIszLxTweXNzX2i4EqhVhsBAN4l2bQscz4zELe3XZY0yRvMzlMndYJ
	 noWdHFhX/Dxt1YnYfGLd7iVzo6Px9LZ8Vw/CNrpAdASoSz9RSZia0ewtKKGq/vxbz2
	 FnD9b/0Ugx4zOF9FNU6amX5e6449rfRPQyuhDkerWMASxsNOAaYde4I08qOFAhYbIa
	 mO2VWaz+83vHA==
Date: Fri, 21 Mar 2025 22:38:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Eric Lin <eric.lin@sifive.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
	will@kernel.org, mark.rutland@arm.com, tglx@linutronix.de,
	peterz@infradead.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	zong.li@sifive.com, greentime.hu@sifive.com,
	vincent.chen@sifive.com, Nick Hu <nick.hu@sifive.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Message-ID: <20250321-spinal-endocrine-aabd38734c32@spud>
References: <20230720135125.21240-1-eric.lin@sifive.com>
 <20230720135125.21240-2-eric.lin@sifive.com>
 <20230720-slept-guru-216e2803061e@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7UoAQXoEu0XzRgDv"
Content-Disposition: inline
In-Reply-To: <20230720-slept-guru-216e2803061e@spud>


--7UoAQXoEu0XzRgDv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 06:10:51PM +0100, Conor Dooley wrote:
> On Thu, Jul 20, 2023 at 09:51:19PM +0800, Eric Lin wrote:

> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: sifive,pl2cache1
> > +      - const: cache
>=20
> You omitted the pl2cache0 from here, that needs to come back! You'll end
> up with 2 items entries.
> Either way, I can't take this binding without a soc-specific compatible,
> per sifive-blocks-ip-versioning.txt..

On this last point, what Nick Hu has done for the clint2 would be
acceptable, adding a {} entry to disallow the compatible in isolation
without requiring a soc-specific compatible for hardware that does not
yet exist:
https://lore.kernel.org/all/20250321083507.25298-1-nick.hu@sifive.com/

Maybe that'll allow you to submit a v3 of this work?

Cheers,
Conor

--7UoAQXoEu0XzRgDv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ93qSAAKCRB4tDGHoIJi
0oUaAP9uzIey7liZb+Bjy1/CuZWjq+8Noa6ZaN/cM35WlmDg/AEA2z0nS1vm0ayX
GW2I1IyVpUNSK01K1FIhOgrUeQuXTA4=
=VwYy
-----END PGP SIGNATURE-----

--7UoAQXoEu0XzRgDv--

