Return-Path: <linux-kernel+bounces-168519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8858BB980
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 06:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 921D7B22F60
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9248811711;
	Sat,  4 May 2024 04:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4xLK2Yx"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880BFBA42
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 04:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714798044; cv=none; b=rdUT5tSHwB9N2UsCMYz52WUD7K2+GP3QTiPR8gzP4GxIAkcsTFiJSAZyxS4VVfvI/qVkHC8ywS+gMaO7Ibj+j+oCbRjkwMxqfoUJC8VrrdKdxtpLmKTWQtdyR4chjPIKxv9+YXJ2dP7v9S1T7RIeqvgY1k1SxfQ9b+bEhOuxCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714798044; c=relaxed/simple;
	bh=vONpxGkKrgomZ6pmGDAeB+1fSP0EXFfND4CmLyAS5B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pg+xE5ZKXBhuIxyWwaPydW9U2O+9sqh3gvdh+c0am8NJbtyLxruRKxtOKGPcS2CSgMfN0a03K6bBeR5XlgcU8uUUA3YBbGXjBlo36vUIw6Oty/9vPMxUJjJgd5t3/J/ttJaIzryvaeUzmYtQeC3EMN5WX6h0rIbA3YXqjrhvq3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4xLK2Yx; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43a317135a5so2428181cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 21:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714798042; x=1715402842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUjw08Dptdko0n6fmP/rOSW9rqkNSjLddnMoD7BoCiE=;
        b=O4xLK2YxIE7FCiCsBuyjbPqISPjm1CiLorZSkgjBgliAUT2EbekWt2O7mnXuxWtBxY
         WWzEdqtFlyVMsaleekPns5eHRuqvGEwUIwqlpFO/T2/muVPKTiLZ1/UI78u9mISiuVHc
         15IBw14vQ92hF+16jz5VD5pyLozkoxTU5b8C/hUPUZ3orzNlyJJPzNqlpIv6LlY3lR5Y
         2NcrUv+FDGiBA8VB8JIgp9iZODa4yqDZhQGAq/lW+ZFPBceitflu+bPEtHkVlKpIFF4g
         g2A6bM/u5c1lnKgzi4/ThtuT+9wUJs9JSQleGeP+fJtKxV2ddgBDJaBjKuFjHTmRVgi4
         qNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714798042; x=1715402842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUjw08Dptdko0n6fmP/rOSW9rqkNSjLddnMoD7BoCiE=;
        b=kKmIfL0u1BVVsC1dWauNh6bP5WB70Jobzb0zF4d824nXWyeHqUE2sZef4aqdrJM3hS
         nRGEYMPQLnELDE5fBe75uzyp4DtJFhJWfjUoe/OKp1zt835IHu/v+kvh5m/SrxIcSrLa
         6B5KMQhhH174YFYQE53SFesnGGcemoXM/4ywg7pYbaeFmyFL2zeM7xM1syQSYLkL+kFp
         7kejMsM85bsDlLyfAQgVjzHkiP0lMg+00fkGjOPatuB15AiqpjMHIzLdKVaDDDzCpjo8
         jgxXSQ8At5q3cqMs48JkmWfJ+WVThejpi8Z/YnQZtZBppQBV4v+wJ/Kq8gybZE2ZN4Hj
         bA6g==
X-Gm-Message-State: AOJu0YwFHlWklnHvSyXHG5s9nyQqXjGV73CCuqEJJ8j/mREcaItiGvSM
	c8Co523omj3RvUBgpm2zdbtsz8ixyJBOm1H8mQ62iJAEN5YLYze6gwYcpXvguWQ53cM4jjO4S6f
	vVpBJfPMqpj+811Y1A41ZN267FW0=
X-Google-Smtp-Source: AGHT+IHrD6N4vV5SpoNuG45uUxmKfgmnP2BU2PFr+zeMg8MGxlsJ2hRoAk7/H87Vb079kPsTM5oHlonlLGoayle3T1c=
X-Received: by 2002:a05:622a:298e:b0:43a:357c:322a with SMTP id
 hd14-20020a05622a298e00b0043a357c322amr14260508qtb.34.1714798042326; Fri, 03
 May 2024 21:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501195116.62669-1-ppbuk5246@gmail.com>
In-Reply-To: <20240501195116.62669-1-ppbuk5246@gmail.com>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Sat, 4 May 2024 05:47:11 +0100
Message-ID: <CAM7-yPQMDZ9SZPVQExCd2bqTRTzoBVwQUSgrXp=1WSDDOCajag@mail.gmail.com>
Subject: Re: [PATCH] time/timgr: Fix wrong reference when level 0 group
 allocation failed
To: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping

On Wed, May 1, 2024 at 8:51=E2=80=AFPM Levi Yun <ppbuk5246@gmail.com> wrote=
:
>
> When tmigr_setup_groups() failed level 0 group allocation,
> next do while loop refers wrong local stack array location.
>
> Changing group init do while loop with while loop to fix this problem.
>
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>  kernel/time/timer_migration.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.=
c
> index ccba875d2234..84413114db5c 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -1596,7 +1596,7 @@ static int tmigr_setup_groups(unsigned int cpu, uns=
igned int node)
>
>         } while (i < tmigr_hierarchy_levels);
>
> -       do {
> +       while (i > 0) {
>                 group =3D stack[--i];
>
>                 if (err < 0) {
> @@ -1645,7 +1645,7 @@ static int tmigr_setup_groups(unsigned int cpu, uns=
igned int node)
>                                 tmigr_connect_child_parent(child, group);
>                         }
>                 }
> -       } while (i > 0);
> +       }
>
>         kfree(stack);
>
> --
> 2.41.0
>

