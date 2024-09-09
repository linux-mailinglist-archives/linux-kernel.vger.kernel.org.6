Return-Path: <linux-kernel+bounces-321976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFD9972248
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D391F245A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FC7188CC8;
	Mon,  9 Sep 2024 19:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g//e2Qcl"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56365134C4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908529; cv=none; b=hHUr/f52N9ci8+Qxg52KJQd3OsW6reFIUv+hKG5HZXvJc3PhdCIIKW//E+Rq0b9xV9NFTIkkNgwNJ0u8YrnWABvzvsaJVzxfT5nEUDtBNvHPIFpBovb7EM2WVNlbjK6NjmuM/uqrv0bgqZe5LaMZvvX253veJuqkM9h4HxY503o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908529; c=relaxed/simple;
	bh=K+b9jT80AE3ZZFuhBz6OwUugXPtt5oA3UnH9Ij0SzHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF7WKU14BQcG8syOhWONfIaG7ITOxKd2/1GT9bi8HjwN4C42tTZWHWmgzVJfozUqe7JCViW5/I3leb3mhujimPwB75ww1cKxli6QNCDhfPtnf3+yMvoLwyG30uNe1KZ1m6akbQkezmEb18/b7ybXY3Q/whwOWZW0xn487c2erQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g//e2Qcl; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c84dcc90so2767488f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 12:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725908526; x=1726513326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nCpdn2WB7mYuksujzPxN2x+vUaM5ZhTRbDlkyi39eFo=;
        b=g//e2Qclquty1Da52lXw7Glho/BENO+amRVOeX72E7cKBh6HJZGVILTASwXQFNiRTl
         wfcN1EIxTC9AP0QmeBk8klJsDidGZdN1GlXSqedYIcmvmC9nDNrYX6ttYcFQGEKREd3i
         pnSvYoH40BMfvTNv4H0qVaTIcFS3O3EZuHYG0Bplnktu/lzoexivIvDPJbse3Zor/bzS
         e21fVBtkRa6bNo0ly8sgnb+sZ0ZQAyWEUO5SMcoVs8wFjc964v27eo9k0hEkulYZ8mXb
         6dNgAkeJ+xdLgjU9EBX1O2ZiCgqG9X4W8sQEHRbuWvP5Qr7rJ83qliTDx/GfqvTWVzx0
         zmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725908526; x=1726513326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCpdn2WB7mYuksujzPxN2x+vUaM5ZhTRbDlkyi39eFo=;
        b=fOlO9NKymGyiHjN9LkQh+WCJ6y+N8uh1pybA1FOo7J7VV4kJA+j89rz4ewQH3c/pIu
         HiTfkSb8S4olgtOz5EoE30veXF0+sIIhnbpZGclBA56+H8C6OW+C0ivIstWZGwyHjZHu
         i+t9cH7N1KVu0ehZmVeclM267ioV0mVgAGS2jvF74VwM1+8hI04HGvNDKpjCt33f8f+/
         RD2Sg6mAlK9TnSFHYNYWqLzWfgNO2/wNaUHFglm7jsGolG2wUUg4puDx/TbT1ZGmPB3t
         UKP3dnh6Zh7CBrzz2pJdSpFzZbdaYAu67eFROuslKFHRMMZ+FoY0fRee43IovehQmmmm
         zLBg==
X-Forwarded-Encrypted: i=1; AJvYcCX1Cj59mUVE44092eaIiXRXLldh40vgozOtznFi1Zg9qnR51KTfIroov/jnL4K4hAJanRFFJSDg6AYNg8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYdypR6CokxFDF6ICl6/pPVrGpxdO2f1d/7FcCRJ5ZAoOcNh7L
	IZlgj0P/xV2FANfflcDybcEF/QDmRTbqcWBuwd+WW5tG/VCUFmQPEQHXWWcS+g8=
X-Google-Smtp-Source: AGHT+IGqZGplm8DYsG2Nlu3l0FzjmhLOC9JeDjStUeBx76+FbJZhqMBoUsmjyzT6wer2ytlSkb403w==
X-Received: by 2002:a5d:4750:0:b0:374:b960:f847 with SMTP id ffacd0b85a97d-378896740e1mr7836748f8f.41.1725908525636;
        Mon, 09 Sep 2024 12:02:05 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956653d1sm6693152f8f.33.2024.09.09.12.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 12:02:05 -0700 (PDT)
Date: Mon, 9 Sep 2024 21:02:03 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, adityakali@google.com, sergeh@kernel.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, chenridong@huaweicloud.com
Subject: Re: [PATCH v1 -next 2/3] cgroup/freezer: Reduce redundant
 propagation for cgroup_propagate_frozen
Message-ID: <cieafhuvoj4xby634ezy244j4fi555aytp65cqefw3floxejjj@gn7kcaetqwlj>
References: <20240905134130.1176443-1-chenridong@huawei.com>
 <20240905134130.1176443-3-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dvabnlli3r2xnuyk"
Content-Disposition: inline
In-Reply-To: <20240905134130.1176443-3-chenridong@huawei.com>


--dvabnlli3r2xnuyk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2024 at 01:41:29PM GMT, Chen Ridong <chenridong@huawei.com>=
 wrote:
> When a cgroup is frozen/unfrozen, it will always propagate down to up.
                                                             bottom up

> However it is unnecessary to propagate to the top every time. This patch
> aims to reduce redundant propagation for cgroup_propagate_frozen.
>=20
> For example, subtree like:
> 	a
> 	|
> 	b
>       / | \
>      c  d  e
> If c is frozen, and d and e are not frozen now, it doesn't have to
> propagate to a; Only when c, d and e are all frozen, b and a could be set
> to frozen. Therefore, if nr_frozen_descendants is not equal to
> nr_descendants, just stop propagate. If a descendant is frozen, the
> parent's nr_frozen_descendants add child->nr_descendants + 1. This can
> reduce redundant propagation.

So, IIUC, this saves the updates by aggregating updates of
nr_frozen_descendants into chunks sized same like each child's
nr_descendants, otherwise there's no effect to propagate upward,
correct?

This would deserve some update of the
cgroup_freezer_state.nr_frozen_descendants comment.

>=20
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/cgroup/freezer.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>=20
> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
> index 02af6c1fa957..e4bcc41b6a30 100644
> --- a/kernel/cgroup/freezer.c
> +++ b/kernel/cgroup/freezer.c
> @@ -13,7 +13,7 @@
>   */
>  static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
>  {
> -	int desc =3D 1;
> +	struct cgroup *child =3D cgrp;
> =20
>  	/*
>  	 * If the new state is frozen, some freezing ancestor cgroups may change
> @@ -23,23 +23,38 @@ static void cgroup_propagate_frozen(struct cgroup *cg=
rp, bool frozen)
>  	 */
>  	while ((cgrp =3D cgroup_parent(cgrp))) {
>  		if (frozen) {
> -			cgrp->freezer.nr_frozen_descendants +=3D desc;
> +			/*
> +			 * A cgroup is frozen, parent nr frozen descendants should add
> +			 * nr cgroups of the entire subtree , including child itself.
> +			 */
> +			cgrp->freezer.nr_frozen_descendants +=3D child->nr_descendants + 1;

Shouldn't this be
			cgrp->freezer.nr_frozen_descendants +=3D child->nr_frozen_descendants + =
1;
?

> +
> +			/*
> +			 * If there is other descendant is not frozen,
> +			 * cgrp and its parent couldn't be frozen, just break
> +			 */
> +			if (cgrp->freezer.nr_frozen_descendants !=3D
> +			    cgrp->nr_descendants)
> +				break;

Parent's (and ancestral) nr_frozen_descendants would be out of date.
This should be correct also wrt cgroup creation and removal.

> +
> +			child =3D cgrp;

This is same in both branches, so it can be taken outside (maybe even
replace while() with for() if it's cleaner.)

>  			if (!test_bit(CGRP_FROZEN, &cgrp->flags) &&
> -			    test_bit(CGRP_FREEZE, &cgrp->flags) &&
> -			    cgrp->freezer.nr_frozen_descendants =3D=3D
> -			    cgrp->nr_descendants) {
> +			    test_bit(CGRP_FREEZE, &cgrp->flags)) {
>  				set_bit(CGRP_FROZEN, &cgrp->flags);
>  				cgroup_file_notify(&cgrp->events_file);
>  				TRACE_CGROUP_PATH(notify_frozen, cgrp, 1);
> -				desc++;
>  			}
>  		} else {
> -			cgrp->freezer.nr_frozen_descendants -=3D desc;
> +			cgrp->freezer.nr_frozen_descendants -=3D (child->nr_descendants + 1);

nit:                                here you add parentheses but not in the=
 frozen branch

> +
> +			child =3D cgrp;
>  			if (test_bit(CGRP_FROZEN, &cgrp->flags)) {
>  				clear_bit(CGRP_FROZEN, &cgrp->flags);
>  				cgroup_file_notify(&cgrp->events_file);
>  				TRACE_CGROUP_PATH(notify_frozen, cgrp, 0);
> -				desc++;
> +			} else {
> +				/* If parent is unfrozen, don't have to propagate more */
> +				break;
>  			}
>  		}
>  	}

I understand the idea roughly. The code in cgroup_propagate_frozen was
(and stays after your change) slightly difficult to read smoothly but I
think if it can be changed, the reduced (tree) iteration may end up
correct.


Thanks,
Michal

--dvabnlli3r2xnuyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZt9GKQAKCRAt3Wney77B
SXD8AP9sc2g2/HbZgTngb1JqvJRjsGlhw0QMfCbzhi2jukoiVwD/STPACF66xfTD
itnY3mp8zJrJ/kYSxZei+1hlz92o7AQ=
=r1Ms
-----END PGP SIGNATURE-----

--dvabnlli3r2xnuyk--

