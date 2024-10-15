Return-Path: <linux-kernel+bounces-365288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABA499E004
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0801C21B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9E11D049D;
	Tue, 15 Oct 2024 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyBwbkru"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01EF1C8767
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979069; cv=none; b=c5cWus3cvl7bD5pxhdgYHUsJ7uKRE4+uMebAr56iNlOC17XGUPYRLkSv5qcRlUHMxrLOjNqPFt47K+oHsrmK40O86CDNiAK0y+CwOZ/PjhZcsSBr+uBYzfthtTvus22kmoc4mrwm3F0IkFioUFN4/d4LqomZoI6bh8ZFv/w1/Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979069; c=relaxed/simple;
	bh=Zof5Y2DRZ+ASO16Bz7hMyJqUb/zB0attIIjBQF7RISI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=krgcwniVEjAUXA9L6OSd6Ejs208g9Wh3Rlh9Uv+bT/U47U1rVPu8OuoIByMmLbn26mSl0LwL/3OjNeXxxIWljiPeM8/wK5btwJdpafwtMMTtaXIBiYT5EGQag8ytKrcY49HTLFYA3TSpOqWqWQoB9abPzg4N2j1IrbIJ4OEE55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyBwbkru; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c960af31daso3505303a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728979066; x=1729583866; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4guiKkbKgZ86G4WhEFPsesYt1g6BMTt4IGBlAOBmJ0w=;
        b=WyBwbkrus+98KqBotaOClEsKGGxioZ1QEMHcqYsG5GVKnUNQ9flPQNvHvejTDZmdv3
         LgKrgGw+TnIB87xtfXY1J82m1OVIGn+Qij2bnq5YWqXqanYOn3VRGgHgRsOui3bC9mJw
         eEY8D6g7pBOMDF900ez56lcw9EmWpH6yMcXbyhB4ORtJOp+MRuNSsbTlB4xSsXRBxrT8
         ynobKb7iNPvkks+L0EDvlDed8BryTw5/BRE65HLduSvfJDb2u0BNfV7zJJUXwqcgK6Ij
         mJZ0EeACV+n29ixTWW7G12vcBub3w0KF/kbv+N9e/3nr+hlMkwJ++C2BppiAobwFflOl
         PulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979066; x=1729583866;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4guiKkbKgZ86G4WhEFPsesYt1g6BMTt4IGBlAOBmJ0w=;
        b=GTjqR9/mythJq/H8nw1upQ6tX9RX67KNoApokSQrtNe7/DX4boXuUsflwvQ7bje03F
         WUBH9QHLVTM3ACfr2fyBaS/qo/aYI7Z6uSs9u1ie1nxIssSnLnNk5LKjrnkeX9au++nN
         qqHl/78ChBraSB8u68k+X1UkdzQwA+LiJKJ26GllIBO2kfqsoEH2CI1v34pCu+706OOy
         aKno9xmU0t30I0qOzeBppUi8qVmS2dVtfO4b88ukL6q5VAztuIOVIvBPrxH6iRc0VO5H
         StFXiblhVYZmIbn1X04kkXOn8TGfAzkduFE1evohylvFB4ro4hcPJd3Touc+64VnG8L7
         +DLQ==
X-Gm-Message-State: AOJu0YwWQ5vH0KZ4fkBd0mt4Vt1FQTdJJuTxZAYPVZMtUKOTuUP8JJ7+
	MJEA4e9QcdPiNNXgNbjsBhgwkbvrYp/YzAtbl6JqY5jw9Xbs5d/j42Oy2FVFDnHxM9vCyLd4oln
	H3GzGxEqz6SzvA9r6/dnYhlMhMbFQoGMOlmU=
X-Google-Smtp-Source: AGHT+IEZnIF5pVZyAuVimAXtYpJdKZA6otSuRq3P9Bat7qUeujm0NxNe8R+VMCy5XhajOMO3nU/Vo/gq+Leu2/Y5wNA=
X-Received: by 2002:a05:6402:234c:b0:5c9:6047:7467 with SMTP id
 4fb4d7f45d1cf-5c96047762fmr8119546a12.8.1728979065278; Tue, 15 Oct 2024
 00:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024101416-scouring-upbeat-b658@gregkh> <20241015070226.15790-1-vimal.agrawal@sophos.com>
In-Reply-To: <20241015070226.15790-1-vimal.agrawal@sophos.com>
From: Vimal Agrawal <avimalin@gmail.com>
Date: Tue, 15 Oct 2024 13:27:33 +0530
Message-ID: <CALkUMdR4y6r9AwdX5_jnhaRHuDhkqvnxWOj_8rr3VSBOmqjo9Q@mail.gmail.com>
Subject: Re: [PATCH v2] misc: misc_minor_alloc to use ida for all dynamic/misc
 dynamic minors
To: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Added commit that this fixed under "Fixes:" in commit log
As this was not causing any failure in any functions, I tested it by
looking at WARN in logs.
I wrote a very basic kunit for testing misc_register as I could not
find any tests for it.

I was hoping to fail misc_register if someone passes minor value in
the range of dynamic and misc dynamic minor but I do see at least one
case where PSMOUSE_MINOR(1)
is passed. Unless we decide to change the range of dynamic minors from
0 -127 to 1-127 but I am not sure if there are other such cases so to
be safer this patch is allowing
callers to pass minor in the range of dynamic /misc dynamic minors as
was the case earlier.

Thanks,
Vimal

On Tue, Oct 15, 2024 at 12:32=E2=80=AFPM Vimal Agrawal <avimalin@gmail.com>=
 wrote:
>
> misc_minor_alloc was allocating id using ida for minor only in case of
> MISC_DYNAMIC_MINOR but misc_minor_free was always freeing ids
> using ida_free causing a mismatch and following warn:
> > > WARNING: CPU: 0 PID: 159 at lib/idr.c:525 ida_free+0x3e0/0x41f
> > > ida_free called for id=3D127 which is not allocated.
> > > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> ...
> > > [<60941eb4>] ida_free+0x3e0/0x41f
> > > [<605ac993>] misc_minor_free+0x3e/0xbc
> > > [<605acb82>] misc_deregister+0x171/0x1b3
>
> misc_minor_alloc is changed to allocate id from ida for all minors
> falling in the range of dynamic/ misc dynamic minors
>
> Fixes: 0ad35fed618c ("char: misc: Increase the maximum number of dynamic =
misc devices to 1048448")
> Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
> ---
>  drivers/char/misc.c   | 35 +++++++++++++++++-----
>  lib/Kconfig.debug     | 11 +++++++
>  lib/Makefile          |  1 +
>  lib/test_misc_minor.c | 67 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 107 insertions(+), 7 deletions(-)
>  create mode 100644 lib/test_misc_minor.c
>
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index 541edc26ec89..9d0cd3459b4f 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -63,16 +63,30 @@ static DEFINE_MUTEX(misc_mtx);
>  #define DYNAMIC_MINORS 128 /* like dynamic majors */
>  static DEFINE_IDA(misc_minors_ida);
>
> -static int misc_minor_alloc(void)
> +static int misc_minor_alloc(int minor)
>  {
>         int ret;
>
> -       ret =3D ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_K=
ERNEL);
> -       if (ret >=3D 0) {
> -               ret =3D DYNAMIC_MINORS - ret - 1;
> -       } else {
> -               ret =3D ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MI=
NOR + 1,
> +       if (minor =3D=3D MISC_DYNAMIC_MINOR) {
> +               /* allocate free id */
> +               ret =3D ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - =
1, GFP_KERNEL);
> +               if (ret >=3D 0) {
> +                       ret =3D DYNAMIC_MINORS - ret - 1;
> +               } else {
> +                       ret =3D ida_alloc_range(&misc_minors_ida, MISC_DY=
NAMIC_MINOR + 1,
>                                       MINORMASK, GFP_KERNEL);
> +               }
> +       } else {
> +               /* specific minor, check if it is in dynamic or misc dyna=
mic range  */
> +               if (minor < DYNAMIC_MINORS) {
> +                       minor =3D DYNAMIC_MINORS - minor - 1;
> +                       ret =3D ida_alloc_range(&misc_minors_ida, minor, =
minor, GFP_KERNEL);
> +               } else if (minor > MISC_DYNAMIC_MINOR) {
> +                       ret =3D ida_alloc_range(&misc_minors_ida, minor, =
minor, GFP_KERNEL);
> +               } else {
> +                       /* case of non-dynamic minors, no need to allocat=
e id */
> +                       ret =3D 0;
> +               }
>         }
>         return ret;
>  }
> @@ -219,7 +233,7 @@ int misc_register(struct miscdevice *misc)
>         mutex_lock(&misc_mtx);
>
>         if (is_dynamic) {
> -               int i =3D misc_minor_alloc();
> +               int i =3D misc_minor_alloc(misc->minor);
>
>                 if (i < 0) {
>                         err =3D -EBUSY;
> @@ -228,6 +242,7 @@ int misc_register(struct miscdevice *misc)
>                 misc->minor =3D i;
>         } else {
>                 struct miscdevice *c;
> +               int i;
>
>                 list_for_each_entry(c, &misc_list, list) {
>                         if (c->minor =3D=3D misc->minor) {
> @@ -235,6 +250,12 @@ int misc_register(struct miscdevice *misc)
>                                 goto out;
>                         }
>                 }
> +
> +               i =3D misc_minor_alloc(misc->minor);
> +               if (i < 0) {
> +                       err =3D -EBUSY;
> +                       goto out;
> +               }
>         }
>
>         dev =3D MKDEV(MISC_MAJOR, misc->minor);
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 7315f643817a..5a5d27284e0a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2488,6 +2488,17 @@ config TEST_RHASHTABLE
>  config TEST_IDA
>         tristate "Perform selftest on IDA functions"
>
> +config TEST_MISC_MINOR
> +       tristate "Basic misc minor Kunit test" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         Kunit test for the misc minor.
> +         It tests misc minor functions for dynamic and misc dynamic mino=
r.
> +         This include misc_xxx functions
> +
> +         If unsure, say N.
> +
>  config TEST_PARMAN
>         tristate "Perform selftest on priority array manager"
>         depends on PARMAN
> diff --git a/lib/Makefile b/lib/Makefile
> index 773adf88af41..631d73f96f76 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_TEST_SYSCTL) +=3D test_sysctl.o
>  obj-$(CONFIG_TEST_IOV_ITER) +=3D kunit_iov_iter.o
>  obj-$(CONFIG_HASH_KUNIT_TEST) +=3D test_hash.o
>  obj-$(CONFIG_TEST_IDA) +=3D test_ida.o
> +obj-$(CONFIG_TEST_MISC_MINOR) +=3D test_misc_minor.o
>  obj-$(CONFIG_TEST_UBSAN) +=3D test_ubsan.o
>  CFLAGS_test_ubsan.o +=3D $(call cc-disable-warning, vla)
>  CFLAGS_test_ubsan.o +=3D $(call cc-disable-warning, unused-but-set-varia=
ble)
> diff --git a/lib/test_misc_minor.c b/lib/test_misc_minor.c
> new file mode 100644
> index 000000000000..bcec3fb1c46a
> --- /dev/null
> +++ b/lib/test_misc_minor.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <kunit/test.h>
> +#include <kunit/test-bug.h>
> +#include <linux/module.h>
> +#include <linux/miscdevice.h>
> +
> +/* dynamic minor (2) */
> +static struct miscdevice dev_dynamic_minor =3D {
> +        .minor  =3D 2,
> +        .name   =3D "dev_dynamic_minor",
> +};
> +
> +/* static minor (LCD_MINOR) */
> +static struct miscdevice dev_static_minor =3D {
> +        .minor  =3D LCD_MINOR,
> +        .name   =3D "dev_static_minor",
> +};
> +
> +/* misc dynamic minor */
> +static struct miscdevice dev_misc_dynamic_minor =3D {
> +        .minor  =3D MISC_DYNAMIC_MINOR,
> +        .name   =3D "dev_misc_dynamic_minor",
> +};
> +
> +static void kunit_dynamic_minor(struct kunit *test)
> +{
> +       int ret;
> +
> +       ret=3Dmisc_register(&dev_dynamic_minor);
> +       KUNIT_EXPECT_EQ(test, 0, ret);
> +       KUNIT_EXPECT_EQ(test, 2, dev_dynamic_minor.minor);
> +       misc_deregister(&dev_dynamic_minor);
> +}
> +
> +static void kunit_static_minor(struct kunit *test)
> +{
> +       int ret;
> +
> +       ret=3Dmisc_register(&dev_static_minor);
> +       KUNIT_EXPECT_EQ(test, 0, ret);
> +       KUNIT_EXPECT_EQ(test, LCD_MINOR, dev_static_minor.minor);
> +       misc_deregister(&dev_static_minor);
> +}
> +
> +static void kunit_misc_dynamic_minor(struct kunit *test)
> +{
> +       int ret;
> +
> +       ret=3Dmisc_register(&dev_misc_dynamic_minor);
> +       KUNIT_EXPECT_EQ(test, 0, ret);
> +       misc_deregister(&dev_misc_dynamic_minor);
> +}
> +
> +static struct kunit_case test_cases[] =3D {
> +       KUNIT_CASE(kunit_dynamic_minor),
> +       KUNIT_CASE(kunit_static_minor),
> +       KUNIT_CASE(kunit_misc_dynamic_minor),
> +       {}
> +};
> +
> +static struct kunit_suite test_suite =3D {
> +       .name =3D "misc_minor_test",
> +       .test_cases =3D test_cases,
> +};
> +kunit_test_suite(test_suite);
> +
> +MODULE_LICENSE("GPL");
> --
> 2.17.1
>

