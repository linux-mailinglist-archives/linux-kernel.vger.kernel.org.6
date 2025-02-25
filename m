Return-Path: <linux-kernel+bounces-531842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F99A445C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6704D863DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702381552E3;
	Tue, 25 Feb 2025 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ovCr1/zP";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ovCr1/zP"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013012.outbound.protection.outlook.com [52.101.67.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA981891AA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500098; cv=fail; b=j6+BdYJT760uDdPMh0Y/6jZN6X1ZTG2x4dmS3rMibyUwa7antuCteM1AqYt4YmH/iicwZLkIpvjbotT4GrCDB/21/JBYc+mRn5piOBWGdCZhWdeIPVZfwQLvklk1T/+cyAgQvyH2TGeKQVBRqNvyMrorWzaCm157lLL2PZ2sGNw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500098; c=relaxed/simple;
	bh=jvHUdqMebG5fVL4xoj3sKlv6fJfhEHI4cFDG4pwYZo8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pf16ids0MOEzO7s6PaoFMwy3vR1yaG+op2FznQP/xX/lXQx4UJWkpyTpkejYXTI/cCHTdxsoHOJ/J1/4eYAkJaUQRS5TZ1sksnQ/Rjja4rThJTC9Fp5pgrDOzJyp1R63TdkRbW+nGYFJY0DVupV1YwyDv0V+SvlQ9zuznkz0620=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ovCr1/zP; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ovCr1/zP; arc=fail smtp.client-ip=52.101.67.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=h3tNo2hUoSJGVz4+p0hTjfDhd3gMdPZtZA57sPwxTC5YtNWSKHr3h4GxG0aS0eN1mEHHFgz4i4S05Dzir8aiD2kCkC9qR4p60G11Obws/oVm54g1/cfT/ZTcUoF5/fk2F6QyQYaU/E9H74JhlYl/Rah1zR+69xxNHaR8la+aqiwfAJuuDFvx9dl7jpbiNFuwigTBUFNEoOLc5B2rr8Hy8v1w60rK4N8CdMOAgdFWyQf086G17poiaaakS2vE7PMcBNIFJKU/0c3qnPEfE9hELPyguQgDDUm2dh4CXnO13WKzIRMoM9WSbHu9pV/HbugKKil4eSSE+In2WfUBEH6mzQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uAAqY2bXbtRuLdeNlmB4D8vJH3V71wfEC0fEOZg0g8=;
 b=wfIi/k6j64IEwD0RIL99sq5PrLzkrHdXqlkM2m0wE0+QLYolu6eKBcmJrxI8eR9ruuX7nDVLWnVjSRM19DXAPriGNk9zNm+6u43E9aM3KdQOq+8hMDBGv8+bn2eRzjDI3K3hBAsQ0uXSb0B2KjLTvDmJPVhPICPeQov04kf9ScX1xsZgz5D06f+Nbi0QYaEKi8MGm9fVu2cJkQptF97v7yUZqS8tNCFi9+ZDTf4N2ACxVhpF/DWoWlnKZGdXldvFhDHTeQ7ZbpSJ1p9y9guKYSHE+D9LjH7JsbK6GXFycMq2FFvJ+EphUgHUDIgw4NEyutTqYMU3xZ53ejHTD3GhUQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uAAqY2bXbtRuLdeNlmB4D8vJH3V71wfEC0fEOZg0g8=;
 b=ovCr1/zPUrsybiQJNuy160lvDF/upoQ9xib/ZdeQiC2TTCSq3DFBf7fw708hWq2b0MU/l5IZRlhd3BvIx8mknM/cVCP54iMzuCf4v8MUQbW0n9cSgHRmtTi4UH0wS3iwvOqieoBLdMQMdff7JMBLRzebZNchpAfkWbptuOMrYfY=
Received: from DUZPR01CA0318.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::7) by PAXPR08MB6334.eurprd08.prod.outlook.com
 (2603:10a6:102:dc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 16:14:47 +0000
Received: from DU6PEPF00009526.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::50) by DUZPR01CA0318.outlook.office365.com
 (2603:10a6:10:4ba::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 16:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF00009526.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via
 Frontend Transport; Tue, 25 Feb 2025 16:14:45 +0000
Received: ("Tessian outbound a60532193129:v585"); Tue, 25 Feb 2025 16:14:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 19119babab32e8b3
X-TessianGatewayMetadata: BJ5GFQg3j9rNivsIgv7dm2qsMRQ6FPyYH31bNNeQvlBSiUSlnznRylVvxjPXpMRSxQ//m2aMQkR8y7oiOMwlMc9Cx3fpAJ85htHhrHVSUM/UbcJkkSTLVhLeG8jOuUgmNTCIYMjvpJfrxnbkn5xea6PIkMizbATqX3nAc9GINiU=
X-CR-MTA-TID: 64aa7808
Received: from L3b335dfc6564.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 49C2E535-067F-49FE-A30A-6FC7D194F96A.1;
	Tue, 25 Feb 2025 16:14:33 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L3b335dfc6564.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 25 Feb 2025 16:14:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2KA25PwFti9CrdHj7h5IHsMTm3/sNKRmXyV/PPz0LnNhJ/1Brg0gEmiNoJEDyiQ8+CAW2UB/sOQf7s/kz+z2ruJCPCqeRnsMAz5r7Cf6LvA8Lcm2Z0eDHTqw8aga2JsbKdeVsRVhI/AnBKb3iNzpOSMfPWkGkuSNJ5i4rfQUQK+X1dLWZI1UYuAPraLFQhjRpOpEwVBHpItA5FhoSnKemtNyqgrKxomrld8s4AFE6TzK62zi+aN6zuZtu3qrv2UYFp7jz8LlVZK/lKbY/iSFncVNOZO0M6rG2ZUwkV+QMLOHogFVavHhg6ZASXRrzMDlxoo71DGAcei6655lNlagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uAAqY2bXbtRuLdeNlmB4D8vJH3V71wfEC0fEOZg0g8=;
 b=qXwzNNITz+WcxYDWofIbUZRkenqQ36K7zDBA1GstocWLwxmYLfYrxiqnET4PTb7CDi9y4uSuzOSAyTTQB1Z6bO2t8C2j05Mjm0bysH6FvKH7cDVEH28P18JxRX+sh31Y4HJgksX9r0lmuX/4q41/NPsg42Kqsmoju1fZ5ZFCRcchnI1nGEp4TU60ZrbIrB3Dq3baAyWsUPjllA7Lx+dJ9gZ+GGmJpmKU99Hx/uOWSUFFD/GlKZ2CJ8hZhNlD3xQ48/7bhynSPo1LBw8xvOCAxxwT708DuFFeOSCXeYFFSsk+WlQFTyk+7U1iGaR3zMNI5d8CoffpGdBsOhNQWvaJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uAAqY2bXbtRuLdeNlmB4D8vJH3V71wfEC0fEOZg0g8=;
 b=ovCr1/zPUrsybiQJNuy160lvDF/upoQ9xib/ZdeQiC2TTCSq3DFBf7fw708hWq2b0MU/l5IZRlhd3BvIx8mknM/cVCP54iMzuCf4v8MUQbW0n9cSgHRmtTi4UH0wS3iwvOqieoBLdMQMdff7JMBLRzebZNchpAfkWbptuOMrYfY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB7727.eurprd08.prod.outlook.com (2603:10a6:150:6b::6)
 by GV2PR08MB8169.eurprd08.prod.outlook.com (2603:10a6:150:78::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 16:14:31 +0000
Received: from GVXPR08MB7727.eurprd08.prod.outlook.com
 ([fe80::9672:63f7:61b8:5469]) by GVXPR08MB7727.eurprd08.prod.outlook.com
 ([fe80::9672:63f7:61b8:5469%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 16:14:31 +0000
Message-ID: <b5ffd56c-ef29-4889-b2ac-ba334e86d059@arm.com>
Date: Tue, 25 Feb 2025 16:14:29 +0000
User-Agent: Mozilla Thunderbird
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v2 3/3] arm64: realm: Use aliased addresses for device DMA
 to shared buffers
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
 catalin.marinas@arm.com
Cc: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 aneesh.kumar@kernel.org, steven.price@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
References: <20250219220751.1276854-1-suzuki.poulose@arm.com>
 <20250219220751.1276854-4-suzuki.poulose@arm.com>
 <0b0705aa-8c85-4502-8450-a6c7fdbdbdbd@arm.com>
Content-Language: en-GB
In-Reply-To: <0b0705aa-8c85-4502-8450-a6c7fdbdbdbd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0131.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::10) To GVXPR08MB7727.eurprd08.prod.outlook.com
 (2603:10a6:150:6b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR08MB7727:EE_|GV2PR08MB8169:EE_|DU6PEPF00009526:EE_|PAXPR08MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf828d4-bb11-4c45-82e0-08dd55b784f7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?S1JqcWRlNWhBL0U4bUZDTkxqTEcwWDI1Y3JJUDVIWlQyRURuS2s1QTRmUlRD?=
 =?utf-8?B?VENwMzBaZW9yN2dKaGsvcDI2V2xmY2RoYWRiNWV3bytvQ3J1N0FKRStQUUhq?=
 =?utf-8?B?bmN5bC90K2lkbFdMUGFZazdYUUw3Rm50aFdCcGJOaHcrZTFIV0ExaWhzSlYw?=
 =?utf-8?B?UDJVcEdWUGxlRCt4bGExcEpYWUZPQU5MWDV3U3NJaTNOdzQ3K2h6V2ZKdmxu?=
 =?utf-8?B?Wi9wNndxVklQTnZMd0FuZlBDZmx5VEFVaDZkSDNSWUpDNnRWNnJhYUhXSzFT?=
 =?utf-8?B?aEg4dGV1cVhtMDdtMVNFcXpKQklWN29zNHhGYkxzUFhIOGpDTXdsMnVFNEZK?=
 =?utf-8?B?S0JQZXQxaFRldTV0d0N3V3NRZGZFdldXaDJNS3FxbUVLbjhYRGQzR2p4dXBy?=
 =?utf-8?B?cEQ4MmVoQUR1d291WXZZa3Y5c28ybnIrbVhCZFJOejVXcHVQM2RJOGFtRWs3?=
 =?utf-8?B?M3BvQXJnMlk3NURIcXAyRm9NSzJLVGc5UW1oRSt2K2dzRThpVit2eHlhU1VV?=
 =?utf-8?B?eWNKaFJTTFl2ODU1L0tzMEdhREt5R3dodWJVVFRQeFJyNzRBL2tVV0dxN05p?=
 =?utf-8?B?MDhZVE5iT3pEWGQxU0ljMkhVaGE0YVFydHNxMUZEblk0QVhrT0tZMzFwelV6?=
 =?utf-8?B?d0d2YUlxem9sRkhiQ3VnQVZvcUFjWkhuZDNVQTk4SEU1UXc3VjZpSitIaGFJ?=
 =?utf-8?B?S3VVNmdwa3RKYlBZUGxjQ1htYkJvYmVCaEdMU0l3dWVLODNNWmQ0cjNTV0Ex?=
 =?utf-8?B?TnZjbDRnQ2FxZFh3Nmg0V1RNV2NSdUM0a0IrSVllN2RLUk5kRkNHOWRRanNB?=
 =?utf-8?B?VGJBa2FOSnhadTJlRmdmV3QyN24vRnVvdytCQlVXN1oweDFqeHhrTkQrZVRx?=
 =?utf-8?B?c1R1UTJUcDEwYkxkSExXRXR0QjJhVU5HMjE4K0VFZ2VxUDc2d25HVlVhQWxo?=
 =?utf-8?B?R1E5ZGtiQVptYmN2akxHNEg0dkt1ektrWXF2Ni9PZnpxUFQ5d2Vaa2E3Wmc4?=
 =?utf-8?B?dlE3SXcxM3dOcUlWQm1ia2NGRGl5OVZWMncyYmZqTkJrdkZnRWN2Ujk1T1pw?=
 =?utf-8?B?ODR4eXFRYmlDc2pnV1l1SmNDK1dGeGxING1JSDA1a1NuendqWVdUVXpzZExS?=
 =?utf-8?B?bnZuUndFOS9oenZTVGVZR3dSWnpxSW4xbm5kbVZYdS84UlNoSFdFSGlKWUk1?=
 =?utf-8?B?V2VBbVZoUFV0dFFVc2kwNHI2TTJjbU1YUldUVmkxM1FSVlZZUUdyZ295VGw4?=
 =?utf-8?B?WGZMWG5mVk8ra3FhckxnSE9GQmxUM2FTamJURTBNYzk5NVdVcUR1RmR3TWJl?=
 =?utf-8?B?Y1ZhZVowbkFUWDBFRHU5Z0thNlB3K1lSRmEySFhzWWR5TldQa054ZDFBQW5W?=
 =?utf-8?B?L1F2TzhYRWJUa1Fma0E2TG1MTjFPQlIxRUV4SWQxSldLTXhoQUhwbm5MWTdm?=
 =?utf-8?B?OE1yQU9hT053Ylp5eDhTNm8rc3ptOEh4R0pQSEI3SHVITm5vamZUQ1J4NkE2?=
 =?utf-8?B?UUpZVkZwTU4vcHhxV2ZDQktBdUFHQUdIaVJMV3p4ZUdWdDV5dHo3YXhWUTRR?=
 =?utf-8?B?M1Z0dlRoNlk3d2FnV2RwZ0JHMTNBTDVWSEY4NzBvNU41RXdCL0Zmdlo3bCs5?=
 =?utf-8?B?WEJicFhOdFpKVDF5bVZmNXBvY1o2Z2lIV3RPS29MbjlNM3NWckNzZTc0STZx?=
 =?utf-8?B?LzNOdW1TTUpIeXBLSDdrbG1UZHp3c3dMVTl3K3lwK09jblRlc0tRQW15aUtT?=
 =?utf-8?B?UTRwK2hqcjJ6b0V5dmdzeGhEekxTNkp1eTVDeGhOVThiajUwNEEyRnFpN3Jx?=
 =?utf-8?B?ZmNGNEwwdHdtcTNoYmVNWVBkT29nWXhNaEl6em1tSkVMR05yaG1CZkc3WFJF?=
 =?utf-8?Q?S5dnt2Z5Z0mMJ?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR08MB7727.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8169
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:6b::6];domain=GVXPR08MB7727.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	092429f5-8174-4962-c5ad-08dd55b77c45
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|35042699022|14060799003|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHduaHhIcUUwcVBPeUxibUVjcGNudE8zWm92d25PalhDYktoa0ErUjZETkRD?=
 =?utf-8?B?aURsZVZGRWxGcEFPKzFCVzJVM0lBVFg2SzRLMGl5eVNZNVA1WVJ4WWJaU0pi?=
 =?utf-8?B?Y2UzMWtWcXFZK3NIWmhZTndqaXA1QitsaVV6ZkVIaTN6TEtHTnQ1M2hOSEIy?=
 =?utf-8?B?Rktoc1B5K2c5eVZURk9GVDZTbFBHR3VOZG1yVGlpZXppMFgweldhaWxZRGo1?=
 =?utf-8?B?dDhhZ1Z5UGZKWVNxRU5DS3dCaHR5czBLZXZtNnVMSFJqcXY3Vjk1TnVhRXZv?=
 =?utf-8?B?bVoyUjBYc3g3SFhtcHpCejNGSVF3RVhZK1NjSXl5eCtXTXJiSDltZWE3RUw1?=
 =?utf-8?B?WE5ZZllwdEk3NDYrRy9Ka2NSTkZMRFB5WnhhSVVBRkNwYXNmdXllOHoxYjVN?=
 =?utf-8?B?WktYZk4xcTNOZXBvZGFnNW5QbXNsQjJDSkdUbWxBeGcrQVFvVTA5VlBUUjNH?=
 =?utf-8?B?eEFOTGxsR3dMMXNlNEdoVmtEV2tSaGJ1TENlTUR5UFBMYWNrK1dCY3hMdis3?=
 =?utf-8?B?WVFXWStuek1LaVpSbUtnTTZsVk5RR2NIK1o3ZXBKTk5mRWJpZTl1K0xMZGtu?=
 =?utf-8?B?OVpIdTB2UnUvK1FyNFcwU0k0YXlNNEFCUHZjY203T3pDRkYxTTU4RUI0Z0Z1?=
 =?utf-8?B?R3Y5NVZXRGFmRTA4VjVnZldmWlpHNExhZDNiUUZuU28reTMzeHdsY2YvYVhr?=
 =?utf-8?B?V0J5R3hqblNWNzVjVXh3czM0MzlKMHZwL1Y1MzF0cUNob2UwWVRwNFN4Qi9w?=
 =?utf-8?B?M3ZTNjYyblFOM0xZTm9JQjVxSXVSL0VjUi9HTXpGQ3ZnZVp1Vk9KUmtVemp1?=
 =?utf-8?B?Q0lzQU00UHVoOVZKTmZYR2ZQNVBmNFVJcjZmb0ZhWXJRS1JMRkY4dVljbGY5?=
 =?utf-8?B?c0I5RTlQOFRmL1VnWGNhS0NZcjVJWlBoaWEwK2djbHNBR1FnZEUrS055Skw0?=
 =?utf-8?B?S2lIT1FFU1JEeDhFUnZZUExvaDhUQkxnRW52U2RITGY5NFI3VHhWYk1HaW1q?=
 =?utf-8?B?a016R1Rzdy9WcFl0MWdaeHBJN3k1SlFJSkozVFRDYWJPaG1jN2JPOHNsbFhP?=
 =?utf-8?B?bTg4OGdSUmZKK1ZKY0xWbTkweWpFTnlRWU1DSnpRcnRKazZrdmFvcEI1UHBH?=
 =?utf-8?B?aU9uNzNSTkw1bURLcEtzZm05TUZUaC8vWlJTa1RVZUU5bER2TFJaV3ZySFJ5?=
 =?utf-8?B?WnUweW9DSi91eTdBaWRvWmhIZVRJNW1pZjRmWW8yUDFBcURTa3IvSTR0eHpX?=
 =?utf-8?B?V1UzZUptQkZIc2sweG1UYi9XaVdoaGVER3QzVDVaaTYrZWVhUE5POUtDRFh1?=
 =?utf-8?B?d2xSZGhHLzNCK2F3K1VjY09GeGZlTmcyRUc2b1VEeEhib2ZRdTZMMEZzN0E3?=
 =?utf-8?B?QklMU01KTXFwOFVjQUhYZFpNdUJxZWVLSFlQWVpqdUhKQzgvbEluRk10VmZ0?=
 =?utf-8?B?T3FhdVhTZE1YdW96ZVJkZnd3RTBnaUhQWTM2VjN5YjRia3RkKzhmL09sK2k5?=
 =?utf-8?B?bjVoUkdvUlFjdmpHN0MxN0gwUUlpR1dESGJ6ZzBVb1RjR2ZubkJaWkFqRzhX?=
 =?utf-8?B?TUZFbExiTmtqZ20xYWRpMHRESXVRWGwzQ1ZKTkRuaEdLMDZ6cnVSUzVQYS9z?=
 =?utf-8?B?cC9ONngyczNabFJzWU5yTzVoakpoNnFNZ1NrWCtiWTllbitZUkQyWFliY3Bx?=
 =?utf-8?B?QldkQStFTUVJNzBzTGUvUngrQnI4eHZzZXVQWHFvWEllL1hLZmJNWGVqTlRv?=
 =?utf-8?B?dmEzSk4zU203QTZJM3ZYMTd4M0xlalJGbEFBSm9mVHB3QmZEajlMaEZPMmht?=
 =?utf-8?B?WU9HZ2VsMXBXZUFGaWJrQmYyemtCVzNWMnZQM3VXbzVnYjNhTi9mWjBJYmFQ?=
 =?utf-8?B?Z2psTW9Lek9MeklXbVhRcG5LVklNb2J4TE1WdTVyU09kZ1hqS2pZMGloSkpx?=
 =?utf-8?B?QnlUZnVYYU1vTkFkZTJGclRKZGxHRHAwT2Z0NEs1ZFFodyt6RisxZ2JWY1pL?=
 =?utf-8?Q?ONRybF7sNEXeY1apDCt9ZVEtx1gaB8=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(35042699022)(14060799003)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:14:45.4511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf828d4-bb11-4c45-82e0-08dd55b784f7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6334

On 25/02/2025 13:04, Robin Murphy wrote:
> On 2025-02-19 10:07 pm, Suzuki K Poulose wrote:
>> When a device performs DMA to a shared buffer using physical addresses,
>> (without Stage1 translation), the device must use the "{I}PA address" 
>> with the
>> top bit set in Realm. This is to make sure that a trusted device will 
>> be able
>> to write to shared buffers as well as the protected buffers. Thus, a 
>> Realm must
>> always program the full address including the "protection" bit, like 
>> AMD SME
>> encryption bits.
>>
>> Enable this by providing arm64 specific 
>> dma_{encrypted,decrypted,clear_encryption}
>> helpers for Realms. Please note that the VMM needs to similarly make 
>> sure that
>> the SMMU Stage2 in the Non-secure world is setup accordingly to map 
>> IPA at the
>> unprotected alias.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Steven Price <steven.price@arm.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/mem_encrypt.h | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/ 
>> include/asm/mem_encrypt.h
>> index f8f78f622dd2..aeda3bba255e 100644
>> --- a/arch/arm64/include/asm/mem_encrypt.h
>> +++ b/arch/arm64/include/asm/mem_encrypt.h
>> @@ -21,4 +21,26 @@ static inline bool force_dma_unencrypted(struct 
>> device *dev)
>>       return is_realm_world();
>>   }
>> +static inline dma_addr_t dma_decrypted(dma_addr_t daddr)
>> +{
>> +    if (is_realm_world())
>> +        daddr |= prot_ns_shared;
>> +    return daddr;
>> +}
>> +#define dma_decrypted dma_decrypted
>> +
>> +static inline dma_addr_t dma_encrypted(dma_addr_t daddr)
>> +{
>> +    if (is_realm_world())
>> +        daddr &= prot_ns_shared - 1;
> 
> Nit: is there a reason this isn't the direct inverse of the other 
> operation, i.e. "daddr &= ~prot_ns_shared"? If so, it might be worth 

It could be. The IPA size for the realm is split into half with the
lower half protected/encrypted and anything above that unprotected. 
Technically any addr >= prot_ns_shared is "unencrypted" (even though it
may be invalid, if >= BIT(IPA_Size) - 1), so to cover that, I masked
anything above the MS. But now when I think of it, it is much better to
trigger a Stage2 fault if the address is illegal (i.e., > BIT(IPA_Size) 
- 1) than corrupting some valid memory, by masking the top bits (beyond 
prot_ns_shared).

Cheers
Suzuki




> dropping a comment why we're doing slightly unintuitive arithmetic on a 
> pagetable attribute (and if not then maybe just do the more obvious 
> thing). I doubt anyone's in a rush to support TBI for DMA, and this 
> would be far from the only potential hiccup for that, but still... :)
> 
> Thanks,
> Robin.
> 
>> +    return daddr;
>> +}
>> +#define dma_encrypted dma_encrypted
>> +
>> +static inline dma_addr_t dma_clear_encryption(dma_addr_t daddr)
>> +{
>> +    return dma_encrypted(daddr);
>> +}
>> +#define dma_clear_encryption dma_clear_encryption
>> +
>>   #endif    /* __ASM_MEM_ENCRYPT_H */
> 


