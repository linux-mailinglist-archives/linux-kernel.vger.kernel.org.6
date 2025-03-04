Return-Path: <linux-kernel+bounces-545201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86178A4EA3D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F0D172439
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E92A292F82;
	Tue,  4 Mar 2025 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7cEncbi"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E380B291FBC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109707; cv=none; b=rNowY2G9i7IjwOfKUetSvL9SA7uqF78mX26ZTBsyeSP+m0sP7gPvSj71Aj3O2UYkHPMwfBg2iPLyO6NUUHs5w5jNqmWJVFyFaexNK74crnfejGUSbunvtY2O6KJaAnSN2jAAfUHMyWCYA/W05WZ39LWbwcQ9/4t7Ywzs12KZIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109707; c=relaxed/simple;
	bh=n6YY4OqOCEdOPtx7xPZJWxTSZ48DQxzR9HnQ4oeYLWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZuXvqSO5QRk0r2PjbOmxQmNWbh/5qi6WjsCByn81aa9UOcUNXbR5LZFWvtTSZKee1dDj2mlQk1krtmsWUs7Y330iLFXXvubxDv6jyiqjjuRegL6W0OjwCaBSK4yR06RTKgoubzCaQhgR+lCldWTaX/AEs60iRqYZqNJbWDwzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7cEncbi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7430e27b2so966540166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741109704; x=1741714504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8m0gEqWuH7yGl+3Qln2JYyfTIriI+6OnbOe67mtKYjk=;
        b=M7cEncbiKbv2aOtd7kZqvpgQNetaZtnen1NHdy8LGr16E5wn53Kd4p7uSpGZwxRobG
         F8Mj/NGiq8A4FwESxGUBv6SDrA8F4uvwslfiTNLdh30raKFxKbHzDnDHPPdDB3ryPBRV
         jtHMz4BUkCN7jL1c/vg+SRSCgDvR96raCfFMCwLscV2vbapSvs9ex0RL0s6DWv/Dw9/D
         8EmneN9EITqmAt+nUrdc85hKGa2AZ/rte1NdfO3JsW4QMoLkGBGAXY31O3eKuWhaEPNL
         94wPLk/sFmkePFOHbjMAJjyS7iVSurwiYBL8S1vOIr21dr1Dw2OxiuUyca8/pY5l3bbM
         TJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741109704; x=1741714504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8m0gEqWuH7yGl+3Qln2JYyfTIriI+6OnbOe67mtKYjk=;
        b=rt+Dp/EmZeK0I2PUXrS+9yvocjhpVmmyzbbRGlAeCBCGNYDoiOB/pZUQWQ8pfbfN/2
         fy13oH7YLiv2vUN3F3VBANAT7ZMv2HJKV1CkgzEyEiTE5viKgb4yfVMmGGCBTNbiX5hv
         RFApibRVBHPmiI1tuyYeLDItHRgL9a7WEW+H7x/50HTRF7Cq2Bapc7kp78/oQx9OJdnG
         KaZfRkbClWliQpwuZkHF7B78+Jof/2W3a7eREGJ+uybnPuLJ9v0aibRtU63rHCm2j9if
         DmV/Cp8ooLqHd6MMXwuPSwMVo312Ws8yZRiYzUk8E7nTkz5v99pBfOWXYvRpYA6gACCc
         SX+A==
X-Forwarded-Encrypted: i=1; AJvYcCVCUcOjyqjCPWEIxg6bMV/3wssb270WkR3M+NSgRdLrqHowkZkWHfm80VQqji5C7ecDkFVQvDeMzZ1vTw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqh0jGOA4Ry+6RagKVxptRZdB9r2qWvDtbEaL6Y6d4RREgFKdt
	C2GJ/vyE7k8lbuvS09ksUTK7wlNzrkY7nWAm0sRZZxklkX0SuSBd
X-Gm-Gg: ASbGncujBzep/gDVxdzMfEWLBHUnNglDepMh2/b8Q/pD/oIPLWXuWyUIxTEsKImWO95
	E2dB84lzhGd8x+rIrf0MWF/BB3HbqT9ACzhmUUX9SYcYIdQFENRvGWmDa+2P6AnXZ3oOoNnyPYP
	RCr1P6JcKkaMjiDOIJ3NdxcuusCph48/E/3Fz5RxrULXP2LwRxhRKJmA0pVGWhlcbL2Uh2x35Ru
	6sCLXk17YXrWVdJ1golxqpb41SsV7KSEXz1qWgPKEWMhwERydLmVOzOWZIAPCF+JPgjFdy6LSiP
	2F48fP1/2p2zcF2zzpwczxMsqypiA0LZij8p2q/SOMn1p3D21UDuew==
X-Google-Smtp-Source: AGHT+IG/YfkDZ+HHmbGwdd4Q/fe2Osz/EbvKcsQgdP+PpFjgrmVHSj0EO0fZWQI0aJQVgApNlV4Ynw==
X-Received: by 2002:a17:907:8b97:b0:abf:7919:4990 with SMTP id a640c23a62f3a-ac20e1d7190mr9093366b.35.1741109703857;
        Tue, 04 Mar 2025 09:35:03 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf6b53b572sm472973666b.88.2025.03.04.09.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:35:03 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] x86/percpu: Fix __per_cpu_hot_end marker
Date: Tue,  4 Mar 2025 18:34:36 +0100
Message-ID: <20250304173455.89361-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make __per_cpu_hot_end marker point to the end of the percpu cache
hot data, not to the end of the percpu cache hot section.

This fixes CONFIG_MPENTIUM4 case where X86_L1_CACHE_SHIFT
is set to 7 (128 bytes).

Also update assert message accordingly.

Reported-by: Ingo Molnar <mingo@kernel.org>
Closes: https://lore.kernel.org/lkml/Z8a-NVJs-pm5W-mG@gmail.com/
Cc: Brian Gerst <brgerst@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/kernel/vmlinux.lds.S     | 2 +-
 include/asm-generic/vmlinux.lds.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 31f9102b107f..ccdc45e5b759 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -331,7 +331,7 @@ SECTIONS
 	}
 
 	PERCPU_SECTION(L1_CACHE_BYTES)
-	ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <= 64, "percpu cache hot section too large")
+	ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <= 64, "percpu cache hot data too large")
 
 	RUNTIME_CONST_VARIABLES
 	RUNTIME_CONST(ptr, USER_PTR_MAX)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 4ed0e6a013d0..58a635a6d5bd 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1071,9 +1071,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN(cacheline);						\
 	__per_cpu_hot_start = .;					\
 	*(SORT_BY_ALIGNMENT(.data..percpu..hot.*))			\
-	__per_cpu_hot_pad = .;						\
-	. = ALIGN(cacheline);						\
 	__per_cpu_hot_end = .;						\
+	. = ALIGN(cacheline);						\
 	*(.data..percpu..read_mostly)					\
 	. = ALIGN(cacheline);						\
 	*(.data..percpu)						\
-- 
2.42.0


