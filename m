Return-Path: <linux-kernel+bounces-203465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DC08FDB99
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901651C214A9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D028F58;
	Thu,  6 Jun 2024 00:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l60RncE1"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176E029AF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717634791; cv=none; b=s2/FYgF0+TemuVWItjBnSXb8AIQlkq+RdDEZBe2Ow+B0OIYGgwrXqvOqNeaup0CcdiRHXV1SyqVPDRRJVyE00D2OVbSGhtWX8YTA7YF9HtFKhRAcc47bFUteWk7nqRS0vNUbzwxgI6bBNuqeFlWHP6GJ+AZL0HgnSne9ILm+FZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717634791; c=relaxed/simple;
	bh=yIZJVvAK3HHx+7zGZQrgoXzBGlVRQKP+JzY1L8rRxRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=F2ywK/EUf9DnbvV6SIgpBPqPHEGZicRZkYFe1BYepxbMsUXKvjnRuuR0hcTh1USYpdZjn1xhc7A+AoJKf4AR+TdDP4vI8Iws9zk1JKsdAnSwfvP1/0EOJ/HL+cizUarCKwvnFqPl+wNSRUf4nbh2YWD8vhmWUHv88rjQv+M5sXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l60RncE1; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-df78af3bdbcso75260276.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 17:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717634789; x=1718239589; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MFC/FaxgXEL8RPYoKRhycCHLP0/mgJuIoz6NXdvOI4=;
        b=l60RncE1iISUzwEprCu/Rtd5zPStVfNgQYDOF7kWRWKnQNL4Ijqa1khPFEvDdLSsbc
         S7OkXrjw3q/Rl0T1g131i4KjocoYZ8CNR4gVOKIYQXY3kZd8rK57C38lhPPL+N9HfmjP
         b41dUl+duk59Uv24oN/85673UwnfAVnwObxWFZUkR/OZWubV/tRZZUR7HLwCo4OoNiTa
         kM3/TCP4lSEOhoUE3V6eG8w2VnaTKyjXC9qBGlt8hXdZkr1N6tV4cwz1yObVp4hPVPgu
         PmIONmr//HYgyuodCYR2nLuqq19d8jGzb8RV9/x/RTYD6qhC3tYlQ9ZNzHTjYMH/uF7o
         0ojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717634789; x=1718239589;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MFC/FaxgXEL8RPYoKRhycCHLP0/mgJuIoz6NXdvOI4=;
        b=c2O1p39Dt+5s62JqINHkm2VBJjVXIgmTsb7JVaPRE43tlfADu+BGeDIACOuxQrWvlm
         atL4PpWepr/qUcaynrLLFX5SShYni/GTMgy+pbtigayPRmb3CpJverRowd0qbualwAM7
         OpB+KGgLEW39DE+H1xgM8c0Vc1s0OCUIYfbxzyOmaIZ7rOmHGjSrAlGtgEt69UqyH0A8
         fRd7BfmUnDrl9Y4CD/YevYCITE1RwtwdUnWhdWVVv/VcLW5mXLiEY3Vozy+WU9Rku+j2
         SW1mlY2BfVQTet/2Q4knX75RKD4VMSifAnpkNQ3S7rdVPQlQZPOp9FJryP4A4CwuCp5E
         b6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXT2nAlzLidMAAxe1yQ7aj6DXruKFkJlKZufX1WZ02hq6FPCBtUzOsLIC2V8cE45CgsgQf4IEDwZAq4hnuHg/EQsjAbzkLwEvkr7HnH
X-Gm-Message-State: AOJu0YyPn6SYFW6bGpcPPowu46aOxqxXsXUBsa4hg7bQbE1SDFgRMjtf
	y7azi8d24ZCMrZF+wH9qmXpLinivwSqXb1mAZZVde3K5FFmGuR09fxh0wK7e/1MKaqhYZU8qF+c
	ZWgRoXI2yDemfhLn+jdZVSTdq/io=
X-Google-Smtp-Source: AGHT+IE6Dh6kz+d89djMSqTzxUiYsLPH2rhtvI0EIyaJNhn3MwrMctlg9ryIrTzUsKd7Yk347s2F9SiwVBASLW5XsQ8=
X-Received: by 2002:a05:690c:f01:b0:627:e34e:14de with SMTP id
 00721157ae682-62cbb6917f0mr31095297b3.5.1717634787539; Wed, 05 Jun 2024
 17:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606004002.3280960-1-olvaffe@gmail.com>
In-Reply-To: <20240606004002.3280960-1-olvaffe@gmail.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 5 Jun 2024 17:46:16 -0700
Message-ID: <CAPaKu7Q8Ba4_GEZdBruO0if374BhMYafDbGc2dptPL4vdKR+1Q@mail.gmail.com>
Subject: Re: [PATCH v5] resource: add a simple test for walk_iomem_res_desc()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Baoquan He <bhe@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 5:40=E2=80=AFPM Chia-I Wu <olvaffe@gmail.com> wrote:
>
> This mainly tests that find_next_iomem_res() does not miss resources.
>
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
>
> ---
> v2: update subject, use DEFINE_RES_NAMED and hardcoded offsets
> v3: really hardcode offsets, with 4KB intervals since 0x1000 is easier
>     to read than 0x400
> v4: use RESOURCE_SIZE_MAX, split allocate_resource and KUNIT_ASSERT_EQ,
>     and other cosmetic changes
> v5: include linux/limits.h, add a comment on the resource layout, and
>     add more negative tests for holes
> ---
>  kernel/resource_kunit.c | 99 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>
> diff --git a/kernel/resource_kunit.c b/kernel/resource_kunit.c
> index 58ab9f914602b..b13f01f290606 100644
> --- a/kernel/resource_kunit.c
> +++ b/kernel/resource_kunit.c
> @@ -6,6 +6,7 @@
>  #include <kunit/test.h>
>  #include <linux/ioport.h>
>  #include <linux/kernel.h>
> +#include <linux/limits.h>
>  #include <linux/string.h>
>
>  #define R0_START       0x0000
> @@ -137,9 +138,107 @@ static void resource_test_intersection(struct kunit=
 *test)
>         } while (++i < ARRAY_SIZE(results_for_intersection));
>  }
>
> +static int resource_walk_count(struct resource *res, void *data)
> +{
> +       int *count =3D data;
> +
> +       (*count)++;
> +       return 0;
> +}
> +
> +static void resource_test_walk_iomem_res_desc(struct kunit *test)
> +{
> +       struct resource root =3D {
> +               .name =3D "Resource Walk Test",
> +       };
> +       struct resource res[8];
> +       int count;
> +       int ret;
> +
> +       ret =3D allocate_resource(&iomem_resource, &root, 0x100000,
> +                       0, RESOURCE_SIZE_MAX, 0x100000, NULL, NULL);
> +       KUNIT_ASSERT_EQ(test, 0, ret);
> +
> +       /* build the resource tree under the test root:
> +        *
> +        *   0x0000-0x0fff: res[0], a match
> +        *   0x1000-0x1fff: res[1], a non-match
> +        *   0x2000-0x2fff: a hole
> +        *   0x3000-0x3fff: res[2], a non-match
> +        *     0x3800-0x3bff: res[3], a match
> +        *   0x4000-0x4fff: res[4], a match
> +        */
> +       res[0] =3D DEFINE_RES_NAMED(root.start + 0x0000, 0x1000, "SYSRAM =
1",
> +                       IORESOURCE_SYSTEM_RAM);
> +       res[1] =3D DEFINE_RES_NAMED(root.start + 0x1000, 0x1000, "OTHER",=
 0);
> +
> +       res[2] =3D DEFINE_RES_NAMED(root.start + 0x3000, 0x1000, "NESTED"=
, 0);
> +       res[3] =3D DEFINE_RES_NAMED(root.start + 0x3800, 0x0400, "SYSRAM =
2",
> +                       IORESOURCE_SYSTEM_RAM);
> +
> +       res[4] =3D DEFINE_RES_NAMED(root.start + 0x4000, 0x1000, "SYSRAM =
3",
> +                       IORESOURCE_SYSTEM_RAM);
> +
> +       KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[0]));
> +       KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[1]));
> +       KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[2]));
> +       KUNIT_EXPECT_EQ(test, 0, request_resource(&res[2], &res[3]));
> +       KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[4]));
> +
> +       /* walk the entire region */
> +       count =3D 0;
> +       walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> +                       root.start, root.end, &count, resource_walk_count=
);
> +       KUNIT_EXPECT_EQ(test, count, 3);
> +
> +       /* walk the region requested by res[0] */
> +       count =3D 0;
> +       walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> +                       res[0].start, res[0].end, &count, resource_walk_c=
ount);
> +       KUNIT_EXPECT_EQ(test, count, 1);
> +
> +       /* walk the region requested by res[1] */
> +       count =3D 0;
> +       walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> +                       res[1].start, res[1].end, &count, resource_walk_c=
ount);
> +       KUNIT_EXPECT_EQ(test, count, 0);
> +
> +       /* walk the hole between res[1] and res[2] */
> +       count =3D 0;
> +       walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> +                       res[1].end + 1, res[2].start - 1, &count,
> +                       resource_walk_count);
> +       KUNIT_EXPECT_EQ(test, count, 0);
> +
> +       /* walk the region requested by res[2] */
> +       count =3D 0;
> +       walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> +                       res[2].start, res[2].end, &count, resource_walk_c=
ount);
> +       KUNIT_EXPECT_EQ(test, count, 1);
> +
> +       /* walk the holes before and after res[3] nested under res[2] */
> +       count =3D 0;
> +       walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> +                       res[2].start, res[3].start - 1, &count,
> +                       resource_walk_count);
> +       walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> +                       res[2].end + 1, res[3].end, &count,
This should be from "res[3].end + 1" to "res[2].end".  Not sure if I
should resend or if you can make the fix when applying.

> +                       resource_walk_count);
> +       KUNIT_EXPECT_EQ(test, count, 0);
> +
> +       /* walk the region requested by res[4] */
> +       count =3D 0;
> +       walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> +                       res[4].start, res[4].end, &count, resource_walk_c=
ount);
> +       KUNIT_EXPECT_EQ(test, count, 1);
> +
> +       release_resource(&root);
> +}
> +
>  static struct kunit_case resource_test_cases[] =3D {
>         KUNIT_CASE(resource_test_union),
>         KUNIT_CASE(resource_test_intersection),
> +       KUNIT_CASE(resource_test_walk_iomem_res_desc),
>         {}
>  };
>
> --
> 2.45.1.467.gbab1589fc0-goog
>

