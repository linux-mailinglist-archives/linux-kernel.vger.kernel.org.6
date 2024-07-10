Return-Path: <linux-kernel+bounces-247539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9910092D0E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B37CB25D49
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CB01922D4;
	Wed, 10 Jul 2024 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gc2eyODY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648951922C1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611768; cv=none; b=Yoxgz9cmy8QqTqL4VbLG7Elv3kvRffH7vaBDUdFskxejBOK6n7mzOgStN4ufW28gkBvO60Ci5q7LYgahPF0jNSb3UIgiZGTKhiZLlmjRzjnfXZRjBP1TSLOJXIKP5jq+fe6lA+7XVvsr9/BX9Izu3+bmP2qj4fzXiUOzxWS2AIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611768; c=relaxed/simple;
	bh=I4vwiSftB+F731hVfmhCuFYBWXDK+YtJLQnnu1NLfd8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oBB/7ti7qTg/AmWAW+ZViUlDbsn/91WDl5xwliRIYCJ8Hw8xQA1JvJljUnIUnSvSupZTDwukHGMVd6WDaSacmaA3aH7q31dgr+sZ1hi+4e4hDUyG2naUrSTxfYIpXOHCluhjJZ4aayJqlQGxTtD4/s/Y6Ni0JVnEtShccN7/ZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gc2eyODY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720611765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=rA/LKwoIvIi/EKPPpXFA9bO3DxUFwvpThtL9CddNZOE=;
	b=gc2eyODYtBeKOsam3ZvyLcg6bJkpmVY+j5+QUj9aye7WNkp+UN/yIWZSfw7ulzhZP7GolW
	uPBIPzuLhuixJtEIOVHQ4o7DK9I7B18Y5flX51+UEAey+ATcuoQ90VsQ+yHSbM/VzO6nU0
	eemcpwrlGhPH4bIUzFPuwmCQsVbznVE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-hMJSa3oLNqON4WOexLAafg-1; Wed, 10 Jul 2024 07:42:44 -0400
X-MC-Unique: hMJSa3oLNqON4WOexLAafg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36792df120fso4632644f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720611762; x=1721216562;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rA/LKwoIvIi/EKPPpXFA9bO3DxUFwvpThtL9CddNZOE=;
        b=VLGaxGRGZ687WTUZtt2UhJf6SQAWytpKbNV6OGSKwa1lIZHiW9Cx7GtGJZF2nXfw3X
         l8/UfnIh0iPixaBt3mpqfUX8VvnhZOeEbT+rNxUHudvMSIDrKxm/gXxuUHlO4AnC4JsX
         wEbAWIzIhAM0Qyr1QCKlECuBn6kQLDH/ZepJqCk7H8MCi+kawOasCdcxihBfobcmN/C8
         otESfO2bQNVWBPB4tJ4wPnJKIvWtWbb2qli1N6UsWmPo3Q0RQ7MDPCS7kFEgnuKiiB0h
         OTepSeDvomD6UbDnbszCSWDO9eoeAmRASU1d7jeoVz/TbRX0ehODX/Wfx3e0xQCGplkf
         pq1Q==
X-Gm-Message-State: AOJu0YzhPRCKVusgjvJ1CFDF0o1UZ98GgRbnD3taKdfsfs4FmrJGpnRI
	kl0weOQqIkPqN2epW8p4QJRpjg3e4kIw/0CCwguZT4kXbbVYX6hu1jyYHMjs3j5HzxAjTtJHQZy
	1hjyGxrg2h+fPFnla0PZt5XDsStwXxE1nOdBQGUh7rInGAFAJ9xz7HcnWbtNHhelpuYMlmHXT1U
	4wFKir41c6Gz0hZFgsn2jiMHo63SBVwqDZlzyqsRo=
X-Received: by 2002:a5d:4e8a:0:b0:367:9522:5e6b with SMTP id ffacd0b85a97d-367ceac4995mr2976208f8f.45.1720611762439;
        Wed, 10 Jul 2024 04:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbaUO5X5WYIMSyyseij7Vh+5sCZQOY7ageBBCn3/GXwOX/tqPirGrV3AP7JlkpvCPVzsMJSg==
X-Received: by 2002:a5d:4e8a:0:b0:367:9522:5e6b with SMTP id ffacd0b85a97d-367ceac4995mr2976183f8f.45.1720611761756;
        Wed, 10 Jul 2024 04:42:41 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab11csm5093652f8f.102.2024.07.10.04.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 04:42:41 -0700 (PDT)
Date: Wed, 10 Jul 2024 07:42:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 0/2] virtio-balloon: make it spec compliant
Message-ID: <cover.1720611677.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Currently, if VIRTIO_BALLOON_F_FREE_PAGE_HINT is off but
VIRTIO_BALLOON_F_REPORTING is on, then the reporting vq
gets number 3 while spec says it's number 4.
It happens to work because the qemu virtio pci driver
is *also* out of spec.

To fix:
1. add vq4 as per spec
2. to help out the buggy qemu driver, if finding vqs fail,
try with vq3 as reporting.

Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
Cc: "Alexander Duyck" <alexander.h.duyck@linux.intel.com>
Reported-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Changes from v1:
	rebased on vhost tip


Michael S. Tsirkin (2):
  virtio_balloon: add work around for out of spec QEMU
  virtio: fix vq # for balloon

 arch/um/drivers/virtio_uml.c           |  4 ++--
 drivers/remoteproc/remoteproc_virtio.c |  4 ++--
 drivers/s390/virtio/virtio_ccw.c       |  4 ++--
 drivers/virtio/virtio_balloon.c        | 19 +++++++++++++++++--
 drivers/virtio/virtio_mmio.c           |  4 ++--
 drivers/virtio/virtio_pci_common.c     | 11 ++++++++---
 drivers/virtio/virtio_vdpa.c           |  4 ++--
 7 files changed, 35 insertions(+), 15 deletions(-)

-- 
MST


