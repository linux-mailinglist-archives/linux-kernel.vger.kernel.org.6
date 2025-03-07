Return-Path: <linux-kernel+bounces-552110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F75A575DF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45DA57A59F6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0F258CEA;
	Fri,  7 Mar 2025 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="hW0JAWg3"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B5419CC05;
	Fri,  7 Mar 2025 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389381; cv=fail; b=SCW+826lwanIY9fCugejesdsbYSno/QkXllZMAa4i1J7NN1GxMr9qwOaYCtYIfCBcHiMkzU/ruM9RDSpqnUiGvOBtbjqnFAYadMxn2OI9kxr1PGuSsfbLwQrm+RA9U2rUvUPN0qn0hruQtB2mLg3y+ZXmy70G68XmJS+yf8sW4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389381; c=relaxed/simple;
	bh=WMh/idgd89mXvvEHQff/eGai0dX/Mi6+qVI5BagBSRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uJ1OBrgxv/ZcA67R+tigiEncndWZ4z8kxoCz4zf/guxqppPgdd0E3BU9k87FxJI22WJrNtCA+/H2wDTNQsk7tfrrzZfzDWSOPHCApND3/uoQERi+6esqKQhMr2zfFj1IV+lsH/a/et0u//D+D7rzQeX6r96/F9JEbB/LsC0ZHkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=hW0JAWg3; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527EVCEB020991;
	Fri, 7 Mar 2025 15:16:03 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45813b13p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 15:16:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUOUvuE7/WkqIACo1caOH5vfaG40PHaFJnrVbBK+8dG0mon1HuBi4W+KAHKRwWCq0+mnGb3O8aB7W2d6MHf+Rf8aNKMwQUvnmrSeYJdi09f3MG0RHXbjY8RHRDsdBcB/i8CHEoqRb5c50sTrG9arwWx8M+xGtH7r+A7GnbNUKgBwPHbURd3BEU4iIDPUurPidYM8FqiAWUK8XQZQg/urHRpIcaIEaOwc5YRJcAhJuRMM0iJTC+B9i71d8Wt4uKzPKNs5XBKmcIiXoLLuHOaz9i+f0dghnoA0szUKqQjATihgpwtEK+ZlP25YmOhLNV2oDxrZ00VwSOVZmDMVoDxr5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMh/idgd89mXvvEHQff/eGai0dX/Mi6+qVI5BagBSRw=;
 b=SgJdHo5ivrRzvpW2mO3X28v6mUiLgFE7Vs8aYtjdFkyBhE1KyA5Zs9fsGG7OCMc/b2fnHkOwGFjq5XYU0MFJwc/s7jIFyb2Sdp2xwD48UmLmDcqhcibOct4AkQ/Xhu9vqsnt66XV+WRX+1nqft5oao9BUAmQE+gn8T2PSj9D2vQbOhLKIp2B3VKkZcliEL2CeI5C/Kp8DqfaOTR9sNUJcTCj854Iet+iL2xM97J1CR50Y1tdMfazhU2wIIcKFZbYVGK8mc4XXs17Tkun3ufB571JdV2DGVobChwfVpz6glcgJDemdYMy54ftes9b0JL98PmFTBUuNWxCbRFtAdBo9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMh/idgd89mXvvEHQff/eGai0dX/Mi6+qVI5BagBSRw=;
 b=hW0JAWg3JMu63W97KncwTNs93Y4ZmgVswsMyPiAXwezTsOHyRLEr4K8a/AuQu+k6koRzqNTHDSv04fisCJaoKArCqonSCyBJ5ZjkeyaT/kylNTxzMRkTnH7ObhnzucJRH1OLusn++ilUIor1/SPOmTN2WyMYRo3sLFR45AFDMw0=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by CH0PR18MB4259.namprd18.prod.outlook.com (2603:10b6:610:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 23:15:59 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%5]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 23:15:58 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "Rob Herring (Arm)"
	<robh@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        Sanghoon Lee <salee@marvell.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "gregory.clement@bootlin.com"
	<gregory.clement@bootlin.com>,
        "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>,
        Geethasowjanya Akula <gakula@marvell.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add Armada8K reset controller
Thread-Topic: [PATCH v3 1/3] dt-bindings: reset: Add Armada8K reset controller
Thread-Index: AQHbj7biLYcKMtg8WkOLBEiPzL05Cw==
Date: Fri, 7 Mar 2025 23:15:57 +0000
Message-ID:
 <BY3PR18MB46735010948BE323B9A8ED5BA7D52@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20250227192536.2426490-1-dingwei@marvell.com>
 <20250227192536.2426490-2-dingwei@marvell.com>
 <174068786548.161165.4348563654300627455.robh@kernel.org>
 <BY3PR18MB467346EB1FA7CEF0A3300350A7CD2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <d2929546-27de-4893-a611-dd4a3bca1a64@kernel.org>
 <BY3PR18MB46734A2425361D8BE83E4282A7D52@BY3PR18MB4673.namprd18.prod.outlook.com>
 <f8e2091b-52dc-4b7a-b781-84588dd6b1ba@kernel.org>
In-Reply-To: <f8e2091b-52dc-4b7a-b781-84588dd6b1ba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|CH0PR18MB4259:EE_
x-ms-office365-filtering-correlation-id: 07c4f08d-c99e-4afd-6318-08dd5dce053d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDBnUzBvbE4xYWpIalh4R2ZMc2FJN3BEZC9UZmFvOWFtczFLUm43MUZQN1Ns?=
 =?utf-8?B?QzRuSFpNeU5jZmtRaXZkZWhMUm9LeDVUT1QvRGU3eE1xL1BPRzdDSDAyemh5?=
 =?utf-8?B?RHVZQmVTQ3JQaHJZdHdmbVlFeVl3eHp0M0hrYnRTQkF5OWtDNm91VGVLYnVl?=
 =?utf-8?B?L0dLWTByVEVyVDljblBrc1BLL3ZjaEdoaFNqNE5kWVYwSDdHTXB4MW1KVU0z?=
 =?utf-8?B?WC84b3VsaExhY081d2htYyt0YXZFYnNVNnVWWGxCVC93R0RoZVVtSjl2Tytp?=
 =?utf-8?B?ZXJYbG95YVBFclBqQXFPc08vL0dreitaWU90YmI3TlRlNHlBUUtPUUV5S0NJ?=
 =?utf-8?B?N1NHQlZBMkMwcWhPd04rY2RUaDdTV0k3STZUeVc3NUtkcFc0ekFlWmRxdDly?=
 =?utf-8?B?YkZVeVIxdDVvK3VrMWlvRzFRZWIzbGd4dHY5YUw2WmNQd1NPK2xFRzY0NE0x?=
 =?utf-8?B?MGNjUXFhK2xYRy9uMEgwWmVMdEV3QzBBUThLQ3dBRnViaXBlWGttS0tLYldF?=
 =?utf-8?B?MSsveXA0Y0VwMlpzb2o4alZ4aUcrL202YjZENk1rQVNocytGNXJjQVR2RFlD?=
 =?utf-8?B?YlNRQThzc2pQTzIyaEFxdWZ6NFdsWlB3MXZBckY5cDRIY2lpMHBEcThCcitH?=
 =?utf-8?B?Zkl1ZEsyMjgxUEd1SDQ0eDIvY1RxVUJnOE4zazVTbDU4d0V2MmlGMWtPMEFh?=
 =?utf-8?B?SFRGL3FOZXNCYWJUbTZSd3JyeWtRSWFUK3pmSjNiWVRlNERZejNIYS8rcVph?=
 =?utf-8?B?b0tuUCsyQjhpc2lzNDdaS0hWYTR0akVpbGhqRmNLeHBkclhHeko5WEJPcUFQ?=
 =?utf-8?B?Ylk3YzlObHE1VVlvTS9OanJPY090Q1FFUHhNTExwQjZpN1J3UVp3N2NhMXVa?=
 =?utf-8?B?RjdkWVp3ZWllbmlHZE1mY2VtSm1zYWsvRTB6blNuVy9lL1RqSWVkbVlVTlJy?=
 =?utf-8?B?dklsckpVNW9uUDUrVTZhU2YyRVNXcm5iRHhkbXhuTGtqZUlJRjJ2QTFRQ2Q1?=
 =?utf-8?B?V2RuOURVTk9UY1I1SFNvd3JNMWNjQ0ExZ2g5UW9EbDBmNEkzeEhJOFVObzN1?=
 =?utf-8?B?WXNVWmhxaTAyY1c2S1gvbktuZHJabnN0bkgydWQzekkzQXNhK3BOYzBEUDFP?=
 =?utf-8?B?Z2pVMTg1dkZzeW93MDVvdDc3TDZXQ2tKckdDL2ZPR2Q0Ymd5RER5SFYrQWk5?=
 =?utf-8?B?Q3FSNVlJNmp5L092bHd1bFk1d3hHVm1hMXlrdUVTem96c1VHaXczeTFuTWZN?=
 =?utf-8?B?NDN0VXNId21xZzZpdmdWeTV2Rmc1QmtzNDJTZ0haYlV4TjIvNGNLZEZBUG9K?=
 =?utf-8?B?Tjk2TDdJdjZ4VEl1UU5vTEpLSTFaUmpRV3dPTldSbmtJN3h0K0UzdE5PbG5X?=
 =?utf-8?B?a0J5ZGZvTS83dGtTVGI4OEh0K051YzhnL0JVUytaTVF0dHpwY1BUWFBaOHdl?=
 =?utf-8?B?UXZhS3VkZE9DdjNVd203RlJ1dmVNS0k5bmUxVEovM05BWXJUWFpFRkFrTGxz?=
 =?utf-8?B?d3pjckFnZ1M4cS83OU9zWlVJckNJbHZPcnR4aUNONExzdGJxRWxyRGxOOXo2?=
 =?utf-8?B?VmRFMm9KQTZ0T2c0cE5yWGdQdkt3MHdocC9HRnFFZHJ5ZGl2SG5Gb0tnMi9s?=
 =?utf-8?B?OWQ3OTU3eGVtcFJrT0FvZFNxaHppZy9NaUh4VFpFbHpVSkw0RklzN1hDaisr?=
 =?utf-8?B?M25LRkVNWEo3bVVjUkZWa2J4cFQ2cmgwYUZ3VHpmWVB0ZFh2NjYxVG95NS9W?=
 =?utf-8?B?clZEa0psY3JaOHRFMHFTeDhEWitrbW91U0UwdkVRbHdEMjBDdnFKbXlpQnJQ?=
 =?utf-8?B?enJKMmdUOTVwTzFzd0xQb2ljYUw3b3dYbDV5M2tkdVpST3I4NWNHSmpvSkdZ?=
 =?utf-8?B?dkxZeXZRZmhUdm14bmNsQmgrekJrUlZ4RGE2ay9XM1MvSHBIbjhxRkxoOTNP?=
 =?utf-8?Q?xsnyIbKbmLoS3JB5Y7+QEZZdezHGF7wo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0Rjb29lOFhobmozSFV6MUlkaUJlNitlNkhhM29BWmFRRFZwTmpLUlpPeGYv?=
 =?utf-8?B?UE5ub1NSRFRabklUWW85N3E1T1hRVDBKN3ZjTGtFeG1JUUNOQzhoUE90QTMz?=
 =?utf-8?B?cSs4Q1ZocHMyaVZlK3c4anhpNXlmaHlQalIvaUxLMmRSakNpZEM4WjJldlJD?=
 =?utf-8?B?TGVCbFFyYXVvOFIvVGExUUs4MHd2b2QzV015NGFveFJMeWVwSEdJZ09LY280?=
 =?utf-8?B?WG9VMGNQQ2tPaERoODMvUzN4b0wrRnMzaVRzbHEyeitWUlRIbWpQQXV1RCtU?=
 =?utf-8?B?d0hhSHJ6T1lsekgrS29YVlBzcEJsZVFDZnpmWlZmOGkzTU1Ib2NQN2xIemFG?=
 =?utf-8?B?RHBEMVhKZEE5NzBhMlZ2aStlNzdad0h1bnBOSGlyRDB2eG9NK2diUXNBSitB?=
 =?utf-8?B?NjR5M1NucnR3dHg2WUdRcEgveThTTHoxRklDRzVXZ3J0cGVad21LNGV4MldR?=
 =?utf-8?B?WTRUME1KWlFFSGgyd3EwR2ZrcVFKMk5OR0UwSXRQaGlXbElLMk1PbE5XT1M1?=
 =?utf-8?B?U3pnOTl0RGp2dS9EeXhtRlk1MlZEcVFFREVyTnNYSG9kOFErMEVneVZ3QWEr?=
 =?utf-8?B?eEtaTGpnTXBlQUt1eHR1akdWK1kzeHg5dnAvQ1N2V2ZwSGI3UUlLNzhNZXgw?=
 =?utf-8?B?K1NPL0t3VTByRGtwbUdMb1Q4TmlxMDdJTlpETE5FdFFiYlQ0N3dqQUg0L0xB?=
 =?utf-8?B?bXRjWkhMQ1pML2lnSTdjWkhxYTdlWXFaYjdxVTZLUkpjbnhYQXpFSkZwZ0k5?=
 =?utf-8?B?ZFFiSzhYWTJxNWdTOXUvc0tHbk9VcDc2ZUlJM3BKd0dlNE04WlBuR0ZyVDRi?=
 =?utf-8?B?UDhSb3Nhb1NwZHM3SkNwV2RacVIwN2IrZEg3OThLSzJzd29mWGxPaTlEWHJH?=
 =?utf-8?B?Z2F0cWNmNS96QktEZytFdmVlRThXREVJMkpMVjE1WDFwamRQS01BTlFidzZR?=
 =?utf-8?B?WElsb2VhUDNXMkU2Yys5dkp5QjhDY3RSdXc5c0NlWFk5c2pBb0tkMGVLZ1l1?=
 =?utf-8?B?NzF0ODI0dTMxN0EwWm9wQ3FaQVIxaDQ3TG4vQURCenhuVkpXbDhjdWl5b2Vw?=
 =?utf-8?B?UFJiZDVBcHdCaWEwNzdpRlF4enlicDBCeFBxVGxWY002NlgzK3QwanlnazJZ?=
 =?utf-8?B?S09Xc0k4TU9wZDJaMmw0cDFsUkNpWkFSaHA0T2tIRmRscnEzME9PRWxuNHlt?=
 =?utf-8?B?dW40WlBRbDNZY0QycFZTeDRLU0Y2dFhGOGdjY0plMk9JOHM2b3ZkWHdiYzhN?=
 =?utf-8?B?NHB2a3lia0d3NDN6dEZ5S0RFc25rekwrWk1rWjlkMU1WckdicXdKcEorMWs0?=
 =?utf-8?B?aWMzQkFjUzh0RlpqUGprV2EzckV6NmErUUorOFQ0MjI0NXd2RTFDVVBkd3dO?=
 =?utf-8?B?NURpM0lINkhlMHpzZU80N1FrRWlqUGwxOWZZbElTWlZ5T3k1WEpGNTFjZ3R6?=
 =?utf-8?B?aGxIL0xRNFBhVzlLeGt0Q1Y0b2JXQytQdWpreGJGZzZjbjd4amsxcHY2Q3Bl?=
 =?utf-8?B?VDluV1RqSG41MHZndVBtYm1peDRTckx1RVZPMWdzc2FzT2EzNS9MUzBHK3BU?=
 =?utf-8?B?OXJ6LzF0aW54bjBHSGNkT2h5Nyswb2dyZjlyRnE3azRabnFkbEovTndUQ0Qx?=
 =?utf-8?B?cXdoWklRSEJ0eGk0MlpxYWdDZzJwYXdtS2o2UHdFa1lIVGxZV0xUa1E4bTlD?=
 =?utf-8?B?S0ZMUHMyakJvMzl6WjloQkNnVk1JeUhvVVF3ZzkvV1d2UnJydW12Z2R6bGhM?=
 =?utf-8?B?WkJ2WjkwcjMzd0NyMHlSME10M3Nyd0Y0djFSS21kN2FGUWJWOGZEVGI2Ny9v?=
 =?utf-8?B?czZ6b3Qwdlh6dHBEYWZMRTNsYVhXRFY2aXpnbHlwQXkxRWxsanFsMmxMQjY1?=
 =?utf-8?B?RHUxd0lVZ0lyODAxSVJvUmM0cUtVcW1Nc3I4dDROZ1ZKd3pRMzVVOG54WURI?=
 =?utf-8?B?ZlZDRVZ4b2RnZElLZTBWeDVURWtoRUtDcktUNGkySklwcGxFL3NRQnFxS1Ev?=
 =?utf-8?B?eVI2WEJHeE0vWEJ4TjU1Q1NZRzBLMGZiLzFaWVNQT3hpQTlNaHE2eWc4bGFY?=
 =?utf-8?B?UitucXBqT2JZbURnUjlUMWFNU0lsWU9IU3hYT0trYmlLSUU4dUdCM2V2MTB3?=
 =?utf-8?B?OHlyaWx2Nk0wN3J6YVc1OFh6dWdUVnJ1M3pnQ2xmQzVORDNuM3pYMVBxSlBJ?=
 =?utf-8?Q?5iPUwLG/WzB3XKe+xbthL+4Dk0NIRm83sTe8dKpxU2nQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c4f08d-c99e-4afd-6318-08dd5dce053d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 23:15:58.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yc1Hw9I1BIoKE78uvcogbjNitMFIpQs298qi42XGDqg6l86gXdpmquHTKD8VhD+Tm0zI29mGHAOe/aG2oHPhXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4259
X-Proofpoint-ORIG-GUID: gtpLUf0eTKy8qbJldde4nWsgjkgJzGBI
X-Authority-Analysis: v=2.4 cv=AJ9YMcAg c=1 sm=1 tr=0 ts=67cb7e32 cx=c_pps a=PK5aExQQjalka8oDlC/sVA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=RpNjiQI2AAAA:8 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=JfrnYn6hAAAA:8 a=P-IC7800AAAA:8 a=pGLkceISAAAA:8 a=85wFNujiMn-KS7usy3sA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: gtpLUf0eTKy8qbJldde4nWsgjkgJzGBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_08,2025-03-07_03,2024-11-22_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDcsIDIwMjUgMTI6
NTcgQU0NCj4gVG86IFdpbHNvbiBEaW5nIDxkaW5nd2VpQG1hcnZlbGwuY29tPjsgUm9iIEhlcnJp
bmcgKEFybSkNCj4gPHJvYmhAa2VybmVsLm9yZz4NCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgU2FuZ2hvb24gTGVlIDxzYWxlZUBtYXJ2ZWxsLmNvbT47DQo+IGNv
bm9yK2R0QGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGdyZWdv
cnkuY2xlbWVudEBib290bGluLmNvbTsgcC56YWJlbEBwZW5ndXRyb25peC5kZTsgR2VldGhhc293
amFueWENCj4gQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBhbmRyZXdAbHVubi5jaDsNCj4ga3J6aytkdEBrZXJuZWwub3JnOyBzZWJhc3RpYW4u
aGVzc2VsYmFydGhAZ21haWwuY29tDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2
MyAxLzNdIGR0LWJpbmRpbmdzOiByZXNldDogQWRkIEFybWFkYThLDQo+IHJlc2V0IGNvbnRyb2xs
ZXINCj4gDQo+IE9uIDA3LzAzLzIwMjUgMDE6MDMsIFdpbHNvbiBEaW5nIHdyb3RlOg0KPiA+PiBy
ZXNldC5leGFtcGxlLmR0cw0KPiA+Pj4gICBEVEMgW0NdDQo+ID4+PiBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcmVzZXQvbWFydmVsbCxhcm1hZGE4ay0NCj4gcmVzZXQuZXhhbXAN
Cj4gPj4+IGxlDQo+ID4+PiAuZHRiDQo+ID4+Pg0KPiA+Pg0KPiA+PiBUaGF0J3MgYSBiaXQgb2Rk
IGJ1dCBhbnl3YXkgd2FybmluZyBpcyBjb3JyZWN0OiB5b3UgY2Fubm90IGhhdmUgc3VjaA0KPiA+
PiBjb21wYXRpYmxlcyBhbG9uZS4NCj4gPg0KPiA+IEkgdW5kZXJzdGFuZCBJIG5lZWQgdG8gYWRk
IG9uZSBjb21wYXRpYmxlIGhlcmUgdG8gcmVzb2x2ZSB0aGUgd2FybmluZy4NCj4gPiBIb3dldmVy
LCBhcyB3ZSBhZ3JlZWQsIHdlIGtlZXAgdGhlIHN1ZC1ub2RlcyB3aGlsZSB0aGVyZSB3aWxsIGJl
IG5vDQo+ID4gbmV3IGNvbXBhdGlibGVzIGluIHBhcmVudCBub2RlLiBTbyBob3cgc2hhbGwgSSBh
dm9pZCB0aGlzIHdhcm5pbmc/DQo+ID4NCj4gPiBJZiB3ZSBkbyB3YW50IHRvIGFkZCBhIGNvbXBh
dGlibGUgaW4gcGFyZW50IG5vZGUsIHdoYXQgc2hvdWxkIGJlIHVzZWQNCj4gPiBmb3IgdGhlIGNv
bXBhdGlibGUgbmFtZT8gSSB0aGluayB0aGUgbW9zdCBzdWl0YWJsZSBuYW1lIHdvdWxkIGJlDQo+
ID4gc29tZXRoaW5nIGxpa2UgIm1hcnZlbGwsY3AxMTAtc3lzdGVtLWNvbnRyb2xsZXIwIi4NCj4g
DQo+IEkgZG9uJ3Qga25vdy4gSSBkb24ndCB3b3JrIGluIE1hcnZlbGwsIEkga25vdyBub3RoaW5n
IGFib3V0IE1hcnZlbGwgQXJtYWRhDQo+IGFuZCBJIHdhcyBub3QgaW52b2x2ZWQgaW4gYW55IEFy
bWFkYSBTb0NzLg0KPiANCj4gUmVhZCB5b3VyIGRhdGFzaGVldCBhbmQgY29tZSB1cCB3aXRoIHNv
bWUgcmVhc29uYWJsZSBuYW1lIGJhc2VkIG9uDQo+IGRhdGFzaGVldC4gV2h5IGRvIHlvdSBhc2sg
cGVvcGxlIHdobyBkbyBub3QgaGF2ZSBkYXRhc2hlZXQ/DQo+IA0KPiA+IEhvd2V2ZXIsIGl0IHdh
cyBhbHJlYWR5IHRha2VuIGZvciBpbiBBcm1hZGEgY2xvY2sgY29udHJvbGxlciB0byBiZQ0KPiA+
IGNvbXBhdGlibGUgZm9yIGxlZ2FjeSBkdC4NCj4gPg0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5w
cm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwub3JnX2ENCj4gPiBs
bF9iYjIxZWU5YWNjNTVlZmFjODg0NDUwZmY3MTAwNDliOTliMjdmOGJmLjE0OTYzMjg5MzQuZ2l0
LQ0KPiAyRHNlcmllcy5ncg0KPiA+IGVnb3J5LmNsZW1lbnQtNDBmcmVlLQ0KPiAyRGVsZWN0cm9u
cy5jb21fJmQ9RHdJQ2FRJmM9bktqV2VjMmI2UjBtT3lQYXo3eHRmDQo+ID4NCj4gUSZyPXNYRFFa
dTRHeXFOVkRsRlVYYWtTR0psMERoODFaSVBsVTI2WVM0S0hHSUEmbT1uZnJCMXo2dGdMRVkNCj4g
M0JlVUs4Y0gNCj4gPg0KPiA1Q0JFblVKaHExeUhYUzl4Q0RlZ1JNR2FwekQyck9MN3owOTJzSmQx
ZHpJbyZzPUxxVUlfSzBybk9YUG15DQo+IGRrRTluLWhkSw0KPiA+IEtPMmRtR2h5TjVILXJhVzYt
NkRjJmU9DQo+IA0KPiBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCBpdCBtZWFucy4NCj4gDQo+ID4N
Cj4gPiBUaGlzIGlzIHNvbWV0aGluZyBhYm91dCA4IHllYXJzIGFnby4gSSB3b25kZXIgaWYgd2Ug
ZG8gbmVlZCB0byBoYXZlDQo+ID4gdGhlIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgZm9yIHRoZSBm
aWVsZCBkZXZpY2VzIGF0IHRoYXQgdGltZS4gQ2FuIHdlDQo+ID4gZHJvcCBpdCBub3c/DQo+IA0K
PiBEcm9wIHdoYXQ/IFlvdSBuZWVkIHRvIGtlZXAgQUJJLg0KDQpEbyB5b3UgbWVhbiBvbmNlIGEg
Y29tcGF0aWJsZSBuYW1lIHdhcyBwcmVzZW50IGluIGR0LWJpbmRpbmcsIGl0DQpTaG91bGQgbmV2
ZXIgYmUgZGVsZXRlZCBpbiBmdXR1cmUgKGV2ZW4gdGhlc2UgaXMgbm8gZHRzIGZpbGUgdXNpbmcg
aXQpPw0KDQo+IA0KPiA+DQo+ID4gICAgIHN5c2NvbjA6IHN5c3RlbS1jb250cm9sbGVyQDQ0MDAw
MCB7DQo+ID4gICAgICAgICBjb21wYXRpYmxlID0gIm1hcnZlbGwsY3AxMTAtc3lzdGVtLWNvbnRy
b2xsZXIwIiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJzeXNjb24iLCAi
c2ltcGxlLW1mZCI7DQo+ID4gICAgICAgICByZWcgPSA8MHg0NDAwMDAgMHgyMDAwPjsNCj4gPiAg
ICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICAgICAgICAgI3NpemUtY2VsbHMgPSA8
MT47DQo+ID4NCj4gPiAgICAgICAgIHN3cnN0OiByZXNldC1jb250cm9sbGVyQDI2OCB7DQo+ID4g
ICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLGFybWFkYThrLXJlc2V0IjsNCj4gPiAg
ICAgICAgICAgICByZWcgPSA8MHgyNjggMHg0PjsNCj4gPiAgICAgICAgICAgICAjcmVzZXQtY2Vs
bHMgPSA8MT47DQo+ID4gICAgICAgICB9Ow0KPiA+ICAgICB9Ow0KPiA+DQo+IEJlc3QgcmVnYXJk
cywNCj4gS3J6eXN6dG9mDQo=

