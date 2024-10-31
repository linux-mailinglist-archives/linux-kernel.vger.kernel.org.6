Return-Path: <linux-kernel+bounces-391095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E169B82AB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487261C2164A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7B61C9B7B;
	Thu, 31 Oct 2024 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao7+6tAF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20511BD4E2;
	Thu, 31 Oct 2024 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730399881; cv=none; b=L/HQTenVX22PfTJIds7t/kl34QXpWX8a0cMfiHx8FlnEGKor2uJrRX6yxGb6G2FFDNDd49OSE9dGfEyu7WABCF0g/Nc5spfPj6YPJw2ESsA9L+Ep2fuFVgO3f4lGZY5BEZZ6fCOak+C9jbO7aZL8JWG0yMwTbjGkPlBhYEdGzHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730399881; c=relaxed/simple;
	bh=qecJ0qHrAeujnhyF+dduZkCOL4K+wkfdthsWnoxyKR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WSE2IDJTjfkaj2EPlYc9ORPXhA8VikdpZPBh1IZmhQT755SQBCmNWxbLOk4H5i3DRi7wXHG1kycFnN5d7MLGqomz1ZY885Wr/QTCOxBBMkfP/bRxnijWuyFPwdfhFLDWeS0du3cV0pbZdda+jpJJBxGtv5fWDJ86VQBuiIEb0VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao7+6tAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E7DC4CEC3;
	Thu, 31 Oct 2024 18:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730399881;
	bh=qecJ0qHrAeujnhyF+dduZkCOL4K+wkfdthsWnoxyKR0=;
	h=From:To:Cc:Subject:Date:From;
	b=ao7+6tAFmxFdXzIUpaISgQipbkO/HBP5KElukkh5rvJzabrTA7LbFJZXtivIV91cr
	 7egNniWWyOcj2YiAwE6pGAKAiJ1RzRuJvPv8ocIqnomjEuAvjPuzpJ6IdW9pxD+WLs
	 rylYOxlMIRzEKWEFapimd1GtXzv6Ls9aBSECqRaXu4HGnjgmXOP5C1SzqVno8DPBxe
	 R9sKYTJSDBmV3bLxdP2OewcnVQZzcQWYSSRjjEASoYiIIvKdUmDwDz2tZ23upTd8os
	 wy3kaM3oOzwIb4OtJmatO8hKtb+0TmKZGj7R2H/Ov2jdfH6KAbG6wlH3bkPJQN5MBY
	 KbJlO6aGz68Kg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 0/2] mm/damon/core: fix handling of zero non-sampling intervals
Date: Thu, 31 Oct 2024 11:37:55 -0700
Message-Id: <20241031183757.49610-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON's internal intervals accounting logic is not correctly handling
non-sampling intervals of zero values for a wrong assumption.  This
could cause unexpected monitoring behavior, and even result in infinite
hang of DAMON sysfs interface user threads in case of zero aggregation
interval.  Fix those by updating the intervals accounting logic.  For
details of the root case and solutions, please refer to commit messages
of fixes.

SeongJae Park (2):
  mm/damon/core: handle zero {aggregation,ops_update} intervals
  mm/damon/core: handle zero schemes apply interval

 mm/damon/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)


base-commit: 0c9ffe1412203c72280f67567bb53200f4de44fb
-- 
2.39.5


