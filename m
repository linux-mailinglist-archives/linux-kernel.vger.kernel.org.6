Return-Path: <linux-kernel+bounces-317028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ACF96D865
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4492628834F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49001A2C3A;
	Thu,  5 Sep 2024 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyGKol9f"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F9619B59D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538851; cv=none; b=AmH1LW4alGaF6mpYosCcJO61kJSEzzQqwkFJO80u0aeKqi+LCu+bwXYhdQJk38bBHLeAZTkQYD0aX8O8OfJtbMCftpMxgdQSW3bKRliZ2ZN2NUh+8kqYOV98wb3PtKvlgQ53JLG8N9lJxDcc0fVxyFNVvPh3mgM231zoWTcyutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538851; c=relaxed/simple;
	bh=hHjAl0JPGPI/MEBYL1dc9G6PBZSCIPKFjHkaJktHUi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLSLp3UXqmZ6MLCxuieOR1KIQRZLPDHDP4NLhAGxrzw7IU+OqAmJkMuNmrDqB4V3lHZKr4W/Xdryme7STdSQpaY0bmT+bCosnPU2eHS/p3qcyUvAcftZoWE1oeZ88huplMqtYOtQFS9P6JsDAqZssSwmGY0rW1Lob+CUIDmAGJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyGKol9f; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428e0d18666so5524815e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538847; x=1726143647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCp0s1EgIc6d9eNEtusAmlUF6jtxxZup/pWyDJ1l1CI=;
        b=AyGKol9fqqjmXMGKRnUDm87pq+7GlbA7OmKm9m1kS0BKpv4ffsiz1mctQ96ii3aO14
         g/6dlrtIUGJsaqsaiVRMyNdmGyOu4KwgWGVmx+1vZuyNHne/tlCnhub39T+89IR07cGv
         iXzrWrVk3WMoTVaEOfxZ5IC/+Bk6bi2E+uXA18E4JFp3Lp0IL6yVFxQ++wtz2eGlFdpn
         JSrcK5VOKZET1+mOazWEPmCUZZXF9floe+G/RGGwkZEHSwrim7plMHkka0sRHSIO5Rdn
         eXswCRHW7SB5+oV1mRMznYWeOyRFzQZRP/grPnk58pBLZtrdSs8HQ/+4BeT0qTyZWd/k
         p3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538847; x=1726143647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCp0s1EgIc6d9eNEtusAmlUF6jtxxZup/pWyDJ1l1CI=;
        b=PBBbn+WZ74+WMOpD81W2kDZDFeLuiNk9VrpC3BD7ueE9Hr/OebM/GnAOMoXJ3dd7Qp
         BCfhlsN9SRfuwc6Xw7+6VWReBDda0dOFfW8twfSMNNidpHFw3HINdUgRWN5wXCnq93f0
         VT/KSNY4kcU5cI70L+GPiwYDryde1rJIVTnviUv8/VD5TO5ITxi6k/c7ZgvrCwQhqjJa
         dUXdQFwC9mBfG7VXdms2feovO6B8QwaZW2pMmKTf9wBjxLGziNcOq/FFIUiN1gVnzNDZ
         ff/AEQ7aKvj/jv9y8gdoc3fhEFhZXsBpmxM+qre20jn6B0H7pqTMEkPAIFvYei2QWSYY
         9D6g==
X-Gm-Message-State: AOJu0Yyrbr/FO0Kj82G+ov2tMDw6hOevQeljwib2ikHwzlBtDjCr3arj
	oLOcLl4T4k2zErTDmnF4kDPM0SPms8DqPS/8a9MA0pj4vvKhwT8OToXQLBf20uc=
X-Google-Smtp-Source: AGHT+IE5yxBN118HplIlvPg9gZvSoBXKJvJ7nOyr9wmvuNtH4bwXftPYdBzQrbyyHQCbDIX9IXVj4A==
X-Received: by 2002:a05:600c:1d94:b0:427:ff7a:794 with SMTP id 5b1f17b1804b1-42bbb10d2abmr165979055e9.4.1725538847459;
        Thu, 05 Sep 2024 05:20:47 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:46 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 17/18] random: Do not include <linux/prandom.h>
Date: Thu,  5 Sep 2024 14:17:25 +0200
Message-ID: <20240905122020.872466-18-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905122020.872466-1-ubizjak@gmail.com>
References: <20240905122020.872466-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Files that use prandom infrastructure are now converted to use
<linux/prandom.h> header instead of <linux/random.h>,
so remove inclusion of <linux/prandom.h> from random.h

This is the "nice cleanup" part, wished in c0842fbc1b18.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Fixes: c0842fbc1b18 ("random32: move the pseudo-random 32-bit definitions to prandom.h")
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/random.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index b0a940af4fff..333cecfca93f 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -145,13 +145,6 @@ declare_get_random_var_wait(u64, u32)
 declare_get_random_var_wait(long, unsigned long)
 #undef declare_get_random_var
 
-/*
- * This is designed to be standalone for just prandom
- * users, but for now we include it from <linux/random.h>
- * for legacy reasons.
- */
-#include <linux/prandom.h>
-
 #ifdef CONFIG_SMP
 int random_prepare_cpu(unsigned int cpu);
 int random_online_cpu(unsigned int cpu);
-- 
2.46.0


