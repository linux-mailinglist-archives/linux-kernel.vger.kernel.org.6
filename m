Return-Path: <linux-kernel+bounces-341047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F23987ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896C5281559
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2676918871E;
	Thu, 26 Sep 2024 21:37:06 +0000 (UTC)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10518871A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727386625; cv=none; b=Fd0BCSLRt3tngUNj+F/FPfFI9rC/+qwwr5spCzwwviipevPF0bIr5uzPpV1/cfv3oryo1qPuOy2SPr2Oq7fZUPU+aB0y/sGZzrpC++KtRP17xZk2PQlvRQ5nLV2H67w53WN1WOwbj/hFF6glhAJ/iY6U47eDKNEg59lr4jURu6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727386625; c=relaxed/simple;
	bh=yxg9EPFXKmtbf/lHj0s4HsfwkV/vuZolJfG/hidMz1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbNp1P2bIPYJldeBRy5s7b0XIH40xRwTk5p0AMC+oB+qMqUE+SYEKyxy/YQL0qZ//xhxiiUp4i2DculmkXigsx5H3np2f3UjsGM66hfkzqOyuVSWhXBF2zttjSWxNspvj4b8dOmUoQ38CjCmRBmsc5Kz8xlRfbdXkiIKle07Te0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a2759a1b71so6400845ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727386623; x=1727991423;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxg9EPFXKmtbf/lHj0s4HsfwkV/vuZolJfG/hidMz1M=;
        b=FYXur+AGKdsjcU+nupwl7fvtIyn/PfXKJ1laH0yUKwzMprLbHnWye0ckxhNuoJbEFI
         VeygGDa+MQ+v/pKH970zOW/U+KyFwGlvpeN/uR3nlneMBziUfCofkThMpI/ASsjRNFUA
         QfaHiWdL8oDZXmVzuHOYjrYzZk76AlcOssPTOH8fQuTF5W11b2ETCRlx6kMwagv2gbj1
         s4eB8ehI3D9Arr/IOkoyVKUPDghhHdujgDurjFO6XRbIuQ0n/yB/I9UB0wRKW268aED5
         YYjR5mRNKnPQVeSakHP7TEQcW4Po37TaNwCIWk+cCYvjitRaaT/NWgv62djVoGID9BoG
         9w6w==
X-Forwarded-Encrypted: i=1; AJvYcCW7LqWz+T+CUgIPxvcIoCYCvdV+47RHau4izpr4fWCiWTHxZu1B9iw3lKr7Yx6VWX1j59l44Mc4Vktsw/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOQiguQQ/+/EScwQcK5o0Y+3dntOSl70suBG4IXW3499qruR2
	tfJRRrB+6PoMtvdXFHwn2/4IgYuoOb2jKWuOM935lOo0/Sg6K5Zw
X-Google-Smtp-Source: AGHT+IEw8pN0e5JjkbY2wU8/YAG3dLRppNaSov2Z0e1AQ0wPfYaiycEY+bP6DZocBWDgCG+ht7MYFg==
X-Received: by 2002:a05:6e02:1948:b0:3a1:a759:b3c0 with SMTP id e9e14a558f8ab-3a34517160emr10636455ab.8.1727386623052;
        Thu, 26 Sep 2024 14:37:03 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d88884a66dsm146488173.53.2024.09.26.14.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 14:37:02 -0700 (PDT)
Date: Thu, 26 Sep 2024 16:36:59 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 2/5] sched_ext: Allow only user DSQs for
 scx_bpf_consume(), scx_bpf_dsq_nr_queued() and bpf_iter_scx_dsq_new()
Message-ID: <20240926213659.GD26346@maniforge>
References: <20240925000622.1972325-1-tj@kernel.org>
 <20240925000622.1972325-3-tj@kernel.org>
 <20240925170956.GC26346@maniforge>
 <ZvR6z9WoThpP5pWo@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="51Md3y/RnkcraZ7s"
Content-Disposition: inline
In-Reply-To: <ZvR6z9WoThpP5pWo@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--51Md3y/RnkcraZ7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 11:04:15AM -1000, Tejun Heo wrote:
> Hello,
>=20
> On Wed, Sep 25, 2024 at 12:09:56PM -0500, David Vernet wrote:
> > On Tue, Sep 24, 2024 at 02:06:04PM -1000, Tejun Heo wrote:
> ...
> > This API impedance where you can dispatch but not consume feels unnatur=
al, and
> > a bit leaky. I understand why we don't want to allow BPF to consume it =
-- we're
> > already doing it for the user as part of (and before) the dispatch loop=
=2E That's
> > also one-off logic that's separate from the normal interface for DSQs t=
hough,
> > and because of that, SCX_DSQ_GLOBAL imposes a cognitive overhead that I=
MO
> > arguably outweighs the convenience it provides.
>=20
> I don't know. One can also argue that this makes all built-in DSQs behave
> more consistently as the local DSQs can only be dispatched to too. Either
> way, I don't think it makes meaningful differences.

That's a good point r.e. making it consistent with local. I don't think it
makes a big difference one way or the other, but this is something that fol=
ks
seem to get consistently confused about. To your point, maybe that won't be=
 the
case now that you can't consume.

> > I'm still of the opinion that we should just hide SCX_DSQ_GLOBAL from t=
he user
> > altogether. It makes sense why we'd need it as a backup DSQ for when we=
're e.g.
> > unloading the scheduler, but as a building block that's provided by the=
 kernel
> > to the user, I'm not sure. In a realistic production scenario where you=
're
> > doing something like running a scheduler that's latency sensitive and c=
ares
> > about deadlines, I'm not sure it would be viable or ever the optimal de=
cision
> > to throw the task in a global DSQ and tolerate it being consumed before=
 other
> > higher-priority tasks that were enqueued in normal DSQs. Or at the very=
 least,
> > I could see users being surprised by the semantics, and having instead =
expected
> > it to function as just a built-in / pre-created DSQ that functions norm=
ally
> > otherwise.
>=20
> Maybe we can further block it in the future but it doesn't seem material
> either way and I tend to prefer not putting extra restrictions unless
> necessary.

Fine with me, patch LG otherwise:

Acked-by: David Vernet <void@manifault.com>

--51Md3y/RnkcraZ7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZvXT+wAKCRBZ5LhpZcTz
ZC1BAP4qu/qvZyYTjQcay4eZRzcqiGASR5W+w4TdCOKSerXTwwD/QRTmSHCrNhRQ
PtisOTPwuYbyM0Np9mwbXOPqbHFGRgM=
=rVLE
-----END PGP SIGNATURE-----

--51Md3y/RnkcraZ7s--

