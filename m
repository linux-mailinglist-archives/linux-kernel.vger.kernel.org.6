Return-Path: <linux-kernel+bounces-298032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC06595C0F7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669FAB21763
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEBA1D1759;
	Thu, 22 Aug 2024 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVjcL0Mt"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6835633981
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366431; cv=none; b=n6Nflnpr9DoQ3NNB00+pR1H4mXiu03CVfYNupS4ZhErhzR9nQ5NFnwouJvTHbZhvOWTML1S44c/5IbrnN/AKiSGv4Nik9PnT/dIEvlNxDYm7GK/AY4p3RxTMgiNod8p4HTYYW7/LoVutBPNtpBeVFlZpCTFDSjkb5B5caDW9bbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366431; c=relaxed/simple;
	bh=rK9Q9YrVsoVfxnISYGXXxwFSeJeMMHJOONhU/+7nlPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B8E/Al2i6iwR3xYMPSjqJIwIpD9QkSZ0dLeul72KaB/HkP3QQOXGgLngEChggQGM7467U78M48Y6T0Ku9ph/w7nthERB43L0OdHdvKLZoxPcRbMCXvu+zPY++Pe9YlVzCapnoBk3y0t25Nkpj7J4b7eHh29+edLxjhd/80Q7t3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVjcL0Mt; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-714187df604so1552405b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724366430; x=1724971230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWWpnqWRODr8kHzJl6yw6khun8cbsZY6Wz6VJHrsR3w=;
        b=HVjcL0MtSk1Pe0ISopyA0eIlj8tzPLO2iGV2wd9W368kY7h5XrEpb+kQcUhwrHDdte
         aNUBxdN07JhwDX6227ORpNiHwM8dwwnAUmVqNFmErfs7z7rlubvTjs/FYRzGjyymsHcM
         R3YfoMalowdV7tkq+/qsscHJ6wd9QrV0+hWdINvQ5iS0QGvajG8CNKatBvwju7DvWqhk
         qmt+1gMuahc4hmsb5/sFAkWzNbPoLYaFF4gIwHT0GC7Ij357x865f7rAiCZEUt773jkV
         y0RerhJEPZFzIJKi8yljTShTpHZIlQ2OyzcVqCbpoY7PE9kZtOeZV4+FZKwGIa36lQ3U
         mCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366430; x=1724971230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWWpnqWRODr8kHzJl6yw6khun8cbsZY6Wz6VJHrsR3w=;
        b=hQyOKhJqyWQZtGGQeTFLLleEkIiF2uYo+VoCByqijIdpWMaoTP3yHszDqtD9e0AaYT
         5naoWxzw+CRnsJJWGhF77G9SGqDw2Gy/TXkISfhzf6j7lOO+lQWvWRJLKJey2hOTgLL+
         YGi8NHA3tRoaFMvNsOUJ0PLvYoMQP2EOyHTgMena8AeilUO/OCmNbdI7Jma+FlxniOYv
         b/owwof7znfEM5bqXda06MBKt43L7MM4KCPs7qrJHK2O/ERcv9EWX7SMoi/+gk35PCbN
         KIZ9e6SBbkh7pS3LnDpRfdzC66ywEG0LzKmU3oPWQMoBwU67jUFm7SzFKBzqX7MHs+Fc
         Pihg==
X-Forwarded-Encrypted: i=1; AJvYcCU00+yo86eUDAnOQq9gJ7cUwGhkFE/wbiNbyfjiXx94OLza7IQXUlmGSVaJcIJRpJ32O12NMcTg0Qyx3gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1kIN0F6HgPPkuSJJoUb/E12KBUh23hZfco18uN6vZDmyR0IZY
	z3GAysOqcFjPOT/XceT6kpaE/tnCZOIkvvMtC7IYITFBuFwmFeZ7
X-Google-Smtp-Source: AGHT+IHwHwKPCfecstS5+UFp+9p02u8bULrq0z++VtyZDRwdSsHdIkT+rIFUaJtNqfbblXA5nPn9/w==
X-Received: by 2002:a05:6a21:4603:b0:1c6:b0cc:c510 with SMTP id adf61e73a8af0-1cc89d6b9ddmr756708637.9.1724366429574;
        Thu, 22 Aug 2024 15:40:29 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:427:337e:a4f:8e74])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acabccasm1609912a12.27.2024.08.22.15.40.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Aug 2024 15:40:29 -0700 (PDT)
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
	v-songbaohua@oppo.com,
	yuanshuai@oppo.com,
	ziy@nvidia.com,
	usamaarif642@gmail.com
Subject: [PATCH v3 0/2] mm: collect the number of anon mTHP
Date: Fri, 23 Aug 2024 10:40:13 +1200
Message-Id: <20240822224015.93186-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Knowing the number of anon mTHPs in the system is crucial for performance
analysis. It helps in understanding the ratio and distribution of
mTHPs versus small folios throughout the system.

Additionally, partial unmapping by userspace can lead to significant waste
of mTHPs over time and increase memory reclamation pressure. We need this
information for comprehensive system tuning.

-v3:
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
  mm: collect the number of anon large folios
  mm: collect the number of anon large folios partially mapped

 Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
 include/linux/huge_mm.h                    | 16 ++++++++++++++--
 mm/huge_memory.c                           | 19 ++++++++++++++++---
 mm/migrate.c                               |  4 ++++
 mm/page_alloc.c                            |  5 ++++-
 mm/rmap.c                                  |  1 +
 6 files changed, 49 insertions(+), 6 deletions(-)

-- 
2.39.3 (Apple Git-146)


