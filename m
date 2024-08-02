Return-Path: <linux-kernel+bounces-272013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264CE9455E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 03:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D832843CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B761C2A3;
	Fri,  2 Aug 2024 01:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j20ltIcB"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318BA134AB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722560980; cv=none; b=XtNUMUOVt4MdT2JmrIvyvYiyt7yXpyULKPorZCNZSccw1oQqLpWTGpC/F/ZS60Dn+4NLsYgy+Phjgt7y3gUENmDBQCF61D3a1hX4B8ey+LS/2/vG2xBek3dFpBHZolQcE8RTjmbKeW3qgpOOg1irh5GekrW2HUZJ3IdnexGtS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722560980; c=relaxed/simple;
	bh=maHef5ggs1ts45wIzJE7VDz5VzmJJUpzw7iq/Ex4uNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sP+SCno5I86Z9IVf2qUSfur8ZJN8KEllUcAze5wd61NqqBGSAMbdqlOrJ0vKe+h1x9usaBCUTZvQUCdlHswFFeUw08V6NEQYT+zQWKUn8ZM2RYFrtQ5lDepKWP3hlJzLwSSeksS58aZMXXJeS1vlR6ZjjeNTaV9ivHAoWrQb5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j20ltIcB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5afa207b8bfso7997641a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 18:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722560977; x=1723165777; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+JPYPQt1yTaGk3WXPjbRRDMHWDKLDoRYgnwrc901qQ=;
        b=j20ltIcBaafy8fNl/9fU0m9Z2ib9c1XAR0m7BRf7zRaqttUrVrIz0vYlZcEimpuiYO
         4qp0ML7kFNu+flAvbA6p7+2BIemzB/dImtWa+50p1Ehx7Ro7VgpiAlv0pxHRlurQCNz9
         kTlcCV4AreLf1PngUA/0pK6bqOVGzrHl/kJ8CIGF9LjuaX1eqfA7piRrq/T2fe5id/WW
         mJxvEzY5NtgDrQAFCGdezsizURL/aep7F2Gy8Yqu0k9CM/t1olicp1J9W73FqKjX2Oq/
         U8YMts0hi03uhAOdQYeP4wqEfDySjWk1UBCzp5HydVM87xr+SXK1mP4DnHyF2HWZ7hsq
         dd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722560977; x=1723165777;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+JPYPQt1yTaGk3WXPjbRRDMHWDKLDoRYgnwrc901qQ=;
        b=vMi9Z1u7wKwHFJIIGfFbC8GtOE5YznaGMV+2AaRcB9BL8pevqzXzO0ZNE1y5LR7z4d
         /wEUTUh5ymDwmvWEa8zTNrhgAkQPrhrinqTLUUJ9ENa7itLeE1NE/ZeoTHCN4UoAoh9z
         ybUPTgSx/mgO+qPLEutB9IrZM9yidHFlhrtSWH3tInZhuO/FgLXGbVfU3lXcDVu/jYCc
         K/GbMPgEhSGJdyzvxb4qiv/5FwVXBCt2EeQ9qpIfqlRS+25Ipzxj9LVLLLoczN01eKwj
         94oH+JQzoLOe+IHNBc06Rm9SSuTQ9n350iDO2JbpO08B3+GxxpihHm/gkga1WflNFwEA
         eYJw==
X-Gm-Message-State: AOJu0Yzd/Gr0EiytwC6APdU3i7ppDLl2uaXUrg/4GL/EIVV+nYz1BNLk
	74t6ivkuQkGzeFGLXEtM+x7WHtFFa2sosjnQKQ/iuv/cI+7Vw2kI
X-Google-Smtp-Source: AGHT+IHH9gnl3KVlZJuaWCLeBUtTiHBLMppMhdSgZyiqE3c4pDFS+dgOTRi8caOWBu6UptY9DHlNxQ==
X-Received: by 2002:aa7:d604:0:b0:5a3:76e3:1dc with SMTP id 4fb4d7f45d1cf-5b7f39e043bmr1346910a12.10.1722560977346;
        Thu, 01 Aug 2024 18:09:37 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839c2a61csm406639a12.36.2024.08.01.18.09.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2024 18:09:36 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 4/5] memblock test: fix implicit declaration of function 'isspace'
Date: Fri,  2 Aug 2024 01:09:22 +0000
Message-Id: <20240802010923.15577-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240802010923.15577-1-richard.weiyang@gmail.com>
References: <20240802010923.15577-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 1e4c64b71c9b ("mm/memblock: Add "reserve_mem" to reserved named
memory at boot up") introduce usage of isspace().

Let's include <linux/ctype.h> in kernel.h to fix this.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v2: include ctype.h in kernel.h
---
 tools/testing/memblock/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/memblock/linux/kernel.h b/tools/testing/memblock/linux/kernel.h
index c16d9cd2d1ae..4d1012d5be6e 100644
--- a/tools/testing/memblock/linux/kernel.h
+++ b/tools/testing/memblock/linux/kernel.h
@@ -9,5 +9,6 @@
 #include <linux/linkage.h>
 #include <linux/kconfig.h>
 #include <linux/string.h>
+#include <linux/ctype.h>
 
 #endif
-- 
2.34.1


