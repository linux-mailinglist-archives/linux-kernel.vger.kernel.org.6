Return-Path: <linux-kernel+bounces-321516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A13971B8D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746251F2301A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463081B6549;
	Mon,  9 Sep 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/ITHpSh"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B891E507
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889788; cv=none; b=ci3IAQD68UPY/oXKnqm7Hi9i4moFHS0o9XKkfasL5xwBcScO+pw8ju+WzTPLZY4A2R/Q+nDA1aREqh9zfSlDMvpz7FPKZuw8dvnj4523Yvwxar2T9j7SbyqO1VYP6blmWwRWG5oHPyW4O1o76a+8HNx9Wp5XTKKHhatDya4nLZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889788; c=relaxed/simple;
	bh=x8+GxYy7sDFaTgzJ+dGd7agnmfFyVRYJW1KHjgaXmig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hSkBfSHHL2OYrH/tz4GAwxuhdjXFhpzd2pRA3uPtF85yzVmZNL8QOe73Wd5U+JmXWjeYvO154uhLYpsHwwMqXavWe708fj9CFQjoWnytyjTg2Lkv3SYxzC3gfiJXLFpkMubDUzipmT0pxWnjlJq7zLS2PynZoCxzLPz8umoQIzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D/ITHpSh; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374be2ad12dso114248f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725889785; x=1726494585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4KVfpyRcERzz2i1as450oYxAXUetUWvBqg/ooNWbJsU=;
        b=D/ITHpShIPLfmgk1G7wtcxbXvhDadQH+j77tuCHBAISB1bEgjlhjT17ZXxUJYUsdkF
         uQNjYE5ZdE5EUm4Z3uAjym8j2hJYrLOBhyMNXr50eHEYOTICB+lbGgf2n0Y717eg/EPn
         V45sZXRhT6PhwI0ILA0bPkwJojr4hHC7gCjf9o7mXU+FNcPlGBNa40SVQcE8dWT+EsrK
         U7iCTAOCDhn1h5WdSpM6bDjWAuzyzZ8oq8iXyrKRkYDxPzmx8ZdObgX3QnbSJccwrwHf
         mS9vzPvibfIShEi3+pD01gHSsX0Qk2LxO7mv5wU0zBnJClGRuEku0WWWkJD/Aq4VMUsF
         PjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889785; x=1726494585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KVfpyRcERzz2i1as450oYxAXUetUWvBqg/ooNWbJsU=;
        b=rUY7qJ1Qq8MCeqq+Zm5HZhR8ikAxkTJwrMrXP+1ckUY7p8VH71SmePgkwazL9eXI8j
         L4Fw7fV8ZFHupO/Kr7MJgQxd4MKzuvWN4SWUKjsu+4X4YWwzJAwSxfkCli+JF04XNlAU
         +H9GnW8f+T3s/Q0111eLpfntLFW3yHm25iLI0M1uqm8+vyWx5G4dChMz9wrZxRjjLUOS
         w4Out8RxpK0K/X98c4ZNymHa1Tv4VJftqta6Mlk/nYobdN8enYIbs5shmi4CB3jH3Bb/
         5QsXqvhqRVzXm+qHwChsMfs59quNonK8g2QzbQ/kaN9cOywHT5KWCdNfyMNdH8kgU4F8
         gySg==
X-Forwarded-Encrypted: i=1; AJvYcCX+3aPCHROasO0ItqsrGnOXaSbnzsqcQqfOZfBQLLQKX1eG2gTjzLx2BQHxk617wZFeP7wP/rHjJAXBrKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFEPRp//a/EU2eu0DAX4gbN8FAPpGzZRYLXje6cKZ06IislF2x
	XhKdOHVIuO3973g185fRxd60+wPURhx/wA+jSNtgSJ2hweT0v/g6oQbQC5V+jL3q+tAX1wXwWgN
	T
X-Google-Smtp-Source: AGHT+IGRjcW4tECdrmHTv8f8eN00jirEkEROrA2rDEKcNZVVnzYdW05edwFES8ojRpaMwHiha03JWA==
X-Received: by 2002:a05:6000:18ad:b0:374:bfd1:a786 with SMTP id ffacd0b85a97d-378895de490mr3542682f8f.4.1725889784651;
        Mon, 09 Sep 2024 06:49:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2595122asm346196466b.65.2024.09.09.06.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:49:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] mfd: palmas: Constify strings with regulator names
Date: Mon,  9 Sep 2024 15:49:41 +0200
Message-ID: <20240909134941.121847-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The names of regulators are static const strings, so pointers can be made
as pointers to const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/linux/mfd/palmas.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index eda1ffd99c1a..dabcc0dea802 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -98,8 +98,8 @@ struct palmas_sleep_requestor_info {
 };
 
 struct palmas_regs_info {
-	char	*name;
-	char	*sname;
+	const char	*name;
+	const char	*sname;
 	u8	vsel_addr;
 	u8	ctrl_addr;
 	u8	tstep_addr;
-- 
2.43.0


