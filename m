Return-Path: <linux-kernel+bounces-436203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB989E8271
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 23:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5010D1884824
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA524155A4E;
	Sat,  7 Dec 2024 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1NgAXDcJ"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15DC126BF9
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733609729; cv=none; b=UjlleK1odnNlTxgLUMd6bKKM4BERC7bPU7dWChSJpVsHezzWvPcGn7rr5KjwPeYviQkOqHi8fEwLGEtbRgl1s9HFZnxiYBoiIcSyyNWCgnfjygRuADOYjb8CX8PvE4a2TliixVy9bBL2qERwWGwrCHT1mn5nIfmbQwfvormIqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733609729; c=relaxed/simple;
	bh=ECRWQS6SuMTTjmQ63I+FkeCk7oNweT/Trrfr2wUpofs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UlQCboLKqvcV6s5UuzZ581A0JAqZs3ePR+irKZvZrElrEYzR/2Hur3mU7pi3HGBkl7f+Wu9U9PFnnDO9/o1dVtitBlH7qyjGC6oTGtO3T6SpVEb7lFaOpbeHuH2UrFScZVsR9JXGaDf6W+ukW90BcHMH6uJ/PhEtg4ozh4ksKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1NgAXDcJ; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-29e525890e4so2990439fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 14:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733609725; x=1734214525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iYMLMKsYjKvyEkJr7+KniMm5yM50yZLPEaf04bZG/TI=;
        b=1NgAXDcJJaQKNHPnbe7laMNtSIMRrbjHiVeukywSwpQTeZI8i0d/Ad9dAiS4ISa6uq
         o3kOmB/cS8rTyTxL26bYQHYQGVxLe76za0GL8ny0M326O4J9Jjo16tXRqvEbisfTa+HX
         k9MIwlPHOf5ZB/gknCF+WDCytbaK7lS1NJwnbzppKicOFdIPsa4qwrrY/X7TKOcg+1Im
         qQMR+1RErYbZ5AByZMFB67ppZ1kdGrDZe07Nq8Wj6Lncyh5swAlE6hEXPwqEtVkZdcOb
         5P6p3wW8gMpYwhgjS17HxJ7Y//9BZddxDqvWu4RHmyBxBQP4QRtS2XDVBM2vBUQ2an8C
         uggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733609725; x=1734214525;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYMLMKsYjKvyEkJr7+KniMm5yM50yZLPEaf04bZG/TI=;
        b=SK55g0UVC/mTg2opjPruu8LhlqD732QR67TTugxkymHVLGfRFzrsDPcx4AT8y0C4tV
         Miexi+8ZwG55RkrE/kKcueK/n/+OZNm5up+18A8VII8YMAoHpu7YNLmA47GEfI3U/Cwq
         fRYF0QBC08elnQUUvmp+BGp+EFQENdMWChfbcZLOot3mnx84iD3qNdSC8PYinL0FLUBm
         Iau4pl5mBSJZ3vqUrv+DHDe4NknAwtiNQPNOG31H5XbT89OXK3LksYHmt6/LBbUpKWXn
         2bP6xN3wolHnjjAZekrRzTS4LVbxpCHNXB/o9mU5sxFO076XxmH6upCc5ujFHzpJdza9
         rPRA==
X-Forwarded-Encrypted: i=1; AJvYcCVGXi68+X1rgMqOuMvZ5wBy19rXoxUgZ9E3C39bvQSKtgI9an5Wc7gK0O1mx9yl5z4SYruqet5lhRJlMS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Gfe0uP/PNjnyvNAnDEsw7K4lrhUCoSB66Lkoas01ZwyWWlSn
	xkmQ5hstihlj3PPUMv/wGFuopBxn7jg3BJoItllQ2wzAojJ/pcirsrFsj5ddND3NVjgrytADl5v
	SFg==
X-Google-Smtp-Source: AGHT+IGkmSZBHwFVqtrTFBOi3OdNPxu1qwCT2x7Nl6fMyRUN+dhlfJDvko1xurBMQvNmKLZtB9t2kbRHEBE=
X-Received: from oabpq6.prod.google.com ([2002:a05:6870:9c86:b0:295:f44d:8dfa])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:be89:b0:29e:6c6a:e7e7
 with SMTP id 586e51a60fabf-29f733478a9mr7584044fac.21.1733609725715; Sat, 07
 Dec 2024 14:15:25 -0800 (PST)
Date: Sat,  7 Dec 2024 15:15:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241207221522.2250311-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v3 0/6] mm/mglru: performance optimizations
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

This series improves performance for some previously reported test
cases. Most of the code changes gathered here has been floating on the
mailing list [1][2]. They are now properly organized and have gone
through various benchmarks on client and server devices, including
Android, FIO, memcached, multiple VMs and MongoDB.

In addition to the warning [3] fixed in v2, this version fixes another
warning [4] reported by syzbot.

[1] https://lore.kernel.org/CAOUHufahuWcKf5f1Sg3emnqX+cODuR=2TQo7T4Gr-QYLujn4RA@mail.gmail.com/
[2] https://lore.kernel.org/CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com/
[3] https://lore.kernel.org/67294349.050a0220.701a.0010.GAE@google.com/
[4] https://lore.kernel.org/67549eca.050a0220.2477f.001b.GAE@google.com/

Yu Zhao (6):
  mm/mglru: clean up workingset
  mm/mglru: optimize deactivation
  mm/mglru: rework aging feedback
  mm/mglru: rework type selection
  mm/mglru: rework refault detection
  mm/mglru: rework workingset protection

 include/linux/mm_inline.h |  94 +++++----
 include/linux/mmzone.h    |  88 +++++---
 mm/swap.c                 |  70 +++++--
 mm/vmscan.c               | 426 +++++++++++++++++---------------------
 mm/workingset.c           |  67 +++---
 5 files changed, 375 insertions(+), 370 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


