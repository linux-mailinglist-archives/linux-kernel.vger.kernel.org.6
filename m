Return-Path: <linux-kernel+bounces-560666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D924EA607EC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB9C1775C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30A213B2B8;
	Fri, 14 Mar 2025 03:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bwNI0XW3"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F278E15667B;
	Fri, 14 Mar 2025 03:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741924041; cv=none; b=No039MLnUUjKAHwzGe+upYS10r65a+LKU0cLObPP58Vc0vJtloPMZXa7VGP+MLzuQrplJq/o+oISqGQJQEUSY6TBrjC4pyfPSN55Y6LxeEWeBO0EnlEm3Ooup9ARRDn0BALI5r0IW+ZIoOPSG0Mb7q2qEbd/TfmHt2eXuMMnIC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741924041; c=relaxed/simple;
	bh=VgynmPp8o8Kly1ovbL5L6pygpdyjHB221aCZlk+6jb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WczCINHAX6HpX6Ll79u8cmklNOOPiSEGbE+MNIkebqVVq+Iosesg46q+2gLktQ147e0AWFWW3zRB/QiH19Jp3SHllHtck6W5c/I0/xNFy5X2ZGSDV3qL0JXy+sy9PzAL9Fukhe2leFZGzHY2jvGJnBXENSxL1JhxBoDvOyFOUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bwNI0XW3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNOwXX018106;
	Fri, 14 Mar 2025 03:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/qvyeY
	YYxIm9T87HGra/YtOB/c7AxJJYhqzkfAbhCfo=; b=bwNI0XW3UoxChqJEpLS3B/
	35k2rIieWnCo02ba1H290RUsvTEVxdeaAth6is9yBRnUcaBH8uSMpqJN0GTOhhcP
	9/JjcngT0rCZqKpME3cBJ5Fz6iibKyXq9R7ivmeRVaq7KwrEldAaaJNAQ3RYYvaO
	WJuyfQUEPVQCmWUEZ3R3YHIrPQGzUL5kaSGg3OrPtAZFZkn3Gvg2BGCzy9zq8vnb
	fQrq1iwmh9+wNC5eIPxsKsidpY8Kionr+YWRW4PsahQZ1XbkLKzcw/ah/saQr7BJ
	O+MVfcEulw+VoXF2pN4FdVVO0UnEu8/fdsY6LaZdQb/8C9T3Rszm8u3LDmziIaOQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c0srbfuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 03:47:06 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E3iIi9030125;
	Fri, 14 Mar 2025 03:47:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c0srbfuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 03:47:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E04Np0007490;
	Fri, 14 Mar 2025 03:47:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrd1wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 03:47:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E3l2BT18022904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 03:47:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B66520040;
	Fri, 14 Mar 2025 03:47:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80D3B20043;
	Fri, 14 Mar 2025 03:47:00 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.in.ibm.com (unknown [9.204.206.207])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 03:47:00 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Andreas Schwab <schwab@linux-m68k.org>
Cc: robh@kernel.org, saravanak@google.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/prom_init: Fixup missing #size-cells on PowerBook6,7
Date: Fri, 14 Mar 2025 09:16:59 +0530
Message-ID: <174192385434.14370.13614517118508707143.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <875xmizl6a.fsf@igel.home>
References: <875xmizl6a.fsf@igel.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F4a78_1Bf75BdXRZPmX8d6tNl8qAogCC
X-Proofpoint-GUID: JtZRzv744qTWLYqtAJmCWHTS9f7OHq-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_01,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=730 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140026

On Mon, 13 Jan 2025 18:19:09 +0100, Andreas Schwab wrote:
> Similar to the PowerMac3,1, the PowerBook6,7 is missing the #size-cells
> property on the i2s node.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/prom_init: Fixup missing #size-cells on PowerBook6,7
      https://git.kernel.org/powerpc/c/7e67ef889c9ab7246547db73d524459f47403a77

Thanks

