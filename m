Return-Path: <linux-kernel+bounces-206756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 398DE900D5B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9D8287730
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B2C155306;
	Fri,  7 Jun 2024 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMcEpWaE"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578C2D600
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717794861; cv=none; b=BUJSoOeLj8si6bN1r1tuUfYttEcNYNvE6FddLB0pwUKb4topHM7GuqIjpolUjr+qJEWka1AYe2AMuv/B7MnyurLP4P7W5WQWhyhXjxWERTDmrSgUs3vbqr0SEHCdNItwYUK/nmUO6HdykFWtHsBpKB/HhUggigdEscJ/go+NFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717794861; c=relaxed/simple;
	bh=xafOhFlAPGLrq1slliGFgBaJ+5TK9UaGi33bOcLbnf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ltoF0x3oU2VFv4/tN/hnhzAaSLCVZbsGovI5VKgiwO42glIudxWdgZBEGur6z1vJ28jFuBQhL9PwgbIUDlgkanZ7nIcC0xLwi3e0nfYJrOtT94q/LAQtb7iRWqnSwAW7ARetTFP0LdSrn36R5oqz180xvqt+PpPY5ShMOcCIgjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMcEpWaE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f6c7cded01so14781575ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717794859; x=1718399659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SgcxjirVqsAvgUPWOPPhW9cui9hZtZdtPFLjs4Py2VQ=;
        b=mMcEpWaEFOfmILXZro29xvbIv/nMEEh9M+SWVdWHyQ+uT1/ZDSpCRFLNHR8ANIDmro
         0ROdPsFEfZdOFLM1jWEYye70iv2U8Ev6Vz8PH5MoM7Q5M1QM4RS4KiydtBhp67lxZcKC
         CRgGjGH0U2p8VODhemurcax14tjS7D8QNec84tCF2Z27yIyO3UaQ49rgGBCA4zDgDRDf
         EiPC+UQp8NiCFEVlOAFEuSrVlKURe+I8z6FVzwB3xFfngJW9M6v14TBXJh67tOHehVjK
         3cXmgexq5JIcNGsOpn6vLdR0+kfjDAQkO3ZkT83svoZVwyqWQJ09FPxkq78PCWEFf4T2
         vB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717794859; x=1718399659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgcxjirVqsAvgUPWOPPhW9cui9hZtZdtPFLjs4Py2VQ=;
        b=w7wSMmXZ41BHN1FLNn6H4vMwcDvH87uPpsGGff5hWYahvCbiMdcX0WiVA2g0T1/4fm
         sAAqIc4X+QG2jRn2s6fnCe+nVma2+VFn6BG25OOGZw1ypOnLCNdw9zUd/M2WU1LOV2xG
         F9m2DW1x8M69dVlOX2ayDNf3aVrma9qXEC3WsfMpx933sRmCHgRAb7fvexqLX/oxCVtZ
         s9lQnny20o/3z+USYYViA4LZkvnPhs2n0b3Ap8jsCYNk4gmtXJNO663BSBiMxzeF1X1j
         5JsyRbonSksbUXbzLZ5ADXl06hzlgya/selXAlJYE1X4H46TyJbahQoFpr+wXvHlRSTf
         FkeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM+m4JSJxsGKsCM2QTmrosNNoSKxNla8gbi/DMKNq7vFHgPKE2dkxo8sTjx+racN127THUAavA3q3yZlKTbD+hTkUuWIItpNZZz3Tc
X-Gm-Message-State: AOJu0YwkpwuYp0umzoh1p1gIgFv71W1uMid8iiiBHSNagDKW91d0nVZa
	iaByQr8KuEW/qntyUPGhzs2hh/bIC6oWLAO8i/wx7xXlecRpSQrg
X-Google-Smtp-Source: AGHT+IHTd8X/qWpPzrmVP3cjEjhpM6LTclHmUzVMfHbR6wSNSFbYa4J+jFqkRsLLUl8yINr0c7mPyQ==
X-Received: by 2002:a17:903:1c7:b0:1f4:8faa:cd68 with SMTP id d9443c01a7336-1f6d02f1b75mr38515985ad.29.1717794859212;
        Fri, 07 Jun 2024 14:14:19 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6d859ea3csm17912255ad.178.2024.06.07.14.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 14:14:18 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	minchan@kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org
Subject: [PATCH v2 0/2] mm: introduce pmd|pte_needs_soft_dirty_wp helpers and utilize them
Date: Sat,  8 Jun 2024 09:13:56 +1200
Message-Id: <20240607211358.4660-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This patchset introduces the pte_need_soft_dirty_wp and pmd_need_soft_dirty_wp
helpers to determine if write protection is required for softdirty tracking.
These helpers enhance code readability and improve the overall appearance.

They are then utilized in gup, mprotect, swap, and other related functions.

-v2:
 * rename "need" to "needs" per David;
 * separate the change of do_swap_page() per david;

Thanks to David for his original suggestions on this[1].
[1] https://lore.kernel.org/linux-mm/baf84b51-7e8a-4da8-9662-3f5cf14ad6f6@redhat.com/

Barry Song (2):
  mm: introduce pmd|pte_needs_soft_dirty_wp helpers for softdirty
    write-protect
  mm: set pte writable while pmd_soft_dirty() is true in do_swap_page()

 mm/gup.c         |  4 ++--
 mm/huge_memory.c |  2 +-
 mm/internal.h    | 10 ++++++++++
 mm/memory.c      |  2 +-
 mm/mprotect.c    |  2 +-
 5 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.34.1


