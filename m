Return-Path: <linux-kernel+bounces-422897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE8A9D9FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E341B165F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734101DFE08;
	Tue, 26 Nov 2024 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="bcoPMmkj"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3E17591;
	Tue, 26 Nov 2024 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732663834; cv=none; b=gtVnyuO+JZGna2oS9jGM7GkrAGu5EtEZz6tpUHWG825bT6Lg0pdrL8Mu4A48Vas0y9rJds7TP53Wc+Jq1jfMS20HtGopHst0UigucegC3YmgfK4MKULUoQxlEFN5q2kHcJDBaB7qEbkf3Qi72laDv38wksXHUuLr0omP38Yx1PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732663834; c=relaxed/simple;
	bh=hDYPxd2Pt2u7e5CZXJFtoYM3vKlpULe57hkJs4a8pkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvBhsRP1eZNoEiLrFlpZJvhT0uKFNCDvIa8MXYCi4tp2JHhGVlg76PJKoYL8wA8klnHHc2COkIohk/9WGAbxoVr4XQNIuClTm7ftN5QwqZ8r4EZtwQB1Open9eAzHMeap04TKEqQv21xiED/KuEYc0cuqvGNFawzgukWDB4KBQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=bcoPMmkj; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Xyf254dyBz9slv;
	Wed, 27 Nov 2024 00:30:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	s=MBO0001; t=1732663821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmRa2YTf7+HcBwk+icW3h4HwmqbHVFZGBaXv+geFw/E=;
	b=bcoPMmkji07Iuo0TVZ10o9zea1sGE9W9NJRA0kr6rdiadeDueMR97ETiirMhFg3eE7c2/C
	f7hooB49yn9ePOP10ZB9p/e/EFXWj/pQG2MoOiM2jR8Njiu3UcYqZmF4Erwnh77QxDOpaC
	wkUzdvQUeZsPfLGYT1pJ6rRTNzrmhqtyOdkc1hANQZ5ApuP14DlvhJdKQyrsdukRENETpT
	HWaAf8OPcceUf7nMzahMGyvCEfXVGRurv16oZjlP/IxBSd2Nip/VJbtI4LlVn2HRjJuX+E
	sfbJp0xFhxuGnAvjufObISIsZKWwpUAPo/MF9f65v9UsCYiF6hx75aT47WvNqQ==
Date: Tue, 26 Nov 2024 17:30:15 -0600
From: Michel Lind <michel@michel-slm.name>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 perf-tools] perf MANIFEST: Add
 arch/*/include/uapi/asm/bpf_perf_event.h to the perf tarball
Message-ID: <Z0ZaB6AN3y8MfE8c@hyperscale.parallels>
References: <Z0Yy5u42Q1hWoEzz@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ibvFAdc/0LdZ7abw"
Content-Disposition: inline
In-Reply-To: <Z0Yy5u42Q1hWoEzz@x1>


--ibvFAdc/0LdZ7abw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 05:43:18PM -0300, Arnaldo Carvalho de Melo wrote:
> Needed to build tools/lib/bpf/ on various arches other than x86_64,
> notably arm64 when using the perf tarballs generated by:
>=20
>   $ make help | grep perf-
>     perf-tar-src-pkg    - Build the perf source tarball with no compressi=
on
>     perf-targz-src-pkg  - Build the perf source tarball with gzip compres=
sion
>     perf-tarbz2-src-pkg - Build the perf source tarball with bz2 compress=
ion
>     perf-tarxz-src-pkg  - Build the perf source tarball with xz compressi=
on
>     perf-tarzst-src-pkg - Build the perf source tarball with zst compress=
ion
>   $
>=20
> Building with BPF support was opt-in in perf for a long time, and
> testing it via the tarball main kernel Makefile targets in an
> architecture other than x86_64 was an odd case.
>=20
> I had noticed this at some point earlier this year while cross building
> perf to some arches, including arm64, but it fell thru the cracks, see
> the Link tag below.
>=20
> Fix it now by adding those arch/*/include/uapi/asm/bpf_perf_event.h
> files to the MANIFEST file used in building the perf source tarball.
>=20
FWIW - when testing against the architectures Fedora carry (x86_64,
aarch64/arm64, ppc64le, s390x) only the arm64 and s390 headers are
needed; see

https://git.centos.org/rpms/perf/blob/c9s-sig-hyperscale/f/perf.spec#_120-1=
28

(I would link to my Koji scratch build but Koji has some sort of glitch
right now)

It's probably safer to just include all headers just in case.

Thanks for this patch, it is really instructive in figuring out how perf
is put together!

Best regards,

--=20
 _o) Michel Lind
_( ) identities: https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc0=
4f2

--ibvFAdc/0LdZ7abw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRdzi5+nDsc/9M1wdeLIp0vfMwE8gUCZ0ZaAwAKCRCLIp0vfMwE
8vX/AQCzvrpWa59vsZ7EfxiQTJwN4wjIlXqEo77SHLz+z/t0BgEAsDmx7+64SYdP
3DMYEhnB6keZqr8A5OlgWKuUeWIq2gQ=
=gDJA
-----END PGP SIGNATURE-----

--ibvFAdc/0LdZ7abw--

