Return-Path: <linux-kernel+bounces-398680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B679BF49E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F357B1C23ADD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B60208209;
	Wed,  6 Nov 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="i5obsU+C"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11C206043
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915469; cv=none; b=MSzNM7J+4adQxGnsDbfaDL2KL0+iv3TqXsY7jPN+m2sh8FDeW/T0t0lwTQGkM4DJluejWCG2k2cLXfMRvOYckfrKC7G8Z+ZlW1Y6/fUis9Z6/S8iKJMnYULh7xehmLitoNwhZC2aT0lmQ+WSwugC5N3d1Aob8nqaO83ZD5bCoww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915469; c=relaxed/simple;
	bh=AmNubWSFsMbGUCbqMjD6qzHq7thjNbyHZT8pPh3Hg6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SdJZStigwKg9DbJzxCk6s4pvcT152mmfuLdwDgfjDUlFp6S8Pk2ikGyZoaht0XpI4qOYpfgU+jiZfxoYeR2LmtKzaahlkj27G19nGSsDdPB4xdlCDTu1GUuIqrc1O6VIAE//68c4o0Epn8Rts3sG4ipycsP2MizLBJOfDkDb7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=i5obsU+C; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso3828a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 09:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1730915464; x=1731520264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVcjUYi+p2tO+HyWvtxM4cA353hNsNdE371FkKVPyL4=;
        b=i5obsU+C/Cw2p6tGPSDn9/AfQb77OxkCQ4Zrm0vOImztHrEurj6aS2bDiDkjh7lWAv
         b5m+gxS+qbP1tu13iSAGE46QM+LOZ451S6i2idaPrArHLsHEQXFpuhPmOwVKFL9GXpay
         8Yu4bvnwHMpvmrARZR7Aqwe8kioG8j+Q2ZO6wDvHGjJQovjVLz4ZddaHmdZtbwfqLD+f
         bXf/FYhBNo2fy338XwxssDQhDDxBRzey3u9zThZsxXVDfA46CG+Z0sKbpfLpJhToOz9A
         77uEYNKGrczUfle2m6GqNNrd7CDdx9B4FdgvICMeVMRt8aRSbHDjWQ7+oHdZxF1IltGa
         1uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730915464; x=1731520264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVcjUYi+p2tO+HyWvtxM4cA353hNsNdE371FkKVPyL4=;
        b=Ds+fbAJGXqiQCHghINNuV413igJDi+YST5PsorZZBREDHC7cX3RbSXHrU7zg3zLpK5
         5XjxWzy++hB2JISo+wlqw6Mgs/7iXj+R7eek80mBsnkg1xl/j3g/5Mb6cMzSCyS/l8Nl
         IA4BAnQVMjaZhLiI2wUJI9E09kH+hsvHLe2FgMQYdzCMubw4Yt95Fe1Z6gOF8eacbvuM
         3yXs+HBAxV91+21xeOPqaIXsghrDhYFty4xfxPtyVHkm8A2P/+sHDmwfj6n8IW/gjt07
         LvhXYvcFYuLfELwnWEX1fG7+eQ074pWZZbEMcEbJ78qpgRsmPYg9/cY8wnIKcgONfn27
         sePQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlq1avj5h/dBxlMKbNHVObVQMIwhJgZzA8PyWkzTzwYbjd016awGSp2y/v2Mfn9BtxX33uFcp6V01/jnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU76O9weSYRfmf/DmPOLgytOLEQblNSsX0SQ2aUGF5GSp1QKHj
	caM2D6xzzmmneFzywKYd0OkrVEsyseDVjCedyMLr030wzxzPBSUGEK27FKO4fAA=
X-Google-Smtp-Source: AGHT+IHXfsJQTYy5HHptGM/9osFkvYFJQ5HtzeFTl1ShVaweHG9C+gB1ii3r1lKuqPbvrPZMSrlCpQ==
X-Received: by 2002:a05:6402:510e:b0:5c2:439d:90d4 with SMTP id 4fb4d7f45d1cf-5cd54af9db7mr20651491a12.30.1730915464436;
        Wed, 06 Nov 2024 09:51:04 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6b0fc63sm3075873a12.83.2024.11.06.09.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 09:51:03 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [PATCH 0/2] iommu/riscv: Add platform msi support
Date: Wed,  6 Nov 2024 18:51:03 +0100
Message-ID: <20241106175102.219923-4-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is fix for an issue found while preparing the second.
The second patch adds MSI support for a platform IOMMU. The patches
may be tested with QEMU when including [1].

Based on linux-next commit 5b913f5d7d7f ("Add linux-next specific files for 20241106")

[1] https://lore.kernel.org/all/20241106133407.604587-1-dbarboza@ventanamicro.com/


Andrew Jones (2):
  iommu/riscv: Free irq vectors on pci remove
  iommu/riscv: Add support for platform msi

 drivers/iommu/riscv/iommu-pci.c      |   1 +
 drivers/iommu/riscv/iommu-platform.c | 102 ++++++++++++++++++++++-----
 2 files changed, 85 insertions(+), 18 deletions(-)

-- 
2.47.0


