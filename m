Return-Path: <linux-kernel+bounces-336488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2F8983B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64341F22E17
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64A312E7E;
	Tue, 24 Sep 2024 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oIdSzo+L"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815C523DE
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727146790; cv=none; b=jzfPlZnb6qEJ9yclTQy2vxZJOYcudvG+ESw7Zz2k82otKA+OEo55982cAqckpvEVfphyRdKPweEoy7ud9SC5fKJeRBnZ6dFhzvXz9CToEzah6LCAefeFX0/khv+DPN5i/U7fAU5u66ervlzxoXqMlMbXFY3IODONfnVTWYHwWhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727146790; c=relaxed/simple;
	bh=Ba4A+TdFcbQwrcZ1Em2TFFt5fR3zoDFR7vF/Fk4Z0Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeq9D0kq9ZMqhrX4J+PeeYQ4a+ExtHfpMHDZwydJCt3HYZeM30LosUB4Kz79zwUgPPJWr87M3RUGHIiSeRhdl433eMtATKNrbVkTIMzs1mKhAOzxu3UM+wWe4YvDUO7mYWim07Z7aS6/6kWGQOE1ijKifOeNHBw3/dHNoUaylhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oIdSzo+L; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5e1ba0adcb0so2336741eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727146787; x=1727751587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A7oN5W7TNsx8rj73OuWfnvUP/XBNcMIaAb16FR0c0o=;
        b=oIdSzo+LmspjNhfZL4H9obwXggKUtKgXz8JJCwxshqu5p/tCqgsMPSlx3D+DYc+tEa
         2Nsp76YCqh9h07MFfTw9P1/r7DCzwX5M6dbnaBLuiIgSU1blSyOKWVE2wp871gDuyesj
         3SrvVsoUF1YneSJm7kWgjxM1gBiE0cVMPbuw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727146787; x=1727751587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2A7oN5W7TNsx8rj73OuWfnvUP/XBNcMIaAb16FR0c0o=;
        b=mz4qJLm4LK1PmT7SuLZIhDE4XF4TVycag4vPL5QW0QYfY51JEK6G/EWBctolK2PliQ
         VmHqjipVe8nrRKTg2SkAXY0Rx+wC5jRJPRCRPV5WcNAolgT2ZI02wYorkTBUc3r7s1/D
         RftNtErQTzdk4INbi4L+YW9Cxb83nw3MQ4CfKgwmuZvl7/EfYt85hKR8Sdu79X2ROtvP
         oG2DA4QluzfuEt4zHdqBiE+8TnT4wNVr0CmTKp4B/4Zblkty5jlfX8HuJI3oMFTWHMrP
         yRryEAfiAlP71YCfIi7YIjIUTE4FHOUQz6rmruA9ri8rDNFpxbHfbRklz2HSvp0OQ8mu
         5BTg==
X-Forwarded-Encrypted: i=1; AJvYcCWxSB7PatHfjeGsqlkm6r9TBN3hFt/eHjExR4TuXxArR3l6x1dlsNFzQX+8+PejRjSNGynpcdwv8/1cm9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmWfvw690WOCr2bFsDx3QQOjt3kq0ZfVPXj797cX6WvJr4P43z
	zY7jYqcBGC8ciAMKmWzPqRvP0Q+x6DMAmxPLLzM5p0KuRQc0bmrzXeoYTwdLdZFtSUYZ5c8aXxd
	p2DB2Piyw/8KEQKUXYAp/o5BwIzO4BJpp+TMx
X-Google-Smtp-Source: AGHT+IH1+SRKIPyBrUHidz4n4WMU3uFmkshuiWHBHVzYm97HXJx86PuKF5H9wpxkMmLpJwYwyoIA2gmVbOkzzmyWgkM=
X-Received: by 2002:a05:6830:6588:b0:710:ec5f:45b9 with SMTP id
 46e09a7af769-713923caea2mr10257229a34.13.1727146787532; Mon, 23 Sep 2024
 19:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923094826.13471-1-Hermes.Wu@ite.com.tw> <20240923094826.13471-3-Hermes.Wu@ite.com.tw>
 <4viir5prnuvpp76npblwmdrwlttm5daumvdnocipdsn6geyxvf@2yfcytjb3ono>
 <a0a8f862018b4c9aa689672551e7a492@ite.com.tw> <mkx63gnb2fobxxc5jc2f326d2oviix7dahyoh4sfeuiyypucln@hnklvrtv4q2u>
 <169c171660ac4897903aef5befc780db@ite.com.tw>
In-Reply-To: <169c171660ac4897903aef5befc780db@ite.com.tw>
From: Pin-yen Lin <treapking@chromium.org>
Date: Tue, 24 Sep 2024 10:59:36 +0800
Message-ID: <CAEXTbpeSvpoHpo95wNznGYmJLaG9hTAJ5hVb1URRkkUddsOuAw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/bridge: it6505: HDCP CTS fail on repeater items
To: Hermes.Wu@ite.com.tw
Cc: dmitry.baryshkov@linaro.org, Kenneth.Hung@ite.com.tw, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 10:57=E2=80=AFAM <Hermes.Wu@ite.com.tw> wrote:
>
> >On Mon, Sep 23, 2024 at 10:45:49AM GMT, Hermes.Wu@ite.com.tw wrote:
> >> >On Mon, Sep 23, 2024 at 05:48:28PM GMT, Hermes Wu wrote:
> >> >> From: Hermes Wu <Hermes.wu@ite.com.tw>
> >> >>
> >> >> Changes in v3:
> >> >>  -add detials about fail item and changes.
> >> >>
> >> >>
> >> >> Fix HDCP CTS fail items on UNIGRAF DRP-100
> >> >>
> >> >> DUT must Support 127 devices.
> >> >> DUT must check BSTATUS when receive CP_IRQ.
> >> >> DUT must enable encryption when R0' is ready.
> >> >> DUT must retry V' check 3 times.
> >> >> it6505 must read DRP-100 KSV FIFO by FIFO mode.
> >> >> it6505 should restart HDCP within 5s if KSV not ready.
> >> >
> >> >Still not readable.
> >> >
> >> >English text, please. Split the patch to fix one issue at a time.
> >> >Describe the _reason_ for the change. Annotate fixes with Fixes tags.
> >> >
> >>
> >> with fixes tag include drm/bridge like this ?  =3D> "Fixes: drm/bridge=
: it6505: HDCP CTS fail 1B-xx"
> >
> >No. Please read the document that I have been pointing you to. It descri=
bes all the tags and procedures.
> >
> >>
> >> About the reason about bug fixes.
> >>
> >> for example, the 1B-01 device count.
> >> will this readable?
> >>
> >> " When connect to HDCP repeater, it6505 must support 127 downstream de=
vices. "
> >>
> >> And this will be only one change in a patch?
> >
> >Let me repeat the phrase that you have quoted few lines above. "Split th=
e patch to fix one issue at a time." So, no, this will not be the only chan=
ge in the patch.
> >
>
> The HDCP CTS include serval items, I should split each failure item fixes=
 into different patch?

Yes, please. You can mention in the cover letter that those patches
are fixing HDCP CTS failures, but please fix one issue at a time and
explain what it fixes in the commit message.
>
>
> >>
> >> >>
> >> >> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> >> >> ---
> >> >>  drivers/gpu/drm/bridge/ite-it6505.c | 112
> >> >> ++++++++++++++++++----------
> >> >>  1 file changed, 74 insertions(+), 38 deletions(-)
> >> >
> >> >--
> >> >With best wishes
> >> >Dmitry
> >>
> >> BR,
> >> Hermes
> >
> >--
> >With best wishes
> >Dmitry

Regards,
Pin-yen

