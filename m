Return-Path: <linux-kernel+bounces-426172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D7B9DEFD4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A081630EE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F92155CBF;
	Sat, 30 Nov 2024 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KlmFOoiR"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EADC155336
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732961266; cv=none; b=ASyMcKTNiJPpFrORkQDhdYqUhXI8MR2U7VbucR6MdpNrbF1H/z2hsBceRLgo2Ag0HJBsFqQj3owYH9lNR4SN6JrEKzQ9zZ4FBtExk+yzPo8O7JkRCVfB60DJAxLBZStKfX0pf5WF8o2YSAkQzVNQ5AKApMghEAJTA/TC1UHVV/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732961266; c=relaxed/simple;
	bh=/Lqq8JaXt4nCGNvsOy0aZbqLE2wFjoQdnXCeO4UCcfk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q3Nc3SNNeGKdkCwm9fsg2QToJrmOiJ6vzuDK0ENQ8WZ68vaiBIrA65gAa/1rFICOrptWk2I4i0lfKJsgFTd/JJ13Pn2phKQ/uhP/hLy7vXwXGnNuvwdSBTgIjNnlF/jVRH8rtr+e0EGSusW7UTdG61DyTtCwKhxGJ8tRiVZ6lMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KlmFOoiR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa531a70416so155914666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 02:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732961263; x=1733566063; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LTiN4AcsE0vQHpWePTXXpdIk4ANIHC/O3POgP94FzkU=;
        b=KlmFOoiRNiKz0bmAJL57GEISkQoQ512U25sLcZT2hsC8tO8m5haKOCdgJUHuyjppJf
         KWoKC3uHZWLPpq5vL46C6bLn95vUyhHEWPz1UljzjN9KvEF96ZDqG/WAYg4itPQubq7j
         EBfOagcrQ+dOxFdLjQ1q1/x756AQY7lngM6ufHZY5r+lRmAGYdxTPxnLXcGmXmf6p1iq
         q5uT22WixjfX3OV2CLM8n7lKc3mPFxUdt1mndKhGiS0oamSBjj1eqz+Ve4ffeW3BzbkA
         nse6GpSnavW30ilngbrCWsnixHl6pC1BA8CJDTAFxz7H3Qu04LZtlO60ghpH+YFt6RO3
         Me2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732961263; x=1733566063;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LTiN4AcsE0vQHpWePTXXpdIk4ANIHC/O3POgP94FzkU=;
        b=VXQBhkLYlzVpQ5Ss9qgCOt1qA5P96ZhMBaWXf9yAfvRx6kCYD8Kmp3O+YANLGQalz4
         r0S6LHKBhIwVkG69j/tv++NSy7R6UM4HfjoDtp8Hm93BFodNLttaKp0w+pIAdaTtmqr2
         bcMmh62kUuHeRvlrtEwakSD8TgIoHcDZZP4P00YttlytkItvwZVqgQWL1h19zXDvE7sA
         2x9Uc9gNtMAJOi6z8YbMIFsIeAECYnGj/nHd4Vcik9IEP87ALvpOvxa+3M2waXex0Teo
         8OWZKbQvtedv/aXR85J0639QLEiz2AMdBSkFuvTlgo9rHKgf1H2+T3oLsXpsQQdx6RE8
         e5DA==
X-Forwarded-Encrypted: i=1; AJvYcCW3emiS95oUAjpIySCmCHbj5ESRMk1F7NnrVsafVFXWgG0isSCOe3tpEbLxDqHJntgyjvgNcLTg5GlyAKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3EJyk2OBnvzibdT6rrklIhXg52kiwFZMivhc3u49DUK6EaZx8
	GE2jgekemuRfAH1kMvHNhdbIQ/iI2RyosmPP4LvE4YOaW+5RcMCXvjuyZmghE88=
X-Gm-Gg: ASbGncsz6l7CuUGtEW7cDVEnNqyiuNygzjhciXjmMuJfYAxWif7pGv3GT95eMy4qkKH
	Bf/OITMSXxHCf94AlVfQ0Xi+qtwfBU99sNXtFifBhI5n9FMUCxNC4QFmEi/Br9v/6lAexpZTXpD
	CumZSo+mbmnb8MfF3cs66bMTXFjizTCfgA6WEiQhyMOIlFVxndHAZS6STROtHlg7+DnjBCuG30z
	mDpckQtxkLx+1CpDF4Cl42FtA15Ujz5s5bMcqhlu7KMF3bqacTsAr11Px8Vp+Tk5DjY0kh/
X-Google-Smtp-Source: AGHT+IHcv3RQB0ttGHB3rHF8kVixpbGo6oU/NmsBDLLe1zSp/r+M8Q40bOxX/CZl1ALhhzeDN+WQDw==
X-Received: by 2002:a05:6402:3589:b0:5d0:ced8:d22d with SMTP id 4fb4d7f45d1cf-5d0ced8d41amr1610681a12.22.1732961262750;
        Sat, 30 Nov 2024 02:07:42 -0800 (PST)
Received: from localhost (h1109.n1.ips.mtn.co.ug. [41.210.145.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d4124sm269133866b.64.2024.11.30.02.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:07:42 -0800 (PST)
Date: Sat, 30 Nov 2024 13:07:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Jassi Brar <jassisinghbrar@gmail.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] mailbox: th1520: Fix a NULL vs IS_ERR() bug
Message-ID: <bda05d7b-5a6e-4f57-a124-ba56f51da031@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_ioremap() function doesn't return error pointers, it returns
NULL.  Update the error checking to match.

Fixes: 5d4d263e1c6b ("mailbox: Introduce support for T-head TH1520 Mailbox driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mailbox/mailbox-th1520.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox-th1520.c b/drivers/mailbox/mailbox-th1520.c
index 4e84640ac3b8..e16e7c85ee3c 100644
--- a/drivers/mailbox/mailbox-th1520.c
+++ b/drivers/mailbox/mailbox-th1520.c
@@ -387,8 +387,10 @@ static void __iomem *th1520_map_mmio(struct platform_device *pdev,
 
 	mapped = devm_ioremap(&pdev->dev, res->start + offset,
 			      resource_size(res) - offset);
-	if (IS_ERR(mapped))
+	if (!mapped) {
 		dev_err(&pdev->dev, "Failed to map resource: %s\n", res_name);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	return mapped;
 }
-- 
2.45.2


