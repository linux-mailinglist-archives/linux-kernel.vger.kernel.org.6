Return-Path: <linux-kernel+bounces-269230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE73B942F87
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7505B2852AA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EEE1B1505;
	Wed, 31 Jul 2024 12:57:23 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619701B1423;
	Wed, 31 Jul 2024 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430642; cv=none; b=UE6WhsP6rJ6T5pHFQXtQudWp7hdIXk3MtOkA/gsPe1FuneIGdP6/XR3SEZ3RqDzqcoGbwMDjZwtlvXjzEFWbMXRF3g80thVNHES3A4B4JmpYE16k6WEX5TevFz8Kd8zvrrnNC5p7szdcmRXTb8s4RbDoykv2057oCxJxiNC7ONU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430642; c=relaxed/simple;
	bh=+Ich+i88Ajk8gWGCEI+UfMM4Lpr1h3Awv2tyu/m29+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFwqwcONKLLy2pcTs173axX8z8gWT6bOl89Ehv8JraAPdmw6OpQiQiSRjcUUdSHzyBn1H6CiGuXjaMfV4q2t1KbFU8eVMRvsQn9jdZh3DWO2Tnj7CWftmKdqZcB6W5W4jB0oVoZr3w5SrCXMC/+2wlh59fvHYtCG81J/nCXXAA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b7a3b75133so40785196d6.2;
        Wed, 31 Jul 2024 05:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722430640; x=1723035440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HH60pPIigszmi5NT6xUYpEZJEnXe5I5RDClaVzxrNOk=;
        b=oJmkVIOXJniAhDlBINoAXyN4itvBp7g3QXqCqCtfTR6K8jNdpWWzgTQx/Fj6PZYPhM
         Q3hCd+o/CmE2fj0WoDWBfdNWSbYb7KATgB3oXI/Sja8KG+kIX08uHas+zoX8x/oZO5hX
         MvdC5+ttaUkc7v92KKLnu1fKTNuhTUoKAtqsV7mJuBW4B+FJcJZc06q7MnPPeMMk+vUC
         PWQfzV+zwwmUIWYSCQpYVnyQHDUmgL1/4rq23M4i65vE8gp/KjkxCwEVnjF8vieAnGyd
         fm0slE8mDCP/wqNrbgSbY/CcV+UyZC7qLbcQw3aXeoo5Wf7VeNZiaP3d2CW0si5tAfgU
         oueA==
X-Forwarded-Encrypted: i=1; AJvYcCV7IE1AKSP8BIxd4/iuurs00WKX90sZDYY+mnbvadIlivQNRmyUGkXrI8r8+oCtwtc/w4cwK9+hfvBHWRAVmxMu8VyxUd5tIbqhzU1q
X-Gm-Message-State: AOJu0YzPk7J8CPf6Nm7SM+i1yZuAQ+GwzJqiLREx3UOzl+AhOirucMj9
	AjKAumWWGTeumYEgQgeOwSusgHYT7TtBVloHsKNryi9F+3BUMtdanOlTXpfy0vM=
X-Google-Smtp-Source: AGHT+IFY63PsDshIgYxQeoWEgGzy3bTrB04am7xVVHGqHOwT0MgQryeOj1gZ9kiV80HxtDTFEM/8mg==
X-Received: by 2002:a05:6214:ac3:b0:6b5:238:2e42 with SMTP id 6a1803df08f44-6bb55a83bcbmr226653276d6.40.1722430639815;
        Wed, 31 Jul 2024 05:57:19 -0700 (PDT)
Received: from Skuld-Framework.tail03774.ts.net ([32.221.37.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3faf8f0csm73492276d6.132.2024.07.31.05.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:57:19 -0700 (PDT)
From: Neal Gompa <neal@gompa.dev>
To: rust-for-linux@vger.kernel.org
Cc: asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Janne Grunau <j@jannau.net>,
	Asahi Lina <lina@asahilina.net>,
	Neal Gompa <neal@gompa.dev>
Subject: [PATCH v2] init/Kconfig: Only block on RANDSTRUCT for RUST
Date: Wed, 31 Jul 2024 08:54:28 -0400
Message-ID: <20240731125615.3368813-1-neal@gompa.dev>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When enabling Rust in the kernel, we only need to block on the
RANDSTRUCT feature and GCC plugin. The rest of the GCC plugins
are reasonably safe to enable.

Signed-off-by: Neal Gompa <neal@gompa.dev>
---
Changes in v2
- Drop changing !RANDSTRUCT to RANDSTRUCT_NONE 
  (they're equivalent anyway)
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index a465ea9525bd..0939486938cc 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1900,7 +1900,7 @@ config RUST
 	depends on RUST_IS_AVAILABLE
 	depends on !CFI_CLANG
 	depends on !MODVERSIONS
-	depends on !GCC_PLUGINS
+	depends on !GCC_PLUGIN_RANDSTRUCT
 	depends on !RANDSTRUCT
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
 	help
-- 
2.45.2


