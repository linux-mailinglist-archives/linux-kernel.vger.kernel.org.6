Return-Path: <linux-kernel+bounces-181395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33148C7B88
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C86CB21F00
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A506158A1D;
	Thu, 16 May 2024 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV4huTzr"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72015886B
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881465; cv=none; b=qZ1xbqOdQOQ4zSczsW8mNV+Qm8XrQ5pFOB89p+xRVcgsIZlih5DwYQR8jiwimBqMcUOGsf2O6gaAA6dYjumIzzjjKa2YIo19c/gtErLJ2+OedF3trE5URhryjrzj+RP1ayLzqiFaC5hBJJ8YOn+TZ0yxPoD4RXTOg+inVWQ4uvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881465; c=relaxed/simple;
	bh=1zJyuDbvdt76ut8RigK/vWcBb0NOz4ONeWxuQgM86HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cW5GyN+nZwPKCe5b57LzWJ6h6StA9AVhwb4LddXVeueV9NnSJ3FxhM2uvKBGpSlUl1W3pLCSs4khIE0QEZkOZc3gbltjShFaC2TpMckWaYMvMXrvO62zAMYHK/2RmikiGcOO57NyYxMn4GB9CiIwbsuh1MT94nqeb4ldM78IgyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV4huTzr; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e1fcd2e6a4so68406739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881464; x=1716486264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW/yUhWkDFIutai+S2266F3/sOkg2CArhcP/x13Dl2Q=;
        b=GV4huTzrrrhJbSWh+zN/Vn85oPShISKxvljFVMmAUiiGAaoy8hL+jRf6+VdBfKIjuJ
         67PKX+WVJ0IKTMRMTZNhWAj0vfAfmAvtszP32p4Tk5MWc5CalBDt/A68tBxxyIEozl0k
         cEWod84McIZw7fiyojeRu1KAt3v5Tvzr5xO29lSFWlE1KlMDmV/x2/I3rbJCy5AiVZe4
         ukGwxy8YGt3fyx24XZgppzsuiHFXlkprSxqg2VMt5aLg2bhK3J7I93ZG4gDfjczB1eCw
         Nc2PWSZu1Cup0nkDqqmEuGRJkyzhdOP2oNI2jnxK2wGAIWhKh3nIXpROCz3Le83WaTcT
         9VTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881464; x=1716486264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW/yUhWkDFIutai+S2266F3/sOkg2CArhcP/x13Dl2Q=;
        b=I+8NqLH5sLUOS2ZDXfReqNQ3EMyIB1mKh8uHWzgaRQmOOVSyf048T/X3ueVMaeXm0Q
         nGHxMkK+a9073pwFjf5/mVr6m7CtZJTvPgnDy0FUG35F7fSKzmrdUJjMIXy2Qe1ThhGB
         AsIrZoN6HvsUGA7p04O1uC655y/+N3MTjAttg4YyIMvTRyS3hJWFWxt6ZfE4evSTZ5rw
         +pBvQ5f2EDfnLIUKPPahT1nDFEiiubqPMMX9jsFX41s3PJmPaCkMvThsiXQq+f/YwYhy
         fFvNykPI0rej6RIahh29irLLIj5WZSf/lBNanrJn5ByaVgLe0CZBZbyrYeitxWKnmJge
         3Alw==
X-Forwarded-Encrypted: i=1; AJvYcCWbFWm1A1DhI/6jufqC7F3n5kLvHnaOM09f+DEswSEFe0w2fo8FxvZZROLPEtprxsh6gka+MneWx5pM7tUm9s7kj9v0H1go6pKCjPzM
X-Gm-Message-State: AOJu0YwznYjWeDs28SJCQcioUtaCrvHuFzFWjawxdyUviC6MHFYWNrrf
	/7nSG54IKM7/hZ+iLPrxE5zSUXSYl50StKWH+uDaAWbKOgeM0QIq
X-Google-Smtp-Source: AGHT+IGKvXM7HiYApge8E9iHu3CPKE8EAuEa+F+s+rWEqnJnm+wJU4zHZoweXZYq2tnSMwYjgjJAHg==
X-Received: by 2002:a05:6602:21c2:b0:7e1:839e:5ab1 with SMTP id ca18e2360f4ac-7e1b520c50bmr2909385539f.18.1715881463929;
        Thu, 16 May 2024 10:44:23 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:44:23 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8-RESEND 13/33] dyndbg: reduce verbose=3 messages in ddebug_add_module
Date: Thu, 16 May 2024 11:43:37 -0600
Message-ID: <20240516174357.26755-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516174357.26755-1-jim.cromie@gmail.com>
References: <20240516174357.26755-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When modprobing a module, dyndbg currently logs/says "add-module", and
then "skipping" if the module has no prdbgs.  Instead just check 1st
and return quietly.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d4a0ae31d059..43a8e04b8599 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1245,11 +1245,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	v3pr_info("add-module: %s.%d sites\n", modname, di->num_descs);
-	if (!di->num_descs) {
-		v3pr_info(" skip %s\n", modname);
+	if (!di->num_descs)
 		return 0;
-	}
+
+	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
-- 
2.45.0


