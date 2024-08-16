Return-Path: <linux-kernel+bounces-290435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 904CF9553C8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 01:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20CAFB21E83
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97596146000;
	Fri, 16 Aug 2024 23:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCgFhQKQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9735B661
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723851310; cv=none; b=uAsEDXpWZ8eE6OrFbmeAmQa7bCEwwUcZ4gMYAC21xufPjoISiWRjyWPPl16n0euCAl4MBsQeIxoceBI4G5Q8Q/50zmdYlp6WsSnhIHLfzfGlwIbqhSYLrmLOMXMIOr5fbiecl7knqSWpd9rn09LkO9QIZRIPnGTS8j5NMRb0IzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723851310; c=relaxed/simple;
	bh=8njhEJcKnY8cF1n7ynktfkj4MvqPou9P5TU/PPxixU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sieaB/K+Yw/P7RMf7Lgr7P5sX7/Q3tyaq6/lzY6nSWIFGb56spBFEEptZTzAftDWAgO9h8MGNS3CSP6B2Ya6y50IAxjl6FocgmXo1eXXBd+ZEI29OYIHROfr4lBZwpLpaRnAultJMOvK+uxKLJNGaxIkFfbb7eYcbne/Qzz+y8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCgFhQKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7C2C32782;
	Fri, 16 Aug 2024 23:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723851310;
	bh=8njhEJcKnY8cF1n7ynktfkj4MvqPou9P5TU/PPxixU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCgFhQKQS62kr/mjtm32b/1EtvGrGLA05X9alkOntwPCuQnVdq1P1BLz/rMmns6EE
	 QdA3WWlrWIM5UP3OlopAXKYoT8IhjYcqASqDeYca5bgz5xAjHQSePz8jis30srvmQo
	 vLXD3R0qK7kTi1djnQyl4KA7w8hzsBQIGViWfF7K3E0h961Q9v/6h+aVv0eKJmiAg2
	 0pjVlQan2uU74IPtFhIUMx6NFeeTJy6/z+F7NyUgnro/sZA7ugZAzymvHa4rIEKxvf
	 Nj21Ng7ltRZmdKTM9YbV/JFcXHKdim8lDU3nw0qMpdrlsn+ZxCiSgP9O+O1dqRH2WR
	 1PbdZ9vqu7MHw==
Date: Sat, 17 Aug 2024 00:35:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH RFC] regmap: maple: Switch to use irq-safe locking
Message-ID: <cd4c01db-961c-4afb-8b8a-8fc6efb91234@sirena.org.uk>
References: <20240814-regcache-maple-irq-safe-v1-1-1b454c5767de@collabora.com>
 <4a8c9f85-3785-4cbd-be9b-dc6da9bd7324@sirena.org.uk>
 <9cb322ba-4c08-474b-bdc2-d21cc1904ecf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rUIRmD8vR+exF2St"
Content-Disposition: inline
In-Reply-To: <9cb322ba-4c08-474b-bdc2-d21cc1904ecf@collabora.com>
X-Cookie: Are we running light with overbyte?


--rUIRmD8vR+exF2St
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 11:11:27PM +0300, Cristian Ciocaltea wrote:

> The deadlock scenario indicated by lockdep actually points to the lock
> acquired by regcache_maple_exit(), which has been triggered during module
> unload operation, and the lock acquired by regcache_maple_write(), in the
> context of vop2_plane_atomic_update() called within the DRM stack.

So still within the interrupt context then, and due to the fact that the
register has not been accessed outside of interrupt context.  Reading or
writing any cached registers used in atomic context on init should do
that and avoid the issue I expect.  In general if you're going to use a
sparse cache you should ensure it's populated during init, like I said
in the prior mail providing defaults is the standard way to do that but
just an access should also work.

--rUIRmD8vR+exF2St
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/4igACgkQJNaLcl1U
h9BeDgf/fan7wST7akKqMi9+qkN/0TQTIV+Llqn317xcf8p3R6g4rRB4tnqrRKg0
llza/wtZ1HsPEH3TRXuQwZGj7zU0ttDR2ucZ0e//bCfnkfYJvmrTuGwro5sRdgcW
cFd9dkHL//ud/dzd7VrgcgySnoWL2oV2PZaDrTxSEF9nt8wiSmtnr4nIgsy56La/
L5Hf9kOkKhEPuen/Egrc88Sa9ppvG9wzHFw+BtVkf2Ocg8Cs0DAHFqLcUuFufvsT
KuKda0BcBKwD9whaTfV8oPD8RvprpO0wiuxkfNaSO7KcBjaRriYSkGI1ViWHAsfk
QAOlNzJNn1QchgaaLAE+38Iuvvndgg==
=iApJ
-----END PGP SIGNATURE-----

--rUIRmD8vR+exF2St--

