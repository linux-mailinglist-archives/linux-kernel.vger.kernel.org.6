Return-Path: <linux-kernel+bounces-332875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A62F97C01A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3EE1C20FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01131CA684;
	Wed, 18 Sep 2024 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zEBtfEwt"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4841CA685;
	Wed, 18 Sep 2024 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726683761; cv=fail; b=M8QVW+EJ7hKDtsi90D9wzq9AsU1vQwI60ATCEtciH9o/4Vk5LR88QqUmGjwg47uU+ctilUvMGUTtLIgqbmNLIDaS4+AzDn/lVTiXq2wuEQKoNOA/a6qtx/UjZpJRSwR11JbZXhgD7KaXDQY8WpFMD3KmrkVIdwDL6XgwJEcuQp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726683761; c=relaxed/simple;
	bh=sKxCQYllFy3CXzdMZw9AB+jjc64gPPZkuX2loZGGr3M=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V03nejVCWNSFbDeE+0UmiE5LORBtXpQf5225n/46tItHSjCwYfNTMhJLs0deh5vE+iIOWazdrML9UyPtLV+NvL3BQ/wzX/3USj6Z558eLcRsh3nMJsxMNvIeowuyMW0NsREUpAATLNVKjsukPHYbNyQxMPY73sUiWZWbLdhHpZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zEBtfEwt; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5L15DnmWFChxNlYw2nQiwWBZ33UvCFNNmnq8AFjMc9eQJp+pGYi6HG9ZQrWLIOu9hMT9M5PCAQOIXJ2NWlhK2GUDAnscO7QbX0BMwOXSwr09HtLdNdi77IqzLxfTY369LNJWohSN8pGN5SZ+sCZnJIoQtUWcJxYhNCgiSaaq2tC+TLQVMHYHkoG/lYCBHXQFKt8ZFwp7tdNCo08ZS3x06EbmqBgYvn6olC10B5FesvcXD71JGrug9jmm+7OrG9QEU2Q+bDuE4OvTDzLZws0feeH5zR1r9IAcVfW3f+wZ3xxxiJZO1JvtsLBGn9+b/jatjePwBnqOozrW+rfa2bnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtNUQMwzVEkxut9vY/BC0W5JdX4hrxGQFcjtY6aYQYw=;
 b=VsgJM/7ZhzIDccq/VrEC7MIPTjIQ3o0KI13w/zu2+Sc7F5bzoOg2V8LZph0C1DvFonwO6hvnQDKkH551+ZCWaTmGxkT1A0AuR9fvVQApZF+K88/fm9FdTkbK1i6i8IeEodDuuIh2qDX74lE1bHgIvHEskiya+cLiQA+AbPyilKN+1IYzpwPUYmcXgEtJEqEvZitm8ah+rbSqvco2NOOxNpqemB8c1u1sV7kETeUxb+hXfxbmirZ44si1AkKeutynRdZH/jbVKZR1GDfBvmlnDJroFPHqRSsYt4ZP3jDINz/ozUOxlfPjfUOWwpgoV0NZZvfhPnILapv05q/Wx5OuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtNUQMwzVEkxut9vY/BC0W5JdX4hrxGQFcjtY6aYQYw=;
 b=zEBtfEwtciJzQMMA7slGAw1ROkRHsMKbPC2ByymTkKmWLu9nixa19vIPE+E9+kNGWsIdVv+Q024jccanXKEmTY4T550DQQPsjPaGFysM33TaGT2T9Nz/8UG7cmQ3hBXfZRVqUNwsfoGmKOPvzCzDE8SIln5SlmnaZtu8PS6L3ik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB7382.namprd12.prod.outlook.com (2603:10b6:303:222::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 18:22:36 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 18:22:36 +0000
Message-ID: <89da43fd-69fb-48a6-830e-e157360aeab6@amd.com>
Date: Wed, 18 Sep 2024 13:22:32 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 3/7] x86/resctrl: Introduce sdciae_capable in rdt_resource
From: "Moger, Babu" <babu.moger@amd.com>
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: fenghua.yu@intel.com, hpa@zytor.com, paulmck@kernel.org,
 thuth@redhat.com, xiongwei.song@windriver.com, ardb@kernel.org,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 sandipan.das@amd.com, kai.huang@intel.com, peterz@infradead.org,
 kan.liang@linux.intel.com, pbonzini@redhat.com, xin3.li@intel.com,
 ebiggers@google.com, alexandre.chartre@oracle.com, perry.yuan@amd.com,
 tan.shaopeng@fujitsu.com, james.morse@arm.com, tony.luck@intel.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1723824984.git.babu.moger@amd.com>
 <cf9e47bbd66dbbdb76f0124620fad2f1b06e977e.1723824984.git.babu.moger@amd.com>
 <254da029-81b2-4745-bc78-5aefeb33adb0@intel.com>
 <b96e5de8-75ce-4a7a-8788-f5d3a959d771@amd.com>
Content-Language: en-US
In-Reply-To: <b96e5de8-75ce-4a7a-8788-f5d3a959d771@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:806:120::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: ab09b652-80d6-4a28-cf09-08dcd80edf24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0p6MUVxZFFsYWRERnpFTVl4aGNYdU9UZGFacHJQNm9QVWt2aVNTVE56STBo?=
 =?utf-8?B?eTFqT05wa2tTZ2JPZ0tWaXM2R3d6TDVKNkRNNkZwK2VVdDVnRGhZTEJQTW9k?=
 =?utf-8?B?aGx0VUxnV3R2Y1JZRGFxQy9xdU5SS0RYZVdENUhjZ0dkaVlEOEVuZ1ExY0RP?=
 =?utf-8?B?Uk41bmM1K280LzVMR2FETVZCNEd6NXNSZnhJaW5GNTl2WjJNYTJPaHNyRE1y?=
 =?utf-8?B?UXM2QU5kbkgyTWZjNkVodUNuRzhtRVFuTUxHdHZpdjdKWnE2K0RGaDFpRXRh?=
 =?utf-8?B?NjhUejdmTWs2bmZKYkh0WDdsb2Zma3BCNkJLWmNHenQ1ek5JTXMyN2JldXll?=
 =?utf-8?B?d1l4c2VWUnJjeFkwa0ZjUUJRSDY4OTJ2YnpTREpKTDVlSG8ybDVDMmd0T1lQ?=
 =?utf-8?B?a0U3UU5WeEhSRDFuZkM1RTZXTUlHbHdKYnk5YWZZMWVQZ3BUWjRaVm8vTWtS?=
 =?utf-8?B?V1BIN0JGYklJTE1wL2l2MGNCRXI0RngzWXRNS0RrWFFPQWt3MFRXZUFyR1li?=
 =?utf-8?B?RTNPaFp0dkdvcEZJMXB2cGJLbjRUSWtYb2RPOFhnZDJHRmE1U1VOU3lVSXdT?=
 =?utf-8?B?djhDWXM2UmFTRjhldEdIbHEyZU5GMG5mTnhscmp4c1h3MjFGRFg4UGF4Z0dM?=
 =?utf-8?B?T0NZRUM5Yk5nVmI1SkZTTjNvSEM4SzMzWTFkNWxUWGhWWElFOEJXYmR2alda?=
 =?utf-8?B?WlczTGIvdDN5Ukw3dzRwbVlWSkpxZDhQUDRWbVBKWjc2R3k2b1lvZ1l1enpO?=
 =?utf-8?B?KzFLdnpkKzBWdlRjVjJ6cWJLUnpGM2ZTbFNPdVl3aDJ2TEpTcXpPeW9DbjNa?=
 =?utf-8?B?dytLdGJZN2FENG1Rci9jak5Sa2VuOE8zMC9yK2xiTGI3NXNiajNQUEt2SjZF?=
 =?utf-8?B?amJRdWNSa1RwYytpOU5tZmdTcDNoODdjcVBoOXVibEJaemh2ZmwxMDdIZXF4?=
 =?utf-8?B?MWcreE4vM3dHbWt5WStlYmNhektlcXo5MGdxT1RFVDBOM1IrWWd6dkhBS3FN?=
 =?utf-8?B?SEVjOWNhWVR4WGZiaEk1emFhWisyVjZHaGRseGdqaXRBelljMG0yczJXTHo5?=
 =?utf-8?B?ZitzbE5qTkhvMUpUU1hKWWVTZjVCYmpVVUZRczRyNTFnSzU1dmFTNFkvZFhR?=
 =?utf-8?B?RjdSNUx2OFNCYzMvUDAxRm5vemRxU3VKWDRoSWp3MkNROG9lRk9vNUUvZVA0?=
 =?utf-8?B?QVRhdVJSOVBySUpWUzFheWN3WTY2aGw2U3NneldpaElXdXQ0azdSQUE3dEta?=
 =?utf-8?B?cHdscVd0NDRXb3cxWHFnTGtLb01GRTNSUmtaS1pFTjBFUE9MSDlNejViU3dw?=
 =?utf-8?B?ZCtIdDl0TlBqL1VqbXpmTi9KanVZQ1AxbmcxNVZkb0V1andpNnVHY1JxK3Fp?=
 =?utf-8?B?RjhzcW82b2NjcTk1QU4vYzZlK2NHVTNBU3dGanNLWXFRa2QySkVpYVU4MHhs?=
 =?utf-8?B?bGx5RjM5NGhzbnpTci9ISFhIM1RIZkRmUm9SSHVMZzZjWWZGSU96NkZjODFw?=
 =?utf-8?B?S3g5L2tQUDNHejJZT0RVNk9yVEViOVBpOSt1NlVTeGNKMzZmZS94ZEJybDRN?=
 =?utf-8?B?QjFOUi84UjhTZUMwM1FTK2VXSytwd0hOeWQ4Rld0akJTZUx4UUwvRGUxbjdp?=
 =?utf-8?B?TTBGL0pqNXU0VVA5L2ZkcE9CaTRsRWhWYUIyTk9EVXkvSmlDTElYMGRRQk1m?=
 =?utf-8?B?bTJzaFhBL3Z2Z0hoblZkK2Rxb0FqaUlWVFdLcTdyTnZNVkZSYWZ5VDU1eDlq?=
 =?utf-8?B?YnIxTThXOGZTY29uM1FGNUY1b0c1ZjBTMXA1TnQwVnBxazBpU29OOW82Ty9o?=
 =?utf-8?B?QlJSS05hVko1Y016Q09WQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDQvYitpeXBQVkROK0pFTndkNWVEZnBqMFc5aUpsQmxGdk91akhWODF0NzA2?=
 =?utf-8?B?aXgwVDNRM3lZaTFTSUpVcGppWm11S2lQSnJOK2RhQ0VpZ1BjaXlZQ09BZ1gy?=
 =?utf-8?B?cDcvVUxzNmFtbDBJSkE1U3QwMzBjSWd6RlFMa1BwVmpCZnl5YXMxd0ZZNXdF?=
 =?utf-8?B?TWFIeXhSblZoQW9LeE1yL1BWenZKRTI0bmZwUE9sT2t1TFc3eGQ5cG01b1Na?=
 =?utf-8?B?T2ZrWHNyUzFBT0hCNk1KTXJQQzFnZlFTOVpEOTNVSURyL2tFb0Zmckt3bm02?=
 =?utf-8?B?ZXNsTlRrcCsrTDBzRUhiQ2RtYUIrRkNpRTlRaGE3SVNSZGtVZDRZTzdtUVRY?=
 =?utf-8?B?WFp2VFBydmNOZUk1eE81cUY3RUJpOU1lTkJZQ2loNnYxOG9Lb3FKL1I1VC9z?=
 =?utf-8?B?c0psYjhtRU55ZHZTZzFhS1lKbGJPekN4UVZtekNlVnhGZFpmU0xNVDg1WTA1?=
 =?utf-8?B?ZEF4TUNPUHdsNVdaMFRxbmpqb1JHZHNQZ05Xd0hhSU56dUZNaVZ2dHRzeTMy?=
 =?utf-8?B?cGdQeHJnWWlTQkdmQ1JpcEJBTDlCZHZMWGJtcUt5cElIbk1sMmVFYTNYNTR1?=
 =?utf-8?B?Y1RiVTBNYzhHQWcvQ2dxWXZuV2VCTnpINjFMSFovOE1RYWJXTzduVWxoRUw0?=
 =?utf-8?B?VjdrS09LaHl5dDlyWXZ4NXlYSm9FMDM0THVzYWZZSjgzclliVlJLeTVtZnVY?=
 =?utf-8?B?VGd0a3Y4UGF0UXJHNzBwSFQweEFyV2U1cUJUZ0l5THVJeGdiWFlHYlVpcXl2?=
 =?utf-8?B?c2V2U3YvRi9hL0VYSzc4K3p6ZE5hY1RzSk15TXAwZS8wNjl5MG01TkJsMjJq?=
 =?utf-8?B?eGtpeHc3WTBtbkRuR2hHSG1mWGFoRzRIVjEvVVR0RXVaQzMxRERyNDdTQXZL?=
 =?utf-8?B?Z2d3ZUtFdGI5dk0wNStHYlJNUk9JbWlSVjBQR0ZFdmJJS2ZQU212azIxcUhN?=
 =?utf-8?B?TnJTU0JOcFJOdHZ4U2g4R1plNkU3WTB3K25IK3plaldhSitQYlZQRTRKVWc1?=
 =?utf-8?B?VzlWaGJ1Tnp3T3V3K1lCUDFqMmZPY3VzRGUrNnBENzNFZXlrSmpkenlsVS84?=
 =?utf-8?B?ZjBUSWh0NVNXajgvdDJEWkZvbG9jbnJpcmVMVGk2LzBLejg5bTdtSWRLMm5q?=
 =?utf-8?B?RXhKc1F5Nm4xWXNsSVVJN0EzVGhZOUtiN1ZYbVJkc0ZPbThWd0JnRFZCckhI?=
 =?utf-8?B?YkZnaFB2UEJoUkhCcHh4YVNabncwYUcwYkI0ZWZvSi96S1FUUTFPUVQ2YkZG?=
 =?utf-8?B?bGJudlMzc3JmanQzanJqL1NMRmxMM2xmWVJtOVVZYTJTL0dIODdzTmFUbU1u?=
 =?utf-8?B?NkZodktEVjREN2V6azljUlFtTEg1bktSN2ZoVmlCQ0gycklqNjdoL3pTRzhQ?=
 =?utf-8?B?WjlsSjZ6aW8xR2Irb0R2YVRGRUdNYkdiSXAzU0J1M1plMWw0UjI2Zk93NlZ6?=
 =?utf-8?B?R0dTZ0hnYlNITU0vRUdJZ09hY3NvVkcrM05xREpSalgvMk9IVG16aytwdWY5?=
 =?utf-8?B?blovSDd0OVAyUEZKRVJrSVFXSklVbWFVdExjUjVycm80NFp6cktPU1hRQUQr?=
 =?utf-8?B?dEowUlRSb1dvUk1MUnBsS1ducnZVNlZXS056NDdiZWNhU0htY295RE9FV092?=
 =?utf-8?B?cFFIWW5hSHQ5QXNGTlhzRUNLcU0zWVFzcnEvMlMxQVNEMEgrWDQ1Rm82dklZ?=
 =?utf-8?B?UDAzOVFGVmZac1B4bHJFT3J5d0R2amtOTndqWDVBVXFDbjVBOVdmaU5vaW94?=
 =?utf-8?B?TitLZTlGYjBoVVJFS3pTcmMxeU1yT1U1L0VPT0JDeUk5S09WRzgrYy9TRzN3?=
 =?utf-8?B?RzVBbmkzdGNQUlZWL010VlQ4MnRkREw0WHg2M1NOZ2pDWVg2VGJ0YmZWZVFX?=
 =?utf-8?B?SFBVTkVzMWkremNRRmp6VkZVQ1BlQS9vNjlRd2lpOUxTdzVYUjZ6UDkxaDhY?=
 =?utf-8?B?RERMaEZjR1lTTzdhTFcvRDNzWTlLUkRoRE9YTDZRU3VMTEZQQ2xDbm1hVGhl?=
 =?utf-8?B?ZFBpWWhSMXZ4YUM2MVJGSXhhNXNUYmV4OXg0L1BRTS91ck5yOFpSYVdGNE1t?=
 =?utf-8?B?WHF3SWhoWURhQUZPQldRZzdnM3ZNVEQ5YmovTXAyWUpEV2NTWHdhWXFOMHkx?=
 =?utf-8?Q?Y3Po=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab09b652-80d6-4a28-cf09-08dcd80edf24
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 18:22:36.7895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czrX/S7T5MgaGz7R/OiQTGVU2X6eE0NzVUFJp9HDdEsepuKVxQPbGHKXfMImcFFu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7382



On 9/18/24 10:27, Moger, Babu wrote:
> Hi Reinette,
> 
> On 9/13/24 15:45, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 8/16/24 9:16 AM, Babu Moger wrote:
>>> Detect SDCIAE`(L3 Smart Data Cache Injection Allocation Enforcement)
>>
>> (stray ` char)
> 
> Sure.
> 
>>
>>> feature and initialize sdciae_capable.
>>
>> (This is a repeat of the discussion we had surrounding the ABMC feature.)
>>
>> By adding "sdciae_capable" to struct rdt_resource the "sdciae" feature
>> becomes a resctrl fs feature. Any other architecture that has a "similar
>> but perhaps not identical feature to AMD's SDCIAE" will be forced to also
>> call it "sdciae" ... sdciae seems like a marketing name to me and resctrl
>> needs something generic that could later be built on (if needed) by other
>> architectures.
> 
> How about "cache_inject_capable" ?
> 
> This seems generic. I will change the description also.
> 

Basically, this feature reserves specific CLOS for SDCI cache.

We can also name "clos_reserve_capable".
-- 
Thanks
Babu Moger

