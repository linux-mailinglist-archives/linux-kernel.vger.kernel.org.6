Return-Path: <linux-kernel+bounces-525870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210D6A3F6A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392593BCC6F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC81120E324;
	Fri, 21 Feb 2025 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4enJIMR3"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C3E20B1EE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146236; cv=none; b=K/s0voMnTUHU0LccHlhuiY1cbFcWbmmc7ziARoPb+pQQ0OpIpu9KXG90kLNm8gARb1N9hv2YNAmAkNUVGKeN+HeUw2gaCGI0i11eOrEEEn1Jz3X9+F+P7jJkmFD1izRkurg02LHxdbujh7ZKvS9Gmm50YDLgHdCFOO1c1dLE7Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146236; c=relaxed/simple;
	bh=xricxKMgkN3E2OkG7LX+OEc0LQM8GJ4sqDfZzKihkGs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=exbFYZaCIm5FTSwtHbOdciTp+2Y3KvwavQ3EZPT++4qtQRIXEqsxkfHrWUXbtS+Uk3x47hZJrfRrBvC/9km0xTqpKQ6gRx6V+rBg/6srwfVSSEy8z8dM/5aBRgm6kb1/WNz06vE7xv2SM1Nn71+ASBBiAwBh6zUDvCF7gYqeYp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4enJIMR3; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43935e09897so15579625e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740146232; x=1740751032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OJ38GZWcC1r02/VUwv5pKwIOZCXZORRGPK8k9CULFtU=;
        b=4enJIMR3DySTfTPJ4BQNJzcW0bu3kwvm58jShq2Oj7OWS8Kz2V6NotNUSkEkchzIdi
         hf7ADNcKH0O9s21/7snG11n1/6eHl4hcjQUqxqR3Zzkh8fvYf4Al5XUB75udMghtdFja
         n+2koDMBUvB3YBi0XwBj/G1l/+RKbClz9o5VW7pppHlIdyepoQfAOHMh/XRLYUTbN1KS
         tLU4pXmHwe47SlnKeiilylmH6t9y3Q+3kaYnWyxhvtnItQUj0WSqZU8I1iWN/aVPhlXF
         f4xZB6nINIQIcMlE7+gA5ejgqENirP7T7L9LYqAld8vX2tX9KaLB3iXELkRyQMoZ+gNF
         YV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740146232; x=1740751032;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJ38GZWcC1r02/VUwv5pKwIOZCXZORRGPK8k9CULFtU=;
        b=QWgKVSjNjXcXV8/RJvZOtt5HAHUrYFETRaVmmNrR8Lqahz4F8CQPZXGkGv6dPa/KW+
         86F67oIdXjWeeVQaWbuSqg5C71nC+vsBeOirkslGoluWiWiCBwSLfXMx//VzKxbG2eqi
         0tYYBh2/6fsZXKi13vwdE9pY7RJNikq9w1X81y71vumS3wCteGFdNYWe2rcEjIFPOxYw
         TT86ryKV/8jFmYCtzwatYQ/i/NqWS4iBKNs7yCWrky0HzOG/531XlIK0KcSjyTqjkefu
         ieEzil4AiZqwjqlAVTbqcHy7sozamDrQw59oNNfmEk97Z5nwcmt06dJ9DkfWgV7PVOEt
         9OJA==
X-Gm-Message-State: AOJu0YyjrBkkJwY13B2Yiav9ur2AmY9XzTLMKmUVWI670X3LDdp4zk5w
	DBSpU2pJesi8Qx2BUDuoayKH2Gsa9rrwAPGqy0jhO+Jiu4YFkzd9fHjvffwhFAricexIDweFIc/
	YwcaSwRUMXbXfTNZKgg3dYhf+3ffydC8JxYVRlJyQZdVGy3TKCAhEZOd471cTlzS9LTZRt3ty+d
	Bjj9iIIo5rrysL5HSbDm69+agsPlMYFw==
X-Google-Smtp-Source: AGHT+IGBIyl8Grbk+ZY2xCMGNDaQ75XJN0hc8jsYYNZ8GobXGiADiJWhQ2ni1d8+7z3w0ZGDuIlqhP+r
X-Received: from wmbes14.prod.google.com ([2002:a05:600c:810e:b0:439:975c:23e0])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4686:b0:439:8c6d:7ad9
 with SMTP id 5b1f17b1804b1-439ae225a53mr29180805e9.31.1740146231992; Fri, 21
 Feb 2025 05:57:11 -0800 (PST)
Date: Fri, 21 Feb 2025 14:57:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; i=ardb@kernel.org;
 h=from:subject; bh=O9j1IGAaI6OXvskg/0jJexoNaX3jLazAHTJ3Zr42LCg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX1Hm2Gj92zjQxdeS/qat++rrdcW3u8hV3pW9PEls96W9
 LCFDCs6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwE2uYvgfnBr9efGPaRy6V250
 vYvJZc2WUrRpMxYwyt73kjd+7kRjhn9aaSLXPI28+5Kj91ot3xwVbG1uwFUjr/dew8oqUS3wAyM A
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250221135704.431269-4-ardb+git@google.com>
Subject: [PATCH v3 0/2] Handle .data.rel.ro correctly and use it for BPF
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Huacai Chen <chenhuacai@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

LoongArch uses PIE codegen for the entire kernel, which has some
implications for how .rodata is populated and emitted into vmlinux.

Changes since v2:

- Rewrite patch titles and commit logs

Changes since v1: [0]

- Always use .data.rel.ro.c_jump_table for C jump tables
- Add Tiezhu Yang's Tested-by
- Split into two patches and rebase onto Linus's tree

[0] https://lore.kernel.org/all/20250218092538.1903204-2-ardb+git@google.com/T/#u

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>

Ard Biesheuvel (2):
  vmlinux.lds: Ensure that const vars with relocations are mapped R/O
  objtool: Fix C jump table annotations for Clang

 include/asm-generic/vmlinux.lds.h       | 2 +-
 include/linux/compiler.h                | 2 +-
 tools/objtool/check.c                   | 7 ++++---
 tools/objtool/include/objtool/special.h | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.48.1.601.g30ceb7b040-goog


