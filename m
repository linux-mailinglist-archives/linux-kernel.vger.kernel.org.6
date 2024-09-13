Return-Path: <linux-kernel+bounces-327472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F06E3977665
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF4E1C23B99
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CBC4A2C;
	Fri, 13 Sep 2024 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXRin4vE"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7434C6C;
	Fri, 13 Sep 2024 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726190654; cv=none; b=WCsZgwlGBKI3jPYx+4FDh3K7cZ88ad03w3DpLTQ2M+xE0DyLRyDlZIO1MYmVswAE22bpeuMhIY1ZN5GUHoV0SSwYZnMtUx5WGLD97v9UTiIDXzakuTk+fYoTcajTRALkEkNMtt43rI35A39euk3QUscFYDXY9fr6WkblmIU72to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726190654; c=relaxed/simple;
	bh=RX99iHM3X+S45ILnyoYhKkBEinLaml5qshNtXrhGSjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKwOBbnOIvlvlscPaB7gTjgatTv4n2j94VeznxOP+1txEsdeXxmY+SwN79rzIUrwv0kb/pzUl52aKv6w9DaY9lNj05Qzya632NXuW7dnwcVCTpc44FK2oFvkqaZzZcaX+haLtgHUISoLYXM/VgwVT0TxRWommxRSdJrhxuVZ0nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXRin4vE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d877dab61fso328814a91.3;
        Thu, 12 Sep 2024 18:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726190652; x=1726795452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CN1N3iY6hg7sVtKbSfdbDShJpKBB5GtoR/npFtZ9dS0=;
        b=LXRin4vEO8N92Tk6bgBXT4/7fuXjGS7nq5LJZ7oJ4gVr0xY10bKHaU+E2glKsjmKIV
         KOfVIwk/KjVysU33woPfkr6hRRDNVMcTkV7OjP3+Iy9dMTQkuIuEBWwGhmk56p3Yw79k
         M0Eqw/bG61NZiGhkPo7jw0xUi/HAwB2gVrsb6PlWX3PO9a6i+AVPxhekBwxUYBk1gOXC
         fuPXgXyKS6FiNlE920eJAkIAZFWbxJPjSg/Fb+dEDfQKZexEAG0m2gvTop+Z4WS2UhuO
         UDmdQp20TUT1ZWLy92TZ/hUR/RQglnq06DJ1+ydQ70EDhXJxRi7/5iGk7QerEqqifIXC
         AC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726190652; x=1726795452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CN1N3iY6hg7sVtKbSfdbDShJpKBB5GtoR/npFtZ9dS0=;
        b=PwE5vCkCtAZFLMh/HQYsoL8PdjydjCNqnXOTGZAAB3PFh1WuUE5/PUrqvqA/r/z3Vv
         lAMgBhxbbStap3+voo+5OgPQNwqGDOMBP/8vk537I0+ga6+XIB69+e1U36DUKZ9G/SF/
         S2SnbpM8iVAjc601CpMLDiLxOvrU7Plh2VcqKBl+0W+BdA7thAh5301dR75LbgKUbupP
         QPGzeEdZw7gZCxNllTNwKYKAe8gG6YDL5TADGXVedU+kF74nbB3atU48mivi9DLcI1Qg
         jOx2/jrXoGB5kWzaYnYCOJTqq0HYV2sLA86FAiz4Qq8CAwuHFvd8iORDo1/Y9n+w8B5X
         +cQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/0AIf8KD76lyIWatqueMPxc8FEa0qKkX2ifUe3qDTaYZkZl/JecozIUIKuXcDFLDJZzF+OrX57dU=@vger.kernel.org, AJvYcCXkUTlKJ6Uv8YUo9HsucADOt3pev+mIJjkm32vzUm6FlEvxgfh8qvHF1G1UlgkO2SpgW+EOeIe0jT/TYL2S@vger.kernel.org
X-Gm-Message-State: AOJu0YxdUsrXMR/mtZ7zMzGS8bOsfMpRYQiddiDOWMZQzPuZ0j2z7a/u
	+ziVr6RDxra/oG9Kju1YKIRHGurRHZt3FjAWcjl6VYl7jstJyeUH
X-Google-Smtp-Source: AGHT+IGn54VC3I9qukbo6RWinzRhc4Fl8ZU0uPSZvawJkXQqN0jhftw4TvGM7XURRDz2D8PxJyRBFA==
X-Received: by 2002:a17:90b:4b4e:b0:2d8:9040:d170 with SMTP id 98e67ed59e1d1-2dbb9edff0bmr1431284a91.31.1726190651765;
        Thu, 12 Sep 2024 18:24:11 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c4dd13sm382061a91.12.2024.09.12.18.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 18:24:11 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 5A07D4A19C6E; Fri, 13 Sep 2024 08:24:08 +0700 (WIB)
Date: Fri, 13 Sep 2024 08:24:08 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Takahiro Itazuri <zulinx86@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Unify format for vulnerability sysfs
Message-ID: <ZuOUOIdLbSVDGfpI@archie.me>
References: <20240912142542.590907-1-zulinx86@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UnAzdXWw3D8SrGPl"
Content-Disposition: inline
In-Reply-To: <20240912142542.590907-1-zulinx86@gmail.com>


--UnAzdXWw3D8SrGPl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 02:25:42PM +0000, Takahiro Itazuri wrote:
> The format for vulnerability sysfs files was diverge across pages.
>=20
> Unifies the format as follows:
>=20
> * Use list table for possible values for the sysfs files, because simple
>   table does not allow line breaks for the first column; otherwise
>   recognized as multiple different rows
>=20
> * Insert 2-spaces indentation before a sysfs path
>=20
> * Wrap each possible value with single quotes
>=20
> * End description with a full stop
>=20
> * Apply 80 columns rule
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--UnAzdXWw3D8SrGPl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZuOUOAAKCRD2uYlJVVFO
oyIaAP4kAUOXLr5TBC13Iuu/WFVwkr/sL+5uJZA9rMHXZLOZWAEA9yhfsQJ4HNCw
ispJNPTGu6Zi1pzmf530PCJAeKgNwwk=
=UVit
-----END PGP SIGNATURE-----

--UnAzdXWw3D8SrGPl--

