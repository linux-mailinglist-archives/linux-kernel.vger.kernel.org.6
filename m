Return-Path: <linux-kernel+bounces-189790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6628CF4F7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 19:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E36B20BC2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 17:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E121B94D;
	Sun, 26 May 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IO955frt"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5E5200BA
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716742993; cv=none; b=UqtCrwQNBNxiHQGaZnmT4Red/z5QCOKbMEaF8qeDYwWnSltJrNUFxZkcgTygqtru/3o8D7DDopOa5CXldsaX4qDt4T6qAx4yjSVq3p3pyAk3RPpC0VejY7Ly5zMk/ANBsXv8Wec6rPOwrVyW2ruFO2Ezci/0U3zypDeU1NcwH6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716742993; c=relaxed/simple;
	bh=tFZFEGMvVkVlCK6u9Aig/nw745nXbWR9VtGHw6z5Lxo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B+cr+qWp4ICx18QinZSYrHqLjA36v5j6VLgwL3NrhZpO5WAg+tXAWbhTxz9TkWmFqRswKEfYdwuYYenPxVmGnfi3cV5FVHoOwjwzVhlF1wz+/difwAWpfbg27UNSVFOh/kilwogVe23FS0+AcaRX46dvc3StWtuKp5pQ1PSepKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IO955frt; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: torvalds@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716742987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=dqhH+uw34lp5DiUdfeUhU1eSbI3jUtWHnBiE4Qio80k=;
	b=IO955frt/4ILeL2bKyUsTxPRDAO9GmBXegsXpXZGXCzCLQHBBAIUOhw7Tcw4xalJH+ZnlJ
	YIFBz5E0yJmVF28wKzt1IeCJxznVg0hzzcW1VKdJLu4dNx7gO0nnEXpachl+pg5aQCxsce
	POGqfdfaNuc6/iYNhEOm46hVAZjN8SI=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: surenb@google.com
Date: Sun, 26 May 2024 13:03:03 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>
Subject: [GIT PULL] header fix for riscv build failure
Message-ID: <h23suk5s4hhkf7prhkzxp6a4kmhpgqxyl6ioski5cg7ciihxmj@j4zif6l6dqxc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, this fixes a riscv randconfig build failure from memory
allocation profiling...

Did some more local randconfig build testing for this one, as well as
had 0day test it.

The following changes since commit d960f67701b21b945a3fb5b6555aa4a97062fcd0:

  Merge tag 'nfs-for-6.10-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs (2024-05-24 11:42:03 -0400)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git fix_missing_include

for you to fetch changes up to acb7ffcaeaa6793fecf71decbe41ed2ff4422ad1:

  bcachefs: Include smp.h in alloc_tag.h (2024-05-24 11:42:09 -0400)

----------------------------------------------------------------
Kent Overstreet (1):
      bcachefs: Include smp.h in alloc_tag.h

 include/linux/alloc_tag.h | 1 +
 1 file changed, 1 insertion(+)

