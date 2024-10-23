Return-Path: <linux-kernel+bounces-377659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFC99AC1FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E4E2B24663
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C08115B13B;
	Wed, 23 Oct 2024 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6HZm0/a"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA715A86A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672926; cv=none; b=TBTUfgM0bfgYTSSztQe+8lHKdAFJ75zCQnlg5iKo6HAK/nygJ8pfHY8AUwz6OXHxMTFNyF2UiQMENKbxLWytVToIZCYeazp2vX0IlkZjIU70LgfrvqqFyFmWzSMrS8oM/ED0u2UcOWXfM4zL25QZqYJyveWbedBCIrtqcKq9YGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672926; c=relaxed/simple;
	bh=eLg/xfE9L4uf5NA59EESgWABT5YKgmF+DoFEsj5P+2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UCiASPSxM0avRPC5H8sv1YBKRAJOt8YPILtZAZpBC2ld43NNNr92M5AwF56BoRopK0KJn4nJ1NVRx097AEqi2Se/KbdqHI3THX4hGamUFvWCHS3Vhj7LnDa9ZSFFskWwh8y2o5nv9WGEch2EWGInEUdq29gfbWERykdscd8868k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V6HZm0/a; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so78550565e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729672923; x=1730277723; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgEgDyVyxHK+n1+lMp/O7AAdm5QoPSpJEhFz0fntFAg=;
        b=V6HZm0/apO52fm+3JXYYE3Slmm4jEFMraxfhRTgbs3e5np9JoYGc3/JOmtP/AC65gt
         bpbdCjai1axYBKbPRRes9lYtiB/ooXoVzk8s9bL02DUfV+Ge2WA8IoEd4KHcfZUjwnbx
         vc5wikwgzFVRuzcEiP1+LupB/dWJZ5shuXU5V7GjRFcMIm08mpzJOv7EhbRLcRCpjtXW
         l2QLEAK7Z+GndQMfSw3QlEs3mNpP0FCVeinCXf6Yi8Kbi16kP7SSQHH7dkLhdqr6wQhs
         VE1LyK2Pa377E6owVoqEhMdyHu/ceT/QqhB6U3QgrTDf3Owt1nhZ3xD++EExS7OQ1uYN
         jvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729672923; x=1730277723;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgEgDyVyxHK+n1+lMp/O7AAdm5QoPSpJEhFz0fntFAg=;
        b=ZyphZCTQ/D9Odeeci55dJ7e06T3vFPTZucqhV3TVnTcHb8rjR7rnwBjgZOjwZIewJH
         3acDHXG/GuxjNOtNEDt060uP23rywJKCVh79X9WCebwTOIC/QAA8KOjvFxil4TpJ5o94
         spLofUC/fvVVsbc28CZxFitDxI/jsHOrff9QeSukfm0Awra7guIvv+9Xj4mLoAKr8Nyt
         D+xQCapytUxbcc+daE2PZOh+CXyrerizasU3wHLnr4KFnanONjBoMaaOZWvZyPMQq2sr
         FxFZxmXn3i1w01JdASiaiBU5R3BM47q6bXMlGTXIV1INjTF6tosV4fCIwaJyy3Mgf02F
         m30A==
X-Forwarded-Encrypted: i=1; AJvYcCWK6qryoO01BZqB9cyM75lVwqRAyxqmidw4mA7Yd5M4QV1nyJ3kyz1WcH4ih0WDAJcX9SKNsMwBhlLQ+0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb72/q7WTuM6CJb9kd3LgYfftwb+OngGkJzRy6rQiD5Smjmtyn
	3TdiLTUmzlsrOaDbQxA4dMl/ufkK+ExAC+22wXWSbHWQEvnC0eyD84VOLJJDLlk=
X-Google-Smtp-Source: AGHT+IEdJTPLU+KIutK3YvEYkbyMsNru7UMvkTH+o3ilss9qDJzDB/AM60d14OwM1KUZAzrdCjPunA==
X-Received: by 2002:a05:600c:5492:b0:431:562a:54be with SMTP id 5b1f17b1804b1-43184201b33mr18026225e9.9.1729672923367;
        Wed, 23 Oct 2024 01:42:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c1f86bsm9778255e9.48.2024.10.23.01.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:42:03 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:41:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] sh: intc: use after free in register_intc_controller()
Message-ID: <45ff88d1-b687-43f4-a022-4e07930cd2d0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

In the error handling, for this function, we kfree(d) without ever
removing it from the &intc_list which would lead to a use after free.  To
fix this, lets only add it to the list after everything has succeeded.

Fixes: 2dcec7a988a1 ("sh: intc: set_irq_wake() support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This patch is highly speculative and I am not able to test it.  Please,
review with care.

 drivers/sh/intc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 74350b5871dc..ea571eeb3078 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -209,7 +209,6 @@ int __init register_intc_controller(struct intc_desc *desc)
 		goto err0;
 
 	INIT_LIST_HEAD(&d->list);
-	list_add_tail(&d->list, &intc_list);
 
 	raw_spin_lock_init(&d->lock);
 	INIT_RADIX_TREE(&d->tree, GFP_ATOMIC);
@@ -369,6 +368,7 @@ int __init register_intc_controller(struct intc_desc *desc)
 
 	d->skip_suspend = desc->skip_syscore_suspend;
 
+	list_add_tail(&d->list, &intc_list);
 	nr_intc_controllers++;
 
 	return 0;
-- 
2.45.2


