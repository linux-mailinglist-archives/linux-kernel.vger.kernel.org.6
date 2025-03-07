Return-Path: <linux-kernel+bounces-550291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841D5A55D9D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC56189707C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BB7176FB0;
	Fri,  7 Mar 2025 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wz26eIA1"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8954F8C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314038; cv=fail; b=PLmRcKvvKwSBxbp6w4yKj+vTg5RXNDf8qggb8Lwr9h+irk6j9P+Pi/HknwDELrvSm8CdwIyZpwR5ilbcXMU3wTadOGNrCeV52ELG9RfMkw8hgiD2gQNG1akrqptaDsJdLUg3dZhiLDCh4eCudLnEhinJejWEqMQpWIpvzIGtdYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314038; c=relaxed/simple;
	bh=HjvdkB51KWWGhBSj8IETuXVTR8QtKHL/03UaEO+vIms=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dDTSR8ThCTTSOld/i8ORjBdcy4ZVTqb2NilPlUbLDJjCBLZfgEPlDKmNJDdbVWt03qypZSqYxmElDoeMu8e+K+5G9cChjn54Ho9YhBdCQuT1E4mPRLLPX/eJaC2Rb43Qp32ZNoNt1lLWvMg4pEUW/s9t/wt8u5kq/jY7q8dI67Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wz26eIA1; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJkQxnQcIMjTEmcsHWQ6XHQ+lZN7FXHa52aPW0YS7rJKtAu6OGZQPvSeb0SH1m9plGXKbyQXX8QVyY/kRWhP8vIs2Y+Df5FpDtDLV2wOlF3IFC4sIJrZt13qbvmuAzpyIeemBF4mrkx5EkMyacR0RhN5XdPjlDd9hU2KPF1bs08TiYvPI+SKXNMpTEy/KB3+UwLAP+OL7k0OnCAuxZrhaMopEjjCQfV/raiKeyhit+AJNYdTDu13LuRivmamITpl9hJCbl94jDpZ7v4LEiyaXLWt9GrKvCZN/Fle2PEB5SIJwfJbDrilLb4VEuPbXNOuYjQGvCpY/JSgWDB8T8S1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjvdkB51KWWGhBSj8IETuXVTR8QtKHL/03UaEO+vIms=;
 b=bIKOqKjU4GA6TtlHLYshUUr1NLMDpIKW+vDIjgt/o2L7rdyLrE6toXBqIJcB0qmJNjMsEt8eAjX8fe0IC/kINVJ+BXVpk4myrJfZQkt3dpcc9sVNjObcnf9g55wm6FOvEAtSfERQSEihwe1JAUTrt+vABewxGh3yzOP8AAs6ChiI6oUtWlxSZQl1FAjaU71QrV/XqZqHrVKoqjX9h7o+66IizHtqhg4MH54wEPAjWC7aSgT1qS+wSIr/ftSkMnQTDDI/W049gj7WNJ/cqF/eTtzEU8vyHXyr1G+489mqcQI+lKx/0BX2uABcVCvGVLykXpe5S/sDprlF0m4D5hTUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjvdkB51KWWGhBSj8IETuXVTR8QtKHL/03UaEO+vIms=;
 b=Wz26eIA1TgpHreNS5FvkWhjRLkTW4yP9NmR5+p6Bp1zA9JkGdo3uikq8ESEKNqPSak1kNTWzODHoNNjfyW/N/11s+obuiwyx0xE6GfBdExGto4lPjD6uALM4GFEjwE+cUCXvoBcB2iqYO7ailirFIGyv6IpTuoGmQCZxYBEMFEgUsLODjGy/bKwH9yUsNS8UxvKV048um3LaNcSml04DkZVDIy7XI/vNVIleRSG0oUcD4XY1ASTh2v+bYscgNbIEokL+eQ1YwA3uyC/oaeSeExErlr82NMK3vldMbhv9+NC0xt8BX4xyYq0Asj8mqF+w882ZizEkiT3R+QRfMVdDAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 02:20:34 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:20:34 +0000
Message-ID: <63b9c4e0-ad24-4662-8579-6fe6bfb24d18@nvidia.com>
Date: Thu, 6 Mar 2025 18:20:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 42/49] x86/resctrl: Squelch whitespace anomalies in
 resctrl core code
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-43-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-43-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::10) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c79f98-fe95-4ef9-15ee-08dd5d1ea3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czlqOXcxMmxRRVpta0haZzVicmNFVXZDUnBEa1VaUmtubmJOVVNkY2g2N2Vv?=
 =?utf-8?B?QTVjTFhNc1V2WUdnU0dmMEVGZm9HczRxMWdJUHM2cnZXNmtEcWwzT1JpK3ll?=
 =?utf-8?B?TzBEekk1SnNCdUZuMjRLTU9HbXVHZnJ2UVJaUFNGNVhBdXNTQnFGMFI4R3c3?=
 =?utf-8?B?ZVNiTE9wSDRrc3RybjBJUkZYTklpdC9nT0ZHbkdjSU9CWm1LTS9hK094UmVl?=
 =?utf-8?B?dGl2b0J6OCtVelVibm43UWthbGJxdkdCYWMvNVpVUXZPYkV1eGxKcThNSHgy?=
 =?utf-8?B?ZkxEN08xRUJqUk1CZUFLajdJYkprenVRSmVIck5ZdERRNWplb1VjZDdJamFa?=
 =?utf-8?B?WXNhUUJ5NWtWMi92c3dxSVlSUG5VN3laWTNSRDByOFFUOTc4OUtlSng5bUYy?=
 =?utf-8?B?QlgxQTlxK08yRTZGSW0xOW92VEFIUzY0SDExQmliNHdLQjRXZGd6Y3JORkt3?=
 =?utf-8?B?dVhGSUhQbGtBRUdsb1piT2JWM2s4bGphNkx3YWw0bSs5VmJENXJ5YXBmYzAw?=
 =?utf-8?B?emxQTXdRN2JXdDhxb3dJVE5ma0FTd1BvTStTejRPOGpBTjNOWEFzenE5UkFV?=
 =?utf-8?B?OXF2T3l0Z29tQkw4OHhsRTNHbmlWK08zdzFSbkVLa2g4c3BjVy83L0hPZlhm?=
 =?utf-8?B?dVhjVGhVdEhnMUpXUnA1T1ozeTlVYllIellLdGpCeFk0VkRqZUVVRUFBQ1k5?=
 =?utf-8?B?aHBpNHh3NnJUUS8zUVRXZk9ibGtLV2NrSjAwTXQydXJTb1RCNUtHcVBRNTMr?=
 =?utf-8?B?UVBaY29tSjJKV1lFS3lGYm1uYVpGdCs4L01pN1IyMG5PdDVzREtPU3p5bDJT?=
 =?utf-8?B?RDhOZklnbWphUTlCT09GNEtKM2VSRzZ2aVY3SlJYYTE4WTNMVlU1VllSK0Z2?=
 =?utf-8?B?QmZqZGI4V1FVVW82ZFRsZEtQbnhKdVBxWjZZMDZjRlNDZUNjTDY0UWlwWXFo?=
 =?utf-8?B?NHVObk9tRE13RHVjekZ0UzR6amVZZ3JwNUVwRmc4UUg2QlRCQ1I5dEZuZ0hH?=
 =?utf-8?B?OGNvTjlibzNyT0krb0M0dWgvTC9ESXhSQkhnbURReVVXbGpHUWlLYnJ0QXhE?=
 =?utf-8?B?cy9JV0pUUFN6OWlFYnhyZlE5V0xOSjM0aWRRM0hnSG5MWDUzS3NCN0VTNTFT?=
 =?utf-8?B?Y01vSUM4REs0M1lTVVRWeUVoZS9abk1CS1c2UHMxUXpCbkliZTBWY0taWHcv?=
 =?utf-8?B?R3NRQllXWXExdWwxTWk5SzhlR050WGsya3NXR2pXMWQyVGYzbmZoUmtiaTVM?=
 =?utf-8?B?eldZbDdSVWtUVjZBTmMreHVpTlBYN3IwVTcwWlFZWE14bTFuUGV2VUdyNEQw?=
 =?utf-8?B?ZmFQWWZpdDNMZGU4dnM4L3NrTFN4UXB4cXExNy9QR2Z0N2VNM3ZPWFdRR1JB?=
 =?utf-8?B?VUNhVjl2SjlSWVZJRm4yOSs3akNzbmFlN2VNYTBhMFROeW1RK2J0ZE9hS3V5?=
 =?utf-8?B?VVlzR0MyMzNBU01mM3JPOENsU3NLQzllak5LK0x0SDQyV0g2eXdQMjBlK0sz?=
 =?utf-8?B?eGp0RTRYZ0JYZVVrMXczaXFBUGQ2a0U4Rkh6UkxsM1kyclN1SEpud0haNzFB?=
 =?utf-8?B?TVZpUGdiTzQxZDg0V2VqUU8venZtMmJMZkl2ZFZMYzU3MWNQSC9tNEJaYU5Y?=
 =?utf-8?B?QitNNmFLOHllS3lUNzhscitIdStReW1yd3RNaDAvTmFoa09XUzE4T1NibSs4?=
 =?utf-8?B?KzRVaEtkTFBadFZkRGhpTlF5YVQ0a3pCTnZPcWp4RGxFZWp5UEtIaTVYdG9t?=
 =?utf-8?B?TWRudlFZRjBIZnVwWEIyblRyeHBBMTlyZHIrcTd5SVJIMEh0OFVwUWdsYTZU?=
 =?utf-8?B?NU4raERsWmNmS29NVU5SaEd1cHQvNndVQ1BEZWNmZlQ4OVBpNlRwQWFLbkNM?=
 =?utf-8?Q?XKNYhesDTKEtU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEZINFpMWkFzRGpiaWsvaG1SYnBPczU5NElSRzhKSnJOT1hYeUdFeldEZHZX?=
 =?utf-8?B?MmxseFZoOTY5N0tGNnNsYnQzeWhwa01qMjZkS20zV2RDTmlUWWpzOXJWZVor?=
 =?utf-8?B?c0FEQWtaOWJ0T3VlN0hpeGhlV3plR0ZQRWplaEZnK1Q4a0gxQkJDSVA2SEdp?=
 =?utf-8?B?TGFtVTJGZzFaejNscVhpSHBiZmFSOXZGUit3MlM1RU5FWkd6dlV3NUlSNzBN?=
 =?utf-8?B?S01NS2grY2pUYTlScmpRNEJYR0Z5b0s4UVdTZkFGVjJqcVdKYko1SFZwU2hE?=
 =?utf-8?B?TkZNMFZ0YmJlUFpWQStTbzFIODZOU3NaZVFqTTYyZzRrLy9mbE1lalJ1SlNp?=
 =?utf-8?B?bW95U2VKRlkzTXR6T1B2aExheVFRVC9ETDZ2NkVTcWlIY1d0eU4wQnB0ZDEw?=
 =?utf-8?B?N1pxQ2RYZXBSSkRzdlpIYUpmNGFIbEg1QTA0VHVDbit2SDkvRUxpL2NrUXNG?=
 =?utf-8?B?TW1KSGF2K2JlUE5UVVNJcVV1TWtJODFiWWgyenpQeG5vVHBXSUFGdU9JZFM0?=
 =?utf-8?B?UlM1NXJYallWbmgvR3BheVd0NzFFSGRORFVibmpLTnlxMVFCZ213WVFJV2FG?=
 =?utf-8?B?VmxjTTJ0dUFxZHNLV2VXeU9TRUJLZFNBS1ZpQ2I0b0tmdUxmUmNhT1VjWU5C?=
 =?utf-8?B?aGlVb2RrWm83ZUlyM3UyUFpCUTJqUmsvZ1VIREo1RWFWUmRWQncrdGtiSlNu?=
 =?utf-8?B?RjFWZG1MS3NJU1NUMkRkT2RNL0tPdWZkdTFlVjdIRHhVbmJVbnliNFlQa3ZU?=
 =?utf-8?B?TmFJazhEOUZjeEN6TFBzbXpPbTBZKzlMbHEzaWVnck9OVjM5RVEzNmZuUEhS?=
 =?utf-8?B?cWtJdnJpdDIvdmsrT1pSbmdLdyszTzZGMm9jc1VFQkJIMlZmQzFlVUpBNk1B?=
 =?utf-8?B?emY5VDFjM3lzVEdUbzlBZTFEU1ZtdlBqUmZUOXlUQktFUGV2OGVmaDM3elA3?=
 =?utf-8?B?OXVGZVIwOS9wQklXYURXTHV0bDZVQUlWVTB6ZU8xTFBUTWw0bXpIUEZOMEZ5?=
 =?utf-8?B?Uy91YnVleW1KTXhMaW1vL1BOSzY5UnR4NENTblhHc2Jtd3oxckQweUpIUFJJ?=
 =?utf-8?B?OTFlQUY5VnVPbVQzY1picllDMDI1NGhmeEVYWTJRM3BvL2RsYVhMVFNEVit0?=
 =?utf-8?B?K3R3cnhZVTczSHVPMkJlK1QrcVJid2tvU3RtSE1tSngwemVKVWYyYlhMelV5?=
 =?utf-8?B?dnNRT0JZU09DSEVuWkpBb292UUd5UWdaOWdGTmR6RUxpUUFBMWJXU1VnQU5M?=
 =?utf-8?B?d2ZTVkxiU0Vka2xVWUIzSHZQcEphVmpTRld1Z3ZWY243WUY5SUNVVGpRU0VR?=
 =?utf-8?B?QXVqcnh3Zk9PNHI0Tm9vaDVNR2RwSU11SGFFbk1XUjRXUlJtUmh6dldxUFBq?=
 =?utf-8?B?VmU4SVYyQjYzR3RWeGJpVmJzaExZRmRyalJqRWFnbmdaVzVzREpIdzJ0Q2Vs?=
 =?utf-8?B?bEdabFNIL0x4VE1UZzNxa0wrTzMzM2MxbzZpMDBXRUR5MGFMV3N5UlNrU1hm?=
 =?utf-8?B?bFUydHVVSHVMeWhYTU5aYUFpT0V3REl6ekg0SXdmbndpWENQNU0ybVFjYmtr?=
 =?utf-8?B?Sk9reHZ3THYwc2dOa3pWczBTMTBtMHd2M1RWK3lDRFNaUVdqTHp6OUI0NFYy?=
 =?utf-8?B?Qm5kSzJEcmlsS0FSWGVvdkgyTjhNd0JuWUovY3h4L2lGZEE5TzcxQmROcVN4?=
 =?utf-8?B?WkY0cmphYXFMYThQc0F3SUZGaEVXSno2bTE1VHlxcVR2dkIvb2lUYkdYdmYv?=
 =?utf-8?B?a2I5UURQQkk3MlBDNHFUMmR0LzNNbENFV2I0MWxEWW9KQ0ptOVYrSm5LRldE?=
 =?utf-8?B?Vll2NmNVcFRTNWpjUzVvdGx3NVpjdmdSUXF2cGxlUEhGSVRZaVlYWW1rN2Jk?=
 =?utf-8?B?MFgvU1A1NEY5amFyZDh3U2lCZFQ0dnBhM21xN0JFTmdtQUlNNmRveE01TkZ3?=
 =?utf-8?B?SjROR1FZUkhIOVQrSnNmVkJ1ZHBGVE5TaTdHUjR6cVZrdU92N1M2a3IyT1Ez?=
 =?utf-8?B?dTJrTHFQZ0hZUTRURWtWMHZwb0ErZFJSdzFUQXd6eHk4dEptb3BRcTkraXdz?=
 =?utf-8?B?blp0RmZxKytaVjQzYW9TbXFFK2JuTG9QOHV0UC9PY3hydGJFZjJJTGRZRGRP?=
 =?utf-8?Q?U/FrCT8SQgQxAdz+fP8MwF4PZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c79f98-fe95-4ef9-15ee-08dd5d1ea3ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:20:33.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b56G48woIRTrBxwcf4mg9U0E3Wr0h/46vdppLJrrC/6ghupR1o3abygPAvwtP46dih0UMbnSyZUIUcUzifQBCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084


On 2/28/25 11:59, James Morse wrote:
> From: Dave Martin <Dave.Martin@arm.com>
>
> checkpatch.pl complains about some whitespace anomalies in the
> resctrl core code.
>
> This doesn't matter, but since this code is about to be factored
> out and made generic, this is a good opportunity to fix these
> issues and so reduce future checkpatch fuzz.
>
> Fix them.
>
> No functional change.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua


