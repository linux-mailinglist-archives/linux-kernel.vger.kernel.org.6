Return-Path: <linux-kernel+bounces-543800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4591DA4DA09
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE4F27A65A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B301FDE12;
	Tue,  4 Mar 2025 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YNxpxhow"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11022086.outbound.protection.outlook.com [52.101.71.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B611FCD11
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083626; cv=fail; b=MVZgLu5AHqJBGoa1fkpmySFrJ3IPXUP6I1zvfmbMWWJwoEeTA3gU0R+onOhJBU3sVtjaY3acEizvU7ktSmUZWLziV9AT7AYYHaB8gg0tT5+NBEFbCgZ2cgW/VwF1ibnyB2GPJGM4f8wivAdhoapJUdc6xCPcqv4aYnqyo3yOiqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083626; c=relaxed/simple;
	bh=cy6T/Ev7Kshqn9HbrjHeRtCcdSdoMPwncip/2e0OSiA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9NA5ZaczDWJIQoQOIv4Q3AYb1wcW8OGE5vCkk7U6tId6Q8wIfBdbJUtY6QrK6G0EiSfVk5BkKusQ584lvH6jtgAPP+3FDmwJh2YbD5t1Q4SxuFjnWJsLVALuiVWYiJoCCChx0w/gUQMycB/QbpTenaqRHE8r5VIDnxVwwBp12o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=YNxpxhow; arc=fail smtp.client-ip=52.101.71.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=konDdoDRo1ZwWwHEm7rSs3owuBw0UonLTaKlw86g+cz8yyct9R+DEJv6QphdAC2Wqx8fg/bb7WW6BhrCMu3UGT/3wcFzn2ChrMosEODWiiW5mU/wXAV9RlLvqJlfGFaCXnV3rJk/2RfMcT6UCHDTxFXTOkYYnIJI8Rl33lLz6BYgsXp1O5oFDOsZdr0QyCnbCVSQMLTGODK+cv59S2d3tvD7HZkv5mUzfMqTbp3NbTUvEnsdybo1zQmnJ5NE/yZC8zPKStpZA2NjjB+7C9z1taNudZJbV8MZXMrmZAZyC+dEKxnXnmlPlQSeBBzd/hzLMHiVMN2NqNLSbwMXQbc1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0ZWfI3y/biQqGgpqV1F22SZ9TzHRlQT3acxeTZXpV0=;
 b=hpWtw2rK4kejyWYezgiwsLPp834FOXNtqcmzY8ND1xI6LDhx9P6279sfoXVbhCRDYuFGWkaUPcfXHbrHEc7ydHZ7wZL2qKpXjT3JRmTv1MqUfWcYFk1cmvLDBRF3j6OkkglokPy0/jwQTG6NBeCQir21VAS6ssINkMzmgqdQvn/XJxEh3Jjg52IkkBMlts8EPvk24R/jQh9/0A+i4ISxCQX9fG1Q04zCWuorQ7fUlZuPw5gDH1X9NvIGj436B7z0jSafYEjhRIlVGqdMDnYoUZhwVQ+Hyd5J+NvdREn1T9RMwTDb9VPz91FGb/n3EVog0JsJhm5GDPj5DlzXk6kSEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0ZWfI3y/biQqGgpqV1F22SZ9TzHRlQT3acxeTZXpV0=;
 b=YNxpxhowWrDtZg+lj17PfFwNJFr/wxut2UaAwJ+U9mBXoAZ/dFUYQE+akM4xYnmQWPjqhhgpsb9sPu5mNtC+BTKWEyYQJ8qmEyKQxnSONBf+2PTL4XtguF521NIhhb+8SfhQj1g4AkC5UI/LmEfiYxOzrxeFszKfYKb71pqVGjJmnCCWJCkKjTC7eBypIRf/xP7Pvd3z768Dkcf9WLi9JiTbWVCqy5PP3gEu+BxSPAGnGyqNFFpq8oOZsajCbEqriI9fBmW/d5+xacG0aw97WvQZ1n4jUgWYE3VyYxOFja01c0BymNYKO3tLK9bJjz8RPfBE+U+FqNlONlTI0umujw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AM9PR08MB6099.eurprd08.prod.outlook.com (2603:10a6:20b:286::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 10:20:19 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%5]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 10:20:19 +0000
Message-ID: <b6e7766c-3e9c-4d65-8b6b-3e19140cb572@virtuozzo.com>
Date: Tue, 4 Mar 2025 18:20:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 08/17] posix-timers: Rework timer removal
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>, Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>, Peter Zijlstra <peterz@infradead.org>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.416552300@linutronix.de>
 <3e38af8c-1d06-49bd-aa30-f4e8b0263492@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <3e38af8c-1d06-49bd-aa30-f4e8b0263492@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0328.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::7) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AM9PR08MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: d6830839-38b7-44ff-0432-08dd5b062a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1N4c2U1QXh2Q25zbUEvNmNiYWM4OHVaMWRZVVg4dklSVnBwcDJOODZ4TFpt?=
 =?utf-8?B?a05mdEJ2b0J5bTE4VS9BV25mTUFvYkY1cTJzV01sdUJ5aEw2SDgxMk1SRStV?=
 =?utf-8?B?Mlh2ZzU2YUhIdVZ0MDdvNkhyWTZGQWJtSUh4M3FzckQyOVpFUHpsQkt0ZVNN?=
 =?utf-8?B?WUVLelJlOFZwR3BSQ2k5amhuUjRqTDB3RE5nVDBSbmUwOUtQVzZSejJNaEw5?=
 =?utf-8?B?aHEyWk5TVUx1Q2NGYnZzcGw3TUw5d1ErakZTWStOTG9oYzcxVDhJMWlUdnF6?=
 =?utf-8?B?ZUZ2aE02RkZVdkJheG9LdXZSdVRIU3ZUbldSSUJhUFFrbnpQWTQ0d0tjOXlJ?=
 =?utf-8?B?dlpRdHFIQ1MzeDRaVUU2emx6VnlzVXZzc3BQMzRaWVE1TlQxYXVqYWNjTXlX?=
 =?utf-8?B?Vkxubm1JcUMrc1V3TTM3R2lwQjRIclJOZW04T0tXOFlySTV4NDAyYnFDN2Q5?=
 =?utf-8?B?c1hWaTV4ZnowTGN1YTBJTjk0b0pjTEZ4Wm5KOWdNanQzZW1RQXV1YkE3T1dK?=
 =?utf-8?B?ZkNiUVVlYW9pMmZJY21JNExxN1Z2aHZGMG56SXo0THlDV2kyRHdOSGhQcWxl?=
 =?utf-8?B?K01TVjlPWi9CYVNZc1IvS2tPM014THVTZEJpNlAyWkRtMjdZSjI2UloycWtX?=
 =?utf-8?B?T1pSUVppdWZPWFFLR2prdDNEa3BMTGFTT3FvZVpKQm5XcXFtT3dMZDQrbCsv?=
 =?utf-8?B?NUpSRExTbDF5Qmw1WVhWcUtEVkVSMlZySmZqL2hWcFhDRW1IRzE5RUNJYXBO?=
 =?utf-8?B?R0dhd1RGL0FrME1HZ2RyVWJ5NlRmblhmQ2c3WW45cy9SQW5FKzZIMnM2aTBy?=
 =?utf-8?B?OW1FeDI3V29ITVVrRjVsVklKSGpDSjBzZEIwVGQ2U0E2VGFLQXFNQWZwdEFP?=
 =?utf-8?B?STIrU0F2STdib04vSE5NWmcrNU1mUzFoQXNmT0p4YWk5V2JIL1Q0M0YvY3dD?=
 =?utf-8?B?U25ZVlFvN2gxS2ZndjZMQVZvT0g1OFBYamdXY0c2ZjdmcTQ3bFJyTHVRNVpY?=
 =?utf-8?B?Tkd6Ty8wdzZvbHBGV1J5cTVtSld6eCtBVEJrM0lrZ1M4bVlRYnBiZEloelI5?=
 =?utf-8?B?MWd2dmNNT1dNQUZ5MDZwU1BrSml1NDlBU2xtZ3RVUVRnSkV4bjZxaW9tcDZS?=
 =?utf-8?B?RDVETzVoTS9kQ2JPV2ppcXFOMWJ6MmVBRzJyTy9xNVJqUld0V213azd2V0k0?=
 =?utf-8?B?aHdXazJSTGNMWG1VQUVMc1k4RS9YY2JTUVByNExtVGVYK0R6UHUwaldzNHdl?=
 =?utf-8?B?L3ZCdWdCTUhHMnB3MTk4RGhrQzk5Vm1HZ0NHWkpieis2VXdrRmhqWHliUXVR?=
 =?utf-8?B?bUM5cmRDS2VqUkR4OGtVTGVqSmp1TUsrcGphYVUrcGxTNWtkM1JrMm9QamxU?=
 =?utf-8?B?UGRaNjY0dDNUN3lKcm5UeFNDM0xuR3JTdWJUZVFEc3pUY0FFVC9jZlVqMENs?=
 =?utf-8?B?bGJsQ2V3aEN3M0w1SThsN2oyUmVNUDZrWFZnOWk0b0FEckxsT0s2Ri9zNDh3?=
 =?utf-8?B?SmJyTHovTzViT3dwMGxKaHB2UzUrMGpvNHQ2YmIvNkxGazI1L3c3dDJBNGl1?=
 =?utf-8?B?M2NzRUNQZUdHbUhsd1h0ajNIRU91MHN4YjJhMDg3TFVSS1dBV2x6b0tZb0ZL?=
 =?utf-8?B?QlZiTkNoVDRGbHpkZVJDTjRRTXZxVXBiZXJUaVhESUVIWEVGYWRYaWxRZVEr?=
 =?utf-8?B?RUJyWW9menBaVFNpWnFxemxPVHFWdGUwUHFVYnNhcUlKUm5TSHJQd0xGUTVF?=
 =?utf-8?B?V3IxMndNQWN1Rm1peDgrZ2hkSFpGZlJKQnBqaWpIMFlJS0FYY1Z2TlMzdm9u?=
 =?utf-8?B?YzYwSlhLWlVidHpaNlpkMG9zaE9qVXNOZ04xSGkrcXFuSllveFpxM1pTWnpu?=
 =?utf-8?Q?oQRHlcrGsGirE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3NJUU4zazJGRUZRWDBGUmN2NEJ4ZmRlSmJnclU3eDI2aXovU3l3VUJLakJY?=
 =?utf-8?B?MndhSUhId3pSVlVoK2lETWdyNGlCN2lXWTRBMjdmTWpTYVRGaER2MS9Tc1V3?=
 =?utf-8?B?KzZlVmRIbnp4Ym9zMzdiU3EvUVgycDY4VDRjSkdoZXVGQmxvL21aS08yV3hS?=
 =?utf-8?B?K3MzWEhuMXZoLytqZ2dQZGtFdGxmMEgxNHozVU1sd0ZmMVZsMWdhRnNYcXZJ?=
 =?utf-8?B?NUdSUlZ3eXg5TjJIVk9INW4yNTc5cXhOOXl4WW9IMG1sL1VQYUZSbXF1ZWZm?=
 =?utf-8?B?NldFMGlRcGtUVW9ZRnhBQ0JqTGxKZTgwNUF2N0lhV2cwMThkd01DNG92WWVC?=
 =?utf-8?B?MDFMNFljQ0VkbXpydFl4cDNONndOenl6Slp5d0tXai9aT1NhWFpiTDlYSkVH?=
 =?utf-8?B?dWFrOXA0NzFwMVg0VUo5aWZUZGFKOFBFenEzMFRUS0VCNEpmR0l1UUNZUnVw?=
 =?utf-8?B?Q1RuYlAwRC9UWDlDdVhNd0ZFTzU3MmxDSmkwUmNsbjZCMWk3ZTN6Y0JoUFVT?=
 =?utf-8?B?VGhkSVNSMHErZm81L3NOSEN1eGp5bXZxS01jQTRybW5GRDBtem9XQnorNW4x?=
 =?utf-8?B?c0N3bzRXZXNEZjBoVmhwUkEwb2JtRVJSN1Y4eXJLTElkQ1gwV2tOdlFrczdj?=
 =?utf-8?B?Zkh2RVpLZjFqaElNRk9ZemtFZmRyS0wzeHN4WThIR0lhZGdjSWRwZ29PUWhQ?=
 =?utf-8?B?Ky9FRHk1eWE2NitBMWRRTUxEQyszMHNGcktCeVdDWnlaVHBlMXJjaWpPZ0lD?=
 =?utf-8?B?b3AxbWh4ZHMxalB4NWlBaHh6cStDZEQ2MVRaam1TNnIvOUpaV1Y1WEVKMjhy?=
 =?utf-8?B?Szdmb3FjZzhBTjY5d1U0c0tkQlJzME84QTVLZFgyeTJFUmZQTlhETGJFM01L?=
 =?utf-8?B?cW1tNS9mWkJDY24veUV3S3pqbzVhcWlDTGZXeklISkZIS0NMazBNa0R1MGhR?=
 =?utf-8?B?U2p3VVgwWHRnNk5iRTlzOEdHZFNPb1dyeDh3NSt4VUJXKzJpWm9MNVlmNlFx?=
 =?utf-8?B?REVTS3JObURTdlI5c1p3OHozTDRLNVExU25OSnNHRUo5NXpkOGkzL01MZVph?=
 =?utf-8?B?cDZKS2o2Z2FkTmRjWUVHUXF2eERsdTUxVlMwYXF5cU9CK2c5QkgzVE0wY2RC?=
 =?utf-8?B?S2ZYcHEybEtYQ2NwdDRUOWpDaFZBREVJWkJwRWwvMTRjdDBRSUswSitBTXlm?=
 =?utf-8?B?N2ZubHZvbFFNcWJaOUU2RVZiYjh0TnFydWdUMURiYkVvZnR2V2NxTG1sS1pT?=
 =?utf-8?B?YU00NXhESUVJNlBXclJQNkpGTGxUTDlyTFBsaDhFd2VseWo2RlFZV3p1WG9K?=
 =?utf-8?B?TFJESFFyUm01cG1vc2xheUd3WEMyMEgzbitWekk1MWJvQ3ZTb0RKTjBINngx?=
 =?utf-8?B?VUx2aG9lMmxscTdVeDc5M1dNZms3M0JTaUZsbkh4OVhuWENzVUkxeHlhTjdJ?=
 =?utf-8?B?cUJtRldER2wzT0FTaWFLdU9KRGI0aHZnbFlXcE1reGdyVHlZaS9hT2pHejY5?=
 =?utf-8?B?QkNEenRxMDdUM09qaE5vY3BtRWZKRUlEUzFaOU9IYWZOREk3UHFiZEorOU55?=
 =?utf-8?B?NmJiOUZRVCt5NlRCR3RKV3NhSEh2VGE2N2FKRk84anJPQkFZcGMvcXdaY1Ja?=
 =?utf-8?B?eU01UnJGMnBsSlZWVkF5NW1pNDBXUmllRmlKMGxVWkpnZ3FQT0tPV1J0NzRy?=
 =?utf-8?B?UjFnczRJUkh3NHZOdW5PdHRkSGtBQXoxNVpoNzFmTE5WMDdRZVFDWVREZ1d0?=
 =?utf-8?B?L0lxbTdoS25Nd0FHa1V3RVh1T1lGbHR2eEk5WXR3VjE2WW1XM1J4MHhvSkht?=
 =?utf-8?B?ZU91MlNMYm5IQldvQ2IzZUo1dmJSc2J2OVlJQ0pqcmF6UTdXd1hpWC9PU2lt?=
 =?utf-8?B?OG5CT3RJYmllSktqZzd6QnpheWZ0SjFKQVUxU2Vsc1drWHIwaWtiMml6TXJz?=
 =?utf-8?B?YlJNSFQvb1F2dkx6VmhycWoyVXp4MG9OMGtJSWlZOXVnZzhPMVQ2c09jM0Fr?=
 =?utf-8?B?QXlpNWo3eVgzNy9MSlhFeGNCbU0weHI1UGRyTk10dmc2WGtVaUx3OVRhNTlL?=
 =?utf-8?B?OU5JSDJaKytrbEZNU2hPbk0xNDN5Y2VUTUd2V3VhUjArZk91KyszWlFOQ1Mw?=
 =?utf-8?B?aGhkNWlBeDY3SFZ2SFF5aWNFbm1nanVtV1hvSHd2TlVudXZLV29uSFRkcXZF?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6830839-38b7-44ff-0432-08dd5b062a46
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 10:20:19.5354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdyZhRl96xLJqV/2bYw9ankCHRlUufrZplUakFyhXEHvU/8+DYr4D/21MYVSYMqv+FJE+EM/hhMh7UWv4+jT9ls8nTKCHGoNAkt/ifkGVP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6099



On 3/4/25 18:10, Pavel Tikhomirov wrote:
>    > -/* Delete a POSIX.1b interval timer. */
>> -SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
>> +static void posix_timer_delete(struct k_itimer *timer)
>>   {
>> -    struct k_itimer *timer = lock_timer(timer_id);
>> -
>> -retry_delete:
>> -    if (!timer)
>> -        return -EINVAL;
>> -
>> -    /* Prevent signal delivery and rearming. */
>> +    /*
>> +     * Invalidate the timer, remove it from the linked list and remove
>> +     * it from the ignored list if pending.
>> +     *
>> +     * The invalidation must be written with siglock held so that the
>> +     * signal code observes timer->it_valid == false in do_sigaction(),
>> +     * which prevents it from moving a pending signal of a deleted
>> +     * timer to the ignore list.
>> +     *
>> +     * The invalidation also prevents signal queueing, signal delivery
>> +     * and therefore rearming from the signal delivery path.
>> +     *
>> +     * A concurrent lookup can still find the timer in the hash, but it
>> +     * will check timer::it_signal with timer::it_lock held and observe
>> +     * bit 0 set, which invalidates it. That also prevents the timer ID
>> +     * from being handed out before this timer is completely gone.
>> +     */
>>       timer->it_signal_seq++;
>> -    if (unlikely(timer->kclock->timer_del(timer) == TIMER_RETRY)) {
>> -        /* Unlocks and relocks the timer if it still exists */
>> -        timer = timer_wait_running(timer);
>> -        goto retry_delete;
>> -    }
>> -
>>       scoped_guard (spinlock, &current->sighand->siglock) {
>> +        unsigned long sig = (unsigned long)timer->it_signal | 1UL;
>> +
>> +        WRITE_ONCE(timer->it_signal, (struct signal_struct *)sig);
>>           hlist_del(&timer->list);
>>           posix_timer_cleanup_ignored(timer);
>> -        /*
>> -         * A concurrent lookup could check timer::it_signal lockless. It
>> -         * will reevaluate with timer::it_lock held and observe the 
>> NULL.
>> -         *
>> -         * It must be written with siglock held so that the signal code
>> -         * observes timer->it_signal == NULL in do_sigaction(SIG_IGN),
>> -         * which prevents it from moving a pending signal of a deleted
>> -         * timer to the ignore list.
>> -         */
>> -        WRITE_ONCE(timer->it_signal, NULL);
>>       }
>> -    unlock_timer(timer);
>> -    posix_timer_unhash_and_free(timer);
>> -    return 0;
>> +    while (timer->kclock->timer_del(timer) == TIMER_RETRY) {
>> +        guard(rcu)();
>> +        spin_unlock_irq(&timer->it_lock);
> 
> Maybe "guard(spinlock_irq)(&timer->it_lock);", since we already use 
> guard constructions everywhere else?

Sorry I'm just stupid. Please ignore.

> 
>> +        timer_wait_running(timer);
>> +        spin_lock_irq(&timer->it_lock);
>> +    }
>>   }
>>
> 

-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.


