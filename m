Return-Path: <linux-kernel+bounces-544493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75E8A4E1D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974C9188729D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A035125D900;
	Tue,  4 Mar 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AZS5c8pK"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC4209F33
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099606; cv=fail; b=H3FMrfPOsNCDuz/rOqhbqxilIxL2j3U/5z+rmm9hB/ZNX1pxCXjjCh7yprPdCSI92UE+iW56ORSfktoi58GttF/+EOAXhPnQQs3qCD7tyccFUKB/1P4qeZzzzPKIRJJNEIviOtm0Hec0yNSmnOlavL/q4p2gfvYfFMmJImDT4g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099606; c=relaxed/simple;
	bh=kb+0+6MylJldNENH6H06mbMvV5HmofQklH+bRglcZDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qfFw8Yi4omgNQDCLkHsGaCfaLiZ0tygpI/P/BNRBPqeIn00X/kUZmVNawqZ6N/134av8xKJexYjuAijPrlwFlXHYaOQSr9+YSnaBTl9FKxIgeFfaoupqKhD33kJYYQqgbHJ0Y73DsB9sjAEklxguRGfcGs3YqQPKMTn1KCg3roE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AZS5c8pK reason="signature verification failed"; arc=none smtp.client-ip=148.163.156.1; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 1ACE340CF10E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:46:43 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AZS5c8pK
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dkt0nQDzFwyy
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:45:10 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 6194642729; Tue,  4 Mar 2025 17:45:04 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AZS5c8pK
X-Envelope-From: <linux-kernel+bounces-541267-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AZS5c8pK
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 2F60641B2D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:25:42 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id BA4982DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:25:41 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD85A3A4F60
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D421F1506;
	Mon,  3 Mar 2025 09:25:15 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD991F0E38;
	Mon,  3 Mar 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993912; cv=none; b=jdBbsXEYiOdBCE2zkC2oQt8pu4sQI2WLseRfrj/0rzAc175eWkvoVKE0AegfvmNiO2FivYlz0wlJ2VfHOidHmeriGvxqcLFZNpwbucQXVWc+Ig0PczLoR+sxa5vHEhlYCSpL4075j8Ns05137nNzeby58EekQEaaRzejslWTTHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993912; c=relaxed/simple;
	bh=g2u4KWHAbEr61K3IGP6F6Dzv/QjB4YrY/gbIp2B/7eE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pURWHTvJj53nfJPW2rI4o8VEL4UOxyqogTFzIlEvpLFM3WdFZq0gxKfNlO/QnrXI3kDHxsJ4NyX6iVr2mBuB4w8KAS8UrzQQeDbc2x/iubEAMDrUoYH1aUOHDzvpFmOMP+6FLtoLcRZQNiGEQbqLkDSZOIR5LIVSRBlrQIxcw0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AZS5c8pK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5239DJnF006969;
	Mon, 3 Mar 2025 09:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kjOu7pwLW51iYtAOgoncP2baULu3m3yha+h5Jk0Py
	M0=; b=AZS5c8pKGQ+NDgRkHfBJ3uMDzJyH3/0hWTV6htap0uD1wCu9sLomUi2su
	/DFS0MtPP+6VL6kmt/86gyPyAPxLucoty+8emDOw6tIgS4gv9abx/yUEOkSLso5M
	9R6LSVo4/n/vxin3SsFbFskMbqM/cvSoMlyQBweyXU5EajPLVjk0lZ1q118LU5PS
	4DnZlny/U3fcJbrvy3D8mKLNCSaaa2MBzow11AaIlmVInhttQj2yluTmkylbl63n
	I0mr7cwiVWDW22uO0yYbp8KW3wYA+yzv7khlyRIiLg04RCFe4YK3Jmq/vZic5a0a
	taJSuL6tapJElGmpXYJUxbWzBnZew==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 454rrnks1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 09:24:58 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5239DUO7007324;
	Mon, 3 Mar 2025 09:24:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 454rrnks1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 09:24:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5238U1cG013720;
	Mon, 3 Mar 2025 09:24:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kecef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 09:24:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5239OsQ618219458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 09:24:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AC612004B;
	Mon,  3 Mar 2025 09:24:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A6CF20040;
	Mon,  3 Mar 2025 09:24:52 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.in.ibm.com (unknown [9.109.219.153])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Mar 2025 09:24:51 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, hbathini@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com
Subject: [PATCH] perf/hw_breakpoint: Return EOPNOTSUPP for unsupported breakpoint type
Date: Mon,  3 Mar 2025 14:54:51 +0530
Message-ID: <20250303092451.1862862-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z-Zl_pgDd762yZl9RWOFN818MhGm5ZpY
X-Proofpoint-ORIG-GUID: enF0SJJ43EYkPngJh6ffURjuLsPJNpbv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_03,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030068
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dkt0nQDzFwyy
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704319.1657@27hSCG8OUc+JWDeBRVKMPw
X-ITU-MailScanner-SpamCheck: not spam

Currently, __reserve_bp_slot() returns -ENOSPC for unsupported
breakpoint types on the architecture. For example, powerpc
does not support hardware instruction breakpoints. This causes
the perf_skip BPF selftest to fail, as neither ENOENT nor
EOPNOTSUPP is returned by perf_event_open for unsupported
breakpoint types. As a result, the test that should be skipped
for this arch is not correctly identified.

To resolve this, hw_breakpoint_event_init() should exit early by
checking for unsupported breakpoint types using
hw_breakpoint_slots_cached() and return the appropriate error
(-EOPNOTSUPP).

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 kernel/events/hw_breakpoint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.=
c
index bc4a61029b6d..8ec2cb688903 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -950,9 +950,10 @@ static int hw_breakpoint_event_init(struct perf_even=
t *bp)
 		return -ENOENT;
=20
 	/*
-	 * no branch sampling for breakpoint events
+	 * Check if breakpoint type is supported before proceeding.
+	 * Also, no branch sampling for breakpoint events.
 	 */
-	if (has_branch_stack(bp))
+	if (!hw_breakpoint_slots_cached(find_slot_idx(bp->attr.bp_type)) || has=
_branch_stack(bp))
 		return -EOPNOTSUPP;
=20
 	err =3D register_perf_hw_breakpoint(bp);
--=20
2.43.5



