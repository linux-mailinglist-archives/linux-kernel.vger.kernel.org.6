Return-Path: <linux-kernel+bounces-344402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC49698A91F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5341C20CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D043191F86;
	Mon, 30 Sep 2024 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovHoYmIb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F029313634C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711607; cv=none; b=tYIrDSB9VMwCQYeMLTPTJVLxHKH3TXMWA03tjdEXVBF4/Tli2E14RcZ/FPbCh5YvNmeEvQ73US3hS8eXwBwPgsUg8Oq+4trnlaWxBuJayBdMcUAqHD5H+WLpMQRYxLwoxUSbq4dMd5SeTxf8WBvTkRn5PNtUstX2FoMS239gLWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711607; c=relaxed/simple;
	bh=uqoeDHKKRnzeK3NPDWxHHqqdgMPVpHX+ICXcGKVH8TE=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=Hmhp1rPP4KJs5MCuS5Qri5/6ZuneXe2V8NqIaDi0BT20/JTHBdYS4ZJk30Jco9kpP1B2beXRUtbeV8GpZw06c8ESHFJsRRM/LRX0SSNdnd3mInnQKX53ewvJvUIbXAsSXpQVPueONQIaUj6LwEAU3PXRveHjDnFm5uZxpb4HHkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovHoYmIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F28C4CEC7;
	Mon, 30 Sep 2024 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727711606;
	bh=uqoeDHKKRnzeK3NPDWxHHqqdgMPVpHX+ICXcGKVH8TE=;
	h=Date:From:To:Cc:Subject:From;
	b=ovHoYmIbkp6UlG+5UsefR2LWllKnscn/OjCDLuAhtA61T2jAHJSXRA9x4hP+BSmdh
	 pN3zpIa+cRCYsCTJ0GGpaRRMc3xBoH65S8a69OxOIx4g7h7mAp8l+H6ffe6+rEAwJk
	 cnNWIcDRDti8XFSrQMpuJmV2xjRFxJ6y7ltMUGm03bAsM+m9MDTJ4Tpr5jVVoPHB+6
	 1CSwhVBFYao9s/WhLbHeve+/A1Z5aJ4YAWnbWmX5GXyHSD94AG/SdPfTWSmnhRc0wy
	 Q/YNPDbgJ0NomQUSbZ4xy7dJu+luGmxtgCKxuvMMcJ2E3sF5CUch/8Rb/YZvUgamCV
	 wXG5Cux1TFauQ==
Date: Tue, 1 Oct 2024 00:53:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.12-rc1
Message-Id: <20241001005322.9e65df06e0f7c4aac19337ca@kernel.org>
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

Probes fixes for v6.12-rc1:

 - uprobes: fix kernel info leak via "[uprobes]" vma
   Fix uprobes not to expose the uninitialized page for trampoline
   buffer to user space, which can leak kernel info.


Please pull the latest probes-fixes-v6.12-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.12-rc1

Tag SHA1: ee48a9b9cc6cb804d0a49359b8d85290020b72e2
Head SHA1: 34820304cc2cd1804ee1f8f3504ec77813d29c8e


Oleg Nesterov (1):
      uprobes: fix kernel info leak via "[uprobes]" vma

----
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit 34820304cc2cd1804ee1f8f3504ec77813d29c8e
Author: Oleg Nesterov <oleg@redhat.com>
Date:   Sun Sep 29 18:20:47 2024 +0200

    uprobes: fix kernel info leak via "[uprobes]" vma
    
    xol_add_vma() maps the uninitialized page allocated by __create_xol_area()
    into userspace. On some architectures (x86) this memory is readable even
    without VM_READ, VM_EXEC results in the same pgprot_t as VM_EXEC|VM_READ,
    although this doesn't really matter, debugger can read this memory anyway.
    
    Link: https://lore.kernel.org/all/20240929162047.GA12611@redhat.com/
    
    Reported-by: Will Deacon <will@kernel.org>
    Fixes: d4b3b6384f98 ("uprobes/core: Allocate XOL slots for uprobes use")
    Cc: stable@vger.kernel.org
    Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
    Signed-off-by: Oleg Nesterov <oleg@redhat.com>
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2ec796e2f055..4b52cb2ae6d6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1545,7 +1545,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	if (!area->bitmap)
 		goto free_area;
 
-	area->page = alloc_page(GFP_HIGHUSER);
+	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
 	if (!area->page)
 		goto free_bitmap;
 

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

