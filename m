Return-Path: <linux-kernel+bounces-182371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11898C8A75
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682611F24803
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016F13DDA2;
	Fri, 17 May 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/0c/y9F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFE913DBB2;
	Fri, 17 May 2024 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965358; cv=none; b=rc+9OMSXf+7yoRixvkdz5SKz5FlIzznxZrnvLh2lR8BivFFNXmQxnKcykOdVtQcqOPSrNQ5C3TN1kWlzriCmn81+a8yQwuyYPGLDDyewh5Oxpj3lG+1otzRoGk3fGuaKsVkd4W/mHMrMJNxngfU0Ga2RqyvKTBtScu/aFJ8n+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965358; c=relaxed/simple;
	bh=a9qTdLj24waCyJqkBNOPq9CVw+6PnI5f9rvBm2lXyEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQyy8HchDf0R6kcZcUYuSpgcr4CLcKMfNViJsUx5pOthigeHNSBlpiqixN0+4KP43PwgxNv6sXz/1AK+7k6rG7m0nEKPoL6NnQSWTD/wg1A990HMsEyOWEUkcP4qpU/kaGNyrg9/NtDnjQjb849KUDlARFiw8GkqGOtsc/SgWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/0c/y9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CFFC4AF07;
	Fri, 17 May 2024 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715965357;
	bh=a9qTdLj24waCyJqkBNOPq9CVw+6PnI5f9rvBm2lXyEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/0c/y9FsVPkTUc0JYrmy/XwpOODWBuwLiYxOWciUnsLiLJzvLzGZ7itQVRzJaAB4
	 kZEwIzGJCOrZ2NTY28sZD5GwUqSClcU7L2jlTudo8rGkqFal+mHNrt4ooQlR1NeJSx
	 dq+jtlpKNtC4uoJNWxdQ5F278xclxVzsZDs7s5Eg6tMw/TYZReFbQSBGIYme2j78ct
	 AX33Lc6YlncbTUZKDBhM7xUcAeFMEznOuL9VuNnWXIGmmUhBUQw7z7srBgAk1TkzKu
	 xoToHyZsb0Twcb6O537rnGl74/ccFGs8fBPc2EFQy4JbtQ4DGxO+GRjsL1HE4UTNH+
	 EqmwOGzhjsjUA==
Date: Fri, 17 May 2024 18:02:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Document adt7475 PWM initial
 duty cycle
Message-ID: <20240517-pellet-visa-a2d469dc5f34@spud>
References: <20240508215504.300580-1-chris.packham@alliedtelesis.co.nz>
 <20240508215504.300580-2-chris.packham@alliedtelesis.co.nz>
 <fe5b3af9-b307-45e1-b190-ba2b3327a8df@kernel.org>
 <d11093bb-230b-4918-a8cd-4f4eb760ccf3@alliedtelesis.co.nz>
 <94c843e2-4415-4786-bfd4-a77fdbbfab07@roeck-us.net>
 <35361786-ef5f-4d81-83e8-e347f47c83ed@alliedtelesis.co.nz>
 <df40a387-37db-4a4d-b43f-ae22905789b5@roeck-us.net>
 <58fb36f5-4d4b-495b-a7cd-6129ab1ed454@alliedtelesis.co.nz>
 <20240517-pointer-cloning-3889f3d6f744@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+X2rjDYBXGZyu12t"
Content-Disposition: inline
In-Reply-To: <20240517-pointer-cloning-3889f3d6f744@spud>


--+X2rjDYBXGZyu12t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 06:00:06PM +0100, Conor Dooley wrote:
> > On that point. How would I explain in the bindings that cell 2 is the=
=20
> > duty cycle, cell 3 is the frequency and cell 4 is the flags?
>=20
> In the pwm-cells property in the pwm provider binding . You might want to
> order it as <index freq flags duty> as usually that's the ordering done
> in most (all?) pwm provider bindings that I have seen.
> The pwm bindings I think are really unhelpful though - they all say "see
> pwm.yaml for info on the cells in #pwm-cells, but then pwm.yaml has no
> information. The information is actually in pwm.text, but the binding
> conversion did s/pwm.text/pwm.yaml/ in pwm controller bindings.
> I'll send a patch that fixes up pwm.yaml.

Possibly cell 4 should be standardised as the period for all pwm
providers and then all you'd have to do for your provider is set
#pwm-cells:
  minItems: 4

--+X2rjDYBXGZyu12t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkeNqQAKCRB4tDGHoIJi
0uXCAQDXCODtnYYARTz+kbcGq3ND2LzQGGADi0a7Lvxv4dhlsgEA2L0ABO/dxCWQ
c1WMqf36kbId4rznhBGJT5PhHcJJnws=
=AKMl
-----END PGP SIGNATURE-----

--+X2rjDYBXGZyu12t--

