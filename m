Return-Path: <linux-kernel+bounces-283732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E8994F859
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843AB284C24
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49A194A53;
	Mon, 12 Aug 2024 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqIiw/bD"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB57D194143
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495271; cv=none; b=Wb+ii/ub9CXsv3xLi3k4dG9U6FCoLWZ4Vb3OS+UIa3545/B8n+gJV2YO+d/c245hY7R8YreYwtZXL3ROSDci7lNhtOXmLMGIzPkBMaNGh7zQAmTU9nq/SEi6H4zyM6IpWrsFUeSeW7kWtygTJxW7IK8o3ZpLkFQ7WCWt0aAJKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495271; c=relaxed/simple;
	bh=e4RuxkPU98BkS1X5dHtOt8IxAI09GkTtwErRPfsZxEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvfqTpaHM88ZGprfAe7phFB5DjA0Fou3t9lz7za6Q40CFmWNNBI7Smq6g4W5r08s7le89jvinRcHvKlKHO6SnTSch95KgjNGX7Giv9TVC5iSIrsQ5tIKaAqaY4/LNLhd4N6Nl7V493WND+ed5M9+AzklcruPd52bZ2PKG4iBPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqIiw/bD; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f1870c355cso45558521fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723495268; x=1724100068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s9BCvy8coHdl2CucoLZ3iDhHSVmt1fz4/dGA+lhm9/c=;
        b=gqIiw/bDJQ3Q1iGB0JV7EPqSshfy10xHg6ngGZvAyqSmzvixlC9n1qQA3n9tdwFrwf
         +qFB/ZN0jt9Zcd6NdSCz2hosBnDEY9xV8CmMzc2Ju6fVZVfRmnw0Gb9/nGtYRNOm+q7b
         K9T7Qt0rLKhaIrFEM1OSvCP9mYGwPKLylsOqAIoKHN87IoroiMK8yVnBDlKaTGVmcOn5
         XOsaxOl92TUbk8kH960zt9OEJzUcJHDW88qFaZT/Gg3QsdtzbFbvxf2iwtYyMymjHone
         cggzzAt5SwQAGVj0WT6hBMCroYaEZNppmpqjUUoiBDzfc94XWFgQPVCkDhIplGYZay5c
         G9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495268; x=1724100068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9BCvy8coHdl2CucoLZ3iDhHSVmt1fz4/dGA+lhm9/c=;
        b=XYTt94W9eX+ANXQnhPwLFlCNc17e94ZCwxw6jmi4HM1iQzbEzvQeT5FlPfDyt8L/Hh
         0kHQ4j52bcUtGYQYtBcu3I+14/GSFs8gn5zN3gwqhPcDEqRu4m3HYASbTwttlqtcJAlk
         nzMNfnfQKu/vonMK+JzzVam+n+JiKNllNHHoXF/0+Y01pbQO36zFZSE4HQIIjrU/quwp
         2zOL3gtzxx1aGfSiRXz4EUOAKg0VjH76JMEH+GtvVReWzhxaCtm0NWbA+X+AGZlgqrma
         qI/3qZAMyxwQunMCGW8HIyk+KsCkZyV/C2kXPzUHPCNS9iKcAn+3L+MsevO8q+8RMva9
         /O/w==
X-Forwarded-Encrypted: i=1; AJvYcCVfLlzxaVZ+3XyyTOHSB1xTKdEmox205zlST+H0z6/aI6+LUqzP3wqT+sxL6QAoZWJCAM8aYvAIuf5qykM0Q5Mr/TQo7riE4cMe1YDV
X-Gm-Message-State: AOJu0Ywo94bZIdrLwmd1qqdVkN5xDSlKKlJuzhfdlmKp3Q9gabMy9oa6
	/VScLxc7bJTSSpa7vmJLpA5vAwjMYW36e0G+O3XbvN+Us4GfzUkS
X-Google-Smtp-Source: AGHT+IFMbNCdiOKmGRBle4jaHfW9+scmP4Pt32W41n7UrzXfvEIl6Z2fg4uSFyP3sNrOPK/hbNzrhQ==
X-Received: by 2002:a05:651c:199e:b0:2ef:2016:2637 with SMTP id 38308e7fff4ca-2f2b70c9e22mr12025721fa.0.1723495267491;
        Mon, 12 Aug 2024 13:41:07 -0700 (PDT)
Received: from localhost.localdomain ([46.53.242.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c750379asm113821565e9.10.2024.08.12.13.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 13:41:07 -0700 (PDT)
From: Max Ramanouski <max8rr8@gmail.com>
To: x86@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	jniethe@nvidia.com,
	jhubbard@nvidia.com,
	linux-mm@kvack.org,
	tglx@linutronix.de
Cc: Max Ramanouski <max8rr8@gmail.com>
Subject: [PATCH v2] x86/ioremap: Use is_ioremap_addr() in iounmap()
Date: Mon, 12 Aug 2024 23:35:38 +0300
Message-ID: <20240812203538.82548-1-max8rr8@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems that use HMM (most notably amdgpu driver) high_memory
can jump over VMALLOC_START due to pages at the end of physical
space being added with add_pages(), while gap for new pages left
by KASLR is as small as 10TB. This results in early exit from
iounmap() leading to leaking, and additional problems with rebinding
devices to vfio_pci from other drivers with error of conflicting
memtypes, as memtypes aren't freed in iounmap().

Replace comparison against high_memory with is_ioremap_addr() to
fix the issue and make x86 iounmap() implementation more similar
to generic one, it also uses is_ioremap_addr() to validate pointer.

Fixes: 41e94a851304 ("add devm_memremap_pages")
Signed-off-by: Max Ramanouski <max8rr8@gmail.com>
---
 arch/x86/mm/ioremap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index aa7d27932..464344da4 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/ioremap.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/mmiotrace.h>
@@ -457,7 +458,7 @@ void iounmap(volatile void __iomem *addr)
 {
 	struct vm_struct *p, *o;
 
-	if ((void __force *)addr <= high_memory)
+	if (!is_ioremap_addr(addr))
 		return;
 
 	/*
-- 
2.45.2


