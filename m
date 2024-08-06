Return-Path: <linux-kernel+bounces-275558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4F494872C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B411F23856
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F262E182B4;
	Tue,  6 Aug 2024 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LgpWGKLJ"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2059.outbound.protection.outlook.com [40.107.215.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60010B665
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909722; cv=fail; b=kAmf4uhA10YRiiqKHq0mZmKb6RciSk5OuG8QGITUwnPyt6PpEmmoVMRReC6ypkp4VyCsFBSQAOl3lbXWQJ5bK6c8pmXlB2uxWT4XmNFbt39P2VEqLJUCX3nokRkBTaw/AZ3E2TKerJSrSRxCTjGxVCHBq2tyQN5b2WiRambw08U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909722; c=relaxed/simple;
	bh=juWVYwqic1TywCQfNQ8i7MKjNU+vptZrDY8/ic76REg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G8gUNpjTCoiMnBaosVOuH0PYbkXES22c4bCttcqp3o0eE3Qe6iqJ/ruFWyyXLer/olY1bIO3us9q9wHDo3zGw/RAFNzgjOQXrbrcvuVCzBZsJdhPYtvu1QzJfHzYPHRCShK3xOdMjqpHYhlHbRsO+tbWNnkYVnvK9hikLUhd1zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LgpWGKLJ; arc=fail smtp.client-ip=40.107.215.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpmQSVpuq6SLOTO0e0YQrrJtiV2PSatOoCw+OLgduxQ2DNFE9L3p6HsYWZf4OzYuMARU83HkEisO2+Q6jIPy5t+0TpguyfUDvOx3RkYRaCAm3Z3KepZwhm2eEhzY5QGON/2BCVSpezOLGlnfgP5kOKyxRhcgFTSXS/QLYsEDOUdQJ9gXyj0zr74QGOeaIZ3nNHLdx4JsIMoSDAEul8CjkSOm0Ua8qgaE4/7fFNk7NnvAqtnML8GalSzk/NyhLdZoepOCix4m0D3uI6I6MyEyB0MO0Cl9/8WAC0jOImYa6CqwVq3TaWeji6nU+ND5LixGD5/nzBN+m1VSbPcvW+1XVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZanajdPmVxRYwxycKGkdRBOHban7y2WRGwmTcJ0yug=;
 b=AcR3Rn68zqP8jcgzvFGox/o31YnsUHZ13VFyN6xuFhtW3wqW+dv5BVFK9nE+YXQ5FaxT8yjTUJcN1YBLdH8iUuO3KpU75iRNX7gPZHjkTGBqpEOnYlZPuKvx6DBZERrcK2MOEH62GK8rkozqzeITFZuTlzUidH6fGbClHrPLutaaDBtDl9S/ZDEqFvTQ68sdFA/iM+qw0+REkP5uiioSkzGhSzm674vTFF5zUmTtQzb1k8EtzgzwzzGMyopSinR1PLSGsGxTai5/8mz4kUUR3efltoaX2UOkD1GNJ87b6QgT8q4jZuxinTpaATivdwT7wuz8m7mZPS3w9ilalxHCyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZanajdPmVxRYwxycKGkdRBOHban7y2WRGwmTcJ0yug=;
 b=LgpWGKLJSMLDiMpXok1boxT7YziKH6KwX5kiVWl2PmkgwpJDhzS0Cts8/mVJovbquOqqw16lEMxfIcq/JZWwZkT+53zsP8PSoQL/QkfnphQwQACv/bOC5AsXcXM/ly2iuw8b6Vu4BxnodTRqdeMuhOkuFoMvZvCJaSSmQDm6UVuZxtkIIxXZQVrkuxlHaGe3E9DnQg5JPoWIn63fk1HVllOIDQ1XA8hPWoJ19UGzIQ31tlBOlSh0lys0LFNlOoMwuy0fXRdqOD9Xn7DOQGmsTDiGP1pRRAJinA89hMU2YLP6TB+gFSNtzOJQuPFpksjHl2eVQR9Jw/zONoWf3uHExw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TY0PR06MB5753.apcprd06.prod.outlook.com (2603:1096:400:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 6 Aug
 2024 02:01:54 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 02:01:54 +0000
Message-ID: <3699860f-3887-4a99-b9ef-10e3f86ec3bb@vivo.com>
Date: Tue, 6 Aug 2024 10:01:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: swap: mTHP frees entries as a whole
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>,
 opensource.kernel@vivo.com
References: <20240805160754.1081-1-justinjiang@vivo.com>
 <CAGsJ_4wqENiGf4FoEKA2yO5pmu3SfJD9qsjHD0E7eHPZG1+PuA@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4wqENiGf4FoEKA2yO5pmu3SfJD9qsjHD0E7eHPZG1+PuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TY0PR06MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 453fc298-a252-4525-c4e7-08dcb5bbbe6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzJQODRwNHFGc3I3SHJWdzhXRUhvNm03VTJwNDJJTkhJVlY5Sm13ZnZZYi9h?=
 =?utf-8?B?WXBNMm1wKzIzSkowcXpONVZFSEg4dFFaSkdZbnpSeXNCS0paM1JKZTVGYTdj?=
 =?utf-8?B?eHdhV2NJYzZwUTB5UW9RWjQ3MmRwWFNsRXhZTTZUNjZFcjhKRXhCaUNOZytN?=
 =?utf-8?B?YlBYSFlFc2ZxdzBZa2s3U3VUd1RacmdpNXp3THpJTjQvMnprUEt1RDFUUjFH?=
 =?utf-8?B?WlBrQXk1SU1qQ0NEUHlIY1AxMm5oZ0JaVS9KU2RvTHN1bmh4YzdpeDBuQmxT?=
 =?utf-8?B?RFU3WkFES2xTNkZ1dWxuaW8zOVpKcmRvU0l6djdiWEh3Z1VTUEV1Rk9raDVU?=
 =?utf-8?B?NE4zNjcwQUZLbmFJYldtamhoK1d2VUc1UkNIOGJuUkF3bTA2T3pFVGNJaW1i?=
 =?utf-8?B?U2xsajF4UXJEMk51N1FTc2kwNkFJK3JYa2dlN3Z2ek8vV25uZGYzdXBWcGxx?=
 =?utf-8?B?UTdPOEpJNm5lWXNvR0dSTGZ1aS9LSXRUYXdFSUw3NDJIT2N5dmswV0dKMk1G?=
 =?utf-8?B?aXMveWVLL0IyaGdRem0xc25sQW4yNkJ5Ym5xT2dyb0kvQi9CYTFhR0dYb3E4?=
 =?utf-8?B?WGFocU5xZUpJRkVpajB0UlpVU1ZVWUpmRXJvTkVUam1TbVRORGg0VWhpWklO?=
 =?utf-8?B?VEtZWC83YXMxRWJDRUtyT0xYQU0wSUtlMmhPcExwQXV2SzBKZXJ3NzgwRXBa?=
 =?utf-8?B?dmp0dVcyY0JHNUQ2Nnl1YnVvSzVvaTJYT0FNQ0F0eXNOVUFBV0ZncGhFbE1I?=
 =?utf-8?B?NE0vSCtISFRuTFRvUDJ6Nis4bmlmcU03dmVPaVRLN2dJYVVwbTE4VVpDdk1k?=
 =?utf-8?B?Ui8xcmZCVE9HRUFtUkJyM3NMY21oODc1Wi9yVWdpRWFha204RUNhR2c5RklT?=
 =?utf-8?B?RTdvTnUxSjJLc2pLNEYzMnBlVVB6L1pSZnZlbUwwN2Jsb1o4Y0tCOFpGa0pP?=
 =?utf-8?B?UEt3dXVuZFVSTDcwZTFGZy8waTNsemxJbWV0eE5jcDlKeDZmcXNkMUN5T2R4?=
 =?utf-8?B?UUNqRXFHdTR4ZEhOMGFPbHNyQ1BrV0dqTldtRi8xdnM4V3RCdjUxK2lxMWM1?=
 =?utf-8?B?Wnpib20rbUIreEJKS3plWGwzaVMwSWJPQzhXeGhCaEVkL2h4ZEZIeXV0ekla?=
 =?utf-8?B?bzlLWEUxcnZFRDIzOG1VNW9VbEJLMnBVZ29VNjhGWEwvZmFUbHZQVU9MSHRN?=
 =?utf-8?B?Y0EzMkV6c2k5czNzNWtxMHNUd0pLMGM5d0lrRmxYeUMwdk9hYVEvN2JOSlhS?=
 =?utf-8?B?VzZEZm9jR2kvZ1Z2aU82aVBWSU1oa1phMG5OSy8xazgrY1pZMGRWYUlIY2V2?=
 =?utf-8?B?eWZYbGNXN3IyeUVaVnFJK0EyaFp4QXpxUnlJMWt3aXpsWGc4MGx6NkxSVTdy?=
 =?utf-8?B?MWZHZVpoVjV0TXkvak1ibW1qQzBEeHZRUEJRVHN5NkVNMGtXRnh6L0Jidkdz?=
 =?utf-8?B?R0trYmF0V3Zialc5d2ZyMCtTRVFLdVVMeHorV0NZQW14eGRNN0RSTnQ1KzVX?=
 =?utf-8?B?R2FIU25vRFVlZXZLRTB2YlVsZzl6NkFhYmtZK2RwZlZEbDV3WXRqdG1CSWFV?=
 =?utf-8?B?UWFPOUw2aDJncVBnVURYK2pudWF6UjZmOUJLZFJkS3JrcWo5K0o1dlVsK0Ni?=
 =?utf-8?B?Y21xV2EreTlXY2RHNndRWkFLMlJ0bmw5S3g3M3N4bUhrWk1MMGF6aWdIZkh5?=
 =?utf-8?B?ZjhmZG5YSGtGMWU3cU9XTmZiMThHSk5tK3V5MGcrUlo0SFdkU09tSTdteDI3?=
 =?utf-8?B?RzU5SXozY1g3bnFKUjVQQUV1SkE5SHVVM0REcEdTdjNKd1BMZnBLbUR5ckxk?=
 =?utf-8?B?dEdXalJSbUE1RVhaMHA2Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2dFS0xpY0VSc3ZmTzU0T1FabUNLd20wRDdwUHNlZjR2Zk1iNXpkT09VYWM0?=
 =?utf-8?B?U2tzQk42aDJmL0lyNFAwQ0Q3akFJNnlEOS9GRWVlNWx1NVVjUW5CSXJOMzNh?=
 =?utf-8?B?blUvTS9VRTBjZUZPOTgyTmRQNUxHaTFTSm54b1IxOVJIejM1eWgyTnhybTdB?=
 =?utf-8?B?VnNZdzhhVm5wUFZ0R216a2J4OFE2amhZNS9OdUNGRm80ckpNendrbXlDdUZN?=
 =?utf-8?B?NFl2c2JTUnp1RnU2NjFkQUc3UnI3OE9ZRWUzSjZvUkxXWCtLZVNzRkhmNlE4?=
 =?utf-8?B?WVR6ZEpaYTZGSjE2NFdpT3QwU2Fid05vbmVWVzNNalVtODRsYTJwbHRLSUhh?=
 =?utf-8?B?UEFMRmZQaDZpWGRUbjFCcTlqdXErakpFOEE3R0Fmem5wdFdiUkw0dmtmaTND?=
 =?utf-8?B?OTNETWNpMlkvOW12aDdVYngyYmcwaWFaU0gwMDJXTkg3MXRxVjNqa2VBT1NB?=
 =?utf-8?B?Zm1OcDFYNG5MS1Y3SHo3NjRZNnQ0WFllV0tBSUdEZkpJaFNPNUtEclFxWnFY?=
 =?utf-8?B?bjJwRVNBeGwzaW9EMk5DMEx2UWRDbjRJenQ0VVhOZzhlRjI5OE42RHZ5elBI?=
 =?utf-8?B?bWpsY0srRS9mcUZxRy8yZldLWmpobzU0NjB4QStjV2czNTJvMSs4MGVTeFVu?=
 =?utf-8?B?UkJnUE9JSWhNL0IySE14dFJVTFhjUUdmMTJvUjIzc21QSC9DRWhFYk5OZzNL?=
 =?utf-8?B?NElUTzhGa2dMNURoRE4wRWF5SjhOeWJuUENHek4vNStVV3kydTFTeEtmVFdG?=
 =?utf-8?B?enBpMHZEdXBuSzJMaXZQZmppT3ZOYzlFK2Q0bFJzTkNiUm9LQnF1eFduK2F2?=
 =?utf-8?B?dUhKa1pZQVZBN3E0RWhBbHl4MVVoWWNyQVR6NWdhVkdiRG91VW1jMDNMVjUv?=
 =?utf-8?B?RXhFSWVFdFAvU1AvTnZxb0lSSHhlVjRhWEV6WHZKc2tiaHE4ZWRIS0prNElu?=
 =?utf-8?B?cW9GWEJ4dkYxN2dmNjBacFFMRllTUjFaQitKQlByVGE2U1duTWlCREZreXpu?=
 =?utf-8?B?Y21YNi81NUx0Qk5kOHI0VC9lVUE2VFM2WFJJM1J4OVR2b2tTa2NibUcvU3FH?=
 =?utf-8?B?TlNSMGpRcVRwaTBGR2hIQ0l5dmpMN0dZS2RmaTh1UnViMXJ2WHhRNzM2dlU1?=
 =?utf-8?B?YVlGR2NKaGc1bTZHVXZNS1JDMEU1a09Wa01GNG0raFpQaVZrVkhiSWVQSmZ0?=
 =?utf-8?B?RzVSZnR0Wi9DaHFudHdnSzlMd0ZCVU1sbWN2cHA5dldqOWRNMGtHUXhRT0dZ?=
 =?utf-8?B?NWdiejRqUFVlbzgvb1JsSlNXcGVRNnBHSWRzZ0QvY1FHdlNHeFl1ZDl1U3R2?=
 =?utf-8?B?eTN1RWVER21HNXYwcmI3OEJHTE5DRzBITVJRVlBiMlU2OG1aQjFkSkRHalY4?=
 =?utf-8?B?cm5iUHljM2JnQk1VVGM3QzBuZ2Y1ajZmY0UwQ2tXWFgyTjJxd2NZMmZ6em1p?=
 =?utf-8?B?K0dydll6VW5qRVNUeEt1cW5zd0Z2eUQ0YXdnOSs0MDRxK3B3U2UvelFKOUZP?=
 =?utf-8?B?b2ppYStZVDRUazdka21Yd2lHN2JzOXphM1VQclJXR1pGOTRRUnA2a1JCWVVI?=
 =?utf-8?B?SHZiT0ZyUHdPaE0yK2ltOG13OFpCS3E5Y1U1UjV0aDBsUDVwTjJ5OGdrcGJQ?=
 =?utf-8?B?eGZpMUZOM0hhSFB6eUJaZm16VjlxZmc3bzd4S01lTEthaFlNcGgzbzBYSFFn?=
 =?utf-8?B?VVozcnlMa2V3cTNGT0xsZnAydzVUeVBQNTBmbFBodkEyY0dtc1FydzV1b040?=
 =?utf-8?B?Z04xMXdHSVlzY3VEdzh2R2NwYlhPT1VoemFUOTZjTWxDWSs5RERMRkx4M2R0?=
 =?utf-8?B?Szg3eS9kTGxBQ0tNUHZ3bGJJcVJqcXVpa1NrMUlSY2twM3A4VC9FeXRGUFBQ?=
 =?utf-8?B?Q2xzUzNqWldCS1hyaXFGTXJZSkpSOEZJTFhKS1dva3g0Qy9iS1BnajVWZ01O?=
 =?utf-8?B?WGp3c2RZSkcxbWdmMDN0Smk4RStHK2I4d2c2YjVLRFI2aEFQalFZUEFCdGZk?=
 =?utf-8?B?R25lRURQSkxNSm9jR3BRcEpnMitEQThjckhqSG9nUzVDK3dRMlQxbUxUV3ZF?=
 =?utf-8?B?YWpXMzhIOEdIanBLQTJIeGI2dy9Hb1ZYOUNTa1l4UTBVS0dsYUEwV2trWXU3?=
 =?utf-8?Q?8hf7FW5E9bqYZBY0juknem4si?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453fc298-a252-4525-c4e7-08dcb5bbbe6f
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 02:01:53.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCSQKth65x+xqv7Q1+MC8JMFUcykUBiYeThggmikRllBFNM5DwjWB4kQrJ1cPhguzYyQOSRYtEmGK4N/1lWF5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5753



在 2024/8/6 6:09, Barry Song 写道:
> On Tue, Aug 6, 2024 at 4:08 AM Zhiguo Jiang <justinjiang@vivo.com> wrote:
>> Support mTHP's attempt to free swap entries as a whole, which can avoid
>> frequent swap_info locking for every individual entry in
>> swapcache_free_entries(). When the swap_map count values corresponding
>> to all contiguous entries are all zero excluding SWAP_HAS_CACHE, the
>> entries will be freed directly by skippping percpu swp_slots caches.
>>
> No, this isn't quite good. Please review the work done by Chris and Kairui[1];
> they have handled it better. On a different note, I have a patch that can
> handle zap_pte_range() for swap entries in batches[2][3].
I'm glad to see your optimized submission about batch freeing swap 
entries for
zap_pte_range(), sorry, I didn't see it before. My this patch can be 
ignored.

Thanks
Zhiguo

>
> [1] https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-5-cb9c148b9297@kernel.org/
> [2] https://lore.kernel.org/linux-mm/20240803091118.84274-1-21cnbao@gmail.com/
> [3] https://lore.kernel.org/linux-mm/CAGsJ_4wPnQqKOHx6iQcwO8bQzoBXKr2qY2AgSxMwTQCj3-8YWw@mail.gmail.com/
>
>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>> ---
>>   mm/swapfile.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index ea023fc25d08..829fb4cfb6ec
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1493,6 +1493,58 @@ static void swap_entry_range_free(struct swap_info_struct *p, swp_entry_t entry,
>>          swap_range_free(p, offset, nr_pages);
>>   }
>>
>> +/*
>> + * Free the contiguous swap entries as a whole, caller have to
>> + * ensure all entries belong to the same folio.
>> + */
>> +static void swap_entry_range_check_and_free(struct swap_info_struct *p,
>> +                                 swp_entry_t entry, int nr, bool *any_only_cache)
>> +{
>> +       const unsigned long start_offset = swp_offset(entry);
>> +       const unsigned long end_offset = start_offset + nr;
>> +       unsigned long offset;
>> +       DECLARE_BITMAP(to_free, SWAPFILE_CLUSTER) = { 0 };
>> +       struct swap_cluster_info *ci;
>> +       int i = 0, nr_setbits = 0;
>> +       unsigned char count;
>> +
>> +       /*
>> +        * Free and check swap_map count values corresponding to all contiguous
>> +        * entries in the whole folio range.
>> +        */
>> +       WARN_ON_ONCE(nr > SWAPFILE_CLUSTER);
>> +       ci = lock_cluster_or_swap_info(p, start_offset);
>> +       for (offset = start_offset; offset < end_offset; offset++, i++) {
>> +               if (data_race(p->swap_map[offset])) {
>> +                       count = __swap_entry_free_locked(p, offset, 1);
>> +                       if (!count) {
>> +                               bitmap_set(to_free, i, 1);
>> +                               nr_setbits++;
>> +                       } else if (count == SWAP_HAS_CACHE) {
>> +                               *any_only_cache = true;
>> +                       }
>> +               } else {
>> +                       WARN_ON_ONCE(1);
>> +               }
>> +       }
>> +       unlock_cluster_or_swap_info(p, ci);
>> +
>> +       /*
>> +        * If the swap_map count values corresponding to all contiguous entries are
>> +        * all zero excluding SWAP_HAS_CACHE, the entries will be freed directly by
>> +        * skippping percpu swp_slots caches, which can avoid frequent swap_info
>> +        * locking for every individual entry.
>> +        */
>> +       if (nr > 1 && nr_setbits == nr) {
>> +               spin_lock(&p->lock);
>> +               swap_entry_range_free(p, entry, nr);
>> +               spin_unlock(&p->lock);
>> +       } else {
>> +               for_each_set_bit(i, to_free, SWAPFILE_CLUSTER)
>> +                       free_swap_slot(swp_entry(p->type, start_offset + i));
>> +       }
>> +}
>> +
>>   static void cluster_swap_free_nr(struct swap_info_struct *sis,
>>                  unsigned long offset, int nr_pages,
>>                  unsigned char usage)
>> @@ -1808,6 +1860,14 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
>>          if (WARN_ON(end_offset > si->max))
>>                  goto out;
>>
>> +       /*
>> +        * Try to free all contiguous entries about mTHP as a whole.
>> +        */
>> +       if (IS_ENABLED(CONFIG_THP_SWAP) && nr > 1) {
>> +               swap_entry_range_check_and_free(si, entry, nr, &any_only_cache);
>> +               goto free_cache;
>> +       }
>> +
>>          /*
>>           * First free all entries in the range.
>>           */
>> @@ -1821,6 +1881,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
>>                  }
>>          }
>>
>> +free_cache:
>>          /*
>>           * Short-circuit the below loop if none of the entries had their
>>           * reference drop to zero.
>> --
>> 2.39.0
>>


