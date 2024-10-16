Return-Path: <linux-kernel+bounces-368515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0809A10B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1191F22A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4508212624;
	Wed, 16 Oct 2024 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="jArNPyf3"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2091.outbound.protection.outlook.com [40.107.22.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D404617333A;
	Wed, 16 Oct 2024 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100003; cv=fail; b=S955wGgL9a6j5BzgUvxZtUWIo8hbyXE3usA+OvS7FNVKbq+XyuBpVvXMaVD7OicRq4/y8z7fFw+TfGc15Va5bINrq5COwm2zt/LoIt3TfDHjarOQCO1EJTZMbRQ40zW2XqkTvSA7g7n4J6b5Gx+cTYvqqjL32PgVPYiOWLGdQJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100003; c=relaxed/simple;
	bh=kJFu1aGPOAEEhJZx6l50P+tLtt3jnNhHrInd26DN2S4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FwRMO+WfPfTyc9fhHkNoRvhL9fCJvLCskrl/V9XvSmkucswDxtBNmQDUcShw4snoKFpVzmDz/nqOwsRlWL95orU9FUkodHtZgdsDmDe2YypMlkRL+TDdDhYRsi7rqd3w/JVF6TgUBKWrn1CHvvmjUjR7R6X/ohAglfuMoi2yqGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=jArNPyf3; arc=fail smtp.client-ip=40.107.22.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlIwlL3QA/q6NzG4mJTwu65oYgemLSf7466tU4YNbPOB1lWvnm3zEJKoJxPnMi3IE4qob2Oz4+VwxEi8b8TB+H4K0qQGLShy7T4a5jFHxmO3lOiTGyxp3wT4t1FUcRQG5xy1+5teroEsc8P8FpqmYjIWM1KyfAL+gkqxGYtw2MvFusfwwa79fUdbwelNushjhaWoIMR9gdYmNHO16ntcaL2FM4buVlYLNAn5BVIViJ0quRGSm9HKuu3xoGeWA5EAnds/JLLFO0GKNy/P5G2+me4es0Z+gsCQvIUP7wVtFFGgVNQzHl3a6uzxA4uMjkt/GXwgWqyT8WLPbHP1VD8zjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KypmDt5nVWEed5RSFGvMROhOUDVAguDyPo/ccJIpXoA=;
 b=XDIFqoHzs/PJeKek9sS1VLVstHpAJqIR6ObtfdzB6NrnOvUPAq+AUlm4ZGrL8G5B9lnxdvJeolGjONfb9OmaEbXTx0m9OcBZsIHypL9y1Pkt9QetbDn5YBF7Xnfhhdz+vnN/ghvaCsy/bT1kmrj8OeIfMiSJMEPWJ9TNB5QVVk2JJzkbbtEx0zjX/b9hQFdckLYivtn0uthBTLVMoa4ZbJnAb/sNVsRx550S+HoEHaCgMa7wxcCGad3h8GxOdw78oIisPLZiO/tIltbePT29aho5CZ1nluKXTquY1lGNnRi4ONab3zieVwmB9xoRwQO6yTQ8otCaDnXsaHGfE6+YUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KypmDt5nVWEed5RSFGvMROhOUDVAguDyPo/ccJIpXoA=;
 b=jArNPyf3KPPVXk8N3kUiGsvpNFRJuHcn6m9X4WvegrfNF4MUdkUXeeK0HPrm/FtjUJ0KwxjTH7/V0XAayIs3x9T6I70/BBWO8eh4LVsMC43OBecFRy8Kj1tiy78FpKjwr8d4B0c2BqGhBCHJo5gb1gWd+VpS8UITO6HCuHnX5kzo99VCRXVmIEJVtTs3uEIHBTFzofrAQFkQJL53jNZ2ZaLHzEQ2Yhl8Z6CE8QM41ChWZ68l9afHfYP8AWSwWDZt9anMEks8H2k5El4p5NVy9wfhL72OEdGvV0ldD2gwqm0Kzm0CuXehxlfbcOB/mKeyjhMuYeKA/tna1DeNPsfNVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DB9PR08MB7512.eurprd08.prod.outlook.com (2603:10a6:10:303::14)
 by DU0PR08MB9486.eurprd08.prod.outlook.com (2603:10a6:10:42d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 17:33:13 +0000
Received: from DB9PR08MB7512.eurprd08.prod.outlook.com
 ([fe80::fd8d:f047:ac4f:6d6]) by DB9PR08MB7512.eurprd08.prod.outlook.com
 ([fe80::fd8d:f047:ac4f:6d6%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 17:33:13 +0000
Message-ID: <2cbac0a6-08d7-4ec1-8f19-0fc009a34705@iopsys.eu>
Date: Wed, 16 Oct 2024 19:33:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: mtd: Add Documentation for Airoha
 fixed-partitions
To: Christian Marangi <ansuelsmth@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
 upstream@airoha.com
References: <20240925101422.8373-3-ansuelsmth@gmail.com>
 <20240925133003.619c40c4@xps-13> <66f3f58e.5d0a0220.5d655.b48a@mx.google.com>
 <20240925135256.32d3a0f7@xps-13>
 <66f3fcb7.5d0a0220.3ca4c2.ba83@mx.google.com>
 <20240930114819.609f9341@xps-13>
 <66fa7915.050a0220.1da288.aeca@mx.google.com>
 <20241001104225.67483dab@xps-13>
 <66fbcee8.df0a0220.2ad0cb.4f6a@mx.google.com>
 <20241002100006.5995fd10@xps-13>
 <670f6c5e.170a0220.373da5.7bb7@mx.google.com>
Content-Language: en-US
From: Andreas Gnau <andreas.gnau@iopsys.eu>
In-Reply-To: <670f6c5e.170a0220.373da5.7bb7@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00003849.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:7) To DB9PR08MB7512.eurprd08.prod.outlook.com
 (2603:10a6:10:303::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB7512:EE_|DU0PR08MB9486:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c760f2e-9e4d-4a46-6e28-08dcee089c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OG1pU05GbXZhL2Rja3IveVRBUE5KaEswTEc5cktRTGg5ZWt3dFR6STlJS3Zj?=
 =?utf-8?B?T3JUZE9MQ1hxTmJ6UlFaVDVQTmRaY05kSjdPWnZNeHVkUHBZS2RBVUczbzRv?=
 =?utf-8?B?RUdyR0ZQczQ0a2FVMVdXd3ZHNnJWVFh1Yngwb0pKaGpjNnNRNUx5Q0hhcU12?=
 =?utf-8?B?WTVtbUhiZFM0dEhhZnR1ejZqdk10QUx0NlJjQm0vT3JMcHVFdm1OTzJpTU9F?=
 =?utf-8?B?UWRRVEw3YkUrM3JsR3ZKMnN2VlZSRnVZSlVKcjN6bDNGMjdGN01qOTZZTkdH?=
 =?utf-8?B?dllrQ3MyQ3JvUXRrVWhmQ2ZPcGVvNXlObzdUUUNEdlQrR0hxU0FFOFBZdk1G?=
 =?utf-8?B?cDFGa0h5R0xUWmgybHYyWEJYTW1vV2dGTEhvcG9MVGNTbUh3MjE4K1NVWGsy?=
 =?utf-8?B?VlNGY3R5U3gvNWtHVHI2UVU0dHNRb0tJMWEzdU1lYzY4OFFuUmRNR0YxZTNB?=
 =?utf-8?B?QTIrTmp4dE9VYnZoRGJ6ZzFVMjNyZ2c4bVAyWDNoOEphQU84REN6ZStBbGQ3?=
 =?utf-8?B?QWxUbXlpK3ZHR3d2Z1REdEllakpiemVUcEU2SHhkSU1LRWR3aG1kV3BCR3BH?=
 =?utf-8?B?U3FFYXRNOWtKbzczdW83b0JmM2FYSENoUkJKQytjUUlackw2ZkhBSmVBOFRL?=
 =?utf-8?B?Zk1SdTJEUnZCY1lwWXVXcWVqZHJQZmpyMlRWazZ6ME9NYVhzU1d0dVZjUG0w?=
 =?utf-8?B?ZFptbURwblZkZ0RtTnFVUnR2MXYzTVFUekJJK3BEQ1JGNVNLLzhYMFF3cWVD?=
 =?utf-8?B?cHY2bkVDR04ySVRMU1o5U1FwQlJhMEY1V2FYU1Qxa3NsTlFkbzFpU0U5L2VZ?=
 =?utf-8?B?S1phVitzNkllYll0RWdBcWN3cExNYzJZb1FuYUFYUWNQbmpjK21oeFBhWGtu?=
 =?utf-8?B?am52UG1RZlg4NWxOT3Rmc3A1WlJwOU5nbjcyYnZzR1FhQXpnUEdxNmlnTFBh?=
 =?utf-8?B?cTRNWFdUWE5EVkVzYVU3bHBTTXkwUy9iM0RId3JpMVlZSFliRHFpQXdZcWp2?=
 =?utf-8?B?VzhBWnd1WWxLYXJQa3lSTVYrNGluQ2xZa0JDUkkvTlJ3QVRZTTZPRkVBSUNa?=
 =?utf-8?B?SUt3Q24zNzhKc1dPZHpkRUxZR0lhWCtRbmpIbytoYnFQTVlOWjh0V2twdTVR?=
 =?utf-8?B?ZFRHYk40VFA2UXREV3AvbThoRCtHOU5yeHJLKzlqUEYwaUFBYWV4bUYxZGtq?=
 =?utf-8?B?UEZtbzlSdFU1bkhTbE02UUVGMUZoRURFa0Z4cFpsSk12WkZsU29ZZHJFR1BR?=
 =?utf-8?B?UjF3WkRIU3hVQ0M3cWJjbXIwRmFsWlJFOVJRZEZWMEFaMVEvcjV2WDNQYnZM?=
 =?utf-8?B?NERsb2ppRm9VR0pMSzBUN2xLWU52anBFY2ZrQTNwWEJ2Ri9ZaTl3ekp5UEY5?=
 =?utf-8?B?TEsyTkx1dlFLVHJOdkUzcUdqRkNaNnU3NUcwNERaZmttN2xLUGhqbTZmeVNZ?=
 =?utf-8?B?T0JHdzhXKzRXSkNjRWhHa1FHb2hxcE56c0Fvb1NRdEI2aUJQVDNQZ2FoMms2?=
 =?utf-8?B?RW8wUDZLQmd5aEN4WXhKTTN2bnNaRGI3TVdZYWRobUxyMjJ4NmdYM1Z0MXZ2?=
 =?utf-8?B?bVB4U2VFeURsbzFMTkRiK2tIa2k0RFZ5Q2RZelk0d1I5b2xZMXNLUW8yUURD?=
 =?utf-8?B?dTFIL0Fvd2NJOThETzJBc1lKUEtyalN5dXlGSlFnZVhBSDhlQ3duZW9jdTh1?=
 =?utf-8?B?RDFCN0lVZXluditBS2tiSkZMOXRQTk1JVzcxbkxnTURsOHpxTnFiQnZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7512.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXkvRU9CL05Qd2toVFBVTVN5ZjBiZ0xzSVc5WjlNY29XY3BIR2lLUnd4ZkVD?=
 =?utf-8?B?OGxsRVRwV2M2VER4TDRBS0RzNVJhbTlmYVZZQ0ZETGYzQklGSVpDeGd4aVNO?=
 =?utf-8?B?T2NKOEdqYis0V1ZUemozMTlEMnlQaHJRc2QvSDFuZ0tQYkR5eDM5WDRUQ3lY?=
 =?utf-8?B?SW5ZWkQzWVdBV3RsOVFEbm5TWWRxVElCdFlTTXcrRXV0SzdmUlNpSVJJRzRO?=
 =?utf-8?B?cldxQ3JvQUU5REVGeXV6SW05djZjYUZveHBnNVNmOGpVMFJNbVJEdXUvU01j?=
 =?utf-8?B?VjQ1YjdjWklqY1Q3cXREUDJKOXJOVjJnblY3UWxFZE00WmxRS1lWeERGbkxt?=
 =?utf-8?B?SDc5eDAzd3hSS2JYUkxmZmExOUU3R1IvUVRJVTR6aTd0bHZ6ZnBGTkJxT3Ny?=
 =?utf-8?B?MlBzcmRwRkN3c0NHVEdESmhpZ1hOeXM0NkxBZkxtb0lJLzlnMDh6b3JxODZy?=
 =?utf-8?B?dDcvc3p0ektNZndrT2lPOU9oanhhVzNkR201RGoySDJkZ0FLbHU0Y1VoOUF4?=
 =?utf-8?B?M2R4LzFVWHNHMEpUdEdESTd5ZGpxMmpOSCtCMnEwdUZKSnM4d2NJM1hzL0hm?=
 =?utf-8?B?ZEdIT1dKNEFmU1dldExZOGk2OW84VHorL05VakI1S29zakNQdzFUbXdZbG9m?=
 =?utf-8?B?T2d5U3daM0doaUE5ajhKTHNUR1I5UG1XaDNXK2dYb0hzQllaSE1oV1lrK1V5?=
 =?utf-8?B?NVpwZUV0MlVRUWtQYm9nWTRoUXdtL1Mvd0QxNnA1OXpqcjN6S09PUk95Nzlk?=
 =?utf-8?B?TElVTTF6aGVheklwOWVFdVNZbkJ5eXFMdEJ2U1BmTDRmdXFlaGF3UG13eGZW?=
 =?utf-8?B?bzVhcEVqMzRzWHFxZEkzZWFVNzQyL1BCMU4rWC9jNmh3Rk9tZ0l5aEkyZUsx?=
 =?utf-8?B?VGVvSUlpQnhRM3I2U3M4dXVFTUtFU2hsSzBNdlFUWXVUTTlxY05mR0VhdTJa?=
 =?utf-8?B?eGJMdU9ZMnRONklyVzBreXArdng3aHAvY1JBZjVZVzl0dFRkTFpVZ1dVZzNW?=
 =?utf-8?B?RVBGZjZGdVpmZ3k2OExvWTkxSkxhamliR084S0tIRkorNWlPejZWSGFEZVdT?=
 =?utf-8?B?akpqd2Ixdi85ZDVXNHhzcUNLYm1ZMW5ZVm9DWTZ6OUsyczBxR3VjaUllRk80?=
 =?utf-8?B?a245M1RML3hnK2tJVEhsaCtpbThLOGJkZHJXbXByYlVsaSt0dzFwRG1YN2ox?=
 =?utf-8?B?N3BMVFJIcnZTRkk3bnF1aE9qNWVqZUlQVGdpWlZiMFM0ZHlqNjFVSEFZNW9k?=
 =?utf-8?B?VmMrSzBYOHExL254NXRyWlJETzZ0bmJYcWtBOXpzaHhsYTVTai9Ea0Y4SS9i?=
 =?utf-8?B?TWRLZUJHYnpXRXZjek5aSUtUNWV1NWpKeWNIaC96Y3hZaTRmY3FCSlZyWlho?=
 =?utf-8?B?TTRpSW95WDNEZWRnTStKU3hDNzZlbS9zRjlRY0FpTm4vUHZoYTNkZ3pPeGZt?=
 =?utf-8?B?cEdremFYL05tbHd6cjZqdW1yYnRLblhZSldGeVgvcU9Nck9ZTEFIdlZPdm5k?=
 =?utf-8?B?Q2NjS2YzUHRHSHNWbWx3N2V2RHBrVmVhZzRLU2xVMU1hR2FLaGxUcFJUaXE5?=
 =?utf-8?B?amhOSGVCU052YUJnMk15ODhLcVNWa2xDMExJcTNydGg3K3E1M3kzcVpHS3hO?=
 =?utf-8?B?SVhtTElFQXg2QTVmTGcvZHdjWkl0Y2U4QWlLMTVjb3hBb2NPbkY2VzlrbkRK?=
 =?utf-8?B?QWJiMVcxMkE3S0pYZFM5UmUrelNOb3V3MEZERXBLWHE3dC9XeG92TjRUdDAw?=
 =?utf-8?B?U2tiSXJqd0Q2alptSTU1MW14VGhEYk43SXNsQ3hYWU5uVmcrbXIrc0dTRy9w?=
 =?utf-8?B?Tys5UjNhR1lBZmRoU0dWUWZud3ZGMncxdWFXY2RsT1d1dGNvcU9PdGNjQ3do?=
 =?utf-8?B?RWsrdisvZjVEUjhJdnB2VnZXZ1ArY3hKVWtiOU5oT3lKYkRMZStUcUhzbm9U?=
 =?utf-8?B?R0tNaXdOQ3lCc1I3RkxpeWZVbjhBbVh5N3dScm5hOU9sSHNLWHFjaWdST2pP?=
 =?utf-8?B?K2Y4aTA5a3FOS0RQYlJVczh5UFgydWlGeTlUWTBXVm1IczJhbkpOTmJDZUFH?=
 =?utf-8?B?bW9FYXJKeFJWTkp2bUtuelZLWExwYUs3c2tHNFJNU1lsN2FzZ3oxN1hBMVQ4?=
 =?utf-8?B?YXA5c2ZkNm1aWXowWDlVbTJPZW9OdkJ5QWw2Z1NObGJ0c1psUmtWWTc2RU9R?=
 =?utf-8?Q?fZgRCZWfu8AeAqZEJUBhJBE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c760f2e-9e4d-4a46-6e28-08dcee089c2c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB7512.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:33:12.9138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/XTWxJzV1CuWHP9kI1z5i046def5Y+nyLj62/nLJfMJTx+SBsOoVbOUZXauhUfWsWiPmbwIF/CPftxNmGMY+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9486

Hi Christian,

On 2024-10-16 09:33, Christian Marangi wrote:
> On Wed, Oct 02, 2024 at 10:00:06AM +0200, Miquel Raynal wrote:
>> Hi Christian,
>>
>>>>>>> Ok probably the description isn't clear enough. The missing info that
>>>>>>> require this parser is the flash end.
>>>>>>>
>>>>>>> Following the example we know the size of rootfs_data and start offset
>>>>>>> AND we know the size of the ART partition.
>>>>>>>
>>>>>>> There might be a space in the middle unused between the rootfs_data
>>>>>>> partition and the art partition. What is derived is the starting offset
>>>>>>> of the art partition that is flash end - art partition size.
>>>>>>> (where flash end change and is not always the same due to how the special
>>>>>>> bad block managament table reserved space is handled)
>>>>>>>
>>>>>>> This is why 0xffffffff, used as a dummy offset to signal it will be parsed at
>>>>>>> runtime. On second tought tho maybe using this dummy offset is wrong and
>>>>>>> I should just have something like
>>>>>>>
>>>>>>> length = <0x300000>;
>>>>>>>
>>>>>>> Is it clear now? Sorry for any confusion.
>>>>>>
>>>>>> I'm sorry but not really. You know the end of the physical device and
>>>>>> the size of the ART partition, so you must know its start as well?
>>>>>>     
>>>>>
>>>>> Before the system boot we know:
>>>>> - size of the ART partition
>>>>> - real size of the physical device (512mb... 1G... 64mb...)
>>>>>
>>>>> When the physical device is probed (nand) a special driver is loaded
>>>>> (before mtd parsing logic) that change the physical size of the device
>>>>> (mtd->size) as at the end of the nand some space is reserved for bad
>>>>> block management and other metadata info.
>>>>
>>>> Here you are explaining what you intend Linux to do, right? I would
>>>> like to understand what you are trying to solve. I dont understand why
>>>> you need the size change, I don't understand why you don't know the
>>>> start of the ART partition, I don't understand what the data you are
>>>> hiding contains and who uses it :-) I'm sorry, this is too unclear yet.
>>>
>>> Totally not a problem and thanks a lot for you keep asking them... More
>>> than happy to clear things, I'm trying to solve a problem present on
>>> Airoha SoC and upstreaming a correct parser for it.
>>>
>>> What I'm trying to solve:
>>>
>>> Correct access to this partition at the end of the flash in an automated
>>> way.
>>>
>>> The content of this partition is the usual ART partition found on lots of
>>> embedded devices. MAC address, wifi calibration data, serial. Usage is
>>> NVMEM cells and userspace with dd command to extract data from.
>>>
>>> Airoha use something also used by some mediatek SoC. They call it BMT
>>> and it's currently used downstream in OpenWrt and they firmware. This is
>>> also used in the bootloader.
>>>
>>> The usage of BMT is a custom way to handle bad blocks entirely by
>>> software. At the end of the flash some space is reserved where info
>>> about all the blocks of the flash are put. I'm not 100% sure about the
>>> functionality of this but it can relocate block and do magic things to
>>> handle bad blocks. For the scope of this change, the important info is
>>> that after the BMT is probed, the operation of "reserving space" is done
>>> by reducing the MTD flash size. So from the MTD subsystem, it does see a
>>> smaller flash than it actually is.
>>>
>>> The reserved space change! Across SoC or even devices but the BMT is a
>>> must where it's used as bootloader makes use of it and writing to it
>>> might confuse the bootloader corrupting data. (one block might be
>>> flagged as bad ad data moved, BMT driver validates his table and do
>>> operation)
>>
>> Ok, I think that's way clearer now.
>>
> 
> Hi sorry for the delay, very happy this is better now.
> 
>> So the BMT driver does not exist in mainline Linux, but you would like
>> to skip this part of the MTD device to avoid smashing it. And it is in
>> use by the vendor Bootloader I guess?
> 
> Yes correct, idea is to permit easier access to the partition. I hope
> (and assume) this driver will come upstream.

May I ask for a better understanding what the "complete goal" is? Is the 
goal only compatibility with the Airoha ATF as it is now? Or is the goal 
to read flashes that have been using the Airoha SDK with BL and Linux? 
Airoha bootloader is just software on the flash, it can be changed to 
not write BMT, which we have done.

I am asking, because I consider this BMT to be actually detrimental when 
used together with UBI. Wear-levelling on the UBI side is no longer 
correct when blocks can get re-located by some other entity below due to 
bad-blocks.

We have patched the Airoha bootloader components to not write BMT (and 
of course our U-Boot fork and Linux flash drivers do not use it either).

Before we had patched the bootloader, we had initially marked the BMT as 
bad block, but if I remember correctly the BMT location might also be 
somewhere else in case the BMT block itself is a bad block, which is 
also the reason why we went the safe way and patched ATF.

Just putting my thoughts/experiences out there, mostly because I am a 
bit concerned to about the possible double bad block management (UBI + 
Airoha). You might have more insight into things than we have about how 
exactly things work. So, maybe it is not as big of an issue.

I just think that this BMT can create a lot of other issues as well. And 
maybe, I am a bit of a burnt child dreading the fire because of learning 
about this BMT and how it works step by step the hard way. For example, 
we had an issue where Linux and U-Boot had support for a NAND chip while 
ATF would mis-detect that 256 MB NAND as 128 MB and thus destroy data by 
writing BMT in the middle of the flash. Fun times...

As a side-note: We have also migrated some customer devices that had 
been deployed in the field with Airoha SDK BMT and drivers to our UBI 
flash layout without BMT. Strategy was to load relevant data into RAM 
from Airoha U-Boot and then chainload our U-Boot 2023 that would flash 
everything back.

>> Is it some kind of table that is written by the chip itself in order to
>> maintain a list of auto-replacement blocks for bad blocks? Can the size
>> of this table move with the use of the device? (if yes, it's
>> problematic, we don't want to resize MTD partitions without noticing,
>> it would break eg. UBI).
>>
> 
> No chip hw bad block is disabled with this implementation and the table
> size doesn't move/change so MTD partitions will stay at the same offset
> after the first parse on boot.

If the block that holds the BMT goes bad when BMT is being updated, 
wouldn't the BMT location itself change? At least that is my faint 
understanding (which could be wrong, of course and it has also been some 
time...).

>> I believe this BMT block is going against the bad block handling in
>> Linux, so I really wonder how one can use both mechanisms in a system.
>> If the BMT layer takes "one random block" to map a corrupted one on it,
>> it totally defeats the current bad block model we have in MTD/UBI
>> and simply cannot be supported at all. Just skipping the
>> currently-used-for-BMT blocks sounds like a very bad idea that will
>> break your system, later.
>>
> 
> Well we disable it and since it's reserved, from the system side you can
> do all kind of magic since the space used for the driver is not
> available to the system but I will try to gather more info about this in
> the next few days.
> 

Best Regards,

Andreas Gnau

