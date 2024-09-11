Return-Path: <linux-kernel+bounces-324795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21139750F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A071C20890
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09EC187327;
	Wed, 11 Sep 2024 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikvqh6Rl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056C715C13F;
	Wed, 11 Sep 2024 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054882; cv=none; b=dteKcQK4DJp4aVtTeUBHDeg64Qi+uZJdm73r80hGlZhM1+TFOxzcKp1azstXNgH1dNB+//tTXwFdGDe/Xy4cr8eHQkdCan27nrI/nT75rgltIAmqeTvaRcKPBPuZ7pBn7hMghO4PIuJb4N10P2DV4nqFwGPfCKV37AjCrDGdrDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054882; c=relaxed/simple;
	bh=9Ff5CcqOR1YG6EDTYOSXZ/lMsTO4cJ1WRyPod0s+/9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEQ1vxoppB5rSFcav05956kfEPZJcWvCrde+a186k2jPqetpSE6T0MqbKTWklQ9gEvQjUWuys4uQvfc50UV/v3JT0KYGCJo4HAcY5wyeb7mzvOu4338rgRVWnxmVjMxQ1C27n5ZPpoyFDPyOpafjh9Yfy+Y4jI0sEmYn+ZkToxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikvqh6Rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FF0C4CEC5;
	Wed, 11 Sep 2024 11:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726054880;
	bh=9Ff5CcqOR1YG6EDTYOSXZ/lMsTO4cJ1WRyPod0s+/9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikvqh6Rlp/kPJjy8jzBlCQj051T+9r0X7WTLZPJ7utoxrHvi5Sip0LAdo+Thsm9v3
	 kwdh5CALo8Ka5NiLx/SaZoyguMVGXDMag1w2JQoHPMlVpEVbjHmUIp7VhIMs1CzlT/
	 r3JErK+tfK+KF+5BjX4gdFaAlHVrE/j6YA4zk2rf9Mm+vJP3Nm6QPsgHINBvpSQt2H
	 DMsxshlW583pu+sjody+JZcGB9+T9b3vI0SvGs3dMWL/NJEVADyDpLmPug+4gV8RMf
	 1MeRopd/pCbi0SnuUSgLW1ze/6YezqUsHW3unS9fzeukYA9+HR1eDW1GJBMKXshL5T
	 45v4DNvvv/s4w==
Date: Wed, 11 Sep 2024 12:41:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: amergnat@baylibre.com, angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com, matthias.bgg@gmail.com,
	linux-sound@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: mt8365: Fix using uninitialized value "i2s_data"
 issue
Message-ID: <eb21bcab-333d-4ab3-9222-058764ced720@sirena.org.uk>
References: <20240911001516.47268-1-qianqiang.liu@163.com>
 <9ea8731a-7888-40a2-a183-4598884bbb27@sirena.org.uk>
 <ZuGAwQGPWdpO1-G9@iZbp1asjb3cy8ks0srf007Z>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q51in4Tbj9DzVb7D"
Content-Disposition: inline
In-Reply-To: <ZuGAwQGPWdpO1-G9@iZbp1asjb3cy8ks0srf007Z>
X-Cookie: No Canadian coins.


--q51in4Tbj9DzVb7D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2024 at 07:36:33PM +0800, Qianqiang Liu wrote:
> On Wed, Sep 11, 2024 at 11:52:58AM +0100, Mark Brown wrote:
> > On Wed, Sep 11, 2024 at 08:15:17AM +0800, Qianqiang Liu wrote:

> > >  	spin_lock_irqsave(&afe_priv->afe_ctrl_lock, flags);

> > > +	if (!i2s_data) {
> > > +		spin_unlock_irqrestore(&afe_priv->afe_ctrl_lock, flags);
> > > +		return;
> > > +	}

> > Why would we look up i2s_data without the lock, take the lock, then
> > check if we actually found it?  That doesn't seem right.

> Just check the "i2s_data" is NULL or not.

That doesn't address my question at all.

--q51in4Tbj9DzVb7D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbhgdsACgkQJNaLcl1U
h9Dd+gf/XpYSVrJXYWSZflF2+Mnro1CePEcrfJpjk4v4ucJNLSTRozAKskqvZSff
XEiSPDRVj7jAqLSduflUTvv8faamui4SZinWSq4v1uRg2hQChLrdoeJZy2YD+Z4r
YAaAFfwBN1XYv1H0LDZG29/oqK0/3DKRWsU2fjkdb0AQEiZt96pQiGJR6LzXAeLK
xTVd2ifwALsRNNFouHFtgajOyybitV80htpkLCkpnqz3kg5ApT3TK7fBqSNLss8r
8RfcnfrCMC749oBl55oioH+uedaM+w+WXDn7BhKlz2GcU2O6AdHxBOirJOlUgJqK
aDP1+jhRqBgYvIuZVOloGOyHyf0uQQ==
=0dpD
-----END PGP SIGNATURE-----

--q51in4Tbj9DzVb7D--

