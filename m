Return-Path: <linux-kernel+bounces-218485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D398D90C070
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB64282E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5148D53C;
	Tue, 18 Jun 2024 00:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jqQ4iZjf"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A106545977
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718670993; cv=none; b=fg2qZvsPgVlLWLq0Okk8lGmg0UvWsbvQRhhS1KEviMvGTyDAtkaZs+1mqjjaYztC7PTm/GUPaoRvfEqqiRWpJO1I2i+lWtQIT/FXCKO/ueRaR4dQs1cx+OzoqSVyKfPLAKPptZTY3lmtLjKhFPujo8xv/O95MyL2pCZzOPVdapg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718670993; c=relaxed/simple;
	bh=dZBggxVjqVg/TaB130MCgxdtIA1h1/U5KPd47XJfcvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGCspBl6hXgeWHk5sJNbONe6WRU7MQUjZbqLAmWgJ+F4at2ZQbDKd9//qddonuXbcfTh0G1ULM6gQNw7qHjDReCTsxRHIUfbqDAfYIzsORuIQsOnTmyHUCf05Go0OQUWkpbVegjFinma03EZ3bidK3DdUL8W82OeoJ8niySUY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jqQ4iZjf; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-705c424ebbbso4626626b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718670990; x=1719275790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YzKFH+D6NQgHG9zhqd66xW8XxeSc0R9a3mp5TZ3Z+A=;
        b=jqQ4iZjfRNh2Jo22j2OgrpdRqN5kT89ngzEtxJmg2ufSmSl83L0ypYvS9E8+Sk0jbl
         MPwG4VPIwO/AUAXm88sZqkOfxApduLO7nxnAzKfE9oU3WfrepjI2LVCrW1sKPkJJrKiV
         MxFVndkguII/ZZsa0lTZU0uZU84HtUA7p5R5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718670990; x=1719275790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YzKFH+D6NQgHG9zhqd66xW8XxeSc0R9a3mp5TZ3Z+A=;
        b=aPCc+lisXjgps7kmc6uZ0AmpO7AyBvnK4jqOvX1K9eCy7hLMlNyRnn4s4ZC57SAGZc
         eQKA9WIsjmfWg/M2Uh4pFwGrA6RfNGPyQZCVjeziLaJkdkgbvhWcZC83BJ5iTRplvtas
         L6SwizUpr5Z1mRQrnkMW9x9Ap+m5mN74VvZBx2L9hAYN7PInVkxB2UpYYmkD47PTL9fW
         kkraN+jHIvCEZiLzVw74iXpZPR+/fhhl6FBPrmmKx8zHSpPB27yJOLelVBeOeZZfNazh
         WuAS6X/WcghZRETfToyboFNMgqHIw/PR0y/mELLNv2COoepOnhxxn2fh881jT+QAoi8B
         I9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWJl9yaSgmhsK+8niUaVjjOJKr4CAGWKHASvnVpzKDsBnOcYspCb9uqRE+vQ0Ex/KCGWun0Go+VMfNR/twTYbHdnE2qwHCbr+cm+MA1
X-Gm-Message-State: AOJu0YwypkbNSbiW6nJKky0l4v64WpMbue5JLTYuef4c8H7nSeHxu+im
	hh+XLjv7WAoONlRki+xWS+LX+xWnXL80naRUOrHtgvSzTN5jThOflkSISlxIXA==
X-Google-Smtp-Source: AGHT+IFS3RxVs2fnEd1ihyg8w8up89zEOy8fuhL1k7wY0FKmK/CaH0BVgZ641hCtcwhv6j8bgR00+Q==
X-Received: by 2002:a05:6a20:258c:b0:1b8:2211:b7e6 with SMTP id adf61e73a8af0-1bae802a38amr14462075637.49.1718670989991;
        Mon, 17 Jun 2024 17:36:29 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1798:e71b:11ad:8b94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb99f4dsm7905917b3a.216.2024.06.17.17.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:36:29 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Douglas Anderson <dianders@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] kdb: Add mdpW / mdpWcN commands
Date: Mon, 17 Jun 2024 17:34:46 -0700
Message-ID: <20240617173426.12.Ibed4a8f87371710c10b62a6621a5ccf054b2b7c9@changeid>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240618003546.4144638-1-dianders@chromium.org>
References: <20240618003546.4144638-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When specifying a physical address allow specifying the word side and
the number of words.

NOTE: we don't do this for the "mds" command since it's pretty much a
different beast.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 1a37c9bb505c..be72657741a5 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1653,10 +1653,10 @@ static int kdb_md(int argc, const char **argv)
 
 	if (kdb_md_parse_arg0("md", argv[0], &repeat, &bytesperword))
 		valid = true;
+	else if (kdb_md_parse_arg0("mdp", argv[0], &repeat, &bytesperword))
+		phys = valid = true;
 	else if (strcmp(argv[0], "mds") == 0)
 		valid = true;
-	else if (strcmp(argv[0], "mdp") == 0)
-		phys = valid = true;
 
 	if (!valid)
 		return KDB_NOTFOUND;
@@ -2705,6 +2705,18 @@ static kdbtab_t maintab[] = {
 		.help = "Display RAM given a physical address",
 		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
 	},
+	{	.name = "mdpW",
+		.func = kdb_md,
+		.usage = "<paddr> [<lines> [<radix>]]",
+		.help = "Display RAM given a PA using word size (W)",
+		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
+	},
+	{	.name = "mdpWcN",
+		.func = kdb_md,
+		.usage = "<paddr> [<lines> [<radix>]]",
+		.help = "Display RAM given a PA using word size (W); show N words",
+		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
+	},
 	{	.name = "mdr",
 		.func = kdb_mdr,
 		.usage = "<vaddr> <bytes>",
-- 
2.45.2.627.g7a2c4fd464-goog


