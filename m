Return-Path: <linux-kernel+bounces-443117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 849959EE788
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDE0282AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AB1213E97;
	Thu, 12 Dec 2024 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1bW2rhya"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240BB20E6F5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734009169; cv=none; b=H5bFeNKOBkXtJtI1H/aVleemGaO2MPgH180IY3h8PAvMKy3T8Q2Vye8+M5d5urVCSzyNG+gRWP+hfESC9AvaTDlSSOZIA+AteeSMm1b2+DGPDGuxtSPXdrXYyeiPSdjYVR7CLYDqd3Ulf7v9ZLgxmneUrubsAiCqRT+1EcXQ7KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734009169; c=relaxed/simple;
	bh=pPPWX8Ivwy/gV0ty75BIy0qQGhmfgM1RmE/XDdVKt8U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IlUqgmY0+UqdkzT7y+a/CeS1SbufHVJ4rZP41v6GCpF9dqi30FGce6/S+kgPWYXySR/3kckVj3s95JjjBg3rbf2x2Is0R3hDMhxTAuZOosqtafo//8f9Oy9CkDemfq+rywLpP4RU19R7o+Ot3t6BnCV1TixqySItYByYY4F011w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1bW2rhya; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-436228ebc5eso3707475e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 05:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734009166; x=1734613966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NxSuGPEUP4LGoJOZXmNeFLCDtdbxnqDmxNJo3hcCyNU=;
        b=1bW2rhyaLQJcZvinBZBocgLtwNUd3DgBFVZO72qi3sDmF+0hE8pZ9yz+65hOrzIhZ5
         rRQd5GEPsjspa7ayuE4xbuntAaKocs1waTZTQqwlOMImyYgG5sMucR2xndcMYp43dMb4
         8YbISEFnucMNIdwDBVBtCSTj6tg1pVfUE5m0mYaHhdaACwmGnzCivZGkpgVTEOjlwF0w
         X1oypEfoBqokb+W7ii1TNbQQ5BvdMlVRgjDUK3ixpaYc8sfI676ltMCFLFPTQm58E8wm
         XwhOliyDpBjy0MlC/5I6vASXg8q7+0yxvjL07iXtBwTzUXW/Rg88Klk7VL92DnquEdTG
         iLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734009166; x=1734613966;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NxSuGPEUP4LGoJOZXmNeFLCDtdbxnqDmxNJo3hcCyNU=;
        b=GE9Y3E6V3holUUy4k5FUpr/E/naRO37cp969SZZU8pb4yo3z0Zxel8ngRG5ONWDffk
         THeY1wFcboFsZThWIFCEajst06/iA+VhDBuOSQD1JK11ZvDIsPCsgAGNfhaHCODXqbri
         XwM1bYaQvLTE0OBqFG8GYx830BbMK89L5/Yg7Iu2bKI0A157x0iE7PpIDwm9Km3HzI5P
         DGa7akE58yVJPFXL/Aoa+6Gt2MposqzYgGi8OXU6gJ4cSwxrm+OFr6V6Cd+8Gr9Cfy7U
         XUNEO289cIq6YBhgtL8qQygs5FaITcOICqe1Qv2nlq0Ft9/sNX5F0mqoCvW/brGXUUvU
         +XnQ==
X-Gm-Message-State: AOJu0Yx/T5KG2PwR8tt7kz6dz42OME0v2oX4sX6qNfQ4CTjezbINpjaK
	KUq/lvk425dr8bViVv3lm3TUoX4tdIswcELDuVuK9oqi/yYp1tXzNwj8JtsuDI0Mv1j69PZqjp8
	tskLDxZFPyvba1g==
X-Google-Smtp-Source: AGHT+IH7UrSbTZN32BOx/05eHD1pdfafDslL/a9FKykKJ3ljqCd1tCecl999iQwnPEAm1PM6/DHtB7MRoBx7ReQ=
X-Received: from wmpe39.prod.google.com ([2002:a05:600c:4ba7:b0:42c:bfc2:aa72])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83c9:b0:434:f270:a513 with SMTP id 5b1f17b1804b1-4361c4011d4mr50051315e9.29.1734009166642;
 Thu, 12 Dec 2024 05:12:46 -0800 (PST)
Date: Thu, 12 Dec 2024 13:12:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3030; i=aliceryhl@google.com;
 h=from:subject; bh=pPPWX8Ivwy/gV0ty75BIy0qQGhmfgM1RmE/XDdVKt8U=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnWuB6x0lQJd/Xt6RpUUS60L1VWB5rtefkWy4Qx
 x7GTJ1d9fqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ1rgegAKCRAEWL7uWMY5
 RlDlEACJpkq1ieFKxKefZcE02/A6D2POl4XhDtXPCUbRv0LwB1npNJPz1adDpL5XnZRjCUHtjm9
 AmB3qS3xEJ0g+qBQ5s8p8ndri8gROxUdNQ9YMKf6dZer9a05hWrwUUYf5MNMjCiNdlZR+paZyOF
 941DkiaIBBdRyg+rZvyJYadqjYhYMcK439Aj7YFyelyCSl+k+jr9WH96NAIlnQIg377Ys4uu8Br
 5MYeie8SSjOtDfOi/vFfLZ2q9fzTVmQspQm6zXbR7TrKn41tHpL0lypfW35HY0WOxAHbwAyL569
 MByT8GZ76KL/p8Tmi2tJghvnaHEPGMzbJALdz1JFNShutatc6AAEiGCmxkC0omPsuSNxX2GMlmV
 L+trhDeql+LHVcoD31X8s/eF8rwIwEik+yPQtBHci5IZgQ/G5kX7tfXu4FuTINY7T9h6TIxvAuV
 nk9zA7p7/rckaVXtRFYVnxZlCUE83omOoCoGh+l9y+MeNxQzrRaHldBHfaRFRlW2aMIanTBeuFR
 lszvgSG4FthjEAbydv+bohXhRZJ+IT99/qfj7hzbIueUAkYwgXSaZwCqgZXTSonlzUrCYlXAd0H
 YaqRK8InTyUVMD1tmua/iC84JMly4iwzBOfLNSGDbpuydVzkHQNj89x675oV+yWbHzGypr1jmKE +snT2nC7oVzpT6w==
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212131237.1988409-1-aliceryhl@google.com>
Subject: [PATCH] tracepoint: reduce duplication of __DO_TRACE_CALL
From: Alice Ryhl <aliceryhl@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

The logic for invoking __DO_TRACE_CALL was extracted to a static inline
function called __rust_do_trace_##name so that Rust can call it
directly. This logic does not include the static branch, to avoid a
function call when the tracepoint is disabled.

Since the C code needs to perform the same logic after checking the
static key, this logic is currently duplicated. Thus, remove this
duplication by having C call the static inline function too.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/tracepoint.h | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 76d9055b2cff..a351763e6965 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -218,7 +218,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DEFINE_RUST_DO_TRACE(name, proto, args)			\
 	notrace void rust_do_trace_##name(proto)			\
 	{								\
-		__rust_do_trace_##name(args);				\
+		__do_trace_##name(args);				\
 	}
 
 /*
@@ -268,41 +268,35 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
-	static inline void __rust_do_trace_##name(proto)		\
+	static inline void __do_trace_##name(proto)			\
 	{								\
 		if (cond) {						\
 			guard(preempt_notrace)();			\
 			__DO_TRACE_CALL(name, TP_ARGS(args));		\
 		}							\
 	}								\
 	static inline void trace_##name(proto)				\
 	{								\
-		if (static_branch_unlikely(&__tracepoint_##name.key)) { \
-			if (cond) {					\
-				guard(preempt_notrace)();		\
-				__DO_TRACE_CALL(name, TP_ARGS(args));	\
-			}						\
-		}							\
+		if (static_branch_unlikely(&__tracepoint_##name.key))	\
+			__do_trace_##name(args);			\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
 	}
 
 #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
-	static inline void __rust_do_trace_##name(proto)		\
+	static inline void __do_trace_##name(proto)			\
 	{								\
 		guard(rcu_tasks_trace)();				\
 		__DO_TRACE_CALL(name, TP_ARGS(args));			\
 	}								\
 	static inline void trace_##name(proto)				\
 	{								\
 		might_fault();						\
-		if (static_branch_unlikely(&__tracepoint_##name.key)) {	\
-			guard(rcu_tasks_trace)();			\
-			__DO_TRACE_CALL(name, TP_ARGS(args));		\
-		}							\
+		if (static_branch_unlikely(&__tracepoint_##name.key))	\
+			__do_trace_##name(args);			\
 		if (IS_ENABLED(CONFIG_LOCKDEP)) {			\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\

base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.47.0.338.g60cca15819-goog


