Return-Path: <linux-kernel+bounces-236124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1036191DDC8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDD01C21679
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5337913DBB3;
	Mon,  1 Jul 2024 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="VXz/GQ9v"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2108.outbound.protection.outlook.com [40.107.104.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441B912FF6E;
	Mon,  1 Jul 2024 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833094; cv=fail; b=nMGfwdVDhlvR3yNshjzz5j+x+iUJnKZtHWLYyAyl9VN68qcqfZ2kXhjWllFHrs3g7zDsaWg6bhfH7B54kjjpb3SL/wFVmyGi+Ag8+iCPRVFj0zLMlcVvXqVWj3XlB8pbmb7fED/RbCB7JfsHD2997XLQHtPNgalMWwasKXgKLAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833094; c=relaxed/simple;
	bh=H34MgRwUmVyKENuwOOAZl5Iou5tlnhxSoB5I8mrhYvY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CSkBJptuNTNwwVc92HA0roZjQWSZp8Z4qh5pU4c1GSYCIgjw142d7i4vwb8tKJ+E3pRPChtGfgNhy5AsQ1Ni3g9f8XXHXw1pNZYw55ghwsWy5cLIuiKA9YwMtDAzOQylIC/XYpeIIUtLspR0HbrpnmihKi07lExiWmXqyJAe+Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=VXz/GQ9v; arc=fail smtp.client-ip=40.107.104.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSHu/Mpprr2Z7po9OGGCbXeOXwH586HtlSvvFMIRdR3EyW+YkgQif9PzkL4ZYc8OD5DDXu0i+0ADf3VC6CrYuRkj3IhNOaGVhs0rX5vx3YbbemjQr0EwZdJ4kzkvkXTnK5oYd+lCU92OLLPh6Y0vAsDqCn76aX5c2kcEfX9qEmhcSLx/NNiyJVS16IqeYAiV9cg7IcaUXZ7cB7tgGDhbWiY4uNsFfl2/V5FL1Bu90aRd1h9t+nLy38AAosQrYrmlgQRx5QuRKdOVJK+XD8HXE38rGwShisWDCY1bdw+VcHV8IjZmKXV2kQuejLgA4NSB7j94p9juJFLkoMmg6ABoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddkrWQaf0ldjKeteJxUsPw8Kz+oVJ6VovIARxkdLHDE=;
 b=b2WervDC4ziO5g3H60KUSgZzYBRrUBWrhmEKqnGyOwsQvQuc5hQybfY9VvPlvQbLH5jSKNV7yD/oLf896fWyX3SwqrY6lNmH6LUmNoJHMBAKAU8Mkm+bsjxhj4pVfD8ixO4ptzY5IR+ZyDrOArLcP5DiQff+OLk8tmkSMk/huloZ1KaqhOXVCsSuAO2twBzvwuppgvHhjE+AsIdNDxiBOkKVmyss6lvGjOi2S0mNyW8siKbIKeV0zlAmuX12rnlaRABgpx99gW9d8w1J8ekIP1RUys+zjpZd5fAFb6VJ+SvJ3TV3gmoGwguCRk5tr6iW05MGtj4skqz+gRIjY0xJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddkrWQaf0ldjKeteJxUsPw8Kz+oVJ6VovIARxkdLHDE=;
 b=VXz/GQ9v/gHNK/dOwe6bKr0lRrvM40h9dyK0xYlXJND9jb+tQAQHdCDHeDGjbg3ZClaGw7fNvQWA0oE+Xr21B6jeFsH1hyVbwJ740yahDm4lrZtNRj5eLJSCFicvPz7UVLeebsHmLgcmpObX9Ip1o7zigmGj60mvhCsgcnRoUdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 11:24:49 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 11:24:49 +0000
Message-ID: <d660c8f1-adde-4922-ae9a-305e145c61d0@cherry.de>
Date: Mon, 1 Jul 2024 13:24:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] hwmon: (amc2821) Reorder include files, drop
 unnecessary ones
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-6-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240628151346.1152838-6-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0036.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::9) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DU2PR04MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b81e93-8ded-445f-8183-08dc99c06b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWxONmZHMWNrSUVuRTJRSU9PSUxSQTEycjhTUHo4RjF1eGZ3MUhOL3RWVXUv?=
 =?utf-8?B?d2FYRVZKR1pnV200VjNocThva2FGQnhNczVydG5kcEhNb1l4b213QnlmOGYr?=
 =?utf-8?B?Ym5CZDdub1NoT0MzaXRlTnd2SHlwc2JBbEdVLytIRVVzVjh5SkRZdVNIQTdB?=
 =?utf-8?B?QjhKUkUrZDE0b0dORnlnQlpqb3E2UmYyUWlxSUh3RFpkQksvY0FmYXFBeFBJ?=
 =?utf-8?B?eUJhbXJQOHc0UHdYakRuTk9aWjl4ZjY3Um9DMXJhOHJlZDhudlV3WVROb1ZQ?=
 =?utf-8?B?UGpobkVtWkJXUytkK0k4YTV5aWZJT0Juc1FuOTFJUXJmV1RLd2NBNmdJdkFY?=
 =?utf-8?B?eFZGRlhQc3JkT0xaRHNVbTFTbU5UclBKWTd0N0R2cFlQZjlLWmJncHJHV01S?=
 =?utf-8?B?UkRzdlNEckZ6L0d4TCtvVnlsaVFMcW1GbWF4ei9uc1JJNGt3OGV5dmwzREpx?=
 =?utf-8?B?Rk9hTVRvQ3V2QUUyQ1ZYQUEzQnBncDlwVVY5NUNzdmVTY0lSUlBvbk5acmJz?=
 =?utf-8?B?djdnamRJSHMvTUFHNG1YVUZ3cGcwdjA1THZrYU1ZbGZSNDVsMkxwWERFTHdY?=
 =?utf-8?B?NGxqUHlqV3JMUGk1bjNBQzQ5YkxHcTVMb3g2K1JIWVdidFNKb0pDWmphcEd0?=
 =?utf-8?B?NlhXTVlYUldsWlI0UWlVRWVhZWpscndaNjNXZFd0OGRpc3I2bmpwalBNa3Nn?=
 =?utf-8?B?ejZ4aGx5NEYwbXVkcGc0blNHSzUxdVExSHRSRHFpR1JucC9jMmtNQm5pNENp?=
 =?utf-8?B?T0FaaXNOWUE4TVhFVkxtZmRpRUhsWHJEcithTi9OcW5TMDhtM00zOGdrODZu?=
 =?utf-8?B?NVRGdE5TbzUxNVNabDZGWG9Wc3Uyb1ZPeFg1aE1PMDVQRU5uOGUyU0IvYXNX?=
 =?utf-8?B?ZysvZkVBNEZZRUNlSEtWei9ucE1GNjJ0azhEa2xkTXcrdGkyYk0xb0JqdTEw?=
 =?utf-8?B?NkZ3MDAyV2w3U1ZNTTVWalhxeHBXTEFyNE9sZFBpdXYybGltd0FHUFhJWXRs?=
 =?utf-8?B?cDJJNjhrdU45Y1VLQkRVN2dVVmpkSU1BMXB4WWZjKzhBS2JTdnpxQlR3ZXk4?=
 =?utf-8?B?TUthS3Q1cWp5NnJDNzZNbkFyakcxWGNZYXBNRVM0WDNIcVk3Wm5DZU5pamNj?=
 =?utf-8?B?YjhaSmo3Z0I4b2cxRW0yWG82ZUp1K3cwMlZBelU4RUVTU29ITnFWS2RnRWhl?=
 =?utf-8?B?VDVQd0FKODlmcjVldjB0SzBnZDNOU29yaExOTzdYVUdrVXkyZjJjNDRCVDNJ?=
 =?utf-8?B?Um1xK3dHZnNwQ21zNjE2RVNENkhxVFRjQTdQbXRadXZVeU1vd3VJSDQycjc0?=
 =?utf-8?B?ZTc4alV1VnlmWlNCSVNTZkVPN0RiYytMWTJFNzJIKzFpcjNpV2FUd3k3Qkcy?=
 =?utf-8?B?VTkvUVdXOWQ4bXM1NXduNThDVkFDWllwMDVxRjNDOW1sOTdzcmR2Z0NrY1pS?=
 =?utf-8?B?VkJzc21UcVVmcjhNZUdPS0psYlRNTG1JNVBtMnIxNFBlVEk5ZmxNT0JzKzlT?=
 =?utf-8?B?Zmh0N1VPdlcwdVl4eG1UOWl3dklGUEpwRWViVEhtSWRZd0FiQ0gxc1JxazQx?=
 =?utf-8?B?dFl4aGhyaWhVWDZNUEk1dXJwbTMxR0JOVzl2YS83WUpPTEFEb1hKcEovbEdt?=
 =?utf-8?B?QW84clRvRy9NN01NVDg0a2FwbTN0TUkveUo5RlBnZlZhRlBTYis1b0JxMmlp?=
 =?utf-8?B?VUxlY1M3dkJRbG1CUWFwM2ZMOEtRVVFEL2NZeTZkOVNXZ3l6c2dlTWIyK3Yx?=
 =?utf-8?B?eHg2b0tIZUlFT1BRajk3NGs1S21HaG8vTVc3dkNvejE3b0xGZUtsTktpL2xt?=
 =?utf-8?B?cWErQnhGaEdDQU1tVHpsUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmJLV3dxcndiTGt6NDNzOEtPYjhhV1VxeE5ack9VUENsSVQ5MG5uVkdNNEZu?=
 =?utf-8?B?WGl5a0NJNGpHWFpCRWg1V3BRcnd5TjE4K1M1a3pTVk1Fa214Q1F5SEpMcW5a?=
 =?utf-8?B?TTkwa1lmNE43dGx2OGVpRjB6bUltU1lmMDF0WjZ4VXNyT25uZS8vR2IrNFp2?=
 =?utf-8?B?cWlvZmw0bDZEOHE4RHJoV3I4aUgrZ3lhVE5kcUhEQ3dMaXlUckg4cm1VUHdj?=
 =?utf-8?B?QTZBRm4xZS9jZmtiK0JTcjd5QkpLMmtLQXhIZnlLSENDL1QrVkNJL3BOUFNK?=
 =?utf-8?B?UVBFZjB6L2xWWjQ4QWE3aDlhL3J3V29OeXRrczVNZHh2aWoydXdBV2tRekhZ?=
 =?utf-8?B?QjMrSzJ0WGNyVnQxejNha0Q4WEpOMXE3WFh0LysweWdMNFFrZTJFZnBuOHdT?=
 =?utf-8?B?L2VZL0Ezc054Mk4yVjZLdWhvWExHSHByNi9PYmwyaWYxSTJPZVdpVlZ3QjNK?=
 =?utf-8?B?MzN0ZGp1T2ZDTzFqeE5yQ2tRL0gvVEY5RFBDZ1ZHcG9Ld0o3QytHQkRSRWdP?=
 =?utf-8?B?d1pxSVdSMlI3RDg0ZFZkOEhOSmpFeXdlejU5aWs4N1IweFFISTZDTnFQMTBi?=
 =?utf-8?B?dytnZklHREhINnVUOFYwL2hhWnllT1ZORHZlbjBJLzFKbytTYUF3bzE0WWN6?=
 =?utf-8?B?KzBDTkpiZ1dsMDh0YjRIa2xCdmZrMVBOY1BqYkJXK0huQTZTblRHV21ERTdh?=
 =?utf-8?B?UGZnbXIrSWd0SWVlVTFQR0R2UjBvRG11d3NhS0VCV2N6UkdzNjFIWmNOZEVl?=
 =?utf-8?B?bm9pWkh4NkdnUVBISW93ZXBXeDMzMEVhQWE0QkRlSnFOSndPMTJ1dFkrRG1I?=
 =?utf-8?B?YzJPQ3I5Q2c1dFdqMDltQnRLRzZxNDFNcTUzVmhhV0NldFlFd1hCVTJ4dU1B?=
 =?utf-8?B?ekJiRk1SQ2JvNHJCK0pMYTJIOFZjbm5IM3JDNVd3dDdRd1p6aUo2MlptTkx3?=
 =?utf-8?B?cE9lN1g1eC8rN3ovZWJ6dVVUczRuVUpFTURPWDlpY3l5c21wYnhrVjB1aUZ0?=
 =?utf-8?B?b1JWclRJcnB5cFBWaFJxQ3c4cWk1M0dZUU5hczRESi9mTDN5Q202UjJONHky?=
 =?utf-8?B?eUdqTzZmdU9VMlAwcml1Si81aHJIa3cxSEdqM2QxeUlETC9SWXd0NWNLR21S?=
 =?utf-8?B?c0I0cWRpRDBZY0oxNS9qbmhjem1sTUkzM2hHREp6dEVvN0dSY1ZreC93RXhE?=
 =?utf-8?B?bXdidFUwWFlxSUJzdGV3cG04Yi82S25FODB5cE4vUWlpMXI0MXpiS3V2dFFa?=
 =?utf-8?B?NW9wbzVDd3RXR2hoc2ZFWnBwdlRmZGplMTlIZS90eWlvMG1jV1E3U3N5SkFi?=
 =?utf-8?B?Slg1YlZNai9iNXVmTTNldkVUZWx5aVBiV1Y3aW56Q1I5clJETi9XMVhiT091?=
 =?utf-8?B?OEhyMFRVNmlmZjI3MjhXOUVlNlZDekhNZzZvVngwSU5FcEVHWTE5Z1NjZDk3?=
 =?utf-8?B?MU9uNk12Z0FpWHFkUVcwK2VMN1dQVFN6UWVBeWFLalJVeWtaK1loTE85Mm5D?=
 =?utf-8?B?ZU0wSGZjNDZPRFB0QnU3Z09mdE91VUpURjJueldyY2l2cDJFK3FIS1B6NXNx?=
 =?utf-8?B?OE1xZ0ptS3d3UmVzbUNoQW10YjBmQ09qOFp5Y0dLT29pVTFab0t5Y2NhZTJT?=
 =?utf-8?B?NHA5M0xuM0J5OVFnTitPV0J6N0MzVHZSV1JKMTNqZW9PY2I5WUZDS05nak1h?=
 =?utf-8?B?RW1zcEVJZitUcHBOa096R1h6Q3Ixc05abUZXNGdYbkkzcE10dWhuY2JRdDRk?=
 =?utf-8?B?KzVOUHlkc0YzbWpEd2FnQlZrV2gzNFlUZ3RjaTdnSXdPQ21HTHdEaDJiaEhS?=
 =?utf-8?B?Y2hiQlBTSE5uTFBLTENTaFpJcHlQZjVvMVVTTVk1a0lqTDRhdk5mcnlBamp1?=
 =?utf-8?B?enhkdG5MK05pbTlhVTliT1h4bDN6dEpmU01TMTVQWkQ1aXpjdkxFd2xUQmhJ?=
 =?utf-8?B?T1ZXMjNka3pUN3NWZnIwTjc4K2RSQ3ZKa0JBTmExZjNoOTI0OW9MTU1mRzRU?=
 =?utf-8?B?a0txT2k3aFJFWHo5cDdoUStPZEVHcTRiWW5UaGVXVyszREZvdHdVMVdCbXBS?=
 =?utf-8?B?eW5xeUNpTFUrOFA4SjgrbG02dkhnUGpIdmxGT2RHOFRyM2tlaVl2WFFuTjVz?=
 =?utf-8?B?RkFwdTZjVis0M0w0dVI2bERsSUN5YlJPQ2hLOVpvTW5wazNuUTdycEFsZFJS?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b81e93-8ded-445f-8183-08dc99c06b0b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 11:24:49.0057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MstOo/FE2l0f9g23/Daclmtuo+5O1cne2l67ufAwYgcevywX//umckXl8OJzQ4jCizeTnnDhvSPNn2slX9y5hzAev95IiGCTFAkiqxlX+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552

Hi Guenter,

On 6/28/24 5:13 PM, Guenter Roeck wrote:
> Reorder include files to alphabetic order to simplify maintenance,
> and drop the unnecessary kernel.h include.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

