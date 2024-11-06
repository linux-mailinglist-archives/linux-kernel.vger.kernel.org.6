Return-Path: <linux-kernel+bounces-398875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7CA9BF774
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5221F22602
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5309C20F5BA;
	Wed,  6 Nov 2024 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IZwDW1OL"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3FF209F5F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922055; cv=fail; b=C7J+Q9oGnLnMQOHZkylyN+YxlMIGZFXrAL0nEyf/ZiV69idt8NeXVMCq8emIAD+yXFyWUGRfeMF+w3XLofjy2RFU6HvqX1NHzaqOtswh20rf8dzYuH5/bbDfSpxVv0YLHiHV4p0sxlY6rVwezrCrbept7sih8dZ6r0dP/eQqFXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922055; c=relaxed/simple;
	bh=VyTwuKaH60HpiqHt1AkiiudZ8acFDQstxk4k5jShl2c=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=IuB341qQXNqoRIa9nvx1aehuh/52IlVsj9SvfZUBcKr5Lwj/Uq8aW1H6BK79sMUh4/1mbqp6PGiGj1QZdSJfmNCZ96/HE2/AO5kzhGiSNKuSHt+Hz3E7+YlLWjqtsYmMXDl/mjaugAWXsa9vzmDqFSIJzOhENKkRgJhtRgGX2jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IZwDW1OL; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKuVFw3TdsTePa690FazlKRXqFh8Qi6DzBcIg39+E9QGzsN11lNCD6WNKo9Gk2+9olrBfigEbmPD6L8sipEQaT6rp63iWyh5VlZJs/YobBNs1kJA463TgXLKebzo4WfXft9g09lH2a8EeuU1kjsHOEe39UsRZYWMjQX9IDbK300u3M7/lZNaLL5lgOr9O24RCh/ratX735me0DdH3xmvyE53krIxDRS6z7DHzkfi1/VhMWujymGF3kzo3yzMMPnQnufzF/N1Ku4EyewiEyZbBt68F1VR5mO+T0VLLje//0oDphMBAgExJUmo4nJ/aa1mBHfJnO/Pnk310JbF1Um28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzTHavpw2OFzCvC1Xl1C1QARxg4jcd4/++liExbvUr4=;
 b=XgllhlL2qwnoaMXLGBEQ5im7F1p6az2XFebEQPaqCjCzkmKdc6xdhONK1DjvnxNL6ZXH1BmtFtI+0HQbO5JTrmOhEwZkupLhXoLTinf3NrbH6cVxGoWmjAGLdP9BbwG8x948WL08snY9DnlPK29yQyofh9dpcFAT7RQeZTWR6gr2hrhPh1coDTcohRkrD8jinvBgN518HGMZMfdEoT0UqeyonMAoZOLoU9JsxX83RNMvhioO76yRArtHPO6MHTwI+l4dWYDNyaeCcyq9bA07B3nzNOoggxdnovOHui2yXGPLTIs6TyafxRHzfeFPzNnhdVzVR770zkdYyiuPmgOvkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzTHavpw2OFzCvC1Xl1C1QARxg4jcd4/++liExbvUr4=;
 b=IZwDW1OLkTkXgQA+R4IXGYrXtdj94PmvKJ11k12YavLrjBexoJt0DsmTbSCycc7y8u3xwC7WijThUoviAk4LPxBfsNRCKG9iPG38eWB864DJvcWoOK67LeHEov3ZAyuUjcfGGZCDv9FWSY8Rs0hZKrKsNCmSYuKfGbGU1l0IkNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 19:40:49 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 19:40:48 +0000
Message-ID: <4816aded-9ac4-c55d-053c-a7c7f31d11c9@amd.com>
Date: Wed, 6 Nov 2024 13:40:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 linux-coco@lists.linux.dev
References: <20241106172647.GAZyum1zngPDwyD2IJ@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC PATCH] x86/sev: Cleanup vc_handle_msr()
In-Reply-To: <20241106172647.GAZyum1zngPDwyD2IJ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::13) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 7965d07c-b18a-45ce-9ca0-08dcfe9aea3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0cvQzRIQ0s3aVJWeDFGTG8zUEtCVmlzeTZCRndPZHpFaXEwRjgySjVVRU4y?=
 =?utf-8?B?ZUp4MWZBcGg5Um5MNkRPZ1l4RU5vY2NpOXdtVzB2UzI0dFg3c0gySnA3dXhV?=
 =?utf-8?B?OGJJLzYzQmxEa21teXo0K09VVEhlOVIvK09mbUJyY2lINHZleW5RdC9RUEc0?=
 =?utf-8?B?VXR6ZGdzeVA1NmVkbnVObm1PYUlRRW13cUlpZ0w1RVZiZTJnR2FleG1kMWZT?=
 =?utf-8?B?Y0piaUl6YUdIVTE4M1plU212M3hYL3ptZTF6SnVoaUM3WnIzeGp0eVlWbEJ5?=
 =?utf-8?B?U2VLWWNVbno0aU9GeXh4V0pJeDFHdUwwdzJWOEs3K1E4NGJDb2pEcTJxL0g0?=
 =?utf-8?B?Q2FFRnBYUkdBczROcVRzL2huZlVZVnhzOThWT1dSZ3NwN2R4Z2puYXAwNS9M?=
 =?utf-8?B?eXJJbm96cnFZS2tPVlVRdTY5UDVFc1Y5dmJkN2Jwem9MaVhmeWFXU2JjQXNv?=
 =?utf-8?B?WkRHclU5Nm9vSGR0UHQvUi9qMEZYS1Y4SHg2RFV4ODBEVWtuWjJZUkRoYmpx?=
 =?utf-8?B?bVdYWUJ0SHUzSzNuUXVJMCtCYnl0Wlo0VDVDdTZjMUdEWW4rOUNUUEgvSjdx?=
 =?utf-8?B?THEzQ1hvYTBtQWgvTTlIUWxSYkFGUzA1V1ZNRFUzRUFvQXdQbkpLQ3I3dzhF?=
 =?utf-8?B?SmJIaUZUbStLdkYwSE5iTlJVMHVnUHpCSlg4UC9VWDZZajNUaDllQ3J5UVNy?=
 =?utf-8?B?VWNjbmhDbVcxWDROem82SklxZG1lMCswZEVpSDFNSHZZaUh2QmVRSGFOVWpx?=
 =?utf-8?B?Ym1VYmdlZVpLV2pMNFZBd0VaUnNLZ3lYQ2hXMFNkMEZWdUpKT1hmMjk2VTM4?=
 =?utf-8?B?bEUzaWVsOCtJREFlaHAxQVFHUFJxOU5jZ1VJNWUvd2kzVzR4bTludTg5STQv?=
 =?utf-8?B?dkVXc0xGV0JBU0s4cG5URGp2dklRQkRLN2RaT3l2ek1IZ3ptTWwrRW5mdTFm?=
 =?utf-8?B?Vi9oY1FKYnZkazQ4OW0vSlh1QkQ0dzdWbFpBVGoyLzdpdmovcUMrVXNudkE1?=
 =?utf-8?B?ZWpWVVRHMWxTdWU5a0JOaEd6bHg3YlRQY1N3K1k1ek9lblNBM1ZKNnVaUDhU?=
 =?utf-8?B?elVOY1MrNGtKMmlncGF5ZjhFMHR4T0tHdmRZR1VyNjVLdzYzVFJFdFMvaU1U?=
 =?utf-8?B?MDE2TDlUZ1graXVxMVpZRi9kenlDNjYwYll0WWlkVmFjWEVXZHhvMDdtajdG?=
 =?utf-8?B?MEwrTmpnZXgwc0NtVkxEcFBjV3lRc3JhY3NvRVlVMDNUWTVhRkVVOStGUnZZ?=
 =?utf-8?B?cXYwUENMWFdlY05UdFBSaGZ6ek0rTFdVSFNZdnIycjNCZTZka3Evbzh4Zmkr?=
 =?utf-8?B?dDZjTnY3b0hSWlU5bUFENnJvdDAxZDdQV25Dc3dJeWZUSXRuTERyTGFjeGtM?=
 =?utf-8?B?TE5PdTFtVmUwVVRneUVGSVlvZkJ3bkxWeDFWdWZDZVpXbHVPSkM3QnJMOWNF?=
 =?utf-8?B?MEFqWi9TZUREaFNrbUR1eVFYa1JaZi9sd1dLTkdJR2UySDM4NlgvWmxLL1JF?=
 =?utf-8?B?TUxGajdydkRPT0JnY2dLK3BKUkZWbkFSZGd2OHFlQ0JQVE16aGZjdFJYTmlL?=
 =?utf-8?B?Yzh3NjhHeWZHRy9rZDBFNDdiSmU0K2tSY3N5SEV1TkxZbmg0TnIwdldzODdY?=
 =?utf-8?B?TDNTS0wyWmhvOE0rTStyVWVCNEpFekFtRzNjRFJGV1NLRjRhYmsybnoyVms4?=
 =?utf-8?B?RUFTNHNvdmlSM0dVMWE3bGZLWHcxNHVjQXRIdWE0WVZpcWt0VGFwZkRWVmxD?=
 =?utf-8?Q?lKQ8psAeRTAZwhTJNY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUE5Umg3QjlVOFhaQ2tjRExra3pRdGc0OUF3QlJnSzVlSFVVT0lTcUVoTTJC?=
 =?utf-8?B?c05JRWRHQXR4NFkvVGxZaVViTFJMaUlrLzJHanlwaEFtbzBPUVJBYUdWVldj?=
 =?utf-8?B?UUZEc1dvQmZkR0RGSHpvTUZ2OU5aSGE2SWlCRWFiTnRBYjBxbmQ5ZlZlSG1B?=
 =?utf-8?B?aWFOTy80d0RsSFhNQTk4emRPbmtxL1hkYW1kRjBycWNzTUVmbEZuYTB2MDZC?=
 =?utf-8?B?YW1IQStqckdvcTRpTmdRN3gwcXFjeElSZzNVSzlhemdPOVoxcksvK3RiZGZK?=
 =?utf-8?B?ancvQUt5Vi9SaTBSdEtZT1ZhcGErZHZ1YXlhdEFVNzRRY2tLWUlFYUpIYzVE?=
 =?utf-8?B?TFc4ZmY0OXgxMlJlL3pWUkZyWGROMU55WDJhUVhOMEpJQzVhY3gxSWw2UEpI?=
 =?utf-8?B?djZyUmpYaUdBVHBJc3MyNTBxazJidmZYMk0zZ29FVGs0REcycXZCTmxFSmt1?=
 =?utf-8?B?enlUekZVWTJxNDRGSGJqZERpSDJ3MU54c0RISHZOa1duUVJkRXZmMTJ5SVBt?=
 =?utf-8?B?STR2Ykk2eXRsaForTVZVN056R0k1OUcxanFHSzhWOHBJWFpoUUVNVXlWOXUw?=
 =?utf-8?B?SHd2QlBTZkFTNklPR2ZJQmtTcFgzdGhNM3JRY3FUZi9JdndCWTZMVGg0OXd3?=
 =?utf-8?B?c2Q5eFQrSWNwUStYZmIzbnhsYklQS25DTlZJZlNZMlJOOFgwZnlLaTF4MUFD?=
 =?utf-8?B?VU5VT3ZGbXE1S09jWlU4MnkzT0xYYnpaS2gxSDdJbzBIMFMxTVNHOVZiVUhj?=
 =?utf-8?B?dzRxaThHaWlRTXhGZlk4OHpwclRHMGVQQ1RIWllQOTVDU2RHRXBLZW95NEVz?=
 =?utf-8?B?NVdaTUNxK3lIdGV1QklnSkpxR2ZCblloK21leUhwUUdid0YzYlhFRlR0em5V?=
 =?utf-8?B?aHRQZ09uWEQ3WC8wWUZXN0NQVEQwSXZyQXdJRks1bWUzckVNbS9VL00wekRH?=
 =?utf-8?B?a1U0QkZLbnpvWkNLMjlQMUg2aDBXaU1NOXBlRWdNaUx3SU9jZ054VTk2WktQ?=
 =?utf-8?B?WnZuNldGYjlEYTNZWkVmcEZXOFlNZzdJbGVhOGgxWWhvRTVud0o0Rko2MWM5?=
 =?utf-8?B?SXp4dnJXVkVTK0tVY2xiSXpNUlFuMGRsWmJNWGJIOWE1UFY0SzZma1pmNFlj?=
 =?utf-8?B?aCtVOFJyVGdtVlVYSm50eHRqUkFPWkZvcDRCVHhJQUh5b0N1VCtIM1JCOVlW?=
 =?utf-8?B?d0VmZmgxTnI2aVZrWXFDbkY2bGpEMTUvNXZPNFYrRm12amk3eTRGR1V4WmVX?=
 =?utf-8?B?QWd0ODRvbVpWQUJOcS9TTENWandOSmNybk1ML1dQVjNOck56N2RFVVVRNmcz?=
 =?utf-8?B?N2w0SEpxT3kzL3RnOGpiOEZNUkRQMHJDSGttTjdQMXBDRnNpVW9pZlBOYlZv?=
 =?utf-8?B?dXJ5MGNNVzJQTlRkb1JhYUZRa1pqT1U5bkYrUjJ4QVEyZmNGdnRhS2NReWZF?=
 =?utf-8?B?UmxOeGt5TTFzcUgraHJqYzJiRTR1QlhJOVJlczFrOCtZckcweUx4cmRJb2Fx?=
 =?utf-8?B?S2lBOGNEN2pVUG9KaVFkcWEzNitvN2VmcjNPb2F5S2tvREY5ZVFhbkFlOHBU?=
 =?utf-8?B?UFg0eWVEK2hSUG5hWFVMOVkyeVQ1c05WNTFtWE1oemUyMU9veW53eFZrL1hV?=
 =?utf-8?B?VHVLY1pjUnNrZFlQVkkrRU1YNmZYdEVHNFh2Y2dvTTVqaW0yeFQrQy9YemVo?=
 =?utf-8?B?cTlJOEdwN1p5VmxhVWl3bWpGNnJvSm5VZTJDeFMyNlJlT1NMOGcwY2ZMOGd4?=
 =?utf-8?B?VU51bkF1ZjNsN2UrYk1BTHVsemxadFFPeXNpbXdaZ0xVcU9wNFFaNVh3cW4v?=
 =?utf-8?B?QU16UjYvZ05TUjk5Z3pMTnNOdUg4V25oZjExUUdqZ2pWSWc0RGc0ZkFtbjI2?=
 =?utf-8?B?NERxWXB4Qkg1UTdLYTZNeG12MTNiRDVSNVk2Z3Uxc29OU2g0SVpRa3ZLbnZU?=
 =?utf-8?B?YUZwTDRSYmVXVGUvQ3VWVVlCMnllS3NiMDVjanl3b3ltUnZJdE9seC9wb1Bo?=
 =?utf-8?B?dkp0U1BEYmpINXFqZlJqdk5zaUJVNGZZdnBqNVFqQURENThSWmhxOGRYSnc4?=
 =?utf-8?B?NGdmYUt3RG1XcldFSUNXYVJ0Y3VFTVJUNlU1UUhBeThoUnlkNUJteEx6VHh1?=
 =?utf-8?Q?WOL0cPUhyx6+/Tgn3H8a6jL4m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7965d07c-b18a-45ce-9ca0-08dcfe9aea3d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 19:40:48.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUHZIz3kT8hrnSAFc5Hu1HZfqw0iSAYNBtrm/6TIXj4lNTOp0urhnAodiSGYjoYkTYozoqF51V7StMVC3fn/NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934

On 11/6/24 11:26, Borislav Petkov (AMD) wrote:
> Hi,
> 
> I think we should clean this one up before in-flight patchsets make it more
> unreadable and in need for an even more cleanup.
> 
> ---
> Carve out the MSR_SVSM_CAA into a helper with the suggestion that
> upcoming future users should do the same. Rename that silly exit_info_1
> into what it actually means in this function - whether the MSR access is
> a read or a write.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/coco/sev/core.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 97f445f3366a..1efb4a5c5ab3 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1406,35 +1406,39 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
>  	return 0;
>  }
>  
> +/* Writes to the SVSM CAA MSR are ignored */
> +static enum es_result __vc_handle_msr_caa(struct pt_regs *regs, bool write)
> +{
> +	if (write)
> +		return ES_OK;
> +
> +	regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
> +	regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
> +
> +	return ES_OK;
> +}
> +
>  static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>  {
>  	struct pt_regs *regs = ctxt->regs;
>  	enum es_result ret;
> -	u64 exit_info_1;
> +	bool write;
>  
>  	/* Is it a WRMSR? */
> -	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
> -
> -	if (regs->cx == MSR_SVSM_CAA) {
> -		/* Writes to the SVSM CAA msr are ignored */
> -		if (exit_info_1)
> -			return ES_OK;
> -
> -		regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
> -		regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
> +	write = ctxt->insn.opcode.bytes[1] == 0x30;
>  
> -		return ES_OK;
> -	}
> +	if (regs->cx == MSR_SVSM_CAA)
> +		return __vc_handle_msr_caa(regs, write);
>  
>  	ghcb_set_rcx(ghcb, regs->cx);
> -	if (exit_info_1) {
> +	if (write) {
>  		ghcb_set_rax(ghcb, regs->ax);
>  		ghcb_set_rdx(ghcb, regs->dx);
>  	}
>  
> -	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, exit_info_1, 0);
> +	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, !!write, 0);

Is the !! necessary? It should have either 0 or 1 because of the boolean
operation used to set it, right?

>  
> -	if ((ret == ES_OK) && (!exit_info_1)) {
> +	if ((ret == ES_OK) && (!write)) {

I guess the parentheses around "!write" can be removed while your at it.

Other than those two little things...

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

>  		regs->ax = ghcb->save.rax;
>  		regs->dx = ghcb->save.rdx;
>  	}

