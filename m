Return-Path: <linux-kernel+bounces-435252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16DF9E751E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9176162E3B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7A520CCD7;
	Fri,  6 Dec 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUZhriGH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED44DBA20
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501212; cv=none; b=DhRX4aV/13Rl8vxSPC179QjAuGjP7PzYMmcih30TWrztdTNgcE3AZ4QDzVftUyD0Sg+tv5HG5oZ3PxQfI2IYzEBVHyaSRkyu48RxIM9WJGm8CWOfZbSeWVdKByK0d9wd1akHPEU3oMJ37remTggmQ3DqkxT3uHnrTIu/08wVoRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501212; c=relaxed/simple;
	bh=gToIYM+37jkKtK/Sbu0IwPGwvwqDSaBXiHsgZA/gUAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pS9lJaDVF7K/Kb7Pwu4p4d5bUKf1zv7T3E2Jm3QyLfYR6aOJkG1lVbf9//AaTAhqxVzUI2a8IAbAMS3mmw7bYgaqTF/lEu221LSk/UCVP1zTxY38iz3nnKbBLdxoahnnMQZ05Z8Ll/1fJGN6MX99O7mo/oB6HS/bVPNRQs3PEp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUZhriGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403D8C4CED1;
	Fri,  6 Dec 2024 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733501211;
	bh=gToIYM+37jkKtK/Sbu0IwPGwvwqDSaBXiHsgZA/gUAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUZhriGHwCOGUtnZPn6FC7saJhs6BKSmHqVG5AS+E0JB1T7WxDfeMpEbolQahWmV4
	 +/IvsXta9NDAgw02+PN2UCwNsn9gZ7EcEzwPrENYs2Vv191ztYUHRjTXw+lBe+c9Ic
	 odbaoVofPbb+z6qo3uRJPlLjvHkpPXpFKIIvFaH5hbkzMAoRG89g854UUjG8fG127a
	 4I04DzE5/U6OQjK/qkdEVVwAPxTAKAB2LS0I9ttpCOLbB7M9AkUDMA1KcR+1H7deLu
	 TFv1mG8eIAAlXUdkyPJgcjkxdssShLZNDvFIYmCLWfTfQ3uccoPRQtkhT+hkSm5eNH
	 lTXQ1kBPWpADw==
Date: Fri, 6 Dec 2024 16:06:45 +0000
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
Message-ID: <6456e0b7-08ae-4515-a7c9-734f50c9130a@sirena.org.uk>
References: <Y4Y/vEWe3dw0FPQH@sirena.org.uk>
 <cf9ea98a3263ffb8fc8b542888ad0ad680facfc7.camel@mediatek.com>
 <Y4jHAJgmz/P58Q/C@sirena.org.uk>
 <7023a2c7b471d6888d9079563a6c01f22599201f.camel@mediatek.com>
 <Y43e+EsNCrCpZSIH@sirena.org.uk>
 <dc50d0b21795acbcc44c77e5fd81e7cb92c65c67.camel@mediatek.com>
 <Y5ipwqzHKTK8UdlC@sirena.org.uk>
 <a699178dcef540fff5caae6291983a444886bff6.camel@mediatek.com>
 <00d5c728-3eb9-427a-bc60-5828c20fec09@sirena.org.uk>
 <b44319c9fabbea2e8c333191a0005ef5c4ec6b2c.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0Q96+HlCP5jtbeOt"
Content-Disposition: inline
In-Reply-To: <b44319c9fabbea2e8c333191a0005ef5c4ec6b2c.camel@mediatek.com>
X-Cookie: Sales tax applies.


--0Q96+HlCP5jtbeOt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 03:39:15PM +0000, Jiaxin Yu (=E4=BF=9E=E5=AE=B6=E9=
=91=AB) wrote:
> On Mon, 2024-12-02 at 13:16 +0000, Mark Brown wrote:
> > On Sun, Dec 01, 2024 at 05:15:45PM +0000, Jiaxin Yu (=E4=BF=9E=E5=AE=B6=
=E9=91=AB) wrote:

> > > So I want to ask if I can do it by just adding
> > > SOC_DAPM_PIN_SWITCH("Speakers") and SOC_DAPM_PIN_SWITCH("HDMI")?
> > > Correspondingly, dapm widget and route path need to be added. That
> > > is
> > > "SND_SOC_DAPM_SPK("Speakers", NULL)/ SND_SOC_DAPM_LINE("HDMI1",
> > > NULL)"
> > > and "{"Speakers", NULL, "Speaker"}/ {"HDMI1", NULL, "TX"}".

> > Yes, that's what I'd expect to see.

> So if I open the "HDMI Switch" amixer control, it will call
> 'hdmi_codec_startup', which in turn calls "audio_startup()"  in
> 'hdmi_codec_ops'. Conversely, if I close it, it will call
> 'hdmi_codec_shutdown', which in turn calls 'audio_shutdown' in
> 'hdmi_codec_ops'. Is this understanding correct?

The audio stream will still run, the DAPM path attached to it will get
shut down.

--0Q96+HlCP5jtbeOt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdTIRQACgkQJNaLcl1U
h9AR8gf9Hfqv5O8hW1VoO/+oNPx5CkfRkyZFsfXQTS4FYXeTZ9zcxTzV8bdgREIe
WVUSi00ehS2CCupQkffrSFfZHqk88wxKrrMFNQYcoDrekq/kUtbseBayFJgB6mQY
4NUYT/0mnejbXDk+qeiHI1f0UzygswelfRVu+TZ7exCG2UI7GJO2RYdL6fpItNpQ
F7ISvK9ldljmyAmqAbZ8Ol6tg2eNfbhESwdEGsGrx58UpFAWH/0Qb6G+T4tzPxQ+
3rMJvvwahR0VMHmVglGFRUneunLknVaycWRVne7jYBilbaRlWMGQQ4FVs8XLY45q
OE7ZqGZc2+b4p2bOuAcnSLIiQPRSsg==
=/TNF
-----END PGP SIGNATURE-----

--0Q96+HlCP5jtbeOt--

