Return-Path: <linux-kernel+bounces-315389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C94596C203
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4241A1F234E4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DD21DCB1A;
	Wed,  4 Sep 2024 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/1nw17+"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338DF1D88D0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463101; cv=none; b=ht/bnk0UDhtxGPZ8AD0UmK/LBEWiMq/8ueszKetda6wtLgutNgziIs3OC84BBOwoTxFfPw1N7YEVRflBu7L+jsdFUsSmYw2ELtyHqnGDGoQmq5qFGSgASeBoLYpW153KVFl8CEq4MlVOrm2gJFq08eDN2hHAHY2oCN5yT4OwCqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463101; c=relaxed/simple;
	bh=dUb9az/c6+CPl0K5M+I7pQpZWwwdg0pC+LKQqrwHU9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QKXJyB6XAS5yhpHLvHT4M3iBDb0R+ek/eZ0xKuqfyuODQXxLGvMDnN+Gk9wRUg8dg8BzRbbmeoTxAe6wjaTXJNnOP24gKZwRcd4iqOyx4LS6cxKDZOsfqc09kdHNSDFjV30GSu6xX4L2gq3VMGwjy/0znmBNXO1T0SXRnYKpw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/1nw17+; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3de13d6bdcaso2492063b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725463099; x=1726067899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KySHgeOXTK92gdEN8sIJW9iIIS87z7XEvOVn+fuIfuw=;
        b=d/1nw17+Pra6M6mSbmb5kW43lOHM6MZH7JoizK5Lfzkx2G9aoZ7bUjYB4IczG1g3gD
         MxM9Zy6A3mkkSBtIrc+uwr8jYYHDKHsvSWfEW2tT+EG0Sz9ZSEk6Bgysv5q+gIWh/NOx
         SnR3OFYhMahitVMUxPoqPhkR1eOY3FEP1jbFr9eQBj8873Qyv70CZot+mOmD0rPV5R9b
         I2hFFK/sIN+vxzn3bb8v0Na1YPu5+tWao6evOhIxU6+x3m3NHhsSTkgQgVHKqMiGneYv
         cbnd7QwiamThWnMjEjkPEoSc3wmHUVDNaMfXgLcMOIyh4wDrCiYmEmITJ8o1mUe4hWYl
         0xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725463099; x=1726067899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KySHgeOXTK92gdEN8sIJW9iIIS87z7XEvOVn+fuIfuw=;
        b=qhI8ePhYblzcxuKplH+21/92ihyhq4AsKcTY00GlAOI1hByAj3eOkTcZBm/5jOcdTd
         9IXC0JhrI2N3Hytwj7U7ytHeDh3M7B9YZx2HzBC4XscDDzquIZaI22w8w+sYXf7W96cS
         BXjaFlEeBTp24j/B0Wctu4V9UdJ0lJCZRmLfOY6h3OElg8VhTpYC0RFtJ7L7Krdzg3ZM
         Mvq67auJMArV797xnSywViUptNYQUcC9/EoPnu3FocP9ScozoEKtoqDrxiouJ2h2puZh
         8hOUjSbVMtg4p6qm4Y1YzYZ036VuVP81Bm7dM8dTLUC0Mru6qG3IZOHKQ+bPP3eQjqK9
         Nmcg==
X-Forwarded-Encrypted: i=1; AJvYcCXquDCj8viNzJYXLkCva8YgPuVYY/HwFQGkYYdJ8JeWgJfjIS8RZ15kc8ivtLHzcndlZlnZjarTxuUhWlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHHLWRq0NtdmAd6x0MC/pkfPcufl5hzCtueTHkpZ/sg3VKe9WQ
	NgHWKeH99djbz9E76eoKGqvrBgtBgH2X9RWO39Zpn/1Ai0OJ2nvn
X-Google-Smtp-Source: AGHT+IEruZWEvt+Qyt+sCbAsEFb6gFwBCtXsHstZp4YcWIu3csV/K7WrCtutgzoM68O4FNDcf+wAvA==
X-Received: by 2002:a05:6808:180a:b0:3df:144f:9ef9 with SMTP id 5614622812f47-3e00cbcfbbamr7079390b6e.41.1725463099185;
        Wed, 04 Sep 2024 08:18:19 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df117db1f2sm2831040b6e.32.2024.09.04.08.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:18:18 -0700 (PDT)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	shannon.nelson@amd.com,
	sashal@kernel.org,
	alvaro.karsz@solid-run.com,
	christophe.jaillet@wanadoo.fr,
	steven.sistare@oracle.com
Cc: bilbao@vt.edu,
	xuanzhuo@linux.alibaba.com,
	johnah.palmer@oracle.com,
	eperezma@redhat.com,
	cratiu@nvidia.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: [PATCH v3 0/2] Properly initialize speed/duplex and remove vDPA config updates
Date: Wed,  4 Sep 2024 10:11:13 -0500
Message-ID: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <cbilbao@digitalocean.com>

Initialize speed and duplex for virtio_net_config to UNKNOWN (mlx5_vdpa
vDPA devices currently do not support VIRTIO_NET_F_SPEED_DUPLEX). Remove
ioctl VHOST_VDPA_SET_CONFIG and its related logic as it is not supported;
see: https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html

Carlos:
  vdpa/mlx5: Set speed and duplex of vDPA devices to UNKNOWN
  vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance

---

Changes since v1:
 Link: https://lkml.org/lkml/2024/8/29/1368
 - Fix prefix of the first commit and add Reviewed-By tag.
 - Redo second commit completely: instead of attempting to add support to
   set configuration fields, remove ioctl and support entirely from vDPA
   implementations -- because it's not allowed by spec.

Changes since v2:
 Link: https://lkml.org/lkml/2024/9/3/1407
 - Fix first commit by changing 4 spaces for a tab.
 - In second commit, ENI is legacy and should keep set_config(). Change it
   to set_config_legacy() to avoid future confusion and erroneous
   implementations.

---
 drivers/vdpa/alibaba/eni_vdpa.c    |  2 +-
 drivers/vdpa/ifcvf/ifcvf_main.c    | 10 ----------
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 19 ++++++++++++-------
 drivers/vdpa/pds/vdpa_dev.c        | 16 ----------------
 drivers/vdpa/solidrun/snet_main.c  | 18 ------------------
 drivers/vdpa/vdpa.c                | 16 ----------------
 drivers/vdpa/vdpa_sim/vdpa_sim.c   | 16 ----------------
 drivers/vdpa/vdpa_sim/vdpa_sim.h   |  1 -
 drivers/vdpa/vdpa_user/vduse_dev.c |  7 -------
 drivers/vdpa/virtio_pci/vp_vdpa.c  | 14 --------------
 drivers/vhost/vdpa.c               | 26 --------------------------
 drivers/virtio/virtio_vdpa.c       |  9 ---------
 include/linux/vdpa.h               |  7 ++++---
 include/uapi/linux/vhost.h         |  8 ++++----
 14 files changed, 21 insertions(+), 148 deletions(-)


