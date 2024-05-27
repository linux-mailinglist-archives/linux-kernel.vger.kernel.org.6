Return-Path: <linux-kernel+bounces-191504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7648D106F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9751F21E55
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5267C167267;
	Mon, 27 May 2024 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgGDdJqt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DBB383B1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716851449; cv=none; b=LmkZFCeXMcDteT4xU7ekHHM1hSUDpkqvX8iH1RkKx+vCZBnAXBkykj6FAOo8obDSfPIJKnPiEXwKP67qTyXoUJbC1Yr7CKLuKjsT2VH5hKzLgbPDLzO4MCJMmK18nyrnZnD9EJQpxWK95KAc0qxvzrJ6py96zwpMLGJwxapOpao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716851449; c=relaxed/simple;
	bh=RFEMcuP2eTdQG3rCRF/XncUOHdRSP50IIGauX333D0U=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=K5EpkMv15Lth/1vFu2+dc5H2dZmge4G8/ew6Xz8Cs4+dscvUkneK2K+BxzINsh+sCuINpd4wCrDatUoafTXfiBMHr8LgPAsq5N7exkb0KuDypBktFqpJmQI2TvmNX/qlWrcfhgu4XRBVid21xoNXDA+vYZgNXkTQHBrDj9wvgG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgGDdJqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61326C2BBFC;
	Mon, 27 May 2024 23:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716851449;
	bh=RFEMcuP2eTdQG3rCRF/XncUOHdRSP50IIGauX333D0U=;
	h=Date:From:To:Cc:Subject:From;
	b=lgGDdJqtDw9QXoMtEO3EOJTYRq42e6tJAkheVN1Y6xV1RiE96qaUcWvBCszDqEeYo
	 WwVeTzkVTwTCpuTmxf0uEI1fbaW78N20Cpxy9STJM1TmuLvtiT2j2q75mQgZqD3FVA
	 eHTNz5V0upHmFTwsAguuqfPp0fD/a7DwPoxMhxNkpLJpRGhoWb7kbZP8Fh9JK+dZl9
	 BF1N92DtydEJRMtK6GHwlJT8E+HhCjb9wz0f2CIr8leQfmMTPvycaLETIEClx18w81
	 mgonUK6TxqPHQdN1mh1O3w9vjzrBjAGj1CIVCCOcXILP2stVB45WSvVenSu+gGSFt9
	 pQ4hNSrS0ONBQ==
Date: Tue, 28 May 2024 08:10:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Carlos =?UTF-8?B?TMOzcGV6?=
 <clopez@suse.de>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.10-rc1
Message-Id: <20240528081044.aa2ad32fbec8e15e2144d5f4@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Probes fixes for v6.10-rc1:

- uprobes: prevent mutex_lock() under rcu_read_lock(). Recent changes moves
  uprobe_cpu_buffer preparation which involves mutex_lock(), under
  __uprobe_trace_func() which is called inside rcu_read_lock(). Fix it
  by moving uprobe_cpu_buffer preparation outside of __uprobe_trace_func().

- kprobe-events: Fix to handle the error case of btf_find_struct_member().


Please pull the latest probes-fixes-v6.10-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.10-rc1

Tag SHA1: bb80683f3a93708ce63bae89b6c712a1a8ff1c43
Head SHA1: e569eb34970281438e2b48a3ef11c87459fcfbcb


Andrii Nakryiko (1):
      uprobes: prevent mutex_lock() under rcu_read_lock()

Carlos López (1):
      tracing/probes: fix error check in parse_btf_field()

----
 kernel/trace/trace_probe.c  |  4 ++++
 kernel/trace/trace_uprobe.c | 14 +++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

