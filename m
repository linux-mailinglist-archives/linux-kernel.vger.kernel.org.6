Return-Path: <linux-kernel+bounces-348243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A3098E47E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064A61C20BC1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10585217321;
	Wed,  2 Oct 2024 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WTEzun4Q"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508641D278D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902646; cv=none; b=Gxrd/JTRdFkozzlJJs5dkrN6Nyvg40riS7j3HzRjG7vRhipnkIOKgP9paA8qKkmklwvukgHXvBi7lNUzgrYqW9vvd9Q9DpXIT/j3h6v/Ok+ex1EdAHKDPiPY42EioWn0KtLCRCVMNVv1lRc77l6rQRp0KMgQpr8/8jJWijCBVHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902646; c=relaxed/simple;
	bh=lDwQQzSqj/a3EgW/Uu5hfngo30wF4r6s5N5XnBx7LDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdUDnmNZOuX2W/ylhEy6gtrUuh3/cNd9tHQzkrfgjI+sAiCenTQHjPP/V64BzcOJXmGJgAd3llzXtbnHvFhcPfzi4JAVQd/fIuiOzZRd6dvdbsD1B+e1fHxieFOc3XEjpNVMABRTVhHTaofa/6u9E31SLN9O4s8AzUAHrL5ETh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WTEzun4Q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727902641;
	bh=lDwQQzSqj/a3EgW/Uu5hfngo30wF4r6s5N5XnBx7LDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTEzun4QMxPLMmEHl8Z/gnXsi7M7Tr6pigEHV8fBWdRSMOWrxSJL34N+REyOV2J6w
	 KC85tKnFczg4q3+9SKLy5UUve8nkMcAnPCCMI8cfhmHIevm/Dq1VL4JYu2UZrGWjEY
	 +WKzmZ2rOoUUSC35mDg6wjYqhxbtlJzre+ad2Vc4ibKbzSI0IGUOxkdUuXfQ2qLiRR
	 yflVhESPOi33Pw0dnwZKvYeL2ekBRqzRL+BGv4Wt6n8y3NSBURPwlGCvtCvQu4hY0w
	 ESuO1XLpBDEOxoiF20fQNEND8jNxHTTEvs7EmbcxurhY66SvR8Y15w5PEcQbVLWtPD
	 ZVqFNO01F1uGg==
Received: from notapiano (unknown [IPv6:2607:fb91:302c:db04:6e70:c76a:8f40:2e66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EB8B817E369E;
	Wed,  2 Oct 2024 22:57:18 +0200 (CEST)
Date: Wed, 2 Oct 2024 16:57:16 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, kernel@collabora.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Don't log intentional skip of device link
 creation as error
Message-ID: <da4e5807-712d-4d08-a780-f363cee823b9@notapiano>
References: <20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com>
 <CAGETcx-sAu-wMDKT9zCeCzLzZ=ZdvK+CSoX34YxMLd5z0YeVZQ@mail.gmail.com>
 <7b995947-4540-4b17-872e-e107adca4598@notapiano>
 <575b02aa-6496-492b-b37d-d0612165eda3@notapiano>
 <CAGETcx9e4mpcMY+pqMYXsVWGcjgkctCqgO665KgqUH4JvYbUAQ@mail.gmail.com>
 <c622df86-0372-450e-b3dd-ab93cd051d6f@notapiano>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c622df86-0372-450e-b3dd-ab93cd051d6f@notapiano>

On Fri, Aug 09, 2024 at 12:13:25PM -0400, Nícolas F. R. A. Prado wrote:
> On Mon, Jul 29, 2024 at 05:08:48PM -0700, Saravana Kannan wrote:
> > On Mon, Jul 29, 2024 at 2:25 PM Nícolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > >
> > > On Tue, Jun 25, 2024 at 09:56:07AM -0400, Nícolas F. R. A. Prado wrote:
> > > > On Mon, Jun 24, 2024 at 04:53:30PM -0700, Saravana Kannan wrote:
> > > > > On Mon, Jun 24, 2024 at 8:21 AM Nícolas F. R. A. Prado
> > > > > <nfraprado@collabora.com> wrote:
> > > > > >
> > > > > > Commit ac66c5bbb437 ("driver core: Allow only unprobed consumers for
> > > > > > SYNC_STATE_ONLY device links") introduced an early return in
> > > > > > device_link_add() to prevent useless links from being created. However
> > > > > > the calling function fw_devlink_create_devlink() unconditionally prints
> > > > > > an error if device_link_add() didn't create a link, even in this case
> > > > > > where it is intentionally skipping the link creation.
> > > > > >
> > > > > > Add a check to detect if the link wasn't created intentionally and in
> > > > > > that case don't log an error.
> > > > >
> > > > > Your point is somewhat valid, and I might Ack this. But this really
> > > > > shouldn't be happening a lot. Can you give more context on how you are
> > > > > hitting this?
> > > >
> > > > Of course. I'm seeing this on the mt8195-cherry-tomato-r2 platform.
> > > >
> > > > The following error is printed during boot:
> > > >
> > > >   mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) with backlight-lcd0
> > > >
> > > > It doesn't happen with the upstream defconfig, but with the following config
> > > > change it does:
> > > >
> > > >   -CONFIG_PWM_MTK_DISP=m
> > > >   +CONFIG_PWM_MTK_DISP=y
> > > >
> > > > That probably changes the order in which the MTK DP and the backlight drivers
> > > > probe, resulting in the error.
> > > >
> > > > One peculiarity that comes to mind is that the DP driver calls
> > > > devm_of_dp_aux_populate_bus() to run a callback once the panel has finished
> > > > probing. I'm not sure if this could have something to do with the error.
> > > >
> > > > Full log at https://lava.collabora.dev/scheduler/job/14573149
> > >
> > > Hi Saravana,
> > >
> > > With the given context for where this issue is happening, what do you think
> > > about this patch?
> > 
> > Ah sorry, missed your earlier email.
> > 
> > Couple of points:
> > 1. It looks like the link in question is "SYNC_STATE_ONLY" because
> > it's part of a cycle. Correct me if I'm wrong. You might want to use
> > the new "post-init-providers" property to help fw_devlink break the
> > cycle and enforce the right dependency between the edp-tx and your
> > backlight. And then this error should go away and your device ordering
> > is enforced a bit better.
> 
> I don't see any cycle there. edp-tx points to backlight, but backlight doesn't
> point back (from mt8195-cherry.dtsi): 
> 
>   &edp_tx {
>   	...
>   	aux-bus {
>   		panel {
>   			compatible = "edp-panel";
>   			power-supply = <&pp3300_disp_x>;
>   			backlight = <&backlight_lcd0>;
> 
>   
>   backlight_lcd0: backlight-lcd0 {
>   	compatible = "pwm-backlight";
>   	brightness-levels = <0 1023>;
>   	default-brightness-level = <576>;
>   	enable-gpios = <&pio 82 GPIO_ACTIVE_HIGH>;
>   	num-interpolated-steps = <1023>;
>   	pwms = <&disp_pwm0 0 500000>;
>   	power-supply = <&ppvar_sys>;
>   };
> 
> And DL_FLAG_CYCLE is not set in the flags in the error log: 0x180. (Let me know
> if there's something else that I should be looking at to detect a cycle)

Hi Saravana,

Here are some debug logs to help contextualize the issue:

  [    0.198518] device: 'backlight-lcd0': device_add
  [    0.198655] platform 1c500000.edp-tx: Linked as a sync state only consumer to backlight-lcd0
  
  [   34.971653] platform backlight-lcd0: error -EPROBE_DEFER: supplier 1100e000.pwm not ready
  
  [   35.115480] mediatek-drm-dp 1c500000.edp-tx: driver: 'mediatek-drm-dp': driver_bound: bound to device
  [   35.160115] mediatek-drm-dp 1c500000.edp-tx: Dropping the link to backlight-lcd0
  
  [   53.910433] pwm-backlight backlight-lcd0: driver: 'pwm-backlight': driver_bound: bound to device
  [   53.919213] mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) with backlight-lcd0

So a SYNC_STATE_ONLY device link is created from backlight-lcd0 to edp-tx. When
the edp-tx probes, the link is dropped, since it is SYNC_STATE_ONLY. When the
backlight-lcd0 probes a new devlink is attempted to the consumer edp-tx and
fails, since it is useless, printing the warning.

You mentioned a cycle before. The only cycle I see is between the edp-tx and the
panel, but doesn't involve the backlight:

  [    0.198104] ----- cycle: start -----
  [    0.198105] /soc/edp-tx@1c500000/aux-bus/panel: cycle: depends on /soc/edp-tx@1c500000
  [    0.198112] ----- cycle: start -----
  [    0.198113] /soc/edp-tx@1c500000/aux-bus/panel: cycle: child of /soc/edp-tx@1c500000
  [    0.198119] /soc/edp-tx@1c500000: cycle: depends on /soc/edp-tx@1c500000/aux-bus/panel
  [    0.198125] ----- cycle: end -----
  [    0.198126] platform 1c500000.edp-tx: Fixed dependency cycle(s) with /soc/edp-tx@1c500000/aux-bus/panel

Just in case I tried using post-init-providers:

  diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
  index 75d56b2d5a3d..19df138ef043 100644
  --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
  +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
  @@ -322,6 +322,7 @@ &edp_tx {
  
          pinctrl-names = "default";
          pinctrl-0 = <&edptx_pins_default>;
  +       post-init-providers = <&panel>;
  
          ports {
                  #address-cells = <1>;
  @@ -344,7 +345,7 @@ edp_out: endpoint {
          };
  
          aux-bus {
  -               panel {
  +               panel: panel {
                          compatible = "edp-panel";
                          power-supply = <&pp3300_disp_x>;
                          backlight = <&backlight_lcd0>;

It broke the cycle, as I no longer see it in the logs, but the failed device
link warning is still there as expected.

It seems to me that the issue comes form the device link being SYNC_STATE_ONLY
in the first place. I see that comes from the 'else' path in

	if (con->fwnode == link->consumer)
		flags = fw_devlink_get_flags(link->flags);
	else
		flags = FW_DEVLINK_FLAGS_PERMISSIVE;

and the value on each side of the comparison is:

con->fwnode: /soc/edp-tx@1c500000
link->consumer: /soc/edp-tx@1c500000/aux-bus/panel

Could you help me understand what (if anything) is wrong here?

(I also noticed that as per the DT the consumer for backlight-lcd0 should be the
panel, but the devlink has it instead as the edp-tx, I'm guessing that's another
symptom of the same issue)

Thanks,
Nícolas

> 
> Thanks,
> Nícolas
> 
> > 
> > 2. If we take this patch, it might be better to make a "useless device
> > links" helper function and use the same on in device_link_add() and in
> > the "if" condition that's used to decide if a device link should be
> > created. The con == sup is another "useless device link" check. But
> > I'm not really sure if we should mask this error as it help with stuff
> > like (1). con == sup is a bit more clear cut example of a "useless
> > device link" in the context of fw_devlink.
> > 
> > -Saravana

