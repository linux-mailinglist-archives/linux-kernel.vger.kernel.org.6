Return-Path: <linux-kernel+bounces-377114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46B09ABA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58B328457F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F501CEAC9;
	Tue, 22 Oct 2024 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mA4AVF4E"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061D51CEAAC
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639486; cv=none; b=hPiSgBkH/1OLvYD5kajWFE7he9C23vmAe4wpgNXp2vXJ8cROIIqF6hTcfFOYEUVF8b1x9AK9ogmFoUYzLrPsN1K0o39lMxXGmfAVLVy1ylIgKQ9petn/4/QhfBseuqmIhtfigm/d/bm8/luwCCG1sHNwScSEhSDfziDgt1o4Fj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639486; c=relaxed/simple;
	bh=w5Cmv1nC3DQF0HJ1AhpAv/11cjEeNS+xOrhT/mzyzvg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=siWgB2WboQT3cLMd2fIiDPDGW/41o3iJLtYIBKKevnKiq1s0CV+y7N7elqZTd4/EPDjulFkgaEtwe2a9XYZd7461tngmmzrF8xX6ba4WmxjU/ti/b3lXeYPRkansY7XcDKUus6000WSfgCZZRkQZRPxUDp9RflFefTaFPCBgTKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mA4AVF4E; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e2cc47ce63so5802270a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729639484; x=1730244284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dx/bAtd7J34pukh8whXLHvbZ8CIncDKFC5WH0skHh/4=;
        b=mA4AVF4ECmdmc2NQfTt39iJv81hOhxFy0yz16ynltNavrHTvoJwTNAqiKQWpwQteEm
         64ugsKF9HZwymcNfRygOg7Y5H+vdyLz3yI4aLufxXHynKWopKQE0d0XBXg1ItxjsaZCy
         RK7EUFTh+H3DqBo0SaV7KY8WY7DkWX4+JfeKjmXz9wueoU1+AGgkJAiSqDjNk86hIRoo
         I9a+dT/z3OCJHxOuXzXbhb4bkQRvHhbqFCzwf7o6c7/4i1NMKL2wN10r0fYq1Ljv8MRY
         xM8Ih21C5/0aeoxQRAqhiFyIJVu1uXBCaISQRIKyPavkBjAchOG5+DCp6Lq0XgaBMAge
         yg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729639484; x=1730244284;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dx/bAtd7J34pukh8whXLHvbZ8CIncDKFC5WH0skHh/4=;
        b=CP7o0yor+wuO0k25slwJzUvZM+OIoW5isUJvQhn0kdTPnJ7REWzAmXTHyx34tjYp/q
         WL+b2qOWIjezY4/8TvPkpaJzWMsziIsv9C8uMNAd+olKCKi3SnS3PU56vvob4ArYiISJ
         f26XRGOU0s3C65YvSZujx+xvVkDXIzcSG4gug5oykjsDRh8MSCa9wmuj9VZz/ohSMBXr
         gcgHqdBG24BYUfi3Gii2KoVOETk755LOMp0jbiYkD+6eK7KcJlux+I45RTWNXtQNXaWs
         phihL8qWkFZsphlOEw62wREgP/fwrUyyuRW3GyxQQ7Ng5T/aUZQxSntruSQ2UkcsJ3oz
         DTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGthyMGDbLT65IzM3sPcmq9VewHTqHrtVz4avubEc6VlXCGTLEilQ9au+5a9Eje0Orq7Stmxv77HwjeMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7cT95HRRWgfCWmFdNbb3YfjHQPvS8j+lyb38wngeYtubKjDyL
	MeyG7XGyX298BsU7/mHgKYoCN/RCfOtMedJ35Avd1NrYncaUne0minfmRfqtr3j9teRd9AZ0XV7
	rbWTF1FWV7JtB0R9MdJ9Uvw==
X-Google-Smtp-Source: AGHT+IEWwJ0q7HzgQitOsqrFtJ42q7VF/jH/hgTdsiGeloYBSKWeWUHNFKDOVkkvROJJBljYeVguSl0SeiOObdVWPw==
X-Received: from souravbig.c.googlers.com ([fda3:e722:ac3:cc00:4a:2332:ac13:d235])
 (user=souravpanda job=sendgmr) by 2002:a17:90b:1a86:b0:2e2:af52:a7b4 with
 SMTP id 98e67ed59e1d1-2e76b8516c1mr764a91.8.1729639484076; Tue, 22 Oct 2024
 16:24:44 -0700 (PDT)
Date: Tue, 22 Oct 2024 23:24:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241022232440.334820-1-souravpanda@google.com>
Subject: [PATCH v2] mm/codetag: fix arg in pgalloc_tag_copy alloc_tag_sub
From: Sourav Panda <souravpanda@google.com>
To: akpm@linux-foundation.org, surenb@google.com, yuzhao@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
	weixugc@google.com
Cc: Sourav Panda <souravpanda@google.com>
Content-Type: text/plain; charset="UTF-8"

alloc_tag_sub() takes bytes as opposed to number of pages as argument.

Currently pgalloc_tag_copy() passes the number of pages. This fix passes
the correct unit, which is the number of bytes allocated.

Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
Signed-off-by: Sourav Panda <souravpanda@google.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
Changelog:
Added Acked-by: Suren Baghdasaryan <surenb@google.com>
Added Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Fixed the nit pointed by Wei in the commit message

v1:
https://lore.kernel.org/all/20241022205622.133697-1-souravpanda@google.com/
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecf63d2b0582..2890001c8b97 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4203,7 +4203,7 @@ static inline void pgalloc_tag_copy(struct folio *new, struct folio *old)
 	/* Clear the old ref to the original allocation tag. */
 	clear_page_tag_ref(&old->page);
 	/* Decrement the counters of the tag on get_new_folio. */
-	alloc_tag_sub(ref, folio_nr_pages(new));
+	alloc_tag_sub(ref, folio_size(new));
 
 	__alloc_tag_ref_set(ref, tag);
 
-- 
2.47.0.105.g07ac214952-goog


