Return-Path: <linux-kernel+bounces-186129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19AB8CC024
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5751C20D74
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC3E82862;
	Wed, 22 May 2024 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZHR0Qit"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA53C80020;
	Wed, 22 May 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376958; cv=none; b=KRayCQAJtxJjvH2dE2PGyd2yBxC+f8VqwyUQTT+V17ck9lkeI9MjLKs8WvjdTp6/8DU4KBCMElSfuL/CcW6mf8j2IOwd3qg89U2clA+6VZUJn63VCduTTRcjjeV5dV75gK/ADi2CrBGzv/54PxYZUWj8YSLiOveKlR+u/1+484k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376958; c=relaxed/simple;
	bh=XoXUWVXyz0Rmx/CPuiRBeLNAvxQGtHJx3BaC6+uReE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zep3uK1DVAVeXBlNqbXQMxn2DivZd0zQuDBtF5zYIlgtdVY2TPXACJNf4C6i0uoL3HguZo197cA2byh5WAspsfsD6TSTXNH44kIbGto4KNryDKmdA5DcFQ4r6gBbqa3k2TCCbbIeR3Hud9bfWNSaM0Rm/ZlXMYWXL2W1jNRqeqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZHR0Qit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367CDC2BD11;
	Wed, 22 May 2024 11:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716376957;
	bh=XoXUWVXyz0Rmx/CPuiRBeLNAvxQGtHJx3BaC6+uReE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZHR0Qitw07H7122vpe02wbYXfQz1adMBbp2SMha8JZhaAujg/tNRTRTs3dUEOf5f
	 1BO20QlIGB4C2VZdZAqqvyDIa9VDJzGeTZuBzDnrKmnOEBEHmW1R8pKyIEKwIFn5cT
	 Pq3K5rsipiuwsjKiB/rRRmZDtynIJ03d8qTINXhsyv9GuvRMCJdYwSkPLgK2hbOEq7
	 zR258ls5yuMEbVB2c3XgVFLXdKnCiQFgT2aoZPRYzi1//wNGD0x+7H+fydA0lv/pd3
	 u0eDY5jzslNMLKf/FX0Otx6PY9Dk3G858U48ynQgAfi/prEiseW/huT48J1w1cqzzv
	 n7rNmOw7iSAqw==
Date: Wed, 22 May 2024 12:22:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Walker Chen <walker.chen@starfivetech.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 2/2] ASoC: starfive: Add PDM controller support
Message-ID: <297b2034-4e2e-47a7-97bf-53991a102db7@sirena.org.uk>
References: <20240423083405.263912-1-xingyu.wu@starfivetech.com>
 <20240423083405.263912-3-xingyu.wu@starfivetech.com>
 <NTZPR01MB0956BAFCBF0EA32824C3350A9FEB2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2qrOv5Bk3BqeYH74"
Content-Disposition: inline
In-Reply-To: <NTZPR01MB0956BAFCBF0EA32824C3350A9FEB2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
X-Cookie: Bridge ahead.  Pay troll.


--2qrOv5Bk3BqeYH74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 02:11:55AM +0000, Xingyu Wu wrote:

> Could you please help to review and give your comment about this PDM driv=
er?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--2qrOv5Bk3BqeYH74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZN1XcACgkQJNaLcl1U
h9D5Pwf8DExjzr2HmtHrdZqAUJL20nH1D6ECtNx5ETkMKbJg38xD6/SHbymeBLCX
/tisDgYjHzgrKiQn+hs40G/6DL8jqjARtzSrQipr0I9m4enVnoKngiPVcQ+Xfbs8
wFJr8kv1+Kb4QM8vCdpaWNpH1OQ7lhmBUHzqy7N9C0FIz7YonN6LMFGiWHEai/zr
UPUI2jX2Hd/VXl1RPYmJqaFMlRM3cA9NG5v5/+4JZ3yDj6ukB8UlPTLGpAWvnIX2
LyjFR6K/31R8ZbIN4qsUeXCH7Lv8LMIxWVJDjyUO/c6McyTTpSfBpLTdR57RYgHO
9kFqVLynQfx5t2KTeaeUdzb+4pEksA==
=Au8Z
-----END PGP SIGNATURE-----

--2qrOv5Bk3BqeYH74--

