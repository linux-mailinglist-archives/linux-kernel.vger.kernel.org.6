Return-Path: <linux-kernel+bounces-426016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 575ED9DEDC2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19764163D90
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F761846C;
	Sat, 30 Nov 2024 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKy0FrVd"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4323A28EA
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732925671; cv=none; b=XrM44/jqOfxgCzRsAS+12vTg2KQGohHE8uJIQgLZktukKVHuh+u+2uHl1YdF9/TZrPecFynD4/vuvnpu/50K0y07qU1Dy8yieLwujO5nek66hI0Vx3BjDqSOMc6m/avL3j6tvgn+QRHVt71xOQuHWRgso9BOLZMN4Ur+OXKIx5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732925671; c=relaxed/simple;
	bh=MEF9DxNJa8aYJ5cq2tp04ev4Wc7/xbftCxnd8fnJ2a8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QYuEDYCvXJKKWGMKkWd6KI1v/HvnMdG1mZ1snGO6jIb084WMn6wizeTQP0Xkf/t/r66R5MiGlkUU45Ne6bOZmcqtwphj2X65vQP6zvhEP8UNfeih3o3cTktqyWSqv0fTwGQ6G75OiWXPbYtGIrEGrMW2XSKvXs2eG+3hO+5MH84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rKy0FrVd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7fb96d3a3a8so1700340a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732925670; x=1733530470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpxKrm09+SAPJmqxiOga34L0FlTVIOyjiLSP0mnmo8Q=;
        b=rKy0FrVd4msxohX3BnPXxJj+kqvQLTzfn1riFXVb78Ms7oi/45bHlQwdFdUO2CjBMI
         qvW8b2jQa54vCLdzwswus4FGhAsyUfph6wTFtdnT2WdoOYOGA3zSZhY6C+a2RV/esbvs
         nXmNROGTskBoLT3hA9UmfXlGlQeIE9mA4TIBg89HXcjGrLvzOi5VlBnCan7wYTZSFSNr
         ZTa+yq5PuzS5JfdmOv7SQw+tSf3Fh61E07HOyOTeOntqRTTD2h/XZHadz5bZwApC+Ubb
         6ujBaiSoXsxvhmpIuVLT5V6hVixqRoGBS9FMRwkv+CunpZyNK01yo8IghRv7Q+57w1VR
         ByIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732925670; x=1733530470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpxKrm09+SAPJmqxiOga34L0FlTVIOyjiLSP0mnmo8Q=;
        b=uciotrP1blFU3XJFSB12BRBL7/ayMzPHdZf9D7+xuUh8oK3PGzwJmlN8NO1ZVkQif5
         NCfFtkj1vDUM8F3tBUdivErRYMFyGU+WQ1xGj+GfmnRXQ4NOXAZFzzcH8hQdB68+gHtC
         DwUZzuFSb2HWaFbXPP531uUiS2mlm19XUnqRHOLQyW49AtEUYYoC1U86p8B6B+8OJKzT
         4kfPeJwGwcOnKZU+G7YFdNuwhVX2efe1DqZ8yUu77eE2YgPfzbwM+nASiTwBPvgntG3O
         PAmrvYDEcOrY1/3rUw8mGcgNZhyDV2XhAOcx8ZqmrfusFBu/rSvShvPocuH0rp1xP2fp
         SV+w==
X-Forwarded-Encrypted: i=1; AJvYcCXYje0kvPdNLf0LtZmeMrPZw6ycsRThT0HHyZA/Y/cYXxXEK9RXN7usuMHGTz74LOqTAXNzilSaUWBXN+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1KYz0cIoadlD3TkuKowQPfNIr0uoEP82dKII8QWhD7jm7kKo6
	6XXz5DZPf1Gjc5K6z7RnEnoIs20xOo4dVZP3L4uwSKQZ0n8w6Cn9hwDvjId/U+SmSkTg7aDiOlY
	+SQ==
X-Google-Smtp-Source: AGHT+IEO1jq34I3S812cs/LC0CKsK8aw91gm2TSktbeu+lByPR5ov0es7eD7kBYzK9Z3arRorDrO9sMmpoc=
X-Received: from pgvz26.prod.google.com ([2002:a65:665a:0:b0:7ea:618a:6e04])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:99a5:b0:1e0:df27:10b8
 with SMTP id adf61e73a8af0-1e0e0b52839mr22679442637.31.1732925669775; Fri, 29
 Nov 2024 16:14:29 -0800 (PST)
Date: Fri, 29 Nov 2024 16:14:23 -0800
In-Reply-To: <20241130001423.1114965-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241130001423.1114965-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241130001423.1114965-2-surenb@google.com>
Subject: [PATCH 2/2] alloc_tag: fix set_codetag_empty() when !CONFIG_MEM_ALLOC_PROFILING_DEBUG
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, pasha.tatashin@soleen.com, rppt@kernel.org, 
	yuzhao@google.com, souravpanda@google.com, 00107082@163.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

It was recently noticed that set_codetag_empty() might be used not only
to mark NULL alloctag references as empty to avoid warnings but also to
reset valid tags (in clear_page_tag_ref()). Since set_codetag_empty() is
defined as NOOP for CONFIG_MEM_ALLOC_PROFILING_DEBUG=n, such use of
set_codetag_empty() leads to subtle bugs.
Fix set_codetag_empty() for CONFIG_MEM_ALLOC_PROFILING_DEBUG=n to reset
the tag reference.

Fixes: a8fc28dad6d5 ("alloc_tag: introduce clear_page_tag_ref() helper function")
Reported-by: David Wang <00107082@163.com>
Closes: https://lore.kernel.org/lkml/20241124074318.399027-1-00107082@163.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Applies over mm-unstable

 include/linux/alloc_tag.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 7c0786bdf9af..f6a1b73f5663 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -63,7 +63,12 @@ static inline void set_codetag_empty(union codetag_ref *ref)
 #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
 static inline bool is_codetag_empty(union codetag_ref *ref) { return false; }
-static inline void set_codetag_empty(union codetag_ref *ref) {}
+
+static inline void set_codetag_empty(union codetag_ref *ref)
+{
+	if (ref)
+		ref->ct = NULL;
+}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
-- 
2.47.0.338.g60cca15819-goog


