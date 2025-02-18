Return-Path: <linux-kernel+bounces-519725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A19A3A116
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F9116754E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF6526B09B;
	Tue, 18 Feb 2025 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi7pV0T8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C7A211499;
	Tue, 18 Feb 2025 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892271; cv=none; b=fstREXjVa04VT0w95us+s4hAxVzl1BSqpvgIT9otTf1QmI3uZvGDToH3pA5A15mlw+cPkHcfxLXth4/f6NtJmNIE0doZrO1wMNjroK0ouBwXJqr8Z7x4HtVapWOiBqJluvK2iCfVy/jMRhcGJxSXQO+36ACUoziCmbHr5pa/swY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892271; c=relaxed/simple;
	bh=lz+IyjJeomORXfyusNlUxTlQKv9XoLXCm88WmFfwjQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=an+g5QbxWs+NJ70CSLSTJ6sAOTR7xc3Wd3hWl1MngPhRz2GBscATyyEscvm9Q8/PebdMfM9AhQqodAiBOdynCDVYaCpgURhqKskiC9Izo5r1tObBU3t6xYVuFyZDWAvlZMSJit3X+NvWq0yPjUJa9V2BHZHkq22QulmoQuonZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi7pV0T8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853EAC4CEE7;
	Tue, 18 Feb 2025 15:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739892271;
	bh=lz+IyjJeomORXfyusNlUxTlQKv9XoLXCm88WmFfwjQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zi7pV0T8H4ZKlrgST4w04TpsySEYItjStCjRX9vqXf862KIKJQXM+1GUzxSKIhsIF
	 tmWeDJKKNXsmAvqcmSB31VHZ/SnFcht2yq6XocAsLxXS6mE4QxcM7qM8LTtTXigVBZ
	 OnSja8HCzVQUcNAjn+u3AT3M63LUBzZR9QKhBEijXKHj50mFZxBJrZBuj908pghYyg
	 Yp8Y4+MJJft6r3HQaEBFVhNkdxKSKh+bvOu6GIbzpC8FtLlWySssYF8OEpZ3TKpXzU
	 QsQJ2JPMj9+2rns990BeQWyE8QUa7pwg7zZ/qRsFAfZra/gB3tzukleV5nGGh9Hj4G
	 3S/6Sz5jg0lCA==
Date: Tue, 18 Feb 2025 15:24:26 +0000
From: Mark Brown <broonie@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 14/29] ASoC: tas2770: expose die temp to hwmon
Message-ID: <Z7SmKoWF0zLoDoLc@finisterre.sirena.org.uk>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-14-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tq6akGPotT7yuHge"
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-14-932760fd7e07@gmail.com>
X-Cookie: Editing is a rewording activity.


--tq6akGPotT7yuHge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2025 at 06:35:48PM +1000, James Calligeros wrote:
> Create and register a hwmon device to export the die temperature
> to the hwmon interface

Oh, so there is actualy a hwmon device added (which was why I thought
you were ignoring my review comments on the last patch...).  The
question then becomes why also have the custom ABI for this as well?

sysfs files are also supposed to be documented in Documention/ABI,
though actal enforcement of that is a bit patchy.

--tq6akGPotT7yuHge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0pioACgkQJNaLcl1U
h9BGHQf+L3a01Xe4BXkXRpARVZ/PhW4X39H8P97msP/0wqI1E8dPDNB5OfcQhrRo
pbpjIX+E0hBnDTk6JBEpRXZzWjewRofoLx6shsfGJCPhxOFkEFJJgYszoWJig9oh
1UxhrPionc0Rmf74oliCQ+BzXS0LU7FsPOZAYjnmbOJ6NfzUyBaeh6s1tVS+jetM
moYZmVaVkD6SQ39nMUi2bo1V4P2bL2fsFLqKKi5pZO3air4AWmI5/KSd07QWye3J
hTkA9iktMLFbXaXZFbujvIkMPxaYb00fhZFE8sjT98wvYHS6Co2c1PBMPM13wFkx
9aSONFIY88HmnowcJtiHcFc3SwxBRQ==
=lXao
-----END PGP SIGNATURE-----

--tq6akGPotT7yuHge--

