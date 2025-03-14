Return-Path: <linux-kernel+bounces-561155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647A8A60E24
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3513B8E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B151F236B;
	Fri, 14 Mar 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PswBnVdK"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AE1EB5D4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946535; cv=none; b=Ivvw+X9QN4XSbVP2y1IeOcmGF6puzrns7Wd5o1ecWM/U/JtV9wEiO6iKXsYOLQ+Pmgb+jdnESkaGZEwkRlW+0TK3NEvweNcUfAVsFKKFGytFxQAO2RDG/M5F0xloh17aBPPzBAH6P8Gn9dUP0jll/JwZRdA/2nZ0s11tWRk4RxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946535; c=relaxed/simple;
	bh=MTO1PX/LQ9lgMOSSO9QL5nuKMvGbKATf+NLhryfAkck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fn0M9sUWIYEp6ts7DIF7U9bgYORPc+N2gl+wjPNz4cG0743uWq36MCeRPclX6KEZquiwwos/gWKEPpTbyKa8AjFXV+o8030tWQ3Ws9OWwxxlH+/GCBGsjuIKrSocpWn6IzGrphJjA8U6qpSL+3iyr1JHWpsM+5sUu5VDdQ496ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PswBnVdK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390effd3e85so1636063f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741946532; x=1742551332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UWJoPqxYk38Dw7bFH158IGboik4tDupQYBFkOVdu1QQ=;
        b=PswBnVdKZ59iBFaBO7oDTJOXnWTgshz5yr+Orn6hTqKAk6R1i812WO0uMOFr9vtXZW
         aQraTUeF/L9zOTii+4ssJbCC/p0Kk12bpjK5VWg41jhgsAKOkbwWu/xAEMPKbwA9CQBb
         l7mvWZWgDaaEcmwEIJn1X4zdW3Ywugcl+PLGjF4cWpVl8f7dretGfeUKcn3nj0cqIwiM
         IrRYJ2tuntqaw+y1WI9aiM7LM1/wVYcO1awqqQTwnu8H+tbXg4GKzCzUoLSqvG2Ts3nQ
         +xrqiTH8/dSB9MHKN773g/wgrrto++A1VV5J8l9dTZTZTgQwFpwWHISZbGqQtijUym8p
         Mo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946532; x=1742551332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWJoPqxYk38Dw7bFH158IGboik4tDupQYBFkOVdu1QQ=;
        b=jpni/EELGPxHuL3RgXTaDLyZaPyvht3R5N9Jhnuxz5bnlMNv67vPUgx/zANFolJUs2
         kvQ4W0tqJ9EAXugpVeitt1epuR2PdHtxrjjGao/vIU0DoURCkAeeHvuX+2w/hqKEM4c7
         QM5sQwjeDXVn9SkCIzGBa1/X6SDwz3omWkQuCqyvbcFi+70rc/3zRf5G5hmUBFibp6RS
         vTvJ89ciljZ6n8ExrJtBBJ/ZB9TGwzu3QY0vagyNaJlcoS8SYRW54CtrmsnzNIJCzZrE
         9h92GakQPzFeWlayAct1/QW4c6LOAKDbhrHH6EvLCa7R/Lb30t+ID+bI0DrP3XKJ06w9
         poLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE4hf71/4EF5F7REXuEI2UK/zZdWnTtVs5s99f9I6exX0nD5rIOckKceTPPTqJ09uwnmc00NsOaVMBIp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb4G4ds8ta2EuYs8BFKIh7gLl/jVm9wmvO+sAcChoOi2wl5lFP
	530tB6OJdohs8X+K5AfqOdscbN7YRdlX3eviAbzrFanOB4DjYdz/Nj3hAP69
X-Gm-Gg: ASbGncvv/vxfFtHKxasbz5fwDBc1PV2UUl44dNTt3zIP5cA9tUtqVQGPuRLX3ILZmJQ
	4lDvTzkS7B4TlSh7QhPWcfQLCXyhBkXQQS5ljAVr9+qbwRaZEif28j2O/oOWrfhNYC/zfpFiq2E
	3ze737010iyl7r11aaUq0iOnTr/DBobmi6JrTP2mfVOVmqf2DIA7ALqqrZmQrim82pNtRn7ATDb
	8ktT1zvVDJrCw2DT8tRyNeL1kkgJHLRONfrB99nvlO7e8SpkOwXJU/eykFE/Bc3MD0zFczIvUMT
	MIvtKmNf3Acd9IGjz7P/1gAH/IHihNdMp3dmNsoLX0UccJY=
X-Google-Smtp-Source: AGHT+IF/ihWOYUidbbLtAN45HMaGN8fOuSRvMux/BzKnkQHE+XazkbhalA64p9oxoJI0d1FYjxrabA==
X-Received: by 2002:a17:907:7d93:b0:ac2:84db:5916 with SMTP id a640c23a62f3a-ac3303013demr195400266b.31.1741946520733;
        Fri, 14 Mar 2025 03:02:00 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816968ce3sm1778794a12.21.2025.03.14.03.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:02:00 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/asm: Use asm_inline() instead of asm() in alternative_msr_write()
Date: Fri, 14 Mar 2025 11:01:58 +0100
Message-ID: <20250314100214.683494-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use asm_inline() to instruct the compiler that the size of asm()
is the minimum size of one instruction, ignoring how many instructions
the compiler thinks it is. ALTERNATIVE macro that expands to several
pseudo directives causes instruction length estimate to count
more than 20 instructions.

bloat-o-meter reports minimal code size increase
(x86_64 defconfig, gcc-14.2.1):

  add/remove: 0/1 grow/shrink: 2/0 up/down: 338/-249 (89)

	Function                          old     new   delta
	-----------------------------------------------------
	arch_prctl_spec_ctrl_set          339     656    +317
	arch_seccomp_spec_mitigate        135     156     +21
	ib_prctl_set                      249       -    -249

  Total: Before=21423521, After=21423610, chg +0.00%

The code size increase is due to the compiler inlining
more functions that inline alternative_msr_write().

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/nospec-branch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index e8757d7a3582..097ce28aabc5 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -510,7 +510,7 @@ enum ssb_mitigation {
 static __always_inline
 void alternative_msr_write(unsigned int msr, u64 val, unsigned int feature)
 {
-	asm volatile(ALTERNATIVE("", "wrmsr", %c[feature])
+	asm_inline volatile(ALTERNATIVE("", "wrmsr", %c[feature])
 		: : "c" (msr),
 		    "a" ((u32)val),
 		    "d" ((u32)(val >> 32)),
-- 
2.48.1


