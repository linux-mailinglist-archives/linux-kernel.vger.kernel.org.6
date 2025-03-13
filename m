Return-Path: <linux-kernel+bounces-558692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FAEA5E986
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C0D189D171
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A44250EC;
	Thu, 13 Mar 2025 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ji0YQxkn"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860EA5234
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741830442; cv=none; b=U4zCBHuuXJ0s43YLOmzIxgtV0Gd8I/Rs4+mNoUUqBABzTK5g0qKgVY3acOVNdsrnccsfXgTPTlE1BLTG4JKBlKMRrMs4+wv9Rm/RCrLHVz1ixBCNw7UJF9eCecoHi/sO3RJKpTNwLOhGUPFGlpvaDyN08HzR1r3StAB/5tab1uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741830442; c=relaxed/simple;
	bh=CNzX2BLt9vSy0RwqsvvJFnXAbLJjSgMYXeOXRYHsjfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=us7GkA8TOfD3G52yBXMqF3MzgxIdz9PVp2mvQjPVZsA0oanOIfygmx/PI2ifPEqv3jebB39IQ6qx1Q0z1Cf9YIlyxpIk3ncuakOpQcnj5JmP2Pzd8DXk3K4Tf4eAnbs9wV7RFzK+pmbVC1IvuPXycNgHe8SBi0jr34IYy6aMG8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ji0YQxkn; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30761be8fa8so5523911fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741830438; x=1742435238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxo19Z41i1BGllZFR/UFGbGYG0KQe5O29loXSOdObiM=;
        b=Ji0YQxknpRrUBH55FrPVD9hpXuEXDMhMhUPELz69eGISqzpqhi/Ze30ZlQj7oS5ROA
         HXaJkoWx9H3SushWL7uXsrGpbxR5/QbaE4GiJwXIolYEY72zsfTkXomqqOUsvSg1Wd5n
         O+ZZeAoKxaobifggQRu038D6C22k2pwxbEY/n8pk7MNq+me9SkB9auLiGzlpVDLDcuUE
         nHv9SMeKXltU86wXp47qnyNeF2ictso8OCkVV/C2wNwnsI/axcxDOvNss1w+2+++gJu1
         PvYieS76Tvk20rgLoAKSi16TQHdhtwrM/RpGWU8hfcg9DM3CSB7/eD/ylHyjZm1oC9w/
         mW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741830438; x=1742435238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxo19Z41i1BGllZFR/UFGbGYG0KQe5O29loXSOdObiM=;
        b=DmrqKahV/hC/GUHnCu2zfNKgK2U4ByvZ6554mX7vEc8xRarDzak7dHIzmjEdDddxR5
         D8aFxPBRVQLXBxCXP78ZlCjQQJ9C5PUVUGN0OGaNkwBbZGqkWJ+5/JM/QMmThasKtMPe
         Ey8ozlc3qNmctvmGllFVKhbUCTaYGAWd79ldiFVe15SMkyanYGn9vF3+IJMq38oGjCs0
         HpRf4rzZuWyaIuAoaB3XqGS0Qp6a0ivpLBaGY3s7pqV/K55nE2DLo+59lcf+yzteg9e9
         m8PLocNs+56335g5gShmBSqEEwOvcytLPcalMVVbigwXScraORjw+9epCs4K1at10EFo
         RXXA==
X-Forwarded-Encrypted: i=1; AJvYcCWDKn7HbP8gmolCC1YKrG1k78jxwL5ygjO1JNFBvexIr9+5GkXmaE1m49UqrJv1YABd9xaMgXFLsyOZqhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9yJoEgpukg+VCOr/AOW8bEftPHyVOyCk3C4wOlEqnDZUVdW3i
	WfY2AOCl0+087TcyHpq56mnWeW9jso7sLLtGjnxhk1EQGOCirnH3XeC7/9xsAQlGHDWrlN5D2i5
	Y4z/7g9DhyAlyVZhBto4YQCtfHXHuMTyl52gLF3jAGu7DG/YizQ==
X-Gm-Gg: ASbGncvLukI+4MI3q+4IbmL5wNpfpl8mxcIx6ZGqv4+fbXBVDw3oZpXrOoWpYJHHH5C
	5n8g1JeBzpTCZkF27MsI4BKtAeZjV6tixkGngslfWO2mQqv0jCz1is5UbQ9mjspVFzpsyI84J8l
	6/QfsosmwAHUJ7Ndz1XoBV7OR7R1BOqhea4Udyy+0XwabOkW61DDrN7lMpsBCu1JU=
X-Google-Smtp-Source: AGHT+IHBMMlR+WeA0g0MIwwF5aBQXbpjbTmUfMWTU50ympR1rsZPq4VdmUa2cc0kWXmoeoa0ebTlcEsJ+7I4yxZ4kS8=
X-Received: by 2002:a05:6512:3dab:b0:549:4e88:2e6a with SMTP id
 2adb3069b0e04-54990e2bca7mr9022964e87.6.1741830437391; Wed, 12 Mar 2025
 18:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net> <8536271.NyiUUSuA9g@rjwysocki.net>
In-Reply-To: <8536271.NyiUUSuA9g@rjwysocki.net>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 12 Mar 2025 18:46:40 -0700
X-Gm-Features: AQ5f1Jq-16AfGXUjWcMj9D0w6-WVNfS-_YrMcJ1i9u46rv9rFjfsh6vZwFCgFc8
Message-ID: <CAGETcx8htyu635DhuE_+2X7RzwBwcvT7Wdkh9RL7Zswf1B079A@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] PM: sleep: Start suspending parents and suppliers
 after subordinate suspend
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:46=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> In analogy with the previous change affecting the resume path,
> make device_suspend() start the async suspend of the device's parent
> and suppliers after the device itself has been processed and make
> dpm_suspend() start processing "async" leaf devices (that is, devices
> without children or consumers) upfront because they don't need to wait
> for any other devices.
>
> On the Dell XPS13 9360 in my office, this change reduces the total
> duration of device suspend by approximately 100 ms (over 20%).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c |   73 +++++++++++++++++++++++++++++++++++++++=
++++---
>  1 file changed, 69 insertions(+), 4 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1237,6 +1237,49 @@
>
>  /*------------------------- Suspend routines -------------------------*/
>
> +static bool dpm_leaf_device(struct device *dev)
> +{
> +       struct device *child;
> +
> +       lockdep_assert_held(&dpm_list_mtx);
> +
> +       child =3D device_find_any_child(dev);
> +       if (child) {
> +               put_device(child);
> +
> +               return false;
> +       }
> +
> +       /*
> +        * Since this function is required to run under dpm_list_mtx, the
> +        * list_empty() below will only return true if the device's list =
of
> +        * consumers is actually empty before calling it.
> +        */
> +       return list_empty(&dev->links.consumers);
> +}
> +
> +static void dpm_async_suspend_superior(struct device *dev, async_func_t =
func)
> +{
> +       struct device_link *link;
> +
> +       mutex_lock(&dpm_list_mtx);
> +
> +       /* Start processing the device's parent if it is "async". */
> +       if (dev->parent)
> +               dpm_async_unless_in_progress(dev->parent, func);
> +
> +       /*
> +        * Start processing the device's "async" suppliers.
> +        *
> +        * The dpm_list_mtx locking is sufficient for this.
> +        */

Why is dpm_list_mtx sufficient? Is it because you are assuming no
driver is trying to change the device links during suspend/resume? Or
is there some other reason? That sounds a bit risky. Is it because if
you do, you'll hit a AB-BA deadlock or at least a lockdep warning?
Also, if we can use the device links read locks, we won't block the
other readers -- so, less contention.

> +       list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
> +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> +                       dpm_async_unless_in_progress(link->consumer, func=
);

This will still queue a lot of devices that can't suspend yet.

Curious, how many devices do you have in the system where you are testing t=
his?

-Saravana

> +
> +       mutex_unlock(&dpm_list_mtx);
> +}
> +
>  /**
>   * resume_event - Return a "resume" message for given "suspend" sleep st=
ate.
>   * @sleep_state: PM message representing a sleep state.
> @@ -1663,6 +1706,8 @@
>         device_links_read_unlock(idx);
>  }
>
> +static void async_suspend(void *data, async_cookie_t cookie);
> +
>  /**
>   * device_suspend - Execute "suspend" callbacks for given device.
>   * @dev: Device to handle.
> @@ -1791,7 +1836,13 @@
>
>         complete_all(&dev->power.completion);
>         TRACE_SUSPEND(error);
> -       return error;
> +
> +       if (error || async_error)
> +               return error;
> +
> +       dpm_async_suspend_superior(dev, async_suspend);
> +
> +       return 0;
>  }
>
>  static void async_suspend(void *data, async_cookie_t cookie)
> @@ -1809,6 +1860,7 @@
>  int dpm_suspend(pm_message_t state)
>  {
>         ktime_t starttime =3D ktime_get();
> +       struct device *dev;
>         int error =3D 0;
>
>         trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
> @@ -1822,15 +1874,28 @@
>
>         mutex_lock(&dpm_list_mtx);
>
> +       /*
> +        * Start processing "async" leaf devices upfront because they don=
't need
> +        * to wait.
> +        */
> +       list_for_each_entry_reverse(dev, &dpm_prepared_list, power.entry)=
 {
> +               dpm_clear_async_state(dev);
> +               if (dpm_leaf_device(dev))
> +                       dpm_async_fn(dev, async_suspend);
> +       }
> +
>         while (!list_empty(&dpm_prepared_list)) {
> -               struct device *dev =3D to_device(dpm_prepared_list.prev);
> +               dev =3D to_device(dpm_prepared_list.prev);
>
>                 list_move(&dev->power.entry, &dpm_suspended_list);
>
> -               dpm_clear_async_state(dev);
> -               if (dpm_async_fn(dev, async_suspend))
> +               dpm_async_unless_in_progress(dev, async_suspend);
> +
> +               if (dev->power.work_in_progress)
>                         continue;
>
> +               dev->power.work_in_progress =3D true;
> +
>                 get_device(dev);
>
>                 mutex_unlock(&dpm_list_mtx);
>
>
>

