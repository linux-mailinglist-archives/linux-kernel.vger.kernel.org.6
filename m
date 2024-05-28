Return-Path: <linux-kernel+bounces-192500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CB58D1E20
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C216D28539F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C287C16F82F;
	Tue, 28 May 2024 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CwEh34Lk"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA7B16F277
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905548; cv=none; b=G6SrV52afrPw36IcG+DsdAOxW9P+5tTAWDwMyXcq17Jv8whIlMmEx2g0f9V/VucskXHBnXnYwqOpkcmMKsxnEW4zXB85+Yv4jH3+io5nUFVKpTezuVMZaXPbPXyBzY0HBf6G6N+lN37OAAiuyueeTBEwL6xQ1QMK6nShiDrMeLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905548; c=relaxed/simple;
	bh=L7ojHEkPpJXwIpmwABRLu3WqdrWNoFsIlzOc1775n4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IHwNDttDcnoDtav9ghps0IGe1V8t2MG0ieuOjo1IN5LanohTiIvT8oXVQ9pYU42K+CRYC27lQopViw+G+1dCFL1jKwRQCgJMeaSzQkuct9/R6lqCmLQZTPK20Vj3D/RHmhHXLWk9yYcLwL+Wh6g9jwW/d7WXM44tnWNchpAQzCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CwEh34Lk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f4a52b94c3so7850145ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716905546; x=1717510346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nzuk/A/LDTekVmucccKhiVtGzJSwoK5rWUuC5nM9gSY=;
        b=CwEh34LkV1Q3f8YlKSohhQM9TBQfQGJok/BhPsGKRGtI48EapiKMgaY4quT/79J+DQ
         V56OWmn9cmSuDhIBgkD3sT/Jch8Hr3N+wh93YHvb2yHJScFBExeUgnJxUVFDb/2vhbQI
         OZhx0wnvO51sRC9/7jckOCCnmYgAa5KvfvoI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716905546; x=1717510346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nzuk/A/LDTekVmucccKhiVtGzJSwoK5rWUuC5nM9gSY=;
        b=IDWQCW+e6z+OyohAnR2JPf/B3r0cQLYFxLX+EOt0/EKwUHFyVXfDLGo2rGgvpdvm6B
         zmc8V9XJZv+bXuGVG6RrkTYr5knvf+88xLdVMIgaMCzTMWiQwHhfr4FpCwpEAZrL5AXL
         oSf3QiPhgG4VkuxGBcUvywJy4HZrBrX0o7Nd6Urr/Wugq5nGLAaaT4EyHASdk4jd1f9u
         chPEKH0TBN6laXUZ1rvxdcxbnktphoaHawlhcUxMUh/ONkrRr+wtIquvB/hWdFEUo+R+
         BxSiP5MPiuxoOjngkeszjq3BGuzOnrYGM+rEmZPbgxALgUEjywmDxBumubRQk53JWBo4
         oMoA==
X-Forwarded-Encrypted: i=1; AJvYcCXgIhfgKm7HQiVnjNFgOGUhN0Rntc637FVtg7gA27vJxSBaoLEhcQZ1se0HWs/yzykUrdagr6tgesl3DgmJjRVmGkXDdYVb3VLyJK3K
X-Gm-Message-State: AOJu0Yxv6nXh39g7nPR8TVJVx+91LvXH0+XIRmBgwCxTAmxudnbOUpBb
	3VitU63qPjB8NEyHdwlUJ7FoL5+zzqBgbneL0xnjaXiOdm1d+Mjs9GmTt5T30g==
X-Google-Smtp-Source: AGHT+IGq2Ds3m0hTxoYo8DC9tg/dA1K51TXxuSsGl6i4q1RywM8QvwUmEyVSYF/f1J6pen3F1Uf0fQ==
X-Received: by 2002:a17:902:ce92:b0:1f4:9308:2ddb with SMTP id d9443c01a7336-1f493083073mr67439795ad.59.1716905545979;
        Tue, 28 May 2024 07:12:25 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:95f4:6142:6041:6962])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9dd375sm80461445ad.288.2024.05.28.07.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:12:25 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	John Ogness <john.ogness@linutronix.de>,
	Justin Stitt <justinstitt@google.com>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: Use the passed prompt in kdb_position_cursor()
Date: Tue, 28 May 2024 07:11:48 -0700
Message-ID: <20240528071144.1.I0feb49839c6b6f4f2c4bf34764f5e95de3f55a66@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function kdb_position_cursor() takes in a "prompt" parameter but
never uses it. This doesn't _really_ matter since all current callers
of the function pass the same value and it's a global variable, but
it's a bit ugly. Let's clean it up.

Found by code inspection. This patch is expected to functionally be a
no-op.

Fixes: 09b35989421d ("kdb: Use format-strings rather than '\0' injection in kdb_read()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 3131334d7a81..8e98446564a9 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -206,7 +206,7 @@ char kdb_getchar(void)
  */
 static void kdb_position_cursor(char *prompt, char *buffer, char *cp)
 {
-	kdb_printf("\r%s", kdb_prompt_str);
+	kdb_printf("\r%s", prompt);
 	if (cp > buffer)
 		kdb_printf("%.*s", (int)(cp - buffer), buffer);
 }
-- 
2.45.1.288.g0e0cd299f1-goog


