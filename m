Return-Path: <linux-kernel+bounces-550514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7EBA560A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84DC170532
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE85519E999;
	Fri,  7 Mar 2025 06:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGXt36Hk"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C619992C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 06:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741327941; cv=none; b=o3GHc9dFoGkEhmeKYeS4v+Jo+MjtpwFoPfy9lEgDahg+Lsy/6Hxk+W8ZyqvWPSuMJ+muvMbd9Ohw7NT2Zih0xBdocYSVTPlFiksWF46eHZJFthLHJhk473bSjo1bdQNqtJ07yumJB5rbrGSIUHZxTCWlIjnYOCleXLuD9ZpXFhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741327941; c=relaxed/simple;
	bh=aRoyyOHMvzr90ISCT5bgtgpVorqzMbYKOJ3GMx0h6U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ax95JXwdN9HjWvwn21L7XyW9qNeC57qCDUOx+D9wpOPWcuWfFqKgPNKkthNAaPsVRFZ5axXMLo6GLTbL15M4YCKAZHYvs0KzXFwi74LbtgpBHkPNRcLQgeqnryN9XpP+eEFoZa+pwvJsuQAvzHX6E824tuHR6eo6FiJlQWUMJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGXt36Hk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf3d64849dso180351066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 22:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741327938; x=1741932738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8knJezzJCT9l+ND7megGgoGD5wp7Ssz/zHqpIYkSpM=;
        b=EGXt36HkSHh8o/iWtDT/UZgVlWlowfRGW1Tq+uU7HqD5qieiU7dv7s4f20mcUQBRMA
         HcOXVGlqIoCwS1EL/HnoaTVX34Xht6KxTz/yFXcmkkeqd8zJxcw9IWCeyJmm3GE80GMW
         TGn+6JAzqrp7c6mvtBtzYk14hGq5sfdruCoaDiqPYlXDCMLx7yB20E9uTVBoXx6gTphp
         JNtt3zDYdpkFZU0UoAVcJuKDdWlu/jaJ5WMNYfRU9aEVGpjiEs1uZAS/cCgcDuN/CFHC
         PHgu7UDcQgsa9kfe8uJdFb4IBN9hbLXMNUci7zgCiCgcKgCPUcP3UOtTqiEzuuRY8IOq
         rCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741327938; x=1741932738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8knJezzJCT9l+ND7megGgoGD5wp7Ssz/zHqpIYkSpM=;
        b=EdLvnVvZcUNN7R+Hos7z6xsAFK7mk3ouNk2PN9ZbBvnkGJH3X6Jl3uX18cLNLmYegB
         1GgB4jreVwI7nTIEUJjlIZJJGfacfmqGiN/bObHVZIjzWT4IYbZxQOeYPipfRMPEQn05
         OkQrCRKBdwHTFLGNfV7NL/snv6eqOjEmyJ8uGQwZvG+D8mRn7bLZK4zkDdrOA8Znmp76
         KVjcagvH4ujXEjOVs8FVKj8jkqvLNktxQYV7EzCZKWG7iBY3Isk43JfoGHMFgD2MvPOD
         c3Sqx4a6XnYdKQJYJksm8twqLYHuzRgxpJRTwUBeK9ABeJxB6p5tkWgMQ074aO/24tCz
         1TgA==
X-Forwarded-Encrypted: i=1; AJvYcCUyU6OttRXnGbnx3ObXNdk30CBIZQtZw9fnjDNIc97ncaQTKTHWaG/Fuoa+sb7sP4Qw6Dorux94v+Jhfjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKsJeG5Zb1LeSt/UP1qqxv8tvzFafURKyErtM+Zf95aokWIoEm
	WTy1qLVHUd+K4pgHCcRbowLIvFv+9Uk9/Qp7nCvQw03jq4EhM2A=
X-Gm-Gg: ASbGncsqgiObiwQNgYc2pxtlzCxh7YkS8dAgrU0XXpIRX8phMlvWxFQbofjUTyCKTAP
	Zpv+kY4Uxp82o03DJ03qrq2Qtv8/Y744nTazrNFxfrn9GGJ2o7VlBSrsjjIXVXmgh0GPR0rHNE+
	v8EjbeYZeRbVRj6qPbK/e/HlOuSVUV5uT++y596XQI7QCBKi69zzWHlsc1hZBe56/Uc3Y/GA8MS
	HRgOB2R7wSWABvyFjJOL9ulLlir84qlMUgt52AmVNFQwA2Wdhw1HB5iPUmyRI3t4O15UzND6X0W
	2ONz/pRoHo2sug/4aldwl0wOz/3OQr1xrXSuhXrJuyU5W0D8SH0eNvvL
X-Google-Smtp-Source: AGHT+IG4hafAVbNqH1sKPeax9E4vo2Jy2vcdcCxC08KGu374Vcmt3tKHInZCZElzY2TkZ4xTmhrWVg==
X-Received: by 2002:a05:6402:2114:b0:5e5:be7f:a1f6 with SMTP id 4fb4d7f45d1cf-5e5e229cc0amr4966593a12.1.1741327937643;
        Thu, 06 Mar 2025 22:12:17 -0800 (PST)
Received: from localhost.localdomain ([178.172.147.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988bdd8sm216824166b.138.2025.03.06.22.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 22:12:17 -0800 (PST)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 4/4] x86/asm: delete dummy variable in enqcmds()
Date: Fri,  7 Mar 2025 09:12:03 +0300
Message-ID: <20250307061203.3281-4-adobriyan@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250307061203.3281-1-adobriyan@gmail.com>
References: <20250307061203.3281-1-adobriyan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cast to pointer-to-array instead.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 arch/x86/include/asm/special_insns.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index b24c6c945c38..aa5f015ff2a2 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -257,8 +257,6 @@ static inline void movdir64b_io(void __iomem *dst, const void *src)
  */
 static inline int enqcmds(void __iomem *dst, const void *src)
 {
-	const struct { char _[64]; } *__src = src;
-	struct { char _[64]; } __iomem *__dst = dst;
 	bool zf;
 
 	/*
@@ -268,8 +266,8 @@ static inline int enqcmds(void __iomem *dst, const void *src)
 	 */
 	asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90"
 		     CC_SET(z)
-		     : CC_OUT(z) (zf), "+m" (*__dst)
-		     : "m" (*__src), "a" (__dst), "d" (__src));
+		     : CC_OUT(z) (zf), "+m" (*(char __iomem(*)[64])dst)
+		     : "m" (*(const char(*)[64])src), "a" (dst), "d" (src));
 
 	/* Submission failure is indicated via EFLAGS.ZF=1 */
 	if (zf)
-- 
2.45.3


