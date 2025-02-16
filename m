Return-Path: <linux-kernel+bounces-516613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80005A374BA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 15:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B05C16CB4B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 14:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE74194AF9;
	Sun, 16 Feb 2025 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Aw5CEZRJ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF4B18BC1D
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739716635; cv=none; b=du4ihkuhmUgV1wxShlpyxxCYZo7udPIQ69TAdqGIrSz3CzWU4FJW6a4P6kFUkCW29avC9/kL7awJUT8PGQxANvptd4WgPKxMbV5sSmM2CwgdUmIdDeZ4VW0CYdzFbhO0I4eor39Fp8FeARlb+tF7/aY5FVCbcf4C5z3thQ7qw50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739716635; c=relaxed/simple;
	bh=jJQhD75jKktmb4BgIxDSwBKaAZQ9a6KTmdQKQrbfXYA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=JhJHzbd99IDnKzJGBvbe1PS85Ez7LTUBfYtW87/RVClpaQbjDN4DCaxcxgR53AJgC6WDuJ0J6fWHQiPT1qHqOSwm98+cOBpfy5Aiu6W2A+NYLXvUkW5UrtDee579HKrve/OBqNyH2zBgJYAHnZ/mBT6F6+8g41TWNJrILxEhnfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Aw5CEZRJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GDroZJ021213;
	Sun, 16 Feb 2025 14:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=XzCGYRBydUXu4RE+1YR673QjfYos
	j/ZQ+0EkfdbbZ6g=; b=Aw5CEZRJg5rzQI6gNKBuI8NY8PQAoGmebxgl3u1iWiVu
	KtqkAbiCYjdA1j0lWq+P17VK/vunt+QWhxjua3Zj7phnKSeBoi51/gl/aqiNT7Sf
	a0OSNuNnJnTimJpjZH0t68Oivt3ms+XZG263paX20LJyNvXHXQJMyOsXT6ZOdtst
	jAJoUlsUWEoyfKq0Vq7u19cvANQjqPHlNx7JWpPTG9pYldH7zp5JtAVyFAwwnrLM
	TeLnzCfnoKOxTmTQWCTF392hHNS+to/JjSzAFg8XKNYmIsHIv21GlWJygXGjqN+0
	B5dHPqwjVRSYjUzqrecZTOgZMdD8TJHwoNps62beow==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44twrtm8bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Feb 2025 14:36:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51G8vqse024883;
	Sun, 16 Feb 2025 14:36:50 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u7y19r86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Feb 2025 14:36:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51GEamiI29754050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 16 Feb 2025 14:36:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9ABA58059;
	Sun, 16 Feb 2025 14:36:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77C1058057;
	Sun, 16 Feb 2025 14:36:45 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.242.32])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 16 Feb 2025 14:36:45 +0000 (GMT)
From: Venkat <venkat88@linux.ibm.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] kexec: Fix kexec_locate_mem_hole() for missing
 CONFIG_KEXEC_HANDOVER
Message-Id: <CDD6EF33-E1A5-4D0D-81D2-F280E23A310A@linux.ibm.com>
Date: Sun, 16 Feb 2025 20:06:31 +0530
Cc: akpm@linux-foundation.org, bhe@redhat.com, graf@amazon.com,
        Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com, rppt@kernel.org,
        Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TlMFenNNJ55o34LALG77mJKNEPZXoq4D
X-Proofpoint-ORIG-GUID: TlMFenNNJ55o34LALG77mJKNEPZXoq4D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-16_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=350 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 adultscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502160131


Hello,

I have applied the patch on top of 6.14.0-rc2-next-20250212, and =
proposed patch fixes the issue reported.

Please add the below tag.

Tested-By:  Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>

Regards,
Venkat.=

