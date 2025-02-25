Return-Path: <linux-kernel+bounces-532320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EE3A44B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCED3A6C99
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7001C8626;
	Tue, 25 Feb 2025 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4lQxC/vP"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332DFEC2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512174; cv=none; b=Jm6VDOGP0QWEPPQCGfV9PSneNVW+2B5dkvc7Hr4dkgnVoDd5gyoqjiQgPvehrw+YpRGNTW8UB6PdFjxZzjwBkIV2dhhGNeoMsETEs35JsiRregx/2d51IqV5l/OA8aSO8FB5fXHG/5taLbt67mKS63iyoQfkK5VPF25bJnSI6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512174; c=relaxed/simple;
	bh=KG5MWZNUweaYYldKGZHsm0/vi9Gg3rQjK/eO40hF+vQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=f8UmksozhytHBQTmlKUOoTcfiQ1t812qEDTvOxEEI2ZDq1+0EaDKHjsol+1LJ/EMKw1zzb43WP7C78DrqMr08xDVpyhI0n5OVQ6L/QdxVttUzy2wlZv6+Usov7JmCPBf7Sx/aFaTT7x+y/Pxj8TH06VTdAAm9bbQ5tJbDSZksEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4lQxC/vP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5dd69746f5so8223598276.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740512172; x=1741116972; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m3pywi2vHa9A/RVrz4AHdduVJ/73uQpM4Dpx98DE2+U=;
        b=4lQxC/vPTcyxkCaZ7wzKKe2cTTyG4cOzSt2z3zCLP2oFqBZIM1nK70lJZQrc/2W7Pf
         3OCdgBfXehNkfJdag/EkWzquqZcS6vOIRW1kRlXozZ9Oe0bYt/vMNujISuq4sj02f8HO
         rt8QWXl0MB+36oOm/80Hv4TfuaepLgBSAAX+AfSryPPpEk2kHEZ8O6rjMvVtEQROGns+
         KSnQEGXjx04agaeCOUegkUsSERVtGK0IlHg8lWE8kYEKile7E1z2rgb3LPz5qH6Ky02W
         v5eKywsaPZIk96Y4PW0KOwlW0ZmTW0UnYVPiZs3bTlqPNUZTwxDXOZWMBucI6B9rX0AV
         WQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740512172; x=1741116972;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3pywi2vHa9A/RVrz4AHdduVJ/73uQpM4Dpx98DE2+U=;
        b=jdbP8FWOEoluenDGm9xhiie/5WSFJUjA4F7fNNbdrSrNv4A66IZcBSmIOni8z13/9M
         Qsq1bN7GEplNGd2MglPRBkAaVupJYDFvQhLEVDTwaO5fNkaJKZZuP6dYBJ+KeWGlrBf4
         9gfjhVqaK7KzcKRPeEL1QAw/hwwcr1wPNEjXbVWb7uEbnuhavddAAYvHCglhh2+IPIea
         HAnAqtn6Oz+lHhByaKA97EGBFoc9T0T/criCfT3zEUytRxCtDCvLCs5A9NzLg++8Ey1Z
         xOWT1XSY2LGk+jHUQAar4Yx70rCPFQhl+PcGTgwm/P0vSX1TQv3+y3dG96ahrYx53D38
         jiaw==
X-Forwarded-Encrypted: i=1; AJvYcCWkqFbiQtO+R2Gum+1gc4qZVPJgzJ/5Heh0YwUm4Gi3hfAoGO5Fhck7M2J02Fbwrr92CFDDPnxQW4BFtKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRoGR+iZ9ER5vheGkcI+31vZe+/qp+IkkPd09fpkDtOBu4D53H
	KFxmQt0hJkNW7+hPOkA9YALztEcczmJsFkZeGt2uUpugk6NrCnwG5JaJdmK+itZ3Lwsy/0WBURQ
	iU64DcA==
X-Google-Smtp-Source: AGHT+IF+rqRKsMslRLdrMWlb6cIa/Q0Qd+fRL+o/sfhU3rqig48SrWa5nfxjCHfBLk0jJm8fftR68L6DsEtA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ea22:428a:b9cc:203c])
 (user=irogers job=sendgmr) by 2002:a25:abab:0:b0:e5e:1cb:25b4 with SMTP id
 3f1490d57ef6-e5e245004f2mr126315276.0.1740512172139; Tue, 25 Feb 2025
 11:36:12 -0800 (PST)
Date: Tue, 25 Feb 2025 11:36:00 -0800
Message-Id: <20250225193600.90037-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v1] x86/insn: Fix linux/unaligned.h include path
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ian Rogers <irogers@google.com>, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"

tools/arch/x86/include/linux doesn't exist but building is working by
virtue of a -I. Building using bazel this fails. Use angle brackets to
include unaligned.h so there isn't an invalid relative include.

Fixes: 5f60d5f6bbc1 ("move asm/unaligned.h to linux/unaligned.h")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/arch/x86/lib/insn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index ab5cdc3337da..e91d4c4e1c16 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -13,7 +13,7 @@
 #endif
 #include "../include/asm/inat.h" /* __ignore_sync_check__ */
 #include "../include/asm/insn.h" /* __ignore_sync_check__ */
-#include "../include/linux/unaligned.h" /* __ignore_sync_check__ */
+#include <linux/unaligned.h> /* __ignore_sync_check__ */
 
 #include <linux/errno.h>
 #include <linux/kconfig.h>
-- 
2.48.1.711.g2feabab25a-goog


