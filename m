Return-Path: <linux-kernel+bounces-256655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814879351A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 20:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA882837AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE5F1448E4;
	Thu, 18 Jul 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8XujeF8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAED222EE5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327744; cv=none; b=C477ridsa5ZdoinZbOG4aoBYTaG0GZHNEQVB1GAeT3VcyWFTntEjQhq9eK4K/skzsnEvueGXniAXZH2P1tXbGFsyE2WxIGkhBfWbyO8HmrPUdZtMj6OpPb1H2mEVZnDZbrlqrS2EtlHrZRWt19gTzB5nnBuaIwWEHW1vX5P/WCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327744; c=relaxed/simple;
	bh=u02ddkAcPCoiLwQdxM0rK+aeGphrXzTinlCWIgn2fgc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Xe+kgbU2XjSHt1DszXVk2qgIMyWNLlh3hqTGxL78ZpxYXyg+SA4G20ZFG+Bcbk1I2GxcuVTT4smxcZYHv5VveJOZ+Pc+lQoPSWqV2/eRC4EkG3pPnhzb2LITK+R3WV6AK/MnfJAqVd1Pyo/72WV0154WjnQCmiaunkuAAkmCeH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8XujeF8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721327741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PyuFM1OIMvIXLcmAF20k2pO7T0rexvFXzXgDHWSM8q0=;
	b=G8XujeF8hVwYAe4PEVcYAmK6xcEBOfRBlQ8Cds+MANcS/CNPZdXh9ws2KIX0uFFHeMzbk9
	0pRHJj7wtFSnA+L7Z+GmTWOZ2lxuCt540NS9Bzzo6ydV07YekMjFxaIWnsqOMG0XfsikdP
	if4l5afunX2fbjHAjRLYds/G6Yd4Cmo=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-LZfr0GKENV6xAtjC6q5FaA-1; Thu, 18 Jul 2024 14:35:40 -0400
X-MC-Unique: LZfr0GKENV6xAtjC6q5FaA-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-397a7f98808so2075225ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721327739; x=1721932539;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PyuFM1OIMvIXLcmAF20k2pO7T0rexvFXzXgDHWSM8q0=;
        b=vVWwHGt8nP8EJqzXRJlHptBiXcwyKMN0TviP+chtkQpowq9NZzKQa0Ap5e91Ya5fLQ
         2vVcxb1F2czDTf98nQDy3ejcK28rY74Fsag3FcvCLTQXfXTNNqhvgOoPxi7U37ZkKn6L
         C+esUUjzMwZdwZ4h8XUAXwoW6XCL85k7secYv3djoszIqEeabXk5KyuySCl2ilQCnaU8
         BMJFA2NS/36hQeO08UF1vL9KI0ttC0rafMG4tOUJGmon9Qk1X7iwgtf1NQ2B8yFVyxqC
         dO8vIjTpCW5fBKJlpiKgHu21Goud5pDmxjJTmOUyHoL+nWS7YtN+2oHcIc5WbOoiXfG0
         8zbw==
X-Gm-Message-State: AOJu0Ywu7cdQAu8MHok/klHtGmRPhmoJwyQA50jGG/4tE/TJ+1tVpMzx
	DAosTCPmLxPctWCTYxaCjASPwR5hFRETJd1RgjxMARgCOHpup0agac6XhF0PyFFhnCLd0IDL2Dv
	hbJj/rtF6+TfkmQOATi2Rves4j1xXYVP9Ifj7lvxAdOs0FogxuLxX0Jjrr83qlQ==
X-Received: by 2002:a05:6e02:180f:b0:375:a3a9:db49 with SMTP id e9e14a558f8ab-395557fff0bmr78420565ab.9.1721327739538;
        Thu, 18 Jul 2024 11:35:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx1qPRUkHN6qE40URnXw+SHEmKc+lZRbuQ/6PJzWWtSfJeXV+gE3MMKAO+C7tH3VwQB7WTHQ==
X-Received: by 2002:a05:6e02:180f:b0:375:a3a9:db49 with SMTP id e9e14a558f8ab-395557fff0bmr78420355ab.9.1721327739241;
        Thu, 18 Jul 2024 11:35:39 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3950c80f614sm18428005ab.55.2024.07.18.11.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 11:35:37 -0700 (PDT)
Date: Thu, 18 Jul 2024 12:35:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v6.11-rc1
Message-ID: <20240718123535.270f63f2.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Just a few commits this cycle.  Thanks

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v6.11-rc1

for you to fetch changes up to 0756bec2e45b206ccb5fc3e8791c08d696dd06f7:

  vfio-mdev: add missing MODULE_DESCRIPTION() macros (2024-07-17 12:24:13 -0600)

----------------------------------------------------------------
VFIO updates for v6.11

 - Add support for 8-byte accesses when using read/write through the
   device regions.  This fills a gap for userspace drivers that might
   not be able to use access through mmap to perform native register
   width accesses. (Gerd Bayer)

 - Add missing MODULE_DESCRIPTION to vfio-mdev sample drivers and
   replace a non-standard MODULE_INFO usage. (Jeff Johnson)

----------------------------------------------------------------
Ben Segal (1):
      vfio/pci: Support 8-byte PCI loads and stores

Gerd Bayer (2):
      vfio/pci: Extract duplicated code into macro
      vfio/pci: Fix typo in macro to declare accessors

Jeff Johnson (1):
      vfio-mdev: add missing MODULE_DESCRIPTION() macros

 drivers/vfio/pci/vfio_pci_rdwr.c | 122 ++++++++++++++++++++-------------------
 include/linux/vfio_pci_core.h    |  21 ++++---
 samples/vfio-mdev/mbochs.c       |   1 +
 samples/vfio-mdev/mdpy-fb.c      |   1 +
 samples/vfio-mdev/mdpy.c         |   1 +
 samples/vfio-mdev/mtty.c         |   2 +-
 6 files changed, 78 insertions(+), 70 deletions(-)


