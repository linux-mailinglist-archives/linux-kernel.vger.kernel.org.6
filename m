Return-Path: <linux-kernel+bounces-397380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EDA9BDB38
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4EF1C221BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7173318B47E;
	Wed,  6 Nov 2024 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUjew3K0"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8CC185B58
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856667; cv=none; b=a8v8Q/b6ffGesyklslWXniA6pmYGTtHYu8ADGzO6RwVhOHYN2cBdMjjh94lH6LWPIMEa10QCT4UHYiZB9A71JxeAjSrBdHaeeFahSo1EuEMQGU1D6WCF2Nj7X2GbajBCH1WCvE3s5xX7ZZF7tPGqE4aykQh9HR+/ExOdGzV57as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856667; c=relaxed/simple;
	bh=vzFB9xStOCX972cpMon5YnTYpZ/raQM0JduXXuU2Kfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFOQd2fWjiQNRT25srENDuNzFZ/UEYYYRENg3i3aR1YMJs0xADCkjejMNMqHUSmAlVHDqspvL5k5Q3TDmndorZGNCqACfX6O2rrWSb0GS9UOgcjGAZSA8FzxzAOrEc/rT5CHiNS9l6VSpmGGIr3pqD9qlchriiVTYzmuqIe2LDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YUjew3K0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso4874115a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 17:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730856660; x=1731461460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dPtLYyyFnRfenKmPBexESny14tkCENyQqLk3FnIXd8=;
        b=YUjew3K0FWVyo4PdynX9Qpnc3HoV3dHfp5GOF7F1PEWO5IpRbU0JR/RJ/VOEe4HqVh
         ilwJUQTpkx1erCRI7ShWNXqLaAzWkhpgrDOORsnict/N4gFlTDL+3/EYALJDW3mnu/Qx
         1HfXTnPHZMrfm7J+HyggLTYq4oNMCbqxugFj1yZnLQZb3grEQCiw9tVtX1wB7+6A1h/T
         1sSAkHdHCA2mh9pmMP7gPRrVJo6ziLY7AIQD0GeG8xZisatgRNUcEvPzPxaHmF1NUvKa
         pZNt1xJ+RkoJGttpnIarJKIaBWBzTI3oUQWc/m+H3k+TplRzI1s4DcX0B6XI0W2oRHAU
         ng1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730856660; x=1731461460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dPtLYyyFnRfenKmPBexESny14tkCENyQqLk3FnIXd8=;
        b=YQBtzqYzu86SPLS4SGXkQT9yUjjSC9EkVS2by7N7asmDBFEHwoYss+nsylWo/jYSLU
         v05ZCqNS1UknlaOyM0aLsVwaMaiFhgLduGrL29I1Htc7MyK9JUSk76WxJm9/etIqzqA1
         aXejVoYGRvwqEE4YQcFfsNvdUI3/IC1GhOVbAFjTbW6VIqUIwacfkKIHMCCtGlkIfM+G
         EjOq6z0JhQQvYj2KKgeABFfw4KR0HMLTcrdquQbwnrWGvaa6rsAeq2LpF8q++sqGWIJ0
         OUlcqJICg2iglBzqaWdE8lFHy5+7zZz2ejrDcSuEUad3tkLAp3f//eBRzwqdjKyl0YTm
         WCAA==
X-Forwarded-Encrypted: i=1; AJvYcCUitwdUQPOWmSaPuZtHaOXe/TUTy+bZQZK/wTP+JHvXHxp5hNO1IDvmT/NcACZ8HNLWjDLOEVi1i/42Mas=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKE8T76ApF58nmMfMV3ywgzcwFrCJgZOyeRJCTjyRrzpPVsgVi
	HSZtiA0Y6E2SgA1tU9PNh49a5eVmAc1RQG8vj84qn4yo8HW618j7heisykF0LnBwrqK4Fsmd7B5
	UKsrfnodx0eO/vG89gLUNnDyj8+dvJxoneieP
X-Google-Smtp-Source: AGHT+IGNl4bJP+n92BSTip1ee5Eh6hUcyuO7KCDErBF6owjWJE6mIP3zJ+qfnKXwlzSwMTniUPn9FzEIR9o7Myz6Cgg=
X-Received: by 2002:a17:90a:d14f:b0:2e2:bb32:73eb with SMTP id
 98e67ed59e1d1-2e8f10a72a3mr42421056a91.31.1730856660175; Tue, 05 Nov 2024
 17:31:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030171009.1853340-1-saravanak@google.com>
In-Reply-To: <20241030171009.1853340-1-saravanak@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 5 Nov 2024 17:30:20 -0800
Message-ID: <CAGETcx9MZbvg0ikfsWpJXYw=UzUjv3PerzN4RL1VFMjitBtYXw@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: fw_devlink: Stop trying to optimize cycle
 detection logic
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: Francesco <francesco.dolcini@toradex.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 10:10=E2=80=AFAM Saravana Kannan <saravanak@google.=
com> wrote:
>
> In attempting to optimize fw_devlink runtime, I introduced numerous cycle
> detection bugs by foregoing cycle detection logic under specific
> conditions. Each fix has further narrowed the conditions for optimization=
.
>
> It's time to give up on these optimization attempts and just run the cycl=
e
> detection logic every time fw_devlink tries to create a device link.
>
> The specific bug report that triggered this fix involved a supplier fwnod=
e
> that never gets a device created for it. Instead, the supplier fwnode is
> represented by the device that corresponds to an ancestor fwnode.
>
> In this case, fw_devlink didn't do any cycle detection because the cycle
> detection logic is only run when a device link is created between the
> devices that correspond to the actual consumer and supplier fwnodes.
>
> With this change, fw_devlink will run cycle detection logic even when
> creating SYNC_STATE_ONLY proxy device links from a device that is an
> ancestor of a consumer fwnode.
>
> Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Closes: https://lore.kernel.org/all/1a1ab663-d068-40fb-8c94-f0715403d276@=
ideasonboard.com/
> Fixes: 6442d79d880c ("driver core: fw_devlink: Improve detection of overl=
apping cycles")
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c | 55 ++++++++++++++++++++-------------------------
>  1 file changed, 24 insertions(+), 31 deletions(-)
>
> Tomi,
>
> Thanks for all the testing and debugging help! And do use
> post-init-providers even with this patch to improve ordering
> enforcement. I probably should change the cycle log from info to warn in
> a separate patch :)
>
> Greg,
>
> I no longer have concerns about pulling this into 6.13. But we can give
> a week or so to Geert/Francesco to do some additional testing.
>
> Geert/Francesco,

Heads up. Greg has pulled this into driver-core git's
driver-core-testing branch. Which means in a week or two it'll get
into the actual driver-core-next branch. So, if you want to do
additional testing, you might want to jump on it soon.

Thanks,
Saravana

>
> If you want to test this patch, pull it in and compare the output of
> the following:
>
> ls -1 /sys/class/devlink
>
> The only device links that should be missing with the patch should be
> device links in a cycle that weren't detected before.
>
> Also, if you notice any significant boot time increase with this change,
> let me know.
>
> Thanks,
> Saravana
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3b13fed1c3e3..9a490b1b7a6f 100644
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
> +           con_dev && con_dev->links.status =3D=3D DL_DEV_NO_DRIVER) {
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
> @@ -2115,11 +2115,6 @@ static int fw_devlink_create_devlink(struct device=
 *con,
>         if (link->flags & FWLINK_FLAG_IGNORE)
>                 return 0;
>
> -       if (con->fwnode =3D=3D link->consumer)
> -               flags =3D fw_devlink_get_flags(link->flags);
> -       else
> -               flags =3D FW_DEVLINK_FLAGS_PERMISSIVE;
> -
>         /*
>          * In some cases, a device P might also be a supplier to its chil=
d node
>          * C. However, this would defer the probe of C until the probe of=
 P
> @@ -2140,25 +2135,23 @@ static int fw_devlink_create_devlink(struct devic=
e *con,
>                 return -EINVAL;
>
>         /*
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
> +        * Don't try to optimize by not calling the cycle detection logic=
 under
> +        * certain conditions. There's always some corner case that won't=
 get
> +        * detected.
>          */
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
> +               pr_debug("----- cycle: end -----\n");
> +               pr_info("%pfwf: Fixed dependency cycle(s) with %pfwf\n",
> +                       link->consumer, sup_handle);
>         }
> +       device_links_write_unlock();
> +
> +       if (con->fwnode =3D=3D link->consumer)
> +               flags =3D fw_devlink_get_flags(link->flags);
> +       else
> +               flags =3D FW_DEVLINK_FLAGS_PERMISSIVE;
>
>         if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
>                 sup_dev =3D fwnode_get_next_parent_dev(sup_handle);
> --
> 2.47.0.163.g1226f6d8fa-goog
>

