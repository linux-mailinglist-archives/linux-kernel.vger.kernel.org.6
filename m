Return-Path: <linux-kernel+bounces-335878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C94D097EBF0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE321F21D34
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3A199934;
	Mon, 23 Sep 2024 12:58:51 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5094197A83
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096331; cv=none; b=a61McGrB46tX60QlBC5ngoU+z+HFf1h9ELZJ5sLAcMeTxdCCvmlQ7i+2RtDO6CD50lV+qMtDVU9JoHrrqCqddxTGcPSB026kCSgegphaBN5W9GrJBx6ssdA9SjOdzaadROwR8DfpuqkekQjOZEUn+9xMApfrlEs5rTtdVUlu1sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096331; c=relaxed/simple;
	bh=xCiDweo3hzGkUbqUZAJbOYJZGsITZvPusvHiOSVXdjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efjac3GTvjFrlHSp8o/7Esc33GEuq2/g4t8h3RwdwS8tFlU7RhoWPw75ABNcOBiLDFD4mKHwzw+hm7cAqEfizDUqJr32YMSx3lIAEM4PXr+qtwT3XPrVeNdxWSvf1UG3gDAS8QqXtiPxZ3e1JJBSEepI1xnhFlvrXZ/pTpSDYXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6d6a3ab427aso30874287b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727096326; x=1727701126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaLCSQwMnL5yQlJ46yOm8AzTT+2OU1roRxi7npJUrfA=;
        b=vOiuwNRcBYZjSgzob/aDNPcMr6avI9SkeOa5sqAJi1CJb9sr0nLhCH6Yb6+E3VLuGn
         x1GYqvbaM3Mp/u62x2NVyx4hbwEH8RVuOyxzxIcwE8IljZ7dZ6YpvwupozbgIhEbiW+X
         KYsDDp2y4vesf6pxA+va2OsWewZRgfdy6oAKHdH4tA5HLFt1EqP2npkYvCsqJbv0d8og
         kQ5ajOfWULiOpZ7UeI6RWRah0Qfa1uSWfRf9aI2nQuRvt1dBXLa97JfBQZCBI6Al4m5n
         PE3qlSR01heUd5o1Fx7ON07SXDEVqmY3Cn3a5k7nO+XsdjVOJGSirzgoE+KmtXhW/kQa
         9RPg==
X-Forwarded-Encrypted: i=1; AJvYcCVALxNbjWyH54kv1wyG16ILWrv6Eba1FunNUUCAUyjAMVdMJ+U9drYbCEbhVLcbWg9oQsl9OfWfO6lkKDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuP+5KYaCtLsZ580TSmWPOfS3qElX/9NQC1FNReqjiShhvIvfu
	vp5Sw3C6Z5CdoC3mSX5X6T0E7v3FoO3RNltH0LcOI+F/VI/HrD9Fe1L+ai4J
X-Google-Smtp-Source: AGHT+IFv5XmrNKiF0mFGpwNgM+pU1KSTfzHP3x5eKGdqYwoyM1JsTLDT3iQOIW2dwL6RDv3CiEk7dQ==
X-Received: by 2002:a05:690c:90:b0:6af:55ec:3cd7 with SMTP id 00721157ae682-6dff290369amr78463677b3.28.1727096326630;
        Mon, 23 Sep 2024 05:58:46 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6dbe2e25b49sm34027767b3.66.2024.09.23.05.58.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 05:58:46 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e1f48e7c18so6421057b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:58:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsYOtM2V0oOb9XPZdDyKYitccK1s6xZhzIZYQRVH9CXLqwUASMgqyg4g0MMBfd1PCbazi+J4e111WJPQA=@vger.kernel.org
X-Received: by 2002:a05:690c:ecd:b0:65f:aaf1:9dd3 with SMTP id
 00721157ae682-6dff270f59dmr81166547b3.2.1727096325925; Mon, 23 Sep 2024
 05:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922225041.603186-1-linux@roeck-us.net>
In-Reply-To: <20240922225041.603186-1-linux@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Sep 2024 14:58:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
Message-ID: <CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi G=C3=BCnter,

On Mon, Sep 23, 2024 at 12:50=E2=80=AFAM Guenter Roeck <linux@roeck-us.net>=
 wrote:
> Building allmodconfig images on systems with SPARSEMEM=3Dn results in
> the following message.
>
> WARNING: unmet direct dependencies detected for GET_FREE_REGION
>   Depends on [n]: SPARSEMEM [=3Dn]
>   Selected by [m]:
>   - RESOURCE_KUNIT_TEST [=3Dm] && RUNTIME_TESTING_MENU [=3Dy] && KUNIT [=
=3Dm]
>
> and the build ultimately fails.

Really? What's the build error?
It does build for me on m68k, after fixing:

    --- a/include/linux/mm.h
    +++ b/include/linux/mm.h
    @@ -101,7 +101,7 @@ extern int mmap_rnd_compat_bits __read_mostly;
     # ifdef MAX_PHYSMEM_BITS
     # define PHYSMEM_END   ((1ULL << MAX_PHYSMEM_BITS) - 1)
     # else
    -# define PHYSMEM_END   (-1ULL)
   +# define PHYSMEM_END   ((phys_addr_t)-1)
     # endif
     #endif

> GET_FREE_REGION depends on SPARSEMEM, so any configuration selecting it
> also depends on SPARSEMEM. Add the missing dependency.
>
> Effectively that means that RESOURCE_KUNIT_TEST is now restricted to
> systems with SPARSEMEM=3Dy, but that can not be helped.

Perhaps the individual test(s) that do depend on GET_FREE_REGION should
be protected by #ifdef CONFIG_GET_FREE_REGION instead? However,
I have no idea which parts depend on that, as apparently all tests
succeed on m68k/ARAnyM, with CONFIG_SPARSEMEM=3Dn:

    KTAP version 1
    1..1
        KTAP version 1
        # Subtest: resource
        # module: resource_kunit
        1..3
        ok 1 resource_test_union
        ok 2 resource_test_intersection
        ok 3 resource_test_region_intersects
    # resource: pass:3 fail:0 skip:0 total:3
    # Totals: pass:3 fail:0 skip:0 total:3
    ok 1 resource

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

