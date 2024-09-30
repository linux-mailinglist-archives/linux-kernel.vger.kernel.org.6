Return-Path: <linux-kernel+bounces-344659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EE298AC6E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF513B22D19
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A458919924E;
	Mon, 30 Sep 2024 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QhU07ogk"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B12198831
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722727; cv=none; b=Ag2upYalK3c3EGqEQ6ypd3eWY4eCys7K9R1BB8opRp3djpSO5WEcu4u08+NlrQtwgalBSxtG6hR1HmtfSOOB7ZjyoVEhM5Ea4X0EztL76fE92G+X+w4X8ZIwolUZYD5baOG0n83WrkP5FPx21LddLNVebC4EHZKUURT6+u9DmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722727; c=relaxed/simple;
	bh=pFfZglBl/QyvA/aWTL6ZwHetOTMUtUtT+fp6RCnfxr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdG/MNWOvFPAsk5iUH1XwfP8V/jPMc5zqBGBwj//ddwGVpf9YkZ5dmkjtCgGyi+nJKFI3aTAtzVBm1Rkgw5RQRItRdmkIgKTuZcvO1OeDcBLl0wHiDBG9j4J8ZDFv8H/FCaaRns6YhxxtUwW8yPjxtf6c8PJFuYUUUtMjaXl0wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QhU07ogk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c881aa669fso4954307a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727722723; x=1728327523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pFfZglBl/QyvA/aWTL6ZwHetOTMUtUtT+fp6RCnfxr0=;
        b=QhU07ogkPd8Xv9UgoxCSgSs1hvnOID+VNw6lhNF2zZqMnIm/+haR1EUKu++31mXyxJ
         YoiezDi8aWn1IhKmyDgojSi9uQ3qTwJwAubMERGeEmsWSrgWp419K4mOiq+WI6+xx1Bz
         7rSvxP9/zAcv/Jyovo8sfBEbPimn9E1vVBxD7bJZ6RWNpSmSUHwFD1CEWHPt49eNh3jZ
         zFqudCbrOyZ70iJxYRqyhNnyZjmpa9lu7t9hIY4oJrR0Nfuskg5VT/U2UAKKqEJdTWtY
         Jhw1l7kccqvuIJWBNhJvxFA2i+vKIoSJDNKBvORlRpRNRTUUyM3N9sbY9TuIF4hviN0J
         FhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727722723; x=1728327523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFfZglBl/QyvA/aWTL6ZwHetOTMUtUtT+fp6RCnfxr0=;
        b=PB2/t6XSnUBxUqFKQ5qc4sVRW5+sC9W7teIk/Kh7RhusoseFoMY/LXOLelNC/Po0lP
         jCds6APvO/hYY5Xzv41oOiJiJw0wvTqki2ay20G+o9kXQyRVfgGPyn4t7gPLS+eVzt59
         z7RGxCVArBBg4Ly1K/o4gri61u9EZnYxYOX+egQZ0xUoK8n0HIBdLa9HdRCN0zmmYaYs
         shsOyU3LsnWesGtTwJWGplJNS1mw8yecpc/e9cU9dXKAN2O6OIA3o4s6dlVNFHhfGHuH
         g6xv1ZLSl2JRL97qikkFCPlCWt8v7en/3igqddffv9xKAwsJNhghavT5YDtZenZcm2Y/
         vZTg==
X-Forwarded-Encrypted: i=1; AJvYcCXTq9eZeG8KTkJCVX4TVajCrNXLQTZGluyGmarmORjIhJ5HoiY0EZVL/FOjz2PGuYQbEGdMg9kv8BJTNNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6EFWI6BztNorpdToWwO79CrBkJY14DJR1tcGl4I/4j3gAhw9s
	86ggqmTZHaemlVqE2ScJWjfBx53p9IEtKcnCZ7smC32MXdeXBksnaD0TU9boCZY=
X-Google-Smtp-Source: AGHT+IGftaXVtjmwbu21Jrz70y49tNy87dhPPE0cOwnTd1LW26yrG7P5xvZeZ5CZcoxH0oIpkvVutw==
X-Received: by 2002:a05:6402:34cc:b0:5c2:4cbe:ac1c with SMTP id 4fb4d7f45d1cf-5c8824cde60mr10117664a12.4.1727722723327;
        Mon, 30 Sep 2024 11:58:43 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248bf61sm4874255a12.59.2024.09.30.11.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:58:43 -0700 (PDT)
Date: Mon, 30 Sep 2024 20:58:41 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tom Chung <chiahsuan.chung@amd.com>, Hersen Wu <hersenxs.wu@amd.com>
Subject: Re: CVE-2024-46808: drm/amd/display: Add missing NULL pointer check
 within dpcd_extend_address_range
Message-ID: <khg5rxxfvmdfjze2tpdamrnhsry7jd4eptxfdkht5nnpjacpy3@rhlk7omy3ulc>
References: <2024092709-CVE-2024-46808-8886@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hse3xbpiyipqknog"
Content-Disposition: inline
In-Reply-To: <2024092709-CVE-2024-46808-8886@gregkh>


--hse3xbpiyipqknog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Fri, Sep 27, 2024 at 02:36:13PM GMT, Greg Kroah-Hartman <gregkh@linuxfou=
ndation.org> wrote:
> In the Linux kernel, the following vulnerability has been resolved:
>=20
> drm/amd/display: Add missing NULL pointer check within dpcd_extend_addres=
s_range
>=20
> [Why & How]
> ASSERT if return NULL from kcalloc.
>=20
> The Linux kernel CVE team has assigned CVE-2024-46808 to this issue.

This is not a good CVE fix since it'd bring the system down for users
with panic_on_warn=3D1 anyway. (I wasn't able to `make
drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.i` but I assume
the ASSERTs expand to one of the WARN_ONs, feel free to correct me.)

It'd need graceful handling of the kcalloc failure.

Michal

--hse3xbpiyipqknog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvr03wAKCRAt3Wney77B
SSnwAQDzfnpAgdADXkfXRZLJ4OhX+N0n+HuZnoj6Sy4O8X62ZQD+KJx3qWahsuSu
HA0fAesvgvHj8+1EH42Z2oKyVHZxJgs=
=7q82
-----END PGP SIGNATURE-----

--hse3xbpiyipqknog--

