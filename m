Return-Path: <linux-kernel+bounces-241181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC89D9277F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE13E1C21BAD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCB71AED5F;
	Thu,  4 Jul 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q4QrAb02"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620001ABC25;
	Thu,  4 Jul 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102415; cv=fail; b=N2EQd7mN91jEzLIW8ZE1qOrZF3sApwwHiYgDArAVvlHzygiL/URzC0r5A3qGcHmibdEtF8jYaX5aasZUO7Lo6Ojh9cNyLxNiKEioYEXWhGWEJU0ShZqbokHbAAmB08m2T13oVRJt2APziEJb4IRMnDCrD+RsA/Yr0u40nXzkxpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102415; c=relaxed/simple;
	bh=DxLj5PcCxxUqTpahGhd5qcAuduru8Md0YkOMheKFG2E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=mnkiJmTywBu/F/aU33ArmWa+Rx6ll+Q5iJKx1VST07EGrPC0/5WR6ATQX6JkQiFuBMLsufF4KlyDV9HPPg6lOeZfHsDlcsDwTXtr4CLsw1RkaKPPPSsmBf2DSr5UMEXaHzYLm2oXwwdJ8SxlfE/ogwXPO+4g6jYUZIL7IzO6eSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q4QrAb02; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSBdu0VJ88lSXAHgB6nf800G0Bg8zYfPLNRle6DJS4o3eMFMguW2vdWM603An77AyuEf00QdMCjLRst78p+57dnzY9DCN3hXrutPam4q8ryJ157l+5yKGvW3PbVCMKuxj+NyIi5foJnQWiPsgXNkOD16BANqiisYikGvRl50YepXRPsO+DZzEEpIrQJXNEWpdkhf7NZ1aygy4cjw/mGb70TRpmWmCBOQHba+8c9FJOqz/jAH9GnfhPio23kxtaFqf/A1hKS0i98Ujgoj4ctSfUE+uAr3Ivl9Bynp+pji/Gls8EEePkLN6pOC9symTBD/HcsYYtfYp5ATvKSSO8MsGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxwSMKgUynDaeRbODAkRxxHXy9RH6VBRmK+Q8GBgLaw=;
 b=N76znxmE+G0740ZmIyXd/Aaymyn5XOr5g1lB8OZNpLoj1vOFylUPlkpmlcPluFTEPs89FYwP09bJSg7ob1OAAw8r+fs8c2ytygjyQTTjX5+CDCr77k/CgkU0smTuKM3ggtq2WI7gTd4avB7FFB+Bggq+M6LxA0nvG9ZiD4gNU5vmNUOY2WzoIlnMuZi+4NpCFpJaLkv4Y3Y8Nk5lpYtex5BpSG2e0Q5Vk5skEqNsNUp+CGE4Q8TOevaoA4US8slUhRnxbEyTQ3OljI69XILkjwuC/XK0ItPlXwUK/BvuxXmHH2If6F5RfjJdzrmCCls3nna3qYZg4Fu3DJHtaxUJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxwSMKgUynDaeRbODAkRxxHXy9RH6VBRmK+Q8GBgLaw=;
 b=q4QrAb02BlFf35AKBScAM9UF5ZB05UGO1FxlCEudP5EDHkMnZ1cqu6tyPPnDm99bGd46ID0d1HLsTOLdEMCnvJFQ5hF22b05x31sAGZHeihJ82CDPkLpnDkYOIigmrlOb2tqa4RBXj0t72sAiJxioOut0G0kNChi8oukFK2FmK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 14:13:26 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%7]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 14:13:25 +0000
Subject: Re: [PATCH 2/6] misc: sbrmi: Add platform device add to create
 platform device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
References: <20240704111624.1583460-1-akshay.gupta@amd.com>
 <20240704111624.1583460-3-akshay.gupta@amd.com>
 <2024070447-cosigner-shanty-fbbd@gregkh>
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
Message-ID: <01c95139-dfeb-6983-77d2-4382ffb50896@amd.com>
Date: Thu, 4 Jul 2024 19:43:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <2024070447-cosigner-shanty-fbbd@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::15) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 32593f37-adbc-4acd-c02b-08dc9c33785d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzhERDBYM2JvaVRSLzV0T2FkUTFSV3A2eXZ2bzljY0lURnR0T0xYL0Nub2Zx?=
 =?utf-8?B?OWgxajYzQkt4dXhTMGlRRU50aXNSRWxOVGtVR0g3ZkhMK09INHJIWit0NVJr?=
 =?utf-8?B?VnR2RkRLd3c5NU1xOGU5dGxQSlhSZGdUWlNqSXc1MGd5K1p3YWtXTmwvVldm?=
 =?utf-8?B?dC9remFsYnkzYUVmYk1BK21CZVFyaVdkZWRRU0xKeDRiUFVzS0J6emowaDM0?=
 =?utf-8?B?UEg1MkJGRGZlVzJuZmJGU0YvVGp6bTBGVFBiUkdocFBqVlVFS0R4SXdZYmFn?=
 =?utf-8?B?Vk1VeGNCWFFBMm4zK0Fxb1g5em9QV2J1VWxUNXpMR0xrK29OZ0tkZTFzQ0NP?=
 =?utf-8?B?SGxGdVFxbDZLQkZCaUp4NEV3NnRCYitBVUJkWGZhTTJ4NkZzL2g0YVEydHJU?=
 =?utf-8?B?bDRxSkpRRWpoNExtNHFyNWxTVEN3OGJnYStaWVFCVm5GRWRDMDFrU0toYkI5?=
 =?utf-8?B?dEdKQ09DM2Ryc2Zlc2JNNGQ1WDF5cDZhSDRaMU1YWk1ITkQvYkhUWnFUVXRt?=
 =?utf-8?B?eC9qdG95N01tMmMxNDlVRGIybU4zQTVGd1RPNUgvK1A4dW9EWFEzQnJmSk1x?=
 =?utf-8?B?ZzlVYnR5clFXYVRLSXhQeXRUYndJWDZNRUh2S1RhbFJqMFVHTUtDV3A1MHhX?=
 =?utf-8?B?c09kOTJpUWkrSUlCZmxxNnNIS0JINFlNTTc3QVZpUFkyeFpFdXRZbWxqRFBv?=
 =?utf-8?B?dVNLZmcvUVdPNUNSQ1hXYWhuV2o5WklHVTY2K2VPaUhUMXBHUU1INkk1Z3B0?=
 =?utf-8?B?cDZ2aDF5c3lKTGtYL202STVUQjZiTHUwTEFib1RrTThWdERKdU1qZHBnMXpx?=
 =?utf-8?B?ZXFHcjJMc2JjcXU5QUdaRWh2ZitORDQxM2V5aFczV3crWGhvMzMzTUFnWUho?=
 =?utf-8?B?WmxteCtxcGhZa3VseFN1T1AvaGtjcGNWVUdkTjhLbEVZcVdpb1pCUS8ydVU4?=
 =?utf-8?B?RXQzNFhRd2JRVjU0RnRFU0lrbW9GWjUyKy8wUlJmOThURUtiSG1iVWZTSnJl?=
 =?utf-8?B?ck9BcFNqWEVaeVpSYVRaNEJzemhOVFp1eDAyRDFtQ2J0SU5Edk16RGRtK3FV?=
 =?utf-8?B?eTQ5Sm9OOGlENStrcG5uc09TZXNlRG1FRzFiRDRJUmc4Z0dMOWlFWkhSdHQy?=
 =?utf-8?B?eDVIN004UWdaTnlrK1R5T3NBazhMQlhUdVJiSmJHUDA4RWdHVndKYURMbmlK?=
 =?utf-8?B?WTF1OCs1R1I0WEx3Sm1EU3VnN3ZHN1JVdW9QdEhxa0JSMEY5K05paU9qMExU?=
 =?utf-8?B?bFhBaEptRUczKzM3dXdXOUNqaDJjWUI1UHhtV3JzczNsc2JDcDFXZ2UzVFNq?=
 =?utf-8?B?SFlJRzJnYlhOcmM2aExUbERmMjlzVlhrM0twSkQrS2VtRFhyNndmc3lMUUhq?=
 =?utf-8?B?a1c1dGYxUnpFY2JvRVdLSVlOdHRnNEhIa2p5dVYrdHh4SmZCUjhJRnNqbndC?=
 =?utf-8?B?Y2gzK01TeStKTlhnOXdXUGd1UjlUNHN0TlpONFBqWkRrMncrdVh5OERFNlRH?=
 =?utf-8?B?bmd2NjBSdnRINkVzS0xZQjV0UmdZOEszMW5vVjh5NGtTc2xQaVp5MHoxbkRz?=
 =?utf-8?B?MlYvSnBhTjNPd0hWTU81cWRxTnFJSFZVeG4vR0FvL1BQVmtzRUdPaVg3V1FY?=
 =?utf-8?B?a3BtTDB2TmJzTDJOeTRYdlNROHE5RE9SQUxtUzV5WVZ4NFJqeVhQYklTQVNu?=
 =?utf-8?B?VHBCWmhIMHdnNEF3dXRhVmJnam9CUXhWS09SQmUxRUxDOTVSbnFnT3ExaUtm?=
 =?utf-8?B?Y0pRajhIM011YkdyL3ZBVnNaMEhMVERXMktqTThHOExLbjJ6cTNVOXRneXBE?=
 =?utf-8?B?d0NjaFNGN1dJZk1Na1FYZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MElEZTBMTlJSTThWOTc0UEN6d2NqVkU2WlVpaHdjU3VqMmdVS2l5ODRnN2Va?=
 =?utf-8?B?ekJQbmNYWGU1SElYaXozRjBWMHc0NTJzVGdYaFBDZFhGM0xIcklhaU1DZVVE?=
 =?utf-8?B?aTY4eHM0UU1aVnp6MnpqL1ArbVEybEZmTlFmNXdyMDdnSHZsQWZLNkVicC9E?=
 =?utf-8?B?cEVRc1F2RGtJb0pVSFFxUVRmT2t1RVlheHlLeGtTZUxLSGtvWmF3NzhsVEtS?=
 =?utf-8?B?ZEZsOUVIWjlYWC9iMHJ2cDFYTUU4bjY4ZHpNWDgwVG5QdGVxZ1RCZGRmNTky?=
 =?utf-8?B?UHhqbk04MFJ2ZTU0WVA4WS9JbzF3b2U1ZHJ5UXNZWHRiK0M4cHVGUmZ4cks3?=
 =?utf-8?B?T2J0YWZSMm5wdUFPZHpQb3NFU1l0VHp0Tk9FYng5ZjdLNHdSMFFMN1MybDJJ?=
 =?utf-8?B?Z29zbzQwQmFLQTV6NEZmdFROaXh5ZFZkQmNpeFBFcjlRS2o0ZFppbW5TcEZW?=
 =?utf-8?B?YWlJTTdDdldLTzJ3Ui9Oc0VyNlJlZ0ZrM0dENWVZdnZkMFBFbzgrK1RZUXdK?=
 =?utf-8?B?L1ZjR3gzbFVsQmc1eWNFYW5vTUdlTVhuWGtxYzZtVTRCM1Q5ZG5VUTdUdVl4?=
 =?utf-8?B?UG51eHU3Q1M1TzZTdXU1RHN5VER6VDFJN1Z4cGpDNFJTcWhFUjR0bU8rcWhU?=
 =?utf-8?B?Y0lQMXpXVlRhQnZQL1pESzJoRTB4ZEh3R0tteU4zNnZlZllDcnE5LzlqSjZP?=
 =?utf-8?B?ZE0yTEdnd1hUZEtoL1hNaTE1UnlENXZhTUhhUGlFaEFqNzFxNlltOUJnMWFV?=
 =?utf-8?B?SlFRejN3Zm1IUGI3WTFoek04OWRVT0w1NGpvOVRnS2pONW1jWjZEKzRSYW1E?=
 =?utf-8?B?NVRIdUNuWlhqZFhEeDhPVSs5RFpzZ3BiMjVNTmlUOUZXaVIxejZSUUh4S2h5?=
 =?utf-8?B?Wm9YejZ0ZEVUV0kvQ2c2YmFTdzlGbGtBWWtFUC9qcmQvY2QvL2pUS0tNQ3Qr?=
 =?utf-8?B?b05VR2tyL1ZzSzFPbmJvVTIvek9oTWNqUGNhTThxMnN2MjRMZTVlRldMeTVy?=
 =?utf-8?B?TVAwZkZRYUZxMFYyblpNQlNzeE1LcG5BaGJCU2FuOG9pd21Xd0ZMb0ZlV3Ew?=
 =?utf-8?B?YmExV1M4d3V4SmUxU2p4dENKazgxUWNIMUQydHFJeFVxTjJrQm5LTXkzcVdS?=
 =?utf-8?B?OE1Zd0ZEZEZ1TVZnQ2h3NTVWNGVBNWd2bmJRZFdaSnBhcHl0VmJLUUM3ckFn?=
 =?utf-8?B?TGxPSlZqWEJlWFZZWmFvdzNFNTE2STRleERWL09xQnJsS0NkTmZwRysrVWRK?=
 =?utf-8?B?M0ZkV0xRcnZzcVA3VUZyRTF0TU80bmhYcEtHT3lXbmhjNlEyZ0c4TEJuajNK?=
 =?utf-8?B?em5oZkJKUi9heDdTaVhvSE9NTU5BeFQvL2RYQ0Y2Ni9LQ01uUnArMjdFaVZp?=
 =?utf-8?B?Mlg5bUVqaHNWWjdEK2dXcmVXbVdZbjNnRUFDNWxtcUVTN1dpdHl5RUltQ0Iy?=
 =?utf-8?B?ckVHNEdjdU8xYkpzL2RpRkEzakdIOHJrYTBaOFhkM2dJeTBqTjRRMUY5QjA2?=
 =?utf-8?B?Rzg3eXorVENMRkdRQUJOVmlrRXZ3bG85OWE1bXByR0lwMGJxdnNjaGgvUXFH?=
 =?utf-8?B?Y21OUFJoS2FWNDM3TUcyT1hjLzNhK3ZkY0FXQnZLTk5oNjN5VXFaVTFtL2hV?=
 =?utf-8?B?ZGpkZkhtaHFUbmtDazlGZnVldWZiVlQyaUdEaXdWQjc3WUYwaCtmbkd4ak5N?=
 =?utf-8?B?ekNCNWxTTWwza3Qvcm5IOGlIbjBIWnEyekkvbUU4U0RWTEkrcHFvY0VtbHNU?=
 =?utf-8?B?ajM2UWp1WkNMMDg5S1hPL3Y2UUlpa0p3OWFFT1VrdytIK0pwbWxLRzA2UjZh?=
 =?utf-8?B?WXVhUGJxRDFSbnBWaTYwTm9maTlRVTBqcjdFWGdGUzlQZ2l4NTJIZ1V1Q0pG?=
 =?utf-8?B?U2s3T2RycTJZMEp3cE1KZzlyUlZNd3I3bVBkeEpOV3JmUThrNnltRlA4b2FU?=
 =?utf-8?B?RzlNRmlDV2tnOWVqUkFKWlFtZUI3VHk2S0RhNkFMS1RTWnk3ckF2Y0ZxMzUw?=
 =?utf-8?B?THVEWUdqbFFxa3JIS3ZHbDZqbFJlQUl1SVpMNStCSU0xZ1NEa0hpNWZlNXpa?=
 =?utf-8?B?TTk2UHRUMWljd0F2WmFvTkE5ZW9DT210bTBpN2JFTHFNVnFyZndvRDBxcFps?=
 =?utf-8?Q?y1Wr2OZrvDC1fr47ZVCadrbxn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32593f37-adbc-4acd-c02b-08dc9c33785d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 14:13:25.9327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzduLY60HIrAy5cLDyt2T80+9Y2it17ULws2q+4zyegBMwRkc2gfdEer7r6In6VlwQAaMdBbmLIvqKn8XUSZKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117


On 7/4/2024 5:20 PM, Greg KH wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Thu, Jul 04, 2024 at 11:16:20AM +0000, Akshay Gupta wrote:
>> - AMD provides socket power information from out of band
>>    which can be read by sensors.
>> - platform driver will probe drivers/hwmon/sbrmi as a platform device
>>    and share the sbrmi device data.
> So you are "splitting" a real device into different ones using a
> platform device?  THat's not ok, and an abuse of the platform api.
> Please use the correct one for that instead.

is it ok to call API, devm_hwmon_device_register_with_info() from misc 
driver

which will require to defining the hwmon ops in here.

>
>> Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
>> Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
>> ---
>>   drivers/misc/amd-sb/sbrmi-i2c.c | 25 ++++++++++++++++++++++++-
>>   include/misc/amd-sb.h           |  2 ++
>>   2 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/amd-sb/sbrmi-i2c.c b/drivers/misc/amd-sb/sbrmi-i2c.c
>> index c4903d9e9f0f..b593bbdd78e0 100644
>> --- a/drivers/misc/amd-sb/sbrmi-i2c.c
>> +++ b/drivers/misc/amd-sb/sbrmi-i2c.c
>> @@ -72,7 +72,29 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
>>                return ret;
>>
>>        /* Cache maximum power limit */
>> -     return sbrmi_get_max_pwr_limit(data);
>> +     ret = sbrmi_get_max_pwr_limit(data);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     dev_set_drvdata(dev, (void *)data);
> No need to cast, right?
Yes, will update.
>
>> +     data->pdev = platform_device_register_data(dev, "sbrmi-hwmon",
>> +                                                PLATFORM_DEVID_NONE,
> Yeah, that's not ok.  Please do this correctly, as this is NOT a
> platform device, but rather a made-up one that you just created out of
> no where.  Instead use the correct apis for that.
>
>> +                                                data,
>> +                                                sizeof(struct sbrmi_data));
>> +     if (IS_ERR(data->pdev)) {
>> +             pr_err("unable to register platform device for sbrmi-hwmon\n");
>> +             return PTR_ERR(data->pdev);
> You don't need to unwind anything else here?
Yes, not required.
>
>
>
>> +     }
>> +     return ret;
>> +}
>> +
>> +static void sbrmi_i2c_remove(struct i2c_client *client)
>> +{
>> +     struct sbrmi_data *data = dev_get_drvdata(&client->dev);
>> +
>> +     if (!data)
>> +             return;
> How can that happen?
Its just a safe check, once we remove platform driver this will not be 
required.
> greg k-h

