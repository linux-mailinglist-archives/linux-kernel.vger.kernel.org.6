Return-Path: <linux-kernel+bounces-329091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4384978D2D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB0C1C2221E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 03:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E143317C96;
	Sat, 14 Sep 2024 03:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHjjrBQE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1175D528;
	Sat, 14 Sep 2024 03:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726285624; cv=none; b=LzOa2rMwtv/LbXbvHa6H7Qn94kotKbotbfXyS9soOG8shgdHvMxJqFFmCyo4khMqo8qRylWhR4fFhqQIQRJu47lYFi1c0/Ys7vjedAz6//4y1nvZJ/ET7aXBEGKyDYeIG9aTfmXQPblWtU3T/mGw8pI+Sz4Noa6LrzOxsDKNvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726285624; c=relaxed/simple;
	bh=UOGC/8KQyUmk/djAeqsWg+upqOqROGfOn5+f87rsqlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCEz2DpjZvBHlWba0VRT/2roiU2AG5+mok6nZ+PtMwjiezfCJfzWWxoN5ZOgEdE2MIiOPPREWo26uUAeNYFFkvjnoKxaUulc5w/TdXbua2JOJEVF9gfHWgwKB4FDv9QfQQ1zDnzydUC+6sfKL3sfOPfKs/g2JiJaG0pXpSSqStg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHjjrBQE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2057c6c57b5so16838655ad.1;
        Fri, 13 Sep 2024 20:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726285621; x=1726890421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UOGC/8KQyUmk/djAeqsWg+upqOqROGfOn5+f87rsqlQ=;
        b=UHjjrBQEgWhdLMsCBojvW5iG4XMa0C4Hf26Q6Jsh7DQGqA6zWKuhHCb3J1aKnv3h62
         rOttdiB/s/RTlTrmiS/dKoSWe4sW7OCGZ0bykWKzrvU0KsEKD5bNykUwc5Tw5ANFUD9E
         UXVfO1rA6ACqRaLmNqP63oughCOCsykJQF8Ol8KAmYrjh1IUkNIVhv05dxuoMN1Wwf0R
         hH18GK0m+uhEOsq7IYAlI/m5SzvGYA+VzeVSLgdqVUb7t+VwVMFLbPiYMcpvzSYz7E05
         yaxAjLbqCo78punicT9X085i6LX7gKTdbq5pr+FjfKhM7UlLpkhZPhfhVsZ7sufoAuPP
         PN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726285621; x=1726890421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOGC/8KQyUmk/djAeqsWg+upqOqROGfOn5+f87rsqlQ=;
        b=trwFZhuzPo6rbqXL95TR7qPL2Sw56fO60V35vdD5hL11Y9gQmCa4CFPtxDVWpGLxsC
         gEu/ALrgv1OPWwF0S+BEHiKYo3GYYNbLL3z3AYa33qLXivxaTn4CGmPHmt7EfJTzmpcq
         SfC6xrwbvsRk1IjwtzbxBOfAXaNuvJmdTAA6hbwfCv9FIisf/N/Ol0B+FvoNTdCYa5pH
         iNqTuyMrp5Pi7vwAOXoe3OUNtkgT3r8oaRbTtMEeASXp6lHPbPFPUzFSy6c7/Ps+8O5q
         GrGV2qpCIQ8SvFOZrL7Sid35NcaI5qt2j7C9oyWTCrOK0P/l59L8vpT614EeWW/DdhHg
         T47A==
X-Forwarded-Encrypted: i=1; AJvYcCUJTILowRlvK1FWnN3/kfbKnax/B4ypjS/Sd9brTefKGhxlbVS5a94oXLyQ2NHgQ6atmEPA6hoFxKLgmiWn@vger.kernel.org, AJvYcCX7t2W+hzm3jJxraKM3GKgJQ+jhUN3T5gvmu8HFpn+XNpX48SaMDJyHnosufQSdoMjSHJ3DvzqAIv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRpMMfhBulhIrqykj4KQsFMjFF16Ul7c+mUy4FHhexmzIlVXK
	ZZp+Kq8rFaJiXqH24UYJkuoTCbLy0Av7dvf7UrmEFKjBGozjxozh
X-Google-Smtp-Source: AGHT+IExTh4sE2dSavfpwo4le+w02Q/wEN2CuAipPKijPK4VJUyg2q5Zn8F/TmmAXocQ0Y+9QvxwMA==
X-Received: by 2002:a17:902:d501:b0:205:7b04:dde1 with SMTP id d9443c01a7336-2074c6df55dmr214950935ad.20.1726285620519;
        Fri, 13 Sep 2024 20:47:00 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794731606sm2978505ad.270.2024.09.13.20.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 20:46:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 332114A0EB86; Sat, 14 Sep 2024 10:46:56 +0700 (WIB)
Date: Sat, 14 Sep 2024 10:46:55 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com
Cc: kevin.tian@intel.com, corbet@lwn.net, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	baolu.lu@linux.intel.com
Subject: Re: [PATCH v3] Documentation: userspace-api: iommufd: Update
 HWPT_PAGING and HWPT_NESTED
Message-ID: <ZuUHL7HXAe0vANdY@archie.me>
References: <20240913052519.2153-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PBkg31RWqd7Uf7Oh"
Content-Disposition: inline
In-Reply-To: <20240913052519.2153-1-nicolinc@nvidia.com>


--PBkg31RWqd7Uf7Oh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:25:19PM -0700, Nicolin Chen wrote:
> The previous IOMMUFD_OBJ_HW_PAGETABLE has been reworked to two separated
> objects: IOMMUFD_OBJ_HWPT_PAGING and IOMMUFD_OBJ_HWPT_NESTED in order to
> support a nested translation context.
>=20
> Corresponding to the latest iommufd APIs and uAPIs, update the doc so as
> to reflect the new design.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--PBkg31RWqd7Uf7Oh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZuUHKQAKCRD2uYlJVVFO
owvjAQDSw5TgYY8NMgLw+QyfLivJhB7uKdT02aP1nAn6TtpTfQD/QNhgfBqI6HQK
JvLMcrifmDGlSUVtqide+k63/C3V1As=
=Mu1T
-----END PGP SIGNATURE-----

--PBkg31RWqd7Uf7Oh--

