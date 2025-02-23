Return-Path: <linux-kernel+bounces-527566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFBDA40CA9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 05:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E859E7AC1F0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 04:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796FE1C8638;
	Sun, 23 Feb 2025 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mfpvpIQE"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF901F5EA
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 04:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740283261; cv=none; b=rn3UgJXtci15xzpZOAzaInCjOqzU1t8AfrJbGg2bxa63QomGOs+on3VR3P8rPBzj0ZcFH9B7TEhjW63pee+3wo35vKCFCF8lVN0jrqXyiYHtrRxZdJSsSt5Of3E+zM4HXTut7ObVynS/7xQ/hmtTSN+enrSVIbbSI1ZeYcpFpIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740283261; c=relaxed/simple;
	bh=NPRHBze8188Fc/dmK0zK3env63I+msIIhU0YUA5geFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIp+MvuhMm0n9h7GmZWrrWFfNl+M59f8N3IJFAW9XcLGX8vNi/5ZhVWekyx0l7X/aPnQwj5T/EccjoGc+vETYYO16O54DlMkHGe5d0BVekWbW9UUjbDSY+dz1tcRiMQfXWc1+UHFjfzLYkUtUi3N/ez2Jr+yfWr98e5qb8lpMMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mfpvpIQE; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-471fbfe8b89so304801cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 20:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740283259; x=1740888059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aY9CdaTP4RbjlHaRC0ponJc9BbyfmorYxqjI77oHIeQ=;
        b=mfpvpIQEEd96JFfGqRsJ9OTmO19qBAWL22xl8iBwUafIjO99sn89hPXRTzI4OljEHh
         j384fG1CUqG/8VP4RZVMYX0J7t6gmXmqy789ja9HhKrUduohPOPg7cJlVaz2GDEm1fx9
         ZvtVD/71dQrGYpqOHEw8icNdrYZjo9dHn5vtJucZNRiE+LflWXBermKJKgjpuq2j/Y8K
         9C8zVFESgxMYxw1+y15qQYBXdR/81BeEr7vvNrgBYsXz7kgmVYOIuaomNgTPzOf5x6TG
         hzckWNMVie7+Y+g4q2LzYNhNCL9CCqfxd6AK98vovBRxkLIHdpwZrcLt99Dz63gNLEvF
         2GnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740283259; x=1740888059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aY9CdaTP4RbjlHaRC0ponJc9BbyfmorYxqjI77oHIeQ=;
        b=gPgzhXBQnX+F1HT2Lbv9Hs0ct9sDX7C2nAGpTPUfH6fQ9YJU9OkR/SZw+pii8vo6gB
         7JcB2vefobOUhJaLU2w3HKy2Ogxgt/UupI/oc+2/dmWzjLAIjW+0MtCWKd9jogvAd7Fa
         WfHAyzwDaGWmf+5gO0EXtUkExQ18u/YbJnU/QfQstIA0pEpF28Ovo9bZIT2Yg+KChf9D
         gvePWp3eGonnH3wRnbDeyf+bneBsrMwfmJF1ebcRcEnV5HjAJVfdw4nCW3uZEgUsI7og
         qFIrpZpkLAo/9TljAiBz5OEsGz+5wH4yy6i+TvuPFQdqBmMhzxi39UPT/Mdex7Yxppl/
         IWkA==
X-Forwarded-Encrypted: i=1; AJvYcCXQA2h51vbRFiu4UXhBsaAvo7bEpOnEVGvI7h84XBdxj5s7mUPj5/z2SLodUp5H9WJD9ZpH5moPlMevJF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+HFESdVskf4GPMCcplz8Ab6gjp+8+QuHyMSwjVYKdP2kGJJ8
	y7D0PhCJE8nz+DYoMFEjwn7kig10YCfDN1ZQJfwkTTug5Im93kyJnPyHo31VP59GAJ/R/TbtE+1
	u67PZDeVVHuNi+fxsX3Dv5B/a1XZRUoAP85gm
X-Gm-Gg: ASbGncvgW6qaHXEdX73YdB8xKDgX0RaBvzb4gqVfOvTB6TzXiW4L+Ud0jrgzTcEG9u9
	uL0nSJDUv5H3k/J2v7OxROmAMSKyxmmHNPNLUUCeht0Ztwx8wQWNIw/c71PWPs2KSK2OKJ1pcrp
	skB5qHDuo=
X-Google-Smtp-Source: AGHT+IHetWQEdxRiILOaUBpw/NeyYJ/gqHkNcZyWUSeSwMhL2AOEG5FmX2oXvR+sBPsWcfju++oIs/B2IWKj7AV9jXc=
X-Received: by 2002:ac8:5dce:0:b0:447:e59b:54eb with SMTP id
 d75a77b69052e-4723358478emr3373221cf.26.1740283258617; Sat, 22 Feb 2025
 20:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz> <20250214-slub-percpu-caches-v2-7-88592ee0966a@suse.cz>
In-Reply-To: <20250214-slub-percpu-caches-v2-7-88592ee0966a@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 22 Feb 2025 20:00:47 -0800
X-Gm-Features: AWEUYZk951RWW7__fhix8bBdYAk5asCgJ9Ex815rLz1fssOu7vW6UIhbzIZEhBs
Message-ID: <CAJuCfpF0-dAmUdH93_9MDyScO0+q5xrsuzLNwRBTPjpC_xj0Dw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 07/10] slab: determine barn status racily outside
 of lock
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:27=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> The possibility of many barn operations is determined by the current
> number of full or empty sheaves. Taking the barn->lock just to find out
> that e.g. there are no empty sheaves results in unnecessary overhead and
> lock contention. Thus perform these checks outside of the lock with a
> data_race() annotated variable read and fail quickly without taking the
> lock.
>
> Checks for sheaf availability that racily succeed have to be obviously
> repeated under the lock for correctness, but we can skip repeating
> checks if there are too many sheaves on the given list as the limits
> don't need to be strict.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 57 ++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 34 insertions(+), 23 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index c1df7cf22267f28f743404531bef921e25fac086..72e6437f1d74bfacbb1cd7642=
af42929c48cc66a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2685,9 +2685,12 @@ static struct slab_sheaf *barn_get_empty_sheaf(str=
uct node_barn *barn)
>         struct slab_sheaf *empty =3D NULL;
>         unsigned long flags;
>
> +       if (!data_race(barn->nr_empty))
> +               return NULL;
> +
>         spin_lock_irqsave(&barn->lock, flags);
>
> -       if (barn->nr_empty) {
> +       if (likely(barn->nr_empty)) {
>                 empty =3D list_first_entry(&barn->sheaves_empty,
>                                          struct slab_sheaf, barn_list);
>                 list_del(&empty->barn_list);
> @@ -2703,38 +2706,36 @@ static int barn_put_empty_sheaf(struct node_barn =
*barn,
>                                 struct slab_sheaf *sheaf, bool ignore_lim=
it)
>  {
>         unsigned long flags;
> -       int ret =3D 0;
> +
> +       /* we don't repeat the check under barn->lock as it's not critica=
l */
> +       if (!ignore_limit && data_race(barn->nr_empty) >=3D MAX_EMPTY_SHE=
AVES)
> +               return -E2BIG;
>
>         spin_lock_irqsave(&barn->lock, flags);
>
> -       if (!ignore_limit && barn->nr_empty >=3D MAX_EMPTY_SHEAVES) {
> -               ret =3D -E2BIG;
> -       } else {
> -               list_add(&sheaf->barn_list, &barn->sheaves_empty);
> -               barn->nr_empty++;
> -       }
> +       list_add(&sheaf->barn_list, &barn->sheaves_empty);
> +       barn->nr_empty++;
>
>         spin_unlock_irqrestore(&barn->lock, flags);
> -       return ret;
> +       return 0;
>  }
>
>  static int barn_put_full_sheaf(struct node_barn *barn, struct slab_sheaf=
 *sheaf,
>                                bool ignore_limit)
>  {
>         unsigned long flags;
> -       int ret =3D 0;
> +
> +       /* we don't repeat the check under barn->lock as it's not critica=
l */
> +       if (!ignore_limit && data_race(barn->nr_full) >=3D MAX_FULL_SHEAV=
ES)
> +               return -E2BIG;
>
>         spin_lock_irqsave(&barn->lock, flags);
>
> -       if (!ignore_limit && barn->nr_full >=3D MAX_FULL_SHEAVES) {
> -               ret =3D -E2BIG;
> -       } else {
> -               list_add(&sheaf->barn_list, &barn->sheaves_full);
> -               barn->nr_full++;
> -       }
> +       list_add(&sheaf->barn_list, &barn->sheaves_full);
> +       barn->nr_full++;
>
>         spin_unlock_irqrestore(&barn->lock, flags);
> -       return ret;
> +       return 0;
>  }
>
>  static struct slab_sheaf *barn_get_full_or_empty_sheaf(struct node_barn =
*barn)
> @@ -2742,6 +2743,9 @@ static struct slab_sheaf *barn_get_full_or_empty_sh=
eaf(struct node_barn *barn)
>         struct slab_sheaf *sheaf =3D NULL;
>         unsigned long flags;
>
> +       if (!data_race(barn->nr_full) && !data_race(barn->nr_empty))
> +               return NULL;
> +
>         spin_lock_irqsave(&barn->lock, flags);
>
>         if (barn->nr_full) {
> @@ -2772,9 +2776,12 @@ barn_replace_empty_sheaf(struct node_barn *barn, s=
truct slab_sheaf *empty)
>         struct slab_sheaf *full =3D NULL;
>         unsigned long flags;
>
> +       if (!data_race(barn->nr_full))
> +               return NULL;
> +
>         spin_lock_irqsave(&barn->lock, flags);
>
> -       if (barn->nr_full) {
> +       if (likely(barn->nr_full)) {
>                 full =3D list_first_entry(&barn->sheaves_full, struct sla=
b_sheaf,
>                                         barn_list);
>                 list_del(&full->barn_list);
> @@ -2797,19 +2804,23 @@ barn_replace_full_sheaf(struct node_barn *barn, s=
truct slab_sheaf *full)
>         struct slab_sheaf *empty;
>         unsigned long flags;
>
> +       /* we don't repeat this check under barn->lock as it's not critic=
al */
> +       if (data_race(barn->nr_full) >=3D MAX_FULL_SHEAVES)
> +               return ERR_PTR(-E2BIG);
> +       if (!data_race(barn->nr_empty))
> +               return ERR_PTR(-ENOMEM);
> +
>         spin_lock_irqsave(&barn->lock, flags);
>
> -       if (barn->nr_full >=3D MAX_FULL_SHEAVES) {
> -               empty =3D ERR_PTR(-E2BIG);
> -       } else if (!barn->nr_empty) {
> -               empty =3D ERR_PTR(-ENOMEM);
> -       } else {
> +       if (likely(barn->nr_empty)) {
>                 empty =3D list_first_entry(&barn->sheaves_empty, struct s=
lab_sheaf,
>                                          barn_list);
>                 list_del(&empty->barn_list);
>                 list_add(&full->barn_list, &barn->sheaves_full);
>                 barn->nr_empty--;
>                 barn->nr_full++;
> +       } else {
> +               empty =3D ERR_PTR(-ENOMEM);
>         }
>
>         spin_unlock_irqrestore(&barn->lock, flags);
>
> --
> 2.48.1
>

