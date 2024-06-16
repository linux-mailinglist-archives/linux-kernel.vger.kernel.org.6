Return-Path: <linux-kernel+bounces-216434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A09B909F41
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02D1282929
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936A83E478;
	Sun, 16 Jun 2024 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S78wpN6S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE2C210EE;
	Sun, 16 Jun 2024 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718563107; cv=none; b=I8XqA8+1mhRLbo67qeDfr74JRfxgt/ejE1BPWX8oUWkENK0qzKzSOqKN4GQpZbv08xNgAzX5jOxWddb7XaGi1ad+FPO/3G5jtgSxnL2+z+ai3jKiwy7vXokArV1a5khOWVplyI3NnPxpraZD05ZebX7woxKFdG7SugIqVh/hcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718563107; c=relaxed/simple;
	bh=mKljWFCEhr4ejc3sfHEzZLzWr53KPVcA5FfLGTbsJHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSrTI2v1TVCfW0ektKoFyG+V2bGXm+ju2G05ur1dEhEzj/IksccXZ/XpbsZcnvL8e9I5ANkUMKzGq3+r7q3neVvhXvwYQbWrZS8KDiv0yTOAGHSCoVIXcfE19+ehV/pCfkd/92pgWtV7eWQ0wsBFPBw9jXiA/1iNEPOaaOxWPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S78wpN6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7311C4AF1D;
	Sun, 16 Jun 2024 18:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718563107;
	bh=mKljWFCEhr4ejc3sfHEzZLzWr53KPVcA5FfLGTbsJHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S78wpN6SwSUeYKlNi+qGGtGDZ/DGfl5WZYihFc4RNV+iekIa+BqjXaPCP3s/r99cc
	 SRcbh6rQgjTlxof1oFJa5cE1AQhwW2aJJG4SlA3cSICp1q7JbpKQK2DXmVx8LAPPG8
	 KinUnF3HWCIRITCC9VYrofnnlC/3s7XaDUqqHUv5Apy1V3e65poWfeyg7qOePqxti3
	 Vx4PFD9ampodJz7jEOgQzY9lFXuTo8ri4jkBr3f2cL5T1STHFa6Z7ovbkQaIl4c0KD
	 +ikBGtl2nU1i0lCziGuYLFPjnRrx2+PuaYKOAc3NClRsOP980nJq47Ipr74dOdUsPl
	 sS+TsW6pEK0iA==
Date: Sun, 16 Jun 2024 19:38:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: clock: Document T-Head TH1520 AP_SUBSYS
 controller
Message-ID: <20240616-reaffirm-thud-e3fb4de33d7f@spud>
References: <20240615-th1520-clk-v1-0-3ba4978c4d6b@tenstorrent.com>
 <20240615-th1520-clk-v1-1-3ba4978c4d6b@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GV1+ODsExlaKnTkx"
Content-Disposition: inline
In-Reply-To: <20240615-th1520-clk-v1-1-3ba4978c4d6b@tenstorrent.com>


--GV1+ODsExlaKnTkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 15, 2024 at 06:54:30PM -0700, Drew Fustini wrote:
> +examples:
> +  - |
> +    #include <dt-bindings/clock/thead,th1520-clk-ap.h>
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      clock-controller@ffef010000 {
> +        compatible = "thead,th1520-clk-ap";
> +        reg = <0xff 0xef010000 0x0 0x1000>;

Drop the 2 cell stuff here, it's not needed in the example.

Otherwise, looks okay to me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> +        clocks = <&osc>;
> +        #clock-cells = <1>;
> +      };
> +    };

--GV1+ODsExlaKnTkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZm8xHQAKCRB4tDGHoIJi
0nakAQDI/dX7wq4wr9fhDskwIEdo5GYlExy1/hq7ZvnCAqI/sQD8DXYLfuYeZ3h5
b137VHF34ez/lW6qbnhU7C8kg1Cl3wY=
=2EDw
-----END PGP SIGNATURE-----

--GV1+ODsExlaKnTkx--

