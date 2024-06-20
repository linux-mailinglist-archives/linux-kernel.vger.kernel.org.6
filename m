Return-Path: <linux-kernel+bounces-222876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A3091090C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F26E1F24C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021E01AF693;
	Thu, 20 Jun 2024 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X5h+trBr"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539791AE87C;
	Thu, 20 Jun 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895214; cv=fail; b=tfC0mNOxgBO7gysb0oEWYpnVqMTizxNuKqdfoyxFaXdn9p6cIkZG+8ynneTp6yqcmB1W5P30yytFQpy4pi8TnTlOacbSaVi/RfQyh78w2tUK+FuhYiq1E/vqRwZp3kh65rc7VsNYWjRLh1D25rHssGHLu1LClrqAnxuIXQy4aek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895214; c=relaxed/simple;
	bh=CCwUDzCz88MdI1B/HQCU7xeoPVCef8FnUc+/x9dyJcE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SfasL6iOe0jT68XgSTk3erK0LCFwq8Bfxmqy3CP7uuXnYijwzZEbA9dXVQ3sYnMTCVhdPpopBHwGDTQNh32ircWU1NGyiKv/dOwB9sKKcj0401nIpcjGJMbBTNjZWrZaO/YrX++5Yu2AJLucFqSslSUH6Jid5msgA4tauFgHmAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X5h+trBr; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQU5VOmh3IcnhbpnaEC79s8BzBs4l1rcG/2G3hy9uTC4IzbjKmdqAqpm3Ac/DHxc6NPM7cYjbxuq1tsPmEbIp8PICVC0AfYFehnP04LP0c1n+waMs5cH2oljmoGJKDnw9J7dN1xMod6EcNEFoWsANRWok6H3jqeURTWNeKoFvWn1cdrHCqPuG43kKqsGN8UpZdSyhBZMsJgVIPWgb/ndRmCC1NqwKeQYNoY3sapLr8k6xrb7Jca1GI/+p5UppXi+OXQzCXUfw/jnIst5Su4I9cqtZUAL3IQEm3ctivAPp2lpsNcMto4TQwLJFzSxdQCs7n2mNbb4rdq3L/TJ9i1ttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsRttjABYdiYc5+vE1UFX/9IJYzpCJnr54EeWGpCNGk=;
 b=SFyY+OirfJoGgX6JbUm3MJgHjIS69rOZM/QAGN+CmvAh6ivBCsV71SR1sNJjYk6x0aJozVI6/AufsGO6to7Tt4ooa70dHT9cXLcDnJSlr0mwoF8wbNLnzB9BtSXEpeRaBqHh0UVCqmnu7MUTMLXYOvobskLV40XyY3++dmE8JO2zVWeB2r8/ImCTHnjJPraO+Zas2GlqrPRujYr6wBKsUa+YqV95ZEJqMqLWSpMhTY/wKbfSEpuibP/Stl4zGLgQntSQIF7yFj3dN1diDg2G8/yiFD40YyZO6nRicgJf7CCii5dldMSWSduKvIRMC+gMzqnK/MOt36Akgh9NFbDwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsRttjABYdiYc5+vE1UFX/9IJYzpCJnr54EeWGpCNGk=;
 b=X5h+trBr+h9f4F32b4w+o64JF5KlJ6tNx+JvAq2R2aaLtv0YR0Q+m3EkhZBYyt1SCP+j56AHkinjBXE1BPY+66G8k8M5q0COsOAgSBH9a2663libU2BmH53HFpwrwyks8CUPkBlF6XFol7tqqJq7QS9EA1YDIDj47Ntep4pSpeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 20 Jun
 2024 14:53:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 14:53:30 +0000
Message-ID: <48c20213-ad25-4717-a7e3-6e5ebd6a2713@amd.com>
Date: Thu, 20 Jun 2024 09:53:26 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 17/19] x86/resctrl: Introduce the interface switch
 between ABMC and mbm_legacy
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1716552602.git.babu.moger@amd.com>
 <0148e3317b0de3b5d1eaa58af37a2910783a69c9.1716552602.git.babu.moger@amd.com>
 <9141ea08-5109-4c61-880b-a5136405878e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9141ea08-5109-4c61-880b-a5136405878e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:806:130::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: f41d5eaf-a68e-4604-2890-08dc9138bfe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnEzSDNnb1phRWZCQTd2UmxsNHQ2cEN2aW5ORHUrcy9iVnFFWlJCYXhTWWIz?=
 =?utf-8?B?a1JRaUgwcjBPZ3EwUGVoUEU3MmdlZGVzUGQwQ2NydWZaRE9oanVTVFpLYURr?=
 =?utf-8?B?K1lwSUpjME01cGVlSWZPTFlnekRtMkMyRmduWFdoeTJWMmlrVUQwZkw5R0ln?=
 =?utf-8?B?aWNVUTBCbDFLbWpRbE9NZDEyWGJjZnlPcjl6ZmR0VTk1T05EY2ZyMEdwOThW?=
 =?utf-8?B?WTV6dFdacE5ka2trRUMzaURWOWNxWlhIMWJjWE5GcS9kT3UvZmNLd1dIQllF?=
 =?utf-8?B?K3VTT3dOOFgxMDhmdkh5T2RObmVRZm04ZkVXSDYvcnVaalhPR0NQWkRyb0NF?=
 =?utf-8?B?Ynd6TE1kcEtoSFNaTFVNSzl5a3J4aHhyWFdFZmFsUEhYb1FTYzJ6ckFoVzJR?=
 =?utf-8?B?RFBVejdnSGowU1FPeDBnenpLS3dxQmdTcHloMTBNcW1OV0FFcHBQeHVvajNi?=
 =?utf-8?B?ZkRma3I2QmhiSkQ1M29wb3NweEl3cjdZMnluUjJwS3hVN0NoWTg1R0RlenBZ?=
 =?utf-8?B?V1oyWEFKQytBRmc1cUJFRUh1ZUtrRmdVamxVWFFVQ2dQUEpSeDFvV2RvbDVi?=
 =?utf-8?B?M3M0QjduQXV2VG85VEcwekM0czlnZGR1QTh0SWlpUnBKSS9tL2pnNlFDTGR6?=
 =?utf-8?B?aDA3ZFpCd0hKRUtmTFVHMEl6TTBsa0c2WXZPa3dHL004WGNiNmNLQkpha2VR?=
 =?utf-8?B?a3VnV0pHNFRBTm5qZXhZam9XbCtBdUpucGpSMXE5OHMzVWVQcDFYQkRNZS9T?=
 =?utf-8?B?dkVyZ0FydVhuaUZQNmh1cUYyWktkSUVZbnRRdEUrSWE4TzhlWk1CeUNISG5R?=
 =?utf-8?B?OHF5Yk96Qlc4MWxVblNodkFoTzFjbG4wNHkwMFhoRUZuK1JTOGdzeWF5ZDdn?=
 =?utf-8?B?UFZEeGo2UzJkVXJaS0F3Z0tYZHk1ZkxJRnJGaUtJVlVVSFFmUEx4ajAxSk5n?=
 =?utf-8?B?WkpKenptLzh4M0tmWC9mMlNIQUJvQW5acjlhc3ZyVXdZWmZ5UFFGYWdyK0Z5?=
 =?utf-8?B?K2pFQ2RnemFZeVBqZXc1ZUh3RlkyeW0vcDRxZ1J5VmpPODBPOHA1WTAva09G?=
 =?utf-8?B?cG9ZVElBeFJqZGJDQmhmWGJwQ045MElZVjRxcjduUjhTSko3RlcwVWVZb3lS?=
 =?utf-8?B?NHRxeko0TGdCN1VGU1FkZExXcjhkamNLWUxjMlVZbTBEUkFWUkpFMldnd29i?=
 =?utf-8?B?OHZLczBRSGtoYlc4UmszczA4aElWY3FGaWVRZzhBaDgrQW9zREFkSkd5Vlpj?=
 =?utf-8?B?UlFqd3JDL3IrR3hXdFpud2hMNjJHZUxzVHIwM09XWFRmRmRzUGNNSWQzQ2Jw?=
 =?utf-8?B?cWZWbU1UZjRHQ0N6QmFqVG1xS1kva1hCa0swS292RGRwcVdtRjlxTnlOdi9K?=
 =?utf-8?B?SWZFcWpiOVF2cWtsMjJ2Y2R5U1NlQ1ArMUd1N25pODhzaFEzeDUxa25ic2J2?=
 =?utf-8?B?US9McUlZZTRUZVRhTms0QlhhOGV4SUozL1NZaEYwWHg0TlFIblE1bzVMbk0y?=
 =?utf-8?B?Z2NSVm5BSHlsT01rbHZsRUpFNC9tc0pmd2tTcTRVYjlsa0xHNU1kakx0VEZX?=
 =?utf-8?B?Z2ZNT0grY2szNS9qM3o1a0ZQQTZDVEhMMnBEWTFZcHMvOUJ1eVplcGRVdkNm?=
 =?utf-8?B?ZjlOTmZLcXliL3lDRTBJazhnb01wc0toMGVIVHJHazVzbzVyOE1WUktDZWl3?=
 =?utf-8?B?L1VUemJkRG92N2lOa3V4WkExUS9VdWFpTjk2NUswREd6RmlTeW1NdHdOUWR6?=
 =?utf-8?Q?iYxjzjUZHIvvTZJqrrNdyTnPT2qFpQY3JmxHVeU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NENpZTFBUmlZdW8vWTJKZ1BUbHZmUVc2ODB5QisxWkdhckNWZ2piaGlWZTFo?=
 =?utf-8?B?UDJaUGQ4NEV2QlRlZUYxSjNCNkpML0FJdkdISTFVYjVJMGp0cHFzZGVBam1n?=
 =?utf-8?B?RjJjL25uLzBlTGtVamUvWmlLdnMvTmxmVUFNSFlvVlc5MFFTVngrdlpnNzVO?=
 =?utf-8?B?MmI0enNkV3lQRGRUMmh3VnFUZmFhZHR2UURqWjVSREt6ZWhzSXB5Zm54N0xB?=
 =?utf-8?B?WDR1dVA0cDdVeFF2aWJxbmx6RWlCYVB1bFc0RnlNQlNNTVU3bWJieUxwMWFm?=
 =?utf-8?B?a2s3ZmJhNWhZUVpqSG9iRHgyR1Z1RFhTUzNLd2J1Vjh0N3MyRm1UaEFveTlp?=
 =?utf-8?B?THF4elpiMTl3UmhrNENNSXBRbVBFcVZ1TmtkM040MFk2ZDBsTUVwYWpVb0gz?=
 =?utf-8?B?V25Vc2R2dWRlT0lYTG1yVmcwNXNPcXNJKzdBN3F6TnpQclVnZHIwci9BSnhj?=
 =?utf-8?B?YVI4VzFhV2t6c3lKTGpZTVYxNUxCWXJ2eDhmZHdKcGtYbmEvbHkraS8veFpZ?=
 =?utf-8?B?RmtmcC9uN0ljRi8rbmtMakVRMmRrcWFrUnBYaWVMaVZSVDBZK0l2a0ZGSE0z?=
 =?utf-8?B?UU0yTnhWMjlhYzBOUVNtblhWRVNrN05EUWJCZmpuQS8xd0JKSWl1WERqcThZ?=
 =?utf-8?B?RyswcGJlaHdidW5DTUppN2FZMFRaZnllVnRBVENXMjZ5QmJxdjNpdjdkNGox?=
 =?utf-8?B?b0hIbWkzMEs4VXJXNVBaeGRIazhhQjFOdXdtZWV0b09SUzZqaE43eFZ1ZFN0?=
 =?utf-8?B?dytFSERtZW5hWkV3NENCM0xGeTRsQWRJTUdGaGxTT0ZaSUVudG1wSXAxbGJG?=
 =?utf-8?B?dzAzM3MzTml6TU5vRlhZaUNkbTVlRjd2aWFHSjluelRhajJsSVl5Tm1PQWJS?=
 =?utf-8?B?dTlaaHZaOVpwSWFVWWsrUGtBbEZ2YnVJRThxbWtpcllMd3lYMjhCQmJOUW44?=
 =?utf-8?B?NDFxdFZQODZ5dytBcUlDVTdVOE5zc1Z6KytVelNwdHlwTUorcDZjU3dFU1Fi?=
 =?utf-8?B?TzRMcnVMZXp3RzROWURIWWhXMmJCanRrR2MvaWxGVGpKNzlrb0FGemYzbjZy?=
 =?utf-8?B?MHd1V2IwY2JkOXlmT3haUkdpOGV5MTVWRzRBTVVrQ05HdXZrQVRjSnk0NXVz?=
 =?utf-8?B?Y1l2dHAzVUlNWEo3TGhZbHR5dEF1ZWVlSFpzYndpaWhmSnozL3NsTmNMdzhD?=
 =?utf-8?B?djhoZUtUMUdQTzBZNWJkMEY5RFlDa1BWMjJHY21SeTlvb0p2aFNOOWxZLzdz?=
 =?utf-8?B?eGxoNkFuQjBBYmVSMUxSTjBZUkVnMklROVBCNTR1UXlrNlkza1l4anF6a0lI?=
 =?utf-8?B?SmZuMzMvREthcDI2eFR1ZTZoUFhLUjIzeXI0K2tvSk9LbFpuRkF0SWlYUTFL?=
 =?utf-8?B?RWR4aXNhYzN2VHVyQ0g4emRNOHBGMkVlVXdQSENuODBUd3pXWVB6Y2lOOXUw?=
 =?utf-8?B?cXlaMk9JVkxCQnlUSCtDY1ZuY0ZpMUJwZzhnTXh1SEJNSFhGcFI1VW12dXBa?=
 =?utf-8?B?K3VDalkrT2FzS3Qyek0raldvT3pMaVBkd3JZUzRWR2lLdFdGM3dnbTJzQ09M?=
 =?utf-8?B?azU1eklIV281SFhWQWtlOXhuazVjYWJnRnRYUXZBZHFybDhpcEl4RjJtVUhj?=
 =?utf-8?B?N2duSDZQeXR5SHMzRlVUQTBTNlB6U3ZURFBCOGs2VC9NN3NkbHdRb2Q5WkF1?=
 =?utf-8?B?bkVIam92R2lCVE1NR2ZKc2VKMWtJK2w1T3dxNEFESjNYOVJ5NGNIZ0ZyWm84?=
 =?utf-8?B?OXNBWWZDck5mSDFXakpvdkQ5blhnSmI5QmZaTWhqMkpMV3M1SVhZZFhaSDNh?=
 =?utf-8?B?QlJjbUc3UW44SWdYV2R5Y3J0R2J0WjkwOUszRUhyMnRMQXFhb0F4aEdsRGJO?=
 =?utf-8?B?MXZEN1p4UllVNkRXWFBOeWdSclh4ejhDN1NON0xzRE9ndlZicUVDTGlhOVdp?=
 =?utf-8?B?TTFvMnVmNVpjdGdEMkpBTlZtVjhGR0dQNGFFdzlmUW9obXhzQTJHQUhHNWJt?=
 =?utf-8?B?Rng0UVhCWGxwMG1ib3NOSTFHTmxQaTZDZFNjYnIwamxpMlQrWDkzKzYrQU5Y?=
 =?utf-8?B?ekxtaE5ZTHR4ZDJFQWpndlQ2UitHd1grRWhSU1VzT1VvWHVoZGhDUXl0MmhZ?=
 =?utf-8?Q?GVfw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41d5eaf-a68e-4604-2890-08dc9138bfe0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 14:53:30.5348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKVL/SPGAotvssGkQzVsmVDDWPpZzURnKRjbwlpY8/ltZM56ER77NqKSjkgwnc7S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235

Hi Reinette,

On 6/13/24 20:51, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/24/24 5:23 AM, Babu Moger wrote:
>> Introduce interface to switch between ABMC and legacy_mbm modes.
> 
> shortlog and first sentence of changelog do not match: mbm_legacy vs
> legacy_mbm?

Will correct it.

> 
>>
>> By default ABMC is enabled on resctrl mount if the feature is available.
>> However, user will have the option to go back to legacy_mbm if required.
>>
>> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>> [abmc]
>> mbm_legacy
>>
>> To enable the legacy monitoring feature:
>> $ echo  "mbm_legacy" > /sys/fs/resctrl/info/L3_MON/mbm_assign
> 
> Missing information about user visible impact to counters/events
> and any mitigations needed in implementation.

Sure. Will add the details.

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v4: Minor commit text changes. Keep the default to ABMC when supported.
>>
>> v3: New patch to address the review comments from upstream.
>> ---
>>   Documentation/arch/x86/resctrl.rst     | 10 +++++++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 40 +++++++++++++++++++++++++-
>>   2 files changed, 49 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst
>> b/Documentation/arch/x86/resctrl.rst
>> index ab3cde61a124..fd050d4d22cd 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -271,6 +271,16 @@ with the following files:
>>         [abmc]
>>         mbm_legacy
>>   +    * To enable ABMC feature:
>> +      ::
>> +
>> +        # echo  "abmc" > /sys/fs/resctrl/info/L3_MON/mbm_assign
>> +
>> +    * To enable the legacy monitoring feature:
>> +      ::
>> +
>> +        # echo  "mbm_legacy" > /sys/fs/resctrl/info/L3_MON/mbm_assign
>> +
> 
> No information about what the features are or what will happen on such a
> switch.

Ok. Sure.  Will add more documentation.

> 
>>   "max_threshold_occupancy":
>>           Read/write file provides the largest value (in
>>           bytes) at which a previously used LLC_occupancy
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index f452b6d9bb99..d77ff059269a 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -908,6 +908,43 @@ static int rdtgroup_mbm_assign_show(struct
>> kernfs_open_file *of,
>>       return 0;
>>   }
>>   +/*
>> + * rdtgroup_mode_write - Modify the resource group's mode
> 
> Comment does not match function name. Seems like "mode" is the generic term
> to use instead of "assign".

Sure. Will fix.

> 
>> + */
>> +static ssize_t rdtgroup_mbm_assign_write(struct kernfs_open_file *of,
>> +                     char *buf, size_t nbytes,
>> +                     loff_t off)
>> +{
>> +    struct rdt_resource *r = of->kn->parent->priv;
>> +    int ret = 0;
>> +
>> +    if (!r->abmc_capable)
>> +        return -EINVAL;
>> +
>> +    /* Valid input requires a trailing newline */
>> +    if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +        return -EINVAL;
>> +
>> +    buf[nbytes - 1] = '\0';
>> +
>> +    cpus_read_lock();
>> +    mutex_lock(&rdtgroup_mutex);
>> +
>> +    rdt_last_cmd_clear();
>> +
>> +    if (!strcmp(buf, "mbm_legacy"))
>> +        resctrl_abmc_disable(RDT_RESOURCE_L3);
>> +    else if (!strcmp(buf, "abmc"))
>> +        ret = resctrl_abmc_enable(RDT_RESOURCE_L3);
>> +    else
>> +        ret = -EINVAL;
>> +
>> +    mutex_unlock(&rdtgroup_mutex);
>> +    cpus_read_unlock();
>> +
>> +    return ret ?: nbytes;
>> +}
>> +
>>   #ifdef CONFIG_PROC_CPU_RESCTRL
>>     /*
>> @@ -2087,9 +2124,10 @@ static struct rftype res_common_files[] = {
>>       },
>>       {
>>           .name        = "mbm_assign",
>> -        .mode        = 0444,
>> +        .mode        = 0644,
>>           .kf_ops        = &rdtgroup_kf_single_ops,
>>           .seq_show    = rdtgroup_mbm_assign_show,
>> +        .write        = rdtgroup_mbm_assign_write,
>>       },
>>       {
>>           .name        = "cpus",
> 
> 
> Reinette
> 

-- 
Thanks
Babu Moger

