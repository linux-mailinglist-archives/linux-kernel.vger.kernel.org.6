Return-Path: <linux-kernel+bounces-393063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53459B9B7B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3671B1F21E86
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5881D1581E1;
	Sat,  2 Nov 2024 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LqmGvR8O"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479E01547D2
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506140; cv=none; b=sfI/O28WUKAht7/LHA2vhiF16tt+FuKWrY6iqVJPxo0+y04Xsh4vvCS5Lo70d2pHOOk4VrcdvtA4UdAet57eBUHXfvCiUzt6fHyxl0LTu07HAY07K+RNOxOrsvdjN41u0FBlt8xVU7Ra6o6v6+G8l50ePEbyEeBdH0S1YlyUbPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506140; c=relaxed/simple;
	bh=fk/tTqVWYjU/0tRNnqT1WguFbBT89HpTQst1uQHgeXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoaEddY4mt08MRlo14vS6nlk5/ebapViqEf7405PM2V7q798Q/S834Pt6gLQATqcGLiLNrXOAsiz+9/Keyc5ew9K1ZBm8oz+hnKv6sYQxvaMr2UHP2oKZG3mityXmTkCW4arjsu4TwtHV1EjNr2ZttAfHJHxHuR/Nt+oepGOYvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=LqmGvR8O; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso1893998a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730506139; x=1731110939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj12kTh6O/rQ/Xl4Qt+B24adktPEP3DMoxSVhcVbOAI=;
        b=LqmGvR8ONVIKejd0DvKkKMo+TmOBElqlbiGZGupfmBBTvTi4BmUpxcNixBEIM1ul7o
         CmP7AFteFLgw0TH6U5gSSgvQiKbW4HUusNj9Td5+4OxBsWV9056opVXELshkk4hHrsrV
         TFk6QJQVOnN/9bd3l3vmYw1R7e6JsH+ah4L7WeOvHcGo2LrhmuKSbki8UBgBClhL4ANY
         ySGHcVAedJnk9VIXN3WCnJ+ZxJkyfKakH+RfhpeI2XI051TuWGUkOSN8X5koEx4+esic
         7ywjedl42Rfw/PyAj/fMDyLgdjkqA7k9s4IwVOSDPRn89EE8om7pyl+Xl90Mebl13N3X
         7UKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730506139; x=1731110939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qj12kTh6O/rQ/Xl4Qt+B24adktPEP3DMoxSVhcVbOAI=;
        b=twuyPECO4pgP80CM068tOpMyBtG1q+4I7n0UkLcHPbMcLxnwGrxESGYzRE0+CaQMw1
         31C+fEptJZD7/o20iFV8+GjWUoCnnwK30skhkVGxAB9U4B+lVyQczUrlSVf87UBmbH0y
         PP4x7jlD2JybV0g/gR5wK7bWy0VN/2eiT90iSlMJ1R0X2MQBKMpjvaBC/H7VA0SB+5Zb
         ckRXIgNiFZDcfhNmVC5UE6B3MyZVoHbGj5pBFHyZslVWyh12tdlNk7sR9WWPvbqvi2pD
         y6NxwZOb4dFhntBE2hL1qZRk0pD4sQZYbbml9O5oFlEXqNQW3WXbC5avcuP+0TWSAaib
         /igA==
X-Forwarded-Encrypted: i=1; AJvYcCVy35utvZKtT+mLcf3GdtWUuOY1fajNYK2Y8FK9OP3p49NR3uC8h6HnpL2R66N1QaT2HFFmZAonelt7x8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHto/td5tWvwXjnTUVKMAM/X58ynIpmGhJ/AHbH+isJ9d7q6XH
	Pi6AT+lAX3mHj/kPQePk5tQN/ijf1WUsmOJ28KJN48TB64peJvTthOvYEGfJY/4=
X-Google-Smtp-Source: AGHT+IGji3cval3a5wb8acdD/53zei/e3sJ2bqSexeB5xbUIDHdLdQW6YclDCN4wNPBQMFu1+TtgTQ==
X-Received: by 2002:a17:90b:315:b0:2e2:ba35:356c with SMTP id 98e67ed59e1d1-2e8f11dceb8mr25968856a91.39.1730506138674;
        Fri, 01 Nov 2024 17:08:58 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fc00856sm5505749a91.54.2024.11.01.17.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:08:58 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 09/11] riscv: alternative: Allow calls with alternate link registers
Date: Fri,  1 Nov 2024 17:08:03 -0700
Message-ID: <20241102000843.1301099-10-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241102000843.1301099-1-samuel.holland@sifive.com>
References: <20241102000843.1301099-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alternative assembly code may wish to use an alternate link register to
minimize the number of clobbered registers. Apply the offset fix to all
jalr (not jr) instructions, i.e. where rd is not x0.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index 0128b161bfda..54d79e6f4afa 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -121,8 +121,8 @@ void riscv_alternative_fix_offsets(void *alt_ptr, unsigned int len,
 			if (!riscv_insn_is_jalr(insn2))
 				continue;
 
-			/* if instruction pair is a call, it will use the ra register */
-			if (RV_EXTRACT_RD_REG(insn) != 1)
+			/* if instruction pair is a call, it will save a link register */
+			if (RV_EXTRACT_RD_REG(insn) == 0)
 				continue;
 
 			riscv_alternative_fix_auipc_jalr(alt_ptr + i * sizeof(u32),
-- 
2.45.1


