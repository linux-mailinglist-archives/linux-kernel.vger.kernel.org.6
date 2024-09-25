Return-Path: <linux-kernel+bounces-338164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2727598542E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1AE1F2175F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A34156F30;
	Wed, 25 Sep 2024 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2w8Fa89"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B00F132114
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249443; cv=none; b=qn2OZERyh5EpJtxJ26BXY6l8cZIpy5kJEnYIMkVeFbjCdyz/9RqFbkYm4w2FE5kmWLH/S2VFZoXBT3IIS1iUcMftq9piqGn9Mw9rcAC3ncjwjpIXxMbCbFcByYlsAZeuMODb3KdiS6qn8nzhax5nZMGXXOwKwpnsMy1Alovsw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249443; c=relaxed/simple;
	bh=TmrPdn5NEcwKi8+2/Xl+a5iFyHK5ODJ6fs9fiV9ETFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCEEA7ifBygLk8nRRxw0LGcGZRafzCEV5QyXcyVMZk297H5qvPGLSLvktb1DCAV9PvHNiG7V4G9EyexpzyXr8ozRwFAKYiJ1StROSsgDHDE1jbGLSdGyk6jAn+nO6sL2m6GL4Ccwowdo3ZcT57ALB1mBdwYveyUP3rkhPQguOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2w8Fa89; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-277e4327c99so3389626fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727249441; x=1727854241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEF//4/TjEDOSnrvBgSi2vP7otKgKVy333EOw4mnEkU=;
        b=A2w8Fa89YBzIiBMKnJewfj1w7aMugUnw9eau07jjIsAK0KkJ+CHduTKfsBOJSXjc0H
         GN4D7NGD0hSTr2gk99Baq2fXA0fdynzjEZ713Y10EJLjwO0qRcnUTt/Bm9jV1FpJGIIg
         N0EzypNcj7Vvb7jNTcNPoR5MRYHn5WtxWo8iM1fDcbWy0g+S1tXFnkVMPVdg3Nj4CKXJ
         C5t9Ko74L40C1cFiZPhkASUbTjmmVNFheeTVuM4u48GK1DsblralSzLOiuMWymz1KCUT
         AVXUHNk4L5Rn233/SXr5d2uP6iETA+pmFxC6tQmFsmsmPgxDZz437BqpIqkfwaj2vU/+
         Wn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727249441; x=1727854241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEF//4/TjEDOSnrvBgSi2vP7otKgKVy333EOw4mnEkU=;
        b=BWiIcwjilgLBCWvZ5pAhDknDxm5IXtpIumRbRAa+EqifHPmX4TWOQ3D2NlHVCjbDDQ
         LRA30JAgCtMLErromx376WHRvMd6YQvuB4AnbE2l2U4UQEevUPmzSfSmZQE46NOmG9Zf
         JXarQmI15XiNShnYsi+maXsR9M3qAdpUYJE+C/hNTZEkZkjF0kkukh0dmNUoPSaHJmac
         dnX4ihb4OW5tczr7eLOr/TYTHuDjCZf5jU6i+HOOWK++JPOx2BpESPJDdIx35wrZNfjL
         mc2Wvk+5azs43jcYEv6Qxh7Fg/EJ2iQ5MfMlVwECthu05DJLSxHtGxTcacNDT7+uUnJn
         fCnw==
X-Forwarded-Encrypted: i=1; AJvYcCWKZGu1ucIACtS2O+//tFz571OtlDUPuKCUUpCosqFLR0/zZU+HJxAY+N+21yTqcoNIpHzPa8BqTzwDunk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDv3V4Rt4xXZ5ANku5yKoBCB+o+qpDp5tXmBeKTQmiQ3DZnLXe
	utmWrXkjjHo5HdCm/2lBIxTh3YEcr+hPJeraz9oK/SL/WwXUMIpuySEgpO+npIvAcXmOOnCByg5
	LFRg4S3/hSy0FQ+nwYe5JpFJmZsc=
X-Google-Smtp-Source: AGHT+IERUFf43OQjqFHBX1wxjsV5rFHY2BjnxHcVaN5zvMxnuLwsk8+tfyrT/vPc8EahpFIWZ7rQIkjn9j8OvTepDXI=
X-Received: by 2002:a05:6870:a450:b0:277:cb9f:8246 with SMTP id
 586e51a60fabf-286e160a076mr1465727fac.38.1727249441010; Wed, 25 Sep 2024
 00:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815004617.2325269-1-philipchen@chromium.org>
 <CA+cxXhneUKWr+VGOjmOtWERA53WGcubjWBuFbVBBuJhNhSoBcQ@mail.gmail.com>
 <66d89eaeb0a4b_1e9158294e1@iweiny-mobl.notmuch> <CA+cxXhmexXuXJg2qgbDJO7MXqpJzuDH1_Hru=7Ei9jus=FGwew@mail.gmail.com>
In-Reply-To: <CA+cxXhmexXuXJg2qgbDJO7MXqpJzuDH1_Hru=7Ei9jus=FGwew@mail.gmail.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 25 Sep 2024 09:30:29 +0200
Message-ID: <CAM9Jb+gj2e0A-3=gmvUUWWEzjpEHfJhaqnSKPmhg4E4ucXgexg@mail.gmail.com>
Subject: Re: [PATCH] virtio_pmem: Add freeze/restore callbacks
To: Philip Chen <philipchen@chromium.org>
Cc: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	virtualization@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+CC MST

> > Philip Chen wrote:
> > > Hi maintainers,
> > >
> > > Can anyone let me know if this patch makes sense?
> > > Any comment/feedback is appreciated.
> > > Thanks in advance!
> >
> > I'm not an expert on virtio but the code looks ok on the surface.  I've
> > discussed this with Dan a bit and virtio-pmem is not heavily tested.
>
> Thanks for your comments.
> I think this specific patch is not heavily involved with virtio spec deta=
ils.
> This patch simply provides the basic freeze/restore PM callbacks for
> virtio_pmem, like people already did for the other virtio drivers.
>
> >
> > Based on our discussion [1] I wonder if there is a way we can recreate =
this
> > with QEMU to incorporate into our testing?
>
> Yes, these are how I test on crosvm, but I believe the same steps can
> be applied to QEMU:
> (1) Set pm_test_level to TEST_PLATFORM (build time change)
> (2) Write something to pmem
> (3) Make the device go through a freeze/restore cycle by writing
> `disk` to `/sys/power/state`
> (4) Validate the data written to pmem in (2) is still preserved
>
> Note:
> (a) The freeze/restore PM routines are sometimes called as the backup
> for suspend/resume PM routines in a suspend/resume cycle.
> In this case, we can also test freeze/restore PM routines with
> suspend/resume: i.e. skip (1) and write `mem` to `sys/power/state` in
> (3).
> (b) I also tried to set up QEMU for testing. But QEMU crashes when I
> try to freeze the device even without applying this patch.
> Since the issue seems to be irrelevant to pmem and most likely a QEMU
> setup problem on my end, I didn't spend more time enabling QEMU.

Thanks for the work!

Did you check why QEMU was crashing, maybe because we did not support
freeze/restore before
so some missing NULL check? Any back trace you got?

If it works in crossVM, it should work in Qemu as well?

Thanks,
Pankaj

>
>
>
> >
> > Ira
> >
> > [1] https://lore.kernel.org/lkml/CA+cxXhnb2i5O7_BiOfKLth5Zwp5T62d6F6c39=
vnuT53cUkU_uw@mail.gmail.com/
> >
> > >
> > > On Wed, Aug 14, 2024 at 5:46=E2=80=AFPM Philip Chen <philipchen@chrom=
ium.org> wrote:
> > > >
> > > > Add basic freeze/restore PM callbacks to support hibernation (S4):
> > > > - On freeze, delete vq and quiesce the device to prepare for
> > > >   snapshotting.
> > > > - On restore, re-init vq and mark DRIVER_OK.
> > > >
> > > > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > > > ---
> > > >  drivers/nvdimm/virtio_pmem.c | 24 ++++++++++++++++++++++++
> > > >  1 file changed, 24 insertions(+)
> > > >
> > > > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_p=
mem.c
> > > > index c9b97aeabf85..2396d19ce549 100644
> > > > --- a/drivers/nvdimm/virtio_pmem.c
> > > > +++ b/drivers/nvdimm/virtio_pmem.c
> > > > @@ -143,6 +143,28 @@ static void virtio_pmem_remove(struct virtio_d=
evice *vdev)
> > > >         virtio_reset_device(vdev);
> > > >  }
> > > >
> > > > +static int virtio_pmem_freeze(struct virtio_device *vdev)
> > > > +{
> > > > +       vdev->config->del_vqs(vdev);
> > > > +       virtio_reset_device(vdev);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int virtio_pmem_restore(struct virtio_device *vdev)
> > > > +{
> > > > +       int ret;
> > > > +
> > > > +       ret =3D init_vq(vdev->priv);
> > > > +       if (ret) {
> > > > +               dev_err(&vdev->dev, "failed to initialize virtio pm=
em's vq\n");
> > > > +               return ret;
> > > > +       }
> > > > +       virtio_device_ready(vdev);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  static unsigned int features[] =3D {
> > > >         VIRTIO_PMEM_F_SHMEM_REGION,
> > > >  };
> > > > @@ -155,6 +177,8 @@ static struct virtio_driver virtio_pmem_driver =
=3D {
> > > >         .validate               =3D virtio_pmem_validate,
> > > >         .probe                  =3D virtio_pmem_probe,
> > > >         .remove                 =3D virtio_pmem_remove,
> > > > +       .freeze                 =3D virtio_pmem_freeze,
> > > > +       .restore                =3D virtio_pmem_restore,
> > > >  };
> > > >
> > > >  module_virtio_driver(virtio_pmem_driver);
> > > > --
> > > > 2.46.0.76.ge559c4bf1a-goog
> > > >
> >
> >

