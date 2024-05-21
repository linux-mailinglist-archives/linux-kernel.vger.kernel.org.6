Return-Path: <linux-kernel+bounces-184365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAEA8CA626
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6F01F21FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4C212E71;
	Tue, 21 May 2024 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6UMxeLq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75212134A9
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716258555; cv=none; b=aM7e/PwapK1UPDszA5qSq/1n3Elo7zCawu4GAHGuYM+73JS7O/xpHfiW3CiZeOjY7xRtd++QmzKvQzuRSV4TrPTu9GtQY87RkWS13qBpgc1mVcAVogW38OFIQMWcg7dTXD4/Sy9rDhLqQHw3ceK5QOnz/ztb6sdodb+w2XWQCPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716258555; c=relaxed/simple;
	bh=fHuz2izoRrXrdHAlUrSjhQX2YUje7YUBi+uJY+FIFow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMxTmviRZbTSYHEophSSMhYvweRaTVEkXYgp9/IKVdhCjfB+FWS3tDgAaHU7wJP+yyDHgq9G5o5JTa/VN4GN0mPDlv5JCDnf3CZEvLGNKbA1o2voIhOcR6tPRBEkBrKKY56IPn0SU6j1KDqgd6nm/9QffjHQvl1wxveiFyxN5a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6UMxeLq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716258552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w/SMSLTAXFZZwyaLr5kA0B7cu9hCGbcKtCcSYK2/MZg=;
	b=U6UMxeLqj/g244r0zOY7+I7RFOf2HAzZTcrIOhanm5KzQLnEI+LHkpu1yIdnJFgkKszaim
	lNnbGb2CG7XRuK0+3f3Alcl/BK/V2yhZ44Xm1SotweippXOs9OFwZX2Cml+x1MsOaBYDSM
	Vd/59X2MS4DoSZvcFE9rTD9gKiGHtys=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-8DZktjcVMpWbsHmFAzGJOA-1; Mon, 20 May 2024 22:29:10 -0400
X-MC-Unique: 8DZktjcVMpWbsHmFAzGJOA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2b4330e57b6so12201921a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716258549; x=1716863349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/SMSLTAXFZZwyaLr5kA0B7cu9hCGbcKtCcSYK2/MZg=;
        b=YBZ/JlYDvk/LiRuuJPmabTz5bsxUl2tmYo9gNh9L1R8ahceIM9eLQWZcBrwG/U3AuJ
         kG2mlAnNJL+1/oPAN4MyzEW3FNl/Wj8Mf+HCzV/5S/G36JCJMHwDEtXUMIduDWMPWnLk
         SvdgBLoKkHiBdkM1hj7UfJddgh9v4ePes9LMUPvQ2Nv5rX3c8CNJ/UE+1RJJePxRIaoq
         SbpgMsp1ZcJ7W+GMwbOCGslT4LVrlOt6qvqmcPD0i3MkC3dk/wuAnNuDngsoQ189wgTe
         WsGSidl5DBpiZyrP8r+xCQIjpmM6/6UIHr+XRyxdtREwuIX7XvZSgTWPX9Q1fMQeNQeJ
         fOlg==
X-Forwarded-Encrypted: i=1; AJvYcCWGBV/LSLmCe5GAGvJCThS8CSR9PaDdJMqkKM1JVMyIblTNYtPAbynJONqabCxGZwCUsCgfAsZgo3JB2Yo/cVBeXgj8O5KIfq+q4Owv
X-Gm-Message-State: AOJu0YwadAf5t8kJDAjzBcISdv9DHi4VafZF8LbzK+N/+Aesy71s4y7w
	KRxDMdqMSTT99P0/iEt2LLjn+g2awxETWjCE6hjI44qtZ2z7qVnNv8lT9V56sVRji1sMU3mpXPY
	pfOXTIJGwAypZoYYiG/OOhuOHoj/Ldn0k9WlXpk8iAlv7LBlB2Zbiep94/faAkTCtOMNaBgdLXF
	FZHfTNt5pN+f7SdquD78si1KTjJ5lXw+6PYQ+o
X-Received: by 2002:a17:90a:590e:b0:2bd:9319:3da1 with SMTP id 98e67ed59e1d1-2bd93193deemr634200a91.25.1716258549715;
        Mon, 20 May 2024 19:29:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo2Z7xohL05uhMNAfGrDbx9YpWpz1z4P9YFEzrqlUWpKPu7N+uZF6UrdhiOEzsxGwb66VvqwEqJFlwaQIRHdY=
X-Received: by 2002:a17:90a:590e:b0:2bd:9319:3da1 with SMTP id
 98e67ed59e1d1-2bd93193deemr634190a91.25.1716258549414; Mon, 20 May 2024
 19:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com> <1716218462-84587-2-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1716218462-84587-2-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 May 2024 10:28:57 +0800
Message-ID: <CACGkMEvhs_-wD4p-i2VCmQnmdNPLsH9FkhkGePB5LxZQf4B30A@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] vhost-vdpa: flush workers on suspend
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 11:21=E2=80=AFPM Steve Sistare
<steven.sistare@oracle.com> wrote:
>
> Flush to guarantee no workers are running when suspend returns.
>
> Fixes: f345a0143b4d ("vhost-vdpa: uAPI to suspend the device")
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/vhost/vdpa.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ba52d128aeb7..189596caaec9 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -594,6 +594,7 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>         struct vdpa_device *vdpa =3D v->vdpa;
>         const struct vdpa_config_ops *ops =3D vdpa->config;
>         int ret;
> +       struct vhost_dev *vdev =3D &v->vdev;
>
>         if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
>                 return 0;
> @@ -601,6 +602,8 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>         if (!ops->suspend)
>                 return -EOPNOTSUPP;
>
> +       vhost_dev_flush(vdev);

vhost-vDPA doesn't use workers, see:

        vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
                       vhost_vdpa_process_iotlb_msg);

So I wonder if this is a must.

Thanks

> +
>         ret =3D ops->suspend(vdpa);
>         if (!ret)
>                 v->suspended =3D true;
> --
> 2.39.3
>


