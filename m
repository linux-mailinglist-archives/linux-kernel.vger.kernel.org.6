Return-Path: <linux-kernel+bounces-346580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DF898C629
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55ED1B211EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123681CDA11;
	Tue,  1 Oct 2024 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="cCICAsuS"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021127.outbound.protection.outlook.com [52.101.62.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EC819FA9D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811552; cv=fail; b=oS+eiia8nI50d58JTpEAvRDpEV3Z5Uidy0UqWVBITzca2Z85Pl80k2hSlVPslOvc8yw3XWmu5ZQJ31I/fDch4YtIE4Trg1vxhTBPY9s4v32qnsbyuiYOEPf+C7xX10omBJJ3LiFNwxNdUs6uXgHWoN2Hb2LyhhgnoJ505b2X79g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811552; c=relaxed/simple;
	bh=gz29bfN6XrfUhbJq46fkzcxD/X08BLXDdBm3cAbNS6I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hEeNzGPcT4cWJ/YJUtsnrsO1v24lABKQka6NwiPVXseg1i1Dola9G8oLwluSAkLnmZmqr3mFcvld4CMPtzrLd2wWOmENIUGsTsulPArt5PBqwKb4F8kkS2KNcreVCpbEfk6BM/7kvyDEsT57TLWseKSBH03ckqXvT4YuXiQj25w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=cCICAsuS; arc=fail smtp.client-ip=52.101.62.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWU+sYhbEnZH/c1jPZmBk21iyYsS6BrPOabV7f0OIIB8+qUl59pcFeerLNCxripDwD2kCBvY9mRdX9UY8lUWbt5WSjFzvHdGciq3jNQHS5rjHd3RQwMcTph56KPfoKsulyM1ybdcm4wiCprOraEVH1P3A9KPvrC3cqQc3G7J93NEvd2I+SbsTb8VXQdeC1eG+EFvyRKW3xbEfov38vkTAsqxKkF5hriCuTXk0xyN8LlIpNVOptSw3tUQLijeUHIzzv+IroPb8CaetguOkmgwzhUkKx3eWCSlvLjouUTGyR0sDCxUNNmDg4jeFl65hgDfxDZyfxznG+O+2ZJqJZPC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtFmYi537MXw6JioWPtZkL8+p+HFXut2Ux5iihuy1Ok=;
 b=oNnkGiGYMRjsd5QGPd/v4j0/FpaiavN2+68eQ+ZCXMGJFpxTmLbodv7E72pib8inTbqm7fzwawjG984yUnzJVtkFe2p873mOXsvyWMAXCrRwiw/bu92mgIulddd8cIsV3JAtHrwF+4ko/KgIWZICj19pkPtEobebbXw3Xb59n05PoM4tVXWm6ExwSnBQRCmVkjVBgmQzEzBxW2QSCcPbhmv9vCyQjfITmyPXLOmWhWaX+G0IFSrC76Ge9h1qwpDvZI+MzZjQnWEcnF/k83EKPjFkms0Mpgx4eR3JcDlr3Hrcoh8O9Fi8Rbdqhow24zV4dG6abCkxhWleITi4dBEdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtFmYi537MXw6JioWPtZkL8+p+HFXut2Ux5iihuy1Ok=;
 b=cCICAsuSHikSyvOEFY00jF19vRQff9X1YllMmWwjqljsff9zxmL1o0ItonpeBIY8uTrVUBs7QCz4SOFE3FHehoWtEskgvcUJ861DZfRjiQ0S6RG0yLHrzzYn3XEf+EjSSw9Btd2Mq7jl8V7VQk/pkycu1LWB5GCkwduOKR4CgPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB7508.prod.exchangelabs.com (2603:10b6:510:f7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.31; Tue, 1 Oct 2024 19:39:00 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Tue, 1 Oct 2024
 19:39:00 +0000
Message-ID: <0e84f3c0-09d6-4485-ac76-ca296d1ee07e@os.amperecomputing.com>
Date: Tue, 1 Oct 2024 12:38:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation
 for AmpereOne
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
 <Zvw/Kghyt9zUkupn@Asurada-Nvidia>
 <45b97496-29a2-4111-ba38-3c8bcf9f8b4d@os.amperecomputing.com>
 <20241001191800.GA1369530@ziepe.ca>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20241001191800.GA1369530@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0041.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::25) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c53917-0ebb-497a-a073-08dce250b28a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTRjZW45dTlzYTVvTFVDWEttTFczQUJPU2V1dEJnR3BIQ3NSZitpN0I5NWx2?=
 =?utf-8?B?QjNhb0F4V0VDcHVmU3QxRHlic2ErWWFneC9CdEVTMm9MNjRCZVVMdnUwbTVR?=
 =?utf-8?B?RWE1Zjh3d0hXN1RMMWYxRHNMZTVlVys1czhpa2VHc21jUWRmTnJaZ0ZHVHlZ?=
 =?utf-8?B?amlRb2lram5heHphekJRWGw5clB2WVJrazJvV0FYT05jS2JKRER1ejQ0TlNL?=
 =?utf-8?B?MGhQSlJSWHpNdHo1R3NsS043VEFieDdKRW15NWgrYllmVmFob21KVU9LYk5z?=
 =?utf-8?B?VWsySEJGQlZtT2lsMzZMTlluVkpEL2pEUHB3cHAyUGdYTUE5a2lETCtPRmFt?=
 =?utf-8?B?OXc3eThFWHdJRG1tS2wzbjNsOTVveVZKeS9ZTlpsVDZVOHp2d3NwMGEwZ0lE?=
 =?utf-8?B?K1lzTVhCMjhQOHNaL0hsYk5QNlc0UHdzUjlBSFZUSFpmWlQwclJncTF6MzNM?=
 =?utf-8?B?V1FoTmFDTmYxRXJ2TWZvWG5ZTHJIMHRaL2ppWHh6VFI5YW1DU2hFeG8wMXF5?=
 =?utf-8?B?YStwZEIwOEdvTUFqcHZsdE1XdWlvZUVVTlZRRUN3VXhhdjMwVzhlYS9HcndJ?=
 =?utf-8?B?MFlRT3UvNEpyR1U0VmZTT3hPbjJqV0UwSXltaHJ4WlZPNGM3SFZoQklkUjFG?=
 =?utf-8?B?MStpaThON2pYbXhYcWxDN0pWeDAvTnJlMnA1QVYwNnZUcFBCTSs2L2pKZG9i?=
 =?utf-8?B?c0FPZE1VenpPOWV2VHFLSjI1eTBCUEpGMXdMTC91UU50UXZHSGhtT3g1YXpK?=
 =?utf-8?B?R1FZaWxxYVZDTjhiamg5TTNPZ2N4aFBWMDFWMllaTGdNLzhGejZGcnhrajQv?=
 =?utf-8?B?NlVKK25wMStoTDYwemV2M0FWd3l5dk40eGhGWHlWbno2eE9PUU5taDNLaXVv?=
 =?utf-8?B?cml0MWRVL3drQzh5ZjVWVnZaY3JKU0hudUMzcllDQjNnRjEwenNQOC94cmRh?=
 =?utf-8?B?bW1lZFpXR3RjSVJiTFFrbnNQTE96OElxQVZYWXgwS2txUERDKzJiT1J6WmtW?=
 =?utf-8?B?U3ZleG1OVmdxQzVvTnNJSVlNd2pQT1hzVGV0YlMyMnZZRlNKYjQ1Y2o3cTF1?=
 =?utf-8?B?U2xvMEo2Umt2b3JsTWxWSG16RkVpZHUvMGZlUzFMamZjTGtjYVRqeitKc2Q3?=
 =?utf-8?B?eE41RFZwekU3cm9MWWZkdTJrL2dzOWsyOFU4WUJabTNxbkxSc2pJeEdTTWlE?=
 =?utf-8?B?WmlxNW1IcVlGNzAraWdUdDd5WW9JbzFuclEwVWtRU1I0cWxoOCtpTTcrYWp4?=
 =?utf-8?B?ZHptVUpzczFGMTRZK0RDcW1jbkZiRlE4RTNhM1hjRks2Q2FrS01xSnFGMHMr?=
 =?utf-8?B?OGRGUFE1eG13R2RQbXVDR2lFL3FOeWxncDl5ckkrZlBYS1hHNDdXVjFJbjRr?=
 =?utf-8?B?ektldGhjVnRzZVNQRSthOHFQRGRST3c5K2FpMXhEUk9LZy9YUHFlamdFQnFn?=
 =?utf-8?B?SEpqaW1QbFZNTVAxOG04LzlIUG9ONHY1alV2WWg4Wk95VkcwaFRIM3Z3YTBn?=
 =?utf-8?B?WkNXSU1IZDRtVnVSTEJ5UkpwOWFRQWhlUG9QbXBWblpiam1NUlo4Tjl3OWxP?=
 =?utf-8?B?b0RkMHBsNUlIbDBxT0t6L1VIczRpelNnLzRaUFBaV3JMSGlkOTdnMVBnTENU?=
 =?utf-8?B?SCtqbC9Mb0YrZFFlb3p1N1l3REtjbXJ0S1pWdlFZUGpxRXZjODBEcVpLSGpB?=
 =?utf-8?B?QXFBRGRScFhLdjJnNHZ0S0ZTZm5CK3VHc25lakhnYjVLcDFHVHZKN2xzNGRF?=
 =?utf-8?B?OGlyRHB2aEpQVXE1SHF4ZzZUcVQ5a2N0aGJmUFBsTnMwYXNDNkV3dUFzdHFL?=
 =?utf-8?B?Zm5EKzl2bU9ONE9VRHFEQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmlPY2ZBTjhnVldPMHVzOXo4cWJKbVJLRkFvekduTXNCaDZBS3A4OGh1dDRl?=
 =?utf-8?B?dXNPZ2VTMmNmemFxUmhPNGl2My9lZ2QxSGtNMWpJeXNrNHFrekorSklOTlhC?=
 =?utf-8?B?MnZHTitGWENZb1JCcTJSa29LWXNuNXFIWFdQY3ppQXVwSFMyQmdyNlpsVGo1?=
 =?utf-8?B?Z1lYZ1h4cGVyVmZGcktyY0MwWEpsaHdxRXpiSWg0WFpSUDlYSzVzREFlNGdG?=
 =?utf-8?B?a24wb2p3NTkzU285NkdBdGUrNWNuWUM3cmwvR3NGb2ExYjZPR3hIdmFCd3dl?=
 =?utf-8?B?ZE1MZ2x6NDBjZXh4cldXL0E5MHRjOTdOamVWUW5ENitWbk5XUVJhSjVuTmVJ?=
 =?utf-8?B?TG9OY2tPRDI4ckdvRzR3SjhsL0JlWDMyUFNaYWpJSmtLYVAvRWRXZExJaHdy?=
 =?utf-8?B?SFRDRG9PSUpGMWFZNVplL09HM2J3T1p1anh0YmM4ZnRWdWlWa003dHVVQ284?=
 =?utf-8?B?bENqYkV6MkJ1bXBDK0RjTFpZbEFGbjVnazJGeTROd0NkbGs2alFFdmtIQXp0?=
 =?utf-8?B?NkpyWGRscDFiVXVMZDBrSlI0SkEyMW5Wb2dibXcrZTF3dFZuWWFTb3FLaU96?=
 =?utf-8?B?Qko4eWlZVkk3bXdmQ3VXYmgxSHE3UHdZR3VNaXZ1MWZGVlpsQWF0UHJnM3Qw?=
 =?utf-8?B?ZkV3NVJCc0hsSHoza0pGVXVVa1Bma2dac1NqVVU1YW9BZUpjM3p0cGlWUkhL?=
 =?utf-8?B?enprelg0dFlZMk5zWXVsbWNIYXliOVNMZWgreUthdkFEWkhRYzBMRmJJNUFj?=
 =?utf-8?B?bU5GenBNTHJNMDNVNCt6VzZBOEhzWHp0M0VsYUE0Qm93M3RNbTVoMUNKNHZn?=
 =?utf-8?B?NEQ2b3FMVUhxektHSUh5R2pyZU1YQ0RtdDV0bU1zaWVhR2x6RUZmekl1WG50?=
 =?utf-8?B?REFxYklXaG5pVUhKeHJIOFJjWTlRMWJCSmp2QldIbHpEWUZuYjYvL3owcVNt?=
 =?utf-8?B?YXZHSDd0cStNMHBJK1pyS1dIaUV2Y1liTFhubzBDL0JFV09sS3hTcW9nRUxr?=
 =?utf-8?B?SGNyTWlxRCtBOTVHc3RGeXQ0M3NJL21DbG1KZExsRy9pRnJkaTlxbW4wdjc0?=
 =?utf-8?B?UExzZ2o3cXNyRzdWWmcvRzJLU3NQemthOUZtdWZST3RDUVlRQWtibUlKMzdq?=
 =?utf-8?B?Q1RkK0VaZEZDam5PODlsWG1BZi94ZHdYRFUxQ0VwVmRtdVM0RktFNG50UnQx?=
 =?utf-8?B?amxOanJwOHZlNnpmQUhoV3gxTEhmak81RUJlaVVDUEZpTU1Uank4SG5IbnJ2?=
 =?utf-8?B?bzRUb1djTUFRVXNzSVVXcUhzWVFidFNUZVhuaHZQRWM1Um1mN1hyK2o0bDU5?=
 =?utf-8?B?eUs1L2hrT0wvWnVLWjdIR3RDeUhOK2RNQVJNV2Zhc1k0bmNNV1p6Y0ZTZWhr?=
 =?utf-8?B?K3RyM2RQSE41UmZKMnZOWEExQlB2OWNhSStrdFZsNHdWQ0p0TW1EWGtBeTJW?=
 =?utf-8?B?UlFpaXEwSTE5VGZobUFTMkhDT05lWmJsY3F2ejBJSk1jdHpMRk0zYW5zTWNq?=
 =?utf-8?B?UjRrS0ZHUVZpaWd6ZjZGV3hrUWhrWFFXVHpxS1JyZ3hXUkZESEROU1pWd0JB?=
 =?utf-8?B?ZVU0QUF3TWNUbk1RM0xGRWpmVmkyUmd3am9FWnltdERrYncwOHh1S1RIbDQw?=
 =?utf-8?B?M09RZU40bjNCdUJlYldZcEJqV1VaNURCTG5MdHYwUDBwUTFUQVZ4UFAwMzhM?=
 =?utf-8?B?UGliZERvMk1VMytyS0tPUExvZzJwNkkyTWJlRW5ERVJBUlZVaXByeER6MVBM?=
 =?utf-8?B?b2k0RlIvL0ZjdU1BdGdNOUM4ZWcwcDVoR3RhNnhkK003NVJmaU90K3Q5WlRQ?=
 =?utf-8?B?OVJlVXdzdm90MVNuK0hFZzVmbzNZa0hZVUFXYlpDZC9hZzlvYzJuLzhaZjFY?=
 =?utf-8?B?anNyNmFHQ1Y1WnRyZWxYMHNOcW5vQ1lyQzA4c1NjQ1FKeFNGMS9WT212VDNM?=
 =?utf-8?B?NnNUOURVRXRBQ0RxMXVIZUJhQ3FtYVdkQlpWWWdoT1RkSlVYQjNVNmhxekg2?=
 =?utf-8?B?TDQ0QVBXVkNlOFg3bGVYWjZDRWxmNk50TmwzandYR0thSmhSa0ZuT1JtNjlT?=
 =?utf-8?B?VnNwckJnYmlVbGlzdEtPbnZBWE4xTjVaZmgyVGdQdWZTK0dVMlRUWlRES2Y0?=
 =?utf-8?B?aWRqeUxKYWdDVGtSYkVSSStFay9DM3Q5Ris1TVUxcmlwRDlsUzFiYkxNeWJy?=
 =?utf-8?Q?vMvSUd7r2MS6isE0vregwCc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c53917-0ebb-497a-a073-08dce250b28a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 19:39:00.1546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAhoGC2nA+r7zAB8QTsNB4miRBi+ETEQXBklC6hNqELHXACshYwXjNyIxDO9NT0BMMQWmqrhbDSM7Q1Fw3c5HCjoEdnloYbr+WbvUABpCkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7508



On 10/1/24 12:18 PM, Jason Gunthorpe wrote:
> On Tue, Oct 01, 2024 at 12:09:03PM -0700, Yang Shi wrote:
>>> Also, there are other places doing "1 << smmu->sid_bits", e.g.
>>> arm_smmu_init_strtab_linear().
>> The disassembly shows it uses "sbfiz x21, x20, 6, 32" instead of lsl. 1UL
>> should be used if we want to take extra caution and don't prefer rely on
>> compiler.
> Still, we should be fixing them all if sid_bits == 32, all those
> shifts should be throwing a UBSAN error. It would be crazy to have a

OK, will cover this is v2.

> 32 bit linear table but I guess it is allowed?

I'm not smmu expert, but if sid_bits is 32, it looks like the linear 
table will consume 256GB IIUC? That is crazy.

>
> Jason


