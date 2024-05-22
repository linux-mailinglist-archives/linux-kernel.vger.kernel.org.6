Return-Path: <linux-kernel+bounces-186513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5FA8CC51F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0BC1C21735
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5676A1420C9;
	Wed, 22 May 2024 16:49:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35CC7E57F
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396588; cv=none; b=aldoEnpZmFzJJQ1swVTSiYXsK8Tlbja1i28/tworUEcplXpyMlggLdNOBjBS5IeV3b20Q7dwqWczlgp4aM0biBrpYBC1/XKTLS2vRTfVZLMtdJ3e+/d2p/u+p6ol8btUm2OQE1kUmO6u4uW40HCrtw4UQi/DhimHnHtMQXuJIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396588; c=relaxed/simple;
	bh=5EZtOuCgfS+Mz9ETXz+eVnCePAJAmRHUWGsqrzA89Fc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=bTZUe9EfeqRkkhiTZkOMRHCHAJDlqCexZrusn3bPzT0O1IIKD0G6C2lTfWehcbO12kUnij7C1GxLGvqYmXpm8r31EGCksgYeUMmXFSS+PznLkrlXam5FZEe8epDnF68xptlo6X/uY5D2pJsZ5Fr1wVJ3rLGXsElOeA/PShYX0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D1BC2BBFC;
	Wed, 22 May 2024 16:49:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s9pAd-00000006HP7-2VBo;
	Wed, 22 May 2024 12:50:31 -0400
Message-ID: <20240522164942.590663963@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 22 May 2024 12:49:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/4] eventfs: Simplify the permissions logic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


While debugging the failure of the ownership test failing on the
second run again, I ended up greatly simplifying the eventfs code
with respect to the permissions, only to discover that the bug was
elsewhere[1].

But because of the great diff-stat that this produced, not to mention
the simplifying of the code, I'm going to try to get this into this
merge window.

[1] https://lore.kernel.org/linux-trace-kernel/20240522124504.28982867@gandalf.local.home/

Steven Rostedt (Google) (4):
      eventfs: Consolidate the eventfs_inode update in eventfs_get_inode()
      eventfs: Remove getattr and permission callbacks
      eventfs: Cleanup permissions in creation of inodes
      eventfs: Do not use attributes for events directory

----
 fs/tracefs/event_inode.c | 172 +++++++++++++----------------------------------
 1 file changed, 46 insertions(+), 126 deletions(-)

