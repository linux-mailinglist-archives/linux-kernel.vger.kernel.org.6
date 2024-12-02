Return-Path: <linux-kernel+bounces-427587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 126679E0320
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FA8288C9B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBC720101A;
	Mon,  2 Dec 2024 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlUDTiqG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2CA200B9B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145417; cv=none; b=hC2EQYxBwMN5GsGmJafcfd60BCOML5bfaDXJj6u0deaCBjZCEftRSCyCdLmkMJf93c3IYh+uIN1XLVYuyCsDwwCwFrDglAns//GPMebI4ayrn5ikLP0z2Z1kOk9SG1Lzvl8qowSAQ6m0U6s4on7MxuWf39tJcg8CeSP/XLOQSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145417; c=relaxed/simple;
	bh=/VF+nWs6BWtLEi7pKkF8pL4507yNu1NwuQmjk0P5/9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAOxVffYmM1DrKC2I17IXjxRuXwblZYgh7hmdExpF3RTW8hK2o8GIz4+dXDK377mavgNQZjDZlTyvpV0xROlyklOakWW4W8OeJNQC80GkqcrZgMyZgy+azSf+GXq68Cf5i4X2TOg/wU2ckHPs420D5ArCzNHByZQNjY64Gd9jIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlUDTiqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CE9C4CED1;
	Mon,  2 Dec 2024 13:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733145417;
	bh=/VF+nWs6BWtLEi7pKkF8pL4507yNu1NwuQmjk0P5/9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TlUDTiqGqqVXsTcBbB9DY1Tj4GMlqBKCfLy4MRppqgoZ+hIXX+C1MxEj5vfH9GnPp
	 pZzbmEljazX/5Fp15FZzjtyQiV1ARa5cluHtszSCNK+WUICMjsXncH/i800kboib3d
	 5yO6V9WPYE2Gw6PKa8jvyRcXDRMhpGkyfykwfGepEd9RLlf9N+2uRYV1kfFkMrn1rb
	 va5YB+0NIfOs3QsVhKScTQ1SxXldUT4An8nqBvnsXywUZlmtQRVQHW/x/+juRJpXdN
	 +RZehDyE3RB5KB4msJrMpBXmF/iSnIGVeQI0SRdGYab574kPnU8kJRIi+YRG9yp/R8
	 u967dyf3w8Lgg==
Date: Mon, 2 Dec 2024 13:16:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Jiaxin Yu =?utf-8?B?KOS/nuWutumRqyk=?= <Jiaxin.Yu@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"ajye_huang@compal.corp-partner.google.com" <ajye_huang@compal.corp-partner.google.com>,
	Chunxu Li =?utf-8?B?KOadjuaYpeaXrSk=?= <Chunxu.Li@mediatek.com>,
	Allen-KH Cheng =?utf-8?B?KOeoi+WGoOWLsik=?= <Allen-KH.Cheng@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
	"andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"robert.foss@linaro.org" <robert.foss@linaro.org>,
	"Laurent.pinchart@ideasonboard.com" <Laurent.pinchart@ideasonboard.com>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Nicolas Prado <nfraprado@collabora.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 1/3] ASoC: hdmi-codec: Add event handler for hdmi TX
Message-ID: <00d5c728-3eb9-427a-bc60-5828c20fec09@sirena.org.uk>
References: <Y4Cysgk5Gic5ae9B@sirena.org.uk>
 <18c82f6f723cd97a9d6b9a7ff16c6ed62fd005d6.camel@mediatek.com>
 <Y4Y/vEWe3dw0FPQH@sirena.org.uk>
 <cf9ea98a3263ffb8fc8b542888ad0ad680facfc7.camel@mediatek.com>
 <Y4jHAJgmz/P58Q/C@sirena.org.uk>
 <7023a2c7b471d6888d9079563a6c01f22599201f.camel@mediatek.com>
 <Y43e+EsNCrCpZSIH@sirena.org.uk>
 <dc50d0b21795acbcc44c77e5fd81e7cb92c65c67.camel@mediatek.com>
 <Y5ipwqzHKTK8UdlC@sirena.org.uk>
 <a699178dcef540fff5caae6291983a444886bff6.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NG9fJ4QMkZ8167X3"
Content-Disposition: inline
In-Reply-To: <a699178dcef540fff5caae6291983a444886bff6.camel@mediatek.com>
X-Cookie: (null cookie


--NG9fJ4QMkZ8167X3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 01, 2024 at 05:15:45PM +0000, Jiaxin Yu (=E4=BF=9E=E5=AE=B6=E9=
=91=AB) wrote:

> So I want to ask if I can do it by just adding
> SOC_DAPM_PIN_SWITCH("Speakers") and SOC_DAPM_PIN_SWITCH("HDMI")?
> Correspondingly, dapm widget and route path need to be added. That is
> "SND_SOC_DAPM_SPK("Speakers", NULL)/ SND_SOC_DAPM_LINE("HDMI1", NULL)"
> and "{"Speakers", NULL, "Speaker"}/ {"HDMI1", NULL, "TX"}".

Yes, that's what I'd expect to see.

--NG9fJ4QMkZ8167X3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdNs0IACgkQJNaLcl1U
h9DGvAf+J3hwEq4x3bF91sZy15VQBvz/0kSF2J0M+KaBQnVVFXj/YCUp9AjHd9Py
svtvltKB2dzk8Cpzti6uG995Vi0ugqWdEFR57tDSFDzyMMEStcr/z+LYr8gmncxg
0kEyoQrLHpnucIqWa+IJ766YUIsU2FvSM5IP2ZDXfWUeSHI5fzUfpc5M9MrgZJut
JfoR0eE91G28dKk46pdE+WRc6xsPWl/jRqlgr492lZe5Qew7l8ZRdnvummrx0iDd
A4z1fW9cZXTepa9GisH8GziS6GP3C+qJWwsAgq+iaKvZ6tBcii8s0sSGVRWbvQQG
a7poRNcQYuwS88Fimgys4lWYbODVVg==
=weMB
-----END PGP SIGNATURE-----

--NG9fJ4QMkZ8167X3--

