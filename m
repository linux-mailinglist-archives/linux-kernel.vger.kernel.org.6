Return-Path: <linux-kernel+bounces-217980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5848390B796
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E248FB26DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E0C168486;
	Mon, 17 Jun 2024 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="w1J4C8+N"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B4F335C0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643683; cv=none; b=karVSuXe1WopLAhCJ3UFCkUcnR39DZ/Z7sXMev7mqbJiWR/ENavHUSgiv5iRyUgMh4iqsgirY7lyCe0h4cS458kEAKXz1z9PZIJxSUqxOClHJ76vLYItNdjVJrDc3ijGR/RbSEoaFiq2bP97/Yi2FwBIKTPAhGOd59ROCS1u1cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643683; c=relaxed/simple;
	bh=ggtgEFWxLY5KzKGMkn+w0yd/JsuWTu5QxX/rhOCIS4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNZZUX4Iahu3NA82+hqfz4sfExHS2Z9qgX9oPxHB/NuV1Cnp7B+2eG/ADXXxijrX1XaBxCp1JKuNe6eaQgqtseOiOzbBFbpFz3m5efTnnxF0mqfiVvKYEavyYhYW9z2anBuX+ab4nFLmXq753BfzuO79yyWjZmYEgE0K95wm24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=w1J4C8+N; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-633629c3471so22871287b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1718643678; x=1719248478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggtgEFWxLY5KzKGMkn+w0yd/JsuWTu5QxX/rhOCIS4Q=;
        b=w1J4C8+NlpOfDJRuGsVYeFv267jikvxxl/+IZv9zo/I8ljfx28Gefd2WPu24hyVEpC
         U2d++tvSEU2bWReVYutDE/PHry3NW/g5MH+W9KtRbpOXpevlPKByHbHKV2fTSBkBvDgn
         /Hx7ML/3pMDWq+qzF/rocTk4ICML2tSrO89Lb7SJq0IEOFY9BOEAWapOfvyngToyyFPh
         h+bXUC1kAmHl8Hl7Xy3ZJVOUIKL1U+ibbDi7EDpCyGDZ7nq61okBY3BLkcGRkMF+jtGU
         AQ9PlL3J5jxekXs7giThJrueqT/urQ/RsNdR6gJKBAaRyVQovfMGBdz96//wlZPTzjqP
         1mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718643678; x=1719248478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggtgEFWxLY5KzKGMkn+w0yd/JsuWTu5QxX/rhOCIS4Q=;
        b=vvIZRu9X7wzft3/WxI57mdibfQmLktZsoGBDSwsitBHN19u/UgO7LxmXwPJ0klLcN+
         HDNNvi0ESljO3sUhhX9lpQ1NllBCzV5F/5uhM2NmCgVZlCHc4C0ZKTsUCVx6yDuTq3Uz
         WonwwjelrmatzMHRBKSfL7Fnz1JT8Mjt8Ndhd3xgR4GNjRD8Uv1ecs2qLsvN2N1d+MXm
         7tnZmhIPT12L9kuwjohiLfTOaytW9nqVy6omp9BEHds6WLEeHAnDt6Y4ITbz2661rNd1
         an9WaXVDm8RsJTkhFi4bZtzNOEOnJSrJvWVVNV0vpVlgEhYBNQoqt62sGX/gGxbM7aaA
         Fjfw==
X-Forwarded-Encrypted: i=1; AJvYcCWt2yIVsDsLhbqb/UXV3Nb68sMljfbrOS2pF3akcgiBVbtzlprTICls7objqFvMD+vHfzr++cyUQVlYDe0Y1ljbNKnoQ2FR8PYViSAu
X-Gm-Message-State: AOJu0Yxn1XAXVqndUnzuRhynVNzzpul4Av8AXYERmqZhDGB09asXlfp+
	13jnZG5+8qQEqkE8ZXzBATcxZBwaP+JncseFdGECps5wHgnIzhJeK/wfE54kxc+e9c+85xczymD
	GYSOR1A==
X-Google-Smtp-Source: AGHT+IGYt8/+KocbII2zUsPuRJ3mIodDvR+z8fRfG01lIdIcVc6Ike2X4YyTaJBofg5P86q6wjAViQ==
X-Received: by 2002:a81:8d4c:0:b0:627:778f:b0a8 with SMTP id 00721157ae682-63223b3c02amr98797427b3.42.1718643678545;
        Mon, 17 Jun 2024 10:01:18 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-631189a7d33sm14887667b3.33.2024.06.17.10.01.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 10:01:17 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfdff9771f8so4659985276.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:01:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUe032G9PrfunTiS8HE5en1JdgkV+NkGgRscomb6YWD665c5bCUFXGKENHer+XlXx3pRbnm2c2OC5REyrzoNqG2+v7+ZXV+YXmNyopK
X-Received: by 2002:a25:2e4e:0:b0:dfa:ccb2:b18 with SMTP id
 3f1490d57ef6-dff153422ddmr9460718276.6.1718643677298; Mon, 17 Jun 2024
 10:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
 <97eadcba7cabe56f0f4b4d753bd3d53f8540ef4b.camel@pengutronix.de>
 <CAAObsKAQ=pWQ8MR1W7WwK1nVEeiCFNC3k+NZKsu4Fkts-_+zWg@mail.gmail.com>
 <CAPj87rO7zyDsqUWnkF0pZeNFnNK2UnAVJy4RmB3jmPkKQ+zbEw@mail.gmail.com> <CAAObsKBm3D_3ctFyK-rfpM-PU6ox1yoaMA1EES9yR-nRmU4rYw@mail.gmail.com>
In-Reply-To: <CAAObsKBm3D_3ctFyK-rfpM-PU6ox1yoaMA1EES9yR-nRmU4rYw@mail.gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Mon, 17 Jun 2024 19:01:05 +0200
X-Gmail-Original-Message-ID: <CAAObsKAt563VNzDcF4rGkWPcxBPzKcq=Hj5RY6K20FWR43nvUQ@mail.gmail.com>
Message-ID: <CAAObsKAt563VNzDcF4rGkWPcxBPzKcq=Hj5RY6K20FWR43nvUQ@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
To: Daniel Stone <daniel@fooishbar.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org, 
	Oded Gabbay <ogabbay@kernel.org>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Daniel Stone <daniels@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

Do you have any idea on how not to break userspace if we expose a render no=
de?

Cheers,

Tomeu

On Wed, Jun 12, 2024 at 4:26=E2=80=AFPM Tomeu Vizoso <tomeu@tomeuvizoso.net=
> wrote:
>
> On Mon, May 20, 2024 at 1:19=E2=80=AFPM Daniel Stone <daniel@fooishbar.or=
g> wrote:
> >
> > Hi,
> >
> > On Mon, 20 May 2024 at 08:39, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrot=
e:
> > > On Fri, May 10, 2024 at 10:34=E2=80=AFAM Lucas Stach <l.stach@pengutr=
onix.de> wrote:
> > > > Am Mittwoch, dem 24.04.2024 um 08:37 +0200 schrieb Tomeu Vizoso:
> > > > > If we expose a render node for NPUs without rendering capabilitie=
s, the
> > > > > userspace stack will offer it to compositors and applications for
> > > > > rendering, which of course won't work.
> > > > >
> > > > > Userspace is probably right in not questioning whether a render n=
ode
> > > > > might not be capable of supporting rendering, so change it in the=
 kernel
> > > > > instead by exposing a /dev/accel node.
> > > > >
> > > > > Before we bring the device up we don't know whether it is capable=
 of
> > > > > rendering or not (depends on the features of its blocks), so firs=
t try
> > > > > to probe a rendering node, and if we find out that there is no re=
ndering
> > > > > hardware, abort and retry with an accel node.
> > > >
> > > > On the other hand we already have precedence of compute only DRM
> > > > devices exposing a render node: there are AMD GPUs that don't expos=
e a
> > > > graphics queue and are thus not able to actually render graphics. M=
esa
> > > > already handles this in part via the PIPE_CAP_GRAPHICS and I think =
we
> > > > should simply extend this to not offer a EGL display on screens wit=
hout
> > > > that capability.
> > >
> > > The problem with this is that the compositors I know don't loop over
> > > /dev/dri files, trying to create EGL screens and moving to the next
> > > one until they find one that works.
> > >
> > > They take the first render node (unless a specific one has been
> > > configured), and assumes it will be able to render with it.
> > >
> > > To me it seems as if userspace expects that /dev/dri/renderD* devices
> > > can be used for rendering and by breaking this assumption we would be
> > > breaking existing software.
> >
> > Mm, it's sort of backwards from that. Compositors just take a
> > non-render DRM node for KMS, then ask GBM+EGL to instantiate a GPU
> > which can work with that. When run in headless mode, we don't take
> > render nodes directly, but instead just create an EGLDisplay or
> > VkPhysicalDevice and work backwards to a render node, rather than
> > selecting a render node and going from there.
> >
> > So from that PoV I don't think it's really that harmful. The only
> > complication is in Mesa, where it would see an etnaviv/amdgpu/...
> > render node and potentially try to use it as a device. As long as Mesa
> > can correctly skip, there should be no userspace API implications.
> >
> > That being said, I'm not entirely sure what the _benefit_ would be of
> > exposing a render node for a device which can't be used by any
> > 'traditional' DRM consumers, i.e. GL/Vulkan/winsys.
>
> What I don't understand yet from Lucas proposal is how this isn't
> going to break existing userspace.
>
> I mean, even if we find a good way of having userspace skip
> non-rendering render nodes, what about existing userspace that isn't
> able to do that? Any updates to newer kernels are going to break them.
>
> Regards,
>
> Tomeu

