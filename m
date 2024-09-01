Return-Path: <linux-kernel+bounces-310049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F313967420
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 03:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4BF282B9C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 01:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DA61EEE3;
	Sun,  1 Sep 2024 01:09:42 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1DC79C2
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 01:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725152982; cv=none; b=LUPMgRdyFlgZ8WzZgWVyejAnVsSnc2LnqVkKWHO2Kig8LM64So2VqHsKkUAI8sq+vV79mk/OVzUKnRFInIgFoApeWLCP3AShzosBsr1otLAdzrAYjhV3QqDb+HIysalANk7CeejWhqcvzVNyzRu8UYF6EK0MmvJcVAi0RVZEcYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725152982; c=relaxed/simple;
	bh=09WEYAoaYIWI8H/VsnPLMiOXtdks3sa22lYLUVDbKRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJmjko3jdlFBecV+Kqqe7DM3ngDhOqGHxoE4FgmulovqzVbDKe4385UJe7jRAMyXaXnUEe+qqivtole1ebrDRAN3V3ckZnBf3WjotC0gT0u/3dBpC2+I5J4Aq91KGIr6aTHKAZcczSH0fXkYTJf1THY4HcEHy1hmftKSm7QT1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a8125458e4so123516685a.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 18:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725152979; x=1725757779;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBYjmSfur/+qUf9hZFWy/glGR08G1FcGpyNx7QGm8/Q=;
        b=LbIxQlC8GX8Y6AIIFhwN+HRxqBUBq0iLItXA4Jdq0Cu8ZezJOqMwBfp/nvzy/IhwH8
         Gl6oE/EpWjhqJIqcz/EJQHAlxX0jZs1z0yQmLAvajiqloypSJ7bCQ2hPxOIzhH9jBiSH
         PevI6mcW5lmFTos6AqDGVbvCucjQd6solrHIxK5SLXK184Wy6307A7gOu1CbgObXMSZa
         KtI/WTReOaQrZzAtxtyT5Fvtsuz0IiC8wWwY3cjBn0lrS8sPIv5xtllQUVPXseqHuahI
         erTgGUSyOA/GESDAB7nh1keL73w1XqLplYoWl1RXw9Ng6+A2cnjXvGyfPZxi8ucTR+0q
         Kv6g==
X-Forwarded-Encrypted: i=1; AJvYcCVoaTyqrwK+vWws9RlDbUfeBKyQ28wIe588OUlmwOzDPKFZClDggbpzaNiKRlPy5R8MTrC4+gXv1AC90OE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+MhJjRdAf32RIV71iLBgFy8rzlpJKhaQxtScWNvnC4rZ8KKS
	mE/m3seJV8fBEX1EFH6FjwSXBcrsQKdt/ZOfVThrGAn7MRlsrbLo
X-Google-Smtp-Source: AGHT+IEqMn4U8Q0zic0JNck0YJYxm5qTDe6vmWd437Wyz9a0xLXFS50wh4VgfIdpDp1mNbfUiysKzw==
X-Received: by 2002:a05:620a:40c1:b0:79e:ff41:fd47 with SMTP id af79cd13be357-7a8f6bca35dmr459685885a.28.1725152979305;
        Sat, 31 Aug 2024 18:09:39 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c4a6e6sm285826985a.64.2024.08.31.18.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 18:09:38 -0700 (PDT)
Date: Sat, 31 Aug 2024 20:09:36 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] sched_ext: Restructure dispatch_to_local_dsq()
Message-ID: <20240901010936.GF70166@maniforge>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-6-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OdEjSQVAIULJHznn"
Content-Disposition: inline
In-Reply-To: <20240830110415.116090-6-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--OdEjSQVAIULJHznn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 01:03:49AM -1000, Tejun Heo wrote:
> Now that there's nothing left after the big if block, flip the if conditi=
on
> and unindent the body.
>=20
> No functional changes intended.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

LGTM, just one comment below.

Acked-by: David Vernet <void@manifault.com>

> ---
>  kernel/sched/ext.c | 94 ++++++++++++++++++++++------------------------
>  1 file changed, 44 insertions(+), 50 deletions(-)
>=20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 34b4e63850c1..add267f31396 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2333,65 +2333,59 @@ static void dispatch_to_local_dsq(struct rq *rq, =
struct scx_dispatch_q *dst_dsq,
>  	}
> =20
>  #ifdef CONFIG_SMP
> -	if (likely(task_can_run_on_remote_rq(p, dst_rq, true))) {
> -		/*
> -		 * @p is on a possibly remote @src_rq which we need to lock to
> -		 * move the task. If dequeue is in progress, it'd be locking
> -		 * @src_rq and waiting on DISPATCHING, so we can't grab @src_rq
> -		 * lock while holding DISPATCHING.
> -		 *
> -		 * As DISPATCHING guarantees that @p is wholly ours, we can
> -		 * pretend that we're moving from a DSQ and use the same
> -		 * mechanism - mark the task under transfer with holding_cpu,
> -		 * release DISPATCHING and then follow the same protocol. See
> -		 * unlink_dsq_and_lock_task_rq().
> -		 */
> -		p->scx.holding_cpu =3D raw_smp_processor_id();
> +	if (unlikely(!task_can_run_on_remote_rq(p, dst_rq, true))) {
> +		dispatch_enqueue(&scx_dsq_global, p, enq_flags | SCX_ENQ_CLEAR_OPSS);

Given that UP systems will always take the path above where rq =3D=3D src_rq
&& rq =3D=3D dst_rq, this isn't really a functional change, but technically
we are now moving the backup global DSQ dispatch_enqueue call into the
CONFIG_SMP block. Should we maybe add a BUG() in an #else block below?
It's UP so it's obviously not super critical, but it might help
readability? Feel free to ignore -- the fact that all the rest of the
logic is in a CONFIG_SMP block is pretty clear, and this arguably
already improves readability by moving an unreachable piece of code on
UP into the SMP block.

Thanks,
David

> +		return;
> +	}
> =20

[... snip ...]

>  #endif	/* CONFIG_SMP */
> -
> -	dispatch_enqueue(&scx_dsq_global, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
>  }
> =20
>  /**
> --=20
> 2.46.0
>=20

--OdEjSQVAIULJHznn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZtO+0AAKCRBZ5LhpZcTz
ZBDOAP9mmtS385e8mYAYCdV53enX86zShwaRBMTADnLTWMvLvQEA9SiWWFBDMmta
RZxuNnAG5EHHxrDrIK44IyVgN+Z2BQs=
=2kQK
-----END PGP SIGNATURE-----

--OdEjSQVAIULJHznn--

