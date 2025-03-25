Return-Path: <linux-kernel+bounces-574660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F63A6E835
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFBF1896E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD8914A62A;
	Tue, 25 Mar 2025 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgyo09B1"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDEF13632B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742868097; cv=none; b=Dri2lPDwcKt5OKZllNRurSPPEEyZrg5Hehw5I258ntVZeDmEMNF05Ci0GafqYUL/WYTKrxGFfGna8B+ihi6iIZ/6+rSM5qwDH+RxuQ/LoVVfC7YY5yJcCg7G/4mR8FproeBoKjcmtEqQW93B4Acx68zuy5GJFcN3MIJXJVCFCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742868097; c=relaxed/simple;
	bh=szpsKldcBJlI9NUuSXe8uKA5PaTZoujy6dZVJOXH0/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qw6vgKnutEHZp5WencKv0ROWo+rtSCfrdcLTJLhe8PtfjsSbduttBH9YsQbx0rJhVGQDUthNgkUvEy8rq56ljVNcihnat8wfaP4F7lKhaas3Ea1OTaqi+o7SLaQs68SBqMOkDgb1WPt/2o/Jlin84kD5QnJo7s945INYmJm56x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgyo09B1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso17365e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742868094; x=1743472894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVeFuBiZOFAA2t89F6lA5CWEvO7WSJHez6s5fDO0YwM=;
        b=rgyo09B1qZvgvHTYJQyJa4GkxZjZMdD2dAQp7tX6cZc/zQZlAUdBPelAnfGyD2NC0Q
         9CBOulXu+DvFwUv8LllO82BZK2aTu/1Ez4gm+pDeyFKJmNUz2whrSBw9CP12MOHkNlXE
         YwEI0iiBjH6cEHcQDiE8AaUYkO8ig2uUSjLVF7tpSYC8iKhw4kT9RGBr4RAsqo3uAo18
         089uq4H1++NlFaJ/wsO3ZnzOqX9/lP/wd/3elokWFZ+mSpuuRpAqwzDcTSx2bpFJcM9b
         BxrIYcF/NsQo1LchHOw5A6lwou2+H8mwEwDbTSukRZ8jn0oEZHXYIEUiNqT8v5HMoS2b
         w8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742868094; x=1743472894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVeFuBiZOFAA2t89F6lA5CWEvO7WSJHez6s5fDO0YwM=;
        b=UEbUuL6O9/OsaI7ze7X0//mbR8en6m+oYxNWBxUhh57f41MjrYJdK2i0bGaP4hhj/n
         93Z9jdeXvEpYEO9M/EtJpO3w/46Cng3FbeK6eeu42U/qcyN25WR4v+7e0mHQ03iYpWO4
         SNRy9y1+Lb5S7bw7kowkxzetbQrb8Dnbfu+X5G6qF0sn/gDJR1yDDcF1cwdsAuSBnnKn
         Ud+fgfvp0dcixMXSzpRwCexot7kk+uWhvNZsfFHSCaGGdRK97dLRZOga7guv54M9dqF/
         wGnNsH1/MeuLjoZKisYfpotnADXRymEI9llTHFIMxzlt7iQRMTSgQ1SLdHzy+0s4dULe
         dDzw==
X-Gm-Message-State: AOJu0YwWvay4P+DBdhMQKIW4YM6eoHPuqrFxzV1MSEiuH2lQbGSdo5b4
	QTVD1XB5ik1UJ0zM1/gp42+rAm9zppj2UN9VsbrNP81e2UV5Mo9Da3aqckupaQ==
X-Gm-Gg: ASbGncvIqf/g2ELurTYTOGfHt6qp+hBa1A9fv/YO4cqPiJuQeJmpgk/DutvVYFyNOBg
	jTB/SBkN4ht3Tw42LvnSNahQ2Qjo45KXgkamwMScSJLcJd8EdQWry/M/qWv7R0lvPWDyYS8UXxJ
	jqMZ6ZobdE6r53U8JpQqm9oK2jMWDnPxEdoNBz8VEU+Y6eoJHyqhQKTAnxgNoxY4iT5WEgcNXRo
	iucgm9zkyiMy1McBF0YTBofJGBMdN27WgSg2HBOy0Vskb8+D5VfIUfGRizu2WY0+/8dtGnJAfuc
	3wIsi3GZzlqY5Hp0ftSxpwfIo1kDugg0uQ==
X-Google-Smtp-Source: AGHT+IEv5EnYyb6w8f9QzYVxZCs9XDaaVvOTHQj26dS1mrqcnpuOyCUGO5jHALpCEeKHnLLrQ4IkUg==
X-Received: by 2002:a7b:c455:0:b0:439:4a76:c246 with SMTP id 5b1f17b1804b1-43d592c4964mr4075415e9.6.1742868093914;
        Mon, 24 Mar 2025 19:01:33 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:fbb4:5f96:b3e7:71b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed5e0sm185626655e9.37.2025.03.24.19.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 19:01:33 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Mar 2025 03:01:22 +0100
Subject: [PATCH 1/2] x86/entry: Fix ORC for PUSH_REGS with save_ret=1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-2025-03-unwind-fixes-v1-1-acd774364768@google.com>
References: <20250325-2025-03-unwind-fixes-v1-0-acd774364768@google.com>
In-Reply-To: <20250325-2025-03-unwind-fixes-v1-0-acd774364768@google.com>
To: x86@kernel.org, Andy Lutomirski <luto@kernel.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, 
 Dominik Brodowski <linux@dominikbrodowski.net>, 
 Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Vernon Lovejoy <vlovejoy@redhat.com>, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742868088; l=1532;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=szpsKldcBJlI9NUuSXe8uKA5PaTZoujy6dZVJOXH0/A=;
 b=pYQFC4kJ/G4fLchM1vkw6c+mYH6uR8wpqVVqS8jxr5vZaTfgW59CJdm/QLdz2RDLEG19lYfUN
 8hV+CnVIi/bCUXAAKkHPKU1+ws9Cb3O3EoQmHW3j5A9O/4gApWg5nAR
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

PUSH_REGS with save_ret=1 is used by interrupt entry helper functions that
initially start with a UNWIND_HINT_FUNC ORC state.
However, save_ret=1 means that we clobber the helper function's return
address (and then later restore the return address further down on the
stack); after that point, the only thing on the stack we can unwind through
is the IRET frame, so use UNWIND_HINT_IRET_REGS until we have a full
pt_regs frame.

(An alternate approach would be to move the pt_regs->di overwrite down
such that it is the final step of pt_regs setup; but I don't want to
rearrange entry code just to make unwinding a tiny bit more elegant.)

Fixes: 9e809d15d6b6 ("x86/entry: Reduce the code footprint of the 'idtentry' macro")
Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/entry/calling.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index ea81770629ee..b14a2c39a601 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -70,6 +70,8 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
 	movq	%rdi, 8(%rsp)	/* pt_regs->di (overwriting original return address) */
+	/* we just clobbered the return address - use the iret frame for unwinding */
+	UNWIND_HINT_IRET_REGS offset=3*8
 	.else
 	pushq   %rdi		/* pt_regs->di */
 	pushq   %rsi		/* pt_regs->si */

-- 
2.49.0.395.g12beb8f557-goog


