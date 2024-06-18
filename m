Return-Path: <linux-kernel+bounces-219866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD05590D91E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40291C23B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FAE74BE0;
	Tue, 18 Jun 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="CtUqpVJt"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DADB46521
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727847; cv=none; b=Sep2VRfuAGJNL1WOUIQnyo9wWZONk3clcaSY91tUXPGZ2HnCdmfNJbNNNa2lRNrpdu5E6x5z0gWbGQShNkCq3zC8dvSb2Cbaje/l1+Nw9HagdtdQKZV1sOLcbAThCJdHQ8w5YftBTXPyw4/u+28Txx+1dGlMVkLbXo/h12/RD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727847; c=relaxed/simple;
	bh=iginfQEMH+QiHEvMKEZfi6Hc3mXKOtB6yNGCYGefA3w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fnwMuInSpJ14j3ufYjFfyNozaflWPAp6Bz8BvTlZ/E/3dbhXfdXGeeXi3MYW6nMbm15JsW1AqrwehY0NKH/UcpjQrDEnme3Lu4tLZoJwu36sy8jQeH6TxgtBoz8kIeLWi21z9nNTIZevp/9T+6TDGSC8NY2Nip00QZOwetvbzvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=CtUqpVJt; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ba70a0ed75so2879735eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1718727844; x=1719332644; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y2L36ZkKRa2ldLn+cK6LBceBfGVZn+/Ml/80DU+Rz8Y=;
        b=CtUqpVJtoZjv1x2rlqFUFM7fOG8/Iyx97Sxwrqswdx5aeaaAnBht5NKUt8obY5Pzxt
         49DnSc/UkBBfvTXKlGclJMac3km26LSo+z6Az/D8eeYUEkXJ71MKoH40BlOJAUrLo9n/
         BzUBpRFNhrnR/pmkH6aJACfSGUM1kROGhvL/1+1Vl6rKWkSnzeRGgDjEkZtkGzg6ctgb
         p9WrDZMtGkh1dK+xCdgcvuz3X+Mbn4P6JTvl5cYgqVoOpRr4ti9VmgpIZgz070boQVGD
         jT+WjE9CXkpuLRQglU+ZlUQ9l7dGnKKJHCXBRixbhyzH8knnkHIYgEjPGhgWT2JfiKj+
         nUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718727844; x=1719332644;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2L36ZkKRa2ldLn+cK6LBceBfGVZn+/Ml/80DU+Rz8Y=;
        b=E/W+gPlkbKLoZN7HqAEiIauW6orFBo7FI4zaPYnQc3rFQunKdXt9pIHf9JDxx/F/xW
         qVOVSFEKmbDAQufASoihle8Lk4h0KAkMhPVoBG5hFhHTHiKxnQ/UOGF2VU5qqSLx4xY7
         onKQoVI0swfvK2Fib9WY/rvGxa8obB7Djg0Q6RxrjC4WmRmUTznOvW0Oic2wbpOPxt7P
         Szap6E5goe8bE+zpSvJsht0h4JgSHDeyUTpyT6l8PVBh3Ux2ASG1fr3xTRYmJeft/skx
         llJ1fqQjYd/fQS/0NXxb4ylQrBy5cTv1JViGgf0F7MsMAhh/T39Jt4JQyxTkIn7631+9
         a8iA==
X-Forwarded-Encrypted: i=1; AJvYcCUIR1AuC5gQAxQ7WJne5P25sp1vDkr/rwFcvL02aRCta5GLj36rY3sdaSmTns4XlE5wJi03YZyq5GMkWa7Y0LgRVsx/Oz/bu25nxB5+
X-Gm-Message-State: AOJu0YzheFfxXuM+cWcvOywf+e7VeQooEWOyLzOzaXZiib6ttDW3xueY
	9uTsd0zYD/VrAJsuNtONLL/LBEmrWWZ6hD2LNugrbDayGRpxIE0dQWW8HJJ+o8M=
X-Google-Smtp-Source: AGHT+IFJbrVxZSy5MW1kEWYhiDGt9QvD0Fml+npOhQgHsfa3dm06eYcugngrvjSxbWiA5O9MHgS/Zg==
X-Received: by 2002:a05:6359:5fa9:b0:1a0:d4b4:5eb5 with SMTP id e5c5f4694b2df-1a1fd59877dmr34733855d.28.1718727844503;
        Tue, 18 Jun 2024 09:24:04 -0700 (PDT)
Received: from nicolas-tpx395.lan ([2606:6d00:17:5fb9::7a9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe279c0sm532234285a.110.2024.06.18.09.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:24:04 -0700 (PDT)
Message-ID: <036bf0d7f657cae444d20ea6d279b47e3bf0164e.camel@ndufresne.ca>
Subject: Re: [PATCH] media: videobuf2: sync caches for dmabuf memory
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Tomasz Figa <tfiga@chromium.org>, TaoJiang <tao.jiang_2@nxp.com>
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, shawnguo@kernel.org, 
 robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, linux-imx@nxp.com, xiahong.bao@nxp.com,
 eagle.zhou@nxp.com,  ming.qian@oss.nxp.com, imx@lists.linux.dev,
 linux-media@vger.kernel.org,  linux-kernel@vger.kernel.org,
 m.szyprowski@samsung.com, sumit.semwal@linaro.org, 
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Ming Qian <ming.qian@nxp.com>
Date: Tue, 18 Jun 2024 12:24:03 -0400
In-Reply-To: <CAAFQd5B_RTHsMwMdD59RAAyFne_0Ok_A4ExdkVOgi=G6-UGfRQ@mail.gmail.com>
References: <20240618073004.3420436-1-tao.jiang_2@nxp.com>
	 <CAAFQd5B_RTHsMwMdD59RAAyFne_0Ok_A4ExdkVOgi=G6-UGfRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le mardi 18 juin 2024 =C3=A0 16:47 +0900, Tomasz Figa a =C3=A9crit=C2=A0:
> Hi TaoJiang,
>=20
> On Tue, Jun 18, 2024 at 4:30=E2=80=AFPM TaoJiang <tao.jiang_2@nxp.com> wr=
ote:
> >=20
> > From: Ming Qian <ming.qian@nxp.com>
> >=20
> > When the memory type is VB2_MEMORY_DMABUF, the v4l2 device can't know
> > whether the dma buffer is coherent or synchronized.
> >=20
> > The videobuf2-core will skip cache syncs as it think the DMA exporter
> > should take care of cache syncs
> >=20
> > But in fact it's likely that the client doesn't
> > synchronize the dma buf before qbuf() or after dqbuf(). and it's
> > difficult to find this type of error directly.
> >=20
> > I think it's helpful that videobuf2-core can call
> > dma_buf_end_cpu_access() and dma_buf_begin_cpu_access() to handle the
> > cache syncs.
> >=20
> > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > Signed-off-by: TaoJiang <tao.jiang_2@nxp.com>
> > ---
> >  .../media/common/videobuf2/videobuf2-core.c   | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >=20
>=20
> Sorry, that patch is incorrect. I believe you're misunderstanding the
> way DMA-buf buffers should be managed in the userspace. It's the
> userspace responsibility to call the DMA_BUF_IOCTL_SYNC ioctl [1] to
> signal start and end of CPU access to the kernel and imply necessary
> cache synchronization.
>=20
> [1] https://docs.kernel.org/driver-api/dma-buf.html#dma-buffer-ioctls
>=20
> So, really sorry, but it's a NAK.



This patch *could* make sense if it was inside UVC Driver as an example, as=
 this
driver can import dmabuf, to CPU memcpy, and does omits the required sync c=
alls
(unless that got added recently, I can easily have missed it).

But generally speaking, bracketing all driver with CPU access synchronizati=
on
does not make sense indeed, so I second the rejection.

Nicolas

>=20
> Best regards,
> Tomasz
>=20
> > diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/=
media/common/videobuf2/videobuf2-core.c
> > index 358f1fe42975..4734ff9cf3ce 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-core.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> > @@ -340,6 +340,17 @@ static void __vb2_buf_mem_prepare(struct vb2_buffe=
r *vb)
> >         vb->synced =3D 1;
> >         for (plane =3D 0; plane < vb->num_planes; ++plane)
> >                 call_void_memop(vb, prepare, vb->planes[plane].mem_priv=
);
> > +
> > +       if (vb->memory !=3D VB2_MEMORY_DMABUF)
> > +               return;
> > +       for (plane =3D 0; plane < vb->num_planes; ++plane) {
> > +               struct dma_buf *dbuf =3D vb->planes[plane].dbuf;
> > +
> > +               if (!dbuf)
> > +                       continue;
> > +
> > +               dma_buf_end_cpu_access(dbuf, vb->vb2_queue->dma_dir);
> > +       }
> >  }
> >=20
> >  /*
> > @@ -356,6 +367,17 @@ static void __vb2_buf_mem_finish(struct vb2_buffer=
 *vb)
> >         vb->synced =3D 0;
> >         for (plane =3D 0; plane < vb->num_planes; ++plane)
> >                 call_void_memop(vb, finish, vb->planes[plane].mem_priv)=
;
> > +
> > +       if (vb->memory !=3D VB2_MEMORY_DMABUF)
> > +               return;
> > +       for (plane =3D 0; plane < vb->num_planes; ++plane) {
> > +               struct dma_buf *dbuf =3D vb->planes[plane].dbuf;
> > +
> > +               if (!dbuf)
> > +                       continue;
> > +
> > +               dma_buf_begin_cpu_access(dbuf, vb->vb2_queue->dma_dir);
> > +       }
> >  }
> >=20
> >  /*
> > --
> > 2.43.0-rc1
> >=20


