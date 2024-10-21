Return-Path: <linux-kernel+bounces-374604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C539A6D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079A4281B53
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC211FA254;
	Mon, 21 Oct 2024 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3VNshhq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD391D517D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522539; cv=none; b=BRUC2WPVdZmlagmbDakbKrX85N1JSrNNYpFfT1vefUGnCbxsc4PaMkQdoOYMA3i+9VT5SnQt8GvEmnx2vtijfGXelg9xqCPColv5QctHud+bF5GN0Wy3q8se1a2iFujQU57qLVfvN0qBpLSLnI6RNF5f+CEYmEhKscFVfOQVe0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522539; c=relaxed/simple;
	bh=u5jelveERIqRBb4smc0AMLIvWXytoSD8Dxmebvzx/8M=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=K/5ncuoSpQ7dybu8Iz2l5G8XXif7tBK6fkMyS/RgJ7s36qEj/wRxjiM78dKfs70AJgSZI6Ge5lYR5l5nzLnEaZr+EtbAQXTiF9WDBjmOg3XFNKAihQbt8Nzl1GDso2gDnwK6iBRQ2uoejtIQ5MWE8+mSA0JiLOF/1gln/JQsfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3VNshhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD54C4CEC3;
	Mon, 21 Oct 2024 14:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729522538;
	bh=u5jelveERIqRBb4smc0AMLIvWXytoSD8Dxmebvzx/8M=;
	h=Date:From:To:Cc:Subject:From;
	b=O3VNshhqkzFVAclJf0cDAvqWo2mAlLI9klC18M5YJHBQlG3IpN5TGHqJC6XxHRpzG
	 7fWiFtc+Y6ZLwLLoPTrhU+KlKaKke7r8KrJnAScUJrhdNhv2Bvd0EPvzdmnl7dwX8q
	 K28jr9oVqGjVQ3R9XFoWu8jvtPiaETC0HBPZSlrzf5WUtN6DW6GI+/z+wpmQHruhwS
	 ykXdEIN4MEIGwsBObcHmPxW1OQZoc3itVl/thG9kFCALn6iAz91yJ7FFOFLElDqbvY
	 HvSF5UOmcgPJ+o5/eLFmnjLvxR028iG/qRh+76p/3irPpka6vcQ1ukNP3SIeCDe3eP
	 Y9vwJU0jJkkog==
Date: Mon, 21 Oct 2024 23:55:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Qiao Ma <mqaio@linux.alibaba.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.12-rc4
Message-Id: <20241021235534.e5e55cffca4113ff0081e99b@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Linus,

Probes fixes for v6.12-rc4:

- uprobe: avoid out-of-bounds memory access of fetching args
  Uprobe trace events can cause out-of-bounds memory access when fetching
  user-space data which is bigger than one page, because it does not check
  the local CPU buffer size when reading the data. This checks the read
  data size and cut it down to the local CPU buffer size.


Please pull the latest probes-fixes-v6.12-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.12-rc4

Tag SHA1: 7490126e350b20cee68a1437bc1a43788e2c4ae5
Head SHA1: 373b9338c9722a368925d83bc622c596896b328e


Qiao Ma (1):
      uprobe: avoid out-of-bounds memory access of fetching args

----
 kernel/trace/trace_uprobe.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

