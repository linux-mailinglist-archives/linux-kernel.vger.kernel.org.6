Return-Path: <linux-kernel+bounces-516258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A370A36EC9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 15:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679047A38CD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F451B532F;
	Sat, 15 Feb 2025 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuO2uV0T"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D288E56C
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739629416; cv=none; b=SAQiSPxNJ1nLHbtGiig4C0s859mNhq5B1kQk0D+9tQ3OxbWyhSz23kXOGf0OWcQtYDmINEQzfGTDPkXVPHwCuO61ueyLtjcp98rZSIbNKsdHMQHWVrjaDnOQCllhOCwGH3Rx5vV65T4y+pCSYGpcVgkl53uhp51OCecLLGJ5vNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739629416; c=relaxed/simple;
	bh=YOsBcF04Rgo/e5yx4NkTfmA/JJnUEXXNHCa0NThtskU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DSSQDcPqZEfg3mfXlYLvhj9L91y6w5RCpNDhxs+HuYN4cuY1ZmaplhawPLvz2Z/KjxWqxXJv9pZy8g4xuDbi7hBh8AFsIgn3C5NdnhuaESRr0pykBuVxuH1Qk1NX/4CXGghIm0BiSS1tyNEhc7iA18Ld44c7iKVHPK99WEw4U2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuO2uV0T; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso17923825e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 06:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739629413; x=1740234213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zrBOrH/58XmEm6HxVZRTW5XflwasEYktfKZVOBkPhuA=;
        b=RuO2uV0T0thzseCZXv8wQP581BS++8T0QtELfqSJawVgdEwuTnZEnp6Quh6CD0umgx
         KSZBq0+Z9KBA/lTH+kqBfH5g99cWEZAvWN/rhJ1q9OCB2AbSLGfeNWHdsGpnW2vwVnLv
         wlC4AY04YhmXjc9nDLKY023hrhGYMy/YTAwe8uRBdMZjn76GHIkmxgHDJYc6M+xUWKYd
         2uACak7xvURXT+RvMyk322V0fdAGZnlcvciqVVEnufWSRk0oR+0P+VQn4Gzd6x/KiLmc
         M0rlRdKNP7GY0Rq/RLsbe+bXze8OsCynAQPuK3952McAoRbnsXLefeU2fog3cSnZ/kfd
         BfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739629413; x=1740234213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrBOrH/58XmEm6HxVZRTW5XflwasEYktfKZVOBkPhuA=;
        b=d1mixTO9kFjRnntkJWl6m5mEW5bkV+fuYBTKvzUmMP4crD4ioUwDJKrHV8Vx6BpOqZ
         /kLPs4edIn1sSRPdgtF7AIQ4BKa27RAwpZeUYvSf59jLWxupehtaCyW1fSTQY8Irsp3F
         tflZG8lxi/nVeTLPLlwjByYNmnAepB8x+PNsJf/xbUJOMIqZaASZOSBsvZPmZ2lK0pGg
         zN8IrYwFMekNRxddHner2/y5jCyrVRw4tYJeS8wGt8OKD8rznvc++TeOst4xxH8wYeli
         rj9MfPMWTndvJLsn+Y3BB9LYhJkRa5tWs9yTWTxLdc1QtHkaaffgXuiV+KBso2lFkeoh
         dgEw==
X-Forwarded-Encrypted: i=1; AJvYcCWrd0Z3OKrM7380kNnIurdDkecs0MRlHrp1I4PDd0dnirIo3Xel725FWnu1WO/74SMsIbwvV+vWWD97BtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCvStxA3sVssmDba7WKZnNsQNi3TOHnl0ibVvfPW+ZoDHMbOV
	MClX3NwBHUGNzy0csqC3JTrs7kQLfesQdtIoXhy7xrXM46VFgI0Q
X-Gm-Gg: ASbGnct58S5SG9CqLF0QtUSK117cNl724R4mYVeBuTFbAAXSTVN9ae7Ks++v5Z2SOlK
	eVDudCBdZg2Gr4WqDjMdcL0OtjSQ1Ey1q2pRg2y344NW/WN7HWNKhzcP2iXo/3MsdAo9KuaXt9j
	9xe7/fyIYuxPuitL0E0x8OgNsQyMt6fCZdEjqFeuqreckSC3pphYggdOSlWy9q/afVGMwVh4mlt
	ICmMeJFpioqAEZoECpGfL+Ih9Dax7MODODjYz1TPjUa6awEjZDZroVUmG9b9R9isdOiMWbWCkTW
	boygb72W2sWrvFv2xA1cNYqK7ZcaW+5rs3KBYeHQMIWOAqez3Khem7e9o89sNZ0vc2em2Miy
X-Google-Smtp-Source: AGHT+IG1zBwXQOwoELC9+PsLFAhlbC6vGxbcAKHD0060X9IT4yvaOEN8c2sJV5NrqmZOo0dzrAbB4A==
X-Received: by 2002:a05:600c:54eb:b0:439:5d00:e78f with SMTP id 5b1f17b1804b1-43960c05dc0mr141040435e9.11.1739629413162;
        Sat, 15 Feb 2025 06:23:33 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b410dsm7347965f8f.5.2025.02.15.06.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 06:23:32 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/1] objdump: Fix disassembly if CROSS_COMPILE not set
Date: Sat, 15 Feb 2025 14:23:21 +0000
Message-Id: <20250215142321.14081-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CROSS_COMPILE isn't set and -v specified the code tries to run
	system("(null)objdump ....")
which really doesn't work very well.
Fix by changing NULL to "".

Fixes: ca653464dd097 ("objtool: Add verbose option for disassembling affected functions")
Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 753dbc4f8198..c1b771e772fd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4506,6 +4506,8 @@ static int disas_funcs(const char *funcs)
 	char *cmd;
 
 	cross_compile = getenv("CROSS_COMPILE");
+	if (!cross_compile)
+		cross_compile = "";
 
 	objdump_str = "%sobjdump -wdr %s | gawk -M -v _funcs='%s' '"
 			"BEGIN { split(_funcs, funcs); }"
-- 
2.39.5


