Return-Path: <linux-kernel+bounces-554453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D01A597EA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92161884F90
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5A722CBD7;
	Mon, 10 Mar 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uCZDpTK2"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92E229B23
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617591; cv=fail; b=nIwSoTpw/TgBlggSzuNnCjF+yU6CLqO0CS2R/FvYqEW3PzdJejAyN2hrucmLDRsxT/K8tdTvOwinxJg1ysFJCNPtXPqVdNjDJQerJYzU1AasFwmF+YbSsjMr5Zz4X3vp8svmDINbgOzSpgfTt4woHEMSFGBYSjk0AuLUgRDyH/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617591; c=relaxed/simple;
	bh=+PnJxsya/iCEVj5+U2j/kFyqcBxwctLgcDQIVt67Z0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gQv6/eYB4twJmQ+LFLFC7xh2QVVYELmJD2K6V+rM1IslWdF5jq77CL+Hn/43IOl/lTsL7X36uP25v8Lxy6R5Wqgq78n2mAdoBoIHogtp1MgCdjXmyfQxNZ5uQVS2CJFr30qgMT9RO+jFnDVpnQToBGjTlu3psWetQiRi4QF4mg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uCZDpTK2; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiW8fJn/yW3xMzYOve4iJK6ONzDxGpR/Zl7AwXucB4BAPkLUdsz3ua/tkuDg/kseulZZm+xPDBHsa/LtTGSCaoAmt8Fr6yV0fZtfuSEq97Yen2exFHKb5QxGBR0Oo9qQ1G1NQEtKImaf3sGeOU5IyJM8lj+r9p+KzviUseAVJFrsGVpNZZyJzG3MiLM7E4K9c3yrypq3eterubH0MGj/W7O5NdsLxy8FnlPkQwVZ/AkTOeROKGrQ3T56CC2INU71ue4416RYgjXnff3DGlmuyJFitAwQPm9s+Pw/YX4ixwP6jhhqdC6D2xMrXnGSLhXJD/uQ0O30dyhUdhYqNoysoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OccPyDK97DGuSYVOpVnL9ICvnRvOFiA1ghnsKJvtcCI=;
 b=r28hjQl8Ib0sPpo8liUuxWrX41hpo3M1iGBHQ1YStkEU7rQQ0EQQilY8HJdF6nKbkS1NTH58sCFpFy7v3pWZ74CJaZiYbCaiK8zqGzBSqIqbwvWAvi/aVnCa4jcenjGVPiaAPZ68fy0pRMBXRKgX206iMcF3D9ZZ6MbZ8UjCfzGq6y9Xiay90REHpgxH+T2TK8ja/0d7ysg70gZC6P0mX1i9SkmBB//X8b315pQYxEdsDZgPUKhd9rRVta2Mkhx6vx2aS2hLfIvefjN40RAsGGr79Rmb4NfGL/qgEk/RXuord8ebSa6uu16fmI7LBbI6SdzCClMvIlUbBNgLRGFMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OccPyDK97DGuSYVOpVnL9ICvnRvOFiA1ghnsKJvtcCI=;
 b=uCZDpTK2Hb3Fcn8/4uocuE5gVW3MWA2MJirR2l7hUV2JFGXclKse9lyWX7nIu8/8qztyl7JcKgIaJOW8b8IJcq32LjdHP5TC4gA1MFXVNSN4soDcpFWfWolPVj4d7CSQaF/yKsNgFLKPbtfXgaHUaQlb1UjGmVC+WVCsVOIaBLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 14:39:44 +0000
Received: from BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a]) by BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 14:39:44 +0000
Message-ID: <778ca56b-7731-736e-1d0a-84ee2b2c261c@amd.com>
Date: Mon, 10 Mar 2025 09:39:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>
Cc: Joerg Roedel <joro@8bytes.org>, Alexey Gladkov <legion@kernel.org>,
 "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
 Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
 Larry.Dewey@amd.com
References: <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org> <Z8l66FFgPu5hWtuI@agladkov-desk>
 <Z86-3n1-MArVLM9Z@8bytes.org> <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com> <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0016.prod.exchangelabs.com (2603:10b6:805:b6::29)
 To BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b8a749-504d-4b5a-befa-08dd5fe1662d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3dXcnE5U0NocGVyN3E1Ui9JOWRWWVpPRHpIRlg1dTdsRDhZRWQ3TUxiTWF3?=
 =?utf-8?B?dktTbFVFb3c4QW1WdVVDVHNsYnA1K29jSnNNMy91Q05KTmZlTkp6bFlPRW5U?=
 =?utf-8?B?djExamo2VTFPYXlTSFh1VHlGcXJ4b2cxZktDVnplek44Q3h1MEF3TUVPSTBG?=
 =?utf-8?B?OVZmWnNMRHJXVit5OURCU3lvTjJ4eVAydnZzVHdDb25JZjRGc1pqMTBJYmRB?=
 =?utf-8?B?NGJpYjZmOTl6UkV1a29CYVBzakhibkdkVG1udEFaTTI2RGxMSURWenNqRVd0?=
 =?utf-8?B?Tk4rcFlYdWNBRlR2a1hzNGZpU1NaeG9yeVp1WXNBYXVTb1hSSDg1bkJCZ01h?=
 =?utf-8?B?R01BNjEydi9MWERWMHlaSGYwTXpmNUh3bGFHUFVieEhCTGI1eXR5QWtNSFBi?=
 =?utf-8?B?QlVGaFBVd2trUGh2WkhXOGJrQ2ptckh0a2FUdElBbDFNUURNcTBmcUxVWHZ5?=
 =?utf-8?B?TmN1MllHbzAxVm9BMGp2aWxocEp3ejF1bWs5aXNEMUkzMTIrTjJpVmUrdDZp?=
 =?utf-8?B?NTRmYTUwMHZ6SWYvUGR2SzA5QW1keXU2R2hHRVRELzZ2SlBYSVkxVkJvQ0lN?=
 =?utf-8?B?dzByOGZLTXZ2TEU3ZjlhZlFlUkZTVjFJcDA0ajhla0lUWnZBTlR1K0ZOSC9O?=
 =?utf-8?B?VlhZeXJ1Q1l0Y3ZHelFBa2xueGxwdHVjYW5VVDFqUVd3OUFFVThmSWdRRlJi?=
 =?utf-8?B?dEJ0QWthd1h5aVlydzBiMWJuSUtjSUxpb3d0bnQzL3Z1OEdtczJOY1hEbkM2?=
 =?utf-8?B?alkxQndlMHcvd2I2RFpnOVByWGcvVXhuYklobXhXWVhKNjZNSXVCWUt3L1dy?=
 =?utf-8?B?NHJXVFNZZEg0RGdUTWNpZFQ4YlV1ZURNalQyeFZaSHd5amcrUERzZ2ZDc2NU?=
 =?utf-8?B?MjQvQUMzK3NLaFl5eVZTc0hIZ3drdDlrb0RJNVhHRWVYWmNFZzA3WFFlaDhw?=
 =?utf-8?B?MVBaVy9DS2hTSGZLSERldEJHeWFRR0h2THBuQzZJQ3dSbGFpU01rQ0VJSXBX?=
 =?utf-8?B?V0EyQTNmRzJSR1dKNlpENE1xOEFxaFVubGhvam8xbk82OGtFQWo4cWtBTCtV?=
 =?utf-8?B?YmdDaXNpRjB4UlRwNUtPQ2p6Vk8xTUJJNkVvVkNaVlFkeGNGZjJOL1huRXJv?=
 =?utf-8?B?ZnkybVBZUk1YbUNUT2xjakhEc0Y5NUJKemh0ejNmR0E0cHJYZDZEQXJSSjkv?=
 =?utf-8?B?bXNOQ3F2bk9hUXcvejdpTnFaem90emlKWDI0SUJvY1JwSkZONDF3eDFuMTVn?=
 =?utf-8?B?SXRRU3pUaWZuL2ZkSHUxVFRiRWsxQTVwRjd2UUxwOWJrVzAwa1BtUm9tdzZC?=
 =?utf-8?B?dkpzOWdNSktWVEQwYU9wZElWMlpCSis3ZFBIcGllWkY1QUJEb29jNUt4R1FY?=
 =?utf-8?B?T2V3aUl6eTRTL2pYVWpoWjA4WmpvU1o2US90ZU1tN0dScGIwakdwN3N4OUYw?=
 =?utf-8?B?YlRpTU5IbHFxenFjUEtvTHVIZ1BLK1RPZGVQd3h2dzNUckNQZ0Z2cUhNOXFq?=
 =?utf-8?B?Sis1ZDFtRFRvZjBPVmZuSDZzWW5HU29hVFVHaTlUYVY0VGdQcUp3SkZTbUpK?=
 =?utf-8?B?ZlU0eTBCQ1hpc29MREQzeVdGSVN5VGluZEU1YTFSM2NEWjNabkZEc0Jja1Bq?=
 =?utf-8?B?OGZrUVEyckFJakRObFJDUTVrdE1hbG5qUHhqRG0reE9DNnByUnFkS0ZoSUxs?=
 =?utf-8?B?OGdXR3M1ZVNKOGM1aTlVdDlTM1NFbkkxVC9uRVUzdUcxUkhOdWpwR21oRlhZ?=
 =?utf-8?B?YlBTeXZGRGdOTmpWb0tyZ3Q3MTlyWUwydndYTjNPMWdsbVRDWkFVNHVHMzBz?=
 =?utf-8?B?SWhMaHZuTi8zbE9OaVZVNXk4d2doWFEzdFNKVG1IMjBOVVpCckJ1OWlSRUQx?=
 =?utf-8?Q?s9F5EZ6jkGHbL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5062.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVRHSHdvWDJ2NFZLL0lncUFlS25oN3dQZWxuZ2prMTZpMlMzcnFONStiWEZq?=
 =?utf-8?B?Q1FjZlRBajRIck1LZmpXdEVyR1RMQUt1ZWxPbUx2RVArdkhCc2x0Unk0R3pC?=
 =?utf-8?B?NGRsYW5kRk4yUDJ5R3lLVFdzN0wwZ1lOMVdWd3dyQTJaYXZDS1ZkODkrV1BU?=
 =?utf-8?B?eGZlc2IwSlRxOFBlV0d0QWVubVpzRjF4TktVaDVKZVhjdG8yR0s1TjBEWnAy?=
 =?utf-8?B?WUZydlUwUytzRjJ1WGJuTWZOTi83NHpVdSt5OEpmeVNIS2lROFdjV2tFUEp4?=
 =?utf-8?B?MFMyeUtDczdZcXlXdHRNU3QwYTFlUFp0Y3ppWE04azB4MTNQNGhHRkZjOGwv?=
 =?utf-8?B?SVFTV0o2ekFWLys0ZFV6ZHJkQ21xU2piUFNOd3N6cGZaUWVmcUFkUnpkeGNK?=
 =?utf-8?B?MHh4ZVdtTUNrK2l5Z2t5eUtlcmtUUFN4a1ZVY1p6SFh3MGpoWWJIdk9Fc2Z6?=
 =?utf-8?B?SnowUUxQYmJmZ0JERUpOcmVPbkVnOWVsRm1kVWhKMG0xR2gzTkR2S2E3TUdB?=
 =?utf-8?B?Wll3d0xxcHpvTi9WNVRvZkNmSFlnZTFucEZHVWJwK09CMCtiT0FLMnVXS0dD?=
 =?utf-8?B?VUtFcEpWdEUrVmhES1Z5TlpqS0pBUEZTTFNjcVA3VlUxd1Z1UWRpRXpRUjVG?=
 =?utf-8?B?R0hxdFNQbWg5czRza1pQSXRHNStCNE1qY21XSW04RktjRENxOVJxb3hVY1h3?=
 =?utf-8?B?dDdDL09sRVZMRTA0QTIyNURvVkR5bXJ0ZEUxa3B3azZZUzNNMDN3ZUp5aXln?=
 =?utf-8?B?aWpYdUZ0OGExcGV5bTFEeGhrUTdMV1lZUmIzcVhuK1dTdjRXcFhkQTA2NG5Y?=
 =?utf-8?B?bDRyaEtqMXRSamVJdDhtbE9hcVNrMFUyTXIzMmF0UXJKQ3k2bEd3QWJFL0FF?=
 =?utf-8?B?SFF0ZlZabk8vTGVod0ZVeU1KcVpFa2wyc2QxdkFYeDNzRGtBbDZSNExtMmJk?=
 =?utf-8?B?cHVKWmtJaVQxSW1nU09YRXNRODdNUnR3YURpZE8zS1JMTnYxREdrL3lhNC8r?=
 =?utf-8?B?SzdKaUZJWkg0NUw2L0ppVkpVL1VGSWphajFQWG9odVpHL3d0QmVwaFpCTnlJ?=
 =?utf-8?B?OEtQYWc4Z1VyWkVFVVFzM1RUN1pmSjRRN2tHUEpBK1JsTnNZU1JGd01GUWdq?=
 =?utf-8?B?SmVZdURrbVBYbzNKMGpkQVlvUUV3TWJNUlBlNjN2bnRGcXlWMjEwQzV0cWN3?=
 =?utf-8?B?SGxFVEgzeUdhUmhXNjRCbVkrTVZRY2wydmVSeEIwMVB2aWVWdW1JRTJyNFRn?=
 =?utf-8?B?YWxpZW5URkU3YTU1alhJeEs2RE93WGgrNWpDbEw1RWlidWVXK3lYVGxlRHlF?=
 =?utf-8?B?YUJFLzd6WGs5ZXhlSlBueS9BS0RzbC9oNkVWL2l1TGFsdHdOcUo0QVhUcGRW?=
 =?utf-8?B?T2lKZ2JhQTlvLzJ5SERqNHppaUlteUcybGRITGwwUlVOTGdRYmZVdnBOeWVl?=
 =?utf-8?B?Qk05SGk0aU9ZcnZpQkQ4bnFEamRkL0JQREtpMmU1RjhZVm9NbDIyUlNLaDFn?=
 =?utf-8?B?by9tdEhjUlZMUjFENmwzUEdkbGE5aloxT2c0aFV6WDA2NHB0VXlLejcvU0Vj?=
 =?utf-8?B?SFluYmpGRVp6TVg5TWpJdkVHMjBJeHVpdDh3WEwvN0ZVbUtKZXRySEFabmVv?=
 =?utf-8?B?MUVOd1FOMDRyTzFMd2t0Z0RjNnVYVFdvVy82bEdhcGwyMHR3M0xNKzFUNFdu?=
 =?utf-8?B?c0V5R3k1MEJhZkU0NmF5V3hFUHNrM284U2hDc0FPL1lMVzl4ZEpDMFg5Q1dp?=
 =?utf-8?B?dzRTT2hobk5aTERWUnV1c0p4azY3MlR3VGlKbnozQVdwMmZCOVl1TEpzbENy?=
 =?utf-8?B?MEQ4YmxyM0dHT3hzL2lzQ1JYOUZRaXlQNzB5d09HRXpqaXVaenFCdjZEVkdG?=
 =?utf-8?B?Rmx2N0M4ME55UVdqdk50RStuZFdOSHd4TmczZUhVNGRzSDFBTUNKVUFSWXRh?=
 =?utf-8?B?a2NyN2Z3VWpyMTBkUjVjb1AyOTlCbUoyaFVaS2d4TTc0QW1wZ0F4U0QrZVZ5?=
 =?utf-8?B?NEVadmg3QVBaUXNINFRLbDFYK2RhRjZHd3BrN2lpeWlzSnZyY2w5Y2ZXYjc5?=
 =?utf-8?B?c2djckFCRHZXTEtrZmNSc2I0NEMyZXlrSTBaV2YxSUFrN0dOUTJqbzh0b3R3?=
 =?utf-8?Q?BL7rRxmxXSgkWo6l97qyIoBe1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b8a749-504d-4b5a-befa-08dd5fe1662d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:39:44.5546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxSjW84h3KbMgrif+dnOKOvqN4a48xfnBRjR32mCsIPD+75g5sbg/Cs8/QzVAPw0/mvmLwt9JLmVeq48dGaq+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738

On 3/10/25 08:38, Borislav Petkov wrote:
> On Mon, Mar 10, 2025 at 01:49:46PM +0100, Juergen Gross wrote:
>> 1. Only name the hypervisor nearest to the guest (similar to running Xen on
>>    top of another hypervisor in nested virtualization, which would still
>>    say "xen").
>>
>> 2. Add another entry for naming the outer hypervisor(s) (if possible).
>>
>> 3. Name all known hypervisor levels, like "kvm,svsm" or "svsm,kvm").
> 
> /sys/guest it is then.
> 
> Let's just keep /sys/hypervisor alone and as Joerg said, we can link to it
> from /sys/guest.
> 
> I guess that sounds ok...

And we should link the VMPL setting currently under
/sys/devices/system/cpu/sev/

Thanks,
Tom

> 
> Thx.
> 

