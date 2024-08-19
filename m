Return-Path: <linux-kernel+bounces-292794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3897957475
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85691C23AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D7A1D6191;
	Mon, 19 Aug 2024 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nfQZ5VZM"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711A41DB45F;
	Mon, 19 Aug 2024 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095686; cv=fail; b=UBm0KCqck3kXjFYs393ZUFXy7M10OIlHbnbY7aIz7gP5vhGr7qJnFFTOKnnOfQVZYTcFUhBVIRTNNgjJ+VF1Nr6jpLRqU72NJfe3eaeLEE/zYdar/u+wsOa2ikd90HlhFKrIPcIMWxkywsJvWrTSShx1jEFbxBNCJmcHu7e2rj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095686; c=relaxed/simple;
	bh=RmmsRQVYRMkbONRCEUEYFFyeMy33hGZ21Bg0gr3fQS4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vlp+VfHGcgXQtIRxgytCaEsfymtgxd2eR6IVzAlzRY35cJsqW8+jvAwAaak+uUFk2YOybyENP2LtldZNPAMFQsXrV2lVeQISPYJuJMJQAz8mKlZo4dU8Jl850bw4rj5uCeqM2cVrzWq2ps6EIikWJtFgF9/VNdljCaLap8ID3SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nfQZ5VZM; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsFnCMpguuJoiYTnBDgAdnxnCGiZaoIlUwi4xukQxD9wJF1+QWWgn+QRHeZdMHtmu2ADVz3TJj1RCEW6q6dpSWfjNSTtUgcoekIhlMVH3kyneCj6nSOOJ58NrvWwlo6UnjhusN30EVMr8kVNAOXaFe7wQ3IcTLF0tpm//3tYW2YAeCqDcLMwLxf3R3xmZj+cHw6Ls1BtxsE8TUaEyJtWP5MJcJersQslBLIpDRLTgB9qg+bIRLQcWCzDcGZoKRiVArHXxOt4skrmhCp3POOXGLb4JF2tDyKYdFrSKgJxDZQSfIDICqn7trhl5QODAzL9Lt9uvo9hyram90cEuz04HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pQUj5wNeIBvVcX39ys2JjHUSArpycPaK1q33590Who=;
 b=vWMSHpQGaozReyGQhX5TqsNYiE8K5Hpk1OtjZf5KMuFOUtF0RVr61Ai5M0Lx7vXKdSuGn8GCtkEIIl7iWHbQSk9loGQFMHV57Nl62sUUZlbuUsZRzDqdPl1H0iswEyXipBJG4aIy2CyirRL5tG1C7C9Bydz+feWpY011mgPI9z3VSsEJnHOop1dlnj2JeBUtceUyt7F+8ZGq/qm+drG3abk7jkaJB1rm9Nyp63G4AkSG7Vwuq9dZovGSFsXYzNS1vNobx/3yQ0TQosmUtSCqJ/qIgBgHjsjzKnrIEVx1oZHAoxfOsUljmcPYCmDiNYALU99niC+i6oSBxJdyolegvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pQUj5wNeIBvVcX39ys2JjHUSArpycPaK1q33590Who=;
 b=nfQZ5VZMdqUEMsHETkSFMqa5FvWz4wK9L0oeybkUpHB+XooeWYsP6lEANXvx/zIbUizbcs75Gmh1iEKR0B/kLgv0Ojp59r5HA8MUM/TW23Za1Z2Nclq5GcyaORM1LJtjn1Eza0pJYNw0hxDSmeBT/gxuh9uV+Qr0GPfPjj1viSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 19:28:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 19:28:01 +0000
Message-ID: <c82e67e6-b2ff-40a8-9992-f3f68c397f53@amd.com>
Date: Mon, 19 Aug 2024 14:27:57 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 07/22] x86/resctrl: Introduce the interface to display
 monitor mode
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
 <c8503402c5dcb17012b2010f6accf00db245dec4.1722981659.git.babu.moger@amd.com>
 <5e2fb414-3593-4d1d-b47c-a7dafb454e0c@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <5e2fb414-3593-4d1d-b47c-a7dafb454e0c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:805:f2::45) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 970774e9-a3cb-46ef-4889-08dcc08509ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVphZ09WSmJwc1crOS96akNOd0FFS1ZlRnpHNDBoeUJSQVBya1lubm81OStS?=
 =?utf-8?B?U2N5WDVGWFlEaG9XU3MvMFludjdmbE9jY2hWOEMwUkZHS1ZNcC96bDdUaW1i?=
 =?utf-8?B?NiszdEFEdjBiWHJmc2FvYzVYUlBQQ0lERndhTnhwR05PN3FtRUtRODg1NVVt?=
 =?utf-8?B?WWhxVG4vOUkzMXZtWm9jUnlFc0VnSllzQThMWTYzSlBCZEdiMmRUODVoRk5u?=
 =?utf-8?B?eVROWEVQZ0pwYVRmcWNiY09Bamw1b3RSZzVmVWNJa0pWdXdNNDc2SDFYemZP?=
 =?utf-8?B?TU5ic0ZNYnJmenc3YXN4R2hybEgxQXF2d3daZFVJclQwMmViUjVRZWpLVm0z?=
 =?utf-8?B?K3RCdVQ2QmdEK2cxRzJhMGNHSEFDR3pjeExnVnNnQnh1OFNodTdYOXF4UjQx?=
 =?utf-8?B?aFR2WGwvMUlSQ3ZwSFlEVFNxMDVuOUtCSlhFZzg4elJYSmZxZUJIVncrblhM?=
 =?utf-8?B?UllnSHl6akdLVFNiUjJqVXRLZlJET05uaG52VDFrc0pKTFRpUHN4OHl0MWNY?=
 =?utf-8?B?Mk1YU0xZTGRNc3BhSnl6MTRMeUROazI3bDl0enJWUTd0NHJxQk1HNTAvdW1K?=
 =?utf-8?B?a2FkdlVmMGZHU2wzam1uU2FpUkJqVmV1Zm5KVm9QRzBzK2R2eWYrM2JBc2Z4?=
 =?utf-8?B?YjY5bEViSWNsVkdnQlVCMHJ6eXpzREJGMmh5TG9oRHRSWEcwaHVSUjVjS2xk?=
 =?utf-8?B?blllbEcxMzk2M0gvNDI4c0dkWE9QRnpZVG5DaHpMQ0xteVV3My8rV3VQTWtQ?=
 =?utf-8?B?TTluek5IbS9zN2JrNU4zRWRqQlpmdHorNktNNHY4YjVOVDA0d1ZLQkR2ODBY?=
 =?utf-8?B?K25JRHg2S1VCVVJ6UlY4RkQ2UGhBR3ZqUjM4WkhUOWdFL3p3MXdROFNDMUsr?=
 =?utf-8?B?Mmh6UWZyYytYMitlMDFoZzR6Z3RPS2hNK2NNQXJTeEFPRVU5b0NwQVJiaFpV?=
 =?utf-8?B?YnFGQWRrNUtLRWdiOVoxSEJ3aFRPajhVMnJ6NEtpa0N2a2g1MlJkc2xWbzRm?=
 =?utf-8?B?YjB0NTZhc1pXVlhueVBYcHlTTjNJOHl3NllCUCsxRjVkTjVaYXl4ZGNMeWdL?=
 =?utf-8?B?RzNmRWZwU2tRMHBKNWJhZnlBN3U5UE5oTDk4Rk9PUldzRmVVYkVmemNNZ1VB?=
 =?utf-8?B?WGtGb0dEOXNwR3FHMUd3RnpxeTRkcTB3VVB2aEthL1VwTUFiREs3MHlwVGpE?=
 =?utf-8?B?Q2phbnd1eDYzak5ZRDBXSDB0V3VTcGtLVHZNclJEcXNlOWRtTXk3YjBNaDZj?=
 =?utf-8?B?eE5mMTkrNVZQWFgvazgvMktXL0g2RFBEa3FsQlcwVlluR2lzbzJjMmc3OXZa?=
 =?utf-8?B?c21icm5KdkdwUkVSbTdON3RtWU10SzNiamhBVW5FRGJ5UlQvU21iTDRENlNB?=
 =?utf-8?B?OW8xYk01WnFFbEtsd01MNklROFcvZGJSeHNsTjlmVFNmdldjdGV4M3Awa0Vv?=
 =?utf-8?B?NFFsL1NCRW52MVNMYWQxcDFHTXJ1UlVUYkQ1K0M5MENUS21USjNiRlUzTFJG?=
 =?utf-8?B?eU81RVFZOWNWR1dKdGFNdnkwbUFRUThZa1MweUt2K2NHdjhMNDhONk1Vb21n?=
 =?utf-8?B?NGttd0ViSlVPdk5qM0k4Q05kNmZlSkdtVDdYQzYxTGsvcEpCU1I3RkRyK3FN?=
 =?utf-8?B?TFRvVURieWgvQnpod1JDVDErWkY1ay85NXZQS1VCSDkxL3E0SWQ4eStMSHFV?=
 =?utf-8?B?SE85MEVCNmgxNDB0di90eFZxTTFoT3VNM0FtdkxkYWMwNGc1Szl0WEV1MFNP?=
 =?utf-8?B?M21vdE5BQmF1V1YxRU9aTlE3QUZqMDFmOWVjSDM3RXhEZU1BV1pobnNTN0Jn?=
 =?utf-8?B?VW5xK0UwemthOGs3QjFaUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2hMenVaVGEvVDZ3K2RySEhyVVZ6UFVIcitqUHdWbEpzejFDZ0VFdFBuTHdp?=
 =?utf-8?B?K2FBVS9PbkhLKzNlRUdTL09VblU1MFVYY1BlY0tSdzRNR3V0QU0ybFlqU1VK?=
 =?utf-8?B?YXY0VkgxMXduNEEzdUtBd1NDdjMxRkppU255cFMzb0JBanBrQWJ3b0x2MytI?=
 =?utf-8?B?MzZkb0JqTDRGQ0pSZ0o5K3JwbXJxVlZFZHBqQUE0MjVZMUQzVlI1Z1ZTc2Vv?=
 =?utf-8?B?NGM2cjdyQTl6WmFkbStTU2JsMTF0MENFZnh4eVNzZnlVc1hDT2pGUm82WHpN?=
 =?utf-8?B?WGFKKzFIdXV4bm1ZeitqbHVja3BDSXc5Z3ZlVFA4RFJHR0tHRGJma3BTSFRZ?=
 =?utf-8?B?aVlYS2F6NE5tMVhJTy9xVUtxb3k4QlhhaUZLSDBHaFd2ZmRQcy9GNndiSFlM?=
 =?utf-8?B?b0ZXQjNaSHVmYUFDTGMwclc0bEErZHZRbEk2U1grYXp4QjhLaTFXd0Z0dkt1?=
 =?utf-8?B?dG5GaFFuL1VLdTNTbytvbTNHZE9OTXUrYVNkL0Rwci9WdUlBdVNtcnJMOVRJ?=
 =?utf-8?B?c1lYR3ZPZmg3QzFvcDFRYnl1Y1NaWHhRMkhyU3Y5UVVnRGN5aW80bmh2bGZs?=
 =?utf-8?B?bXY4dXoySlk1bCtOTlp0S2tFQlBFem5Nc0lCbkRnQU5WK08yZXRxZ1Y3Q2pF?=
 =?utf-8?B?OWQwaGJXeTdoaTFWUFhwZytsZHcvSXl6cFBwcHloNnRrOEo0c1p0S3FHeVVT?=
 =?utf-8?B?SVdIL2t0ZkZ0Mlh2bW5rVGFOcmJVRHdRVkd0UWtqTWZLZU9TcVB4a0o4Y1ZY?=
 =?utf-8?B?MTJMTkkzVHhScTB1R1E3Lzc5TEx1c0xWR2RBckxkeXhnWmhOMmJMUU5YNVNI?=
 =?utf-8?B?d1JxMVB3VG1BRUp4VnZPZ3o3MWVDTC9scWNJQ2prYy9ZR2pLQXdSajN3NUM2?=
 =?utf-8?B?b3hMUjgrcFhjK0JaZ2dXQVVTdm9nd3Y0dFFIM1FRazRQTXJmTGE3Q1cyTnV5?=
 =?utf-8?B?ejNoNHJ5blBxYVl0ODFhVXVrZDhzNDJqY3FONE42clRHRFhTd0hGdDM0L25n?=
 =?utf-8?B?M1hOTVhoQnRIQm9RaTFadXMvS0cvTURSclB1VUo3RVZUcUw0cUdOU0xyeldo?=
 =?utf-8?B?dFphUHZoTEU0YjIrUUVtb3M0UFdTZlQrWUZaZXNid0tXR01FSXA5cm1CU1c2?=
 =?utf-8?B?cWhwNE5ZR0Mrc1RBcHRyZWMwVWtmeEJPOWZOSnd0UkNSMHJ1enltbjkvVHNT?=
 =?utf-8?B?QUU1YXF5bEJNSllEZTNKajczLytFaENQdzU2WmFBZVVFcGxhTENGbjhIbFpX?=
 =?utf-8?B?aHR5SVVWV3lIdi9ZSkVQSXFtQ09KOWRJampsZ1AwY21JN2p1Mkx3WGRLY0Y0?=
 =?utf-8?B?VEhSSUQzNG40SUJ4S0FBR1FPOTR1aHhkRnE0U3BHMlpDR0w2RzhHaWdRb2Jz?=
 =?utf-8?B?TUFNVjlMY0Z2OEtPOWJKbzVWc2FVSzJaZ0k1MEpzQzd6SjZIM1B5TG0xaUx3?=
 =?utf-8?B?dUtBaDB0eTlUbWNUZndhTE5OanF1akFlNTVPeGoxN0VhcmdSbnBEMzdHei9U?=
 =?utf-8?B?bno0TGtncXlRNk02MnFNVGxuN2JrUXZYdFZOQVVTdHpqc083VUxvdGlOa2JS?=
 =?utf-8?B?MjJmWUFzY1ZIb1RPc1E5ZEdBN01neGJLRTMxODJKY2hTcmNGRXZkREFqS2VO?=
 =?utf-8?B?dDB1di93ekZJdlFBV1EzdnFQMnNoM2wxUlRkQU5iZkc0QXQ5aGhxSVJ1amJr?=
 =?utf-8?B?Nkh6dG4zV3BTYmhNQ0pTSE1CNGtLZUorNmdNeVl5cmZqNzJuVllUZWZCaHVR?=
 =?utf-8?B?YktUbDRidWtXc2FkWVM1RmJOK3haQWtmRnlZWVJmWnZXekF4YzJZdkphN3hh?=
 =?utf-8?B?bTJyVksrLzBONXN3M2R3L3R1L1JPN2JoclA3YTlCb1YvZ0FXUG9zSG1ZU25z?=
 =?utf-8?B?Uy81S0haU21ONVZHNTc3dzkrWnZGVmdxV1Uvd0hZVE1Uemt0c0dBaWF6bldB?=
 =?utf-8?B?d2tiQWlTZDY0U3BvVXh0WElCSmZ5bmVCZFB0Z3kvN054dDN5WkFxYlRta2Jr?=
 =?utf-8?B?M1NRQXZTSlZ4NzZXY2E1N2tITi90eXk5VmpmRDVjd0tyVzV3QlZyeVhuWUJX?=
 =?utf-8?B?Q0pIUE5OVGl0R2hWNDRtUUZtYkxoNVduSGpHc0V6R1FKSS9mVWYzcXZyTTRp?=
 =?utf-8?Q?oxZQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970774e9-a3cb-46ef-4889-08dcc08509ff
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 19:28:01.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zesjtt4O9LRmuya2J3RQwnWQdLFOeSetsaQRMfBEayJHpHxdrh5MgCItTT7J+t03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756

Hi Reinette,

On 8/16/24 16:32, Reinette Chatre wrote:
> Hi Babu,
> 
> (expanding on what James said)
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> The mbm_mode displays list of monitor modes supported.
>>
>> The mbm_cntr_assign is one of the currently supported modes. It is also
>> called ABMC (Assignable Bandwidth Monitoring Counters) feature. ABMC
>> feature provides option to assign a hardware counter to an RMID and
>> monitor the bandwidth as long as it is assigned. ABMC mode is enabled
>> by default when supported.
>>
>> Legacy mode works without the assignment option.
>>
>> Provide an interface to display the monitor mode on the system.
>> $cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>> [mbm_cntr_assign]
>> legacy
>>
>> Switching the mbm_mode will reset all the mbm counters of all resctrl
>> groups.
> 
> The changelog also needs to be clear to distinguish the resctrl fs
> "mbm_cntr_assign" mode from how it is backed by ABMC on AMD hardware.
> 
> for example (please improve):
> 
>     Introduce "mbm_cntr_assign" mode that provides the option to assign a
>     hardware counter to an RMID and monitor the bandwidth as long as it is
>     assigned. On AMD systems "mbm_cntr_assign" is backed by the ABMC
> (Assignable
>     Bandwidth Monitoring Counters) hardware feature. "mbm_cntr_assign" mode
>     is enabled by default when supported.
> 
>     "default" mode is the existing monitoring mode that works without the
>     explicit counter assignment, instead relying on dynamic counter
> assignment
>     by hardware that may result in hardware not dedicating a counter
> resulting in
>     monitoring data reads returning "Unavailable".
> 
>     Provide an interface to display the monitor mode on the system.
>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>     [mbm_cntr_assign]
>     default
> 
>     Switching the mbm_assign_mode will reset all the MBM counters of all
> resctrl
>     groups.

Looks good thanks

> 
> 
> ....
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 6075b1e5bb77..d8f85b20ab8f 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -845,6 +845,26 @@ static int rdtgroup_rmid_show(struct
>> kernfs_open_file *of,
>>       return ret;
>>   }
>>   +static int rdtgroup_mbm_mode_show(struct kernfs_open_file *of,
>> +                  struct seq_file *s, void *v)
>> +{
>> +    struct rdt_resource *r = of->kn->parent->priv;
>> +
>> +    if (r->mon.mbm_cntr_assignable) {
>> +        if (resctrl_arch_get_abmc_enabled()) {
> 
> Since this state can change during runtime this access needs to be protected.

Sure. Will do.

> 
>> +            seq_puts(s, "[mbm_cntr_assign]\n");
>> +            seq_puts(s, "legacy\n");
>> +        } else {
>> +            seq_puts(s, "mbm_cntr_assign\n");
>> +            seq_puts(s, "[legacy]\n");
>> +        }
>> +    } else {
>> +        seq_puts(s, "[legacy]\n");
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   #ifdef CONFIG_PROC_CPU_RESCTRL
>>     /*
> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger

