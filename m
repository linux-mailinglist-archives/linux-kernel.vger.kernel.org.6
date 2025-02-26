Return-Path: <linux-kernel+bounces-532996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35306A454A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12431894877
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A381917D8;
	Wed, 26 Feb 2025 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BWIYceyM"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87A221ABD7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740545215; cv=none; b=flxR0AZ5uJgiRwWxSyMrHZOdyAsURokUP6DgdG+Anrz+uGchE84m6R/rL1XXqWljsmCOBGZeZXEgVRhGpIARJI0bsSBhUet7XUtCiUrUPJeDUs7McWL4aC3esxbq/qQFCg5CWXHp2rbQKbrST3h276GSWUkzhQkpN2oIwFtGjfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740545215; c=relaxed/simple;
	bh=hpzFBgxbZDkFIKE5tdJKliY5Tp3S54pYi+VbyZpnx/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMz9aVYLaAJ1yPpjeia4yu7pP8U4UzVqlHlLRaBB3m+/6xdrwlAFHHSX2zmz2hj4AJ3ghjym9COoJA0yroXrCb1qBLTfpOpSXv0ZKsxIW/sbcMaIhPavcHlVOBk9u7chWv+DpAFfr9CrvDbTw7Q+obN08PbN4ksDcunklZU7I/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BWIYceyM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q1kswq027799;
	Wed, 26 Feb 2025 04:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/jFEVa
	0ZWxt2n9ZJoBsUd19dCfch4h+qt59lzlhzq7c=; b=BWIYceyMBwWUZOI88KcjE/
	tElFcybj+T1AU4OP0d3I1sqqj6xNXMF7KZqibIWnTfoZVyzPhmE93uf/+sGtR12a
	EtL3p5I08RLUcTFQucgnmQZyAA3vbtQcS5zfjDsVv40RBja5nWeCGq8P/GjljdC7
	8Qv/mKJ/5jkBpkI3E2NxexyvfD8x8+fYOvAkJQ+MrDoDKsPmcGtfB5PQOPZpICaY
	OQ8qRbuXc7YqWHUFuNBIxuyWN/h7M4u0adc0c5o8LlgM8LgmdR7MuKqZjM/zrk9b
	jMoP+BjOmOjaJ903WX1tv7NU6GdtFbDaejxadt85eAfOm1zTAyda3u+ND7HwhoRw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451q5j95eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 04:46:35 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51Q4kZlJ024787;
	Wed, 26 Feb 2025 04:46:35 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451q5j95ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 04:46:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q4TrrC026287;
	Wed, 26 Feb 2025 04:46:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswngsut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 04:46:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51Q4kWhu41615716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 04:46:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41A1A20043;
	Wed, 26 Feb 2025 04:46:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 244C820040;
	Wed, 26 Feb 2025 04:46:28 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.65.188])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 04:46:27 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] powerpc/44x: Declare primary_uic static in uic.c
Date: Wed, 26 Feb 2025 10:16:26 +0530
Message-ID: <174054508251.1386382.8390304767144100879.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <0e11233d30333610ab460b3a1fd0f43c3a51e34d.1736331884.git.christophe.leroy@csgroup.eu>
References: <0e11233d30333610ab460b3a1fd0f43c3a51e34d.1736331884.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SsfQpaZiyM8m6zvLnAS8LKdCYTYAd3DE
X-Proofpoint-ORIG-GUID: EJ6bfjv7CBq3maI_XU5MYHt55rXMtqki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=808 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260033

On Wed, 08 Jan 2025 11:24:54 +0100, Christophe Leroy wrote:
> primary_uic is not used outside uic.c, declare it static.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/44x: Declare primary_uic static in uic.c
      https://git.kernel.org/powerpc/c/779c501cab14ba0b441a3c802c56be46a24f5c3b

Thanks

