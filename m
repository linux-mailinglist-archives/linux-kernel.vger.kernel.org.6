Return-Path: <linux-kernel+bounces-577071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA6AA71805
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C40C1888E29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AC21DBB03;
	Wed, 26 Mar 2025 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOkodoFu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CFB14A09C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997692; cv=none; b=UJ/x+qqKfz8ZvkQEaeBYPXNWA9y1hd7gaN2Z0rmQt9NZozRjrGJJHv4X9Nl/S1Tpdqbg/Hs0VQtlYGYQfqwE0PwQNUPZbsBlW+S+z5XJDAZvGLi9WR6KJhV9axzqApuNSnpHLCobRs+dEgZf3hly3aQuO9PTUsOLhRhw88hTNYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997692; c=relaxed/simple;
	bh=OzD2J58SYOwB2yDqTE1mn52U7OmtWFJwIChYYjGgtbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CH/K2v1qDAstwcwowwmParfPT55iDijPLq+S0BbF3JrmQIhQ8UJm17aaxlonxRSSI/ikYuu8o6Rcyp79csWQPDG52QxQdmYnE2NfoKA3GDW9A7o6KByLVx9hKfaoYiWClxt1xbAjIBTnmR+3HfbjaotdP+Yrmt7ySOY0Pmppliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOkodoFu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742997690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5ynOER4mzzMilZC5d1UHwb8YZwTVg8BWon4ImvG5J8=;
	b=cOkodoFuVqdZ0R/m3LVGrMWz5xVd3cT8ULXzgUWEylTZD8VCD7Kha8smAb2CWMZr094aUP
	to/LrMV4k46aK8oWXT57TNJf9F9q8vev82y7ZG99jaOPTmVLM7LHdidKEJzYhIaf0YB1EK
	kh7l9ffLc8O47/nYXVVucrX77x9NulU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-yFA67TdUMU22_XJba17Vpw-1; Wed, 26 Mar 2025 10:01:28 -0400
X-MC-Unique: yFA67TdUMU22_XJba17Vpw-1
X-Mimecast-MFC-AGG-ID: yFA67TdUMU22_XJba17Vpw_1742997687
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac2db121f95so524924366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997687; x=1743602487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5ynOER4mzzMilZC5d1UHwb8YZwTVg8BWon4ImvG5J8=;
        b=rfrExI/7fQxRPftkvcIQidJYvYnWNJZC7bwN/KvJk8HiT0ZP+tRZuhKTqWPDSNE0W7
         61OP9buAcmHS4aYLt8iAjMyuGp8f+D5yJfQ8GAaQOAcEZ3PqfqjGgnuNLF1xUpQh34Us
         zpuVfPFxe9gS8t+kpRFoeOTgq+f9vLSgqoyNv46TfDZB0ckCAD9NsozPT3wX53TG7v5e
         QArcpS51P22GR9lY80pTePmGIC6fwLwStV+h7JOgaRqgtkrY4OzZKMlH+57L5IUN+gC4
         bEL4ofKNeuWLs3OpARjYNaqGJSkZy0Y1040k26ePcMehHjmRbpmTvlUrk5xroyPDA6PZ
         ja8g==
X-Forwarded-Encrypted: i=1; AJvYcCWMPkQ5xAfZSIGDFcgsyw/HzNxDnE1UatCNubuMzVD9oXmbjAOlU4+WO1QG/jEA/GKqmrOlCEfFxQ0n7KM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1NWnvYydzjr0UkvtVytate5FHzKqOMrOD868UBQb4FUBjLvOC
	SiSc7yYnvpIz/peJn92SjFUZzsjOOudK02KIuz5R3O9qOa2cpWidtYidMga8yszyELD08HTPRzp
	YBsTaUgrBA4KnKIPS7oSQDigIqQPQFMHIeZc0rJ/ZgR6vVEWeKsA8rtT6YvVVW692K9PW4qJTxo
	/SEHX6dR2GNrG7FHcUcVfXSECYfnHatcq1ZWXO
X-Gm-Gg: ASbGncv0f23dR/Hy621UL6d0ooTV6jKCh6KDwVXTLYQqYLYLhqcZflwRSKwbju8WlXg
	eE6lMmqcMD7rRLEJSJTH4FIYEBfKEyGppcGBB6wYLLSeekd9AH6+XYuqSJCwjWbKbsS6bsA8=
X-Received: by 2002:a17:907:7e5e:b0:ac4:5f1:a129 with SMTP id a640c23a62f3a-ac405f1a286mr1833708666b.15.1742997686336;
        Wed, 26 Mar 2025 07:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSZWMfF0qvpznduI2fyVWwvyCi88++3cklgjOFWP+86MHvJ8ZbEJ5hy7FQdtX0Z8LvVrmee6EcMcbESp39/80=
X-Received: by 2002:a17:907:7e5e:b0:ac4:5f1:a129 with SMTP id
 a640c23a62f3a-ac405f1a286mr1833701966b.15.1742997685769; Wed, 26 Mar 2025
 07:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324060127.2358-4-jasowang@redhat.com>
In-Reply-To: <20250324060127.2358-4-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 15:00:48 +0100
X-Gm-Features: AQ5f1JofivsiKPGTGocKmP1oEUGTJ8yrW1FHIDHFG3jB8_FllpLx33EoChopQ5A
Message-ID: <CAJaqyWeuPSQZJip-z3_g-HEP0jVP7JH6gskpi-uPJOPQkR+Yug@mail.gmail.com>
Subject: Re: [PATCH 16/19] virtio_ring: factor out core logic for updating last_used_idx
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Factor out the core logic for updating last_used_idx to be reused by
> the packed in order implementation.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 43 +++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fe3e6f3d0f96..bd4faf04862c 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1749,6 +1749,30 @@ static bool more_used_packed(const struct vring_vi=
rtqueue *vq)
>         return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
>  }
>
> +static void update_last_used_idx_packed(struct vring_virtqueue *vq,
> +                                       u16 id, u16 last_used,
> +                                       u16 used_wrap_counter)
> +{
> +       last_used +=3D vq->packed.desc_state[id].num;
> +       if (unlikely(last_used >=3D vq->packed.vring.num)) {
> +               last_used -=3D vq->packed.vring.num;
> +               used_wrap_counter ^=3D 1;
> +       }
> +
> +       last_used =3D (last_used | (used_wrap_counter << VRING_PACKED_EVE=
NT_F_WRAP_CTR));
> +       WRITE_ONCE(vq->last_used_idx, last_used);
> +
> +       /*
> +        * If we expect an interrupt for the next entry, tell host
> +        * by writing event index and flush out the write before
> +        * the read in the next get_buf call.
> +        */
> +       if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_FLAG_=
DESC)
> +               virtio_store_mb(vq->weak_barriers,
> +                               &vq->packed.vring.driver->off_wrap,
> +                               cpu_to_le16(vq->last_used_idx));
> +}
> +
>  static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
>                                           unsigned int *len,
>                                           void **ctx)
> @@ -1792,24 +1816,7 @@ static void *virtqueue_get_buf_ctx_packed(struct v=
ring_virtqueue *vq,
>         ret =3D vq->packed.desc_state[id].data;
>         detach_buf_packed(vq, id, ctx);
>
> -       last_used +=3D vq->packed.desc_state[id].num;
> -       if (unlikely(last_used >=3D vq->packed.vring.num)) {
> -               last_used -=3D vq->packed.vring.num;
> -               used_wrap_counter ^=3D 1;
> -       }
> -
> -       last_used =3D (last_used | (used_wrap_counter << VRING_PACKED_EVE=
NT_F_WRAP_CTR));
> -       WRITE_ONCE(vq->last_used_idx, last_used);
> -
> -       /*
> -        * If we expect an interrupt for the next entry, tell host
> -        * by writing event index and flush out the write before
> -        * the read in the next get_buf call.
> -        */
> -       if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_FLAG_=
DESC)
> -               virtio_store_mb(vq->weak_barriers,
> -                               &vq->packed.vring.driver->off_wrap,
> -                               cpu_to_le16(vq->last_used_idx));
> +       update_last_used_idx_packed(vq, id, last_used, used_wrap_counter)=
;
>
>         LAST_ADD_TIME_INVALID(vq);
>
> --
> 2.42.0
>


