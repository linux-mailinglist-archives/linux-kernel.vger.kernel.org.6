Return-Path: <linux-kernel+bounces-274649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B786A947B1C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7C0281EE9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5529B156F4A;
	Mon,  5 Aug 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="TbHQOz3H"
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA7218026
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861715; cv=none; b=ZqtI/LJU0uyhAaSPNnzmbIVg1Orl41mddfPfCZ/gxTyGK1GaKPS8jqiUypZjO1thIr4u3L92YHn6UlHG+nW4kqjngX5hAXp32c93DwD3fF/tVQxRbO+WaC1GkxjQAt3o4//CX3dPmi43Bw+En6NdLIHwCb4uB5zvwk7G63O2Y/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861715; c=relaxed/simple;
	bh=9qL1APuSU+SUpT00s7sLg/0r1Zc7TDh6jxI8ZkvnJrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ia+BaGuocSyb8LI0JSNGAhpba4skL/j3x75JX5CNl8oEnqtAI/Tz2As56WH1cCJizwtYw9J/kXDHfhx0pkYsy9vHIEkV29GGFyzp2qlhxCfYzmyj+jzX2/qEhgilLzEyx35kGsC8GHPWaTZCF7mEySJnAobVNb6s++m8AMPRw0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=TbHQOz3H; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240805124141efde5b3dbcc989403a
        for <linux-kernel@vger.kernel.org>;
        Mon, 05 Aug 2024 14:41:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=rvnMNyZLu/jU0Z0YFRyWB9GvoaymKTWjDtNi1SDjhhU=;
 b=TbHQOz3HnShUEwZz2aiA9Gm40NFvBEPv9isH+ApYLXFwnW0ksIRkQFCFnGsocay36BtEB5
 bK1COwcM8zXo4WndSsNq8GBlIAt/y6UeJwp7UDes6bYS2lkLWYXcHlzcyS0xkvvc+AzwXaMo
 HrgharkQupQwHmg3Yyf8NHGDwEdUYndQcJBeEhQNkT+FK9LCDBjiceeY+VcAWe/L9CfImwRU
 1pkLRnbiwZ6k35r0lh/hvLgH1YSSza6XwlhRNJO9a1x5qJc4SV0qkA3tpJjSiL3kcV6FOPWc
 WI98118AxpAlqFDi5Ay7mCmDGiRliV6xGladpnZTB8de7yCBh6ltGk5g==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH 0/2] hrtimer: More fixes for handling of timer slack of rt tasks
Date: Mon,  5 Aug 2024 14:41:14 +0200
Message-Id: <20240805124116.21394-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

This series fixes the (hopefully) last location of an incorrectly
handled timer slack on rt tasks in hrtimer_start_range_ns(), which was
uncovered by a userland change in glibc 2.33. Along that, the patch documents,
that currently all tasks with rt priority should ignore the timer slack.

For me, it is unclear though, if this behavior is actually intended, as
also PI boosted tasks that create or reprogram timers ignore the timer slack.
While I guess this does not have an effect in most cases, it is at least
a lost performance optimization chance. Instead, ignoring the timer
slack could be limited to tasks with RT/DL scheduling policies.

Best regards,
Felix Moessbauer
Siemens AG

Felix Moessbauer (2):
  hrtimer: Document, that PI boosted tasks have no timer slack
  hrtimer: Ignore slack time for RT tasks in hrtimer_start_range_ns()

 kernel/time/hrtimer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.39.2


