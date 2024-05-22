Return-Path: <linux-kernel+bounces-185623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A7E8CB7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842B32845D2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2AE154C12;
	Wed, 22 May 2024 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCcbTFAn"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4F154C11
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339714; cv=none; b=aIp/AFcFT2gduJjPmVI0YFRW6NgdJPJV0w23FaiqGyFDPVdnuXx+G9ztsjmrqR7Nse0rz94VcCmQsKGY92OHNw4iIi+MTgLl+UqZ0wZNgxcAJrLzuqJnVt1YG9VSax5V5LSU4VSItjpK7WM8aJZecyPHedd00SXq6RcqDUhZCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339714; c=relaxed/simple;
	bh=HG/fzBjmfKcxpb5f3B0yExIXXkrOGmT9xMnSqfeC5lk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gcBamtDMWCmSer5r8HWN50/5elVoZnZ7ZqU1MlsCzYvPUosWnYWBB5OKHLH8IkUffSIjEohSJ6x9sxqqapcPRLe0LaAEXjCdaEgvnhDHZHcphUyxgntwICRT+uu+jPwus7LmJ/p10oqfzeEpUiQ5l4vRlugvuoYXCVEakFix3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oCcbTFAn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1f314d14930so7550465ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339712; x=1716944512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8sLKR2gMdZkVeKpBpgxiG+z3Q3TQVVoa/qct09zlNg=;
        b=oCcbTFAnLAL2kv1/D8+Qt6Un0xj8UpwQlTiwGN6BOMSMbwo5CGth3F4+n6b1fp6q2Z
         0xb5jhKZNypiwCOgSeZl29sGLa8kzhzpnuAlzux1P9S9CuOhQbO+oX8ec61GgS5K4Bn6
         WUq1iTsYGH6E7WfCAWmgj9cCdFBDwk/IKWIUu3p1pQuvuv5ooHChGxAq/Y62Nm0Viarg
         lX2KQWoQtPalOrzfTg8VM0aBzEaa5VTdNRJT8b2uv2gKQQ5WSTF9jqtNBizlI5rDs+oH
         kLmnmMfODzoaMNMKtm19TwlXmZ7CKjztaFoB/jES3CN4jsVBk5Xz/xXR8QOFIxkIc618
         gCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339712; x=1716944512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8sLKR2gMdZkVeKpBpgxiG+z3Q3TQVVoa/qct09zlNg=;
        b=L8Jr46sFC1Z0UZ/wKfC3Plo4lDJp2TX+0NnXD+Q9Nf5RhrPYH9SnZqX+VLj10HnlkM
         Eg13j3tjLE6a09YTZ2k4o+LnjXjTr4VlWooTS8ia/Rxv3AKqYXAoL4VvBPrr3acsm9+Z
         VMIEpJfldA0Ry1NNuKTveYO2koyH+V75NiJDTn+VSsTebax2BCUpILS6MA2g5RUahfZo
         y07/M/fsS5ZseLCSFJzizY4g45KPxsVLLGRZe+PUUsWGjJvvmzU2SEN3ilurzMfuPhxD
         mpKR+7C7lXHum6oyteZT4bPsmkHFJYPXWpP/sAdIBWRnfBpuCsKLrCqw5oxPxpHSPGmP
         nnyw==
X-Gm-Message-State: AOJu0Yzd7YEMpd/bFEsLBI4yS3w3tWhSEDQYiWbXtDaedM4T1Gp/imQQ
	GfmG4ip7hVIMHyUUFjfWGs1Usj1i29yJC0CPpD3yWeqsIMOVL6K6r6eLYK15hhtNsx9401yOEds
	pDw==
X-Google-Smtp-Source: AGHT+IGuQmIgWokYa6GFSf+m5Z57mXGg+LljOBmerbd3gJBjFhivGNVqaTCd4aTQnhoWGr5w0Jse9j9GlEI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f213:b0:1eb:51a3:75ee with SMTP id
 d9443c01a7336-1f31c95c280mr34845ad.4.1716339712356; Tue, 21 May 2024 18:01:52
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:33 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-48-edliaw@google.com>
Subject: [PATCH v5 47/68] selftests/ptp: Drop define _GNU_SOURCE
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

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/ptp/testptp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 011252fe238c..ea3c48b97468 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -4,7 +4,6 @@
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
  */
-#define _GNU_SOURCE
 #define __SANE_USERSPACE_TYPES__        /* For PPC64, to get LL64 types */
 #include <errno.h>
 #include <fcntl.h>
-- 
2.45.1.288.g0e0cd299f1-goog


