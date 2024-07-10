Return-Path: <linux-kernel+bounces-248217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6F192D9FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27305B2297B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E8B19645D;
	Wed, 10 Jul 2024 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="rYxHk+3Y"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B982D69
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643100; cv=none; b=RiTCV9rnV0dvzZl/V2+0h3vabaTyYhha5DU5DimUnsxeMLqKnqXL5AstVrl6MjE48bQHPpO1QaHMIh5lnGHL0KWEETMkfxbYYm07s3spiBiZEqGYfiHemlujspYckzNJVnkrJUaHdf+3RrBIx6jE4tjdkE6ZGq8t+8/S13/goIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643100; c=relaxed/simple;
	bh=33dnCjGAsbtQoFz+aqoLLk+FxKb2FGiVWUE6UqhV/gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5OcTnix9hghwHSfE2O02+1lGX1wv++N1mGkeygdKslYEO5kI5QYmMYIBAP+4s3h0fUUnIn+V/9UiuBwwJI6x31JV9PLy1V3x7g7cKXu0MCckgE6+LO6EkEf3b+Rm8canych0261yLgdIcm/x20Hpo2Qpszyp8AvhhSwxKfxuaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=rYxHk+3Y; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36798ea618bso61311f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720643098; x=1721247898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ehEDACZEo2Gb1GPaaV18tIUSiXICGHsIvIVpWT2aMEU=;
        b=rYxHk+3YXHW+cOaooVUXV0/Hvpsa7I9mT8SU1F0x8FVcTSb59hcEZABsOwstnUaUW+
         6n/a5xEg6gYgcJbn2FzZE71fmAqTUhCNO20AanJnRK0cj4/o6I9AywvGuQ3QrDXLZXan
         tfxIsexpFChJiZ9WST+iWmgsQ+06PZ8VQRXqE//e1Kx6I1NVVgohaSUBRbNnfcne6rcG
         CnRpWaXxJE8C70owFtO2uR8jRqSmHwk2PPg1WR0+Nle+t7LZBX3A6TDC+dFrEga0gaVU
         JfDjI4+kTFxB9STGuSWYtlA7WX5LCkLxUxM0TKsFCVrRwkvqoPZGONJNgjkfOXQ/mjBS
         UoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720643098; x=1721247898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehEDACZEo2Gb1GPaaV18tIUSiXICGHsIvIVpWT2aMEU=;
        b=wZPeOF4vXXR78iWxIxweFcb0Rjxq6612EOLCAAOZnGCi5QSyGHyc5IkOXRY8suoDb+
         DtCDe4AIOkYTrDHTv111rjQIC7FJq/4DAYSTFPYsJbdrwHAUpaE5GEQVHf+v5gVMpRVX
         6BZaEd0PGUQpjLvN2USo/PtDn9b9QXpz9lP4qDnqXKxrfJWROI2Jwt5l8R6ngMETTFi/
         9Uaf9BwHUGaW97fXMw3NG/aGR5lM9bCV70dVbmOIonRP/sR4tS0cS7d72QBgZQ0ZKluy
         ilI/0mjzSsbQewJ6rk3yo46M/dm5lmyg/zG+vD0hbRVQFVdVUXgvEoyeZ/ZkSamnTQk6
         iuJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2h0tZ286dlBX3057lqEPpacPbHegtXdl/Dam7s8an1GaXOV6OYqHdactaYsQI7OHVaNvbRy2LvB7UKVjh+9NR4rUeptCwtjSsB8s8
X-Gm-Message-State: AOJu0Ywx2BrblMHTQfLfkQHnvOCOIMobGfWNw3kS0c11UjPVJUCvl5k9
	L51rxq3f0GFSt/nG4J6L7iyjBV7zE57W47EV1hJIxwXeXInt23gCrSGiVuOEB3Y=
X-Google-Smtp-Source: AGHT+IH3DrwNuEFLAz1IaTtJw8NWddd/qu6YiYyy8h0Cxg/Zcp3nFmbvLMiWqFgMx9D5H/V4gSvpFw==
X-Received: by 2002:a5d:5f85:0:b0:367:f0f2:66c1 with SMTP id ffacd0b85a97d-367f0f27ff0mr441185f8f.12.1720643097692;
        Wed, 10 Jul 2024 13:24:57 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7ed52sm6175423f8f.6.2024.07.10.13.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 13:24:57 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] riscv: Remove unnecessary int cast in variable_fls()
Date: Wed, 10 Jul 2024 22:24:18 +0200
Message-ID: <20240710202416.710880-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__builtin_clz() returns an int and casting the whole expression to int
is unnecessary. Remove it.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/riscv/include/asm/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index 880606b0469a..71af9ecfcfcb 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -170,7 +170,7 @@ static __always_inline int variable_fls(unsigned int x)
 ({								\
 	typeof(x) x_ = (x);					\
 	__builtin_constant_p(x_) ?				\
-	 (int)((x_ != 0) ? (32 - __builtin_clz(x_)) : 0)	\
+	 ((x_ != 0) ? (32 - __builtin_clz(x_)) : 0)		\
 	 :							\
 	 variable_fls(x_);					\
 })
-- 
2.45.2


