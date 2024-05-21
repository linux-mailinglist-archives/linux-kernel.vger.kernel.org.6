Return-Path: <linux-kernel+bounces-185231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C728CB278
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBF81C21522
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB987710F;
	Tue, 21 May 2024 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkIxJPC7"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973C2C181
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310281; cv=none; b=mg8BMyzl3OFySwB9k5Lce6C4DBsLyBbpSZQBexeJgSCSzFY/0joVQO8Qjz3EGIl19EJPTxmlHxMof0U3OmjRjyqAJAecYBnZCSN6xCN8rmu8LzDkVIwV7ixdwKdD6VH67OYB5AS1qdcE6hClMBbNq3muWqiBFk2bCv0wC6k5Hew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310281; c=relaxed/simple;
	bh=bjhkqCLwFh5x4/YQNYhbvCnOXQQwYWrnkQRg+dc4jVc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=YdKtLjQUfRt5ImeQm1GspfKrQxgOpD3y1rHlhKvGvyCqVlG8b+I01GqTWv39zzZ0rjdQV3q1QCvnnEnqcg7lXHW2+LCBHXakHxj7bp2E1aRX/8gjsimD0xMHUPOHaNdz6HqtCvyPT1UugakvQRTH/2Olf3SoxllGjQ7T6I61ZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkIxJPC7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de59e612376so18921145276.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716310278; x=1716915078; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dTzCtBYqo5qPAcuxKyv6ANbzvYtg0N+sVJ3rcLshDVM=;
        b=AkIxJPC70HmEjjUS3NF1ZSWTj2RcmTW1Hj86YylWMN+Ig+oNfZRZI84xCSzms6w0+4
         CoWVlpQvzzZJuowDVt/ESbkP0x7rj0MleC5AlOZQGpXg96qhg73jp3WRUB7bKhCpOdgV
         tJjDZ7B7MwbTawxFTC1M3cymtb4eDpFyufmqO2XWTmAt5kwzSiRntF/ROOE6mtV6y6rN
         N2QfUtrtxzAMN+klzEG5FT8dTWhOJogLAJa714M8QwE2e1Dfpiowdvv6NgyjumC6wJ21
         EAl1bjRG2le8lFzUbvqVuSjm30Hsqoq0qkSohoQ6Oaczp4UjXJBKzhKTdBwfrSb2ZsCt
         M1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716310278; x=1716915078;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTzCtBYqo5qPAcuxKyv6ANbzvYtg0N+sVJ3rcLshDVM=;
        b=uyUxeAjTqdwA8PFfSWD+u7Zrs5PNztyXVr6+fgPLvNOsjgtKpWEUP7oS1KDbIledQ+
         VfrpNjX0nHYCn2ke0N2ObvyeeidJslH6mzysjwHGmWq9O7y8drbf8BaAGmq4w/7WPgdv
         e52roRcXsI4XrJA/CDp/FHDeUiETWWBnuyV1mpJAFUlr/X6Gd66gsnnDwjVuerGpWG5D
         W/gsSRjoALuvBa24wDzCpvyc8FJH4NZ82QV696qZatzZS1oc15E31cIy1qja3VvFdD+W
         zCRAg6Lp7K+lCI56F8Gg3mH1zLJ6WnYIFvWUIDE7J7Q0DbmY4NLA5kNvzQo9YGW5u2Ke
         iyWA==
X-Forwarded-Encrypted: i=1; AJvYcCUF3yo7kEjRl/4nUqgmZS+zp30dcddiB1ejUliGByKUI0LZiE55u29mKFbDwveczb7D6wr98lV6kppRaOeGPuocFsPPGuv7iCMO/TZA
X-Gm-Message-State: AOJu0YzfbGeQQBKi3ZKrDplEusmBZew9jOjTEtLsyycKFj2my5vK3ApE
	vmANu3JQAew5t1XKUzz235KCfMami1sTFEYBL0z795FRdiIm3qj/oqiStHa5WoVnb8C0f9UcQE7
	pHDDHHA==
X-Google-Smtp-Source: AGHT+IEmMr0Lb0d9RryWzApjev8jwTAxZLwt8l5tfrfEm3fDSReYbTbe5ajh9TwlpM6kOzRv5E2xItYNLzXm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8533:b29a:936d:651a])
 (user=irogers job=sendgmr) by 2002:a25:8211:0:b0:deb:9d56:b498 with SMTP id
 3f1490d57ef6-dee4f321076mr2428304276.13.1716310277923; Tue, 21 May 2024
 09:51:17 -0700 (PDT)
Date: Tue, 21 May 2024 09:51:06 -0700
Message-Id: <20240521165109.708593-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 0/3] Fix and improve __maps__fixup_overlap_and_insert
From: Ian Rogers <irogers@google.com>
To: "Steinar H . Gunderson" <sesse@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix latent unlikely bugs in __maps__fixup_overlap_and_insert.

Improve __maps__fixup_overlap_and_insert's performance 21x in the case
of overlapping mmaps. sesse@google.com reported slowness opening
perf.data files from chromium where the files contained a large number
of overlapping mappings. Improve this case primarily by avoiding
unnecessary sorting.

Unscientific timing data processing a perf.data file with overlapping
mmap events from chromium:

Before:
real    0m9.856s
user    0m9.637s
sys     0m0.204s

After:
real    0m0.675s
user    0m0.454s
sys     0m0.196s

Tested with address/leak sanitizer, invariant checks and validating
the before and after output are identical.

Ian Rogers (3):
  perf maps: Fix use after free in __maps__fixup_overlap_and_insert
  perf maps: Reduce sorting for overlapping mappings
  perf maps: Add/use a sorted insert for fixup overlap and insert

 tools/perf/util/maps.c | 113 +++++++++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 21 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


