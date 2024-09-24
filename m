Return-Path: <linux-kernel+bounces-337610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCD6984C69
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726E91C22B65
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC6813CF86;
	Tue, 24 Sep 2024 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuVsvKdt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F817F460
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727211058; cv=none; b=kjV8IOwD35BVZG4kPphdNhq54xOClsMO84KX+4XIPHI8b2x5Nxx6enuwco7nrSuvrTcIon66M4FxDO2vLwtpfQEcO/B32mXG3xaa2U64YYkIRWu7GNP1HBblvebP1WAVwruaem1N/Mxz7SDQYadycKWJywEFO16yarK2kI8yPzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727211058; c=relaxed/simple;
	bh=q1Fzh6XcLCvsZX97wtdGvG+wbgRVQb9FWzltMHxrYhU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TlqW0RZrCZ25pLCNlegQJCrFMQ9iEZzDKyhGhMn4/vgsg8e4qxirRDTYBLXWJh0R09je2vr0zaVAZv4JHx0BGMn9yiXLGnb4OjOBNK3HtM7tSsORq90NoPzbtmFQzK4e3zkA04x++BQBKzMSLJbVuH5Okm9PHPg39+sxHx/KmSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XuVsvKdt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727211054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Ha73YKMkXYy714HDQl55jm40mWYNmGrnegcmLNCX6UI=;
	b=XuVsvKdtbddFmvyhBgg5KQsLKtsRxYVy0lJ7n+m1DIwADGtrWygpIojbUzoWlZxkj0VhMs
	LUmY5nZ5uwrRWj+s9FYG4aelFLENAvxd8pghWhpqxoYJ4g8mhiwFRLzQvTb3hrKqb8jZjU
	8q8aBfPypiEUEIdGfJ9btJOiZwIWTls=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-REO2jbbyMP2VlxWP07Az7A-1; Tue, 24 Sep 2024 16:50:52 -0400
X-MC-Unique: REO2jbbyMP2VlxWP07Az7A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb808e9fcso38260565e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727211051; x=1727815851;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha73YKMkXYy714HDQl55jm40mWYNmGrnegcmLNCX6UI=;
        b=wiJAVEhtUtGTka25qBaA+jsqF6ioV9MjxvFLJ/jlJ7wSh9EFxG7UCGqXRIBvjN818C
         UejTVE8aLXoGgF0Q0IqErItFlpBAVr7RM2ZstHWsEI0kXYWXg0LVS8kCsep6HIAKUypj
         D/ZF8ZuQwnFZdF6a4OGyEKuHdTLenu5Qqs2cyjYl8wuiXzF9gzFFA6Uox4zvMpIidXF1
         aJmruGXZTnuFr0dt2Tf9jnkIaVkBw6i6P0IbwanSxKuLMa1ZWmdmiBeJRJhEFPnAfGmV
         TSwxsU+p9uPa+KsriLfOYH2kOKGVwTM9HVJsFY2TYrMRNYMNCQrTRV6f5S1j31rXf8P9
         JARg==
X-Forwarded-Encrypted: i=1; AJvYcCXERuvyv81SLsnnThnSE85YmWOrlDDNal+gAQKKmKpsp28OOsb5gUc5BMVzD0Ck1x/KIzP2ZjeRa2N3/u4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdTnNiD3NGcimltAHG9uk2l1+7M5WSOm4uts5wFZWmDZbVKEYG
	N1mHo9Sq1ZgMAGhMKvQpzLCrchoqNarlRFjYQhjZxRx7k5cavLZWBypqGtTzo4yOSGNrd3nDK8n
	OIlq6z65sZ+7Rpcfnn/Xgarm9u6fUuaaXlFaB/vgoH9xOxG4rDgLttZAMHUVHGQ==
X-Received: by 2002:a05:600c:1e0b:b0:426:5dc8:6a63 with SMTP id 5b1f17b1804b1-42e96242214mr1865625e9.30.1727211051379;
        Tue, 24 Sep 2024 13:50:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiXHIUYfLg/ApdHxFIkfiGLw4xDQ4Vi/t8oKMffgZIEevAFQUBrtSqrnnQvLLtODlevmJANQ==
X-Received: by 2002:a05:600c:1e0b:b0:426:5dc8:6a63 with SMTP id 5b1f17b1804b1-42e96242214mr1865395e9.30.1727211050977;
        Tue, 24 Sep 2024 13:50:50 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7405:9900:56a3:401a:f419:5de9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754a7aedsm170062615e9.31.2024.09.24.13.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 13:50:50 -0700 (PDT)
Date: Tue, 24 Sep 2024 16:50:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	david@redhat.com, dtatulea@nvidia.com, eperezma@redhat.com,
	jasowang@redhat.com, leiyang@redhat.com, leonro@nvidia.com,
	lihongbo22@huawei.com, luigi.leonardi@outlook.com, lulu@redhat.com,
	marco.pinn95@gmail.com, mgurtovoy@nvidia.com, mst@redhat.com,
	pankaj.gupta.linux@gmail.com, philipchen@chromium.org,
	pizhenwei@bytedance.com, sgarzare@redhat.com, yuehaibing@huawei.com,
	zhujun2@cmss.chinamobile.com
Subject: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20240924165046-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 1bc6f4910ae955971097f3f2ae0e7e63fa4250ae:

  vsock/virtio: avoid queuing packets when intermediate queue is empty (2024-09-12 02:54:10 -0400)

----------------------------------------------------------------
virtio: features, fixes, cleanups

Several new features here:

	virtio-balloon supports new stats

	vdpa supports setting mac address

	vdpa/mlx5 suspend/resume as well as MKEY ops are now faster

	virtio_fs supports new sysfs entries for queue info

	virtio/vsock performance has been improved

Fixes, cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Cindy Lu (3):
      vdpa: support set mac address from vdpa tool
      vdpa_sim_net: Add the support of set mac address
      vdpa/mlx5: Add the support of set mac address

Dragos Tatulea (18):
      vdpa/mlx5: Fix invalid mr resource destroy
      net/mlx5: Support throttled commands from async API
      vdpa/mlx5: Introduce error logging function
      vdpa/mlx5: Introduce async fw command wrapper
      vdpa/mlx5: Use async API for vq query command
      vdpa/mlx5: Use async API for vq modify commands
      vdpa/mlx5: Parallelize device suspend
      vdpa/mlx5: Parallelize device resume
      vdpa/mlx5: Keep notifiers during suspend but ignore
      vdpa/mlx5: Small improvement for change_num_qps()
      vdpa/mlx5: Parallelize VQ suspend/resume for CVQ MQ command
      vdpa/mlx5: Create direct MKEYs in parallel
      vdpa/mlx5: Delete direct MKEYs in parallel
      vdpa/mlx5: Rename function
      vdpa/mlx5: Extract mr members in own resource struct
      vdpa/mlx5: Rename mr_mtx -> lock
      vdpa/mlx5: Introduce init/destroy for MR resources
      vdpa/mlx5: Postpone MR deletion

Hongbo Li (1):
      fw_cfg: Constify struct kobj_type

Jason Wang (1):
      vhost_vdpa: assign irq bypass producer token correctly

Lei Yang leiyang@redhat.com (1):
      ack! vdpa/mlx5: Parallelize device suspend/resume

Luigi Leonardi (1):
      vsock/virtio: avoid queuing packets when intermediate queue is empty

Marco Pinna (1):
      vsock/virtio: refactor virtio_transport_send_pkt_work

Max Gurtovoy (2):
      virtio_fs: introduce virtio_fs_put_locked helper
      virtio_fs: add sysfs entries for queue information

Philip Chen (1):
      virtio_pmem: Check device status before requesting flush

Stefano Garzarella (1):
      MAINTAINERS: add virtio-vsock driver in the VIRTIO CORE section

Yue Haibing (1):
      vdpa: Remove unused declarations

Zhu Jun (1):
      tools/virtio:Fix the wrong format specifier

zhenwei pi (3):
      virtio_balloon: introduce oom-kill invocations
      virtio_balloon: introduce memory allocation stall counter
      virtio_balloon: introduce memory scan/reclaim info

 MAINTAINERS                                   |   1 +
 drivers/firmware/qemu_fw_cfg.c                |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
 drivers/nvdimm/nd_virtio.c                    |   9 +
 drivers/vdpa/ifcvf/ifcvf_base.h               |   3 -
 drivers/vdpa/mlx5/core/mlx5_vdpa.h            |  47 ++-
 drivers/vdpa/mlx5/core/mr.c                   | 291 +++++++++++++---
 drivers/vdpa/mlx5/core/resources.c            |  76 +++-
 drivers/vdpa/mlx5/net/mlx5_vnet.c             | 477 +++++++++++++++++---------
 drivers/vdpa/pds/cmds.h                       |   1 -
 drivers/vdpa/vdpa.c                           |  79 +++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c          |  21 +-
 drivers/vhost/vdpa.c                          |  16 +-
 drivers/virtio/virtio_balloon.c               |  18 +
 fs/fuse/virtio_fs.c                           | 164 ++++++++-
 include/linux/vdpa.h                          |   9 +
 include/uapi/linux/vdpa.h                     |   1 +
 include/uapi/linux/virtio_balloon.h           |  16 +-
 net/vmw_vsock/virtio_transport.c              | 144 +++++---
 tools/virtio/ringtest/main.c                  |   2 +-
 20 files changed, 1098 insertions(+), 300 deletions(-)


