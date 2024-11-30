Return-Path: <linux-kernel+bounces-426173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978979DEFD7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2CA2B219C2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98155156225;
	Sat, 30 Nov 2024 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3GBR9rd"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585F1537CE
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732961283; cv=none; b=uHnF0mVWkuc0QMhw4m2/rh2JyH6O7NK6+WUVfsMaPMGCNmFFeM3czJgQWj/Eg+/L0JJH1KFTzOLahGmq68djvXSNDJmjUwjq36HnFf03GI924fQkuPzXbkoR6rYSR3ipcfkAa2nJue/BQ0FijrpZiPj9u+R512a8RSG2HEziIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732961283; c=relaxed/simple;
	bh=7zmpFrkNE9b9fiTObZOVjwcI3iZNrUR2CLn6+i8hq2o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pJwcJCR2Sn+vBoQHRV9E0+9+Fi8pJyuQSvXo4hst/gc3+HSYDsDT4Vc/frNBusfRPC+pr26imwtdwF1CME3r5XITwcUeMNKcZ12zkUwiXAsz8H412fIeOce1IYp7/6xfqAaPmVxuU1KiEqsJEDfTrbVTd2NRNa1a4T/GerDK9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b3GBR9rd; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso361149466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 02:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732961280; x=1733566080; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bF1qKdUD6G82UToWOeQ2OIejZEXXxD5wyzBbKqaeajo=;
        b=b3GBR9rd0hyfCgYKbu8TnWR3qKxYGOMQvNRF3pPW54jLcHrFjMguPv5NyYyQOP/YDm
         xS1dSKvt+9R/eR5S8HICejlOgGrg3re5qSYaL0q8UW9qmQNmxllmN1YcAEP3qHENpyQH
         wtFEK6EJmi0nPi4VAVQzhJyVXj6cK9+e4yCfq0eNHGQyBIUWhrTiA4TZx1E50Puvuyqm
         Hc5hO/jiXVBPKMBe5EBA3D5G/sNkyeHn1qALIuKFAW+NtTiZ/13P0b0jKei9fEPxKTSv
         ET4wwN1gmBSt5AT9FUTVpAMrMVG4RqqC1cq3D3k5B5asl4+ABWPuQje1Yh6MyZDfwdJH
         VlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732961280; x=1733566080;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bF1qKdUD6G82UToWOeQ2OIejZEXXxD5wyzBbKqaeajo=;
        b=GDG0EExixBoiR+btXwGKfA7vuheoclqk5gOYIKMeyFFcGJAFXSU16f/5pvFyambRCx
         H6/V/deWxsp4XRjrPyVBQ49NCJ+v+/nyERNPzgGWLBypzbYW5uNKvEKkWrYwbzXG62Sa
         U+yanabcaHSyKD5EO7oFiqKo3X6zD/dJpMq/nT01rFFeS5ZnZthmkweOIEbiA9tS6rEp
         ojnniKOe6i2Y/Bn6DjN1bfc4rSl9rjTTo9G03BtAQrUz9Y6Oiel534k+6sok5fszni29
         ejwdyXwXBBI+P0wwndOJzPtvQLYA8Ho2hsYHBDkKKaCFYKua3xpqPy5YcuYFC4LDGYo/
         oiqw==
X-Forwarded-Encrypted: i=1; AJvYcCWdHiLyzPlfJ/jQumoUZ+I/sgihkj6IRnrWPmPuosw+3K+hAYhb81flzrehft69UAg1G9oAHU6RBdfC970=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/BLFSUFPmlvdO5BnX1JtFqY96+9uUZVf8n3vlmr2Q7tX2SZS
	EOBOZ2oNRrA17R3hCh7lMSWbmhTBDhOA99GgCaIdryBboElxuHf5shKWzWZNiRI=
X-Gm-Gg: ASbGncsTLXLFOLYfH1DCT8SjJKZ8Dvfq+4kUqb8vkZuV/hcpazTXvW6+7HYO2riuQaT
	5ZsWG0X15aw+Vqqv5T8M8zhPYkuhp65LHuHRjD7eeJeDPntVh3gUZJ8PQx55TN3xnpOoT91+97+
	5NKhLEWP7mz4vF/0u5McLolyLdltAvrKH91mY1arU37sCc0/CxV3hhv0hC+t0p95k1zhmcVbt5a
	7ioWX2D8RtIjLzjBNe9vEN70xz1sc1rEs/HJGTWfq5uYdr61E7kFSFlRnyIKk6ZMF33e32Q
X-Google-Smtp-Source: AGHT+IGFFkuSzUzBV6MpzgZNlz2YgAq3cRPDWZKCNGkjjw0xQWjwQCZY0kfL1J0lIP1VbayZcSBWxw==
X-Received: by 2002:a17:907:7819:b0:aa5:b2b:f236 with SMTP id a640c23a62f3a-aa580f353f3mr1240877266b.28.1732961280003;
        Sat, 30 Nov 2024 02:08:00 -0800 (PST)
Received: from localhost (h1109.n1.ips.mtn.co.ug. [41.210.145.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de7e7sm264394866b.71.2024.11.30.02.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:07:59 -0800 (PST)
Date: Sat, 30 Nov 2024 13:07:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] opp: core: Fix off by one in dev_pm_opp_get_bw()
Message-ID: <41ae307c-f6ff-49fb-a962-eb488152de71@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "opp->bandwidth" array has "opp->opp_table->path_count" number of
elements.  It's allocated in _opp_allocate().  So this > needs to be >=
to prevent an out of bounds access.

Fixes: d78653dcd8bf ("opp: core: implement dev_pm_opp_get_bw")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d4a0030a0228..09a1432561f6 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -121,7 +121,7 @@ unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, bool peak, int index)
 		return 0;
 	}
 
-	if (index > opp->opp_table->path_count)
+	if (index >= opp->opp_table->path_count)
 		return 0;
 
 	if (!opp->bandwidth)
-- 
2.45.2


