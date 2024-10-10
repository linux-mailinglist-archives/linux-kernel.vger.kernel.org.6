Return-Path: <linux-kernel+bounces-359057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864969986E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8F4283AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558951C8FBD;
	Thu, 10 Oct 2024 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3/Z4rw+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E61C7B84;
	Thu, 10 Oct 2024 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565079; cv=none; b=KuD0QHnNQAIWLcMBWvynUx2afT95auqUxJdwWLrgXj9g1Gj8cmWtpuGkV8Xx9xEmMUcWoCuQF5BIN9brmbrRnTU0jFMIL7iFahipA7CBMPUJ+hYASVUR0uT8Z1Ntf75DK0zDJlblJAihmA5ZLKrfONwi8ZhilaORk5Bqye+Xz9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565079; c=relaxed/simple;
	bh=T3JPdNWgqvuOuTKAeftYpFlj5uZXKBpVl1V80k/cnn0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JvoF98S9I2lxLbejYXvWyKO3ctAsFkhlifSxpX7H2HHLQVmN+q7mTA6vTvlZPOkbu/GQR1lYi9+7P9iC3RWaWQTyGd5uBF2sXha52vuCiSVEBcyXOzzGApOwjb9OZqxSBRwU2zndvSc4B07rtpzhJbNCVk8Z1ZiDXvLqE9U7Kt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3/Z4rw+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728565078; x=1760101078;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=T3JPdNWgqvuOuTKAeftYpFlj5uZXKBpVl1V80k/cnn0=;
  b=W3/Z4rw+Q2aRXy1hgMxV2I3gI/mPPSjT5vDP1MQf7pLn16Z50HweTCoP
   BpjfmeUgmDuKVTYBSsmR6LsaXC6P+QrFPnNgRQ6gsk0p+otU4ADLARt1K
   N58OVl+g20CUXJRxeGR5NHDmpA8KrKXuzaupOgWBv7YXv/pR2q8cAPfss
   HjBOwsoOQpg1MUFY8dqDCpVhCzu5P5LDQ1iXKt2/DENpn39qzV+5dooEd
   1zbg/1nNrEm5erYDZ+9uJ9PbqI5wWhfdIiIMN5VCeUijv/EFVZH4e/y0V
   +FENhcjd10VXvWCN9sTy+Pw/EZa6zlPaL1eLVraYHZnJjNaQHl3p8pKCL
   g==;
X-CSE-ConnectionGUID: bVsi51XvQeaVP/lQ5XjKtA==
X-CSE-MsgGUID: ewG099Q2RGOdGRWPKYAV/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31617171"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31617171"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 05:57:57 -0700
X-CSE-ConnectionGUID: 7jc+Nv4dRmuik6D1op2Ydg==
X-CSE-MsgGUID: BvLH9yeESWelwBLj91QW5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="114049337"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO [10.245.244.227]) ([10.245.244.227])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 05:57:55 -0700
Message-ID: <648981da5fcf3118b10932eabc07b74c99bf53f4.camel@linux.intel.com>
Subject: Re: [PATCH][next] drm/xe/guc: Fix inverted logic on snapshot->copy
 check
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: John Harrison <john.c.harrison@intel.com>, Colin Ian King
 <colin.i.king@gmail.com>, Lucas De Marchi <lucas.demarchi@intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Julia Filipchuk
 <julia.filipchuk@intel.com>, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Oct 2024 14:57:52 +0200
In-Reply-To: <7feb0520-0cd3-46fc-8b44-a78d1c3a65bf@intel.com>
References: <20241009160510.372195-1-colin.i.king@gmail.com>
	 <7feb0520-0cd3-46fc-8b44-a78d1c3a65bf@intel.com>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 09:32 -0700, John Harrison wrote:
> On 10/9/2024 09:05, Colin Ian King wrote:
> > Currently the check to see if snapshot->copy has been allocated is
> > inverted and ends up dereferencing snapshot->copy when free'ing
> > objects in the array when it is null or not free'ing the objects
> > when snapshot->copy is allocated. Fix this by using the correct
> > non-null pointer check logic.
> >=20
> > Fixes: d8ce1a977226 ("drm/xe/guc: Use a two stage dump for GuC logs
> > and add more info")
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Reviewed-by: John Harrison <John.C.Harrison@Intel.com>
>=20
> Thanks for the fix.

Pushed to drm-xe-next. Thanks.

/Thomas



>=20
> > ---
> > =C2=A0 drivers/gpu/drm/xe/xe_guc_log.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_guc_log.c
> > b/drivers/gpu/drm/xe/xe_guc_log.c
> > index 93921f04153f..cc70f448d879 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_log.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_log.c
> > @@ -122,7 +122,7 @@ void xe_guc_log_snapshot_free(struct
> > xe_guc_log_snapshot *snapshot)
> > =C2=A0=C2=A0	if (!snapshot)
> > =C2=A0=C2=A0		return;
> > =C2=A0=20
> > -	if (!snapshot->copy) {
> > +	if (snapshot->copy) {
> > =C2=A0=C2=A0		for (i =3D 0; i < snapshot->num_chunks; i++)
> > =C2=A0=C2=A0			kfree(snapshot->copy[i]);
> > =C2=A0=C2=A0		kfree(snapshot->copy);
>=20


