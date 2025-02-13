Return-Path: <linux-kernel+bounces-513770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60EFA34E78
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E5716C669
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1493245AF6;
	Thu, 13 Feb 2025 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TG3HaU5B"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A428A2A6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739475040; cv=none; b=H9MMjgnw/emhyPTjXgcnZYJTS+IY3O+BrnZ1stVwnRG1gSsi4RqFs8tCbybmBienTtA8awus3xMEW283IX6C37/S6sO/ko9s//0pIJWObHMXNO98kpi2jqWdjv4fzLvn1Z5+KV4F/WgrSC9A1GLCyIXBrCutoJjuXXY1OqdbK9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739475040; c=relaxed/simple;
	bh=M3Xtj7RQJ68uhGe29VzgQq5XlLmgymGY4bXdENOCD3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTeQyCZB3gsO6WpZj6z+NaI4D9W2zLJKFdy00MbennP0c8bVnJMV0FL4OjNg+6oXs2GcNF3IH2L0cBXmUYZc3fobX2F5uJudlcXYxFgawpuqpTWrcfLV/MvUsLtOE9XtM6aMouJd1r3p2LBLlwQ2MJkCviqWYNzIr5IBNZXr/xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TG3HaU5B; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5fcb00ae5edso26651eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739475037; x=1740079837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC+znPA2H1vB7HU6VZGH/VUzzp6EPafRFN/wfL/kwkY=;
        b=TG3HaU5B3NHNVDypwQ8TEP3h/ytDcogcAYp/fGIALKEcydUiOCTlIuvxL+8mMkiy/s
         hBkJZdDAgqhXKgvncAcyM3AayVR+F6lEX5dLmoUb/rh/XurYrnF+p7teIAhy90swY/t2
         7jOPS6JIXWJiwV0T8s1kdrs+JiTkjkoAMb6k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739475037; x=1740079837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KC+znPA2H1vB7HU6VZGH/VUzzp6EPafRFN/wfL/kwkY=;
        b=iOQO3keSNGr2UrPpdG2vG7Mpabl5iPkj9qg9h2EGRNVGZgnKKHiNv3CyYgZW2JLbD6
         3blEPY3voKlMcclEMmUcRMzVN5UEZTHU4jamxf6tp2LXy9DnLxx18Tm7G9UB+NCojwhJ
         0Y4dBy9aj64TqPWY8ZmuYt3k3J7Qe4xu2OXUr/ISBNeSXkxn2H6ld0dlJ9+zAHF3Jc5o
         QO+x4wzLAPmGsSn0Q+hEjeUPcGUm5xzvWU4zuh/Fd2nRmicYSF2ubd+FadimGzTfAlNT
         SRI8LqGtmyZmyG+VAIAJo+5xSpVPVDrneYmRZ8nSv3I1bl/A75m7jQqlugOAb2l8Ux85
         L7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUUMB95E2y0iMB6b92XdfBk+YveejPb4qfVVJ8zCOZOSkp57X/Sry+EbQ2REks6BDbSgX/tUca8c7w6PYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YziQzStrKcSIQ+44NBsdNkK5FWU0+ahchl+quw5v2bMBZQE80Dc
	7A3AxkbcPolMn1WEATeQqvUIAlFHQ//xGaOnuyjJS2TN1/5gseM/3rXmEBcpqjJsHhNspBpIoIv
	Dzg==
X-Gm-Gg: ASbGncvXniG2R5fVwUCvTT1I05v3hhTK0B/l2d3aZopi2iI8x4KSw2OOVQ2hjq2uImN
	Q4NpW76Pd6GI97ht1BKiFIMiv0EJMzFFw2zc0RWtF7rujknBBTyMkfzLkJpLCzsqcpN+GzpW3FP
	eqKJvifWELKhEdD9wTMxchWoqW3VVf/dSOXTtF/sa2bmC7OnhJpojJ1PmygPTwD2SUJMd/+E3eZ
	C7lF8a9OK0NacZLSQnpp3h+9VjpHIavymCTJOiI8kbBEfETW/ZK2IRrGuUqtRmcadMFtu889tQC
	pvGWttmnndmXG8pW8zstuFKIKR4A7atbmmUoeiNqtVLl5Y73jTJ7Ves=
X-Google-Smtp-Source: AGHT+IHy7BfKBEyVj40kyJZXDjYaGW3VfZn1rtl3M6sdQStOmMG0Lw5pPaSiVruRg7wU8jdT+UG2tw==
X-Received: by 2002:a4a:d8d9:0:b0:5fc:a870:d84e with SMTP id 006d021491bc7-5fcbadd9ebamr64481eaf.1.1739475037312;
        Thu, 13 Feb 2025 11:30:37 -0800 (PST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb16a5a5csm783759eaf.9.2025.02.13.11.30.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 11:30:36 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-726819aa3fcso792177a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:30:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDl0Y121tsClaA4AYH4RKStPhVJerzxYJuzpPPQi40/R9t+pMLnP73FQIr1S48xUWLkDfVnWkeIvkYQMs=@vger.kernel.org
X-Received: by 2002:a17:90b:274e:b0:2fa:17d2:166 with SMTP id
 98e67ed59e1d1-2fbf5c6f900mr11663838a91.31.1739474591586; Thu, 13 Feb 2025
 11:23:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com> <20250213-virtio-shm-page-size-v1-3-5ee1f9984350@redhat.com>
In-Reply-To: <20250213-virtio-shm-page-size-v1-3-5ee1f9984350@redhat.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Thu, 13 Feb 2025 11:22:45 -0800
X-Gmail-Original-Message-ID: <CABVzXA=r=X+GYnSxgeyktKzfKCW2DW+v++c4v_+BHBDHZ_Bzyw@mail.gmail.com>
X-Gm-Features: AWEUYZnbyEFvCjOaJipQpOfb1MF9Gi7XhI32b8q-z-30QmKnx8ZNHSfRGuJzTvI
Message-ID: <CABVzXA=r=X+GYnSxgeyktKzfKCW2DW+v++c4v_+BHBDHZ_Bzyw@mail.gmail.com>
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

On Thu, Feb 13, 2025 at 7:54=E2=80=AFAM Sergio Lopez <slp@redhat.com> wrote=
:
>
> Turn the 16 bit padding into a page_size field to allow the device to
> pass its required page size with format PAGE_SIZE >> 12.
>
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 29 +++++++++++++++++++++++++----
>  include/uapi/linux/virtio_pci.h    |  2 +-
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_p=
ci_modern.c
> index 79616ce5057bf3b2b88cae7e8fb7729efa9dd632..26e9cd5148c0f10209c34d12e=
65d64490a855d75 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
[...]
> +               if (__virtio_test_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE)) {
> +                       pci_read_config_word(dev, pos + offsetof(struct v=
irtio_pci_cap,
> +                                                                page_siz=
e), &res_psize);
> +                       if (!res_psize) {
> +                               dev_err(&dev->dev, "%s: shm cap with inva=
lid page size on "
> +                                       "a device with VIRTIO_F_SHM_PAGE_=
SIZE feature\n",
> +                                       __func__);

Maybe this should also constrain the page size to be a power of 2?

[...]
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_=
pci.h
> index 8549d4571257142ac6c9dad5c01369923791a85a..fb0ccb7a125d8178c1f78333c=
4d2f43540e1764b 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -127,7 +127,7 @@ struct virtio_pci_cap {
>         __u8 cfg_type;          /* Identifies the structure. */
>         __u8 bar;               /* Where to find it. */
>         __u8 id;                /* Multiple capabilities of the same type=
 */
> -       __u8 padding[2];        /* Pad to full dword. */
> +       __u16 page_size;        /* Device page size (PAGE_SIZE >> 12). */

This comment should probably clarify that the page_size field is only
valid when cfg_type is VIRTIO_PCI_CAP_SHARED_MEMORY_CFG, assuming
that's the case. Or should the device be expected to provide the
page_size for all capabilities regardless of type?

It seems like the name should also ideally make it clearer that this
is page_size/4096 rather than the actual page size to avoid confusing
device implementers.

>         __le32 offset;          /* Offset within bar. */
>         __le32 length;          /* Length of the structure, in bytes. */
>  };

