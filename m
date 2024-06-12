Return-Path: <linux-kernel+bounces-210960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49F8904B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5041F23259
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4910913CF84;
	Wed, 12 Jun 2024 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rx1LmvgW"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203A512D1FE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718172527; cv=none; b=fezD+JzL22IrVi5zWfedcybfeU7E4i1H32qGLVWEiv2OMk7UrIxiHaLlFzpZYjbB4I79oKZiM+AQiu2OV25cpBGMO25FhEkm/jUWxIuuC7Mj6UAlQ1nq8rPDqedhc5yedu/xwdgu6mRbUo7K5x+LZszueGBkTX2CWe19/GjvmT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718172527; c=relaxed/simple;
	bh=gyE0yRf++M8xpQPQaXpdKeQW4X1m/NGIHRme4AlmbpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjviRTjH+qSwLiPfdSnhR/u+ncXgo/JDr9GKNGMQQV9OYcLY8+NvUSfCxgWhRY28tIOv9TiVrBkm2vDVe+KHJ0tin6jAjRPfvUeqJ5pms/eJMaNgIMDRWrpBMDMfBl7NsN5SANMy2COW1mJ3G6bDoVDKN+XcWrZcoegD/U2ZarA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rx1LmvgW; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b0783b6dd5so14582806d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 23:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718172525; x=1718777325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyE0yRf++M8xpQPQaXpdKeQW4X1m/NGIHRme4AlmbpE=;
        b=rx1LmvgWSvAw9PyqH6LoZdpahIT1/5/r9JoSxVV3Grc2PTP/rJj5TJpxWAhzYnzqF2
         4VUQ5QaALU4I+bspgBVQXK7HIG6q1PX381TFIO8twvgZP9jXmVcBB/9IxmdqIxeraPHb
         cOAejezmf1U+sRqLYGuOR329pvCVWbb9kttppboKNrGrOoNuyk5hPQ6WV9o+MOpUBB+c
         UVBTpo7gV0pOL2+wAvFWA9YbXWG3FUaYJ76dU/wTLZXJ44o32bTZctAz7PUKjbls5Zbo
         hXq51aqU0XumsXnAoxj2O/lP7L4w2UeftOpALCAGHuys8vstsT5Ni1ThbFxxJyd1TfCF
         KT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718172525; x=1718777325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyE0yRf++M8xpQPQaXpdKeQW4X1m/NGIHRme4AlmbpE=;
        b=r1S+9YPqCOeTLMIIi2kOOnk2vMNS6hJx35bRCPgrEVQ9stFySBc6Qa74fyHO9Jo2hu
         HcXEa6D3cIo61To8aghYTq0Ff3PNGLDAGZHSFZ68rbWhLLve+yyByiSwvv9uJxyTVAt2
         IXR0YDJ4bVZ5mxhMWaSRiviYa+YmiyzLnZmVcuw1vLjXIPf6Z0rLn7g2fOFRCgScE8Ub
         AWQxoJK8O+5fHh7i5FpxFjzLNEEoDwEJATkGzL/v0OwbS8hN4SIupO2mQCfTyF27TedU
         cv5QK6a/odZ+IOsk8BczAC+shYvePBW5wSeN0ao6X3nQfDl2rUaZ4UTjTQZSbgSe87Oa
         q99g==
X-Forwarded-Encrypted: i=1; AJvYcCXsjl814a68okc98kCw16P+IemP4EKkgXP7cUWN8O8VJ91CS4hN0zHgnYXmEWXFbb6vjM3aqBWBaFCsC7ZNouE30osZgUT+JIZ5a+hZ
X-Gm-Message-State: AOJu0Yw14lCfe0fOGwv7DcAaFEIx7/sF56P92Ex2I4Zc+aQVCWj0wy7V
	GfConj6w74Gh/S8m7UIS+fTC7Rh3v1gfdjgpLl4cNavYkPwbILr/r6Qz3msZVRdOWk5skB7uWQ6
	hT/RkG1u11L0GAbdB+1u0ym9mDxBblVI+/WZoAw==
X-Google-Smtp-Source: AGHT+IGgNv214CmoVwCSUjRaOqQbUErdoxgXeV4BV/W0aoOAYNd4EZbmAwgtVrL+4MkZyrldxa3mrPpXHofORifQF5I=
X-Received: by 2002:a05:6214:44a1:b0:6b0:62bb:ab9a with SMTP id
 6a1803df08f44-6b1920277a9mr9426226d6.19.1718172524993; Tue, 11 Jun 2024
 23:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422060811.670693-1-xuxinxiong@huaqin.corp-partner.google.com>
 <CAD=FV=WRLLuOkCJeM6RdAb6xLN-cPH+hfWbOv9-LujB-WMGEFw@mail.gmail.com>
 <CAGoogDB-mj8_xu04w3V2ZxOBTWoXcPKrVR1NRt6BFcpjHX3-7Q@mail.gmail.com>
 <CAD=FV=WwsR9e-ZXJRY11FvdUZ66YPy9vqmY_=sGDw5Wqk1eV3w@mail.gmail.com>
 <CAGoogDBCzfKwkAA-VAs3_Cdw_4oFO94mt7yjy47Sp2RAtqtPxA@mail.gmail.com>
 <CAD=FV=WYiD-BUpksBnZrkWvORepZqtaAvm5645X-_oJPea0s0w@mail.gmail.com>
 <CAD=FV=WMC0XZBc3UKP+Qzb5aeiWBnXrYDf31PNP5cGeAT-8XcA@mail.gmail.com> <CAD=FV=Ua_CuWsPRMsZZhXF2kFjf6-o=s9zKYq=FC4XHQNL8UqQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Ua_CuWsPRMsZZhXF2kFjf6-o=s9zKYq=FC4XHQNL8UqQ@mail.gmail.com>
From: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
Date: Wed, 12 Jun 2024 14:08:34 +0800
Message-ID: <CAGoogDCjpanCwHHuYEu0kU9grv8qy002Utnm1JgRAw-o6TY8=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add panel CSOT MNB601LS1-1
To: Doug Anderson <dianders@chromium.org>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm so sorry for the late reply.
The information we got from the CSOT is that when the project was
first started, CSO was used. Later, they realized this problem and
changed the VID of other panel models to CSW. Since the panel has
already been shipped, they will keep it as CSO and only the VID for
that panel will be CSO.
Thanks a lot!

Doug Anderson <dianders@chromium.org> =E4=BA=8E2024=E5=B9=B46=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=89 00:50=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Tue, May 28, 2024 at 9:27=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Mon, May 6, 2024 at 8:54=E2=80=AFAM Doug Anderson <dianders@chromium=
.org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Apr 23, 2024 at 6:55=E2=80=AFPM Xuxin Xiong
> > > <xuxinxiong@huaqin.corp-partner.google.com> wrote:
> > > >
> > > > Hi Doug, thank you!
> > > > We had reported this info to the CSOT to correct the vendor id.
> > > > If they confirm to fix this with the same product ID, we will submi=
t a
> > > > patch to fix this.
> > >
> > > FYI, "top posting" like this is generally frowned upon on kernel
> > > mailing lists. One such reference about this is [1]. Some folks are
> > > very passionate about this topic, so please keep it in mind to avoid
> > > upsetting people in the community.
> > >
> > > In any case: did you get any response from CSOT about the improper ED=
ID?
> >
> > Just following up here. Was there any response from CSOT?
>
> Continuing to follow up here. Did CSOT say anything about this?
>
> -Doug

