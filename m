Return-Path: <linux-kernel+bounces-242149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8274B928448
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE781C20D1B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B715146595;
	Fri,  5 Jul 2024 08:59:46 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731EB1448D4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169985; cv=none; b=QEkMFQu9PgJmmWM5fE1MMceH11S+RxAfBA59v9xQ3tD0Hle4Q+YuYrsacmqSLRB+Kt9B2ma39+nTysPrKTxzGUrwI5h8miw7uXPkgzWgQ/OswJUqZZHl7ZYgFJvPCf9VN7qpXKJiqD5C7whReh9zk7xMbzEATfDcKFHYOwHD09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169985; c=relaxed/simple;
	bh=/pW678AZNupnImv2XGMH//9gBxSvMxccUKOYw+dT1QU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EdXiH5RL6buq7W6ei+lNba3rZVPq/Zk5xviAXGnd7MTJFNi1cbHtH+bCjbxrafpGAnHZ3VZd944RBmSl7sNn6EP0kFHwwV+irH7bWIijl2B9r1OfxEmo5jdldHxiujx7S/Fu7Rfr+UdqYsXJYonhRzEY+vpZEieA7FxNW/m/HBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpsz3t1720169919tj4nuro
X-QQ-Originating-IP: GUDXbLmTXhOWsACCWmbvKzkKHGYBvUhK+PM62patSTg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 05 Jul 2024 16:58:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16430579746846863616
From: tuhaowen <tuhaowen@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: alexander.deucher@amd.com,
	huangbibo@uniontech.com,
	linux-kernel@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	tuhaowen@uniontech.com,
	wangyuli@uniontech.com
Subject: Re: Re: [PATCH] dev/parport: fix the array out-of-bounds risk
Date: Fri,  5 Jul 2024 16:58:34 +0800
Message-Id: <20240705085834.17224-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2024070503-concert-mummify-dcbf@gregkh>
References: <2024070503-concert-mummify-dcbf@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Fri, Jul 05, 2024 at 02:45:45PM +0800, Greg Kroah-Hartman wrote:

> I'm not disputing that this change looks correct, I'm asking that you
> redo it and properly check the array size when writing to it so as to
> ensure that it really is correct in case our math is incorrect
> somewhere.

Thank you for your feedback. I have redone the change and 
ensured that the array size is properly checked when writing to it. 
Please find my updated patch below.

Thanks,

Haowen.Tu


From cfdf8445987147f3a7e4f1232a8c6e8a271e4a6d Mon Sep 17 00:00:00 2001
From: tuhaowen <tuhaowen@uniontech.com>
Date: Mon, 27 May 2024 14:34:32 +0800
Subject: [PATCH] dev/parport: fix the array out-of-bounds risk

Fixed array out-of-bounds issues caused by sprintf
by replacing it with snprintf for safer data copying,
ensuring the destination buffer is not overflowed.

Below is the stack trace I encountered during the actual issue:

[ 66.575408s] [pid:5118,cpu4,QThread,4]Kernel panic - not syncing: stack-protector:
Kernel stack is corrupted in: do_hardware_base_addr+0xcc/0xd0 [parport]
[ 66.575408s] [pid:5118,cpu4,QThread,5]CPU: 4 PID: 5118 Comm:
QThread Tainted: G S W O 5.10.97-arm64-desktop #7100.57021.2
[ 66.575439s] [pid:5118,cpu4,QThread,6]TGID: 5087 Comm: EFileApp
[ 66.575439s] [pid:5118,cpu4,QThread,7]Hardware name: HUAWEI HUAWEI QingYun
PGUX-W515x-B081/SP1PANGUXM, BIOS 1.00.07 04/29/2024
[ 66.575439s] [pid:5118,cpu4,QThread,8]Call trace:
[ 66.575469s] [pid:5118,cpu4,QThread,9] dump_backtrace+0x0/0x1c0
[ 66.575469s] [pid:5118,cpu4,QThread,0] show_stack+0x14/0x20
[ 66.575469s] [pid:5118,cpu4,QThread,1] dump_stack+0xd4/0x10c
[ 66.575500s] [pid:5118,cpu4,QThread,2] panic+0x1d8/0x3bc
[ 66.575500s] [pid:5118,cpu4,QThread,3] __stack_chk_fail+0x2c/0x38
[ 66.575500s] [pid:5118,cpu4,QThread,4] do_hardware_base_addr+0xcc/0xd0 [parport]

Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
---
 drivers/parport/procfs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index bd388560ed59..27674a34ca3c 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -51,12 +51,12 @@ static int do_active_device(struct ctl_table *table, int write,
 
        for (dev = port->devices; dev ; dev = dev->next) {
                if(dev == port->cad) {
-                       len += sprintf(buffer, "%s\n", dev->name);
+                       len += snprintf(buffer, 64, "%s\n", dev->name);
                }
        }
 
        if(!len) {
-               len += sprintf(buffer, "%s\n", "none");
+               len += snprintf(buffer, 64, "%s\n", "none");
        }
 
        if (len > *lenp)
@@ -87,19 +87,19 @@ static int do_autoprobe(struct ctl_table *table, int write,
        }
 
        if ((str = info->class_name) != NULL)
-               len += sprintf (buffer + len, "CLASS:%s;\n", str);
+               len += snprintf (buffer + len, 256 - len, "CLASS:%s;\n", str);
 
        if ((str = info->model) != NULL)
-               len += sprintf (buffer + len, "MODEL:%s;\n", str);
+               len += snprintf (buffer + len, 256 - len, "MODEL:%s;\n", str);
 
        if ((str = info->mfr) != NULL)
-               len += sprintf (buffer + len, "MANUFACTURER:%s;\n", str);
+               len += snprintf (buffer + len, 256 - len, "MANUFACTURER:%s;\n", str);
 
        if ((str = info->description) != NULL)
-               len += sprintf (buffer + len, "DESCRIPTION:%s;\n", str);
+               len += snprintf (buffer + len, 256 - len, "DESCRIPTION:%s;\n", str);
 
        if ((str = info->cmdset) != NULL)
-               len += sprintf (buffer + len, "COMMAND SET:%s;\n", str);
+               len += snprintf (buffer + len, 256 - len, "COMMAND SET:%s;\n", str);
 
        if (len > *lenp)
                len = *lenp;
@@ -117,7 +117,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
                                 void *result, size_t *lenp, loff_t *ppos)
 {
        struct parport *port = (struct parport *)table->extra1;
-       char buffer[20];
+       char buffer[64];
        int len = 0;
 
        if (*ppos) {
@@ -128,7 +128,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
        if (write) /* permissions prevent this anyway */
                return -EACCES;
 
-       len += sprintf (buffer, "%lu\t%lu\n", port->base, port->base_hi);
+       len += snprintf (buffer, 64, "%lu\t%lu\n", port->base, port->base_hi);
 
        if (len > *lenp)
                len = *lenp;
@@ -155,7 +155,7 @@ static int do_hardware_irq(struct ctl_table *table, int write,
        if (write) /* permissions prevent this anyway */
                return -EACCES;
 
-       len += sprintf (buffer, "%d\n", port->irq);
+       len += snprintf (buffer, 20, "%d\n", port->irq);
 
        if (len > *lenp)
                len = *lenp;
@@ -182,7 +182,7 @@ static int do_hardware_dma(struct ctl_table *table, int write,
        if (write) /* permissions prevent this anyway */
                return -EACCES;
 
-       len += sprintf (buffer, "%d\n", port->dma);
+       len += snprintf (buffer, 20, "%d\n", port->dma);
 
        if (len > *lenp)
                len = *lenp;
@@ -213,7 +213,7 @@ static int do_hardware_modes(struct ctl_table *table, int write,
 #define printmode(x)                                                   \
 do {                                                                   \
        if (port->modes & PARPORT_MODE_##x)                             \
-               len += sprintf(buffer + len, "%s%s", f++ ? "," : "", #x); \
+               len += snprintf(buffer + len, 40 - len, "%s%s", f++ ? "," : "", #x); \
 } while (0)
                int f = 0;
                printmode(PCSPP);
-- 
2.20.1


