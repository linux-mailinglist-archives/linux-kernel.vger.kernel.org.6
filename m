Return-Path: <linux-kernel+bounces-315816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744F496C74C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310CA28763C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A821E5015;
	Wed,  4 Sep 2024 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aLNyBGM2"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8226984E1E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477326; cv=none; b=hxLP98a4YOk80nVmIdGIZNxCnAZ2GuA9yx8fQjcXWN5oFULHG7U8RrHJgHVEx9XRvM+g9LFnYHhjEMKefzWbY6kmQeiilrPdu4RZfUdXJdfulvwYM5lTF+uRCv+CdQ0xgmFP/0VIRhY1vWolVju65YaUF+E0WU4X5r2d4bJe+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477326; c=relaxed/simple;
	bh=7eKFCS+deXpzM5jOO60xa8yg4fleUzi0kR5d0HtYZo8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GBN/cgq/tm7hk5NVWD+1v8+iJxpVZKbx144FNh9fCsK9QoHMRW1x1VVr7cDT6TsQDdSlALcZFYwIg7hArYwerM8Mql76HT/1XDXQ4JiAchAAI14w3h8sm3cF7HNepOg1W2D5CphxescDzs9SutrNJisUYCrGMx/eRItcVac37nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aLNyBGM2; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Sep 2024 15:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725477321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=u8kpNsKSZ3uqQLjXloSdeinlpG3I+j+7gjEL1plsaXE=;
	b=aLNyBGM2GzqCDnPPc5Lp9dLpwaUlizi9R5lzZNyqzNGWyz4EW/Gl78bjBiLtcPW+otV3R6
	voCUhc5I8x3bwOI5WVWQZ3h/WLTX9ogIv8ui//zFbzQfE8hsgys97r0icMzaYLY89Jp9ui
	DE8O3pyn2CMVC8BfDw+XCSK/ErvpYpA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.11-rc7
Message-ID: <45wxyfvbqm76vqbdjkasy3a4pxtbnza5qiukvcougseosx4qnt@uqosw6rkccxi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus - just two little ones.

The following changes since commit 3d3020c461936009dc58702e267ff67b0076cbf2:

  bcachefs: Mark more errors as autofix (2024-08-31 19:27:01 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-09-04

for you to fetch changes up to 53f6619554fb1edf8d7599b560d44dbea085c730:

  bcachefs: BCH_SB_MEMBER_INVALID (2024-09-03 20:43:14 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.11-rc1

- Fix a typo in the rebalance accounting changes
- BCH_SB_MEMBER_INVALID: small on disk format feature which will be
  needed for full erasure coding support; this is only the minimum so
  that 6.11 can handle future versions without barfing.

----------------------------------------------------------------
Kent Overstreet (2):
      bcachefs: fix rebalance accounting
      bcachefs: BCH_SB_MEMBER_INVALID

 fs/bcachefs/buckets.c           | 2 +-
 fs/bcachefs/replicas.c          | 3 ++-
 fs/bcachefs/sb-members.c        | 3 ++-
 fs/bcachefs/sb-members_format.h | 5 +++++
 4 files changed, 10 insertions(+), 3 deletions(-)

