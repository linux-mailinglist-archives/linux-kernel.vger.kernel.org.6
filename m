Return-Path: <linux-kernel+bounces-382384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E999B0D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9931C22C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D968518D62A;
	Fri, 25 Oct 2024 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1BNiwmkf"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6085118BC23
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880453; cv=none; b=nwcGlbwvNu0bTkt2kfjlXl7ohasbyHQAEvMLbiEIkMf0Kr7F09wxdl5wCSsy9Evl+nOuffGYEfaBf6wqf9IseG4e2OnoKXVtjiOhBkSOPyFf4o9jTZU120kDUUU42oBJZn/rECrKa357STrqAdDb6/F8ctmXpoFWJyPEPu9pQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880453; c=relaxed/simple;
	bh=a6zZTZkAMo+zqGztqVGNTRaIEb0mb+Y9Lnu9Gu2Sp4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LooYJcsIsjvLtpEGUXYaaa3gmmdmB7CgIM8WusaNchIS9Pay3rkqbFAO8kdgvbl2RZNwde7A/Q3egxmiMGn0P1c9GbCA65a7b9s6+NMcaYEkygXVy9h1pIgfJKj6JU+hBswkrmZK1m4S8duxgqf89eJz5RzVAGB8j/LB1CS5cec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1BNiwmkf; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71ebf65fe6bso2373255b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729880451; x=1730485251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/FzCKkZzvJstDaLglCOzaVhmGuwzgqmPghGo88HmjU=;
        b=1BNiwmkfRukInRzQLU4ubIKcLpbABrGklXskqw3nH0IcFx3Ui/X4X7UHxs3zHwjNeY
         v/lZED8gbCk7RN/JbFaI7Ot17BTXzERQj1AqAdcyG3G0Oe7pHBT2kXkf6P5oP32F5aIC
         MMVcJJYmsYubWkiJGodNQdkafnrh2D4M1O5JGADx/eIymVx9Y6FB+CwYQRvAMULf+577
         hxbrOY6hR6ugNpsiAoKJSbdT8t7y6/k/02H/yUOiw1oXmJon77RiXBPLSJQVl8ORLkI/
         XoekzS33pCZphbgNiEukoUM2POiRv67wi5jON8jOGzVPmaQOq1uMf0LogojsqXTYBmAE
         9h4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729880451; x=1730485251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/FzCKkZzvJstDaLglCOzaVhmGuwzgqmPghGo88HmjU=;
        b=H7p4J65+68VoiRcAqCjc6moDRaefWpPJkKDayA4Xtw2I8jwRCAjXrFD951gaodaaTr
         Y1Lp89k1FgBF/tp4Bmx9nK+p4BST9uycQ33DbXNi2jhAsC6Wyo4Lp9SkD9NhG/jizoBA
         DYXe4C1HMfwKGId9qZdpWmWxCCWx2A70SlMv5zYp9VHDfwUDyJE+SPYenjFBfceEjHm0
         gEVioRnehz66iI5hoVzOCM+9CMkGFQBnZ7xKvh6h7Ua2zXmlTmwupUtwc2SyrwqdCwMD
         DONq5nLmJwhfUwJBSX+myaP9kbGjt9LxeSC4LEIcXr0U74ZmFWv799wBwaH1QcAP493l
         JDjw==
X-Gm-Message-State: AOJu0YxtBAyJWwFPXM8VXNga4M4+Ll+yalyEO2pWX+tnecn8Ie6V+XZK
	kgpfKKt2kU3hIJYWKz/rsHDR7n3wL933dtAcvL1U+sGFtqoMOl+4Sd2k6ZjyKzvUNAwM/NqV2fd
	SyH3y/AsNuzO47t998E+s+fVPc/b7mM8Up6kdsfILREbqVEWompBtyF06gKRiKEYjEk2ITYkqff
	pDfVPv9bVsI3+QB66CJhxLKjCEUdUgO10ph7UUmUhC6c+A
X-Google-Smtp-Source: AGHT+IGnEjihC5QbbL3J0qlq7fny5Hy+kLzJtJIRG8GaZmdm1jyWlF/JXP/IRPAnbG+VFdX38Pas6Pay3VAF
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:6518:b0:71e:50e2:5f6f with SMTP
 id d2e1a72fcca58-72062a4eeeamr399b3a.0.1729880449560; Fri, 25 Oct 2024
 11:20:49 -0700 (PDT)
Date: Fri, 25 Oct 2024 11:20:33 -0700
In-Reply-To: <20241025182042.131384-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025182042.131384-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241025182042.131384-2-jstultz@google.com>
Subject: [RFC][PATCH v2 2/2] lib: stackdepot: Avoid null pointer if
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
2.47.0.163.g1226f6d8fa-goog


