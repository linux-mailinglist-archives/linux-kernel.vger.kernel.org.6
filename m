Return-Path: <linux-kernel+bounces-561659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F538A61498
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30301461841
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65503202C33;
	Fri, 14 Mar 2025 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlK+B5pW"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C215200119
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965168; cv=none; b=UK5Kb+V2UfUDaZIw3pPgmMPidrLKaci4/UBgooAUxUDw+fJVwcFoCrdYTNXFo2s7dST7B9q2Oaqzy0pkbN3XwHlKOopec1pdxbhn+CF+8+k+eF6RATMgGNN+hRkS6Tfw9TxJG3nPAxQDrgoWMVkO2semqldi2gM2U/41lnFQFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965168; c=relaxed/simple;
	bh=CRZx8RZJJ4GQURbHjfKNYt+IG1166SlqUw57SHrAEJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCfFLBm37pMmiME5FnYqvfDXJKTG2762pxJBZsVGWhbyaDDK4KdBkYEuXPEyK+USzWIgTwD0CRo4p+4bbmCJxg+OIjka2q+9UOTmBvrr9rdBNSKB8FcCIRKd+74EepEgXOZS2v5PF8DkqugznWVlm8PsGP3nSs/xvXmtqmezz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlK+B5pW; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7272a839f3dso634879a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741965165; x=1742569965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LYZOViRyT1/ELcDX3aXX2XaY5ZboHM/SnziHQcTBEk=;
        b=OlK+B5pWlqwCUI48r70pjQfQT3pX9mzvz1vSbxin9JP/4vX4hA9OMqLKwS1zYNBb51
         el0NqwZapmEjeOrfU0+q9ys5w60+Im8pq6ibfJoaUZxeOQMqJXHNslt0ChSn3DpGDoUv
         2W5PkLG2c3hW0QYGOpRUISHnQujUplK5jkyU40GZ0W5lcli4pVHDe6gSfEYExh1KBSu5
         Io0fdQffGSKhDXU8oJVjWzzX5xuJne3KU0GZVU5w4m4fae/ttL3wCRj6Oqo5b0VrkZcP
         b8FcnoBUno9TWy5ai9GkNK50/T/kJPW4xddtTGqg+V7/Vf7RTmGTjZF77u3NQD982EG0
         jhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741965165; x=1742569965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LYZOViRyT1/ELcDX3aXX2XaY5ZboHM/SnziHQcTBEk=;
        b=j0gLPX6HdJ+sy0Bd+0qS+D8OKnX0+Rm2GrmcBwdgKMzfY/vFml8xSACbqhr2faSvhd
         LhHNqCWHAekE2r6cZX5eWA0MX8vccZBibpOcGrQA13TFJBExDCCTHZvSUzcMVCD570Tj
         aYThq1pDa8ygIamq3DcNPWKwNUZDR5qUJfI5XKL6lHrGXoLbI5Gv3sm4XtZeCxXRKABU
         AxQ+kIGXBDvgbO2QmwRB8XsNXbdzX0fUh+tA1bjxIgV98f7YjpbzpvIvweLBXQJZrRxc
         frNAtdx/oy244K5DjLsCsnebPl6TkrgmoZ8B4UEMbH+EbbPSbzm5OHyeOCs38nk9L/LZ
         p0/w==
X-Gm-Message-State: AOJu0YwYD1I/XdAgtNLApfxvoCr9Srsv8nhwIE9QkBiTuI4Dq6zMden6
	/kjv3aCapXvz2Hc0GpvE/nRZE/h8n4gfJgz0O3M1+rqlOzUOmcYzMuEm
X-Gm-Gg: ASbGncsdR39S8ugARwSiYi1IW0XpH2iA/bT2QRegXXR8OM50JPax54WW64xJXHwE5M6
	1UVzxjK1fgG4HjIuxkrFQtwGmNYd2cJPC8v6sOquFOxSFzk4HfxTXHOWN/P6j88OP77Y/dSE5ww
	3tD2OzwRrLwNRzfq30d4bx3toPvyUbSc5y3z2hIS0lr1m9nKsa679wAgCqSRzrN8PAT3wjlntIj
	VYNbkDjuTrf3558J7YoVOGHIQJ2yl/wgUS0w1rc9LQgw2JnW3+ol1HJaLVD7QVHTgSK4xYTm6YY
	v5JTvFN+LvE4NJDOmlDILyi9qYTkwYKkYjLl
X-Google-Smtp-Source: AGHT+IGrA/C8m1HFR7VM+0OlgxeQ+475dUUWnQ3VW7Q+CedVDkvA/sLvxGq6EQ8sZs/Ecrt6O2LR0Q==
X-Received: by 2002:a05:6870:9618:b0:2c2:3c88:6ef7 with SMTP id 586e51a60fabf-2c6911c7e25mr1423464fac.26.1741965165381;
        Fri, 14 Mar 2025 08:12:45 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c6710f21efsm883026fac.30.2025.03.14.08.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:12:44 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH v2 6/7] x86/syscall: Remove stray semicolons
Date: Fri, 14 Mar 2025 11:12:19 -0400
Message-ID: <20250314151220.862768-7-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314151220.862768-1-brgerst@gmail.com>
References: <20250314151220.862768-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/entry/syscall_32.c | 2 +-
 arch/x86/entry/syscall_64.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 06b9df10f2f8..993d72504fc5 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -47,7 +47,7 @@ long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
 	#include <asm/syscalls_32.h>
 	default: return __ia32_sys_ni_syscall(regs);
 	}
-};
+}
 
 static __always_inline int syscall_32_enter(struct pt_regs *regs)
 {
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index a05f7be8a0e2..b6e68ea98b83 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -38,7 +38,7 @@ long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
 	#include <asm/syscalls_64.h>
 	default: return __x64_sys_ni_syscall(regs);
 	}
-};
+}
 
 #ifdef CONFIG_X86_X32_ABI
 long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
@@ -47,7 +47,7 @@ long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
 	#include <asm/syscalls_x32.h>
 	default: return __x64_sys_ni_syscall(regs);
 	}
-};
+}
 #endif
 
 static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
-- 
2.48.1


