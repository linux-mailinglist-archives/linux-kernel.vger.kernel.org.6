Return-Path: <linux-kernel+bounces-352817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D843992482
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A0EBB20F80
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0D214C5BA;
	Mon,  7 Oct 2024 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfABdgzB"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94192149C6A;
	Mon,  7 Oct 2024 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728282591; cv=none; b=VkVbn1VAkV7le11tFWgqVoSB63vf0RK0dfar1jwJCQoIaa8YZIeok88KBCsTmg34bkuHO5Zu8pdqWlywmMN5F+2UdE3bqnvrq0En++nShNR8KO1WOcdBBS9GMnNpDrE990HGPnF4igMb3NQDH+uetFc3eJhJIdj2FFIEex65z9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728282591; c=relaxed/simple;
	bh=glgdpkfaskCwAgy7ZSQIZ/tGLSUwlb7biA7qGB/lKwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhG++RCanCY9eLS8DYfAJsOpD9vXQOXfVaRndBTwdhVahlALtiAIe6643rPibUWcgBBfEuXlgVsHnZEFwyip7fCP5CdTRuRk9V0Vu07lKuIB52gtZ3mWk6FZRfzKh8NazZpjs3OqbUSfjxHpJh5fmH6TGQV+MvxfpezgZ5yK4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfABdgzB; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539983beb19so4850913e87.3;
        Sun, 06 Oct 2024 23:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728282588; x=1728887388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=osnv1yxxdQVp7h+Sp8U/YDqEPinZ/nOSgLBWQfew/P4=;
        b=WfABdgzBnUxSSarzu9iusez+l0XLB8BA3bpr2QphTpEdM4S8zmdMET4i7cPemfaxwW
         G0hzECeCoKyzdeHURC896HrBe0ZBYU/VSpEiyq+00o48DQ4zvzUOl827PhI6Pr04mWyX
         B9V0kajSoaF5mXIzrgP5DSd8HOnsaLjNSv3fx+Ud0JWHobrM2m39OjBJmuc7aMyWRjBg
         IX390P4Qnu0aOaBgMvryDiZj0SZ4JCoA5DL5grEFNr9ts7kR13JVdj2Kn24XPeiuA8Bw
         ZpDmzlL1BEvCRXINqpxvsdiFCfms+kPJuhFLvWxVut86hVtyTFZGubakGY7cYFct0a2v
         xokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728282588; x=1728887388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osnv1yxxdQVp7h+Sp8U/YDqEPinZ/nOSgLBWQfew/P4=;
        b=X+wcnXG3sZgT7SVPGms5vNkjch55KJWJNHREtNduUCO4tgWURaWRYn7ZpW/VDdmwlb
         Aurzlq0CUXTkel1nN2eHLpC3xG/10k3HFE6kdquy3yPGb6elBt1/ownNpYBUGrDqrbtw
         n3S4s07xuSPgCxXHnwazEmQx+FmSkUu/gCQkrCWG4Gyh4LRG70w534QtMfMt1QDSzjuw
         +jTezqfOCjSAtyGAXOHmTC9rdfP8TWs37SB7wllX3rDulsy9XmYQ72Jalw1G85wFmds3
         uCkrqMeCbHPsyX+BDWKPE8dGWSmnJ7h/j4wlaBXOEb8UZahOy7BxAq/hu66v9dzxLfgv
         sTTg==
X-Forwarded-Encrypted: i=1; AJvYcCVmbrWtrMj8jv3Xj+op0WnjR5Jgp/tcR/9WTpqVmoxvN1CKR/gGcqb9PddX2N/z+8lz2qvOLzcP88xV@vger.kernel.org, AJvYcCXsN7bJH/1yf/c2jIuUy+2ltB5hbjMQDaRj75mSBcH2Ux4G0ai86S0Sb7HN4exbbKL43MmbxjxUA0GaAt/4@vger.kernel.org
X-Gm-Message-State: AOJu0YyfnuB/RSeG8JmKMtMV9Kh34ODd5E7v0UPo3Ua4pjmjl4oUDMKg
	A+fmISd3tpuIF0yocfDPxlCrmDIsettYHsGeSJnqMbRCG7s06408
X-Google-Smtp-Source: AGHT+IE7r1R1O5OQdAi7uxj+OWqTtNW67GaV9bYf+ItjaWIPFYGCtZngf3yO0zh1gSmgYJpIbHQ13w==
X-Received: by 2002:a05:6512:3d93:b0:52c:e326:f4cf with SMTP id 2adb3069b0e04-539ab84e3a7mr5206892e87.3.1728282587246;
        Sun, 06 Oct 2024 23:29:47 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec1187sm729051e87.32.2024.10.06.23.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 23:29:46 -0700 (PDT)
Date: Mon, 7 Oct 2024 08:29:44 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: mtd: davinci: convert to yaml
Message-ID: <ZwN_2LsLep_mXUgy@gmail.com>
References: <20241006-ondie-v4-0-ff9b9fd9a81d@gmail.com>
 <20241006-ondie-v4-2-ff9b9fd9a81d@gmail.com>
 <deeflg5wd756tkfr6zdta4imuc7ijwl56yclfwiqexlqdq6jsk@5za5g6i7wj6k>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XEOPtyPcjEau4DFa"
Content-Disposition: inline
In-Reply-To: <deeflg5wd756tkfr6zdta4imuc7ijwl56yclfwiqexlqdq6jsk@5za5g6i7wj6k>


--XEOPtyPcjEau4DFa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024 at 08:07:27AM +0200, Krzysztof Kozlowski wrote:
> On Sun, Oct 06, 2024 at 03:05:47PM +0200, Marcus Folkesson wrote:
> > +  ti,davinci-nand-use-bbt:
> > +    type: boolean
> > +    description:
> > +      Use flash based bad block table support. OOB identifier is saved=
 in OOB
> > +      area.
> > +    deprecated: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - ti,davinci-chipselect
> > +
> > +additionalProperties: true
>=20
> That's a final device schema, this cannot be true. Why you are doing
> this entirely different than all other bindings?

=46rom my understanding, additionalProperties is to indicate that the
schema could contain properties that were not explicit listed here but
inherited from e.g. nand-controller.yaml.

Obviously that is not the case.
Could you please give me some guidance?

>=20
> You wrote in changelog, that you "silent the errors". Sorry, but that's
> a no go. You are not suppose to silent them, but FIX THEM.
>=20
>=20
> > +
> > +examples:
> > +  - |
> > +    nand-controller@2000000 {
> > +      compatible =3D "ti,davinci-nand";
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      reg =3D <0 0x02000000>;
>=20
> Keep order like in DTS coding style.
>=20
> Best regards,
> Krzysztof
>=20

Best regards,
Marcus Folkesson

--XEOPtyPcjEau4DFa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmcDf9QACgkQiIBOb1ld
UjK6EhAAuB6a6IgXxYmSKcdGNBGy+OZA+C2kjYHm8eVvYm4lt5AwVuMSacyjAiP+
UnhA8AyF1nEuXvE4aAE8WuwcJWTwQxPbmpHKmU11Xpb4FSyL/d0V75s4ssWvWlm3
PDS3xlUpEQScMBTBILEtUwZs6CNq3bsUJBGTkEmMODMN/Jet1sX7KCTDG5BBHFSL
QHR9bBA13IJTmB0FgghaDm3zAL5H3Kzf4Rk8yaHqGl7upkS3zdN5fonQsGtpexVT
m6EX1zzXFvb2HoV2vKUCLjkfd4/HHYKw3Tc1xSRPIiO9hEy+4j9M71tWF1tEmuuk
xledFWUWZGH6PH8q6aDormFAo8Gd5ejS7xxzLW3FSk11oNMqz/VFwmEu+6K6zDtS
cIj4ngEDhwsQYWsfLO2yT9XiyMYddQhvnpC2aE7POXnNqQeIiJortYBLDBOOpY8L
9U7YzHgGbsnIsDtOb6m1KovJeaqEayh6L2xMlJlCvmSma+mg1XHeH6tB8SA2AIqo
U/PWrufvWM/gyU4yp/IprKPefF0rvtnr74Jgb07g2abQgiWe3gbE3w8F6C3wj1Mc
4i6PmVg05xWk95SkHxeAiaYgugI0BhdMNreiOdUMVO8MonnTAULC1buX1HMLiCYQ
J7N9NKo42gNgf1dQMc41TXcYtj/VizRwsd6WV9pKwnhSrIHy/6w=
=zXUF
-----END PGP SIGNATURE-----

--XEOPtyPcjEau4DFa--

