Return-Path: <linux-kernel+bounces-300586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110D095E588
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6DF1F216F4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C666F2F8;
	Sun, 25 Aug 2024 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="d4RNZMxV"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9254BE6F
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 22:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724623945; cv=none; b=OBZfhEcXt6J6IfIs4xCE1ulGFc+g/evXE1frKvc+9OpA0RL20MoP0RMHVhjLrDnegm21+CwcYRn9qx2O8PMXJyewxxDpK9w3l5HfN+emwRbfa82/mOpPhe0uKBeZsVGUw/fbNrXRTYXYuhTUehIcQZEEOJ9OvGmrsKTufwH4ym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724623945; c=relaxed/simple;
	bh=u7bZboGDT/+N4wx9kwp+DbHrbF5tN4GndeUgN/OI3FM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qDaFPrFVfGfoOAWS9DuAIf2R6Udcs9SlNaw4/8QFRVIlZiDd39lgOC5AWfdu2C5SKY47N/tNqNAGB6DEo8U/cExsMpQ6u7j/4j1NReHlVPaYlohA0Xt//I+oki+HcfTkNlce4nSCxgJiA1X5jT5vfU4ZYzBDmZ6Ac35nxt+ZjV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=d4RNZMxV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5beccb39961so562776a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 15:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724623942; x=1725228742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pLJRN2Vp+Xf3fcbCfRIg89MO+eFyJ8s3GETZxSreGxQ=;
        b=d4RNZMxVMkeZBr43A5NXT777Hbidkloaoy/Jvlu3VZpRxBLEgv3uL6zE5WfDEIBiav
         Hu8RsMB99QjL3ExBmalhxJraoiEgItXURuOBUCu+LNk5y2obclk8HWKDrDJfgzCzJF1q
         8Z2agzgTJxw3gkm674EhaVJUWBplrm/wY9ler8f46LL/q/P0npUCBKIxLUceqv1cN8ZS
         ZGkgyD/bCIv/pO3aqbplF3FqpGWDKBUDFwsq8WHiG7iAqtXRDzoAiPuRKLFrdy1sOp6l
         8q+nXNnxf1h0K1FvQp02eHZPJIBi0Oi6QcDdB0XDEWB5dWyKTJ2coouUGo5tJlX9+zWg
         tOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724623942; x=1725228742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLJRN2Vp+Xf3fcbCfRIg89MO+eFyJ8s3GETZxSreGxQ=;
        b=a0NOCrOr6XBeFV36z8LMALhqcMiF5xykKwtoPBQIh360vUKy7OWEd9D2XyN3SHzgQb
         aaHTAH//sxKCEO+eLk9+1qr4KhzdJ7l7/Ra8TYvFaZk3cZA+Hay0JvutmdScbwMVZy+k
         3bNO4JV/7ZbSXtKo5SASsT0LOpERlpC4MijePBsHLgUDXLY6076aZBWvhB6g5MjjCQqd
         J9T8O2nsA3Yy2z6pZFInRXLF/zk4im1UhSnH1uT/ZQoQQWrRrlOdOc5QaO3EWkFVI9We
         OBiTsI4zlBuFt/IYzZry0jz7Uvp2BZGtMRHe/0BuFoDenrb9n8JZV2V7gQw8PbtJpUQj
         X//A==
X-Gm-Message-State: AOJu0YwcF5dqBsmxCOe7fpY4ynLYygwU1ExQJIDcT3EyHYUDCNe9frHs
	JprjPCPACy3IMQ21+oLVujeNuwLz/1DqHYfbdtmCsU6nh1EgdIACYkaOtAfOgOk=
X-Google-Smtp-Source: AGHT+IG1Oql87HzzfcogalMXlHEKmOLUoG555y/F2Kg+5hoOOB5r3rMj6QoEfDlaVrO5gOYdmK5UDQ==
X-Received: by 2002:a17:907:94cd:b0:a7d:a4d2:a2c2 with SMTP id a640c23a62f3a-a86a54e7659mr226450166b.10.1724623941912;
        Sun, 25 Aug 2024 15:12:21 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f47c505sm588293166b.147.2024.08.25.15.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 15:12:21 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: tglx@linutronix.de,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] cpu: Fix W=1 build kernel-doc warning
Date: Mon, 26 Aug 2024 00:11:53 +0200
Message-ID: <20240825221152.71951-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building the kernel with W=1 generates the following warning:

  kernel/cpu.c:2693: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

The function topology_is_core_online() is a simple helper function and
doesn't need a kernel-doc comment.

Use a normal comment instead to remove this warning.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index b1fd2a3db91a..852ff634d86f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2689,7 +2689,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	return ret;
 }
 
-/**
+/*
  * Check if the core a CPU belongs to is online
  */
 #if !defined(topology_is_core_online)
-- 
2.46.0


