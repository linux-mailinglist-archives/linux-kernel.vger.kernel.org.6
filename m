Return-Path: <linux-kernel+bounces-251595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82D69306B2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 19:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EA7284E23
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 17:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF1E13C9CB;
	Sat, 13 Jul 2024 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b="gQZJhO17"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5D31757D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720891373; cv=none; b=nHMyfy0HlSLApcGoIPvJtncKGeqR5jzaz9/m8oEHgPowPyzi5W8OtAxf4zw82e/N7b3PvxStbInQPsRKHHNjCUGcx0wPPVpkkE/YtPWOzAmDButc5b1FranziYn0/2+i//GOhdjEi0bG0rqP+liGVsDN7ET8O0eb23JC9Q9g9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720891373; c=relaxed/simple;
	bh=LFtUKNPWDeUKEtI50JpAItQ5h0nXU1L8hRmcUKoA+VE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Izp6PFbmEr5HZn2eauLgOplAmVkd+p8qeRBH1gy2PjULbM3fc2XH47LStyj0/bdjQoX1VlvifrHSaE6Ekch1aMHrVMdw3FNlx7d9tylTkxCWEP3vGwyvG7NNbaIzelFkkx8+ZIfq6200CKwpkdhdSpgP0nuwjxFGFgb0WdDVcpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in; spf=fail smtp.mailfrom=mitaoe.ac.in; dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b=gQZJhO17; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mitaoe.ac.in
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb70169c23so25977205ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mitaoe.ac.in; s=google; t=1720891369; x=1721496169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6HzW/a9N1AEcgIf6A+5EQUhbObGqQjBzYBZLTCmCokY=;
        b=gQZJhO17WOGKRzOZkpXZAem4trxUR+DxK4K6kf1n+9aZXaFNVd379N150NJdHkGJ81
         Xmj6J/ceouYpkV+wGVfA95bByaDCrg3pfev4M4A5XSexU3YpTQcCSy/8svxyzmEualX0
         L1njlnK34WeW8hMrk5OwH+z6ijYnEsX9RNrUxrTBB9wAdaGB78VVIlkhOI6k+bmD4yTb
         yxPHWc+BlJA2xa3qOA6OEAemFi5zESMz7uPjI/P1P0QpkFGgMf1fPB6qVUU0tXlHKGYH
         0/r3JsaecYuKiGyz3fmy9NYRatNHAguhoB74t3tPyF6N77VxBwdLqjhqJ8ZtbvVq2eS0
         OhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720891369; x=1721496169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HzW/a9N1AEcgIf6A+5EQUhbObGqQjBzYBZLTCmCokY=;
        b=wemIIA8YdViV+KS+Z1fyXIY5Q9ReAYwFEiEYuf6Cidf6qhsWXRA+/fEoFhrQBo3JUu
         L2Bl8n0oGV7ziTkGLrAWQUB2QUF+wHnuptrC9mXmx/nVHiSIYofkMjP6X8vBatvNAo7O
         r878WGJHUx1q0YXGmv1DYfwit9cvhad4ARNcOzXES5+znQIcFDxcvG74KVsiYZJ6KxRc
         dy77Be/e8pyd1MgyBKaUErgwUL0HvZ6z78uvZvoqII6S6iWpNilZPgwRFWFIT3B90/49
         GumB9w13/xJas9q2Dl9If03BuwwqTr9AoDveSDAikD/IpNizUduK2uFQ3nMUqlK4rILW
         sGqw==
X-Gm-Message-State: AOJu0YzMveozaYY1krW+n4Rj+j/UENhZJgEV2P9CQa5wACLyGm1rHvpy
	Q7sf1vA030rKlErcuHXVCXNbkLJU3tu0G0Jq7zwQK7a8FnP6S0r69HxlidLGFMU=
X-Google-Smtp-Source: AGHT+IH2If6imdFWwkNLPOA4ZzF+T5v+gMfoF9fHPEpy5IYhTzOufN+D+dHejfRPJ/32UKKcjAjx0w==
X-Received: by 2002:a17:903:1205:b0:1fb:4c2e:9803 with SMTP id d9443c01a7336-1fbb6cda8a4mr128712135ad.10.1720891369360;
        Sat, 13 Jul 2024 10:22:49 -0700 (PDT)
Received: from localhost.localdomain ([152.58.19.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6ffdesm12969375ad.53.2024.07.13.10.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 10:22:48 -0700 (PDT)
From: mohitpawar@mitaoe.ac.in
To: bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org,
	Mohit0404 <mohitpawar@mitaoe.ac.in>
Subject: [PATCH] pci: bus.c: Fixed warning related to comments
Date: Sat, 13 Jul 2024 22:52:42 +0530
Message-Id: <20240713172242.125555-1-mohitpawar@mitaoe.ac.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohit0404 <mohitpawar@mitaoe.ac.in>

Fixed multi-line comment style warnings
---
 drivers/pci/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 826b5016a101..ef1f2a4c09d8 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -200,7 +200,8 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 			continue;
 
 		/* We cannot allocate a non-prefetching resource
-		   from a pre-fetching area */
+		 * from a pre-fetching area
+		 */
 		if ((r->flags & IORESOURCE_PREFETCH) &&
 		    !(res->flags & IORESOURCE_PREFETCH))
 			continue;
-- 
2.34.1


