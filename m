Return-Path: <linux-kernel+bounces-338428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DE39857AC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F93A1C20949
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED4E16DEDF;
	Wed, 25 Sep 2024 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3ow9NCj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B01C154BF8
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262599; cv=none; b=nTPm6hua4zKuRl/98JTg4li24hbS+5mV4m0jBuLVCrKhAAwilBU2uTT4XV8cWF/jahHkhSkWz1LyJOL1HQnqqFgnEovtbP9GFwb+ZM8NAm1y/CZXwZweQaYm3PwT2FOUqhyxfpOPx/tTizXQtI4grYlgqRo+9yWzeF1Z8pLhysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262599; c=relaxed/simple;
	bh=xtxsvm8uRDT0k+Fdso/owoT8wFfjLj3xm055kPKyiKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oxlJzQecLFI+gf5ax9Xd5Prwf3CQWb8LDhoZ628cVPfo3rQO7gn6KWaiGXbw9TgBnKqryjRxpIxkQ8E/bgGom7X6VAHAYevoY5v4b/GfT9OERXiYhTQBHqIUw3qte19sNW7a5ht3YafV8IV+iQKH6WFfJT6+XEI27I+t2FnPYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3ow9NCj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727262595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GYARqqH/zIw2gIrAZ+tTLBZyNzYt/nqsl4mA84ZpEqE=;
	b=a3ow9NCjxICxby1QpdwZaMQH0cafnWgeyxlwQVMCc7jPuk2CFY2P+XF4vVmKdyXnTuL6GI
	njHHrpik0/JLpHZcxbr9zhGDGfEHuovG38tONVWvMN+0xsi533RxeSQq/NljBG0pgd+Lp3
	v14Vcs+/iFFTtaijU/f+VvWcdNA8LPQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-KJpNDysKM-2BawGjmaxI0Q-1; Wed, 25 Sep 2024 07:09:54 -0400
X-MC-Unique: KJpNDysKM-2BawGjmaxI0Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37ccc188d6aso162180f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262593; x=1727867393;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYARqqH/zIw2gIrAZ+tTLBZyNzYt/nqsl4mA84ZpEqE=;
        b=pkhTFDjl3si8h6IqHs0JvOJi9Ok7E9/6Xv+71VjWC3LQLbF4UAxdxyT67MuWK1k7FP
         UkZNHYvAc3xfuXJpbHetlUijdYNp/zyQf7RCyzCV1Oxeuc5gWlUVsv3xxx17fXGI0XZF
         4ZItWwOj3l6HmVQlcCb1oMVdBER9OkhDfxBevqA/JtOuogNn9t81mTnH2DEZkueQxNon
         cbnKgU5YTAkGhy9BV6kiZUNwGGkJIbYN32GI83/Upc2rNrMSr/XhMqHehqUeks7cRO6G
         5y/FT1Ft2ZbsHr1CRzmVbzuPmqWTRfkh59uCVK9bb/iIbV19Cw63bDOzBX2iL6a4xjbD
         CPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd4wwnbCZshJ+Ww65lbLMK5hXKwrYBPQfyx1+ezUr2LChDJ6FyZm37UQzvQPp99y1/w2owrnlC2VGYJ9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX3MegxRJoiSRqTUK1JX0jTEW98J+VoW5JJcsWtabC/Fl3fCQg
	CBlzZiqzcGzgyOW3wy8RKs+32b/LtzDFO5xQ+t0U+xOBDOfqykM5JxBvjjPm4h69coiZNV6tZfn
	4dFO0puG2IlSOMe1dt8YZQMUMB0OFxnjlBwoK0yYe/qUYLddWPdf9gRirqGkmKw==
X-Received: by 2002:a05:6000:18c9:b0:374:c3e4:d6b1 with SMTP id ffacd0b85a97d-37cc24b25b5mr1902409f8f.44.1727262592657;
        Wed, 25 Sep 2024 04:09:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVT6hBQDAGQX3+vy1AsamAzh0r2GQEW+rZO8mUVTLUvy6RGX+GkdPmK+Lzdj53mjsxARrWvA==
X-Received: by 2002:a05:6000:18c9:b0:374:c3e4:d6b1 with SMTP id ffacd0b85a97d-37cc24b25b5mr1902383f8f.44.1727262592214;
        Wed, 25 Sep 2024 04:09:52 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7405:9900:56a3:401a:f419:5de9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a07e69sm14908845e9.21.2024.09.25.04.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:09:51 -0700 (PDT)
Date: Wed, 25 Sep 2024 07:09:49 -0400
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
Subject: [GIT PULL v2] virtio: features, fixes, cleanups
Message-ID: <20240925070949-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

Changes from v1:
	add a missing ack, removing an empty commit that I used to
	record it.  no code changes.

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to efcd71af38be403fa52223092f79ada446e121ba:

  vsock/virtio: avoid queuing packets when intermediate queue is empty (2024-09-25 07:07:44 -0400)

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


