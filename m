Return-Path: <linux-kernel+bounces-439311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0DE9EAD87
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E1E1885E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F32723DEB3;
	Tue, 10 Dec 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="PL/M6RXV"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0AA23DE80;
	Tue, 10 Dec 2024 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824917; cv=none; b=c98AbMF+IF2Vbsbct9N8F8Jbxu6OYoA9HzFm3Nbwv3cpQnNaWZZU4VpIhmMwBCM5GFvCdAPA0J6xMbG24ZYL9CsYKrrwUAvFmuH/LqKz8sA+s4yEXt5ZuabwYg/UtsNGRXHIQFZYacgo7SzAPX1lS4ihngAKmUtTXC50Me0XWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824917; c=relaxed/simple;
	bh=qexxCczfr+X2BkZUf8yml6mLKO33dfcfABhJJJmF18c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnyD4aACjYFc9sKq5rDjMbUjLsoFLSqYjd5m13U3C8IlwUBlYmsTso8rjBy9EyBoetcv7o1rKbGP1sth56XJBu9PpgudSmh2srVetEjgJl9ZzwaD59paVNL4RvN36Yk5LaKPge5BYTQ+bcrcm+KaQvZoOuUkGgbmhZpIC6m1jTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=PL/M6RXV; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7r4xfSODKGy3g81bMhiMFOfk/EfRckjRbt+ZPVGFK4g=; b=PL/M6RXV0ShUZBMUNHiO5ZgItP
	apLiD0XeIwBENg5C3YZHRvB7etdwsQkW62AKHgcAt5QqwRPGytnr5gjgh9b4FVMT+eIQj5q7oBbrF
	PvMqnPXqlb8rMfX/A53ximn12OI8ob53r+fgcoasq6nZT0XjAHUyuQPUtbcMLjRe+y18yephfx3cE
	emwHQ+w6sK7y0D9vOBkLXZqzDyvadoDStZb2HoeRAgXFRBc/BONNTJpmpPQYSFvp7jSb+8Emav+0W
	Yt5NL6mUE9LpbcgYi1OhE2bpqvMCfT/nG9QC/Rdt5xM7r+gaw1PZGdpr5IP/ERpaobgInwSFN4nEj
	qXJk9vIA==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tKx3g-0003mj-0a; Tue, 10 Dec 2024 11:01:36 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Andy Yan <andyshrk@163.com>
Cc: Daniel Semkowicz <dse@thaumatec.com>,
 Diederik de Haas <didi.debian@cknow.org>, andy.yan@rock-chips.com,
 Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, quentin.schulz@cherry.de, rfoss@kernel.org,
 robh@kernel.org, tzimmermann@suse.de
Subject:
 Re: [PATCH v3 0/3] drm/rockchip: Add driver for the new DSI2 controller
Date: Tue, 10 Dec 2024 11:01:34 +0100
Message-ID: <2117643.K71DO8KEF6@diego>
In-Reply-To: <2d68155e.1e5b.193ae4616b9.Coremail.andyshrk@163.com>
References:
 <20241203165450.1501219-1-heiko@sntech.de>
 <CAA8EJprLA09NP0KAztc5eoAMkGcrom84jg_pcbNcwN0FAaSLrw@mail.gmail.com>
 <2d68155e.1e5b.193ae4616b9.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Dienstag, 10. Dezember 2024, 02:54:09 CET schrieb Andy Yan:
>=20
> Hi Dmitry,
>=20
> =E5=9C=A8 2024-12-10 09:45:11=EF=BC=8C"Dmitry Baryshkov" <dmitry.baryshko=
v@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
> >On Tue, 10 Dec 2024 at 03:22, Andy Yan <andyshrk@163.com> wrote:
> >>
> >>
> >> Hi Dmitry,
> >>
> >> =E5=9C=A8 2024-12-10 09:01:38=EF=BC=8C"Dmitry Baryshkov" <dmitry.barys=
hkov@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
> >> >On Tue, Dec 10, 2024 at 08:50:51AM +0800, Andy Yan wrote:
> >> >>
> >> >>
> >> >> Hi,
> >> >>
> >> >> At 2024-12-10 07:12:26, "Heiko St=C3=BCbner" <heiko@sntech.de> wrot=
e:
> >> >> >Am Montag, 9. Dezember 2024, 17:11:03 CET schrieb Diederik de Haas:
> >> >> >> Hi,
> >> >> >>
> >> >> >> On Mon Dec 9, 2024 at 4:06 PM CET, Daniel Semkowicz wrote:
> >> >> >> > On 03.12.24 21:54, Heiko Stuebner wrote:
> >> >> >> > > This series adds a bridge and glue driver for the DSI2 contr=
oller found
> >> >> >> > > in the rk3588 soc from Rockchip, that is based on a Synopsis=
 IP block.
> >> >> >> > >
> >> >> >> >
> >> >> >> > I did more tests with different LVDS displays. I tested follow=
ing
> >> >> >> > configurations with DSI/LVDS bridge:
> >> >> >> > - 1024x600@60.01
> >> >> >> > - 1024x768@60.02
> >> >> >> > - 1280x800@60.07
> >> >> >> > - 1366x768@60.06
> >> >> >> >
> >> >> >> > All of them worked without issues, except 1366x768.
> >> >> >> > With this resolution, video is blurry, and offset incorrectly
> >> >> >> > to the left. There are also repeating errors on the console:
> >> >> >> >
> >> >> >> >   rockchip-drm display-subsystem: [drm] *ERROR* POST_BUF_EMPTY=
 irq err at vp3
> >> >> >> >
> >> >> >> > In correct operation with other resolutions, there is no error.
> >> >> >> > I am not sure if this is a problem in your series or rather in=
 VOP2
> >> >> >> > driver.
> >> >> >
> >> >> >This really sounds like something is wrong on the vop side.
> >> >> >The interrupt is part of the vop, the divisable by 4 things likely=
 too.
> >> >>
> >> >> This is a hardware limitation on vop side:
> >> >> The horizontal resolution must be 4 pixel aligned.
> >> >
> >> >Then mode_valid() and atomic_check() must reject modes that don't fit.
> >>
> >> We round down to 4 pixel aligned in mode_fixup in our bsp kernel,
> >
> >What is meant by the "bsp kernel" here? I don't see it being present
>=20
> bsp kernel means downstream vendor kernel.
>=20
> >in the mainline kernel. So, if the mode is unsupported, it should be
>=20
> Will it be acceptable to add this round down in the mainline mode_fixup?

personally I'd like that.

I.e. the thing in the examoke above is an LVDS display, so has essentially
fixed resolution. So adapting the resolution may or may not be possible
(some for DSI or whatever) .

Doing that rounding-down AND emitting a dev_warn about that fact would
be preferrable to me personally, though I don't know if there is some
different precedent in other parts of DRM.


Heiko



