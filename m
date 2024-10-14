Return-Path: <linux-kernel+bounces-364118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A2699CB4F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D0AB23D98
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDC21BE23E;
	Mon, 14 Oct 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="V3QzwnRN"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8EF1AA7BF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911589; cv=none; b=T9qZOSy43lSqMVAtTp/Ix/peyxrJ2VB4BmzC1JYGfi+7UTiv1a6LU/IkeLQ1Zb46qmsLBFIbXFP1TcK0zLdaDSeh4LBmDZZc0xouUHXautQxcRjuaVptAXbvgC83faTCnVswYzpLKssAx/IV0bdQF12jpEiJqzCCRbI3/9arpt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911589; c=relaxed/simple;
	bh=Ld1IFHH4VoD948pzXVnM8uGtymM6N9lAqhQr7/Xhim0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOIgOq9kFeR5exV+KCzuty/09G+ygWxD73ILwj3w4xe4ysulOveyl1XTDhxJS3kzxlFPbV5VEzYKZjA7T5f3dEfnRU9qPtkt+VpY+GpN0jknHMWzHZBUTnbVI/tjs2JCVhPrIDn/O9dQvQ0qMsTJFOl0gJwlT55FZZstUGJhazY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=V3QzwnRN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4305413aec9so41512535e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728911586; x=1729516386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMxWbG3IzboBy+GjbpVI1B+44dHkVyWcI9T24UQ7YSc=;
        b=V3QzwnRN34HJ53KpEAz7A28xqAitPMyLUeJ9cHIT8d9hYAmfLIv+TAKFbedwqtMcCG
         Vn0UXsBNklUo0dUF1SB5SRqpobHlPStFb9QDweg4Emf+tg+NpLDv1Xu0Hze18m0Yi03m
         Nu5yjp54DF7sO67gkruJkajgqgurR2uwm8P7372OhhNRJ43yjBn8CzVDYl73Ee3sajVH
         WecPU0Prhlx/IJVno3u3OGE5cw2zXD6K4bWYVGIusfxDuL0SSGks/XVG/OwUHjDoCR5J
         La9hnqAoT2AJDmsCW8FgOmTAsZ3PJp/nE9bZP6NeUKpx7TcvxzW89dB+QGbHgscaELZ+
         ECcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728911586; x=1729516386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMxWbG3IzboBy+GjbpVI1B+44dHkVyWcI9T24UQ7YSc=;
        b=vj/sbPSyO1N+X234UVnu/XCocgEz8TcX2j8VI5XvSxFTSz1GJ7LH2EwJ8tXvOrAF/l
         by17k/lzek99rJhbsZyebKHDAD5jFelFImCiicDyA8iMqPICBn60J3DESAHP45hqwQ0v
         KNkn2HCOZayra/kj0Mo2JDSZVl9N5RquUTHR58kKpe4Cm/tfxAiWImZTIEyNVDjfQd9z
         Mc6BfqCrdKtRHvENB6l35rulYdYxHvjmd1FZ15F1F8SOp5NI02qsJ6uaVt/i/lR6ag78
         dLSE8m3Y1IOt1k74IEmqSYzdWyglmzzo5U8NHM90n+AZ5LUuBtImCu0ICmZaOXLdvoYq
         zXvg==
X-Forwarded-Encrypted: i=1; AJvYcCWrjLLSEjuY/UgTrg1DgeOyiR+RCCeeYtPdnhEqyNiSu6OxZisGTUVrz70vQ9U3kB8z7+T58DiFZELWqd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7zX2iJ//c9T/H6pkYHxN4JhAQozY+BgYgwCJZMeq+K4eyB4hN
	ib73KAyu2EL1K6uZB9Yu49NQHf/ZUGVZZIk7FlM19J2T2nRSCGtqM3KV+3lJuLs=
X-Google-Smtp-Source: AGHT+IEPo6MAy2c+4GzFFcgx3sGQ/2Os/WfUJwtAh8XUeAuMsQOlwNE9ajuG1rMx3nJ9KAV3UNhhAg==
X-Received: by 2002:adf:ea8d:0:b0:37c:ccad:733a with SMTP id ffacd0b85a97d-37d55304285mr7994847f8f.59.1728911585726;
        Mon, 14 Oct 2024 06:13:05 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:13:05 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 32/37] arm: Implement read_mpidr on armv7
Date: Mon, 14 Oct 2024 15:10:48 +0200
Message-ID: <20241014131152.267405-33-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement read_mpidr() on armv8 to make use of it in generic
code that compiles on both armv8 and armv8.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/include/asm/system.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 2237d7d006..9eb30c2ade 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -394,6 +394,15 @@ void switch_to_hypervisor_ret(void);
 #define wfi()
 #endif
 
+static inline unsigned long read_mpidr(void)
+{
+	unsigned long val;
+
+	asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (val));
+
+	return val;
+}
+
 static inline unsigned long get_cpsr(void)
 {
 	unsigned long cpsr;
-- 
2.46.2


