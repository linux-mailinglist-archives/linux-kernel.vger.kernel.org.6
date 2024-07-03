Return-Path: <linux-kernel+bounces-239639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC1092636F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A48B2219A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A95F17B50D;
	Wed,  3 Jul 2024 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="bwvYwF4R"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2096.outbound.protection.outlook.com [40.107.21.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB01DFD1;
	Wed,  3 Jul 2024 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016965; cv=fail; b=T9qEBH3M3LdjkuXaBN3WbRNhPyEuvuQZMj5tHd9Nma1mSGi5Ew4lk3RRwBHWrknFugCPBlyqjTUes6VOOcYBnnMto5Fkt30/UZtfhvRGQASiMPVAug+ibmsRA0PXFe6WgFWGeLQRrziiEThe3TWN6JNHDkkT1g3c7eLrCBaXK8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016965; c=relaxed/simple;
	bh=NYw1a913jvpa8JhC4dAXYwG97R6Ceg+Wmv9AjtNM7EM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t/o8BAw18JdcvWMAk6HzB4FcTYheU4F+2KmoqMNJs4Jgjy1XsrBqfQjuPNmKMmaUnlQ6lcewioVo3fpfmrmETtQdzEza0zfER0WF5kUrqgugLOVfCI0ybHfmXGlZG4k99unIu2kzOeti9bS/Qz9VSGMRYLJHCWloY6rzQKEOOKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=bwvYwF4R; arc=fail smtp.client-ip=40.107.21.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aB+qkuJMvjkvkRcfqQ8suwdI30FcfT//QVZrj6J41ZuNSo5m0P3cp/8QHXSwLXZZgGyTABHjhrhoHElEgHUPn4AuXIj+9lNHmkpPlg2el7xhJdQiYBVZF74f+a4ew47JxCIIKy7j7nRzMdjUwJ4lL2xcrOfmM2G/6UDqNzzkxaqN/sT/HZz8P+qnaeInVPWcfmsBhkgZkPcBM1VzNKL2n+Ya0Q1ALzH9ZFqDcdILOHKfHcCEDPeo2ufr4JysDSEeLkPa9nWl+y0AmjACu3mNTsjEua/kNV6j8M5n3TbCcPXFSGO2ledeOhDd31uk20K7vHl7HZezYy4i+AOHmpc4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ39nKDZ3cI2Dk5hut1NeQdDi/d7l7I4nd0AADYGQfc=;
 b=USvFOokgfnp09Z6yMrjj8bZ4TnWbuLUNR+um6p+JiArI8Bu786+UXqQZZDDAS3w6LOJcQ470llY+X2ixjLBUTWE9Co7pO5LqhbP7v60R2N+9xB0Yvqo+qbwxNMARxeCjDxa0gfeM1sOhd42P6T/FFy0UUP8t0EpoUfmdXLVbKGs+oSveM7AslIqVL0znqNByI6YDBQDTUnW/NaRD0lnE/T+BuRCpeCeA42VikS+qeiBBTDEYYNG7HumEKYwBNdtBQ96NLROJw2Up2+1kGpAPpJsqEp7Rba9hpACAhFq/Xem8F65zxMROWbpj7PaoTGg0NT0ATV/cgyu5+FKLyr2uLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJ39nKDZ3cI2Dk5hut1NeQdDi/d7l7I4nd0AADYGQfc=;
 b=bwvYwF4RL/diBRjs9Jfef9s3bsxlWDXYF5aDzIagNIiHRJEr+tGQs2fd4RdKm41oX0FWYOj9o9vbPGRwobecEOuFeDO/9OkeRWcLztZyCXnluSW2h3dU9u/OnIXriIsriFJz3WOhbIFknDBK4/rqTlmdin1icGxbhazwnFsB4Tw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB8PR04MB7179.eurprd04.prod.outlook.com (2603:10a6:10:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Wed, 3 Jul
 2024 14:29:15 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 14:29:15 +0000
Message-ID: <42ab8d15-a195-42d4-a191-a25da00f4c8d@cherry.de>
Date: Wed, 3 Jul 2024 16:29:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] hwmon: (amc6821) Stop accepting invalid pwm
 values
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240701212348.1670617-1-linux@roeck-us.net>
 <20240701212348.1670617-2-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240701212348.1670617-2-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0039.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::25) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB8PR04MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d07275a-c81a-494e-60e0-08dc9b6c83fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmJHL0d3bWE5Tlo1Rm52RHlpM3VLZTYzNlVWWFZBVlozOWtBSTVJQjFxK0Nl?=
 =?utf-8?B?eTFNSDRnNUt0OFV4MGxHWnJDdU8xL3R2R3dGeXZPSDhZZXVtREtvSHBYZ3dr?=
 =?utf-8?B?WFZmd0s2cGdZeVZDQ0hrblJuMktrRGJCenA2eE5mZjkwckhodjRSVVNYN0lj?=
 =?utf-8?B?YWlBNHZZMGRMVlNQaXNmajNTOWRpaXpobnNmRzAwckoyRGYyTEwxQ0JjcE5E?=
 =?utf-8?B?M2RSMlV1ZDBhdTFsU1pxTi9MbExFdEZKcTJuQUJIaXByNkwrYzR1UEZQcjd1?=
 =?utf-8?B?ZWZ1MWUySUhvUVBRdEYyeGNFdVVxczhtOE1NajNhcGhNNTdDQXhvUnNEN0dV?=
 =?utf-8?B?Tys0RDdCV0t3RWVqSWsyL1orL2hHYjdlRzA5VHNJTFJOR1dqZ0tSUEdhRmxK?=
 =?utf-8?B?UnFSTlZ6Nld0OHpNb0VjenYyMnZqOXdpNndGcnpTR0U3S3FBQ2xHWDAzMnZP?=
 =?utf-8?B?dFhCT0JneE0vVG5lYkRDSnFKVDF3VkNxVVhUbENmSjlhMmZkVGpBOGxlaWox?=
 =?utf-8?B?SWNiM2xhaVBhaG5uMGJFZ2JaSGUvQ1BxTkpGQnZ6c0tmd3RRMG1sUHhCZXls?=
 =?utf-8?B?YVQ1RlRKZzVBMWM3NnlHa29HQ2daUk9wbXU4MWVFK2RGanFlV0MxVkM4ejho?=
 =?utf-8?B?Vld3RHhENDBpbzE1TnRCVTVsQ3A2enQySVQ3TVltbTBvdnFEREVxMkwyd1JF?=
 =?utf-8?B?Y0hMUHpIRC9ITis5TnR3QmFMaytGZ2ZDeUM0MDlEbzJDUSt3dFFodHJHa1Vs?=
 =?utf-8?B?aHRNNnhOdGplcm9kaTNteE80akR0dGF5dmpDRW9qU09zYWhWaWx0czdlNVRT?=
 =?utf-8?B?NkQvazNnRTZWd2I5Z2RZbnJDUDA5aERFQlN6Rm10V3QwZStuNU1ERzdOQUNs?=
 =?utf-8?B?OVZIeDBjS1BPV001NzJjeW16OXduZVhhcTltSEppT044cjVBN3dKTGJQZGlO?=
 =?utf-8?B?ZXBKTUQ2MGVWVWhlQlkwbndKcWs4aG9oOVVSdkFrYmJzMmpmYXp0N0N4UUVW?=
 =?utf-8?B?UFBkbGRQVXNuOWxjUld6SDJrMlVTT1d0V1hodnVGczdCemFCUFdxRkVGa1lm?=
 =?utf-8?B?T2R1Mm1IbFRtbzV1T1BsQTdPUnhKUXlJNW9DVndVNVIycGJCOXJ5U24yWVE2?=
 =?utf-8?B?d0Y5ZzhrMHR3NW8vOWxhVDJoL2VLQnZkR1B6cmI3czdMejd2ZjA2UmIrZ2Fx?=
 =?utf-8?B?aE1nZHRIanZzTkwvU0s4N08yd3hTa1pkY3FzK2hxUTFnZlhENzdCbms1Ylpo?=
 =?utf-8?B?VEFwZ09LWGNZQTB1dndUWXFRSzVKSmpBd3pjTzhYVGgvN3VhcGs5Z2pOTkti?=
 =?utf-8?B?S1dvMXZmNUg0elBtUW9KZEYvQWp6Z1FIRmkxOHNTOVh2SmlrWDRkekNqOUo1?=
 =?utf-8?B?RE5TbGhhbUZ1U0EwcXJGdWZXZHNlUVk3OHVrbEU1YkhPZndyZVpvdC9vSWtw?=
 =?utf-8?B?M24xVkNqeDhyNmtpa0NqQmMzZjEwdU9tbWpNSVVDalV6UkdkdjdORFZGU1Yx?=
 =?utf-8?B?ampjSDdpNVQ5RU1oNVo5V1ByZDZycXgwNHJNeFJwUkFUbnd3Q3dZcllFbFJa?=
 =?utf-8?B?ZCtmV1duSmpQZ25LNnNlU0ZRSmJEcjJwVTBxcW4vTm14NGhSaXkycFRsOUht?=
 =?utf-8?B?RWJpdXRmWEo3MWsrVGZydUtiSnFPYnlSa3RJNkozMG5DSzVYN2F3VHFiOEor?=
 =?utf-8?B?Y1dXaGYyVGloNE9tbzlCRUZPNHM1anJZd3M1eXBWQU9KY09GUExMckIydjg4?=
 =?utf-8?B?QmNYUDFhdk9Ed09BTzlmYlBQMkhtR3J5VFh5NTY0c1NUK2RmcEFXeEN3eFR4?=
 =?utf-8?B?YzFDMTR6VUZNQlpCam1udz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qkc2bzFBUldiaFJRYjVFUUFhdWROcDlWUmt1aXRBQndyTWY4eW9FWkJPMThp?=
 =?utf-8?B?K3NxdjFXMXFLckQ1NjhGN2tKeGRqUloxUk5CazRkNGNlVjBNLzNsZWt0V0hh?=
 =?utf-8?B?dTMrQzhwY3I1SnBwUklEcmJpWTBxeXpwOGtsSnFlTExVVHpqL1cxWnpzV0xF?=
 =?utf-8?B?YTdGU3ZoRm9YL0dwQTNGV0tNaTR6NjJ0UnhBU1Z6R21NU044S2k5aEtieFd2?=
 =?utf-8?B?RkExUUUreG42N3VBSnBVZTlueTZTWGVLZm5uZU1aTE5CQVAyWWxyUzFSWFpj?=
 =?utf-8?B?eS9FSjZ0YlFMeWt6b2R1Sm5tKytEckd1YzZ4ekZHcTRENzFGTDZvbE5nMWRM?=
 =?utf-8?B?QUhkSFY0NUhEZTJXK0cwUVBTNzFFV0xGOVRlb3BVS0FQekhGbHVqUkhpUnJn?=
 =?utf-8?B?NWdQemtCMG1idjdqL2wvWTZHY005MXo1aU8ySWVrMStMZURVcDZ6L2psS3pu?=
 =?utf-8?B?Y2ZRSWtRT2MxYm51bVZZVDBXNS81OXB1VGhQNmxEUVlDanl3QSt3TnJmTnlO?=
 =?utf-8?B?RFhQVWxIL1UwVFRtNWlhOTZKZ3Y2azkwaXpCV3ZzZXYzVjZDTmJjNnFiVmVH?=
 =?utf-8?B?YktmSis2ZTRPUlpkYjdiMTQyYVRvU3VkYjFJWWJ5dTVsSzVabFB2RFdPL05Q?=
 =?utf-8?B?LytuUEczNERTSXozVUM0VkU3ZVJJQ1FEYjNnb2J5MnlBais4N3Q1Qks5bG5Z?=
 =?utf-8?B?K1ovTTZCdTJVV1F3d3ZRdnFPS29hUGY3Mk9ib09kcFVrNEt3Z2Y1V2l6ZFNJ?=
 =?utf-8?B?TWpOR0MxNnFkck1EWTFyLzdtOG0zM1dhak54TFRvaDUvVFhndE1HQVVRSHIw?=
 =?utf-8?B?a2k0YXA2eklDVGtmeDRTMUpXcUpNb0MyWW9kemZEU2ZUckNmbVV6SVVKdTJ1?=
 =?utf-8?B?eUJhN2VhOFNXN0pRWWthV2FmclBEdjUzQzhtZE9JNzJaNEpSNXJmUmwvc24x?=
 =?utf-8?B?SmYxeHlwNHZubEM4TnQ4OGI3eGRPUzRhSFZrS0I0d1lHcXdPTjRxQko0bTZK?=
 =?utf-8?B?ZGJNc2ZNcVVLTjRHbnZMWVRaM1BId0VmN2FsSVY5NzIrT3R4a0ZKckpxcFNl?=
 =?utf-8?B?K05LWGdYNzBUOVJzVnYvTVRLMlVOK2FreXM4V0JNY2svUFJteWpXeTY1RU1P?=
 =?utf-8?B?cnJGWVBNbHIxTFRQUVRLUzF4VnpnSnY2NzdBUm5tOExVRWJMTDlOYXFLaW55?=
 =?utf-8?B?VVJLWU5FU2Q5OFJySm5HYW4yNGE1eUhNZTRoZzF4NDVNVGZhREpxUHpnckJa?=
 =?utf-8?B?M2hPN0ZKR1IvaXA5bU9tYUl5OUhIZmszdWtHa1RvWFBwcFZYMllnaDlFVzA1?=
 =?utf-8?B?LzRiN3RGRmVhMUJYWVBrMmNYQlZ6ajB2bHNEYUN5U0t1WjhhbFU3ckovbVZk?=
 =?utf-8?B?WWdWK2V0OHc3Ykd6S3VNYmFCRXJQR2RxUkRCbGtCdExEMVYzSzVDK0VCYnFP?=
 =?utf-8?B?OHNjbkFnTCt5aW8vN0xNcHp6Z3lhS01rYmg4eGFDNjhkR2Q1eFNnYU1XdDFm?=
 =?utf-8?B?UzNVeEJydEtueGwvNWc3WEordFR2UWZyeDRWMWtQeTNMcmd1NHg0eC9EYzRw?=
 =?utf-8?B?b2ZiOTZyYnFVZFRSTE4wZ2QvdXRLMnBLcFdNL0t4cmY2ZXpaMzdRT09tOGdW?=
 =?utf-8?B?QVZPT0RRRWlobEY1UHk1VU9iVVJZbUw0aHZMdEh1TjlEOHdFckFQK2t2amsx?=
 =?utf-8?B?cGtXMjZxaGlKWnBINlh6dGRoQUVUNms2MUdHeXNnNnF3cU5CVERIM2Zpd1BM?=
 =?utf-8?B?cTVwMXhvRktVaGh5Z3pLMlVyRVljUWNtK0hUOGo3NVpZc3RSNUh4MmxsVkli?=
 =?utf-8?B?V0loSnU0UElUbkdKWWZ1Rm5LdDVWaTdvU1hBbGV3VFhzZmlKM1d6TSsxd2k0?=
 =?utf-8?B?TkNGNUtaWFBXKzNETnZNK3J3VnFMeUhSMTNkbmo4d0ZERkdZSkpXMUpaUHJ6?=
 =?utf-8?B?OXh6eXhTNUE0c0JUbFBtMFEwWjlpMU12bGNFL3YwMHNTRDFCR1NZa3k2b2tW?=
 =?utf-8?B?MndQdXBkNVNXSmhkV29FcnpEOGZKL3VlUmRFYitqcTk1RXo1UFFWSG5RTWkv?=
 =?utf-8?B?TnlxK3JSYStieTdxTjZsK0tubThXUDIyVjg3WXI4M1YwSUN2RW1xOC81OW1j?=
 =?utf-8?B?VnRmR0FiMDZSVzdseFZLcEhBSUdwWVdOVmVyek5ZZHp6cm5MQW1jSVUxQnQ5?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d07275a-c81a-494e-60e0-08dc9b6c83fc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:29:15.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoF7AxIYB33KLrqUJO+4lm0y+QqkDllnWwCZKmGXPf1s9GI0MTnDwvorVnLBWjQQQud9t+nzf9uF/0OAcEOCyrdtA6GLjiMX90sYwlhdTAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7179

Hi Guenter,

On 7/1/24 11:23 PM, Guenter Roeck wrote:
> The pwm value range is well defined from 0..255. Don't accept
> any values outside this range.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Use kstrtou8() instead of kstrtol() where possible.
>      Limit range of pwm1_auto_point_pwm to 0..254 in patch 1
>      instead of limiting it later, and do not accept invalid
>      values for the attribute.
> 
>   drivers/hwmon/amc6821.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 9b02b304c2f5..eb2d5592a41a 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -355,13 +355,13 @@ static ssize_t pwm1_store(struct device *dev,
>   {
>   	struct amc6821_data *data = dev_get_drvdata(dev);
>   	struct i2c_client *client = data->client;
> -	long val;
> -	int ret = kstrtol(buf, 10, &val);
> +	u8 val;
> +	int ret = kstrtou8(buf, 10, &val);
>   	if (ret)
>   		return ret;
>   
>   	mutex_lock(&data->update_lock);
> -	data->pwm1 = clamp_val(val , 0, 255);
> +	data->pwm1 = val;
>   	i2c_smbus_write_byte_data(client, AMC6821_REG_DCY, data->pwm1);
>   	mutex_unlock(&data->update_lock);
>   	return count;
> @@ -558,13 +558,16 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
>   	struct amc6821_data *data = dev_get_drvdata(dev);
>   	struct i2c_client *client = data->client;
>   	int dpwm;
> -	long val;
> -	int ret = kstrtol(buf, 10, &val);
> +	u8 val;
> +	int ret = kstrtou8(buf, 10, &val);
>   	if (ret)
>   		return ret;
>  
> +	if (val > 254)

Would have appreciated a comment as to why it's 254. My understanding is 
that the subsystem requires no overlap between multiple pwm_auto_points? 
0 being 0 and 2 being 255, we need 1 to be 255?

Actually, that doesn't explain why we allow 0 here, so maybe I'm just 
clueless :)

The change itself though:
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

