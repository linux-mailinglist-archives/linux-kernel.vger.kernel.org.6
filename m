Return-Path: <linux-kernel+bounces-340797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B52987802
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5CD286846
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AD815B10E;
	Thu, 26 Sep 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4nx3lmbR"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AD8157E61;
	Thu, 26 Sep 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369981; cv=fail; b=QGkkla3REtzzLcSZ8e+clLHj2WO/26eFOyb+PIit55NqDwCrU+HmoaN92Gnp61hyeuZSfxvBxyDjfwl7BlOCX9019bhek2xw915qJM5twZIH8e49d+Z0HqsXf+UV7w/mXcKFyWEUxc+zvDcadDDjGs/6f7pwJCSnBTAnFBEfxN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369981; c=relaxed/simple;
	bh=YO0lpk33jiiZ4zCba86dC/BzMkrNuOQ6XtzZqLtvhUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qQGJ1HtIf7Iq6u4jroqzQtYsBkJxSaUINoFO8Lk/TIDVktVVpMVdI/cGiYf+ZBuCHi2illZ19P42uKe12MCNYLfOJHZiJwFOpEseWJpesyMwwJOChSWI5G5/707JUasWOV7DuGO7ZKRUXg8Zyu8eE543aDxun9izT9XjKSH46K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4nx3lmbR; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpmgekO+t9Q0+jxKxUcJhYfxxhaOHVDBfIQavtFlB6+G5KzsUsWpqOEH+BROnaMMRsNFc2gNN6OgAuiY6qGEzScGqzwDwNwR3Z8xbl7ZLakPRYGlcYOwK7CHRurTphi7lujZEAQAHu+KoKqlMaFNxAeSuO9j95TBQ55rZfLrq8uA4n7+vKHQVfnGW8j2knwy09QePvTrA3hI7Xspfmrp+6cp7qmDKwuF6vT/qcidDDLSSD0Oq9CKO77KNXZ7f+iCJAyIZoQUc/VuqqQ9IrXYRo8nzLf3jiI5wO9qwhqStEJ/Ft4rp+Da8vaMOaVFHmIwU5Bv+dTfWznApW82QmEglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDg248Dc7jO5JBfPV8ApUwU004r97bE0efCdwdBthGQ=;
 b=pjOvyaiyNBGS4GSWXgkK/JdRCN+8bGM9cK8c3dfy1wzGJd5lZ6K/kkYpsfbfsjSP7yfLM2LfMYh1cLRa6rOPmBVl8aWWh42uudA6DZe+5L8v61+hLDWNso9HrSVH7t3cFOY26xjM48eJg6llI4J8Flt7d0+CnlUXi+owEwIWo94vYkoDlePt+c1sWCHYfwRTeiwT8T//ElkmOnkvcxhwNioP0brx//HnUYU5xXjorE9mwVWF+xwlKLGJFO6HRwnfJdnG+oGGBKKMpdP7ajum6yirV3iy+6cjBu6THviojgwPptPFrfiBmfu3LLB6YiBXlJRF+wVxsIwaytcvEvvZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDg248Dc7jO5JBfPV8ApUwU004r97bE0efCdwdBthGQ=;
 b=4nx3lmbRdl9uFD7cQQckLAoNCZvAzXd7radOUyqPZHqmMatUg2tbYdztgrhX8MDVtUQl57IvJs17iMv1zBgIYrVIKZ13YwGjzY4r0iiJaias9SOCwix0WFrz93M04I7XV4/1tp9Dxhw0WeSng5IQirExZR4m64jxBRGoULL8Py4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.31; Thu, 26 Sep
 2024 16:59:36 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8005.020; Thu, 26 Sep 2024
 16:59:36 +0000
Message-ID: <9573dd90-a028-493f-9957-83ef787badda@amd.com>
Date: Thu, 26 Sep 2024 11:59:32 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 16/24] x86/resctrl: Add the interface to assign/update
 counter assignment
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1725488488.git.babu.moger@amd.com>
 <39a621b5281753c9f13ad50808d478575cdb52e6.1725488488.git.babu.moger@amd.com>
 <9109e7fd-34e3-485e-bd20-dfd4c68edd01@intel.com>
 <791e12c1-ddb4-4d65-877c-a7d887d3ef6c@amd.com>
 <faf2b24e-4329-4b73-a012-10e85844fa74@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <faf2b24e-4329-4b73-a012-10e85844fa74@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:806:121::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: e9708699-36c6-4b85-419f-08dcde4c99ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHpRbmU1anBURDhBbW1pTXltSzBRdCtRaWx3UUQrK2RkZHI4THhkRXorK1Zx?=
 =?utf-8?B?LzFLTi9DMmZpZWJBUVVUcC91RUxPZ284L28zcVljOVp5NmxuSEJZa05WQjFt?=
 =?utf-8?B?MFlFTUpFSU9CMmpjOXlkS1phMTcxenhUcFVKbS9RaUlYMUpsR0krV29DbXRo?=
 =?utf-8?B?eWFkemdLVzRsL0ZxbE1xcDlMbHBQQ3puMC9RcjY2UHVxbkV4UGY4UzRyMk1E?=
 =?utf-8?B?b1BRWXdGVXVicFlyZ3h4aXR3ZFlmSExBWXk4NXBXaFcwRTh1ZFVVM2NHelRQ?=
 =?utf-8?B?Si95bUVSUkp0LzZLbXlyUGR4SmltdkFvSFdKL1pHWUFKdE1URWRvTVl0NFVG?=
 =?utf-8?B?UWJ5Y0I5b0x1OTFrK0UyakIyVzFlWjNlU054NzNpQWVyYnBYNkhvVEY2YkNG?=
 =?utf-8?B?blBWQnk4ZWJQWW9weUsyaVdPL0pySGdjL1FXYjFQbEd6TElIbWdob2FZRyt0?=
 =?utf-8?B?Q1NENmJ6d1JkeUxoaC9GaU1jbnNWWjZ2Z1JLNVFBMHRBSlduSFF3WjZXWU9W?=
 =?utf-8?B?OTAycXl0SmpVQjNvVFFyaDJOVEVTVXEzWStUdjV1UDlEc3VJY0U3cGtDcWN0?=
 =?utf-8?B?WUEvWFZhWENCTGNkVWxIbVpTc0lLNlFYSlE2SWFaNmJZLzFrVGU5eVRaWWFH?=
 =?utf-8?B?UVQvUERsU2RSbkR0Z1dleTJDVFVJVDJPVkdjYldhdUNHd01XM2RZb0FsdStq?=
 =?utf-8?B?MnU3NWo0SDI0b0xrRHFPVWFzQjBoSHBYYXc0Z2NJdlZ3anRiUkRRajMzVGxZ?=
 =?utf-8?B?YTBHZjVHY1B2eDJVT0pERHV1YWdJWk1KaUNuSlBGMGVFbWlvMUN5bXRBVUNB?=
 =?utf-8?B?TUdCZ2JyT0I1YU5vemtaV3pMR3pNeGt4Q0FNL2JONEpudlkrNFc4VHJTWXRN?=
 =?utf-8?B?bWdpNEIrUzM2MHd4V3pQa3B6N2RNYjN0SkFxMEowbTcxd0xXRWdpZHNQdXdw?=
 =?utf-8?B?QXpHTkFCMHJ1VVN0SkhGbDN4QTh2NUIrUDVnYy96dSt3allVcDlKdThpc1lz?=
 =?utf-8?B?Wnl5L1ROMDBuUWhldzFXc2dtbnZBZTJxUjRQS0hVQnVUQmNDM05ZQWxpdVVT?=
 =?utf-8?B?WTNiaWdzcmhyUlJPTE5ZTVMvUCtjTXJwc2tjekN6RHg0dlVKaVRtMm1tbjFY?=
 =?utf-8?B?VCtZYjAvcmdkaFBPQXFHRmZzbHlrNmU1UDZyblY5N0pYRjNJZlNtRnNTTlRv?=
 =?utf-8?B?ektsZVpJVEFGWVU2RXhNOXkyUjdHaVZvcm50UHFYYVVwcU1FeUFhQTJtcDVl?=
 =?utf-8?B?cXhmZWZna0lEN0k0SlB1bUdlVzlUK3RVcVdzWU9PLzZGWS9rbGpUeFBtL2pU?=
 =?utf-8?B?dS80VHVicWg4K0hVL3lwVDhKVTkyV1IzZ3BqUERVcCtVWXFqWm11ZWh4M0xu?=
 =?utf-8?B?di9zdlF0WStPZzcxbUQ4c2pmUTJsOFBDU24vOEJCSi9LSDFYL1htTWpFeG1p?=
 =?utf-8?B?ZjIvT3lrZ043VVVkNWNhU2ZmdzJ6Uy9FdU1YYk53akxjdGJ3WEgxTmlpV3Uw?=
 =?utf-8?B?Q0x6Y0s4a3A5K0tsZVFkSUY2K1NiaUd0RS9QeFR5ekJpTzg2dVYwYnFXVXV5?=
 =?utf-8?B?ZHhzVHkzeURMMGJPN29FbTN0WHl1UXNnZUZOOVBMaTNYWEJwM1lKUUFSdFNv?=
 =?utf-8?B?WWtDbHZla2x3NGtjQ3ZzbEJUY25kbGZDdTBBRE1uOHZTazBrS1BXSG8raFZ3?=
 =?utf-8?B?Y2VQM1lnWTFBMmxQZ3BEQWZOS2FpNXY4R09zRVo4d2JqTThDYXA3Qk1RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0QyLzhIVEVDTGVIV0pCYWpsZDl6NWp1d1FmS1BXeUFPemRvVkV1MnNpQXdC?=
 =?utf-8?B?V3F1SXQxazNSeWowalQrK0VCdWFwRE9SUXVRYXpwR1JoK0tLbXhnYW56U1hy?=
 =?utf-8?B?VGNUeTN6MnEwWlI1Y3BMMWNUSEdxMDFNQm5mUWZOd2R3QmxkUU1ubWd0WHhC?=
 =?utf-8?B?bEVrVG1XSGtWNlZCWXd3c3BvelUzNVd5akRla3hlZXNPc21Pa0krb1VEK2pl?=
 =?utf-8?B?a1FPRTMrK2M3MVNCd3NwamJ4RlBKVHJaUmxwTmZiSkhBd2JWandCM0F4WkxR?=
 =?utf-8?B?S1R6TWF1U3N3OVFOTG5aUHN5dEhWN1M5cmpBK2QyTXdWT0UrQWFCa1JOWHdL?=
 =?utf-8?B?cmFBNXcwcWJBZjhacVJxMDdscVA5T3BnU25CTDFPN2xKVEM4aG9uMjRIcGxN?=
 =?utf-8?B?M1JiTnViaTZEa2dZcGJ2WVZsUWF6WnM3VkR5ejduOXVybjNxOXJqUzRaaXNp?=
 =?utf-8?B?d3Bqa21iZE5hWW50WmdKSlZVM0tHSUl0aURpczZCRGxEQ1F1WFlnTE1QRHJs?=
 =?utf-8?B?Z0lQVXVOSUpQelo1SDRBRnExTEJIYmJLWE5iQklGc012YjZsSk9rUXRlYjM0?=
 =?utf-8?B?Mll0M2g1THFMVTdMakFQeHU2Q0lHN1V6RGRqSnYxc1ljak94QWtoOGxrelN3?=
 =?utf-8?B?Wm1uRk9pTDVJYnRjaTFBR1BteW9kYnM1eVFHRW13Sk9PVTVqZUc2V1J1R1ZL?=
 =?utf-8?B?d2x3WmwrUGFZbm1aMVJSS3Z1clZ1bFc4NTh3U1V6Mi9wejZIVW9Kc2VpR3lk?=
 =?utf-8?B?b2laV3NsTU1Eamx0MEtmc0RWVUV0YktqcmFUaWdNTDJCR25xUFhURmszSjRL?=
 =?utf-8?B?eGxLYTFjTGJGVkU0YlFJY2VYWnJIendEQmZwV0pRUks2RWF3ejQwdXJqaGtE?=
 =?utf-8?B?S1I2VEQ4OXdxM1BkSTF3akcwKzFocmFiNlIycWVDUllMK0laaEx0aU1YSjNk?=
 =?utf-8?B?Q3lGSzFLdE5iYm92emNvYmlIS1IwaTdLQWc0ZXU3cjhVZm5PeTh5bmYrMzJk?=
 =?utf-8?B?ZkNsWjdtRFVxbGxJOEFBMC8zZFF1Q2RwUHhISG5YRis5aFNwdSticTEyd3gv?=
 =?utf-8?B?a2NFZEk5eWZYWHo0bks5eThGR2UwUitkOGx3dmFQMVNkY2FhNER2Q3lkclN6?=
 =?utf-8?B?V0JscFl2VFdnMFJ4a0JpRmVVRSt2M2h1TXFLekphTXl4YXF5TlFBcVlsRnh3?=
 =?utf-8?B?dk9pdzV3cnAzMURZRU1iNG90RFhlNkhvVzFMZW9ud3JnaC9oakE5aXBKMlRX?=
 =?utf-8?B?SnVJTFBPZnBUWDFacG9mUUtiWTFBelB6UUs0b0hNTTkvV3ZMZ0k2bEE1SmdZ?=
 =?utf-8?B?Q0pBaEkwcWtYSktPdkVNMjhSaXBYRkNqOWJjQ29zMlJnU01LUHN5enhpZjFv?=
 =?utf-8?B?bkVKT0ZXUDY5cDk3Y0h6MjJYSWE3VncwNS9uK3E0RkNuemhxcVBVYVdBZnJF?=
 =?utf-8?B?V2liSnphS2d5RW92TTJDVENuKzd6aDFwL24wNG9zV2hZcmtidjRLOGc4MVJs?=
 =?utf-8?B?T2VKb2s3Tkl5QmY3azdDOGpjbFFsNENuUzhSYnlqcGlteVJ4b01MOThLNTk3?=
 =?utf-8?B?RGJ3THdEVG4yaGRLMERNRkhabFJBQnhVdVV5NlorUCtWOHZ6Wk01K05LajE1?=
 =?utf-8?B?aTZUbnkwNkRyUkFFRXJDWlMzdlFjNW4zTnVuYWtLbWtJVXZYQzZRRUs2QUpL?=
 =?utf-8?B?dUN0TzNxSmpmMU4wQUZ0Z0pBME5pWjNlVUZYbGxQQ1JwamFvRGhKNExIOWQ1?=
 =?utf-8?B?c0RJVHFMMVJCbHBJdENPbG1yejkzMzRQQ2l1L2hTdVk0NXFmN1VTays4Njgx?=
 =?utf-8?B?OW82Y0d2N3NmZEc2UzNYOTFnMEtpaUJEZG5rTGZ0VExNNys1NTEwYkhsUFpl?=
 =?utf-8?B?WW1SSnE3Sk9Sdyt0bE5VVWQwWWxZV0hWQjlkdmN0dG1KZUErYmpZVDNCbk11?=
 =?utf-8?B?MTJmaHNYUkoyd0RIdGxzZ1pnL0hBcVFCRVZ6ckVVOWlFN0k5djhtMGJGMzc1?=
 =?utf-8?B?bWo5U2d0UFJ0eDhGN0E0TVBLQ2RRWmIweG9pbHlHUy90azBmWGtXZ00xYVVl?=
 =?utf-8?B?aFBobDVReE9uV0l4UmtCTzJpY091VEpUVkMzTnlsem01bzdrMnZBbi9vZjFi?=
 =?utf-8?Q?uoeQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9708699-36c6-4b85-419f-08dcde4c99ed
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 16:59:36.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z76oh6QSx8IcxfZSTAaTcyFESU89NL4wGmcymNg54v+uO58k29yVhpCIMy4KYJ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608

Hi Reinette,

On 9/26/24 11:46, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/26/24 9:28 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>>
>> On 9/19/24 12:20, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index 7ad653b4e768..1d45120ff2b5 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -864,6 +864,13 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>>>>  	return ret;
>>>>  }
>>>>  
>>>> +/*
>>>> + * Get the counter index for the assignable counter
>>>> + * 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
>>>> + * 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
>>>> + */
>>>> +#define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
>>>> +
>>>>  static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
>>>>  					 struct seq_file *s, void *v)
>>>>  {
>>>> @@ -1898,6 +1905,45 @@ int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +/*
>>>> + * Assign a hardware counter to the group.
>>>> + * Counter will be assigned to all the domains if rdt_mon_domain is NULL
>>>> + * else the counter will be allocated to specific domain.
>>>> + */
>>>> +int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>>> +			 struct rdt_mon_domain *d, enum resctrl_event_id evtid)
>>>
>>> Could we please review the naming of function as this series progresses? Using such a generic
>>> name for this specific function seems to result in its callers later in series having even more
>>> generic names that are hard to decipher. For example, later (very generic) "rdtgroup_assign_grp()"
>>> calls this function and I find rdtgroup_assign_grp() to be very vague making the code more difficult
>>> to follow. For example, rdtgroup_assign_cntr() could be rdtgroup_assign_cntr_event() and
>>> rdtgroup_assign_grp() could instead be rdtgroup_assign_cntr()?  Please feel free to improve.
>>
>> Sure.
>>
>> How about rdtgroup_assign_cntr_event() and rdtgroup_assign_cntr_grp() ?
>>
>> Added grp extension for the second one.
> 
> Is the "grp" extension needed? The function already has "rdtgroup_" as prefix so
> the "grp" extension does not seem necessary to me since I think "rdtgroup_" and "grp"
> intend to refer to the same?

How about rdtgroup_assign_cntrs() ?  Added 's' in the end.

We are assigning multiple counters here.

-- 
Thanks
Babu Moger

