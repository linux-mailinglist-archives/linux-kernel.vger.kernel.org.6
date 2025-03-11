Return-Path: <linux-kernel+bounces-555705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39AAA5BBA1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9BE1724F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D793F222576;
	Tue, 11 Mar 2025 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KCMITyiw"
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D93146593
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684082; cv=none; b=mV6fvScaKOZbeqeArCPFxzh1ur5f1AJJ1DMtWiXgfsNWXJIDkJhIQlEdt2qV8QsEFiGS9sGiUt8Bgf4r7xz2JdKOgIghW8rFOgUfqm7hrvR2gc7Pk8ZFPpd2hIz96IRrBnwo3ROCucz+T6EeDYKUGmZav34FpP0s3lqyAdkoe+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684082; c=relaxed/simple;
	bh=2dOCfF3SE4JtdwJGgzc7tTDXSXveTGf7JBWlac24dI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJve7QQtaJM1MD56e5JUAosRaLybMRMeSFBbtWLkVkakRZ66ekduUdCe1sntfqmUmBfjW1IZt5ZKh8iUqnRzG+e/BDY+jPinNl7/Y0m2xMCwVMv7j1UAODb09VGJAnu5cEdQrkVGxYvBWA4GRNg+YChEmQg2LV7XMjn7UBfmelU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KCMITyiw; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741684055;
	bh=ZiPqY/RKHISV8T1AisgYMO+/5+gEQu6ZX6Kam1AOsDc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=KCMITyiw2jf33hRsA5XZI+pABR/NQeKOrjimuH/Fvu/O8XH+beaithnWBYsBbSumM
	 NxMf5A/nD8GVB60KxWu05RNw4sBomQ9KIR7B68feH4UHb1VU69uIGyB+Yb43Httwcd
	 JJoiQC7BPXPnNTUS8rtAHtHjWjlK3rzMNycy7E0k=
X-QQ-mid: bizesmtpip4t1741684045tzy6fhy
X-QQ-Originating-IP: vufqVQTjWyeothMrDcmUwU25hNfeKgzbYJXcByj5JzM=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Mar 2025 17:07:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1440186853844928154
From: WangYuli <wangyuli@uniontech.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@unintech.com,
	guanwentao@uniontech.com,
	chenlinxuan@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] sched/core: u_clamp: Fix "-Wunused-function" warnings
Date: Tue, 11 Mar 2025 17:07:14 +0800
Message-ID: <6C18D4916C41C8D7+20250311090714.902321-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MW2WLBvYEeCv/l2Wr/ujvAUi8rsh02+maNw3jXFnBUAicw8OeAyKZIKG
	KN6oA6R3/RoW2Wqi7OO0UiT7FY7YZVGgOK5pAiVZWU3S48Dk90hol+sVOvw8GYsE0bWSzGZ
	t7bCb5BvIZtoiw45vkQ1+McNyGlkuFUnJt8b6cMoeci18XHJ9RQpGuViF+/+qJLL+fYOgOp
	o+q5pxbN7BPDYuE18SXf7Sm/vF0hCRhoi29IOaYyzYzM9IWL2elQ1TovSwIUf02awE63K7P
	Y9W7MBW7A0Cx2cTMQQtHIRVZMpMTZbpiYZl89TxbWgUoKSekAbYEP1aD7Z9xC0jHQjNC0c2
	yE7FDGfu4XqWyB1/qq5+sqlvMP4066pFlNkSLCAZ6JM1Me03V4xXxFVUxn7hLI6aFlqeOvZ
	8h7CHb4+CJJsVUFh5Xr/pp1/n6CvAGx2uVS++007HqoMTix3fOI9dsENTvcbIOFQFMT1Xcj
	Oc6hK/Vmh1UkWhn0byMX1AuUsuZsuYTF5AOdfQdctlXvJzAX6Oe3MbPI55PgOvg5gOxDOmk
	A0pu+7MpZsGNz5ME9pblAAgdZF8xeWK7C+SzG4JJCTZI6UMiV4F1p9IZgzrXJrEFcXXPENS
	K3yvUztoZ6rKrZ8RSjn9SFw9iUIKOb3Gxx0tB5eFDxgYkYt2Z26/qo5gJYd8Ddct5ch4AqB
	rqRVwykL+ZohS+AJcu9h163fyzhapkVbwhaw2EOMboEK9Ge2e/Fk6Y184sgWgB5mSN4ZdbD
	OJ1y/PLI33Yc0vQKCN3Z0k31Miaj3pAdgO0YfeZ19S4jA8dR0azawh/4KgUFedUd/TxQZRq
	s3V7B3Kduh0HMg3yuPbqFYF4RCNUHgzueTc9dh9IuOnhMcOJfJcbZirJyUpZ+Sxyvb+QaGE
	7gAZ5jCuMRK5isaNQgsh7l6OZT0KaMzQb+oF9QkZd3Ni/nd24DqNfXmA201uKibq0bURNpp
	dwBFLjvbJ2zml3/k22CyMcsJWAtf9NFuuGWBy3s3r6Gv4QPDfddDzqPyB536vqXYw3MYjC/
	rG0vM3JA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Given that uclamp_update_active() is exclusively called by
uclamp_update_active_tasks(), and considering that
uclamp_update_active_tasks() is utilized solely when
CONFIG_UCLAMP_TASK_GROUP is enabled, it follows that
uclamp_update_active() will emit a compilation warning if
CONFIG_UCLAMP_TASK_GROUP is not enabled.

Similar reason of uclamp_rq_reinc_id().

Fix follow errors with clang-19 when W=1e:

  kernel/sched/core.c:1818:1: error: unused function 'uclamp_update_active' [-Werror,-Wunused-function]
   1818 | uclamp_update_active(struct task_struct *p)
        | ^~~~~~~~~~~~~~~~~~~~

  kernel/sched/core.c:1800:20: error: unused function 'uclamp_rq_reinc_id' [-Werror,-Wunused-function]
   1800 | static inline void uclamp_rq_reinc_id(struct rq *rq, struct task_struct *p,
        |                    ^~~~~~~~~~~~~~~~~~

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 67189907214d..49549e030f4c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1797,6 +1797,7 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 		uclamp_rq_dec_id(rq, p, clamp_id);
 }
 
+#ifdef CONFIG_UCLAMP_TASK_GROUP
 static inline void uclamp_rq_reinc_id(struct rq *rq, struct task_struct *p,
 				      enum uclamp_id clamp_id)
 {
@@ -1843,7 +1844,6 @@ uclamp_update_active(struct task_struct *p)
 	task_rq_unlock(rq, p, &rf);
 }
 
-#ifdef CONFIG_UCLAMP_TASK_GROUP
 static inline void
 uclamp_update_active_tasks(struct cgroup_subsys_state *css)
 {
-- 
2.47.2


