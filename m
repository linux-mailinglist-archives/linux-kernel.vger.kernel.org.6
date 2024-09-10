Return-Path: <linux-kernel+bounces-322784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E4A972DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9FB1C23D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5CE14F12C;
	Tue, 10 Sep 2024 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TipdhiDB"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CCF46444
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960923; cv=none; b=VyFlq9DlfsFdYAhJskZOF8x3FPU5F8yD6DakqgGJbeXSibRxwjpbvAyC00eXwxMTzLFNsV6wOJnr1DpAf5zKlBWb+q8lsZF//rmxTHi+1KXpEEklNuAWyFW/SVZx6BGkryL4K2uxajHAMUQNR/530aMYk/D+Y32dHanOFxBshxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960923; c=relaxed/simple;
	bh=XNJJ3mHKNptpNG3Nl27UzTbSVvpy2ePe+ZhtX+KoZlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0a8WHq0lltGe9RqLQ1FIv89AhL76QaNTFkH/etFm1lEtAJNjvG3Y/U5d/oBH5ZwYDi4WovL2VU8zfE/UEpMg77dOGBNRdTzDxqzetX3+2rSBRL1HBMUWWaZZmgktCGPj/CHwuxTGGCUqCOCJo3nPMYG3rgVT8FbxRgrGv2H3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TipdhiDB; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5365cf5de24so3788636e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725960920; x=1726565720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSAqDYPbQePoYyU/zqFPQ8g0B1IkyNHpQhriOaJbTlY=;
        b=TipdhiDBz3USRsobgfOXH3HH8/988By3/HXKlMLA8tfdt+CLzkhWTjqmlutPI+OLQE
         qmLcvuz7K2uT7496/hStDuBuWBPU6g0HVC7nqGcvpnRzftsmSkY8D6Wxs/YeoEhIT5TW
         1ZsFvsDCZ8qetqMuyvmzM6/M0f28aEw4LXdE6UHUlsoYrH2lAZ9oSknmfgeFrMOTSitR
         LTt7M5TwJ8H+KK1iHXRffZtXEPwkuKU/Yrkj28WTSdTlZkOvXF4SVLpa6ECRE6PftQPk
         PLoxAKAbFXAkkhmz9ngKKIBYUPynP1nLnK0gA6Jk6363PJaa3D28iATfAkPdpYth3oB0
         KQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725960920; x=1726565720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSAqDYPbQePoYyU/zqFPQ8g0B1IkyNHpQhriOaJbTlY=;
        b=mpntmEfOjwuCG8rc8tyOO4nb4XQi1R1VkzQEtX5v+allfJiCTB+I1AE7BmQOaUgtJn
         aSrWBR9yJNbuTdggOrP1yU6DtYPs5pvd1p+tRgmHJMEmwRM/7wsl3znUhsH9blL1Rm3L
         +ToG22iz7GUCIcBZZWDHxmekpBDMMOWkF/hJymzfoUVpzWQTE9/C1Ao8REuKWxfzbK6W
         s7NVuDzPfCzHAmuQnUW7EAGs8wFOiqQRmL6CUf07ZwYo1qBFvH8DegOBu/4zkiupeZ+P
         hnWu0htfKNI9U3jFbH8SZzFMS3MMOfpMoyEo3Scpj1RzNJtiPa9SIlB/IONpgfkxDhP5
         VlNg==
X-Forwarded-Encrypted: i=1; AJvYcCU0OByhZKzt9+79fW5eudB5w0gbNog6SSYI9Au/XBSRLWQeZhohSbdYRRF7rkZJSNlSkU1WAG77cJV/Pi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkJs0s7B5xFLfYCT1LLLj4K6O9SvNne8V0w1vFE5f9P37iX3GI
	IlLeML1PPAH7znJSqAa8Jo6ARtOZWVcW4TWGCBLoP0DnzYe9QRtoaLjVqPLu/5A=
X-Google-Smtp-Source: AGHT+IE1hXLrCS22kk5lupmDOywOYGlrbDvzsi3wjSQiAIoaKbjPCBcHNXQ3b0UVb6vJJahfpT6NTg==
X-Received: by 2002:a05:6512:1599:b0:52c:d645:eda7 with SMTP id 2adb3069b0e04-536587ac1cbmr6693958e87.18.1725960919519;
        Tue, 10 Sep 2024 02:35:19 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956ddbbbsm8230804f8f.93.2024.09.10.02.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 02:35:19 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:35:17 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Liu Song <liusong@linux.alibaba.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched, cgroup: cgroup1 can also take the
 non-RUNTIME_INF min
Message-ID: <t5x3lxz2au5caw33redslk6vmak4nc7kmuxzflhd7tr2x4d7ma@ssdb2g4nkdlq>
References: <20240910074832.62536-1-liusong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="54py6dw7gyowvoqy"
Content-Disposition: inline
In-Reply-To: <20240910074832.62536-1-liusong@linux.alibaba.com>


--54py6dw7gyowvoqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Tue, Sep 10, 2024 at 03:48:32PM GMT, Liu Song <liusong@linux.alibaba.com> wrote:
> For the handling logic of child_quota, there is no need to distinguish
> between cgroup1 and cgroup2, so unify the handling logic here.

IIUC, v1 check prevents quota overcommit while v2 doesn't.  So this
isn't user invisible change (i.e. there may be a need to distinguish the
two).

Regards,
Michal

--54py6dw7gyowvoqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZuAS0wAKCRAt3Wney77B
SaZZAQDkFGG+k2VhqjCbKuJOPzh/hD6Zunijo6SpKsQlUXnZlQEAxBqVMOGdD2Lv
w66v2crcxbF9HK7dqXSHlhXynaRdgw0=
=u97Y
-----END PGP SIGNATURE-----

--54py6dw7gyowvoqy--

