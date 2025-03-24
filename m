Return-Path: <linux-kernel+bounces-574223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02800A6E232
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1813AA764
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3552641D7;
	Mon, 24 Mar 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y21IOOzQ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306341DDE9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840513; cv=none; b=EhJ5ypwf3GPaVxffUwly/4sV9mpzXM4Clvyp0+1N+G2RZbOnQh/VnOQgag6j/Uk+1167hi6gpZK8ZBBpTzT4l7ETBjn8LaDXPr2yk30HnGGZ+uo/e3S1yUosAHuPVyrj85weD3bCayW+rEk/RdyyTjzb91rLEOEEBs+FZETIH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840513; c=relaxed/simple;
	bh=zrnjllOaaVCrevHwpeSRdGJoKF3yeMBuYeMtGhQbo4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQF9E6XBMTuYK13YfxgMHBkCTom2bpRXipVdQMqVRV+xpXTlfBtJC+WlcQ+V0rE9+5yWaEuIV9AnEf6Eqv/fyl7uebRhwtNvkEVYmTeHNrIVP4N3pQk+vvX/f5sjg5BZFWm/LYyrDMkebfRo0Ffl4ef8ALVPe8itDvUxO1lBCbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y21IOOzQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227c7e57da2so22046535ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742840511; x=1743445311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vYGcI8imqj+MGUqjN29fBqg3Vw5woBztKuaSrXR3vbI=;
        b=y21IOOzQ7oWFkC5MgERgN3pHOrnckRViW2tubWvvZIMv0dQY3A1X9uK/8bp+AH32vx
         Y2QMbgI6c/SggVMc9QQ0RNJ1aNw6qbHKyF0SzBzjqJn6ZdeBq0HqYBJltgNcMb+3QYdE
         5TMUBZUU8wYVYWG1rtSwLZH8ZUjXqtlYSOtlLk84vqWSTUazP4/B0w1+HbqZRzVt7BA8
         nV1kuDNMTckgfuTKDtC2WDmwfjc+WfPrDwEXmI8pCVN8K/EJtFL+E2lQFoI8z/xNauox
         FKSpJtxNZLzvvsjXYd2r+TlVLd5HsFHTn4OjykcCnUzSnij8c2vUoN8KXF09KM3htf/h
         pyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742840511; x=1743445311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYGcI8imqj+MGUqjN29fBqg3Vw5woBztKuaSrXR3vbI=;
        b=DBSWNvit+tsc1m35OTSLWy+q8LcGAFzLBryjKuAZ/bsAsXc4ZWhXGThaAEC+nrBf0R
         zKwTl0A3Gk8U7NeCA8pnFO0rE4iDY9KdClrGgRQ/XlYbXZn1tgyhXTXOVfxqfQm3xnd3
         XyNxQetS3p2AJuFdo7lTz8ZIkGiLM5bPcYiFiCldNExe22GTVbxTswPadKePNUMH56/O
         hVIPupsct0hxquORaWxded0m+YrbQkLU3LXZfacBIPsoZaAxvqzzpszfm48/HedaXkwV
         1lpdyez50r1esxMMUqV4dgx8dV0YUlTftJKf24N/lOGwu1ftytqO4tquFA2zDDfkwOKK
         1ojg==
X-Forwarded-Encrypted: i=1; AJvYcCUbbOODmypHRkcQFV6+2H8UtYL8yNe6YOuNjsCd4xrKkcjO3IF78l+N62ganzbf4nqN5d7Q07jMHwHXWzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoCvbCErema4eDrrBxDFf7NFx+D6aqnYGCVxr8bbxSUjcbtuIL
	BzsLiUnQETgMPDqeFun3r1WFZbZDiTEDBJBoM0Dy+oRClasRx/xxKetgc+UKfU/ROfJsmLJ/UaB
	xpnH5Zryt1bo408qt2YNFF6CBJTyLxTR3yL4yKkDcn4zwS6Mb130=
X-Gm-Gg: ASbGnctGULblk7mt6odcRlyLK0z5QeFJkstwE/+Oov+N64d7UX60YRFR3xSkUF8CcC4
	18uENDSRnIF6moSrbFIL74zL/iHfjSZxD9Ztqpmlt5AVZ/iiuYbDkopO4rmTC7jyMSFvthoW8S7
	M+Ibv6IepGWApsVCGn1066yDxfC27L8sHT8plhJHcBxPObExtufHc+Mj8qP0E=
X-Google-Smtp-Source: AGHT+IFF3EcxhuVze+FBnKUvTSo2ADv/p17nL+WNhX5Rraz4E5NBfUNu9Acb3U1M/4KPXQVXhN5pXD8y6Aad14poHsA=
X-Received: by 2002:a05:6a00:2384:b0:730:d5ca:aee with SMTP id
 d2e1a72fcca58-73905a2529fmr23710196b3a.23.1742840511070; Mon, 24 Mar 2025
 11:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109171956.3535294-1-yeoreum.yun@arm.com> <CAJ9a7ViuVntYL62q=WYPkFR3++cyufPdKUHm0FUAPyGy76pB_A@mail.gmail.com>
 <GV1PR08MB10521BB7C93822F5124F2D66EFBD22@GV1PR08MB10521.eurprd08.prod.outlook.com>
 <CAJ9a7Vgz+L+UYf8Yqyu9J5hp3AB3WPSKutA4AvR-OFdu8b-dPA@mail.gmail.com> <Z+FlLDLV9WkGNbj+@e129823.arm.com>
In-Reply-To: <Z+FlLDLV9WkGNbj+@e129823.arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Mon, 24 Mar 2025 18:21:39 +0000
X-Gm-Features: AQ5f1JpBLeuBe2uwu_6LtTYvGXXov15RoxnfseC3LtykXCAnpx1LgBpQDY-jWNc
Message-ID: <CAJ9a7VgsBZ6MkgwVjDiOm7rvcy9KVPfPc_PbaRNX7ra8NWGb9Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] coresight: prevent deactivate active config while
 enabling the config
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Suzuki Poulose <Suzuki.Poulose@arm.com>, 
	"james.clark@linaro.org" <james.clark@linaro.org>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, 24 Mar 2025 at 13:59, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
>
> Hi Mike,
>
> Please ignore my foremer mail.. and please see my comments for your
> suggestion.
>
> > Hi
> >
> > On Fri, 14 Mar 2025 at 15:25, Yeo Reum Yun <YeoReum.Yun@arm.com> wrote:
> > >
> > > Hi, Mike.
> > >
> > > > >  static void cscfg_remove_owned_csdev_features(struct coresight_device *csdev, void *load_owner)
> > > > > @@ -867,6 +870,28 @@ void cscfg_csdev_reset_feats(struct coresight_device *csdev)
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
> > > > >
> > > > > +static bool cscfg_config_desc_get(struct cscfg_config_desc *config_desc, bool enable)
> > > > > +{
> > > > > +       if (enable)
> > > > > +               return atomic_inc_not_zero(&config_desc->active_cnt);
> > > > > +
> > > >
> > > > Not sure why we have an "enable" parameter here - it completely
> > > > changes the meaning of the function - with no comment at the start.
> > >
> > > Sorry. But what I intended is to distinguish
> > >     - activation of config
> > >     - enable of activated config.
> > > Because, current coresight doesn't grab the module reference on enable of activate config,
> > > But It grabs that reference only in activation.
> > > That's why I used to "enable" parameter to distinguish this
> > > while I integrate with module_owner count.
> > >
> > > > >         list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
> > > > >                 if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
> > > > > -                       atomic_dec(&config_desc->active_cnt);
> > > > >                         atomic_dec(&cscfg_mgr->sys_active_cnt);
> > > > > -                       cscfg_owner_put(config_desc->load_owner);
> > > > > +                       cscfg_config_desc_put(config_desc);
> > > > >                         dev_dbg(cscfg_device(), "Deactivate config %s.\n", config_desc->name);
> > > > >                         break;
> > > > >                 }
> > > > > @@ -1047,7 +1066,7 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > > > >                                      unsigned long cfg_hash, int preset)
> > > > >  {
> > > > >         struct cscfg_config_csdev *config_csdev_active = NULL, *config_csdev_item;
> > > > > -       const struct cscfg_config_desc *config_desc;
> > > > > +       struct cscfg_config_desc *config_desc;
> > > > >         unsigned long flags;
> > > > >         int err = 0;
> > > > >
> > > > > @@ -1062,8 +1081,8 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > > > >         raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> > > > >         list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
> > > > >                 config_desc = config_csdev_item->config_desc;
> > > > > -               if ((atomic_read(&config_desc->active_cnt)) &&
> > > > > -                   ((unsigned long)config_desc->event_ea->var == cfg_hash)) {
> > > > > +               if (((unsigned long)config_desc->event_ea->var == cfg_hash) &&
> > > > > +                               cscfg_config_desc_get(config_desc, true)) {
> > > > >
> > > > This obfuscates the logic of the comparisons without good reason. With
> > > > the true parameter, the function does no "get" operation but just
> > > > replicates the logic being replaced - checking the active_cnt is
> > > > non-zero.
> > > >
> > > > Restore this to the original logic to make it readable again
> > >
> > > It's not a replicates of comparsion logic, but if true,
> >
> > sorry - missed that point .
> >
> > > It get the reference of active_cnt but not get module reference.
> > > The fundemental fault in the UAF becase of just "atomic_read()"
> > > so, it should hold reference in here.
> > >
> > > So, If you think the cscfg_config_desc_get()'s parameter makes obfuscation,
> > > I think there're two way to modfiy.
> > >
> > >     1. cscfg_config_desc_get()/put() always grab/drop the module count.
> > >     2. remove cscfg_config_desc_get()/put() but just use atomic_XXX(&active_cnt) only
> > >         with cscfg_owner_get()/put()
> > >
> > > Any thougt?
> > >
> > > Thanks!
> > >
> > >
> >
> > The get and put functions are asymmetrical w.r.t. owner.
> >
> > The put will put owner if active count decrements to 0,
> > The get if not on enable path will put owner unconditionally.
> >
> > This means that the caller has to work out the correct input conditions.
> >
> > Might be better if:-
> >
> > get_desc()
> > {
> >     if (! desc->refcnt) {
> >        if (!get_owner())
> >            return false;
> >    }
> >    desc->refcnt++;
> >     return true;
> > }
>
> I think This makes another problem when
> it races with _cscfg_deactivate_config().
>
> CPU0                                          CPU1
> (sysfs enable)                                load module
>                                               cscfg_load_config_sets()
>                                               activate config. // sysfs
>                                               (sys_active_cnt == 1)
>
>                                               // sysfs
>                                               _cscfg_deactivate_config()
>                                               (sys_active_cnt == 0)
>                                               (config->active_cnt = 0)
> ...
> cscfg_csdev_enable_active_config()
>   lock(csdev->cscfg_csdev_lock)
>   // here get module reference??
>   // even sys_active_cnt == 0 and
>   // config->active_cnt == 1.
>   get_desc()
>   unlock(csdev->cscfg_csdev_lock)
>
>
>   // access to config_desc which freed
>   // while unloading module.
>   cfs_csdev_enable_config
>
>
> Because, the desc->refcnt meaning of zero is different from the context.
>    - while activate . it should get module reference if zero.
>    - while enable active configuration, if zero, it should be failed.
>
> that means to prevent this race, the core key point is:
>    when config->active_cnt == 0, it should be failed in cscfg_csdev_enable_active_config()
>

This is not a failure case, it simple means that this config should
not be activated for this device.
It is possible for a configuration to be active on the system, without
it being active for a particular coresight device.

Having a get/put interface for the config descriptor - which prevents
the config from being unloaded is fine, the key logic here is that we
are searching a list of possible enabled configurations for this
device and taking the necessary action to enable it if we find one -
and there can only ever be a single configuration enabled for a trace
session.

Therefore when the list of loaded configs for a device is > 1, then
all but one is allowed to be active - so the search code will validly
find instances where config->active_cnt == 0.

My objection to the original interface was not the get/put operations
to protect the module from unload, but the fact that the logic
deciding if a config needed to be enabled on the device was hidden
inside the get() operation.
My suggestion is to restore the logic that decides if there is a
config to enable on the device be clear in the enable function itself,
then use get/put as appropriate to prevent module unload.

Regards

Mike


> Because, according to context the handling the zero reference value is
> different, It seems,to integrate the get_desc() interface to handle
> above case together without extra arguments (in case of here is
> "enable").
>
> If this interface is really ugly and unhappy to you,
> I think It should remove get_desc()/put_desc().
> although we can add new interface for cscfg_config_desc_get() for enable
> path. but it makes people more confused.
>
> So my suggestion is:
>    - sustain this patch's contents
>    - or remove get_desc()/put_desc() interface but use
>      atomic_inc_zero(&config_desc->active_cnt) directly in
>      cscfg_csdev_enable_active_config()
>
> Any thougt?
>
> Thanks.



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

