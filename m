Return-Path: <linux-kernel+bounces-174858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94528C1618
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D0A1F21EC5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279F113048F;
	Thu,  9 May 2024 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yuy2xw9z"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D6012D758
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284885; cv=none; b=WvadRGVfWruHbe4lo1PYJ/kP7Bo3FAVmkpR8EyzOu9bEuTfC+a3JjGRvpe1pHwD5qT+Z4vJOSLYuTt0wQdhCGQT0gaSwAmrcCyO4AMYVrPOcj0Gd0ZSh/Aibt9y3mMX0hpSB0zw+6oK04X1AqCNpxGyRY5zuXJLJnUeIBuwiGyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284885; c=relaxed/simple;
	bh=1K0xCZRVD3vn54vwOcfFPXDF9T0L4kexPHQ9ePKy6Kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GNo2m2pqlUTSDrp9sXpXXhuynifeU4OLIsWl1y2NdRwlZX5xoPKJhoL6mcYLCDeCHZbQWt8yakfX/M9Kx9oHGfblwZEMGYeUU78Uco9BBCUpDD/kzogIsPTJSZVqZ9BDEBx/L7Yqwk4/TD96Y4WKxM+QzQFhNedJecjlh+BzbdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yuy2xw9z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f467b9e948so1252859b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284883; x=1715889683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TU/vpufr9a9ZUHQPOG3JePKH031tzM2+5PrrIqHPNIs=;
        b=yuy2xw9zJxR0T90PEJcbIfBYa4md0HVAwOlsng3ZA8QNPP5v8ZXCGsUNTqKpJU9DHz
         Jz7MqlxMY+JfBQBdvjuHBjmIvUAa/bPUF9Nge3DC8oijKARoygZ/DOQt72njtY9PMaBg
         fqKoCNhRCHh85tISlcnnyaZqDyVaIkgHkLZZ0Uy1cnsrD4Nul36lya5dm2iR/g+xKJ7V
         iudhx/3GAtRnNTm1TqyuYeUCn2uk0b9d2wCwxtaP9XAYFyfZZujsyX6UNRWckrh/D39K
         kIXqoTaxhGiKIJS2oYupSUUQ0AOvMre3tLCw5++Xofo3KjmsjULAegRdpGOaPetFoqv2
         tnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284883; x=1715889683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TU/vpufr9a9ZUHQPOG3JePKH031tzM2+5PrrIqHPNIs=;
        b=ijZvhzLPiN4jywmA5TnMuR3xSnJvlEddt/RyRsul66LuzIsrjj8NdsSUvIu1j/AP/a
         IZWY0ZG3R8SQF0ThcmYxKy70R44kktebmDkeu4+DIQSO06Bv3EkUc2vX8uZrgJQx1UEn
         RFx0GXiD4f/uRneZMUgN496yPkfVMebvk87GCPOt1uVWKi4ojCNwr1oytSlt4NeM3LIu
         //j+aLxV9K3JKA1Bs25/Hix0eWOis/A2kBoG0iAL0/XTFaBmqnHJKEas/9jyTM5xJs2Z
         5ak6k5aNJnkwLkLoR7lc0tAA6E01C742b/KM++O3ovauWYJqhyCaiQya/OaCzA6W47TE
         ihZw==
X-Gm-Message-State: AOJu0Yzn8r7gIQiGICvhHoLeAMYX9ctj4+5ort/cRotOT25lynQi7ymn
	17otToaScWDgc1qX8G0dfDTpnErXjdljLwrUAocoRMTbOInzgW5OSDkrmBgRk4ZRvkCHNwc++te
	eFQ==
X-Google-Smtp-Source: AGHT+IF1zeNl7G2mrY5GSol57Wmpqj9CLyOfkFGR2ecW54/KxC4a46reBAyc7WewMqRKduaOo7Ktdkz2CAY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:98b:b0:6f3:ead3:c280 with SMTP id
 d2e1a72fcca58-6f4e027813amr25753b3a.2.1715284883459; Thu, 09 May 2024
 13:01:23 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:04 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-13-edliaw@google.com>
Subject: [PATCH v3 12/68] selftests/core: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/core/close_range_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index c59e4adb905d..1c2902bcc913 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/kernel.h>
-- 
2.45.0.118.g7fe29c98d7-goog


