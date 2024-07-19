Return-Path: <linux-kernel+bounces-257199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34BC937693
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FD428220D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0694482D69;
	Fri, 19 Jul 2024 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFRr52oZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC36EEC0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721384563; cv=none; b=bg7q/tWCmQioqRT/NX1xL0cy4nQIW2PYCf8hwyyobaKYMNBhLBTlm0KHMAOFQVfz2+UDweq/lc0XWa0rXDC7xlY41TpRvPUofi8LcoPv21KHDxi2C60Kol75dWUEwCPHVtbKneLYnXj5spz7T6+hIUvN8fRL9RLXz/cWuElCsB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721384563; c=relaxed/simple;
	bh=5Y6Inw7h4aNk0l6XAbpTpmLy8D3tP0XjXN7Tc7eVKXc=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=VvXV4w+/3TJnSU/gA+x1ohgnpCBYYkZ0HIQq/VC61ir2qZOwWo8fyZyUouWTjNAHUxYsU4/e0e2VDVm24g0w7jaLp0rtlBjAonH/FnguUWVWR76XEDcKcNEBXf897OKnk6YND/ZFqRceDv5hEcu6jQsS+7vFgJkl7QgZIgaxyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFRr52oZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A665CC32782;
	Fri, 19 Jul 2024 10:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721384562;
	bh=5Y6Inw7h4aNk0l6XAbpTpmLy8D3tP0XjXN7Tc7eVKXc=;
	h=Date:From:To:Cc:Subject:From;
	b=HFRr52oZLgMUItbyIzhH0oTW46HxlYrz/sZuatlulm97GIgfUi4NOPH+xKaJPE+dU
	 eMGsWBWYkG56w2OxGux+EPL7qL24lQzewsMFZPPXk0cEHvOhDmPboJED8NlhSD3HqR
	 RncTDZ6eTIaRWcnCdIa7YJiyUnVgGMVruI3S9DA4Zr7Zg4EpIgpokJNlknuFaxOuwl
	 Oa74n7Fa3xRM9kw8eHHagGfYeBXL85ZDtes8wguIS8RjsLTIgDlWIMNwa0/ysl2IgA
	 eQDpVdFhkndqJxyl82tDN09N83urfzFHzN1fkKFYLaI42cn0VmdNMUfhjtea4l30oj
	 oZ7uqiMSuMxhA==
Date: Fri, 19 Jul 2024 19:22:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, Jiri Olsa
 <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fix for v6.11 pre-rc1
Message-Id: <20240719192238.96266f98f6b96cccfe3fb038@kernel.org>
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

Probes fixes for v6.11 pre-rc1:

- uprobe: Add sys_uretprobe entry to scripts/syscall.tbl.


Please pull the latest probes-fixes-v6.11-pre-rc tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.11-pre-rc

Tag SHA1: 4f9c2075da85cb89b4c36fc11250b803d979f345
Head SHA1: 5c28424e9a348f95e3c634fe2ed6da8af29cc870


Masami Hiramatsu (Google) (1):
      syscalls: Fix to add sys_uretprobe to syscall.tbl

----
 scripts/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)
---------------------------
commit 5c28424e9a348f95e3c634fe2ed6da8af29cc870
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Date:   Fri Jul 19 14:35:51 2024 +0900

    syscalls: Fix to add sys_uretprobe to syscall.tbl
    
    Add sys_uretprobe entry to scripts/syscall.tbl as same as
    arch/x86/entry/syscalls/syscall_64.tbl.
    
    Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Closes: https://lore.kernel.org/all/20240719102824.1e086a40@canb.auug.org.au/
    Fixes: 63ded110979b ("uprobe: Change uretprobe syscall scope and number")
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 797e20ea99a2..591d85e8ca7e 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -402,3 +402,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+467	common	uretprobe			sys_uretprobe
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

