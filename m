Return-Path: <linux-kernel+bounces-363095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F64B99BDCF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F204B21C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE89450F2;
	Mon, 14 Oct 2024 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0UvWuXo"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8754594D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728873472; cv=none; b=AlqoxU7F1YOicE7PzrrZAbwBNhJ2NainjzUsZzY0RHsytNJ2v5f5nZhBvC7VBJfjSxvlTYXOromohQ5yHMzaUFdktrbH2syzvrCSw9uxJ6eHPnAE1ToYNbFEJkcqIhA2HPekqwGFLm0v/q8xsKz1Dvb0M7AaMw5NzuQd9G3ZBpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728873472; c=relaxed/simple;
	bh=sIxI7e5sgdvRRPR9jHSTfcKb4j6Q+ooisLwyqBkg2wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lblVAzAc1ab9P0OKkJOXI7JgxezsZuCaVv/ailiLTnRdqu5lFUw92iT7wuii2we9x/ebaJm56oPq1jgum5SCo5OeksTNzsD/BpKyP2zfRCvlSsQnsiTrnGDlsmuDwpMTVpY4RAGfxiR/cVaeWOuX1lcl6CTB0jeKo6mPceo9yQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J0UvWuXo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c693b68f5so37703135ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 19:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728873470; x=1729478270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvS7dkDnxUI6bp1u5nJxrjFDPThHi48yAYLmv0eTJmw=;
        b=J0UvWuXorwx4HbQSZ+FpbStEaaO5YqVDwvuglIlMQLDZ1VYq9uIB/qfChZslk3+xn/
         FXdqopWC9z6UR2GJyGqQnertCGRyH1dDODQFRk39uwsHqKA54T45rQm5/Fc/jCsklgPT
         Xx6X7WMJ9g9RrFGMfOgQ7MdZs1oT+wj1g8E8UH46+Ojcd2lxBKWb9vdZNaNymFGT2ean
         wohJkUiajzAx3hvndab+HNFfp3e8oazApp4JsTBNJKG5dSXDWHdlXnybBmUhLzg4LEe+
         50rkWxW5ErlvuBOg8Mq2lUBmi/uzOldNGaZREjx2HyDe9HV7cfE111UtiIhsrR5yfk2S
         9OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728873470; x=1729478270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvS7dkDnxUI6bp1u5nJxrjFDPThHi48yAYLmv0eTJmw=;
        b=Yzy9+BjpX1Ni7BKlxObSMld9bXc5u5L44lZhB8rfDirRwZWVV9T8IXWrmk94KaJbh7
         IfXV7gqVsFj0LUogfpiONNf9qVZV+hzGozZHxjzmfDJgLMcIi7k7kkgboXMMMNU5SCbt
         F0ZyflwXSFQvPfNlfflDkAC/ZvCMEB0qe0psAlL6ync0jKfMPGt7ydj/Bss/8IEO0wSm
         03EPqhrrfRVkCA5UHaYR03NPgQratS1v38qB9PXi9h0enAVLNB+/VnprWP/iGp52Q2Ur
         nFo+OtTS+rYzjX/C9lFOXLaDS4+xufr1lkYtTQcWbOxBMTf92sRKk+XUx0Qxb1e2mf4m
         j29g==
X-Forwarded-Encrypted: i=1; AJvYcCWmoRgLtKAi7kU7TaJTwu1i1QE2YEg8zNZcKiB66tgCtS8/+2IwqL0V5DErRQWtZ6RkH2Idkto5YJ1iAME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrG1DHdTaueYDosjqfQ0zbBTuom4dLy13QSsmWSMloo1JMD9iQ
	mx26+OUwlCkei6wMhgxvtQaKHBDCrFtKRiAYTqQJlR3WDIUjIEgYP0M5c1gThSej2LzS1zn3/yi
	NwUIKQW+EbH8u/8aAWV6bKZxqRuGHhrzSErhsEtbC0WBnOlT+Khbe
X-Google-Smtp-Source: AGHT+IHdscZngOk4DHV6or3IO500O+lpxngvQQvWAeD6ImszLIemhpRLBPXwXKk532fxYhBAl3tOt4Dgaa+rt8JSCL0=
X-Received: by 2002:a17:90a:df89:b0:2e2:bd10:599d with SMTP id
 98e67ed59e1d1-2e2f0ad2040mr12976320a91.11.1728873469285; Sun, 13 Oct 2024
 19:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013200730.20542-1-richard@nod.at>
In-Reply-To: <20241013200730.20542-1-richard@nod.at>
From: Saravana Kannan <saravanak@google.com>
Date: Sun, 13 Oct 2024 19:37:10 -0700
Message-ID: <CAGETcx_+Poy8b_QhKY21Wg9=TBjtxrhCmFWTq8Qv6rLSJMURCw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] of: Add debug aid to find unused device tree properties
To: Richard Weinberger <richard@nod.at>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-kernel@vger.kernel.org, 
	upstream+devicetree@sigma-star.at
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 1:07=E2=80=AFPM Richard Weinberger <richard@nod.at>=
 wrote:
>
> This is a proof-of-concept patch that introduces a debug feature I find
> particularly useful.  I frequently encounter situations where I'm
> uncertain if my device tree configuration is correct or being utilized
> by the kernel.  This is especially common when porting device trees
> from vendor kernels, as some properties may have slightly different
> names in the upstream kernel, or upstream drivers may not use certain
> properties at all.

Why not just add debug logs? You can print the full path of the
properties being read and it should be easy to grep for the property
you care about.

> By writing 'y' to <debugfs>/of_mark_queried, every queried device tree

A lot of querying is going to happen at boot time. So, I'm not sure if
this method of enabling it is helpful. If we do this, make it a kernel
command line.

> property will gain S_IWUSR in sysfs.  While abusing S_IWUSR is
> admittedly a crude hack, it works for now.   I'm open to better ideas,
> perhaps using an xattr?

This seems quite convoluted. Why not just add another file per node
that lists all the queried properties?

> That way, dtc can easily add an annotation to unused device trees when
> reading from /proc/device-tree.

I'm not too familiar with this part. Can you elaborate more?

-Saravana

>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/of/Kconfig      |  9 +++++
>  drivers/of/Makefile     |  1 +
>  drivers/of/base.c       |  2 +
>  drivers/of/debug.c      | 83 +++++++++++++++++++++++++++++++++++++++++
>  drivers/of/of_private.h |  6 +++
>  include/linux/of.h      |  3 ++
>  6 files changed, 104 insertions(+)
>  create mode 100644 drivers/of/debug.c
>
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 0e2d608c3e207..39079ab9f1dc9 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -90,6 +90,15 @@ config OF_IRQ
>         def_bool y
>         depends on !SPARC && IRQ_DOMAIN
>
> +config OF_DEBUG
> +       bool "Device Tree debug features"
> +       select DEBUG_FS
> +       help
> +        This option enables device tree debug features.
> +        Currently only <debugfs>/of_mark_queried, writing 'y' to this fi=
le
> +        causes setting S_IWUSR on each device tree property in sysfs tha=
t
> +        was queried by a device driver.  This is useful to find dead pro=
perties.
> +
>  config OF_RESERVED_MEM
>         def_bool OF_EARLY_FLATTREE
>
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index 379a0afcbdc0b..041502125e897 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -25,3 +25,4 @@ obj-$(CONFIG_OF_OVERLAY_KUNIT_TEST) +=3D overlay-test.o
>  overlay-test-y :=3D overlay_test.o kunit_overlay_test.dtbo.o
>
>  obj-$(CONFIG_OF_UNITTEST) +=3D unittest-data/
> +obj-$(CONFIG_OF_DEBUG) +=3D debug.o
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 20603d3c9931b..00807da2187aa 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -202,6 +202,8 @@ static struct property *__of_find_property(const stru=
ct device_node *np,
>                 if (of_prop_cmp(pp->name, name) =3D=3D 0) {
>                         if (lenp)
>                                 *lenp =3D pp->length;
> +                       of_debug_mark_queried(pp);
> +
>                         break;
>                 }
>         }
> diff --git a/drivers/of/debug.c b/drivers/of/debug.c
> new file mode 100644
> index 0000000000000..ceb88062e9dec
> --- /dev/null
> +++ b/drivers/of/debug.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <linux/debugfs.h>
> +#include <linux/kstrtox.h>
> +#include <linux/of.h>
> +
> +#include "of_private.h"
> +
> +void of_debug_mark_queried(struct property *pp)
> +{
> +       pp->queried =3D true;
> +}
> +
> +static int dtmq_update_node_sysfs(struct device_node *np)
> +{
> +       struct property *pp;
> +       int ret =3D 0;
> +
> +       if (!IS_ENABLED(CONFIG_SYSFS) || !of_kset)
> +               goto out;
> +
> +       for_each_property_of_node(np, pp) {
> +               if (pp->queried) {
> +                       ret =3D sysfs_chmod_file(&np->kobj, &pp->attr.att=
r,
> +                                              pp->attr.attr.mode | S_IWU=
SR);
> +                       if (ret)
> +                               break;
> +               }
> +       }
> +
> +out:
> +       return ret;
> +}
> +
> +static int dtmq_update_sysfs(void)
> +{
> +       struct device_node *np;
> +       int ret =3D 0;
> +
> +       mutex_lock(&of_mutex);
> +       for_each_of_allnodes(np) {
> +               ret =3D dtmq_update_node_sysfs(np);
> +               if (ret)
> +                       break;
> +       }
> +       mutex_unlock(&of_mutex);
> +
> +       return ret;
> +}
> +
> +static ssize_t dtmq_file_write(struct file *file, const char __user *use=
r_buf,
> +                              size_t count, loff_t *ppos)
> +{
> +       bool do_it;
> +       int ret;
> +
> +       ret =3D kstrtobool_from_user(user_buf, count, &do_it);
> +       if (ret)
> +               goto out;
> +
> +       if (do_it) {
> +               ret =3D dtmq_update_sysfs();
> +               if (!ret)
> +                       ret =3D count;
> +       } else {
> +               ret =3D -EINVAL;
> +       }
> +
> +out:
> +       return ret;
> +}
> +
> +static const struct file_operations dtmq_fops =3D {
> +       .write  =3D dtmq_file_write,
> +       .open   =3D simple_open,
> +       .owner  =3D THIS_MODULE,
> +};
> +
> +static int __init of_debug_init(void)
> +{
> +       return PTR_ERR_OR_ZERO(debugfs_create_file("of_mark_queried", 064=
4, NULL, NULL,
> +                              &dtmq_fops));
> +}
> +late_initcall(of_debug_init);
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 04aa2a91f851a..55a21ef292064 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -184,4 +184,10 @@ void fdt_init_reserved_mem(void);
>
>  bool of_fdt_device_is_available(const void *blob, unsigned long node);
>
> +#if defined(CONFIG_OF_DEBUG)
> +void of_debug_mark_queried(struct property *pp);
> +#else
> +static inline void of_debug_mark_queried(struct property *pp) { }
> +#endif
> +
>  #endif /* _LINUX_OF_PRIVATE_H */
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 85b60ac9eec50..3b7afa252fca3 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -39,6 +39,9 @@ struct property {
>  #if defined(CONFIG_OF_KOBJ)
>         struct bin_attribute attr;
>  #endif
> +#if defined(CONFIG_OF_DEBUG)
> +       bool    queried;
> +#endif
>  };
>
>  #if defined(CONFIG_SPARC)
> --
> 2.35.3
>

