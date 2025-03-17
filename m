Return-Path: <linux-kernel+bounces-563418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746D9A64164
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F98C3AA4D6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27928219A67;
	Mon, 17 Mar 2025 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fY2WcAYk"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2063.outbound.protection.outlook.com [40.107.215.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FBF42C0B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742192804; cv=fail; b=ASkbHttLdgVz2+ZpMuzMWZz+VOl/Z7sP6lczAqbwi8IBV60eFna94rqVu8rcPR1yUyzTdLp4JAkzadY+cQPzpFAo4M1ZjAPjeWixcoUXlOAgYmMtXieVA3vPKnj3x9Over1BCXVdjLCnFsT+NyjHOzv+p/oxc2UfQ61p/EcqvP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742192804; c=relaxed/simple;
	bh=OIoTqpHhDUafO5USrhxI1OBhWX5+er7geuqcQabBhA4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nw7Z/oG6Qc3afy5Qrj4QESzABtX9E5QhLBujkzu/ClSc5DUBgOuZKZjX2QuKPAJFPCvYRUk94HsMO6nJIoSu1rmfQdjop9baRB/ql/H0F9e8NjJTOh/HyycyKD089NDrXOTTE8LZQdGB1mKEaSP0E4mwB6iZUXBaUScl5shL/SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fY2WcAYk; arc=fail smtp.client-ip=40.107.215.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+H+nJ0mnMiI1PNDiMvpwwwLsbL99UH9SeJSwi+Sind440fMX8knjq6Ee3LRn1HeJ8SfuLcN1aY0c5oRnbSRbTP7dH6vepL9LSCxQMFb6AmQcEQSt3oi0480+wTHSfrVFY8mbYy7sPxqcpr/bHdRu7+thvpvWkEAjHyrK5h2EDLBlHOPmX47RptSqrgmTockwVZ6pPI2Q7oRRy4wMBZmFGEym1j09TAjtJB9OBqgiJR9/xFjydKhn/z4Vpd4WUqjR72w1RvxFNkzUhUg2no8XWhrF2HYXMjgTcFYjonqJ6AtVYvZTntKIHG5a2Q5dLhzFDWTsGLEXjevhSmm70TgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/RFNRiAEENVIsNvOXOug5F1J/y57/ACWz8+je6dw6U=;
 b=ynvO/zUwd2XA1/Q3uaRdZwLwHVWsad3ME8+y2FuN0dHe3Mv25KhMxvoRRDdAYVEq8at+mlBPc5523w7U11oT4al2sZQHhkKJ+0QcxuMR/TQW7zj9+W+XkkLNrfoKuFNfrLk9oWe7N6VlCAlc5qEIEENuDwXXdh0Ls/00ao5m1cP03eD6HiZ7BR9BcSuSKKdfQQWeamr19UmcsbfKMzWjALPlYA1VLxDE7Z4g9bxKg3RGsuqN61XPkcM5Z+MslhlZHH9bj17VYsiBqBMnNyZi8U7CLYkvVw5iiXcymqp/coLYlfkcmZQA9qs+2asvVA0VYkwkI3XXYvRuH63nqVACkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/RFNRiAEENVIsNvOXOug5F1J/y57/ACWz8+je6dw6U=;
 b=fY2WcAYkp9HO1uxZz0QZAiiZ+nNqqWnn1WIfGEQdg53QrsfknNGE3QDWqlIUiy/cChorJ6YsxIEMJhoy4g68hErL1+C0GZ/A4LDCY1OzLeJ8wfV4YdkXRI+ayxk0lgsBddBovA+VZpW+QkopCLPFR15a+0GwtPMz/YZ2ox7hv/F5lJZyxoAV6BVBv/25FQ3ynpNSVGgbDGL8DKybK62xBddZMkQrMIoki9aNWtccsueM8H/pQH4mTNGLwnJK0pAAesFMuzxXGcWU+Iyd+iOUunwGPzO4nibd+nFDHtCv39tWw7Sd3t1oufE7VzY7ZZrLWx9DtgVhzRbHuiuW2zEX4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB6594.apcprd06.prod.outlook.com (2603:1096:400:462::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 06:26:36 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 06:26:36 +0000
Message-ID: <fb36378e-a3ab-4ac4-a71f-ccc95f96361e@vivo.com>
Date: Mon, 17 Mar 2025 14:26:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
To: Bingbu Cao <bingbu.cao@linux.intel.com>, hch@lst.de
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, opensource.kernel@vivo.com,
 rppt@kernel.org, ryan.roberts@arm.com, urezki@gmail.com, ziy@nvidia.com
References: <20250312061836.GA12841@lst.de>
 <339b0c1f-ce90-449f-a1fc-2656d5a1115c@vivo.com>
 <79247edd-761c-82e3-b8d2-acdbe31c8205@linux.intel.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <79247edd-761c-82e3-b8d2-acdbe31c8205@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:4:91::23) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2ac4c7-666b-4d32-0567-08dd651caafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXRDU3VBa1VEcmFNTEFtL1lWaVNQSWl1MW5FQndvWGE1U01tZ3pEWmRiMlNP?=
 =?utf-8?B?emJZYUdRWmxVMi9hci9jNmRJTFNxQW5acXA5Vm5aVVJ6c0sxbUkyWW5vQzNa?=
 =?utf-8?B?YW43RmtEK2RrRDFEZk9LV2dVOTB2Vk8vZUtGVTZmWk8xckpCV2dqZGJLWlRn?=
 =?utf-8?B?bVhUS0U0Y1VYakQ3YmNic3JRc2xkL3ZCY29DVWVIT0E2aktFSlhXSkxUamRW?=
 =?utf-8?B?SzlDTHJPL2hTcjZQcTJyY1NZeVdUaERTUklUU1pvdlFZcHE1TXZWYytlaE1W?=
 =?utf-8?B?SHZHV3ZnREVrTi9tWHp5OCs5RWFmMzBleGVscTRna29PNTcyUWNTSXUyWmpV?=
 =?utf-8?B?YVZ1dWdsajZwSEVKZSt5Mm5QUlBMT2c4eGlqL2drYWZXU3EwRVVCbC9sb3hM?=
 =?utf-8?B?VHJZaGZOYTdUbkdCczUzQkRwVmM1QTdkb3VYa29UQys1L24yOTk1N3RtWUkw?=
 =?utf-8?B?S1VjSHZ2Ynl1SG5YTVl6d1dXTW81c1VpNm9iNjJvVlZGbStRMGhNMjRCOVdO?=
 =?utf-8?B?NjA0RisrcFJTUTRzaEFON25lQ29UeDVlRkJFRno1N1dHU3dYRlRqUVRlTmNL?=
 =?utf-8?B?NWtESlczMW1RQUgwZG5qdWNjMEIrbTJ4ckZ4T3U1S0VRQ2xqZStkODdFOGlB?=
 =?utf-8?B?QlB6dUdvdmJSNUZ6WmtwUTRLTnR6WXpaUXF6SzZWd1JaZU1nMkhlYmF6anha?=
 =?utf-8?B?cFlPVWNzSStwcUltdzVwbENzbGYwWmhINlQxeU5JcWM0UEJtLzJuVy9ORzFm?=
 =?utf-8?B?OXhZSFg0N3NRYnlzdE43WFludDA1Y1pzWStjZEZOTFlDYlYyTTB1VUJzZVRX?=
 =?utf-8?B?bkxqQms2TmQ2WUNkK2hGUUp1RUZqM3pGMkFSa0V6VDNiQ1NlNytBK1llTzJX?=
 =?utf-8?B?THpxVmZMVFkydnVaWm03RjhxUWJua2gya3Q4RU1jNWR6eGhGUG9nYUpUTEI2?=
 =?utf-8?B?RVJPRzdLYVdqanFkdStnOFltYlZ5S0txTHUzMUZkamJjQk93cVdUUU5QZkZo?=
 =?utf-8?B?VW9Ca3pYcnc4ZE94TXZOTTVZeG9JRExCMlhwTWlKT1pQaEhQczJFTk9MTWdt?=
 =?utf-8?B?aXE0TDRvMmNRMTBJSUpnSXdtRTRWUHY4YnNiTFZGRmoyL1h0ZUhZckVEeVFH?=
 =?utf-8?B?bGJibWI1eWNZVm1xajE5aVRGbHNRc0k4VTBmWTlZK2JwbHdtdElsMlpWOFVq?=
 =?utf-8?B?c2xpcWJrNVg2WmhJUld4akVHeFhvbUxwdEJiZGcxYVBrL2ZodDl2RDBmMnJq?=
 =?utf-8?B?U2FENFh3Ujk5dkd3SHFKZDh4UnQycU9mWjNGc1V5MHRXWXFFL1JvT2JvS0JY?=
 =?utf-8?B?Ymd3RUg2aUl4Tmd4SXlGRFF1Zk1CTmUwQWZ6ZC82UzdjY2piMEdiRVdubzNu?=
 =?utf-8?B?Wk9XZHdwamxGZjRvVlczVENCSkR4QlRWajJocGRnd01mSUNlQWlRTkMrd1Bn?=
 =?utf-8?B?anF6bE9xN0JpN3g2Y3RyaFNiZ2xRUHNpT2ZJUWJIVnJTU1lScGJQRmtLL2ta?=
 =?utf-8?B?QnBXYU03UW5BRDJRZ0E5N04rc0JFbUg4Skl5SUgzZTNrSytkUUswZC9mMmdB?=
 =?utf-8?B?T2dKSnNSeklzRUh4dmluaUxia2RuanRod3NNTko2Z2ErTjhpUUduT0lEdXNH?=
 =?utf-8?B?RUphVkR3OXBueVFDOEUyRDFaeUYzNjM2d0t4bUJIWFEycWt5MmpUQVlSem02?=
 =?utf-8?B?aUFGaFJNMUdpTk1XWXY1NjEzekFpRkVmNCtWN3FVUzRTWGtkWk9qRHhXU3ln?=
 =?utf-8?B?OTE4UjJ5R0l4N1Q3MzdxcjhIYXM0djlQUzhLdEtrUnYxcncwTStiUS9raGxX?=
 =?utf-8?B?S0VjT3RzMFRzcHFsZUVPVUx1bGxRQlQ5Rm5YT1JxRW9oYStRRi80Yzllc1p6?=
 =?utf-8?B?TmlLUjliZ0g5R0xyRUN4VE9hK21LcnBINHZVTFFMZ3p4U2NONDdHVTc4akNz?=
 =?utf-8?Q?Qn4EhMAXfMjYLEK9nOu5++hE34vW8J/5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzZPdVE4N2F2TXhyUHN3Qmk1NjIraUR6VVdIbXlGUFZlQWExN0MzWEdsd0tM?=
 =?utf-8?B?cVJXbEJMYWJlY25QMVZPZkJPQlRRdnhiRG1yZUNTeGZEOHAxNVQ4eG1yM2tp?=
 =?utf-8?B?V0x2TW56eEJNSkROMGVEUGF1QUpIRUN0WktSNC90MzU0N1lkdGJnaHJ1VTl2?=
 =?utf-8?B?bWFWU0U0bVQzNHkxV0J3OFhFYUVKekRITEhnQlVWWWpKODJpano4b0JzZlpS?=
 =?utf-8?B?NERxMWIvNm5pdTFGVHNMeWdFb0tsbkd5TTR5eGtVbVEwZFdqNmlteURaSjhp?=
 =?utf-8?B?WDhEQ3ZXV1M4bmFqc0pjbHFtQmV5T3MybzNRb3hKNktZTFhsbXc0RTdsWm5q?=
 =?utf-8?B?REZRc3ZEWW1XVnljZEdsU0Y5bm5wVkhoQmxFb3FSWkErdXVUSnB1bjVpT2x1?=
 =?utf-8?B?SHZPSGZOUktEbldFT21jVUF1M0htNUtFUEpMdUlnc1FZSDZRc0RjNm9STFRP?=
 =?utf-8?B?TTdhWmZuZXhuVUswdkVSc3h3Yk1nTjR1SHlkQXdaZjNTTTNXQkpvVE9wdzRx?=
 =?utf-8?B?Nk1VN1ZsVGJzY3VHb2RwVXFEOHFuQmI5dDdOeDh5UHhKcGExVjBidGZ0RFZq?=
 =?utf-8?B?TnJXVEczZEFucitocWdkcmMvVWNvSm1xMnpJVUFnRTNCZXBzaS84Tk1IU0ln?=
 =?utf-8?B?emk4RkxvVnIvRkV1MGIzZUpPTCtkazcvdzhNdXZ1SUxwWEQ5Q25MTUk4TWdw?=
 =?utf-8?B?dGRtRXl6NFVHVC9ha1EyWGh4aU1XQkUwV1Y0Rlp0Y0RZS3NwQ0NrNDA0TVlh?=
 =?utf-8?B?TjJKNTVxQWxna056NnFvbmtWZXJSZlhTRXllSE1TdmhVTjhoK1pJNVE5NEFn?=
 =?utf-8?B?VkdPZmV2cTgzS1lkS0RuWXlDMzV5LzkwR2VDRlpwdFNheTJIMVBseFdFSmNt?=
 =?utf-8?B?a1dhQ1k0RGJhVDhzdTQ3YktCVDFlY056bTVVZlNRaXlrT2dQVVo5SHFndG5T?=
 =?utf-8?B?SUR5V3VUMkQya0FBZDlQR29JbGxyQ1NRYVBRUlpDYmlueDh1MHMyRjVnamRk?=
 =?utf-8?B?cjJGRjNuK2NUT3J3Q0RjVUlMd3M2UU9NL2xsQzNabFB0OUZ4UWtwL2d1blJZ?=
 =?utf-8?B?c1ZlME9vNVdaQkFtV2xXRS81S2NlbFNteEtSYUp4S0kzRldkQVlJVU9Wa2F2?=
 =?utf-8?B?STRYVUNma09wMGpjQmxZa0Z3UzJpQ3F4UkxVanBrSVZPNmpiam5GazAyRlA4?=
 =?utf-8?B?T1lrT2N0Q2dWTWllblYrYlRTOVRudHJTY05BcUJvMFI3Qzg1WTEvN0hvRnA2?=
 =?utf-8?B?TUNwcWhyTzAwcXNCQytuUDZzSkJVUDFOKzRINEMzMmVyNHoydUllclhlYVB6?=
 =?utf-8?B?dWV3aHhkWEQzUFdpQm9NQnhNZ2twMFVNUXpoNnpjVU8zOXY5TTV5OXNmbmpt?=
 =?utf-8?B?ZDROZUZWcUt4WVcwaW9vYytvQXR0Nnh5U1h4RkNuanAvaXdydlQrdVdOcXBG?=
 =?utf-8?B?MEhEYzJsTTl3NnVvam4wb0lHeUlSaDhySy9OTjBHNWhaaGE2TC9keHhHMHMy?=
 =?utf-8?B?dzJ2REwrbFRqRlRxbFhKUXFiYWp5eGo2dFgvV0NlNVFKY1UvNW1ia0daYTJY?=
 =?utf-8?B?S2YvK05yME5Tb1ZFem0rbzJJTkIvL2NyVmkzU2ZHalpWejFvZ09lQ2djeE9s?=
 =?utf-8?B?eHcyWkdjMjdvYytoYXBhaE1peHJCeFFoMnBmKzhkVytGRThCL0Faa3VOYmV0?=
 =?utf-8?B?U2JLNVBnbHd3MU5lYnNrZ3BMUmpDWld4UHRLNzFWMTEyZXBlTEpCcE01VTg1?=
 =?utf-8?B?cFM0b3pmNnZhZmR4WEFvVDEyMDRDNm1saDFxTy90eXRRZDlJdDFGY0pvbmdG?=
 =?utf-8?B?QTNWd011cVdwemNsOXltdjFNNFpLNUhOdjJUa05yd1Azd0g3alVLZHJCNFR5?=
 =?utf-8?B?VHN1bUJOelpGTGxmMnR6SmMzS0dRRkJNNStrTzhhbWY0Q3AyQ1g3bUw3cjJs?=
 =?utf-8?B?MHBPejBWQ1ArVGR4ZWRQTUw3OXZvUWpJRmFjc0NLOUdYS3U0ZmtvSmp2eG1l?=
 =?utf-8?B?M1Q4ZVhjWE8zZy9NTENLcytIUjgxK2ZvMjFKbjVFdlEydXlITWtlUHBNbElF?=
 =?utf-8?B?ZE5UdnladzlIVTRuRUVMYmo0SC9KRndmaUk0WkxSUnpnRU5WTTgrM3crOFUv?=
 =?utf-8?Q?zhYO0qMR9JCIDM7aH/nHrm3I9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2ac4c7-666b-4d32-0567-08dd651caafb
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 06:26:36.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymHJ6d8L6aF4H687yjpvKliNp5ywdpw0ra1I2orzVfMXtpi7GobdyXrsxzzBOXG6x3rErs78scsCcPbrpXGXXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6594

Hi Bingbu

在 2025/3/17 13:29, Bingbu Cao 写道:
> On 3/17/25 10:12 AM, Huan Yang wrote:
>> HI Christoph,
>>
>> Thanks for your reply, and I'm sorry for my late reply. Your response
>> didn't appear in my email client; I only saw it on the website.:(
>>
>>>> On Wed, Mar 12, 2025 at 02:15:12PM +0800, Huan Yang wrote:
>>>> When invoke vmap_pfns, it call vmap_pfn_apply to set pfn into pte. >> It check pfn is valid, if true then warn and return. >> >> This is
>> a mischeck, actually we need set a valid pfn into pte, not an >> invalid pfn. >
>>> As just discussed this is wrong.  vmap_pfn is for mapping non-page
>> Thank you for your explanation. I now understand that the design of vmap_pfn
>> is indeed intentional. It's design to do this.
>>> PFNs and the check is what enforces that.  What is the point of having
>>> that detailed discussion if you just send the broken patch anyway with
>>> a commit log not even acknowledging the facts?
>> Sorry for that.
>>
>> We now have a new use case where, in udmabuf, memory is passed via memfd and can
>> be either shmem or hugetlb.
>> When the memory is hugetlb and HVO is enabled, the tail page's struct is no longer
>> reliable because it has been freed. Can't use vmap.
>> Therefore, when making modifications, I recorded the pfn of the folio base pfn + offset and called vmap_pfns.
>> And, these pfns are valid. So rejected by vmap_pfns.
>>
>> Can we just remove pfn_valid check in vmap_pfns, so make it suit for both of they?
>> If you agree, I wanna send a new patch.
> Huan,
>
> Why not update udmabuf to make it work with both vmap_pfns() and
> vmap()? As only the udmabuf knows it is actually working on?

You mean, If udmabuf invoke vmap if it's normal page-based folio range, 
else invoke vmap_pfns

if it's in HVO based?

udmabuf can contained a rane in folio and offset, what if it contains 
folio's head(with page struct) and

remain tail(without page struct, freed by HVO).

I think there are no suitable way to map it into vmalloc area.:)

Or else, just block hugetlb's folio mapped into vmalloc area? Which I 
don't think it's a good way.

>
> I don't think it's a good idea to hack the common API, the WARN_ON()

You mean common, but I think vmalloc can provide a more common API that 
not care if page it's

exist, if provide pfn, just map? :)

Or else, document it that vmap_pfn just do not welcome page based pfn 
map?(Just IMO)

Thanks,

Huan Yang

> is really a mandatory check, and current case is a good example.
>
>> Thank you,
>> Huan Yang
>>

