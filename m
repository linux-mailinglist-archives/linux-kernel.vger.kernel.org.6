Return-Path: <linux-kernel+bounces-418730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A499D64C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CBB281707
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAD01DF96A;
	Fri, 22 Nov 2024 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZfQGpGtg"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650BE1CA9C;
	Fri, 22 Nov 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732306347; cv=fail; b=cqtTsvLardA8eacQEzbJpBCUFBLT6w+UJ1+fpum0SjnlcdY0RIBg3wUnaG0uvpvouQDCfUVtraRx7HDpY5dTiQublsyZMeey8be6Hx/SaTfPXjBbeymLgxdh1lSCJf99sei3EiCQUn3OcaQnfZRle0REh7/cmKopxFsQcUpuw9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732306347; c=relaxed/simple;
	bh=K6L47CwV2FU5MFgd/8q0SNOCL6ZJmt6kyblmMc1IKug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sk6f7V88L1TnMI0eL26Zc8qIUzWKHX5B4BmS3ih7GrhMLvcoY+gu7AIDyuHoBUCBreXFvEL+rUD4kMn8UPGGsLCbh5+k58cBHQoP1t5uhnQcqEkqbC0S8Nxnz44A4UavksELi81vYPrmhXjc2h+YeJjYMWOWEL/mpMqgL5PjpFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZfQGpGtg; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nezMTcDtcmNi02vsHOKaIs5fD4SGJzQEFimQiSG1740SI3bkwBuT91iGhjrBynCGhBYsJNwiPan7wqv6bkA5YJJn7tSgSFIkUSqTLwLNOVP+WTk6GaeZY2EFBtrhtGtbdVclTfFtcFI2ztbX5aKwa0GzR3/XdQox+aueVpLreJkZ0PVx1pB4v6ij0K+NjcpC0hjquoqJya6xCUUIRaenmLEYQVGK4ICHObyIia40EPgxDyqlfZM5zBcHQsKZUIBJ3gOjex3IC0hEMkJTpZieXuLU8kYdXPqCX7g9M8OJ4fW2BA/gKiznGCnwlalsRZSXEAiME+PzRQtZxz/3llAiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHJ9cyD+7iPEFlBeMNHsgmxm3lrKtFGVmZTHLHXdOUU=;
 b=b3iYKpKLm+1JksdmmIrAGZ9FiwCRUEnXIdqLhxf3T2zsoegPSBAMdm7rRYhpNHwqx9FI30irdihxVeMKCU3EVs6WL4WRe5Awf1pcvFsiNBmNy3e7ugtE2blJ3EzR7CHCLBD57d9iEDn7g2jL3pKdxM89Tjq45BLTtfTyhmbl98OH7BV4aiLJgzDcElhaZ3DBHy8QckZann7/9FwJNMFsVHDuNEFar2hr43aPlLEcni1Cea8OxYacJpxg9nSDrjRUkinj4cQPNAH9WjyxKyqLkM0nTu8FIQTACXwzRDAzYu2XYgKfK8rKzljrkbZ3HDVHEOJu9BOfyakRbeW6kN8XMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHJ9cyD+7iPEFlBeMNHsgmxm3lrKtFGVmZTHLHXdOUU=;
 b=ZfQGpGtgO0+0pWVIaZUD3fLjJVLmHyXfCZ7dEoTx1x2nfHQhG/NyFfXwTs3hmQanl06ipHaiCjUgQEmMjgoQ7DcK2JZbdUUCJSkjQAthcFYjYu7azLX9EzNY4QYjOl3InGnTWFsHYPgxJv2bIn7vxNJ2haCJ35nObbUB+HyguOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB8347.namprd12.prod.outlook.com (2603:10b6:8:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 20:12:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 20:12:17 +0000
Message-ID: <50a7d4a1-f45a-427e-bfdb-980ac796238a@amd.com>
Date: Fri, 22 Nov 2024 14:12:11 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 24/26] x86/resctrl: Update assignments on event
 configuration changes
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, maciej.wieczor-retman@intel.com, eranian@google.com,
 jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <89e98891f50d1d57c1cf8bc18c1f562ac58d2cce.1730244116.git.babu.moger@amd.com>
 <b78a01b4-3583-4689-a894-96dab5dfb9fd@intel.com>
 <31994778-74aa-0b61-cf93-14c25c872e9a@amd.com>
 <82b51e46-3da4-4b49-8ad9-45ed18fcc2e6@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <82b51e46-3da4-4b49-8ad9-45ed18fcc2e6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:806:f2::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: aee865c7-e186-45c7-f0dc-08dd0b31f62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVlmcTU1R0pZWXEvSXdFOFNUT2ZsVVpHYjVuK1o3VjAvWHdxd2xPSW53WmZ6?=
 =?utf-8?B?eDRJSUUyV0pYOVB1VGZlcDJhcEFkUnZPWDVGUWk4T0IwRXdOd3BtbFZxRjZB?=
 =?utf-8?B?L3V2czZ3dUZCK0lnUXUwVmNVUEh0cjcvUnhudjV2RnNTSDJCenpFK2QvVDVX?=
 =?utf-8?B?ZElQc2tKY1JvdS9SeTZEZHJMNGVMYzYvWkNXM25lbkdXR2szUjEzZzUwMFds?=
 =?utf-8?B?Mjd2SW9VcnVHTXJNTkxEbjJlVnNjVU4yS0VJL3pkL1RDdGM0b2xjNWpqT3FZ?=
 =?utf-8?B?L0Jva1A0M0xjU2wwS1YrdUY2bm1hWG1VOUluSjBGc3BIOEtram9NSERvdXFx?=
 =?utf-8?B?ZDFWNS9sWUJZVHNBWHQyNUUwZ0UwOUMwcXl5MWpPUUZOQnZhSUtUblhraUR4?=
 =?utf-8?B?QUFHNzZCSUJUbTNLUEhkQkM0RVRnbVRYSlVNcWpNczBGZTRlNEEzbG9sMm42?=
 =?utf-8?B?d21TV2Y5c3J2YnFFOGZOTUR0Zy9JOGU5R3ZtcFpPSFljMWlmUUlPOUJMWWhr?=
 =?utf-8?B?WW91Ym10Yi9FUVUxSzlsQWhxWk9XbTZpcnV5WlBOdDBlUytIZkk2WFhwcWpL?=
 =?utf-8?B?YVQzZXlkd1BnUVVKSHp0U0JEQ1crVXJQSGtVWmVjeE0wcGsyV3RVeDA3cG16?=
 =?utf-8?B?RHljNlduNTdqWS9uSDlkTzVFclpOWTBEdjJFNnd1UU4zcjlWblQzR25McFlZ?=
 =?utf-8?B?WW82NjlCMURjbW9VZmVDNFRBUUlpTEExMlZYUWNBbmJuK3VwZHUvN2NIcnV2?=
 =?utf-8?B?S0Y3TlJtT0FzNTdFVk16VFpDNzUzQTNYUnJEZnJkTEtyWU9CUUUzaC9mNFpE?=
 =?utf-8?B?NXdUNFhtRG8vUHFkcUxiSllkZGhBVDlNN3hLaS9Za0NqZHozSlRwWFM5WmJa?=
 =?utf-8?B?aTZtY1NvcVE4YW5Za2J2Q0FwOERLdzdteGlaa083NEI1dkNkbVg0ZWZJNWg4?=
 =?utf-8?B?ZGhyWUpRK2dKNnVCdnZPaUZveXFzRldObjRPNHlaTFd2a1pHSnlWbi9nT1A2?=
 =?utf-8?B?NDBRWjVScUlmNHFFOEtBMXNXV09JSXppQzhwMUZVQzhyc1phcEtsRFlCMncz?=
 =?utf-8?B?V1FqeVQ3MjdhZTFxak5zWk5DWDNUaGtwYy9mUnFUYnNUdWlQT05TOG1kMnFq?=
 =?utf-8?B?Rlpka0hwUU9Vb0JpakErWUhRMFluZ2UvSkNpWEFVaUwrcmpXajI2ZmoyM3JV?=
 =?utf-8?B?SWw3YWdwR1dNQzZycTgvZnk5NkQ4UkRnOFJ4aDZ0T3Y1TC94ZnVIWjYxZUZC?=
 =?utf-8?B?eENmUDU3eVNqRnFscFdHcWtIMW5ramFZZnZBSEtvL0EraHQ4NTNWMFU3ZDFq?=
 =?utf-8?B?K3VtcGo2eGEvTFd6U1cydFlHQ2ZNUmVRdjkyUjkyTDNUZk4xZ3Z5ZUtlekI4?=
 =?utf-8?B?M2hyQUdDZXo3SHdibEtOUjNITmhROVVsV0s4MVp2dWFtNStHeEdiOU53S2M5?=
 =?utf-8?B?NCtwaUpMN0dkSGRVOHA0dVQ4ZlpKNXNoUVEvY0lDaWE4ZE1ncENPSHhnb3d5?=
 =?utf-8?B?LzRJLy9nWE94Mi9pWnp3NFIwZzFMT1h2K1ovb2NKWDVNT21aaER4c2lvSXVN?=
 =?utf-8?B?a0N5NkJ4RGFNSVo0eEdsSm4yZ2FQcWFFQjkxZVk5OHJ1N2IzZ09PMHBhcXl0?=
 =?utf-8?B?eldrd3dsOFd5eXNqUFZrV3VzTWJwYWFXZXVkYXVBZXE1RE5LTXlHMHMyeWVU?=
 =?utf-8?B?S3BkUTRCNng1SWExMzNDNjdHeFF3MGwvL3VqeFVFWlphVzZEZXlEVzdwSUwv?=
 =?utf-8?Q?CKV0REd1VF5i6rVQXako4Jx+HQGEhVQoK6CNTfd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWkwNGwwRU42Y1hadGdLVHM4Tml1Rmk1RXIyNjZPQXplZFI5aHFlWU56bUVn?=
 =?utf-8?B?VDd2MmRvZERvUFZCWm0wSnNCc0lsSHhsVWlnOUhyRW05dHdmSHhwNndZeklt?=
 =?utf-8?B?SGZ1cE5JVWJRd3Jad0c4ZndIYzArOGQ1QWlZbmF1RG1KMExNRWsyWk5Ycnd6?=
 =?utf-8?B?U201RUNaSnF6Sk96VTN1OEFsUkx2WGNYZzJGRTBpSUs4ZzEvdVNJbGkyenlM?=
 =?utf-8?B?RFVCbDZrbVJCbTNMRGk2aEttc2FBa09RK2RDcUxpR1RzQ2NSY2UzZGFpR3Q3?=
 =?utf-8?B?MGNpZksyUTRFb3k3LzRaQ3dwbFgxWE8rVHRFcktzTWprTFFoMkI4M3IvSCs3?=
 =?utf-8?B?NS9oT1JuSk1IaENZU1Nqd1oyT1VRZUxWdTY0WDJ4bDBBRHFmaFB3UzRjZExk?=
 =?utf-8?B?THArUjVReGhETVlSdGdXeHFoSXlVa1puMzFxSlV6QWk2WkMyNEpqalh2Vm1S?=
 =?utf-8?B?dkMwN2dwVkZobHc4VzcwZm5Lb1JIbWtaRXMxREtVU3FXSmlUVlVTK3N4MTVI?=
 =?utf-8?B?NGRKT0RTVHVueUxLWHFXbTB4aTZYeTJ6bW42S0pEa3Iwd25tckRJM1ZaS0lv?=
 =?utf-8?B?MzRTcUVDZ2FxMmVzQXpkWHVlSlNzWjQxTFVGT2tyME04VUVLR0k1cGNTME54?=
 =?utf-8?B?ekJDSnRrOE45REQwRTZKY1VXTzNIT1VNeGt4S1dsaWJYemo3bjk1MFFtZHlQ?=
 =?utf-8?B?U09NMk1oT3NVUmx1T2FBbHNOOGlDbHhBbWh6MnMrd2tkNTk5R1J2QnlZcE5N?=
 =?utf-8?B?NDhJcUxKcUpPTW9pUzhFb2tLdmpYYmpoUktQVmx2YmRWbnBqMTJUemxWNm16?=
 =?utf-8?B?cHF5TFBGaWw2RUdoQ2FMdDRjRGNjdzlGQmU3aXk3NjYvVWhzYnowS0RVbGNN?=
 =?utf-8?B?c1FuWU9OSzdQQ0dRMGJISlRybXdzdmE0WEJBNFpqT05sMDdOOTl3clVCbVpp?=
 =?utf-8?B?b2FNK0xRcWhsSXBRQmZ2OUpFN25FYUcxb3hNbXIrMnl6cnI2cFRiZmpFb0gx?=
 =?utf-8?B?eXhFUEJtck16UkxkZ0N1TUFrQThnMjIxUmV2Y29vaHRHd3JFSjR0RFJBZlYw?=
 =?utf-8?B?WVBNZFQrNGwrTTdGaVFTNlBTb3BnaGNoblFtNys3czc5OVBVbmxidlR1OXhI?=
 =?utf-8?B?NzZaK3laWENWSXE2NHdXZkJ6SVFxcjlrbUozdW1CdDVNY3FJbzlrWUE1dFJw?=
 =?utf-8?B?Sk9mSXlvRFJ6Z1VBaGRmYkY4ODh3RTZDOENSZE9Jcjg2bjdvY2ticm9HYU85?=
 =?utf-8?B?OFhKVTNpdnVpZDhaKzJOV3ZmSi94YUdsM2VSU1pFekV6NHlyNmxnUFhaOEtX?=
 =?utf-8?B?c2k5R1BucERLcWZIUVlZQVVoUHkrN2ljeHJUWHdHY0UzUUZQRnA1T3Yrcndy?=
 =?utf-8?B?Uk9Edm5MTTBwYzBPMG5zWDJRMnVkbCt5Vld3SWp6NUtzSDZUQ2t5eWZhMDZo?=
 =?utf-8?B?TWNWczRrTzF0VmJDL0MrYzZQN04wdjBYN0VtQ0NVWHg4Ky9UVjdsMTdkWGVr?=
 =?utf-8?B?YUpBbzl4aGtkaWpqTDgvYWYwV1ZMcHRseTFpMGp2STFmSVpYVFoxUmlxOFFn?=
 =?utf-8?B?akc0ZXpYZFdya3VaT1EwTWJnWEkrWHkyV2dySEhHYlpMUTFGZGJNSmRxNDhV?=
 =?utf-8?B?elFjRVNCZDFxR1JVOHdSSkdJSjI2N09kVkJRR0Z3TTVvSUc1RmZObTk1NUc3?=
 =?utf-8?B?STRuWXp4MnpoMGRFYjdlYXlrMTZvNS9jRGZqTVZZanJHd3ZkR0x1ZGt2U2Nu?=
 =?utf-8?B?MlV1MG9rS3dRWEFyWlJjMTBDOW95WVFWbWZsZ1dtVjZOYWdxc0ZwSkcyckcz?=
 =?utf-8?B?czR6YUR5cjNLR3BsVmwxSHNlUEhXY2tiKytlWTVGYU13empqZi9ZSkVzMWhN?=
 =?utf-8?B?TXZ4MldpcEE0V1JTalRoV0tsU29Ga3NNM25kelNYSjJDQ1l4RDRwTHFvN213?=
 =?utf-8?B?c21VbFdNSzFwWkNISU1PU2RabmxTSEkyVXNsZ3FzZCtZSXU2QW1xUkNCR3RY?=
 =?utf-8?B?b3hBcERlSHFZWTdRbnNGZytyL2VHQkhVUVEyUG96akRLditFQlo0VGIxRGt5?=
 =?utf-8?B?Rno5cFNPVEdEa3JxMzNVVDhXMGcyUkpPYW5XL2Q4MDU3aVE4T0FnQndvMUdP?=
 =?utf-8?Q?d6iw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee865c7-e186-45c7-f0dc-08dd0b31f62c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 20:12:17.0431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WD5bYrdaRWIo8oKKZE3LMtgYLIOS6jVhID+h1vmY8m4n5bqGXBob3A1JoGX3D3jx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347

Hi Reinette,

On 11/21/2024 2:58 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/20/24 6:14 PM, Moger, Babu wrote:
>> On 11/18/2024 1:43 PM, Reinette Chatre wrote:
>>> On 10/29/24 4:21 PM, Babu Moger wrote:
> 
>>>> +static void resctrl_arch_update_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>> +                     enum resctrl_event_id evtid, u32 rmid,
>>>> +                     u32 closid, u32 cntr_id, u32 val)
>>>> +{
>>>> +    union l3_qos_abmc_cfg abmc_cfg = { 0 };
>>>> +
>>>> +    abmc_cfg.split.cfg_en = 1;
>>>> +    abmc_cfg.split.cntr_en = 1;
>>>> +    abmc_cfg.split.cntr_id = cntr_id;
>>>> +    abmc_cfg.split.bw_src = rmid;
>>>> +    abmc_cfg.split.bw_type = val;
>>>> +
>>>> +    wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, abmc_cfg.full);
>>>
>>> Is it needed to create an almost duplicate function? What if instead
>>> only resctrl_arch_config_cntr() exists and it uses parameter to decide
>>> whether to call resctrl_abmc_config_one_amd() directly or via
>>> smp_call_function_any()? I think that should help to make clear how
>>> the code flows.
>>> Also note that this is an almost identical arch callback with no
>>> error return. I expect that building on existing resctrl_arch_config_cntr()
>>> will make things easier to understand.
>>
>> It can be done. But it takes another parameter to the function.
>> It has 7 parameters already. This will be 8th.
>> Will change it if that is ok.
> 
> Please correct me if I am wrong but I am not familiar with a restriction on number
> of parameters. It seems unnecessary to me to create two almost duplicate 7 parameter
> functions to avoid one 8 parameter function.

I dont see any hard requirement. Will add one parameter for smp call or 
direct call.
> 
>>> Since MBM_EVENT_ARRAY_INDEX is a macro it can be called closer to where it is used,
>>> within  rdtgroup_find_grp_by_cntr_id_index(), which prompts a reconsider of that function name.
>>
>>
>> How about ?
>>
>> static struct rdtgroup *rdtgroup_find_grp_by_cntr_id_event(int cntr_id, enum resctrl_event_id evtid)
> 
> ... or for something shorter just get_rdtgroup_from_cntr_event(), but no hard requirement.
> 
Sure
Thanks
-- 
- Babu Moger


