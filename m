Return-Path: <linux-kernel+bounces-331954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1AE97B36E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72FF1C23A74
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE2187FF5;
	Tue, 17 Sep 2024 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IteyPrga"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39B171E76
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593422; cv=none; b=gEaeRjxGwSRPB3C+/z2ST7ulNLl5XITFewnH01kkyDafertIuHWNgyRBYY7YIZewAWITA1Euaq56nspRn3gZ14N9X90Bhvl14UWFes2rr5jSvCYnjFVV216Veh1P95ZOj/68mV9r94rL9SDBqA6IpqJzhKBEGRXHZt6I2HrUdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593422; c=relaxed/simple;
	bh=SXxxTzENUHqgDbzbtKrbUaVIiszC+vbHGp1EeZo64SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMtNDwNulWnQ5b59sqVp/yT93j/9qvVrRqgCLHOep2uXFleo+gSD0B/LPtZ8pTuHKGMu9+NWqZz+8dkaWw2vA6jITXk4hpyqEQKTb/YMCQB4SFwJWp7eVlrQa2hSUrzqljg9k+wNUMCw1jAUVwZxcLTwmhtz5+tUMMqWibhTemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IteyPrga; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HAdDL8022540;
	Tue, 17 Sep 2024 17:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=07/1oSmtX2YV/pvANH5bd1gjwj
	16spq50wcdA0N8LCg=; b=IteyPrgaYXgp84rfB0o0ajOfUVd9WN64jLytgRY1lw
	wT6ePnJO2VzD/KmlIz4CLCif1pLj3cXPiB/rWjOHYm4usVe/ja0ApScSR2ICRcjr
	+nFs+i/4gQs+iQNecjqIsZ6TvPRt7Tz4fRzRjvuP/5sdiPgF5GE3OpObvG57K29f
	5dEVGs2cZSB/x50AvBtv4KS77fbUr9fzmkAzivikYyrzCCd7u48GjeKkHsBgi2Ou
	7cIHifW3CAGUvVCk2V9H2aiyZfz/zLeLViJf35k7U8NEu/jjnh1QSYv6z29W74cL
	Qd3cb2NJ5Zm6Tx2TGwBcDoroAQfDG3PGBSwFm3b0vgUg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ud9hgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HFtljW000742;
	Tue, 17 Sep 2024 17:16:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nntq6erj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48HHGmJQ17695428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 17:16:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E781358059;
	Tue, 17 Sep 2024 17:16:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAA9658058;
	Tue, 17 Sep 2024 17:16:47 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.93.228])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 17:16:47 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@codeconstruct.com.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com
Subject: [PATCH 00/15] fsi: Fixes and improvements
Date: Tue, 17 Sep 2024 12:16:32 -0500
Message-ID: <20240917171647.1403910-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XUAmBy2pCbBTeRRhC0Y2tTfH3eMPAIQB
X-Proofpoint-ORIG-GUID: XUAmBy2pCbBTeRRhC0Y2tTfH3eMPAIQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_08,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=804
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409170122

This series adds a number of fixes to the FSI drivers, improves
tracing, and adds clock calculations so that FSI client drivers
(i2c, spi, etc) might calculate their own bus clocks properly.

Much of this series was included in the previous interrupt support
series, but I'm sending this part first now so that the other
subsystem updates can be sent independently.

Eddie James (15):
  fsi: hub: Set master index to link number plus one
  fsi: Move slave definitions to fsi-slave.h
  fsi: Fix slave addressing after break command
  fsi: core: Use a defined value for default echo delay
  fsi: core: Calculate local bus clock frequency
  fsi: core: Improve master read/write/error traces
  fsi: core: Add slave error trace
  fsi: core: Reset errors instead of clearing interrupts
  fsi: core: Add slave spinlock
  fsi: core: Allow cfam device type aliases
  fsi: scom: Update compatible string to match documentation
  fsi: occ: Get device number from FSI minor number API
  fsi: occ: Find next available child rather than node name match
  fsi: sbefifo: Prevent async FFDC collection for Odyssey SBEFIFOs
  fsi: i2cr: Reduce status checks for read operations

 drivers/fsi/fsi-core.c        | 185 ++++++++++++++++------------------
 drivers/fsi/fsi-master-hub.c  |   3 +
 drivers/fsi/fsi-master-i2cr.c |   9 +-
 drivers/fsi/fsi-master.h      |   2 +
 drivers/fsi/fsi-occ.c         |  50 +++------
 drivers/fsi/fsi-sbefifo.c     |  37 +++++++
 drivers/fsi/fsi-scom.c        |   1 +
 drivers/fsi/fsi-slave.h       |  97 ++++++++++++++++++
 include/linux/fsi.h           |   1 +
 include/trace/events/fsi.h    | 131 ++++++++++--------------
 10 files changed, 303 insertions(+), 213 deletions(-)

-- 
2.43.0


