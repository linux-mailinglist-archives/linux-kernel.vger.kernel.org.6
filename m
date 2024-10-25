Return-Path: <linux-kernel+bounces-381053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E669AF9A2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319D4282A00
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF7D192587;
	Fri, 25 Oct 2024 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yMnre3wr"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437F818C92C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836725; cv=fail; b=MbdTMNWBcLWnRGC3T1IF3utljugcN7zw/FpiSt2cKXijsvMP6eHKuL/IVWBsU0w2Sinipe8DikLKPLN4ZfZJRZ+YFhWOz029iaRlBSWwmw8MsJ/yTN/lsMDT8gPwqtzGfmuxn0PkTmt1M8V16gJdzFx+gWGxPBewWBT6Ay7Lh1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836725; c=relaxed/simple;
	bh=RRQKNHyLSatwk+JXfZcZLSP/8Ai6AhCwm/Pjcq30D4M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H273QUAswcEyCTnZWg8q7kF/uWChnHFRj/Wm10MqGjCV22YW0q02H2ir+FwTb2Adnfi3/cydx244uvn/f9fPW2Qz4fd1Wd39icJITzlL6K4Dkns127KwdhzLZxEI9uhYNBPYwwf4CZKZTJGMO3S8K7w47BkSG44adHN3kAhwGqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yMnre3wr; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o49oAfr6DzMbVXaHBoIDrdJcGuUgjr8KugruWGAGtBUpncg9qZmWZIZqHhx7o0B4pZkrQOxm4JSEq9CW7n20ty5V72hRTuSlfPOeqIOeiWevZsrvS1YxrbjulQqfoumg+AgVQYava8yP0yqcA04TTM7cRNMUiy6SHNjYIRMOTLr/V2U5XyxeQJQ94RFRLjNTBl9PC6thK02Rh12fNm2VSPgUaEdm6XaswiV8YZRjdo+MMLiSBuIxHeN/C7feZS4YZJsbTHHI27QMTapGeja+YhPgBau11Skbb3o5JGU7aftNw1pGDJZqY8SkVJhONYEX2+e9RraVHNQt8IvhDsl3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERCKgGi6yYOwtDcw5u9/HPUsZjL69aqMLYn0X5zGL80=;
 b=Q7OUKenUVbav6KmZzdW71B+hzCszhFYVnxTeIS9CfsNuzGMv1A8LdQNc+EdAz6YD8tXU4CykNdmBYHZympg4JAc2BkvaIVOTImyVnlPo5NncYIQl3280NFBoSVezntwIuc/13c39XIaKA7Dhhjw/ywYF6cpyCN8EHtKiUVMVwtDy/LxcGXFBDGav9MjpkdhoWqdR0IXDVNTlndezZ8HZAta4gjAZP6XfcLLVgfK6Gv3KZw56mQ08qsazLwIsyNKZ+VJ5ET6l1RjHJD6t5fCRcFNq1CE8qNbbO1lmGGyyRT4GnEuC+vnQpAaF+jbWpC9cmU3Vn+UeRePdXhvIjrM4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERCKgGi6yYOwtDcw5u9/HPUsZjL69aqMLYn0X5zGL80=;
 b=yMnre3wrwWV26pvQzJaaCT/I9+LTIqZM+wSmCKX4xwT1v8zpC+AJqRj5SE8lB57IYhrNX14k86tBwqpuLj6o/qvp+V5mypTv4wFiyWo/12YH/ZXI/E906g73z4HCSL1AAU2S+VkVbKRGAMYvouv0aVsjCH9R7xum/xy9Y8n50fE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 25 Oct
 2024 06:11:58 +0000
Received: from CY5PR12MB6599.namprd12.prod.outlook.com
 ([fe80::e369:4d69:ab4:1ba0]) by CY5PR12MB6599.namprd12.prod.outlook.com
 ([fe80::e369:4d69:ab4:1ba0%5]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 06:11:58 +0000
Message-ID: <0d36f8a0-dff8-426a-a223-bfe344e84561@amd.com>
Date: Fri, 25 Oct 2024 11:41:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Provide support for RMPREAD and a segmented RMP
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <cover.1729708922.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::24) To CY5PR12MB6599.namprd12.prod.outlook.com
 (2603:10b6:930:41::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6599:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: a669b831-c55b-4c52-c576-08dcf4bbeee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGRXRnNIU21UQ1BXelpxQWp4blZLVVVZMkluMXpueW03NGtoRU9zZ0o4MklB?=
 =?utf-8?B?UEtMYlJpaHgxb1lkT2tTVWFlK0JPdVlCRk9peEFLSGFGaW5wQkZpbytMdFlV?=
 =?utf-8?B?Kzd3aFQ4aGZPZWRudHF5TmlMRWNpMk5VZy9pMFNuSmt0WW9RTWhmeFVLOW56?=
 =?utf-8?B?Z09FZXFXd3VCK2lzaU5WL0orNlF4RzIwdncyNXl0MG5rcHYwcTBXclRLRXNF?=
 =?utf-8?B?dmZkQmNEbU1QRXo0MEJoWm1lRXNUQllBbXlCYU9VSStDZEg2NlMyYlV5WWtX?=
 =?utf-8?B?T1JJSGJhWjJPUWNueHdVYXlzazN2YzdHY1JPcTRQRWFpcVg1ajBzL0dDUSt1?=
 =?utf-8?B?WXE3djRaNDV3ek5lQXZPdlo2SXk4ZS92U1NwaUVYbm44MGdZZk0zNnppcHk2?=
 =?utf-8?B?Z3k4QThOaXNMd2pWMWVpVlJHbm9Jc1g2WmVuOXFrTFIrYy9vVUNNWjhDNEdF?=
 =?utf-8?B?NmE5WmhKVUZjSFRmMDFvNWNvWWhDd1Bmd2pGYU5xdHBnMEY2Z1pTUU9nc2tm?=
 =?utf-8?B?T2FsblhUeFI3NjBraWxvUkxOY1RyWlJxcm5hajUxeUt6Y2xacG4rQmsrSHFR?=
 =?utf-8?B?M1RHZFNOcEMvdkFwUFNiRElzR1JFWjlZQ3RpU2l0Z2E0eFIxNHUzbnZtNzhr?=
 =?utf-8?B?N2t3a1pJUU4zMHZDSUk4bkozQkZyK3JSM0ZuK29jclV6RUIxcUE3QWdzYktN?=
 =?utf-8?B?cW5zejBPa211SkhuYjlDL2laT2pGZ085dkYzWUE5cGNXMGk2ZjR1TmNzYTBn?=
 =?utf-8?B?K2xMM1NRbkpWanpmN0pzRC92VHZUM2w1aHZGdmh6WTMycnJlaHVqTUVzOU1v?=
 =?utf-8?B?YXNjRmMwcnFWUWdleWtPOWlGVlFLYTltRVpLdTJaTVNjeVVKQnV1b2x6YkFR?=
 =?utf-8?B?dEYzWDFRdElYclh6MXVzYkREc2RJYVl6R3RCWWFPY1F4NzJ1cmhkeWFpWmRN?=
 =?utf-8?B?MUZrMkprbmNhcjEyK2pFeU1vUW1nT1hwYk9tdVlPYUsxSUQ1ci9OWlp5dDlW?=
 =?utf-8?B?bnAwUkN2NStDZEp3V0pycUxycWMzd25rcWhnQ3pTREpsNDV2M1ZxajI3bGNk?=
 =?utf-8?B?SlZDaG1pbkxTc0FKSUVNWnNzdjBjSVRXb1VMS25RL1FxaGR4V256S1pNdVBz?=
 =?utf-8?B?RFArSktDTnczand2N2xxVFhOUmxDWVN2cjBBTzNrcFVOUmJOSUZnSFMxdzNy?=
 =?utf-8?B?U09ycE13clllMHdwaFM2VmxDVFhtd0tORTZqaFQ5Z2VTSXdkdzQ5emdTZnRS?=
 =?utf-8?B?TDBqUW9JTlNNbzB3bXRvRklxcURrTUFkTkpYUThvTXVkSWRndUVWaGVqYUFJ?=
 =?utf-8?B?NEZuSmQxWUg3bXU5K0ltNm1VVFNSeWhwZFZyczE5YjZPOWhvSFkvSFRUSTFI?=
 =?utf-8?B?YVBXNlR6WFpIS3lzbXBnQzFQK2pSWG40QzE0VUFiNnRQN3l2TGlPUm1HUnJz?=
 =?utf-8?B?WUdWdWdxMkVqYitMc0R6THlrQXoxMG9hdytGNDJ5M0RiSmRXUHVnWE5UN0ox?=
 =?utf-8?B?d2RKZVJ6Q0o0cnUvM0tnS3A5ZzFmRUZFWGZBQkozVnZ6VFVQYWQyRU9pQWFJ?=
 =?utf-8?B?UWFNYXJVNk4vT2ZueWF6MnllMG4rRHNjSVo0NU9jK3hMMmhGNmpxVDgrU1Nz?=
 =?utf-8?B?UDVvRDE0T3BHeTNEYlJ4SkhoZ2hUeldhYTJvNFQ5TVZWTWhJMGkrbnlPc2ph?=
 =?utf-8?B?TGxSMWZNZExpSHlETWpzdFlsYWpLeDhGVWp5cml5bFNteWFSUE1HRUlrRDBm?=
 =?utf-8?Q?vfXvg43Zuc4qaL6mV4U7AC62u054DhhG6fntSQl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2NaVnlCMWpWM3JQSFBvZXphMjNZVllSSzlSamJDOWdRU2QyM1ovYlUreFpX?=
 =?utf-8?B?bzFiRlNUUWZybGJxcDFURTk5bGY1VkR6VThxSndybXhSelFJcUp4ODF6RXlm?=
 =?utf-8?B?SUUyK09TNnQ3UW9KUzVVK2IzVFIxQmplV1FMOE0zU2k0WlZSd2hqZjVWY2xj?=
 =?utf-8?B?OGxzSUo1b3hmY3pJL1JXVlpjL3luTjRVOEt0cTBNZWV6alpHNWdDcysweitU?=
 =?utf-8?B?bVA5OUtxUEpreGZBa2NETnFiei8xWGE4dzNzejZRMzV2NGxyRkFPVWw2K1RS?=
 =?utf-8?B?NWptNUE5VXFBcmNKSGYzTU9jSSthSXpjS2E1WVczSlJoalovc2g0Mis3RUJH?=
 =?utf-8?B?Z3o2aWtyMUxIQjQxSEdiM3B4OHdSQzNpd1RkbWdZd1d3dW5Sc0JsdlpvcGpD?=
 =?utf-8?B?NHNhb0FlV280ZlJ6M05LcHI1d1FTUkVWb1ltbVVjL2FKWlQrWSt6L1BMVFls?=
 =?utf-8?B?UkMrRHJBMW5JUHg2cjlYQUJKZUVReTlHVFRmQ1JOQ1M0M1FNM2tKN0tkdmlV?=
 =?utf-8?B?WVRqbzhvYnBXK1kzZjFLU2JFQVBtaERwKzFwYnJzc2hqOS94T21qa29JL00y?=
 =?utf-8?B?MVpjYWV2alFTWmo4QldyRkFKcnJwZHcvMldqSDV3VHBxSE5Ma0dJdTZtcnZv?=
 =?utf-8?B?ZENjRlZZMCt1Q2cxN0tNTTk5R0pIcEk4ejFLYURMZjU2ZU9BVkJ1Z01uVExN?=
 =?utf-8?B?aDZsWmVRNC9OdXVJY0lHZStqeHBMTXdwaXlLWTM3RTNGRjYzVjVka28zOEVa?=
 =?utf-8?B?OGZVdHRScXlMVC8yRk5RM3pzYVVjSWlUb2VUSnNhUElFUlZhcG51Q01mbnJi?=
 =?utf-8?B?WGxIUEV4WVdFWmg4U0ZLUVlPVWJGd3daekNMUHY5dDh5VTQyOWJGVTh5L2ds?=
 =?utf-8?B?YXhjUDdrY3I1VHl2YjhMbUpYUEcvc04waTIrL2RidFYrWlIwNHBnVnZIOTMy?=
 =?utf-8?B?UGRwckhQdGEyYm9uRVgzMmZ1WW1sUkdWR3hDbzV5WjZxQVluLzZnaWNYNlA2?=
 =?utf-8?B?bWxTVitUdFBqWkdkdUJDL0RmSmxuc1JsVnRPVEFkdm00VUdkeWRDTU1wV251?=
 =?utf-8?B?QXdTVUcrMU5PWitTd0FYQ1NTcWJmRFFSWmVKWmZGWUFkckZnN2FVRlF3VVVy?=
 =?utf-8?B?amJSN015Qm9NR0Vkb0htS0ZPSWl6d1pseXkzbGtrMUFXR2VuVkM1VHAyKys0?=
 =?utf-8?B?QzYyWDJxRnVMRDNGdXlwV2xZNG16WnZvMGJCeXA4em1aRXI3bTFCTWhpVys5?=
 =?utf-8?B?OGZocTVjWndTU3p5anQwc2xsZnlKMWpZNTdnY0pnbEhWbkpZUG1YdTIvdGxB?=
 =?utf-8?B?WlpBM3h4Wnd2VmVwSUV3RXhDMG1aZ1ZhTXVkRDhocXBpUWVyTFZiMk96R3gy?=
 =?utf-8?B?ZXBYMGVRWXowc21EZFhEa1RhYitONWQ1blFZb2NBUmZIYTB4eGluQURHelFr?=
 =?utf-8?B?bGNqNStTWjRqK1dvVXc5cFM1c1JoMGJvcGhNUS9jTERVdzBMMFdzT1IrSURX?=
 =?utf-8?B?V0RJVzQ1RjY2K3JYQW54SlN5UmZjdFpVTTZpcTBsM3BaTXp5SzVhYmhIWnJ2?=
 =?utf-8?B?UnhXQ3BXcVlBNjB3clVrejEvY2VOWC92eTl2QmVDcDdDeUg3Tm1PS3VNQ3hP?=
 =?utf-8?B?d2Z0OWVMdFVLUTF6cDVzN0pXSEJvamVicmwyR2RmTU9jLy9iZWNRdm1hRno0?=
 =?utf-8?B?R1VtQU8rblBrZUVNMnMwQjAxcWd0cEl3VlNyQ200U1RQSm85bTRNNVNVZ3l5?=
 =?utf-8?B?bGhlL250Nm9VWitFUnhPZXNYVU01TUNzQnhWUUZnK3dXanVmbVFVeUREb1pO?=
 =?utf-8?B?Tlh1R2RCOEhiWVdxL0JOaDVFbkMzZDhtSHZRTEpzcm5sa3NmajJZSFVtUXJN?=
 =?utf-8?B?b1VDRE9GYWVZV21TeXBrNXBhdDFnaXZiZHdueHp2L1lSM2Joa1lOZ1M2eWdG?=
 =?utf-8?B?NXpIMFhZMlUxWjN1Q0RDbEdlekJnYnFWckV1OFlaMXRVamExWnhyKy9reU9P?=
 =?utf-8?B?WVFjTnk5S3FvajQrTmQwQVFpSXNnNkFFbjFlRTRFbFN5a1FrMkNFUllnd1Ew?=
 =?utf-8?B?S2MyUU5WWkJibTZIOWFUQVkrQzM1SEJGUHZ2ZEFwVkJsOE41Ykh6dTV1b2hI?=
 =?utf-8?Q?zxq8thA/EB3TxRdpHsvObc2tj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a669b831-c55b-4c52-c576-08dcf4bbeee5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 06:11:58.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHS/0VtWm4UTLucs4RdPFK8ePfBvH01Q0uzenj8Y1GmHnSnFvexUpLdVSjk+0yzULjfJiVbznW/pVT2UdPP8lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987



On 10/24/2024 12:11 AM, Tom Lendacky wrote:
> This series adds SEV-SNP support for a new instruction to read an RMP
> entry and for a segmented RMP table.
> 
> The RMPREAD instruction is used to return information related to an RMP
> entry in an architecturally defined format.
> 
> RMPREAD support is detected via CPUID 0x8000001f_EAX[21].
> 
> Segmented RMP support is a new way of representing the layout of an RMP
> table. Initial RMP table support required the RMP table to be contiguous
> in memory. RMP accesses from a NUMA node on which the RMP doesn't reside
> can take longer than accesses from a NUMA node on which the RMP resides.
> Segmented RMP support allows the RMP entries to be located on the same
> node as the memory the RMP is covering, potentially reducing latency
> associated with accessing an RMP entry associated with the memory. Each
> RMP segment covers a specific range of system physical addresses.
> 
> Segmented RMP support is detected and established via CPUID and MSRs.
> 
> CPUID:
>   - 0x8000001f_EAX[23]
>     - Indicates support for segmented RMP
> 
>   - 0x80000025_EAX
>     - [5:0]   : Minimum supported RMP segment size
>     - [11:6]  : Maximum supported RMP segment size
> 
>   - 0x80000025_EBX
>     - [9:0]   : Number of cacheable RMP segment definitions
>     - [10]    : Indicates if the number of cacheable RMP segments is
>                 a hard limit
> 
> MSR:
>   - 0xc0010132 (RMP_BASE)
>     - Is identical to current RMP support
> 
>   - 0xc0010133 (RMP_END)
>     - Should be in reset state if segmented RMP support is active
> 
>       For kernels that do not support segmented RMP, being in reset
>       state allows the kernel to disable SNP support if the non-segmented
>       RMP has not been allocated.
> 
>   - 0xc0010136 (RMP_CFG)
>     - [0]    : Indicates if segmented RMP is enabled
>     - [13:8] : Contains the size of memory covered by an RMP segment
>                (expressed as a power of 2)
> 
> The RMP segment size defined in the RMP_CFG MSR applies to all segments
> of the RMP. Therefore each RMP segment covers a specific range of system
> physical addresses. For example, if the RMP_CFG MSR value is 0x2401, then
> the RMP segment coverage value is 0x24 => 36, meaning the size of memory
> covered by an RMP segment is 64GB (1 << 36). So the first RMP segment
> covers physical addresses from 0 to 0xF_FFFF_FFFF, the second RMP segment
> covers physical addresses from 0x10_0000_0000 to 0x1F_FFFF_FFFF, etc.
> 
> When a segmented RMP is enabled, RMP_BASE points to the RMP bookkeeping
> area as it does today (16K in size). However, instead of RMP entries
> beginning immediately after the bookkeeping area, there is a 4K RMP
> segment table. Each entry in the table is 8-bytes in size:
> 
>   - [19:0]  : Mapped size (in GB)
>               The mapped size can be less than the defined segment size.
>               A value of zero, indicates that no RMP exists for the range
>               of system physical addresses associated with this segment.
>     [51:20] : Segment physical address
>               This address is left shift 20-bits (or just masked when
>               read) to form the physical address of the segment (1MB
>               alignment).
> 
> The series is based off of and tested against the tip tree:
>   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
> 
>   94559bac4d40 ("Merge branch into tip/master: 'x86/sev'")
> 
> ---
> 

For the series:

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


- Neeraj

