Return-Path: <linux-kernel+bounces-255758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EEA9344C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D991F21949
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9475674E;
	Wed, 17 Jul 2024 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Trx5I8WJ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A03A48CCC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721255078; cv=none; b=UpP1EPHJi1ZyKLlrmKxUN4yMYaL3HhshdC4PPyt/JdFq6MDGphZ/dAM7/oIWq7SkbVLhaAyfWxwK6QT5hj7ru6mXo2vntlVOeoBYs0qltYcJQc1Hd5mjiRC3vTYBMbdK69uL1s2kWYBxcWxPvuXgLNmPTR7Gnto3vSSbKOMWoDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721255078; c=relaxed/simple;
	bh=Ntl9tRnYPr/zJHNKvphgoIXwclc8AMU5292YrLEeLMg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z4XzOwe9UDubsfCx/IujfcYP6BVYashXrygAzLdGXY5+jNpUYO2jg6FRhUEvtByeyryKwOW8gaCBc8t6LBMcbCdQ2vaxtyg0gFw+EiAMCXnIV1RfUocGTsPktHAQq9KoYm4rBFNUSpuHGDXRh1Q43KT3yspauuSEWiu42tvQR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Trx5I8WJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05f9611400so391510276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721255072; x=1721859872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MezEZvDkvM+1W/zRjucz+iEQh8YeOxqZVDK0/PzLMrI=;
        b=Trx5I8WJWSde4ZXTL+SX1MKXfpd8aEEjLHqkVa5LYd994J6dWBmChwK9QssfVILCOT
         lVYy0v4DHdbkarhzeNQsK2p6wWZFTg24cALYe5rpsllEv23MqCPnp/IvS6xhlPyo2iMw
         3HzJbMTDKk0PmVHxio8MGH1qdP/IudTrjziBCP43rBYpkwyl7Z1N/6f1tdq3yFOhAR/8
         6VOC2WAMDylcK+YlmDOP5BU9hwo7zNkEDB0+73yqG6Gfkxh1MDCNHd0GIcKOnoq9imqW
         qNTwCAqzV1+NChDcDGiO7ie0ZDbVwgUfiB/kQRFHfR5aa0JILFppfra4R7tRcCT7QIwC
         EBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721255072; x=1721859872;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MezEZvDkvM+1W/zRjucz+iEQh8YeOxqZVDK0/PzLMrI=;
        b=uybZdoEdrG5f51Rr+nSIZDSuImFVnSxKJUV2iRyLItoB70l/dNEDhvwU8u/Wy3GERp
         bWLfZv2ffZqUduCok/ZLm3rlp5X2jTIicKAzpQNneG5Ba+ijF24PL0Uk5DsiJLU9h1nu
         ortIgA5ohwHQbNu4VRBE+WMAx5oecfg3P9ayOaIGU9eilYoA3RuXhQhqmSQZYrj7Ulk7
         CKsHI+O1AjnlyCb7z4oBkPOoQjzN06VnE1Yvm9rAA5q4zVtJ3UcF7KdQnwqetoIkTzfb
         yXZ7bSzDj3k8iqKlb+ihgQ6R2EQ3kRQR+6DRltyz0O/Rf4aBJ10Wm8ooY96Zv6D5Ik10
         R/bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp4b5S7AeimL42fSE7iB9hHBz0mCihW2N3RKyxGiKhSH5kFcKwFeEUPIv7AxFdIbix0Wp/xgH+12EXERHdmgaM2lY0sVFw3fourA1o
X-Gm-Message-State: AOJu0Ywt22uRI9UV4GodAuHy06PexPxzK13mQXOwFKFTPVo6QW8ts3w0
	rOKnYgvf/PBB/WecKemElNGIfAgFBLe9ccr+JxerNpShqSQA0Wmln5u9QQI27hTY4eADwwYUXd+
	hEua+s3HRXwOGbuOjkctwPn5jfI8eSQ==
X-Google-Smtp-Source: AGHT+IG3+vxstPdTJZp8jxDQlLO2DBDeon/AfyXaM8QcDfmGpsUe4BCC7qLioU+mUNebeDuzOmN7MsFB77LhWaaMobJI
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:a503:d697:557b:840c])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:c03:b0:e05:fc91:8935 with
 SMTP id 3f1490d57ef6-e05feb62eebmr2039276.3.1721255072045; Wed, 17 Jul 2024
 15:24:32 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:24:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717222429.2011540-1-axelrasmussen@google.com>
Subject: [PATCH 6.6 0/3] Backport VFIO refactor to fix fork ordering bug
From: Axel Rasmussen <axelrasmussen@google.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Eric Auger <eric.auger@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Kunwu Chan <chentao@kylinos.cn>, Leah Rumancik <leah.rumancik@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>, Yi Liu <yi.l.liu@intel.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"

35e351780fa9 ("fork: defer linking file vma until vma is fully initialized")
switched the ordering of vm_ops->open() and copy_page_range() on fork. This is a
bug for VFIO, because it causes two problems:

1. Because open() is called before copy_page_range(), the range can conceivably
   have unmapped 'holes' in it. This causes the code underneath untrack_pfn() to
   WARN.

2. More seriously, open() is trying to guarantee that the entire range is
   zapped, so any future accesses in the child will result in the VFIO fault
   handler being called. Because we copy_page_range() *after* open() (and
   therefore after zapping), this guarantee is violated.

We can't revert 35e351780fa9, because it fixes a real bug for hugetlbfs. The fix
is also not as simple as just reodering open() and copy_page_range(), as Miaohe
points out in [1]. So, although these patches are kind of large for stable, just
backport this refactoring which completely sidesteps the issue.

Note that patch 2 is the key one here which fixes the issue. Patch 1 is a
prerequisite required for patch 2 to build / work. This would almost be enough,
but we might see significantly regressed performance. Patch 3 fixes that up,
putting performance back on par with what it was before.

Note [1] also has a more full discussion justifying taking these backports.

I proposed the same backport for 6.9 [2], and now for 6.6. 6.6 is the oldest
kernel which needs the change: 35e351780fa9 was reverted for unrelated reasons
in 6.1, and was never backported to 5.15 or earlier.

[1]: https://lore.kernel.org/all/20240702042948.2629267-1-leah.rumancik@gmail.com/T/
[2]: https://lore.kernel.org/r/20240717213339.1921530-1-axelrasmussen@google.com

Alex Williamson (3):
  vfio: Create vfio_fs_type with inode per device
  vfio/pci: Use unmap_mapping_range()
  vfio/pci: Insert full vma on mmap'd MMIO fault

 drivers/vfio/device_cdev.c       |   7 +
 drivers/vfio/group.c             |   7 +
 drivers/vfio/pci/vfio_pci_core.c | 271 ++++++++-----------------------
 drivers/vfio/vfio_main.c         |  44 +++++
 include/linux/vfio.h             |   1 +
 include/linux/vfio_pci_core.h    |   2 -
 6 files changed, 125 insertions(+), 207 deletions(-)

--
2.45.2.993.g49e7a77208-goog


