Return-Path: <linux-kernel+bounces-245158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D351092AF16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AC51C20CB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC747D06B;
	Tue,  9 Jul 2024 04:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jjhf1cDK"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968132BAE1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 04:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720499462; cv=fail; b=hRzBMF6F96V/jaIsLW8SxrlL5NNlSB0Ybjn2ckto/uyQe9s3k6daD7kaa4jIze46hfXsJy6sqQhtDf+xcX6CADNZC7eUIs8yD6G/Je8BV5+ylE58ZtjOn2GsLVktZ0Hg9JJtXZnkpq4TV+uc2hqf+i20J66QBFwot68eePLu5ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720499462; c=relaxed/simple;
	bh=Yx+ilqjp7ZsD4kB7OeosSQVRLrlTD/gY1g2lG4OqHfA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H5vOa+S6ODlSLrR5T0JfaFHapxs3E9kpZIovsbpET9Dud1yoR7oVpqDARWzW/mMjYhek+wBxZx+Hz9QVY1fw7nlZY9GGIxeMV3YmkkX4epG6l0a/BzTv2nk/DaX6VGAJIZ6tS8CZIfkeRQj2GTQ5bRw3xKualJjeCtzstjR4Nas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jjhf1cDK; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY+n5wfpLFbcWK/1A2Fkt5Yv4sggcArct92Y3qdaS7HIouEZC78O4a8JX5z1+oIcl9sv5TXdvsBa7RqKQ0SpYJPKQh1C4uH8QWej4D89/iDc51g8DM14Q3NTRbO/eVV+12UpaIiU+BkYwsAyhaPyda2SneN32fEZtWnK5gALJCwtl+Hcoj8GlPCMGUjJc675NC28JcZYlnjPnHeAXnKfSF+BtQsHryIerbwRQhGEvtggXS3jsrEZYM5zifirnmPNJ4LruMvg2kI49eEeNlAkKhQD+8ePGG+w2GdTSiIurS7RU7P4iKgUkxrtiAJ2nLOPUdd7DulY0XBBVViedd3raA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTkUJ/WuoH/a2vcasdDTDKwC4bPpOnYG2d7MESx9Ubk=;
 b=aNtvQ+Loz7NnuRAu20x2eRW3WfVLa+tb9hj9/e0e82plzaVb617X/hnuSp/mxLppFw6F7g++rVB++dp6eMthiyAWbf4F9A7AEF8iquepBXgWs7QJBkVWWF5GWQecAxk+fmukFoSISQYEg7cFOq6RZqy/sf4sUGmffIl6/2fWbwMAj976DwaSrj4YNonyCN2V8e5GXMeKeziawlPDrRqr4BhugWeVU0MqAGNpV2GWx5gj2G1cb+99SRTPHAMbXAizr5Mqp6YZl23llJ0VgRKxOlCV1ojbo51L1ED8eEztjdNa/0bZSWzjY0Yeyj22pM8ZDo1bSKbrgwUfxwW4pIi7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTkUJ/WuoH/a2vcasdDTDKwC4bPpOnYG2d7MESx9Ubk=;
 b=Jjhf1cDKu4CUxverNzzKiiIVw//fkypdlJQ+qETkemFXF9758xMXL9KpKdulFfo11BeML8ocKtvLfbVJtfRzijlBzuzPM0VoDbx51a1jaaoEp3rN3uka4GNs5+7NyqdYTzHpzYqxbMjFRrE6J4tMtnQlob+vS2Uw3l8bn1auuyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 04:30:55 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 04:30:55 +0000
Message-ID: <7a06a14e-44d5-450a-bd56-1c348c2951b6@amd.com>
Date: Tue, 9 Jul 2024 10:00:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com,
 "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz,
 kinseyho@google.com, Mel Gorman <mgorman@suse.de>
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
 <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <1998d479-eb1a-4bc8-a11e-59f8dd71aadb@amd.com>
 <CAOUHufYA-ZAHni1_aDQjjwB5UC9EFYPL_YqVN52DoL3J7SFziQ@mail.gmail.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <CAOUHufYA-ZAHni1_aDQjjwB5UC9EFYPL_YqVN52DoL3J7SFziQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::10) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbff826-2cc4-4e10-5de0-08dc9fcfec0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnlvSUFIWlpLcUVLQmxUb2VpdTVLWEtrQ2NUL04yWUZoNHVLQ3pPTEJkaGZ3?=
 =?utf-8?B?ajhyU3RwWFUraDdTMGRpbVRWdU9GUnJKNkVvSWp6STlma2NOcVdqS2dpMkhr?=
 =?utf-8?B?VjgvOFBMNkc1WXd2UHVybXlscG5LN0NOeWFzQ29GRkd6ZTlPbEpkR0tuMk5T?=
 =?utf-8?B?aHBKdXgxQ1BZTUNpVFhQRjNtSkR4a0dRdWhwUnBobnpyc21KY0svT1ZTb1RN?=
 =?utf-8?B?Vk5lR0U1ckhyWG91Z3dIMzhKekhtdmdKRnc1YWVvTmhtSEVNVUczMnJVend3?=
 =?utf-8?B?T2pJRUxvRWxSMldiN1Z6MWFSekp2SU1TbW1lR2txNk9SanVaQXZqYzFMc2Ji?=
 =?utf-8?B?MGlDTk1CMFVrNkxhN3dHZXBHN2tZYWVGSC9IcHpDL0lIZENjbGRkNTVOaTV1?=
 =?utf-8?B?OHFTdS81cVlxdGlEM2YvUll2aWhJTklvVVRlQTcvMXp4ZG1QZkdoS3RzL1VR?=
 =?utf-8?B?NE00bjhoNGc3R0NtNlVwc050enpsTkxCaG5xb0lQZHBTTU9Bb2RqMUtGM213?=
 =?utf-8?B?amJON0lLc3UyTDNvNmRkQWZqNndnL3lzWkVaMDl1NEFVK0hNaFlSQjA1MFJZ?=
 =?utf-8?B?RHNBQzIvZTFScEFnZWVZdHJVS0I1c2xSQVhUNTBBQ0xMY2hTYmFIL3R3Y3ls?=
 =?utf-8?B?NFVXMmM5SVpGZnU4djVCN3lJQjIycGYvS1REdEZHUzNHbkdwY2txOTAzU0kw?=
 =?utf-8?B?Y3VjNk5XY2c2eVJNTGs4SEVXbkV0aERaS0QzYU1BcllUSDlPaUtyRWdMYjV6?=
 =?utf-8?B?bHVyQ2N3dUdzMnY4ejVEZDNFWGpOTWNaOFlLVERWcytGWFVKMkJPUDczTEJP?=
 =?utf-8?B?RzhmTDZrZ3JsUWZtRTVuSWR0NExHVmdrMmRHNjQ4SVZORno5V1lTQktWazlC?=
 =?utf-8?B?QlJBd2d3bWJ6ZW15YkdrQUc5SnhkWm93SWl0eHZrbFNHZUIxTnZ3ZHV0Y0E1?=
 =?utf-8?B?VW1WLzNnZmJQaEtDaFBnVm4zOXdYUitHUW5UWk9RMFFqdENJL2RlbDQyejVU?=
 =?utf-8?B?SjNMN3FnYmd4M2pmdHdwa0FKeGJDbldzOFI3Z2RXVmJDUEU3N1dudDNyQTJ5?=
 =?utf-8?B?U25TakVPRmFhNU5ndVFvMmZJbE92Y2JDbkZZeGVkTzdrTk9BbUdsUFFkeG85?=
 =?utf-8?B?WWp1YUJmTm56NStZS05HZkM2TGZiVUJ0VFBtdTd0djhaMlcvRXd6eTlCaGhZ?=
 =?utf-8?B?Qm1Ga3BYdVQ1V1VqcGRVdXBDczFWUE9VYThQblFJeEJTRjV1eVJMQncyQW0x?=
 =?utf-8?B?WU5yZU4yOERzb3o2K3J2WDF3cklLOGx1Q01KQnoxS09kSWJsR1FhQ2VGcVQw?=
 =?utf-8?B?ckYzMit1cU52REdqMy9qSUJHQ3RjU25KMXdjbFd4ai9GSTJLSktoK2RHa3Rr?=
 =?utf-8?B?NDBkMW1rcEc0SEU1UmlicWFVSTJZMkVaQTZKWHFyZVNsbGgycGVwaUI3MUov?=
 =?utf-8?B?SHNtTkRUV0lUdzR5bXZQaFdON0daSlpOZ09CWk9RK1RGandNcHNYK2loazlK?=
 =?utf-8?B?RlhyUTNuUUdxVUpiVElLWFhDTHNMai9nYVdUQWE1TVFUZ2hFTGVRS0swOGt1?=
 =?utf-8?B?MnRvNE1ES1ZsdW8wRDZLMW93N1N0UnpPUHcwRkxzL3E1a1VyYWE4ZHc0R1Vv?=
 =?utf-8?B?REc0YlcxcTR4WktuTDJGd1RIN1g1VWV2TS8wK3VPa0tGTHVwWWgwSEs4N2Y1?=
 =?utf-8?B?MkpRMElaTk10QlUrc1Y1Zm9UVExvTnZITzlGejJBbmFvQkFQOGQxQTU0Mk1j?=
 =?utf-8?B?N2Q1Rm5jQ0dvRG5PVnF5M3A0VG9ZM2RUdlhEa3dNdTg1Q2dnTWlld09HM0ZT?=
 =?utf-8?B?MjBvVWp2YU84RTUrSGwwZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y05QaEY2ODc3cStDVm1HZHU1YTRLTE4wU0NaaGlPdDZUL3krUjZZaW1Kc1Ni?=
 =?utf-8?B?Y29CZitkTDZ4VXFiQXBIZ3VBbjRyRDhsTzYxWjdkck1UV3ZURkZaS1E5S2E0?=
 =?utf-8?B?bGFYYjQ1MkZOU3BCbEEwdE9QQi95MUhaUXkxNHFKWEFzbzdWNC9aYnhhSnRI?=
 =?utf-8?B?SVloaG5OU0JFaVlhc2VjVWJoN2wzaW40eHlXOHk3NnRyb2FIOTBBMkZtYnNP?=
 =?utf-8?B?a2U2cjhmd2pBbmcvYW1IdFNtd1JOVU1yTkNMRkQyL1pNdFMwRlh4OThwcFBu?=
 =?utf-8?B?d2FFa3RDRDhiMjRXeXlDT1R3SU1BdnNPa0FQYy85MFBHQnRERW5uTlQvenUy?=
 =?utf-8?B?Vk1KaWc1cW1XbDJMNEJ4ZHVwbUpVNlQyUlg2WDFmcitYSTJiaFp2Q1FOM2tw?=
 =?utf-8?B?N3FvVHVRWW4wOThBWWFGY1oxNklQaGU5a2UycXZxM0hpNTU5dXRaU1M4eEJw?=
 =?utf-8?B?VFJmZkUzWWkvT1lGNXhrWTVNbnFiMkxEcVNRWWZNWk0wUjhDaDgrVmxOQjlL?=
 =?utf-8?B?Nk4rbUNqd2JzSXR3aTFUZmd3TUxYL2lqaDByRVNGQkpNQjhZaFNibmhiOWZF?=
 =?utf-8?B?RjJLYk0zOUVick42T05RcGpVVUlsK1RLaEdjR28zRGkwclhzWkJ0ZVl3SzJP?=
 =?utf-8?B?dmNWYUdpaU5QQXE0Qm9KQ25hNm41dS9vRDI2OEJWblhIaWZaSXcvdkk0eVc5?=
 =?utf-8?B?SlNINkxEWmdQdGx0UjQvR2tPdXRHVFU2RUNRZnBwdmFPMDc1ZlZ6dy9LMUpE?=
 =?utf-8?B?dzlLQ3BaY1RDQWJsOFVPbTg1T0liMmIzWTI5bVBhR0ZzRThuZTYzL3ltREc2?=
 =?utf-8?B?dVllMy83bkI1YlJsKzd6MXRDd1hBL2NaZUNPdG02YkdKdWZRSTBxb1gzMzd3?=
 =?utf-8?B?YUhKcWZJcEZ2T3ZON1NHSGJtcDZsZmpjdG1sUlRjNDR4Y05kOGExYW5DY2xL?=
 =?utf-8?B?S0R0dUFuOUhpTUliQk1UOFNBdGlEU1hXVk1DRWppaHBSNzFJdHZ4cm1DTlBj?=
 =?utf-8?B?TFVmZFN2NytNR2lwallpaDFJYWlYVEQ0QjI3ZTNiTVlqanZ1Wk9LUVhKWnhQ?=
 =?utf-8?B?NyszUVFJelVxRTdheU1FdnFGL0dBRHV5S0VmTWRnenM5bFdob1B3anhTRWQx?=
 =?utf-8?B?NU5pamt5Znk0TVlaazNtMWVVMHBtemhONE5IRGQzK2dPOFFFcWtua3czM0t0?=
 =?utf-8?B?cXRDZ0MycTR6TTlvaTdBa3ZVS1I3eFA5ekdjWnJhN2trSE5EVDFDeUtyM1hr?=
 =?utf-8?B?ZmVINXREMTM1VWsxZURqQWFySm4zZTdyZ2ZYK25YZUtQMEUwemliS0RBZUsy?=
 =?utf-8?B?T0pTS1hySEplOWpoQlM2bHRSeC9NRUdWYkFza0dSZUF1RFRqM2RKRGhWblVl?=
 =?utf-8?B?TEF6bWtJSm1XN25SdHN5VUp4WHdUTTlZZDA3dmpBL01tRjY2V0d5ZHNqUitG?=
 =?utf-8?B?ek0yb0RGNTBaNGwvU09YRGlxWEwxNFpYcVlVQ2xFcEs0RktkZHk4SDY1TjFx?=
 =?utf-8?B?NWUvTGdJaEtuTFBmeUt3WnNaSEpSMndOVThDZzlVY1owMXpjUEZhZHk1cHF2?=
 =?utf-8?B?Tm43NHFyb3NmT1BnV3RFTUhOSjUxLzE4QVF1azQ5SmdidFpPcmJLRjM3Wmdz?=
 =?utf-8?B?LzdTZG1sbkx6WWFLc0JqQ2VIR2lZWVFEcnVlalMrQnBFcGVtRDZIZXpCMDZC?=
 =?utf-8?B?UExYTkNlWnZCSVBCS0VpZGIrTGhleU0rV2hlTmlHODR0bHFPM1ljTnVESWlZ?=
 =?utf-8?B?R29HTVhWTkFUNlcxRithMTl3bWdXamRTVDZpM1NWYzhKdmk3aXVpeXVmTndu?=
 =?utf-8?B?ejNabGJHUmlyZndFdnRReVZwZ1B5VVRIbmtabllmMDdJTVlDMDU5NTAvTkxT?=
 =?utf-8?B?R24ycUQzeDJ0aGwwMlNTT2lIckQ5SDZrZThKclJucUdlLy9JNmFDQyswVk9G?=
 =?utf-8?B?VjVYblZPbjZveVMrUE9NVGp2VWRuUVIxTDN3Kys2VGR2OVh2ZDRwNjYyNWtV?=
 =?utf-8?B?VUVjdFZhb0xMZGN6bVd1dWJxYVo4cTRvY05wblljM1pkWmhTcWpRaDN6TzdR?=
 =?utf-8?B?ZzNDRkxpaTRtQnR5TzhWVHZZZHl1MzVNRmxFcUh2YXZKS21XUXVuKzZ2ZGtL?=
 =?utf-8?Q?HXRIZFiGysZUraStblCBw+j3V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbff826-2cc4-4e10-5de0-08dc9fcfec0f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 04:30:55.0125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgIsfm3S5I2BaZnI6tS93deXzF4A8oG9muwNj/LbBD2aqgTZhABlXRTcOkmE0C80BAbIv43iTLN5mvj+t5BrxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529

On 08-Jul-24 9:47 PM, Yu Zhao wrote:
> On Mon, Jul 8, 2024 at 8:34 AM Bharata B Rao <bharata@amd.com> wrote:
>>
>> Hi Yu Zhao,
>>
>> Thanks for your patches. See below...
>>
>> On 07-Jul-24 4:12 AM, Yu Zhao wrote:
>>> Hi Bharata,
>>>
>>> On Wed, Jul 3, 2024 at 9:11 AM Bharata B Rao <bharata@amd.com> wrote:
>>>>
>> <snip>
>>>>
>>>> Some experiments tried
>>>> ======================
>>>> 1) When MGLRU was enabled many soft lockups were observed, no hard
>>>> lockups were seen for 48 hours run. Below is once such soft lockup.
>>>
>>> This is not really an MGLRU issue -- can you please try one of the
>>> attached patches? It (truncate.patch) should help with or without
>>> MGLRU.
>>
>> With truncate.patch and default LRU scheme, a few hard lockups are seen.
> 
> Thanks.
> 
> In your original report, you said:
> 
>    Most of the times the two contended locks are lruvec and
>    inode->i_lock spinlocks.
>    ...
>    Often times, the perf output at the time of the problem shows
>    heavy contention on lruvec spin lock. Similar contention is
>    also observed with inode i_lock (in clear_shadow_entry path)
> 
> Based on this new report, does it mean the i_lock is not as contended,
> for the same path (truncation) you tested? If so, I'll post
> truncate.patch and add reported-by and tested-by you, unless you have
> objections.

truncate.patch has been tested on two systems with default LRU scheme 
and the lockup due to inode->i_lock hasn't been seen yet after 24 hours run.

> 
> The two paths below were contended on the LRU lock, but they already
> batch their operations. So I don't know what else we can do surgically
> to improve them.

What has been seen with this workload is that the lruvec spinlock is 
held for a long time from shrink_[active/inactive]_list path. In this 
path, there is a case in isolate_lru_folios() where scanning of LRU 
lists can become unbounded. To isolate a page from ZONE_DMA, sometimes 
scanning/skipping of more than 150 million folios were seen. There is 
already a comment in there which explains why nr_skipped shouldn't be 
counted, but is there any possibility of re-looking at this condition?

Regards,
Bharata.

