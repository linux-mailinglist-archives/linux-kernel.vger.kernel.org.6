Return-Path: <linux-kernel+bounces-296171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61F395A69D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4618C1F22C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9B4175D34;
	Wed, 21 Aug 2024 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JjRPNQsv"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2529D170826
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275873; cv=none; b=gtzWjTo4w+yCNoN7nP73Pe61S2ID5UczqbZtckCReVLpeUTyCV/y4rK4uG0APCSFYKQl85NgBpufBjjbQMUYOG5W+SqI1l1miSxwx7fZbZ27JAHlcnqj3NeKIT50qMimOj/qqw+NJOrysZNHq4jek9b82NcK4ATNvvABf0Gt5is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275873; c=relaxed/simple;
	bh=1HPbXZu26ylIr+VTL5kVcyFAqWx6XVIzYfT9vJGT7f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPXybKbb24EaSd3CoVwjBc6Es6piiWJM/bxEH5wkGpWc9B0iR9FAqzFydDyv3sbKkEUPfhCOXAHxKAZEySjUdGJjuarTF7OT9pVhSpm1w5015srSHB/LXNZjb8qGsl1P4gzRKWJtsnUroilRh2rnNiKRYcrLTZMMe2Dh9pBD0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JjRPNQsv; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf7f4a133aso369526d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724275871; x=1724880671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwfXYtq5H/Bwl31FSzM7tg0skZKB1oDTQ8t4Qt6Xu7Q=;
        b=JjRPNQsvOmHwUPp/S9APvXPiGY3dpBCW16lWa2ikP+PjWYj/Kzp/kqg2QEUoRlEIXS
         YryJCejLVxsHMWIUfqrReBteANaas/r9OqW6MUhzc3wskxnkxA0dAhAvpvtF92q9u36+
         bFmgk+tFx0WXaHvbiJtX6yc3u/1guw2TTXd/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275871; x=1724880671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwfXYtq5H/Bwl31FSzM7tg0skZKB1oDTQ8t4Qt6Xu7Q=;
        b=Rkty6R0NzzNlonz3BJo8Q8/UtVNCofbpqMQw0rXQk2i3GWm6UNHQ7EDP+9bpUnuBFR
         Aj+oJOZAVKiPqK0GvcJebVvfG3iIsdymnwcrCYDEAp4FKRdJnUGNfWBGpBOWQs8cMBuQ
         hTmpJpYqYhUMKsAjlmsIevE7N9repqr7RLR9Rx04AMpo/Lo2zUwzx+j1xqyMOxEDWYUr
         2pW0iG/gwxctvbs5JPduYPRmw6dW0VNlnbkeiazTZdOFyEbUnqlKtaR28YtTWaRjICRR
         Cuj4Ktch4LIDQriCQxnzkMRVV/5E0t+CtrVyByQGeZmflgsnD4hJO3EcdBTUXIBxlaup
         qBXw==
X-Forwarded-Encrypted: i=1; AJvYcCW4ovQR31eIVB6ReSmN+D1Wk2Pjxr+8E40iGlzMVkI4YcPlKPll8u6byRGqFVHWuS3WCqN/3RkTpll01E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRRLUAO6Y+jzvic9ciumbW+/3pL1wFu1WgWO6zbOlQbpgG71Ey
	INvMComFP7NB/RZfDw4zpvvOWOMjKayrvUxugwAry54Iy/08qVlBtgpOTfC2WDw+n4G7ZLFV70n
	CUuK9dn0XtoL0/6PEtduFbzZr+4uDy5CWsBJg
X-Google-Smtp-Source: AGHT+IF/2t26ymLl1453TNbuqayvZbqevzagzBm58wCHeO+njmSvYDXpCN0QjxbJ2OFbF/nJXJO4NU7h/01hnI5dBhI=
X-Received: by 2002:a05:6214:4185:b0:6b7:ab98:b8b4 with SMTP id
 6a1803df08f44-6c15688e06fmr41700066d6.48.1724275870748; Wed, 21 Aug 2024
 14:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820172256.903251-1-philipchen@chromium.org>
 <46eacc01-7b23-4f83-af3c-8c5897e44c90@intel.com> <CA+cxXhnrg8vipY37siXRudRiwLKFuyJXizH9EUczFFnB6iwQAg@mail.gmail.com>
 <66c6501536e2e_1719d294b1@iweiny-mobl.notmuch>
In-Reply-To: <66c6501536e2e_1719d294b1@iweiny-mobl.notmuch>
From: Philip Chen <philipchen@chromium.org>
Date: Wed, 21 Aug 2024 14:30:59 -0700
Message-ID: <CA+cxXhnb2i5O7_BiOfKLth5Zwp5T62d6F6c39vnuT53cUkU_uw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_pmem: Check device status before requesting flush
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	virtualization@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Aug 21, 2024 at 1:37=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> Philip Chen wrote:
> > Hi,
> >
> > On Tue, Aug 20, 2024 at 1:01=E2=80=AFPM Dave Jiang <dave.jiang@intel.co=
m> wrote:
> > >
> > >
> > >
> > > On 8/20/24 10:22 AM, Philip Chen wrote:
> > > > If a pmem device is in a bad status, the driver side could wait for
> > > > host ack forever in virtio_pmem_flush(), causing the system to hang=
.
> > > >
> > > > So add a status check in the beginning of virtio_pmem_flush() to re=
turn
> > > > early if the device is not activated.
> > > >
> > > > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > > > ---
> > > >
> > > > v2:
> > > > - Remove change id from the patch description
> > > > - Add more details to the patch description
> > > >
> > > >  drivers/nvdimm/nd_virtio.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.=
c
> > > > index 35c8fbbba10e..97addba06539 100644
> > > > --- a/drivers/nvdimm/nd_virtio.c
> > > > +++ b/drivers/nvdimm/nd_virtio.c
> > > > @@ -44,6 +44,15 @@ static int virtio_pmem_flush(struct nd_region *n=
d_region)
> > > >       unsigned long flags;
> > > >       int err, err1;
> > > >
> > > > +     /*
> > > > +      * Don't bother to submit the request to the device if the de=
vice is
> > > > +      * not acticated.
> > >
> > > s/acticated/activated/
> >
> > Thanks for the review.
> > I'll fix this typo in v3.
> >
> > In addition to this typo, does anyone have any other concerns?
>
> I'm not super familiar with the virtio-pmem workings and the needs reset
> flag is barely used.
>
> Did you actually experience this hang?  How was this found?  What is the
> user visible issue and how critical is it?

Yes, I experienced the problem when trying to enable hibernation for a VM.

In the typical hibernation flow, the kernel would try to:
(1) freeze the processes
(2) freeze the devices
(3) take a snapshot of the memory
(4) thaw the devices
(5) write the snapshot to the storage
(6) power off the system (or perform platform-specific action)

In my case, I see VMM fail to re-activate the virtio_pmem device in (4).
(And therefore the virtio_pmem device side sets VIRTIO_CONFIG_S_NEEDS_RESET=
.)
As a result, when the kernel tries to power off the virtio_pmem device
in (6), the system would hang in virtio_pmem_flush() if this patch is
not added.

To fix the root cause of this issue, I sent another patch to add
freeze/restore PM callbacks to the virtio_pmem driver:
https://lore.kernel.org/lkml/20240815004617.2325269-1-philipchen@chromium.o=
rg/
(Please also help review that patch.)

However, I think this patch is still helpful since the system
shouldn't hang in virtio_pmem_flush() regardless of the device state.

>
> Thanks,
> Ira
>
> >
> > >
> > > > +      */
> > > > +     if (vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_NEEDS_RE=
SET) {
> > > > +             dev_info(&vdev->dev, "virtio pmem device needs a rese=
t\n");
> > > > +             return -EIO;
> > > > +     }
> > > > +
> > > >       might_sleep();
> > > >       req_data =3D kmalloc(sizeof(*req_data), GFP_KERNEL);
> > > >       if (!req_data)
>
>

