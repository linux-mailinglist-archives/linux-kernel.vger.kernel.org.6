Return-Path: <linux-kernel+bounces-193831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0819F8D32D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B796228513B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F32716C440;
	Wed, 29 May 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LiOSz1FP"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7193E169ADC
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974438; cv=none; b=F35tU6wvqToFnxspqEzC7BbFyw+PY11rEOiRz7aKdkCHJXKPVh4lcEKufdsdgQzC55BGcKdX9Wd706bTwDv7bVI9rL7nlcoc3jeH02gpM6eDqvy98UE3NFffA4vs6tAdYi6NihIuQErbOJ85oLpstvQThYSQbk/Gn51p8LEhX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974438; c=relaxed/simple;
	bh=BQndSFmSzjVJszryV0eFHGto7znM46+Oj/DK6i9A0ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXIAiQ/TZwvnoQdEUZJj3frEhIOKNcwgmBLmODrfAR3CyppMvKDWG9+aVMrEVvbhAKtEtkz6FGFuA0xKTA49J3U9MPxN6aiMTp97Xeac4w7wece1VV++ZmuL7Xbmh3pKg+tzC5RHx7RET+zhv3BiJG7B6KSz3I3BQCFRtZIQc/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LiOSz1FP; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: harshadshirwadkar@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716974434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HdwK0wHKQIzYeRO2c0o1hYz9tLJqH5VOwbHssaheTcs=;
	b=LiOSz1FPuzNilPE/VUJBm6Fej6CKUAA0uv5wZxrzDshhamAFct8057g8nYZH4Cg2zTzq1j
	OAtkLazjNRuRLw9O6b4rxq6/wlvd6IQHi+z3wvCdT8Mfin50u5YgNt9TsIKnMO9GKgaVmE
	VDZ7h1O4p/iQ55ppSbBcW5ZuQi2XFVA=
X-Envelope-To: luis.henriques@linux.dev
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: jack@suse.cz
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: tytso@mit.edu
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v3 0/2] ext4: fix fast commit inode enqueueing during a full journal commit
Date: Wed, 29 May 2024 10:20:28 +0100
Message-ID: <20240529092030.9557-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi!

Here's v3 of this fix to the fast commit enqueuing bug triggered by fstest
generic/047.  This version simplifies the previous patch version by re-using
the i_sync_tid field in struct ext4_inode_info instead of adding a new one.

The extra patch includes a few extra fixes to the tid_t type handling.  Jan
brought to my attention the fact that this sequence number may wrap, and I
quickly found a few places in the code where the tid_geq() and tid_gt()
helpers had to be used.

Again, please note that this fix requires [1] to be applied too.

[1] https://lore.kernel.org/all/20240515082857.32730-1-luis.henriques@linux.dev

Luis Henriques (SUSE) (2):
  ext4: fix fast commit inode enqueueing during a full journal commit
  ext4: fix possible tid_t sequence overflows

 fs/ext4/fast_commit.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)


