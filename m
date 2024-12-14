Return-Path: <linux-kernel+bounces-445975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBB49F1E12
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D567A05E2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BBD1547C3;
	Sat, 14 Dec 2024 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVfkIWWX"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F22EBE
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734172480; cv=none; b=oYBYIuywfke3R+5ddSVBbziixzPpYKWRWHo8dODLVpvV5KcKAnMMPmI5q2uK/ralSsJRQhwsqWi6qVYbpoRsg8uohTkT0YZhjJvwbrKvC/45MNQtIrH/Ewx1UxtGzueopz7LbcZpKJSDoH2j2t4D5x5w5DndrUJGEH/OjKCErfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734172480; c=relaxed/simple;
	bh=BAd/0j2AtuJzJkY70CVXd1EbmANcvMXyheaBSOkjCN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mEulR+1nE0PJ6G0byqEISH5hThSc4EbpJgpF8X1VIDOyaKxJ1yZQZsW7a2jNhUmraKmlojVu3M444V/bMKCTHrcbZcW6FmOAjazRL1hG32+bPkWs544mH8QPzzCofb/zJ3pMrpjwjUOcj8kPXPXHHoC9GeBPxuL2rnFLUFnmiGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lVfkIWWX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e0d47720so240686f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 02:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734172477; x=1734777277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq6s/wfYBk+ZemjMddvYvogmPT2NqpMDY7p5OVNj6tE=;
        b=lVfkIWWXu4paL8LXP/QSiDMgfFOpdQ36KoIy25nSUcsQSc0h5ZqBhUzNh2JvRGyDe9
         rMRSB3/vyUU14+7fIcwdp1xEsv78ozTmQOp0g+tHuMMvd1H9PCo+mhQKXkm44lg+KQkl
         7o6YZT9/kKpmLQQuPP4Mnt8aJiPQ/ptgr8r/teqOPBmr0o2fgx1bVYKDI/oXU6ciooqN
         CvvFGLjUXfh0plisZ0csnW/0feeFeMteJseGRCoJ5HM6itb+bxVNXtbmstA0n62Bohvx
         v842xK+9U7p/kYjF46rNv9T7RhHCln+qHLIOZepikvkZmrSoBi274CnKsa73daC2JyO0
         TfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734172477; x=1734777277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fq6s/wfYBk+ZemjMddvYvogmPT2NqpMDY7p5OVNj6tE=;
        b=tU0AZl6g/ZcezoGC07RkWbGgddo2iLf34sIf+UX47TT0rdpkYH6Hh7ZzcgIScX2rR/
         gjd1rYndpy6Aq8ZhcnTW1jRT9p45o8vePKjJsZ1F5EXNDefoVc5G1v+rVMBm9fNNj6Wa
         xMrvJWQwfxY4yV+z4tWBseRvARZvYy6zMV+cL1qL/s64Xj1kxtc6WYwMpCb1ajR10kWA
         cbjGE8jFxpt++D0wYe4A+mc3VfhGHDXrxZGix+O5M6BsRWCBjoQmvporoMVerxYGfC28
         6cRnTQQ/aSOAi58GXSxVvdFWNR0sLDe9HVkpuDVfwbe0KeTqGMHzOtP/dVuHbV9EYifR
         1B/A==
X-Forwarded-Encrypted: i=1; AJvYcCXeHHfatckVdRyRHZZ+NNLT+Q7CNJG/7DtVQn4PSxdFIlS0s2aT/VloU/P0Rdhgg/rGdBUwtpPQTAlpHvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytStbLE7fNmvPRv6ADAHU2EqDaihkgpNAmwKgfW+AorigIKdwK
	ri+vYRl1PcXwHkkDoD+CHXS6Nq4qf+GscnZyFIrMpBQdotkxhdz3clDa7RzKAL8=
X-Gm-Gg: ASbGnctM5+7UX/gWyc1XvdaYb7Q8kdOJG/dNlsakt/GTCFdUr1x1/zqxgon4zf2TqZL
	aLodPN6MZZ8RL+DoJYsyCV2PO9Zz11aXt62lis4vPDJkE7p0OwZkyg9IZlOAEadVYNIJLjesvzS
	mTKh14BwjKMYWPJ1+MejSGhseeQ5jBbbSzEUT/LFpePaL7tWppD8p1ZoUMIpAf/KGC4+WpQ7qHh
	Um/7tM8FS6qtAy060ZHToQC8389xbIhqmRourMR6b6m7xtI8HXfYITLpCb7C6SQd+Kysqw=
X-Google-Smtp-Source: AGHT+IGZVqeMRUhAYbg9AH7voB3+lxMPHQ/ldtxAwyAOMtaECInhdRHcp3XSg6K8vSgxZBBT3kSEOQ==
X-Received: by 2002:a05:600c:35c6:b0:434:a30b:5433 with SMTP id 5b1f17b1804b1-4362aa9f021mr19335045e9.5.1734172477096;
        Sat, 14 Dec 2024 02:34:37 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c357sm75243735e9.10.2024.12.14.02.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 02:34:36 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-mtd@lists.infradead.org,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: stable tag with TI AEMIF for v6.14
Date: Sat, 14 Dec 2024 11:34:28 +0100
Message-ID: <20241214103429.17501-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

TI AEMIF memory bits for NAND/MTD.

Best regards,
Krzysztof


The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-ti-6.14

for you to fetch changes up to df8e78607d4795806b59564ba7a3e2e125d119fc:

  memory: ti-aemif: Export aemif_*_cs_timings() (2024-12-09 20:38:27 +0100)

----------------------------------------------------------------
Memory controller drivers for v6.14 - TI

TI AEMIF driver enhancements: some refactoring around timing
parameters and finally adding plus exporting interfaces for devices
using the AEMIF interface (e.g. TI Davinci NAND controller) to better
configure the memory interface.

The exported functions are going to be used by:
drivers/mtd/nand/raw/davinci_nand.c

----------------------------------------------------------------
Bastien Curutchet (6):
      memory: ti-aemif: Store timings parameter in number of cycles - 1
      memory: ti-aemif: Remove unnecessary local variables
      memory: ti-aemif: Wrap CS timings into a struct
      memory: ti-aemif: Create aemif_check_cs_timings()
      memory: ti-aemif: Create aemif_set_cs_timings()
      memory: ti-aemif: Export aemif_*_cs_timings()

 drivers/memory/ti-aemif.c       | 192 ++++++++++++++++++++++++----------------
 include/linux/memory/ti-aemif.h |  32 +++++++
 2 files changed, 148 insertions(+), 76 deletions(-)
 create mode 100644 include/linux/memory/ti-aemif.h

