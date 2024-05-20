Return-Path: <linux-kernel+bounces-184279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9278CA4C7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7E8281C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F4813A25C;
	Mon, 20 May 2024 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PhteVsDs"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C834AEF0
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245533; cv=none; b=RZxNxjyQgQAd6oUlDL0XrCCY5m6fYeUWJdQFvG3j/eJyMabrlRjS44J11q+N1enMv5TjcjO/06zBEq2rHqg+VqiOqPaRLCLikeJx1qa0Kl4KmGIV5C58oGrnz0RO5sPA0vRPGjhIl/85get6xt63ec9h2ojPdxr4SZgRBRFYCjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245533; c=relaxed/simple;
	bh=LSyLwFwwGKbsWNrZ97yRysd1sjCxGAdHZ+B46seWahg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUA+h7qIGkkKCVy5Xari7Fa1/SRDbSKbHB467kYRgyKafnTIaYl7ESaTeuQZePWMuPF4pkTewkNxdXDt4f2xyykJNhYJptfQbw5qjvWfEFhn7EbAPmyrq0/oJ3O3uQIHKzZ3YXJkvE1My/O+8AMjqs+7sRlkeYbsSQ+M8MeUGfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PhteVsDs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso84898635ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716245532; x=1716850332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IpQC4KCd8hRD1xiB1n+nGcrKBWSRDOzqTKV1oG7H/w0=;
        b=PhteVsDsGPaYJCFHGJkoXgrYY8HfNzgnUwNSF1BLh0wPUKSYuyGlLh4Q8W3dA22/eq
         MOkPD6xYYl84dSf3XCFB+21eGuu10/6iO6gyQ3qc84HK7OpwSZXzD36BVa4lLndThtNr
         Bxomr3yeeswl6Drm9CQGOZUXajw8Ve55LAMWI/rhlO+y148+dfPaJwXtNDFIllQK/6yS
         ZR082VVr8l58gwr8upmOB6nDkp17gezGCF7VfDt/1ubD3dCTFYMbEh2UpMduyr1nnXRX
         ZVpuc9iueczHigXZb4lviKsIAmbhnDJwFB02oXJB1XX+D09ej4J3WzCteUk1FGMZN+cv
         p0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716245532; x=1716850332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IpQC4KCd8hRD1xiB1n+nGcrKBWSRDOzqTKV1oG7H/w0=;
        b=q9VswdRgvfkX1blgXVMorXC4fTIlboTVLan/GtlKwDiL5x+CsuxjtdQTt4tE9Gg7ur
         rEz+Ynej0D7aBCbdjLi4XPaUnS94BB0pdBkKWIh4NRshW/w0I97DhlfTSj0JmtNNlZqo
         4/PC6Ma37vXUstX4gwEmqc2Z/iWz/QAFZo5/BY+rXpI4XlPHiMMDODoE9B9nH/M6WDXI
         c/LCeZu/8wz1sBMQ/TaOapaYMR4sjGm3tSdtsTawxCZ8ZgZEf9zvPgX4H4FGqTwrOWqJ
         Kccs4FeIdb9VCZexbqSrEqEBDvCZ4gvM935yQnadV2ha50lRcBeRJYrn/x87W93AuZTE
         /2NA==
X-Gm-Message-State: AOJu0YwPpn3atXutG8t4lSikZIq6lHVt+aGNi/Nzvb3FMWZy3uYi0QYw
	FpPhHkADqHQzOoImYSObd7vjltJZbCYFiflYtQFsVTbG7t4F6sxdxRs9sL7myHE=
X-Google-Smtp-Source: AGHT+IHkHHyhk0Gb9OUaDCyEzCF0IBHNnNkyYks6Z2cBGoaKJv2VTHbBW1DbtaiSjRjs7OsZ7i4vgQ==
X-Received: by 2002:a05:6a20:d817:b0:1b0:1025:2f5 with SMTP id adf61e73a8af0-1b010250487mr21580687637.0.1716245531768;
        Mon, 20 May 2024 15:52:11 -0700 (PDT)
Received: from localhost ([2a09:bac5:6548:1232::1d0:55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2c41sm20244431b3a.172.2024.05.20.15.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 15:52:11 -0700 (PDT)
From: Ivan Babrou <ivan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Ivan Babrou <ivan@cloudflare.com>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Raman Shukhau <ramasha@fb.com>
Subject: [PATCH] bpftool: un-const bpf_func_info to fix it for llvm 17 and newer
Date: Mon, 20 May 2024 15:51:49 -0700
Message-ID: <20240520225149.5517-1-ivan@cloudflare.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LLVM 17 started treating const structs as constants:

* https://github.com/llvm/llvm-project/commit/0b2d5b967d98

Combined with pointer laundering via ptr_to_u64, which takes a const ptr,
but in reality treats the underlying memory as mutable, this makes clang
always pass zero to btf__type_by_id, which breaks full name resolution.

Disassembly before (LLVM 16) and after (LLVM 17):

    -    8b 75 cc                 mov    -0x34(%rbp),%esi
    -    e8 47 8d 02 00           call   3f5b0 <btf__type_by_id>
    +    31 f6                    xor    %esi,%esi
    +    e8 a9 8c 02 00           call   3f510 <btf__type_by_id>

It's a bigger project to fix this properly (and a question whether LLVM
itself should detect this), but for right now let's just fix bpftool.

For more information, see this thread in bpf mailing list:

* https://lore.kernel.org/bpf/CABWYdi0ymezpYsQsPv7qzpx2fWuTkoD1-wG1eT-9x-TSREFrQg@mail.gmail.com/T/

Fixes: b662000aff84 ("bpftool: Adding support for BTF program names")
Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
---
 tools/bpf/bpftool/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index cc6e6aae2447..6d8bbc3ec603 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -338,7 +338,7 @@ void get_prog_full_name(const struct bpf_prog_info *prog_info, int prog_fd,
 {
 	const char *prog_name = prog_info->name;
 	const struct btf_type *func_type;
-	const struct bpf_func_info finfo = {};
+	struct bpf_func_info finfo = {};
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	struct btf *prog_btf = NULL;
-- 
2.44.0


