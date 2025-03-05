Return-Path: <linux-kernel+bounces-546724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D61BA4FE08
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E31016BE5B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8A5241697;
	Wed,  5 Mar 2025 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LNzY0xwB"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5861EA7F5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175614; cv=none; b=Wf6E1OFFeb8L++tyZxh9p/6Fr1RZIMaLRnsaBxCasJtZM6aUrHWLapPsaKJRbOalSNdsSMVRW2FTZvphnD35eO+Rd0ryFrWoot7GOwshPRYEkRAt2w5/DeV5Llip2ezAcgQ/M5cdSwKHNT6soeUd9asoKb5ZelVtBLty5Qd/dJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175614; c=relaxed/simple;
	bh=ETscUFb3W9g8uoK4dXkEOb0mnNFPQQG2xbrhc/DTp+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVbyKgMDjkoUQH/leS0GzDYI33t5YKIY6aj/KxioSX5Jfm9d4ZZQ2qVtp0pIbct96/b19TC67lucYEL5aD4+rpMil4JM/1M2LOCGpQBArvacgitSCXPjEyi/pYAMNrLGDEjxGE7qyODKyqu7WvRntuDUf6ECNuYBRHKLrTl+mMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LNzY0xwB reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0FAD340E0214;
	Wed,  5 Mar 2025 11:53:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xMO1CcNIzyuP; Wed,  5 Mar 2025 11:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741175605; bh=Icqf4IZRc494aUQLMvtjKf8rwo7CZb/O4JmauOKLlYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNzY0xwBPGxJy9tJQeWyRDFvomzJ8hdXAxR1CRXJqsxFL8V9XsGVWVuZ9ykJ4aMjE
	 VtSLh3zXMle1gFnTo0TXtn8QXWP/mbYnUV0EOZdXzqCRidQhERd3UF9d0BaJWF5wAX
	 s9M4BGOwtQdeJaV4LNUGkpnURWfBEzjFXmPulyuhAWfe7UGYPm+hM1OEO2W5IKbtZk
	 vR8KI/0lm0P9gVVCRSpB7j3bJC8YDKTWgE+jTIx8t+rHdq6bNOe0EcC2d2mOzg6B7s
	 RPvRy8gYXg7j5OW3CyzBb3Bfh+IS8sJlls/y2/O6MhaSiouQ/jktNXXHUXQVLT47zf
	 DD8Yje6VDjractrRxVRX1CaSn0DPLegPx8QrCEwRWcVqNEsrHyUv04TvINKimUq8LN
	 b0h2sM0N5nLDvH+PPz4EAhS6hFitw1ApiM7GIPy07g4RysKUKLGqo+L+yQi8zBOp7F
	 NVgs38EmSMm7cbsUB24epyaVbG9gLI/RN7QlZ7btBfhv5ct7rN0nOY8ojWQCkPh2fx
	 c5X9BTL5Xm7aRIWJvmFVVngLM77uQCiSxtrrk1RulcWnfU4b6hNQJSAnrqlz7HkCqS
	 5nMcWUWPjBALH3miscioEzqqrq4Ozy/YrRlgYmsrcIh3jfM/YGFRAuSpAwsN3VqLAF
	 kM/VRITg8SizlcQuIgJpvdLY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E04740E0176;
	Wed,  5 Mar 2025 11:53:15 +0000 (UTC)
Date: Wed, 5 Mar 2025 12:53:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250305115314.GFZ8g7KlmTa-eApiwK@fat_crate.local>
References: <20250305105234.235553-1-joro@8bytes.org>
 <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <d9a1a460-2982-429c-b29d-cf2483e9380a@suse.com>
 <20250305114132.GDZ8g4bNdM-I5OQd4B@fat_crate.local>
 <b21842d7-0355-4630-b293-2d29b003918b@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b21842d7-0355-4630-b293-2d29b003918b@suse.com>
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 12:48:11PM +0100, J=C3=BCrgen Gro=C3=9F wrote:
> And?
>=20
> Under Xen there is e.g. /sys/hypervisor/guest_type which shows in which
> mode the guest is running ("PV" or "HVM").

And looking for guest features in /sys/hypervisor - especially for
confidential guests which do not trust the hypervisor - is ironic and wro=
ng to
say the least. :)

/sys/guest

or=20

sys/guest/coco

Now that's more like it.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

