Return-Path: <linux-kernel+bounces-327465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC6E977656
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AE91C210B6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886444A3F;
	Fri, 13 Sep 2024 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUbkVguT"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A264A06;
	Fri, 13 Sep 2024 01:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726190292; cv=none; b=q2RSqTG4A3sb7u2uAJYXgd0+LW59Q5wAFGZv7addllcDaaZ8rbsygiaGnGeyj8hR7S+aSCNUX1Ue+fKcp8IoSmY6yPdSFahecYgIZI33pcExT/1+D/ZDvAY8cNu+KL9lt8wtg/cIRHwJGU3j1MNNTGSUQEN/cBDxxLWGZR9aCcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726190292; c=relaxed/simple;
	bh=Yp6PMUWJlSeoZOwCPYo7ijS5MpmrOP2BcUzEIaBVPcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jc/EdfMPyzaFDtMLAhdsH3Pgbq6suVRTVtst5s9n14819FpB1ib3+Jg83cjPsb7t3QCDBCsrmcRJTp6sf569SZIwidsTe+7TxoTvRDzGVecCX9DbM09oQSw70RrzPVv1Hr5QTHcZPnac9Nnbp82SGX33ZGHksScA9RvvNC43ESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUbkVguT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71911585911so1375296b3a.3;
        Thu, 12 Sep 2024 18:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726190289; x=1726795089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d9Dv1rZ4lSX5JLn7g5A6qbc9I0zKJhTNVaRog4l8gvk=;
        b=VUbkVguTlOw1eBMSoMATp6omKnSrBNg+jBhdNLCwMImDu+tys7Mocsj1qfYMoFLj0p
         t4v8YBUc+6+6V4CBUOyObMxJOSt++sAKrPn6PJ8G2yPLhFCciEPeYZxwb5n4G0pIQOWD
         /6yr71/BLLCNzL7lDOk4eFfc55ARbnnUGgFepGL7bVyVvsh/ZlLs/8UINl9l0qIavcrV
         KaUquvYgo+MkR5fgl0rcCb60deYIydRD00Mmv1rw+84yzpdxr4M59gEWluPo93NPYHCw
         fZ4KsXyclLThzVFeUqXFTr0pQgZVzMl+J5ZqRO8+ECPiMMRA0g6gGp30GNZLAfs8MQYB
         tj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726190289; x=1726795089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9Dv1rZ4lSX5JLn7g5A6qbc9I0zKJhTNVaRog4l8gvk=;
        b=jcE8Nz9T+gnbojdGsWrSZNXbyoaepwbQeejeTeeBpl4QXp/Q7aJ7Vna2nkvRv2AimE
         OVfRXMa1HGLOkRPoZJF11W63GmLYZwH6a4CxEMuPZ4vE0KIYHh7LKIlPbEd9HlMez4qz
         hWyawohh1KZjktF5NujwN1WFnb8Wg91wSYiBYJK8mn6bcreKxwiShW3rSiJ3tluOlOL4
         yot3id2oPDSYaQOh5NhUJZnh/GKKngf6RJVEqCvpVR+PNP9W3JhEeWSOK7EKHdWF8KkO
         cUlD//aXeieQkOr0dRagYYSLCm8XXIMeVLlvtBVinj4kzQH4oD6XjWfEIymgP3RGVVgl
         6PMA==
X-Forwarded-Encrypted: i=1; AJvYcCUtYDQ/+GLaZkEkG3iu+yJNxF46tXHb5mfjEgNjbOhMZmcGwJSOzQCuM9qUIBQ2m+3o/LxBtOp5wwE=@vger.kernel.org, AJvYcCVjBirnBnAjKdsCnV2DW5y42WHVcHuGhVJgaX5OhFS1Kc5qE7e4DvegY7gr3kVbeIFDPQ3w61DI+g5215t2@vger.kernel.org
X-Gm-Message-State: AOJu0YyvCZ96/VpO0piokF2LXUakvCueAwoCqY9Vbms8ZtwqIlm78Idc
	Um2GqB6/ZGogFm4LOjASgAWzqMxADvugz8gVgBGtZueQAMbQjoMH
X-Google-Smtp-Source: AGHT+IG6Z1K2Jq2CgbYNkWAoessZF2j9kOgTQZdK15l+SPX166vfeZd+aLbSAVSTd/QbfgpqEkcmGA==
X-Received: by 2002:a05:6a00:3cd1:b0:714:1d15:663 with SMTP id d2e1a72fcca58-71926202c98mr7348108b3a.24.1726190288659;
        Thu, 12 Sep 2024 18:18:08 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908feac91sm5154667b3a.85.2024.09.12.18.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 18:18:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7260D4A19C6E; Fri, 13 Sep 2024 08:18:03 +0700 (WIB)
Date: Fri, 13 Sep 2024 08:18:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
	kevin.tian@intel.com
Cc: corbet@lwn.net, iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.l.liu@intel.com,
	eric.auger@redhat.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, baolu.lu@linux.intel.com
Subject: Re: [PATCH v2] Documentation: userspace-api: iommufd: Update
 HWPT_PAGING and HWPT_NESTED
Message-ID: <ZuOSy3ITxJ7tkMnl@archie.me>
References: <20240912021503.205502-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q6dB82KOjQiJ6b5g"
Content-Disposition: inline
In-Reply-To: <20240912021503.205502-1-nicolinc@nvidia.com>


--Q6dB82KOjQiJ6b5g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 07:15:03PM -0700, Nicolin Chen wrote:
> +- IOMMUFD_OBJ_HWPT_NESTED, representing an actual hardware I/O page table
> +  (i.e. a single struct iommu_domain) managed by user space (e.g. guest =
OS).
> +  "NESTED" indicates that this type of HWPT should be linked to an HWPT_=
PAGING.
> +  It also indicates that it is backed by an iommu_domain that has a type=
 of
> +  IOMMU_DOMAIN_NESTED. This must be a stage-1 domain for a device runnin=
g in
> +  the user space (e.g. in a guest VM enabling the IOMMU nested translati=
on
> +  feature.) So it must be created with a given nesting parent stage-2 do=
main
              "As such, it must be ..."
> +  to associate to. This nested stage-1 page table managed by the user sp=
ace
> +  usually has mappings from guest-level I/O virtual addresses to guest-l=
evel
> +  physical addresses.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Q6dB82KOjQiJ6b5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZuOSwwAKCRD2uYlJVVFO
o0OaAPwM6FumUDIil8nGnHe9Y/dbNttmC+bS+5w4gXSnlpG87AEA5HC2c3jQt49S
VlXWJWQKvlGu5wi0sZOUQXBN9rH+uAc=
=DzZT
-----END PGP SIGNATURE-----

--Q6dB82KOjQiJ6b5g--

