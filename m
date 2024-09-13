Return-Path: <linux-kernel+bounces-327773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2331977AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BFE284D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BA01D6C4B;
	Fri, 13 Sep 2024 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BO8zMnJB"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C61D67B9
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216171; cv=none; b=ejxh71T7U2e/BCy6uY6r3HYV81Tw9FNsdRL7E3tMCgUlKWQAbQ6Xcdjik/5xzjhI4YabM4CilV2oD4+7gaFB6/M2tT6/R6HKTk/a1yQjx+ThPDZklf7eeCX0wfC2ZyzMkknp7ulrHGzJ9NylGco4pWsM6Bk91VPFDYOMn1IFW8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216171; c=relaxed/simple;
	bh=kMfEiKqpDc06D7dQkCljg8wh+jDHH5Hk2dh71ceHbQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVFYgLCMDlCjjupdPcR9/lfk1pyYMhNC8FGCWn/gCSOtK/nx2U7GvQ1N4ceYG191GMf3KiYbt4MoBB2Dx2khJbdxdo9AfpyskZtbRSm+bCS7cRwnsaloWAN4LOzkr39Vq4vmSL3CwhGyCLjaGTlKwKhRsgz1BUqoYmyTK/FdEvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BO8zMnJB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cd46f3ac9so17653025e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726216167; x=1726820967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kMfEiKqpDc06D7dQkCljg8wh+jDHH5Hk2dh71ceHbQU=;
        b=BO8zMnJBrzL9HmnVtY9vSPIj61nR45AxGFZg71hx+gHE5jCZ1lxQOu3NRjfY6q6May
         p2gsRHw3qftwXEKTx/U9c0NPimFTH5FNK+SnR3oN35r5r61QMVmMjfWxsXLuO6GPLBSi
         uwnUzNM7M8YQkkWUILWZeIRdBReQ+6pIwRib9WGTvIwLFHK1uMTRKjwTqbYKVX1HE45i
         mK2GuP9zAU+pSX3MyZepRYzE5odtOBBtXgjYaJx6y5ZU+zeNWYLLGA6LPGragzwaapDK
         XNqdbv4zEGVDOi+w7m1zR7wBjzE3wick2dSdSj7BEFKt/R9/dMhNxtBxHJKEYQ3SOQhO
         eO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726216167; x=1726820967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMfEiKqpDc06D7dQkCljg8wh+jDHH5Hk2dh71ceHbQU=;
        b=O+6K+Dq2iVGQh6so7sjbzEUL6TNAfR31JEMjvoe8LjF7btUIR1YnZSQ4nXB4+DevzB
         Knza4VIyttrZ5W/OI0VVH/pr3t0mAVwFe/NGRztWTVE2uqCXyev4NXO/CEuvqbN1cuTx
         y27HUNoHwqUUaeGtC1T8ypG/MjzvJhW8HIdXTG2VgxT1F8J03MM1s8fijxXCZKSsLLXB
         B2PYZcalmyuxpHpdITttsiK0Z0NNcbA7SDAw1P04r4TvbaM8q/8LwQcXMMtJv7/t834b
         Jgz06yfgnDx9u8UEcY+j/8nWgtqc5SQzqHuyyBXfA1WeW9ssXxxWJs+aBu5n/cUwZ7HK
         ROZw==
X-Forwarded-Encrypted: i=1; AJvYcCVt1RLT6UiJa6IzIJGcc4LrPBh/NBrxMFd91wTSSipd9buNDK5qsDK6ElZmJ/uz8W/tk+3ymWcKw30vkY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz5v4PMKHP2Ml8klhk1OGxt2gXrb1e4S2muXzDp0d4PAmiJU2X
	0xNA2EsK1izkuSjgs7O1hMg5ef7s43WyceoSRa9IrapDG6gjwa3QWim5COb4kXnQ6wWIKY8q/tf
	F
X-Google-Smtp-Source: AGHT+IGCRfhqBR46g2WorFNoNKOpP03fbD4VqoUjtKyqvkkbjjadGBaX6OOdbAzv5LmUDUas3D9Dvg==
X-Received: by 2002:a05:600c:4f81:b0:42c:b7f9:4bbd with SMTP id 5b1f17b1804b1-42cdb586ccfmr44332375e9.26.1726216166355;
        Fri, 13 Sep 2024 01:29:26 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956e8674sm16382949f8f.115.2024.09.13.01.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 01:29:25 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:29:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Steve French <smfrench@gmail.com>
Cc: Steve French <sfrench@samba.org>, Enzo Matsumiya <ematsumiya@suse.de>, 
	Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smb3: Fix complilation for gcc9
Message-ID: <rrvi3uld3bobgegll3jlapwprgfv4kbtcboipcwxxgp46eg2qg@5lpncjmuh3e7>
References: <20240910151418.1233049-2-u.kleine-koenig@baylibre.com>
 <CAH2r5mu_PT+34JqL7O6yqfDua=6NNU+AP4+n56FJSc1X5Rpp3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qgaqvhh7noghhbnm"
Content-Disposition: inline
In-Reply-To: <CAH2r5mu_PT+34JqL7O6yqfDua=6NNU+AP4+n56FJSc1X5Rpp3Q@mail.gmail.com>


--qgaqvhh7noghhbnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Steve,

On Wed, Sep 11, 2024 at 04:26:39PM -0500, Steve French wrote:
> this looks like it doesn't apply anymore due to changes in "smb:
> client: compress: LZ77 code improvements cleanup"
>=20
> Let me know if you see any problems building the current for-next

You're right, while next-20240910 is still broken with the reported
issue, next-20240911 and ...12 compile fine.

Best regards
Uwe

--qgaqvhh7noghhbnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbj9+IACgkQj4D7WH0S
/k5g3Qf9FB3bRCAV+lJjoXHgkHs2UzX29Ea0/33wD7ZXzgsStk52mHiKuC5GtsIo
GDbnPDXDTU7rfq6RYaBI392LRH3YzBnnGR9pbAZobz3eYlx2WvvQ8CVz0+c+HWAj
RFQ+1V2AVyPo31bxj3H8RPj3nnd/hh8wSQaAKbYiE45iSMJY2KOciZ11DsYFlCE3
fuz6F/BlnCtcXWxYRYadv/189dWuO/FJh320KjWzut90KJTmFIDp+rm0hbr9yijD
OQwFOE30zYLftLEg45J74CCvaPDL0Jkp62rHbLIXX4CdlQ30t+AiJs3lvV89BJ8B
qTMWq1tLBV+RtCFdmTpBMdSdjyZRNA==
=lqCK
-----END PGP SIGNATURE-----

--qgaqvhh7noghhbnm--

