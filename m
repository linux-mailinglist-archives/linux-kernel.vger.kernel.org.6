Return-Path: <linux-kernel+bounces-405209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A509C4E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872ADB26CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F61209664;
	Tue, 12 Nov 2024 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0j6GatO"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB117333A;
	Tue, 12 Nov 2024 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731389964; cv=none; b=E3BnsQCTULLbdpmppOrWxIMrcJot15IvoxMnmB3w4C1WgytULlLSZXlBed0YT1d/JWM4S+loYyFB/m1+C055AuHx2clp4dLRUKZEghRzwoKMvGcjOar2u/+AeRFPCqVSyJNv9bRXWkl8avb7sobY3Pnkp2LtrLH7FfkgJBw9xe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731389964; c=relaxed/simple;
	bh=F1BfRa+7qOoBb0WExc9t56zOgnTDDdD0ITVpKzY7aPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A72rkJZyDx1v8V6xgV5k0JYu07tAU0Kw0trGS7vvWLLqVSGvmv/wtVwDJA4VHcParqfzhFPGQMtbqRK6/HnbqSKPHlEy+Ej6PevIGmebh0JHcJYMdOwufw6Isi9o2SMrd2DBuAlaTKOrB8/bazcNr2aI2hm5kRUDT2aRZSoKukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0j6GatO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ea50585bf2so50924457b3.3;
        Mon, 11 Nov 2024 21:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731389962; x=1731994762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F1BfRa+7qOoBb0WExc9t56zOgnTDDdD0ITVpKzY7aPA=;
        b=V0j6GatO7VbDkc+ap32qJfG8zIFjo9ihHGcCGyQd1c976lEqQsmTcGrG4MexhBPrrT
         mlrfnRich8D9lgOmxUEKBo5xhdA5PlPvE0maiQ2sd7TFwei7Vth/kO3jScEzOMHC7/wV
         Y6jp/Dz/Qub+94QYvaZmJdcvBv+RFjnjuH1CrzvINsoLfO3Sw2Zh9ahY6DXxezYGU0Tm
         iQacqvh5BwJK8LMHjSkYKoXJ2ATVUY7mxS1WpPNlqGfMcYmsbMEz5Q2MJlRgaRqsju5r
         TBEZAMIBqL34eOiLFJcOj34QwoeI7+Hr8JALKtWO23biSFzhxoZI+u4DB3x9LmSeyr8J
         xjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731389962; x=1731994762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1BfRa+7qOoBb0WExc9t56zOgnTDDdD0ITVpKzY7aPA=;
        b=TNQXAL3fEykW4MhyW0u8R7SeHq6CSXkTpxc1IcI9vK7AqLZTzr+yMQBMLbrJGuIT8X
         uTN1u5DgfMxKkoQ6dMVbHky45FdoH7TOEPBKOr21TwIwnWgliQ+QSZ2TPgEVJ5XyXdLB
         thO1/66l2YGIq4I4XESmMan0ec7TEzNkHO3+8hqdAB1NokKCWWKHicdDwJ2ILnfFBYOS
         1UJ6zOEN7Q9l5MD5gS2EYgSa9OlijVWhHfK9QOU1u+CIneNM45R+QlrIAALcw+2XsW1F
         rE56sNRYM4jlZIvA2zXaUep//cUUNkaA6Ts5LBQj9vUwmwcZwDPT4qCeUaLToztcaWkw
         osRw==
X-Forwarded-Encrypted: i=1; AJvYcCUXMpabWaOgC4BpVr6oPNQuHG2rCFdq4C+d+0y/LxDjQ1+3YCrlti385Hshm4ur3SDP8txeoTtQhBJiI97W@vger.kernel.org, AJvYcCXKwWODvwv2dCzCiQafywhOOaC/eNZQrTaxRvQqNBGfJmYgGXQVsQPMYh+8GcfOXqeGfOJjYD5mnGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZiJPmeJ/inNp9cQQ+GD7/Zcrldl2ra72ZrwkQ7ufdygNGN60
	w4HI0V+h8UQn6OQcBrfmPtuyy/Ot1zwDTRuNkIZt5ZuX+Js7eDUq
X-Google-Smtp-Source: AGHT+IGEMQpLn4quiUmZDO6r6Zoxq3fld89dpP4MRj6NYnmDAhJC3fbLHaBmwmZ1HBZItGfhrhFEKw==
X-Received: by 2002:a05:690c:9b08:b0:6e7:e2e9:6940 with SMTP id 00721157ae682-6eaddd9fd09mr144632247b3.10.1731389962011;
        Mon, 11 Nov 2024 21:39:22 -0800 (PST)
Received: from archie.me ([103.124.138.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a41cfsm10333655b3a.41.2024.11.11.21.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 21:39:20 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id C881D4209E61; Tue, 12 Nov 2024 12:39:18 +0700 (WIB)
Date: Tue, 12 Nov 2024 12:39:18 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v2] docs/mm: add VMA locks documentation
Message-ID: <ZzLqBu2-MJKKOVpm@archie.me>
References: <20241108135708.48567-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XkZYaAUKn9osvV3m"
Content-Disposition: inline
In-Reply-To: <20241108135708.48567-1-lorenzo.stoakes@oracle.com>


--XkZYaAUKn9osvV3m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 01:57:06PM +0000, Lorenzo Stoakes wrote:
> Locking around VMAs is complicated and confusing. While we have a number =
of
> disparate comments scattered around the place, we seem to be reaching a
> level of complexity that justifies a serious effort at clearly documenting
> how locks are expected to be used when it comes to interacting with
> mm_struct and vm_area_struct objects.
>=20
> This is especially pertinent as regards the efforts to find sensible
> abstractions for these fundamental objects in kernel rust code whose
> compiler strictly requires some means of expressing these rules (and
> through this expression, self-document these requirements as well as
> enforce them).
>=20
> The document limits scope to mmap and VMA locks and those that are
> immediately adjacent and relevant to them - so additionally covers page
> table locking as this is so very closely tied to VMA operations (and reli=
es
> upon us handling these correctly).
>=20
> The document tries to cover some of the nastier and more confusing edge
> cases and concerns especially around lock ordering and page table teardow=
n.
>=20
> The document is split between generally useful information for users of mm
> interfaces, and separately a section intended for mm kernel developers
> providing a discussion around internal implementation details.
>=20

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--XkZYaAUKn9osvV3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZzLqAAAKCRD2uYlJVVFO
o3STAQDHnJFvv5jfJOUQFsOkCAeoxK+s6dpeWgh+GGi4e2MbrwD/Z8pkRZj351cf
Gpboj+UwEbMqIeY4P85LhhCHGKJ6UwQ=
=U+MU
-----END PGP SIGNATURE-----

--XkZYaAUKn9osvV3m--

