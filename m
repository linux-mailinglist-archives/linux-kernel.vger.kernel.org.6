Return-Path: <linux-kernel+bounces-395643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3CD9BC0EB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294251F22C18
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC291FE10E;
	Mon,  4 Nov 2024 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1RWd7Bvv"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE091FE0F4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759298; cv=none; b=GMMBEX0Vzco6V1YuZRH/kByyYanRyBtV5bacWDuUfqDEqB2MSRyiuZABaXgTb/oRselQslPlKfYLvPTHY6GeEndjAYtnE8up5r4QECjkYObp9KKFCPqqQaCMy49ubmQbW/VVVoVo9ZFYcKWbL3iZEPI/NxFC2/Tfyrwmp4+0c9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759298; c=relaxed/simple;
	bh=jS3VhDQe0RHXucAy7fChPZMlDpJINb08hArPK+wtgmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NoF64uEdGhhbMlaiRutZkz/4nKUFliCeNtxXEvcm0lAkWwHE4vo4RjNx8cjGE0OQ/DJvyPRz8e7vRgY0F3Wpw7kHmewwfD4tlYQPWKRoK9y+MSPRDipdt5sLoDQWN1n8zqr7UGCUxa5eg8Ks7V/DQJ9sYtV7GYqi1h4NZzkbtww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1RWd7Bvv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e9d6636498so92887367b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 14:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730759296; x=1731364096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1YSqDn0sbFO9SXEJcmAUmq+AuYyNB6VQvHAGKw4UO8=;
        b=1RWd7Bvvundou4AKtP3w4KX4AnJF8pVzjJVliEC9YSRGHDjeWLkeIEvfd8Hcn9bS/A
         MtGwsRfSkIrDT1cIOvzks70dr5M6kQoF09O3epxCRzVmZFQSNRf7iS+I2HUaO8mUSlcE
         cfGFi8UPMKFPWBXmbvfp18g+ueZ1hF9eWsMWAdC6d/u+hG/x3cEFtDTJ1twnqgZ1SNNU
         t13uWSlaG8Rnw5OMa+hzs2xqbrGRZ/2L+G2uU8YUfXI8Br67pZeLfct2EXAup1FgRl7W
         Ux4d+80gbICiMzZ6uAmW1XIoPcocX4bYVZjavMccepPY/m40eyYCng9XdbT5Kbaf/pFo
         xP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730759296; x=1731364096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1YSqDn0sbFO9SXEJcmAUmq+AuYyNB6VQvHAGKw4UO8=;
        b=CVEiMrXDmjJLKiuAM6zpA7OZOSGzP46dNxL7xqF66bPDVZA4bGpmSQP6UF5FUHhBFA
         oVCdzHCpcvp84pAQhZabi2qRJda7EzllD0TMKzpY1so4CDTrDdQE0L4Yx179PfgwKDWs
         KIrrvrekMZlIs+fWh6FngboHm/9Hn8cU49Ckw00IL4M3e1qUkacs+l7kfimYXs0uZAVz
         d5/IT+S5fLPFCZnASnwxOs94taj3yqb+Bl7qHzezHL/P8fosxyVdTSz6PNgRnxAIv6ri
         kPTRdoq7jPOOlyCpwSaetXoud2cmSmpKlOYvXop3jdkkMXvyix2zP1qdRvTUPdhmzQUY
         yNLw==
X-Forwarded-Encrypted: i=1; AJvYcCURoIdmxqTN2hH10zzW8tcgWycbr2lMqUEpZePvdhYemERUzg43az/kAHZ+xAtqSCTFdyl7/IdIkfm3Nqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhCShra7yLyyA5l669BRQr2j2CqGEKiTuTRr9SjgGH7Fqz2eFM
	gLbBGXsEP8RfFztR+hOWJl82Ox9wb5iERSQAPfsrbQokdjWIYstiy4s5L3yTeftSMeYJmAdN39w
	j+jJyLaywDA==
X-Google-Smtp-Source: AGHT+IEwJ6XoH9jYvE9XepfbYW66gSHe6pDYBUEJ6j7mRhsOIIUs4LZTeXXSxAJhVRpRqXv6MfH+lzcIHJo1EQ==
X-Received: from kerensun.svl.corp.google.com ([2620:15c:2c5:11:2520:b863:90ba:85bc])
 (user=kerensun job=sendgmr) by 2002:a05:690c:802:b0:6ea:1f5b:1f5e with SMTP
 id 00721157ae682-6ea52518ac3mr273147b3.4.1730759295937; Mon, 04 Nov 2024
 14:28:15 -0800 (PST)
Date: Mon,  4 Nov 2024 14:27:37 -0800
In-Reply-To: <20241104222737.298130-1-kerensun@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104222737.298130-1-kerensun@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241104222737.298130-5-kerensun@google.com>
Subject: [PATCH 4/4] mm: Replace simple_strtoul() with kstrtoul()
From: Keren Sun <kerensun@google.com>
To: akpm@linux-foundation.org
Cc: roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Keren Sun <kerensun@google.com>
Content-Type: text/plain; charset="UTF-8"

simple_strtoul() has caveat and is obsolete, use kstrtoul() instead in mmcg.

Signed-off-by: Keren Sun <kerensun@google.com>
---
 mm/memcontrol-v1.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 5e1854623824..260b356cea5a 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include "linux/kstrtox.h"
 #include <linux/memcontrol.h>
 #include <linux/swap.h>
 #include <linux/mm_inline.h>
@@ -1922,17 +1923,15 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 
 	buf = strstrip(buf);
 
-	efd = simple_strtoul(buf, &endp, 10);
-	if (*endp != ' ')
+	kstrtoul(buf, 10, efd);
+	if (*buf != ' ')
 		return -EINVAL;
-	buf = endp + 1;
+	buf++;
 
-	cfd = simple_strtoul(buf, &endp, 10);
-	if (*endp == '\0')
-		buf = endp;
-	else if (*endp == ' ')
-		buf = endp + 1;
-	else
+	kstrtoul(buf, 10, cfd);
+	if (*buf == ' ')
+		buf++;
+	else if (*buf != '\0')
 		return -EINVAL;
 
 	event = kzalloc(sizeof(*event), GFP_KERNEL);
-- 
2.47.0.163.g1226f6d8fa-goog


