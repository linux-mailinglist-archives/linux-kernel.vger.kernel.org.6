Return-Path: <linux-kernel+bounces-225954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E29A9913853
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 08:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46965B2156C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 06:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EFE26ACA;
	Sun, 23 Jun 2024 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw9Tu3Fa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF014A90
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 06:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719124124; cv=none; b=ckF6mUTpL7m1VGPyca9U3DYi9VFxlvpEUnsvydGwmTAYIUEI1fHuemw6bITrUiRBaaM4k7NTAuRRjfPnqu+Ppeh7nYGhDRLuH3E4HSMEvBoOuRLGae9Ha+17wkPkuTnz7ngkgLnjKN6APgkhfy1bhKhbIXupkSmXbNq1sKMB4y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719124124; c=relaxed/simple;
	bh=/szumQs4ZfZmpOw59Gy9dK6j0OCQ6BkDfNmmnoXGkso=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nAeNJ0fAGO7b1td056nMlFlBHZwMCyin0Cd5MPmV82QTiW91vpMB8E9sEJiKRrz3sDBw4JNTozwB81jpmb0mTO/jLt7Cwtrn+P2C6sTl45zwRjqdsLkKS3BRimOjPjpwCIRwOkFBMzAOMZGDu6lTsaacU0o+djbbD7M8OYeDoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qw9Tu3Fa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DAFC2BD10;
	Sun, 23 Jun 2024 06:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719124124;
	bh=/szumQs4ZfZmpOw59Gy9dK6j0OCQ6BkDfNmmnoXGkso=;
	h=Date:From:To:Cc:Subject:From;
	b=qw9Tu3FaXDUjMlL6vrOMpeYK14O+mC1kSn1q+Enk7OOEqOy9fDcTf4XTXB8AdygZx
	 dyrcejsfbSpJDkMWEtKViW9vTXAekICmms99os9mYGJ3MoTuUkz3SSkMVsHmktBMZw
	 b0sWRg7pyFthmzee9uOVL9khVjJVOaw6egzPhoVWb6B+Vd3V7h5+RRz8wraurWwgeJ
	 Qs+3HWJ+/apDAlCE+IV1m0RUmu9dZl/efze43OABSKCBqd9PjnYAhMajojrCZ7G6yS
	 Zl85847Dax5/IDf+3tdvCxBaELtHJ9M7SH0yutlElFEv121O+Dq0k/rfO/6vIv6rxu
	 f5mIofroEAkEQ==
Date: Sun, 23 Jun 2024 09:26:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: fix fragility in checks for unset node ID
Message-ID: <ZnfADPCiONdn1F8d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 3ac36aa7307363b7247ccb6f6a804e11496b2b36:

  x86/mm/numa: Use NUMA_NO_NODE when calling memblock_set_node() (2024-06-06 22:20:39 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2024-06-23

for you to fetch changes up to 8043832e2a123fd9372007a29192f2f3ba328cd6:

  memblock: use numa_valid_node() helper to check for invalid node ID (2024-06-16 10:17:57 +0300)

----------------------------------------------------------------
memblock: fix fragility in checks for unset node ID

Use numa_valid_node() function to verify that nid is a valid node ID
instead of inconsistent comparisons with either NUMA_NO_NODE or
MAX_NUMNODES.

----------------------------------------------------------------
Mike Rapoport (IBM) (1):
      memblock: use numa_valid_node() helper to check for invalid node ID

 include/linux/numa.h |  5 +++++
 mm/memblock.c        | 28 +++++++---------------------
 2 files changed, 12 insertions(+), 21 deletions(-)

-- 
Sincerely yours,
Mike.

