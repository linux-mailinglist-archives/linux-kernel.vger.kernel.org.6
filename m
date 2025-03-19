Return-Path: <linux-kernel+bounces-567729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC989A689B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9C53A4A69
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF61A253B74;
	Wed, 19 Mar 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XyNvGu/D"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314DA25332F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380398; cv=none; b=b2ec5fqlP5tSIitVlf8OrXpL4RCkYfffEcmXp/4Hcr9REXO22aAln7kzlsUx4LxjUI6/kZXdE8V880g2O0uUtE+PyfQHQ5FJg15EhfCEOhmnXtwfAe9oyIlgwb5UzFvC++y+nywzyxTF6SuJcmoJza+8LsnJT5YaDd2jPt/5+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380398; c=relaxed/simple;
	bh=Z692E4Us4bwCPQMfgiKqOm+CDl4LPK/+OBs3OKkVM5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sxef2lBOOQVjlYTmQ8CA3NyyPYXRA/Uf2GuY0zgT/Gpw+BHb4lxisWkRmF70Z17hS26LNY9B06dd6E7+jrnYZ/eKzDc0l5Z/BCOrIbHzoaAZXnlv35537BxZ9mJVUsiWqv5tljb9DjBfpoEwEle3M8ornUkt1sjk9F+rS/wwBZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XyNvGu/D; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so43329075e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742380393; x=1742985193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHUFNCIIO10GyL2uIfpwlNVW74wFOFO/xZ1QWqgzYRs=;
        b=XyNvGu/DUsb0ALzvJ1GlXEioewz4XGRtj/hx2tgeh4HwsmBNiHVtrQKlp7c/oIhiV7
         MDIX3r/xOvXIUjjmlTJzQrkQG5viSxMLGX2oDkPKoU09Nmk1AXqW4CmpRSg8iMBhGC3E
         wRHALGKRiGiOm4ABLHvPGI6a+O07vjONfZKoe+fA6nbox9ptzCY10etM001XAnakZIpI
         2HtAYbaQMg4jkJ2GYk0E3bYqCPB9fNb4lhv7FrEzvkH1lAPAp0m5uImzeDNB+sReQbkh
         jmC73feY6eqt2FvIP6NZePtii3KCCyhk5kCU4niYy1nneY2XBiy1NG8Wpf3U08Slyy4W
         ObCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742380393; x=1742985193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHUFNCIIO10GyL2uIfpwlNVW74wFOFO/xZ1QWqgzYRs=;
        b=lrfjntsttm3+GXM2LcBKrd3hS05OcKagJNxCUuYiw2c/MAHaV9QKLvfwxbnJScJ4aY
         uKION8N2mDz8ln9+GOPlm/liVWonA4Kj/Wwo8miy///6TYHeG0gMQC6RUxFGvctxs4nN
         5zE3NIBoE3o4WByFEt7KzL+gqLb9WLVNuOdsMTc0MdCTtjquUOqgjCBFMJqAc7/nyz1a
         Louz1M+YVqn7lmMv0AFA+kJR35Cgaa1gNVc5WbV9rIwR2w/G2BZIGmapfMPTiKl3uR6b
         m7vYPehbqLJVF725ogVIredZSSUdCsTHNqds7xQaQBR4gILlFQizIzU92ConO+zPCXag
         SnUg==
X-Forwarded-Encrypted: i=1; AJvYcCWNdAc1/bpM53w8UeaWiQG154zm27eUfQ+fzrDDUgO8XEFnEu7B4TPlwjPc++51J+ozcrCNVTKGFlQFaJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3hqTRCSGmyY9Cf0ATBLOD6c72gCXOcg+gBFpMrMjQul3kyrnJ
	HSrQ2vpvmFCH13m3VuHQfb67JoqTskQoi0td8Cmeqa14ujzdPp0FQ8mHGh7R8X0=
X-Gm-Gg: ASbGncsVeVIHfXxZPxZ2GzXOW3jumdH3kWNngwouQ9A3bZNHJ0YAEdv90JkrBpjbGee
	DC3lUuTRq/BRDX2etEKrpwC/cIwmS+bAnXfbsvP2P57Z1EYTH3NY/9McpW2oqCuuVbarp0p66zd
	PJiutauhS3P90GTUWA/3ZZs7f0aybnPd4SB60/+2t5cOUJy6Cbrz8nfvfCLE6nveHeXvQtRK3yd
	cKRNgc8jVkVRA8ahtMpvTDXMHfeG0L3IE/nczyckMLq5wDjOzGZzdE7UcSHNKHzfxnXBuWuT0UP
	g+0g5YVTzbln/goTtLKBmYq8684SxKf7WL6LNePTc2kO7pU=
X-Google-Smtp-Source: AGHT+IEwlmcO/Nsy2vMvC0TJIU6rQJVpXquecxaeZ4cOXlH7OaHP55G2sGoqGpVHjHr9T/l+vWkvLA==
X-Received: by 2002:a05:600c:4fc2:b0:43c:f64c:44a4 with SMTP id 5b1f17b1804b1-43d4378bfbamr12087425e9.8.1742380393287;
        Wed, 19 Mar 2025 03:33:13 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4453227dsm14414315e9.40.2025.03.19.03.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:33:12 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:33:10 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Hao Jia <jiahao1@lixiang.com>
Cc: Hao Jia <jiahao.kernel@gmail.com>, hannes@cmpxchg.org, 
	akpm@linux-foundation.org, tj@kernel.org, corbet@lwn.net, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
Message-ID: <rxgfvctb5a5plo2o54uegyocmofdcxfxfwwjsn2lrgazdxxbnc@b4xdyfsuplwd>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-2-jiahao.kernel@gmail.com>
 <qt73bnzu5k7ac4hnom7jwhsd3qsr7otwidu3ptalm66mbnw2kb@2uunju6q2ltn>
 <f62cb0c2-e2a4-e104-e573-97b179e3fd84@gmail.com>
 <unm54ivbukzxasmab7u5r5uyn7evvmsmfzsd7zytrdfrgbt6r3@vasumbhdlyhm>
 <b8c1a314-13ad-e610-31e4-fa931531aea9@gmail.com>
 <hvdw5o6trz5q533lgvqlyjgaskxfc7thc7oicdomovww4pn6fz@esy4zzuvkhf6>
 <3a7a14fb-2eb7-3580-30f8-9a8f1f62aad4@lixiang.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r2xghzya6xc4nema"
Content-Disposition: inline
In-Reply-To: <3a7a14fb-2eb7-3580-30f8-9a8f1f62aad4@lixiang.com>


--r2xghzya6xc4nema
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
MIME-Version: 1.0

On Wed, Mar 19, 2025 at 05:49:15PM +0800, Hao Jia <jiahao1@lixiang.com> wro=
te:
> 	root
>   	`- a `- b`- c
>=20
> We have a userspace proactive memory reclaim process that writes to=20
> a/memory.reclaim, observes a/memory.stat, then writes to=20
> b/memory.reclaim and observes b/memory.stat. This pattern is the same=20
> for other cgroups as well, so all memory cgroups(a, b, c) have the=20
> **same writer**. So, I need per-cgroup proactive memory reclaim statistic=
s.

Sorry for unclarity, it got lost among the mails. Originally, I thought
about each write(2) but in reality it'd be per each FD. Similar to how
memory.peak allows seeing different values. WDYT?

Michal

--r2xghzya6xc4nema
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9qdYQAKCRAt3Wney77B
SSAOAQDscRz1ZK2hjaZeAzcmaHDL4+BU5iqRrEbfZn7B5FsPTwEA4guBl5SiFtw1
e1egLefaDOYhMuPKh+O7ZQAYqh+S2w0=
=6EjW
-----END PGP SIGNATURE-----

--r2xghzya6xc4nema--

