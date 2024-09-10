Return-Path: <linux-kernel+bounces-322280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29019726AA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 03:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438A1284C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 01:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE1113A41A;
	Tue, 10 Sep 2024 01:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT0gekev"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D989139D00;
	Tue, 10 Sep 2024 01:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725932610; cv=none; b=eF2PE6mEKnM6SoottfN4+Gu9wF2wD5i31918SMNBXpwe9G9siyky44HMtDT4H42stxE3J6mR5rKgiNHFHUv0XK2mKUJFKtDT7njsKiWtOPD0PDrIHqVutPJWYVYOD1wdVLjA/gs14//5S1+80PBLjTC1dAgWJtHI0ziCAphIDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725932610; c=relaxed/simple;
	bh=YzGy+hp7SZR+Q5o5fS4z7XLw/dNTcxia5QZMQX7D+M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0w2S0GkUvv7Nhm5g7+KX/e8/1XiXKLBdhSqeHC58O0JGS7lVIAXU5T7ii0zlH7MBvSvpb+6u3K1jgrkV1EbgD/hiE4dmPNJ85yg1HR3LLooIy0JA40H+0GikVDETutsO5AM573nk4UV0WvTNOY5ZShVh3rXS3OzO1cHBdWRpJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT0gekev; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d889ba25f7so3224931a91.0;
        Mon, 09 Sep 2024 18:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725932609; x=1726537409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mk8jUA4c/TUn5yczsIGnbvEjRxcVe9zGvkVGlOkcVKI=;
        b=WT0gekevD+dQzRzxqYNF6uecgBkWiUDDbTtBNGLoSwY6dmYSxdky2KOKGBCH0oky8f
         uT5uNhMGt3v0cdun+XvcCsygA4u9ksuXuvXkFmmow+/tjsKG8G2hFDSqo3EBqzJnmJwX
         JGXptoKDXeyGdbOhLfVexBcRh8E35qqYCrcavPJ2cLalPtU2isR0EVef/JeL/kaUqtYQ
         ktytH2DImQJjnSMTHGPoYt7z45U+eUF2EwpqJ5ZkZk7qy7M13k1YXfpZ/4mh6/2ejELM
         jjOfy60gCOFG8at6qjAg6CD2kDlhES7YOdj0WuKweJMpf8P82zCLiOUGLxN5zWJYHNeZ
         XVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725932609; x=1726537409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mk8jUA4c/TUn5yczsIGnbvEjRxcVe9zGvkVGlOkcVKI=;
        b=aHXVde54H1OFgb3qLIOWQhmc5DhQi4y3pdMuGggkYHIrMWpF1K+VIEbxObqCfoUV7B
         IUmMzg6ijl0mpkra5PLz2GtW+QiI/4HYEek3SpvtGZcMhcop8JGLGxJde0t9uqeNUwKq
         EGbLCq2RDKBIea+aiQwkMpQ7X/vfH44smAaVf6etRQg2aGYBiJuYKpDlP91bZ/tWza2X
         VjggApQvT8xAQ0LAtFp+SmdAU5HXf2vpqtL9rAFKHjuNQJDEd0hpAvKEXwovzIKs22HM
         Nc7NparZCref9FZzfLwj/8kjnZyEvMosiMrtkH01m9t+rGagb/p4PXYQKkAn82LnwrF2
         afmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcOu50OH9bJ7bOvNWC9STRY+4XuEEGqYPtPNH823EL0lrIi2Pz8v6UegTTSsYhCDTWNruud0+bVWg=@vger.kernel.org, AJvYcCXFm55+bGvW5DNvkBIl0WpjDpWvgHwU0LK7lBHGGK03BwGWUfOzXe79nsRT0aiw32xIRLsAz9JLf9fB+U9z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9LoPiLks9T7oT9ycsvCXq0iydATxyXTii6qRO/N5ipfLJOar1
	TH5XuVhgMj5EQzfYaYPUs99sVGN8xi6aD7i+fX08tWmtV1bpfCqe
X-Google-Smtp-Source: AGHT+IF89D5+0Db132uWdlVe0BLV8QVcSwLgWZUN+YKoCRs8bHDBlYz6YkznbruQkOCtUpLvmnkImA==
X-Received: by 2002:a17:90b:4a06:b0:2d3:c4d1:c95d with SMTP id 98e67ed59e1d1-2dad501a9ecmr11034460a91.21.1725932608361;
        Mon, 09 Sep 2024 18:43:28 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe4783sm7253097a91.10.2024.09.09.18.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 18:43:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 19BFB4A0EB86; Tue, 10 Sep 2024 08:43:24 +0700 (WIB)
Date: Tue, 10 Sep 2024 08:43:23 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Takahiro Itazuri <zulinx86@gmail.com>, linux-doc@vger.kernel.org,
	corbet@lwn.net
Cc: bp@alien8.de, jani.nikula@linux.intel.com, jpoimboe@kernel.org,
	linux-kernel@vger.kernel.org, pawan.kumar.gupta@linux.intel.com,
	peterz@infradead.org, tglx@linutronix.de
Subject: Re: [PATCH v3] Documentation: Unify format for vuln sysfs
Message-ID: <Zt-kOyU8IbAiAUBT@archie.me>
References: <20240908172341.571476-1-zulinx86@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XklpuDC2wL548uIr"
Content-Disposition: inline
In-Reply-To: <20240908172341.571476-1-zulinx86@gmail.com>


--XklpuDC2wL548uIr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 08, 2024 at 05:23:41PM +0000, Takahiro Itazuri wrote:
> The format for vuln sysfs files was diverge across pages. Unifies the
> format as follows:
>=20
> * Use list table for possible values for the sysfs files, because simple
>   table does not allow line breaks for the first column; otherwise
>   recognized as two different rows
>=20
> * Insert 2-spaces indentation before the sysfs paths
>=20
> * Wrap each possible value with single quotes
>=20
> * End description with a full stop
>=20

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--XklpuDC2wL548uIr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZt+kMgAKCRD2uYlJVVFO
o3HtAP9ydSJlUnUIWRGoqZRShyAz1wauh+fO3nZXIlj4lIa0/AEAzPHfhl1dlInh
t5vxgPUarVyeyUIE+71eSKtE3z6DhA8=
=Sr7k
-----END PGP SIGNATURE-----

--XklpuDC2wL548uIr--

