Return-Path: <linux-kernel+bounces-185643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711BA8CB855
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EC01C20B57
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127F215D5B9;
	Wed, 22 May 2024 01:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIMg1EtA"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0952F15D5CF
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339765; cv=none; b=ryug6ykKkogv8UMwdZgcmz1c/kJxL2gbeRoF6JIZboh9GOBlPOV4Ja/oa/8NO6P/wUlImc7tzjqPMBGtQLqyzNcGJ5IXNDfop87jIDvrgI8JMcY35rJtKe6feup3VsLPwrZMtPr6p1VdhbKusY0ZlCnQcLKih7wdGOY9kifENek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339765; c=relaxed/simple;
	bh=6W30WIKhE96pwmtcuV2NfxhpFW0veZZZU83PwcF+fM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XA0ZcFYmR8OERQcJ4WqowX5sVCJO2dGlVoVFmGts18B9MogHX38RJZ1AoirLZccm4Yttk84x5rcCVwncmJLjvgbwJi0lb8OuKEN0xjUeJrgJ7kYcJF9xcfR+fcHBKvOKbD3FQ0f9IpkHX+/11nuA933T6jnGvockjoIwebGC8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIMg1EtA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f44b2e0bf2so12433855b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339763; x=1716944563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FDddXI/rz5Uh/0hxgnIVyZ6+81rNdMnfIsgCLtRcH+A=;
        b=PIMg1EtATWDnwfr31/oDxOZL4KodTbq3ps6C5BR2hXeKBEGJSNlZyIe2/ibUBHWliB
         N0fu43mmrb1weOkXFLzXFH/ovQYis5dnzc505OxAOhfmlKmdov3tbRjnX7dCr5zatrNH
         dy3g8gYqiW/SlazGKNy2TtKZ68s/pK0ZBh3ucTAeYedjvUehxCpyu84WtjCcgfTcno+J
         zm/IHKFiXZqedKEd046owtFolCwdCNz3+u2lW4pkp+Bxm+Co3s/R79oIV9RPluVwLzFe
         OyOqs9NeYYV0XXZc7OZuFy/JPk8WKUVkIHy4dPiHrH4aun02GYwJuxCKyLgx37elfU7B
         hrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339763; x=1716944563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDddXI/rz5Uh/0hxgnIVyZ6+81rNdMnfIsgCLtRcH+A=;
        b=WiopYKsmGWBQtxPkWEikNeAmW1YIukyUUO7vYk2GH6OU61pplbKPXIAKBEzU4JAu7t
         VHk/lmvUnmz9IJCT7AmYGxNTmWprvgqP31yTBK4T29eIOHoVgIlabv0+x2ThK+XyHoNr
         enJZGIJohkpTuHxlBD2WdAok4XmomC3PdZlEgEsYkQ8M8HShrMWuKek4NQzMYeoFgtX7
         g+iYuzdoQVf+LG1WF4XCEhBK0vBZ80OvKh1U10qHvHcoNeSHZVii22zzUzIBGLpgD/Mq
         0UAEtEQ6HNMUqBTgw+XqOrjv2WWdCSaqjmxzJkJsWMeg+XkbaF7mBhvPEc5OUH04OxHo
         xppw==
X-Gm-Message-State: AOJu0Yw1H1TDR5O3DVopz+Vc/0XWFnZaNTRKV/t91wkIavdsKjA8CHo4
	QQZZCaCKxOlBfdp5W4hJUl0XFQ/A59ncEKXOz/GP66ffnM8voARIo+B6jaP2PfK9m7Yf5QYBlqT
	N6A==
X-Google-Smtp-Source: AGHT+IH8wpGwaawCict9Ep4Ub644GN8fYtHlm1t7v7pZuightlDMU0GhBoDAJQNtreKGztGUsjMmh0JORdc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3a18:b0:6f4:133:f5a5 with SMTP id
 d2e1a72fcca58-6f6d645c526mr21783b3a.4.1716339763429; Tue, 21 May 2024
 18:02:43 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:53 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-68-edliaw@google.com>
Subject: [PATCH v5 67/68] selftests/x86: Append to CFLAGS in Makefile
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

Instead of overwriting the CFLAGS that is imported from lib.mk, append
to it instead.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 0b872c0a42d2..3395a5d114c2 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -35,7 +35,7 @@ BINARIES_64 := $(TARGETS_C_64BIT_ALL:%=%_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
-CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
+CFLAGS += -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
 
 # call32_from_64 in thunks.S uses absolute addresses.
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)
-- 
2.45.1.288.g0e0cd299f1-goog


