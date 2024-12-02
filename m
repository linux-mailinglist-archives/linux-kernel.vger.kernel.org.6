Return-Path: <linux-kernel+bounces-427128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1549DFD05
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36AA280E31
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EE71FA178;
	Mon,  2 Dec 2024 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VlFXzHZN";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VlFXzHZN"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A91F9EAA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.88
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131440; cv=fail; b=NWJukMyYADLKmRzMOE9wNHvfzmUyQuw4JRKYU/TQ8KstlkhF9IkBx92cDu006KhEE0iFfS0B7tOWIQbgMCB8HVxm6bh/+6WhFsCVkcxktR2sLT9n5LdYrfk3P7oYg4JIbqUCrY7DYHvwO5pPZnHxkDqJWzioTfVDcknwGsRBbNQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131440; c=relaxed/simple;
	bh=u/9ip/pzAt6tngv+NnHeWhi+xUSd2LRdIO1grsb0L2g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AbmKxV7y9Lv1H0wLseuLcIvQnila2m7PI/EOp65A0bKQ76Rm2yHkf/2xc9ELb+NEuFUR2FSQRO9Oj0x0RY0kG2X45YSLIfuEH5O80jYcARDPVIgxhoBrXeBBydhoSD+AOgET8po2AOVjwkAoHRKDtdt6lB27BhxL6ou2CHhZh9s=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VlFXzHZN; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VlFXzHZN; arc=fail smtp.client-ip=40.107.104.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BwE8E2XM2hacPnVfNcCeJKnWzLCAN3eut6u/F+xVEbOCAlKx0BEH0jGYgXqi6O+sfagmbujIthJWnlZWK6/Qsmdg4oDjNo9tIb75/xWj93toLNKsBjLT4upu7KWBFiehHttdxEDxcs4P+py3U9+cTY8E508ZkHtCLkGACt9U0oBZzPBcHiRIVS+xOVzkhfoWgTmlyJQTD2DTaKlYcJUFaOdzoZcsuevIvc/pkgBlzd4A/TKUC+hm0lN9X2EPktfYXigwXqv03v0DN0SbEmPYSKLClU1Fa2VsTUI+B3hBGEzAmA5aQ54c6rOjP/VICKKnKuX7LO7yNkC31TA0dO8Oyg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFA1JlBlqWUCptZHAUMHsqyfuXrNKi1x88OtyqjP8Kw=;
 b=RoH6JBEGye8cBPeSCzajnDZJWyMwAZ//ULRZo1SCpVo5Sqc2Sp1qkayTu28JN4+tVRSdkLKKuYJB8kwmvhbyLILTS2l5MXla9HWpQz0lCO65EZkbGfO7xY6cCVp6R977eSr46GDR/nKJt1DmRUyDcr1Mfft4lwx2OqWaJMdsf/D7eYfWtK+IrpGF5W+Zqed4FGo9sfHI19g4/w7ynDCMsKS+XE2muJ+nSpCoHnWTBPsbROzSw/qfFNUEuDOerk0tsnFUmfzS/d4xW8iYdpPJIih5K1MzY2CM+a86bYjU0h4S0/MmbOEleQQ26j3gSkLjGUTSG4DOHvqE3Ys7C6SAfw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFA1JlBlqWUCptZHAUMHsqyfuXrNKi1x88OtyqjP8Kw=;
 b=VlFXzHZN7uZJ18KBMSs8CBf50UZFmCcS8UHe6VuL0WbJeSLhcLlUQ6yWlbqBO4FEnKC58gEhsYXaWgmGNCyO7kOLMEhSdAFwoCtSdFxZJisuymwKSWt7WZCKPDTXtOWMBMOCnViHYfxPkCfsQm6LOrxnWs8ibr7jMF2PDqJ/fZo=
Received: from AS4P190CA0037.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::18)
 by AS4PR08MB7685.eurprd08.prod.outlook.com (2603:10a6:20b:504::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 09:23:50 +0000
Received: from AMS0EPF000001B1.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::f9) by AS4P190CA0037.outlook.office365.com
 (2603:10a6:20b:5d1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 09:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001B1.mail.protection.outlook.com (10.167.16.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Mon, 2 Dec 2024 09:23:50 +0000
Received: ("Tessian outbound 206fab1c37e0:v514"); Mon, 02 Dec 2024 09:23:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e57d72e1bd4c979b
X-TessianGatewayMetadata: gdG/hJJuzm5kd/MdYnb5340CSVh0hv9g09ruOPgHKTZUatrqgLA3vHqjnqgtl3ZECUuumGrPhGiZJ6dn9C7abiXY1HEDMwnioWZNQMIBEs80A6kTqPDHj8phlWsMxsjDY7ty6muN2fjeYJ9IJgEsI/SuRWzJCbSznvLusKfQskg=
X-CR-MTA-TID: 64aa7808
Received: from L6fb36fcc0483.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4DE00764-5D37-4C21-AB76-19C57059623D.1;
	Mon, 02 Dec 2024 09:23:43 +0000
Received: from DB3PR0202CU003.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L6fb36fcc0483.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 02 Dec 2024 09:23:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WutWw9gjOYWJikfQixDo2bGgG+onpOWPPkI2r9Am3j2x9zcBn2C2F5SNSDPU0R6nsWrgzQoH10DBBGhebRiVXQO6ThuDj4bLCfJ5T2A1iNlplWO68Ef16WDvt/JAZ1C+9IKTnlin2cmLoSNBHTS8xeswgTkbN0gl9fvA652YIqMAcHMuphBgxAtCnbQ8eQOBjgSKPM4PSIDJ1khLB8k8dz8t6X3W8sI8+Vn7yjWX3gX5EtARycbgcW6CvGuN/XecRtQvzmD7JS9p4YZtWkzxhQDh9R6bKbyRspea4u46ZVowcYSA4tqk55b6I2bQBheivJO3TCp0GfjBR3hv5mOiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFA1JlBlqWUCptZHAUMHsqyfuXrNKi1x88OtyqjP8Kw=;
 b=ubGw1q8ylBeEQhlJRiBc0s+a2yBt2w9qccXRnDk6776zzEGqu9WtWzxYo+2t+OUZT14WlGTfar2VKMJgihUF3G6Hdhh+6folHZoEJQKCpQBEteurK9/hEatGremrTzjWLA/WIgIUTitHWw1qJiYsahB4w2Dwh7yESiMDLzgzbyc5xo5DgmbMfk650PKY1GZ9ap1srPhLmJX9Lbyrr8EVuCHtVzrDtLeMsuv2x1OtPKyRyh0c9LAX8on14kck/Q+Ynu/2KXaPAImHxBXDvuOd7SiFBTzOgNk57UrDzumcBTA7MiA6zOvZj2Fv55/dK4k+s36G7iJFlWkOmWFmPHVkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFA1JlBlqWUCptZHAUMHsqyfuXrNKi1x88OtyqjP8Kw=;
 b=VlFXzHZN7uZJ18KBMSs8CBf50UZFmCcS8UHe6VuL0WbJeSLhcLlUQ6yWlbqBO4FEnKC58gEhsYXaWgmGNCyO7kOLMEhSdAFwoCtSdFxZJisuymwKSWt7WZCKPDTXtOWMBMOCnViHYfxPkCfsQm6LOrxnWs8ibr7jMF2PDqJ/fZo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by AS8PR08MB7321.eurprd08.prod.outlook.com (2603:10a6:20b:440::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 09:23:38 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 09:23:38 +0000
Message-ID: <dacfbe5d-a730-4643-90a8-1c38cb6780da@arm.com>
Date: Mon, 2 Dec 2024 09:23:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/10 v2] sched/fair: Fix statistics with delayed dequeue
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Mike Galbraith <efault@gmx.de>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, pauld@redhat.com
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
 <227863d758551e75cd0807a5f1f31916d695205b.camel@gmx.de>
 <CAKfTPtDwS4+t0Fnacre6dtxKdxtrgua_2v=s7pZHqDsYoMMxFA@mail.gmail.com>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <CAKfTPtDwS4+t0Fnacre6dtxKdxtrgua_2v=s7pZHqDsYoMMxFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0256.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::9) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|AS8PR08MB7321:EE_|AMS0EPF000001B1:EE_|AS4PR08MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d5f34b-6bc6-4d3f-dc06-08dd12b30848
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VkR2bGlZbDJwaG1FQ3dBSFdUL0Z2NDNId2JIZm1xT1hrYjRHbW5YcVM4YnNx?=
 =?utf-8?B?eU81SDkzbUMrRktCZ2d2Y3YrL2dzMVNkdTBoTjk4djlQK09DT0FqMVJRcXQy?=
 =?utf-8?B?Qk1sdUFxMVZTelRPREdXRlNXZk9qeUhLWVpiV0ZwZ3ZxMVJkeUc0ellWdXhi?=
 =?utf-8?B?dHEySWRsOFExZlNYQ3N6eG4wSEdvOEhoV3pXOGlOU0VlK01qU3hqTFBxNnhB?=
 =?utf-8?B?V2hHeUVseWF0a3ZhTFVoOWFidGVEcm54dlI0Vlp6SWsvY3JWODgwdis2N1dq?=
 =?utf-8?B?V3V6NFlIa3BXQ3FTNHhkY1RLc0FBaElrTG9EL1BEQmtsZU1NVDgyQ2cvdmw2?=
 =?utf-8?B?MXppcnFpQjV6eUJpbTAyMWxnUEowcG1qQmhzQlRZeWJCQ2JmakV0aFlHUktl?=
 =?utf-8?B?VVpHeHVlRXUyRXhNemxxSG5TMDZ5WHZEcTMzTmxLMWRZWmE0TFBUallMZmVz?=
 =?utf-8?B?QlZpMFZTMFV0VVc2OHZ6VWFSSXR3OWdXaUVCRFdKSE42ZlErTjNjSk44K1dL?=
 =?utf-8?B?bUFxaXhDL0JSTGZvbVg3VWd6NXJxRkV4R1VycU8wNTQ4QjJkVGdzdDk1Rk5R?=
 =?utf-8?B?bEdNeGh2WnNMMWxLSmMwRi9ySkx2TFRiU05UV0tFbVN0eHZqY2tkV0JYQUdM?=
 =?utf-8?B?eXJ2RGw1T3kyWFVobnlwM24wc1k1ano4Zm5vSkU3dmJwdjkrRWg2dGV2NEJ3?=
 =?utf-8?B?QmpjSW9EcUdoeDU1N0F4WG9qSHBqLzlTbTZWS2l1WThGdm1yazl1VzA2R256?=
 =?utf-8?B?QjVya1l0U3JWRG1CeXRWaXNFQ1VMaFZRRmNycDVWczhFeGdnZXA0dUR5ZnRZ?=
 =?utf-8?B?MkFESTkvL0hoMUJhMUpMZjVpT1c0VDVIVTNZcXdpK056KzVGTUlsR1RRRS8w?=
 =?utf-8?B?K0V1M0ZhQWE5WjFGWW11Zzh3VGJtQnJtMzhSTmIzNEtVbUxMTWd1cm56Nkhu?=
 =?utf-8?B?WGJUS1FUc3NZMEg0SC9Jb05yU0E4OGsxVytQNFRGSC91VXkrRlozR3JTUzlv?=
 =?utf-8?B?NFRxdk9yRnBaWm4ySFB1ajBVb3djZXlXcitKK0s2MEkzSm1pS0hhOGhuV2dR?=
 =?utf-8?B?WjF3dE1rT0VveFdsWlFyUnNRWnhTcDUvQ1d6azBkNGZYWVRzUnFraWZITjRs?=
 =?utf-8?B?ejhRcjBlWU94VGEwWVBLTldxV0tuS2EzMCtFaTdBeTkySEdjbWhxYTVYMFVi?=
 =?utf-8?B?S3huR2RDdTlqT0lmMDN2eDFCb2d0c3ROZUhVVHRyRk5NckhuQW94Tkl3OHZo?=
 =?utf-8?B?MU5oWklyMXJzVzRabjRFRm9LQVBiQ2lweTVGZFA2SkJxWlVWSHZab3V2RGZl?=
 =?utf-8?B?Vi94bENXNlJjV1hNYXNxUFlpVk4xbFV6SE9sSXo1QXhaeVhyaUtUYlBBSjVa?=
 =?utf-8?B?SDgyanhwSkd6RVRzeXo1dlIrMXB6V25XS01CTVpiWG9jM3FlWEpXQUZoZHFQ?=
 =?utf-8?B?Mmo1SllWTm4wb1lkcmpGZEplMjR3SUdCL0QwRTVodlBVVTN5cEhuY0lYT1pl?=
 =?utf-8?B?c3JJNW5zS0Vyek9Ydk5jaStaLzJReElUV2h4TkNqbll4eGx5OHlnbDM1a0Z4?=
 =?utf-8?B?dysxMThhODN3b3AzelhYTUxkWFNoMEV1WjliQWhHMjNWdUZWNkNpZkRzTDFV?=
 =?utf-8?B?ZExxMFBEdjVibjlkcWRSb2I4TC9LNm43ZklMbTRzSkc0LzhjZ3NTYk1yVjQ3?=
 =?utf-8?B?blplV3IzclpEOG5GVXd4Yjc1QWZ3cUdkbllHOEVLc3RvdTdMdVpDS2pjZEh1?=
 =?utf-8?Q?GBn5/gFvteK5rx9OCQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7321
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5f6b443b-b950-4800-f7eb-08dd12b3014a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkFBaUsyOUlSbUdaUWZrVEdhUTBKQWYvam1TL2ZCM1VEQWJuUzNWeW03clNp?=
 =?utf-8?B?dUE2ZmVuTGFZVE1nMmNDcUFMNkRmNFlLbkUrbDlvd1ZjWUxrYU9sYVM0M1NF?=
 =?utf-8?B?cVB2cGE5TU1TdDc4aDllY01wK3VkeHZzd2lVQTdVSjI2K2pSWDM4eVNPT3hx?=
 =?utf-8?B?TnFuUndYLzdEQTBTbmtVUXFRZkxRTENDdk5VZFN1SmhjR3lTMGgyUUN4L0pj?=
 =?utf-8?B?MnV2cmV2aXRxWUs2RkxQeGExTUUzRnRlWDAydXN5bGpuR2FORlhzbEVBaWZL?=
 =?utf-8?B?SEhhN0hCcDlMeGJSSmlGSmZWdUU3OVJpN1M3aFYzekg0d2tkd1piTXE4QkRw?=
 =?utf-8?B?WHhiSlllSXQwMDNwNmdmTHYwSm5kSnpXWVpxQmZNNUxENjFoUFQxN2ROMUU3?=
 =?utf-8?B?cUs2eFREWDdBcEEwY01sc1VTc0I0SXJoTTlzaGg1QzdPeWNDUFcyVnkxeUlD?=
 =?utf-8?B?U05aYmFVZ1V5YjhwSmt5RVphcHhtbUpVYWZ5MmhOdE9RbHU3V3JLcDltelVq?=
 =?utf-8?B?YzNCMk1aRXlDUWJ0d3RSODY3b0tibWoreS9ucnBMdmZySFVXdG9wV2dMNHBi?=
 =?utf-8?B?T0xQRHJXNFB5SDRTV2l0SVp2WDlHZmNzQnpLa3F1SHpIQnRCRlFRVXY4ZG5T?=
 =?utf-8?B?dExjMXRRNDR1Sk96d2tKUFBoNW5pcDlKWVpOWFMwUjdjSEFNN3czMjRhKzJB?=
 =?utf-8?B?cHlQUURFQ2cwSitrL2wrNS9QMk1Jb1hHUHlkOHlJZ0x0R2JjMUpubk5TdC9k?=
 =?utf-8?B?SlZ3TnV4WlBZWVFOVzdxSnZXMWRDcFE5R0pJUGtGSFJacEdjall6anRvL2FW?=
 =?utf-8?B?QUZlejhJaHZJNmVQNVMweDVyTXA3cllIb0Z4MXNkTnBlamcxVUNqNVpSeGJK?=
 =?utf-8?B?VUozcVUwaTk5MWVuUjdDRlErdTZpeTA3VUlGRkJOdGF4YlhVcGZDczdHeWdW?=
 =?utf-8?B?MDhZdkM3Zkc3aDVMQlhpTFRpV2JFdkl6OUR2ZmRNV0xQTk9wbkU1aGczckhI?=
 =?utf-8?B?a05NVEJjRkw0QkxQNURFZkVMN2tiR09GZXdscXR2ZktiakVkN2dyc2lyZFhl?=
 =?utf-8?B?RWpUMkpZSVpWbGU4eE9tcjdsUzE3N0hNUlpuRGQvM04rREl1RjhFenl6NkI4?=
 =?utf-8?B?dG42WjFiSDFXd0VFSmZSZ0xoakRwV2s3RkVrYVRkMERYMENBd3oxd09OdFBZ?=
 =?utf-8?B?L2pzSEk0dWZYZ2Jxa2RaekUwQ01vWWFqMmFQZUZzeVRuK2s3alQwNkYwWGZX?=
 =?utf-8?B?ck0xSDVTMStMbGFnWlhlbndzSkJnV0Q0SUpaL3Z0TTNENlFMRnE0K2ZPeE1l?=
 =?utf-8?B?clhsWEhKWEc3UVMwenR2REFxMnpYaFlsdGc1MVc0MEJhbVpnamdPQUFtUVJX?=
 =?utf-8?B?UWRoTHROZ1N5T1N2RUhxUU1Oc3BlMVZoeW9Yb1ZaVnFnVDJpZTV3WjdEMGYv?=
 =?utf-8?B?bFNORHNlc0JQem9ZSWNyMWdvMjhBN1lBUGlWT1lmL1hiYVc5ck5nUEN3aUJB?=
 =?utf-8?B?YmtCYWZEa1haN2tNYUFINEVDM0pYaVloaXZCTnZVVmdmdUh5dXVvMjN0REJW?=
 =?utf-8?B?TktuR0ZEcWEvYVcxVGN0cHRiUDNLTSsrS0NYNXpSK045ZHl5d3VEZmdtVGZI?=
 =?utf-8?B?Ujc1T2dIVGd5dlQ2OTQrcDdLYk1yTmdOQVZaR0p6bXorK2RvS0M1ZWRrY1h6?=
 =?utf-8?B?Uk1XVWZVSXpWQkcySndlWUNQaWJPRGV2OFpQdTVaUVJITUN1RUxCdDQrdGFr?=
 =?utf-8?B?cm1yUTlwVGdLN0NRU0llQjkyQU45UkpRWVhnZ2J6eThuRXRXaWVRcVZSTHg5?=
 =?utf-8?B?S1BlbkZBNEVQN05TSy9WSEFhNmdiU1pPcFdGcS85TzB5WUZUdFowTTRmQkl6?=
 =?utf-8?B?QWFlYzh3Si9sblRLVExLRW9lTkNMNTRqMmpQUGd3RzMzWGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 09:23:50.3448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d5f34b-6bc6-4d3f-dc06-08dd12b30848
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7685

On 12/2/24 09:17, Vincent Guittot wrote:
> On Sun, 1 Dec 2024 at 14:30, Mike Galbraith <efault@gmx.de> wrote:
>>
>> Greetings,
>>
>> On Fri, 2024-11-29 at 17:17 +0100, Vincent Guittot wrote:
>>> Delayed dequeued feature keeps a sleeping sched_entitiy enqueued until its
>>> lag has elapsed. As a result, it stays also visible in the statistics that
>>> are used to balance the system and in particular the field h_nr_running.
>>>
>>> This serie fixes those metrics by creating a new h_nr_queued that tracks
>>> all queued tasks. It renames h_nr_running into h_nr_runnable and restores
>>> the behavior of h_nr_running i.e. tracking the number of fair tasks that
>>>  want to run.
>>>
>>> h_nr_runnable is used in several places to make decision on load balance:
>>>   - PELT runnable_avg
>>>   - deciding if a group is overloaded or has spare capacity
>>>   - numa stats
>>>   - reduced capacity management
>>>   - load balance between groups
>>
>> I took the series for a spin in tip v6.12-10334-gb1b238fba309, but
>> runnable seems to have an off-by-one issue, causing it to wander ever
>> further south.
>>
>> patches 1-3 applied.
>>   .h_nr_runnable                 : -3046
>>   .runnable_avg                  : 450189777126
> 
> Yeah, I messed up something around finish_delayed_dequeue_entity().
> I'm' going to prepare a v3> 

Maybe something similar to what I ran into here?

https://lore.kernel.org/lkml/6df12fde-1e0d-445f-8f8a-736d11f9ee41@arm.com/

>>
>> full set applied.
>>   .h_nr_runnable                 : -5707
>>   .runnable_avg                  : 4391793519526
>>
>>         -Mike


