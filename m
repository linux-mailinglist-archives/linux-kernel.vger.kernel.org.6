Return-Path: <linux-kernel+bounces-514669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55FBA359F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 396927A1E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82AB22D7A9;
	Fri, 14 Feb 2025 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL6xd6/F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C8B22D79A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524421; cv=none; b=YPDTc1xtAGFc1uLT8MYmr8rq2wxntR1zZdnUj7J/p7IugE7MqvdC5fmIlC3NOjZ+S1lj2pGMM4RmqNtXtdrkSlIgxNTow04MggHjMnDsMZZHB+2wz7ZOZ45c4/XpO0OTmeJCXXU3yTkTBNDS3PWg8X845njkMmsRuONzpJgbK/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524421; c=relaxed/simple;
	bh=c2bKQPYo9tYpcciFCfCYFVVyaMXybQgfoIFS3LMZaek=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoWBBlE6Wn+gadxnJW/PWjidBgaZ93e5OdamKtTWKSa0FTE8dbG7+k7Uu9kKldygph3T2V/fBXVOpIwq13GG8yk2Lknc6kADr/ezHL71aljnsbMhPBYHJxFAClSQ0PxI5wXsyxnvjBIx3cN7h4ZlpPz0w/iNqXdkBc/sfiOoPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OL6xd6/F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739524418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhQbOMy8+GzTi4lxjceqncwBz0c2/iKXPxAWUqDq8Jg=;
	b=OL6xd6/FMuuisDcLeqc9RGGEnKaU9mQVDeiVhuj7bqVjiZSw68XD3WDfXRX9OvpYo+GLji
	5laFNY+vX1cnYCq6L8POXrgg0qgnqomG3BNWoqOarIU/D1LwNM4p1VQfKKOwPBD9Hioomw
	VrMcjEjuIjCkmi64Nwy8pl5oFQe1lrU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-TOlgeeTuMVut1HpIovu9wg-1; Fri, 14 Feb 2025 04:13:37 -0500
X-MC-Unique: TOlgeeTuMVut1HpIovu9wg-1
X-Mimecast-MFC-AGG-ID: TOlgeeTuMVut1HpIovu9wg
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc1e7efdffso4315948a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524416; x=1740129216;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zhQbOMy8+GzTi4lxjceqncwBz0c2/iKXPxAWUqDq8Jg=;
        b=Pj5lUCXNA6lfCvjtxK4m9RFWWhEKqPB3INDlDpIIXt5HowqWyE8ggMdAzcKa/rCJzB
         PIL3Rqkv1a9ipnsfg0RrDLiDllMhY3pG0HWUNQkQSfp0HbIQUl6TqOxasR64VGOBjKpP
         VLBBJGrjJF3zSIyRcB8MbAuYxa3kjyJ5502AvztfUHeKBXha5ox9BJEzImNzLL/vHMP9
         jI83p46Pbplx1iMzTYVENKa60WGmC7Jg3/BIjJtIxZNurMIn72p1Es4anRV/srUrIhPP
         lds/9D4t/6O52g0A5OqyB3BFhsedTRcW8bsd7u1fr3/E+KEo/Ij+xIGVv1RFAWplXp0B
         3tFA==
X-Forwarded-Encrypted: i=1; AJvYcCUtoGC5c7I4ZVWQ6DLOpH67PMGWkCZoLDjBBPDK8Ht5aUMi7frXPoEHPQuBdXtlyUV9v9yQrwJmv9HwY6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYkxXOwrqxw76DiZ5oc0v5HtiCB1IbncvxhGkKmufgAIrtJmc
	nPMjsDCktIC+5wm/hwbIcBW2crYBp1tmp9pJznKEu5Qs8XRXh3f00QbbE6ID0uAaQzF26UHM788
	CFftJu5O61vcoSxisZf8mReAN76gadRDVd6wuXZ+Fzm1CB3Ma545Q7dw112jR3G9BM0G8N38E2i
	seJ3KM3KWn8htqMbZQHlJjFI/sPYZXl1JaL2f1
X-Gm-Gg: ASbGnctQ42GRDBomAjD58YQ9B/a438anpuvDZMjzAl8iCnB3a+AuPFjEt+f0vYfL/k2
	qzu/Iep6upfZU+1Fj9F78GH7aQ1JYTBNh0cOZMJhvgCZzFNtr0EykVlcYUg==
X-Received: by 2002:a17:90b:5108:b0:2ea:a25d:3baa with SMTP id 98e67ed59e1d1-2fc0decea17mr9715221a91.5.1739524416373;
        Fri, 14 Feb 2025 01:13:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPjo8jgtMHBDLzBP7QJE/fw8dRdYz3BXgwyJ4HUWTCvNtTSRgFZS9D1zgj8trFg+27pY2Nw3L5Um8vBjoQvM8=
X-Received: by 2002:a17:90b:5108:b0:2ea:a25d:3baa with SMTP id
 98e67ed59e1d1-2fc0decea17mr9715176a91.5.1739524416083; Fri, 14 Feb 2025
 01:13:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Feb 2025 01:13:35 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <CABVzXAkFPr-GiALnk2v53CzX0b5Y0yG=KoRoOFR7fy98Xeyb3w@mail.gmail.com>
References: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com>
 <20250213-virtio-shm-page-size-v1-3-5ee1f9984350@redhat.com>
 <CABVzXA=r=X+GYnSxgeyktKzfKCW2DW+v++c4v_+BHBDHZ_Bzyw@mail.gmail.com> <CABVzXAkFPr-GiALnk2v53CzX0b5Y0yG=KoRoOFR7fy98Xeyb3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Feb 2025 01:13:35 -0800
X-Gm-Features: AWEUYZlFdNHXiXC67hDCe7uvDGJZv05mhOU5Gr2Fjb2yYXvv8J_67e4Yb22V8Nc
Message-ID: <CAAiTLFX6kNtuqWCk5qCVqCLUgNxB8yTKis0gBPKHiyNVr3a_GA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] virtio-pci: extend virtio_pci_cap to hold page_size
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, fnkl.kernel@gmail.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Daniel Verkamp <dverkamp@chromium.org> writes:

> On Thu, Feb 13, 2025 at 11:22=E2=80=AFAM Daniel Verkamp <dverkamp@chromiu=
m.org> wrote:
>>
>> On Thu, Feb 13, 2025 at 7:54=E2=80=AFAM Sergio Lopez <slp@redhat.com> wr=
ote:
>> >
>> > Turn the 16 bit padding into a page_size field to allow the device to
>> > pass its required page size with format PAGE_SIZE >> 12.
>> >
>> > Signed-off-by: Sergio Lopez <slp@redhat.com>
>> > ---
>> >  drivers/virtio/virtio_pci_modern.c | 29 +++++++++++++++++++++++++----
>> >  include/uapi/linux/virtio_pci.h    |  2 +-
>> >  2 files changed, 26 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virti=
o_pci_modern.c
>> > index 79616ce5057bf3b2b88cae7e8fb7729efa9dd632..26e9cd5148c0f10209c34d=
12e65d64490a855d75 100644
>> > --- a/drivers/virtio/virtio_pci_modern.c
>> > +++ b/drivers/virtio/virtio_pci_modern.c
>> [...]
>> > +               if (__virtio_test_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE)) {
>> > +                       pci_read_config_word(dev, pos + offsetof(struc=
t virtio_pci_cap,
>> > +                                                                page_=
size), &res_psize);
>> > +                       if (!res_psize) {
>> > +                               dev_err(&dev->dev, "%s: shm cap with i=
nvalid page size on "
>> > +                                       "a device with VIRTIO_F_SHM_PA=
GE_SIZE feature\n",
>> > +                                       __func__);
>>
>> Maybe this should also constrain the page size to be a power of 2?
>>
>> [...]
>> > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virt=
io_pci.h
>> > index 8549d4571257142ac6c9dad5c01369923791a85a..fb0ccb7a125d8178c1f783=
33c4d2f43540e1764b 100644
>> > --- a/include/uapi/linux/virtio_pci.h
>> > +++ b/include/uapi/linux/virtio_pci.h
>> > @@ -127,7 +127,7 @@ struct virtio_pci_cap {
>> >         __u8 cfg_type;          /* Identifies the structure. */
>> >         __u8 bar;               /* Where to find it. */
>> >         __u8 id;                /* Multiple capabilities of the same t=
ype */
>> > -       __u8 padding[2];        /* Pad to full dword. */
>> > +       __u16 page_size;        /* Device page size (PAGE_SIZE >> 12).=
 */
>>
>> This comment should probably clarify that the page_size field is only
>> valid when cfg_type is VIRTIO_PCI_CAP_SHARED_MEMORY_CFG, assuming
>> that's the case. Or should the device be expected to provide the
>> page_size for all capabilities regardless of type?
>>
>> It seems like the name should also ideally make it clearer that this
>> is page_size/4096 rather than the actual page size to avoid confusing
>> device implementers.
>
> Alternatively, this could be represented as a single u8 page_shift,
> where page_size =3D 1 << (page_shift + 12), and then existing devices
> would "just work" (assuming they filled the padding with 0). It is
> probably still a good idea to guard it with a feature bit, though, so
> it doesn't really make that much difference.

I actually considered not using a feature bit and just behave like this,
but then I've noticed that, for the mmio transport, it would mean
reading from a new register. Some VMMs may overreact to the unexpected
read and crash or, even if they don't, it's not guaranteed they aren't
going to return garbage in response. So I think it's better being a bit
conservative and protect the behavior behind a feature bit.

Thanks,
Sergio.


