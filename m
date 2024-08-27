Return-Path: <linux-kernel+bounces-303028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF26596065D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7191F2230E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D9119DF8D;
	Tue, 27 Aug 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gsPIRQpT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D2419D067
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752562; cv=none; b=pQTYebv2CM3mMJWuWx1zA54ynMHboCMUcMs/upiQ1CBUKtAbZDe9vTyPDkUgbH1oKP2jNvkpt5LN29dbTpB+3qe/RQzAA/merK43D6g2dORTf9PgIhYYTDHVKR+njZJWf8hoojDsq+uKyucsPkgbw+JhfwCAfKWp50KauJY2VHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752562; c=relaxed/simple;
	bh=CaKmYffiLj5wjYYPSwbMvdyiljpXahIOuxC/bopPWgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ohj94mW+ntN4/9tjsKndD4m+3iLgNUPvan9a4LvGCriQk2TLqnBE3eLrMVLm7Xds7xLidwnkPD3DkIEQm8PEthenXvNzz/VL/0MytpuWKHoxv0Mm4oDrkqVE+zctT1fStc6NuvXIheNR6VBrdPDC2GJY+QM+MD3t6H1pqVd3B2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gsPIRQpT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-201e64607a5so37481945ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724752560; x=1725357360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulSL1wDh1UXX6pfgOa+SdSJMLV52Cd+y6JQhndrl4/Y=;
        b=gsPIRQpTDUKLCuLP9FlANzcTzarF6Y2q7h4hgtiRECZC3IEllhG3/e33ikPJ3XpEfk
         1VzUMJBbZfPfMzOhPN4XaOm1igAIjsdmwQCrNZkW9IXORE2ONtXfia30FBcx3RdcJA0x
         RuNaaAxNU/buQaIRcTLtPyBzJwoK0ob+CFtts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724752560; x=1725357360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulSL1wDh1UXX6pfgOa+SdSJMLV52Cd+y6JQhndrl4/Y=;
        b=uK4GiT6E4Dbm5lLyySamSwyyxK2/vh/LI0AGMMuGYFMTEb1xM1xn//aHxE1+ZOuOjr
         rhcBG2G7BxzFm00kznWNVeA0jRF6KV41333Cpiyx9n/3deZaw3yHydic9H286jQ9q7Vn
         lZtcPWbIrTkqj7WNDbfrK/AfBHhsIV5Drbp3QS/j3UCGBHuyjWcTvj3H0JhfFmi3weWj
         1jVjB8NL3LX41kaqFpTQRnRPLQI5tOVr1yKbp5/fQnM5MpdI09Cx6XspkaHC4+BQKg1x
         6mJ0JIrRb5FDWng73EQRFkFYWlQTEuLF/K74SiWxNEhu5gEN27lne3OpfIOUB8auPWg5
         hzog==
X-Forwarded-Encrypted: i=1; AJvYcCUJBfEOHqfhBf/TtORn7A7MsZWT1EGvPmnvUdjILG/EOCec3iHRGbPx6pJH09ankxnb+WYpaGCnaDk+CfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/V9P03D5YuJShms6zJuL3juZlcghyVI+TWeIrpXrEWWZW14w
	uVeVoAoAhMJqf3wXsixHJjjMSaczN4/6rILeYOjyCxVax9aAx4PP4FC8X1izvg==
X-Google-Smtp-Source: AGHT+IHG3kC3TvoiL564c2nCrzUqffudLVZMezuiycIsHxkJQk5Y8znjAyFMUcZ+3HMMg+b6baVggA==
X-Received: by 2002:a17:903:41d1:b0:202:54a5:deaf with SMTP id d9443c01a7336-2039e4fbd80mr184597195ad.57.1724752559745;
        Tue, 27 Aug 2024 02:55:59 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:3102:657e:87f4:c646])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560c2basm80006775ad.222.2024.08.27.02.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:55:59 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/8] regulator: core: Fix short description for _regulator_check_status_enabled()
Date: Tue, 27 Aug 2024 17:55:41 +0800
Message-ID: <20240827095550.675018-2-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240827095550.675018-1-wenst@chromium.org>
References: <20240827095550.675018-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc complains that _regulator_check_status_enabled() is missing a
short description.

Since the current description is already quite short, just trim it a bit
more and use it as the short description.

Fixes: f7d7ad42a9dc ("regulator: Allow regulators to verify enabled during enable()")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9029de5395ee..763048d6f1ed 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2707,10 +2707,8 @@ static void _regulator_delay_helper(unsigned int delay)
 }
 
 /**
- * _regulator_check_status_enabled
- *
- * A helper function to check if the regulator status can be interpreted
- * as 'regulator is enabled'.
+ * _regulator_check_status_enabled - check if regulator status can be
+ *				     interpreted as "regulator is enabled"
  * @rdev: the regulator device to check
  *
  * Return:
-- 
2.46.0.295.g3b9ea8a38a-goog


