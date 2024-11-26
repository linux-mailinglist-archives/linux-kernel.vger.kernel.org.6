Return-Path: <linux-kernel+bounces-422572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E18F9D9B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0719A1624D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FE21D8E18;
	Tue, 26 Nov 2024 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMCYUhPy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589371D63FD;
	Tue, 26 Nov 2024 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638080; cv=none; b=gG1kme4YqiRq1+zNWNBjbBBU+ozIKCgSWq6go6Et/eUprRrafz2p+tisPSrlvAzY6NC1EOgMRhXddEyHcAdHz95sYEhOYCXOZxCoGJihePwZpzbz1r0ltJYw2s8q4JQ184KCrrPADlAdkkBMEKq5DdbES8SKzzqc3YWyqdzoTMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638080; c=relaxed/simple;
	bh=5NmvJsX5yjhL48h+migyyRcy62wI2+uB4AjXYTR6pJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAHTEObokE149jCAbQUVwSBtNhn3UsQRJylvSrhKj+8xfQVzjttvjecPtyxAj3m/9KZYmezU8/FTHJh2C6EmkvMa1bJYNEfKsOEYaIeWAToyoPsfIabopP2wGyHXDqvIwyAlJRU2uVMW7P40VfbV5YY757EeBpFoFfDiEcnsqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMCYUhPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39030C4CECF;
	Tue, 26 Nov 2024 16:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732638079;
	bh=5NmvJsX5yjhL48h+migyyRcy62wI2+uB4AjXYTR6pJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMCYUhPyDHSp70aRs9lCF0ePGlUnJoPz828YujfSa5tOGr4vA6E3+XgtSxhgioCF2
	 Wyq6iM1Q/77BYaDvbRD1baY9O7wwWxdZxei4UpzAK9qv84fQc+6QIqOjDLX6qztRR2
	 SnTzDzk1Rwq3pZMn/J6aDk2MytEj/5YzyLJdxXmyrpUgXCITa6qh0yJB9cw+QdyjDM
	 gTJSFF1zFKwQP61UEKjXvySx03BNVpJCpFWxf+A4hiJJh7MAQy5OxYHe25V1P9j4pR
	 gO+kqmHrvdI63kKJTIL24Y2lg//H3aARdtFw0isypQy6EGOThndUrnn4CKo4r9YaHj
	 3r0F1YxOLwTiw==
Date: Tue, 26 Nov 2024 16:21:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	ycliang@andestech.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	peterlin@andestech.com, samuel.holland@sifive.com,
	conor.dooley@microchip.com, alexghiti@rivosinc.com,
	ruanjinjie@huawei.com, takakura@valinux.co.jp, conor+dt@kernel.org,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: mailbox: add binding for Microchip
 IPC mailbox controller
Message-ID: <20241126-pulmonary-krypton-30da3faa8482@spud>
References: <20241125175818.213108-1-valentina.fernandezalanis@microchip.com>
 <20241125175818.213108-4-valentina.fernandezalanis@microchip.com>
 <vkw7o25szfn2upi5776xdojg5n5fxxaxwynth5kynjwjqzrgua@5lwrjqgzlxzi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UHhEcYF+Tebg/wAN"
Content-Disposition: inline
In-Reply-To: <vkw7o25szfn2upi5776xdojg5n5fxxaxwynth5kynjwjqzrgua@5lwrjqgzlxzi>


--UHhEcYF+Tebg/wAN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 08:04:38AM +0100, Krzysztof Kozlowski wrote:
> On Mon, Nov 25, 2024 at 05:58:17PM +0000, Valentina Fernandez wrote:
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description:
> > +          Intended for use by software running in supervisor privileged
> > +          mode (s-mode). This SBI interface is compatible with the Mi-V
> > +          Inter-hart Communication (IHC) IP.
> > +        const: microchip,sbi-ipc
> > +
> > +      - description:
> > +          Intended for use by the SBI implementation in machine mode
> > +          (m-mode), this compatible string is for the MIV_IHC Soft-IP.
> > +        const: microchip,miv-ihc-rtl-v2

> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: microchip,sbi-ipc
> > +    then:
> > +      properties:
> > +        reg: false
>=20
> What does this mean in reality? Device does not have IO address space?
> Then it is completely different programming model, isn't it?

Ye, different programming models. Two compatibles for the same hardware,
but one represents the m-mode/firmware programming model that has MMIO
access and is the SBI implementation and the other the s-mode/OS
programming model that uses ecalls provided by the SBI implementation.

> > +        microchip,ihc-chan-disabled-mask: false
> > +    else:
> > +      required:
> > +        - reg
> > +        - microchip,ihc-chan-disabled-mask


--UHhEcYF+Tebg/wAN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0X1eQAKCRB4tDGHoIJi
0pV3AP9Q0WEJXVAedx6l0dgDDRC1T1u7gst2xaLmNAJdZULXCgD+NGtzaOJiNZfr
DFwVWzDxNzpUytgABiEoCMczznCo0w8=
=XItn
-----END PGP SIGNATURE-----

--UHhEcYF+Tebg/wAN--

