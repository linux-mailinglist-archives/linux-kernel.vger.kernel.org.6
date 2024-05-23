Return-Path: <linux-kernel+bounces-187666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD7F8CD629
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60BCBB216D7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0FA7494;
	Thu, 23 May 2024 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5KooSen"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01E6FA8;
	Thu, 23 May 2024 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475925; cv=none; b=tZNxR+Dg2bwiPEFbhWdlbxSI7X75FLKEylszY2ZnaHXHOHRhNETwrRl5eSM0XKDgLbfY0ZyiPzlU5wMrxtpP+t1takRMsInCId/yZzePfCHgmo4wd9bRHAFj+WwAedHP/rSWiWv4HzIxhxs9ddh6jlSycWYfEcJ14/e5xi418As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475925; c=relaxed/simple;
	bh=0n5OH0k+GRei5q9zpND2pbMT2lTvBmQGE4laZAvKQMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsbbLTcLvJ7KxkwLzrw2mltA3tFGCevR/JLO5A61tycvjvMEBk+Oomvt+UzSXRj2BSAoTbyMhciu+YEVRdLOqASY6Q5ylEl2t0u+PZcl3ZEkRf/1DKNEBJ58ug5fUP5cq14NVimkf6jW+cqwVh9lu5NHmamhrassRtg7zEK3j10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5KooSen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D0EC32781;
	Thu, 23 May 2024 14:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716475924;
	bh=0n5OH0k+GRei5q9zpND2pbMT2lTvBmQGE4laZAvKQMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5KooSenMd9y77wOzWwd6Ck6YbUB2Z01Il0y3de4MXrjywybDW42k9Cq3Su8fsMMF
	 +u4jh+nwcK1orQSTRR+HA94GzWNvLBC2yoBehb9/NNGDt+1+LG6sKxoGADspETrzP+
	 CCgledNtbdNFb1qGcjZPy8FARa75nPs6cNnr1ULmrl7x1DDNta6V4YvmiQHJZOqM3A
	 8umaZlquBRrWw1C7CsMjIzWg0idNdqvuoBZFXOd0RDw9j95UDK/eVi1FjM54i1eoHk
	 9+dD92MQeP2chxN5Xk9QwicVGUSLAQINvu2+DUpe41UV2PBjHA5s3tfsDeNQcpkMNY
	 QRZgpgD8pRo6w==
Date: Thu, 23 May 2024 15:51:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: display: vop2: Add VP clock resets
Message-ID: <20240523-climate-cattail-e5e1fc8ff0a3@spud>
References: <20240522185924.461742-1-detlev.casanova@collabora.com>
 <20240522185924.461742-4-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jgeG1HuZXzpfSjmQ"
Content-Disposition: inline
In-Reply-To: <20240522185924.461742-4-detlev.casanova@collabora.com>


--jgeG1HuZXzpfSjmQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 22, 2024 at 02:57:50PM -0400, Detlev Casanova wrote:
> Add the documentation for VOP2 video ports reset clocks.
> One reset can be set per video port.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--jgeG1HuZXzpfSjmQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZk9YDgAKCRB4tDGHoIJi
0j0rAP0VlFrFaDu+/KLFAsK956xCJey9qaStyOOlXTICQTGV6wEA/N9OOl/tmZru
MK6sP4YDord/71YqPTb6mQhi9OnMlAk=
=t2FA
-----END PGP SIGNATURE-----

--jgeG1HuZXzpfSjmQ--

