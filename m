Return-Path: <linux-kernel+bounces-529054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564A8A41F64
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7FE16D8A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E7523370D;
	Mon, 24 Feb 2025 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujZR7r8g"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A981A3174
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400658; cv=none; b=ZEz0VPBrJshQlIL/BRBv5M7a+9zmTZxAQDQuo4YP7sf/0qQFeg1hZ7sXddWtzT5bIwDXiBhj125QKdAdKbdjeJlXerZA5J0+7gTQxEXKlGY+953/rgYRq1pPeFu+6M9HBPop7CI1MRFlr9b9KiYTV8oxSkutyQ4FyvgqRa2Rdos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400658; c=relaxed/simple;
	bh=tpsLiQBvvh1dTKZaXDFmn0uNMCVjMjU3wCLdgPa9BK8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W+ZiNymzjDGABZukLauViFyaAoZK8ODZDaEj9qCx9mGQQJK0HrokzzjgHMVeeR6kwkHlULFcXSgzADM7CJNpy5PVKhil7z56sTydqjlSVBvIceFhCT8rx6mMItCYcQmF06NwPMKXgh1uwMrOSpMW2rAtLS6yIAKfFtAZb7de/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujZR7r8g; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4393b6763a3so18326055e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740400655; x=1741005455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S4i9tf/f6bfU94cv5AGuCas1piVsAnCyXX7M6r6zNDk=;
        b=ujZR7r8gOvDei6vO22DDFfhjyKOhb9GWE2B/9G/+y0wH6LmcLhcXHlRyYJfVoQbXVN
         LfOn9WgirYyUAKTqdvpKrFQNwdgSwB7QXydb4wmFfVPwuV/OhplGca84bQ6hz4YQSRJ2
         99SnaWGuRQRkrfZiMQwuI5Mrk5tNef+KF5anHV9Mo+J+DIitJ2qrU39logaWXH/dWXU/
         l2SG791blszwcVaCsds9+6iLanudYgpLZq2JuhZAkN1Zz2/u5uX7faJe4OfvoazDd+xa
         catNlaYdzbfol82RG0BD2NEsl/sc8rLl75BAJ2TNNJYgMax+0FOVpsI749usOBITmnAy
         i7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740400655; x=1741005455;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4i9tf/f6bfU94cv5AGuCas1piVsAnCyXX7M6r6zNDk=;
        b=IL3Tk6aCN6/D/MZxsQ5gHA9SGot5LLzZV8DmHa8EJ+6SVemlXJ0BMR44pFnrcWgUL4
         f0byn9aW7K/y3KwIbV/fRluItrUw9ZUN5wTypcEzj4nCk0SxuKhgIM7dvpWPvO9uN/gW
         GEbk4sp8/iF7qjLyQhECI/tW7BCgnaS2zbuf/7IBxeSWZ4TpTif8mzTj0OAzqgh2ctGm
         2l2zLEMaCV3pImaxlvFbxqrJTeT2pIqwfEaCgENIVMeX6LV4Y3I9salo0OzJFCsq4tbb
         dzBtrDm0DDxxRU4s/L7HCv6wrvroD1QeYME2QS/m8cZU5vFM4X3RDLFQAW1LjGAnXREk
         +i9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxUBGVLcmipTYMFk0sk0GwtyotwwNIQR035+WpMSFCkKc/+DQOsQZYeQ//4Fvu8u1tqKlz1bO4yTeSYFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrgjC1qw1GzrGOAS9SXP8rqYkEDxDREdeqgE+4JRltgWxDgXIJ
	O6W8Piolc1Jr8UK8ofx3x7XLhTMQLw9XpjXvGL38RxZ3XyXUS/oyrz/BOOun8jyzAp2+QY72izU
	2mWN5jYhqzQ==
X-Google-Smtp-Source: AGHT+IGpuYdMTwjODJHxm9TvUiZMzV7BQbJ6p7j9FK7Be3VAsZxuWpWRwZmRvOhYL3JCaQ6xUVBulyNCXtUOZg==
X-Received: from wmbay15.prod.google.com ([2002:a05:600c:1e0f:b0:439:8e81:fd03])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:511e:b0:439:88bb:d017 with SMTP id 5b1f17b1804b1-439ae1d96e4mr108269225e9.6.1740400654949;
 Mon, 24 Feb 2025 04:37:34 -0800 (PST)
Date: Mon, 24 Feb 2025 12:37:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAhovGcC/3XMQQ6DIBCF4auYWZeGIRi1q96jcUFxwEmoNGBMj
 eHupe67/F/yvgMyJaYMt+aARBtnjksNdWnAzmbxJHiqDUqqVirUwgaT2O0ir2SCcErrvpdao0W on3cix5/Te4y1Z85rTPvJb/hb/0kbChTdMNnWTA6f3XD3MfpAVxtfMJZSvkxDlumrAAAA
X-Change-Id: 20250214-clarify-steal-f244880441c1
X-Mailer: b4 0.15-dev
Message-ID: <20250224-clarify-steal-v2-0-be24da656764@google.com>
Subject: [PATCH v2 0/2] mm/page_alloc: Some clarifications for migratetype fallback
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

A couple of patches to try and make the code easier to follow.

As discussed on the v1 thread [0] there are additional cleanups that can
be done here, but Johannes is already working on those. These ones are
just fiddling with the code to make it more readable, with no
behavioural change.

Note there's also a proposal from Vlastimil[1] to rework the interface
which is renamed here to should_claim_block(), I have not adopted that
suggestion yet but I could still be persuaded to do so.

[0] https://lore.kernel.org/r/20250214-clarify-steal-v1-1-79dc5adf1b79@google.com

[1] https://lore.kernel.org/all/764394d9-592c-4d68-8910-67362dd8810a@suse.cz/#t

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
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
 mm/page_alloc.c | 88 ++++++++++++++++++++++++++++++---------------------------
 3 files changed, 50 insertions(+), 44 deletions(-)
---
base-commit: 8df57ad4ed6209600ccd54db2357f75eb46408b6
change-id: 20250214-clarify-steal-f244880441c1

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


