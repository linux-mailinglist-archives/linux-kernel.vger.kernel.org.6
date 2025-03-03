Return-Path: <linux-kernel+bounces-542840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615EEA4CE5B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01763AC767
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC11F4173;
	Mon,  3 Mar 2025 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="QA68lz2y"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12A21F130D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041320; cv=pass; b=joKB/sC2YMaSKUEdA2CEJFshrCsotDBmjt743iLHBi4IYSzwBG2+mqZGk51hmEf5j9Le94H9hBLAGKkmV55zvwUMfy8q43qi8ltmOz4nGY7MnhVoApqsRSjSaqc2EGDACxkFtTKmcupYAUouHQaSeLjj2j0FuBCmM+MoJ3Y+YfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041320; c=relaxed/simple;
	bh=bSobJudvyl8snpsPDEXpVSfaZCLlmUilrMZO8q5lrgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGqrFJ/+KXT3KsW9EuE/cNH7emve9JV5bVDBjWjmYrwdOnVd/lI8HOBVE5xsFOXRDjFPABnA3AXdYVL+yQYHfz+JESvtnNv6OxHvXUWcmOf6eNx/hpR35re/PAKrZjClbdq0Ea7pQi2Djl+CMuLKUGtQV8IKU3wOKGQ9OJqDO2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=QA68lz2y; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741041289; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GejOG25tOtoCkI+YE4XWkXsIJPTBWqb+UgfAZAhzlcVlFx9TguIJRiy9aXih8TMNzNXFoykF46L1KF5uZzmPH67AFFvZGfVGOyKq9Icxm1FNk9WPJKL42JFMvK1yyKWSfxwhDxSWwGef6Ha5YdFqL7L+H1VF5CHYgB1OBaQgG30=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741041289; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PlUzblDYEjYCS98Pl5aItUlNWLm0f3R52njwTiqqC3s=; 
	b=kLzuwD/FsZ3wdDjrs1pSvD1Fzroo3ViwPQTfll2/3Ks3yAKQqwCqOou5tngdoqL3E6VlfzJ7S4EfIOfTi4Q8i331OGfGoDRiZ4T45XzuIhuKQoyGgwDoxVbUOnri+0cq2YxANGAe9g2+bhHPlvjjSI/vPcsoSP4EGdSQYXwTS9w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741041289;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=PlUzblDYEjYCS98Pl5aItUlNWLm0f3R52njwTiqqC3s=;
	b=QA68lz2y9nqvEmAh+PsVrmbG1C6sVQ9Fr4ZjpmixXoldvaSqhRo2v2gOpq/7iP+M
	rDXhD4MZ8svoTj4rlqTHuSqOneFkzzv3bR5SyG86l2MXv62MffBHzeNr6s30/hZzAij
	YGmZU4qFolK0P1sJv+jRZHVciMzR1j03uEgziYaM=
Received: by mx.zohomail.com with SMTPS id 1741041286829334.02204399221273;
	Mon, 3 Mar 2025 14:34:46 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 1766918065C; Mon, 03 Mar 2025 23:34:42 +0100 (CET)
Date: Mon, 3 Mar 2025 23:34:42 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: hjc@rock-chips.com, andy.yan@rock-chips.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/rockchip: vop2: add missing bitfield.h include
Message-ID: <quj727pq3oc4xruatx7s5hob7jtcpw6zhe3wv6fhammxhejcem@eois3su6izj7>
References: <20250303182256.1727178-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uxnpfa7xaeh6coyf"
Content-Disposition: inline
In-Reply-To: <20250303182256.1727178-1-heiko@sntech.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/241.32.4
X-ZohoMailClient: External


--uxnpfa7xaeh6coyf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/rockchip: vop2: add missing bitfield.h include
MIME-Version: 1.0

Hi,

On Mon, Mar 03, 2025 at 07:22:56PM +0100, Heiko Stuebner wrote:
> Commit 328e6885996c ("drm/rockchip: vop2: Add platform specific callback")
> moved per soc configuration code to the other per-soc data into
> rockchip_vop2_reg.c, but forgot to also include bitfield.h for the used
> FIELD_PREP macro. Add this missing include.
>=20
> Fixes: 328e6885996c ("drm/rockchip: vop2: Add platform specific callback")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503040135.fgoyWdLB-lkp@i=
ntel.com/
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/d=
rm/rockchip/rockchip_vop2_reg.c
> index 0afef24db144..f86a30df94aa 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> @@ -4,6 +4,7 @@
>   * Author: Andy Yan <andy.yan@rock-chips.com>
>   */
> =20
> +#include <linux/bitfield.h>
>  #include <linux/kernel.h>
>  #include <linux/component.h>
>  #include <linux/mod_devicetable.h>
> --=20
> 2.47.2
>=20

--uxnpfa7xaeh6coyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfGLnsACgkQ2O7X88g7
+prXag/+MoxGEPpemJ0hBwdSLvlh08UR3FhUgUQ07dWpX+Jn/qz1RSQi2zxlnFqp
gizw7mzUOFbi0+dXZhXOKCKmTa4jdP+SGujt0DBs4psQHQPMRrtokVb+N4IKKKDd
zH7hfzTI/FFEXjU4ayhYVsezc/5ilTrOcax9WDFuEeFVm8ORr8ntdg+vOYoXEPVa
kADBpAn23oPmHbHZCrtRUCN5eomaWiUxYJAW6vBAZs24D8Ne+JmvC2oekhasY1V+
5S9eVwkDncNSyipWAzFBSV2GM4NLKDXnurNc1GqOFJlH4R6o8dhGpTHxagizkba5
JmYqI8+Kc+FO3NyXL0mSOvMVduXJEqPFetIhn9KC4B0UDPoK63I1bXmAgh0wdyK8
Ge5heyM4TD6/L0Mu57aCZJjAwCyW2+ImB9EyXlN6pG8vyd5K7FDY3nEBPf7Pm+Y4
msgCWZmYeTMPYvKhoY1bvF8io19wFOATKNJZAiyFwGYKea3F53QWF7dSNahmq8Pj
PepbbEE20SxuKfK+ceiOb4KlzsRA2z5lL2+f04rej8AANsU6EPFkhNjRsruy26wL
dXocafGEvZChcpqS8EnJDjwVreEdUjFJbFca9E+LVEI259RAczoiv5fYkZhWuNag
23oy+R6C5o1LqVMmkLc7n0j4hzKNRzpfxDiRc7kzWLLSZb4Q4C4=
=zYzt
-----END PGP SIGNATURE-----

--uxnpfa7xaeh6coyf--

