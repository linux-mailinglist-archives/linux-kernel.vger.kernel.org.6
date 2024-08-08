Return-Path: <linux-kernel+bounces-278941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F05294B6E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DABE284405
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461C187866;
	Thu,  8 Aug 2024 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rLsRpFsj"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A318785D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723099483; cv=fail; b=Bke5MOnmm2pB5QE4Vnfzcd4B/NkDcbyAuEP7Lf8gYpQIXz3T7SMSprOU+CvTvNYXEa+Xh+WcRjzFzhMmD+dh/yyt/dXqbNuyVimKxmRPjOmtB0vR3gEw+q/HT471Z274oQBICXltPQmb6gZFjx0qGYqo5cRGz608+mkHDO6qisk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723099483; c=relaxed/simple;
	bh=X1dJWs3E/ekeYorQS8xhb3+YpZ4qIiulksWnFvVJRBw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=myHY00qK1fk5D50v6V99A1ttaRF2bXvCu9pQF+r+2NB+TEr5UcGFK+aMe17WNfmHjAZfftwAyVmDTxgrPNGWzC3Hj09sKykYuDIPjOkvvOlUoPYiU02MecLCko7kYT0joyxnVt2cNtHUcrNN9cRIhDhoaGEOZtp2M5iIbqpPnt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rLsRpFsj; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gViTnednP/ltuN8pVrDfpjFDtVaXP0Hjgdc+LopV67evEhBoHDJ6rrLMOT1IWpAVyeP11KAAycO7C0P34PaUaqTp4xKVl8zvCzAdSfyK7E7c2npkN8PxfkMj2ITiabErPFZmWCGirWEF1nynq7TzvZDYPZUI/5ch7oN3V18jTgwBm45SIXS0R2oeFdEoUlg2EKlCsWp2/P1Rj4nAai3JltjPf76WYjEkTHNitzlCwiCkUN2TivivEKwTZJMkMvUUlbEEIKEd0UswDoqS05Ci/e08ZsL+abiWOOYGw6JjvzZVdSLeWNQ4Nr7aaPo9/VoxG1qPUGgKacjzLP8UGPahLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xEjMQvZk69hdBXJOiEgWuzttTI/rYBnGYAjZ8JVVT0=;
 b=wKnMgJIjMQtJaaOhwhJCK6CfsBleA4zp5P8vGBDWe0Zl06MmHBkBvCvoHmPuWi24RDl2sZos99pdopjLCP/KP9z5CgR53D+672ICW9Z7i92Q6/FDUaNTQ5ZOK7Z8cNlHGc0y2/6o0jlvXwUwPyLPa6Z/2jUI+hVVaIa2mfYOYhU1AVp042ON0iv9R94tSz87ZIvQLFhmYZMoyWNv5fVl9XCKCycFnFz+CDRIsp6CY+WHjbdLWvdplVnEEnQe//j1iY47Fw/B1VCz/moFbgn35eY16X0UKYElOymBzEGmKQsG8Vv2To6buGI/6kGBFYijAfG+iWbxDKOvmg9p0jryjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xEjMQvZk69hdBXJOiEgWuzttTI/rYBnGYAjZ8JVVT0=;
 b=rLsRpFsjdIvffsETq7aEHyrGuYRLWnbj+rJYMrbEviUDVYnQ2Z2EnJZOqB78zZujDcysG9RUFdJhSiCJl2uE5tGQoMYKFM7oqZC7s9c/0AcoMBsDYxOnHL1+jJeT9ZsB6Axr708NdV0X8y3NYVpHvzR5FLec3OIE+F5iTdErclRaUXaA/EFaA8hBPEWfFZGeV5t17gHG2LwIm+ghchTaEKRbDMAohP+P4wWi5tfcFb1BS+M9k+siOcWQH7o+0tEHU8ycqPhRIgEBNnm9/C/Uo6Sf5SxqI42ejFxl7cUhm9SoGW/p9MU+Gm3nvFRDBHM+ukBvOJhIilgh1O973mpfZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 06:44:36 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%5]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 06:44:35 +0000
Message-ID: <5cab1857-2300-44ff-8b4d-cdf238be566a@nvidia.com>
Date: Wed, 7 Aug 2024 23:44:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
To: Alistair Popple <apopple@nvidia.com>, Max Ramanouski <max8rr8@gmail.com>,
 x86@kernel.org
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 linux-kernel@vger.kernel.org, jniethe@nvidia.com, linux-mm@kvack.org,
 tglx@linutronix.de, Jason Gunthorpe <jgg@nvidia.com>
References: <20230810100011.14552-1-max8rr8@gmail.com>
 <87wmkr4jgj.fsf@nvdebian.thelocal>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <87wmkr4jgj.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::31) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|DM6PR12MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed35008-3466-4939-d7c1-08dcb7759136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG55RkswdXgxajdaOUFoZkM2Wk1acW1OKytMQzVFeXYwdmJueDdmOHBLeTIv?=
 =?utf-8?B?RjMxTjZ2d2JjS1NLdHNlMFYySWMrTU9pQWJQcTVhSFZNak5MdXNwQVpmMkRq?=
 =?utf-8?B?TCtEMWEzRGo3ckFpbFNXRERQelV1bnZ0aXluUndLN1pYcFNSUDVRRlVxd21P?=
 =?utf-8?B?clVrQ01LVC8rMU5zTmY4dmpCazdoSjc0UXlpS2doWCs1OTAzMVdFRUxxbHJs?=
 =?utf-8?B?TllTQ3VnNGd3YWZYVU5TRmJSK2lRc0Q5ZjZ4Umd4T0laeTkxZTNWODRqZ2hQ?=
 =?utf-8?B?cWthTTc3bHZHRUpOb1RwUkpKSy9aYnRMT3JNTWVXbmVFQXZWRktFYnl4VWVD?=
 =?utf-8?B?YkZnNmNnZ1UxQ015SDRjbFdoLzJUL3lPdFdFejd2WENwWGwvSnR0TGdvMmZk?=
 =?utf-8?B?bjllbmorMVFiRmRYaTJ0blJiWVpqbEFaOERXUmpJQm42QnpSSThTS3NuTzk5?=
 =?utf-8?B?WHAvcWErWUY4bFNxTGJ1UUtqM25TMjRvaE03UU56bTlFZjJpcWFzdjdZak9m?=
 =?utf-8?B?M0ZPeUhndFhkR1YyL2k4MlBXMHdZYVJ6T1hwaUxQc216aGkxaVJrK3dIbUlp?=
 =?utf-8?B?cUs3VjVyL1FIS1pmMXk5MVZNZ1ZJS3hLOUFxRWk3djdUU3lxN0ZRa3ZrTjR5?=
 =?utf-8?B?dkxPQ2pWcXljR0VmbkZWMHpvNzFZcGU0Z3VieE9PcDJLR3ZSVVFEcnhSUG1k?=
 =?utf-8?B?WFF5V3k0RzhzMHZMZUswL3psMnJsdEtqc1BTUFd6NVdGZ2ZKbmFyY3JEeWdU?=
 =?utf-8?B?b0dzQ0J2Z3dmSGRNWWlnV3FTMjIyY3k3N1BoWGZwdjNXVUNtWlBlb0I3V3Aw?=
 =?utf-8?B?VmpoaUtTS2szUUovYmM3bXRRUi9hWm0zbGlRREJEajRvZUlWd2YyNkt4czVT?=
 =?utf-8?B?M2tiV05HRitjZS90NkVpUENrR0FrYTQ1UTliK3I3dGhqY1ZaSURlV082OUdq?=
 =?utf-8?B?OWJ0d0dzcVlTSklPelRwNWdyL3hRUURVTDEyK3hmbFlaaEhvV3RwUXpnV0pM?=
 =?utf-8?B?QmRseGU0UVo2Y3p2Y2pCTXlqaEowSWhqYkJVZGMwOFN6T0svK2crbHh3L3lQ?=
 =?utf-8?B?aVVsZDlSU1BINjdxdzAwQ2VqZk1lbGIwaHl3dS9sNGdRbEQzdkttaTM5cHJx?=
 =?utf-8?B?SHE3bFF6MGJDMnFSYU9vWWhUcDluaUFxZmlzYUVyeXZtSGlGdnpubUNxUDBI?=
 =?utf-8?B?Yzd2OUNZdndkWnpETTJLUEl0Tk5YdlJMRDZkMVN2S0l4M00rY3lJUmtWbm5V?=
 =?utf-8?B?cFZRb3lnU0hNRldFdXJkcmxvMzE1SktmajVseDUxTDlOOUpkUFZyVExLVU9x?=
 =?utf-8?B?Z2NGbXFka0wxQ3VYSDIvTkszUFBlYjV2YzB3c3hZVlFiUkhNZ2tRc2tJVTlT?=
 =?utf-8?B?bmc4WjVFRzRxYXM5M1dWaGpJTXlOYU05UlN6eGREREJTYjRkQjk4QWRvb3R5?=
 =?utf-8?B?c0ZlelpBSTFwc3dKb0pBSWMrUXFyLzhWaDlTUWx2d2RFUHhrYkJ0aGhqcmF6?=
 =?utf-8?B?c2lId0VmaGE1Vm1TTWE4YytzMWNVaDNmWTVLaC9sWWoxTXQ4VWRSOE9aQnRR?=
 =?utf-8?B?TDViaTMyS1MvSmFzUjU0VWdQc0NpUXJPZVRFYUZRd21FaDJJS1luMGdhN0tp?=
 =?utf-8?B?NmJBNkN0MEkzT05RbGl6WVNQaDZ1VGIzQnJ5VzNoOEtWbGxheEVIV3dSWElm?=
 =?utf-8?B?eld5TXhTcGthUHhRV0lVTXRyS0xBa3N3eVdrcXNOcENqQjhCQ1RSc1E3NjVt?=
 =?utf-8?B?SFJrTGZpQVJPSTVOL1p2QnNpSlQ0TFFnR0VnSjExUWxtNFVpbnJCVTBZYWZ0?=
 =?utf-8?B?cDFRVmtVUnNzakZTZGRXUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHhLb28zZ3VEeTVxaXE4RTM3RGJ0OEhHRUdQTXoyWElrUkZXR2FuaU5zNER3?=
 =?utf-8?B?Zmd2NkpMTFB3WWdab2pSdnlCcXBGR29DczkvUlR4Vm00QjJNVkpiRTlwaFlN?=
 =?utf-8?B?d2pndTRrMlowbDJLYjY4K25KbEhRcytWY2dVbWlldUR1aG5LaDhIQkMvMVN6?=
 =?utf-8?B?UzI3VTJpdHlpRityZFI4TlZBSkVyVi9kWGJ6RFlWazRjM3M4ajZieVN1dkVy?=
 =?utf-8?B?NlhqYkFXZEZwdUJuc1pFNjNKeGFZV3R4eFI4OU8xT2JsSGJ2aWl6NWJpNHF4?=
 =?utf-8?B?MFUwRm5qZ0dwRHJldUFtendwR0FBN29lZXppNlR0cm01aWZPY21pSy9WMlRZ?=
 =?utf-8?B?WElOWGtqUENVWEwwbXc0U0NKaCtwK3FyWElrMnJoK1QyaS9mclpGTWUwWTJv?=
 =?utf-8?B?WXdLZjhRdktieFlCVHhTSldoQlRuQWpIYTJhNDF1SEQveU84Sk9NdEtJc0dG?=
 =?utf-8?B?YzdDYnRmYTR3VnNjK0toMFEvcHlaQlcwN3BrZEhibFhQRDJwVXV6WjRMSnNT?=
 =?utf-8?B?Z0N0TVhUSlVQSXpQZmpRT2xtdTN6TXFWbU13YTZzOWdyMklQdVpxK0dTeHFm?=
 =?utf-8?B?a0c0R2NFNnA1SktnTklSbVk4eTV3WjVialhIYzFGQjA0aGd2Snl6d1J1cVFS?=
 =?utf-8?B?ZFZqTXpVRHR1UGg5NHBoMnJtT3VRYllpWm53VzhISnBDc1A2ZGoyeEFEUE1a?=
 =?utf-8?B?cnVMekxnVVFaSG1sM21NZ0pEblJmZTF5OTRjVno5QTY3M2RhdkRQL1VLcWcx?=
 =?utf-8?B?ZU5zM3lCclgycFN5MWhlV1l5TjNxVi9XNE9yYlF1eVFxUXd4dHRXcDl2V2lB?=
 =?utf-8?B?NC80SXZlN1gzL2tGc3lMN2Z4bm9GTmo0aTNFV3B2aGl4bWFsLytPUGhqUmNO?=
 =?utf-8?B?SkN0Y010MU0xNm5hS2xrcnV0dnh3YXdqbERtTC8rWUJGQzJOeUp4Y3F0UUJX?=
 =?utf-8?B?TU1mSVJlS0JJWHYxbzlGSHhxNjhiUEhFU0xtWlc1TWRkaStWYWpBcERpSW5s?=
 =?utf-8?B?UXBFU2wrcTdzYTVaeWE1S2RUZGp4bU5yZ1pXajRWK0lMdzI0clBVa3Z6dFZ2?=
 =?utf-8?B?Q0tsSDgwNXA0QWZ1TXFSWmVOdHhQM25ETGZIMjhja2UxUFh4cVlNUm5idU13?=
 =?utf-8?B?a3B6d1dpRmpmR3AwVnUvbTh5OWlRb0NrdElNTVc2VkRIQnJ6SS9DbXB4QWVo?=
 =?utf-8?B?L2kxaUdGL2xLZEE5QUdiRGY4VFVMSVpKUXFHRkNwLzhIQVZVTmM2S3JIZFZO?=
 =?utf-8?B?QVRDYmRyWnZMM1pieGMwOFBydFdIamJpZ2kreGVIMXFPNlJOZ0pNazZiTlR2?=
 =?utf-8?B?RlRBUjBqSTl5eGdEclhSOXdmNkdFRzRSeGtzS1pzT0RSYU45N0RlUnhUR1F4?=
 =?utf-8?B?VjdQcFJzR1V5L0I5RmdzZlNFUGVZWkw1NUdLV0Znekh6OVVPRE56L2xnUjh3?=
 =?utf-8?B?bnF4Q3FWNFZZSjAwdS9ybHFOSjd5STV5ajVsbnFwNHhTNmFOME5VMkl3RDZD?=
 =?utf-8?B?S01oVWZLWWdza1kzc3dWSm0xaU9IY2twd28ycitrL0tGTWdjVVdwekNWeDZZ?=
 =?utf-8?B?aWVNSVhLYVlQekF6aGxkdFhPcXhDZ1hDRi8veDRhVTYrYUN6M0NIZHdtU2tv?=
 =?utf-8?B?STh5Ti82Nk5pYUFjcGJCZ2RSTDdKNEFjTVNueW0xM3BYb1JybHAvOEhCS3dU?=
 =?utf-8?B?d3hiOG0vYWMrUU5lY1VlK1hyWFlOV1lUY2pvQy9rcnhVbExDQ2hGU0Z1Umln?=
 =?utf-8?B?YlRJVk8yRmNPMzVaMUErRXdDdjVsUHRBZ0haTCtwZy84Q1M0K3hOZk0zSHFr?=
 =?utf-8?B?N1l5UTh2cWdJVEV5SFM1eUtZNkZxV1B3YWJoaUNiNHdwRjFxZ3ZrSlhXMCt1?=
 =?utf-8?B?MysxS1Z3ejU0bWNoWmx6Zjc5YWtZVWgwdjBiNzRZelVQZXB4ZHIzZ21mdXox?=
 =?utf-8?B?cGhHQjFJeGp2SjA2WVNsUVVDdXQ2K3gvd09FbGFtTU9LWW5pTzlNTGR6UDc1?=
 =?utf-8?B?enIvQXZxeXFrMmN2U3ROYkMzMnhZYUhvWDFvTjZVR1Z4c213OGg0c2l2Y3N4?=
 =?utf-8?B?ZlFXNTlsSjM0MEd5WG4ySTRQMUV1aGZqNStjUVhiems4MHp2Q29wUXJxUGIx?=
 =?utf-8?B?R2FndWRGUFdFMWNzK09LWGE4L1pMYktxNUN4ejUrcTRwSzBTOEtMTk5IR25r?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed35008-3466-4939-d7c1-08dcb7759136
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 06:44:35.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pz2SESNJrYqwaG6l3PJ58iy0sgfWisF+9WYIsYvz1t7e5zuEAecK4cScMb0j4VuYjDWfFq3Ha32MeOG95+Bt+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387

On 8/7/24 11:12 PM, Alistair Popple wrote:
> 
> Max Ramanouski <max8rr8@gmail.com> writes:
> 
>> On systems that use HMM (most notably amdgpu driver)
>> high_memory can jump over VMALLOC_START. That causes
>> some iounmap to exit early. This in addition to leaking,
>> causes problems with rebinding devices to vfio_pci from
>> other drivers with error of conflicting memtypes,
>> as they aren't freed in iounmap.
> 
> This can also manifest in more subtle ways because the conflict does not
> always result in an error. Sometimes for example it can cause ioremap_uc()
> to actually return WC mappings if for example the early iounmap exit
> leaves a WC mapping behind. This is because is_new_memtype_allowed()
> returns true in most cases.
>

I would add that this is really a serious bug. Alistair and the team
here were just getting ready to post a similar fix, after quite some
effort to locate the root cause.


>> Replace comparison against high_memory with is_vmalloc_addr to
>> fix the issue and make x86 iounmap implementation more similar
>> to generic one, it also uses is_vmalloc_addr to validate pointer.
> 
> This seems correct to me, but I'm not an expert in the x86 memory
> map. However it does fix the issue we observed that lead us to finding
> this fix, and it doesn't seem to introduce any other obvious problems so
> please add:
> 
> Tested-by: Alistair Popple <apopple@nvidia.com>
> 
>> Signed-off-by: Max Ramanouski <max8rr8@gmail.com>
>> ---
>>   arch/x86/mm/ioremap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index aa7d27932..0b596a1d2 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -457,7 +457,7 @@ void iounmap(volatile void __iomem *addr)
>>   {
>>   	struct vm_struct *p, *o;
>>   
>> -	if ((void __force *)addr <= high_memory)
>> +	if (!is_vmalloc_addr((void __force *)addr))
>>   		return;
>>   
>>   	/*
> 

I'm also Cc'ing Jason Gunthorpe, as this will be of interest over in RDMA.

Acked-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA


