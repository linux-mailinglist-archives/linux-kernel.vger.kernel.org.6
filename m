Return-Path: <linux-kernel+bounces-449421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5C69F4EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDA616EA2E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CE11F755F;
	Tue, 17 Dec 2024 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqQWliJY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611881F7081
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447744; cv=none; b=np9eaDUGBZDF79j6/j1es5o+/tXcG+gbXjf1Yw5fLB7k73J97c0i0/2U637MJI6gRafEHTFpDz/qFf70zmOtu6qrOjP/StPoPISqaCHGUCbRBoVdGC3sgJV88p3il5NZE2qBTcMN8+d6yUKAcGCjvUN2Od8KB4MXNQ3s54DPLwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447744; c=relaxed/simple;
	bh=ARZxDTKwcrtJRmGfSLGzQJE1LGMCzV+FHKBTe+Cfy1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+iYuTM7BcBO3iUm+Ve1AcTaiCbYjFmDlLL7Xtv3SWA4udXtEekfM+dwG+E6x7rnKJOn7+NbFAOh1wxSyP1t3DSd6H57i+2mzK3FULXa9psXt3inHQCyXzfd1hvf3s41v5G2En3CnJLLCX8eTdsi7OKJ9SaWBrkw5jwl1tmlaKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqQWliJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D8EC4CED3;
	Tue, 17 Dec 2024 15:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734447743;
	bh=ARZxDTKwcrtJRmGfSLGzQJE1LGMCzV+FHKBTe+Cfy1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqQWliJY0C9K4Xu+VSJPhnAIlil4VSlAt8+nzsmVua4BVFT95zgqOc4XpryJV81iT
	 CtRVQUSMLfZoSSf0+wdVrkGMI8ahToWUnzgg+3xXVQTnqm95Hl6PJDHiI78/XHEPXc
	 q6ONHxtFQ3J62oGccTBrhbS3EwJCzimZ1XPX1u9hcnbXeu2L+HaLv0pmrrSSjgf8hr
	 diOSb/Gt9ydHj7lDiwRSkmoOiswfWjSlkZBvUnmeZY99s48OBSRRZBBcMqui+i4acD
	 CXPI0ZhNlkH8DHA98s4AQ56sVB3SESs5pI6l9b8byJ0yIA3zJk1A+TJclPEHX1LXJi
	 vxRWihj6+I0bw==
Date: Tue, 17 Dec 2024 16:02:21 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org, robdclark@gmail.com
Subject: Re: [PATCH v3 0/2] drm: Allow encoder modeset when connectors are
 changed
Message-ID: <20241217-fervent-hot-teal-dc3516@houat>
References: <20241211-abhinavk-modeset-fix-v3-0-0de4bf3e7c32@quicinc.com>
 <20241216-daring-opalescent-herring-bfdc8f@houat>
 <8484df79-6ad8-4702-853f-31d985178607@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="evowgftqcey6meiq"
Content-Disposition: inline
In-Reply-To: <8484df79-6ad8-4702-853f-31d985178607@quicinc.com>


--evowgftqcey6meiq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/2] drm: Allow encoder modeset when connectors are
 changed
MIME-Version: 1.0

On Mon, Dec 16, 2024 at 10:27:44AM -0800, Abhinav Kumar wrote:
>=20
>=20
> On 12/16/2024 3:06 AM, Maxime Ripard wrote:
> > On Wed, Dec 11, 2024 at 01:18:41PM -0800, Jessica Zhang wrote:
> > > Call encoder mode_set() when connectors are changed. This avoids issu=
es
> > > for cases where the connectors are changed but CRTC mode is not.
> >=20
> > Looks great, thanks a lot for doing the tests :)
> >=20
> > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> >=20
> > Maxime
>=20
> Thanks for your feedback.
>=20
> Can we get an ack to land this through msm tree as part of the series whi=
ch
> needed it?

If possible, I'd rather merge it through drm-misc. We merge a
significant number of patches affecting the framework there, so a
conflict would be less likely there.

Maxime

--evowgftqcey6meiq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ2GSfAAKCRAnX84Zoj2+
dlidAYC/XbhyMAkyZHI74Sg0WUgq8YO/a98h5oA7AWtzou8q/eVbVGW04jMEEN8Z
bhMxJpYBgMelkeecYMqiu8NR9/Nyl+AqXRh7Acrp3jpFU7byFh+/DoMfGo2LEGCc
0/wS6heh4A==
=eOA/
-----END PGP SIGNATURE-----

--evowgftqcey6meiq--

