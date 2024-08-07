Return-Path: <linux-kernel+bounces-278296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DD494AE6C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2E81F207BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AD313AA53;
	Wed,  7 Aug 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c94AEnm1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B02D05D;
	Wed,  7 Aug 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049510; cv=none; b=WHTNTT2nEsasIUCF+/bXJxXQjDGo9JEWIF0QwTtaFSeYWMaQQTBMvJ0nVDqFMLFUkM8FxBBTyGRb033tPoFnguz1BlIoP6C7ScS34pEMxva+fKadmdaf3hLeMD7KgYt/EzHQJ3qUOyF9xDJWqGc0986QJV6YyqDGD6jmu4W7fk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049510; c=relaxed/simple;
	bh=6dJTfmCaQH/epAduChi8xwoktHuAwN3wVsejcEpvwnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owF/2NebGdR4uIIAj+q3/Bj5/kvdE2XT0amO9alniy4S3xFDLY+AfkIoTCuMSL9oK+KZxcTWLpFsCtbc88MF9UZR59aoDyxrur77tlrSi8Vc4MFrUAtTgf+P6bj9T7jHRk3AzgZ6S4t+hvNHCr4NVLiDpcXkowCU0UNJLsZZlts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c94AEnm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECCAC32781;
	Wed,  7 Aug 2024 16:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723049510;
	bh=6dJTfmCaQH/epAduChi8xwoktHuAwN3wVsejcEpvwnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c94AEnm1qcyepy0DA0Rfla6DAsg4n1jhEeg8qAJ5vW2rNajHgyHWJwLAjORmeOMfw
	 7m/Iz31lnm8hyAIcDM1hfrKt6A/+69tXQX2g3HSMNwwaBerNuukDVhqWShKtdS1lEs
	 CDlujBo6gmnH4D3Hm0otg7Hxnn2f0jeeRKR771D4uLlj2ban06ozu3rB1nN/l7yWQn
	 pSTUgP5vJjkemsUy9rBZxBUBMDv/kMZDrIcdwuPrKZS7Z2kowUkw9yWCEVPzjvEtaR
	 NKVa8V390mULJ6M16RIWPax9uQBejrpgE4+FbSIXtksNm3X4UXzbFEyUK7ZkLDgYiP
	 OsiAONdhym/RA==
Date: Wed, 7 Aug 2024 17:51:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Sen Chu <sen.chu@mediatek.com>,
	Jason-ch Chen <Jason-ch.Chen@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2] dt-bindings: regulator: mediatek,mt6397-regulator:
 convert to YAML
Message-ID: <20240807-magnolia-oboe-9e8e960390c8@spud>
References: <20240807091738.18387-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7E3aEdg7zXxKTcFJ"
Content-Disposition: inline
In-Reply-To: <20240807091738.18387-1-macpaul.lin@mediatek.com>


--7E3aEdg7zXxKTcFJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 05:17:38PM +0800, Macpaul Lin wrote:
> Convert the MediaTek MT6397 regulator bindings to DT schema.
>=20
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

An ack, not a review, because I didn't verify the regex.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--7E3aEdg7zXxKTcFJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrOmIAAKCRB4tDGHoIJi
0ncGAQDFsDxp44VjZJxJhmVJVIxzpmhH0HGlbIs7Gb4nF+GptgEAlU8xS2U8ajFv
iWSuq2RK14cHc+RkiPuqmmByh77f8gY=
=RHlF
-----END PGP SIGNATURE-----

--7E3aEdg7zXxKTcFJ--

