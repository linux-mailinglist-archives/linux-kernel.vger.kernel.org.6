Return-Path: <linux-kernel+bounces-274099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF8D947360
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 04:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDF81C20DF1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 02:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C412D7B8;
	Mon,  5 Aug 2024 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuj/o7wf"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA63C0D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 02:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722825213; cv=none; b=mZswFvq5bUdsgfdNpjgCREN82BiHX4CHY5NGsWc/B6EPkVaC+eAm/zIstokLjLnJeliD+Lz1WtdjuWFCCuuMlAvMdcRUgR8l5irO38YoZOvCWFpVvd1nLPeIwQA6eI1oJbaage416VPr1UD6N1gu7dSZHkoLcAAfbySSEQspJb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722825213; c=relaxed/simple;
	bh=iW/33+v+ni6zAqexP+Uaze5DTB5yr26RUEedaPlpwis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MBVRfoRamBC5jrlkxlhD5RgZw4RstHGOrIjwPzPJlureHAJzeserzoY3x3LGhZhLMi0ntiE6+tSSEKlZ2gIDtww4PmmdGQE4/MqG8E9yE6yYPoXb8qg97qSRGIbc2L7LZ549be4NGIR950s+wGI7zj1z6iF4Ab0nT5Q4UUgvgZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuj/o7wf; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db130a872fso7051163b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 19:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722825211; x=1723430011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2YwzBkOvf49wpb5oldLY8LveiVGUoRl7flabXImH710=;
        b=fuj/o7wfA679kIYIpl6WmqXNb+JLzuv19imlq8897y2izhoFwQcM3D1na7sE56o1ob
         5pFsoz2wVcQUDYdFx0EnfkWNHte5LoCMP/BLY84ryGJS1jDZ0U8ZNoXjLrXjuBn1ud96
         82bePNP9k8C7JuOzAmI/hRnxgshDTGEUVJpkWUyBhP7d/gZ7RhqznGJOo5oGtFrtizoD
         VbKY2P/z8o40Hpi2+Q/LMI0amTZwuBDghlAmgK21DHDMAwAbbcBaZ9SLVHvRLKgLERkG
         8sxB6/z5oafeS7sHAfoToTILCk9zUZE7qGs7Bug+Cm5dXCe/wnkESBfRkX5IJnkW36hS
         J6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722825211; x=1723430011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YwzBkOvf49wpb5oldLY8LveiVGUoRl7flabXImH710=;
        b=p2Tqprlx6mSThZmjTh/1km/RjdXd6BoFjsxjiRt7GCkRmaxD/Qte6MXWPyL8W13v47
         woxKIb5p3MsrZCGP7d3L5PfV0DavttTDOBRDrf/vdcqX91n8C9YegtrhYT12I7v3xkBt
         3Ef7aloyKgVHb/5q7a2k39y6+Nci3pCxJGiPLDdLb/0fqPBry219OSx+AOfiGWo1NTNW
         FhdqcI/MPGYrDXPfqd+Ma5Od9VgkaKg6dcSh1KcDzgQ4JwMLDN2W1LZozwKD5IXqH8Qg
         xGCVsylC03uqZJBFYdJEEPHsK268Xk8wwccgVKPg17t8MFYShnx/Xh9f7oMc9P3fvC44
         hIXw==
X-Forwarded-Encrypted: i=1; AJvYcCX0yIV2pVBofO3IuMEcSlZQXVN9+kGZsOch60Tzsr7sWONx5mW8T3Cej5Oo7tQYbzCn+FufPM0a34ETiXwNvGeep38xlRamr1ELFpbA
X-Gm-Message-State: AOJu0YyHzjw2gEfRBvsbKcMcGyKqTK8My8ruuVRV8x0LJJhlZb5v2Pfa
	j7OwE2vll6GeZra3XfmMQlS28MbaroqcyieoEYH/ymZ7HsLoKZCf
X-Google-Smtp-Source: AGHT+IGuUR2vzGqkL/TzgPl8jaB8EOstVjkT+LTcv1PCIakTLYRMNPUMBC9mdDC1N1iRzB/jTi1B5A==
X-Received: by 2002:a05:6808:13c1:b0:3d9:245c:4209 with SMTP id 5614622812f47-3db55832717mr12079411b6e.40.1722825210642;
        Sun, 04 Aug 2024 19:33:30 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70a31ec82d6sm2752878a34.47.2024.08.04.19.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 19:33:30 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	inochiama@outlook.com,
	conor.dooley@microchip.com,
	guoren@kernel.org,
	emil.renner.berthing@canonical.com,
	apatel@ventanamicro.com,
	hal.feng@starfivetech.com,
	dfustini@baylibre.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH] riscv: defconfig: sophgo: enable clks for sg2042
Date: Mon,  5 Aug 2024 10:33:20 +0800
Message-Id: <20240805023320.1287061-1-unicornxw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Enable clk generators for sg2042 due to many peripherals rely on
these clocks.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 0d678325444f..d43a028909e5 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -249,6 +249,9 @@ CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_CLK_SOPHGO_CV1800=y
+CONFIG_CLK_SOPHGO_SG2042_PLL=y
+CONFIG_CLK_SOPHGO_SG2042_CLKGEN=y
+CONFIG_CLK_SOPHGO_SG2042_RPGATE=y
 CONFIG_SUN8I_DE2_CCU=m
 CONFIG_RENESAS_OSTM=y
 CONFIG_SUN50I_IOMMU=y

base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
-- 
2.34.1


