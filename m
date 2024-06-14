Return-Path: <linux-kernel+bounces-215357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DB1909182
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255161F2506D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B3419DF41;
	Fri, 14 Jun 2024 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="InuplvbW"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F12C20E6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386252; cv=none; b=QT41FPwyAIze9JZvuwNsJ7J3HPod2BEiVVdMh3KtnHVKj5V+do+3mDMM4FntU7QaFXEOMRx/ejM0pSZkC5rhSkgvC9+hBBZuu9/NN2Iju+qYeo00tbHBPPT4YIx4RWrh4LeViR9ERWyS51kl0KtdXanZUR3NDyXLv9gxZLStz7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386252; c=relaxed/simple;
	bh=OuNYhmUKQHj/+toxfhoz0GPPmvE2PFXyg/c0bbZV3GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DyR5THp11ISxKSx5346DcQfWkUP6m1yZJskeHQ7mpVglexQ5gJegFKTFvD0S5SC1R5nfUtbET3QbH97Rwr+7/CZYQBQUUEMIF6awxf+lJONCpuJmZXy/7icwL2Vsyi63TPXTpmcCh9jNfMzrVsz2obtliq66zGPNZIEO9QMVVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=InuplvbW; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52bc3130ae6so2717098e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718386248; x=1718991048; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GhYLyvnes7IrRyooiF6hUo9Wtmgl5c1FE7dQTHZivIs=;
        b=InuplvbW6PFQthqw0ESLFhfq3C+r4+CPGUcZi6n76AearsZErB7T8UJD0IX+dlMIbh
         RIYmwMQfK4mc841Jywfx0lTuEB0JLogPpDjaHkQDwMQIXxAwDckBKmLXu/6KJ3TfoKs6
         LunoM8gOBMt8Ij9EUM3Ze+0lu7w/vqmCX+qfeipndgrsMQ3TKgHN3X7UqjGaVQcc9DVN
         toIjrORkW78vPsMDVgu8QTGR0SifPQ9CGYJAZV51q7au/T0c34fwy0TlSooZ0Sx3XExO
         4zyh4W+/uSNkP3NP4CWgEMukTiHsH73X+oqtJ0zUjEJOi5Nwb0km8MMOf9tAndOxAswj
         mPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718386248; x=1718991048;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhYLyvnes7IrRyooiF6hUo9Wtmgl5c1FE7dQTHZivIs=;
        b=JHZkaQ1PCu1QsVpIPOG9z40mCdb9yYs3e9rbU6ACm1UA710mVH1nrAUfjHmNKk0wxr
         UWPNcV9ezam9KMm1vt/07kZKb3Zw4cdaghSDwE0eV1Uttj4tBz+GYUVDZXaZyUZZqDFN
         Z86piVNGcGTRNY88xljMENnayrs0YjS59b+Pz0Wit8Es4Fxxq97flCo+9xPIZj27o/RG
         UYsD0zWu59+Dr0QMX/AduFhb6bdhp6ueSOpurbH+ODtQzrhq7SVtrfTtBZIJX1gb7pc9
         +b/FFQ8uCAlEhzcMdZAdiv/rcZ9qGoe62NxpfKxDOcxnIbmRpui7G9iG7/PsW+zI9sVG
         ZsxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLZJJ2xpeBEEEoijCd9Km14WTOofWiMNSEPxknzgq3WVtTGE/O9BxZ46LBaiPdLIVHZwv8WfRn7d2Omkk7/4UF6xrZYtJh8xvKcW/0
X-Gm-Message-State: AOJu0YwSD2BG4rfAyHTGiYiQSmTgShyWP3JrvqPMejfoGaklB/Xz90dC
	sQ9jIwWB/jpVSqPmAR2utUIOuTefAYI+VeqjaI65Kg0U+Pg/yyZKt6VyJO9ivnM=
X-Google-Smtp-Source: AGHT+IE8HK8BsiSh+6Wu+Mm+URrKAZY78WQcHj2XcIl5gyStXYt1n7LGGfHjo2+cbwsFt3wfVVbDyg==
X-Received: by 2002:a05:6512:114a:b0:52c:a809:62e9 with SMTP id 2adb3069b0e04-52ca80963f5mr2378320e87.0.1718386248378;
        Fri, 14 Jun 2024 10:30:48 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6127d6dsm69701075e9.26.2024.06.14.10.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 10:30:48 -0700 (PDT)
Date: Fri, 14 Jun 2024 20:30:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Quan Nguyen <quan@os.amperecomputing.com>
Cc: Corey Minyard <minyard@acm.org>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ipmi: ssif_bmc: prevent integer overflow on 32bit systems
Message-ID: <1431ca2e-4e9c-4520-bfc0-6879313c30e9@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There are actually two bugs here.  First, we need to ensure that count
is at least sizeof(u32) or msg.len will be uninitialized data.

The "msg.len" variable is a u32 that comes from the user.  On 32bit
systems the "sizeof_field(struct ipmi_ssif_msg, len) + msg.len"
addition can overflow if "msg.len" is greater than U32_MAX - 4.

Valid lengths for "msg.len" are 1-254.  Add a check for that to
prevent the integer overflow.

Fixes: dd2bc5cc9e25 ("ipmi: ssif_bmc: Add SSIF BMC driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/char/ipmi/ssif_bmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
 drivers/char/ipmi/ssif_bmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
index 56346fb32872..ab4e87a99f08 100644
--- a/drivers/char/ipmi/ssif_bmc.c
+++ b/drivers/char/ipmi/ssif_bmc.c
@@ -177,13 +177,15 @@ static ssize_t ssif_bmc_write(struct file *file, const char __user *buf, size_t
 	unsigned long flags;
 	ssize_t ret;
 
-	if (count > sizeof(struct ipmi_ssif_msg))
+	if (count < sizeof(msg.len) ||
+	    count > sizeof(struct ipmi_ssif_msg))
 		return -EINVAL;
 
 	if (copy_from_user(&msg, buf, count))
 		return -EFAULT;
 
-	if (!msg.len || count < sizeof_field(struct ipmi_ssif_msg, len) + msg.len)
+	if (!msg.len || msg.len > IPMI_SSIF_PAYLOAD_MAX ||
+	    count < sizeof_field(struct ipmi_ssif_msg, len) + msg.len)
 		return -EINVAL;
 
 	spin_lock_irqsave(&ssif_bmc->lock, flags);
-- 
2.43.0


