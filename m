Return-Path: <linux-kernel+bounces-571658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC1FA6C041
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D797AC4F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE4422D4F9;
	Fri, 21 Mar 2025 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mm49f6Ka"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CBC1BEF77
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575268; cv=none; b=H6R2mUFkP9fFyjf74sETgvhzBd1341O4IpqJzsemYacydeGy8KXQK0mnwy29KQdfkju6plly8XQldzHjKk9B71WL8V5opSSgYw9I8e49dOnjjk6cKeALvu0Pj+iJvaBgNG7yR6JwuYspi3C3rvyPC8OBwUyZkkCHawIOEDoDpzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575268; c=relaxed/simple;
	bh=eUxdW+AhbLxr6ZkHoVChC0c1ciEY5hOoa/Avgl15d2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRvqwtZVIiEi2Og884k1IsYAVCNJs+XZ6Sl+c1tPFkjw7N+/YgLycTaoo2KT8Gh8Y0wVjthkYib7glOCQg3d9WpfuJ+Jqn15F37g9wnYUEtFGSJPZ6f+fEkCWcrXED6c3MvhR2MaSoUXwvemkmg+40AIBngAwA+Jc0Z57HROpkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mm49f6Ka; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-226185948ffso46292155ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742575266; x=1743180066; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9FaPMoTNGeH8ohUXRHD1ixUsB8Tp0d1wecl5lHYFkNU=;
        b=Mm49f6KaLb2tRtQYE5nmSKpFfKYsofhJwTRJf8zJzs9M/Pl8MrURpHwVS11uEIeacK
         ZwJPlVAtVZN38V5YqwFfVDKJGvLPqOFDPo1/EfWAAmQBdF90rEnjgxIuEwIBZGgdhbu9
         nwwjZj2Hp3gWO+dzg8KWvRVEKwZCsdehPLSOIwKbi8mr8jku+EQ+hVPqtSzIx5yHMOYT
         f+6xyCMYkJoECWGF3snstRi/M7RBUJcZ1Npd/lEkKlpibJ7feT8o72QOrmXuC7CBPXW5
         WDHdf6VVvWsNn8rNOCbEtJmclVHC0gNu7rbwTIZ6qR9oHhTRf9PRcr+OMKB2O5w24EHG
         +veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742575266; x=1743180066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FaPMoTNGeH8ohUXRHD1ixUsB8Tp0d1wecl5lHYFkNU=;
        b=JwbrjYZukRu3vKCKpCkuCGnOL7pFRB4PYcPnu110m5N5PdvZ+libnrxu705SW3YNbT
         hemxhDow8nDZNxb0WahY16gEvqDCe3K7BtMqk7SlrO5v/I3FuAT1hEHgRLFlefXAz4FO
         ovYQdhEFGLL4M821zmhtS0WNYpRHVo32bwEZdcoQQoZc2wcnRLe3/inrArrWoCLecYOI
         91GCvUYLZ26s366QKTaZtkP/6lDsl+l4uNWTmF0UmxGKAM7g/WLtR8ujeErPygaUMvQm
         BLWBrw0EZtCNLKoQ/XGXc1h7qC9Xj3NnrFV/hlbtTGTetPEn88y0ETKt2UFEEYVeAVmA
         dSLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB18iXBFm9vr3u4aF1nB7cn7qlftRh6X89JwJp3D6pKrZ6ZhA97Mahu6d4LMfPE2yjHmOJQ8+7+pt1Hu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhM3D5Od+2otXHLiglGCz8xiPiFDIxjhdurI3bBAHcNSOAE5bS
	rl0auqm6yuZR5BtazfvMCbgGUl2XyVtKLM0aLidNgaOQEBRUypsUvsCwdmJgvcv9IjrGQBT4BdV
	gfQsT14KDie5aHndDH3KDn+QVatgtsbT9YKS6fg==
X-Gm-Gg: ASbGncvAeirf67RvAujrcWMJqIjoVXQd+SbUmFRZxWkXRC8I2kwCPCgPQdcoT5O6kVo
	PeCYk2kfc/i58hw8hG+7wONMpFjFCT7TmEhfeGiP45YuF3HABopkdWSEcN1/k8uDtl0Y5jpX0Uo
	J6JY2zuIaOAXjKT47mHbsM2MoeSP4=
X-Google-Smtp-Source: AGHT+IGpGZv7QPVlqJm7zVCLsooGhrw6FWGfyPFguHfvgX7YH05uiYw0fJOVDVFEFFx3C6Sc2YWTTHkw7pNlgPfHnVk=
X-Received: by 2002:a05:6a00:21cf:b0:736:d6da:8f9e with SMTP id
 d2e1a72fcca58-7390564df47mr6098579b3a.0.1742575266016; Fri, 21 Mar 2025
 09:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109171956.3535294-1-yeoreum.yun@arm.com> <CAJ9a7ViuVntYL62q=WYPkFR3++cyufPdKUHm0FUAPyGy76pB_A@mail.gmail.com>
 <GV1PR08MB10521BB7C93822F5124F2D66EFBD22@GV1PR08MB10521.eurprd08.prod.outlook.com>
In-Reply-To: <GV1PR08MB10521BB7C93822F5124F2D66EFBD22@GV1PR08MB10521.eurprd08.prod.outlook.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 21 Mar 2025 16:40:53 +0000
X-Gm-Features: AQ5f1JoCtvVwtGKHSe22bJ_CAOESEB84P3ODOa8rwi7b1lfrK1QBbZhPSXQhfG0
Message-ID: <CAJ9a7Vgz+L+UYf8Yqyu9J5hp3AB3WPSKutA4AvR-OFdu8b-dPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] coresight: prevent deactivate active config while
 enabling the config
To: Yeo Reum Yun <YeoReum.Yun@arm.com>
Cc: Suzuki Poulose <Suzuki.Poulose@arm.com>, 
	"james.clark@linaro.org" <james.clark@linaro.org>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, 14 Mar 2025 at 15:25, Yeo Reum Yun <YeoReum.Yun@arm.com> wrote:
>
> Hi, Mike.
>
> > >  static void cscfg_remove_owned_csdev_features(struct coresight_device *csdev, void *load_owner)
> > > @@ -867,6 +870,28 @@ void cscfg_csdev_reset_feats(struct coresight_device *csdev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
> > >
> > > +static bool cscfg_config_desc_get(struct cscfg_config_desc *config_desc, bool enable)
> > > +{
> > > +       if (enable)
> > > +               return atomic_inc_not_zero(&config_desc->active_cnt);
> > > +
> >
> > Not sure why we have an "enable" parameter here - it completely
> > changes the meaning of the function - with no comment at the start.
>
> Sorry. But what I intended is to distinguish
>     - activation of config
>     - enable of activated config.
> Because, current coresight doesn't grab the module reference on enable of activate config,
> But It grabs that reference only in activation.
> That's why I used to "enable" parameter to distinguish this
> while I integrate with module_owner count.
>
> > >         list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
> > >                 if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
> > > -                       atomic_dec(&config_desc->active_cnt);
> > >                         atomic_dec(&cscfg_mgr->sys_active_cnt);
> > > -                       cscfg_owner_put(config_desc->load_owner);
> > > +                       cscfg_config_desc_put(config_desc);
> > >                         dev_dbg(cscfg_device(), "Deactivate config %s.\n", config_desc->name);
> > >                         break;
> > >                 }
> > > @@ -1047,7 +1066,7 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > >                                      unsigned long cfg_hash, int preset)
> > >  {
> > >         struct cscfg_config_csdev *config_csdev_active = NULL, *config_csdev_item;
> > > -       const struct cscfg_config_desc *config_desc;
> > > +       struct cscfg_config_desc *config_desc;
> > >         unsigned long flags;
> > >         int err = 0;
> > >
> > > @@ -1062,8 +1081,8 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > >         raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> > >         list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
> > >                 config_desc = config_csdev_item->config_desc;
> > > -               if ((atomic_read(&config_desc->active_cnt)) &&
> > > -                   ((unsigned long)config_desc->event_ea->var == cfg_hash)) {
> > > +               if (((unsigned long)config_desc->event_ea->var == cfg_hash) &&
> > > +                               cscfg_config_desc_get(config_desc, true)) {
> > >
> > This obfuscates the logic of the comparisons without good reason. With
> > the true parameter, the function does no "get" operation but just
> > replicates the logic being replaced - checking the active_cnt is
> > non-zero.
> >
> > Restore this to the original logic to make it readable again
>
> It's not a replicates of comparsion logic, but if true,

sorry - missed that point .

> It get the reference of active_cnt but not get module reference.
> The fundemental fault in the UAF becase of just "atomic_read()"
> so, it should hold reference in here.
>
> So, If you think the cscfg_config_desc_get()'s parameter makes obfuscation,
> I think there're two way to modfiy.
>
>     1. cscfg_config_desc_get()/put() always grab/drop the module count.
>     2. remove cscfg_config_desc_get()/put() but just use atomic_XXX(&active_cnt) only
>         with cscfg_owner_get()/put()
>
> Any thougt?
>
> Thanks!
>
>

The get and put functions are asymmetrical w.r.t. owner.

The put will put owner if active count decrements to 0,
The get if not on enable path will put owner unconditionally.

This means that the caller has to work out the correct input conditions.

Might be better if:-

get_desc()
{
    if (! desc->refcnt) {
       if (!get_owner())
           return false;
   }
   desc->refcnt++;
    return true;
}

put_desc()
{
   desc->refcnt--;
  if (! desc->refcnt)
    put_owner()
}

and then change the enable_active_cfg matching logic to

if ( (desc->refcnt) && (desc->hash == hash) && get_desc()) {
     < set active cfg>
}



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

