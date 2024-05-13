Return-Path: <linux-kernel+bounces-178007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABB48C475D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB40B1F241D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC7E45016;
	Mon, 13 May 2024 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NApWZgbi"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B7446AE
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715627143; cv=none; b=PqJ3bZLM0tQyOysmE/gkemSO/o5WsSdcE0/qOd8uiKOm+Rt0f92uRezQ4SeQAmkWwQ6eV5kP/U5pTa9oFxj6pOeTnQm0SEmItdIKwgM6UJgZTjhWyLJoNkDRlJLKrI854VLgk+OaFsRvvp+urAWLVa4atMQT6O5wnUKt4fuyvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715627143; c=relaxed/simple;
	bh=RCInyTf7dR85Mi3yye7ngyof3uXWDGHs5UvX/c5fJTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEBZSbHyawBJ+IYG3ycU5/JAPV2iIj54zPeZzg8Fx31BtHsoRjIOgxlUTQc7kVR1QnRxJPh18M5jVFrg4u5D9475OQvbFbGbbLK/xU5/QZrztq5Jy8QCHCwicHNIpnESQPUcMxqs4VtbjDJLsN2BGHfJtpNI0Fc5+I+GoeU2chA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NApWZgbi; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a64db066so1199065066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715627140; x=1716231940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHVX7QXs7ZSa+q8I5S8KqDQd8wCAFFUEKhPAoKqf6Lk=;
        b=NApWZgbi76AUB6Xriz5z9ICBmOqPT4l+ZFDfLiw2qKNkNuzjTy1VPyw2lOALErRlff
         VEQ2P7qGjpVaGpxeYOkMT7gkry8zmtwqlyngoyvYi+6Cyu1ZssNIWRcxS3G6YCk56xaK
         edHy2CKA77fgis4FgHfmoDn3YRrNxq1ticc+rqpGdE0Q4MuUc/XfqgcmzJl8D1klep9s
         msNst9Ef5jWGqZRaUBJATwVlO0rEZ6ae17bC/6qfZSl50qcEoPuxYg7LA67ypUu2ZrR3
         VIYTOGIYnXrSi/fS1qdkDoQZHvrMl8d3ahv8vAUVGUZuL2a/v5gPqWXvpLafErB+iRVn
         /o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715627140; x=1716231940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHVX7QXs7ZSa+q8I5S8KqDQd8wCAFFUEKhPAoKqf6Lk=;
        b=JyH1FZ7BaxEXEC8rFYgFkVtknYJFeYEnTyM/DRt1OJOsDJLy6cw9M4NgDt4o2jeHlj
         94KFmHohCddEDZC1I3RvZgpV6wxR1qHllrUEtnGDTLIkvaCap1arrv2LtLn4gOXGuONV
         MUmtkklZMfCQGuQjyv1WsTRbAKGDvVDW5KbA0i1qiCj03qSc0vykQ+vPI55G5vrqUv8C
         /XUzY/Utt+jyt2eAg/4BPEG8JS3t1Yze9iq8CdEyDE0NXaNHMMw7E0bhaNUef2UH4XXj
         6Idak0mwglNNai/KHUzaJnuod83w0ZU4OTGAWaeLayHH7qCjjlP3F5v4H9WPBUwa50Nn
         xhow==
X-Forwarded-Encrypted: i=1; AJvYcCXbS/t3hhNUeex8cXi+SZZBmBY0nYnmHd0fo1JvaUUrcNBKb5SIDZHWThdxoaF9XmI+0FzZvRFqTsBHIy8xsNd4xPoHbWtIvfzCx7Nt
X-Gm-Message-State: AOJu0YxAW2an5s2gOmHqOigsLiDTxevchHFoZmzzINBQi/eC9vkx6SB8
	EX8qRCAa4u3vS49iv02pJjekaBrwQDs9+fJLdLGhKdfb3z0WWXQeQubzTrWwpw+ciIhEyTAPclW
	yQtpqU8YJzr9E0Vv1P0EVYgXYHkc=
X-Google-Smtp-Source: AGHT+IH4rmR4xsSXCatjltSOvwUNkDDuHMcxrgtq9uAeiRNRjJeeJdSe85j2T7CEAjDXKJvEXbnP/y5oVYem1LsioUw=
X-Received: by 2002:a17:907:3f9f:b0:a59:cd46:fe89 with SMTP id
 a640c23a62f3a-a5a2d665690mr830382166b.59.1715627140010; Mon, 13 May 2024
 12:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511144436754EiKfJM4xjMSTyCbEExwcL@zte.com.cn>
In-Reply-To: <20240511144436754EiKfJM4xjMSTyCbEExwcL@zte.com.cn>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 13 May 2024 13:05:28 -0600
Message-ID: <CAHbLzkqg=+Dq40-He5ZBCnzrXEJaBUfXtb2jjBoDKERpM-C07w@mail.gmail.com>
Subject: Re:  [PATCH linux-next] mm/huge_memory: mark racy access on huge_anon_orders_always
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 12:44=E2=80=AFAM <xu.xin16@zte.com.cn> wrote:
>
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> huge_anon_orders_always and huge_anon_orders_always are accessed
> lockless, it is better to use the READ_ONCE() wrapper.
> This is not fixing any visible bug, hopefully this can cease some
> KCSAN complains in the future.

A little bit confused here. Did you see complaints from KCSAN?

> Also do that for huge_anon_orders_madvise.
>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>  include/linux/huge_mm.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index de0c89105076..6573430ea600 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -122,8 +122,8 @@ static inline bool hugepage_flags_enabled(void)
>          * So we don't need to look at huge_anon_orders_inherit.
>          */
>         return hugepage_global_enabled() ||
> -              huge_anon_orders_always ||
> -              huge_anon_orders_madvise;
> +                       READ_ONCE(huge_anon_orders_always) ||
> +                       READ_ONCE(huge_anon_orders_madvise);
>  }
>
>  static inline int highest_order(unsigned long orders)
> --
> 2.15.2

