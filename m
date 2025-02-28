Return-Path: <linux-kernel+bounces-538219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00073A495F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6615916AAEB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855B625B693;
	Fri, 28 Feb 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M8SC6hRH"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934425A2DE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736344; cv=none; b=gbDl/pFQNn8GmLmD03Dwbweak138AJtGb7f5TXTHcg4MBMbSsQDQ/j7LTXqabg+5Zr9GVw2e0n18Syf9K7AwUlAe1MIgCnvkG7bLV+Xjv+Nkf5tHGF7dN5arVgJDVT9zyfdHQBG53ojwngJJq1pIqU1eAxsqFsiZO0lsDVwVTXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736344; c=relaxed/simple;
	bh=3Kn36LbYuhm9RIR9p9Dr/OQ4uSVbxLc+woq9AQFIKUU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CODJIq+FMcpcSQ0qbwBF4dne5sG26AZD1LaNxpsSlVDuMDpZ8tx2kXK8sLg1Hc19Im2CeQ7CRGz3BBzigefw+1f+YYbnr5QWbCC2tBdp/JBXfeJej3JEcQCea4NlE8w95BlWVwncMDs5AJVhOJUfr6mK2lGmRDsRCpZkxtHHf1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M8SC6hRH; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-390ddb917abso941374f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740736340; x=1741341140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d5mt9J8i4m5w2763+5K6yjHQ01GU+xDy5TZM3dXejFg=;
        b=M8SC6hRH0qOUzIC1ijuuyBcVR6tab9ESiNT9JXmg9QRfo7Lwrwyqcm/jjcgQYyj2E1
         XXw2wwlLdzR+WVN+ixEpaKreduZtjVZryxTx9MpE0grgXu8lU5Oah32gpGDpkrz3Bklp
         +1ELuzedxmkgE9Ggy/VNHl7yVgzZDJQcvW405M9HI5yo+qWooSQ5ceKR32F6BDR++ASx
         PI85TSu1zUawtbHcC1V9XxlFVHpgbxrChm5G+KF/EGJrs77FhBNDFOH02ku2OUcCknIu
         MfPpRQB6nmMncFqiad5HN/6wXUt5yiIWAsmw1yKye/qN6bcxCRzAuJyrf1YV5jy4VAu7
         RjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740736340; x=1741341140;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5mt9J8i4m5w2763+5K6yjHQ01GU+xDy5TZM3dXejFg=;
        b=tskk0BYoeNxLv1rB1XS6kxq/2gFyNU+EuEffImo9iugFI/Mx70xoNAMa/1VDAnLTLG
         SvCa2hqFvu7ikwupdhY2TthZOf+7+sVupFDo/pMHDBBYYUjzVxrJn6QpR26n3KgtMv7d
         OXs5siZe4W8g7KlvrgwpBpZRU+xaDBsVrocqSaYaEYN68hzGcnL2PGWCoocya9ls6DN+
         dThTxJW83lZIthdBhNbtdw5KCjqD7ZW5Sfnth8gJ7x5JjLvBff7cGAnWLMEcdL8zRyvS
         P++QUJfa9ZXHShychSRBaKkHeMEoip//Miq7Ow+vQagAeM7tVUGhNQC/xczK33LmEqYJ
         vh2A==
X-Forwarded-Encrypted: i=1; AJvYcCWhYGbXqd6DV6fACnmpBxPjGZwNKj62ggAn/9tEFI4UIJAFzU+mI5ihuUKx7Q1XVQb08B2hRR0baG1RgTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUqP3wDmnQvy3kKbz/ptS/guK9/sLvO0xU2zKaFL4/x8mgkkhX
	u88/odLwTYg7DYGWEI099QLyUfm+D+SR038DtwnUnTz8tMBxy2lI92Ek3zh686evk8CTK32Idui
	9ZN/MrdHkJw==
X-Google-Smtp-Source: AGHT+IFhvyhBMDqiCFk0cQyiG9hDs00X+P9w8OzFkmfuBdj2kS5HdpmNO0Wf1SLwxTzA3xHz763DJVjmvMCnwQ==
X-Received: from wrfu11.prod.google.com ([2002:a05:6000:38b:b0:390:e2a5:14b1])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1447:b0:38f:6697:af9c with SMTP id ffacd0b85a97d-390ec7cac67mr2126793f8f.6.1740736340671;
 Fri, 28 Feb 2025 01:52:20 -0800 (PST)
Date: Fri, 28 Feb 2025 09:52:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFGHwWcC/3XNTQ6DIBCG4as0rEsDI/jTVe/RdIEwKImVBoypM
 d696MrWdPlN8rwzk4jBYSTX00wCji4636chzieiW9U3SJ1JmwADyYALqjsVnJ1oHFB11IIQZcm
 E4JqTZF4BrXtvvfsj7dbFwYdpy498vf4rjZxyWlRGS2Usr4vq1njfdHjR/knW1Ag7DgcOlNEaQ RiVy7zIxYFney5/eZa4BSkZKsN49v19WZYPIe5XAykBAAA=
X-Change-Id: 20250214-clarify-steal-f244880441c1
X-Mailer: b4 0.15-dev
Message-ID: <20250228-clarify-steal-v4-0-cb2ef1a4e610@google.com>
Subject: [PATCH v4 0/2] mm/page_alloc: Some clarifications for migratetype fallback
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

A couple of patches to try and make the code easier to follow.

This is based on an old mm-unstable as v3 is already merged there. Base
commit info is attached below.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Changes in v4:
- Some more precision about "try to claim" vs "claim"
- More improvements to the commentary text.
- Link to v3: https://lore.kernel.org/r/20250225-clarify-steal-v3-0-f2550ead0139@google.com

Changes in v3:
- Rebased onto mm-unstable to get on top of Johannes' cleanups:
  https://lore.kernel.org/linux-mm/20250225001023.1494422-1-hannes@cmpxchg.org/
- Fixed missing renames
- Link to v2: https://lore.kernel.org/r/20250224-clarify-steal-v2-0-be24da656764@google.com

Changes in v2:
- Tweaked some naming
- Added clarifications of should_claim_block()
- Link to v1: https://lore.kernel.org/r/20250214-clarify-steal-v1-1-79dc5adf1b79@google.com

---
Brendan Jackman (2):
      mm/page_alloc: Clarify terminology in migratetype fallback code
      mm/page_alloc: Clarify should_claim_block() commentary

 mm/compaction.c |   4 +--
 mm/internal.h   |   2 +-
 mm/page_alloc.c | 100 ++++++++++++++++++++++++++++++--------------------------
 3 files changed, 56 insertions(+), 50 deletions(-)
---
base-commit: 801d47bd96ce22acd43809bc09e004679f707c39
change-id: 20250214-clarify-steal-f244880441c1

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


