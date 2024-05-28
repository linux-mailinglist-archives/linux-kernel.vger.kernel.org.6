Return-Path: <linux-kernel+bounces-193081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE368D269A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4411F28E12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F24517A930;
	Tue, 28 May 2024 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nWvlWUB8"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3171017921D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929837; cv=fail; b=iIFboDE17mEEWpC+GZYQZoOoSeePm0lk7a9o1TdEvsxELqyDDMZ+sn9ffDPMffT6iqHcBQzChYDAGo0TWMcmJOnKdfjTqFXBo+DSecTI9QnOokl5rjZbP9RbYraDHWzdVsKtdiq99RXcdv4AlNNVPOdgArPMm6Z70xgLTLZt0Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929837; c=relaxed/simple;
	bh=8YG3YVhx6Nk5hJOR8GIWsTid6ZBrmW9GUcrOxumkV8g=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=gPJ2hm0bPcemvyWeRsWAXu/ypa23G1RVss/Uyd56cIFdfMkrd82WEQ4QU4KeeT4CaN0RKrj74uKuK6RUXqnYuo4eoxSa3RZrRw/Tubyt5dVS/+K1gMBx3pCdhKdTjyqbMjxmVhgtprXADy0RDNu9KMlO2kB+WazlcBvemAU1lq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nWvlWUB8; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNh+mC0at1LcIAGDWJtviCRZQzDiJp/pTg0ssX34XIoJCD0jyLpvRtu3JDb1VvRiQDOfSkn+5BI/NCr0vxrlNvhaY7ZUi/nx6MoD9Ll5/Q6EGKQh7rzqfCEQ4OFDKbLNh07cwoXsUm5OVjMbaeTArLU645W4Xccgn+wBgJoFGY99jucz5s2n9zS4R4WyWAicBn43Zu3+auberxu1Qbg960Roqyb9im0/sbfve91Ye9C5NPYTMcKYTHe6kBkqeqhDS22E14LjgVt7kqzF8BR5bY8Ess+Uzn5Qx4HpSY6tK24fkL/hCukYXQICmSjRVhR9U5kdcCosCligHUOD9SlQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiYKByk6VE8Tkr30TiNVpM2GIy8o5j+eOTSOymy04TA=;
 b=g0YvkCMZaHzusOz0TqV3h8qwQSpy66TAdf2+34ye/cPsFX32itd13Ik3OhS8ii/0QWHahyPwJyGAPEupkrGQl5drlau1vrX7qjF6UghKNimo4P5i7FCI15HWw57u6xluo4mRZOuGCjzyAz/KyVIOeobZcC7tVyYo9vQT7fTiLtIFcZiVyx+befbBSS75Oy2WscbKjoOt7n8Z+pzKz18kV5bqg4obI5SqSrZjtfkjaL4LRFfbmSJnqq3qqY/Hot40O/8RrHkkw24SoU4TP3Dn9YIv9O2LJAfFK7093rbCm5dGiBK6wv2GzmMSd2kQ3n6Explvj+BZ9vzuF3kzT2sgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiYKByk6VE8Tkr30TiNVpM2GIy8o5j+eOTSOymy04TA=;
 b=nWvlWUB86XvETXXFNzj1mOqPFzuaP8LdopM7bP60ppWONx3+i0EZF+pzdK/EaqFtEIVYG+KGrq0og3V2rSrWL8ZotY3fQtbG/JFNWW9TaEuo1Gw/mQ5KexiB6fGHcjjrqz4juE0c3g0jdgordWAIjX4lQPVh7vsexN4IF9dPeZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SA0PR12MB7477.namprd12.prod.outlook.com (2603:10b6:806:24b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.31; Tue, 28 May
 2024 20:57:12 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 20:57:12 +0000
Message-ID: <ab9e93f0-132e-b7cc-48e0-f83463003e21@amd.com>
Date: Tue, 28 May 2024 15:57:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <0b460ba621d39fda47694332f09301b440619efc.1713974291.git.thomas.lendacky@amd.com>
 <20240527131022.GAZlSGPm_s0FAu_BRB@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 08/15] x86/sev: Provide SVSM discovery support
In-Reply-To: <20240527131022.GAZlSGPm_s0FAu_BRB@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0110.namprd05.prod.outlook.com
 (2603:10b6:803:42::27) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SA0PR12MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: fa842791-8643-4935-2330-08dc7f58bf86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Kzl4aEwwMkJiSzN1YjdIbzhzekFjNmRGRzhPWUU5dTA2YmtvRmpYaGFhZ2NW?=
 =?utf-8?B?NlFWSzQya0RZVlpuWGxyb2EwbzhhbGVnTTNGOWVNdEdIK0V5YzNWYUZNaWVL?=
 =?utf-8?B?QWV6cXdxNTZ2SExxNmptVU1pejFOUlFlTHhsTnFVK0tYSysySzVzd3ZNbnhi?=
 =?utf-8?B?QVBLbXVycENldDFvdXJxUlRMa3c4TjV1SWxma0VsWkQxaGF6SG1zNm5ERHlC?=
 =?utf-8?B?bDFMS1c1NmlGNW1tN3QxZVZwakVsbnNBZGx2REttQ3hDMUd2ejIveEJPNWdJ?=
 =?utf-8?B?eHRiRnZSRFBFUHBRdUtVTkdXemF4cnJwZm13ZnJnNFJ4Vkg1L25SeWlnUFE5?=
 =?utf-8?B?VWlGZisvME1YYWFnRm13SGtoMWZMVVZkbTFNTUNLUmd4dFcxSDlJaVVKbnoy?=
 =?utf-8?B?Z0p6NVNDUHdybmJUYTVpd0M5Zktsa3BQa2oyc0JnM1A4MitJdDNxSGpldGFz?=
 =?utf-8?B?REU4WVZOSkIxa1BtWDVGcmVNV2V2SjQ1MTFCOHFJYmF3ZStSdW5JY1drSkZE?=
 =?utf-8?B?cUJ0MWl0U1NwOURjblV6ZXhMc0JVV3ZVQTE1anBTK0plVWlobzdmRU5Kd3J4?=
 =?utf-8?B?WWVZaGNXMGV0aVVrQ2VSTzBKbkp3T0FidDN0akp2MVhhTGxxSFJ5RmEwNmhG?=
 =?utf-8?B?Wm0wMWlIN3U2OW5BUElMT0ZkZlhOTllEOS9MdXpSeStYeDFRaDcwYU5wQnNN?=
 =?utf-8?B?T0VSS0VQYzZUZGN2VHRGN1lnNlRNN1paRzhqMkhwNHFPSEtmZEcxemFvY2d1?=
 =?utf-8?B?RWN2RTd3dGEvYjZaUW9JeGFiejJSdDJXWmlQZXVzdm0zV1ozVUI1Z2ticm1s?=
 =?utf-8?B?dktPSDBjRzNzMUpOdXEwajFmTld2eElaMUdmU2dncDhnV1o5T1llY0hYYUhj?=
 =?utf-8?B?VlNHMURoMldaM2l2V1ZGVnF4Nko5djlqZWlCYnpSN3MzRTE2ZDlESC9Mc2c0?=
 =?utf-8?B?MCtFSVVTaUVtZFR2aDZiWnpmQVV0WnNxUzZmZDNtN2gxVHZoa3RNaHJrbWhr?=
 =?utf-8?B?dFIyZUp1dzdEVzJ5bW1veDgxdnJYaE1wYmVVdmJnbWt0dGdlSzRvQ1NUTVQ0?=
 =?utf-8?B?UHNRd2JsWVNDSmI4cXV6dXhQQ3pCaHNNTFRaMERXYmFKQk9QanZva0tzWkpJ?=
 =?utf-8?B?Q3pKTThHaERVbStHNVgwMkZhTmJkcVR4UFViUTBZS1hBWTlPK2F5b3lZeHNF?=
 =?utf-8?B?c2dxMERMWUdyNE52MkQ3blc1UVdrOVlTeU1ubHI4cDlacXlEM1czWjBlSEJU?=
 =?utf-8?B?QnZKRU05OXpwWlU5MmZsYlMxK210QU1leUJvbnJuckNkOW1VUUo4K3JRM2hL?=
 =?utf-8?B?ZEFiaktYeUpWOVVoU0libUp4MEU0ZWg2TVAzY2w1N3hmSFJEVUViL2Z0b3dL?=
 =?utf-8?B?SkNadGtRZXpVRTBBNmdMNWFmV1J4eEM2ME54RXdNNE9OS1p3YmhBVmlSTDEz?=
 =?utf-8?B?WkdLblpEMmNJcTJjRGlHVk9MUEliWXV1MUlwSGVPb2doejFmMFdBdENJL29z?=
 =?utf-8?B?dzZpdmhiNzdhYjVydnJuTDZXMkpqazNWMEZoK1h3WTFvS3BxSmJBbW93dTV3?=
 =?utf-8?B?NFg1eWFqang4YW16RnphNGV6MzRiOW1ZdkkwQUxaOFZMUHNpRkE4SGxLWUhk?=
 =?utf-8?B?ODg0Z3pRM2ZBa1dyVGJ2N3JpVjVydEt3ZzRtYWczTDJJUG4vbHJvd2RoT3l6?=
 =?utf-8?B?TmVadWxIdEUvZStWdkdKRzhwQ0k0SEV1UGYybTV5NFRZWnBLQ0x0RzV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHY0Wit2RVBnYkJscitqTEgrZXlIOGRUM3hHREprTHQrVHFpMUFJenpiV2JL?=
 =?utf-8?B?cmdKUm9ZcElIalVwYkFSOElCRUJxbFNCSUg3MExwVUMwVTFTWGxRcXRLczlM?=
 =?utf-8?B?R3FJYjdoVXZ3NjRDTnBPQjV0V0IzdWt1SGZaYjJLL0dTeDIvOEVNd2k1TWNO?=
 =?utf-8?B?eFJiMFk4L0F4S0VKclpCV3IwY2ZEUkZuTlJtTzM5RVl5Qlg0ekJrZlNUa1R4?=
 =?utf-8?B?WDJKcjQwVXFqVFFvSVpXMjRVcXF3ZTBGZEtSLzZodXlTYnYydFIwS1VoNGpx?=
 =?utf-8?B?TmlLeERpc005R0luTmRYdGU2RXd5bE41WmNDNm45blVld2tGNzd6N21FWHlh?=
 =?utf-8?B?TnNydTRENTMrbFplcDZJMkZHUGFiV055MXh3R21NWkNyUXBOelF3WUNUNVFr?=
 =?utf-8?B?dnV6ZWw2OTJEd0hta3QveFB2U0tPcmpQbkhVMVZESzhVQWMrUGlqSGRmbXRx?=
 =?utf-8?B?VlpHZS9jbHh4QUcrdHE2SWpjckI0dmhVVW1VOFNXdlVvUitGYWwweU9Fck91?=
 =?utf-8?B?OWdnREJPYkhoaXVVZVpOMHVBRGx6MUd3WTJRNkt6WGQ0L0FmNU16NDZ6bUtn?=
 =?utf-8?B?eCtFaW9rVENHeGxTVWY0bGYrR2J3NFJSWi9hbTdnd1V1cTJ0cGJDSlVocU13?=
 =?utf-8?B?NE1yNzZlbys4YXROOG4zMjBaOUF1S0RwanVoRFZuRVN3WUwvWm8vLy82VFNp?=
 =?utf-8?B?V0xEN3FtWER5ZkcwMzNHZUhWK0lSZmtwd3hzTkptZHlab2hxU3I3N3JqVnpD?=
 =?utf-8?B?a09EOXRhVGczTDZFc25ZNTFzWFZWQU1PckUzcXVzbFNvQjRIaGFkaHRXNXp2?=
 =?utf-8?B?cUxKRk9RUFREdkVsdG9aaGphVUUrZFZEMW0wUXBFUk9UeUpMYkd0QTF6ckYv?=
 =?utf-8?B?QmFiZndQZnRFamtVT1R0YkRUci9NU1ZtUWJwMk5XMlZEeU5YQXFHT3dhUkM5?=
 =?utf-8?B?V3lHbTNrOEZsREZqK3ZBUm9VanBhYWxzalVzWmpLeFR3NFlVUHBKQU4rRlZY?=
 =?utf-8?B?Y20zZXhwL2VVL3JuQjAzM2RzU3k2Zm5SQ2pzSDM4cTN2d21oMWZGaU5CZHdW?=
 =?utf-8?B?S1c4ZVZDanpjK2taZEF0RzZ1dlM3aUVQNFZKQnRWeDA1bXZKanlZM0gwVDc2?=
 =?utf-8?B?MDdvbDNzblh2bjJFWFoxREl6UU1DYzZudG53eE9hbzhmczhlZ1RXVkVDeVht?=
 =?utf-8?B?bUJaSitzTGlsNGo1ZVFhYm44Y3VEekNDL3BibVF2aUp0SFEwWk5WVTB0Z2lY?=
 =?utf-8?B?WmJzYmh5U2l0UnJYeEtzMW9CT2ZoSDdNRXBGZ3BuYXBVenZlNVhJSXdlQ09p?=
 =?utf-8?B?SjJMZzBFd0syV01mZUhCOEdvcnE5MmtncjdUUWFIMlVseGY2VjFteWhnbHcx?=
 =?utf-8?B?eHRkeDdscGJYZTlzbEc2aGpNcTZXWnVORzg4ZWZHSnFRUldqcjNxcmRDUTY4?=
 =?utf-8?B?dnBPbS9VdzJRVk15U3R1RnFjbjVMd2hyN1NMRWFkV3hjS3A2bEFtNTBHemYv?=
 =?utf-8?B?bzg4V2JiM0ZJS05yMmNRaWRaOHN5eG14bTVRdFh1bHZ3ZDZCbjhSQ2hFdEJW?=
 =?utf-8?B?RUJaMWp2NlFheUxaUGlEU1o5dmJFY29UbTJjQ3JtMUQ4Um1FZkxyV3cyU0FB?=
 =?utf-8?B?WFIzaDI0Yi9XM0h1N0xkVEgyNzJxWUIwOWt2dVBVcDFQR3R2YkZpMDg3L2Zk?=
 =?utf-8?B?YjNNclcyVXdLZm51VWxITVJtRFpkQmVDS3VFalVKK2ZFbGYrUTRZL3oyUUxp?=
 =?utf-8?B?L3VYSjNCVnFsWmxINGxRMnRpaDNYOUZlTk56NDdUOUJkK3NpMmFMQjh5VFJ0?=
 =?utf-8?B?cms5RGdCS3k4aU5wV3Uvb3JtdHJaZVliUmRaNDNoVlJreU1SUk9JZTRuZXRK?=
 =?utf-8?B?UkQ5UnoxZXZURGo0dkVEYzVNWFo5NjFBRHJHUFIzSThIVHZUdlFmbDNJbVRU?=
 =?utf-8?B?TDVoWGhkSmxBSDZ6bGFwY01qVXROcGFqZFdlL3gvcVk1U2dPQ1R5K0tRcWlL?=
 =?utf-8?B?VERpcTBKQVEzOUxlY2FNL1JxZmhXVGV0U01Wb1BFR1MwbmFVdnpsQ1ZVMkxC?=
 =?utf-8?B?Wi9wVVZqYnlobTkrUElwWDlFVUh6WmNlME05NE1Dclh3aWtGSWV3WndwZnpG?=
 =?utf-8?Q?DydspHQ1LG8YEQsQzhzPl4dMg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa842791-8643-4935-2330-08dc7f58bf86
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 20:57:12.8038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iie4ZZJrS2hvfjE3IuosmJwmYtKZe3MRzRP/Uf2gfYH756qKhv6595DaQDJOiEyd6gNUSMrVLtcmBiULzaPhrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7477

On 5/27/24 08:10, Borislav Petkov wrote:
> On Wed, Apr 24, 2024 at 10:58:04AM -0500, Tom Lendacky wrote:
>> The SVSM specification documents an alternative method of discovery for
>> the SVSM using a reserved CPUID bit and a reserved MSR.
> 
> Yes, and all your code places where you do
> 
> 	if (vmpl)
> 
> to check whether the guest is running over a SVSM should do the CPUID
> check. We should not be hardcoding the VMPL level to mean a SVSM is
> present.

The alternative method is really meant for things like UEFI runtime 
services (which uses the kernels #VC handler), not the kernel directly.

Some of those checks have to be made very early, I'll see if it is 
feasible to rely on the CPUID check / cpu_feature_enabled() support.

We can separate out SVSM vs VMPL, but if the kernel isn't running at 
VMPL0 then it requires that an SVSM be present.

> 
>>
>> For the CPUID support, the SNP CPUID table is updated to set bit 28 of
> 
> s/is updated/update the.../

Ok.

> 
>> the EAX register of the 0x8000001f leaf when an SVSM is present. This bit
>> has been reserved for use in this capacity.
>>
>> For the MSR support, a new reserved MSR 0xc001f000 has been defined. A #VC
>> should be generated when accessing this MSR. The #VC handler is expected
>> to ignore writes to this MSR and return the physical calling area address
>> (CAA) on reads of this MSR.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/include/asm/cpufeatures.h |  1 +
>>   arch/x86/include/asm/msr-index.h   |  2 ++
>>   arch/x86/kernel/sev-shared.c       | 11 +++++++++++
>>   arch/x86/kernel/sev.c              | 17 +++++++++++++++++
>>   4 files changed, 31 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index 3c7434329661..a17a81b3189b 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -446,6 +446,7 @@
>>   #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
>>   #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
>>   #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* AMD SEV-ES full debug state swap support */
>> +#define X86_FEATURE_SVSM_PRESENT	(19*32+28) /* "" SNP SVSM is present */
> 
> X86_FEATURE_SVSM is better right?
> 
> And then we might even want to show it in /proc/cpuinfo here to really
> say that we're running over a SVSM as that might be useful info. Think
> alternate injection support for one.

Yep, will do.

> 
>>   /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
>>   #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" No Nested Data Breakpoints */
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index e022e6eb766c..45ffa27569f4 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -660,6 +660,8 @@
>>   #define MSR_AMD64_RMP_BASE		0xc0010132
>>   #define MSR_AMD64_RMP_END		0xc0010133
>>   
>> +#define MSR_SVSM_CAA			0xc001f000
>> +
>>   /* AMD Collaborative Processor Performance Control MSRs */
>>   #define MSR_AMD_CPPC_CAP1		0xc00102b0
>>   #define MSR_AMD_CPPC_ENABLE		0xc00102b1
>> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
>> index b415b10a0823..50db783f151e 100644
>> --- a/arch/x86/kernel/sev-shared.c
>> +++ b/arch/x86/kernel/sev-shared.c
>> @@ -1561,6 +1561,8 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
>>   static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
>>   {
>>   	struct snp_secrets_page *secrets_page;
>> +	struct snp_cpuid_table *cpuid_table;
>> +	unsigned int i;
>>   	u64 caa;
>>   
>>   	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
>> @@ -1607,4 +1609,13 @@ static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
>>   	 */
>>   	boot_svsm_caa = (struct svsm_ca *)caa;
>>   	boot_svsm_caa_pa = caa;
>> +
>> +	/* Advertise the SVSM presence via CPUID. */
>> +	cpuid_table = (struct snp_cpuid_table *)snp_cpuid_get_table();
>> +	for (i = 0; i < cpuid_table->count; i++) {
>> +		struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
>> +
>> +		if (fn->eax_in == 0x8000001f)
>> +			fn->eax |= BIT(28);
>> +	}
>>   }
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index 3f4342b31736..69a756781d90 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -1326,12 +1326,29 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
>>   	return 0;
>>   }
>>   
>> +static enum es_result vc_handle_svsm_caa_msr(struct es_em_ctxt *ctxt)
> 
> No need for that helper. And you can reuse the exit_info_1 assignment.
> Diff ontop:

I'll incorporate this, but probably won't change the way exit_info_1 is 
assigned.

Thanks,
Tom

> 
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 40eb547d0d6c..7a248d66227e 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -1326,31 +1326,25 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
>   	return 0;
>   }
>   
> -static enum es_result vc_handle_svsm_caa_msr(struct es_em_ctxt *ctxt)
> -{
> -	struct pt_regs *regs = ctxt->regs;
> -
> -	/* Writes to the SVSM CAA msr are ignored */
> -	if (ctxt->insn.opcode.bytes[1] == 0x30)
> -		return ES_OK;
> -
> -	regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
> -	regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
> -
> -	return ES_OK;
> -}
> -
>   static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>   {
>   	struct pt_regs *regs = ctxt->regs;
>   	enum es_result ret;
>   	u64 exit_info_1;
>   
> -	if (regs->cx == MSR_SVSM_CAA)
> -		return vc_handle_svsm_caa_msr(ctxt);
> -
>   	/* Is it a WRMSR? */
> -	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
> +	exit_info_1 = !!(ctxt->insn.opcode.bytes[1] == 0x30);
> +
> +	if (regs->cx == MSR_SVSM_CAA) {
> +		/* Writes to the SVSM CAA msr are ignored */
> +		if (exit_info_1)
> +			return ES_OK;
> +
> +		regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
> +		regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
> +
> +		return ES_OK;
> +	}
>   
>   	ghcb_set_rcx(ghcb, regs->cx);
>   	if (exit_info_1) {
> 

