Return-Path: <linux-kernel+bounces-385809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DF89B3C04
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A705283394
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186CD1865E3;
	Mon, 28 Oct 2024 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rV+73Q9I"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB718E03D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147994; cv=none; b=mldV/7mZjRUWslo1r0v1AC8nlTYSBcspaAp6WjVu7dZppDA7BKsy2EiP2Mqa7bRg4jCNykjmLJBR0Kb+C3CpOGMBwH16EDT04tTLlS1n3UnByGySo4+7U9bddKVc+zDoawY9fKejQfPtYz9QueUp4F4J3zYTcejYuYZxoy9JM0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147994; c=relaxed/simple;
	bh=HJ7Sxit0O0NRLcZfQEcpDE5uJaGoFG95t+z8FWJSQNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOp9ZlSIvlis0QvqCn+JbnHGRKxreMnIzBlPbb1QHcpK4cpkNSMQmIUzj6+KCU8VVkdoWQT+dYCJWueb38L9LzCatJIofGZbh6IVvHm1wZWqhqgHLtdVAd7QwKD99UmjyLfwVKYnF8NtRfUiOHp4duznlD0QAYfVLPJohFx/a6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rV+73Q9I; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c1324be8easo4008790a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730147991; x=1730752791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lwka7nWBpShrLfKIhEzGloS4yLOaYMcHWs9aKJ7OeSI=;
        b=rV+73Q9IPJxjlC17a4URf9H5rOGEOlvrz1I1prvzkOwnz9uPn0bixYV3uDWp1Sk8jp
         FcoJ2r3x6Qn/mfiTE7lm7V+R0wUfc+kwpBG+6hA7UTIcs4Aybl6lcyzv3zVn4iQFHOAr
         qaNz02xt2uKkYfrLAxfcUqm6Uev7nYOlipe3xbQJtIDU/JtixuQ/ROG5tt8BKqG3lusR
         3gZ+pkf/CkobTgtaIIhLmCj8kcheBJq8uYtVY0sphDGpEevNFTIDx0UWKocqpafq1VXQ
         9tn6tY7U1je+rjAAnjQkd2qWo9L+malJAqa4Wc24Fn0m6c3eEnJ6rIcEaBP4CgmXntlR
         2xyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730147991; x=1730752791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lwka7nWBpShrLfKIhEzGloS4yLOaYMcHWs9aKJ7OeSI=;
        b=d6s/VtCxwASmJYPbdqbyFwucFxmzp1RrkpCmJJqPxdIz+Hbn4QLcKYCuRip3GsOTVi
         vM7GATSc5mAN0ftR/YqvIZdlZr0yXiHQVCkpzTFmXsjrEg3Sn/VXqCTeHSjlzd6aqlE4
         sx1EqTZOWg2BlElyJvwjz5l60lEkjgixCiGBrPwUo5qs/LJ54H+Tv4ZgxdnoWTqQAIOC
         H1zpsp5kuVOg8dQb3zVCI+Zz8uT0Bm1adAMBt3sCywPaXiaPXXoIU4xeqbDA5WokqlC7
         AdSuq1nANVyalHQesLx5qGEOKSvTn8VcevXLkcqkacnUMjV9VvohoNSDOL/hy1XRDwHB
         E8uw==
X-Forwarded-Encrypted: i=1; AJvYcCWnff1diRIwREswK87P3/yBR9H5NG7W2avFWpJTDg/2CpI4XIazhbHZqvcyDLOKpSX613rXz9lNBufY6VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymrzzMLrFdVUDw/0FeSZdR6YS+tf4IHjy6znabf7lLDGJTuf5U
	L5YkCUzbps1IMbUAXX3VRyPaSquYe9a32wIw2IiRGK03leyQGscqp4EBIwbCdByJLHM8zNYNXsO
	32OSgDw7BmL0Bywd1gAxNB9eaDNrLmi07nLwc
X-Google-Smtp-Source: AGHT+IFT968ZFsNalOTLMoES95nu0Q0U86Gq/eB0MvTBZExGZWuvR1c1bnfKYcUeBHAQ/WoFBp8LjHL+Tsg9flH/VBU=
X-Received: by 2002:a05:6a20:ce44:b0:1d9:13da:db15 with SMTP id
 adf61e73a8af0-1d9dca671ecmr1364831637.24.1730147990427; Mon, 28 Oct 2024
 13:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026045243.452957-1-saravanak@google.com> <76eb4a60-e192-4018-9770-4b973075a3cb@ideasonboard.com>
In-Reply-To: <76eb4a60-e192-4018-9770-4b973075a3cb@ideasonboard.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 28 Oct 2024 13:39:10 -0700
Message-ID: <CAGETcx99+EA=t6KaWCWbHk=Xjj32UAKepktZkmLuap=K5G9h3w@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: fw_devlink: Stop trying to optimize cycle
 detection logic
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Devarsh Thakkar <devarsht@ti.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 1:06=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Hi,
>
> On 26/10/2024 07:52, Saravana Kannan wrote:
> > In attempting to optimize fw_devlink runtime, I introduced numerous cyc=
le
> > detection bugs by foregoing cycle detection logic under specific
> > conditions. Each fix has further narrowed the conditions for optimizati=
on.
> >
> > It's time to give up on these optimization attempts and just run the cy=
cle
> > detection logic every time fw_devlink tries to create a device link.
> >
> > The specific bug report that triggered this fix involved a supplier fwn=
ode
> > that never gets a device created for it. Instead, the supplier fwnode i=
s
> > represented by the device that corresponds to an ancestor fwnode.
> >
> > In this case, fw_devlink didn't do any cycle detection because the cycl=
e
> > detection logic is only run when a device link is created between the
> > devices that correspond to the actual consumer and supplier fwnodes.
> >
> > With this change, fw_devlink will run cycle detection logic even when
> > creating SYNC_STATE_ONLY proxy device links from a device that is an
> > ancestor of a consumer fwnode.
> >
> > Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > Closes: https://lore.kernel.org/all/1a1ab663-d068-40fb-8c94-f0715403d27=
6@ideasonboard.com/
> > Fixes: 6442d79d880c ("driver core: fw_devlink: Improve detection of ove=
rlapping cycles")
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> > Greg,
> >
> > I've tested this on my end and it looks ok and nothing fishy is going
> > on. You can pick this up once Tomi gives a Tested-by.
>
> I tested this on TI AM62 SK board. It has an LVDS (OLDI) display and a
> HDMI output, and both displays are connected to the same display
> subsystem. I tested with OLDI single and dual link cases, with and
> without HDMI, and in all cases probing works fine.
>
> Looks good on that front, so:
>
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Great! Thanks!

> You also asked for a diff of the devlinks. That part doesn't look so
> good to me, but probably you can tell if it's normal or not.

TL;DR: All device links in a cycle get marked as
DL_FLAG_SYNC_STATE_ONLY and DL_FLAG_CYCLE (in addition to other
flags). All DL_FLAG_SYNC_STATE_ONLY (not all of them are cycles) will
get deleted after the consumer probes (since they are no longer needed
after that). My guess on what's going on is that with the patch,
fw_devlink found and marked more device links as cycles. Ones that in
the past weren't detected as being part of a cycle but coincidentally
the "post-init" dependency was the one that was getting ignored/not
enforced. So the actual links in a cycle getting deleted after all the
devices have probed is not a problem.

You can enable the "cycle" logs in drivers/base/core.c so it's easier
to follow the cycles fw_devlink detected. But the logs are a bit
cryptic because it tries to print all the multiple cycles that were
detected using a recursive search.

The non-cycle use for DL_FLAG_SYNC_STATE_ONLY is for parent devices to
put a "proxy-vote" (Hey supplier, you still have a consumer that
hasn't bound to a driver yet) for descendant (children, grand
children) devices that haven't been created yet. So, without the fix
it's possible some descendant child never got to probe and the
DL_FLAG_SYNC_STATE_ONLY device link stuck around.

If you can confirm all the deleted device links fall into one of these
two categories, then there's no issue here. If you find cases that
aren't clear, then let me know which one and point to specific nodes
in an upstream DTS file and I can take a look.

Every device link folder has a "sync_state_only" file that says if it
has the DL_FLAG_SYNC_STATE_ONLY set. But to check for the cycle flag,
you'll have to extend the debug log in device_link_add() that goes:
"Linked as a sync state only consumer to......" and print the "flags" param=
.

>
> $ diff devlink-single-broken.txt devlink-single-fixed.txt

I was hoping you'd give me some line count diff too to get a sense of
if it's wreaking havoc or not. But based on my local testing on
different hardware, I'm expecting a very small number of device links
are getting affected.

> 2d1
> < i2c:1-0022--i2c:1-003b
> 11d9
> <
> platform:44043000.system-controller:clock-controller--platform:20010000.i=
2c
> 27d24
> < platform:44043000.system-controller:clock-controller--platform:601000.g=
pio
> 42d38
> <
> platform:44043000.system-controller:power-controller--platform:20010000.i=
2c
> 58d53
> < platform:44043000.system-controller:power-controller--platform:601000.g=
pio
> 74d68
> < platform:4d000000.mailbox--platform:44043000.system-controller

I took a quick look at this one in
arch/arm64/boot/dts/ti/k3-am62-main.dtsi which I assume is part of the
device you are testing on and I couldn't find a cycle. But with dtsi
and dts files, it's hard to find these manually. Let me know if
fw_devlink is thinking there's a cycle where there is none.

> 76d69
> < platform:601000.gpio--i2c:1-0022
> 80d72
> < platform:bus@f0000:interrupt-controller@a00000--platform:601000.gpio
> 82d73
> < platform:f4000.pinctrl--i2c:1-0022
> 84d74
> < platform:f4000.pinctrl--platform:20010000.i2c
>
> "i2c:1-003b" is the hdmi bridge, "i2c:1-0022" is a gpio expander. So,
> for example, we lose the devlink between the gpio expander and the hdmi
> bridge. The expander is used for interrupts. There's an interrupt line
> from the HDMI bridge to the expander, and from there there's an
> interrupt line going to the SoC.
>
> Also, I noticed the devlinks change if I load the display drivers. The
> above is before loading. Comparing the loaded/not-loaded:

Yeah, DL_FLAG_SYNC_STATE_ONLY device links vanishing as more devices
probe is not a problem. That's working as intended.

Thanks,
Saravana

>
> $ diff devlink-dual-fixed.txt devlink-dual-fixed-loaded.txt
> 3d2
> < i2c:1-003b--platform:30200000.dss
> 23d21
> <
> platform:44043000.system-controller:clock-controller--platform:30200000.d=
ss
> 52d49
> <
> platform:44043000.system-controller:power-controller--platform:30200000.d=
ss
> 73d69
> < platform:display--platform:30200000.dss
> 78d73
> < platform:f4000.pinctrl--platform:30200000.dss
> 97a93
>  > regulator:regulator.0--platform:display
>
>   Tomi
>
>
> > Thanks,
> > Saravana
> >
> > v1 -> v2:
> > - Removed the RFC tag
> > - Remaned the subject. v1 is https://lore.kernel.org/all/20241025223721=
.184998-1-saravanak@google.com/T/#u
> > - Added a NULL check to avoid NULL pointer deref
> >
> >   drivers/base/core.c | 46 ++++++++++++++++++++------------------------=
-
> >   1 file changed, 20 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 3b13fed1c3e3..f96f2e4c76b4 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1990,10 +1990,10 @@ static struct device *fwnode_get_next_parent_de=
v(const struct fwnode_handle *fwn
> >    *
> >    * Return true if one or more cycles were found. Otherwise, return fa=
lse.
> >    */
> > -static bool __fw_devlink_relax_cycles(struct device *con,
> > +static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle=
,
> >                                struct fwnode_handle *sup_handle)
> >   {
> > -     struct device *sup_dev =3D NULL, *par_dev =3D NULL;
> > +     struct device *sup_dev =3D NULL, *par_dev =3D NULL, *con_dev =3D =
NULL;
> >       struct fwnode_link *link;
> >       struct device_link *dev_link;
> >       bool ret =3D false;
> > @@ -2010,22 +2010,22 @@ static bool __fw_devlink_relax_cycles(struct de=
vice *con,
> >
> >       sup_handle->flags |=3D FWNODE_FLAG_VISITED;
> >
> > -     sup_dev =3D get_dev_from_fwnode(sup_handle);
> > -
> >       /* Termination condition. */
> > -     if (sup_dev =3D=3D con) {
> > +     if (sup_handle =3D=3D con_handle) {
> >               pr_debug("----- cycle: start -----\n");
> >               ret =3D true;
> >               goto out;
> >       }
> >
> > +     sup_dev =3D get_dev_from_fwnode(sup_handle);
> > +     con_dev =3D get_dev_from_fwnode(con_handle);
> >       /*
> >        * If sup_dev is bound to a driver and @con hasn't started bindin=
g to a
> >        * driver, sup_dev can't be a consumer of @con. So, no need to ch=
eck
> >        * further.
> >        */
> >       if (sup_dev && sup_dev->links.status =3D=3D  DL_DEV_DRIVER_BOUND =
&&
> > -         con->links.status =3D=3D DL_DEV_NO_DRIVER) {
> > +         con_dev && con_dev->links.status =3D=3D DL_DEV_NO_DRIVER) {
> >               ret =3D false;
> >               goto out;
> >       }
> > @@ -2034,7 +2034,7 @@ static bool __fw_devlink_relax_cycles(struct devi=
ce *con,
> >               if (link->flags & FWLINK_FLAG_IGNORE)
> >                       continue;
> >
> > -             if (__fw_devlink_relax_cycles(con, link->supplier)) {
> > +             if (__fw_devlink_relax_cycles(con_handle, link->supplier)=
) {
> >                       __fwnode_link_cycle(link);
> >                       ret =3D true;
> >               }
> > @@ -2049,7 +2049,7 @@ static bool __fw_devlink_relax_cycles(struct devi=
ce *con,
> >       else
> >               par_dev =3D fwnode_get_next_parent_dev(sup_handle);
> >
> > -     if (par_dev && __fw_devlink_relax_cycles(con, par_dev->fwnode)) {
> > +     if (par_dev && __fw_devlink_relax_cycles(con_handle, par_dev->fwn=
ode)) {
> >               pr_debug("%pfwf: cycle: child of %pfwf\n", sup_handle,
> >                        par_dev->fwnode);
> >               ret =3D true;
> > @@ -2067,7 +2067,7 @@ static bool __fw_devlink_relax_cycles(struct devi=
ce *con,
> >                   !(dev_link->flags & DL_FLAG_CYCLE))
> >                       continue;
> >
> > -             if (__fw_devlink_relax_cycles(con,
> > +             if (__fw_devlink_relax_cycles(con_handle,
> >                                             dev_link->supplier->fwnode)=
) {
> >                       pr_debug("%pfwf: cycle: depends on %pfwf\n", sup_=
handle,
> >                                dev_link->supplier->fwnode);
> > @@ -2140,25 +2140,19 @@ static int fw_devlink_create_devlink(struct dev=
ice *con,
> >               return -EINVAL;
> >
> >       /*
> > -      * SYNC_STATE_ONLY device links don't block probing and supports =
cycles.
> > -      * So, one might expect that cycle detection isn't necessary for =
them.
> > -      * However, if the device link was marked as SYNC_STATE_ONLY beca=
use
> > -      * it's part of a cycle, then we still need to do cycle detection=
. This
> > -      * is because the consumer and supplier might be part of multiple=
 cycles
> > -      * and we need to detect all those cycles.
> > +      * Don't try to optimize by not calling the cycle detection logic=
 under
> > +      * certain conditions. There's always some corner case that won't=
 get
> > +      * detected.
> >        */
> > -     if (!device_link_flag_is_sync_state_only(flags) ||
> > -         flags & DL_FLAG_CYCLE) {
> > -             device_links_write_lock();
> > -             if (__fw_devlink_relax_cycles(con, sup_handle)) {
> > -                     __fwnode_link_cycle(link);
> > -                     flags =3D fw_devlink_get_flags(link->flags);
> > -                     pr_debug("----- cycle: end -----\n");
> > -                     dev_info(con, "Fixed dependency cycle(s) with %pf=
wf\n",
> > -                              sup_handle);
> > -             }
> > -             device_links_write_unlock();
> > +     device_links_write_lock();
> > +     if (__fw_devlink_relax_cycles(link->consumer, sup_handle)) {
> > +             __fwnode_link_cycle(link);
> > +             flags =3D fw_devlink_get_flags(link->flags);
> > +             pr_debug("----- cycle: end -----\n");
> > +             pr_info("%pfwf: Fixed dependency cycle(s) with %pfwf\n",
> > +                     link->consumer, sup_handle);
> >       }
> > +     device_links_write_unlock();
> >
> >       if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
> >               sup_dev =3D fwnode_get_next_parent_dev(sup_handle);
>

