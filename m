Return-Path: <linux-kernel+bounces-397833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4A79BE128
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606D61C206A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147F31D47AC;
	Wed,  6 Nov 2024 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRp2tm1D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723E01922E8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882286; cv=none; b=R/sdJKrZ+qW5eFZl30jaeknoEDno2c+O2XA3CRDLIbuLJ45fZA/NmYazoxk8fnLma0ACjuYGIyVi4XDrXd4XnNtdZwJso07E2Yy2TEOlxgJCGKuJYKjHkanWkrb7utZRgFH+0LMaGOELk1hr+FqM+BZFVdT0wz+VZenS2Bp9TnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882286; c=relaxed/simple;
	bh=YgU92Inzmo2OGXiMJhJYEY7fKfhshzRIDsqVsaD18zU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i/g0MTRCWyguU71M+EmhcT0GrNwROKjWepdQzPOHOYDmRJ24D3EM3smHa6JsG7XgZSW571Q5coC/APoouUiOUTMv3Ck7TTWxuXzZO6VPHfvOrCA6GS7ha+YCCZ7o6JrfPHJkYHt0YdILGSF0SrQl7x+j4nkT1chgRB5XBpvnpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRp2tm1D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730882283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8R+edCnMlYIHT6YcW/hTuojpsCOQL3uAz99YEovrw8=;
	b=KRp2tm1DihMyZ5wqY3BcCbXjOUQIz2WTUNtXgVDDZrGz3eS+Sj052zsPskCjc7th/ek/Qa
	jTHa3H0U7x92SXHAtyvtrvImuNcehC+6wcyVhWb9jvzInP6p+uxDyIOrlBQ3OcwsRZiaCX
	D4EkcjqWx2XaQ0ecZLBpbo76fZSZ7iA=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-IVXmC2UXNFSBAEbfLWAr4Q-1; Wed, 06 Nov 2024 03:38:00 -0500
X-MC-Unique: IVXmC2UXNFSBAEbfLWAr4Q-1
X-Mimecast-MFC-AGG-ID: IVXmC2UXNFSBAEbfLWAr4Q
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83ac0354401so724293039f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730882280; x=1731487080;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P8R+edCnMlYIHT6YcW/hTuojpsCOQL3uAz99YEovrw8=;
        b=gsTggC9Q//thGVj87zZDIywSJRn8uplJIlLHUURdV+ennu9TH8sOM0rkRFVDXuZxt8
         yliuGss2je7jQUGjtwCeQRequQMN7QUebh12bHA7i7jb2Q2VxiLZoj1Sr+GlkfzLVGTq
         g77XIcr2ig+XYk3lzYYs3hJlMon3Z4Ofk3LDqXNzVwxCvZMAux4pPDUeHM8GgYYVgtlu
         XxIOIDzAF4xIO6wcNaHwkcl0/s6+/xhw2qLQOSb09BGCRi0aVcO9J8KS3Sd/NEy91PFm
         jNLlTRDRiFlD7cmdOkQWordW4XuV1f1U6heFkr5zzM7+NBULO2m3oT+aX5PBM6xRfUFS
         Y0Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUn7Phr+9Z8CDR2nCwWqSM2LqvOdBrOF5oGPukyrmDLARjF/RYgZXLjO37j6ieX5ClvhnnojFJSTWO5KW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXwK41xb5EZMoun4x92b9sUq5mLK0Bo1Rv2kxL/p7PxtsexAa
	ejc7ICeI7zkpjd9kN8jfdaA/xDONxiLKq38u+7E6b2/LcLaLZwpW2LG/3U+V+kRmyd/Ll3EsV7n
	Rb2y4HsgWWkXQuikbEgunPSpLAWZGH1Me7yd8FR/PGBJ3fXuSXEoBlj9G++SkdA==
X-Received: by 2002:a05:6e02:1a8b:b0:3a5:e587:f7fa with SMTP id e9e14a558f8ab-3a6b0328e5bmr194179925ab.18.1730882280325;
        Wed, 06 Nov 2024 00:38:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGrp+Kq9oeDJXC6cKX/VL+Kbzl5O17jFc9ehGM64T7i6V1n5pIAdWUiSRgheecOb/on4phKQ==
X-Received: by 2002:a05:6e02:1a8b:b0:3a5:e587:f7fa with SMTP id e9e14a558f8ab-3a6b0328e5bmr194179775ab.18.1730882280036;
        Wed, 06 Nov 2024 00:38:00 -0800 (PST)
Received: from [10.32.64.16] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee455a7257sm10572741a12.44.2024.11.06.00.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 00:37:59 -0800 (PST)
Message-ID: <b778fb587d7ce15b89847627ba3caca2d8d060d8.camel@redhat.com>
Subject: Re: [PATCH] x86/platform/intel-mid: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org
Date: Wed, 06 Nov 2024 09:37:51 +0100
In-Reply-To: <ZyoxPQPupkorXPoa@smile.fi.intel.com>
References: <20241105112521.58638-2-pstanner@redhat.com>
	 <ZyoxPQPupkorXPoa@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-05 at 16:52 +0200, Andy Shevchenko wrote:
> On Tue, Nov 05, 2024 at 12:25:22PM +0100, Philipp Stanner wrote:
> > pcim_iomap_table() and pcim_request_regions() have been deprecated
> > in
> > commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> > pcim_iomap_regions_request_all()") and commit d140f80f60358 ("PCI:
> > Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()"),
> > respectively.
> >=20
> > Replace these functions with pcim_iomap_region().
> >=20
> > Additionally, pass the actual driver name to pcim_iomap_region()
> > instead of the previous pci_name(), since the 'name' parameter
> > should
> > always reflect which driver owns a region.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> ...
>=20
> > -	ret =3D pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
> > -	if (ret) {
> > -		dev_err(&pdev->dev, "I/O memory remapping
> > failed\n");
>=20
> Btw, do we have a similar message to be printed inside the new call?

Hm, no, it seems I forgot. Normally I keep those messages.

In this particular case we probably want to say "I/O memory request /
remapping failed\n", though.

And/or we give back the error code, which would reveal the exact issue
through -ENOMEM / -EBUSY

P.

>=20
> > -		return ret;
> > -	}
>=20
> ...
>=20
> > +	pwr->regs =3D pcim_iomap_region(pdev, 0, "intel_mid_pwr");
> > +	if (IS_ERR(pwr->regs))
> > +		return PTR_ERR(pwr->regs);
>=20


