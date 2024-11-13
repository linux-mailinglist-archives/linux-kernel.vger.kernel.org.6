Return-Path: <linux-kernel+bounces-408181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB929C7B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3210D289578
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA8F201113;
	Wed, 13 Nov 2024 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="NneQw3HL"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF02139CE3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523584; cv=none; b=LzgmZmDHMOXY0pLaiiSBNXTDRhvmOhvYUjN8KsgRMXroedlFz0252Co8zMlWAE9TZc/8qqDPmVlD1NplSs1CSwHYz2d7cU6/aC4IvVGusp8er/cjbidQftp1Xm27ifEeUOOWWnON+wWceAZEyayC95gHty6K63ocA/Pk4GHJjUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523584; c=relaxed/simple;
	bh=bGRyQ2vGNhl3HokNYuwh+4RnXzSMPc7neUjhwD6czxA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=l1Ez9P1QcckfHoiTW5v8kD5RC84xkpttCbeLa6aVCf6vNVLh4ntSixLJpnMKqAOpPBnKVkDpfGO6Smv09NN80TfvduU48H79VA8k3Q7ecktz6NxbFmQ33MSPjQixu+Cqhk4Sr47GfXWunBfDTHG6jqdSDb9ENMVDElqRH9i4l4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=NneQw3HL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e31af47681so5845198a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1731523582; x=1732128382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=D2wRdlsSBS9ax/d+B0UE5nbV3Jw/KYd+JIEXiRB5bbc=;
        b=NneQw3HLfn2PJwaVOEAZit5DRArOTgdLFn4MFopxk+Up+kK5J/Px80aQmH9q3PMB91
         Y1+KZ0j3fUbruuTDfVCygdQVKOFwc4yOzVrlLcQoE21umlvLxTs20iI3IYfDfv+Vpznm
         X1Vo813P+e+fR7uIXGU/p5ejnRqqJ4O9E6R7vRfxHhP2iTSH5MMkeW8ZU+snf8m4JRRL
         0319UkEwz7fOBdDbILf3eqkBONVAVdsNMB7DtJTwwR0/3QuoU7jINaOTHEJoNb6X0T8Z
         CYPFYP/ZyETHiYvy2zuKD5B9qMktX3YyAsWieJy8gzipCmhdiX4Q1cMvv9QKNWXLt8aF
         taWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523582; x=1732128382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2wRdlsSBS9ax/d+B0UE5nbV3Jw/KYd+JIEXiRB5bbc=;
        b=GQ36CoRut6wMRIKe5DzOtggCgc9bPguibLfKVZYiJ5v4AWvZ44BkPi4klvYBVe1Zv1
         RIx+PHTCE2BDamzSTF8tRyYJqhXRyxVCVy7+ds4DxjecYkaghODtI8tXtV+NDkInarbY
         ELBlDNTAH83jHDkvYCV9Mz2DPjSZKPPC3Mb8zao/YqMdIuu7YgYsJbV2tbqGqHnrmHHa
         xhKsm+QpWHsOSFNMA7xhata5zwrH0UoHM4qz11Hi+yAArolGEDmDLtPY1+jo1GgpHdTi
         2bU1gTbYq9S6c7/ByE+uHajh7K8VDlUjkF0ho3jw1xu/jEwX/pK0L9z7skZQ/rcdVzib
         iq9g==
X-Forwarded-Encrypted: i=1; AJvYcCXVlT6LBfWLFloiw8uMxFBSca1k/D3M2k7/nCINf2r8Ue2GPCOVmMtCFEeFCS6Ie8BmQNMEYhD6c9FdDj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1rX3p4/HyPBFYCG8TJQqDi0U6n3sr53c9N5vddORqUl2Iwyb
	hFktwkYPu7XITSP2HXljpRTfMXWA3bwwpJmlJ+ZNDiTye7OJvRvBi0tf+cB/bYM=
X-Google-Smtp-Source: AGHT+IEM1ntvA2Qe+V8GoBpVy79jkXEU0zzfmfqm6KOiW0FHYVA02IKJ/bQKTkVVun17yjdiIv6XBw==
X-Received: by 2002:a17:90b:1d4c:b0:2e2:b6ef:1611 with SMTP id 98e67ed59e1d1-2e9f2c90340mr4604165a91.18.1731523582686;
        Wed, 13 Nov 2024 10:46:22 -0800 (PST)
Received: from x1.tailc1103.ts.net (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3ef3521sm1777869a91.32.2024.11.13.10.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:46:22 -0800 (PST)
From: Drew Fustini <drew@pdp7.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Drew Fustini <drew@pdp7.com>,
	Guo Ren <guoren@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: defconfig: enable pinctrl and dwmac support for TH1520
Date: Wed, 13 Nov 2024 10:43:36 -0800
Message-Id: <20241113184333.829716-1-drew@pdp7.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable pinctrl and ethernet dwmac driver for the TH1520 SoC boards like
the BeagleV Ahead and the Sipeed LicheePi 4A.

Signed-off-by: Drew Fustini <drew@pdp7.com>
---
Changes in v2:
 - Switch CONFIG_DWMAC_THEAD from built-in to module


 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index b4a37345703e..d26e670404b6 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -167,6 +167,7 @@ CONFIG_PINCTRL_SOPHGO_CV1800B=y
 CONFIG_PINCTRL_SOPHGO_CV1812H=y
 CONFIG_PINCTRL_SOPHGO_SG2000=y
 CONFIG_PINCTRL_SOPHGO_SG2002=y
+CONFIG_PINCTRL_TH1520=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_SIFIVE=y
 CONFIG_POWER_RESET_GPIO_RESTART=y
@@ -242,6 +243,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
+CONFIG_DWMAC_THEAD=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
-- 
2.34.1


