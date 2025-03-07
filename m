Return-Path: <linux-kernel+bounces-550416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ED4A55F3E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72893B2CF7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FAA18DB3A;
	Fri,  7 Mar 2025 04:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KIIBU3hn"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F709DF49
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 04:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741320765; cv=fail; b=p7ywIACKkvHb8/DsUezAHgu/7Hms0jBNpUsMRsPDzPX4kq4nfUJaucF18kHTs48HyWocxYvwBvgp5v/Qgz4voJyGXKHcczJrwNJUDbkZMCsfNhkGGSYg3oeLgJVnG6NZJkWFlTIeWi5YXotZX8TSZG69TXGMIZWfBbX3BU5pK80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741320765; c=relaxed/simple;
	bh=GR3gigq3+T8t1ZcY6V6+LRXrfMUl0LuNAUPqVL7jdqs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r5HMaXYXGv8jfmm9Ehd626fktnX3R5NQAB1YTbyCV/InGBkTfQR/1AyPmZBJ5u26J4BU1550tLO0YkBUXY9Lh89xqOjvtF6n1KlyMfx6gaZ60ox95krF/FpfHG4WBls9wrwxlTrxQvBGDQXtxR7zIWbY0JJE4w4WCF8yOFhliTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KIIBU3hn; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6++DMdGGd0UVXs9tMizBKIRM6fjErq1OggtYWXegR7yOvOkxPsMGhM/jDWTGau1E8nuJQZRPcg7nXhUV/qn9YTjCwGoMJgPGCtewQpbkb7OlyN0nH7yfpq8url0dtYivQJ0NCcG6gZYDI86SFQC1IqdjBiabIEOO5u1Uu20kp3nV1cg9Ppo/48W/DiTa+ZyZOLeAGxLJhLLlJa+PKfGcBHBk7DlR8mDhcj7d5utAmLxk5OU3g7g0OtMpTu09YkWC2WXJsVznhU8cBv/AK0R1CxXjUyD5qTpAXNHNLLph5fkkwti3/clVcTKc1n9o5KcHZj14gVrRjEFuy29Na1jUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR3gigq3+T8t1ZcY6V6+LRXrfMUl0LuNAUPqVL7jdqs=;
 b=XgzxiMrj35+PXXvL9KOiRna8Rnd5VzHeyAxmdtIVaXDmq2oHBdB5VD4n4aKLPl5xadtVJKieII4vi2znNyzrvzYZt78cmSQsaeN0wN/w/RgU/M1ihS9Ruh81ebOQ0T91INu/IWVcYikH923nOU05P1gH9VqmDYm689fa1TCUXUSRLXF587D0mIBdL0RPXSSgcj/K0ormpd68FjBQ3iH8HK1g4oXhONN9+iuXjHoWs/jrdFzsNOpXOSlz+kzXlGaK/RZ6sYxlbTBv0mCnJeWRMn/GET8YIli484jm3BmqXb1/KDdORCfH/njFfqf0mM3sJRFHsT2mho7/8ph9gKtK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR3gigq3+T8t1ZcY6V6+LRXrfMUl0LuNAUPqVL7jdqs=;
 b=KIIBU3hnb+iKyzNo6CEfa2MjoaMGDno9kgfMpHspHPT4Evn45/Q1PYsLx9K5k1z7aiwH2ZEm35sqcsTdZsEd8ur+vhX5wTq55mN/+1LA60XVUJz+zeTf7F9++YVCrBtc9knvVxFoXSqT6mcuLP93EZ/mrjaTRduiUq8Py+hzYhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 04:12:39 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 04:12:38 +0000
Message-ID: <8da2463e-775d-4b37-b47a-5d55feee6fe2@amd.com>
Date: Fri, 7 Mar 2025 09:42:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ktest: Fix Test Failures Due to Missing LOG_FILE
 Directories
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ayush Jain <Ayush.jain3@amd.com>, warthog9@eaglescrag.net,
 linux-kernel@vger.kernel.org, srikanth.aithal@amd.com, kalpana.shetty@amd.com
References: <20250305041913.1720599-1-Ayush.jain3@amd.com>
 <20250305190159.7c590242@gandalf.local.home>
 <faadd6ad-3b85-4ad3-8d17-acb5e0991a18@amd.com>
 <7bda5c5c-3f2e-496c-b5a0-6f7d9120dacb@amd.com>
 <20250306101203.3a131a57@gandalf.local.home>
Content-Language: en-US
From: "Jain, Ayush" <ayushjai@amd.com>
In-Reply-To: <20250306101203.3a131a57@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::11) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: d34a0dd1-e4c4-44bf-23e1-08dd5d2e4be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm1JQnptNnA1c2ZJZld5MHJHeWRQWnNuNGZCajVWZHg4UGxCWGFRUTBodCtl?=
 =?utf-8?B?VmdaTUVtK0VUNlpTd1p5SitFL3ZXTmpOWlZBZVBqZU9kWWdxRTRYNVZoRXIr?=
 =?utf-8?B?Njh1VzQzbGlXYkx3R2RsWm9IclRUSHpBOG4zL3VhNHZoVmRXeFFGQUVHMHUy?=
 =?utf-8?B?WUZzZmprMTFVdjFUekF1eHVxUEZvY0pHUFF4MUlFejd3aFlNQktYZkRyRGJ0?=
 =?utf-8?B?dlRrQWExWlc0NlVmdlQxUkhndFpFYzN3Q1djV0NlS0oyL3Rna1dNWnU5ckh5?=
 =?utf-8?B?THc5QWVERmxvd1d4ZTU2Z1ZFVCtOUkZhQjJodGpjYUdLandqdUs0UG5xdnFr?=
 =?utf-8?B?RCt1M3prREpoQjlZY0Jqb0RwdVhIaHpYNTY0Z0VNMGwweHpvRFRsQjd2Z2k5?=
 =?utf-8?B?S2FXZDRuRmt0a0h2RER0NGRnSUZ0ZUFubEQxaGVoZGFhYjRXV1NaTmNOUlV0?=
 =?utf-8?B?dWc3QzZucVRBOHpiYjdHSGd0RkE1eFNtWHpPdHpUWlBoRHgwVEZzdjhobkZQ?=
 =?utf-8?B?VWVZTkpzR3hLTlNaYUlIMTZ6aVJ6ZmUwRVRnMjNCSHh5SWRiT1luM2tCelZy?=
 =?utf-8?B?U2tTSVlMaDRZbmxqWGFLZ3FKTmw3ZzVvODZBVE1LcFlhSmJXWGtOT0pLM2Vy?=
 =?utf-8?B?ZlVrU2RzMGpHQjlGWGNnMzBRUWhYaDlMUDRCb1dGcWhMVWhIUGtQQmFXMkNu?=
 =?utf-8?B?ZWJrbWJZQTdzVk5LV0dxYjBQd1pmc1hpNmdEZHB1OTlaOE5vOGdhVk4vTW9M?=
 =?utf-8?B?b296c0NJZW9IREpZRmROZmFmcU1qUHY4cnZyUUNuVUduSzFVaTBtbzExTTYw?=
 =?utf-8?B?ZzZUcUxrMmlJTVJWdXh3cXhuMElQK0d0cDJUTDdQckZsQzJtQlJySDg4cHc0?=
 =?utf-8?B?ZmY4NEhJVjhTUVdNVWQ0enpGaW9pUHZydkU5YkFqMUQ0MitrSUs2UnF2Y28v?=
 =?utf-8?B?NU1zVkMxYlR5akZFOGFRVm55ZFVGOXZMM2ZXMW9IVTh2b25RWU1oVTREODBz?=
 =?utf-8?B?Z09ISVJRUlc1Q3hWVEhQLzdRbWlTVDJlU08rZEh6V0xWUlh6bVplSVdTKy9B?=
 =?utf-8?B?STJ2bnRVaG5yeHBsQ0ZHdmZJWE4rSnh4SFdGSThjOHVvaHZsb2hmYUNFbm1T?=
 =?utf-8?B?UjJkdU1nQjV3WnVWNjdLZXRZRzlPZUt4SGxOUGRKaHcrVEVVOFRFRGVadXhT?=
 =?utf-8?B?L1JlVk9KdkJDNlBxK2xRZDlSY0RvWFY0UjhBUFA3b2lkY0JObGtkbDZUUng0?=
 =?utf-8?B?eWNlQXdZZzRKVlY3M1NTYXBFMkV3UXJoVmtFTDc4SmlsVmtPVFNUQXFGQXo3?=
 =?utf-8?B?V3g5Y3BybklJb05zQVh4SUJ6MUxwRnFzOXAwN2pVVlpLN25ZQnliZk4rTmND?=
 =?utf-8?B?M0Vkd0pyVWdIcTZpTTZ1ajFidTdTUWlrcjBoaTJGaE9KMnRFSmJDcm56cGIw?=
 =?utf-8?B?c29vQnNZMDg0RDg2V3BEMStONXovcFZ2U3BoUkU5NmwyckJqZFltYVRGYkZu?=
 =?utf-8?B?alp2ZmYvVlZvQ1J5UFJxQTl4Zi9QaWZ3ZWlBdUVsaG1rdlFtVE9uM01JWWZr?=
 =?utf-8?B?aVJsdEl4MGZHVUZjc3ZsbHhDeEhhSEwrRDg3QzNDK01SYWdsR1VIUUN4dGZ1?=
 =?utf-8?B?eTgzTXg3L3hlRDdaanhvNVRlREhWSXhuc3AvNjNwTTJUME82cVAwTUk4eWlN?=
 =?utf-8?B?Q3hjZ2kvTUYyWjZyTkJMNVpMa1krRGlmT0JoVzJoa1o0d1BkYWc3UmpRdU5F?=
 =?utf-8?B?UmtwcCtpd2ZINU5CRlBUdWt2WWJqaklGTTlhbGN0ZVF6MjhRazVnTC8rd3Jm?=
 =?utf-8?B?OEgvRmp4YUk3Q21LNFJLbjJYWldMQVpwNE1mdENYZjMwck9VSHNhNlVqYXFU?=
 =?utf-8?Q?YImGu7fxbI4/L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXNVQlZVTHZrdXFNZk1YeGFERktJRG9mUUZESjRzbVhqNjhiUnhqeE5Zams0?=
 =?utf-8?B?dkZpelpMZE14b3ZqR29GSnNIcnNXR2x6bTNmT0dmMUhEYTNxTWlBeU9wQ05s?=
 =?utf-8?B?TndYU3hXWUhIZ2NjUzlweUF0dzhwYXFXTEQ1YUUrUzlNYVozaE5DSEo2UEE3?=
 =?utf-8?B?U0p4WGgzTXlzOUg1NUN1V0xhK2F6Qk5mVDhJYThUdk5XS1VZaWliRVEwOXJn?=
 =?utf-8?B?Wlo0VHpiUXVvSFpFSWFheU5paWdhK1E2WUVQQzA3QmVORkFsbFZqdXIwelBK?=
 =?utf-8?B?ZWc3bndpaVpGWlhmU2F6WHZrZWpETS9XUDVWcHpvck9EREdTN0xBZ3NnUndl?=
 =?utf-8?B?dlJsaWJTYU1NbWc5NWNCRUpnL216ZWVtU2hURU1XSkdmbmFVdTVyN3RjdzFa?=
 =?utf-8?B?K3UrWEtYOHdwelNaUTlKUHRLYzN4dUw1clhCdzh2UkZrc0x4M093aUIzaTA4?=
 =?utf-8?B?SC9HZkI1SW02Z0ZSUU1hM0tSc0NMOWZPRmVyMCtBWGI3MWdzK3YvQjRyOVJw?=
 =?utf-8?B?NE1zSU52WmhWK0hReWRKN3FVdEplRjZPSnQ1dTQwYldwSDhrRXFrZzZKY0tI?=
 =?utf-8?B?NUtQNmUwS1FPemYrQmJGMVZkanJ2UVAySU8xbG9vaGtZKy9EVGhUWDhGdEhN?=
 =?utf-8?B?Z0FWcmZXbnkydTAwM0gweWlLc056Z2FiWUlMd3MyeEttdkh4YXJXRTNEaXNi?=
 =?utf-8?B?VlhVOGNLbTVzK1JaRXlsS0ttMVY0L1FJR0VKdE5pdkh4S0NvTzNSRlhlbzF0?=
 =?utf-8?B?L3RucjNQU3B2VnpWUTZ6NkNGMHMxcTdvMDgyOHdlOC9rcUs0bWQwSEh3ckhC?=
 =?utf-8?B?Q1MyYTZ3QVEwWEFxSU1QMFNXcU81b3ViNElhWXdUM28wT1QzWFlhVngwOVNB?=
 =?utf-8?B?eG1ndnNlQjluTmIzcVpqVFk5QWRLeWNSeEN5Zy9wWDNHaEp0V1ZVZmVWOWJK?=
 =?utf-8?B?bC9yTlVOMzZnNkx4Y1V2TnRsanpKcTdpUjBUUjQvdzFiQVJjeEVobHdsMW5C?=
 =?utf-8?B?c3NGWVBuVmt5ZmJsMlRBWk9QWkk1NVVHWk5OVDZQM3lYR1JNajhYS3JMTXVB?=
 =?utf-8?B?TUQrckFyOVZnemUwZFp4SHFUMDJMSk5WL3VWS2ZLaHU4SHZQVnZUSEhwMm85?=
 =?utf-8?B?V3FQYWxPdzBTUU8wT3FpVWEzajFHYjFLSFpHUVRrdXNlY2cwejQybzZEcXg5?=
 =?utf-8?B?Vm1MU2x2dGlxc1FlM1o2eGo4bHFqQXQxT0MvdHlTUC9IemovbWd2QlpGZllm?=
 =?utf-8?B?Uk5laUlEdG9VYlc1Rlg2RThpRFlCOG51amVtL0l5bmhiR2oyTG1YWFJoMlpy?=
 =?utf-8?B?UWE3bUdGV08zMEtMbEpYR2VWUFVvZ29TRUF6aU5MRllWS3dQMUFmNnZvd2Nv?=
 =?utf-8?B?WkpwSmN6aVI1dk1XZTUrbUREWm8wNkxyckU1RU4vb3RnbVYxMi9YNW16OHJk?=
 =?utf-8?B?ZnVXelhXektqQXMzLzlpK08zV3NjR0p2QTdBK1QvTFc4ZVJqUnRFMVVzMVBU?=
 =?utf-8?B?dEROV2dHaVJZN255eDhET3hQN0N4eGg5UTNoL2srTkkxdTM2K2NsQlU5RFZo?=
 =?utf-8?B?d1hKaE1TZFBXNC82b2dKVmRDZWlXbjA1OWthQ0hLVElZR3RXK2NLeVE3Tzgw?=
 =?utf-8?B?c01pcjU2U2x1Y2ZBc3VPQUQxYW0rYldacDNOd04zTDJReTdlMXE2aEpTV3pV?=
 =?utf-8?B?M1dVVE5Menhkd0IybEhYaVp6dlNUZXhTRFg4TC9lSTZ3NkhiOFdrVlRBUUZw?=
 =?utf-8?B?dU95b1NrSFRSc1pRTVBkZmtoU0JNcnBvVzdQRjRLNE00WnV5N1FKV1JqUVR5?=
 =?utf-8?B?eFhqcnF4TDdLR0U0a3paRnFhU1hSMU1zampGa0QxMEtza2VOMVh5NzBreitN?=
 =?utf-8?B?UEFYZHJhZnFZdzF2TGpITWdyc2Nzb09SZnhlNk1Kdm85bmdZSXJObmhlRmZr?=
 =?utf-8?B?T0tpVGNwZWhHWG9GeGVtU0tYWWZVb1JSSC92ZVV1Z2grbWpVU3puZndTYTJz?=
 =?utf-8?B?Y3R6ckRWM2ZFSU5NekxSYzhYdis3Ym82T2ltSVBFY2oxRExESnJNeXBtdjlN?=
 =?utf-8?B?TzluTFVRM1VGN3BTMm5CNEczMU9oUUxwUGpQREtNYzRNNDhkYWUyTWFFT05V?=
 =?utf-8?Q?MktS/x7z1eZpTg+SmJOgk0K4C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34a0dd1-e4c4-44bf-23e1-08dd5d2e4be6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 04:12:38.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LxaCHsm8KEgENYVCLKfPvRheDN0aVnnOgt1zK0WU3honbZWZB46syGzHN1hr0CGha8SheewU6k52r85VKjKUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103



On 3/6/2025 8:42 PM, Steven Rostedt wrote:
> On Thu, 6 Mar 2025 10:19:04 +0530
> "Jain, Ayush" <ayushjai@amd.com> wrote:
>
>> Just to be clear on my end, you mean 4 space wide tab for indentation here.
> Correct. That's what the rest of the file has.
>
>
> ....[indent 1]
> \t[indent 2]
> \t....[indent 3]
>
> Where . is a space and \t is a tab.
>
> So for every 8 spaces, use a tab, and then add 4 spaces at the end of those
> not divisible by 8.
>
> -- Steve

Ok, thank you for explaining, will update in next the version.

Thanks,
Ayush


