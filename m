Return-Path: <linux-kernel+bounces-278873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D6194B5DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43AE31F230F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BAC81751;
	Thu,  8 Aug 2024 04:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNgUgQbI"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB99479
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 04:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723091026; cv=none; b=cBAYVVjqfTA6AmiiVSwLolJsNoFt4ERnrpR5YELN4mhVuCkIN8LDNW/tODC4WNli9RWr2CKcEJcAie/mK7KVGhH6OI+Burd1/679/qX6s9YCv36Y+kwH55EhErk6h7luiPjvrGaqX9pp8sOdyEIJG3vY77SccJ2aazbs0DMZNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723091026; c=relaxed/simple;
	bh=SWfYIM3OIuhRhP+HQWluSdhILpZhBQenaM/ijW1wCm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6UVPwChcC0IkcI9j0MRu0TpCBnI6i8WUAvXHfniz9omXARsDsWo0OZCdInuMr9Yl5/komC0QZDqq2eVS0BwdkgQZTGy1943PXIu564s2yX/VlX+Wj4Z0DRGXA/IpdrVFDkV40SgYEwLcZDf+ub2ys9h/K6oh5fs2zp8okzDe5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNgUgQbI; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cf11b91813so463217a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 21:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723091024; x=1723695824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=It0jnQvSTnsNl9m1sw0iiNcmUDMRTYEU99kRgSwwlW4=;
        b=XNgUgQbIUQCz1zt7D7PpPHijypUTS1niVuBIYOUO/L6mlG6MpUhmKaZsYIxnjdR7vp
         sZK5IAlpo7a32xQC/ZzpG9NZmxoHHchKl9v85MSbjC2fUgPU0m6zGCKBbSDmHLW/VXep
         T0s62YM3elw/cx0fBXtgAq7nK2qr8VUpyxpdlLZV5PkwJHjwbUfBhDFdJq4T64+qg6rU
         V37Mh3AXPH5mofEVF/Lpqa2x5gFhLV2jNslWTB6Tn/fbNeUcANVIRiyD25a1EQGuHTZo
         tP8DwelJodNpWBc63dPCTsGNT0pb05/hf9WmJZzLdQbMxV5HXYbQ2X9AMNL7RjMsQHFL
         ph1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723091024; x=1723695824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=It0jnQvSTnsNl9m1sw0iiNcmUDMRTYEU99kRgSwwlW4=;
        b=VBr+bkscVFH2+QZDif5mvgUSS7sWc5SI0W6EOSJI41t0/tHdFWZZx/Pg4Zg2Iao3GM
         D6qA9NdkzA/98Jr50FkcGj98Xwg21FI7yudJYieuvMYB+amxIsH3R2kJT4Qwq57UpfPh
         iDPcgC2ndyx8YiYalngKBqbcxjXYIOGLKghugq4Vc/1GtXpi/OjQ4LkEg3xYYXGwYgct
         vfIra9NMcTzFJ+qnIHPdYewm7K7stTlC9my72up5Wzy804T1kkQbXiRI7RTPG9AALpac
         4LKn7Y68eTuERJyTLIdSGyruECqV3W1YJDqMwqSwIbiqwYMBOrIIatMFHYl9ieUFQl0m
         2VUQ==
X-Gm-Message-State: AOJu0YzGL8xLP3nXnQGvy4yUcLHbFVtIhZpgwtsqC5blx2AFOlzkRJrI
	cjIf3k+zZlVXaSNU73pvHxQ/gCb6QjhyAlWexSThsoBFj6yTiCd7CEfYvsDcq1BNksuGH4pVT0v
	P5o7xKHJGRDcgMkCC9tC3qwJq6Bg=
X-Google-Smtp-Source: AGHT+IFAhAAzjU4QhlzFjI5wM2xeNDvAvz1TlNmrkToL+qqYYLdk3jc4X+HkPZDquAJxEEqNSsU07UEVDRx26b8Qsxo=
X-Received: by 2002:a17:90b:38ca:b0:2c9:a3d4:f044 with SMTP id
 98e67ed59e1d1-2d1c33b5ce2mr744052a91.11.1723091023969; Wed, 07 Aug 2024
 21:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802211850.1211737-1-tj@kernel.org> <20240802211850.1211737-2-tj@kernel.org>
In-Reply-To: <20240802211850.1211737-2-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Thu, 8 Aug 2024 12:23:32 +0800
Message-ID: <CAJhGHyAv_jwMxFoU6Wa2epfCQK_0LsAkBhFwkGX-ZT-9tAdwYg@mail.gmail.com>
Subject: Re: [PATCH 1/4] workqueue: Make wq_affn_dfl_set() use wq_online_cpumask
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

On Sat, Aug 3, 2024 at 5:18=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Other unbound pwq update paths are already using wq_online_cpumask which =
is
> protected by wq_pool_mutex. Make wq_affn_dfl_set() to use wq_online_cpuma=
sk
> too for synchronization and consistency.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/workqueue.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index d56bd2277e58..6571e1f3c835 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -6909,18 +6909,16 @@ static int wq_affn_dfl_set(const char *val, const=
 struct kernel_param *kp)
>         if (affn =3D=3D WQ_AFFN_DFL)
>                 return -EINVAL;
>
> -       cpus_read_lock();
>         mutex_lock(&wq_pool_mutex);
>
>         wq_affn_dfl =3D affn;
>
>         list_for_each_entry(wq, &workqueues, list) {
> -               for_each_online_cpu(cpu)
> +               for_each_cpu(cpu, wq_online_cpumask)
>                         unbound_wq_update_pwq(wq, cpu);
>         }

I think it should be for_each_possible_cpu() for updating the pwqs.

For all the 4 patches:

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Thanks
Lai

