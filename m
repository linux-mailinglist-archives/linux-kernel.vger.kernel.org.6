Return-Path: <linux-kernel+bounces-376779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BEE9AB5C0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2FF2830FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011451C9B9B;
	Tue, 22 Oct 2024 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQJAIGK+"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127FA1C9B7B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620491; cv=none; b=KQ6Vs4OwoSnplxvb99AzwpDuFdQucXM/ao/xKn/MrUd2Xx0Gd2fdnZOziNiEOG+Na7AU765kLc8xCIPGSlAcfTzi7VsyvAOnoYOYQnqA4zQYizyYrD7riiAPTO+fWRJmmvFBQ0J44KShRCVolLiusC5qsbLWlhwFJVHZEl3glu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620491; c=relaxed/simple;
	bh=Qfypyu1Nn2V+3gcNfw82SEJviEnlpQZXyb16muLLWlQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=H/LL6OvGJ+VLVXVxFlmAILj1TcaLq67O5kZLUdazEJLg2CsCwvFdICXZhMEBbtsFH8e/AQDCo4yoxFLi1UPtDR8C8u/gwUe0NNP6rdV1j53oq53/n7N0S/zFLZRS/2ZSsBHqe575xSvLvMxX/LtUUNrY0theoBmcv+w5t7Ivyr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQJAIGK+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a68480164so581054666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729620487; x=1730225287; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHKeAVy/sqJfWF1Y1uRllNLeoPiow2LfJ2lXuumLr4w=;
        b=hQJAIGK+20yttFQOGjB3wGdx/qYBIeMHziNo94hqI0yrTKSjTOmotvMxkE54tjgkfy
         4p4UieWBhm8KGLFiNuGj4BoEYcgMVhpQ/BA3L+BF6mWrbQbfi8NpXV6NFRP+hzSUb270
         QFYuboCtQXS38b5t+Jx1EYju6JBrbiMy2PlJqPrIHfp3i3EDAoAFDBMLjGCDv1CsReKa
         tp6xQiU8UCk7kozFLm3VDXkwkZS4OYKRAuHoKlwiKiGvtyXhfXOzSGE7BCWtOM84TMRQ
         9L9LPwY/03cdyUaysngEDSKz78ggAYscUTTKTCYaXJetA9dU0lQIRZqj2G2qsOy7FXGb
         Sa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729620487; x=1730225287;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHKeAVy/sqJfWF1Y1uRllNLeoPiow2LfJ2lXuumLr4w=;
        b=umUMl0XsrCUoglTHyfzRYUE8b9K1xvHPkWkXtzU2meL1pgKu8n2G7jJQTPgfSYdwMz
         QzZMrYUP0If5hfT2I6rLBxWeNK7irA6kf4XpfabjWwjbqBzg71y/ImxzEgrb9un3YszN
         95OMQeQZq0wvqtVc4Cm5PglBTwGV9n+SyCBq72hY6sGRrw8cpLgVQGhvmb1atLTzHJmh
         avr+sX7gE/BmUyZ1pc9EpkDSUBRXmVWT+r2XAoEG5VWryVjWNq25fkhwfpBSKmSzX3ao
         +RRtwasOxWH4HKrsmG+KYUhdGX/GwrwV+DgHrccvctNgpolh4S9S/w2BTlwASfQkAW7d
         yUHg==
X-Forwarded-Encrypted: i=1; AJvYcCWHLLgyNUCYQDwkc7RdQFgSfQMz4zMpnfEL3PtspdX2cJFqODHnAKU2/6ra/J4TXHm4Ua6ytDWqApNZwQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpaM2KzTXT3ubUVcu5y+WsRvrThkObD+etIeg4cAmBr15eLttV
	nH+UaFmuByVCMoQWxrvbPwybzS11emOYPDJJ50cTMw3ZLZ7e+ODDyNuKOrhl
X-Google-Smtp-Source: AGHT+IFZ57Kh6ofjTHGWKo3b2N/ZqJNgB4wtTTZHGGPhENJZf1bEnfOrjTuJ9BzbHBw+JSngk4k3XA==
X-Received: by 2002:a17:907:1c9e:b0:a9a:188f:efd9 with SMTP id a640c23a62f3a-a9a69bad2a2mr1529801266b.29.1729620487109;
        Tue, 22 Oct 2024 11:08:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:e0:9854:5800:84ac:8ecf:df7e:7d6c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6255sm376856466b.19.2024.10.22.11.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:08:06 -0700 (PDT)
From: Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	arnd@arndb.de,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
Subject: [PATCH] Staging: gpib/common/gpib_os.c - Remove unnecessary OOM message
Date: Tue, 22 Oct 2024 21:06:20 +0300
Message-Id: <20241022180620.12429-1-m.omerfarukbulut@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

It duplicate the MM subsystem generic OOM message. This patch fixes the following checkpatch warning.

    WARNING: Possible unnecessary 'out of memory' message

Also, this patch itself might teach to module writers or readers that they have to give attention to MM subsystem
even they interest another one.

Signed-off-by: Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
---
 drivers/staging/gpib/common/gpib_os.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index 6b12404efe7d..27654b2180a5 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -2093,10 +2093,9 @@ void gpib_register_driver(gpib_interface_t *interface, struct module *provider_m
 	struct gpib_interface_list_struct *entry;
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry) {
-		pr_err("gpib: failed register %s interface, out of memory\n", interface->name);
+	if (!entry) 
 		return;
-	}
+	
 	entry->interface = interface;
 	entry->module = provider_module;
 	list_add(&entry->list, &registered_drivers);
-- 
2.17.1


