Return-Path: <linux-kernel+bounces-541804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81DAA4C1D7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8501883C5E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F1021148C;
	Mon,  3 Mar 2025 13:25:21 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775EB78F32;
	Mon,  3 Mar 2025 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008321; cv=none; b=pMrLq7oTZAw34O9B0L8Lc2kJcSIb0aDH/U2b8GGiHP76P+Focf+K1fPypEuuLDsAF+haC2Z7CEKn39TEYEBICoYkO35JDQcgx4trG6F3nKtisM05RLlPN8whMDkc6Hvt9zS7DI4yTF5CQhJ+MNx7OAHWKj9Gv1evsqODT5H5BSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008321; c=relaxed/simple;
	bh=CF68ITkEzio2lwFpdhhqfi0tekXN0M3JCQJhfd1ikgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MCWwmgfd3ikoQTSH8mZYreDXJlNRBc6PZznavyMx354Gj1jcv/sCCZp3ezp8eXiqTG9dwPHd7xxqGLnyyLDtZC+TukhBApVN253amxxoO9PiuBci70RNVkQm3ybMHQwlFB7AyZ1k3KV+bQR0CYgXSf4+yz/GH4VyanZmX9oJIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5495c1e1b63so2035368e87.0;
        Mon, 03 Mar 2025 05:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741008317; x=1741613117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvI8UXCWnMKFItrWuIun9EnniZdpCTtSLK3drgRiXNY=;
        b=TiPaRhxt9OWS1FT+p0fD08f02ZBBu//NJgiBYLMbh6xhXXylTTA1qXpeHYVAtPWzL9
         Ls/71il1Sfu9fBwPDzXXeKZC9soAVwnNZq6bn4MrQnI6t/iMTLAm3eHbhINSkFKdHA2r
         6xZTTBOxMtY1w9Ir97gPcUaxCRrhRwQrnxlnu9NpLzDkUMLhUGWRMGLjMdkZE+fmNfHw
         KkX1VqPJEN826qr8vXL76Ty7PwlOKtcT95PeTYpI2yS6CCQ/doulVIoG0f5J6918KATy
         NaNkKXrJ+sdrrAcGACvtssoniLv+XCXjFu4nL4DvHOJgBPvTS7l+FSwZmn9TsykUv0r+
         OUuw==
X-Forwarded-Encrypted: i=1; AJvYcCVyXv1XX+u4UViqH/zgFUlAUHvNAql1gtSyUrvD2p3L8MX53vUrF6XZqCv2EGICYTvTMmAndXHAPVmffo9E33QPJcTE5A==@vger.kernel.org, AJvYcCXnM5z8ORff9rQFxpdtX8M8VmMAktiPOSpZAux9tRIAuHgx7Mzo+6SyIOVsZJRjaFO4Kqft0FcLAF+6AGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YydXnjhAJLNxfX2SDB07rhAFoGD52+1+V43GPqVT9JV85iaEEI4
	ttxIWLlRKpDHJUuhZr3t4laNUOeTzteEz9/HCBuCCQWdOXh71rDN
X-Gm-Gg: ASbGncvw6ng6NeoB1U4cLsRT7O49FsIaZW3vwfMUIAcejn9ktiKKNF7xb0u4mffvwtL
	QwlarFnO7qL0jgPjrfNRwlZ3f/cSOM2TWwXEodZqYL8keIOB86Oc3kMRBAFuktd39+OykP8fyZk
	LY0fsa0F4WOx1+/l2zxccwHOS18SI/dNf/Og/4HUgZ+sqgK2waL12RzeHd6fLSLsWLCqFszTFr9
	cE4a4e6ZAFRcIfl5kUKuZoEvh0duJOOyIwT/orIZ+0YJV1tFTdq9DOtz5QD1xvUyGfEu4NLwspl
	umpxXPL0CC2UCuy82UsCeTV+i5KElF2ApLd0UUmKtdim0kYjsO1C2+0QlbnXTLXN/PP/xuOZ1IX
	9ggPw3UTZQw==
X-Google-Smtp-Source: AGHT+IEWiJqiN80wxUoSGkDQiEjqewC3CEjHxlQkylO7RhGd89y/xiyRzvl6dA6nkfkKffRfu4Gg6Q==
X-Received: by 2002:a05:6512:3d19:b0:548:794f:f9dd with SMTP id 2adb3069b0e04-5494c111896mr4440514e87.10.1741008317210;
        Mon, 03 Mar 2025 05:25:17 -0800 (PST)
Received: from galaxybook.local (82-183-24-76.customers.ownit.se. [82.183.24.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549497fd3c6sm1141139e87.206.2025.03.03.05.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:25:15 -0800 (PST)
From: Joshua Grisham <josh@joshuagrisham.com>
To: W_Armin@gmx.de,
	thomas@t-8ch.de,
	kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joshua Grisham <josh@joshuagrisham.com>
Subject: [PATCH v2] platform/x86: samsung-galaxybook: Fix block_recording not supported logic
Date: Mon,  3 Mar 2025 14:24:32 +0100
Message-ID: <20250303132433.348653-1-josh@joshuagrisham.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Fixes logic error when block_recording is not supported but the fw attr was
being added anyway (reported by GitHub user bbregeault).

Tested myself on a Samsung Galaxy Book2 Pro (has block_recording) and by
bbregeault on a Galaxy Book2 Business (does not have block_recording).

Fixes: 56f529ce4370 ("platform/x86: samsung-galaxybook: Add samsung-galaxybook driver")

Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>

---
v1->v2:
- Add Fixes tag with prior commit (thanks Ilpo for catching!)
---
 drivers/platform/x86/samsung-galaxybook.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platform/x86/samsung-galaxybook.c
index de1ed2dc6..5878a3519 100644
--- a/drivers/platform/x86/samsung-galaxybook.c
+++ b/drivers/platform/x86/samsung-galaxybook.c
@@ -1100,11 +1100,13 @@ static int galaxybook_fw_attrs_init(struct samsung_galaxybook *galaxybook)
 	}
 
 	err = galaxybook_block_recording_init(galaxybook);
-	if (!err)
-		galaxybook->has_block_recording = true;
-	else if (err != GB_NOT_SUPPORTED)
+	if (err == GB_NOT_SUPPORTED)
+		return 0;
+	else if (err)
 		return err;
 
+	galaxybook->has_block_recording = true;
+
 	return galaxybook_fw_attr_init(galaxybook,
 				       GB_ATTR_BLOCK_RECORDING,
 				       &block_recording_acpi_get,
-- 
2.45.2


