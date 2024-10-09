Return-Path: <linux-kernel+bounces-357557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25461997280
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C1828351F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880E514D71E;
	Wed,  9 Oct 2024 17:01:54 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B9126BED
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493314; cv=none; b=gO8vTtKkSiWKZ1Q4O71VElsBXQahC2NFm/+qbvvUbKTo+z81DHekvO0lpjoeBo1U37Twi85elVYDqmHOsQpePzPgz6Jxh9HFJjkG7Md+2ZlNbkHkhmtOwKGn6RuTKYKM2alN38vK4ceATHiGrxOZQjJvu3gIjBfhLWbRpjzpsT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493314; c=relaxed/simple;
	bh=EMjz7e0FiiwJ+rpFJnBtMUfHCt7yWhOOwBHNjKoon/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWnXpwKHFJKT4xzpQoRQjtZDjvidYVTfK3fYUXVUslU4LDhSEptEsDLBid2+WEeRLmlg+td2LoQJimFsdfAhxIwRAtEPcwYpHq91VqriNojAYdEr4N2W3Y9+PCE6FvJSYxiGAfgyZ4Es/a66KPNQ379E5AN8/FqY+APCZgH4UAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e2e4d16c2fso697397b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493311; x=1729098111;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkzjRec8YJ4+1+3P6DGrHTRe2F0Tq1u79D8Iz7E33N0=;
        b=KFbq0sed60FCAcouPqh4bxKw9DVppVMcw8ZInIAc80GIJr9dvYY5TQTzttHB/dKWvx
         Q95wOsP6hDDZ+Zle8+B5U1XClCVgP11XP52ntV8wXSPj1WUzNDuybq7Gl5tLhWPHZgrM
         hCgPDNZde7Ov3lSDzyGhiFvRlYth4JxS/hnJNOUY0X++tNUrzBDunbAVPckdjbc3OO0k
         byl09JmQib+HBLuIIWh6YuPIKPeYz78JCQ3/0DPfuh1t7iuAGzrFExC9FcJKJS4SE5mb
         mv7nK5K3UiSRqF6/rNQKVsbjX25IGx9bE6XfNvNQALhqnxcZpm3MuiAjU28gvzbXgLGd
         8z/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKkY2h1boahUyyQVDXRUyqtc+4mniG2wOTdd+k8lkMYI95Wtwg1rRdtIW8IHYqhRWPTwqlYAQivh8FsMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI2i9A3Y32h+qtu+bwt0sWSrWJeFGcV6IW+FS2RN3NF/eubKs5
	8RssgDCeGr09/2UC5RCpWhuNiAt4kV5vAkPCL8vbdtxzLXjhT5Ik
X-Google-Smtp-Source: AGHT+IF5haxHhjIQSSeW8G5y3sihqZS3wN9nTXQ1/IRQ/4p+dRXlzu5G2SVJsfnEskShU4FIZKEr0Q==
X-Received: by 2002:a05:690c:dc2:b0:6e3:1a7b:9c9b with SMTP id 00721157ae682-6e32210de3fmr29896977b3.3.1728493311117;
        Wed, 09 Oct 2024 10:01:51 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93d409esm19275077b3.88.2024.10.09.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:01:50 -0700 (PDT)
Date: Wed, 9 Oct 2024 12:01:47 -0500
From: David Vernet <void@manifault.com>
To: Honglei Wang <jameshongleiwang@126.com>
Cc: tj@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: use correct function name in pick_task_scx()
 warning message
Message-ID: <20241009170147.GB11867@maniforge>
References: <20241009030602.91216-1-jameshongleiwang@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1nXxWTsSIsVveJQJ"
Content-Disposition: inline
In-Reply-To: <20241009030602.91216-1-jameshongleiwang@126.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--1nXxWTsSIsVveJQJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 11:06:02AM +0800, Honglei Wang wrote:
> pick_next_task_scx() was turned into pick_task_scx() since
> commit 753e2836d139 ("sched_ext: Unify regular and core-sched pick
> task paths"). Update the outdated message.
>=20
> Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
> ---
>  kernel/sched/ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 410a4df8a121..22e18aec4ee1 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2958,7 +2958,7 @@ static struct task_struct *pick_task_scx(struct rq =
*rq)
> =20
>  		if (unlikely(!p->scx.slice)) {
>  			if (!scx_rq_bypassing(rq) && !scx_warned_zero_slice) {
> -				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pi=
ck_next_task_scx()\n",
> +				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pi=
ck_task_scx()\n",

Doesn't really matter much, but if we ever decide to touch this line again =
then
something like this will be a bit more robust:

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fe8acae35166..9fde2d3f8df5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3020,8 +3020,8 @@ static struct task_struct *pick_task_scx(struct rq *r=
q)

                if (unlikely(!p->scx.slice)) {
                        if (!scx_rq_bypassing(rq) && !scx_warned_zero_slice=
) {
-                           printk_deferred(KERN_WARNING "sched_ext: %s[%d]=
 has zero slice in pick_next_task_scx()\n",
-                                           p->comm, p->pid);
+                         printk_deferred(KERN_WARNING "sched_ext: %s[%d] h=
as zero slice in %s()\n",
+                                         p->comm, p->pid, __func__);
                                scx_warned_zero_slice =3D true;
                        }
                        p->scx.slice =3D SCX_SLICE_DFL;

--1nXxWTsSIsVveJQJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZwa2+wAKCRBZ5LhpZcTz
ZMCCAQC9zg1Ef5GgcT/XYyOMRTqcnTjJ64293rDd4VquCozLkgD/aDR/cocTS8Xj
Tghp43IlXvUQJqQsos3CqIDGd1i+ugM=
=cn1m
-----END PGP SIGNATURE-----

--1nXxWTsSIsVveJQJ--

