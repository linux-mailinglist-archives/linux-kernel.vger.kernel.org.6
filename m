Return-Path: <linux-kernel+bounces-294318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E22D958C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819631C21770
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3793C1AE04F;
	Tue, 20 Aug 2024 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="WlK+nnZ/"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD8B190671
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171101; cv=none; b=tNlkQ8mPDDdIRW0pCpfwisfPvNbT0Yf9i70MKcqUf7vk3PT036DSoWcfp+AJQUTRX6YbBUMnBnqHBOv7W3FF91WdcbFpVq4dhE5p6BowI16NHk8gzbU8+b5ku+TBCjpdKiFR+usbH5txoLN9VDFAvuDXroaiZgUjVYKpdFOH534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171101; c=relaxed/simple;
	bh=2eNpori7ijAO0KE5CfbR7xqHuMRyRCj2Pmn3icvdUuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szKCBu3yLjT75oIA1tdcwEX449ERN3KvOgS21tTDFAB+5hdGPq5oxHjRKASiW4EXgGI8+6UmaHwwycCzPWeicsWXPFHDa/SJXrwYFeMRHpp75Qsd6cS7qYszcNUjaIwu1rsfdcpqqVjqvHoUejjOZ0UAG6i/Or+3D4yaiPNuWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=WlK+nnZ/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5becb24e227so663950a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724171098; x=1724775898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=APU9tMJCpenUMC6yhXzDejWbQFkKRW9sw3JyNE2D4q4=;
        b=WlK+nnZ/6OElqKbiVOXHiElrISFzGVkYLeibkeKfEnqGqR5h1U25eWfYm3I6EM20sb
         xAQheugBI6cEJUs1zm/OPIDst6gmfm6L4rtIRrWrQ6Qe2mr+9eBfUXCUrPPqCBO5xpAH
         XzLCHjS0Y9JHrxLGWzii8kj+4HqK/SCELBh3lHDrwSNMIOCNTcrevfw3yYD2PYc3AVsa
         cGUUSSy+U+ge0KzAMIctoj15wlqPKg5ahF94jPkmo+8/ie6BX1muXu7tQjF1P98poPYA
         0p6SkzMdai7Dl3FFEJO89AbCo0simlJui69bHYN8kr69ItqEgduqNcn1fhONpR6z7fNw
         IdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171098; x=1724775898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APU9tMJCpenUMC6yhXzDejWbQFkKRW9sw3JyNE2D4q4=;
        b=ezb++lGOmCsGD/xzXu9TZgztbS38pPXSzqEttlJiimCxLTxhY6feJhfFOZ3gxEtXbL
         n72qM7up+rEKYVhYSR+Tu9FBIvBAWDcO7MNP/fkXsZCSAeL5f3THNFIJsnXawEUlon3I
         kOLfMpc6yNqNrX/5LgWom0qVaGHWM0kxITub4Bq+qOjy6lR+0hJzHsKWGrNYvtyvwLPg
         myPWNASl/4spYnC1ETJMgqdOIuKf0ct4I9VlQn6bto/d2Y5FcgS6bIH3JHsMKFTGU5i7
         HvpSelQejgDVbTDp0zdcHD181WuIZRVxJdng42CaxrTzGEGvVB+F3aak0F5NFC5RnmWS
         mPsg==
X-Forwarded-Encrypted: i=1; AJvYcCU7Lpash8i3WVl7dCtW9ti+FsTAP1KyvlkebMJCOCHsAQILFW0mXOF4AK+IVV2SOG9OJLa32AC0tCH26Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi1DqX5MgQXUQR/S/I3fxMDJtID2ZKQcVSoMTu1QbOl7dQYdlw
	3vuK5NQrf7+QEr6+g5NUwzpuUXUGBaB17A9ONwjKGxAlafyrAOb3vmQtFEaSzL0=
X-Google-Smtp-Source: AGHT+IF7SKUNETxE/Jdu/YGqFLjKzRhmaqsU6MOEriSsSPJW5OwLKJqW4BGUvohJd6GSYQuTRXu1RQ==
X-Received: by 2002:a05:6402:2682:b0:5be:bcdf:4118 with SMTP id 4fb4d7f45d1cf-5beca9587fcmr5345994a12.5.1724171097592;
        Tue, 20 Aug 2024 09:24:57 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bf0b0cc99fsm1205498a12.49.2024.08.20.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:24:57 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] mm: shrinker: Use min() to improve shrinker_debugfs_scan_write()
Date: Tue, 20 Aug 2024 06:22:55 +0200
Message-ID: <20240820042254.99115-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the min() macro to simplify the shrinker_debugfs_scan_write()
function and improve its readability.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 mm/shrinker_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 12ea5486a3e9..4a85b94d12ce 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -114,7 +114,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 	int nid;
 	char kbuf[72];
 
-	read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
+	read_len = min(size, sizeof(kbuf) - 1);
 	if (copy_from_user(kbuf, buf, read_len))
 		return -EFAULT;
 	kbuf[read_len] = '\0';
-- 
2.46.0


