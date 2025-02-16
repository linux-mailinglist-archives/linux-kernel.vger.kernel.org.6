Return-Path: <linux-kernel+bounces-516719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB19A37630
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 18:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C423AE8AD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B870919D07A;
	Sun, 16 Feb 2025 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7UU8tAf"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9A19047C;
	Sun, 16 Feb 2025 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739725717; cv=none; b=MiRta8DCgiRRb4clCBrPxrQaEDBkj5tKvQTx+wKB+bXtTl5KHqOcoGugWQ4+fxm7F6hRskBNyPiXsoxVN8QnpHAN5YpjQhy7tAD2Py2tLxsSj4/BIlbz4Tqv0Yz3f3TC50j/uY4LSWM6gKmDKhbdyqbqzBigl2lg3TM1FkQsv2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739725717; c=relaxed/simple;
	bh=HEHXMI6WdAfby4lnVNaQ09H/JY0Nm/qewozJ+5uMGqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOaX/eF1M/P4WaxeIyZWm4P0UbQbdUM9oZ0p41NuJWYoVYkHt0sMzFkseeqqpjF8TMw+7Jaxh0YP2BxqyKBvbkwZbMPwceho57mmqAXzng6oOt7LOL8e4vobxpAXpjO2ZMbxLa0RinvYjSB6Su7m8flP5GF0E/vxPvWvWHLxTSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7UU8tAf; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54298ec925bso4953765e87.3;
        Sun, 16 Feb 2025 09:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739725713; x=1740330513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhA9rB+TVGhS4kXmOmdpbdYF2mOnK+KxvNZOwrTjUJk=;
        b=m7UU8tAfyuupMTyiUpYF7aOe8K3xEEZKETDjQfktJlXXwJT9xWzTu91/8gmO4ZbPls
         DANZEb1z351oBLDNcIqfSvEgdF5i8Prbu8ADpBJ1EMhgcylJhS4t0AKdsEgMW5b93Q+w
         PLEzJNXQpBWtd6WcT1Tn1cZjy3jGS9rXHOMwvSu/auyh7MV/0CAEjrzX8IVyMuQC5dps
         kzHVN+ibLtc0eUTcL/aU+Xz0H9Cq/ZB5hmXRW/SHk0bhwdkbWTntRzVQ871ZykIdh0eV
         oB/84+tkRIvHCqheAVAudvp8g/FpWuav8ffbXTttjmqeElx4reuLiIaYbDzg8XoOdIj6
         MX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739725713; x=1740330513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhA9rB+TVGhS4kXmOmdpbdYF2mOnK+KxvNZOwrTjUJk=;
        b=fcVL27r2bVQCvRWnfiCaVlIchQkL8rDBIH+l6tael93kQoUjCNnxUdt/PsHS90R30K
         vV9kczkqpnpdZd3hhGrcXoYu3YsOoBKxUjng9tkhQv+5bOcmYznExSwBZ7AFits8iKl7
         MIU7VTZggku9VylU6v1q5gw+gGK9OdqHbsDdmALfPyQ8WTR02AqXGz4PGzE1CUnBMOU7
         viGjFPxu67mmTPxZyr9uYi6SnDSm2pA/V8lD/eVronMmQIZ0Y4oz9VUIkP0e7r75tgqa
         54Scfl6U1dFPqQ06bP0aSdSnT6aCLap5A1JXbJ/xjLnYsq6fpoL6Ay4CJE/iXsrR4b6j
         A+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHOT+Cbg9w0VI86mM860MoQ+B0BU6Xhxug11ilFELpIpVzqOAq6tJSgVs2ZDrBPUkyHHaAq8iwNH7EIA==@vger.kernel.org, AJvYcCWxDfgnspH8thSdtgePbMZs4oGwc1/tSDHc7cHm0UK3vbnN9wSEoq9dZAT4FHcbtAVoAoLuRndIyx5NEmzY@vger.kernel.org
X-Gm-Message-State: AOJu0YylgfudFB2xJ7VYWSekLn4Uwm53LoPg8ZoqMnxEaedUZfuyOsy/
	BiRd9783uP2Z9GsGIEdWv2ij9v48mgC/ihWs+BVvN2OKVljGxSwm
X-Gm-Gg: ASbGncsCT05/wiJHzL+cZYZ/pKoymdC+DYPmj5uFinczU5M+11nKKIv+2I4T7x04C5f
	CtAxumL7NtnPlLYUZ7j+hisSBXRe4O1FnkgtqC1jRSELUeisZfXwYStHGN/rR6XfjBZuq9s0kGC
	ORNPVHsKIHtvW2AgyvEEF1vZorZIOOdeOfLM7kxvoWwLhrZsW2oPQJOR1IBMab2lMpfn3hoSWno
	hAvH2OOJWx+CPIX8WxIrDEV+VjhbU8+fmV8k/c/Uq4mEdL9OvZ7wTJItoreL+EWJTn+x7CRD2to
	If+zaxx/wkx5JsichZiO4lQS/4WzMkipg+iOMozFpeCtfq4jsyZkEON2aGqHgQ==
X-Google-Smtp-Source: AGHT+IHOCKvLeeQf3yKBb2Vl70hk6+HUiPYWTe5RwG9kk7T3GiyDNf6DCsCp7pLUpYPlxnmGHNcyPA==
X-Received: by 2002:a05:6512:3b28:b0:545:60b:f391 with SMTP id 2adb3069b0e04-5452fe2e48emr1355722e87.2.1739725713228;
        Sun, 16 Feb 2025 09:08:33 -0800 (PST)
Received: from es40.darklands.se (h-94-254-104-176.A469.priv.bahnhof.se. [94.254.104.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452a67e6c3sm921808e87.1.2025.02.16.09.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 09:08:32 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: linmag7@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	glaubitz@physik.fu-berlin.de,
	ink@unseen.parts,
	kees@kernel.org,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Subject: [PATCH 1/1] alpha: Fix pte_swp_exclusive on alpha
Date: Sun, 16 Feb 2025 18:04:53 +0100
Message-ID: <20250216170748.2258-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216170748.2258-1-linmag7@gmail.com>
References: <20250216170748.2258-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function pte_swp_exclusive() checks if _PAGE_SWP_EXCLUSIVE bit is set in
PTE but returns lower 32-bits only. Shift bits right by 32 to return upper
32-bits of PTE which contain the _PAGE_SWP_EXCLUSIVE bit. On alpha this is
bit 39 but on most other architectures this bit already resides somewhere
in the first 32-bits and hence a shift is not necessary on those archs.

---
 arch/alpha/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 02e8817a8921..a96d652629fd 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -336,7 +336,7 @@ extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 
 static inline int pte_swp_exclusive(pte_t pte)
 {
-	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
+	return (pte_val(pte) & _PAGE_SWP_EXCLUSIVE)>>32;
 }
 
 static inline pte_t pte_swp_mkexclusive(pte_t pte)
-- 
2.48.1


