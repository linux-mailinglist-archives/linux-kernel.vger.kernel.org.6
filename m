Return-Path: <linux-kernel+bounces-444692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9319F0B20
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44C9188B749
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3AA1DF989;
	Fri, 13 Dec 2024 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8V4rozR"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF21DF728
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089512; cv=none; b=ukTJMdknL83jOJ3VgpzMona7+i43d3m23SpTIKg5zrdrgoo6eGgyh6s+eNsvZzzlrRYWYeeU4zr8+S37Y4sxmYAVM9wEhvpT6T7S9LYB9umesVQSWAJmanCSWEN4vPx4qk1q7GxmWqlkeT4xymkasaezcIOJ2VsAKbPbW5EnQok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089512; c=relaxed/simple;
	bh=8Z+fkcLpCW50dgG3XgGbc9Y+J6ZITUqaOeKIYboitQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FI4emZ+Rt9gWg6BSjNCM3kESZYK4eJhKlnCd4ppJtwLcauLUVARQHhbs0gEWbPfHYM2s9sGsXr9q8YiXtj5O6Ef0k7G9iAWjl02r0v3fPehVJs0kvQkOTaAU9BQ8sC8W3Jil2vhv09eDbauHpOjCUPeNYGpZuN+i8LlN8Y9lD60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8V4rozR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43627bb20b5so10416405e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734089509; x=1734694309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=12jc0w/fivkkryMIJsg9WOh7az7NrRYvkDaKh8q38vk=;
        b=e8V4rozRZDQGgq2bdNP9Nlyfwa9Xh7OHavGBO4y1dBS7KWB5hmAmheJzIpiE8Va8Hy
         tThS8pUJk+855bCGr1xkxdKgL+hKir2WTVNg7Sc2SyCYixDonXpuRd6r5FlibvVngQcN
         mwy3BUdGVR30Y4FuGy/8eHAkKHR/oaiv3Zu4Zn3S5cU6OVkiFAUwpKXHM4rEfSaXRXTU
         86GA5bMq24zb1IKPkw36n/JZVcyaac3/a4mjNGebq//WyJDnr91JCxT2IheOBCBy4hkW
         ZhukrohU3vzuLVu+yHxu1pRPoUeggUG3fdP0eCFvVhA4oL/RSlYrjmhnfQpw/WhsAKda
         Ofvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734089509; x=1734694309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12jc0w/fivkkryMIJsg9WOh7az7NrRYvkDaKh8q38vk=;
        b=gZZgW9soxzo6AYXGOt6jQ543S6fBLecNpYZGxE0B3YWucpfBoCXPjrinUtpzeIpu2F
         JpRaQ1m2ehLW1EyY+1ouz8E3utG4Gir8Q8GHfoIFex2MMgu9Xu9GIrF/i/6wKeIZmsYl
         llsQKwr6O6la4AMGn3sC+O8Z1jAMalwiW3bN2W/p8ip5vb52Vk5MhOQHjuOjMliWOQDI
         l47EVgQMITF+32na7Yf9J5jWdYtVnK0wI8huq2ewOPgs13EQbY/X+GPyn+80PdbZgaOa
         B7j2hx/G4V0pUZFRcIgkPmdU+QCXeLzCdaOqUBmY9FnkNkYEuYoNds2NcqeFBnZZXnBC
         RpQA==
X-Gm-Message-State: AOJu0YyL6+GPeZP7xHWUn3gzovFTqSoFeEwcmmX0h75hqQNLk3Stc2yO
	+QdPrNl04DwLNgqcVEQLQoNToDaSjAQ26qnYymxjjganAYUjUpqzdIr+Yr4dpDBpoJbrWPs4eDX
	LeeLQV85Ljg==
X-Google-Smtp-Source: AGHT+IEZ4eA8bhHHA8R9uWIaOs6w9kxA+a6SSCc9PyYcjPq9AgHQF76/B6v8e4W1chnsdD7KewFoDA8hfeL33Q==
X-Received: from wmbdx22.prod.google.com ([2002:a05:600c:63d6:b0:436:3ea:c491])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a14:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-4362aa3bcdcmr19895245e9.14.1734089508870;
 Fri, 13 Dec 2024 03:31:48 -0800 (PST)
Date: Fri, 13 Dec 2024 11:31:31 +0000
In-Reply-To: <20241213-objtool-strict-v1-0-fd388f9d971f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213-objtool-strict-v1-0-fd388f9d971f@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20241213-objtool-strict-v1-2-fd388f9d971f@google.com>
Subject: [PATCH 2/2] kbuild: Add option to fail build on vmlinux objtool issues
From: Brendan Jackman <jackmanb@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

NOINSTR_VALIDATION is pretty helpful for detecting bugs, I would like
my build to fail when those bugs arise.

If we wanted to we could enable this for individual warnings, it seems
unlikely there's a use-case for that though. So for now I've just added
a global setting for vmlinux.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 lib/Kconfig.debug          | 11 +++++++++++
 scripts/Makefile.vmlinux_o |  1 +
 2 files changed, 12 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f3d72370587936fa373129cc9b246f15dac907be..b1f0f8c83b050d4112428e0d8dece059ebf8dcd2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -563,6 +563,17 @@ config NOINSTR_VALIDATION
 	select OBJTOOL
 	default y
 
+config VMLINUX_OBJTOOL_STRICT
+	bool "Strict objtool on vmlinux"
+	default n
+	# Conditions when we run objtool on vmlinux
+	depends on NOINSTR_VALIDATION || LTO_CLANG || X86_KERNEL_IBT
+	help
+	  Fail the build when objtool produces warnings on vmlinux.
+
+	  By default, objtool just prints warnings to the terminal without
+	  causing a build failure. This config changes that for vmlinux.
+
 config VMLINUX_MAP
 	bool "Generate vmlinux.map file when linking"
 	depends on EXPERT
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 0b6e2ebf60dc1bb69d9651d5b7858ccd296e92dd..97b6b262d482e0bac1a4d74f9a2e7b1867b6ee00 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -39,6 +39,7 @@ vmlinux-objtool-args-$(delay-objtool)			+= $(objtool-args-y)
 vmlinux-objtool-args-$(CONFIG_GCOV_KERNEL)		+= --no-unreachable
 vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr \
 							   $(if $(or $(CONFIG_MITIGATION_UNRET_ENTRY),$(CONFIG_MITIGATION_SRSO)), --unret)
+vmlinux-objtool-args-$(CONFIG_VMLINUX_OBJTOOL_STRICT)	+= --fail-on-warn
 
 objtool-args = $(vmlinux-objtool-args-y) --link
 

-- 
2.47.1.613.gc27f4b7a9f-goog


