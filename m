Return-Path: <linux-kernel+bounces-210931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F8F904A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE41C1C20F28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACDA2D057;
	Wed, 12 Jun 2024 05:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VK6KZBJZ"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC262BAE3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718168799; cv=none; b=rY1Y8yFViN5rK+5M8bmeAI5AzOT+oAcAhfoP8XI2FBnRizkkiXLG9tziI7FUUw8t2AhsnlRYFVPv8I2nAWidJFHmJ5q/8dsz9nVgTjM8he341pcgSKJG5Rz9RViZEpYvJZjKWFtjFCt9uTNAXMEHslMVZ8kLp+pAuY/d7kZnYN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718168799; c=relaxed/simple;
	bh=Vm+nM0PHiki+y35zCKm3VLSuncQiDq60EnZ8SU66lm0=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=Xl5yD98hQHlzXO1SGTO6MgnNX9zAJbG5MFqNpJbIrqnuI4wpIMuP2sBckZ7XmbsEMQUoiM0a5cy0FcYKj0CeEUQX2k7IuDffACsG44JS8PYK2SHuTQstK/t6Wa1xg7qQE+KMWTnopXuB0O0iM7Vx9Ifng1yKFji84ACIEmbWla4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VK6KZBJZ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d23db75f5cso218975b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 22:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718168797; x=1718773597; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AZZ7VrGQ5YNuXnqr8Kq8rpi6ACseFS2im/RkA+OveFs=;
        b=VK6KZBJZkRRojZRYc0+G8TUj3gch4W4utQMWZMW9UlEIqwLGAC8ai9DZ1jJIKWhtLB
         0+UII+bf8WNMu3QX8lYWCm0n1SsIbXFmujMWBy+E5QYcbQMJ0T6w5+L8mWV+bHbCZ1Ef
         YRJcxfjBZXnpZezhSEPMlQAB59lLbRKKBXEEZedKlhIPzbgZyyP31uTKjWO7egoRXrgA
         s4sRpItwLTnbto5HnadBPMoh4M0A78ojGMxKcIN10xuTkxME5dQCRz4Lgl9t6wf/Z215
         19KRveLaw8/mLhr0/Ky7f/aZCsDVtWMtg/AhgBJaO6CZfu/O+whY8JoY31ewL9xPROeT
         ThAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718168797; x=1718773597;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZZ7VrGQ5YNuXnqr8Kq8rpi6ACseFS2im/RkA+OveFs=;
        b=RxmypTPG5JrEVbbr/wR8BQlb7KeLz0b6wv0PmFzZLY5qQ7YUnb6gkP8qcViMoW6bbJ
         JjUAhx7cwk4E7lZaWojLl1/HMgIxmlL6vicm88qmzD518ISEmSnTqjud8nAWWdw+Kign
         LRhg4T01lcxDCfaOkge6efJBv8QgAR2+nqeYFi22DyH0OzfFTu8MwKBIpQhD1RGlcu2U
         rnJCLwoqgcgumyJUBYWJc2Uae18dRAI0NYEGOePvCUjdRFGPo5RqXKJ35R8uVsrqq5JA
         mxgNf1Ame1SlDJ4YIeTSTW100euWBeSyzu3/ELAVdC+z0OeLJMz9NXIdVfRYEtES+LCK
         czLw==
X-Forwarded-Encrypted: i=1; AJvYcCUi+JtJVZNtdNGeFKcuBe0xcE8lrHo6nNxS7oIXbXtN6E2Iys/UsZ7VpH+fK3PbOFsfioQ7T1+ZpcvNho0oZfTXJ5W/pwJq1h+cXR4G
X-Gm-Message-State: AOJu0Yx/ZX2rEv05eyrLA5d48g8oqwyh34Aqq4t98piR6lJ+zZISBFu9
	/nNcAXC87sqtj+Y2s7pL552jiCIt/I3Gc7YZRn74EUai9TJ0dtloV5KaWLLTKw==
X-Google-Smtp-Source: AGHT+IFMUaZ7yMvSMqeufNtIAUmrLen16Bxl7XyolcQW+Gd83s4MP2Pt4VowYhFv9QB0nNaBqVxjCw==
X-Received: by 2002:a05:6808:198c:b0:3d2:23b6:de9e with SMTP id 5614622812f47-3d23e0f4805mr925698b6e.58.1718168797097;
        Tue, 11 Jun 2024 22:06:37 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d23e9f1625sm90319b6e.15.2024.06.11.22.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 22:06:35 -0700 (PDT)
Date: Tue, 11 Jun 2024 22:06:20 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Huang Ying <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH hotfix] mm/migrate: fix kernel BUG at mm/compaction.c:2761!
Message-ID: <46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

I hit the VM_BUG_ON(!list_empty(&cc->migratepages)) in compact_zone();
and if DEBUG_VM were off, then pages would be lost on a local list.

Our convention is that if migrate_pages() reports complete success (0),
then the migratepages list will be empty; but if it reports an error or
some pages remaining, then its caller must putback_movable_pages().

There's a new case in which migrate_pages() has been reporting complete
success, but returning with pages left on the migratepages list: when
migrate_pages_batch() successfully split a folio on the deferred list,
but then the "Failure isn't counted" call does not dispose of them all.

Since that block is expecting the large folio to have been counted as 1
failure already, and since the return code is later adjusted to success
whenever the returned list is found empty, the simple way to fix this
safely is to count splitting the deferred folio as "a failure".

Fixes: 7262f208ca68 ("mm/migrate: split source folio if it is on deferred split list")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
A hotfix to 6.10-rc, not needed for stable.

 mm/migrate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1654,7 +1654,12 @@ static int migrate_pages_batch(struct list_head *from,
 
 			/*
 			 * The rare folio on the deferred split list should
-			 * be split now. It should not count as a failure.
+			 * be split now. It should not count as a failure:
+			 * but increment nr_failed because, without doing so,
+			 * migrate_pages() may report success with (split but
+			 * unmigrated) pages still on its fromlist; whereas it
+			 * always reports success when its fromlist is empty.
+			 *
 			 * Only check it without removing it from the list.
 			 * Since the folio can be on deferred_split_scan()
 			 * local list and removing it can cause the local list
@@ -1669,6 +1674,7 @@ static int migrate_pages_batch(struct list_head *from,
 			if (nr_pages > 2 &&
 			   !list_empty(&folio->_deferred_list)) {
 				if (try_split_folio(folio, split_folios) == 0) {
+					nr_failed++;
 					stats->nr_thp_split += is_thp;
 					stats->nr_split++;
 					continue;
-- 
2.35.3


