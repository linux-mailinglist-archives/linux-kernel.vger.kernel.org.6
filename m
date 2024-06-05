Return-Path: <linux-kernel+bounces-203298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960088FD917
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB371C22305
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6A516C68C;
	Wed,  5 Jun 2024 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsEWGT8i"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3983416ABD8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623136; cv=none; b=pB+z7t4ZrCGjrJTZwPqnJpU+6wpZKGgWiWrBqTyQ7x+bZFjQjZxJ9HJrGXID1DPBz3INUiTVKQglQLbcmlAKuoCt06/RFRkiObOHs8TqqBtfBmj1/ngz5HArKxu53+w3f5X51s3/eNx0z8MAsWOGz/CAr1aqg5K3cGxi/G/3xYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623136; c=relaxed/simple;
	bh=2LvJMHkgU4AO0k7JuEOpImVPgoMfIqlW7xjlqc199rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ev4+WMSnhLsf0KQPznFYPR4g8BZBnKHOF+pa4ajFDedKGO2EVKUKVufBku+xg+g8DkEqCF3TUpOWw4UylUVoZz+X1M9a7UspkNQ0jf1ImDfGh3aBHYXdTZmperPjhXH64ixxJsJsveVnOMX8mON8pZGGlB3cbKZtkHpsOlxhMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsEWGT8i; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a24836e10so119277b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 14:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717623134; x=1718227934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTBiKvOZtBNblIWb1cS7CeNoRrpZ3phkUvzOyTJpLCA=;
        b=IsEWGT8iIg1T14K4dOloXje5CvpTSDfe+ec/PF8fFqjsNQJJEBtpq0M60T+ZKWcSUN
         f3cbUpWr9aWI5gdWKSXBgdcwNOYbBqqiFXkBRVuBBjaP4b/eXllGIYs+uUSocEdPIEx+
         VOJi5+qqkGKHsalZdHDBQ1cSQUa5jW3sfX/bDPKnhuHC6P/55rXdEaBBsmN4mQpy0IZY
         fXXBQoygTcMf98wh74PXEMAofsFazED8KtMur3fYPVNN0dzaE50Tpa257/3lAKPQT9V+
         pbtzr5WtZIBFPM+yh9AbyNyfHVLRaa5bVP3p+nRuIzeHLfMl4C7i61e/c5R42gqer6z4
         yVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717623134; x=1718227934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTBiKvOZtBNblIWb1cS7CeNoRrpZ3phkUvzOyTJpLCA=;
        b=OnS8rQ0e2mtN/x42Wxg+spsiqXP3E9p9UFyTiPZ7Tgz2w5OOT9d963rNrWzT/Xf5jJ
         yNcV9+x5wS4TmwNvu6/6GNXEmh6mkCDz/AczQ0/IKfyU1utRYMlwfNOLiidSwy0kGdxU
         jWZwdw/S03hvlIOUqRKjBgLlJzthClp3gGBPp6vA1GQTcCCTTbN93VZxn714bDAD9zaQ
         PBtUrNS95kGU3VreUIJfYm2iCgz5xlL88GKfMGgk8H3SKQ7CZlFij6VtBN38jYuj5O7u
         hRdgYxLkvo4tBgqOVDAZ4uEVPcmgAm6ZTUEfd1XAlUglOuR3KF1TwiE3WD5gf5Q6TaKS
         n0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCX9E0229g2gH3f6bbymPeFDM98HDT4llyaSj8PpjC1JDzUktlezGCfRk38qe0wbkCyeydHMkbiURZI/qsydkDV4ECzVuQyC0Nw3RVFn
X-Gm-Message-State: AOJu0YyeT9b259os+eLd/tAtJSUYPK4HQiU1j8hHprKlqCWRyVHfEIft
	VwTG5jqUJiaeczFdFZZO0u7idMeDH9OLCEgKHx0sXiDS3EuRN9qlKveAKOZNgjZaY1reB3NqUWJ
	fUaXNjedIkNcV20j2BytJkwzl+Q8=
X-Google-Smtp-Source: AGHT+IGgNWL9Q0ibK2GBnZou0MbYISBtvApLYj9KKS/gJI3w/PedbuqkbLVpT7GYpH2dD3iXO8Zw23QBnuxhuv9qT+4=
X-Received: by 2002:a05:690c:fc6:b0:61b:e5de:1206 with SMTP id
 00721157ae682-62cbb5ec24amr38461097b3.3.1717623134083; Wed, 05 Jun 2024
 14:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605195324.3213954-1-olvaffe@gmail.com> <ZmDLm1xN68f_6Odg@smile.fi.intel.com>
In-Reply-To: <ZmDLm1xN68f_6Odg@smile.fi.intel.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 5 Jun 2024 14:32:03 -0700
Message-ID: <CAPaKu7Qsvjq31LJJPMnpT64r7-5MTXaDQ7bNStK8V_QHw_fjTw@mail.gmail.com>
Subject: Re: [PATCH v3] resource: add a simple test for walk_iomem_res_desc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Baoquan He <bhe@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 1:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 05, 2024 at 12:53:10PM -0700, Chia-I Wu wrote:
> > This mainly tests that find_next_iomem_res() does not miss resources.
>
> ...
>
> > v2: update subject, use DEFINE_RES_NAMED and hardcoded offsets
> > v3: really hardcode offsets
>
> This doesn't explain why you multiplied previous values.
They were quite randomly picked.  They were changed because multiples
of 0x1000 are easier to read than multiples of 0x400.

All suggestions have been incorporated in v4.
>
> ...
>
> > +static int resource_walk_count(struct resource *res, void *data)
> > +{
> > +     int *count =3D data;
>
> + Blank line.
>
> > +     (*count)++;
> > +     return 0;
> > +}
>
> ...
>
> > +static void resource_test_walk_iomem_res_desc(struct kunit *test)
> > +{
> > +     struct resource root =3D {
> > +             .name =3D "Resource Walk Test",
> > +     };
> > +     struct resource res[8];
> > +     int count;
> > +
> > +     KUNIT_ASSERT_EQ(test, 0,
> > +                     allocate_resource(&iomem_resource, &root, 0x10000=
0,
> > +                             0, ~0, 0x100000, NULL, NULL));
>
> Shouldn't this use RESOURCE_SIZE_MAX?
>
> Please, split the assertion and allocate_resource() call, so it becomes
> readable what exactly you checked against.
>
> > +     /* build the resource tree */
> > +     res[0] =3D DEFINE_RES_NAMED(root.start + 0x0000, 0x1000, "SYSRAM =
1",
> > +                     IORESOURCE_SYSTEM_RAM);
> > +     res[1] =3D DEFINE_RES_NAMED(root.start + 0x1000, 0x1000, "OTHER",=
 0);
> > +
> > +     res[2] =3D DEFINE_RES_NAMED(root.start + 0x3000, 0x1000, "NESTED"=
, 0);
> > +     res[3] =3D DEFINE_RES_NAMED(root.start + 0x3800, 0x0400, "SYSRAM =
2",
> > +                     IORESOURCE_SYSTEM_RAM);
> > +
> > +     res[4] =3D DEFINE_RES_NAMED(root.start + 0x4000, 0x1000, "SYSRAM =
3",
> > +                     IORESOURCE_SYSTEM_RAM);
> > +
> > +     KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[0]));
> > +     KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[1]));
> > +     KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[2]));
> > +     KUNIT_EXPECT_EQ(test, 0, request_resource(&res[2], &res[3]));
> > +     KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[4]));
> > +
> > +     /* walk the entire region */
> > +     count =3D 0;
> > +     walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> > +                     root.start, root.end, &count, resource_walk_count=
);
> > +     KUNIT_EXPECT_EQ(test, count, 3);
> > +
> > +     /* walk the region requested by res[1] */
> > +     count =3D 0;
> > +     walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> > +                     res[1].start, res[1].end, &count, resource_walk_c=
ount);
> > +     KUNIT_EXPECT_EQ(test, count, 0);
> > +
> > +     /* walk the region requested by res[2] */
> > +     count =3D 0;
> > +     walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> > +                     res[2].start, res[2].end, &count, resource_walk_c=
ount);
> > +     KUNIT_EXPECT_EQ(test, count, 1);
> > +
> > +     /* walk the region requested by res[4] */
> > +     count =3D 0;
> > +     walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> > +                     res[4].start, res[4].end, &count, resource_walk_c=
ount);
> > +     KUNIT_EXPECT_EQ(test, count, 1);
> > +
> > +     release_resource(&root);
> > +}
>
> Other than the above, LGTM. Hopefully next version will be ready to apply=
.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

