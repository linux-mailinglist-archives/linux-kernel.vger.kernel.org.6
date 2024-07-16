Return-Path: <linux-kernel+bounces-254150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482F932F85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EA3B21220
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE8A1A00FF;
	Tue, 16 Jul 2024 17:56:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8718A13CA99
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152610; cv=none; b=aZ5he24vzvKbwTXCRcT3Z2ZtoipVl4MqIe52+tpjLxBSMUm7SkveL13ODsekeOlWTZuJx6bAy0P/M/mGdw5/OHCTNfua7442Ev+/13s/yh6sJKYL2Rg12BqxgxSyBlOsXHr/oSAN155/k8L1I/hnZopNHkvsL8iPIcBZPhraizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152610; c=relaxed/simple;
	bh=zSk1mhPSq3TEzWAeCOKHZfbh/UTenRVbDjRt0RwXWEg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=QtnUjIoVnhHm6+eW7mRvvnBgsfebro8iKOrHGiuSI3pvLTgIIVnUJwilS6vqFpTU49K07krTvgVoYFhFkK0+WvwMF69nBXQvuMiI6uhkb2y7dnRkH650uWrjflTin/LhcQVuRRhcb7xgnYhN9Z+IPJ/HoMHfGj4gQ2Zea8oykaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3135C116B1;
	Tue, 16 Jul 2024 17:56:47 +0000 (UTC)
Date: Tue, 16 Jul 2024 13:56:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jiapeng Chong
 <jiapeng.chong@linux.alibaba.com>
Subject: [for-next][PATCH] fgraph: Use str_plural() in
 test_graph_storage_single()
Message-ID: <20240716135630.77e3355f@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/for-next

Head SHA1: b576d375b536568c85d42c15a189f6b6fdd75b74


Jiapeng Chong (1):
      fgraph: Use str_plural() in test_graph_storage_single()

----
 kernel/trace/trace_selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit b576d375b536568c85d42c15a189f6b6fdd75b74
Author: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Date:   Tue Jun 18 15:20:14 2024 +0800

    fgraph: Use str_plural() in test_graph_storage_single()
    
    Use existing str_plural() function rather than duplicating its
    implementation.
    
    ./kernel/trace/trace_selftest.c:880:56-60: opportunity for str_plural(size).
    
    Link: https://lore.kernel.org/linux-trace-kernel/20240618072014.20855-1-jiapeng.chong@linux.alibaba.com
    
    Reported-by: Abaci Robot <abaci@linux.alibaba.com>
    Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9349
    Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
    Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index adf0f436d84b..97f1e4bc47dc 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -877,7 +877,7 @@ static int __init test_graph_storage_single(struct fgraph_fixture *fixture)
 	int ret;
 
 	pr_cont("PASSED\n");
-	pr_info("Testing fgraph storage of %d byte%s: ", size, size > 1 ? "s" : "");
+	pr_info("Testing fgraph storage of %d byte%s: ", size, str_plural(size));
 
 	ret = init_fgraph_fixture(fixture);
 	if (ret && ret != -ENODEV) {

