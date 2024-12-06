Return-Path: <linux-kernel+bounces-435362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2909E768F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7623628453A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139D51F3D5B;
	Fri,  6 Dec 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="VXhh32cJ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00F020626A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504392; cv=pass; b=hfgtM5V9wTYQ16PhhraYHdIpYN+F+hPtUxKkOn3HZEAd2hncW5xCzpjFzIBwkPUStsUa4YAXMOECBwLISH8RBcJPjro8IfvIgqR5Ez8FuFRLseRqjnQ60/EEtUdBZUJmMtLuP3NEhG0E4nsZ1hFCFeQ6STLXYxi6ECfVoGa7tpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504392; c=relaxed/simple;
	bh=gwYB7Aucz6xsQQzxvtIP//90ofHhycnWMcYkF7vufl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BibZYFvT+jXZqyTanh+tloh/JUUyIPNfb/3mzpi6C5oXtKPWdXZ4F9jHdIq+xwcUBRz5R2NnFFKs6GLhloCvTQIuPz22eLURUt8s6jeDXvy4BKHEejIfT7nKjwdbwghqP/m9MYNJ6KZBI4DL6AVQGt+zHUZz6hqgkZh5uXWt5a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=VXhh32cJ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733504381; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=f3isgZAAVQROAKB+sviCZjpp+zyjQkj3XLS2laHyVCgdIS6VbzZ+hgvGPUyWHygzutpftzalS9U3d7i47FTbl7ZtG6lamZxjMdzh/z9Bql1/mnTN+9CqBBZ2Kn+srr4jJWVEoNfZUWeWvIgBApLVXAs0uRVt8RJRpG5YgDk6uoM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733504381; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xNVPYInbDo/m1K6u9klXT99pnNhKMyXFgxqw/lq+NuI=; 
	b=gIpulh8Wx1CKWzRm+av2DP7FEjUT/S37R3Ict6LXvMj0k7I7sSZMipW/x18RM58RJlm3XStpg4Lu89EQWDMSunPnH/ezDrZPlYzMuwjpUq/RueaA8p0Kva5IHCMSnxdWcyLkwhm4a8N9L9jCrC7NWjyzZGGmP047L2wVSaIZs90=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733504381;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=xNVPYInbDo/m1K6u9klXT99pnNhKMyXFgxqw/lq+NuI=;
	b=VXhh32cJhKQWXTCE+qIlBthQ3aWC4Sak6KpF5yhkVCajBpZWrhHDCDe3klV9H6me
	rL4cIIUMELdF0gPCJCxDLJ7Pd8hwMQ+bMJJ+6+7zqzC4QzLFy4CqGxFbaR1jW+zdmrv
	WZv8HMxyEeLWCs/CQKfMpFI/j5ScAMDJnxLK5yF8=
Received: by mx.zohomail.com with SMTPS id 1733504379368564.8733754480363;
	Fri, 6 Dec 2024 08:59:39 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 3F86810604B0; Fri, 06 Dec 2024 17:59:35 +0100 (CET)
Date: Fri, 6 Dec 2024 17:59:35 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: vkoul@kernel.org, kishon@kernel.org, cristian.ciocaltea@collabora.com, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, quentin.schulz@cherry.de
Subject: Re: [PATCH 0/2] phy: phy-rockchip-samsung-hdptx: don't use of-alias
Message-ID: <vdg36bpis2bzawbei6eacojttuth5ihtp7o5fabs6f6rkctikl@hofd3mjepunv>
References: <20241206103401.1780416-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zxls2fxk2byapnnk"
Content-Disposition: inline
In-Reply-To: <20241206103401.1780416-1-heiko@sntech.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/233.478.56
X-ZohoMailClient: External


--zxls2fxk2byapnnk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] phy: phy-rockchip-samsung-hdptx: don't use of-alias
MIME-Version: 1.0

Hi,

On Fri, Dec 06, 2024 at 11:33:59AM +0100, Heiko Stuebner wrote:
> One nice comment addition and removal of of_alias usage for core
> device functionality.
>=20
> Heiko Stuebner (2):
>   phy: phy-rockchip-samsung-hdptx: annotate regmap register-callback
>   phy: phy-rockchip-samsung-hdptx: Don't use dt aliases to determine
>     phy-id
>=20
>  .../phy/rockchip/phy-rockchip-samsung-hdptx.c | 64 +++++++++++++++----
>  1 file changed, 51 insertions(+), 13 deletions(-)

Full series is

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--zxls2fxk2byapnnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdTLXAACgkQ2O7X88g7
+pr8sg/7BNdpQkGIGLwMdrX+F3YVz8wFfbFq5Kg+BrqM4O1w10VcTOOxMriGEdxw
OMJpE3WksnBMT7EXGHtczqL8nexDnv9r+rHla8Jp0myRKMj4LAo7gKhLBv7W0sgB
XN6mj5oLM1dx6YgQDNUBCGkiAdY7MK1j4NRIcdHEVTJ4zOaeLl0wZCkXQK1H1/XW
XQjtubsowP1+6I3tQ+QfyYCIyvzAGVV6//yYAHDNSIjHrdEKULp6puGkCrJ2Y4NZ
CAcO+Ee7i9vttFDpZwDg6u5RS08vjBc7HBCNcQ+/wHsMl7I3BjbcWvgEvdIN0DXy
LeeNR8EJ7wZmlaCZX1I8WzXEhsS0Ek/TsaGW5u98eV2/sqqHO6yBNnddVQa4c9j2
tcVS/XVK9WsBR/9NPFxgOyuod+6xoOufI7QAEXcGdoQDMrCW7tKoDmmEmuqMLfCv
v1u65jqKi8GgaLXW02MsJb/Kx3myUaQMBiJocZ6eHUIO7IbAFnJpGureYaWFUOpD
O0YpUQFxK08GOnMJkvMICml8J2E8UiEjgpjL2ZbZtuxVZrDq8U1j7PCiyfMMm0mh
ISpMivLqTTRjAOHYdQU+kWNOvRmqwXgHTRJD7rOKo3I0gGt4NP53084kPEtyb6oD
t+jsJDOw6CmdGW6zXa28gFrMbbO40X7ih24VGfKXIXFVzgN9lHQ=
=Wj79
-----END PGP SIGNATURE-----

--zxls2fxk2byapnnk--

