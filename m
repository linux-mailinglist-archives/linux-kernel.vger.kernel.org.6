Return-Path: <linux-kernel+bounces-285597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C20951022
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8286A287F58
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC28416DEA9;
	Tue, 13 Aug 2024 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Rtir1nDl"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E151A76DC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590145; cv=none; b=irHt9v6RO/sGrvytrhBS5LAYsT0torpnyBGphD5XkWH5cPS6kz4L0YsNR4G1Z1CueepV4lkR6pJnIT6VeTcEeq1fiWj2kKmdfk0u228wD3i39lOs2KIUN1mzEFS+BkBHKDUBB2ZGy8how0FiwYhTIgHfp9+yFjgCuNlktahF8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590145; c=relaxed/simple;
	bh=XeL6GWit/pqjHiJc/lAmWKHdjpGQ7Hay1LB5z79tDoE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R2F4bO215B1ci4rKww/kTqdwe++ltFLG5oltqVOSwC8gPi8xd1bV7B8ssm7jXqWPXZSTswo5GMMIFNLkL1TwJJkH/sSG/OaXcO5QQHaM50mAuPfOw3i7EvNtT/o8nlEZsWBwWdNtVWYAsIaMHH90aZzIHh4pWdFOIso0L3j5v70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Rtir1nDl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201d6ac1426so2536045ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723590142; x=1724194942; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XQV0MiEWzTrgzO2mz9iNyCN7xzYIt4no8L46cKq432o=;
        b=Rtir1nDl0j0pPkWzaZiM1Ndx4ikQ38ZR6NWgR9COMyAX3qLLlbKUVVtXhjfDnehz53
         DvudJF28mq9F8BhcaQ5gCxjuvYNAazrihAq3PYcXtFHjdrdftN0Nk744l8KwRiANIQSO
         Vui/2OJX48lb5zX1y6+hH18o6tNeKdqAaY2SF0DT4rU/0RSWP6Vx7D88MDovgGLd2udi
         NLwgIe9XuIFJBERT5a9oveXIOwgmpVZ7zt7uUrmbSiM41VWQl+jh7WjLRsdUjMnkFt/n
         iMaCs1pEZFcCgLT4yMmpGVjb3cr2ATWlypBGGYirBikU4nL9cqAVeKrqlgx1sP2IVf+e
         RZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723590142; x=1724194942;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQV0MiEWzTrgzO2mz9iNyCN7xzYIt4no8L46cKq432o=;
        b=xQHIERN8z53fuiMr1mp+clsig79NXnMKu/dW05+sge52Eqm7D77N2toAR0g8HmoH0v
         ckrlmQu+0rIffQA7BEoxx0ezER4mdeD+j+HO8lqpTcxfd7QxVwEW1Ib09DFhQX2zZZLF
         947HhnDc9yxH54iP6ejwR65OdFUd51yXJe+iqAnCAVIW3N7pL8gmBm+02/kgmQsc9YU+
         cHNjc5AJT5Uh2/+qSJaxYGTLJvUotyORGcBgIy2YjMW8L53ID5+2htbNtkzucpE/iZSw
         puHXv6giUs0EV8cuV2F2I9PIgAQMf+bkjZA2zTkXzesYYX5wQHPVSOZgxEzDGg3NVsDB
         hpBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx5Taict46wRtyEtQPiR43DQb25pR55f+RY2abFlHT8D2v0wxkMhGTejMmGqlpq5Ne2YHzaNzeUhbL0ykJ2v1SIIgOH30ZQdiO1scR
X-Gm-Message-State: AOJu0Yyg07pxfKylBMc48HApfWNSNccpOYTBOMJuXyiF3SBFmskpswZT
	pP3aigPZS1vd8TAX5uE4w+G5nfiBOw++JemlH/Vl94UJgDt82JzsFcfUKKUOMPA=
X-Google-Smtp-Source: AGHT+IEg0CEgUALnAgG2Oa0GOQsbhFkD+FfOfT8UYpKAYuMjCeALF3gqTWEdHtfs4BiTRKmqmTRH9w==
X-Received: by 2002:a17:903:1d0:b0:1fd:a264:9433 with SMTP id d9443c01a7336-201d63bcb69mr10901115ad.29.1723590141834;
        Tue, 13 Aug 2024 16:02:21 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1e0659sm18522475ad.297.2024.08.13.16.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 16:02:21 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/2] riscv: Fix race conditions in
 PR_RISCV_SET_ICACHE_FLUSH_CTX
Date: Tue, 13 Aug 2024 16:02:16 -0700
Message-Id: <20240813-fix_fencei_optimization-v1-0-2aadc2cdde95@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPjlu2YC/x2MQQqAIBAAvxJ7TlitIPpKRIittYcsNCIS/97Sc
 WBmMiSKTAmGKkOkmxMfQUDXFbjNhpUUL8Jg0LTYa6M8P7On4Ijn47x459de0qjG99o6g9hhB1K
 fkUT9z+NUygdPKwdEaQAAAA==
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Andrea Parri <parri.andrea@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=XeL6GWit/pqjHiJc/lAmWKHdjpGQ7Hay1LB5z79tDoE=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9rup7+jX5jK+HTHn2h1NFjOsFy6TvLxppccbIU/Xh0JX
 HowMPdDRykLgxgHg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABPpV2Nk2D51+xbPPfvqiizf
 mM2972bc/v9e9H6rOu/SXXccH250s2P4p6nypyLuR3PSrhV/Oi/OmeaiF/dAZtbMnBaTktWs727
 d4gIA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

There are two race conditions possible with
PR_RISCV_SET_ICACHE_FLUSH_CTX. The first one can be seen by enabling
DEBUG_PREEMPT and using this prctl which will warn with BUG: using
smp_processor_id() in preemptible. This can be fixed by disabling
preemption during this prctl handling. Another race condition is present
when the mm->context.icache_stale_mask is changed by a thread while a
different thread in the same mm context is between switch_mm() and
switch_to() during a context switch.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (2):
      riscv: Disable preemption while handling PR_RISCV_CTX_SW_FENCEI_OFF
      riscv: Eagerly flush in flush_icache_deferred()

 arch/riscv/include/asm/switch_to.h | 19 ++++++++++++++++---
 arch/riscv/mm/cacheflush.c         | 13 +++++++------
 arch/riscv/mm/context.c            |  6 +-----
 3 files changed, 24 insertions(+), 14 deletions(-)
---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240812-fix_fencei_optimization-3f81ac200505
-- 
- Charlie


