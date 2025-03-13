Return-Path: <linux-kernel+bounces-560377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F8FA6034F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A9319C525C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CAE1F5404;
	Thu, 13 Mar 2025 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ytqwIeCe"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7F1F4E47
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900654; cv=none; b=qrTp4AKft1tlBicK+0ERrV41fwr3hxFKfCbFCX1rLd7bDuWhklqKDDwgNTVRKP5w6R0N+g9mW9QU6Ac0Cab+hq1JT+96Ao+p1sYCI6QsN/DrQDBWnDkMVhkJ4IPCefUHZv1+mLewzZHptnyhat+5heqjZ6UHX4ECoOq5GxuNqYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900654; c=relaxed/simple;
	bh=01VRN+5Oc9irHEStjkL1GRCI2Lde1v6sdm7SIfuSG90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/dVw2PP3r7bkiDVOUx6uf06V5q1+TyULLUm/UYyzwUJJEeIPglSIXkRdBi3IBPdMQrYUMARiiZr1Q4H+Ax3aUxdlCfzmcMcKrWxF6swC2NBYxbe5JpTdQYda2hI/aBKCDUmyVWlh3wEhHhdH7s9UnhEjTWIM/15AjSdZcd+u58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ytqwIeCe; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30761be8fa8so15951991fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741900651; x=1742505451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhkAlSKazQUgE7RGBPfARnD6ogRZRA0FONKRofLoCLE=;
        b=ytqwIeCeH2WuSHRdrXSOWX0AkQnxlYUtnxCH1UjMQbBMGXeq95wYDPkbthroEND9hu
         Fi1azVu407qBVdNRGuvfd1506XLnoilWw2rijssRa7offzG3TpP17Az5YiqJnpC2/9dh
         6QrDOg34m9fTyvEQvzUeXqJWAY55If+XKLcTNShk4C6sOn2sV1dcBMYUtlsssxyM560S
         yRnYtY0f3ST391z//pmtBP9F6P5lxJ0UmMcVngC58aCRVgQ840N0hJ5T0vGEygr6rnHg
         XyTRHMmXGfNpyt2mef6yI+m95deB5ZlxnkwFKSHnsibBy82/Ff/sRZtNiwt1j7MwMKEb
         gwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900651; x=1742505451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhkAlSKazQUgE7RGBPfARnD6ogRZRA0FONKRofLoCLE=;
        b=jomTksunuSLh7PZ7Rh8RnbWk104fUdXo1RVMTC29v1iE+SPzzaaakEslufT1mFjlDM
         i+kxzaEn5EiU6jJSaIF478wdYcFfxlyfWaDgtz1v1qjhV148jgdsWsbt3yHlgm5tRuct
         lV5243s63uSgLGid9hhOg47hTLJ6tCRc9DNl3TzFytxYYikki5UreUIgKuGw2LRpxR6j
         YXwJayUb2kupsQHzqIRVzYongEJ+jdFhBkdxm0nBThZavbPB+6ZwE4O1aVW7Ehm4ij2O
         8H3hWp0UPsxHr3xK7N/DiNj5u5exAUnEAgNosqFLJpxikyoOO2nk8wOuDa+T9rtyugja
         i1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0Suv8RUASeZIZR7DmnZgvdNBGptGresmnhhdvHVrW2QZe4LecbZY29Awkzsb+cm2hsodvWgxHJadZSvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQNorr9uuklkOhp4ulY//Ex7sdLHMBuXTbogh4mKDTYbBVhLBs
	p/4ch0qu9zojO2NXlFD9a1vWjoqek/LproKBWL6568ePpN+SpnqgCDHxCyNBtbe8YmzzV3kOsMr
	F6diWLB4DoBSSOqUMzoJ/J/aXWVBFTMJ29+t9dQoHQCTgQpn+Ww==
X-Gm-Gg: ASbGnctKQbkL9F+jUQm+VDUvDTsDCY7DKlldNkOmXCByWqhWJMJVuzIpuuLCrxzuI+f
	nfXuqghuN/QujKCrj9mM4f7zqQih2No0v8g6cQNullHSyxYO0Wy4U9Jp08pGsXi1VEKUZMRfFHy
	KTMb07AR0IQxW4ql9I5BUEmfbwkuHnFC9kVYBHaUkY1rvfXVn4cVBb
X-Google-Smtp-Source: AGHT+IHpcFYH3qu9oy6WAGpbgXTmT2cVC2uZtZhaiTmrNNrp46WN1fnPTaNpmFiMSu5PTHs+sKTsHw4eWpmXe1w0JIk=
X-Received: by 2002:a05:6512:2245:b0:545:cc5:be90 with SMTP id
 2adb3069b0e04-549c398cf85mr675e87.35.1741900650569; Thu, 13 Mar 2025 14:17:30
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1915694.tdWV9SEqCh@rjwysocki.net> <3346996.44csPzL39Z@rjwysocki.net>
In-Reply-To: <3346996.44csPzL39Z@rjwysocki.net>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 13 Mar 2025 14:16:53 -0700
X-Gm-Features: AQ5f1JqxGU7xdKfoZCTUD1pMRE0GPTNiFz9ZzFSL5dzH7hIedByvRUtJrpoUSOw
Message-ID: <CAGETcx_s1YHMQraDS23iPkax_rAF7u7BrC7nP4mQjZHZ5Rww6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: sleep: Resume children after resuming the parent
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 1:35=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> According to [1], the handling of device suspend and resume, and
> particularly the latter, involves unnecessary overhead related to
> starting new async work items for devices that cannot make progress
> right away because they have to wait for other devices.
>
> To reduce this problem in the resume path, use the observation that
> starting the async resume of the children of a device after resuming
> the parent is likely to produce less scheduling and memory management
> noise than starting it upfront while at the same time it should not
> increase the resume duration substantially.
>
> Accordingly, modify the code to start the async resume of the device's
> children when the processing of the parent has been completed in each
> stage of device resume and only start async resume upfront for devices
> without parents.
>
> Also make it check if a given device can be resumed asynchronously
> before starting the synchronous resume of it in case it will have to
> wait for another that is already resuming asynchronously.
>
> In addition to making the async resume of devices more friendly to
> systems with relatively less computing resources, this change is also
> preliminary for analogous changes in the suspend path.
>
> On the systems where it has been tested, this change by itself does
> not affect the overall system resume duration in a significant way.
>
> Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravanak=
@google.com/ [1]
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v1 -> v2:
>    Use a separate lock for power.work_in_progress protection which should
>    reduce lock contention on dpm_list_mtx.
>
> ---
>  drivers/base/power/main.c |   80 +++++++++++++++++++++++++++++++++++----=
-------
>  1 file changed, 61 insertions(+), 19 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -63,6 +63,7 @@
>  static DEFINE_MUTEX(dpm_list_mtx);
>  static pm_message_t pm_transition;
>
> +static DEFINE_MUTEX(async_wip_mtx);

I think (not sure) this can be a spinlock.

>  static int async_error;
>
>  static const char *pm_verb(int event)
> @@ -597,8 +598,11 @@
>                 && !pm_trace_is_enabled();
>  }
>
> -static bool dpm_async_fn(struct device *dev, async_func_t func)
> +static bool __dpm_async(struct device *dev, async_func_t func)
>  {
> +       if (dev->power.work_in_progress)
> +               return true;
> +
>         if (!is_async(dev))
>                 return false;
>
> @@ -611,14 +615,37 @@
>
>         put_device(dev);
>
> +       return false;
> +}
> +
> +static bool dpm_async_fn(struct device *dev, async_func_t func)
> +{
> +       guard(mutex)(&async_wip_mtx);
> +
> +       return __dpm_async(dev, func);
> +}
> +
> +static int dpm_async_with_cleanup(struct device *dev, void *fn)
> +{
> +       guard(mutex)(&async_wip_mtx);
> +
> +       if (!__dpm_async(dev, fn))
> +               dev->power.work_in_progress =3D false;
> +
> +       return 0;
> +}
> +
> +static void dpm_async_resume_children(struct device *dev, async_func_t f=
unc)
> +{
>         /*
> -        * async_schedule_dev_nocall() above has returned false, so func(=
) is
> -        * not running and it is safe to update power.work_in_progress wi=
thout
> -        * extra synchronization.
> +        * Start processing "async" children of the device unless it's be=
en
> +        * started already for them.
> +        *
> +        * This could have been done for the device's "async" consumers t=
oo, but
> +        * they either need to wait for their parents or the processing h=
as
> +        * already started for them after their parents were processed.
>          */
> -       dev->power.work_in_progress =3D false;
> -
> -       return false;
> +       device_for_each_child(dev, func, dpm_async_with_cleanup);

Continuing my comments from v1 here, it's not a good assumption to
make that the child can start resuming just because the parent has
finished resuming. In my example, I have 386 device links and ~600
devices that have some sort of suspend ops (I think the total device
node count is ~1700).

I'm even more confused by why you think resume needs to be asymmetric
with suspend. In suspend, you kick off all the suppliers too when a
device is done suspending, but in resume you don't kick off all the
consumers.

>  }
>
>  static void dpm_clear_async_state(struct device *dev)
> @@ -627,6 +654,8 @@
>         dev->power.work_in_progress =3D false;
>  }
>
> +static void async_resume_noirq(void *data, async_cookie_t cookie);
> +
>  /**
>   * device_resume_noirq - Execute a "noirq resume" callback for given dev=
ice.
>   * @dev: Device to handle.
> @@ -710,6 +739,8 @@
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async noirq" : " noirq",=
 error);
>         }
> +
> +       dpm_async_resume_children(dev, async_resume_noirq);
>  }
>
>  static void async_resume_noirq(void *data, async_cookie_t cookie)
> @@ -733,19 +764,20 @@
>         mutex_lock(&dpm_list_mtx);
>
>         /*
> -        * Trigger the resume of "async" devices upfront so they don't ha=
ve to
> -        * wait for the "non-async" ones they don't depend on.
> +        * Start processing "async" devices without parents upfront so th=
ey
> +        * don't wait for the "sync" devices they don't depend on.
>          */
>         list_for_each_entry(dev, &dpm_noirq_list, power.entry) {
>                 dpm_clear_async_state(dev);
> -               dpm_async_fn(dev, async_resume_noirq);
> +               if (!dev->parent)

This check isn't sufficient. There are plenty of devices where they
have no parent, but they have many suppliers. That's the reality in
the DT world. And when you do deeper down the tree
(dpm_async_resume_children), the children typically have more
suppliers.

You can also check for "no suppliers" to find the true leaf nodes and
start with them, but that means you also have to kick off the
consumers when you finish your resume. We definitely need to check
device links for this patchset to be useful for me. With my patch
series, it's effectively just NCPU kworkers running continuously on
each CPU. Won't be the case if we don't check the device links. And as
I said before, the overhead isn't just about context switches, but
also forking more kworker threads.


-Saravana

> +                       dpm_async_with_cleanup(dev, async_resume_noirq);
>         }
>
>         while (!list_empty(&dpm_noirq_list)) {
>                 dev =3D to_device(dpm_noirq_list.next);
>                 list_move_tail(&dev->power.entry, &dpm_late_early_list);
>
> -               if (!dev->power.work_in_progress) {
> +               if (!dpm_async_fn(dev, async_resume_noirq)) {
>                         get_device(dev);
>
>                         mutex_unlock(&dpm_list_mtx);
> @@ -781,6 +813,8 @@
>         device_wakeup_disarm_wake_irqs();
>  }
>
> +static void async_resume_early(void *data, async_cookie_t cookie);
> +
>  /**
>   * device_resume_early - Execute an "early resume" callback for given de=
vice.
>   * @dev: Device to handle.
> @@ -848,6 +882,8 @@
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async early" : " early",=
 error);
>         }
> +
> +       dpm_async_resume_children(dev, async_resume_early);
>  }
>
>  static void async_resume_early(void *data, async_cookie_t cookie)
> @@ -875,19 +911,20 @@
>         mutex_lock(&dpm_list_mtx);
>
>         /*
> -        * Trigger the resume of "async" devices upfront so they don't ha=
ve to
> -        * wait for the "non-async" ones they don't depend on.
> +        * Start processing "async" devices without parents upfront so th=
ey
> +        * don't wait for the "sync" devices they don't depend on.
>          */
>         list_for_each_entry(dev, &dpm_late_early_list, power.entry) {
>                 dpm_clear_async_state(dev);
> -               dpm_async_fn(dev, async_resume_early);
> +               if (!dev->parent)
> +                       dpm_async_with_cleanup(dev, async_resume_early);
>         }
>
>         while (!list_empty(&dpm_late_early_list)) {
>                 dev =3D to_device(dpm_late_early_list.next);
>                 list_move_tail(&dev->power.entry, &dpm_suspended_list);
>
> -               if (!dev->power.work_in_progress) {
> +               if (!dpm_async_fn(dev, async_resume_early)) {
>                         get_device(dev);
>
>                         mutex_unlock(&dpm_list_mtx);
> @@ -919,6 +956,8 @@
>  }
>  EXPORT_SYMBOL_GPL(dpm_resume_start);
>
> +static void async_resume(void *data, async_cookie_t cookie);
> +
>  /**
>   * device_resume - Execute "resume" callbacks for given device.
>   * @dev: Device to handle.
> @@ -1018,6 +1057,8 @@
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async" : "", error);
>         }
> +
> +       dpm_async_resume_children(dev, async_resume);
>  }
>
>  static void async_resume(void *data, async_cookie_t cookie)
> @@ -1049,19 +1090,20 @@
>         mutex_lock(&dpm_list_mtx);
>
>         /*
> -        * Trigger the resume of "async" devices upfront so they don't ha=
ve to
> -        * wait for the "non-async" ones they don't depend on.
> +        * Start processing "async" devices without parents upfront so th=
ey
> +        * don't wait for the "sync" devices they don't depend on.
>          */
>         list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
>                 dpm_clear_async_state(dev);
> -               dpm_async_fn(dev, async_resume);
> +               if (!dev->parent)
> +                       dpm_async_with_cleanup(dev, async_resume);
>         }
>
>         while (!list_empty(&dpm_suspended_list)) {
>                 dev =3D to_device(dpm_suspended_list.next);
>                 list_move_tail(&dev->power.entry, &dpm_prepared_list);
>
> -               if (!dev->power.work_in_progress) {
> +               if (!dpm_async_fn(dev, async_resume)) {
>                         get_device(dev);
>
>                         mutex_unlock(&dpm_list_mtx);
>
>
>

