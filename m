Return-Path: <linux-kernel+bounces-432576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF859E4D2B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 06:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FA518809FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 05:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D389192B75;
	Thu,  5 Dec 2024 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw+C/6iM"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B152107
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733374827; cv=none; b=GwcZI993iHV2YsmsBBsgrrQWPNyTsLtbtX5XYxhw9t+Ybsorhz+HhenGnOXEeSdIof+hzeMF5GrOeLwW6ZqCvFvI4zIaoWlDHsknrBGzsLR62UBu5/v9HsoOOWQATq2sqmHeqZ97OMj29EVY2+cXbnacvy94tJgkDgS8da2HdeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733374827; c=relaxed/simple;
	bh=XpNB0mtXdvNu/q4sT5r0g0WVQJhd2G/gIaVobzLYJmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpDmICq04zJZWQ1WhHquF2lVTqFPfY0DDE9R9ZVMxoMIW/vLKhLdOW77sOTkUkY7DNx5gyNX8pVQW1+/Qw58D6uoYEPqDxEr7sF8RQAG2UVRimUMXEXzsmL7sHb+UdX9eGBoK187FkK58mnsMSnWjT1fIHKAPBjRqaNZZoRm89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw+C/6iM; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-84ff43e87cbso132555241.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 21:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733374825; x=1733979625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzsRhBq8BhSQFnCo4YskzWswq/XF5Fd+zdWe29F6F2s=;
        b=Bw+C/6iMpYhBbP09dcqBhLlLEw2PyVYjeL+2FSQ4K/muB3orSveHU5oQxSJ/WqJQVM
         etG2qLxpfihSJAlInyKtbndx0lnpJcfUlzK6cjIrgw8D4yOl3Y++/ZFMKdaeR8b9N7pQ
         yg/wY8pCwm1BSOsBWDB4dxggxZ+RuVzlvHWw8ttY7067ZE5ve5deapaYBdO3B5qya7H+
         srLXaFnttoAPq8/Rx5r27DxDFTld0xw6/47g1dCLcW8WZlPxOVWMDm49O5eTc1FFBrSf
         K0ujeSJHB6wUKTftC7aYNsQ47wi6k8kWByZ0VOfff4PpSXIoS6d79k4mhC/773ehILMh
         6v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733374825; x=1733979625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzsRhBq8BhSQFnCo4YskzWswq/XF5Fd+zdWe29F6F2s=;
        b=twbyxkbg/4l+gqtYreru2N7LdPfFuNuoeiSWqfEFfJ7OkXmrp4IAdntZHtIIPBp8n5
         mo6pWiu/0E8mKaphRMrBGv+SRoT2rPm7NJPIl6FowU6r6S0K6nbOsx4IG2RFL/33uEDa
         S2b8L2cPkIQNSj19sxYLHl7mR8cvSX7DLWwzoxmPEJh2dvaIMdsMYOQuZDaR0ZsmxmB3
         RCBxoBIi+G871TZ7JJcidLfSz85ChpIeJLY8xoAXp+gvPTSuGuHYspI1iTIZIjxCXONG
         kisPAEvR/GdZPsFxRSToBeObAu64HBJJ0GHTDbOM1wAOqxA6L3pk3vBA5A/3gZ+yYy8M
         avDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNB4YMbwmLzq3PDOHqj8gZKjaWlFaTnIWXKxQuJCK0RjIln5E/+cl3o2egoz6S2z5066B+HpezO71+J7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwLx+GNnUre9EYde/jgeqyauyck6Ze0ARhW3Sm/L8UmuvIFr8s
	dR9JYkhQUFxmRKo1e+DcZ0qZOJGRquFTbxj5i0zXaG3K+FuTGJXn4+4M+jFaHr//B5YO9oOUI82
	eQfPKcPojtgPCfnfFTz8+ix+gc4o=
X-Gm-Gg: ASbGncvd35ttlaHgf34aGKYgM41+ztsFlGOuGnXt4IRXSYsUqwR0lg6DPf8/5ND0trL
	GxZVINQsrPpN1NsYAWd+96h0epdWx11ZTypA6TTVKj8bgJ2Ba9F/QrbmrrVammo+C5w==
X-Google-Smtp-Source: AGHT+IGf5+oZBFNrebFdiC214ro7YEnLr3lIwDKyEMoTQMyP8/SQ0CiENoy9aJg5qpCiMPkTRcp0bSXlqrMZ7XD2dTQ=
X-Received: by 2002:a05:6102:50ab:b0:4af:ba51:a25f with SMTP id
 ada2fe7eead31-4afba51a30amr1826292137.20.1733374825081; Wed, 04 Dec 2024
 21:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5e191ae02c2ab63c70cdf44877fe14fc69f5ae8.1733368611.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <d5e191ae02c2ab63c70cdf44877fe14fc69f5ae8.1733368611.git.baolin.wang@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 5 Dec 2024 18:00:14 +1300
Message-ID: <CAGsJ_4x53qO1r=6=gjkZQWvc2xYR8V-t4d3t4V4o9qFobqW2-Q@mail.gmail.com>
Subject: Re: [PATCH] mm: migrate: drop redundant anonymous statistics for file
 folios migration
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ying.huang@linux.alibaba.com, 
	ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 4:54=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Commit 5d65c8d758f2 ("mm: count the number of anonymous THPs per size") a=
dds
> a new anonymous counter per THP size, however, when folio_mapping() is no=
t NULL
> during folio migration, it means this is not an anonymous folio, so remov=
e the
> redundant anonymous statistics in this case.

why? Are you sure anon folios won't call __folio_migrate_mapping()?
folio->mapping is PAGE_MAPPING_ANON for anon folios.

static __always_inline bool folio_test_anon(const struct folio *folio)
{
        return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) !=3D 0;
}

>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e9e00d1d1d19..d7fdfdd23fd0 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -523,8 +523,6 @@ static int __folio_migrate_mapping(struct address_spa=
ce *mapping,
>          */
>         newfolio->index =3D folio->index;
>         newfolio->mapping =3D folio->mapping;
> -       if (folio_test_anon(folio) && folio_test_large(folio))
> -               mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>         folio_ref_add(newfolio, nr); /* add cache reference */
>         if (folio_test_swapbacked(folio)) {
>                 __folio_set_swapbacked(newfolio);
> --
> 2.39.3
>

Thanks
Barry

