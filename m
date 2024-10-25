Return-Path: <linux-kernel+bounces-382775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083089B1351
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 01:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF151C21434
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1367920D50A;
	Fri, 25 Oct 2024 23:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1J5w9iB"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F6157E99
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 23:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729899310; cv=none; b=CpjwmasBdYOmCS2FcLRxhFzWCy9Rwf5VmUENTgLbe5bZ80/eGadHM0iwBMaFU+ErAQm/ISztXQ4j70EPVvN1QCRGBl8EAwCoFC6Z+9J8iVLdkrjeqSTI915A/IcMQbHirQfhjqoF+Y6+LCLPkErrhgJE64fIbioSfdovNO14Uo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729899310; c=relaxed/simple;
	bh=b5GAWGLKjfUB7uDZ47/13dYmyWMgtOKSTl2HDb0W2mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpQ06p9N1fnk+8D06KzUiyo2LN0XTDVPq5Fya7XxeHgShO0EdIUUMq9sCCgV0/8RBoFYTzPLX7zE5j+KBy+8cRLBq+Ia9SAVGKGjO0H/nUxftVSU29YET+eLXJ8z1dr3ViTFnKd9knS6+RhWmj+01iA6ZEQsQWb6aCyiqanoK8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d1J5w9iB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso1858912b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729899307; x=1730504107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCoLSGzjbtcBrD1uHaLhj0VXdRbCmIaCg29GLb5RnkE=;
        b=d1J5w9iBuV+Zmu9S9Nhe9+ARS5EsRWxk9AFR4Ze1WWv70C/DewSUTI13YsmK9aziXj
         45oNYAUBuzKtP5pKHl9rxtEeJNWdYF729JklXh26M4AZBq9B0MT8J/8ApMVygaaht1Hc
         oR8Fo42VE5QO/ucMvwBxzcb9eHkZLATH9P2YwtJbWfDxVrnkebe+ALfoUu8CtK6pk5xV
         +yzc5yHuNZOMC0Mzc+I1B/MLyNC4rpiQ9g4wvzOJKFETmOC3fwcLfbZQDZ0XEHEm3Np5
         E1kGzkttL9jR7/7qP8PvlAuLTk4vEVAAYBzaZd9tn7EmaCzRqds3U/q149YQvKca8JGn
         8Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729899307; x=1730504107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCoLSGzjbtcBrD1uHaLhj0VXdRbCmIaCg29GLb5RnkE=;
        b=KAAng0H6G57bdjP85EqAYHiD2qovGbmOVUdhFj8HPpm0MWwDC9cXjQgOxzI99yfoKf
         oH28jVOF+zsfYaNsxuhI0/I0Di7vGEkiSTzC/r1EzaQOb0TZskJjOXr/FQmh6yjLjGCY
         kW7XgXHHlNUgbWLSyc7TeBbrw3kwlzJoDKg9JbnGhHnxT7FZEGghnjf6NY1UggpxDqDH
         Qu9LQ9KT2ta2acWHXQjekwQ8Rgd/siBr4LYbumNlybM/B1n1NHnBJggLXwJ1jC6AQOgN
         jRK9v7xAlxloFucfL+T0W0AcCYseSEbIU9wuSMlujfuDfPHxIuetYXSwuQGLUf6Wl2gv
         ijJg==
X-Forwarded-Encrypted: i=1; AJvYcCXTFn1aO7B/IlX4sjgjh1ZBiO5Gbvbqy88egpYlqWqUBfOPYxwKA+aK2+MB4a/K0ZvKy1LEvRvs116aE30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs6GwMi1JHuL/wTgJBMPfAPiLIRSGkT2WfRjVkZZ+r7exZnkNq
	hTRHFNoQOntomml7HwEuGzTkRnwGVLt9MgFxbgRvAf7qgW1EMtiMPv6g3BllMPhME03oWLsW+el
	Z/aAtPv8nHtqAOUaf9BFCBUu5hlWrp5dZLViUvr5PaMOjVmZEILoXzNo=
X-Google-Smtp-Source: AGHT+IFTN5BbCRBKeUP725s/tOzTtNXmLOlE5qilPeW72lNy5o+RjpK66YFmZCSYZDuKKgtgXnerB1VIiHONPkN1wsI=
X-Received: by 2002:a05:6a00:9a4:b0:71e:6ec9:fcda with SMTP id
 d2e1a72fcca58-7206303a603mr2037220b3a.19.1729899306959; Fri, 25 Oct 2024
 16:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025223721.184998-1-saravanak@google.com>
In-Reply-To: <20241025223721.184998-1-saravanak@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 25 Oct 2024 16:34:28 -0700
Message-ID: <CAGETcx9unBjGosuv3XMMujRA6A=BW8RJWWyYuHgz7EO6nmk9eA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] driver core: fw_devlink: Detect cycles when the
 supplier never gets a device
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 3:37=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> Sometimes the supplier fwnode never gets a device created for it.  Instea=
d,
> the supplier fwnode is represented by the device that corresponds a
> parent/ancestor fwnode.
>
> In these cases, we currently don't do any cycle detection because the cyc=
le
> detection logic is only run when a device link is created between the
> devices that correspond to the actual consumer and supplier fwnodes.
>
> To detect these cycles correctly, run cycle detection logic even when
> creating SYNC_STATE_ONLY proxy device links from a device that is the
> parent of the consumer.
>
> Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Closes: https://lore.kernel.org/all/1a1ab663-d068-40fb-8c94-f0715403d276@=
ideasonboard.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Tomi,
>
> I didn't have a chance yet to test this on my end. But I expect that
> this will allow the display to probe in your single-link case without
> having to add post-init-providers. You should still add it for better
> probe/suspend/resume/shutdown ordering.
>
> While you test this, can you also do a diff of with and without this
> change? It shouldn't have significant differences (other than the ones
> with actual cycles):
>
> ls -1 /sys/class/devlink
>
> Greg,
>
> This is RFC because I haven't tested it on my end. I need to do that
> before I'd be okay merging this.
>
> Thanks,
> Saravana
>
>  drivers/base/core.c | 45 +++++++++++++++++----------------------------
>  1 file changed, 17 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3b13fed1c3e3..cf20101c74ac 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1990,10 +1990,10 @@ static struct device *fwnode_get_next_parent_dev(=
const struct fwnode_handle *fwn
>   *
>   * Return true if one or more cycles were found. Otherwise, return false=
.
>   */
> -static bool __fw_devlink_relax_cycles(struct device *con,
> +static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
>                                  struct fwnode_handle *sup_handle)
>  {
> -       struct device *sup_dev =3D NULL, *par_dev =3D NULL;
> +       struct device *sup_dev =3D NULL, *par_dev =3D NULL, *con_dev =3D =
NULL;
>         struct fwnode_link *link;
>         struct device_link *dev_link;
>         bool ret =3D false;
> @@ -2010,22 +2010,22 @@ static bool __fw_devlink_relax_cycles(struct devi=
ce *con,
>
>         sup_handle->flags |=3D FWNODE_FLAG_VISITED;
>
> -       sup_dev =3D get_dev_from_fwnode(sup_handle);
> -
>         /* Termination condition. */
> -       if (sup_dev =3D=3D con) {
> +       if (sup_handle =3D=3D con_handle) {
>                 pr_debug("----- cycle: start -----\n");
>                 ret =3D true;
>                 goto out;
>         }
>
> +       sup_dev =3D get_dev_from_fwnode(sup_handle);
> +       con_dev =3D get_dev_from_fwnode(con_handle);
>         /*
>          * If sup_dev is bound to a driver and @con hasn't started bindin=
g to a
>          * driver, sup_dev can't be a consumer of @con. So, no need to ch=
eck
>          * further.
>          */
>         if (sup_dev && sup_dev->links.status =3D=3D  DL_DEV_DRIVER_BOUND =
&&
> -           con->links.status =3D=3D DL_DEV_NO_DRIVER) {
> +           con_dev->links.status =3D=3D DL_DEV_NO_DRIVER) {

This needs to be changed to the following to avoid a NULL deref:

con_dev && con_dev->links.status =3D=3D DL_DEV_NO_DRIVER) {

My preliminary testing looks good. Once I'm happy with my tests, I'll
fix this and send out a v2.

Tomi, if this fixes your issue, please give a Tested-by:

-Saravana

>                 ret =3D false;
>                 goto out;
>         }
> @@ -2034,7 +2034,7 @@ static bool __fw_devlink_relax_cycles(struct device=
 *con,
>                 if (link->flags & FWLINK_FLAG_IGNORE)
>                         continue;
>
> -               if (__fw_devlink_relax_cycles(con, link->supplier)) {
> +               if (__fw_devlink_relax_cycles(con_handle, link->supplier)=
) {
>                         __fwnode_link_cycle(link);
>                         ret =3D true;
>                 }
> @@ -2049,7 +2049,7 @@ static bool __fw_devlink_relax_cycles(struct device=
 *con,
>         else
>                 par_dev =3D fwnode_get_next_parent_dev(sup_handle);
>
> -       if (par_dev && __fw_devlink_relax_cycles(con, par_dev->fwnode)) {
> +       if (par_dev && __fw_devlink_relax_cycles(con_handle, par_dev->fwn=
ode)) {
>                 pr_debug("%pfwf: cycle: child of %pfwf\n", sup_handle,
>                          par_dev->fwnode);
>                 ret =3D true;
> @@ -2067,7 +2067,7 @@ static bool __fw_devlink_relax_cycles(struct device=
 *con,
>                     !(dev_link->flags & DL_FLAG_CYCLE))
>                         continue;
>
> -               if (__fw_devlink_relax_cycles(con,
> +               if (__fw_devlink_relax_cycles(con_handle,
>                                               dev_link->supplier->fwnode)=
) {
>                         pr_debug("%pfwf: cycle: depends on %pfwf\n", sup_=
handle,
>                                  dev_link->supplier->fwnode);
> @@ -2139,26 +2139,15 @@ static int fw_devlink_create_devlink(struct devic=
e *con,
>             fwnode_is_ancestor_of(sup_handle, con->fwnode))
>                 return -EINVAL;
>
> -       /*
> -        * SYNC_STATE_ONLY device links don't block probing and supports =
cycles.
> -        * So, one might expect that cycle detection isn't necessary for =
them.
> -        * However, if the device link was marked as SYNC_STATE_ONLY beca=
use
> -        * it's part of a cycle, then we still need to do cycle detection=
. This
> -        * is because the consumer and supplier might be part of multiple=
 cycles
> -        * and we need to detect all those cycles.
> -        */
> -       if (!device_link_flag_is_sync_state_only(flags) ||
> -           flags & DL_FLAG_CYCLE) {
> -               device_links_write_lock();
> -               if (__fw_devlink_relax_cycles(con, sup_handle)) {
> -                       __fwnode_link_cycle(link);
> -                       flags =3D fw_devlink_get_flags(link->flags);
> -                       pr_debug("----- cycle: end -----\n");
> -                       dev_info(con, "Fixed dependency cycle(s) with %pf=
wf\n",
> -                                sup_handle);
> -               }
> -               device_links_write_unlock();
> +       device_links_write_lock();
> +       if (__fw_devlink_relax_cycles(link->consumer, sup_handle)) {
> +               __fwnode_link_cycle(link);
> +               flags =3D fw_devlink_get_flags(link->flags);
> +               pr_debug("----- cycle: end -----\n");
> +               pr_info("%pfwf: Fixed dependency cycle(s) with %pfwf\n",
> +                       link->consumer, sup_handle);
>         }
> +       device_links_write_unlock();
>
>         if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
>                 sup_dev =3D fwnode_get_next_parent_dev(sup_handle);
> --
> 2.47.0.163.g1226f6d8fa-goog
>

