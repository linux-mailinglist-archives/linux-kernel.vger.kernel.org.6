Return-Path: <linux-kernel+bounces-306443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84018963F16
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0601F2521C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E45518E354;
	Thu, 29 Aug 2024 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TkEUns7r"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB4C18E054
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921528; cv=none; b=O0jXYlGB/h2ehTXwETDHHFa3FkqSXFJMJARUcB+AD8ebltE/cl7ArCz+ySQiGGaYwGigb0d2aAKz47v8Hse6tEI9Qodj95Yfioih+79qm4PbY63xghb5D/pYduFJsuD41DT5QYtOla5y0Z0PEhFr/UN7Vzw3RBUVRKNsZrbM/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921528; c=relaxed/simple;
	bh=sBM9ARh7eDRymdf4FtcaEhoRTmZZ184Uz1y3Zn5KRB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4zJHSCk1uPxMl+okh6f5sryMke7xZ8v2nadzye4XJ43d3ML2Zm+ckM9/OUULikQoqCtFEGTgfzuNheAUNkjoozKJBprN09YLmJKdc4p0w94ir7buV5aniZCQrxVF0a65dAQil0IWkA+v+ImlHzRVh5i7TbMik1vyX7KX3zzIX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TkEUns7r; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201d5af11a4so3456745ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724921526; x=1725526326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7f9k7PpUQjpljatpt98ZEbTrZ2XDZjx22JMjFJskajY=;
        b=TkEUns7rsPTsVlSqcBill7lJpxxSZTMFdklj7k34wLoix/sQdgeMOhroCYxhEXrLnZ
         IHo72IHDGdRiF9jsa+s/8N1lQiV3ohSjIwdKFnc5NwRmyF1WcR0X7fSWguElove6wOQl
         +q450CFXmqXzjcouQZsM3AlJMmCJKbcdO7Jeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921526; x=1725526326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7f9k7PpUQjpljatpt98ZEbTrZ2XDZjx22JMjFJskajY=;
        b=nL9F9We4f/YvbukcGyk3p6wQjEaKpSJxFD0zEMkbPLynFpBlV9eNwfCrmRcpENUc0K
         IqT9GoJSZerRiai41G12j96OiOCsEbPoL+YC/JMz+K+fXAH4ojDLpmRVB3ElGG8FNR1A
         D94PdYCmwHfBcw3yZ5YBHJy9s2k+Woiryz+1MfI1Vg8udAOMWq/sYCR0uI3+sBSzbl1p
         xBD3KpjQ0kzFkhPkERQPkk4g95OCYMq+fI4Z6Dm9vHToElowiTqbc6J6IZ3bZypNjtDy
         GI3iXLlXmu3U+idyAAjdJ7GOpOa1tZTcNt1zfty+V7Gu2izkf7l4OdRQYhvoxjTPpKUr
         BLYw==
X-Forwarded-Encrypted: i=1; AJvYcCXpjqJCzK6cTRNBWfwsZqoKp3zNgL0r1IBh2FMDQ8sAxH1ee1hHmzmsmD4Rh9Md3irCRjLhm5j8wKXPLqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxveMzLQhvYwBKuM1V8aRUUmjpUye/i6j7YJMlJ3VMdhOtCH/1v
	xUzFmLTwgiGr4g9ku3ll5aKlwoB62XsQQpnLgx2rYi2JecfrB91T/tBq0Snt/A==
X-Google-Smtp-Source: AGHT+IGhKkcGNXI0K2CzplNu1hl3pLJjO1nnoCWwWYcUIQxyGIW+1Pl1x1rPn6MjaWMLeftQHomqJg==
X-Received: by 2002:a17:902:ec84:b0:203:a0c7:3156 with SMTP id d9443c01a7336-2050c23699amr22267205ad.5.1724921526443;
        Thu, 29 Aug 2024 01:52:06 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fbe5:6d6c:1cc7:23f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515543fbdsm6924165ad.218.2024.08.29.01.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:52:05 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH v2 08/10] regulator: irq_helpers: Fix regulator_irq_map_event_simple() kerneldoc
Date: Thu, 29 Aug 2024 16:51:28 +0800
Message-ID: <20240829085131.1361701-9-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240829085131.1361701-1-wenst@chromium.org>
References: <20240829085131.1361701-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc complains about missing "Return" section for the function
regulator_irq_map_event_simple().

Add a "Return" section for it based on its behavior. The function
actually always returns 0, but fills in fields in its @rid parameter as
needed. Expand the description of the parameter to cover this.

While at it fix a typo found in the description of the same function.

Reported-by: Matti Vaittinen <mazziesaccount@gmail.com>
Closes: https://lore.kernel.org/all/e341240e-1c1f-49a2-91cd-440888fdbda0@gmail.com/
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

---
Changes since v1:
- Update commit subject to reflect changes
  - Was 'regulator: irq_helpers: Add missing "Return" kerneldoc section'
- Add period ('.') to the end of the "Return" section sentence
- Fix typo in function description spotted by Marti
- Describe output fields in @rid clearly
---
 drivers/regulator/irq_helpers.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helpers.c
index 5ab1a0befe12..2de7b907c81d 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -404,16 +404,21 @@ EXPORT_SYMBOL_GPL(regulator_irq_helper_cancel);
 /**
  * regulator_irq_map_event_simple - regulator IRQ notification for trivial IRQs
  *
- * @irq:	Number of IRQ that occurred
- * @rid:	Information about the event IRQ indicates
- * @dev_mask:	mask indicating the regulator originating the IRQ
+ * @irq:	Number of IRQ that occurred.
+ * @rid:	Information about the event IRQ indicates.
+ *		The function fills in the &regulator_err_state->notifs
+ *		and &regulator_err_state->errors fields of
+ *		&regulator_irq_data->states as output.
+ * @dev_mask:	mask indicating the regulator originating the IRQ.
  *
  * Regulators whose IRQ has single, well defined purpose (always indicate
  * exactly one event, and are relevant to exactly one regulator device) can
- * use this function as their map_event callbac for their regulator IRQ
- * notification helperk. Exactly one rdev and exactly one error (in
+ * use this function as their map_event callback for their regulator IRQ
+ * notification helper. Exactly one rdev and exactly one error (in
  * "common_errs"-field) can be given at IRQ helper registration for
  * regulator_irq_map_event_simple() to be viable.
+ *
+ * Return: 0.
  */
 int regulator_irq_map_event_simple(int irq, struct regulator_irq_data *rid,
 			    unsigned long *dev_mask)
-- 
2.46.0.295.g3b9ea8a38a-goog


