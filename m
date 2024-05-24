Return-Path: <linux-kernel+bounces-189039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E94028CEA38
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D1CB21078
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6190544C94;
	Fri, 24 May 2024 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx8CQpfh"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB04084D
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716578106; cv=none; b=iBONrr5MEpUfuHlzNzRYUnYcvX/6j9JL1D7qVvqHAnRp87hDq8TUq+6CsaliRgHEAkfFwTO3UMYZjCXKdBt809IyArSEDG3F1LUt/HrZOsewarqtKaceysOcnPw0gVi5We4a4f6SUqs8yCgpKmp7QXoh/xGhvK75+PQPyk/YtM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716578106; c=relaxed/simple;
	bh=vTcTJgzaPf7lDXMW5+ZA/HtNiEId3pQN0dsO3z2j0Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RWSbhrPMSBlQ6Bu1I1JpiTK8zHvauTSvAxES7SXhoGRTTn1G1Q8qzcf7S9WrkLT/G7p067zHZT4hgC2j+iyqpwRF1+Kr5Tb+8R7tkIt/YxEMFKsZICNVvQyp442H41dA3qDPiZ9iDLFFFn6pL76kWilvrAon2i2KXYB6jzzyH8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gx8CQpfh; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-67a43b00501so64423a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716578105; x=1717182905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KsduevG5+Aj2PDxaoQ2QBif2xi2LREur8jUJt/lxbn8=;
        b=Gx8CQpfheU6qJYKDsxE2dpPzJoh+lNvsOZgyRCeBHM/PsFczwD/eymjOkHC3xpuXlv
         GwqQ/Nu54Uucmz222A/IGaONOhoz/F4uMQ7mlY39A7+7WCM4Lq8Jy8JVRvESnvZ5CXV3
         h8SdlMmZWVYopMYEJhMn2WBfGxFmEItr18qVsf2zFZlGX2hgt7jJsqAdLxr6zOCL2rFn
         vn5IvwV3JT8B18FYPzn3HmTJdeMGppcT2lsVaNwrLytfXeA10o5o0Qr5bNVSbwKn6POC
         Kbd1dAEp4LNzFkJnMRDi5rWQAQe7l838wMt0oIG77AszkId3ExNvya/a7kaZvABRMszL
         65nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716578105; x=1717182905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsduevG5+Aj2PDxaoQ2QBif2xi2LREur8jUJt/lxbn8=;
        b=bt1HCE5GreRemiK+26jnDBKVlS+9z7XpPXbP+NaWXca3F/l2h6IU3RZTAdRq4SQO6V
         seJ1+lqBE63J8FKlh+9sJu3Cb4wrQ/JZYYhCAMxGii9U/n32f30gk6EJmoVFsk/9r42x
         qoDvWgs8XSMTj0Lq38Hbhx4s6IegNFqEOUsL70DnnUHkucZtcbCpTi8jQonYbBcWcUMs
         Zvyyz7LuU88mhFBLHKlXyThuAnxm3Mc+ul9lVt6U4uAbols7XSMgqzgkMrwp71T08LA0
         C4AOw9HqO6GVkeGTtuMfmplMQV68E3jwP39TP6T/kSKyd0Zme8Rh7taMC2GtBkTCAXTQ
         t+mw==
X-Forwarded-Encrypted: i=1; AJvYcCU+SMU/e1DQgzAfz5LZoHpUAkoQ69iM0Cj3VYliHMvz8eAJdDuUhcRuD5N053g49ugSuxnL4a2Ht68OJwJAsAVKpxrwfLfA6NxEPYp4
X-Gm-Message-State: AOJu0YwsTzGmGp++EaJqOXUZ5/OPfEZp7QRbIawRENiF93ZCf3n0E20m
	ee7SngSbov0zpo/vsdoVhlD1FSpCMg4IsdoWyjGliZpXk/Ds66Gi2FPHIw==
X-Google-Smtp-Source: AGHT+IHxkYKouZ2Y4m2SvnLt/y6Ns7jWHSiYGH6PEhpr84FiwECepmJEu7Da5JvDlzWWtf7b2sYt/g==
X-Received: by 2002:a05:6a00:38cc:b0:6ea:8604:cb1d with SMTP id d2e1a72fcca58-6f8f1a652eamr3349043b3a.0.1716578104610;
        Fri, 24 May 2024 12:15:04 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc05bb88sm1427273b3a.62.2024.05.24.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 12:15:04 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] tools/lib/slab: Fix potential NULL pointer dereference in kmalloc()
Date: Sat, 25 May 2024 03:14:59 +0800
Message-Id: <20240524191459.949731-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In kmalloc(), add a check to ensure that the pointer 'ret' is not NULL
before attempting to memset it when the __GFP_ZERO flag is set. This
prevents a potential NULL pointer dereference.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 tools/lib/slab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/slab.c b/tools/lib/slab.c
index 959997fb0652..aeaf535b422a 100644
--- a/tools/lib/slab.c
+++ b/tools/lib/slab.c
@@ -22,7 +22,7 @@ void *kmalloc(size_t size, gfp_t gfp)
 	uatomic_inc(&kmalloc_nr_allocated);
 	if (kmalloc_verbose)
 		printf("Allocating %p from malloc\n", ret);
-	if (gfp & __GFP_ZERO)
+	if (gfp & __GFP_ZERO && ret)
 		memset(ret, 0, size);
 	return ret;
 }
-- 
2.34.1


