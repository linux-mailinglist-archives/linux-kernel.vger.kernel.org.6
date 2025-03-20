Return-Path: <linux-kernel+bounces-570036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DD7A6AB2C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66FCD18926E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2E221C9F2;
	Thu, 20 Mar 2025 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="duIZYYEQ"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A606A1EDA18
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488560; cv=none; b=Fo2BKDeOWNAi2nk/WggEkpGvyWuhjjfEeXyR6D1tRBo8C8vj0PUSgot2BY95xNi8J5KSoVK0rpc8yMyUXXHUbk4/CPGPuEQ2mmaNmIC5qqi+/H+C0ZvvvMtAELNGqBlOQCQiceXRu1av/P8OsqkeRoIjO/5blMkDw0XnPAToK2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488560; c=relaxed/simple;
	bh=uJE0LyZF6yVuQcphj9nsdtQM5hflRWAsEYJ7qpVTckA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iqc/Rf326I7WtHOuorQZzH1oEh4zPuVBes55c+jQivTzYCeRTsWA9iMXydR7+wpkKmzbeQmGV3HGljMuX54JKj7cyLCQ/VgXUQ5PI5q6KYRtKHxWhq3b1eJ8ExHnFgeEap1mPXL+K878X4gKDMKs73EUk4hl9DlwvVl8tLucPMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=duIZYYEQ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476964b2c1dso18341241cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1742488557; x=1743093357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSJhl8Ya+U9yAyNP3Wu79LvGc5zWv1+4r8Tqq+zSr98=;
        b=duIZYYEQ/DXp+E/JUVIBCqKmpYhcTxptuo09fVJ0RAv3rxd/ijpcrPp1N/MWY8Ykqy
         ZC7KWtD+esMPdkvFoGMSxRsOdSMw0GJuLWzRVwip2cYWpI0lpLhDS8lZg4DciaxnapOR
         OaJTEmHwNuV23nFyLYpA67JrfQXoAp5UsdrKDpgKiJNciUfCNUah04j6H6VAdEMFjbDK
         +XLinJHcciY2Ko4OVyL2oxm5kVsVxHud+IjqxK2OIxUBiXkE8yb/xnFgD3Kr+pBeggb+
         O+a9Tq5K617RCEge5zMABCJlq9xi+TLcdueY71IlVahFc3JxgFue5XcSkiK1c/Ddepgn
         4hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742488557; x=1743093357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSJhl8Ya+U9yAyNP3Wu79LvGc5zWv1+4r8Tqq+zSr98=;
        b=DkCCpwi8DMnpj9rbX5Su6Cf8cAUQA1pJWP/DKZNuc6Sgbvnec90aaQhBvcQZq8TdG2
         NT3r5NsGLi6qbbkSNsEBHPKaLm9xqNc4andIHGPMe72Ox1aws5yP4W/Z9dqc77YEz/vb
         XxQ5wpR2IkUcP1jCnBounT4JERkaww/iLgmFNlY747V6caG2Ad9+jhKusMLV9P0TYQ2y
         0uoKZziZd/jxricXnNHtgJF3JOVO75ontGYp/3wFSSEaJ3etUrztmJFcszwuaLnSmpV5
         P9FBy99sohMsQGubqFGuDuy5IdgYW+wjJfbhFIt4C9FhMjclpWcbFP2LHsN3KOF3/HcJ
         o37A==
X-Forwarded-Encrypted: i=1; AJvYcCWFYZX8JG62DCUS/+ZYal3BsE2SjdQuIVHvzv7TXTZWNIiyMc5JVo7B2Q3WlSs/f4UFtELa7/KSEQZDYuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwidvHoxY9Jzeeetp/qNFgZEWvN2iTiTzD5l8zqcVLhaSVdGCF5
	DWycLsxwpITRIsu+sydC3PNtFc4UdPziIWZJ/d+r5IrVF0/mFi+YBBTpPIAiYCSl1qDUi1NmfEW
	QqBkf6xw3KQgDN3xNRlvTTQgD/9qYLuapOyY+mg==
X-Gm-Gg: ASbGncuTzn1I87ssqURsVZKJJo0zV4F7xs5sU7FMhTmdSHXN27rIwQci1fe+APjHXhK
	jbD3k/ifSDzacBIrLTJp9It2owGUy/hl1LKuGjBmrRrmojId7GGO/qcZl0Z7bljA50TlcYkId5p
	Ddt6vxQk4JE8hqFSxsm+/0020=
X-Google-Smtp-Source: AGHT+IF0eXOQlc/TCcCLJjjH1RwfQ9Q7azG+hpO1bThoH01wQ+mnOSXeNm3Os2T9J32bHJKiD8UV6/78bbxc28Q/6yY=
X-Received: by 2002:a05:622a:11c7:b0:476:b06a:716e with SMTP id
 d75a77b69052e-4770841fd04mr103463281cf.34.1742488557448; Thu, 20 Mar 2025
 09:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
 <20250320024011.2995837-2-pasha.tatashin@soleen.com> <Z9wan08CpbvddHhc@smile.fi.intel.com>
In-Reply-To: <Z9wan08CpbvddHhc@smile.fi.intel.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 20 Mar 2025 12:35:20 -0400
X-Gm-Features: AQ5f1Jo9DEAuy95jWf1ZvdTmiidPtoTdbLtKofntA_8ycDVY8wy9zZs4pKR771U
Message-ID: <CA+CK2bDWJcrWpkk0asKUb46GYT-r9JdBMU-OUx3E4qjr6rVpGA@mail.gmail.com>
Subject: Re: [RFC v1 1/3] luo: Live Update Orchestrator
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: changyuanl@google.com, graf@amazon.com, rppt@kernel.org, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, leon@kernel.org, 
	lukas@wunner.de, bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, jgowans@amazon.com, jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 9:40=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 20, 2025 at 02:40:09AM +0000, Pasha Tatashin wrote:
> > Introduces the Live Update Orchestrator (LUO), a new kernel subsystem
> > designed to facilitate live updates. Live update is a method to reboot
> > the kernel while attempting to keep selected devices alive across the
> > reboot boundary, minimizing downtime.
> >
> > The primary use case is cloud environments, allowing hypervisor updates
> > without fully disrupting running virtual machines. VMs can be suspended
> > while the hypervisor kernel reboots, and devices attached to these VM
> > are kept operational by the LUO.
> >
> > Features introduced:
> >
> > - Core orchestration logic for managing the live update process.
> > - A state machine (NORMAL, PREPARED, UPDATED, *_FAILED) to track
> >   the progress of live updates.
> > - Notifier chains for subsystems (device layer, interrupts, KVM, IOMMU,
> >   etc.) to register callbacks for different live update events:
> >     - LIVEUPDATE_PREPARE: Prepare for reboot (before blackout).
> >     - LIVEUPDATE_REBOOT: Final serialization before kexec (blackout).
> >     - LIVEUPDATE_FINISH: Cleanup after update (after blackout).
> >     - LIVEUPDATE_CANCEL: Rollback actions on failure or user request.
> > - A sysfs interface (/sys/kernel/liveupdate/) for user-space control:
> >     - `prepare`: Initiate preparation (write 1) or reset (write 0).
> >     - `finish`: Finalize update in new kernel (write 1).
> >     - `cancel`: Abort ongoing preparation or reboot (write 1).
> >     - `reset`: Force state back to normal (write 1).
> >     - `state`: Read-only view of the current LUO state.
> >     - `enabled`: Read-only view of whether live update is enabled.
> > - Integration with KHO to pass orchestrator state to the new kernel.
> > - Version checking during startup of the new kernel to ensure
> >   compatibility with the previous kernel's live update state.
> >
> > This infrastructure allows various kernel subsystems to coordinate and
> > participate in the live update process, serializing and restoring devic=
e
> > state across a kernel reboot.
>
> ...
>
> > +Date:                March 2025
> > +KernelVersion:       6.14.0
>
> This is way too optimistic, it even won't make v6.15.
> And date can be chosen either v6.16-rc1 or v6.16 release
> in accordance with prediction tool

This is an early RFC and is not intended to be applied. I meant to
replace it with the appropriate version once it becomes a candidate to
land.

>
> ...
>
> > +#ifndef _LINUX_LIVEUPDATE_H
> > +#define _LINUX_LIVEUPDATE_H
>
> > +#include <linux/compiler.h>
> > +#include <linux/notifier.h>
>
> This is semi-random list of inclusions. Try to follow IWYU principle.
> See below.

I will remove <linux/compiler.h>

>
> ...
>
> > +bool liveupdate_state_updated(void);
>
> Where bool is defined?

in kernel/liveupdate.c

>
> ...
>
> > +/**
> > + * LIVEUPDATE_DECLARE_NOTIFIER - Declare a live update notifier with d=
efault
> > + * structure.
> > + * @_name: A base name used to generate the names of the notifier bloc=
k
> > + * (e.g., ``_name##_liveupdate_notifier_block``) and the callback func=
tion
> > + * (e.g., ``_name##_liveupdate``).
> > + * @_priority: The priority of the notifier, specified using the
> > + * ``enum liveupdate_cb_priority`` values
> > + * (e.g., ``LIVEUPDATE_CB_PRIO_BEFORE_DEVICES``).
> > + *
> > + * This macro declares a static struct notifier_block and a correspond=
ing
> > + * notifier callback function for use with the live update orchestrato=
r.
> > + * It simplifies the process by automatically handling the dispatching=
 of
> > + * live update events to separate handler functions for prepare, reboo=
t,
> > + * finish, and cancel.
> > + *
> > + * This macro expects the following functions to be defined:
> > + *
> > + * ``_name##_liveupdate_prepare()``:  Called on LIVEUPDATE_PREPARE.
> > + * ``_name##_liveupdate_reboot()``:   Called on LIVEUPDATE_REBOOT.
> > + * ``_name##_liveupdate_finish()``:   Called on LIVEUPDATE_FINISH.
> > + * ``_name##_liveupdate_cancel()``:   Called on LIVEUPDATE_CANCEL.
> > + *
> > + * The generated callback function handles the switch statement for th=
e
> > + * different live update events and calls the appropriate handler func=
tion.
> > + * It also includes warnings if the finish or cancel handlers return a=
n error.
> > + *
> > + * For example, declartion can look like this:
> > + *
> > + * ``static int foo_liveupdate_prepare(void) { ... }``
> > + *
> > + * ``static int foo_liveupdate_reboot(void) { ... }``
> > + *
> > + * ``static int foo_liveupdate_finish(void) { ... }``
> > + *
> > + * ``static int foo_liveupdate_cancel(void) { ... }``
> > + *
> > + * ``LIVEUPDATE_DECLARE_NOTIFIER(foo, LIVEUPDATE_CB_PRIO_WITH_DEVICES)=
;``
> > + *
>
> Hmm... Have you run kernel-doc validator? There is missing Return section=
 and
> it will warn about that.

I have, and there are no warnings. There is no return in this macro.

>
> > + */
>
> ...
>
> > +             WARN_ONCE(rv, "cancel failed[%d]\n", rv);               \
>
> + bug.h

I will include bug.h

>
> ...
>
> > + #undef pr_fmt
> > + #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> Leftover from the development?

Ah, yes, it is duplicated.

>
> > +#undef pr_fmt
>
> Not needed as long as pr_fmt9) is at the top of the file.

Thanks, I will remove it.

>
> > +#define pr_fmt(fmt)  KBUILD_MODNAME ": " fmt
>
> ...
>
> > +#include <linux/kernel.h>
>
> What for? Can you follow IWYU, please? Here again semi-random list of
> inclusions.

I will remove kernel.h and cpufreq.h and add
#include <linux/kobject.h>

> > +#include <linux/sysfs.h>
> > +#include <linux/string.h>
> > +#include <linux/rwsem.h>
> > +#include <linux/err.h>
> > +#include <linux/liveupdate.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/kexec_handover.h>
>
> Can you keep them ordered which will be easier to read and maintain?

Sure, I will order them alphabetically.

>
> ...
>
> > +static int __init early_liveupdate_param(char *buf)
> > +{
> > +     return kstrtobool(buf, &luo_enabled);
> > +}
>
> > +
>
> Redundant blank line.

OK

> > +early_param("liveupdate", early_liveupdate_param);
>
> ...
>
> > +/* Show the current live update state */
> > +static ssize_t state_show(struct kobject *kobj,
> > +                       struct kobj_attribute *attr,
>
> It is still enough room even for the strict 80 limit case.

OK

>
> > +                       char *buf)
> > +{
> > +     return sysfs_emit(buf, "%s\n", LUO_STATE_STR);
> > +}
>
> ...
>
> > +             ret =3D blocking_notifier_call_chain(&luo_notify_list,
> > +                                                event,
> > +                                                NULL);
>
> There is room on the previous lines. Ditto for the similar cases all over
> the code.

OK

>
> ...
>
> > +{
> > +     int ret;
> > +
> > +     if (down_write_killable(&luo_state_rwsem)) {
> > +             pr_warn(" %s, change state canceled by user\n", __func__)=
;
>
> Why __func__ is so important in _this_ message? And why leading space?
> Ditto for the similar cases.

removed __func__, and rewarded messages to be more descriptive in each case=
.

>
> > +             return -EAGAIN;
> > +     }
> > +
> > +     if (!IS_STATE(LIVEUPDATE_STATE_NORMAL)) {
> > +             pr_warn("Can't switch to [%s] from [%s] state\n",
> > +                     luo_state_str[LIVEUPDATE_STATE_PREPARED],
> > +                     LUO_STATE_STR);
> > +             up_write(&luo_state_rwsem);
> > +
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret =3D luo_notify(LIVEUPDATE_PREPARE);
> > +     if (!ret)
> > +             luo_set_state(LIVEUPDATE_STATE_PREPARED);
> > +
> > +     up_write(&luo_state_rwsem);
> > +
> > +     return ret;
> > +}
>
> ...
>
> > +static ssize_t prepare_store(struct kobject *kobj,
> > +                          struct kobj_attribute *attr,
> > +                          const char *buf,
> > +                          size_t count)
> > +{
> > +     ssize_t ret;
> > +     long val;
>
> > +     if (kstrtol(buf, 0, &val) < 0)
> > +             return -EINVAL;
>
> Shadower error code.

In this case it is appropriate, we do not case why kstrtol() could not
be converted into an appropriate integer, all we care is that the
input was invalid, and that what we return back to user.

>
>
> > +     if (val !=3D 1 && val !=3D 0)
> > +             return -EINVAL;
>
> What's wrong with using kstrtobool() from the beginning?

It makes the input less defined, here we only allow '1' or '0',
kstrtobool() allows almost anything.

>
> > +
> > +     if (val)
> > +             ret =3D luo_prepare();
> > +     else
> > +             ret =3D luo_cancel();
>
> > +     if (!ret)
> > +             ret =3D count;
> > +
> > +     return ret;
>
> Can we go with the usual pattern "check for errors first"?
>
>         if (ret)
>                 return ret;

Sure.

>
>         ...
>
> > +}
>
> ...
>
> > +static ssize_t finish_store(struct kobject *kobj,
> > +                         struct kobj_attribute *attr,
> > +                         const char *buf,
> > +                         size_t count)
>
> Same comments as per above.

OK

>
> ...
>
> > +static struct attribute *luo_attrs[] =3D {
> > +     &state_attribute.attr,
> > +     &prepare_attribute.attr,
> > +     &finish_attribute.attr,
>
> > +     NULL,
>
> No comma for the terminator entry.

Sure.

> > +};
>
> ...
>
> > +static int __init luo_init(void)
> > +{
> > +     int ret;
> > +
> > +     if (!luo_enabled || !kho_is_enabled()) {
> > +             pr_info("disabled by user\n");
> > +             luo_enabled =3D false;
> > +
> > +             return 0;
> > +     }
>
> Can be written like
>
>         if (!kho_is_enabled())
>                 luo_enabled =3D false;
>         if (!luo_enabled) {
>                 pr_info("disabled by user\n");
>                 return 0;
>         }

Sure

>
> > +     ret =3D sysfs_create_group(kernel_kobj, &luo_attr_group);
> > +     if (ret)
> > +             pr_err("Failed to create group\n");
> > +
> > +     luo_sysfs_initialized =3D true;
> > +     pr_info("Initialized\n");
> > +
> > +     return ret;
>
> Something is odd here between (non-)checking for errors and printed messa=
ges.

Thank you for pointing out, it is a bug, fixed.

>
> > +}
>
> ...
>
> > +EXPORT_SYMBOL_GPL(liveupdate_state_normal);
>
> No namespace?

Namespace is 'liveupdate_', all public interfaces have this prefix,
private functions are prefixed with luo_ where it makes sense.

>
> ...
>
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/syscore_ops.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/liveupdate.h>
>
> Can oyu preserve order (with given context at least)?

Yes.

>
> --
> With Best Regards,
> Andy Shevchenko

Thank you for your review.
Pasha

