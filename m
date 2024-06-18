Return-Path: <linux-kernel+bounces-220195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F5090DDF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136292818BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A8B1741FF;
	Tue, 18 Jun 2024 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g9aoRaDL"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F0176AB4;
	Tue, 18 Jun 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718744606; cv=fail; b=CXS5CPX/tATxapxL5JDBFjWzGMVWSz8XSIxbB5XqawswO9yMjAHXc500PHFtk5+sArf1cfXZOzWT5bmtjo0e3n3ou9b/yd7Kuvc9X7kA69CdMRcqXEfkDNTzOlINuSNtpbwsvgu/fzxLNpLVJM0YzeKIkgxiFCpyK8TVZAja3nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718744606; c=relaxed/simple;
	bh=Gskh8kbPlmZU9P1mCzNoJZznLgTrZX/2EP+U909VfX8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iqahUocf0W0EUxF7gmgGGFgrjiqbSNewxt1v+whDuJDmOXV/WyMemnPdDrOnaz27lXc2ANrBf5m/YsMS+pkSdQW+Q9Jyfe7HlH3bl4Ui59F716oKpsnFN4gRGn/aWumt2yLiZe+nECrGVTmjqOY2l7ZWFdvwFTp2zBh2IMnhd/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g9aoRaDL; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6QI9RABNzYL5Zj2mtkpPWs3FBF4CM8Kud+FRo3C5mTnSbuCiAtZZ7XTp2BHc0e7VfhyOkrmqHvSrNLzQVQ39uiUYlivEI536sTbufvg8GfmGLxhvoHkAXLaZnfrIrFUq05HH6GmKAHO26qsNf0bx52Z8wl0YVYZp80dts1E5f5wsC4U1JuVTPLRPlYj7LGHNw8/HlExXSygR8LmO/ZMlDWOSDWum2pw47pQyE5faTRM4of2pLx942EtLBZahHW6EVgTUJZfn/Wzssxwv5Xx9mY1SFR1zsRZjfb6ehu+UpGUCZOKcSS22q9LyYtXmDZysgJx6E6SWW9oycn3ST6BxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9Vz/EOzAzwmKKn0R2IxmjTTwqArHlK2yyN1tLbl34I=;
 b=i5o9cSFGwaNA2sQe+DdbBroC7GApDsqiiLg9Uhq+Vy/VLnAPtyZQ/MarGM/wO0UfvCZ9R5aZzlM624G30BRxTMb6jsmKGRfCY6dzEd76Cg58cImZZdBwRI1rp11lSrRyAH+wUYLw0V4PtXSmtKxU0EAHocHZuphqf8F0lSu5Gb1SC2dZUlROWK7xO+ZNcoSX25Lz3XvSmBEFewhsOvj3szKzzHCSyVKmvvmk0xF+mL4XOlXVuWRL7x3JAL2v5xgTRIGjjGcr9mDH8nFQUrE9skWBKCFNj7wZ02J+idrUXrUoXqjutG9As/NJ7CfHN9eGAv1RA6LpEsjbQWkbrN++Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9Vz/EOzAzwmKKn0R2IxmjTTwqArHlK2yyN1tLbl34I=;
 b=g9aoRaDLCGErE38aJi9HcGVf4KDsPAVEuZ7dKumM1Aa5EKyd9hMN8eWoZPwk9Tfpkd/Slma6rnW0p5Up0lEs1gvCbdsFExcRj15KULaS57iqb/npRtCgnVz4l3GBq3C9TEI2xHnyldwFKyNIuymiK5foATLcYiBbiAo5AJq/iIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 21:03:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 21:03:22 +0000
Message-ID: <14123d61-b8fa-b21f-ca3f-1ac6c29a1fca@amd.com>
Date: Tue, 18 Jun 2024 16:03:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v4 04/19] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
Reply-To: babu.moger@amd.com
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <0a73504f355a8b0b0b3d32f6c0e0b8909c552340.1716552602.git.babu.moger@amd.com>
 <da81b315-a97f-4b43-84a2-5bb347bfafe0@intel.com>
Content-Language: en-US
In-Reply-To: <da81b315-a97f-4b43-84a2-5bb347bfafe0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0071.namprd12.prod.outlook.com
 (2603:10b6:802:20::42) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bcab15-4864-455d-8da1-08dc8fda1662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWI4MVhqekhkWEQzZll5MkNGdUM3RkFQRW5ncHRocjNJZ1kzMlV0SnNYWTFk?=
 =?utf-8?B?L0VYSzNxZnpGNUxLMjlIdzFJaTR2K0d2NVBrUHRmUWkyZlhsMjFYZlowTmFW?=
 =?utf-8?B?a3pZMUJEQ0ZSd25qa2w3bEVKQjBEKzRQQWJZNG44QW43QlJPWEUrYUtnTjRz?=
 =?utf-8?B?aHhSL25RMmRJTTJzK2p0RmFyTzhZQjJlZDlhM0c1M3haRm9MUDF3eExSSDE2?=
 =?utf-8?B?Zzl0cGdVaXZkYnpFdU9yYWxabWNUSGJ3WEJINmg0Qkk4VmZxWkhGRGtPWUZC?=
 =?utf-8?B?SGRQTUNqcEd3VGxDSkZJMjJ6cDlkeHpkTlJjb0x5dVBIT2lDazZ5Ylp5TUNT?=
 =?utf-8?B?czB2WFpYb29FbnBCT2Rac0JwYmlyeW5GQWQyZHJQeTFGQTJ2c2JZRHZVS2U5?=
 =?utf-8?B?MjVrVFdSMjZxdnZOWlJVaXBJWHZETmdYRVZFU1ErZEUyWjVpdFo1Syt3R0NB?=
 =?utf-8?B?ZUtUc3RYTWtwc0MrckF5QUN2VGlCZURmZy9NamZGMjg5UzVLT2IzREJGWnBk?=
 =?utf-8?B?NUFVK3VBUGpQSlpyak5seUJPb1FWVk1HUnFrSFdiQWY2UE1LOHQ0ZFBQemZW?=
 =?utf-8?B?d1Z5TEpMbGczbStsaHdIZ1ZpYWhocU8vNHVJcGR0dFdvRXhjaC9ET3JwRzRp?=
 =?utf-8?B?Z0Vnd0JmeUVyelRrVHR4RWwzREVxSllxOWJSdzBheUxXbU5USmkySlNXL0g2?=
 =?utf-8?B?ZTMvYngxaThReU5TWVdGQ3Q3UzBQckZJRS9kN0lCUFFDU081QUJ1WEY1WExo?=
 =?utf-8?B?VGZ2UmJVTHQ0R0padE9CMUNOcXA4Rlc0RUJiejhTYzNTU1pSaDRzSVIxMUVE?=
 =?utf-8?B?SURVelBiWE81QS9YNVd5L2hjdHFrRWFmSGw0OGdHdjUxdU5vV0szVU1FK2ZD?=
 =?utf-8?B?dkFhZTNUaDV0RTA1QVhoVFBHbUlIellyekFVeHpjOW1udkc1UDdHaFF5YXpi?=
 =?utf-8?B?Y1dPYWtWUHF3cWNUUkgzTE5PS2FCZFZ6Yzl4MStJNi9NVXhRTE5oelJzUjB2?=
 =?utf-8?B?MHRFYVFJRThSdDdpZFlya1pBVXUzd1dSdlZyUmtXVnFScEdqRHNCRENwelhu?=
 =?utf-8?B?R0ZaZ1puRnNUUnpJUFp3ZWdHR3JBbmtVdCtBdkh2WXNYdjJhNC9YMTRtb0Fz?=
 =?utf-8?B?bUZzN3BOaUhmSkVCbVRHelZ4d0xpL3pIWDlpUU1KNmZ2STJQOGRwNmNPM0s2?=
 =?utf-8?B?cElmaU9wS0xaS0F1OW5vV2hBSWQ1bzZWQ2dFZDIzbVFTRmZQaVlBQXhPTWFT?=
 =?utf-8?B?eFBXc0dEQlZlaC9iTy9GczhibmNGSHJFM0pqMHhYR0xoMGgvUFZiYWZtSmh0?=
 =?utf-8?B?ckJIeEZISUVWZEJNQmRxbnlyNHZSREdxeFF5NHlpbkx4RHkzUGhwU1RabG1G?=
 =?utf-8?B?UjJIeDZ3NjV4ZUFoSWhXMm5hMTFxQmhUcHZTSFFtVFEwTURCTzRSc0hadGhi?=
 =?utf-8?B?eVk5bXVGdGtwT1A5V0w3UFZrbThMQWw2aVR2cmhPMjZ1bE4yYjU2cDJIa1Yz?=
 =?utf-8?B?ZGJ4Tm0rUGF2b2kxVXBWT2hNSFNVMitsZUlrL0F1UndDRERucy9XR0t0TzdX?=
 =?utf-8?B?RmRNSUc3Nkx2ZXg1OHRZSlFCQTdwYVhFT1BPZ2JZSHVmWVlyUFRFQmY2V3FP?=
 =?utf-8?B?RTNXWkR3ZWNVRWg2M2l5bTgzdFhteVgzNW9UVHN5Qm5ZQ09Bd2pmazBHTzk0?=
 =?utf-8?Q?jp4Nd+c/G6flcVJ078/7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3VBV1JRM0dTWm5tME5Xa0kzam4yR21ZRk9CNk1lZTRPS0szU2kyN1RhdHl3?=
 =?utf-8?B?cGc3SGduOGJTSkJjbHZhTTR0UGVtWkhwNkMxMFZkOXNOdXdjOXU4cGFRdERJ?=
 =?utf-8?B?L2l1MVZLTCs2V1JkNDc3dU8vQ0VDOEU4Q1E5a281QlNSdk5GbXZMTUpTcEJ3?=
 =?utf-8?B?b1R3RklNcFdOTWlzY3Vha013RzVuR1ZPQnF4V3NTMHFsK0JibmM1MGIzcURs?=
 =?utf-8?B?eldHbVk2N1FVeWJxSkpFSzF4RlZERExDUGVnS2ZtWUI1Uk01VXJmY1dUNFpY?=
 =?utf-8?B?ZFZnM0RkTU10NGFSdXkzbmZkbFRFSWUvM0FCMm04ckFybkRWNFliVm5JTHE1?=
 =?utf-8?B?YlFocVdKK3lwd1R6TjhWK0dmeUFSUGVyMFdWWWsxQ3pTSXIwalFtdUtxMElr?=
 =?utf-8?B?VXNyM3NSaFJYazNmRWZuZGZRQmtvakJ4YnV4bnZDMnpmQ2E3ZFd4Q0tLaG9Y?=
 =?utf-8?B?ak5pYVE3WlRJRVlHa0tENktjQnNjd2wzeGxESGExb2FSK3NHZXBtWjdjLzhj?=
 =?utf-8?B?eXk3OTh2UStUSVpZVkZOOGJ0OEpPWjNuVnM1ZXJYNkFEYldjL1BZdzZOSkx5?=
 =?utf-8?B?b29KcTRGQWxMaTc1L1puWWVpWm5hRG5kajRSa2dBMmZGekpFUm5LaHZqMU55?=
 =?utf-8?B?RXNiNHp4RjBLc2Z4TGJWOC9URHJTWVl6cWRBMXFyNkdTNmZCT3p5QzhNWk1T?=
 =?utf-8?B?MHAxNlJFeDZXVTJ5emJSeURlL3NxckU5OVk3MTZvbEhla3RhNzVoazU4UXJU?=
 =?utf-8?B?T2R1WHd0amErRWZOSnlxZDg3TkVOejVxbHJ0d3IzSjVZdjNiUVFjMjgrRHEy?=
 =?utf-8?B?am0xdkY5K0cybmN6UGN2RDRlOFRXaVcrbnY3bEIrMlptd3p6VzQyQXo5YlY3?=
 =?utf-8?B?WTFZOHdzWnIrOW1IaklON1RwTWJRZklNWHhYUjVuMHIxaEVLK3F5Uk9NbTl4?=
 =?utf-8?B?anA5bW1CS25QTXFQYi9WdHBuTTVEbUhENGEzWG9LWjVEUzBHM3dtWTJMZTBE?=
 =?utf-8?B?V01vTmZlQVhLVkl6OFJ1WTlWWWg3RFE2WFpqQm9YTEdpemlzNUJVMWdHZGRo?=
 =?utf-8?B?WU1GQWxUOWh6R0h0M2ZiTmg4TU5QVm50QXRVK2ZHcjV3RXZyd04wbnA5ZFJM?=
 =?utf-8?B?U1MycEpkNmhTSStrSW5ZcW5icVU5SitqYUpLY0N4QU10MlVCNy9lbVVXbXFp?=
 =?utf-8?B?dzlQRnNsc3JvS0NIRlo1ZlAzSTZOc1dEaWJ4WEdoRnc5ZWYrQ3E5SHcwMFdB?=
 =?utf-8?B?TDNMRzJyRW0vQzNCcGxTRitFeDd0bGRNWDNQTHlLTE5iWGpQOFVWNkdTbG9O?=
 =?utf-8?B?MWYwM2R3RHhCN3dINmNKbmZtbmtuWXNYN2ZkYmQ0aHlHUVZvZGlBaWRHRTZn?=
 =?utf-8?B?dWIrcFIwa3dETXZKV1hhVWMxYkpaNlhEVjZpVWZmUzBSV00yVkdJUjczWFBU?=
 =?utf-8?B?ek1Kdlk4YWVobFdUVVo5NjhxdW5UQVZjTHlKaXU3MW5STHcxcWY2aWJOT3NP?=
 =?utf-8?B?RUZPKzVCd2xTaUZzMEZtY0JOUm41LzZ4YStCMXhFVjM1VitJWWR5N2hOTkV1?=
 =?utf-8?B?WlVhbU1QWE5qSlNjdElOZVMvRnhpc0t2VjRqQjVwQzNqczlLQ3dkblFnS2gz?=
 =?utf-8?B?WFlJSHlOL0tRZHByNGhxNG1WNzBoSFZYODM2QWY1eUpvT1lhMFZMRkk2Z3pY?=
 =?utf-8?B?QnFHWWorR3g0RVEvUk9CaGRWM0tsakR0TnlRTXdkV0ZGWDE2bTlBQWNzL2F4?=
 =?utf-8?B?cllKU05MU3Y2TTUxNjltQ0cySUNmUDcvalJ1SkdZVXI1SFdSM0xBMi8vUG9x?=
 =?utf-8?B?VUNtTkp6L0RRTWI3Z2Y2czVIU3lCelhielpPejRFM21QRGxOSjROYnk3OUJk?=
 =?utf-8?B?OEpFemFJdFVKWTBYbVVDa294d2lDWHJOQTFLWVA2bmZ3Y0VVdzNDNVJrZjdO?=
 =?utf-8?B?bVBpM0pHampUOHg5bi9ySTU2SnFiUzlFalZKSHU1aDlVdWVHRTdDY21lWDAy?=
 =?utf-8?B?bTRqY0d5VDE3dDBUSFdaQUtHdXRzSkZ3WTlvQ3Q3NjZNL0dXYnhoS2hHYkZp?=
 =?utf-8?B?ZmZhMi9ZZGdqa2p5K3o4cDdHTGcvWnVhL21Vb1R6SnZNV0FIL1c1NWl3bDJH?=
 =?utf-8?B?aGw3dzViSDYwWDZqcHkzZjV4ZDlZN0V5SW5aUzJhcEQ0Ty9zVk5TZnViQ3dT?=
 =?utf-8?Q?NNri1h96+7yfkII8VXlWCQkWFxNyw931y8izg7y5UFB3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bcab15-4864-455d-8da1-08dc8fda1662
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:03:22.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TWihs5DM9IcP7MNzZ8mprUimPC86d+AusVnqLZbH2QL3s75IbJ02u+noI492mzS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

Hi Reinette,

On 6/13/24 19:56, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/24/24 5:23 AM, Babu Moger wrote:
>> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
>> Bits Description
>> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>>       Monitoring Counter ID + 1
>>
>> The feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v4: Removed resctrl_arch_has_abmc(). Added all the code inline. We dont
>>      need to separate this as arch code.
>>
>> v3: Removed changes related to mon_features.
>>      Moved rdt_cpu_has to core.c and added new function
>> resctrl_arch_has_abmc.
>>      Also moved the fields mbm_assign_capable and mbm_assign_cntrs to
>>      rdt_resource. (James)
>>
>> v2: Changed the field name to mbm_assign_capable from abmc_capable.
>> ---
>>   arch/x86/kernel/cpu/resctrl/monitor.c | 14 ++++++++++++++
>>   include/linux/resctrl.h               |  4 ++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index b35d04fc761b..1602b58ba23d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1066,6 +1066,20 @@ int __init rdt_get_mon_l3_config(struct
>> rdt_resource *r)
>>               mbm_local_event.configurable = true;
>>               mbm_config_rftype_init("mbm_local_bytes_config");
>>           }
>> +
>> +        if (rdt_cpu_has(X86_FEATURE_ABMC)) {
>> +            r->abmc_capable = true;
>> +            /*
>> +             * Query CPUID_Fn80000020_EBX_x05 for number of
>> +             * ABMC counters
>> +             */
>> +            cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>> +            r->mon.num_cntrs = (ebx & 0xFFFF) + 1;
>> +            if (r->mon.num_cntrs > 64) {
>> +                WARN(1, "Cannot support more than 64 ABMC counters\n");
> 
> if (WARN_ON(...))

Sure..

> 
>> +                r->mon.num_cntrs = 64;
>> +            }
>> +        }
>>       }
>>         l3_mon_evt_init(r);
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index bf99eb9c6ce4..24087e6efbb6 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -153,10 +153,12 @@ struct resctrl_schema;
>>   /**
>>    * struct resctrl_mon - Monitoring related data
>>    * @num_rmid:        Number of RMIDs available
>> + * @num_cntrs:        Maximum number of abmc counters
> 
> Maximum implies some limit and it is not clear what limit this applies to.
> Can this just be "Number of monitoring counters".

Sure.
> 
> Thinking ahead ... when switching between different "MBM modes" it
> may be that one mode has a different number of counters than the other.
> Since "ABMC" is just one mode it does not seem appropriate to
> connect the "num_cntrs" property to ABMC.

Ok

> 
> 
>>    * @evt_list:        List of monitoring events
>>    */
>>   struct resctrl_mon {
>>       int            num_rmid;
>> +    int            num_cntrs;
>>       struct list_head    evt_list;
>>   };
>>   @@ -177,6 +179,7 @@ struct resctrl_mon {
>>    * @parse_ctrlval:    Per resource function pointer to parse control
>> values
>>    * @fflags:        flags to choose base and info files
>>    * @cdp_capable:    Is the CDP feature available on this resource
>> + * @abmc_capable:    Is system capable of supporting monitor assignment?
>>    */
>>   struct rdt_resource {
>>       int            rid;
>> @@ -196,6 +199,7 @@ struct rdt_resource {
>>                            struct rdt_domain *d);
>>       unsigned long        fflags;
>>       bool            cdp_capable;
>> +    bool            abmc_capable;
> 
> Shouldn't abmc_capable be a property of the new struct resctrl_mon?

Sure. We can move it to resctrl_mon.

> 
>>   };
>>     /**
> 
> Reinette
> 

-- 
Thanks
Babu Moger

