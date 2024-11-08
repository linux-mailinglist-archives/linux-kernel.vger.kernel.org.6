Return-Path: <linux-kernel+bounces-401781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC139C1F16
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC76E1C23016
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9A81EF0A8;
	Fri,  8 Nov 2024 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="lOrhdASv"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC51401C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075784; cv=none; b=iun7xP86J7tNx6UHTikPSizm6e0Jh+W6DnzbCeSSMD5TmZOq6hi2ew7ok7jmzSwlr/71iVaStoX57Pu9E4AbEkJMln/3oYCr5JLlsk0Mx0af7Ddvs/a9N0gOGRjJZ5yAex7NBlLOZtZ9EOoFx1Ibmzn2xgOX43IzocYku3/0Ni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075784; c=relaxed/simple;
	bh=a4me9NEi48xs/Gv9LqD6QXla8QM2Yfu0bCPFDTc7gjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7xCXtL11MDu11iDzsCx2expF/VnTZbS4fCrjGxR6JORVePl0A8iJShrychOP+0vUYIS8pevHmv94nqZjsGQqgK+z/Br+zWVie8yw/WW2CXTCm03D75v0wjW7q9ILPdgaTi4agLIgw8uIu4kTMbo9rUStpCxE+tpCTx4RWwsdAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=lOrhdASv; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=03Fc1fmCF/avRthU6lr7E9Jhe4IxFOTMxCL1KW92V/s=; b=lOrhdASv7gsImU9H6JBn4Q7VGa
	XTYrdXLQU1uFqre8mwmKTU7BL2IA7FOr7KlJ76A1TbEIegqSCvTSXNKT/l9kZMWoTxTpYx27f7Lll
	qy0ozFX8Xg7whfsMOBbBdnbdTbZTFzikQIkEahETI5qUNDkcju+wqjl7d3+kiLr39B02sOsphjH3z
	ostzHmMz/d9kSIVBTyJPXTeKs6UZAj4GEreNDzVcy+ZgNs1IjUZQ6sKLYeMkFdvcAa0QKVMrT1Ivn
	fHaWaUXlB5+aXZwemkFDJsQGjoS9Uwhb+LB2BNe/7o+20laNwsWIGnD/bkKQexJCELnxmRN1tG7Ju
	xbmAkMGw==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9Pso-0006fc-4s; Fri, 08 Nov 2024 15:22:42 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/rockchip: dsi: Perform trivial code cleanups
Date: Fri, 08 Nov 2024 15:22:41 +0100
Message-ID: <22484879.EfDdHjke4D@diego>
In-Reply-To: <047164cc6e88dcbc7701cb0e28d564db@manjaro.org>
References:
 <cover.1731073565.git.dsimic@manjaro.org> <10558711.nUPlyArG6x@diego>
 <047164cc6e88dcbc7701cb0e28d564db@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 8. November 2024, 15:13:33 CET schrieb Dragan Simic:
> On 2024-11-08 15:09, Heiko St=FCbner wrote:
> > Am Freitag, 8. November 2024, 15:05:02 CET schrieb Dragan Simic:
> >> On 2024-11-08 14:56, Heiko St=FCbner wrote:
> >> > Am Freitag, 8. November 2024, 14:53:57 CET schrieb Dragan Simic:
> >> >> Perform a few trivial code cleanups, to make one logged message a b=
it
> >> >> more
> >> >> consistent with the other logged messages by capitalizing its first
> >> >> word, and
> >> >> to avoid line wrapping by using the 100-column width better.
> >> >>
> >> >> No intended functional changes are introduced by these code cleanup=
s.
> >> >>
> >> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >> >> ---
> >> >>  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 12 ++++--------
> >> >>  1 file changed, 4 insertions(+), 8 deletions(-)
> >> >>
> >> >> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> >> >> b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> >> >> index 58a44af0e9ad..f451e70efbdd 100644
> >> >> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> >> >> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> >> >> @@ -1379,7 +1379,7 @@ static int dw_mipi_dsi_rockchip_probe(struct
> >> >> platform_device *pdev)
> >> >>  	}
> >> >>
> >> >>  	if (!dsi->cdata) {
> >> >> -		DRM_DEV_ERROR(dev, "no dsi-config for %s node\n", np->name);
> >> >> +		DRM_DEV_ERROR(dev, "No dsi-config for %s node\n", np->name);
> >> >
> >> > this is all probe-related, why not convert to dev_err_probe?
> >> >
> >> > As the doc states [0], DRM_DEV_ERROR is deprecated in favor of dev_e=
rr.
> >> > So dev_err_probe would be the correct way to go?
> >>=20
> >> Thanks for your quick response!  Seeing that DRM_DEV_ERROR() is now
> >> deprecated (which I originally missed, in all honesty) makes me very
> >> happy. :)  I've never been a huge fan of the format of the messages
> >> that DRM_DEV_ERROR() produces.
> >>=20
> >> However, perhaps it would be better to keep these patches as-is, as
> >> some kind of an intermediate, limited-scope cleanup + bugfix combo,
> >> and leave the complete DRM_DEV_ERROR() --> dev_err()/dev_err_probe()
> >> conversion to separate patches.  I think it would be better to avoid
> >> a partial conversion, and I'll be more than happy to put the complete
> >> conversion on my TODO list. :)
> >=20
> > But your patch-2 really just open-codes, what dev_err_probe is meant
> > to fix. So with going this way, you're sort of making things worse=20
> > first,
> > until that second step happens.
> >=20
> > Similarly, reflowing lines for things that get removed in a week do not
> > serve a purpose - those line-breaks have been that way for years
> > already.
>=20
> Hmm, it makes sense when described that way.  I'll see to perform the
> complete conversion in the next few days.

just a note, as written on IRC earlier, I am sitting on a dev_err_probe
conversion for dw-dsi-rockchip.

I was waiting to see if more cleanups turned up, so didn't sent that yet.

Don't want to steal your spotlight though, so not sure if I should send
that or wait for your conversion ;-)


Heiko




