Return-Path: <linux-kernel+bounces-258453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF68938815
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C501F210D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C69B1642B;
	Mon, 22 Jul 2024 04:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WkPfPUGb"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2858F54
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721622580; cv=fail; b=UnCtACP9+CjdMUGR4nzUEz6T8VpRCge7vg0hvOq/oGe3fCfrg/2pt104mhNGbV2wf4sWLMBLNPl33fSviq8KRyog6+f6OmQT4vftIyCwukfEM6JN8/G63EgN1JTEQ56y6o1on8jm5X5lKLddYGw66/LTr9grlJYEQagr+PDRJSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721622580; c=relaxed/simple;
	bh=h2W0V/c/48Oc24XDvdDoU4QhIwX494Uwvq9+Hze7Fyk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m8MKl8FleXkn1Ij/Yjra991XDrJ7g3Hl103yuUobNFx6yjEJtzCDY4uoysxxIe/tGiI3Gr/OoUHOulxGVl1YelG2S5m2DMLzkrok4XRV5LjjWaAlN5tNqJMxt7FBF7BW1kk4fnhRwMpbc0E8SMsNasbiFkap+nikCHbzs5n5kQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WkPfPUGb; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJOq7ojDNBsPmbYBDV4L0Db+7jVxSL4F4Nod5XiAuycIrIEh68ycW34eJveygLbY1xvvKWpM6SVLXGbdunfImngptPeA1FUz6lgJPM4p6/MVvm9Hj1trBJnLfjNKp8n6Hj2rFJAb1gOpJkdlz2sxthU2dfVHUAgqkgiuAM9tV1PBTHE32GfjBlbBjMoUr65RKvPl74nXzOc7YiiLqnG+u9bT/KShb+1mhXjaV4KPu7wsexMqHgXTUppb5mYnyNyAkQjBVh8zkePwjJv+2CAECZFWKiFyGvUSFrOKig06eMRnHsYHQ8pLsyaFsjyDPMpWSGotzHuK34sGNDvdByyFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9o+auC/p05O4Vq+BYU1gy06AVdP3bc1jyKWHOkYyR0=;
 b=UCg+9cIV0f+3QynIehWs9N9wfPyVFc/8AAKKgNCChG/PJlwC5a9RYn6BdANaf1EzNfDErRWzqRqVgi8A/cmDvTeo2vtHpDdVBAhaex4d8oSPq5eEks5Q1lsv/yO00wGkk9mq+WsQn64sKaKD62SAtf9BfNktLr3PsA952xREq0EJqAVvxQTrQKwrnlXjlnD1TlPLVdKLT/qB+9V/Jbr6cMDNyVRpR3vWIk+ukLSXG8WWvFWk3m5ApEK2Uly2jFfLgvs0GDK2n2TozIarxhnP9ISL1hKuTnTSPPCpaGeVCXvp0y5/UkS5qT5PDqkAAVGO6pOzrRrXjGBUjCWonZBa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9o+auC/p05O4Vq+BYU1gy06AVdP3bc1jyKWHOkYyR0=;
 b=WkPfPUGbdTR/Q9iaVAU5/LLLpfj5hII56wluALQUwPpvFNORYKV7V6uRgB/fePM3RI2XWItt0jbPyJsWVSmi0Y8eQcqyXTL6+jlzHGLtteqjLf9+4B5mPdXv8xyjg6O9xupJiPUKNaE0syNd4MKbXWsuWKZ6qwRd2R5fk42Z6p4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 by CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 04:29:36 +0000
Received: from CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7]) by CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7%3]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 04:29:36 +0000
Message-ID: <7141e8f9-db0f-43e0-98ed-c3e2c44720d7@amd.com>
Date: Mon, 22 Jul 2024 09:59:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cdx: remove unused struct 'cdx_mcdi_copy_buffer'
To: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: nikhil.agarwal@amd.com, abhijit.gangurde@amd.com,
 linux-kernel@vger.kernel.org
References: <20240530233436.224461-1-linux@treblig.org>
 <01c9b471-705c-40f9-bb82-90a6cb651ff7@amd.com> <Zp2QBoqAjKjABfJD@gallifrey>
Content-Language: en-US
From: "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <Zp2QBoqAjKjABfJD@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To CH3PR12MB9193.namprd12.prod.outlook.com
 (2603:10b6:610:195::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9193:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: a155025b-0a6f-497d-55d7-08dcaa06e472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEcwVVRoSnlvMWlVNzQ3MmNxRE1hYkYyTWZmRU42R0YvWEhlT3NSYzhieEZi?=
 =?utf-8?B?OVFWMHdSZ1JKR09JajdhaURvSVdVekp4QzZma2Z0QUlreThzd291N2Q3S3Vy?=
 =?utf-8?B?M3dPdTNIYVdpQ1RacnQ0NExHV2pJRldPVUpZbDJ5dVNtV0grUFFyVHFuNS9k?=
 =?utf-8?B?bHFoZW9qcm9tblk1SkVUT2RqTUlyQXd4V1pzTjdCcHBNYVBmYzZxcXJCNWlt?=
 =?utf-8?B?RVZIUzVtWEV5L0FwMDFVWEUzY251eE8yVWpHa2YwYUJyWmpBQ3ZDVG90MzVu?=
 =?utf-8?B?ZEdrdXFnampUc3o3cDVkNFJicUhQTEpTN1crODNLRVIwd2FWbmZtY2RlVnk2?=
 =?utf-8?B?M25aWDFHWS9CYXkrME8zeXZuWU93dDdna3ZqZ3ZaQ3p4TDdVaTR0WEJickxq?=
 =?utf-8?B?ekZYRzZyTGMwSTBnRk5CeTltdjl0Y2tzR2t0Tk1FcWI2SmUxMm5DMjhBVno1?=
 =?utf-8?B?b3Y2TURtaFpzS0RXbTYvSnFKOStxS1lIaFlvd0VWbkRwZkRQZmd6Q2p3bWVI?=
 =?utf-8?B?Z1o0OGxjd0NaNHFaOHFmUXR0c1ZKTGt4RjVnbjk3bld2VnNKcFlPbmJRUjA5?=
 =?utf-8?B?MnA0RWlueWREN25jb0FKWFpGNEZrTnNsaUx2QUkwczc3OTNKdmYxTVhxWjFI?=
 =?utf-8?B?U3JwMkRnMkNFTnZNdjRGSllXNGxpa25sdnVmWmh0SUluSW1nMml0NDVma0E0?=
 =?utf-8?B?cVdjTmpnVU1UdGszeTJuem1Dbzl5YlFBZFlQY2dLWE1GVzZKbStFd0FwM1dj?=
 =?utf-8?B?T0JrL2RIOU5MN1dhZjUzYW5iZW85anZZbjlIY2xjaFMzY0NzRGFPQXVEUlBW?=
 =?utf-8?B?QmZaZzdySWVNRnRLUGhOZEludGZ5dys4OU40MmtQdkpTMEpQWnFIVHRHUHRy?=
 =?utf-8?B?VWVCdmpvc0ZDV2YxUmxEYVZ3L1ZtTmxCZ0FPRW9tMjBZMXE4dUZlMU5zUnJv?=
 =?utf-8?B?N01Ndm4zdVZlN0hrUk1Zbi90Y1RhRlFjZGRYWlZzRDNMbzV3amNMYlBuN1g4?=
 =?utf-8?B?SnNSYnc5Tk40ZjhESGFQZC8rUTkzbytXKzN2SjhMMFllSW02NVFRRnFDZGs3?=
 =?utf-8?B?MnN5clFsdlZNSTBDMm15N3NZbTBpRy9NWlk3SUZHdC9vbFFWSnJwNFY0UGpM?=
 =?utf-8?B?ZmlpUDRYUFBoMUdHY09wZlZJSE93amZwK3FNWlVRS1NwdGZldGtuSStLb3VX?=
 =?utf-8?B?UWFmazh6WUR2TlNqTjQzOVRaTFh3N1pnbGIvZUorT2JnWW9zdldjdmsrdVJv?=
 =?utf-8?B?ZkdHd3JZNHplLytOclpjcElYdXY2b2RNQkYranl2eHhia0hlNmhVZy93NFVj?=
 =?utf-8?B?RkFzeTQyUUp6RDJWd0FNWXNObXZUSks4aWFnQzJFMzVibERLbXB4L0ZQaG8v?=
 =?utf-8?B?TGRwZzdoS2VGbUMyRHBRbm1YUWVsMXdLRTR5SE52a0ZVNHZrNGFVTEJEdmpV?=
 =?utf-8?B?QmtjVTkxY0p3eGVPNVh3dkNwWmZvVHJDSWcycFR0OTluUVVPTjIzS2YySER3?=
 =?utf-8?B?RUhjQzdkdWdDdmdXQUtML0lUNmVkYk9IV21HWVVYeXFNWGJRWWtTSERLY2cz?=
 =?utf-8?B?Q1haTHFMMU9pSTZCbFQvZ1FqbnU2WFUrSldkUDQ5MVRadFJySWZCc1VqUXVm?=
 =?utf-8?B?U2FuMHpWZjdqQnFqL1FYQ1d5UGt6Q1ByWVptRzk3dkw0TFEvblEydGVua3Jt?=
 =?utf-8?B?QlF0N0pJajIvZ2lSaG1YaXJ2S0Rsd2d6WE84U244VkErOVdPN1YvdWRpMHBL?=
 =?utf-8?B?QWpuOXA4UC9JMlpDKzhDLzRvUFloVGJoZlZad3JXT1B5bTBOS0EwaFFMRnBK?=
 =?utf-8?B?NDVCcUluUTRMRkpYT1hldz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9193.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDZrblZXWHQ5aCtFU1hmanp0UTFBdFl3T01nOXFGSzVtb3JzSmVwZWJpT3JG?=
 =?utf-8?B?MkNMcXcxRE5OVExEdXdjbStXM0gyb2llQU1HNVhCZDkrK010NndrRXFYQkJY?=
 =?utf-8?B?YkxjTXk4aStHVkFCQm5Xa2VvUHNqclpWSWNRcnZxU25HTkR6aXJzUCtxREJE?=
 =?utf-8?B?MVdjei9nSkJDVDBJWVhXZUJOSWpOYW5QT29yMlNXQ2loVnVMUWU1djYyaDVL?=
 =?utf-8?B?dEMzN05GTFhvZ2xrVUhRWWxiMHVGcVIrVC9IM1ZhRGhGZFhRTWY1Y21ZUFo4?=
 =?utf-8?B?ZlB2Mm9zZ1JndGY0T1k5YTN1c0o0OG9UbWUrcFJlbE9ib0hER2xuemNaZUVV?=
 =?utf-8?B?dWVDNFlGRk5zd0pTaGZWdURoVWdTcWRCbm1IWDZQeVdaUmlndGNqMlJkMU1s?=
 =?utf-8?B?L3F2OVJTZGJBMWhYYTdPRGFQTFlQdFFXRkYwRHBvM21TSXNVNzdVVmdXc01o?=
 =?utf-8?B?SnJVaDRtc29PL0R5N1RRRmJjTlhBc1dTZVl5N285VE0wQnZBVU5EZlZUbW5m?=
 =?utf-8?B?R3NsdlBxdmdWK1h5UWhsbFhDbENJNjVDUGZjS1h4ZHJUaDBxb2tGbDJKVFdE?=
 =?utf-8?B?dGtvNTF1VzRRcjZtTDV5ZlNxTnNRRzh0WU1naXZvcjhCMlpMbWtkNDcyanZK?=
 =?utf-8?B?WTFHMXR2NnpwZ2ZpVThHSGszTDlyeWZJcnc3bDlhdWR1ZFQyc0FMWmkrdHoy?=
 =?utf-8?B?b0dDMEhoaXlJaWEwczJRTmt6a3Q2TEhEczg3NzZvMDFFUjZyRURid1NKN2xC?=
 =?utf-8?B?QkhmSXNCWXVyWkFveEtJalp1ZEtMbkRiRHE2WDIzUWVIMzBYZ0cwN3JwbENC?=
 =?utf-8?B?REo1cUlZbkdBWi96ZTkxWWFid0hIUFBBRDZLZDdIL1BxMTd0RExjUDFDVUY1?=
 =?utf-8?B?Y3UrOURWdi9Vb3ZtYkFyMWhuUzAwZGRmaFZLQnhNTzNpVkVXdTZ3eHprSVdR?=
 =?utf-8?B?a2lKbVZLd21uMCtLa2dXQS92dXZLOG1iL0k5a0Q3Z1B5bVR3T3NrTTk5V2lr?=
 =?utf-8?B?djFkTG81azVmeVZIZ1dhV0h1clpaM1NlMnpKcGQrdytWM3IzbGpqRC9Tb3Zh?=
 =?utf-8?B?anR0Vk5PaWJzME1aQjRZb0pFVmVDUVpSRnREcTJkbFpPOGl5aXI3ZXRNOTBu?=
 =?utf-8?B?MDNPRE1MT1FTdStMcVBMalAra2h2UnJrUUxYbGtqQ1g3UHFDRFlNVldmZm1p?=
 =?utf-8?B?Y1NSeVpqU1ZTbE1mOHJXRVp2LzRvREI0bDRnWlZSVDd3TFZ3ZDhpK1hBamhC?=
 =?utf-8?B?S2FGVnlEZG9NSU5TYzRnbGVWWG5NSnpySTAxR0Y5eFdGcmtYOGltS24wUGh3?=
 =?utf-8?B?RS95Z2V6Q3JVbURjdWxBREczcHRjNXlCYzdtWWtIV3BrRFhYODZtYTV3ZjZV?=
 =?utf-8?B?WGZ2b1NnWVRCcStCdFd2US8wOERtcUt3QXlvbCtzTnFzMHpQc2VPclEyR1pI?=
 =?utf-8?B?dzJVNGZIelk0bVUvWUwwNWFyR0FTMnFJNDVpTjZBUTVRdGNjdDZWa2hHUEJ1?=
 =?utf-8?B?ZDhUY1NrUzVneXE5K1h5bktMbXZaWCtBci9raGxGWWd4VUIwamRFQmlxSjNs?=
 =?utf-8?B?WkNxMVlYdEtjcVJsWmp3TkVYTlBqb3pWMTBNVm5aVFBvemlvSHBWeCtza3BB?=
 =?utf-8?B?WUhNNnQweFVFMjZRalBsWjhlQ1N4RmlVK2l4MlNQekcwTEVxVlpISzNGOE45?=
 =?utf-8?B?aHRDdFFJQWJtZUZzL09SNVl3K1I0V21BMk5OWFFBTituTnRnTzRjMWltcG9x?=
 =?utf-8?B?djlhRXREcWMrNHYzWlE3NFA5SzdiT2JTKzJyMHRaSWFRNGJBMWlYamVWQmY2?=
 =?utf-8?B?UFNoNkc2andyc1B0NHhhWGlGeVRGSWFrTURHL3QzRVdTUG1GeDVaR3ZvMWdK?=
 =?utf-8?B?enlJaUpxdHVNWTBaRUNTQlRydUNlTXFrdk9xUjJGMkF2ZVpFd0dhZ3J4aHpl?=
 =?utf-8?B?bUh3eW1oeWpmb2YyQ1dnNXpHTWluQTZ1VUt1TytlbkdEZnB1SllwNlVnbUp2?=
 =?utf-8?B?OUVGTFpGRTlmbG9OdVVqNlZhNDhoWmNtYTFDdFQ1elI0dVFFeitUSllCbVBz?=
 =?utf-8?B?L3ZIUW05b2Z3cEJtRm5ZSlZFcHdta0xXL0NmL1Zjdm1ieU1oOG1KdzRyeXVY?=
 =?utf-8?Q?a7cWP2jztPWRPcEo/0W+PXoqi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a155025b-0a6f-497d-55d7-08dcaa06e472
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 04:29:36.0078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PFyF/j+yuzpUnzzTDkO9fspL4faR/1cgedqNDUkL0jAwpQtG51MxkZKRz9c7Ce3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511

On 7/22/2024 4:17 AM, Dr. David Alan Gilbert wrote:
> * Gupta, Nipun (nipun.gupta@amd.com) wrote:
>>
>>
>> On 5/31/2024 5:04 AM, linux@treblig.org wrote:
>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>
>>> 'cdx_mcdi_copy_buffer' has been unused since the original
>>> commit eb96b740192b ("cdx: add MCDI protocol interface for firmware
>>> interaction").
>>>
>>> Looking at lkml,  it was used in the V1 posting but was removed
>>> somewhere before V6.
>>>
>>> Remove it.
>>>
>>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>> Acked-by: Nipun Gupta <nipun.gupta@amd.com>
> 
> Hi Nipun,
>    Do you know who would pick this one up? I don't think it's made it's
> way into -next yet.

Added Greg k-h for this.

> 
> Dave
> 

