Return-Path: <linux-kernel+bounces-449171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620D89F4AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4FD188D87A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4DD1F131B;
	Tue, 17 Dec 2024 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gk9W7XSk"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4F31CEEBB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438472; cv=none; b=IbYhn4y9dutG7ODdJ7JL3ZWasemyyGxbHUDdMJmZ+g7PhjcEuAvQKQuAi9WRNklRULoNFqiK42KC+7cJvWb8wy9rVXznq2UHsRr1NtqDJF1y/vjGbgfaxTnUF1gX0IyDteGGDuNLcrr0m5Xv7Daht6Ug0EjISFMTHHB+YiWI5JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438472; c=relaxed/simple;
	bh=mfOjG9fKcnZofTiP6EMJkP840fGyXQ0OaXOxdGVHwGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIEGRi/LJHXKS3T6LofyAov3b4V3onY4tlsuoIQrLU1k/Xsjrvn7JsKBbbLVMuxowQazkc9T8JC8VY7TuZ2ll1pRgMakN8A8whipRLLBP/cMakFoV3jrLjdR3Mz5dTvOjtuWmuAi1F/xV8hy9C/2ypGo/SH9L5fYLn/vHSVeCy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gk9W7XSk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385e27c75f4so4029759f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734438469; x=1735043269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KUCaeAxyUqo8DWV52BpPxnODaaGmTXqNe/mUro311qA=;
        b=gk9W7XSktOn6UrKpbmjEBVbXAzRkM+7PNKIhUKYmha9UVQL6fUs5igTWbgPCyaY+8U
         ecVIT+cW4ISUJvvZ/9+ogXjFEjIX2isdprRz9xb93FQYxuZ1BKfjgMSMQ+fKVY0EbOGn
         ZLqRrxpiEFdsKLSjzTHXHlW2B34kmMjwZUaFzWhPGtV51IfC4rn9GIEYMI70KgwSrxl+
         aurwcrthzWowwHCaWjyxppS/FP7EIYx1mDHVbIL35AEm6wDTerojOULHoRJYX30WLycJ
         NCIxAyau0735zkFQRQiAe36tRjsXa6n6VNHcLr5O4Aze3dtQ9hCqko3I1zWvIq8zBZMy
         vk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734438469; x=1735043269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUCaeAxyUqo8DWV52BpPxnODaaGmTXqNe/mUro311qA=;
        b=NFP18XYtLuvdyPALBBeuq1KRX21x4yID6mnLqY4zDU4JRFVTrHoW07EdeNeM6TUszG
         MuCFOKl9rbttfDj+in0baVd+1CIar3pXfvFDAWy2vSXGpyrKv7rVI8wdRvoo+LIJhj6M
         lRlZ8p7URPndYLURICOixjihAFIOO4iVlT2Zyu11ofD2MMJy9c1JBqlBh4bFlOvq2x0p
         AgzuuqjsCrjp18d4yx/1ORGXTlxD1ba5xAQXhSoNfXyM/1XYiXrG5sla8RVDvLw4Zry/
         jKSe1XaEOEcnF7TGO6nRTyOc211m45Ju5P41p0xRq1ndtsx77tEq0LGrf/porbD4+2o9
         FmJw==
X-Forwarded-Encrypted: i=1; AJvYcCV2oWDEBfHymCuBg4/F1sD5oFHFlCUPIotROaTFNDfgPsExN41l2Gpx9iwVc2sx7aTJVGFco3bV81oVj7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbY/a4/xgYLCqh2wy+gYjXwTl1VaVq1bgaNKByz095mFBhE7+z
	0dMPIHYFWWHTgmRwODrqkAHEJWOncbfOKLY79TyaWpDlqwMLV5fBIbj/lGGCrwU=
X-Gm-Gg: ASbGncsXxC54I15y2w2rRbu9tv7iaIWCfUUv7HAFkK5G9jOaaGCixqmPrK0kxdAIg1I
	ruoUN31eb4kdGlKyo+McDJkwkg0Wj87oNxusQY2u6ZuW0Vj2/AE0aia9iyLZKUghTvZCFu5M2ro
	96ccu+khoLy+Qtikc0Tntzo+nWD8EksshnIQ7pIq2kfkG3Cv4CZ0u7NjWm/rOtyuTShmjmqXsB5
	dzy5MqBgrXwvyBYXEOWpR+P6XsT6r/ggFuhn6Z2II2do7Do9PLuMwhi/ek=
X-Google-Smtp-Source: AGHT+IF4zzeWZiq5WUJV5p8HsJlkUkt0GdMreTu7qE4Nap/RX8z912EgQPfdHcKIxD5g1BK2weO3JA==
X-Received: by 2002:a05:6000:1fae:b0:385:e013:73f0 with SMTP id ffacd0b85a97d-3888e0c23f8mr14120180f8f.59.1734438469092;
        Tue, 17 Dec 2024 04:27:49 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8016427sm10821119f8f.30.2024.12.17.04.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:27:48 -0800 (PST)
Date: Tue, 17 Dec 2024 13:27:47 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com
Subject: Re: [next -v1 1/5] memcg: use OFP_PEAK_UNSET instead of -1
Message-ID: <eydeud7il4oe24xa4uvs2gistzrkphzq6bfiunwn73ipd2cxsx@kyisofhuivp6>
References: <20241206013512.2883617-1-chenridong@huaweicloud.com>
 <20241206013512.2883617-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zjcz4prt7izdxoks"
Content-Disposition: inline
In-Reply-To: <20241206013512.2883617-2-chenridong@huaweicloud.com>


--zjcz4prt7izdxoks
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 01:35:08AM GMT, Chen Ridong <chenridong@huaweicloud=
=2Ecom> wrote:
> From: Chen Ridong <chenridong@huawei.com>
>=20
> The 'OFP_PEAK_UNSET' has been defined, use it instead of '-1'.
>=20
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--zjcz4prt7izdxoks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ2FuQQAKCRAt3Wney77B
SQw0AQCgJ1ql+qt8nwjNYTOb4Vf53qsOaZQDbmj2GLjx7hNH6wEAt+mLSBFbt9Cj
h2vOR8JL7AmC1u2ExaNce0CqcXuO1gI=
=EZAl
-----END PGP SIGNATURE-----

--zjcz4prt7izdxoks--

