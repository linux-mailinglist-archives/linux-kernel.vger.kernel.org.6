Return-Path: <linux-kernel+bounces-319259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C89F96F9CB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AA81C22579
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD66A1D31B9;
	Fri,  6 Sep 2024 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X30AxL6r"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6F54648
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642918; cv=none; b=LfwDMML9YNlPV6gvlcn5cidIKNhkcIUlPDcwP4f0qKu4Aqs/DWFUpnsOLnOXpSV6oDgxVu8Y9UMTFMmcO4h1yCW9kcTcNY3Y+BAwWYdXRDVmRhw2XVzGVwh11SPRkhnstw9HTsaK8VW5UhAhtelGfrHwFkiBoQLLfB3fR284BpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642918; c=relaxed/simple;
	bh=Jmls5nUdyMOsBAiBg7TTSU9JfIxxrNVlDj4mecc/yoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BILsqD+FP+xpJFPNSXcOtGmI5MQQUhi8lvx9hmmTHgBIrB4HuYbbOPdJzdLuxvwrNpGhOTQdILXLTX4B//3C3ArDKrXbSX4VrB9L52IvIXABIFq29xhe7peZJ0CGwSF26TPtTyLNjOXFnPo/PXf4A9XxIP9ZY/GQ5qo19raTDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X30AxL6r; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d877e9054eso1633175a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725642916; x=1726247716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SaVByIt9eCypiDOxTfs1PccVcQTRV63Fz457LfGw/wY=;
        b=X30AxL6rJ1jReNplaCyzz38cxC1HF1IvEAUWFSXvHOStki7+jzb/dakt2PChACLZBC
         ySo2yfuMDr4EgMqPPhuvT9Dmg6oeTMp2lhnJ0WnuGPudjnkNOW63ILMVNFKv7MueNhVm
         cKREya6KGx+k0U0NIODKYjbYj+5I1/DwcxPrKnSVgpETKDY/SlSR/DxqSvt6TaIe1n05
         x+jc9QbYzzm1RAseWkZZTXo93FmZsUC3JQw9cWreGe2H9+9o11pyz/veVmAB4Hm4LH+D
         62jjWwq/zYgZhTzbO7R7fbyXkgSPujhXNYV0bS/thEyWX2Oy90aSJfMIVII3dv+GlzoD
         HsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725642916; x=1726247716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaVByIt9eCypiDOxTfs1PccVcQTRV63Fz457LfGw/wY=;
        b=aCEneP/3N/Yv5IWo+hl8u8hmWwlrOzqX2TXq65rqZGoX81A+I9DoGqNvKp6+nkrg05
         nwXpOLXgN97L+1MMPiMr/Q8zfpPnDrnIGb/Z2y5851U03IrxCk01b6hro1zTfdbRt/wi
         vXev/e7pc/W98PMODD8y5/Kjbe7FHi5vpOND0jZ+5/Ei6++j3KfUwKbRnN8dLxbv6D1+
         wQy6+ladHSPTCiyxfaQpQO7aUyn+UjGwLSwW2+JFHRWL1Waj+v4CakZINANbmP90oW7l
         WEjvQxL/fbveWmweleVTJEW9i9aFiMzAUwSPVMSlnQvbxAOciLAbEjd5JVS7v76FQJtf
         zw4w==
X-Forwarded-Encrypted: i=1; AJvYcCW6j0wqBv/sRbaynG/Sgui568cH3NVkgeCUJRaZfP0rDvJmOpapNuFg+bS/dxYPT8i5hMGfK+t35R0mnMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG2Ez6KbkmBEY/T8T7nthwmU240h7yxLv0wQrlcOi/Nay3jirg
	MX5jXmAOE9T7GX0/4/vMoexcYXyp/17qZi54LQVSgn2FjUSP9a7K
X-Google-Smtp-Source: AGHT+IFBQV45Sa0tIy43N8zFjBdNAf25uRTNT11vv0asg76rfVvFBpgpxA3E1uE3Z4F+20X1KKpO2g==
X-Received: by 2002:a17:90a:be10:b0:2d8:e3f3:fd66 with SMTP id 98e67ed59e1d1-2d8e3f3ff0fmr19353405a91.34.1725642915887;
        Fri, 06 Sep 2024 10:15:15 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2dadc10fa99sm1841519a91.39.2024.09.06.10.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 10:15:15 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: asahi@lists.linux.dev,
	~postmarketos/upstreaming@lists.sr.ht,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH RESEND 0/2] Disable 32-bit EL0 for Apple A10(X), T2
Date: Sat,  7 Sep 2024 01:13:23 +0800
Message-ID: <20240906171449.324354-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resending as the cc list was messed up.

Hi,

Apple's A10(X), T2 SoCs consists of pairs of performance and efficiency
cores. However, only one of the core types may be active at a given time,
and to software, it appears as logical cores that could switch between
P-mode and E-mode, depending on the p-state.

Unforunately, only the performance cores can execute 32-bit EL0. To
software, this results in logical cores that lose ability to execute
32-bit EL0 when the p-state is below a certain value.

Since these CPU cores only supported 16K pages, many AArch32
executables will not run anyways. This series disables 32-bit EL0 for
these SoCs.

Nick Chan

---

Nick Chan (2):
  arm64: cputype: Add CPU types for A7-A11, T2 SoCs
  arm64: cpufeature: Pretend that Apple A10(X), T2 does not support
    32-bit EL0

 arch/arm64/include/asm/cputype.h | 42 +++++++++++++++++++++++---------
 arch/arm64/kernel/cpufeature.c   | 25 +++++++++++++++++++
 2 files changed, 55 insertions(+), 12 deletions(-)


base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
-- 
2.46.0


