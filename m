Return-Path: <linux-kernel+bounces-183650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980718C9C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECC128301D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB75B51C54;
	Mon, 20 May 2024 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="RE5FvwEK"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA4920EB
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716203995; cv=none; b=rFYXWWGKuXwSizO9FqO9Um0uDzkSbInQcKQjdaUvPi0z+uk011s6wCgUElAyOUHLu0xmCOLzzmgJOmMn2yQvsYYs4Hsa0pBaLldcFNth98KU9dEyVklksnjbkpI3MTiUeNYa6LoiRyPZmr/XgGWUIlrJq21quC7ojNO/6sNwxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716203995; c=relaxed/simple;
	bh=XcAkCrUUp3v82N3Nes852/6WDKEZVaV70AZavoqjXfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCyFuZ1OHoL/n4Xb0kP/gmea+RIwI6rWXrnp0mJQj8F4QECxjpK+dTtpPOrfWBtcLaC33y0f6MzgoBItImfprDo6QNaHcq+WCNhmC4xdh0CzpkxQRKOuJ4zb9JICdbdfOYRo1xbwa/xfD+nzSfBQLHXU8E6koz3AznmayXh/ufs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=RE5FvwEK; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7948b7e4e5dso24640285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 04:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1716203992; x=1716808792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcAkCrUUp3v82N3Nes852/6WDKEZVaV70AZavoqjXfU=;
        b=RE5FvwEK7ya32/MoSF2IKoDFHl0j56tc5kAaE0LxMPbTqUJz94S1RGjCXCgEeKRDV3
         dDo9XpAfAvQ3UR0HLYMLs2/ZlU5Rqd8nclWAqhWSddxbQklYB4g4MQSIr4a9AKroudCh
         pEWokGKBgzzlHVZHH6zAGd4+FfcvqepT3lSmUdWZueGNYslM+9dbWvDr29qtmrgI4lcn
         uNo7quNsPmOcX+EzEPYZV0zwkJ3PC5Y71TvJ9jnIGQPhATgA4+ddod9MfvpLiPoOZwRp
         kHFTd8c6D00qpGx5RBCnIo6D+g3UZhTdHykOMmgcA+b4n2WW3LS7xcLyo7dwmwyvJOZG
         eSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716203992; x=1716808792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcAkCrUUp3v82N3Nes852/6WDKEZVaV70AZavoqjXfU=;
        b=SKgE2d4YXCayuKiOixTDUaUawOXK+zTvKjdzAXPidkb/x0mQXniZXhxE97yu1gTQur
         Thgcl157PuviQcV28UM2LY92fpnE6VuEjhzQ4+8TwUHk8/arxKo0pYREO4q3pOa3tdJi
         BQpEqRbhQp8hV+6vRpof003lDH9qq8vPfKZ6cYvItaNh80oy0i0Oj48OknxC3b/xgycm
         v2ANDZH+9u1arYIDkx6MU/Lzy90C0PLUItuqo7pLd8jSrUTinagpJQz3FL1CjeSfbgHU
         Rr1K5KJahNn+MbmOa1LR3QS+NBna8IHgvmmAluvjhwhjCjlzlnfiIakOfb3F5Xm+Xytk
         cjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcZ+u7wb5r9qmpjmwK4D0yGXIhd36vUorP3yn3O2QCMgGURKpsh3DO4zdeJpz6FtcJDTV2Xh/ohApxzQxwJuEX0BPODRq7ztk0Sz85
X-Gm-Message-State: AOJu0YyR335kEgDxJ4L2OH6n/cxP0yL828ozuPVdncCSxbcJS/F1Ll3k
	Ud8qu1l5cKIb6fJRwlfY3Wwnabxvt43HKgaUxFyHnaFJ3EjpoQRoNHzWYvVYscxj+XUh67SqUVh
	RSCedpuXXklBwbaW7onYwQlu5F2dGURY3aLUjQQ==
X-Google-Smtp-Source: AGHT+IF9QqTZAJOGL9hX5enwhsws06RKb4rc6h3DEa//4Gpj+yXe03WFhBY5czWR0TmSy2w5QCwMYSbalfMBsJ2uDWE=
X-Received: by 2002:a05:620a:56d2:b0:790:c017:89e2 with SMTP id
 af79cd13be357-792c7577a26mr3027043685a.16.1716203991836; Mon, 20 May 2024
 04:19:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
 <97eadcba7cabe56f0f4b4d753bd3d53f8540ef4b.camel@pengutronix.de> <CAAObsKAQ=pWQ8MR1W7WwK1nVEeiCFNC3k+NZKsu4Fkts-_+zWg@mail.gmail.com>
In-Reply-To: <CAAObsKAQ=pWQ8MR1W7WwK1nVEeiCFNC3k+NZKsu4Fkts-_+zWg@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 20 May 2024 12:19:40 +0100
Message-ID: <CAPj87rO7zyDsqUWnkF0pZeNFnNK2UnAVJy4RmB3jmPkKQ+zbEw@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org, 
	Oded Gabbay <ogabbay@kernel.org>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Daniel Stone <daniels@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 20 May 2024 at 08:39, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
> On Fri, May 10, 2024 at 10:34=E2=80=AFAM Lucas Stach <l.stach@pengutronix=
de> wrote:
> > Am Mittwoch, dem 24.04.2024 um 08:37 +0200 schrieb Tomeu Vizoso:
> > > If we expose a render node for NPUs without rendering capabilities, t=
he
> > > userspace stack will offer it to compositors and applications for
> > > rendering, which of course won't work.
> > >
> > > Userspace is probably right in not questioning whether a render node
> > > might not be capable of supporting rendering, so change it in the ker=
nel
> > > instead by exposing a /dev/accel node.
> > >
> > > Before we bring the device up we don't know whether it is capable of
> > > rendering or not (depends on the features of its blocks), so first tr=
y
> > > to probe a rendering node, and if we find out that there is no render=
ing
> > > hardware, abort and retry with an accel node.
> >
> > On the other hand we already have precedence of compute only DRM
> > devices exposing a render node: there are AMD GPUs that don't expose a
> > graphics queue and are thus not able to actually render graphics. Mesa
> > already handles this in part via the PIPE_CAP_GRAPHICS and I think we
> > should simply extend this to not offer a EGL display on screens without
> > that capability.
>
> The problem with this is that the compositors I know don't loop over
> /dev/dri files, trying to create EGL screens and moving to the next
> one until they find one that works.
>
> They take the first render node (unless a specific one has been
> configured), and assumes it will be able to render with it.
>
> To me it seems as if userspace expects that /dev/dri/renderD* devices
> can be used for rendering and by breaking this assumption we would be
> breaking existing software.

Mm, it's sort of backwards from that. Compositors just take a
non-render DRM node for KMS, then ask GBM+EGL to instantiate a GPU
which can work with that. When run in headless mode, we don't take
render nodes directly, but instead just create an EGLDisplay or
VkPhysicalDevice and work backwards to a render node, rather than
selecting a render node and going from there.

So from that PoV I don't think it's really that harmful. The only
complication is in Mesa, where it would see an etnaviv/amdgpu/...
render node and potentially try to use it as a device. As long as Mesa
can correctly skip, there should be no userspace API implications.

That being said, I'm not entirely sure what the _benefit_ would be of
exposing a render node for a device which can't be used by any
'traditional' DRM consumers, i.e. GL/Vulkan/winsys.

Cheers,
Daniel

