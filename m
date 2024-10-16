Return-Path: <linux-kernel+bounces-368094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB499A0B20
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C213F1F2657A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D84720A5E3;
	Wed, 16 Oct 2024 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BGY5mDIn"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499B20966C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084438; cv=none; b=EXDjqmaRkGNInkzv5LnzwLPvb1g18rtltWzlgnw2LjoHRtnsta6DBY+CxSHYY5nso4pyW4tcDy8NZk6vX7pgcONLdChhk/Ii2oyD0tv03oSVKGPEtpE114RqhMPQZ/1oiGSP2pR1AwM01xJyQOhWhBEMbgpkwCU2ePK+kh3o2+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084438; c=relaxed/simple;
	bh=sU0FRblfqUsUOvS/Y/y49d8/u2eSq0rWG1iA9ZZWaKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqVXmng10Q3XpA7dniRMFeqXRCI4ST6xm+OJhY2ifGB02rupTPl8x+mstsOb1EWf6wccMxW0zeRgY7/OF59+EiEtHTweQaAZVF7PIl784nNm3LRK30nBQnTH7eSuXOLHZloXkvfwdJCEyULUP1siKHwxRPycvRineHRlwsoOahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BGY5mDIn; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso46784141fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729084435; x=1729689235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gVPKV8oh8NL8rA1y3+Zs9M593wMBxqQzxgKf7Y9/E4E=;
        b=BGY5mDInXPbM0HsjBRYSWH91e/ZGkPQbu936Q3YZSGX+aOI+8MQHZyytXUMMKkq6xy
         NRUN9cDceYtCYzRRDr8pwgeqWR0dawXiCbsNt+Evqx5Gvrah8dH/BAJX0wnlLoeklcfc
         ozI6XNNLjFGJrPjMScA4161HwlUBPBqPdZdhylkQog/J/cUUUcLpnK0cZUifoaB3qcE+
         TUN6i06T4TA7+w2nSbki1KjLc3iiralvZh+7REmLmUdeC851QW7Y0jn4hOPYr0M1im9N
         q1+5IPE4TscDYwR2lE50n4y2UimoyFA6Kfqg+dLPVWRwIB9STK8wcVe1cYdx7lGQJo6u
         dnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729084435; x=1729689235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVPKV8oh8NL8rA1y3+Zs9M593wMBxqQzxgKf7Y9/E4E=;
        b=aG//6XWO1UDKDHiRaeh2cWxneoANPb8WudDVYZmzsk+Dc5RBE0UBBPYJNcIxVx9lIb
         DEcGSpj8D1p4QFikLsAUGRqhyxDv7HFxda3KhtYq2sbu61ol0ZD3ZwzDmrJu5dI1eIjM
         AJvEIRBWs5hVdJm2v7CviJzOzl4q7Ou4ShcV4ZnDp96i5i+rRJlWD0hG0sIgzNyIDpoV
         R9DWrjETVwts0GF//ixE3DIADKtUTNNklhghZUdl/g6LcGguXZCqZXY5vXdl3i6cCUOl
         NeuspBIxEg7uaTKAEA3vpegI8Dr8QoSNXy7RRvCPO/cNKqpzVt+xer5YwzawD3itEAOv
         vprA==
X-Forwarded-Encrypted: i=1; AJvYcCURYn5bomJcNS0vablIGPlTXZGHS/tXkW40Bca84xWMVFgd7LnlRpRuyOe2NeBTbTG7O3SKMHikmNzV3r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKH44/6xwQxtElPWUUVaWHrsJXkoArrjuHQIo4bZLG4++VxjO1
	TtnqOlcxB6wQS4xKmDwdEke8SirhhU+7PnkD8whnEI96jLxa1UVoaoCw34tLpIE=
X-Google-Smtp-Source: AGHT+IF1xMsqL8WkEqIB+t+mnOZrdgkjPSr/XVHzMRIarc20R7tCDQNiDtbG0a469pOFE7463jwcTA==
X-Received: by 2002:a2e:a7c1:0:b0:2fa:d604:e522 with SMTP id 38308e7fff4ca-2fb3f025dd3mr99315381fa.0.1729084434976;
        Wed, 16 Oct 2024 06:13:54 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29823d5esm181756166b.113.2024.10.16.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 06:13:54 -0700 (PDT)
Date: Wed, 16 Oct 2024 15:13:52 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, john.fastabend@gmail.com, roman.gushchin@linux.dev, 
	quanyang.wang@windriver.com, ast@kernel.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com
Subject: Re: [PATCH] cgroup/bpf: fix NULL pointer dereference at
 cgroup_bpf_offline
Message-ID: <bidpqhgxflkaj6wzhkqj5fqoc2zumf3vcyidspz4mqm4erq3bu@r4mzs45sbe7g>
References: <20241016093633.670555-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ovto642kgmehv6ht"
Content-Disposition: inline
In-Reply-To: <20241016093633.670555-1-chenridong@huaweicloud.com>


--ovto642kgmehv6ht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Wed, Oct 16, 2024 at 09:36:33AM GMT, Chen Ridong <chenridong@huaweicloud=
=2Ecom> wrote:
> As mentioned above, when cgroup_bpf_inherit returns an error in
> cgroup_setup_root, cgrp->bpf.refcnt has been exited. If cgrp->bpf.refcnt =
is
> killed again in the cgroup_kill_sb function, the data of cgrp->bpf.refcnt
> may have become NULL, leading to NULL pointer dereference.
>=20
> To fix this issue, goto err when cgroup_bpf_inherit returns an error.
> Additionally, if cgroup_bpf_inherit returns an error after rebinding
> subsystems, the root_cgrp->self.refcnt is exited, which leads to
> cgroup1_root_to_use return 1 (restart) when subsystems is  mounted next.
> This is due to a failure trying to get the refcnt(the root is root_cgrp,
> without rebinding back to cgrp_dfl_root). So move the call to
> cgroup_bpf_inherit above rebind_subsystems in the cgroup_setup_root.
>=20
> Fixes: 04f8ef5643bc ("cgroup: Fix memory leak caused by missing cgroup_bp=
f_offline")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Hm, I always thought that BPF progs can only be attached to the default
hierarchy (cgroup_bpf_prog_attach/cgroup_get_from_fd should prevent
that).

Thus I wonder whether cgroup_bpf_inherit (which is more like
cgroup_bpf_init in this case) needs to be called no v1 roots at all (and
with such a change, 04f8ef5643bc could be effectively reverted too).

Or can bpf data be used on v1 hierarchies somehow?

Thanks,
Michal

--ovto642kgmehv6ht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZw+8DQAKCRAt3Wney77B
SbJJAQCaNZ288n0DROz5DP9BCs9ko+3s0L0ZEdHjKLk1YJcBxQD/SY7kuuBtca+q
D9LXKlm2Bn64muAIPzhmd/wxtz13CwM=
=Bvgi
-----END PGP SIGNATURE-----

--ovto642kgmehv6ht--

