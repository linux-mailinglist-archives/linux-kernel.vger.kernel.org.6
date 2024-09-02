Return-Path: <linux-kernel+bounces-311023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CF796840C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71682B247D4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4FF13C9B8;
	Mon,  2 Sep 2024 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Stfh4Uqi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDADE13B580
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271463; cv=none; b=Cm6MWhUYGIxVeeM23rNUgFm/HkH19F2HIYFCWaSAiBoKC7RxWCHe+1/VfnR/6vEY5htJK/OxvGQvJ7X8NpU6/CM3kV4YxrpZWApxsZu9ycxL1CUrI4Z0DSl2eP3pXHBwgvnotW/AleT/Cd/8c/uavzJCneXpcI38Sj839aJkOyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271463; c=relaxed/simple;
	bh=1Gy5ROiwQJJO9oMaCCxrG7aibSYEu/UpXyiNyunXbfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCrT7+Hw9Ka5fwl9F2sRP3aRrXE9LvJmC4Q9w3hhwwOUupLC5FIfsnZ7mc03z8wkU9ZuJ8XYOjnWxODhi56/qt2jX0AurGuSpay8A2qoolrerChPqfZGFEt8SOrwEBpQ44TGx0KMCtFyX17q46OKYsnHYGqXLSoI6nUMhnaGEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Stfh4Uqi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725271461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ie8OFN0GPfRB9t4uKG5JuFRs18zAhr60LEccBUs+PdU=;
	b=Stfh4UqiJ/U37WYVY18as5I2SUcdQp4gV+Mb4iwQwylmkEbiyvMBrRiNBVSlWw1Xl0mE2C
	RVZop/hhnKcq7G11neo1XZSo1l1ojqpoKp6n+oAQUeToD+DtxZfl+8NzJ1Gztv+myDPaKf
	cykjjB3FQbBvAk9Hl9L2U+Oyi2UQqGc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-AuwcYsIkOFiF2Wnqp6QXJQ-1; Mon, 02 Sep 2024 06:04:19 -0400
X-MC-Unique: AuwcYsIkOFiF2Wnqp6QXJQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a870cad2633so376882166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725271458; x=1725876258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ie8OFN0GPfRB9t4uKG5JuFRs18zAhr60LEccBUs+PdU=;
        b=Xb8RUZVWL1lCOrG+KPLp0YriswoHqufi+irP/zOuPzH3MtZwqnNiQTx6MuN0T8HUlk
         gRWk2jfYpR+fqNACjKOgYIc6+jz8gVyCfu65KbPe6wbZAduNFauIhNyYIyDgFsVcFUTz
         LJBUk0YLiVKwZTkPYAC6mBLVnt4SOpgtJJirC6insCVs9KhZ34FCbEl13PP+2waSxo7I
         ER51umW7i3tBXlA0xBvOOv2QDB9JLfW/K7PLGf7SY5PCi0QqfVgND7j2usHY5GxjLMnP
         9Sxne5dPTaBAJkoHWpY2BDEMvnEpvJNRV0PZ1/UiyvuDGcQI7SB9JH8Q/b/YsPWc+zDz
         eUUA==
X-Forwarded-Encrypted: i=1; AJvYcCX5fbaJGpaFhkgIIGaI74fPx05h7aJ7HI6iN4ygQ7PyUUT+YfptXyWy1yqRmfiLnSf/7R9BvaJ9kKtaUOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc7HVZPbirOF1fk540ZXldukZ4a/Gbbyuq7PVcKA+1WIZ6YYht
	hF6d8/qeE/ilMmkOcx2bGPkXrcXc1kldjJoS/0ZQNbtJmldq1l/O38fvvdBb1EHN5XsaSj5daGb
	TmQfjQHJVt6dH0jltJLzL3J2yV5R96zA/smiERqfftPJNOygpXLWQ2YMQ9x3WnPfg2B55cp2V3m
	80uxOdZxAwPqJAx+GJk4SsGKPhj9LwRvkReQKk
X-Received: by 2002:a17:907:72d3:b0:a88:a48d:2b9a with SMTP id a640c23a62f3a-a897fa74459mr988546366b.52.1725271458512;
        Mon, 02 Sep 2024 03:04:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1kxKnbkvEfLFVflp4jaSLPmVyXctTqLe0cqw7LvdiW4hckvb1eweF4ThQJBsaRbv4+DVAoodYhVeTUKoFzuc=
X-Received: by 2002:a17:907:72d3:b0:a88:a48d:2b9a with SMTP id
 a640c23a62f3a-a897fa74459mr988542066b.52.1725271457591; Mon, 02 Sep 2024
 03:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816090159.1967650-1-dtatulea@nvidia.com> <CAJaqyWfwkNUYcMWwG4LthhYEquUYDJPRvHeyh9C_R-ioeFYuXw@mail.gmail.com>
In-Reply-To: <CAJaqyWfwkNUYcMWwG4LthhYEquUYDJPRvHeyh9C_R-ioeFYuXw@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 2 Sep 2024 18:03:41 +0800
Message-ID: <CAPpAL=xGQvpKwe8WcfHX8e59EdpZbOiohRS1qgeR4axFBDQ_+w@mail.gmail.com>
Subject: Re: [PATCH vhost v2 00/10] vdpa/mlx5: Parallelize device suspend/resume
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Michael Tsirkin <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leon@kernel.org>, kvm@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Saeed Mahameed <saeedm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Hi Dragos

QE tested this series with mellanox nic, it failed with [1] when
booting guest, and host dmesg also will print messages [2]. This bug
can be reproduced boot guest with vhost-vdpa device.

[1] qemu) qemu-kvm: vhost VQ 1 ring restore failed: -1: Operation not
permitted (1)
qemu-kvm: vhost VQ 0 ring restore failed: -1: Operation not permitted (1)
qemu-kvm: unable to start vhost net: 5: falling back on userspace virtio
qemu-kvm: vhost_set_features failed: Device or resource busy (16)
qemu-kvm: unable to start vhost net: 16: falling back on userspace virtio

[2] Host dmesg:
[ 1406.187977] mlx5_core 0000:0d:00.2:
mlx5_vdpa_compat_reset:3267:(pid 8506): performing device reset
[ 1406.189221] mlx5_core 0000:0d:00.2:
mlx5_vdpa_compat_reset:3267:(pid 8506): performing device reset
[ 1406.190354] mlx5_core 0000:0d:00.2:
mlx5_vdpa_show_mr_leaks:573:(pid 8506) warning: mkey still alive after
resource delete: mr: 000000000c5ccca2, mkey: 0x40000000, refcount: 2
[ 1471.538487] mlx5_core 0000:0d:00.2: cb_timeout_handler:938:(pid
428): cmd[13]: MODIFY_GENERAL_OBJECT(0xa01) Async, timeout. Will cause
a leak of a command resource
[ 1471.539486] mlx5_core 0000:0d:00.2: cb_timeout_handler:938:(pid
428): cmd[12]: MODIFY_GENERAL_OBJECT(0xa01) Async, timeout. Will cause
a leak of a command resource
[ 1471.540351] mlx5_core 0000:0d:00.2: modify_virtqueues:1617:(pid
8511) error: modify vq 0 failed, state: 0 -> 0, err: 0
[ 1471.541433] mlx5_core 0000:0d:00.2: modify_virtqueues:1617:(pid
8511) error: modify vq 1 failed, state: 0 -> 0, err: -110
[ 1471.542388] mlx5_core 0000:0d:00.2: mlx5_vdpa_set_status:3203:(pid
8511) warning: failed to resume VQs
[ 1471.549778] mlx5_core 0000:0d:00.2:
mlx5_vdpa_show_mr_leaks:573:(pid 8511) warning: mkey still alive after
resource delete: mr: 000000000c5ccca2, mkey: 0x40000000, refcount: 2
[ 1512.929854] mlx5_core 0000:0d:00.2:
mlx5_vdpa_compat_reset:3267:(pid 8565): performing device reset
[ 1513.100290] mlx5_core 0000:0d:00.2:
mlx5_vdpa_show_mr_leaks:573:(pid 8565) warning: mkey still alive after
resource delete: mr: 000000000c5ccca2, mkey: 0x40000000, refcount: 2

Thanks
Lei




> This series parallelizes the mlx5_vdpa device suspend and resume
> operations through the firmware async API. The purpose is to reduce live
> migration downtime.
>
> The series starts with changing the VQ suspend and resume commands
> to the async API. After that, the switch is made to issue multiple
> commands of the same type in parallel.
>
> Then, the an additional improvement is added: keep the notifiers enabled
> during suspend but make it a NOP. Upon resume make sure that the link
> state is forwarded. This shaves around 30ms per device constant time.
>
> Finally, use parallel VQ suspend and resume during the CVQ MQ command.
>
> For 1 vDPA device x 32 VQs (16 VQPs), on a large VM (256 GB RAM, 32 CPUs
> x 2 threads per core), the improvements are:
>
> +-------------------+--------+--------+-----------+
> | operation         | Before | After  | Reduction |
> |-------------------+--------+--------+-----------|
> | mlx5_vdpa_suspend | 37 ms  | 2.5 ms |     14x   |
> | mlx5_vdpa_resume  | 16 ms  | 5 ms   |      3x   |
> +-------------------+--------+--------+-----------+
>
> ---
> v2:
> - Changed to parallel VQ suspend/resume during CVQ MQ command.
>   Support added in the last 2 patches.
> - Made the fw async command more generic and moved it to resources.c.
>   Did that because the following series (parallel mkey ops) needs this
>   code as well.
>   Dropped Acked-by from Eugenio on modified patches.
> - Fixed kfree -> kvfree.
> - Removed extra newline caught during review.
> - As discussed in the v1, the series can be pulled in completely in
>   the vhost tree [0]. The mlx5_core patch was reviewed by Tariq who is
>   also a maintainer for mlx5_core.
>
> [0] - https://lore.kernel.org/virtualization/6582792d-8db2-4bc0-bf3a-248fe5c8fc56@nvidia.com/T/#maefabb2fde5adfb322d16ca16ae64d540f75b7d2
>
> Dragos Tatulea (10):
>   net/mlx5: Support throttled commands from async API
>   vdpa/mlx5: Introduce error logging function
>   vdpa/mlx5: Introduce async fw command wrapper
>   vdpa/mlx5: Use async API for vq query command
>   vdpa/mlx5: Use async API for vq modify commands
>   vdpa/mlx5: Parallelize device suspend
>   vdpa/mlx5: Parallelize device resume
>   vdpa/mlx5: Keep notifiers during suspend but ignore
>   vdpa/mlx5: Small improvement for change_num_qps()
>   vdpa/mlx5: Parallelize VQ suspend/resume for CVQ MQ command
>
>  drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h            |  22 +
>  drivers/vdpa/mlx5/core/resources.c            |  73 ++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c             | 396 +++++++++++-------
>  4 files changed, 361 insertions(+), 151 deletions(-)
>
> --
> 2.45.1
>


