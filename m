Return-Path: <linux-kernel+bounces-388144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111F29B5B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BD52842F7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F051CF5F4;
	Wed, 30 Oct 2024 05:36:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33931CF2B9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266571; cv=none; b=aXjSoHtzIkUS3BaCCcUorUO1ZtDzHuX8KiG1PKBMOTftzeVkTIuiO0zFcmPobGlD7PIxlCj1F+swuupmQV4jeCMK4SQ481UnaX2IffqvZi33mKFrNP3PEeepNt98yWK4SXj5ZfgvQL43peA3/+BmlALajCQ/h+B7NIl8RXW/qjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266571; c=relaxed/simple;
	bh=wl7rjGQW9/kucyZ/icZDg7u/6kpXX4yITb5MxwTF4C0=;
	h=Message-ID:Date:From:To:Cc:Subject; b=pd5MaFMt9dIzOxuoLkHPOX+qEoRhlxRKqWxhdEifh7+3Lt760MAaXU70wcMlTD10i8TGyQIO9odAv31Ty2I0sd+X+5/Cl3DkU+QEe5nsbzpTTjPcoAt7JEt8A6J+qXUyPwL/vKc33V+Xr+f/TkCK337F1uBL38qzXV78/4wotOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932E6C4CEE5;
	Wed, 30 Oct 2024 05:36:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t61OC-00000005BBy-2UZP;
	Wed, 30 Oct 2024 01:37:04 -0400
Message-ID: <20241030053650.956861738@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 30 Oct 2024 01:36:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/7] ftrace: Updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/for-next

Head SHA1: 8b0cb3a4c5e85dda8957ba6a4c8c081a9aec6e80


Steven Rostedt (7):
      fgraph: Separate size of ret_stack from PAGE_SIZE
      fgraph: Give ret_stack its own kmem cache
      fgraph: Use guard(mutex)(&ftrace_lock) for unregister_ftrace_graph()
      ftrace: Use guard for match_records()
      ftrace: Use guard to lock ftrace_lock in cache_mod()
      ftrace: Use guard to take the ftrace_lock in release_probe()
      ftrace: Use guard to take ftrace_lock in ftrace_graph_set_hash()

----
 kernel/trace/fgraph.c | 45 +++++++++++++++++++++++++++++++------------
 kernel/trace/ftrace.c | 53 +++++++++++++++++----------------------------------
 2 files changed, 50 insertions(+), 48 deletions(-)

