Return-Path: <linux-kernel+bounces-233430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B393391B6F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E61C28378D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 06:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846846A8BE;
	Fri, 28 Jun 2024 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="TZmxOzuP"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764C955E4C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719555856; cv=none; b=OLrY4vbVFptFuMljnPS3kv04C+WBVJ4HTpGfd6MvDlFpSsDaK3u56hd8ASMX/2FmDmgNm9e5BxOMsEmGTvfPw9YelyUqESiSi/VJzCMGyBZiJbXvqzdIeBgxEwKXPdO0S1KmuhjRNBjKPzJZ9sxO8Dn4/m3DEcvI8/tl1mypYBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719555856; c=relaxed/simple;
	bh=2OhVz+CWLAqwx1TZwOjll/zRHYZJKy6m4OT1DSiFqzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mN5kMiCgGNZpRBlg/dNbPouCX8+C2G7LLZUd0qfYmNJhY1sUFtWVTVaf5ZENGfuHC2N1Ym73VJgpIZxyQ8NZ5LfaomzZQE6p14TpfY+ns7tQXnQmhMhecTTlpPl8LZOI9CpxURF6xDogx1wN+wJM2Jx6hsLpY446lAJNpLkB/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=TZmxOzuP; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36dd56cf5f5so1144345ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 23:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719555853; x=1720160653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HzLoPiZE4JE6+DixEf0MtA8WCsiSCC+1JUW9jnXAdIU=;
        b=TZmxOzuPQQQBHI35Gj/lGElIJtwzr0/aWCV7HwluPPi6Dyha+xq7r77TgraTqnTIxb
         S3+YYKuIM5giFHpuMbFgC0X2GrsxMvXWSWhaYphzjt+wP2aI7MMMCM3y79yWe7HKAGYQ
         fYrTCydC6iTTCn00V54NHFOrzlweBEX6oyBBSMX1dpUsxVoITXGK47PSKP+SSQO2NPne
         VwTW9+S6prqUkv2epwKINqKbdd+eRqP7Oadbs18pkm/K1nCetKjU0aG1N8dJHagDiwcn
         vGY5z6YMH0bFV2CzHVKYs32LrHe6eBVjECUqiUq8RXnxXEHTosiHdcsRD/lIsuZHEQD/
         Hfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719555853; x=1720160653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzLoPiZE4JE6+DixEf0MtA8WCsiSCC+1JUW9jnXAdIU=;
        b=LDger/ivsWlxOejZjMsRq+AxMznVxkwua4qNBUopwiD6yrTbp3hY1pclKtSZ0ntBfi
         mxPDqXFiPohj3ivmi5wkxwm8zpJWfQytfjfMXW0X1c4rlIkf5JWetU2kR6P6/dQQ8h3n
         ols2M1bcYH+IbC2KIDgU2OoHDGvi+YH5p1FUNgCmaOQvbel5nYsp9mWnO5Gry0msEATZ
         D4tP+YAvuZnFN5vLKyNFsn1w3N2AYTYCh+NbjUOAIk8Ki2Bw/bHp1HBn0LOGUPViBjVE
         zhvyf9x4gqqnbzz7DGf64cmq7IMaH4pWfpYQq26pFgh7Pl+U8nH1JYloMdjtr2TAf0Oy
         HHnA==
X-Forwarded-Encrypted: i=1; AJvYcCV23z3eohwFedbFCbHQ3wxDBaNUU4Tzdcc+WMVSjdDp4xQC2EX0jMEv/5iVbbdZBFS5z9aTPKSuWzO5Qog+oQRTZ+adz5FdeQxi5/ve
X-Gm-Message-State: AOJu0YwFgRbzklARB2MBdWgqNEL4Npj18AC1RhAkoFZJaPe46dTjabga
	5tzAMmvhGJ7D/5Srt2SF+l9jhCbIwrYJdM1QLEHajInVjB7Pbovj7jn5k6FuZd8=
X-Google-Smtp-Source: AGHT+IFsWTRPrleNV9WCHgmOyv7LoUsWG9TeEWqDKOF3BkaC6BtC1QHIn26XExOxqaLkUv77OaSsOQ==
X-Received: by 2002:a05:6e02:1c0c:b0:375:c443:9883 with SMTP id e9e14a558f8ab-3763f6ce08dmr180676155ab.21.1719555853457;
        Thu, 27 Jun 2024 23:24:13 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53ba0sm671358a12.7.2024.06.27.23.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:24:12 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: dhowells@redhat.com,
	jlayton@kernel.org
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Simon Horman <horms@kernel.org>
Subject: [RESEND PATCH] fscache: Remove duplicate included header
Date: Fri, 28 Jun 2024 08:23:30 +0200
Message-ID: <20240628062329.321162-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/uio.h

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/netfs/fscache_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 38637e5c9b57..b1722a82c03d 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -9,7 +9,6 @@
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/slab.h>
-#include <linux/uio.h>
 #include "internal.h"
 
 /**
-- 
2.45.2


