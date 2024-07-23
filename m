Return-Path: <linux-kernel+bounces-259940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521D293A02D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D6B282149
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1B51514DE;
	Tue, 23 Jul 2024 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODCtjwm9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE1313D609
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721735368; cv=none; b=qpO0gvl/3YXUrjQXGGFM6dzAnP1g/wOZbSWbP9W1owLGfF54YOcXLJ8QjjpVXwIeX3aQRs2DgsWn/13n3AXD22Si2w+8y4MBPu4nb4H/fLlXZqv5YUrW6JxCLC6At63AASI0aXL2wccRtxvhPWZjG5THIkw4NOEhJ/1aK3+WVhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721735368; c=relaxed/simple;
	bh=2IzsPayJCnWS/dIbO4kd197KmAE14y6oomj9vNSuERA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GDA5yai67XnHMWdqOJNyS/Rpy+8/vk3SKg6RvXSYXBWmMVaKPBGzOInbKusfk67JmhoclAx/WaXMXdrAz4yEWnUysLaiZNyGPHVKTJ+FhvHZPgXBWZpValQ4SsDj3Qr4vEfB+fDAiEf9+I0bZkzdqZi9oE+2sfcXO+CSXTIf3uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODCtjwm9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721735365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2ZZ7xf/f12+Tr6LA6vgO8m70M0xzWtORCsg5GqY5FWM=;
	b=ODCtjwm9gwHU2DG2yc2F/btnk+QtJQtGI5wOOiDG5gnYpAgzSz1ncMOF825KsRhXvs8BYL
	mbhSnX05oDqUUmR8SV71RnIt3VBQmquESsvNlg9nEv60Uh3ytJUkNMJeZbNkcwsCM7q+JI
	xFKBYift9qH6GESEiwf+9WYuMuJNlDk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-lzkINb5QNrO5cKrvekHW6Q-1; Tue,
 23 Jul 2024 07:49:22 -0400
X-MC-Unique: lzkINb5QNrO5cKrvekHW6Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4387D19560B6;
	Tue, 23 Jul 2024 11:49:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.104])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC9FB1955D45;
	Tue, 23 Jul 2024 11:49:15 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: gurchetansingh@chromium.org,
	tzimmermann@suse.de,
	mripard@kernel.org,
	olvaffe@gmail.com,
	kraxel@redhat.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	airlied@redhat.com
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Sergio Lopez <slp@redhat.com>
Subject: [PATCH 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
Date: Tue, 23 Jul 2024 07:49:12 -0400
Message-ID: <20240723114914.53677-1-slp@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

There's an incresing number of machines supporting multiple page sizes
and on these machines the host and a guest can be running, each one,
with a different page size.

For what pertains to virtio-gpu, this is not a problem if the page size
of the guest happens to be bigger or equal than the host, but will
potentially lead to failures in memory allocations and/or mappings
otherwise.

To improve this situation, we introduce here the HOST_PAGE_SIZE feature.
This feature indicates that the host has an extended virtio_gpu_config
structure that include it's own page size a new field.

On the second commit, we also add a new param that can be read with
VIRTGPU_GETPARAM by userspace applications running in the guest to
obtain the host's page size and find out the right alignment to be used
in shared memory allocations.

Sergio Lopez (2):
  drm/virtio: introduce the HOST_PAGE_SIZE feature
  drm/virtio: add VIRTGPU_PARAM_HOST_PAGE_SIZE to params

 drivers/gpu/drm/virtio/virtgpu_drv.c   |  1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  2 ++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   | 13 ++++++++++---
 include/uapi/drm/virtgpu_drm.h         |  1 +
 include/uapi/linux/virtio_gpu.h        |  5 +++++
 6 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.45.2


