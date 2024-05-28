Return-Path: <linux-kernel+bounces-193035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA938D25D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB461F24726
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDE817966F;
	Tue, 28 May 2024 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UvOU6M0n"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142417964F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928119; cv=fail; b=Z/mciQ9eKvVBiBmVg57AReMbatGBMopvd9JysZU90k3ytinlozHFuXQOG2wl/DIDqnd6Xnu65xAzqBTHlaG/VuoGTUG0IaLPjQxFxEoH3iQ639VK3cPXvMPMtu781tjEWfkrCrNYKc+GrD5QFM7wTW4DnHAB2SV10Nsyx7qCtUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928119; c=relaxed/simple;
	bh=GpwHXObud+V/8Ka4ylfrykm0Rk9YI0pH9S1uH+z1OpE=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=CgIYirBGxF03Tx1RZgUKJXDuTamdsTZdLu3pbr/mdIg5bqGkXDlyjWinxVq6vLvhqeaSAQMU6d+qsMxCgCDjKIpadF0uR6/DviRfv7gLw/kQSGBNw3dWuT5HcxVzJhLvEFaqyhMtzTNrqb6tOwCdIoyGrgrYfd+xlDO1DwtT7zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UvOU6M0n; arc=fail smtp.client-ip=40.107.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKqxvUaVO8XLgL6Wn1r0HHnY9fVseS6Fr9U5nzDyf656T1YbDsEhpeKXshmpS7fF28BK+c13HRs/FGrJRzaLmOr/hAiqtxTNpezrxUwxQYHnUGOAQtASp79aQxZsQhgfEFYsA6DbEZwb6R7p+SD+uh+mKTs3Oz2x3VJta+U+QBL+iA5ENLC7xTLAYJZGl3R8+pSf8JBRTvnw9VHsqAKNbopqQUi27/5UXG05fWFSlgoTMo1aA1r45wb26whWhxBEeSScS1xAr0M49pLiRvB5o+IPHjOZxuSN8dW5W99JXEkqiGc01mPWa5suyxBeohkZN8onaIx47E5UnYLuxEgbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvssJWYkgWMSEBgNBbAXLccgKpcaBAe8L+cU1d8MHkk=;
 b=ahGk2K7U3ciZ/SUuw1qua063BLKa0KBLYJXE+UCC8FC0pNhTWMEOTkiy6KrJ9NaOASpL2W6IIalOONCaP/0eX99hvSk27Y0WnE4eJEFzybNMz1sb1LLieouQQGwiSDDA5decLE4/wiibu0yJs97LRBCH7TfUhJ5QCkmx/d4QH3lMO7rtC5p3YFIX/nBTrEk4JYhEhwvyRerjqLoQ75LyuRguoIKJ6npmMryhF+taXCdvxTu2EWBHIGFRMMs36A/FpTp5QPV64zEVWBo12atoXHrYfdSnrUwjYwOYp6DUI3QLo1QaG+jhnjHulN/bYsOpts7gKkH3PmmNH+WCjlpbjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvssJWYkgWMSEBgNBbAXLccgKpcaBAe8L+cU1d8MHkk=;
 b=UvOU6M0ni0DsUo4Itcn22zUbqE/wtPxkzrE85qq3mp96xAMl5CcX9IvQXr8cwdHjoMgQdBUWiyTWSKJYNZ9PmNMzK0X2UfeiA1BA3g68yWrbfAi5tPkuD41HY6a9eNqdWCU9uhwunseM7jtCStgXJblOMLNSEuzcMlOsvyTq8Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 28 May
 2024 20:28:30 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 20:28:30 +0000
Message-ID: <4f704d19-088a-89d7-0515-144db61b93a5@amd.com>
Date: Tue, 28 May 2024 15:28:28 -0500
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
 <aa7f311d90efb49dfa6f4589854ee43c049b7b88.1713974291.git.thomas.lendacky@amd.com>
 <20240527123304.GBZlR9gBzBIjqEKKo6@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 07/15] x86/sev: Use the SVSM to create a vCPU when not
 in VMPL0
In-Reply-To: <20240527123304.GBZlR9gBzBIjqEKKo6@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:806:130::16) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbd0f7c-534c-4a6c-3d1f-08dc7f54bd07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEU5RitVR3dtUi9KZW1QVXY5WHM3NnR4cDkzK2FZaWVZMmlnUUpoWkVoV052?=
 =?utf-8?B?ejZlbitjczlEL2NKdG1HMk96K3FFZFZJTUZuOXpISjVHRjBVelZoU09FK1Jt?=
 =?utf-8?B?NjR6MURPUTVod2pleFFid0dEbmx6Ui9UVEpuaXdZU3h5anR4NUd5RGw2Qyts?=
 =?utf-8?B?M01iVzRYUmlJcWhpaHNodUhwMDBGZUNia2NJSkpCclFZekJPNjEwbkVseHFF?=
 =?utf-8?B?L1F6WjRpQmkxdGk3YitFdnNwdmZUbmdtNFloajZ6UVZlYlZrT1NNODdBUVVE?=
 =?utf-8?B?cHY0YmRFV3NxeFlRMi9yL1VCY2xqeFRJV2QyMnpxSThlaGVHQ0xjOGlrMmMw?=
 =?utf-8?B?Z0VLdnZzN0kwWWhNaE5JbTc0Z2JrRmVOOVZSK1FJUXNuY1dTVDRlbW0rdHIy?=
 =?utf-8?B?cjAveDNEQzhKZGpwQzgrRnlrYjNCdXpuVGdRQ2ltMVlRTUZvTXV0Wi9xL1dQ?=
 =?utf-8?B?UFc3WGQyRWFnMDFRcWZ2YWxWeWp2OXJlcjhSUG5JMmhoNFlmUHl3STBidm5m?=
 =?utf-8?B?RmRldStlRzlLV2xmSklJdzhOZ0VLS0NjRlQyY1BkZWZZYzZ6MUJMWlN0Mk9v?=
 =?utf-8?B?MDhRbjFsTlZtRG1sWnBuN3c5N3RDa213ajFyRFhyTkVlSUh5d0d2WmxhbXBp?=
 =?utf-8?B?SGFuR3VBZGhpMHdjS254UXNSNWM0ZldVQXdLckJxY2Uzd0JVTjFiL3VhcHAv?=
 =?utf-8?B?MUhjQlFsVkNlT0xiQzZOYnpkL3N4Uy9xUDB6Z0JtSFM0VVhsMFhxZnJrODF6?=
 =?utf-8?B?NVZocjVJbi85TVowVWRZbS9iREJUR1dwSEhFdjBQYkl6Uk5NSi9lWjB0UVVj?=
 =?utf-8?B?ejF4OVQxR0JrYi9PdUJQeW5pcm1tVS9sSmxtMzJ2TDJoa2w2bzAwQStNekFX?=
 =?utf-8?B?cmJhNmF0dU1URWNtMjRRUUY4c0VBb2FGS1F2em0rS2VPODcyVjlvS1ZEM2hx?=
 =?utf-8?B?SXEyOGhMOHJsL2E3Nk1QRUU1Qi9vd3J0TldHVUdJNlI0L2RRLzVlZWgwbEV1?=
 =?utf-8?B?ZTB2NTdURHpTZEF2VldZUnNJcnRHclMycVJDQ2N0dlNkd1BXeFRhN25uMHpK?=
 =?utf-8?B?LytwenNHeDBEK2VCOUs1M3VOWFNpUnN2d1pGWS8ydnNFekIvQWNNekxIdFYz?=
 =?utf-8?B?eGhZUTVTQzFvTElTZGQ3eXE2ZTIwVTl6TXhUQi95WjZFMTV3M1lxZU8wWVRv?=
 =?utf-8?B?WGVFMmd4bzJzajBSTUkzdXczVVgraW9pN2t5TmxpTVNYazlTeG1oTmxJNGcv?=
 =?utf-8?B?aHdUT0sydVY5VW85UGJ5NXo5YUV2OFptWkplMG9EemdES09aeVUzZHZBOHFi?=
 =?utf-8?B?M01DWWRwbjlrNkRYWktpSVV3STB6OUsyNjhxTWdSOUdobDZWbENYdXh5L2xh?=
 =?utf-8?B?V2VzY0I4UmNLSHFUanluZzVoamJqS0tKVTEwWlY2YlJGSUtXTDVaQm1BYS85?=
 =?utf-8?B?Y016VnRIcFZpeFM2dE9CUDQ2aTl0TE1sMWdGZ1d0U0N0RVFPWUIrT041NFhR?=
 =?utf-8?B?V3BHRVFvdkgzTUszL3kxV1JnOTh6Vjd4UXIyTksyR0h4SElJUHdBM2dJbjFD?=
 =?utf-8?B?SnJWRE1STjBKMnhjckNwdkFHSGdPd0cxVWFRejhjaHpaQU1za3ZjVHZUWFRh?=
 =?utf-8?B?eklsMzFrN1JBeE8wQnJjZk4rQ093Y3ZDY0M5cm9BN0RQdUU4clNZRmRJRXk1?=
 =?utf-8?B?U2J6Z2xzZ1ZLU2M5WHo3eis3UVJGMStpbTlDQkNkWHk3OXdjNy93L2l3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVJHdEJ0K0FMU2JZUitWT2pDMFYyQXVZdm1nVzFVVEJZQ3Y4UEZDbTZFWGFr?=
 =?utf-8?B?bEpOTXBaWU50L1ArS0d6Y1l3Zzk2M25pUTVxZU9IK3dKSGFkUFlXVVVIQUhF?=
 =?utf-8?B?ajR1eHh2UGtqOElMdERIMjV0ejNDT1R6djJkZTQ2azlIdTRjeWxEZkZ5SHI2?=
 =?utf-8?B?N0NxYlhsc0VXMkFjb2NOQ1FJVEFKRUc1cDAxY2g1RjViNXltN2RzWTltdVRF?=
 =?utf-8?B?dzhWV3VBQ2VMbnY4T1RyUTZBNzNBa3kxYjhRZVg5Unk1MHRWbE1VK01wc2I5?=
 =?utf-8?B?WTArZGdOWEZFekt1dWRHdUg1bFFQeEhwSTdYVm1OcFJ2OTNuaWdCb2lyZ3Z0?=
 =?utf-8?B?L2hpM1FNdnNmNFdOYXFWSlhCaTN2YnVxVGQ3T0VJeDV3ekRaa2tMVFZlNVFo?=
 =?utf-8?B?YlJhQTNEbFJyeGlpSTdrMmRONTUvb0FobVozQk0vbk1DUmtXNkJXMVpSTklP?=
 =?utf-8?B?YkRCckdDVDJtaDlNQmpLcm5SNjE0VDRnZGdwemtCSW1CLzZLbTJURnUrSWxM?=
 =?utf-8?B?Qit5VElya1MwWkpaSUtDOG5Tejd2M3pSVTJlUXlZb3R6YzB4TFNNalI3K3BN?=
 =?utf-8?B?OStwTVJ6QTIyRWxOUHpaNzBjcjd1OVdQakpVeVg3ZXI5eUN2azZlazdscmw5?=
 =?utf-8?B?NW00Zms1ODV2QktXbldHcThWWVVTOEFqMFR4dVVhRENIVWhuSGxFYXBKY3k1?=
 =?utf-8?B?OTlzeS96aGJtTS92NERFU3BYWElpR3Y0Yk1ERjdPWjdmanhHUjFEQk5GRlFT?=
 =?utf-8?B?RXJtNnlySnMxWTUzMnQyVkpqL1pHOWJPQTVVUlpodS94VG1uTkJPMXVVa0lS?=
 =?utf-8?B?eWJ1SmRJa001Y2I5ZUNVTVdjU1pOR0MxeEZIcjNJMzQ5NVRZajlBVVQ0aHg2?=
 =?utf-8?B?aklnaG9hbkcyM0MrNWVOMk1zMzU2cTJLaWE1MHRxWGtvT2VvbWJkcnlFL0VO?=
 =?utf-8?B?TkhJdkhZQUJKWm1xWmg5NkR0d3VMRTVYNW1TMzNySnh6SlpKWXVYWGViemlJ?=
 =?utf-8?B?TFRtaEZ5QzBpWmJweG1rTWsvMXdnVUpBTVg1Z1V5dmJtVHpYLzl5VjREK3ps?=
 =?utf-8?B?d2Y2VnVmOGJNR0lzT1hFajU4YTl4ZFhoMDVDRzRrblc1a29uanZhdXJqU3Zm?=
 =?utf-8?B?MVN6MFVJRVZTM25SeVozaFhwVWhaRklIbk0rc3pHOVhPSlM5ekNjcThBQ09a?=
 =?utf-8?B?VXdVWDUwa2krL0RYOEVINlBnNHdmdHJhd0lZK21WUVNJY3FtcDR4STZpWHJT?=
 =?utf-8?B?bUVJVVkrcHEwTXgrMU9VNGgyMnhsZEoyQldwa3ViMEUvdGdDTUFYR0lDVFZS?=
 =?utf-8?B?blN4Q1k2L2xFS2F5NkhtcVNtQWFDSmdlOEdCb3VGeUs2eDREaFVQNlhZaG40?=
 =?utf-8?B?YUFJRnVBQmNROFRWZEp5b0FROXJIVnludHlMOGJXRkhQVHUzb0FsdFNQQzgy?=
 =?utf-8?B?RjJhR2k3ck1pUWkwMVRyVzNwZGNYT0xxZnVBeTdLZkthdHBDOG0vQitxdFVn?=
 =?utf-8?B?Y005UzVvcVNaNGxzZnJvaE1HMHlBODlTM09tSG4zdXA0K0tGd1E4RVRhT3lE?=
 =?utf-8?B?VS9tVmt3UW1RenlMTDdKUzEweG4xL0dJMDl1cnBvY2FCYXpnaXM4d09sb3Y2?=
 =?utf-8?B?S0tjS0hOdCtuZjlKcVY0dk94S3RvOGJrbUxMcEZvek56TWdZdFU2cXE3b3dV?=
 =?utf-8?B?T01YNmdDOUVLRThWbktFSHhsTlY5SDBDc1lKY3Ewc05nSWlrMjd4SzdLcXpI?=
 =?utf-8?B?dG1BUDlWd2pxL0IwMmxoS1hVQnNRbnFReXN5d2g0bGEwbXpmbC90U0xEOHVE?=
 =?utf-8?B?am5ZTnA5ZUdqV2lkNEsvSWhycHdER2x4OEdtbE1qN3FIc0MwWk9NbkIrVnVW?=
 =?utf-8?B?NS9lNzY2Y29aeUR1S0RwV2lXeVhRaElqUDJNbm1Ec3J4RGxIMGh3di9JWHpU?=
 =?utf-8?B?d0ovTENwTEFFMHVRMkNVTm8rOFhabmlYRXdiMlhQT3hNTTY5YWlxS0dKeEdL?=
 =?utf-8?B?UzMrKzY1U0RPRVl1QlVicWlJYlBCeXkxM09vR0ZoS1R6VCtaUWN6TXZFSkov?=
 =?utf-8?B?YUpBWjR1MHFnTG1ESDI5YUh3TlZUY21lb0VSUHhNWDk2UFVqYzJ1YlIvKzJ3?=
 =?utf-8?Q?EKBCvjEziZWq4xtqH5YC6uTBT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbd0f7c-534c-4a6c-3d1f-08dc7f54bd07
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 20:28:30.6714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eacWYjqnCnypuUGzdnBfRBjde/sil+sBiu31leDPZtlUq76AkJCsn+cX4xTy54Guogmy53koV9BbAH3gs9Kj0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407

On 5/27/24 07:33, Borislav Petkov wrote:
> On Wed, Apr 24, 2024 at 10:58:03AM -0500, Tom Lendacky wrote:
>> -static int snp_set_vmsa(void *va, bool vmsa)
>> +static int base_snp_set_vmsa(void *va, bool vmsa)
> 
> s/base_/__/

Ok.

> 
> The svsm_-prefixed ones are already a good enough distinction...
> 
>>   {
>>   	u64 attrs;
>>   
>> @@ -1013,6 +1013,40 @@ static int snp_set_vmsa(void *va, bool vmsa)
>>   	return rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
>>   }
>>   
>> +static int svsm_snp_set_vmsa(void *va, void *caa, int apic_id, bool vmsa)
> 								  ^^^^^^^^^^^
> 
> bool create_vmsa or so, to denote what this arg means.

Ok. I'll change it on the original function, too.

> 
>> +{
>> +	struct svsm_call call = {};
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	local_irq_save(flags);
>> +
>> +	call.caa = this_cpu_read(svsm_caa);
>> +	call.rcx = __pa(va);
>> +
>> +	if (vmsa) {
>> +		/* Protocol 0, Call ID 2 */
>> +		call.rax = SVSM_CORE_CALL(SVSM_CORE_CREATE_VCPU);
>> +		call.rdx = __pa(caa);
>> +		call.r8  = apic_id;
>> +	} else {
>> +		/* Protocol 0, Call ID 3 */
>> +		call.rax = SVSM_CORE_CALL(SVSM_CORE_DELETE_VCPU);
>> +	}
>> +
>> +	ret = svsm_protocol(&call);
>> +
>> +	local_irq_restore(flags);
>> +
>> +	return ret;
>> +}
>> +
>> +static int snp_set_vmsa(void *va, void *caa, int apic_id, bool vmsa)
>> +{
>> +	return vmpl ? svsm_snp_set_vmsa(va, caa, apic_id, vmsa)
>> +		    : base_snp_set_vmsa(va, vmsa);
> 
> Why do you even need helpers if you're not going to use them somewhere
> else? Just put the whole logic inside snp_set_vmsa().

I just think it's easier to follow, with specific functions for the 
situation and less indentation. But if you want, I can put it all in one 
function.

> 
>> +}
>> +
>>   #define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
>>   #define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
>>   #define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
>> @@ -1044,11 +1078,11 @@ static void *snp_alloc_vmsa_page(int cpu)
>>   	return page_address(p + 1);
>>   }
>>   
>> -static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
>> +static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
>>   {
>>   	int err;
>>   
>> -	err = snp_set_vmsa(vmsa, false);
>> +	err = snp_set_vmsa(vmsa, NULL, apic_id, false);
>>   	if (err)
>>   		pr_err("clear VMSA page failed (%u), leaking page\n", err);
>>   	else
>> @@ -1059,6 +1093,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>>   {
>>   	struct sev_es_save_area *cur_vmsa, *vmsa;
>>   	struct ghcb_state state;
>> +	struct svsm_ca *caa;
>>   	unsigned long flags;
>>   	struct ghcb *ghcb;
>>   	u8 sipi_vector;
>> @@ -1105,6 +1140,12 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>>   	if (!vmsa)
>>   		return -ENOMEM;
>>   
>> +	/*
>> +	 * If an SVSM is present, then the SVSM CAA per-CPU variable will
>> +	 * have a value, otherwise it will be NULL.
>> +	 */
> 
> 	/* If an SVSM is present, the SVSM per-CPU CAA will be !NULL. */
> 
> Shorter.

Yep.

Thanks,
Tom

> 

