Return-Path: <linux-kernel+bounces-538977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6BFA49F77
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B344175766
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815172755F6;
	Fri, 28 Feb 2025 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDhpO879"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2615B26E97E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761698; cv=none; b=HsPfdTg34+rkqZhcKyAnUkh5lUcNwm+BCAVDXaFiS581BMr6RSkkT1SMmRyWp11B0+tNeBhlRNEu/pPrjj46TDCNDgevoIRAYqwughHMqC+TMCldhyI0G4JyageP7HV4LNX0MmmKQwK+oPsJCd+6QcQBUBn7hHxxegGe+ej3h8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761698; c=relaxed/simple;
	bh=4BPFi+YOSDUSDxJGwHc3EfEKeJnUp44VBVSlPIcFVQU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IvokJu3lBwm4iEb3lNeMNCJaEgHrtLd1bcDiqvJ11UWMV9pnHncsJgOBLR9P9aDunYxmrKvMmgwsh/ImUSRqahDeVGCqHKjlx2KG7gj33HllvyqUfNQnMPDNzNuz89axEoQaIOY4pLVrVjcUJWq3LC8EH4A5D27Q8vmXld23W3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDhpO879; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-390ee05e2ceso592898f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740761695; x=1741366495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N60kH1GUzJjh3qweY5Wozn6tvXiwFNn/mmR1dP9CBxU=;
        b=eDhpO8795vKBMLyjOax2UopoSGGETksgumNx6Zb661Mq/n44oJczhdj399nI3AwC2O
         s1ZP6PI45+MkUbkMZCQ3YlFWqPSNMYj2+3m4KpNj8NSC+rC42yQOr/UAsa94bOZ91lP1
         KEay4UhNW8o2RB+E3uYWp5PVBuyBhwJI7DqP8Dt5Z43z8pKTTbWlj8sk+zLB93u8EZc/
         ueIFxyhhEtWwNTvEwR5wdWx96rfkmkZlnrYNzH0jADNxbGX0Q1NAej6k05DGAU7g+bu2
         U3LhyjMzVFbtwxHwlXRRSskeI8p+PKJv8kcQQoTG/D5dj19hGXMedHXPoMc5kkOE8Di3
         FzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761695; x=1741366495;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N60kH1GUzJjh3qweY5Wozn6tvXiwFNn/mmR1dP9CBxU=;
        b=fe3nGN+e5+Bs26cauFTLZ7n2/BdTI642/Lx317BV0OJudRyPPhcNN1pj2eGLj1eIAl
         yMDilr+IiLCeeS6x4XYNVT2tL3nv89LSsGs3RquyMiSAirTwaI1zGHCJJ9zOCAQVyKGK
         RcmC0OiORRC8YrVIli5ScitMY5oYAYEfplzSPS1CEz0RyqDab7Ffhqr/Ly7KYGp3T6Ys
         YxJv8FWPgKMNrh22RA8QCgW4/8Xx1r4RvJ2z6Sc0yMVUv0oMaHuesVBuV06nEu1BdtIs
         3qVeUM44dB2+t1myZM2o6gDYLRbOv5BgO4v2uGCVWh3F/u+X/o4T+d5OidugUaXO2jLd
         ULZA==
X-Forwarded-Encrypted: i=1; AJvYcCXhFP0X6F7L6BqJX/q2O9YyBrJ8MpqonQNqzPIXQ/iwHMmxCojYH9i8wUYxx7qrx2ocb6mfUV1sFF7j29U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFP1eEYq55uHb5a4X8JYbKsnBlqO7xjl8EafzLBKu1UeK8pdTe
	NO/FZ3fsLsNlBf2ooC548DGwQph4txcfIO03CGn6HjvQQVuaCtWhWTunyt3GbsWDE1yIAYpFLiw
	bJX1v/NO6aw==
X-Google-Smtp-Source: AGHT+IE8RFBDoXnybZcLhnR95WmNyhuhSBpy8g+82jmGo3gir1AQ+P7E3C3dzckGzTkA372AoyCvaXEdGAGchg==
X-Received: from wrbfu11.prod.google.com ([2002:a05:6000:25eb:b0:390:d964:d327])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64cf:0:b0:390:e63d:30d9 with SMTP id ffacd0b85a97d-390eca5b159mr3212116f8f.36.1740761695598;
 Fri, 28 Feb 2025 08:54:55 -0800 (PST)
Date: Fri, 28 Feb 2025 16:54:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFjqwWcC/3XMSwqDMBSF4a1Ixk2JNw9tR91H6UCTGw2okURCi
 7j3RkdtocNz4PtXEjE4jORarCRgctH5KQ9+Kojum6lD6kzeBBhIBsDoONKIg10wLpGCqQyTAmy
 jkWQyB7TueeTuj7x7FxcfXkc9lfv7J5RKyuilba2sjBJC8VvnfTfgWfuR7KUEn7r80ZA11FoYp XjNtfzS27a9AVrPEZXnAAAA
X-Change-Id: 20250220-mm-selftests-2d7d0542face
X-Mailer: b4 0.15-dev
Message-ID: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
Subject: [PATCH v3 00/10] selftests/mm: Some cleanups from trying to run them
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>, 
	Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="utf-8"

I never had much luck running mm selftests so I spent a few hours
digging into why.

Looks like most of the reason is missing SKIP checks, so this series is
just adding a bunch of those that I found. I did not do anything like
all of them, just the ones I spotted in gup_longterm, gup_test, mmap,
userfaultfd and memfd_secret.

It's a bit unfortunate to have to skip those tests when ftruncate()
fails, but I don't have time to dig deep enough into it to actually make
them pass. I have observed the issue on 9pfs and heard rumours that NFS
has a similar problem.

I'm now able to run these test groups successfully:

- mmap
- gup_test
- compaction
- migration
- page_frag
- userfaultfd

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Changes in v3:
- Added fix for userfaultfd tests.
- Dropped attempts to use sudo.
- Fixed garbage printf in uffd-stress.
  (Added EXTRA_CFLAGS=-Werror FORCE_TARGETS=1 to my scripts to prevent
   such errors happening again).
- Fixed missing newlines in ksft_test_result_skip() calls.
- Link to v2: https://lore.kernel.org/r/20250221-mm-selftests-v2-0-28c4d66383c5@google.com

Changes in v2 (Thanks to Dev for the reviews):
- Improve and cleanup some error messages
- Add some extra SKIPs
- Fix misnaming of nr_cpus variable in uffd tests
- Link to v1: https://lore.kernel.org/r/20250220-mm-selftests-v1-0-9bbf57d64463@google.com

---
Brendan Jackman (10):
      selftests/mm: Report errno when things fail in gup_longterm
      selftests/mm: Skip uffd-stress if userfaultfd not available
      selftests/mm: Skip uffd-wp-mremap if userfaultfd not available
      selftests/mm/uffd: Rename nr_cpus -> nr_threads
      selftests/mm: Print some details when uffd-stress gets bad params
      selftests/mm: Don't fail uffd-stress if too many CPUs
      selftests/mm: Skip map_populate on weird filesystems
      selftests/mm: Skip gup_longerm tests on weird filesystems
      selftests/mm: Drop unnecessary sudo usage
      selftests/mm: Ensure uffd-wp-mremap gets pages of each size

 tools/testing/selftests/mm/gup_longterm.c    | 45 ++++++++++++++++++----------
 tools/testing/selftests/mm/map_populate.c    |  7 +++++
 tools/testing/selftests/mm/run_vmtests.sh    | 25 ++++++++++++++--
 tools/testing/selftests/mm/uffd-common.c     |  8 ++---
 tools/testing/selftests/mm/uffd-common.h     |  2 +-
 tools/testing/selftests/mm/uffd-stress.c     | 42 ++++++++++++++++----------
 tools/testing/selftests/mm/uffd-unit-tests.c |  2 +-
 tools/testing/selftests/mm/uffd-wp-mremap.c  |  5 +++-
 8 files changed, 95 insertions(+), 41 deletions(-)
---
base-commit: 76544811c850a1f4c055aa182b513b7a843868ea
change-id: 20250220-mm-selftests-2d7d0542face

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


