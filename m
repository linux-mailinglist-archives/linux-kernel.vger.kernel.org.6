Return-Path: <linux-kernel+bounces-318028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252CA96E754
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3ED1285BAB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 01:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF2E1BDCF;
	Fri,  6 Sep 2024 01:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1Hd0Cqs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF91CA94
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725586607; cv=none; b=J6HwpycTSXFA7OmmrfDqNFsQVE+8gflKIaIsregxR2d+TUylBNMVlRxypmJJwTtu8sjTv1YAaRllnGnIe0V+NRMcodO7cXGuwEB+3Z7Kz/bGRitDJ/fb+Jbeml0G7Xv3EQsGHIizLjVXCH7wuglZy6cC8aLiJl1tWlhsoZyfT0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725586607; c=relaxed/simple;
	bh=5iTtw7kOx/YnIeNBRLJofk7fKpGXjnIazgYTV7KJOzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+JToIOy23+JUBVMa3tTStzS7mXteLxO58QPz9hJOLNFA9FhvrBDzLeldNmYfLPiZILolmo1ZyLSkctWwnnjUmyZOyJ1uJnozUt/EP/WGJ4VsZkq538eL+B2xW+nhYKXXsfALTbXRM5qpLcG2spEpZyY1H5wq5vntwgX2a8ZRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O1Hd0Cqs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725586604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sznQI6KuNKV7gRpvv3H+9o5AoDrtBah/Zop1d7Vs134=;
	b=O1Hd0CqsQAAoMfex4KGHTGbMNep4w9NuZ3wkKu4hx3PJ6uK4x7fzlVPV9TyyaNDcD06FZg
	vVRZZ77Rm+rYdZ77ZbJNsfY/UzU4AL6I+Lrjjg4fdObWPmqmWR7EoepfntqhlFGgKlsO45
	DLtO+CrSeCE1LyUp9gv9gn610KqvF80=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-pzqlTQsRPyOHwf_TC6_h_Q-1; Thu, 05 Sep 2024 21:36:43 -0400
X-MC-Unique: pzqlTQsRPyOHwf_TC6_h_Q-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-8486718aa6fso356536241.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 18:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725586602; x=1726191402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sznQI6KuNKV7gRpvv3H+9o5AoDrtBah/Zop1d7Vs134=;
        b=kQlJRvLvhXOzLz3hIUdZMzyjI++KbeOucjrFkD9T3TuxLMFx61vfnWMkqE1UKohtpJ
         MqZ3oYDriXHQ6Ri82MVFd8aB78jR8sjZbsWQ8D3h/7qlNQhy+RglvyRDpsK7QWMuIkxx
         PejUX3ujvOzHJWdGZlLQFRjztcbwBvGDB+GLC+lqS2Kncr1vVfEeYmkWJMUnV/74+hS/
         t6LU7mYgoZTLblIbueuc0Cy9cKrbaN83itobaDU1aWnCBjZhwhVBVXyOPH+2OQtKXNrL
         bpfC5jJmkEdpixY06Vv4Bpckllyw9Uam+vFR4fRRRWuRaEvTmh1c5x1RWHb0gsPJjqvi
         XhRg==
X-Forwarded-Encrypted: i=1; AJvYcCUi/AAwWk1aDnzsmOqv9uw91fpY1wgDz97rEHC50BBvzsuaZMN9xiFjBvdLa5UHQ0ZmMT2wt5JFPMrTAsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFV9zqQyWGOB30+sWJRx7YuaSzdhVMINxDQ8DBYkXRo9J8sPC/
	QA8vQ0pnOXruhzcmxQ0gpDTOyArDw0DQ0oC5TKhnzecD6841glxtr2L1zZMJ3mRTuwV65nQgZzr
	Xi68++MxUP7TMakUdexdbKska0sHXy2Mb0U5Jau/e9+HDu1QW8zxtUQlzIIsuwB4YCe+AjAYHrf
	48z3XxA0ZmH70SV2C2hJcLRgwNiJoop1NTYfArWYm2o8a/cMW7rg==
X-Received: by 2002:a05:6102:3ed5:b0:498:f38a:2c8b with SMTP id ada2fe7eead31-49a5b166e09mr24950393137.25.1725586602472;
        Thu, 05 Sep 2024 18:36:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSytqHqvZy4yLcEGDcGBzrXa4WczqvJwGscCUVOEV4Zt7+h1Q7crKt7Fs0mf/Uq6lIJdT+2b3TRaXddxIQmkA=
X-Received: by 2002:a05:6102:3ed5:b0:498:f38a:2c8b with SMTP id
 ada2fe7eead31-49a5b166e09mr24950371137.25.1725586601807; Thu, 05 Sep 2024
 18:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904134823.777623-2-costa.shul@redhat.com>
In-Reply-To: <20240904134823.777623-2-costa.shul@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 6 Sep 2024 09:36:30 +0800
Message-ID: <CAFj5m9JitO0sgmq+Viu5xX-VSCwBO_7=x3iDmF=+D6rXV7aPwA@mail.gmail.com>
Subject: Re: [PATCH] genirq: use cpumask_intersects
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 9:49=E2=80=AFPM Costa Shulyupin <costa.shul@redhat.c=
om> wrote:
>
> Replace `cpumask_any_and(a, b) >=3D nr_cpu_ids`
> with more readable `!cpumask_intersects(a, b)`.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  kernel/irq/cpuhotplug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
> index eb86283901565..15a7654eff684 100644
> --- a/kernel/irq/cpuhotplug.c
> +++ b/kernel/irq/cpuhotplug.c
> @@ -37,7 +37,7 @@ static inline bool irq_needs_fixup(struct irq_data *d)
>          * has been removed from the online mask already.
>          */
>         if (cpumask_any_but(m, cpu) < nr_cpu_ids &&
> -           cpumask_any_and(m, cpu_online_mask) >=3D nr_cpu_ids) {
> +           !cpumask_intersects(m, cpu_online_mask)) {
>                 /*
>                  * If this happens then there was a missed IRQ fixup at s=
ome
>                  * point. Warn about it and enforce fixup.
> @@ -110,7 +110,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
>         if (maskchip && chip->irq_mask)
>                 chip->irq_mask(d);
>
> -       if (cpumask_any_and(affinity, cpu_online_mask) >=3D nr_cpu_ids) {
> +       if (!cpumask_intersects(affinity, cpu_online_mask)) {
>                 /*
>                  * If the interrupt is managed, then shut it down and lea=
ve
>                  * the affinity untouched.

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,


