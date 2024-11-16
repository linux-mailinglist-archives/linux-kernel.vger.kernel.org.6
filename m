Return-Path: <linux-kernel+bounces-411535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97499CFBA4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F20A282EAB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30D8610C;
	Sat, 16 Nov 2024 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KJ3Sz5Z3"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E192107
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731716613; cv=none; b=Sel/PpOH5706ajZDWGCoE+A7bV/WPaRSDXXarWzsBSJUJ/rA4w4jO6fv55usBSU+Dgs2QBkPlDGv45HWe5Fy5MOpbQ5bmuaHGKBsyVYBxGix+arlxkviFTx3PAwB13s09S+Mnzv2NSbg887Elq633wzdNjU/YmctjxaffmVXkb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731716613; c=relaxed/simple;
	bh=WmS8zxT2Q1jka+KaHMF71D3onWxqZXl2ZWo6Thqnv24=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YeSfOVhSh8uwlbqnrq5drHV/gZIJJLDSJ/DEmkGqZHbhU3Ah1Zp3sYfmHPC5maFDWpRWqSAeZ0GMPYbuHd2eHv2GdeQAcn+AWwukLBLk8JZWzW91rKMF4/OQqYeWful+GaZ70QoSULHhHwa6+bhdwt9+rO/UEyjmBUGksvyLJLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KJ3Sz5Z3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ea3512feaeso265720a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731716611; x=1732321411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mAISKCygyKfiQBAPwtOOB4Nt2ymKuY8x1KhZAspiXJk=;
        b=KJ3Sz5Z3oIXvQPTnEQ1jv7NxBpaxnY5e7wr+XobSD60usLx+OHsgwFxiGrVGAM3p+5
         2RolSqXgg0qOmhx4rOQXhusWuIqcr5qUFbvyG943p/NflzIZEuIXDporbvWtUfJhE4Lb
         6HlFomgzNAdStkGMCChSK/IPyXW5cUffgBalQrvbGJTEBiHS0HNfnH3swBWJ66aRU9F7
         hSj2+JMIr+vQKe3JNTRidFdC0j3R6+URDoTSo+aZ8g7JlcNE2iwGMU8BseXiJTr/+Ogu
         0EQKB9JzHfXoJrxSLsWvO6tQLXRU58tg1u8vXfFaPT6m68HRQW6g1ODbkrcrYRmF48pf
         HkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731716611; x=1732321411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mAISKCygyKfiQBAPwtOOB4Nt2ymKuY8x1KhZAspiXJk=;
        b=tc3VuRk3K37KZncgNw+6JDfQORD0sN4bSu4YUU38tsHx+uYIbzpk6ZG8OMso0qk7K/
         gMr1DUJg3CroHQDnPOFyWnrQ/EJQW+MSpZDQEft9wMOA7i8N0QH2SzQW8ruPqzcDouI5
         GqVwMkgAKdRnVe8JM+6gWxqd75mHK+LO4vXe27LA9laCyCFbRL0h/XAjIw0Dv0o7gDgo
         +F4aXVjU+QmHP/SeenbdSRSTrA3CZ81avmOhPZFwygvGHgYAS3iV4Np0xYSP9sTzrGOc
         F3icirxI71lbmNwW3tRuvheZ5I9oYahSzm5LjbE4fGFH5/iPFe8PCtQPTOPBy1P9h9No
         qM/A==
X-Gm-Message-State: AOJu0YyZ6qrhcI8u+J14KGbHTjlvJCpvh1X6/VWt5fcFP1a6rWqBMqHO
	4h/lj3xTctRoq8dGhKTUUzSJBs2SzKRRcHoYHonGcHDk8mCIAlSt6sGxt0fGNeAukaARMkfwOx/
	8gi01keKNeIej8G9AoGfjIyiM1YUlhsDHQnc7VAkHQmuohLe5blZRsXfue1BJnOIRwDy1HgfDNz
	xyJE4TZZHsnsynRha1AKlAhMYRjeiWU7AbBHfFIJ6faqG0
X-Google-Smtp-Source: AGHT+IGr0l6UsZgGwMT35aAhg8C7sVqD2sj0qJzMrrVgYieTOOz6I+qWRoA7NuiQlbYXeHiYWEpFlbsr70Ns
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:ff04:b0:2ea:3177:f017 with SMTP id
 98e67ed59e1d1-2ea3177f170mr2524a91.1.1731716610858; Fri, 15 Nov 2024 16:23:30
 -0800 (PST)
Date: Fri, 15 Nov 2024 16:23:07 -0800
In-Reply-To: <20241116002322.1035417-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241116002322.1035417-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241116002322.1035417-2-jstultz@google.com>
Subject: [PATCH v2 2/2] lib: stackdepot: Avoid null pointer if
 stack_depot_save is called too early
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

If stack_depot_save is called before stackdepot has initialized
a null reference to the stack_table might be used, crashing the
system.

Instead, check stack_table has been initialized before going
further.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
 lib/stackdepot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 5ed34cc963fc..09780c835362 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -611,6 +611,9 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 	if (unlikely(nr_entries == 0) || stack_depot_disabled)
 		return 0;
 
+	if (!stack_table)
+		return 0;
+
 	hash = hash_stack(entries, nr_entries);
 	bucket = &stack_table[hash & stack_hash_mask];
 
-- 
2.47.0.338.g60cca15819-goog


