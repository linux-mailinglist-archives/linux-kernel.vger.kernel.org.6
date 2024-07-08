Return-Path: <linux-kernel+bounces-244514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7685C92A558
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C21B21ABC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00581422C8;
	Mon,  8 Jul 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tG5J7xrK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5178C9D;
	Mon,  8 Jul 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451105; cv=none; b=t5vGdJT3W45w5B+6creaaED2cr9bZs0zbezfZne1yDzhacxOdjalSXFUQ5BPUNoL5HfsmlP4B1FZzZbsAt+6vskzQjfq0sSCV0P1WwBUN/aY7n4JifcvIeb9cF7ph48XNSawjN2xxH2oO0unJMRaZxffugEAFsUERSR0kcys6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451105; c=relaxed/simple;
	bh=UezjPL3T/OnCXTBp0Y+/oH1ev/RmhW9z8IKaXU4tL0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEsqPyjwQi4JrAEHJGJmubY4sVv5M4m8VkVx+3AWCJ76a/d8I5+6IhcfwC5opFCzjehmGapHYl72pJpaXx4WFD5Ss8Qsgm/+h7EQt2a6iV7oXNHj7kM4c5gjFLn42jZ+2ygsHAtttUm21j6W3UCbAP4XXazMAHd1IIr9S8rklqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tG5J7xrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A794C116B1;
	Mon,  8 Jul 2024 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720451104;
	bh=UezjPL3T/OnCXTBp0Y+/oH1ev/RmhW9z8IKaXU4tL0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tG5J7xrKMKXjfrdzywSEEU68edCUx0b2WlZo9owO4MQoXFUjdT5xmgmR5Y9wCwckR
	 Y2KhZVTXP58z0mNAsXWSfFdt3qp4e0rr2H7W16fM6fI+Df6RfF5kAqwVryN8enEXut
	 MwmOR3BPuAZ4pNeYyIIXaT7qqN7sR432ICwTCNReiE7pubh91rnobWtj3sMWMV+g+U
	 z3E2LBQ1zB3QIicAK3RMI/fr0YiUtRiVkpvCp8K3iFIFgUR/DiodextZ4b8Hf+j/V0
	 9s7VvXLvmloztonCr0swBAqIrYtqxVwlc+O/+XQRVhSZkfi+9OEfE7CWG1AvtyouWp
	 fpTOE0RVhgCKA==
Date: Mon, 8 Jul 2024 16:05:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH] firmware: cs_dsp: Use strnlen() on name fields in V1
 wmfw files
Message-ID: <91fc7cb3-6a00-4b3b-abed-a3a41b191912@sirena.org.uk>
References: <20240708144855.385332-1-rf@opensource.cirrus.com>
 <de44f274-4e02-4c66-b784-41031e99c33e@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FJRKTcPs+sZ0rFsq"
Content-Disposition: inline
In-Reply-To: <de44f274-4e02-4c66-b784-41031e99c33e@opensource.cirrus.com>
X-Cookie: Many are cold, but few are frozen.


--FJRKTcPs+sZ0rFsq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 08, 2024 at 04:00:07PM +0100, Richard Fitzgerald wrote:

> Don't take this. It applies to 6.11 but not to 6.10.
> I'll try to sort out one that applies to new and old code, or
> send separate 6.11 and backport versions.

> Sorry about that.

git seemed to be able to figure out the context for 6.10 (I apply
everything with am -3).

--FJRKTcPs+sZ0rFsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaMABsACgkQJNaLcl1U
h9CkAgf+IM6nyhh313jQKBcO3PnBflDEBf25Duajbv1xDQK0DncEyWpkOgueuvie
RdCQg214wCJPCALfND/tzHHfPMcqoi+uraGIpdRDPM4V4jnMQ6k/TaPs+5jx4gjR
a8p17voU62DKumtQWr+G2CtdsByV3M7XK/+qM28W+NJGuFXCmbxRmgOajhAFr9zR
y8Ioftmk0fiE3DDeYXCm6S2qHql3PnDoD144PynUkzrLy0eBwmJZQoBxn9ttAIaX
FxGuaXRvWimj4+fFmKBZ71IV3YSaBW9rVSo+d1ldkKUQGNUNOEl8AuDtVz9eyuV5
VNfrT33uRnQB+tIlnuxuSAr1ednNGw==
=ftUo
-----END PGP SIGNATURE-----

--FJRKTcPs+sZ0rFsq--

