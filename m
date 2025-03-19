Return-Path: <linux-kernel+bounces-567754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D17BA68A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576F319C2A27
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D55825484D;
	Wed, 19 Mar 2025 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A1QsgFSe"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4E253B45
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381666; cv=fail; b=frvBQohYGJQZpQ+aQoa26MyNA3mELzq52VW1guFolKfw/8p1efXvxAr1fRDH1Ze+rHfustAGQhj79ufrUGBRbWtzm2/5Q+E93NdWg1eWUJk2g7ftjIFP0xOhBhlEs54NH1MXPMrg+l503xfDZN6tjTyikNCWhM9fl6gJEr2zqvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381666; c=relaxed/simple;
	bh=pAAw1sn8SVB1gHDJogfvxyMveVzSlh1eXhMtMXAWudA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fx0qp4C+hLfpoNjsatokV4QfCiLIC1N9g71wjbzvnWh7Gjuo2yMRvtZnStf8khtqzvekyNfisyp63JVDhcwDqk/8yzThCkGYfbx3EIkYE8mwiuCxRStaova/oItv5DzUDIjySNk0nKe0415ax/w2fU5zhp8QtCuuBgqzrv80dZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A1QsgFSe; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nP9QOE+0sqaK0Ev4kBSIfLLzp54jTOlmnBYx5wbnmXAj1LVd8R4hXLmWzpAQUwqz98TroKK4IluETPuP57Jc1+9Ld1bEhboAX2dzp1X3Xg+eFY66ydtnOyDbtFFh1RLkoWHkGfoqEboIot6UM7Ln52V+RRz/ySh6rtGnoQS2LlywEWwTAXKb9+sy2j5+vZaohNGmQEwAChERSu9+XRxzY5QECMBlaIpykzncpuVu13GpiVS42J/EUTGp7bU818NPmLCg/AZUEbYza4A5yJ+EzXDG0DTDE0GgtEzD+4kXInNeY+Q8hkwm24aQGIpU/RaN2FgHVwRo6t///ooYeSkLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojB2sjxmGAGAnIWDpxC/LTJDFLI46UUf4v2AX9mprLU=;
 b=C8PDgPq0ZnzCny3p78NHlEbJGZxj2aEo4ve0pr0ne69OOJVV+1cORtAOsQVW31dty1TGl6cKj/IB5GfW0apPspeBm2urLCvy7Pm3mtCZCRBJ5vVeza20AtlxjMy1acpkB/Y95b5qRde5cOHduUeJ5QBJFnQQGya/jB8D0geO2ajoMZS3lmRZLB4eBWydXuihkH9ATD0nLaD9cW9NZpAMSt19MoprK9Aa/hggrfVSDgg/06hc4eX4mF56CoohHsI/Sn9xXe4E1cQWt/vGrKl2Y+8SpMojrPXJPSTkg9o+gje43TMIDMqaAdhY6KnY6m+4rLikQmzYB13UhKcM5SihkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojB2sjxmGAGAnIWDpxC/LTJDFLI46UUf4v2AX9mprLU=;
 b=A1QsgFSev9x+SCkxsO8ftdGPVF8LAJbdMfcnETOOuw2qZojJApIeg5N4kMHjLJN60u6wJ84RUYm/EGsHj2n0AypFlLtMzxgTzauWLJTMHztgSfCVmWTHzS97yJckx2CwwimgYK8WQEU31S2i4uKaIf6sRfQYm1+Qz59lW53kIjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:54:22 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:54:21 +0000
Message-ID: <d1dec8b8-10c8-4da0-920a-d1f744543253@amd.com>
Date: Wed, 19 Mar 2025 16:24:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/x86: Check data address for IBS software filter
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Matteo Rizzo <matteorizzo@google.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250317163755.1842589-1-namhyung@kernel.org>
 <0eb55fa1-3b03-4550-bdd7-c7c50294dcbe@amd.com> <Z9m20YMkMfUDBxgv@google.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Z9m20YMkMfUDBxgv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 19bc5677-9d94-4eee-234f-08dd66d4678f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1JDUjZVQitjMTUzamQybVFJMUNiMDlYNncwNHRvM2c1eGdTVUFGNnpwRFFF?=
 =?utf-8?B?ZmJuZG1QbWgyc2ozWVhnMk00RzlQQmNEeFdyUkNrT1ZCbmxJYUVqRnBnY0Vh?=
 =?utf-8?B?c2NyRXlHRjJDakhMSGc4YytQZW1IRzhoM3RSREdWMit5Skl5THNQdHZQcmJ3?=
 =?utf-8?B?V1JPNzZPM3YyNVdOWUp3cHVVc2NxUFNqWU5VYkZ0cnR1ZnNFU29QcGQ5ckdm?=
 =?utf-8?B?TmtSaVdiNmg1VkNjWWJEZXpFNk50VjVvYzFVRTZaTEFkSDRnR1ZFenhXbURB?=
 =?utf-8?B?c2VOalF4NXc5cE54cS9lRXpmMWl1OEF0WFR2KzlidXl1a2VwcnR0R3g1Q0dE?=
 =?utf-8?B?dUh0c3BnU085NVZiMFJrbDZERzkrQ3lnR1YrVTFsVUhwRmE0TEtlKzBHdHJJ?=
 =?utf-8?B?VHhwbUJnYmxNZnVrUC9QOXhYbVpIa1hJWklmbHRLaWtFUmY0MnEvWWRJZXNa?=
 =?utf-8?B?dDJ3WEU5cExwNWovYlFlN1JoRU55S1FaWDlYWkYwR2VaeXJIak0xWk9kcTZU?=
 =?utf-8?B?L3dKTGJhblNIcVBvMnFPbTNHQmhtYjlORmdubCtmSUl4M1dtTWkzM0xtc2Mz?=
 =?utf-8?B?YjhSZTRjMWMrQUU5dzVUWXdHQktZaEdBa3ZwRmlGU0IyNGpxR0JBR1Y5eHpP?=
 =?utf-8?B?YlBtODQ5Y3BuSlE4b1BUeDQwRmxkeGZjQVNIMEJBaG4xeGJlbUZOUFBGaWRN?=
 =?utf-8?B?V1hTUm9zYjVCcTdFbVV1QUJUcno0VkUyb1F5cGN0MjdibU5ieXNocVdFNGNv?=
 =?utf-8?B?SFNXZ1R2RFMwU0FLdTBMdHFVV0t5R1c1QnZRUDI4cUVJSEZYWS9NSWN1MUFI?=
 =?utf-8?B?ZUltcUpucjhtejJTS004QkQ0N20zV0NsbmxzZVFJWjBZYWFRUzcvNmNvMVJk?=
 =?utf-8?B?U2w0Mk5HMlJVNUpaRU9POTBWbUZyL09Jb0NKRzlBdzcwUEtZblk3czdvVzM5?=
 =?utf-8?B?U3AwZERHVEhHYTJmdDluM0hKVWFUaU9xNGQ5akdlL0dUTnFPL3pGd2JwY2tB?=
 =?utf-8?B?eHVyTzdsQTl4MkoxQ3FBOU42QlMxcVJxQjcrRlpnSTRSRGdoaDlLZExWK2l1?=
 =?utf-8?B?bTNsNTEzMDRSd2RVR1JpVmJwbXVDdlEzek92UWo3WXd3WHBpbWRpOEZ3UjN0?=
 =?utf-8?B?VVpZTWxZT0IxU3lON0U1YVdPS3NMZjZaeU9YRUd4UW9HWEcwclVaa08yNTY2?=
 =?utf-8?B?R2wySUJpdUdrNmtWSHczekdJazNONzJ5UmFyalZ5VytTQm5yRm1yeHdxZERR?=
 =?utf-8?B?bEgyU3AyMXhKcHRCV2laR1JvbXNwcWM3Ni9LSGJFWnNVNFpPU2tDeStmTXZl?=
 =?utf-8?B?TExxVHhWd1M5clFXWXdBTUt2RWNkU2lBQ0lTLzVvb2xDNWwrNUI1RTdaYXVt?=
 =?utf-8?B?bHVVRnNGRnBSeHR1ZlI4K1Nnd28vUGRBeXVoUmxKVGg5UjF2cTNGYzQ2cVdh?=
 =?utf-8?B?NmIzQkVyMDg2ajFvTm00ZjdKUmFPampKTGJ4UWxDUFlvUmd4TVZzTzJKSHNM?=
 =?utf-8?B?OXIrSEY3cGJETnFiSFA3bWdydUhSR0tSTHRBcnpaSXBpeDFPV0xJVTNsMFli?=
 =?utf-8?B?bjNLSDNITm5LYTZhVzZTZ3ZndWRDbm1oUUd6NUoyNVFycDBxL0Fwa05SNWZP?=
 =?utf-8?B?QkxLUHFCV2QyMWNiL0NmT3EyMEIvd29mZlRZSk1tTGRGOE1VT3J3c1FUZG0r?=
 =?utf-8?B?YUN1dkd0MzlTSFlQajh5a2Yza2hUQ2lHQzgvZnd1WnJpeEdwa2NxdE92MHVF?=
 =?utf-8?B?Q3g0WGJqWEJxblRKbng0MjR6ZFdXcUlzdDJFRjExNW5kV0ZROXJYL2JHbEtJ?=
 =?utf-8?B?WXJ6c2hNMGtPRHlKWkxDZ3pyeXNZRityTytwQ3RkSVdkNHNVdWQ4b21QaEhW?=
 =?utf-8?Q?x1CM66Kdi5uxc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEhmS2o1enZPdDBxSkZMZldsNWdtYjlqYWpkZjBwZnNjUlFNNTVkRFRSRHlX?=
 =?utf-8?B?VzFFM3d4YzZMQVZ1QW9xZVA1QmVCN1NBNmVOZ0ZqNUFGSFlBcEFvT00zS3hj?=
 =?utf-8?B?bE1VYVVSaWVJaUk4ZUFVZ2ZCS2U3enhhbVNZNE5RL0ZVVGtEWWoxaUZVaEh1?=
 =?utf-8?B?ekR1ZFFtOUFnaU9jaDdteW5jZkxSRlZ0RDEyVUprTXV6M2VLaDhZclVWZVBh?=
 =?utf-8?B?MU9QOUxlMmZwTXRpRTBoc3hRRU9qZUtLNWlxL25GaE5mV2ZweGorSXVhN2FT?=
 =?utf-8?B?Vm1IWDJXWVFjR0ZxNG5oWlFPRzkyMUU3UkgyUzBQVXNiWklhOUJJV2JEVFhl?=
 =?utf-8?B?RTczc0JBQmpoSnkwc0M1ekdGY0ZoTEh0eG9CRnYydkZrcWQxeUpPK1lmN01J?=
 =?utf-8?B?REdYSUZJcWpxckRaaW94dm5obUp6N3pYdGNkTzJNaHFhZUM4T1dzTmRyUkdV?=
 =?utf-8?B?K1UzUXIwU2UwMFA0NjZUejBaUWhja0xvM3JTaHlHNGxUQ0wvRWFzeHBpRmxv?=
 =?utf-8?B?dFZvdnI4clpQWVV2cWNYa2dvS3EvNjVESHNNaXdMY1VmMURTVDlJQnVTTVdW?=
 =?utf-8?B?ZnkwaXBWbE1KWUFBQ3pzcVIxcW5BVjUxbVFhQTc3UUNhSVVIQ2UrNWZtS080?=
 =?utf-8?B?RTcvOHBJNW5PbVVxQXFGVTRPaC9STU1NVkN4eWpQSE9sMnZJUG9hQXFlZ1li?=
 =?utf-8?B?eDhSaXF1aUM2Ykl0NkswT2Q5SUtzeHh5NTExOEtjOUVVOGpnalZXUjJiTStp?=
 =?utf-8?B?TFhmdVVlNWIwdXlzbWg1M1dYb3gyRWF0Q1I4aENJelJGZTJlL25uSHcyUlA2?=
 =?utf-8?B?RkVIdXB6N0pUc25aQ1ByWERwaWNEdUcrVUJqYnJWREVjME9lSjRwbmpkVXEv?=
 =?utf-8?B?WGhJUkhzVThEbkV1NFpzUlpJSFBjOU1WNU9HWDhuaDFjZHR6c2RrQ0xENUgv?=
 =?utf-8?B?emd6ZG9UZGhZR2ZSMUhtSjZrM1BJQXFJRW9DNENIWUc3dVcrM0hqU3NFUXJp?=
 =?utf-8?B?RDRCWElxckVZU3ZONlpoTU40U0pOY040RFNrMkdsK0IrM3dZLzh0Y1FRcHhi?=
 =?utf-8?B?RXZSbVlLcmphV2RNM1I3VjB2S2RDSXRtTi9zLzZYc1YyNmNaQ2ZNOGkvWUto?=
 =?utf-8?B?M1RDY2o2TmsyQWF6QXBMV1hJQ1dXU0RUcDJTbW5iUTdRR01mR1Z6VHorYWlM?=
 =?utf-8?B?Y2dlNm0vU3k1Qnc4Tkc4YUJzWHB2dTdqbVREZFQvUTc4MlIrMlY1VzkwRUNZ?=
 =?utf-8?B?aVlxQ2hPRi9wRHVYNjNudVhIVVl4VTFwbCswMGlZSllER2tqU1VqQThZdHds?=
 =?utf-8?B?Ykh4VS90Y2JKa2twU05KN3pzTVZuTFhrSkZxeTB1QWcvWlRaUjVnMU0vSTRV?=
 =?utf-8?B?OXFuK3FkTmlUSEJyMXoxaThYdDJDTFhKQUtrNnNzY3Q5eGdwMEwwdXJFSUlx?=
 =?utf-8?B?TkxkUXk0RlUxa1c5YlhKdVFFbnozWkE2WWVXUnEyQzFnNWNYNUw0Y1oxTFVL?=
 =?utf-8?B?bk4xZmI5M2RVdjZxVTgwUU9DOTNPd2w5Q3VvaGwvbHZvWVc3aVR3SlB0Sldl?=
 =?utf-8?B?QUxlL2hFSWI1QVg4QXQ2MjB3MnFtZEQxRGY5MVlOdG05WXVnalZYUXdGUGNS?=
 =?utf-8?B?WUNucXhCc1V1QitWWllHcENRSnJZUkR4Zk14ZXdkOEtsOUxKQzByQURocEhW?=
 =?utf-8?B?MXR3YXltS2xzZGtpT1M1T2dhaFhXZTk1N2xmZy8yUlB4VUVsenl2QnUyODhC?=
 =?utf-8?B?NllROWRWRzZhS2g1ZXZUNlBnbTA0ZGYwaWUwSHJ5L2NSR25yNDRFL0Vlb08w?=
 =?utf-8?B?dm1FQjZ4b2lMWnErQ3JicEN1dWx3VUJ2RDkwWkZrUmRJS1d3T1RRdlZIOWhh?=
 =?utf-8?B?MGtEYlBUNmNpRU1JMnFqRi9vRGxLQ2Vhdjg3bXBSMGpJTlQ5UjBzSHNLSmVM?=
 =?utf-8?B?YWVJWWY2eTEyMU9SOUd0Q2RGd0JTeUFvMlN6WEZQU0FGYUNtMDlwcUJPK0h6?=
 =?utf-8?B?WUdsNVh2UG5VY2lGYlZDVGQ1ZkI5dXpKTkZ6cTVtQUpXSGpvcUM0NHo5NS9U?=
 =?utf-8?B?eWpPQVBEcVV6bkpjbURZSzdSSTlUM1ZMbitlSmJ4N3RGbDhwdENUUVZOaWhG?=
 =?utf-8?Q?mVzEDL6tep8LQL1IU+tuiybr+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bc5677-9d94-4eee-234f-08dd66d4678f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:54:21.6695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QfWdZ9mG+8rMvofzpk48tsFLF6+IZlpqVzzlbNdRh3ugODMiekkxOLfSUjeeAeNgsN328+92MHxqLxBr1MU1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

Hi Namhyung,

>>> IBS software filter was to filter kernel samples for regular users in
>>> PMI handler.  It checks the instruction address in the IBS register to
>>> determine if it was in the kernel more or not.
>>>
>>> But it turns out that it's possible to report a kernel data address even
>>> if the instruction address belongs to the user space.  Matteo Rizzo
>>> found that when an instruction raises an exception, IBS can report some
>>> kernel data address like IDT while holding the faulting instruction's
>>> RIP.  To prevent an information leak, it should double check if the data
>>> address in PERF_SAMPLE_DATA is in the kernel space as well.
>>
>> PERF_SAMPLE_RAW can also leak kernel data address. How about:
> 
> Thanks for your review.
> 
> I think RAW is different as it requires perf_event_paranoid == -1.

IBS allows PERF_SAMPLE_RAW irrespective of perf_event_paranoid. e.g.:

  $ cat /proc/sys/kernel/perf_event_paranoid
  2

  $ ./perf record -e ibs_op/swfilt=1/u --raw-samples -- make
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.371 MB perf.data (3957 samples) ]

  $ ./perf script -D | egrep -A2 "LdOp 1.*DcLinAddrValid 1" | egrep "IbsDCLinAd:\s*f"
  IbsDCLinAd:     fffffe00000000e8

We have two options:
1) Restrict IBS + PERF_SAMPLE_RAW to privilege users.
2) Remove all sensitive information from raw register dump before
   passing it to userspace. (Kernel data addresses and all physical
   addresses are the only sensitive info I suppose?).

2 is better IMO since it will allow unprivileged user to use IBS
with full potential. wdyt?

Thanks,
Ravi

