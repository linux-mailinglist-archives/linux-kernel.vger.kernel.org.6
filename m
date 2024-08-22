Return-Path: <linux-kernel+bounces-296746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB7E95AE75
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9563F282DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242A0149012;
	Thu, 22 Aug 2024 07:13:05 +0000 (UTC)
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E8AB71CAA6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310784; cv=none; b=R+6H8dFg428Lp5twnpj0KoZ9TvjqRBomEIjy1NJWzJ2nq9Urat/FmAQ/BZtHKzLdo44wmNml1Er+rQXMSI9FAempkifft+Baej1BHesGf9hE2CXvkyfz4Zc1Bro1K7JZy5COYbpxzWbh0NFdiMjSMbHPyJPfaE/6JKADRFIVvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310784; c=relaxed/simple;
	bh=6V7R9WRDaC5qqyqeluu9YL5mf4JiUhdO+sm6KJdD2fI=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uEr7atDlXM37Vy1PoN38/HJd+ULg02vJ/P4b+HxQv3HjVMmWSYWOfO0LPj/XoH0BFP1zvlNPHyN0shF/HHmFmfdHHEQ0yCfnlpL/AmbXP8vaKBDYa2/RdOVtuPK3/TECkOMuOAcipnAFaDrUkckdoLgVZE/d7oC6oqfoKODih/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 65B4B184A78855;
	Thu, 22 Aug 2024 15:09:42 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.65.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 15:09:51 +0800
Date: Thu, 22 Aug 2024 15:09:44 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: Tio Zhang <tiozhang@didiglobal.com>
To: <akpm@linux-foundation.org>, <dianders@chromium.org>
CC: <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
	<zyhtheonly@gmail.com>, <tiozhang@didiglobal.com>, <zyhtheonly@yeah.net>
Subject: [PATCH] watchdog: when watchdog_enabled is 0, let (soft,nmi)switch
 remain 1 after we read them in proc
Message-ID: <20240822070944.GA13716@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: akpm@linux-foundation.org, dianders@chromium.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	zyhtheonly@gmail.com, zyhtheonly@yeah.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: ZJY03-PUBMBX-01.didichuxing.com (10.79.71.12) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)

For users set "watchdog_user_enabled=0" but remaining
"(soft,nmi)watchdog_user_enabled=1". Watchdog threads(,nmi watchdog)
rework only if users reset "watchdog_user_enabled=1" without printing
those watchdog swicthes. Otherwise (soft,nmi)watchdog_user_enabled
will turn to 0 because of printing their values (It makes sense to print 0
since they do not work any more, but it does not make sense to let user's
swicthes change to 0 only by prints).

And after that, watchdog only should work again by doing:
(soft,nmi)watchdog_user_enabled=1
*** can't print, or everything go back to 0 again ***
watchdog_user_enabled=1

So this patch fixes this situation:

| name                       | value
|----------------------------|--------------------------
| watchdog_enabled           | 0
|----------------------------|--------------------------
| nmi_watchdog_user_enabled  | 1
|----------------------------|--------------------------
| soft_watchdog_user_enabled | 1
|----------------------------|--------------------------
| watchdog_user_enabled      | 0
|----------------------------|--------------------------
    
            cat /proc/sys/kernel/*watchdog
                          |
                          |
                          V
| name                       | value
|----------------------------|--------------------------
| watchdog_enabled           | 0
|----------------------------|--------------------------
| nmi_watchdog_user_enabled  | 0
|----------------------------|--------------------------
| soft_watchdog_user_enabled | 0
|----------------------------|--------------------------
| watchdog_user_enabled      | 0
|----------------------------|--------------------------


Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 kernel/watchdog.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 51915b44ac73..42e69e83e76d 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -995,8 +995,18 @@ static int proc_watchdog_common(int which, struct ctl_table *table, int write,
 		 * On read synchronize the userspace interface. This is a
 		 * racy snapshot.
 		 */
+		old = READ_ONCE(*param);
 		*param = (watchdog_enabled & which) != 0;
 		err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+		/*
+		 * When "old" is 1 and watchdog_enabled is 0,
+		 * it should not be change to 0 for printing
+		 * nmi_watchdog_user_enabled or soft_watchdog_user_enabled.
+		 * So after we print it as 0,
+		 * we should recover it to 1.
+		 */
+		if (old && !watchdog_enabled)
+			*param = old;
 	} else {
 		old = READ_ONCE(*param);
 		err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-- 
2.17.1


