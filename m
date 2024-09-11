Return-Path: <linux-kernel+bounces-324344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A91974B67
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353731F23416
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B22116B391;
	Wed, 11 Sep 2024 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vrj47DI6"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E813AA3F;
	Wed, 11 Sep 2024 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039742; cv=none; b=VQxvniTMnsESIoIxrYorjBi1vbmN5ErNAQQp4KD4gAr1fwNnn7CQi4SmsP9fTKoApcnaE8KEZ4RIqm8hQzttnEFnS/bBHAEPYcTzBBf6RS0qp1wZJCcN0JjTsITLnhhGS27hQhP98HELR0FUzb6m01utUCloZJ/bQY2Kw+ZGAqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039742; c=relaxed/simple;
	bh=iakLmgvnukwcswtCPtzAFI8kmqeVXpVpTFw5LuQno+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK4E3/EaoEEczSUyTtrkHRfRqrJ1OStAP6X2/5S2aBFNpXPvkomO2HqPavqCt5y3BJdE3HU3xfdLSaGLzZ52PEvLfr4fTceehUOErVf+d7o5cY+LNRohuZovepAGfz+/2oDFAOfhZ+ijRBH209hP+6mUQVS4s7+QQq6xcUzMc/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vrj47DI6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718f28f77f4so1514910b3a.1;
        Wed, 11 Sep 2024 00:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726039741; x=1726644541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iakLmgvnukwcswtCPtzAFI8kmqeVXpVpTFw5LuQno+8=;
        b=Vrj47DI69wXt3s3+got5Uem8XgP2dhjoA0vA9/owLpIS+m6vpnX5mv6ppYNxjWVTnw
         pW1h/iQT3K2vUeqqDNCzw18NcYY3rgDFzYDY9N0+oSmJ21OvV9YcQaGno5OfPYYjgs3X
         WzIYqAwNIGlQARMn9ABqBoekdYqAGGFPvtIONAe98ZZGEUjXj1PAUa/ytyJPYnTsuY7v
         EMzBcSNjc+7mRz2yYvlMDmhV/UkNT1yU/GVkQFcuYBwsW6wFGT0pAfRIxy9RcK2gcuTH
         76nlskKz6pbqFlz6ncEyHkOmtP5QsxBYrpB8x+eVGowkRKHRwayxggx613LpUR34CHlB
         xeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726039741; x=1726644541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iakLmgvnukwcswtCPtzAFI8kmqeVXpVpTFw5LuQno+8=;
        b=vYVfCGetlOE4BcptikLBYW35fzopJc3aUYdGuMUAQOELcN1dEf94EEujNfSHLhW9Ye
         LbCorM1dlapCx69A/ah2AnvqDRvcPOeCgrHnYhjuDes10+JC7bExMT4pOzyn/REonogW
         8qmzfnCvQnhVqNa163xOt6WEeSlfXbq67Rer++CXfa/bJNP2Mstk0E+onDbR+mLrYalk
         y1EnNDdvD+T/XU5BvuAUrYt6ENZF9Lvzf5MDnemEkY5TxGkNWku+46NdoZcP2IHpbjIR
         4SRCid7Bo3s6sDbzcsKpDoKsgipzo0PS7gyHx9PhSKm/PSyGK/Q3pL9J/9Z+T2T++xf9
         fX1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2O6/5BU4BK2FUNrJPOrxyjJC7NHrnpA/92LXbyFaJyyZ66GuNmMy6ghMtxAPvvmbWH+Ty+qykQOw=@vger.kernel.org, AJvYcCXdtOdd6IVE3kmSwC0jKiRYyX1ZDLUhIvaKr8XasrLabdWPbw1M7UsHKNHGwDAgFL41pSnRh5QyYD32bIYs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PEdgSvmDNsV9rZI8LKGW9+yhrUvAwtqIEaojUC6wWxiWWyWG
	G6stKXLkOx4pV87h/ctLYG95Kq0+9nUe20cZK/23jg2LcwX9kHH9
X-Google-Smtp-Source: AGHT+IFox3Oy37dkHcW4zCrbt+yyMH8RpvT5yN69nrUau6VYcU+/WxmcW11NcONfdC22LqiM/YfTyQ==
X-Received: by 2002:a05:6a00:928c:b0:714:28c7:2455 with SMTP id d2e1a72fcca58-71916d950a2mr3374011b3a.6.1726039740385;
        Wed, 11 Sep 2024 00:29:00 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7190909226fsm2475877b3a.98.2024.09.11.00.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:28:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D27674A0EB87; Wed, 11 Sep 2024 14:28:47 +0700 (WIB)
Date: Wed, 11 Sep 2024 14:28:47 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.l.liu@intel.com,
	eric.auger@redhat.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, baolu.lu@linux.intel.com
Subject: Re: [PATCH] Documentation: userspace-api: iommufd: Update
 HWPT_PAGING and HWPT_NESTED
Message-ID: <ZuFGr53PK3HvhRHl@archie.me>
References: <20240910204111.7969-1-nicolinc@nvidia.com>
 <ZuD8tsci0JPikUYL@archie.me>
 <ZuEbir5Np3sUFkHz@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+bsyqXFVwMp8PLlE"
Content-Disposition: inline
In-Reply-To: <ZuEbir5Np3sUFkHz@nvidia.com>


--+bsyqXFVwMp8PLlE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 09:24:42PM -0700, Nicolin Chen wrote:
> I've applied the diff to my local version and will respin another
> version after collecting remarks from others.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--+bsyqXFVwMp8PLlE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZuFGqwAKCRD2uYlJVVFO
o/miAQDDyi62rowi/sUwnMvXfGllpnhSXAx5LswuPKFU/6HbbgD+JAv+CSyrdd6V
9nVTuBTkoGvsr5MfVDav9vEN5jfDfgo=
=6gHX
-----END PGP SIGNATURE-----

--+bsyqXFVwMp8PLlE--

