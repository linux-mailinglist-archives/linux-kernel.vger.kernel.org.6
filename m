Return-Path: <linux-kernel+bounces-447202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2FF9F2ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7300718845CB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C4D204097;
	Mon, 16 Dec 2024 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuraBuVR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5D20408E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347216; cv=none; b=fiEVhPpso0nGolEPeS8xQk4srY0WDMUjy2sHb+E3tHYSpxHKYa+SuEn047o+eMIpl7RHl9wguBFuHeWwOPyDUEV85GPzQv9jHGNuKuIchNhG0sr3JqYIRBar/3qmWYRWi5tU3liyLEdTqemFy77ziQGe6aaIH25iwjQ8MpnF/ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347216; c=relaxed/simple;
	bh=ywX1oQ18iE2vfl6WWVI5VhJrNL5RQwd7RuMeVyNwMPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPBUJC7Q8tesBnkxmfZcr+R/CGmBzLIKMwr+em2XYv4qKLzU20QOcNTfBbPAPtlm4t11wOexY4yQgWBJY0Uqn0V/TDwfx6W+5kglicMOVd+SUjRf0Mv8g22Hh3BK2evLvG1TfDxEjL3LLvzIoi0MrPQZzgRm1RV1AB41/WMNsV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuraBuVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9ECC4CED0;
	Mon, 16 Dec 2024 11:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734347215;
	bh=ywX1oQ18iE2vfl6WWVI5VhJrNL5RQwd7RuMeVyNwMPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuraBuVRAsnT6gD6C7MwpftgUMyIgYT4jkPbZClcgUHIgAQbC3jyzh6rp0mzYYjQ9
	 S77N5jO5/+eVUMBEypsuJVhCL93MHcLSf43s6E2Ip7NAUIMgHRv8wG2lir8TPB9krm
	 y/rLWcKUEr6h+6IxBIjotw01LmIQuIXb8pHXN2avcmpvAusM35Z9mE6FLifuFVMh0n
	 pUvkZVluitwzgRgyfZGEeylP/GPop6sIGG8GDYlGsYRQPcxpmNfOfBRqqm9Ed7h2+y
	 K2/Nw08o+rCIzzK/eGQ3WKO/wS/3VI16wsgqRAaQxDG1Futl/oYWxvLgwAt+gWq0YQ
	 kbOnp8+CbVr7g==
Date: Mon, 16 Dec 2024 12:06:53 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, quic_abhinavk@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org, robdclark@gmail.com
Subject: Re: [PATCH v3 0/2] drm: Allow encoder modeset when connectors are
 changed
Message-ID: <20241216-daring-opalescent-herring-bfdc8f@houat>
References: <20241211-abhinavk-modeset-fix-v3-0-0de4bf3e7c32@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="cve54abmjy6zy4ki"
Content-Disposition: inline
In-Reply-To: <20241211-abhinavk-modeset-fix-v3-0-0de4bf3e7c32@quicinc.com>


--cve54abmjy6zy4ki
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 0/2] drm: Allow encoder modeset when connectors are
 changed
MIME-Version: 1.0

On Wed, Dec 11, 2024 at 01:18:41PM -0800, Jessica Zhang wrote:
> Call encoder mode_set() when connectors are changed. This avoids issues
> for cases where the connectors are changed but CRTC mode is not.

Looks great, thanks a lot for doing the tests :)

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--cve54abmjy6zy4ki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ2AJyAAKCRAnX84Zoj2+
doAKAX4pPBt7VLBlP5IvAhuVZ6Shqdm2H1X/lYRp7MyncmWE+FL5eQP1/vfD6ZnC
E/VtNa8BfR6R5wMfrQSRkkVWpIUeUVmiq2gpikdFQ5+i6Pwonp/GABF2PdLHhXaU
6Mv00hJLEQ==
=c2zP
-----END PGP SIGNATURE-----

--cve54abmjy6zy4ki--

