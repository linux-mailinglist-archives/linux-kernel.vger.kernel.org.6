Return-Path: <linux-kernel+bounces-329626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C1F9793BE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 01:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958771F222A3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 23:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233F2BA49;
	Sat, 14 Sep 2024 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0WUpJpAv"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2BD143C72;
	Sat, 14 Sep 2024 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726355584; cv=fail; b=N9qvdHId+Bq+jV5Lzeftb4xmcEo2XFW3wFgs4F0iIKaJgWDIX+b4WajI6VWZ84a/XM/vPG3KcwIRjmscsfN3IvReuUyDMofFVbqKZHYqPGua1S+RY8IEjRdp4zavgW8ZIq+1xWN6nwuPmRjV0gprF6WEe3cYz8h3OZZzph+Myhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726355584; c=relaxed/simple;
	bh=qDHOIkf90oPu35+GfNvshCkE9wuPfprx/2Fi0/+mwFI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AyLPJYyd1DMXaQGDJtLapX1rbHDryAxDflYoHMyx+LEBCcSG9199OW9OjFnQXs2Ay96lXS4nuxwJ7QEGc6KSh/ixcg+JpIg+n8LWqRfOK9ux9IKgCAd2cIo/eM+rp2AmYfd+sN9blJTZ+Hce0bjusLfnKBSkfyREbkEowH7K5yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0WUpJpAv; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ym2UUIAe9Pt8b9abe6BEB7Aebjy+4KzJ0LdpzSHJlhG7xIoYhJ58XohxY/mC7GNbyjHtAFjixXl0W4q6jJwSup0aGtuHlDkBj1VSxPIvOYL0UiVpYWBGlg1+fnT5dmHBfTiX3Kv3+m4qBvxRYg9ABWVt503PfPkFnBcElrfomfAxVeuFGtRTWOSgXdXIskgcstGwK1e83rWaB+kLUkrOAWs7qn3mQy97C0fmkYy5MdBXrkEGEa8yHkTe174G5PlcJP/fOjhxlG/DBusqM/PIa71okHtoY4Gl39yBpeaZchFolGAMUkWZXGiLWKcMJLSPoMa9hyLENgUjtpLMGiZ/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq1Ckxz0+R2yyQsdwcFfCSEEMGivgpkZcr77I1GE1fs=;
 b=p+g3ikKjP4zqIM38YxHh8/bzpyicqWSEbLxG+VoOVc7zeULv4YBmO2gjVyeARCRC5/N5THe5GxnratjLXfStp9aFa3cl5HlHGOKnv82NQJ1XjvKebsu+JVbosEKGkHX81BqvXj44Hb3dBipWhreTShPgeFNLM5YbW+ZzpRCRIHU1yXe7q9upxgS4pCoUwHlHk7R18XDQNT3XAk/ZqueEtlusC9NKeHnBtOpjXsD30sywxCQhvH81/1c8Up3FRAJI5BI+6unfOP/iutB3EUiPDfVee8WlLwM1myh/Vwge9T++4ndI27ONmq7eeZtY6gMNm8v9feZvrKchkCbSqBePFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq1Ckxz0+R2yyQsdwcFfCSEEMGivgpkZcr77I1GE1fs=;
 b=0WUpJpAv5ltC9o0y7JaOFKmq9urX8TJJqRq9JpXWrUZ+ImMnKAjgJadqkm/j0H6A12RMZjG/Q3FMX0qITYHSacMzdiDThQOU8jlI74B+DSTydxEq8EPkEDKgue5XO5x6wp3A/ZTZEsc2sLmIPeIxmI2AttevG4PKQ9R/6dJcow0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Sat, 14 Sep
 2024 23:12:58 +0000
Received: from SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2]) by SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2%5]) with mapi id 15.20.7962.021; Sat, 14 Sep 2024
 23:12:58 +0000
Message-ID: <f1f8e625-0771-4d25-cb1f-8949ad264954@amd.com>
Date: Sun, 15 Sep 2024 04:42:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Eric Van Tassell <Eric.VanTassell@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20240905143056.48216-1-papaluri@amd.com>
 <20240905143056.48216-2-papaluri@amd.com>
 <20240912112847.GGZuLQb4Z2Vvor5-JM@fat_crate.local>
Content-Language: en-US
From: "Paluri, PavanKumar" <papaluri@amd.com>
In-Reply-To: <20240912112847.GGZuLQb4Z2Vvor5-JM@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0089.namprd11.prod.outlook.com
 (2603:10b6:806:d2::34) To SA0PR12MB4447.namprd12.prod.outlook.com
 (2603:10b6:806:9b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f0bf53-3489-4a2a-5b6b-08dcd512c541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUloa3N0VnNhQWREdklwSmR5ZkFqZmlNZGdHdUtiRVBVdExsTXhWMWN0WTQ3?=
 =?utf-8?B?TWpaNEpBdEVsd29JN3ZUMDIyYVluM1dZYzJLRVpENGxFR3BJa2RBUEJSOTBK?=
 =?utf-8?B?NlA0Tmw1N2pVVVl3dDJPQmRKbm5qbEg3WEZrM3RJanZXWHNtWktxLzJTamhE?=
 =?utf-8?B?bHU5T2VkV3crb05wQXlYV3ZiMGFCbUZLUE4yOFNSTUdqeWp2N1hvZ3k1ODFO?=
 =?utf-8?B?VzJFYWZYZnRyRTFoYnNlTlZpa3hzWVJhNVF4eGhUNjBBUy9Mc25oaFJCTy9Z?=
 =?utf-8?B?NmExY0E0WTV4eE9KYnZlYlI2UUhQWGdvY2tnTVVZQTdNNmNOZEFyNUJ5V1hE?=
 =?utf-8?B?THBYaTlvWGFpai9RY2lhKzJ5djAyQUI3TUdadzVYYnFBaGdQV3dFV3BDdlRK?=
 =?utf-8?B?YXF1QjRMaEIzTENXYjZxSEM5S2pXcGNPblRxbWMySDY4eU96TFlHQnFZd3dL?=
 =?utf-8?B?aXg1eml6UlllNTE0ei9xdTNkTE1mdDJaRzZIRWdmQzJHeWtLd2g5ZndFUEZQ?=
 =?utf-8?B?VXR4U29ubGM1Y1dId0dLTDZsWURzTzY3ck03ZktQTHNlWmZnV2lRd2VqdWxq?=
 =?utf-8?B?dU04TmZva05oVjU3bmpOeGdBS3dvS21HZEczQWROOERXL1dOajVHY0lDRk1v?=
 =?utf-8?B?aUh3WmFuRjZ3cE5FNXNIcHkvbEVPQm9QUE5vRU5sYnhBNkQxRXNwWk1QSWFt?=
 =?utf-8?B?eURjcGJGbnprU04rZCtZZVhDQWlQSzQ2NmsvSmFlc2pWMml4cWFTVVhRY0x1?=
 =?utf-8?B?SlVJRWE4bDhXVTJoK2JneTRqQzY2Z1MrckFQTzd5RjlYblFjdkZpcG5wazlz?=
 =?utf-8?B?cEJwaDhmTFNBWHBzL1lCMVZ2M3JtaGJuaFBDaGxTSzU0RDVOTktRQzZoNmJ1?=
 =?utf-8?B?RXpOMENRaHgvQXBRcURjQ2VZUjE2TkFvN1U1ZWcxTGs1dUMrRVpNM2dSRitV?=
 =?utf-8?B?S1dDaktFWjNzQjBMaUV2elU2a1pvbi83b3pwajdXTEwrMjBWcmFVdjREOVAv?=
 =?utf-8?B?MnZrL3RGb3RxZnI3OXVpMy9LTUZodFVqUkFjcXpTR3U4RThMQmh5VUsyWHVn?=
 =?utf-8?B?K1FQLzcxWkhxN0N6aWt6dHNUQTlubFFEaHBUUVlTVUZRWm1qV2UrWXlYNmNl?=
 =?utf-8?B?dFRqQUJuQkROYXR4M1A1anNFSTVsWjNiNStRV3R3QU9HN2J2aEV5UGN4dExN?=
 =?utf-8?B?S1I0UzFsSzNnaGNaTlFQMk5aQXoxTGdUaEVVL0Mxa3VQbGhaaER2cDE4YnhO?=
 =?utf-8?B?c3ZQdGJmMVpycTREZVloYXhwSG9ITG1rU1ZHVVl5VExZUTdOWEhXVWxrZ1J2?=
 =?utf-8?B?bG0zVWVoUjAxbm5Jb2wvYTQrZlFGSnM2eTNQMkYyRWFqcEg1eER3dUNtLzlk?=
 =?utf-8?B?anZPU0xrR1lEbjEvTGxHSFdrcmlRYTZrUnFuY2FHdVFCbWx5dVdzaVI5SldO?=
 =?utf-8?B?YjQ2ZzAxODl1KzFmMzQzTCtwYVlaRmV4UDlSWlQ2VkRqa0FLOHdVSnBUUDJU?=
 =?utf-8?B?TlBDaUk2YWNxckpaS1Z3aW1jSkpDcHFMQnYxT3E3U251Q09WNWRLMzZYSWVD?=
 =?utf-8?B?ZnFpVlNHcVZHbmh2REZmZXhvaEd0bVJvSWdWV0I2WHprT2NUd3NGVURyWFpZ?=
 =?utf-8?B?MmFOM1U1MGQ2KzM5c014OGp3YmcyR29uUUNOMys4eDVpMnpSU0lUYWt4bXV2?=
 =?utf-8?B?SDN5UTNVUU9DY1c0RXhsemU4MmZsUjQwYlJ1Z1JsYUc1eHpvK2xqWmdSUHk4?=
 =?utf-8?B?eGc1TUY0L2RvMjA2dE1WVlJGZkpqcDVySHRHa1BUcEVvUTVudUVGNTJBS0FZ?=
 =?utf-8?Q?RLYvdxdfQRH5y+PXthdCa76KqSXxl3PvsIHIk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wnh1eEloWUtWMTNGdHVWSkh4RFYzTGpPTFo3eWdKMlk2RlloK2JadDNEWHFi?=
 =?utf-8?B?aEdlbktwVGllRHZoSzRGRUd3Q2JYNG1iUkZNMGtUVmdndjhhOWZSYTdXWmRp?=
 =?utf-8?B?TkFhaHRXTFBBQW9ud2pKOXF4MFRQWXpDSXZRam9lcEZmeEM5TkJmVGxCRWV4?=
 =?utf-8?B?MVhzT0h2UEFncGllYW9ZK2tBdXdtTjVqOUllOHRjOXRUQnRiRzN3Mm1DdVhW?=
 =?utf-8?B?a0pVTE9IbEpIVWdyYjBRYWlNRk93VU5zcTJKRDlKSlFEeFptSWJZajRWYXNH?=
 =?utf-8?B?WjZKMkRHajlLV0Y2WjRqZ3Zuc2tHK21TOUlIQitCdGRlR1llVXlPcmZDWXRF?=
 =?utf-8?B?UTNnc1V2cUhZZHdkaC8wbEdhTnAwVmdaWmJoYTlWb1FqTTh6OUZISnY1MWxN?=
 =?utf-8?B?TXE2MDNGQ1NVczQxVEh5OWxkYmhmTDF3bnRNZXc0bDFoL1EvWlRUS3VRYStH?=
 =?utf-8?B?TCt1L1VmQngzNVIrUDFYMzIwcVo0K1kyQThMaUtpZmNOS1lxRHBkUVpYTnZD?=
 =?utf-8?B?WUs0RGxPRlRCRjR2TDNscVJGMlhpRGlsRGljaElRRDI3WGR6VXVLVUZzR2dU?=
 =?utf-8?B?RDlTSitnT1M1SXJwd3EraTBBakdRVTB6VGZSUTB1VDNKc0pZeWJHbTNrSUJj?=
 =?utf-8?B?S3liY2JnTE8rNDhpQTlhNmFuekplaXpTaDRRUFRhZmwxODhmVWhadDBtVEVP?=
 =?utf-8?B?dUc1ekpOWXkwRlVkUjJiNDdwODFCYkhJU3hUQ1NoZ0tBeHdNMU5ERC9UcUhz?=
 =?utf-8?B?aFhzeUlMaFBnRzcrbnZvR0xaTEIzY2VhWkRYVGprdldLQzBFUG9YQU1sVWVO?=
 =?utf-8?B?QmY4Mnp5TVhNM0ZWUFZ3L29FZFQ2M01abW9Dc00vblg4YUJmVUc3Z0Q2ZXZK?=
 =?utf-8?B?T2xWYmxBZVZGamM2RGJMSHFRSHA0SUx0aXhOMVpKNGszZDZaSk5tTFdTRXg3?=
 =?utf-8?B?YXpoZll0aFoxMmFqWE5iR1ZobVUvT0xKdkJRbEREbE1VZWc5VXhTZWxxSHB6?=
 =?utf-8?B?QThXT2JXWjJDalV2cHk0Zkxqa0V6R1g0TkJnL0crcmVlYy90NTVpdnNPZFM3?=
 =?utf-8?B?REtXSjFzM0JucDU0L3RnZ21YQ0dzU1NiZXlJQUlNdnpqc1hVWk1od2JnL1l5?=
 =?utf-8?B?QVIzTmtaekt6T0ZIVyt3bnFCUjVYMlVCZStKTFd5ZjBaUkJDTkY5TWdQb1J0?=
 =?utf-8?B?OUphODg1K0xsc0RlampjaHdQcWJyMldMWjlhblVKOVEra3FMMGNJa1I0dFRu?=
 =?utf-8?B?NU9tam9sT3JUVGs1UGJPZml1dng1dUdsY0s3b0JRRFB1WVRRdFo4dSs1elAw?=
 =?utf-8?B?NC8xQjd4dlJtS25qRnc4aEwyS3BUck9adGJIR1JuUkNuVmRZYW4vdVdlTzBU?=
 =?utf-8?B?bEFxbTlnWFRvMlNseVdZbVdyMm1lTEJrOGp1Y2FKT24wOHFOQU9SNktnRTZO?=
 =?utf-8?B?cnlpbjhMcmlsNkZteUMybEVrT05vRFhhMmlCSmtRenNadDdqZGJSL2EwZUE3?=
 =?utf-8?B?NGFwWFlQZWdhNEJZSUlSQWFUVEtSNGpvYzVvOTFrZGVIR1NpUURGcmtFSVp1?=
 =?utf-8?B?REEvYlNVSWlyOGFndWxNdjkzcWQ0d3F5dkEyN1MxTlpBc1JCN2JMMXlkcEJM?=
 =?utf-8?B?c1dwVm5RalhIUFdxVWF3ZDlKaUJRUHNNSS96MGFwZERFa2xLa0N0aVZkMmxO?=
 =?utf-8?B?d0pNR1dmcFpqRWJENkdjeldaQzZ3RXQ4TXJRcjVZWWdIOVNWYzM5TktrajZZ?=
 =?utf-8?B?MkJOZDV4WUdSallQSHhwcDFHZHJRTlpWY2hPUVlVSXpKa0tEZ0pMNFJqdTZX?=
 =?utf-8?B?NjRqTEd6WXlFYWd3WWMzYm83RllzN3lzVkRBMFN2Y0Vhak5FTnl2RHRwY3E4?=
 =?utf-8?B?TzRsbms3eE9pUGdFWVlhd3ZCUzBVUmErODhEMXd0QmJGOTlGSVg0M1lRWXQz?=
 =?utf-8?B?eG9RMnhnS3h0cGxtelpROGxQbE1QYXNGaHFtdXpJUTcwY09MZVBUb2FKeWpI?=
 =?utf-8?B?TnN2TGVkdXNxOEpaUTJUdHQ3c2ZYVXFpVEVWZ2R0dTJUdTR3blpSU0p6YTVC?=
 =?utf-8?B?V2ZGNWEyOFdKSlU3SjlndzFxWDRlazJBNTA2WklsRVl5am9wVld5R1FRSDNi?=
 =?utf-8?Q?1oIcKhFIkG+EGZHWanZdfQdAj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f0bf53-3489-4a2a-5b6b-08dcd512c541
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 23:12:57.9180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DY9xHlLb3mxUGPZPaqDOGfSl0JYiwleOyMO2gt81oq6DEI3XsUVHtPo+IPoPwlojq2hFPYCkdr+iLk2HkaAVeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116

Hello Boris,

On 9/12/2024 4:58 PM, Borislav Petkov wrote:
> On Thu, Sep 05, 2024 at 09:30:55AM -0500, Pavan Kumar Paluri wrote:
>> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
>> index 98726c2b04f8..d3e7f97e2a4a 100644
>> --- a/arch/x86/include/asm/sev-common.h
>> +++ b/arch/x86/include/asm/sev-common.h
>> @@ -8,6 +8,9 @@
>>  #ifndef __ASM_X86_SEV_COMMON_H
>>  #define __ASM_X86_SEV_COMMON_H
>>  
>> +#include <asm/cache.h>
> 
> 
>> +#include <asm/pgtable_types.h>
> 
> What is that include for?
> 

This include was a part of the diff you suggested when we had a
discussion on including only those headers that provide the definitions
for the functions we use. Here's the link to that diff:

https://lore.kernel.org/all/20240829132438.GCZtB2lqeYpleYk9c4@fat_crate.local/

I included the diff as-is and looked beyond for any more changes needed.
Should've taken a look at why the above headers were necessary.

Now that I see, <asm/pgtable_types.h> is not really needed here. While
<asm/cache.h> is needed for __read_mostly.

I will fix this for v4.

Thank you for raising this question.

- Pavan

