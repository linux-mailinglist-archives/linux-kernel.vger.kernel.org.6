Return-Path: <linux-kernel+bounces-310278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3172967756
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683A21F200E7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B645C183CD7;
	Sun,  1 Sep 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgkoi5CB"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FA62AE69;
	Sun,  1 Sep 2024 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725206332; cv=none; b=YrjUE2ekBva0TwUhHiJrtku+QNF+yHNEwGUiguE4GvmtGpVmFWp4wwgTqh3PQI8vKvs5k9G6yzBIoCoKpnsrLA3vMsrWcrSFT4mEybJucngWFIIwLVpLqLB0BMGQj8S84plYTr/kd/pHyrS/SMgYCelrWobESgJzd4jBamo+6uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725206332; c=relaxed/simple;
	bh=Fd0bb3YMgevpo+aFHgL9hPue0EfkpePLJPpVGruGSMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=L5TN9pXxU2Gg1AoPDqcOw1UbnLz0V1teNAfhBSa4uQid0LcMDUPIHcdPsFKKKrUFEq8zkGHCmd4EnJZ4WOmfjqxq1CmyoiwiIiBe3A8PoAvCnEOmF9l6p5Xxbp4SyJNnTK+MkFZUuWA+Q/jYp5PGK0Xq1Y2ngbnxer6yOpo5Xvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fgkoi5CB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c255e3c327so381996a12.1;
        Sun, 01 Sep 2024 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725206329; x=1725811129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ix5Lt4pX5BzybSP7o0NR7nn740Ac2JLNvIgvnvkwPSo=;
        b=Fgkoi5CBfqFs+oanSsBmbJcrOKI9EINu5Soi+lnLg463bPUbXwoe/1hPKWYxfycasE
         IyOn+jGBT8LBtZGoHma5gkLXv2nJK+BJR3/forh5EcywfgMGJVMvssj6U/L4Fz31o+3r
         UblyZ/agibgesBeElTkDOf/lH09VxtZ/VX/8CDeyuyL+EQthDUHo1kZt6dkutaa28rHF
         KFCq5mNZFXfl43MRwAP5VgqhwNDoaH7FkQLMv10qJT7Sl6RCTBz46jOGXl9VKHtOBrag
         ZCJ57CgdU55eDNrzZBLfOtqmGyO/na1nnQyzxin/xUXMsMuLlOJgYkTSBOCUJZOKkqDI
         a07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725206329; x=1725811129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ix5Lt4pX5BzybSP7o0NR7nn740Ac2JLNvIgvnvkwPSo=;
        b=McpuZ/3vqSN8wfEzaz761jdMiRhZIzmlLYpa40bIbJAY6WkbGygIqCcvK0U6ZhnKWb
         hitIbGZ00qmVXwNGDvtSw5oMfiewRJjSnxrMjAeKt7T49DyZMqIzxRnosNrCxqotUGPG
         q+IHyTakOS6ArRvUMH2pmdDNkjcWyE/Co4/qVmJx5VtrR73DoiENeM26nH4dsZFfbXvK
         R6lvNE8BrAXhYIEjXNueGfklhPHPlrSEzDHF1FBMcjIQIwWUQiimCqqV5Jj/qGTNaSGE
         EHQPPjooSZwo82hPmyvyZlXhjSENHHXsysvqfAempCfsV2kNbFfd2OCHJ5j6SHU3Md0L
         mtSg==
X-Forwarded-Encrypted: i=1; AJvYcCVN2QGyCrN/iglT0ifRFsRc6hTz0pWOKCd5QtkYLBdX9rWZkm2bTlHR4/2lbRZ9Lw2d0tWEarnsHlnAy+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnMtseDMdVsxXteuyplViFDhYELz41YV7OJ5HUiqD6l0kk2AmW
	B4d7YclY5HwbYdVuxTrcAEM6XMPtl0+HU0rF6ULU7s2gCJHqXrfh
X-Google-Smtp-Source: AGHT+IHzgrO8NU44+fJNcWnq66TFNrhLOjVWgk9tgTrJy3nNrgGeA8GYKexNqTa4lGy/w9c2kViNNw==
X-Received: by 2002:a05:6402:42cb:b0:5c2:5cc8:b1 with SMTP id 4fb4d7f45d1cf-5c25cc803c1mr752921a12.7.1725206328654;
        Sun, 01 Sep 2024 08:58:48 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ce96ddsm4144760a12.94.2024.09.01.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 08:58:48 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] m68k: remove trailing space after \n newline
Date: Sun,  1 Sep 2024 16:58:46 +0100
Message-Id: <20240901155846.142816-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a extraneous space after a newline in a pr_debug message.
Remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/m68k/kernel/setup_no.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
index 37fb663559b4..c926da9d5ec2 100644
--- a/arch/m68k/kernel/setup_no.c
+++ b/arch/m68k/kernel/setup_no.c
@@ -138,7 +138,7 @@ void __init setup_arch(char **cmdline_p)
 
 	pr_debug("KERNEL -> TEXT=0x%p-0x%p DATA=0x%p-0x%p BSS=0x%p-0x%p\n",
 		 _stext, _etext, _sdata, _edata, __bss_start, __bss_stop);
-	pr_debug("MEMORY -> ROMFS=0x%p-0x%06lx MEM=0x%06lx-0x%06lx\n ",
+	pr_debug("MEMORY -> ROMFS=0x%p-0x%06lx MEM=0x%06lx-0x%06lx\n",
 		 __bss_stop, memory_start, memory_start, memory_end);
 
 	memblock_add(_rambase, memory_end - _rambase);
-- 
2.39.2


