Return-Path: <linux-kernel+bounces-415216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67489D32FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 05:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8937F2840CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 04:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4166615623A;
	Wed, 20 Nov 2024 04:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjpVgPUI"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A74E42AAB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 04:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732078455; cv=none; b=p/OOyvTIBJ2IBPfrz1bJBho0Fm0ZpYONHumFcDnjBSYRZ/fDBc5eRqnY2PeK4/dW0C39BDTHktWNQ+yYvRZ1zB4IBrVJPKogkYukTnhrCWgBjPczNzrrckLmlN/tQq+C3b1n1Gn45GK/sL6II8FcZg5tGsalCFhqPHZKDYTvuRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732078455; c=relaxed/simple;
	bh=7pmAWgkWPTIzC27FaJlbcmI1rA97iEBa4ST5XvEvdUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfxK5XZ+YvfbDIlhYjUuGDyttN9/OU+I3sdvxXX+QjEuWyCL6d3rlkb0c8t5EPOk6MBBKnxclhgaihNBXTpVBk529RQ7x6g33PUpElhRIGndKzixB1IqL7e/Rzsc4WUqEcJulYiSchgiYgrmYmhIJEp36nWFSMlbxNMj7wdV59w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjpVgPUI; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ea1bc2a9c5so382731a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732078453; x=1732683253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nr9bDWpFW06TWsiAwkTdInEtC48T7Y3ALsBXGGbhmbY=;
        b=fjpVgPUIxmPl02tf0gmtbkmfAkiTv9JlP+P7cFPAzF9K1GFVxPsXSl2Vfe/7oZoFHk
         7/qviLLdJMmAno7fnfWVwUollG+dYW0BmdSi7/2zoN1mm2SQNsBqs/XUqNj4kf9r80y9
         PIayi2A0Yoj+9xgdwbH0RJxaut9EtAluj2ryaCHcZ7IzAOjf7rVuiXtMcg1E/eheAK3s
         DZnFK3gBQPq3H3Btm6zsqWGe5fs9EA+LB89zCp9g020bZZACZUc7OLsVhSoANsZ4I7Um
         EEl1yEKRx9w45OMOrfbvc606bZkaFR0oH8yAyz3KQbR1J2+OFAxh6YD63Amv2FutbJnV
         n6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732078453; x=1732683253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nr9bDWpFW06TWsiAwkTdInEtC48T7Y3ALsBXGGbhmbY=;
        b=mNuTxnlokVZe6Kigv8iJx7rYb1GBhsmCK2jHaOjt7zhKXH1JNk6DUg4ZC7Ho/z/vRb
         rZHMIQdRu6QYlHIWGla262cW6sG6cL3hhlWUjLK4sRLCr474UXU1b93ZNgRPDctliBDU
         c/XmjcmLDNkv6p8xry23tncqqlKt2Nb+CUbla1MRqKvgzEq24wEIqDi7AFoM91QwOrqW
         p+SN/R8wO/dCcVp3bp8TBduT6AEnvocptq9rQDrkV/ZNHfBYpKp9vFXu5bhsXgQhyBnN
         7rvInVMd0tBSZp6npbXimqkOUNf98tC4KWXmemtn2G2j9jq+ANpAftvdmfeL5uhgs/Pc
         AA8w==
X-Forwarded-Encrypted: i=1; AJvYcCUhPEVmnRAjtBRm/6ZBQwUhGaerKnb3BCdIF43e1vxX0EL/q5cOxRnmVgU4xzlK5t3fLumIezilIFS1SII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMqCp4qsJRV1nhT9XokTEMv5Ots+lgBQ3h/S4I2Dmh8LAHh1h
	1KenXSmeSVvR3ri1UvLK5Ijjgy8C0Tf4RYbCcy/ubKm3kVzEpo+P
X-Google-Smtp-Source: AGHT+IHcXpG4JC6BlYjXdB2KJFxOFKlbKLdS2H6Lq/TlBRndmGYk/bd8MqYjQjQSxSLDifqguTxRug==
X-Received: by 2002:a17:90b:3ec8:b0:2ea:9f3a:7d9 with SMTP id 98e67ed59e1d1-2eaaa73c00amr8834300a91.3.1732078453533;
        Tue, 19 Nov 2024 20:54:13 -0800 (PST)
Received: from localhost.localdomain ([175.112.156.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc305dsm83194625ad.44.2024.11.19.20.54.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Nov 2024 20:54:13 -0800 (PST)
From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
X-Google-Original-From: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: remove duplicate word
Date: Wed, 20 Nov 2024 13:54:04 +0900
Message-ID: <20241120045406.21537-1-RuffaloLavoisier@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Remove duplicate word, 'to'.
---
 arch/arm64/include/asm/pgtable-prot.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 9f9cf13bbd95..1d6970efeb6d 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -131,7 +131,7 @@ static inline bool __pure lpa2_is_enabled(void)
 
 /*
  * Page types used via Permission Indirection Extension (PIE). PIE uses
- * the USER, DBM, PXN and UXN bits to to generate an index which is used
+ * the USER, DBM, PXN and UXN bits to generate an index which is used
  * to look up the actual permission in PIR_ELx and PIRE0_EL1. We define
  * combinations we use on non-PIE systems with the same encoding, for
  * convenience these are listed here as comments as are the unallocated
-- 
2.46.1


