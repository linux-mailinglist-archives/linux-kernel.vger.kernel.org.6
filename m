Return-Path: <linux-kernel+bounces-287398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63099952755
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0147D1F221D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF49C210FB;
	Thu, 15 Aug 2024 00:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JiE/HO2e"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A424211
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683440; cv=none; b=NuhzLuEX3S68bi5Lbz1zNS2So0wBsONhzwZECfOaIUIDVxkKsow4xZmgTU516hqQyUcIWX+x2OhZXA6DQvDfZjuHPXNTLG/QQn/NAp1wWihdmYI1ALxELlvSYLi1l85z02VhkmjfEe+jOxlYiLLK6vBlMubloiou2RPC5ojLInM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683440; c=relaxed/simple;
	bh=YuoZT1Le8rW8iRGj7CdMFiXVxmYJSRwzEyp4dHt7o5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t6phW00XyZTTUdLg4l2pwSiJzQYVuKbFWe3EpUe0sqwEjZxiv00IWA9Eb6XMWvnTQM89f0PD6/KWkyvey8CVqG0JUsedqg8/7UEdj9HQ1+l6lrpVSJ7q1u/r1KN5sT3c80eAdngpzg9o0b+MVz96Mm5iCJpprqZE70G0ydM9NPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JiE/HO2e; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c661e75ff6so280529eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723683436; x=1724288236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWDwobnkCHc49Gr0pve6ji7mHLerdNm6SIfbLUzFN+s=;
        b=JiE/HO2enxoqD4ijyA1ZHLlkcGRa4ZG56kQidfLsnhtgzkTdE0lKSANDGvb8HZqlhT
         VdL3ggNnU1w/uaU8s82zHeiTwjj3Xdn5lxgA9ohcBL4pPqK3sVEbgB7M6tsd9suA/vCn
         oT8ux7/lV/OGmGjejNnlcF9BOEZwTEWPFWL8/3jwHJFrEEeNlIEiSw3iyf53ODrAsBCi
         vbnFAEfzhDayzgywQ5xkKyhsJF8jjNfSXduMHijxqHTRq4h+h5VBENHYd3jfl1+W9nvx
         HfHjnQpUwvvUiWz4cx+qFrbwuSEZkM7nAnxFzhQQwdrgFh7jHwUcx40ixmDRxMx92uMt
         +bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723683436; x=1724288236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWDwobnkCHc49Gr0pve6ji7mHLerdNm6SIfbLUzFN+s=;
        b=Fj75m676XTg/56/LZGrpN/zwBN1EGBmiO4MkpxQIKbQDeXbIL7xog+MWSA22LO2rX+
         tJ0HXzFKsP0w5olwUn8QqTfsQ2lRndOxwPBx+l7ynMBtmU1rr/88pu5Uv43WOeAevzDQ
         iNMAJKzu+A9bfnJQlGJKO6pnjyeP108h8Ec8btIvaS5h+I5URSOATpaAAuYYMYugCnhk
         gVnveUU6QNbimJ0wDHpNAis/9AiMhviTjEmc1eeaONrekuLhMtgwqHVC0kO5pUobGoan
         IDVPgJVVjl6yG3QxbSHQykvbmr7LhHYXj4o0lpIk3t2f7AVZc1iDeB1fySE17XpDTkwR
         9nzA==
X-Forwarded-Encrypted: i=1; AJvYcCXNEhAIKGiuwBohpLJJahE5YE4SUi8qMBer5px+stvK8oOD96h53xR+wf21ekcM3EgTM3MzOKgm8dpiPjdFegLsP5z63Jw033H63VZ1
X-Gm-Message-State: AOJu0Yyvs6ArD2cShnRf7I22+JP/BEbVZ7elRZKAM9v4XzhyNrD+asLq
	/yXlyj0peh4y+c4lzz01mAbFv4gizSBH/bhEMS4jVIgrTuncpsB9SnranlZseIg=
X-Google-Smtp-Source: AGHT+IHC66VEYQdljRuTuSO2x/zOwIVJbZPl2UlJTONTu2DLilQDdVvPTmdGUvtQ7FJ0ndbu7er3LA==
X-Received: by 2002:a05:6871:328c:b0:261:d43:3eeb with SMTP id 586e51a60fabf-26fe5c082a6mr5371911fac.32.1723683436253;
        Wed, 14 Aug 2024 17:57:16 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b63570a9sm164518a12.60.2024.08.14.17.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 17:57:15 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: misaligned: Restrict user access to kernel memory
Date: Wed, 14 Aug 2024 17:57:03 -0700
Message-ID: <20240815005714.1163136-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

raw_copy_{to,from}_user() do not call access_ok(), so this code allowed
userspace to access any virtual memory address.

Cc: stable@vger.kernel.org
Fixes: 7c83232161f6 ("riscv: add support for misaligned trap handling in S-mode")
Fixes: 441381506ba7 ("riscv: misaligned: remove CONFIG_RISCV_M_MODE specific code")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/traps_misaligned.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index b62d5a2f4541..1a76f99ff185 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -417,7 +417,7 @@ int handle_misaligned_load(struct pt_regs *regs)
 
 	val.data_u64 = 0;
 	if (user_mode(regs)) {
-		if (raw_copy_from_user(&val, (u8 __user *)addr, len))
+		if (copy_from_user(&val, (u8 __user *)addr, len))
 			return -1;
 	} else {
 		memcpy(&val, (u8 *)addr, len);
@@ -515,7 +515,7 @@ int handle_misaligned_store(struct pt_regs *regs)
 		return -EOPNOTSUPP;
 
 	if (user_mode(regs)) {
-		if (raw_copy_to_user((u8 __user *)addr, &val, len))
+		if (copy_to_user((u8 __user *)addr, &val, len))
 			return -1;
 	} else {
 		memcpy((u8 *)addr, &val, len);
-- 
2.45.1


