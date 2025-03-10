Return-Path: <linux-kernel+bounces-554425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4CDA5978C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C4C188E59C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0605322B8D9;
	Mon, 10 Mar 2025 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="FtunF4RA"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021117.outbound.protection.outlook.com [40.107.192.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14926229B1F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616824; cv=fail; b=EftUuD3eqN/xQ94TVsNJjIyoYThG4lcaRD2va/XQV6VMIwd4+t0lJ/UVNXP49mzqqRrk2eu9s4HsuSZYF2wX5661z41XB6qCx30zd63LkX2XTZJzB1RH8WnYvBmWX+5hMX1T4fNiK2kGfYvWIaGT8hlfAyDLWAvZErUBA2OcpP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616824; c=relaxed/simple;
	bh=JeBDCjtMIPoL0WCeb/4whmsg1h8b2z0Ju68mNoQjXf0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G0KFGr3A1AviAmDxaNXtVrmwAyGbTDrGJVUhLeWAvGkJ/kzuh1E3CwUaTVlsgZSSUURDsMk+40mmC207SrvbkHrY5Eu5NIu/Ip9VGqBzc7991xw5A6PZn3dpbEesUmJ8r4xPOUASBUZ0OvQrb8BX0X/29/CFNx5KpIE+ZcCvLA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=FtunF4RA; arc=fail smtp.client-ip=40.107.192.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4IWfmiSoA4Mk3i98jAC0PcAVTUwA7/Ss5D5RixBqnwg2ollHeH7+YikINujn2NMuDe0Vfw+EB7wTvoDTIzj9zDkyzu7YTf2He9DQVBVhDF0TRXeAy3oPZvlNZUgAxqy09HxzO/3YbNCNFhT8J+ppGoKxCXJRX5+c0oNgIGAKAUbwvw/K5ssNArg2BP0OI6ZJOqnQU8SmYmb6kPeP6gNbECLwUPZk4XQ1YwCavaQdb3pN4axkFrVCElcQvP6xikw0HotiIKJ7Vg+N3v3DqsJdardoFal6uQmhU8urQtU5jegdwXG5T9Ut9HuswYuFE2xmrfxaPuy3OQYgsZo4HFMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTHXI+N6Tw45A8hbfMBusd3vHpb9Kta2rU1CoL0rRZU=;
 b=LCYqyYSSMdjPmlAR0VCzg0U77hxlvMaT8xJz4lr/93zCSyv24VbddZbw/4271KibTfFbcXWFERS7G/h8XumZ4VSHHuQgf4ir0zthodndMirR+8iW478uk1Bmh0B44XoF4vgZVaZZTbryh6aTxAPwqIijoITcpjC0FG19OiRmOWTDdImHPcfjeXITIk8spOQl/8fbgEE8lnc7tkqgvY+4jy0R9731hzS1k/ssrPZ/lBhsFM/kKT3F34GqPKKcI23pAwtDnI7xE2xGYAPu+NZAt7BzNYUHZ+RIihUVVTckHqZDeCh5jkXsiRSW/TsiW2G2hQG1B48scxqfb5mdKUUNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTHXI+N6Tw45A8hbfMBusd3vHpb9Kta2rU1CoL0rRZU=;
 b=FtunF4RA8+PhIKYpJIe1md7oAJTM7hRc2cNWh7o71dk6VHR9enhTVYDXHQ11ZP55teW8RPWPQXsW88PIGRWIjYoHuIBXnsiuGPdbOj9hY7B+BxxjPbUAFRaDI3snNux0Xi3qGvOf9GJKIh/dXZ8cfKjyCcBtQCdHCwZ0+IEmZn/YOVUh9v+4sQ77yxwuO99dg7qCcMLdCbcsm6ZwjPaMaWODecHyNJKFTEQxKhziZX0s36HwSz+/vliA/dRKo6taBIElPvrcxFtjPl6cW792vGXtOL9bCYdi0srqHDSv/n3pmrSoRZoh9gzFUQRhbU2rZYVjx9qFKscQVXAwhS/FVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by QB1PPF7F5753167.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::253) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 14:26:58 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 14:26:58 +0000
Message-ID: <2dfdd471-813e-4188-9f48-dff99a0d2450@efficios.com>
Date: Mon, 10 Mar 2025 10:26:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] rseq: Make rseq work with protection keys
To: Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
 boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com,
 elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1740664852.git.dvyukov@google.com>
 <e534910c51271eebf4055a92f3b1c5ac998988bc.1740664852.git.dvyukov@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <e534910c51271eebf4055a92f3b1c5ac998988bc.1740664852.git.dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0300.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::29) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|QB1PPF7F5753167:EE_
X-MS-Office365-Filtering-Correlation-Id: c37a56fb-740b-44af-09e3-08dd5fdf9dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2FxYTg4OGtUbldkOU4vU1RmV09IeEVFNm9qdU1EVzI0azJXMVhzczNwc3BX?=
 =?utf-8?B?eWNUVUVqWDdHdldKZEVDNWlKd0xsZnQ4Ylgyb0VJM0lXS0JqM016Z0cvbkt6?=
 =?utf-8?B?N3VWbVV3eUFxeXBORmhES1dtcDNMZ3o4YURidll3S1cxMG53S1RldDA5YTI3?=
 =?utf-8?B?cndBb1FKUzFhKzJtTXhjQlBEdWM2QUV6SGw0K0JrYUNSWGVjdUdUOWo5SmZw?=
 =?utf-8?B?cE5SZk0xa3IvbXFDMnV1ZkRRZE1ldWlUeG9JQjFDVkZ6NEZFd3VmbDVZOXZ5?=
 =?utf-8?B?L243cXRuOHhLRWkyVWhlSEdBdE5iTDNSM1Zld3NacDVQcXljTVZoa2cvbWNM?=
 =?utf-8?B?MWlTRlBlUVBkQXoydDh2K3VpTFIrNW4yZGtnY2QraE1iOWY4VDlHYml4U2JQ?=
 =?utf-8?B?N3RDNW5NMFhmNi9HMU5RVzRBUXNMWlVnc1NNNnBSZVRqeXFMTWplVDJmSjhu?=
 =?utf-8?B?WEZWN1lkL0VYbGNFNEpTMmxtQXpuSWIwWnREbmlYNVZwdmtISXRMUHpMcnFM?=
 =?utf-8?B?VGRRbTlGaDJiZjJVVUVISFA5S05wK3M5Mk1WUXl1WGU2TXNOWkFpUEIrTHRB?=
 =?utf-8?B?cGVaNVhmNHFkNzdTeTJEc04zZHRwQ1BRM0NzWTc2b1doRjBjbklYYWpCSFAy?=
 =?utf-8?B?dW43dEJ0QnNQMCswaG9ybU1KMHV0VG1RdEl4QStBWFdtY2wxZ25hSit2M3pa?=
 =?utf-8?B?SlZhM1JMUkFtNytyd3I2ekZjZ21ERVFNb1dYei9wYW9iNW43S1lEZGdUNUFl?=
 =?utf-8?B?b3NNUXlZTUJ1SHNVWUUrOFR6MGJkSVdTdC9LMUxRdHg0RDlENGY5RDFFbGhM?=
 =?utf-8?B?QWVKcllNWVJ0UVVsTmdsZGxKQXdOamJ3TWtNOEFWSjBCTnNTN3cwRDVhZ2kr?=
 =?utf-8?B?SmErNS9kajRoTXdWRm1xS3UzY2NnZHhKUVkrY2tiZkJMRnhlL0hxK09Jajcz?=
 =?utf-8?B?eUhzMURWT2JjTThudFcwM3AyamwyS3VpRGR5amZxMWJMdkhESENFZnl1VWxa?=
 =?utf-8?B?a2N1QWNHcFhMWWlpVXpvTTNxYzEzKzJJdnNDSE9xL0lOZkZVdHduclNVTVFL?=
 =?utf-8?B?YU43Mk5wZWNTcTlYSWd3WG1hMUJZb3hzaFJpTXFRWTVHZmxVUksyelNSTGda?=
 =?utf-8?B?VTVuYUpGUXgyNVdKN01OcnJQY1orc3BEeTNMbHFXU2JsdUNNWVhYOUdtRHJr?=
 =?utf-8?B?a1lPLzZ6YTdSc1dITWtHTkg5ZE9xY0FjbDJjcC9EY3RtOGRmbDM1NmNSV00v?=
 =?utf-8?B?V3lORWNna3RtQzFDWVZ1cnBwcjRCRGl5U0lYUW5hMDJoR094ZFU2YklhTkJw?=
 =?utf-8?B?VWNHVVFqYnBSWm16eUY4M1lwekdHbmJQM1Raek9Yd1ZwMkRHVUNIelRvUlZv?=
 =?utf-8?B?V1hzdTR2QjNLWnNVQzFKc2pPSUhJK004MDJNaUxpUzFYSUQ5ZlBJblpPdmNS?=
 =?utf-8?B?VVhKbjhacUpCZjFQdGRqS3JIeko1Y1R5Y280Y1BDWXRydjJCdWFWWkxwcWRT?=
 =?utf-8?B?dTVFWlhDL2N1TTNRNFZrQ0hscGE3VzY0ckFId0JsWHNrMFh1UDZvaTV5ajhn?=
 =?utf-8?B?N0tFVkkzT0dHRUswV0xOYWtOdytWa21TdzZJTG9hNllJck5FeGVraTB2OGE0?=
 =?utf-8?B?VW1OWTdTcW85ams0Tks3a3BWSkpKdDlWeEtYVStnTXZQMXJFRXdRZ0kyRUpr?=
 =?utf-8?B?OHlEY3FNZEtPY1A4S1dXY05yZTB3NVZmVmY5MGVOamczM3Y3NkpJZjRwekk0?=
 =?utf-8?B?THZabHppY3BkZy8rVGV2b1prSFovay9ob011SVRzQ1ZFREMyaE12NldxTDBa?=
 =?utf-8?Q?WCe1Reo/zsJ+AvhAtkx0gI6A6LVoVgmyQSQss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkpnUE1iWVhrNXNYZXEyb3JHemIxbkRQMkprUGlmVTdrSmxjMG43cTUvZnFn?=
 =?utf-8?B?YWFwcWtRUCtINGt6cG1zT0J0Q0lyYkVWMU8xR1ZkSjdRZERoRzhFM3NnQjF6?=
 =?utf-8?B?VTZodTN6R1hTbVRXQ0ZncXNWTXdLUTczTmcveDAyamRNUmduUlpoeU1TT3hO?=
 =?utf-8?B?WFpUK1BGeFpBbWMzcDdPbW1rb2ZDRllFeGJUNHVrUTZNSFZRMFM5czFVT05q?=
 =?utf-8?B?M0wzSUQ2aUlCcWZFZFZQam9IVWRlS1ZPUnQ2cFZRaGpmMXUySWJjSEpPTDIr?=
 =?utf-8?B?Y1JHUXRjK3kvQVpLSGRkNXFFYVBHcUJRSUxpSGVJNkVkME1UaEM0TXJpcVNn?=
 =?utf-8?B?NlpGNlRlcUJVemdud3Y1bktXQU8xTFVzWlVobWdjVUJaYmpONVhheUtBUXh5?=
 =?utf-8?B?aDFtVVd5aHZkUkkxZEtjSlNrZlBpWC9laXBueEZkbHFNQU91d1B1TkdJREJ3?=
 =?utf-8?B?ZXR4VlRQN0Vzc3VJM21QbXJZZHY5QjlraitxMzM1NDJFZ0FJK01adFJCTXBW?=
 =?utf-8?B?LzBBMi8xVG1PQWpSZVNLc0xVQ2xpKy9DdUZlNDkybStSSlBhaFUzcks3Ukdi?=
 =?utf-8?B?engvTEpVZXBsemlONXY3b1JsTDBVNWtXVkpDSVQyc0xHbERSalA1VnpKTHpS?=
 =?utf-8?B?TjBMaEZRV2RzNHhqcVpwYTg3Vm5vODY5cC9wb1lEK3E1a2tYVXIrTk96bVYx?=
 =?utf-8?B?QnJES1VaQjBzdzI3RjFXVExsYjB6TVdPMStxZDc3ZWhqTUY0b0lrRzRkbnIv?=
 =?utf-8?B?STRxSzdjV0MzcVd3WWJYdk5IZHNxLy9GTkFUTnJjcWhJT2xRTTJldmdZRURE?=
 =?utf-8?B?NU9TWityVGllaTZwWWY4SEgwSUxrcWJxT1dhUGtlcVdqcXVMaWx1MWxYcUlU?=
 =?utf-8?B?L3M5bmExNjZDU0ZiemZBZlVhTjUxRVlWbEY0cDZhVmhxdG9hUnNqUS8xMStu?=
 =?utf-8?B?VHdzYTh4UHZyMXU4MXhYbTVIS1NYRmx6R2xackdnYmMxYk5DVEI2Y2RKeWll?=
 =?utf-8?B?S1pFSTVYdnBBUlhkaDdOdVFSenBlSGpsWnB4WVNORHlNVzI3cVVRVFNybWRt?=
 =?utf-8?B?cTJ0RldjUEJIY0xQeDNXbk5uNGw0R2g5NnNoV0F5c3RXZkwzY1ZPVmtyWStp?=
 =?utf-8?B?RS91Yy9Mbk9qM1pPaCt6cktSN2d2STVwbm43aVlmMlFnMWdpTkkvZUZaUzlM?=
 =?utf-8?B?RTRmSSt4ZjgvL01LMFpGM2g2TTNkSXdCMHJ1UUp0THNtQ3ZDb1YwRW0vbWxN?=
 =?utf-8?B?UkRnenJDelJPbkY0dUFtNnlQQXkrRUIvcENFUlhjdnFrN1VHbzBVdzB4NU9a?=
 =?utf-8?B?bURpblhVYkQvNzB5R1hPMjFyaE9OdXh0Z1FjRTdnYVlGVFB5YnU2KzNKaVdn?=
 =?utf-8?B?NHZGRFRBYS94RktMNm1YZDNtdW9tK0R0MHZxdG1pS0kwSWNYL09rUUJQSmZ4?=
 =?utf-8?B?akxBUHNvTTZmdmc3ZjZqMURqNnNuSGZwQ2JHU3VrUGJ5aEdBRlRBVlRZRzJZ?=
 =?utf-8?B?RHloNzJtcU14ZldndWsrb25ET2kwNFIxeFVINCtsSnVPTWlhVjJhRmxNZjZy?=
 =?utf-8?B?UURRWmZXT2xLNGhIWHhweTBOZnRCQlFPK0R5VlVBdm43SmJuTnFoU3UybkQ2?=
 =?utf-8?B?VDBtZ05RcnJlR0c4V1VLWXJYTXNCMUxQVmZOamI1am0zVDY0Y1hTTzNRMWJq?=
 =?utf-8?B?WmF6elBWUS9HaGpHTm9tUS9UeXJKQkRnRWlOVjdoVHYrbXp2RHRRZ1BKdjg4?=
 =?utf-8?B?bmUzQm9vdllFK1FvMlhjb1RBRmFzUmp0d3FaZHFIMmtjemRtSytBb3VFSjJW?=
 =?utf-8?B?anpFYStaWGJNWUNRT3FxNkRGNm0zdCtiNVN5eVl4V2ZKbmFJbklsZThua05k?=
 =?utf-8?B?dXB3Z3NXSWxLRzZ0d3lNeGhtQzJCNklwRlhFZWNDWVgzdG1nQ3RvSGJFTkZR?=
 =?utf-8?B?azZzL1ZJeWZvc056QUxldUxrM3BFbERzOURMY0UyOCtzUGRPWkV6WitVSjh1?=
 =?utf-8?B?S0R2cDFLMENGc3VOcTRraW1Ia2NXdkUwNTR1QXRLTW0wclZ2c25IbXJTRVNl?=
 =?utf-8?B?cWZqYUdDUWxBSlBJZzQwcm9Ock92TWtnK01kaGw0ZEwzYW5HWHhraE4xYStk?=
 =?utf-8?B?TG1EcTk3OVlCdHBlRTB2dGd0RXFsbndiaUt3TUtyZXNVUjIram5PV0NDVm14?=
 =?utf-8?Q?65rF0kQ4jGv0eyt86RjbGjQ=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37a56fb-740b-44af-09e3-08dd5fdf9dac
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:26:58.5857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRsEb8V26X8WQJbSQILIXRTuXejvZjOL7sVRBH3gOMoS2c54b0/E5SgizlQPot6fHZEpdaoSoBRC9k2F3RIiI9PcNqhIorZ8tjDAzWSNLPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPF7F5753167

On 2025-02-27 09:03, Dmitry Vyukov wrote:
> If an application registers rseq, and ever switches to another pkey
> protection (such that the rseq becomes inaccessible), then any
> context switch will cause failure in __rseq_handle_notify_resume()
> attempting to read/write struct rseq and/or rseq_cs. Since context
> switches are asynchronous and are outside of the application control
> (not part of the restricted code scope), temporarily switch to
> pkey value that allows access to the 0 (default) PKEY.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> 
> ---
> Changes in v6:
>   - Added a comment to struct rseq with MPK rules
> 
> Changes in v4:
>   - Added Fixes tag
> 
> Changes in v3:
>   - simplify control flow to always enable access to 0 pkey
> 
> Changes in v2:
>   - fixed typos and reworded the comment
> ---
>   include/uapi/linux/rseq.h |  4 ++++
>   kernel/rseq.c             | 11 +++++++++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> index c233aae5eac90..019fd248cf749 100644
> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -58,6 +58,10 @@ struct rseq_cs {
>    * contained within a single cache-line.
>    *
>    * A single struct rseq per thread is allowed.
> + *
> + * If struct rseq or struct rseq_cs is used with Memory Protection Keys,
> + * then the assigned pkey should either be accessible whenever these structs
> + * are registered/installed, or they should be protected with pkey 0.
>    */
>   struct rseq {
>   	/*
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 2cb16091ec0ae..9d9c976d3b78c 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -10,6 +10,7 @@
>   
>   #include <linux/sched.h>
>   #include <linux/uaccess.h>
> +#include <linux/pkeys.h>
>   #include <linux/syscalls.h>
>   #include <linux/rseq.h>
>   #include <linux/types.h>
> @@ -402,11 +403,19 @@ static int rseq_ip_fixup(struct pt_regs *regs)
>   void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>   {
>   	struct task_struct *t = current;
> +	pkey_reg_t saved_pkey;
>   	int ret, sig;
>   
>   	if (unlikely(t->flags & PF_EXITING))
>   		return;
>   
> +	/*
> +	 * Enable access to the default (0) pkey in case the thread has
> +	 * currently disabled access to it and struct rseq/rseq_cs has
> +	 * 0 pkey assigned (the only supported value for now).
> +	 */
> +	saved_pkey = enable_zero_pkey_val();
> +
>   	/*
>   	 * regs is NULL if and only if the caller is in a syscall path.  Skip
>   	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> @@ -419,9 +428,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>   	}
>   	if (unlikely(rseq_update_cpu_node_id(t)))
>   		goto error;
> +	write_pkey_val(saved_pkey);
>   	return;
>   
>   error:
> +	write_pkey_val(saved_pkey);
>   	sig = ksig ? ksig->sig : 0;
>   	force_sigsegv(sig);
>   }


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

