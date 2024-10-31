Return-Path: <linux-kernel+bounces-390254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E739B7789
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3EB6B23CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8F41946CF;
	Thu, 31 Oct 2024 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5N/3ulf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A75B13F42F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367050; cv=none; b=AG3iOulIC9aYr4l+1qDUdtwCJMShgASEfzQfhPU/jhMMqQQTGSKESZM5q8NvZ7JKt+dbpWb4lrxJAQCFhD5Wb6taiymZlK8hnd+8thhKdXuvQQK0O6jxSq6ml/xHKjh03UTZKoThShgFM7hALTMb6/JglilrrqW4g6mTkPgNAYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367050; c=relaxed/simple;
	bh=z8IQtCmj33W86d21B+EaX/sCF/MzMV/EOSoJK7YNil8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mikaciu8Syrz11PfqFIlSBmzco1y9fgIW3GLod1q4qhhg/iIX3TvveOKMJm+ACH+eagyuUqkALLlOkkiA79HONCJSw4b4fesT5mnMRSFJJk+psNfmakqqjw2Sy1LF9iI31QjjSDjHUumaM0o38JPzZcpy74aJ9WCUatRXaiWCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5N/3ulf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F95CC4CED0;
	Thu, 31 Oct 2024 09:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730367050;
	bh=z8IQtCmj33W86d21B+EaX/sCF/MzMV/EOSoJK7YNil8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5N/3ulfWm/A8PLepngAlXzNbpeeLQfnD0G7bPYVYejO8c18/o7VmfMh7mFffzx+4
	 UFV7bLwarSbu0TNS1PFo+tlaarasjjtzs8zg3GCpGgQ7g6SsOj0SFJVVJcsK183JIB
	 AeaObIsRydHOpJubLMPInAlOpUzpSmSoH8Dzi2TqMc+6O+YMdQD5BOuhUqkEa1f9A9
	 KxLQw8yKQPcKs5xzDccNtxg/aiU2CwItZzATuR/tq8uQcjfoZursvtA1mTtCZAW6Je
	 rGjDnppAvxurWmixQVN2e3Yr7H1v7Fxq+iQNF1ggCOvYjoxUtxsheYs+NCc0veN/En
	 R2rku15wijgoA==
Date: Thu, 31 Oct 2024 10:30:47 +0100
From: "mripard@kernel.org" <mripard@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: CK Hu =?utf-8?B?KOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, 
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>, 
	"ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "airlied@gmail.com" <airlied@gmail.com>
Subject: Re: [PATCH] drm/mediatek: Drop dependency on ARM
Message-ID: <20241031-turkey-of-astonishing-reputation-d1de20@houat>
References: <20241029111309.737263-1-wenst@chromium.org>
 <d9177ba80fc78b1f74dc54260c0c43440ec5a804.camel@mediatek.com>
 <20241030-hot-peridot-falcon-57bdbb@houat>
 <0cfba5bdc9443fb4b9719c47ee93c2a467cc66bd.camel@mediatek.com>
 <CAGXv+5EWyGGKYo+NNQ3Ykd3QUUO2cOManSnhZQaVhhCnupNx=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="yyz2c2rl56su2opo"
Content-Disposition: inline
In-Reply-To: <CAGXv+5EWyGGKYo+NNQ3Ykd3QUUO2cOManSnhZQaVhhCnupNx=Q@mail.gmail.com>


--yyz2c2rl56su2opo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/mediatek: Drop dependency on ARM
MIME-Version: 1.0

On Wed, Oct 30, 2024 at 04:52:17PM +0800, Chen-Yu Tsai wrote:
> On Wed, Oct 30, 2024 at 4:48=E2=80=AFPM CK Hu (=E8=83=A1=E4=BF=8A=E5=85=
=89) <ck.hu@mediatek.com> wrote:
> >
> > On Wed, 2024-10-30 at 09:25 +0100, mripard@kernel.org wrote:
> > > On Wed, Oct 30, 2024 at 03:30:34AM +0000, CK Hu (=E8=83=A1=E4=BF=8A=
=E5=85=89) wrote:
> > > > Hi, Chen-yu:
> > > >
> > > > On Tue, 2024-10-29 at 19:13 +0800, Chen-Yu Tsai wrote:
> > > > > External email : Please do not click links or open attachments un=
til you have verified the sender or the content.
> > > > >
> > > > >
> > > > > The recent attempt to make the MediaTek DRM driver build for non-=
ARM
> > > > > compile tests made the driver unbuildable for arm64 platforms. Si=
nce
> > > > > this is used on both ARM and arm64 platforms, just drop the depen=
dency
> > > > > on ARM.
> > > >
> > > > Reviewed-by: CK Hu <ck.hu@mediatek.com>
> > > >
> > > > I find this days ago, but I don't know there is someone who apply i=
t.
> > > > Let this patch go through drm-misc tree which already has the bug p=
atch.
> > >
> > > If you are ok with this patch, why didn't you apply it yourself?
> > >
> > > I think that's very much the expectation, so it's probably took a whi=
le to merge.
> >
> > That's ok for me to apply it if drm-misc has no plan to apply it.
>=20
> I'm confused. The culprit patch is already in drm-misc. So this one has
> to go in drm-misc as well.
>=20
> I can try to apply it to drm-misc myself, or have a colleague assist with
> that. I'll let it sit for another day in case anyone has something to say
> about it.

Sorry, I was under the assumption that CK had drm-misc commit rights? It
should go through drm-misc indeed.

Maxime

--yyz2c2rl56su2opo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZyNORgAKCRAnX84Zoj2+
dirAAXwMtocqqWOLJX3eed/G1RYDirHeRZPuWU/rPZByXJzFkdOx2CbomE6jbcW0
37L5Zj0Bf3ZbGUBxEnKE2qlLavUFFw6P3brl86LznSy2iz0l7SD9zGdrx/ojiRkC
Vf2QI/XF3w==
=L+1s
-----END PGP SIGNATURE-----

--yyz2c2rl56su2opo--

