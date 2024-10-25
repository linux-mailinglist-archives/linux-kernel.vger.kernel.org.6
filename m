Return-Path: <linux-kernel+bounces-381788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1829B0475
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED3428427C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F2E1E491B;
	Fri, 25 Oct 2024 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sberVN8g"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED01632DF
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864034; cv=fail; b=oGDcaWXdX8iCMlYZkzafuz/7s9HvDAjsou8+8eJJ2Xd+gMy35jd4mZgeVvdCeGJQuYQwewrH157xVo2GcG+TSGHeTGujyObRUht8N7K0c91K067n2LciE1y/hQvBc1GcLf7p9sAwvLrImC0tYHzwLDziLpf+nN3P4Hfb/tycWrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864034; c=relaxed/simple;
	bh=rOrU1pLZil/65rbYxHOdWsworbmiW6lOk0o7Fc2YEVI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JJzRVTl9DAj4dXePOyIfeMDTg7JNoevhFq6+mfk0sryRo7g53ClKGzVb+962PGXmnC+ObyiFjcXsdryvQzXnHv2PQw5IuitXtd2u1qCxhQky3yr9rxWZFeVg4AT8FjtEDCSHyKYHEuZieSfVUYIv1Ii8aOLWoHbyVVnzHH2g77M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sberVN8g; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4AuyTCd1NScAJgcKLPY1NpylnU7oSX7IVKsQfp78U88FqPBB8+i+Y1/S77gi3CJ3N3gNnIGdeJtyX5LTJF5tyEIv2v387NH4KgTMJStK81zg86gpGoaZFxrWJR9/ZuC7DeDKh37Dc/Gk2OJ7WPC+10d0G3QoM3WLxxLzr2imQfV5cTslJHmUjksSddNgaF3M63io76xw2e+Ir/fg68lfN3s2uEF7GYm1fGOsfBC0rFSC4hHIDTPzevVEa5/1qrVAjYHdQsQ1yx1sDzkADvjYhhsdmC3Tm7h430v+g+6XWlvcdXn2oUVWhxOIPkJYwxWX6poDdbxtbU3CfHbeymWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9p+IULW2yFfcp14Hazj67ufGsykM9k6r2EHJhKYmXk=;
 b=AfQoZhau11BRYCz/tAC9yWhml4Y8jtS9Ix0xrCVrLate6ze7jXgzVw4Ik8wYNcBfHjUNlpJG4DHvK75FDHqx6SQ3PtIPYXjFZh8lx5DtXAQAY19eeDHVL5RkwpnyLzbXFOn1GhFycSg+2VyPhCB1WLpbZwSDXoPp8l9mdHEatn1j1FP6q2L51b4CiXVxgUCkMw8Lryi+wmZ/5JxVC1v9R4imZIWgVockvddiJKbIu0cRxg2a1FkkHmjLSFI16/oQ8l1kSQYBOXB0UsRUNUs2tGk9xUijphH5C5Xi1mhZ3NaPUET1/IYEEdpb+fHFMXtPytB+jeBHZcqbMQeDzGfHfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9p+IULW2yFfcp14Hazj67ufGsykM9k6r2EHJhKYmXk=;
 b=sberVN8gzyDOk8finxnk+ArGuFwM9Ii8lx7smOUtWYc7rk7E1vqTIn8oYHilEZkBWQ1uaOw8PLAPSRojatpH2qsu+drcR8j5foA99RurjGULG7jJsvv3IMcP+Eke2EtSU9msCiGe5qj2y8YXhoiFSynfN6aqS0r/flLqxSNO7SY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 13:47:09 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:47:09 +0000
Message-ID: <2dcb1db1-fc1b-0fd0-f878-470cfd22e8e8@amd.com>
Date: Fri, 25 Oct 2024 08:47:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/8] x86/sev: Prepare for using the RMPREAD instruction
 to access the RMP
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
 <5e8bbb786f0579b615a5b32bddbf552e0b2c29c8.1729708922.git.thomas.lendacky@amd.com>
 <20241025120920.GNZxuKcBsMvYTd0ki-@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20241025120920.GNZxuKcBsMvYTd0ki-@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0035.namprd05.prod.outlook.com
 (2603:10b6:803:40::48) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b48e6ae-e4b0-43d3-887b-08dcf4fb8553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2x3UiszdjVnbzhIRElISXkrWlIyajRyWHIxd2tETFpGV0VzaU5weHBnZWlk?=
 =?utf-8?B?MHJJQ3NJMnNLVnZVTExTVFlDUm1xbGE3SUNZRnRtNHZQV2dUQlJFU3FUT3Ay?=
 =?utf-8?B?eGtmNHNNeDdZVE5yS2RWUHl1anJFcFNMVlQrcmRZbDk4SEJOWU0xYURvczdy?=
 =?utf-8?B?aUdoVGRucTM3aEJMK3F0elV4alY3NHNsZmYzTDV5WGVVSzdEQnU1SEZlN1gz?=
 =?utf-8?B?a051c0hkSUV0V2RNdHFQcUFmbGtjdmVGWVc2akZrYmlxU0xRTmJaS0ZFQ1Zl?=
 =?utf-8?B?aldLM2ltRmkvRDRGNE5NaVNwaVFpWXJiYmdpQmdGUDlnenR0cHJJV1JTWTk0?=
 =?utf-8?B?dzJ6dk9QN212bm13VS8rTmdJQmFnZDFIZzQ0RE5CME03R3pFMDFqYjFQeUR2?=
 =?utf-8?B?RWpacHkxcDJXVGtEcU5XdURkYzRBYzNTZldlamUvaU5BVDNTT004VzRza2ZO?=
 =?utf-8?B?Z25xdmtDRTNhMUttUVA2eG80bFZEY3FhVFUxckl5TTZ5TWJ3WHJ2Zkx1Nys4?=
 =?utf-8?B?L2ViVTUya1g0MnlxenZwc2dOSW0zbTZlT1EreTFJZlpTbGZ3RjlGc1ZwTC9n?=
 =?utf-8?B?WFhXR25lSXRHSjQyeW5YNkdCZ1p3QWFIYk1kbVRYUDhiWkNCNEc1Q1NLV3Bx?=
 =?utf-8?B?eHpLSEhKK2o3OUJiekh3cFkzdVUraE5PeFNiQlJsRnk4c3RCNkUvdXAxRmV3?=
 =?utf-8?B?RFpRNXM5QjR2M0pLKzFYdERUMHVEUFMyS2h2eTNFNHBIR0lCSWZ4bHc2b2Fl?=
 =?utf-8?B?b2F2NWRzemVyRmIxMWwrOXVTSmN2SnFJK0xMT1A2dFEyRGNJRHlIaG10eUtr?=
 =?utf-8?B?WkExQk8vcDBNRGtacHNCaFFCajA5Ty95aCtWMlliOFZiRVYzMUVJMnY3WUFp?=
 =?utf-8?B?YkJ1d2ZleXhmK3ArVGVsSitlWmh5eG9YbzJPOEhrYjdWWFVDVzFyMERXNHU5?=
 =?utf-8?B?K3NFQXlWR3d1SFFpbHRnR3I0QkEycW9wU0wzTWlhc1dDQkhoQVptRkxUS2Nl?=
 =?utf-8?B?V2V1K1laeVFqU3phb1pVT0I4a2NxNCtKMnJSZFFqT1lxMWlweFcxS3ZXTnVx?=
 =?utf-8?B?dGUvUFpvL3Y2SHgwQ3lpTWRCY3BId2FLY3c4SGhaVnREaDVuMzBKZzVIL283?=
 =?utf-8?B?QWR3V3BVQ0kxTzVhSkJsejFVVUtjdEFwMTFqZFlOZ3BtK01qbVdFSTBQeFFx?=
 =?utf-8?B?T21OMVAvZHN4U016YjRydmxPZitrNW5kRURvTXlPcjRNZjBIdSt5am9UQ3Fj?=
 =?utf-8?B?VitCTVE2VDJrb2xsRGJURDU1cUhydVpJUlR1VEk1WC9leHA1OHZOelVSb0hz?=
 =?utf-8?B?b1FlSmpodTV1ZEtHTWttN0JFMlkrdXdjSDQ5V1hLcGNEUGFlTkhsendzTFl5?=
 =?utf-8?B?b24xc3luajVQZmdhckREN0ZRdjFIUVVLTE1uTU5IZHpNcmZCWUU0SlpUam42?=
 =?utf-8?B?NkNPRytvNU9yUVFkMlhUV2pnSVdVdjlHdFpDMnRSbDB6RlFjS0crTXQvbGo5?=
 =?utf-8?B?TzByK21YZ011cC8zMGdGU2ZDZkpqNXl1SEhWa0hEVEh5aXo0V3hibWFwdm1Q?=
 =?utf-8?B?NFRHU0hIQVNmZklBbUcyd1F1RTRwN1F6QkQrWnNobDFOUXRZOUhWZlRsOFZF?=
 =?utf-8?B?Q0dkVmVLWmRvSHdVTkgvR1ZYdFpUdlJnTnJ1QlRvT1ZnTzRvUS84TkJhVXpB?=
 =?utf-8?B?bUFyM2RoQzI3M0x3WjZZZHp6RzgxaUpnd2lKeStSNGgwaVEvVU43Z3BRQWp0?=
 =?utf-8?Q?SfV53RYuAMLEfLTLHEy+wT2DPX9o3jBwpjpSkEC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlU2RWRZdGNhdkhHSWVMb0hVWTFObmVVZlV3YmluT0tpZXhuV0dzc2ZtbkVU?=
 =?utf-8?B?bkg3ZVpjYkV5TzRhTVBwb2ZkWG5mc2tzTFRiSng4RXd2TjkwRFN3a2xRZEZp?=
 =?utf-8?B?SEs0RzZ2ZVFYVlRYM3JBY3ErUm4rKzVVcGFoNlVrd3lURXUxQ2thMmN5OXlK?=
 =?utf-8?B?bzZuZU5OWjYwNnpONXV5THd4UnVDQldFQkVSVnM1cVl1dGxRdHdrazR2VlNX?=
 =?utf-8?B?Qzc4c0FOMDdsTDBuV3RFbSsxNktYSVMxbkNBMlYyb2owOVhUN1hjZEU2UlRj?=
 =?utf-8?B?T2ZESUc1cjhmTVM5NmhXdE9HRjUramRzREhHWmhXQWdLdVpNYjhjTmUrREEx?=
 =?utf-8?B?Tm1Eb1lUT3U3ZVJYWWVSeFE1Qkk4c25XK2xlUGtJand3UlhZdUJDL0hDdDBZ?=
 =?utf-8?B?YkxrRzZKTkpGOFpmOFpnWk0xdDQyZGcyWVhNVXpJbDRhUVFjbDJRNVFBY2dN?=
 =?utf-8?B?Q2hFb1FZWFB5WE5BNEtVKzgwSVIvcUJ3b3grRE55cWNyZGQrK2xLdFhoS0RE?=
 =?utf-8?B?RXNVODhCRVpKcUN4ZFVJaU9POXkxRTAvaXh2RjhVdXVkeW1sRzV3ekNmbUs0?=
 =?utf-8?B?SFpUMUVUVGxwdmE1UUJoRm01L0EyNllNTEFKZjA2V1V4V3hqQjJnK0t2TVAx?=
 =?utf-8?B?UDJsWDQ2eXNUZDlBWitHZHI5QlRERmg5UlRPSlhpWFBYbk41UjFITEkrcDNW?=
 =?utf-8?B?ZnVFZ01NOGhHUlhVeTA0cC9MSldKWWtzRitDRFQrTWhoWEtadVBNSUdHSTYz?=
 =?utf-8?B?TUl6cGdzdEtVV2N2TWhGNkJZWFJwTlBYeWVmN3hqNUFXcjVDTHZtakI0dmNQ?=
 =?utf-8?B?NmdveStIQTIxZ1BmQm5yemphUnNwWXhTMlZwOW83UUxId3lhQ1VRT3BKbzMr?=
 =?utf-8?B?QWZEelVxS2M5WWsyZjUweTdrd3VURS9pTDB2N09ERkovWDBoY2hsQkRmY1NI?=
 =?utf-8?B?UWN6M0puaU1BcERDSnRIblRnZS9XbU1kcE1VNnNjZWJLbmM0VkhsRzNtQWox?=
 =?utf-8?B?WHBWOWVXT0I2WFk3VGJOdEZlYjBZcDVTcUpOalhTN1V0SFhCbXNHeXROVG9V?=
 =?utf-8?B?OFhXajhEcW9OSm1NaUtSdm44aWJVbnVydXBUZVg3SXUvNmorVTZmNHhBemc2?=
 =?utf-8?B?N21XSS9lbG56QWdNUE1tN3ovaVVXUGV3aEozSEQ0SmxrWTRlNVh2RTBOQnBS?=
 =?utf-8?B?Rkw4dHNDTEtOVzcvZ3N2N2RjRU9hRTJPMnhCYVV4R3A5cTJ4ZGFKWW5aNlAr?=
 =?utf-8?B?aFZMajZFYkxnQTFxL1oyUnR3UTRRK1lRZjdRQ2tMR1dLVEZmb1RQbTJQSi90?=
 =?utf-8?B?THhSOUhSSVhFcFo4MVBiOUQwdEhtRFRmeE4wT2RDZC9aVHcrM2N1bVltY2p6?=
 =?utf-8?B?L1ZRUTRvOWhsTk4zaFVnZ29Qeko0S1pxL3M0NlF0ay9WcE9SMUhuYVFVM0Ro?=
 =?utf-8?B?clBmVHg4ZnppeWgyZmZJSmdPNDZxbzJkbGtrY3dUTnExc21MTjl2UGdVNXRw?=
 =?utf-8?B?STA3dUpjT2g5NXk2bEoyQlpHZ25VOFpiN3dqeENwMUwrZ2xndVJZYTlzbmZU?=
 =?utf-8?B?ZkVkQnBpUG9sM3RXV0J5dE5ZUW1yT05jQUh3VzVPSVFXUlIyWHRlQllSYjZP?=
 =?utf-8?B?aXJOTVREZlZ6djlRNzFHNWEyajlNMFc2bW1vYm9XWitBdVpMc2s0Sk1pSEJC?=
 =?utf-8?B?UHM5cjQzNkxTclpIeDFYb1JFbjNqRjhIY285ZGo2Z1IzVkduSkYydlVVNHNq?=
 =?utf-8?B?Q3RsNmVNWHo2RXc4Q0pEeDhLZFhjQVY5eS80dFp6UmZENXhUSERORHd1eGoy?=
 =?utf-8?B?QkxxREk5WUJ4eStQTGFwbE5UZldRVXorY0xnQnQ0c2xHVnloMCtvMEZxNnVF?=
 =?utf-8?B?dXljY3FrcHhjM2Jkd05aU1dMUDFteUp0UmttRURySVpzdzQ1S1RGVXloN1cw?=
 =?utf-8?B?OU94YkRoYk9FOWsrMmtIU2JIUVo1NGFBdmRxdU5lK3paWE9BSWxLKzZYWmF0?=
 =?utf-8?B?a3pzNW9Fd2ttVytnaU9tM1Fab0Q2YWEvWDJORStHR1g5OFNJbkIyUVFxVnJG?=
 =?utf-8?B?V2Nvd1pNR0pSSEtJU3BxYTYzdXgwT2R1enRrcFE1UXpVUFJ6SzcxZXQxNUM2?=
 =?utf-8?Q?ezbkspl3i71d2xvIjT3aStwZt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b48e6ae-e4b0-43d3-887b-08dcf4fb8553
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:47:09.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mm5n6Sj/Xd+JlvUxevpxGnAA6H3h3BkjyF1LtELfr+8W5coIT6ITI17Ib6X5n++a9aAk7AjaDUERDVDZUdajUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995

On 10/25/24 07:09, Borislav Petkov wrote:
> On Wed, Oct 23, 2024 at 01:41:55PM -0500, Tom Lendacky wrote:
>> +/*
>> + * The RMP entry format as returned by the RMPREAD instruction.
>> + */
>> +struct rmpread {
> 
> Hmm, I'm not sure this is better. "rmread" is an instruction but then you have
> a struct called this way too. Strange. :-\
> 
> I think you almost had it already with a little more explanations:
> 
> https://lore.kernel.org/r/20241018111043.GAZxJCM8DK-wEjDJZR@fat_crate.local
> 
> The convention being that the _raw entry is what's in the actual table and
> rmpentry is what RMPREAD returns. I think this is waaay more natural.
> 
> Hmmm.

Just wanted to show you what it looks like. There still is a lot of change
because of the new argument and using a structure now instead of the
direct entry.

I can change back and maybe add some more detail above the struct names if
that suffices.

Thanks,
Tom

> 

