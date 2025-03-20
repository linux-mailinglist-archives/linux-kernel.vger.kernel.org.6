Return-Path: <linux-kernel+bounces-570485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E53A6B12D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567E1189D77E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB8E227E9B;
	Thu, 20 Mar 2025 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="F+17PrB9"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72FBB664
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510668; cv=none; b=uPNSqMaBuJACWMFeZjvCL4LoVxj2L45jIiT1qFJr23jVXgbe1YBEURne1Ub3Gg8eXxsBLeiW5tIsdCEbRGAq34ITk8rXLM6oy+K0u3tc5YrTuZJ1F4wMtKZ0T2JMcUg/jDgsz/d3xU9ofHXe3UAkoxhq1wGJkTaTZydPAzbAwbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510668; c=relaxed/simple;
	bh=K5bNxzT+yW5E8QX8elpSAyd8FsJ83FmM98vDGXUMYSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WCZtKxAVXSL/4ICPuY6HPLtXUxBXUy0ZnKlkxHEkOSeqf3QPU8fvCyjcZnXJtv5rgIrzFGXbzSLI8ivQW3Ti2lGfqWOngSnHEy09Mdf3QBfk9eExb+c3dbhwueVq/kZPI7nFM8Pdw05QpiRWorHTTNX6JtmjqS4SXspF3mX6mRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=F+17PrB9; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3feaedb39e9so391000b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742510665; x=1743115465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8SFfZ8SQ++q1U43zBVQpg0YMcuwUtwU9gjCvKh1RgaY=;
        b=F+17PrB9X98oa+SXJCbz3dK/v173WgukTr+ywiR4tfKNWMfZlmdr6ibrXvaX8JwCe6
         lN1QlSuUxdwcDhc3AVpd1ER4TvF7lZYaU5GYDIlcYNyL7EReyZF+rWqKD4uYtCDU2g6K
         mOVmPcS1fnAx/EFPTyvUVJvj+td6opabDbfdaaiBYMCxKpV+0Vs4QknNR2dMvHpwfaWT
         v8ivFn58HSjw3gSJ0vzri/LqoUr58Yk234LoXKgErrmoTsRiIrPWxmne/QyMKv5cpZq7
         DE+pEY8bKyIK876JhiI9/TO+okIXBwdzqnWsHqBS+rQHzg76q9CsDdd+kWqrDuB8+TWB
         3nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510665; x=1743115465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SFfZ8SQ++q1U43zBVQpg0YMcuwUtwU9gjCvKh1RgaY=;
        b=PuxxSYQWb+mnP8OVHi5kQ+WHKBY41wVrOZx3+gbkNU3nb+euM5mD33bkiU/+zBY72a
         p0tRPESXia0ecEqczvsz6i1mg3Ii73WgJxhbzbeRezVxabwLFC+omRJUCynbz2PQ3ErB
         p5021xoGTGZyTZ6FI6bu0fBa0RCeIdJj4qiaWhKcB03KiOfQm7FLP30E1sYiOkFkcxDC
         SUBEj0RoBrwdgMYESH4dEG8+EqaQzKJluc/bEdUUULtRqTCkd7p/HsGwIp2PhV6u+ONZ
         6fNV+LLcKUk+yFMsFq8ZnD1279n6dOiADAHCR/zX4MMDBFOm7jVEmQP2xQMIHMDT/r0O
         4e3g==
X-Forwarded-Encrypted: i=1; AJvYcCWOoXInagf9e0verC3pkYpTmvZRdRH+PbB2WLIXxXu2iEQskk3L4QWOVd+bW/aZz2hXsYduVE71lDXF6MA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+VHS8Tg2u376Q7hKyi3k2IzzfpO1YsXOWPjnBB+WTES3osfvY
	jYyhytXTWQB2tRXYKORE9aMDd8SC00voAzgumv0Tx/nzoKXWD0bhQdq9Ppy5fg==
X-Gm-Gg: ASbGncsFWbXeW5KD2zOd3n+gpt/H2cOAm2wQwXM13xnTZynyDsJ885rcpRJgNseoJZt
	MwpzHOhcWd+HUNhDg+7r6jYemixRWHXirMjAPYqH2RtiL/2IAcp1vHQ/whdKmdW3uBcytv1/+DP
	NzrY5LtmBPD4W/wdE8F9zwGSoZJwab1tUB1Idm5V1Oil05T7HpM4xHaEaPJUSmtcFEOmklE5LEz
	05ELMLn/z8EnmPNLcPFCrF/pgV/gOGWwoQPiDYxbzHj19Odza5kM2lL+JsBvur9MQZe/iAulkDB
	rPVZfn0JxOsQXud4YggNCqfQFjaJvWmnMuzqS7uYRNEDWUCVwc5yUTn0qV+xjhs=
X-Google-Smtp-Source: AGHT+IGD26THZoSitvwX/Ku6LnvKO2hX/XV09PCTifQuKV3OygKNloEFk1j02pnAYxFav3zAgUrsvg==
X-Received: by 2002:a05:6808:2396:b0:3fc:1f7b:c3c7 with SMTP id 5614622812f47-3febf714101mr614720b6e.15.1742510665572;
        Thu, 20 Mar 2025 15:44:25 -0700 (PDT)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf6dcc09sm103524b6e.12.2025.03.20.15.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:44:24 -0700 (PDT)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paul.walmsley@sifive.com,
	charlie@rivosinc.com,
	jrtc27@jrtc27.com,
	ben.dooks@codethink.co.uk,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jszhang@kernel.org
Subject: [PATCH v5 0/5] riscv: uaccess: optimizations
Date: Thu, 20 Mar 2025 22:44:18 +0000
Message-Id: <20250320224423.1838493-1-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series tries to optimize riscv uaccess by allowing the use of
user_access_begin() and user_access_end() which permits grouping user accesses
and avoiding the CSR write penalty for each access.

The error path can also be optimised using asm goto which patches 3 and 4
achieve. This will speed up jumping to labels by avoiding the need of an
intermediary error type variable within the uaccess macros

I did read the discussion this series generated. It isn't clear to me
which direction to take the patches, if any.

V2:
I've taken on this series as there isn't any response from Jisheng. No
significant changes other than build fixes.
- Fixes build breakage in patch 3 to do with not having used 'goto' keyword.
- Fixes build breakage in patch 4 on 32bit not having delcared __ptr in the
  macro.

V3:
Significant commit message rewrites.
 - Corrected the justification for patch 2
 - Better explained/justified patches 3 and 4
Minor code changes for legibility and more comments

V4:
Fixed checkpatch errors
Added a unsafe_copy_from_user()
Added patch from Ben Dooks to save SR_SUM bit on switch

V5:
Fixed mistakes in adding unsafe_copy_from_user()
 - Sorry about the noise

Ben Dooks (1):
  riscv: save the SR_SUM status over switches

Jisheng Zhang (4):
  riscv: implement user_access_begin() and families
  riscv: uaccess: use input constraints for ptr of __put_user()
  riscv: uaccess: use 'asm goto' for put_user()
  riscv: uaccess: use 'asm_goto_output' for get_user()

 arch/riscv/include/asm/processor.h |   1 +
 arch/riscv/include/asm/uaccess.h   | 218 ++++++++++++++++++++++-------
 arch/riscv/kernel/asm-offsets.c    |   5 +
 arch/riscv/kernel/entry.S          |   8 ++
 4 files changed, 179 insertions(+), 53 deletions(-)

-- 
2.34.1


