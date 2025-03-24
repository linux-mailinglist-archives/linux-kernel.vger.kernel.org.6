Return-Path: <linux-kernel+bounces-573624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B1FA6D9E8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2331683EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0D525DCE5;
	Mon, 24 Mar 2025 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cat1DCEj"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9329544C94
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818497; cv=fail; b=DZQw6kFTo+1IoIZNoyJyK6jOliK+uWT1emJY2PcgJpn2PSrVqHBp/hYLY+2ZCjpckgkAlxA3pM9O6iuNpR9m8QzNST+y8zUPalzMkLPibUgOA+fDXqIuXF2viFkkVzsKSRuvzjuAdsvaNYLudUOSQWF2uxa5OHCvpEwz1Zxfupk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818497; c=relaxed/simple;
	bh=E4q8R9F1C8jDqW0gUHAnhZOyZXp+7r+hb7PhZbX+W4s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=reSipg+KUY1R/t6JGVOb0jS49XmEVAili6DMR13WxgNxilzqy+cM4Wd0BRip5NgA31TcQcMjQGbXmec4qbj1JDFBljPBy5JunZDRH2QAlDPncrmqTFs2uWJNEUnzLecdR0Sb3aT11yPuNs1CGrmWtVwn80LiaPtT0iqhNQ3QYtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cat1DCEj; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMCmi7o8wlH2h/USOn+gydiunOKGZU8kkVXsBRCt714873zP+84NN8HMd6MVD7HJ07ZPKKNnid9W8qkI593/1xgvEuMCn7k8QWtvG/Sb2f4GRMegohFehR16C9C8d/RoGQUgnENrR9z1Omt7kPTK7OG5QsaG0oB+bSBS+osyr3gVBfakhxpbouSa/MiF1A93WQCR1EMw2gIRiCweqLsK+1a9P8i4uZoaHhHnz2zAmIivNpKmxtUdwcLHmOeHbpxu9ExSTVGer/JB9XAzEFMj2Pz5xRyPaOJdf4YUw2B8w3D8V3F+ax3EWpCiMwu7cG3D2uASbMg+53VqYyYsxxvIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LjNfYcvD4xMbS+VaEfZ1iaWhVWyRYj2h31ivs/vftM=;
 b=YRPf66mTcLp2mKDQVrRkoT2zdCD/Hw+9SRFfpP1h6SyomCXW3mFbgt05hfODmtIcKr3MdYf/UhhDWCiNp1GwVeOpEaucL1NkuOPQd90Z259wnGTJwDp68xktS2HYlBvSiwQ45gNUyt8YL2vgQ4TVhzuwnZG4OPFrtUxYIqJzo5ZLL0Foh4QKxFdfg1LfSW7OlsNDX0sPUBLwrxPGtOu4p8U1+r5Lf8UbBSOo3E4gxeSCclX4b+2KCOMvJvbkd+AsZXhk+KhYusub1A758uYVzbJ6+qUNnpGab+IvGPwS1wgYiDo+ydxJ3q0iPz8f/+ca2RnsvkgFb9Ut23tysUmrAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LjNfYcvD4xMbS+VaEfZ1iaWhVWyRYj2h31ivs/vftM=;
 b=cat1DCEjIuAxrNyfr1fd7mb+YjkFQcgGLlNn7ISSKxBg05dUL+0lF62Ndy2y8hHPkP3tYPldHUi4lxrPJLwSJflmVunVziwVwQeBC73JFrRiDtqn1v9/7e9sULH8okm1ovGU3j65dewKGOnvYjrp98rdTHKomGrXQImLER51cMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 12:14:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Mon, 24 Mar 2025
 12:14:51 +0000
Message-ID: <7cdbe06c-1586-4112-8d27-defa89c368e9@amd.com>
Date: Mon, 24 Mar 2025 13:14:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>, Balbir Singh <balbirs@nvidia.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20250322122351.3268-1-spasswolf@web.de>
 <688f2757-e364-45db-ad54-daa6ff1c4f3c@nvidia.com>
 <6e8ad3cd27b570aaefd85395810cc90bb3120734.camel@web.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6e8ad3cd27b570aaefd85395810cc90bb3120734.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: a962c1bb-d9b3-4f8a-2c92-08dd6acd7a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elRVNVpsRDd0K0U4SkoxSVp5OStSRGc0TlpiRVJDYzlrQ21odXZsb1pnSE4v?=
 =?utf-8?B?Y3BQNnNGTThkWUNFRnZvU3VHcjlJYmU1Wkl1dFBDb20wYnFSTDhjUGo2RDY1?=
 =?utf-8?B?dFg4bUpvcWtjcGczcGFEZFhkbDRIRmUwbjY2SCtOczQ1YVVRUjY5dnBLelFT?=
 =?utf-8?B?VXNwZWJ6U2lXeVJFcStBcHdkZXBza1NTMFo2a0R4bDdrS25wVzBuM0tyOU1K?=
 =?utf-8?B?NVFCMHBpRmJPV3pGYXY4RnY3Ym9TcHJPcndYdXZNR1Bwbi9KUFRJeDVPN2t2?=
 =?utf-8?B?bVFPZWxoWHREV2FpRE5pS242UE0zeHFJeHZsazhLS0JCUFBQREhGU2Z5SFR3?=
 =?utf-8?B?V3A0TmgvZnVRRTdDSUlxeThaSXJWVlcyZTNZTTVrK0ZDRk83RlZDUWtQeVFW?=
 =?utf-8?B?eXVxVjNCZGlrbUp3bVExeWZPd01xOCs3ZCtYcnQxQTFLcjhSb0p1Y0tSTjky?=
 =?utf-8?B?Z0VybDRXMEZsdDNPTnZ6dk91dEFxdENwUDRnUkQ1U3pFejUwN0pOV0lDRlZ2?=
 =?utf-8?B?VGQ5dzMwaTRNbHFmdXBhd1lrUDRsTFpzL1pVVlB6Y0FGSzVnd0xnOFUzQ0FM?=
 =?utf-8?B?ZVdYaTFCcXNIUXBSeGtqOGk5Ymg1RlZDTFhIVTZUVWtLVDNVcDNmTklPVm5N?=
 =?utf-8?B?aDJ4OGxnYUpBbTB2cXQvMVdxNEIrdE5zOEJoMk4vVUZXL3hHT1BCUFZnb3NJ?=
 =?utf-8?B?WkVGdzZ5VzhmT3ZlRDJ4ZUJzaFcrUGpYYmpnYkp2MmwxT1huUlY3TVVZbC8y?=
 =?utf-8?B?b3g1dXEyOTMrL0hSOWZPcjRDM3Y3WnIxUm9JWklMVnJqcEFtajlvUTRvT0Zy?=
 =?utf-8?B?SWh6WDl0ZjNGL2sra2lnbzBWNzBKeHVMSjNqS3pMZ1BOMlFpcXBseVdha1Jo?=
 =?utf-8?B?TjJGeGRRSis2TEtwc0dzWkFCblZPZ21ja0VwYWduU3B2M2ZzWjFUS3lnYmg4?=
 =?utf-8?B?dWhsU0xNMWdzWDEramNCcy9aTURRNEVYZ0JEemtFSm1iMmVibmp1SHZYMHVK?=
 =?utf-8?B?aWF6azdicE8zRFV5TXBOWG1NUk1raU9oVzlMOWgvOWk1OTd6TzVGNlhMTnJG?=
 =?utf-8?B?Zjg5Tml6RThoVFUwMmErZ01WcGU5SkhIZUtxcmlVZUlWZE9naVNFKzAzcHVK?=
 =?utf-8?B?SFZnZmMwUm8zbmlwSEkwaWM4bVlteUgwbUJXaFZ5OU44eTFndWliWnRhRzJV?=
 =?utf-8?B?TGh1Ky9JbFo5UW5aOWtjVy85WUllanZXbGFoSW9IaDJIZENRb1VNTmI3STdy?=
 =?utf-8?B?dm94UXkxcUpMSS9KcGl6WlM1Z1RibXZ1bU9ocFZYVHhqUWZnK1Q3RlBuZUZq?=
 =?utf-8?B?Vng0SEhZNHViT2JyWkpmVGpxK1A4QlhKOXZDeVNEcUVCczFzd3NVRFlxbDd1?=
 =?utf-8?B?WCtXWG5iQllFUEVlMm1sQmR4WjNMdmpMNkdIdDBvc0xsVTVaL3hYZEliOGdP?=
 =?utf-8?B?SUFlb0JNb0JpRUlURWhWaWpUYlJSUnVwcVE0SjI5QmI0eFNCM1c0bGExNlE2?=
 =?utf-8?B?bTBVM0FFWDNXalhnVlJ0NytVZ3JyaktySkoyQnNjSWlFOU5ENkJxb25YT1pO?=
 =?utf-8?B?STZyMDdGeEFZa1RPRzdaVWlBVlRiZm5LOWRvbk9MZW0vblIzZ1ZRWVVWYVFL?=
 =?utf-8?B?ZDBDNVlhOW9rdzdFRU0rNWoyQWFhM3FLbXRnbEJjekJ3a3dJM0hFUDl6bXBu?=
 =?utf-8?B?ZFdEdlY1UVppZHRGSVAyK2NhTjA5c3JseG1iSFloRkRxSlpwQzJodDR6SVU3?=
 =?utf-8?B?V1hueHNVdVl1cGYvUGJHdG5BbjkwZjJwK0crd29LSFM1bW5FdmVSMXdudTlE?=
 =?utf-8?B?czdxRkZXS1dmU2RDZEtwbERHUU5makl6Qnc4bTFaTWJacHhjZVZ1ekFjMjRs?=
 =?utf-8?Q?i74/COnu0BZL2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGREdUNwSTZzV0V6UmJrRTl1MXpEaE1JeFhQT3NzejRYNnVFckhNS0VSTGxl?=
 =?utf-8?B?c2dnakNsdSt2U0M3NytuNG5MWTNCdXRVcWxYSmVTU0kwcDdGZFkveXJrZDJa?=
 =?utf-8?B?aU9NekduNGh5TG1Wd0Yvd0hVMktyT3hWcjFYMnBvMm5SMUt6K2FCcDRqcmVy?=
 =?utf-8?B?cU9YUTdUbFAxL2daNUhBbTd6UEJZN1FQRDNWc1FBTWQ4dVBRMllPVUg5QkhH?=
 =?utf-8?B?aHJCQ2F1c3h6TzVSTDRjUEsveXJnNXhORjVnWHE1UUlSM253WXFOTWc5QVUr?=
 =?utf-8?B?RnRxbm9Uc20xUXEwbGNJUEYxUzB2S1pkV282aU0wZW9JYnBlZ2hJNWo2N2dX?=
 =?utf-8?B?SWFyd2R6MzFGZkorZmMrNXdjaFAwbDU1aFErUXZKVjNwZzhOMFlrMHR0OWQ3?=
 =?utf-8?B?SnFjY3cvUlFlQmNZVkFXTzZsTXRDNUNmL1JtS2VvZFhiSDFSREhDWEdmb0RF?=
 =?utf-8?B?MEJMQk02TWZOOGRXVXlDbkVVRXhob0JYU2FoR2RsanZ5eUpGa0w1NGpaRjEx?=
 =?utf-8?B?VGlwWkpEbkdCUzBRWUM4UjZJY0VURkcweTlvOGhBNkUrZGxZUUJuVXlFaTJ2?=
 =?utf-8?B?YU95NDdLOHJoZ3l3TG82MEJkNlVEdis0d3VLREZja09rR0lmNzJ5dlhyVkJU?=
 =?utf-8?B?WFRHRU1Lc2RKbXBiY0I4M1k4R2hXazIrU1FYTHBDMG1vS21EaDdWWjV5dkc2?=
 =?utf-8?B?dmx4b09Lakc5OWF1WUMzNUNqS2Z2VGV2am1GTjZBcDkxek9rRjdrZlF1Yjcr?=
 =?utf-8?B?QjFsaHAxUitZQktKWGtxZzFxWDhrd0FpbzE1dTcra1grMi96YTh6ejJJSGVJ?=
 =?utf-8?B?a0ZCKzBOSlBJMTAzMUFRM3Y3YTlCMytnZ0VGelpOT0h3WHZPN1BVd0oxTVQ4?=
 =?utf-8?B?ZzJGRitCS0J0L2ZqME90SkZBL2VSL0F1NEN5djBsK0haaDNaTVI0TTM3Kytp?=
 =?utf-8?B?SFFzNUVQZDFOTHVQUGJwa25aejg5K09zak9Wbkp4Q0xVVmxZajhya1NnNVNI?=
 =?utf-8?B?S3RZOVpNNTV3UXJVNEJFVmZlK2pQOG9lTnNEZi9JSkZwMkxTdldCc0NJWVF5?=
 =?utf-8?B?MEMyckI1TUxRSkU3NlNSZit0cWVpZTg4T3Y2dWhCQUtpcGV0Q3FrVTRPVlha?=
 =?utf-8?B?WHFrQ0JzL2FMTmt3T01nd3l6cEkwZFBrdmRXL0VJQ3dxQ3NhaU5HVnZZTFRR?=
 =?utf-8?B?V3VRdVBUcndScmlFYkxvTWdKeVQ3SU1wZ1NBREZGdjJkVmp5NjdYSHB4REFP?=
 =?utf-8?B?bzhIUE1rSmRDY1V5NU40U2ZGMXhveCtSdzRTR2h3TWs1QjI2Q2ZIc0pYbFRs?=
 =?utf-8?B?ZS9QeHErbXZQVzV2Q213SlFjMy84V0ZjSGlFRUpPcitHbU5ZNVZ3YzgyOUZu?=
 =?utf-8?B?RUlEZnI2RDRXT3U5THVVcjM3aEViNnlaYkYyRzJPcGVRMzJPRE9wcGJHZGVZ?=
 =?utf-8?B?eW4zRG93U0lHOTR4ZGxPYnZwSnl4RllISnRtUzh6ZEZtNVlBOU9obHd6Qkxj?=
 =?utf-8?B?azBDNThpeUFXek5tTHZHZS84dnhkQWJYU0xNeVNrZ2VlQ05MUjFaemVzcWFB?=
 =?utf-8?B?bE5rdjZBUFJNRW45UkUra1hmMnZIYVUxRkQzbmpvbkk0YmYvZWxDS0crZEdz?=
 =?utf-8?B?eGFRUDBUdXp2eHg3NWVjaiswMDdSRGJueS84V1B6QkZGSXhvQXp3VWp5dlRi?=
 =?utf-8?B?U1d4Q0l6UWYwZlVZVERIZGtJNUl3aUVBaWx1ZUR0TFFsd3JjTmJlWVpCcEpo?=
 =?utf-8?B?aUU0U2ZjcUlmSkJXQzVFZDVpditvSkFnMnBRL295VU9SNXZFQ3g5c21QRzFF?=
 =?utf-8?B?NjRxT2lWTlhJdHJQK1dnSDlJVkFBYXRVWlJFSGxDTFRYZ0sxMUhJcUdsT1Qy?=
 =?utf-8?B?blRLOTFaWjNZeHNUaVNjT0pHYkxaVG9UaG01bUhmWFJyMW5rWTBhU08wM01p?=
 =?utf-8?B?NHZPQVhzbEVnVEJ1emZ0d1hFZGYzeUsxbkVYOFg5a2JHckhtbXRYRnh5azBn?=
 =?utf-8?B?SFJxYk5MSFY5R2ZoWk5Zc01vaU9tU3pOa0g2MUptOGFPMFFyYlh6S0ZZRE45?=
 =?utf-8?B?a1MxTW5GZVJQYTVTTGNzaXpXei9EbG1tek5lTlpKaXdJQmpreHJqRXdEZDd1?=
 =?utf-8?Q?jFnM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a962c1bb-d9b3-4f8a-2c92-08dd6acd7a98
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 12:14:51.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7P2hZmCLHW21bX7CSNn/Vdxg0DiE+bpQbIGoEWXEmpPj599qZygBpGkZlDGPWvj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162

Am 24.03.25 um 12:23 schrieb Bert Karwatzki:
> Am Sonntag, dem 23.03.2025 um 17:51 +1100 schrieb Balbir Singh:
>> On 3/22/25 23:23, Bert Karwatzki wrote:
>>> ...
>>> So why is use_dma32 enabled with nokaslr? Some more printk()s give this result:
>>>
>>> The GPUs:
>>> built-in:
>>> 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
>>> discrete:
>>> 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23 [Radeon RX 6600/6600 XT/6600M] (rev c3)
>>>
>>> With nokaslr:
>>> [    1.266517] [    T328] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0xfffffffff
>>> [    1.266519] [    T328] dma_addressing_limited: ops = 0000000000000000 use_dma_iommu(dev) = 0
>>> [    1.266520] [    T328] dma_direct_all_ram_mapped: returning true
>>> [    1.266521] [    T328] dma_addressing_limited: returning ret = 0
>>> [    1.266521] [    T328] amdgpu 0000:03:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 0
>>> [    1.266525] [    T328] entering ttm_device_init, use_dma32 = 0
>>> [    1.267115] [    T328] entering ttm_pool_init, use_dma32 = 0
>>>
>>> [    3.965669] [    T328] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0x3fffffffffff
>>> [    3.965671] [    T328] dma_addressing_limited: returning true
>>> [    3.965672] [    T328] amdgpu 0000:08:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 1
>>> [    3.965674] [    T328] entering ttm_device_init, use_dma32 = 1
>>> [    3.965747] [    T328] entering ttm_pool_init, use_dma32 = 1
>>>
>>> Without nokaslr:
>>> [    1.300907] [    T351] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0xfffffffff
>>> [    1.300909] [    T351] dma_addressing_limited: ops = 0000000000000000 use_dma_iommu(dev) = 0
>>> [    1.300910] [    T351] dma_direct_all_ram_mapped: returning true
>>> [    1.300910] [    T351] dma_addressing_limited: returning ret = 0
>>> [    1.300911] [    T351] amdgpu 0000:03:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 0
>>> [    1.300915] [    T351] entering ttm_device_init, use_dma32 = 0
>>> [    1.301210] [    T351] entering ttm_pool_init, use_dma32 = 0
>>>
>>> [    4.000602] [    T351] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0xfffffffffff
>>> [    4.000603] [    T351] dma_addressing_limited: ops = 0000000000000000 use_dma_iommu(dev) = 0
>>> [    4.000604] [    T351] dma_direct_all_ram_mapped: returning true
>>> [    4.000605] [    T351] dma_addressing_limited: returning ret = 0
>>> [    4.000606] [    T351] amdgpu 0000:08:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 0
>>> [    4.000610] [    T351] entering ttm_device_init, use_dma32 = 0
>>> [    4.000687] [    T351] entering ttm_pool_init, use_dma32 = 0
>>>
>>> So with nokaslr the reuqired mask for the built-in GPU changes from 0xfffffffffff
>>> to 0x3fffffffffff which causes dma_addressing_limited to return true which causes
>>> the ttm_device init to be called with use_dma32 = true.
>> Thanks, this is really the root cause, from what I understand.

Yeah, completely agree.

>>
>>>  It also show that for the discreate GPU nothing changes so the bug does not occur
>>> there.
>>>
>>> I also was able to work around the bug by calling ttm_device_init() with use_dma32=false
>>> from amdgpu_ttm_init()  (drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c) but I'm not sure if this
>>> has unwanted side effects.
>>>
>>> int amdgpu_ttm_init(struct amdgpu_device *adev)
>>> {
>>> 	uint64_t gtt_size;
>>> 	int r;
>>>
>>> 	mutex_init(&adev->mman.gtt_window_lock);
>>>
>>> 	dma_set_max_seg_size(adev->dev, UINT_MAX);
>>> 	/* No others user of address space so set it to 0 */
>>> 	dev_info(adev->dev, "%s: calling ttm_device_init() with use_dma32 = 0 ignoring %d\n", __func__, dma_addressing_limited(adev->dev));
>>> 	r = ttm_device_init(&adev->mman.bdev, &amdgpu_bo_driver, adev->dev,
>>> 			       adev_to_drm(adev)->anon_inode->i_mapping,
>>> 			       adev_to_drm(adev)->vma_offset_manager,
>>> 			       adev->need_swiotlb,
>>> 			       false /* use_dma32 */);
>>> 	if (r) {
>>> 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
>>> 		return r;
>>> 	}
>>>
>> I think this brings us really close, instead of forcing use_dma32 to false, I wonder if we need something like
>>
>> uin64_t dma_bits = fls64(dma_get_mask(adev->dev));
>>
>> to ttm_device_init, pass the last argument (use_dma32) as dma_bits < 32?

The handling is completely correct as far as i can see.

>>
>>
>> Thanks,
>> Balbir Singh
>>
> Do these address bits have to shift when using nokaslr or PCI_P2PDMA, I think
> this shift cause the increase of the required_dma_mask to 0x3fffffffffff?
>
> @@ -104,4 +104,4 @@
>        fe30300000-fe303fffff : 0000:04:00.0
>      fe30400000-fe30403fff : 0000:04:00.0
>      fe30404000-fe30404fff : 0000:04:00.0
> -afe00000000-affffffffff : 0000:03:00.0
> +3ffe00000000-3fffffffffff : 0000:03:00.0
>
> And what memory is this? It's 8G in size so it could be the RAM of the discrete
> GPU (which is at PCI 0000:03:00.0), but that is already here (part of
> /proc/iomem):
>
> 1010000000-ffffffffff : PCI Bus 0000:00
>   fc00000000-fe0fffffff : PCI Bus 0000:01
>     fc00000000-fe0fffffff : PCI Bus 0000:02
>       fc00000000-fe0fffffff : PCI Bus 0000:03
>         fc00000000-fdffffffff : 0000:03:00.0  GPU RAM
>         fe00000000-fe0fffffff : 0000:03:00.0
>
> lspci -v reports 8G of memory at 0xfc00000000 so I assmumed that is the GPU RAM.
> 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23
> [Radeon RX 6600/6600 XT/6600M] (rev c3)
> 	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
> 	Flags: bus master, fast devsel, latency 0, IRQ 107, IOMMU group 14
> 	Memory at fc00000000 (64-bit, prefetchable) [size=8G]
> 	Memory at fe00000000 (64-bit, prefetchable) [size=256M]
> 	Memory at fca00000 (32-bit, non-prefetchable) [size=1M]
> 	Expansion ROM at fcb00000 [disabled] [size=128K]

Well when you set nokaslr then that moves the BAR address of the dGPU above the limit the integrated GPU can access on the bus (usually 40 bits).

Because of this the integrated GPU starts to fallback to system memory below the 4GB limit to make sure that the stuff is always accessible by everyone.

Since the memory below 4GB is very very limited we are now starting to constantly swap things in and out of that area. Basically completely killing the performance of your Steam game.

As far as I can see till that point the handling is completely intentional and working as expected.

The only thing which eludes me is why setting nokaslr changes the BAR of the dGPU? Can I get the full dmesg with and with nokasl?

Thanks in advantage,
Christian.

>
> Bert Karwatzki
>


