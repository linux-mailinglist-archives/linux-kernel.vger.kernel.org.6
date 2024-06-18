Return-Path: <linux-kernel+bounces-218473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B91290C05C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336AF1F2203B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0735C89;
	Tue, 18 Jun 2024 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="btXWoUqx"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0633817FE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718670969; cv=none; b=O0VOfRDwPELaBXge4JH+n/Gcs9SkS5itKUU9JijPBpDF2+8+ddGS15Wps6h25M8HMf30x/kkTwl/ctg1iXvggamU5hSiqCfstr+FSQVFdfWoFzNJdhb7WI6Eyq9jB2nFx+9etd3ROUpXF573GOctytya1NVHMZuN+ysSF4Bpeyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718670969; c=relaxed/simple;
	bh=x5hewR0DqmjMgAAfoswmaLPzRU+O8ZTQi8OsSrWgRvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVtoa3coepZD8VpSeGTHemuv9uDMs5Be61azvoaSX5FzD+/GyR+5v8RcyZhY7lratjHFe9IAx2NIKTUoCxsMXTdqCPETfG6ehpzIFYIDwTpyq5aciH/LTnKZsYe2BcD8MCHsMVu61SiBubRDp6N1etjvlSRBsC28N4X5+At7btI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=btXWoUqx; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-70df2135426so307190a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718670967; x=1719275767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omgt9hawKdl/cfJMYFE11rv/XXi1ULnu+83s0osHk00=;
        b=btXWoUqxgOlDrnG9wwfVkS/AdUZCAlPhJiM74ZqfTVfRY5gJ6LMT1QE9prqW+Q8qT4
         xFg0s9O/SfhXY5Cp/cLYdjbeqAe2v5uepmTVxAI5AE1MeGK76wAsYkcVeckImDVonnnU
         aUfVma3/dFZg/RzZHFowQ0CmuTITRuOW3HaaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718670967; x=1719275767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omgt9hawKdl/cfJMYFE11rv/XXi1ULnu+83s0osHk00=;
        b=mu0G7v5kurpA4J8DK6xwTfnyFP9c/qkPt0EjwJ/7Z2mqIvzMIzEpFPal4kljaM3um5
         QJcWHHUJbG9K1rSE6CF/moxHF9c/OSCCbNfdCqXA9SWaHrfDiwXOTTYkLSKcYhMbXyJo
         ZAoW5+8d9TZtHIizJ8+sE3Habo8hyYKDoNftauz3g1DWV9Vpur8mhoiWMDc3WxCOGFnR
         FT94gKdgMoPpu6C26q6kODoVKhg0YJu5d/ZQpkPSPmiId+5+la99c96FpOG1TWXHHwbX
         IzslN0ioHipVFl3yGiMQV90xKcsaLeKF3GCSRy/N1TkFd29fvixcz//qutNeUeQTRY7G
         0ukw==
X-Forwarded-Encrypted: i=1; AJvYcCV+CI3T7sjuhVDW1Os5KlY7pXoFij/ezx2qRINWuwT5J3PQ1+Ydj2kDuDm8POpTAIhlEciAEHi8aj0Vit1RRrg6Dufk43Cx27R7198G
X-Gm-Message-State: AOJu0YzR7snPxVlDbLTrUaLH30SP0H7cOBC9MK738pBbc2pvEZjuZibR
	mSyQVFM3/ja+pMMf2qxNeoABYOpzf2Occh50b8ANiBFpSBMWCFwDlEpt/BdfCw==
X-Google-Smtp-Source: AGHT+IHtbC25s0aTUY1ZqOaNeu7VCFF+xc9eyM0e3dUxN0EAX7KLndR1scK8IXp/tiR+XWvQvp1LNw==
X-Received: by 2002:a05:6a20:841d:b0:1b5:d00e:98d7 with SMTP id adf61e73a8af0-1bae7ff15bamr12235079637.24.1718670967267;
        Mon, 17 Jun 2024 17:36:07 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1798:e71b:11ad:8b94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb99f4dsm7905917b3a.216.2024.06.17.17.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:36:06 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Douglas Anderson <dianders@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] kdb: Get rid of "minlen" for the "md" command
Date: Mon, 17 Jun 2024 17:34:35 -0700
Message-ID: <20240617173426.1.I0535f656e94cc475de6b04652aef4f9e9fb45f49@changeid>
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

The "minlen" field should allow us to abbreviate the "md" command as
just "m". However, the kdb_md() function does a lot of checking of
argv[0] and the logic there simply doesn't handle if argv[0] is just
"m". While this could be fixed, "m" isn't really unique (it could be
the prefix for "mm" also) and it's only saving one letter. Remove the
setting of "minlen" to 1 for "md".

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
While digging into this, I found that "minlen" doesn't seem to mean
what's documented in the structure (AKA "Minimum legal # cmd chars
required"). If it worked as documented then you could abbreviate
"summary" with "summ", "summa", and "summar". In fact due to the
parameters passed to strncmp() only "summ" works as an
abbreviation. Fixing that could happen in a future patch if someone
were so inclined, but they'd have to decide whether to change the
behavior of kdb or whether to change the comment and keep the
behavior.

 kernel/debug/kdb/kdb_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 664bae55f2c9..cbeb203785b4 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2679,7 +2679,6 @@ static kdbtab_t maintab[] = {
 		.func = kdb_md,
 		.usage = "<vaddr>",
 		.help = "Display Memory Contents, also mdWcN, e.g. md8c1",
-		.minlen = 1,
 		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
 	},
 	{	.name = "mdr",
-- 
2.45.2.627.g7a2c4fd464-goog


