Return-Path: <linux-kernel+bounces-321975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD83972247
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41E6BB2360D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5280189B81;
	Mon,  9 Sep 2024 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QzjylISA"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F3B134C4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908520; cv=none; b=N9fyRZIAxsWnYbI8kIXeUQPiq3rRhg4W64Aa7Fti+dpFLf+SohnhiOyXo5SEQR78HF9dIjuyf87T/2JVmsPPcJ7FNfFvhqeZaEncLchTvRX5UUSeCOPlQ0EBcTiAfmaTbBpzZ2OZUOT3KuVYN6mMoBekX2h6aEr+u1ubSLbzntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908520; c=relaxed/simple;
	bh=UUWKqD8lriEdS8wZdH79VyocGcpjNV/3c+Z1gw2ZAVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxNU13XqtaAz2Nzpw9ajTV4CjpPbAZyPDqB1SO6ALSmxKFaxZejHy6L4iXrFc0pbd5idwYODw+z7fudeteRZYFDGFHF+GzAxVcfh8euL5+mrPwRwhxd2qDi1a9pWEYuTkkldL5NQ2l5DIAh4nHyC9d8lDCgIgqFdXU73Gt0drMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QzjylISA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so40409055e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 12:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725908516; x=1726513316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwbNU2x4QPfAS3MGCVrGiN68ie1CP+a7m8Muz5lyEEE=;
        b=QzjylISAMb2tXtRPoxUBAC9WvG4gQJnVt4LAlEx2GIbONQ8NA2FktjvtNZoBf71Pm5
         xpWU1ppjU5lTzFvU78iyDtvgDAqiV0BmAa2dml0pcxiN9Ys/I/U9BnadNWNP7OHwE4Pg
         fjiP9YmGRpfQ3y2EJURuS5HvXnbhj8mYqyN2OczOQ0mQsTWKULMfVxJBBUzD7qWvplyg
         t0TkCaAvixxBS87pgEhIIvEvqIB8QOURCG0GgbxIlOqTEHxFnOcgehRXRfF+kYjmHmFM
         6wKsMrTAZvW5SJ2lES6pB4dou+8lQIZ/U4GIprL7g2vLI+rI1RKRjrTetpfWJakOpUml
         SWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725908516; x=1726513316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwbNU2x4QPfAS3MGCVrGiN68ie1CP+a7m8Muz5lyEEE=;
        b=cU5zQuDieOiDvJ3HilObEUk+9UYKHN+PNsTI4u1IPsocqZj+o5cB/9HSDn5Orph8YX
         uBvO4XgdIKF5s2rAv9faowekjxZopMcNDtj8UKHFS2U7jr/GMcc2+NSCXTAUXw/v3lzs
         10pZlc9fHylHCZKShak2S9SyuCR6zJgTxQYuSI3QlL4AhODPvumBlPD9X7lFlCDFH571
         pVRs/yHbht6nvPH19oGry9NVGLbk4EoFrByUsmlg235uYdGgQZXHOdIZewQArFTOndFa
         Po/r2v195D+pYcbHOCsU3U9+cRFNCMjLLCJd3bGrevosZEb9g0AhLYTE75xPGirXv0Sw
         CP0A==
X-Forwarded-Encrypted: i=1; AJvYcCUZC2nnXrL8GbExSzkR20zmHAtu85fFCcQZU79G1VLuXyzhdm+5MtmULbCcgzT4VV2UmYr8pz665oxY/Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkWwzamsR3nSFt/0/wsKPGwifJC60O3XgZxK4MFNtK+XUovuja
	W5AidTz/XjdgFz/nv8tspVGe4oxvsp9hnuagqFmy4VELgrOSdRT+/n96LipBr0Gn11gV4WHdeYQ
	m
X-Google-Smtp-Source: AGHT+IGicLwywVtqmrNHcKbpRNCT4u9ynzQ+I5hc7ApdqEpOBOxM4NumiNZt27caMDAfOs/lvK6IUA==
X-Received: by 2002:a05:600c:3b98:b0:42c:baf9:beed with SMTP id 5b1f17b1804b1-42cbaf9c1edmr16934255e9.27.1725908516429;
        Mon, 09 Sep 2024 12:01:56 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956650fdsm6740503f8f.25.2024.09.09.12.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 12:01:55 -0700 (PDT)
Date: Mon, 9 Sep 2024 21:01:54 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, adityakali@google.com, sergeh@kernel.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, chenridong@huaweicloud.com
Subject: Re: [PATCH v1 -next 1/3] cgroup/freezer: Reduce redundant traversal
 for cgroup_freeze
Message-ID: <quuw3s2y47l74ge54a43yjeaeoofqwg6ozofb3nwgvn55oj55p@o7bb5yrhvbj2>
References: <20240905134130.1176443-1-chenridong@huawei.com>
 <20240905134130.1176443-2-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="we2v5fu7yb44atvh"
Content-Disposition: inline
In-Reply-To: <20240905134130.1176443-2-chenridong@huawei.com>


--we2v5fu7yb44atvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2024 at 01:41:28PM GMT, Chen Ridong <chenridong@huawei.com>=
 wrote:
> Whether a cgroup is frozen is determined solely by whether it is set to
> to be frozen and whether its parent is frozen. Currently, when is cgroup
> is frozen or unfrozen, it iterates through the entire subtree to freeze
> or unfreeze its descentdants.=20

It's more to maintain the numeric freeze "layers".

> However, this is unesessary for a cgroup that does not change its
> effective frozen status.

True.

> +static inline void cgroup_update_efreeze(struct cgroup *cgrp)
> +{
> +	struct cgroup *parent =3D cgroup_parent(cgrp);
> +	bool p_e =3D false;
> +
> +	if (parent)
> +		p_e =3D parent->freezer.e_freeze;
> +
> +	cgrp->freezer.e_freeze =3D cgrp->freezer.freeze | p_e;

Better be || on bools

I'd open code this inside the loop of cgroup_freeze since it is not
context-less function and it relies on top-down processing.

Root cgrp cannot be frozen. You can bail out early in the beginning of
cgroup_freeze() (possibly with a WARN_ON) and then assume parent is
always valid when iterating.

I think maintaining the e_freeze in this "saturated arithmetic" form is
a sensible change.

Thanks,
Michal

--we2v5fu7yb44atvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZt9GHwAKCRAt3Wney77B
SZ9TAP43zQDtXIDM4IACasv4ofnkznamTnG5TI1ddulHOQngcQEAja7a8e506jo7
5UnApJEhT6UGFQbcm+uF+DZsfohhYg0=
=HzgX
-----END PGP SIGNATURE-----

--we2v5fu7yb44atvh--

