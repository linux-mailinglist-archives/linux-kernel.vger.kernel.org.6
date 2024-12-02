Return-Path: <linux-kernel+bounces-428202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF51D9E0B67
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C66D164049
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502071DE3A5;
	Mon,  2 Dec 2024 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BqShDiE7"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A19170800
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733165984; cv=none; b=CchJyVcvzwUFhZvGh+k2V8ldRydCNsxyzvoMWMUFydtUMW8FvwdkUp0mo454nKbH7xkUdc0jFeqx1vPPG4G6uvb+98SGB33j4/6SULY8yp0q05crw943VATjMBwjXWDSOjA2aOGR2bNNy+cO31t0jtTx9SnwmcMGRpb8LyrfHqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733165984; c=relaxed/simple;
	bh=kKBsj5BcSA/E442Svcd48cKRaaZ3Y8NqP4NA5BgDCsc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qjgg6iUOrp2UXjftjhgnRL4VHdEuMIw88ZHZYQxVNpnWlm+sizhQPqJI5SFAX5ik9XwNkbZHRt7MVD47o9MC0qJWGd7WfxsldZopURx+52eAOGlMYjz/of1TL9b9EbsqimorZKRTPYkGFrxWGTciH/Zbsx5Wy7OIJoctVN+AyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BqShDiE7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2ABRin021884;
	Mon, 2 Dec 2024 18:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kKBsj5
	BcSA/E442Svcd48cKRaaZ3Y8NqP4NA5BgDCsc=; b=BqShDiE7qt0NXgBZJZNnDS
	oZTmMbRvgcvBAexbGaFMPAtZzu7XyEJHXUMSbpQOixMqbLOFbJew2WO3CW1ZuXXO
	XJmQEGe6YNnD46FZ9VSwWzTMWL7EXowZFBic6FZ2Rx+m/7Rz4YxTmKjWBltUsh9k
	S5s4gTCrdRwGKqrEpsMSfn5dkM276RGyvcNm0jpXDYzWUTqlK6E3XHxW29DUut+6
	eYKG+zK6TNWkM+UAFqExzMItmite7O+hUubrjG1V01unhMParuMdtFFxp4kQKqXp
	63RjRCfNfrmFPTbLp2JYFdqPHyFhic26avY7LpHLB8xDYDhMlkMp2Aj3wuafILaA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437s4htfdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 18:59:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2HB4um029509;
	Mon, 2 Dec 2024 18:59:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438ddy8na4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 18:59:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B2IxDij59113758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 18:59:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 430F620043;
	Mon,  2 Dec 2024 18:59:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4EE220040;
	Mon,  2 Dec 2024 18:59:12 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Dec 2024 18:59:12 +0000 (GMT)
Message-ID: <155228c69769d32c234ea3ae8fe01f889f221974.camel@linux.ibm.com>
Subject: Re: [PATCH] posix-timers: Fix a race with __exit_signal()
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Richard Henderson
 <richard.henderson@linaro.org>
Date: Mon, 02 Dec 2024 19:59:12 +0100
In-Reply-To: <20241202172808.GA9551@redhat.com>
References: <20241202155547.8214-1-iii@linux.ibm.com>
	 <20241202172808.GA9551@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZErFoXAGhNXkCeS1PMmUX4F6aSfEYJGI
X-Proofpoint-ORIG-GUID: ZErFoXAGhNXkCeS1PMmUX4F6aSfEYJGI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=716 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412020161

On Mon, 2024-12-02 at 18:28 +0100, Oleg Nesterov wrote:
> Ilya,
>=20
> I hope this was already fixed by Frederic, please see
> https://lore.kernel.org/all/20241122234811.60455-1-frederic@kernel.org/
>=20
> Oleg.

I tested the Frederic's fix and it resolved the issue for me.

Thanks!

[...]

