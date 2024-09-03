Return-Path: <linux-kernel+bounces-313680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03196A892
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927E11F251EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EA21D5886;
	Tue,  3 Sep 2024 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rkkvWzhX"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCDC1DB531;
	Tue,  3 Sep 2024 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395893; cv=fail; b=Lq13AYkKHn6ew2OEY4br+zyg//s89ly3Z+wZMW9OKpTLQVPZGTRFS5iwXsWOgD/McwsH3mG3+ALIa76n3f42WmVFNOsCG6G5ks5xBID14TK+rY5EoGmjtLxHZwuLH09spvG3vsI2C9RrqxxEdHLWCL7awkZqQ0MMKZDIY/idR2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395893; c=relaxed/simple;
	bh=Ijq3fd5L8BSvNvF5ZOrHuiEbEFIErE3jCPVO5A9bdlU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nz3lQGQdR4RVIyLXFiXmjsHrgkGIk+gPSg5Bu41DEOJT1Ya41oWom3PUNOr6VYam241QSxjQEB3w4g4phn7M2rjZEy2eQ67lw67X7RzF7I+pQiudhi3Oye0wPRWSxZT09jmtjkYkzhMrm4F4CgctwP4GRuKKzwtDYegWeSW9MpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rkkvWzhX; arc=fail smtp.client-ip=40.107.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1CPkbUIGW26RJRtyNaKxBCsyz3HiHGqybzClD3mXwVz1W3SVbisZKWe+H8+dIYTLxcwZKgExSxooTDaQJi8l84ysm99pNhVIB6TiXr+1xEmBNF73yIRqxoDO8d5JN/6M+K8C7SlclhPHE8+bHIjxn1PP2TPCCu/LzMQaNKLEHmsGStWvX0dTNp//QrN+unmA/E9z8FjDiHpYETGoQtWFbz/SWrqI5crU0QdBVjn3dQPvH7taIqc5Cs5MtrQvFrSS5n58IJ488EBQ/Sv7X74fwbvAs0fLlxOKE1iGghyy0pTN6v8LO0qit7ZVdaUbQyfe3wkfulJpGxFc1JPVTXhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTOVDlllWLDdzlMSZznT+2RIK5fFtS3990Pwlkjel6g=;
 b=Kd4QwS/IKhLWSYfEfO4f1oN+J9wakCe4Lgf8Yq2hxloDEcK0BoQxR5iGBT889ldIXic1y+fAHkxor0seHnnMCYPpN3mz6+wd5PzfMgNWuahBb1xdrHqv0sy4WnrpBLwJbEKs/RQ82AcK2sPBpcCdb0XUUceBO9g4HiL885dMI36qk11kV5lmt0yAntOU6pETo0V/1rQoskcJzehKdA+Sf+cHpQwbG358QTfyKEL+jG6JcjPCzpWfN6AixD/DsvVnMosgikc46xdQKcS6A2DHzzFox3RwF4zm/t7yB4mPjVaq1Gx+KnDYqYiUCgVWUHdWu/9iP0AaGx4jP+boIma4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTOVDlllWLDdzlMSZznT+2RIK5fFtS3990Pwlkjel6g=;
 b=rkkvWzhXdSzlcbJnMpcKmmo/mfgLTN1yFRyoj/cKVqWPUplURlE21N81L6Xk9JQvDLXfzF9V/EU1XNUSzf9pwCxZeSY2xKFpbSA3XbIm258b225fSGa9Zg4FBeELtdnWPM88XZ4ML+tR9dOrfqg3l9G08br+E6RtiRd1ZeDtC3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 20:38:09 +0000
Received: from SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2]) by SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 20:38:09 +0000
Message-ID: <ab9f0c78-0e7e-95b4-5b24-5264d745e44f@amd.com>
Date: Tue, 3 Sep 2024 15:38:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
To: linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Eric Van Tassell <Eric.VanTassell@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>
References: <20240903003511.1530454-2-papaluri@amd.com>
 <202409031656.SS8NsjIN-lkp@intel.com>
Content-Language: en-US
From: "Paluri, PavanKumar" <papaluri@amd.com>
In-Reply-To: <202409031656.SS8NsjIN-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:408:ee::7) To SA0PR12MB4447.namprd12.prod.outlook.com
 (2603:10b6:806:9b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d45bdbe-d046-4510-2f5c-08dccc585261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlltVXlvNkxsZm5rT0ZaUFlDUUQ0UU93OUJkalJYVDRUN1RVTXI0R3cvc1Rq?=
 =?utf-8?B?bnhZS1BtSFVsRmZmNW9jVHVnUmFOblU1Z1hRaUFXbHdlbm9qcG82NVJDUHZO?=
 =?utf-8?B?SGJTYjFVVmlNMnFiS1hPOTVUR2pBL1grVitPTHBWY21HK2h6RzJsVngxS2ls?=
 =?utf-8?B?MENScm9oZElkaTE0UkVVOTNnd3B4MlVIWURKcjNqSDljV3hKc3BPb3daK1Na?=
 =?utf-8?B?dkgxY1pZU3hZaERQTEd3ZXduMmhBQmx2Y0ozYlcvREhGQWh2N3FlTkxiMTlB?=
 =?utf-8?B?Tm1tM0tWUVYzbFhVTkJFektEVlEzb1ZMbERYUlROSktkT2drb2MxTyt6cW1s?=
 =?utf-8?B?WE0yN3p5OXdHd2ExaFFGdHpxK3pFenFUSXRaVys0UFhnVXdSSzZjUFdSZHBs?=
 =?utf-8?B?Q1pkZDk3d0xrMEJNb21QckJKRzhRNG83VVVZTitFeGRBQmlUeTBIc2ZMOWVC?=
 =?utf-8?B?TSs1WFdKS1lLVzBndnFQaEpWZkRmY3JBWmxCYyszUGxKb3FPdHNTTnVXVmdz?=
 =?utf-8?B?UFpMdTFOMzBaeVA0YkhadGdiU0ZmVUFqQTFFWVMvL2F1WEZLbTlpUzZBSFJT?=
 =?utf-8?B?NVhOVHV1c0pCQzAxMEo4WlFFMXBTeTZNYjZpaU5iUWQxSEhRMXh0Nk1rc2pl?=
 =?utf-8?B?VU03VmtvZlNKR3d4ejl3OVJFd1lTK05BQWRaMDhkd293ZFRiK25mdUZva3Mw?=
 =?utf-8?B?ZkM0TWlaWUJKNUNLeTI3RXVCK0k0a1RPbVFqcENPb3pwSkhpM1NYRDNxOHl5?=
 =?utf-8?B?b2Q1RkppeFFRN0d0Si9kNjBhN2p3aFNMdTNXOWJzMmRjbXdsV0l6aFNHaHdT?=
 =?utf-8?B?RWZ4VFk0TFpaek5lengrRmtDbnlnaFFoNmxqQ3hkWGMwNDNrZEUzQXUxSWNE?=
 =?utf-8?B?TUpsVFNwOXg3OU1sQTd2WmF2NDVTSjZPQm1FZEFNK0FOZnFYZ2Y0N3Izdmw3?=
 =?utf-8?B?RkxxZHdkNHJkaVhjYXY2NlVIaERPM3pTVnIrVlBESjh0aXAzNENWWExNK3RF?=
 =?utf-8?B?bE1aRytMeFR6Tk4xV3JuYjRYZlRtczU0enM1bXkzSmtHVWVickw5blBjK2VM?=
 =?utf-8?B?Sno4UTYrZ2M5OVYrckg2aXhnMzlxcjFqci9SV0M5OGQzOXNmMnhpckxUYVZi?=
 =?utf-8?B?N3VpUmZMNjBweUlHeHJPb21OQkRYUHVvamQzSjNEMWRBOUJvM216UEM4ZVZP?=
 =?utf-8?B?NDBCSlNLL1NDRWd2VjBUeXJ5L0pITS9xQnhGTzBnajlGelRXWU9DVGVPeWha?=
 =?utf-8?B?ZVpXMEQweDREWUFWVGVhOHBRdjVIc016VmhkNEN6VXI3djR2RG1KTVBjSzRU?=
 =?utf-8?B?ZVZTcGI3Yzg2cW9wNlZOdlI4MzJqQzBrcWFjeUF0SE92SElnR0Z5L3RoL3Ft?=
 =?utf-8?B?cThjMmZqNE16Mm9oekJyRFk5UWo4TWdvejBTYzlYNWR6WlBNZWd0aFNLME5X?=
 =?utf-8?B?NktlT3NPV3UrdDUyUElldUp2eWFvNHM0RlF0RWpjM0YzMUFxZjZzaitwOSty?=
 =?utf-8?B?Y1BXaE43WENFT3A0bVdmc1paS2xsSW9vM1poNlZlM0h1YU9PM1BNME84Ujd6?=
 =?utf-8?B?bVUwZUhZTGRkelJIQU1RUmNJb0ZHd0g2WXZOZUFLTXhhalU4R3Z2amE1N1U5?=
 =?utf-8?B?QlY4MkUzdlZvMFF2M0d1ZVQvQWNGV2VZekJvTTVsaXNRMFhWbXlheE5idkhx?=
 =?utf-8?B?Vzl4T1FnMkllNXRicjZySCtVbExPRHVKZkRiOHEwMEhXZ014bGtCNjhwVVJZ?=
 =?utf-8?Q?oPU4hlQ+hz9gCu9sddZGrCV0eWjt3bP45vonfh6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MENYOTBDWExwSDRHeWVOSHdZdTk0RjhnUnA1WkltREZsL3FiRjBXcUtCNERV?=
 =?utf-8?B?N1Z0VXZLOEdxTmx6RVJqaUZKWFBaZWFoSUhLemF2QlNpcFBzL2todE1QbjE0?=
 =?utf-8?B?VE93QWJNcU5OWnZDVFFWV3drdzFyNHVyMmtlQkdOL095VGY5dU5yMjJ4M3lO?=
 =?utf-8?B?cVBaSnp5ZW5oc0FIZGxnMlhDZk1CUHBjaVovTFM0TVZQbDlkaUhreUoweEJS?=
 =?utf-8?B?TCtxNElRQUVhOEVtY1pIOHp1RWVkQXJUQXNYVlc3aVhIN1lwb3J1SWRzaUxI?=
 =?utf-8?B?RUUxSVYrcUl5d0Zna1dMdUVZc3RQVnQzTDd5Zm1zMnBWWFFsZEhJV0NCajZS?=
 =?utf-8?B?Wlc5cUVyZUtKRENOK3ByYlpPdlU3Z0ZUaGltTUxuWTZya08wWEFQTXFKaTFp?=
 =?utf-8?B?TlVEd0JHaFRPVmhxelBpRS93R09DWi9OZGdCZ1ZmZ3NmUzNXQ1kyMFFYU1JT?=
 =?utf-8?B?V0I0WGhGcVZUb0c1L1g2YVg0aFZUQnJIZjJ6TWMrODZtS3p3TFFPR3NwK0tp?=
 =?utf-8?B?Snd4U09NNElneVdwQm11K3VGVzlxSE4vQkhHVGIvanVoaGxSNzJjdlE5TnVY?=
 =?utf-8?B?d1FpTnBpWXBqZFIyek9mK3IvQWxrMVN1ZWVhL1NJZS9WSHBGVmpVWWhyN1hJ?=
 =?utf-8?B?ZmlEbjQ5WUl1OHB3N1R2ZDJYb09wbk1URDBxVjhkVWNzK2ovRkpydnFaUlBy?=
 =?utf-8?B?SEpMRFlMUW1mMFFlRktKeUZ2Z2MyOWZNcmZ5RDdSTGxKK1VMRU9lTk5zODhX?=
 =?utf-8?B?OW03R3pMK1NkbkpiSEMyeUhFbXNJNGhvaTU5QnhOTDkveGdGK2lrY0ZUYUtQ?=
 =?utf-8?B?cTNJbzkxcFhkNmlxL1FrTzg2UndsNGJINUpBVkVBRjh4d05KZC9zRkpwZWkw?=
 =?utf-8?B?TG9sWGJmVk1EN2tUWm9wN05oTEp5SEVKbmMzUlpqMzVVWmppWjFnSHordHFG?=
 =?utf-8?B?azBjWWc3R3VpQncydFdKUWhrY211WlJueW83Q1VrY0s2clM3M20rODhyZHpi?=
 =?utf-8?B?bCtrM2hwQ1ZOZWt6WkhNR25OTExKQXp2OS9wT085VnM2UWg4Q1RVRmp1eERm?=
 =?utf-8?B?MURnVzJ4MHRIRUFub1B5MWh1bHFQTmdJbkpFOGhQL3BoRHpvcTNIYkpPaGRy?=
 =?utf-8?B?amRESjFMbTQ0dm0wa1VYUWVIcHZwZEhwN3N0Y2pOTTBUZXJ5RXdXdjl5UlUv?=
 =?utf-8?B?K0liaFhCQmk2RW5uZlR4T0FJUllhc0lXNjVlYWd0S0N6V0c1QUEvcm01ZVla?=
 =?utf-8?B?ZDMyMkdQUWhiUzkyN2ZjTXhMakduN3Zvekw1cGFHWit0MFViaTVxc25xU0Jo?=
 =?utf-8?B?M1pLeG1Fb0cvekhKTnpVTnljeDBNVW9wYVhlTUxCOG5mVU5teTBOL3N1QWhx?=
 =?utf-8?B?UXBXd2xubHhYQk02MWcybThEQ2xrdER2Vnp6SVA3bWRsblArOGRiaVhHWVBK?=
 =?utf-8?B?dUxrRGVaRy8zK1BzdmZmaDRoUklxbkUzQ2tDcmp5UWw4cjdJZit6M0xiNzFY?=
 =?utf-8?B?aHBta3RaMnNJUis0SWhBK0N5TXhicWtGMWdBSXlTRjd4TnQwZjBjbWMwUVRx?=
 =?utf-8?B?clNtTnZ6bDdaUDM5ZnJRUi9QUEZHUXU1S1NBbU04dGZvKzZVVTFpNWVZZmI0?=
 =?utf-8?B?VEdNYXNDeStsdU5nOEEyS0l4VnpOdmRnUEFxMC95UmJXZk9ZYTc2YnhCcDhF?=
 =?utf-8?B?RTRzRGF6NEZMRTA0aDV5VW02c1NXSGIwU1JLbXltR2hRMysyVE9relZwdWVD?=
 =?utf-8?B?am9aOHZPbkNNYjFzanBiVGtkK2ZESXRsU1ZEL0JGaUVYRFk0cmFLTHhwaU9Y?=
 =?utf-8?B?TTZuK29UUTZ5T21TZDgvU2VEMngwcnAvQTA5VGVidVhZNW82aXVXL0grNy92?=
 =?utf-8?B?RUZlcG5POHREUVRCVktHNzNLcitUSUhhQjNHVy96K29hZ1VCUThnbmtJdlZK?=
 =?utf-8?B?QWxvcWpiSWRwblFzaFViWnZ5SzhOaCtTc1Y1aUJwQXl5eFhoMGRDd0R4a3JN?=
 =?utf-8?B?UkpsZW1TQ3kzTUVqc3VuN1lxQkJQMzJvaEFVUkVEZEZKektvUGFkd3kyNEs5?=
 =?utf-8?B?dlRFZGxaVHllWG5kUkhkTDMvMWRkRW9SRm93YnRvdDZMNWhJNklWM1gzQTBl?=
 =?utf-8?Q?bVJoe4LrVk5tb0cVV/53rO6Wz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d45bdbe-d046-4510-2f5c-08dccc585261
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 20:38:09.5701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjKQfNgLSa75LUZURuYOTDJg3YBIqnq4xTh3Gf870UsBZtgDmpGH1r62Zbks23qdG/z9R09Tkj+gdWuaBjxwtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269



On 9/3/2024 3:44 AM, kernel test robot wrote:
> Hi Pavan,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on a85536e1bce722cb184abbac98068217874bdd6e]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Pavan-Kumar-Paluri/x86-KVM-SVM-Move-sev-specific-parsing-into-arch-x86-virt-svm/20240903-083803
> base:   a85536e1bce722cb184abbac98068217874bdd6e
> patch link:    https://lore.kernel.org/r/20240903003511.1530454-2-papaluri%40amd.com
> patch subject: [PATCH v2 1/2] x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
> config: i386-buildonly-randconfig-001-20240903 (https://download.01.org/0day-ci/archive/20240903/202409031656.SS8NsjIN-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240903/202409031656.SS8NsjIN-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409031656.SS8NsjIN-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/x86/include/asm/sev.h:16,
>                     from arch/x86/virt/svm/cmdline.c:13:
>>> arch/x86/include/asm/coco.h:28:18: warning: 'cc_mask' defined but not used [-Wunused-const-variable=]
>       28 | static const u64 cc_mask = 0;
>          |                  ^~~~~~~
> 
> 
> vim +/cc_mask +28 arch/x86/include/asm/coco.h
> 
> 1c811d403afd73 Ard Biesheuvel     2024-02-03  22  
> b577f542f93cbb Kirill A. Shutemov 2022-02-22  23  u64 cc_mkenc(u64 val);
> b577f542f93cbb Kirill A. Shutemov 2022-02-22  24  u64 cc_mkdec(u64 val);
> 99485c4c026f02 Jason A. Donenfeld 2024-03-26  25  void cc_random_init(void);
> b577f542f93cbb Kirill A. Shutemov 2022-02-22  26  #else
> e4596477100706 Nathan Chancellor  2024-02-02  27  #define cc_vendor (CC_VENDOR_NONE)
> a0a8d15a798be4 Kirill A. Shutemov 2024-04-24 @28  static const u64 cc_mask = 0;
> e4596477100706 Nathan Chancellor  2024-02-02  29  
> 

The following diff resolves the build warning reported by kernel test robot.

diff --git a/arch/x86/virt/svm/cmdline.c b/arch/x86/virt/svm/cmdline.c
index 43039ec67606..9b900e950b4b 100644
--- a/arch/x86/virt/svm/cmdline.c
+++ b/arch/x86/virt/svm/cmdline.c
@@ -11,7 +11,7 @@
 #include <linux/printk.h>

 #include <asm/cpufeature.h>
-#include <asm/sev.h>
+#include <asm/sev-common.h>

 struct sev_config sev_cfg;

I will apply this fix to the patch and send a v3.

Thanks,
Pavan

