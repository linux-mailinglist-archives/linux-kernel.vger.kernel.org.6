Return-Path: <linux-kernel+bounces-248291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885A492DB47
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EB11C212EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596B7148FED;
	Wed, 10 Jul 2024 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="FI6k7htb"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DC614373A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720648411; cv=none; b=oIRnnChSb94E9uJ48tf4bi4GbFLfXBIp81woHVt77GRinl+JGaxS8uvAgGoP9Si59Mk51BnXy4AcCzobnv6P+IHryNNKaRmBCggc1MCAv+IpusNz9HPPjpVCqsLW51syfy1nAZRD4CPyqAI2B4jQU4oQ2/vSPuM2IwZxFW+sScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720648411; c=relaxed/simple;
	bh=P6pFNtSX7hdrdMiRS/EXJepsenFC/aKl4HB9zMgtPBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HS9Bgwb9V1/jEtfsrF6wyq+O854/G8Xft6LqBRfhUT5wmgcaDWrNtRqXcu1MxiCB196r5Ju+u2k+eaQTbOk6pg6uoqKztCBbNePYzD0hmXaaMYrm9GPNjqejHNM552Jtgm/tRw+z/mxJRbxaXRcKveI2CBI4FL+Ixl80qFKhQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=FI6k7htb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3679df4cb4cso160343f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720648408; x=1721253208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z+RxlZv5zaSboGrNLVWqBx+GDpoTgWV4FJEqOM09oe0=;
        b=FI6k7htbjZ4uGnRLFaOCh6OG1+MN9G6HhU3nxENmt6wf/6v2hrhZPrMhKerVQvh0ki
         tsdSC+j0kxgHElOQ8SvTd90avd4ZDVnNEhNNdMJdxqPZckw+epfqCTNxUR8o6rIpldQi
         tO+4Wl9UxliPhHi+HIU6HPPfrvgwDERmq11x4BvkhsJwQ/Hb8F2cScZOl/IPWrZL6jDd
         e8jEi271busO9cwuNKOtAMO4fVy1IcWBPpALMuISzEqp7vM3R+in9/wDAzPNB2ZXoL2u
         Kx+mxTp7tGVDmGuzb06fpEgJmHiWvx8eGaphvfn9PpPtrLGqtRQAg0Y3Vwb5OIrU5ird
         VnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720648408; x=1721253208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+RxlZv5zaSboGrNLVWqBx+GDpoTgWV4FJEqOM09oe0=;
        b=Lk2atrHwNq3xq8TJO5gIfqmIfzb1nIOGzz161Y8ghPmS5eTrYs7dSHPobkQ7ZCjZeR
         v1swzlWerBvjbYWkWmwbFq8waeRePBa5GEbeGEZrAA8y34YE5vjqjD8PJp0IzZaTMtLv
         tTNRPASfP9JgjwRc9zGdJeZorxS+M5pI71fZd47zs1A8my+c0zu8hr0j4R0awDJ30USQ
         JJKQWRc+JvcqMcfSbpjrH2uKubd/C8f1W0N4AbtsufPeME3lquRKaflnsRTqeEI8ixGG
         0dvkzV/NjevpmQwNauGcoT6IPJznLxWquvR1OknbBID0jxgSWHd4KWsjb80G1nooenTm
         Tg0w==
X-Gm-Message-State: AOJu0Yyb53tv5uAEhcqP0Yh38O1Xl15MaSssEVAYLTNo2S8QJTM8ZHVQ
	9vddyRDNCi2Y6PibE0bFh//bgRC9HcIh4yoBEvQf9lhxhe6WK0fdjz6ghJaLvqqAoWi+iNBTZau
	Ivbs=
X-Google-Smtp-Source: AGHT+IHsJRc6zAIpAdOxQabAabzknndVrqqFCuYrpiVUkFJAgXU9otYiRo9uQPDBBlA854IaUCWRow==
X-Received: by 2002:a5d:55c2:0:b0:366:ea4a:17ec with SMTP id ffacd0b85a97d-367f04c383cmr689102f8f.2.1720648408331;
        Wed, 10 Jul 2024 14:53:28 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7dfccsm6232708f8f.19.2024.07.10.14.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:53:27 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: clemens@ladisch.de,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] hpet: Optimize local variable data type in hpet_alloc()
Date: Wed, 10 Jul 2024 23:52:39 +0200
Message-ID: <20240710215238.799239-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local variable period uses at most 32 bits and can be a u32 instead
of unsigned long. The upper 32 bits are all 0 after masking and right
shifting cap by HPET_COUNTER_CLK_PERIOD_SHIFT and can be discarded.

Since do_div() casts the divisor to u32 anyway, changing the data type
of period to u32 also removes the following Coccinelle/coccicheck
warning reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/char/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index d51fc8321d41..bd68afa22cff 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -784,7 +784,7 @@ int hpet_alloc(struct hpet_data *hdp)
 	struct hpets *hpetp;
 	struct hpet __iomem *hpet;
 	static struct hpets *last;
-	unsigned long period;
+	u32 period;
 	unsigned long long temp;
 	u32 remainder;
 
-- 
2.45.2


