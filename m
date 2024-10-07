Return-Path: <linux-kernel+bounces-352940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D36B992660
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F023285ABB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A74187342;
	Mon,  7 Oct 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MShz6Fyw"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B417BEC7
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287426; cv=none; b=cav5wIKb1ZcelinpsscfIas1QZXLm9Y7xFTwECrU+8EGTT6CP3ElyvoUkn3OYjXQ4A5Jox5ddJMXJAOFRB6ILTdwnBcdKuRQc9wKCBswDBI1k5bsCDqdweEyVYuqeN8bikMbGJat8db6O5v+8lgVJQ1AEptDgjGduNJHnd/vmbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287426; c=relaxed/simple;
	bh=pHCToeShx8LU5EUuCiczcpFVNibGwhcULMjDTy1y2VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5DlywFs+u6kdn/jKNdSREBDIok2Oh7MHBKrKt7kD1ufKvNzMibln8y3cXAKzC9bErEkAXu1KsANpZXXoq0st+O03lsMQ0AE+xOXWoCVqYUYCynW4YSL8oUX5/OkMJWcjsHyBNJ6uh/ev6bQoEsYYLrPlUfpD4FsUbXRdSCwzVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MShz6Fyw; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9939f20ca0so275929966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 00:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728287421; x=1728892221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLNNitcPXR/qt5149fWMZpiHstfJxjvPxWI+IfozKpU=;
        b=MShz6FywgT16lMq/wgu6YxiEC9q8A0hvbezRHb845YGsSoctVQK95iC3WHU9ukR0xC
         vOrV9ky1fZXrICyUXxTP64dmy4pMudX+tSsX3v7fgfDWh7wjppDO71gdMUBjNn5RBAqy
         Kv0K1Cre2o5AZn2/up/34W9IZfyW8P6sQvWm+npscfLwNbDZlXxpRrUnzwn85ePVMJOC
         WJs2LipI6fn8Jb45TkX7w/JUsQK390zOB2e15lOgNTCotLQwxXOe64P2qE92OVWT4VQh
         tVhefXj435Az1+2rQ63hT8iJNWVni8lUprEjrBPY+/Njwcrg2kjf/vbK8iLfFbNWWWyN
         zmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728287421; x=1728892221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLNNitcPXR/qt5149fWMZpiHstfJxjvPxWI+IfozKpU=;
        b=NBquohG8bN/T8Ev9yrTrLa+gmzCeyhpiIy9xDj+P95LsM+Q55ky5WMgt4qan/rOXYJ
         2h+mJ63ZmSmEAnvmlh4KvP8/4k8n5Sjp8H37I1VNojpYkbdTY2hjxJiJy4+luLjHKOiz
         ijDBAWDWezdbngDIJVqTwjmb0chbnuiWayZ5nq3rS2/w6sEBO5aD63rX2bpwB+TfuxxA
         KaJDuqFUnCVI6pJvHY7IGgDH7rNmfAbjONuwVNZeV8y3SRaDBZw6cYbgPK79Aw3ssjBD
         hmKYG472TOGLnkpwiBcpSCa+KnpdsKYxTOVMPssgzn1kHqGnGduA8jz4QwmHDb2JfkK0
         ZsUw==
X-Forwarded-Encrypted: i=1; AJvYcCU5u7pGTVLH/gA/W8P2ibwiDE0noMOy7hUDnHTqwngG4eNeFWyYvfhvRcwsfjJ9FIG6yFmHqFTXqQ3ULH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnkEjeEmerJQEvoTKNDDx32dfNsrsKE7IuVhQxwDRzF5eI8lDC
	fyb8PT/uVVN7yBxhO49ZujB9IfUXHkLpkZfLjoVtDTo7KKRABmD0QMX0T8Hmd34=
X-Google-Smtp-Source: AGHT+IEY2C2lMI0qScAd0qPkR9+MCTsbGKS/yNNtf8NdwQvOMy3ro0ca/ab1tcQAkKVRIWmMcg+k6Q==
X-Received: by 2002:a17:907:3e13:b0:a99:3ed0:58ad with SMTP id a640c23a62f3a-a993ed0b560mr691506366b.64.1728287421076;
        Mon, 07 Oct 2024 00:50:21 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a995668f4b6sm95636266b.48.2024.10.07.00.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 00:50:20 -0700 (PDT)
Date: Mon, 7 Oct 2024 09:50:19 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nicolas Pitre <npitre@baylibre.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Zheng Zucheng <zhengzucheng@huawei.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "sched/cputime: Fix mul_u64_u64_div_u64()
 precision for cputime"
Message-ID: <5j22peklzybliocy6lg3rx6a6qsvrij3kvnjs74djpqpufv4kx@ql2zrdtsor3i>
References: <n81qp943-q364-3143-7q84-05sp790on692@onlyvoer.pbz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xkedcshel5y3crvv"
Content-Disposition: inline
In-Reply-To: <n81qp943-q364-3143-7q84-05sp790on692@onlyvoer.pbz>


--xkedcshel5y3crvv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Oct 04, 2024 at 08:19:54PM -0400, Nicolas Pitre wrote:
> This reverts commit 77baa5bafcbe1b2a15ef9c37232c21279c95481c.
>=20
> After commit b29a62d87cc0 ("mul_u64_u64_div_u64: make it precise always")
> it is no longer necessary to have this workaround.
>=20
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> ---
>  kernel/sched/cputime.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 0bed0fa1ac..a5e00293ae 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -582,12 +582,6 @@ void cputime_adjust(struct task_cputime *curr, struc=
t prev_cputime *prev,
>  	}
> =20
>  	stime =3D mul_u64_u64_div_u64(stime, rtime, stime + utime);
> -	/*
> -	 * Because mul_u64_u64_div_u64() can approximate on some
> -	 * achitectures; enforce the constraint that: a*b/(b+c) <=3D a.
> -	 */
> -	if (unlikely(stime > rtime))
> -		stime =3D rtime;

I didn't look in detail, but even with mul_u64_u64_div_u64() being exact
now, stime > rtime can still be hit if stime + utime overflows. Can this
happen? (Can stime + utime become 0?)

The example from the commit log of 77baa5bafcbe ("sched/cputime: Fix
mul_u64_u64_div_u64() precision for cputime") however won't occur any
more. IMHO that is good enough to justify this patch.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Thanks for following up your improvement to mul_u64_u64_div_u64() with
this change.

Best regards
Uwe

--xkedcshel5y3crvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcDkrkACgkQj4D7WH0S
/k5tPwf8CBiNafNz9OSOjxKDImXMypL6e0fW36bh3CgkmRdMUuKcOoC59oR+pLY8
dqLr+YpVTqHCLEXZFecLoXpnhMKwN8eLl5VJca7UgORy/+wiKlt53c5Ie9nC6oNc
gPT9DwJM9/2wA6U9sbipIfAzf+3hhCNURGJSdYMtG2w+6ejJ+6H9zKVj2dAC6vsN
CljYfhOm1kwWTtsHb7EguqqQgbKK6PBqxLGB/A6baVsbnlNtESjrwat5PDUQ8McQ
CFUWQU2wT/nZsbKCoNUWz8cViq3QAdhrtOvp/IaDwG/Aht4j9c9IOmN3eflvHGkA
Y8CRcpdeZVGuZr63lRBfgD6YpM1G8g==
=xCic
-----END PGP SIGNATURE-----

--xkedcshel5y3crvv--

