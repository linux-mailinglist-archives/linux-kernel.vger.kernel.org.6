Return-Path: <linux-kernel+bounces-235723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC37991D8F0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D37EB226DE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1D16F073;
	Mon,  1 Jul 2024 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TrCf7BKe"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D614E7E110
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818960; cv=none; b=Yl2CVtwP1Wa7FK54BmJVqn3VLcDA+SVeHdfHcfQJF86DrgbAa7N5SOckrHf45yv58Uw0S23Y1wzGqcHNRX0Cp18ELsIyj36rGAefxouVJqQ44qxyVHwzokYsSGAbVpEBZg56xuMvJNB+vLZTOv9wsY70fusD7Z4+3ghBpA+7qME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818960; c=relaxed/simple;
	bh=ud4FVBvixmqybTJpkYMtIYJPy3IRXCt7ASTyNTFo0Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VPOWz6PBWsR/8xwXGRdtvMAt0v2g6IZdC/5mMn9H0EL/NX/aJPeGO80zBe/jqcSSPdWVm3H7we1l247ddMePrXHefoCiyUVXOopZ5JRZ4kRxxPc+KHmfmV9nugEXUE+02clgySlMFXXkt8JM4nR9V0wUyVN/pIkCT5Bj18nQf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TrCf7BKe; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-706680d3a25so1588279b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719818958; x=1720423758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VGhqSiLMzxESl6q2TXeHQ+QtaRhhPlHzzW1Ik7jwLak=;
        b=TrCf7BKeBkLLWuMC7PwHagFBdVKFkGgLUvk5RNt7U3WLh4jzomfQXGkhC/eq3jyCc1
         AUiwwULNcPAA1+9Aw0+U5axseSTTSqWQff3MOYHsQy9GTUOvu9HWzMSvTposvcwO7Ph7
         8c+o3ezNrlLAqDrWbBndYjyMu4GriOOZo0iUmV5jundtcjKy0qY7RpCq1RqHvNntjFjC
         JG9dCZC+cLKPHveGB+kHgLEgxXuPmGRSd7Tr5G19qsey6qYA3e3NbbE6bTCi5AGE4W5/
         N8eda0gaH5fwbK4TfhunFc3jNa4cLqZsqDyAcuqwA0nyP8y/6NN0Y2sY60R3pBsxDAe+
         oU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719818958; x=1720423758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGhqSiLMzxESl6q2TXeHQ+QtaRhhPlHzzW1Ik7jwLak=;
        b=XywCOyi9W/ywJAGkbuoQY/xv1zSrRwjg9WbCdq3v1crF+SXPLbtwgMtx4jjnUkZkbT
         bYi4mOVElJPNTSIzR6q0gKU4vw0tvJhePacJJomr+JkP5/FgV9ebF1BonL3Ft+Sn8lJr
         5JmTlR0HFkv9ncRjvJpLGLf8dnOK9izwfH37BuSGdaxpViI00oVGlJ2OaIqqrTzR+aui
         Lqv8NjhAqMF5xnTjSWnHuuisFM66Lm+SalbJ5q0JZ9C4gXy0zwEmHXjVrLu08ou/7RCv
         OGGjgZyvAk++3aJUp0SEBmzcs3Rpx/FIBANbtaBCDdJYEq81yXljnSAtc3hoUKcwG+18
         Id8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjhSLvvmeCLFLyZQ/bcuJrmwSIqpJbjNCqofk8EkNTVFECnnBS5d1YOkloDj4m+rpHSsXImgiPQOuxzKHp6sM9DIYfmSB14wSTf9ln
X-Gm-Message-State: AOJu0Yw+Xvhauyd2Np8HN0o9XGjeDYpaJ+BoPZmF3TKxxXpYgW6Or/Bo
	CnHPql29I+barkKsKH/BvY6OznUQq1CtyvpzPaFE3rVCveGlwbrqsBFZTnkmVow=
X-Google-Smtp-Source: AGHT+IGMGQElpf9p3wHiQ0XgC52tuI2eBaue5vhEMaYrPXb1lA2D7IhLm40/sZqFmLeQyKwdlN8PBw==
X-Received: by 2002:a05:6a00:1909:b0:704:31ae:4fe5 with SMTP id d2e1a72fcca58-70aaaf25245mr3686034b3a.25.1719818958046;
        Mon, 01 Jul 2024 00:29:18 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf757sm5779337b3a.104.2024.07.01.00.29.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Jul 2024 00:29:17 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	paul.walmsley@sifive.com
Cc: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	apatel@ventanamicro.com,
	sunilvl@ventanamicro.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	baolu.lu@linux.intel.com,
	lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH 0/1] iommu/riscv: Support sharing irq lines between iommu queues
Date: Mon,  1 Jul 2024 15:29:07 +0800
Message-Id: <20240701072908.25503-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an additional patch for Tomasz Jeznach's riscv iommu driver
patch series[1].

It seems that when the number of wired irq lines is less than the number
of iommu queues, iommu platform driver does not assign virtual irqs for
iommu queues whose id exceeds the total number of irq lines.

If it is a problem worth fixing, please feel free to merge this patch
into existing commits. And please ignore this patch if we don't think
it is a problem.

[1] link: https://lore.kernel.org/all/cover.1718388908.git.tjeznach@rivosinc.com/

Xu Lu (1):
  iommu/riscv: Support sharing irq lines between iommu queues

 drivers/iommu/riscv/iommu-platform.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.20.1


