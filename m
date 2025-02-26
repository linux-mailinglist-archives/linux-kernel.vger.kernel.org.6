Return-Path: <linux-kernel+bounces-534300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8746A46541
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBBB17C346
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C5221CA0B;
	Wed, 26 Feb 2025 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1ff8Jfq"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DB020AF8E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584242; cv=none; b=s+MHi/6yRAJ5kNEquloh8R3t2biqWhbk71gZVDBN3yfw6gfqKhrbySVQ/Hf/gZjq2/ygKLEdzgcBRxAwfVGULekQfLX0cQXufMRrh4d43vOD2rtIzOxp2whASVp3JLNKHr7DQyn1u2NRvasS2iGquLPOPxmE9BHFW9e1ZPGjEnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584242; c=relaxed/simple;
	bh=LPMeOR16SbuxjqKPHN67owvO+O7nYbioSjfnFMDz/HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFFDHVqdYAoc4SkWy8xnx1lnKrHG5BzVtXj1UbGj3jsAYZJA439/1VSG/bIA34+tBzPcK1/KQzKZpl+NBt3xkL59n/fLC+8FY0R5W4YMNcxDXW5Fw92DWttozguSDFNNtKHlSD4LRFsOt/NztNx8+XDd977qNNjQCjoVADVtlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1ff8Jfq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb86beea8cso1238738066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740584238; x=1741189038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2mR8w25aDW2SxfUyp+4vH7DZUdoBKGAVuoCZ2tcfghU=;
        b=Z1ff8JfqamTcMXQXfSK4URjlqmG4GOySfJa8lqm8CP+VlVBD4Fn0VSzMG/2LP1W1Rg
         kX6Tno+RYHE4QpgJRPlVjaN9vE1auGEL/GujcHG+Hsz/OGjjj7XlB/DFdOfGLq1uqPXq
         l6OoJU1PsTZPuFLwtRup4xzXcjEWW7pql+iqSiHd60PaMyoZJ3m0JAd8lfZfXKPudUQH
         P1Qvypn+u2VRwY3jDfQf/FQDi61es2n+roe0YQZSg8zGJ5xIzzZQ4ztPwpuJgt4R9Aqe
         XAMa5zL8//OTrjvw5x9yDdzqGfMk5r0mT3kJxHuOuxWOyp+LXFCZgFsaHszIeHqIV8HG
         SJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584238; x=1741189038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mR8w25aDW2SxfUyp+4vH7DZUdoBKGAVuoCZ2tcfghU=;
        b=Vk9Du74EKG+o+FXX7QFyRrW68IJL2UyCn4GBkUgK28guYKgPmAx2L2uqjLy3FJbiSa
         Gp/blsHW6lIqsW/FkGL91Lz9eknZcm91ysvjPOze/acpkAMjyv/88jTWWFJ7IPXUTh1w
         IuZWCMUzNCW6k8Hrit0bcNYDuv5XTwCNdHOzrnqVpzNT6XZu4VePAibuKTVS+y6NNvbV
         1HkawuQz3WUVkcyMud/laxd6n7XqAsrijvPWyqkWJl+P4vPL4II3DwKcEgvwDatfQbad
         Pmv7G3sC6595oPiCtY5ilIqmCFfAhhpOc5hIjasBJ+qU+cJ8JCaiKvhaRfcFZt96jb8Y
         N0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVKvUXqRRa8ZQsCnySx8wluyAVDaEOGaiF28rUKsR/PWtYs4PVJRyPBoXpYE1kbwBoUZziD2buzIfYstdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyda+OHoTBYZLLkx6764O2qIdGF9F1+YkKeXRwKag0rTc7GVeTg
	Y0h4mtu6LR0qD0ntEPcmRqlVyIl/giUimTWo0a71rk3022H85Dww
X-Gm-Gg: ASbGnctv+CMgJAh48kNfhzQwj4cZABPzHGxoLesErsI3o73fd6g5Mn/Ditb+N/IdElq
	4yaQ7Zte8cC8+GhIhDFXK7TnJBN+ewl1XqTp26xaiev79uMe9r8uPve3m6leVZ5vHkCQJ4ATATg
	XBDAQbq8YOv0JAttmQ3UgvtoMireLRnOSPKX/hjpzqeM8WeA/lA2Ur+HZxOsoLNQfGUVHkTYG/N
	cS27lw3vdi+/MPd76lsh8jY1w67ixgvwVsrxUZr8/+MKbMbdVjp0CCBjeS5vUefLyBvtvKUR0kq
	eWlgRLJNK6pfuWLqJF2JgspEzal8PhW8Y94=
X-Google-Smtp-Source: AGHT+IEC8n7+ktWGHdwPd8OG1yevv54a7MkSQLOasQdYH/ebVYPD8D357ageZmhdLCb3ItoP82tX/Q==
X-Received: by 2002:a17:906:c142:b0:ab7:beeb:d1f1 with SMTP id a640c23a62f3a-abeeef76330mr436320866b.51.1740584238099;
        Wed, 26 Feb 2025 07:37:18 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20133dcsm344781566b.119.2025.02.26.07.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:37:17 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH -tip] x86/bootflag: Micro-optimize sbf_write()
Date: Wed, 26 Feb 2025 16:36:56 +0100
Message-ID: <20250226153709.6370-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change parity bit with XOR when !parity instead of masking bit out
and conditionally setting it when !parity.

Saves a couple of bytes in the object file.

Co-developed-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/bootflag.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/bootflag.c b/arch/x86/kernel/bootflag.c
index 4d89a2d80d0f..b935c3e42bfd 100644
--- a/arch/x86/kernel/bootflag.c
+++ b/arch/x86/kernel/bootflag.c
@@ -38,9 +38,8 @@ static void __init sbf_write(u8 v)
 	unsigned long flags;
 
 	if (sbf_port != -1) {
-		v &= ~SBF_PARITY;
 		if (!parity(v))
-			v |= SBF_PARITY;
+			v ^= SBF_PARITY;
 
 		printk(KERN_INFO "Simple Boot Flag at 0x%x set to 0x%x\n",
 			sbf_port, v);
-- 
2.42.0


