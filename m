Return-Path: <linux-kernel+bounces-531750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B95A44469
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1FC17A7C92
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A28126E173;
	Tue, 25 Feb 2025 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfzffp7j"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089D26BDA5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497398; cv=none; b=q+Z6zwwfaYiQjD17lfzaAAF/hb84OeAN/o2pixqUep46eBvxvVLzJIgOOwvwG92/venHNnDnTJ+3CSzEDJ1VUrCVyZ9g7TY8uHEoAFwWWq2MNYI3JhNEz98SviEq/KE7N+QIiolM5L6upr20GQInQKDgJd9IDhxTWZ5WccrSmDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497398; c=relaxed/simple;
	bh=RLsorROFwBBMfUlu6ca/nd5YJGIqnKQsJnln5ydYiBI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MDE38Habk7Q3hNF8W7f+5Q7iH1kJK4dOit1yn0AZxnXk0oqUabRDI3mq4X++r465+kB/dT+k69vFHYAnQ4FuGsF21kBO3SzWxXbGwLE/r7uUNsY8Mgao1HUZ03udJMnBuGYX7Abn475uxAN2Rm3czHPufKxUsnsD+9T7oRX8Pis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vfzffp7j; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so29612845e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740497395; x=1741102195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J8OYSBSiWmuORPMaPvvvkcx69CZNTKOmuoq2J/BinMQ=;
        b=vfzffp7jxqoTLerybKceRbaaTaM9MkSE5uieISgEcBQ6XD0mCGwF46kz+VWn+88EzA
         rUqj063NHXTWeOBQnSmpSZpYbvLwI9QPbusyy7MZpZFf2W6e8Zjaw0b++1/LI6EXUjJC
         qnFhQfpopDrhuqIq6q+6/yUUqXLdPGp44/Ze4KbQl3BOlZRTLazd5y+x5RyhLSVhO1u9
         GvSrP0/fHmDolBQsuaZd27I849lBW16IIwgJAcN556SfCzAI0KDsazuEP7RTlKIl/J6X
         Q7oMEvCWcfv+5Cp70uHQecEcHFyXKfIuaY4Y2uuGp2fjOFzfRf0kjJAfK0z/aQLaqzrX
         Qg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497395; x=1741102195;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J8OYSBSiWmuORPMaPvvvkcx69CZNTKOmuoq2J/BinMQ=;
        b=SV8jS+JskgBpnyh1uc3xSbG8mEbkZ6Ijj6dqqS6Yh6wqetlaukNVjt0mvfZsZlkJXa
         1WEwVty1bTT0KHEzCs8KOWxJ2f7q/8G3bdFscymWtYoTo6sIyYG9duHwBv7+QniSRW8u
         tJD6TVhWRFbv5QH173zXp/idfbl5iRfhVfvWfAmeYWF2KpsKJIlvJ/ljesl0qi1FYIkH
         DCXhAAjlJlIGptvbZl0ibiWMkOUWJI1mR6uezanD8SHhRirVc1lK/H3MiX5ctPN8o/ks
         zIatIaEyl4ObIQSvyCFbQMGyR6muBEcaI/ogqixZStv0iRNR7OCfFA7F+fXrkLJ0uXBD
         wrhA==
X-Forwarded-Encrypted: i=1; AJvYcCWZxV6RT/ueuaD7iXAPPaDDsDAOhX7s7YNingExSr1f5oYUKBSfDf6YwNA6Q8ColJbJX/7a+Q+FBTai+qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw4uEo5X4DdGOLVydmvn056FynEeOd2wpKbpW2LJrjJ9N+uK9B
	W6GeyU+QgqyW4znaKxMbnbLnpfasnZROqtrRYIK7zUTWSYZpBMq46QVy6JZY24PcXy6HIy997EG
	nSDw1xM7MRA==
X-Google-Smtp-Source: AGHT+IHaOjWXrfAn70S+bygs3HR7doHIL+V0Tpo6ZxQyuZusTOvcqMi9FI6lDjFvFVsyrT5UFP4/n/DOg4EzzQ==
X-Received: from wmbfp16.prod.google.com ([2002:a05:600c:6990:b0:439:9379:38c7])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:350a:b0:439:8e3e:b0d6 with SMTP id 5b1f17b1804b1-439aeb2ab04mr138373815e9.13.1740497395390;
 Tue, 25 Feb 2025 07:29:55 -0800 (PST)
Date: Tue, 25 Feb 2025 15:29:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOvhvWcC/3WMSwrCMBQAryJZ+yR5pj9X3kNcpMlLG6iNJCVYS
 u9u2pUiLmdgZmGRgqPILoeFBUouOj9mOB8PTPdq7AicycyQY8FRSNCDCs7OECdSA1iUsq65lEI
 LlptnIOte++92z9y7OPkw7/skNvvvlAQIqBqjC2WsaKvm2nnfDXTS/sG2VcKPHH9yBA4toTSqL MqqlF/5uq5vgEPR8+oAAAA=
X-Change-Id: 20250214-clarify-steal-f244880441c1
X-Mailer: b4 0.15-dev
Message-ID: <20250225-clarify-steal-v3-0-f2550ead0139@google.com>
Subject: [PATCH v3 0/2] mm/page_alloc: Some clarifications for migratetype fallback
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

A couple of patches to try and make the code easier to follow.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
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

 mm/compaction.c |  4 +--
 mm/internal.h   |  2 +-
 mm/page_alloc.c | 95 +++++++++++++++++++++++++++++++--------------------------
 3 files changed, 54 insertions(+), 47 deletions(-)
---
base-commit: 801d47bd96ce22acd43809bc09e004679f707c39
change-id: 20250214-clarify-steal-f244880441c1

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


