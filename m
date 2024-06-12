Return-Path: <linux-kernel+bounces-211664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C91905519
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D231F234D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0340717E456;
	Wed, 12 Jun 2024 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="zK6W22l4"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FED17E470
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202385; cv=none; b=CzNYxwErYjCpNLvWcGHJ9bfbktSAOWdameaWWgtl+8+9xd74YOj/N4Rd+SeCbJamSORAKfr/B/oFOrtRZGQ2osRyPSxMVVZMQJ2Vrwqmq9yWfBI0ZWVWaCmTggde8aCjYph/5TXz48sv9SUXgVMP35A70ED7UXQuuRIultxtqZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202385; c=relaxed/simple;
	bh=uNi2Aj5GB0qprr0RlLvPxqzHcZyuu+DlH1zEbI28b0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGgAr116QYLkH11JBr/Rukya3/EtEjTTzKuRo0ht9O6jIqJS/EKLHrLz+Io0BADy28MpV9AECwqtxo2/zG92tLlN+nPJ2Hnbg2JxptIPHssD7iZ2zcf3O3nIfialEqqKl8owx8VCz5eUKlnFtw88ZVlBKODCDzf43OaYPgoWkZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=zK6W22l4; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-627f3265898so74047167b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1718202377; x=1718807177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNi2Aj5GB0qprr0RlLvPxqzHcZyuu+DlH1zEbI28b0s=;
        b=zK6W22l4Yl+ZEhgN7Bvo0YSNNAHaS30wFFj0bQni9yDpxgfXFCeub8mAoqgCgECvuo
         Xra+umtXteC4pw6eOOsqHoQeew3zNy6G41YaU3Tz0afJNnxUo/NnKGyI4mv2O0wIEKQ+
         DG/K/pKqQyVLjpvDFpC06YANmfdkAsIbZukydrDYckOnQgrvJ/ahDD3lCYaK0pkScNnS
         KcwHiW2wXZ9/vUEkhKK5la4OEaPOwyXd/2uIqz4LzEd//9zX1OiTKGvqtIg0GNXbhYk4
         6s2SZA15eRHXuxZjOxJjo2ggLn6uavzctosoXAnOlunxPaCcmbHX990Bpq6yd+h8X1Ht
         84ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718202377; x=1718807177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNi2Aj5GB0qprr0RlLvPxqzHcZyuu+DlH1zEbI28b0s=;
        b=Th8Q3UU5O+BFWw0GO1x02vX5P4/KX3s9jcjCdk8rz7ZXCREXore75PLTMVPeB7nh4v
         /apistQNwVo69PTkaMrSQwIOvSfioCTplqnFumwNH7VlqF37ulfsgeLAqHwQ94fPQuQc
         luzdMuLb+Du0M8RFa2sr/pdoBFnFWFLr4Xo/qCN9yq1fTiPnCHCqT1bcHIugyJ3iz/77
         K/U5sTDpkqIeLjqBcRo+h4LJsVOpol2TyiwnpP+uQZL+9mDu1DFKYCTDg7+oxq7V//2O
         Zeyiol3SQJPvy1aKefZip+oqEov9J0LFWydjkHpC2PNyNPkbTRRw/VNl9AmS1RzAksxc
         Zuhw==
X-Forwarded-Encrypted: i=1; AJvYcCXOJyd0Gwuxcn4/f7IezLrMEDmwMh6/1UvngPITqewZQO/qnkDPUB1sMn7KPWdTU67DKVM2XFgb4H6o/sZ1Gtl4sIEq4VDlG2lqJEsY
X-Gm-Message-State: AOJu0YxWYr3zg1PKwKpEuroLg4SMn6OrEQuT7f/1T5crTIal8iSkt2cy
	YSEubWk8ct1/oCdmAkxkyTVTPmiHGklcau4ORdkGuxZ08IfORttfw/EzNLKhJbL7xhL7wca/Bef
	sWvI=
X-Google-Smtp-Source: AGHT+IET9KivyoOw02SqbWX8+KoeFJ2956s16q2bJVtdbkuqsDxSa7zyXiLqji88CEabQ8vULgAGTg==
X-Received: by 2002:a0d:ca01:0:b0:627:7e65:979 with SMTP id 00721157ae682-62fb902d6f8mr20373777b3.24.1718202377106;
        Wed, 12 Jun 2024 07:26:17 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62da43d3528sm8138847b3.25.2024.06.12.07.26.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 07:26:16 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfde5ae0aaeso1516001276.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:26:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjWDOPgapHScKDPYPlFUGAVgYdQRFWd/uxilgOOI8hnic+u72tYFD+ErxSoyUPeEMpXXsSBkMcGockpoMnnXJi0CYoul8NMyVRS308
X-Received: by 2002:a25:aa70:0:b0:dfd:dfc3:2825 with SMTP id
 3f1490d57ef6-dfe67065562mr2033623276.36.1718202375106; Wed, 12 Jun 2024
 07:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
 <97eadcba7cabe56f0f4b4d753bd3d53f8540ef4b.camel@pengutronix.de>
 <CAAObsKAQ=pWQ8MR1W7WwK1nVEeiCFNC3k+NZKsu4Fkts-_+zWg@mail.gmail.com> <CAPj87rO7zyDsqUWnkF0pZeNFnNK2UnAVJy4RmB3jmPkKQ+zbEw@mail.gmail.com>
In-Reply-To: <CAPj87rO7zyDsqUWnkF0pZeNFnNK2UnAVJy4RmB3jmPkKQ+zbEw@mail.gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 12 Jun 2024 16:26:02 +0200
X-Gmail-Original-Message-ID: <CAAObsKBm3D_3ctFyK-rfpM-PU6ox1yoaMA1EES9yR-nRmU4rYw@mail.gmail.com>
Message-ID: <CAAObsKBm3D_3ctFyK-rfpM-PU6ox1yoaMA1EES9yR-nRmU4rYw@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
To: Daniel Stone <daniel@fooishbar.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org, 
	Oded Gabbay <ogabbay@kernel.org>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Daniel Stone <daniels@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 1:19=E2=80=AFPM Daniel Stone <daniel@fooishbar.org>=
 wrote:
>
> Hi,
>
> On Mon, 20 May 2024 at 08:39, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
> > On Fri, May 10, 2024 at 10:34=E2=80=AFAM Lucas Stach <l.stach@pengutron=
ix.de> wrote:
> > > Am Mittwoch, dem 24.04.2024 um 08:37 +0200 schrieb Tomeu Vizoso:
> > > > If we expose a render node for NPUs without rendering capabilities,=
 the
> > > > userspace stack will offer it to compositors and applications for
> > > > rendering, which of course won't work.
> > > >
> > > > Userspace is probably right in not questioning whether a render nod=
e
> > > > might not be capable of supporting rendering, so change it in the k=
ernel
> > > > instead by exposing a /dev/accel node.
> > > >
> > > > Before we bring the device up we don't know whether it is capable o=
f
> > > > rendering or not (depends on the features of its blocks), so first =
try
> > > > to probe a rendering node, and if we find out that there is no rend=
ering
> > > > hardware, abort and retry with an accel node.
> > >
> > > On the other hand we already have precedence of compute only DRM
> > > devices exposing a render node: there are AMD GPUs that don't expose =
a
> > > graphics queue and are thus not able to actually render graphics. Mes=
a
> > > already handles this in part via the PIPE_CAP_GRAPHICS and I think we
> > > should simply extend this to not offer a EGL display on screens witho=
ut
> > > that capability.
> >
> > The problem with this is that the compositors I know don't loop over
> > /dev/dri files, trying to create EGL screens and moving to the next
> > one until they find one that works.
> >
> > They take the first render node (unless a specific one has been
> > configured), and assumes it will be able to render with it.
> >
> > To me it seems as if userspace expects that /dev/dri/renderD* devices
> > can be used for rendering and by breaking this assumption we would be
> > breaking existing software.
>
> Mm, it's sort of backwards from that. Compositors just take a
> non-render DRM node for KMS, then ask GBM+EGL to instantiate a GPU
> which can work with that. When run in headless mode, we don't take
> render nodes directly, but instead just create an EGLDisplay or
> VkPhysicalDevice and work backwards to a render node, rather than
> selecting a render node and going from there.
>
> So from that PoV I don't think it's really that harmful. The only
> complication is in Mesa, where it would see an etnaviv/amdgpu/...
> render node and potentially try to use it as a device. As long as Mesa
> can correctly skip, there should be no userspace API implications.
>
> That being said, I'm not entirely sure what the _benefit_ would be of
> exposing a render node for a device which can't be used by any
> 'traditional' DRM consumers, i.e. GL/Vulkan/winsys.

What I don't understand yet from Lucas proposal is how this isn't
going to break existing userspace.

I mean, even if we find a good way of having userspace skip
non-rendering render nodes, what about existing userspace that isn't
able to do that? Any updates to newer kernels are going to break them.

Regards,

Tomeu

