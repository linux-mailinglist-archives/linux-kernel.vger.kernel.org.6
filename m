Return-Path: <linux-kernel+bounces-336128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131F497EF81
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA837280DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1BF19F111;
	Mon, 23 Sep 2024 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E+TEjqHM"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0FE13D625
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110081; cv=none; b=QqTn8SVSesEi6OA55RYizbm0O904HhPb1EVg/McQPTgzNDleXK3jkPuq0RrzAs2tbWj4fqqRiszfGyUXlk7U0kAzF91fpSl7dCKO+kfdlJQCtoAi5ARwhZKsiIMxh31UiLioluWqGgfKaD9MY+Z0lvTBNcDuS2zEDX8zOJdMYkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110081; c=relaxed/simple;
	bh=/p30FrVYVuYfEnt6kv72Q1UcFg9YJf1SQEiA395yPXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBHn7dscPtfsgD0e6SZH3Qu44VEVSMnUWOZUtnPJLvDUUxcb3wps6umHk4Qg8waVcDD278W0CupFCII1r51khj6XsZ24pdZ+NQ7WRqDGOfVblHjolx1l4q2FxI7LPDwXSJYI08UNDYSVjTRDD8rugFGc05wFD7kxskxlW5HGg4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E+TEjqHM; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c354415c19so33861516d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727110079; x=1727714879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jkCqUIg3Xe8RRG1JyAgfDxC/SwDY13wlpSpEmGTb8k=;
        b=E+TEjqHMKv3x5ugJyyL+OmEu/00vAcMVBRYLDiEYIGy0/JFy5jHnrNwMB7JX8c79hi
         QOm8my84uosjQpS95oSHx7Dkyb6Br5nVy2EDwDgYCdEa/uvT4Tig6CcjzRMHzU+I7Cq8
         I8rQh0qeFR85O6s3L3qYpJa+GLU3RmDHETfXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727110079; x=1727714879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jkCqUIg3Xe8RRG1JyAgfDxC/SwDY13wlpSpEmGTb8k=;
        b=NjWIzuHY45bXTSgMnBpJLw4QLwMGBkhgnlvZjVCSBTkd/+E+sYaU13bUu2KYJI9BjF
         AXfSwpKR2CF+8+xzqrEqNTyh7vZIazm49hDD63gPawXr6yGqu+56V5axf4LygjLNnJsY
         QbTIeLKpspRed1rSfbCnqUjYu0FxdqO5M+H5RTTAH8/wPMmfTfYL5DPk3c1ppBHD6n8z
         9wS04PeRau9eiZ6bSiHHnSwY5U/S9Af3kPIc5Q97VpI25nxyJ8cq7G7CvlV31xa3l0V0
         8vE5pCAJYspBiVyh8/sLx8Sjr2jPHcEeTAddnXwqekfpuwvtX4njB0nL5+ImsKbxLb7B
         lfjA==
X-Forwarded-Encrypted: i=1; AJvYcCWzlJp2ETFVyRukmuAr5R2v3GzW3O6sNKihvZNJu9RhT4yfOHsx8QzLLCNDDr7/g7cOwrtoLXsyHO5VxzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMCD3JXzY1AIqyOgVGlLhGPeDmIFGwniHnnsISsqyRrj+5Gc+U
	G0zxKwLGb/Da0JgeEstwEjsLc1P3xtqe1qRaYNDccCdycQOTAa2JDFVmK2u6ba1o9jdVZ2KPbiI
	+IZ4pvnX5gISEGPGld3XXMWzlnS12AovCBJU+
X-Google-Smtp-Source: AGHT+IG2yd0efpRRzhPAk2QTdSce9Tjc0IthclvMuhkAgRnoOsrG4G3REAz+LXZA408Gybkvd7KwLETYZ59qfR+vU8Q=
X-Received: by 2002:a05:6214:469b:b0:6c3:6a68:499f with SMTP id
 6a1803df08f44-6c7bc73066bmr168626116d6.19.1727110078647; Mon, 23 Sep 2024
 09:47:58 -0700 (PDT)
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
From: Philip Chen <philipchen@chromium.org>
Date: Mon, 23 Sep 2024 09:47:46 -0700
Message-ID: <CA+cxXhmnsysKE-pTCkx38U5r+ofM6_2nFS5R1_rW3p3FbmiSLw@mail.gmail.com>
Subject: Re: [PATCH] virtio_pmem: Add freeze/restore callbacks
To: Ira Weiny <ira.weiny@intel.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	virtualization@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi maintainers,

Are there any other concerns I should address for this patch?

On Mon, Sep 9, 2024 at 4:52=E2=80=AFPM Philip Chen <philipchen@chromium.org=
> wrote:
>
> Hi
>
> On Wed, Sep 4, 2024 at 10:54=E2=80=AFAM Ira Weiny <ira.weiny@intel.com> w=
rote:
> >
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

