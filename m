Return-Path: <linux-kernel+bounces-388725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C869F9B6393
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC1B1F22AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31771EABB5;
	Wed, 30 Oct 2024 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fBxGRPJZ"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2063.outbound.protection.outlook.com [40.107.247.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2C81E907A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293061; cv=fail; b=A/ma4kZDHDh1nzppG8tOnAhBz1BiMjce6EqDA7pf/ywOwjEDAObUt/PwO9nvn3nggxSql9u7nkc8lKW3jdZqIyevuReVPMwOYmc+0QHYwJD8LNBVzIeB8b3cFWVsyuOwgcQGzk3SWztjXGPan8OslJrR2YoC1CAIFnvivN0gUVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293061; c=relaxed/simple;
	bh=QWAFO7fbjN7xzWUn0Sx4mabGaeqYLWcNmDix+94pB7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pZVxSVFrKqozvoC6cIMROBQknUB1l/rV6CQR/22UkXXliG+sJ3O0Ghk8sHIiP5g6JUKdLG7xw1iQ6PdqtIs5pM46yfpH3pMzNSCVGtuwFZ+HCUMVaylqZSYPJfbCO152QgPhxWdYxZntZBwZKGTAlE0q14/39trG6SL7YOpYN34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fBxGRPJZ; arc=fail smtp.client-ip=40.107.247.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRNIlof+wFrNgdMlB6VWAq3TATXT1ipdHZAVZhpz0KwqnKqYOtuXn38Sak7Cdfvzk281GUr32SsdhIFbeKPesMaCBSYaJIAJIzbm9AvsqqePlSYCdpCv2TJS3yO8ZCzy0bSEtTlMmz3HL9CZ+/K7gvgPLOu1PbS62QEbgll/LIKirWJR8FBL+274mVi/Srguf8KbfhHkpqBjFB/y0cNpXTG9kL5ll52rfN/PWSw/JqVHyRToNIX8ySes4W/lhYEKZzwDaYslz10yOCLq9vd/iAPzyr4uZNYlg06AxamN+NzS7GMwVD3lqYFbf9wxfS8tsyryOsSAK7X7Z1z3lxC8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWAFO7fbjN7xzWUn0Sx4mabGaeqYLWcNmDix+94pB7U=;
 b=ZwYIRUCf9BaQiSsWCC/lYNLnp0+oWXYi1ixS1ti4Wy7cEeofCZ8649BA27n44GCz3wvrQ9MuUKZv4dV+GmySemM7vtqGjxBQCZMkM11O6QTC7o0atAA98ndjGCpPKtqkuRmAbnARoLSEswIHqDJhgEvxlsjFWE2gxAPU6lTp20jGoPxhElhXqJgPWcOPNnr7XFrSiefKLlzp/Y/dKHGC6mnZ3ty2L9Z0jWQXAvOxxFQQEMR0ty5HG1QsmLpBdOC6pq0sy7E8lU/uZ5/fJBh1pyxyaaYodoF0+pjZFwajKLx+eBE/WtTPqK+qpQKBHMMJB6nCdFKTKDdx+zzdX+cSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWAFO7fbjN7xzWUn0Sx4mabGaeqYLWcNmDix+94pB7U=;
 b=fBxGRPJZB7HN9ZpsD5I7aF3yGUQaMjTUFcsYpVaQ8ZTIru5lQ7wM0grI8xR8EJTJjt9nh/ScktdPVzrwBJFSm+ZAY3Chfe1yloOykpSP/1kHX2L3y3xNrUqHeOwqLj9+9NUnQ0F5Vfk7pTwy3SOpan4C8O66gD8w9j+ecDDoS72iCEvavXYMLYGlx8q++rwIlBb7wI8vlYSdc9z1txD92b3I1xH7IgoBjBxpjBX6T9AXMpDk9e22RY427WB0MLOPefHzPRgUw/WAWIyKDc9tXCLUYhjPk12pOvmSlaA/xgDEIhwX4xE3cLkO4TCbysEdUyswL0+K8vtcDpsRnq+xyw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 12:57:32 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 12:57:31 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>, "Alice Guo (OSS)"
	<alice.guo@oss.nxp.com>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Alice Guo <alice.guo@nxp.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzXSBzb2M6IGlteDogQWRkIFNv?=
 =?utf-8?Q?C_device_register_for_i.MX9?=
Thread-Topic: [EXT] Re: [PATCH v3] soc: imx: Add SoC device register for i.MX9
Thread-Index: AQHbKqwqz+kk7bvHZEGUqeAMoxlRu7KfL14AgAAQS+A=
Date: Wed, 30 Oct 2024 12:57:31 +0000
Message-ID:
 <PAXPR04MB9644C990417C75755334BD61E2542@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20241030091336.3901440-1-alice.guo@oss.nxp.com>
 <9e239176-b1f2-45ef-a731-636f5a78aaa2@gmx.net>
In-Reply-To: <9e239176-b1f2-45ef-a731-636f5a78aaa2@gmx.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AS4PR04MB9692:EE_
x-ms-office365-filtering-correlation-id: 83477363-8045-40be-9db0-08dcf8e26ac3
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0hiTE1HMXp2UVdSeUNLN1R0N0tseGNXSTF5bnVuNC9qUjBheGVxQmJmRXpN?=
 =?utf-8?B?SXc1RjlMM1NiVERyb0hJbTd2NWxvdGhyZ3drcDNMVXVmUnBSSUYzWVJXUzRN?=
 =?utf-8?B?ajE0SGZBR2E2aDMyVzFCUCtzVmlEa0dGTXYzRlV2Q2hEcjJLaUJuaWxsZ1F6?=
 =?utf-8?B?T1puS0J0RkIvcWlwelgveDlMdEdkSnpQRXgzL3NqMUhWajdxQXltRWYzMWxQ?=
 =?utf-8?B?SDZONmpxZ211eHhIQmVNTW1UYk5GSjhxcUhZN0xTT2pSaVZNb0RocXpNVlZr?=
 =?utf-8?B?YmgvZ0NjQSt0N3hDb2h6S0lqbEc5NnhhRUI3d3B1TmZOVUVQVGhLYUtPUjRT?=
 =?utf-8?B?bElnZWk4MnhHSExUUEIydElpVE4rWW91ZVdPR0t6d3lNWFVNV2lybm9VRWxI?=
 =?utf-8?B?dExnUkxob2VGK2ZkT0ZnU0FkUVR1TEF4dzZ2QXBZdk1PcFpQS2dSQjMzdktO?=
 =?utf-8?B?bldaUnNNVjVjaXRaVFlqT3RLdGFXZ0NaaFdaVUlEbFVaUFlMcnRiUW1aMnVq?=
 =?utf-8?B?RjZYT3o3VkoweHZURlF2bnZwK1NDY2pWd0Q4azF0SXNEcHhSMEhHa2lKWCti?=
 =?utf-8?B?dHAvTjk4dloxZ2dvdDNYRmpDbjY5S21nSDN5cVdqRGw4dyt6Qy9Jd3NNQVpH?=
 =?utf-8?B?Z1RJV3VTUUg2L0JZeWcwcFZGOUdiV2owRktIUGtWOEZXcXNvSXNKazdoYUoz?=
 =?utf-8?B?ckpZS3FOUEhuV0Uwa1NIK0JHRjVZNlU4dENKZnVZODRhcjk4RTJqRzJXL0tw?=
 =?utf-8?B?Q1R0UWJyNzc3eVd6NmIwcm52STU3a2pBMmpzOHN1eHFKcmNLejB1YmRZSXVr?=
 =?utf-8?B?ZTFxcWdVWHBFeXpnMzNnc2RjMmp2bTRMekZralBZUUY0UmlXd1BCQlB6RnB4?=
 =?utf-8?B?UkZWV1ozT3NLd0Q0WWcrTmQ1MEs5M1JtRVppSFV1Rm1qdXlROTNpYkhPb0xM?=
 =?utf-8?B?T1lEN3ZGLzliQWJWTllERkg3UlpIQk81NUozWW9yOVVmOFcvTzMvZVJtVVpJ?=
 =?utf-8?B?RURhb0ptekZ6dVdJMzlIUExvWGZlaXVXVEhRTE1KMmNQcWhOZURydXo2bWty?=
 =?utf-8?B?bG0zbGYwQ3dSSlBnazdLV2s0a0ZBWmFJL29remN2VjBFR3FzaUY4ZWJVT1Zv?=
 =?utf-8?B?UGZuYWFqcUFEMm0yeWZQV0szVWozeHhFYW5tb2ZLd1R5ZThicnVHWVZQNEJ6?=
 =?utf-8?B?anZoZGhJY1dYdENINEJvWUdiMmtmL3RMeFhyaER1REQxTXVYM1dGM2N6Vngv?=
 =?utf-8?B?YWNyeTZpK0J5QU0vQnYzY0cxOHJleTZiZlc4MS9RaWptTUpWMGZ1QWdqM2dW?=
 =?utf-8?B?dXc0TnNYdFNVcnVaR0Q2K1duMVQ3Vm1LM240U09JR1VaT05LZUg5NzlyUFJJ?=
 =?utf-8?B?Uld0Nnh0NmZsanFDam1teVFFeWptQnV6dFNrQ1VVd01LN0dKMGp5MzNSUkFC?=
 =?utf-8?B?cnNjVWhLbEdJNHUwZjZhaDlhV2YvaGM1eTRkbUNYTElGb3J6eW9aNmhINzla?=
 =?utf-8?B?NVZKRVQxVk9rTnVFMjBQb1JuS3VSTG9RS1kwNVduSTBiRnZCa0RQUEFzbGNL?=
 =?utf-8?B?b2ZJK0h2UVNteXdIOXNtYUxBQzA2UWdSVUxaMzdpRXJudXd1cUlxcnEvY3Ar?=
 =?utf-8?B?SkFFZm8rdTRqNVU2dU00K3pacUpCUHFsbFBrTG13bzY0eXVac3FGRkRjMGkr?=
 =?utf-8?B?MTZBOWpsVEJVWS9jWDFwaTJFb0s0WTRFdktkTTUxMkpRZThzMDkvanJVSFhn?=
 =?utf-8?B?eUl3SVM5TGZvNkZvZE93cTVOYnZkaFQzL1BscnVLa3dsRXNpWXZ3S2pIdlJO?=
 =?utf-8?Q?n9Lukaw1qECQFuCatI9oeCaBdPB/GsTrLY7bo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkYvNk1jWjk0dkl4MkY3eDMvQm5POWdqTTJtdFJRY284bVVQaG4xZkhPYTZn?=
 =?utf-8?B?eERxTmhVYzNhc3RJcVZLVzZ2MUFheWxEYnRpS09wYXZTTlNnclBNSXM0QUZy?=
 =?utf-8?B?dE1iR3ZlbHIyM3BCR2FYdytHaitVK29hU2hZVFNNcHZwMkNWU1VzQmo3MUo4?=
 =?utf-8?B?cnJwdVlCSzNnRVRrcnVJL2tUbS9abnVkZWpvdmtlb3lzTysvazRLd01wMHRQ?=
 =?utf-8?B?T1FtMDZpZ3U0SytLYUI4cE1kb2VVakRHNXFSWlNzSWwyaEJJVkNOc014L2dI?=
 =?utf-8?B?ZWxXaW1pMEJCY2I0ZmJZL2J1dzhvaUJmQng5enl1TlpLSERiMWY4REcvWUc1?=
 =?utf-8?B?YVpBMndIS3BvY3cwTlJuZENmdTZTcksxb2tldUVva1VCd2I1dGRnUEFkRGlK?=
 =?utf-8?B?VEVRY0FSek9Vc05tbmxrdGxmOXdhbStFRDNORkwxczRQSWRpNjRtY3ZZL1M3?=
 =?utf-8?B?emVhVkVadDZwdzRUY1VCWVZSRkpzZ2UwcERwMG80c2xha3NTZjEwcmhZcjg3?=
 =?utf-8?B?VlAvRnFPV2VLcDBxSFRweXl4MzVETkduSnBjMXNMMk9XbHlvdlNXQzVmMFFV?=
 =?utf-8?B?bzBkVzZmeVRiL1ByQ2VzVE9rcU5EdVVhTzJpYWlabENpSXg0U3J6c1ZZNUU4?=
 =?utf-8?B?VjEwQ3V2NEdZNFVka0hlQmNSU1FOL0Y1ZFd5MkR3dzdoQ05mRXZ6OXFKQ1k3?=
 =?utf-8?B?WHE0ZFVURWJCbTNlb3NTd0VrV3RIVnUvQkloWnBLTFIrRmZiaHVyTHZubGky?=
 =?utf-8?B?bjBYUGVaWVBLdVVUOUM0MmdmMUNFRVh1eDZuOG5hV0hDQU10YkY5NFRubzMz?=
 =?utf-8?B?WEpNdFd0NHF0czlIU2NWczZpSUsvTmg4R2V6ZHlPR3RjQ001NEVUT2E3b0Z1?=
 =?utf-8?B?cHIySGNJekVVaUtEZlRBL1pjTi8zQ3ZMSzhVMmtlODhHMzAwc2JmeHpGU2Zu?=
 =?utf-8?B?NUpWQXVLRXFZUFgwc0tnWTNRTkdDK2lMRzVvL0NDRlFLL2x1SWIwSTNZOVU0?=
 =?utf-8?B?ZmFOV21OTzBjY3NMYndsVktTdmFEOEpuRFJoTUJYL2MwMHRySE5JV3B3WVoy?=
 =?utf-8?B?aHpBK1BUUW80U1V2cW0zV2dNQU4zNzFjakk0eHNidWloVVFKeFVpb3JxL09S?=
 =?utf-8?B?V3FXMzhZQkFTSEZQczI4QS9HVC9TOEhkOHZTMzBNcHRXc1dUNUMxSFBWSk1z?=
 =?utf-8?B?b0M1M2NudjdiampjQXlWb1VCTEZzRENsU2s2VS9OUTBwaFJEclhkRlFZV1pU?=
 =?utf-8?B?cUxrdytlTjdjc2FqMTZINFBUMW8zdUg2anUxRE5JVFVER2lxN0JPYkd3dE9a?=
 =?utf-8?B?OC9PbUtLQTRZdk5abkFId1lIR2RLNHFzYnBHSUlUVE4xSW1UUG5BdlhtOUdE?=
 =?utf-8?B?c0xxanRwNkhjWjlaNzRIMm1aVVAzNzBiYUM0b3lXdkhDdVNRaG0zN3hoK2Ez?=
 =?utf-8?B?WVJ6SG9zanhvcElKazl6OFg4RU9ubFQ3VDNhQ0NMUXRpaDliQytmYzB4TDlU?=
 =?utf-8?B?RFlrT3o5M1ovZjF0c3g5ajRTVUE2OVlhLzRvek44VmNvengzWTFVZUw4c3JX?=
 =?utf-8?B?VVhNTGVFVjdmNDlZaHkyWXF0VDZjcmkxdkJwZ0h2K2tvS3lPMnQ4ZXd4NUJQ?=
 =?utf-8?B?azUvNEVER2ViMDVOYXNwSUFSWHJGNlZycXZMaW5QS1FXTnl0U0hsc1h6U0ty?=
 =?utf-8?B?S0xEUC9WT29UTVFPUm9rTi9ianJaaitFWVh3QlE3SkhXMy9iY1ArQitMQkht?=
 =?utf-8?B?N204QUpDcWtCK3lBcDI0YXVQM2p4cDJ2MU1EZ3pCSmxmRDk5eFRzcFFLRnpM?=
 =?utf-8?B?RVdyaFVacHg5czBLY2JHU2lXbVlxdG9zNVFUbkFnUzJia0NKNEhrUG10TGgy?=
 =?utf-8?B?cFhRNXI2QzJFRnVOVjRxUWVKU2VCQWUxMnhTSEZYNUtLTmNiU3dTNUVtUVVk?=
 =?utf-8?B?RkxPMTNRdEo4akhPd1E0QThVR2JGUFZ6VEUvYkZtNHpnZktISGV3ZUpwOUxt?=
 =?utf-8?B?RGdleWpuakF3UDFmSEhOc0IzbHNLbUIvMUdtczBHdC9yRG0vQ1VEMUpXd0VX?=
 =?utf-8?B?bzhqK3FHbkF2bnpGaldIRFluSXcxakM4blZHakRsUkNKeUgreDgxTHRHTGpl?=
 =?utf-8?Q?9V/w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83477363-8045-40be-9db0-08dcf8e26ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 12:57:31.6747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YygARM6icfQ/43Sry452iThqw1I/fE/xoPHFr2Gq++l0/jSxpSquB0dZAN3f0EhHAovxhDNo0BpsGJpSsdqpZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9692

SGkgU3RlZmFuLA0KDQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBTdGVm
YW4gV2FocmVuIDx3YWhyZW5zdEBnbXgubmV0Pg0KPiDlj5HpgIHml7bpl7Q6IDIwMjTlubQxMOac
iDMw5pelIDE5OjU0DQo+IOaUtuS7tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3Nz
Lm54cC5jb20+Ow0KPiBhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tOyBzaGF3bmd1b0Br
ZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXgu
ZGU7IGZlc3RldmFtQGdtYWlsLmNvbQ0KPiDmioTpgIE6IGlteEBsaXN0cy5saW51eC5kZXY7IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4g5Li76aKYOiBbRVhU
XSBSZTogW1BBVENIIHYzXSBzb2M6IGlteDogQWRkIFNvQyBkZXZpY2UgcmVnaXN0ZXIgZm9yIGku
TVg5DQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFr
ZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hl
biBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMg
ZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IEhpIEFsaWNlLA0KPiANCj4gQW0gMzAuMTAuMjQgdW0g
MTA6MTMgc2NocmllYiBhbGljZS5ndW9Ab3NzLm54cC5jb206DQo+ID4gRnJvbTogImFsaWNlLmd1
byIgPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+DQo+ID4gaS5NWDkgU29DcyBoYXZlIFNvQyBJRCwg
U29DIHJldmlzaW9uIG51bWJlciBhbmQgY2hpcCB1bmlxdWUgaWRlbnRpZmllcg0KPiA+IHdoaWNo
IGFyZSBwcm92aWRlZCBieSB0aGUgY29ycmVzcG9uZGluZyBBUk0gdHJ1c3RlZCBmaXJtd2FyZSBB
UEkuIFRoaXMNCj4gPiBwYXRjaCBpbnRlbmRzIHRvIHVzZSBTTUMgY2FsbCB0byBvYnRhaW4gdGhl
c2UgaW5mb3JtYXRpb24gYW5kIHRoZW4NCj4gPiByZWdpc3RlciBpLk1YOSBTb0MgYXMgYSBkZXZp
Y2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBhbGljZS5ndW8gPGFsaWNlLmd1b0BueHAuY29t
Pg0KPiA+IC0tLQ0KPiA+DQo+ID4gQ2hhbmdlcyBmb3IgdjI6DQo+ID4gICAtIHJlZmluZSBlcnJv
ciBsb2cgcHJpbnQNCj4gPiBDaGFuZ2VzIGZvciB2MzoNCj4gPiAgIC0gcmV0dXJuIC1FSU5WQUwg
d2hlbiBhcm1fc21jY2Nfc21jIGZhaWxlZA0KPiA+ICAgLSBmaXggdGhlIGJ1aWxkIHdhcm5pbmcg
Y2F1c2VkIGJ5IHByX2VycigiJXM6IFNNQyBmYWlsZWQ6ICVkXG4iLCBfX2Z1bmNfXywNCj4gcmVz
LmEwKTsNCj4gPiAgIC0gZHJvcCB0aGUgcHJfZXJyIGluIGlteDlfc29jX2luaXQNCj4gPiAgIC0g
ZnJlZSB0aGUgbWVtb3J5IGluIHRoZSByZXZlcnNlIG9yZGVyIG9mIGFsbG9jYXRpb24NCj4gPiAg
IC0gdXNlIG9mX21hdGNoX25vZGUgaW5zdGVhZCBvZiBvZl9tYWNoaW5lX2lzX2NvbXBhdGlibGUN
Cj4gPg0KPiA+ICAgZHJpdmVycy9zb2MvaW14L01ha2VmaWxlICAgfCAgIDIgKy0NCj4gPiAgIGRy
aXZlcnMvc29jL2lteC9zb2MtaW14OS5jIHwgMTA2DQo+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTA3IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9pbXgv
c29jLWlteDkuYw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lteC9NYWtlZmls
ZSBiL2RyaXZlcnMvc29jL2lteC9NYWtlZmlsZSBpbmRleA0KPiA+IDNhZDMyMWNhNjA4YS4uY2E2
YTVmYTE2MThmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL2lteC9NYWtlZmlsZQ0KPiA+
ICsrKyBiL2RyaXZlcnMvc29jL2lteC9NYWtlZmlsZQ0KPiA+IEBAIC0zLDQgKzMsNCBAQCBpZmVx
ICgkKENPTkZJR19BUk0pLHkpDQo+ID4gICBvYmotJChDT05GSUdfQVJDSF9NWEMpICs9IHNvYy1p
bXgubw0KPiA+ICAgZW5kaWYNCj4gPiAgIG9iai0kKENPTkZJR19TT0NfSU1YOE0pICs9IHNvYy1p
bXg4bS5vDQo+ID4gLW9iai0kKENPTkZJR19TT0NfSU1YOSkgKz0gaW14OTMtc3JjLm8NCj4gPiAr
b2JqLSQoQ09ORklHX1NPQ19JTVg5KSArPSBpbXg5My1zcmMubyBzb2MtaW14OS5vDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lteC9zb2MtaW14OS5jIGIvZHJpdmVycy9zb2MvaW14L3Nv
Yy1pbXg5LmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NCBpbmRleCAwMDAwMDAwMDAwMDAuLjgy
MzM5NTU4NDUzMw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9pbXgv
c29jLWlteDkuYw0KPiA+IEBAIC0wLDAgKzEsMTA2IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wKw0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgMjAyNCBOWFAN
Cj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8bGludXgvYXJtLXNtY2NjLmg+DQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9zeXNfc29jLmg+DQo+ID4gKw0KPiA+ICsjZGVmaW5lIElN
WF9TSVBfR0VUX1NPQ19JTkZPIDB4YzIwMDAwMDYNCj4gPiArI2RlZmluZSBTT0NfSUQoeCkgICAg
ICAgICAgICAoKCh4KSAmIDB4RkZGRikgPj4gOCkNCj4gPiArI2RlZmluZSBTT0NfUkVWX01BSk9S
KHgpICAgICAoKCgoeCkgPj4gMjgpICYgMHhGKSAtIDB4OSkNCj4gPiArI2RlZmluZSBTT0NfUkVW
X01JTk9SKHgpICAgICAoKCh4KSA+PiAyNCkgJiAweEYpDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50
IGlteDlfc29jX2RldmljZV9yZWdpc3Rlcih2b2lkKSB7DQo+ID4gKyAgICAgc3RydWN0IHNvY19k
ZXZpY2VfYXR0cmlidXRlICphdHRyOw0KPiA+ICsgICAgIHN0cnVjdCBhcm1fc21jY2NfcmVzIHJl
czsNCj4gPiArICAgICBzdHJ1Y3Qgc29jX2RldmljZSAqc2RldjsNCj4gPiArICAgICB1MzIgc29j
X2lkLCByZXZfbWFqb3IsIHJldl9taW5vcjsNCj4gPiArICAgICB1NjQgdWlkMTI3XzY0LCB1aWQ2
M18wOw0KPiA+ICsgICAgIGludCBlcnI7DQo+ID4gKw0KPiA+ICsgICAgIGF0dHIgPSBremFsbG9j
KHNpemVvZigqYXR0ciksIEdGUF9LRVJORUwpOw0KPiA+ICsgICAgIGlmICghYXR0cikNCj4gPiAr
ICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArICAgICBlcnIgPSBvZl9w
cm9wZXJ0eV9yZWFkX3N0cmluZyhvZl9yb290LCAibW9kZWwiLCAmYXR0ci0+bWFjaGluZSk7DQo+
ID4gKyAgICAgaWYgKGVycikgew0KPiA+ICsgICAgICAgICAgICAgcHJfZXJyKCIlczogbWlzc2lu
ZyBtb2RlbCBwcm9wZXJ0eTogJWRcbiIsIF9fZnVuY19fLCBlcnIpOw0KPiA+ICsgICAgICAgICAg
ICAgZ290byBhdHRyOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgYXR0ci0+ZmFtaWx5
ID0ga2FzcHJpbnRmKEdGUF9LRVJORUwsICJGcmVlc2NhbGUgaS5NWCIpOw0KPiA+ICsNCj4gPiAr
ICAgICAvKg0KPiA+ICsgICAgICAqIFJldHJpZXZlIHRoZSBzb2MgaWQsIHJldiAmIHVpZCBpbmZv
Og0KPiA+ICsgICAgICAqIHJlcy5hMVszMToxNl06IHNvYyByZXZpc2lvbjsNCj4gPiArICAgICAg
KiByZXMuYTFbMTU6MF06IHNvYyBpZDsNCj4gPiArICAgICAgKiByZXMuYTI6IHVpZFsxMjc6NjRd
Ow0KPiA+ICsgICAgICAqIHJlcy5hMzogdWlkWzYzOjBdOw0KPiA+ICsgICAgICAqLw0KPiA+ICsg
ICAgIGFybV9zbWNjY19zbWMoSU1YX1NJUF9HRVRfU09DX0lORk8sIDAsIDAsIDAsIDAsIDAsIDAs
IDAsICZyZXMpOw0KPiA+ICsgICAgIGlmIChyZXMuYTAgIT0gU01DQ0NfUkVUX1NVQ0NFU1MpIHsN
Cj4gPiArICAgICAgICAgICAgIHByX2VycigiJXM6IFNNQyBmYWlsZWQ6IDB4JWx4XG4iLCBfX2Z1
bmNfXywgcmVzLmEwKTsNCj4gPiArICAgICAgICAgICAgIGVyciA9IC1FSU5WQUw7DQo+ID4gKyAg
ICAgICAgICAgICBnb3RvIGZhbWlseTsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIHNv
Y19pZCA9IFNPQ19JRChyZXMuYTEpOw0KPiA+ICsgICAgIHJldl9tYWpvciA9IFNPQ19SRVZfTUFK
T1IocmVzLmExKTsNCj4gPiArICAgICByZXZfbWlub3IgPSBTT0NfUkVWX01JTk9SKHJlcy5hMSk7
DQo+ID4gKw0KPiA+ICsgICAgIGF0dHItPnNvY19pZCA9IGthc3ByaW50ZihHRlBfS0VSTkVMLCAi
aS5NWCUyeCIsIHNvY19pZCk7DQo+ID4gKyAgICAgYXR0ci0+cmV2aXNpb24gPSBrYXNwcmludGYo
R0ZQX0tFUk5FTCwgIiVkLiVkIiwgcmV2X21ham9yLA0KPiA+ICsgcmV2X21pbm9yKTsNCj4gPiAr
DQo+ID4gKyAgICAgdWlkMTI3XzY0ID0gcmVzLmEyOw0KPiA+ICsgICAgIHVpZDYzXzAgPSByZXMu
YTM7DQo+ID4gKyAgICAgYXR0ci0+c2VyaWFsX251bWJlciA9IGthc3ByaW50ZihHRlBfS0VSTkVM
LCAiJTAxNmxseCUwMTZsbHgiLA0KPiA+ICsgdWlkMTI3XzY0LCB1aWQ2M18wKTsNCj4gPiArDQo+
ID4gKyAgICAgc2RldiA9IHNvY19kZXZpY2VfcmVnaXN0ZXIoYXR0cik7DQo+ID4gKyAgICAgaWYg
KElTX0VSUihzZGV2KSkgew0KPiA+ICsgICAgICAgICAgICAgZXJyID0gUFRSX0VSUihzZGV2KTsN
Cj4gPiArICAgICAgICAgICAgIHByX2VycigiJXMgZmFpbGVkIHRvIHJlZ2lzdGVyIFNvQyBhcyBh
IGRldmljZTogJWRcbiIsIF9fZnVuY19fLA0KPiBlcnIpOw0KPiA+ICsgICAgICAgICAgICAgZ290
byBzZXJpYWxfbnVtYmVyOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgcmV0dXJuIDA7
DQo+ID4gKw0KPiA+ICtzZXJpYWxfbnVtYmVyOg0KPiA+ICsgICAgIGtmcmVlKGF0dHItPnNlcmlh
bF9udW1iZXIpOw0KPiA+ICsgICAgIGtmcmVlKGF0dHItPnJldmlzaW9uKTsNCj4gPiArICAgICBr
ZnJlZShhdHRyLT5zb2NfaWQpOw0KPiA+ICtmYW1pbHk6DQo+ID4gKyAgICAga2ZyZWUoYXR0ci0+
ZmFtaWx5KTsNCj4gPiArYXR0cjoNCj4gPiArICAgICBrZnJlZShhdHRyKTsNCj4gPiArICAgICBy
ZXR1cm4gZXJyOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCBpbXg5X3NvY19tYXRjaFtdID0gew0KPiA+ICsgICAgIHsgLmNvbXBhdGlibGUgPSAi
ZnNsLGlteDkzIiwgfSwNCj4gPiArICAgICB7IC5jb21wYXRpYmxlID0gImZzbCxpbXg5NSIsIH0s
DQo+IFdoYXQgaGFwcGVuZCB0byBmc2wsaW14OTEgPw0KDQpJIGZvcmdvdCB0byBtZW50aW9uIHRo
aXMgY2hhbmdlIGluIGNoYW5nZSBsb2cuIFRoZSBjb2RlIGFib3V0IGkuTVg5MSB3aWxsIGJlIHB1
YmxpYyBsYXRlci4NCg0KQmVzdCBSZWdhcmRzLA0KQWxpY2UgR3VvDQoNCj4gQmVzdCByZWdhcmRz
DQo=

