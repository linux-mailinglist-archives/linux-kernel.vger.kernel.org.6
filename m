Return-Path: <linux-kernel+bounces-313418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE9696A537
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46497286D74
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD0C18EFC8;
	Tue,  3 Sep 2024 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHqx6UJI"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800318E043
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383720; cv=none; b=PmXzD+iY11fLhszZh3I6rqCNIWtPaAKojz9n0/U/d7d44c5lTrhtBFUn3adtQerZusVY/f1p74IlvE6HRFh6ShlPGVcw1XgcMAxws4VKqKHqscRf0zNCLNkCz6sifvRESi2UH/SsgzXgrF8xs9dtHRA/NeJSRFLEWHsAOhVgd/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383720; c=relaxed/simple;
	bh=kLNPtRx11hsfJ+9TPaWWJn6lMwA7D38MMP9cWpDIIlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NTwPLSf3JAmVOCfD2mPfFGpYm2VbhLQ89t9QpOodZiUq41xbcqfKpsuM1r4aGg6Up9spRHNz9u6trpv3CIYSwqHpnlI8vdPqr4a6EkqOwg56kOPxMOHKBSEp7ZT3pACJt4y3GNhoNzXurHRnrW0NZme9hCoxBxCxHGWU9MEa9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHqx6UJI; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5daa93677e1so3385616eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725383717; x=1725988517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TLZ2qy4nIG4Jhx7z3LE1rlOsOATUkEObwLNmcXIs87M=;
        b=eHqx6UJIO/wDCJkvYOp1w2kGLAOxtGVJKODSKrvndZHZ1Po9mmVLQ/DYckbHE1DM3S
         j1fY8EqzoyoSTZyptLvlqG2nlkiMZdzWk2pdc5Y9Y+nClY+TDkPXfy7kSFyunMbSAg9M
         ohW9mgUrDnrhpHCiZAghIVmXQ7p1ty/OR5S1RMxffsR+5P5aEQT1i5lXiCO34FIXCBiq
         GysIqHPRpNUSMBEbeMz8loreBxLI7Wfjn97n2X9/0263dFOC2oU/ops5As3fza3Trxu6
         8T4hdQfmC2vHZ0NVFvT+6/hrnIlUKwDJpKQKNUtWHMLw83a7FxETLf37e1Ub81x/okTY
         IM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725383717; x=1725988517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLZ2qy4nIG4Jhx7z3LE1rlOsOATUkEObwLNmcXIs87M=;
        b=qctRC0S3DG6PrQ3MXiqg+qz+x37BiYHWKIo/K1UISEMTCfTL7z/p57mRUuwnqa//BO
         wcecM2X/N3+hnsONMlKRLuXqfKv16YbDhifSEyQi6Y4mBrfPbI6hIwWBRWlNEz79HKiw
         Obo9sy7sREbZyH0Ojx8br1eG2GVm5I0KgDsfj2UtdCLMee4zbG9JEuF/WNqtGYnDZtdJ
         XF5QKoc+nI3ljshBlg4024HHIT1g7K+LaxZQ3hQK8IsHBf1Ix/gUwB4E83qr8qeDpY0C
         ngAv/LbpfwVRKKsZBPhrMwdGKc6UTftVGI0HthN7gZ8Iv88KtiUr5O749DlMawfOafyF
         PBBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK6+myLNGpNg+bG+SGTlYlwqQPTZ3ijRo+onmDXr46qMGas0ZKdzvVhr0Q20qdv2fnMMD7QH5QvvPZ4Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6yts6CaRTQyAeiXAEaWtn7b/e40xbzXbXoVzPvUkji6GulsJ
	UsRXRa8u/IfSDAqmVUDwFaDNkNuLf8OAOtkteM3HRnhFGjdjOtwSEwvk2Q==
X-Google-Smtp-Source: AGHT+IE6BIq7Z9DSjqx25ixqdMPN/+sENLE9DRYHmtWnc/QOGbu69+yK7YfN4avZLU6r2N3y7G2Cmg==
X-Received: by 2002:a05:6808:3999:b0:3d9:9e78:420c with SMTP id 5614622812f47-3df1c260619mr16918658b6e.38.1725383717562;
        Tue, 03 Sep 2024 10:15:17 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df117a5f91sm2398059b6e.2.2024.09.03.10.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:15:17 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Properly initialize speed/duplex and remove vDPA config updates
Date: Tue,  3 Sep 2024 12:15:12 -0500
Message-ID: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
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

---
 drivers/vdpa/alibaba/eni_vdpa.c    | 17 -----------------
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
 include/linux/vdpa.h               |  9 ---------
 include/uapi/linux/vhost.h         |  8 ++++----
 14 files changed, 16 insertions(+), 170 deletions(-)

