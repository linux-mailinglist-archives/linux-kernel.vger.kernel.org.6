Return-Path: <linux-kernel+bounces-521030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE07A3B2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69803ABDD7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E8E1C4604;
	Wed, 19 Feb 2025 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYJwj5e3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494E51ADC84;
	Wed, 19 Feb 2025 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951823; cv=none; b=sRNKqjnv5qz5Tk82FIiXIPiQQ/9WOCV/hA4o5I1OvmSQB1bOJVSh5ESXgqtQHNw5bwUgjQWRYzkQez6vut8HQADjA9lb4PJTlIivt8UM9WI3PNHWze+PtJ1HUldiwqqkzwYLnAz6FmOUGB0HcS3mD0ykqgp2PFxdEyHJ9oO2QC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951823; c=relaxed/simple;
	bh=P/kpZ0JFyS8K2bUvvNK9hIZS7U9RMBG2F3Uw3zx/60k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8W1VT0URkKc9M39g140sAdl8gdmFAgcRoN7HObu3H+tHwXbf4RNShOpCfCOMuRkIDo/6iRObKGi+rVTOjXemB/aay6MKfEF2oespR9Ym3PbD46FLEQ8sIJOjaVXKmmLQbm39QbozBSZmVBnfSqc5UVrvslvJtcN1R2IYdgtlc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYJwj5e3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-221057b6ac4so66880535ad.2;
        Tue, 18 Feb 2025 23:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739951821; x=1740556621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/kpZ0JFyS8K2bUvvNK9hIZS7U9RMBG2F3Uw3zx/60k=;
        b=IYJwj5e3s9/IRQs4FxunfeKczzTn4JXmeX/jUwkQaPlA6KWnGDaaEUwFDLhFiy5gRR
         zEaOaSMb79s7l7SIo6OHc7zRp38cj6cxioSdXCxtanc13IehD6ipubuCGJMaJCf6h2qA
         kKwJh9zu+HwUGwAJnLS1ZmDzcrLmZgtPD8ML1rzSssj8GiDgTg9sYvTNeXK53oQfFDKj
         qin8QIXMdLx7R5xF2TwLFtV/I2Q5oQ3YKyZ/hyMZH7EHKJns9x4W7DJvwhVZ7vNTGhZx
         a2p31DYrlJaEvlyp6JjSZB6zhy8+6DAr+HmHTaD9E4xH3KupxmvNH1anlbiRvIbVYa4N
         rWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739951821; x=1740556621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/kpZ0JFyS8K2bUvvNK9hIZS7U9RMBG2F3Uw3zx/60k=;
        b=TnFfMzuy7rECr6hqJ1KrPxjnTYyfCSEVSH67w9M2xkKWyNl0A0WuqeFnPeaTl5k7OY
         ZiUKHthuLB5x5I4GqXke1BFdxzVULvAJFurwwOCrerGtQuD/eumWgyTp4eHRLOp81/2X
         H2rMkDJYoBGDMCO2anF3K+oSz5+FX4Kn5eG8+h+UxUJIA509Zrf2998EvM2ZbhiYAMWm
         Ep1Cjn5JMPpOL0vzK4nHJiQPtjna6Q3NT01e1ZMs/ln1MlmJgzfVhxSD49HBp/7z8wKJ
         uPGYKDngHe8v3HzGw2H5CfxsRJL9UWFb2rJPUpOQiZhu/x6ImPnYBho30Y03EFe75MX7
         kovg==
X-Forwarded-Encrypted: i=1; AJvYcCWOqjKP5lE4pzEdTdpyUwL4vc62vj/13zKN+R7Jvdv5KNGBU8BeolnO4hVabE1uUmFUvz64x9FzjTi5LmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ6MefP0V7JYz6HdckU2xpJ5I24YiuOXWmW3GwHY/mnQ8pwdES
	BIg+TZnvKZLzEJRFqTggUv+oDLm+S3FwMA3sf3OXlqlKse7SAqah
X-Gm-Gg: ASbGncumWD4obgDeRMPfaTlH+ta5KQcHAUJcstwEq7oyCsBFPET+LeDsXQK7I/lmpXh
	9Adp83jddRj30qoUR9xdamZUdS94unEYEDuavsECm7EiN0LbaDDtZpIFwovtjP+aBdjjd8nIPbp
	m3uVAnA+YjVYam3tWzMNgp9itg5bmMvjhbvNzO+NdyXyyNw5saLmbzSWipHIIO1dcI5S36g75V/
	SvuofmGFa94M2o/2Ift/XWRwZe3akx8YLgnRqj7SiYdsJNnflhalv0hdbvSFWMJ7/ZAJ9Hz7hXa
	UebQH2e/lkfZDAM=
X-Google-Smtp-Source: AGHT+IEJD6274fxtcOpikxcjTZmPbe/QYievTKtzYG/3d2LzY4XIXg6MjLwRdaeB83HEkRnMk5cYhw==
X-Received: by 2002:a05:6a21:394c:b0:1ee:d7b1:38ad with SMTP id adf61e73a8af0-1eed7b139b5mr2915550637.0.1739951821365;
        Tue, 18 Feb 2025 23:57:01 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546177sm11328548b3a.5.2025.02.18.23.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 23:57:00 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 4BD094208F47; Wed, 19 Feb 2025 14:56:58 +0700 (WIB)
Date: Wed, 19 Feb 2025 14:56:58 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] vgaarbiter: documentation grammar correction
Message-ID: <Z7WOym9fl8GNPJiO@archie.me>
References: <20250207165325.3998-1-pranav.tyagi03@gmail.com>
 <Z6bKR9K16-oYMLFl@archie.me>
 <CAH4c4jKe7Q-E1LhA0KxOxEjK-gn=JY7e=2GN13X=yutaO8k3Pw@mail.gmail.com>
 <CAH4c4j+kOYMfzO5QOBg+hGe2zt4kN4f7v+mrri-2GMLzYtCPrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BToSCmPd5dm/qara"
Content-Disposition: inline
In-Reply-To: <CAH4c4j+kOYMfzO5QOBg+hGe2zt4kN4f7v+mrri-2GMLzYtCPrw@mail.gmail.com>


--BToSCmPd5dm/qara
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 11:05:39PM +0530, Pranav Tyagi wrote:
> Hi,
>=20
> Just a gentle follow-up on this patch. It has been reviewed but hasn't
> been applied yet.

You may need to resend the patch, but with scripts/get_maintainer.pl
output Cc'ed so that DRM maintainers can be notified on the patch.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--BToSCmPd5dm/qara
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ7WOxQAKCRD2uYlJVVFO
ozkoAP0eKLrhmoKPcsU785IBYgu8CdHmCLy3XmrPIMibyJI/QgD/ZJDL9komfCvv
38f91wD0Ik059kbk8dCpCTrK/qTtIgA=
=qgWc
-----END PGP SIGNATURE-----

--BToSCmPd5dm/qara--

