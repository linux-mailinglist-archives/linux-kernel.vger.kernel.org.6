Return-Path: <linux-kernel+bounces-391667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49639B8A0C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 04:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8CE282A6C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 03:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D001313C67C;
	Fri,  1 Nov 2024 03:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqNrbQOQ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ABE28FC;
	Fri,  1 Nov 2024 03:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730432752; cv=none; b=tGglp5NdJeHXDiWfFPxMRjm6dKoF+8ICGaq61op7gU1HfivL7/SVb4M2froCrBZlYLn9rF7OhGEFbAO2K9ywXFGEuyYJyOrP+NSQugH/pLBTOrMSxz6nDRWUOJc4EtWT3UNeSHVIVu1FXp/MdGdkO0Wm/2tCgZ92CWFD5uDyZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730432752; c=relaxed/simple;
	bh=cnzUZkbBcBs98pc9YfSXF5HdYH0/67EsLwq9UvZ7gjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nURq1sGyNHXY0pfNBK/jbG3iB2hUSUeTQTxVUenSX/JKB6lgv7uwuJQ/g5YAzxMBR4L+7VIwxSRA1/EX1ERWxN8uY/P6FByUhz6i5rI+PODgE9waM7kHkhNzdUlPRgmCT0RBLGm4gAk+546Yq7Bg4d8tLRYKmO7YzwTf7GSrqJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqNrbQOQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-720c286bcd6so974727b3a.3;
        Thu, 31 Oct 2024 20:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730432750; x=1731037550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iMhg8EkFVCwQt3PhgFQ6nqEf2yCrDLeR6HdVQGVOfn4=;
        b=dqNrbQOQaJ50q+0rHfikv5zsPydiARxt0h/LjjtY377Nrz/1f4SHMF1MnCvx1VwK/o
         O0iM10uaNUvZ+BZocANeJGNGnC3ZKkharCcFcOe8X369e/LJFrl3hw9g0Muz8kRazXdn
         ei/hmQlP7BKP660Kprq+cts0DOaCl1OAHa0vnB+ICtjr+nFD+3e3garuUIkzn5LC+0dC
         racWxELYnOOtvIjsajmSrUhpzZUNUwHkWgym9ojCz/4lQo2A0IVN2SDaKBpQ3+vp85Vo
         p15R+Fs17zORKRSqQs3+sCbsan26BazThuYsmDtpF8ReK2j5+5Dj/YWf9Nl4e1/Br0Ah
         jM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730432750; x=1731037550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMhg8EkFVCwQt3PhgFQ6nqEf2yCrDLeR6HdVQGVOfn4=;
        b=iReYRvTBTQslMYADP1kxeHDFtoQT+Ul3P7vDFD2sa5/WrVkyB3lzz1GuBsZkJzgYK4
         tbxm6/g5TG4dFR9rTtu/O6j+Gi8nq7Kk2VH/gnCWe0y4QkwAk4yQyQ6mSkPwgGAuIg3E
         e0UuQanduxvcKULek+212lk2ZOb+v1j5W4y1glpWdDSrtBIRV/7PkOPKMH834qTfUoWu
         S82D8NDRew855FOzrhzQwYxOHExNmUAajoV38VOs5U6cX7lcsxHrobLzcT/WYhXDROAj
         fxpcfVob0gQ/w6Ljk/eo59KYe0lH4v723NpSEVTYhnBBKCkMHwxjLzL4lkGiud1BmmMc
         859w==
X-Forwarded-Encrypted: i=1; AJvYcCUgsW4Btzm7ngMCc7RHE8Z7kAmUryHOBSTnfYlXGs0EM9zn7Hmr6VqgkBCW7e8XGpfPIPoydqNLIwM=@vger.kernel.org, AJvYcCVfwEQX2/ORd/grHoZk5usuWp1OMa3lkqtrlKbw4AfcHwsFEawoZMWUkAfVjhUZUP5QoBCX95BdL0nr/Fc1@vger.kernel.org
X-Gm-Message-State: AOJu0YwLZ2y/oVicwIxl3918PaTUgw4venfrNZW/4OXr0Znsy6Is32G7
	rZPtcdRd4lvPIniiQhzL14k12O84mluRrK31EF8x47Jzlu4I6d4u
X-Google-Smtp-Source: AGHT+IGxVLYiySzhvZ1mbkUaPhKE067V7/l25cinuk+3o/JtNZxLTUkzVMBNRn33jVOXMlZgC/1KsQ==
X-Received: by 2002:a05:6a00:1703:b0:71e:573f:5673 with SMTP id d2e1a72fcca58-72062fb21afmr28012039b3a.15.1730432748191;
        Thu, 31 Oct 2024 20:45:48 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8d2fsm1914393b3a.9.2024.10.31.20.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 20:45:46 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9A6E3420B6E7; Fri, 01 Nov 2024 10:45:42 +0700 (WIB)
Date: Fri, 1 Nov 2024 10:45:42 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Rodolfo Giometti <giometti@enneenne.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>,
	corbet@lwn.net, Hall Christopher S <christopher.s.hall@intel.com>,
	Mohan Subramanian <subramanian.mohan@intel.com>, tglx@linutronix.de,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dong Eddie <eddie.dong@intel.com>, N Pandith <pandith.n@intel.com>,
	T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
	Zage David <david.zage@intel.com>,
	Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [V2 3/4] Documentation pps.rst: add PPS generators documentation
Message-ID: <ZyRO5iMjvPOXor5Z@archie.me>
References: <20241031163508.259522-1-giometti@enneenne.com>
 <20241031163508.259522-4-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I1RB4s/nr7A5+j/x"
Content-Disposition: inline
In-Reply-To: <20241031163508.259522-4-giometti@enneenne.com>


--I1RB4s/nr7A5+j/x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 05:35:07PM +0100, Rodolfo Giometti wrote:
> +Every directory is the ID of a PPS generator defined in the system and
> +inside you find several files::
  "inside of it ..."
> +
> +    $ ls -F /sys/class/pps-gen/pps-gen0/
> +    dev  enable  name  power/  subsystem@  system  time  uevent
> +
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--I1RB4s/nr7A5+j/x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZyRO4QAKCRD2uYlJVVFO
o3bLAP9ZfzF7O+mx9vvBfsPsj4AWAwS5ul1h/WZUgWvXdmI7GgEAzl/qmVww9rmh
eBJlNxhX5f65/8Pd6XBJg5ff9QIPYQs=
=7npy
-----END PGP SIGNATURE-----

--I1RB4s/nr7A5+j/x--

