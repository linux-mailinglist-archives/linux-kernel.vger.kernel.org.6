Return-Path: <linux-kernel+bounces-367607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1439A0465
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE541C20D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8696D1FCC6D;
	Wed, 16 Oct 2024 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pNvShRVp"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E31FCC67
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067791; cv=none; b=Nd9RQgwi/ALW9obKGsHqy3rilZxhwWzX5u0KFs9F8jQTb1fUd7hysvV8qZdqs4E9J1ka0gjB7yXseKO1uI2Fdkypp/uag9RA/88X4cmeYuA97fu3rWdA1bGkFT8ZZ4BnCbVI+bBncQFlj34rS03SZP3xPbyiRgJUPbmHeu54aNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067791; c=relaxed/simple;
	bh=NvYfaNEvvDYsB2/D2rW3W050VS/1HBI6DZFjWNSoKL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FFWbLTgAtE/jHmiu7e78ElKru9m/YX3MT4WxmLSSJG0zVi5NRzwY/K0H0ylBRv2wdU2XFCSmPc+09vg3YMVm+Ru3RUC0SZxOmLPSBk35Gc8EY0zlsfm7Ml/y9SQCBv4T4j5Kp7Ll178P5iTpjveKh0CxBaJkDALYx4pDpSR2NUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pNvShRVp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso4310642f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729067788; x=1729672588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FeYqk9ynM30um50YdbGX0Cpn4ob9BfFrAFXR3B+7qOk=;
        b=pNvShRVpxiqWGwZL3JD/OnCCLoWU5nyUcjBv0/uZRDoCKdQi2IA+BDJereRkYWO7+V
         W5ht+dqej41mP4imNa+GgeO3FzTEeHb0e6zLiq9UnBBbQG0rw7ayjUNvlCVDLPHE5Y6W
         XlO4ZEh6GJhQR79Hf8eeIvAwV55g9mfwUP7B5lp18k/xnZ/BYNCELjltixX/6uPEcGSZ
         ML/VM9muevBrKOPfdUCMvpuKV1W+0B/1zXajK/q0uHkKSq0Bju/HYTOihgwbgBLOUQkJ
         K7Z4Cygk61Lcez3OU9wLeEIlIXo9lrS81/Q+I38C1lm6W5XPY0GGsMffCjHhJnp9NxIf
         LJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067788; x=1729672588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeYqk9ynM30um50YdbGX0Cpn4ob9BfFrAFXR3B+7qOk=;
        b=SCQl3WCzzz0LgSrlOmiuVEQAEPb4HSzFwkPgUIcaevcfGUpZRa3zDIVWyeWVydakDn
         TnDr3zzAIK+wubCFLPySKeZOfwlFPxvR42z9sdheZSR9BJS0XaUiM/PlEFX1P7BU5FlK
         m48q1cWHyiSW7CwUnjrTu+5RAwSnRlg4uVs0dJag9xiCRG+aovvuiTfu5Mdpp1uU5eSB
         /M/oiCJXTbSAyY+GK+evWTdbLo9FwvhKlL/ZRkLtWb0MqwBuWcLcZ9O7J7CbfX1ugl4C
         H528ZJwyG45OPQqzSa9zUVM2sQ725E+2SwtzTa0liw3Nx0vd6jKuUS5b9s6RiWqcac81
         tDHg==
X-Forwarded-Encrypted: i=1; AJvYcCW0xeObYpTaSWS+31IgNa9iw1PMsi9xaLNyaiFRON59N93ORxrwc1lg3aLWHKpw6FL5NUgV6t/bp/V3IRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI49ImgenBd5D5Q4wzswERZ57srtebTpagNHGD98PS3/IOp/IQ
	UQOZkDW7Xpup5Za7mA+K1vX10syNqqnTgZowAb71a12mAkVSMS2nQcZTv8oMqOA=
X-Google-Smtp-Source: AGHT+IGNVbDoncQNJfiq09HJCM62LLWy45vzoC8aPLyFn5dzlzYXlZQ1XlwBkH1FA6Tc39+cvfCrgQ==
X-Received: by 2002:a5d:6c62:0:b0:37c:cfba:d16b with SMTP id ffacd0b85a97d-37d86d54839mr2073400f8f.44.1729067787698;
        Wed, 16 Oct 2024 01:36:27 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc123e5sm3692081f8f.95.2024.10.16.01.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:36:27 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Vladimir Isaev <vladimir.isaev@syntacore.com>,
	Roman Artemev <roman.artemev@syntacore.com>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 0/2] Prevent dynamic relocations in vDSO
Date: Wed, 16 Oct 2024 10:36:23 +0200
Message-Id: <20241016083625.136311-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Patch 2 uses a generic function to make sure the vDSO object does not
contain any dynamic relocations.

Patch 1 removes a dynamic relocation from vDSO in rv32 found with patch
2.

v2: https://lore.kernel.org/linux-riscv/20240705060902.113294-1-alexghiti@rivosinc.com/
v1: https://lore.kernel.org/linux-riscv/20240326113831.283025-1-alexghiti@rivosinc.com/

Changes in v3:
- Add RB and TB from Bjorn and Vladimir from v1
- Use -fno-builtin instead of the previous option that does not exist in llvm
  (Palmer)

Changes in v2:
- Add patch 1 (Björn)

Alexandre Ghiti (2):
  riscv: vdso: Prevent the compiler from inserting calls to memset()
  riscv: Check that vdso does not contain any dynamic relocations

 arch/riscv/kernel/vdso/Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.39.2


