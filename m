Return-Path: <linux-kernel+bounces-188322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A2F8CE07C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 06:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597551C211C0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA40E3B1AC;
	Fri, 24 May 2024 04:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxrK9Imb"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EAB3BBD8
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 04:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716526437; cv=none; b=jXFBGh/kKf4q6L7l66zL3THDeBMH+4e+xgNVlaXqfC3fSjJg7EbIPISjERk/eqesqHaJOdmXbohyy8L+ofRShe8DgnFuSKsd3BaCuhD69s0Ivps1wsx2OmUeMf6oV2JILht17hJEVPv+MdqW4uxHhiMrNIVPbKuHvoeCsMyqPsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716526437; c=relaxed/simple;
	bh=gvZu8w0rUyRAs6mCEAunAScGuNPqwLhrRY7xPvkQKvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GoZIRm8TsQzlFaMbyjh0gg3FXlKa7j7iRQDXI9T/YfJr7jSrublc2ccYajAu3ibJLR/msnLtbnFPfe3LtZLtRi1xjfyKT0fCGt06CbftaQABJ7pKjVQHtmLO3xHSC2lI3g0Rdeb8YLdVFj8+kv58ChKbgR4s8hE/zf/dUlR+qQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxrK9Imb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f4603237e0so1977791b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716526435; x=1717131235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeZ2M4BqAFyvDn0M4gwVlrKswbQmxbPvIOPmTf6imKU=;
        b=SxrK9Imb1hFo7IKnIPYyFvsECf6oCaV0GIRvXss7f03BLv6tstdV5JiNDpInnera72
         ph2VuLP6vZHkyfkW5clDNcF6OklqVT8AwBAobVMP/huIUjEISDtOhzPEvRwTiQGFFbh/
         mUV+B/DhbqSsKu1EiVAeG8RA9Duan4M3W7A6ma6cyk8uiQmqMiQzQMLnZdcsJHCHRamp
         twQPozeZCVo2UyHRJRyGTm85Rb4U8HzXcaBzm7PXAsNWPPJRLfA3EAXvaa+iGu1J3vev
         Y1QqgUTGBKgs4MH8SmQH4nQfGbEhpSjne36AwIt4Dnn26js6+g6ho5fAAOQ8BaBuMKdo
         cKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716526435; x=1717131235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeZ2M4BqAFyvDn0M4gwVlrKswbQmxbPvIOPmTf6imKU=;
        b=GGkk3uDbvlojlEEtCvSs2S2oM0sLgnDknQ21ZECvXHfgv91InmWjVyKvbUNlMDEOz+
         suOnKXU3kASS5qXbTwYLTAbUV2yCLt6gwR0WL2ZisZ0QH5JYRsWKVm84aSHO0/OJZ9y1
         obu1A5qqbNDrDqWkEgPXGRkyfyuueB06tI8GLQnUKueUsBkg48Ds7p2fhLUtlTixBEEq
         uCi2kA34wJdWbz4WkWjxorcIO68WNTzwwwL6xt+mB0O/bj4epifMOpKTzyTJDYjOucts
         JC2Fu4rWcRsvJ3Cn22rsrBfc/uR7RsPkYgE5LVPV/1vtJUAD3nTvsQZxENsov4jXklA2
         1pfA==
X-Gm-Message-State: AOJu0Yw6J4gwn2TTBKFNLsFHiRUu7BJHUUizK74SCxeDHdHDDudIejUm
	aqqaCMrN8AbMPZga9DGj11ROMWgHCelzIGuRx+DbpwwauLh8fTIF9dX/R+Zl3FAHQw==
X-Google-Smtp-Source: AGHT+IGglxs725oP0CWuAhXr6pa0jMNX1dWN+lt79kz9rZEUDdOhAJT61rrzM4P7cUeSMq4Ns9h1KA==
X-Received: by 2002:a05:6a21:3998:b0:1af:86e4:bc99 with SMTP id adf61e73a8af0-1b212cecbfemr1813196637.10.1716526435072;
        Thu, 23 May 2024 21:53:55 -0700 (PDT)
Received: from localhost.localdomain ([223.104.43.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682274ba9edsm362179a12.90.2024.05.23.21.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 21:53:54 -0700 (PDT)
From: Xiong Nandi <xndchn@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	quic_bjorande@quicinc.com,
	cmllamas@google.com,
	quic_eberman@quicinc.com,
	Xiong Nandi <xndchn@gmail.com>
Subject: [PATCH v3 2/2] scripts/decode_stacktrace.sh: better support to ARM32 module stack trace
Date: Fri, 24 May 2024 12:26:00 +0800
Message-Id: <20240524042600.14738-3-xndchn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524042600.14738-1-xndchn@gmail.com>
References: <20240524042600.14738-1-xndchn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes there is special characters around module name in stack trace,
such as ARM32 with BACKTRACE_VERBOSE in "(%pS)" format, such as:
[<806e4845>] (dump_stack_lvl) from [<7f806013>] (hello_init+0x13/0x1000 [test])

In this case, $module will be "[test])", the trace can be decoded by stripping
the right parenthesis firstly:
(dump_stack_lvl) from hello_init (/foo/test.c:10) test

Signed-off-by: Xiong Nandi <xndchn@gmail.com>
Suggested-by: Elliot Berman <quic_eberman@quicinc.com>
---
 scripts/decode_stacktrace.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 2bc3a54ff..a0f50a5b4 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -283,6 +283,9 @@ handle_line() {
 
 	if [[ ${words[$last]} =~ \[([^]]+)\] ]]; then
 		module=${words[$last]}
+		# some traces format is "(%pS)", which like "(foo+0x0/0x1 [bar])"
+		# so $module may like "[bar])". Strip the right parenthesis firstly
+		module=${module%\)}
 		module=${module#\[}
 		module=${module%\]}
 		modbuildid=${module#* }
-- 
2.34.1


