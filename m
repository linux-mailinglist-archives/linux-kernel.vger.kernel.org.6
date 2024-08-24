Return-Path: <linux-kernel+bounces-299813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348DD95DA4D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 03:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 557F4B20D6D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E105680;
	Sat, 24 Aug 2024 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciW51yjG"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8B9A35
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724461501; cv=none; b=cJvelKdpr9ol0/iyOoAFyIYzl7bgjuHXwvb5puMEhl4Iuuj2zYqBC/S7cjqp9DWjeqKtG5OJuHvhFQ2j30PN2ZiEfEpTVqjBzi/iM6EO9v2WvKbvypJ6XIQFxyB3lk5DpqnBVzRbTpYXvgO+4jw4XxI2kfdDSf5RcoZmjlT1gak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724461501; c=relaxed/simple;
	bh=N/Jfo1ktSSXGBtOWv7j57sZggT2zbeOR35V2b8egs+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LJl4RIonNmgLUQVbQBu5VZS88xOE4qHBhgyQacvKWhH4Al/Z4lHGZgYfVpMau0z5n5aSLNKtQ67MFXXX5g4FjOXIZ69W8/A0GDyzCIkq1wEn0N8KmDOXrc/DvEr30Yo3DNAl2gkC1737x45uiK+hLFRL5jXprxFPx9IuRNlPwzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciW51yjG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71433096e89so2313279b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724461499; x=1725066299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CbNUgmTNsphXqIZa0CCmomGeojpScQXjjjGa2MU00Jg=;
        b=ciW51yjGI/7DMyuXPnX40zzPIgoXnmS5zwuUrdtxf8zV/YDneJ/HPi3x1l5IP+Y80G
         Qr5UJECfD77uvMJj/2iccU4SpcWEZLFxbMhcRIf6Ikd52XSU6AI//39NmCQHGgntmQmw
         rWnHUTR4Y6mbq+X3YIFLQmNwdXqYZwWZu5Wi18jnV7Jhz9Ql5yJd5mJqkrzyBN3I4Qn8
         +Z0zvGdFv7XXaI5tZj1df5O7gVDxeCfARlbEmGy6pDXOOBCxVXYGAdnMdJK9lINuazrk
         rKbP7ZJhgM6CD7Vgv4neIX1QbSY9g4oT9lzMXS5nREDwJ3K45duIXqKTkcM0RwP1Mp/m
         4pRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724461499; x=1725066299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbNUgmTNsphXqIZa0CCmomGeojpScQXjjjGa2MU00Jg=;
        b=eoHdSyKyPeyxbaGRci51r+6+gCXdkFGlDGxuCyYR9Q5lJgFqvOnDA6o/Fqn17TA0GU
         eWHGJ/cknFfmvgdS9sJtwCIskLULeTP+Wl41/36hLizL6SXCPxeH2qmt9TMAjbq+NMIw
         c4YLvsaJ4WI70zDDpnEln0Uz5qQFoOHaoqeivfMII4a7sfa8BlnLsfqa7P5jLfnXaNb8
         AEp5FfBbdmCE0bCXAp7N8KfSqf51TXnu6/ZvOR03tVa+lbhaA2VO9PfdSpVi1fJvBTno
         /Q97tWtGqmlIN8BqVtF4Hu6T62ZEL/iqlWEf1UwXnjYadZ/pbdQ0M7PA7fvqrCbZBxNE
         uf8g==
X-Forwarded-Encrypted: i=1; AJvYcCUM8b170Oc5bw/Rk4bjTYr7eXYirIpkyg7Ywgo18Jsf8lRJJvF4wZY+D/4kguPMQYO/dpBXqjO/5QBlpeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1zrCBdjKv3FjotYsAjhaxZKC11EnouGSyoAGC0BCyf5BSBKCI
	qFcY1aTY3c/bc5fl2s4uem4roHVZykgxysl0LbCzr4Rmt/bAodH5
X-Google-Smtp-Source: AGHT+IGwYJLyI4gzSGzBG2ITxnEBF2Cfa1lvUw4QO7iTlXPUTRZI+8eG3ODanOgUKyeEyGyKsw45lA==
X-Received: by 2002:a05:6a00:b41:b0:70b:1d77:730a with SMTP id d2e1a72fcca58-714458c8b91mr4491863b3a.28.1724461498983;
        Fri, 23 Aug 2024 18:04:58 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:8d8:dd4b:c921:b282])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad56c9fsm3274064a12.64.2024.08.23.18.04.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Aug 2024 18:04:58 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	ioworker0@gmail.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	usamaarif642@gmail.com,
	v-songbaohua@oppo.com,
	yuanshuai@oppo.com,
	ziy@nvidia.com
Subject: [PATCH v4 0/2] mm: count the number of anonymous THPs per size
Date: Sat, 24 Aug 2024 13:04:39 +1200
Message-Id: <20240824010441.21308-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Knowing the number of transparent anon THPs in the system is crucial
for performance analysis. It helps in understanding the ratio and
distribution of THPs versus small folios throughout the system.

Additionally, partial unmapping by userspace can lead to significant waste
of THPs over time and increase memory reclamation pressure. We need this
information for comprehensive system tuning.

-v4:
 * collect David's acked-by, thanks!
 * refine subjects, changelogs and docs according to David's comment,
   thanks very much!

-v3:
 https://lore.kernel.org/linux-mm/20240822224015.93186-1-21cnbao@gmail.com/
 * collect David's acked-by, thanks!
 * rename nr_split_deferred to meaningful name - nr_anon_partially_mapped,
   per David. Ryan, I assume you will like it after you come back :-)

-v2:
 https://lore.kernel.org/linux-mm/20240811224940.39876-1-21cnbao@gmail.com/
 * don't rely on rmap to implement - 1, uses folio_free, split etc.
   Thanks for David's comment;
 * rename sys counters and refine doc. Thanks for Ryan's comment;

-v1:
 https://lore.kernel.org/all/20240808010457.228753-1-21cnbao@gmail.com/

Barry Song (2):
  mm: count the number of anonymous THPs per size
  mm: count the number of partially mapped anonymous THPs per size

 Documentation/admin-guide/mm/transhuge.rst | 12 ++++++++++++
 include/linux/huge_mm.h                    | 16 ++++++++++++++--
 mm/huge_memory.c                           | 19 ++++++++++++++++---
 mm/migrate.c                               |  4 ++++
 mm/page_alloc.c                            |  5 ++++-
 mm/rmap.c                                  |  1 +
 6 files changed, 51 insertions(+), 6 deletions(-)

-- 
2.39.3 (Apple Git-146)


