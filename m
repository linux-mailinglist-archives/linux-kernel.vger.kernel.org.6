Return-Path: <linux-kernel+bounces-316377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9813F96CEC0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0081C228D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0B8189518;
	Thu,  5 Sep 2024 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sv9qAjDH"
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940414F9CF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725515568; cv=none; b=aHMF+aeJeDiSJQteWBKLuCQG7nGsS+Bpv/eI3fv15oktAFtU5+ICDd/Y3a0Z5XU2EmJnHnFXykoOjXXDJWlmCUbITBwimgAFNWGypEsohPrDDkN9Ah6+GHRFYSkHFiUP+TDAFrYcHRRjYu5SMmDMmv6KiwDEiXu2xR6qNT74OWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725515568; c=relaxed/simple;
	bh=EJ14sOhLF8dqlqHR5/S5KsDVVFZ7Uf+ffgtsitGZDYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1SGclZZI2YOJqEXK/0sG3GhUYTLngfOE29cuW0nuNiqK+bibQpxznBo4CARS9GzqessVJTYwC7fqJFXdYkHUUwv1jq4pDC/0hwnESnKFPmQyzwPPZKmU6R3KBvQYq0rsYr7vsMgYNzvmfQ0XaSNWli3DnLKNaY6ox7JJxPfimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sv9qAjDH; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-374ca65cafdso148170f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 22:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725515565; x=1726120365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hjf8mtcnI/VkGNM4WcDRLxoMkosopxI2lQGXBy19+Pw=;
        b=Sv9qAjDHFavdkYQMrMTKd+BAtcjRD23PHqNEyAxhSkqaqtMRKDir8zwREjr3qoj4lg
         2RuuPaD6dWphNKZ5BwZhqezuMOoGhQ7LiWPCOxc5v/YI25GYoegDCCHuuBnAHiXb4QW1
         4GIcDl5Mi1LqmMU/bOPSnm4Zdhe9ChbF9WdWBWntcXWOCcxigakc7GtgKT7wSuwJwZPh
         q+ZIqat+0IhgFKBqghCBUNZu+Bpw+AVWKNJrr5mNxh32DjxJ57LgM19iwByAEDdI5nZC
         i5iyIF/2O7KTNiIAUOeIChi+Z5MrjSeHODsGtI1Yg/whm7rpRrGEfMrEDgJf3CbbFsO4
         th1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725515565; x=1726120365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hjf8mtcnI/VkGNM4WcDRLxoMkosopxI2lQGXBy19+Pw=;
        b=GgQnpM3+dIiTPJXOtq8eRle9iOwERKoam+3/8Y1wJ7KjGV6I+Ag+Iy5OB/bdMvdrDq
         pIDlHSAIO5EwNwpE7XKg0WnidQcN2Wk59iWpNn84yokK51qmw4kmGv9snXDYIg5gdvZm
         WyKBMyg8/iBlIQspur7ygpIXTo+2mEUkf6GWeiWKaMCHIlpLRWmGao2fsumDwTOAl1/S
         xLmBFpqB2Za9uNiBleHAeyGiPFZl/74QOYBCF2tR0BpC8yb6sgjiWYo/zYQWkVXX7FMO
         JDE9BFdIhFxrbwuj65Fh0ppxsM6BlhXTK/GBtf2Fn00R5XtFAIiuRZDIXBE+ir4AJljC
         L+ow==
X-Forwarded-Encrypted: i=1; AJvYcCVOwpRhYRQM8L61NKSWO35dGmaoaeLQHXX7U5aGEM3w0Z6T/NGy+rjlmLf9KiQTtrH82c4xRPTA3k7OSp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ85cZsGld//Z6q/NWqQOh1NHYKvx2ApgR4X/rBC1/Z0JyBJwp
	G2JME9vjtCLr50UF3taFEXtuNnVu5tbEVw9I+xwHGFv3rdrAay8EYatJrbxZ+Po=
X-Google-Smtp-Source: AGHT+IG1SWr/hH8fDwc2lTHFSC7khyXM197qaW9qea5dTMGILPk5Z4cjIsiuD9Zgz8SQL2bOy/5LAg==
X-Received: by 2002:a5d:46ca:0:b0:374:c95e:1636 with SMTP id ffacd0b85a97d-374c95e17a1mr7580681f8f.21.1725515564903;
        Wed, 04 Sep 2024 22:52:44 -0700 (PDT)
Received: from localhost (39-9-193-138.adsl.fetnet.net. [39.9.193.138])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2e17636sm3413678173.74.2024.09.04.22.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 22:52:44 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Vernet <void@manifault.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] bpf: use type_may_be_null() helper for nullable-param check
Date: Thu,  5 Sep 2024 13:52:32 +0800
Message-ID: <20240905055233.70203-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 980ca8ceeae6 ("bpf: check bpf_dummy_struct_ops program params for
test runs") does bitwise AND between reg_type and PTR_MAYBE_NULL, which
is correct, but due to type difference the compiler complains:

  net/bpf/bpf_dummy_struct_ops.c:118:31: warning: bitwise operation between different enumeration types ('const enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    118 |                 if (info && (info->reg_type & PTR_MAYBE_NULL))
        |                              ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~

Workaround the warning by moving the type_may_be_null() helper from
verifier.c into bpf_verifier.h, and reuse it here to check whether param
is nullable.

Fixes: 980ca8ceeae6 ("bpf: check bpf_dummy_struct_ops program params for test runs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404241956.HEiRYwWq-lkp@intel.com/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Due to kernel test bot not setting the correct email header
(reported[1]) Eduard probably never saw the report about the warning
(nor did it show up on Patchwork).

1: https://github.com/intel/lkp-tests/issues/383
---
 include/linux/bpf_verifier.h   | 5 +++++
 kernel/bpf/verifier.c          | 5 -----
 net/bpf/bpf_dummy_struct_ops.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 8458632824a4..4513372c5bc8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -927,6 +927,11 @@ static inline bool type_is_sk_pointer(enum bpf_reg_type type)
 		type == PTR_TO_XDP_SOCK;
 }
 
+static inline bool type_may_be_null(u32 type)
+{
+	return type & PTR_MAYBE_NULL;
+}
+
 static inline void mark_reg_scratched(struct bpf_verifier_env *env, u32 regno)
 {
 	env->scratched_regs |= 1U << regno;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b806afeba212..53d0556fbbf3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -383,11 +383,6 @@ static void verbose_invalid_scalar(struct bpf_verifier_env *env,
 	verbose(env, " should have been in [%d, %d]\n", range.minval, range.maxval);
 }
 
-static bool type_may_be_null(u32 type)
-{
-	return type & PTR_MAYBE_NULL;
-}
-
 static bool reg_not_null(const struct bpf_reg_state *reg)
 {
 	enum bpf_reg_type type;
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 3ea52b05adfb..f71f67c6896b 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -115,7 +115,7 @@ static int check_test_run_args(struct bpf_prog *prog, struct bpf_dummy_ops_test_
 
 		offset = btf_ctx_arg_offset(bpf_dummy_ops_btf, func_proto, arg_no);
 		info = find_ctx_arg_info(prog->aux, offset);
-		if (info && (info->reg_type & PTR_MAYBE_NULL))
+		if (info && type_may_be_null(info->reg_type))
 			continue;
 
 		return -EINVAL;
-- 
2.46.0


