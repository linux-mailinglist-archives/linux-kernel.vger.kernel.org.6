Return-Path: <linux-kernel+bounces-425357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AB19DC0F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AD51641DA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A28175D47;
	Fri, 29 Nov 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VCHhrI4j"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB0516E863
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732870853; cv=none; b=qRLfNv97o2uNGcniGGALNZ1DfWd6CWll0VboafpWrauBP44xNkzvfTch3MIw5eFMqPKRUG/3s9LQ5/ulW8gTOHTecpJPMtj44Cjy9V40e1YSeBE8z6ttIKdPYk3XdfiIpYyuk/aiD9fHiVNXKOdRvcvqE57Hd7skRR+P14yMOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732870853; c=relaxed/simple;
	bh=xEslxxsKiLFjjUwGtii3ivKf92ut0unGtMTc00chBhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fYAvxASIlxffcCY5RDGUGSudOs0+mkRm4UXiuDMs3p4pz2Opo5Rhvxsstfz9Q50TPumOdFJWjxoVLMOVZmtOtvjBfYzd25MgKCsM9RDUDl3XSNsfOV4e/a+wSLB1xnS4jTnQb3v29g6r0p5wWmEa8o64s983BMMwLPca90Pr1vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VCHhrI4j; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d0bcd51932so251918a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732870849; x=1733475649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AM59VOGYG3wMVgUo99G/iJLAIksKG+8729FKlv13tNI=;
        b=VCHhrI4jQUAULt0SFnU/cQeuVGY/zn4FwyQ9RUX/F7+XerRIszkBul6k7NDETe1ojE
         if9Ya0A3Ezt6QDuRLf2iZ25VomwVKZJ7tKkIAfsBZss86ue3786MvLpNndMM5gw3LKQ2
         8XOUn36Lgy5u86L9EGD+iBiWi4PuYUiCFH88BByf0UY9OQ2aGObMX7iRTwftuq7Pzw46
         9cy5TUtrSnv6V+82DkEPPWJgcvpAdjC8tZsy/Oogw9RGqGhOHfMLFziv1fJst1I+1J1v
         nU5KUF0qd/gAWUUfMdhLDnI/OJFa4l81AvETdG+t9n8ihdcMeJqRysZb2rdVQws0ceKu
         lgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732870849; x=1733475649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AM59VOGYG3wMVgUo99G/iJLAIksKG+8729FKlv13tNI=;
        b=xCoxJ7ZX9NzFn/4ryKySdyhbdPGuXEvPppaMfO5xn1GN6GreirkRVMPu6aSQatN9Zp
         zWQFRgeio2dcF7IkFpiC+oq30LmUgsgX2XZRLRECGn9RP8b1l/nmmfEamoQBSKi4wanD
         Ds3SPLc+yW1WMkq0DeNAPNB0UjomuXFJu5b1DSbMcuJJ+GkwtVfWvgbRuJ+UYbXrKgK8
         voTdYgl1w9HGSdDGnGWRyrqZnjPhiG3PJJmjmiux4148i8TGUXN3UBBi708/cvNDIDDH
         pjcvf8KXhrQg41QZrJXXFXmGL+8w8SVrbsvXtq+JTHIgZZZRSOErZvC0HyydNUJgtI8h
         enbA==
X-Forwarded-Encrypted: i=1; AJvYcCXpDOcM4k9qNaXiX11yHCGYvN2IoftN7SbqVivj9GiBffybV3RuhBWzEN87suPFC1I3ntb3V92Yidac25o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu3q+fhOLJi/2+ViGPumGVro+ljwf+wDJSRWcXhqHSHEe93S3+
	sq6OBWGcmfnuUBzjiOKa5ngpWtGTftyMji1gPJQ1DpVXmxooFyVyi1pKJowuYDoGO1X2YMlFDQ=
	=
X-Google-Smtp-Source: AGHT+IGHXhcpcjgkHjA0k7hYdLh0VcYJ721uO/6wKXB9uB8gEZqYP0S/2HCU0HVINTTx/wAZ9JlKx76g5w==
X-Received: from ejca24.prod.google.com ([2002:a17:906:3698:b0:aa5:2ede:53bf])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:d513:b0:aa5:199f:2bf2
 with SMTP id a640c23a62f3a-aa580f56baamr1006472966b.29.1732870848742; Fri, 29
 Nov 2024 01:00:48 -0800 (PST)
Date: Fri, 29 Nov 2024 09:59:34 +0100
In-Reply-To: <20241129090040.2690691-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241129090040.2690691-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241129090040.2690691-2-elver@google.com>
Subject: [PATCH bpf-next v4 2/2] bpf: Refactor bpf_tracing_func_proto() and
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
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
v4:
* Call bpf_base_func_proto() before bpf_token_capable() (no protos after
  should override bpf_base_func_proto() protos), so we can avoid
  indenting the switch-block after bpf_token_capable() (suggested by Alexei).

v3:
* Fix where bpf_base_func_proto() is called - it needs to be last,
  because we may override protos (as is e.g. done for
  BPF_FUNC_get_smp_processor_id).

v2:
* New patch.
---
 kernel/trace/bpf_trace.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0ab56af2e298..b07d8067aa6e 100644
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
 
@@ -1417,6 +1409,8 @@ late_initcall(bpf_key_sig_kfuncs_init);
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
 	switch (func_id) {
 	case BPF_FUNC_map_lookup_elem:
 		return &bpf_map_lookup_elem_proto;
@@ -1458,9 +1452,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_perf_event_read_proto;
 	case BPF_FUNC_get_prandom_u32:
 		return &bpf_get_prandom_u32_proto;
-	case BPF_FUNC_probe_write_user:
-		return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
-		       NULL : bpf_get_probe_write_proto();
 	case BPF_FUNC_probe_read_user:
 		return &bpf_probe_read_user_proto;
 	case BPF_FUNC_probe_read_kernel:
@@ -1539,7 +1530,22 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
 	default:
-		return bpf_base_func_proto(func_id, prog);
+		break;
+	}
+
+	func_proto = bpf_base_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
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


