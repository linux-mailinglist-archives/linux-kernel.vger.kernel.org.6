Return-Path: <linux-kernel+bounces-569218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862E9A6A01F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D666189EE08
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC21F1C3F02;
	Thu, 20 Mar 2025 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edSa4umq"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63091E1E0C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454481; cv=none; b=Fr6v49S3WZnJBM6yU0ZfV/DwohTr08+Iu4vV9f6ZMUwIOTIwMhDgN743cBXLuOFQqDQaTj94Z9qgtcSMDdHHsqORAaq3KO9HCIdtJQz7R+mxtm4Exspal5yv8WDnNJeT/QX01z4B5v1loplV3mhc00p55O1dHNqvM/mR6pbB6A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454481; c=relaxed/simple;
	bh=uw4b/RiiXEWF+KXFroVNQ+bW5DLJqNu80c1YkYmPNfI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Rv1pGXsXl4PGIg0gwMY47ZA0vOmBBAaOykh8yju7aoNA6c/b4XQUgjGhe/0U6OgZGgzQO2vkUFx3U4Uu/IqKC11zpmetyn5ldxd0aKweLC41HaA8Io4f8RJ4tmiBjMetBxC8Z5mjd52KUCHtvMpZbG7Ex+ch95sg2W0O0SeYwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=edSa4umq; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d025a52c2so2792155e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 00:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742454478; x=1743059278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m6h+F0/nFdWzGpVnaI7g3BhPqw9suQPatRe63A5Wf4Q=;
        b=edSa4umqXgjIJ53UKj+8rj4PQ/ynlp29DIF+RV44OI+RL7yK4EX8Pi1w1Zofr0JV38
         aazStfAhnTpKi4yQgpfxcFLbGsdvUsqkrF0k4jw4wYaUSAM0D6TVUAIzuHjMERs3tI09
         NztwfUWg/Mch3K+MU9DtbD1l/1lcYycCn3HBtq9yys6Jy08l03b5TfqRW7iX3SBmr9j4
         G+3zI8IDS3fws/OjTS/1SiLq3ypv0QVwUHWQx81ux6jG5LmEtsxwAHJnRoc/t1+GcTRv
         nmDmPIpj+3lfim1f6ju2SbEAeo48OTvKOs4HO9EY8F2nopkqEk44GeKuwgbRT4UtWu9F
         PFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742454478; x=1743059278;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m6h+F0/nFdWzGpVnaI7g3BhPqw9suQPatRe63A5Wf4Q=;
        b=WGzwDjZ0abeceXAw4k8ijxwwgYTo9TMnEmoND3UzWdMgLeZmslweuZ6LRxMYyfhq0H
         ptdDumYFZ2nucT7geF910XeFT49Kj4K8xXaybJ9obpE6we+PNHSVEK1yNF1MKvTmRkfI
         MN/rXo08SBEObl2eHXyYSCcjg4sIETUhet036Hu0RII4ANiNeNxTLntRkXvZRWybKiwg
         YN02pr5KjWFxRcsRK1SXknFd/82Helu1kOAwyfx8zQmlv3yd/wnyW4o9oIYaPAr4jz3t
         Lfn2tA7tM0H/sCkEqtufYrmIpE+RLOG2d6VIZhcjZaxHCVxS4dwiR9rewd1tQ5wUkqJQ
         UEpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvRUSKO9q0gko/bT9a/3YSxQKbPVu+01VEJQ5pNgB3lIiZMXyp7ULig21gbuOTaquta8T/A1aQl3eQds8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6AnXOA2q+1wMa2bNY1G4btx5aAjA3n28lrVRS6jj8Mr7KpTz
	agpq+8f5OJHhy1oa+ZTT1eu4s7Oh/ElMMVEjBb76aZ9w4ZGxhVm9664LQr2Xi43dspQvfQ==
X-Google-Smtp-Source: AGHT+IF+VnrL0v5CYAVKdki8Klh5wzn3sWCYydvi8udh+gEgZZ1pS2CxLE2W83x2ewvKpLCNR+0S3ZkP
X-Received: from wmdd10.prod.google.com ([2002:a05:600c:a20a:b0:43c:fcfd:1ce5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c115:b0:43d:563:6fef
 with SMTP id 5b1f17b1804b1-43d43bee99emr28493805e9.21.1742454478140; Thu, 20
 Mar 2025 00:07:58 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:07:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=ardb@kernel.org;
 h=from:subject; bh=UbRvGXHmXbz1+l9NIU5EXHMwFDxs4liL7vgOZJ6xpHc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf32vsPRLfxxXZeMZmazXBExPRYcvi75EtNsRv2ip0Ve0
 ysW7CvrKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNpfcfI0LzsSsm5YObvysnf
 Kn5Gt+5T4g9LLJ6tuZ7J7/WhIv8t4owM19ct5L6WU2V+aqpE1fZrYWvMKqsDz3F9nGUeXVR8KnQ GDwA=
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320070746.101552-2-ardb+git@google.com>
Subject: [PATCH] gendwarfksyms: define __GENKSYMS__ when processing asm-protoypes.h
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kbuild@vger.kernel.org
Cc: brgerst@gmail.com, x86@kernel.org, masahiroy@kernel.org, nathan@kernel.org, 
	linux-kernel@vger.kernel.org, nogikh@google.com, 
	Ard Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	syzbot+06fd1a3613c50d36129e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Ensure that __GENKSYMS__ is #define'd when passing asm/asm-prototypes.h
through the compiler to capture the exported symbols. This ensures that
exported symbols such as __ref_stack_chk_guard on x86, which is declared
conditionally, is visible to the tool.

Otherwise, an error such as the below may be raised, breaking the build
when CONFIG_GENDWARFKSYMS=y

  <stdin>:4:15: error: use of undeclared identifier '__ref_stack_chk_guard'

Cc: Sami Tolvanen <samitolvanen@google.com>
Reported-by: syzbot+06fd1a3613c50d36129e@syzkaller.appspotmail.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 scripts/Makefile.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 993708d11874..7855cdc4e763 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -305,6 +305,7 @@ $(obj)/%.rs: $(obj)/%.rs.S FORCE
 getasmexports =								\
    { echo "\#include <linux/kernel.h>" ;				\
      echo "\#include <linux/string.h>" ;				\
+     echo "\#define  __GENKSYMS__" ;					\
      echo "\#include <asm/asm-prototypes.h>" ;				\
      $(call getexportsymbols,EXPORT_SYMBOL(\1);) ; }
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


