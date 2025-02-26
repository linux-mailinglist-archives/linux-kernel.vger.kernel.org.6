Return-Path: <linux-kernel+bounces-532997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F6BA454A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F3E18949EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8274C261363;
	Wed, 26 Feb 2025 04:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h6Sea7Db"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B21A9B34
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740545218; cv=none; b=ehlfZJqfkfcykwCs/h3+tLBstC+O6JBv6CV3o2pc5xleltQ7TNhOVeLes8uc3nF94dchRV0GUXVSdnLyM6RnyafKQbXW2lrk6xKNxi1lm4M8V5/8LrRAe3EhqojFrNkmadsv9W3wj/gi3FhtYbGWt0SfW1Kl2MOQ+r0kKndHblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740545218; c=relaxed/simple;
	bh=rq4PxzLYhA15q740mf+tAF96TAwKbxgLXLvQ4dxoosA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUavV8oI2yFmwNNSEb7rBUNOjGu+zOjEfXb1vlxVGdt8e+amlLkEk6xYs66a1g1tehp3O95Dz8pCzpQ/Kuk5JFwmcoKtcwUhRWIH9u8+0h4s52YzKlrDlklPgSB0j7DefFu+l11U1JBIuDEEAL5Xg8YKastHjcLwrerK35U2a4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h6Sea7Db; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q1mARR020966;
	Wed, 26 Feb 2025 04:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UGnsTD
	CDGe8G2v3oTBOpZ/92icpnLt9nPD0ihUM9Zi0=; b=h6Sea7DbE5qCgiNltLBx5S
	ZROcGkjuquNfuYfLJuvGpOGVKZboxy+RYlj0GvdRJEwS8UfCTtt7KhWEGOHmgYxK
	g7N5o3nhdjSLuzimzvmg+XUFzx+08On/Gz3aM6DFUyyiEjvz4SHbCIm2dXlYkay+
	kZ07S0Yn/orHIrci2PACv3YPTOAvXh4XwLD85knV4bzKUqFSbQ+rRl8XVpu3LBFP
	FY97jKBoCrPV5Rhz+RQ2i3JcpAzQwuzFmfjWDh6f9A6LXyS+ZKREBmTC+xKRHgjy
	Ve0nFsu1J37uLREOZTC93Hco+jmrlaX4kK5yVSo0+s7yUp/pZyUkVmMMvAYaxcCQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451q5bh417-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 04:46:41 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51Q4kfxi015738;
	Wed, 26 Feb 2025 04:46:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451q5bh415-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 04:46:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q26erQ027333;
	Wed, 26 Feb 2025 04:46:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum20cyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 04:46:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51Q4kc2853150018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 04:46:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A98C620043;
	Wed, 26 Feb 2025 04:46:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E577720040;
	Wed, 26 Feb 2025 04:46:34 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.65.188])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 04:46:34 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/ipic: Stop printing address of registers
Date: Wed, 26 Feb 2025 10:16:32 +0530
Message-ID: <174054508252.1386382.6056168945528529778.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <ecffb21d88405f99e7ffc906a733396c57c36d50.1736405302.git.christophe.leroy@csgroup.eu>
References: <ecffb21d88405f99e7ffc906a733396c57c36d50.1736405302.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qd2TNnM2phvmYQkvNTET_B0HC_81_FPn
X-Proofpoint-ORIG-GUID: 2Z_Ib-uG9xuEO2Ka7KUTe2rXjrWHgbKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=711
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260033

On Thu, 09 Jan 2025 07:48:36 +0100, Christophe Leroy wrote:
> The following line appears at boot:
> 
> 	IPIC (128 IRQ sources) at (ptrval)
> 
> This is pointless so remove the printing of the virtual address and
> replace it by matching physical address.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/ipic: Stop printing address of registers
      https://git.kernel.org/powerpc/c/67d939159764d0c826971f9a83b4df687df5cbf4

Thanks

