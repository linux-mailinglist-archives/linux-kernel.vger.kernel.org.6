Return-Path: <linux-kernel+bounces-224877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40507912803
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCBE287704
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECDF2940F;
	Fri, 21 Jun 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oCv4Wg2i"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723503214
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980671; cv=fail; b=Q2KYUTcVGTZZLG/+qdatDDd264bntjIu7ZJYjAMdXkN95+Ivmdqf+84V+J6aXlu22GTGLqCWr/ah1qi5e0M0MDeZ71LJ1fRJgOvIhnhuTg7ZQNmR8L7vw098pUDo4TITpCzJ7Z6i4GGKndcVWmE9PhTNXOtGGjW2XZZI184umXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980671; c=relaxed/simple;
	bh=17cPNkOwr+dTMhp9yjdkheY5IbglUoAj3e+mcg7ZpN4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fyM3m38JGIlBlTzdsOHKtTV3Ae3RSE6kDaH+PiQdxMR+6XVnojUGyJmyuVMumocKkckxjFwmzYyIlj3kbi7XC0HSgmNtloli+cHaqGBrrpPs581stXTiIJ9DhWL9Wa7cUiL6MCPGGb/Td0o635idDsc5d5LfDN+v+UB0t9AQ6TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oCv4Wg2i; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJs3FRP0RIzatNRKWxEieEMlU5W0WkY6mhOmFowjWbNQswRd+Ptmh6t42pvFWiYJCWIa5+L9shMJpSnYLSonUUGhnySXvvxnVBTxnPnMOqZZJrVjXt6pTK6STHfagFgl88ZcGU1mSZvOfsawnXlaYDJOxw1Ftgzmb86CKXlhNhHglGTGo26d3Y34mYCvwd3aWPVXA7XGKanTYWmznVp6ZVwtD8AkdyEGHGCpBb/zf+hXLTp+KPVKX46B5qreQai9emdCVfpK5ogY2D1JdHQZx12Sm+gNdDwlFcWqQpfpdx4dIgGrMbwc5yITG1a7WXTFee3ZdOpiV7l1Esn7fiGDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HzXJu+4LqfL1A5emsbIWtVoQUxBtwL5uj49WkwctTI=;
 b=W+eprGrdkpQ9xyeDjpwrXSKDshbinpXakohgMI8alwI89wSFNto4drmJAR7k5est6++YaS+Lp4PSUI0AbhhKXl2u5DEpR6WumltkqDN1SmeadRsYt1+K8o18H13EvhjzoP3hsa/fvqclLnDMz2PXLiHpFnjgccAD+QtdRCcTHke9vl6a222A/EElrMSoVVFx1f10pLfu76KkOf+eV6o6Jz92wLLa/Z8byXnfU33iEqJK5VV/GwH0N16f6f2Xmuu89d3e5rOB0lccLL7DyY1HMZkvf5d5p+qVUUF+BEgLzm6z/uMK+jc+bESYPv57I7LDnp0SBHWWHZ6ffvgUrHqVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HzXJu+4LqfL1A5emsbIWtVoQUxBtwL5uj49WkwctTI=;
 b=oCv4Wg2iqgDhMudq1Tqx5yoaEU3gmlunrlevpoeqHCscKc+TWa+1aGyv+0t4ja+LV5PkrgVIrEzojga+nR/E22cTCmpWv/8ENwVJgnTyVURhZN5zIz7guzbOHbUVOVl4s4Ry45AVEA5nxuFlba6frmEIvj1i8915CoSy3uEx7M8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 14:37:46 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 14:37:46 +0000
Message-ID: <187a0e4e-6e05-7da2-37bd-d75f9a6034e3@amd.com>
Date: Fri, 21 Jun 2024 09:37:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/sev: Do RMP memory coverage check after max_pfn has
 been set
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <92b4ba20a5afeb4aecde167bfac094d0275d8e1b.1717601917.git.thomas.lendacky@amd.com>
 <20240621135935.GGZnWHRxn08g8CkLNu@fat_crate.local>
 <4c4c8208-7194-79d0-a9cf-e625e5feff23@amd.com>
 <20240621142911.GIZnWON-Pgx4dSzlGZ@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240621142911.GIZnWON-Pgx4dSzlGZ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0193.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::18) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: 06448a82-2054-4d81-c3d0-08dc91ffb7a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MW5TS3ZPZzR1OHNzTWJqTnN4cy9paGFuWFg0V3I5ekpDRFFDTEpOZ3JoeTZk?=
 =?utf-8?B?RXNySVpWcm5hZll2d1pqUm5NSjdWTWx6OFNmSUYzdzRsWnY3UStFK0k2VXNo?=
 =?utf-8?B?YnUvNTRjZDQyR0pEMDNnS1FSdWwvc2ZKUkRMTjF5Mm1DYUF4WW92cmlzbUNr?=
 =?utf-8?B?UXZZbW1BamJmWWVTaStlRzdKVDdqeTJ1VVdlbFBPMDZRcm8rUjhEK25CNzdm?=
 =?utf-8?B?YjAwVVBpbVZpRDFxUVErYXZpTTF0N25EM0lGQXlNVU92WSs0ZngzK0NQbnFt?=
 =?utf-8?B?QWt4ZjAvUEhxdk1yV25FNVdYVE5ocUlGbEFQMzVqNm5CWGZWcmltVDRuQ1k4?=
 =?utf-8?B?WmFlbmJZcWxyQWRaZDc2NnRIb2FrTG9FNFZHMFdrc1p3MWwvQ25rVXVNdjZq?=
 =?utf-8?B?MlQwVE5kRmdEd292RW5yeTNOenBBbWdibVFIdFJVRVBjOTcvNzlodS9YK2RC?=
 =?utf-8?B?NlFLTHNVaVJNMmZpNXJkRUJFdm0wcjZ3THE0MmFIeXBKQm5RcFN2U1hiVG9r?=
 =?utf-8?B?dlZOMVBEeHFWbVQ5RC8rd2wyVkh3TktKSjhtbzVpQ1ByQUNyZCt3N2RIK01I?=
 =?utf-8?B?cHpwNk9XN3JTOE01ZmNXd1pOSWNSbVVBdFhQN2M5ZUtWTUlOQUJma3hiRGpa?=
 =?utf-8?B?WWthN3gySXFkSWpTbHFSYzJFMGkvVnlSdkZ0QjJMQUdabXJCZ015ak5rT2NJ?=
 =?utf-8?B?M044YjVEUlJlQWZzV2wxMyt1UUg5WjBkbFJvNTlBcjdGc0EzYkExU3JKVXNy?=
 =?utf-8?B?WFhiY3RHcHJXR25WMFBNNTAxdHI0WUlWNmFzWHBLSFJrejVGUlRxRXlTUFJt?=
 =?utf-8?B?Mzc4Vzcrck5ZZVBGTjlsTTJaOGZnN1pEYWVuZjNQMzhOMndZMXZVR1c0MjBy?=
 =?utf-8?B?RWo5bjJCK1dtYjFhQzZNQmFIc1FqdjRFSFJMTXpJclV2M042SkxrL2FBaklY?=
 =?utf-8?B?cTYxQklmU2lFOU5MejdmUGFLdDNLVG1UTkF5TVREQjU2THRHWkdoQXFVSWNv?=
 =?utf-8?B?TEZIR25GSGVHV0gvdHgxRWlJcEZuWVBDRHgwSldySnN2YkcxV3k0alJ0UEd5?=
 =?utf-8?B?ZTFBc1YvQnZqbnRpVXZIdUVLa0tkcytyRDhDUlRtNEJqSjBPWE91TklZT3Qx?=
 =?utf-8?B?Q29sTG01Q3NXMjVJOUtYSWdoMHVGMmxHcytYYmI0K2JWUSt1c3ljZlJnbVpU?=
 =?utf-8?B?OU5aS1pkdmcxb1ZSYzV0QkFNVXVOTi84TWgwUmsvUzkvb0dBbGNnQTJ3dm9N?=
 =?utf-8?B?d2wxekgxek1jallOdkgwQkJPL2NkNTNvb3N1Nzg1VkpwWGs0bHFxRTBiOGVJ?=
 =?utf-8?B?ZGN6UmNsRWt6Mm1pdEMzb2t1aHEzVWpOOFdzaTRLczdkbEgrVkdldHFGaTla?=
 =?utf-8?B?V1BuclZ6QWZHSS9GOTVsK3RONVVjRERROFZhalpWQUhCQWVta1ppb0lFT3lV?=
 =?utf-8?B?T052WWsyVDRWMlA5NCtpNElPN0JKNkdJK1ZJeFpBNVl5bTk3VFgzK2hYbDJk?=
 =?utf-8?B?ZktHb2RXR3BJRmVJY1FIT3M1VFRBdkVCZFl1NW1pcEI2Y2NRdTVmZGxQOUZT?=
 =?utf-8?B?U2prMWN5Qm14dDF4UDhKZS9oNThQejJKd1htRDJEV1JaSlNBeHBldXpQWkJy?=
 =?utf-8?B?WmtvdDVocFVBN2ViY3FkU2JWOVBoczFUVmh5TVh5UHFhLzhVVHFwa1Z5WHU5?=
 =?utf-8?B?dUVtTE9rejhaeldQMy9aMkdlUkJTNC9zZklHOWgxYVU2VmVvZlRFZnUrNjhS?=
 =?utf-8?Q?hLKpS2XYsJjK+jxfONzrIeekKGNq5JQl5rflfJv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?andrblJkZjlkSERuRTdYbjREY1dBRDVadVFyVnBWSjRkZW8xL2MrVk9TMFo0?=
 =?utf-8?B?QktaWnMvb2JKREhrKzVtRXlBOUVxQ0g5SUZoL0dHanhteXIwNGVySW1qN0dX?=
 =?utf-8?B?T2l5OWRTQnQ0azFBUkI3ek9qTis1SGc1bnFMUVZtTUFIaG81dldHaUNBWkxH?=
 =?utf-8?B?Rlc5U1EvSk1CeUdUMis4S0pqTG0za2h5ZExFLzJ6NTk1enNxL24xTFFrK09y?=
 =?utf-8?B?TjNHeCtoY29yRlovZzZpMFphOFhQYmcrNkFCT1IvUmhpL2ZrU293eis1d2NY?=
 =?utf-8?B?MFNpamw4TXgzT0FPYzJoOGVYckc3eUVLTkNuUTVNaFVub3pNVHZ3Y0lpaGZF?=
 =?utf-8?B?U2lROGFNZ0Y5aC96RXBrdXZWWkdkaXI3MlJTaHFGSE10d29iL2Q4R28wdWlY?=
 =?utf-8?B?T2dqMzZ4NDNGZFZUMEtXei9qWmMrUzkzdmhXd0pXWDM0TGhoWnRNdndwKzdC?=
 =?utf-8?B?SGNLVXZBM2VWSG9QbGxkdE9Fd09lTnIrYkRrZzdZT2VLd21WMWlJaGhLRzNn?=
 =?utf-8?B?SUpzb0JnTDMrNHlYZDFPTTNTdGowdm1yblAveE5aRFA0L0hTcjV1NTcrVG9v?=
 =?utf-8?B?dnh2NnFDQzJxQTFFSnNtb2FuVUNPWmxzVVJUaklENWduVXFtUXZhVkVSdjZi?=
 =?utf-8?B?djdrUmN6NjMyMGlWVDNWMndjQm1sM3JwejZQakkyZ0hYRlRhR1VRS2JXbFVP?=
 =?utf-8?B?TC9hUWZ5aEgzbWcvQkVQMmZPd3V6YXBLd3E2YStnM2tWaTNIUkpxVWE3KzBn?=
 =?utf-8?B?a2FrUFdqTVc5UHREZlFIa1lYbndEZ0lSU29FSkNjcURRMlg3Z1hhZk14emhR?=
 =?utf-8?B?SGFLNWlUWXJuS3hsb1htdXRlam45VDNDbmVzZG9FOERJdWI0aSsvQWtpWGpP?=
 =?utf-8?B?aHpNUEZKMSszSm5ld0VKb0sxUnpsTDUwM1gyc25ORUNybWl5UmgzMjhHT2pR?=
 =?utf-8?B?dnhlMGlZRThwREZNZ0prMGh3WDluSjV0QWNSSFpMMVB3U25kdDF0R0I2Mzl2?=
 =?utf-8?B?MnZuYzNjK2ZreXBZdHNlTHJCeWQ1UWFGK1hTZTlDMWhiSHVueCtVQ0dQMGpO?=
 =?utf-8?B?SFdVcnd1TzNma1JCRUhqN1JqemRSUG5JQW0vNTFvUzZhTmh5c0pmNDFoME0z?=
 =?utf-8?B?WmJVQ0FVcWEwY1FCQVJDdEgrY1VGL1J0UktFNGo5ZlNKVHYxYWJFZ0lPMnhw?=
 =?utf-8?B?K3B4Ynp0bU9taHYyU3Job2tnajhqUVlLckNTYkhhUWwzRWdodG04blhraUls?=
 =?utf-8?B?bjhXMzVFWEd0b1hFdEhnOFpjUklnS3lUOUVNNytkNHJ4T2w4K24zR0lOWXNL?=
 =?utf-8?B?cUYrNkcvdktIV1BMWndTZ1BCWkc1UW9PSldoVlNhbzVSN21xN05lalhOR3U4?=
 =?utf-8?B?V3hIMHNNdFpaUXpjV0N4VFVmU2xsU2pLaVp4c0pVSXBjVlhkWkhRaE9KaG4z?=
 =?utf-8?B?bXJtWlJUWStnckwxZUZPdXRrS3RqN1ZZVEtncFpndmlRdzhqZnpuejcvYVF0?=
 =?utf-8?B?ZjlBK2UvcmdrZjk3OWxQWldLc1VDSmFMSmc0aVBpdHQ5VW02bHV5eDUrWGky?=
 =?utf-8?B?UzNWWGpZeHFRMEVCN1gxRlpkQUlrR2JkZHFUdFBDbHN2UWdIcUlLWUl2bWc4?=
 =?utf-8?B?ZjR2bzNQcjNNUjZnWVh4dmpVRkx0S2JsdmxoRVk5ZklXOVB5d3dMVVpyT3gz?=
 =?utf-8?B?TldzbGYwTDJWWURRY1lTS3ptSjErd0h4L2UrZ3dnSERPcUdqSlA2T1VNMFRF?=
 =?utf-8?B?NHdLWTVGSHpkVm16QnBocTl3SGs0YWlZMUJsWGxvck1TRG5qbm02ZDczZUJL?=
 =?utf-8?B?UDNwaVF2RDcvWGNPKzZiWFFNMGZMOVJEamEzcnpXQUE3R0luUnJTeFRGOTVQ?=
 =?utf-8?B?Z3BKNzY3M1Y2YWkwbUVmejNkaUhXSzRudkNUNStFbGpsdExlRkF6V2dqTnh1?=
 =?utf-8?B?VEU4d3dGVDhsQ2FNMUxDQmt3dFRUYzJ5THE1N040TzlPbVMrVVdKN1RndXRY?=
 =?utf-8?B?WmluNTVnYVFuMjVNeUh3Rzlydm44MVpuekxUaEUvUjlJWlh3U1B3anFHTTFB?=
 =?utf-8?B?dkQ2cXJkd2s2NC9kMVNQbERMaEM5UWdLWXcvUVFLZldKOW93TTl5UmJkMkl5?=
 =?utf-8?Q?q7Qu92zhLizK7tG0gqpNd6972?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06448a82-2054-4d81-c3d0-08dc91ffb7a9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 14:37:46.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +U/XtUTegPUxtXf0G5wpIylTb7YuLE6Mf1ZxON+s2WYOlidOM+f8BAraux+6kiFcvVyJ9oBWRm2lclLCwMOGVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

On 6/21/24 09:29, Borislav Petkov wrote:
> On Fri, Jun 21, 2024 at 09:17:35AM -0500, Tom Lendacky wrote:
>> I think it makes the code easier to follow and less of a chance to compute
>> the value wrong given you have to substract 1 (end = base + size - 1). I
>> guess I can create a #define or a helper function so that the calculation
>> is always the same if that is preferred.
> 
> Why, what's wrong with this variant?
> 
> You can always do a separate variable if warranted but right now you need it
> at exactly one spot and one spot only...

Ok, I'll remove the new static and resubmit. There is also a logic error
in the original check which should be using PFN_UP instead of PHYS_PFN, so
I'll include that, too.

Do you want a single patch or two patches, one to fix the PHYS_PFN to
PFN_UP and one to move the check?

Thanks,
Tom

> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 0ae10535c699..8a87c0344833 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -120,7 +120,7 @@ static __init void snp_enable(void *arg)
>  
>  bool snp_probe_rmptable_info(void)
>  {
> -	u64 max_rmp_pfn, calc_rmp_sz, rmp_sz, rmp_base, rmp_end;
> +	u64 rmp_sz, rmp_base, rmp_end;
>  
>  	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
>  	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
> @@ -137,28 +137,11 @@ bool snp_probe_rmptable_info(void)
>  
>  	rmp_sz = rmp_end - rmp_base + 1;
>  
> -	/*
> -	 * Calculate the amount the memory that must be reserved by the BIOS to
> -	 * address the whole RAM, including the bookkeeping area. The RMP itself
> -	 * must also be covered.
> -	 */
> -	max_rmp_pfn = max_pfn;
> -	if (PHYS_PFN(rmp_end) > max_pfn)
> -		max_rmp_pfn = PHYS_PFN(rmp_end);
> -
> -	calc_rmp_sz = (max_rmp_pfn << 4) + RMPTABLE_CPU_BOOKKEEPING_SZ;
> -
> -	if (calc_rmp_sz > rmp_sz) {
> -		pr_err("Memory reserved for the RMP table does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
> -		       calc_rmp_sz, rmp_sz);
> -		return false;
> -	}
> -
>  	probed_rmp_base = rmp_base;
>  	probed_rmp_size = rmp_sz;
>  
>  	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
> -		probed_rmp_base, probed_rmp_base + probed_rmp_size - 1);
> +		probed_rmp_base, rmp_end);
>  
>  	return true;
>  }
> @@ -206,9 +189,8 @@ void __init snp_fixup_e820_tables(void)
>   */
>  static int __init snp_rmptable_init(void)
>  {
> +	u64 max_rmp_pfn, calc_rmp_sz, rmptable_size, probed_rmp_end, val;
>  	void *rmptable_start;
> -	u64 rmptable_size;
> -	u64 val;
>  
>  	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
>  		return 0;
> @@ -219,10 +201,28 @@ static int __init snp_rmptable_init(void)
>  	if (!probed_rmp_size)
>  		goto nosnp;
>  
> +	probed_rmp_end = probed_rmp_base + probed_rmp_size - 1;
> +
> +	/*
> +	 * Calculate the amount the memory that must be reserved by the BIOS to
> +	 * address the whole RAM, including the bookkeeping area. The RMP itself
> +	 * must also be covered.
> +	 */
> +	max_rmp_pfn = max_pfn;
> +	if (PHYS_PFN(probed_rmp_end) > max_pfn)
> +		max_rmp_pfn = PHYS_PFN(probed_rmp_end);
> +
> +	calc_rmp_sz = (max_rmp_pfn << 4) + RMPTABLE_CPU_BOOKKEEPING_SZ;
> +	if (calc_rmp_sz > probed_rmp_size) {
> +		pr_err("Memory reserved for the RMP table does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
> +		       calc_rmp_sz, probed_rmp_size);
> +		goto nosnp;
> +	}
> +
>  	rmptable_start = memremap(probed_rmp_base, probed_rmp_size, MEMREMAP_WB);
>  	if (!rmptable_start) {
>  		pr_err("Failed to map RMP table\n");
> -		return 1;
> +		goto nosnp;
>  	}
>  
>  	/*
> 

