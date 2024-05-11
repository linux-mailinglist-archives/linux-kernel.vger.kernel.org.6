Return-Path: <linux-kernel+bounces-176545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB898C3170
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53749B2126F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 12:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A150292;
	Sat, 11 May 2024 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8359fNt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9985028B;
	Sat, 11 May 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715432350; cv=none; b=Q+14zYlMo63fz0udV5ICgkwGXaCm486u5AijZvrs9K/IsQUugOm+WcIWQZRE6u+ZiMVk5ChoB+AnKGH+G5ZZztWEqCQmNcmPNBjr1hA6HSZaKn3WmnM13dd3Vi0SNZ5znrpZ3Gy0Kd/RlFWgswBKnC3LbnjOohNCOFyJY/5VZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715432350; c=relaxed/simple;
	bh=7mUFrYFasyg0D5ghmubzeb0I1JT+OGqiTqWUaMx3Vtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXdKAitwRI5W1P+WrpWr5NC50Pktxaz9NsdIwrbp7vP9jne+KjJNmoGplEo7YDA8PMXctKB/HYGAWSiw3jYhlWN8OpiO+LRnLbWvfG8sHiTA8XxpgU97nOxwJiXz0fNy207/d+5YaJYrOfK7oe3O79zM/yZ1Cm8+kt6rNoDAjxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8359fNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9B1C2BBFC;
	Sat, 11 May 2024 12:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715432350;
	bh=7mUFrYFasyg0D5ghmubzeb0I1JT+OGqiTqWUaMx3Vtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8359fNtDMDkH1bx2UfEwjgmDVuwhVScnjOQ71LQoqai9NM7zhfOMXFNls917FrM8
	 4xZQUKNO9+KGpkwaoR/2fsY1rYK/9eaPrniD5HplavmmPmZXP59G9N24Vw7VugghxJ
	 VN6CLwqcji+N3mFRkEtJ1Wx9l4U2jwqDauOyzG8Y2eZjqzbWtq40dGVPYa6S+kJqVb
	 AaAdqDCc+a2Sx8OFcIpOJfNH6/94rgdCE9Oqwn/L7Oft1qgI35cPAREvZyAfm7GSg8
	 VdvKlXALzWQ/kG4wdTkgDChfKCVT8WDaYPOv5idjpfBWwBXl5Ej7Yhk1yuhlvurH2b
	 vlHv4eXI+J8hA==
Date: Sat, 11 May 2024 13:59:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Konrad Dybcio <konradybcio@gmail.com>,
	Del Regno <angelogioacchino.delregno@somainline.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Dmitry Baryskov <dmitry.baryshkov@linaro.org>,
	Shawn Guo <shawn.guo@linaro.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: samsung,ams495qa01: add
 missing SPI properties ref
Message-ID: <20240511-lid-depth-f29664519bd7@spud>
References: <20240509-dt-bindings-dsi-panel-reg-v1-0-8b2443705be0@linaro.org>
 <20240509-dt-bindings-dsi-panel-reg-v1-1-8b2443705be0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2/wI+SpQ0UgMlFs6"
Content-Disposition: inline
In-Reply-To: <20240509-dt-bindings-dsi-panel-reg-v1-1-8b2443705be0@linaro.org>


--2/wI+SpQ0UgMlFs6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 11:42:51AM +0200, Krzysztof Kozlowski wrote:
> Samsung AMS495QA01 panel is a SPI device, so it should reference
> spi-peripheral-props.yaml schema to allow and validate the SPI device
> properties.
>=20
> Fixes: 92be07c65b22 ("dt-bindings: display: panel: Add Samsung AMS495QA01=
")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--2/wI+SpQ0UgMlFs6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj9rlwAKCRB4tDGHoIJi
0iA7AP4z/SpXYwQc+M1q8GGrK9XnK29OfT3DTaXJVMuASjZnkAEA9Vbey58W1Nsl
v/4W+TsdYBNh0T8/Omb/K3yj7+yiAwE=
=Tmx3
-----END PGP SIGNATURE-----

--2/wI+SpQ0UgMlFs6--

