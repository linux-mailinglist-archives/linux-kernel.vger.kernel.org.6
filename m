Return-Path: <linux-kernel+bounces-335881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EAE97EBF6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E12F2B21987
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829351990B5;
	Mon, 23 Sep 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTppZf1D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF189196455;
	Mon, 23 Sep 2024 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096533; cv=none; b=dUpmvHD9qjMO829tnJUzdV6pZ5nlfHvugsKARVT1+sAYFAp4FD7VTRAw0YHT+LMdgWKT9Be0KAodhwSFJKLCzOs1Xz4c7VVlb1EtLxQM5XGCxMyKqNOzLk7e0hR0dE5rTBIlyC7SjVdrmisRMX3xmKm438XUvNtSTMj+5+FEeM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096533; c=relaxed/simple;
	bh=LJpXFxAsyclLpPrnQFALYOoymD20OOsa6hDvGfOP9k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwcoRjyikMFN1us/qvU8xiC9r/iabWcuW+ModD8UPxZUcMQPjIfKKfqvkCnHGgsQIS9TdIEKlYVptza8jwXhWieIgHvwqnxUlsauB5DwWyDhRFBYaLGbsb5vzYh+CNVfpn5wvqXaL5mcEpybviYyeDkywzavejdhfHafFA5Skwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTppZf1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AA6C4CEC4;
	Mon, 23 Sep 2024 13:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727096532;
	bh=LJpXFxAsyclLpPrnQFALYOoymD20OOsa6hDvGfOP9k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cTppZf1DkOP5h7AyTfvmyDxomRdQIFVNFW7VO6HFkPiH4HyaIibWkH6Gsx/twS7H0
	 fwJQRbX7cxNdvlkmTL57Unsy8LuwQEvOQZiuxoa9pkWbKMs6vLmUQeTuqglPMDNNEq
	 vUecpIHxkV/y1w/UvhwXVaDTYu69R6sDXgQcpYRK8qCdBJ8H/5ZDTlG1khhp+Aw0Lt
	 sIS1hEK+UGLfKQg/tzx7hnYlbTtL3KU8n/dfmWxx9G0OX6cV4ePduOvkf9mvU27B62
	 ZFwg66Cg3dbyrSYNbD+Cs8CcA7aMNT83ajp4L/1IgHUDBCgzYYbOI/GKmiU5bPsH2K
	 BC2OSnpQW8yGQ==
Date: Mon, 23 Sep 2024 15:02:08 +0200
From: Mark Brown <broonie@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	kernel@pyra-handheld.com, risca@dalakolonin.se
Subject: Re: [PATCH] ASoC: topology: fix stack corruption by code unification
 for creating standalone and widget controls
Message-ID: <ZvFm0Oa6g_pTjK8t@finisterre.sirena.org.uk>
Mail-Followup-To: "H. Nikolaus Schaller" <hns@goldelico.com>,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	kernel@pyra-handheld.com, risca@dalakolonin.se
References: <7eca678fa7faa9e160b998192e87220de81315c8.1726847965.git.hns@goldelico.com>
 <3ceac85f-e419-44b1-b04b-1d1cf99a3e87@linux.intel.com>
 <746AA9D5-9D53-4351-A534-B9F86A5B9B82@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k/wIB9H7eaiWlc3n"
Content-Disposition: inline
In-Reply-To: <746AA9D5-9D53-4351-A534-B9F86A5B9B82@goldelico.com>
X-Cookie: Editing is a rewording activity.


--k/wIB9H7eaiWlc3n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 23, 2024 at 10:07:48AM +0200, H. Nikolaus Schaller wrote:

> You can't store a 64 bit pointer in an 32 bit unsigned int without getting into trouble
> on conversion back :) That is what uintptr_t is intended for, but it is also just an
> unsigned long in linux/types.h. AFAIK it is defined by C99 as "unsigned integer type
> capable of holding a pointer".

Practically speaking the kernel C code assumes that uintptr_t is the
same size as unsigned long and there's a whole bunch of porting would be
needed if you want to change that.  unintptr_t is a relatively new thing
compared to the C that the kernel originally targeted.

--k/wIB9H7eaiWlc3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbxZs8ACgkQJNaLcl1U
h9CRXAf+MpGocDNd8ekJnlE+xoeKS1fzQs5LPYu0Lqsfs36ouGiDFwOdtIKFVjc3
c6SxAj36GLzTuTw499h55M3ocqSVwyXBYHfKr7qILMT5HxbK1HyWXZy7f8/fc4YO
1+jFVVZFc5NbA46SXxxUFbduL97nIpuUjwrelNfH8hwCarrffOMLl2htMcvfDcIZ
dXEYY/Phu6pECrX1X7YUJEgY3tywqqwdvkpXb79XUeI1kDlMXean+cAScgTFciLW
wl4bSh6W6DmY5x3Vv9JFQkJECnjEhDq/iiUkmAvOcKQ6KSDIOigj5mCMRiI68Htk
zrcfMffpxuyUkS5VBw8wiz7et6P1Zg==
=b1Y8
-----END PGP SIGNATURE-----

--k/wIB9H7eaiWlc3n--

