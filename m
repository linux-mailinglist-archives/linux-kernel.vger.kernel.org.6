Return-Path: <linux-kernel+bounces-423383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EBA9DA695
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F312164B31
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C641EE038;
	Wed, 27 Nov 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qM4RhDWO"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10391EE023
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705832; cv=none; b=rr/gIXx/BPSYPBTADTKywZ0gD9ObJn8N39U+ee60VanFJZTa6M24lWpcEbDy9J+Ngh1q20ttMRyovtNMqy9qqyjxHdmnACBeF+P+QGm+X/mghtQCeEud5Smre2PN9I9SfJd4bXVfx6rEX89UvblLUFfWq3rBrRkO0pCJItqshC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705832; c=relaxed/simple;
	bh=n6SFQlgQ89x+UN3cScyPqDrPZQIK8ftr0Y2vU2LxfCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ReHXQNepflYWxdQ02LNF8d3DcmzCkqXkW1q71Q8WEtxmM9wTKoylT1u4yGglTjU9ZqzkDXq555loDnS4+usluheGDm/0GFHq+sprly7bS1JQmPZ5hDJVAxriuj/JfLVJbWVq8Q5uOpEBWyle17CU5pYYyRZVooBlWxKyxChzRhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qM4RhDWO; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa53fe66a10so130931066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732705829; x=1733310629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R16rjOQpVflGeOoJdXs8xt/CprClomxX6VQzmlYl7Q8=;
        b=qM4RhDWOt44e4KZ9HnAFNjGT5OvWBDGwksE6v/6n4UxpfwoEQDw32WlimyAQF77g3U
         mu/k5RBsNcBRbPy3Q7mZHrWUahbhduwTZ92/daKd8dFO58wZscvSsyWvmCjcuRURcjdy
         GtY+Qv6a10mv9kf7nKvWOoOHI0kn5Xm//prxWzemIi1CbNHa5M0TVbwW/NjMVCeN59sf
         +VyDAzu3X2+4AU054Fxi4G+6tafTAAanYBV0PufcBunBIoG2VcGrRc5iLqtJrcOMZFWd
         wWAOjJgtaHuuuE5t/TxIRwb25yEjon3ugADOLOMu99A8P693tXfft8NRLMdJ0DQiDQbI
         p2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705829; x=1733310629;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R16rjOQpVflGeOoJdXs8xt/CprClomxX6VQzmlYl7Q8=;
        b=AmGyxoq8/ygHpPOqO6fNwhLPcLpee+vG5tbz/Iea5jDLPk/L5uvgJF30PTS071FEdj
         0r9xbxsAFLej8qEx13rGCbPdzE/SGgt11+zQ8ocUpstYYAyin9ugSoDCr9en2tin5zD9
         /JA8vwZ36m8+XJFMCNPwbFac8ZFXbCcHCzgBxsr4AsMf/VkW03oM/PHFCchuvm9rPAQn
         rjHNVZBJdaHZmmv1rno0/8JojpWYV0rspNFbsfgXVaP46GOES8phakEEa3/kJQuqK9Xt
         4bdWjs0t8zxi+89YCw/4/L55REBPM/0t1Bmd0oO01pIqSHSifImmbq/1s03CejEOdsQD
         kP5g==
X-Forwarded-Encrypted: i=1; AJvYcCXNfcI4pFKgl+2pZhQDPRNXkXsy9WctrY1yVG1MbEbfDuOfL+WuTg6zRa+jL+1PxWoryEZG6wRcdvvkQXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo0N5OGZpkdRfWg67E9dcTFUaBklln0ux+ba8t3bykfiLnDTwV
	KlnjXI8SkOJd21l93jZdVf8I7TeBnEpO+eHjk7JPvZNZgSCtBs5aMzxCJTdPUWpRWlCeN5FHhg=
	=
X-Google-Smtp-Source: AGHT+IFuVotXYt+hPl929kqPNZTpS9LM+/Eywv9tUfBdOkJB00QlrJaxyYKFUm0tMShw5iE3GwobJcrbhw==
X-Received: from edbio6.prod.google.com ([2002:a05:6402:2186:b0:5cf:db39:7001])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5108:b0:5ce:d435:c26d
 with SMTP id 4fb4d7f45d1cf-5d080be7cafmr2296169a12.19.1732705829149; Wed, 27
 Nov 2024 03:10:29 -0800 (PST)
Date: Wed, 27 Nov 2024 12:10:01 +0100
In-Reply-To: <20241127111020.1738105-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241127111020.1738105-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127111020.1738105-2-elver@google.com>
Subject: [PATCH bpf-next v2 2/2] bpf: Refactor bpf_tracing_func_proto() and
 remove bpf_get_probe_write_proto()
From: Marco Elver <elver@google.com>
To: elver@google.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nikola Grcevski <nikola.grcevski@grafana.com>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With bpf_get_probe_write_proto() no longer printing a message, we can
avoid it being a special case with its own permission check.

Refactor bpf_tracing_func_proto() similar to bpf_base_func_proto() to
have a section conditional on bpf_token_capable(CAP_SYS_ADMIN), where
the proto for bpf_probe_write_user() is returned. Finally, remove the
unnecessary bpf_get_probe_write_proto().

This simplifies the code, and adding additional CAP_SYS_ADMIN-only
helpers in future avoids duplicating the same CAP_SYS_ADMIN check.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch.
---
 kernel/trace/bpf_trace.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0ab56af2e298..d312b77993dc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -357,14 +357,6 @@ static const struct bpf_func_proto bpf_probe_write_user_proto = {
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
-static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
-{
-	if (!capable(CAP_SYS_ADMIN))
-		return NULL;
-
-	return &bpf_probe_write_user_proto;
-}
-
 #define MAX_TRACE_PRINTK_VARARGS	3
 #define BPF_TRACE_PRINTK_SIZE		1024
 
@@ -1417,6 +1409,12 @@ late_initcall(bpf_key_sig_kfuncs_init);
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
+	func_proto = bpf_base_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
 	switch (func_id) {
 	case BPF_FUNC_map_lookup_elem:
 		return &bpf_map_lookup_elem_proto;
@@ -1458,9 +1456,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_perf_event_read_proto;
 	case BPF_FUNC_get_prandom_u32:
 		return &bpf_get_prandom_u32_proto;
-	case BPF_FUNC_probe_write_user:
-		return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
-		       NULL : bpf_get_probe_write_proto();
 	case BPF_FUNC_probe_read_user:
 		return &bpf_probe_read_user_proto;
 	case BPF_FUNC_probe_read_kernel:
@@ -1539,7 +1534,18 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
 	default:
-		return bpf_base_func_proto(func_id, prog);
+		break;
+	}
+
+	if (!bpf_token_capable(prog->aux->token, CAP_SYS_ADMIN))
+		return NULL;
+
+	switch (func_id) {
+	case BPF_FUNC_probe_write_user:
+		return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
+		       NULL : &bpf_probe_write_user_proto;
+	default:
+		return NULL;
 	}
 }
 
-- 
2.47.0.338.g60cca15819-goog


