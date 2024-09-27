Return-Path: <linux-kernel+bounces-341455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B82D98805C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4C61F20F93
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1311E189524;
	Fri, 27 Sep 2024 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CUpgiLx0"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1118308A
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426137; cv=none; b=VhOnWx7N2XEtL1oThYfUsEMKungyMWZ0VM+A56WKsB/vi64lmWPWvXgHdjVYz52u9drkcIOKHnp+2FqAYJx6RVZhvRYiQ37FnXa9gYX06vxirimQBUW5PQ3oJ//l8HX/Zlpnbci30a68a7N7Et+CXET1JYtExvApO/JKHGEOYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426137; c=relaxed/simple;
	bh=8OjU2hUtFPO6kVJZ7bsfwgum5hpgvLcBpO7gOANOhcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mP9FRXqffEi9Py5IwhYPaRDPwm/M++gcb/O2y71lnHtTjIFhTFjm7WHh7dM46uxWsoHhSDfeXahGUBNUoP7BJjCfa2SIPi3C6tLzrO3ocoyE4tMYL17q3oNWNp509TV7KYZm/jbJo4vhGx27N0CPhD/zKHH+EcPC7GR2HRYpOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CUpgiLx0; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e22f10cc11so16484617b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 01:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727426134; x=1728030934; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5XUd7Nnduy5xO4AHIf3r18vL5fGi0trQPBiW3OSmV8o=;
        b=CUpgiLx0PSIe/QvMVMfsjRdsJIF+cRukUvX5/QIjVCVI7MnRWcjCwBSYN1WzSHWXPI
         XFpwFIF95+xmxS5Go/nVFAXsp1kMSEvm4bAbDSo7KZRzYDwbsN/Cs9WZjN6gM4YHSOME
         thAs1wCG/dCJ7mExHOGrMBJmuuToBXP4cSa9G5DvWIlNXJcdpqtVG8c2Os2IbbrCQOj1
         5milYMppr5N+7ETjlUhtqGp5vpxZ6fmnc5Lssjnp/cekPqurs9KkDz7MAWN2jfDaWflb
         AhUSzrr7QrUEEjK5HhdKOn6Pec18+kLsewX8VDql3FpMlCVGEwYHxDf+vUL9lGxDG2Mb
         AitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727426134; x=1728030934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XUd7Nnduy5xO4AHIf3r18vL5fGi0trQPBiW3OSmV8o=;
        b=CUgpgPkEMd9HDc8hCChCpeOoXPkHGbYdzkov4F3ucUT7HR6MtClt8IEzoTQVUrrish
         WtQyrbWYOwkc+xJYuI41qS7IBZpjHe0hX/0kZAWOvHR3EeD9gEWBADgxyjU2uAc8SzOt
         EdwA2IVyd2I9YO1D++kgvRkNbEW752cHXdGBDkR8NzefKpp24nkpwVxaXX0BePtLotNH
         UpHaw2XrX0gQrGglwXNw7zX4eVmg7L/Mp4keCjmBEL0mKQGid3iRsW71EeEx89yyxWYL
         1n8E2x6omKO8kQESjSemi2jlqIgj8eca9MknUxhUGk703dJgQWXvohVJ8x991wgkPO6E
         dtHA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Obb4uvhE8f2iTmEBA7duAN11eA9HjYpZ9xRni7qL24/GDkStHiSWwF3vFJ+hZCqzBUh9pQWPJplZqpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlYmlHgqpH/+tqF4gdTyky7C1ZV4FdL3HpQzZxEvLsMAMAW3p6
	P9tHxFeOGpfRQb1kYbWyIHEy5xKD/bIeoxdqWZwocpq5OHLP74euFyH8AQzmmHyast6rxhhnaGc
	rCbfDf8auK46IKK8+epw7tR8qZ/hmIMeusbdV/8BHrbGAY/ZpALjRHg==
X-Google-Smtp-Source: AGHT+IEzctUgceHZg4s1ya4eisdGWijfQ2geGrfzjwHBvsz5NThuPVpdViA25Blq+a4ULU8aoTtsMQvkxd9ludS0ckU=
X-Received: by 2002:a05:690c:660b:b0:6e2:1467:17c0 with SMTP id
 00721157ae682-6e24751a2d1mr19773607b3.8.1727426134592; Fri, 27 Sep 2024
 01:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a1ab663-d068-40fb-8c94-f0715403d276@ideasonboard.com>
 <34mewzvfyjsvyud3lzy6swxs7sr64xkgrbkxtvyw3czvoerct7@7guo32ehwa52>
 <5a540bdb-e3ca-494a-b68d-8f81f4d1cc1a@ideasonboard.com> <il3s26owmtyf3knniv7klkmw3uuz4dffrump7jo47dk6hxdsya@v5plmtjcbukf>
 <bed619c7-1a82-4328-825c-117c2ee3639d@ideasonboard.com>
In-Reply-To: <bed619c7-1a82-4328-825c-117c2ee3639d@ideasonboard.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 27 Sep 2024 10:35:25 +0200
Message-ID: <CAA8EJprDdst-mcwMsWs=0AHGCNa_5Ng90tubSJ7VAHamx2T93g@mail.gmail.com>
Subject: Re: fw_devlinks preventing a panel driver from probing
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux Kernel List <linux-kernel@vger.kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Devarsh Thakkar <devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 08:41, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> On 27/09/2024 02:26, Dmitry Baryshkov wrote:
> > On Thu, Sep 26, 2024 at 02:52:35PM GMT, Tomi Valkeinen wrote:
> >> Hi,
> >>
> >> On 21/09/2024 23:15, Dmitry Baryshkov wrote:
> >>> On Mon, Sep 16, 2024 at 02:51:57PM GMT, Tomi Valkeinen wrote:
> >>>> Hi,
> >>>>
> >>>> We have an issue where two devices have dependencies to each other,
> >>>> according to drivers/base/core.c's fw_devlinks, and this prevents them from
> >>>> probing. I've been adding debugging to the core.c, but so far I don't quite
> >>>> grasp the issue, so I thought to ask. Maybe someone can instantly say that
> >>>> this just won't work...
> >>>
> >>> Well, just 2c from my side. I consider that fw_devlink adds devlinks for
> >>> of-graph nodes to be a bug. It doesn't know about the actual direction
> >>> of dependencies between corresponding devices or about the actual
> >>> relationship between drivers. It results in a loop which is then broken
> >>> in some way. Sometimes this works. Sometimes it doesn't. Sometimes this
> >>> hides actual dependencies between devices. I tried reverting offending
> >>> parts of devlink, but this attempt failed.
> >>
> >> I was also wondering about this. The of-graphs are always two-way links, so
> >> the system must always mark them as a cycle. But perhaps there are other
> >> benefits in the devlinks than dependency handling?
> >>
> >>>> If I understand the fw_devlink code correctly, in a normal case the links
> >>>> formed with media graphs are marked as a cycle (FWLINK_FLAG_CYCLE), and then
> >>>> ignored as far as probing goes.
> >>>>
> >>>> What we see here is that when using a single-link OLDI panel, the panel
> >>>> driver's probe never gets called, as it depends on the OLDI, and the link
> >>>> between the panel and the OLDI is not a cycle.
> >>>
> >>> I think in your case you should be able to fix the issue by using the
> >>> FWNODE_FLAG_NOT_DEVICE, which is intented to be used in such cases. You
> >>
> >> How would I go using FWNODE_FLAG_NOT_DEVICE? Won't this only make a
> >> difference if the flag is there at early stage when the linux devices are
> >> being created? I think it's too late if I set the flag when the dss driver
> >> is being probed.
> >
> > I think you have the NOT_DEVICE case as the DSS device corresponds to
> > the parent of your OLDI nodes. There is no device which corresponds to
> > the oldi@0 / oldi@1 device nodes (which contain corresponding port
> > nodes).
>
> Do you mean that I should already see FWNODE_FLAG_NOT_DEVICE set in the
> fwnode?

No, I think you should set it for you DSS links. If I understand
correctly, this should prevent fwdevlink from waiting on the OLDI to
materialize as a device.
Note: my understanding is based on a quick roaming through the code
some time ago.

>
> If I print information about the relevant fwnodes (from dss up to the
> oldi endpoints) in the DSS driver's probe, I see that none have
> FWNODE_FLAG_NOT_DEVICE set, all have FWNODE_FLAG_LINKS_ADDED set, and
> only the main DSS node has the fwnode->dev set (to 30200000.dss).
>
>   Tomi
>
> >>
> >>> have a dependency on DT node which doesn't have backing device.
> >>
> >> Well, there is a backing device, the DSS. But if you mean that the system at
> >> the moment cannot figure out that there is a backing device, then true.
> >
>


-- 
With best wishes
Dmitry

