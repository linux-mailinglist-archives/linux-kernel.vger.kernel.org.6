Return-Path: <linux-kernel+bounces-558126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61771A5E1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C2E1788BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C398D23F388;
	Wed, 12 Mar 2025 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCpt+u3Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDA61D61A2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798077; cv=none; b=kk9RC/5o5KiGsC68dhCmwsFOHkS2XhKSIWWAIwDNeHSnluVc5CV6d+Sn98W613PV76i2WFe5Y5y1052FZzzPOIIrUexPT3vzsLcq9dKrDv+lZVX05jCeCkS8K+SU1zRAqcfT6YC7QmJpG4rRfMQBva1XAU6Yr/5L8zHtrP0pvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798077; c=relaxed/simple;
	bh=mxnEpJvz9nEMAHM0YcAwaufxBIrflDriQAYttnzHCGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=suAX4TjJxAlKtWcJygEpo6aR+0tZmb1LlbjihudXFt09uUlY08voDS2HWXv8eMp7s3ehWwGMlm+DN6nG6Xpk26/Vvmy5dGnbvE0SQR2IsVHEMP1ZOHa/VNVFEKvRzxbnKywxsUhxjK4VnFaBCOzfFauCaugIiswXo79JH4U6wpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCpt+u3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856FDC4CEDD;
	Wed, 12 Mar 2025 16:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741798075;
	bh=mxnEpJvz9nEMAHM0YcAwaufxBIrflDriQAYttnzHCGo=;
	h=From:To:Cc:Subject:Date:From;
	b=MCpt+u3YL/tiQp64WdzXGI2lHLevdieuEp8i6+MpZ7ljiAUV79PsEWlTK4HPjvKTs
	 7vEIQOf4MLhfCwaIrkj+euARVrjhtNphM1amcGrixCH0P6XAeNmYFVY6bsN7g2Y5UH
	 Vcc5X0U6YAtZEnr6wK3OLhkflBM9UrWJJBleQ6n4NJdq6F0eQ3EKQWMEJs/GCHoLKq
	 GARQVeHsEgMWS1kfmfDDYnn7uJWm3uHBg+i6PBdBouAyzVyZ5ZBOu16pbrL3aOhU4x
	 0PeCfAuEpqQaxw7ElhFAMU46C+0LyEOsvqRLza3o3hdtmWUQ0icZrmgPYFM/cYU8S4
	 3zs9aHtOkiVjA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] mm/madvise: cleanup requests validations and classifications
Date: Wed, 12 Mar 2025 09:47:46 -0700
Message-Id: <20250312164750.59215-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup madvise entry level code for cleaner request validations and
classifications.

Note that this series was a part of another one[1], and separated to
this one following a reviewer's nice comment[2].

Changes from the original series
(https://lore.kernel.org/20250310172318.653630-1-sj@kernel.org)
- Separate from the tlb flushes batching part
- Collect Reviewed-by: tags from Lorenzo
- Fix typos and wordsmith commit messages and comments
- Rebase on latest mm-unstable

[1] https://lore.kernel.org/20250310172318.653630-1-sj@kernel.org
[2] https://lore.kernel.org/0f90d56e-5960-4478-803e-1054696c0cde@lucifer.local

SeongJae Park (4):
  mm/madvise: use is_memory_failure() from madvise_do_behavior()
  mm/madvise: split out populate behavior check logic
  mm/madvise: deduplicate madvise_do_behavior() skip case handlings
  mm/madvise: remove len parameter of madvise_do_behavior()

 mm/madvise.c | 128 +++++++++++++++++++++++++++++----------------------
 1 file changed, 74 insertions(+), 54 deletions(-)


base-commit: 733c75c2264b9de72a463f731507e674a32ff094
-- 
2.39.5

