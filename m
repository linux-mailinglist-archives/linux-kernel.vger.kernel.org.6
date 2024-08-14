Return-Path: <linux-kernel+bounces-286689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D355951DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9146B2CBC9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46261B4C56;
	Wed, 14 Aug 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fbQvx3Sv"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD031B3745
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647416; cv=none; b=pldSUi7nPv9YCWEh3ZBmGG3lJJKnMd3/wrlhnCK8yhav7rIYzfhWlTT4lJnHorW2ibe9o7bSx3gAKVfsgMKssy8QA+/sTWIXXK8ECMZh0bFM6N0YJeKQgPRT+1gQZvxiA6vZmXXfEpB+IXK+gxytiSMgt0FDqnxDCysJ/XN1bNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647416; c=relaxed/simple;
	bh=n5g4/r8R0Dy5GXc8xi+OU8Z0eLkUCmG5FtYMVQZogf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3ri6JwHxgxi5/RbMVhgvX+HaPLufwowSs7PnodkLZBSQfM2rW9g9rvjHnlzOKFQwHEvBy8yiQZs2tqHFNgE+33ktdIVVggH/hVeLuZfNCJ4efmkGfMeuj7+LXzXorsHP+psw8JBU9fjoFkY99IvdOe1yONZUkHw6lYa7MRvUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=fbQvx3Sv; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 01A56400B0
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723647409;
	bh=1wRtYUtR8UlqWuh3Z5TcGqfoeh7JMRQxw9M4F5yrv74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=fbQvx3Sv+plNk7jizSXQAYUR4MYLXagi7S2e0KHXy99Rcnm+oJdLwtrIK9RCqbDWF
	 qcokZH//erjHjEbacsVF6fTlUJkmFp8gfXgke7tAAq4AmG+GGgerJ86g2BtgQI70te
	 rzd9I2h4ilSEkKs4EhnOzwGZhnuMRIfkIZa/ZYHqDWvBZSnCGwOKluFAlCPYyat5Ct
	 Kj56dYPt8tCHzpT0MvEhhVQu1CqPeSMA/vokB01TNy2ewrau73o5xd6Nkl2M4z5AGo
	 a1Ue1H9wnCE23EAJITzhkMxQ0ahCmaWsY7g7EVpHTpbrCtHXVfy16wx7KHOkklkG4d
	 fKOlsjWajo5VA==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7d63fbf4afso646931866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647405; x=1724252205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wRtYUtR8UlqWuh3Z5TcGqfoeh7JMRQxw9M4F5yrv74=;
        b=c6QSwNkd0wNQ67xuc06x38bNjT8WB4ex3i8KLEpG4oG+r0BncRZpKSeVkEgCVR+zO2
         q9csF5O+scDJBOWxmmECyY8XQRkKfjnJiCcDmgp/RBJI9tCccG9lk2f6/jEHvNIo/I1I
         vH7zag8IE+KJrodocVRenbVbIJagNKJPAycNfl6H1+Qggh5YGgl+8aEgoeAhBPVgo4Qt
         W/Icr2cNH/25oiRwRlnx9si1Jv6wI7AXeRmKMcEFSxM9gr8XPbKAvUdgewknotKHycf5
         ZK/AqP84itIwHmYAbt5R+3djdI1R8RhPi8P86pWa92jhyqDOMArD+1OyVr/vl1Jw3ZFl
         nnAg==
X-Gm-Message-State: AOJu0YzZTD/of67AQMgtT2jAqfu20HHuEC6X13YMXJGpt33FcdS+i4OH
	ZlYFierT7DYKjKWp2U0SgCKUQysXZo4kNygAhPa/jUJE43uT9YOz0CFL31bGbetJCZ8Ylt7aEve
	keg506r94ef7KFc3nV3Z4DrUmIJ9wIVrm3VeFMd+Eri5pDoHbtxHQKV6o7QE1J3F6uawEC9++tG
	x4OjJi7I4AHA==
X-Received: by 2002:a17:907:e211:b0:a7d:edb2:21f5 with SMTP id a640c23a62f3a-a8366c30b5bmr210859466b.12.1723647404935;
        Wed, 14 Aug 2024 07:56:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQWZpAuZgbaR8dtL1ZzyQGO7tXE160bYSLtf1lpTYlgFKh4xYX7pWpwI3T11+uHl2LSysZkw==
X-Received: by 2002:a17:907:e211:b0:a7d:edb2:21f5 with SMTP id a640c23a62f3a-a8366c30b5bmr210856266b.12.1723647404030;
        Wed, 14 Aug 2024 07:56:44 -0700 (PDT)
Received: from stitch.. ([2a01:4262:1ab:c:bbf4:eba3:898f:7501])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411bdcbsm182316866b.105.2024.08.14.07.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:56:43 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Anup Patel <apatel@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v1 0/9] Fix Allwinner D1 boot regression
Date: Wed, 14 Aug 2024 16:56:32 +0200
Message-ID: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Anup,

As described in the thread below[1] I haven't been able to boot my
boards based on the Allwinner D1 SoC since 6.9 where you converted the
SiFive PLIC driver to a platform driver.

This is clearly a regression and there haven't really been much progress
on fixing the issue since then, so here is the revert that fixes it.

If no other fix is found before 6.11 I suggest we apply this.

[1]: https://lore.kernel.org/linux-riscv/CAJM55Z9hGKo4784N3s3DhWw=nMRKZKcmvZ58x7uVBghExhoc9A@mail.gmail.com/

/Emil

Emil Renner Berthing (9):
  Revert "irqchip/sifive-plic: Chain to parent IRQ after handlers are
    ready"
  Revert "irqchip/sifive-plic: Avoid explicit cpumask allocation on
    stack"
  Revert "irqchip/sifive-plic: Improve locking safety by using
    irqsave/irqrestore"
  Revert "irqchip/sifive-plic: Parse number of interrupts and contexts
    early in plic_probe()"
  Revert "irqchip/sifive-plic: Cleanup PLIC contexts upon irqdomain
    creation failure"
  Revert "irqchip/sifive-plic: Use riscv_get_intc_hwnode() to get parent
    fwnode"
  Revert "irqchip/sifive-plic: Use devm_xyz() for managed allocation"
  Revert "irqchip/sifive-plic: Use dev_xyz() in-place of pr_xyz()"
  Revert "irqchip/sifive-plic: Convert PLIC driver into a platform
    driver"

 drivers/irqchip/irq-sifive-plic.c | 296 ++++++++++++------------------
 1 file changed, 117 insertions(+), 179 deletions(-)

-- 
2.43.0


