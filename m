Return-Path: <linux-kernel+bounces-340508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 724CD98745F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6B21C21677
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCC73B1A2;
	Thu, 26 Sep 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="PaK2SFbV"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6291CAB8
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357058; cv=fail; b=ioFcEPBhTJJArTu1gRS7EoxOSVZeFrmh8wgDXCJR8grD5EoGwcJfWDNU6y/zPEJm7uo82mscvLrEXMYga33PJ4z3uIuUI2MK4H5e2VUkSZXsxjuVdhl1WKhuSZEZoG0mtHOkmZJBUi00JW5lgZ0hE0jEqrjGKQpMeGY52w8463E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357058; c=relaxed/simple;
	bh=5aIGlUiGXfAacJRHbZ9e3RhMP3qRKtIhXipdPoYli3Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hc+j9venlHNggvbdpwwgj662OGy/5vQN7OeBqjRcKjL0sdsraNliaccYJNmEQ950PYxCZdJCLdLgJI28UFF/ozXppdYPlt9jo9e0iSnSpgXI68M+iN4yuaLliCSBEBivLLoXmldSGaefFrZcUhPjDF6Ibir/Bd/AHpgp5O8r+fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=PaK2SFbV; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAVtQLAxIzYOXnyMYOh4qqRhhEnS0TPfBmnEcHaCYeUpH8WoC4QFOb8usYMltiOl6WhnHYsWN1qumiX0b2zjFS35LGOmoDADuxWLItwgnxQMM+ji+niRLvH5TPqH0dUTSOkJgc0dDabIXGyxO6+sSLOCWN81XKWfxz9zzfUp4hfKhAaUJ3vy+NJtpZfFXsb3Rh/AqehpetzWLHm94vbDV/0seBIcov4nwl9flNJZSa4tIw2CObHoe2G3FdDSUgqKkAmLV/pY6BEZQ/xp6uwst3Ws/pIrzqCy48y8R1XJT9DR7+OTNzKWvOaAjH0zcDYWJQni248kWyRYBnN5SywVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOjxMfnROhx3hkUrh3ixB7iWQE98sdnn/RyVTTFuP6M=;
 b=BVgIuzjY0Fp/yhjQVQ4CqmGcWYRVpkNsUOiocL8h+Effp9juzfkIzSYdbYmEwYeU+IvF2U8ezgCwNevX6ma6doEYZCcPWbrVNJ8t8aQ6E4eEZXjbMNaZ+0wEjOx4A/+3rqkgvASwwnY49Cg357HvXYeVzGA+XA1PdiSHhjxGoHgNa0Osuuwhwc7GngWDY3IgN43/0NsvlgT4mkCecaYK93w2iHRAOHuHw91wYJFcN1+imdE6cbvaRe/4UIPFmpqpBgIKzMiJQHCIGkVQp5KbBLHWaQdIdzKYe+7aq9G8X51LBvANhpcpd2J2Rp1eI7ET0ID7cbR2l2o2irBMdVJczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOjxMfnROhx3hkUrh3ixB7iWQE98sdnn/RyVTTFuP6M=;
 b=PaK2SFbVeJk4AWcPmbytFp+mo6vUJNFVzJGT5i+7rYXMQaJR9tuczsIFekdX59VpMqed7zaxi8U6igGNXaYhkZ4tYnHap0kEOdx6CYN7yWOm96Z6kkwFh3F575MPnp4ZEwPBsSTHz9AkDG0fx4VSyY8Ximmrveg6Q73PPkhyyT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by GV1PR04MB9101.eurprd04.prod.outlook.com (2603:10a6:150:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 13:24:04 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Thu, 26 Sep 2024
 13:24:04 +0000
Message-ID: <050724b3-aed6-41d3-b2b4-18b90fbf0ad3@cherry.de>
Date: Thu, 26 Sep 2024 15:24:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: add attiny_rst_gate to Ringneck
To: Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: heiko@sntech.de, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
References: <69f79284-b52e-496e-a286-d7e5ce3d90ce@cherry.de>
 <20240926132028.21910-1-jakob.unterwurzacher@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240926132028.21910-1-jakob.unterwurzacher@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::6) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|GV1PR04MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 418a807e-de5b-454f-9838-08dcde2e7e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bk5VQjJHNkZIUUZNcWh5NU01aTJNMERWdi9ndnFFZ2EwRzlacWtBOGQrdVI0?=
 =?utf-8?B?ZURmRzJqTDJnYmFXeFNPOWJLcm5NMk5NUjVxSU5XUjVoQk1GSzYxT3Vrb3Z6?=
 =?utf-8?B?ODhSZ3pHZGVvaW1XL3YxZWQ1eWlWZlpoTWx6aGU4bUhyT2pjK0dNLzd6ZlpV?=
 =?utf-8?B?RGQ3SW5GdWVRUklyNDZHZlFudHhXaWZIOGhsMXZCc3V5WDlDakg4ZmRuNC9U?=
 =?utf-8?B?MTJibGMxbDZrT1JLa3ljSkNNZTlhWUhBbmNsdGNBTDY2M1J6bHVyN0YwVEht?=
 =?utf-8?B?WnZzVXRNdnVHT0c1M0NtU2t0U3ZZbVhaV0NoUHNvd3N4YWZpQlY3VTJOSjZX?=
 =?utf-8?B?Wm1zQUNvQ3dEamc2MmlQS3dna21qZVpWbTMxTk45Tk0yUEg1Rm5zY3BSeVFF?=
 =?utf-8?B?bnRxSGRHK0tzd09wRnpTZk1hdG9yMVZDS2s0YjJyU1dBT0xXTC9GVmkyZ0ZG?=
 =?utf-8?B?UDNFQ0R4Yys3WTdWQWdSNzRaWXVFQkpiYy8wc2RqS1hiQ0RaTXYrY2l1VnBI?=
 =?utf-8?B?Q2tsbTJjd20wcXR5T1VVL2lxdUc0OENXVUt3Wlo4aHF4ZVpWandJaXFSSmo5?=
 =?utf-8?B?azFvTlN2WTA4azR5MnUwYm1ybU1NY281Ly91bUk0WGNLTVlZc2xuSXV1UDJu?=
 =?utf-8?B?NlYvR081MFNFN2RjMDczR2I5Q2FEemlSai95Z05hN2Vyb0orejFTQmo2M3VH?=
 =?utf-8?B?M2dUQkRONndCWEViWDJCeXVnT3c5NTlyKzg2UnMvZ1ZXeEg3NDZSeVEwTEcy?=
 =?utf-8?B?bktGSGUrTjFyOWdaWXNUWEplb0RZMk9nUmMvK3JDNlc4bng2UktnQnprS3Y1?=
 =?utf-8?B?S05jbEVRSEdTS2FRMDBPUVZmWVFYR2lsZnU2dVJtdHJ0R1NKNUhVeVMxdklu?=
 =?utf-8?B?UjRaVTVuajYwNVFTT05uTGVqTmRVNkMyelVLa3VQOXV1Z3hYOWF6SE5wdUlw?=
 =?utf-8?B?T05OQjV4RGRDU1ZxaVgxQzBYUHhNb3EyYTlpRDZVSlUvc0JhK1NYTlBWcnZL?=
 =?utf-8?B?ZllaS2N4UUVRWXd6a3J5NzJwcTY0TUpybDZpS0lqWlVOL3FSNWZ0aFNJZ2dn?=
 =?utf-8?B?UUQ4dmptb1AyWjkzejBxRSt5cmpSVWVQemxOZExjTmI2b0x3VW56Tm5LdU9q?=
 =?utf-8?B?Qzltc01rbENkeWYzcWVXTTR4VkhhcVQwYjhoWitYR0tWVk5RZFVtL3o5OVls?=
 =?utf-8?B?TUJiM2JtL1RJNjAzVElZR09WcGh5T1FLcnNwZDd4STdnUFoyUUdzTFV0QjlZ?=
 =?utf-8?B?dDNsRWtPVkJlR2pxZ0haZ3ArM3NqQUk3VzBJSGtDRE15RzVsVllzQ0dRWHFx?=
 =?utf-8?B?YnJmS0gyUm90N1paUUNwWWptaFZwekt3Q1l4SXhaUU83MjBLS2w4ZjFVVnp5?=
 =?utf-8?B?c3RwUmc1bGZOZmtjMGxaODk0Mk9VeW9mZ3Z6Y1E5c0Y1QlRzaERUb2N2K2pO?=
 =?utf-8?B?WXdSdEN5eDc0dnkwSDNoMzJHSEsydWkzeFBqaVNrUkloQTNtYVhUbkMrbU13?=
 =?utf-8?B?SEZBblRLQ0VWMk9tTlhTalRLL2REaVN6SHRUQWZtVWtuWi94V21YRFN5cGNL?=
 =?utf-8?B?WWxVdkFGSlUvR3JweFcrSkV0K09YMDd2YUVnYlNEaFM1YVUxWUNUZ1BtRUNM?=
 =?utf-8?B?a0ZhNVc0YVdFcUFZNUJKaGVvZzFmTXhtTC91MlRFMmMrOW1Ia2NBQnFHakZC?=
 =?utf-8?B?UFZwTmhCQ2RxUWJmSEtmdnkrVmhrWnFFMUx2OFFHU0JVZ0VaY2M5V0lRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dC9adkU3RFEvK09YdW1nOVZRaDl6cUI3S0p5SGxHM25Kb2M5T3FUcGxqeU84?=
 =?utf-8?B?MFM0cWc2THN4VXRqMWdLZzg4OTY1c0hJWmFlbkxENGphMWJUMU9RL0RNMnV5?=
 =?utf-8?B?OTJBK1AxTXV2UEJWZTNmcWVrb3k4QThLYmE5KzdQUlFkN0VtTWY3em5sRnJw?=
 =?utf-8?B?dzBjdVVrVENaRkJ0U3l4MGZBRTRiY2cvdGtwaFhTcFJIb0ROQitqU1Jqa0dH?=
 =?utf-8?B?cXBzV2dFRHJnNVpiK3N0R21lMkNLam1YOEE4aXRTQjVmYys4TU1XaXBjS1N4?=
 =?utf-8?B?SjdIdVdiRXpFS1JXcU9EQ3BST3ZhV2hRVTlsQUpHNGF3Q1pjYkpPUTc0VmNR?=
 =?utf-8?B?WDFSdk1UMlliOVl4eEI2a1o3VTNIbFJRVDBRMDJoRzJyNzB4Q25maHd0V0FB?=
 =?utf-8?B?dzVyTlZtcWVoTWpjR1dvdllvU0pHV0I0STc3dFRlYlpzeGlzZkpaQXFPeGt0?=
 =?utf-8?B?RDJhbXFELzdHNkJYR1pLMk4vdDN6SjF5V2tsNzY1d2JaYm1TTU1iZVVwellF?=
 =?utf-8?B?cHJqdHpYLzIxUFRob0QwNkdDQzRXbGRIbmc4eVBob2NQU0JnSnUyQldidnd4?=
 =?utf-8?B?dUlNaUJzVm9ZeGtQUGxtbTN1T3BIVWIybVZQOXJ3aldyTUVaek1JRVlTenhj?=
 =?utf-8?B?U1R0bHExQmRLN2FjMVN0ZTBZUE5QR0NXNStOMW1sNnpIM2hZS3MwYyswRmNS?=
 =?utf-8?B?cEFKbmQwdXBwSm9ESUVWTlY3WVAwMktWaEtMUEtBZGkrakl5SnRNM29FSnJm?=
 =?utf-8?B?Y1VKVzdwa0RUVmx3c3dJUnY0dGQyYU8zK3gvdXhMS1k2ZmllakVTV1ZRTnc2?=
 =?utf-8?B?N29OOGpDSVo3NVYvdE5TTnA3UGZNNHNUZzBabURXZ01xamt0SW9wc2R3KzN2?=
 =?utf-8?B?QlZBMSt6em1mVEpYQlhxMDYzSWhwN2xoRHZnWUF4Tm5wYTVlNzVuUlM5QjVY?=
 =?utf-8?B?SU1SekhVU2JvSzVzczcwclhaK1NqTEdKbUVxQTlMWUpaN2NzcXZpQ214T2pR?=
 =?utf-8?B?YzJsemEzNW5STnM1emdON2FUaHZnQzRuR0VBdWdZWjBZNk00cTZVdHJVVW1M?=
 =?utf-8?B?QjNEOCtNMUM5a25pcFhPTFF2aFlrWmQ2TUR0cUlIemdFUGZIcHhuYjZQSDJi?=
 =?utf-8?B?QU5jRTZEQ1M5aTNLT0hsbW9SQW0xbysvNnliUEhWa1dxWld6MVVuN1VNSEJo?=
 =?utf-8?B?ZEhDY3VYM1E2ajJVQTZzOTd5VzdTOFhCK1FHeXBZVm9LS0RjMktQRThiSFFV?=
 =?utf-8?B?c1R5aE15NlNHUUR0QW9NVG5qeUR2MDl4NjVoUGxGaHhxZ2Q3bnlrK1E2UWla?=
 =?utf-8?B?cUNqTlpldVkyNWF2S0FPaENRVHdNSTdDaUJSazdYTHgzZnRES2pwSmJ1R01C?=
 =?utf-8?B?ZVJ0cW1rVzRKRjdHNEdJRWg5eEdmRitWWWZhckpKbFdqc24ySGpwK2dtS1RQ?=
 =?utf-8?B?bjhhRno5UkxzSm9ucWw4dkt6ZTRIM0pLbFdFMVdsQ1RqVEdJWUxxc3N2aktJ?=
 =?utf-8?B?cndGQncxRTBJTmc4N3JzSUpFZXJDN29EdGNmUXhycXpEY056Wjg1MC84NUZ4?=
 =?utf-8?B?dTlTV1h5RG1YWnptTXh0cnkvd3d3eTlrZUVXWS9PNnR0Ung4RkxqMVg3Kzlo?=
 =?utf-8?B?VDFZVm14cG9KbXVPWjM3Vy82M0k0STJldUN0cWxYTjRYcXlVYUhKb0NUeVM1?=
 =?utf-8?B?VFlac2gxbmliUVVXazhmZVBXeWhzOWJHOHZ4T095YWFkeGlHL2RNSzl4TmZU?=
 =?utf-8?B?dWpSMEsybk5CZlhhMjBoRXlqL2Vtcms4NlBrWWxzZUZEcmE0QUVjNTRMd1Rz?=
 =?utf-8?B?NmNOU2x5ZFA2RDBFVlhwaWdsYU8vQXB1d0FUVElqMVIyUTFqd2ZnVklDaDU0?=
 =?utf-8?B?RGJ1U2tHM3VqYWRwUlh1Tk55V0VYZG5URlh1cDEzMzE5UkdPV1RYbVhHWit6?=
 =?utf-8?B?d0tUU0s1aG9mbjN4VStsUzVOWUlneTJ3dVNuY2UxZ3pIaTBaNmxjbDdTTUVJ?=
 =?utf-8?B?aVRMaGc0U3ByampCVXl2bWNrczdMc0FLT3FMbjh2dTJWMjc5SkhDTnk3eGpt?=
 =?utf-8?B?MzBMdkVFQU1KcUFuWXlaNm4wV1FUTm81WkpQSXl5ajJIMUw5alZkeG1FdFVq?=
 =?utf-8?B?bGV0VlAxUjd2M0dGaWxEVlhlY2lVTG5QUzRyUjlHS3E2UFpBWDJ0K2d3bFFp?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 418a807e-de5b-454f-9838-08dcde2e7e2f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 13:24:04.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1TLEcWzxm2Q+2hefGqR+ztTYdhQsMgHLIHjWT/RMFPwWNqt+YCQNKiTAUEEnnm1c+X6mCTT2RgG4YfclNFKn2vvxnMUb8nF6Dkc8/eMacI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9101

Hi Jakob,

On 9/26/24 3:20 PM, Jakob Unterwurzacher wrote:
> Ringneck v1.4 can contain (placement option) an on-board ATtiny
> microcontroller instead of an STM32. In normal operation, this
> is transparent to the software, as both microcontrollers emulate
> the same ICs (amc6821 and isl1208).
> 
> For flashing the ATtiny, the SWITCH_REG1 regulator of the board's PMIC is
> used to enable the ATtiny UPDI debug interface. If the STM32 is placed, or if
> we are running on an older Ringneck revision, SWITCH_REG1 is not connected
> and has no effect.
> 
> Add attiny-updi-gate-regulator so userspace can control it via sysfs
> (needs CONFIG_REGULATOR_USERSPACE_CONSUMER):
> 
>    echo enabled > /sys/devices/platform/attiny-updi-gate-regulator/state
> 
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

This is a candidate for backporting to stable branches as well I assume, 
@Heiko?

Thanks!
Quentin

