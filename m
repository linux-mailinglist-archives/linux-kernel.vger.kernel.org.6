Return-Path: <linux-kernel+bounces-546947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD860A5010E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193C6172D6A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51C3248898;
	Wed,  5 Mar 2025 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBbA/7rn"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011BC2ED
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182365; cv=none; b=rzTO+AnKQ4wDnIiRqKSpLAFNVbHkSX4XseKFBBG45m6JbEeZgbGUAMEENtb/mq7hUddbLtaS37nZt3vP8QA0BP284KWK6ix0JNQJKp8BO+AkiMs/eOBvTl3ixfsN8h2PahSa4iUxasnQUrs3qH09FRCQLLRg7EWrRB0ofuZoWZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182365; c=relaxed/simple;
	bh=AtZlKIX5S9UAP4j0Axku2V8szde/1juxC0noCroYU6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbue0Qx/4Jx5bLikZjNRnHiKWn2Pvf0oRnBMHq67YQoJw6xfZvA/Nx8J6OXHeNeeLu3cOgb9uKwIT55osx2OA5y2BSwjsATfieG7m0fNoYT4kaMpKB2gRkR1w2IhgOhju70PfRPoPhK7w0bnsbGkenNFOpnQ571j+L73b6MK3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBbA/7rn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223cc017ef5so49658365ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741182363; x=1741787163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/px/S3IqWhEUcWqSxL2Jl4SMrtR12fYNolH67/5Znm8=;
        b=dBbA/7rnmqc+4z6waZ0wPDxR/+lDrJnFINxbgptiq9YZJ8APFTVNJ7VSUuDnpu8acC
         2QiuszrLf1JvGkr+v4wnmuX+R1HCe9fDYGNQqI9JHOguk1N8FIA/Msvt+qHULDyeqGvl
         m8JvKdR81XfVbBMlEIWB2zOj8MagIFGr2VegTPc7Nc8Dqx8U7woTOqFCht39IuVZibce
         4gYqGhXUPV1n1GGiYUQRKE6iZsJFgQk4WsU8TLX9YdCf3nweHsQZclPUXN5vP9cMyvct
         0DGmHmD9j2MJ192L9asa6YLzBijVjRJv3/IyB7yUvvqbI4FUP9IW/LSkDtnus6IE7BKc
         WTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741182363; x=1741787163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/px/S3IqWhEUcWqSxL2Jl4SMrtR12fYNolH67/5Znm8=;
        b=keONvRwC3NKUD3IyV8RIk/HafjtCUQmaDJWAI64Drl/44CpxmNGKgGOwXCfD8aBxWX
         +EBlqvSXBg/LOI64mF+6eH/DRdahkjjRADo9Hspq6hF2Q3T+ctrOhRbctOtLIdHXN1DP
         /QOagIdJ6jJq3I6EB+UYJKoHVE3wo1qeeuq1GoO8oU2iMdHNjiLvpRLIIDvNDYvkYboN
         GCNYoAZU4ZuDo7xnoqLbaPKvR7B/Mz9pzwP0C3YZ14U4unjdAbM3wcDJxrS1OkfP0DPA
         OGm09USd8wPEC+IhyUueHpqqT3iWs6mHfmak4FZxLZDvSKljzKsIf8YYQ4/wtpTbAtqx
         ZjAw==
X-Forwarded-Encrypted: i=1; AJvYcCUU5wu1ttHgd8qsnTT7UmFgbiwO1GvEbGCN0znWQ7mbD4zB1IkDIQPSafj5GDBON52Qp24wZsDi9XJ/Jts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya2SrthyZemNi2wT8cMqGufbgmc68IGjsLSRE0KC5NZ8/28CZe
	GZmoVI1Br7Aoc0o0rOUo41GvR+Lel7XBKSDex1C80/KQzevCwMX1
X-Gm-Gg: ASbGnctvv7yEmap4pHgMyrPwVtivo47RkSEpGE4jrHG+H5Tc2OByY8KKSyB0AnvKyHu
	ODruLJ3Xe57Uxajy4C3+K+1LRSDquPYJ15Y7xghpf0+q2frhhqovJj7NCq5y2tQylasbdcL2/ou
	NchauCpS7wF4vg2pONizYdt8ExKapoJbwgZrNC/tLFOgMgZAp1ECsj7iMNal5VRGdzcW9yhkIz8
	M/EzP/gNmg5dgVCFzxKDw78hqfPBvGt2nJEPO24u41QV7xZuRXacGQrYIetgUCChfKn/cVA986R
	p00q5QOdSh90mU1CzZjGuSYNbfx3OJw26kU8nWp8SZJV
X-Google-Smtp-Source: AGHT+IGYSUjtH3sedYuRr0u5NHMtfZcmcEghWFQ4LPcIqufsg11z0toJ1auh2reLKGU+Shpwkqnd/w==
X-Received: by 2002:a05:6a20:6a0a:b0:1ee:ad21:e692 with SMTP id adf61e73a8af0-1f34951be84mr7283636637.32.1741182362949;
        Wed, 05 Mar 2025 05:46:02 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af021fb1581sm9620914a12.36.2025.03.05.05.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:46:01 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 0546E451AB7A; Wed, 05 Mar 2025 20:45:57 +0700 (WIB)
Date: Wed, 5 Mar 2025 20:45:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Philipp Stanner <phasta@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] drm/sched: Adjust outdated docu for run_job()
Message-ID: <Z8hVlc0AgQkNqSGL@archie.me>
References: <20250305130551.136682-2-phasta@kernel.org>
 <20250305130551.136682-3-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BAmTh8OS1ScbKhPJ"
Content-Disposition: inline
In-Reply-To: <20250305130551.136682-3-phasta@kernel.org>


--BAmTh8OS1ScbKhPJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 02:05:50PM +0100, Philipp Stanner wrote:
>  	/**
> -         * @run_job: Called to execute the job once all of the dependenc=
ies
> -         * have been resolved.  This may be called multiple times, if
> -	 * timedout_job() has happened and drm_sched_job_recovery()
> -	 * decides to try it again.
> +	 * @run_job: Called to execute the job once all of the dependencies
> +	 * have been resolved.
> +	 *
> +	 * @sched_job: the job to run
> +	 *
> +	 * The deprecated drm_sched_resubmit_jobs() (called by &struct
> +	 * drm_sched_backend_ops.timedout_job) can invoke this again with the
> +	 * same parameters. Using this is discouraged because it violates
> +	 * dma_fence rules, notably dma_fence_init() has to be called on
> +	 * already initialized fences for a second time. Moreover, this is
> +	 * dangerous because attempts to allocate memory might deadlock with
> +	 * memory management code waiting for the reset to complete.
> +	 *
> +	 * TODO: Document what drivers should do / use instead.

No replacement? Or bespoke/roll-your-own functionality as a must?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--BAmTh8OS1ScbKhPJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ8hViwAKCRD2uYlJVVFO
o/7CAP9JYkL53h8JRbqf79JQDnecBuTAl51o0C19e9U8AzZdGQD+O21VSfvdkdU4
9Ai00GB7ztnSU4Rg80+OXXOZhFux2Qo=
=F7NO
-----END PGP SIGNATURE-----

--BAmTh8OS1ScbKhPJ--

