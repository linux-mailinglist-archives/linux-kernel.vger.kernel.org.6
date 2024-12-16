Return-Path: <linux-kernel+bounces-446902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 732CC9F2AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E1F1613DD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF61B87CF;
	Mon, 16 Dec 2024 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OiEPw6vv"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03251487F6
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333347; cv=none; b=ICL4IVAN5VTuQfKRxpSXOIntEVE0W4HryQTWFrPLrHECEtDG+skH4R1sBnBYKfc1jGVC3ach5MblUQZP3U1U7IFvBXPDqJc3tYv8xNwv5+M1sFjCZSx0HZtWXUwwyD2Gf57GwHEe6jp6Ey022MVjaUc3ct5SkdwMV89GAlDhQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333347; c=relaxed/simple;
	bh=aPaGCGQaympv63t88YDP83n4uLvzWwk9QvyFIehLf4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4gGCYWyrKzp9BsjOuYo7JGLQetoW+io6rXeEbcuF2Kd6HTdPJy1w3wkgcmRDJ/r5ZIDtKqd8zRYBOiOCpoM8zRW7RlZBC+2pmsCjzXexg8T3LWlG3BtNbgbqleUn6kDozLsvvkaQ00dq/7w0aNxtajQA6Tj9zZxmxpEgS2Rqy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OiEPw6vv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG3ql1Y012254;
	Mon, 16 Dec 2024 07:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=c+7KTRb+ydDHq3foa7AV8t01zGUQ6590OrTFRDoQc
	HM=; b=OiEPw6vvaYRydAfU756ZZtmNeyzim/Qpz6Ek4k1SjzE8ALIb2KAALrkgR
	vmrAPjY4fIrSa27yZjtPSioz6s2VLeFnywebldFjYddW4Q5TFEk7TFQo+wS+6Hpt
	x/q38O96J4X2+uQcBQoL7u3INnR+U5vPgfVF2Qwt5LI7ng2YRxAbHd9kiOtZOOyy
	i+XeEWHJ1MO8h69NzGLpYQM6Br1GxTnK8n+Sa6nqiCdNbblVNSaOJUUYGFxHZN8J
	j1YOwC0nkoQwn2k0+SLxvotFlQAZwFw+1qpJsExCy1tT6Y7dUqwX/bXkTGaYSIxc
	9E5NXnMYBpprLUY42M9z0NnJAh6gg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpb0rgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 07:15:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG5st6v011256;
	Mon, 16 Dec 2024 07:15:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjjvm4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 07:15:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BG7FSLI21102872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 07:15:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 629C820040;
	Mon, 16 Dec 2024 07:15:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE4C72004B;
	Mon, 16 Dec 2024 07:15:25 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.28.229])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 07:15:25 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: mpe@ellerman.id.au, maddy@linux.ibm.com
Cc: atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, disgoel@linux.ibm.com,
        hbathini@linux.ibm.com, adubey@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/vpa_dtl: Add interface to expose vpa dtl counters via perf
Date: Mon, 16 Dec 2024 12:45:15 +0530
Message-ID: <20241216071516.104324-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nQ-lNA7Au3r9aM-FCv2pGNfxNkT4gfuc
X-Proofpoint-GUID: nQ-lNA7Au3r9aM-FCv2pGNfxNkT4gfuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160056

The pseries Shared Processor Logical Partition(SPLPAR) machines
can retrieve a log of dispatch and preempt events from the
hypervisor using data from Disptach Trace Log(DTL) buffer.
With this information, user can retrieve when and why each dispatch &
preempt has occurred. Added an interface to expose the Virtual Processor
Area(VPA) DTL counters via perf.

The following events are available and exposed in sysfs:

 vpa_dtl/dtl_cede/ - Trace voluntary (OS initiated) virtual processor waits
 vpa_dtl/dtl_preempt/ - Trace time slice preempts
 vpa_dtl/dtl_fault/ - Trace virtual partition memory page faults.
 vpa_dtl/dtl_all/ - Trace all (dtl_cede/dtl_preempt/dtl_fault)

Added interface defines supported event list, config fields for the
event attributes and their corresponding bit values which are exported
via sysfs. User could use the standard perf tool to access perf events
exposed via vpa-dtl pmu.

The VPA DTL PMU counters do not interrupt on overflow or generate any
PMI interrupts. Therefore, the kernel needs to poll the counters, added
hrtimer code to do that. The timer interval can be provided by user via
sample_period field in nano seconds.

Result on power10 SPLPAR system with 656 cpu threads.
In the below perf record command with vpa_dtl pmu, -c option is used
to provide sample_period whch corresponding to 1000000000ns i.e; 1sec
and the workload time is also 1 second, hence we are getting 656 samples:

[command] perf record -a -R -e vpa_dtl/dtl_all/ -c 1000000000 sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.828 MB perf.data (656 samples) ]

There is one hrtimer added per vpa-dtl pmu thread. Code added to handle
addition of dtl buffer data in the raw sample. Since DTL does not provide
IP address for a sample and it just have traces on reason of
dispatch/preempt, we directly saving DTL buffer data to perf.data file as
raw sample. For each hrtimer restart call, interface will dump all the
new dtl entries added to dtl buffer as a raw sample.

To ensure there are no other conflicting dtl users (example: debugfs dtl
or /proc/powerpc/vcpudispatch_stats), interface added code to use
"down_write_trylock" call to take the dtl_access_lock. The dtl_access_lock
is defined in dtl.h file. Also added global reference count variable called
"dtl_global_refc", to ensure dtl data can be captured per-cpu. Code also
added global lock called "dtl_global_lock" to avoid race condition.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 arch/powerpc/perf/Makefile  |   2 +-
 arch/powerpc/perf/vpa-dtl.c | 462 ++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h  |   1 +
 3 files changed, 464 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/perf/vpa-dtl.c

diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index ac2cf58d62db..623168572685 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_PPC_POWERNV)	+= imc-pmu.o
 obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
 obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o e6500-pmu.o
 
-obj-$(CONFIG_HV_PERF_CTRS) += hv-24x7.o hv-gpci.o hv-common.o
+obj-$(CONFIG_HV_PERF_CTRS) += hv-24x7.o hv-gpci.o hv-common.o vpa-dtl.o
 
 obj-$(CONFIG_VPA_PMU) += vpa-pmu.o
 
diff --git a/arch/powerpc/perf/vpa-dtl.c b/arch/powerpc/perf/vpa-dtl.c
new file mode 100644
index 000000000000..0a3ca46c602d
--- /dev/null
+++ b/arch/powerpc/perf/vpa-dtl.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Perf interface to expose Dispatch Trace Log counters.
+ *
+ * Copyright (C) 2024 Kajol Jain, IBM Corporation
+ */
+
+#define pr_fmt(fmt) "vpa_dtl: " fmt
+
+#include <asm/dtl.h>
+#include <linux/perf_event.h>
+#include <asm/plpar_wrappers.h>
+
+#define EVENT(_name, _code)     enum{_name = _code}
+
+/*
+ * Based on Power Architecture Platform Reference(PAPR) documentation,
+ * Table 14.14. Per Virtual Processor Area, below Dispatch Trace Log(DTL)
+ * Enable Mask used to get corresponding virtual processor dispatch
+ * to preempt traces:
+ *   DTL_CEDE(0x1): Trace voluntary (OS initiated) virtual
+ *   processor waits
+ *   DTL_PREEMPT(0x2): Trace time slice preempts
+ *   DTLFAULT(0x4): Trace virtual partition memory page
+ faults.
+ *   DTL_ALL(0x7): Trace all (DTL_CEDE | DTL_PREEMPT | DTL_FAULT)
+ *
+ * Event codes based on Dispatch Trace Log Enable Mask.
+ */
+EVENT(DTL_CEDE,         0x1);
+EVENT(DTL_PREEMPT,      0x2);
+EVENT(DTL_FAULT,        0x4);
+EVENT(DTL_ALL,          0x7);
+
+GENERIC_EVENT_ATTR(dtl_cede, DTL_CEDE);
+GENERIC_EVENT_ATTR(dtl_preempt, DTL_PREEMPT);
+GENERIC_EVENT_ATTR(dtl_fault, DTL_FAULT);
+GENERIC_EVENT_ATTR(dtl_all, DTL_ALL);
+
+PMU_FORMAT_ATTR(event, "config:0-7");
+
+static struct attribute *events_attr[] = {
+	GENERIC_EVENT_PTR(DTL_CEDE),
+	GENERIC_EVENT_PTR(DTL_PREEMPT),
+	GENERIC_EVENT_PTR(DTL_FAULT),
+	GENERIC_EVENT_PTR(DTL_ALL),
+	NULL
+};
+
+static struct attribute_group event_group = {
+	.name = "events",
+	.attrs = events_attr,
+};
+
+static struct attribute *format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static const struct attribute_group format_group = {
+	.name = "format",
+	.attrs = format_attrs,
+};
+
+static const struct attribute_group *attr_groups[] = {
+	&format_group,
+	&event_group,
+	NULL,
+};
+
+struct vpa_dtl {
+	struct dtl_entry	*buf;
+	u64			last_idx;
+	bool			active_lock;
+};
+
+static DEFINE_PER_CPU(struct vpa_dtl, vpa_dtl_cpu);
+
+/* variable to capture reference count for the active dtl threads */
+static int dtl_global_refc;
+static spinlock_t dtl_global_lock = __SPIN_LOCK_UNLOCKED(dtl_global_lock);
+
+/*
+ * Function to dump the dispatch trace log buffer data to the
+ * perf raw sample.
+ */
+static void vpa_dtl_dump_sample_data(struct perf_event *event)
+{
+	struct perf_sample_data data;
+	struct perf_raw_record raw;
+	struct pt_regs regs;
+	u64 cur_idx, last_idx, i;
+	char *buf;
+
+	/* actual number of entries read */
+	long n_read = 0, read_size = 0;
+
+	/* number of entries added to dtl buffer */
+	long n_req;
+
+	struct vpa_dtl *dtl = &per_cpu(vpa_dtl_cpu, event->cpu);
+
+	/* Setup perf sample */
+	perf_sample_data_init(&data, 0, event->hw.last_period);
+	memset(&regs, 0, sizeof(regs));
+	memset(&raw, 0, sizeof(raw));
+
+	cur_idx = be64_to_cpu(lppaca_of(event->cpu).dtl_idx);
+	last_idx = dtl->last_idx;
+
+	if (last_idx + N_DISPATCH_LOG <= cur_idx)
+		last_idx = cur_idx - N_DISPATCH_LOG + 1;
+
+	n_req = cur_idx - last_idx;
+
+	/* no new entry added to the buffer, return */
+	if (n_req <= 0)
+		return;
+
+	dtl->last_idx = last_idx + n_req;
+
+	buf = kzalloc((n_req * sizeof(struct dtl_entry)) +
+			sizeof(tb_ticks_per_sec) + sizeof(n_req), GFP_NOWAIT);
+	if (!buf) {
+		pr_warn("buffer alloc failed for perf raw data for cpu%d\n", event->cpu);
+		return;
+	}
+	raw.frag.data = buf;
+
+	/* Save tb_ticks_per_sec to convert timebase to sec */
+	memcpy(buf, &tb_ticks_per_sec, sizeof(tb_ticks_per_sec));
+	buf += sizeof(tb_ticks_per_sec);
+
+	/* Save total number of dtl entries added to the dtl buffer */
+	memcpy(buf, &n_req, sizeof(n_req));
+	buf += sizeof(n_req);
+
+	i = last_idx % N_DISPATCH_LOG;
+
+	/* read the tail of the buffer if we've wrapped */
+	if (i + n_req > N_DISPATCH_LOG) {
+		read_size = N_DISPATCH_LOG - i;
+		memcpy(buf, &dtl->buf[i], read_size * sizeof(struct dtl_entry));
+		i = 0;
+		n_req -= read_size;
+		n_read += read_size;
+		buf += read_size * sizeof(struct dtl_entry);
+	}
+
+	/* .. and now the head */
+	memcpy(buf, &dtl->buf[i], n_req * sizeof(struct dtl_entry));
+	n_read += n_req;
+
+	raw.frag.size = n_read * sizeof(struct dtl_entry) +
+			sizeof(tb_ticks_per_sec) + sizeof(n_req);
+
+	perf_sample_save_raw_data(&data, &raw);
+	perf_event_overflow(event, &data, &regs);
+}
+
+/*
+ * The VPA Dispatch Trace log counters do not interrupt on overflow.
+ * Therefore, the kernel needs to poll the counters to avoid missing
+ * an overflow using hrtimer. The timer interval is based on sample_period
+ * count provided by user, and minimum interval is 1 millisecond.
+ */
+static enum hrtimer_restart vpa_dtl_hrtimer_handle(struct hrtimer *hrtimer)
+{
+	struct perf_event *event;
+	u64 period;
+
+	event = container_of(hrtimer, struct perf_event, hw.hrtimer);
+
+	if (event->state != PERF_EVENT_STATE_ACTIVE)
+		return HRTIMER_NORESTART;
+
+	vpa_dtl_dump_sample_data(event);
+	period = max_t(u64, 1000000, event->hw.sample_period);
+	hrtimer_forward_now(hrtimer, ns_to_ktime(period));
+
+	return HRTIMER_RESTART;
+}
+
+static void vpa_dtl_start_hrtimer(struct perf_event *event)
+{
+	u64 period;
+	struct hw_perf_event *hwc = &event->hw;
+
+	period = max_t(u64, 1000000, hwc->sample_period);
+	hrtimer_start(&hwc->hrtimer, ns_to_ktime(period), HRTIMER_MODE_REL_PINNED);
+}
+
+static void vpa_dtl_stop_hrtimer(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	hrtimer_cancel(&hwc->hrtimer);
+}
+
+static void vpa_dtl_reset_global_refc(struct perf_event *event)
+{
+	spin_lock(&dtl_global_lock);
+	dtl_global_refc--;
+	if (dtl_global_refc <= 0) {
+		dtl_global_refc = 0;
+		up_write(&dtl_access_lock);
+	}
+	spin_unlock(&dtl_global_lock);
+}
+
+static int vpa_dtl_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct vpa_dtl *dtl = &per_cpu(vpa_dtl_cpu, event->cpu);
+
+	/* test the event attr type for PMU enumeration */
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (!perfmon_capable())
+		return -EACCES;
+
+	/* Return if this is a counting event */
+	if (!is_sampling_event(event))
+		return -EOPNOTSUPP;
+
+	if (!(event->attr.sample_type & PERF_SAMPLE_RAW)) {
+		pr_debug("To enable perf sampling, run with -R/raw-samples option");
+		return -EOPNOTSUPP;
+	}
+
+	/* Invalid eventcode */
+	switch (event->attr.config) {
+	case DTL_LOG_CEDE:
+	case DTL_LOG_PREEMPT:
+	case DTL_LOG_FAULT:
+	case DTL_LOG_ALL:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock(&dtl_global_lock);
+
+	/*
+	 * To ensure there are no other conflicting dtl users
+	 * (example: /proc/powerpc/vcpudispatch_stats or debugfs dtl),
+	 * below code try to take the dtl_access_lock.
+	 * The dtl_access_lock is a rwlock defined in dtl.h, which is used
+	 * to unsure there is no conflicting dtl users.
+	 * Based on below code, vpa_dtl pmu tries to take write access lock
+	 * and also checks for dtl_global_refc, to make sure that the
+	 * dtl_access_lock is taken by vpa_dtl pmu interface.
+	 */
+	if (dtl_global_refc == 0 && !down_write_trylock(&dtl_access_lock)) {
+		spin_unlock(&dtl_global_lock);
+		return -EBUSY;
+	}
+
+	/*
+	 * Increment the number of active vpa_dtl pmu threads. The
+	 * dtl_global_refc is used to keep count of cpu threads that
+	 * currently capturing dtl data using vpa_dtl pmu interface.
+	 */
+	dtl_global_refc++;
+
+	/*
+	 * active_lock is a per cpu variable which is set if
+	 * current cpu is running vpa_dtl perf record session.
+	 */
+	dtl->active_lock = true;
+	spin_unlock(&dtl_global_lock);
+
+	hrtimer_init(&hwc->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hwc->hrtimer.function = vpa_dtl_hrtimer_handle;
+
+	/*
+	 * Since hrtimers have a fixed rate, we can do a static freq->period
+	 * mapping and avoid the whole period adjust feedback stuff.
+	 */
+	if (event->attr.freq) {
+		long freq = event->attr.sample_freq;
+
+		event->attr.sample_period = NSEC_PER_SEC / freq;
+		hwc->sample_period = event->attr.sample_period;
+		local64_set(&hwc->period_left, hwc->sample_period);
+		hwc->last_period = hwc->sample_period;
+		event->attr.freq = 0;
+	}
+
+	event->destroy = vpa_dtl_reset_global_refc;
+	return 0;
+}
+
+static int vpa_dtl_event_add(struct perf_event *event, int flags)
+{
+	int ret, hwcpu;
+	unsigned long addr;
+	struct vpa_dtl *dtl = &per_cpu(vpa_dtl_cpu, event->cpu);
+
+	/*
+	 * Register our dtl buffer with the hypervisor. The
+	 * HV expects the buffer size to be passed in the second
+	 * word of the buffer. Refer section '14.11.3.2. H_REGISTER_VPA'
+	 * from PAPR for more information.
+	 */
+	((u32 *)dtl->buf)[1] = cpu_to_be32(DISPATCH_LOG_BYTES);
+	dtl->last_idx = 0;
+
+	hwcpu = get_hard_smp_processor_id(event->cpu);
+	addr = __pa(dtl->buf);
+
+	ret = register_dtl(hwcpu, addr);
+	if (ret) {
+		pr_warn("DTL registration for cpu %d (hw %d) failed with %d\n",
+			event->cpu, hwcpu, ret);
+		return ret;
+	}
+
+	/* set our initial buffer indices */
+	lppaca_of(event->cpu).dtl_idx = 0;
+
+	/*
+	 * Ensure that our updates to the lppaca fields have
+	 * occurred before we actually enable the logging
+	 */
+	smp_wmb();
+
+	/* enable event logging */
+	lppaca_of(event->cpu).dtl_enable_mask = event->attr.config;
+
+	vpa_dtl_start_hrtimer(event);
+
+	return 0;
+}
+
+static void vpa_dtl_event_del(struct perf_event *event, int flags)
+{
+	int hwcpu = get_hard_smp_processor_id(event->cpu);
+	struct vpa_dtl *dtl = &per_cpu(vpa_dtl_cpu, event->cpu);
+
+	vpa_dtl_stop_hrtimer(event);
+	unregister_dtl(hwcpu);
+	lppaca_of(event->cpu).dtl_enable_mask = 0x0;
+	dtl->active_lock = false;
+}
+
+static void vpa_dtl_event_read(struct perf_event *event)
+{
+	/*
+	 * This function defination is empty as vpa_dtl_dump_sample_data
+	 * is used to parse and dump the dispatch trace log data,
+	 * to perf raw sample.
+	 */
+}
+
+/* Allocate dtl buffer memory for given cpu. */
+static int vpa_dtl_mem_alloc(int cpu)
+{
+	struct vpa_dtl *dtl = &per_cpu(vpa_dtl_cpu, cpu);
+	struct dtl_entry *buf = NULL;
+
+	if (dtl->buf)
+		return 0;
+	dtl->active_lock = false;
+
+	/* Check for dispatch trace log buffer cache */
+	if (!dtl_cache)
+		return -ENOMEM;
+
+	buf = kmem_cache_alloc_node(dtl_cache, GFP_KERNEL, cpu_to_node(cpu));
+	if (!buf) {
+		pr_warn("buffer allocation failed for cpu %d\n", cpu);
+		return -ENOMEM;
+	}
+	dtl->buf = buf;
+	return 0;
+}
+
+static int vpa_dtl_cpu_online(unsigned int cpu)
+{
+	return vpa_dtl_mem_alloc(cpu);
+}
+
+static int vpa_dtl_cpu_offline(unsigned int cpu)
+{
+	struct vpa_dtl *dtl = &per_cpu(vpa_dtl_cpu, cpu);
+
+	/* Reduce the ref count if dtl event running on this cpu */
+	spin_lock(&dtl_global_lock);
+	if (dtl_global_refc && dtl->active_lock)
+		dtl_global_refc--;
+	if (dtl_global_refc <= 0) {
+		dtl_global_refc = 0;
+		up_write(&dtl_access_lock);
+	}
+	spin_unlock(&dtl_global_lock);
+	return 0;
+}
+
+static int vpa_dtl_cpu_hotplug_init(void)
+{
+	return cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_VPA_DTL_ONLINE,
+			  "perf/powerpc/vpa_dtl:online",
+			  vpa_dtl_cpu_online,
+			  vpa_dtl_cpu_offline);
+}
+
+static void vpa_dtl_clear_memory(void)
+{
+	int i;
+
+	for_each_online_cpu(i) {
+		struct vpa_dtl *dtl = &per_cpu(vpa_dtl_cpu, i);
+
+		kmem_cache_free(dtl_cache, dtl->buf);
+		dtl->buf = NULL;
+	}
+}
+
+static struct pmu vpa_dtl_pmu = {
+	.task_ctx_nr = perf_invalid_context,
+
+	.name = "vpa_dtl",
+	.attr_groups = attr_groups,
+	.event_init  = vpa_dtl_event_init,
+	.add         = vpa_dtl_event_add,
+	.del         = vpa_dtl_event_del,
+	.read        = vpa_dtl_event_read,
+	.capabilities = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_EXCLUSIVE,
+};
+
+static int vpa_dtl_init(void)
+{
+	int r;
+
+	if (!firmware_has_feature(FW_FEATURE_SPLPAR)) {
+		pr_debug("not a shared virtualized system, not enabling\n");
+		return -ENODEV;
+	}
+
+	/* This driver is intended only for L1 host. */
+	if (is_kvm_guest()) {
+		pr_debug("Only supported for L1 host system\n");
+		return -ENODEV;
+	}
+
+	/* init cpuhotplug */
+	r = vpa_dtl_cpu_hotplug_init();
+	if (r) {
+		vpa_dtl_clear_memory();
+		return r;
+	}
+
+	r = perf_pmu_register(&vpa_dtl_pmu, vpa_dtl_pmu.name, -1);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+device_initcall(vpa_dtl_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index a04b73c40173..7803da11d684 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -234,6 +234,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_POWERPC_TRACE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_HV_24x7_ONLINE,
 	CPUHP_AP_PERF_POWERPC_HV_GPCI_ONLINE,
+	CPUHP_AP_PERF_POWERPC_VPA_DTL_ONLINE,
 	CPUHP_AP_PERF_CSKY_ONLINE,
 	CPUHP_AP_TMIGR_ONLINE,
 	CPUHP_AP_WATCHDOG_ONLINE,
-- 
2.43.0


