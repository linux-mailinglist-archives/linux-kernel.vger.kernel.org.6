Return-Path: <linux-kernel+bounces-271939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E204945541
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFF91C20FA1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA197483;
	Fri,  2 Aug 2024 00:21:24 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA8A92D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558084; cv=none; b=qcoelBF6Z1Pl90RP3yj9xIbtyfBxQZQavUR+YZ8NznTwWqROOOdsDFrYgVczSOFugqiACkSmrRll1n/omyGDNz6D/NH9b8iF22PKqJS/UEf6Q4DP4WZZuShJvc4Z8LQ7MN/896IeqR9Lqoa5Fi0QA6OZhoOkmDlgGZIXBBdZO6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558084; c=relaxed/simple;
	bh=odO19YngnXiJQsTQV8Nw2HCAzH9PsMMNC7KXFZmbOHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am9mADY/U2u/vurXmOP1IpKad5dC8lqW9u2epx6cqpThrFk0fsfsk1ckABCbUFrFFhpLYoZeien84WTIbpyxWnKjQhRl67I6QpX3z450gE96iTOTxAqAiGwMmE2410iIQASxD3dpN+5jOGgVyHtMRKRhDYBIJCuykRynhkAto5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6634f0afe05so65470327b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 17:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722558081; x=1723162881;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jA3c7uUuCkRHs06KYWISWkUwyWzjw9tBg56ETJ7yhto=;
        b=oaERU664fcIvpGX0n65ZHrA7tl1s437PMxvp86rP32pDdVkqN2Gsimzf1ZGKcDfs1o
         ELDVfogd9yFMGnYnlLoqwM3uo+UdAXfmovRAqQZ5Tv9lf8m23BidUgpIFD8pKClQcKMq
         ShfAgUXfFwUNNFHkXR1f2L4XgxiC79scPmcxp5vjFxHVeI1d/SN4ZzJI2ppx2Qrq+5Ha
         ByC0mXzoC/d1siOppx2KslUyz6Gu9nsiuF7cgZkX/Ksj5o+zLL4SrxNY4sv616KaPMfP
         zfrg8ZL+TcJCNLFoPwe2psK3kFMnLIB5N21iPFkleMevMmklQRQfgBIMBfVeIL65nEGv
         H2dw==
X-Forwarded-Encrypted: i=1; AJvYcCVSADpq5d7qlgOFXHce9YcFvTVNV6a7Uo+fOEkosquk1m//n+zx1zX+WsfNnCkGts/U0zGFXKjHFflA2x8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiv2rU/aUR4CAXz7q3ricGGHcSGENfPxfy5ozIhUlf2kUpC9Vq
	kSSp+E33Kxb+ADA2E7fmbj3/j4W+GqfnHqa9W4rbECqSsCj5PAeb
X-Google-Smtp-Source: AGHT+IHTl83tojtcKt1hM/1GEvd5oqKuPU1+05ooQj61TNrw7oo90L4IDFQ2CqYjSu0UYzZtS+uARQ==
X-Received: by 2002:a81:5b06:0:b0:675:a51b:fafc with SMTP id 00721157ae682-689637057fdmr19981157b3.30.1722558081279;
        Thu, 01 Aug 2024 17:21:21 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a76d827sm3242631cf.87.2024.08.01.17.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 17:21:20 -0700 (PDT)
Date: Thu, 1 Aug 2024 19:21:18 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 sched_ext/for-6.12] sched_ext: Allow p->scx.disallow
 only while loading
Message-ID: <20240802002118.GB42857@maniforge>
References: <20240711110720.1285-1-zhangqiao22@huawei.com>
 <ZpArK0qxZZI-0ykt@slm.duckdns.org>
 <ba2702f9-f66e-498b-853c-d23f1f9191bc@huawei.com>
 <ZpbclgFjf_q6PSd1@slm.duckdns.org>
 <cd3fa16d-5a70-4c85-a591-fa4fa481f50b@huawei.com>
 <ZpgERphu--gPn235@slm.duckdns.org>
 <7d39f26d-3c9f-4ee4-977c-87f9bed0bac1@huawei.com>
 <ZqqNLNWLfjsJ2E02@slm.duckdns.org>
 <20240731203344.GA42857@maniforge>
 <ZqwbK9m6ATnyYxHS@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2HyKJPWEAh1unRYW"
Content-Disposition: inline
In-Reply-To: <ZqwbK9m6ATnyYxHS@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--2HyKJPWEAh1unRYW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 01:32:59PM -1000, Tejun Heo wrote:
> From 1232da7eced620537a78f19c8cf3d4a3508e2419 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Wed, 31 Jul 2024 09:14:52 -1000
>=20
> p->scx.disallow provides a way for the BPF scheduler to reject certain ta=
sks
> from attaching. It's currently allowed for both the load and fork paths;
> however, the latter doesn't actually work as p->sched_class is already set
> by the time scx_ops_init_task() is called during fork.
>=20
> This is a convenience feature which is mostly useful from the load path
> anyway. Allow it only from the load path.
>=20
> v2: Trigger scx_ops_error() iff @p->policy =3D=3D SCHED_EXT to make it a =
bit
>     easier for the BPF scheduler (David).
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>
> Link: http://lkml.kernel.org/r/20240711110720.1285-1-zhangqiao22@huawei.c=
om
> Fixes: 7bb6f0810ecf ("sched_ext: Allow BPF schedulers to disallow specifi=
c tasks from joining SCHED_EXT")
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> David, how does this look?

Looks great, thanks.

Acked-by: David Vernet <void@manifault.com>

--2HyKJPWEAh1unRYW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZqwmfgAKCRBZ5LhpZcTz
ZB79AP0fhgUXq3gpSUCPJzcG19NRKiYI3ZqlH48GwLcGUZ3KHgEAg2wNHvojZiiS
Y+r2KDgvvETkKLw9ONYr2u17hFgS6wU=
=v2W0
-----END PGP SIGNATURE-----

--2HyKJPWEAh1unRYW--

