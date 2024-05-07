Return-Path: <linux-kernel+bounces-171503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068368BE539
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A5F1C2401D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACAE15EFAD;
	Tue,  7 May 2024 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ena+8Ryy"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3617A15E1FF
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090864; cv=none; b=ibtCypWhzqaFd/rglnJyj8olSVebI/WUhqjJs6yEUxL3IwgB0sl5kjUSELyWEG9YesODfAt4ubs9lSW7g9NTXTm+JRUfFp0xQ6ZHnstDo/uqHD9CP77lctqMorYGhSgabDDKcMfd+fScU3YdPNZNoYyAP3HnePiZ9iqkH7sGV3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090864; c=relaxed/simple;
	bh=3kMEdbIdgG0v4HUHY9kiHl86gb8P0atzgdn4djrB8b0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EKalWYRdmCzjEkIj7yGLWjMtSALL/5b5E1wKENBQFksDFKi7uHGz+Y1STTpwFtcRt6DtyRPpvbuBfRcYA0JXPgim14eAEcBj75W+mIFQC6wLqhoODQTLIrb+ldDQVnkKe+Xl0H43Ym9TvmMHf3/FCmxKBcoOAXnvjzOxtZ9S+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ena+8Ryy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ed41eb3382so24089845ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715090862; x=1715695662; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkGvtX4jUwYRJLbDOy4RLI6M69O2g7lMQEi2Kh6V+XU=;
        b=ena+8RyyHCJ6trgdawHANLinkXBV1SzfOpJSQHfjdrqagtikKhe3trCZRLbmNADQOv
         n/h3rPT/EXPP1ceFCCDebLEliannTCkzB4gnrcVUVr3MKEe1ENRuAyz6Wl+LxzzZtmqD
         6Y7YfjB5xOE/ETs61vQiFDoUZo5l4lVH2cHuViTbMz4+V5IIisNNXW7YC3KqlVZgsIpg
         K/fxErxFS9Mi9c+jh6nfl/zSoKBoQUFgD0oE9dnLQSxKLaIk56TmOm6Vr7P6noEIYQeH
         VidcINxn2dXztYZAqgUQTUFS8e/w0gb8zr8wEL9WxcnkXZfn2P1DfEAwHm3X+28woPYL
         fNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715090862; x=1715695662;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkGvtX4jUwYRJLbDOy4RLI6M69O2g7lMQEi2Kh6V+XU=;
        b=NI08Ng2NR52B8+bixyDMK6vVJ/dOP7+WuXAM06TxbWGfslflEB8afTn3NNbfZ20A3T
         8667ljNn87nVFMupYq1Cr577uJJIqlIZJx1Lq7SS39iGC3ijfuW62aKs4OtYaTGO6uLK
         PcQRlAkD/DyNDdPEJXTyX8gvhVSJuz55E82ON3Rzo/EKMWwPybDt3Ipbwyu02hdk/iPp
         kWrdZGVXUPO3K+EZHsV+beVQz6kTG1Gc4R/69pKzH51a8xYlClPTPYh5n/GvF1VFDA+l
         /pYZo97846U4ZPEeVhvWC7UVz62lMcdwJ62EVbpZtWCKncS3JUtUq0KnNqUHa0/98KL1
         mwWw==
X-Forwarded-Encrypted: i=1; AJvYcCVOPT2+ny3ggcOfnfTzZxfomeL2c25rJSBMc25KMtHT1/gHek9qHVCoVGWyqifJY9AxEqjcu/RVzLWhi4hkC0GAGCyuWDQb7ferWdev
X-Gm-Message-State: AOJu0YwLBt5SF6mrBJkd0gVVFeqNt4yvvXlDw1CWab/PinoQLvufGgtx
	nYbi+Ue5MHMOcIVNNSAdVlD4Yq76AOZv0ac8EW6NSTy7hdKo13zWnGa3Zbl1gwI=
X-Google-Smtp-Source: AGHT+IEZquwWePQ2daUPDLBtKy+IdyRf8hFqcaeC1wV3eDUCTRzWsQMIJUGo2E2KSkbpK4Iiw+UIPw==
X-Received: by 2002:a17:902:e947:b0:1e2:8841:8d67 with SMTP id b7-20020a170902e94700b001e288418d67mr18129070pll.32.1715090862451;
        Tue, 07 May 2024 07:07:42 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090301c600b001ecf8659bd7sm10061883plh.257.2024.05.07.07.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:07:42 -0700 (PDT)
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
Subject: [RFC 0/6] RISC-V IOMMU HPM and nested IOMMU support
Date: Tue,  7 May 2024 22:07:31 +0800
Message-Id: <cover.1715072254.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This series includes RISC-V IOMMU hardware performance monitor and
nested IOMMU support. It also introduces operations for the g-stage
table, which are required for nested IOMMU.

This patch set is implemented on top of the RISC-V IOMMU v4 series [1],
and it will be submitted as an RFC until the RISC-V IOMMU has been
merged. Additionally, it will be updated as needed when a new version
of the RISC-V IOMMU series is posted.

[1] link: https://lists.infradead.org/pipermail/linux-riscv/2024-May/053708.html

Zong Li (6):
  iommu/riscv: Add RISC-V IOMMU PMU support
  iommu/riscv: Support HPM and interrupt handling
  iommu/riscv: support GSCID
  iommu/riscv: support nested iommu for getting iommu hardware
    information
  iommu/riscv: support nested iommu for creating domains owned by
    userspace
  iommu/riscv: support nested iommu for flushing cache

 drivers/iommu/riscv/Makefile     |   4 +-
 drivers/iommu/riscv/iommu-bits.h |  22 ++
 drivers/iommu/riscv/iommu-pmu.c  | 477 ++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c      | 481 +++++++++++++++++++++++++++++--
 drivers/iommu/riscv/iommu.h      |   8 +
 include/uapi/linux/iommufd.h     |  39 +++
 6 files changed, 1002 insertions(+), 29 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-pmu.c

-- 
2.17.1


