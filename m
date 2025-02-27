Return-Path: <linux-kernel+bounces-537520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9018A48CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912DE3B5B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0DE229B01;
	Thu, 27 Feb 2025 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Me2xPsfK"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78559276D3D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699832; cv=fail; b=ZKfvUjWbqfvEcpoXEjGdBV3ZplayGm8u9KN+5usYwNSJpT0ilrGw5i8oFMaNTzG7fTo1rWNav0K9/rIasXwnVLbCtk0amhIf1ECKOtDSoUFavC1YPaNVzj9K/kw2vqkoR3zEVXqbyEKeZarbPsWusm5ZVLWc2hdJ8GzbCNkAyNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699832; c=relaxed/simple;
	bh=8xXp3Z8yQyHuu6c11EfpH6pgcV0tUCGxzu+On627XL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sVkyhv51std6ICjJcywvvIgrdgAs5SAW9aObzefAurNP+O9VXW+mAKo9bNQKDSFWuLcMGJxvVEbNTWcyvjdmy+8WCoGrE5E59MtjsI1BfAPfazpO2l6unIUvn6Mw+AGIYR3dwLTP7uXgQgXXJIRH7wVtV5fUN1mGVaDkC6ZaKx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Me2xPsfK; arc=fail smtp.client-ip=40.107.95.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=No/A2kCjeMj8yURu05vBi5gb96mWFOon6Kwj6tnIPxJT9DegSAyBA1MQdDkUSjwUt0JKp2em1QcKnOTJ0VsGEkJs/Gntu5cHX+OGAPUrI2iveTBa8mYCd+awGsbyrL7Uni8BgBMlIYWE+gGxmnSFV80t3Z0fF8TOxBTX51+/8ZexTcY6zB99IwC+CyI30O1gY9JAIkf+jaa1SrOiyO1Ot6sJRV2Y/8bs66smHIn864bnGOE9S7MGsub4W/AUGv6nNNJzjZwpxcVPR5K7Xn113FjnEE9SqHVjLRXGfqs9JqwJux8rQ8hi5XFDbmll7poMtXEqqatskcStg5WvCLTd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6Nov21MCEp6eRi0C4HnbkZSFRaq3IMhTvZJzzQGsos=;
 b=Ex1pS7sPug7WGJcnz+4XzHOitvgceJ5KxBRQfC++jS4X+jcf258iNL23n+PFl+EbR/HDwx+4+W113fxZRPyt0lEwajUiZ2zJ1k9rjwEpE8CorbnvH+8LS7TJQ5gKdlasJNmM7CGnIxqC94EQKEZVs7pOinUFzQwEmF6GftkzonVGGb16XXpswy6127Ev2gmVvN2ug1SrERwbe8G6rTTa3J0qtdoLPf6gs1t+K2VtF2A0BPbQHjKB0dIeBM9UzLwkvNjS10p21C9xDXYJ0Ua9PlLwud5HO+obTvEIlbFaXkN4rdVNfUlVcaF1B1gTSxysZHrr7cbSQ2xfwMRhrDoTgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6Nov21MCEp6eRi0C4HnbkZSFRaq3IMhTvZJzzQGsos=;
 b=Me2xPsfKG6oya3BSA14wLCsHDXv/RKZOw0gDUjk01XfhQskuCHocradqYNfVLIO+UCKE4v5LIal3z5DfMn8jXj2mHYq7mtm1DnrLUBDa0W08ArwbopjVpt9XVK4VRwYUJmg63+b3+hroGdNsPMXQt7/djX97OXGCQkR+90cJTvQfsOgr3Ho7/jZdgjOMOczcKUahgFjazWVx02uMTQeFKYJxKEEMpb8Mrzq3VKm2qOEDGk0m+G/AIXikvZIjkYlDte7dOcC7sEz94S0qHZSZGmK7HWdpJ41buKedCreFde49cexC1H8bB5YjlgVvpioaIuB5GZj2SreR4/d4pyLuXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH1PPF189669351.namprd12.prod.outlook.com (2603:10b6:61f:fc00::608) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 23:43:47 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 23:43:47 +0000
From: Zi Yan <ziy@nvidia.com>
To: Liu Shixin <liushixin2@huawei.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Barry Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Lance Yang <ioworker0@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Softlockup when test shmem swapout-swapin and compaction
Date: Thu, 27 Feb 2025 18:43:42 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <696E1819-D7E3-42BD-B3F0-8B3AC67A8ADB@nvidia.com>
In-Reply-To: <acbfc1da-f743-b11b-191c-ce6e476f1709@huawei.com>
References: <28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com>
 <c4a07dd6-fffa-41f4-b6ff-3e333d1b5fc2@linux.alibaba.com>
 <acbfc1da-f743-b11b-191c-ce6e476f1709@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:208:134::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH1PPF189669351:EE_
X-MS-Office365-Filtering-Correlation-Id: 58dc8605-ed9e-47c6-6ef4-08dd578894a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVRNbkFBd1NGQSs0NmhUdTg0cDZ0RFBvczhudTRnMllRS0ZEUmpoS3dxTWVx?=
 =?utf-8?B?RzR2UUd4UWRaRDgrZUNSMEtrNG82Q3hqbVptNkhQYi9HK0tlYVRpQ0VsdDFO?=
 =?utf-8?B?dXg0bzVWdjNIRVUxcmJvNUxwUVNwZGJjaGFnTGZZa3FaeDhWNkJUQ2RQYVlQ?=
 =?utf-8?B?cFMzVU0wNm9tZjVkOVNuRkZkVVcwOGJMaDk2Z2pHWjFnSkNkRUkrRTZYRzNv?=
 =?utf-8?B?TlkvOElqOE1sdkkrNFAzcTAyb0R2eGhEYk1iYThibm5lRVlObE9yS3Vla0dU?=
 =?utf-8?B?aThnekRxbnpxT1h2akhEWU5JVjdZMUxnMUxPZEZWUmpvRGhVcnVEcjcxckdi?=
 =?utf-8?B?U0JuTCtPYkZyS3p6aG5sL3lsY2xBMUVuaW1GZS9KSUZLcjBzNFpKdmlCb0lI?=
 =?utf-8?B?TlFlZzV3eFBYcm1YbEljbUxYRmxYcHNOaFQ2aVhSL0luN25UV21YUUQwa0tk?=
 =?utf-8?B?cXM4N2NnN3Q4QkhwdXBNSUliVThRUGxjTW9SUHFWbEZnRENMRWhMQ1dGbGth?=
 =?utf-8?B?MlRkYk5YTXNOVjlFK0wrenNtdWt2UDMydnBCcUhVVWRRTXpFZ1lwSHcwcXVX?=
 =?utf-8?B?elcwZ0p4THBueGhqcW9pbEwrTGNJWEtNSjVvNGJUMndsSkM4STEybVRhTXdH?=
 =?utf-8?B?VGRUMSt1a2k5R1N2MWs5K05NRHJvWGtyaExZTHVhUjNtRVV6TVZzaHdrUnYx?=
 =?utf-8?B?TEVHRGNmWFBvSlYyT3lYKzFIdVlVVzdOaE54TlMwK3UxSW1tMWtCOFRqNHNO?=
 =?utf-8?B?SVQrNlp0RGxSdFJabm8wY3liMzMyMW5odlFqOUhvSHg4aHg1bFN5RG1DWlZV?=
 =?utf-8?B?MTJ1MUt1Z1ZlNXZmajVuMXNidmVEZlhuVmsyZWJpMmJ1aGo3NXFBWXY5dk45?=
 =?utf-8?B?aVR5TjBMNklFTVhmdnRCZUFIcnRKUVIxbnJMdjBGT0ltdHNzbTJhcFRtUzd2?=
 =?utf-8?B?NFRiVVd5RDRTcjdQMW56ci9mMW5SSThvWS9za0E5aERMdXhuQmZkVXIvalZB?=
 =?utf-8?B?TnJCc3pjblVKQXBqRi9Zb0RPRHJrQ0xTY21QRmUrbGptUHJSWk5NWkhQRHRo?=
 =?utf-8?B?SGZSU01kdFdQUm0rUXNGMG1vRjE4cUo1RXp4NXM2bnQ4ZFBlYyt1cWUyZVJy?=
 =?utf-8?B?R1dqdFA0em5saUcwelQwMk43L0hNREJzY1VCaXZyT0VyUTFoYVBwRVdiUHBS?=
 =?utf-8?B?TG4yM096RGRjVERhNWtTaVV4aUtzUWt0QjYrWUl5ZkVWeDdHZFBXeGxSc080?=
 =?utf-8?B?VDFRSEhyZ1o0eHpxM1F4UFFCNHhSZjBYcFh3SldVSDBXY3FldFlXVDh6MXlB?=
 =?utf-8?B?cTc3TGFYd0VFb3RKdmRuLzhGTWpTTTVvclVRYlJLVXE5N2Vud1prSHBMamE0?=
 =?utf-8?B?M1Z3L1hGUXlrOW9NcVA1NzMzcGk1VnFCWHd2Rkd5Q29yVm52ODNhd25DVWZq?=
 =?utf-8?B?RTh1Q1FMSmg4WkIxeE95dVltMHJMUU9LVkc1RzhQWjdsbms2M0Z2MU5HVWQ3?=
 =?utf-8?B?MlhjaWdIR3Z5VWY4VVpEMzI0SS9uNU9sdTVtOUlHaDQ4ME9xYmZyYlc4Nkw2?=
 =?utf-8?B?Z0J1TStiYkVQK1E4WDlwbnFWRERMMmhuMitHT2FkcmV3bVl2WHZIa3BIRlE0?=
 =?utf-8?B?cThVbkRrNnRpRHZDR0REZmhtd3ZCNnJlbzAzU0IvbFUyTjZyeW84L2NjYlJR?=
 =?utf-8?B?aVJZLzd3R09EakVpVmpRUzZwNzUvT2YyZVFyaEhFSGNQL1ZKQ0hJUUpWRWt3?=
 =?utf-8?B?c3FnNmszTFZBTTlTeU1salR1aGJ1d1ZSTWZqUGo4bnNXUnJQT3JVQWs2K1NS?=
 =?utf-8?B?Y0FMWWJibGFDRURlMHpIOWhsb0NnOVZ2dHNDRlpwQTQ2aE1vQVBoVGQ4SDJW?=
 =?utf-8?Q?zFDTrel4TpsqY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R05VTzVjVHFNUE8yaWUySDlpSmwvc0t1cWpzaGsrOVNhTHltU2djUC81MFdl?=
 =?utf-8?B?TnRZcE42WmFvdXlsQS9XYS9rTXBSdDNDRFJaQ1VjNmR4cU15WkxsbW90c3hF?=
 =?utf-8?B?THR0dEkzbmJxL0xNb1lzQzVxa1VCUlp5MHZuWlZrdTNqTzFUamx1S3BGTHJB?=
 =?utf-8?B?NUNNV2pVdjFJZ2pXNnZTVjl6NXlURjVxRDF5RmNRRXVkc1ZUVFBYSGUwUzlM?=
 =?utf-8?B?Q0NTaWV0ZXV5UDZWZ2ZIenFkWWhtalg2SmVsZUVTSzZ5NFNTSDAvVmZKSkRt?=
 =?utf-8?B?WHNwanJpNmpRTG1TRWo3ZnBtMkFSaTY5YW1pQ3p0dldwZUpSM1ZKbm83blFI?=
 =?utf-8?B?OUQvVTVBUWxWbzFJSXg5UUorZjRpSEQrNHQ2blhLNFU2MHQyRHZFcmE2dW40?=
 =?utf-8?B?SnZxZ2ZUNHNpSjZNa2RRK0tRandFOEo3MzBqcmE2U1QzcWpaaW9yT3pna1Vk?=
 =?utf-8?B?SlpoZkI2MC9GRnpNd3dubUVIRkM5ZnkwK0t2Y0k2TStZMVhLVW5jTWkxSml1?=
 =?utf-8?B?Z1IyMVV6MFVWRkFxeEFodS90Szd5TUVvcUVBaG00WU9aYTlzL0hBNDJCcXoz?=
 =?utf-8?B?WE9tVHRwNEFBSVg2VHZjSkM4MnBRYzdoMFZxYzEwMTBWN1o3REkvTWQ2T3Q1?=
 =?utf-8?B?MVpNSVFhVzlCNnd5c2l6T3Z5aGNZUXZINFY0VWFGbU5VQmxyNmhaZ1JhT0dB?=
 =?utf-8?B?dCt1MzRnL29qaUdJUkVUcXlJQ2FubUdEZndvTGpmeFVGc3AyWWxVLzdSOEo0?=
 =?utf-8?B?bHJ6NFhYK29oM1ZlV3dFeUdBUmpkVmlxMWg3VGZCMWlMUTZIRnkvTU9OUlg5?=
 =?utf-8?B?NjljbGtaUFhMREhjWFk3MlE1WnMyRzlWSFBSQXFPeEZKWWQyUkt1NkJOS1RM?=
 =?utf-8?B?dTRETUZYODJlc05qRm41dTd3MXZSN0hjVG5qTTBLNFBqdy9XSVJqTzgyZGxV?=
 =?utf-8?B?NDY0QnBhaGlLUm9pNHFyTE5ZQ0NoMDNxbU1iK3lLNndMcUlmaHZBUzZscE1u?=
 =?utf-8?B?WXl3anFYak11cmh4L0xRcW83RWthaXhRT0pDc29kTHliak5WRU05T2UrTlRI?=
 =?utf-8?B?eGlMOTBSazl2dnlLbVJqdWZEYW9mRWZPQUcxRGtjQUd3S25IdVc3eHZFVG44?=
 =?utf-8?B?NDhyVWlaSmRrM205N2JZbUZ1YkpUeXJJdmdsQndNQkNDM1NtRks0KzFOVjY2?=
 =?utf-8?B?OEVOUTNMaVNTUkRPZGtrK1BtSmJWaXY5R0tDUEFPa3lLbzRrNEVXYkw2NlRs?=
 =?utf-8?B?ZkFDay9OYmhrbTdiUjBrMTFPeHBCL2wzK0NDMk15b0ZkRjVwS3A0T3c1SS85?=
 =?utf-8?B?Mml5STQvSWxZQU5BNHlnKzdXNHdaQkZLSHI5ZXJ1MjNIWmRSWVZDeXpmUm5k?=
 =?utf-8?B?R29MUnh5Tm9HbTBiajdXdlFtZm9JQ0lUcmtFdG14ZlhkWnBHZ05ubFNScFpM?=
 =?utf-8?B?K3dTWkNhaEpWT1dISWxFaFZlcjFsOHVQbjY5TVpXS2sycWw0b0dQYXZWRW9m?=
 =?utf-8?B?ajJ2Rm43YnVlcEEvc2hZTDBUL2VDQ20rSzg3Zm8vVlVnUUJ6ZG50RFJjYmcx?=
 =?utf-8?B?SnRUdFZBckorYVY0WDNZN0RyMlpRRWo4eVVXUFpZT0RsUVh4VEYvVHRsNUtR?=
 =?utf-8?B?ZFVpcHBjcWZ4L2c4bkM3UkNBNERVV2VmVDNQelNBNEE4QUJjejNEYW5xbWhF?=
 =?utf-8?B?R3VFUFpiekhBQUVSR0JyTDRMcnd6NmExVXJXYlZOUC91M3J4SmY5TkRySUEv?=
 =?utf-8?B?R0VSeEdoeGZwT3ZMRzI2UkhWVmoyZFBUTXFSSUYrby9rZk5wSTlmeTA1ZUxh?=
 =?utf-8?B?S01jOFV4Q0syYWh3dGlWSG9xTWgwalJIai9xelFOOFU0SjFScnUxaDB6VmRI?=
 =?utf-8?B?MEVLcHk0U1k4eXNUaTQrdGE0SXI3cDZTencvd0EwT3pKTnd0cmFjMGN0MmR4?=
 =?utf-8?B?SEVGcDRmakR3WkY5REZFUTVsNnlGeWxkNWZEVjU5ZFc0Q1EyTDRxbU8rY1Jh?=
 =?utf-8?B?a3JmSWhWQ0p3VS9obFh1NkdwVks0VmFmMytKeXFFaml1cW91ekxZcXJLcGZo?=
 =?utf-8?B?d0t4a2g5UlBtYzhuZmtQZ1A5SWVHZ0EyY2doMHhLOEd4c2lHVmM5dGk5VGJX?=
 =?utf-8?Q?ovf7a0XDHxzAmtYUgWxPnNAI6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dc8605-ed9e-47c6-6ef4-08dd578894a0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 23:43:47.8052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nvvm8mUo335z2L4O6HI2nK0prMX9xKOSAkKG4SowET7newa9mysf+t3+2vHuHwrm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351

On 27 Feb 2025, at 2:04, Liu Shixin wrote:

> On 2025/2/26 15:22, Baolin Wang wrote:
>> Add Zi.
>>
>> On 2025/2/26 15:03, Liu Shixin wrote:
>>> Hi all,
>>>
>>> I found a softlockup when testing shmem large folio swapout-swapin and =
compaction:
>>>
>>>   watchdog: BUG: soft lockup - CPU#30 stuck for 179s! [folio_swap:4714]
>>>   Modules linked in: zram xt_MASQUERADE nf_conntrack_netlink nfnetlink =
iptable_nat xt_addrtype iptable_filter ip_tantel_rapl_msr intel_rapl_common=
 intel_uncore_frequency_common skx_edac_common nfit libnvdimm kvm_intel kvm=
 rapl cixt4 mbcache jbd2 sr_mod cdrom ata_generic ata_piix virtio_net net_f=
ailover ghash_clmulni_intel libata sha512_ssse3
>>>   CPU: 30 UID: 0 PID: 4714 Comm: folio_swap Kdump: loaded Tainted: G   =
          L     6.14.0-rc4-next-20250225+ #2
>>>   Tainted: [L]=3DSOFTLOCKUP
>>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1u=
buntu1.1 04/01/2014
>>>   RIP: 0010:xas_load+0x5d/0xc0
>>>   Code: 08 48 d3 ea 83 e2 3f 89 d0 48 83 c0 04 48 8b 44 c6 08 48 89 73 =
18 48 89 c1 83 e1 03 48 83 f9 02 75 08 48 3d
>>>   RSP: 0000:ffffadf142f1ba60 EFLAGS: 00000293
>>>   RAX: ffffe524cc4f6700 RBX: ffffadf142f1ba90 RCX: 0000000000000000
>>>   RDX: 0000000000000011 RSI: ffff9a3e058acb68 RDI: ffffadf142f1ba90
>>>   RBP: fffffffffffffffe R08: ffffadf142f1bb50 R09: 0000000000000392
>>>   R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000011
>>>   R13: ffffadf142f1bb48 R14: ffff9a3e04e9c588 R15: 0000000000000000
>>>   FS:  00007fd957666740(0000) GS:ffff9a41ac0e5000(0000) knlGS:000000000=
0000000
>>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>   CR2: 00007fd922860000 CR3: 000000025c360001 CR4: 0000000000772ef0
>>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>   PKRU: 55555554
>>>   Call Trace:
>>>    <IRQ>
>>>    ? watchdog_timer_fn+0x1c9/0x250
>>>    ? __pfx_watchdog_timer_fn+0x10/0x10
>>>    ? __hrtimer_run_queues+0x10e/0x250
>>>    ? hrtimer_interrupt+0xfb/0x240
>>>    ? __sysvec_apic_timer_interrupt+0x4e/0xe0
>>>    ? sysvec_apic_timer_interrupt+0x68/0x90
>>>    </IRQ>
>>>    <TASK>
>>>    ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>>>    ? xas_load+0x5d/0xc0
>>>    xas_find+0x153/0x1a0
>>>    find_get_entries+0x73/0x280
>>>    shmem_undo_range+0x1fc/0x640
>>>    shmem_evict_inode+0x109/0x270
>>>    evict+0x107/0x240
>>>    ? fsnotify_destroy_marks+0x25/0x180
>>>    ? _atomic_dec_and_lock+0x35/0x50
>>>    __dentry_kill+0x71/0x190
>>>    dput+0xd1/0x190
>>>    __fput+0x128/0x2a0
>>>    task_work_run+0x57/0x90
>>>    syscall_exit_to_user_mode+0x1cb/0x1e0
>>>    do_syscall_64+0x67/0x170
>>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>   RIP: 0033:0x7fd95776eb8b
>>>
>>> If CONFIG_DEBUG_VM is enabled, we will meet VM_BUG_ON_FOLIO(!folio_test=
_locked(folio)) in
>>> shmem_add_to_page_cache() too.  It seems that the problem is related to=
 memory migration or
>>> compaction which is necessary for reproduction,  although without a cle=
ar why.
>>>
>>> To reproduce the problem, we need firstly a zram device as swap backend=
, and then run the
>>> reproduction program. The reproduction program consists of three parts:
>>>   1. A process constantly changes the status of shmem large folio by th=
ese interfaces:
>>>          /sys/kernel/mm/transparent_hugepage/hugepages-<size>/shmem_ena=
bled
>>>   2. A process constantly echo 1 > /proc/sys/vm/compact_memory
>>>   3. A process constantly alloc/free/swapout/swapin shmem large folios.
>>>
>>> I'm not sure whether the first process is necessary but the second and =
third are. In addition,
>>> I tried hacking to modify compaction_alloc to return NULL, and the prob=
lem disappeared,
>>> so I guess the problem is in migration.
>>>
>>> The problem is different with https://lore.kernel.org/all/1738717785.im=
3r5g2vxc.none@localhost/
>>> since I have confirmed this porblem still existed after merge the fixed=
 patch.
>>
>> Could you check if your version includes Zi's fix[1]? Not sure if it's r=
elated to the shmem large folio split.
>>
>> [1] https://lore.kernel.org/all/AF487A7A-F685-485D-8D74-756C843D6F0A@nvi=
dia.com/
>> .
>>
> Already include this patch when test.

Hi Shixin,

Can you try the diff below? It fixed my local repro.

The issue is that after Baolin=E2=80=99s patch, shmem folios now use high-o=
rder
entry, so the migration code should not update multiple xarray slots.

Hi Baolin,

Is your patch affecting anonymous swapping out? If yes, we can remove
the for loop of updating xarray in __folio_migrate_mapping().

diff --git a/mm/migrate.c b/mm/migrate.c
index 365c6daa8d1b..be77932596b3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -44,6 +44,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
 #include <linux/pagewalk.h>
+#include <linux/shmem_fs.h>

 #include <asm/tlbflush.h>

@@ -524,7 +525,11 @@ static int __folio_migrate_mapping(struct address_spac=
e *mapping,
 			folio_set_swapcache(newfolio);
 			newfolio->private =3D folio_get_private(folio);
 		}
-		entries =3D nr;
+		/* shmem now uses high-order entry */
+		if (folio->mapping && shmem_mapping(folio->mapping))
+			entries =3D 1;
+		else
+			entries =3D nr;
 	} else {
 		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
 		entries =3D 1;


Best Regards,
Yan, Zi

