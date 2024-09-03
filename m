Return-Path: <linux-kernel+bounces-313942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDFF96ACA8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6338A1F2557F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA8C1D58B7;
	Tue,  3 Sep 2024 23:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iEAGK9Ys"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750E01EC00B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 23:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405297; cv=none; b=sqRgjH4ECrB5o7svatbnUwi0gSxw5mtB9FaBl6wshdV8Nkqc9A2zrG83wnbxGWVl9ge2jEt6kkHERfgExQuuDNMk2MC1kIdoI7WkfUXJO/kWzxjwyzeN5GRxu54EurSSPtQsZa2srplknzoznGtKhddepGb1pfQybvkwZGeGAYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405297; c=relaxed/simple;
	bh=plmlcLlzOAXF+94zhqL6I3TOmr7yQc1mIxhUIPH7J28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2WxIuWpaUTtnOGIJHDia6uH8KgtF/H7GTL7oSyNIIaKM4Ku3L8Ph4e4qLDJmcGpDDP7qThbTGgaRdNGyKbfeyPO0SJx+m+/lhCKUMNFSTbdrgH+oduJ5moogpA3OWi4MKaqbOEpbXZGVaehmIiezzfpITah6aglqEQkstvEt6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iEAGK9Ys; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a7f86026a0so392513285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 16:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725405294; x=1726010094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKGnNzBix9k9BwTLwmd0F4XaUJ7PXl0Hgu4ajuAli18=;
        b=iEAGK9YsubFctjBESMJocxHUt5aSXcbEq6ZfvBLjGQWqdW2HCdegX78T4UdMhGnN5v
         Sb9tHPvIR+pAS0zgj9V9wq77u9lLMnGFhSYjHWHS0nRiBmuHOjHyYaSl56AP7yxQvlzX
         oU92880EOPDFBu3AYoMkT5VkfVLo9ZIVInTfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725405294; x=1726010094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKGnNzBix9k9BwTLwmd0F4XaUJ7PXl0Hgu4ajuAli18=;
        b=lScHaTEC1SpQ1DshUvhyAQDlY4uDDKgLSNT3a4wszxdImcq0Of1LREZ6lcQN/ed6JY
         oGhhiOb5ZTNy8b2k0rjcrNzQ+1MNlxJiSBSJUR/JmEH9/JPU9luZYND9Hcqc+kBBQj28
         bwHXRl9p7IfcSyuxaasFSzVx6Y3+Ldxt6j8zto59lK2ORo8NX66HrpKVUz+R5/Wk0u0z
         bxYO/+t/Qkjj7QDc9GOi3U2kLeqb2uXhZzh6HHlIBMCU6cgPgjaEz5vz7JOmms2yw/vi
         0hkk9Kw2I+4VcgR2P6xH2xYceTzUMT4ykO/hLkjqRTync9n/97kxOdX6Kb/rSKANxFte
         bfAg==
X-Forwarded-Encrypted: i=1; AJvYcCXybzGC8/ES0UuWvm99cb5CnnFPzllpxJMTq7pV48XFdGrsoyzt0TiP4o5W3K3VUXpOGIRJw+OC/49jdxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+W0kyvUZzwUhk19E6tOmGigTouR8vP5iX4N2+47Akmokf9Ih
	Ty0bCW0lZZ17XOYpRpZzSa8M+cq3RO54+v3RWQkK3wFhO/9mbsdPdGqBabEu/YvN50RPXHf6FVI
	=
X-Google-Smtp-Source: AGHT+IEYr8RcAj+6tyR0G4cK3cfrjxodQAN9vcOi+GbiVQmEDHQ/hQxWQ8uE2SK2EJXjQQHiQ097hA==
X-Received: by 2002:a05:620a:2681:b0:7a1:da5e:c4c8 with SMTP id af79cd13be357-7a89324a1camr1664055185a.40.1725405293513;
        Tue, 03 Sep 2024 16:14:53 -0700 (PDT)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c24067sm572000685a.47.2024.09.03.16.14.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 16:14:52 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bf92f96f83so28943046d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 16:14:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVMaqnJ2q5LP+sBpdFxvYH9WWwt8kETcWS8qtefVicQV1wtn/MJaO8aeMES/SZJ06VWZHYGhKrh8DmUH8=@vger.kernel.org
X-Received: by 2002:a05:6214:5b0f:b0:6bd:83c3:ba1 with SMTP id
 6a1803df08f44-6c3554753f6mr170317256d6.52.1725405292025; Tue, 03 Sep 2024
 16:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823163513.4344-1-hanchunchao@inspur.com> <CAD=FV=X_a2NzAi6L3N-Bgta4Vn7uSd3DPZ355LBg1gpd=A7H+w@mail.gmail.com>
In-Reply-To: <CAD=FV=X_a2NzAi6L3N-Bgta4Vn7uSd3DPZ355LBg1gpd=A7H+w@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 3 Sep 2024 16:14:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UzEucvODyhYo=o-eroe3Q3+siKN2yWwAfOQ=L8NXBD_Q@mail.gmail.com>
Message-ID: <CAD=FV=UzEucvODyhYo=o-eroe3Q3+siKN2yWwAfOQ=L8NXBD_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83102: Add NULL pointer check in hx83102_get_modes
To: Charles Han <hanchunchao@inspur.com>
Cc: neil.armstrong@linaro.org, yangcong5@huaqin.corp-partner.google.com, 
	quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, liuyanming@ieisystem.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 23, 2024 at 9:49=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, Aug 23, 2024 at 9:35=E2=80=AFAM Charles Han <hanchunchao@inspur.c=
om> wrote:
> >
> > In hx83102_get_modes(), the return value of drm_mode_duplicate()
> > is assigned to mode, which will lead to a possible NULL pointer
> > dereference on failure of drm_mode_duplicate(). Even though a
> > small allocation failing is basically impossible, kernel policy
> > is still to check for NULL so add the check.
> >
> > Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as separate d=
river")
> > Signed-off-by: Charles Han <hanchunchao@inspur.com>
> > ---
> >  drivers/gpu/drm/panel/panel-himax-hx83102.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> FWIW, this looks to be v4 of your patch, right? The subject line
> should include a version number and you should be providing version
> history "after the cut" in your patch. Tools like "b4" and "patman"
> can help you get this correct [1]. If you plan to continue posting
> patches you'll need to start getting this right. The next version of
> your patch would be v5.
>
> [1] https://sched.co/1aBGS
>
> I see:
>
> v1: https://lore.kernel.org/r/20240821095039.15282-1-hanchunchao@inspur.c=
om
> v2: https://lore.kernel.org/r/20240822093442.4262-1-hanchunchao@inspur.co=
m
> v3: https://lore.kernel.org/r/20240823083657.7100-1-hanchunchao@inspur.co=
m
>
>
> > diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/=
drm/panel/panel-himax-hx83102.c
> > index 6e4b7e4644ce..e67555323d3b 100644
> > --- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
> > +++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> > @@ -565,6 +565,8 @@ static int hx83102_get_modes(struct drm_panel *pane=
l,
> >         struct drm_display_mode *mode;
> >
> >         mode =3D drm_mode_duplicate(connector->dev, m);
> > +       if (!mode)
> > +               return -EINVAL;
>
> I would have returned -ENOMEM since drm_mode_duplicate() is defined to
> allocate memory copy the mode (like strdup does for strings) and it
> should be clear that the only failure case is failure to allocate
> memory. Other callers convert a NULL return as -ENOMEM.

FWIW: if you spin v5 of this patch and have it return -ENOMEM then I'm
happy to apply it.

-Doug

