Return-Path: <linux-kernel+bounces-242384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D908928766
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1565F281D8A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B921487D4;
	Fri,  5 Jul 2024 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="eTISJ4pZ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2122.outbound.protection.outlook.com [40.107.20.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032C1465A3;
	Fri,  5 Jul 2024 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177244; cv=fail; b=CjcOzEP1SwNuKZ2WZIYWa/6k3jajX1mGgdKPgjlSTsBt8JpRv9YA8+EM5xLOB+9Au7H79eFLfBegYiP2czhXdCMrVIalS5ChT5ItidASs7Cfo3daj7MpZBiZn4Jov+M47Ts/tJ1iB5WbVGfKevvTM553WEgtq9HUomiFE/4f/Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177244; c=relaxed/simple;
	bh=QtWkyR75vn4mCEW5GWB+CU1ijz9b/+TKfujmSRZsk34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i6MRlRVPhMuZyNorEFcBLfcPYv0ZVXBmLrKctGaEOBpAycjT0AFYatlzqlGkBoKLzsnuJDDL1B49zHQ0PkZ97GnvtnuHBOYe3u0K3ofClYnFlpQCu64pHVuIhu/wuNY4rkAUGEtOGZ2HQcV1id1kA9InTFAlTJivNslsExqdwe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=eTISJ4pZ; arc=fail smtp.client-ip=40.107.20.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsQ9/Ma2g1pBrlT21eXkN8NNQzX1R/Oc17ac0XyWq2lZOENFwMs/zAjuRUUgjFLVs6Z2A9N1NZFYKxF/7z2yLNGLQ34CWAwW1d/DQki105M0gTsYAFLucQftzhgqNJwfEa+2ncdtP3OvZpJlr9BURsqIBN73pOiuR9B8iFWx3GeqhFwUfFkgP9utPiNxrXEH43R2hD+Y2uElskT6yhs0DRKWqIoF7WniD9GlI+DDLlm2zVgSYcY9UaN9e+XJ98oofIUIgf6ILq7q76cWzOAwkhfqfJ+VD6DUqtj2m65dy3tv6/+etHT9AkN7Ws1asNEPZ3vfmmNu5rznviiFcNDC/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W5xrRyzRCq6lQK/iek88rlSlUxVsoguTmLuOMQIgPY=;
 b=R+ARkQkXMV13BcMALH3pWleJA5HH6NyE7cR+jWOgp5O+JXt/mBbLYvr9csd8f2+liOVHk26daf1ItInr/XD0y7YKaGMReR+cr5+NWB8ANyNaQTJbH4sLYAjOy9LqsLjgTARJCQT55hrMHgyq5wVE4QY4/RZz9SN/VbpfX8B7Qh16DHdruUSbiVSXxjBFUmI7HSSxryGNT4ozvQup6E5FlViGfXPuwmu5iSogE4oUaP00E1jYQhNYQ99ggSJBZc0JXxk9rIg6pQTlNt8z+037yVDbYGeM5p8w9+JC6jaY0ivedUKEUqRIR878vyoPe1jkxyB34a4aYG+mzRc8qmscxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W5xrRyzRCq6lQK/iek88rlSlUxVsoguTmLuOMQIgPY=;
 b=eTISJ4pZjiqj0ni2Fh+W9UpvZpUNofcxu/3aw8eyd2xw0sxi8CXA1ax/fpSfIrMizf37Oa6iopbUOnnqxhWLLo8whCwg1EsLknCWoNWRZIDjUjgQrTFSe0vts9WmUHF6Ef3D7Hz1ZZGrW8xK4AnMdGw8Qs0fsfRaZqsphVw1Rbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AS8PR04MB8417.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 11:00:37 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%5]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 11:00:37 +0000
Message-ID: <9f4abd56-d095-4c51-b026-8a6640ce1e0a@cherry.de>
Date: Fri, 5 Jul 2024 13:00:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] hwmon: (amc6821) Add support for pwm1_mode
 attribute
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240704175207.2684012-1-linux@roeck-us.net>
 <20240704175207.2684012-12-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240704175207.2684012-12-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::26) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AS8PR04MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 756e3c78-0bac-44bf-ceca-08dc9ce1b369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0pmUjJaaFFxUFQzQUU0Qng0RlZJdTZBRTVOOCthUzdnQVlNSlk1U0VQd3NG?=
 =?utf-8?B?SjZ1WmpkQkdIS0Vnc2FVQWdXbTBqVi80YXZjbWNCQ0dhcy9xeVFHcnlTQ2RD?=
 =?utf-8?B?MUNHVjU1S1MrbEFSVHY3bmFsR2Z2REpRTGVVTDNyS0xjenM2NjJYTzVUZWcy?=
 =?utf-8?B?TmhkTTkyNHM3ZlZIS1c4UzRNRlMxMVVlYWFvN0xpWGxiczlGeXduZTV5RmFv?=
 =?utf-8?B?amdDQTRmMmVLbThtZ0thRzBrR1QxaTRDZ1B5cnAwUUl0NUhlUEZVYTZ3aTMy?=
 =?utf-8?B?cE9FVnRyeit4dnNLekZhMTdadTErd2Z5bDVsT2Z3RzlzOHZQRnc4aGJaM1Bo?=
 =?utf-8?B?SnRxcHg1akUwM1g0YTQ2WFVJWSsvSTU3aFRSQ0N6RGt4bndNOXgvVlJHRDB1?=
 =?utf-8?B?SU5YYXJ2b1ZvNkpFdFNFLzg5YlpOd3RUNVoxanJSSVJtUXNscUdhaTJ1OFZM?=
 =?utf-8?B?bE4zazlQSzZqK3F3YitJUDBLK2kxeGE5Ulhzc3RTeCt1c0drbDNESkppK25p?=
 =?utf-8?B?T2NSRmpVY0RmU1puU2hHbndXOW9YOHdEbzViN1JUVC91VGpxaTI0R1hYNFVV?=
 =?utf-8?B?RXZMSWp2akZqRlY5RU12cVBuWXBJL0RMbzJTSytsZXl1U09GT2M1ODJxZnYv?=
 =?utf-8?B?cWRaMy9QSkhaWS96Mld2NEoxOEFkYUNrMW5KY2JXMEZuaVdrREpHS0lCb0hm?=
 =?utf-8?B?cnJheXBGUW9yOTViSkRLMEF5RmprRXdMS0FXWDduanpldkxOcjV4WGdNREdQ?=
 =?utf-8?B?S3J1SE1rUXpxQWIvNis5Z1dYZ0UrNGhQcUR6dEFvcG41S2lCajQ3M09JTll1?=
 =?utf-8?B?dmNoNUFEMHFZQTlHTngwZXNNS2Y3SGJTMTc0OTVTcEZhUDhzOXEwVjd0aUox?=
 =?utf-8?B?NlpsenptaEtlMTcwdEI4MHIvVXp3NFJqS1NwTWI2K0FPTVRQbUVZZ0QzbVlY?=
 =?utf-8?B?bURlVjJoZDNkRXdlaHp5eDBUMFZPQlhrU1pBSEdSM2E5NDNHVXZaanAxM3lX?=
 =?utf-8?B?WlZaMnZpZFovOSsyWng1aERrNzNNMkRtQUZDR0Z5czFjOXFjRGFIdExGWEZX?=
 =?utf-8?B?c1ExcVNjQ0dKNzM1QVg2bUlSOHVTd3Q0M3pmOGJ1VWc5VXVZbWJOSDZOR2Z6?=
 =?utf-8?B?ZzhkdHVJbVJsT2FWTmJRc256YXlvb1dLMUJtNXJiVDl6bUw4cWh6UkQ0QjFP?=
 =?utf-8?B?YndKS1dPMW5ha2RBa2FzR1dzdjBtYVd5MWgvVDNobmlkZGx0TlRnVWhDRzBL?=
 =?utf-8?B?YjNUM2c0cm1IVHNPbnZLTEtTUzA0NS9pWWFKWFlIaDJkTUhCYndGZnRYbmNq?=
 =?utf-8?B?Qmpwc01LNWVXMWNJMU14K3FuQXVuVVhCTzQ3WXNORHA2U21YbHM1LzNqdVZZ?=
 =?utf-8?B?RWt4SitCMmgrMzczQzFzWUwwa0UzdUhWMU13ZDVqUkJMd09yd2puNGQ1dVlG?=
 =?utf-8?B?MGtvdHQzNEh3N0gxc2RHRE9JWmRhSE1tVEVXbWY3Q210OFpSRVRkV2NGL2pF?=
 =?utf-8?B?M2UwWTYvbUp0bWs2c3R2b2VQVkhHSXdXaDFpd2tJV2QzN1FnTnU4U0Y0cVpR?=
 =?utf-8?B?ZnRyR3hmMW9TV2tpYzNwNGFNOGtZN0xUWnh3UVkyR1lKZ2ZVK1MxTXVtOTlR?=
 =?utf-8?B?Vmc4ejlsaThLY2lSaDBPYkJIZDFrc0hLcHM1dlBNZUZXaExRQVpDNE5wVVda?=
 =?utf-8?B?MnhyL3pRSGJBWHhWalp3TURZZkl5RVRSWWxUd3c2TWdLT25DNWFGdXg2TEsr?=
 =?utf-8?B?VXU2c3VVVytadkR0VHpFWHIzcThzbjY4bWU1NFFBRCtrSkFBVFpaMnFHbkIw?=
 =?utf-8?B?MkpiR09BUzVnSytQRCt5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1pvRkUxVHM2UzNuUWJCVTBWbUtyZ0VVRUFUTncwbUE5TXFSS2J2QUdWOFcy?=
 =?utf-8?B?VUQrRDRub25sM2lrd1Fpb0orTXdNODBNREpKc245QUtLb2VTZG16bW41aFQv?=
 =?utf-8?B?NWF3WVRscnkvTXJZYWNkUEN6K0RYZHRTd2pLUytzM0FlMU0zZDJLc2RPNFR2?=
 =?utf-8?B?UWdOTVM4eU5mTHdsNllVbHlEZTVzTEtpN24veXloSDBESjh5YVVMRkRDNzl5?=
 =?utf-8?B?d2dOVnkxQWFSZk80N2hPa0ZPY2xxZHhka3MrQXBDWDlTblpFdU8wakptS0x0?=
 =?utf-8?B?NDA2KzZrdXF2QkFROEpZOW01akhEZCt0UzRKOFZWNHRqRmpIZ2FKS3hheWxL?=
 =?utf-8?B?T0p3dHJ4MktodmZCZENhYlFZK3V0YzdRQ2ttdWYvYnVBOHBMam80aXltWkJ0?=
 =?utf-8?B?OWxtK25UaENRd3pSYWZpMk9PbGs2ZG8zUWhDSlJkejVUNzRON1BTbEtLU3Vi?=
 =?utf-8?B?aURHOHN1M2xzMTNaOG9xZG9pYld1VExPRUlCOWlELzFsRTIvTll0RHhGZXVU?=
 =?utf-8?B?SFZSOXkraEFFWTRVcHdMYXgwMTJrNVZnbGI5dXFCNHVpeXNvZEo0aWx0WVEr?=
 =?utf-8?B?em43cWo5Rk9yeDd3QnZtQ0tJVlo0NkpVTHJ3eFQyYnRQN1JUS05IVEg2UkdC?=
 =?utf-8?B?blpxS2pIM1B1aDhZbWFzYnQ2Wm81c0hhVk9TcDVGcVptS1BEV0p0ekxFNlVO?=
 =?utf-8?B?NGMyMkVoMi9nNHRRSTQya05tTVZraEtSZGRWTFhrRHJsdzQ2U2lzY0tsWWxz?=
 =?utf-8?B?S1F4S1hCUDNHZmNKSndXVER2SUFlV0kySk5ISXl3NTMzbVhlcUUyNld6R2lU?=
 =?utf-8?B?UWo2UW11cGg4VmZIaG9RdXhjQ3BhaEhvZk5vQzB4b1FXSFhkbjZFaEtDaE54?=
 =?utf-8?B?WlpOSjJ3R3c3NWEvZTZ2QmZXa25ybHQxcFBNMmV2d1VtcUtST1dnZ1pMNjZk?=
 =?utf-8?B?Rm0xSFFIbDNRSE56UFBEeHBKT0FrT3NlK3hsenJlT29OdEI0RnZteG0wVHRh?=
 =?utf-8?B?ZXdURU5tejlHcmVTTHVSYmdHZHdNY0RER3JlR1pNMTVNaG5Ic2QwM1VURHZW?=
 =?utf-8?B?Zzg3d3l4VnY2NCtWcXRZeTBIS016b0ZhbHZoS0NGK29lcUwzWFdZakZHOVNt?=
 =?utf-8?B?bnM0bFpjMDdGR2NNaFpwMFRKYURyYi85cytJT3JFK0lRNmkweCtpekhUSmxO?=
 =?utf-8?B?aVNWQktzSjl6Q1l3emoyaVh0WjNGaVdxU0Rrdi9Uc3Z0U3N4d3lGcy9PbWIr?=
 =?utf-8?B?dnBWbzRFaEJuQm1TYThnM1loaVVyOHRaZHFQb1dpSHk0QTd4czA5dG5Wc2p3?=
 =?utf-8?B?WVJVajRtcTgwMFpqZEQzRi9ZU0VUbU9oVjhDblJrK2JLaEhmb29sOWs3STN5?=
 =?utf-8?B?eUMvWGlvT0RJQ2VGQnRpSGJnY2N3dXdmL3JKcmxMbk5qZ0psdTQ3SU5yeFg1?=
 =?utf-8?B?SFBSbzBMUEt1RTUvZGdRTUVubzJ6eW9WQmNHQ2NsMlhFdnBUZE9BVGtCcDkv?=
 =?utf-8?B?VCtKQnQ1MmdranBkYnNtUUtsdzJnbnVMQk9iaVJsbVV3bXBPR3o4U2lPQkgw?=
 =?utf-8?B?cm9qZk83MUlTV1pwbEptUXlpMTcxcXk0eW50QWw1Mm1UeklYUy90cm8wbkJP?=
 =?utf-8?B?akt0Y2lIQWFvVVNxbEwvcUVCQysvakhndW1OTVhpd2N5MGU4OGV1R3VRd1ZE?=
 =?utf-8?B?WEJVQlJXZDdRWXlaNVQ3MVdCaVIrS0w2ektsanZSL3Vmb2YzZm5tZTZuTzEy?=
 =?utf-8?B?QUdiTmlFQ1FHM1ovOHNHamhOaTcxczdwSkFHR2hsNDdTd3YrM1VRV0VSVVl0?=
 =?utf-8?B?UktOSzZRYVhUNmJJTDBaRlc3QnhRZzRycTdHV1dVVU4wY2xBY1hJdEtxRzRi?=
 =?utf-8?B?S3g5VEFQZVlaS0YvTHBDMi8wL1FPQ1h4YW0yUjBlQjROZDdIOElzbGdpR0s4?=
 =?utf-8?B?REJOVTNabUFtVTNWSnBnUER4SWdqUStHYUtMbjlDNEI3WThwV3NyN29QOUhZ?=
 =?utf-8?B?VXdiTUdNSTQ3ajNvUS9meDJLbUZlZSt0VVl3Q241UllSWm9NSDJuTW1wMzZW?=
 =?utf-8?B?K2I4U2JFMWNobytab2hRUWliaG1FaU1EZ2xUTDdkZWMxNWx1NXprWUVWUkd5?=
 =?utf-8?B?RkNkQzEvQXdoTy94UHF2K0FZcGVUcWRmN2lYc1pmNHo4S3NRTkdxQzRHbG5B?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 756e3c78-0bac-44bf-ceca-08dc9ce1b369
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 11:00:37.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sae/fCilqfGnYWrFPgd1WLVG2yvedeZV+EimOlq9PU4CsCNlNiP87KXgaUqpVVMiOTj44zeBZZSLHwGEFRUrBUg2HSPkA79M7Ik8k5iNbXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8417

Hi Guenter,

On 7/4/24 7:52 PM, Guenter Roeck wrote:
> AMC6821 supports configuring if a fan is DC or PWM controlled.
> Add support for the pwm1_mode attribute to make it runtime configurable.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

