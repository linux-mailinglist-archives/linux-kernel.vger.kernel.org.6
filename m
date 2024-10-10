Return-Path: <linux-kernel+bounces-359678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFE4998EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0921C2357C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C329D1CB30D;
	Thu, 10 Oct 2024 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bBW3VocI"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2078.outbound.protection.outlook.com [40.92.18.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BA21DF997
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582756; cv=fail; b=mIxcwvEt9UdgvVrR6KvJ3kJB3Cwuq/L5Pc8vibH9cu4ykkPNq8qMqwQT4tERCjLMFhwgfbVTqegIi12Fp49hKwyiypF4l6WbLKmidoVB3J591M04jdxZ/pxy1bH0M76GEWXboFjhZNe0Md0XY7otyZhLLyxaHKwUJn0lsVNsl1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582756; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=KwZ2PiUiSGq2p1Sjq0b/GJvR6gJOXaLQ60L+6S1npm5x7cRXY5oqYZFDsV7xEGbiD+BW+x1CsnmB6ucjrLnzyd4xCycZUWfdeD4IKBR0yhJasuwYepLGVZtkpNmv62rxF9XmUlvf+Fudkszn+WM/4mJmL/bZvbgeTqyIMspx9nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bBW3VocI; arc=fail smtp.client-ip=40.92.18.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r41NiEdq1bxUvG1bPCk18CLYeKM2Q7saJCcoyfFoksFHbVyaYQUu20I4JMVzCPZDtiAe4EQAQSZXusho70ENh91kNqNw8LtGcCmyyiBXH2Q5euOoGfDJ9kfjwYgsRDGMEf6YshfA28XZ+wWMfq7vmgzpwOz+YF/omImBMgeG5XdL0pA6yHfDDZHTpklhfVZc6/I4ACJYlIXlOJXcq+e2Ugq4GdEDpuhKuND3VlPfG9bI/0Dui07GZtCtG28FsbFPQTZSacnQoGxVzi25MAIxh5M+iDSAJ6QpIIZWCcdW0gUg4PAXl/Uc+TH3vYR9iMxS9DF9smhieuAXdqMZQTM72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
 b=zHMs7sWX7vlt7GAJyu/KEnHICGOPhn1e5DFsq9UogVIij0mlS8Gb+cPV1stKzAlPJUAmoaieP6jF+4YPpuw0390/+TtCvvJ6bOVqD9s0EPVGhc4c4KxqDiJZvqiWovthVG72Ye621H7T76NRM7NgIYd1wEzlxJlxK4nI+JjjVOUit4wnsDdhmU/Ikfnpp+GqCBfhr2WIMyHDBmPo4etwx1EbP1WVcN8PXluw8UAMs+OmfYZWlrU8P83YEVSol2lISgPDBNWjCJyAzOJgiCjRyuhCu8ul4Q1MmTfmvv+sguFQZZ57iZ2pOXYr3bbH22iBTMGQMa/AXOdlY76TyAl6jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
 b=bBW3VocIoYg6VWfBOcffVNZmQPAYnWhD3SgNSvNW1CqHMTQT7G2MF1NcPONQ0TX/HJbbeo90gNM84oHUswdqjEvelV8x29ytfQ+GBCZg16BYU/DD+LpVBm8gvG07VMKyxf5r+vMU2Y+FbeL3YxOXoNmFw6egGASKIIfzEFqgtJ4YKYYFxrFNoj2e1xKGzbYvPAkStRaC5rKTW7NThyahvjRNM4QLaKSEXRJ5GV6huh++4TU3umBjmYObr4tVXrhUw2s/DN+KCLsT6rSHcph9fRqNoucEx428yjYct35NyQtM54SbRzM00dzWDOD+MMbjNmQEenW84tklbiu044ziHw==
Received: from CH3PR84MB3522.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1ca::5)
 by SJ0PR84MB1823.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:435::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 17:52:32 +0000
Received: from CH3PR84MB3522.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ab1f:ea69:7433:dd47]) by CH3PR84MB3522.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ab1f:ea69:7433:dd47%3]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 17:52:32 +0000
Message-ID:
 <CH3PR84MB35227A198AC74F4CF46D0786D5782@CH3PR84MB3522.NAMPRD84.PROD.OUTLOOK.COM>
Date: Thu, 10 Oct 2024 13:52:31 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: Iulian Gilca <igilca@outlook.com>
Subject: subscribe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0785.namprd03.prod.outlook.com
 (2603:10b6:408:13f::10) To CH3PR84MB3522.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:610:1ca::5)
X-Microsoft-Original-Message-ID:
 <0b7e4fcc-7303-4403-8b0a-638e180988de@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR84MB3522:EE_|SJ0PR84MB1823:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a93602-4202-40b4-b597-08dce9545113
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|6090799003|461199028|15080799006|7092599003|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	k7L8eeNd6z3vpv6jbiiTGA06aKGs1vNjsPhX+gyyb3EL3op5Te8Kg/IIVmtB3/iuVyZuQbgCs5RN8DNArVp5cN/Xlt/hJfcVW4l11q13SlLspiF8L6pXZA4Jby55WomB0mQ0kzRzA+Lh3U+MNTm+5o67jY95Qd0hglFxcqt2sBG8A+GGFH9oAPRDopjPJw4Y/zLWuqN2N4kdEpHGGu6tie2MPhI1sKZ3q7My8iGRPYh1eJrQV7nfyeg41Vubao0YQq07zNNlbHomK4zxpaxi46uv0yuu6Ut9V3gxEyDiy42wAQZ2LDb5SwibRCdk/wexmmInleH1XActh0jVWLaDSAC/HrrvpRAZxovwaZ2xiasPAcAgPsMdVa3h/f3nvfahl0n0mmsmVLhvBhdXb5zk3fdAuQ96tY7UQqCFmKzPgxrj3mhdw/YxdbaparKNycw+31NVhCdKeR6AVWeECW3zPaH99DxhLQoQwhc3en0lVII=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzhGTTZVRVBzQWtHZTlyQlV2UEp1dGVPVEVITG1hbU1OdmRHbEZ2Ui8wWVpv?=
 =?utf-8?B?L3c4b0xoZFlnbWlEZVdZNmgwb0RjRnFJdzJSUk96UHp6NTZ6UGxZaUEvODJQ?=
 =?utf-8?B?OThweEZhcXdzN0hHSWY1ajhFd245U0ZiaTVYVFVndFJVSjNJWkROdDVRZUI1?=
 =?utf-8?B?MXgrTTBNdWJLVWZQYVc2U1dleTROK0hWZEFVWFl4b1prU0ZKOG53K2U4bGhQ?=
 =?utf-8?B?bE00SDdzQmNJZEdnUFVUY0NiTE9XNDV6aWFuNmEyY3dZNU0yZUxxTERSdThK?=
 =?utf-8?B?MERHNUtJSUM0d1lTTjI0SSs2TkhJL1V4YjQyejRvc3A0c3BJbEgrUlk2ckRI?=
 =?utf-8?B?RSswQ2hJMGxGMVkvb3VNY2x2UE5UdjJKR0NZck05d3FrTzhxMEM2VGV0d1Fq?=
 =?utf-8?B?YUl5cEdueC9Nd3hDZHN5d1o4bE5ib2JCQmxQTGYxeFo3QVljdU96M3M3WGZ1?=
 =?utf-8?B?QlJaWEpwaGtnTXJ1ODhBQ05JS3RtSWZDL0k5YlViSExycHhKcnYyc0hDUHdl?=
 =?utf-8?B?VzV0RkYrUVUyL1FSeERkeU5uTGNOUkRBWXlLanRra3NjaGhiQlRyNjVVQU4z?=
 =?utf-8?B?M05mVk01YzBvQXJhbEJXR1hpVXIzdUhWaHZZK3o1MHNIQnNtTytkQTNhUXpz?=
 =?utf-8?B?ajFPNEhnZWxtdzZJYWdPRTFnRWtvZ1N3MDBnYVNtZE44QkxlbkpyT1ZFZmtp?=
 =?utf-8?B?WDRiMTBqclkva0p5cjZUTkhTTWVDL0FISERLYTgyYkZ6V3UrTUFQUVEvY1Az?=
 =?utf-8?B?Y2xrVWpjRDRZQ2VlY1hPR2dhMmowUzhzR1k0aFc3Nyt0NmlhMS9KM3I4YWJ5?=
 =?utf-8?B?TkUweGZIcTZKU084YUt6b2djNEZSSkM0MjNybTBDZ1FQMFZNdTNGSlBaeGFz?=
 =?utf-8?B?NmNTY2tsSU5SSlU2ZllJOTZIL2lvTlZJNkJRNTVpT2Y0ZWJlTkhkMjdnSVkr?=
 =?utf-8?B?NVBjWk44WjZ0ZG1PY3BPSHhTZmxZNWRzM3llTE11a0NHL1g5VzNOMVM4eUxZ?=
 =?utf-8?B?TjJMa29QZGZJVHVLck9XeDNuczdNdnN5YkNRdjBLYlMxNHExSU03YzB0MEpI?=
 =?utf-8?B?cVdzTWFpZzJFRFJlWHNRaC8rdmlyb25hdGpneDZBWmUwS1VIRXdGOFZ5ajZM?=
 =?utf-8?B?cmlXbnlvbWxyamdsb3NTYVZHbmtadndldy9nT1UwREE0QzE0V0Y5b3dubnFZ?=
 =?utf-8?B?VXk4VVdvSk9RVkRDWEt1VDlSZHgycDlBOHQyWGVyU09Yd2EwMGhUS1UxYXlY?=
 =?utf-8?B?dnl5RHhmN0ZlY2l0SDE3cjNGY1NnSUY3MkxvemVKaU1BSlVrd1VuRjNvMEpa?=
 =?utf-8?B?QWx5S0RzblQwdG50WGZEREdGNHg0dFM5RXd2TWladGpuQUZQSjhjMnBQbFlU?=
 =?utf-8?B?UWRia3R2TWQ5MEU2clBQMWxja0J1UStxNHJmbGpxcnc5YTB0TGFNOGdTLzZE?=
 =?utf-8?B?VWtxWlk4VWxBdyswWklpaTJyQUVBUFhNK3B6VlRHNHVhWnpPNXphUzV4U1Mz?=
 =?utf-8?B?L0p1eFp3NWp2ZFd4c3R1WnRHOU5qdjNoMG04dVBMMGR5bFdDaEQzYlI5V3RM?=
 =?utf-8?B?TStOK3hQZTljQjM2aFYrc1dZSzY1cUphNldmdDRmbFNuQVF0UmlmWWo1UXQx?=
 =?utf-8?B?R2ZibVpLWVA5REhKdERMUGRoZG5UeW1JWmFvbGZPR1BhNWZqNGJ5bnZFcjRv?=
 =?utf-8?B?eEovL2RBSG9hMmJUdmFkWjUxMDRuSFcwUXV4c2UyT2w3czh3RzFwV2VaNXQ2?=
 =?utf-8?Q?etGtb/aJN9eBPWQ6/I=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a93602-4202-40b4-b597-08dce9545113
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3522.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 17:52:32.8633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1823

subscribe


