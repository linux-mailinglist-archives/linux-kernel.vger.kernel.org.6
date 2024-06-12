Return-Path: <linux-kernel+bounces-211943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EFA90592F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C591C219B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC465181BAE;
	Wed, 12 Jun 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jGBkoLvM"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBEE181B9F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211185; cv=none; b=M4VGPz+YDupPdupw/wCvERltZPuSSuYahnNrjjeXEtBKABwC9tdgtN5JJUCCa0GngsSCB/zRpwdk0UUwnFsdPfVX2vaBDubnMVeeFctw8neBqT3Hi6NlFFQyYiH6GZfi4Zgvq5JJ94rTQtMW/l4Q5oN/tnv1T3Rru+hmTBB+S+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211185; c=relaxed/simple;
	bh=4lDWDL+MI8dXm/cLOrE2UQ6kio+8e5ilRQYq2zx3sQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMMMr6Y8NX78jNB+rtzAiI1oL+MCdJlgEeW7QuIMR902PaeSFpOS4y2BXbJTyysEOKPh8tArBVWeXXLihO9vv1drVztSfNpZ/YV26lIYXJ1mtiKUBnZwwb0vrYY35/5EysnsIDEyJzqigeQ1EjmA6rOb6XX6OeSLv6ZK9kRfqx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jGBkoLvM; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-795a4fde8bfso135643785a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718211179; x=1718815979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lDWDL+MI8dXm/cLOrE2UQ6kio+8e5ilRQYq2zx3sQc=;
        b=jGBkoLvMAs/SQupsWFNbejAAfdQna1OTaHbfbnntgCUqpcIm/mTk8o86hs5V81FaaO
         OngKHrzYDiYrSf2g7JbwwIC7bnMjDDtgxgulqkcKTnQl9H6kpNcUovOiucHYCsJgX3fG
         cBe+2g0ZCQBlZM9tbHIG/NGkYwt3itw5zKrA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718211179; x=1718815979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lDWDL+MI8dXm/cLOrE2UQ6kio+8e5ilRQYq2zx3sQc=;
        b=J1LTziGYkzjL6kzKPzqX7llY4DrT6yGxkxTTJdKwsaiLsUYx39J8XlJW7uu52UkkW6
         6npg3iXT/gABcTScQruvtUDmFzxhyc6F7qu+wepPdMby564SQv6v8fXMVLHZdFeI/fTM
         WnnDQGMkCajO5wGhjJ3eyh+yJERwlPyD3H6ud5EfWNwlc7zI6xBvrTtj/XLbtjsBKXfX
         9iPdxrDKluVx7RSmbFQbeDZ3k6Lv3x5vkMvhcrt4SowiyJ9YWLq6dtYREyiFtMVmNAcf
         oCz/V6zdbq3WxoyFO1xngcgJ/krOYvezHKW5mjeURCoSch4vHzDjK6jUiygcv4jq/RWB
         apiA==
X-Forwarded-Encrypted: i=1; AJvYcCXGjSq6+pzV6iU1ndHd5Lj9kd05jUgWXqCvNNEus5fQncFyJt7DKyMOpLWTp0Hmij5DmVj7BXeOGwK3NZLIzw3bekz/Ptz9OpvXMdPD
X-Gm-Message-State: AOJu0YwMPMtnaL+d8yjv/TpuekCcjKo5iK6/zyeiBfQSv4MiUYax1bA1
	FmhB9WkuPp/76Jltvy7tcVS+evyPu06AG2t5aeYibUXwcI/6B878xe80nYaX3wcgfs2YQ2LBb9k
	=
X-Google-Smtp-Source: AGHT+IHHtHR6tcGYP+Uia3VosV3UXx9ftEcTxkN8zI2EkrN3Rd6SIYF/Tw9klTpliGFi9VLanbeCHQ==
X-Received: by 2002:a05:620a:240a:b0:795:d442:2a59 with SMTP id af79cd13be357-797f6154513mr259894585a.67.1718211179404;
        Wed, 12 Jun 2024 09:52:59 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79581331ec0sm316703885a.16.2024.06.12.09.52.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:52:58 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4405cf01a7fso5841cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:52:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkuyNzessX0LrKahI4KQHZV/jFB42mekaLb4xXO+pNy1KY5jV8KwXNN4gTaFTyqTriK4xdNjNDrZ7PcqoF6/xnGrr2A2i+zveSa0lg
X-Received: by 2002:a05:622a:580d:b0:43f:a8fe:d5c0 with SMTP id
 d75a77b69052e-4415a221a1bmr4461961cf.25.1718211177899; Wed, 12 Jun 2024
 09:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
 <20240612-garnet-condor-from-saturn-1c51bb@houat> <CAD=FV=Xpu0-_kEvRWy9w8ypjo7pF7tsFWxHfhMZ=YjHugTqG1w@mail.gmail.com>
 <Zmm6_27GikpmT3HQ@phenom.ffwll.local>
In-Reply-To: <Zmm6_27GikpmT3HQ@phenom.ffwll.local>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Jun 2024 09:52:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XpJtCU+8aSaT0e5Ob5Owcn8b0gcdZzUrQoSdE5f9CerA@mail.gmail.com>
Message-ID: <CAD=FV=XpJtCU+8aSaT0e5Ob5Owcn8b0gcdZzUrQoSdE5f9CerA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at shutdown
To: Doug Anderson <dianders@chromium.org>, Maxime Ripard <mripard@kernel.org>, 
	dri-devel@lists.freedesktop.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Chris Morgan <macromorgan@hotmail.com>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org
Cc: Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sima,

On Wed, Jun 12, 2024 at 8:13=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> wro=
te:
>
> > > I ran the coccinelle script we started with, and here are the results=
:
> > >
> > > ./drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:1640:25-39: ERROR: KMS driver v=
mw_pci_driver is missing shutdown implementation
> > > ./drivers/gpu/drm/kmb/kmb_drv.c:621:30-49: ERROR: KMS driver kmb_plat=
form_driver is missing shutdown implementation
> > > ./drivers/gpu/drm/tiny/arcpgu.c:422:30-52: ERROR: KMS driver arcpgu_p=
latform_driver is missing shutdown implementation
> >
> > Sure, although I think we agreed even back when we talked about this
> > last that your coccinelle script wasn't guaranteed to catch every
> > driver. ...so I guess the question is: are we willing to accept that
> > we'll stop disabling panels at shutdown for any drivers that might
> > were missed. For instance, looking at it by hand (which also could
> > miss things), I previously thought that we also might need:
> >
> > * nouveau
> > * tegra
> > * amdgpu
> > * sprd
> > * gma500
> > * radeon
> >
> > I sent patches for those drivers but they don't go through drm-misc
> > and some of the drivers had a lot of abstraction layers and were hard
> > to reason about. I'm also not 100% confident that all of those drivers
> > really are affected--they'd have to be used with panel-simple or
> > panel-edp...
>
> Aside from amdgpu and radeon they're all in -misc now, and Alex is
> generally fairly responsive.

Sorry for not keeping up with things, but can you point to where this
was documented or what patch changed things so that these drivers went
through drm-misc? From the MAINTAINERS file I see commit 5a44d50f0072
("MAINTAINERS: Update drm-misc entry to match all drivers") and that
shows several of these drivers as "X:". As far as I can tell that
means that they _aren't_ handled by drm-misc, right? Maybe the
decision was made elsewhere and MAINTAINERS was just not updated, or
I'm not looking at the right place? I checked drm-misc-next and
drm/next and, for instance, "tegra" and "kmb" still show as excluded.

-Doug

