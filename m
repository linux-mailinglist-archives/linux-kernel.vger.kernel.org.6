Return-Path: <linux-kernel+bounces-245692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE4692B62E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CEA01F232DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8E7157E94;
	Tue,  9 Jul 2024 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="CTeB0jzn"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8003155303
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523257; cv=none; b=orihpBFJrCuCjr/PTesXlBf5q+lIYInsqsqFUJ2ScCNz5Jf7aLBzNfVJyu8A2Ft/WTgZZz485M2D3YJv51YUdP2ff+aQMx25r/SlnIpXHjbzFajvsMVCRE1IxsH3sprPncIh3sQGRKRFVq3p/yE0RpqUcgFlLSvECDcwN9nXvUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523257; c=relaxed/simple;
	bh=/F2IkqN6onhi8bqBg+Ffra8tWyO9XNvT/nQhWcfnN24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lxSr7ysCFYW+VGFz+hzfGxRKvPuke+05+WjrFk+x0JM8YDkN/sLwwVBK+od8FRQ21uNA+MFXgckz1jpEbjasF8GFODHmdG4BjwR5ptAyEcVAqWMbbSGs9mc87SC5W8k0GE2Ssal0kZOSVbPbXZyazR7aWXS7yPYsxqgz346WLGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=CTeB0jzn; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58b966b4166so5967840a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 04:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720523254; x=1721128054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1I1Xf39ndiqFsWjFiF87exVBTjo0QTgARXHDppQr8z0=;
        b=CTeB0jznI61lD1iyxEC5WLV+gzPSLPaRtMUoBS5xu1szVuzM5d0lT0LVBZxR28d1/K
         Y2MJ38IuI9pKiTyDb4IS7TLJIdequJsk/IqRHhEYwmw3PXmnNPPYEaOajYABKTczZDuM
         m93FupyXA+7jyUcT/fjjGaM1T5jIkBVnMu3nGIS0D2qM1eRVE7n53L/PEAddYN838B8I
         lNn6w+8oY9VFh6PJ9+LNio11ohGJBD/RR4FjUQII9e8t18+kKfQ0QUTBdlM7SGsF4csk
         Gig4UEAw9s3JygWXE30VjfhTtJ3cMKYfx4thHyzchfydY4gfm2wmhnXCuBxsheJ8SrAZ
         elVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523254; x=1721128054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1I1Xf39ndiqFsWjFiF87exVBTjo0QTgARXHDppQr8z0=;
        b=ScW0Jl0go4hcA4bt+jyJuO5uKNtBnYKt8yCfbk7gETRu218Lbs47TEEK2q436l2q+X
         WZHGuB6WZnsWiJ9kcRBI2PCVpSKOiWc5erv5nenN4bn/lcAkNSk07VBbMHXvWbtf5ddS
         bbWnKQVbxHya7XawZO1iNKVuyZgVqRkvPLItI5b+JtzCF9qhF+Oy/dNfhfxx5zcwsDBD
         1PD4FTdJbxRU4sMtusK168lYPY/JzSblY8D1UrIFJoubkRog6pJRhAzAVBeo7jFF29E/
         PsqoZ+EYC8f6PlqqwYa/YktyOeXH6wnMBe7l07iCScfF14r2WbSYzAj+C9jz1zZDYuWW
         4RYg==
X-Forwarded-Encrypted: i=1; AJvYcCUnJFkx4556AS4G2+A4mmA4PJc9OGKTI/tHZXYhD9KiFmhLZ+N3l5ZdH6ZQZf4dj/wjlgQSSPdF+celSPtwB3BBUEmJOpaFH7rrx1HF
X-Gm-Message-State: AOJu0YxkEZY2hEQZYw0tyVjjKTdz/yOalhdgbddbUQdE6VrlzH1sG2r3
	PfgNRCJD2m15uz+maG2eVY/john1Bt9vPgOrjC16qbqaTxGBoa3NabZH6CXCMAw=
X-Google-Smtp-Source: AGHT+IEkC6Gi8bnVVlEoW+KjySdnk0g6ZRKfC91eeq9IoFsCYK+Vmj3FZQuIZi13296mSsrR6orb0w==
X-Received: by 2002:a17:906:46c9:b0:a77:e2b2:8ec with SMTP id a640c23a62f3a-a780b68899dmr145995466b.3.1720523253801;
        Tue, 09 Jul 2024 04:07:33 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-224.dynamic.mnet-online.de. [82.135.80.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bc8b8sm69164366b.30.2024.07.09.04.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:07:33 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] m68k: cmpxchg: Use swap() to improve code
Date: Tue,  9 Jul 2024 13:07:04 +0200
Message-ID: <20240709110703.66166-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the local variable tmp and use the swap() macro instead.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/m68k/include/asm/cmpxchg.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/include/asm/cmpxchg.h b/arch/m68k/include/asm/cmpxchg.h
index 4ba14f3535fc..71fbe5c5c564 100644
--- a/arch/m68k/include/asm/cmpxchg.h
+++ b/arch/m68k/include/asm/cmpxchg.h
@@ -3,6 +3,7 @@
 #define __ARCH_M68K_CMPXCHG__
 
 #include <linux/irqflags.h>
+#include <linux/minmax.h>
 
 #define __xg(type, x) ((volatile type *)(x))
 
@@ -11,25 +12,19 @@ extern unsigned long __invalid_xchg_size(unsigned long, volatile void *, int);
 #ifndef CONFIG_RMW_INSNS
 static inline unsigned long __arch_xchg(unsigned long x, volatile void * ptr, int size)
 {
-	unsigned long flags, tmp;
+	unsigned long flags;
 
 	local_irq_save(flags);
 
 	switch (size) {
 	case 1:
-		tmp = *(u8 *)ptr;
-		*(u8 *)ptr = x;
-		x = tmp;
+		swap(*(u8 *)ptr, x);
 		break;
 	case 2:
-		tmp = *(u16 *)ptr;
-		*(u16 *)ptr = x;
-		x = tmp;
+		swap(*(u16 *)ptr, x);
 		break;
 	case 4:
-		tmp = *(u32 *)ptr;
-		*(u32 *)ptr = x;
-		x = tmp;
+		swap(*(u32 *)ptr, x);
 		break;
 	default:
 		x = __invalid_xchg_size(x, ptr, size);
-- 
2.45.2


