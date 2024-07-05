Return-Path: <linux-kernel+bounces-242299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4FA928667
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299961C21A47
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5348F146A62;
	Fri,  5 Jul 2024 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N90T8mU2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F3413B5BB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174142; cv=none; b=qT2IIg5cikgzAgamuZtgG/l0Zs8ItPO2WmJ64/Uq6uoWljzBFzF9+q5sgeG6J6XCIuxJSlURlCE/z21w3XMBgN2Nu+0HdXpjFBwv4HsDsSSyx/gzL7uwW8+SbB3Vw/8wGjIOr7DIrLymwIZn64em/IPy1oo36tR8IULvPc1A/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174142; c=relaxed/simple;
	bh=7j9Jdm5VU4/OltxbB0ueSTNWYCdjR9qDN9hVuUIh/wM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VDhvcptjMXZUJsQkR6s32jma5HDqIg4gu8ontkI0Axc8U0EeraRAp+D6y1fgeQnIBBRddaB28ev/yL5fXHaPBLX9xO0S6SyysLt0hkjcd1nFDkbayFhAQ82RP5mFox4ONpOOHpEZPUBmw7RIGL7UfLUzC8Y/jTnNcm2VNZtZqYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N90T8mU2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720174139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=7JyxCBbKfIShbwa9o4YlOtIGgflnmKtyw69jVRYJDY4=;
	b=N90T8mU22ePi1GPSniBaeFera/BhCmg8+i7z3H8Urb9m9DZKlLoeM8+hjg+sE2YyE4+/gN
	aGIUprf19IPW03jK40qRIc08HCKNehpftYBpNIpAi6bexioGiIIbPWV9Ng+G9X8oE3bHzj
	A5sQ+Wbl5asM9yq/FhjCgQUp7ifLyEE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-BFrRDDXjNhWCKVnsXMg9Hg-1; Fri, 05 Jul 2024 06:08:58 -0400
X-MC-Unique: BFrRDDXjNhWCKVnsXMg9Hg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52e98693f43so1582924e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720174136; x=1720778936;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JyxCBbKfIShbwa9o4YlOtIGgflnmKtyw69jVRYJDY4=;
        b=jIeqYLk9yGmh6kJGwYOhAb7ECVdA/+QuBtDQDAMGF82VDVImRyNPEWSRIJpTLeC4gY
         +2R6cAsnk727VatVfzp2iIjScMtEhRWhlp4QMSVwNSpAGtJhlGP1J+QewsqKxtdmqhxZ
         1HVTjJsr++PeeaR1jo+5np6GqHeGggFxRs9auzKFWVRusk91a9ciBTn27ZE87dmqNBBL
         cAyoFmfKXrttQozFcIoM2Kxfcx2p+4wPkYb++KbrkA7w2c7qYceDDZXYNNa/W1kf+Mwj
         vqDXPucEOVjeVUW0WbFvCPm2Dzkase0MREZxSvTGnXantO0Vw0ZCmAuhuEYgysx8sofx
         Reiw==
X-Gm-Message-State: AOJu0YwVZr2ePqYoNWXbDG3nNfIzZc3yMm5/ED+SMnXfUd4yr320EQD9
	BVp6UfENefSKiLEhPTf/x1r78OZygG5wLLOT0DpI/WaVH4u3+D/QXy6X9TPc2mCMG0/JJkNoHrG
	FHp04YOeJtY5we2gYILkQciDlfMKuDQtk+o0GaiLU11ANXLTWu/+iGyVdTzyPPFUzgeyIDftEIR
	PN5vzHjhkLmBiW/U2RlkJGy3uIWHsZfhwhDOWc/Ss=
X-Received: by 2002:a05:6512:3710:b0:52c:e11e:d493 with SMTP id 2adb3069b0e04-52ea062a2c3mr2688697e87.26.1720174136299;
        Fri, 05 Jul 2024 03:08:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgFd4g48bCQMW2Bugknj1/Y3kp1VD/efPxZsNviOCYRskjptI8viNo1gD4BP8d6pPRFp6A3A==
X-Received: by 2002:a05:6512:3710:b0:52c:e11e:d493 with SMTP id 2adb3069b0e04-52ea062a2c3mr2688673e87.26.1720174135600;
        Fri, 05 Jul 2024 03:08:55 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:a185:2de6:83fc:7632:9788])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a112b3f0sm3064111f8f.19.2024.07.05.03.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:08:55 -0700 (PDT)
Date: Fri, 5 Jul 2024 06:08:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH 0/2] virtio-balloon: make it spec compliant
Message-ID: <cover.1720173841.git.mst@redhat.com>
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

Michael S. Tsirkin (2):
  virtio_balloon: add work around for out of spec QEMU
  virtio: fix vq # for balloon

 arch/um/drivers/virtio_uml.c           |  4 ++--
 drivers/remoteproc/remoteproc_virtio.c |  4 ++--
 drivers/s390/virtio/virtio_ccw.c       |  4 ++--
 drivers/virtio/virtio_balloon.c        | 19 +++++++++++++++++--
 drivers/virtio/virtio_mmio.c           |  4 ++--
 drivers/virtio/virtio_pci_common.c     |  8 ++++----
 drivers/virtio/virtio_vdpa.c           |  4 ++--
 7 files changed, 31 insertions(+), 16 deletions(-)

-- 
MST


