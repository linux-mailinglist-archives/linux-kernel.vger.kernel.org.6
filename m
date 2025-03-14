Return-Path: <linux-kernel+bounces-560663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C08A607E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E0B8806F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538FC14A0A3;
	Fri, 14 Mar 2025 03:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="azvkX/+c"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37802146A6F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741924037; cv=none; b=QvW/HZh1WTmaZ65SMFyzg+A/x+6XvcK1Uwl/6VvH3E6sT7QsgJecW3+gKIrJo1iVvqVkdHIAXVrGalVdMDz1nD0ep/1dVxxYLvW0wsWuPkW0w4F7OesrFcyH95fRfgW1kucopWyVo6BGfcxikWr6nF8P3iIZE3FGDl3+oT6TS40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741924037; c=relaxed/simple;
	bh=oIywZkGD5Th6OTLIBRKSxZxSQC3/7L8FOcIq6zoJstY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyhwKNK+FZilieksJAWnEutdxKAg9OD1QYymbzXXeEQQAkNRGWwl8dH58VFHeyHY1LZnA8Wa1bgDw8dRC3yx2CGyNR5LI/84CdaNmZf1lHnlrmGLJnFq1P9WIyuJ98439/R8nIIYrs6sRVIFJqoBL8s5yu5rRYwcFF38TkOIkgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=azvkX/+c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNPBpo007380;
	Fri, 14 Mar 2025 03:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GqfipV
	5ca4LdAp5dGcglzb+9cWzAV1VCxMnJ+UczaPU=; b=azvkX/+cmCOlQ/QleP2LVj
	zEhCYF4lVyBWc7YAKabmwhYZHs8HA7fhJOcstL9Jg0DfzO3vbSLxKIWF2INFKtpV
	LF41Fs13CPWqc0NLHDkXyngZmJxbi5A/pkTI0zfR6/sYUc6BjgQGWlRmbrw0sB/Y
	/t687OZ4DqfO4UCzX1jjZdp2WVM6/QqM7ABZic1bptHHUg5m6P4c7SgM40qJmSCp
	sfVBjRvN/43cQMUFNUimTSNuthpm/rLRp7Hd0dSaX4n+h3pWGs73J6cnKN0x8F5X
	cz7JVSpSTp1fkD3UbDPU2AeqRLcUtx6yoEUUE43q7D72PN/sTXPcznkr+MegT18A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6s59ajy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 03:46:59 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E3kxCx027323;
	Fri, 14 Mar 2025 03:46:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6s59ajw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 03:46:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E04KDR007468;
	Fri, 14 Mar 2025 03:46:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrd1w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 03:46:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E3kuiH18809296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 03:46:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 693C42004B;
	Fri, 14 Mar 2025 03:46:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A808C20040;
	Fri, 14 Mar 2025 03:46:54 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.in.ibm.com (unknown [9.204.206.207])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 03:46:54 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] powerpc: Fix 'intra_function_call not a direct call' warning
Date: Fri, 14 Mar 2025 09:16:53 +0530
Message-ID: <174192385437.14370.8812406188343679236.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <88876fb4e412203452e57d1037a1341cf15ccc7b.1741128981.git.christophe.leroy@csgroup.eu>
References: <88876fb4e412203452e57d1037a1341cf15ccc7b.1741128981.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mmWLhl5V9nK_SNc1QL7Ih81ALHW2UDbF
X-Proofpoint-ORIG-GUID: L5VJTQ8DqvsXjDnuDVB9-1qbt2NOdF-D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_01,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=727 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503140026

On Wed, 05 Mar 2025 00:00:19 +0100, Christophe Leroy wrote:
> The following build warning have been reported:
> 
>   arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0xe84: intra_function_call not a direct call
>   arch/powerpc/kernel/switch.o: warning: objtool: .text+0x4: intra_function_call not a direct call
> 
> This happens due to commit bb7f054f4de2 ("objtool/powerpc: Add support
> for decoding all types of uncond branches") because that commit decodes
> 'bl .+4' as a normal instruction because that instruction is used by
> clang instead of 'bcl 20,31,+.4' for relocatable code.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Fix 'intra_function_call not a direct call' warning
      https://git.kernel.org/powerpc/c/382094a41c706bf9d990a224d5d4d34c02a21f15

Thanks

