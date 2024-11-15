Return-Path: <linux-kernel+bounces-411334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C961B9CF653
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709992869FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A621D9346;
	Fri, 15 Nov 2024 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="zKHB0oIi"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3C1E1035
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703569; cv=none; b=C6e/+m80Z/6+e2ko+DGZJbIzAsvQooq6NZUrtIIl/05/waRk7ckw14C++dTx6+dwJfvPcOB2cr/UP1jgIdBEJB1O0OcKp7uBiKcc8Nu2TyFeiKum0cFuw/HlT+yEuzVih5jCmS3XdlW/iXnIzQnxH+BdrnvOTqFqufcXNCX433A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703569; c=relaxed/simple;
	bh=XyNHVlWArvdX146gZuzHeGdpDCkh87/BT8U5Fy7c6Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UamhcW/d+F3sS1Z2NbFeUOjHAH9hYAFj8MHvkdsj3JhVDtJGr8tDFJ/rz+I2TMv52SF/X3F8uw6ALERUFyWYqVgm+PxcClBWVY08Qi5iAodLXG3g1wCstkV2dmr2pdJ3Whpj7HurXdAm8/R3zOOCcZ2nN2gmrUN8tWWn/s75iH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=zKHB0oIi; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cef772621eso1461576a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 12:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1731703564; x=1732308364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIsOzL1TL5S0a6NvpEb/SIB7nJlBKvKr3uCVh+cqpFI=;
        b=zKHB0oIisQSwyXlpKE10/xtcgnGUDd3v3NFV/BLHmzwcyyY2uIQwFeWU+3xZv7Zefu
         llcDAtjxbVVq368Co5EAOhqzLiXlaBjARbY+Zsiq7DaKFBXnCbZrkomyzuVzkwSndI+S
         r/h8v+xjU0XrrB9vHa/t0ZjMkL3j0ZnFUjnNcPl9o1rd8J7cHqhhWtEbvRl0R67t+GCi
         pG+2sRv773KcbOg/177gYMci2mATUKXiXpokpK7Cv9DndvG9Rq+4xt34fni8TuOnfgIU
         tSoqIawRQ4/ODDiobI2v2woiLMVEqBWjf+pzOe9kqA8yTsz+Qvh25WJVu0zHk8c2LHvB
         q2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731703564; x=1732308364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIsOzL1TL5S0a6NvpEb/SIB7nJlBKvKr3uCVh+cqpFI=;
        b=eiuSrVZRc+228+ZIsYBsYrnXQ9oqstTyAT9iMMSO4ERrYT3xPriMh0KWVljyRkui8/
         oqDbjoUIz6dxnyzY+PiOpmTVxBRIPuvdN6uF5oFohrckm8ED2VqjaZkhTVn9USMugAoz
         maaOZ3QH5V/a09BbMi0DK2xKKvEkyjRtO0MfWjYwi/CbC/qO6MvFlGXbRUeZ5CBheIyT
         66J8zcB5X3saj7GrzHbPKnAow0jCt3U0l6rRoxv0eqfEzsDU1SOus2u+9/uZhRzRbMY6
         4StXm7RsBI+fq8vsg7jgiyiGcdKnvnQVs1S/ZzsMp+EvDTShKHLnphUJOoGmUZLpe45V
         v3tA==
X-Forwarded-Encrypted: i=1; AJvYcCUSI8VdaLXRdoCbhNqR18OGtA2vJjoFg/knJ0r1Yeu4zfOQy0E3ykApaqnrauW8OIWlHvVtvMZ7WSv56tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1i+0YZJVkF4wRsC3yhnLn2qLZbYHSAWVJ/cEaw6OK8QV5KCeh
	EQzlnCK7wW1D8VxdHbSB9nq9Fg0Ql8Q624Gz4BGqSQpuEU5qbNSR/i33xQHRbQg=
X-Google-Smtp-Source: AGHT+IHrJIgFHzNI33P22/GuDZL5K7P5kle4zcvSF+rw03HRsCdnoxcq89YtrUp3Vdg+5KHxoucflg==
X-Received: by 2002:a17:907:70b:b0:a99:499f:4cb7 with SMTP id a640c23a62f3a-aa48341481dmr376258966b.23.1731703564587;
        Fri, 15 Nov 2024 12:46:04 -0800 (PST)
Received: from ryzen9.home (193-154-230-113.hdsl.highway.telekom.at. [193.154.230.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046ea8sm214059366b.169.2024.11.15.12.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:46:04 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] compiler.h: Fix undefined BUILD_BUG_ON_ZERO()
Date: Fri, 15 Nov 2024 21:46:02 +0100
Message-ID: <20241115204602.249590-1-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CAHk-=wiPZmd1hrsUoP+9vPg2=E0Jj6Li77_BZcV9GocbJg8fag@mail.gmail.com>
References: <CAHk-=wiPZmd1hrsUoP+9vPg2=E0Jj6Li77_BZcV9GocbJg8fag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

<linux/compiler.h> defines __must_be_array() and __must_be_cstr() and
both expand to BUILD_BUG_ON_ZERO(), but <linux/build_bug.h> defines
BUILD_BUG_ON_ZERO(). Including <linux/build_bug.h> in
<linux/compiler.h> would create a cyclic dependency as
<linux/build_bug.h> already includes <linux/compiler.h>.

Fix that by defining __BUILD_BUG_ON_ZERO_MSG() in <linux/compiler.h>
and using that for __must_be_array() and __must_be_cstr().

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 include/linux/compiler.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 4d4e23b6e3e7..469a64dd6495 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -239,11 +239,18 @@ static inline void *offset_to_ptr(const int *off)
 
 #endif /* __ASSEMBLY__ */
 
+#ifdef __CHECKER__
+#define __BUILD_BUG_ON_ZERO_MSG(e, msg) (0)
+#else /* __CHECKER__ */
+#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
+#endif /* __CHECKER__ */
+
 /* &a[0] degrades to a pointer: a different type from an array */
-#define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
+#define __must_be_array(a)	__BUILD_BUG_ON_ZERO_MSG(__same_type((a), &(a)[0]), "must be array")
 
 /* Require C Strings (i.e. NUL-terminated) lack the "nonstring" attribute. */
-#define __must_be_cstr(p)	BUILD_BUG_ON_ZERO(__annotated(p, nonstring))
+#define __must_be_cstr(p) \
+	__BUILD_BUG_ON_ZERO_MSG(__annotated(p, nonstring), "must be cstr (NUL-terminated)")
 
 /*
  * This returns a constant expression while determining if an argument is
-- 
2.47.0


