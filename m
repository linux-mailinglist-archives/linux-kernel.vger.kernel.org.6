Return-Path: <linux-kernel+bounces-312384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AF29695D6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62455281119
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DD31DAC46;
	Tue,  3 Sep 2024 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ld5/o6L4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715D1D6DD1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349289; cv=none; b=OkkP8hwBb3UXnr7flkB0kihKdeHRAgWOX2QE01UrX0FjcVKjf9KauKCsjYEsjBTemchN9pEucqO9wX9P3Em1bq0G8WTRQIv7157i1bnJSs5tHGlBIEcYNJtOJzmYyQruK0Zk8PEqXiGzI68PEpCFxyGZYZiMscBD9vU6OkYPVRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349289; c=relaxed/simple;
	bh=NmZGb+MA+mXou1jnaR60KfjaG6/mC67CXIvC/9dCxeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCi8MAPydiwLH22X9jHLMjDU37UHusUIPOJShcqC0AhSIZqJO3vFQRIeScUB0tf3UTqCzfvYVwbXN654WUyPQ7MwZGTSVy77qaWxlDGntwKQddMMdJWE/fEfbprhQT1jA3onfIH6NIq0puU+gHlvHjDE5pI0QI3OvGmNhKWw1tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ld5/o6L4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725349286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmZGb+MA+mXou1jnaR60KfjaG6/mC67CXIvC/9dCxeQ=;
	b=Ld5/o6L4tKHdnObFngkvIb0R9doLao8g5eP9Al7zaDGH0lmpBtz7Xm7FpCkMDqut4iaFKp
	7AVQ69rUcg9PEuycbkm7D27Vdr/AOszO9CXEN5Jouuv+IfnLVG07iBSkLUNj0f9hcY+aW6
	68ZhYqwWKfwq8AuGpRjDqCpt9tcmhA0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-53NP3alhMhqJ9yYhLK3eyA-1; Tue, 03 Sep 2024 03:41:25 -0400
X-MC-Unique: 53NP3alhMhqJ9yYhLK3eyA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f3f61b42c2so58404251fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 00:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725349284; x=1725954084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmZGb+MA+mXou1jnaR60KfjaG6/mC67CXIvC/9dCxeQ=;
        b=ASolNioEiYlkPDdKDJFqc9aub6HHv+mrSP//HVLO/Eljixl1ZV2l+e/7vW66shln+d
         9IiynheoFa6yN7akwVeybAoTl+knQ6ijeY6UGfO0Yp0koZ6j5u56oJ2QoRWuDrHX1fHl
         cmDj5C4vn+IgWPqijR4t04X+GKdXWdzCAFBYtVX2n6WZUGlynFyU5OlaZbIz6U3wHRiI
         26aTG93UhGL6+m5VZBmVM7R58l/evvL5cpL16tCMe0TPCGhyFS7z4LdzOLXIugXYmKyQ
         3v+pb2h+PmRCpkBGHcLahlbOccZR5iJlbiLjXjenDEQ7/fl/workDjlIS2cz9iWAYCfA
         lHFA==
X-Forwarded-Encrypted: i=1; AJvYcCWbBn/h3HNHobpna7D7h8t4gfGBj7sL+wBooiA4fmUl8hPaidygwAH56jiWWtH0oD2tJJb29RkoUI44vqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPrjC4JIfnynEXOz2oAp7LMm7kcSKQdebEGCICZaWaVVeQr5Yg
	2WYMiXiDHWlHSmBrXEwlGKN+V6Ab+S/bEhh0066Pa9u0ocayMw7UBkILz+A+6a6UbY3QMW4JFYO
	CHhSHTv5aY7E35+cnYsiGMT1fISR0Su8ZmX37BCTP2V7EdGoLcnTNxdyrsntWBFpz/d6Wo2mCXC
	KKW4ZwY6EhJoYrIyPoLKnpk3LlFRdbOQ0ZvF8V
X-Received: by 2002:a2e:a9a8:0:b0:2f3:ed2d:a944 with SMTP id 38308e7fff4ca-2f6105d7638mr150706111fa.15.1725349284132;
        Tue, 03 Sep 2024 00:41:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+2y0Ox29ncWXSJQ27vWedil4q1hbIeNw26N6BH7DRSWODvYcgpZIEbdqPrK/1dWOWpcepNHdpzljzxOVI1xg=
X-Received: by 2002:a2e:a9a8:0:b0:2f3:ed2d:a944 with SMTP id
 38308e7fff4ca-2f6105d7638mr150705531fa.15.1725349283019; Tue, 03 Sep 2024
 00:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816090159.1967650-1-dtatulea@nvidia.com> <CAJaqyWfwkNUYcMWwG4LthhYEquUYDJPRvHeyh9C_R-ioeFYuXw@mail.gmail.com>
 <CAPpAL=xGQvpKwe8WcfHX8e59EdpZbOiohRS1qgeR4axFBDQ_+w@mail.gmail.com> <ea127c85-7080-4679-bff1-3a3a253f9046@nvidia.com>
In-Reply-To: <ea127c85-7080-4679-bff1-3a3a253f9046@nvidia.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 3 Sep 2024 15:40:45 +0800
Message-ID: <CAPpAL=wDKacuWu-wgbwSN3MORSMapU8=RAdzp3ePgPo=6EMFbg@mail.gmail.com>
Subject: Re: [PATCH vhost v2 00/10] vdpa/mlx5: Parallelize device suspend/resume
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Michael Tsirkin <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leon@kernel.org>, kvm@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Saeed Mahameed <saeedm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 7:05=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> Hi Lei,
>
> On 02.09.24 12:03, Lei Yang wrote:
> > Hi Dragos
> >
> > QE tested this series with mellanox nic, it failed with [1] when
> > booting guest, and host dmesg also will print messages [2]. This bug
> > can be reproduced boot guest with vhost-vdpa device.
> >
> > [1] qemu) qemu-kvm: vhost VQ 1 ring restore failed: -1: Operation not
> > permitted (1)
> > qemu-kvm: vhost VQ 0 ring restore failed: -1: Operation not permitted (=
1)
> > qemu-kvm: unable to start vhost net: 5: falling back on userspace virti=
o
> > qemu-kvm: vhost_set_features failed: Device or resource busy (16)
> > qemu-kvm: unable to start vhost net: 16: falling back on userspace virt=
io
> >
> > [2] Host dmesg:
> > [ 1406.187977] mlx5_core 0000:0d:00.2:
> > mlx5_vdpa_compat_reset:3267:(pid 8506): performing device reset
> > [ 1406.189221] mlx5_core 0000:0d:00.2:
> > mlx5_vdpa_compat_reset:3267:(pid 8506): performing device reset
> > [ 1406.190354] mlx5_core 0000:0d:00.2:
> > mlx5_vdpa_show_mr_leaks:573:(pid 8506) warning: mkey still alive after
> > resource delete: mr: 000000000c5ccca2, mkey: 0x40000000, refcount: 2
> > [ 1471.538487] mlx5_core 0000:0d:00.2: cb_timeout_handler:938:(pid
> > 428): cmd[13]: MODIFY_GENERAL_OBJECT(0xa01) Async, timeout. Will cause
> > a leak of a command resource
> > [ 1471.539486] mlx5_core 0000:0d:00.2: cb_timeout_handler:938:(pid
> > 428): cmd[12]: MODIFY_GENERAL_OBJECT(0xa01) Async, timeout. Will cause
> > a leak of a command resource
> > [ 1471.540351] mlx5_core 0000:0d:00.2: modify_virtqueues:1617:(pid
> > 8511) error: modify vq 0 failed, state: 0 -> 0, err: 0
> > [ 1471.541433] mlx5_core 0000:0d:00.2: modify_virtqueues:1617:(pid
> > 8511) error: modify vq 1 failed, state: 0 -> 0, err: -110
> > [ 1471.542388] mlx5_core 0000:0d:00.2: mlx5_vdpa_set_status:3203:(pid
> > 8511) warning: failed to resume VQs
> > [ 1471.549778] mlx5_core 0000:0d:00.2:
> > mlx5_vdpa_show_mr_leaks:573:(pid 8511) warning: mkey still alive after
> > resource delete: mr: 000000000c5ccca2, mkey: 0x40000000, refcount: 2
> > [ 1512.929854] mlx5_core 0000:0d:00.2:
> > mlx5_vdpa_compat_reset:3267:(pid 8565): performing device reset
> > [ 1513.100290] mlx5_core 0000:0d:00.2:
> > mlx5_vdpa_show_mr_leaks:573:(pid 8565) warning: mkey still alive after
> > resource delete: mr: 000000000c5ccca2, mkey: 0x40000000, refcount: 2
> >

Hi Dragos

> Can you provide more details about the qemu version and the vdpa device
> options used?
>
> Also, which FW version are you using? There is a relevant bug in FW
> 22.41.1000 which was fixed in the latest FW (22.42.1000). Did you
> encounter any FW syndromes in the host dmesg log?

This problem has gone when I updated the firmware version to
22.42.1000, and I tested it with regression tests using mellanox nic,
everything works well.

Tested-by: Lei Yang <leiyang@redhat.com>
>
> Thanks,
> Dragos
>


