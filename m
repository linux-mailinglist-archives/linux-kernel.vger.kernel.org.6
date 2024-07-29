Return-Path: <linux-kernel+bounces-265674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FDE93F446
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F132E1C21D85
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648D6145B27;
	Mon, 29 Jul 2024 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gQXIKMJG"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDFA145336
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253167; cv=none; b=ls4ijkMgmCNbZ3F9yTjllQGjG2gdnXeCwBESvNCAH0ynlPWgZx4HyWpQBDecATP1kbuPhHauX4kjeTR1eIT5ki5AEJQ5siif8o/q2hVJNsrHPYK4OJ/XBIDJylaBmeEU+KlIKIG6pfzUfUHM/I+VVdBZUjWWRmj4HUzIVJkJP/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253167; c=relaxed/simple;
	bh=YX7MAxi1eoO388V1QAqSh1iSE1d2pFOd0fQ/WdVlUf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=denuxD3MpH8BBRd/lRMJJNOCP61ofjKoxOLTdsAx3u3Xr5d8ZH0YSB99RwJJxH9beHqOLeWRGMbhZGsHPtjkk4DuB/DFw+0WlJmwzzXoxX0fd51ifO7HvrbaBIwoZ3aBXJtb6Kb2s7DPQ7yooVM5vNID/0dqK/qIMg6HoH/CMxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gQXIKMJG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TAgdRW024507;
	Mon, 29 Jul 2024 11:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	ej2UuXNiMc+VzH7/REVn/NwqaaNUOdQWMSHHiRNmCC8=; b=gQXIKMJGlJHRPw4d
	x0jUfpeGCFroZDkNY9m5ahutwXW8TQr2oPHBy9G5R2SCjdleDjmXGD68D3rpPR0X
	7mjLeA8m37f8dm9A713owjm3Lrwuz9eHtsU1dKVJBcxmIiq8a8lBO6Qgr38BlXrB
	zbiVrRnF0glRsta+NAT65SRyfqxkcHoC0s9iN6JD0jBcUQOj1QZlMpeHygmaICo2
	B5Gxs9kyelTj3lc4Q6qiLCb+Xu1KyklnojicsfsKhnL9gsK2j5pVhmhib9juMTj2
	aDfnQsJE+1FwIvmnwUFwt6zfPhIBIoMTAebEQQkkeSfQ1d/Ndh/FzpssOFW0rYDU
	yReemA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40p9bwg53f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 11:39:18 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46TBdImU025318;
	Mon, 29 Jul 2024 11:39:18 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40p9bwg53b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 11:39:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46T9fVxf007457;
	Mon, 29 Jul 2024 11:39:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7txmvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 11:39:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46TBdDvD51642802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:39:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2B7E2004D;
	Mon, 29 Jul 2024 11:39:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 775F52004F;
	Mon, 29 Jul 2024 11:39:13 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.171.16.76])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 29 Jul 2024 11:39:13 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] workqueue: Remove incorrect
 "WARN_ON_ONCE(!list_empty(&worker->entry));" from dying worker
In-Reply-To: <20240725010437.694727-1-jiangshanlai@gmail.com>
References: <20240725010437.694727-1-jiangshanlai@gmail.com>
Date: Mon, 29 Jul 2024 13:39:12 +0200
Message-ID: <87wml4s9zz.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ipS9a1dL7SXRKEXkK3vLD9H-_CqMOvP9
X-Proofpoint-GUID: ofIxgT0QXnOTnNfPLxHyVnvtieggilRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_09,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290077

On Thu, Jul 25, 2024 at 09:04 AM +0800, Lai Jiangshan <jiangshanlai@gmail.c=
om> wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> The commit 68f83057b913 ("workqueue: Reap workers via kthread_stop()
> and remove detach_completion") changes the procedure of destroying
> workers; the dying workers are kept in the cull_list in wake_dying_worker=
s()
> with the pool lock held and removed from the cull_list by the newly
> added reap_dying_workers() without the pool lock.
>
> This can cause a warning if the dying worker is wokenup earlier than
> reaped as reported by Marc:
>

[=E2=80=A6snip]

The crash I reported is fixed by this patch. But I can't say whether the
removal of the warning is OK.

--

Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

