Return-Path: <linux-kernel+bounces-274101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A961F947367
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 04:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC5E1F212FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 02:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D89E2BCF5;
	Mon,  5 Aug 2024 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NnMjyls8"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230E17C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 02:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722825530; cv=none; b=cMBjstbk7bj63GPQmKl0gjIlcYBbv1BHfqiF4m1htA16mHn1p+hOBeFVCQz+7/7mXaxEn4k/otRgRBlLmfD5nEa91mV6dC8837oeDFFgO7kJKUk7UXbLJWL0BHfczotfxq5ZnTT/qR0T/qeVHDSpt6T12/2sARtfkrEsffCJVoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722825530; c=relaxed/simple;
	bh=lQMQ91IJU48AgSZ8BtTv6mms8dBnhGSEtNmP8mi76vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLEgdZ0b81QUTjmWjbB/FJmqCBI2unAqSIt7EOsizM7zAPxJTY5bVZHkQtUmAvuGzTZh1PxDUsSJ2ClGKcUhbxv/HTvNbHykg6UjK+MfA9ORgkhbVyqLPUJV8z9TEJud21s7JzV0qzOxOLzAnN66wpx9Pr53gNwzcM9bUBpy7NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NnMjyls8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso13265622a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 19:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722825527; x=1723430327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8vWHyjZtR29d9CpbPSiDhP2YMe9PC/XfNzJS8EFIt4=;
        b=NnMjyls8sfcYJuFIFCMl5h0uCtFVZWJV3QqhP/yCnDW5nCbXdEI5QykesH/qlaMu16
         CHMqIWb0HxYsOL6Od+eEQlRi/AE0/R23m4hPknXm36eH5Wc/9FNGij8JggeRKAXhyoD/
         C6cb/udpGHOt68MHVxQhj88UnWgzsMT1ia3wN5gXsKjf9zHVl2X7c/Hpti9NgYPO+8mF
         W+fMb+BTb48pOd4OBEQj5Xp0CSgoQYvqp1D14uyNCH/zvbMsYMgS6FO/ZHICVdNcTkJe
         hYq409ii07/fvencbjan9SiTyuS9CK7JIeZZqO3bK2VBUXUYAQdm6FOfHLms2DdKEo+f
         Da8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722825527; x=1723430327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8vWHyjZtR29d9CpbPSiDhP2YMe9PC/XfNzJS8EFIt4=;
        b=wTXOXSNEd780PiGfcmbRF2Qo9jWy9JqRvUNaHGn52A0VEndDLY31qBOjsCpgJTobFr
         MNSK2L+IcZp+yl7z1eoX6UOBmDcTrIyQFKERs5J76Uv7cVcZOMfFQ06eO6/Apna8eh1M
         ycv755T/jBcAodVp0LK+WGr9nITmg4TaoTTvmml+1MA2hnZVzxgL04cN0JbuwKbxVnd+
         Pn/oJvO3NG5CgkgclKJhdU++T2YGHR0KQs/aAhupB7QOUQxIsfkvLuyEaBwM1H1Ak9eX
         q76ps6zb0903QoHVUH8We46oHeYuACND4n2BCRMweLS/TajaznE+BRvMfucu2O7Z2Y9o
         3qsw==
X-Forwarded-Encrypted: i=1; AJvYcCVfUZW0O0vgNtujqqjB9CrKYGfGUS2FugOvFhOLlKTNkdCnSkEvlneLdY1v23r1HxE6fUPHUtQ5NoP7bvRVDK4TEflkc3JtWpH2R7fN
X-Gm-Message-State: AOJu0YwP9Ib9CUEP0gmIV9oYbVUJRH4YDmBoEcLf3hykxuqC/bincsiW
	SIUJBCT5Cvt1Pre7f2+JVveFXzOuTF4ziegKxgsuBKnu1gZtanjWeUcmZMTTmB1kW93Fd++U76r
	OAHmaPMyR1PD9XE6fhM7ufca10d5NNIl2LAM/LA==
X-Google-Smtp-Source: AGHT+IF1XZEUzGVo9Lh0nCgnHUnOoZw9jPxqVyDP7B7VGnZfXCG88TKyRuDM5fgTzawr6UswyF/G5ja6h2jVd1fLu5U=
X-Received: by 2002:a05:6402:2032:b0:5a3:a4d7:caf5 with SMTP id
 4fb4d7f45d1cf-5b7f5dc13cemr6532306a12.36.1722825527304; Sun, 04 Aug 2024
 19:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725083245.12253-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240725083245.12253-2-lvzhaoxiong@huaqin.corp-partner.google.com>
 <gq5fcttutomphgfrwrtloqzczia3uc5qpont3lrowocan2xjc5@ubfabhsh3mfl>
 <CA+6=WdQuFYbADjG0i_zWMGYmw95H1U_McqCw4CLW0+Gate50YA@mail.gmail.com> <CAA8EJppoj1Y2675UOp=JH=-HLdYuuzfr2Sxy1zzkvLosmrRQNw@mail.gmail.com>
In-Reply-To: <CAA8EJppoj1Y2675UOp=JH=-HLdYuuzfr2Sxy1zzkvLosmrRQNw@mail.gmail.com>
From: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Date: Mon, 5 Aug 2024 10:38:36 +0800
Message-ID: <CA+6=WdQ6q=Zmji8KxCPYK17pFY4UAUBOykd5Tx4N_RZ1MfgOdg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/panel: jd9365da: Move the sending location of
 the 11/29 command
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	dianders@chromium.org, hsinyi@google.com, airlied@gmail.com, daniel@ffwll.ch, 
	jagan@edgeble.ai, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all

Do you have any other suggestions for this patch?
Looking forward to your reply, thank you

BR

On Tue, Jul 30, 2024 at 4:09=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, 29 Jul 2024 at 06:10, zhaoxiong lv
> <lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
> >
> > On Sun, Jul 28, 2024 at 12:59=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Thu, Jul 25, 2024 at 04:32:44PM GMT, Zhaoxiong Lv wrote:
> > > > Move the 11/29 command from enable() to init() function
> > > >
> > > > As mentioned in the patch:
> > > > https://lore.kernel.org/all/20240624141926.5250-2-lvzhaoxiong@huaqi=
n.corp-partner.google.com/
> > > >
> > > > Our DSI host has different modes in prepare() and enable()
> > > > functions. prepare() is in LP mode and enable() is in HS mode.
> > > > Since the 11/29 command must also be sent in LP mode,
> > > > so we also move 11/29 command to the init() function.
> > > >
> > > > After moving the 11/29 command to the init() function,
> > > > we no longer need additional delay judgment, so we delete
> > > > variables "exit_sleep_to_display_on_delay_ms" and
> > > > "display_on_delay_ms".
> > >
> > > Won't this result in a garbage being displayed on the panel during
> > > startup?
> >
> > Hi Dmitry
> >
> > We just moved "Exit sleep mode" and "set display on" from the enable()
> > function to the init() function and did not make any other changes.
> > It seems that many drivers also put the "init code" and "Exit sleep
> > mode" in one function.
>
> You have moved the functions that actually enable the display out. And
> by the definition it's expected that there is no video stream during
> pre_enable(), it gets turned on afterwards. That's why I asked if
> there is any kind of garbage or not.
>
> > In addition, we briefly tested the kingdisplay_kd101ne3 panel and
> > melfas_lmfbx101117480 panel, and it seems that there is no garbage on
> > the panel.
>
> Ack.
>
> >
> > BR
> > >
> > > >
> > > > Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google=
.com>
> > > > ---
> > > >  .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 59 ++++++++++-----=
----
> > > >  1 file changed, 32 insertions(+), 27 deletions(-)
> > >
>
>
>
> --
> With best wishes
> Dmitry

