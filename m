Return-Path: <linux-kernel+bounces-545018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5065EA4EA24
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C118A2BAB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C8624C068;
	Tue,  4 Mar 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxI2Hw/e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94A29AAE1;
	Tue,  4 Mar 2025 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106769; cv=none; b=jkLORh4bybKJqqbG56KjvsETTMXv0zNSBsQm6szVok1jKr6TYAvvJ0S2/mGCf10QIbgFpSDgnSf2vCxLFxIQYGiMynvARiCyh6p/fWLxS0ZxhURWO62zVKMDVvQTTldoQsi7l9+rYfY9kPeFgl2zf5/8tAOCYr/ZMH7z068FTJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106769; c=relaxed/simple;
	bh=eoJB3OLgTrk+lA8oBYKJiwXc8eqZCVoHFloR0SzQllY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEEw57u7R+0F8J3MnPeeA+XeqnYWdqoMMIYR80JT1Nkhe2OqaUc2C7Vu+0kj4KMd3NE0app9KVX/XxQGwntXjtFxYHuVsQ3xgbLSBNGZIKUjuFXSMkl9URZHNh0zEkNzR4QApktfAZ+kUxkAlleFvmXtFXmPgaXWjerOYy9ciZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxI2Hw/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5D3C4CEE5;
	Tue,  4 Mar 2025 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741106768;
	bh=eoJB3OLgTrk+lA8oBYKJiwXc8eqZCVoHFloR0SzQllY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XxI2Hw/ea4eI+SoFuS3K0cKmjGZ3ZtNccc4VskQyfpMe9NvMF1jUiRpqZ5JXH6WOz
	 xTW+Xqi2T0wkOQvH8nU/K8EGesDgQdsAp9TjhaDz+K2V5VtF3s1ggT95YSVYgoGSw4
	 kybnoo9e4Isp3EZrQi39i1S2GZ+KuKZs6XyH3STW0z3iP5VX/Q+P11pvaELXqQ15ON
	 hlr84h6hwEx3deXvRLoHlOqbvXrJjXsT7iMd1HtwcCDxHstS3mGb/YT4RjDpXvltMU
	 xrguuGDPBPlcgTpmDwe4jPyfRk6QyUFJ+WpucTNsm9STEu6fgv5p4pDfqJN2uPlqXW
	 2QIon9Rrb9LUQ==
Date: Tue, 4 Mar 2025 17:46:05 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm/vc4: hdmi: Fix some NULL vs IS_ERR() bugs
Message-ID: <20250304-adaptable-monumental-octopus-a8ea0e@houat>
References: <a952e2b4-d4b8-49ac-abd9-9967c50f4a80@stanley.mountain>
 <CAN9Xe3R-nyCcTRhDTeWFrW9EVnpdRG2Nyz=qjiYB0pzFM3NxWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="jmdly7fe3anaxwwp"
Content-Disposition: inline
In-Reply-To: <CAN9Xe3R-nyCcTRhDTeWFrW9EVnpdRG2Nyz=qjiYB0pzFM3NxWw@mail.gmail.com>


--jmdly7fe3anaxwwp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH next] drm/vc4: hdmi: Fix some NULL vs IS_ERR() bugs
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 10:22:29AM -0500, Anusha Srivatsa wrote:
> Thanks for the fix. I shall revisit the rest of my series.
>=20
> Reviewed-by: Anusha Srivatsa <asrivats@redhat.com>

It's already been applied

Maxime

--jmdly7fe3anaxwwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8cuTQAKCRAnX84Zoj2+
di70AYC6ULd7dct3xCYAhUfz5uJpVATAd7zazZggq/xnzOI2jlTCF4qgyYPwrYew
KYdyTE8BgMZZK7VY6cp70tbWDArNUO9U0wES2zr7mCr3dAutBqpCvO2EYu6hlbSL
5cbIq5Uu5w==
=Jmp5
-----END PGP SIGNATURE-----

--jmdly7fe3anaxwwp--

