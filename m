Return-Path: <linux-kernel+bounces-173517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F528C0189
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F261F282E1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0868128396;
	Wed,  8 May 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k5I7L9k6"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651712839E;
	Wed,  8 May 2024 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183861; cv=fail; b=uKnrIoXurigMh5OVuKMQrDZvWjc8QXp/R/xvT3UbSPGRJ9BHNPkO2l3X2SR2AOCpSVQA1Xpq/Mr0YpP7pLN0et3HpBFQWKbGI2RNdr1fAyz34Ye34yjD5IQ+Lm1Bn+v5gPVwY1nau5AElpRmqoiW7kTY+waSNVjVj6uzsEUnx7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183861; c=relaxed/simple;
	bh=I3of0QP6+EUxiE3EB/m14x34E7EyBnnHLEwa3PW3QOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MIJq+BONLmYf9dkTtjxOeaJTn4TdFSEhplF/+zfyznsg1YYKpJIR42V0vP6/v//kTAX1UUEfCLPDKyGjV8gZvLDyowPCn+pxNVHnQeIb2o4RvcyxDf3NSJJ7dRVeAUq7YA/oeDANkT1Phm+KSeFx0pmaTyNVC5oneesH/yKF65A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k5I7L9k6; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5AnjH+ledWHgYSfiwEvdnbcktTAkfLgMZE2MPqauyldefKS/LyG+DBWf2rx1H/E5CajNbw+A37z/6tOI2F2NoYdSmNB/dpeqgZ6oUIJrJmBEt95lsy19EHCM0pb/oI91GNucOBl6YJGe/f5QP03ySf7Ji2XS82ZXLejuvNjWZqD0Oo/fzYfspTBagHBf4axskiZfWwuIgI7AYGGTYS8imujsmDF3ARW1Tpa8jcuWB2WdC/G97d+enDUqAt4fYyhOI1wsh/VUkUCUuhneoIM5Z7DP4q+E2vdt3lak54hxt/+8753+y0YqHnHAPy6teoNdvuDjRc8W6ZcZ8A5ekfWug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pXMRHk6i/2YtiPyX8RXcgwyKCt/+gk4Mjm2wIyxr8Y=;
 b=ls3CZydUOTr43SiCsbH2jAF7FNXZZy4lfsgeysISoGlIKgYKOgCfAeGUo4hpV5+JIwBBTkrthB8UI5M3SIwc+3iAlQqF32ZfcnsamoHY1hhwDArkQNI0/OItS41f+eR0UF0l/pfhtf3Oqx+xPQ86v5zpqq/IQwdtHGhAZvfQ28hcb9QRUzmA6rkS3hpgRki2qbsOX0qDkTsUUQ9EdEDP9B9K/GoPdLakNnxukCu9hu9hJQ8IMFgIhMyi8I/RWvCc9EMlJn8wZfD2N+r8JFW5eEbiomg31Lyw2sPMzicLe7nkURZ2Iew9Ni5rrb1nzoM0nVVO5ptICMWG+E5MVwatGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pXMRHk6i/2YtiPyX8RXcgwyKCt/+gk4Mjm2wIyxr8Y=;
 b=k5I7L9k6mMue6/2ls141wcw7Xn4SWhptyIOrs1B2+dWhpkjOGECp6OvWbwZj5+0tee40hiUHGVvNJYYupPDBUWDnIAwsd5tW/t51RL7T5Y6hwwJ6ioRYBDDrjh2t8IH4eIxUjAFJ8iNWLUewTn5ONXhYfWRzJgdzOFw5+kXB/ZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 15:57:37 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 15:57:37 +0000
Message-ID: <7fd1ec49-fd10-4749-acb6-264cd9f4c300@amd.com>
Date: Wed, 8 May 2024 10:57:33 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 11/17] x86/resctrl: Introduce mbm_total_cfg and
 mbm_local_cfg
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <46f83accddba3c25a428d1a30f6091913a4f7c73.1711674410.git.babu.moger@amd.com>
 <5c612f5c-7709-49db-b998-a676b61245e1@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <5c612f5c-7709-49db-b998-a676b61245e1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0131.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::12) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: c25bcea3-902d-45f5-1a08-08dc6f7794dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDlyYjVMMlE1dVNCNHExUWZUbWVTVVFDQXJqbVZKc3BXMzc5U0Q1OUxmMVVy?=
 =?utf-8?B?TjNWYzlnRml5c05SN1JWNG5SQTF6eTJ6Kzk1aVY3WGp1SmpJdmorR0dscXZR?=
 =?utf-8?B?d3V3ME10K2F1Z2VMU2dvSE5zUXAyNWVoeE9uVVIzdDY3dnE5blVqSWVVcTh4?=
 =?utf-8?B?UGs4Tnd3YW1Id2U1YkxEeFJiejN0YWo5T0hUL0kyQkhXOUpvUCtneTNxbzhl?=
 =?utf-8?B?UVE3UHZ3em4zT3R5WlhiWXFwNkcySVVXUytCemlPWEVmQnpDMnB5SStYNThU?=
 =?utf-8?B?Rk5IRUZrd0hWOW1HU0FSeGpGclY2cWNaUFFIcXh3eCtEM2xmMzNpak55d0lX?=
 =?utf-8?B?WmJYYUxCN2lFQllrZ1BBa2VCTzNJMzJzdXpUQjNkTGk0WnpMU28wNzZZZmx5?=
 =?utf-8?B?N2NHbHp1NnJkM01ERmRkVzhkbHpvdUo3eGVpSjVjWHJ0VWZ3WDNMT21iNHg0?=
 =?utf-8?B?S1k5a1c3RitqVElXcndISVhXVjNMVk1pN1Z1TnpyRWZsdTh5SDd5TXlUOUo2?=
 =?utf-8?B?S2k3YUdwZXJvdlZxallFVTN6LzJSTlVGeDRsTUtHTVA2Ym9nWVFJL2hDUVZR?=
 =?utf-8?B?d2VqT280K2N6NndWVlVqTjRSZTVYNEI2K3h2UjY3SmpTVGdDQ0puRS9mYXRw?=
 =?utf-8?B?Uk9VeEpPdmYybVF1RkJxVjFManhMZ2hlUkwyUDBJNHg5c1kwclJvaXM0ejd3?=
 =?utf-8?B?ZmRKK3pDeVlGU2tkdXBBeEpld1NKTDlMZ0JDbHNFT1ZSTVRsTUNmb1FoWEp3?=
 =?utf-8?B?YlVwU08zU3hnSy9vak1pRWEzK2h4SlFPVUVnY1V1QXpoL0RjanZjM3NDQmZT?=
 =?utf-8?B?Yk9aY0dMNDl1cEZ6b2QrSU5RM3ZIMHgwY1ZwbVNvYk5jRitpdjk1OWVXTW0z?=
 =?utf-8?B?OXNXaklvMzAya2txakQ3L0F2Z1RWVWd5L01VZE1xbllsRVFraFQ4a3BodlI2?=
 =?utf-8?B?NGNmdzAzZUhyM2ErYW9UWCsyckhyd3hkUGNjV1BVNE4vWG9sSWRSTlJOQWlD?=
 =?utf-8?B?M0Y5d0s1cHVRMUprZjM3SWQ1c1llUU9HblR1N2FvU0VVdy9VVlpGNnRjVThG?=
 =?utf-8?B?elVEZEF5Y3pyZFIxVWdkL0YzVjc1YkQyQi93Y2xTZ29qbVRQOTZiMEVOcE00?=
 =?utf-8?B?eVJPQ2xLeE91d01WNE9DcmpMWDFEemNwQzBERXNYV1UrelBlZ2NRREsyaDNh?=
 =?utf-8?B?OFRmUmZOTlZ2WmF0WjVkZC9FakVVNXBIMWdVUmUvUmxzMmZQb1Zydnl4NHZC?=
 =?utf-8?B?Q3FZdUNjT3ljR3FreDAwZTRDYnd0dUliWVdWZkJlSWFoZXQrdSt2NjcvczJX?=
 =?utf-8?B?TjRQaEZ1T1oxUWxTNFkvSkFWcHFQYmtzaDZ0V2svU0dhcjk4MEdZNVRLRTJx?=
 =?utf-8?B?ZkRYaGVTSUQ4TU85V0R1dkppckpVTmZlRHRrWXlQaWQvTnh6SG1BSTZTcHBR?=
 =?utf-8?B?aFMrcXdIMEFJaGZxSm11T2M4UTRQdWs1ZUpEaDdWeDl5L1RuZ3dZNnlsSm1T?=
 =?utf-8?B?MlVXNFJNNmVjYXRtRk9ySUpLYXptazVPUG1HSjE3M1QrRzZmTzM5UmlwcWdw?=
 =?utf-8?B?M0JQVmtQUWhORFJnRXBCa2NhOEovL1RZR3dOUXZUbDFJRWJaL09IU0dKZFNj?=
 =?utf-8?B?endNQ2hoSG5SYndOdGltaVYveitpeXoyb1FySzdaSnpEVDVDL2xWK2V0VUFB?=
 =?utf-8?B?bGhIZ2FhQmNJMHdXMDNpRDNtMDBPM0ZMazk3RlEwbWVGWVJqaDBVNWdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDVrUC9EWENHMmdRb2h3dlhyV0F1ZnRqRTR5YUJCdlIxbEtwekJHNE9Hb1RH?=
 =?utf-8?B?dWhUM3ExaDUvVWlXNEhlc01sWjhzd2hMSHVaZkdSa2ZBVG9uZ1YydjdxQ3Jr?=
 =?utf-8?B?VkxNa2Q4UzBET2FJRTFGcWtWelBDMU80RHY5R2dJWk9tc3ZRc0VwNWJaNUQw?=
 =?utf-8?B?cGVuSlJsVnJaWXdwQnl0WU82cGtBYy9mbFgyWjZsdEVGdGJzNXhxRWRyNjN2?=
 =?utf-8?B?Unp4RXNwOGtWVmh2V3hKRWhQUklsbGQraUxVUW5hQ1VVdGhQa3lRbFpqc2VG?=
 =?utf-8?B?TzVyOWpJOGRMTEdwcFNEZnBlK0JGR0dETGJVem1TS2pLMTF4QnJ5V2dIcVg3?=
 =?utf-8?B?YlJlNldyemM4a0pjVGtGa0xQL2FBQ0xQRGVHblhDVjBzSU82UG9nTXNqblJW?=
 =?utf-8?B?VHp1MUJSMmJ0d0VtQk1hT1BnTkhjTFZiVWZXbGp1enZTSkJmZi82RmUzaGVT?=
 =?utf-8?B?TThJOE5mbUpybVRCeThsOERtWUZHS1U0d2dGbTNrbllHY0ZCUi8xUGc0clJa?=
 =?utf-8?B?cmlPMktVZXU2SmtoTHRJdktWSnpzano0ajgvUWhYK2w4bDlLNVBYN3gyZ2hF?=
 =?utf-8?B?UUY2Wkttc2pwbXdDQkF3b0Nmb2NmOFYwUGZuTUtuKzRla3FOcXZocVlqRUMx?=
 =?utf-8?B?OWlWekZ4c29VQS9nZkM2QmhLZGkrakN4RzExZEtEcG4zYWxLNkR4MEZYOGVk?=
 =?utf-8?B?NXdSVkF5ak1QdGNjVFhXOUV2K1lpcjl6SHlZcTRFa1J2clo1K2JxR2tPQjlV?=
 =?utf-8?B?djdzTVJrSm0rQ0dzTnlGRGhpa0pCYWJHUTlqSHZwWTF0NG1UdThMR0k0N3Ri?=
 =?utf-8?B?N3JuenFjeFlwdWRld24zS1ZyNzVTdFVhUWc0V0lzazlhQndIOHFEd3VLMFRw?=
 =?utf-8?B?L1hYUDU1YTJLM3l6aVNOQXVzblZySTl2aWROY0tpNWo0OVBsNktSalJDM3hm?=
 =?utf-8?B?OWVpU0MrN0w1MG80SjQ5YWo0MFhkNi9PdjBLVGExamgwdGxha2psZTJXczN6?=
 =?utf-8?B?YU4rVTAzdTg2QkJiY1krOERSUURpNVlPNGluYUFPM1hFVDFMNDFUZ09tZFdk?=
 =?utf-8?B?ZVBKMGRwQXBPdmtyalh5c0VRK0hLS1JBd2JoWDVWd1V4ZE55UEl0V1JWOGhX?=
 =?utf-8?B?MDZHbmIvRjI5RWZjcDU4QUh3bFdzZ1JuNVNkN0RQRVp6WisxWHhpRHNCVUZj?=
 =?utf-8?B?V0M3VWVheGRGZWRveWhuek9GVE0xc3hqcjVBRG8zSHhMOWpoMHFGRmVCMW5q?=
 =?utf-8?B?WnJyUEhYMGFuMzl3dkF2QXF0bVV3Z0ZNaU1NWUJqVFh0cHF4WERnZnBtcXcy?=
 =?utf-8?B?YndWTndJMm5FZEx0bWxUazh2eTJSRmRsWGZXVmVzVDNZQW8rRmd1ZEtLeTA5?=
 =?utf-8?B?T0lmL1pINFVMUzg1TnAxWm8yaEowa3U2YnFsTUxMandCMTRGdFZHanRHQTRW?=
 =?utf-8?B?bzYwbFAzaTFaZjB4MHpjRzg4cjQzUHNDaGxSVGxGaElLRm1CZWRCcjBac1Jm?=
 =?utf-8?B?N0NleHRob1Z0SmxiVWJWdm9LViszT0pRQzNiUXcvWC9YZHd1ZUZmWVd4d3l4?=
 =?utf-8?B?OUo5blJSUzJQdmhHeVNpSVRvMXU5V0pCNWVpN2hkMmF6QW0zbktnRno5VDBv?=
 =?utf-8?B?QkhEYkZ4SUZBS0k3NmZMNkdhMElMMFFvV3F5TGd2N2VzQlhJUFF1MFM0eGgw?=
 =?utf-8?B?M1M0NE92bkdXSGRxZkN2KzFrdTdTWGpNcmVabk92YWh5N051NVNVZUEvRDIy?=
 =?utf-8?B?Q2NjeWhHcSs1NkpHOXptblhDSnZSTVl0ZXVLeTJKRXpXU2tFOG12aXNLTnJk?=
 =?utf-8?B?Rm94N2ZVbVoyZDJET2U4YzNIWnI2MWdzeTEyZEh0Nk42SUIwenBKN1Ixak1k?=
 =?utf-8?B?U3NFOHVEYktTZW1OM3NNQVZYRFJSNFFVYUZKdzFCa0lxOHJlZFdFdzRWcmNS?=
 =?utf-8?B?NlpxK1pxNm9GdVlqYWhKSUEzZkJBUGNmaGUrTlZFTE9RMGlSYkpEMWs0eFVY?=
 =?utf-8?B?amVJcEN0dmhyYUVqaFJpNTlpL2dWQlpZcVAyalRxaWlMMTN1VG9HY21lOFZw?=
 =?utf-8?B?bUxRT3VkOU9TbnV2bkg2RFROK3NZWFNTWXMvS1hLbTUxdmVxbWhNeVhKWTBV?=
 =?utf-8?Q?VoX8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25bcea3-902d-45f5-1a08-08dc6f7794dc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 15:57:37.0979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxhGZomiTutDD1lnTnWi9FNnES1fJaBOv3kQnn/Y4zum7UZugzf1pX/pvvrfPspk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337

Hi Reinette,

On 5/3/24 18:33, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/28/2024 6:06 PM, Babu Moger wrote:
>> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
>> supported, the bandwidth events can be configured to track specific events.
>> The event configuration is domain specific. ABMC (Assignable Bandwidth
>> Monitoring Counters) feature needs event configuration information to
>> assign RMID to the hardware counter. Currently, this information is not
>> available.
> 
> hmmm ... "Currently, this information is not available." does not sound
> accurate. Perhaps it can be made more specific with something like:
> "Event configurations are not stored in resctrl but instead always
> read from or written to hardware directly when prompted by user space."
> (feel free to improve)

ok. Sure

> 
>>
>> Save the event configuration information in the rdt_hw_domain, so it can
>> be used while for RMID assignment.
> 
> "be used while for RMID assignment" -> "be used for RMID assignment"?

Sure.

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>
>> ---
>> v3: Minor changes related to rebase in mbm_config_write_domain.
>>
>> v2: No changes.
>> ---
>>  arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>>  arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
>>  arch/x86/kernel/cpu/resctrl/monitor.c  | 11 +++++++++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++++++++++++++-
>>  4 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 50e9ec5e547b..ed4f6d49d737 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -555,6 +555,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>>  		return;
>>  	}
>>  
>> +	arch_domain_mbm_evt_config(hw_dom);
>> +
>>  	list_add_tail_rcu(&d->list, add_pos);
>>  
>>  	err = resctrl_online_domain(r, d);
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 41b06d46ea74..88453c86474b 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -385,6 +385,8 @@ struct rdt_hw_domain {
>>  	u32				*ctrl_val;
>>  	struct arch_mbm_state		*arch_mbm_total;
>>  	struct arch_mbm_state		*arch_mbm_local;
>> +	u32				mbm_total_cfg;
>> +	u32                             mbm_local_cfg;
> 
> (please fix tabs/spaces)

Ack.
> 
>>  };
>>  
>>  static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
>> @@ -648,6 +650,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free);
>>  void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>  void __init resctrl_file_fflags_init(const char *config,
>>  				     unsigned long fflags);
>> +void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
>>  void rdt_staged_configs_clear(void);
>>  bool closid_allocated(unsigned int closid);
>>  int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 56dc49021540..8677dbf6de43 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1090,3 +1090,14 @@ void __init intel_rdt_mbm_apply_quirk(void)
>>  	mbm_cf_rmidthreshold = mbm_cf_table[cf_index].rmidthreshold;
>>  	mbm_cf = mbm_cf_table[cf_index].cf;
>>  }
>> +
>> +void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom)
>> +{
>> +	if (mbm_total_event.configurable)
>> +		hw_dom->mbm_total_cfg = MAX_EVT_CONFIG_BITS;
>> +
>> +	if (mbm_local_event.configurable)
>> +		hw_dom->mbm_local_cfg = READS_TO_LOCAL_MEM |
>> +					NON_TEMP_WRITE_TO_LOCAL_MEM |
>> +					READS_TO_LOCAL_S_MEM;
>> +}
> 
> Shouldn't the defaults be discovered from hardware?

Yes. That is correct. We can read from the hardware.

-- 
Thanks
Babu Moger

