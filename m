Return-Path: <linux-kernel+bounces-410802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF05C9CE125
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8991F21BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06AC1CEAD6;
	Fri, 15 Nov 2024 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uZnmPiz5"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692AE1B218E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680551; cv=fail; b=NFMFqoE3isuIWv/vN2OGf7g8tFtD9RlPtun/4kwJrYm1oCOZ7C6ED/OV2aLBNEzSOZbZtdcC0+lNJdvJf+C+aSPOeQ/11EFPBHwEP72wJ8HId77us/6ygGgHeA3R75D84p7NgeM0fytSVeMQE1x0CvDFYb1DnKNI8i6ceyP2B7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680551; c=relaxed/simple;
	bh=XGytDwtxJzmdZZUB+sb6nOj2nOWhjxaYWgR8YaqB0/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f0iBNKERxnn55T521ka3u7pEVczK9Nk0CYZsJ8z2TKPBnOFN87W18SjwiEMLjQudBNi/AzNMVz41qokgT+9gO8hZ4zpBdS+DGcoJlTWdqNx5Bz3/u77I9NmrpUwa/obW8TohXawm3zocyL9v1nr5ewVp6T8CVRSIgrqLWcMuFe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uZnmPiz5; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfewNL9ZGDxRuw0/L+ECu/dcqykqRVcsRok/CEVVX8bxtbys9Xst1JpFCEbtAmQxiTnbTV3Wjt3o2rR97MoUibi4k5OdHxaNFB6UWL+K2QqrJ8SMGHREykJ8QrxlSTRfBZ8ok/VCWr7Cxp1Z/hQU/hyWgyTXkWBxpNTSBbv9z+d+tcznUm04UKvA2/npyQT/AEvHlhZNWybI/Kr+SDEufGvq7ET9RJzaZbdhFeB96z2wtZRJ7Ci0ypDHRFg8qPP04ix5wUCYVnRR7Y0qmMTHPeCcVhDK7Vrr0supxYDjcLS/0ArhgHRPOsUacnskjpK1cU5w0yrFYl+doPmGfJK9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75KjmkmTSUJ+g3WSdT/s0X1nRRlDDVx6S3HKNXENNOE=;
 b=QlSt1++GnMVhkddzO9fJfyxTmiTrs3aiiaJWzgCapbUR6wXfw0pS63yTGII8SRJJuYz6VcJWXusmCVhFFiVQsVuipCkuIz6FS89a/s8knnFONP+LS3EaTsLljA8sFMr2C4lmw/Ki5vjHFZ+kcSNyr1oumiBou1mk6RhQ2HDj6f53vQnXgJwjDPAHhrkDNitLfRa+i4py2x5hJpSU6nUNW21MGPv06Od3l5nnml0jCnt1u3698mdeKg/6MR5P16w6yo8q/0P7duErWTXZZOu+aGzKXNMUZC6Q6uafBE7UbBxgpd0+s0027UvKdd3qTPAMuzj2TffPyccD1o1AaejYsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75KjmkmTSUJ+g3WSdT/s0X1nRRlDDVx6S3HKNXENNOE=;
 b=uZnmPiz5E3Mlm+JNh0hvKhE/xnQmkIFYN6BKdXC8cdZC13NACCOIboa41hEqHucA5y3ZqEOcezpYeCOna/T6PlwTAKSw06AB+7yccyIvDe3GxEOKr9EGnX323Df6mSkIu/7ubjjzU9Gn6JHQDX7lVk/KbduiLnucjPcitmmWhcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 14:22:27 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:22:26 +0000
Message-ID: <d6c946f5-8e7c-ca06-ed0a-4d4e8a82d679@amd.com>
Date: Fri, 15 Nov 2024 08:22:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] x86/ioremap: introduce helper to check if physical
 address is in setup_data
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org, bp@alien8.de
Cc: x86@kernel.org
References: <20241115012131.509226-1-bhe@redhat.com>
 <20241115012131.509226-2-bhe@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20241115012131.509226-2-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0108.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::29) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3008aa-eee0-4d5f-9944-08dd0580ee42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHY4T2pPa2ZtT0g5NGFsbmZBTjN5cHdJZTJCVnkrcFdSZWQ4c1NpTVp5WEsr?=
 =?utf-8?B?b3dTYzFCZUVnWlp4K1ZYY3FxMURLMWZPN0d0Q0lGRG9jM0FpMEdaaG9lakc4?=
 =?utf-8?B?SU9yV3ZBYXdZNzhkNWIrVDJQQUpxUXlvZHd5K1RQdFVqejN0Z0pkcERXQk9v?=
 =?utf-8?B?L0d3ZjNMWGtxRGtoRFdpMk8xd01yUlVaWmRhRndUQS9jMzVxRkhLVThySHc2?=
 =?utf-8?B?cHdiekFJMVQ4SitleVp3YXFhOUpMRkQ0MldpamxjY0M4Vy8vUHVlODFPTXdq?=
 =?utf-8?B?eUpsMWFhM2hEVDhKQ3QvNGxvTVpBRTUySDRRSERKemhmd052RnhoWlFqeU9P?=
 =?utf-8?B?WUZEQllXRGxYZGcwQnpEK0RaQWIvaG5vcHVjQ2F5eWJHSllLS3ZBRjIycFJD?=
 =?utf-8?B?cmFvd3dpMEFHSHp0MDVLOGtPR09uMC90N0l0dlVwVXV5UWRza0srL0krY1Ez?=
 =?utf-8?B?R2NEZU1NTGNHSUtxNnpTTDF2bDA4RE5QRU1RL3BlclBJeG50eGo4R2NkaCtu?=
 =?utf-8?B?Mm10VDNMYVdQMGtrbHJaSVdSUzVKYXFWeDlMa3VjYmVVblFBNzF1dWhYTEN1?=
 =?utf-8?B?cTZ3ZHFMQU5OTEN0WERuWHBmemMxTWM1WVN6TmZnVVhXZDFMSE5OYWYvWlZw?=
 =?utf-8?B?bWZCcGhvMkVyaDI4VkJ4ZFFVbG1aVzlyakhFTSt3aWdIaEVXZVd6Y1RSL3pp?=
 =?utf-8?B?czN4RGl2Z1Z0a0xITGtqVnBDUnV1UlY1RVp0c1V6c2VRc0Q5anpWQmVqaS9Y?=
 =?utf-8?B?UGdLREVuSVdFaDI3dURVbkYwMFdyVXc0UFFXcjRhdlFVZnR0ckc0L005OXlV?=
 =?utf-8?B?SjdmZmtQNUtva01TVW9UNUZnczJ1YXZFQmhOcWd2ZDFjM0xqMXhSNkd0ZndV?=
 =?utf-8?B?dldDR09sNjVFdks0Rkt0bHFqbUF2N0hYL3Zaekd5bFVDMFJjWU5NZ1diYWY5?=
 =?utf-8?B?UmRCWUZrMEtQeUVPMXR6Z0pzSTA0VTJPa3ZyeDZpRDJSM0hSanNIN3YwTzYy?=
 =?utf-8?B?cUtndnZqa0JORmFielpvUDFYeC9iVkFXSGtDRldGSGEyTHRGM0VzTGVEeVJ1?=
 =?utf-8?B?d0I4bFJMblZlSCtGQUJxKzd3M1dSVysxcHYzRDhEODdmM1BnbEIvQnh5aUZW?=
 =?utf-8?B?RVJOSklGM2hoMzFhVUFkcURoNlBSenhCRWxvbnA3ek5sbXRibjB3YjdjaUdU?=
 =?utf-8?B?blRRMUI5NUJEeVloSXhMc05Yd1BkcVYrZ1BDbHBwcFVBbml0Y3A1NDFWMmx1?=
 =?utf-8?B?TDVjTEEvb1REZVNPUjU5OG81MWFTenVDTmxwMDFoQkZuN2tNaFprV05WdGZF?=
 =?utf-8?B?WGxlTTBoRFFvc0M5Zk5BT1pkc01QcU14U3NnMWlDUGlJM2lZY2NObmZOS0lW?=
 =?utf-8?B?ZkgrZ2Ird0tnNjdIUjhEbTBEYkNXM3c2WTgzOXRzNEJtMTErY1RhN0xzOVEz?=
 =?utf-8?B?anJ6Q0V0bGZFQjhOb2JCZUVFRmpua2pNNjEzdldaRk5tTlhPN1o0NDF5bUlU?=
 =?utf-8?B?T1FiT1cydVQrMHdvMVFaMmVqN0hvWkRXSVNTTEVJSGtrZmRIeE16N2x2Nmw0?=
 =?utf-8?B?c1Q0TWdwRFN6dlBacUFJNjAvTWMwcEN3dlpQUnU2MnlMMHVmSzZ0cTgyQkdv?=
 =?utf-8?B?UG4wS2k3Q0F3Y0ZXQjBtUnFjU0xmS3p3OUwxcVY1ZlZkOHpjZmZXM3pZTi90?=
 =?utf-8?B?ZlJteldCcG8yN3djUVA0S0RJeVN4eGk4cm1DdFJ2ekt2bXRPL2VTcXV6MGk1?=
 =?utf-8?Q?UNJOG+JeHWQd37dUqj+AOJ1cJ0Ex2ihl0chVXs6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTg2RGxuMDJjVlluZVFuZ0haQ0pvb3hLdUI5WEcvdVVmZGZzUGhBUEY4bmJo?=
 =?utf-8?B?aTNYWnMzaXhQK1R6RlM3S2JQejA3RHl5Z3YxeHJnaG1rN3pkVmpXWFdCRkN3?=
 =?utf-8?B?TitaaG1OcFJpd2lQWDNvK0MrQjdJOXRkR2pkOUh4VCtod3VsdGtJNm04MTlH?=
 =?utf-8?B?MWVFSVJ6WVdFazA3MEtRSTUzSTVKL3hIaXJ5LzR1dlo5d1hXa1E3YUQ0enNY?=
 =?utf-8?B?RnVLVjMxa29oUmlmSjIxRzVzTEEzVnFuQnVKVnY4dlhoVDhSdGtaWVY0a0ww?=
 =?utf-8?B?bEkzdEhjd290ZlBqUzdtUHZQTmtqdDU1S2pzRXdiY2JRb2c2R0Q4TlgzRTJ2?=
 =?utf-8?B?cytVQVB5SzNpQWkvbEgzY2pmVGhSSnFnd00rU2p2WUcvRTFja0txbmdpUzFn?=
 =?utf-8?B?TzUrZW40TzNLa2luUTlENDk5c3M5S01EZ2hDbEkwdHhVNDFpd1NYcXZ2NmRl?=
 =?utf-8?B?L1Jza2NXUlpOcGJybEc2cmJrWkZRS0JrckdXU2JsMlJ0UDRyWVI3UUdNa1J1?=
 =?utf-8?B?TE16UmxvVXpObmFxMTV6aTBTT0F4bUJxNFdvSUpUOUlIbUIvQlZFSG1XL2d0?=
 =?utf-8?B?U0ZhZitudGJDTDdIU2xWbWtyN2pHU3J0bTdhTzhYNllwNjhuSW9GSEgwaVBq?=
 =?utf-8?B?cC9GVzdJS1lTWkdGWmhLampubjdMR1RrSTF3RzdqbzFueEJzVEh6OU4xWkc2?=
 =?utf-8?B?emV4V2FQSUNKVU9kbDU3bEpBTENsWElPdzk1VldKdldTWEw1QUZPaVVxRWJ4?=
 =?utf-8?B?RXAweVhFZCtQdGI5NlpjbjZZRS9PRVRQbWdJMVlHbTZSNVJLNFVBL01ZTXdu?=
 =?utf-8?B?djBmODgzbkw1ODVBREliTTlTUjlZN2hrdUJnWUsyNklXZDdDZUt2cEdBUzJJ?=
 =?utf-8?B?Rmk4TFk4TFFwbWIyWC90NVpLU0FLWDFIWUJoVW92UXB1THM0WU0vNzFVOVA1?=
 =?utf-8?B?cVRPYXBGT01GQlIwYjhQZStjNjhZUFdhSlFrWWE4c3UxU0k3Y0c5cytQbHNr?=
 =?utf-8?B?d01uRnhna2dHR3pKcHh5bEpsQXhMRTRMWi92ZEErT2hXL2c1R0lhSUtVcURk?=
 =?utf-8?B?RzhNMWlqVktGZjExLytEckZvdHJWek5Wd2QvcFZnWVNrZ0ZVQkVablUyOWZF?=
 =?utf-8?B?MU9SL2Q5Q3F3M2hhVDcrZzVIMzBnQTZ4Z2NqVW9XR0NjREFzMTFjWFE5UjRj?=
 =?utf-8?B?c3Q5RXJ6RmI5VW5tc1o1b05Jc0Y5MW9uME5pc3Y1MHR2MnAxQ1ROOXl2SDBE?=
 =?utf-8?B?NEpSckVabGx2NWNkY3lMTGt5dklSTHBQclE1aHg4WGg5UVpZanNxTVRXWEZP?=
 =?utf-8?B?WFpUS1VjK3UvMjhlNzUzOGJhRG16VGFTZUNpUjczQUl5MVhtcXZOYTY4UmVv?=
 =?utf-8?B?dHRQRmFUb0FQOE9QMUhPSU1XQ1FiVzlXNjdyc0F4b1RQWXVxS3RqZDJtWXlx?=
 =?utf-8?B?VlpFOGdmZ0hwamFyYy80Z1BYTWQwQm5WTms4SmJVWW1pd2x0QTVQc2d6aTNq?=
 =?utf-8?B?d0Q2dHh4RnQwem92STNLQU5uOXV0L2NlK1RxRVFTMVNheEcybFo3N1E4cFA2?=
 =?utf-8?B?b1FzckRramV3SWZ1UUlZVjE0cWozR2cwZm4rOEFIZGl5cU5hVmpUYTYrTHJn?=
 =?utf-8?B?WGtqSDNVY2V1NkVQMXhnOWJsR01EVE9CeEFucWZBUmNicDFDOERxZ1BBUVR5?=
 =?utf-8?B?SVdQdFpLeUdMQVZRRC9OSm5RQWJuYkpSblV6NDhtc0dHelpGeGl6U082KzZv?=
 =?utf-8?B?OUpmdnh1VFRXc01oYld1ZWpKTGpNcHhBb0Z6dFRwcVhqVm1aYWJOYWNNekdB?=
 =?utf-8?B?S2pqWUhNUC9HZ2FPWW1EQUk4UVJ3VzYrR1lXbkFrUy94VTZXbmd2NTlkeWJY?=
 =?utf-8?B?VE45SmtoYUIzV0w4dXlWNnFsNWtUb2lSZmZLU1NWQlBqT1RUQWlML3VGVUxB?=
 =?utf-8?B?VDdBbW45VWIxSTRRYmRFRkZ5MGhnb0t1MEREbUFaTkdIZ3NmYWhXWXFUN3NE?=
 =?utf-8?B?ZWYrU3diN1RLby9pTlZLWlNNdnVUZHV0Q0REKzZTbHZ2SU1yeEtrRmYxWStB?=
 =?utf-8?B?VkRCdzFYRDZoVmNuMGZENTRpSi9ORzNYMTdzNFFWTmZwaE1iVjhrQjBFTm5j?=
 =?utf-8?Q?jHX+HFKf+b+AlTgnj52CfMTH0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3008aa-eee0-4d5f-9944-08dd0580ee42
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:22:26.9367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diCSHL6B/pzrsQcdYGcivLGW0MMa+p/PxZzZjT56ENvvzFRu6nMDjEgPx6LiwUcAdc/EbPPDYp+PMlCpslgJig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229

On 11/14/24 19:21, Baoquan He wrote:
> Functions memremap_is_setup_data() and early_memremap_is_setup_data()
> share completely the same process and handling, except of the
> different memremap/unmap invocations.
> 
> Add helper __memremap_is_setup_data() to extract the common part,
> parameter 'early' is used to decide what kind of memremap/unmap
> APIs are called.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/ioremap.c | 81 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 8d29163568a7..5ef6182db630 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -628,6 +628,87 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
>  	return false;
>  }
>  
> +#define SD_SIZE sizeof(struct setup_data)
> +/*
> + * Examine the physical address to determine if it is boot data by checking
> + * it against the boot params setup_data chain.
> + */
> +static bool __init __memremap_is_setup_data(resource_size_t phys_addr,

You should remove the __init for this helper since it is called by a
function that is outside of __init.

> +						bool early)
> +{
> +	struct setup_indirect *indirect;
> +	struct setup_data *data;
> +	u64 paddr, paddr_next;
> +
> +	paddr = boot_params.hdr.setup_data;
> +	while (paddr) {
> +		unsigned int len, size;
> +
> +		if (phys_addr == paddr)
> +			return true;
> +
> +		if (early)
> +			data = early_memremap_decrypted(paddr, SD_SIZE);
> +		else
> +			data = memremap(paddr, SD_SIZE,
> +					MEMREMAP_WB | MEMREMAP_DEC);
> +		if (!data) {
> +			pr_warn("failed to memremap setup_data entry\n");
> +			return false;
> +		}
> +
> +		size = SD_SIZE;

Just me, but I would use sizeof(*data) here instead of using a #define
that is later undefined below.

Thanks,
Tom

> +
> +		paddr_next = data->next;
> +		len = data->len;
> +
> +		if ((phys_addr > paddr) &&
> +		    (phys_addr < (paddr + SD_SIZE + len))) {
> +			if (early)
> +				early_memunmap(data, SD_SIZE);
> +			else
> +				memunmap(data);
> +			return true;
> +		}
> +
> +		if (data->type == SETUP_INDIRECT) {
> +			size += len;
> +			if (early) {
> +				early_memunmap(data, SD_SIZE);
> +				data = early_memremap_decrypted(paddr, size);
> +			} else {
> +				memunmap(data);
> +				data = memremap(paddr, size,
> +						MEMREMAP_WB | MEMREMAP_DEC);
> +			}
> +			if (!data) {
> +				pr_warn("failed to memremap indirect setup_data\n");
> +				return false;
> +			}
> +
> +			indirect = (struct setup_indirect *)data->data;
> +
> +			if (indirect->type != SETUP_INDIRECT) {
> +				paddr = indirect->addr;
> +				len = indirect->len;
> +			}
> +		}
> +
> +		if (early)
> +			early_memunmap(data, size);
> +		else
> +			memunmap(data);
> +
> +		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
> +			return true;
> +
> +		paddr = paddr_next;
> +	}
> +
> +	return false;
> +}
> +#undef SD_SIZE
> +
>  /*
>   * Examine the physical address to determine if it is boot data by checking
>   * it against the boot params setup_data chain.

