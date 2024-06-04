Return-Path: <linux-kernel+bounces-200480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9978FB0A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025E5282A44
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F065145344;
	Tue,  4 Jun 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNlI/P2R"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1118438B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717498800; cv=none; b=UP2I9j/wJzGhezXWtR9nRnpdCd6mUQQipShKHFvJFc3j+0h4VpTcsrYTuSj2k1+KZFOLzXycN0x2i97lWFjSpeaOLMja1U/c/UFDSCwI6C6tnZM80vjwJPdI6nnZ0C2MI7CBs2tSCn7XR4S+QJmPPRyS3sF4j6N/6pasQrAXxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717498800; c=relaxed/simple;
	bh=amnDFGwyL8uOismLvNn1tA/X/od12bKgrqZzAsB0a+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFR1DAaQv5Tss19MClegr1f9wv9ih/wjV8L0bN7xXjZi9CWGhiX50iae/J1rroaT4UACWogG46wzfcZXN4FrRCWJUkjkLGv285bBz65a7f/Lv8XPMiCeFgwS7CE37Gl5hI18/OwuVPlI2erkJZqcP/7OmXUOG48bsKyh90epeVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNlI/P2R; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4401151aad1so13725701cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 03:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717498798; x=1718103598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=765VyAO8rMxFRoAXeQsS0GGMGSzxOxaKvjuw/yslhkE=;
        b=mNlI/P2RPoSL2xnjhjU7VloJwjTUxBNcEAb5/jFa/NC3wIzfaR1N3zC6XPIbgCgeYm
         Of7/6eh6sLUftpY4Wljjkq2vVny7p/k75zaX6AnNQsbT7dADkj/w08uXkpSPXegm1gec
         mpjDYF+QtViWBherTenZeBGkwY2TLM88MLYDBuc/VQVMSDsgHFZ5h/UsU+bP1lC7eyjQ
         ZHvZZudgeGBSa9+HVtizDePlV0fy2QauJDsuBWmwqCmfMcw62H/ZnfyibVR0AT7zvRTA
         h/msDG4ZKOMWtBbZ9UMsHRyC6YN7dBm/aPJSZGNP9snPHAhUHrAV/CvqdRRlfUd9qOV1
         IwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717498798; x=1718103598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=765VyAO8rMxFRoAXeQsS0GGMGSzxOxaKvjuw/yslhkE=;
        b=pqv/z0PWEanX42o7cxMxw0v6gaHSryPmR5DciTcjGACUFyS6lYABoJouTD65SqFCmZ
         2L5Sks2Px1rUpuCNqUwSmtnP34DOEEvllTn6G8z7T4hCOU6qn7UfHneJSfyLsDNBhdv+
         Ma1QPPaTfbrNgmn9GpfaqwbJ5L3iNFBAqECELsB66dJwa4oyehr0/WwWz1cDmmbXqxqd
         6J4n7yplcRMtQvsYusUHf4do9Ec4ar3xpwjWuFDeSSuXYdjuoH/lNz+PdFPzjezyPZcj
         FtNn0iWcfNnlTm6NXptyTwGge42L1//m75q1YF6KbqpV71L7j7ib7x8UKNP8HLNtevNa
         Omxw==
X-Forwarded-Encrypted: i=1; AJvYcCUx1ASrJxkZD8gBKLnGHs8jF2A4Y3DZ357efFYZvld28qZoQqAMgwqnhtUi3KhA8iVlwrlvWcZpLlo8mRaIpCsnW0F+npxWwLqg1g52
X-Gm-Message-State: AOJu0YymXAkKnrqGVCoR4WBvr9usB4Yrenr7sDL4OigIPX5JrNNgA1xe
	XyFsbT5/RWSG1KUF0yvDviE16Il3yJ6S1qt8FIIY3mzcvxDLFGey
X-Google-Smtp-Source: AGHT+IGRq7Z/tZzmzbxwPgvYQ88vQLH6cgxrvrynzg4ONUZbxlUOaP4A/wV4QoQXBgJItdB5ro4BzA==
X-Received: by 2002:a05:622a:215:b0:43b:1472:1671 with SMTP id d75a77b69052e-43ff527c3b9mr103889381cf.17.1717498797718;
        Tue, 04 Jun 2024 03:59:57 -0700 (PDT)
Received: from localhost (fwdproxy-nao-119.fbsv.net. [2a03:2880:23ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff25947b0sm48234141cf.91.2024.06.04.03.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 03:59:57 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	willy@infradead.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2 0/2] mm: clear pte for folios that are zero filled
Date: Tue,  4 Jun 2024 11:58:23 +0100
Message-ID: <20240604105950.1134192-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As shown in the patchseries that introduced the zswap same-filled
optimization [1], 10-20% of the pages stored in zswap are same-filled.
This is also observed across Meta's server fleet.
By using VM counters in swap_writepage (not included in this
patchseries) it was found that less than 1% of the same-filled
pages to be swapped out are non-zero pages.

For conventional swap setup (without zswap), rather than reading/writing
these pages to flash resulting in increased I/O and flash wear, the pte
can be cleared for those addresses at unmap time while shrinking folio
list. When this causes a page fault, do_pte_missing will take care of this
page.

When using zswap, this also means that a zswap_entry does not
need to be allocated for zero filled pages resulting in memory savings.

A similar attempt was made earlier in [2] where zswap would only track
zero-filled pages instead of same-filled.
This patchseries adds zero-filled pages optimization by default
(hence it can be used even if zswap is disabled) and removes the
same-filled code from zswap (as only 1% of the same-filled pages are
non-zero), simplifying code.

This patchseries is based on mm-unstable.

[1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
[2] https://lore.kernel.org/lkml/20240325235018.2028408-1-yosryahmed@google.com/

---
v1 -> v2:
- instead of using a bitmap in swap, clear pte for zero pages and let
  do_pte_missing handle this page at page fault. (Yosry and Matthew)
- Check end of page first when checking if folio is zero filled as
  it could lead to better performance. (Yosry)

Usama Arif (2):
  mm: clear pte for folios that are zero filled
  mm: remove code to handle same filled pages

 include/linux/rmap.h |   1 +
 mm/rmap.c            | 163 ++++++++++++++++++++++---------------------
 mm/vmscan.c          |  89 ++++++++++++++++-------
 mm/zswap.c           |  86 +++--------------------
 4 files changed, 158 insertions(+), 181 deletions(-)

-- 
2.43.0


