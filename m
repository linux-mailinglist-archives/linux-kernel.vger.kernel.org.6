Return-Path: <linux-kernel+bounces-279903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770B094C334
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304BE288B94
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CC218FDC9;
	Thu,  8 Aug 2024 17:00:13 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E921190480
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136413; cv=none; b=Qu/w0vNCbC6YWZmTcYQj2rqiVkZYE127a8T3i5JLEwyrcEIFgxuciOeZKlEXT+zRJn+76eOjuioV88czB12StQedWwd0L0jcy4fppt7VErVEnLTto3nE3PJlsv4TUGIBqubt82kP+sB4C0R5W1t8uK1NkCl5r3cN+FJ9ly94HOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136413; c=relaxed/simple;
	bh=WLu/qunDEPYWVg+3QdtXvv+RxqjdfzKpgyThSz7PE1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WW+uolCqwxekEtha6fqOZnalzWug3R8qqSk1p+kCDuzHnMtwTjCqWGVTkaovNYDNq93u11JU0MCfgFZNpx2tulGZXfzhtBWh5p2uA+1bAZ3RVWVnl2pfZYEEWY7l2+x1pkuWy6kTOCJZ8kjGB5YpCpTPEoYqsiHTgjE9vXAo6fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b7a36f26f3so19888176d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 10:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723136409; x=1723741209;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGkLIhhwXdXteeSjY2/FlquAK3aLu21xD2MJxijmIdc=;
        b=bZuQYBN+mbL43R5eQxsGrCEEUjfremXGagixmJDgEvnMaYD8kg1vJ4CYMgFkMQO9S2
         ilphqWkmt1JjDT9XQsyJprjs0qR1iLvry8AMyop1ldXfr6X2n/FUIPhgnqmHbOGa4Twd
         ZobicBeMohr/hEpfw+ryxQNy82sT9LgE62wtvUTmDAOfU92AoG7je0ZAGx1quaeS1z3R
         oj2J+I4nSkjIGEXnQ9wJDNvY2oO03zRCXYQIU0OwzMTKStSFmd84W5VSGTwOzWuNZ4Jh
         4aPpuVKbFPZet3bw8gLs1/cBZyc6fHqLCOFn1MCGbcBVT550qWvkY3mUvZa5AY4aOgzO
         4Z5g==
X-Forwarded-Encrypted: i=1; AJvYcCV7x/i5uASv1Jv21yA59WdA8bVPcVsqz5h9LkHlA2UNPTNGPhobeZVNpp0DEXDielZcu+Q7ARpR6VWgH3mW3chE83U+4g2X11XFJL5C
X-Gm-Message-State: AOJu0YyCPwjyva2vkYTUMMy7BNW6ZwlNqacw9jGWUixHY5yPG2eE16MZ
	LA81+vY4EMjESxGi/K9o8D049I2cxMJnzjSYpXYkaQ8DfIPC4hXV
X-Google-Smtp-Source: AGHT+IH2oiVdwUKUUHhuebMGQN4cTWYz1FZhhjZM+b1GV9bLfRurjx1JVhpJUxaTAT0q1aDcgd25TA==
X-Received: by 2002:a05:6214:29c9:b0:6b5:1584:62bf with SMTP id 6a1803df08f44-6bd6cacccd6mr41756186d6.6.1723136409210;
        Thu, 08 Aug 2024 10:00:09 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c76f8ccsm68570876d6.4.2024.08.08.10.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:00:08 -0700 (PDT)
Date: Thu, 8 Aug 2024 12:00:06 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Improve logging around
 enable/disable
Message-ID: <20240808170006.GB6223@maniforge>
References: <ZrQW4gqIr_hTgp0z@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fdIb7HZuWu12nU98"
Content-Disposition: inline
In-Reply-To: <ZrQW4gqIr_hTgp0z@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--fdIb7HZuWu12nU98
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 02:52:50PM -1000, Tejun Heo wrote:

Hi Tejun,

> sched_ext currently doesn't generate messages when the BPF scheduler is
> enabled and disabled unless there are errors. It is useful to have paper
> trail. Improve logging around enable/disable:
>=20
> - Generate info messages on enable and non-error disable.
>=20
> - Update error exit message formatting so that it's consistent with
>   non-error message. Also, prefix ei->msg with the BPF scheduler's name to
>   make it clear where the message is coming from.
>=20
> - Shorten scx_exit_reason() strings for SCX_EXIT_UNREG* for brevity and
>   consistency.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Phil Auld <pauld@redhat.com>
> ---
>  kernel/sched/ext.c |   21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 60a7eb7d8a9e..eea2fda8e099 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4004,11 +4004,11 @@ static const char *scx_exit_reason(enum scx_exit_=
kind kind)
>  {
>  	switch (kind) {
>  	case SCX_EXIT_UNREG:
> -		return "Scheduler unregistered from user space";
> +		return "unregistered from user space";
>  	case SCX_EXIT_UNREG_BPF:
> -		return "Scheduler unregistered from BPF";
> +		return "unregistered from BPF";
>  	case SCX_EXIT_UNREG_KERN:
> -		return "Scheduler unregistered from the main kernel";
> +		return "unregistered from the main kernel";
>  	case SCX_EXIT_SYSRQ:
>  		return "disabled by sysrq-S";
>  	case SCX_EXIT_ERROR:
> @@ -4126,14 +4126,17 @@ static void scx_ops_disable_workfn(struct kthread=
_work *work)
>  	percpu_up_write(&scx_fork_rwsem);
> =20
>  	if (ei->kind >=3D SCX_EXIT_ERROR) {
> -		printk(KERN_ERR "sched_ext: BPF scheduler \"%s\" errored, disabling\n"=
, scx_ops.name);
> +		pr_err("sched_ext: BPF scheduler \"%s\" disabled (%s)\n",
> +		       scx_ops.name, ei->reason);
> =20
> -		if (ei->msg[0] =3D=3D '\0')
> -			printk(KERN_ERR "sched_ext: %s\n", ei->reason);
> -		else
> -			printk(KERN_ERR "sched_ext: %s (%s)\n", ei->reason, ei->msg);
> +		if (ei->msg[0] !=3D '\0')
> +			printk(KERN_ERR "sched_ext: %s: %s\n",
> +			       scx_ops.name, ei->msg);

Was it intentional to use pr_err() above, and printk() here? If not,
let's make them consistent?

Looks good otherwise.

Acked-by: David Vernet <void@manifault.com>

Thanks,
David

--fdIb7HZuWu12nU98
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZrT5lgAKCRBZ5LhpZcTz
ZA72AP9n6JROZdkWAgO5KHDX5TWkKWpMjGJqu9d+2nr0JlmYYQD/Wqis0DF/B70x
zBJYaFNsMlY4t0eAqm6z9Uq6R2uhTgE=
=tGJw
-----END PGP SIGNATURE-----

--fdIb7HZuWu12nU98--

