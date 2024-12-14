Return-Path: <linux-kernel+bounces-445954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9289F1DC9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A54188BEA6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3903156F5D;
	Sat, 14 Dec 2024 09:20:30 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A58126C10
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734168030; cv=none; b=Gok4yP6aX9ikQFEg1O2L8jSarJRsLuwFuwtJC4PlMv059ffstF7172DyUB+NGoPXeF/cQRuybtwVYgnsz33TlT+7FxjwjD5E1Qgw++5uRiFkju8S4ItlrLux/rBxkA5tfr40bTMTyVsIFgLqx8UA5n1sj6LmRIcQj16znGGRqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734168030; c=relaxed/simple;
	bh=q6E6nHgx7FpQaxmK8F3VebahMPjYpo9H7DTOBqI7fUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6K8HYnbNlCzWLo+R6P5ldS0oZ8/CznO0ntyCalOy2OcyRlJnBF//b/17xrQsdCUVhd5nuaicU24o981QSmz9bYQOx9ruu0PJLLpP11PKrIIQtS2zGx7pqU1Oy2YWq85B/ml7X1/MH7EXIAglwtbzGNGtNHr0lTV1MU9Cpi91TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2163dc5155fso22866225ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:20:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734168028; x=1734772828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+66VXGs6F5HU673/dKdLLlML7sMQZ22uvjCf12/lRU=;
        b=ZCVzPnZbbibf4GYBabDerNCXbNi5inFlkcY+pkwLU7RypDODU6rOQV6IcGZeFQREE4
         z9JRcxMXiqetxCLfl6N6cScOl43Ab96B+bsTl9MLs8DIAw0oKHh13cbRgLtOaEL5IGAz
         K6U/dfZh58ItqDfICMqoWZqmML9Q8atze9kF4iAC5P35XdQcRZ1Eym+cKWqJkruYhwnx
         EoIgUuxkyIdlLeT5quJms9evJJFDN3t1agugV+zl6QQvmGjlpBI4+3n1k1noXDRL52cD
         1KHCt3LiyLMN9IURKGD1wv17qkOOY2eDc46aKnE0KPaAEYK+juiN1iAKB+LNfe04Y2Ez
         DtNA==
X-Forwarded-Encrypted: i=1; AJvYcCVLTtLJnqEUDBroxN7ivYJOtEoKIlodivrxKXF60vtVQbMxIwcNVRVuWwqmwDVTb75BYQC2VZeKtb25dIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9r7YpNa2v4aKIObuVbcPTMJ3R8TL9gCPSLcl0iA7wZB3txePg
	HomGFNVV73GdARA6ISDGRejtTnCCr45s/ocR/DpmHrCGrZqeF4eI
X-Gm-Gg: ASbGncsQ+UFQDOgmoy+WxBwpPOcKsvyso21mv8qDaemUwEeb37wW7Z9+t8eGcF29NoC
	1mxg3nJPPqqf1PnhKb1+Q67VZFt2T4J7u+bYrM4LMg6wSIXjC9SjP8QwHdEmbVPgteM6D+F9d0x
	6vroBQqgpZFvNAP+GtL/GAZI09jH6rWXnke5hTSpuGpEfw858S5ICUFYpmysJtUvyhJL1Njpdv7
	9FEVWTDv67rF0wPfAUu09nW7db7uSEEtcKL9mlT6sqzIsJqTYB0rtMHbqIxE7UA
X-Google-Smtp-Source: AGHT+IHWmUuzFm2NgWrxBw+GJHPWsqa1auCQBreCR2X2pHOkHboY1h0+LNMOIgKnDqiL6+vqpgONNw==
X-Received: by 2002:a17:902:d512:b0:216:1cfa:2bbf with SMTP id d9443c01a7336-21892a41ecbmr76928745ad.35.1734168028072;
        Sat, 14 Dec 2024 01:20:28 -0800 (PST)
Received: from localhost.localdomain ([1.213.237.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5d00csm9060345ad.202.2024.12.14.01.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 01:20:27 -0800 (PST)
From: Leesoo Ahn <lsahn@ooseel.net>
To: lsahn@ooseel.net
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: mm: fault: replace the behavior of fault_info[18]
Date: Sat, 14 Dec 2024 18:19:36 +0900
Message-ID: <20241214091937.203842-1-lsahn@ooseel.net>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the behavior of 18th element of fault_info with the 'fn' member to
do_sea(..) and 'name' to 'level -2 (translation table walk)' based on
the information[1] of the latest reference manual[2].

The information has described in the chapter, D24.2.40 of [2] and
DFSC[5:0] bit (stands for Data Fault Status Code).

[1]: Synchronous External abort on translation table walk, level -2
[2]: Arm Architecture Reference Manual, for A-profile architecture

Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
---
 arch/arm64/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index ef63651099a9..b1c08289a5cc 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -863,7 +863,7 @@ static const struct fault_info fault_info[] = {
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 permission fault"	},
 	{ do_sea,		SIGBUS,  BUS_OBJERR,	"synchronous external abort"	},
 	{ do_tag_check_fault,	SIGSEGV, SEGV_MTESERR,	"synchronous tag check fault"	},
-	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 18"			},
+	{ do_sea,		SIGKILL, SI_KERNEL,	"level -2 (translation table walk)"	},
 	{ do_sea,		SIGKILL, SI_KERNEL,	"level -1 (translation table walk)"	},
 	{ do_sea,		SIGKILL, SI_KERNEL,	"level 0 (translation table walk)"	},
 	{ do_sea,		SIGKILL, SI_KERNEL,	"level 1 (translation table walk)"	},
-- 
2.46.1


