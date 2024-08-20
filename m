Return-Path: <linux-kernel+bounces-293579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96884958191
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408BE1F21F71
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9E616C68F;
	Tue, 20 Aug 2024 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz+zbJyZ"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D718E349
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144433; cv=none; b=rvmDYZ/XXzrEFz8oKNFgO8ZN9BesJKwSk8s9cue/AsFpGWhX8W9H4YDD5zv9I1CAywCreHYX6bFX7g/deEgu1m4uIcr09icEP4iYZcWzUrkw0aMagWxxhIVRmaEUQ72cW1nNjjzasF0piDfPJvNWQl3OnYU8GgyWKA5A5707klE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144433; c=relaxed/simple;
	bh=wH4bh0QjC0XYEswTLII2R9xq/oNU94FkQihIVyLujwE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=B40ALrCiPWYl7WTIfa0/LwwsfIdPIIvDmxGKYArok/8rf6t30ur/t93w4ZnKZbzLik5Ga+bq6UuwMy4A2xwGfev0BuanRE0EubCX9MXmuVK6C80YKawLNxTgHzYXS/XXCGOClgF04sYH0uDX0ewxQGwGOzMK6vdkD6n6t0G3cPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz+zbJyZ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso60663341fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724144430; x=1724749230; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PyY1LhSQ8D3bjJDDyqGfsvY0xd3/fs1K9yFTOFAX8Y=;
        b=lz+zbJyZvJ0OB0mLTr7NSC8UYn0/XHrGAmTikxtllQ1L2TDnSoYvmLd3qucUmoK6ov
         8tUF6FVW218WOayWRKHlj+r9U8t6mr4gmiZ3C0FV9Qu2RzcZwhLA969/IzLQgeXzVxiy
         W6rAEYyUdpz2S5W6zrR89EDuVgw98Amly9BJtaOfrE1MY2W6Ts5dhpLqkcGC2J5UNKdJ
         tLATZbPASW2QsxmvzhM5RvM/Eh/lTPhtODYG3Lu7P3KJrq2OnTfa0wCO7wPLdiYmrlrh
         wXUgL9403U/9cGaTVb/4PR0VT4bsjT6XnFqXnpc5tBBC2WVF9+cxXQqEbElGiilwfNPb
         gR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724144430; x=1724749230;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PyY1LhSQ8D3bjJDDyqGfsvY0xd3/fs1K9yFTOFAX8Y=;
        b=qzOg8nxvhwF0fVuxxuA6yyN7SyfZgBYNTolkS7kGzDBnHLyk6SA2uO8kKnpfGoiTIH
         djre8aIZZyuupArReEf4tf7b4S4GAO6v9z4SeifEKAnLs9XPrLXtBpiYQBijPwF2Udxm
         kM9ORLpuYSzdsGDIkL33fJIB72Ejv+G4f1u65d91ZIIiOnYtfzO2zS4fVgyxwxoEkfO4
         12OZQqEimjjkYdpd1ykVnU/OyW3FYnGhN2uUpmoEcwCVNHm+OWbxuDpzoR+J8K5uPFA1
         eaPDtM9Yj8tEu0PMrxG5vpjUBT7nrM8MYRdEdRuCBzL2BaFcUw3ZsNNAtnpp7BUjW40J
         VXRw==
X-Gm-Message-State: AOJu0Yy1GwDF6UJgbzzr9i6cSbpN3G4UH4NJnZBtQw2zws8zrluPto2L
	H/8vWZElUX9lLikJJVweyWf6s+nsr59ufT3NLvnr7VmV18F+pLG4Yu/dHQ==
X-Google-Smtp-Source: AGHT+IFB9C8RrY1ZT/EB4HS9ezcDq+mbWFIiwaImt2ZCvBbVfl042SSQJG37KuBR0r4i2bRbvRTFtQ==
X-Received: by 2002:a05:651c:504:b0:2ec:568e:336e with SMTP id 38308e7fff4ca-2f3be575a3cmr93662921fa.1.1724144429224;
        Tue, 20 Aug 2024 02:00:29 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bcd4:8c00:e1ae:e834:c372:a0ed? (dynamic-2a01-0c23-bcd4-8c00-e1ae-e834-c372-a0ed.c23.pool.telefonica.de. [2a01:c23:bcd4:8c00:e1ae:e834:c372:a0ed])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc081c59sm6588691a12.85.2024.08.20.02.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 02:00:28 -0700 (PDT)
Message-ID: <bd5221cf-2071-4be0-97b1-00a681482a5b@gmail.com>
Date: Tue, 20 Aug 2024 11:00:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] driver core: drop __must_check from driver_for_each_device
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are several users of driver_for_each_device where the worker
function doesn't actually have a return value. One example is
__igb_notify_dca(). This results in dead code just to make __must_check
happy. So drop this annotation.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/device/driver.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 1fc8b6878..aed40242f 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -153,8 +153,8 @@ void driver_remove_file(const struct device_driver *driver,
 
 int driver_set_override(struct device *dev, const char **override,
 			const char *s, size_t len);
-int __must_check driver_for_each_device(struct device_driver *drv, struct device *start,
-					void *data, int (*fn)(struct device *dev, void *));
+int driver_for_each_device(struct device_driver *drv, struct device *start,
+			   void *data, int (*fn)(struct device *dev, void *));
 struct device *driver_find_device(const struct device_driver *drv,
 				  struct device *start, const void *data,
 				  int (*match)(struct device *dev, const void *data));
-- 
2.46.0


