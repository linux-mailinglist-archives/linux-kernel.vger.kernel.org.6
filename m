Return-Path: <linux-kernel+bounces-322986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C456973647
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306F3284F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F255C1DFE8;
	Tue, 10 Sep 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pl1JxxZJ"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CDB1684AE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725967989; cv=none; b=n6e+Z9H+Fnv4EOHJT6uLxXTIUcLD5VIgmVwxXqsVZkFVo5NtN3sdb5MwwhpdrrWGowoDRZotzFl6/Re019iGJtuvalxVTdK1W/1V15LiKvjlfL8veED0DvibT2YOG0EGUqSBhYDfDqHre7sA1kCGPXO3YayEdTZNZluV8qpyfZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725967989; c=relaxed/simple;
	bh=dD7MFjjgq+OQH2QBt4N1yvwPwT2h9sYXw3+FI4Ewxj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d76Nc7ywTmabXp32+IrMLDWb5zpp4QkgBeD0jolN8F9BdxBckPimfmikb8mh0Tiw3jMpMYoX+o0sa3JfG21Su2aoCXQafqQaV/ILmBPQv8vItsGVE+99Y5GrPMkdgX3CrUK811gCBwaPySdiKTrctV6BVrrE9JSplH0xnjChqFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pl1JxxZJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-371ba7e46easo560842f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725967986; x=1726572786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dD7MFjjgq+OQH2QBt4N1yvwPwT2h9sYXw3+FI4Ewxj8=;
        b=Pl1JxxZJisyly8w86iYg2y+Mb+439aH6kkFbrzg9RMyrFTOKJMjjOrAnLrkKBExo8E
         JEAd4jGdY2smVwdXCOp1+murDKWmYty+f7Ceo1veIr936w66bwISkPXMLmAEXmTVvU2L
         qNaMTAmLBfTpcEJVirgjkrd2574CsSkUg+yTyKXU6Fwk/mLurXnGZr+3fRdxiTYBrpdf
         T8FSoJSZhh9E1pCuuOVnmeMz73RjQ6YPMfGZoNL1iUiRC2VxMQh3zyCT8jXoCW9EMiAl
         GF04xvvR7WXoSSt9mLJntZIP/PaZxtkcq7F7eekMyWCogyDl5qjBJT+85R4lNIDewmeb
         /BGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725967986; x=1726572786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dD7MFjjgq+OQH2QBt4N1yvwPwT2h9sYXw3+FI4Ewxj8=;
        b=dE1QzJ2ac3jVnRS7EvpDtmzYiLOYLhmsJKWXt5bsXs+iPL6j9qeL3DKOyUkxOSBMWz
         IhKULLyrcYCTk05zMH4wPzeC9AZB6x5Kw50w92OZl1S7V9E2yT/Eqld5HAZfxOWJhEhl
         E8c3GXOkpI1Nydw9WuuLELXkd7rCUTIJ1M0tHdIN6UAgD+YJhq5RM3/Q7jTznuPartGF
         5a4MvXouRDjHP7wPuORdN7rIuBHHZWltySgqIFVIwbB4lixNAPzfe96VKMBcb2rfMLBL
         nnTkEP++4hPJiichonkIFXHYpMbdU6dV3IEQpPhza6cGPXsn7G9RZbEGjIE85YvtcGnV
         2PCg==
X-Forwarded-Encrypted: i=1; AJvYcCVaMaVU49QzzkWMT/A43mp+dlskbrmkrsGcXA7NLPcdDMi8HiuS9VbklFWzwSSK+IMDOGW5v05FVyVq8Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzISvZmKUtonn/bfZz0WNTacUHSSP39/CYH76cx9uD1L82cNC1Z
	SmjbU7VLkobc9QrhQLSrK7IgmUfhqCQ21Bgs/IVR0KxxFw2v0Geq42yH4kKzZGI=
X-Google-Smtp-Source: AGHT+IGCPZLNgtlgfTNoYPlP2/OXuhE7b6NC9+f/tt5lOx4XUHFWh+Bf+oV6lVEI1P/mevSIl8vfIw==
X-Received: by 2002:a5d:6608:0:b0:371:a60e:a821 with SMTP id ffacd0b85a97d-37889682bdbmr8233340f8f.38.1725967985769;
        Tue, 10 Sep 2024 04:33:05 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564b02asm8736427f8f.4.2024.09.10.04.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 04:33:05 -0700 (PDT)
Date: Tue, 10 Sep 2024 13:33:03 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Chen Ridong <chenridong@huawei.com>, tj@kernel.org, 
	lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com, adityakali@google.com, 
	sergeh@kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 -next 2/3] cgroup/freezer: Reduce redundant
 propagation for cgroup_propagate_frozen
Message-ID: <x7bbfxw4bq4bjzz5q2viqsf6ogczzbmws5kdudqqcditjbpjln@y35o6uumvhc6>
References: <20240905134130.1176443-1-chenridong@huawei.com>
 <20240905134130.1176443-3-chenridong@huawei.com>
 <cieafhuvoj4xby634ezy244j4fi555aytp65cqefw3floxejjj@gn7kcaetqwlj>
 <5a29e13b-7956-4f68-8c39-92183e5ed0ca@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jko4zp6g33zza3wu"
Content-Disposition: inline
In-Reply-To: <5a29e13b-7956-4f68-8c39-92183e5ed0ca@huaweicloud.com>


--jko4zp6g33zza3wu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 11:08:12AM GMT, Chen Ridong <chenridong@huaweicloud=
=2Ecom> wrote:
> > This should be correct also wrt cgroup creation and removal.
> >=20
> Before calling cgroup_freeze, cgroup_freeze_write have hold the
> cgroup_mutex, could parent's nr_frozen_descendants be changed?

Sorry for ambigious wording, I meant that the code you posted appears
to me to be correct (and safe) wrt cgroup tree operations -- thanks to
css_set_lock because frozen bookkeeping is under it (cgroup_mutex would
be too heavy weight for all possible callers of
cgroup_propagate_frozen(), namely cgroup_enter_frozen).

Or do you suggest the current form would need cgroup_mutex
synchronization somehow?

Michal

--jko4zp6g33zza3wu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZuAubAAKCRAt3Wney77B
ScGSAP44qGFORSW3hcoRiepum0F8MuDlZBVBJyH56WhdCn7VdgD/fhim9MJ2+dGR
PnfqWIuBO5ZO817o8cQTaJkCxbFxgQs=
=SwvN
-----END PGP SIGNATURE-----

--jko4zp6g33zza3wu--

