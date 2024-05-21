Return-Path: <linux-kernel+bounces-185279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBAE8CB306
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6993228284C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1FE1482FD;
	Tue, 21 May 2024 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj3LQXko"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA685482D0
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716313150; cv=none; b=UyZCYygdc8SLUad0T3BBfRcbfyrACHBkrNJk8DhBNgIBbec3ldWrGndLcgJocvimyfIfrGAO9UIP66/zqOkCqlI+NjaNLIlHbDdxCYQ5NvM+tpf6QMCGaKBaJ+MCQ+6VH2mMXIyim1B/FmSbo7T+P/k24foIbyWts0GODHvh4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716313150; c=relaxed/simple;
	bh=/XhjSFuvkXzuGm8TOE4bt1Gx2/2a15udsyjEKI16Wmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N0flYzTQmOE9isRA5YKsbJCoSU918YkNHLLiBPp2BGrBVGxtLL+SoYc54CMRk+qXq+jyTF7+JBmZI9xjqh0OhKasELDpsOaZJ40VznyJ0AfTM+Dxq0lowjXi/HcrNstYQBEG/D2ZhqsDTH8kWyRCNuSF5W0tk2OdOrdxYaDIEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj3LQXko; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so110657165ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716313148; x=1716917948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uV3GrqVP0qYMNyLcMp5DeTAEtIzneWxCv77ALTeKoVk=;
        b=hj3LQXkoNDCJqWFu9Qo0sLpcvoiC6yw/Oq/XkxIRrqmUs3769ADEGt/bFjUg9MAa7A
         0pRsY/38p2TkTwXAgpI/kK0d/gIZr8GiD7H2jvi+Fr1sGkMENH5nIF7WC3WeqbEg54Kq
         r0HtCZWrcltwkB/yJmLjpmaz1fvKXEQM3dJYBVx3JYm0VMaGV5DgErCbIZ9doSNOSW/B
         567EqmZbeLtvNXkxLBtbO7dAEnW2gNhD8YWAPhAwCD0uFhYiTzl2Qp7Rx+eTdx1lJn1x
         g/CfbAtyucE6vRb+Z+bYR+KDBCZzS1Y9IuQUO1qLr8YxKokUkdML9hbrBb+FvKjwrbOy
         9NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716313148; x=1716917948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uV3GrqVP0qYMNyLcMp5DeTAEtIzneWxCv77ALTeKoVk=;
        b=dwwiwSZlOnspFgIuccvIRhUu2HnHKIMkl55adI77YrhzDSsg5PFyZCXpoYv4nC7HBg
         u3LpSXhOJ/nYe4oX2fZ2ey76aZeVo6iCfvrKauQdZhCFkgl6yiMAoBIbMBb5woq3BJ4s
         xN1u5ezbiLjQz9uNykru9sUeLOdfffK55S9nAa1/UO3vi3pEkJ53Y+rzRg4eMMN23aD5
         b2vl7/AxZ5+KfBGuVAynYfYBYoroTVJxXWOvfkWuFy8XyzFw7zGqA26LNCtSsAgUSeNZ
         kYWYte0Ju6zqBNp86oW5d4Ic95qDFRk0pNaQwlMseyfNq9nqfp+YPA4TVTc59xMZ/y/r
         YO4A==
X-Forwarded-Encrypted: i=1; AJvYcCVqVrfnf3u0icUdIj9ZlfDPFPZqZCzHWiAZQI6yX42DBB+DZC9leh1Ots9fdArbRauw/X6U2+x3ojNzXj6kjJpI1Pn8UgbpA21HTiZQ
X-Gm-Message-State: AOJu0YyM3qTzpf8BVF5uIR5MB6zLkcM3FumYxfXXkG7pKP1zo70su1jY
	MpmicXsqWDt6bWDYR/85JqhxEdbctoCbHmIUvHjIJ7+Mtw/BwnNb
X-Google-Smtp-Source: AGHT+IGjD6OYIpckFwaXQYt3LAcRXmZvaDuzHbk7bgUa8MB4MekY1TOiVYfkBkDV1dIBIo7GwHFClg==
X-Received: by 2002:a17:902:c402:b0:1ee:1fcf:e19a with SMTP id d9443c01a7336-1ef4404adbcmr379970535ad.59.1716313147899;
        Tue, 21 May 2024 10:39:07 -0700 (PDT)
Received: from localhost.localdomain ([27.7.152.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f0958d1e3csm112759285ad.191.2024.05.21.10.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 10:39:06 -0700 (PDT)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	javier.carrasco@wolfvision.net,
	skhan@linuxfoundation.org,
	Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Subject: [PATCH] drivers: soc: atmel: Automated Cleanup using __free()
Date: Tue, 21 May 2024 23:08:57 +0530
Message-Id: <20240521173857.1080030-1-pvkumar5749404@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using automated cleanup to replace of_node_put() handling
allows for a simplified flow to enable direct returns on errors.

Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
---
 drivers/soc/atmel/soc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index cc9a3e107479..8c7fe37b4f21 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -250,7 +250,7 @@ static const struct at91_soc socs[] __initconst = {
 
 static int __init at91_get_cidr_exid_from_dbgu(u32 *cidr, u32 *exid)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	void __iomem *regs;
 
 	np = of_find_compatible_node(NULL, NULL, "atmel,at91rm9200-dbgu");
@@ -261,7 +261,6 @@ static int __init at91_get_cidr_exid_from_dbgu(u32 *cidr, u32 *exid)
 		return -ENODEV;
 
 	regs = of_iomap(np, 0);
-	of_node_put(np);
 
 	if (!regs) {
 		pr_warn("Could not map DBGU iomem range");
-- 
2.34.1


