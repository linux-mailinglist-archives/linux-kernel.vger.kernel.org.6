Return-Path: <linux-kernel+bounces-177830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662138C4518
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8776A1C22269
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F75155386;
	Mon, 13 May 2024 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNkZuFVT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12587155344;
	Mon, 13 May 2024 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617716; cv=none; b=nCiB0hlxFVjIWA3JWCfBQXMbtG4sUYPxqGIVkME3sGQgsGKykLqEbInmt25l/bwsNxJSqhasUkQG3K8/Uae4izQZQ8LH2z85PZpYz9l9zrmfkm0KpSCCHqivhtta+/TsQYoQD3aUhCU4uakkc+dZ0TbPtGYOS13yl8y+SUAJKhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617716; c=relaxed/simple;
	bh=dreGzymTKJvTE2xPwadAY/8dXCucGzSp5e1CjkI9194=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBHKoG2Yg3p8ftZ8l8y3Y/l2OZpKP3VHLwy6MJCg3hnvO2Uu1dVKUCKqoaXcgkx8siGg1ZKE6n0wl0OAgLz7Oszn6jZU2GPyCTPcQvPOSzrDYqTFRY0SR32mZfnsdR1ud5ebwhoDblGZZ3ZmRVr0JvCvZ5lZgK4iSJ2jqDFU0qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNkZuFVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FCCC113CC;
	Mon, 13 May 2024 16:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715617715;
	bh=dreGzymTKJvTE2xPwadAY/8dXCucGzSp5e1CjkI9194=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNkZuFVTgpilJnrk8k42qcAleha/WbDDTTi4Qgq1tTQkm/Ebiz7FPNf4ikKCYaseZ
	 7N/pgS2dC5ti1KaPZSiSLdW/c6tTGcnFlO62YIXDDWkRxvldaFiXI/Srbw/GdDaOSK
	 DaayMNussMq2hVzzqpQ4sQVLtgVw5hUd3e5iOowyHxXbnwpZZeSn3IPbrE4xjB9JQ5
	 UEBlb/U+w8eMMvj4P/3IvFENgPyKzxEFpGfobya5R1G/vQmxTvV5/tySFTFP9RkkuQ
	 cuN7q1aKqATShYTqcCv+FfOEphVxJJQx/WaucdXMtNgpqQZRnZFj3XD/7kEz30I3nC
	 N/zGUS/lTIcUw==
Date: Mon, 13 May 2024 17:28:29 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: CK Hu =?utf-8?B?KOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"wenst@chromium.org" <wenst@chromium.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	Shawn Sung =?utf-8?B?KOWui+WtneismSk=?= <Shawn.Sung@mediatek.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	Jitao Shi =?utf-8?B?KOefs+iusOa2myk=?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"kernel@collabora.com" <kernel@collabora.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	Yu-chang Lee =?utf-8?B?KOadjuemueeSiyk=?= <Yu-chang.Lee@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
Message-ID: <20240513-papaya-bagged-8f01503b0a22@spud>
References: <4dfb09b9c437ab2baa0898eca13a43fd7475047a.camel@mediatek.com>
 <46347f5d-e09b-4e83-a5a2-e12407f442a4@collabora.com>
 <847e1a84b532956f697d24014d684c86f0b76f03.camel@mediatek.com>
 <cbf73111-a6cf-47da-9563-89d49fbdb17d@collabora.com>
 <ee721fd3339f8b3a25464ca57ca192343a51e514.camel@mediatek.com>
 <34caf545-1fc9-4905-a82f-2596f053b3ff@collabora.com>
 <de23d55dd1c84bf9b04119014c3785189ce6f9da.camel@mediatek.com>
 <c384946a-e151-4afb-82f7-d31a5a26aff6@collabora.com>
 <5b0ed6dd7190496d70fe625ac9b4539eb0181c0a.camel@mediatek.com>
 <6796f082-dfbe-45dc-bd01-3c9b4ac73865@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aZdOAVgj7H5otCBg"
Content-Disposition: inline
In-Reply-To: <6796f082-dfbe-45dc-bd01-3c9b4ac73865@collabora.com>


--aZdOAVgj7H5otCBg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 03:44:00PM +0200, AngeloGioacchino Del Regno wrote:
> Il 13/05/24 08:15, CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89) ha scritto:
> > On Fri, 2024-05-10 at 12:14 +0200, AngeloGioacchino Del Regno wrote:
> > > Il 10/05/24 11:34, CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89) ha scritto:
> > > > On Thu, 2024-05-09 at 11:27 +0200, AngeloGioacchino Del Regno
> > > > wrote:
> > > > > Il 09/05/24 07:42, CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89) ha scritto:
> > > > > > On Wed, 2024-05-08 at 15:03 +0200, AngeloGioacchino Del Regno
> > > > > > wrote:
> > > > > > > Il 08/05/24 09:19, CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89) ha scr=
itto:
> > > > > > > > On Tue, 2024-05-07 at 16:07 +0200, AngeloGioacchino Del
> > > > > > > > Regno
> > > > > > > > wrote:
> > > > > > > > > Il 07/05/24 08:59, CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89) ha=
 scritto:
> > > > > > > > > > On Thu, 2024-05-02 at 10:50 +0200, AngeloGioacchino Del
> > > > > > > > > > Regno
> > > > > > > > > > wrote:
> > > > > > > > > > > Il 25/04/24 04:23, CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89=
) ha scritto:
> > > > > > > > > > > > Hi, Angelo:
> > > > > > > > > > > >=20
> > > > > > > > > > > > On Tue, 2024-04-09 at 14:02 +0200, AngeloGioacchino
> > > > > > > > > > > > Del
> > > > > > > > > > > > Regno
> > > > > > > > > > > > wrote:
> > > > > > > > > > > > > Document OF graph on MMSYS/VDOSYS: this supports
> > > > > > > > > > > > > up
> > > > > > > > > > > > > to
> > > > > > > > > > > > > three
> > > > > > > > > > > > > DDP
> > > > > > > > > > > > > paths
> > > > > > > > > > > > > per HW instance (so potentially up to six
> > > > > > > > > > > > > displays
> > > > > > > > > > > > > for
> > > > > > > > > > > > > multi-
> > > > > > > > > > > > > vdo
> > > > > > > > > > > > > SoCs).
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > The MMSYS or VDOSYS is always the first component
> > > > > > > > > > > > > in
> > > > > > > > > > > > > the
> > > > > > > > > > > > > DDP
> > > > > > > > > > > > > pipeline,
> > > > > > > > > > > > > so it only supports an output port with multiple
> > > > > > > > > > > > > endpoints -
> > > > > > > > > > > > > where
> > > > > > > > > > > > > each
> > > > > > > > > > > > > endpoint defines the starting point for one of
> > > > > > > > > > > > > the
> > > > > > > > > > > > > (currently
> > > > > > > > > > > > > three)
> > > > > > > > > > > > > possible hardware paths.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Signed-off-by: AngeloGioacchino Del Regno <
> > > > > > > > > > > > > angelogioacchino.delregno@collabora.com>

One of you guys, probably =E8=83=A1=E4=BF=8A=E5=85=89, has a mail client th=
at is completely
mangling these quotes. Can you try to fix that please? It makes reading
the thread unfun :/

--aZdOAVgj7H5otCBg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkI/rQAKCRB4tDGHoIJi
0jwnAP9uirCN5nWb54TXI+oti65ABU7175drHSW8qsorNLLmJAD+LES8EPnVXHkZ
ntqNSxhNBnabta4KQYednD8SAoWwyAw=
=uI9h
-----END PGP SIGNATURE-----

--aZdOAVgj7H5otCBg--

