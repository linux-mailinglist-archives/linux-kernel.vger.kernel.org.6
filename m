Return-Path: <linux-kernel+bounces-439890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C800A9EB58A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360B5283AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605E9230D01;
	Tue, 10 Dec 2024 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="fp20a2RK"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2098.outbound.protection.outlook.com [40.107.20.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E722FE1C;
	Tue, 10 Dec 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846373; cv=fail; b=V7QCUNY+x6qgTspokDPixLHG0VVxg60Hi6tHPtWPctEs2EIF7Th5n0qy3VQ9ZRhuuA3sTu1KuveoGHhweQejTbZ4ZLWZKRLwQIvhsG3RbfPuVUKNwJQnhWodfY4qszQueebgus7TCJwc4od3nkVPJqUbeW2X42OpnO7jJ1+VcgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846373; c=relaxed/simple;
	bh=U2rtSGED6UetJ1K7dnok3rr4YDDl1pu4QK4V8QOSCeY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NyHbXYjv/UvxbbHLpvlhFCO3tvrbnXhnpvZRY6Kc99EwEGopEtUeukVVw9dpvcfsU+MIZO0pIgE4fd6BFYjK8V1ODZVm6o0ZAygfLXzO4UO9STRu/gK5zHbH1Lo+nIQQIjBfj3Kjoco+8u3VfYyjmMhwIQgRPTJFWCLCZJ6T5JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=fp20a2RK; arc=fail smtp.client-ip=40.107.20.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=In06InbvmEoSFWnyiXBXx0ey24HnOmy+wslmNfBUCqR2cTXWWXzw0aO2U7SXAeB7jxmOjiWmM9Xysy7UXrovD+iizg7K51pa1jz6mWaDy5/RVU2HHWIvasLUtaQ2xNP45xLDk+/KF7iTihI1FBGRozNCJu5uaAGsEWtiz2aOtAwc234whFL6D0CVrSUrFonD42kAf6izdSQBbWCtbOEP7MJRgOCKKwcSfkH7ZThy8WJrHXsxz7aLxNgAai1QyCpbPkHD5JipK8ZbbJYHlWYLqdxMPNJIRwvIe5urIj5tpD+RXvKZUq8OryuJM6GI+Wyj1rMuo9+DDJXcM3SGoljtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEwW8lOtXiS7iADVCJvq/FumlKQgikPyknfwN4og1xo=;
 b=INe0ex4tWVAbb1cNfr3OIIVIpadZEfDBspC5+MJ3EO+q3rMfagv/Pqq5xfon/Tmtk786F3uwrek+2vNtRWVp6A35/0BNemjHTxW5vYAGjQtS+EMmcC51P2CtltJ7+zMjKmXuhILJafPoo/lh4UnuVg5UC/tguME7WOkvaokODn2cSo7sq4lCxnmJ7A+iz8Ox1NKQDbDnZRqGZ9pUj16wCddv6zaMt46mWRMQncUnn3cErttVNaGnV40PVJHca5abLO61k9gzyMVldtbC5DxZWP0DNw9Ip9IyKu55XbsUSJw48ey/uEO5Jq5rvRD4A4oycLV/fmWsvWK5I3rdiRpyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEwW8lOtXiS7iADVCJvq/FumlKQgikPyknfwN4og1xo=;
 b=fp20a2RKyBfp2nDol8z1P18y0gIF61Zg2bUzFDCA0aBWN+nQ1QdogQIipyrYXbEc5+xqOC8pade8ADuF5daolMUanBaDhhmdnUvturhaCsilyUn9WE97WsrGZFkxTBCx+sBoAKGeFmePRdpu+HHHH2lFwRC/OzMkrVin9MK5UPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GVXPR10MB5886.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 15:59:07 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%5]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 15:59:07 +0000
Message-ID: <b5456480-a68f-4e71-831b-f145453e2646@kontron.de>
Date: Tue, 10 Dec 2024 16:59:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] Revert "regulator: pca9450: Add sd-vsel GPIO"
To: Conor Dooley <conor@kernel.org>, Frieder Schrempf <frieder@fris.de>
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Robin Gong <yibin.gong@nxp.com>, Joy Zou <joy.zou@nxp.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20241127164337.613915-1-frieder@fris.de>
 <20241127164337.613915-2-frieder@fris.de>
 <20241128-candle-guzzler-b7ea4e5ce643@spud>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20241128-candle-guzzler-b7ea4e5ce643@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::6) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GVXPR10MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ade5b6-c553-45fa-0620-08dd19339401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGJ2d25TaHA2V2haSS8yUnRqYTFQVG84ejk0NXJmYTJYSXlqV1ljYTBqU05j?=
 =?utf-8?B?VVhacVcyYXoxcXFzd1piMU5QZWg4LzZLcXNEbzV3K0ErQkZ5V0FjdVJqaWY5?=
 =?utf-8?B?N2c1V0RTeXFYSkVRVG9XbS83OVljK1ozTmtueFlldW13d1U4Y3dvaGRNUVFF?=
 =?utf-8?B?N3hna0c1WHM0ZElOdUFSSXdRbmtZT2M5T2RCbTF0M3ExM29Yb3I0d2ZMNjF5?=
 =?utf-8?B?b2Q2citRMnZMOWs5N2ZKWThncUFYZW93SlhOSEtyc0NrbHBpTDRzMGNycFFP?=
 =?utf-8?B?Uk5YZDBPTnZja2h2RjNIWnU1NmJwV0xGUENYemkrTlhJS3A3YklWOFBrYTBO?=
 =?utf-8?B?V0VPMFB5azN2bG8zMVM5VGdGSVFsMUkvN2YxUzY5K2hMSW9xc0UwL0dId1g3?=
 =?utf-8?B?UVdpOFpBYzdNSGRyQTc4aVlVN1NFY3FFOHJLNkNiZC9kQmNCQjNsZlBtRm05?=
 =?utf-8?B?aXQ3eUt6bkV6RXFDbWoydGE4dnFvZjJLRGVIaTlDb0VJbGJyQm1Ca1o3MkZv?=
 =?utf-8?B?bEFwek5KaDhFZHJ1MkJHNERQditpdGloQlkwYld6TkNTVVo1c2Q0djZPenJF?=
 =?utf-8?B?ZXhRVkJDZWlGc0Y3UVNYZkJtRUFMOU96dUJYVGRjY3BUTG4rRUFYUmVjQmor?=
 =?utf-8?B?RUtqREFiazluL0NsSStVS05EWkZLcUpqZGVVeXk1YkFVaXJ1ZkdUZ1lpUUh1?=
 =?utf-8?B?Z3ZRajd3UHRkM0xDZmcvVTlNalQ2Y0I0TmtBRFVJTlc3YkE3N0pPRkhDNVc3?=
 =?utf-8?B?d0U0dE1ZbldOU3JxWEg5N3JBcHpQRUNqL2dvY0E5Tm0vQjVnYnhab085VzJU?=
 =?utf-8?B?YlB1ejJrenRYYS9iUWJ1Z2hjZmhBMHBORHREN2JlOEg1T1YvUjA1ZnBtUDda?=
 =?utf-8?B?bGdxTDh1WlB3aUhvN3FXM1dPTkMyVEgvRXJIaTBHa2FDKzE5L0dHb3hRZUYy?=
 =?utf-8?B?Q1JJSkhnaHRnUHdiQ05CRytCL3ppNi9xYW5Yc3N2SzVLV203V2RDTWVDYW5t?=
 =?utf-8?B?NndNS3pLU3FuSnBTMG9kdTR1L0hqYzhPU1dOQXhEL2g0NWg2MmtqVTNVSTMv?=
 =?utf-8?B?VWg5WVBXVmRUMFlzd0JwODZ1Z1pmQ2lZK1RxVWNLL01mbDU3Y0V0RHQvU2ZH?=
 =?utf-8?B?WFhSUnQyQ2JMWTU1YVR3Vk1ZeFMveS95UC9KVzMzck8yeUVhZGcwa3M3YnJv?=
 =?utf-8?B?RXNJNlU1NCtBcTk1Z1BNb3BEd0J2MGxweWJzRUZKeVh0b0psWUpkdUZCQXI0?=
 =?utf-8?B?ZzFjcUM2MFp1NDVIaUpmWWpoYzZRNXNZY2o4RGs1SmxwRlV2MlR3c2hKdWs2?=
 =?utf-8?B?cExTMEpCVTRsMlNId3lOdXRpbzg2YWJpZmdWa3BMVHh1eU1RN0ZHQjZQN1ZB?=
 =?utf-8?B?YTlSampvWW1YOVQxcnFhZ0VFYXVBb1NlbUp4RDRmMTVKZ3VVR0dYbXRJSlI0?=
 =?utf-8?B?cDBheTJFeklOeDdVMHZuWGtpQVlYTy9TS1JEMDk0RjkvWEVNbmpBVDZwZ1Jz?=
 =?utf-8?B?b2FSb0FiZXB2dXg2YkQyZWZ5VHZjRElXT2lxaE5scXlsTFd5YXhkYW9QaXRF?=
 =?utf-8?B?Z1hiVk8vNnBSU2xvZ1hFcGZFbURXNDJpZndIbnozekpQTGNraEJpRE9qQkMw?=
 =?utf-8?B?R3BKSTlHbnRMUDlkeGxDVUI0NFFxbXZnOVNLVllEMXRtblRJQ28wbkxvdlpV?=
 =?utf-8?B?MWU3SHdpS1hQdlRWcE9HZFFMRDlvdFFXcjJWSTBFWHQ4d01idFkrMHNWT3kr?=
 =?utf-8?B?L3FhSHJtWEdBYXk0VjMxTVpOVXJqL0IzZXlMMEpSUjNNaTUxNnk2ZEtaWWQ1?=
 =?utf-8?B?ZGxCbFFyYkd1OTdXTU9Cdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VldTZ2ZORWxjbWErQ0pZWmExQS94YkdscldZQ2toMVRyMFF5L3FRM2E3OW1a?=
 =?utf-8?B?UTR1Zk9NQTJEV2hiWXUwZEhGVXJjeEY1b3VqNW5JOHFUY3ZGVmVsRjZISEpv?=
 =?utf-8?B?eXlJTitkbnUwL2pEU2hEZnpWZS95MURjSmlRUkVnRW1TZDF5SGppd05aOGpm?=
 =?utf-8?B?c2JTSjNZZDBGWGx1MGF3LzhSaEpyS1RwNSszeGJjalgzbVJaQ3R6SUJJdExh?=
 =?utf-8?B?eG1BTk9GK1BiM2FhZGp1OTlhZi95ZytpU1pvbEwxZWRVQ0NNeXlUYlN0eFg2?=
 =?utf-8?B?dkU5ZkE1eDFEVmtwUkFwMWN2a3BUaGp2eXJOM0hnU1cxTTdqeEZ0TU1LajlN?=
 =?utf-8?B?NmgrV1hFZUhQWFNoRnBIZ2tjWjh2SVFiZURySnRHL3laNzdIdWI4WDNuUFdk?=
 =?utf-8?B?Uk5tdVJoV0FTZTdPYjhGNi9VQWt2S2J0a2VKY2RxZHlXU3lMZnhJZUI1UDRO?=
 =?utf-8?B?Q0U5RnA3WGJvbzFOYTYwZnVEbHNEMkVYc0tLdmRKemVQbVk2SHpRZ0pkVlla?=
 =?utf-8?B?dGFEa2hCcEpPMExmYy9UNEdlbXcwYXRPWW44WmlmMzY2Q3BRbXF6S0c2KzQw?=
 =?utf-8?B?UVZXcmNPR01mazNyOXMwalMrcGo1aytuRHJ3SHJNTVVINUN1RWxFMUVZZWZn?=
 =?utf-8?B?VEpCc3lnUkxTTitoQ1JJRFBkT3NwSzh6aDRNM3RwMEhtWjY2SExGcWNDeXJm?=
 =?utf-8?B?eUVHTDN1ZHZIajNVU0tUWm1WMjEwc2NqMS81Ym95SXFyOTNUaGdMT25YL1lR?=
 =?utf-8?B?VFpXWHZzekNEVi8vM2xlWFNiSzB2WTFWZDF2bFVqNE5vWlovVSs3dnA2WDhB?=
 =?utf-8?B?a3ZIVFRSamJpelExNlhoVjdPUWRpTGNxcWo4ZUVpLzZuczExR291U2RnSXBu?=
 =?utf-8?B?R3l2RWhzZytMWHI0RUJja0VlUDBLbC9lVmdFL0k5c1Z6RCt4c2hYZWI1bzZP?=
 =?utf-8?B?VVZpYkVBUXQrS1RyQkxxQ2hOemlGMEZFT21IY1ZyMnNWV2g1U3VUMDB0blk2?=
 =?utf-8?B?bTFkbUZ3Rk8ya2hmZU9Ga25sUTBxaFFyQm1wbEFlTEhnRXdaQjZIeFhOVEVn?=
 =?utf-8?B?Y3dmaFluN0JhdDJUaVpWWmlENWMxQ3d5bEJ1VzZHc2RoS1liV3R2bE9sMDRk?=
 =?utf-8?B?b01KMXE5Z213UnlBOTFHVXdlMC9VaTJwS2hLZG1scG1ZMnBEZGpJN1MwYzh5?=
 =?utf-8?B?Rm9wOHpCNW4xV1JaT2tnVVdaWUNFSndjcmdNUVd6ZTM3Y2xnUytaLzYzbXV2?=
 =?utf-8?B?TzB2RTRKS0VucTVHU2k4cVpRajdTTlFxNHd3dHpkTTd6YXA5VHpkSzY0RzVN?=
 =?utf-8?B?TkhQcHkwbi9qY2hWZDZUR0czQmtZWERrK2cvTWVVbXdmVlJ4cWthL25saUEy?=
 =?utf-8?B?TFRhMUE0cUxWT21yeDMvZjFqQmd5RkE5QW9tUFQ2VFR6UGlVVmMwWTBOVDdv?=
 =?utf-8?B?eW0xOWdZOEpVTUN0VkdZWWNQcnJHYWlqSGNua0dmL2lSSWk0bzNuNmFpWWVY?=
 =?utf-8?B?ZW1NWSt4U2p3cmR1WlIrRmxoMnA1Q3drMkpibkk3Qm43RTNkdlFVSFptajM0?=
 =?utf-8?B?dEszUUR5bXBqUTlPQk5OM3prVm1QcnppbGpIdUgray9tOGN2S1lrMkF6MWRM?=
 =?utf-8?B?R05JbGVLOXJ6R0xGRGF6V3gwRnRuNVhndXBJWWxEN05Vc0VkeEdTUDBaUVNX?=
 =?utf-8?B?Tk9OR21PNHNuNkFpVzlEZkQxRmZUa01jMk5JZFltbVJKeUx5dzNCdjQ1VERo?=
 =?utf-8?B?bmVYay91d0RjbHQxWDdLdk9RTFU1U3ZSbzhxSm9OK0pmVWQ4U1FZb3VIUHVn?=
 =?utf-8?B?MHgrUHhCQk04OWpyQ1Q2OWtEVXdmMnF5SmxvY09UOWY4bE1tdXZwaFF5SU1T?=
 =?utf-8?B?Y3kvaHczVVdFdGtjYW1wNy9MYnY3aHAzUXNQZHgwOGJrSVR0SUZ2Y0x6ZjU5?=
 =?utf-8?B?KzFhTXJ1ZUFpbUpLOXZ3di9samhCM1dJN1BpbmRqT3QvdStUV1U5MnZtMXIv?=
 =?utf-8?B?WFdOVThSM0I5MUplTCtVdFllcXMvSjBnM2ZuRXIvOFp3U21HNk1PbFZrM29n?=
 =?utf-8?B?cXBJNVFvem50U0t4ZGFiaG5GQlBkeUpyRTl4YmRiWjBxWFdmTVEzVEFxWUov?=
 =?utf-8?B?KzZYWm4rSGZIU2lJOEozT011R3hDYnNYZC9NcEp1R1RSS3NrcER5NFVQN2JO?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ade5b6-c553-45fa-0620-08dd19339401
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 15:59:07.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lARlK2zTrlQCQiNgNPvjAhLNiRiNdVOIaxMlOGoGxph2h2SxQErYW88fOvWpcbMEMAn1LFSMb8/OzG57OE9foBsg712gMcfL7PSiBR6Giyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5886

On 28.11.24 6:37 PM, Conor Dooley wrote:
> On Wed, Nov 27, 2024 at 05:42:17PM +0100, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> This reverts commit 27866e3e8a7e93494f8374f48061aa73ee46ceb2.
>>
>> It turned out that this feature was implemented based on
>> the wrong assumption that the SD_VSEL signal needs to be
>> controlled as GPIO in any case.
>>
>> In fact the straight-forward approach is to mux the signal
>> as USDHC_VSELECT and let the USDHC controller do the job.
>>
>> Most users never even used this property and the few who
>> did have been or are getting migrated to the alternative
>> approach.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>> Changes for v2:
>> * split revert into separate patch
>> ---
>>  .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
>> index f8057bba747a5..79fc0baf5fa2f 100644
>> --- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
>> +++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
>> @@ -77,11 +77,6 @@ properties:
>>  
>>      additionalProperties: false
>>  
>> -  sd-vsel-gpios:
>> -    description: GPIO that is used to switch LDO5 between being configured by
>> -      LDO5CTRL_L or LDO5CTRL_H register. Use this if the SD_VSEL signal is
>> -      connected to a host GPIO.
> 
> Your driver side of this, that I wasn't sent and cba downloading an
> mbox of is not backwards compatible. The code has been there for a few
> years, are you sure that there are no out of tree users or other OSes
> that use the property?

Yes, this is not backwards compatible. I introduced the original meaning
for the sd-vsel-gpios property based on some misunderstanding of how the
hardware actually works. Therefore I'm quite sure that except for the
cases where someone copied my erroneous implementation into their
devicetree, nobody has really any reason to actually use this.

In-tree all users have been removed (one fix still included in this
series). Of course we can't be fully sure that there isn't someone out
there having non-standard hardware (SD_VSEL not connected to
USDHC_VSELECT but to GPIO only) and using the old sd-vsel-gpios, but the
probability is very, very low.

IMHO taking the small risk here is better than keeping the misleading
implementation which will likely cause confusion and failures in the
future. But of course that's not up to me to decide.

> 
> tbh, I think all 3 of your dt-binding patches should be squashed rather
> than drip-feeding the conversion. It makes more sense as a single
> change, rather than splitting the rationales across 3 patches.

Ok, if you like this better in one change I can squash these for the
next version.

Thanks!

