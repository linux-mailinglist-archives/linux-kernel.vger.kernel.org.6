Return-Path: <linux-kernel+bounces-522086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28833A3C5AF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D1B3A6495
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10972214225;
	Wed, 19 Feb 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="F6AlDrlU"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020119.outbound.protection.outlook.com [52.101.191.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F452862B2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984924; cv=fail; b=EEj+6GWMxmUqXSIv22TLW2enkmwYOGvuDfIL9L54Z094k4TuXtj07sOfT0uj0+qIqWNrsNt3q88U+Isotkegqe+I6n9OAfx+D18mjrDFGhmkkLHs6tGculMLflS5KdZ6zstaorE+X4tS4DYZne2pDC9z8zsenzbwd9/jOhxconY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984924; c=relaxed/simple;
	bh=FqGcLkvnvbWNspz2cxuPRMbWOiDvMLhfPfGPpKO/3MY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ojiwZkKm1/lxaHF2IavMLPKz0JDNFjIZxIAcqHCryCRB3BlOljmAv/h0clDTYF349tfiZrTfAH1GsUdsbSvBCcJrxKhmeHbuEmwPFEPSYp/1wMh/DCwX6H3ZkU8z5UufwhGTeJqYxPahEH5QnEIEptrzLmowfnT603+ztpoT8Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=F6AlDrlU; arc=fail smtp.client-ip=52.101.191.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzg//5S0sSIY+ql6204BWGibsTyBnV/UY6CGoi5Nusskjhrl+TPGZHuhVGZWuRfd+FGUM830dbO6migLLdEFfvUchKZiBhwQNLQDlhT9hk7OFWbWa2ZSvSY/QJpjzAwnI64zBl/3Hb6qb6nmY8sXwfMLmWZm8q8fgLHobtT+D/X8DeBMT4eUckSf5EGpSJBc6uDR0HEZs57rA5a5eU4fD8Pt9MoLf8PNyGV3yHfYN7cjcPuodF/78yyaUC3fjw1mfnWr0vUEXxt2DDHh+Dm8Nf3kF6JecLwdT03PtCqNpWGwpAcUAcu184Ql1GU/7UE5mSwhb7XSzOtC11aVYDE36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ufg8erVuoILmsE+vKWt1EuxSvhMwPapDWNygyoUY4ys=;
 b=sorMjtLorrUi+ZWD8P+nrMvMyI+PCHOnk8u9T3oyLswD75UYDT1lZTmDPOXX4iDfkW8Zb1YE0koKWhwqo8kJPLijL3tX3obdP6FZ+EylPfSnReCGMzaBgDkavgdSyuuGvZz0C3DKOI2p0Iny5MqW7xUqecvnp6Eo8sGOLOhHwTj4b7gHxOQ5D1Xl8OviUki6iJOqUHh7nuvCa1ulbMKPD0i9gixyANRn42fVeVa5c7r0eMWGo7jKmy6WeDm2i2eq7QnCGjUMcRl9O56k+ZSUwdyBjQSRnwqNBaUYYMLKpcjOb9IituXuHPHUzWd+xO1674hv8XZiEJ4QsuqXejefcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ufg8erVuoILmsE+vKWt1EuxSvhMwPapDWNygyoUY4ys=;
 b=F6AlDrlUyM4B4eJ/iW5LHUFJv3BZ7mA4zgU07uxRrUh3c+3a6MJwsyuY+YyWyDEs2NY9p5TjNi9p93tcMYLpIqvL5YdISEvB7PxcnGerlrb3/RQVAilg6wqQye//c8zrSlSGhuE1mM3a2D5e6wN8fYuHq/+qlZgGgNUJfLvykOt7NsbfrImyVO8Pc/euJCs6JmoR2M3G0YUOVXixrvmZEmByWbZJQo/C5UI1eGr7Q5MOy7OqNP1tBqA6ttjp442c5fUcHGgk9iv55Iw2ieo/Dj2Ril7F4k78APy2eSBSS3lwRM30XxX445bZxE8US9YYroA1O56lyEV/iuYFfPOB0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB9116.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 17:08:36 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 17:08:36 +0000
Message-ID: <0493b3c4-c37f-4ddd-93ee-6d7946e42846@efficios.com>
Date: Wed, 19 Feb 2025 12:08:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] sched: Move task_mm_cid_work to mm work_struct
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, linux-mm@kvack.org
Cc: Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20250219113108.325545-1-gmonaco@redhat.com>
 <20250219113108.325545-2-gmonaco@redhat.com>
 <8fc793e3-cdfc-4603-afe6-d2ed6785ffbb@efficios.com>
 <86fad2bd-643d-4d3a-bd41-8ffd9389428b@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <86fad2bd-643d-4d3a-bd41-8ffd9389428b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0293.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: d72f6565-a390-4cfa-7c8a-08dd51080c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUtaa3FCMjdhbG9JQUphZXNWRitTRkRnTlBickdrQ0tJdDJ5Z3BINDFtT29q?=
 =?utf-8?B?cC9tbkh2RVViSkluQklrV3l1bVhhVW5hZWVrTzZ3SlUwMVJxbkhBdHpKS2hF?=
 =?utf-8?B?QkNxZXMrMG5HRGpZTEJ5ZnVBakZqaUs0Q1VwcWU5cTVwUG15dzRUbDNTczNM?=
 =?utf-8?B?K0pHNmRCbTBLd3RWaTFXOU9hZVV2Q1cydEs0bDlIVmMwb2J6ZEtJMHloRFN2?=
 =?utf-8?B?TWEveDlWano3akVBQThwL3FoMWdTT054aUN6ZytvWmY5REt2VFBORzJCaHl3?=
 =?utf-8?B?dEVXb05pZWliSGhaeFp6WDZIQWlCR3lrVlpORnRIeUFwZVV5bVJMdXI3eFVt?=
 =?utf-8?B?UkNKYTVXR3RWb00zU09DZzFWZXNadEJHN29tQTZhMmVDUnliYVYrblhEdCtV?=
 =?utf-8?B?aDRkTFQ5N3BLc0tGYVpFK2c5bytjM3N2d2RUL05NQUNtZGJoSHRXbmdydWts?=
 =?utf-8?B?aEpmeU5CdzRSdG55bytaTzBrRHBNckJqY0ZUQ0p3OFMrdzNaS1hoS0tRWG1W?=
 =?utf-8?B?N29YeHhHd2NmWEVtaGo3cFJ4ZWw2T3FhdDVuSHJzSk9XUUJtRTk4bkdpK05i?=
 =?utf-8?B?cGppV0JQa3puT3dkVnpTcVJKcTYvSElYRDZBNVR6OXN3QlNiN1RxM0gwaEph?=
 =?utf-8?B?clhJWnlVd08yRTdQS051YXJzdEtTMHRaU2NBRXFncmJ6UTBlWVYxTjRLcndq?=
 =?utf-8?B?UktZQWFQNTdDZUQrNENVMWd3ZytZZ1hyWk1lbis0Nk9WRzd4dG9wN0J2ejZm?=
 =?utf-8?B?a3pDOER1SC9sWUZhQkRuK1VVOHNKcEl0VFRPTXVDWFBPOHl2cEg4dVJJVVRt?=
 =?utf-8?B?d21BaENXYUgwNjVlbWlROG5oN2hxU05iL3JhUGFlQjJWYndyaUhiK3lCdDZk?=
 =?utf-8?B?TmRvQVRTeHgwdFVSN1hkYWZraHZ3MzlMVUZBZ2FmYUlDMGFLVkZqNW5rYTJL?=
 =?utf-8?B?MWRjN3I4eitFSFh0czhRZ21rcGRER01hUGZGTHk5YUdEd2wzUEY1Wk1vblRW?=
 =?utf-8?B?bFFETm9nUzZKeGZXdVdEczhWL0t4MUpHd2RaMjZkKzdNcGxXRFZURzlNdkpR?=
 =?utf-8?B?NmRaZzQ5WWd3L3Z0Yk9UTUI4VCtNbnNLUEMyNFoxZnF4VlZ6Y3I2WmNpaW1R?=
 =?utf-8?B?bUlFUlpXMmxCZmUxcEdDdTRXTFRmRFZVZWRpd0gxRjV0dDZUNlNRVHk5MVV3?=
 =?utf-8?B?SDVzRXhUNDREOG5aTElHOGkvYU9ab0NLRnhISElSL1l3QU5BRng2ZXJyYklN?=
 =?utf-8?B?N2NJdUpzKzV2Y201OER0U1pnMnBYb2c3SE9xSFNpMSswWXFNa3FJU2VoOUtB?=
 =?utf-8?B?RGFRSFg3SHNoUE9jWWtoT1FpeGhsMEZHSGt2OG9RT1JuOHFDdnZBZWl1RWYx?=
 =?utf-8?B?NVloLy8rU2p2SFBxVS9tTGpsRFJaOXM3dHBHM3FJNmlZUXR2b2k2WUJJRzdH?=
 =?utf-8?B?dTdjOTF5TGpiTVdJYXdYUE9zdWxzMXZteGRXVkNhQjN2RndHODdEbHo5ZWc2?=
 =?utf-8?B?U1BPdnJUdDg0VkZnRU0vajhTSTEvSW5RbkV0WVp5NkF1NlRCN2wvVXpoN3B1?=
 =?utf-8?B?OVQyV1ovZVpsVVNkODhqMzZhNHdEZllXWnVUOEhIQlF4OUlQd0xIdWpiSGJs?=
 =?utf-8?B?NXFvOVJzMmpjMURnMXhPeDhWQStoMkxjcGw0NFM2OFhVN2h1QXdNbFc3aUVM?=
 =?utf-8?B?N1JPQStNMThvem1KcnN5QTFYWjExc2FsS1UyS2dYUGdwNGYwb2FCQ0dVbXRH?=
 =?utf-8?Q?g+V11dWxF9kNzs7vmALEyx4bQXcv6P2SuHstitg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2c3ODBNbSs1U0N4Ump3d21KQ2tqbVJsSEYzRDlrTDl1aEFpRUxveU5NYWVu?=
 =?utf-8?B?aUl6b3MxcllFNEpNZEpmTlNyb1IzQ3JuSnFiOE9USDdnbzh1bktrcUllby9C?=
 =?utf-8?B?VnVIam5SVDk1c0puWVREUTc3YXJxV0U2bXhvRWdvWnFhc0pyMVVXeGo2bjF3?=
 =?utf-8?B?cTFad3FWc2ZQRG5GWDZPRDJhUm1zUDRJbWhMRXlYQUVJMHFrUTArZzhUblBH?=
 =?utf-8?B?cWR1ZW0rSCt4c1AreHA5eWhNN244enRVUUVRZ2FwMmh3QXZTU2JCQUJlRTA4?=
 =?utf-8?B?SlZuSERPMnllM1ltbWF6RXdCdW9BWW1TeWt5T0c5TUhRT1dBSmZRcHBLWUNu?=
 =?utf-8?B?UGZQODFYNElwMXl4NVVKcE42c2dlaS9pMUpmR0Mva1hIM2N5NG90SEZxd1E2?=
 =?utf-8?B?eGhJTDBFa1pwaUEybUNtVFhQYmpYRzFucCtJeFRYNTliMnF5c0N6clh1UmJ0?=
 =?utf-8?B?L0p4azV0L0s2eEY5bnRmNUNuZFFuTGZNRXZRRUxDNnU1RXRvTEVaeGtIcExR?=
 =?utf-8?B?UTlFNVJqdThldTNZejFJbkJqcEpiRUN1bjQwWU92L09ZOFo1ZHVlcGdEYVNU?=
 =?utf-8?B?RXQ4N0VlZXRjRTVXQTdvRVhQVGpVbUs2VVRoWklHVlErSGp1cElhSE1IZ21E?=
 =?utf-8?B?a0J6bTYzRHVaNFF3RExqUE9wMkYwY2Q1b2huTlg5WW5JUEpMcnlIS2F2ZXor?=
 =?utf-8?B?TDZjRnpQVTI2UEpFb1JaNExNUCtHRXRxOGpnUmlmTno4V0tlZDQyOEhnczRn?=
 =?utf-8?B?VmxOb0RBY243N3FoNjkvaU5LWUpuaTVYR1dFd2FOQlFZREFHUEdOSjBEZ0Vy?=
 =?utf-8?B?MGZtOHJnYWwxdHJKK0l6bCt1NTJSSk9RREtvczRKb25Oclo3cUVpVVpGQmlN?=
 =?utf-8?B?NzdYbTdkRVp2UFh4d0JTUFB0NTdaVmFOMEVmckk5aGZHbjcwZ2h4L0ptWStK?=
 =?utf-8?B?enJYQzEwY3JFOFdMaHArSFpXaHlsM0twUHFYTUh6M000SlJkTExtUUZ4UllM?=
 =?utf-8?B?SWZrSlIxUnZCd1Zvem13TU8yV2NOTXh1eUMrUG9zK1gxMzVFakJoeXJQTHF2?=
 =?utf-8?B?VVp4MWpvcHhCRnpySVJlUVlldXh3WFI5SmJIcUdhRmJrOUtVbzVTQ1ZWWUxT?=
 =?utf-8?B?K2tDSzNqK0VNWFplampPRTMvN2pVdGpCQnE1QXhka0QvTWZBeUpmd05oY0Nz?=
 =?utf-8?B?WFpmd2JxWmFZU0NRL3ZLT09aL2pXQ1BOY3h1MHhYamZTN3ZRR3lvTkpVSlJM?=
 =?utf-8?B?cFhTNnpvbmY4YWZGT0dyMk1OSnBiVWRjYVQ5UldzU2x0MVcxL0krUWdjY2RI?=
 =?utf-8?B?U0VibDBRMm9wZ3NBVDhwdlVJL1F3blg3cERRaXZBd3BoR3RWaGdOOGROM3lZ?=
 =?utf-8?B?ZDhoRVJ0Q1VLZldzUEtxaUtoQU80OUVPQmRpWkdrU3lONS8xdDNxUEgvM1Bn?=
 =?utf-8?B?MUQ1WTMrTnFJdTVoQlVubXQ0dlVPdXlRbUZyYUc4dDcxSGgwRGpIOTlFQUpV?=
 =?utf-8?B?eElaTmhrVmRiUG9hTHlnbHQ5czVmVWtwY3dmUU43MnlPOFhHOGQrV2Y2SGZ1?=
 =?utf-8?B?S3o4dThkVE5Dd3pzeG9qd05mNWNoY3FSUGw0emUwQ1ZLVStCYnVqSjZ3Z0JN?=
 =?utf-8?B?eDFKVk1TTE5LN0hjWEVUdlZwT2VuSFFBZUhBalIvdGM1c2hHMVJTeDJ1UnJZ?=
 =?utf-8?B?bm1RNUVXS05KVFo5S2NXS1FlUEt3U0V6R0w3eGV2ZCtveXMvUVVmaFMreC85?=
 =?utf-8?B?QmtlQUJpUHdmWVVMdndVdGJxTk0rVEMvUnBkQUdEazA1L29NMFI5VmFGQUpo?=
 =?utf-8?B?dGlnUmw4MWtyMVcrZk9URVJSMDZES3M2dDNyRXhtcHdXd1NTQ2tBekZJNVdy?=
 =?utf-8?B?WjJBbmNvQmVsZTdnUFZzWmRZV05iNXdhLzV1amVId0w3b1lMYkI5T2RuS0N4?=
 =?utf-8?B?N09jc0t2cEVvVkc2cWJvMG5IZjdLcUx3ei9mM3BvWXJRUXU3K3loNW42dlEr?=
 =?utf-8?B?cG1lVWtEekJLZWp3cnlURTV1YWpHVHFnNmNjektHY3JJTlBkQWlBUTJ2NUN5?=
 =?utf-8?B?cDVQM1dLc05Tckk2eURLSlYzZTRhSnMyODlwVnpwQTNzTFFCU25WV01OOWw4?=
 =?utf-8?B?eHJNbnNnN1ZnWmNWcDBCSGRuWEVEVzdKeStpTHR6VU4zZ2dabit2TUFqVUMv?=
 =?utf-8?Q?gj9hKFv9AdAqHoTuTH7gBkI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72f6565-a390-4cfa-7c8a-08dd51080c58
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 17:08:36.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBdAb9rY6bLB2KqzAdDMGabKkKX6sI6jCJwKkNjmw/8+APoLRKPCoo7FgoZwNKQdS3/Hb/+Lw/sCvYet2A55B96hXMzLm6uE/8z9IZc2Y68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9116

On 2025-02-19 11:32, Gabriele Monaco wrote:
> 
> 
> On Wed, 2025-02-19 at 10:13 -0500, Mathieu Desnoyers wrote:
>>> On 2025-02-19 06:31, Gabriele Monaco wrote:
>>>>> Currently, the task_mm_cid_work function is called in a task work
>>>>> triggered by a scheduler tick to frequently compact the mm_cids of
>>>>> each
>>>>> process. This can delay the execution of the corresponding thread
>>>>> for
>>>>> the entire duration of the function, negatively affecting the
>>>>> response
>>>>> in case of real time tasks. In practice, we observe
>>>>> task_mm_cid_work
>>>>> increasing the latency of 30-35us on a 128 cores system, this order
>>>>> of
>>>>> magnitude is meaningful under PREEMPT_RT.
>>>>>
>>>>> Run the task_mm_cid_work in a new work_struct connected to the
>>>>> mm_struct rather than in the task context before returning to
>>>>> userspace.
>>>>>
>>>>> This work_struct is initialised with the mm and disabled before
>>>>> freeing
>>>>> it. Its execution is no longer triggered by scheduler ticks: the
>>>>> queuing
>>>>> of the work happens while returning to userspace in
>>>>> __rseq_handle_notify_resume, maintaining the checks to avoid
>>>>> running
>>>>> more frequently than MM_CID_SCAN_DELAY.
>>>>>
>>>>> The main advantage of this change is that the function can be
>>>>> offloaded
>>>>> to a different CPU and even preempted by RT tasks.
>>>>>
>>>>> Moreover, this new behaviour is more predictable with periodic
>>>>> tasks
>>>>> with short runtime, which may rarely run during a scheduler tick.
>>>>> Now, the work is always scheduled when the task returns to
>>>>> userspace.
>>>>>
>>>>> The work is disabled during mmdrop, since the function cannot sleep
>>>>> in
>>>>> all kernel configurations, we cannot wait for possibly running work
>>>>> items to terminate. We make sure the mm is valid in case the task
>>>>> is
>>>>> terminating by reserving it with mmgrab/mmdrop, returning
>>>>> prematurely if
>>>>> we are really the last user before mmgrab.
>>>>> This situation is unlikely since we don't schedule the work for
>>>>> exiting
>>>>> tasks, but we cannot rule it out.
>>>>>
>>>>> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced
>>>>> by mm_cid")
>>>>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>>>>> ---
>>>>> diff --git a/kernel/rseq.c b/kernel/rseq.c
>>>>> index 442aba29bc4cf..f8394ebbb6f4d 100644
>>>>> --- a/kernel/rseq.c
>>>>> +++ b/kernel/rseq.c
>>>>> @@ -419,6 +419,7 @@ void __rseq_handle_notify_resume(struct ksignal
>>>>> *ksig, struct pt_regs *regs)
>>>>>     }
>>>>>     if (unlikely(rseq_update_cpu_node_id(t)))
>>>>>     goto error;
>>>>> + task_queue_mm_cid(t);
>>>>>     return;
>>>>>   
>>>>>    error:
>>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>>> index 9aecd914ac691..ee35f9962444b 100644
>>>>> --- a/kernel/sched/core.c
>>>>> +++ b/kernel/sched/core.c
>>>>> @@ -5663,7 +5663,6 @@ void sched_tick(void)
>>>>>     resched_latency = cpu_resched_latency(rq);
>>>>>     calc_global_load_tick(rq);
>>>>>     sched_core_tick(rq);
>>>>> - task_tick_mm_cid(rq, donor);
>>>
>>> I agree that this approach is promising, however I am concerned about
>>> the fact that a task running alone on its runqueue (thus without
>>> preemption) for a long time will never recompact mm_cid, and also
>>> will never update its mm_cid field.
>>>
>>> So I am tempted to insert this in the sched_tick to cover that
>>> scenario:
>>>
>>>        rseq_preempt(current);
>>>
>>> This would ensure that the task runs __rseq_handle_notify_resume() at
>>> least each tick.
>>>
> 
> Right, I thought about this scenario but forgot to add it in the final patch.
> We could have a test doing that: instead of sleeping, the task busy waits.
> 
> Does __rseq_handle_notify_resume need to run in this case, besides for the cid compaction, I mean? Otherwise we could again just enqueu
> the work from there.

Yes we need to do both:

- compact cid,
- run __rseq_handle_notify_resume to update the mm_cid.

We we don't care much if compacting the cid is done at some point
and __rseq_handle_notify_resume only updates the mm_cid field on
the following tick.

So enqueuing the work is not sufficient there, I would really
issue rseq_preempt(current) which makes sure a busy thread both
triggers cid compaction *and* gets its mm_cid updated.

> 
> I'll give a shot for both.
> 
> 
>>>>>     scx_tick(rq);
>>>>>   
>>>>>     rq_unlock(rq, &rf);
>>>>> @@ -10530,22 +10529,16 @@ static void
>>>>> sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
>>>>>     sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
>>>>>    }
>>>>>   
>>>>> -static void task_mm_cid_work(struct callback_head *work)
>>>>> +void task_mm_cid_work(struct work_struct *work)
>>>>>    {
>>>>>     unsigned long now = jiffies, old_scan, next_scan;
>>>>> - struct task_struct *t = current;
>>>>>     struct cpumask *cidmask;
>>>>> - struct mm_struct *mm;
>>>>> + struct mm_struct *mm = container_of(work, struct mm_struct,
>>>>> cid_work);
>>>>>     int weight, cpu;
>>>>>   
>>>>> - SCHED_WARN_ON(t != container_of(work, struct task_struct,
>>>>> cid_work));
>>>>> -
>>>>> - work->next = work; /* Prevent double-add */
>>>>> - if (t->flags & PF_EXITING)
>>>>> - return;
>>>>> - mm = t->mm;
>>>>> - if (!mm)
>>>>> + if (!atomic_read(&mm->mm_count))
>>>>>     return;
>>>>> + mmgrab(mm);
>>>
>>> AFAIU this is racy with respect to re-use of mm struct.
>>>
>>> I recommend that you move mmgrab() to task_queue_mm_cid() just before
>>> invoking schedule_work. That way you ensure that the mm count never
>>> reaches 0 while there is work in flight (and therefore guarantee that
>>> the mm is not re-used).
>>>
> 
> 
> Mmh good point, in that case I think we can still keep on testing the mm_count and return prematurely if it's 1 (we are the only user and the task exited before the work got scheduled).
> That would be a safe assumption if we don't get to 0, wouldn't it?

Yes, although don't forget the mmdrop in that case ;)

Thanks,

Mathieu


> 
> Thanks,
> Gabriele
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

