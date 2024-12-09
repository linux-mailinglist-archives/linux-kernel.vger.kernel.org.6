Return-Path: <linux-kernel+bounces-437316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0489E91A8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9DE282873
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1C221A95C;
	Mon,  9 Dec 2024 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ElWtmYlm"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668C21A945
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742415; cv=none; b=UCMNazLE+2aX8r8xwGBUIKisxbOkJf2kJcSpFKlgm3bn5uqVS7ZSu3a089+h+yeikzWTmb3edbWXT99VNqDimzhTNm+m2IMhVmu03h07GWi+Oa0JyT6aOC8OHsRIh2Zxff/r5EiSHahS7fEemwdRlIdP6GIp89NaxsRxv/YlUts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742415; c=relaxed/simple;
	bh=TU6+vySM4nySSmeA3VhBnKPmr6s/mMPOzKam09vQ5D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BPIKF0gi+2Di+gtx2by3Ecqigpcfukfi6Ua2ScL64USLQIiZofv1z3WVZizIbmoVdVf7QnthVL8BKzkS6fdje8yuUkkSpT3rBdhF966VY3Ozvf6wzWaj+gUcJJQocN+4TfqIzqI6UONwmDpEuzhxPZaqX67q65/OF0OtvCmqmoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ElWtmYlm; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733742412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ah/rJqBs5srJWlpxLWyJKbQtaaqJ3bAYyDKZWXDICwU=;
	b=ElWtmYlmf/PXEgxh1Gb3WfsCxdQfm4EziZY4iBm+SbJ3t8PW+xqF4HqY2i6lIGCD+vbKCq
	deUGKC+zW7j5uiTaG0Zzp8WTWmH+E31Ae0/cgiNEuyrjLO30ho0lKBkVdCzGHeZntX5IWq
	A3oS/8ZIQ73ORP10nmZmzxMZpt7xA+A=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] nios2: Use str_yes_no() helper in show_cpuinfo()
Date: Mon,  9 Dec 2024 12:06:39 +0100
Message-ID: <20241209110640.39956-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/nios2/kernel/cpuinfo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/nios2/kernel/cpuinfo.c b/arch/nios2/kernel/cpuinfo.c
index 338849c430a5..7b1e8f9128e9 100644
--- a/arch/nios2/kernel/cpuinfo.c
+++ b/arch/nios2/kernel/cpuinfo.c
@@ -143,11 +143,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		   " DIV:\t\t%s\n"
 		   " BMX:\t\t%s\n"
 		   " CDX:\t\t%s\n",
-		   cpuinfo.has_mul ? "yes" : "no",
-		   cpuinfo.has_mulx ? "yes" : "no",
-		   cpuinfo.has_div ? "yes" : "no",
-		   cpuinfo.has_bmx ? "yes" : "no",
-		   cpuinfo.has_cdx ? "yes" : "no");
+		   str_yes_no(cpuinfo.has_mul),
+		   str_yes_no(cpuinfo.has_mulx),
+		   str_yes_no(cpuinfo.has_div),
+		   str_yes_no(cpuinfo.has_bmx),
+		   str_yes_no(cpuinfo.has_cdx));
 
 	seq_printf(m,
 		   "Icache:\t\t%ukB, line length: %u\n",
-- 
2.47.1


