Return-Path: <linux-kernel+bounces-336974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93AA98438A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54E0CB275F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF9F178364;
	Tue, 24 Sep 2024 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOSc0Gyl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B061714CD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173177; cv=none; b=NGMGm24oF9QR4sUxSnxsJGLYJ1yyBa/Y7dfJQ+Pb+oOoC4frMHBo32c8jymU1IlFi/ikxZZMOhqOaqRhzkHYb4ZNg19KYShD/lLTrqVIogG2O3vwhCXh+BlfSEWp2Neq7xq+uWMqtbaHV7dwmONanabu+aGYWRmxoa0hC8dRc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173177; c=relaxed/simple;
	bh=UchMxXEXcad0LIjFfTqK0it44Uqh316PnTh6X24Qpb0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=talX4e/w0ZHkaR6TwqJ8cZwKW9swLyrNOu0tpLILmlb2qKwlBYst5OMdyFdEHOwK5IByXKE/vxixQN0J4NZQaIFvCjrGOQHHmIxR2/YI3EcPc12QaLFD1kd9N/hfF2j7q1AwZHtlWoIC+qJtOFrMc4J23CYJWazM5nqVcbhyuyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOSc0Gyl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727173174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rJzkKNQcKbyX0QFGo3eW/PqcmuWb71AkdgCrjjKSlqo=;
	b=jOSc0GylDOr5GtrhTVFMobzoerfCPq4p7EUMzHjbpVnDXkHaW9DpJ8JYawzLptIjm6yFNS
	hlzi9UP8m8dOvOHntf4Q4BWfJjizjmo/C8m9opPtIQduKqqzYh8NUWpsBfFk/vfBu+bJ1o
	qnycxrY6xm13n38eC4fPuIL5aMK/vJQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-y45cl5y4OlK1g_FGAAXuag-1; Tue, 24 Sep 2024 06:19:33 -0400
X-MC-Unique: y45cl5y4OlK1g_FGAAXuag-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa3ff05b9so52837539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 03:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727173172; x=1727777972;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJzkKNQcKbyX0QFGo3eW/PqcmuWb71AkdgCrjjKSlqo=;
        b=bD5Q9UvZSHu7SdtoIPMAKZmDscfCs76lhc89r7auo9IW1HnY96fvEdem89sOfU23dF
         iEGc3PC4Dyu/U5qHmoQGT2Cvzt7LYHbql+IH27fSL0r4ZsWvnBren8tcIByW09ScaOuI
         iyDVVFjAhqlWSlo6ESX16FtraQh5ks4WQ1fXPF2cmChbIEl0LBQ8px/TNxzrR6znIseM
         Nu60pA9DkfXvYGD5l9WWX7/XlLtQNMDSrhpUMR2upenRSPw4fSDRkMN1OIQAXLq90k50
         +l+NcY4YNXdkCp4JuqAQBsUfsQjzm5Y3R8dLgc81hBuefekjVgFdDK/BVHk9p8NrajCS
         BbQw==
X-Gm-Message-State: AOJu0YzAwd1QGzk3I6mZFN6kU68Hu1LYaPj3406ye3BVhga3zvI7jb5R
	s0yE+eAxch9fdc6ZllXrQWHaewBM68fHs8t7qmUoFmztHeykGhGmdPcDHU4jZ5OnmCnrnlFQqcR
	35U/a/1WycEHLM7ZAXO3hpO7frkywMud26G5FPrvKmDQVXhvBXqY7QiGBlLdFd9lzTEVWBtRZ
X-Received: by 2002:a5d:9b90:0:b0:82d:2e1b:66c5 with SMTP id ca18e2360f4ac-8323c854edemr56722439f.1.1727173172106;
        Tue, 24 Sep 2024 03:19:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFNj/14WbEMKL5rlVdUOeAgjM2NSsG7TYmN4xxKX7XrOF8K1oLGiMxYB8r0eNQ5wRYhmTHQg==
X-Received: by 2002:a5d:9b90:0:b0:82d:2e1b:66c5 with SMTP id ca18e2360f4ac-8323c854edemr56721339f.1.1727173171671;
        Tue, 24 Sep 2024 03:19:31 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f0e7150sm341493173.14.2024.09.24.03.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 03:19:31 -0700 (PDT)
Date: Tue, 24 Sep 2024 12:19:27 +0200
From: Alex Williamson <alex.williamson@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v6.12-rc1
Message-ID: <20240924121927.07b82b38.alex.williamson@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Just a few cleanups this cycle.  Thanks,

Alex

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v6.12-rc1

for you to fetch changes up to aab439ffa1ca1067c0114773d4044828fab582af:

  vfio/pci: clean up a type in vfio_pci_ioctl_pci_hot_reset_groups() (2024-09-12 14:15:07 -0600)

----------------------------------------------------------------
VFIO updates for v6.12

 - Remove several unused structure and function declarations, and unused
   variables. (Dr. David Alan Gilbert, Yue Haibing, Zhang Zekun)

 - Constify unmodified structure in mdev. (Hongbo Li)

 - Convert to unsigned type to catch overflow with less fanfare than
   passing a negative value to kcalloc(). (Dan Carpenter)

----------------------------------------------------------------
Dan Carpenter (1):
      vfio/pci: clean up a type in vfio_pci_ioctl_pci_hot_reset_groups()

Dr. David Alan Gilbert (1):
      vfio/pci: Remove unused struct 'vfio_pci_mmap_vma'

Hongbo Li (1):
      vfio/mdev: Constify struct kobj_type

Yue Haibing (1):
      vfio/fsl-mc: Remove unused variable 'hwirq'

Zhang Zekun (1):
      vfio: mdev: Remove unused function declarations

 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c | 4 +---
 drivers/vfio/mdev/mdev_private.h       | 3 ---
 drivers/vfio/mdev/mdev_sysfs.c         | 2 +-
 drivers/vfio/pci/vfio_pci_core.c       | 7 +------
 4 files changed, 3 insertions(+), 13 deletions(-)


