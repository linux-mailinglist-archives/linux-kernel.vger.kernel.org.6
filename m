Return-Path: <linux-kernel+bounces-566523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 865C6A67946
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD57019C8143
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A46211481;
	Tue, 18 Mar 2025 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhtqjT4e"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4F17A2E0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314951; cv=none; b=a0/Qa/uP4HYtCmgMCavuZFFbdhqf0rVBpcF6VninQoH/J1RdgM6CkfNLHL8opvRqv77280rs7ZsMq8dZYCwQ7qB0K9tF9Xee76vB0xtN/wtBBkNRhzxKXN3atwUhnoR9NeLSZyrZauT8rOzmZaXOHhSpIWVFB4qL3dWG2IMLQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314951; c=relaxed/simple;
	bh=66bm41lhhS3nn8MZ9iHzR0XXqD7b7ryKbgSpas+K5+E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OWmgCWKw578k3DaT85vUnvVT1un2RyaDaB0wsfD0UGZu1dDE5iqFjvIJS/4oWfAjhUVW+JnMJWK4UJCZMJtyrippmevxBYn1fGU4P/pFr81ebIWnO+I5aY4pIVM9ESNxx8HyxgchymMe4ShxlbObcXpECVWdjSdaDvfJnPEMkoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JhtqjT4e; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so3581923f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742314944; x=1742919744; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IS58nPgz/vhhwTrnHBcU78ZbfsRgzftJFesloBEwajk=;
        b=JhtqjT4eTZHFLpHSn8hVhtX2DQvcODnY1l+aA9uqjbpZXCiKCritLLYTXd9tJ0fUeK
         wcCW150N8QpJygoxv0+E6rxHWtM4+UiIGXwGEDGUfuWcw1K90rZ88vQVaRkoxhtgqeSA
         ikXlCQ4/XoacQL90TbU5YY0FS/KMG9gwNOdqmZNldsHW/B2n9KOM9ng2TgwjNozFWbHA
         5kM2IRDULu+kFZaVuvLB09NGe8O4FFLjdd3gYTktgUcLEXtiNrpeHF7IyexDJfN4bBKt
         mLidF9SBHrXBHG2ruA45kEikSSw0ex4FsZCxxAGj28MLJiSbANPs0MQWAgfM6auN/mf/
         pskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314944; x=1742919744;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IS58nPgz/vhhwTrnHBcU78ZbfsRgzftJFesloBEwajk=;
        b=jJxYgkro1GC9yvR6O7Y3Tk3OOZpj4DpwiJYQEnlyCpu58rCQp5fnPf5oym9R5fybuu
         CuznRRA4TU7LqxjYVh3XCBtm1UNFur2gmyu0pSMK6yqiwm6ZEtY8jRIJ59xSZy7ZxDGP
         yNgnO21PIHO7RntoHYsXEvmKS5iakkDCk1ED6E13q++iApX6r74w+kr3S/EQZgl/3OH3
         CMf3cxOD4WSW2bdvAgRjxGGLgu/kaAEo6IMlg76MKztIZlv3E0x6pEEa9z8MQOjB5kIB
         AxJAGnRjtD092EZKDvmMy4ZipSaxBO9VV7IocDiVziIMKtn7fyeCJBIdEle1Cl3rMG8C
         2nuA==
X-Forwarded-Encrypted: i=1; AJvYcCWCL083DkTrUtdbguJAgjfcqiPdlw9XC7tD1VSKr3LjpGYB0f3Dx3QZzAi/HfrzHg9/af+7Yev3lvEtlbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvPi7DniIegqT621Wf6CDzumIASFR6ACpigFUTnz68ncalqKs6
	NOeXH0dJ/j62xCh449Wgg+mbohND82TswiwnbxAn0pHHOTU+2mZ01onARRvNXpw=
X-Gm-Gg: ASbGncsUGB0D7dxdlCJCVJiatok35ko6X2UE9oBDHOCrDLiXdykY7RFol8r7QUsDFnY
	TmbMfb79mUrSQa29ZrIHkkmEv6ojpZqljzN6ws885dptSB0pRHGB1LFk8N8cR9UfFFVUvWlFcyI
	mFBacOA6wIdoUjIEEqBs4IVJj+0Y+VJaY47LUdnMTEwn5HURVuqRkc9sYctKpqC+NVA6YNl86dC
	sxknTvM535MW8I31B7saiKfYeeTavay/baZn+ywMl5eU+L9u5dV0FNe2FWJ8/sZfdXqN9EwggCO
	pAnMwBHY+tAW9c5lKKKRFOF4wwDjI9O08tkcpnak+8KSPz0=
X-Google-Smtp-Source: AGHT+IEwJEcXk3dumIi7rBste16wPAh7uoKDuJkycvX07wE3srIa49dtB8OVLWB1K6r6+XwTz4wL1g==
X-Received: by 2002:adf:9b89:0:b0:391:3fa7:bf66 with SMTP id ffacd0b85a97d-3996b46892bmr3310969f8f.31.1742314943988;
        Tue, 18 Mar 2025 09:22:23 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975ae2sm18914732f8f.51.2025.03.18.09.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:22:23 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v2 0/8] coresight: Clear self hosted claim tag on probe
Date: Tue, 18 Mar 2025 16:21:54 +0000
Message-Id: <20250318-james-coresight-claim-tags-v2-0-e9c8a9cde84e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKKd2WcC/0XNQQrCMBCF4auUrJ2SSZuWuvIe4mKok3S0NjIpI
 pTe3aALlz88vreZzCqczbHajPJLsqSlhDtUZpxoiQxyLW2cdd422MONHpxhTMpZ4rTCOJM8YKW
 YgRjbDgMGz9YU4Kkc5P3Fz5fSQVNZTsr0Jx0i2mZofT10fTt4wN9DXVy9n2ZZSFOdNJp9/wDJh
 P2LrQAAAA==
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Suzuki.Poulose@arm.com, 
 leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.14.0

I've gotten stuck a few times with unusable Coresight after a warm boot
due to lingering claim tags, especially when testing the Coresight
panic patchsets.

This change does some tidy ups, adds some debug messages and clears the
self hosted claim tag on probe. The last two commits are unrelated
tidyups but they touch some of the same functions so to avoid extra
conflicts I'm including them here.

This gets as far as fixing the claim tag issue, but there is some other
state not being cleared on probe that results in the following error.
This can be fixed up as a later change:

  coresight tmc_etf0: timeout while waiting for TMC to be Ready
  coresight tmc_etf0: Failed to enable : TMC is not ready

Changes in v2:
 * Revert most of the interface changes, just call
   coresight_clear_self_claim_tag() directly. This is possible because
   we're not doing the read first, so it has fewer knock on effects.
 * Split out the change to add struct cs_access to etm3x
 * Add another warning for racing with external debugger

--
2.34.1

---
James Clark (8):
      coresight: Rename coresight_{set,clear}_claim_tags()
      coresight: Convert tag clear function to take a struct cs_access
      coresight: Only check bottom two claim bits
      coresight: Add claim tag warnings and debug messages
      coresight: etm3x: Convert raw base pointer to struct coresight access
      coresight: Clear self hosted claim tag on probe
      coresight: Remove inlines from static function definitions
      coresight: Remove extern from function declarations

 drivers/hwtracing/coresight/coresight-catu.c       | 12 +--
 drivers/hwtracing/coresight/coresight-core.c       | 85 ++++++++++++++--------
 drivers/hwtracing/coresight/coresight-cti-core.c   |  2 +
 drivers/hwtracing/coresight/coresight-etb10.c      |  4 +-
 drivers/hwtracing/coresight/coresight-etm.h        |  6 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 28 +++----
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  8 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  4 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |  1 +
 drivers/hwtracing/coresight/coresight-platform.c   | 26 +++----
 drivers/hwtracing/coresight/coresight-priv.h       | 20 ++---
 drivers/hwtracing/coresight/coresight-replicator.c |  3 +-
 drivers/hwtracing/coresight/coresight-stm.c        |  6 +-
 .../coresight/coresight-syscfg-configfs.c          |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   |  9 ++-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 16 ++--
 drivers/hwtracing/coresight/coresight-trbe.c       | 18 ++---
 include/linux/coresight.h                          | 40 +++++-----
 19 files changed, 166 insertions(+), 134 deletions(-)
---
base-commit: 5442d22da7dbff3ba8c6720fc6f23ea4934d402d
change-id: 20250317-james-coresight-claim-tags-ae1461f1f5e0

Best regards,
-- 
James Clark <james.clark@linaro.org>


