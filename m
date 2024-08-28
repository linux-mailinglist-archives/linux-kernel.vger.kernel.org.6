Return-Path: <linux-kernel+bounces-304192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A55961BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06A81F246C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B58E3FBA7;
	Wed, 28 Aug 2024 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaQbKtUn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40291D555
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724810038; cv=none; b=HiwoB9cMxBU8JnxbhAnTvx6/fftPnsefR8lQosTdzcH1ucA91WzUhsdJC8b9hK9B1SUWx5aLmEbxF/BnncDazvDpUNzpP/poqcb+M55x+y/9BUg6jQbz4BjB+lF1y0FzHQJMj3e3Gj/thLMul6JPCY1xRuLCnLOG9OBdNQHgbu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724810038; c=relaxed/simple;
	bh=Ihnt1ar3JfRypvQqp4iSOHFZC2B1REpR9Hs1iceNJg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8Ib1Pg8iv8JmhecUWRHFilzRnmZfh1yAlsvh32H3zaUbwZv+szNfaWG7S1ZHfzzpl6oR0LomtG2q3TJwaC1u5PuSdlhcMXBXtcZdW5qlOlHksTdk/zN8Gm7j2EQ7YxvOuLDs8OzjZrWdodh70AMMyRGyYfST8Ic15UKe5crWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PaQbKtUn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724810035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOQmDHNk02iEFdI9Q/VFdgwzXnB003Qij7WxsoYEhlE=;
	b=PaQbKtUngN9B0/7aI8dyGbm/CTBN/oJX0A9dM5+MTSjHr826FQL2gq2KDayTkXc4hTTnPP
	F+Y7yJYd7z/5THvPPTibPGfHIUpHYU4bBq6hj/fQchTD0NTkmR2ZdBFwVjnXEN+wkZmLxz
	eg7fYEuhFNkxZVP2f6qqizpV4ytFm3I=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-8-S8OqxxOWiMKoMpncq0hA-1; Tue, 27 Aug 2024 21:51:31 -0400
X-MC-Unique: 8-S8OqxxOWiMKoMpncq0hA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7cda25df5a5so4689816a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724809890; x=1725414690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOQmDHNk02iEFdI9Q/VFdgwzXnB003Qij7WxsoYEhlE=;
        b=Wnd2Ax1mnKHlCkwEnib5Uti0eXsT81AuKvPIlNsOFzbsc+v1rEhH/6jqduu0ZSKQha
         BZzmH5OKSna72CmSi6GwJYYSWR9gAE1WMAELEVtEM6Xu83UD+utSa3ttjhLegrzlKrt8
         fOaYUw65A7Lkq3cT17XvD3IoxrU6fO9oq/yQYzCLcd61ySBf36vpyM6MT/8mZfHS23FW
         16cHPK/U0uXf33DOQyZoW/VFThAsseHElefSM449nfyJzV5mlze/BpZOoerGxodgda3j
         B0yBNJs5O3dgIBs63v2e0gasHbdwY1av/rZjcPIQoBbTTQKdAARLl4KbOEzxla2M9GLb
         JnDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtrqjNMCoTkuzWd775mdBXmxOuQuMF0PxFrnGKZSur+66RNIaaFnF9F53SoNu8/d8GZfEGaLVstK/me24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXCN+GtYSZmJsWhXfw2OnKVZbN9UoFMGqKWg/4i3s4my6XocRJ
	2iXxpsPo6hSxcq0nMzbifcCAD+Ehzvzx83yxD/gwlVODGvC6i7GFXq7nX8sVuV28z5jLZnL88m9
	r07QRfv5TLZhAJfG2JvkZyBTwkKW4SHc3o/A4rYp9vmNlR+R5NwnL3pk2cHkYeAdT+ifz710EKt
	AUnvxqRIC6uXmKr8Zlu87drXBMM2/0rC3tTZP4
X-Received: by 2002:a05:6a21:330b:b0:1c6:ee92:e5f4 with SMTP id adf61e73a8af0-1cc8b653a76mr14216690637.54.1724809890423;
        Tue, 27 Aug 2024 18:51:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP52rbqS7MZVJt7hO2qpm29QtWCdUrTg52A32PylwCwqLsssQwwvk+YdMqQNy/RJvBvWf34lMfe2sQQ0Eg26Y=
X-Received: by 2002:a05:6a21:330b:b0:1c6:ee92:e5f4 with SMTP id
 adf61e73a8af0-1cc8b653a76mr14216668637.54.1724809889810; Tue, 27 Aug 2024
 18:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827160808.2448017-2-dtatulea@nvidia.com>
In-Reply-To: <20240827160808.2448017-2-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Aug 2024 09:51:18 +0800
Message-ID: <CACGkMEvo1+T=d3zFeQJK4rit1G_dQJHaGupJ3EKS9VGq2bi_Hg@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix invalid mr resource destroy
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:08=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Certain error paths from mlx5_vdpa_dev_add() can end up releasing mr
> resources which never got initialized in the first place.
>
> This patch adds the missing check in mlx5_vdpa_destroy_mr_resources()
> to block releasing non-initialized mr resources.
>
> Reference trace:
>
>   mlx5_core 0000:08:00.2: mlx5_vdpa_dev_add:3274:(pid 2700) warning: No m=
ac address provisioned?
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 140216067 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 8 PID: 2700 Comm: vdpa Kdump: loaded Not tainted 5.14.0-496.el9.x8=
6_64 #1
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-g=
f21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:vhost_iotlb_del_range+0xf/0xe0 [vhost_iotlb]
>   Code: [...]
>   RSP: 0018:ff1c823ac23077f0 EFLAGS: 00010246
>   RAX: ffffffffc1a21a60 RBX: ffffffff899567a0 RCX: 0000000000000000
>   RDX: ffffffffffffffff RSI: 0000000000000000 RDI: 0000000000000000
>   RBP: ff1bda1f7c21e800 R08: 0000000000000000 R09: ff1c823ac2307670
>   R10: ff1c823ac2307668 R11: ffffffff8a9e7b68 R12: 0000000000000000
>   R13: 0000000000000000 R14: ff1bda1f43e341a0 R15: 00000000ffffffea
>   FS:  00007f56eba7c740(0000) GS:ff1bda269f800000(0000) knlGS:00000000000=
00000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000000 CR3: 0000000104d90001 CR4: 0000000000771ef0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   PKRU: 55555554
>   Call Trace:
>
>    ? show_trace_log_lvl+0x1c4/0x2df
>    ? show_trace_log_lvl+0x1c4/0x2df
>    ? mlx5_vdpa_free+0x3d/0x150 [mlx5_vdpa]
>    ? __die_body.cold+0x8/0xd
>    ? page_fault_oops+0x134/0x170
>    ? __irq_work_queue_local+0x2b/0xc0
>    ? irq_work_queue+0x2c/0x50
>    ? exc_page_fault+0x62/0x150
>    ? asm_exc_page_fault+0x22/0x30
>    ? __pfx_mlx5_vdpa_free+0x10/0x10 [mlx5_vdpa]
>    ? vhost_iotlb_del_range+0xf/0xe0 [vhost_iotlb]
>    mlx5_vdpa_free+0x3d/0x150 [mlx5_vdpa]
>    vdpa_release_dev+0x1e/0x50 [vdpa]
>    device_release+0x31/0x90
>    kobject_cleanup+0x37/0x130
>    mlx5_vdpa_dev_add+0x2d2/0x7a0 [mlx5_vdpa]
>    vdpa_nl_cmd_dev_add_set_doit+0x277/0x4c0 [vdpa]
>    genl_family_rcv_msg_doit+0xd9/0x130
>    genl_family_rcv_msg+0x14d/0x220
>    ? __pfx_vdpa_nl_cmd_dev_add_set_doit+0x10/0x10 [vdpa]
>    ? _copy_to_user+0x1a/0x30
>    ? move_addr_to_user+0x4b/0xe0
>    genl_rcv_msg+0x47/0xa0
>    ? __import_iovec+0x46/0x150
>    ? __pfx_genl_rcv_msg+0x10/0x10
>    netlink_rcv_skb+0x54/0x100
>    genl_rcv+0x24/0x40
>    netlink_unicast+0x245/0x370
>    netlink_sendmsg+0x206/0x440
>    __sys_sendto+0x1dc/0x1f0
>    ? do_read_fault+0x10c/0x1d0
>    ? do_pte_missing+0x10d/0x190
>    __x64_sys_sendto+0x20/0x30
>    do_syscall_64+0x5c/0xf0
>    ? __count_memcg_events+0x4f/0xb0
>    ? mm_account_fault+0x6c/0x100
>    ? handle_mm_fault+0x116/0x270
>    ? do_user_addr_fault+0x1d6/0x6a0
>    ? do_syscall_64+0x6b/0xf0
>    ? clear_bhb_loop+0x25/0x80
>    ? clear_bhb_loop+0x25/0x80
>    ? clear_bhb_loop+0x25/0x80
>    ? clear_bhb_loop+0x25/0x80
>    ? clear_bhb_loop+0x25/0x80
>    entry_SYSCALL_64_after_hwframe+0x78/0x80
>
> Fixes: 512c0cdd80c1 ("vdpa/mlx5: Decouple cvq iotlb handling from hw mapp=
ing code")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/core/mr.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 4758914ccf86..bf56f3d69625 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -581,6 +581,9 @@ static void mlx5_vdpa_show_mr_leaks(struct mlx5_vdpa_=
dev *mvdev)
>
>  void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
>  {
> +       if (!mvdev->res.valid)
> +               return;
> +
>         for (int i =3D 0; i < MLX5_VDPA_NUM_AS; i++)
>                 mlx5_vdpa_update_mr(mvdev, NULL, i);
>
> --
> 2.45.1
>


