Return-Path: <linux-kernel+bounces-251936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E52930BD0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 23:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F23F1F21E3B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 21:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C376C13C9CD;
	Sun, 14 Jul 2024 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i11aRz8k"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D63DDAD;
	Sun, 14 Jul 2024 21:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720993680; cv=none; b=o3BUHEOqoPyqVdHPs/SZdAftNLQetuNmemAlq4PTnsN3Oo9iDRzwQXzWGqsr9b7ZsOKUlbhPV6NxcASgH9ScS/itUeF4s6vmUKjvMTXag/QhKI+ywggY+03CXrX8mq/zp7ZyjXEeOQN+cf+VH3xXQOy5ocEZJHkJJfAHN7IuDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720993680; c=relaxed/simple;
	bh=OPgvFq7obMv7GmeiLernwZ91FcWyRXMaMaPwAII0TKE=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:CC:Content-Type; b=Ixc9yeJvagGhXCpfB1RJCL91Am1c1vmpQpSRSja2sai+utCQZETb184OlWsbQuLPxGHX9UXdo8bj+nl5mc4F9sT71gtm8Xb32B9jT2x9CELR+YwyufNzoNQ0X1rSdE9Z9JC0Mxpu4SaIWXmNjaY9QJHgOZopCF8eTgbFYV5yE7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i11aRz8k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46EKnQbh008267;
	Sun, 14 Jul 2024 21:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OPgvFq7obMv7GmeiLernwZ
	91FcWyRXMaMaPwAII0TKE=; b=i11aRz8kiKoU58NFzRB0gcXfQAqbRk4+1Y0lqd
	wOZ7acqhtFY86yr4MmDC18TmO7mnoAJUKeRHf8h2D9Fb/gIDlVJChswJ8dRikOoC
	WDBMpv7/pnEXcO3JdD3pjvgrEjagofz7Pti3jERYtPr08Jfr7UZzLyfpnRxl9Pg4
	qsX90rP7+iyaKnR3nWxNEVdnSzoqc6kG+2ylvWRb5lbNWvl6OmFdHAqJvwNDJVTU
	XYTUV/LjuzPoZVdexVDmWMimCu5G6Yg/n9KUTZMRK+eyiDBJHdWDEavwbYHhBsjY
	2oWv6OojOQpW61oLKnIwDPEneY1p2qm5vMGNSiYHEC1jSXlg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bjrja7hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 21:46:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46ELkL6G026617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 21:46:21 GMT
Received: from [10.48.246.224] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 14 Jul
 2024 14:46:20 -0700
Message-ID: <2d168cf9-e456-4262-b276-95e992b8eac7@quicinc.com>
Date: Sun, 14 Jul 2024 14:46:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: MODULE_DESCRIPTION() patches with no maintainer action
CC: Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Karol Herbst
	<karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter
 Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uHiJuLrbG-gyOrVCv3S8wWVfEDAvVCSw
X-Proofpoint-ORIG-GUID: uHiJuLrbG-gyOrVCv3S8wWVfEDAvVCSw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-14_15,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=841 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407140174

Andrew & Greg,

I hate to bother you with such mundane patches, but the following have been
posted for a while without any maintainer or reviewer comment or action, and
they have not yet landed in linux-next.

What is the path forward to have these MODULE_DESCRIPTION() warnings fixed?

arch/arm/probes/kprobes/
https://lore.kernel.org/all/20240622-md-arm-arch-arm-probes-kprobes-v1-1-0832bd6e45db@quicinc.com/

arch/x86/mm/
https://lore.kernel.org/all/20240515-testmmiotrace-md-v1-1-10919a8b2842@quicinc.com/

drivers/spmi/
https://lore.kernel.org/all/20240609-md-drivers-spmi-v1-1-f1d5b24e7a66@quicinc.com/

(note that beyond these 3 patches I still have an additional 13 patches which
need to land in order to fix these warnings tree-wide, but those 13 patches
have had recent maintainer or reviewer action so I'm not seeking your help at
this time).

/jeff

