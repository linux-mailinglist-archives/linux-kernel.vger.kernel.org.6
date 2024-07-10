Return-Path: <linux-kernel+bounces-248357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D1792DC1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19F528249E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F142514AD25;
	Wed, 10 Jul 2024 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OU14a8TJ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2390E1411ED
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652095; cv=none; b=taVlPY0NXpPTDuQgomXd4Iz9YN61E0H3IcPR/5xFBLA2TIOL1P2mhbbjL8qziQhgYJY3oKgK2oygoHSiM+bCjSDOb6Ws5B8vd1lhTl6Ni7A33IAIxCVnMDp/3k/ohj0iIvwsY1zYuhogbAnGqkkJthJzt9vNdueV1h2OJVMtqWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652095; c=relaxed/simple;
	bh=cDOzi+ZXwS5C7Idx4dnKQ0UYYVdAQXQ23kbJX7qsTSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAEBDINXw+uxRVAryRXkAkVunJHwfy5D/wExkDx8BcMhT+WHnM45ITJAvhzhix94u5nBm+5rCInNAER31Z27wRE7/jIo1zgGB+ZQtkMQLvfoVIaC/fA4d9b000ziMeJXNlELlw/rfNyBueDfMtJhzRHSUQgITVP1h/UNS14bWj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OU14a8TJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5854ac817afso361288a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720652091; x=1721256891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XJJfsxcbaqihoVxsU56HYN19zV6cTHgOtHzTxAFpq0=;
        b=OU14a8TJeWM3cIJp8XXn0TxYggV9M599JGPDu6j74+0siZHj2UimJAtLomPrECiYwt
         OoXtBgQ5db+8FlfAL3ccCajE1TjLk4oSk19NUxtqqB+0o+Sg199Bn55f8H1SyJrsNGny
         py3d5bZcf7fUrDLeD4jxpU1xreBvukakb4Zl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720652091; x=1721256891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XJJfsxcbaqihoVxsU56HYN19zV6cTHgOtHzTxAFpq0=;
        b=i4JC7wZYIDsRcFPmqI1y50JmxCEeegQcC3MFNUFSguKfkbv9ArvUqt34OBQRLmGFTf
         AzBWjNW33AJzsRd9x1t59sbEPg+IwICk4j7jC8RxcFIydVgrqj8+/Q/64uEnMPrwYn7N
         xEWYV4Yx0a/apjFkcIIEVMZ1YwHQ6Tmcnu2aZzorCLd0BJFpbAv7ZRWg5PgWVM92WnMz
         t8CvXVwxSFJ9vGD0fJDskNSRl+1hM4Nee1HFLwW9gLI0n5p8N12FkyUXLowm7fRve/Gt
         e/WAyY+PsTD7fmAPlhMJ3GG2LL8yz+vgyNHs6bgmy54RhGJrqJ0++89AEpoPw756bfbo
         +LOw==
X-Gm-Message-State: AOJu0Ywi+0zbU8aJ+U0EnPiQdp6hYVlaKFqL2bGtHXNG1WKE7JW3scYt
	vIiDKkQ4MI7aMxUGZSBIFB4j/iy0o4GgP539VgTJFIW4frrygz//VoHJeCVpRAUbXX5STW8hHH3
	aNbvg
X-Google-Smtp-Source: AGHT+IHKL4pwanQd6Y0L8OtsIzHlkE7LirUxQvg+tcQZhDEFuE33PLiXKhRor5ndbq9o9dIB0E1ZUg==
X-Received: by 2002:aa7:c258:0:b0:57c:abf9:e6ab with SMTP id 4fb4d7f45d1cf-594bc7c7df9mr4484455a12.31.1720652091514;
        Wed, 10 Jul 2024 15:54:51 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bda30a3bsm2707568a12.92.2024.07.10.15.54.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 15:54:51 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77c4309fc8so50714666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:54:49 -0700 (PDT)
X-Received: by 2002:a17:907:7f12:b0:a77:db34:42ca with SMTP id
 a640c23a62f3a-a780b88347amr588125666b.49.1720652088624; Wed, 10 Jul 2024
 15:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720611677.git.mst@redhat.com> <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
 <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
 <20240710142239-mutt-send-email-mst@kernel.org> <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
 <20240710162640-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240710162640-mutt-send-email-mst@kernel.org>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 10 Jul 2024 15:54:22 -0700
X-Gmail-Original-Message-ID: <CABVzXA=W0C6NNNSYnjop67B=B3nA2MwAetkxM1vY3VggbBVsMg@mail.gmail.com>
Message-ID: <CABVzXA=W0C6NNNSYnjop67B=B3nA2MwAetkxM1vY3VggbBVsMg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] virtio: fix vq # for balloon
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 1:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jul 10, 2024 at 12:58:11PM -0700, Daniel Verkamp wrote:
> > On Wed, Jul 10, 2024 at 11:39=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Wed, Jul 10, 2024 at 11:12:34AM -0700, Daniel Verkamp wrote:
> > > > On Wed, Jul 10, 2024 at 4:43=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > virtio balloon communicates to the core that in some
> > > > > configurations vq #s are non-contiguous by setting name
> > > > > pointer to NULL.
> > > > >
> > > > > Unfortunately, core then turned around and just made them
> > > > > contiguous again. Result is that driver is out of spec.
> > > >
> > > > Thanks for fixing this - I think the overall approach of the patch =
looks good.
> > > >
> > > > > Implement what the API was supposed to do
> > > > > in the 1st place. Compatibility with buggy hypervisors
> > > > > is handled inside virtio-balloon, which is the only driver
> > > > > making use of this facility, so far.
> > > >
> > > > In addition to virtio-balloon, I believe the same problem also affe=
cts
> > > > the virtio-fs device, since queue 1 is only supposed to be present =
if
> > > > VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
> > > > meant to be queue indexes 2 and up. From a look at the Linux driver
> > > > (virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATI=
ON
> > > > and assumes that request queues start at index 1 rather than 2, whi=
ch
> > > > looks out of spec to me, but the current device implementations (th=
at
> > > > I am aware of, anyway) are also broken in the same way, so it ends =
up
> > > > working today. Queue numbering in a spec-compliant device and the
> > > > current Linux driver would mismatch; what the driver considers to b=
e
> > > > the first request queue (index 1) would be ignored by the device si=
nce
> > > > queue index 1 has no function if F_NOTIFICATION isn't negotiated.
> > >
> > >
> > > Oh, thanks a lot for pointing this out!
> > >
> > > I see so this patch is no good as is, we need to add a workaround for
> > > virtio-fs first.
> > >
> > > QEMU workaround is simple - just add an extra queue. But I did not
> > > reasearch how this would interact with vhost-user.
> > >
> > > From driver POV, I guess we could just ignore queue # 1 - would that =
be
> > > ok or does it have performance implications?
> >
> > As a driver workaround for non-compliant devices, I think ignoring the
> > first request queue would be a reasonable approach if the device's
> > config advertises num_request_queues > 1. Unfortunately, both
> > virtiofsd and crosvm's virtio-fs device have hard-coded
> > num_request_queues =3D1, so this won't help with those existing devices=
.
>
> Do they care what the vq # is though?
> We could do some magic to translate VQ #s in qemu.
>
>
> > Maybe there are other devices that we would need to consider as well;
> > commit 529395d2ae64 ("virtio-fs: add multi-queue support") quotes
> > benchmarks that seem to be from a different virtio-fs implementation
> > that does support multiple request queues, so the workaround could
> > possibly be used there.
> >
> > > Or do what I did for balloon here: try with spec compliant #s first,
> > > if that fails then assume it's the spec issue and shift by 1.
> >
> > If there is a way to "guess and check" without breaking spec-compliant
> > devices, that sounds reasonable too; however, I'm not sure how this
> > would work out in practice: an existing non-compliant device may fail
> > to start if the driver tries to enable queue index 2 when it only
> > supports one request queue,
>
> You don't try to enable queue - driver starts by checking queue size.
> The way my patch works is that it assumes a non existing queue has
> size 0 if not available.
>
> This was actually a documented way to check for PCI and MMIO:
>         Read the virtqueue size from queue_size. This controls how big th=
e virtqueue is (see 2.6 Virtqueues).
>         If this field is 0, the virtqueue does not exist.
> MMIO:
>         If the returned value is zero (0x0) the queue is not available.
>
> unfortunately not for CCW, but I guess CCW implementations outside
> of QEMU are uncommon enough that we can assume it's the same?
>
>
> To me the above is also a big hint that drivers are allowed to
> query size for queues that do not exist.

Ah, that makes total sense - detecting queue presence by non-zero
queue size sounds good to me, and it should work in the normal virtio
device case.

I am not sure about vhost-user, since there is no way for the
front-end to ask the back-end for a queue's size; the confusingly
named VHOST_USER_SET_VRING_NUM allows the front-end to configure the
size of a queue, but there's no corresponding GET message.

> > and a spec-compliant device would probably
> > balk if the driver tries to enable queue 1 but does not negotiate
> > VIRTIO_FS_F_NOTIFICATION. If there's a way to reset and retry the
> > whole virtio device initialization process if a device fails like
> > this, then maybe it's feasible. (Or can the driver tweak the virtqueue
> > configuration and try to set DRIVER_OK repeatedly until it works? It's
> > not clear to me if this is allowed by the spec, or what device
> > implementations actually do in practice in this scenario.)
> >
> > Thanks,
> > -- Daniel
>
> My patch starts with a spec compliant behaviour. If that fails,
> try non-compliant one as a fallback.

Got it, that sounds reasonable to me given the explanation above.

Thanks,
-- Daniel

