Return-Path: <linux-kernel+bounces-396897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDBA9BD3D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDCF28402B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769371E6316;
	Tue,  5 Nov 2024 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYnKe2G/"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5243D1E379F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829396; cv=none; b=QugTjzGyWEeKrDzazytg910RIX2JEOMHC1fJsTAKRelVcnV6wX13aEePr8HSost363D2JjSDLHUjMIsMA4wZJnxTUhge9nqtoCSCawST4MFtBICbioitqRuQpfh8fkCKIh6JN6V1Mqs4zzDraVUXa1nw7V1uoObZrMQPCTE18mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829396; c=relaxed/simple;
	bh=NSwMtnyL6SBXHuyDoTvvI3uH9NNMxlx7bJuI3BdLaF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qm7grfhNL8a6iJHLjyrDy/f+YtUtg55g2T+VSxouI/wjMHg9zEA3yR8b0iMvsRGxm3pBlZgkAlrMaUjWVsx7IQ+ma5LUiG4/8OlNkw1lUmTythoAr/0ozDIfzHD7VfzSm/koo1CgpJjTccWecqXkziE/yRXDlAZCZQlLQxnO9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYnKe2G/; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e3c3da5bcdso52923667b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 09:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730829394; x=1731434194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ov/f9wodCdcoHX6CtnPdt9zj/r382pau+gNNBIGmZj0=;
        b=nYnKe2G/3YJkqb+m+t7bCCnE0GtW2ixFMX+n0z/CspiVx7mdUwEhcYJflbhkUwlx4M
         XL4Rlm7cd+pVI/U4miVZQZT/GZosXcsT3D5vms8KJlwYN43sQ/ii6n0Xkb93uUAg76Uz
         VnhUymWlHU0nbPMny/bUCNIAak1ns3KTZ+uL4gqlCkdM0t6dzIx7OLON0gDfcH9B4rBO
         42EcjJ3ZQxEglGyvYVxLIl3EzRxPhtVAj3YaNBDmWlGHmzUPFPATU30T5LgDpU1pm/V9
         jJfHEqLVvVGIyDKkdfIFc+tXGDG8UJFS0nQU63IMsisTPd7ZO7Ao+kwSzMrZFLcFu8c9
         cV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730829394; x=1731434194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ov/f9wodCdcoHX6CtnPdt9zj/r382pau+gNNBIGmZj0=;
        b=ttAD8bEoC5UAJ3Jtjo9f+Gpcpb69/Xm4uHRbPA70nBzyTbHn5OR6dDiat/NB1ljyMM
         kWQWkXKtux3KebrC2G7icA8kaZeUvi+qG84aea64+Tw+RUZyKoL9w6IocpaYI4EfO/kN
         KVyC3cD6uLq0Fp4cTFjUO/U30IbYSLk909eXdm2uXBOqX++7qj6o3G5rJLALntwJ+lBc
         620HLmXg9b8xl8l9ZR/tAtLgcmEAfsbtRAqzqL7STpYdtbrWX4gw4GqqWt9H79loETj8
         KnMBec87AsIdzpbxcBnagjeXNaNFkbmGCur5G7ou5bjxhZDtOG1u3QTVu2I+xMPn76s7
         uWhw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ9fop3/sScMGjr70/LOInJhfcWnwzzLNBCBF7k1iyFt5DqZaZJXOKGBWJMyXhqfa9pkH8GuTjC4neBOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxODYP44yGX0V6RLnPxq54r2bcvxHVAGZgm2RPMK7S8b2pLDoo1
	pyXiGByjDvU2qF+FrIcOT85P+L3bZukCygxORtabpEs7/cPhrkjQ3AVX11yTvgXVYPAKnnfPbhU
	VpiUpH9AC/Gu5n+at/nTwnI/omDs=
X-Google-Smtp-Source: AGHT+IHbpu4HwjZGZXhxAwIjzUksgDOJS9GbBH3EafkyWRfgBcFI24N6LWQk2NivLxsyP/a0bgW6sdPzhnvDpEipS/s=
X-Received: by 2002:a05:690c:4711:b0:6e5:ac5f:9c43 with SMTP id
 00721157ae682-6ea3b980f74mr194507837b3.39.1730829394260; Tue, 05 Nov 2024
 09:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022161825.228278-1-olvaffe@gmail.com> <900f8658-726c-4034-90ff-398e6c57ec47@amd.com>
 <CAPaKu7QwSq7a-ipSOdETFEBGMu4J4ud1SqxDfPp8bNMjCMM5RQ@mail.gmail.com>
 <CAPaKu7TB30wvDvMW2FcYNcxjfDkOje358JNnRr2jJf=99-h-rg@mail.gmail.com> <301110a2-c004-4385-9231-b9354904b5e0@amd.com>
In-Reply-To: <301110a2-c004-4385-9231-b9354904b5e0@amd.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 5 Nov 2024 09:56:22 -0800
Message-ID: <CAPaKu7Tbp1_sd7Eqj7tkWBJBVPSZYo6uYD+7jwP=CwM5YYauFg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/syncobj: ensure progress for syncobj queries
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: boris.brezillon@collabora.com, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Chunming Zhou <david1.zhou@amd.com>, Lionel Landwerlin <lionel.g.landwerlin@intel.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	faith.ekstrand@collabora.com, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 11:32=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 04.11.24 um 22:32 schrieb Chia-I Wu:
>
> On Tue, Oct 22, 2024 at 10:24=E2=80=AFAM Chia-I Wu <olvaffe@gmail.com> wr=
ote:
>
> On Tue, Oct 22, 2024 at 9:53=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
>
> Am 22.10.24 um 18:18 schrieb Chia-I Wu:
>
> Userspace might poll a syncobj with the query ioctl.  Call
> dma_fence_enable_sw_signaling to ensure dma_fence_is_signaled returns
> true in finite time.
>
> Wait a second, just querying the fence status is absolutely not
> guaranteed to return true in finite time. That is well documented on the
> dma_fence() object.
>
> When you want to poll on signaling from userspace you really need to
> call poll or the wait IOCTL with a zero timeout. That will also return
> immediately but should enable signaling while doing that.
>
> So just querying the status should absolutely *not* enable signaling.
> That's an intentional separation.
>
> I think it depends on what semantics DRM_IOCTL_SYNCOBJ_QUERY should have.
>
>
> Well that's what I pointed out. The behavior of the QUERY IOCTL is based =
on the behavior of the dma_fence and the later is documented to do exactly =
what it currently does.
>
> If DRM_IOCTL_SYNCOBJ_QUERY is mainly for vulkan timeline semaphores,
> it is a bit heavy if userspace has to do a
> DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT before a query.
>
>
> Maybe you misunderstood me, you *only* have to call DRM_IOCTL_SYNCOBJ_TIM=
ELINE_WAIT and *not* _QUERY.
>
> The underlying dma_fence_wait_timeout() function is extra optimized so th=
at zero timeout has only minimal overhead.
>
> This overhead is actually lower than _QUERY because that one actually que=
ries the driver for the current status while _WAIT just assumes that the dr=
iver will signal the fence when ready from an interrupt.

The context here is that vkGetSemaphoreCounterValue calls QUERY to get
the timeline value.  WAIT does not replace QUERY.

Taking a step back, in the binary (singled/unsignaled) case, a WAIT
with zero timeout can get the up-to-date status.  But in the timeline
case, there is no direct way to get the up-to-date status if QUERY
must strictly be a wrapper for dma_fence_is_signaled.  It comes back
to what was QUERY designed for and can we change it?


>
> I filed a Mesa issue,
> https://gitlab.freedesktop.org/mesa/mesa/-/issues/12094, and Faith
> suggested a kernel-side fix as well.  Should we reconsider this?
>
>
> Wait a second, you might have an even bigger misconception here. The diff=
erence between waiting and querying is usually intentional!
>
> This is done so that for example on mobile devices you don't need to enab=
le device interrupts, but rather query in defined intervals.
>
> This is a very common design pattern and while I don't know the wording o=
f the Vulkan timeline extension it's quite likely that this is the intended=
 use case.
Yeah, there are Vulkan CTS tests that query timeline semaphores
repeatedly for progress.  Those tests can fail because mesa translates
the queries directly to the QUERY ioctl.

As things are, enable_signaling is a requirement to query up-to-date
status no matter the syncobj is binary or a timeline.  Whether
enable_signaling enables interrupts or not depends on how the specific
fences are implemented.


>
> Regards,
> Christian.

