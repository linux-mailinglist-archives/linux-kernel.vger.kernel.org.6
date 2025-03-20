Return-Path: <linux-kernel+bounces-569025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE5BA69DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9233BDFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0181D7E3E;
	Thu, 20 Mar 2025 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtUfwelE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A991C3C07
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742434914; cv=none; b=MytxI+zQuZomcOC/bnYWNn95i21CAg4eZKjKRE2/BulMH4PWL1hRqBumWPZ/pgufohCXpBE9QEUONMe/n0VHXibCypf/HC0Slg8c7tTrNDOD5/T7zGfez/CdhAf5qWrTt24qihv3zQiI2aX1algE/Z9XGpVapgMxinpb+JDtolI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742434914; c=relaxed/simple;
	bh=w9AfWzzr+d037/c3NOeBWhBaP4yXq6yTOr4wb6Ns8vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtodBEEWFJG2nvhvtIbev8zU1m0HEe3ayFlBN6vwYuOoHUcFukWcn3I3FGRpi49XJdnSYFrHGCsdYMPKHYZJuahAhjLxFtZuBYxMgoE9o+IPJJq2binJVI/g4Scp3Bm3Ipy+fbyIKEOEvzOu0to0KOZX+0Yw0SxhXtZVx/4nvjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtUfwelE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742434912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSuXJ+t16wNkJ0IQCizE9LYu63n/iEBBS31rUbJRxyo=;
	b=gtUfwelE/06MUR3oHHRF3eHSiC/EU0hLHGXPTc79TyhUCY3NwTHuDIH724A+9utPbPWF8u
	u4BiTw6d48/veSdbOjgCSCaIDEMzpg30zzDH7ppmvFxATF0ly+ekKkO1lZPKJp0QVFQAcp
	zB0jVkI6J1IpOU/ndI044zx+u+bvQcc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-u082NmP6Oy2J3pyVpj7EfA-1; Wed, 19 Mar 2025 21:41:50 -0400
X-MC-Unique: u082NmP6Oy2J3pyVpj7EfA-1
X-Mimecast-MFC-AGG-ID: u082NmP6Oy2J3pyVpj7EfA_1742434910
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2254bdd4982so4598525ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742434910; x=1743039710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSuXJ+t16wNkJ0IQCizE9LYu63n/iEBBS31rUbJRxyo=;
        b=R9P2T/igAHxCecJlEG7qbzuv8WB+Mn7TGfAbHNSXl95/TnFxJmtvOudQ7sSc0qhh0d
         sa/sPAHaypyCtaKjOL+c7ePY1zCT1PCoIlYIiYW3iUFYvHKewOoCX5QLF8RlvDNdeWN4
         AKQ9+TiE1Rgmgo/s6iZ4MWoR0VR6v3HwK2Q84XWulDUnYBpeaD413Vai13jzF2wi3jlB
         jF9UVNZcCF3wlG7vjpPtLO+yjiXVDqBu5Y4/7eqxpa3ft5fiNMeSXiMIGSfW3gr3seTM
         LjXaqWrSF/H7/pNLT/rfprNgoxAhmCEg1tS5su16eMsr0ZMI5WEVfFXBfCljWoVo0OqE
         DiKA==
X-Forwarded-Encrypted: i=1; AJvYcCUTcztssli5Z0NdlDi2y7dYqE6ybYp7es5yHlsl74oBkBrATK97Qh6iA/pbwwVr1PTkVZGirVXvGIYwVDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFMJzrBKs8icuOnR5PiPhPi7mHzVrnYy75iolb005YlgTRSRz
	/UQhh6jcdv1oD0+3UU6iJxqOR/VpA2K+hxAZuIRarJmK2TRkWOoWEeZQ4uIcT6hqcpWoq8WR/qu
	WUr45B+em9FXI8avn9TCzkcviAu5Y/0TAAbwFcm/ov40ald0xO1bPgTtze2MkKd9yyn9MNKD58U
	0rSeRGO0O/R0NT+qceoHJsPPR42zIQnAqVj0/J
X-Gm-Gg: ASbGnct3DXr7ptLh4KMzEj49mrHimEoCp1hiGEmu0EYJAJXm1Ss5o0NjwiYD0Q15tbd
	XzkX2BLh1gasN1NDlW3HrzHAvWn/5Ov1d40as7laIw4lquRj0tyNObQzdMDISBP1EnusVN0sZhw
	==
X-Received: by 2002:a17:903:94d:b0:224:584:6f04 with SMTP id d9443c01a7336-22649932705mr63381835ad.18.1742434909667;
        Wed, 19 Mar 2025 18:41:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVZKY3/+gQ5uW4/fRFDSSY4RbxBwj7ezTcwSLDI5DmlGESAAawToYcSxzkgeMlD8Gi5b0Qg6P+w4Wdqx5CWrg=
X-Received: by 2002:a17:903:94d:b0:224:584:6f04 with SMTP id
 d9443c01a7336-22649932705mr63381575ad.18.1742434909306; Wed, 19 Mar 2025
 18:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317235546.4546-1-dongli.zhang@oracle.com>
 <20250317235546.4546-5-dongli.zhang@oracle.com> <CACGkMEtOsQg68O+Nqo9ycLSq7sN4AMZ92ZvLLMEF7xYDCA5Ycw@mail.gmail.com>
 <93797957-b23c-4861-a755-28bfc506051f@oracle.com>
In-Reply-To: <93797957-b23c-4861-a755-28bfc506051f@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Mar 2025 09:41:37 +0800
X-Gm-Features: AQ5f1JoEyf7e7dIADyZ-GdsiVzlSQbUdGG6ZatFtMLzEzjqH5P6c8GQYkcs51wI
Message-ID: <CACGkMEvrrENCeBFkVeBDgvPo=dizcxA9EOaLeN7MWTH_qjnnfQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] vhost: modify vhost_log_write() for broader users
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, mst@redhat.com, michael.christie@oracle.com, 
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:38=E2=80=AFAM Dongli Zhang <dongli.zhang@oracle.=
com> wrote:
>
> Hi Jason,
>
> On 3/17/25 6:12 PM, Jason Wang wrote:
> > On Tue, Mar 18, 2025 at 7:51=E2=80=AFAM Dongli Zhang <dongli.zhang@orac=
le.com> wrote:
> >>
> >> Currently, the only user of vhost_log_write() is vhost-net. The 'len'
> >> argument prevents logging of pages that are not tainted by the RX path=
.
> >>
> >> Adjustments are needed since more drivers (i.e. vhost-scsi) begin usin=
g
> >> vhost_log_write(). So far vhost-net RX path may only partially use pag=
es
> >> shared by the last vring descriptor. Unlike vhost-net, vhost-scsi alwa=
ys
> >> logs all pages shared via vring descriptors. To accommodate this, a ne=
w
> >> argument 'partial' is introduced. This argument works alongside 'len' =
to
> >> indicate whether the driver should log all pages of a vring descriptor=
, or
> >> only pages that are tainted by the driver.
> >>
> >> In addition, removes BUG().
> >>
> >> Suggested-by: Joao Martins <joao.m.martins@oracle.com>
> >> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> >> ---
> >>  drivers/vhost/net.c   |  2 +-
> >>  drivers/vhost/vhost.c | 28 +++++++++++++++++-----------
> >>  drivers/vhost/vhost.h |  2 +-
> >>  3 files changed, 19 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >> index b9b9e9d40951..0e5d82bfde76 100644
> >> --- a/drivers/vhost/net.c
> >> +++ b/drivers/vhost/net.c
> >> @@ -1219,7 +1219,7 @@ static void handle_rx(struct vhost_net *net)
> >>                 if (nvq->done_idx > VHOST_NET_BATCH)
> >>                         vhost_net_signal_used(nvq);
> >>                 if (unlikely(vq_log))
> >> -                       vhost_log_write(vq, vq_log, log, vhost_len,
> >> +                       vhost_log_write(vq, vq_log, log, vhost_len, tr=
ue,
> >>                                         vq->iov, in);
> >>                 total_len +=3D vhost_len;
> >>         } while (likely(!vhost_exceeds_weight(vq, ++recv_pkts, total_l=
en)));
> >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >> index 9ac25d08f473..db3b30aba940 100644
> >> --- a/drivers/vhost/vhost.c
> >> +++ b/drivers/vhost/vhost.c
> >> @@ -2304,8 +2304,14 @@ static int log_used(struct vhost_virtqueue *vq,=
 u64 used_offset, u64 len)
> >>         return 0;
> >>  }
> >>
> >> -int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log=
,
> >> -                   unsigned int log_num, u64 len, struct iovec *iov, =
int count)
> >> +/*
> >> + * 'len' is used only when 'partial' is true, to indicate whether the
> >> + * entire length of each descriptor is logged.
> >> + */
> >
> > While at it, let's document all the parameters here.
>
> Sure.
>
> >
> >> +int vhost_log_write(struct vhost_virtqueue *vq,
> >> +                   struct vhost_log *log, unsigned int log_num,
> >> +                   u64 len, bool partial,
> >> +                   struct iovec *iov, int count)
> >>  {
> >>         int i, r;
> >>
> >> @@ -2323,19 +2329,19 @@ int vhost_log_write(struct vhost_virtqueue *vq=
, struct vhost_log *log,
> >>         }
> >>
> >>         for (i =3D 0; i < log_num; ++i) {
> >> -               u64 l =3D min(log[i].len, len);
> >> +               u64 l =3D partial ? min(log[i].len, len) : log[i].len;
> >> +
> >>                 r =3D log_write(vq->log_base, log[i].addr, l);
> >>                 if (r < 0)
> >>                         return r;
> >> -               len -=3D l;
> >> -               if (!len) {
> >> -                       if (vq->log_ctx)
> >> -                               eventfd_signal(vq->log_ctx);
> >> -                       return 0;
> >> -               }
> >> +
> >> +               if (partial)
> >> +                       len -=3D l;
> >
> > I wonder if it's simpler to just tweak the caller to call with the
> > correct len (or probably U64_MAX) in this case?
>
> To "tweak the caller to call with the correct len" may need to sum the le=
ngth
> of all log[i].
>
> Regarding U64_MAX, would you like something below? That is, only use 'len=
'
> when it isn't U64_MAX.
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 9ac25d08f473..5b49de05e752 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2327,15 +2327,14 @@ int vhost_log_write(struct vhost_virtqueue *vq, s=
truct vhost_log *log,
>                 r =3D log_write(vq->log_base, log[i].addr, l);
>                 if (r < 0)
>                         return r;
> -               len -=3D l;
> -               if (!len) {
> -                       if (vq->log_ctx)
> -                               eventfd_signal(vq->log_ctx);
> -                       return 0;
> -               }
> +
> +               if (len !=3D U64_MAX) ---> It is impossible to have len =
=3D U64_MAX from vhost-net
> +                       len -=3D l;        How about keeping those two li=
nes?
>         }
> -       /* Length written exceeds what we have stored. This is a bug. */
> -       BUG();
> +
> +       if (vq->log_ctx)
> +               eventfd_signal(vq->log_ctx);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(vhost_log_write);

Something like this.

Thanks

>
>
> Thank you very much!
>
> Dongli Zhang
>


