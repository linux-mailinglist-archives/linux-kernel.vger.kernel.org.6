Return-Path: <linux-kernel+bounces-514362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93372A355F0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A770216B451
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F4F19005D;
	Fri, 14 Feb 2025 04:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HrnUaK/2"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D11922EE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508834; cv=none; b=QJst0rN3QX9Gd62al3OTfxYyDxGdUX0aLCeM+Km0Oy2Ozw8sntRhcN9CwjNLwzWJJHl79IDc/f4wY+RDJpLvau10n5+ODw/j1vIfFiesjEsA/3CI7xRyaLP8Myouts8a2eVTqmjRh4oibO5xF+5ljRvdxTXQHdTcusgRMCaTfUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508834; c=relaxed/simple;
	bh=Q00m6RhnC2QFthHDOznvkFOKfPvZy0Gqt9YMxLMX4xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mD27tFbsdI3LXg1VMWCcOFqwvwSscQrTM+TVblEOwnK0FGM8iWwWFSxC5W/r+NFNcIZL1yPB/ZLqF5vGSOrZFXlVbqdMNLNEiPcw1tNA67+1zRYTfDNwH8sFHkWmQm2QnNHdWw5puKY2emrA3MWOpURzBZ4oBJDTUGUlquSI2kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HrnUaK/2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f49bd087cso24743665ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508832; x=1740113632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOTlfVzF3e2Wm9f7wmP5BEorbNSbvme8XOlj2WM+zhc=;
        b=HrnUaK/2POlzpked4ms4Y91XsPUU4V6VlbAjaCfUP6J/91AythWYng8gWEnnHuxO58
         Aqt8S9Ev7PlYxUvKtyHjTuInDLDPKYRSFPERjORYfGIup/uJR1vsGrowTY8ywKbt8sUv
         WdAj29pPn/gg6V86So9x6dRC2Law4ufR0XCmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508832; x=1740113632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOTlfVzF3e2Wm9f7wmP5BEorbNSbvme8XOlj2WM+zhc=;
        b=iZGfOlxkNCVHXtheyMo1QYhnWPjVivwhMfewbItGutA0MVKA/vVBAAcKQWM4oMSn2H
         OzVTtROq3gZ2yay2vQ+FrgDRjri7tFhc/4A/DUagK2G/cgJ0WQhuwi+R4mn13rwXsStR
         Wa/OD1NFjuH/E0Vu1vbgpikpi314Q9P38J1z0ELOJygtOqV5BiYVDPGXodMRv3Ne1xH2
         XvLRHpLnrGGFncNoQOiLGpA0T/yTTbATkZJle9GP2Z/raAVduQdkuUz6uM5GwD318W8d
         5ujPLZfP13MrgHwLx1Dy/Fp5F3xVnsh9iknns4NGSlB8VoNVmLIrXox9AouK/EvGOfOH
         W/9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUATbzuhoLZ36eGGXo3QT71GGgRxgTViiUB6N9X5wWBqyXOnwYjbZXwIjT+nMBQsSfWqWZxEEQZ03FSEEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvR/gdWHc+gXgC30rQqyfSrgwBZleQZe+B70VW9E1wWe/5L9bx
	D5wUdIi2nparwNZC1Qv05HVNfEFuRNuS1Eh+Iwm86gSbzaL4QtxjpALvnqYi1g==
X-Gm-Gg: ASbGncvrAFDOwmcGVTjEMMHwossF95jxmroHADYXj1OTF0NHGrGaMRKu1p882Co+kUQ
	rQxRC7/IXHnRGWdOhihIteYb+AxDcUXBkLFmDP5TnqrhbzY7mNWLr0xR4HKOxWZqVgxKAR0A2Wg
	cd6ZoJTCFNEc5658NKPVo+jIJUMhUs57mzjKPTaPGfQPrU/40MUBcrobTRHibEZi1+kpVdHxtH9
	CQPk3lcB7Np7OqgQQtPxrj/6F9HVBtCjIj0ThRiu8NpdzijHINLoBcZF8XP+2he+sROti9xHXfg
	2HzVCSTrIZuEJLs4CQ==
X-Google-Smtp-Source: AGHT+IHKsmcyZIg17GYlLEbKgjy5fMkUQ7BmQ1HUJMxSkfACov/TMDteDP157pPV1tX1h7GlE/qMmQ==
X-Received: by 2002:a17:902:d48b:b0:215:9bc2:42ec with SMTP id d9443c01a7336-220d216ce9fmr80849875ad.47.1739508832004;
        Thu, 13 Feb 2025 20:53:52 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5585fbfsm20932385ad.226.2025.02.13.20.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:53:51 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 15/17] zram: do not leak page on recompress_store error path
Date: Fri, 14 Feb 2025 13:50:27 +0900
Message-ID: <20250214045208.1388854-16-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214045208.1388854-1-senozhatsky@chromium.org>
References: <20250214045208.1388854-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure the page used for local object data is freed
on error out path.

Fixes: 3f909a60cec1 ("zram: rework recompress target selection strategy")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 87ce304a60aa..b4661de6bc29 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2059,7 +2059,7 @@ static ssize_t recompress_store(struct device *dev,
 	struct zram_pp_slot *pps;
 	u32 mode = 0, threshold = 0;
 	u32 prio, prio_max;
-	struct page *page;
+	struct page *page = NULL;
 	ssize_t ret;
 
 	prio = ZRAM_SECONDARY_COMP;
@@ -2203,9 +2203,9 @@ static ssize_t recompress_store(struct device *dev,
 		cond_resched();
 	}
 
-	__free_page(page);
-
 release_init_lock:
+	if (page)
+		__free_page(page);
 	release_pp_ctl(zram, ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
-- 
2.48.1.601.g30ceb7b040-goog


