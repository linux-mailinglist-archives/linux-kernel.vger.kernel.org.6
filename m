Return-Path: <linux-kernel+bounces-517389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 734E0A38039
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A30F16BFBA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E68216E1E;
	Mon, 17 Feb 2025 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g9cwu4C3"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25742165E3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788158; cv=none; b=hRP5g4SGCj6Gv++Gcf+LooDjyIbfDyk56zVIu8eadRZmz6QLriRDKdWgMGPQLXTxBJSy4FS+Ir8eUah9FD6FgEMJhUtiM4j4Y5LsWcI1OPAQ8/n4w8EmnGYj/Yy+zpeGM/x7VxZIIPW4GpjxIXmaKTcoFaDrV4TJ03tDgWINxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788158; c=relaxed/simple;
	bh=7y33fDb0wMIs6o3xh7SVgy+AZNBArbTifjA3ejNW29o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mey/pMgCZBNJ/85bPDixxeY3zcA8yb1m6Ad+2TfSVCAlHfF7JzZqwM+zeIvH6ds28nR1L39ZkpvYq8mjeXgE4TrU0jN/B7cs82c0WKs6FxXJZ/REK4VJ3R+fq0umXNl0ghUyvxivVXUmmuiFkOK1cEvHxn1kU3qbFa9aUwUgiUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g9cwu4C3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f378498b0so1287011f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739788154; x=1740392954; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzKQkD8qOhvMp4rRnOtjNfMjGk7qhy8jucg/scdAJ2Y=;
        b=g9cwu4C3lQ/wGzgPwQqKUz1B0OCbC9vtjPl5uy+Hq2UM9OMu0abfoZjtbTqphIwyse
         86I+OxVuh8o3vUpSDT8t71RKZDuFkKpjoLPKzU+sH3hyZ4bK4qssaWkH+EHSvhUSgp17
         513UD1WqIndTIDJV0rdbuDDAqhDmO6KWra6cOrzzT4a5ChV/+K1ZzM/RezHirnfCGwK0
         KtJBGc+MbN7jXSftKND5X5dJwaZy0AhGbSYqbM//cZ2RNVrs6a0yK+qoNKEU361Fmivv
         fTQBCQ0ZHXo87NUBIxYeaYr8FzWOwhEdM430IFEc0oLSz+HnOLKwir9p3qdORBt4YO4i
         54Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788154; x=1740392954;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzKQkD8qOhvMp4rRnOtjNfMjGk7qhy8jucg/scdAJ2Y=;
        b=ZY+PLA7v4vJFyBYjZGhAJWFoiAkVFxisJEKmPEVkvWvJ14HJtids86xQodHulI2PTF
         MKoLQ2JIrnLVrDka/e/mNRbPJLffayGlJxrF/C6XrqVyD9nGgz/UNRqC/Z8T22GZGgII
         ABvAlQUZmEAB1QsIs+iFVHBLCj6r1Sz9mrcqzrY7XtqBxZSq/fTVlDAipKMv8H1CIx5O
         sox7pS4Jx3svX9ocmj9iefXBZ1bzALWML0K1AINzlzZsRZuMPJj4VLn18MLpElcoSMBf
         OLi1nYGG11nl05X9SSyc2tgnlmfNImdt8QysQ1FTa13x1XbhGEJCNLy/k5b8/SIz5W4T
         3TNg==
X-Forwarded-Encrypted: i=1; AJvYcCVdt53dJEHHGu4oFMtvmGNzGzj25zm/4OBoauxmkFZsLMV1oH23vGBeBR9BshHuxYfgg7rK+dWQbdastoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWWc64gXaE0ukeY3cNa9RbdxhwVKvPEaYzp4oadjaoMW7SWuTH
	+Ds+53VqVjmuFI/a0EJb/kLuwQoKZJKFc21UZGKenGWmAWR1zFms5hWtA6P/laU=
X-Gm-Gg: ASbGnct+wftxLv71vlHKXtxSzcKDqGVWAAPOAuy9M329xPDVmcz5tojQa0TxFxk1xlz
	PxOfq7UURTE5rpqXLpQ8tnQpDrCVGw947Nu0tX7o8uOuG2KuVp0Sa9e1Yplien+sw+8I7BRtXre
	lGUrmVTw5hY4b9qPm8l9CmN7Gu6wMu9+MdMWbFC085PJwYmKuIrMaKOtDLVWWXJi5gFGZ+Oy55v
	vb+eim3cB+HSjbuAT8EmbNNqda3yGjYWaoV3VvVTmeb6XNwkU5hzIfcrjFNzjRmXLM+fFdVVXTH
	jbf9QQdxm3faEhkDtw==
X-Google-Smtp-Source: AGHT+IFXGWNmh521iDjtAP/Y/ccforECaRdDAMLzD71tuBAY1iklUiezWqR45f+ndyEc6d1qLKHfjQ==
X-Received: by 2002:a5d:610e:0:b0:38d:e481:c680 with SMTP id ffacd0b85a97d-38f33f29144mr7171984f8f.18.1739788154012;
        Mon, 17 Feb 2025 02:29:14 -0800 (PST)
Received: from smtpclient.apple ([23.247.139.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f6674aafsm3167381cf.76.2025.02.17.02.29.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2025 02:29:12 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH md-6.15 5/7] md/md-cluster: cleanup md_cluster_ops
 reference
From: Glass Su <glass.su@suse.com>
In-Reply-To: <20250215092225.2427977-6-yukuai1@huaweicloud.com>
Date: Mon, 17 Feb 2025 18:28:54 +0800
Cc: song@kernel.org,
 yukuai3@huawei.com,
 linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com,
 yangerkun@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <406FA5FC-9D33-45BF-9EC5-36114C846B4F@suse.com>
References: <20250215092225.2427977-1-yukuai1@huaweicloud.com>
 <20250215092225.2427977-6-yukuai1@huaweicloud.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> On Feb 15, 2025, at 17:22, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>=20
> From: Yu Kuai <yukuai3@huawei.com>
>=20
> md_cluster_ops->slot_number() is implemented inside md-cluster.c, just
> call it directly.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Su Yue <glass.su@suse.com>
> ---
> drivers/md/md-cluster.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
> index 6595f89becdb..6fd436a1d373 100644
> --- a/drivers/md/md-cluster.c
> +++ b/drivers/md/md-cluster.c
> @@ -1166,7 +1166,7 @@ static int resize_bitmaps(struct mddev *mddev, =
sector_t newsize, sector_t oldsiz
> struct dlm_lock_resource *bm_lockres;
> char str[64];
>=20
> - if (i =3D=3D md_cluster_ops->slot_number(mddev))
> + if (i =3D=3D slot_number(mddev))
> continue;
>=20
> bitmap =3D mddev->bitmap_ops->get_from_slot(mddev, i);
> @@ -1216,7 +1216,7 @@ static int resize_bitmaps(struct mddev *mddev, =
sector_t newsize, sector_t oldsiz
>  */
> static int cluster_check_sync_size(struct mddev *mddev)
> {
> - int current_slot =3D md_cluster_ops->slot_number(mddev);
> + int current_slot =3D slot_number(mddev);
> int node_num =3D mddev->bitmap_info.nodes;
> struct dlm_lock_resource *bm_lockres;
> struct md_bitmap_stats stats;
> --=20
> 2.39.2
>=20
>=20


