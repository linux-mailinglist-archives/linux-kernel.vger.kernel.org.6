Return-Path: <linux-kernel+bounces-181393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A252D8C7B86
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD30280FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A528615886C;
	Thu, 16 May 2024 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa28q5C7"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C01586D5
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881464; cv=none; b=RGIiUaJT1L8gRs5pjQfrma2shRt44/tsof1RRet/2Sh3+r+Vaw/w4hZdG9VQEFlbIsumQuKTMPBKyw2XUYvLb2sE6ZmQEqgup/k+X806Mb+cUx0rgpgTxmbhcUM/wrHd4m4zRrNNEi+pcZq8ABd9vUSPes+tW1MrbQ5hiIjgyP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881464; c=relaxed/simple;
	bh=iO0MZt52UGy5H1+g6AWhRjkXHqyP+g8jdyAnsD2e2M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uyr2Ny3vb36m/qiFa89Z0gy99S8s0mOlmEEfYHNRNfE10ZQSdJuPyvEXdpEUQ7UPcb3ZVK4XdBo6FM1ozmxAqDXeNspy8PjDKx+O6bXo9xn+6IMdkuogreQytO49f/pM/sRfhTT555LpBZqwa5ArKvdmkja31YRPKLj1vGtHIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa28q5C7; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7e1b8e3070aso63224339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881462; x=1716486262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mt/Bqz8yq2vitOa6vLYoJ1/uTqX72QPUfR10FKnlVc4=;
        b=Aa28q5C7i1EdG1586w6ZiwgREwPAO4yUqq4XbOCFj4S0zdv6UneMw3kIuV9aGIgp4p
         GVd3YX1nvNFEDBWigtsTTgn+Nx8Qycpg0lWprl5hkMnBBL3iKuWCAhiPegecGR83jqAh
         JUv1VgsMxrugS1QbZIYMbcihBWrZwsPnQ9UgP/oEYC+zMoZclAtblaeDGcdiPUMt0Vh9
         qDeW0EtPjoT98te5EHYBYLHsGfUu9rkhNxP5DD+SrYRhremSLO3oQHODhxUDYlQ0CeMX
         Oy8HdjzHMx+3Y3A3flJl7FlauaBrdtv3EDHCooTz/6rtPsVLXJDDaMGnKga+T1l3YU6m
         cPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881462; x=1716486262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mt/Bqz8yq2vitOa6vLYoJ1/uTqX72QPUfR10FKnlVc4=;
        b=QL7zupvN6m3/qCRcPEm+OeLIogl0R3+tK5Nv3kh52ZsINUcfdmKDDFpJJe6AuDDoFd
         aG/fTd5X4XL/dd37lg/THMl6IAth8erSWOV2HbUfAdM+wdWwhor7EIr1dDJUu97TwSVM
         zdbIMjC+PDeCsBZCpGuDJtHKW/fYTPobyZo2oNLkBBto8xH4M2sV2ffOzvEQ6oF3jRRJ
         aWoIGSN2FfUbb/d/TaLXHqd+4QGVidB67HKcT2PH7zew8tpi6BD+xGIpkq9qQBMkzK7R
         rxaxdc6v6iHBt2p/zt2UCTtEkZ3bHKrYUk7JBgSH5IUQDpHAjggPHweDylT7DAALJSap
         37Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUY5eTfRjgEoOsX5xhlPe63enZyOz8PSqfgykhBvkT92p2TRP5OyPniht8Bi3zv3v7FcFicG4Qdq74reXOsIQpohunFslBx4FumdeWa
X-Gm-Message-State: AOJu0YymjfTNJ++Wp3oD7GDPDm9gmpfBQsc+izF3aVYuMPggiLQ+/mvZ
	lr4SdWLibOe+mhT9WCqFqB9xvnZdPGcgrUgrvvZbq9jfSNE8ijWO
X-Google-Smtp-Source: AGHT+IGdYGsd3uiXdSUv74wkg3MOKXq35Pa4NZvpFjNk3CNfp7BjHn5hkIKln1xsbsv61dHhk4cSGw==
X-Received: by 2002:a05:6602:97:b0:7da:303c:b056 with SMTP id ca18e2360f4ac-7e1b51e331cmr2129969839f.10.1715881461680;
        Thu, 16 May 2024 10:44:21 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:44:21 -0700 (PDT)
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
Subject: [PATCH v8-RESEND 11/33] dyndbg: tighten ddebug_class_name() 1st arg type
Date: Thu, 16 May 2024 11:43:35 -0600
Message-ID: <20240516174357.26755-12-jim.cromie@gmail.com>
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

Change function's 1st arg-type, and deref in the caller.
The fn doesn't need any other fields in the struct.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8320cadeb251..882354e1e78f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1120,12 +1120,12 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 #define class_in_range(class_id, map)					\
 	(class_id >= map->base && class_id < map->base + map->length)
 
-static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
+static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map = iter->table->classes;
-	int i, nc = iter->table->num_classes;
+	struct ddebug_class_map *map = dt->classes;
+	int i;
 
-	for (i = 0; i < nc; i++, map++)
+	for (i = 0; i < dt->num_classes; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1159,7 +1159,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_puts(m, "\"");
 
 	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
-		class = ddebug_class_name(iter, dp);
+		class = ddebug_class_name(iter->table, dp);
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-- 
2.45.0


