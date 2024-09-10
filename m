Return-Path: <linux-kernel+bounces-323753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6A69742F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B1FB2573C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6C917A922;
	Tue, 10 Sep 2024 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SnaPKb/1"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E0A179956
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995162; cv=none; b=aSvUgZrDpUS113/IpHzG3KOXKtli1NkbWCbA1NiswXL1nj8LJhiXvRGzpDi8iBb36xWpQ+F04pYs06X62VFggHVaOIak8ss7Z5VQIs5lsctbyUVRnourkHL23Lf+AwB5fm9Brn408eFzqkve1kPpsdl4Q8JQxNpG0K0m/klBW6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995162; c=relaxed/simple;
	bh=SLV+XYn6nBs2t9meQ3KO1h4sWaLFdMza/UJh7pcED8s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pGiVUPzGTIPF0E9sdEgt7JU1x9xFOxn1KCXKlNdMz22pTobl1fgTXpkRBvn5qefGu4hhLcQdZTrt0rCwAu5s2VOw8oc7ecfOJNwGC0+piUQVF2+PQc2GA0y5yKThhWze12HGDUQfguoolywalA8tmHFgGU/SZ8oxtYPbfkg1+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SnaPKb/1; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Sep 2024 15:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725995157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wrDNV0GgXZMc30bnmbuGsHXq9dkPpuKdk+3TqbVzVJw=;
	b=SnaPKb/1M1LDbQj9Oy4xpNbg56/HJL+GuYsgOQVUV9zp/QNmVP06AmcM1dEnQ11ict1TwJ
	0IWypLju1KnU6Oz+Omzh2sFb6hXVRXPxfAoQTDcySLhg7eb9PsOIzYfO0RFax+yphra8Gg
	liS0k0GMITqvpeN/1iyKEqWQGQIRrUg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.10.y
Message-ID: <6ykag7fdhv7m4hr2urwlhlf2owm3keq7gsiijeiyh6gd45kcxr@jfmqoqrfqqfa>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hey Greg, couple critical fixes for you:

The following changes since commit 1611860f184a2c9e74ed593948d43657734a7098:

  Linux 6.10.9 (2024-09-08 07:56:41 +0200)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-v6.10.9-fixes

for you to fetch changes up to ee64e00984ec3ea3fbf9b4331cbd073690ff8765:

  bcachefs: Don't delete open files in online fsck (2024-09-10 10:52:16 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.10.10

----------------------------------------------------------------
Kent Overstreet (3):
      bcachefs: Fix bch2_extents_match() false positive
      bcachefs: Revert lockless buffered IO path
      bcachefs: Don't delete open files in online fsck

 fs/bcachefs/extents.c        |  23 ++++++-
 fs/bcachefs/fs-io-buffered.c | 149 ++++++++++++-------------------------------
 fs/bcachefs/fs.c             |   8 +++
 fs/bcachefs/fs.h             |   7 ++
 fs/bcachefs/fsck.c           |  18 ++++++
 5 files changed, 95 insertions(+), 110 deletions(-)

