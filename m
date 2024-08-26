Return-Path: <linux-kernel+bounces-301439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C295295F0DA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C8A1F24C77
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2666217BEC1;
	Mon, 26 Aug 2024 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYKugEnG"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A32915B13A;
	Mon, 26 Aug 2024 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674016; cv=none; b=ADJIdgbLHeHu7Lec1wft6kkRDFRO787Bt0DjAc3ebbjSExj5O69w4miCdXjPYCGTP/VwQJF/V7Nc9ab0OEZDTUskEwYVu0x6Nb6O44pK8W/KGViXCzFZounN8AuQRj63/nAvu6+ueCTB4ldT+R8b1wUfwZzo7CmwYPebUUdmLGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674016; c=relaxed/simple;
	bh=TnVYqFx8iidahUDrnDilYvKd1NQU38KVQJIeCmFEZdA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pagmjcrfoXqM1kP57pepL2AjXLhRjbeksUnauGYNF1mZlJsDk2XA13YZ6weKsxa3PP879+T1G/h66G6cpU4WW0YoIAN0vGzx7io58xrodVUDP0YIRa3FdxDBPKO0ZeP3Ue8vdFmWVrwrz1m6JIM/ZEk1ysLcQWaiRah7i3hLPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYKugEnG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20223b5c1c0so35895235ad.2;
        Mon, 26 Aug 2024 05:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724674014; x=1725278814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TnVYqFx8iidahUDrnDilYvKd1NQU38KVQJIeCmFEZdA=;
        b=AYKugEnGc1aRTT3M6FMk//h23EVA+jIrw8EcA7KRDtvCVOmoraiOBW1Q+tMDEDJnsn
         X9agJ05uYyVv7ZZlbgLAJKTzzoMhvxD+hiFI/pN6SxNcb35XdohfTqPj9vDsci8pSUuJ
         ihfyz0U9ZVzf8hOcVoWPISsJ2SR9tY889I/fadpU7XmjivO1cFvM/IoFmSGrNF9hDMYz
         I0EUEcP930GoHqqlfOBvONK+H1M94kzhJ+RabNh+g9Q3dp5T+n2hJQM4bPE8R8dl73t5
         VhSRkZ/1Bz2BUF4iYwo7xsdaZn3KRvdoYjQbyOGT4DXjCIfbevUgbvbDok1KPUCG2Vao
         ZzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724674014; x=1725278814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnVYqFx8iidahUDrnDilYvKd1NQU38KVQJIeCmFEZdA=;
        b=m8j4j+pnsxNp4qpPIi0qzWqA1On862B7GBQGyw1SmPk5c4dMCauPEWs42nuxmSiadv
         Z84Kk/41kIvQLF7ijj5/62edKziDDeMFaCfLMFDy6vmh0H597Vje2A63ocUSVtB+OMca
         PyayFMv3yRYL8uQ1zPEe/xdd/8Arr9RmpYblvCZeTHmP+zDmWi1GpuQq9xlSdqNe5Rdx
         He8fBie/Bx4zAQdbJ/HOF/krundxQzQUYMC7V/LR7VVRWTdNqrCQ+E/Tq0seoZAA5x7x
         0rrrNjvBN+m57yEcOXtHkmj4GQDL720vp78JHS09NLEnShZAskC50tRhJe5IEARY1l4B
         +x8A==
X-Forwarded-Encrypted: i=1; AJvYcCUPDFK0mA09Ic2eEqGsvjw3JgsVI4N95+qFVPY9X2MnHRm2QYdNyJbu7+5JODxf3Ex9IfyLUl48lDg=@vger.kernel.org, AJvYcCVWBP008GU5OOPYbOTN+IG+EqovuDolbkRbzCr8HJqYvbo53RIUwlHlfM2S+Yo56kVU4c7ptsZNxKISOoyw@vger.kernel.org, AJvYcCViFCqRund+yLL4fwunQrjW7IBgnio/GoqSykR1LFOnwnl8dS1QS1Tw6Rxj2NChY7P0tes6X8pSM14M@vger.kernel.org
X-Gm-Message-State: AOJu0YwxokdyOyD4t4mq1OUlh3AwDgqQx/KEBZ33ePXUWYRrISZNne4W
	G87j2UEd9wNHT1o847avtGe8r+pamFnvF7PN82mj3uUQYtyg7/Uu
X-Google-Smtp-Source: AGHT+IEQMgmfsNtXw28+xuRExp75piWl7tqAWS65ZBXAc9S3z8Buaz9ERqRlQD/RUI0oQs6uHaqALw==
X-Received: by 2002:a17:902:ecd2:b0:1fc:6901:9c35 with SMTP id d9443c01a7336-2039e4d875dmr78754185ad.20.1724674013823;
        Mon, 26 Aug 2024 05:06:53 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20391b7faadsm58553345ad.195.2024.08.26.05.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 05:06:53 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A005948D2E95; Mon, 26 Aug 2024 19:06:50 +0700 (WIB)
Date: Mon, 26 Aug 2024 19:06:50 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Aryabhatta Dey <aryabhattadey35@gmail.com>, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: process: fix typos in
 Documentation/process/backporting.rst
Message-ID: <Zsxv2gilh-zfZbb3@archie.me>
References: <rd2vu7z2t23ppafto4zxc6jge5mj7w7xnpmwywaa2e3eiojgf2@poicxprsdoks>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PtfwvYqb3epCZ1qV"
Content-Disposition: inline
In-Reply-To: <rd2vu7z2t23ppafto4zxc6jge5mj7w7xnpmwywaa2e3eiojgf2@poicxprsdoks>


--PtfwvYqb3epCZ1qV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 05:03:40PM +0530, Aryabhatta Dey wrote:
> Change 'submiting' to 'submitting', 'famliar' to 'familiar' and
> 'appared' to 'appeared'.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--PtfwvYqb3epCZ1qV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZsxv1AAKCRD2uYlJVVFO
o0g2AQCKuw0SRpzN4Byp3EYjPPIjzcxbfsBvmFvBtlCRAgLiwgEAtsTT4/BtRb0l
10fGTV8TtXdiIr7euP2REfiYI7pDcgY=
=R5Js
-----END PGP SIGNATURE-----

--PtfwvYqb3epCZ1qV--

