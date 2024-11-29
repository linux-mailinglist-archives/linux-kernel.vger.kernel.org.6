Return-Path: <linux-kernel+bounces-425454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB48D9DC24D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800B1164B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA8319067A;
	Fri, 29 Nov 2024 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F6msEVFv"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67822155345
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732876884; cv=none; b=QYpu6pdCRMcIgU5wPrF0RJ4ATciZg5MBcdXOKL86x3/7hUBHEMga3qzXiE8abEJEvsvb1Ev97WlmP/bW2c0gDJTYaccRvRP+6oHnow0nWCNbih/L3VtNV079B0NbEOqOjhoAOSLc3M+H0kqKZwUq4oI3vaRiwSIO1GD6T1sZnew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732876884; c=relaxed/simple;
	bh=mGcE/a4Djr88U2hlV5AL8ojy8KDVt8E/UCu7GG9SY4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jx9StKq8u16IpPoLeF7gE7a8dK23UURI2AhZJ+7gz+SWuTcEk/MFmsxez4pdl73CrVcR8VNQgSVta5XqVygnBR0kYar3d2lmmN0WTIIb2zGgudQcgfdODMuzUDrLMwfGO68UOHVCdXkd1r1IViyZ0M9s76CYnh8KwuyuNmleny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F6msEVFv; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d41176505fso13385676d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 02:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732876882; x=1733481682; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3QJ9o8M7EqzyfllL/EViAFMscBHfEHttay7cu2lgzk=;
        b=F6msEVFvLYxO2u5kQ7hKkCDPrm0PUkutk+Sbj/6S41Rd48k8+Qdf1D0JGMZedN46W8
         WEujGoeFckNFIyLC9S3TVjc69CYh6bZIGQjOCIAQdzu6yr9yE4cisZH8Mm03ANYczj3g
         2thxJduLCTH0YfUk+gDvnB9YW94fEDRp3boLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732876882; x=1733481682;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3QJ9o8M7EqzyfllL/EViAFMscBHfEHttay7cu2lgzk=;
        b=p0+duLH+v5lrZyPsxKZ9pK7Uby0gJgFQJwhWqsd/QCXp24IQ1FXbndNhSoxdw2th9f
         4H9M3yyPlzk8qsB/xeZOju6hlJ8AfyFaVI7L6YCm68MOK1zh0BnW/rQ3VWyqiXAnzvCo
         gL69VV/T3dC9IZH1YspSzaFSUPYgcQ5T1Tn5qZAtfzgfqQ1ZQQCwSNpSF3Guee8FV3po
         xl8dU+cMNGLRnuWksRkmC6flXbBxDf8bcrICGcpyqbE/B3hbhgFM65C2HFLpv03Fcr0E
         nfitR8/1pG5YYEUH6LppwjQHczj2OGE4csJmsKNVzzSP8caNpQvFwMdbrmop3yBzTGh9
         kEmA==
X-Gm-Message-State: AOJu0YwXg+BudBZWVrEFqPibYtS/qyOofSyyuzq0W2KnBitzaFVp6kOO
	M7wfzEex1RG5DfCujHAWNwM99swubBlMTPt33bVQcB+8HbHam2N1a2SdoSHI7Q==
X-Gm-Gg: ASbGnctUl8OwTlmHnl++vTgvtqr3MAK4Pi7hfH/++F/y/he7i3EA8TgNA4KbpwiX9cz
	ATumYV1+sN8AvbsEM4Pt92SteyZzgOusz67aoHBIDJxCT8QEooDFzJkVWUlMq38OJnothXNZD9J
	9F6SPYj2M0OF+82/F1teIOPqiK9+EU+X9nM/7nn6diVk0aNae//MxR2A2V1ECRhB0iz44/4rteZ
	4b1EjC6OvobEuNdu6lyD8hGbPH/uoPyBX6ZjKMVtuWeB0dU15VNWzZxMiIA+Nllt0Wrfd1lY/gA
	34wcz0ZTXTFcNx6PsKH/cPgW
X-Google-Smtp-Source: AGHT+IFPJqQq8cqv3iqc88emxGC3oK3p3CTTu8/xVIK2j17o+i02UeE9vByNWT2QWKhklXfWBpziBQ==
X-Received: by 2002:ad4:5d66:0:b0:6cb:edd7:ac32 with SMTP id 6a1803df08f44-6d864d29ffbmr151115536d6.12.1732876882317;
        Fri, 29 Nov 2024 02:41:22 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d88b9e6a69sm849916d6.60.2024.11.29.02.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 02:41:21 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 10:41:17 +0000
Subject: [PATCH] misc: Kconfig: Make MCHP_LAN966X_PCI depend on OF, not
 select it
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-lan966x-depend-v1-1-603fc4996c4f@chromium.org>
X-B4-Tracking: v=1; b=H4sIAEyaSWcC/x3MTQqAIBBA4avErBNSVLKrRAt/phoIC4UQxLsnL
 b/FexUyJsIMy1Ah4UuZ7tjBxwH8aeOBjEI3iElIzoVhl41G68ICPhgDm53XxkmjJCro0ZNwp/I
 P1621D+SgttBgAAAA
To: Herve Codina <herve.codina@bootlin.com>, 
 Derek Kiernan <derek.kiernan@amd.com>, 
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Most (maybe all?) the drivers depend on OF instead of selecting it. This
is more convenient for CI because we can have test scripts that do:
make allyesconfig
scripts/config -d OF
make olddefconfig

Without this patch, OF cannot be disabled that way.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/misc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 902c306bc972..2ea5f40ff4e4 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -612,8 +612,7 @@ config MARVELL_CN10K_DPI
 
 config MCHP_LAN966X_PCI
 	tristate "Microchip LAN966x PCIe Support"
-	depends on PCI
-	select OF
+	depends on PCI && OF
 	select OF_OVERLAY
 	select IRQ_DOMAIN
 	help

---
base-commit: 7af08b57bcb9ebf78675c50069c54125c0a8b795
change-id: 20241129-lan966x-depend-8bc69b4954e5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


