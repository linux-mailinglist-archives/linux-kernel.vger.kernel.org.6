Return-Path: <linux-kernel+bounces-510956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF317A32412
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6E83A6CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C82209F55;
	Wed, 12 Feb 2025 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CO1SZVc0"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B6A209F4D;
	Wed, 12 Feb 2025 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357861; cv=none; b=GhMCvi/L20d9ix3kKp/aIY7k6kTicjXJhKUDp3AKkrLJgIMcRt+7u1//6iwip3+gJjfmfi97C/W7wbC3TbQFZq4n2e3ozVOX9qK5pTcl8oHbLdgOkcmfsQRpXYabSP7ktPr/zSqV8nOaAT8c40LJKeZ2M2YGO7TxrzDFd6apEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357861; c=relaxed/simple;
	bh=DxsRVHn+IoOw4t6HcvfmabIuE6OhYAGH8nufPSrhJe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOsZ7MG67x62xzi/ToibRSCo1Bo+ytiMvyZexu3NfEkMrfbrwT2vYdv2+uyTI/KnTtcg4E9ySzhvoizLjcPR4LD1JNFpiktUo/RjzJeF7nA7H5qAVo5VzSYTS/yHGSIsUd+2/9JbscHkXuuJ+wgk/waeaX3E2CEqQ0QO7RoeywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CO1SZVc0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220c2a87378so5426115ad.1;
        Wed, 12 Feb 2025 02:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739357859; x=1739962659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gUDk1zcLrpXnvzTsm2uKzR73IoX4Z07XrYWZgkm6NP4=;
        b=CO1SZVc0w+Ug649tIgy67I/jCbn21U0K1j4Y6eV6o3zxb1MhW3toJRw87Me0/2eIQk
         X+57boYqxvwCnQtawBpgKUw0Vi/dDMiAU2hOfXAL+moujDMgKZwN6xjm+xezPnRQrIHt
         Q/IaM/+dg2Oy3BpQE5ZRGM+ex4esVCb6OowRvXMaPsXFbvvB/mxo+u7tg6htW3dE5i5u
         g83/4j+syEO2YcFDk1DtpDE681aNuUh/VNUV9I+wF5KK1tlzq4NlBzXElgIR9GnMfUxZ
         9ohSg0LLniAd1d3oPVk2liz98TEVbed2lmZw9qDHFFNaNxhha9E5j6z9cUbCYSkUL6pZ
         rd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739357859; x=1739962659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUDk1zcLrpXnvzTsm2uKzR73IoX4Z07XrYWZgkm6NP4=;
        b=ttI6WIUQ9Zi38o3DPaWYv4sRcqbmLAfKTvtAv6udDVBWRAiJ1u3nSYEkpJ+nF/SJdk
         6VwmkSuKbkV+DJ5aznZFWTBsUUe0zUudcGKYQQurijxQCFH/cIb/eAJKHFQPrMX4fyYN
         QMMhqSm3n+cQ7DOWrveLbMOVpRcMOFwNQl8TUUimkIUDQ09nhoImaY/LQ3ZmOz5dxFBS
         HbI871Sl1YSj/o9GYALiyMRMs7w73BLSo+Py9FqyTr8YCle0oE0gvs86YeDL12tMobGo
         u3u5WHMMIy1gOe5Fl//Qvvo7OShB6POG6GlbdBcA/2LYjoRPsqOxX+Q0V590IMxXB8fq
         7fLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtw3MGdulA1isExUHhXI4G9wLZ2fAuZtbZ9KTukcjfaUldhLrDQ7/lPhV/OM8koungdmD/2vxEo8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlC3Z5eiQ99Ywgm+Jt00CwmWpeQ/pRKUiA5nnw/ODbJuB8nndg
	RCCH25H0ncpNKhi6I9D2cwS5thwofKOzCV1LwJTyoQ/DTj7yp/4y
X-Gm-Gg: ASbGncuG2RZCAc9yi1Yi2DESz6JCxlLXPhx5Slf9+fDyztNZSjXA62Rp2eAgcPzF3j3
	VmrUJ6ScN7rRB7TWeMzmgaoUV0gVFuqKguRt/Qr5FQgWDMZi4r4zJLcsFKFh8qaKVVtgB4S64eG
	HlagZP3omewrC9WSWbsYWgn9v5hmAMa2BMhxK+8xlJTLSlFIqPpw2kxe/Su4kL/IYaxfUdTnKte
	lR0B2oMWbdhE7OEpPijYlH213A1DGvB4HBD0mzlcg2PsNRg88dnI5puRg4uw/dPep1GTiOdEzhV
	B7MC5mFFkjb6DJw=
X-Google-Smtp-Source: AGHT+IHmYr477s1KuP6so1P+5qf/CdBWlosojZkB2v6AyA9WZxKpAZ1TX3P1VIsLbpp8rD8PP4dgyw==
X-Received: by 2002:a05:6a00:a90:b0:730:9446:4d8a with SMTP id d2e1a72fcca58-7322c3f6d63mr3325609b3a.16.1739357858911;
        Wed, 12 Feb 2025 02:57:38 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73086b7f9e9sm6255190b3a.97.2025.02.12.02.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:57:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 615E541F5559; Wed, 12 Feb 2025 17:57:35 +0700 (WIB)
Date: Wed, 12 Feb 2025 17:57:35 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] docs: Makefile: use the new script to check for bad ABI
 references
Message-ID: <Z6x-n9U7p1rq60ZV@archie.me>
References: <20250211054446.1696826-1-mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="40CA+Cf7cHl0g0vT"
Content-Disposition: inline
In-Reply-To: <20250211054446.1696826-1-mchehab+huawei@kernel.org>


--40CA+Cf7cHl0g0vT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 06:44:06AM +0100, Mauro Carvalho Chehab wrote:
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 52c6c5a3efa9..63094646df28 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -12,7 +12,7 @@ endif
> =20
>  # Check for broken ABI files
>  ifeq ($(CONFIG_WARN_ABI_ERRORS),y)
> -$(shell $(srctree)/scripts/get_abi.pl validate --dir $(srctree)/Document=
ation/ABI)
> +$(shell $(srctree)/scripts/get_abi.py --dir $(srctree)/Documentation/ABI=
 validate)
>  endif
> =20
>  # You can set these variables from the command line.

The warning squashed away, thanks!

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--40CA+Cf7cHl0g0vT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ6x+lgAKCRD2uYlJVVFO
o3TSAP9/vicgk7LXwi5IXt5JDCRfxfl9RPwCsgsV7N+uXvmWLwEAjDOO3MZEuOLB
9cFCewu79s5VFhyFsgINr0nDkvTXSgo=
=2p7L
-----END PGP SIGNATURE-----

--40CA+Cf7cHl0g0vT--

