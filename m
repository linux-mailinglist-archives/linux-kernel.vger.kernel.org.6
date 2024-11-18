Return-Path: <linux-kernel+bounces-413149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB319D1446
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381C3B2DCC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9CC1B3938;
	Mon, 18 Nov 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="oME+0QRK"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011006.outbound.protection.outlook.com [52.101.70.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059501B21A8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942821; cv=fail; b=OO9pQtWiuxPPxDCnOnK4niOmbttFuw0FBERBa5FwMt5ktSb+VH2+1UEIjOxEsuf4ltmXMwLecw9cu9nLAd1PvzXYihk2sbPRbjPCjqz+Ma+tyDeI73B8VagB5IMdR1bCCht+S2ZSbsQ3criB1OzL4UeSA7wFskWbPI3WsHhmywM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942821; c=relaxed/simple;
	bh=Byo0JTig8NNffv+BDErehK94s3mI9CCAbN/dzyRuH0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QQsH9cpLcoCljpwhwuipRteeE/HumMNKVeCQkT9J1Cyf32R7GoHd8b9toPCAVAAZEt47Tjnw0o5xMmQgnz8LU9vlySYydHhCejky7M8EWMjdW8ACGdLsWGePOXiIi36rhQXhNN0Del1taf/BcT8O2/TxWcLWHM4USzo/wVwcn3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=oME+0QRK; arc=fail smtp.client-ip=52.101.70.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quH1JjYOZc7HWSQTtBHnuPixtbQ7FzlNHNMslG4shL75VzC+SU0Q94esv9bKx+GLP41xiH12K4t55vNH0YIi1D023kcfAJgrdcPsC3Wuzq4Fe2QuJzdf9M6tHWa5YkUueodzlgHlYq57Ia4aIclhhFGoESCSwjaPA15i1AOee5YDylnz+qXeIZKhD3SPCk26TwlW945E5XldbQz7WD6yoxQ+F/JhL6Rmw+BX6KfgMsXWKf5V5DWpTiawwZ1M1q4dmWuLKwTDaLfb38Vb+QG/wxWzMuemULjcf9RcheGIKY630lXAZJvEbgV0uKLT7beDw7v9d9+565rpqNAVc3ynWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xBbCwiIPyJ4qtIUGZXhodtdN/eBS7kQjTiMoWL36ys=;
 b=Mu4Fz7EVCctEMe/VxP1yjLwqMQndNZm+t0A3NgOs4HaKWmApnk83eLayLas68Z4GDpCGSpSXOIvLuPdCAcjKm4KJ5/HjnCee0tADVE264wtmnr+ZFBj0iv27fhjFfz8rqNjWPBjKLbUBxb7VEXfMhNkbZHEf+MfrEyWtrhxoTKqVBoEboohbeF0QTUmAjZx7wHOvYLQ6zGdnfbXH5oDTHoXUcDOKFw8/JCXGCPZFHKO2yHmf2tL0tNk9AQcWXNR3tD+ioUP8aoV9yV1OGKIUCTpUhsSbANjFjGmL32OyIWd855QKzK4g94rFnBoBkldC5SVqdkXYuSOLBY2ijZ31Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xBbCwiIPyJ4qtIUGZXhodtdN/eBS7kQjTiMoWL36ys=;
 b=oME+0QRK/fXVFhrHXBFgFw4ncL/fMXCnBkBMlmO85YV+XNMBiqRwmq24vybtADxIq6X80DLhMsoDExEUivYxKdYcOWajNZQz1wzjYu4H5oFQUxM4YvZJ8hVA0nXryH6u9Ycp9qT7RvCr7/gXersgaE7LxH7lN4KLAYQoFUboy05EneL3565diaO1SVMbURMWFbtWZTUTocLI5BhPZvjgjSWqrzODI+OFSn9DCaKY/YxvmgjbjJH0d5O8ipZzzf2ToE7OXEdQ6U7o/syQeCZzTUaStcwzWTHvkSBPqiaNIOKakd9vL8yw3qkXo4oGezRL4CnXg7eUo9WnaQcGHid6EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DB5PR07MB9582.eurprd07.prod.outlook.com (2603:10a6:10:4a8::19)
 by PR3PR07MB6521.eurprd07.prod.outlook.com (2603:10a6:102:66::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 15:13:37 +0000
Received: from DB5PR07MB9582.eurprd07.prod.outlook.com
 ([fe80::a809:c351:afb4:53b]) by DB5PR07MB9582.eurprd07.prod.outlook.com
 ([fe80::a809:c351:afb4:53b%3]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 15:13:37 +0000
Date: Mon, 18 Nov 2024 16:13:52 +0100
From: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: x86/amd late microcode thread loading slows down boot
Message-ID: <ZztZsCgX45rrMOVD@antipodes>
References: <ZyulbYuvrkshfsd2@antipodes>
 <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>
 <20241107153036.GCZyzdHEwm9-LPQOzY@fat_crate.local>
 <Zy0p5DT0SOWsCDn7@antipodes>
 <20241114095639.GDZzXJV1EDJlMqv24c@fat_crate.local>
 <3f6a84bd-af4a-4ffa-8205-25b2c9084893@citrix.com>
 <20241115205114.GCZze0QtUKbeXdFEHe@fat_crate.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115205114.GCZze0QtUKbeXdFEHe@fat_crate.local>
X-ClientProxiedBy: PA7P264CA0355.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c::24) To DB5PR07MB9582.eurprd07.prod.outlook.com
 (2603:10a6:10:4a8::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR07MB9582:EE_|PR3PR07MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e83c15-e940-4094-fca2-08dd07e39376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHZTM0tsR2NENEFEc29uZDdUSzNaTWpIcDV6VlVkK05KU0EzSTRxdzJyKzcx?=
 =?utf-8?B?Q3JpL0RQTXZvQnRMb25ySHBqY0g5bkoxRWNiMThBTStjdWhOSnJRc0wvYTIw?=
 =?utf-8?B?cld1RCtnSElnYnpUWkpyblFWSUFzYkZpdWdwTnIrdmducXdSZ0pwTko1NUc1?=
 =?utf-8?B?N2Znem1SL01HMm1mSm1Ud3JoNnhVeDN1UXNRMklGZGQ1UnlzSCtPSlFZZitw?=
 =?utf-8?B?cW1ON3lmRHl3SUdybHNlcDdpaDdNOHBHK2dWcGlpV24vaDBoSXFNL1lORXNS?=
 =?utf-8?B?eVRnWHpTRDhzc1FYZFU0cHFydDRrWFBMQzdUSk1XcE1pa1hEV1VhMXlmVEZR?=
 =?utf-8?B?RDNVeHFkcWtDRy9na2JERDNSNEFjUkI0eXN5eDlMMzVZeFpDVHlvb2FFQXlF?=
 =?utf-8?B?Z09DMDZZR3M2MU10ZFNlUVlLVzZ5ZGo0T2Y3ejlsNXdWM1NIcm9tL0Jjc1NM?=
 =?utf-8?B?NGhNZnJxS2lzeiswRnUxVytUS2xwWVByalZRYXJUQm1mSFp6YngyTWhCeEM1?=
 =?utf-8?B?UVh2cWcwN1ZkVE9ncHlTbXp6b2U4cVVGcEkvM0FpVU5xOWtrcXFvWUN1eC9u?=
 =?utf-8?B?bURJY2p3Y3JVTHBZSE1OTkw3MDF0WUpIc1kvSzFiYUEweEpYRGZYVm02NjlW?=
 =?utf-8?B?aExNWWxJaVBGUFZZMkVPNHBSTk9peStiaFdqWnF1Z1pLTGlTdGtxZTd6azd0?=
 =?utf-8?B?S1l5UEpJdWM4TXRiVGhSUXNzbzBmWlZOK1RhUHdhTXppU1I5TmsrOUVyTzdx?=
 =?utf-8?B?R2lCU3NKeXB4b1dIcTVheVVZdTBsZHV2TlMvTHlKMnJDMDBDbDRYK29qeGJs?=
 =?utf-8?B?VkoveCtoUXJobE9oMTFUOGJlVDJCQS9US3ZjbnRFRTN2THkzdk5RSmF5SnJj?=
 =?utf-8?B?VlRPSUplMFRQT0I0QXlMVnI4YlovZlNVTmJ2WDNSQ0ZtbTZUUzhkeS80bmFK?=
 =?utf-8?B?Wm5iUmdhWDNmVzRYd3YyNldVOXZGWHVHb0M3WHFINnliL2IzZ0FGTnN1WTRn?=
 =?utf-8?B?MDhkczBFek9xN2ZWNm9YR3l2M0o3UmpuajU3anZTd0xMWVNITTEyYWpPSUlX?=
 =?utf-8?B?WUVYSTNwSFJPOG1pY2ZPNEJzYkN2Zjd0QkQ0NEdMSWRFVmhzWGlaVk53NkJE?=
 =?utf-8?B?NWdOYUxJclp5OHk4bXNRV2lQeWsxbUVqZDdDcXRjbzFnOGlQd2luYXp6Z1Aw?=
 =?utf-8?B?NDdzdnlQcUhZaGoyMklTbEVQSDBoc2lDa1VFWHpuQ05hYXpERURIZEp4em5T?=
 =?utf-8?B?em9teVFGS1NCTmJHUFZiNDJaUThVQjREeUVobElJcUZ1RXV6ckRUWHRvSGQ2?=
 =?utf-8?B?V1NOMkJJN1hhMW9zV1pTWlJ4eC9CbUp1NmtCYTI2REJKT3gxQ1NhNzY5ckx3?=
 =?utf-8?B?Zk5aL2hOb05TNlV5KzBIVC96YTFHR1B4UlByNWF5WFNJa1Q0UzNIbm12bVU2?=
 =?utf-8?B?bysrbG9wVTdvRHBOZkE4SS9yRjljQytHTGFNTmRYSVFZNmVnL0VwWEpJZ1Q1?=
 =?utf-8?B?OXg0dmVHNXNrcVBYM3lXL2d4SjFCSDZQWGQwYkNPZjRvMzNyRElRUVZWNnNM?=
 =?utf-8?B?T2Irb29yUmFCemVFbWFQbWJVMnhITkoyT2ZGU1k4bEtrL3BlNVVUTW4rWFZj?=
 =?utf-8?B?MUU4R3ArSGNxL0FNaXVxUWRTZnhRMVRma0Y1bWMySkZjYi8rT0I2Q3RYa2dp?=
 =?utf-8?B?Ti9PTXRDOVZWWWJ6SnVWaHJNam5qWmFKbnljSTJEcVQyZnJyYVMyaXBVRnpr?=
 =?utf-8?Q?ZkiFTL/D2r9jI8QoKVGd5KL4A/raV6MkRLDGerr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR07MB9582.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGQxKzk0VzZDeCs5TzdlMHdiYTVlSmRQVEUxMjJ1ZGUyQXRDdDhSUDA1cFBT?=
 =?utf-8?B?L0ExSE4wZUFrY1VuQk82MmdkUjBmZ2lxT3F2QWQ4WjR5NTdEM0wrMUlkbmxG?=
 =?utf-8?B?VCttaVRzVm1Dd3lLNGwzT2c4b2Z2Q0xnQktLdnBlMjJtTkxROEFQbUZRMlhn?=
 =?utf-8?B?SzNGSUJxNndmWExOczNlZkZIN2tJOUt0SHFSL0VRRFNKM3ltalhIUFV1WVRI?=
 =?utf-8?B?Zk8wV2Q4dVdiS0szemUvZFh6dXc2cnRSK2piQjhWdkcxazA4QnV1M3dNdDhh?=
 =?utf-8?B?K21tZ0tpUmx0ZFl5RkcxNm1VQTZ1U2hHRHJjbzc0WFJzNVpOemZhUDBHQjJo?=
 =?utf-8?B?d0VjWFNYZzRsK3ZOTnNTWEpwb292TnFHQTV5NjgxcGdLUG5QVXdiMEdGa29L?=
 =?utf-8?B?NFVjb2pHNHVzdlVLa05HdlkweDgweXd0aVV2VU5QT2swV2gyRE44Y3lzOXRm?=
 =?utf-8?B?RlF6ZFBzemRsaWxDRVkxSUVyeUxMb05CQVlDWVhpL09oNE1WTldyU21YZXFH?=
 =?utf-8?B?cmpzcWtqajRwVkNwQTJEVkNTZ3RieFVtZlFwV1cxTlF3VWd4WkJoejFwTVZ5?=
 =?utf-8?B?SlRmT09IRHdlV0NWd2JCcjdQMmNVME90N3cvTDBXR0hjdDYwV3lUbUpXb0ll?=
 =?utf-8?B?UEJ6UjlPYWtTK01GVkFNaHNGOURORmIrSzVsYlpRVGRvQk44SXl1RGJTcVNM?=
 =?utf-8?B?Q3pUVUhaVDN5WS9XMG1JQXdOM2grbkdzL20rUytvRkZCaDYyclppK1NwL2x5?=
 =?utf-8?B?NUFYb2Q4T2lRVHRKdUlMSyt3bmk5YkgvMGVnVG5zbkdwbEhRdTUreEF2Qml1?=
 =?utf-8?B?b2lTelJXQWcrVmtqU2U0WUhhLy9Ca0lvbGZDNHdSbnNJTnNTQ01nTm1Gck9h?=
 =?utf-8?B?VjllYkxRUmRoajBaZlJlcTVtVDhYUXVKeTltdzB3ZHBHUXYyR3Q2em5BL3Rn?=
 =?utf-8?B?b2ZJekRLd21WdG9NRnRQSGM5emhRMjJyNXZJd2NSWUJRek40cng2UHdUd3lJ?=
 =?utf-8?B?dW1vVnFsQ3ZubGZIaTRsU1hjNS9oQjk3WWR4WHdoNVdwdXA4UVNNL292NWg2?=
 =?utf-8?B?ckttQ3JFTkhheXdYbzduT0ZZcTVNa0lNSGw5TlNod3EzNWZYNFlnOVVFRzBD?=
 =?utf-8?B?bGc2RmNBbFczcDdUUm9SWXNjNWpJOE4rZzJGSGlwaE96Wjc5T1RHUUhCUW1q?=
 =?utf-8?B?azBKWFJzWnlnNkpDQXJZSmxvSXhRT0phMHBDUE9Bd293VFlpblRjSXhRMFhW?=
 =?utf-8?B?Y2N3U1QvQW56OU9ET3hIbWRldU1ZRjFhTmxMSTZqSld6VVlxMzFxdW4weTRn?=
 =?utf-8?B?OTl1SUh4a1gxYis0T3lvKzJjbm9GZFY3SURNbEZyOS9rUWRzbmMvbnY1Zk5L?=
 =?utf-8?B?cTYzRFcxNXlwbHV1TTUxNGFDLzh5WDVqUmc5WmdiN0NVcDhFZmhleGhqS2ow?=
 =?utf-8?B?ODJseStqNDE5OHMwaWg3MHhETmtlejAvc0JzMjhuTExVdnU4OVV4MWJmS0FB?=
 =?utf-8?B?WHFlcDlieEV4Skx1a3RNZXRVMHUydTNwSk1jbFBWcEFaUUpiaGN0cmFqNm9x?=
 =?utf-8?B?R2Y2d3BSWENBbUpoUzVLNXlZSTQxeGxWZHNBSWxuZVd0VmRHMlNjMGxqK0xR?=
 =?utf-8?B?TmxBUDl2dkRYVFFwMzE5cEhlYUNjaVM0em9BbnlEeWd6c3ZVYTI0TG1EeWlK?=
 =?utf-8?B?dWI4VHpLNXFaRFNFRThGQ2VtWk55K05KYkQ2djlhQmxsRW5VdXZPc28vc1Jn?=
 =?utf-8?B?bUZmc3F6Sk0zRlhmN1RCMWhkTUt3bXpGUkt5WnJ5VUY1eDB5c1FMNVI4cDlm?=
 =?utf-8?B?MmpZRXdPWWtYS1ZjT2l2M1VQZ2wwY3hTd1FhZWQwN2RYUjVaSXRpQ0cveUFR?=
 =?utf-8?B?TUxuOWo4Q3JrQkN3UjRmcmVZV0daVTJlODlSTGY1c2pCaTduYTVlOUJXTG5G?=
 =?utf-8?B?cTVhNnFucnl1VzJkU2l3a21idW0reEU2NUswNzhGZ2F6L0JYdXpzVmxrd0s1?=
 =?utf-8?B?bWVYeEtwRldVS0JRc1hRRVBZbHRtdVgrQTd0ZTFBVUpnVU0wYVAwbHdWVnhk?=
 =?utf-8?B?WFN1QTdGd2twYVhRMWdaYWJXaWhvSUFIc01Dd29EKy9LZ285QW1iL3Q1K1dz?=
 =?utf-8?B?WnlueWhXNEpzS1pUWXRVanhHb1NFZVF3bXpna3QxUStRMGExTGRhWlIxVTFU?=
 =?utf-8?Q?XgzuJFUQR+hqQ5vzw5T4EcI=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e83c15-e940-4094-fca2-08dd07e39376
X-MS-Exchange-CrossTenant-AuthSource: DB5PR07MB9582.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 15:13:37.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYo7esOB15DbkrA8aLFF4Uits1eamyv3dXJHxJFpjWzrRScC0/NTmM+UTX80HAkorapqQ8BTxWbH0SA0a8e0qrJHWk1r5fxOi/Z8jXxWBktiEDYvVUn6I/YkYMBUNE8q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6521

On Fri, Nov 15, 2024 at 09:51:14PM +0100, Borislav Petkov wrote:
> 
> On Thu, Nov 14, 2024 at 12:03:41PM +0000, Andrew Cooper wrote:
[...]
> > However, these blobs are 3200 bytes long and come with a good chance of
> > crossing a page boundary.   If you're invlpg'ing, you need to issue a
> > second one for the final byte of the image too.
> 
> Right, see below. It works here, Thomas you could give it a try too.

Thanks, I tested this version successfully.
I hadn't included the 'size - 1' fix yet but I don't think this could influence
my test negatively.

Please go ahead with the final patch.
Will it be backported to the 6.6.x branch?

Thanks,
Thomas

