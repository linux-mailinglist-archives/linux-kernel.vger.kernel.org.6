Return-Path: <linux-kernel+bounces-220643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274E790E4DC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCBD1C21E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B190F78289;
	Wed, 19 Jun 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WbA6xlFu"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F2770FE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783384; cv=none; b=rcnK+3KSxar10uJN9OlUh/RA3mZ2I0yNDZKU1b3A9YgOLHkncOgb2/W6QoQhpQiSpEXlowQUTWOcz8Mxi2/84kfySK9qERRSB7umbL4shqqfLWPuk7Y2nW6bGO22dLg1TTJQYAY3VT1QhlcG7m9jg06bvUrV3cbwOWI7rd90atw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783384; c=relaxed/simple;
	bh=P8Y0ZBoHD6UGUARlqOcqgiQJDH5yOvLxRyqtOGlIIfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYUt+xt4RMEnXVhDTzp3VYkgggPPM4TMNDWT7OM9FGQo+NFNnvzlqG+QrYukqcS63fD+ir+OpAQE0TgqHVMfCd6qsk+jrM9wud0HYz5H3HmRIkobe8/K2J1fhfhTGA4c+U/58dOtdTQQOEJSiA/Gi9amYPRfx+AkDBVrsRlXLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WbA6xlFu; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EAA003F66F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718783379;
	bh=THUI5NvIeZrnSRinnC10PYx0agCfUTpnm+UcAy2EO1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=WbA6xlFuxJfQ8av03EvaYOAYzOYfMVgxUPEviFMIOMyhZmC5XvcgFtUKmOg8YbjSD
	 a+QIs06WWgkkCe/yp30iQFj9NOkOLJbtkJcE+nzxYlBGmkvib1wKcHAECtGSNvur/s
	 3kOpCNKvaQTeUurhEnCjXiLABy36RcI/AWMxq512Jd24+nrNWBmrs30X+RLhDEzitj
	 PYx686625xVFWfMnikhjOuF5ZYciVnMygEXAS+1HiUnWcKFEtM1sYQBE3pWB9TiUgA
	 62xItkPWgCWb8wVafJp+8K0FlrhgsyUDWt2hozhb/KY1EeuECIIHnp0glMDsw/tqjZ
	 VxZzNb7LheV3A==
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6fa16525999so7482131a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 00:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718783378; x=1719388178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THUI5NvIeZrnSRinnC10PYx0agCfUTpnm+UcAy2EO1o=;
        b=MB868qitx3rjJB1w1aEvz4Ol3Ykxgp2FrRXieqSbVRN6IQAuScMXiacV1LTIZyYNBS
         xpkwnDs8AV/XfrEr7pFyIzvpPE8jcnfp0Y5mufqt0Y3YxFOX9kFFgBXVVTpKYNTaGA4F
         wXJnVyTV16pIFjov8NwLdQY8nKiphU5UMU8zuCad13zZfnFJHK4L9go+4v8y/LEhkMZL
         ezr0Qlr6Q9R9BrvosWFmaWU6sfnH3VpoA1lWfbY5JnOX965t46kzghvNkNPr7DVej4S3
         ymghhQTbyWDoHsGJ5jS3UEFm9uecOd0CwR9OdizbmXBvHk9TXEJp/euuUDoekpxfQFjQ
         jDZA==
X-Forwarded-Encrypted: i=1; AJvYcCUdlop/hTvr/Jaqg4BnVeBqkO5x14PscP4H3PuwH+N4pOHnne2Ft1C7LMLZOMI5/4rMAkScWIh6DpvvVf+60sbpYW+W34wDwqw946rl
X-Gm-Message-State: AOJu0YzSG19+usToxCN+VSR/X5bOPguhFA5d4EnFjQZgspExKzvxs8MU
	7aJlGWFITFCpIDFfOX/PNXogcghMK1Zzz4eubTmm27+gE3C4I+l/5S9EHjI4/LQluBZPDASEpUe
	+qDp6aPcIkexOgICt+BP5GdreWqjIhMXkgZgZhtslUm4KrCs4Nfda6VXsSDevRwyYrMduyL3v1s
	WZUA==
X-Received: by 2002:a05:6808:1911:b0:3d5:108a:5ae6 with SMTP id 5614622812f47-3d51b96722amr2358284b6e.9.1718783377909;
        Wed, 19 Jun 2024 00:49:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvqqwOkWAVcy2DXi/y2o9V8ky7bncsfLdc9P9N+pDGm8XKr790lPV7PrpkM+U9Sq9PZxDzUQ==
X-Received: by 2002:a05:6808:1911:b0:3d5:108a:5ae6 with SMTP id 5614622812f47-3d51b96722amr2358275b6e.9.1718783377588;
        Wed, 19 Jun 2024 00:49:37 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3cdc6sm10076908b3a.138.2024.06.19.00.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:49:37 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] scripts/gdb: rework module VA range
Date: Wed, 19 Jun 2024 15:49:07 +0800
Message-Id: <20240619074911.100434-3-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619074911.100434-1-kuan-ying.lee@canonical.com>
References: <20240619074911.100434-1-kuan-ying.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After we enlarge the module VA range, we also change the module VA
range in gdb scripts.

Fixes: 3e35d303ab7d ("arm64: module: rework module VA range selection")
Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 scripts/gdb/linux/mm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
index 30738f174fe2..e0461248abe2 100644
--- a/scripts/gdb/linux/mm.py
+++ b/scripts/gdb/linux/mm.py
@@ -33,7 +33,7 @@ class aarch64_page_ops():
     def __init__(self):
         self.SUBSECTION_SHIFT = 21
         self.SEBSECTION_SIZE = 1 << self.SUBSECTION_SHIFT
-        self.MODULES_VSIZE = 128 * 1024 * 1024
+        self.MODULES_VSIZE = 2 * 1024 * 1024 * 1024
 
         if constants.LX_CONFIG_ARM64_64K_PAGES:
             self.SECTION_SIZE_BITS = 29
-- 
2.34.1


