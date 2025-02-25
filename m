Return-Path: <linux-kernel+bounces-531108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C948A43C48
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816C01892027
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DDD26738F;
	Tue, 25 Feb 2025 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fB6zkoia"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B12E26159A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480708; cv=none; b=KFMVz0lUDZkpXq5fqS7yb+I+paxC1jYWPuENoqzlFkuw24rbd5Tw3+T53vvwBq6R/gkLs58ef7qGNpXWPOUUZZRIK2okKvX8dH2tGH1v80RQBpGT9Q8wLWdxkaAhZ4ij5r4VL2032fv3+0HH4KOMhI4DNg9OsMfUjFB5yLgnIQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480708; c=relaxed/simple;
	bh=U2Fxrw+ZWnZroV2gtVWjbt2Q37s+7jT2hIUi1TH42vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8Wy9YV3rEVMczBX0aSVn5oW3N6sRhmoyfUWYg77uwyIYo/bBIzT+wECuJAUK3289VSGQpjBpdV54edG/ilfTSEO5A1W+PVcd6VN211Gv2pz8sccttKawNqNvUK2EaUVcn1SZnlTL3Tuzf1WyH++/AgStJQ/2twwZ5ui+ovoa+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fB6zkoia; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab771575040so1116201166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740480704; x=1741085504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mv1GjtLH9p6AAgaKLJdaYv1valnjqWPg00vkxZOmddk=;
        b=fB6zkoiaIdMgbfeIGodOK3Bc5hooKM6K1xm0XsoLN2PzPWLcJ0JpZ1FGbt9tU+fZj1
         cbH+/LkcoTXyyH7sdIjr+yizafF491qtIPOiJBtHMj6O7v5KdfCiPEpkgq4VYaUEdFbR
         RCzrlNVkOSokkiFb5dyCsTLf4Wo10/c4HE0cI+EvhHLduwLr1oATaVQlrIRvp8QZAnxx
         ZYVlsRJQlJkn8IL5m2vQ8ikz8w7Oy7eKBfSaYewdZL7UUZ0c7QntQTruTzMxqFlCnQg3
         ZOUBl6Rho1SsPEjNqrZKLsDD7Y19DsUiV3DC17C2pjx9XmasY/krW9B41OJFhoW6wpH4
         IyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740480704; x=1741085504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv1GjtLH9p6AAgaKLJdaYv1valnjqWPg00vkxZOmddk=;
        b=U3eT5fhH0U2Uucmk2S37nMEc2aaiOf3WKL3JLM9sNyiCogtuRsass+gHJOyAUhyF8q
         0FaGKNSjbH2PPlbEWwE/p+Marw9u4m3ZmBblKE1AT83DWZDUClqwYFAoVpFOg3Yj8qol
         320XENEL9Eb6H1/4RSSt7cbM4gzrpbzJFfALh2/AM/3zgPloDYLDUlk9DS/jf//NvRCQ
         jhrc5q51oecc/JY0zKDvwOF4hUR4+qTZc6iGkq6wB68t5P0RYuHZHEwi/bK4yKk40dtF
         GliNXsbtV7E/rpFqOvP5LmYRtxaHuo2i/yhkDeRedFgOwZJM8mPfHkOH/AdhjBW1xTJB
         n3tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMK/T9fJpsEJliPzBXiQfzj6sQ2dTfEguF3aXilg6ZbH5oLZceH/YWsOqbdQzKK7gUxWpodJs1wcPNzW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUc1RAc8lL2gzOhM7rXjL0HXf30SEpJzmLdU6UhP7D1l6L/LBL
	bAAc4bEHWsBts82QPJ/naA27rDxJFm+fl1hvybKVPKhyJmhiq9ger8wxKCWDabevurTtx6Jl7ue
	fyaw=
X-Gm-Gg: ASbGncsW06oeCclOQmqJrIffH0kw1lIsiykYQEJ9qf+vCvk3fkqCkqMh7U4f+sIkQ7I
	H/fbb1c8T7wSB+N/Vl16t6kogcsIYffITmbNEXK+yfABx+9OMR72ey0U2xSISCEaE3DZXlezLXN
	A1CuFbubUGIgR2rWtemMef1tKGO/2ADvd7FwHtZpwbDGta2FKAi6eHQepBt/x6lNFdSyB84VfWa
	X277npBGLwWbG3BD9tAH0KY7Rf9hFFjx9uF9QMC2ozr2jFw1c5C3urnEnjwTYB56BYBCKpZOH1y
	difDqVIXu3vYe/n0vDts0vIU+AEc
X-Google-Smtp-Source: AGHT+IHUS8m9al3aYpp9dTro/BoJsAzrTMGGeZSSdFhetcpWcy+SNbbUKcmiFFvP72TdtmWFR4s3Zg==
X-Received: by 2002:a17:907:3e0b:b0:aba:620a:acf7 with SMTP id a640c23a62f3a-abc0ae5728bmr1777898866b.10.1740480704381;
        Tue, 25 Feb 2025 02:51:44 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1da1c2dsm121396366b.77.2025.02.25.02.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:51:43 -0800 (PST)
Date: Tue, 25 Feb 2025 11:51:41 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, tj@kernel.org, josef@toxicpanda.com, 
	axboe@kernel.dk, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 0/2] blk-throttle: fix off-by-one jiffies wait_time
Message-ID: <igzfzkwbbdywdvkbjzi624fgrc2jopnb6c4dpcrac644lazgbp@k63ht5r5ue4x>
References: <20250222092823.210318-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="teg6osmgnl3qwlc4"
Content-Disposition: inline
In-Reply-To: <20250222092823.210318-1-yukuai1@huaweicloud.com>


--teg6osmgnl3qwlc4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/2] blk-throttle: fix off-by-one jiffies wait_time
MIME-Version: 1.0

On Sat, Feb 22, 2025 at 05:28:21PM +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
> Yu Kuai (2):
>   blk-throttle: cleanup throtl_extend_slice()
>   blk-throttle: fix off-by-one jiffies wait_time

(I haven't read through all of the 2/2 discussion but) if the 1/2 patch
is only a cleanup, it's more backport friendly to put it after the fix.

Thanks,
Michal

--teg6osmgnl3qwlc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ72guwAKCRAt3Wney77B
SXOwAP9fngBMH4Xn+ahF0Zv0RzYoYnjox8PuSgoFd8VeVVyVIgD9EMg0p69jzpqn
RGSQPrygGqTm1vbVYBMl+rzVsdR5Sgo=
=bd7s
-----END PGP SIGNATURE-----

--teg6osmgnl3qwlc4--

