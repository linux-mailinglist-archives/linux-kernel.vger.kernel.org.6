Return-Path: <linux-kernel+bounces-221204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0456790F03D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DF61C20E65
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE7617556;
	Wed, 19 Jun 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnJ3+MZ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647BE1CD11
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806871; cv=none; b=uUDErdPFmIIkcOVx7JqbAFaKGZIzGN0SNOCv1auw+IB4E05Xw1Nmv8i2FMeiCkxMj7PT8TJ4qTUcs2uXS2sO1GumqDwmapyT76+HeILPmKoTa17FVkRMm8EzI6DgdQBZjqcx7vogwVFEeI/Abu5c3H7mLwdd1DVuPyzvoGlRXaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806871; c=relaxed/simple;
	bh=1pa1Rg3EEdZO0MwDNVmgK7Br/MlmULENPwmjX4iSk3M=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=Y1ZoD9OSW9v19f+p1kDTu3D8wI5aCEZwzssfpT/Qms63+X4bu2jFvEEwKOBVzaAE3xQgWN47PfbuS7dvYPg0L7b1rruShjryKHZ0k/YX6UJZDJ8baYFos1N3zXVptFZz6AW3ghNNnWVsp4lgOeL6NgiVUiNt1s9vsZAPPhfw8dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnJ3+MZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4673DC2BBFC;
	Wed, 19 Jun 2024 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718806870;
	bh=1pa1Rg3EEdZO0MwDNVmgK7Br/MlmULENPwmjX4iSk3M=;
	h=Date:From:To:Cc:Subject:From;
	b=FnJ3+MZ3yYz9cc8tai+EjHGToce74I1jmQMxVwu55cHPezEtZKLAxTX1M9CR8RB4/
	 Ig5DtPt+8uTITkWrMtSQH7xzIgyVBO+uhhUL/nSzJ8z5PnIJYfb5zuGg0wvYIbMHc2
	 CQUp+1y+eRIZDyy7C+hKd1XejccBDJ012l6JVNToxslzjay7aPCEsQUsNsEEXjXZnM
	 s8IX7aAOGx0UAiYKzsTrGpRkZ64rrulzX2TkPHH5GTc8CexiIGXlN4XP/X572hPO+j
	 deqFIVgHukjbWBUFcX6BFF+KP1+rzX/Kc7sVduyGvoybG8rRlwe6lUeTNeG4iZd+vW
	 HzLsJtLh0Gtzg==
Date: Wed, 19 Jun 2024 23:21:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.10-rc4
Message-Id: <20240619232107.bbb51e397b9896454a2c66a3@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes fixes for v6.10-rc4:

- Restrict gen-API tests for synthetic and kprobe events to only be built as
  modules, as they generate dynamic events that cannot be removed, causing
  ftracetest and startup selftests to fail.


Please pull the latest probes-fixes-v6.10-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.10-rc4

Tag SHA1: c5688fd601f3e7bc8b233db1b67d2d48abfdc683
Head SHA1: 3572bd5689b0812b161b40279e39ca5b66d73e88


Masami Hiramatsu (Google) (1):
      tracing: Build event generation tests only as modules

----
 kernel/trace/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

