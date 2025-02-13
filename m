Return-Path: <linux-kernel+bounces-513772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFBFA34E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCB33A9B88
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0579245B1A;
	Thu, 13 Feb 2025 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S2X13KZ0"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F52D28A2CE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739475139; cv=none; b=gQnm1AdL6MY/70UVtKVf9ZQfS+9NpqmLNB8OfbbeCjLqqy406uByPC80dYUYfZbJUrHzghbtFd2UY/cLxXE+sr7O5UM+RZ7y32OaG6dQRViiaXwUcJJ3Yam4loocoCXhd/LpSvF98j+/E1UL6wh9wuNSgjQ+5Sy17DjutNYYf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739475139; c=relaxed/simple;
	bh=vN3xU5PUlBtz0G8Jkp9LPRqLUaC4SYRlG+96xxoP57k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYUN8HMYfvAIubuD8ON5SqT/N5z9Z1DwHKGzvZh9A9bbSk7xdU/4jzto9yoCxEco3z4a3qmSr5JtTnsva4Aa4nkLKS+pmxP8BxGKL9Jxd1Vio/45oLXYIVt9O2SAgXzRkak6kUQDEHCsuv7DiE/XGzgCDU0N75OCf16mwJVDCZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S2X13KZ0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220ea8ed64eso508445ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739475136; x=1740079936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHPT8j19eeATQvpAXIQ4iMz+8wtwWzqZEPxJSsWFp70=;
        b=S2X13KZ0dkyTrWvaM7CB9faTeO1FqEnVjgsELnklfPTLXhVnka5E4ftOqglknn2VBy
         P3NHl6GTFSWsB7MI28Zov7HHANxwSa6jiXWAwFHPVrS0FgO2FhayLxY5CWpnWFEXJ4Fi
         XUpOa1TBFeuQ1IVvsW5+xXzYB1KLb6geGCbAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739475136; x=1740079936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHPT8j19eeATQvpAXIQ4iMz+8wtwWzqZEPxJSsWFp70=;
        b=aJYkrO5K3cj/3mmM/rVGRNNu8JoaglDG0bX2Kmxtap1hMxtIAfy0y7YCMn4FVYbQr6
         2roF+IAlfHfjWimEZzY7VQM3CCWDkukSMViNjDKVQ5NYX1QD6jK7VlnIsaqehRAwI2wG
         0qo2cxj8uMOQQB/vlyGE5nns1wAoaY7NORHs4IKWJfdyjuXpOrPAHGdP+dMx9Z0CYpQ3
         YAQbLBjnURTsz3RntRFcXQzbdOw5BfM2IW5VgKXkqIAxWt7QC9oG6ZjioS/PBJKurRFN
         cH0kFrBcI2CDoBHo4ZqIEgtfeFFGTV9xp/mDVddjFRRW7ZuU25gcfA82kgEtZnLKR6ID
         YjVg==
X-Forwarded-Encrypted: i=1; AJvYcCUFxd4XZ2pi2v0p1KV5t+F5kxd7eLofYhqMI2cytqlL2bvNXWwimIkLUacMiPg9gHXrgoL7s/7upzYpLPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcISYuAXrwRbpADSRzo9vjBdvZtmEKpswKgRkYLEgcCkQh3jo/
	8uT2VtOC20Gqq6uek+h66K1Al9gVeUCo2UNwLf5i6a0t5nL5Ls5LLtjO+dZj2uEIusfaTNaPOx0
	6tQ==
X-Gm-Gg: ASbGncv/MdOWMZpI9ZXUGs4P+5uWbrJWU5ZyxRsX6/9pAF2x8Fks6OCFZnmJhHhmIKh
	p7XCRvYNgJrSXZN6wh2jAMQsTH8Vid4Rui9/jcJua/Nf5OVljRz3TDUO4Hcgg2tg7kPh0x1IJ5Y
	E+GrMJEmqCEXlvZ6OHp372eLJYEXurnZ07eQKB0xdNqMu29EbHvs80uHlfNezpvoWUqJdBIXtqX
	+7qqsrBWqBOwoIpMoT9nucdLsnz1DplZ51LV4A/kmTftAfyy2dcJKyANBqbYdmftT6IQOk57uW2
	hi+leoV/DbDiRycAz5d2D+c7TUUulXWq7khA7Fqm4T3bAa8ZlGuMw9L9EVU=
X-Google-Smtp-Source: AGHT+IF44iKUkMdvRMinOPPaHfl0bnYUPohV6e4Sm6hrg733dWNwZvDSQRyVP1hi86pINUi6p2jV1w==
X-Received: by 2002:a05:6a00:c93:b0:730:83c1:1f79 with SMTP id d2e1a72fcca58-7324f6053c8mr41671b3a.3.1739475136487;
        Thu, 13 Feb 2025 11:32:16 -0800 (PST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com. [209.85.214.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242580889sm1656516b3a.83.2025.02.13.11.32.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 11:32:15 -0800 (PST)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220c8eb195aso23997265ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:32:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4/peSYMUGOfsTyWeM9WNbsRLqYReY7rfQn8Kb1eWxeu2TMrYvVZMCYnoMDPxFmokIUCxgHFiZrI3WL3g=@vger.kernel.org
X-Received: by 2002:a17:902:da92:b0:21b:b3c9:38ff with SMTP id
 d9443c01a7336-220bbc5a245mr127466175ad.37.1739475134479; Thu, 13 Feb 2025
 11:32:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com>
 <20250213-virtio-shm-page-size-v1-3-5ee1f9984350@redhat.com> <CABVzXA=r=X+GYnSxgeyktKzfKCW2DW+v++c4v_+BHBDHZ_Bzyw@mail.gmail.com>
In-Reply-To: <CABVzXA=r=X+GYnSxgeyktKzfKCW2DW+v++c4v_+BHBDHZ_Bzyw@mail.gmail.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Thu, 13 Feb 2025 11:31:47 -0800
X-Gmail-Original-Message-ID: <CABVzXAkFPr-GiALnk2v53CzX0b5Y0yG=KoRoOFR7fy98Xeyb3w@mail.gmail.com>
X-Gm-Features: AWEUYZk5k0yVhKRl6x_CJTphuuoRNXkv7QK8mgqxAE6j9hp4qpFVaj_QTvwQhdQ
Message-ID: <CABVzXAkFPr-GiALnk2v53CzX0b5Y0yG=KoRoOFR7fy98Xeyb3w@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] virtio-pci: extend virtio_pci_cap to hold page_size
To: Sergio Lopez <slp@redhat.com>
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

On Thu, Feb 13, 2025 at 11:22=E2=80=AFAM Daniel Verkamp <dverkamp@chromium.=
org> wrote:
>
> On Thu, Feb 13, 2025 at 7:54=E2=80=AFAM Sergio Lopez <slp@redhat.com> wro=
te:
> >
> > Turn the 16 bit padding into a page_size field to allow the device to
> > pass its required page size with format PAGE_SIZE >> 12.
> >
> > Signed-off-by: Sergio Lopez <slp@redhat.com>
> > ---
> >  drivers/virtio/virtio_pci_modern.c | 29 +++++++++++++++++++++++++----
> >  include/uapi/linux/virtio_pci.h    |  2 +-
> >  2 files changed, 26 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio=
_pci_modern.c
> > index 79616ce5057bf3b2b88cae7e8fb7729efa9dd632..26e9cd5148c0f10209c34d1=
2e65d64490a855d75 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> [...]
> > +               if (__virtio_test_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE)) {
> > +                       pci_read_config_word(dev, pos + offsetof(struct=
 virtio_pci_cap,
> > +                                                                page_s=
ize), &res_psize);
> > +                       if (!res_psize) {
> > +                               dev_err(&dev->dev, "%s: shm cap with in=
valid page size on "
> > +                                       "a device with VIRTIO_F_SHM_PAG=
E_SIZE feature\n",
> > +                                       __func__);
>
> Maybe this should also constrain the page size to be a power of 2?
>
> [...]
> > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virti=
o_pci.h
> > index 8549d4571257142ac6c9dad5c01369923791a85a..fb0ccb7a125d8178c1f7833=
3c4d2f43540e1764b 100644
> > --- a/include/uapi/linux/virtio_pci.h
> > +++ b/include/uapi/linux/virtio_pci.h
> > @@ -127,7 +127,7 @@ struct virtio_pci_cap {
> >         __u8 cfg_type;          /* Identifies the structure. */
> >         __u8 bar;               /* Where to find it. */
> >         __u8 id;                /* Multiple capabilities of the same ty=
pe */
> > -       __u8 padding[2];        /* Pad to full dword. */
> > +       __u16 page_size;        /* Device page size (PAGE_SIZE >> 12). =
*/
>
> This comment should probably clarify that the page_size field is only
> valid when cfg_type is VIRTIO_PCI_CAP_SHARED_MEMORY_CFG, assuming
> that's the case. Or should the device be expected to provide the
> page_size for all capabilities regardless of type?
>
> It seems like the name should also ideally make it clearer that this
> is page_size/4096 rather than the actual page size to avoid confusing
> device implementers.

Alternatively, this could be represented as a single u8 page_shift,
where page_size =3D 1 << (page_shift + 12), and then existing devices
would "just work" (assuming they filled the padding with 0). It is
probably still a good idea to guard it with a feature bit, though, so
it doesn't really make that much difference.

Thanks,
-- Daniel

