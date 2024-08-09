Return-Path: <linux-kernel+bounces-281214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DDA94D465
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AC92B25233
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B8A1991B1;
	Fri,  9 Aug 2024 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="kzKgS7ST"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C39168B8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220061; cv=pass; b=FqFwX6+yUM15Gfid2W58D1C1NBxwbvekR1WdZ8I93pQT7iovsUnp6YUXX5TmmpVhdMTRiaWo2vru0Qaj4v9prrLcBIaHB8JtT92gLY1Fiu1woJOIrfwquT3CalbcwNO6LMjIJ3Gdkxs90cD1N+TzQtQ7Z7PWwfIVbv4v5+D4YkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220061; c=relaxed/simple;
	bh=BhdXbCF4opZF72OIDH0MzBIs3IrQuVrVH4NOQMVK3fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTiZxibpXwZLjMeaMxn7FiRSRJnbcAVGz0xKfpJmGndgfKLT7cbxZkyGpccGlcBrvoFT0JQ/E3K0Mp+DlwcZbZ2kI5KqzNi96xj7euAF6eQu9+kCLTNRUC5r1Qr8qbwDTK6qaq4blt2ofG9g1yjqAq26kNSv6ItbAX23SdY2BQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=kzKgS7ST; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723220009; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Tg1Atl3izxzo2dG1duotyLhowrLI78Hq/3+8dRXUICF74KT/+/SskcnCWKh+Owp8wd4XS6aGNbKa9AwK8xRkVKWfkL7zIqym10jjVv96HWXd/VocEGf5cnj3xLVVUmkxvbEoETA/8pZP1bqU5VYuk0skUGMM3DjypKuGUd9HA/I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723220009; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zsqexKaCUmnzNcgCOpXqps2v8Vk4UqQgswVHvnYf6OE=; 
	b=BkAtcoy90LtzaukBoSi2lpQrEhWylZZNgPtTzZpCC0NWUJhiqddIzd0+5b5hl2BjtE+hWRsDPxT1oRX7m+2eKYhQCEmIRx7qhd0o8ysnKaEy9v7WdCJZGmbCNeGnaXsvgNE7QqVEU6kIko3Sq+cs68FoUTYhY0KyqQNl9eI/Tic=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723220009;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=zsqexKaCUmnzNcgCOpXqps2v8Vk4UqQgswVHvnYf6OE=;
	b=kzKgS7STjyFe+w5RiGKuXbCtJmEQq279XddftWUZoct5gqWAW1MIqKgZ2rnLko+a
	tCUlOfUFxUCX2eTXIH0gosCQ35+hPYQHXr55FmjdOA6IfvW2UAonIqnbd8HpPQpr8pZ
	fyU6gpd/TVw034oLechwVLqC8xl5FB9ONbFcrOOI=
Received: by mx.zohomail.com with SMTPS id 1723220007751173.19020273790488;
	Fri, 9 Aug 2024 09:13:27 -0700 (PDT)
Date: Fri, 9 Aug 2024 12:13:25 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, kernel@collabora.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Don't log intentional skip of device link
 creation as error
Message-ID: <c622df86-0372-450e-b3dd-ab93cd051d6f@notapiano>
References: <20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com>
 <CAGETcx-sAu-wMDKT9zCeCzLzZ=ZdvK+CSoX34YxMLd5z0YeVZQ@mail.gmail.com>
 <7b995947-4540-4b17-872e-e107adca4598@notapiano>
 <575b02aa-6496-492b-b37d-d0612165eda3@notapiano>
 <CAGETcx9e4mpcMY+pqMYXsVWGcjgkctCqgO665KgqUH4JvYbUAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx9e4mpcMY+pqMYXsVWGcjgkctCqgO665KgqUH4JvYbUAQ@mail.gmail.com>
X-ZohoMailClient: External

On Mon, Jul 29, 2024 at 05:08:48PM -0700, Saravana Kannan wrote:
> On Mon, Jul 29, 2024 at 2:25 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 09:56:07AM -0400, Nícolas F. R. A. Prado wrote:
> > > On Mon, Jun 24, 2024 at 04:53:30PM -0700, Saravana Kannan wrote:
> > > > On Mon, Jun 24, 2024 at 8:21 AM Nícolas F. R. A. Prado
> > > > <nfraprado@collabora.com> wrote:
> > > > >
> > > > > Commit ac66c5bbb437 ("driver core: Allow only unprobed consumers for
> > > > > SYNC_STATE_ONLY device links") introduced an early return in
> > > > > device_link_add() to prevent useless links from being created. However
> > > > > the calling function fw_devlink_create_devlink() unconditionally prints
> > > > > an error if device_link_add() didn't create a link, even in this case
> > > > > where it is intentionally skipping the link creation.
> > > > >
> > > > > Add a check to detect if the link wasn't created intentionally and in
> > > > > that case don't log an error.
> > > >
> > > > Your point is somewhat valid, and I might Ack this. But this really
> > > > shouldn't be happening a lot. Can you give more context on how you are
> > > > hitting this?
> > >
> > > Of course. I'm seeing this on the mt8195-cherry-tomato-r2 platform.
> > >
> > > The following error is printed during boot:
> > >
> > >   mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) with backlight-lcd0
> > >
> > > It doesn't happen with the upstream defconfig, but with the following config
> > > change it does:
> > >
> > >   -CONFIG_PWM_MTK_DISP=m
> > >   +CONFIG_PWM_MTK_DISP=y
> > >
> > > That probably changes the order in which the MTK DP and the backlight drivers
> > > probe, resulting in the error.
> > >
> > > One peculiarity that comes to mind is that the DP driver calls
> > > devm_of_dp_aux_populate_bus() to run a callback once the panel has finished
> > > probing. I'm not sure if this could have something to do with the error.
> > >
> > > Full log at https://lava.collabora.dev/scheduler/job/14573149
> >
> > Hi Saravana,
> >
> > With the given context for where this issue is happening, what do you think
> > about this patch?
> 
> Ah sorry, missed your earlier email.
> 
> Couple of points:
> 1. It looks like the link in question is "SYNC_STATE_ONLY" because
> it's part of a cycle. Correct me if I'm wrong. You might want to use
> the new "post-init-providers" property to help fw_devlink break the
> cycle and enforce the right dependency between the edp-tx and your
> backlight. And then this error should go away and your device ordering
> is enforced a bit better.

I don't see any cycle there. edp-tx points to backlight, but backlight doesn't
point back (from mt8195-cherry.dtsi): 

  &edp_tx {
  	...
  	aux-bus {
  		panel {
  			compatible = "edp-panel";
  			power-supply = <&pp3300_disp_x>;
  			backlight = <&backlight_lcd0>;

  
  backlight_lcd0: backlight-lcd0 {
  	compatible = "pwm-backlight";
  	brightness-levels = <0 1023>;
  	default-brightness-level = <576>;
  	enable-gpios = <&pio 82 GPIO_ACTIVE_HIGH>;
  	num-interpolated-steps = <1023>;
  	pwms = <&disp_pwm0 0 500000>;
  	power-supply = <&ppvar_sys>;
  };

And DL_FLAG_CYCLE is not set in the flags in the error log: 0x180. (Let me know
if there's something else that I should be looking at to detect a cycle)

Thanks,
Nícolas

> 
> 2. If we take this patch, it might be better to make a "useless device
> links" helper function and use the same on in device_link_add() and in
> the "if" condition that's used to decide if a device link should be
> created. The con == sup is another "useless device link" check. But
> I'm not really sure if we should mask this error as it help with stuff
> like (1). con == sup is a bit more clear cut example of a "useless
> device link" in the context of fw_devlink.
> 
> -Saravana

