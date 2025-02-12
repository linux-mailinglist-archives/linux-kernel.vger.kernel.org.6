Return-Path: <linux-kernel+bounces-510483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507DFA31DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CF618891E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB29D1F0E55;
	Wed, 12 Feb 2025 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b="jnDJcnUs"
Received: from sdore.me (unknown [95.165.1.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE092BD10
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.165.1.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739336412; cv=none; b=W9oXhyqj6jP9+dUWNe5dQcisFLiIcHdbWqcwJqOcKEPpwc9EQyplPay12KWK1Xtg4sBcGfQFYhK+VQG5DKp6oKr6TawnuX9fRYLAYMd1FCHxE6v0B9qud0/hM4Ki1RvfNJBidaPniOMji1rZO6624LxQxx66p7W62Ib2ITU1+JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739336412; c=relaxed/simple;
	bh=LJ3FscKzRFI9xG0SkR9TnsxjH4mUlJQIc9iKxWW8SIY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YYM+Cg3MCJxzoZUqu3eUw6H+61tFgWBv6rH/pR7T/yUfvq82PcWJUuePwZbACiibKJAcZAM8Az2rAyBiqByR7EAEY9FcD/dB1aG7ljve8PEoIAAOilCXI7Yoj/Cz8Ij/yPwrn8EqVh87V7YhRao1CZOtFi7Efi5PVA9U2Dyfgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me; spf=pass smtp.mailfrom=sdore.me; dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b=jnDJcnUs; arc=none smtp.client-ip=95.165.1.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdore.me
Received: from [192.168.1.2] (beast.lan [192.168.1.2])
	by sdore.me (Postfix) with ESMTPSA id D92E6EE799DAC;
	Wed, 12 Feb 2025 08:00:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdore.me; s=SERV;
	t=1739336400; bh=LJ3FscKzRFI9xG0SkR9TnsxjH4mUlJQIc9iKxWW8SIY=;
	h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References;
	b=jnDJcnUsDl0NboJDUdqlBHA29ZwiS0p8aqmiJ3yu93AG/RJM0evMtOHplnRhc9qRG
	 CAhxDwnfT4NT2/h2fVVw7f4H6l4aOd9sJFBIaMwm5fuWeNLEOD+ecT0Vn1s01GWhgz
	 zqQTyb46Q8IGZfeR5iWG1q720u0TaIqa+wPjBAls=
Message-ID: <8968029b9ceb0bf88106e8372f7a2c4a46780f61.camel@sdore.me>
Subject: Re: [PATCH RESEND] drm/edid: Implement DisplayID Type IX & X timing
 blocks parsing
From: Egor Vorontsov <sdoregor@sdore.me>
Reply-To: sdoregor@sdore.me
To: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst
	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Egor Vorontsov <sdoregor@sdore.me>
Date: Wed, 12 Feb 2025 08:00:00 +0300
In-Reply-To: <87o6za3ujp.fsf@intel.com>
References: <e60254ec3544d37367c9917bc0e1cd5fdb95248d.camel@sdore.me>
	 <87o6za3ujp.fsf@intel.com>
Autocrypt: addr=sdoregor@sdore.me; prefer-encrypt=mutual;
 keydata=mQINBGDSFnMBEADfvtLiuRL6CHdMzETKrux7sNHWG+eJ2+pgRZ3Nc9pH/YWqjoed8OpFx
 OLeUxr9YSQ3uMD//JEe3+Sgte29Z3PAAHVkCwKBIucCnhHpXbcQZgC9xYMCd6GWR5+DpXN9szOIyb
 kvnEtuqTddz6Q7fYsaFDs0pH3jUUWmSAyCn2JCIRfT22XgO44B/yoqnM3JXHAayeHbEAQOzMe81q3
 deauI9W7SC9ScRT6VkgLuc+SxqH99el/OkiKTe/QpO6I6cVS8leesqnOGffkRPos/o2eRonqgDu0e
 Mw4YTu0x5iNr8Lbr4TefU2W1l6M3MNwOsLmI+58+3fK1vh0QqZ70NC4eyD9UEXk3mJyV7epfNU6fY
 0mFJbAhGV1TXomcy2MlOD1rDixw85zdK5uUwp0tfEkpxqKtihJmrTdApOTTVed303CLzgDsMokTIe
 aUOPqVZoWFDkvOzq6IppBkApJHBf1lcLlgwEn3cLQlGpYRSSi5NY3+UYtcOEZLDbF3TO6ncY8W2h3
 yQH/sAcSllfKKvkhdqEz4/Mha3GbZQXWgjrLy9BcISsQFj+DBN54I6a6kLm2n5wXH99sOp7s3jMeN
 zSU6PtuxZq4Gkt2K5JGT8yrIdfJfOH7yRUVm+8JqKNKqd6oczlDKV+lzRk9M/kjb8VQivaNSNwTo9
 3NxEuft0+tZgwARAQABtCJFZ29yIFZvcm9udHNvdiA8c2RvcmVnb3JAc2RvcmUubWU+iQJOBBMBCA
 A4FiEEXlTCjXwaPBiJP3U33a9iH2xv60MFAmDSFnMCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4A
 ACgkQ3a9iH2xv60OquRAAgbgenXi+Ud0tYoAz6giuFKYqzuEYuoSVkjxYvZq90ODrzbu7EdvMVuKA
 qNqYjs3VRBPBMHXhJKEftKbX4bZwCoC2o2wB5oV5O13jVN083r49FTLCxmOoufCkaqscBBxi/X2T6
 +i0n5Nqx5NLBL0kE4NMTk1jxEEyuEjv7bBMs196G/d3EpNJT3YGkLXBUibpaSaVjE6zBr3UygieLD
 2QXNkRJubx2d0FoD8TezSt5hsHWg9FOElsW6ZImRI+5q+ptL39K3cpjxHMKyhmo7xypD5XNWdmsmV
 1+STnK7R+id18xs7JUDxHBtG7Z/3K6txgF5CPbPvtaEi9fB3K/uS03BnIzsY2/cY3r9UHHrHa/sP6
 DhDwj9dr2xIFG5w6ZNh4mUTHEJoWKEEsYKwXy2eJCB3XvP7GURAm8fXdIapONbHDYj7XX49Mj+LBr
 s4PNBuKaZTFgGQ6RSc7LpAR56xaEDR93m7zNy84mQtpab/owaox1A+BEujzKK/vEDvj9f8EWlWZRa
 DH2auNNAxdr2ACR8RzkojcFDCErAgc5sFQrgVUlvNmMdn3VL0CWmndzEQxsOdgVk9SwoHHYpHf4Cg
 gtchq3pTQ5XSRaP/wxOtQpzqJWq5uFERBTLU8WRXYv3mM3KMdvtTJadF8+P+KSSnn+/yHahR0HKVx
 PtHSH7Px/vI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-10 at 13:31 +0200, Jani Nikula wrote:

> I think "Closes:" is what we want.
> Sometimes it's good to follow the surrounding code, but let's not
> duplicate existing mistakes. ;)

Ack!

> Please avoid 0b, it's very rarely used. Just 0x7. Or we could start
> defining macros for these in drm_displayid_internal.h...

I guess I'll leave the macros to future implementation, as clearly the
naming here is subject to seeing the actual DisplayID 2.1 specs PDF,
which is non-public as of now.

> Refresh rate is -1 in the data block, so this needs timings->refresh + 1.

Ack, nice catch! Worked for me, might've not for someone else's case.

> > +	if (timings->flags & 0x80)
> > + mode->type |=3D DRM_MODE_TYPE_PREFERRED;
> There's no such thing?

Oh, accidentally picked up from `drm_mode_displayid_detailed()'. Ack.

> > +	u8 timing_size =3D 6 + ((fb->base.rev & 0x70) >> 4);
> I'd go for int timing_size.

I'd actually vote for an unsigned int, as it's a length and can't
possibly be negative. But sticking to the M.O. of the file here.

Thank you for the review! Fixed per all other notes, as well.

Will resubmit soon,
Egor

