Return-Path: <linux-kernel+bounces-309291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C1896689B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA747285561
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCCA1BC09A;
	Fri, 30 Aug 2024 18:01:49 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994021BAEFB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040909; cv=none; b=KYgMCPZjIzIFLNs9Layo5wuBGAVnvWvDtYMT6m0R7NR8l9LGZ3QxdG6o/C/fqeaqag63LQXooQxLLBMdxTDV5PK3IKBJy2342bds+OZ0r0VXfsjSWy7muzCd9rxYUiP/0cEeI28HQRqcGZ9mf7MyfpMP4uVmo4g3L/EU44mqaxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040909; c=relaxed/simple;
	bh=Wkn0NEovL5pCoQtw6/Lg6viGcF8IybsMpWYEL2WoUK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjnSP4Z9slsb2Fa9RDHyu+L53Ga+C0Gu7OCBHIv00kJBa1V06NSHY4yKwDtfIN2WXSyHVGTpiR1hza+t2v26wWfbLhqEkuJCD09LdSetfMyHgO6bzqJDqdceaR+cE0f+eZLa5GjaTc3u3WKaO9a+UCHz7hAzlP2iVh7G17ueAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c331543ef0so11763646d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725040906; x=1725645706;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wkn0NEovL5pCoQtw6/Lg6viGcF8IybsMpWYEL2WoUK0=;
        b=CZ/uQrAvQPVe5LeChb5dhQMOee5JtRlFQlhU6aRRxRMHWg4rKD8FkmPKWQZyigFGqN
         NSPkBd0fkNyXfXoflVtspBDD8FBog8WO6mlphUXtfss6Qzw4AO3WwIQps9vnObqlB+S0
         X51LwU7IjCV1Zu34n+vx1HvhcL4MsS61bQ+pyjuCydAGa6w0vAhN6DnznxwKEUFhID23
         T8v/2SelZh+On3SHhknbwwjOWzY86cKNuZevL00BiVvlXRTmmhHrUumwCF1w/BB0vSs7
         tykTwrgssHPSbRR2IdDMLLHhy+7vzs8M+EEJHA2Rfo6sTBMSJvx4sssdh4xsn0mFrVFZ
         39vw==
X-Gm-Message-State: AOJu0YzEcNGcKkrNpDgZKWLwcDU8ei6N/G0ychVTOF97sCJIKFypRDoR
	bj6YBazi7EW+7OvMyWRMu/3Ub+wXAocMfwnoQd8mQjqY/kEZNYu0
X-Google-Smtp-Source: AGHT+IGi8PtFIdGpLbtbMSqPQ5nsIzNW3hmafcEJy3zWtjxNxMjT3PYH8lHOx/IGULdUFR1lo94v9Q==
X-Received: by 2002:a05:6214:4a01:b0:6bd:70ce:e413 with SMTP id 6a1803df08f44-6c35540cd90mr3362506d6.30.1725040906276;
        Fri, 30 Aug 2024 11:01:46 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340bff5bfsm16727946d6.36.2024.08.30.11.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 11:01:45 -0700 (PDT)
Date: Fri, 30 Aug 2024 13:01:43 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/2 sched_ext/for-6.12] sched_ext: Use
 sched_clock_cpu() instead of rq_clock_task() in touch_core_sched()
Message-ID: <20240830180143.GF5055@maniforge>
References: <ZtGkPKgoE5BeI7fN@slm.duckdns.org>
 <ZtGkgCEkgNLzjxUC@slm.duckdns.org>
 <ZtIHYe4DgGlu8k1n@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NNswZFIh3UIH4OeF"
Content-Disposition: inline
In-Reply-To: <ZtIHYe4DgGlu8k1n@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--NNswZFIh3UIH4OeF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 07:54:41AM -1000, Tejun Heo wrote:
> Since 3cf78c5d01d6 ("sched_ext: Unpin and repin rq lock from
> balance_scx()"), sched_ext's balance path terminates rq_pin in the outerm=
ost
> function. This is simpler and in line with what other balance functions a=
re
> doing but it loses control over rq->clock_update_flags which makes
> assert_clock_udpated() trigger if other CPUs pins the rq lock.
>=20
> The only place this matters is touch_core_sched() which uses the timestamp
> to order tasks from sibling rq's. Switch to sched_clock_cpu(). Later, it =
may
> be better to use per-core dispatch sequence number.
>=20
> v2: Use sched_clock_cpu() instead of ktime_get_ns() per David.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: 3cf78c5d01d6 ("sched_ext: Unpin and repin rq lock from balance_scx=
()")
> Cc: David Vernet <void@manifault.com>
> Cc: Peter Zijlstra <peterz@infradead.org>

Acked-by: David Vernet <void@manifault.com>

--NNswZFIh3UIH4OeF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZtIJBwAKCRBZ5LhpZcTz
ZIYJAQCdYxgMELf+q/vFrKrBoEn9X0lxej0CT2EuGACsCXd8VwEAkA624PfK1nuV
tZZx1/ohkQFEtv8U54R6wne2YCvjngw=
=poOo
-----END PGP SIGNATURE-----

--NNswZFIh3UIH4OeF--

