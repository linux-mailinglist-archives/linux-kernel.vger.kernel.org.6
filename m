Return-Path: <linux-kernel+bounces-238423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFD6924A7A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18F5B2428C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5305220FA9D;
	Tue,  2 Jul 2024 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpRoPp/1"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3666B205E34
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957500; cv=none; b=bGe+xH1PLRIFtuj3HI9K+CDpJKUfhrw3ZXD08kuX891AR10cBTZxm9+ZpInbPaLedF5r3x0Wkfs2I79IxByiu+nEFSyFXws5t6fGNkRNAfK71SdRn+Na1BPxg+TNT/VQeLtRKtVBADfG/Lsdcmq3GqrROYd3oUfGX0zuhTuT8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957500; c=relaxed/simple;
	bh=SicJpcI+BtX1T3osyqjgxwJrfmLN+824rrUnpMOe6aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxtKAwcdpOQ8pHZUoyaYkZgHxo7hO6ic/+rq/B7zJ3PcG1C4yU2iVZ7W1YzAVOjMX4M2QE+U6IVZgRuFkeT3ZAvQa+aO+17vUG/27Dw6qSpiLW4m7aqApoFnNek1N4Lt6rv7jlUTSdOv5qN2N2traS+947Bjq2iZL3lm/+tbJkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpRoPp/1; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7eb5dd9f994so174407539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957498; x=1720562298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gHhZlZC9lRM4IBPTZ/FMwaYyy9pebB6jMENYSRc4Ds=;
        b=kpRoPp/1CbogXTPVq7cwDlzJRTSwFtINlL4Abd+NSWd8e3kASR3l8XKMscJi9GIbR+
         9za6Bzi8+zJ5RJuWgnk7zApyc0S1Xdn2cVUG5/TH7Ykw/3rdzEE6rnyPPWMuTk2WnurR
         S17JhUdrROGb9/L8yWio1ExWKLiWtpnsW9zQgqO6pyHy2o5hZJig2+NY2IUmULIB7HcK
         3ffIwklI3k1jM9ThsMcqnmWtXA4FQXBE8/g5fZ/++d0N27L9fN2WMCeZIIUZpwyihWhS
         MALRAdBMBST+h1QzliXKgbiOPvwTrWHHaKwr3qittIb/qVstX/Um7a9PXCptmmxF7ipW
         px6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957498; x=1720562298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gHhZlZC9lRM4IBPTZ/FMwaYyy9pebB6jMENYSRc4Ds=;
        b=fP1V1s1u5yYe8ndXeq5+Z3mNjroeaCrUCkZd0Na+IPtJ7J9zHIedTiwWzWgZXHD1gw
         QV2q86vizkciMHmpoxzal8TF82Nvjm1j4kg2zSBtrvEKxUVvmz/C4CGK3YZFsOrDdnyy
         r8GjACMVSAr4LuC93cyDe0KEkCQpyUe1od9m77kk6g8/AXonVZmfvpwGIf9Oq7dC9TQ4
         2KJxO2hU8LaXjttnfAUQOQjWfJCcM0AkUOl/plvzwGtqPptSynIuVNwLmxXMscqRptKh
         iAYJAYgX+DejP7xWRZMb9Pzpyn/gNbBMQxj0C6kB33paI99l1ym3rqPXyRqCDRWU5W1F
         rRuQ==
X-Gm-Message-State: AOJu0Yx0Uttu7Ctmi5wN3DvXYrZUTbBGxcU7SQr3u3HpUXM/RRWYa9la
	oekgyMkwoQn5cm3YW6itn+5fSyYr6bGD7BywxKS0YgXtSTOdWKFM
X-Google-Smtp-Source: AGHT+IGvsn87+MenBdfimxbbj/1jff8gsxfSw490RrEkjixo7jQ/GQOm1e+Gm6LnX0EupXDxk6SVWg==
X-Received: by 2002:a05:6602:1651:b0:7f6:51ac:bba9 with SMTP id ca18e2360f4ac-7f651acbd92mr409433439f.10.1719957498297;
        Tue, 02 Jul 2024 14:58:18 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:17 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 03/52] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
Date: Tue,  2 Jul 2024 15:56:53 -0600
Message-ID: <20240702215804.2201271-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a dyndbg classname is unknown to a kernel module (as before
previous patch), the callsite is un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it exceedingly greppable.

NB: pr_debugs are only alterable via >control, and to protect class'd
debug's from unintended alteration, "class name" must be given to
change them.  Classmaps map known classes to reserved .class_ids (the
1..64 val range per module).

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f2c5e7910bb1..73ccf947d4aa 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1154,7 +1154,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_puts(m, "\n");
 
-- 
2.45.2


