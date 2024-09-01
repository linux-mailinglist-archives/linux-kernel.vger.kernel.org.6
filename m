Return-Path: <linux-kernel+bounces-310051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD38F967426
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 03:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD9DB21AED
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 01:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA173224E8;
	Sun,  1 Sep 2024 01:40:06 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F94A01
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725154806; cv=none; b=L75nykRpHUrl+bZ2yMNsBDrdjm9+sGCjN5YyqKW1OYK7zQrSHWckgtG0FOZN5YT0Qz9ywCwSw9Ok2uZyUS8d+sAivU9cO5jduX0KvEu49edSu8YO2mHwjDlC9Sl46/d0JIY0PN+VmywFhP+ESXhs6etX/QALuFdiuX6sLLUn1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725154806; c=relaxed/simple;
	bh=ShGd81rIB8FWPwie9GznTdgj4IbOhgt7nACoB516FIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpXR0qRvTxEQrpsOU+nzIECvVHHNXSc45YMoVghileoMygDhK1XQfBXIIzPurQR+NVmXMSsi4gS3suOlxn4e1GKxKvBPA5vQhy27tS0TcBJFB46kj8m3dRU6KQ1JN3Zd4rbBR3Rqt3s8B2E69VIJxdEwys8gx8J/SrQgb/sYmkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-498d7ab8fefso1205815137.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 18:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725154803; x=1725759603;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M62RPjXdQZ3qRN/395TUlOdWsjehUdGFN0cXCmAwUy4=;
        b=H21xlR9MNeSLg8EEV9n8kEGCj0K/egcV0dlUv4DTHw9pLu5wgTyFgxlZLlMBqDCH5t
         5WTlitLZx0mblKpYymPo9Ofap9WIj9WjnSl6t6YQIsL+aDbHBZqQo0VzaSoy+ieofFyg
         d6mMaov/Aiq7kfB/+10euLqDx++h2QFhHlGi0av2tCuo66UOxs4AMw9DhM8doMriKZ3R
         Envit9AgD0uyLNbYO4Molb6HJmtl8X43LBlps+Kz3SRgrJv2spc3f7D5zPdgh43ZRY85
         Izc/POs9u2St/VlJS6J/ZV6voSDMa5eAWPqiv8csrqlJ80JwfSyRjdi7jdVwUtuKlrvR
         zQDw==
X-Forwarded-Encrypted: i=1; AJvYcCVafS2Yl8IXA1ds0/A0l5bQv+eTHkFQpLbdbH/HzgHSh/a7/25IU05LiUpGPuoEbVjiOi30uPOa3Jx6ICU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTf9IoHrz/XPwaTtI75d795xsjYrKiiEPWGMX6ik0P5QG6rMgY
	gsrFTVE8say2MPgTgBfYRwZpcGBx2isan7L74nglCPvHTjtYP+1F
X-Google-Smtp-Source: AGHT+IG4A3iLRdMswfNrg0vTxfMCDI0Ez11RzVkdWlIFBD8QJ7xJmhW3RJ/5TRP6xax98Mypbz5wuA==
X-Received: by 2002:a05:6102:442b:b0:498:cf81:3a40 with SMTP id ada2fe7eead31-49a7778c1admr3878603137.17.1725154803396;
        Sat, 31 Aug 2024 18:40:03 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d83451sm288274385a.126.2024.08.31.18.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 18:40:02 -0700 (PDT)
Date: Sat, 31 Aug 2024 20:40:00 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] sched_ext: Reorder args for
 consume_local/remote_task()
Message-ID: <20240901014000.GG70166@maniforge>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-7-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xb8YIw+HKJcm1tkm"
Content-Disposition: inline
In-Reply-To: <20240830110415.116090-7-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--xb8YIw+HKJcm1tkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 01:03:50AM -1000, Tejun Heo wrote:
> Reorder args for consistency in the order of:
>=20
>   current_rq, p, src_[rq|dsq], dst_[rq|dsq].
>=20
> No functional changes intended.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index add267f31396..620cc0586c4b 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2139,8 +2139,8 @@ static void move_task_to_local_dsq(struct task_stru=
ct *p, u64 enq_flags,
> =20
>  #endif	/* CONFIG_SMP */
> =20
> -static void consume_local_task(struct rq *rq, struct scx_dispatch_q *dsq,
> -			       struct task_struct *p)
> +static void consume_local_task(struct task_struct *p,
> +			       struct scx_dispatch_q *dsq, struct rq *rq)
>  {
>  	lockdep_assert_held(&dsq->lock);	/* released on return */
> =20
> @@ -2249,8 +2249,8 @@ static bool unlink_dsq_and_lock_task_rq(struct task=
_struct *p,
>  		!WARN_ON_ONCE(task_rq !=3D task_rq(p));
>  }
> =20
> -static bool consume_remote_task(struct rq *this_rq, struct scx_dispatch_=
q *dsq,
> -				struct task_struct *p, struct rq *task_rq)
> +static bool consume_remote_task(struct rq *this_rq, struct task_struct *=
p,
> +				struct scx_dispatch_q *dsq, struct rq *task_rq)
>  {
>  	raw_spin_rq_unlock(this_rq);
> =20
> @@ -2265,7 +2265,7 @@ static bool consume_remote_task(struct rq *this_rq,=
 struct scx_dispatch_q *dsq,
>  }
>  #else	/* CONFIG_SMP */
>  static inline bool task_can_run_on_remote_rq(struct task_struct *p, stru=
ct rq *rq, bool trigger_error) { return false; }
> -static inline bool consume_remote_task(struct rq *rq, struct scx_dispatc=
h_q *dsq, struct task_struct *p, struct rq *task_rq) { return false; }
> +static inline bool consume_remote_task(struct rq *this_rq, struct task_s=
truct *p, struct scx_dispatch_q *dsq, struct rq *task_rq) { return false; }
>  #endif	/* CONFIG_SMP */
> =20
>  static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
> @@ -2286,12 +2286,12 @@ static bool consume_dispatch_q(struct rq *rq, str=
uct scx_dispatch_q *dsq)
>  		struct rq *task_rq =3D task_rq(p);
> =20
>  		if (rq =3D=3D task_rq) {
> -			consume_local_task(rq, dsq, p);
> +			consume_local_task(p, dsq, rq);
>  			return true;
>  		}
> =20
>  		if (task_can_run_on_remote_rq(p, rq, false)) {

How do you feel about always prefixing src_ and dst_ for any arguments
that refer to either (with any @rq before @p implying current as this
patch proposes)? In this case it's a bit confusing to read because
technically according to the convention proposed in this patch, @rq
could be either curr_rq or src_rq in consume_dispatch_q() (there's no
@p to disambiguate), and @rq could be either src_rq or dst_rq in
task_can_run_on_remote_rq() (they both come after @p).

It's pretty obvious from context that @rq is referring to a dst_rq in
task_can_run_on_remote_rq(), but it might still be a bit easier on the
eyes to be explicit. And for functions like consume_remote_task() which
take both a src_dsq and a src_rq, I think it will be easier to follow
then the convention.

Thanks,
David

> -			if (likely(consume_remote_task(rq, dsq, p, task_rq)))
> +			if (likely(consume_remote_task(rq, p, dsq, task_rq)))
>  				return true;
>  			goto retry;
>  		}
> --=20
> 2.46.0
>=20

--xb8YIw+HKJcm1tkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZtPF8AAKCRBZ5LhpZcTz
ZF8uAP9mmoMXE1qu2keG+/BnjMJO5fksd4bDFiw0/j6RbR2jTQD9HhLAv23KlDf8
tp+HgMC3WplL/Ej+EylOYVrZX1zotg4=
=7LAo
-----END PGP SIGNATURE-----

--xb8YIw+HKJcm1tkm--

