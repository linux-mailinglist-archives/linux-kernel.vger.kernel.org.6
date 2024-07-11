Return-Path: <linux-kernel+bounces-249920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEC092F1A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D721F2276D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E32219FA72;
	Thu, 11 Jul 2024 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awZk8FJv"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DC742AB5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735503; cv=none; b=IawzVfqoIwc4ck7pB3AuHcoC9swiMKjF3mcjS9uqSylfUAXhJUiY8WOqTujOk76IGsL0z1jclZ04Mh/Klx4ytSsAQodxSosRTshTiXtm2PIJ58JaazLuaJR4uVzT5MCslN7gsVoTzHbXjVAWiazE+v4ZsJ49z5yY8LUGGAgUFeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735503; c=relaxed/simple;
	bh=Fil2wenKQ3H6RJp8la/RuIezEOCN8nH1G7BHf+hLpwE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NBUxCXe5+gL4TBs0P7Fjag9r5Zg1XMU62HZKBX8bGHlH2baQOZxCFmJLBqJh/zqxDu34WzNc5Twzgk2c9l8+fITMggqc/o5oHW0zGU4Hmek1pKcf7SyVB20iPPYfb6S7QBtJwAe73XoIvT/ArwQsDMY0Zg2ZJcHUuPBw5aSoWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=awZk8FJv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62d054b1ceeso23269267b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720735501; x=1721340301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GmNVGQhxfF+dmL8G2Kdb1Uh26WeDRaL20f0RWOUcIns=;
        b=awZk8FJvsvhPWg3+VGBzSTc689F8PFBpnRw7DqH1M3LXYvS8TY5SgFPNl48YhEeefE
         fM3BZnryniBpIMhu0y8NKNNqfZj3agxWpdHP3iPfv93nzKETkbG2iRXHkuEe4tfYtwF8
         /UcKNZU0RmsTFvGumtLhlv4coCfyHWxqhnVpZZOlA547bQZixFqVayYxkWz/AnH3HV7Z
         bIU+VVSqu4jBKZDpIJCzMZbCgIqzgv5dUz3RwNA2YMzHCJjIKbH7D/YYuUnSgUSMxy7t
         3b3eHKJ2RvcmtR8R3S7Enz0x0+mnfSmM3WXYv0Vh3y77NwxayJCgoNMPOo1mqnQetNX2
         PMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720735501; x=1721340301;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GmNVGQhxfF+dmL8G2Kdb1Uh26WeDRaL20f0RWOUcIns=;
        b=UeI28bd9sv4b5EU47IDG0cHPTYuKlnSE/m6PTZDq0Yj/og3/thl4xwpBBAgtDYrCs3
         Sos5dTzJgoep0RnlBg7UatB1Y31kbzSkleUYWZYh7oRIC29colNABg5c1s5xvhqRRAtm
         SK/WWINpp79HalxySL176e8KVbZLZWudV1kycHi1sGWZ485fUg3PPFyppL3mkvk2VOtp
         8IvsjYjlPl7XsrI6ncScNpHRUMMlemIvBHm3SIWQyJxod45dAyJLqEkpnPRXb49xtt4s
         TfOttrIN5bijD4LWE2tPpcW4Jw+mqhS+Rir2HJIMcW4snNFIRxGFVRCUC6PieGErYRMI
         4uKw==
X-Forwarded-Encrypted: i=1; AJvYcCVqhbJZImVsXzrLb+raz6Yqwvs1kUnbkGZmhp+ZzTjWTJDp3ZvZuckzB88S1QzrSB6Fvs6nny83Bz5NdogW0lM/suKxICA9Qjpn6vMo
X-Gm-Message-State: AOJu0YwmUGiT4jn/diU2yIiKWKjzaVJqmWRnK0fAolEk8FwLhuMAH/4h
	CRyWTLSeSCtYrRZcYomoU4uvZwH3EIjpOcIXovnLtQVU2wP+Pl5mhC7Jd6kNHVnKPHOgbGalmsR
	aqQ==
X-Google-Smtp-Source: AGHT+IFeorrBi9jfJXX70RSirbeZ3WCfrHwYAEA3ofVUx+qVZL0mHI2sTcB+Ym/6U8kb0iPO1/hJZdh8n04=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3f97:69c0:dd80:bd4a])
 (user=surenb job=sendgmr) by 2002:a05:6902:72b:b0:e02:b093:dc1f with SMTP id
 3f1490d57ef6-e041b034472mr20616276.1.1720735501238; Thu, 11 Jul 2024 15:05:01
 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:04:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711220457.1751071-1-surenb@google.com>
Subject: [PATCH 1/3] lib: add missing newline character in the warning message
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allocation profiling")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index abd24016a900..8c61ccd161ba 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -122,7 +122,7 @@ static inline void alloc_tag_add_check(union codetag_ref *ref, struct alloc_tag
 		  "alloc_tag was not cleared (got tag for %s:%u)\n",
 		  ref->ct->filename, ref->ct->lineno);
 
-	WARN_ONCE(!tag, "current->alloc_tag not set");
+	WARN_ONCE(!tag, "current->alloc_tag not set\n");
 }
 
 static inline void alloc_tag_sub_check(union codetag_ref *ref)

base-commit: 8a18fda0febb7790de20ec1c3b4522ce026be1c6
-- 
2.45.2.993.g49e7a77208-goog


