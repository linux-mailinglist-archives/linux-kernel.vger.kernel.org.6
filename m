Return-Path: <linux-kernel+bounces-318582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3DD96F01F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98F81C21081
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4B9156F57;
	Fri,  6 Sep 2024 09:47:20 +0000 (UTC)
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 65A1141A8F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616040; cv=none; b=MUK7GcawgK6mvnAi6MFuvoM7CwgR9JWYDXzpa0naj4KJNuR/v/odsqhPdgYKT78JPEOjzopW/L08d0975l2g2/ZoEMP+FrbL9cPgsI2FgQrhWpotQ/vfrXRKTtYubwEPZNM8crmtRFOcYTR4JFGkNJSZIcYOBv2IMuwxR9M1sIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616040; c=relaxed/simple;
	bh=LuQosShwQuJFIYgyfLWKF8xsGn/wx9lb/Psp6NDSHcg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WQhZn1MU5gxfToHCfi2FzV02FXvxdl/iTr4/DqBaAINxdl9jyWcX/XQ74bBTQhIoZOcExnL9p2AfPUfTiyg29wkvb2C7bt6asWIFBTcpsjaI8vZ57Ew15cjrstphShZYyD5g41UG0xDNQ6Na8QQjyc3cXia2677m/WrckKj9liU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.19])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 2CAD318B081ED5;
	Fri,  6 Sep 2024 17:46:59 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.65.101) by
 BJ02-ACTMBX-01.didichuxing.com (10.79.65.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Sep 2024 17:47:08 +0800
Date: Fri, 6 Sep 2024 17:47:00 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.19
From: Tio Zhang <tiozhang@didiglobal.com>
To: <dianders@chromium.org>
CC: <akpm@linux-foundation.org>, <bristot@redhat.com>, <bsegall@google.com>,
	<dietmar.eggemann@arm.com>, <john.ogness@linutronix.de>,
	<juri.lelli@redhat.com>, <kjlx@templeofstupid.com>,
	<linux-kernel@vger.kernel.org>, <linux@weissschuh.net>,
	<lizhe.67@bytedance.com>, <mcgrof@kernel.org>, <mgorman@suse.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <rostedt@goodmis.org>,
	<tglx@linutronix.de>, <tiozhang@didiglobal.com>,
	<vincent.guittot@linaro.org>, <vschneid@redhat.com>, <zyhtheonly@gmail.com>,
	<zyhtheonly@yeah.net>
Subject: [PATCH v2 1/1] kernel/watchdog: always restore
 watchdog_softlockup(,hardlockup)_user_enabled after proc show
Message-ID: <20240906094700.GA30052@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: dianders@chromium.org, akpm@linux-foundation.org,
	bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
	john.ogness@linutronix.de, juri.lelli@redhat.com,
	kjlx@templeofstupid.com, linux-kernel@vger.kernel.org,
	linux@weissschuh.net, lizhe.67@bytedance.com, mcgrof@kernel.org,
	mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, tglx@linutronix.de, vincent.guittot@linaro.org,
	vschneid@redhat.com, zyhtheonly@gmail.com, zyhtheonly@yeah.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAD=FV=Vw1fG9sUiG4R6LiKnR2fgnt5Wr4QKzRg+v8MC15pWUEg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BJ03-PUBMBX-01.didichuxing.com (10.79.71.11) To
 BJ02-ACTMBX-01.didichuxing.com (10.79.65.19)

Otherwise when watchdog_enabled becomes 0,
watchdog_softlockup(,hardlockup)_user_enabled will changes to 0 after
proc show.

Steps to reproduce:

  step 1:
  # cat /proc/sys/kernel/*watchdog
  1
  1
  1

  | name                             | value
  |----------------------------------|--------------------------
  | watchdog_enabled                 | 1
  |----------------------------------|--------------------------
  | watchdog_hardlockup_user_enabled | 1
  |----------------------------------|--------------------------
  | watchdog_softlockup_user_enabled | 1
  |----------------------------------|--------------------------
  | watchdog_user_enabled            | 1
  |----------------------------------|--------------------------

  step 2:
  # echo 0 > /proc/sys/kernel/watchdog

  | name                             | value
  |----------------------------------|--------------------------
  | watchdog_enabled                 | 0
  |----------------------------------|--------------------------
  | watchdog_hardlockup_user_enabled | 1
  |----------------------------------|--------------------------
  | watchdog_softlockup_user_enabled | 1
  |----------------------------------|--------------------------
  | watchdog_user_enabled            | 0
  |----------------------------------|--------------------------

  step 3:
  # cat /proc/sys/kernel/*watchdog
  0
  0
  0

  | name                             | value
  |----------------------------------|--------------------------
  | watchdog_enabled                 | 0
  |----------------------------------|--------------------------
  | watchdog_hardlockup_user_enabled | 0
  |----------------------------------|--------------------------
  | watchdog_softlockup_user_enabled | 0
  |----------------------------------|--------------------------
  | watchdog_user_enabled            | 0
  |----------------------------------|--------------------------

  step 4:
  # echo 1 > /proc/sys/kernel/watchdog

  | name                             | value
  |----------------------------------|--------------------------
  | watchdog_enabled                 | 0
  |----------------------------------|--------------------------
  | watchdog_hardlockup_user_enabled | 0
  |----------------------------------|--------------------------
  | watchdog_softlockup_user_enabled | 0
  |----------------------------------|--------------------------
  | watchdog_user_enabled            | 0
  |----------------------------------|--------------------------

  step 5:
  # cat /proc/sys/kernel/*watchdog
  0
  0
  0

If we dont do "step 3", do "step 4" right after "step 2", it will be

  | name                             | value
  |----------------------------------|--------------------------
  | watchdog_enabled                 | 1
  |----------------------------------|--------------------------
  | watchdog_hardlockup_user_enabled | 1
  |----------------------------------|--------------------------
  | watchdog_softlockup_user_enabled | 1
  |----------------------------------|--------------------------
  | watchdog_user_enabled            | 1
  |----------------------------------|--------------------------

then everything works correctly.

So this patch fix "step 3"'s value into

| name                             | value
|----------------------------------|--------------------------
| watchdog_enabled                 | 0
|----------------------------------|--------------------------
| watchdog_hardlockup_user_enabled | 1
|----------------------------------|--------------------------
| watchdog_softlockup_user_enabled | 1
|----------------------------------|--------------------------
| watchdog_user_enabled            | 0
|----------------------------------|--------------------------

And still print 0 as before.

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 kernel/watchdog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 51915b44ac73..ade69b2319f6 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -990,6 +990,7 @@ static int proc_watchdog_common(int which, struct ctl_table *table, int write,
 
 	mutex_lock(&watchdog_mutex);
 
+	old = *param;
 	if (!write) {
 		/*
 		 * On read synchronize the userspace interface. This is a
@@ -997,8 +998,8 @@ static int proc_watchdog_common(int which, struct ctl_table *table, int write,
 		 */
 		*param = (watchdog_enabled & which) != 0;
 		err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+		*param = old;
 	} else {
-		old = READ_ONCE(*param);
 		err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 		if (!err && old != READ_ONCE(*param))
 			proc_watchdog_update();
-- 
2.17.1


