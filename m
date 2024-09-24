Return-Path: <linux-kernel+bounces-336707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E85983F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9561A1C22723
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B388C1482F6;
	Tue, 24 Sep 2024 07:47:25 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857611CBD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727164045; cv=none; b=kvScmYzOrMDo7KO+Ha1L+elzP8ziSjUZUDLPpi/nuNuHELyLgnzkKuXk709vWOHgFF7E1nMfhbRznA4CPhWE+hGv0sylI5d/J22ChumCKCUO1CtkgNGYbf9MITqgN0IMbq46MGuz+8Bmm39OHabFGH+mt/PAULEW7ov16/nKu+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727164045; c=relaxed/simple;
	bh=lUiC8pPeAdjEEhjbLYsIogH+t4nNjZ104qOhbL4yMYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dM0zF9TYAf1JkvFfZAvT7jVpAbYaGH5UNLi0aHteQ08CgPspcdirED7U9Ha6dIYZdwwDRlqiNl52MWmaO7CJerBaGHOyv0DzHyggad+LO8i4elzjeZZDTAXEFKj0qFV1yug5V9u1pn4AmRy8dq/XKUzzlE0Al94kh2JNIR6WtdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6db67400db4so46880177b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727164041; x=1727768841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNw2DhrwTm2AW4f1N12CXbt6M5JazA1VutRgcAZxBHM=;
        b=p78ArZR0YJkZZrPwOS/Vrw5hcBEZbCVpA9Qg5f5nnRhjKUswfjQkSoxYyIGJFBcP57
         cGV4LJePhnRXrheZXlPtLXy4DaoUX4OvXIgdeLDVLHKPyirzPexcBvNQF1Duw5sOg3rv
         s5YxhuyG8I1igyF6m1x9fl9NBR9TTr2iX55wXcuObm21eq7/7uYKWT88wg8K4Ne9q+oC
         KX73X9pBMiEXIpLjBbLv2Vdz48XAFLv7FDXmchELNtvlUE7Mza5YqjVyvqTxahdzy2Tp
         1fHmlthv3AKK3tQ/m+XjoAirNNmC0TQbzxIU6k7KeGL522MTSTNNCYSQLzon00O3a0FC
         ZUBg==
X-Forwarded-Encrypted: i=1; AJvYcCXcIhbCN2+wndSj6u46xKDxdcWatBXZ6qwTQT1U+KY8+AiIqYj5VbMWDuCk64Aa2q8c8MwKoTPmyQJliEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAxTW4IMKeYeDEkXyRCuecGQIH04z4JFSEpSnRJ68kdxXrp8g4
	UC8g6AWWkbd84JWKVcGbUmbZuhThF5uHJMHBeCI37Ue4a+DIpQMUZmAowZJQ
X-Google-Smtp-Source: AGHT+IHRPe8tdQmHMxA7Jm0Mh89t9S11hh6n6+QLpPYPiEVF31VI+7fLxiAwnsHAIrdBfhjNgzFBRg==
X-Received: by 2002:a05:690c:d8d:b0:6e2:636:d9ba with SMTP id 00721157ae682-6e20636dd0emr28744347b3.3.1727164041407;
        Tue, 24 Sep 2024 00:47:21 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d06eb02sm1675007b3.70.2024.09.24.00.47.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 00:47:20 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6c3f1939d12so39866917b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:47:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKBVNKqsxMYcfWdOoYSDFxi5xqbvcd/wfwxjshFtzCToBjxtbic5FHiOb+e1tPWdyTjDt+4x5A0r9oWHE=@vger.kernel.org
X-Received: by 2002:a05:690c:6189:b0:6d4:b774:e503 with SMTP id
 00721157ae682-6dff2b291a6mr113715397b3.41.1727164040274; Tue, 24 Sep 2024
 00:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923235617.1584056-1-linux@roeck-us.net>
In-Reply-To: <20240923235617.1584056-1-linux@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Sep 2024 09:47:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUkMWjzT_vT3E7yLgopPWWP=BS_G8Ui22M_b8sZaCWSxQ@mail.gmail.com>
Message-ID: <CAMuHMdUkMWjzT_vT3E7yLgopPWWP=BS_G8Ui22M_b8sZaCWSxQ@mail.gmail.com>
Subject: Re: [PATCH v2] m68k: Define NR_CPUS
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi G=C3=BCnter,

Thanks for your patch!

On Tue, Sep 24, 2024 at 1:56=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
> SPLIT_PTE_PTLOCKS depends on "NR_CPUS >=3D 4". Unfortunately, that evalua=
tes
> to true if there is no NR_CPUS configuration option. This results in
> CONFIG_SPLIT_PTE_PTLOCKS=3Dy for mac_defconfig. This in turn causes the m=
68k
> "q800" and "virt" machines to crash in qemu if debugging options are
> enabled.
>
> Making CONFIG_SPLIT_PTE_PTLOCKS dependent on the existence of NR_CPUS
> does not work since a dependency on the existence of a numeric Kconfig
> entry always evaluates to false. Example:
>
> config HAVE_NO_NR_CPUS
>        def_bool y
>        depends on !NR_CPUS
>
> After adding this to a Kconfig file, "make defconfig" includes:
> $ grep NR_CPUS .config
> CONFIG_NR_CPUS=3D64
> CONFIG_HAVE_NO_NR_CPUS=3Dy
>
> Define NR_CPUS for m68k instead to solve the problem.
>
> Fixes: 394290cba966 ("mm: turn USE_SPLIT_PTE_PTLOCKS / USE_SPLIT_PTE_PTLO=
CKS into Kconfig options")
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: David Hildenbrand <david@redhat.com>

I think it's a bit premature to add David's tag, as v2 is completely
different from v1.

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Instead of trying to make SPLIT_PTE_PTLOCKS depend on the
>     existence of NR_CPUS, define NR_CPUS for m68k.
>
> v1: https://lore.kernel.org/lkml/202409240546.SJwj9tUj-lkp@intel.com/T/#t

I replied on v1 why I think this is not the right solution.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

