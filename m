Return-Path: <linux-kernel+bounces-366183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E8099F1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A9AB2315B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384581EB9F1;
	Tue, 15 Oct 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lC4iQ9MN"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C661714BE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007125; cv=fail; b=kB7KIUtXQjQ9dhP3dUltSpjvsY5ytEf4yoTLpqBS0FWEtknL2DXWNm6DvHYAv2BufWlOME0jRbmhaAzO3Y28U/9p9qkLLHOV2DFcYpIxLmNZeAn7/Fb//xgZ5ittOOz4kakNACjtx5O+8Hz7GKVyhuVhZ0ualqsetncXbCFAXuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007125; c=relaxed/simple;
	bh=wb+dSS7RCQtoV4TeXCrFEW2dogiuHpw2jzQC1wFmld0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=flItLMvZ6Tzt5wjOk/kcCujJzz2O9ZbYeHBlNgsn1q+lL5UUwJ7AYZMWxYz2TSwaCVjIqfD3LMlWyCeSBV7Rw//NIVhUnvFVEQAnPxuaSZ6bbAh1g5ICTRVyf1i/KrmOClEEqvTw0TYy/FHUTjyl0YfeiwGDu2C3oosMiBduKxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lC4iQ9MN; arc=fail smtp.client-ip=40.107.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBGR+W/nj98EZicYFMAF9kxk4ynGMyBIUsVZYu1P2IV/z3v1yfO0Mp3r+EJq8ptANLehZon40ryLTRt9JXtClSAiu5O5yPxVJB9TKxLGbXfqAJg5noPyQWUU5RJAm+ZBM6sy/GBI+UoBaHt0sjqA9j0wm1UxaiFTjWfQ823x2sklJo8tdx2yhKuXLAV2KQ2nnHbxdLKMlFfOjW+70aa5CctLvKPWR83juR/nXHpV8ygBsLAdIZzl95kijH7FgN3sBOfAdnvKuLuFIKCl/rz3xGbWo2i4fOmasvRcnJ0yoQT/APhqIE0Zmkri1x9Dz68lQNBMX7vg/ZZ5Vq1UjrLEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wb+dSS7RCQtoV4TeXCrFEW2dogiuHpw2jzQC1wFmld0=;
 b=OVbfzuPRewse4svowYfaFxw5vAd6fZXKCkKHddLgTmSYnHetJEgar1CAOg4wN52tE//vITV87zGp8uqrMTsTeaRuvMsrKGuzzCWgOXQHEMHbuXkF5CVbpw7OMTG4omLkaBi+6fTVswJuHk9zLEtbEkXoQuaYZa9wXSD0/ajpSnffDOcX3bME1JN51hZBuNkwCPKOVgNkBDXA2yDzXLNSJcQMkl3uamgIkKmzt7rAXpK394ZW31+Wv687W37e6jgjz6XAjUtcKC+N5owj8OPziwff3OKzzQ3ZtTJmH+3ypVq+ivbwfBNAQbVGjfJYnjXl3EaHVQHk0+YRrVJO1mwCNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wb+dSS7RCQtoV4TeXCrFEW2dogiuHpw2jzQC1wFmld0=;
 b=lC4iQ9MNrgW9PjDzwtBc6Uq6EheStPwDyrzYSZS6n6ItOc9lVtKhWiaVXfx3KfYf7rKPItEP9pkTPIyK6imfC/WTtM1pIb/KJZtPfzLEmNXIZdAhZVotf+Ack46HO7yh8gfljIRx4XxaIPdAGuNg/O8OpspuS2RsgpHpnptsInEiyW2jE8ya4DaaK4Bg230uTfQLbx8CGpLpgaLnsz6j7mXVnA3JooUD5dn1iOE4hB/EXRV1lIblzCaUnXPa1ae+kUSMTEA57yfQ1niRJSwUi1MJ44S65w5FUZnHNup+ZdgA01zJOwqtvbi474wVmiD+Kvx70F61HfVEMVLSGs5bbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Tue, 15 Oct 2024 15:45:17 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 15:45:17 +0000
From: Zi Yan <ziy@nvidia.com>
To: Jann Horn <jannh@google.com>
Cc: David Hildenbrand <david@redhat.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] mm/pagewalk: fix usage of pmd_leaf()/pud_leaf()
 without present check
Date: Tue, 15 Oct 2024 11:45:14 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <9D9A6A63-8B74-47FA-B50E-C4A993258944@nvidia.com>
In-Reply-To: <CAG48ez1Sf04jfwWM3J7XFQ2Y_ZP0CT75ASQHuFkgJLdQf2reYw@mail.gmail.com>
References: <20241015111236.1290921-1-david@redhat.com>
 <bu3aq2gxcfkjxocu3uzowvevlv6rgeihepc36cwuhh44xqydkc@3ghgml6xnlgx>
 <ef49981b-b4ae-4a39-bfb2-7c2065d7bc98@redhat.com>
 <CAG48ez1Sf04jfwWM3J7XFQ2Y_ZP0CT75ASQHuFkgJLdQf2reYw@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6684DAA8-7A91-48F9-B0DF-B037AC4119CF_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:52f::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdd9ffa-b1aa-4afc-7ba6-08dced305e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TytTVG45cG8xOHhJblNadWtsZzhOWHhqUXZPUVRxQjBEQmk2SmxyTGdiNUpM?=
 =?utf-8?B?R1VvREp2SkxVckxsUmNBOVJOM0Qzb2ttU3MveGtDQlVBQWd4eVgzVmhka0l0?=
 =?utf-8?B?OGNZRGlQN29uTmRkekdNTlc0ZHJxOXRmNHhtRU1ycS9SMmt6OE9KeSs1bDgz?=
 =?utf-8?B?YnpuYXdqKzhjaGJYd1dJeFExQURvWFh0WS9VOFhjM2FZREI4NzJ2aGNTS2Fh?=
 =?utf-8?B?eWkrWXZ6L05wYTFQSzNMMjNSalVyTTNNVFJxMFVNOEhBUkk2eHhlUWtjTzN6?=
 =?utf-8?B?bGp0a2hOeHlnb2svZkZGVkY3aEVaemNLM203UTh0NERmZXIvSEsyTlp0SzVv?=
 =?utf-8?B?RHBJUHFISWFvYlpHRzlNcUxIcmhkeVZBOWJGa3VCK2NxMldhUW9KZHdTY0VS?=
 =?utf-8?B?WDBxOTB0aTBZSk9HNlJhZVFyTUlYeXFrd1E4ZHgweXdESnl4SHd6Qmo5allR?=
 =?utf-8?B?Y1lRNFVKRURaV3VEbG40QmFqL1U3dm8yRUsrUExGbXpNNjB0WXNhUUhhTDRy?=
 =?utf-8?B?SGdjRjZIeE9RYnFZN1ZWVkpxSHlYYXJtTHhFbXRTc0RMTklVeThXTzZ2QVF2?=
 =?utf-8?B?OGUrRFZZeEZSTGNjK05kempyMFg2NFNkS2RWc015OU9zMW0yVzE0RHdkTm1N?=
 =?utf-8?B?eTkyZnJnUnA1b25nRCtUTHpuY0I1ejZLL2ZpR3BqMEpEUGExUUZ3bFV6VHR1?=
 =?utf-8?B?c0srZmtDVWF5VFB1bzlqSkJFUmg1Ym9FQXFSVFcyUmJqQ09UR2hibklUMkJG?=
 =?utf-8?B?U1Zsa0ZyZS9KTnhpUDBldUFkNU1SczFpSjRDYTFKNVpJa252TUpienh6R0pL?=
 =?utf-8?B?dlFLUFJDcEpwaTVkdmF5cDJsNFQ0TDZzelR4OC9kTlY4M2t1VkpJNFRtWmJH?=
 =?utf-8?B?ZzFSRjlKazBFbDRiYUZTSFFvNlZ0RmducnkvYTFNOHVnejVYWXlPSkJkQmNS?=
 =?utf-8?B?TXZhUzdaRFJoZ1hkTkpZenFUZlRnQ3kxRVgydi9qL3haanZldUZFQzVpcDZt?=
 =?utf-8?B?QlBRT25wRkJQQVZvRTllRVhMZW1PeXc4akVLRWJneCsxeEQwakFiTFBlakJq?=
 =?utf-8?B?QlBsa2RQZ29XQVZzL1RmWERwTXRQdG83TzQvY3ErMUJjWUVUd1VVSXJmb3Jm?=
 =?utf-8?B?eDV4eGs5WmpPU2taMi9CbzNKTkFFMG1Mcjg0VlptRkVCdkFTTTRHMlRFTWI0?=
 =?utf-8?B?azZjN0ZGVWNMT2hMejVQYkFjUytReTgyOU9obG9VVWJoWm1yRE41eEd1U2JQ?=
 =?utf-8?B?TDVQeVJSeTJKS2F6S3llNm5kMDM1SE5BbVpMU1FtZzMwdDVoWTFUN0xZWndj?=
 =?utf-8?B?RHZuZTNZOU1TeE9pU2hCaVJ5VndJSWpQM0dsTlE1WEkrc3JPamEydGdhYlhI?=
 =?utf-8?B?akJNOVF6U0R0SGtmRTRJNlMwL3NyUlpEelJRVkc4TW5LRHJaeEVhSzhCN2c1?=
 =?utf-8?B?U040QkJJTmNZRk4zemZrbHhteUN1a1YvN3dodlNRMmYraUJoS0ZJOGlsck5u?=
 =?utf-8?B?bndzbzhmTXpGMWVuTk1ZcmNoUSs4UjFjQzFmcnlDRHRkblFFUDFpMHE5b3dp?=
 =?utf-8?B?MDlMVlFidVMydXhmYUZVMXdrQXNYaDUzWEJlY01ramFRTCszeGlwWlI4ZlU1?=
 =?utf-8?B?SmFHRHlsaEhINWhVdVVtWVZaL2FINWxqcjd4K3hQeXBvaTFSZEhGL1N4bUU1?=
 =?utf-8?B?VkpGS0FzTzN0VFd5eWpTYml0ejlZWnRYL1hLV1kyVk1zdW00TWhTTmtnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHhuWUQ0L3BGcC9rVjM1K3A4dzJ0TDRYMnNjaEZQUzUxeWMreUhhaEtZSDNI?=
 =?utf-8?B?bnI4Z28ydTZWdlhhZXhiMWtLajI2eEdkLzRlSUxBV3dyUStGTXA3RWtOWXFl?=
 =?utf-8?B?V1IvYUVidTZ2V1lhNGdDZU5rdlJEOGNreVZJUVlqUXk4dzZEeTRRUTNFQm53?=
 =?utf-8?B?RERRU1VXTE9LNVFObTNXY1V6Mlk1UW1nN2R5Qnh5K1dCSGZpR2p4NUFPbjZO?=
 =?utf-8?B?UzlDNVduZW1NN2pRY1pZM0toV0V0aWU5T3FaTzVDUkNReVk0OHhLWG56RG03?=
 =?utf-8?B?VWhNd21SZ2k4cWNFSEtqVFhVWXBtWm8xR0F6Tk9jbXF5RHlQS25BVk9yZUpO?=
 =?utf-8?B?YVdOeGNxTnoySWk2cTd6NE1zN01BT0JMOHhEQTRydFlnWFphVkhVanRpRlV5?=
 =?utf-8?B?c3lXV2R3U3ZzRVcxZjNJendrSmRZcXBlQjJnbWpJd3IvdGpsaGczNFM0bzBz?=
 =?utf-8?B?NmxXL3hsQnJ5d1YzeTNqMUdpOE9nTGlzV2NScGs0OUd2aG02UXcxV3A3OU9M?=
 =?utf-8?B?YmhBVUczT0pNeXJWMWl1MmJFNDdDMEM3Z3VHbTNaYkFuaHRSSmUwek5QVE9L?=
 =?utf-8?B?citrMzQzZTNUVEhWVGlhNmtDU0ZWWW1kTW5ab3RxWkxTc29oL05yK2dzSk16?=
 =?utf-8?B?clVmR0R6dUZXbEI5aE9kVXQrcmhMQlkzVEphc1JsTXZ2cUhpTWZPSjVra2s2?=
 =?utf-8?B?YnIxN2RHeW0rQVM0cHNCdzZQWEFFcVFLSml5eGx5Tm5UWGdYNk5vcXdFWThB?=
 =?utf-8?B?b3NjMG5iWUdYNXFHNFRMb1QrTmN4SXJyYTlMR1dOaDZheXZvdlprRDQxQ1BO?=
 =?utf-8?B?SlVtdnZEZ2ovTFJ0Y2ZHSlFSUkNUM1NHM0J4ekt1YStNc2ZyRlptdmp5UTQw?=
 =?utf-8?B?azE1dTI0K0FwdVpkclhJQ2RHWXBRT2UwWExKQWE4QSt2eFVMNXgwcHZjcjZI?=
 =?utf-8?B?S2FVOWswWkZqTi95eFNTbTYzR3dnZVNnNlpSMWdZRjlCdmQrSlZIaHZIMy9j?=
 =?utf-8?B?Z3p5VTErL08yN09qZ0p1M0lTMEE4VTNRWGV3UzRYaGxJRnlrcGJURThPY251?=
 =?utf-8?B?SDVxeUhqc3lMWnlEdFp0cUFXd3A3d0VZTXpudm1xT1VlYmpEWU91TEJVc20v?=
 =?utf-8?B?VnNzNlFHc2NGbzlsSFFtcklIVnA1UncvSG9yaHhEUFVmNEphTDNMVkZhY3Fi?=
 =?utf-8?B?eTk4U291dXEyRW9KL0lqR0VLU25KZTNGVDZma1JFRzVGL1VFY1NueUR4b2k2?=
 =?utf-8?B?eWluZmpnOGFvZTFTU1BKWGV3bGNQbHNadVRmQVRndWtBUGJxQUFReEdValhr?=
 =?utf-8?B?UjFValJ6MFB0RDZBNUhtY1A2MzlOVTgwOE9mVEh0ZVhDSC96eXYvREczSzJn?=
 =?utf-8?B?SmJhcFl3S0tmRHp4SGo2QllZZDRMdy9QMS9nemhrSkZ6ampMMFZCRHcrZysr?=
 =?utf-8?B?d2VJcjBYNit3cjRtcUFKU3pIZVRFVkEyalF4TTNGSGVIRXptY0IzNzA1eUx5?=
 =?utf-8?B?WXdaRlJ4ako3T0IzRFByV01YOGZoYTh3QVl0Mmd4TWZXU2JLMnAzY0M2VXNa?=
 =?utf-8?B?WFFTWm0wY1k5MGxDTDNMaWU2NTNTZ0dUbTJCYVpMaXFON2lESTR2NmdXVWNx?=
 =?utf-8?B?NEpXazFSSmlPUGxRTkt3RE9IOFp5b0c0c3o4bStHYjJCdHhiRlJmTzNkaTZv?=
 =?utf-8?B?K2JpK1pmRER2MkpMRHR6VWtJYTMzT21rUTFCWnRYNDB2dGlLS1J2azJTck5x?=
 =?utf-8?B?MmtSS2d6VThSek90YmdFMW1sWlBlM0NnY3ViU0JUNVI0Qmd6UkJlTldjVGFT?=
 =?utf-8?B?OVNSTEIvT3VuT1Z3dUJwK3YxcUh6UkEreFlERGVCWGhCdEd2bFU4MkhDS3N4?=
 =?utf-8?B?dnpML1dCRjBJTFdxTUx0bDl4QTF0Vm93OVY4Tld0STJNOFo2Y1RZSVFNUHpq?=
 =?utf-8?B?TFR4clZLTWg2R2xPVHl5MHlKR0RBVGFjbHBTV0VQeElPNk94Y3BIUU5ZNVFy?=
 =?utf-8?B?ODlYTVZFWW9jRElWZEMrdkRsbjJXVUJyUE5GSE11L1IyZDV1d1RNYXl0Umh2?=
 =?utf-8?B?RXJuU05jVmxxMzJSaml4cnh0MGFqc0ZiT09zRjhrZEJDYlYzLzdkNUV1VmJk?=
 =?utf-8?Q?aWF6Uwja5+wN/lH4ryLlb8bGO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdd9ffa-b1aa-4afc-7ba6-08dced305e21
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 15:45:17.4067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wf8+EvhAC7AOIfxCYMifi1s2XxM1UVP3rMGkNYzXTFWo0PATNxSMMOVkCRNtJpqd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038

--=_MailMate_6684DAA8-7A91-48F9-B0DF-B037AC4119CF_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15 Oct 2024, at 10:43, Jann Horn wrote:

> On Tue, Oct 15, 2024 at 4:40=E2=80=AFPM David Hildenbrand <david@redhat=
=2Ecom> wrote:
>> On 15.10.24 16:32, Kirill A. Shutemov wrote:
>>> On Tue, Oct 15, 2024 at 01:12:36PM +0200, David Hildenbrand wrote:
>>>> pmd_leaf()/pud_leaf() only implies a pmd_present()/pud_present() che=
ck on
>>>> some architectures.
>>>
>>> Should we clarify what behaviour we actually want from arch code?
>>
>> We probably should document somewhere that things like pmd_special(),
>> pmd_leaf() ... should only be used when we know that the PMD is presen=
t.
>>
>> I wonder if we should even add ways to detect mis-use
>>
>> Jann also raised that recently in a private message, that it is rather=

>> unclear (well, and repeatedly leads to issues) when pmd_leaf() is vali=
d
>> to be called.
>
> I think one place where that should probably be addressed is in
> Documentation/mm/arch_pgtable_helpers.rst - that is supposed to be an
> overview of these helper functions and what they mean, but the only
> thing it currently says about pmd_leaf() is "Tests a leaf mapped PMD",
> which doesn't really tell you much more than the function name. It
> would be nice if that table contained information about the conditions
> under which these helpers may be used.

I find the related documentation in include/linux/pgtable.h [1], but it i=
s
not an easy find.


[1] https://elixir.bootlin.com/linux/v6.11.3/source/include/linux/pgtable=
=2Eh#L1865

Best Regards,
Yan, Zi

--=_MailMate_6684DAA8-7A91-48F9-B0DF-B037AC4119CF_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmcOjgoPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKv7gP/RADZ2mzmdP5fOtk/n0lzNkG8fixRcKH4TKI
dxJGrI+V+tR0SYSxVQwHk3uGPdoRiFzWfFyDtmsAP3O3s0mqAfFgz6EHh8uGBrEV
wQNs3tUc3dHcXz9XbuO4CmsQZjeOzxM4uoekR1wFNnxiGaNYCwzYDnPGi2LXH/Dw
co+Zy5T10WEKUaXnUxzJki6fTaL5467eEz3fU4YAHFAaV1WcrpF8JkfaHVSH3wIg
N/Lm5SSTTNZENzYwALZCyF2E3F3nDpIFo1YNOXdeZuli0uLwIRyFWoywsBl9D4lX
eE99AGqeSUVhsdPJ+wCCbHycutQekrtcg4bddu66szWY0N2gUyVa/ErqGgdLEnbu
MRFXLS9HFEHY9jlBwuFs1j2k4LKRM8TTTvt17S3Iyl0ukPqyD9yG06VK78uclaLW
2qPyDOCrekk97y30Op1VM6lvL4cTHS9nxYcHpgUkKTrCGIZPfvsCAQiJTHkjwqFs
m9WSRQkReRgZz6gDDxKm8BFqMIFEvMJCCoXew08BqaYLKiRQNfPP1YHo2MqyQMBU
Ll6HX8X+RsSuB5+rEnAlMRssHPFVPDHwSlf8MIQfsVFK2EKN1C1MhnJsAs1Cgsgb
y4p69Y3bDx+xFaB4w4ndroPCXKSFDhP2JOuedVk+i7XLIuFpg+rsQQXII7HEnPXA
SjE9xKjK
=jRAB
-----END PGP SIGNATURE-----

--=_MailMate_6684DAA8-7A91-48F9-B0DF-B037AC4119CF_=--

