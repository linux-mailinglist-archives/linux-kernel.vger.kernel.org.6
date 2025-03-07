Return-Path: <linux-kernel+bounces-550858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4409CA56508
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7E6188FECC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801C8211276;
	Fri,  7 Mar 2025 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="P5+ISNKc"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668F2163B7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342736; cv=fail; b=CFFqyKtxubVQtuvQKqm7ljaFcHtaDKNP5BeTkCYVo9ACrfJcQ0iOoRMDtnmsVvG7vUt0yuloFeYUxWSnk1NZVmhXbiGmxcsCwxWPEVTvokBie+YKn2Q42G8kE6OB6oncGghtveAwtpHL3DOTGp2ptsGg1pTY0t1VUjFPXjVDpLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342736; c=relaxed/simple;
	bh=XwxtwOKj3hsuHucNd1XE17QS0aTxgocW4H/FjuQvb+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=LvfJiJ4wGpw1pLl6njD+J6lDNk0pE24Da5Hua3sqdhSmxarapTRui/r0P6xamyACki7igKVKCoRPUrwvNB1D4qqDs2wKzv/gP8JhLLXhtU+6pKjOQk0OVkkCtSuN/AX7Ll0iTzO84fHjlAxQ8Br67ggREeya5znJm7QM4FOZlxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=P5+ISNKc reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5270DYHT015546;
	Fri, 7 Mar 2025 02:17:32 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 457p2t8xj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 02:17:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1BE/Ounkqo8L4oKLlBAIxkaZWvXGvUvtN6U6nPV4+NMHtMOBArtH6KVOPOmhNKpB6V43RGUcJt5uOWCCDdbgp919XNgHhhW5jAqq+CtCiXcM4piDlKAhqp8Qx3UmjAUmwJ8rpTjOOlOD7p0oQOHysm9iVa8dmSzQJvzdG5bc3HBa/6kSnTRf7ctS7q0RhuP3LeXufafnI9I/omxQ+7rlbAQ2prZUUfG3hAWQi8xV2t9vGxsFJsky2GVNHHIEZETx01+jQ2CuPLULrCAQRlB5XE+dxahcGeDqayd6FsuDkc7rEhutCi8cG3fDg/SPEirKx84+ejB44GHvCeNSZnuuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lQVRfupHvq+5fXWJ9pW5+H7zvTfi0OnO+5B9EodI28=;
 b=PKLtBDc6hsL1M92JWI3ZqtcdOZ9Lml85nIlDa/KYx2RJmIoWnnPgljQBcqqpKxvAB7mfsTb77IzzAL4nMcp61PZtpiplN237RBLd4p9ywFJdfdhBrD7d3Td2Jyeeavi0fMdAfUMuQ1rQbjl6hzkUuV3NWvoEkv8Cu+lqRYRbTg2jxtMIWF7TVwsOTQJ8AiTXzjp2GqztMlc1fAFTUNG7W/hTPY0xEPC/2eECaglkzJLlChtpM5q92Z6GgotuDmoMZTlBD2fUrjVfxNn51Gl5T3lk39OJM2mivhsRBpEWjw+/jfiBvpJdSkdiWU8XxdRna5ZK6MrzZf4dQsF57E/V1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lQVRfupHvq+5fXWJ9pW5+H7zvTfi0OnO+5B9EodI28=;
 b=P5+ISNKcwpsTqfpSN8+yEYaPzmt5s3z0HAujiLZ2NC9vYQnouOgawkkWF96c9cNbjcHYtAe19LMN3ITJNbOgp2hj4jD2DQJkYWi1TZazjhKoxBdaaKtdEJkHuN/kgLtx2pB1WgkXfpL1bo40QY5xIE3BLTOlUphc4V0yPhLnWn8=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by LV3PR18MB5662.namprd18.prod.outlook.com (2603:10b6:408:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 10:17:28 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 10:17:27 +0000
Message-ID: <072e82c2-97c2-429f-a0e3-10eb0bd00b1e@marvell.com>
Date: Fri, 7 Mar 2025 15:47:14 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 37/49] x86/resctrl: Expand the width of dom_id by replacing
 mon_data_bits
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
        dfustini@baylibre.com, David Hildenbrand <david@redhat.com>,
        Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>,
        Koba Ko <kobak@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-38-james.morse@arm.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20250228195913.24895-38-james.morse@arm.com>
X-ClientProxiedBy: BM1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::32) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|LV3PR18MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bcafbd7-8f7b-4c20-cfa3-08dd5d6142d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFBvVUc4YmxMbkJWdmVHRlVDUXdtZGIrNHhySXBraUl5TlNOR1lKK2N4dlVE?=
 =?utf-8?B?SkxkUVpFOG5VTnZ1Si81NVFiOGpPTFRCazhWTVVPV0hmU040WkxzNkJyaFlU?=
 =?utf-8?B?SmFlM2hrR2ovNTlaYWp1L25DRFlua09ScWxmNlJkcEdBSml5R2FGekVVV2J4?=
 =?utf-8?B?OU5xWE04WklLWEwyaG82SC8weXRJVCs1TFoyalZxczZ4TTYzQTFPdlZtMGQ1?=
 =?utf-8?B?bm1SUnJFR1c2ejNmbVF4bTN4WGVIT1QxZTRNOWJHdXhYaHRUUVkvcHByRVEw?=
 =?utf-8?B?SmIyMFREMUtEUklrS0VHU1BhMUllYmZzS1Z6NG5GZjl6SUNCNHkzekg2SHI4?=
 =?utf-8?B?Y3lWUVkvcXFXdkxEUlhoWUJzUUtGeVQ4MTJDa0dEOGp4QzdOZjd6MlNPcTRR?=
 =?utf-8?B?YVhtc1NBajhEVEVGWloyVU1ZbWJadEk2d3lYMHJBZnpHd0ZwNFF3YXo2b1Vs?=
 =?utf-8?B?eFFaMXJhMVZ4R0NXR1dJRjNKQnNQdnRoWEI3QW1mdG5SSk82ZHJkRytNbDRi?=
 =?utf-8?B?T1JBM29SZzgxM09BRUFEbmxLQmpVQ3puSThWRThrYmFJT1BacURscmthczM1?=
 =?utf-8?B?S0lwNFFQYlFvZEEvZ0dNR0loZ0p5bmFWejFQVlZtSDIyb3pzMkxQS3BRaTNl?=
 =?utf-8?B?ZnMyODRlYmp6QlY5MHEvQ2w0SDVqTVpnNEp0UXkvRzJnZWtwMHhCeUE2NEhp?=
 =?utf-8?B?ZGQrRVdCUWJwczNHeER4b2pPNFJTSENrZkNiOGY5U1hOcWhyN1FEYXVTbFFR?=
 =?utf-8?B?MG9WK2c1eHA4bHJTWE5FYm1xTzVJWnR2U25lMlNsMGhuN1FOazFyQkkwZGx1?=
 =?utf-8?B?TmN5aExMM0NaWkxjMHVqbXAwZFRQYld0dDFtWENld0tkRC92ZzNiU3gvRzc3?=
 =?utf-8?B?SFlrVTZCamJJbytGN2JxSTlXVmp0TVFHNTZrZmJOYTdmZ2tzMlBxS1hXVDI5?=
 =?utf-8?B?clFpallSQkNsQWxZU1RuYyt0N1Q0bmhwOE5NOUx0MzlhOURJSDhQd3VaOThm?=
 =?utf-8?B?VThPVzhnNzBGRVlkKzlHTmVDMnErQkV3U2RzVHdXL0ZoZFNCdzlTbWRZTm14?=
 =?utf-8?B?c2VvcDJFLzdsVWJVeE5aYTViQXNSUlp2U3ZZRHR3Ny80ZjlmcUJsVmF6Smdp?=
 =?utf-8?B?a2ZiMlcraGNRdlpRNTByVDNzd04wbHFpQXJtUk44MDNRRHZOcDBiQTAvaGFF?=
 =?utf-8?B?bi9uUU11dkpmZ0NzUFkwR1hYaVd2SEFoQTlzcG9jVWViMEtBc3BITjMyY0FK?=
 =?utf-8?B?dFB5d3cvcTlGYzUwOVQ4WUlqYXFSWjZ4VFl0U3o0cTFUZDRBeFljYTBlbngw?=
 =?utf-8?B?VytuVXJvZWw0SHNJQ3lwRENlaElJWXR0aTJiSWY2Qmlkam5WRGJkYjFjZnhx?=
 =?utf-8?B?Z2lGQ3dabDhPNXlQNFFleXM1WVkwWVBDQlQ3cVdRWG1RYnVvcENXS3NVUmZz?=
 =?utf-8?B?UUpVcTZFV3hycnlWZWlJd1IwTlF3aklnS0hHaEFjREt0QXEvTzdiZFhVMVgr?=
 =?utf-8?B?aUZqQmJiMmY2Y3ZldnlqT2xkeE1PVEwyNngyQnJaUk9NclNxbllUWnBUR2t4?=
 =?utf-8?B?Q3NQZUFNU09nazN2OTRYNE1NZHc2b0xuRG42aTRodGNDVjVDSUpLMVZiaytV?=
 =?utf-8?B?eitkY1J1QVpjYndFY1VmV0k3TTZaNHpJQVZManpEbkYvRWI0RkRvTWdaMkRa?=
 =?utf-8?B?L1cwVTVFcWpGbEVCWkY5bXJVYVU3Q1hHdmtnaksveU1mNDNUTnIyRU1kVlNX?=
 =?utf-8?B?STJYL3NaVTdMcXNaQUtQODZHeURJcTNpTmRISEp5akNyYVVaamlOd2ZkeEV0?=
 =?utf-8?B?UVhYK0l6VXhjQmJLVmtBYy83bElYY3c0QUg3NERHSnJERjNlSlI2cUlkNDhQ?=
 =?utf-8?Q?h6fIoTfon/23k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm5xUmJpbUhFR3FubXV0Sm5VWXF3VUFkaExNd2VQL2wweS94bGxKRkhWMHgv?=
 =?utf-8?B?YUIvMVdoMWxtcDJYeHlWU2thK3dMZkxEVkpEL2lkWVplYXZrUFcwZVZlMlFV?=
 =?utf-8?B?WVN0dDFwa29mV2dHZWRKK3ExaTRMTER0TDJJaG5mSFdWcDJOQ25NemtpU0dm?=
 =?utf-8?B?YmJTWmlFakV1dDRhZHNtZ0FidDRBMjVYVlFUckU2czlnMzF4eVExRmJiYW5v?=
 =?utf-8?B?K01EK0o4UUhENVF4VFpDZTlzUHoxenpsajVqWDViMWo1TEJjdER6Y3JhUUdD?=
 =?utf-8?B?WEl6bVIrSnBCUjMrOTdhT2pJMEgxNUlqcGhqNDQySWpzZVRUcnlPNUJ3aU9n?=
 =?utf-8?B?R1ZSZ1Zwa25JZVBlcUM2SEtEcjdnRzNZcUpicXNsK2h4Z2R3QUdJalV3WlV0?=
 =?utf-8?B?ZVRCcm84RkxoQXd2VFh4TUV4elFRQ1AvTXRJcDZzT0QxU3o3dGZ3ck9xTEdh?=
 =?utf-8?B?azZYNUFMSHhKODN4L2tNamRLWUZBdnhPYlFJeWIyb3Q2L3lXM3hqT29PQ0I4?=
 =?utf-8?B?OVBLVzdnVXJWamtoREI2b0NKRWlFN2k3RnZ6MXN1SjBZOW5LcFB6clZsNnJj?=
 =?utf-8?B?NlJkZnRZbThxUjd3SjZ2SFlLKzFVTEE3Y2QxK1RMdVY2LzhYMWxTSGJWdWVs?=
 =?utf-8?B?UkpXbmlSUmVMb1VhWUhIbTRxclpDeCt5bTFEaTRBK3pLQURUSWVuSlJCUnMz?=
 =?utf-8?B?NnhwOVo2SGZkUHBvQWhXaktWYWRTb2pZS2EyZ1QrVW5MYkZWQ0tiekV2SDZW?=
 =?utf-8?B?Wk5qQVE4UXArTHhhRTZJNWhxRzVFbjFGb2E2WWMvNi9xY24vdGl5RGRJMmxn?=
 =?utf-8?B?N09GNXVwSkZSblQ1Mld5QWZaMmFrRTJxRWR4VmpBN05Bcjk5UTFSRUFWUjlv?=
 =?utf-8?B?R0QwazlDOFVyMVg1VEs2VXAzSG01UkdQREpWOEZTOFFYRy92ckl1SnBKVGRw?=
 =?utf-8?B?OEM3emVpeG1Md0V0K2JpRmlnOFhhd1NRV0FYZ2FhemJQdFljT3E4K2dYQ2ha?=
 =?utf-8?B?cmlBZEVoaENnakNlamNvT2NSRjBIVUkyVWVPOFAzaER0QUdBanlGL0pLUUZ3?=
 =?utf-8?B?bG1tUTVHMld4U2tCUHNoK1FIdDN6SkhmNVdDYytEM1QxOWk0NFFCbm10a3ZO?=
 =?utf-8?B?WHJzVy8xTW04QlhGeElIUzRUaHF2UVc1U0xjZmRIOHh6MVp3VEQ3SnBpbVpw?=
 =?utf-8?B?ZHJjTHBYdHlxbWdnMkY2cnZnc3ozMWk3Tk9sd3IvZVFHQjFPbWROY0lXNWtq?=
 =?utf-8?B?TUlKVVgyRHVGSjMyeERQd0RmUENML2lTUDQvTThJSVRFUlFTcHM1dXM3LzhM?=
 =?utf-8?B?VTc2WmdPeHBPMGlHa3FuaE1MSkYxSDNGbFpOd01nQnB1OTFXOTlQdVVERjJ6?=
 =?utf-8?B?RExnN3d4U0RuL0hJKzB3cG9nSlpLems2STFaV1lJcXRWdTRxdHpqbERaODJG?=
 =?utf-8?B?OC9CVDJ3SyttOUt4WWlxY3N0RE0ycy9McFNGdkxmZFlpQmJMUWFxZWp1UXQ5?=
 =?utf-8?B?a1pBeUQwSmcyK1ZYNTdhNFdhUWhld0NKekgrZkUzUmdVTFptdkRVY0ZDbWwx?=
 =?utf-8?B?aDVNd243b0o3ckkvdElva0c4Z2JVdyszNEJNKzBoL0E5R2h6RExxQnJFL2Ux?=
 =?utf-8?B?YWdydVUwVy9kUVFhSTRqbXJ2Q3NEM2QrQ0wwU09xWDUrRXc2ZWxNTVl5SzV4?=
 =?utf-8?B?d0YrdGdOaU1kV1htSmhQdTIzQ2pobm80ZnVHTkZKSUp6RFVzdnMxRFJsY1lC?=
 =?utf-8?B?UFhTSUZGOTRhc3BXOUIwU095Vlp5aHNBNktMMmZCUS9oRFJSaDZCY2h3VUQ1?=
 =?utf-8?B?M3AxNGF0cXl5U3ByQ1RrbUdWRDNyc3E1ZDhXZ1FmWGVOcHFPWjdqWHNjTlEw?=
 =?utf-8?B?eXJPa3orTGtIYmdOblpMSmdocjZ2QzBHNjJQRnNZWXVCN1RaRWMvVHptbkxi?=
 =?utf-8?B?NUdYME56NnUrYU5xM0wrMzROaGptZkNWcUpOZ2c2R3FuTkZWUzJtOEFUTE53?=
 =?utf-8?B?K1NKU1FrQUdJR2xEZXE5RHJrVFlheGJYaTJKTXh3dzZrV0ZqRDlqMktqeUJ2?=
 =?utf-8?B?eDZmRlBVc29WZWxxM0xIdlg4KzhSTVNYRlFWUFVLNm91U3REbjlZYTRYTTVj?=
 =?utf-8?Q?e7S5lqvwTz03i3pEkRcq9BoFb?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcafbd7-8f7b-4c20-cfa3-08dd5d6142d0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 10:17:27.4369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/dtr1r9ww1rL369VpwJm/xBW66M8N9/Ya7byU+8uAcwaAYaE4l8V+iP1wmTXNtbCm1VckZYWFTaRaW3ylErpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5662
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=TOC/S0la c=1 sm=1 tr=0 ts=67cac7bc cx=c_pps a=+tN8zt48bv3aY6W8EltW8A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=RpNjiQI2AAAA:8 a=7CQSdrXTAAAA:8 a=smdTkf2pP8M3szc7_pkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: Tnq9LaksePFhbWyzm8MV0E-wjhImdn63
X-Proofpoint-GUID: Tnq9LaksePFhbWyzm8MV0E-wjhImdn63
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_04,2025-03-06_04,2024-11-22_01

Hi James,

> MPAM platforms retrieve the cache-id property from the ACPI PPTT table.
> The cache-id field is 32 bits wide. Under resctrl, the cache-id becomes
> the domain-id, and is packed into the mon_data_bits union bitfield.
> The width of cache-id in this field is 14 bits.
>
> Expanding the union would break 32bit x86 platforms as this union is
> stored as the kernfs kn->priv pointer. This saved allocating memory
> for the priv data storage.
>
> The firmware on MPAM platforms have used the PPTT cache-id field to
> expose the interconnect's id for the cache, which is sparse and uses
> more than 14 bits. Use of this id is to enable PCIe direct cache
> injection hints. Using this feature with VFIO means the value provided
> by the ACPI table should be exposed to user-space.
>
> To support cache-id values greater than 14 bits, convert the
> mon_data_bits union to a structure. This is allocated for the default
> control group when the kernfs event files are created, and free'd when
> the monitor directory is rmdir'd when the domain goes offline.
> All other control and monitor groups lookup the struct mon_data allocated
> for the default control group, and use this.
> This simplifies the lifecycle of this structure as the default control
> group cannot be rmdir()d by user-space, so only needs to consider
> domain-offline, which removes all the event files corresponding to a
> domain while holding rdtgroup_mutex - which prevents concurrent
> readers. mkdir_mondata_subdir_allrdtgrp() must special case the default
> control group to ensure it is created first.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Previously the MPAM tree repainted the cache-id to compact them,
> argue-ing there was no other user. With VFIO use of this PCIe feature,
> this is no longer an option.
>
> Changes since v6:
>   * Added the get/put helpers.
>   * Special case the creation of the mondata files for the default control
>     group.
>   * Removed wording about files living longer than expected, the correspo=
nding
>     error handling is wrapped in WARN_ON_ONCE() as this indicates a bug.
> ---
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  19 +--
>   arch/x86/kernel/cpu/resctrl/internal.h    |  37 +++---
>   arch/x86/kernel/cpu/resctrl/monitor.c     |   3 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 142 ++++++++++++++++++++--
>   4 files changed, 162 insertions(+), 39 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/=
cpu/resctrl/ctrlmondata.c
> index 0a0ac5f6112e..159972c3fe73 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -667,7 +667,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *a=
rg)
>   	u32 resid, evtid, domid;
>   	struct rdtgroup *rdtgrp;
>   	struct rdt_resource *r;
> -	union mon_data_bits md;
> +	struct mon_data *md;
>   	int ret =3D 0;
>  =20
>   	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
> @@ -676,17 +676,22 @@ int rdtgroup_mondata_show(struct seq_file *m, void =
*arg)
>   		goto out;
>   	}
>  =20
> -	md.priv =3D of->kn->priv;
> -	resid =3D md.u.rid;
> -	domid =3D md.u.domid;
> -	evtid =3D md.u.evtid;
> +	md =3D of->kn->priv;
> +	if (WARN_ON_ONCE(!md)) {
> +		ret =3D -EIO;
> +		goto out;
> +	}
> +
> +	resid =3D md->rid;
> +	domid =3D md->domid;
> +	evtid =3D md->evtid;
>   	r =3D resctrl_arch_get_resource(resid);
>  =20
> -	if (md.u.sum) {
> +	if (md->sum) {
>   		/*
>   		 * This file requires summing across all domains that share
>   		 * the L3 cache id that was provided in the "domid" field of the
> -		 * mon_data_bits union. Search all domains in the resource for
> +		 * struct mon_data. Search all domains in the resource for
>   		 * one that matches this cache id.
>   		 */
>   		list_for_each_entry(d, &r->mon_domains, hdr.list) {
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu=
/resctrl/internal.h
> index 32ed9aeffb90..16c1a391d012 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -103,27 +103,24 @@ struct mon_evt {
>   };
>  =20
>   /**
> - * union mon_data_bits - Monitoring details for each event file.
> - * @priv:              Used to store monitoring event data in @u
> - *                     as kernfs private data.
> - * @u.rid:             Resource id associated with the event file.
> - * @u.evtid:           Event id associated with the event file.
> - * @u.sum:             Set when event must be summed across multiple
> - *                     domains.
> - * @u.domid:           When @u.sum is zero this is the domain to which
> - *                     the event file belongs. When @sum is one this
> - *                     is the id of the L3 cache that all domains to be
> - *                     summed share.
> - * @u:                 Name of the bit fields struct.
> + * struct mon_data - Monitoring details for each event file.
> + * @rid:             Resource id associated with the event file.
> + * @evtid:           Event id associated with the event file.
> + * @sum:             Set when event must be summed across multiple
> + *                   domains.
> + * @domid:           When @sum is zero this is the domain to which
> + *                   the event file belongs. When @sum is one this
> + *                   is the id of the L3 cache that all domains to be
> + *                   summed share.
> + *
> + * Stored in the kernfs kn->priv field, readers and writers must hold
> + * rdtgroup_mutex.
>    */
> -union mon_data_bits {
> -	void *priv;
> -	struct {
> -		unsigned int rid		: 10;
> -		enum resctrl_event_id evtid	: 7;
> -		unsigned int sum		: 1;
> -		unsigned int domid		: 14;
> -	} u;
> +struct mon_data {
> +	unsigned int rid;
> +	enum resctrl_event_id evtid;
> +	unsigned int sum;
> +	unsigned int domid;
>   };
>  =20
>   /**
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/=
resctrl/monitor.c
> index 73e3fe4f4c87..5bf67b429dd3 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1096,6 +1096,9 @@ static struct mon_evt mbm_local_event =3D {
>    * Note that MBM events are also part of RDT_RESOURCE_L3 resource
>    * because as per the SDM the total and local memory bandwidth
>    * are enumerated as part of L3 monitoring.
> + *
> + * mon_put_default_kn_priv_all() also assumes monitor events are only su=
pported
> + * on the L3 resource.
>    */
>   static void l3_mon_evt_init(struct rdt_resource *r)
>   {
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu=
/resctrl/rdtgroup.c
> index aecd3fa734cd..443635d195f0 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3114,6 +3114,110 @@ static struct file_system_type rdt_fs_type =3D {
>   	.kill_sb		=3D rdt_kill_sb,
>   };
>  =20
> +/**
> + * mon_get_default_kn_priv() - Get the mon_data priv data for this event=
 from
> + *                             the default control group.
> + * Called when monitor event files are created for a domain.
> + * When called with the default control group, the structure will be all=
ocated.
> + * This happens at mount time, before other control or monitor groups are
> + * created.
> + * This simplifies the lifetime management for rmdir() versus domain-off=
line
> + * as the default control group lives forever, and only one group needs =
to be
> + * special cased.
> + *
> + * @r:      The resource for the event type being created.
> + * @d:	    The domain for the event type being created.
> + * @mevt:   The event type being created.
> + * @rdtgrp: The rdtgroup for which the monitor file is being created,
> + *          used to determine if this is the default control group.
> + * @do_sum: Whether the SNC sub-numa node monitors are being created.
> + */
> +static struct mon_data *mon_get_default_kn_priv(struct rdt_resource *r,
> +						struct rdt_mon_domain *d,
> +						struct mon_evt *mevt,
> +						struct rdtgroup *rdtgrp,
> +						bool do_sum)
> +{
> +	struct kernfs_node *kn_dom, *kn_evt;
> +	struct mon_data *priv;
> +	bool snc_mode;
> +	char name[32];
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	snc_mode =3D r->mon_scope =3D=3D RESCTRL_L3_NODE;
> +	if (!do_sum)
> +		sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id=
);
This change triggered a minor report during compilation.

fs/resctrl/rdtgroup.c: In function =E2=80=98mon_get_default_kn_priv=E2=80=
=99:
fs/resctrl/rdtgroup.c:2931:28: warning: format =E2=80=98%d=E2=80=99 expects=
 argument of=20
type =E2=80=98int=E2=80=99, but argument 4 has type =E2=80=98long unsigned =
int=E2=80=99 [-Wformat=3D]
 =C2=A02931 |=C2=A0=C2=A0 sprintf(name, "mon_%s_%02d", r->name, snc_mode ? =
d->ci->id :=20
d->hdr.id);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~~~^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long =
unsigned int
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 %02ld

> +	else
> +		sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
> +
> +	kn_dom =3D kernfs_find_and_get(kn_mondata, name);
> +	if (!kn_dom)
> +		return NULL;
> +
> +	kn_evt =3D kernfs_find_and_get(kn_dom, mevt->name);
> +
> +	/* Is this the creation of the default groups monitor files? */
> +	if (!kn_evt && rdtgrp =3D=3D &rdtgroup_default) {
> +		priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +		if (!priv)
> +			return NULL;
> +		priv->rid =3D r->rid;
> +		priv->domid =3D do_sum ? d->ci->id : d->hdr.id;
> +		priv->sum =3D do_sum;
> +		priv->evtid =3D mevt->evtid;
> +		return priv;
> +	}
> +
> +	if (!kn_evt)
> +		return NULL;
> +
> +	return kn_evt->priv;
> +}
> +
> +/**
> + * mon_put_default_kn_priv_all() - Potentially free the mon_data priv da=
ta for
> + *                                 all events from the default control g=
roup.
> + * Put the mon_data priv data for all events for a particular domain.
> + * When called with the default control group, the priv structure previo=
usly
> + * allocated will be kfree()d. This should only be done as part of takin=
g a
> + * domain offline.
> + * Only a domain offline will 'rmdir' monitor files in the default contr=
ol
> + * group. After domain offline releases rdtgrp_mutex, all references will
> + * have been removed.
> + *
> + * @rdtgrp:  The rdtgroup for which the monitor files are being removed,
> + *           used to determine if this is the default control group.
> + * @name:    The name of the domain or SNC sub-numa domain which is being
> + *           taken offline.
> + */
> +static void mon_put_default_kn_priv_all(struct rdtgroup *rdtgrp, char *n=
ame)
> +{
> +	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +	struct kernfs_node *kn_dom, *kn_evt;
> +	struct mon_evt *mevt;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (rdtgrp !=3D &rdtgroup_default)
> +		return;
> +
> +	kn_dom =3D kernfs_find_and_get(kn_mondata, name);
> +	if (!kn_dom)
> +		return;
> +
> +	list_for_each_entry(mevt, &r->evt_list, list) {
> +		kn_evt =3D kernfs_find_and_get(kn_dom, mevt->name);
> +		if (!kn_evt)
> +			continue;
> +		if (!kn_evt->priv)
> +			continue;
> +
> +		kfree(kn_evt->priv);
> +		kn_evt->priv =3D NULL;
> +	}
> +}
> +
>   static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
>   		       void *priv)
>   {
> @@ -3135,19 +3239,25 @@ static int mon_addfile(struct kernfs_node *parent=
_kn, const char *name,
>   	return ret;
>   }
>  =20
> -static void mon_rmdir_one_subdir(struct kernfs_node *pkn, char *name, ch=
ar *subname)
> +static void mon_rmdir_one_subdir(struct rdtgroup *rdtgrp, char *name, ch=
ar *subname)
>   {
> +	struct kernfs_node *pkn =3D rdtgrp->mon.mon_data_kn;
>   	struct kernfs_node *kn;
>  =20
>   	kn =3D kernfs_find_and_get(pkn, name);
>   	if (!kn)
>   		return;
> +
> +	mon_put_default_kn_priv_all(rdtgrp, name);
> +
>   	kernfs_put(kn);
>  =20
> -	if (kn->dir.subdirs <=3D 1)
> +	if (kn->dir.subdirs <=3D 1) {
>   		kernfs_remove(kn);
> -	else
> +	} else {
> +		mon_put_default_kn_priv_all(rdtgrp, subname);
>   		kernfs_remove_by_name(kn, subname);
> +	}
>   }
>  =20
>   /*
> @@ -3170,10 +3280,10 @@ static void rmdir_mondata_subdir_allrdtgrp(struct=
 rdt_resource *r,
>   		sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
>  =20
>   	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> -		mon_rmdir_one_subdir(prgrp->mon.mon_data_kn, name, subname);
> +		mon_rmdir_one_subdir(prgrp, name, subname);
>  =20
>   		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
> -			mon_rmdir_one_subdir(crgrp->mon.mon_data_kn, name, subname);
> +			mon_rmdir_one_subdir(crgrp, name, subname);
>   	}
>   }
>  =20
> @@ -3182,19 +3292,19 @@ static int mon_add_all_files(struct kernfs_node *=
kn, struct rdt_mon_domain *d,
>   			     bool do_sum)
>   {
>   	struct rmid_read rr =3D {0};
> -	union mon_data_bits priv;
> +	struct mon_data *priv;
>   	struct mon_evt *mevt;
>   	int ret;
>  =20
>   	if (WARN_ON(list_empty(&r->evt_list)))
>   		return -EPERM;
>  =20
> -	priv.u.rid =3D r->rid;
> -	priv.u.domid =3D do_sum ? d->ci->id : d->hdr.id;
> -	priv.u.sum =3D do_sum;
>   	list_for_each_entry(mevt, &r->evt_list, list) {
> -		priv.u.evtid =3D mevt->evtid;
> -		ret =3D mon_addfile(kn, mevt->name, priv.priv);
> +		priv =3D mon_get_default_kn_priv(r, d, mevt, prgrp, do_sum);
> +		if (WARN_ON_ONCE(!priv))
> +			return -EINVAL;
> +
> +		ret =3D mon_addfile(kn, mevt->name, priv);
>   		if (ret)
>   			return ret;
>  =20
> @@ -3274,9 +3384,17 @@ static void mkdir_mondata_subdir_allrdtgrp(struct =
rdt_resource *r,
>   	struct rdtgroup *prgrp, *crgrp;
>   	struct list_head *head;
>  =20
> +	/*
> +	 * During domain-online create the default control group first
> +	 * so that mon_get_default_kn_priv() can find the allocated structure
> +	 * on subsequent calls.
> +	 */
> +	mkdir_mondata_subdir(kn_mondata, d, r, &rdtgroup_default);
> +
>   	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>   		parent_kn =3D prgrp->mon.mon_data_kn;
> -		mkdir_mondata_subdir(parent_kn, d, r, prgrp);
> +		if (prgrp !=3D &rdtgroup_default)
> +			mkdir_mondata_subdir(parent_kn, d, r, prgrp);
>  =20
>   		head =3D &prgrp->mon.crdtgrp_list;
>   		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
> --=20
> 2.39.5
>

On 3/1/2025 1:29 AM, James Morse wrote:
> MPAM platforms retrieve the cache-id property from the ACPI PPTT=20
> table. The cache-id field is 32 bits wide. Under resctrl, the cache-id=20
> becomes the domain-id, and is packed into the mon_data_bits union=20
> bitfield. The width of cache-id in this
>=20
> MPAM platforms retrieve the cache-id property from the ACPI PPTT table.
> The cache-id field is 32 bits wide. Under resctrl, the cache-id becomes
> the domain-id, and is packed into the mon_data_bits union bitfield.
> The width of cache-id in this field is 14 bits.
>
> Expanding the union would break 32bit x86 platforms as this union is
> stored as the kernfs kn->priv pointer. This saved allocating memory
> for the priv data storage.
>
> The firmware on MPAM platforms have used the PPTT cache-id field to
> expose the interconnect's id for the cache, which is sparse and uses
> more than 14 bits. Use of this id is to enable PCIe direct cache
> injection hints. Using this feature with VFIO means the value provided
> by the ACPI table should be exposed to user-space.
>
> To support cache-id values greater than 14 bits, convert the
> mon_data_bits union to a structure. This is allocated for the default
> control group when the kernfs event files are created, and free'd when
> the monitor directory is rmdir'd when the domain goes offline.
> All other control and monitor groups lookup the struct mon_data allocated
> for the default control group, and use this.
> This simplifies the lifecycle of this structure as the default control
> group cannot be rmdir()d by user-space, so only needs to consider
> domain-offline, which removes all the event files corresponding to a
> domain while holding rdtgroup_mutex - which prevents concurrent
> readers. mkdir_mondata_subdir_allrdtgrp() must special case the default
> control group to ensure it is created first.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Previously the MPAM tree repainted the cache-id to compact them,
> argue-ing there was no other user. With VFIO use of this PCIe feature,
> this is no longer an option.
>
> Changes since v6:
>   * Added the get/put helpers.
>   * Special case the creation of the mondata files for the default control
>     group.
>   * Removed wording about files living longer than expected, the correspo=
nding
>     error handling is wrapped in WARN_ON_ONCE() as this indicates a bug.
> ---
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  19 +--
>   arch/x86/kernel/cpu/resctrl/internal.h    |  37 +++---
>   arch/x86/kernel/cpu/resctrl/monitor.c     |   3 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 142 ++++++++++++++++++++--
>   4 files changed, 162 insertions(+), 39 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/=
cpu/resctrl/ctrlmondata.c
> index 0a0ac5f6112e..159972c3fe73 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -667,7 +667,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *a=
rg)
>   	u32 resid, evtid, domid;
>   	struct rdtgroup *rdtgrp;
>   	struct rdt_resource *r;
> -	union mon_data_bits md;
> +	struct mon_data *md;
>   	int ret =3D 0;
>  =20
>   	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
> @@ -676,17 +676,22 @@ int rdtgroup_mondata_show(struct seq_file *m, void =
*arg)
>   		goto out;
>   	}
>  =20
> -	md.priv =3D of->kn->priv;
> -	resid =3D md.u.rid;
> -	domid =3D md.u.domid;
> -	evtid =3D md.u.evtid;
> +	md =3D of->kn->priv;
> +	if (WARN_ON_ONCE(!md)) {
> +		ret =3D -EIO;
> +		goto out;
> +	}
> +
> +	resid =3D md->rid;
> +	domid =3D md->domid;
> +	evtid =3D md->evtid;
>   	r =3D resctrl_arch_get_resource(resid);
>  =20
> -	if (md.u.sum) {
> +	if (md->sum) {
>   		/*
>   		 * This file requires summing across all domains that share
>   		 * the L3 cache id that was provided in the "domid" field of the
> -		 * mon_data_bits union. Search all domains in the resource for
> +		 * struct mon_data. Search all domains in the resource for
>   		 * one that matches this cache id.
>   		 */
>   		list_for_each_entry(d, &r->mon_domains, hdr.list) {
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu=
/resctrl/internal.h
> index 32ed9aeffb90..16c1a391d012 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -103,27 +103,24 @@ struct mon_evt {
>   };
>  =20
>   /**
> - * union mon_data_bits - Monitoring details for each event file.
> - * @priv:              Used to store monitoring event data in @u
> - *                     as kernfs private data.
> - * @u.rid:             Resource id associated with the event file.
> - * @u.evtid:           Event id associated with the event file.
> - * @u.sum:             Set when event must be summed across multiple
> - *                     domains.
> - * @u.domid:           When @u.sum is zero this is the domain to which
> - *                     the event file belongs. When @sum is one this
> - *                     is the id of the L3 cache that all domains to be
> - *                     summed share.
> - * @u:                 Name of the bit fields struct.
> + * struct mon_data - Monitoring details for each event file.
> + * @rid:             Resource id associated with the event file.
> + * @evtid:           Event id associated with the event file.
> + * @sum:             Set when event must be summed across multiple
> + *                   domains.
> + * @domid:           When @sum is zero this is the domain to which
> + *                   the event file belongs. When @sum is one this
> + *                   is the id of the L3 cache that all domains to be
> + *                   summed share.
> + *
> + * Stored in the kernfs kn->priv field, readers and writers must hold
> + * rdtgroup_mutex.
>    */
> -union mon_data_bits {
> -	void *priv;
> -	struct {
> -		unsigned int rid		: 10;
> -		enum resctrl_event_id evtid	: 7;
> -		unsigned int sum		: 1;
> -		unsigned int domid		: 14;
> -	} u;
> +struct mon_data {
> +	unsigned int rid;
> +	enum resctrl_event_id evtid;
> +	unsigned int sum;
> +	unsigned int domid;
>   };
>  =20
>   /**
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/=
resctrl/monitor.c
> index 73e3fe4f4c87..5bf67b429dd3 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1096,6 +1096,9 @@ static struct mon_evt mbm_local_event =3D {
>    * Note that MBM events are also part of RDT_RESOURCE_L3 resource
>    * because as per the SDM the total and local memory bandwidth
>    * are enumerated as part of L3 monitoring.
> + *
> + * mon_put_default_kn_priv_all() also assumes monitor events are only su=
pported
> + * on the L3 resource.
>    */
>   static void l3_mon_evt_init(struct rdt_resource *r)
>   {
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu=
/resctrl/rdtgroup.c
> index aecd3fa734cd..443635d195f0 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3114,6 +3114,110 @@ static struct file_system_type rdt_fs_type =3D {
>   	.kill_sb		=3D rdt_kill_sb,
>   };
>  =20
> +/**
> + * mon_get_default_kn_priv() - Get the mon_data priv data for this event=
 from
> + *                             the default control group.
> + * Called when monitor event files are created for a domain.
> + * When called with the default control group, the structure will be all=
ocated.
> + * This happens at mount time, before other control or monitor groups are
> + * created.
> + * This simplifies the lifetime management for rmdir() versus domain-off=
line
> + * as the default control group lives forever, and only one group needs =
to be
> + * special cased.
> + *
> + * @r:      The resource for the event type being created.
> + * @d:	    The domain for the event type being created.
> + * @mevt:   The event type being created.
> + * @rdtgrp: The rdtgroup for which the monitor file is being created,
> + *          used to determine if this is the default control group.
> + * @do_sum: Whether the SNC sub-numa node monitors are being created.
> + */
> +static struct mon_data *mon_get_default_kn_priv(struct rdt_resource *r,
> +						struct rdt_mon_domain *d,
> +						struct mon_evt *mevt,
> +						struct rdtgroup *rdtgrp,
> +						bool do_sum)
> +{
> +	struct kernfs_node *kn_dom, *kn_evt;
> +	struct mon_data *priv;
> +	bool snc_mode;
> +	char name[32];
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	snc_mode =3D r->mon_scope =3D=3D RESCTRL_L3_NODE;
> +	if (!do_sum)
> +		sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id=
);
> +	else
> +		sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
> +
> +	kn_dom =3D kernfs_find_and_get(kn_mondata, name);
> +	if (!kn_dom)
> +		return NULL;
> +
> +	kn_evt =3D kernfs_find_and_get(kn_dom, mevt->name);
> +
> +	/* Is this the creation of the default groups monitor files? */
> +	if (!kn_evt && rdtgrp =3D=3D &rdtgroup_default) {
> +		priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +		if (!priv)
> +			return NULL;
> +		priv->rid =3D r->rid;
> +		priv->domid =3D do_sum ? d->ci->id : d->hdr.id;
> +		priv->sum =3D do_sum;
> +		priv->evtid =3D mevt->evtid;
> +		return priv;
> +	}
> +
> +	if (!kn_evt)
> +		return NULL;
> +
> +	return kn_evt->priv;
> +}
> +
> +/**
> + * mon_put_default_kn_priv_all() - Potentially free the mon_data priv da=
ta for
> + *                                 all events from the default control g=
roup.
> + * Put the mon_data priv data for all events for a particular domain.
> + * When called with the default control group, the priv structure previo=
usly
> + * allocated will be kfree()d. This should only be done as part of takin=
g a
> + * domain offline.
> + * Only a domain offline will 'rmdir' monitor files in the default contr=
ol
> + * group. After domain offline releases rdtgrp_mutex, all references will
> + * have been removed.
> + *
> + * @rdtgrp:  The rdtgroup for which the monitor files are being removed,
> + *           used to determine if this is the default control group.
> + * @name:    The name of the domain or SNC sub-numa domain which is being
> + *           taken offline.
> + */
> +static void mon_put_default_kn_priv_all(struct rdtgroup *rdtgrp, char *n=
ame)
> +{
> +	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +	struct kernfs_node *kn_dom, *kn_evt;
> +	struct mon_evt *mevt;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (rdtgrp !=3D &rdtgroup_default)
> +		return;
> +
> +	kn_dom =3D kernfs_find_and_get(kn_mondata, name);
> +	if (!kn_dom)
> +		return;
> +
> +	list_for_each_entry(mevt, &r->evt_list, list) {
> +		kn_evt =3D kernfs_find_and_get(kn_dom, mevt->name);
> +		if (!kn_evt)
> +			continue;
> +		if (!kn_evt->priv)
> +			continue;
> +
> +		kfree(kn_evt->priv);
> +		kn_evt->priv =3D NULL;
> +	}
> +}
> +
>   static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
>   		       void *priv)
>   {
> @@ -3135,19 +3239,25 @@ static int mon_addfile(struct kernfs_node *parent=
_kn, const char *name,
>   	return ret;
>   }
>  =20
> -static void mon_rmdir_one_subdir(struct kernfs_node *pkn, char *name, ch=
ar *subname)
> +static void mon_rmdir_one_subdir(struct rdtgroup *rdtgrp, char *name, ch=
ar *subname)
>   {
> +	struct kernfs_node *pkn =3D rdtgrp->mon.mon_data_kn;
>   	struct kernfs_node *kn;
>  =20
>   	kn =3D kernfs_find_and_get(pkn, name);
>   	if (!kn)
>   		return;
> +
> +	mon_put_default_kn_priv_all(rdtgrp, name);
> +
>   	kernfs_put(kn);
>  =20
> -	if (kn->dir.subdirs <=3D 1)
> +	if (kn->dir.subdirs <=3D 1) {
>   		kernfs_remove(kn);
> -	else
> +	} else {
> +		mon_put_default_kn_priv_all(rdtgrp, subname);
>   		kernfs_remove_by_name(kn, subname);
> +	}
>   }
>  =20
>   /*
> @@ -3170,10 +3280,10 @@ static void rmdir_mondata_subdir_allrdtgrp(struct=
 rdt_resource *r,
>   		sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
>  =20
>   	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> -		mon_rmdir_one_subdir(prgrp->mon.mon_data_kn, name, subname);
> +		mon_rmdir_one_subdir(prgrp, name, subname);
>  =20
>   		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
> -			mon_rmdir_one_subdir(crgrp->mon.mon_data_kn, name, subname);
> +			mon_rmdir_one_subdir(crgrp, name, subname);
>   	}
>   }
>  =20
> @@ -3182,19 +3292,19 @@ static int mon_add_all_files(struct kernfs_node *=
kn, struct rdt_mon_domain *d,
>   			     bool do_sum)
>   {
>   	struct rmid_read rr =3D {0};
> -	union mon_data_bits priv;
> +	struct mon_data *priv;
>   	struct mon_evt *mevt;
>   	int ret;
>  =20
>   	if (WARN_ON(list_empty(&r->evt_list)))
>   		return -EPERM;
>  =20
> -	priv.u.rid =3D r->rid;
> -	priv.u.domid =3D do_sum ? d->ci->id : d->hdr.id;
> -	priv.u.sum =3D do_sum;
>   	list_for_each_entry(mevt, &r->evt_list, list) {
> -		priv.u.evtid =3D mevt->evtid;
> -		ret =3D mon_addfile(kn, mevt->name, priv.priv);
> +		priv =3D mon_get_default_kn_priv(r, d, mevt, prgrp, do_sum);
> +		if (WARN_ON_ONCE(!priv))
> +			return -EINVAL;
> +
> +		ret =3D mon_addfile(kn, mevt->name, priv);
>   		if (ret)
>   			return ret;
>  =20
> @@ -3274,9 +3384,17 @@ static void mkdir_mondata_subdir_allrdtgrp(struct =
rdt_resource *r,
>   	struct rdtgroup *prgrp, *crgrp;
>   	struct list_head *head;
>  =20
> +	/*
> +	 * During domain-online create the default control group first
> +	 * so that mon_get_default_kn_priv() can find the allocated structure
> +	 * on subsequent calls.
> +	 */
> +	mkdir_mondata_subdir(kn_mondata, d, r, &rdtgroup_default);
> +
>   	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>   		parent_kn =3D prgrp->mon.mon_data_kn;
> -		mkdir_mondata_subdir(parent_kn, d, r, prgrp);
> +		if (prgrp !=3D &rdtgroup_default)
> +			mkdir_mondata_subdir(parent_kn, d, r, prgrp);
>  =20
>   		head =3D &prgrp->mon.crdtgrp_list;
>   		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
> --=20
> 2.39.5
>

