Return-Path: <linux-kernel+bounces-335565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE5F97E782
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F801F21CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B783193422;
	Mon, 23 Sep 2024 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W8tX+e8T"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4625A17BA9
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080090; cv=none; b=Nw3a2Q0qY3Jw18P6/liN2QFAXFxjHyLuXqy5jy5bAz6bPvyJZofhi50rwnGEWb7sqRI34zFEpndXdZTfmO5hIcdaec9cBb3njKBjKoy43SR3+Fv08grh9W/3oQ0n7Cunmgor4RB7pJXYyJiOVHo2/RpankT9nmEVj6eo2wjJJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080090; c=relaxed/simple;
	bh=oRQJzc14WcNUsOdKCyr5yCj6GtBFRvGcB6pvf2l/BBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a97FGhkviORD+E401cxE3QIxg2qLXFtGTD8dLj+l/omkP9rgmn72wtfqcQd1ISswiI4EE4taZPs7+npFOfmlIxHWV/5Dna3PvO6Tb3fJgmmsoPaDuDKc4YUQSK7KJF+mlbdPNiVbwNWQy9MmTdHEclD03wrjlUyz2ThAkSzKC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W8tX+e8T; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-713892fed01so1499574a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727080087; x=1727684887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRQJzc14WcNUsOdKCyr5yCj6GtBFRvGcB6pvf2l/BBo=;
        b=W8tX+e8TzxAnQBhpugiXYdqzubq3fzkSFYG6rC0PTbGcCSeObkGw3YELdVKcv0KioK
         gelhFrAqCyFbW9coa5cfjDaHpRvoGNLuX9d4ojxcZe+Xr6qk2JRhs9BTN/hMR7Xe6KG6
         DrVqiPIus38O2CZJprbWVVVp2kW3UHbs97OHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727080087; x=1727684887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRQJzc14WcNUsOdKCyr5yCj6GtBFRvGcB6pvf2l/BBo=;
        b=Bm5YnNEJjnd8BqajZLjcQA+5MGwvxk/8FS3rieQaAY34ww1obzhsixPJT4Od7tRPZ9
         FLNG/n/wWN7Eov/kLIltwi0FmzGhcbHnyBDYF6Uq4o84zyU3DBNAnqJqHYCHABOguxJJ
         8t1n4pwFvkCIP27DTxCtk0BoSG9YnvJKVp18NmbNe51i66rEIb70ziB+5gNEpSi1iPta
         rHvEnAP7RAtewNEe5ZWhaTsMfpJcVjp3SlL6NbxWw3nfdozG5YFO6andGr0+cdEQiVB2
         MxeJqRxA3qiyeFfhjSkDg8XnZFA5LP1X3Zwnd9bkdQh+BaXplkv01kMxcEgDP2Y2v1F8
         SjKA==
X-Forwarded-Encrypted: i=1; AJvYcCXRYAKu1xCYaX/685ke/wZMHS4cCK+ErYaKR0s9cVZlRrnbR4O33X+KVWoSd1nHixfnfdQQ6ihDJXz2AVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjR9AwmfMv6+C3fens0tWrK/Ww3ifANpgz1xKppHvO4tRDnrHe
	bZtjLhsbZXNaMiNaGW2OIybq4eCFYn9Swy8QujOTTiKh/GFr7Ayu0tJjkK1twQomWMkwuIkNku0
	hIXt4Cv4IzSWAG6PpeBNSopyeBTI6W4OKF9MB
X-Google-Smtp-Source: AGHT+IEotB6vqJGozKIDCyFeXIu/sIjXLkkvpvrjnD8lnxdaDPcFwtLXyQUotn5H5ZJ+w/od9z+EVXTAq5uJum5qTLc=
X-Received: by 2002:a05:6830:6312:b0:710:ec31:391a with SMTP id
 46e09a7af769-713923e2176mr7165295a34.15.1727080087167; Mon, 23 Sep 2024
 01:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919025551.254-1-Hermes.Wu@ite.com.tw> <CAEXTbpc7N2v4LwoZ4wpHXi7ogyqGwYC3Gpt5sqfxtOpYrngPLg@mail.gmail.com>
 <nczuje3ur7sf7uqkygtziwnz5p6b4b7bf5on5crljr2ijmblrv@ym3fkvqxbjq5>
 <467ea5d3380843a1ad1f2f2429bb2833@ite.com.tw> <kek5orlxcrejicq55mczj6gmjgq2pgynzxk2qup65iyuedcwdy@maird5uixbys>
 <97861ebe0244454cb5e76d9c26cb6d33@ite.com.tw>
In-Reply-To: <97861ebe0244454cb5e76d9c26cb6d33@ite.com.tw>
From: Pin-yen Lin <treapking@chromium.org>
Date: Mon, 23 Sep 2024 16:27:56 +0800
Message-ID: <CAEXTbpfy+F1RpKvc4zbVhMGFm_pu-tmTdiWmwk+NWfFEiYSTxw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/bridge: it6505: HDCP CTS fail on repeater items
To: Hermes.Wu@ite.com.tw
Cc: dmitry.baryshkov@linaro.org, a.hajda@samsung.com, narmstrong@baylibre.com, 
	robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Kenneth.Hung@ite.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 3:25=E2=80=AFPM <Hermes.Wu@ite.com.tw> wrote:
>
> Hi
>
> BR,
> Hermes
>
>
> >-----Original Message-----
> >From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >Sent: Monday, September 23, 2024 2:16 PM
> >To: Hermes Wu (=E5=90=B3=E4=BD=B3=E5=AE=8F) <Hermes.Wu@ite.com.tw>
> >Cc: treapking@chromium.org; a.hajda@samsung.com; narmstrong@baylibre.com=
; robert.foss@linaro.org; Laurent.pinchart@ideasonboard.com; jonas@kwiboo.s=
e; jernej.>skrabec@gmail.com; airlied@gmail.com; daniel@ffwll.ch; dri-devel=
@lists.freedesktop.org; linux-kernel@vger.kernel.org; Kenneth Hung (=E6=B4=
=AA=E5=AE=B6=E5=80=AB) <Kenneth.Hung@ite.com.tw>
> >Subject: Re: [PATCH v1] drm/bridge: it6505: HDCP CTS fail on repeater it=
ems
> >
> >Hi,
> >
> >On Mon, Sep 23, 2024 at 05:21:41AM GMT, Hermes.Wu@ite.com.tw wrote:
> >> Hi
> >>
> >> Sorry for the confusion caused
> >
> >Please don't top post. Answers should come below the original quoted
> >text, not above it. Otherwise reading the email becomes really hard.
> >
> >>
> >> Last patches did not switch to drm-misc-nest. And I need re-create pat=
ches.
> >>
> >> The HDCP patches is now on tow threads.(This one and the one include M=
CCS patches with cover letter)
> >
> >Just make sure that when you send the next iteration of the HDCP + MCSS
> >patches you provide the history of the changes in the changelog (either
> >in the cover letter or in the individual patches). Also please don't
> >send several patches using the same vN. I'd point out the 'b4' tool, it
> >can automate a lot of such topics for you.
> >
> I will check using of B4 tools
>
> >> Should I keep on this thread or restart a new thread?
> >
> >Please always send new revisions as a new thread. Otherwise your patches
> >can easily get lost.
> >
> >I suppose that [1] is the latest revision. Please review and implement
> >the feedback that was provided to all iterations of your pachset, then
> >send v3 as a separate new thread.
> >
> >[1] https://lore.kernel.org/dri-devel/vxs3eklfifsnaq5rn6kppegfv3plsviqaq=
5nvlzo3fgazwj6y7@od4atbvf5ep3/T/#u
> >
>
> A suggestion that a aux path need separate to different path, this change=
 will before HDCP
I assume you mean something needs to be a separate patch...? I don't
really get this sentence.
> Won't it become more complicate?
>
> it goes like this?
>
> Patch V1 aux
> Patch V3 HDCP
> Patch V3 MCCS
The whole series should share the same version number, so you can send
out a v3 series that contains these three patches. Just mark the new
aux patch as "new in v3" in your change log.

Regards,
Pin-yen
>
>
> >>
> >>
> >> BR,
> >> Hermes
> >> -----Original Message-----
> >> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> Sent: Friday, September 20, 2024 11:50 PM
> >> To: Pin-yen Lin <treapking@chromium.org>
> >> Cc: Hermes Wu (=E5=90=B3=E4=BD=B3=E5=AE=8F) <Hermes.Wu@ite.com.tw>; An=
drzej Hajda <a.hajda@samsung.com>; Neil Armstrong <narmstrong@baylibre.com>=
; Robert Foss <robert.foss@linaro.org>; >Laurent Pinchart <Laurent.pinchart=
@ideasonboard.com>; Jonas Karlman <jonas@kwiboo.se>; Jernej Skrabec <jernej=
.skrabec@gmail.com>; David Airlie <airlied@gmail.com>; >Daniel Vetter <dani=
el@ffwll.ch>; open list:DRM DRIVERS <dri-devel@lists.freedesktop.org>; open=
 list <linux-kernel@vger.kernel.org>; Kenneth Hung (=E6=B4=AA=E5=AE=B6=E5=
=80=AB) <Kenneth.>Hung@ite.com.tw>
> >> Subject: Re: [PATCH v1] drm/bridge: it6505: HDCP CTS fail on repeater =
items
> >>
> >> On Fri, Sep 20, 2024 at 01:27:54PM GMT, Pin-yen Lin wrote:
> >> > On Thu, Sep 19, 2024 at 10:58=E2=80=AFAM <Hermes.Wu@ite.com.tw> wrot=
e:
> >> > >
> >> > > From: Hermes Wu <Hermes.Wu@ite.com.tw>
> >> > >
> >> > > Fix HDCP CTS items on UNIGRAF DPR-100.
> >> > >
> >> > > Signed-off-by: Hermes Wu <Hermes.Wu@ite.com.tw>
> >> >
> >> > Reviewed-by: Pin-yen Lin <treapking@chromium.org>
> >>
> >> For the sake of somebody applying the patch because it was R-B'ed
> >>
> >> Nacked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>
> >> The commit message doesn't describe what is being done and why, it
> >> doesn't have Fixes tags, etc.
> >>
> >> Hermes, I'm not sure what's happening on your side. I have seen severa=
l
> >> revisions of this patch with minimal modifications (and being a part o=
f
> >> different series). Some of them were marked as v1 (although you've sen=
t
> >> different patches as v1), other had v2 (but no changelog, etc). Please
> >> adhere to the described process of sending patches.
> >>
> >> --
> >> With best wishes
> >> Dmitry
>
> --
> With best wishes
> Dmitry
>
> BR,
> Hermes
>
>
> -----Original Message-----
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Sent: Monday, September 23, 2024 2:16 PM
> To: Hermes Wu (=E5=90=B3=E4=BD=B3=E5=AE=8F) <Hermes.Wu@ite.com.tw>
> Cc: treapking@chromium.org; a.hajda@samsung.com; narmstrong@baylibre.com;=
 robert.foss@linaro.org; Laurent.pinchart@ideasonboard.com; jonas@kwiboo.se=
; jernej.skrabec@gmail.com; airlied@gmail.com; daniel@ffwll.ch; dri-devel@l=
ists.freedesktop.org; linux-kernel@vger.kernel.org; Kenneth Hung (=E6=B4=AA=
=E5=AE=B6=E5=80=AB) <Kenneth.Hung@ite.com.tw>
> Subject: Re: [PATCH v1] drm/bridge: it6505: HDCP CTS fail on repeater ite=
ms
>
> Hi,
>
> On Mon, Sep 23, 2024 at 05:21:41AM GMT, Hermes.Wu@ite.com.tw wrote:
> > Hi
> >
> > Sorry for the confusion caused
>
> Please don't top post. Answers should come below the original quoted text=
, not above it. Otherwise reading the email becomes really hard.
>
> >
> > Last patches did not switch to drm-misc-nest. And I need re-create patc=
hes.
> >
> > The HDCP patches is now on tow threads.(This one and the one include
> > MCCS patches with cover letter)
>
> Just make sure that when you send the next iteration of the HDCP + MCSS p=
atches you provide the history of the changes in the changelog (either in t=
he cover letter or in the individual patches). Also please don't send sever=
al patches using the same vN. I'd point out the 'b4' tool, it can automate =
a lot of such topics for you.
>
> > Should I keep on this thread or restart a new thread?
>
> Please always send new revisions as a new thread. Otherwise your patches =
can easily get lost.
>
> I suppose that [1] is the latest revision. Please review and implement th=
e feedback that was provided to all iterations of your pachset, then send v=
3 as a separate new thread.
>
> [1] https://lore.kernel.org/dri-devel/vxs3eklfifsnaq5rn6kppegfv3plsviqaq5=
nvlzo3fgazwj6y7@od4atbvf5ep3/T/#u
>
> >
> >
> > BR,
> > Hermes
> > -----Original Message-----
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Sent: Friday, September 20, 2024 11:50 PM
> > To: Pin-yen Lin <treapking@chromium.org>
> > Cc: Hermes Wu (=E5=90=B3=E4=BD=B3=E5=AE=8F) <Hermes.Wu@ite.com.tw>; And=
rzej Hajda
> > <a.hajda@samsung.com>; Neil Armstrong <narmstrong@baylibre.com>;
> > Robert Foss <robert.foss@linaro.org>; Laurent Pinchart
> > <Laurent.pinchart@ideasonboard.com>; Jonas Karlman <jonas@kwiboo.se>;
> > Jernej Skrabec <jernej.skrabec@gmail.com>; David Airlie
> > <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; open list:DRM
> > DRIVERS <dri-devel@lists.freedesktop.org>; open list
> > <linux-kernel@vger.kernel.org>; Kenneth Hung (=E6=B4=AA=E5=AE=B6=E5=80=
=AB)
> > <Kenneth.Hung@ite.com.tw>
> > Subject: Re: [PATCH v1] drm/bridge: it6505: HDCP CTS fail on repeater
> > items
> >
> > On Fri, Sep 20, 2024 at 01:27:54PM GMT, Pin-yen Lin wrote:
> > > On Thu, Sep 19, 2024 at 10:58=E2=80=AFAM <Hermes.Wu@ite.com.tw> wrote=
:
> > > >
> > > > From: Hermes Wu <Hermes.Wu@ite.com.tw>
> > > >
> > > > Fix HDCP CTS items on UNIGRAF DPR-100.
> > > >
> > > > Signed-off-by: Hermes Wu <Hermes.Wu@ite.com.tw>
> > >
> > > Reviewed-by: Pin-yen Lin <treapking@chromium.org>
> >
> > For the sake of somebody applying the patch because it was R-B'ed
> >
> > Nacked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > The commit message doesn't describe what is being done and why, it
> > doesn't have Fixes tags, etc.
> >
> > Hermes, I'm not sure what's happening on your side. I have seen
> > several revisions of this patch with minimal modifications (and being
> > a part of different series). Some of them were marked as v1 (although
> > you've sent different patches as v1), other had v2 (but no changelog,
> > etc). Please adhere to the described process of sending patches.
> >
> > --
> > With best wishes
> > Dmitry
>
> --
> With best wishes
> Dmitry

