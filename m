Return-Path: <linux-kernel+bounces-299829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A982295DA7C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45CF6B211C8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FF117C68;
	Sat, 24 Aug 2024 02:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ECNnidMu"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D888F6C
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724465222; cv=none; b=UbO4Dvge5OIBmKsFqGznC7maz5OXCnJHRlcpGo/3JX09lRpbzkLRwCfNqcFFaxtoPBSWdUnQAl4Z0GKxW5eqHQrKf+MBoyn6tbC5XTLv3lokQZFmuyGbJAjf1Kk4GIAVWR1ApOmnCpCDHibiia7VX+PJ1Jk5FijPIzP8Lc/W7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724465222; c=relaxed/simple;
	bh=L1a/fLuZOGUu5Zj1RuXcZgKqEmzDqs688WLUixmKdkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMpq/lkDhtEHKOHnHskUfFT/OlnKOj+FlWrchMI1kbCReotl5zNpepzyRe4GhK3MgKsGYCik1X8LLgNBnjTPLLaqktLMLhW1oGZFqJQXt8RUKk7QAAbqZ7Bive7S2DtyrwZMvSPoysFTTIGV4lM/szxR/8bSfTKD/e2IJFlmkaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ECNnidMu; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6bf999ac52bso12199166d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724465218; x=1725070018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38U3TamQgtOMpIheDUaSqju5cn7JqVNPQVT6ndofX00=;
        b=ECNnidMuyj7eTLDWRK0lq0tRb6dc4P3eWZlYSr1FNXo+npCQApXFyX9sDpSz0WDWiS
         xgYI5Xzk9KDot7PyTFkp+ZvxZrp1sJWeIPOnAc2Au4ut8i+OUa81hzwZL22DDXI1eg+B
         z6gaGyFBYI5/vjqzv1mFX3MytB0pAO7C9Ywss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724465218; x=1725070018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38U3TamQgtOMpIheDUaSqju5cn7JqVNPQVT6ndofX00=;
        b=vnSFYEoWPnVKKJIy9gOQZSExnSyl8eR+ujJJtbKucqQldOMDElrp7/IIEvjxlVIU60
         f2oCrKn1+nuRPMjbniVOSeJVr9duDwjMcZ9Vi2FIaa6wXSBaIa7xBuVTaB1aqv5+wTDN
         Z7/lIhEd/lHMbjsvNnCYlWXUFcHKGKdT3bhaeprsd5eA/FAVpWwPjv4ab4hPajr66dEN
         F+KzRdsRstjO+HbNtyP9fnltUS4TwHaBz2qyzCighjWjnesFr7GD7e+Ks4bwDB2jbawE
         qjd0BHlaKbecNJ14cJeID0anoG1/6UOwQVsp7lhpTFtFTLNrk/ythEA2jDW6yx3aVp/L
         P5+w==
X-Forwarded-Encrypted: i=1; AJvYcCXqmN9VcYmQ4yIjGWd3ozzhcI9fN6NNm6nihhCFtAjJV2JYI+mOF0SYY8u8Ej23gb+IztHWkWHplIji+eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLBgiekT4vtMm/Qar70UgizUhuEEBUq7JQe+yKmwOE2GEMuI6K
	T4GVz8hhCmZRKVVf9UetHBG13RxIQfZFbmSRhk62C1JHvJnuO38aQQFgU8vAmoLDyHSJRAqCVuJ
	jqNWbiLrW7Ix3f5MkAx/V1Mc0NASOtMtXqThQ
X-Google-Smtp-Source: AGHT+IFuyHAil0u7ZWb4xCIHUwmhAwZMPgDdoKeyRsz9kcT37qgzsuYEH1oVBYR6znpm0ntncsND145bSWsjf+QJzJM=
X-Received: by 2002:a05:6214:5a04:b0:6bf:979a:34c8 with SMTP id
 6a1803df08f44-6c16dc9635dmr48532596d6.33.1724465218039; Fri, 23 Aug 2024
 19:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815004617.2325269-1-philipchen@chromium.org>
In-Reply-To: <20240815004617.2325269-1-philipchen@chromium.org>
From: Philip Chen <philipchen@chromium.org>
Date: Fri, 23 Aug 2024 19:06:47 -0700
Message-ID: <CA+cxXhneUKWr+VGOjmOtWERA53WGcubjWBuFbVBBuJhNhSoBcQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_pmem: Add freeze/restore callbacks
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
Cc: virtualization@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi maintainers,

Can anyone let me know if this patch makes sense?
Any comment/feedback is appreciated.
Thanks in advance!

On Wed, Aug 14, 2024 at 5:46=E2=80=AFPM Philip Chen <philipchen@chromium.or=
g> wrote:
>
> Add basic freeze/restore PM callbacks to support hibernation (S4):
> - On freeze, delete vq and quiesce the device to prepare for
>   snapshotting.
> - On restore, re-init vq and mark DRIVER_OK.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
>  drivers/nvdimm/virtio_pmem.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index c9b97aeabf85..2396d19ce549 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -143,6 +143,28 @@ static void virtio_pmem_remove(struct virtio_device =
*vdev)
>         virtio_reset_device(vdev);
>  }
>
> +static int virtio_pmem_freeze(struct virtio_device *vdev)
> +{
> +       vdev->config->del_vqs(vdev);
> +       virtio_reset_device(vdev);
> +
> +       return 0;
> +}
> +
> +static int virtio_pmem_restore(struct virtio_device *vdev)
> +{
> +       int ret;
> +
> +       ret =3D init_vq(vdev->priv);
> +       if (ret) {
> +               dev_err(&vdev->dev, "failed to initialize virtio pmem's v=
q\n");
> +               return ret;
> +       }
> +       virtio_device_ready(vdev);
> +
> +       return 0;
> +}
> +
>  static unsigned int features[] =3D {
>         VIRTIO_PMEM_F_SHMEM_REGION,
>  };
> @@ -155,6 +177,8 @@ static struct virtio_driver virtio_pmem_driver =3D {
>         .validate               =3D virtio_pmem_validate,
>         .probe                  =3D virtio_pmem_probe,
>         .remove                 =3D virtio_pmem_remove,
> +       .freeze                 =3D virtio_pmem_freeze,
> +       .restore                =3D virtio_pmem_restore,
>  };
>
>  module_virtio_driver(virtio_pmem_driver);
> --
> 2.46.0.76.ge559c4bf1a-goog
>

