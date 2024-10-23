Return-Path: <linux-kernel+bounces-377171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B96FF9ABAC7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7528E285017
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2DF1AAC4;
	Wed, 23 Oct 2024 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRGD0L/D"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D50329CA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729645100; cv=none; b=YBzdxMYkVwK39WIpEXnvh9nduVei+16qerfviZDmf/xfIeiL6DSOEgUd3nOQiRYC64UXrleF3BrFfcns60X+bVbr1J/fug/xkyG/CXvO1A//3hsEYO4iz1qTuMrhNu5NSss65Gr77+hnW8esq9g2zU9eHrEhQaVvPZ42wJseSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729645100; c=relaxed/simple;
	bh=SqSf5pGZ8Xm3VI+2adFpBL/dJUNIOYyz90exxJJcMfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A49HfmRUneIAgL0DEn5z9GGs0F/zP+t+EDD7KjpGOPovlJsiOimhw0sJbg0aRjJnTv3krzxpwW3oK5kPDxgVrobN0fvBfbqd42i3a+CD6arc90tc5dHwBcoMq902iAotY/jEajOv3Udxotu5qXsCP1NNtijAdoXodQLjizqkf/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CRGD0L/D; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e7086c231so4743171b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729645098; x=1730249898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1X+k4ALoGij2h8EJoArvR6OhIJFBlu5UZi57RZJEgs=;
        b=CRGD0L/DzHn/lVRL+beWiwtMIbyGR9WaXX9kYaIDfPd4HlxZGukZUuP3dRAu8xQWbR
         5j+DzSdMcoM+2Xfy854G2JfsGsFdsWiv6LlJ6JEpyE7v2vcjQkvQF1r4qbLnb5CwB7RC
         DhiTdFW5ePugjhu5tsq202V73J+KdIZBnToPKT7HUIfLhhUAVFOVOc0LOcYGucPrybu5
         G6vOKSOkqrmLPKyY9feoxvJfF0BGsoVFcf5rhq0Mil6eMYCDzGjyG+mSKmtTqjnqg2gb
         oOZiCe2L1+3DbJNLFJd7i6gdrLSX/6Dx3FRrOvyvyb66EG3XdczEzFf8w8QgNE+Hz1Uj
         gE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729645098; x=1730249898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1X+k4ALoGij2h8EJoArvR6OhIJFBlu5UZi57RZJEgs=;
        b=qksGqwcCtgggID/5PTLTPSzvO+CDMkq49/ODt66JqC2jKiGhF4pQLeQvXTMSfYuiSz
         az5UFGRbjQ5h5c6liPjoteefRXBBDVIJuWFZTFT7QkRTdPCYWWiampURQejvdLZw3wdr
         vbFuLOtXR8i9YTj1a63cLDC8p/uZiVzukvc8veLM4Q8ebiXxz0kUKudJM1RNTdFRvUk4
         0wj0GnRGVNsO4DquT92EobKX51xZJfNtryKSxqLUT6TgI2Y87rAuc2GAxM7/bdwIXOXi
         DtH38fg8a80MlZFkXjPzgixrP14SnSK8rv/vsyu5tCkg9JFOvb9dc5l0QCmJQ9fERZKq
         R7Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUtlCWUQqD81Bx3PDPj9hxHWgrKagfbiVrbXHk/GBu/VGlnSn3VfEatjbWMDGT1QSd8VKeqghBGnW0VROo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwyN08NG9mXnkArKQhwzcof03/xp8lah1EMWITGjnLlAveQWbm
	6JP+yNWNNieiwmwBDMjv5JeJPUQG9iHMHAmKbD152PltEZ1aREfRN/ZV0qUhHIHVdYB4BxhwAGL
	79009pfjvhvLWxce3wDqns5nHJw4SkHkMiFDu
X-Google-Smtp-Source: AGHT+IEbEqhIXl1K1tfHoQmQ1uIOs+Y6i7tWxL4ASffCS7bsrtHTPoy6lbz+wkFAomlLun3HDdM08BoqoUxom18Txfw=
X-Received: by 2002:aa7:8896:0:b0:71e:79a9:ec55 with SMTP id
 d2e1a72fcca58-72030a895a4mr1688550b3a.7.1729645097384; Tue, 22 Oct 2024
 17:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com>
 <CAGETcx-sAu-wMDKT9zCeCzLzZ=ZdvK+CSoX34YxMLd5z0YeVZQ@mail.gmail.com>
 <7b995947-4540-4b17-872e-e107adca4598@notapiano> <575b02aa-6496-492b-b37d-d0612165eda3@notapiano>
 <CAGETcx9e4mpcMY+pqMYXsVWGcjgkctCqgO665KgqUH4JvYbUAQ@mail.gmail.com>
 <c622df86-0372-450e-b3dd-ab93cd051d6f@notapiano> <da4e5807-712d-4d08-a780-f363cee823b9@notapiano>
 <ce40a778-ea62-455b-9c05-aa4ff35b49b5@nvidia.com> <fecb4264-217b-464b-9b1c-226898abff7b@notapiano>
In-Reply-To: <fecb4264-217b-464b-9b1c-226898abff7b@notapiano>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 22 Oct 2024 17:57:37 -0700
Message-ID: <CAGETcx95hf+xBCXvczq=Qx1n1QgdqSM-ezBDNj4ys=gwWm6gyQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Don't log intentional skip of device link
 creation as error
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, kernel@collabora.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 2:32=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Mon, Oct 14, 2024 at 01:49:56PM +0100, Jon Hunter wrote:
> > Hi Nicolas, Saravanna,
> >
> > On 02/10/2024 21:57, N=C3=ADcolas F. R. A. Prado wrote:
> > > On Fri, Aug 09, 2024 at 12:13:25PM -0400, N=C3=ADcolas F. R. A. Prado=
 wrote:
> > > > On Mon, Jul 29, 2024 at 05:08:48PM -0700, Saravana Kannan wrote:
> > > > > On Mon, Jul 29, 2024 at 2:25=E2=80=AFPM N=C3=ADcolas F. R. A. Pra=
do
> > > > > <nfraprado@collabora.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 25, 2024 at 09:56:07AM -0400, N=C3=ADcolas F. R. A.=
 Prado wrote:
> > > > > > > On Mon, Jun 24, 2024 at 04:53:30PM -0700, Saravana Kannan wro=
te:
> > > > > > > > On Mon, Jun 24, 2024 at 8:21=E2=80=AFAM N=C3=ADcolas F. R. =
A. Prado
> > > > > > > > <nfraprado@collabora.com> wrote:
> > > > > > > > >
> > > > > > > > > Commit ac66c5bbb437 ("driver core: Allow only unprobed co=
nsumers for
> > > > > > > > > SYNC_STATE_ONLY device links") introduced an early return=
 in
> > > > > > > > > device_link_add() to prevent useless links from being cre=
ated. However
> > > > > > > > > the calling function fw_devlink_create_devlink() uncondit=
ionally prints
> > > > > > > > > an error if device_link_add() didn't create a link, even =
in this case
> > > > > > > > > where it is intentionally skipping the link creation.
> > > > > > > > >
> > > > > > > > > Add a check to detect if the link wasn't created intentio=
nally and in
> > > > > > > > > that case don't log an error.
> > > > > > > >
> > > > > > > > Your point is somewhat valid, and I might Ack this. But thi=
s really
> > > > > > > > shouldn't be happening a lot. Can you give more context on =
how you are
> > > > > > > > hitting this?
> > > > > > >
> > > > > > > Of course. I'm seeing this on the mt8195-cherry-tomato-r2 pla=
tform.
> > > > > > >
> > > > > > > The following error is printed during boot:
> > > > > > >
> > > > > > >    mediatek-drm-dp 1c500000.edp-tx: Failed to create device l=
ink (0x180) with backlight-lcd0
> > > > > > >
> > > > > > > It doesn't happen with the upstream defconfig, but with the f=
ollowing config
> > > > > > > change it does:
> > > > > > >
> > > > > > >    -CONFIG_PWM_MTK_DISP=3Dm
> > > > > > >    +CONFIG_PWM_MTK_DISP=3Dy
> > > > > > >
> > > > > > > That probably changes the order in which the MTK DP and the b=
acklight drivers
> > > > > > > probe, resulting in the error.
> > > > > > >
> > > > > > > One peculiarity that comes to mind is that the DP driver call=
s
> > > > > > > devm_of_dp_aux_populate_bus() to run a callback once the pane=
l has finished
> > > > > > > probing. I'm not sure if this could have something to do with=
 the error.
> > > > > > >
> > > > > > > Full log at https://lava.collabora.dev/scheduler/job/14573149
> > > > > >
> > > > > > Hi Saravana,
> > > > > >
> > > > > > With the given context for where this issue is happening, what =
do you think
> > > > > > about this patch?
> > > > >
> > > > > Ah sorry, missed your earlier email.
> > > > >
> > > > > Couple of points:
> > > > > 1. It looks like the link in question is "SYNC_STATE_ONLY" becaus=
e
> > > > > it's part of a cycle. Correct me if I'm wrong. You might want to =
use
> > > > > the new "post-init-providers" property to help fw_devlink break t=
he
> > > > > cycle and enforce the right dependency between the edp-tx and you=
r
> > > > > backlight. And then this error should go away and your device ord=
ering
> > > > > is enforced a bit better.
> > > >
> > > > I don't see any cycle there. edp-tx points to backlight, but backli=
ght doesn't
> > > > point back (from mt8195-cherry.dtsi):
> > > >
> > > >    &edp_tx {
> > > >           ...
> > > >           aux-bus {
> > > >                   panel {
> > > >                           compatible =3D "edp-panel";
> > > >                           power-supply =3D <&pp3300_disp_x>;
> > > >                           backlight =3D <&backlight_lcd0>;
> > > >
> > > >    backlight_lcd0: backlight-lcd0 {
> > > >           compatible =3D "pwm-backlight";
> > > >           brightness-levels =3D <0 1023>;
> > > >           default-brightness-level =3D <576>;
> > > >           enable-gpios =3D <&pio 82 GPIO_ACTIVE_HIGH>;
> > > >           num-interpolated-steps =3D <1023>;
> > > >           pwms =3D <&disp_pwm0 0 500000>;
> > > >           power-supply =3D <&ppvar_sys>;
> > > >    };
> > > >
> > > > And DL_FLAG_CYCLE is not set in the flags in the error log: 0x180. =
(Let me know
> > > > if there's something else that I should be looking at to detect a c=
ycle)
> > >
> > > Hi Saravana,
> > >
> > > Here are some debug logs to help contextualize the issue:
> > >
> > >    [    0.198518] device: 'backlight-lcd0': device_add
> > >    [    0.198655] platform 1c500000.edp-tx: Linked as a sync state on=
ly consumer to backlight-lcd0
> > >    [   34.971653] platform backlight-lcd0: error -EPROBE_DEFER: suppl=
ier 1100e000.pwm not ready
> > >    [   35.115480] mediatek-drm-dp 1c500000.edp-tx: driver: 'mediatek-=
drm-dp': driver_bound: bound to device
> > >    [   35.160115] mediatek-drm-dp 1c500000.edp-tx: Dropping the link =
to backlight-lcd0
> > >    [   53.910433] pwm-backlight backlight-lcd0: driver: 'pwm-backligh=
t': driver_bound: bound to device
> > >    [   53.919213] mediatek-drm-dp 1c500000.edp-tx: Failed to create d=
evice link (0x180) with backlight-lcd0
> > >
> > > So a SYNC_STATE_ONLY device link is created from backlight-lcd0 to ed=
p-tx. When
> > > the edp-tx probes, the link is dropped, since it is SYNC_STATE_ONLY. =
When the
> > > backlight-lcd0 probes a new devlink is attempted to the consumer edp-=
tx and
> > > fails, since it is useless, printing the warning.
> > >
> > > You mentioned a cycle before. The only cycle I see is between the edp=
-tx and the
> > > panel, but doesn't involve the backlight:
> > >
> > >    [    0.198104] ----- cycle: start -----
> > >    [    0.198105] /soc/edp-tx@1c500000/aux-bus/panel: cycle: depends =
on /soc/edp-tx@1c500000
> > >    [    0.198112] ----- cycle: start -----
> > >    [    0.198113] /soc/edp-tx@1c500000/aux-bus/panel: cycle: child of=
 /soc/edp-tx@1c500000
> > >    [    0.198119] /soc/edp-tx@1c500000: cycle: depends on /soc/edp-tx=
@1c500000/aux-bus/panel
> > >    [    0.198125] ----- cycle: end -----
> > >    [    0.198126] platform 1c500000.edp-tx: Fixed dependency cycle(s)=
 with /soc/edp-tx@1c500000/aux-bus/panel
> > >
> > > Just in case I tried using post-init-providers:
> > >
> > >    diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arc=
h/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > >    index 75d56b2d5a3d..19df138ef043 100644
> > >    --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > >    +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > >    @@ -322,6 +322,7 @@ &edp_tx {
> > >            pinctrl-names =3D "default";
> > >            pinctrl-0 =3D <&edptx_pins_default>;
> > >    +       post-init-providers =3D <&panel>;
> > >            ports {
> > >                    #address-cells =3D <1>;
> > >    @@ -344,7 +345,7 @@ edp_out: endpoint {
> > >            };
> > >            aux-bus {
> > >    -               panel {
> > >    +               panel: panel {
> > >                            compatible =3D "edp-panel";
> > >                            power-supply =3D <&pp3300_disp_x>;
> > >                            backlight =3D <&backlight_lcd0>;
> > >
> > > It broke the cycle, as I no longer see it in the logs, but the failed=
 device
> > > link warning is still there as expected.
> > >
> > > It seems to me that the issue comes form the device link being SYNC_S=
TATE_ONLY
> > > in the first place. I see that comes from the 'else' path in
> > >
> > >     if (con->fwnode =3D=3D link->consumer)
> > >             flags =3D fw_devlink_get_flags(link->flags);
> > >     else
> > >             flags =3D FW_DEVLINK_FLAGS_PERMISSIVE;
> > >
> > > and the value on each side of the comparison is:
> > >
> > > con->fwnode: /soc/edp-tx@1c500000
> > > link->consumer: /soc/edp-tx@1c500000/aux-bus/panel
> > >
> > > Could you help me understand what (if anything) is wrong here?
> > >
> > > (I also noticed that as per the DT the consumer for backlight-lcd0 sh=
ould be the
> > > panel, but the devlink has it instead as the edp-tx, I'm guessing tha=
t's another
> > > symptom of the same issue)
> >
> >
> > I did not seen any update on this. It would be great to get this fixed.
>
> Since there hasn't been a reply on this, let's postpone this investigatio=
n and
> move forward in fixing the error log. I've sent v2 of the patch:
> https://lore.kernel.org/all/20240624-fwdevlink-probed-no-err-45d21feb05fd=
-v2@collabora.com
>

Sorry for the really long delay Nicolas. All the logs you provides and
all the analysis you did so far definitely helped me narrow this down.

Your instinct about devm_of_dp_aux_populate_bus() was right.

Can you try this fix please? I'm 99% sure this will fix the issue.
This has been a theme... the log message you saw mostly indicates that
the device didn't have its fwnode set.

-Saravana

diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c
b/drivers/gpu/drm/display/drm_dp_aux_bus.c
index d810529ebfb6..ec7eac6b595f 100644
--- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
+++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
@@ -292,7 +292,7 @@ int of_dp_aux_populate_bus(struct drm_dp_aux *aux,
        aux_ep->dev.parent =3D aux->dev;
        aux_ep->dev.bus =3D &dp_aux_bus_type;
        aux_ep->dev.type =3D &dp_aux_device_type_type;
-       aux_ep->dev.of_node =3D of_node_get(np);
+       device_set_node(&aux_ep->dev, of_fwnode_handle(of_node_get(np)));
        dev_set_name(&aux_ep->dev, "aux-%s", dev_name(aux->dev));

        ret =3D device_register(&aux_ep->dev);

Thanks,
Saravana

