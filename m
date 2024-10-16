Return-Path: <linux-kernel+bounces-367346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D259A012B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777171F21D24
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EBE1B0137;
	Wed, 16 Oct 2024 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="dqD/OuuX"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ABC18DF72
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059225; cv=none; b=BZ9LhPc+5pCcv5aEWYxK8qYvc7xnpJcgiwvYsr5rtc86SblNUkH0Cx30fH2GZ9oBajas1Su2mKL2zzGRNk4EoAUvhFcPf9YWXzLt0d/qr9PCPYOccJCHiXrdYdbZGjh/HfPy2yesh9uwmxEtEnQ7FF8m+yJLgvKJXL9RujcRFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059225; c=relaxed/simple;
	bh=aN7qz/p2yFFjWdhvlvJcw0UJXrJvejxwLpb3F/G3N2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwbYur/fkYI2bkoXrA9RuIUYL5QiSnUPhiT98vDjV1OXZS8PYoyT0dgsH9YkUp8oGM6ReLtj4BHfcfyZSjFpZlxP4ufRUpGzzAnH1NTmN1+IPu8XZv/6wo5zM/3t7UfBAPsGlp3cy/J2UnEaotzmKsQ/0P0m2q1WRBLAEE25oVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=dqD/OuuX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99650da839so1027643266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729059222; x=1729664022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
        b=dqD/OuuXwsaHIQ3U2BlfTYSfgxkWgB93dDsapeN6GUVVxRIQEJaLju8l3OzSbZM9g2
         fHWsD9bowyGlMiRyQtz2NtqDIK4Gd5r+WhyomwHgAWWKNDxazDnEn4WzZwH7lNTXCDnv
         bM0IaJWm23bZrqd+Ymt+8Ad7WMmPu4++lHWrpBCKdWNO7igiSv+K3VV082ZdSwtaoYvX
         x6ghDbCrSZPWrt0z2QMFMhb2JWU8LIf6dytho8liIauhs1ZVoSKJe8hXScMld1gg/7V+
         ogeyDPfRiiipKCi8DGmRtCax8uoa0dbqIpruoIGIHYn/l5NARN1XZ3qD2f2DCePoGP6i
         73zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729059222; x=1729664022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
        b=GakyCco0KzZ+m7WOT7lVXr8kMqwx2fnmGfKpPyWZZsZUFK7TbF2ZXPSCS9ig9X/FfB
         AaOvEU2eCFtT/s5SwuOZ4t/4Evfjh20vlpIvHmhgphBfBSAI8xOTPCDF8m53QaBbkxEI
         74m9gJZVktbEUWNkCIs+lzQ/YSOTp2/7SlzRZVASMz378U7KJcukpUP8/lO+I66kBKlm
         CEkgm7s5Ytwg1CKiUofn8+EOBeWawtouT28kxXZjg8h4iZEr1tuVbEz435vElnTMDKsu
         kXgEuRGKPYy3gV7dC58b7uz7s4DQJ2RGVK/u8Dto12ps2YqlXOSpp6Do/Dvz1woAfe5z
         IocA==
X-Forwarded-Encrypted: i=1; AJvYcCV+dre/kVWpPb8aqRjGx9iIVgoMOKvey/e8Ux1IRVBSSqkrsto/BoRNbdeDW2tNIqoKqxUGGL3ywqpQTKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3cP89oaI5jlLvELsW8srxIWIi97f9Ey0XqtcrxxWcv7/4UBjv
	kAip5s6Ph8HpftX5ytaIsqgiWEiWwNh3DSrnwutmwzJZicO8W7c98YVfUZF8MNg=
X-Google-Smtp-Source: AGHT+IHgOyv9Fue2XHIrLmyQiCMmzbnRByx6LLM1OmvFY96miMvecbdf6FZuLlE6xeqz5Ti+WqJ5TQ==
X-Received: by 2002:a17:907:c087:b0:a9a:1c19:4303 with SMTP id a640c23a62f3a-a9a1c195d08mr551706166b.63.1729059222342;
        Tue, 15 Oct 2024 23:13:42 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 23:13:42 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 35/37] bloblist: Fix use of uninitialized variable
Date: Wed, 16 Oct 2024 08:04:21 +0200
Message-ID: <20241016060523.888804-36-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize addr to zero which allows to build on the CI
which is more strict.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/bloblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 2008ab4d25..cf1a3b8b62 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -499,7 +499,7 @@ int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
-	ulong addr, size;
+	ulong addr = 0, size;
 	/*
 	 * If U-Boot is not in the first phase, an existing bloblist must be
 	 * at a fixed address.
-- 
2.46.2


