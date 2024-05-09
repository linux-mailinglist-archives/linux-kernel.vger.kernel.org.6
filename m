Return-Path: <linux-kernel+bounces-174878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587E68C167A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9FB1C230BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9806013BC0F;
	Thu,  9 May 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFTp/NUm"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9AB13BACD
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284935; cv=none; b=YHudh967mw17HW1CY9IZF1QGBElPI/Qw0uD6NpG5HauvCW4yrZTNo1gkZNTDtmQNpeXJBB5FoJJha5WTxSRn4Qv9xVEtiyrK5sJWUx1XR08en/4hk0G24Yck4UObrjvfCF5afnpnHie1FTHatUeEAxO4QFYLDZqF1SlmDr4WyZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284935; c=relaxed/simple;
	bh=Q8vMNdjv6oUz3ffMNcoe90QZDt2uRoBqgozhP5DTiA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d80/sMHeykQVNN7oKWeBG+MVbl0kPU9JyLPtZWoiTmWNrOfXeXiE2oUnxM+dtCHqpaOxuCzGA/wn3uJIHQlroJilJ90Nw360VZNjgpiwb5XCYPP24DrWMZe7que7NJEnfI0v7p/mGbjD91tkZ8tIvIeGBY7QkS0zFkXUDWzpX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFTp/NUm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso2139810276.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284933; x=1715889733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ea0S0oR7atF2Lg5jk6+sVnhZ8gGTM0V6dmG3kMF6TeI=;
        b=IFTp/NUmnUR+jPPz4ujog3zcMgIwi3YGl67rPta55u0EYf55NSd92iDLr2zqaMJ7Ge
         a8fMNeB4LzFmiXwz34o3m+tI8GnDdJ+ie3emfW5JcPmxnXx7gYSvly1UWadyXOmY9h5v
         kDWJ8Yp5IfDhmMylqCSkgemMI4oK0PtB7qXiuB1Kb50H2b55NXwB6rtUmNpzJexISHju
         2oe0f9U4h+k54Ha7p1H16kdt5DE7mbYTMfvZpKiOy/x5QbcvoMkk8IJXCAGljyHI1G/5
         D8tN38y3Nv52Blzefk+23RURsZW2ZEM29+cf1dl8TVik3dSk5Fc+GVXMU6sDuYCo/ALZ
         lq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284933; x=1715889733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ea0S0oR7atF2Lg5jk6+sVnhZ8gGTM0V6dmG3kMF6TeI=;
        b=rwYHyJQs4MASySDS6jtVmItXBqgf6Swqs9cJ0fmm4j2zIpY+R8ie/n0iRwL3pZb8h2
         g8WHC+k6fXuYjodfL4vMwGFKYuifC8cVP43eFvcgrXbZYYnzoadLWvQjtmY4V+jQym1T
         vSTOCQkenOgazCfK15eURp/MNTMXbOnZDFUOSW0EIDbO9uAADsTMRJpOHZN4ymTJeYx0
         HTtpYwIcLTqh9EBH5CfUGfkrXfhV5OoqHLM8IkK2xdlGvB9HmxzROH0qMWcZ37lT1dET
         X+Q76c2OR8PdqCLMgub+Hhq270p2LFk29aPs0RZQCzkQO/yFQj3gegI9hdj0Fez6yN4D
         M7/Q==
X-Gm-Message-State: AOJu0YwII2KzWRLj/Bsro0R9zN+UlNYBlhSVFSSVqf6EGnLf1hAouqJI
	R5PR4cEn5WCiQzD46Cig8c+sBWUsARX6S596qNrzpO1Rx8BWNn1gFR8X+w3BQc8fdtTg7e+AuiY
	OpA==
X-Google-Smtp-Source: AGHT+IF/jnDS4ymNWQMUF/oWdD6iqbobUDLDZUHVjJQIP+SRjrwW5c29IOEMwIEB1XpBJKq7KUUsEHKahpI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1002:b0:de5:9f2c:c17c with SMTP id
 3f1490d57ef6-dee4f37bbfbmr149190276.9.1715284933545; Thu, 09 May 2024
 13:02:13 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:23 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-32-edliaw@google.com>
Subject: [PATCH v3 31/68] selftests/mincore: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mincore/mincore_selftest.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index e949a43a6145..e12398366523 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -4,9 +4,6 @@
  *
  * Copyright (C) 2020 Collabora, Ltd.
  */
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


