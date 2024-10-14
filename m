Return-Path: <linux-kernel+bounces-363297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8707E99C024
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4021C2247F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA512145FEB;
	Mon, 14 Oct 2024 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/v/Yzfr"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F97E14373F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887993; cv=none; b=r6NRj+Kj2loJhDH0DyrQBPpiZ8dMD9K0+cuWCVTt7AfY2Dzm+MN0mv4Tb78NNCrP7mR/ikR4PZeOmTM9JpW4R0uQxor03GUGs5MeKPZ8uWRMbDzfMNUkWI1DtUDahz/ZZFIiB8HeLra6JG4RnpM26suo54XI5Yp00+DrEMXfH9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887993; c=relaxed/simple;
	bh=RBj1oSv9qbGuLjxINaejAFKcBxp1vC7PoA7sA1LPURQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SY77imrgr1B2EdOOHwb5Jj19xvAuLkVuMF4lTVKzY3oDCFpLOtdKr1fzNVNG47Tnmn3/tHnbIIO6gAIqfZuh9xlmkG5aGzZKSVeapBXfHlht1x9cwfs82SosblMayDF5lmXYgKJcEshykHUO1TLyo7tzbbd9vmINhQWjNehfjXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/v/Yzfr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c948c41edeso3323297a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 23:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728887990; x=1729492790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jU7sxQpvZnWepCzlYwvvfgH/fWp+MYyl0r8AMT7cAT8=;
        b=l/v/Yzfr31G39MkbFDTL3NqPJSoHtLqeAl3K1vFdjNmNCait6ZKPenl3+pFpyvoAZP
         l9tA6eOHXMt4xibldQEyo6SEwLVabI0XEfeaGeIWBEp787cdkEZjcotl3QGdi/dH4/OA
         PGXqibaZ+otC0pu1eHcNNwIfJaxj3ckbxMl1dlNx4VE0SjHUSrMFVPYu80fqq0b5V67z
         p2C1YYpyUIDuUa7zXjA8pMlGja5TW9Wys3n/2Qpnv1KYIq3NSE3P8moOoAbhMkHBi6H5
         yTMzErXAvt1qhyz/q4rUVGx9zYQlHdV9AKhAd1M3j5Gs/XZFRGddGsbkJAYpYUWD6Yvz
         g0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728887990; x=1729492790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jU7sxQpvZnWepCzlYwvvfgH/fWp+MYyl0r8AMT7cAT8=;
        b=C6Tvks7gPMnYQzrDo2QndHscZbREpEgBgwS47Dx0Hog5ooKF89vYf+3jOaFNksf7Zv
         rI/DVe18WGWd06fROXgv0PedTmBRUog8hMadHto4DW7LSUUPcD9i8zwKh74Y1TxYRuZM
         ixQ0RxUkiaxSEO2aLksMTfAU6/jDKqMKn5xwDG8SIpVm5yVOoW8WcqEkaL1PZpHopHqx
         AFGTfMdDUp/cpBVZazX9Eu0ZfzDS74Vpl7/vGiofBfPk3qMUlK5yIA/WjiVCPTO+NLmk
         S4cke2id2sdMlQ4cZm5+v2gNLxQW8xBiSqI02GzTvfAwZJyL3s1HfqzCKhxvLfXUPXxW
         UluA==
X-Gm-Message-State: AOJu0Yye6v3XZwefRBdZZgMKZjX/8Wq2/JNg7prE12WfShdFQOSqIQ6g
	lMzPkvEspZSO+Y0TgV0cLNh3ptW6t53232z5h8oRUE/2xOzFVwDghFj1wEhG1ab5nPV4LP1bAEh
	5dCeT8hxb85ThJGeMqG20teoP/HJ00b1k
X-Google-Smtp-Source: AGHT+IHUztqe2AHjqjw8gzKu4H9krgYdjteB/Ma0GZFjQQ3J2/ryCYdkHSmUO10OeTMFX0dtRpuPGJ5LI3ZIobHjdwg=
X-Received: by 2002:a05:6402:550e:b0:5c4:4dfd:9fd5 with SMTP id
 4fb4d7f45d1cf-5c948d645c9mr7515777a12.29.1728887989356; Sun, 13 Oct 2024
 23:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALkUMdT_Q9o-NDKhAk=v_ARSe541y6yeg8hacYJ2iZ5PGjjRVw@mail.gmail.com>
 <2024100732-debtor-panther-4a75@gregkh>
In-Reply-To: <2024100732-debtor-panther-4a75@gregkh>
From: Vimal Agrawal <avimalin@gmail.com>
Date: Mon, 14 Oct 2024 12:09:37 +0530
Message-ID: <CALkUMdTFaUOurzkRT5y8SB07sdPQ0PvAutcpNhE-W2ZiyzTbxw@mail.gmail.com>
Subject: Re: misc_deregister() throwing warning in ida_free()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	D Scott Phillips <scott@os.amperecomputing.com>, Vimal Agrawal <vimal.agrawal@sophos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

I checked the return value of misc_regiser() and it is passing.
Following is the complete code of call to misc_register():
<<
static struct miscdevice ust_dev =3D {
        .minor  =3D 0,
        .name   =3D "ustdev",
        .fops   =3D &ustdev_ops,
};

int ustdev_init(void)
{
        int result =3D 0;

        result =3D misc_register(&ust_dev);
        if (result < 0) {
                KLOGERR("%s: misc_register for ustdev failed\n", __func__);
                return result;
        }
...
}
>>

There are two cases that are supported for minor numbers for misc
devices. One is using MISC_DYNAMIC_MINOR where api itself allocates a
minor number for it and updates it. Other is where the caller provides
the minor number which may fall in the range of (0, DYNAMIC_MINORS) or
> MISC_DYNAMIC_MINOR and my case is the later one as I am passing
minor as 0. To support both, we may have to allocate id in both cases
so that allocated id is seen the same in both cases.

I tried the following change which seems to be working but I am not
very sure if this is the best way to fix it:

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 541edc26ec89..d7933fabb8d8 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -63,6 +63,17 @@ static DEFINE_MUTEX(misc_mtx);
 #define DYNAMIC_MINORS 128 /* like dynamic majors */
 static DEFINE_IDA(misc_minors_ida);

+/* allocate a specific minor */
+static int misc_minor_alloc_static(int minor)
+{
+       int ret;
+
+       if (minor < DYNAMIC_MINORS)
+               minor =3D DYNAMIC_MINORS - minor - 1;
+
+       ret =3D ida_alloc_range(&misc_minors_ida, minor, minor, GFP_KERNEL)=
;
+       return ret;
+}
 static int misc_minor_alloc(void)
 {
        int ret;
@@ -228,6 +239,7 @@ int misc_register(struct miscdevice *misc)
                misc->minor =3D i;
        } else {
                struct miscdevice *c;
+               int i;

                list_for_each_entry(c, &misc_list, list) {
                        if (c->minor =3D=3D misc->minor) {
@@ -235,6 +247,12 @@ int misc_register(struct miscdevice *misc)
                                goto out;
                        }
                }
+
+               i =3D misc_minor_alloc_static(misc->minor);
+               if (i < 0) {
+                       err =3D -EBUSY;
+                       goto out;
+               }
        }

        dev =3D MKDEV(MISC_MAJOR, misc->minor);

Will send the patch shortly.


Thanks,
Vimal

On Mon, Oct 7, 2024 at 1:58=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Sep 16, 2024 at 06:56:18PM +0530, Vimal Agrawal wrote:
> > Hi Scott/ Greg and all,
> >
> > We recently upgraded kernel from 6.1 to 6.6.49 and started seeing
> > following WARNING during misc_deregister():
> >
> > ------------[ cut here ]------------
> >
> > WARNING: CPU: 0 PID: 159 at lib/idr.c:525 ida_free+0x3e0/0x41f
> > ida_free called for id=3D127 which is not allocated.
> > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> > Modules linked in: ust(O-) [last unloaded: fastpath_dummy(O)]
> > CPU: 0 PID: 159 Comm: modprobe Tainted: G        W  O     N 6.6.49+ #11
> > Stack:
> > 818bfb70 6093f8d3 0000020d 61381660
> > 61381630 60c1ee6a 00000001 60068c0f
> > 818bfbb0 60983ee6 60983e5c 61381680
> > Call Trace:
> > [<60973831>] ? _printk+0x0/0xc2
> > [<6004b2e6>] show_stack+0x35c/0x382
> > [<6093f8d3>] ? dump_stack_print_info+0x1af/0x1ec
> > [<60068c0f>] ? um_set_signals+0x0/0x43
> > [<60983ee6>] dump_stack_lvl+0x8a/0xa9
> > [<60983e5c>] ? dump_stack_lvl+0x0/0xa9
> > [<60068c0f>] ? um_set_signals+0x0/0x43
> > [<60983f32>] dump_stack+0x2d/0x35
> > [<60983f05>] ? dump_stack+0x0/0x35
> > [<6007aad8>] __warn+0x20c/0x294
> > [<60068c0f>] ? um_set_signals+0x0/0x43
> > [<60971d98>] warn_slowpath_fmt+0x164/0x189
> > [<60222128>] ? __update_cpu_freelist_fast+0x96/0xbc
> > [<60971c34>] ? warn_slowpath_fmt+0x0/0x189
> > [<6022d2fe>] ? __kmem_cache_free+0x16a/0x1be
> > [<60068c4a>] ? um_set_signals+0x3b/0x43
> > [<60941eb4>] ida_free+0x3e0/0x41f
> > [<605ac993>] misc_minor_free+0x3e/0xbc
> > [<605acb82>] misc_deregister+0x171/0x1b3
> > [<81aa7af2>] ustdev_exit+0xa8/0xc1 [ust]
> >
> > basic code of calling misc_register()/misc_register() is following:
> >
> > static struct miscdevice ust_dev =3D {
> >         0,
> >         "ustdev",
> >         &ustdev_ops,
> > };
>
> Nit, use named-identifiers pleaase so we know what is being set and what
> isn't.
>
> > int ustdev_init(void)
> > {
> >         misc_register(&ust_dev);
> >         return 0;
>
> This can be just one line, you are ignoring if misc_register() fails :(
>
> > }
> >
> > void ustdev_exit(void)
> > {
> >         misc_deregister(&ust_dev);
> > }
> >
> > Note that this was working fine without any warning earlier on kernel 6=
.1.
> >
> > I suspect it is due to
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?h=3Dv6.6.51&id=3Dab760791c0cfbb1d7a668f46a135264f56c8f018.
> > It seems misc_register() is not calling any ida_allocxxx() api for
> > static minor value of 0 but misc_deregister() for the same is calling
> > ida_free() and hence ida_free() is warning in our case.
> >
> > Please let me know if I am missing something or some of our
> > assumptions are not valid anymore in newer kernel versions.
>
> Can you submit a patch that works for you to resolve this issue?
>
> thanks,
>
> greg k-h

