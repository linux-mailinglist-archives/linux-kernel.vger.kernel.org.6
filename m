Return-Path: <linux-kernel+bounces-171570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFABE8BE5D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751BE1F22EA0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBF615F330;
	Tue,  7 May 2024 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UodZUXOM"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B115ECFB
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091967; cv=none; b=erMzXhBR1AUEkXazxo6xnqukUXXKIkhcNQJw3wBmI8xE4Dqd80XVOpYpyBglfdt4VrwtVuF0YKO+nxJUpThcllw/NH6lAiKNbovsDmKm/onXLldy1xIJHxnC/YXD/ulKlXt28IDK3yZvKpaoZDpnZ5UNBfTskKUggju1gUqMXvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091967; c=relaxed/simple;
	bh=3kMEdbIdgG0v4HUHY9kiHl86gb8P0atzgdn4djrB8b0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BsLIlrqmJgTrcZezp4jz2AGThurq9lwTAOY+Xee9mbRenwljDrn2H6pESoBuoz1WYwcSh8QdkJkGNdFvh/wMk+nH7oh0ba3WkwGg7sL4BvSmvyjYEPCE1FzYHEBBnDRDDMHHKD+oGM4wfgdA+FzXcb7lKoEkNwhrT/Yx97mRAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UodZUXOM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f44a2d1e3dso2701031b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715091965; x=1715696765; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkGvtX4jUwYRJLbDOy4RLI6M69O2g7lMQEi2Kh6V+XU=;
        b=UodZUXOMFO8Tzx585sLLDoMJmpWXv/UA2FRisAFWjdotupFDshimAUzTONYNpxLW0f
         OnnqkMTqDgswlQBI1QBn74Qc0SDApByIYTkhNv2fQXA1i9RupJ7MFHTlMvFyhlH++p26
         6F+Qp11voRNb71b15dnw8EpAN9xJ3KHwE5w7nQpGcUSk8cDLsrKaCaqj8zIV98PbM68q
         kYwq1ti0snHquwGBsbIjObR9OS6pry+BXIwOZWAnf9GY58TEHvFRKkXlxnECSGhmsc1D
         y+mFglQ65tq+d/AcnXhDovmwvcc4SUrw/5YdQ+V9JikwA7A0XL4GGOtQCPR7fgsJpEDY
         EMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091965; x=1715696765;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkGvtX4jUwYRJLbDOy4RLI6M69O2g7lMQEi2Kh6V+XU=;
        b=sYK8Tw3wdP4MOQVHkd9KafdDtalxjbheZxDgdBRbUbFTHh5g6zy4bhYr5SdsLeIyXm
         aoE2sXJ0jIjSytu9sA7GKloTJD0jxhfCXs5BYd1+xDr4+DtydrYDy5QmWIMClOrTAtVs
         Cv5NvKL6O7nud/Sf2AZS7+Yapj0XVcfy/sjx+ZLIsQXRVnxKAPhMLEo8ttagZY8tVnTn
         HFwmMZX9WNUJzhk2Y4KHvkgR3htvO0/2M99EBgyYriJ2Ryt6B8APq6Q3AUlWxR3n18mY
         K+SaC4X0Di+BC2XHQpZT/wqH5phufhopZJWjiIuVpIoMt3Eb4Q5YwV6p+TpAa9WmwzDP
         JfZw==
X-Forwarded-Encrypted: i=1; AJvYcCXsuowL0hSIqgNgmgFqZisNwhuqQNm/DDQcmn2UUTVi22qRZ2x3ELBdAyg3SM0sAMu8+AwF+Pt6d42GTDPkEfDwgf086p6N6Bj1sy27
X-Gm-Message-State: AOJu0Ywfa9HrUN3PG9ESUBNJiL63rB9tNX8NstGEj0/58MBjmBOZJB0b
	CxV1bnto66CCzm1C/5iWZuXrbkqI+OrPzwkYQNPCICR6eBHRKHFE0JTkycRiTMw=
X-Google-Smtp-Source: AGHT+IHfG907D2ZaVYbVRAYvbH+/piHHBre+FsyAhb2B6a1VTqojpliLbTmA9dXHy0VdebudgPk6cA==
X-Received: by 2002:a05:6a20:914c:b0:1af:a4d0:1614 with SMTP id x12-20020a056a20914c00b001afa4d01614mr7766162pzc.6.1715091965553;
        Tue, 07 May 2024 07:26:05 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i22-20020aa79096000000b006f44bcbe7e3sm7687554pfa.201.2024.05.07.07.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:26:05 -0700 (PDT)
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
Subject: [PATCH RFC RESEND 0/6] RISC-V IOMMU HPM and nested IOMMU support
Date: Tue,  7 May 2024 22:25:54 +0800
Message-Id: <20240507142600.23844-1-zong.li@sifive.com>
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


