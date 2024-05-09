Return-Path: <linux-kernel+bounces-174869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28688C1651
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C22B285A79
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F73C138482;
	Thu,  9 May 2024 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="chFricDo"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B17F13792E
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284914; cv=none; b=tW2hQTmd0brgUIGW2qxExaHgK7w8DG1pYbIE9FVa8E8j+H5ekc/6bVW++xe6xw9aRrlKG54RTrJQvuYWDe4j0MZjAC/bKc4zkO4xZGVw85pnAAIlWJzG2AHS4WFd8UhBMQIC4xO7uupTbjpUtRK4naTnZ9LaJodMoORQIyUtT4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284914; c=relaxed/simple;
	bh=VGsCQqHe1ICNXcu6Xm0RUTfwKrG6XqF3VyhcVP10zHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lBCic6aTV6qoJlk8Wwf57KcNmsyW17pOMPx2NLjOCYbZevWnM4Tt+3dq3ZF3woI5iQ+6N5BRo/S+FrcoX/LeVM7qePfP8yKCrTqDq4cWYmb/Cqx7lcHnqydkSYCXI+97NYTnLFH5rGPCaS5Pe9VD/benRxZzGWGH9Oeie2yfs5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=chFricDo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-635731168f7so512621a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284912; x=1715889712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=29EvGICOAZ0F1vgmDohmB/AvF71KDeoXeGxlYusrQjw=;
        b=chFricDoC+Fdh4vS5MoUveobxKE5C+Okrw59WyWVFibQECFehw79gA7jzxnRvFv8GX
         oWnCO3ou5pNS8JoW0gz4xiKI+cbqLUjMOxikRsIKlxuALRN6pH9ANP8e+LMA8NjFAfUa
         BFlRl0MEy/PIEyy8vXxenQYVd19RdKiQqtcGp8OWWDkxzLjzitEBItII4z0CPgDdQpVN
         NVh5Yi5IhsWw9nXP6mF3YUVzd6hmH3RsktVtj/bnLof/j88fvKztJnrhD4mE7RAjtQsY
         9MvmO2Vjnzui29ky/mnAm/JgTWkjzcT5cTJgkpvHFGqbfVU5/qMpJj6zq8MSYt5Uxvmv
         Vgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284912; x=1715889712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29EvGICOAZ0F1vgmDohmB/AvF71KDeoXeGxlYusrQjw=;
        b=qjbBrob7Oqa8R0KZUkQypDOJubALCum9GHYE0DkV+WPc3qA2bMNC/xd9q6QjBdr3r3
         rNLEDP/jNPSPkDRQuGGi3SZzaWpG9uTRjV0IyHi1TeRt4L1mSWbPXp7MjRhH2HrDET9u
         0SYTnQy4sAb9juf0lh+SP0sv5MbP9h3pEHmH8+8T+dzTHnFNG1E3+COm90V1DHl0IcVk
         TEDPUC/o3zaOSvxU9bk+d32jX2hnQMbXL/79Cctm2lfMK0wQ2tzjNyAg4+pItsrCANho
         8tJPOFOsUko+0vxLvofqtKMH14CadGrOSD+1CoOw6b0qXplH6qC1CZvegf3HjgnwgFCf
         7fUw==
X-Gm-Message-State: AOJu0Yy3YLyBWAdarTP9CryniMu6V4epzNUBbbTmoUMdv/UnVwnArcJM
	iy/d9qyCOCiiy4pKO1jW7hryya8iUWXF+tgpNs7LwLrfWDpRWdKo/NKvxaCjwszs1YkSMO1BAn/
	DqA==
X-Google-Smtp-Source: AGHT+IExsnAklZVtVghvLsMabbdi8FZgDS5AyDRMtR6GiyjsnqQrJZG4Wi2JzFqUxOoc8PAeH7g5t5xlaP8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:2742:0:b0:5dc:8f95:3d with SMTP id
 41be03b00d2f7-6373e5492b5mr921a12.2.1715284912360; Thu, 09 May 2024 13:01:52
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:15 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-24-edliaw@google.com>
Subject: [PATCH v3 23/68] selftests/intel_pstate: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/intel_pstate/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/intel_pstate/Makefile b/tools/testing/selftests/intel_pstate/Makefile
index 05d66ef50c97..f45372cb00fe 100644
--- a/tools/testing/selftests/intel_pstate/Makefile
+++ b/tools/testing/selftests/intel_pstate/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS := $(CFLAGS) -Wall -D_GNU_SOURCE
+CFLAGS := $(CFLAGS) -Wall
 LDLIBS += -lm
 
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
-- 
2.45.0.118.g7fe29c98d7-goog


