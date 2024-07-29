Return-Path: <linux-kernel+bounces-266065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 247F693FA4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D106928379C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8915B57D;
	Mon, 29 Jul 2024 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pu4+Qchd"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF3E145B21
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269279; cv=none; b=J4zTDnpc9QnXaIw8mzABNDGzqhn1OD07ofsbKj5UwJgLB2LzJBkKyd5whgIZLJ+8cdwPMHoGCclwVhKl9xFvafZUzqN5EYQRWuqM4SD6gEUpdaATr3boHOnMjHtN0xoBVwGZlooB8gVN3/jel6xVAlCqa3e2ddbEMlJR62ZYoQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269279; c=relaxed/simple;
	bh=k4RkeOxzb+GR7BGPrjk1wBuirbtQCjQ7BPJxMh8+Qgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqagjI9Secevd+0OaTdT9iRPvddczb8Xsavn8qfiYgWaE/CUmvhPM92bW2pNmZ5rFJDUWB9XwFCSGDLfidaSoWDIYOvzKOGwqXYZusJxqusyttpy/mt5litY8TONgoGEJiOzNTFBz8elBP5hXMbyoLBPoIgfAm6rSdB6j6ukIXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pu4+Qchd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso16826885e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722269276; x=1722874076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VtXKBJemlfvoko1AHjQ7IvVY9ObPq2tHJhDbGIYEv58=;
        b=Pu4+QchdtRZZxqyoGQ70fQLXuPBgkrQ9dmNB5Jq/QMrqPOM767gi4t+RxDMfPK6dLQ
         mEHlIqduCaTqtCVEJuJdFh4giMZ/DvCabfMuQy+VwmAJUKLNSPKuJkl592TToTwRO+Ih
         E5DyTJi8RmYhE1eghXtpI8DMhDiuOt0U/CV62FUTg9+nvr/PhGfiBpWjezS4kxKMBmMI
         8jvvnn3klztskwU+B4trINFVw6FZkCKPjgtlC8T0epiXi1Zz0Gzpfx1pf0HUjm8yXI5H
         RvqvYKp5jAa1+yShf30EHcwhH4VtmY2yDtnlCLr6/hwdTe2kqQ63fxudw6DRHni+1Y9t
         yxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722269276; x=1722874076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtXKBJemlfvoko1AHjQ7IvVY9ObPq2tHJhDbGIYEv58=;
        b=UQMScEhCt9ejdrC/nrUAGJjhTXvQi8VTTaN4dCyJ7t8rBEFmO3Zjx+Zbw3Ap+fBTCY
         Km5slzdzkJwt55q6E/6BETWsTnqV3hKbs+8G6YVhshAgF5gWNCs8lecdeXdMlWQS7FQU
         TaaX9VtpZLDUA1P5cjnXtEbt4Z1kZAYt1cIkCBN6qIBENv8IqBa33wgNW5rA2a7cZOjm
         xHvZulphthLDqvtPWT68ddcbr70MPgc/+dfjDEdE8BrbtaLVyzRQ+Wjwc12zNluGaMkb
         CJXIyM4go2e78zyqViv/flB5DRedUMXxIuwiQ3jP+mMSEOENajjGqVO++cwm2zYYlddC
         svQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5UT+MspHzv8M5RMUPseYqx26NSt7B5zaP8Xvyb9qs8RBxEYOB9EZTR8UpfcyyTDv3vkUQqPSVczB23knshjE1vKpj3WR7R5LScWvU
X-Gm-Message-State: AOJu0YzVPz59R/hi/7ukN94f7P/Hgeb2i1VuYO/0cZYSJ3AnwF6m5q+Q
	XGKSbNcmyJP6ClBZXntdKNzlx3Nlh61GXZiVYDWwFfAeP3JLyeOkcNyJ+J5LRFw=
X-Google-Smtp-Source: AGHT+IE0dSrRgo2vLpqo5ORtHxP2oWta2E8Ee5cwWc9bufF33wsR8jqHsewDPHomhkEwyKRn6M/kGw==
X-Received: by 2002:a05:600c:3509:b0:426:6388:d59f with SMTP id 5b1f17b1804b1-42811d7fedbmr55183475e9.1.1722269275665;
        Mon, 29 Jul 2024 09:07:55 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574b21dsm182743915e9.27.2024.07.29.09.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:07:55 -0700 (PDT)
Date: Mon, 29 Jul 2024 18:07:53 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, xiujianfeng@huawei.com
Subject: Re: [PATCH -next] cgroup/pids: Avoid spurious event notification
Message-ID: <k2cfhjs33ch6dd2v3wzrs77dthcgavhaleinaxgt4oulaztekc@pikhtt5e52tc>
References: <20240729105824.3665753-1-xiujianfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="26r32t5wx4g3vw34"
Content-Disposition: inline
In-Reply-To: <20240729105824.3665753-1-xiujianfeng@huaweicloud.com>


--26r32t5wx4g3vw34
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Mon, Jul 29, 2024 at 10:58:24AM GMT, Xiu Jianfeng <xiujianfeng@huaweiclo=
ud.com> wrote:
> To address this issue, only the cgroups from 'pids_over_limit' to root
> will have their PIDCG_MAX counter increased and event notifications
> generated.
>=20

For completeness here

Fixes: 385a635cacfe0 ("cgroup/pids: Make event counters hierarchical")

> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/cgroup/pids.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)



> @@ -257,15 +256,11 @@ static void pids_event(struct pids_cgroup *pids_for=
king,
>  	    cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
>  		return;
> =20
> -	for (; parent_pids(p); p =3D parent_pids(p)) {
> -		if (p =3D=3D pids_over_limit) {
> -			limit =3D true;
> -			atomic64_inc(&p->events_local[PIDCG_MAX]);
> -			cgroup_file_notify(&p->events_local_file);
> -		}
> -		if (limit)
> -			atomic64_inc(&p->events[PIDCG_MAX]);
> +	atomic64_inc(&pids_over_limit->events_local[PIDCG_MAX]);
> +	cgroup_file_notify(&pids_over_limit->events_local_file);
> =20
> +	for (p =3D pids_over_limit; parent_pids(p); p =3D parent_pids(p)) {
> +		atomic64_inc(&p->events[PIDCG_MAX]);
>  		cgroup_file_notify(&p->events_file);
>  	}

When I look at it applied altogther, there's one extra notification
(heritage of forkfail events), it should be fixed with:

--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -251,10 +251,11 @@ static void pids_event(struct pids_cgroup *pids_forki=
ng,
                pr_cont_cgroup_path(p->css.cgroup);
                pr_cont("\n");
        }
-       cgroup_file_notify(&p->events_local_file);
        if (!cgroup_subsys_on_dfl(pids_cgrp_subsys) ||
-           cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
+           cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS) {
+               cgroup_file_notify(&p->events_local_file);
                return;
+       }
=20
        atomic64_inc(&pids_over_limit->events_local[PIDCG_MAX]);
        cgroup_file_notify(&pids_over_limit->events_local_file);

Besides that it makes sense to me.

Thanks,
Michal

--26r32t5wx4g3vw34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqe+TwAKCRAt3Wney77B
STUGAP42RFBRNmikbQI1SssqEizG6P8hyHl4L6eYZyW4XxUpiQEAs5yGaX4nybXi
BiyU2pyLmyiagg93SCI616vuDAgwZAE=
=Spo7
-----END PGP SIGNATURE-----

--26r32t5wx4g3vw34--

