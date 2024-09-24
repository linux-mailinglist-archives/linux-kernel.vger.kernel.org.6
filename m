Return-Path: <linux-kernel+bounces-337629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA34C984CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5461C22FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CA6146A6B;
	Tue, 24 Sep 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1vW9r/wY"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA5C13E043
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212835; cv=none; b=mY/1JyF2dYoeHg2EskEuXI2UkZ+2QNl7n1eda/xhEMrY+k+eGSb2vGekhkdJk3wnUXfm9o+lPBosOKwD9OQASjIzFZCBeI4gbR9YT88HM/Ys0OSDojBReeWW/I0iKoe+umn1jrgWYg2Znw+UDqfkEufEa/JGny11gHS1Re50eg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212835; c=relaxed/simple;
	bh=87UiLghCgImjI67qGqkZVlUAdkIatHILzWkWX7E7o4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZWtrLHBOZvbSdBZpgrXJuM3eSxVgaQHaJ4LydoBHENbxImgpdy9/y7tB2yZgijWMLa3K+39yWEoD7P6epB4I1CS5mh6WWglTlTZdGmf/B1yqCMSm18tt+XWcpSmpGIeutmA6YHUTWYQuqM23vwqF3pXwPukCMbERdQLtwQ3kx2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1vW9r/wY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d4f52a4069so106304467b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727212833; x=1727817633; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LyxbaKZI7M7/7zXNo9r/7MnbWQPTGkdTyXhoBixsIfc=;
        b=1vW9r/wY5pMgV+iETKeCJpYBeVh/xxtd+97mXm+W8IkHfkJh59ByIPFs4ATtDqdws9
         TvxRvEOaihdlpzI4Og8q2QbW0YHwbdBXEwOdOPqHjnnGB1ExZjCwLLOF86YwgIXLiARv
         iUmY8WeBhH0l+2zxHoMlbFhZVEiC+nTKd2t72+Id4nkQC+t69iu1U2a5bUiTbG5nmwmQ
         y5lLO/uUOeghXFHCigzwssO/hKThGX+4esGF5X9Ve3rpxm5ZSsxAIbkIAMfwQ9a/4EpH
         /vTmgmkQL+63RJ18JqX4mzWbfPpSjJaaBIdCV22wvYu4B38aCc6ve72grdcUb8lyjaH6
         a/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727212833; x=1727817633;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyxbaKZI7M7/7zXNo9r/7MnbWQPTGkdTyXhoBixsIfc=;
        b=UD42cHK3KEgpEDZq3CfGxUmHtbfnjAVUv5orGMYSMCEpaSwYU0mwmh7CV+E49AQIdG
         0eFej9JJzKb8WChUubGqQIqYft6NjrKL/m7kG89Jn9DOVNMzhJPL0thTTBCkuaxu4VKS
         bxKaGA2iSIXU2amTyTR5vnwTJMdP3PddTw/v09XZx1wVWt0WYNQQkEi7IVRjeJybvT9Z
         iBlPaMImi3Wp2p1xQ5vBgRngFtyqz8FVbR9QlrKexZ04TQ+D22F6cQNNgc/q1IGRpran
         Li2UgWmeIB9xrCmxnMIeGRctiJiQ9Txvx/P/xBEXGtrJRNd8XRgtUPzXQvyvYdxMfiQa
         voEA==
X-Forwarded-Encrypted: i=1; AJvYcCUqPh4j2xGvrrklXwlL7+MofABl2eD3+wrcZ3QxmGtjVbaKQsMyWwFVsLc2jGBgO7KEUCk3Kwkgz+cGdXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBDkwf1FEH6MFzB1ubTGyrRcAyS2yu6H44Evglyvx8/z2w6vUB
	FNhDRMrfyxpZYZSLSNtiQh1aoTxR6dx1y3EFc9UVqhDfziEVNb1PCwSvfcGlD4gZ1rEM2xX8BHr
	cwBVg8w==
X-Google-Smtp-Source: AGHT+IGnyEMTRWI7sNtJtp7R9rDDC+Gbb0gxLeam+VvQbZl9PF/2aqJWci9nw+JctbXxlWMfU5L+JyyiNb9f
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:4289:b0:64a:e220:bfb5 with SMTP
 id 00721157ae682-6e21d8373e9mr83647b3.1.1727212833007; Tue, 24 Sep 2024
 14:20:33 -0700 (PDT)
Date: Tue, 24 Sep 2024 21:19:43 +0000
In-Reply-To: <20240924212024.540574-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924212024.540574-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240924212024.540574-2-mmaurer@google.com>
Subject: [PATCH v4 01/16] module: Take const arg in validate_section_offset
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

`validate_section_offset` doesn't modify the info passed in. Make this
clear by adjusting the type signature.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 49b9bca9de12..1a2dd52147ba 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1645,7 +1645,7 @@ bool __weak module_exit_section(const char *name)
 	return strstarts(name, ".exit");
 }
 
-static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
+static int validate_section_offset(const struct load_info *info, Elf_Shdr *shdr)
 {
 #if defined(CONFIG_64BIT)
 	unsigned long long secend;
-- 
2.46.1.824.gd892dcdcdd-goog


