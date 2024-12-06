Return-Path: <linux-kernel+bounces-435174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC4E9E7381
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B5616B18A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B61D149E1A;
	Fri,  6 Dec 2024 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hiySym7C"
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA11514CE
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498441; cv=none; b=tpmpLxO0Fb5LQHAhk+VFVd8uALNqujGec7tQsBbZzNNHJLWsWdYIr83eVltrDfkxV/7Byb07Va0g+5oujNwq+nurncKqYCMvxVed6h80OAyNFMMyUkE4Z9o39O+eNACreJQWuLmCtRTKsG4e8ZsCoQ+/27y79Eov1fZcZSghSv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498441; c=relaxed/simple;
	bh=QcIDdjDjRSw0EVFN1coNwQmYe/qyDdHlxbIJv9WpXu8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p4HEfOcBAUO3cM6v4ngqwmhH0OcQuaCfYMbZs5jbVqn5grDUXoUj/CGWoM0PaWpI4S9Mmj2EyEYyP/INd9cumt35oZL1uXjjZ7icHpD5YdVfEJv6pOiNhDQwUsfBHLXfgwCg7YyPEPQhN0go6nbH+bYLB5xBaloQlqCmJP1YMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hiySym7C; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b67aace1f5so647840485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733498439; x=1734103239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yx5dQ67QKROK4en9M6ES+ALddN2aYOQNxBy+mPlHr6Q=;
        b=hiySym7CxkhnjY+8irnyGvpgr2pu76BdtFAN4Qzx0f6Kf8W74UCwewOSHNZ6U8SAKH
         daX/DpP7V8LC9YeKrsymPROpJCkD09nn8V+iSAnHFsMupLFllfXYl3o2O5INbtV4tWKU
         m1Inft1AYnXRnOj6XPfNW6AGTAb2XHaEk/27NI6Dk/7YAGOhCoIhVr7VVLMmJI5YbP2u
         bgtEilQVt/2GSnmPJYsm7vtz4epwq6GyN7U8313J9Pqff36D1rgD1qFFIRBAEj9EGykU
         w0sue1qDtV/V0EiiGokAPMAk7TNlePG/Ag7AWi/9nxTQjvvmuXpKW7QbEZTVOT97QEfn
         aM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733498439; x=1734103239;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yx5dQ67QKROK4en9M6ES+ALddN2aYOQNxBy+mPlHr6Q=;
        b=Eqn2DMem2w8AanIiDxZxYjv9EAKZPKCd06VVW5VocxCCjFUZO9cIhB4/5wHQjZaHl0
         HaPfy8KspSxKg/8OwxNTqu1/NPchFk3pW6Mwj3HH0hF2qvdAFGvC7MfKVf5h8eoI/OlC
         dxIkckm8Ekec60i4AaEAOx/AMWd8HwdZ5Yb55hAgwAB/iMM7s5HdGgV6Ct61+DoPeykI
         Oiwp+BKOyYfYLIIko0/cklb1htRO6HAs3EYOc26CaBgMMxcfLEzZglpBSZDwx9+YE1c6
         OLjJ6pSGIr5YFtVjUaDsD319yEjEaH1Ta1LZaTNqoVnhWUTkBUKQ5zSoMnOCtz0ISAcs
         SEww==
X-Forwarded-Encrypted: i=1; AJvYcCUPjsawK99RqlmOPrmhQAkpE9bs88S7EJDCqgKMP7CXTdvYJJf+6W22UK/9v3AITW1/Q8UEnm1t4einuO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFDT9uK/xTOz/yUPHUtXvHZEjnnI3mSiPPmr09saA8uSdOb5pc
	SKOxBT2+PbgHhQ7WUTUk0JB14bIfFKoJJRS93HsdDegpu6zO+zDMCyOj2Aisbg4VnbnvqaPSrW3
	Ta5gMiA==
X-Google-Smtp-Source: AGHT+IF/lfNniPN6wmswQiItjU0OXX+sV8hnnN//Js1/LASgX6OPG2uwCt1Xx3H4kK5M8cW8GQWU0rcRdU5v
X-Received: from qkc12.prod.google.com ([2002:a05:620a:4e0c:b0:7b6:7122:b8d0])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:4806:b0:7b6:6c46:556
 with SMTP id af79cd13be357-7b6bcaf1409mr527037885a.28.1733498439039; Fri, 06
 Dec 2024 07:20:39 -0800 (PST)
Date: Fri,  6 Dec 2024 10:20:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206152032.1222067-1-bgeffon@google.com>
Subject: [PATCH 0/2] mremap: Fix newaddr hint with MREMAP_DONTUNMAP
From: Brian Geffon <bgeffon@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"

mmap(2) allows for a destination address to be specified without
MAP_FIXED and in this situation it's a hint to get_unmapped_area().
This address need not be page aligned because get_unmapped_area() will
align the hint.

In the case of mremap(2) with MREMAP_DONTUNMAP it shares a code path
with MREMAP_FIXED in mremap_to(), which means this function can be
called in 3 different scenarios: MREMAP_FIXED only, MREMAP_DONTUNMAP
only, or MREMAP_FIXED | MREMAP_DONTUNMAP. In the second case when only
MREMAP_DONTUNMAP is specified we don't need to do alignment or size
checks on newaddr because they will be passed to get_unmapped_area() and
dealt with appropriately.

This patch corrects that behavior to match what non-MREMAP_DONTUNMAP
mremap(2) and mmap(2) do. This odd behavioral difference was reported by
Marco Vanotti. Additionally, I've included a self test to validate this
behavior.

Brian Geffon (2):
  mremap: Fix new_addr being used as a hint with MREMAP_DONTUNMAP
  selftests: mm: Add a new MREMAP_DONTUNMAP self test

 mm/mremap.c                                   | 26 ++++++++----
 tools/testing/selftests/mm/mremap_dontunmap.c | 41 ++++++++++++++++++-
 2 files changed, 59 insertions(+), 8 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


