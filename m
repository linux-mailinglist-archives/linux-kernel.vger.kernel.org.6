Return-Path: <linux-kernel+bounces-215009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FE7908D46
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF0A1F21824
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DBABA33;
	Fri, 14 Jun 2024 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TY81g+Re"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0071DDDDF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374927; cv=none; b=V4sa8Q4Z1o8wDomMlG0oczW+B2dvP56vE7oLJ2Jj2fUhpYjku1V2hsmlyUP+URWpIMNsTAImUcTj8AKFmjAGlLWBGCr8XFRmKEQwIoVjMaXax2tOxsCOFtwpKGymDSKf9p4m+tLk0xtoR+Ma96BUvxHqU53QEhiYLYrAjUGun2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374927; c=relaxed/simple;
	bh=kB0azTgKkuVGVw33hGW1rnAxLMPrkox5uErZehXfzkA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YZkZH7Ri96pP3FGZLWNM9V52CBp6CPgn0pDtkVmxReeJH3OHx3nOvdooW080lRCdlmGL9QYpuLPzsrcmOWPKAttzI6etkxQzxQULWeVhtHhvI5RTUy01rKS59W6rOnagFA/rnC1pkFCvcccXWsqIfQwfujJ0deffPAiPPU0Qrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TY81g+Re; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-70346ae2c43so424648a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374925; x=1718979725; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIgry4ZlTdfYnxRdys2JHwePBLV3NAUgUfJMeam51TU=;
        b=TY81g+RekTTCJXMxO8Ogb5noztbhlE3iSSp31TC8p9tAhXhyJ6F13GFxL8LCUeT2Sg
         yLPMJWzBe3/C15kVTNscJzhFeEVif+0GiqRTGURYIxsXWzqpGpY2xDaMz+i+U2X2JR3q
         1jM8b7RGT6DKTXyzXLK+POuz3BWOnUnLb0wMXk7Nxv5tLHszPjN2S4WS4/f+B5+G3pOy
         LygVaByubJvktT3qCnX/phjVj9Bd4FZxxqzy5HMBpdZAf/CqrEAPC6wu3NimcKGsbDDu
         6sxHTdZT+L4xz+92WBoqZY2/JwaDpxPNd2n4B4Ur4evzs2VdXiD5emn0bq/mN7+jYi93
         bOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374925; x=1718979725;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIgry4ZlTdfYnxRdys2JHwePBLV3NAUgUfJMeam51TU=;
        b=nv/iG0dC5KaU6b0M+Px0AmrP2ddp8ddcEuhKn6GVl4JJFzeiy2jLpCxWMC/WRioVtQ
         drl/0tPkwvOMCnega/n6DZIbTPLzZtDfhIpMd8DGjxrqc+jyj+ceibPhMFsTUJWe1qzz
         4gfrJho7l6PWTpM+Ev+HLoo/gDW9h+qvXa7mvaiU+H75PkYE5iJZECiBunE2j5wWAWmG
         ZmRdtwqF1McKbl60Ve4hn12Laa3GYNF5rG69E9v2ZcHtJNVbaIqvmSh66DhvwDejUCx2
         R67698wubqL/XJXeQJbv/un7+OHV8nPmFTbdIu3DHvMyupmw14NyK5JZolIKwsLXNV1q
         idIA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ6IO+x+GbtZQt9pIj7xUg0tlbw7XZrXbiMX7wYVc48j6sJ0vYmQvgDdsA5UPI8U2yQy1oXoiyyrvjpmW6OaeUjwTHCzrI1lPwZQXI
X-Gm-Message-State: AOJu0YxXjaUg6yJcZ5pOxxnI8VSTTB/pl3xqkHnbTn2WCWOHAXZ5ggEc
	39HMcX5St6YX1IW4CMxjSweNz8fEuA6rhURXBQc9G2zlP1ylpQ0Vy+0YswM85bo=
X-Google-Smtp-Source: AGHT+IEVsMcS6+7wufPf6Z6lst2MBU5R+h9CJE7+OjLz9j0eS8xJzhCtKfTAGpUKzPFSFcnOw3bIlw==
X-Received: by 2002:a17:902:ec92:b0:1f7:9a7:cd33 with SMTP id d9443c01a7336-1f84df9b5admr85978835ad.3.1718374925217;
        Fri, 14 Jun 2024 07:22:05 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:04 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [RFC PATCH v2 00/10] RISC-V IOMMU HPM and nested IOMMU support
Date: Fri, 14 Jun 2024 22:21:46 +0800
Message-Id: <20240614142156.29420-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This series includes RISC-V IOMMU hardware performance monitor and
nested IOMMU support. It also introduces more operations, which are
required for nested IOMMU, such as g-stage flush and iotlb_sync_map.

This patch needs an additional patch from Robin Murphy to support
MSIs through nested domains (e.g., patch 09/10).

This patch set is implemented on top of the RISC-V IOMMU v7 series [1],
and tested on top of more features support [2] with some suggestions
[3]. This patch serie will be submitted as an RFC until the RISC-V
IOMMU has been merged.

Changes from v1:
- Rebase on RISC-V IOMMU v7 series
- Include patch for supporting MSIs through nested domains
- Iterate bond list for g-stage flush
- Use data structure instead of passing individual parameters
- PMU: adds IRQ_ONESHOT and SHARED flags for shared wired interrupt
- PMU: add mask of counter
- hw_info: remove unused check
- hw_info: add padding in data structure
- hw_info: add more comments for data structure
- cache_invalidate_user: remove warning message from userspace
- cache_invalidate_user: lock a riscv iommu device in riscv iommu domain
- cache_invalidate_user: link pass through device to s2 domain's bond
  list

[1] link: https://lists.infradead.org/pipermail/linux-riscv/2024-June/055413.html
[2] link: https://github.com/tjeznach/linux/tree/riscv_iommu_v7-rc2
[3] link: https://lists.infradead.org/pipermail/linux-riscv/2024-June/055426.html

Robin Murphy (1):
  iommu/dma: Support MSIs through nested domains

Zong Li (9):
  iommu/riscv: add RISC-V IOMMU PMU support
  iommu/riscv: support HPM and interrupt handling
  iommu/riscv: use data structure instead of individual values
  iommu/riscv: add iotlb_sync_map operation support
  iommu/riscv: support GSCID and GVMA invalidation command
  iommu/riscv: support nested iommu for getting iommu hardware
    information
  iommu/riscv: support nested iommu for creating domains owned by
    userspace
  iommu/riscv: support nested iommu for flushing cache
  iommu:riscv: support nested iommu for get_msi_mapping_domain operation

 drivers/iommu/dma-iommu.c        |  18 +-
 drivers/iommu/riscv/Makefile     |   3 +-
 drivers/iommu/riscv/iommu-bits.h |  23 ++
 drivers/iommu/riscv/iommu-pmu.c  | 479 ++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c      | 492 ++++++++++++++++++++++++++++++-
 drivers/iommu/riscv/iommu.h      |   8 +
 include/linux/iommu.h            |   4 +
 include/uapi/linux/iommufd.h     |  46 +++
 8 files changed, 1054 insertions(+), 19 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-pmu.c

-- 
2.17.1


