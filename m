Return-Path: <linux-kernel+bounces-377507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3572D9ABFC3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3295281821
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB77153BD7;
	Wed, 23 Oct 2024 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0UvUMkb"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B71414F10E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667186; cv=none; b=bc3z519M1BzoVsB91LbGu/Vqqn9zACCSSExHfhZ3dXGPuWMLEaQX7T5ZMaj5CWCPjpSTZxLqKySfuFfFMFyGzqik9LnvlIVCvfeFYKqlJe1gVtVUi+QC95KsidHYRYys3hbFJiKWtFkXGLIIiX26nPs4Cp0ZwUBQf5XeR3XbOEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667186; c=relaxed/simple;
	bh=XoHUoJsrswRGxjRl6sDRxsflPiQBKRUxRfRYpDwBas0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bN9Q8S7t5eU/0bVWsh3pLYn/Zbx2ObbMU4PxImzaoH5kkYJ++XG+erJbn1pSdCanVNHPVuQP9lV9DQo3FSa67sBhmpEDiEgUoTHibyx0eVRaDHcDxw1z4j5iqBmhlCMBWOMljhUQ3qR/Fszia+9yy94Yo2XDdZnx0B5Zkm+G/fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0UvUMkb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so5784359f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 00:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729667183; x=1730271983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yfTTWreZVW5LY5QClNfyq728uUh/+v+MiaH1C99PVt4=;
        b=I0UvUMkbo3XC3NNI85tUE6yT8/EQn8zmZ0aREoe/LdUV/J3H8/d2TvhMp+PoJNAjOp
         6qSA0uDZQ2YyWPM6BifuOR9SsfKrhgzRWmisM6Hvz2IOMLBkr0EN+OlvjemwAnO0O/fL
         PNbzlnIgSnOphUoY3BvZ6k6+QmFW2zaSE//WCuN47mhGtEK6A9p7vFk8QvYR6UAT65f9
         7Y0/+jjstg0cIxNECQjPPF6Rl3rjgO2nsA6RFsfPCscIPMoKCuzry2+YAJezUm8BCdB5
         uGgauJzDY9vvu8DKdrH9t6a60k4v4T70fEWwnRHmwEwrSyU29swB0k+pW+OGXOBPM7Q2
         mvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729667183; x=1730271983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfTTWreZVW5LY5QClNfyq728uUh/+v+MiaH1C99PVt4=;
        b=dbRVw7+M+PCbUnT1+MpXFwvSvNQoGnkNO+Fikzsx269fwTuCorp7bnsBru6F9RZRJV
         QW0LkxHy52w7Kewt2QeAYaXFVaBfA8GVPHkH5IhXeFDl7rOlyYZtNDe8f494Fb58oauE
         2erszIaNC7C5sJArf+FQcIC8bq8GEJ0w6cRXt2/GFgv1tRjBTZEJp6fJRYH7UMxZZSy2
         qpOq9r+xxJpk2qqE+zgJpq+TULGaTzhEy0VnMX89oVTVd7TpLO7uJRAfR8+LTvYFzaGS
         Qm3o5n6JJWUJt8Q0dy65gQjw7p+Xk+5tItGCoEVIyglU8Cr7rNQ0Q4ZlaiTux1D4k2m8
         Zv4w==
X-Gm-Message-State: AOJu0YxlEWIdnkuY0+t05lyq9XfVWpPryV67PRjDrXC6We6MpMb/ZnOS
	YoxuNQHu9Ty07Xl5XKGuTgAwib4KhOHeD5E1Z5/lO9su0HC42hpBqnfN9K/hTSs=
X-Google-Smtp-Source: AGHT+IGx77prV81rpRKWF2iShgmXw9axXlF4bLHAfsjP2F6ZI7ageC/XK84UTh1SQNx50KiALKTSNg==
X-Received: by 2002:adf:e386:0:b0:37d:53d1:84f2 with SMTP id ffacd0b85a97d-37efceeddfdmr1248569f8f.11.1729667182969;
        Wed, 23 Oct 2024 00:06:22 -0700 (PDT)
Received: from localhost.localdomain ([5.28.129.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9410dsm8212285f8f.79.2024.10.23.00.06.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Oct 2024 00:06:22 -0700 (PDT)
From: Liad Peretz <liad.per@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	bhe@redhat.com,
	hbathini@linux.ibm.com,
	yang.lee@linux.alibaba.com,
	david@redhat.com,
	liad.per@gmail.com
Subject: [PATCH] Makefile: Remove unused filechk_cat
Date: Wed, 23 Oct 2024 10:06:11 +0300
Message-Id: <20241023070611.67449-1-liad.per@gmail.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Liad Peretz <liad.per@gmail.com>
---
 kernel/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/Makefile b/kernel/Makefile
index 87866b037fbe..ca2dfa4343f0 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -146,8 +146,6 @@ targets += config_data config_data.gz
 $(obj)/config_data.gz: $(obj)/config_data FORCE
 	$(call if_changed,gzip)
 
-filechk_cat = cat $<
-
 $(obj)/config_data: $(KCONFIG_CONFIG) FORCE
 	$(call filechk,cat)
 
-- 
2.39.0


