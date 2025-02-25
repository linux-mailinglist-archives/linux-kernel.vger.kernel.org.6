Return-Path: <linux-kernel+bounces-531326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E48F5A43F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD4C164318
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA196241CA6;
	Tue, 25 Feb 2025 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSHLtlv7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7A92571AD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485865; cv=none; b=ls5lXBjAjyab4/CEUyQoB+KfCwVlpw24OhTMAPijynnaJA6sW5zGx1jV3n7+Wz5LfAVOuL5mnJugvr5/fX1HiZKDnVEs2VFg8D1pejll3mPKlaz00h7AR5L/xZogpgUkGc+luSD6XlD2f6k7/87pqLmAXn06xjNE+VvYfq6F7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485865; c=relaxed/simple;
	bh=F2vZaOS9f5dPxo1fJQc1/bBdBD5kzX1Fyp6Pv+/djS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSNlsuq7cOCRD6u2IEUNyRSd07JkU3tJe2n4bSIEL/UiOy6PDIOgriOMlPICpD5umfpGX1t0htMBCnO4ZdRoc6i13K3vYo9hL+5/l8pO+8SPqEsTE5nhrNQVYhX4Fk/8hc15f+YB0hhxxxP859szT+t2pigY+Cpf1M83xoVU3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSHLtlv7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740485862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUj8pOCsz76dhsi/SG3EEBuJV5Q3s6LEl5sicjNVCjQ=;
	b=JSHLtlv7Tx5EJpb4JdQ+8lz0eprX1s6JGMNIE/hCfmGaQzX9g0eBMX3ZEA/4KX82aJ4X57
	KA85jeuim7z0GQ19MV5zuXhsmHgoY6djKFP9t5pgPa+fM6hlmvBeOIZJSGTmmlAOBTeAX3
	rI4XD31y2nkYGhzu8zc9Sy27wfJkGEs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-BDvqBJfcMO-k0lI09nG7JA-1; Tue, 25 Feb 2025 07:17:41 -0500
X-MC-Unique: BDvqBJfcMO-k0lI09nG7JA-1
X-Mimecast-MFC-AGG-ID: BDvqBJfcMO-k0lI09nG7JA_1740485860
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc2b258e82so12077827a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740485860; x=1741090660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUj8pOCsz76dhsi/SG3EEBuJV5Q3s6LEl5sicjNVCjQ=;
        b=OreiNhmfMDmjSlNx1bOURd4CN614rc/jABB+YYt2N7H4r+hfqVc0OcTnr49OSNuhtV
         o+WgzGeYSCAix/vxOAHUhxaYpyHqcYextUAP+QinxhTIexkSyjTdLUcJdzz3JNCC9oDc
         ZzmgWM5by1hZQ2dxobFw+D6s3mLMiHrbcjsNX4ueHfDPxzx+sbqYmg0DMB2JZhqDOQuX
         +TOw8gzExnS2zo4WlB8mrYMXvbYeel8tYkuURqnj3X3/zuCtrZLr+sdXHCAKNnoLUoAu
         /29V0U+UV6/MbJTI5DTB3La23jhOtMD/L64Xk/tFsjYghYMX2K0XvjVYPBa8XgePPiNP
         F8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOLdYzKUUFvCR4j+hqpunl+3mQodLID0evG3uNXYvt4ZitLVzXY7mk8uM5NjAmk0OOUdWKMaikxluDEXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/AzsL0sRpxAccvqXlTP6aq/3s2Hfix2Q3a/KD5AHNFGPz8Ive
	PhncF+qhp8cqdBjW1IrFqEUoAKaPznWMokPn+plyVqHgg4NC/9HhBcCZ8YBxs4iKUB9Z7tE+pzD
	hCnuWFl6C2oQgFRZFER905ca4f4WxP2U3X65L8NfxydkrEeZJKKLscy4fSKJP7Db5tXd+U4AwOk
	HkkMgSOuNsQslMUcJGwGeozXMQA2WnxmZTZ4O8
X-Gm-Gg: ASbGncvV3+S+RTNry6ibqoJcyavkgNxgxglB90Tm/UvJQ9YV2rcWSLhTq2tqzE385lk
	asKWSFvsm7qfP/YgJJrzeLiCWKiboq+qOFkqU5iuP2+FrWrsGwCbeQdkXoI+u8BFhnYfgjVM=
X-Received: by 2002:a17:90b:2590:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-2fce769a8aemr27308463a91.4.1740485860043;
        Tue, 25 Feb 2025 04:17:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/2zzJb5wvZ7QqLIuzcDLskP+j6OTP1hc+levVyCYPy4thU+0z+g/gmtEF0bRntfAknjp+kHEctUeQsLn49kA=
X-Received: by 2002:a17:90b:2590:b0:2ea:5dea:eb0a with SMTP id
 98e67ed59e1d1-2fce769a8aemr27308438a91.4.1740485859755; Tue, 25 Feb 2025
 04:17:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121103346.1030165-1-eperezma@redhat.com> <20250224164956-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250224164956-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 25 Feb 2025 13:17:02 +0100
X-Gm-Features: AWEUYZl9o1wkJEhPYQV6xj-jLOpXFm58am5y2uOOONMp9W8KB-2y7XkozzEpMWw
Message-ID: <CAJaqyWfir7+oVtC3Z+eC+jbDxkACs0J9a4-wnx_dgU5VeFhr8A@mail.gmail.com>
Subject: Re: [PATCH] vduse: add virtio_fs to allowed dev id
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Hanna Reitz <hreitz@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Jason Wang <jasowang@redhat.com>, German Maglione <gmaglione@redhat.com>, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 10:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Jan 21, 2025 at 11:33:46AM +0100, Eugenio P=C3=A9rez wrote:
> > A VDUSE device that implements virtiofs device works fine just by
> > adding the device id to the whitelist.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
>
> OK, but the commit log really should say why
> you are doing this.

Sure I can expand on the motivation.

Something like "Allowing VDUSE FS type allows to build filesystems
that run in userspace and can be presented transparently to the host
and the guest. After modifying userland's libfuse, this allows to
expose a good amount to already available userland FS through vDPA."

I'd add using the high performance virtio protocol but I still need to
do more tests for this TBH.

> And also why is it safe.
>

Can you expand on the scenarios you think this is insecure? While I
understand it's security sensitive, you already need root to perform
vdpa device operations. Is FS different from net or block?

Thanks!

> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 7ae99691efdf..6a9a37351310 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -144,6 +144,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
> >  static u32 allowed_device_id[] =3D {
> >       VIRTIO_ID_BLOCK,
> >       VIRTIO_ID_NET,
> > +     VIRTIO_ID_FS,
> >  };
> >
> >  static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa=
)
> > --
> > 2.48.1
>


