Return-Path: <linux-kernel+bounces-446726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D04A9F287D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41991885042
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31FC2E628;
	Mon, 16 Dec 2024 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fny7u4oQ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69B125634
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 02:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734315939; cv=fail; b=bS6iemNN/v6asBLw1xCWPdd854Gkl8RqRLJG7LjOMsgtQFAXaae9/jsA46KJKy3w31iXn+z/9oKz51IN1PlncY6SV0W7Z975373YuSBnSbLoF57C2F8k0DNUFojofnHIzr6mxXPiQPV1/phC9cipuIyPx8WypePx8cnfcGyYyS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734315939; c=relaxed/simple;
	bh=bn8bYnFOo++ULgHOKIZcidUxxYPeePSbd77L5ms/bZk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kKVgaCGrZPj0i52Zm6TyebL7GIbEAWGzJJrxjjNjynD/vtQmjVgmrqKc+bvF+tFfVe1kt6lXaRm2vftIH2j/W45qe3BAtbxJxaItaTjvL1slAc4H1oTRJfTvKo6ESKw29KBTetpCDqQ5YRS7rPstXykaxqyR1znZPJSumc+x1NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fny7u4oQ; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIo+2832C2OPyZ8aWvc81uoDmMCyKvV/IEdFPo/guYt8fKXKj7WZF2uwWXAgIWOp7XXPXPRQOZemXSx7INCU22+3pCDVKWITMf89gI5bDt7csHSDGV17CSoWKhZqbeJLiUSHgyGEpGuE/VFKJWzBDK68pAHsSSsWKHFvQkyRfmLJbwHyjJTWRt1Ra0ePlMbvw0oQX+KNTXfaKPdJ1zgLKpptBMn1F8fcfk8qHSnkMHinpdfMXVtk/vM3of2xNHEjmiUH5FN6ilexj/WgniRAiB+iLvBfl81lwNdYwhKzN3h9nSTZZI22/+P9r0VjNwR5GO85jAGKUXTVd7R3ZKjWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAUG0Pjll4DB4ISApHQNz5v1dB9jJuV+K0VFwNa8dtM=;
 b=hSWfDG5cB/UwNAmNk0LEfCjcste1rfxpjrLsNeZpYJXEW+7kU0oAkFTIdyZ1XYIM+/bs25rFDZKPpgSRxeeewf8xWn+F1zSFNBWlyPE01ouCSjHHPLz8wUnDZLcfXi6marGdcdLzexDT9echvJPbwRFEVE2vBE3yrNbCgRgLd4Fb+z9xoniXiZ9Gnr5uJ/XFbhRj+l44fZMszHF3YpO8he//PQw8PTlEVXO0qD96X6OkjhS/AH+Tf3LU4cQaGnRPJIslEKfhltqyp4uFxB8n1U605F4xpzaVZ/BHBsBYOv5wmG1uISsBiwRWHLiO6qAUuNHPtsApJSheaKcmcSsY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAUG0Pjll4DB4ISApHQNz5v1dB9jJuV+K0VFwNa8dtM=;
 b=fny7u4oQqAfpFZmX8r2z13KMhEsm4FRYhUOooBS+rOlyiMWhRPnD1XYP3zC5cZ4xMahcFR3opZcdH0bLKscBPPt8tSVdq1WjiHON3Zxif2butrBEOLV80QYWBwYaa+GQPtmN2O05zmJh9i5UGJV29VFdAkgD3iGDS7yX7lmHMVAWSnMvJ57HYfbHGGzEDlgLNvhpF53HMbbFFABQCezPloi9AULkkfmaNNd3op7nD/YEq7MHXf7U0oVvj/C2fElDFUQ6jA5yCjGwHZpj66JASY76Hl58uSz2nyWJ2AuI8lXoMdRfwO3fyFMylCzj7LgK8fyW1plZ/gEUiHdUmCZ0jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 02:25:34 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 02:25:34 +0000
Message-ID: <1885f74b-5bfb-46a3-a65f-521d974d023f@nvidia.com>
Date: Mon, 16 Dec 2024 10:25:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/gic-v3: Allow unused SGIs for drivers/modules
To: Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>
Cc: Shanker Donthineni <sdonthineni@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Carol Soto <csoto@nvidia.com>
References: <20240813033925.925947-1-sdonthineni@nvidia.com>
 <86zfpgztmt.wl-maz@kernel.org> <Zrs2i9Iyrlqc-a4K@bogus>
Content-Language: en-US
From: Kai-Heng Feng <kaihengf@nvidia.com>
In-Reply-To: <Zrs2i9Iyrlqc-a4K@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::13) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: c44ee182-18a1-4cb5-cf20-08dd1d78eb6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlVCN0lIaU50WEEybERPaWFKVHNjZ01qbTI4WjA3Mnl1a2oxSVBzcURUdWpy?=
 =?utf-8?B?QlRLdWlPZ3lTeTVra2M2emltU0RxSG0ySG1KYlAxS1dkVTZTTlVQd3ViQmRy?=
 =?utf-8?B?bDI0aHd6WC9ER28vK0JHcHByRXF6WHZmRUZ3dnJycXVibkRhaXBieUFjTysw?=
 =?utf-8?B?MXJuelBEanlDUFRSZWcxNWlDUk45MEIvUk5FLzYrYVQvYStJMWFvSWhVY3B6?=
 =?utf-8?B?MmJvT3FOZTlacXVSMVNQODJSWGJCbGIvbHFmVVA1RTJuVlVDSEZpYWFhMng3?=
 =?utf-8?B?ZVI4Q0FPSVNvQlFPTWo3TGVlcC9mR040eWNBMG9DU2JSeUY5NFVjUU43S1F6?=
 =?utf-8?B?Z0dDWUxwV1ZIbnByV2JhdHhpOWJmVTdVTW0xUFY4emlTRXVPSTQyOG1pQ2pn?=
 =?utf-8?B?TXd4OURKdXh4L2F5RENVY21xeE9TN0Yza2FnaXNqS2VVd0hzOEVmRVJUV3JF?=
 =?utf-8?B?MmVyTmtsOE96eXorWno1WXhBRlFreDBpVXpUVUJRRHlFc2NYbGhTeEZIY0tl?=
 =?utf-8?B?NnU5MnJHdnYxN054YVpUcjIxKy9lTHAybStnU3l3QUR4VXJZaWZGQ0EveUJW?=
 =?utf-8?B?dEVmNXpMSEltYXY4QmlZVkZ1bGtQM29URW1lQWt5VklmRzVtZGc3WDRjU1gz?=
 =?utf-8?B?S2RHdVVNTy83OFdxejcwb09Ldk1VS3luQXoycjlIcjhTeTNVKzhrUVV5d2Fk?=
 =?utf-8?B?Y1BybVFzcUdJVmsyMjRRUFBpWHdiZy9VU3lINWdoQldFelJ1aU4wNURsZjgw?=
 =?utf-8?B?bEEvMFE4WGNrYkJ0REt3RjViUER0TnFhWWZ2UktibkQ2a3hLdXEwMTJMcHhG?=
 =?utf-8?B?V2pIRmVDN2YvNDY0SUE5VkdTaE8yOGJHQWFUNTVXRDJ3aDA4N2ZYSTVGNjN6?=
 =?utf-8?B?ZGdXU2pGY0VjTHBjN3RmeUJWS2lQZFB5SkxZa3FpNGJhLzIreVFBbDVwZWNF?=
 =?utf-8?B?SmI0bkR2S1lCRzgzL21OenBpSE1DZEE3cHRYTXRzNUgxLzl4YzNFUXMyUWVU?=
 =?utf-8?B?YTNtWHZBQWJjeHorQXBNS1F2VzA0ekRGb2ZLWFA5ZUIxQk5Bajg1a3lRUHZP?=
 =?utf-8?B?V1UwdzRCemFES1ZnVTIzdVd1TEhsdGxjUW1Fc2I1YjBrQWtGaTVRKzJHbjZv?=
 =?utf-8?B?SVlvejFnZDFWd2xNeTBJRzZobjg3NkY2WjFKdjBnUWZ5MG51KzVESk02TU8w?=
 =?utf-8?B?UlJRSjlydnlBY2VPdUNpckJFK0pFOEVRVFJSWUJ5TC9UWmJDZEN0REtxWFNj?=
 =?utf-8?B?cjN2dWc5MisrOHZrdnRWVG5CUWpNR2lpQU1WUk5aSEJDcTVoS1BqeSt2N0dn?=
 =?utf-8?B?MXZra1NXMitjb2RCRmg1SlJaYndoeXNaelZzTWRwV3p0ano4VW01a2x3L2xo?=
 =?utf-8?B?QURTR1JNRHZYUUhrVnFUMDhXMTV6OFJpV1REZFJZR0tFM28vODNvVWhoQkk4?=
 =?utf-8?B?cU5UaDlVQ082dUMyZnViWEVORSt4MWdDQVlkVVBTYURDSmhkaDRDaE5UR0p6?=
 =?utf-8?B?cE5KNXZBK3Y5bmpnTlB6ZUplVGxkdzZlNnFzNFJ3OW4xOTVSUUlxSHp1REhO?=
 =?utf-8?B?UEIzKzIzcjJqd1UxbldyeWxvb0J2YnVOOWVYTVovRlg5aGdmSEFzVFVwTnA5?=
 =?utf-8?B?Y3VyQkNaVGZxMGZiQSs1Z2UzNEdncVRBTWZkVlozMEkreFJmRU1nU0plSjFD?=
 =?utf-8?B?VVV2Rk41NGs3K0plN0lnb3hPSGxwcmIwUlVHMy9KSFpMOHU5Q3NncDNvSlpv?=
 =?utf-8?B?L090clZQaEhmZmR3UHJHdjRXOWhyQXFvUWNsellieVdlSzlEb3dSZTQ3NFpI?=
 =?utf-8?B?bEZsaCsxQzlrelNpREhKS05FN3ZiWVd0MXZ3L0tMbEUydEt2UDVxTXo2Rkxs?=
 =?utf-8?Q?On6aCWwkruJTx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTIvVktJVnpRUWdzQkpFcmgveTczY0MzMUFkemV3UEhzWkdhdHdwa3diRUlI?=
 =?utf-8?B?NXRVZDZQcndNczl2bmVHTmxrSjQ1dkNRVE9SeXFzWDFpcHNlZ3lSVnpTNWdl?=
 =?utf-8?B?K2phWHFxN3ZBaFJ5MHhJQ1gwNlRYbzY1L1Z0d0VqUVN6cFl0cHVzaXc5WXVr?=
 =?utf-8?B?SUlBTjRYOWNVdldrV0RObjNvT09pQUNSL0ZrTzdyY25kNGtIdTJEYTRwV3Ja?=
 =?utf-8?B?c3JDU0VQSzBrRFFtbUVGbUw5dmpiR3g2clNacVFtWGQyMjhCbmVpMnlPc29V?=
 =?utf-8?B?VCs3QmtoQkJGSWN6ckdpeko5Sm5rNXc1VWdJSTdzb2g1U2p5SUtSYlB0SCts?=
 =?utf-8?B?SDcyZlF2WlgrWnZKNmtSNUxuVHphZzJEdXZhN0thMGh2QldiVUxlYlEwVTk0?=
 =?utf-8?B?QlBhWXN1bU1rMTdETmcxVytaTU9raVBTWUhGdTBwU29PT2d4YzBMdWFnTUQ5?=
 =?utf-8?B?K0R3djVUN2hhek1Ec2d0T0dZUk5VcFVXalg2N0o4UnIxTlNlUUxNQWRxZGNZ?=
 =?utf-8?B?emNldUZLTEZDVzlCd1JGSmVtQThPL0dxMkxCbjNLQkpTZ093dHJ5eFlUN0RV?=
 =?utf-8?B?dThNUk1wa3l4T2E1eXlIRURsU0J5SXlwT0pDUjFDY0ZBNXg2WEVtMnd3UnpL?=
 =?utf-8?B?V002clI3QUgwbkNseGN4a3R5WWdXcURibnE1NnBUL2FCZHlHMjdoTWRZR2g2?=
 =?utf-8?B?OGRIZ2NTZVFmbWhUeDhUOEJRaVVFOTY2RjQzcHNVS0Zpc0Y0UG5WeUN3dVRm?=
 =?utf-8?B?LzZ0QUYyVGhGcFdkVGpGdTBWanVIRUNLWTFUVm5HZGdFV3R5emFRWWR3ZlNQ?=
 =?utf-8?B?UWl4TkhSaVNpcWdCL2gvZXNjS2FjSld6TXZxZERocm1nZ0JHWEZ3alJ0YXo5?=
 =?utf-8?B?ZVBzV0oxd0VCRXF4RU9NRWxFLy81VDJUU2VRdDg5bm9IcERzS0FjV3B5ZTNq?=
 =?utf-8?B?OTZoL1A1THFHaTlKaDhWN015akhUYnJSOERnTmRXT0k1UldLQmxJb0x6N1Zn?=
 =?utf-8?B?bkZ0NVQ5eGdqaCt0MzRsZEtwOXJyTm8rV1h4Z29oMGNBSXUrWklBWmFFd0pa?=
 =?utf-8?B?ZzBUZDVJZTlIYy9MZXlISjdQTkM0VUs5VGEyVTFtMy9qYUhBUW01TTA4NURW?=
 =?utf-8?B?bDRmN1NMMGpyVXgvMkV5bmRiUnUxSDBlc3Uyb3pna1ZWV1hDQi90SWlIMURi?=
 =?utf-8?B?d05oUzJWK0w1ak41RXptU3Vlcm9HVDRPOUZCR0Q3M245eHNWM2pCaEFidzEx?=
 =?utf-8?B?M2dtS3Bic00rMHo1SVVBL2piaFhwZlJzM2U2T0xSdXh3Tkg2MlkvVjQvd0FM?=
 =?utf-8?B?MU52V3hTOFE5UlNzdlp4djVrRGNSMDFiazRCa2psek42N3E1K2d0M1ZWUFl4?=
 =?utf-8?B?SFpGUk1nc3NpUTN3WE1nSU1mWUFtT3lTNkVOUmMyUlJWcFBiQjMzSDRyN0dQ?=
 =?utf-8?B?TlJjS2JCWHpIbTJ6TVZLK3FnZmNCZGUwR0hnQWdWdXZpVituSW80UnM3WVNt?=
 =?utf-8?B?WStDWWxyUmozaklzNW00ME95eUV4UG9sekVNMFpuMTJEOXRwTzdIK0JFZW1s?=
 =?utf-8?B?Q3ZTVnBVNS9xNEFFR2VHOE0wQTRuM0FVcjcyN3JhWGFMeTlVay9UVEdDcVZU?=
 =?utf-8?B?aWF1YXlMRXV4M2FUUWc5V3FtbnJaOU5PVXZBOUhiSWlYbGE4eE1vV0pTSEZ4?=
 =?utf-8?B?dSt3Q0VBS2thWThNTnZPdVZoLzNNNDNjTU4ycnE3SkVFSFVlQzlPc2xRcnFi?=
 =?utf-8?B?N0pPK01SUnJQck5nS0NSM2RhdmNMd1ptbkxGbGp4cWJrUytCcWZudldmS3FO?=
 =?utf-8?B?eGlZTjIyK1RQcVZ2OGVlazlIZTRCZ3YzT21CbnR0UmlNU09WaTNzc21YNDFT?=
 =?utf-8?B?aU5MZUFKd1d5K1ZISmwrdC9UVE5Hc1VZc2xRdEtRb3lQU3A1OUZJK0VrSGQ4?=
 =?utf-8?B?TUhEY1VJUGlOV2JScEhnSWU4a25ad1FWeWFHaEpsNitLVFlRaUJCbDZLK1dv?=
 =?utf-8?B?cmxRVVdoVmliZzRXdlllN2lOeTNiQXhjYlhMbEdRZldFYlMvQnFMYytuWFVs?=
 =?utf-8?B?U3hvUU9zc1BEUjlqaVRoUzZZY1I5RnYrWDFTMVVTZ0ovOVQvRHNWUThETTBX?=
 =?utf-8?Q?qEPceCshzM85JRoIMdN+8e9NP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44ee182-18a1-4cb5-cf20-08dd1d78eb6d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 02:25:34.2629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1w0/EjWe0VyJoLd7y65junGNtAf+L8nUD3LtztSRFSwnhM/0zt5sZmKI+gBOWnzMyj0PkSgFGsFQB6hjixlEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858

Hi Sudeep,

On 2024/8/13 6:33 PM, Sudeep Holla wrote:
> On Tue, Aug 13, 2024 at 09:58:34AM +0100, Marc Zyngier wrote:
>> On Tue, 13 Aug 2024 04:39:25 +0100,
>> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>>
>>> The commit 897e9e60c016 ("firmware: arm_ffa: Initial support for scheduler
>>> receiver interrupt") adds support for SGI interrupts in the FFA driver.
>>> However, the validation for SGIs in the GICv3 is too strict, causing the
>>> driver probe to fail.
>>
>> It probably is a good thing that I wasn't on Cc for this patch,
>> because I would have immediately NAK'd it. Sudeep, please consider
>> this a retrospective NAK!
>>
> 
> Sure, I am happy to work on any suggestions to replace it with better/cleaner
> solution.
> 
>>>
>>> This patch relaxes the SGI validation check, allowing callers to use SGIs
>>> if the requested SGI number is greater than or equal to MAX_IPI, which
>>> fixes the TFA driver probe failure.
>>>
>>> This issue is observed on NVIDIA server platform with FFA-v1.1.
>>>   [    7.918099] PTP clock support registered
>>>   [    7.922110] EDAC MC: Ver: 3.0.0
>>>   [    7.945063] ARM FF-A: Driver version 1.1
>>>   [    7.949068] ARM FF-A: Firmware version 1.1 found
>>>   [    7.977832] GICv3: [Firmware Bug]: Illegal GSI8 translation request
>>>   [    7.984237] ARM FF-A: Failed to create IRQ mapping!
>>>   [    7.989220] ARM FF-A: Notification setup failed -61, not enabled
>>>   [    8.000198] ARM FF-A: Failed to register driver sched callback -95
>>>   [    8.011322] scmi_core: SCMI protocol bus registered
>>>
>>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>>> ---
>>>   arch/arm64/include/asm/arch_gicv3.h | 17 +++++++++++++++++
>>>   arch/arm64/kernel/smp.c             | 17 -----------------
>>>   drivers/irqchip/irq-gic-v3.c        |  2 +-
>>>   3 files changed, 18 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
>>> index 9e96f024b2f19..ecf81df2915c7 100644
>>> --- a/arch/arm64/include/asm/arch_gicv3.h
>>> +++ b/arch/arm64/include/asm/arch_gicv3.h
>>> @@ -188,5 +188,22 @@ static inline bool gic_has_relaxed_pmr_sync(void)
>>>   	return cpus_have_cap(ARM64_HAS_GIC_PRIO_RELAXED_SYNC);
>>>   }
>>>   
>>> +enum ipi_msg_type {
>>> +	IPI_RESCHEDULE,
>>> +	IPI_CALL_FUNC,
>>> +	IPI_CPU_STOP,
>>> +	IPI_CPU_CRASH_STOP,
>>> +	IPI_TIMER,
>>> +	IPI_IRQ_WORK,
>>> +	NR_IPI,
>>> +	/*
>>> +	 * Any enum >= NR_IPI and < MAX_IPI is special and not tracable
>>> +	 * with trace_ipi_*
>>> +	 */
>>> +	IPI_CPU_BACKTRACE = NR_IPI,
>>> +	IPI_KGDB_ROUNDUP,
>>> +	MAX_IPI
>>> +};
>>> +
>>>   #endif /* __ASSEMBLY__ */
>>>   #endif /* __ASM_ARCH_GICV3_H */
>>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>>> index 5e18fbcee9a20..373cd815d9a43 100644
>>> --- a/arch/arm64/kernel/smp.c
>>> +++ b/arch/arm64/kernel/smp.c
>>> @@ -64,23 +64,6 @@ struct secondary_data secondary_data;
>>>   /* Number of CPUs which aren't online, but looping in kernel text. */
>>>   static int cpus_stuck_in_kernel;
>>>   
>>> -enum ipi_msg_type {
>>> -	IPI_RESCHEDULE,
>>> -	IPI_CALL_FUNC,
>>> -	IPI_CPU_STOP,
>>> -	IPI_CPU_CRASH_STOP,
>>> -	IPI_TIMER,
>>> -	IPI_IRQ_WORK,
>>> -	NR_IPI,
>>> -	/*
>>> -	 * Any enum >= NR_IPI and < MAX_IPI is special and not tracable
>>> -	 * with trace_ipi_*
>>> -	 */
>>> -	IPI_CPU_BACKTRACE = NR_IPI,
>>> -	IPI_KGDB_ROUNDUP,
>>> -	MAX_IPI
>>> -};
>>> -
>>>   static int ipi_irq_base __ro_after_init;
>>>   static int nr_ipi __ro_after_init = NR_IPI;
>>>   static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
>>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>>> index c19083bfb9432..0d2038d8cd311 100644
>>> --- a/drivers/irqchip/irq-gic-v3.c
>>> +++ b/drivers/irqchip/irq-gic-v3.c
>>> @@ -1655,7 +1655,7 @@ static int gic_irq_domain_translate(struct irq_domain *d,
>>>   		if(fwspec->param_count != 2)
>>>   			return -EINVAL;
>>>
>>> -		if (fwspec->param[0] < 16) {
>>> +		if (fwspec->param[0] < MAX_IPI) {
>>>   			pr_err(FW_BUG "Illegal GSI%d translation request\n",
>>>   			       fwspec->param[0]);
>>>   			return -EINVAL;
>>
>> No. This is the wrong approach, and leads to inconsistent behaviour if
>> we ever change this MAX_IPI value. It also breaks 32 bit builds, and
>> makes things completely inconsistent between ACPI and DT.
>>
>> I don't know how the FFA code was tested, because I cannot see how it
>> can work.
>>
>> *IF* we are going to allow random SGIs being requested by random
>> drivers, we need to be able to do it properly. Not as a side hack like
>> this.
> 
> I am open for any ideas as FF-A spec authors/architects decided to allow
> secure world to donate one of its SGI to the normal world for FF-A
> notifications.

Is there any progression on this issue? Do you think it's reasonable to revert 
commit 897e9e60c016 as a temporary measure?

Kai-Heng

> 
> --
> Regards,
> Sudeep
> 


