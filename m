Return-Path: <linux-kernel+bounces-266985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A738940AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8261F20F99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3FA18FC6E;
	Tue, 30 Jul 2024 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="itkSSc5n"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C7188CC6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326749; cv=none; b=Ha3Lh/k3O8rYHf8cSkvUzSitQVjhv7TRf2U9mKJe+z7tsHorwVGiu1gcdeS50WRsZFg/tZO/BLFLpXB8Q9De68aDJG6wpKm6NadWibNpukbY+DaVtdpn/FC84bPlk8NJPf4sV3jqucLRXQtfzvZP8m9+RD1lTeAorUJNZYSCMNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326749; c=relaxed/simple;
	bh=XYeHUiDzfFFNKKr2evh5IiJPk+C+tQIGApTeroKuhWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=HxSawNr33ZujtsWDaRop56rsifxrS9nM1lZ3iJ5cmTOc5JLB+OhepuOFiDdXwCrWeZEe1SXSgz5fXVCVQGaWSmYyc8svGbLcDEn60KYGosvR7oLyY6nDDCzmLgXLvPey/+8WuXKnQmGYttmei4JOyyoStVqRN91Nmp4XdoPdNPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=itkSSc5n; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240730080542epoutp034302b0662a7b7958c763114f65d0809d~m7wwYisGx3174631746epoutp03V
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:05:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240730080542epoutp034302b0662a7b7958c763114f65d0809d~m7wwYisGx3174631746epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722326742;
	bh=goc3OC/VsvTPj54fegK2tInKaGIb4sFWOhpv8Fx4OSU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=itkSSc5nFpjxS85b+9aQwU3ffC5mqsa+8jAJX5aiX6q8RDWIHFEYCar3xq8TAvEGt
	 dmA+0wfCkulzwxlI4KLcSLXxR2/AEmIC/Cs2BZn2wh9lx7NC1mG3pm1NuSz5GCeGSs
	 K8goqiu7Tf8pMJOG2y1SAygfNfkMh59Lf0AzLvJU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240730080542epcas1p46c69f83543dc6b27a6942f13c352ede8~m7wv81RAF1044510445epcas1p4C;
	Tue, 30 Jul 2024 08:05:42 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.247]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WY786102Hz4x9Pp; Tue, 30 Jul
	2024 08:05:42 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	22.F9.19509.5DE98A66; Tue, 30 Jul 2024 17:05:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240730080541epcas1p144c86d09c0141102bfd89e58759b9140~m7wvfMHHj2322123221epcas1p12;
	Tue, 30 Jul 2024 08:05:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240730080541epsmtrp2eef77f32696434b8383b51e1bdd721d6~m7wvedAZq1168311683epsmtrp2J;
	Tue, 30 Jul 2024 08:05:41 +0000 (GMT)
X-AuditID: b6c32a4c-9ebcba8000004c35-47-66a89ed5bb01
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	35.22.08964.5DE98A66; Tue, 30 Jul 2024 17:05:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.252]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240730080541epsmtip11ae9b46e73517d921c6a8a11637de375~m7wvQ22Co2046020460epsmtip1b;
	Tue, 30 Jul 2024 08:05:41 +0000 (GMT)
From: Sangmoon Kim <sangmoon.kim@samsung.com>
To: Tejun Heo <tj@kernel.org>
Cc: youngjae24.lim@samsung.com, jordan.lim@samsung.com,
	myoungjae.kim@samsung.com, Sangmoon Kim <sangmoon.kim@samsung.com>, Lai
	Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: add cmdline parameter
 workqueue.panic_on_watchdog/max_watchdog_to_panic
Date: Tue, 30 Jul 2024 17:04:28 +0900
Message-Id: <20240730080428.2556769-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmvu61eSvSDNqvMVlMXbubyeLGsjCL
	y7vmsFlM/yhmcetBI4vFr+VHGS227X3K5MDusXPWXXaPTas62Tz6tqxi9Pi8SS6AJSrbJiM1
	MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdov5JCWWJOKVAo
	ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKxArzgxt7g0L10vL7XEytDAwMgUqDAhO+P1v81M
	BRv4Ks7v38rSwNjM08XIySEhYCLxfMUrNhBbSGAPo8TSPeZdjFxA9idGiSNX5rJDON8YJbac
	/scK09Fz4SpUYi+jxKYJz5kgnC+MEisfLwCbxSagK/Fl3mVGEFtEQFbiyrSHjCBFzAJHGCWm
	/voA5HBwCAukSlz4KAZSwyKgKjH3/iSwMK+AvcSsDbEQy+Ql9h88ywxi8woISpyc+YQFxGYG
	ijdvnc0MMlJC4By7xLdZF5kgGlwkWh4sZIawhSVeHd/CDmFLSXx+t5cNoqGfUeJUdxcLRGIK
	o8Tca5oQtrFEb88FZpAjmAU0Jdbv0odYxifx7msPK0hYQoBXoqNNCKJaTeLxq7uMELaMRP+d
	+VATPSQa30xhggRprMTOt0uYJzDKzULywiwkL8xCWLaAkXkVo1RqQXFuemqyYYGhbl5qOTwy
	k/NzNzGCk56Wzw7G7+v/6h1iZOJgPMQowcGsJMIbf2VpmhBvSmJlVWpRfnxRaU5q8SFGU2C4
	TmSWEk3OB6bdvJJ4QxNLAxMzIxMLY0tjMyVx3jNXylKFBNITS1KzU1MLUotg+pg4OKUamJR2
	pKe/UHos/X9BZ7XxpmUXptmGcBs1ed0xSj7a25wc+D79reCK/qYXKh+Ub1XssVr/8oyj7X7f
	hrf3366+UNUw8cb+z+lT0s7taHjdxfZaf5bYpaSmXXcXCM6edcU23v6IyiRL8RXbJHVXhPPf
	ssw/fGx2XxXDPEOr2Jfy5S33WVPXXHh36enSPl2xFjEVoZ3/PH8y6XYYpjA/3Li+Sers9cwp
	0vECJ40KZaWibJ9t577iZJpw3+j+nhtlPmU1UR9NPty4IhwrnZ0S3bC1KGuycOlLRpkrwUEV
	DRHX9piEsXxbtq6G2T375JPDphovNpXfFzot0VxUYKw3a2eVU/icT6H/VmdyHl++6/LHbCWW
	4oxEQy3mouJEAMUFDCEDBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSnO7VeSvSDD68VLOYunY3k8WNZWEW
	l3fNYbOY/lHM4taDRhaLX8uPMlps2/uUyYHdY+esu+wem1Z1snn0bVnF6PF5k1wASxSXTUpq
	TmZZapG+XQJXxut/m5kKNvBVnN+/laWBsZmni5GTQ0LARKLnwlX2LkYuDiGB3YwSix5fZoZI
	yEjsvLiZqYuRA8gWljh8uBgkLCTwiVHizl81EJtNQFfiy7zLjCC2iICsxJVpDxlB5jALnGKU
	+DqhC2yOsECyxKS9a9hAbBYBVYm59ycxgszkFbCXmLUhFmKVvMT+g2fBynkFBCVOznzCAmIz
	A8Wbt85mnsDINwtJahaS1AJGplWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMFBqaW5
	g3H7qg96hxiZOBgPMUpwMCuJ8MZfWZomxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6
	YklqdmpqQWoRTJaJg1OqgWlLjKhkANOypc92xMX7dnCcOes4NfBFuOWkxX/VOWo3Hd4itviE
	i+HmpM/f5Ra+aIk6JR2UkX1ceu8tlTknf30omMbSaZCx2LeA51LQGb5v9gzMa0+fzRX71X05
	yzS3VdN/gQuT0U2933N/bD5daiT5ncN59W+l59OLgllbWGMe3n8RNMneamfixg9JbsziOzZP
	3OotrRs0u3Pig2bLPUXSkhK7lrPWMoQsKVw5NYfTwHBjm6zfCwPVOZu+Vl4/opT58YFEfWmy
	0uLVi38v/7Oomt2p8RSbWXYJK+v2oxd8joacvNauFbkq32FWIMuBRt4NcSbPZe9tW8HVITJF
	LU8tnPXBqrikne9NFqi2KCuxFGckGmoxFxUnAgDCtE+9uQIAAA==
X-CMS-MailID: 20240730080541epcas1p144c86d09c0141102bfd89e58759b9140
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240730080541epcas1p144c86d09c0141102bfd89e58759b9140
References: <CGME20240730080541epcas1p144c86d09c0141102bfd89e58759b9140@epcas1p1.samsung.com>

When we want to debug the workqueue stall, we can immediately make
a panic to get the information we want.

In some systems, it may be necessary to quickly reboot the system to
escape from a workqueue lockup situation. In this case, we can control
the number of stall detections to generate panic.

Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
---
 kernel/workqueue.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index dfd42c28e404..893310ce23be 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7406,6 +7406,11 @@ static struct timer_list wq_watchdog_timer;
 static unsigned long wq_watchdog_touched = INITIAL_JIFFIES;
 static DEFINE_PER_CPU(unsigned long, wq_watchdog_touched_cpu) = INITIAL_JIFFIES;
 
+static bool wq_panic_on_watchdog;
+module_param_named(panic_on_watchdog, wq_panic_on_watchdog, bool, 0644);
+static unsigned int wq_max_watchdog_to_panic;
+module_param_named(max_watchdog_to_panic, wq_max_watchdog_to_panic, uint, 0644);
+
 /*
  * Show workers that might prevent the processing of pending work items.
  * The only candidates are CPU-bound workers in the running state.
@@ -7457,6 +7462,16 @@ static void show_cpu_pools_hogs(void)
 	rcu_read_unlock();
 }
 
+static void panic_on_wq_watchdog(void)
+{
+	static unsigned int wq_busy;
+
+	if (wq_panic_on_watchdog) {
+		wq_busy++;
+		BUG_ON(wq_busy >= wq_max_watchdog_to_panic);
+	}
+}
+
 static void wq_watchdog_reset_touched(void)
 {
 	int cpu;
@@ -7529,6 +7544,9 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	if (cpu_pool_stall)
 		show_cpu_pools_hogs();
 
+	if (lockup_detected)
+		panic_on_wq_watchdog();
+
 	wq_watchdog_reset_touched();
 	mod_timer(&wq_watchdog_timer, jiffies + thresh);
 }
-- 
2.34.1


