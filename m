Return-Path: <linux-kernel+bounces-294314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC4F958C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB231C21C94
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0049191477;
	Tue, 20 Aug 2024 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g/LzdO5y"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29546B91;
	Tue, 20 Aug 2024 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170775; cv=fail; b=Bhrile8ABPcsI9n1IpeqpjjEy8YCfXgX7FwRPKGwFyGEhyjxAJ6hr8THSjFKmkSV9WDR/5x6r37iOPGGhZj9FSHSKpwSLzqM3qoEz5DdVOY2zjlDWHYsnWTgTBNhM6yVu756rnGI6Db4ThQNYTZKvV5nrB2sppHpWbkK1wj70Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170775; c=relaxed/simple;
	bh=0OifyjJQ4yQVZmzXgvIQfk0OrtGFV96HJBN5AoVs4sQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uINhONcKdbPU2lHyOgciXbCCNtt3X8bEh4vHa1/T/5vQQhHhO3cQpB/vpejUDpTwMusTKT4Mwt6szdWyJ/ekjHfVYGJZnzUzCqDw3G+VMkJhRd1u9vatBN2Qo4V52eZbKIj2diHBLxDuvwrBZ8ucceG3UxkaL5hsJeUYpicXLpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g/LzdO5y; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqZN0fLsZQlGgD0HhsrEPaBdbXHEKXk2iHSIMP6p6gwtbbvg4EGM2thuIMiA7oTb2LT5kG7yx9frGu0EqbrDYI50PmYaADTeyWzJ9i+wo/xtoDdXWeWDwAx+1DYsGvH1xtCyIzKHlxX5lMy5egISgpKPl6CEgi8NhZIlG4LlI5LEkkKdxcw8kx35tZD8A3y7aypffA3hANfXZoL/bvbiVQd43W4kIa2jBeaoo8e6xJeJBMWH3EU0LQlu1yRFwcmp3EPIMjkRHvDxTPORJjVLugyg1384Q9sgrJ5jrR7b0r4jjefOeVyTkcuRqFwgAq3uMHFymoV+2oRi3+vaZ2rtfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk4qRJqAF6gjd1bH3wRz9USI0r/umVxmvLJJ/EC1vyw=;
 b=zNeCUY4z5r3b5aVfzps3A+QTt1lEoxzmuoUFBg4Ow5C8DgrBwx1M1+1jHu0fPVtdvGd6WHAT4dsCA3GwqeKbFVrk3T1wsbyVnH+yeEsx5WqzojUxatCkl7/SD5rFaa58OE6nxWiv8GLfmNQ0utTOZcBmu20rRkD+RVHZalRLPqXJoW6Hx+0282+jptMCOZLuTHruMGdXLnLotKSxBL+/U4VrIkIc0Xh4S/pzzQJyFhbKzW7naqv2CS8R1MeGSFucH49jh7a4ERcXmXzvplDmkbHqwkOoTDqDr7pWZiwXVLv/FCrA0RDug0IRISPl88jDacBEzsMCrxgX388h86hvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk4qRJqAF6gjd1bH3wRz9USI0r/umVxmvLJJ/EC1vyw=;
 b=g/LzdO5y+7tCqHSYlse+zJsC0fvMcceKlC8LKnA8xR2FNjJBzWSy2pUC0tcG1raYpWp9mv3/uGWpNnc55hL0AAPIff3jZsnOEJOyxX+UqRdZ3jRBw3qA3NMxuRTKtLMjKk7SC4Sdnwae4D8sXUZZzm8qro5XHR1qCZ/UbZNLDgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 16:19:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 16:19:28 +0000
Message-ID: <654d1c0f-47e9-4bbe-8b7e-404dc1c746ee@amd.com>
Date: Tue, 20 Aug 2024 11:19:23 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 11/22] x86/resctrl: Remove MSR reading of event
 configuration value
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <ce8ca46651c5488dff19ed59ba7c50009c90ac67.1722981659.git.babu.moger@amd.com>
 <57c27158-13ca-4f79-9ff5-58033e3e3b9a@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <57c27158-13ca-4f79-9ff5-58033e3e3b9a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:332::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af2dea3-3aa9-4898-9299-08dcc133dd7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmFqcUVkSGY4enJWR09QdjdKQzcxUVlLNjR6c2xFUVN4ZThUYkg2L1FueGU4?=
 =?utf-8?B?ZmltNSs5bXhLekx5dlhGdGhuOU92UjNpcXY4NlB5QVlTRlpNUGIwMEdiOE5v?=
 =?utf-8?B?c01LTU5VdFZoUFovUnV1d2xsVjFvc1FySUxVM1JVWE1sOUJIaTBEV1Nqc3Nt?=
 =?utf-8?B?MTJ0c04xd1d6YmFMZmF4aFUxUjZNdG5XM1FDN3ZzSFNUY2tDbE54WEQzYitV?=
 =?utf-8?B?bkRhemNqK0pjL2lLczdTZzh3d3VBNmdKeWJjSXNRcGRxazNsK2lMeFJLb2N1?=
 =?utf-8?B?bC90dkNVZHlzbHZKaFVJSDRHb013S2RxYXp2TEpsM2FRNmI3ZDh2NDRiR0dr?=
 =?utf-8?B?aUpTcnlYRkF0RjNDNm9UL2I5RjZ4YWRvMTJOV2xjTlZlNXUyRlBiSFkzSlVW?=
 =?utf-8?B?bG9LR3FKcGxOMitNV0dJMnpMdHNWUW9BU2dUdWUwVUw4bzFFdkhJZFdDUGJW?=
 =?utf-8?B?WUJZYStVaklDMGNvVFJ2NTZKVjBwZWZEbHhrT0FXbkdjYy9lOGhpR1BQNXhZ?=
 =?utf-8?B?WUVkNERWMy95UEJmbWdoUUtCY3pldXZQYVg5czBYbFI1Qy82UDJuYTRNcUJt?=
 =?utf-8?B?S0xQeHJqMGhodytuNmNyMUtNYnZzeUhHMnFqaG82cndCb3BBQytJY1VPZDZY?=
 =?utf-8?B?YUlNTWxoTTJ0eU9RbjlCOW0vMXBCaFV1WERWSVJpdEM4Y1VxSk1sNUpMREJv?=
 =?utf-8?B?ay9VdDFpcDJ5K01oKzN5S1NoSzQrWlJibE14K1FQMGtTSEVFcW5UKzRnYTNO?=
 =?utf-8?B?OUp0SFFUR2lLa1pzWXRnRVVxcUV3eEl1QTB3Ync5RzhRWEhRb0ZUOWNaNmx4?=
 =?utf-8?B?QzNLeHBsSFU3OEZTNVJEbFR2cnFFbENCaDgyR2tkbUtWbVV2RUlycE5Lb3Ay?=
 =?utf-8?B?em10aDJJbmxGQklKM3ZmS2FxZkdyc3VkN21RK3REYTZJRzZFMnlwZitaM3F5?=
 =?utf-8?B?V2ZTR1Iyc3cxdldkOHQvdXZYSVR4b3NOVnVOR051d3Z4K1ladnh5UnIwM3lK?=
 =?utf-8?B?UDBJVnNqYzFxY0RUMjZDaU9KM0tmYllYSHNQdHg1R0lEeXlNMTdYaFJtckk4?=
 =?utf-8?B?V3VVOUdwZUFUQjlJRUlTczZZd2t6dDhsYUJpblFSNzJGazBwQUp1bk1kYkd5?=
 =?utf-8?B?QjdqTHo3K24xYWZ0a1ZnR0hnbkNrNjZhQ3p2RGs2cUR6U3N2K0RDY0lsZWhk?=
 =?utf-8?B?dWlweGV4V0ZpYnZRYm96ZUZEMnZNS3hKVzNzb1VCNy95ajVUdEN1Qjc5ZFJk?=
 =?utf-8?B?RlM2ZzZPbFh1bDdpSnVEanYrNWVjdXVhdE9Hdk1oUEMrMUJNL3Zpbk1zMFNN?=
 =?utf-8?B?TStlT09wMDVsZGsvcVhQcGozeW9zRk9za1I1T2E0NmQ4dGxpM3B0Rm05UGhk?=
 =?utf-8?B?anpNU1kxdG5DMXkzV05xdDJJOUlodDduZm42U1U5QUswR1BrNm42NTk5Ujh6?=
 =?utf-8?B?S2UxUm5nb2tweW82d09yZko0TDV0ZjduZzNPbDlxdWxzU01rQTBUd1FNNURz?=
 =?utf-8?B?eXY1K3VyRVh1TnN1UkJYSHV1Yms3RHUyWUxVTTRmd291aUhMeXZFclJYK2Fx?=
 =?utf-8?B?dktTWTIwYkRVaEpsMXB2bVI4MWREQ3JjRFlaWUtRUlJpWEZrQ21VbEpwdmQw?=
 =?utf-8?B?cWRNaG1QNDdvdDZ1MHlnMitXMWp2eFlMVmF5Zk5QZzU0R0dUNmRIRldVZHow?=
 =?utf-8?B?ZjlJV3dGQy9Zblp4MEQrYUFyWko5d051MGcwVE5CRmtVaWVHSDhvVkxvLzUz?=
 =?utf-8?Q?K3qKwFRf5gva1JGnDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVZwNlBTa0VwdUxkVStTM3doODM5cTJhbTRMTzFndFVxTWxwanU3aUxhS2hT?=
 =?utf-8?B?emRBUmlhcFpaUnVXTW03TkFVRGVkYW52cnlyQWs1S2swd3o5eGxKQlg2VDNx?=
 =?utf-8?B?VHU0V3N1TUIvSmJlaGdNY0ZuSGRZMExITGh0dUcvSFFFTHZHOUFtSVhVVGsz?=
 =?utf-8?B?NTg5QlJZUkdzdWt6V0VONnlxRVdrdDZOdW1mUDZlNThDK0U0NkgwOTF4WlFl?=
 =?utf-8?B?d2c3eld0eFZ1SFRiQ2FtN3FVNmVKNGJUSFN5M0ZVS1lqRm1ZYjhMcjJ4Ykx5?=
 =?utf-8?B?dnBBdmZyb1p4L1hGdTVQQlRJaWpHZ1p3Y2ozNVhpNUZ6c2ZteGdNMG1BMitE?=
 =?utf-8?B?OW42MFpNM2lra3hGVzJWLyt4MElWQ1FHQXdIMUppbXFIZlJlTGJYWnRmWklp?=
 =?utf-8?B?ejVJNjhVZXpoOENtUDRRR0l6dFNwRHphSEZmZzRTcXdHa2pFdVdGekRQV0ZQ?=
 =?utf-8?B?dXF3RnROMFFPM2JDSXdOQWxVZmJTdmhheWIwVkRFUEN0M2EwbzRRNDNZcncz?=
 =?utf-8?B?NGduOFNYSndPbVNGTFFBR1h4WVBnd081NDBKZ3NPYzFKK3pUREtoRVhKd3dN?=
 =?utf-8?B?Ykx6MS9PZGg0YklFTUpjZzdGQ3BacXpMVzUwdjd3cVdzam1yUmx2eElIV1Ja?=
 =?utf-8?B?MHJPNXFxQkQzRU50TGp5R0t6M3JpTXdrM21VVFd0bDEyOWpqWXpBcjZ0R3Q2?=
 =?utf-8?B?cFJka01NMVplM1RQeFhZeG9OeVJvS2Rhd09yUmFMM0YwOExYbFpaUXJ1QS9O?=
 =?utf-8?B?cnhnVExsOXRlQjR0U2RBdGl2K2hDM09wT3pMcy93Zmg3WWFOcmkwaXBndUlP?=
 =?utf-8?B?bmt1RzFyK0Z1VE8vaVlOQmo4MWE5U3duTDBOUWJIWVYwRk5QMGlLNThUWW1W?=
 =?utf-8?B?bDU0U0ZmTWEzbThSMVo1UjhFNmpOUnZqclFrTFgwNnpjRTc1ekFpSXdMWUZp?=
 =?utf-8?B?SDBnZHFXeitIV0E1dlozRDRHaGNpbkNDVHJUeHhNaVE2K2JwOWxINDZ0MHVP?=
 =?utf-8?B?VkpyRm1EYVFsNTFVQkxsejljY3d4YmdSRFl1S2xkWDRESnBTN1JKbFdyYWRG?=
 =?utf-8?B?ZVhVbEdDWExOK2FLamhzS1NvU1g4ZWtVamZZbm9sckFEQ3JtQVVuLzR2VHAy?=
 =?utf-8?B?bllYOWVGcGYrVmxqNWIrbTR2bHdFbkFvS1NkN1pQMVB0VCtrc2VHblhHUzBx?=
 =?utf-8?B?TWFKdjlpQUFkbXJDRnFkMFJZL1ZEQWpvSmE5Q3U3M2ZOMDdxUms1SyswdlpS?=
 =?utf-8?B?dzRLaDlsaUlKVytEV2MxNWl3anFoQVR0NHFJTGplbGJJbS95WXNxN2dyeG1w?=
 =?utf-8?B?THZocDg1eER0YnRLem5hUmZCMXo4Z25LSllYd0xpejg3VmI5YldDWmRLNEU2?=
 =?utf-8?B?WEVRbzZCU01IYVUvVXV1ZDA1eWZDWmVXOHNDQ21nUUpxeEY4eHpKamhmNkhn?=
 =?utf-8?B?ZElVWnA3MERPOGVQNVo1VklWREpPSU1VK3YwYXE0Y3VhS3Y4eS9Wblk4V1px?=
 =?utf-8?B?Zk12dTVCVmVKUzB4SXp1T2g0UlkyMVdmT040YUY4RGloODZ6ZUhDOFM4UVh0?=
 =?utf-8?B?ekhRNk9uRnJVa0VTMGNrMEFXTlZnakNQMjhQdm9wQnJuZDBiV1NuMzN6MVhw?=
 =?utf-8?B?UU9LbCs0SGNNendUSlpIS0t4Q3NheUFtMVF6UkhnR3FvOW5Zakd3OWdYeEcz?=
 =?utf-8?B?SE52Qk4velFiN0FGbSsxaEZjQ0VleGd1TEpRV1NKd2phVTFpcUlsQVJOU3hY?=
 =?utf-8?B?U1A4cWJqOTNtVjBLanpzeDQ5a1g5T1JjaGJyblFzL0s3WjNtbERHZldobUxF?=
 =?utf-8?B?RkhxTXZsN1QxYlVLM1A3SHRkRTFvY1c5bDBYVzhIS3owZnA3RzZTa0RmT3Y1?=
 =?utf-8?B?OHZQUzM0LzNwSk1NNzJSZE4vVXNoRzN1MEx6S0hvR3M3QlgzZ3h6VllWMzJ4?=
 =?utf-8?B?N0JvaXd5c3VNSWczK0IwOWhlc045SmlMaUxuQ3k2cG5BU3I1UmJ0WjZzbnBG?=
 =?utf-8?B?dmRZTEZ0WW54WmptUTBFNWl4TU1zbzdINUpsWXR0MVhCSDhzTEU5d0xVcjZE?=
 =?utf-8?B?TzludVVLOWlZZTF5RDZoZ0VKMDI0WWd3NWFHUWdQSlZpRER3aVpESkxnVFpq?=
 =?utf-8?Q?38G8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af2dea3-3aa9-4898-9299-08dcc133dd7f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 16:19:28.4907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABZk84S1DT+juv9chwZZkxHlv5HdV8yoPUxv/AMKjImIfuAM3zDBnAPftWzcU+Ql
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307

Hi Reinette,


On 8/16/24 16:36, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> The event configuration is domain specific and initialized during domain
>> initialization. The values is stored in rdt_hw_mon_domain.
> 
> "The values is stored in rdt_hw_mon_domain." -> "The values are stored
> in struct rdt_hw_mon_domain."

Sure.

> 
>>
>> It is not required to read the configuration register every time user asks
>> for it. Use the value stored in rdt_hw_mon_domain instead.
> 
> "rdt_hw_mon_domain" -> "struct rdt_hw_mon_domain"

Sure.
> 
>>
>> Introduce resctrl_arch_event_config_get() and
>> resctrl_arch_event_config_set() to get/set architecture domain specific
>> mbm_total_cfg/mbm_local_cfg values. Also, remove unused config value
>> definitions.
> 
> hmmm ... while the config values are not used they are now established
> ABI and any other architecture that wants to support configurable events
> will need to follow these definitions. It is thus required to keep them
> documented in the kernel in support of future changes. I
> understand that they are documented in user docs, but could we keep them
> in the kernel code also? Since they are unused they could perhaps be moved
> to comments as a compromise?

How about just keeping them as is? I will just not remove it.

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v6: Fixed inconstancy with types. Made all the types to u32 for config
>>      value.
>>      Removed few rdt_last_cmd_puts as it is not necessary.
>>      Removed unused config value definitions.
>>      Few more updates to commit message.
>>
>> v5: Introduced resctrl_arch_event_config_get and
>>      resctrl_arch_event_config_get() based on our discussion.
>>     
>> https://lore.kernel.org/lkml/68e861f9-245d-4496-a72e-46fc57d19c62@amd.com/
>>
>> v4: New patch.
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h |  21 -----
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 104 ++++++++++++++-----------
>>   include/linux/resctrl.h                |   4 +
>>   3 files changed, 64 insertions(+), 65 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 4d8cc36a8d79..1021227d8c7e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -32,27 +32,6 @@
>>    */
>>   #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
>>   -/* Reads to Local DRAM Memory */
>> -#define READS_TO_LOCAL_MEM        BIT(0)
>> -
>> -/* Reads to Remote DRAM Memory */
>> -#define READS_TO_REMOTE_MEM        BIT(1)
>> -
>> -/* Non-Temporal Writes to Local Memory */
>> -#define NON_TEMP_WRITE_TO_LOCAL_MEM    BIT(2)
>> -
>> -/* Non-Temporal Writes to Remote Memory */
>> -#define NON_TEMP_WRITE_TO_REMOTE_MEM    BIT(3)
>> -
>> -/* Reads to Local Memory the system identifies as "Slow Memory" */
>> -#define READS_TO_LOCAL_S_MEM        BIT(4)
>> -
>> -/* Reads to Remote Memory the system identifies as "Slow Memory" */
>> -#define READS_TO_REMOTE_S_MEM        BIT(5)
>> -
>> -/* Dirty Victims to All Types of Memory */
>> -#define DIRTY_VICTIMS_TO_ALL_MEM    BIT(6)
>> -
>>   /* Max event bits supported */
>>   #define MAX_EVT_CONFIG_BITS        GENMASK(6, 0)
>>   diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 02afd3442876..0047b4eb0ff5 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1605,10 +1605,57 @@ static int rdtgroup_size_show(struct
>> kernfs_open_file *of,
>>   }
>>     struct mon_config_info {
>> +    struct rdt_mon_domain *d;
>>       u32 evtid;
>>       u32 mon_config;
>>   };
>>   +u32 resctrl_arch_event_config_get(struct rdt_mon_domain *d,
>> +                  enum resctrl_event_id eventid)
>> +{
>> +    struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>> +
>> +    switch (eventid) {
>> +    case QOS_L3_OCCUP_EVENT_ID:
>> +        break;
>> +    case QOS_L3_MBM_TOTAL_EVENT_ID:
>> +        return hw_dom->mbm_total_cfg;
>> +    case QOS_L3_MBM_LOCAL_EVENT_ID:
>> +        return hw_dom->mbm_local_cfg;
>> +    }
>> +
>> +    /* Never expect to get here */
>> +    WARN_ON_ONCE(1);
>> +
>> +    return INVALID_CONFIG_VALUE;
>> +}
>> +
>> +void resctrl_arch_event_config_set(void *info)
>> +{
>> +    struct mon_config_info *mon_info = info;
>> +    struct rdt_hw_mon_domain *hw_dom;
>> +    unsigned int index;
>> +
>> +    index = mon_event_config_index_get(mon_info->evtid);
>> +    if (index == INVALID_CONFIG_INDEX)
>> +        return;
>> +
>> +    wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
>> +
>> +    hw_dom = resctrl_to_arch_mon_dom(mon_info->d);
>> +
>> +    switch (mon_info->evtid) {
>> +    case QOS_L3_OCCUP_EVENT_ID:
>> +        break;
>> +    case QOS_L3_MBM_TOTAL_EVENT_ID:
>> +        hw_dom->mbm_total_cfg = mon_info->mon_config;
>> +        break;
>> +    case QOS_L3_MBM_LOCAL_EVENT_ID:
>> +        hw_dom->mbm_local_cfg =  mon_info->mon_config;
>> +        break;
>> +    }
>> +}
>> +
>>   /**
>>    * mon_event_config_index_get - get the hardware index for the
>>    *                              configurable event
>> @@ -1631,33 +1678,11 @@ unsigned int mon_event_config_index_get(u32 evtid)
>>       }
>>   }
>>   -static void mon_event_config_read(void *info)
>> -{
>> -    struct mon_config_info *mon_info = info;
>> -    unsigned int index;
>> -    u64 msrval;
>> -
>> -    index = mon_event_config_index_get(mon_info->evtid);
>> -    if (index == INVALID_CONFIG_INDEX) {
>> -        pr_warn_once("Invalid event id %d\n", mon_info->evtid);
>> -        return;
>> -    }
>> -    rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
>> -
>> -    /* Report only the valid event configuration bits */
>> -    mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
>> -}
>> -
>> -static void mondata_config_read(struct rdt_mon_domain *d, struct
>> mon_config_info *mon_info)
>> -{
>> -    smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_read,
>> mon_info, 1);
>> -}
>> -
>>   static int mbm_config_show(struct seq_file *s, struct rdt_resource *r,
>> u32 evtid)
>>   {
>> -    struct mon_config_info mon_info = {0};
>>       struct rdt_mon_domain *dom;
>>       bool sep = false;
>> +    u32 val;
>>         cpus_read_lock();
>>       mutex_lock(&rdtgroup_mutex);
>> @@ -1666,11 +1691,11 @@ static int mbm_config_show(struct seq_file *s,
>> struct rdt_resource *r, u32 evtid
>>           if (sep)
>>               seq_puts(s, ";");
>>   -        memset(&mon_info, 0, sizeof(struct mon_config_info));
>> -        mon_info.evtid = evtid;
>> -        mondata_config_read(dom, &mon_info);
>> +        val = resctrl_arch_event_config_get(dom, evtid);
>> +        if (val == INVALID_CONFIG_VALUE)
> 
> Can this check and the "break" that follows be dropped? val being
> INVALID_CONFIG_VALUE would be a kernel bug and
> resctrl_arch_event_config_get()
> would already have printed the WARN. In this unlikely scenario I find it
> unexpected that mbm_config_show() will return success in this case and the
> below seq_printf() would handle the printing of INVALID_CONFIG_VALUE without
> issue anyway.

Sure. I will drop the check and break.

> 
>> +            break;
>>   -        seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
>> +        seq_printf(s, "%d=0x%02x", dom->hdr.id, val);
>>           sep = true;
>>       }
>>       seq_puts(s, "\n");
> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger

