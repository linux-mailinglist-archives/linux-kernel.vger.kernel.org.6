Return-Path: <linux-kernel+bounces-169698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2998BCC4B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100B01F23214
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19AA142E9C;
	Mon,  6 May 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="qOBTu5L6"
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FDA14262C;
	Mon,  6 May 2024 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992382; cv=none; b=teoHeD27idBArbO1K1Oo+1/1YZi4eGJnQh+Q3booxPFKH+36ddWEyDzQ1gjMS31dLrYHRooHtcwLGApTtd0JIUgJXfpFa1vmBF4ACwo7DQtfZou+GKk3e2lnW6hOf5q74h6XM01tS0mjFvrmZmkwgZ6omiFJT46a7tmrDGWrlwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992382; c=relaxed/simple;
	bh=G/JCFcFpL07kX/Bu59NZ0cXDqLo/7av9bnNEswh8Xn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFmUjSBpizgUV4Ut8yE9byAOQCCuJ2Cfsw/rl1DFZCM6pEEGPwq3hP+8t6ZjhBVZeVJPXTkvcCxcTGfD2n5KlzTGTE01gzxCLLfFBSmMassSOsZPE7bIMdkyQr2opRkOyeSibPRuDpwcJlyuCyJJOu2qkbANyQhRTpt48coSySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=qOBTu5L6; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 59369DB45B;
	Mon,  6 May 2024 12:46:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1714992371; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=KdiFXDoiLe1fUJSlZpdwlS+o1eaxJbtolBrFnTvBjmY=;
	b=qOBTu5L649117Qag2HcMFLsZRnyZ2Iizbk/6TtKOW5vNE4u9eMfebwiEn/6AX/sgkyCO+d
	/4a6sWAtChrhCGeTVYR9lV28E1OvzeoeEeVDhhtLxlJ4E4T0qHRu/YxZjKWp7lJ0a+Dm4/
	tBImiWF9RNjHIlAeWIC2vrLrgO27r11dlrPgOQm3RmoxV1HXa5Xt9MB5PWXeXafCT/54si
	g8trQvpPqjNorNgujewOl+Rp9wKkWFwo6mmk5KQ8rqm4qHyl0mzLpiU7ZoouUyqSL5Y4Ou
	37RpwJv5fBrIroFJVs74L/CGrMVJtN3/Vgah09vb9A8xHd0HuDKbhe1kWSnHKg==
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>,
	 <linux-rt-users@vger.kernel.org>,
	 <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 1/1] Linux 4.19.312-rt134
Date: Mon,  6 May 2024 12:46:02 +0200
Message-ID: <20240506104602.16972-2-wagi@monom.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506104602.16972-1-wagi@monom.org>
References: <20240506104602.16972-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

v4.19.312-rt134-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index c2c7e0fb6685..6067da4c8c99 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt133
+-rt134
-- 
2.44.0


