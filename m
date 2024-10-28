Return-Path: <linux-kernel+bounces-384364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C72F9B2953
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6CD281579
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA68204F70;
	Mon, 28 Oct 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LTkK1sVv"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F99201271
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100951; cv=none; b=q3QXp1s+F1JOBFimm6GR7Z569XoGUewMOzO0Th0tpYMQAek78vdb8xMKLtW+ixPKMsLlmYYGNhXK0aUtYgRt2XpNZMrpnw18vtKxTf/XOCcJ7xfClKqngk1W0Pu44OWR+PQizk12JT4ZaASIukJWbS9LJY/llkKrki0qU8IU3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100951; c=relaxed/simple;
	bh=7WhDu8mPAasUOn/jj+GA9KHptAyrb2IdX+xOjw7cWGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Co96lAmpeBR6A6c3gKILotlcYJ7hTy8rCwXiS4pnXluX5cl7H9TPTG2hcE30bRB3XIUdwVi5pBgwGScG0qWwh8kcl5cxu0xN7F+VTBQM/CBVXXe4Tw91T+WFlALTDvBHIl2H/O5bk2By9X1VrkNCOsYarSV3mX7xlMGUGpcLjTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LTkK1sVv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7204dff188eso2458341b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 00:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730100948; x=1730705748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+EhFv+UYwGBfkV4RUwC0LMN5UJxUbHPj+o8inaBXUc=;
        b=LTkK1sVvn9y5PrV39R2wNK/sGx7MRK1xpXaPVinDIUkwtR0554mkVpp0pa9g52Zf4A
         ygagoMdGxgNdnN0C7KomOYAqU0noS59mlwmOvr/4ANVxmBQ7FJIxwbS+4wE9SXRMbOua
         WyPx9A+XWr7i6a2/0DmRbS8p2A5XOyKruAuk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730100948; x=1730705748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+EhFv+UYwGBfkV4RUwC0LMN5UJxUbHPj+o8inaBXUc=;
        b=t4NNCerQ2nktYWjrnnw5iZ02eDMlcydL+dFK07XE9nU1PlCXnuV/0/p2SXC+50zBCG
         n9sz4/oJIbzvONl1xQwp4wIN50IJOhtcoshSkssUdNtuZKTEOI+zy4S9gs0CIaErWaXJ
         MXNxbup2BsKSSzhDTtB+grpm0O/19PE5vNdVCls7us4xYCBLg4+cbv3zz5nfqEPiy3V8
         tcdIUmhra52e54RgkbiqNApvE1Bhl7vYubHZvtjd4Ti0kPwkFht0YGBw1pIbeHCCwRUy
         iWuZDaPZoiGIxgav3muWjmgJ4OalP4wEBAiqwJKL0P8Jz3Kc2F8uwvKodwGrvRfBjIYy
         NWpg==
X-Forwarded-Encrypted: i=1; AJvYcCXbWo1SqDhQfj727gKc1LkYPlnwZeUCAVFEm11p4lyKkegXebuBOTYbe2nLEWbjJ8fpFFiDTXVRJ+neUK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzVuofeRmP7bHi049w2l4QtcsvmGkBnd5l84Rykg2bfPM59F6b
	m5kpB5eSo5ViV6sHEdRUK457zxVKLZMYUi7v2mymsh7wLEHT3j4Ic7Mf1fseAg==
X-Google-Smtp-Source: AGHT+IHWPjPq1Gk1zKDED36EHV354uMSQFNpddiQ+1ZfsoQdyzCivLoYxafq+XY7jMjO/pvMCL6phw==
X-Received: by 2002:a05:6a00:b81:b0:71d:feb7:37f4 with SMTP id d2e1a72fcca58-72062f4bebfmr11467339b3a.6.1730100947969;
        Mon, 28 Oct 2024 00:35:47 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:f1f8:97e1:9c5b:d66f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720579360f5sm5131189b3a.88.2024.10.28.00.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:35:47 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shin Kawamura <kawasin@google.com>
Subject: [PATCH 2/2] zram: clear IDLE flag in mark_idle()
Date: Mon, 28 Oct 2024 16:34:58 +0900
Message-ID: <20241028073529.1383980-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241028073529.1383980-1-senozhatsky@chromium.org>
References: <20241028073529.1383980-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If entry does not fulfill current mark_idle() parameters, e.g.
cutoff time, then we should clear its ZRAM_IDLE from previous
mark_idle() invocations.

Consider the following case:
- mark_idle() cutoff time 8h
- mark_idle() cutoff time 4h
- writeback() idle - will writeback entries with cutoff time 8h,
  while it should only pick entries with cutoff time 4h

Reported-by: Shin Kawamura <kawasin@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 764c5b79b42b..d3b1c1bfaf18 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -410,6 +410,8 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
 #endif
 		if (is_idle)
 			zram_set_flag(zram, index, ZRAM_IDLE);
+		else
+			zram_clear_flag(zram, index, ZRAM_IDLE);
 		zram_slot_unlock(zram, index);
 	}
 }
-- 
2.47.0.163.g1226f6d8fa-goog


