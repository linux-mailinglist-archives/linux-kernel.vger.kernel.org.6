Return-Path: <linux-kernel+bounces-388331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0819B5E01
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124602842F2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D74A1E0E12;
	Wed, 30 Oct 2024 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsyhkGiK"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12831E0DAA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730277462; cv=none; b=OtRpAGUeH1dZC9da+LMF4jmQVotr51QQ6GAZ+1idefg23DsFNop9d3zGZED4ERx6DY13yCBjY+HLvtvkdEIw0anhAM/quufqMGYNwRjrfKXT341sRCqs9+P0W0TF0HyTui0+lWHbdaQos6PCJ0mz9C25eyVD3s9GeE/LWj2N1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730277462; c=relaxed/simple;
	bh=aVe6LXETtn+PlIbEzta2oNAjJxYG7CwvMkigSAEOFjc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=awbymlilM6ilUxhQh7dXY6cDHrPS/2/Wm55AZxS3EKDHzJxFxXsuz8sbDtalqkE+UltFGeXuSbRscRaIW6FzhGzwfl5FjJV4fvSJSePXEg0GZF54ykXeOh+0QzgQ4hmCDK1rlZbosxBTO6Gu7UcVPuDTXdbuG6eABAXnbyMTFm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsyhkGiK; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso2211688a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730277460; x=1730882260; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pK1NNN5iiYcr55Jg1jQR6cz7ApTsH5+EN3pM76pGsi4=;
        b=RsyhkGiK0qYAHl5Jkv07SDizGF9tRQxXk/qBtgkvjqSEpswJmqZODsA+/ta6chXyXk
         o1mtWSHDQUZ9X+fp1Mu2EswqTekV2BsPpLeqSB6+Ohrmsgutohs+yPoVyv10OVVH+iw0
         D35S/d4DrcKwmoRGmv5V6tUiHcDOWkf1+4SQzPgAoR1pJXCs4inOlW+8QIw9qIRlpbTA
         vzivYWstmuq3RMiKHZuOkZWFpLM1xjn5ahrS2GjWYA8qxnctOtYTK7ji2Q4ocDItgSni
         bPdpq0BYrQt4Af2d+2669pm6G5cL+1i41wgpNoM+HIP6OWM/DfV0SJKYZcpR2TjYpUjc
         arEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730277460; x=1730882260;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pK1NNN5iiYcr55Jg1jQR6cz7ApTsH5+EN3pM76pGsi4=;
        b=XLEWuFzR8WqkyqeMGe4q6vRdSnIfvJFPslgZY62MeWfCnMTohovXY4Th1alaw7N59a
         zqpVfBF+8IAnlGbndZACrL+D4W4Sv9kct1Rsv7mazo4I+LbZIQc9kMvE4tMH1IQDp5Q0
         Ap0ZcmwVZt9JATuAopx0ekq96fpgQ49RpKqqjDpQjcF7mtEP9pek6mjxE7t5/xk4vxuo
         AlKKROY9D49zhzEg+5OHXDLWWUi8NvuIpLkLUZFYXrpFqtTMViUuL0yG9yZK2B97kAoI
         i7B8rX2ZNj8ccSgpHCs2yubMMwA0zbqAj6HkXkDZSbriPQ/kNtBx8mGzwndBCuyuGtaU
         PLnA==
X-Forwarded-Encrypted: i=1; AJvYcCU5EGjeu0Gnm221EjpahV1K1ncDSvI9UzLpy4eNZJoD5nE4Rl07gA4F+jG/9EMMHip0gf8GRbPPwF6RaCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxopCaIVkd1y3gGmRrQu7x4tadetiidgZwWFfX9D81sliqbaPFH
	lmAPe3YP3adOhr+V4WTJSZV5gBP/d+XeM9bXZHVEs6ImO4AER4jNm90kgg==
X-Google-Smtp-Source: AGHT+IH27fGPifl/S1VUCnhapo2Uf3UleHjwcju3joeUSQOWLZvC9JFY4Xl/GePrl2GOWwNrtifMvA==
X-Received: by 2002:a05:6a20:d528:b0:1d6:fb3e:78cf with SMTP id adf61e73a8af0-1d9a8506d92mr16954661637.41.1730277460124;
        Wed, 30 Oct 2024 01:37:40 -0700 (PDT)
Received: from localhost.localdomain ([43.153.70.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbfb05asm1081901a91.48.2024.10.30.01.37.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2024 01:37:39 -0700 (PDT)
From: mengensun88@gmail.com
X-Google-Original-From: mengensun@tencent.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	alexjlzheng@tencent.com,
	MengEn Sun <mengensun@tencent.com>
Subject: [PATCH] vmstat: call fold_vm_zone_numa_events() before show per zone NUMA event
Date: Wed, 30 Oct 2024 16:37:37 +0800
Message-Id: <1730277457-22725-1-git-send-email-mengensun@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: MengEn Sun <mengensun@tencent.com>

NUMA events will only be folded from per-CPU statistics to per
zone and global statistics when the user actually needs it.

So, we perform this folding when reading the /proc/zoneinfo

Fixes: f19298b9516c ("mm/vmstat: convert NUMA statistics to basic NUMA counters")
Reviewed-by: JinLiang Zheng <alexjlzheng@tencent.com>
Signed-off-by: MengEn Sun <mengensun@tencent.com>
---
 mm/vmstat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index b5a4cea..2770800 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1778,6 +1778,7 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 			   zone_page_state(zone, i));
 
 #ifdef CONFIG_NUMA
+	fold_vm_zone_numa_events(zone);
 	for (i = 0; i < NR_VM_NUMA_EVENT_ITEMS; i++)
 		seq_printf(m, "\n      %-12s %lu", numa_stat_name(i),
 			   zone_numa_event_state(zone, i));
-- 
1.8.3.1


