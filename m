Return-Path: <linux-kernel+bounces-304439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60A0962013
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A466D281A02
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFC91581F2;
	Wed, 28 Aug 2024 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFZFzZgM"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A70770F1;
	Wed, 28 Aug 2024 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724828122; cv=none; b=Rr0Z2fzZsFmu2yhokvqxetxsiStQHYkm6Pd9JzkiIseboaNLM/HDwXkCOtJvU8eFbF6kgk7hWpBuYdNEHCTrIBH7NK8ULUuL1HIG3/1G5sSWmx6QX7kyFiC0bMUBVHbSGSSw1EHUpPFvtWh+Nw++boXxJOahJb1kygF8xT/7FlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724828122; c=relaxed/simple;
	bh=HMsiKX93vH4tyRC6pQ2hda4FNsg7vm6hdcU0wNIk7AI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jrFMhdu4TqnuI8ulk8sRoPflYvbHqH2lunAthHh/5Yq0FWYrTYPvjnPnJ+j0AR6Und5b/7DMR8u0sQeoxNns+bnTzv7BqLzBvy51g7XtN86p4e8B2sy25Qs1q2myJVL4E8ioQwLjh39RADTUWuG/BqTvQJ225CqaQLbNHtbUdzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFZFzZgM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-201fba05363so53556795ad.3;
        Tue, 27 Aug 2024 23:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724828120; x=1725432920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y574CmIKcywIxcvCP6EUBAVLWIdKH8rgpanWyLXGN4E=;
        b=YFZFzZgM/zOXgL6nI0jynFmzxSNE6gcootd095zR6c09z3TZQcS10inF2J877u52Lq
         pcwAQ8DlI+4iZOardlDEiBrtOw9KmGiXp89bQMNDXaWjeFNO9NGw4zyKlJKxP7Qr6nBP
         f+2Ch5RpAAipYrKYS7VE2ksCdCyai5oslpISGHZwgIIwul/lgfNSENm6EVzQcvmcoEpO
         vBNS6s0LAl1cYg2IYkXI4QOs05R3ng8TOOUBp94DH9g104q7MtmKTLE+OfpL+XcnODO9
         Seg69orzkWO1fY90lWusF9d+0WnOSkREgksb7D+0bVQMmixhx36gJyTGiFT9YZKRGi5g
         pODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724828120; x=1725432920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y574CmIKcywIxcvCP6EUBAVLWIdKH8rgpanWyLXGN4E=;
        b=gWcN33LVzPTruD/GqTk2Wf3W8nn8vCdVgzpjqiBDRMPyDGQA0/Fej5HNrpO3DMSbie
         +M9iQbbZvzxNis4cd7J41fvvHjSO+igToXk8zaL9HCuM6943Vk1Gfz+N9wvCyG1Ox5sw
         pzyguhmuRUFBi3gRycIJ4Xuu9oGEoWLST4ANc1My8cBdzkuLEUWStWGwEacFJG1c4XAo
         L/Rpqb42h/jbqPOQQ0+U6D+29OtZyBK6LPOPtJ0qp+4N9J8UDJ8Qnfj0PuM6l8mWDAyz
         sAQDg+lm5XG5I+mBS1Cz/7wwGQUwacDCvrRlmmwzgo3WCUD4LZgGMnefAd3k9AgAruiF
         ic0w==
X-Forwarded-Encrypted: i=1; AJvYcCUizlPs8xnjwouqP92jrNls1OS3N32YqTcOw8lCxGMHxk5jUcIk+fdvbuyOqdoYTeVYz4pV0XNPCLplFYSK@vger.kernel.org, AJvYcCXRbFzKjLBFnzf73+nOJvYiRyS/JFHNJC32iob1Zh/NrFi0BlVK0BdaGWdZq2MMylA0nJzxQSZbIiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy31C/PjaMuzN/nuSSfC3xDkSRTx3yZf96wlLsMa4TOrgd4m53K
	9wuiyAtwU31s3z4GIxIiNPOTK1TpYsbFXEr7kOHrLmltG+sxd7Di
X-Google-Smtp-Source: AGHT+IEr75YUiPOn/QVcVEtUzyKHpnQasbYQYnkmKjNPiEoQCXEnkKLiZrGu/ut1KsP2T0+uM7FknA==
X-Received: by 2002:a17:902:f541:b0:204:f324:e7a8 with SMTP id d9443c01a7336-204f9a3e92bmr14866705ad.6.1724828120492;
        Tue, 27 Aug 2024 23:55:20 -0700 (PDT)
Received: from m91p.airy.home ([172.92.174.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385607f94sm92816005ad.182.2024.08.27.23.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 23:55:19 -0700 (PDT)
From: Bo Gan <ganboing@gmail.com>
To: zong.li@sifive.com,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Pragnesh.patel@sifive.com,
	aou@eecs.berkeley.edu,
	erik.danie@sifive.com,
	hes@sifive.com,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	palmerdabbelt@google.com,
	paul.walmsley@sifive.com,
	pragnesh.patel@openfive.com,
	sboyd@kernel.org,
	schwab@linux-m68k.org,
	yash.shah@sifive.com
Subject: [PATCH 0/3] clk: sifive: Fix chip hang when booting linux directly
Date: Tue, 27 Aug 2024 23:55:17 -0700
Message-Id: <cover.1724827635.git.ganboing@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the release_reset hook interface to __prci_wrpll_data.
For gemgxlpll/cltxpll clocks in fu540/fu740, the reset pins also have to
be relased for the device to function properly. This was missing in Linux.
The board (Sifive Unmatched/Unleashed) happened to work because previous
boot stage (u-boot) usually already enables the clocks when trying to boot
from PXE/network, and the release_reset logic is present in u-boot. When
booting directly from firmware (OpenSBI) or when u-boot isn't configured
with networking enabled, the board will hang when cadence/macb driver
starts initializing the device.

Fix that by taking the same logic in u-boot and apply to linux.

Bo Gan (3):
  dt-bindings: reset: sifive: add fu540/fu740 reset indexes
  riscv: dts: sifive: fu740: Use reset index from header
  clk: sifive: prci: Add release_reset hooks for gemgxlpll/cltxpll

 arch/riscv/boot/dts/sifive/fu740-c000.dtsi    |  3 +-
 drivers/clk/sifive/fu540-prci.h               | 16 ++++++++++
 drivers/clk/sifive/fu740-prci.h               | 31 +++++++++++++++++++
 drivers/clk/sifive/sifive-prci.c              | 23 ++++++++++++++
 drivers/clk/sifive/sifive-prci.h              |  8 +++++
 include/dt-bindings/reset/sifive-fu540-prci.h | 19 ++++++++++++
 include/dt-bindings/reset/sifive-fu740-prci.h | 19 ++++++++++++
 7 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/reset/sifive-fu540-prci.h
 create mode 100644 include/dt-bindings/reset/sifive-fu740-prci.h

-- 
2.34.1


