Return-Path: <linux-kernel+bounces-233914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2280891BF3C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18F81F241D4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F56B1BE25E;
	Fri, 28 Jun 2024 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lrmcd0g9"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7647194C67
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719580147; cv=none; b=VTMWC0YWS7nwG4bnE8HeepxVE3b51oXrARRv4Hr1Xe/yJ1N2JDzD2RHfKzEY92DCVrPViF5ZUwGlc38++Y/JcXzVMwuH1tPIGYN0uy6wrKtHQftW7K+xIwRYDaDNnt61dprHE9LpQu6AxAflErSgvkBzGGQ0ToTovwbr0PMrEjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719580147; c=relaxed/simple;
	bh=zl74s81d7hG0VAoXPcFLozQA03d/WbDtSaSStG2lxpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D8fgAg/OX6//0zTepNjWgdh87oVbfXFC9YlfwRIW2E77AYcZoLIuMDZF3IjU9hk6cG0WWndSdjhpBhZZhUKUtkVz9VMEWAG9zn/IKwOgdA6xNUELOAuXhFqccs4Q5HxDgPHGCmsGZHfF3zHqRMSwBgf8MdIaGWUdVYO+SuQKiuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lrmcd0g9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7067435d376so447953b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 06:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719580145; x=1720184945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Dqb/vcu87ssIaU9jLdX0yVciHLHBURYh4ogzTx4dk8=;
        b=Lrmcd0g9QE7KkrsS+/7RakjgwBni1uvlzcfBqe+VWKbf9pwvYkxtotB3qq9tNaLf9e
         6o1PmvxmgZ/l92WbVwCVCvt8BLa9zwv67a+19R0bf2XSRmK415DAl63dtbZ6PjFEeI0Y
         bEiX4eneJ8jM/IgRIsDju0GYTo7aKcjDtM+LWR+CZZFh78dUr6HZaHAoYTOUGAnCnVHH
         dZkNvb+QzsCXHg5tdloM0iu4h+Plz2swkOQW64QMp2Rid7SxKV59gr/+ZsIPKm8zi6eb
         tlpCRfSBiQpEW0Dxr0QY/gCkbEkvP392IC3/dszvtfYWFsrGJMzVvN3zp3uNZDdpQ1qF
         hOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719580145; x=1720184945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Dqb/vcu87ssIaU9jLdX0yVciHLHBURYh4ogzTx4dk8=;
        b=mbPDDYwRvUPesA1TD3qkWivfJ3/63vr1boTAbcUsiclS96cBOLQhsjJwD1HPEV4my9
         yf1V8S1rPZ/KXhPFSnBwHI4ITunWT+cIPWvX1fvzTX95LXcY1sSEsN2fquh5dcw4cA4I
         0MvvyzNq3Z4zywfKg2tKBJaNIz3DU+wYyOjd67wrgh0X+1qP3AXeCS62o/w5SR2MZSG6
         Pv5YnsBeCRUhqLFzOeYcfWl40ay9JaIEVevoZ/63ymu4sYEXHAJ9rVljwde8esS3mQrH
         pDJv3uHEMIXG6TKr4qdISX12Mxz3HILpuUMcHZuLv/sALC1jPlAIO9831b2eq0bkgonP
         Txyw==
X-Forwarded-Encrypted: i=1; AJvYcCUnBbTjP+xTfLlCqLeqr2nQ6nRchSsttrS1jTyNSKZwAb7Xq8WeUWkAIxrV6VEJJEacnOgt0EBu1kuRWBzhxcbzB9/ML67OX1tOmZel
X-Gm-Message-State: AOJu0YxmSUBo98z8hK21w48izJOc473apnw+SYLIxmHJydToLKhyexB0
	EQYP/TtM8MRDmNovyFxIze72UIjZQiKnoFp34CB8qSIUygtfVpmK
X-Google-Smtp-Source: AGHT+IE9Mw8tUccks1X22LTAcueisioIwesDxH2vHDyUsIrvhscRuqzeUaHatmmha51tRN2JTA0qDg==
X-Received: by 2002:a05:6a00:2e96:b0:708:41c4:8849 with SMTP id d2e1a72fcca58-7085223cda8mr2632099b3a.9.1719580144715;
        Fri, 28 Jun 2024 06:09:04 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080498946bsm1526102b3a.200.2024.06.28.06.09.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Jun 2024 06:09:04 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: dj456119@gmail.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	libang.li@antgroup.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v2 0/2] mm: introduce per-order mTHP split counters
Date: Fri, 28 Jun 2024 21:07:48 +0800
Message-ID: <20240628130750.73097-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Currently, the split counters in THP statistics no longer include
PTE-mapped mTHP. Therefore, we propose introducing per-order mTHP split
counters to monitor the frequency of mTHP splits. This will help developers
better analyze and optimize system performance.

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
        split
        split_failed
        split_deferred

---

Changes since v1 [1]
====================
 - mm: add per-order mTHP split counters
   - Update the changelog
   - Drop '_page' from mTHP split counter names (per David and Ryan)
   - Store the order of the folio in a variable and reuse it later
     (per Bang)
 - mm: add docs for per-order mTHP split counters
   - Improve the doc suggested by Ryan

[1] https://lore.kernel.org/linux-mm/20240424135148.30422-1-ioworker0@gmail.com

Lance Yang (2):
  mm: add per-order mTHP split counters
  mm: add docs for per-order mTHP split counters

 Documentation/admin-guide/mm/transhuge.rst | 16 ++++++++++++++++
 include/linux/huge_mm.h                    |  3 +++
 mm/huge_memory.c                           | 19 ++++++++++++++-----
 3 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.45.2


