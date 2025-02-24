Return-Path: <linux-kernel+bounces-529962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9201FA42D02
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA861188A48D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55DA1EA7CF;
	Mon, 24 Feb 2025 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="G3O7MZqB"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022086.outbound.protection.outlook.com [40.107.193.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F52571CC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426540; cv=fail; b=msc/DkPMTFXoCAD/j65xgyEDImgk8VcPz5f++4maJQRJlIQKsXZFUaaH+s1JAucayHS4AymMNqBpod0aiP0UxOJB6Ei9gPWaFUwZl8mIyA22Gjbg3MDDQv6LHhlxXhntldXmBCztn/JWOuQt8L76YOOSY6GWumyik6yKKf+NnEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426540; c=relaxed/simple;
	bh=DvZHrHDA/DhgDVK27mpFDbZrzuf3Rno4O7IuNnE1P5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K1sDJAkC0QAOyz50D/zUfTt8mz8Mxhpga0W9dbdpibpkHMeRoRKcy22TOhqCUEoYuUQe+btUXhe0WkejmUlXJ0JY4+YQsWTJaxrOhQyZeqY1vyjqw3itQWWWNhjF/g1Up9n56G9mTGySVIfoyS7RbhnSQN/mXeOKU1FnNmL91Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=G3O7MZqB; arc=fail smtp.client-ip=40.107.193.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAqdCPeVqZwquY8PK5far52gFry7ofvNuvU5BWQMdOO6sf5bKl0GKBRShYjYHNLISQRCMzRoM0BIPG5wZSEBhzQzZdGFwNOhtzsdl2LH58j/dkBCAIIUpFN5J07CdUkeSFwL3k3Pr1xDrJXx1CdONkAE/fsi2OUm+IdonVvwvwXMotZYNitY6yX5vI5Jilk4O1NzWkgtehveuLjilVz9NmLXvymJ5mzuzDXUDZU3+IkTANVDlikGymJAc+bm8/co8I4kQPYvmwZq6ee5xHaA7YQtUag0fy6wyJMLwB1UnyKJen1F1/R+yReCqjI+OyVvVCDyNhWVh9CQudjhEcfUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV+amOO9WY8dOLF6D8qahGsp+ZINNNHivvJFxaPePkU=;
 b=LMsbyK14T2Pb+PbpWiwuEDJ3+MvQ7r0hcSMmk58K9hYnJN81rVYo5ovQ1ZJJeARYls3Xd4ye26+RV8YGNy/vCbIEvXfTeo+gtZ4hXAycS6/r34QJLFZQvDhNlnuVKG4c+wvkmdXhIVTP0mGSbLaXYBgMua00moIIp5vaVoz/Sr8TWLeW+CBcRdp8dCwGbLs+ZKNQ8LJnt6ZMiUfe7MR0xYz992WFsIH/coBaMUWYnF/FkRtckrkqaWukhQcHPP7MQm4BJ0q4pR3OruPWUEjzFbom2fTEmzd08tFTN5Mm7b0C7UyLY8k5Y+S1w4MzNKFJAL6rCDnKBR3xXIFGSaL5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV+amOO9WY8dOLF6D8qahGsp+ZINNNHivvJFxaPePkU=;
 b=G3O7MZqBZFw2G7YFFkt0TkvwP4VUTxVSmxGHMhMjjZgM4jYqgoyHZCA5wbQthlCoee/ExOWFPnOxZcmiEp+kU3kX/JmFN7ukiDjqGpirbhL0GH0qVLyIjfB6pUEaOYXNwRcouBJqIEHw7VfOlKC1ndJ99PBqfokfpf/1TksN69zoNCTxqH1YqA16em8W3+9lufbPMCT6BRlyVk2rcUziPEEbgiK2slWLoyuHOO5Zqe4LVcvkPUvGHilNqOXMvbdV0a9hxZF+V3Jp6NW6/OvjCtqIAICkeY/yGRVMmThk8hL6AxQdG+XAInzwTd5TRiX0dqeR/89L9s49rmLeVx8oiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6551.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 19:48:56 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:48:56 +0000
Message-ID: <cc8b653e-29ad-4cfb-91c3-1e001a811c4c@efficios.com>
Date: Mon, 24 Feb 2025 14:48:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] selftests/rseq: Add test for rseq+pkeys
To: Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
 boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com,
 elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1740403209.git.dvyukov@google.com>
 <356f1e7b2c3c1dfee74f030bca603ffc9549ffb4.1740403209.git.dvyukov@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <356f1e7b2c3c1dfee74f030bca603ffc9549ffb4.1740403209.git.dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0176.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::25) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 4883807d-22b8-476f-a45b-08dd550c4616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SThKclBMUlVFa0JEUnJ3dm1oY2ZDMko3cVg2Mjg3Q1FkUkY5RkdpQ0N0NjdJ?=
 =?utf-8?B?U004MytDY0JRNEhPZGw5MXQydEFZbVJTT3VGeVhRaUJYM2p2Q0lUR3Z5MVBi?=
 =?utf-8?B?RHhPckhLTkFMbVJ4VFZ1NXJFSGtCVU5UcDlTOWtiYjJQUWF3YUR6Y3BINDhH?=
 =?utf-8?B?N3BWdGd5blIwNHU5TUdZbGJZcUR0MlJiWEpvSE0xeGhiOFdCNTU1Q0pvd3hF?=
 =?utf-8?B?eFFhYkEyTjdCY0RWcExQZkovK0dTVEMxUTVndzFYYlJEZjRKcXdrcnR5VU9i?=
 =?utf-8?B?S05abFZGZ1ZhQ05hRjM5N1J1QmdCZFpUVS9uelBVT3JOejJjL04vSHM5cDBx?=
 =?utf-8?B?TWpkcFFYeWxSdEtJdkVaUXpDNFp3aFNrQ2VZRXJXSjBwTWxaYmxVSVhiandz?=
 =?utf-8?B?Q29GSnlKSE53Z2ZwaE14dEd0cGw2b1VWTnJXNC95RllHQVI3WXFpSnFyb21E?=
 =?utf-8?B?YkcrR0FqMm80WFUwdzViS3lYZ0FQZ1gzeWNPV1JBQ1c4VU5MWG9qVTV1cVZO?=
 =?utf-8?B?Y3pwNzl6aCtMV1BVc1VZQkVOTkk0VXhXdGhOTG8wRWwwV1p3dW1EY1MxVXFV?=
 =?utf-8?B?by9WS0Jab2pDMjVETStLaUl1bUR0ZEJKVFJDZTVVcC8vQzJQbkU5aXhJUWEw?=
 =?utf-8?B?cGFFTHF3elFYTk4vaysza3BCNDRqZEF2MU1DaDVqSjd6T2o2bm5PYk9KSzBv?=
 =?utf-8?B?TmNvUzZYKy9SL0F4L1Zqam9aTXY5OEpHczdVeTJtUEdRaEJSNTFOQVVnYmd3?=
 =?utf-8?B?cjZpMkF1U0tGOXE3b0FTZXFVZnVrb09aMEo4RjFOaVFLcFFSVFpoTkxvY0hz?=
 =?utf-8?B?N1pJNUNodjRPajI5YnpLb0xpbkV5WDdVKzVnUWR2c0V5aXlBSGF2UVRxY2lE?=
 =?utf-8?B?Qk9yV0lHblErSEZIWWNvNWpPa2dHZUJNc2dGdUtYdXNFTWYySkxMdVQ1aXRl?=
 =?utf-8?B?NFNzcUdxY3dUeDNmcDVDVEMrVlVmMmJXeUk2WVc2MlZBTXNqS1hwYW8rdit5?=
 =?utf-8?B?T0x6RHdtT2grb0U4WGVDek9PWXV0Z2xqNER5WTdPZUZBWGFUZlBuMXFZZnJJ?=
 =?utf-8?B?RE0xSC91UGlXQWJQeU40cEpCTUZ1Qm1oNjVmTjVrL3QwYTJjNXN3WHZ3Z3g5?=
 =?utf-8?B?UXN3bHh4L1g4YTVuSGZ0bHRsdVlFZHdxdlY2bW5CMFdpcmw2SGNCNWFCZlZJ?=
 =?utf-8?B?aVdrb2JESVIrQVI2Vnpqdkw1Smg1bXd4dk5NY2xpSXh5UzllQ0ZxbFpaNita?=
 =?utf-8?B?Q0RNMDJFN2xHY3ZXdlVrTlBiZHBhNXliZmRnbVNXcHY1ekNSZ3lNbTBkYWRK?=
 =?utf-8?B?SFpmLzBDNHNkZm95UkxWRHhRTXNEbjR4VzZNTTBXR0h6N3pZMUhzcktTOGht?=
 =?utf-8?B?T3dndXpNU2ZiVXNXSEtiWEwzbFlyckFkSWdSQW45cnpLTlRuMnNGT284RkxU?=
 =?utf-8?B?Q1VsRTZkNVhlaFY4ZDM0bEw4aWV6bVZnNXYvdGNFQ3ZnRElwc2tGU3hWMHFW?=
 =?utf-8?B?NG1QUXlIcG0ralNxQmtVcmcxdms4Rkwrei80dUpxT0ZHNWJ1UVdwTEVZSGdp?=
 =?utf-8?B?bjRXVnhvZWtpQkUyZnA4TVU3UjkxQ2JJV09QQjV0cWNwTXNkQnBEOHJtTmdz?=
 =?utf-8?B?VjVLbXZhTUpySDU0MnpvWURXNEloZ0JiRWUvMXN0eG5kWGhMaElnZGtjOEw5?=
 =?utf-8?B?WHl1K1VZUm9DLzJ2NzBiQ2htdnRNQVJERC9OVU1sNnNHMHhPV3NOY2dHb3ZO?=
 =?utf-8?B?U21pRkdNTWtvbFZhaUhJZjNvRURvYjlkMWU4UEdjQXRORTlLYk53dW1HcFVz?=
 =?utf-8?B?dytuWVl6aUs5dnlRYmUzZUZlSG9ZSkJ2UG90anpoWGlWUE93c2ZwR0dsTlVP?=
 =?utf-8?Q?vMxDzeHvBgIKQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THVlREFFL0YxaUtBeGhiN2RTN1pwZFI2NWlFQVNRQXBWZXJnY0FhUm5tc0JE?=
 =?utf-8?B?KzQ3dURBUjFCZFZpRGZoNHhkeVMyNnZSZFM2K3ArOGhZUkN4RGhuUVkyOEhP?=
 =?utf-8?B?ZmtJT1ZSdWxOakdBb05obUxsR1ppZjR1MWhMSk9kWlhWb0VkWkM3ZlNaK1FV?=
 =?utf-8?B?OFJEQzE0K0pacDRmVlV3RVNZZmhGdjZKa3pCaFYxV2NDUitOZXJIWkNiR0lx?=
 =?utf-8?B?Ry9yOC9xSjIzZnVNUUtvZGhpY0ZZL2kwMHpNYTJUamxYNEt6Ukdwd0pnNm5n?=
 =?utf-8?B?bkg4TUo0WSswNXlWUHNLdXhrQUFIOW03VDEremZKOXJrTXYzYUd1SU9kYWFE?=
 =?utf-8?B?ZEo2ZXVuUnZZaTZEekpCdWxGbVQ4L1JrYVRXRmY0THpTOW45K0h2MEl5UE5i?=
 =?utf-8?B?Vm5lWHFaQUZYQkRoL01HekRIRVAyUmVQK3NrREMrNU56NWw4L0dYMkZ5Z2pD?=
 =?utf-8?B?RG1RQ1Z2WFdMUUwzOUZ4YUMrNklFZ2t1NlNVeE9ZYVR6WklISnJlSTFXQnRH?=
 =?utf-8?B?TDZBQ3JYRXk0OGlwSitHYzArZktoK0RBWXlqdld1M1RBUTljSU15RHVBdTIz?=
 =?utf-8?B?UWVpTnNpeFdUcHN1YmdKYWM1MFlzSnJlbThPbUZ1OHp1c0JYbHRqTVBscDhJ?=
 =?utf-8?B?OXNCWFZaL2V5b0dUQ2tuckJoMHk2b0dJQjVlRUYzS3NUcHhmWlQvMVRzYU96?=
 =?utf-8?B?aDVoSmNQS0xXZDV4b3ZHa05sRG9MeW9WRWMyM3MxSVdlMWNxdENxaUl2RWdj?=
 =?utf-8?B?THRYU0g1MTVIb2RieC9qN2tUWU5HUnE0T2xSTWJIWWdYbjk2bTdwK1NleW8y?=
 =?utf-8?B?YitzOWJJMzh0TnZadU1GM2lQSFY1Qm5LY1Q3b1NYWC9UTEtkSzcwRHFuMWE5?=
 =?utf-8?B?Qmlvc0Z0UXZUN0NPbGg4b0hQV0llMFpMRnRFaHJYOGNlSGJLa0lMTk01VU93?=
 =?utf-8?B?ZGg2bTFBLzhIUk1pODFOMzdlc3ZLNlUrd0hpZlR2eFBLdTVpcmQzRDgrNVpO?=
 =?utf-8?B?dVduaVozTlNGL3ZkOTM0UjZ5Zm1IR2NkaGtYTnZsTE1nVkl0QllDQmtIQ3ZQ?=
 =?utf-8?B?VkFXb0dMWFZxSmt6UCtEOUtMNG4zc3dZb09zUm54QXhqV2xuQWZhVXVSRkdC?=
 =?utf-8?B?endOYjN5OUQvS2JvVUg5K29RM0pNYlJmbmhYZnQ0djNqVUFiVkdCb1ordFBI?=
 =?utf-8?B?VnhydHlSTURRUEhXempHQ2d1WDZ0clBmeWw2cjdWekIxK3h2R09BeTdVRkNT?=
 =?utf-8?B?Z1ZBaVN3aXlLZy9PYXBMNk5Yc2J4L2NWdzlCT1dCYW9hamRJN3dhYUtscUlw?=
 =?utf-8?B?ejlLei93QktGdldFYmc2c09aZ2pscFhPVUM0a1kzOUxjV2g1dHFnaU9aRThB?=
 =?utf-8?B?cmdZQlg3ZzNvV3JmM21HUXNZNVBxMDlvcXZLZ1NTTGxwSE03Mzg1WHZCS3R5?=
 =?utf-8?B?dTNTUFdMOE04Zy92ZTJDQ0ZpNFBnb0FReGIyamVqU3hvYy9mWUhVenVsMmJv?=
 =?utf-8?B?R1BWcDdKeHk2MnZrSVlNWXd1ejYyT2ZOazFyeW4wMDZ5MlExSlRQY1VCQVFO?=
 =?utf-8?B?eUpWSjRpY0hqZ003TWVGZXFISGlKbXJiM0JqWVJKUWY3Rkg4T2FWNFROY3FS?=
 =?utf-8?B?OGthRk9pUEl0UGRRNTB6RGFoVWE3OVVwWG95ZU9sUGMwelZ3NWVwRkpjaHdS?=
 =?utf-8?B?akQ4TWp4SXFCbHBlbEoycERSb2dpQTdSeFRGQ0pISWNHa0YyWU4yeEdMS2lY?=
 =?utf-8?B?ZUFIVkRNa2dBWjZKb1NkY3BMRWp5M2toeDdsQm1BZmlzV1llRDRlRWtrc2s3?=
 =?utf-8?B?QkJsV0Vzc0pGZ1NpQzB1ZFM1eHNFRDJRbmRzTDFTY3pocDdWTGhpQUV0Z3F4?=
 =?utf-8?B?WC9PWmNRa2VNRGJ1YVNJSGZGVnB6c0E4QnROMEs4MlcwVnZZaGM4Z3RuQUFF?=
 =?utf-8?B?emVEZTJxeFRScW8yc0dQTUxRUWhLKzEvdGpNK0wwVDhYaVBWZzN4bWlDcjFF?=
 =?utf-8?B?Zk5KaWcyZ0ZWNVYyTVhJWWxRcnB5SEI4NWJNc2JKckptUlJLMFFwbDZ0S2VK?=
 =?utf-8?B?MDNFa29zR2VHVUErdWtWZEZubXdtcnorQkY0V0lXd2dUcUd0M1RzalR6dnpo?=
 =?utf-8?B?RjR5QUdNQzBkYUsrejU4cGwxc09XSUpzSElFRUxjR25wbWFQdkpQOURQNlVU?=
 =?utf-8?Q?w1i+ygm+fxynzmbJwx3rlpE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4883807d-22b8-476f-a45b-08dd550c4616
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 19:48:56.2001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIV63qnGFRgq7dq2kWQlpzBJVI/Iel9AXdVa44noBtnZnOmrAoL1FPYYvQhSW4CPmVvtTfWz82AxZRilOQraiDpM27qUYag8pLtn68jXneA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6551

On 2025-02-24 08:20, Dmitry Vyukov wrote:
> Add a test that ensures that PKEY-protected struct rseq_cs
> works and does not lead to process kills.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> 
> ---
> Changes in v4:
>   - Added Fixes tag
> 
> Changes in v3:
>   - added Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>   - rework the test to work when only pkey 0 is supported for rseq
> 
> Changes in v2:
>   - change test to install protected rseq_cs instead of rseq
> ---
>   tools/testing/selftests/rseq/Makefile    |  2 +-
>   tools/testing/selftests/rseq/pkey_test.c | 99 ++++++++++++++++++++++++
>   tools/testing/selftests/rseq/rseq.h      |  1 +
>   3 files changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> index 5a3432fceb586..9111d25fea3af 100644
> --- a/tools/testing/selftests/rseq/Makefile
> +++ b/tools/testing/selftests/rseq/Makefile
> @@ -16,7 +16,7 @@ OVERRIDE_TARGETS = 1
>   
>   TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
>   		param_test_benchmark param_test_compare_twice param_test_mm_cid \
> -		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
> +		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice pkey_test
>   
>   TEST_GEN_PROGS_EXTENDED = librseq.so
>   
> diff --git a/tools/testing/selftests/rseq/pkey_test.c b/tools/testing/selftests/rseq/pkey_test.c
> new file mode 100644
> index 0000000000000..8752ecea21ba8
> --- /dev/null
> +++ b/tools/testing/selftests/rseq/pkey_test.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: LGPL-2.1
> +/*
> + * Ensure that rseq works when rseq data is inaccessible due to PKEYs.
> + */
> +
> +#define _GNU_SOURCE
> +#include <err.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include <ucontext.h>
> +#include <unistd.h>
> +
> +#include "rseq.h"
> +#include "rseq-abi.h"
> +
> +int pkey;
> +ucontext_t ucp0, ucp1;

Why use an external linkage entity rather than static ?

> +
> +void coroutine(void)
> +{
> +	int i, orig_pk0, old_pk0, old_pk1, pk0, pk1;
> +	/*
> +	 * When we disable access to pkey 0, globals and TLS become
> +	 * inaccessible too, so we need to tread carefully.
> +	 * Pkey is global so we need to copy it to onto stack.

to onto -> onto the ?

> +	 * If ts is not volatile, then compiler may try to init it
> +	 * by loading a global 16-byte value.
> +	 */
> +	volatile int pk = pkey;
> +	volatile struct timespec ts;

I think you are looking for RSEQ_READ_ONCE() when loading from the
global variables to prevent re-fetch. AFAIU the volatile on the stack
variables are not what you are looking for.

> +
> +	orig_pk0 = pkey_get(0);
> +	if (pkey_set(0, PKEY_DISABLE_ACCESS))

AFAIU the pkey_set() call needs to act as a memory clobber. Therefore
having RSEQ_READ_ONCE() before the clobber to copy the global variables
onto the stack should be OK.

Thanks,

Mathieu


> +		err(1, "pkey_set failed");
> +	old_pk0 = pkey_get(0);
> +	old_pk1 = pkey_get(pk);
> +
> +	/*
> +	 * If the kernel misbehaves, context switches in the following loop
> +	 * will terminate the process with SIGSEGV.
> +	 */
> +	ts.tv_sec = 0;
> +	ts.tv_nsec = 10 * 1000;
> +	/*
> +	 * Trigger preemption w/o accessing TLS.
> +	 * Note that glibc's usleep touches errno always.
> +	 */
> +	for (i = 0; i < 10; i++)
> +		syscall(SYS_clock_nanosleep, CLOCK_MONOTONIC, 0, &ts, NULL);
> +
> +	pk0 = pkey_get(0);
> +	pk1 = pkey_get(pk);
> +	if (pkey_set(0, orig_pk0))
> +		err(1, "pkey_set failed");
> +
> +	/*
> +	 * Ensure that the kernel has restored the previous value of pkeys
> +	 * register after changing them.
> +	 */
> +	if (old_pk0 != pk0)
> +		errx(1, "pkey 0 changed %d->%d", old_pk0, pk0);
> +	if (old_pk1 != pk1)
> +		errx(1, "pkey 1 changed %d->%d", old_pk1, pk1);
> +
> +	swapcontext(&ucp1, &ucp0);
> +	abort();
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	pkey = pkey_alloc(0, 0);
> +	if (pkey == -1) {
> +		printf("[SKIP]\tKernel does not support PKEYs: %s\n",
> +			strerror(errno));
> +		return 0;
> +	}
> +
> +	if (rseq_register_current_thread())
> +		err(1, "rseq_register_current_thread failed");
> +
> +	if (getcontext(&ucp1))
> +		err(1, "getcontext failed");
> +	ucp1.uc_stack.ss_size = getpagesize() * 4;
> +	ucp1.uc_stack.ss_sp = mmap(NULL, ucp1.uc_stack.ss_size,
> +		PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
> +	if (ucp1.uc_stack.ss_sp == MAP_FAILED)
> +		err(1, "mmap failed");
> +	if (pkey_mprotect(ucp1.uc_stack.ss_sp, ucp1.uc_stack.ss_size,
> +			PROT_READ | PROT_WRITE, pkey))
> +		err(1, "pkey_mprotect failed");
> +	makecontext(&ucp1, coroutine, 0);
> +	if (swapcontext(&ucp0, &ucp1))
> +		err(1, "swapcontext failed");
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
> index ba424ce80a719..65da4a727c550 100644
> --- a/tools/testing/selftests/rseq/rseq.h
> +++ b/tools/testing/selftests/rseq/rseq.h
> @@ -8,6 +8,7 @@
>   #ifndef RSEQ_H
>   #define RSEQ_H
>   
> +#include <assert.h>
>   #include <stdint.h>
>   #include <stdbool.h>
>   #include <pthread.h>


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

