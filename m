Return-Path: <linux-kernel+bounces-248114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E068592D889
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106161C20B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDE0198A0B;
	Wed, 10 Jul 2024 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="G5CEbez7"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022084.outbound.protection.outlook.com [52.101.43.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB1119924F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637015; cv=fail; b=T4CrZWm8Q8SfsDHlzfwuKP0PgpTA+Xby90gwHDTvxaVqjdv8MjCtpSIY2VM/JLTCkUyuUqgR7EssNmQ6TnZokVKPVXGNO219PgnHpQsdLBxgJOMC7XAxL9elGTl/vb3t8uJV06PbWMh27JP5Am0x21yzDnSS5wNYpeW8vqu9mJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637015; c=relaxed/simple;
	bh=laVfgRPqEmm5p9QZNCnZywozzXqIpejZ6TfkkjhPqmo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pic8vpwi1IKJY454ddvIKBizjLYeKv0D1AHKzP2esTvEcUe1lT8CzJB6Hidsom5YpeLY+DV8jAI8AO4gcJmvV6ZwKUuAmvJek/6BnWjfP/VTmYar3FPaN2a58RghXb9/+tCP8Op9itiAFSZlNzbJp6/yUlnDLBtuQGBoOk5Rkns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=G5CEbez7; arc=fail smtp.client-ip=52.101.43.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrgZ6AIrqsf5PYFtNJJ3qAmNh0q6ZXyiv2JGQpmJQ1Whk5HPnlBnOqr7+RHOYV+WMlPCLMR9X6cE4UjPQSOenKtJL5W4QWAsMiy3oeFvCsVKFGlrTWaJD/H/qcJl3DJJp5VQLE2Rg5jl6pMf/vbXjFR+zwv24TH9DVQEcXhBiP28nwHHHI4ugS0hXiI8eBvyvRZkT/3KGjpuBrnxGz7+/RfYmwb6V5KERSyHUvfukixqw37UUC2CbcHvmL68X/UB0m7Rj4CNMSw/oDl0YQiJYl2qua9t9Lcpl+i17APnBnQmkvBGt+Ns5GMFEMbsHawKLLKy1r5NwgjtmD+hrRp7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeiX5/SeTwQCcDsi1vM+HcY79gVcUSyjeT2SyjKBCNg=;
 b=oGyUW8/jvt4+ItCnNLkiaXGyf5XXbnHoQzQtjORc3yL23fB8n7Bcm14Ztrj2+wBN8c1agskD6vFiqvlo+W7fCE4Yvf8pD7PZMf+nZzikpweAyk/ido2oH3Bx+n/Hf8707rWrEaWIcmTy4CAQwlNfHhqBFA84TWtfbzqQSayJte/DNMjvf0Y55WYLBHyatlYKyqBpf5kNmRvtgJkiiv0aJhaGqwl/rf6CJSQmYDTxvI2r3d6/K5RfMqz3UVGM3xzS0yH4C000qzqsvMtUtpH3ticMmz1jnRIhpeDNI3kUgbSKyFzv64v9DmaepKg5JTXTpHZZBtadx6GokC4YPViH+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeiX5/SeTwQCcDsi1vM+HcY79gVcUSyjeT2SyjKBCNg=;
 b=G5CEbez7/l98PWoi8nUW3czLdYiXE18bxuKjEc80A9Q52ic0+IH1cuyeliFLUuMlFAtGz/F/FdhDtekv2EG7ebwQpGWWJQscFdCnL0aogMHAdGJ02bSRmXlfq1xWFsmm82rePXSMcJRleWcxphfXdw+Pk6xUZaGUjN7hPXBOdfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5471.prod.exchangelabs.com (2603:10b6:208:11b::13) by
 PH0PR01MB7351.prod.exchangelabs.com (2603:10b6:510:10d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.20; Wed, 10 Jul 2024 18:43:28 +0000
Received: from MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80]) by MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80%7]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 18:43:26 +0000
Message-ID: <6167c4ce-fef0-4af4-a6a1-9fe7b2eb023d@os.amperecomputing.com>
Date: Wed, 10 Jul 2024 11:43:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
 anshuman.khandual@arm.com, david@redhat.com, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <Zn7q3oL1AE8jdM-g@arm.com>
 <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org> <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com>
 <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com>
 <ZoZzhf9gGQxADLFM@arm.com>
 <35f70ba6-5305-4268-b7ba-81545cacd83f@os.amperecomputing.com>
 <Zo2C4eXr5_9kifyO@arm.com>
 <cb0bd817-6948-4944-ab09-4ec2aba41cfa@os.amperecomputing.com>
 <Zo5S1JE8B912SHya@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Zo5S1JE8B912SHya@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0136.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::21) To MN2PR01MB5471.prod.exchangelabs.com
 (2603:10b6:208:11b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5471:EE_|PH0PR01MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc15161-6276-4b56-5d6d-08dca1102d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnNZYnNvOXh3eEthTXJOczdRcHNRT0tmTkpRT0VqcVQxTzlrVWEwdms0b1JC?=
 =?utf-8?B?MHEza1I0K25kVHZBY2RDd1NJMlNyNmU0K21EYUdUY0FCeEMxZFdXOHFXdGpp?=
 =?utf-8?B?N2JvM216RVMxRkxxejRzYnA0OVRsajdiTUIwQzZsVWF0Z0I4RkRkMFM1ZDBO?=
 =?utf-8?B?czAyQnJ2eHkvTnVobDlYdEZ5NWdneWpwTEdTQWZzN3lldUZrTzhhYXNtb3VM?=
 =?utf-8?B?SE1HUjhQS3BZSXRpTjRJZS9VRUp5VVhBeTJGaTV0eU8wbWNyS1FxL3IxM3pN?=
 =?utf-8?B?b2pLZlhaS3o2am9tbkNrbXdVS256MlYvZEh6alRYZW41YkhqMjloY2gzajNv?=
 =?utf-8?B?RHVlanFUSmtFMkE4L0tpMTB3czRNVWVCRDFUZWlkaGExMVByMFNmZEo5NVFQ?=
 =?utf-8?B?cFBsNjFhclVtM3kwb2pTSGNTWlYyL1ZOT2hoeFlwZkszTW9XV2xLdWNuOURE?=
 =?utf-8?B?R1hvMXBlWUQwU24xTHNQTlhoQTlZWjVXWmc3clZBSTBCdHZXR1dJQmh0aXYw?=
 =?utf-8?B?eTVmdFNrY2E5UzI5dS9pbC9IcEhSSUFFQ2VMT3VMdzZaQmUvc3RWVys4UGRX?=
 =?utf-8?B?LzQzTFZHcXZTTnZPcE12MldXM1lpd2VGNStJMkE1UDAzS2lBa0k5SmFzMHdW?=
 =?utf-8?B?b2VFZFE1bzBiZU1lQ0xjSk93aTVCRWRpSzV3TUdGNkNUNXErbFRFYU52SUk1?=
 =?utf-8?B?ZmNVc2xMalF0SWVibzI1Y3Vpb3dmN0tjODJUc25MbjZrdzdNdk9VWSswWUxO?=
 =?utf-8?B?aEY3RVE5YnNBZC9tTWk5T29KaXJ6a0hiSWlKUitpR1pLY29uRlBvOUFUOUdT?=
 =?utf-8?B?K3pDbEdBVDZ0b2lhYzVndmpTTjdjcnJ5RnFYU2cvNjZ2cDFjWm1wUDBTZjc1?=
 =?utf-8?B?SXdZUTB5V3IzamE4OFpjRGtLUS9FUXhZTFhQQ1pveVB6c0ZNYWFQNDBaVXRF?=
 =?utf-8?B?aFpqWTFPaFQ4amk0aEtXakJDSVQ2dVNUSEFCdWx4U0F4V1ZjZ2QzVzAwRVEv?=
 =?utf-8?B?S3A4aDRBbm5CRm4zY3RYYTYwMlByTENHZFRkVkJGNHBnMWNyUGp1UW1aUmRB?=
 =?utf-8?B?Wi9QRXY5M2ZIRDJHZDc0RW5VZGswa01NMkNpUytDaGpQcWlHbFJSRkovbFZY?=
 =?utf-8?B?bW93SnlhZ0ZyTXNXazRzN0xKN3N5NHp1Ym1yQkxMcFN3c3dCT1RiWVRhUFVz?=
 =?utf-8?B?MnB2RHkrd1J4NC82a2MrWUgya2JiRWthdm0xakVERzlwWTd1TVl5b0NrYTRv?=
 =?utf-8?B?eXZTSXk5MzNkQmxxUzROWHpwRGR3Zi9UZFdkY2Q1SUQ5cngwanBpRHY0dWZu?=
 =?utf-8?B?SmFydkpwUXZKSHVtRDE4d09uaXFZV28rRml2akR3MkhWSitVcllzUllYVEE5?=
 =?utf-8?B?TG5QSkFEU0grWmdjb0pVRUhqY3BkRlozUktyT1d2d0JHb3BQNVdpbmlYYjlS?=
 =?utf-8?B?b21ZcFFxSTM2bkdTRWhyKytoaEYxSVdRdXJIQ1RLdFI5NmRaUE9hSHUzampV?=
 =?utf-8?B?V0xHVVBYZE83eHpaQklUbTY3aGJibllURmhWNVZnc1UzSldkMmg3SW05bkRQ?=
 =?utf-8?B?TVFJSkpqMFZDd3BHRWlUTHhYbFJpSjY5TzZ5UGJyS2p4blUra2dlZzloSFRk?=
 =?utf-8?B?Ymp3M0FiYUVKY0RZbGdyMnNnWXBhREhTdnRwU3VTaFdUV0pzUDZqWlVPMWQ1?=
 =?utf-8?B?Ny9mMGNQdUJIbldsN3J3ZlpHeXZ2VW9sLzkvaFJmQkR1d0ltbnVUbE16amYr?=
 =?utf-8?B?ZnlYcERnZDNwb0E3NzI1QjBWdHNmN1B4UFMwUnl0R1VGbngrTzRLU0EvUDhO?=
 =?utf-8?B?T2toWlRUQTZua0x0U3o5dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5471.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFJod0ZtekRta2dERXdWRjRqSnhwbmsyZ3YvNTRXaWxFRXRtazZ3THZwL3Nr?=
 =?utf-8?B?NFd6VXJ6YkEyUk9LSHlUdkxGbzcvSXJkeHdmQUlIeU5hZlRUQ0ZUQTc3YXNF?=
 =?utf-8?B?S0RXR1ltYVVNY2NqTllmbDJKL3M1dTBUSko0NElFNzJVVjBCM1BkUzNZME1V?=
 =?utf-8?B?SEZKZkEyemZkSit2bk9CMFhjN2hMNUxySTgzN2NaRmRUcXc5bCtEZ09yejBj?=
 =?utf-8?B?cnYvNS90VmhlRUgwUkVrWG9tQi9BU3NoaTN5YzNFS1U2Q0JCb29sWG0wWGZa?=
 =?utf-8?B?Q0d6VkJUQnpjUVZtcXhldkpSSWZORVh2YUYySjhnVnB3N3NOR1d5QWJLMDUy?=
 =?utf-8?B?RjN5MWlDTDhPSS9UdUtRZHFud0d4R0NjYUlhY2dQbUtoRDhHdkFCdXBxRjZE?=
 =?utf-8?B?cFJWbWZGVWJpY2loYUFOMHFYWUptMkNYUTkwS1BabHplL0JldlNLUko0Rmk5?=
 =?utf-8?B?czNyamdkY2tqR2NlRG9jekxNTHliWUlJTjE2bWhNQ2lZdnpFdXgwQUJIOFow?=
 =?utf-8?B?UWZ6RDZjVlhPUWp5S1R6TlpmOWdxYzJCdmJNeUNxL0FRNnkvaHFLVTRmWFM1?=
 =?utf-8?B?Yy8zemZHQ3lvamtJb0c4cEFuc1plUzdYQSt3ZlpNNlZvRzkvQVpMbGcrUEtC?=
 =?utf-8?B?NGNNYzFwb1Y3Q1BhK0ltUUtoSSs5VVpWMG5sWEFoY2VCdERKWGhQU0NvK2FY?=
 =?utf-8?B?WHczV0d1QmdzcXJ3WjJzTU83dTdtWHVOV3F3Z2J4NkMrYVVjVDdSd1VCTjBH?=
 =?utf-8?B?aTR5eFdKRnRoRVVNcis2Rkhackl0bTNVMVpKU2xJeU9tbmMybW1zY2E5ZHhI?=
 =?utf-8?B?WlNyN0pHSC9JN04zRm9qTDFvZVIvaU1YVFhrWjk4Mk4vajJxZklGOVRJMitI?=
 =?utf-8?B?eXdkSnNxelNPWXFqbDk4MFc1dUFHZjlza3creDlPUW9OekJmMk85V1Zna3Vz?=
 =?utf-8?B?NjgvSGw5d3NISnQzUHZYbHU1MXFFS3kxTERFTFlwUlBteVBGZ1NrR0tuWllM?=
 =?utf-8?B?ZXhqOEhlQzJNdUd6ajFCYWRrSy9pMEp3eFRXbEZiV2hWT3krVk9IUmp2ME5k?=
 =?utf-8?B?aWlrcDB5a2ZQRG5wL2E5L2FDcG5JZFVob1I5NVhFc1JOaDBYRk01QXQxUEla?=
 =?utf-8?B?dnMwWGVwblFTdS9kRHRtNUJ5UXZlSmowekorVFBUTHFXemc4VXdQOG56eUE2?=
 =?utf-8?B?V3QyYWhHbVVweG5DVWN4dlkvMXZiOHpvZmcwYWNiSzg4VFFDVURyaHRqakZs?=
 =?utf-8?B?ZEtWMVJacXdiVnJXZkxOWVRURXZpTGFLY1dKTk1jNmZzMld3U3NnMkZzWTR3?=
 =?utf-8?B?aTE0RHpCYjJGb3g4SEFnRjI5d2dBZ3JOOWhvRjRsV0htVThSSk04c2laSkw0?=
 =?utf-8?B?ZkE0dUxjUEY3MS9JWTY5Uk5MVWtieSthS0xSblBHdTZwRW9ra3FGa3Brbmlt?=
 =?utf-8?B?TDRLbWxYbXMvbWg5YjNmYlppOFZBdTVBdTU5WHNLQ0ZXWjV0azVrYllHTlZG?=
 =?utf-8?B?L2MxRVJsalFQYm9tOUN6VjNRbXFpalJ5VGM4ZGVsaS9WMGpoQXNXMktoM0VE?=
 =?utf-8?B?aVNWNGRiamZnNHNseGRXT0lRbGpOaTZ4aEs1NTRiYlk3VXNsYlhlZ2g5ZmdN?=
 =?utf-8?B?WFYrQkkzRlV5ZGQ1RDlKYk5qTTZYSGUxWW5jeHVPRUdjUkNOcmJlREg5SVND?=
 =?utf-8?B?S3NHWEJmekMyNnprekpxNmtnbDdnWUhMcm90QnJwOVZLamxvck13OGpFWlNx?=
 =?utf-8?B?dnZ4bG9DcHdpZTdUcVBuWVl3OUtUNUFYVTZza2wrWndGUklEUVY1eFg2MVpD?=
 =?utf-8?B?QklLY28ya1VTQXpkZDRmNjgrRWwxS0xseGFCT3JPZXBQUmJ4ckljZGp5ZXI5?=
 =?utf-8?B?d2VVaWlhTERHUFFPMytCaFJuQW1MYVFBMXY3YjRScWQwSXdFSHJ4cHRSTkY5?=
 =?utf-8?B?N2E4VWtWMFBDMDFiNmJXMFhmTlN2ajVLNEFPeTNnOFNJai9zRFBQeXlsbzFk?=
 =?utf-8?B?R1psK3g3RWNoTjBFRC9PR1FVRzJaUHZvbHc5aTFXU1VMN2FGSzIxTXpsckxi?=
 =?utf-8?B?dEVwRWNFNndkUUEzZU9pMmM2eEpWalNjaTl6Ty9EQmV1SFJVOUpFNVNIOENs?=
 =?utf-8?B?SWk4UlpBaFdNYlFGMlZNcFl2dlAvR0NPSkovOWFyQlJ6QXVkd3owMUdMUFdY?=
 =?utf-8?Q?IvVyK8aJC8N3ZrNiKW0KEmg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc15161-6276-4b56-5d6d-08dca1102d89
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5471.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:43:26.8228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pP0iwaG87vUgpkB1mu4zm0hnCGFPskr8MTPzDXUneAK+K2VXs7DuCRdxD/VIN8Gffend9Hj5v4qNCT8LEHRgXVfI2PifEYvbw8KPlNqyI0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7351



On 7/10/24 2:22 AM, Catalin Marinas wrote:
> On Tue, Jul 09, 2024 at 03:29:58PM -0700, Yang Shi wrote:
>> On 7/9/24 11:35 AM, Catalin Marinas wrote:
>>> On Tue, Jul 09, 2024 at 10:56:55AM -0700, Yang Shi wrote:
>>>> On 7/4/24 3:03 AM, Catalin Marinas wrote:
>>>> I tested exec-only on QEMU tcg, but I don't have a hardware supported EPAN.
>>>> I don't think performance benchmark on QEMU tcg makes sense since it is
>>>> quite slow, such small overhead is unlikely measurable on it.
>>> Yeah, benchmarking under qemu is pointless. I think you can remove some
>>> of the ARM64_HAS_EPAN checks (or replaced them with ARM64_HAS_PAN) just
>>> for testing. For security reason, we removed this behaviour in commit
>>> 24cecc377463 ("arm64: Revert support for execute-only user mappings")
>>> but it's good enough for testing. This should give you PROT_EXEC-only
>>> mappings on your hardware.
>> Thanks for the suggestion. IIUC, I still can emulate exec-only even though
>> hardware doesn't support EPAN? So it means reading exec-only area in kernel
>> still can trigger fault, right?
> Yes, it's been supported since ARMv8.0. We limited it to EPAN only since
> setting a PROT_EXEC mapping still allowed the kernel to access the
> memory even if PSTATE.PAN was set.
>
>> And 24cecc377463 ("arm64: Revert support for execute-only user mappings")
>> can't be reverted cleanly by git revert, so I did it manually as below.
> Yeah, I wasn't expecting that to work.
>
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 6a8b71917e3b..0bdedd415e56 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -573,8 +573,8 @@ static int __kprobes do_page_fault(unsigned long far,
>> unsigned long esr,
>>                  /* Write implies read */
>>                  vm_flags |= VM_WRITE;
>>                  /* If EPAN is absent then exec implies read */
>> -               if (!alternative_has_cap_unlikely(ARM64_HAS_EPAN))
>> -                       vm_flags |= VM_EXEC;
>> +               //if (!alternative_has_cap_unlikely(ARM64_HAS_EPAN))
>> +               //      vm_flags |= VM_EXEC;
>>          }
>>
>>          if (is_ttbr0_addr(addr) && is_el1_permission_fault(addr, esr, regs))
>> {
>> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
>> index 642bdf908b22..d30265d424e4 100644
>> --- a/arch/arm64/mm/mmap.c
>> +++ b/arch/arm64/mm/mmap.c
>> @@ -19,7 +19,7 @@ static pgprot_t protection_map[16] __ro_after_init = {
>>          [VM_WRITE]                                      = PAGE_READONLY,
>>          [VM_WRITE | VM_READ]                            = PAGE_READONLY,
>>          /* PAGE_EXECONLY if Enhanced PAN */
>> -       [VM_EXEC]                                       = PAGE_READONLY_EXEC,
>> +       [VM_EXEC]                                       = PAGE_EXECONLY,
>>          [VM_EXEC | VM_READ]                             = PAGE_READONLY_EXEC,
>>          [VM_EXEC | VM_WRITE]                            = PAGE_READONLY_EXEC,
>>          [VM_EXEC | VM_WRITE | VM_READ]                  = PAGE_READONLY_EXEC,
> In theory you'd need to change the VM_SHARED | VM_EXEC entry as well.
> Otherwise it looks fine.

Thanks. I just ran the same benchmark. Ran the modified 
page_fault1_thread (trigger read fault) in 100 iterations with 160 
threads on 160 cores. This should be the worst contention case and 
collected the max data (worst latency). It shows the patch may incur 
~30% overhead for exec-only case. The overhead should just come from the 
permission fault.

     N           Min           Max        Median           Avg Stddev
x 100        163840        219083        184471        183262 12593.229
+ 100        211198        285947        233608     238819.98 15253.967
Difference at 95.0% confidence
     55558 +/- 3877
     30.3161% +/- 2.11555%

This is a very extreme benchmark, I don't think any real life workload 
will spend that much time (sys vs user) in page fault, particularly read 
fault.

With my atomic fault benchmark (populate 1G memory with atomic 
instruction then manipulate the value stored in the memory in 100 
iterations so the user time is much longer than sys time), I saw around 
13% overhead on sys time due to the permission fault, but no noticeable 
change for user and real time.

So the permission fault does incur noticeable overhead for read fault on 
exec-only, but it may be not that bad for real life workloads.

>


