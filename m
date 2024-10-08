Return-Path: <linux-kernel+bounces-354801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA309942C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D7B1C244F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554BC1E0B89;
	Tue,  8 Oct 2024 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RL9Oo2B+"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0384BB676
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376188; cv=none; b=KFeiBBWvo7honA8t68bR0Jd+VKKRJuRrmE1PULOHqBokjfCWvk44Q5RWLCXJWtjPWKjZNZzQtuxn4wd8iq6Hh+FizmUb4EbAUTeWg2m7klIcvEgDs1RC6WM6ilOZkyPfI0jfaHPrq/Jd3V3teNYcUo55wLQDLAfCCnl7fLda1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376188; c=relaxed/simple;
	bh=m/XEcvwHTxJAWn1U1FuEu3LLLcnyFZaircoEyB+5Tv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fs/qW94XJLxJ2SJ5U262TPok0hyQq/8iiLTbGNY+Pe/gtJ3G0hOI5tv0BqG5VEZee/uxpzuym+jsPWALwawB5P+KySp6XAZGPuRpN7ZIIw9sEUEii5Ph8Q4QHIQnN1wswk/ilEmrX27+BYbZSXd+7JJTK4wFtR1v15lpBwOjQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RL9Oo2B+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9944c4d5d4so306173166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 01:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728376185; x=1728980985; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8sDzVM19OHk77GUwZfO9VEAo7ny6iI8b6MTTXOkwQY=;
        b=RL9Oo2B+qodQHMzJv7MRRO6eAymcKoK85S6B/ydBoX4+Y66JSz9H+Tlu1Sdh3Unp83
         IxdW2RVYpa8iLdeGUB6cUH87juztjQ5NaaZN6MSYuz/oow9RO6/MO0e2YaZSlf23HHoG
         vT+u5suFtqLCQV/3J8S8crIj6Nhg+6uAF9NrIvKD/L9yrBLG9QnkWiBsCsN4Go1WNSII
         f1L40AMUCjQpeDWGEcdLsSHOTU/CJcthG9ZwLRQeUHKKvsCw2WtQlV6ket5zfLM1h8NJ
         WgSKG2YWxR79iWd/p1WaAF0qhgNFuDonfEtJMNWY7BaDfjS8PKNo4o58+y7kq5U3Mb/t
         PGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728376185; x=1728980985;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8sDzVM19OHk77GUwZfO9VEAo7ny6iI8b6MTTXOkwQY=;
        b=eYFkTMHzsD8tkM5XyDj6Jqypg2/8CrFW8tXvUG/ixUWSDyTvmgf/8i0+3ROgrfsZwk
         yGX3VvreoeuNgeJo//DsmtDOmbLstRIGrHLnBfoNkZ7qgugTDw4/b9LFWyf5kA750ByX
         5Mq7mdFbvJ6iyN+J+sE3KQmgZLCw7DXREqxv6P/GX53DhzNwnw966TVpkSfSvL8Zfu4U
         XPF/Aj+Fk/eVIkAnHuD51ka55AY9fqT6Lp+I6Dy6wBkG0mdV8T0/VM1WY+FJYBL7yYYL
         DSxFhKv3K9EdoGMz63R7i03h7JWbBBIsk0euVYg2XJQUPvh5gU1RH3NbVDcd5mbrgjhr
         9/GA==
X-Gm-Message-State: AOJu0YzTnJuTirY/L/W22vg4kns1c/KMGm8F3bKmoXxlxfCJmwAareXY
	YGDAqnW2qb2iYH7+fANTaxdIbAhibb/lxFFG0oZyCkTiHj/4JFTMTRheNBO1VUzXfW6FLF2Ropf
	H
X-Google-Smtp-Source: AGHT+IEADtw37ojM3x6368/FEP4lL1YlBCStuf3dTs5a5/EryKzIf2+NDVdopAaIc4OSRS83AHykXw==
X-Received: by 2002:a17:907:6e8e:b0:a99:7e19:fd7b with SMTP id a640c23a62f3a-a997e1a1960mr24453466b.52.1728376185211;
        Tue, 08 Oct 2024 01:29:45 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99497e7975sm327963166b.201.2024.10.08.01.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:29:44 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 08 Oct 2024 10:29:43 +0200
Subject: [PATCH] seccomp: Stub for !HAVE_ARCH_SECCOMP_FILTER
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-seccomp-compile-error-v1-1-f87de4007095@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHbtBGcC/x2MQQqAIBAAvxJ7bsHKUvpKdAjdaqEyVogg/HvWZ
 WAOMw9EEqYIffGA0MWRw5GlKgtw63QshOyzQ61qXSllMZJzYT/xA2+EJBIEbTM3ndHa+LaD3J5
 CM9//dxhTegFwAN33ZwAAAA==
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

Provide the needed stub.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/seccomp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 709ad84809e1..832c612c5b54 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -31,6 +31,7 @@ static inline int secure_computing(void)
 	return 0;
 }
 #else
+static inline int __secure_computing(const struct seccomp_data *sd) { return 0; }
 extern void secure_computing_strict(int this_syscall);
 #endif
 

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241008-seccomp-compile-error-83f367447d56

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


