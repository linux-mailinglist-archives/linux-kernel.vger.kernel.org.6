Return-Path: <linux-kernel+bounces-512007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC86DA332A2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8583F7A1487
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF5B253B57;
	Wed, 12 Feb 2025 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b="gZbJzqzz"
Received: from sdore.me (unknown [95.165.1.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029D20409E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.165.1.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399418; cv=none; b=mf8/5dCtSi+GIAOsG1QXKXFJBYLen3Xr0oA2HKkyoo5fh0EMgtVd4JwHw3kNHUOZFJom0W1tYN32HAIqMeC0TjI1ok24Ubtwi7qPDqMKv2DOkxKAHFiddc1qrqLVc5hOKxiLP4GrjDUcXZWpvriq5/kCDotrmYnUQmsOQxDzAn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399418; c=relaxed/simple;
	bh=WNonWBF4udDjpPlXnE3uoU9A0SFZBdAVCaeatr2Pkp8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PZQbUUyIsk8weXXC65vjJOyJet/xLP/Qelf0RG5xc9/P7RqE1VXQUbofcUXMRk6/x+IhdS2WwD/yrk6sHPNmn6VlhMQV0wexavLTGIqSt6xb8mYIb16PqNGGcMkS1ruVIxh9s+ziMownms80j/mD5fq8EQGk3jb8N5iS3bV+Fb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me; spf=pass smtp.mailfrom=sdore.me; dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b=gZbJzqzz; arc=none smtp.client-ip=95.165.1.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdore.me
Received: from [192.168.1.2] (beast.lan [192.168.1.2])
	by sdore.me (Postfix) with ESMTPSA id 9F09CEE7BBA38;
	Thu, 13 Feb 2025 01:30:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdore.me; s=SERV;
	t=1739399412; bh=WNonWBF4udDjpPlXnE3uoU9A0SFZBdAVCaeatr2Pkp8=;
	h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References;
	b=gZbJzqzzCk0aTRzEy7iYphVtTMN1EtCpl4X8rR8TN8rUaYLO8Nk9KMeNt5lq9Uj24
	 PN3VyiBSftdwXVc3nOIX364aWx2Jrns85L8vKPxHDwFq2aWPZ0XLISttf+WUV5A2Ps
	 87WpnKj/SZ2vfmoSGoqqMaoUOb9Uy5rXb0hseWvg=
Message-ID: <f0e0d4e7f5d552cb82cf3c9243f15772268fa311.camel@sdore.me>
Subject: Re: [PATCH v2] drm/edid: Implement DisplayID Type IX & X timing
 blocks parsing
From: Egor Vorontsov <sdoregor@sdore.me>
Reply-To: sdoregor@sdore.me
To: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst
	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Egor Vorontsov <sdoregor@sdore.me>
Date: Thu, 13 Feb 2025 01:30:12 +0300
In-Reply-To: <87zfirzerp.fsf@intel.com>
References: <7cab8349bc8bb6fa08d2a7127a724efea155f154.camel@sdore.me>
		 <87zfirzerp.fsf@intel.com>
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

On Wed, 2025-02-12 at 11:35 +0200, Jani Nikula wrote:
> > +	/* TODO: support video-optimized refresh rate */
> > +	if (timings->flags & (1 << 4))
> > +		return NULL;
>=20
> Mmh. I'm not sure I'd go this far. The bit indicates *two* timings, one
> for which the below *is* correct, and another additional one with
> vrefresh * (1000/1001).
>=20
> We could just add a drm_dbg_kms(dev, "<message>") here about missing
> fractional refresh rate, and proceed with the one non-fractional rate?
> Or just have the TODO comment with no checks.
I'll go with the former, for now.

> Either way,
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Thank you. ... But!

> Are you up for the follow-ups too? And since you've got the hang of it,
> maybe fix struct displayid_formula_timings_9 hactive/vactive to __be16
> as well?
... at this moment I realised that both the specs and the legacy code
actually indicate it's indeed *little*-endian shorts!
I.e. `x[0] | x[1] << 8' -- that's LSB-first.

Also, virtually no code in `drm_edid.c' uses big-endian.

Thus, I'm fixing both my code and `displayid_detailed_timings_1' (I
suppose you meant this struct instead) to use __le16.

Egor


