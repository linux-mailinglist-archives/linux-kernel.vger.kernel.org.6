Return-Path: <linux-kernel+bounces-403451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B629C35E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E41F9B21737
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF433200A3;
	Mon, 11 Nov 2024 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Szm8xdL7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B9EAF9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288483; cv=none; b=QxJ5AQa2utG3J+dKXVNYUpxq7OwIei4hDm8Uj3oH7w1g35C/0RA5tbcIbQRGZjjYgbIbqnihtUqoJ7LYwWVxgi476fV22AhORc3q0pAag86iExLzNX6ViW+TAWmY7pUL7G5HmPPF4GEvm+njLEQylzj29zT9xaYnxK6Jk4m4+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288483; c=relaxed/simple;
	bh=rmJaCFWLaEKukmoQFYXTWoPzcVFVMWyE+/yJXxOx6k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAfHfgsTTgmS73lEHPF7l2mKKB2YSr2tve2o7rolretXqRqpKXRWU+z7Ki8hiY3YkjmYly6PHmuEnU+FAdqJuCcKi4CsuFLbraWfUbFtHoiXvRgOJxwoCIpT+fPylvo0TKlH4FIFbQ9hRtmcLaVSyw8P7UOzFE2a3yY2drDW2hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Szm8xdL7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731288480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XsueIyR21StC8z8Y1fH80OpJCx4CEL4++SzGNpSB0e8=;
	b=Szm8xdL7I100eOq4lOPRPL4063eIlQKzSKIt0m+OA06xZSBSbBTUf76b92yIuYGVknSMhr
	wlty2Aa2q3JLWBDz3aDzT22sTMDTZy+O2tsWOm7aJVeb8zQl/FsLusJgrhYyckuar+Ivhp
	akCKaDB/H5GRdg0XleJ8+56O6Be0EhQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-HU8HTFWYNV-mLFJFt8QeuQ-1; Sun, 10 Nov 2024 20:27:58 -0500
X-MC-Unique: HU8HTFWYNV-mLFJFt8QeuQ-1
X-Mimecast-MFC-AGG-ID: HU8HTFWYNV-mLFJFt8QeuQ
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e2eb765285so5015655a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 17:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731288478; x=1731893278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsueIyR21StC8z8Y1fH80OpJCx4CEL4++SzGNpSB0e8=;
        b=r60xAnFJzMMy6TiPcm8r/xObpHceSBA/OB+7TkXiksaVfFxBzHn42B4iyG6hMF0eQd
         eY6TGSXHqu8lfl6rA6HYoNCAlsCBU8P4P4x50LDDEX5nlPBUp9qeNPNAwEArWzv2+Mq9
         yMK+bvmL/+HeiHlFs7bDHs+JcaEyrB2AUMeMez+Eig9CRg4+nplpD8bWQjMA3jFP3HwA
         fLlsyVgvlK+q3S8PEG8MLGco1IoA0iDCm/g47jHWbvWuKBI2k2DRNIxZwQ7brJK0/djH
         c4bXmrhtIqH6IRrD+94X6B7U26CGmAgjYcmKVa9M4fHh+3/6aTyVNbL4FOjngXaq3lyD
         4usA==
X-Forwarded-Encrypted: i=1; AJvYcCXyfNDul3vUKOjSOuphXaVbPESmOJuIgIgGoE2w5HV38PlTW01XfYGsKXivJZ4xuU/SYIm/fH131wKGBI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw70nMpyWgfsMCROjrOTPhsN00gvj9lgnRGyeBkFJmIfc7ZPS4G
	M1mzeM5E0Zqij1yvB8zRAUq9aODtv3jnAM9sDh3WU5dGJjteHlPIwhiB5y54vwiPtxS3VJElpkq
	MAJqcUHXv6czkbm733CHbhiMquAYu22Jwzlt/36oh07tYkRMYM9cVn3fDbfetTOXU0WEedh/E2C
	ShcH1j1An/MmbBkLNKNkcmFAuPDUoxuIh5sKkq
X-Received: by 2002:a17:90b:3847:b0:2e2:e159:8f7b with SMTP id 98e67ed59e1d1-2e9b16e6415mr13589093a91.3.1731288477651;
        Sun, 10 Nov 2024 17:27:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2UZCxZDdjpET0emSMpwkmcUbnJkxi3e/4YjQOK8fT8UOV7uYIqku2wZHJSDGRMo1459z1m7GHz7ZEy+uOkt4=
X-Received: by 2002:a17:90b:3847:b0:2e2:e159:8f7b with SMTP id
 98e67ed59e1d1-2e9b16e6415mr13589069a91.3.1731288477175; Sun, 10 Nov 2024
 17:27:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-v1-v1-1-f10d2cb5e759@daynix.com> <20241106035029-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241106035029-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:27:45 +0800
Message-ID: <CACGkMEt0spn59oLyoCwcJDdLeYUEibePF7gppxdVX1YvmAr72Q@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: Set num_buffers for virtio 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 4:54=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Sun, Sep 15, 2024 at 10:35:53AM +0900, Akihiko Odaki wrote:
> > The specification says the device MUST set num_buffers to 1 if
> > VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> >
> > Fixes: 41e3e42108bc ("vhost/net: enable virtio 1.0")
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> True, this is out of spec. But, qemu is also out of spec :(
>
> Given how many years this was out there, I wonder whether
> we should just fix the spec, instead of changing now.
>
> Jason, what's your take?

Fixing the spec (if you mean release the requirement) seems to be less risk=
y.

Thanks

>
>
> > ---
> >  drivers/vhost/net.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index f16279351db5..d4d97fa9cc8f 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -1107,6 +1107,7 @@ static void handle_rx(struct vhost_net *net)
> >       size_t vhost_hlen, sock_hlen;
> >       size_t vhost_len, sock_len;
> >       bool busyloop_intr =3D false;
> > +     bool set_num_buffers;
> >       struct socket *sock;
> >       struct iov_iter fixup;
> >       __virtio16 num_buffers;
> > @@ -1129,6 +1130,8 @@ static void handle_rx(struct vhost_net *net)
> >       vq_log =3D unlikely(vhost_has_feature(vq, VHOST_F_LOG_ALL)) ?
> >               vq->log : NULL;
> >       mergeable =3D vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
> > +     set_num_buffers =3D mergeable ||
> > +                       vhost_has_feature(vq, VIRTIO_F_VERSION_1);
> >
> >       do {
> >               sock_len =3D vhost_net_rx_peek_head_len(net, sock->sk,
> > @@ -1205,7 +1208,7 @@ static void handle_rx(struct vhost_net *net)
> >               /* TODO: Should check and handle checksum. */
> >
> >               num_buffers =3D cpu_to_vhost16(vq, headcount);
> > -             if (likely(mergeable) &&
> > +             if (likely(set_num_buffers) &&
> >                   copy_to_iter(&num_buffers, sizeof num_buffers,
> >                                &fixup) !=3D sizeof num_buffers) {
> >                       vq_err(vq, "Failed num_buffers write");
> >
> > ---
> > base-commit: 46a0057a5853cbdb58211c19e89ba7777dc6fd50
> > change-id: 20240908-v1-90fc83ff8b09
> >
> > Best regards,
> > --
> > Akihiko Odaki <akihiko.odaki@daynix.com>
>


