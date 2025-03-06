Return-Path: <linux-kernel+bounces-548515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2EEA545F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2DA16DF91
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8382080E4;
	Thu,  6 Mar 2025 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="CEdPcA0f"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ACE19D071
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252302; cv=none; b=i5N+bPJas/VWrRfClzLUBj+5eAoltU6r0rvQp10put9kt0Jp1TMKOwIs3jjmsKGCUi2TXKZY6SBN7W5dMAwO1TyoBVy3UygdeKcR8dcK1qThwThDTkLPxRbGAnIox5eR3MagZ/ZFJ8jRQhBNS6SUJZPhK53Fjl9irlT7g08RY1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252302; c=relaxed/simple;
	bh=kQIa3nu2dhzzjZvADyStpwydtsC0PTIr5Q83B1P9CPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0UmBcPRfYfy/MugMQ4QVwGDgOAz/br+QCAYEd+VugiFmpmGnnnDhcN/bXI1QzbPllctmrJvoOwujLLzRc2IQzwJCsKcmhtEg3nqTO+vxPPlCSRK6U+slxiQri49QFvB0MIXMBl8JCmx6aoxH01De2H4CMs9MDa0OUMl8qpWFPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=CEdPcA0f; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30beef77634so658441fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1741252299; x=1741857099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeth2/2WslWW8IDOKFvvxyGpvpWqnNKGjKnPKeSelOQ=;
        b=CEdPcA0fu2gJIihs2G6Ow6aiALcOtYY1AtZe5e0Dno9Y5QTFLsACGRokPQOLQ4Ftix
         raGJvquXt1EhcwHJhVcxoEVmCeVGFyg74DDdVM3Hm8JBeZMx2qKtPjR9c4Ne1PrVHa82
         K4r8k7v1bTd/afs/AhQwN8qAjx2UfwxXSSUt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741252299; x=1741857099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeth2/2WslWW8IDOKFvvxyGpvpWqnNKGjKnPKeSelOQ=;
        b=UwdrxJ9hIyjoErJvxBjjrm6N03KVobKe0tR5H8S5YHdSvHQwRUhlVQ40etg8KQ8nN4
         lTa7ZZ9hS6HIkg5qw/v2HV6lEjLEkOrCz8wzOpaljVUEBBtelqmfn26GdXvKcNDSPPHk
         KlzaU1YQpRlZVm6MFi8gtrV+vn+ddkfMBvcojqN3tGB/k3YJVDETl0pbgwUeA/nwGipX
         pDIoEX2fHyH9mTRJK+Gdb4lOyWuvUaRX2xagU9MHjhQQI/NVPqgRYbgd5/e3TjMFZAMS
         8+Fl/AcqomKTn+/XNidiJ7xWqocqKLMkA2BFGyXiQQnFulnfYpvJ+xjacJ/CN4qRpSG9
         DAYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVingklgZtPazXh8mKraiSZY/d65FZUPJM/8Q0CfKbMDIFxRUozsyFDf49b9mm9fo9Fe0vdQFMg4BMCGqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkv0UYZWlWLtlBXcyIpr1wsUNWlFul7bWPQO+nmCV7KxsLIyP
	R2DGfuPflB5INjp6hKOahqraJdr6ZpwKYgpePQgjt3UCpbCsnD/6f+Cp5VJNEA5CwkKcK1Mt5uy
	gK1R0nO033Q3F6W4erZwfmmCeDl5il51xoOU2DA==
X-Gm-Gg: ASbGncsdQcHe3ma/SJ6DUUFFhOiHmURWng8kwsJK+N8ypkoETeKseYhL1yitIGWI6LS
	0U1u2MNAfipjeSv7XLU/8pjIYQ4x8+Q/pIQjo1d8Jx0pL5m4nmDTMgLm7u5fwh/XTYamWiOHjRu
	8WT5xirsG70t/GWtRbJ69RRS5joBc=
X-Google-Smtp-Source: AGHT+IHp0EwKW/mOwwrvGUkD45b4cykkGlMzlje720ZqEQzzqD2CKDKzqQzHA5PnPST8uBsAD2Ey6XqRrM8nPZSdoFM=
X-Received: by 2002:a2e:96d9:0:b0:30b:c883:e818 with SMTP id
 38308e7fff4ca-30bd7a66cabmr21884891fa.17.1741252298290; Thu, 06 Mar 2025
 01:11:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305145849.55491-1-mkoutny@suse.com>
In-Reply-To: <20250305145849.55491-1-mkoutny@suse.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 6 Mar 2025 10:11:27 +0100
X-Gm-Features: AQ5f1JoE-BDN4spZyACUJCu3-W0Hu-H7PXGcdeS11mXRmTJKgctT4st0BoDJqIo
Message-ID: <CAJqdLrri0q-Et5PfdwP69r7wYDi3_nY225UP5HYVABUFtE5TGw@mail.gmail.com>
Subject: Re: [PATCH] pid: Do not set pid_max in new pid namespaces
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	Joel Granados <joel.granados@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Wei Liu <wei.liu@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mi., 5. M=C3=A4rz 2025 um 15:59 Uhr schrieb Michal Koutn=C3=BD <mkoutny@=
suse.com>:
>
> It is already difficult for users to troubleshoot which of multiple pid
> limits restricts their workload. The per-(hierarchical-)NS pid_max would
> contribute to the confusion.
> Also, the implementation copies the limit upon creation from
> parent, this pattern showed cumbersome with some attributes in legacy
> cgroup controllers -- it's subject to race condition between parent's
> limit modification and children creation and once copied it must be
> changed in the descendant.
>
> Let's do what other places do (ucounts or cgroup limits) -- create new
> pid namespaces without any limit at all. The global limit (actually any
> ancestor's limit) is still effectively in place, we avoid the
> set/unshare race and bumps of global (ancestral) limit have the desired
> effect on pid namespace that do not care.
>
> Link: https://lore.kernel.org/r/20240408145819.8787-1-mkoutny@suse.com/
> Link: https://lore.kernel.org/r/20250221170249.890014-1-mkoutny@suse.com/
> Fixes: 7863dcc72d0f4 ("pid: allow pid_max to be set per pid namespace")
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>

Dear Michal,

This completely makes sense and I tend to agree. But we also need to
ensure that the kselftest for pid_max is not broken with this change.
Let me play with this stuff a bit and I get back with "Tested-by" ;-)

Kind regards,
Alex

> ---
>  kernel/pid_namespace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 8f6cfec87555a..7098ed44e717d 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -107,7 +107,7 @@ static struct pid_namespace *create_pid_namespace(str=
uct user_namespace *user_ns
>                 goto out_free_idr;
>         ns->ns.ops =3D &pidns_operations;
>
> -       ns->pid_max =3D parent_pid_ns->pid_max;
> +       ns->pid_max =3D PID_MAX_LIMIT;
>         err =3D register_pidns_sysctls(ns);
>         if (err)
>                 goto out_free_inum;
>
> base-commit: 48a5eed9ad584315c30ed35204510536235ce402
> --
> 2.48.1
>

