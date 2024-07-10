Return-Path: <linux-kernel+bounces-248198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBB992D9B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A1D1C20EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEA3194C96;
	Wed, 10 Jul 2024 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hbnv8nHk"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992E54EB51
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720641974; cv=none; b=RyeST9zy4fwBsRKpIX/cwlSzd2UO2GhlDlnlHSCDjDKF0NjVXGEPeUSM0zq9shvar4qKQfUW9HBe2ICHSyJK/288MWOzIMMwWHlHrrd8DjT6h7E4h+F6yoZo77yz7ueoAJY+6s9nvQn07vqEuDfuvDMtdgGYdbNdYIv6he4msV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720641974; c=relaxed/simple;
	bh=yaZFbOF1F9Ja9FQEvL/ykv3jVOt1v2vsmoWiE05XgDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mykwUF9pgDQxoBQdeSWYpeivoe3MboLEIUNtiBuL3nLhxgjzfo/nfSs2046qKu2RNRepnAOV7K3Nlvr53nawoONcWrpGz4MgLTO4CDUlGkI4Jwrn1bZLQde7YNvXRU+mpYaee6mbQFeYtEPTcYVCwNa+WIl/78sZjKikXRzHxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hbnv8nHk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77d876273dso15603066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720641971; x=1721246771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaZFbOF1F9Ja9FQEvL/ykv3jVOt1v2vsmoWiE05XgDU=;
        b=hbnv8nHkMgl3FE3lFv/KXEPvwLl/0zc11Mv2u/g6MSNw2WTynqWh8YzYNSzPbOkC4y
         epN1FeqNiBHASIp2qFMc94Y72jMByVp5JNiVToFPFbC0h7mJiRomlTMaAHrhEbBJdDxt
         qm2mLA0wzRNz9qjDav9UnvMShnErtZf1Sf33g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720641971; x=1721246771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaZFbOF1F9Ja9FQEvL/ykv3jVOt1v2vsmoWiE05XgDU=;
        b=Qzoz7RpqAfNJw/q3x94a0KuWBpRBEE2dBT5kKAlqWkAf9Cp2FHdmfcAD3bbByQ8UNV
         lxwcCAtwd3jS1au4E13Ch9Aj2NZORDx9YHDlGBXlw7jWajegJ1gNW0jwW+7G6K6NnKcR
         ixKNUd5ph948wGa6iZKf3e6LNC8Jo5SEKecxBsqVvjwpovmtuMi+lY+ihMbYzij0/7bM
         XQMopbQx9e1RlAjpxyL8omvlmowRV6VSsw8uuSjm/VD9w+YKVeurfKBYW0js9YW1pnFF
         xHwObPM5iv9kay3CqKFCJTfkEP9dj129YAC036p83LSbeJBXkzKtuRtjcmuQgGX+Ja4T
         wX7g==
X-Gm-Message-State: AOJu0YwA6l6FQ2wWnW2JNlbB1k3iWke0vdEAGrizZlDT4xk6/LBLAUWv
	jQ/4+1Jsd9oixBJg2236mnEqxV38HfkGSZC2jO6fvJel3FGhvf0P15kcQ+t4Zmnji9NDGXpSy3w
	p0rBBlEg=
X-Google-Smtp-Source: AGHT+IF1syUx6gj4qd65RysOmCRWjgsFSQRSUqGZ6iNtXYUi+2UCA19VmY/MV6XED52WKSnx4wp6QQ==
X-Received: by 2002:a05:6402:1eca:b0:57c:5d4a:4122 with SMTP id 4fb4d7f45d1cf-594bac74fbemr5632396a12.9.1720641970622;
        Wed, 10 Jul 2024 13:06:10 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc7c9e5fsm2589426a12.58.2024.07.10.13.06.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 13:06:10 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa6b3so103607a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:06:09 -0700 (PDT)
X-Received: by 2002:a05:6512:2111:b0:52e:73f5:b7c4 with SMTP id
 2adb3069b0e04-52eb99a3645mr4058074e87.37.1720641518212; Wed, 10 Jul 2024
 12:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720611677.git.mst@redhat.com> <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
 <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com> <20240710142239-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240710142239-mutt-send-email-mst@kernel.org>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 10 Jul 2024 12:58:11 -0700
X-Gmail-Original-Message-ID: <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
Message-ID: <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
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

On Wed, Jul 10, 2024 at 11:39=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Jul 10, 2024 at 11:12:34AM -0700, Daniel Verkamp wrote:
> > On Wed, Jul 10, 2024 at 4:43=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > virtio balloon communicates to the core that in some
> > > configurations vq #s are non-contiguous by setting name
> > > pointer to NULL.
> > >
> > > Unfortunately, core then turned around and just made them
> > > contiguous again. Result is that driver is out of spec.
> >
> > Thanks for fixing this - I think the overall approach of the patch look=
s good.
> >
> > > Implement what the API was supposed to do
> > > in the 1st place. Compatibility with buggy hypervisors
> > > is handled inside virtio-balloon, which is the only driver
> > > making use of this facility, so far.
> >
> > In addition to virtio-balloon, I believe the same problem also affects
> > the virtio-fs device, since queue 1 is only supposed to be present if
> > VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
> > meant to be queue indexes 2 and up. From a look at the Linux driver
> > (virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATION
> > and assumes that request queues start at index 1 rather than 2, which
> > looks out of spec to me, but the current device implementations (that
> > I am aware of, anyway) are also broken in the same way, so it ends up
> > working today. Queue numbering in a spec-compliant device and the
> > current Linux driver would mismatch; what the driver considers to be
> > the first request queue (index 1) would be ignored by the device since
> > queue index 1 has no function if F_NOTIFICATION isn't negotiated.
>
>
> Oh, thanks a lot for pointing this out!
>
> I see so this patch is no good as is, we need to add a workaround for
> virtio-fs first.
>
> QEMU workaround is simple - just add an extra queue. But I did not
> reasearch how this would interact with vhost-user.
>
> From driver POV, I guess we could just ignore queue # 1 - would that be
> ok or does it have performance implications?

As a driver workaround for non-compliant devices, I think ignoring the
first request queue would be a reasonable approach if the device's
config advertises num_request_queues > 1. Unfortunately, both
virtiofsd and crosvm's virtio-fs device have hard-coded
num_request_queues =3D1, so this won't help with those existing devices.
Maybe there are other devices that we would need to consider as well;
commit 529395d2ae64 ("virtio-fs: add multi-queue support") quotes
benchmarks that seem to be from a different virtio-fs implementation
that does support multiple request queues, so the workaround could
possibly be used there.

> Or do what I did for balloon here: try with spec compliant #s first,
> if that fails then assume it's the spec issue and shift by 1.

If there is a way to "guess and check" without breaking spec-compliant
devices, that sounds reasonable too; however, I'm not sure how this
would work out in practice: an existing non-compliant device may fail
to start if the driver tries to enable queue index 2 when it only
supports one request queue, and a spec-compliant device would probably
balk if the driver tries to enable queue 1 but does not negotiate
VIRTIO_FS_F_NOTIFICATION. If there's a way to reset and retry the
whole virtio device initialization process if a device fails like
this, then maybe it's feasible. (Or can the driver tweak the virtqueue
configuration and try to set DRIVER_OK repeatedly until it works? It's
not clear to me if this is allowed by the spec, or what device
implementations actually do in practice in this scenario.)

Thanks,
-- Daniel

