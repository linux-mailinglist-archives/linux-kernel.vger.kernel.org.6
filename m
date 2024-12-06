Return-Path: <linux-kernel+bounces-434519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB01C9E67C5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6731B281CBC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5281DA632;
	Fri,  6 Dec 2024 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="dxP73iQX"
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22A618D65A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 07:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469517; cv=fail; b=hdR1Xl+HnY7kjkUP8LyVzCU4Wh+GREf2+DR6i2a3JYF/Xu8LBKFPAeBGcpzEhpUxF9Vruwz4uJ6ZOyEgruXzCJ4Ic3o93xGEPGf8WPbc3Zv+S2K6Vup0xd6RhY0qwGZrfgw5NlaLm+VdpcZzjjqQNbfq62oCqVx/6m1N0LaW2LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469517; c=relaxed/simple;
	bh=B1Djs0ZHSIr9PiGhLO/UTtRk90Jr6Gu17jIrkDOfzHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sKiiG5NVryG+RS/AiCTx4qK0qH5mjXEUxHIla2Jkp5qpmUQk+j5/n07NXyZvSEuV/Kzkv3GVI75bSyoU1Vmvrk1O0I/ZjtbvF5ustugq2+JqCNUqCb5nGlgVtHQu/X2yTL/D+Lk+AEDpOM0qjRHoPOivj4yAgB6Uso1p6JSq+cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=dxP73iQX; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1733469516; x=1765005516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B1Djs0ZHSIr9PiGhLO/UTtRk90Jr6Gu17jIrkDOfzHg=;
  b=dxP73iQXqnL0N01F0SLzboX1QLvyv9Cczahgs/n0EZ5TrKQmE/6hsdmU
   wPdt20FFPdnbLHQUWut4bpiw66DKWtVncQbRgRqEDmmHRR7MsOAZ1VRVF
   KTda9QNv1ycKoacFN32S9q5FSr4Lr7oro6aussaKMwNUvCKNUeuHPXLUJ
   8LjINQR8Mkj/fsIsDDaPucYTrnlDlmCyukWPp8lqpUTMBC5meqdZKweJp
   8IVhFLIM4wDE6Gxt+nOxYsR1ocvuoKRKuoyEJBzj54A2lYpnvjCmQQTBB
   NstrSlAMofh0SOIdDtXNpNEiaGDNC5tzhEQFU7PM3BZlGeRxDCXAGK9SH
   Q==;
X-CSE-ConnectionGUID: mgitvW2kQ6+rOxKzTPIC+g==
X-CSE-MsgGUID: n+H9h/dITL64PGKjuuCsFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="50359638"
X-IronPort-AV: E=Sophos;i="6.12,212,1728918000"; 
   d="scan'208";a="50359638"
Received: from mail-japaneastazlp17010004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 16:17:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBKAv6i9K9iGTxaTqXfuK5EQSD0MALashM3ZmgFwCtf+7el2dwj1CTKDuCa86bnp0DNWOpOMxyk7vOllfcTaJzsbX5LbKi3q0CTig2vDLzdZbzX8/s3GZIWUmuDZZ++Lps2aCJw+d76XrvUBpHtBKeShv7ib3Ah8B5YwetMmL+gupP7gFM+hOeMdQrAelcIIAozX7qPRPpHCca/kcHiCqtJwQO94xmYfMwnHizF0wIV1MtUWMgSEPU6tMXAZL/JEpJA8rKespFYZkBVHbV5mmkNBHO9IQWuljkXt3wPfNgcPTA7GS4eBfGExfcGUl/YaQ1JXLyMfDeAbNfIlCMP7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1Djs0ZHSIr9PiGhLO/UTtRk90Jr6Gu17jIrkDOfzHg=;
 b=u/+/+6Qf6zzY5L8+hjUR6PahjAyqZ8XsmYgTfTfGagC3g4ssCRQgRBffEgzmZJ7YEvRD5hdPUcdHWYg46nMWEoc2t0zU7T1XucDMWqKSTygN/25MwGMCvkxa7Qom2v45wMabkWWv6fYLwP6HE8rQccp2rSPrSeqO5LCdcfXlHogePs58LjfBXA4cxepOl2UYWt0emt3VD591VZM2OyqXwDaTWu5+pPl591Qlo/Osxtr2P0yuuOWIYdYe6q2b+HIPt4+FGgBPHb4mJs6hTZSt1zAT0g57dmRz3NR+oJi77mSLsvLc8GjQFKhFhISf7UyLaz3pVPgilIy15JW93c1PWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OSRPR01MB12000.jpnprd01.prod.outlook.com (2603:1096:604:234::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 07:17:15 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%4]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 07:17:15 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
Subject: RE: [PATCH v5 00/40] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
Thread-Topic: [PATCH v5 00/40] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Thread-Index: AQHbFofRJouTwIy1BEanmx/f8g6+CbLZLNxg
Date: Fri, 6 Dec 2024 07:17:15 +0000
Message-ID:
 <OSZPR01MB879830095313B74078A60B598B312@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20241004180347.19985-1-james.morse@arm.com>
In-Reply-To: <20241004180347.19985-1-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=a73b02a8-4d5e-4362-9381-c0c958f5b85b;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-12-06T07:03:32Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 04f975698c074ff8883b38d995e8988d
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OSRPR01MB12000:EE_
x-ms-office365-filtering-correlation-id: 6db06a2b-c9c7-47d9-f026-08dd15c602d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?VmVrOU9kOGY0NXVJMXQ0cUtoOHRySEFuSmpFSUkya3hUNzhFTVI4SUVp?=
 =?iso-2022-jp?B?SmZDV0FuR0VsMzJwZzg4dXA4V0lCYXJPK1lhUFcvQ1h3S2l2VjExZlRh?=
 =?iso-2022-jp?B?SGh0c2pMSm5FZWlma3htQ1pDWWVFRXV1YmxFUnJNWmZFcjZJa21CaVow?=
 =?iso-2022-jp?B?eFRDaXFWR1JBM1ozaHBsblM0b1hKODgzNEgwL2JHNDVXc2xqb05PM3lK?=
 =?iso-2022-jp?B?SjQzMVFHaWx1Uzl2Z0RyaEt5cFE2ZkpHTkNGZWhTRjdiNU9ML3dPSlVL?=
 =?iso-2022-jp?B?dGRjK0NXUGVQSlpEakxlVFR3NjdyZHlFWVM2R2RlK0tFUTczM0RjeEN4?=
 =?iso-2022-jp?B?Qk9pYVpPbGlxRTd4R0FNdFdXRTVKa20xUnF1Y0hjZE9iSXZVMTFvSHEw?=
 =?iso-2022-jp?B?T0lWdjV1MzIvUXY1NnJ1ckFBWEZkbExPN1VZNkNmZzJOOGJCWXlrUzJP?=
 =?iso-2022-jp?B?b2RuNlpaTThwQUtHNEpOSHdEYkFuZUVqVG1SbDI4bG1NOHYyZ2lDdnF4?=
 =?iso-2022-jp?B?b3d2THQweU9pcXFaRURvY3BiV0ZkbDRKSmpkRC90NjgwZFVnQXlMUURl?=
 =?iso-2022-jp?B?NUNNMEgyU3R5KzYvWWh5ZFQ2Yk5RZ0FrSkU4aDM3cFdGc3pMRGhhRnRW?=
 =?iso-2022-jp?B?K1RJSmx3cGpmSUNHOG9RbHJOaVNSRE1WUEZtRklPcWJwb0R2RkpKQXZI?=
 =?iso-2022-jp?B?RFlMOHZiVnYvVGVoTEwvZlZDM2hIQ3Y5RDFTc1V1Vm9lbmtYUkU1UW1V?=
 =?iso-2022-jp?B?QkVoSG1YSWFyK09YS0V1cExXRHJQT0RNb3JYSlF3a0VBUkZuYmN6Y0pV?=
 =?iso-2022-jp?B?VEpuSGRJMzF2YUtnMVdaYXF1UGllanZBV29qU3FzVjNKbE9ZbDU2S2o3?=
 =?iso-2022-jp?B?N2Fyb0NmbS9zbms1QlFKTmJHSzJKV1dQY2V2QTIwL2dXd0EwWVNBeTJy?=
 =?iso-2022-jp?B?ZUtYcUJEa1JXaVB0dlNuTjBqVDBrN05RejNMT2c2cVVnVW5Bekc1TmF3?=
 =?iso-2022-jp?B?bnd5TWxIYmhOOFh6YkhQUC9FYnpzcHpMS2hjam9tNmxUSVV3RU8zNk9u?=
 =?iso-2022-jp?B?eXNIRlFBbTNvSHRpT2pjemNTbGZHV3hUWERhUjRtdW9uU3JHRzZxaVU2?=
 =?iso-2022-jp?B?ZXlZbW5TU1grWFEvMXNacEFQMFBOREFSbzdWd2k0eDdLQUg3OEg5OXRW?=
 =?iso-2022-jp?B?SVA3NEJBV25XRmk3c3o3TVUwSGRES1RWU0FvMWJjT2xBZTFGeWxpY3Ex?=
 =?iso-2022-jp?B?a1BnaG5MMjdTc2VhNk4vMCtZaGtlZVV5cFFDaFFRYnBuUHpGU2I1a0dU?=
 =?iso-2022-jp?B?d001VmtxZ2tWS2JTSXdmRnlRNzFvSG0rNXZ2UGRwR2dtcU0wU3F4SlZi?=
 =?iso-2022-jp?B?VDIweGNoNmpRa0loMDcxTlpLTGJZMWhQZFl6QjlvYW9jWlFLY29xRm44?=
 =?iso-2022-jp?B?KzZuVlVlaWR2NEo5Y0xlVndhcS85OUxHaENicTRuVVBtOFUrMC93YjQv?=
 =?iso-2022-jp?B?SCt4SjJYRzlPam5TOTZCVmRIWnh2WkJHcm9sV2ZKMEpLaXJDbVZoOUVw?=
 =?iso-2022-jp?B?WTBWNytWMzVkVW1aVlJ4YmhxOFRndUZHd1haY3IwV05JNkVsb3ZXZldh?=
 =?iso-2022-jp?B?N2wxQ2dzMzdUQkd2eUlvUEpCZC8vQUppLzkyd2tBLy9SWmhEUitFOTMy?=
 =?iso-2022-jp?B?ZUYvV1RoV2FIMjNVdzhodVdtWnRQOGhPVjdoa0tUNFdwRDBNUzVOOTRD?=
 =?iso-2022-jp?B?dnBFbHo2czE0OWdpYjBvRUVoOXp3VzU3dDNaNXFnODFhbmRLNlJycGlx?=
 =?iso-2022-jp?B?aFFla2VPNHFvQnEwSEhvdUNkcC91NitWR3ZsdXRWbVNFQ1Q1TlJRbkVB?=
 =?iso-2022-jp?B?YjZ2U0lnZzBLKzRrTGN5Z3VMM2c1R0VVUUJtZDA5WHNLOER4OG5Sc0pp?=
 =?iso-2022-jp?B?K1NsaWordGhrS0VxdGtaMmdUcXhueXZCSmZWVDZNd2VqakxqQnVVQlNt?=
 =?iso-2022-jp?B?WWF2ank2ckpORGcxR0trTjdhSnhZT0M2ZVN5RXdwSGpvNlVRWElsNWp6?=
 =?iso-2022-jp?B?UTlzM05wSEZscitObUo4c3dYTzJpeUdiYTlTRWJOaU9mREx6Uk9rVzFa?=
 =?iso-2022-jp?B?NG0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?ZGV1T3lSUmdTVFJYQ3FFTWkrblBsRW1ZM3gyRnNaRXQ4c1oya3FYN2ND?=
 =?iso-2022-jp?B?SDNXd0xFZjZSK0hDMXZDQktjSFBuYzZvZ2RMM1hlNHpNVk0zZkJTVXRE?=
 =?iso-2022-jp?B?b3p5bnk4ZDRpMkpyT3A2S1R5bU9ONnhYcFE4Q1ExdnM3SmF3NUl5a3RD?=
 =?iso-2022-jp?B?elhaL1REazVjOWxuSGFuanNTeGZOTWxjaGtrZ2lXQys3UTdQZThWNmk2?=
 =?iso-2022-jp?B?N1RMeThXMXdvUVZvQTFOUk91QTlxY0NjMisyaDJCTnlGRDBBb01TUTNH?=
 =?iso-2022-jp?B?Mi94QlpuclJ6bGRWSFBqUWtES1BUYXNtRncxZDZRQ3lZaDdyckRaV0di?=
 =?iso-2022-jp?B?WHRRVEQ4ZXVxRlhwSTJxWHZCUHZBNW04cE80OUhzbythektKQjcxVjYy?=
 =?iso-2022-jp?B?c0hFUUtiTFR6NVdqd1hBbHRDc0dFL1p6UlBTNU0vUVhzbXpBYWJiYTdO?=
 =?iso-2022-jp?B?Y0Fia0VaUXdCL3FOSmJIOXE2UXVWcWtwSnZhTG0yNmNWVGlubXBtL3dy?=
 =?iso-2022-jp?B?RmJiMkhjazRxc3ZGdjVoeUpSblc0Nm1tTnhUaGx2a0d4VktpbUV4b01k?=
 =?iso-2022-jp?B?U1N6YUVOeDhmSEpoSWQ5UWN1QXdoYXVoZW11a293NlVrd1VweUl5QWhD?=
 =?iso-2022-jp?B?emdHSlo4azRjZGxpQ2FON0d2cEhKVEVjSUtyY3R2S0dMWTVjamVxcGxh?=
 =?iso-2022-jp?B?YTh3QVNYT2oxbHB5alZFSEwvaG5BQk0xRjAzQ1JlNHdEbFhScktHMlds?=
 =?iso-2022-jp?B?K25ZUHFDWlBTeVVyMG5aSktzY2VPdjlLZWtLb0U0OEpmVCtRUERFT2Y3?=
 =?iso-2022-jp?B?UUowMFZKcWZXUk01eXhCRFV2OURjeEVmRTJ2Qmxxb1lnSzdtMTZpTXcr?=
 =?iso-2022-jp?B?Tzd1alJZL2ZhTGYzbmhHd2RCTThiTzZxeDJGNFdWQThvZVVTR21Ca2g3?=
 =?iso-2022-jp?B?YmxlMkxMMmNKc1hTYWRESEZZbVlxRlJ6SDZmOHJoS3VrSWx6L2VkWkEy?=
 =?iso-2022-jp?B?SjVGWnBEN1o5bWxZQlU3VXlRRVRBRmNMTTJNbTZhTFJ0K3Z1bHdXMWth?=
 =?iso-2022-jp?B?SEJ3YWVrVG9uVXBXVnJpMzZ3TWo2Rk8rOFh2dC9IdlRodHgvMlVRNkhH?=
 =?iso-2022-jp?B?bURzaE9kVTdDdFJnNm0rVHFlak1iYlFmSjYvam9PWFRaNHljQXJNQ2RD?=
 =?iso-2022-jp?B?NHF4aEpGVGFDODIxOTZBazlhR3huMnoyQmxnaVArQmlHeFdoVkJZaXI5?=
 =?iso-2022-jp?B?WkhXV3pqQWRBeWhrS0pUOGl4c0pIa1AzM0ZSdWdXUnN4NHlwL1VDNkpR?=
 =?iso-2022-jp?B?ZVVIYnB6Q3d4KzAwcHNiRVZuVEh0cDJwQ0RoWTdTdnEvN2h6VGIyN1Ez?=
 =?iso-2022-jp?B?b1ZBdlVTSEtCY3U0bDRJa29aYzM0Y2FQb2x6bDMwYStoWTlxZysxenFJ?=
 =?iso-2022-jp?B?T1hTajZSZE1WRVlMMEcyb25ZRVlHcVpBcDlIQWhlcGNYWjVGSldIdVdZ?=
 =?iso-2022-jp?B?bVMwdXFFbjh5dzRJSVBUNlVpb28vbWl0N0RYbzJkeDlvZmhldlFPQnNj?=
 =?iso-2022-jp?B?K0xFaDlZZlZlbFVWdCtvQUdyb0dXM1VEK3ZNcno4c2VEL2lKVHFadHRJ?=
 =?iso-2022-jp?B?bGtaQ1puN3dvY3p2Umg3cmErUWkyeTZURjBaREt3d1NyYUpIRlI1ejkx?=
 =?iso-2022-jp?B?a0xZVTRKejRKcWorMmswdlg3ajBYQng4TnZvNExHZTJneFFQYUsvT3Fa?=
 =?iso-2022-jp?B?Q2FQamJPTWZGU2x3RnZlMXVpM0VEK0V1OHgzeGFxRDBMMVhYSTk2a0Jr?=
 =?iso-2022-jp?B?cXR6bjJJK3gvdFFZckd6UGhzWUt3SW5tdlExTXVUZHRhc2lOUjViUDlk?=
 =?iso-2022-jp?B?SCtFUFE1eTNaMVZ1Q3BtY1F0ZnUzczBRZitNQWhiM2grVzdwNk9LZHNr?=
 =?iso-2022-jp?B?RittTU82NlEvcGdVZmVZR2VHbTJ3eFY3c2R2TXM4bXZ1T2xsRHhqUWln?=
 =?iso-2022-jp?B?NFhwcDdwdkFKWno1d1lLcVk5RUNQdDRuTFZ1b095ZGd6RjJPOGtjQlFY?=
 =?iso-2022-jp?B?eUJPcEs2TGF6MXFoN29JTnYva0ErTjluWGRXY0RnVHIwbC85SVNQN2hj?=
 =?iso-2022-jp?B?clpZSTZCcGpCajJSREpUcDcwMlpYWTYwT0trZ1dKYk9GdHVucW9JUk5i?=
 =?iso-2022-jp?B?cS9SU2VueHhwRFc2RVUvektxc0lHcDhra2dEZVdrQWttOTdKT0w2YWZ1?=
 =?iso-2022-jp?B?OUNDREhkTXFLaFMzNHJVb1Z5NkM2VU1SRStZNHE0bUdmcXhaQkpmaFJJ?=
 =?iso-2022-jp?B?aWEzUmx0b285aTFZVHFwbWVyOHhJdEU4cnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TGXIlBwFUgfPLZ/4/i6kpTzhRByXPExDoPe/OXd0pNppx9hOyFv5Z1rhWrxKw48cOpLBZwShyaK3cUf67Cxh3ccTMKX23xLaIJoSwl6d+jmifSfLpYq6RWNaYTj9/rvMkIxGLjpEJqpldH9zFrComSUilE4zFmXR/eOONyqpnmRQMhCnanyHpC6YcGgeMCEnJJLX1elLRh7mPenLhAEQzI4anpJ3YfxPVywYD5NQuIMcQiKkxOzFVqTaTolJLg++nEAzxP83n2MaW8eiGe+6x6Xz/Hyn2z/fZ9ivuwf61PjyEg2jlO5SEMhqTHnVjU3JOBbYeEAtvQBJNeuj/h+Ic/HtuD+A77BaZiHQkaLb+EP4KcoQPi1L7StlwgOxPaj6NGalXbsjDUen7DNQKiFAkoLiGxwSKMDnkt1uMs691pI7uMi8UCkNdmP5C1+7J5C9AW6OZwcU0o9WfTygMEt8xMgK1LCex7Rl7cRKkrdBtbaSCMvzhTpLVIVcWuTE4GvWxA6ULNMpzVPSwappDuNjpulSsSMRMqGq4jCe4j3a2AFE7SxAZR0FNN7nrx8iE3dzkkMOM2rzQ+1tDhfv0/Wf0rM8wX9YJKSbdWRiPJV49nCtlXyWq4k/XBEsiSpRcxSb
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db06a2b-c9c7-47d9-f026-08dd15c602d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 07:17:15.1618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ubm8PLAuEN9uvxJVI2/GzlwBck0TTNnIKoeHm29NWde+F9RUzYNyj4dGuhvnSzVolhb17YlxauUpFiR2IPlGrBdwca15m2dz/4yr1mXzixo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB12000

Hello James,

I have no other opinions with this series.
And I ran resctrl selftest on Intel(R) Xeon(R) Gold 6254 CPU, there is no p=
roblem.

Best regards,
Shaopeng TAN

