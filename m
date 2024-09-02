Return-Path: <linux-kernel+bounces-311493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DBC9689D1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0D41C223A8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C08B19E97B;
	Mon,  2 Sep 2024 14:23:54 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F5179AA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287034; cv=none; b=q584RG8nGkyWOS78+BcYl+JeVc9WiTXAgEq0xiIzuVAEYj20nsPJyBAXUlpvIu61W5jU6i1dkJvZvbviSeL3QWsnJ6YcwE3+7prjqJOc+b9TXCZAVowF8D3MSNgZptgu/IqJuzERZbPej6fdclz732V/R4/bZ8R8FSdX/d5jXww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287034; c=relaxed/simple;
	bh=cLqYE5DR32lSkmsgs5xYJbMU44sYK8sXP1WRLE578QQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rT5g/6wuDlsi6mEoyhulcWmY8Dnh8wDSdWRPb7MHvCnTZBKiYluP5qTiFK68nMqxlGZ/MIIkdgCQnd2M0jgMCCMn8MhrD8JL5Oa6wIoky7Z0rdrvwe7lo/qRPtxZrq+zsgFYIDbCLR5tNBMisa3RsiHqE6+7XdMMYTV5Qthq5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482CEVQ0015030;
	Mon, 2 Sep 2024 14:23:13 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41bt59a03d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 02 Sep 2024 14:23:12 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 07:23:11 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 2 Sep 2024 07:23:09 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <joseph.qi@linux.alibaba.com>
CC: <akpm@linux-foundation.org>, <heming.zhao@suse.com>, <jlbec@evilplan.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <mark@fasheh.com>, <ocfs2-devel@lists.linux.dev>,
        <syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V4 2/2] ocfs2: Fix possible null-ptr-deref in ocfs2_set_buffer_uptodate
Date: Mon, 2 Sep 2024 22:23:08 +0800
Message-ID: <20240902142308.192983-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <18e9dbe0-afe5-48d1-9788-6b13617aff50@linux.alibaba.com>
References: <18e9dbe0-afe5-48d1-9788-6b13617aff50@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PhvzFckevw886VmTD3qoPKTUbHW_C1Gh
X-Authority-Analysis: v=2.4 cv=DN/d4DNb c=1 sm=1 tr=0 ts=66d5ca50 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=EaEq8P2WXUwA:10 a=Z4Rwk6OoAAAA:8 a=R-6jl9kCdR-hZtNxHjAA:9 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: PhvzFckevw886VmTD3qoPKTUbHW_C1Gh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_04,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=834 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2409020113

On Mon, 2 Sep 2024 10:20:38 +0800, Joseph Qi wrote:
>On 9/2/24 9:03 AM, Heming Zhao wrote:
>> On 9/2/24 08:54, Andrew Morton wrote:
>>> On Wed, 21 Aug 2024 14:39:11 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>>>
>>>> OK I think I found the correct patches - v3 of [1/2] and v4 of [2/2].
>>>>
>>>> For clarity can we please have a full resend of both patches?
>>>>
>>>> And let's please have a [0/n] cover letter which describes the problems
>>>> which are being addressed and which also briefly describes how they
>>>> were addressed.
>>>>
>>>> Also, it appears that both of these fixes should be backported into
>>>> -stable kernels.  So let's please try to identify when these bugs were
>>>> introduced and to add a suitable Fixes: to the individual changelogs.
>>>>
>>>
>>> Again, can we please have a full resend of these two patches with the
>>> above issues addressed?  Particularly the identification of the Fixes:
>>> targets.
>>>
>>> Thanks.
>>
>> Hello Andrew & Joseph,
>>
>> If Lizhi still doesn't respond by this Friday, I will send his latest patch set again.
>>
>I'll do that, thanks.
Sorry, I didn't notice these emails. Thanks for your help.

BR,
Lizhi

