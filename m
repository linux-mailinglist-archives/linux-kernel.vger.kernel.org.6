Return-Path: <linux-kernel+bounces-401767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE889C1EE3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DABAB22174
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA701F12EF;
	Fri,  8 Nov 2024 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="SKx0n5Eh"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E42F1E1C18
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074975; cv=none; b=CK4yNA+D4uTutV4VBjRQpN7qLR+itnWgH10EHH570hIAqzRSAvuOCEMhwZTicemXykdODDnkxO6o4yNseSa5IrmB/o6/e1Kgn6mH2/Hfb+3IshvNQ3YAmPtwKKFnUDfFnwACVhqIpjKinp3IKFB+gPNlDsy44iuKaWgkFpJOkkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074975; c=relaxed/simple;
	bh=3rXC/ZoZnLYpTtlpt1Vkvs68rQa1ilNcfZ88Q776zPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjag3sEwb4b+r7OXmu8Hxg4ea9VhCyy2yTaAG4H5qLcdSUHu47R2hEknyT0LGamYfuaN7iz95uDxPoab6ze19s6sD4WNw8VprnoiZ1RDizrJQ1YKttgYk3XLLMyzCH5qzm7tRXNFYA9YYYqe8xU8on0LCBJttP+agHV+QDTdavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=SKx0n5Eh; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eTfR9AhVV8McI4g4aOI6ukS+LiMUl23jlY0qQyPzn+s=; b=SKx0n5EhMqWfn+/C4Mo8k1ACYd
	DXJQeah3aR3Hd20oz1rmgnJ9vWJCRFOosRNEUlio9UcJ2oYXShmKcec+wC+oWCKPNUl++cSuhJ44e
	mwanlL6kp53EgD5b197zHXo4dcVOpGxDxxTNciz9BWhpw2phg+woANJYXIMR3K/s3tpRwJyYhVgvG
	ezPITg6HHnZtCK8BzlA1ZU/BO3uk0u1oWPIQMFOS723QGf2fRl5o0dIbIabmOkRuwpCZLchMeZKuM
	PSrcDGsvq+eC1v49Xc3U7h065Iv22j1+HzREdlaGtX+FR2NpsUufq60mFottxfYcGOF3MWeIhwBwV
	kgjhzZlQ==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9Pfp-0006aO-Qt; Fri, 08 Nov 2024 15:09:17 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/rockchip: dsi: Perform trivial code cleanups
Date: Fri, 08 Nov 2024 15:09:16 +0100
Message-ID: <10558711.nUPlyArG6x@diego>
In-Reply-To: <3734f6a5424e3537d717c587a058fc85@manjaro.org>
References:
 <cover.1731073565.git.dsimic@manjaro.org> <13633881.uLZWGnKmhe@diego>
 <3734f6a5424e3537d717c587a058fc85@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 8. November 2024, 15:05:02 CET schrieb Dragan Simic:
> Hello Heiko,
>=20
> On 2024-11-08 14:56, Heiko St=FCbner wrote:
> > Am Freitag, 8. November 2024, 14:53:57 CET schrieb Dragan Simic:
> >> Perform a few trivial code cleanups, to make one logged message a bit=
=20
> >> more
> >> consistent with the other logged messages by capitalizing its first=20
> >> word, and
> >> to avoid line wrapping by using the 100-column width better.
> >>=20
> >> No intended functional changes are introduced by these code cleanups.
> >>=20
> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >> ---
> >>  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 12 ++++--------
> >>  1 file changed, 4 insertions(+), 8 deletions(-)
> >>=20
> >> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c=20
> >> b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> >> index 58a44af0e9ad..f451e70efbdd 100644
> >> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> >> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> >> @@ -1379,7 +1379,7 @@ static int dw_mipi_dsi_rockchip_probe(struct=20
> >> platform_device *pdev)
> >>  	}
> >>=20
> >>  	if (!dsi->cdata) {
> >> -		DRM_DEV_ERROR(dev, "no dsi-config for %s node\n", np->name);
> >> +		DRM_DEV_ERROR(dev, "No dsi-config for %s node\n", np->name);
> >=20
> > this is all probe-related, why not convert to dev_err_probe?
> >=20
> > As the doc states [0], DRM_DEV_ERROR is deprecated in favor of dev_err.
> > So dev_err_probe would be the correct way to go?
>=20
> Thanks for your quick response!  Seeing that DRM_DEV_ERROR() is now
> deprecated (which I originally missed, in all honesty) makes me very
> happy. :)  I've never been a huge fan of the format of the messages
> that DRM_DEV_ERROR() produces.
>=20
> However, perhaps it would be better to keep these patches as-is, as
> some kind of an intermediate, limited-scope cleanup + bugfix combo,
> and leave the complete DRM_DEV_ERROR() --> dev_err()/dev_err_probe()
> conversion to separate patches.  I think it would be better to avoid
> a partial conversion, and I'll be more than happy to put the complete
> conversion on my TODO list. :)

But your patch-2 really just open-codes, what dev_err_probe is meant
to fix. So with going this way, you're sort of making things worse first,
until that second step happens.

Similarly, reflowing lines for things that get removed in a week do not
serve a purpose - those line-breaks have been that way for years
already.



