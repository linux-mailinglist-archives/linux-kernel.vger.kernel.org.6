Return-Path: <linux-kernel+bounces-576856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D48A7153B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE1516BD72
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F073D1DCB09;
	Wed, 26 Mar 2025 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtMwMZpl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E291BEF74;
	Wed, 26 Mar 2025 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742986863; cv=none; b=G/GbEuPUfC98Rkd3Nr5TzH57SkZKCXY0HCb9jJs/ng20/EJ7knu2teFWvObx0mvJiHyRUSvE0RyVdoL8W1ev81BuDtmGlsStRaTpHeV65uEjxHTa6jLu9TuOqnrI2JlWqiX0jEnIzA+7AHgDziAsebmdkpDoGi/d9ejTryv0qGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742986863; c=relaxed/simple;
	bh=i5EM31pPlZ7zaytBldZoUh4/6CAZrGXC0cCO7MtVZYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evy5x5CGFa5FqKqcr9S+wYInSjRFuDa0jKoOGU6fxUIjYXA8aVWhYwV/07xfgvbkr3ld9lGdXL9yUGrSLZBKiVkMLHv3/dAFmZXBlouHizrCjPQCzv62wT83dXwbjWeYwDWa6djl5JJWU2yXIr8RfbNd+HfvcuPeiXxbh/DgyKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtMwMZpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC91C4CEE2;
	Wed, 26 Mar 2025 11:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742986863;
	bh=i5EM31pPlZ7zaytBldZoUh4/6CAZrGXC0cCO7MtVZYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jtMwMZplUGaTHjvxtXkF+OmwLt/B2vyVDNY/Z3nr0U01+2RPN9SJte6qEgGszG6Tc
	 Av6yzEFyFnep8Zq+g5vji8Fm+Jyq7efIBIaqnSILPVpshpYx0pdDHGU0EIoVqTJHrp
	 /65cV47mgkEX8mSkaTMJKwBo1Euy/ksvUz72wbS30yBVC8mrQLlfzuDOIhvsdf50Io
	 U7D0DrqP6OVhVz9u7Gyxfns4PCxK1YZBuCPYc71N6/j85KuFt7VqozRDdPKwyIpdzg
	 Wl8nGIBKNAl9wCqTY1RWv5imTIyuoMK5LgGZi8WqwBHr8XpfavhYnhZezTqT/xwKrA
	 vg49qnev6SUdg==
Date: Wed, 26 Mar 2025 11:00:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/9] dt-bindings: soc: microchip: document the
 simple-mfd syscon on PolarFire SoC
Message-ID: <20250326-tricycle-hesitate-e58633e62545@spud>
References: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
 <20250321-ramrod-scabby-a1869f9979b6@spud>
 <20250325-quiet-waxbill-of-realization-675469@krzk-bin>
 <20250325-feline-roundworm-dc391b755673@spud>
 <58bb1186-08ee-41cf-8593-a6664bd874e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nlJEEonkgyvP8Dzi"
Content-Disposition: inline
In-Reply-To: <58bb1186-08ee-41cf-8593-a6664bd874e6@kernel.org>


--nlJEEonkgyvP8Dzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 07:53:55AM +0100, Krzysztof Kozlowski wrote:
> On 25/03/2025 17:03, Conor Dooley wrote:
> > On Tue, Mar 25, 2025 at 09:13:22AM +0100, Krzysztof Kozlowski wrote:
> >> On Fri, Mar 21, 2025 at 05:22:35PM +0000, Conor Dooley wrote:
> >>> +title: Microchip PolarFire SoC Microprocessor Subsystem (MSS) sysreg=
 register region
> >>> +
> >>> +maintainers:
> >>> +  - Conor Dooley <conor.dooley@microchip.com>
> >>> +
> >>> +description:
> >>> +  An wide assortment of registers that control elements of the MSS o=
n PolarFire
> >>> +  SoC, including pinmuxing, resets and clocks among others.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - const: microchip,mpfs-mss-top-sysreg
> >>> +      - const: syscon
> >>> +      - const: simple-mfd
> >>
> >> You need to list the children if you use simple-mfd. Commit msg
> >> mentioned clock controller, so where is it?
> >=20
> > I don't think a child node is required here, there's not enough
>=20
> Then this is not a simple-mfd.

The pinctrl will have one, whenever I get around to actually working on
that. I can leave the simple-mfd out until I establish exactly what
that's going to look like if that's what you want?

--nlJEEonkgyvP8Dzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ+PeaQAKCRB4tDGHoIJi
0t7jAQCCLwmHuZCd9933PeQR17AUr1HNZd3fYK3blMGPPpfn5wD/dNQnm3RNPn8P
lY3prJBqUjp9Wxq+q1mGw/BIyBKFlwY=
=i6NH
-----END PGP SIGNATURE-----

--nlJEEonkgyvP8Dzi--

