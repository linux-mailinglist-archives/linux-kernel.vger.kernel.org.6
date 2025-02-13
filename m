Return-Path: <linux-kernel+bounces-514048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E7EA351B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2EB3ACE01
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137FA2753EC;
	Thu, 13 Feb 2025 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fcKCaSsh"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6752753EB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487498; cv=none; b=MsVAyzaUaJ1mrkko6440jCj7yF8Tp4FCTTsJO0WsZzfjTobDHOK8tOB64KmaQia/8giA1XKW3bGrNHhT3pPmMyxNcDz9+iublVibfm1D/73JZiSlfItn39V5TwWmJNkkNPUe4QmDBAk9Xqj+4lsr3PwJ4eJ6+kPmxTKJnun1Mt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487498; c=relaxed/simple;
	bh=Y27dhfw8v4BA3YPmRiUGr4aKS1BFKwdnmIIc52BuMys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zcr+gzwV2ELcTErqCgORu7K5FmUvPowCynyw+tQ4fWLphSf2duuvPc36Z9/XVEl/83LoQgERFBYXiSk7xFbhjqrK3cZHRqICz3xw1NvqV8YOVKGJPFlCxwJCLi0lDWCGucChnXMqbJzs/1AhiyWj6OOyRRwRiiEtqfK+Q1H7rC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fcKCaSsh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DMvG6j001130;
	Thu, 13 Feb 2025 22:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5Eh7zljLNWHH82zXNllR4wLMW+pcLetr2vsY7QBQP
	8M=; b=fcKCaSshWLQCjnh827XCWKFIIXEcrfzpyDiOpg5AycPuGKcxDf68S4UQf
	bHVMQ0yZqT4D5fGfnIxjQJLIP6D1WouYXvLg5wt+Q+aDkrkPQLHHHo45FE5TomoF
	rvB3zdn7WnotUpNora2am4YJsXkUmg4YsCgx7QPEXr2+trF6SY0iV+ULnlHoRTWG
	ZMhNlaLm4p1jV3RQpOpYqi4PUcMURaBW9vakZuH/m8oRN6jpc5xmmnkmRkPKfzE0
	4W/9Dxk7xnJhHKf886RN0J1bC6BjstCTXGCoGd2yIiG4VPtxxRyijY74isqHxAGJ
	/+dQvquZXKr9jxUH5c/XR/5+C76fQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44saj8n1c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 22:57:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51DKbxjD028758;
	Thu, 13 Feb 2025 22:57:57 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pma20a74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 22:57:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51DMvtUJ29819530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 22:57:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73DFA58055;
	Thu, 13 Feb 2025 22:57:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 486D858043;
	Thu, 13 Feb 2025 22:57:55 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.104.210])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Feb 2025 22:57:55 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, eajames@linux.ibm.com, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au, linux-fsi@lists.ozlabs.org,
        ninad@linux.ibm.com
Subject: [PATCH v2 RESEND] MAINTAINERS: change maintainer for FSI
Date: Thu, 13 Feb 2025 16:57:46 -0600
Message-ID: <20250213225746.2159118-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cBI5atXhIrYQCefTMGonVft6czH-SS6a
X-Proofpoint-ORIG-GUID: cBI5atXhIrYQCefTMGonVft6czH-SS6a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502130158

Due to job transitions, both Joel and Jeremy can no longer maintain
the FSI subsystem. I will take over.
I also replaced Alistair with Ninad as a reviewer, as Alistair doesn't
have access to hardware and hasn't been active.
I also removed the link to Joel's FSI tree as he won't be maintaining
it.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
---
Sorry for the resend; I forgot Jeremy's ack.

Changes since v1:
 - Remove Alistair as reviewer
 - Add Ninad as reviewer
 - Don't add Joel and Jeremy as reviewers.

 MAINTAINERS | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f65a2a1cde5b..59a6b47e9c278 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9441,14 +9441,11 @@ F:	include/linux/fscrypt.h
 F:	include/uapi/linux/fscrypt.h
 
 FSI SUBSYSTEM
-M:	Jeremy Kerr <jk@ozlabs.org>
-M:	Joel Stanley <joel@jms.id.au>
-R:	Alistar Popple <alistair@popple.id.au>
-R:	Eddie James <eajames@linux.ibm.com>
+M:	Eddie James <eajames@linux.ibm.com>
+R:	Ninad Palsule <ninad@linux.ibm.com>
 L:	linux-fsi@lists.ozlabs.org
 S:	Supported
 Q:	http://patchwork.ozlabs.org/project/linux-fsi/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git
 F:	drivers/fsi/
 F:	include/linux/fsi*.h
 F:	include/trace/events/fsi*.h
-- 
2.43.5


