Return-Path: <linux-kernel+bounces-571410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C378BA6BCD1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81A03AEB66
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523BF1D5CC7;
	Fri, 21 Mar 2025 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9bsTZpf"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40A13AD38
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566652; cv=none; b=JO4jHVdexbbL6GWLS8mSXAKV+jc35q6yZx87Dr8ORj26cdcrpdHVHTRuorwScX4YGG8MHfzn/OTNBnpp8b5AW96dBqmzop/t1v40j/TJfP0ylozharoWGRFjshQM5DuR988+WhDMw5TjxnTvJv8RyH7YZWEoZ8Fmz+ckb5AbFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566652; c=relaxed/simple;
	bh=abcpScdIH+iJ7f/cc/lI1gu9a5umSVkyVm37uzzJmlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpjMCKFj86p2Nu2EICL6axsV1cxNH+qv3Qr/THqSrHgoXIqsD9KFpy3xIye9km4yEcsjyDOfGMP+/rhFUEy6U/N+mpV00XZsAEsWXDS8ZZoPOGILsdiZAnCZ3ST2bBmrwMtT3JYRCavro4noMLUe3ZdPzl17pUKfP7+iS9jJVvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9bsTZpf; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bd11bfec6so21335621fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742566649; x=1743171449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tesCzyVEDpNzziJBXhLV3rImVo6j7PfN3V4yTfNrlI=;
        b=Q9bsTZpfrSljlaQ/JUhlIkXh8S1QZTDCZfYA+y4lzLbJWdvjkFZxOUK4eRPK+Fowhr
         Bss88LbtGNZt8OEgjBlo/0E+xjtObSP2vvscDDGv9yeguG0snK5rrKx4eEV+MQCMlK7t
         DvW+w8yyATj/RAX7UNKK1BpxydXUbSfNqSdQfxefk545yEFYDJiqMFmnqWSdkm+FAJMo
         khbqXHMLwAfEt5WJuP3nORMefHCzjSbSpjS2bBm6fmL/7Hzo0sjSpz19lPjgU/W/XzS2
         LoDflmwt+C8xXksjv6OgRKUA/6vpvf/CUW8izH8Jii10KXk0dSD9zSXCyTXRlLQuOtds
         kIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566649; x=1743171449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tesCzyVEDpNzziJBXhLV3rImVo6j7PfN3V4yTfNrlI=;
        b=vsO6VrPJpp63Oz2QN2J+rKaGothf/4Z0unGkKF8wHXtKAmBkB2Xk+DQUHBIRJi8IfO
         J3fFmTjN8nW5T6LJGHQ//ZNVkAPXDlKhnvDRcM/n2p85d/6f6aJpftyy2f1ABiiWXp2C
         rou9S66oKIwNblSRySddIpvQVlOynd3jb8zNBWbvcLpHZZNppw3gr/HkZf8A3LzItQqy
         J0GSQjzqj/ecXlZ3Mv73wXcjj4cuUzb4Ja7PbLNHRummkfkNWA6GBDQ/3mu7BGvsPkRv
         sZC8kfFNNX/dmJULK/hWYMv4/6g0pEZ/yGTZCVxmEV6GVP7Dxcf2ebH3BKOeCPOsjmYX
         aynQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9Wn42X/EqvgGaEtzDOG5Kx2hZpycVgXttTpDFdE/UEn4zulDBXJyag0M1gzLli2COu8I6Gu5C9w/3hOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyZqq7RLFmSsc/rHTXMz+okvJHbkjd//bDW5bXsNSfBYazjuK2
	0t+QC7QdNajSAO9Kxg93hr9HUYMQSmFPSvwYhtW66tW7NrvmJO37mzfkKq5XmSS5C/QCnzfrRsf
	Mw4VZfG3h5P2xgUviqjWlrveL1KA=
X-Gm-Gg: ASbGncsfzBc5dEf1wjufoW9y69VcXhamGa5rWuRMESI0+0zh2Cwz8q/qDqSaa6rjedH
	SZhX9fmE5eB+9bC/nzKavzUq1/XkiZ+Ur6rys7uXB99W1PrFys7XarMCphE0ZCgL+6xSHVZoEhF
	a0RcrN9Th5gTqu/5weQlDPPyWB+9birj6XesBcgwvxSQ==
X-Google-Smtp-Source: AGHT+IFg1NU9tVPGMhUUJJbhOHj4P/H/O2y/QyOLYk4b9KFol8sFt8coljmWvl/+Gk70AvqPwMAuWwgU2nvBrDHJ2Ow=
X-Received: by 2002:a05:651c:50a:b0:30c:2da4:85fb with SMTP id
 38308e7fff4ca-30d7e22171cmr14437071fa.12.1742566647005; Fri, 21 Mar 2025
 07:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4378DDFE-3263-497A-8364-433DC1984FEE@live.com>
In-Reply-To: <4378DDFE-3263-497A-8364-433DC1984FEE@live.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Mar 2025 10:16:49 -0400
X-Gm-Features: AQ5f1JqgTcW7uU8hqB5e3_f6-yhSWki5xFpeg3M51SsKfHQM5bdn12gKjCJKdHU
Message-ID: <CAJ-ks9=zN0pUAt9ELckna+3GcnDfhjF3jgiM1FHXLji9pWc2wQ@mail.gmail.com>
Subject: Re: [PATCH] printf: add tests for generic FourCCs
To: Aditya Garg <gargaditya08@live.com>
Cc: Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 11:45=E2=80=AFPM Aditya Garg <gargaditya08@live.com=
> wrote:
>
> From: Aditya Garg <gargaditya08@live.com>
>
> Format specifiers for printing generic 32-bit FourCCs were recently added
> to vsprintf. They are going through the DRM tree alongwith the appletbdrm
> driver. Since the printf tests are being converted to kunit, this separat=
e
> patch for the tests should make it easier to rebase when the merge window
> opens.
>
> Link: https://lore.kernel.org/dri-devel/79FA3F41-FD7A-41D9-852B-D32606AF5=
EB4@live.com/T/#u
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  lib/tests/printf_kunit.c | 39 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/lib/tests/printf_kunit.c b/lib/tests/printf_kunit.c
> index 2c9f6170b..b1fa0dcea 100644
> --- a/lib/tests/printf_kunit.c
> +++ b/lib/tests/printf_kunit.c
> @@ -701,21 +701,46 @@ static void fwnode_pointer(struct kunit *kunittest)
>         software_node_unregister_node_group(group);
>  }
>
> +struct fourcc_struct {
> +       u32 code;
> +       const char *str;
> +};
> +
> +static void fourcc_pointer_test(struct kunit *kunittest, const struct fo=
urcc_struct *fc,
> +                               size_t n, const char *fmt)
> +{
> +       size_t i;
> +
> +       for (i =3D 0; i < n; i++)
> +               test(fc[i].str, fmt, &fc[i].code);
> +}
> +
>  static void fourcc_pointer(struct kunit *kunittest)
>  {
> -       struct {
> -               u32 code;
> -               char *str;
> -       } const try[] =3D {
> +       static const struct fourcc_struct try_cc[] =3D {
>                 { 0x3231564e, "NV12 little-endian (0x3231564e)", },
>                 { 0xb231564e, "NV12 big-endian (0xb231564e)", },
>                 { 0x10111213, ".... little-endian (0x10111213)", },
>                 { 0x20303159, "Y10  little-endian (0x20303159)", },
>         };
> -       unsigned int i;
> +       static const struct fourcc_struct try_ch[] =3D {
> +               { 0x41424344, "ABCD (0x41424344)", },
> +       };
> +       static const struct fourcc_struct try_cn[] =3D {
> +               { 0x41424344, "DCBA (0x44434241)", },
> +       };
> +       static const struct fourcc_struct try_cl[] =3D {
> +               { (__force u32)cpu_to_le32(0x41424344), "ABCD (0x41424344=
)", },
> +       };
> +       static const struct fourcc_struct try_cb[] =3D {
> +               { (__force u32)cpu_to_be32(0x41424344), "ABCD (0x41424344=
)", },
> +       };
>
> -       for (i =3D 0; i < ARRAY_SIZE(try); i++)
> -               test(try[i].str, "%p4cc", &try[i].code);
> +       fourcc_pointer_test(kunittest, try_cc, ARRAY_SIZE(try_cc), "%p4cc=
");
> +       fourcc_pointer_test(kunittest, try_ch, ARRAY_SIZE(try_ch), "%p4ch=
");
> +       fourcc_pointer_test(kunittest, try_cn, ARRAY_SIZE(try_cn), "%p4cn=
");
> +       fourcc_pointer_test(kunittest, try_cl, ARRAY_SIZE(try_cl), "%p4cl=
");
> +       fourcc_pointer_test(kunittest, try_cb, ARRAY_SIZE(try_cb), "%p4cb=
");
>  }
>
>  static void
> --
> 2.43.0
>

This code looks fine to me. I would appreciate a preview of the output
of these tests when they fail; a lot of effort went into making the
printf tests produce actionable failure messages, and we should
continue to invest in that IMO.

