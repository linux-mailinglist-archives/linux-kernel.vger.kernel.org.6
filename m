Return-Path: <linux-kernel+bounces-280874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BA294D04F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C984E1C213C4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2C31946B4;
	Fri,  9 Aug 2024 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiyMs+Pe"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E179F194120
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206877; cv=none; b=KF12mkw0bcBoLod3KwUyyr/EjsWBz1G4t8YE/jWgdT2SbXZ310IUWcXUrWlgi63t9jAIEZwJl9NCMVwKVFhfKxKaYb8pZ2dxSkgXLhSve8YRRxVXh8Kq+lpZokSMgqm9kP7uw/SZQQQbUu4RwQWwOyHfNT9I16yzrsgQ8St3qdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206877; c=relaxed/simple;
	bh=dFQRHkthV2CiGWZy7z+Br0AUOk55fvfBCAujfUth+ag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eC460S+xFbacQpJKgczEZVb0FtAHMuonTqHME1fDQsO5gO19JWjXQJVnevkZRd/80gQWU6huTfi68WF14amxIbzYOq6t4vx37Qf8K+1lFtoRpSi9ENA6lC+WjTM0vwdNF9yuZzwYx5F9iZ6ax815rWPdtzZFkiUZPNXG6G5Xg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XiyMs+Pe; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7d26c2297eso240202366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 05:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723206874; x=1723811674; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZDoeVn0Ui9DaBYyRf0yS/xJKDLJH8VgYEQMX6ljq/0=;
        b=XiyMs+PexbDUrvUz2Nls1SXA28OiFJAidssFsVyx+O/62AhitBne17u5Jj0MUZxILT
         Z8bAhCOB541b+4YsZNzd9L86loCGvZXGSr9Fo4A+ILgBIBP9aHPieCWMFZzoUkJ0Z5CE
         h0uvsv1nKh4kqEEDsx7enbLb1TK8FS94k9NTWmxox8XEOWlWH0eYPYvjPfyjzSK6s90i
         R8aKeviuP3YCNZUB5sWHK0DXCwCHhPEimE01wVetOwskh4ftbtSNrh9SuHOEy4IWt0AM
         5Zpjy/I9pyI+1xQpKqSMZT07YgfltJz1Hd08oNjAgDGzDdEh6Uixzsx1HLi59PCMazji
         ALfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723206874; x=1723811674;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZDoeVn0Ui9DaBYyRf0yS/xJKDLJH8VgYEQMX6ljq/0=;
        b=TnXkyeOCuuGtoeQMSUk7LTKmNNjUeZA24okfMBaIWYgtiqXk+zCvIHQ0VnkkFbkMe7
         0mCmOZgx9AWvcl41gZdgs/YIka/ibD0ALmzzioUIactNUnVJ/915IeQrx+Y68xsteokC
         cgJGaSoRI9AwFAm679dxBhmeFmZWbKq++nwzD8QS1yPnEbxZ7V7lVOyFyQkuhU3Vwzta
         sOZhA0nNjCbJuXJs21qRME4QkUo3bIY+XHV6CIs3LzWWf7yrbaVo8YE2HgPmodMG8Xfr
         fCDSZWKpMP4Pz4pP3i1ETc7RmjpQm7t3/2ZswewxdFO/cETNNYL3qHlKNzfhnjO2JGtP
         Pmpg==
X-Forwarded-Encrypted: i=1; AJvYcCUI35RxJt/mvRA3CNFHx8DnIOUpsJ3pMgafZRM9f+ovCCBx9rlskBdvWfUiJM5/5TLBUEMzlgrjOD8A5TPQWjhV6yD2mTpvoYqxjvUo
X-Gm-Message-State: AOJu0YwfZZzgGLpvBj3U4GBc8Ax0bs2wnAw534gAafsmvBees4JOkxnt
	KwGgDENE8E1h3tX9JCBNSUv+TDtkZtdO3Srb+R4IGtc1JDiVDTcE0sc7KQJ8yn8=
X-Google-Smtp-Source: AGHT+IHhcQkeSlgaiaLuH3O2urxwGk6K9tJx15iJPwIKKgrG2LT/FmwImrhs1ImaNZ2v2YJcFRxg3A==
X-Received: by 2002:a17:907:60cd:b0:a7a:ab8a:38f with SMTP id a640c23a62f3a-a80aa5fb107mr120044866b.41.1723206874085;
        Fri, 09 Aug 2024 05:34:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d4545dsm837841266b.124.2024.08.09.05.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 05:34:33 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:34:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Clark Williams <williams@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] rtla/osnoise: prevent NULL dereference in error handling
Message-ID: <f964ed1f-64d2-4fde-ad3e-708331f8f358@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If the "tool->data" allocation fails then there is no need to call
osnoise_free_top() and, in fact, doing so will lead to a NULL dereference.

Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 tools/tracing/rtla/src/osnoise_top.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index f594a44df840..2f756628613d 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -651,8 +651,10 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
 		return NULL;
 
 	tool->data = osnoise_alloc_top(nr_cpus);
-	if (!tool->data)
-		goto out_err;
+	if (!tool->data) {
+		osnoise_destroy_tool(tool);
+		return NULL;
+	}
 
 	tool->params = params;
 
@@ -660,11 +662,6 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
 				   osnoise_top_handler, NULL);
 
 	return tool;
-
-out_err:
-	osnoise_free_top(tool->data);
-	osnoise_destroy_tool(tool);
-	return NULL;
 }
 
 static int stop_tracing;
-- 
2.43.0


