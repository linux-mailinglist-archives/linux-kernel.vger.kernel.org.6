Return-Path: <linux-kernel+bounces-436084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAAA9E8101
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F32D16314D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799DE1494CF;
	Sat,  7 Dec 2024 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j0y2mDIl"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FCB13B58E
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733588645; cv=fail; b=ARECMZFe3rqd8xv6uvU5Dcfg0IOCGxsJ7XJVkpIqCN3UWft7GaaJo0x1AbdGtB7s7HfZO3an7WDo4Hhq1puRdSIWazzSWqOUAnr3W2kaerfx8rk9gPQe4/+/1aGyiqGA+M2cBP5nyI4xiTmsC9HvSBG1DAmlF3LrbjkflZuP3mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733588645; c=relaxed/simple;
	bh=SuDRAbihPaaF7v1u+NZl8BOGlAG18OU0AKiwif18Vas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o9+NpoKB4WbxteJ4WOPz6VQa9hI5H/VvIr7gKEV3Tf3yb5ZLlwKsdzfw3YWibgQKybVgGrdZOpm0ZeZyMROPb2/hW3p0e+5Or5Sh9ycpXnJo1GMkinbCcB+9f1xkz9ADIwHFw8+rTp50x07AJnfvwvkOC9o4NkIma88Pzg2QSzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j0y2mDIl; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fS/nNw+pFXfHITPYeGb5qP/Pqm374mTjrm3lj2ztUQM7BMDi85IZOM7Hkde2Um7cgnSCf27W0D/Oj1ARNhrF2eS7xTGmysgAJqUuLiyDAgXyA0d3ceFMyCHqpKsJBXpAf2K2oMm4vFaI4/xP7gMcFUbZqzqScuscyhu3BUBAtCxJ4ki6K8jleW/cKfbTy6Z4tS96PUuoNKA1MByUybrO1TzdZJRa5yYtk3K3je6zFMRAcy4KvodeRMWsmooTUzcwKk6VbN0urNA06GXeBOiYmTXTSohaYjnFozD0lfOO4lMc0h76MacUacWti3YLSkuMD2e7EQMFaZadVkdy5P4FpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBOxRv94TL/qQ8QY2VpOyI7Eb29UTmn2txZ4dn12+4c=;
 b=RAmr/orGrWaaGWmDijDS8R1OZUy/cVXdvZ0RODm11Hrm6iQjinWhXiDoBldGb+okiiLZrzBW50plfJHSD8KbwG+vBK66CmKNMOG2O9mepZsWDrBKDZMjCxN7AdNoMeu+H+KSJPOfKHnUc/GrPft1kZFK/iWu1mv4zOPHpUYyzvX6HkOsTmLgCKjCdzi5c4KLbmuyBlL1bki4TEeFFe6+PAFqhedqQFeoHv4LzaI1UUSz3JzOOkWIgSAw/cPcYwWJuqt3u1gpIkpKKk2Mljaw73j8JvBhXqDvnYDiq1kTYBeZLa/aL75jwVuHMIcRGBemyKxFPLiUqMuvVodvReThzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBOxRv94TL/qQ8QY2VpOyI7Eb29UTmn2txZ4dn12+4c=;
 b=j0y2mDIlHbl3kZELT9bUHUZhbe+SEG4aB0N50w4Nj8Q8BRO3tWf6lE2ujdqKrs1nAJnjZaFeCD4C43c99JQSoGuHgqoltT+I3hPiiaz1pjq3WqcM8f8XXs8DjzBoBatcVv+aaJk1K3aKsmW1cnjI1qe5Lw5oRAdyTaTGp5OcEPIfuXjRueCFm15b6yyQuxqiphbIqMCGanB+J/ghgFVfyzcuFXvNHxkyEF3uLnVzQy/Tpsg6dLBXIMjhL6tNuyfjCu8A8/wvPGQjLQkikNUKzs+SarYkzDP2w0neXIAuaAtx7BfRVuz/TshXrcLk90RiJixMCQ+F4jJ5ZgaRku0ZGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Sat, 7 Dec
 2024 16:23:58 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.016; Sat, 7 Dec 2024
 16:23:58 +0000
From: Zi Yan <ziy@nvidia.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Vlastimil Babka <vbabka@suse.cz>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko <glider@google.com>,
 Kees Cook <keescook@chromium.org>, Vineet Gupta <vgupta@kernel.org>,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2] mm: use clear_user_(high)page() for arch with special
 user folio handling
Date: Sat, 07 Dec 2024 11:23:55 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <C86620B0-E95D-4BB0-9470-FDA3422DEC8F@nvidia.com>
In-Reply-To: <34C615C1-E1CB-4D8B-81D2-79CE7672930D@nvidia.com>
References: <20241206174246.2799715-1-ziy@nvidia.com>
 <acd263a4-824c-4c8d-a3e2-8b2f391fc775@efficios.com>
 <34C615C1-E1CB-4D8B-81D2-79CE7672930D@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0089.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::34) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fab7ff-6354-4d46-8460-08dd16db8d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXE1aFhqbW00TTZ6T3VWTnI2aVRsazllMnVCejBFOS9jVk52eXJFQTN0K0t4?=
 =?utf-8?B?di91UzUzaWhHSXB3TnFGYkFpempZVC9OVnVIYU5BaFlPbGtLWUNibll0Z1Zh?=
 =?utf-8?B?aVN6L3hjTWtGcGljc1h6cWdYanpXL2puUWZVaHViWXVwYjhHSmVFalN0U0JW?=
 =?utf-8?B?bjdJVElySUZxb24vSW9qNGJmRHY3TTNwRlNwUndWWUJSNGpuTFRGekozenhG?=
 =?utf-8?B?eVlPa05kYVN1eDFVenVHdW9mUllWTW1UTEJGQ0I2UWdjSElsS0JhUVNoaVBQ?=
 =?utf-8?B?anIrSG4rc1U3WW5GdDZHM3ZwU2dhN2w2cU5wMmRkUzRzejF3MEZkS1ZDbncx?=
 =?utf-8?B?MW5aTjNDOWtyK3lTa3FyK3dYTWR1dHBQV1UwWUIvajI4djBEOVRzWUxiZVZW?=
 =?utf-8?B?cFEvWmg4UGdNcWZzSUFDaXlaNkUvWDhQOWZ2RFBCY1VYeFhpYU1NQkRiSzVo?=
 =?utf-8?B?cnBkKzFtYmQ1VnVRb0l2SGpmS3pNRXpQRE1kWExRRUtheWNhZy9QL1Z4T2Iv?=
 =?utf-8?B?cVdWamNFWC9NbndPMHBMZENIUWRnWW5rMUNLbitST0UzcmtxTDBjUlZQRHBH?=
 =?utf-8?B?UVRwNE1obURZYWx1ejhnTWpRdytHaGdoYlN2M25KOUxpcjVLeHBKZms4NXRm?=
 =?utf-8?B?alFzSUlZMmJwelcwUVI3cG1Qbks5dWdQemFlSUdlQTNWSEF3RXRZc1BmaDdL?=
 =?utf-8?B?L24zMFcycU5wUlJFcGpnZTdZTmFoM1NjbzNkQVhQVVV1VVBzeCtEK3VNZEow?=
 =?utf-8?B?cUZVKzdTS29NZmhidHpaVm5vNHpjVG4yVDhsWmdWdG81ZHA1Rm1jY1g4RVZ6?=
 =?utf-8?B?bE5GNVY0UWlOYTdRWm1Ucm9IMmNLdUs5YXBHdml0MlpCNTVEODZpUitxbm45?=
 =?utf-8?B?RmdCd2I5aTJYRDFMYjM0NmkzUDZzZlVNb2tQallPS3Npb09BNFpqa2kwdlQz?=
 =?utf-8?B?eVBteThHN2J2MEc5R3VXeDFDOHFyYzJ6b0xWUEUzVDBJbnVzT0kvNWJsR2w5?=
 =?utf-8?B?UndMdGQrOTAyTjBzUTA0Tmxnc24zRW5hZ0d3bkVQTlIvMVB3ZVl2eTRuVnZN?=
 =?utf-8?B?OWtiSEtOenlpNW5Oa0VSdWZTckovbGhTc1dTNEh6dlNrbDJGc0NTV0YrcUFi?=
 =?utf-8?B?bC96WjNySzJmWm5RWGY3bHB6dkVGelJrYWZLUTFrRHNxYnVIMEZyNjlMUVND?=
 =?utf-8?B?RnQwZ2Q1U01BUG5WMlhXQTNMOGptV1h2VXJuYlYycmFTbVJFN3huaEd4NGxn?=
 =?utf-8?B?MlFhdnlJYWRzQ05vS3oyd3BnNWk3d2d4cDc1Zk84cW04ak1TMTZUam9HZWYw?=
 =?utf-8?B?eE5kYlFXTWt5SHVmZFR6SmQwRHlqenEyeHBnS3hxcnVsTzBpZjFEcDNUUWFL?=
 =?utf-8?B?YmNaY1pmL2kvSmJZaWswSHZvM045R2Rvd25scDlqM3QwZS9rY3RtdkZoTThE?=
 =?utf-8?B?S1RuL1ZPZFJWNW1SMTNzY1FYV2xpS0VSWmw3U1JheGMwdHV0TGpydFNvZmFj?=
 =?utf-8?B?OGlja0RLdUZrd0oxc1ptT21mVm9ZL1NNSU5kR2hOTTFGQVJXUzduOURmbjdE?=
 =?utf-8?B?TG0ybEtqTHVqSHpsajJvaENXNzlqRkMzYzNrWHZsL1VGalQ2Q2YxNzE0a3hp?=
 =?utf-8?B?VnBISm9wcDhKT2EzOGRQWTY4Tk5wOWpXNVl0RTQ3ZzVVd3QzZCtOVzJERDJj?=
 =?utf-8?B?OTloamFTTXVRZThobXV1aUNwNm52VXhQNTBZSS9qZnRUOUpzVmU2aHNhZldk?=
 =?utf-8?B?TXhWT3BFZUIvTmtHOC9LSTA4WWtuOUZheEFITGphRjR1N1RMT010U09mNFBJ?=
 =?utf-8?Q?FgrQbUqRWX3cvr06/ibaK1YZkz1nCupiAYGOY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXR5b3FtNEJTa0cxbEhYczJPQnYydW52Zm9KTis4NDdUNkJ0ME43V3crV3JR?=
 =?utf-8?B?UzZLZTZLTjlnYzJLTjNlTW85b2w5K3g0WXlDYkorRHlUUklqb3BHYlkrM0Zr?=
 =?utf-8?B?bkowVmNBUTJYZXl2bllUTTh3R2I3SU5MZjYrVytQOXRGbGNLNjZYTHllMmc3?=
 =?utf-8?B?cU1RbWRzaUpXM2hUUmV4Sjd3NHFlMHdtRzVzN0dac0pvMnEydHdQZlZQc3pm?=
 =?utf-8?B?SWZ1QTV0YzZweDdTL1MvaE1MRDVzLysvOVV2WFl0MkpGUHhrY1JZQ3BsL2NL?=
 =?utf-8?B?OUcrZGMvdUVrbmRza2ZtUjFtd2pGSENQT1VTR1o2dVJHRzUyek9nYUprRkZK?=
 =?utf-8?B?aDJWR1RBbjd5NU9kZWpEaVhrOVV5ZU54bDFST0h6ZVNPMUYyU0pWbW5FSmJi?=
 =?utf-8?B?VGFJcHZSaTlvQU5QVGpZK0QzNVlCREtkblJUNGlEUjBJUGxiL2tncURISlVs?=
 =?utf-8?B?RVc1WEdEZ00rS2VsZElNV3I0VVQrb3orMURmc1A0RTFtbnVqSWxFYlI3cHRZ?=
 =?utf-8?B?VE05UGg0ay9jNE5NOHU5MHdHbkNVNm54Smc4Z3NBNS9RMWpVSUhSWSs1R1ZG?=
 =?utf-8?B?ZUxlTW5XcjkzNGJVRk5mY1pQeXlac05ObVJtV21vLzFFZ1NwaE82cFNjNGNP?=
 =?utf-8?B?bnh6aUsrZ2lGTWVVM05kVmwreXZqWDIzM3BrUGZPOCtLMStiK0F0ZHBJR1dB?=
 =?utf-8?B?anlZWEswQ0FPcUF3V1QrYW4vcnhVSnBzWG1yRllRc0xMYjQzRTQ4MWRJd2o4?=
 =?utf-8?B?cmxhcG1qazBvUEJ4TEwzZHU0TmczZUIxeW9lVkJmQk1xTm9xZTQwTDBRTnIw?=
 =?utf-8?B?QmN2T1E2RllFelNEcHpFM0VNT0l4Z1hycVFvQmErck9LOWloUE5wUG1sdE5l?=
 =?utf-8?B?VTdHNEF4Vm5Wb0I0a2pEMXZGRGc2bGhsbmtqd2tLbUZmQWx2REpZOSsrY0FU?=
 =?utf-8?B?cGN1ZS9tejlTMzZ6U0QwSFlzZDg5WVFxWStSUWgrTjdqcThYd0FmcWdWK0Er?=
 =?utf-8?B?Z1lGWEhTWUFLUnhYSUdkcjZxendteURSUTRFZSt5R1krL3hKa1VMb3U2cStt?=
 =?utf-8?B?elpEbEpjRDRlWEE2b0hJakJiZ0VGR2JZdk1OYzJWUk04RVpMWURaT296SGNJ?=
 =?utf-8?B?aEFNQVpiRU5DbW5NVDROengxekRkSG83Q0t4SVZGRWtZOGU0bVFFVEJsSkdt?=
 =?utf-8?B?T1pjUC9zaGpFZUJNVDMvV1lRQTNhcnJjK1VRZldQOS9NbmFQaG9BT3F6bDZF?=
 =?utf-8?B?VTIwQWNEOXZ0VXBaY0hnVnM4VnNTQW5mWDZoL2lGR2tCT2RCeFZUZWdWdFY5?=
 =?utf-8?B?b0VpYUlWalZDbkhxMTIyVVRIcURLbkEzT3ZPaTFTVGtPSFBJSm1pK1JHdDBE?=
 =?utf-8?B?bXNnWDB6YlNBcEd4bGJRVDE0MUdqU2xMa1kyOWY4R0h1WWdDN2oyenE1a1Q5?=
 =?utf-8?B?L3ZLcnV3eVBwNjRsMmloL1p4cWEvLzhYcjk5RTZmbVFicVA4anZEdERaV1Ju?=
 =?utf-8?B?NUJRMVY2eG5WdkdlOVoza3pVVENRV0hRc3YzYmEyZk1vUWFXcmp5elZMenY2?=
 =?utf-8?B?V3pNaHE0V1dDS3hhWVpWQXNWNXRpUWNlNVZMa1JFQlNPbDNsSXRZdGs5cG00?=
 =?utf-8?B?RGVJUlBwR1RMSjBvd1VIVFg2Tmp5WlF2N0xpWk44ZXQ3ZHIyT1Z4OWhCcUFP?=
 =?utf-8?B?WitrcUNrNFJVM1Y0aFYwOFdIeURXcXZTZW5NTllSU1JpQXNVbG1xdStDYUFI?=
 =?utf-8?B?UGNnQnhPNS9nam1VZ1FxTlRUUnZIWFkxMXY0K0FMRVl3UUsrVGRvTnN2eVVL?=
 =?utf-8?B?L1N6YzlyelNtZEowVEx5ZUpxSHkvNjlsdkpFTy9MWkpXb1pUdDQyR2NFTU4r?=
 =?utf-8?B?d2NpeDFZMjhIL00zTFlQYVM5SUx3dGxPUy8xN1FsVDhHR0MwQ3FzYmNPZVRw?=
 =?utf-8?B?aXlxeTRlczgvelVQN3NuZFVETm94ZVhPTklyVzFpNTZYUVRpVkJidUpDNW5J?=
 =?utf-8?B?U1BSYnR3ZU1mby9YZVJDOEE5VUlIbDlwVkhBck1GRVJwR3FDNDhCNGlGMS9Y?=
 =?utf-8?B?L1dHNHIzNlc3ckxGbWl6SzJ4SU1iZGY1VndKeURaRzEwL2JYdjV1bm9HU1JQ?=
 =?utf-8?Q?KxIu09rQcWdHyfyFZxNE/b6iA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fab7ff-6354-4d46-8460-08dd16db8d27
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 16:23:57.9687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPIJzDVg8KkGk/4k6hvHkE5szUVX0bd3Agen65iTdrHR545560/Vc0bJcldOVGqz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411

On 7 Dec 2024, at 11:20, Zi Yan wrote:

> On 7 Dec 2024, at 10:31, Mathieu Desnoyers wrote:
>
>> On 2024-12-06 12:42, Zi Yan wrote:
>>> For architectures setting cpu_dcache_is_aliasing() to true, which requi=
re
>>> flushing cache, and arc, which changes folio->flags after clearing a us=
er
>>> folio, __GFP_ZERO using only clear_page() is not enough to zero user
>>> folios and clear_user_(high)page() must be used. Otherwise, user data
>>> will be corrupted.
>>>
>>> Fix it by always clearing user folios with clear_user_(high)page() when
>>> cpu_dcache_is_aliasing() is true or architecture is arc. Rename
>>> alloc_zeroed() to alloc_need_zeroing() and invert the logic to clarify =
its
>>> intend.
>>>
>>> Fixes: 5708d96da20b ("mm: avoid zeroing user movable page twice with in=
it_on_alloc=3D1")
>>> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Closes: https://lore.kernel.org/linux-mm/CAMuHMdV1hRp_NtR5YnJo=3DHsfgKQ=
eH91J537Gh4gKk3PFZhSkbA@mail.gmail.com/
>>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>   include/linux/highmem.h |  8 +++++++-
>>>   include/linux/mm.h      | 17 +++++++++++++++++
>>>   mm/huge_memory.c        |  9 +++++----
>>>   mm/internal.h           |  6 ------
>>>   mm/memory.c             | 10 +++++-----
>>>   5 files changed, 34 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
>>> index 6e452bd8e7e3..d9beb8371daa 100644
>>> --- a/include/linux/highmem.h
>>> +++ b/include/linux/highmem.h
>>> @@ -224,7 +224,13 @@ static inline
>>>   struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *v=
ma,
>>>   				   unsigned long vaddr)
>>>   {
>>> -	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vad=
dr);
>>> +	struct folio *folio;
>>> +
>>> +	folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
>>> +	if (folio && alloc_need_zeroing())
>>> +		clear_user_highpage(&folio->page, vaddr);
>>> +
>>> +	return folio;
>>>   }
>>>   #endif
>>>  diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index c39c4945946c..ca8df5871213 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -31,6 +31,7 @@
>>>   #include <linux/kasan.h>
>>>   #include <linux/memremap.h>
>>>   #include <linux/slab.h>
>>> +#include <linux/cacheinfo.h>
>>>    struct mempolicy;
>>>   struct anon_vma;
>>> @@ -4175,6 +4176,22 @@ static inline int do_mseal(unsigned long start, =
size_t len_in, unsigned long fla
>>>   }
>>>   #endif
>>>  +/*
>>> + * alloc_need_zeroing checks if a user folio from page allocator needs=
 to be
>>> + * zeroed or not.
>>> + */
>>> +static inline bool alloc_need_zeroing(void)
>>> +{
>>> +	/*
>>> +	 * for user folios, arch with cache aliasing requires cache flush and
>>> +	 * arc changes folio->flags, so always return false to make caller us=
e
>>> +	 * clear_user_page()/clear_user_highpage()
>>> +	 */
>>> +	return (cpu_dcache_is_aliasing() || IS_ENABLED(CONFIG_ARC)) ||
>>
>> Nack.
>>
>> Can we please not go back to re-introducing arch-specific
>> conditionals in generic mm code after the cleanup I did when
>> introducing cpu_dcache_is_aliasing() in commit 8690bbcf3b70 ?
>
> OK
>
>>
>> Based on commit eacd0e950dc2, AFAIU what you appear to need here
>> is to introduce a:
>>
>> cpu_icache_is_aliasing() -> note the "i" for instruction cache
>>
>> It would typically be directly set to
>>
>> #define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()
>>
>> except on architecture like ARC when the icache vs dcache
>> is aliasing, but not dcache vs dcache.
>>
>> So for ARC it would be defined as:
>>
>> #define cpu_dcache_is_aliasing() false
>> #define cpu_icache_is_aliasing() true
>>
>> And the Kconfig ARCH_HAS_CPU_CACHE_ALIASING=3Dy would be set for ARC
>> again.
>>
>
> Sounds good to me.
>
>> I'm not entirely sure if we want to go for the wording "is_aliasing"
>> or "is_incoherent" when talking about icache vs dcache, so I'm open
>> to ideas here.
>>
>
> Let me know if the code below looks good to you. I will use
> (cpu_icache_is_aliasing() || cpu_dcache_is_aliasing())
> instead of
> (cpu_dcache_is_aliasing() || IS_ENABLED(CONFIG_ARC))
> in my next version.

Or this one, which set cpu_icache_is_aliasing()=E2=80=99s default value
in the generic header:

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 5b2488142041..e96935373796 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -6,6 +6,7 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
+	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT
diff --git a/arch/arc/include/asm/cachetype.h b/arch/arc/include/asm/cachet=
ype.h
new file mode 100644
index 000000000000..acd3b6cb4bf5
--- /dev/null
+++ b/arch/arc/include/asm/cachetype.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_ARC_CACHETYPE_H
+#define __ASM_ARC_CACHETYPE_H
+
+#define cpu_dcache_is_aliasing()	false
+#define cpu_icache_is_aliasing()	true
+
+#endif
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 108060612bb8..61a46cdff1dc 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -155,8 +155,14 @@ static inline int get_cpu_cacheinfo_id(int cpu, int le=
vel)

 #ifndef CONFIG_ARCH_HAS_CPU_CACHE_ALIASING
 #define cpu_dcache_is_aliasing()	false
+#define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()
 #else
 #include <asm/cachetype.h>
+
+#ifndef cpu_icache_is_aliasing
+#define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()
+#endif
+
 #endif

 #endif /* _LINUX_CACHEINFO_H */


Best Regards,
Yan, Zi

