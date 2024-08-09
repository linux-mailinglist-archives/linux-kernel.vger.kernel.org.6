Return-Path: <linux-kernel+bounces-280831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8847B94CFC3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4731C2182C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3895815D5C8;
	Fri,  9 Aug 2024 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AdhMpEXQ"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010009.outbound.protection.outlook.com [52.103.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EF0193096
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205005; cv=fail; b=kSOBhIpNt5noBOvjGPXprwrR8l9AmO3SEd1YAuWIigbgShSUbUTKfpPaygN0ql5WQcZdxyy3UOL03ViQRdrUUs/RPVbG/ad1QXa5QbN88U5Zu6LkJfpgPF4Rh+jH6rE2QBfLd3+j4WpQX+3b6h3WFvRX/YZMnWtWiPmvL+ylhME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205005; c=relaxed/simple;
	bh=BEbHGJO+M+KcqmniaLlm4QDGfICL3f1geFZX1SFbegE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=AuP7vJKoSIovaQAyQDJFBLbII8n88bCi0mz7N/09qlyU3ihhDI/C629SQYb1cEkAXNIiV5tVSLIqEdHYP5eHDXNxwt0LoNkhdiyrhCW7qI6b2M48lpD01U7Y8BzCiKW6QjD7sCyPwiQI4DuVTv4Gc8hsDuCfQsin8aPaFksUaJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AdhMpEXQ; arc=fail smtp.client-ip=52.103.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6Onv/HCGqoYl7bndLp9JS48nsocQrxnyMgJTC6O5eSYPX2ByzH/YOljpPYjqRDYII8SV1QGSQcvayMnVJtafvtLuFK+OnmZwm8q3tQg6lfQqsicG7INgTQSTF5ipNavQOLrzym54y1Vs4HnPu6sYVwz8zdMWUYwbRqXKETkWakCwC3luYYQ8La3NM9FXR7+3M2Ts/ZC3tP+X/K7s8exHg/6v18xW8r1seC/Pq/n0JtKjDhJe4d6mZJsQFUrLXbyoKwI0KaS45hoV2MRp411hvSOq3BVnZIaCaeEiqht6sVP7THEOpgjs/QkmQbqCNAOpNhCwRHw8DAB0tyAh0K/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9BXTbL3IJy8ouSNRiEkBhUgAMX+dHQ4u4HiRpTMJeY=;
 b=XzINLACktJ4GmgpgUGos6o6z8wXpZyZcWe4vZZ08PRajTJWf40G++gDjkH8qYMedhhrZJWOjUpzeq4N8TStVsKCk56OxcymP6GVZ560NRJ00LRfw3bbQQiRP3j/+ATTkqz/DeM4jcqJLYiy6qsTNNR13gxfx6REZqIVjhFW9eUf/95xOq8izXbwRdZQTKgVCcf/KA/ZNOMno0sWhKGqf8K/8tRfyruZWMUr+7+Nn3UbhD5WvaTwaQqfPtsZpBixH/RkklrlDRgPTgFI5dDIEu+bBqNeErE4eD13is+k3+PLPRgLJHZLm3N/fVgc+H1vsK0kRbXnQamn02AFxWLw8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9BXTbL3IJy8ouSNRiEkBhUgAMX+dHQ4u4HiRpTMJeY=;
 b=AdhMpEXQDYDUzjke0qvIfUkGDEJZtrFDxf5I2LfaL0ZoHns4jXOT1vG2it6WTtAvXfnVfhXOKHMXLLEaSYkmpra2wqBouXkih77ElaCj1DhHvrdURMuxpmWJYD/lYW+N9N4LTOAPZ4JfGvD/UUtQ+6rXZa2Tkm8YEulWe+a4yNZCCl6AXxI5MiTbsbwgRkBDljFno6K0w2+yR613G85Ip5tUYKxzn8nED4uZlCYa+T8YEFcufDQLiv6/b/OfzBWK9S4VgXDYZvXl2d2Xr57lLYOkTOjmsgOJQt/kryR4Kz1bRERtAU8n68AWP2Liqkmjdi1gvqXhsdqHbEMPH5CaGA==
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com (2603:1096:404:d8::12)
 by TYWPR01MB9804.jpnprd01.prod.outlook.com (2603:1096:400:224::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Fri, 9 Aug
 2024 12:02:49 +0000
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d]) by TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d%5]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 12:02:48 +0000
Date: Fri, 9 Aug 2024 20:02:43 +0800
From: Zhang Ning <zhangn1985@outlook.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org
Cc: zhangn1985@outlook.com, andy@kernel.org, lee@kernel.org
Subject: mfd: intel_soc_pmic_bxtwc: irq 0 issue, tmu and typec components
 fail to probe.
Message-ID:
 <TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TMN: [xnp8ZDqRIOWJm5vCRKECeOeEfy05NS0C7HJklHIDxAkjlcGfeiN/p3KiRtGrOFrB]
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To TY2PR01MB3322.jpnprd01.prod.outlook.com
 (2603:1096:404:d8::12)
X-Microsoft-Original-Message-ID: <ZrYFYzVd9sklfoWt@orangepipc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR01MB3322:EE_|TYWPR01MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ae52c0-cf96-43fa-a7a7-08dcb86b2ff0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799003|461199028|8060799006|19110799003|5072599009|4302099013|440099028|3412199025|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	4Dc9yumO/ZHoUP92gMD4gQTMG9XwN+l4eDSlFRtTAsHnQaBSm7KV7642VWPpRe55NcuwaoLf1kDEIyrEOEVO4dDtUE407sXrpfSKHNZvv5rpiWb71Z26wupgoZHJBHzIMgpJDnS+4I5Ylkl3eWSjW5SUcsXr9QQZmI54ZO6Fou36NZOArKSE42DFN24pO0KbS/9y4WQsTphfPWGDjMPrMSXkO2apGmeestv82591yCmmObht5PcO0bWzghOOM0l7Pk1tFSBTGeV5n3kKh75c3yPs0+JC/XllBYbfT3DG72AQB8m1hRFkauuV4oH/c5wW1OluIhjr6jrE9oQnNK+uXvRIUqIYgnUPf+f67bWr+rsYw5n5/lTk+FTHJtIuUPkKF9aS+UF2qHWbscOXt23HBnoMyuFte5p+pIDlq+y3KbPCDwChb/180/tpRaNguodpJFS9wE3HJ0KkPOFim/a+wjXt4UuM3v9+N5aza4inimVH1AeeijONg+LhAYsUbuFD7J0Ml+Y1412U/IhUvvmH/4fEzmw2K6Lb5iNyUGxr4Sb+DtIaaRS6SHZQpncU2SfN4p2rYQpZnBMWN68WntYL8hlhgeIqLuR4ARE4xXxoGpiNAS1GdRn/+RUSXDbxXRFIJG62XVh7OSni/5QW7Y3Kv3fSqq1qZzUKCqnnmtGpyNS9pR6h1B7q9SfasSa22g3mgPjAV/953IDqK6LXDLCNQKXX02CSsGLkFSKtM6ULNSg0A8ZRBTYqH1590Vo7HV744iqjk9a7fcmOuYNhtllUEvLpKV3hAOMeBTrDQQAVJAmCNGQFLiLKzrxFyXU382/9JS4iHMMpyL1s6SHbpguNJwEGd1fPyYm8YjNdw3TGyOOeAuNR/ap5lF/IfJ5fvYbX8PltqqGo4/HM2L6mFFarOQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGlGTGtGUGlIYWJOTm94RC9nTzVvWVJZc2lFQzhlMXRRdnFrRDl5QngyaktV?=
 =?utf-8?B?VTFleHNEN3RKUWl2bkE5aWQ0T1ZZblh2QzhGcUIxN2YxeGZzN2VZR1d0SGZq?=
 =?utf-8?B?NTg5M0lPNzhQL0x2WlNXY2dqVVA0elZYcXBhTit1cWlpTjN0bTh3R2MrKzBp?=
 =?utf-8?B?VndXSW9QdWRETk1ITUkvTkxkSUU4ZVBId0Y1aUM5Q3JNKzFkSWRtajVraVFX?=
 =?utf-8?B?aXV1WVpxdEM4S2c4a3VicUtEVUNUUlphVDUxdlFnM1BSQzBHM1VlK3NsZXFZ?=
 =?utf-8?B?bExQMWZhc2xIZlFwdDl5eDNQWURlK3o0WFdEeGZ5TXVjRFM2UnV2NjFHczR1?=
 =?utf-8?B?WTQ0THdMMzFMTzNOZHNYb1k5ZlNORE1iVlhCK0tQY1RCSWthcEs5b1ROWmpm?=
 =?utf-8?B?MC95UzNpUzlsa09JVExkbUhNMVR3NTkyZWpGN0RYbm1BU0FCOTJOR2JIbVZq?=
 =?utf-8?B?elNRbHJFN0lxbTVrZ2hWUG5FOGlQWDIra3BLdGlDNHZYZGJRWkdIa1pNcDRy?=
 =?utf-8?B?MDh6M0M2K21UODN2YzFXRXZPVzZSWHdvdFNJcVBsRzlCNkErQkNmblE2ZHBJ?=
 =?utf-8?B?YzZQc1NteE0xeEZPRWVadXBwQkVEMjZIVkl2TWZRaE9yYTQ5R0xqK2tWTmJF?=
 =?utf-8?B?T2Y5VUh1WE5IbnYzRTd1VGN5UWJNQkJVNTJjaHFhek9oaENMTDJNditrT0hh?=
 =?utf-8?B?ZW9XZENqS2crajU4eVhnWUNtK1lkWG9oRk9IbjFxUXZraXhCT1lmUThyWlNZ?=
 =?utf-8?B?dktHWjZYZjRXaVRpVkhncitHN0tsM0VvNXI2VzYxNGgwMkE2ZHFhcEJTVDRO?=
 =?utf-8?B?SWQ4WGN1NmtLaFZFb1NCUFJmYzdCdmhnWDlSTnFxQVV6ZXYvL0syaTN3SENC?=
 =?utf-8?B?WFF2U01xWFpCN0t2THJGejF5amRUSXNMQmhqclVPSHhQZnEvc2UzbG4zbzJi?=
 =?utf-8?B?RlNIK2JQS2RtejdCTGlLWDFVUk1hM2dGQ0JqVzRNaW9MTlZDS0lya05OTTQw?=
 =?utf-8?B?d1ZzY0dsWFhUWUJwZ1lWZW53WkFwcnRwb3h0UG1jVjNTTmxJamd6Z1NOS2VK?=
 =?utf-8?B?RVAyNTh3bWVqNWJmUmxqUXJWT29qaXBRQ2QxOXFpYmJ0YkNzN1J4U09ERThJ?=
 =?utf-8?B?L1dKVitCVGVseDU1VVc5dThtRzB0SEFwOUlGSWwxU3Z0RVJRbEFkalNEdXVk?=
 =?utf-8?B?NklyRC9tbWF5QmRCR0o4NloxWFlyeDU5SjhMeGZwdksrbk1nS1Z4V0V0WGgw?=
 =?utf-8?B?ZHRxVEp1KzNGdFNrYXc0L1IrbVNlU1JxWDBDMXNUc3RrbmNHOTI4WnY4M2x3?=
 =?utf-8?B?d2tNVkFHQk8yM3AzMmtiSDVLS1FmKy9yZHBNenJieDRNYzBROXVCNWxDVElQ?=
 =?utf-8?B?L01QNW9PNkRoRmxxV011SkNJUVFsZ1pIZGZpQ3lBWWg4NWRBcUcvWisxcEZh?=
 =?utf-8?B?blh0ZEU4V1FOa1BBNVdCT29QYVhIeThzcjJKMkFRUzBIMlFUUjlsK3JFMGx5?=
 =?utf-8?B?YVBYUkR2UWZrRmNzWk1OSDh1ZEV1YS96UG1qNlpuZDlJM3dUdWYreFAxZkF4?=
 =?utf-8?B?Lzd6MEpjRGhITDZaV0YvQ3F2VlhyN1ArQ0ZQckFpbXFxbGtzM3pBSGpSQ2dz?=
 =?utf-8?B?dzVhQ1dGMndaZXk2K3R2VVpQeDNLZm9OQVVtdndPdHdkK1BXKzNJczVWUkF5?=
 =?utf-8?B?Kzg0cXMyZGgxVjBKVmMvaXZSSTVDcEVNY3lCa085VXMxU3pJd1k1MndmTXM0?=
 =?utf-8?Q?SArJch3/t3vIGkwJ/w=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ae52c0-cf96-43fa-a7a7-08dcb86b2ff0
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3322.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 12:02:48.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9804

Hi, Greg & Rafael

recently, when I try to enable mfd components for intel_soc_pmic_bxtwc
for debian kernel[0]. I find tmu and typec failed to probe.

after check source code, I find irq for these two devices are 0, when
use platform_get_irq, it will alway fail.

	if (WARN(!ret, "0 is an invalid IRQ number\n"))
		return -EINVAL;
	return ret;

My workaround for debian is to hardcode irq to 0, instead to use api.

I don't know how to write a good solution, thus send an email to you.

BR.
Ning.

[0]: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1156/diffs

