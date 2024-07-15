Return-Path: <linux-kernel+bounces-252964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D793931A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6780B1C21738
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51807D07D;
	Mon, 15 Jul 2024 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0nbhtwGI"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82353B7A8;
	Mon, 15 Jul 2024 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721070358; cv=fail; b=S5o0+afcMtnl9h3z8SRLfx+NbCjSKuJtJBjUzISZzi3u6jX/LZuy1GdHtphMwilnXptLAAZ5XSIowBNvL3V3qwfmioWjKcv+EY75SouhkbMuppGBXD9OYHnFAB6i0rabvjaJ4AwMZwgu8oltuT9KwlryfooleLVc3iLV37tAC8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721070358; c=relaxed/simple;
	bh=eLo73X8pdJB6ImeFA0BK1fwfdiDF6x9M2KiOJhUD4os=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ryv8yvMowsENHHEDF7GBeHFhy2CtQwhIMUQH7CZq+lfl+AidoBq4AqEVE+RdvM5h1mIpBH7WOZf+6rHJNdKS/Dv1tgDXI/515OKmRb2PrrUNKCNlQBpO3loBJnlEoR5uRFNQOU8e2ObcJL8oiKUl3cBDEjsS36/j0FP52xXvl60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0nbhtwGI; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUfzPoyBl0fIy5VjXLNZ3ok0ogHbE3e75KyU9Ui956gKCUo6opNfhH9DCJFRdwVpbKu5n82eDZNdrizChsak2LkZWbAtmmLt7qFd9zn0pLhKEnGSOS2cMQVSyTRzuz5Rc6euhWFaD6THhvNwWZfdp2/JPlX3WDPzKJYqQjIIiw3TuVCFlTglbAlclu17B9kQR3JVyoMIqt7378Hl6eLeMkCVpM0Y9wWkbSPzK70e7bl/Yncp+IVBfjUSgZon8aT2bZyCtjFHLFTfanpW+q66CUZ2aIwO853BJL9sCe38Sa3O4oEyvvspe6cEYbD8Ydxfk2A0FrQAAxkCQcWQRZXDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9LLak0TWAfapB0AZsyB+EGkvDIoPcb03xUJzKu1ei8=;
 b=iZaRUQWpISFoH6gY2zL3Hrcss94H3LnJ7AG/9zZD/H5tZpZkeeUSfJSDgsQ+/++vXnUK6h/jLHMNVCi1ogPA1itcZS/uCUCLw7rC8p0PxLofQJiNwACSDjdR1h+u5g8wCJuclckN7Hb7dwXNT03BmA1IARKZncn0a3ihZlIFMmfCh/u6757piL7bv25a0PEuygCSpV3S7x4rq4oG6LZLjeXIDkJb2+b/8cJaxxefMT7LiP6qRsDdT/VGdami9O9D+u/CgEZ/+eoFBpdQOg/1Nxm4Ffxps9UT4TRWLpKF3+aVb/s9ttQG7mHGLXl+Eg/YRe8y+ka+mWl4FTt8RruxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9LLak0TWAfapB0AZsyB+EGkvDIoPcb03xUJzKu1ei8=;
 b=0nbhtwGIXtVA6QxPPPU4NTUywN1vll2O4ikOkxCFNC5ktxGNdErdE6BdT+U3Gi4m49A0UteaWfkTRcmvcty9W4FkqZJv6aTneKd5PL/kdXWqt3rbA3Qw27Qw2sdMA5PiW9CySsirAT/c2SanTgrwpTzaIpC5ZIILPfx7sHb1SlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 19:05:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 19:05:52 +0000
Message-ID: <07216753-8b36-46e3-ae39-31bedb50fc0b@amd.com>
Date: Mon, 15 Jul 2024 14:05:47 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 03/20] x86/resctrl: Consolidate monitoring related data
 from rdt_resource
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <29280097cecb6a4717d7e8a19249c9790684f67f.1720043311.git.babu.moger@amd.com>
 <7868eaf0-8e06-4a53-a29c-c057ada46bdc@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <7868eaf0-8e06-4a53-a29c-c057ada46bdc@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 63934ad4-2b7c-497b-dde7-08dca5012541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHZSNmhZbDVNTWhxMkVhc25QK3ZBbTBJeE0vUUFFc1FtSnloSEh5ZFBsWlVW?=
 =?utf-8?B?bWQvTWczdC9YUmg3ZG51NnZXLzM0T01PTXd6WXZaWjhUNWErUW51SmFZeWx4?=
 =?utf-8?B?TXVzb3hrbElmc2FjR2VoZ0JFWkFGL2JBTk9UakVpdklqc3VkRlMzTG9qNHRo?=
 =?utf-8?B?YzhJa08rZm1CNlIwUFY5b0pZSzZMMFBiMGlCZyt5MytlL0grZ1BnTDlaTERU?=
 =?utf-8?B?Wi9udmtsclpYa0RteVg4eUdHNWZySTRrZzFBQVRPSHQwN2daeGJJQjVMYWtQ?=
 =?utf-8?B?VlZvM0p2RHhYQkdtV1JpNVQ5WTZ6VlNYZmRLVUxKZEZkOGZnRytSZlZScG9D?=
 =?utf-8?B?eUFNUitYZ3BjQXcrejJULytpNlVMbG82dmtaR2VsWmtrK2gxSUVvSkhkN3Zu?=
 =?utf-8?B?RXlsbTB4YWNZMStuQUFFaUZiQlBHVWg0M2FWOWN0ZldoRFQwMHIrcVk0Z2ZU?=
 =?utf-8?B?NzhmR2NPb3hRQkJmTHBTdE12L0J0MExSa3dEbElncitHZXVnaUhSZGQ1WE5W?=
 =?utf-8?B?MFI0eWs2VFNYTjhjN2RqVUgxZDZnWUNQVGpNQktNZFNxaVU1WFJNTmcvSGlq?=
 =?utf-8?B?QVord1ZCVjF3azR4djBsTEl2bEpOUUdJRVhFUTYzVVFxUGlNTHVzRFd4TExH?=
 =?utf-8?B?d1hKZVdUdFR0OFZQNUNZcGNBL3dHVTdjK0ptcG95Q1NkL21BTlg2TnVzNUhJ?=
 =?utf-8?B?UmtOOE9WdDJmVStsOEowc2h2YTc5dW4vd2JNNzJCcW1wMENrL2hkREZ3RWYw?=
 =?utf-8?B?WDBPRWM2Tm1hajVIL2M1anJvdWI1bkZUa1czekxBTmMrYW9KejRBS090UmZN?=
 =?utf-8?B?OVpsV2d0NkhWeG1sanFYdTlCQ20yQkIra05iQUd1V0ZLRHdKaklKc2RiZWNF?=
 =?utf-8?B?SmJ2VFpRN0VGNTAxeE9zd2ZCRGdkWC9seDNtbExnQUdUbnB4M0VuR012dDdh?=
 =?utf-8?B?a3ZBVmpCRGM0emlZRTlGbjUzQjdrWjhPYWRwOXRwSUVScFdCUWdITm5QVnIz?=
 =?utf-8?B?ZmJOQlMrZG1xTEErZ2RqdjdoRGlranRFQ3FRb3RYN09vSEhKYWNiVmU2YmUy?=
 =?utf-8?B?OVlvUUtNY1Q2VllJZ0lNR3ZYK1pRaG1MVWlzOFk0VWg5czJ2L28zRG5yNlRt?=
 =?utf-8?B?STdFWURXWHRaNzBQWGxBSEd5c3RvdVFucU0zNnRvTmJBZFNveHNnQnllTkNN?=
 =?utf-8?B?VzArSzFxRjRiV2dUSEphQW1OUUpQTFcxZ0Vlajd4Q1BwYVNtbWd2SFNKUFkx?=
 =?utf-8?B?azVYR0ZHK1NIbm5XcnM0dXNLSmlJSytWR094ekdyZjVzZllMdW1QWXdQdWNo?=
 =?utf-8?B?L3FSU25seWpTRjhDeEllaEx3dVg4YXJMZUs1L1EzYk5yVklVeXU4QU1zT1Z1?=
 =?utf-8?B?TGZaenA2ZU5GVjVhMEd5TXl5dmdxZ2tGVlR1c3Rqdm5CQTJwbTl6ZnFBaFZm?=
 =?utf-8?B?OHRrdit6MStUQVdZaXZwSE84MTkzVUFLekxGYmwrVVJSZitFQ0RNUHp5OGU1?=
 =?utf-8?B?TjFWVDhYT0hyQlB5eUtrZFpZUjc2cnRXUTI4cGJMWENIUC8wY0NPYXorOWQw?=
 =?utf-8?B?alpQUnBXbFhMTkppZ2l2SUFIR056dnJIbDlPZVJwMG1sZDBWam80OTNGdkhZ?=
 =?utf-8?B?QkFxbCsyVU5YVm1kWnMvSzIyemE5aGt1amFJcDg0ZUpkTnlSVE02ODNDSTRR?=
 =?utf-8?B?RzUyMWNyUjh5NnlTc2dsQjRITmpBS2N4WFFzTkRSc1hRQVBEbjNmY01yS3Bj?=
 =?utf-8?B?WlZnUUJHbEJ3YVBPZmVoNTFFN1YzOXJ6N2lxVm9yZ0tSdVZNcFdZaVVFZE5m?=
 =?utf-8?B?bkhjKys0N1h0WHBRTEg2UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVhYNVMySitVMmUzRWx5N0Y3T2s2RmVGSk9Ddm5aVXM2T3pMRlBObHc4bEwy?=
 =?utf-8?B?ck9oVDREdWdCelcwcENEdXlFaG5TbFpUQWxwZFJ4WStyL0lkTlozMDFNUm1H?=
 =?utf-8?B?SmUrMzg2amVROEYrVnFYTlBONzB2d3ZsR3F4akdOamFEVkFqWUpvK3V6WC9i?=
 =?utf-8?B?WUhsdEduYkxMZy83MGFOYlRmTVNFRGlLc3R3S0c2OUNtMUlKTTY1d2NQay83?=
 =?utf-8?B?SUdzcGY5MnJ3b25RL2VyQjdNZ2xteFJtdi85R00rWlF5UTVKSE8yVU5QaGxq?=
 =?utf-8?B?ODRGRU5RTmZjM1llQzZvTHRxdGlpdEpMTXl4L0pEOVFxclgzTm9rNENlMHhE?=
 =?utf-8?B?MWRlL3RuYm8zeWdmdTRxb0M0a2phOW1JU0o2VXp0cm1JNjlxMUcyM0tFbHdI?=
 =?utf-8?B?NnNjWlh3empZTW5ka0s2RFZVTnZ5UjJTZmVyZlFKTHVTOFlJeDJYb09QYWtE?=
 =?utf-8?B?MFBETTI2eldDWFBidGpYbmtDTktEUkNEWmtvRHYrSjFPUkJNYTNMOUhxdGEr?=
 =?utf-8?B?SG4xekJlTjV0eEFEVS8xTGp6c2d0dXpCT1ZnYUpEempjc1VMQTlRNlp0WVFa?=
 =?utf-8?B?bmY0d3ZEdjl1TDRLa0c1WjFwbmpnbmRzOVYrVFptcnVOazM1UjBnV2grM3By?=
 =?utf-8?B?Q0lVT0FISktvRDBpT0tTK2RIZ1pjUU9zTHdXL1JFQ09ZWVJ5cmFpckwzQTVQ?=
 =?utf-8?B?akZ5bkFESlA4V0tKWHVPNElIRmdOaVdUUUYzQVBHbEtYMUorK3dKWGZGM01v?=
 =?utf-8?B?UlVGT3BrdXE0cG44ZDdBSXBrTzRVTjhzR0ZMaWFZeTgvUzEwYVEwV0g3SWRZ?=
 =?utf-8?B?RzdaN1dubU1SSnY4aEptQ2M1elBXVUc5RnZKYkVMS3RsR1p5TExTMUhiZXBX?=
 =?utf-8?B?UkxlUnJqM2RCNThoRUNLQlBhYm5nSnkzU2hMS0hvd0dpd1VST1hBdm8xRStB?=
 =?utf-8?B?Y2pRMGtVU003R2xoa1laakljRmpGbUZ0RkJtd2RYejlVejd5ZGdQUWNjSXVW?=
 =?utf-8?B?Zm9VUXhKSkRZd0QzZUtsZU9LTlY4bjRWL3czQWhUbzBDcTZvRXlFOCtTZUJH?=
 =?utf-8?B?RlA5cUVKcGFHc2hvVGtmdmw5TVBLWXRBaURlQkVUNlFLMXpPTUJ6MXE3aFhG?=
 =?utf-8?B?WjRGZFNrTDNGQjlIUnc4cHJCYW11a0JuRjFqV1ZiQTJvcmNFOUkyMGgrcE9M?=
 =?utf-8?B?c0ZBNTNsUjhYRlZOUlBQYnNudlIzLzl4ZFdCN1RxTmFFN1dmNlFaNnJTUkho?=
 =?utf-8?B?MVRLSDNzYitEbFUzeHU0K2s0UlF4VmhzMVhlQlFtdEx4Vm5pZ3lSdENNOU4x?=
 =?utf-8?B?OWtTY2JnQTdIbGN1YTA4azUrcmhqU3ZnQXB2NVB2L3lpUis2ZmRiSWlFUnRz?=
 =?utf-8?B?S0ozUW1XS1gyaXJFcXFGNWtsR3I1S0IrZjBmS2lnQUVpMWsxMWFLT0tJMkM2?=
 =?utf-8?B?c3VHQldzUlExbUs5Z0I0TG5PdlNOL2UyQnlVZE4zTll6L2R5bVpHdm5BWCth?=
 =?utf-8?B?RkRkVGRUSmNxYmZ0M0RJSTJabkljd2l1UDdIOGxHbVMydzMxeDlVdlhXcHA0?=
 =?utf-8?B?VlhCZ1RwK2xqeWZwaEV2WnJrQWQ3TDZPYnR1RlVUZkhjSTdRTjdhcVVDK2tF?=
 =?utf-8?B?UHk2d3RGeTF6aGVPYm5yS3pOK28venN5a0tlU0NpYytFYUZFazlkVTBuemZs?=
 =?utf-8?B?SG5MOHp6ZlJlV0JPYlFQUnh1MWdDeTIvaVhvYk1jM0JDckJOeTVsMmJDZ0Z6?=
 =?utf-8?B?WUVlYWJndjZkYW4zN2tJVEFacjk3OTJDY2ZlSGpTeUl0eTJlVlNrZDNYOXVJ?=
 =?utf-8?B?MmthQitJTG03N1hGZXhPa1RGK1p4TzB4TjJVQnFqYTJPRk9UZmhzdm1jQ3ZO?=
 =?utf-8?B?cStQdG1KNXdOK0ZSV3dpNGxFV2VWMVJkVEFzWXRKR0l6d29VTkVNZ3FQWndx?=
 =?utf-8?B?UmpmV2JwRWtLV1NsbThHT3gvVnVxS2MvU0w5djYyUDZxcURVOGh6bzd2NnFj?=
 =?utf-8?B?Ly9rZkNZYUdYa0s2VWlRSFRTUE9Hd0hudHFHTkdNNm93ell1SnBZVndWbkF2?=
 =?utf-8?B?MzB5V1p2SHpQbTlsdGJVL1BySS9CRFJZRXMzVFc5TU8wa2RyTnRSM09UMmVn?=
 =?utf-8?Q?+Q4Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63934ad4-2b7c-497b-dde7-08dca5012541
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 19:05:52.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IG3R6Zt5VhGB5cX5WDoTdtq6Ex3pxFiZfnGKiH9gaCxZSLfx86ujbnC/7dvWT1zv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353

Hi Reinette,

On 7/12/24 16:57, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> The cache allocation and memory bandwidth allocation feature properties
>> are consolidated into cache and membw structures respectively. In
> 
> Let "In preparation ... " start a new paragraph.
> 
> Quoting Documentation/process/maintainer-tip.rst:
>     It's also useful to structure the changelog into several paragraphs
>     and not lump everything together into a single one. A good structure
>     is to explain the context, the problem and the solution in separate
>     paragraphs and this order.

Ok. Sure,
> 
>> preparation for more monitoring properties that will clobber the existing
>> resource struct more, re-organize the monitoring specific properties into
>> separate structure.
> 
> "re-organize the monitoring specific properties into separate structure" ->
> "re-organize the monitoring specific properties to also be in a separate
> structure."

Sure.
> 
>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index b0875b99e811..e43fc5bb5a3a 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -182,6 +182,16 @@ enum resctrl_scope {
>>       RESCTRL_L3_NODE,
>>   };
>>   +/**
>> + * struct resctrl_mon - Monitoring related data
>> + * @num_rmid:        Number of RMIDs available
>> + * @evt_list:        List of monitoring events
>> + */
>> +struct resctrl_mon {
>> +    int            num_rmid;
>> +    struct list_head    evt_list;
>> +};
>> +
>>   /**
>>    * struct rdt_resource - attributes of a resctrl resource
>>    * @rid:        The index of the resource
>> @@ -207,11 +217,11 @@ struct rdt_resource {
>>       int            rid;
>>       bool            alloc_capable;
>>       bool            mon_capable;
>> -    int            num_rmid;
>>       enum resctrl_scope    ctrl_scope;
>>       enum resctrl_scope    mon_scope;
>>       struct resctrl_cache    cache;
>>       struct resctrl_membw    membw;
>> +    struct resctrl_mon    mon;
>>       struct list_head    ctrl_domains;
>>       struct list_head    mon_domains;
>>       char            *name;
>> @@ -221,7 +231,6 @@ struct rdt_resource {
>>       int            (*parse_ctrlval)(struct rdt_parse_data *data,
>>                            struct resctrl_schema *s,
>>                            struct rdt_ctrl_domain *d);
>> -    struct list_head    evt_list;
>>       unsigned long        fflags;
>>       bool            cdp_capable;
>>   };
> 
> struct rdt_resource's kernel-doc still refers to the members
> removed in this patch. Its kernel-doc also needs an update for the new
> member added.

Yea. My bad. Will correct it.

-- 
Thanks
Babu Moger

