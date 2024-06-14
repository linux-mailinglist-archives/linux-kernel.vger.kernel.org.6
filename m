Return-Path: <linux-kernel+bounces-214228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DB490819D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 808A1B225EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B11F18306C;
	Fri, 14 Jun 2024 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="TEYm8zWd"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2126.outbound.protection.outlook.com [40.107.223.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E2127E0F;
	Fri, 14 Jun 2024 02:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332168; cv=fail; b=iVhe2HyeNKDza9L5VH02f88E6W+K/Fb10REw0ZFrXcMu8+sED2djrGVWV9v+EmZu1W2ZI6eC+pPDw/KvqR7E4IDGD+opq/j34kxd/8YFCtyZRkwGRD9w6mz1EtZy49vuz7Cq/SDunp6TkkkU/DiSdADRygt9ED8dzMpv0BPkO3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332168; c=relaxed/simple;
	bh=enCyPLEvcflX0ECInzZLROg175muRcScWKVqdcOrPKY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mHWEQd7vtgzg1/2tZ+McmbYqSSmbxu9Oe2Qz7GN962jfO7xCxMdRwwgwUqHvEA1koS27vfrZibbauPuOGGex3HGwD8nSk7AAmi90CMtn2yF7mD1OUHOV5at5fd9KqA3jcEfpeHAU0IGELUwwEvQwaFfvfPtr1bRoElCK2WazhGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=TEYm8zWd; arc=fail smtp.client-ip=40.107.223.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9r+GKXODdGFBvAgrminGnawEX+oCn8yCCaTTIwaGjlQ5jOrwEdqicu1USzcqoSpMAdsettgbDX8fPqb8B0yZGFce8vGv4zHUVnbQlu+h5PoiF0c3DAt6MXnQmRTqVHe7ecI9I9BWG4OQi4BBRwdu650ZdDSLAoIeTYp6GK0V3O4a0M1tfjVJ0qxDzw0p/L3LZ7SlncOTu2HjRmCuDB9a+fDGuPoiTMkfiJok7tzOeDPMOUxi3YZd/1xEmvLGin8u1GzPLL7ms4HyVHhzb5Dx57gn5D84YLeHlaaVoXJBvZDDpcD9SPQp925UZ6ROrpMsiSTicB9+HqqmgtghSUhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqlweyjK14N50xiTTA80ulgicJ8STbumpoeBWzv+Bhk=;
 b=aCZmGXcAk6KuYuUCqnY0bKgSwsUj1KFlT8D1JkXnOasQmqhKv0YSzwZ4QINA/WGd14y+iC4Cm+tMWNBLHrb6yGHGAquJ+2itYluVZ6e4ue8ujG+MSJd+2oS8za51IHh4TLFhf0nMspujd4t8UGYjY2r9DTdybuEHnpZz4xLdDkllWfTgC7cc1JYtzwNbl1gP3aWCjtQX9qQnXfJA+P8vfN0XOfXD20BcxMjdSjjLIBvmX7/KV0oKMuvbvBcNKusbDnFGsLjBvBeGYJIvuHeI0yreuBn6cJZLE2VoLYcAXi+MgwjBwNrRIw3taZ7NNRiHdWRBermfq0IEGhk+w+nvFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqlweyjK14N50xiTTA80ulgicJ8STbumpoeBWzv+Bhk=;
 b=TEYm8zWdEbEh9hr38PCEKpqjLMvB9eZgDry5wwG51h4H1klUlXsmoese3cw9uQS0x4icOwnUv8IbicUWWvbqlZIXzLPtuIe2XgZ02jHpPa87py8B0bne5E/JDQCwQ8/Qq489BC2Ft9l8KyPRwIQZZR5bxTQL7HiRHOEjQjemLgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8193.prod.exchangelabs.com (2603:10b6:a03:4f6::15) by
 DS0PR01MB7892.prod.exchangelabs.com (2603:10b6:8:144::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.21; Fri, 14 Jun 2024 02:29:21 +0000
Received: from SJ2PR01MB8193.prod.exchangelabs.com
 ([fe80::4167:3f60:16af:411d]) by SJ2PR01MB8193.prod.exchangelabs.com
 ([fe80::4167:3f60:16af:411d%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 02:29:21 +0000
Message-ID: <9559478e-5382-4de6-a755-29b115d5f5c9@os.amperecomputing.com>
Date: Fri, 14 Jun 2024 09:29:11 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ipmi: ssif_bmc: support skipping ARM SBMR
 bootprogress response
To: Potin Lai <potin.lai.pt@gmail.com>, Corey Minyard <minyard@acm.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: openipmi-developer@lists.sourceforge.net, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Patrick Williams <patrick@stwcx.xyz>,
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>
References: <20240612043255.1849007-1-potin.lai.pt@gmail.com>
 <20240612043255.1849007-3-potin.lai.pt@gmail.com>
Content-Language: en-CA
From: Quan Nguyen <quan@os.amperecomputing.com>
In-Reply-To: <20240612043255.1849007-3-potin.lai.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To SJ2PR01MB8193.prod.exchangelabs.com
 (2603:10b6:a03:4f6::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8193:EE_|DS0PR01MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 2513b14a-104e-4083-7659-08dc8c19ccbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWQxdDYrRHhVS0lZZDEydk1BTGpPWTRZdVNnSk9uOStqSmJudnNvUEdIYTdH?=
 =?utf-8?B?SmpMUlZqODk4cmp1K3NpODlDejBEZ1piMnJCN0lnK0J6WHlPOEo1cWhrZjZT?=
 =?utf-8?B?VEoxOHZNNnJyajFseDhsaTc2RHBlSnhnL2VETUt6QlpXdXBQUjRZL2dFZlNS?=
 =?utf-8?B?ODNwT1ZSd0phaGd1Ni9JYVNBTnh5ZFI1OHVMelRWbVpaZXpzemJyU0lhMGpq?=
 =?utf-8?B?Yjl3T292NE1JZ2NzOW0rUC9rVGIrNk55QzVXd3hjWXNIMDVBNkJSWWRhUGR3?=
 =?utf-8?B?RVlKaUdVSFdRNHlaaGprSUdMZm55T2xTN2I0R2JRVUI3bDgzMnAyVk5qMVRh?=
 =?utf-8?B?RXcrdkRxTk9pcjBlU3ZUbkZSK2Nja1Z6Z0hBaDVHeUFDWEo0TWVZdlhWNUNP?=
 =?utf-8?B?WkRTQVdlam9EaFMzWUlnRC9taCtnR1BSL05SbldiVENDeUlvV2FwTUJWQVcy?=
 =?utf-8?B?MzBhZnQvSndqaHNMZUlLTWhybDZySXFyZ0xNRmdBT2lQVUdGb0lyeTY5VkVL?=
 =?utf-8?B?KzhEaFhzcXlEL2VKWUd1blhha0pmNWN6NEVVdWJ1VlFyMUdmdnNCcmFMMzh3?=
 =?utf-8?B?QXJzSTRzNkdJN3pWRzBmaGd2aG50c1NjZjQrSUF6b1JWWEdoK0IyQ1JTMlpF?=
 =?utf-8?B?VG0vVG9BRVljemhRTlA2Tml0SVBpNlVDbVZhVHBDZ0NjM01jSE5JRXFHcFpP?=
 =?utf-8?B?c29IeGJsVi9lQUt1MXkrVmxaMW9PbDFPcVZtZU1BVnJwOUhjUHVKTnBZb1M1?=
 =?utf-8?B?Q0t2L00yVmFyc21qSHk1elkxaDBEaEpuaElpR3BZOW1xTDU1SFV4OGVudVZX?=
 =?utf-8?B?SFpIcGRZWEtZZndmckxlQnZMaHYxM1Q2MmxjMjlkYnp3K25xMjZWM2tKTkRr?=
 =?utf-8?B?eEl2Rk5NM2t3VSt6U0NLdGMyeDZRWFFWVVQ3SnFLRWptYzNublhvRFpsc0Z3?=
 =?utf-8?B?N01CWEtMV28va2pheXAvWGsrQTFlMFVjRUdiYTVCTkNRVlBHbWlZU2wrNE5X?=
 =?utf-8?B?UG1pcldGMlRySDBPV2ExRDI2Zzh3SHpicUNFVFIzditqMFBEMktyNlkwaFFP?=
 =?utf-8?B?SVpVQVZHVnBKczlzNzVrS0JqdU1Qd2w1aW4vckdORVFMYWliS21Lc2ZNWUJT?=
 =?utf-8?B?TnpqYXpTejQycmhHYjN3bFVVNS9BNjhZVjh1RkFiMGE3TWpNNjZsYUFyaE52?=
 =?utf-8?B?U0NsZVZZbWx5RWxETFpwR2plNndJS1dESmZncSt5T2FpZFJzZDI0QmxZK21z?=
 =?utf-8?B?WTFEVHZFbUthQ0tJSFJMbm53VmtTMndlbVlwcUpPTlhTRll2RnhGRTRsY01B?=
 =?utf-8?B?SWpNUWxObmtyRVhseUJtMWhnWUFnZXlJd1c5b1FEZnAxVGE0YjNudC9ldXVT?=
 =?utf-8?B?RmdGSmJVakxtOW90WGxlUHVRUmFMaWs5MEJkMTRrMEVRS0hvTWlrdHBDQXYy?=
 =?utf-8?B?OFJGdU1Xd3h4Y0lUWEhWNEVDQlVkSHY0d0JaZTRzOStuLzdqZnBhQ3Axem5x?=
 =?utf-8?B?Y21OM1kwZXllRjFYUEt5SzZlcXEycU0zV0Z6Y1dNM0YwVzdTS0JZSThSSFJ1?=
 =?utf-8?B?YXd3eHRVU0NaNVN2ZTFMNXY2a3FmU1NNKzJEYVE0R0s4SFluWTM1K1hxR1Uy?=
 =?utf-8?B?a0VaU0dvc3lzYlhLNFJ6cm1hb0gyYXJkc0tHV2hCODVRVjZxVFlhWm9IVGVx?=
 =?utf-8?B?V2toMzZDUXg3UHlzSzJOWlc5MHhWaVNvckFTR1pSMEhVbDVveUhKOStIZXpu?=
 =?utf-8?Q?NT+qJccsU1YH7jEu171bksIJmPOsN3IF7IgDHW4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8193.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGQxSGFqUjg3Zm9KTGExbHV3cTE4Ty9xM0Z5TFN5RnlhaWxybkhtZFRZOG9H?=
 =?utf-8?B?dm9qV1padGJqSWttbzQxQkVYU2YvMzlTcHdKdWc5ZGtzZFc4Vjd4ZWdMWGx3?=
 =?utf-8?B?RHROSWg5WTBEQlhtNkJCVWxSZFZWaG1EeDgvdXBhdDdFZk8wK2lmSXNOckFH?=
 =?utf-8?B?RUxSR0VwcW5hWStnSlh5akhiQWF1aEZLci9hR3kwQVVNV1I0WkR3R2srQU01?=
 =?utf-8?B?VnIzamYrbFlaYlRHZjZncGVKWHBrYjJuUVgyUXBWdTA5YjJFM25SeXN2UG42?=
 =?utf-8?B?K2V4elpBZUFjSmM3SlcxME8rUXhRMnYrcFBQaGxKS2Q1cUttUzNRcEVZRHBs?=
 =?utf-8?B?bWtLSERVMk9qOCs1ZTNaREFrYTJTMGVGRFpoNzVkUWcyT1NCWjJsWkNRTUZZ?=
 =?utf-8?B?cmdUb0huZEV3eEwyR1Urc3dBTmVjaGhrOUhGSk1yQTJCQVhWbjdBRHh6Z3Vt?=
 =?utf-8?B?MkpLZ2tVcUw0Z2ZnUzIvTlc1ZjVVTHhHK1JrOTIremt3cEZWTEFGVE9rc1lQ?=
 =?utf-8?B?dU9DOG1TSUVjNFdXMXR2UFhlSVJLMHpFeFM5ampRQnFHUWw0dkduUmhZcS9Z?=
 =?utf-8?B?TGFFT3RvYVBBdStzVFhtQU51RS9ETHNOeDZsS1NvQnVTS2dyancrWStyK0FU?=
 =?utf-8?B?Qk1OczNlUGplSTF2MXk5NXhGOStMU0Z5WU1UdUFBZllNNUVSME0wVitHdXBl?=
 =?utf-8?B?c25SdFVPeURKUlBMT0JISGxnQmgxVHgyYmNvNHdkelFaSEhsWC9jeUNzdFhs?=
 =?utf-8?B?OXJ2b0RTT2lVWCtVaXFHTXhCWU9BYUZnbUFKRjdrekFGT3ZzTzJOMzI5cFRV?=
 =?utf-8?B?SC9QeGp3NTVhMnZidGFRVU9YZjNNdm1yZHZWREZnTTFISkYzeUMwTWE1WFJz?=
 =?utf-8?B?c2FOSHp4T3kzUm5jVzI4NjVoUVVnUUJTam9tWWNjRWlDOEZMMVA3Y09MYTE3?=
 =?utf-8?B?bHBCeWhXK3EyaTQ4Z0ErdnlZVTJZWlJ5ZWVVSlgwdVY4L25aekxMZ2duK0Zv?=
 =?utf-8?B?dzZ2bTBiTFBMNnBuZzhnOUpIbk1FNTd3MDI3aW5xN3lJTHVzZHBPYy83TFQ3?=
 =?utf-8?B?aUJzQWFST2ZHVlpFNlg2UlJEeWJLRUQ2WjRCNnQzOVhRRnd4NldJNmxOa1lT?=
 =?utf-8?B?S2hpM0FHdUFDRTU2ZlZDYmsrTWQvL3JZMnArdXNWU3RrTWZtYnpaR0R1bzNh?=
 =?utf-8?B?UWdhajdrN3hiZ3diemRzeFNxM3BpdkZMMjcwTys0MUd1QzBIUHBZWDZaMlUw?=
 =?utf-8?B?UTY3bXdBaXp0ckVtNk5SbzVXTVpVTjVCLzMvOTZvc0RiQ3ZORS9ZcEk3eUMr?=
 =?utf-8?B?KzJscDdSVmdvNmJJTFBwRXR1ZFh3ckxMZ1AwSjFIWmMzMk9TWU5XYnBBTFMr?=
 =?utf-8?B?TnVFaHFEYzZ3REtsU2dqb0hMTFhKTG8vN2lWWHVKM2w5azRobDB3RzlEcnVD?=
 =?utf-8?B?ODdmYjhFZHMySWJkcVcxWkNMSWRRLytVMDg1QWVpZjBQU044cXFpa0NicnBP?=
 =?utf-8?B?c09uUFVZaWJJMG9hSVNvMW1iV0VROTFkdVpzYmdRenl1ZVZSTXRhbkRCVk9Y?=
 =?utf-8?B?RGF4VXdRVW5rQlYxVUxUZDV1NHNuYUhqTERKamtEVVZPWVl3dGRtc3dCZ3Jr?=
 =?utf-8?B?N1RiVmdiNjFLSUdIaUk2ZGtOaFRNRkxrZEMvWEtQWDdiblVvTTdwdlljSWVU?=
 =?utf-8?B?UFBZTUtqa21kaUdmbDNSSzdUMmNhbmI3VUVpVGZMU2VCaVVlV044aUlDWDlt?=
 =?utf-8?B?VW5UQnEyL0NuaStHdU1RUVowYTN0c1Q3SXIrOWE4SDVrK25qZkErVTNnNnFW?=
 =?utf-8?B?dHc3U2grcmFzd1hpWnN2eS9XM1JPZ05BM2I1YmdTWEhpUG9Fd3llbWtmRy90?=
 =?utf-8?B?WmN4eGVlWUNwMDV5VDZ6UmM5em56Z01QV29PUGZCOStCN0pwd3dmMkJQUlB0?=
 =?utf-8?B?Z3JOQzA0SEVCeUJKMlRteHVGSTRBb1RGTndxMVJsZGFrcGkzWi90cWxFbjdp?=
 =?utf-8?B?OWNMYy9MOVhwY3BJVzZwZXRBRVEza2o5MmNRSFgyMGxSbDd3OWNCcnJKM3li?=
 =?utf-8?B?L1d1azd5TWg4UTZ0a3lPKzVrTVJoYlB2bE01ZkhHLzY4QXU1OUtVOHRGQ01m?=
 =?utf-8?B?b1R2cHV0eUoyWGJ4MllZWEhSVmZzdzc4NEdJamxQbVdQNFdmeEdlR1NhVXM2?=
 =?utf-8?Q?2cp9K02pJntp/sbFcyJnC50=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2513b14a-104e-4083-7659-08dc8c19ccbe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8193.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 02:29:21.7761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJMMYe8Gx7xhsknb4vK6hSmHIoj1x9KysjS1J+7jSjDnlhlU+nHkHWJ28/PZLhxUXfWo41Yh47/1Nlusha9Dow89XQzTNid1Oulqn6ILbsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB7892



On 12/06/2024 11:32, Potin Lai wrote:
> In ARM SBMR document, the host can chosse to not read back the response of
> “Send Boot Progress Code” command.
> 

Thanks for proposing a solution for the case.

As per my understanding from the ARM SBMR document, the "host can choose 
not to read back the response of the "Send Boot Progress Code" command" 
is from the implementation note (U) in Section F.1.1, which is to 
provide guidance on the implementation, not a rule. This item also 
clarifies some consequences if the host decides not to read back the 
response.

There is also an information statement (I) in this section that 
recommends reading back the response after sending "Send Boot Progress 
Code." I found this statement suitable for SSIF, which was designed as 
single-threaded from the beginning.

I'm not totally sure about this understanding yet so please let me know 
if any.

Thank you,
- Quan

> To avoid SSIF being in a wrong state due to host not read back the
> response, add the implementation of "arm-sbmr,skip-bootprogress-response"
> property for skipping the response of "Send Boot Progress Code" command
> from userspace.
> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
>   drivers/char/ipmi/ssif_bmc.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
> index 56346fb328727..3386a8bd18afd 100644
> --- a/drivers/char/ipmi/ssif_bmc.c
> +++ b/drivers/char/ipmi/ssif_bmc.c
> @@ -39,6 +39,11 @@
>   #define SSIF_IPMI_MULTIPART_READ_START          0x3
>   #define SSIF_IPMI_MULTIPART_READ_MIDDLE         0x9
>   
> +#define GET_NETFN(netfn_lun)                    ((netfn_lun >> 2) & 0xfe)
> +#define IPMI_GROUP_EXT_NETFN                    0x2C
> +#define IPMI_SBMR_GROUP                         0xAE
> +#define IPMI_SBMR_BOOTPROGRESS_CMD              0x02
> +
>   /*
>    * IPMI 2.0 Spec, section 12.7 SSIF Timing,
>    * Request-to-Response Time is T6max(250ms) - T1max(20ms) - 3ms = 227ms
> @@ -102,6 +107,8 @@ struct ssif_bmc_ctx {
>   	struct ssif_part_buffer part_buf;
>   	struct ipmi_ssif_msg    response;
>   	struct ipmi_ssif_msg    request;
> +	/* Flag to skip response of Send Boot Progress Code */
> +	bool                    skip_bootprogress_resp;
>   };
>   
>   static inline struct ssif_bmc_ctx *to_ssif_bmc(struct file *file)
> @@ -187,6 +194,20 @@ static ssize_t ssif_bmc_write(struct file *file, const char __user *buf, size_t
>   		return -EINVAL;
>   
>   	spin_lock_irqsave(&ssif_bmc->lock, flags);
> +	if (ssif_bmc->skip_bootprogress_resp &&
> +	    GET_NETFN(msg.payload[0]) == IPMI_GROUP_EXT_NETFN &&
> +	    msg.payload[1] == IPMI_SBMR_BOOTPROGRESS_CMD &&
> +	    msg.payload[3] == IPMI_SBMR_GROUP) {
> +		if (ssif_bmc->response_timer_inited) {
> +			del_timer(&ssif_bmc->response_timer);
> +			ssif_bmc->response_timer_inited = false;
> +		}
> +		ssif_bmc->busy = false;
> +		memset(&ssif_bmc->request, 0, sizeof(struct ipmi_ssif_msg));
> +		spin_unlock_irqrestore(&ssif_bmc->lock, flags);
> +		return count;
> +	}
> +
>   	while (ssif_bmc->response_in_progress) {
>   		spin_unlock_irqrestore(&ssif_bmc->lock, flags);
>   		if (file->f_flags & O_NONBLOCK)
> @@ -806,6 +827,10 @@ static int ssif_bmc_probe(struct i2c_client *client)
>   	if (!ssif_bmc)
>   		return -ENOMEM;
>   
> +	if (of_property_read_bool(client->dev.of_node,
> +				  "arm-sbmr,skip-bootprogress-response"))
> +		ssif_bmc->skip_bootprogress_resp = true;
> +
>   	spin_lock_init(&ssif_bmc->lock);
>   
>   	init_waitqueue_head(&ssif_bmc->wait_queue);

