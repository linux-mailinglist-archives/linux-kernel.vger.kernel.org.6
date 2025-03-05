Return-Path: <linux-kernel+bounces-546085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FCEA4F627
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EC63A9EFB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3637A1B532F;
	Wed,  5 Mar 2025 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYQeNz3r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017A2E3364
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741149167; cv=none; b=e60lgqn4Tz08fGfdbZrE26GNGSFLt75rbVqHIJkgAwdM/2EPNNxKFFGsNk+Wi75/L21TwOdwDfBrD7Z+Vs8k5w813E/ElL2jSULn/pNEvyTmCSehC0HviWpaoNwV+9+SKDR5LdphqVwjXdkyWa17X69uAUrJgFTMWxJ61T8Augg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741149167; c=relaxed/simple;
	bh=nFWeksWwiHDRuocIyS5OZv5DOPyfdCfqD6Zc0mGUK2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hd5wobOV5l0RSnUnGhLIjOSk8tRQUTBDaO341M/4LqhvqK4G8xHrsVc6zkRdNsaoLPF67gHokL8jDp80EDExXbDU6Enkni3v85LBXcLpA8wCF/ezzmv2SVsnpsUQgfStr32mmSRnbtBz6nyXLKMWARpxwmDiFlBhqZN03LNoEPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYQeNz3r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741149165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjVevVXOLmssCLAAJ8imF8PLNyoL6QY0RzG5Mf1zavQ=;
	b=UYQeNz3r0nIi97ZIzAsc99L0yI58eQMN9BwXbj1FfXDvhMzdnbTsKhk1WodMDxquVOfv3h
	RMPsPwW/UadfY3a60anEyaz68bz4q7fGmswOS1HX//eNf4MFhrKR170ZU2UtkkjCMB2QyB
	vr0jB63rRfoPq4YtdZBeV8GK5yyDEUI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-Ft7v-4giN1iu-ZGXdyvUuQ-1; Tue, 04 Mar 2025 23:32:33 -0500
X-MC-Unique: Ft7v-4giN1iu-ZGXdyvUuQ-1
X-Mimecast-MFC-AGG-ID: Ft7v-4giN1iu-ZGXdyvUuQ_1741149153
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso14596997a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 20:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741149152; x=1741753952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjVevVXOLmssCLAAJ8imF8PLNyoL6QY0RzG5Mf1zavQ=;
        b=ZK/ZGcFJ3VWceilVmDy1xp3OdK4i7kN4prjhxbV7o9A46J3N+wZGbQFk0YOFUf5ZQx
         pHcxEamUc5KdJuTt+YdEAdyfa0ElbdIFZvmpq2uz5RoxvEOBlFlkYrPeEC+GVeLHjR3w
         UcTvC+WDXIFp/dhnTc8uDTfXW1wZ3h/Xy7bkHhrQphZKqzZJK/tPMjnHuG5PJwmqZti5
         raLAma2bJss3HHs282c1eT/kzJaO9csveUaZBZfjCBbfh93sprW4JnELnGaqaD+UeBrv
         OTfn106cF9KWKltJYqA8YL8zAdHQ2QqQzYorzc1rUhcJw6vgcrQoav74o1/l2EKiUecC
         nlxA==
X-Forwarded-Encrypted: i=1; AJvYcCWmt5B24QkwI5zDDgpyJdB6seck3jgGudATDQ/nD3l9GufjvTAEVoR1LxMZDU4HbBIf2KMUUICjvHzkX5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlX6K14wXoTcy9vC8lVpCgVH7I2t4i53iITd8hmE/4ErWzRm2u
	nOfYQ+34tJyxDrEED8GKL9XWjedt1wPWEQB1Ob6QH/czcpQaAmG7wmSq0Lhdn6RI6/ghza2XqHm
	gXmbiohhA9eecNiH86Kc78q9QUzqttapu2I0o/ED6z2ZUsAVfYxMd71uvBfjIsFydDZcao5sWhb
	u+U+uubV86De4f93ygOyF0ovYOVZuQ/az7+R2E
X-Gm-Gg: ASbGncv/Z0MUWB2djNztAj6lNuQMv298/ysJaVt6W1Gv4jPJhoaC+2dR55G1kxu3P4x
	yY7xvImamCNxRC3qAIzsfCZnvtxdiUShGyGzvX1bUMnlIufC9xruBRolCk0ouTSuKT5EycD68NA
	==
X-Received: by 2002:a17:90b:1cd0:b0:2ea:a25d:3baa with SMTP id 98e67ed59e1d1-2ff4978e92amr2977188a91.5.1741149152687;
        Tue, 04 Mar 2025 20:32:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhHW7v4PkX/3ohSqeT1tugqPYgOYC7QtruOmWg6dZQg09TZ3e6iZmJF1+UJ3XPL9kMzJDnCsDVq/d2f1hpDUo=
X-Received: by 2002:a17:90b:1cd0:b0:2ea:a25d:3baa with SMTP id
 98e67ed59e1d1-2ff4978e92amr2977160a91.5.1741149152309; Tue, 04 Mar 2025
 20:32:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121103346.1030165-1-eperezma@redhat.com> <20250224164956-mutt-send-email-mst@kernel.org>
 <CAJaqyWfir7+oVtC3Z+eC+jbDxkACs0J9a4-wnx_dgU5VeFhr8A@mail.gmail.com> <20250225072222-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250225072222-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Mar 2025 12:32:19 +0800
X-Gm-Features: AQ5f1Jqvzx_MszP7oKSb_mOembHoEYJVKAnXmXCk5PO3hJR0roqLasWY_CV6zvM
Message-ID: <CACGkMEte+TcMk5BRrcp4h+53p1oCs7uR+6OtSZzGj33kG3WL-Q@mail.gmail.com>
Subject: Re: [PATCH] vduse: add virtio_fs to allowed dev id
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Hanna Reitz <hreitz@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, German Maglione <gmaglione@redhat.com>, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Feb 25, 2025 at 01:17:02PM +0100, Eugenio Perez Martin wrote:
> > On Mon, Feb 24, 2025 at 10:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Tue, Jan 21, 2025 at 11:33:46AM +0100, Eugenio P=C3=A9rez wrote:
> > > > A VDUSE device that implements virtiofs device works fine just by
> > > > adding the device id to the whitelist.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > >
> > >
> > > OK, but the commit log really should say why
> > > you are doing this.
> >
> > Sure I can expand on the motivation.
> >
> > Something like "Allowing VDUSE FS type allows to build filesystems
> > that run in userspace and can be presented transparently to the host
> > and the guest. After modifying userland's libfuse, this allows to
> > expose a good amount to already available userland FS through vDPA."
> >
> > I'd add using the high performance virtio protocol but I still need to
> > do more tests for this TBH.
> >
> > > And also why is it safe.
> > >
> >
> > Can you expand on the scenarios you think this is insecure? While I
> > understand it's security sensitive, you already need root to perform
> > vdpa device operations. Is FS different from net or block?
> >
> > Thanks!
>
> I did not say it was insecure, just that you need to explain the
> security considerations in the commit log.
> The issue is that when one gave access to vdpa user device previously
> it would only allow mounting blk now a filesystem.
>
> Net is different, it is gated by CAP_NET_ADMIN.
>
> When net was introduced, selinux was there initially then it
> was deferred and never surfaced.
> Maybe we should revive it so it is possible to control which
> devices can be created in a granular way.

Can we simply start from CAP_SYS_ADMIN?

Thanks

>
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index 7ae99691efdf..6a9a37351310 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -144,6 +144,7 @@ static struct workqueue_struct *vduse_irq_bound=
_wq;
> > > >  static u32 allowed_device_id[] =3D {
> > > >       VIRTIO_ID_BLOCK,
> > > >       VIRTIO_ID_NET,
> > > > +     VIRTIO_ID_FS,
> > > >  };
> > > >
> > > >  static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *=
vdpa)
> > > > --
> > > > 2.48.1
> > >
>


