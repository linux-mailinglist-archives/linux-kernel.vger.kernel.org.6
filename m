Return-Path: <linux-kernel+bounces-294145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 630609589F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9071A1C21EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E470194ACA;
	Tue, 20 Aug 2024 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FxHqn6FH"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05021194A48
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164726; cv=none; b=DWg139Aac+18i5D+8kyJ6Q/8m+eJpGrEncR+A+yTFfqbWgTDP9OB1bsBOIqlCaAiWVchUlFOVJtjv0ASo3E46hdpKhWuJUDN+yUeZ0/idvJPxFqsdDQpZ8aYrR7VUwj0+XIJ7WJMI44l+LBgwG2J28IAdDmB++kkFB4u8oeQXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164726; c=relaxed/simple;
	bh=esFlyELiTlpKs3CWKZG6G60KKDNNO/y+VTxlq0Hoaas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g55OgY3aP+lILCaj1RSDUIyBIQTW5guhe2EZ7l8UdFLPNMdqKF/YOuvqN8y2Gebf3FOhhkdyoqpqP1Tm2awgH38RCIQZ4lLIzxmfogZnfCuTRvOOjJF/SbvT0hJ3iK7bJiLwwr8DzRMr8/mjb6CwXsNotuoisVxE/8WMCxE4Xgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FxHqn6FH; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f3f163e379so8940021fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724164723; x=1724769523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TgpwFuMMLOMXS/hQ6Zr5uo5qmVPlQl6bud8orFh+UyM=;
        b=FxHqn6FH71DXIOGeE/Rmya3GHOf8EwVGcCA/+xI7+fqnz8c9lSYLESbyjJVRw8l5pq
         Rvk6ATJG0SVvUNENFqa3iABItUWB6yFeCb2qziSnJzl2o3Z1h6ldB2RNay+QMAcHx8Rz
         bF8RjODxMS0W4OuYPoeBj8Ip5w1/uGsPNeSIMlePntnhmtaCF8USjxzGwXO7BN97UkF5
         h/znpMBn5Cb4nHc8bJxr6ce4IMMXLP2lGRmOvDa9nARyJ6BdoQvKGzZQwFHuLwaaOWn/
         QeGnwyVQw2YJVGZwBqEtillsK98jV5i3IzDiuNk51b3dawuS1OGBVtrHuVJ+sKlchuhw
         OkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164723; x=1724769523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgpwFuMMLOMXS/hQ6Zr5uo5qmVPlQl6bud8orFh+UyM=;
        b=ts8wVGwoquHAN/7DB35Lg0HNO/0DDRb05kLYQQ+KmEXkKpfQUGMs1LFCXxtqVuJZfx
         v36G2+8A13GcxTaXv0eOxqT8rjV15HL9A+W5PyukDF3iuujPheCaFB7+UxkOnV6HQF5J
         7ydDPiJjw+7ysGxK4hXeHCGwkyXtNDid4Ljx0onp4Iy44iDUGnf90Pt/RiKUEx4geD89
         BvH8Tc8JO0JyMHJ2lK8Ekc0paJYh4ZBkDCBrd3GnFNMdUuB39/zHOrdRF3eIc9+8boTg
         Q802kYy1y59oM0MYHgnoNy85tXo69Rvrho92rYtGXqx8Bb2stb4ENTJDdEwK7u9tuTWf
         t7tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmN0yEqCRS/lOdlAXKwDh3G5J+zhrvo/XkKM58XnUfIykcGeC20UXYtO1vamy99kv+rSo3mwThHScd0KpVKhGVBS3lsdVFH/Wbr7V9
X-Gm-Message-State: AOJu0YwMPAWce4VoFRIon2cAurdK1EojE7b6wREY8JSMMYJpiEku4apg
	VZIaPVNeTD8AqA/oKMaoQCtCD7Q6W5pBsKnWl9QPRhU2zxKueWOi3Z7AcudCEtg=
X-Google-Smtp-Source: AGHT+IFVwXgnRCh2S3ZlyQoKNHWzEDvNFgDMXck9ADVJ1OMRqAwhUrTB5qjoSPAgMPlERu37srdgNw==
X-Received: by 2002:a2e:4e01:0:b0:2ef:2dbe:7455 with SMTP id 38308e7fff4ca-2f3be573285mr125399121fa.1.1724164723033;
        Tue, 20 Aug 2024 07:38:43 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc0832d2sm6799452a12.97.2024.08.20.07.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:38:42 -0700 (PDT)
Date: Tue, 20 Aug 2024 16:38:40 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, peterz@infradead.org, mingo@redhat.com, 
	cgroups@vger.kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, David Vernet <dvernet@meta.com>, 
	Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>, Barret Rhoden <brho@google.com>
Subject: Re: [PATCH 1/7] cgroup: Implement cgroup_show_cftypes()
Message-ID: <qsdgtsunxgbxb6lf7x7m5777jxmumddomsofuuimqenoyliabx@assdbc6zj2ag>
References: <20240808002550.731248-1-tj@kernel.org>
 <20240808002550.731248-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6efsakeupbonz54t"
Content-Disposition: inline
In-Reply-To: <20240808002550.731248-2-tj@kernel.org>


--6efsakeupbonz54t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2024 at 02:25:23PM GMT, Tejun Heo <tj@kernel.org> wrote:
> +void cgroup_show_cftype(struct cftype *cft, bool show)
> +{
> +	struct cgroup_subsys *ss = cft->ss;
> +	struct cgroup *root = ss ? &ss->root->cgrp : &cgrp_dfl_root.cgrp;

Strictly speaking, this (v1) cgroup_root dereference should be guarded
with cgroup_mutex too (should be the root destroy concurrently).

> +	struct cgroup_subsys_state *css;
> +
> +	mutex_lock(&cgroup_mutex);

--6efsakeupbonz54t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZsSqbQAKCRAt3Wney77B
ST1GAQCsv9s+89ljuCehK/n4LCnxRk0VovAdeMWcRkuAdIIARgD+OwZVgz4n2b/7
e3CxFhjqMrVZE9uw2MtWUmKquhWlSQ4=
=mv3Z
-----END PGP SIGNATURE-----

--6efsakeupbonz54t--

