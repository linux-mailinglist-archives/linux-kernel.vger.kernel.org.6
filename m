Return-Path: <linux-kernel+bounces-436618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8B39E88AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 01:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F77280C7A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 00:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD8B33F9;
	Mon,  9 Dec 2024 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHaHCuTy"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F4720ED
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733703091; cv=none; b=d6+3CrqcmxhNTjI86k7GxahNoD469FFxEbQShwwk2Gkogjf4K4xFFJ7cVcCrtgg6r3Iid2jk/bjuNWK8GKhvtGDd558SOf8so1inrRpn0TKp2xiVFvy+0b/QAOhEeRjVL2pRXQbR5Xcp5AV3nSpAeHptK99fCEUH7VwLRsCg11Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733703091; c=relaxed/simple;
	bh=zM7n/vAl3TGJzgch0WGJOduuRP0DYKVShZ95CA6dAc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwChyQZV1qyVohTLZqZeSJ5CuvjMjsb38G/i5yZwmDxi4VLOTCMScuCDNrKkOtdXsRyrg8ILSMMKp0JC9P+4Amahd/xnA+WJQzSicMVzRK0DDiupqEbfgFDKUkoBJTDt5+GcemraUi99V3piF3iqzPi3j5uU2S5zcYtNF0gfv+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHaHCuTy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215a7e487bfso30959105ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 16:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733703090; x=1734307890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zM7n/vAl3TGJzgch0WGJOduuRP0DYKVShZ95CA6dAc0=;
        b=RHaHCuTynhTQ/+h8bn2aCNG3MzdZ0U8/P+QEYhgOt4YY0iLnWzV3AhNeS59MVMMexz
         fVT/s06aKKjxFKhALWbjEmra0SqPBg4GCsuFMPTTjUgfxq0e2C+QD7jSPlTy/okn8GPu
         PYJ30RZRsSUI0x+wKNeoZ4ezSqU2b+ZLqE+PIvP7vPaDStqVW0sHRO3TbznMYF+hAsrw
         +Y4vNMna3jtIqbUBzUo89E+KgZdirVfnXb8QmMNdpIAwjEcn3jlFtyCYdpq0vpi8LakY
         08MdaMaO7tWmhOqWMPpLpRuj4olmzzpC4BRycbamrtsZOCadjhWbEayLtmcYNWC+q6L9
         iz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733703090; x=1734307890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zM7n/vAl3TGJzgch0WGJOduuRP0DYKVShZ95CA6dAc0=;
        b=PcozZLMfde9wRQlmGuITmoo6CRjFVWDWJ95oLW/GBmpzcx7MMiilRKRW3NfEIjSW13
         NFXDYWmPxkqhGWCC7aR3Qm2K5rAXuUAJ6a9dqliE7RSUKQd4aOAsDcu0qdCKRa7wbyAj
         rdxCySsvNHWUYZFp4bu+33dCHThAvHyL0KBJQAu2HXB+fyOGBVX8Qx2TBRrb3Mo0S5Gv
         TyC27by4ZRJkELtdXZ4I6evWt1DqA1HkFI5azFdu1DpHZEX5w1uNtMNNiSBo39YLCXKw
         EQlnV4L/N68Yn317c8fJZD81Ie+SevpDmMLklfhucFpjb80P2kofuiGk7LYIzwJXi+ut
         ggBw==
X-Gm-Message-State: AOJu0YyjODvEGOcKTtAMxLv/azC0ou10NZxjpzFgT9b+v4OVPpyyGE1t
	bEaw3dimuNx7QvbP9jCO2NB3FOs9BJP36HsKNlR+GU1peQ6tcG2r
X-Gm-Gg: ASbGncvcEN7Q7mmYVQC8QSaApzRTagWhM8AoJGE/KOu+91jJBP1QvgBPph5yjuHYOs2
	hnulbuWIkWHll6pDfQWdsD3Vzb7lbfgrBRUlMBuGyhJ/wmzDIAvJO76O8/B1q4Yo71YV6nb5GJ+
	7MO0MK7157x59dhLZ9wYZgUeDUru1DCpD4NlzsJ08Ll34sICHWyuIW0JaMFqExe2L5I+XfxmJBx
	v0MTJu/qwdj7AhGQscdUc2tz6Nqqe9pCugUvziOt/0rrkbn7w==
X-Google-Smtp-Source: AGHT+IGJC0WMpE+hNO9t4xiHfPXRmI6Z3vUqZe/12jkfwlmxl1MVDpPG/kpEiCWWDGHoAHEhw/OpXQ==
X-Received: by 2002:a17:903:188:b0:215:431f:268a with SMTP id d9443c01a7336-21614d7b357mr199952985ad.31.1733703089620;
        Sun, 08 Dec 2024 16:11:29 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21615dbcd48sm44977055ad.109.2024.12.08.16.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 16:11:28 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 105D7420A6FD; Mon, 09 Dec 2024 07:11:24 +0700 (WIB)
Date: Mon, 9 Dec 2024 07:11:24 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Alexandre Ghiti <alex@ghiti.fr>, Charlie Jenkins <charlie@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Remove Albert Ou from riscv
Message-ID: <Z1Y1rAmvhGitq05T@archie.me>
References: <20241205-remove_albert-v1-1-17eb850f1540@rivosinc.com>
 <Z1PihReuTF3Gx5K6@archie.me>
 <8b4a7f3d-0c3c-472f-914f-7e3971697d7c@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D1MvfAhn36B/cRzY"
Content-Disposition: inline
In-Reply-To: <8b4a7f3d-0c3c-472f-914f-7e3971697d7c@ghiti.fr>


--D1MvfAhn36B/cRzY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 08, 2024 at 07:18:09PM +0100, Alexandre Ghiti wrote:
> Hi Bagas,
>=20
> On 07/12/2024 06:52, Bagas Sanjaya wrote:
> > On Thu, Dec 05, 2024 at 02:46:19PM -0800, Charlie Jenkins wrote:
> > > Albert is not an active maintainer and his inbox rejects all emails.
> > > Remove him from the maintainer's list to put an end to everybody who
> > > interacts with the riscv linux mailing list from getting spammed with
> > > rejection emails.
> > I didn't get bounce message on my spam folder when sending to Albert,
> > though.
> >=20
> > BTW, have you contact him off-band, confirming that he no longer wants
> > to maintain?
>=20
>=20
> I have been working on the riscv kernel for more than 6 years and I have
> never seen Albert posting on the mailing list or sending a patch.
>=20
> I don't mean to be disrespectful but it's not his choice anymore, being a
> maintainer is a full time job and we need that.

Acknowledged, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--D1MvfAhn36B/cRzY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ1Y1pwAKCRD2uYlJVVFO
o0khAP4iOWC0nBXMm4QULXr895qQr0SABQlQ0JghqL3R3edFUAD/aV2Ncd4bD0eh
JoS6KMRWNG/3X0Tly4mrSlz8igWVHAw=
=eVlR
-----END PGP SIGNATURE-----

--D1MvfAhn36B/cRzY--

