Return-Path: <linux-kernel+bounces-543950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B84A4DBC4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FED63B2907
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4BF1FE476;
	Tue,  4 Mar 2025 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="T1qpgAmI"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2AD1D5CFE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086207; cv=none; b=OYuOnAsoPZAs4HKyZg2Wn1wD8ER98nE34fD7aoxpzx/tHc1aifUqkFApE4VZizZsqdth1vKHj7xUvF4D96hWnsfmPcpA77inHCS6y5cQ/kX0G6GC3mv+30UigH6bYVhXfGbmpzXGPIUWh9Vxp1hmTvddDI1K0Uy8PRrSp5bj51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086207; c=relaxed/simple;
	bh=zqEaK6lshzIGNze+IgF53qRIWCWzyItSBvl64+V6X00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fCYbx6IuojSCXiccmP7m1zPOpTH2o/mE/aCcUDsFiznX81I4JZY9MLMsnDA/Xz/J2OCfcj6jO0kjGTmzfeiHHH9034GzpS/EXpgQe++AQHKIHpMKAmZ0SX2hlytC2grjV3Mvk8+BnZ9jGHbPHnN0XXMp0PK3Ps9ybHeZzt3g51E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=T1qpgAmI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22398e09e39so43198445ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1741086206; x=1741691006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SHtbx793tIAG1ciJBxRLA5mIHUNtam6m5RVXu4DBixg=;
        b=T1qpgAmI6q5tdSkdoroAWQzI6raC8vj1ekYmO0S00AvDGBQgvgqjyA9DypK1bqBc26
         CbnCYspiGfGNGr6IVKoIP1U4Dam0zCNg2KVnQGCQ/C4thCu7UZ0LY6JJpbbq6mdTOnIQ
         eQ3i897loaTZmOEKLS+oUIExdNtaATLU+XLtO6AhgWtCfWJBbG8rS+B3roXbgs1SUTeA
         neGmFQRfnxWWa7dQA/4qcaZ1bqx2B2sktTfz5JbhfmVn0LJu79iPvNDbsBSS4XKnUtEz
         aMsGUeM/3jUp6VyzxWj8CfM8s665S7gMmBBUCfVBLJ1V6iwPsJrDaKnqoPSZ8VTJ4q3B
         w32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086206; x=1741691006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHtbx793tIAG1ciJBxRLA5mIHUNtam6m5RVXu4DBixg=;
        b=lGHDIVD49Uc/LyKbKQLEm5ekK24fnVcTtowY+GYvVidcJdE2E0gVrS7gSXg2h4pZgU
         OzYYSmh5V6qjpUmvYQYyGdyyeAqNr3AYeZ6rIThK0zfea7ZUycC9CQ+ezXCUHR16rIro
         22DelvDViX2azGKug01x7A4OHY0kF3a72KTx14IcnsLCn+7DrngKkjGF0UvU46wMAv4X
         keWRDdbuYCdYpRZbmHz+IJ9ITrWz4AOS4GzY3N2TPcSjPmK1coT4H0bekDmLez67Gyjj
         nYgd9RubQQqmn5FO7wmozjjfxQaIbRL+0ckD4FOJLyeyNJpbYqjVo+1m0wkiDYbJhZKM
         1u+w==
X-Forwarded-Encrypted: i=1; AJvYcCUizbpAOp7kuqcNw6+n9c10TrEFv0DOvTAfXST5cTk20RbLbUtt/M2d9h1MGvkZ82onzIACKMASl9CQzpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWsOEfxoPOs3oWqtpsKhwEUSuTa5zjO0+qi5VSs1ZPr5giicJf
	hBllD5oAFvOUe1klxKsHZRdaLEkIIqVzEA+tLpmIfSnDAgCoTNfoPEDiX41/IkM=
X-Gm-Gg: ASbGncv1nHB+x703cED+zjZgim7RU55RE8RTwG6SZF3UnV/kKmASpOG8S0429yt2Pl7
	OWdx6mfrPbe1ArDkvd3A0ZezzoiZtRfzYI9sdKEyrYOg/KYE4J0jO870cWjfUDbn2iPPp5w98CV
	Npe4nav7D7q9oNG5puaMKFzICl+KnEeUkVk6YU68rA8QEdUrQKzOcV6rEZHID2KSAVuxbWo9igG
	akQH7aeVzj6ucbag2uXyG6pmeS6HrH12Vg2ViooG/srg2I5LX1rpQfS4pzdsJ8IdVpevYXs/uZL
	J6kj38TLC9S+nyL1MVAcV6S4ebqoIA==
X-Google-Smtp-Source: AGHT+IEmfNtA9j59gyV0N5Y1sufC0pIIYm447vAhwkKJoR7YVLQIz4BOAJdQRHPoFR2B8LBfRVy0ag==
X-Received: by 2002:a17:903:2307:b0:223:65e2:2f1f with SMTP id d9443c01a7336-2236924e56fmr240292725ad.33.1741086205808;
        Tue, 04 Mar 2025 03:03:25 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2778sm92764415ad.36.2025.03.04.03.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:03:24 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: tj@kernel.org,
	jack@suse.cz,
	brauner@kernel.org,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	ast@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 0/3] Fix calculations in trace_balance_dirty_pages() for cgwb
Date: Tue,  4 Mar 2025 19:03:15 +0800
Message-Id: <20250304110318.159567-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

In my experiment, I found that the output of trace_balance_dirty_pages()
in the cgroup writeback scenario was strange because
trace_balance_dirty_pages() always uses global_wb_domain.dirty_limit for
related calculations instead of the dirty_limit of the corresponding
memcg's wb_domain.

The basic idea of the fix is to store the hard dirty limit value computed
in wb_position_ratio() into struct dirty_throttle_control and use it for
calculations in trace_balance_dirty_pages().

v2:
Adopt Tejun's suggestion and split the renaming code into Patch #2.
Pick up Tejun's Acked-by tag in Patch #3.

Tang Yizhou (3):
  writeback: Let trace_balance_dirty_pages() take struct dtc as
    parameter
  writeback: Rename variables in trace_balance_dirty_pages()
  writeback: Fix calculations in trace_balance_dirty_pages() for cgwb

 include/linux/writeback.h        | 24 +++++++++++++++++++++
 include/trace/events/writeback.h | 33 ++++++++++++----------------
 mm/page-writeback.c              | 37 +++-----------------------------
 3 files changed, 41 insertions(+), 53 deletions(-)

-- 
2.25.1


