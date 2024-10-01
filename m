Return-Path: <linux-kernel+bounces-346553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5B498C5D1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41CD61F23DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F2A1CCECD;
	Tue,  1 Oct 2024 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="noKAoaZl"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021074.outbound.protection.outlook.com [52.101.62.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66691CC171
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727809753; cv=fail; b=B8ZvpQN2OPFPN/z0ZbjLxjCGMn5EkrQKZ7VMZi8wPfklGEXkUAhMhuID0qN+DT06tbqiiliYY9VJKs3JytPrXbDDjvzkGup+zs+cd7VFpvqSV1C8FQaWBaFDe9J3VYhlidFJ6tle9+/rTpeIGRm5HNIAW4TVJ28LSKrUEIBi+0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727809753; c=relaxed/simple;
	bh=u3Amh9UjDQraslg5Ydyy1gryCGQmfJZiJWaDtJCTVBo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Soauhn6k053gVMEdJBJZ+rFVWUmJAVk117NdSMZwF8oG6KiXJfasYzgHtf1sx4jhkgYrOXUgpOkTsQ9+nlpWm+lw3TBBHVaANA1MJ2YoAxOUCF3EF9anDBjRzsyHj1/U0MFzeKHQ0+CxO+pCvTUGk4PKLhJ3uP+1ttIUMuoGsHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=noKAoaZl; arc=fail smtp.client-ip=52.101.62.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OazryjpGXReQqjBloKV5zJGB2/gH1fMp9dCBFkbEBIx1/PNPgohU6DlUCyziKUY9qIeoXo0GH26ydSVR4hZhcTcwWg6EFI8n4KF6Tm5xbIQ4MonVtLTe3RkpqwibCuo2f2xyF30zFUVFkmyQDOy5Pl6shTSgRL4639ri9Q9DUSouWeZJk2wPpvL3+y1l+rivSRfsw+NZoP47HV0IAz/PJiUCdZxqHhhK1lJK578YTOlV95a/mvg9oo8sVK/eZL/FCvNz+MdE2TNHeUCEDeF8dntasJInWKyN5S1xd5t/1oYdhg/0/aXlNYDFlxrt8FggOWAkB4jI7B0BC5Y/zItGCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruttxAPmFHwQBMP5oGSnn8sHoE+Hdsk/Ioz+xukebOg=;
 b=NTMLbWiqO/130Y3sbUVOF3EPlz6PGW024BPqTsyQSNtPnNTlNI6LwTFt1AJovEWLLHIITE/k0KfdKV8wuQy8gKv4Za4y76ul3SFDr8x7nsKJXUoSxpk0TdBFOmp0TXOlBhvomWR6xfRfzRqNqn6Ow0ul2+malnY6xRhVt+HG8qh00b8XNivIMznjWfW98j2b1QHEOp0ESodgMtjkR96zVsWW1mzpnnIkbKEiW2TbCl1zVs63KnsQ1Yj05pD67AhkdHGOsfzKxnhaxo3n3/WnacbUol/8SuPqoA0MSKZn304CbEad3QRQNwA+I+u7xXTGVtRWpewYENDLdl3XmDBwBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruttxAPmFHwQBMP5oGSnn8sHoE+Hdsk/Ioz+xukebOg=;
 b=noKAoaZlhgCnqlob/cIn+BSu8orlK5kqfgsNZ32i7a8mhR1DbQE0D2pnFobHBTv+NfUYCos5XcHJMW6HDU8fs7Bthp8UyLT6dk5hrGjIlQVURMwUvRFiEZjIpvhD4bqBjqTIE8Mk/DZUPvMIIBI1YZ96cGGSNR8T42EJDKmDkY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW4PR01MB6386.prod.exchangelabs.com (2603:10b6:303:76::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.31; Tue, 1 Oct 2024 19:09:07 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Tue, 1 Oct 2024
 19:09:07 +0000
Message-ID: <45b97496-29a2-4111-ba38-3c8bcf9f8b4d@os.amperecomputing.com>
Date: Tue, 1 Oct 2024 12:09:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation
 for AmpereOne
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@ziepe.ca, will@kernel.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
 <Zvw/Kghyt9zUkupn@Asurada-Nvidia>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Zvw/Kghyt9zUkupn@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:610:e5::17) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW4PR01MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 263b5287-fc8f-46a4-6474-08dce24c85a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1VUc2NESzBBVXVMREw2ZVhjTFRZZFZ5K0g4QzVyaFlqVG0weUVPMERFNncx?=
 =?utf-8?B?aTVlejN2RzhSQTVJcmtadmdZSjJFWXJUZjdGeEJGQ2FyMlkvamJ4aFVLaEhG?=
 =?utf-8?B?OW1oaFpDTkFtYnJQaVdSdHJOZWk0Ty9OYVlhR1dYSDNvNEFOMlY1UTN1V1Fz?=
 =?utf-8?B?WFBOQmRHdVFhcjZZNEJTNlZLL3p6TFN4dCtIaEZ0RCtiaW9YSDkwSzZESW9r?=
 =?utf-8?B?WUdLRFF6Z3BEUnFMNldaVUt3Vm5VRlJNU3RhcjNMbFFHTEVmRFJreUV2RlRy?=
 =?utf-8?B?Qi9yK091L0ZmWjVEbW1XWEVTQVVhN3ZSaW9yaDhHSEw4VzlFS01sZkY5b0VH?=
 =?utf-8?B?MGdiM1Nic2o1Z0t2RnNNN3hBaWg0elBKYjBrOVF0Rk9lc3crTTVZK0xvSzlv?=
 =?utf-8?B?QW5JdmI4amVIb0NSeEJjWlIwd0xlMjI5c29Ma3lkL2lzdHBmNHVlT2t0ZENz?=
 =?utf-8?B?VVNCQUw2cThZeE54cVVQYVl3MGpjbUlSRDI0cG01THBST1NLVmNTcThibUdQ?=
 =?utf-8?B?V2Jqem1pQ0VKUHZ4VmNKRFVhcnlObVo0eVN6ZVFkZjFQWjFjaE0yU0ZSa1V3?=
 =?utf-8?B?L1h3WTZFbGFva1MyaUNPT1U0cWFVbVVSZ1pYNHEwaHBNdW13YThYS0xqZmJW?=
 =?utf-8?B?QllmUE82WFVkRFpHRTl5NlNLM1oxTytYR0F5YjQ4Wi8wSHVsU0FKdnd4c2c5?=
 =?utf-8?B?ZlA1TFRoNFdBVklnVTNEVm9qMmlxU3VhM01FaUhGblliWm40VnRMS2lwNDVB?=
 =?utf-8?B?QjVKM0VKcXZtazBGa04vUVhuV1VBWGFmQllaeU8zZGM0VFRvaGVUc1BaZmdF?=
 =?utf-8?B?bENrbzZFSFZ4ZzNnOEZrdUJnN3JqTVFkcEJhSmlWY09iY2VIM2FnNXBzVmVM?=
 =?utf-8?B?QSt5UmJlUCt0TlVRSTRDby82WUdSMGduc2J4b3hhK2ZNVFRPcTRZR01UR1VU?=
 =?utf-8?B?cnNOaUxWY0l1M3A3cGVCLy9pU28wVlJVQ3Y2cTFrbkE1VHIzTmM1ZTJPUW5j?=
 =?utf-8?B?ZjdUUjl4YmtoTjJ0LzYvV2RydzByZ2JGejF0OWpDM1k2czZwK2pIdjRJNkFo?=
 =?utf-8?B?THBucndvbEVIcnI1VkRLNW5KQ0psbVRITHB6RFBocVJ6bHNDYXc0eWhXZmdB?=
 =?utf-8?B?NXQrMjFRdFpmdUVNYkxuK04zNnBKUEVKeWUydDgzOC9heE1VMW93V1R3a1ZN?=
 =?utf-8?B?WVFsWStYdjFUK0VDb0dLYmY2a21BRzNKSUtoa3VLdGVOc2lVS0pWVmh0dWxE?=
 =?utf-8?B?czZTcEp1bUF0ZVpycDd0UGN4cGRFekxHYytSRXprZ3lMQnNya3N1TmFRUTBx?=
 =?utf-8?B?L2p6d2NPQUJZS2NIY1NZSGJCVFRWRVFzS3pDMXh5RGNwQzdxdGVuK3V4a0N5?=
 =?utf-8?B?d0JxN2dXOFFFUzZmZGdFdUUxSk5aakdlaUtPeFNGVDZrUXpCQm9jN2J3bkpL?=
 =?utf-8?B?R3hCNUxZWDQ3RExaQVk2WHZqWUF4NGpUM1hKMWdyUWVjMGlQMnhFb1REeUdL?=
 =?utf-8?B?VzdDbTBZYzZYc05JcmhlZVB4d1J0T0YwNnVFbGwwNU9nTGRDOGg4ejQxdS9i?=
 =?utf-8?B?Rk44N0daSDNNRjFqdm04b2g4VWtUNVpmdm9IWkVSMVRGWjVHZHpHdDduYjJ0?=
 =?utf-8?B?b1VDMXAzYm9vdkNNYUNOc2V2UzAxUHNzdWxvSHBQUWlsS05kbVk2ckRvMnpz?=
 =?utf-8?B?elc4QW5MeS91dmZOZUxQYWF6QXcvZkVsYUJyOVF5NHRYU1hHb2FrTHJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck0zNk1yYWZZOGZFNkV5enVUV29xN3N2Q3c1aUFMZHhsdDhrUHR3Vm1KaFFn?=
 =?utf-8?B?NlJtY0d2aHR0YXRWSTZ5QnNhWlhjTHFhYXZJNzlBbGYrZ3VPd3BQekhPdnB3?=
 =?utf-8?B?MmhodjNDVnQzVWZhYytKRWJyUmdIZUt3cGdySGMyS0J0MU8xRVRKcno2bHRQ?=
 =?utf-8?B?VENXell6cUdxOGw4YUJteU5wMmtYL2lFeVhQeXVUNXRxR3lpWERUOFl6ZUp3?=
 =?utf-8?B?bUovcjVCZzVDdSt6UE0xY01BMjJ0Z01aM1l4WElrYkRPVVlhZUwvQU1DTFBh?=
 =?utf-8?B?WjIyKzh1YVJCdjdJTFFrQUpLSngwLzA4RXExMlQrengrNHZMWVlibnlobzBJ?=
 =?utf-8?B?RnlDRXQ1bGN4aVQ1Vkxnc1NVdnN6ZmtIMStYTzU1SGZzNWJYeFIxVnBnQm9N?=
 =?utf-8?B?SUFnei9pREt5bGx0RGE1ZGdNN2Y3TDNHbTg1QnNFVzVHbGUrMkIzRS9lTGlP?=
 =?utf-8?B?VStHWGdJaW5uTkV4WXdOUVozMnZFVGdXTEJzdHloY3BNVHZpR1hNN0VPMlFn?=
 =?utf-8?B?VUNyWkI1eVdLdkdGZENMSndjZjRKTVN3OGVkbTVteWl2RTYvVjZMWngvQUI2?=
 =?utf-8?B?S3dLZGpINVFNbDNSbHhuM3pCaEtjMTZ1bjJybGVsNm1FUW13cDAybGRhY1ZD?=
 =?utf-8?B?Rm5TbjgzT2F6OXhEcVVDWnZwUU5EaUJXLzVjdXVpdHZDd29TdFdPOGw4b2hM?=
 =?utf-8?B?em10OFordFY2NC9YdEtia2tKOFRmQUw0cjA0SXVrQkwybXNtZFl6eGxLOFU2?=
 =?utf-8?B?bkZHVkNOY2ZSTWhKZ3ViWVBLbGdFUHNwWkwrVUVoQWVTZnVqN28rY0ExdFd0?=
 =?utf-8?B?MWxrZmVPSDgyQisvOUd5RGdDK0VDRmpwZnVnNG93ZVFreDZQNlhJcVdZcVlW?=
 =?utf-8?B?a0JiVjczelZEYStnNlZhWUJLK2pDQ1JHWG9uYXl5SlkzTUlWN0ZvSE9tWm5B?=
 =?utf-8?B?QUVnQmhZeG0wUGUrMWhBL1RMVE1sUG00UUM3UnhIeEYrYWNoNUlkTW10Mkwr?=
 =?utf-8?B?ekFUeDAyM2RzQ2JzVGpDWVhxTmF3T1BJZ0xjTjlNVDd5UTBCVUVXVnFyUE1k?=
 =?utf-8?B?WGo5TXkxM2lLSU0venNLWm5oSld5NlBtT1FUTUNOQ0t0WS9WZC9scTVjSUJz?=
 =?utf-8?B?ZE9kSGEwTW51K3hhY3d2M2ZJclBEV0VLandEMWl1d1hsWFFLcmJaWk54bFdE?=
 =?utf-8?B?ak40Y3VZeURnaGM1M0Q2aG1PejlFOWwrTFRTS0ZLSGI2bGN1M0JUcHhwWUdJ?=
 =?utf-8?B?K2pyalNOaXREZ0oyQWxUMVMzOTFxWGx0TzlFelg3U0RVOVBXRXdzbEFqNllj?=
 =?utf-8?B?SWdWQ0NObm1USnlXOUhZOUVXeGhjSHZVQWhxKzl2aGJnd210NnlkbHZkQmZ5?=
 =?utf-8?B?MWN4RmsyeUwwL05MeHp0Uis5bVdaeSt3MnlEQXZwREF0Tkh4YlJZT3JuTytr?=
 =?utf-8?B?NWVpeGF3RVQvaUhFSDBLZWVGMlBBMzVsRko4ZHZySEdqWHYzQzVXMi9BVHZW?=
 =?utf-8?B?YXJaUFhGMVZiM1pxRmlBbUtwYUo0ZUJiSjV1M1JXd1dDUytRdWduMlJLZ2ZY?=
 =?utf-8?B?YXg4Ymp2WVJTMS9HeVNjdHloVm12cWQrZ25vU1Rpc201aXo3d1BmSWM0bHda?=
 =?utf-8?B?ZUorNGJyeFlpUmJRdUxlR2NzSjRuazR5QWJJOUlSR2dXK1F5cTFWZ0oxSWFy?=
 =?utf-8?B?VkJKaEhYb1kwbEhZcFkwa3dMR0x2dHpwOTZMZzd3Q2NTc1FFTzVndzBFS0Fi?=
 =?utf-8?B?NVdNQnk1dEEvZ1lCQWdNVmlvMDJrb1dvcWxNK2thWHNoSzlYQWxUYk50OUdV?=
 =?utf-8?B?RXBsSFNjNERqVDVEQUkvK0JTVGFFUFg1c1ZuSnlocmRKMmozZ1pSLzRtZG9F?=
 =?utf-8?B?R0RvUkxYVHJ4MTJ3TXpucU5MRHQ5amRYODJ5bGp0SEV6d0FlcnJuZXZZekNU?=
 =?utf-8?B?eHVTUVBlRzFlMTlTSUxLVWpGczRhZUJid01aaXhrRjUrZHVhL0E5OUVITDRp?=
 =?utf-8?B?a3BacTJjeVJ4Z3ZiNTBYSWtiUHdRSnpMam5zc2FOYW54dkNnQm84VEFyWnFS?=
 =?utf-8?B?S1FOVnlBS2ZLQjhRZzZwQk1nSnFyQm1NWmM4VUJoQkxvL0ZyUFFQbElVR3Bv?=
 =?utf-8?B?cXluMG1KWkVWQldvM1pyMnRzVWRla25aeTV2ME1DTW5jTTRxM3MreGp3RXlo?=
 =?utf-8?Q?X0jLTv0PwfTIzmhaGkiUyEQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263b5287-fc8f-46a4-6474-08dce24c85a2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 19:09:06.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzqTSI4juVSvjzfTYWBwtrVgqx4yOonG52V33+7fQc8tIUdrDVIOBQCHGy5Ri9er40C4i+UQAcFmqdIXzmr4EWw113Wa43P37OXgmdxoIc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6386



On 10/1/24 11:27 AM, Nicolin Chen wrote:
> On Tue, Oct 01, 2024 at 11:03:46AM -0700, Yang Shi wrote:
>> Using 64 bit immediate when doing shift can solve the problem.  The
>> disssembly after the fix looks like:
> [...]
>
>>          unsigned int last_sid_idx =
>> -               arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
>> +               arm_smmu_strtab_l1_idx((1UL << smmu->sid_bits) - 1);
> Could a 32-bit build be a corner case where UL is no longer a
> "64 bit" stated in the commit message?

It shouldn't. Because smmu v3 depends on ARM64.

config ARM_SMMU_V3
         tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
         depends on ARM64

>
> Also, there are other places doing "1 << smmu->sid_bits", e.g.
> arm_smmu_init_strtab_linear().

The disassembly shows it uses "sbfiz   x21, x20, 6, 32" instead of lsl. 
1UL should be used if we want to take extra caution and don't prefer 
rely on compiler.

>
> Then, can ssid_bits/s1cdmax be a concern similarly?

IIUC, ssid_bits is determined by IDR1_SSIDSIZE. It is GENMASK(10, 6). So 
it shouldn't be 32. IDR1_SIDSIZE is GENMASK(5, 0).

>
> Thanks
> Nicolin


