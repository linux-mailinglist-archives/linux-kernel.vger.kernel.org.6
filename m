Return-Path: <linux-kernel+bounces-383313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA879B19FC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 19:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9FFFB21788
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594891D47AC;
	Sat, 26 Oct 2024 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FuRA2eZe"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AE91C1ABC
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729962887; cv=none; b=m7ztWFcaykSTFX6L58kxuSkBOqAk7RggOnE8DUEUyaY0zUVLDjQ0+8UWXS3UQqnPBPUF/OBRjyPDh7tEm3qRf4JwMUd4TegeOjAOLYPCF6DoQXyf26FdF6hla81qwLyQ5UC35GcTePXB0wiajvyGAhe/gT7QtDxHrz/JmaUKhn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729962887; c=relaxed/simple;
	bh=jGEgimkaom91Z9EgZ4/3h2i1m/uy4fd9MoLfYA5LE4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukajBiND3yZRzIBDfJOZ3L0ppo2qY61GqUFHfUqltfRB1cxb2ySbP2C21OHutzOOoQJzAAJgO/zcbUuPC+37KAfxSb6HcEXc5CCtzTl2Lf65wugSKLA40LqKFUvbkCgN/rid+dW4Puogf/683ftCB5jpru3RTJD5T8l/StC7tDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FuRA2eZe; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2e88cb0bbso2301609a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729962885; x=1730567685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgTekunG0cQy0vjVyXRBRATW95KVtugkqgihcshjjxQ=;
        b=FuRA2eZeAuxYCOhxIu6YjUtoCcYLVXiIposMh6pl83WW5vUdkTL/+i8yHAKiXpWnzq
         EhYzoYRge/Fz35kGdcVeiUnCs4nECTZKV8gX9NKhPRiHWe+Ro6oPQL0RE3AenfZWpODS
         MEFBGt6zgI69PTRe+I+zU7PIKNjwwqfa6SqAcJEJM76MrLyWSM+gkKmugFfD4SY5XWHw
         RtxL+DIjN8pHeeMBc8U0SUZOsUiREEnfy4gAoC9Mvw572R2ObXiU0m9MzxQmIGVmiPd6
         YE7k/6cdi4D6LPzxhfgvMqUl5NOPUonnBIuBzSIww5tWStUJ7btdoLRMbyMRRKe2ok/z
         LoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729962885; x=1730567685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgTekunG0cQy0vjVyXRBRATW95KVtugkqgihcshjjxQ=;
        b=TivL0GSeWJcghNdfNBdSYHxXBMArnSd5KtMqcPiXNxYVJxWGzbjSyI4ahpP9evywqL
         p0JNMJfB1gVYuPxJUXBoA0xcmMv6x8qQC2W2sj3ENDrphFFT5KvicgBEsFQagIBxJriD
         8Ty88aE1SqsuyGWIU5yxtKrREl0+gPM/Esh/qYhVFXPoyqjb2vXxtC87I7m+WlUfLfXR
         Eh17pDVn69IzwhfZnoqKKsToTQDVDgZ12j2ItBMWZeXv8TPYrcrT0KB3fWOX3IDewyCm
         XZ5SYiLGzxrT8kP9hZnrJikW9Am6h14MyIlydVhAc9uYUgDelhUnCvGr/fXRlGZo6E+s
         yR+w==
X-Forwarded-Encrypted: i=1; AJvYcCVNk+JrmnOShJPTRteqp6zUG63gTw1QXeMrwvi4u4WgamDtztUYrV3JLYjGbrPPBb4cMvHj0T2qqlrsezI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfixDCBm0jQetF/l53o9Bfgds5afNFq8z01IiQLoLElj7iofaJ
	XdvMrx1irXDqWl8cd4Howund30lxMk/Z/91pz79nSlzYvBjpyseAMn2YWfeYKpQ=
X-Google-Smtp-Source: AGHT+IHMFAwANT/EZuDl4La1BmNjmSNtM9o3wF8CMwHklFBsWwrPxYwZlipAsFiUTL+gnWOt/QYKpg==
X-Received: by 2002:a17:90a:b111:b0:2e2:d16e:8769 with SMTP id 98e67ed59e1d1-2e8f106926emr4001679a91.15.1729962885304;
        Sat, 26 Oct 2024 10:14:45 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e558114sm5663762a91.36.2024.10.26.10.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 10:14:44 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 1/6] riscv: Remove duplicate CONFIG_PAGE_OFFSET definition
Date: Sat, 26 Oct 2024 10:13:53 -0700
Message-ID: <20241026171441.3047904-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241026171441.3047904-1-samuel.holland@sifive.com>
References: <20241026171441.3047904-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This definition is already provided by include/generated/autoconf.h,
so it does not need to be provided on the command line.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index d469db9f46f4..6ff2cbde5296 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -92,7 +92,6 @@ KBUILD_AFLAGS += -march=$(riscv-march-y)
 CC_FLAGS_FPU  := -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)([^v_]*)v?/\1\2/')
 
 KBUILD_CFLAGS += -mno-save-restore
-KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
 
 ifeq ($(CONFIG_CMODEL_MEDLOW),y)
 	KBUILD_CFLAGS += -mcmodel=medlow
-- 
2.45.1


