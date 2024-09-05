Return-Path: <linux-kernel+bounces-317855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C29DD96E491
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 526A1B2207C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36EA19FA81;
	Thu,  5 Sep 2024 21:03:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D90C9443
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725570209; cv=none; b=IpSqURe+D3dvRUO8E1T3PuZKZj9W3/vwUclW+f9QzZvfSs+9JJnmhuQtzXetVi/Zcq2poApuG3ISKmiCAEwWZwqbmqChn2vsHEqM+HuP8gLzsmj4L9nbsHH6UY4GukJ9frSlJ5zI6OvwsROapYYh5r7joDO1T0oH5wSRxlCzdlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725570209; c=relaxed/simple;
	bh=XMTiBzkNbhKzHRU0YSU0/zsL2ks0tjzUjokZS0O505c=;
	h=Message-ID:Date:From:To:Cc:Subject; b=baaL1Cd1mnwomM7HfgkXCRpNBLfej5KoBw8c7OHRAQdTcZGKw5Zjt+qzGSkVpQU5UByt6Ct2uiUgyi95XTgaFRm278kDPyFCVyTyivg41BHvuaQtrrGE/2e4jFixypj9EI22lnOvWKmSTVcQnzaf35jfWG9VE+reehrXzoIy3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B21C4CEC3;
	Thu,  5 Sep 2024 21:03:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1smJea-00000005KoM-1f7g;
	Thu, 05 Sep 2024 17:04:32 -0400
Message-ID: <20240905210412.128465542@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 05 Sep 2024 17:04:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: Some more updates for 6.11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


A couple more fixes for 6.11:

- V2 of the update of the clearing of the timer lock. Need to grab
  the interface_lock when clearing the itmer in tlat_var_reset()

- Need to take the interface_lock in stop_threads() to sync with the
  timerlat updates.

Steven Rostedt (2):
      tracing/timerlat: Only clear timer if a kthread exists
      tracing/timerlat: Add interface_lock around clearing of kthread in stop_kthread()

----
 kernel/trace/trace_osnoise.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

