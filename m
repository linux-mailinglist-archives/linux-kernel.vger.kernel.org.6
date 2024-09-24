Return-Path: <linux-kernel+bounces-337191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A507F9846AB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75991C22DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBB71A726A;
	Tue, 24 Sep 2024 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xvEXS+Ub"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698B5224D7;
	Tue, 24 Sep 2024 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184275; cv=fail; b=bb78LyC4zsQrWc9WO2gJY7Q/LvbytdxPVhc2OURJXMK7Fb5tnywMXRNfKTgjpZLLckZQeJTHu7wbrduRHrYTyq/tXO4gp4PbXGB7kPWIYdEMlZJtPto+lUKay7HahRhLenu8V3FjUkAcKmrJEiEI9IBxPXBD0dAjssCao0XceQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184275; c=relaxed/simple;
	bh=us6S6w1r9sMOum1aHT2XDOMriR4SESuFn/PVWXkMvHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SOt+4QgjnNFN5BXdGLLp17xF5eZl1+Bgw0+BMIXq55nsYtqum/ru7Hu5M4sUxPd6G6kATOiw5zmaEfgChbu8R0c8FHybt5fxoVrHPJDI7j3gISE85ELBRkuDoJyS6Hmc0h89KqJ41oiANSYPLMzUExAs7mp9lOarliE5gfNh0c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xvEXS+Ub; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0fHOu3Uhv/laQGe9MUeHCPIWyTc6V+njt6At+rw99ASsRr5V+Un7sBZ/lWPfNLijrtA2GfYI483LH9h6Nv7oejhd39DL9mja19LAbUiYpbL3i1Nb997OeHVrNeapDWMi7Eo/o5JS4+0hzk2mQRjGLD4CX3XnSm3RdhpbxLrea7ZZqcQQ3Sfq5HEiCnkvYJykjqy536V2JA5H1Vk5m6U330Z6JbCfZlmbLX4wIs+IXMgb7AasOHqh6tAqMNf5IABGnKX9yY0N1CONZK4d/yu4WkbvUNH9JF9XoC2mKzblzDby3Bci2shYoV0yYSuVxj1Nsuc8LSpLm3VhbTDNbx0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsHzVGUK5QgpeKhE4NOnzRXnxnDxwuhM/sgAfZOUQFw=;
 b=vtgQVGGC3uoguzvRiqwu42Yg/+g8blpDTMhmzBfty1qQBL5iM+P6UNwq+n/giq/bDKH/fgdc2DgjEX/VbrtkP8bHUoJvfxu0JhrepMNeIzrTEP6dPYJkmLFNx061OZjlIwbzPXCKOBjsKxQehWbyXPdCWFVrR57HTItB2Rh45nI+Mc8hmKQK8Z1cubnUYdXi/W5hSZVm5Lp3+Ww13tz8TV3m04cl6jxqkz50JhgPpp/kEyyPGLcSC3mJB36AhjhgAY8lCv4nWoqFHcDICmIbcR2/dRItQ8SrDJIbPqO58olCvjBXt5882CQOwWCsfDI49hQGRjK5mfK9QpVkPRdWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsHzVGUK5QgpeKhE4NOnzRXnxnDxwuhM/sgAfZOUQFw=;
 b=xvEXS+UbMvCitdiwuPfBSgTTD/o6nm0mOHi/yBkQKFin47gIZrWcFHNVSc/yCqBtZtcAZMfMbtykBBj2TPfyCwn+vXJDMx6vvCOsOjnX6GVOgwflfh7yvE68v75Nj3obALZ8H5q95V0I6td1N+1URiKkHP2+kbxxR6Ziv8UTxDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 13:24:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 13:24:28 +0000
Message-ID: <0a31cb22-e3f9-4212-8fc1-77d6cafa7277@amd.com>
Date: Tue, 24 Sep 2024 08:24:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/1] platform/x86: dell-sysman: add support for
 alienware products
To: Crag Wang <crag0715@gmail.com>, Prasanth Ksr <prasanth.ksr@dell.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: crag.wang@dell.com, Crag Wang <crag_wang@dell.com>,
 Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240923063658.411071-1-crag_wang@dell.com>
 <20240924050302.317522-2-crag_wang@dell.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240924050302.317522-2-crag_wang@dell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0132.namprd11.prod.outlook.com
 (2603:10b6:806:131::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c516853-144c-4943-6036-08dcdc9c373b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MThtYlp1Sms0TzZXQy81bmZNVngxS1RwS3BML3ZBRmRqNHgyQWF3dTBSclB0?=
 =?utf-8?B?Z2t6aGQreXJoOXB2OFZ0Myt1K0Z0dEpMU3dEVHF5NEFNc3E3b2VXYjA1alR4?=
 =?utf-8?B?L2FiNXBMNVc4S21abjFkWUE5czFsbFAvOWV6SmZnTzB6RS9iT2tHN29NK3N1?=
 =?utf-8?B?SjFLVUZ6eXkzREdMVmowNS9JSEtMRXY2ckVxbk5TZmNreGcrS3RoNDJoeUNw?=
 =?utf-8?B?dmVkTHRQUytqN1V4Q1JabWZ2WFdCTTNZbkZoWFM2OGdyR1p0SWl0eHVZMlBR?=
 =?utf-8?B?SlZCVHNuVmlXRkEybjFlR25uOXNGR1RCai9xL0djaGlmdVh3Nlp4alg4cHZZ?=
 =?utf-8?B?ZzFYQm5DTW9OTzlHZytKUzhVSlZadVB1dktxUkhHMFhkdEM1aUVqaGh1NGw5?=
 =?utf-8?B?bVhyNXdZU2xQYW9KQXYxb3ZNT1QxVUJuSGZKN0VSSUw2allVZEUxV2FSd3hK?=
 =?utf-8?B?M3VtUUxTdXZzNGRWVktQTXUxZHlhS3ZPbk8wbUtJM3NiSGxCSFRxdk8xTkpv?=
 =?utf-8?B?WmlPT2VNMi8zRWtZbk84Y3QzVmJwN3A4R1FCc0twVXRXdmNFS3JTRkJhcWNk?=
 =?utf-8?B?Z2RaVTNvb1JWQXNMRnZyd3FpR2FnWTFIOFZNZENTZkU5SnBZWisvbHRmRDBm?=
 =?utf-8?B?cmsxMFhjdTE4UEpsR2xBSzRjczRNOVhFelM5czFiekt4Q3ZrZU9GN01TejdZ?=
 =?utf-8?B?d1ZsbU1JTjZReXAwT2xZajMwSGo3cmdhVWhuZmpDdm44SjRzcCtwNnlOYW1D?=
 =?utf-8?B?TWdjWDlPQlZqZ1pnWXphcGJ4cDZRVFRTSGNEVEs2Ym96em9BekZsUmRxbWJj?=
 =?utf-8?B?SCtyRlpzT21QTE5DUVYxTm5zbVlKcDBnRlN1V3dYeFNsby9NV1VqVCtoRmJq?=
 =?utf-8?B?MTBsSVFwY1pkU0ltNHRURzdPMExvL1dESHlOdzFlNVl3OUtiZ05heFN2U0di?=
 =?utf-8?B?eHFQNGtCUFlOaWhETnpPQWx6aS80WkV3MlRzRXIwNUROWTRGM1JpUytwL0FJ?=
 =?utf-8?B?eUhWbEEyWFBWeFAxOHRuQThnS0hHWnR4bTMyZkJiMHFZYmwzN1JtUkdsVWpU?=
 =?utf-8?B?TjBKVWovM2JON0pOSVY4dEsyaFZrZ09jdURmYnBlWkVUamZpT1EzS0x4Y1Yv?=
 =?utf-8?B?TGVYK01xTWRoWXNnalk4SjB0a242YXVBNVNCMlNwTU5BT0IvWnQ0T25ZSkgv?=
 =?utf-8?B?eW9pUk5pTnJZQzV6d2hZNnhudFlLWkZEWnZ3bXI0aWgxdk9jc2FtZ2pMaStF?=
 =?utf-8?B?c1NRV216ZDhJR0lrK1lDdWhOSVFJRmhpQTBha0tFYnVkTG93TlJGc0E3Tlcz?=
 =?utf-8?B?ek9MUkdreVVwRjVZUjVxK0pJWUl1MkRsejhITHNlVkZpL25YK3dpcUczd0JM?=
 =?utf-8?B?aDAwdU5sdDFuYnVrbEplV3haOFE1SGVNSmo1Uk1WbXZpZE9PbW5BUUtvcURl?=
 =?utf-8?B?dE9RcjliNHNrSXRjWUt3R1p1bTczQlNJZHNrNFhneXpGZE1xSGttaVlRWENM?=
 =?utf-8?B?TnJFVzJXRWpwMVZmc0JCSExpT2l3RlNLT1JVK3NlRmYyWThETnc0MVNMWHcz?=
 =?utf-8?B?cXhoWS8wTFVnelRESEZ5VVVLQ0FqZHNIdG42cFNGaHVVWWdhdi9lMGM0Qk00?=
 =?utf-8?Q?Nbe3iQgp2m17TYDxkwijGRmcRkvS6cfD9UfQ70070HsM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1FMMkJ3eUlqL2tSaVRDVGNBLzYvM1E3aFNvUlJ2R2Q0SXk4Wi9YcDVDWVNI?=
 =?utf-8?B?TmEwNXJsdXlIVGd3N2ZSWGllMUxOd3pTc3YvcVg1RHVyU2d1dnRrT2t0OTVK?=
 =?utf-8?B?NlBpZzJ6cDhMU3FidEZPVHgya0cvY3o1a3Y3TFJFZk9wZ1Z1MkJ5L01PS082?=
 =?utf-8?B?ZlFZRlFkbU1QMkxYNU4xR3N3SmJTSitPajYvbE4vYnRPWVN5V1NJQ1hxZGlS?=
 =?utf-8?B?ZVNjYUFYMjVMN3JMMkdNVXo5UFIwTXplaHpWNkJSV3FSQWVoM3ZvZEVKNnBZ?=
 =?utf-8?B?ZGkxakxMVk0xK3hkYW51djEySzNybXBHWkJYd2lHcE84UlVXT0Urc09zUTZ4?=
 =?utf-8?B?ME8xNlJTMmd5N0N1YmloYzMzUDZFRW02NS9jMUxUejYzTU50bE4zUTBHY21I?=
 =?utf-8?B?VU5RSk5CNElFRTR4L253WVhDaVRtZGh1bk03Nzc3bW0yalk5Y040cGY2U2pP?=
 =?utf-8?B?NEk0QzR6ZFU2RHpGWDNTVmR3YnZFMTJhOTBXYlVjdTNRdVA2QW5xZ1R0TVlk?=
 =?utf-8?B?WlAvU0RYbzBPZHE3akQ2alZnK3RqaWRKNk9wUXNlRUdDQlljYTFad2JYd1Bu?=
 =?utf-8?B?VDhuVDZzd1NTMXRWd3pSVDlTc2ZqV1pVSDk0N1prdmpuOHJGUEU2aWc2WFBj?=
 =?utf-8?B?Y2E4ZUFOblZRcU80eDBuYVhIa1hFTEpJbWhiZElnNjVQRW82NVlad0ZEdjBi?=
 =?utf-8?B?S3RTVFFXZjZUcDFGRkNNb2l5M0NTaCtMVU45STJCTTFWMXVsWmgwVlc1c0xB?=
 =?utf-8?B?WGdhbnFuZ1RYTGU3QmlLdzg4TWx3b2U3WEp0UldOK0ZMVlZKVzJpcCtQWng5?=
 =?utf-8?B?ZUF5bzB3QWREeFRyVUVlUzI1RjhiT0prOVFrMWJTd2hXcEtaaUkzY1B5UFRx?=
 =?utf-8?B?Nyt0bmdtT0RzNGM0bDU1a0N2V0wvZEh2cTIrZmU0WlRnSTFPK1BKZE5yeUdi?=
 =?utf-8?B?VzN1YXlSMzE3NmhUOXdMbUV3ZFVNdGtBeGtPbGJGMG1PeHJvenVyZ01VZEV4?=
 =?utf-8?B?ZWl6MHg1TWU5bkJqYVhKY08yMnVjNStDakZXVTk2dEVFbUQwNGc1K2U1YWo4?=
 =?utf-8?B?c0lENXYrRzdQQUExSG9jWjVFRnNVTW03RlAxdGZKTTRjR1c3bFBWYzA3Q3p1?=
 =?utf-8?B?UDUyTWFxRmdmL09OUE9oY2ZDS1lrYzQyQ3BMVHZaREZqMEkrV0JVakk0a2I3?=
 =?utf-8?B?WHZNL2ttajNJK1BRbnRtN2dZZWppT3FlVnBVcTFIM1NJOFByWWc3ZVFHZnlH?=
 =?utf-8?B?VDZaclZtY0NtUW9HUkN6eDAxVG9pb0ZPdjZPSDdTRGt3RFhrMSt2Vno3SXpK?=
 =?utf-8?B?dnpsMzdQUjdnQ1V2N0pYUk1ZeXk5cGxhQk40ZjZyeEhSbzRRaEFkYWpPQjlM?=
 =?utf-8?B?RWlXSWtLNU52dVo0U2lqdlVzOUN6MG5FUXZHSS9QSEtJVFRwZ3J4dXZENEE3?=
 =?utf-8?B?R1U1WVFsYllzdmZ3a2hJRTVENDBkRXJsWHdyVW9YOER4d2ljK00yNytVZXUz?=
 =?utf-8?B?NjRCRzA1MlltbnJyTHFnMTcyREg3Yy85U3pkSWZ5MlpueG13QzJxV3YyUkND?=
 =?utf-8?B?UWdOcjJGNWtYSjdYd3lZenRmeXA3QmNBRWFNVkhJNkR0YWI1WkU2MXJBUnpw?=
 =?utf-8?B?VEFVcVlRTGh4NTFyVGxoa3NONEVqeHVYcjY0M0NobnV5NG53R2ZhQTQ0dkJw?=
 =?utf-8?B?d3FtR3lDamovS1lzSU4wMnI4L3J4MTk2SzUvNHlEMElmZWVLaDA4L2tzUlE3?=
 =?utf-8?B?VEJMUGJGc0ZRd2M5SHZ5SHYrcGlpWjlPYlhTRGxXL3VhRjhxUXE2QzdWT01u?=
 =?utf-8?B?dUZNWlZiUlp6bFlEbm56WTF2VUFqcUg0Q0hJNmdmU2hlM0U1MjBQNkVlbitn?=
 =?utf-8?B?VG9LNm1FUEJxV3hnbllHT0sxUkZRTjc4eTRadjdRUXZXZTZpMjM2MDhuRWxB?=
 =?utf-8?B?RkdqRS9IS2FxalhTSk5LV2VtWnpEK0k3ekVuME5xb1hTVmR6MmIvWmFIYlRx?=
 =?utf-8?B?by83ZE04L2MvcVhCT1lhbFkxL0ZvcXB2Nzd2b1V1akNrN0RDWlJJRkJOOVhT?=
 =?utf-8?B?ekY5V3o2VC9QczNTcEhPY3hHSCtLRzlWSWYvTzVEVUhKWnZxL1NRSDFsRG9q?=
 =?utf-8?Q?GY4JKe3HJRgm1dMNSub3z4SIw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c516853-144c-4943-6036-08dcdc9c373b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 13:24:28.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esSJYhG/9PIwbyHUngRBbsx7XpbVnZBwXFnP5rIG+CC/u/Uks5J1hVk8vU7yylv5hww7CoWCBqTOgniK4XuUOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930

On 9/24/2024 00:02, Crag Wang wrote:
> Remove the URL check and add alienware string for broader support.
> 
> Signed-off-by: Crag Wang <crag_wang@dell.com>
> ---
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>   drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> index 9def7983d7d6..68c63e1fbd27 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> @@ -521,7 +521,7 @@ static int __init sysman_init(void)
>   	int ret = 0;
>   
>   	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
> -	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
> +	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL)) {
>   		pr_err("Unable to run on non-Dell system\n");
>   		return -ENODEV;
>   	}


