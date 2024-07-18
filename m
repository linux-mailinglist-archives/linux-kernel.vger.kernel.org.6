Return-Path: <linux-kernel+bounces-256831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289F49370FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA891C21AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD431465A3;
	Thu, 18 Jul 2024 23:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="huLofk/B"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F02146587
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721344186; cv=none; b=TLllOvMvWNiOBWCHyR8gH/g61kQmnC7F2LUtCSkNkR0tnN5o6KCqar72Zgxd9TRrbWvh25tOnTls8ij8EdncDaaPlVwvg/3Xf27wmDvFYZkLEg8pdGa2OOWNTaAgQwusqn7Gn0nLpPjGt89TDpm4SIwdBtpO57bJGU7u6gncYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721344186; c=relaxed/simple;
	bh=a2MiU9q1dpoV76yfckJyiSZ5U4LdU8MkAa9iwJ7ocM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dC+rxwtpTxIDE7lkt+qgPLeuiP5KcCtiCFItSMUTs5MhMRZ5Qc/ThKqVy7cjDw7PGDrk+gotAgQtQz3sPrIRpBn3Kp/aVPMIlq363dkzYJzhFymd6w04USbg6DWWAoKFG77kQ0kMyWnna0i37+S1Ey3LrxIz0C4TF15NiLtSyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=huLofk/B; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-447e57103d5so4313951cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721344181; x=1721948981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWUpRwE/EDS0n+s4NT6R/Wf+x8/oxyYVaNKMw8i5CCg=;
        b=huLofk/BwsdzJxyWcsgxE+4M8Ux2AhLcvusl5Ybj3wkZEbvbh5ubRJ+6Q2x9dnAuXR
         fWpJbIpFKpNjAGcJEGiHvcxr6jikI0Dl4sDO3c30xL4DLjBrMragMohu4IBuddHEsNQ0
         Xo0yWnEEcHq7zrK5ZQimrFNBn9yQV2m0EnWdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721344181; x=1721948981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWUpRwE/EDS0n+s4NT6R/Wf+x8/oxyYVaNKMw8i5CCg=;
        b=F0OixIodY+9kGZt5w1Yu4v0LvjxoXTJfEsvEIFtEqkJyud4SlRfHoCirS62HLZ/0sY
         EWbOY/uikGILucwdtxCvMsHT9ECzczsmqBPZ7iPjpVti61THTdLX66a8j0TGHG64hK/y
         wIVn9qoszY3zE8zk/1wUl80IVbtMf7sXcmnMgd6w4NI6rQu4Sa3dfPZh2g1LbJxEXyri
         7vBa6Xy3nzZSqXC8HuDH7wfufW9jYD/eVao/9Gn2YsBsZtNtaoBa1R3W8ABp/HO4EBRn
         uokSxXUOYuTHseXlchIct/Hzl9WKqmuYaL2lIrLJK+x/mb22qBDf7bFjPJUyvqQJGkwd
         ehgA==
X-Forwarded-Encrypted: i=1; AJvYcCWIywLL14g9XqemfiW6pOUftmrtYLlBF8MQv1PaeJbpZGpOWkY1fOWxHCon8l5tZqoYc7zoTp2TYHOLY/kcoS8OIKoYiKpRIBarjfNM
X-Gm-Message-State: AOJu0Yz34Q82kajFvYKs0c4RWv9AsjPNYyUXgh5Gp/XlrGL+WfuROwBt
	vK/wGUz3FyK+1ugVAGosuriDVar+zm0420tBV8BdK4BaeY9LdExShsj5oVxSTkf+EQlie/oBtX0
	=
X-Google-Smtp-Source: AGHT+IFspPA/wRT6grFTx1QhXyfDgQcreCkHNSPq4rlvziIn+SlNkF+x7gSQtLf0FcwHfOAWVs0wTA==
X-Received: by 2002:a05:622a:1206:b0:446:4199:eab9 with SMTP id d75a77b69052e-44f969b7d77mr32711131cf.33.1721344180905;
        Thu, 18 Jul 2024 16:09:40 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cbed80bsm879381cf.12.2024.07.18.16.09.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 16:09:39 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-447df43324fso65781cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:09:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0ZIwuz36vSZ3DyEZFMTN4QppfzfVuFxiVJ9llGC8X0nGUpS0Ohjj30rt2xkac6hhp2u1TSvMDWaBeUUh2KQuUTxbfoa+LoI/DPx2Q
X-Received: by 2002:a05:622a:5509:b0:447:e8a5:fb27 with SMTP id
 d75a77b69052e-44f9c86fd18mr443831cf.25.1721344179138; Thu, 18 Jul 2024
 16:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718184434.6307-1-robdclark@gmail.com> <fnoc5jhpu5gwkfufm4cyyn4cjhh6dtw2if3jukk7t3tyvdwesv@pmr4j3vfgpjt>
In-Reply-To: <fnoc5jhpu5gwkfufm4cyyn4cjhh6dtw2if3jukk7t3tyvdwesv@pmr4j3vfgpjt>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 18 Jul 2024 16:09:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VURWwyLB-VZEpB3JNt-ODyxWtXZnV33GA7JkP5AGgN-A@mail.gmail.com>
Message-ID: <CAD=FV=VURWwyLB-VZEpB3JNt-ODyxWtXZnV33GA7JkP5AGgN-A@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: display: panel: samsung,atna45dc02:
 Document ATNA45DC02
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Rob Clark <robdclark@chromium.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 18, 2024 at 2:36=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, Jul 18, 2024 at 11:44:32AM GMT, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The Samsung ATNA45DC02 panel is an AMOLED eDP panel, similar to the
> > existing ATNA45AF01 and ATNA33XC20 panel but with a higher resolution.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml   | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/samsung,at=
na33xc20.yaml b/Documentation/devicetree/bindings/display/panel/samsung,atn=
a33xc20.yaml
> > index d668e8d0d296..284a4ee79bbf 100644
> > --- a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc2=
0.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc2=
0.yaml
> > @@ -19,6 +19,8 @@ properties:
> >        - samsung,atna33xc20
> >        # Samsung 14.5" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
> >        - samsung,atna45af01
> > +      # Samsung 14.5" 3K (2944x1840 pixels) eDP AMOLED panel
> > +      - samsung,atna45dc02

Please follow what we decided in Stephan Gerhold's case and use a
fallback compatible. In other words: your patch seems to be based on
his v1 and not his v2.

> This makes me wonder if we should define a cover compatible like
> samsung,amoled-edp-panel.

I will bow to the wisdom of the DT folks, but my understanding is that
we shouldn't do that. The fallback compatible can just be the
compatible of the first panel that we supported that used the same
interface.

-Doug

