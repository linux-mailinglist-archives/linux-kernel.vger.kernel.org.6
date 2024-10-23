Return-Path: <linux-kernel+bounces-378136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D259ACBD6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265DA2820F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8048A1BB6BA;
	Wed, 23 Oct 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDhj2n+R"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5331B86F7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692081; cv=none; b=hEqdWVFEBX5SnsHAYaAG88h5inRQV/eUt9ihaz8jNw2D0giENMbSGcgY+4KhwfR2zxRqPLYByhpy4BQp15f0EQykHELy2P/dr2PMg/n32hgRCRI9sAn9qXqQuOaWgZytzd5+zq13f3VPuaLiFrr1lO3bFh08eizDIUzQrU8Gg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692081; c=relaxed/simple;
	bh=HGYucI6JjzhbfppjoegfJ47bgrJ3rnedYlwtPw09Plw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d87CbgGX2S4T7P5MQxJRb/KTRcZEb42+n9tbws3ardqEnYFi64zhp1gfLSJzUCXnDjnONW9G2660vUSUV6NdfuX4utE9yKmADk7s1kaL8wo6O5fjPWE2E4cPS82NMstMdtIH8EdfFIRZTbaiMSr6rfQ5J6rsmXijhjIgsS0uvHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDhj2n+R; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so49317715e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692076; x=1730296876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfi+jVS09oVwJMiUCNMkt7OYW0ltkQ/uQFM4w2BHFdo=;
        b=WDhj2n+RQytpvoTZdlov00nvsLFGzirL2oYnTUiW0CS+KTqEfCCjWAN7TkCV+Ezls8
         3Sa5+wf48GeDIWMDrkjPSv7sMWuNUbWWLRJP8H14koCU4/fHp1UgkoMCHZwxcqGlf1HA
         OrtjYMzJ2dJxn5t0wZAT5Ude+vL7G96uQLcxRgSL40tnqh8+YxM315SF3MExEHdN/8tV
         fKNKhRizm5fcUo9JtoCpo/9o9oA+tJjUCoazPqiKVIrw255O6K8gx9VeS+qS79EV2Jpx
         z4jbv+SyK9EEt/6sDdZfwv7HSFenH+oSsg7Tqb8tb3VZLse3z7M43HTvqT2GrROD1Zdj
         e8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692076; x=1730296876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfi+jVS09oVwJMiUCNMkt7OYW0ltkQ/uQFM4w2BHFdo=;
        b=trGz5YsCz2ucqb4WTmJstPRJcsIVfZHKna31DSe22V9RSEz8xUw7Wm9bgPd2H8Pu2w
         JEEl4KsN7vTC0RbnSFaCFuO7WncSodQt+oJsrtrCYCBmRNkfCMSaM9ru+GERfpZ0boRs
         pf3T5inkrcqIVTcxRqhfN8Q4p2xCBVldqKLN+Bv1UYoxDXpnZem7Qu5qwta64GSSy4y4
         7lMOZGoB/dTa93NqL4cuF5YbnJGMr323bKTIh111PFkbYASgOaq8kjaMcDvMsB4uI9NT
         ovyqPCPE3RT4m5VEGT+gnm6eqdpTtqA68ynxos5TVvluWyKkywiCzPgYduABKrCLrm4k
         nuYg==
X-Forwarded-Encrypted: i=1; AJvYcCVpEPxtFJg0E+PHIvVcaNfV/zWFLrIqoylvFacNwKuI4/i6c1RQjgPEFvaWUKvbYPeXV0rJ3sJ3tZ9wwZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPyphX2PwSyP8PU8LKD91NruHSmZXhrdty4TcQFNqgcUP7tJHy
	FgKdFdGFKXWXMg0Nu3sH2t/wb3EPWHDZiq1OUP/a5JftvJ95E3q+qn89xhl01UHs6vitIsCnOF7
	1/Py9utUyto/H6cHlj54mYSZoYpQ=
X-Google-Smtp-Source: AGHT+IGYQgFJi88cT+sLLpvBs7Z8AygSXnU/8MiScBFreuDqzB0RPbMIsUiLH8TZL/I5wIkQQotJR7HlUpVQmCiBoqw=
X-Received: by 2002:a05:600c:468a:b0:428:f0c2:ef4a with SMTP id
 5b1f17b1804b1-431841440b5mr24527045e9.13.1729692076156; Wed, 23 Oct 2024
 07:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023132734.62385-1-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20241023132734.62385-1-dominik.karol.piatkowski@protonmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 23 Oct 2024 16:01:04 +0200
Message-ID: <CA+fCnZfW_7aFR+q-0=umaP8wYEqDU4im0vE5vkqu74fBbgVvVA@mail.gmail.com>
Subject: Re: [PATCH] kasan: Fix typo in kasan_poison_new_object documentation
To: =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 3:28=E2=80=AFPM Dominik Karol Pi=C4=85tkowski
<dominik.karol.piatkowski@protonmail.com> wrote:
>
> Fix presumed copy-paste typo of kasan_poison_new_object documentation
> referring to kasan_unpoison_new_object.
>
> No functional changes.
>
> Fixes: 1ce9a0523938 ("kasan: rename and document kasan_(un)poison_object_=
data")
> Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@pr=
otonmail.com>
> ---
>  include/linux/kasan.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 6bbfc8aa42e8..56465af31044 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -153,7 +153,7 @@ static __always_inline void kasan_unpoison_new_object=
(struct kmem_cache *cache,
>
>  void __kasan_poison_new_object(struct kmem_cache *cache, void *object);
>  /**
> - * kasan_unpoison_new_object - Repoison a new slab object.
> + * kasan_poison_new_object - Repoison a new slab object.
>   * @cache: Cache the object belong to.
>   * @object: Pointer to the object.
>   *
> --
> 2.34.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

