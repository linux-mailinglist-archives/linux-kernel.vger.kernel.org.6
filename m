Return-Path: <linux-kernel+bounces-322221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE34E9725EF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 01:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32091C21564
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB95E18EFE2;
	Mon,  9 Sep 2024 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oZD/ElBb"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B94A18E36E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925989; cv=none; b=KFzRuJI4VmvwBnzKTsy/uaIJdpS+Ez7rFuInWJpVBy4ihGjdVfACEtcj5qoyXH+6unQWnrcJ//ExPJyN7M6Oe/aWQgAqvRi0eSpZnfPOpXONjv0bUjDs0AVYlyDjaR5UWUaV6tbcDw4feA8iq0eyjCDndzBOXzKfjWwds3oJE3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925989; c=relaxed/simple;
	bh=93DJqojuKjkTdhcHgvdkzwZLsPNskOSznfMdg8BeRjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGRA8AHpNZ2cN5ZI2g57y+grsid4aZ5E3/sfDAFdFks1btg8WFX9H29ZtGqOUPH8ZbvFSTrqsWvxo3UVI6ORCvsQ1jm1j6rd5T0YOjQkMRUsh7zzDKdd9a3dLJLErmKNHaFejF68xgy33bBTx179aVwitbfuI1q1IuQf8qDpNAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oZD/ElBb; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a9a7bea3cfso152126085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 16:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725925986; x=1726530786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5txSkUam2KVmJ0zi846w3pJlJlmv+1vLotb8f8z6fXo=;
        b=oZD/ElBb16ZDW+IAK8lJ7Oyh4ozgfUqj960nWpvTb6bV8WzkCDmqb6bPXWx+vW/K7N
         hoDzcOIkloS2vkSEHzCkzKw6t+QEjd2FQnb7vJfNL73W64XAh2ipuo/UTABslRZLnhFt
         Ob0RDAglyFesYueg/rvCE86JW5+VWka+PhVNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725925986; x=1726530786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5txSkUam2KVmJ0zi846w3pJlJlmv+1vLotb8f8z6fXo=;
        b=v1P8MfKQGOzc3nSAn4E/z6oQnRV/dCn/Kl5Aiid/be2TBsZHKmlNwtu+7KUTnupl2o
         EvcKgEAP/vJsxzmTsojAiNrKoD3Rm5hqjNhTnhNEiP+YduYqptIdXo2sE+sGcjx3Qotb
         aAcDv0qs2IT2XX+lkZDkBsyD4m3TLf97av28nY3fg6PUCYTFqXRa00NWKOwze1+aB7N4
         XeUwtdOfeHH84cZNJuzoD/xnQmk3XqEB4uvN/rdQICW+XpihZsPp3izO7/sK/qEa/6wB
         LWqqg/Mnim+rUVQooMRvJ9RdGLsKU8JcAQFsGbceJ0SiPq2g9mibHZZ9FsuPUhMfaJsc
         8prg==
X-Forwarded-Encrypted: i=1; AJvYcCVOjrBgf+m/ME39R0A4cjHTGdXhdzb0PE5VPYce/o5pNCY9oPLcpl+y4s8Dp2uhr6LVZs+nKILAz+hn5JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWZrl6qDWp9VdInpBI5s6BVxbOZHrqDj9TrrxrSq1c+JIu6f+v
	UAyKu86R6TUW4lWzrn7+ZGq9+XjTINLiRuZvXIvt+VwW5YUOp3kSsyCHElmlATyFOtJNZLrIItX
	td64qICMAYCOaohr+WCPGA7m9BZ96lRHQ8J2N
X-Google-Smtp-Source: AGHT+IHcZmhN6BQ2Z0+LRnxFANlmFVMKp4G/+B7owpMej9pK2QQtphdtxnpR5MG6qG2uIg8xuzf6ob271P04Zgf+Eqw=
X-Received: by 2002:a05:620a:258c:b0:7a1:c40c:fc66 with SMTP id
 af79cd13be357-7a99738e2d9mr1772866685a.56.1725925985991; Mon, 09 Sep 2024
 16:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815004617.2325269-1-philipchen@chromium.org>
 <CA+cxXhneUKWr+VGOjmOtWERA53WGcubjWBuFbVBBuJhNhSoBcQ@mail.gmail.com> <66d89eaeb0a4b_1e9158294e1@iweiny-mobl.notmuch>
In-Reply-To: <66d89eaeb0a4b_1e9158294e1@iweiny-mobl.notmuch>
From: Philip Chen <philipchen@chromium.org>
Date: Mon, 9 Sep 2024 16:52:55 -0700
Message-ID: <CA+cxXhmexXuXJg2qgbDJO7MXqpJzuDH1_Hru=7Ei9jus=FGwew@mail.gmail.com>
Subject: Re: [PATCH] virtio_pmem: Add freeze/restore callbacks
To: Ira Weiny <ira.weiny@intel.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	virtualization@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Sep 4, 2024 at 10:54=E2=80=AFAM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> Philip Chen wrote:
> > Hi maintainers,
> >
> > Can anyone let me know if this patch makes sense?
> > Any comment/feedback is appreciated.
> > Thanks in advance!
>
> I'm not an expert on virtio but the code looks ok on the surface.  I've
> discussed this with Dan a bit and virtio-pmem is not heavily tested.

Thanks for your comments.
I think this specific patch is not heavily involved with virtio spec detail=
s.
This patch simply provides the basic freeze/restore PM callbacks for
virtio_pmem, like people already did for the other virtio drivers.

>
> Based on our discussion [1] I wonder if there is a way we can recreate th=
is
> with QEMU to incorporate into our testing?

Yes, these are how I test on crosvm, but I believe the same steps can
be applied to QEMU:
(1) Set pm_test_level to TEST_PLATFORM (build time change)
(2) Write something to pmem
(3) Make the device go through a freeze/restore cycle by writing
`disk` to `/sys/power/state`
(4) Validate the data written to pmem in (2) is still preserved

Note:
(a) The freeze/restore PM routines are sometimes called as the backup
for suspend/resume PM routines in a suspend/resume cycle.
In this case, we can also test freeze/restore PM routines with
suspend/resume: i.e. skip (1) and write `mem` to `sys/power/state` in
(3).
(b) I also tried to set up QEMU for testing. But QEMU crashes when I
try to freeze the device even without applying this patch.
Since the issue seems to be irrelevant to pmem and most likely a QEMU
setup problem on my end, I didn't spend more time enabling QEMU.



>
> Ira
>
> [1] https://lore.kernel.org/lkml/CA+cxXhnb2i5O7_BiOfKLth5Zwp5T62d6F6c39vn=
uT53cUkU_uw@mail.gmail.com/
>
> >
> > On Wed, Aug 14, 2024 at 5:46=E2=80=AFPM Philip Chen <philipchen@chromiu=
m.org> wrote:
> > >
> > > Add basic freeze/restore PM callbacks to support hibernation (S4):
> > > - On freeze, delete vq and quiesce the device to prepare for
> > >   snapshotting.
> > > - On restore, re-init vq and mark DRIVER_OK.
> > >
> > > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > > ---
> > >  drivers/nvdimm/virtio_pmem.c | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pme=
m.c
> > > index c9b97aeabf85..2396d19ce549 100644
> > > --- a/drivers/nvdimm/virtio_pmem.c
> > > +++ b/drivers/nvdimm/virtio_pmem.c
> > > @@ -143,6 +143,28 @@ static void virtio_pmem_remove(struct virtio_dev=
ice *vdev)
> > >         virtio_reset_device(vdev);
> > >  }
> > >
> > > +static int virtio_pmem_freeze(struct virtio_device *vdev)
> > > +{
> > > +       vdev->config->del_vqs(vdev);
> > > +       virtio_reset_device(vdev);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int virtio_pmem_restore(struct virtio_device *vdev)
> > > +{
> > > +       int ret;
> > > +
> > > +       ret =3D init_vq(vdev->priv);
> > > +       if (ret) {
> > > +               dev_err(&vdev->dev, "failed to initialize virtio pmem=
's vq\n");
> > > +               return ret;
> > > +       }
> > > +       virtio_device_ready(vdev);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static unsigned int features[] =3D {
> > >         VIRTIO_PMEM_F_SHMEM_REGION,
> > >  };
> > > @@ -155,6 +177,8 @@ static struct virtio_driver virtio_pmem_driver =
=3D {
> > >         .validate               =3D virtio_pmem_validate,
> > >         .probe                  =3D virtio_pmem_probe,
> > >         .remove                 =3D virtio_pmem_remove,
> > > +       .freeze                 =3D virtio_pmem_freeze,
> > > +       .restore                =3D virtio_pmem_restore,
> > >  };
> > >
> > >  module_virtio_driver(virtio_pmem_driver);
> > > --
> > > 2.46.0.76.ge559c4bf1a-goog
> > >
>
>

