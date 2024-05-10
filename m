Return-Path: <linux-kernel+bounces-176251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BA98C2C07
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75DA1F219CC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B76013CF92;
	Fri, 10 May 2024 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DISYDo9z"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4052913C3D6
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377439; cv=none; b=mmOVqUh5jyllYyEmqHDwvJ6v3eV6i5YDL80d2vy5Ak5SPYaqfyTqwiKxUeYpaggVJ+nE02vCmMAnA2VH0sd4GaZyEUDO6YQq6AHaN2wOR9r3i3Tz3caTF6Kdca13ZClz4ClxOAGfqrNNFJGhgBNAuErUvm12eY+28DvOeGJBbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377439; c=relaxed/simple;
	bh=kO9ED7trCjjUAJJ/nuxp2R0+BPsrK8QM3ynp21RToMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pun3QMa4niRqWyhKw3I/G897+/w7VG6KCcdVqko7kxX6Qx7+1iWsYamUrjd3Wp+G/VI3C+9qv2dk2kGPv5p7RKsYjiL3CGRq/n8JlZYKcNUUS5oMJRScC2lCF8OnqOHRIiCrpjnl2NXOzaL/pijVs6g137K6HxExWNAgI5p2e80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DISYDo9z; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so1469915a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715377437; x=1715982237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbj0m2f2QYfPFhMHqFk4yDca0m9jJq1tkTFZyZAwwvE=;
        b=DISYDo9zeYB83q8GQXbnnvEQFMc4eMUiQEew1TBEOfYkpKJxiS3ctZdLY/2pUJBUR/
         KGt3GLGmn3ns3rz3qpk/wsco/FFFR0iN26F0/MQlLH+prHgmSJj7Ye5yL/lkv5yQ425f
         pX3J9q1LxUeXk3M9lbuP6yujXmlYGCb2vciKvQSca1prSJdtIkbm5fv7as+Op6bxpnGa
         XhdL4H/VExmfOsyl1MgKRjtgRAzMYA1RoSSj8/iyEmKt4P6t27E5mETvUz4FvuF4fHSn
         JepBejMbYTrZnQQrHPREYU/88n+44W1gLvrj6R6E3PCZRsErmCv0TxHbksWHi4zN4kF8
         3H/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715377437; x=1715982237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbj0m2f2QYfPFhMHqFk4yDca0m9jJq1tkTFZyZAwwvE=;
        b=Ch0PZiW0QzswF7Hcq2se9kteiPtgPrG5S17eXVbZ8IFdDv6e42kT2MjJ3CP0gFFVyD
         wm2FGzM2ACqD5jYYiFJLlzOj+trRbKz0KA/bCV4TjUxDKfKBzahROj4+jo8jVwg/Md6Z
         S8S9glS831OxsvbDCg+4L+HrdNSfdnh08v6nlrI5kYYUpZTAXk+X2DltPMrIO/KAetvP
         5Y63n4e61I6tBOrWLArhjrPyTiJJrYwHeo4WMbtNA1q+0TQNRPlzeewLyxvpHdbbf8/f
         e/l9KfcZCQGlkTtrgZtkQ5w3fu6Uuef1y3uV8IJs8s1eDMttp0uHkbWsMkX8ZUNDznK5
         /T9g==
X-Forwarded-Encrypted: i=1; AJvYcCWuOK09aOXGzZWdTB4RUsnvcPuLtzBG+q9LV1UobiS81MjsHgzTjQHp47Tu8xmvwBXj9J5l+XxsY/jq0B1D92OTGg5JXo0LzezOIYv7
X-Gm-Message-State: AOJu0YyxuqGE2MJNExAmV8RmZFml0l1ldWDUyESKUD3Ff7iSogq3Ubbp
	My73iOm6qVutXIZvjJBtrpX8fnfqOCd/M8b2mnNY9rhO7mrwv3jcc1a0rihyKaOgWT/Ge1EYNIq
	/XjQ8HHpvAhIWT/6FBj2s/XO3AsQ=
X-Google-Smtp-Source: AGHT+IFfVrozGM2vaadK9UrpFrP98qUXh8WZsCiQVseBOTtYFa9DnTxKekjuHfLQLMXqDnFeT0efYO/0Pnjwmn0R8Zg=
X-Received: by 2002:a05:6300:808c:b0:1af:af86:ce44 with SMTP id
 adf61e73a8af0-1afde1b7259mr4352990637.40.1715377437527; Fri, 10 May 2024
 14:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-jdi-use-disable-v1-1-5c175b2ea1ee@gmail.com>
 <rpita5o6za64p7tamasssb2fja6h6ipr5cibh6gs7klkijyk6r@mausrcet2ycx>
 <CAGsSOWWAotJPz+o8HSYTrXtq6H7Vrw9KXZX1jDZLgqfudKsnyg@mail.gmail.com>
 <CAGsSOWX9YcuBpxQZ5kPm6zbMbM6iZqPK3bk=dgKyUZPjq++GXQ@mail.gmail.com> <kjlcqkfipct4d54hrtmwdsrifxvuq3qocv5bcmwsufrbxtvvq2@52grw5ijqx4k>
In-Reply-To: <kjlcqkfipct4d54hrtmwdsrifxvuq3qocv5bcmwsufrbxtvvq2@52grw5ijqx4k>
From: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Date: Fri, 10 May 2024 23:43:46 +0200
Message-ID: <CAGsSOWU=NopJmDK09vLFXa1Riq=8-Rn=U3ZsXqE-8vnL28nTkA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: jdi-fhd-r63452: move DCS off commands to disable
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 8:02=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, May 10, 2024 at 09:10:34AM +0200, Barnab=C3=A1s Cz=C3=A9m=C3=A1n =
wrote:
> > On Fri, May 10, 2024 at 8:46=E2=80=AFAM Barnab=C3=A1s Cz=C3=A9m=C3=A1n =
<trabarni@gmail.com> wrote:
> > >
> > > On Fri, May 10, 2024 at 2:56=E2=80=AFAM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > On Thu, May 09, 2024 at 08:14:07PM +0200, Barnab=C3=A1s Cz=C3=A9m=
=C3=A1n wrote:
> > > > > Move DCS off commands from .unprepare to .disable so that they
> > > > > actually reach the DSI host.
> > > > >
> > > > > Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com=
>
> > > > > ---
> > > > >  drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 12 ++++++++++--
> > > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > >
> > > > I don't think this is correct. If the driver sends enable commands =
in
> > > > prepare, it should be able to send commands during unprepare too.
> > > >
> > > It cannot send commands in unprepare, there are multiple panel driver=
s
> > > what do the same.
> > > Every panel drivers which have DCS commands to be sent in unprepare
> > > has similar error messages with mdp5/dpu.
> > >
> > > [   92.322564] panel-td4320-boeplus c994000.dsi.0: sending command
> > > 0x28 failed: -22
> > > [   92.322635] panel-td4320-boeplus c994000.dsi.0: Failed to
> > > un-initialize panel: -22
> > >
> > >
> > Here is the error messages, these are comes from unprepare by every pan=
el off:
> > [  121.295290] panel-jdi-fhd-r63452 994000.dsi.0: transmit data failed:=
 -22
> > [  121.295368] panel-jdi-fhd-r63452 994000.dsi.0: Failed to
> > un-initialize panel: -22
> > [  184.783019] panel-jdi-fhd-r63452 994000.dsi.0: transmit data failed:=
 -22
> > [  184.783066] panel-jdi-fhd-r63452 994000.dsi.0: Failed to
> > un-initialize panel: -22
> > with this patch these errors no more.
> > .prepare works because of this flag ctx->panel.prepare_prev_first =3D t=
rue;
>
> The flag should also invert the order of post_disable chain. It well
> might be that the drm/msm/dsi driver shuts down the DSI link too soon.
> Please consider fixing the MSM DSI driver instead.
>
Ok, thank you i look forward to it.
> --
> With best wishes
> Dmitry

