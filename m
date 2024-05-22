Return-Path: <linux-kernel+bounces-185640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4781A8CB845
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033DB280A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7307215B991;
	Wed, 22 May 2024 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUqi38Nd"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F515B96D
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339757; cv=none; b=LiDDw0Udsy1oOxyoU4cVi+CViAGJtlbZOjyj80ZN1FK9993fBFoo6CCVCIh1J7j/AG27sXfHpdMzuIXtLdy2n0FBEYvQNaLmhIK0d06DMT6xn8bgHEzthATE0yvUd+524SVHS4dlIjA9A/49vixJWFPTYKka066Ty+M2RwhddVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339757; c=relaxed/simple;
	bh=XjLDp8cUGRvX84+Q9aIS9dPGIChvC28mo14HZv80yTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nysfjtDMc/pFdm5EuSdHwnNVaBveMKtN09J0VXcqX6xLqWPOBubwxdupFasW0wvnmE55gwyZNScUK1NIiecyYow7XfeC9u43IqRTjX3pMXDBdORhrefayvz7X7adY5MrLyWod0Qm/8IbWA90gS0z31QhTkPbLkW1TOfL85GnxpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DUqi38Nd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1eec5aba2bdso117460205ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339756; x=1716944556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=THfAbUsdCLmnmf31zE9Pe2u6BNmh9uFbN2fzLklxkz4=;
        b=DUqi38Ndw87/I0IuyPXlcfBjlFISCrEYcZJlLAupDk0ep2uJEhFx5JWJYXxf1874ZU
         O4VQjI+QfWNK+X9nr35zK8pijuNwwm795x4ktXd4sVkV2adO3/ji7ZYMBqmqYi/l/VB5
         NEP7cvh6xH7HCoW7M7Uyc7VBJQS6LnuKjhJOeO5LP8gJWtSG8lXYc8zmnrK/61siXbCy
         CDPsPJh8E/F2hg/UuO+4JnNCxIfPXM2myy/+DxrAEzkD8CE9Rld7Agzg7kRibd0PrjDQ
         va7y4/a+ur6sJycPNmSS1NJwyNp+jdFGrbQD/UlgRiovQeLX4K9HpO/qqI6FCt/cznXC
         oouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339756; x=1716944556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THfAbUsdCLmnmf31zE9Pe2u6BNmh9uFbN2fzLklxkz4=;
        b=DDZakldZ4xgu09nFsPU0Sh4f5yOsNrIIuzV+h/bxkJ5GCvCIis60abUjRYa450h0A3
         SAah0sIwTKcaU/QwZ8mNCSZNZeyWHEwoRv6pB45oq6nOXqAdYKOIM0s9X2RpC4dsYNJ0
         qAUTLYdqhQUWBAHFiXQRnrJJDZb0krZH1sqwnjoqtV3P1xxqNhCcuTcjgYHds1n8knX8
         XvLydsklYmfnV2VF6SiZroJW0+4eYdWxvaJdw+Yft8ymhW4RhsJmWQXLJ3XmEYrN/UC1
         +z6biq/xpkXGI62Qagr9TDXgsbd+aFqxET+Anu/KS7xlm+bsdWzfSUVgSEKQ01gZPB6g
         ANxw==
X-Gm-Message-State: AOJu0YxRpBGqAdgiNe66oYkeigNEl2VNgRalSDBfV07YbrqVbwTU8/5w
	lKi9Gk39bvGSJQJy7Jg4Xjlnh/Hwcu+o0nt7F6gVIq9qKSSupQYWkNeQdHvL89Tw+nY38C2biph
	HXA==
X-Google-Smtp-Source: AGHT+IF2I2FWOecHFUCcN7nKq/bwhFKSfcaBbhOfbRL9O8f91+0Uq1k+MIvBsT42EkpQs0UJXpRvR7cMkog=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f7cd:b0:1eb:829:b6e3 with SMTP id
 d9443c01a7336-1f31c9672a0mr175035ad.4.1716339755383; Tue, 21 May 2024
 18:02:35 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:50 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-65-edliaw@google.com>
Subject: [PATCH v5 64/68] selftests/user_events: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/user_events/abi_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 7288a05136ba..a1f156dbbd56 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -4,8 +4,6 @@
  *
  * Copyright (c) 2022 Beau Belgrave <beaub@linux.microsoft.com>
  */
-
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <errno.h>
-- 
2.45.1.288.g0e0cd299f1-goog


