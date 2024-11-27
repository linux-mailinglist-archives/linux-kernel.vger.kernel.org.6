Return-Path: <linux-kernel+bounces-423353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE49DA639
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0020281C57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DDE1D8E1E;
	Wed, 27 Nov 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c3DMGxYb"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E71D8A04
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732704950; cv=none; b=Oowvszvc1jJkStJZ+mieXzhRt99j7DqNU2JhCLrAbZtDWqDLu+y0KdxbQm2MXTlcZHEnDEZFmXfThW3dYlQIKeO/0geqVICjQb4J6VA7DFfNpFo0egr2N3W1BxSoUXUkfTR9wX/IUjm8XxXsaIrLmmbnEG8A+8bvtnUOugSGk5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732704950; c=relaxed/simple;
	bh=StRdtYLjTLbRRLN5IYAiQXRAx3bgi5kqO2DGz3LmT5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALi3PTRC7KOnv0cT7btECs40gkb92Kvkh5vtcfYVdXpGrvqWGpb03HzekNF/dRZKxwUEc7hIM6QRAWQMCBCMuoPlXgwqViGGOJIabqhiz7b3YcY9ZyQQY/GMasUEHoo2BXpL0PCshcs8P2SAg45yhvdg1Dv2BGLolFhJzQb+/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c3DMGxYb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3824a089b2cso4011340f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732704945; x=1733309745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vGg1t+MHfq+TOXFYBOSdg5vRyNMFhDabs2gZbtPSKc0=;
        b=c3DMGxYbXEtUiPx34tWrRlv6XBrS3Q/oUF+tQQWdq6h3CqeIwGv3e4qleF9mXXSyE+
         Wi/99Wb8dqJF4kX11tauzUK+VfppEzbRqMJ7Gc/+4O2Q10LThIKCGTDFCeOLDJKsiYp8
         9nQL6ISLtJwHNlh2pLUo1x5HyZln6kXAWMwWH5qOkvhLTZkPKLU/AxLZXlkYGLOM9ilx
         UFG7VeJ58kLsA8cbAYrezger9wRtzUge8ltmFfC8uOGadXz9bvoC1gqkIaW+AVf4npgA
         iDh1hVm4fke9V/9IhEp7Uxw0+C6cvifI3Ouqz/FMvt2qxgSQsXsNMeEMdHDZALBZPtvw
         Umkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732704945; x=1733309745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGg1t+MHfq+TOXFYBOSdg5vRyNMFhDabs2gZbtPSKc0=;
        b=Wdaft4U2WwiIroboWvFmGo472Q2URrMwJmyw3Y2Q3Jgo2FLS713O7I6I9e9yxrSjkp
         4VguArnYjNUfE6eBGVRCMST/ImQ7+b3NmgDw7h7n3FfuS5tBvI4wbzWZjvyFszYSCJ11
         xKZUKiKovDjhsYXK/cwBEaWSC9TTj2d+VjSkyJz7y7nAFiJdflNGwgENE5jqp3I4K95Y
         X14jFdbNrvN3NsULrXRuDcZPWuHCTurFe0JJy9iUtqG6PT7+Q9TxtyUhYBJPSkpcXdZj
         lZ5KLkloZefo15H3N7HI7wR1IDoRWFCIlIyzJ4U30G1aMMvj9pwHuuliFS1iyyngyiVr
         x4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCX7mFG1lSp1P+ZQMdqdqLhrtMbogNU4+wicrP9G5zZwNQYvRyiGLhawtf+3EG5Mdap/NQQ7OSufND4MM80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUb8zuy5QUNRgAB9dEmQ5xy4gMHdXm6E6IWfDox2fCvJNqUjib
	HeMaZsvNC4ZyT9vi8XRbhj4gIZyru0DuKHVRVe8kSFLvgtaf/BgmfL5ghOWcfVk=
X-Gm-Gg: ASbGnctD6Yj7FG0ZD1CBhg+a3iXozjVPPV2Wvt5jAE+meq/kSO4dPuZ5Rcm3dNG8Qkw
	j8gbMpdYkcEJRRM9kTrBa65iEgtGYU7tp8rHqXuqEyLHNfT2M6t52qpwLmMq5Wn2hW2qVoLEB7p
	5t8cEILEpGX33Z1Ox2qcbJkXSyT8p0S1g0X57Y/napnIyAMU/HMywe/9XgTMBHvcy4Jy6bGXXwI
	KU98mB9xhn81+35R80KEcjkbIJV7xf6zz9vVuZBytyR+6xlAyH5
X-Google-Smtp-Source: AGHT+IGzaBlx7gU7W4UvWiy8tri1sKUBH+jBIdcN5SkamPRFLcFqsHNWehuPcEbDZu6qWTRM7NcTOw==
X-Received: by 2002:a05:6000:400f:b0:37d:446a:4142 with SMTP id ffacd0b85a97d-385c6ebe456mr1905227f8f.32.1732704945541;
        Wed, 27 Nov 2024 02:55:45 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7cd7f2sm17458345e9.24.2024.11.27.02.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:55:45 -0800 (PST)
Date: Wed, 27 Nov 2024 11:55:43 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>, 
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, Thomas Gleixner <tglx@linutronix.de>, 
	Joel Fernandes <joel@joelfernandes.org>, Vineeth Pillai <vineeth@bitbyteword.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>, 
	Suleiman Souhlal <suleiman@google.com>, Youssef Esmat <youssefesmat@google.com>
Subject: Re: [PATCH V7 9/9] sched/rt: Remove default bandwidth control
Message-ID: <d3bllrfwji74t3ix3jcdlvdt6jdorw75wjol6kmadpeuuqal2t@io7ghgf7zkbs>
References: <cover.1716811043.git.bristot@kernel.org>
 <14d562db55df5c3c780d91940743acb166895ef7.1716811044.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ujwtmacpuig457lw"
Content-Disposition: inline
In-Reply-To: <14d562db55df5c3c780d91940743acb166895ef7.1716811044.git.bristot@kernel.org>


--ujwtmacpuig457lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

(I'm replying now as I installed v6.12 and this message has the
context.)

On Mon, May 27, 2024 at 02:06:55PM GMT, Daniel Bristot de Oliveira <bristot=
@kernel.org> wrote:
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0dbb42cf7fe6..7df8179bfa08 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1554,6 +1554,7 @@ static void update_curr_dl_se(struct rq *rq, struct=
 sched_dl_entity *dl_se, s64
>  	if (dl_se =3D=3D &rq->fair_server)
>  		return;
> =20
> +#ifdef CONFIG_RT_GROUP_SCHED
>  	/*
>  	 * Because -- for now -- we share the rt bandwidth, we need to
>  	 * account our runtime there too, otherwise actual rt tasks
> @@ -1578,6 +1579,7 @@ static void update_curr_dl_se(struct rq *rq, struct=
 sched_dl_entity *dl_se, s64
>  			rt_rq->rt_time +=3D delta_exec;
>  		raw_spin_unlock(&rt_rq->rt_runtime_lock);
>  	}
> +#endif
>  }
> =20
>  /*
> @@ -1632,8 +1634,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
>  	 * this before getting generic.
>  	 */
>  	if (!dl_server(dl_se)) {
> -		/* Disabled */
> -		u64 runtime =3D 0;
> +		u64 runtime =3D  50 * NSEC_PER_MSEC;
>  		u64 period =3D 1000 * NSEC_PER_MSEC;
> =20
>  		dl_server_apply_params(dl_se, runtime, period, 1);

The global_rt_runtime() also applies to deadline class when CPU's DL
bandwidth is init'd in init_dl_rq_bw_ratio().

The default DL bandwidth is thus is 95%. The fair server is given 5%.
Is that 5% of those 95%?

Or is it meant to be complementary? (Perhaps not as I can configure
rt_runtime_us/rt_period_us > 95% without an error. But then I don't
understand what the global rt_runtime_us (w/out CONFIG_RT_GROUP_SCHED)
configures.)

Thanks for some hints,
Michal


--ujwtmacpuig457lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ0b6owAKCRAt3Wney77B
SX0QAP9cvQqVCchj9OH6W7oJHlww7JQl0bsI+4yKoM6pnh3RQwEA5QjYTqyQplN5
e90Z+6jpoEeJ/ANmxVT45rcrZIFwMAE=
=fGaR
-----END PGP SIGNATURE-----

--ujwtmacpuig457lw--

