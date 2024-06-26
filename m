Return-Path: <linux-kernel+bounces-231349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1170B918EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6B328264B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2923618E767;
	Wed, 26 Jun 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Bwq9gXeW"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2122.outbound.protection.outlook.com [40.107.237.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4A33C5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427535; cv=fail; b=JByqLLhaBxjkym6vz2dnFrpiAjcPaAl13osJi7W+p6exoSEyDXh4qXCY7fKarhaZvpjYzH85Eotz/yGSVej41pwtsRb6jbSJJrTsXKYB5fh969zbmfJaaO+bLw/rUx2xr6NiNp1siwSD7zhP0wQAoyaQWXsDf6pV8kAZ1oOyiQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427535; c=relaxed/simple;
	bh=ureS8Gbqso3q1HWNIglXxHhHyyxTOYhEJ4As6VBDnYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B2RS/8QiHpWyIWFWSfOFgM4Kozl3KwYzIHqWGDdmbvIwb+73i0CffRpG3HMcb8zhX2aAHvZCtqDWhuvUJq5qvUpOwPXSyF/Nvl6mCPo+k++jKO89kY0jiive5zK+CKWajfGJR1sEuQ5w2qnjTvs4IfmZVZDCf2uAydh/SL/64sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Bwq9gXeW; arc=fail smtp.client-ip=40.107.237.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHzYs6P1D4V/n0vjZPN3OS6n+U3xD5lLghRo0BWhSauyix3PsnanOXmC1I4c9bHpn9bbxapDQfrOHmZ/vmlyIwqzYYcSP4Js8xPkayS4kb7q4nSK8p4DylrbSyy/3zFwIAbtuTvD+am7N4GjJbwPFE6tSSAfRpAWWGTO2c6VP3gpZrzuEELDglKqwegHudC8mOgA94WA3m9rlmuCnpqqK6bEZrMe4FEZWGanTBKxY2YT1DtJRi19SbCpm7hGgkLHss+EI5lKTCLj9RstYXCUQ/oKOmbQA7OBaExZydw5td98SdMy88evTmHo5JaeABd2LLVwplWa6vb5d0hXEUAQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHxvQ8o0If63K+ms7EJYwGeTfahJ8+TUK9fQTFSuZMA=;
 b=GZtChpgI5+Wbw/78WVdCs6KOv21+9v8moM+p56CxF67hmg78DzmwDSg/WEspo94vXqpPT4y2Dckw/sDoRBV1CqK8nFJyR6piRghL4Gd39UNEu8zgKvXUBGGlfJ4hN4O+o+MM0cUvPg+4N63UzxCOul/qrJsAFyLCqO8x4F/6InJAIw6jPYeYTUxB+p/RwW0UVos6zALbGCtBYtOejMTxaPQ1jNmpfT3L+o7uVCOqsojGcp1G8HW87LeyUTwMki5Ib+AcFI1EJAL//oJJqzxFxu7shuPXl/sgiNvpab88rfcBDdFa9dTci1U7h3a48wRC+NVSmhNOZJ6hcsAGlQg0Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHxvQ8o0If63K+ms7EJYwGeTfahJ8+TUK9fQTFSuZMA=;
 b=Bwq9gXeWDJx7SsCmpGQJUAl2lsRhgf4LYuONZVkVp85XojjNRX80HXOLHf5gomsraG8UBFIOvnk3SqL/xzSK8HY0t4K6f4wd0Ue4ukvpNNN5JIuLbNYhBEQYjbBOvOTnYV3M0w9/tgUiCAUUu2ExQjguK350xlzK563xyg+T3CE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 SN4PR01MB7501.prod.exchangelabs.com (2603:10b6:806:204::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Wed, 26 Jun 2024 18:45:29 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 18:45:28 +0000
Message-ID: <3cd0e716-73bb-4ccd-a47c-753f6141a16e@os.amperecomputing.com>
Date: Wed, 26 Jun 2024 11:45:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, anshuman.khandual@arm.com, scott@os.amperecomputing.com,
 cl@gentwo.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240605203723.643329-1-yang@os.amperecomputing.com>
 <Zmw1jltdkMrTrT_l@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Zmw1jltdkMrTrT_l@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:610:32::24) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|SN4PR01MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 27489799-b60d-424c-189c-08dc9610262d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|376012|366014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEhhRm92Z09SUUpwSnN4T1Q0S2dpN3hBdzQzZ0RaN2Y3b1FEc1dIbForbHhr?=
 =?utf-8?B?b2EwQ045OVhyUng0TkV6clp2aFowQUZIbktrbDNIYW5XS1l4OGxjeDF1UUY1?=
 =?utf-8?B?L1ZwYkJyem9ocHgxNTlocDRGb1dyOE1rSGhUd1RyUERRT00rTlhCb210Z09r?=
 =?utf-8?B?NHZlSkY4U0cwWXhxc0FpS01vcW8reXRpTGF0cFUyMFlZajRjYTRHTnphN2t1?=
 =?utf-8?B?dG5UcWp6bUxNenBlOFE2UVllSTNmellKODdPTHFVV3ZJdUV0SlBEOTdvdnpY?=
 =?utf-8?B?czE2UnZidkNEcVMwbW81SENWT0FUUnlFaGpmYSs0L3N0Q0IzdktZZ0xtRjc2?=
 =?utf-8?B?V0JyYnR0czZYYk5DeG5KUUVBeS9RcEJHajFkZlJIbXFIc3ZsL0loV3A0aS9o?=
 =?utf-8?B?RkpMN3h0N24xc3JPV0pYUGlNWGNvTjBIaVlWVEd6VmlVdHhHaTd1SzE2WlJz?=
 =?utf-8?B?T1BpZVAzdmswaWhiUTMxb1hxeDNPQmFVdzVNY3JOcU9hZUwxVEUyNFFqYnVm?=
 =?utf-8?B?WkhNT08yMW9IQTlOTzlIRi80WTJnR0NmcEF5enMyZXp1VzZHTzUxa3lmZEhM?=
 =?utf-8?B?ZFExcWdTY3RIaEFkeTE1WlpFNnFyS29wRUw3c2M1RU92aWY0ZW92Q1NZQ2FE?=
 =?utf-8?B?OXk5MU9sRUhBampsdlN6cFppTU1zME5JUGZRSjFLT3BucHVzYXRBTy9NZ0pl?=
 =?utf-8?B?R0VHMWQ3YzVFOVVXUHRXQVozOWczblI0TTZ2YVRwR2ppZmRvTTQ2WW44VURJ?=
 =?utf-8?B?QU5MbmhqS0lCTE9GYlNQcHpaNlM2cGtYMFpmbWkrTjlqN3o2c3BRWjJOY1RU?=
 =?utf-8?B?T2dmZ3R0N1U1WHc1dUtXRkQ5dEtudTQrVmgzSUxqblF3Zk1JK05wWHVCUW95?=
 =?utf-8?B?K2pOK21obDJyUUxYR1Q5RjdTSUU5cmk0eFBwbmpUN2x0U2U0RDVMV0dwNzVB?=
 =?utf-8?B?amk2RVU5a2E4NjdhRThSSlYrVVNHWjNnVEZOcUNZc3A5OWF2bkVBSm4yT1l4?=
 =?utf-8?B?Wkt3cWx5QW9KclphQzI5OHZlRE9hc1Z5eHhuTTdLY3JTMUQzakxFN2NPWFFJ?=
 =?utf-8?B?ZDZxRE9ubmZhOU41ckFjZ1BlUTZlVjRabFZTSVo3Y1JxSlJtYnFBTjk5WCtG?=
 =?utf-8?B?MzFEME8wWnZiR3dadmpFWXF3Ry80T1dPcDUyOFlsQ0dZYk9vQzE2ZHR1dVds?=
 =?utf-8?B?TkVVaTczdVd6c1dDaTc2a0E4b1BQVStSOUVoamZOVFdlUUdMSTYvQUR0c0Yz?=
 =?utf-8?B?akdkL2hoVWZxVmtWMEdtQnhTVkJ5VG5OQTlCQXV4TGZIVzdDUDVHSTMraGFh?=
 =?utf-8?B?TzNpZVB4SkNScWg0aU90STdEdjZXakdDcVJETEVybWRZOTU5U2JKUDYyc2xl?=
 =?utf-8?B?MGNYdEJVWWZXekFyQlJYMmw1NWo5cG91Rnp5Z0RXbWtpc3orYTdPblJsc0da?=
 =?utf-8?B?dGR6WjZzVjYvTlMwcFZvODlpMXhpUkdIOFJwNTN6WERCbXFuSG9VaVdLaU9D?=
 =?utf-8?B?bnZFVGdqNktTcUQ3cnEyR0Y3YjRxRS9UQ3NJTDhPSDNzVGRoMkxCSE5naVR6?=
 =?utf-8?B?QnkxKzdvWllQRmdRcEMwaUlWZFdHdExjbGpDUkR2RDFFc0U1aTg4YUVqWmpU?=
 =?utf-8?B?ak1MYTFLdlY5QVdkbW43SkFXbFVBUEJQUUN5YUVJQ0FTUVkyak5VNjRENyti?=
 =?utf-8?B?cXBZMnR3VmxML0JpNHlrY1FBWjdKcUVsRHl5bUwzUGtrT25uTzNlb3dlbEFh?=
 =?utf-8?B?enZ6N1Q2R0RVbWRyRmd1bTlQOEZrWkpRVzhGNXh4K0hkMktteWUvdDN4YkZH?=
 =?utf-8?B?Uk9mcTFLbElnZk93Z25Ydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(376012)(366014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3dTWkJNSUtNZjV4OEkxVEtaeXRhQlorcHpXbHZwVUtQN0x6Z2ZMeExKbjQ1?=
 =?utf-8?B?dkQrWlBQSmIrM2dhZ1VDSVV3QTIzcXFIaDVCNk5tZzROYldjeFN5UVlqdy9L?=
 =?utf-8?B?cGxwZStyR1NIRTBJRnhMOHJpQmN0WDloV0tCVm9neE1OWDM0MS9iaThINVRz?=
 =?utf-8?B?REFTWG00UG5IS1NLaHlkWlhCWGpjb25uZzh6cXpJbHJFZTE5VGN2S0tWMkJZ?=
 =?utf-8?B?dVJyQWFBU2lxKzAxN0ZXeiszOG9vTGRHcS9XS3ZlWmdrWks0bGdTTnNZYUo4?=
 =?utf-8?B?cThWbUZidGRoREJyLzdNWjVSWnh0bDNxSmg1Uk1WWDhnN0k0VTVjcTk5VFBr?=
 =?utf-8?B?ZDUxSlZDS2pnZVlVaVFTMkR0WWhhNk1MRWsrNFlmK2xTWWJQY3Azelh3c3Zo?=
 =?utf-8?B?eXZwZmxMcUs1dkg4K3lDWk1aMi9kUVloM3ZFY1oyTnBKalJDWjh0TkVCYVBP?=
 =?utf-8?B?SnAwRDQ1MGFRK20vZThJaWRUeW1VWEZtMytLWmNtZzZObEEvdSsxVHRQUmJD?=
 =?utf-8?B?NmgyUzFGVUsvbmZsNVdoMjRWbWxNMitnbnNEU3VRN1hFRlBhanBOMGJ1Z2lJ?=
 =?utf-8?B?TzhQNFpJVVJyUDhaMFNBUTEwRGFDclVjSkhJVGtJTXYxaUszNVIreHBkRkYy?=
 =?utf-8?B?RzY0eE8wRnJ5MUU1ZzhqMGlTVjY2aGorTWFFaE9HQk1nSmtyZmFqTngzMmtI?=
 =?utf-8?B?S2xER05oSTNlWHNkcEx1NTU1OXRkN3VrT1MzZVpacXdUcWwrYnNxTnA2UWZr?=
 =?utf-8?B?Y3V3eDR5dHRLVElRVC91ZThySlV4d1VWZ1loK2srY1Q0bmorMUNkY0VwSXIr?=
 =?utf-8?B?Q3Rrd1FWa2FiR3pKbHR1TUxZeVJEVUJnYWNTMmNkeU11cUhtN3ZJemZvV05x?=
 =?utf-8?B?eVUzTGpGb21YVWpHbzB0Z080VDRUUitYa203QzdHNDJWM3VHdkovUEFUVUZh?=
 =?utf-8?B?YW5PeFZQOTE2K0w4dFhOTVBVVTZMUGVnczRLU0ZnSW4wUkdyeGx6eFJGYXlN?=
 =?utf-8?B?Zm1LT2NOL2p3MWFDSTdGM1EyNnB5QXAwS1FGSWF4S2VIeTlWYk9zTDlvYVJi?=
 =?utf-8?B?V0JtUG5FRldmdU5IRWJwaFhHYTRjRlhtOUlkUUl0NDhWekI4LzBXdFFBOVJL?=
 =?utf-8?B?UnBsZU9jMjVkdHl6eC9NOTk5SnVOcTc4YVNMSzNiRnlOcjN4YVoxVHIyS1JV?=
 =?utf-8?B?NlZQV2F1b2NVM1lrdkk0QkhkNktUbHJaRmxhYno2NE4rNTdHZmtKQ09IV1g1?=
 =?utf-8?B?bUxYTHhPbjk5NW1EVFdGaXBFeHl4Wm9SeTJLZ1Zpb3I4ZTNDWENYY1RpM1dq?=
 =?utf-8?B?R0ppcTd3RUFsUkVzQk5KTFUwY1NoM3ZVeEorZjBHMURESWlwenpoSWpGaWF5?=
 =?utf-8?B?MWNza3Nac2hSbnozaTRuay9oYlFEM2Z3UE1Oc2V0eFY5VXR5R3dZcXNZTDVX?=
 =?utf-8?B?cm15ZWtPWEpOcGF0U2tJSGxPK0V0ZzE5ZUNBUk96VjU0SnhkQlpmWjhxZU9B?=
 =?utf-8?B?RXorbFhLMmZoVm5IV3ZrZEIzWEg3Z2E4d3ZQZmNBNko1VkZ3TXdjV1JFVVJz?=
 =?utf-8?B?dzdER0VvamRKRzVYRkYrTUJiK0hLYlYxZnpKWmtsa2tTK0pyVnJ3MXA0UWVp?=
 =?utf-8?B?UjdjRmo0eGJNbmlnd1RpbE9ld0ZyL1FBeEYzYWtGcDNxYUlQeEJDWVpvU3Jm?=
 =?utf-8?B?Z3BweWJLUktDRUswSHZhMXR6MGZ2OGVxYVVwOVRmMmhPblE1QnEwQkNJV29h?=
 =?utf-8?B?QXdCczhKajYvSG15TkUxV1c5MzhRRE5lbzhqT00rU2tGSTZXWXVDNkVneFpB?=
 =?utf-8?B?QUMwY2doSWZESC9IZ09mN2kwMUIvQkI3YWlMWEhYd1JHOWt5QlYrTzNNaVVB?=
 =?utf-8?B?MnFHcmtNMWJYUWlRMDB2T1ZPc0Yrazk2bGxrY0RMRlJEQStnK2xzbkJUUHp1?=
 =?utf-8?B?OExJQzY1UGJ2WjNvTUsvcndWbFhlSmhFMHhqQSt4bU9WSlJsa05YaW5pc25y?=
 =?utf-8?B?TW1odExvV0JXQ1RSQ0NCQ0JCVEkrMUpLYjR6WHp4Z1cxbngwK2pheWswRUNC?=
 =?utf-8?B?cXBiVzFxSjBNRG1YaDgxV3JLNi9McVFjT0h6SUZZL2paNWY1VjRSY3N4dFpx?=
 =?utf-8?B?cXBlQVVHUzgwdUlEQjhHSWNoWlRWQlBUTiszTzZ6RUludk1uMEozYkQrQ0Vy?=
 =?utf-8?Q?6mmK8odN7BqVunvFPhqkKt4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27489799-b60d-424c-189c-08dc9610262d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 18:45:28.7919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lP9g1bkZySTkHFFMZmlLFvApgRGI84LiZttltClY+RUGKaSRjiLCXa92OltGVEHYtjew3+XoCY/hXal/LVjZPYX3lUfzF7Vw2WwWZhRJXxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7501



On 6/14/24 5:20 AM, Catalin Marinas wrote:
> On Wed, Jun 05, 2024 at 01:37:23PM -0700, Yang Shi wrote:
>> +static __always_inline bool aarch64_insn_is_class_cas(u32 insn)
>> +{
>> +	return aarch64_insn_is_cas(insn) ||
>> +	       aarch64_insn_is_casp(insn);
>> +}
>> +
>> +/*
>> + * Exclude unallocated atomic instructions and LD64B/LDAPR.
>> + * The masks and values were generated by using Python sympy module.
>> + */
>> +static __always_inline bool aarch64_atomic_insn_has_wr_perm(u32 insn)
>> +{
>> +	return ((insn & 0x3f207c00) == 0x38200000) ||
>> +	       ((insn & 0x3f208c00) == 0x38200000) ||
>> +	       ((insn & 0x7fe06c00) == 0x78202000) ||
>> +	       ((insn & 0xbf204c00) == 0x38200000);
>> +}
> This is still pretty opaque if we want to modify it in the future. I
> guess we could add more tests on top but it would be nice to have a way
> to re-generate these masks. I'll think about, for now these tests would
> do.

Sorry for the late reply, just came back from vacation and tried to 
catch up all the emails and TODOs. We should be able to share the tool 
used by us to generate the tests. But it may take some time.

>
>> @@ -511,6 +539,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>   	unsigned long addr = untagged_addr(far);
>>   	struct vm_area_struct *vma;
>>   	int si_code;
>> +	bool may_force_write = false;
>>   
>>   	if (kprobe_page_fault(regs, esr))
>>   		return 0;
>> @@ -547,6 +576,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>   		/* If EPAN is absent then exec implies read */
>>   		if (!alternative_has_cap_unlikely(ARM64_HAS_EPAN))
>>   			vm_flags |= VM_EXEC;
>> +		may_force_write = true;
>>   	}
>>   
>>   	if (is_ttbr0_addr(addr) && is_el1_permission_fault(addr, esr, regs)) {
>> @@ -568,6 +598,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>   	if (!vma)
>>   		goto lock_mmap;
>>   
>> +	if (may_force_write && (vma->vm_flags & VM_WRITE) &&
>> +	    is_el0_atomic_instr(regs)) {
>> +		vm_flags = VM_WRITE;
>> +		mm_flags |= FAULT_FLAG_WRITE;
>> +	}
> I think we can get rid of may_force_write and just test (vm_flags &
> VM_READ).

Yes, will fix it in v5.
>


