Return-Path: <linux-kernel+bounces-310697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD8596803D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CEFD1C21F7D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B64516CD35;
	Mon,  2 Sep 2024 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMQzWI68"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB915573F;
	Mon,  2 Sep 2024 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261244; cv=none; b=Kp9NXMr6qWdJqrRhMew7PCpYyscLpOh4vUmBB0dhz+9n/XnpujkJ10S9buhxTFCP0KTXUXemDnPa5PW9zhx5i5lj08OxUq4h3p3k+U+5BWESq0uree4aqwrlSxn6qUEaY71aKYvWaxMlqmUrOm0crXYSoleARVM9U78gToibcwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261244; c=relaxed/simple;
	bh=O3qnO4tVE96dExdElJgrtwb4RNjNBLk/w49FLco314M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyFYs03YY8+6DeBHqhLGZi2GTtfvDY0MkiSFPQgzIyVKS4FvD9h2/nv/Xoi7khwgxfp7AH1HHqt6LYSZqTIrkWPAFwBvogPmQCEWqlOCK6BnGrYorTISA39BorYvjuVByhRaEbP4CUKhqusPAT00aZZTYKf1BOnT7D2HVlElxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMQzWI68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B162C4CEC4;
	Mon,  2 Sep 2024 07:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261244;
	bh=O3qnO4tVE96dExdElJgrtwb4RNjNBLk/w49FLco314M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cMQzWI68iVxcoQd0OdaF9PXjcNlkC8twkvXk9oFvQ8vQWQVdmZniY3iL5tMiOSjV7
	 x3933fz6aApN6lW2g5arQrbPeNqoZGkA23llNxCyVcNmAlFaDaZuAb+HAOckNTQsqH
	 KKzlQfLSMdYgeLbIGq24X27AjRDUNy+6ZqEFY8zPfrgb2VK0NFeHgDLEQVPa45M3qS
	 0eS9gijm/EScufrUkg+SHpqzFLGT8ShccjMtUVEuRzGnNgvTdzlKqRDPAbXnWh+gEJ
	 vy4ILa/LKKsH76n2CHq3IOug+5q6osjVkvMwiChvauylnHCIw4XwMadOwyNa0qIFjR
	 6htPZ7v3XKxGg==
Date: Mon, 2 Sep 2024 09:14:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: Conor Dooley <conor+dt@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
	Joao Paulo Goncalves <joao.goncalves@toradex.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	Mathieu Othacehe <m.othacehe@gmail.com>, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Josua Mayer <josua@solid-run.com>, Yannic Moog <y.moog@phytec.de>, Li Yang <leoyang.li@nxp.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: fsl: Add Variscite Symphony
 board and VAR-SOM-MX8MP SoM
Message-ID: <taacgew4rjjh6q53pog4jv2waamso7ytor5a2womrm3txowjo3@t3yimdusgc6g>
References: <20240902065606.8072-1-tarang.raval@siliconsignals.io>
 <20240902065606.8072-3-tarang.raval@siliconsignals.io>
 <f3f65c33-335f-4769-958c-9b75fa7083dd@kernel.org>
 <PN3P287MB18293C640A4A027E6292758C8B922@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <PN3P287MB18293C640A4A027E6292758C8B922@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>

On Mon, Sep 02, 2024 at 07:07:02AM +0000, Tarang Raval wrote:
> Hi,
>=20
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 - toradex,verdin-imx8mp-wifi=C2=A0 # Verdin iMX8M Plu=
s Wi-Fi / BT Modules
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - variscite,var-som-mx8mp-symphony # i.MX8MP=C2=A0Variscite VAR-S=
OM-MX8M-PLUS Symphony evaluation board
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - co=
nst: fsl,imx8mp
> >
> ><form letter>
> >This is a friendly reminder during the review process.
> >
> > It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
>=20
> as per your comment, I did update the board name to "variscite,var-som-mx=
8mp-symphony" instead of "variscite,var-som-mx8mp."

??? No, there is no difference. You did not test your patches either.

When I wrote "This is not correct", it means you should drop it.
Incorrect compatibles should not be added.

Best regards,
Krzysztof


