Return-Path: <linux-kernel+bounces-376338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E23ED9AA372
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3416284021
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DD819F42D;
	Tue, 22 Oct 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pvDyL6gc"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D12619EED4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604500; cv=none; b=V8pN3/l5ihODOzlcelZapI6vQsoMfGkuGDG+GeFhfKhlJmnd0vSfOS8BWYe407AEjY3CF5roEkw9h3OE06z7JIIM1k0DADE1baeJlexYnSGMsMlkTGUE8wjxwVbIuGITu2aViC5Ph8q+7IiYVBGjB+RwwhBtTcxHcz4t7DsTjuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604500; c=relaxed/simple;
	bh=X8QUrToiMxnAfjNdFDrnbIVNa9xpaD9bvegFVywWIsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pq+5IRCklKv7e4VlHcrVkUJeaN8pTJqQGupz9JpPBMpfsoycHZK0E5gNiHgwSkl0JLGcD7M3832OlnciDioUaUe1Qcnw88iFBgMictka0pTC1+flBlSp9crfbILys8/6Id3UeUYqnLgkfK7FGYwCpYI9NO6iXPK5dlU5KMqBIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pvDyL6gc; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539fbbadf83so7367706e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729604496; x=1730209296; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f306HhQdZye6c+W6kel6l8M8FTFkMQEoDZyNH+xtfTU=;
        b=pvDyL6gcJo9aFLkagsWohZCDpH1Wn2AWl8K/Vb4NbINL/Abjb9jVp8Mn+fNblnJMI7
         DFY1p1VEaTFAQXtrlijqibWkVDBz+LF8BrxOmMxCjF2SyUIhOH2MilBMi4SHQZwBufnZ
         wxxB466JPeN22T3dmB1CaYygCA4mHGdiEbldxP6C5VqCQqUvvzgQHNtbVwedJXe4uL2Z
         9dkAYznp/90j4iFK7AkbaY3HIvxGSEgZB7aTAPgGkrBw5eoLgVR3mnxid8Recnh9CHfQ
         kiKry3b5X84tXkEzwZ6WeUD3gaAI5CXPQz6C3tvB7znstgq7HjOrLHnXV7ryuPb3673L
         ZpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729604496; x=1730209296;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f306HhQdZye6c+W6kel6l8M8FTFkMQEoDZyNH+xtfTU=;
        b=q1xIYzbdnWH7Mjdv+HFzWiWO6p6xJGQarrhHjVqG0Q9oCLrKE28o3XNjxrLhSd2QCM
         lLfiPwlVmJXbeIQN0reAkrRTw8BsqKgox5J3cYkYPKOwmNWERybI74jbOib1Cc1UNUYP
         yIWa+Isy8/VQb3KSKqEbTtgEvTBhIEHgV+NCgD1+W/1ryaCRLw9yS5SXv72S4hyP7AlY
         k56UziblQMY8HIwKNXcYOJup+cYXSm63SFAW/ywd7p21Q9CgEG0uuDIiYcKUzRwDkwbx
         ET5dvOA5/9+xjZooyy1eRCdj07M+KhG+kT6V3y5KlaTqg2PkYmmmgF2qZToDO/1qV5Mj
         0MVQ==
X-Gm-Message-State: AOJu0Yz7MvCSvk8zWaLpkDGy+/n9jbpWHAdQwKwm/gpxIc2VCNHDc+Yv
	+pgBczR6AKRVDsUZcNzE68aZjSJ/GEprXNeNsB1IR6ittOKo+JzszbPOud1tpRQ=
X-Google-Smtp-Source: AGHT+IEMpe5F5jbKT5zWYIJsMMvoyMYjSPQ5c3T4HS39i7Um8wHXFtH1LSOKGNbeYRvYaIsq5B8GNw==
X-Received: by 2002:a05:6512:3c81:b0:53a:aea:a9e1 with SMTP id 2adb3069b0e04-53b13a3a251mr1517447e87.54.1729604496106;
        Tue, 22 Oct 2024 06:41:36 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e551fsm771702e87.57.2024.10.22.06.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 06:41:35 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 22 Oct 2024 15:41:34 +0200
Subject: [PATCH v2] seccomp: Stub for !HAVE_ARCH_SECCOMP_FILTER
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-seccomp-compile-error-v2-1-c9f08a4f8ebb@linaro.org>
X-B4-Tracking: v=1; b=H4sIAI2rF2cC/4WNQQqDMBBFryKz7pQkRmO76j2KC9GJDlgjkyItk
 rs3eoFuPrwP//0dIglThHuxg9DGkcOSwVwK6KduGQl5yAxGGauVajBS34fXikfwTEgiQbApfVk
 7a91Q1ZC3q5Dnz+l9tpknju8g3/Nm00f7z7hp1OgbN5BVyqlb9Zh56SRcg4zQppR+a8jofLsAA
 AA=
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

If we have CONFIG_SECCOMP but not CONFIG_HAVE_ARCH_SECCOMP_FILTER
we get a compilation error:

../kernel/entry/common.c: In function 'syscall_trace_enter':
../kernel/entry/common.c:55:23: error: implicit declaration of function '__secure_computing' [-Werror=implicit-function-declaration]
   55 |                 ret = __secure_computing(NULL);
      |                       ^~~~~~~~~~~~~~~~~~

This is because generic entry calls __secure_computing()
unconditionally.

Provide the needed stub similar to how current ARM does
this by calling secure_computing_strict() in the absence
of secure_computing(). This is similar to what is done for
ARM in arch/arm/kernel/ptrace.c.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Call secure_computing_strict() instead of providing
  a dumb stub for __secure_computing().
- Link to v1: https://lore.kernel.org/r/20241008-seccomp-compile-error-v1-1-f87de4007095@linaro.org
---
 include/linux/seccomp.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 709ad84809e1..341980599c71 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -32,6 +32,11 @@ static inline int secure_computing(void)
 }
 #else
 extern void secure_computing_strict(int this_syscall);
+static inline int __secure_computing(const struct seccomp_data *sd)
+{
+	secure_computing_strict(sd->nr);
+	return 0;
+}
 #endif
 
 extern long prctl_get_seccomp(void);

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241008-seccomp-compile-error-83f367447d56

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


