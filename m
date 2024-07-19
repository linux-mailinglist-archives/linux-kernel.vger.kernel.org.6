Return-Path: <linux-kernel+bounces-257024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7812993741E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A721F22A11
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D1482C8;
	Fri, 19 Jul 2024 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz7B43s3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712E3D984
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721371882; cv=none; b=AdVJce98qKQ+G9oJJf/7U1LZY9w9jyNKLT594/RsAHO3rZQYGXsPCWmHh70pu/2IPPYrK9mOwlF7bOWP4bGpGWzT/Q/2W7cfhuBmMEJh84K2Le9bzU0CFiFKDzhZXA1ODHdXliK9f4XJCS1V3Nv9k8z1g5EEdst++Gr2vmFQ9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721371882; c=relaxed/simple;
	bh=uAxe6CNjhk8IDZzG2Y+gccM8KHLz+eXU/ZRenoIBiTU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ajUXTN3eFBnuSa/OSsNe23f6zNZqgjs2ROoaoQIw+wIJ51ttWBNYJ0LLQN1YbP4mV4TzjhspUOTqbrQ16hYlnF5VIjPxp7aDtc2K0I3j+Oz99u1b9aOl2R2/Dy8oShofk4vpsWCWMQMRCjKroOim/hXL/01uTHICzK4P7HQKVYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz7B43s3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB61C4AF0A;
	Fri, 19 Jul 2024 06:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721371881;
	bh=uAxe6CNjhk8IDZzG2Y+gccM8KHLz+eXU/ZRenoIBiTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pz7B43s3+U5RU2/v06QkGl3KkGrtbwDQ+iTX1XQMT4KGnZFZORTDpVRwSzerzdn4R
	 4aSmanKy7kC12+9oV0ZcMZXjolsz8vCbzijU5xYJ2K2XkhNBAX4sJWEc0wJie7dOTp
	 ue2t6q1T2R8T6Ykz2jjhkQo/M5XB2QL6P1rEEy7OmU9Tj7dx+nT3rJ+5675TyP1zFc
	 r4rDo0HCcSFzO8ooGkptbXylVCYHOc9DeMXYoJkd2C8Vzuh2IJ+lHyFNxfR3EaRQWG
	 p/vwpBk1vzxPidxz66CUXr1+XEnlGb3qCtpxXDheuspJGeuqO2/7S7d3CYDHM68+dX
	 3t7sdU5cp+IRA==
Date: Fri, 19 Jul 2024 15:51:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrii Nakryiko
 <andrii@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, Jiri Olsa
 <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] probes: Updates for v6.11
Message-Id: <20240719155117.9f0266e3b3e6d186c35359d3@kernel.org>
In-Reply-To: <20240719144455.5db778b3@canb.auug.org.au>
References: <20240716234445.a17a40e8d3d7b4ba5cef949e@kernel.org>
	<20240719102824.1e086a40@canb.auug.org.au>
	<20240719105242.e3c76c4d7958b73ca3428603@kernel.org>
	<20240719144455.5db778b3@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jul 2024 14:44:55 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Masami,
> 
> On Fri, 19 Jul 2024 10:52:42 +0900 Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >
> > Ah, I missed "script/syscall.tbl". Yes, I need to update it to reserve
> > the syscall number on it. (But that did not exist on my tree...) I'll send
> > a fix. BTW should I wait for xattrat series being merged?
> 
> No need to wait.  At worst it will cause a minor conflict.

OK, here is the fix.

From 5c28424e9a348f95e3c634fe2ed6da8af29cc870 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Fri, 19 Jul 2024 14:35:51 +0900
Subject: [PATCH] syscalls: Fix to add sys_uretprobe to syscall.tbl

Add sys_uretprobe entry to scripts/syscall.tbl as same as
arch/x86/entry/syscalls/syscall_64.tbl.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20240719102824.1e086a40@canb.auug.org.au/
Fixes: 63ded110979b ("uprobe: Change uretprobe syscall scope and number")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 scripts/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

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
2.34.1


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

