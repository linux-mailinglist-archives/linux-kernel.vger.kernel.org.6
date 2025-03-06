Return-Path: <linux-kernel+bounces-548845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAC2A549EC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9759D7A631E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FFF1F3FF8;
	Thu,  6 Mar 2025 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="K7DGuYRv"
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38177209668
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261710; cv=fail; b=hvb70oSF3k74Ywjql+aAtD+4LU7RAvkHT0SBos3jm26WF3inIxzvTOoMXBaHCxuAQCGhS7XYYU2R3+PxuQ0FVFITJtB8NOf6RsIiJ7ZUn1tC54/GumE3/vveZCVIs+ZqbDxoif7h2iGedvtHIBHV89VAR5EoBYuPjHjbULl5Amo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261710; c=relaxed/simple;
	bh=5OsdH821KH92rBEpbbEglmUHos7tUzLS15Ig3/cBR/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O1uwKSmg5V2aZDhIAE6oY8e+6HeIKqa//N++pe3L3c0x6lVSr7DCQYngOa4I3oS/zVIvQei5/AmkChlGyfEX0zzH/nKi6Xj8FUgznOoMFgXjFvtM52YEWzUaGIe/sgA5nyfPlQiB890qocBc5DxN3VzSEFJ2M0VfB70xUIfeAlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=K7DGuYRv; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1741261708; x=1772797708;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5OsdH821KH92rBEpbbEglmUHos7tUzLS15Ig3/cBR/k=;
  b=K7DGuYRvviTeluUTcemdh5QQ5DyR1kU52H6cJHAVCv7HyGBUZ5TVxl2V
   MT6ByhfWv5RGNvmngh8Oq3dcDeoay3gYelFHM3wDgXy9cMR/YHkLj4KOx
   3Lyou8y88OKVOB5aA4FHKyGSKHCH2eTz/O7PP2hGa9nI1ErrwQGNaOJDl
   iN9XBsUHKbirL8YLjDyaj8Qk0OJ4w6v54MzLX/Hbd9/Lda5/Ek/SOeCRO
   GNjBd2FSAkwKsq8nl/tqKnRgMZd95znELqiOHGWvuaiNBTz1pRv8TnLU8
   LeDWjKXjDcnVRlEspCdm4QFsDEp0KJJgWP/zFwvzS4NbkfkxJW/h9E3+u
   g==;
X-CSE-ConnectionGUID: NvesCKcZS52AZp41YkqKtQ==
X-CSE-MsgGUID: +fsOmMGKT6KNQIyeR/ZZhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="149039968"
X-IronPort-AV: E=Sophos;i="6.14,226,1736780400"; 
   d="scan'208";a="149039968"
Received: from mail-japanwestazlp17011026.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.26])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 20:47:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izKBH7glADF6pxbwSpI8wVbG13a9QsFMHMz5x0W+oH6WlWjP+iPCn98+RZFi6w48f5XwZEyX+ROysa6pEh80BhlQWtMIvjBTeoDzftX/sbuvyJIIQM/lqwzMHEhz0ZMKbcaTdxqai9n3H4J0mLflpWLeqJKU3JSAVpGxftfBi9hI91mAJpcXX6hPFU51E2Zs1GJ4JWSvtCn4lFkzFGo0ALaUNeP/14J/j907DxNhhiVcPh+8lEE4EkMYuXTChFONHQ4xOPRGmYs7t6UcRkfJUokIwRCNbjWIuJkOWsZ+hY9b1DvtZFYuhB+M5wzzN30UIwlz36xG/gjcil2WVoAFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OsdH821KH92rBEpbbEglmUHos7tUzLS15Ig3/cBR/k=;
 b=Lam5OOxOYAK9zMz9lm3Gtbs1wO34W6keTnnkKP89F9546kqD5JNKK3Dw8QxRtXYtq65I+DiEbuiCSkCKS0sIHIBPIPwmu6Ttv2Ju2i7Vty0KH6A6jQ9rtpR+kID7JuDdHs0CAaOAwMQ+7rrJ97DApFKRHHBbJVlHSTwiedL9pYyOZXGdyPl/lVfln+n10yRd3+ap4LKpTJPDZcNlFeS8xx3tMSLcTW5wJkRMCvy9zJt2Ksp3dvTcmADrSW0LOMKQdnDsIlBp2ituxprQXw0q8fTxkK6duS/pH14kjBlxGv0oa8voVNv+Enlmh4OtgY7J6hO4GmSboRzdfl9Hlf5VTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8804.jpnprd01.prod.outlook.com (2603:1096:400:18d::10)
 by TY7PR01MB14390.jpnprd01.prod.outlook.com (2603:1096:405:244::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 11:47:07 +0000
Received: from TYCPR01MB8804.jpnprd01.prod.outlook.com
 ([fe80::b2f6:161a:adee:a32c]) by TYCPR01MB8804.jpnprd01.prod.outlook.com
 ([fe80::b2f6:161a:adee:a32c%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 11:47:06 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Reinette Chatre <reinette.chatre@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>
Subject: RE: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
Thread-Topic: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Thread-Index: AQHbihtJwyDutGBCmkqrG8FIsK+EeLNmBgDg
Date: Thu, 6 Mar 2025 11:47:06 +0000
Message-ID:
 <TYCPR01MB8804B2389B9B553928A3F3658BCA2@TYCPR01MB8804.jpnprd01.prod.outlook.com>
References: <20250228195913.24895-1-james.morse@arm.com>
In-Reply-To: <20250228195913.24895-1-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=f0af0fb7-4afa-4ea6-9527-96bae352a3aa;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-03-06T11:44:24Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8804:EE_|TY7PR01MB14390:EE_
x-ms-office365-filtering-correlation-id: 88680624-93e2-43b1-452d-08dd5ca49eb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?OGJObjhNRXdRYTZORVFFTUlKZXFKc0MvcUxzdGIwQ0xEcHBSbHg2VFds?=
 =?iso-2022-jp?B?aWN6TDNIRjNPanpudXQ0TnNJUk1Da3M0S0JnUDB4MFBmVGh4eU5xQXlr?=
 =?iso-2022-jp?B?VE0rbXltblRSQnRlUDdhTU9QMWNWcHlIcXZkYytJS0lxZy9FZ2ZYRUow?=
 =?iso-2022-jp?B?amNINHFlVURNSmZvekgrZlpMOHdQQTVPcy9YTFFZL005eFZrdDRNS3ly?=
 =?iso-2022-jp?B?RTNrOG1QQnpEMVM1VkQyaElkNkI4L2R5ZHQvZmZjdW1lZjhjaVNEK1Fz?=
 =?iso-2022-jp?B?UGowZmE2LzJCcW1aUnVNMU02ZCtaUkdYdFJnYi80aHJSVWJnMHh0UklQ?=
 =?iso-2022-jp?B?OUxFTHJhZlZHNzU5NUVNcW1Cb3pJZnNjNzRDSkZzRkwzd1U1ei9NMXha?=
 =?iso-2022-jp?B?TEpGc3FDOVFxNFk5MGN6Rm9LZmpSRUlKTTBxVHluOFRvYWdTc1FBMHV2?=
 =?iso-2022-jp?B?YWlrTVdRTm1qVHlVckIwRXJnM3BmUGU4bmZtK2ZzTDFyeit1bmx2aEc0?=
 =?iso-2022-jp?B?blFSUVpZTzhNM2trMWJLQU93V2VvaVhoK29YS0ZKbVFseDYyQUd2R04z?=
 =?iso-2022-jp?B?REFreHY4YlZqOGNtWmNIUVpUU0FUSWFEcmdrRXpxWnQxbXU3QmpCaVdQ?=
 =?iso-2022-jp?B?K3JUWG1wbkVVNlZaWmtaS3JUOXlKekpuVkNTakxuYjQ0S3ZqU0h5djFa?=
 =?iso-2022-jp?B?RDRJVEhLdHBtQUI0ZWlocldCSE5Ga1FwdE50YmhWNzByWnhnWUtRVk9z?=
 =?iso-2022-jp?B?eGVNbURtMC9IcHJUQlB1NEMxeVQrcG9aWmd1QnRpeEdPQjQwSXBRUkFi?=
 =?iso-2022-jp?B?VzJHUEVKSjRSSlVETDJHclFRV2ZkU0d3amh3YjZ6U3EvRmdROXhVYVh3?=
 =?iso-2022-jp?B?S1RkL3pnS0FPOVhhQXZiTlgzTzkzaFBhM0pKc2VsVE5qQ0xHS1MrU3FL?=
 =?iso-2022-jp?B?dmp3bnRBcFg0eXZtcjFQMklzYUZQdFY2ZWUxdUllWU80S0k3N3ZmYk9k?=
 =?iso-2022-jp?B?bnl0VFhzWkNPMGo4RU5GeDRsQ1EzRlp6YWVPb0NuelZkMXdkRk40Njd3?=
 =?iso-2022-jp?B?SHh4U2V1UXVQQzNVNXI2ckRRMUhNRHdVLzlaUTFtc3UyUC8zMm5Sa1Ex?=
 =?iso-2022-jp?B?UTZnWEt5czZIQzdyVHlSdEdxL24wNWpkRjRDU3hhTzFDMHZFSTNxREtT?=
 =?iso-2022-jp?B?WEZ2ZWFjaWVmb1ozVThLS29vTDNaOHAzT0JkazVkMnNjUE42UDA5Zkti?=
 =?iso-2022-jp?B?ZjlwTkdyNGppU09EU3FKemNKMVM2Vkh4clYzeEFOaHMwV2MzSWlWMlZx?=
 =?iso-2022-jp?B?YmhQL1I0YmtMWWNsbmdRY1Bjc3RWSFVWaTZqNVFQSlh2OFBVdlhNbHBL?=
 =?iso-2022-jp?B?Q2FWU3IwY1A0cDZHNjFqRzlHWWZUZXl4c3BzS2RwU2pTSzdUK0wxWXg4?=
 =?iso-2022-jp?B?bUI3bkVEZzFGVC96NWRSTU5CbHg2VHFicmpFVngyQkV5Tm5qRllScVNo?=
 =?iso-2022-jp?B?dFpSRjNYYmRuNzlXTEEvMnVENkpyb3pQN1k2WVZONXB4QzVNTW5abEJH?=
 =?iso-2022-jp?B?ei90QTMwM0IreTIvRE1WWWpRZlM1YmxIMzNES3BCemVkdDExNVNxRzcz?=
 =?iso-2022-jp?B?ZVVSeGFBS1JmSXRmcXhqd3ZoQlYrU2F0VEJ0eW5DMTdxelFUby9lSGpo?=
 =?iso-2022-jp?B?bENoZ29wNHdiV1k5bzJRTUorZWJ4ZVV2STNVMVh6ejNlMVRNdE1YSVR3?=
 =?iso-2022-jp?B?Yy9FclVkenFndFlqQlNoSzVDR0gvRThJNGVoNGVyM2R5emhhMGxNMTM1?=
 =?iso-2022-jp?B?dFN3cDV2SCtxclRvdGdkZUNEMmNNOHZQSFN1UExYQlhKdVZVbnNZNTM0?=
 =?iso-2022-jp?B?MUtPOGkrSUZOcnlVRzZwbjlZMURoMHNTcnFjQWcrMHRqZGF1T0x3TWx0?=
 =?iso-2022-jp?B?UEVDMVFncnprRFJIbFRmNkxtY3h4bm1sc1B5cDNUTHl4azNHWUI0OWNm?=
 =?iso-2022-jp?B?QWQ2S0lHdlArSFU4Yy85K2hGQnB2VE5zNUxURzF2TjhYWGJ4eUloSUVV?=
 =?iso-2022-jp?B?QTdhWVVQVUliWm01ZnRqK21kcDVHWHJKWCtDUjhwblF3NmZBNUNCQlpi?=
 =?iso-2022-jp?B?Z1IwaUJXdmdVVlRjZVJ1MXc5U3B2MjZnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8804.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?VkVjaFpNWks1RVN1SVAxanRwMmJCbFVrbkVWMzQ3S3Z2WVVOcDRJTUFL?=
 =?iso-2022-jp?B?c0gwSnRoRkVjWE9uSDhGVmZGRkZYMEF2b3hINjJYYjNDNDh0d0JicTEw?=
 =?iso-2022-jp?B?VzZOSlNETFlUc1kyRkdjRE9iTnN6djc4RU4wODUrZVlmVnZmM0VxbEty?=
 =?iso-2022-jp?B?U1d6OCtVMHBWVU0raTlSZFlDS0VIZWJsc3cyN2NNeXpsY3dlWWpyQ2tw?=
 =?iso-2022-jp?B?SHhmU2xaWkpIUWpnL0QyTmFGVnVPRUpiRVB3QktBYVFLZHpRN1kyMUlY?=
 =?iso-2022-jp?B?RXpWWE9GWUpZUDR4NzQwRlpiMjRDSTBaZ3I3ZlQ5YVhZcEQ5a0txVzE2?=
 =?iso-2022-jp?B?dEtuTjRVYXJ0cmg5QmtkR3ptelhyTDhhbWpSejlSUlBxN25BTmIzKzFD?=
 =?iso-2022-jp?B?cDY0WHpaZEphZFJKZUpxR0FyelB5QndMcGxUVXJQRWZ0WU1zZnR4bTZ4?=
 =?iso-2022-jp?B?bGQxV2xuTUVKcDVUd2U3SitZczYzMk1ob3M4U3FuSHExQm5EeUt4WW9B?=
 =?iso-2022-jp?B?bEQ3RTdqWUxabzc3RWM0ZmFqck9wdE5rNGpiRE42N0crZGUxZksyRTVU?=
 =?iso-2022-jp?B?NG8vMnUzZHNORjZ5TlZtUlk3R0wycGFEamsvT2ErMUhJaStSN0F1V1M0?=
 =?iso-2022-jp?B?bk44QWVvVGQzd2I1QkhuYXVXSmYrSTlNRkdjVVZtcXoraFRFUmNkTnNB?=
 =?iso-2022-jp?B?QWhiTC9od1RRMUdhcWozbmtRdUNjZjk1a0Q4QVBTMjRRZk1xMHQ3OC9s?=
 =?iso-2022-jp?B?Zm5jWGpTdnVYYTEvNndZR0MwaTNtRytrbnJuRmRNVEtUeWd6eTR5NXVo?=
 =?iso-2022-jp?B?UDhGcHF3QktmM3VrSTZJMDRYcUpKSE8wRWszSFJUT0dFMzRlMUtJTUpy?=
 =?iso-2022-jp?B?OWN4aDNRZnV4Y21NNCtQZTFseDR4QlJqQWdQZ0RVZ3BsMDZDM1JYZDBS?=
 =?iso-2022-jp?B?MG8zcXc5aG9TVjZTWE4yckVCbmgwZDlaRW1WRGd1T3lUamQ0eUVyS1da?=
 =?iso-2022-jp?B?Y0VWenRyNkNyU3U0UkxjcHVnU083V3kySUIxRjY5ZUhtbDNmWFBmNjI1?=
 =?iso-2022-jp?B?UjM2M3V3WkROblpHWGxiYkJFK3RyeGFVUjQyVURoS3RrNHZWQnQ5a3RV?=
 =?iso-2022-jp?B?cG9ReGNRS1BibnpSR2REdFJqdjc1ZDl6bFJJeFNJQ1FGL1BsWW9rcnlM?=
 =?iso-2022-jp?B?NzBsYjFMc293Y1NEOHFGM01mWWdWZWVPbHdIRG14RDJQYlVSQVpLYzgz?=
 =?iso-2022-jp?B?TXpmVVFLM2NPZlZjclBIVWxVTWYxakNSODk3M2s0MEpKUTVUUzBSNmNz?=
 =?iso-2022-jp?B?N3J6SEFBNm9MdGloQlEvaFB6NkNJNGo4elUwVmN3eis5TTlDVW12YUg5?=
 =?iso-2022-jp?B?N1FqWVAyZzh1emN1K0p6NjNZYlVhNmJ5Y2w4ekZHVHA2VVI5NGtOM3ow?=
 =?iso-2022-jp?B?NU5HQTBlV0FYMnVmTnRUUHl0Y3hKeXlJbG84bmpnd3Fzc2R5ZXorNkd6?=
 =?iso-2022-jp?B?QVFLc3ZGQnk3T3JId2JjRDVzdW9zZWJzMUhrNm1IRFRaTTQ1bUdTRWVK?=
 =?iso-2022-jp?B?bWxneG96UytVc1Q3UWE1V2xTTXV6YTE0ZFhpQWtzTWVUTjZ6eUh6VUdx?=
 =?iso-2022-jp?B?Z0JMclErSUs1emxrSm1HTmhwWXhuVjFyZDExS3RiRytuSy9XNHM5OGJn?=
 =?iso-2022-jp?B?cHYxUUJHYUJHczVsK24yS3VQcDd1c2h2dDVMMWZjMmdHNS9wWEMyOXlu?=
 =?iso-2022-jp?B?cFRTVUpUTi9aZ0hLeFpFemFyU3dwQVROMkoyQzdkaW82YTFrSlZBQVQ0?=
 =?iso-2022-jp?B?azR4dHkxZ3BlY2grbDZrdGRRZ3Y4NDhIbjdMNzBST0FiTGJFeUtURVVX?=
 =?iso-2022-jp?B?VUhYSVlHMnFEVWc3MCtjNjlITUN6SXQ2Q1l5c2tMejV0ejFhU201UjFF?=
 =?iso-2022-jp?B?K3lIUEwrSFNjTzYvVW8yT1F0LzU0U0pmUmJuYk1zNFR0NGQ3b2dldUxP?=
 =?iso-2022-jp?B?QUIrdUNkQ0Z6L1YrZkNQWGNMc2pFVHpkb2p1bEpqd3FhMVd0elRER2Va?=
 =?iso-2022-jp?B?RjF2TXgyajF4Ym5ibjhiM25VbG1YeGQ0UFpVbHQ5dEJLbjI5ZmR2OUNS?=
 =?iso-2022-jp?B?aGFFbWRNUENDZ0FkWkdRUTQ3RGRjenFkMHlGd2xSbHIzWkgzZ1N1RWcy?=
 =?iso-2022-jp?B?VlhGbkR5ckx0OFl6dlFlTG5PMm02MUkySWxlNExZbktRN2VxSjRicS9a?=
 =?iso-2022-jp?B?YlBlUk94VnFwUy9UUHVZYXhoWHo1MkRRVUZrTUp1RkttVEJLK1EyOGMz?=
 =?iso-2022-jp?B?Y1U0R25VZUlsT1hFalJuOExqSjdneCtVS1E9PQ==?=
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
	5RaMRbUq9ybAcK6WNGfaiTMJ37Ey/PGlR0dwYGHo3rCVEQU9yq70XTjr2T3CeOC7lr/6SO3hLXlvgCCQo09Y6LFZS/ClTFxW8tSAuC9OX/mht0mpsQRB7A9VGaU3BHnK8y0RJ1Bx20itEcYtYBzlJPu91GuDJzsN+GGsbR/U17rruZAjzHKALG9TKHOB+P8dkwGbR7oUFDbmBRAnFgTvNO2z3YCX6JvZEYVuiQn1CC6spkdIl7IRiML8KZh74dGc6/w+Ou3CsjWDLDSW3jGusTUSEZSwwVAfVy6Mb9LhlxdJf3cMecU95b5R3bUI6HP7nGEgUMjY4mo0Q7jsgKb3GmdabBZdTDwGIVa414FoLJYtVsq29ZuJKhdyopIC8/OupXG52CyHiiP+lwtkQEhmkWketRkzCCc8Lc0v+x8UgxaTMTQIkiK93ZQTN1wBUPF2cUZonwRlBEhrrfvDTfHNWN0IjhGJPuVFrmLrAy/VSW+iFB5Rcbz4kljDxrNuye1Qvko0AostPLFjafjtleW1a6pXnvrZZ4YV1I9AFtrdb/J+NYHuIGihSAKJmqWDrYuKZEgXlWiqDvkEQn7zYilgINUM74i/5lXSmQBLmME6hUgwnXRxNUpv9sJFIpXSvv6Z
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8804.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88680624-93e2-43b1-452d-08dd5ca49eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 11:47:06.3307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Xvf3LWE87vHGHpvhURzF+dez6ctEgfQi4QfaSNzP4lfdM5xH72XaiVZo4jSzWjjCAVjA+dlAaIz64VO6Ayv7htmerjFtGcRqvBEbqmHL8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14390

Hello James

I ran tools/tests/selftests/resctrl on Intel(R) Xeon(R) Gold 6338T CPU @ 2.=
10GHz, there is no problem.

Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Best regards,
Shaopeng TAN


