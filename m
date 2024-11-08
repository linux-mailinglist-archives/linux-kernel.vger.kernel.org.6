Return-Path: <linux-kernel+bounces-401149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB669C167B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CF51F2205B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F04E1CCB49;
	Fri,  8 Nov 2024 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h5SXlCag"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEDE28F5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731047548; cv=none; b=gmfhEjRT9rTu3GjPvYjCViI7zNFmtnpXtEh3xVa8NG4SUgIzS3yNftHnKl8wDw0u6p1Ni/5Iu2YVh+dRKOHt1zjEVfrxjfZ6NEGkzGMWZ1YIQcQMYyFdu/bjwwHPHAgoI51/mjbdi6T22w/Iprc3HvD+RJnpD6na2V4Wz397v98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731047548; c=relaxed/simple;
	bh=C5yXgqsJZjCR8udV+fNLcBGW9Rgfxr+qL+EDQgfAZmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R1sAfSzEf87YtSdwu/5H010i3UXON+EyOsR9cTDa9tpaenm9WqLvOTj2Z3jgemc9uV1iHhDdYjNW9cfb76Z/ohxqkS7J6YhKyDR9b6bw/PjOjqcGEpoCWAzvmuwdr8Tj5vJRy6Y2OFITxTrr6wzqNk4a86ewdoKJv4QLjT1L6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h5SXlCag; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DSdvd
	y2uYn79GRJ0ykpdqMy0fCqYbrZawMJu3+J+xtA=; b=h5SXlCagJJZVyaXUxUdXC
	JcE9EcO41W2jy/gh6nx1LCTBOG5nLRquPphPl3TqHjquqlTd+W+N+ll+V1r71TrE
	/k/dzo7U1UEZVHrPHND0UKS98DP+/6D8gZG89RlF6YGdMBaY7ExteXscyT7yfkLS
	LbpJy/Y1+vDO2COZPEJplY=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3P8cqsC1n4HuQBA--.53628S4;
	Fri, 08 Nov 2024 14:31:20 +0800 (CST)
From: David Wang <00107082@163.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] kernel:sched:stats:/proc/schedstat: use seq_put_decimal_ull for decimal values
Date: Fri,  8 Nov 2024 14:31:03 +0800
Message-Id: <20241108063103.4434-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P8cqsC1n4HuQBA--.53628S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxury3ZF13Kw4Uuw17XF4Utwb_yoWrtrWxpa
	sIvFWqqws5Aw1xta1rAwn7WFyUJFy5ZF4aq3ZrtrWxXas8Z3s8Jrn5XFW7AayUG348Aws8
	Xr12ga47G34ayr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE1vVZUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqQKRqmctqxKTVAAAsk

seq_printf is costy, lots of decimal values are yield via seq_printf
when reading /proc/schedstat; Profiling indicates seq_printf takes more
than 90% of samples of show_schedstat:
	show_schedstat(98.974% 667134/674048)
	    seq_printf(97.798% 652441/667134)
		vsnprintf(97.810% 638155/652441)
		    format_decode(23.720% 151368/638155)
		    number(16.797% 107191/638155)
		    memcpy_orig(4.610% 29422/638155)
		    srso_return_thunk(2.738% 17475/638155)
		    bitmap_string.isra.0(0.928% 5921/638155)
		    __memcpy(0.407% 2599/638155)
		    pointer(0.089% 571/638155)
		    srso_safe_ret(0.003% 16/638155)
	    __rcu_read_unlock(0.097% 648/667134)
	    __rcu_read_lock(0.097% 647/667134)

And one million rounds of open/read/close /proc/schedstat took:

	real	1m12.713s
	user	0m0.232s
	sys	1m12.440s
One average, each open/read/close sequence tooks 0.072ms.

With this patch, performance is significantly improved:

	real	0m30.141s
	user	0m0.320s
	sys	0m29.820s
One average, each open/read/close sequence tooks 0.029ms, ~60%
improvement.

Signed-off-by: David Wang <00107082@163.com>
---
 kernel/sched/stats.c | 62 +++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index eb0cdcd4d921..21d8c2edbc43 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -122,15 +122,18 @@ static int show_schedstat(struct seq_file *seq, void *v)
 		rq = cpu_rq(cpu);
 
 		/* runqueue-specific stats */
-		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu",
-		    cpu, rq->yld_count,
-		    rq->sched_count, rq->sched_goidle,
-		    rq->ttwu_count, rq->ttwu_local,
-		    rq->rq_cpu_time,
-		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
-
-		seq_printf(seq, "\n");
+		seq_puts(seq, "cpu");
+		seq_put_decimal_ull(seq, "", cpu);
+		seq_put_decimal_ull(seq, " ", rq->yld_count);
+		seq_put_decimal_ull(seq, " ", 0);
+		seq_put_decimal_ull(seq, " ", rq->sched_count);
+		seq_put_decimal_ull(seq, " ", rq->sched_goidle);
+		seq_put_decimal_ull(seq, " ", rq->ttwu_count);
+		seq_put_decimal_ull(seq, " ", rq->ttwu_local);
+		seq_put_decimal_ull(seq, " ", rq->rq_cpu_time);
+		seq_put_decimal_ull(seq, " ", rq->rq_sched_info.run_delay);
+		seq_put_decimal_ull(seq, " ", rq->rq_sched_info.pcount);
+		seq_putc(seq, '\n');
 
 #ifdef CONFIG_SMP
 		/* domain-specific stats */
@@ -138,26 +141,33 @@ static int show_schedstat(struct seq_file *seq, void *v)
 		for_each_domain(cpu, sd) {
 			enum cpu_idle_type itype;
 
-			seq_printf(seq, "domain%d %*pb", dcount++,
+			seq_puts(seq, "domain");
+			seq_put_decimal_ull(seq, "", dcount++);
+			seq_printf(seq, " %*pb",
 				   cpumask_pr_args(sched_domain_span(sd)));
 			for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
-				seq_printf(seq, " %u %u %u %u %u %u %u %u",
-				    sd->lb_count[itype],
-				    sd->lb_balanced[itype],
-				    sd->lb_failed[itype],
-				    sd->lb_imbalance[itype],
-				    sd->lb_gained[itype],
-				    sd->lb_hot_gained[itype],
-				    sd->lb_nobusyq[itype],
-				    sd->lb_nobusyg[itype]);
+				seq_put_decimal_ull(seq, " ", sd->lb_count[itype]);
+				seq_put_decimal_ull(seq, " ", sd->lb_balanced[itype]);
+				seq_put_decimal_ull(seq, " ", sd->lb_failed[itype]);
+				seq_put_decimal_ull(seq, " ", sd->lb_imbalance[itype]);
+				seq_put_decimal_ull(seq, " ", sd->lb_gained[itype]);
+				seq_put_decimal_ull(seq, " ", sd->lb_hot_gained[itype]);
+				seq_put_decimal_ull(seq, " ", sd->lb_nobusyq[itype]);
+				seq_put_decimal_ull(seq, " ", sd->lb_nobusyg[itype]);
 			}
-			seq_printf(seq,
-				   " %u %u %u %u %u %u %u %u %u %u %u %u\n",
-			    sd->alb_count, sd->alb_failed, sd->alb_pushed,
-			    sd->sbe_count, sd->sbe_balanced, sd->sbe_pushed,
-			    sd->sbf_count, sd->sbf_balanced, sd->sbf_pushed,
-			    sd->ttwu_wake_remote, sd->ttwu_move_affine,
-			    sd->ttwu_move_balance);
+			seq_put_decimal_ull(seq, " ", sd->alb_count);
+			seq_put_decimal_ull(seq, " ", sd->alb_failed);
+			seq_put_decimal_ull(seq, " ", sd->alb_pushed);
+			seq_put_decimal_ull(seq, " ", sd->sbe_count);
+			seq_put_decimal_ull(seq, " ", sd->sbe_balanced);
+			seq_put_decimal_ull(seq, " ", sd->sbe_pushed);
+			seq_put_decimal_ull(seq, " ", sd->sbf_count);
+			seq_put_decimal_ull(seq, " ", sd->sbf_balanced);
+			seq_put_decimal_ull(seq, " ", sd->sbf_pushed);
+			seq_put_decimal_ull(seq, " ", sd->ttwu_wake_remote);
+			seq_put_decimal_ull(seq, " ", sd->ttwu_move_affine);
+			seq_put_decimal_ull(seq, " ", sd->ttwu_move_balance);
+			seq_putc(seq, '\n');
 		}
 		rcu_read_unlock();
 #endif
-- 
2.39.2


