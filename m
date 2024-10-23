Return-Path: <linux-kernel+bounces-378098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A899ACB4F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A710628284E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7BD1ADFF9;
	Wed, 23 Oct 2024 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iH5ZgGCx"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960421ABEBF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690507; cv=none; b=n8iy6PfJy6EbGTt9H1ZiF2okf9gR1o8Gfv8l7kZJKYsrnytlS3yV3rqITpjFfqVOlFGGbY5RHUN6RyGLkRgCBzz/rBQcgisT2uAcFDAMpHxTAmJXcTKSSwW28FY7NILpJCUTCZoSDd2lv1p4DuHQYAnKT+/WeeZICDA/AdTdO4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690507; c=relaxed/simple;
	bh=IeiOGxKawDpGkgKsUFtUk/jMFUQK+Z6tP91T77vO2Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awihLvwZJmqt1x5aRcYWlnllVZO6gljMEfD7NAEPPkNv9iAPgKEHXXj99qlQfxG2w3pUy+1E7UnxErNR8nj1HCMbZWQdvhEUTGWYmwTLernYIpEdt2srKwgt2WFXKP7PQdvJehqzIMSRbAwXDQCg8Z5YQN7IODL3AXH6i8yjrIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iH5ZgGCx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729690503;
	bh=IeiOGxKawDpGkgKsUFtUk/jMFUQK+Z6tP91T77vO2Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iH5ZgGCxbOYJmaZKB4Bhjo1S771IqdGK85NCSExQ7y55dgXFN3wYuSz8a4wKqXBLQ
	 cteyfcdlzFv/w1v+qEgw5T/q+YhrRffL57pO4eo2PB6VZtQfxcpGAe6+ZSGEfk9BpG
	 yMT+z9G2EgQoyKpsXswgTkENs6YkFInAJTkjXXdyOmZTpnuuxqNf5Reu9Z8nGAnp6I
	 nyk0dn3H333eSsce+relTBd/9n8eVDhO0U6KENj2LhSHuOD6wHaKWPqq6CYvhgrUGV
	 es2KczmYq0RBNldwrNX2e8ORr4IFpikZiEdXsoRw8rhtbCt2yzdO5gtde/56gu+rBB
	 KjuE3yGRG9Kig==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6AB4317E3616;
	Wed, 23 Oct 2024 15:35:02 +0200 (CEST)
Date: Wed, 23 Oct 2024 09:34:59 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, kernel@collabora.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Don't log intentional skip of device link
 creation as error
Message-ID: <4025f957-c1b7-476b-bdcd-39b891200cac@notapiano>
References: <20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com>
 <CAGETcx-sAu-wMDKT9zCeCzLzZ=ZdvK+CSoX34YxMLd5z0YeVZQ@mail.gmail.com>
 <7b995947-4540-4b17-872e-e107adca4598@notapiano>
 <575b02aa-6496-492b-b37d-d0612165eda3@notapiano>
 <CAGETcx9e4mpcMY+pqMYXsVWGcjgkctCqgO665KgqUH4JvYbUAQ@mail.gmail.com>
 <c622df86-0372-450e-b3dd-ab93cd051d6f@notapiano>
 <da4e5807-712d-4d08-a780-f363cee823b9@notapiano>
 <ce40a778-ea62-455b-9c05-aa4ff35b49b5@nvidia.com>
 <fecb4264-217b-464b-9b1c-226898abff7b@notapiano>
 <CAGETcx95hf+xBCXvczq=Qx1n1QgdqSM-ezBDNj4ys=gwWm6gyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx95hf+xBCXvczq=Qx1n1QgdqSM-ezBDNj4ys=gwWm6gyQ@mail.gmail.com>

On Tue, Oct 22, 2024 at 05:57:37PM -0700, Saravana Kannan wrote:
> On Tue, Oct 15, 2024 at 2:32 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > On Mon, Oct 14, 2024 at 01:49:56PM +0100, Jon Hunter wrote:
> > > Hi Nicolas, Saravanna,
> > >
> > > On 02/10/2024 21:57, Nícolas F. R. A. Prado wrote:
> > > > On Fri, Aug 09, 2024 at 12:13:25PM -0400, Nícolas F. R. A. Prado wrote:
> > > > > On Mon, Jul 29, 2024 at 05:08:48PM -0700, Saravana Kannan wrote:
> > > > > > On Mon, Jul 29, 2024 at 2:25 PM Nícolas F. R. A. Prado
> > > > > > <nfraprado@collabora.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jun 25, 2024 at 09:56:07AM -0400, Nícolas F. R. A. Prado wrote:
> > > > > > > > On Mon, Jun 24, 2024 at 04:53:30PM -0700, Saravana Kannan wrote:
> > > > > > > > > On Mon, Jun 24, 2024 at 8:21 AM Nícolas F. R. A. Prado
> > > > > > > > > <nfraprado@collabora.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Commit ac66c5bbb437 ("driver core: Allow only unprobed consumers for
> > > > > > > > > > SYNC_STATE_ONLY device links") introduced an early return in
> > > > > > > > > > device_link_add() to prevent useless links from being created. However
> > > > > > > > > > the calling function fw_devlink_create_devlink() unconditionally prints
> > > > > > > > > > an error if device_link_add() didn't create a link, even in this case
> > > > > > > > > > where it is intentionally skipping the link creation.
> > > > > > > > > >
> > > > > > > > > > Add a check to detect if the link wasn't created intentionally and in
> > > > > > > > > > that case don't log an error.
> > > > > > > > >
> > > > > > > > > Your point is somewhat valid, and I might Ack this. But this really
> > > > > > > > > shouldn't be happening a lot. Can you give more context on how you are
> > > > > > > > > hitting this?
> > > > > > > >
> > > > > > > > Of course. I'm seeing this on the mt8195-cherry-tomato-r2 platform.
> > > > > > > >
> > > > > > > > The following error is printed during boot:
> > > > > > > >
> > > > > > > >    mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) with backlight-lcd0
> > > > > > > >
> > > > > > > > It doesn't happen with the upstream defconfig, but with the following config
> > > > > > > > change it does:
> > > > > > > >
> > > > > > > >    -CONFIG_PWM_MTK_DISP=m
> > > > > > > >    +CONFIG_PWM_MTK_DISP=y
> > > > > > > >
> > > > > > > > That probably changes the order in which the MTK DP and the backlight drivers
> > > > > > > > probe, resulting in the error.
> > > > > > > >
> > > > > > > > One peculiarity that comes to mind is that the DP driver calls
> > > > > > > > devm_of_dp_aux_populate_bus() to run a callback once the panel has finished
> > > > > > > > probing. I'm not sure if this could have something to do with the error.
> > > > > > > >
> > > > > > > > Full log at https://lava.collabora.dev/scheduler/job/14573149
> > > > > > >
> > > > > > > Hi Saravana,
> > > > > > >
> > > > > > > With the given context for where this issue is happening, what do you think
> > > > > > > about this patch?
> > > > > >
> > > > > > Ah sorry, missed your earlier email.
> > > > > >
> > > > > > Couple of points:
> > > > > > 1. It looks like the link in question is "SYNC_STATE_ONLY" because
> > > > > > it's part of a cycle. Correct me if I'm wrong. You might want to use
> > > > > > the new "post-init-providers" property to help fw_devlink break the
> > > > > > cycle and enforce the right dependency between the edp-tx and your
> > > > > > backlight. And then this error should go away and your device ordering
> > > > > > is enforced a bit better.
> > > > >
> > > > > I don't see any cycle there. edp-tx points to backlight, but backlight doesn't
> > > > > point back (from mt8195-cherry.dtsi):
> > > > >
> > > > >    &edp_tx {
> > > > >           ...
> > > > >           aux-bus {
> > > > >                   panel {
> > > > >                           compatible = "edp-panel";
> > > > >                           power-supply = <&pp3300_disp_x>;
> > > > >                           backlight = <&backlight_lcd0>;
> > > > >
> > > > >    backlight_lcd0: backlight-lcd0 {
> > > > >           compatible = "pwm-backlight";
> > > > >           brightness-levels = <0 1023>;
> > > > >           default-brightness-level = <576>;
> > > > >           enable-gpios = <&pio 82 GPIO_ACTIVE_HIGH>;
> > > > >           num-interpolated-steps = <1023>;
> > > > >           pwms = <&disp_pwm0 0 500000>;
> > > > >           power-supply = <&ppvar_sys>;
> > > > >    };
> > > > >
> > > > > And DL_FLAG_CYCLE is not set in the flags in the error log: 0x180. (Let me know
> > > > > if there's something else that I should be looking at to detect a cycle)
> > > >
> > > > Hi Saravana,
> > > >
> > > > Here are some debug logs to help contextualize the issue:
> > > >
> > > >    [    0.198518] device: 'backlight-lcd0': device_add
> > > >    [    0.198655] platform 1c500000.edp-tx: Linked as a sync state only consumer to backlight-lcd0
> > > >    [   34.971653] platform backlight-lcd0: error -EPROBE_DEFER: supplier 1100e000.pwm not ready
> > > >    [   35.115480] mediatek-drm-dp 1c500000.edp-tx: driver: 'mediatek-drm-dp': driver_bound: bound to device
> > > >    [   35.160115] mediatek-drm-dp 1c500000.edp-tx: Dropping the link to backlight-lcd0
> > > >    [   53.910433] pwm-backlight backlight-lcd0: driver: 'pwm-backlight': driver_bound: bound to device
> > > >    [   53.919213] mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) with backlight-lcd0
> > > >
> > > > So a SYNC_STATE_ONLY device link is created from backlight-lcd0 to edp-tx. When
> > > > the edp-tx probes, the link is dropped, since it is SYNC_STATE_ONLY. When the
> > > > backlight-lcd0 probes a new devlink is attempted to the consumer edp-tx and
> > > > fails, since it is useless, printing the warning.
> > > >
> > > > You mentioned a cycle before. The only cycle I see is between the edp-tx and the
> > > > panel, but doesn't involve the backlight:
> > > >
> > > >    [    0.198104] ----- cycle: start -----
> > > >    [    0.198105] /soc/edp-tx@1c500000/aux-bus/panel: cycle: depends on /soc/edp-tx@1c500000
> > > >    [    0.198112] ----- cycle: start -----
> > > >    [    0.198113] /soc/edp-tx@1c500000/aux-bus/panel: cycle: child of /soc/edp-tx@1c500000
> > > >    [    0.198119] /soc/edp-tx@1c500000: cycle: depends on /soc/edp-tx@1c500000/aux-bus/panel
> > > >    [    0.198125] ----- cycle: end -----
> > > >    [    0.198126] platform 1c500000.edp-tx: Fixed dependency cycle(s) with /soc/edp-tx@1c500000/aux-bus/panel
> > > >
> > > > Just in case I tried using post-init-providers:
> > > >
> > > >    diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > > >    index 75d56b2d5a3d..19df138ef043 100644
> > > >    --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > > >    +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > > >    @@ -322,6 +322,7 @@ &edp_tx {
> > > >            pinctrl-names = "default";
> > > >            pinctrl-0 = <&edptx_pins_default>;
> > > >    +       post-init-providers = <&panel>;
> > > >            ports {
> > > >                    #address-cells = <1>;
> > > >    @@ -344,7 +345,7 @@ edp_out: endpoint {
> > > >            };
> > > >            aux-bus {
> > > >    -               panel {
> > > >    +               panel: panel {
> > > >                            compatible = "edp-panel";
> > > >                            power-supply = <&pp3300_disp_x>;
> > > >                            backlight = <&backlight_lcd0>;
> > > >
> > > > It broke the cycle, as I no longer see it in the logs, but the failed device
> > > > link warning is still there as expected.
> > > >
> > > > It seems to me that the issue comes form the device link being SYNC_STATE_ONLY
> > > > in the first place. I see that comes from the 'else' path in
> > > >
> > > >     if (con->fwnode == link->consumer)
> > > >             flags = fw_devlink_get_flags(link->flags);
> > > >     else
> > > >             flags = FW_DEVLINK_FLAGS_PERMISSIVE;
> > > >
> > > > and the value on each side of the comparison is:
> > > >
> > > > con->fwnode: /soc/edp-tx@1c500000
> > > > link->consumer: /soc/edp-tx@1c500000/aux-bus/panel
> > > >
> > > > Could you help me understand what (if anything) is wrong here?
> > > >
> > > > (I also noticed that as per the DT the consumer for backlight-lcd0 should be the
> > > > panel, but the devlink has it instead as the edp-tx, I'm guessing that's another
> > > > symptom of the same issue)
> > >
> > >
> > > I did not seen any update on this. It would be great to get this fixed.
> >
> > Since there hasn't been a reply on this, let's postpone this investigation and
> > move forward in fixing the error log. I've sent v2 of the patch:
> > https://lore.kernel.org/all/20240624-fwdevlink-probed-no-err-45d21feb05fd-v2@collabora.com
> >
> 
> Sorry for the really long delay Nicolas. All the logs you provides and
> all the analysis you did so far definitely helped me narrow this down.
> 
> Your instinct about devm_of_dp_aux_populate_bus() was right.
> 
> Can you try this fix please? I'm 99% sure this will fix the issue.
> This has been a theme... the log message you saw mostly indicates that
> the device didn't have its fwnode set.
> 
> -Saravana
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c
> b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> index d810529ebfb6..ec7eac6b595f 100644
> --- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
> +++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> @@ -292,7 +292,7 @@ int of_dp_aux_populate_bus(struct drm_dp_aux *aux,
>         aux_ep->dev.parent = aux->dev;
>         aux_ep->dev.bus = &dp_aux_bus_type;
>         aux_ep->dev.type = &dp_aux_device_type_type;
> -       aux_ep->dev.of_node = of_node_get(np);
> +       device_set_node(&aux_ep->dev, of_fwnode_handle(of_node_get(np)));
>         dev_set_name(&aux_ep->dev, "aux-%s", dev_name(aux->dev));
> 
>         ret = device_register(&aux_ep->dev);
> 
> Thanks,
> Saravana

Hi Saravana,

Indeed this fixed the issue! Thank you for tracking this down. Feel free to add
when you send the patch

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

