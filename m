Return-Path: <linux-kernel+bounces-202798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8358FD152
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706BC1F26BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9AB3B1A4;
	Wed,  5 Jun 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k2t8Wv4x"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD652747D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599642; cv=none; b=rWuRPjuZJMcr7RUG504z9lMYfMxNqppPytb883Qh0OMwYVPxwxkKgyTvZ/XZneBu2Kx4P+FWUp+ETo6l1eJah8LXVMshuI0/HAeqW/9cyZ1krP4OJdLHKbbl8XS861X/NZ+5dH6o319jzf9SFhlFlaoy3nH9V/Uj7eV+MJpr8cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599642; c=relaxed/simple;
	bh=Zz1j0hYSAGppgQC9YAIbqYWXNAuMOAAQHxImzWIrScY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WajRKn7Fl6SQ44vK2AVdnu/vJahYaGtV3qRaWMlcNd7BiTc5Xti4Pt/B8sr5slPe50h/ok8JJ74p19BODgpvHajlxJmVVW9rHRG4zO4d2Kqvx3/MLHkQdiUmAHb4jxjC2Ih/GsgM7qa0Vj9mo3q95HSKD/CMoQ0MzqRaUA15zzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k2t8Wv4x; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: torvalds@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717599638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=xcISW8lyXXqJzrVhgbIG0dJoTv2UgwwyLRjlJ9tmt8I=;
	b=k2t8Wv4xgqYx/bG18obWqaT7KjrAK4EiapNHsqN9jDmVzdG8Rvbbrs4UydHTbSSdtwjDW8
	OtTzg4755j1P75Iw8ankvTl/S9Z3Jc6wol69TbZrQWDzSim6/eS/4XqD7qiWOF+vogyrAs
	on0g6SB01Ej10FXLQSpVqqkDB3x0AxA=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Wed, 5 Jun 2024 11:00:34 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.10-rc3
Message-ID: <4a4gssdsaohqqh33hd2i2tavvfsjixngyfsyddy73keqauh3yo@m4vtvrly275m>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, few small ones for you:

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-06-05

for you to fetch changes up to 319fef29e96524966bb8593117ce0c5867846eea:

  bcachefs: Fix trans->locked assert (2024-06-05 10:44:08 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.10-rc3

Just a few small fixes.

----------------------------------------------------------------
Kent Overstreet (3):
      bcachefs: Fix GFP_KERNEL allocation in break_cycle()
      bcachefs: Rereplicate now moves data off of durability=0 devices
      bcachefs: Fix trans->locked assert

 fs/bcachefs/btree_locking.c |  1 +
 fs/bcachefs/move.c          | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

