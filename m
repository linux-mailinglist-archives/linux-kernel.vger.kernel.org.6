Return-Path: <linux-kernel+bounces-409684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E04A9C9088
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A124B2D203
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823B717D366;
	Thu, 14 Nov 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WDmy+GCd"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86A740849
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602747; cv=fail; b=dhcAYBBwQXstRP9eUjngi8rfkRptlmGI/lhJ0zDBjdjjDxB9z9LlQnReTTWpog10cMQdH/AM4aVsBF+yU2DBZWA5hxdrq4ZT014wgbnUPpNashNP9A+NaAbcWIOVUaKgiVhKMqb1yBg5D+nBJWJXORzrOU320nhIT5kNFU2Ii/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602747; c=relaxed/simple;
	bh=3SiBCeQRv2e/ODTFRjt2tzZyX/B2qFK32DNvxRcpJgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bz9GQFqxAKtggSS6kNtZaIFFQlOl+xRuLcqG1ODe0NnQylJTO99zXrFMK3j+4kwtP0hLdgefOKL9AI/FZYF/YuAWu5gQ6Q2nHVBVLl85n2MzTlhSN9Vu/OsSKuwbChVro5uchFx832oEcUr+r3+fseCqrtOoAHSPhuzyMDdxELY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WDmy+GCd; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSxtycqQ7FMAv5y0zBXNrjZ+pco0rB2K+TywsY/PHuZzpE8m4Vt0gJ0ysGXJJ8vy9pjsgXdHIu3cXehynMqSkgCMQNygIwTr7KWUL1x9Ynl6gz96+VQJUpfU8Y6jfW1EpZ/MVWGW6nr8a2uHijmyAKKEid3woMMAYvZT9IgDU39wCuNTgL/GaunQl8uUWNJUuDVhoYqcbWkyVk4gDLvYhrfrGPnc3mRCIVHLG6nLYT4dR19nrOyqqUFJoyT+G5o8hKZ+Htc6iXPDI7icfZsUbwdeWhX8YDdWphcgsm5JvU8lNhP0P4hAMMh/qdFUrC7xcGp4QNBHypyUjPuDcChCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SiBCeQRv2e/ODTFRjt2tzZyX/B2qFK32DNvxRcpJgI=;
 b=by4zKj07n9uHb4YBVBG84SdXci/9zb/9dsLmO9Xs9B9JyTRWuffUFBmVwfqQ5Z0bAG1bHUl5lAuiXWPOAGXg9YyH1iyLNC9lG4QvcAwc4G0uGI6b1QO+7MHQ9IkS7SXUmgV5zX2r00MPCJLvpJtHVpOe7mwRvqoB94/9w9SlOXwvZORYY4+lP8gBwULoOirH5+5M9qUZqt/hJtzu2yOw0jwylDeBe8/dJZrVqx7kAZmtbNjd04LZIMhAPggzEQufn6pdpSxPm0CZIb6d3Z1XQWF50F3jJcKPF9TnmYhSN+SuNznkc17rdIqf8LFsBx+iRX2fbP9CVNltxYHEejGbfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SiBCeQRv2e/ODTFRjt2tzZyX/B2qFK32DNvxRcpJgI=;
 b=WDmy+GCdS9rWkAeWew/zr7jZ57bl39gWWT5OmJo7Ox6brtmmRRuCYSAfjwa4/lYHJE5HVblvuhmWxnhADvKBQJ6Ap4zAGKcAiNvPpLOD0Mw6wz9KFyNt+vflrIz8AT/wO8k0cJnG12OIM0QTrUZkK/HZiw6aGcP+EXq7hZ9M0To=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by LV3PR12MB9401.namprd12.prod.outlook.com (2603:10b6:408:21c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Thu, 14 Nov
 2024 16:45:37 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%6]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 16:45:37 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
Thread-Topic: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
Thread-Index: AQHbNmJz5HBORjzra0GiYVanrEde3LK26EbwgAADgeCAAAmMAIAAAEnA
Date: Thu, 14 Nov 2024 16:45:37 +0000
Message-ID:
 <LV3PR12MB92653BF71C474E72CB2C81DB945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-12-david.kaplan@amd.com>
 <20241114064001.v6ogsiaptrh6oixc@desk>
 <LV3PR12MB9265747DB95F1F54E826A971945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <LV3PR12MB92654B44C7BDB16BA140D342945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20241114161958.GIZzYjLgooyYCECCl0@fat_crate.local>
In-Reply-To: <20241114161958.GIZzYjLgooyYCECCl0@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d0a0878a-57d1-41b4-9d1c-999061d034da;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-14T16:20:59Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|LV3PR12MB9401:EE_
x-ms-office365-filtering-correlation-id: cb1a4694-f88b-42f6-672a-08dd04cbc469
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWVqUHBuVkt5a0pSSmhmNkRKWEpwQWZMMW50bXBqSi9FdlR2YldFZTE4Mlla?=
 =?utf-8?B?NXByeUF2TVkvaG84N05IeXFlSCtRWG1wNWhxK0ZtM2hram5OUGFZeWt1VFFr?=
 =?utf-8?B?eW9iWnVMclVBUHR2WFp1RFdwb3ZnYzZSbWx3WExrRjNKbE9yenFCUmcvLzBk?=
 =?utf-8?B?VVBaY3hBbHNHRkJaUEtGbDBXS0srRytvcUNOOW5hcm1kdmZMMThheDhXREov?=
 =?utf-8?B?NlZmU0xSSmFmYU84OEFKY01Kek9VcG8zTEtCOGUzVlRqd01GU283U2pkd2hV?=
 =?utf-8?B?SG5Qb2kyNko0eUpsOCtWT0c1VXZhVE02TDg0QkpsR0hUQXFPVVQyMXdQejJ2?=
 =?utf-8?B?Y1VvcVdFQ2tYSGlTdzgySDZEM1JBcnQvZ0ttRlZVSHIvMEYzVHZRdjlKTHhC?=
 =?utf-8?B?bGZ6OVp5QUZKUkVxeTRmUVFSRWc5UkVUOHh5SnhZVVdsSEk3K0ZORHdzVEtF?=
 =?utf-8?B?L2t5L0tGUUh6WVRUMXhJSzljTGdUWGY4THdxRlRnOWwwczZvRHJoZjE4TnBV?=
 =?utf-8?B?RG5PTGdsdWtjZnYzd3pRNGsyTkdqV3UxdGRKOEt5Uk5rYU5EeWJGN2NyUVVr?=
 =?utf-8?B?YXNzWEY1OFBrd2g1dzY4T2RxNjMrcytoYUJLOUQ4WjFJV243WUpHNk1YNXJq?=
 =?utf-8?B?MEhjemlzdjRDNVJiOHdTRTRZbVRDbjJ2Sm93blh0WTdTM29aTVl0aWR0SHND?=
 =?utf-8?B?dXE1RCtsMU1FYksrT29rdlhyZDZyVzlBcGh6U3AzaGlwKzhEOGRBYXU5cDZJ?=
 =?utf-8?B?eXU1V2pHRlFYZXZNQ0wrSXk3SlFTV1FTUEpQWU9mZ3VTQ2lSQ01acytXUGdI?=
 =?utf-8?B?THRYVlY2djNHbXVKRnhRaWFEOGNEeUxiREEzS0dXWUoweS9xY2RNakRxRzRN?=
 =?utf-8?B?UHI0c0Z2UWZkUU9ZSU5CeFdadlNtdjdub01SZ1hJQWRLRGJOK1dYSmxtQjhP?=
 =?utf-8?B?YWxtNnUvenRzcWFudDJ5VVpKUUxnU1dVU3ZnRVBZWjErb1ZxR1kvbnVRaDZM?=
 =?utf-8?B?SWZVNWdmN3FyRzN4UVZSZVl0QXFON3pMVVJEMUZVVmpwcUVFMmtjTG8vNktQ?=
 =?utf-8?B?WnNEK0N0anM3cW95SFlTa1k4N0JIWkFJdzd4MWhZVHYzVlhYb3RXcCtoa3Br?=
 =?utf-8?B?UU91ckNtV3FTVngvU3hzRk5MR0p4SUdCL2xydy9qOXJicjc2OWkxY3FHTXdN?=
 =?utf-8?B?cy9DK3FKb0NFNDFILzJyNHRZYUhnVC9KR0pnR24zcUF5d0dMUWJOM2FmbkRU?=
 =?utf-8?B?UWh3M0ZrQVJuQXJocTF4VlpQcW8vSjJoSkdYVjhwaDlMK2N6UFZ5d2JIM0pC?=
 =?utf-8?B?aExXNW5IWDdYWmNwY3NIamhQeWwrWnU3ZmtoM0o5UE9XWkIwVkhwWVA0ZXRN?=
 =?utf-8?B?dFBYS2IxeEpiRWJ5ZjNmWmlWRFo0RWRJQ0tFT3pWb2YvZ3g0NGVKWkhNK0pi?=
 =?utf-8?B?dHc0eGpYL2pueDNDei9tYnVIZFJoVHhIVUlYcE1vVTlnZENNWWZocWV0YUFS?=
 =?utf-8?B?R3FGOGJFT0ZPZ0RVV0d4c3RnVWs3NXFOYXlQOVh0MEZXV29yRHFIYkRnSzdt?=
 =?utf-8?B?Uy9tcmdKbXdxVnREbWNLcnF5VlAzVWY1T01DRlVQdHFXakhEU3RaOUlQTHNQ?=
 =?utf-8?B?UVZuR2hDUXY3R2R4MHZaZ2NCNFJsM05PRVd1bVhhNXFsTFpRV3hxakw2cDIy?=
 =?utf-8?B?eUlEZ1o4OS9rek5XTkw3dGh3cWFlMXhHVXRnRE5pVzFYUVl2QmptcEEvVitP?=
 =?utf-8?B?d1FvTEZaL1VaVFlUL1QwbTVJRmd1aFpvVEduYkMwZWpjVjlIVTJYUzNzRm5P?=
 =?utf-8?Q?2uZ+ISn5HIhfXuRCgtnwZOPf4vIE4mxNWLNU4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dndwYk5FOXVmc3F6eHhXbTJpcTA2czRjTU84bDkzT280djdHSE1JMDVpV1JH?=
 =?utf-8?B?YWhqMCthOWVGRjk4T21Ca1ptdm1HYkNMVi9PaTlpVVNmU1dxRnFZU3FreStW?=
 =?utf-8?B?VzJ2Nm1DbkhiaTBpbk1OL3AyNkgxbWRacEczRTJHUjlFRkgyMnhxUHZadHpi?=
 =?utf-8?B?Ui9RZHIvWGVoVStCdTJoYmk2eEs4V29zUHBqaXVPdTdmM01DaEc4dTZ1NWlS?=
 =?utf-8?B?V1JRUGhsTTd1ZjBJaVZDM2szL3MySUg0SHlwQ0hNOGNROTQ5RWRqMzRreXFZ?=
 =?utf-8?B?SHVick5MbXlqc1ovQVp1eWtvK3p6aWNsc1dSR2Y5WUViRHZIMytscjhZZnRO?=
 =?utf-8?B?Szg0NWxySGtSTE5ETkgwK1ZZTUV2NVl6QjlKZFMzQVlHZVRRSjZCU3dnaU1L?=
 =?utf-8?B?YzYxU2RDTWhBSWhhMVk1WUM5RFRQT0UwNGU4aUZmbmVRSmJLelBlVk1WaTIv?=
 =?utf-8?B?aUNNOE9DNUR3Y2tDbWJOVmN6WXBOK3FwMVZ6Y053dVo5cUJBSjlraGxUVGVw?=
 =?utf-8?B?RjVtOVE1VEZxVG83ZE9ySW5heDBKclZUZUhSZ05RcFpXMHJXK0RONFFQK1l5?=
 =?utf-8?B?QkhXZWxWc1U2aU1ZQVhQcXovU0F1WVBTMFNEUzBMdTVFVG1paDZxRU1mdTZt?=
 =?utf-8?B?VEl4ZGlzT0ROWEljeEpxLytodUhZbUIwN3UySnNNbGhUdGdneFRTajdubXow?=
 =?utf-8?B?d2JwQkFUZkRJTXk1SkN5SEhXcTI1VmRqVUE4eWxtbm1yWHI0TS81V1c0UE5z?=
 =?utf-8?B?aGhGRmdER2oyV2hINkhlSzgxaWV4d1RBRjJaUGtYa2hRbURnKzVxVitOd2l1?=
 =?utf-8?B?b3pDL1BFenpvNllwWlUyVEVuRkNXZ3N4dTRWVlgyRFR3Q3ZudVRQN00yRE1B?=
 =?utf-8?B?TEFxZ2cySkJIV3AyN2lFazl6SVY2dmF6WWlqNUhUYytibW1hOUNWSlFTNFJP?=
 =?utf-8?B?MjhCZjA4K3I4QlNEVVZlVEU2bXIrVVFpY1JoaUpJeTBhODROWjBiOVpDc0Zu?=
 =?utf-8?B?cHhUMTRLUXdRWmhZQnpXNkd5MFFUT3E5enhiS3dKYjZ6bnJ2M3VEQ1VTUDk2?=
 =?utf-8?B?U3RXZ1Y5SHErQ2RyOGJOd08xandZVFhJdzFNNFBaSGZGWFRWVHRKaVhrdElx?=
 =?utf-8?B?WWcvUlpCS3VjSytxemZBQlYzdG5iQWRSTUVMZTIwTzZnb2JnbUtaVmprRzRw?=
 =?utf-8?B?amxEaHhyNmxYTEJRR3k0NVhIeGMyR1o0N1A5aER0WitZK0ovaThyRkp0cGZ3?=
 =?utf-8?B?ZWkxaXdwOGNkVVdQRE8xMC83b2JCK3Y5N1dzL0NSSTNBYUVzODlYWVc1TzBz?=
 =?utf-8?B?M0V1VXN4M3JMUi9ONXNNRG5jd1A0VDlvc1BwYm5VUVpCVFdraWp6VU1XT3ZE?=
 =?utf-8?B?cURuRFo2NGpTVDN1QXpVU2pFKzNmenhhRGphbzQzOEh3cXBpaWtrWklKL3p6?=
 =?utf-8?B?bkhoT2lJUE5wS3F0K2JuS3g4OGxrMmN0MmtFZ0c5YmlRd0xucHA0dmdYRTQv?=
 =?utf-8?B?VkF4aWF6cVlDSkNXRmtzc3BqdmFXalZtOW5wUTlCZXdFU1RFcDdEdkQyOVM5?=
 =?utf-8?B?dFFjMlg3MTRyaWwvOC9SNk44UzgwOHNkck0zTCtjb1VvaGxuSjJBeVBrMjVT?=
 =?utf-8?B?b0toKzM4dzB0RVFDeDdkQmZLNTNucnR0ampKTEdBYm1DM2dPMVErS21MN3FH?=
 =?utf-8?B?Z2xTWTdHbTUwR1J2S0NvU0IxUGx3b2V4QmtDbUZMcU1vdUF0YXFTMndBTE8v?=
 =?utf-8?B?RjQvaE10bnZKS2RGeFJlQUpQdU9TcXJtdzVzQU5oYWNwUENXdStUZXdIYjR5?=
 =?utf-8?B?azNkbGNmTVYvNjJCY04yWkUrdnFPMHJVbjVmYkpsaHlkSGZuY0pNNnF0dUFS?=
 =?utf-8?B?dlBRa1FWekJ6Y3I4QWJNa2xwR0JseEcydTA5M1NoNVlzM1J3UisrNFlaNEk5?=
 =?utf-8?B?YlFVTEJmMDdnU1UxWEZraFhLVVVZV0FGa0V2UktSVFZkeUQ5UndSWWZOYmox?=
 =?utf-8?B?VVFqZ21VM3l4V3VCK2NodzZIOHdvTXQ1ZkRyWms4NUZoRGU2Sm5MSWRmZ0dw?=
 =?utf-8?B?TURodmtjbWYrU082Ri9yVElZT01KNlQ4Z0hyZk1rSFM2WHdqbjdjMWZhVEpT?=
 =?utf-8?Q?KWHY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1a4694-f88b-42f6-672a-08dd04cbc469
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 16:45:37.5905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0IjfVSl//2n2/CX5Ji5O10EPvmV+9soGKmVtX4vC9CUlkVENp9C6w4yUXkA9A0h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9401

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDE0LCAyMDI0IDEwOjIw
IEFNDQo+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT4NCj4gQ2M6IFBh
d2FuIEd1cHRhIDxwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+OyBUaG9tYXMgR2xl
aXhuZXINCj4gPHRnbHhAbGludXRyb25peC5kZT47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz47IEpvc2ggUG9pbWJvZXVmDQo+IDxqcG9pbWJvZUBrZXJuZWwub3JnPjsgSW5n
byBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBEYXZlIEhhbnNlbg0KPiA8ZGF2ZS5oYW5zZW5A
bGludXguaW50ZWwuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbg0KPiA8aHBh
QHp5dG9yLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MiAxMS8zNV0geDg2L2J1Z3M6IFJlc3RydWN0dXJlIHNwZWN0cmVfdjEgbWl0aWdh
dGlvbg0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVy
bmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50
cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIFRodSwgTm92IDE0
LCAyMDI0IGF0IDAzOjQ5OjQyUE0gKzAwMDAsIEthcGxhbiwgRGF2aWQgd3JvdGU6DQo+ID4gQWN0
dWFsbHkgbG9va3MgbGlrZSB0aGUgZXhpc3RpbmcgY29kZSB3YXNuJ3QgYWx3YXlzIGNvbnNpc3Rl
bnQgaGVyZS4NCj4gPiBGb3Igc3JiZHMsIHNzYiwgYW5kIGdkcywgaXQgd291bGQgc3RpbGwgcHJp
bnQgYSBtZXNzYWdlIGFib3V0IHRoZQ0KPiA+IHN5c3RlbSBiZWluZyB2dWxuZXJhYmxlIGV2ZW4g
aWYgbWl0aWdhdGlvbnM9b2ZmIHdhcyBwYXNzZWQuICBCdXQgZm9yDQo+ID4gdGhlIG90aGVycyBp
dCB3b3VsZCBub3QgcHJpbnQgYSBtZXNzYWdlLiAgSSB0aGluayBJJ20gZ29pbmcgdG8NCj4gPiBz
dXBwcmVzcyB0aGUgbWVzc2FnZSBmb3IgYWxsIGNhc2VzLCBidXQgaWYgcGVvcGxlIGZlZWwgaXQg
c2hvdWxkIGJlIHRoZSBvdGhlciB3YXksDQo+IGxldCBtZSBrbm93Lg0KPg0KPiBZZWFoLCB3ZSBw
cm9iYWJseSBzaG91bGQgZml4IHRoaXMgaW4gYSBwcmUtcGF0Y2guIEkuZS4sIGlmIG1pdGlnYXRp
b25zPW9mZiwgbm90IGlzc3VlIGFueQ0KPiAiVnVsbmVyYWJsZSIgbWVzc2FnZSBiZWNhdXNlIHRo
aXMgaXMgdGhlICJtYXN0ZXIgc3dpdGNoIiwgc28gdG8gc3BlYWsuDQo+DQoNCkkgd291bGQgcHJl
ZmVyIHRvIGZpeCBpdCB3aXRoIHRoZXNlIHJlc3RydWN0dXJpbmcgcGF0Y2hlcyBzaW5jZSB0aGV5
J3JlIG1vdmluZyBhcm91bmQgYSBsb3Qgb2YgdGhlIGNvZGUgaW4gdGhpcyBhcmVhIGFueXdheSBh
bmQgcHV0dGluZyB0aGVzZSBwcmludCBtZXNzYWdlcyBpbiBtb3JlIGNvbnNpc3RlbnQgcGxhY2Vz
LiAgT3RoZXJ3aXNlIEkgaGF2ZSB0byBkbyBpdCB0d2ljZS4uLg0KDQo+IE9yIGRvIHdlIHdhbnQg
dG8gaXNzdWUgYSBidW5jaCBvZiAiVnVsbmVyYWJsZSIgaW4gZG1lc2c/DQo+DQo+IEkgZ3Jhdml0
YXRlIHRvd2FyZHMgZm9ybWVyIGJlY2F1c2UgaWYgdXNlciBzdXBwbGllcyBtaXRpZ2F0aW9ucz1v
ZmYsIHRoZW4gc2hlDQo+IHByb2JhYmx5IGtub3dzIHdoYXQgc2hlJ3MgZG9pbmcuLi4/DQo+DQo+
IEhtbS4NCj4NCg0KUmlnaHQsIHRoZXJlIGFyZSA0IGNhc2VzIEkgdGhpbms6DQoxKSB0aGUgQ1BV
IGlzIG5vdCB2dWxuZXJhYmxlIChpdCBkb2Vzbid0IGhhdmUgdGhlIGJ1ZykNCjIpIHRoZSBDUFUg
aXMgdnVsbmVyYWJsZSBidXQgbWl0aWdhdGlvbnM9b2ZmIHdhcyBwYXNzZWQNCjMpIHRoZSBDUFUg
aXMgdnVsbmVyYWJsZSBidXQgdGhlIGJ1Zy1zcGVjaWZpYyBtaXRpZ2F0aW9uIHdhcyBkaXNhYmxl
ZCAoZS5nLiwgcmV0YmxlZWQ9b2ZmKQ0KNCkgdGhlIENQVSBpcyB2dWxuZXJhYmxlLCBtaXRpZ2F0
aW9ucyB3ZXJlIG5vdCBkaXNhYmxlZCwgYnV0IG5vIG1pdGlnYXRpb24gaXMgYXZhaWxhYmxlIChw
ZXJoYXBzIGl0IHdhc24ndCBjb21waWxlZCBpbikNCg0KV2UgYWJzb2x1dGVseSBzaG91bGQgbm90
IHByaW50IGEgbWVzc2FnZSBpbiBjYXNlICMxLCBiZWNhdXNlIHRoZSBDUFUgaXNuJ3QgdnVsbmVy
YWJsZS4gIEFuZCB3ZSBzaG91bGQgcHJvYmFibHkgYWx3YXlzIHByaW50IGEgbWVzc2FnZSBpbiBj
YXNlIDQgdG8gd2FybiB0aGUgdXNlci4gIFF1ZXN0aW9uIGlzIHJlYWxseSBhYm91dCBjYXNlcyAy
IGFuZCAzLg0KDQpUb2RheSwgc29tZSBidWdzIHByaW50IGEgbWVzc2FnZSBzYXlpbmcgdGhlIENQ
VSBpcyB2dWxuZXJhYmxlIGluIGNhc2UgMiBhbmQgMyAoZS5nLiwgZ2RzKQ0KU29tZSBidWdzIGRv
bid0IHByaW50IGEgbWVzc2FnZSBpbiBjYXNlIDIsIGJ1dCBkbyBpbiBjYXNlIDMgKGUuZy4sIHNw
ZWN0cmVfdjEpDQpTb21lIGRvbid0IHByaW50IGEgbWVzc2FnZSBpbiBjYXNlIDIgb3IgMyAoZS5n
LiwgcmV0YmxlZWQpDQoNCkNhc2UgNCBpcyB0aGluZ3MgbGlrZSB3aGVyZSB5b3UgbmVlZCBTUlNP
IG1pdGlnYXRpb24gYnV0IENPTkZJR19NSVRJR0FUSU9OX1NSU08gd2FzIGRpc2FibGVkLg0KDQpT
byB3aGljaCBkbyB3ZSB3YW50PyAgSXQgd291bGQgYmUgbmljZSB0byBiZSBjb25zaXN0ZW50IGFu
ZCBJIGNhbiBkbyB0aGF0IHdoaWxlIHJld29ya2luZyB0aGVzZSBmdW5jdGlvbnMuDQoNCklmIHdl
J3JlIGdvaW5nIHRvIGFyZ3VlIHRoYXQgY29tbWFuZCBsaW5lIG9wdGlvbnMgbWVhbiB0aGUgdXNl
ciBrbm93cyB3aGF0IHRoZXkncmUgZG9pbmcsIHRoYXQncyBwcm9iYWJseSBhbiBhcmd1bWVudCBm
b3Igc2F5aW5nIGRvIG5vdCBwcmludCBhbnl0aGluZyBpbiBjYXNlcyAyIGFuZCAzIChzaW5jZSBi
b3RoIHJlbGF0ZSB0byBleHBsaWNpdCBjb21tYW5kIGxpbmUgb3B0aW9ucykuICBJJ20gbm90IHN1
cmUgaWYgaXQgcmVhbGx5IG1ha2VzIHNlbnNlIHRvIGRpZmZlcmVudGlhdGUgdGhlc2UgY2FzZXMu
DQoNClRob3VnaHRzPw0KDQotLURhdmlkIEthcGxhbg0K

