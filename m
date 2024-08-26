Return-Path: <linux-kernel+bounces-302140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B1C95FA6E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0F02812D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BB2199EA7;
	Mon, 26 Aug 2024 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UUbgOPbH"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09BC194AEB;
	Mon, 26 Aug 2024 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703209; cv=fail; b=GSeM17Gkc1I/C8mqnfSCxwnNRMcwZKo9FrYxTMRrg/yfMEvObSuyqirxq1nlQmycJLWJRviuJbYuuWpiKDUUCV6qSFUo0ZOtNYfGJ12RNcbpcBpF2NUO0BU2bs4gxmQboBa1f/KzT6u+HjlWOQ8QaNirf0bDdZIfOdIjUh6pLLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703209; c=relaxed/simple;
	bh=Uieuy24mR0bKLOqMGi3WAnqEyV42TJYreh8b0dTexpE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EaUlxMvPLd789eARTxI1OZxambfO6qKCXuo4CW3qZyUDXBIoVefPyoRnn0v/tV+UyAGfs0zRmpc9HfpcM024GzDZ0skIWytTSC7Mvw2ixBGRzo9TsjnMsrMigYRrJyKORTip3XBv+Gtt24DFoLMlWT7IGHjn8By2LwlrxU9ZUJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UUbgOPbH; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y824waUtbsXME1kpFTDTr4ZbBFgfdFzQnCQT0Qui26ZXhqOABO+SCX9UkAnbTgKOH/JXycm7prj/jY3opEiK5uIeV3AkXkiw/6tTQKU6X4ueppxCQ3Qo0ehJEg+Q0qgM0xui7McCiosfGCCgkmOYBNYNHbBPZQysUJufCC9mG2NyTaElkNo7O6uRoV9j1lKLzXMPP/Ba5kqocNQ8aqB9oqyc+W3q8kZvexowif/F5NekZjGyD+/J1jgYMdNNjVVrVsm1B9i6CjAFKjxWhrAUfsBNK2gh6/BV1/FwAAp+Zej3v1zYQVPaNzy2yqb73nVNE/WaeiManY1oiMcpEGf3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDHMb4G6dXfWAWP/rzhi9qQDjX9gHPt355zhdniQUy0=;
 b=xm3+4E0ybchMA5tzFONTp0GiDivGb4vHSnLGGsAfxx4z1CHiSV5uAykGOu3l+U1H0kEQ+odU4FtFnvo+lu66rG7pDa6mU6uUwtJwnQc5y1J6+1j8AHthQJ/0x4+2KZDjViNrq3Z3mGwm6R1crKAs+TurlB1uvpmoLWy8AaW9b5glnS6LdXE8Y7jEpt0Ob+UDQiWSydZDoJFQyvdaqUnYPVWNB+8gomIq34NoygIQA09JgyYYfmVFJNbtxFdC92a/NWTse/JFdyr2Gn6ZkipniDfwZ8LZxXSUDmMCtKEXDjBu4hcDiEasoorLg35Iyi1vMMAZuMAHPiHzg24dUAsb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDHMb4G6dXfWAWP/rzhi9qQDjX9gHPt355zhdniQUy0=;
 b=UUbgOPbH0Furvr6SZ0VsIb/pqBhRTlyTHlNdgzVa5nCuOrdtCM0O4Oz7j4bOBHH3AVN0PXflHD/pmMi4sWVHjCeZ8wB2C5uNbLvX6NTcGxtXusxiNMctZYGLf0pfZ8Zv+gsRWTlvphyMDFIXk0n+/dMIpaao/puw44nVk6JsVW7PPVfaoi3lCfLHr+9neA2WZv8USvkQnax0JBjrYAaiu1JA9JNpu1oUKU+zgh9ZxvaCM0ytSmoqnlcy17W9m4W0YUkGEEKwB5kRXnBRDQ+AV4Cb5Rr8rxffgbGEpDZPf+GIkDI7J3YwbNDtb7KGrmyX3E+hmJfZonI298pQz8msvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 20:13:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 20:13:22 +0000
Message-ID: <8de13103-cd57-407c-839c-843dcedbac29@siemens.com>
Date: Mon, 26 Aug 2024 22:13:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: soc: ti: am645-system-controller: add
 child nodes used by main domain
To: Nishanth Menon <nm@ti.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
 Diogo Ivo <diogo.ivo@siemens.com>
References: <cover.1723653439.git.jan.kiszka@siemens.com>
 <c6bbb3884e9270a203ee39d298c34f6676b3911e.1723653439.git.jan.kiszka@siemens.com>
 <20240824175825.bedufmhfkx4btv5n@anything>
 <992d6ff9-3181-4a71-9e21-3ba6465693d6@siemens.com>
 <20240826114259.ynxf5a5qwbm2co4u@press>
 <7ee8c6c0-3e1d-4262-840e-435407521324@siemens.com>
 <20240826195930.c7bylbgu6qma2v3c@siren>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240826195930.c7bylbgu6qma2v3c@siren>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1786ca-e1fc-4107-7405-08dcc60b8922
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEJvQmwxbzdMYXYrK1B0Zjhod1ZDc1VNQ2VCbHdCMEJIbXVTLzR5Wk9mbzRz?=
 =?utf-8?B?OEt6eko2czRDTC9SaWFlbFYyWWVtdTI3a3VBNmRFQlpiRE1DNVptb2h6d0Zi?=
 =?utf-8?B?TkJHSWtLbEtNY1ZEYmpXTmd0eXZMSlVyM0wxaDFhbjc5d0c2RGpMZGNVbUkx?=
 =?utf-8?B?N1lBVzljMW95RGtwMzRqTEQvMWRBMUgzaUdSSFEzdUpuRWczTzFBbVhFcTZj?=
 =?utf-8?B?RnMxSXdvdUxVWE9WZzZ4b3dMWUR5VW1yTkpLeU8ySEtHMzRLOXBFSFlIbUVY?=
 =?utf-8?B?MEJVMzAyMzRGVnBCUVZ6TTQ4TlhVUi93TlljdnZvcFE2TDN0czlHQy9xQk1y?=
 =?utf-8?B?b3NML1VTWjllMElQeWp2K1EyTFVyOUFJRWF0SmNGQVZLWnp4TUxUcmZBb3pv?=
 =?utf-8?B?YlVrYXFRdmNiT1h5eXg3Z1M0OUVtdWV0SUFWdExRVVVWY0RkL3hjZkZXU3c1?=
 =?utf-8?B?TUE4UndObmNPTGEvNDZwTzZUNHdLTW5YVDlWNEJ3MXRIZjVuSVhBZ1dySEJG?=
 =?utf-8?B?YWZqV2FPNGUvRXBCLzZacmZyZkV0K0hOdkdGZlorRDVLUXM1ZHdRdnJHM25Y?=
 =?utf-8?B?Yi9TVER0TXVXVHlXbUowL3VKTkNydnpYellPY09ISlRxUytHZ3VnZGNDVHpn?=
 =?utf-8?B?UGYrUTFHZmNSZjhxVlZoWHZjbTBTVWFRbnRBYWgwZkNJNVJwMHlaK0pueU5T?=
 =?utf-8?B?V0t1cHY0UU55ZkxLYUhiNzZIcFhFb0FqRy9USW0zNU02YTNHdXlLUkZXSWtB?=
 =?utf-8?B?RXNLRmkzbzkwc0k3UzRSQkdXdk1oZ3k2M3ZCUXJmVm9RVDI4L0NFZ0hSZyt0?=
 =?utf-8?B?YmtheUxTYWNCbk9MbkFqc2pRMDBPaFhSR09rTlNHNDUzd01YWTBYUFRCdHkz?=
 =?utf-8?B?bDU1OE5KTFcwYlJaUUdrV3Y3bGppUjFpNzExdWZmYnpGL2tGV2M0b29aSFRN?=
 =?utf-8?B?cjFPbzg4OVYrU3Y3ZWRiWjZsdVpTRmhvYVhWVHVJV3pxVERYQ0R3T0YxRkJB?=
 =?utf-8?B?bjJLWW5CY3FLVGthTENGLzFwU2h0MWx6cUhqdXlqTkorekUzOCt6ODlvc0sw?=
 =?utf-8?B?aFJDd3lIQy8xZENzdE1Cd2xTZUVqWHNsSDF0T251YlZKd3NwTW0xSEdydGs0?=
 =?utf-8?B?N3ZCdXV6bEVLbENQN05jaWxmazFrdGduSXpFY240aDJ0b1ZvMGFTcktjVXZD?=
 =?utf-8?B?cVhxck1TNGJHRktLVXVkV0RFTzdnQnNYRzFYeGNSYXhLZDFnM2V4M3g1eTJs?=
 =?utf-8?B?U1hxR2EvZHNvaE53ZUcrL1YyVlY4OHQrSENGeGNmbUhjc3haNDFzTUtKL1hl?=
 =?utf-8?B?TmJXVmpKWmt4THRlSmpNd2NBUmVuMVJPLzhhNjlhVVB2NHJ3OGtUc09lK2N3?=
 =?utf-8?B?dlRDbzFIYmd1ejd5T0Q5YjFnVE5WSE95UTkvWHh4T1ppY0NRSnRiWHd2OTBk?=
 =?utf-8?B?NVBCallKclpleFlWSVUwQ2FSaTNCaHpKUG9SUHZYc3VFN0hoZ3ZHY1BGVWdK?=
 =?utf-8?B?KzNCSWkyUVV3RmRnQlVyQ3VhSmhiYmZieXJ4UERHdlVqcnRQZnJYc0ZtOTRn?=
 =?utf-8?B?UTdsT1RHMzBxSFBzYnl4bDlGY1NkVmZhWHZGNExrQjJPTGc3MUpqdnRyU1Q5?=
 =?utf-8?B?dThRaWNGNWZTcmtkVC9BdzBJbHNPYkdSSjUyUUw2b0pEZVJaUkFOWW1CVmVa?=
 =?utf-8?B?NEp1ZWV4bTI4cTEwOVdES1RSQkJrQkFNZ3NGMzRhcFIxMGFrRWczWXd2dkhH?=
 =?utf-8?Q?2ZmIOzv8wQMtHFVF+c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXJycUJaNXhHQ2YzWVlCN2ZadDFzWkIzVEJWUS93dmY3Q3IvamlSL1o3UWhr?=
 =?utf-8?B?Q3VPdzFkNnNXb2lPaFFjMGo3MVVnaWtUZzY4dldCK1NIUUNqeEczd1crL2xm?=
 =?utf-8?B?Q05EWmR3TmhaVWc0Mi9iSkJIZGlZMDJMcHJ0aFNsVjF1VlNoV20rSHJSdEdz?=
 =?utf-8?B?WE11Y0ovMGY0Y0RPZ2dzZjhCRm56OEovTUdjRGw2ZDIwUmp0MmEwYzNydVhC?=
 =?utf-8?B?K2kxY1dtK28xTmhOM3MzS2RjWlNRNnBRTHN3RUd4cktwR2QvU09tMm9BYmlZ?=
 =?utf-8?B?WS80cFRIMFBkNTZlU0dlWHNQU25RUlFqN3IxMmVaa3paYWFVMVhqc1hTK1Yx?=
 =?utf-8?B?ZHVTNjlWWXorR2ZZRHFCMXVTd3ZNd1czS2VvV3hOck5lY3FuU3VXTnZSSUQ1?=
 =?utf-8?B?MDBNS0ZNWnZ1RDFMTEVxNTN4c0ZxQVhERjhpVWVrTmx5SDkxaUdnTUtRTVd1?=
 =?utf-8?B?Q1o4YXR5WlIvVk42MkFSb2VvRDdMQjE2c2FYRFhBN2ltenFsV05rbXZNTlI1?=
 =?utf-8?B?UHo0ZURzTGVNR2tCMTRKRHlXRmE5Q0pyNEFJbnJUaUUvcTM2QkU1NzRMNUI5?=
 =?utf-8?B?SHVXZUoxVDBuUm84dSszTkVpTkc4aUE1eTZOYklpVysweS9sYVVya2w4ak5K?=
 =?utf-8?B?blRSV2pPbkhGeUsvUzJBYlFVeWl1UWRRc2ZYRmRYWTQ4OWVVcWxEdldJL3l0?=
 =?utf-8?B?QzRSNjhOcVU3dC9TWU52MFZZYndpUDhiQnRoeTY3RzdEcVRLVlNLbG91WlJ0?=
 =?utf-8?B?bVhxelVKSm9lcENEMC9oZ2pUSjRzYzZDUFY5bEZWdzVJRFo4UXVlL3JwM3Ni?=
 =?utf-8?B?azJwdjVOMzFSN3ZhdkU2UFdUNXpud3R5bXlsa3VrTC9DenlLRk9TMFF6ZjFt?=
 =?utf-8?B?YU1mYVNVdmdjU3pOUjVpQXVnQmwvL0RwYVB5SVArMElRY1BMTU1nWlBuNzA4?=
 =?utf-8?B?VlR0ZUNmcVA4eDQ0T2V0eC9rZDE0UVNvTm5Edk5zcDVhMHBIdzZEU0J1dERO?=
 =?utf-8?B?Z3ZUcFlVSlJVekRGK3ZaRllVVEttcGg0bUdqK2gvbHR0Y21lNWNVYnBsT0Ji?=
 =?utf-8?B?NEJuRGloa3ZMZVRJaGVJSHMrZFVDOExHVDl6aVlFcHhtZG8zbGRTU2tYL0wr?=
 =?utf-8?B?VEVHYTNDNHhUMnByWXVNRENIVWJDdnB5OHdnR3J5alA1QmEzNFluWWtGUXFP?=
 =?utf-8?B?clovaUIrc29xdTRBWEUyNHBzcWVFa210bFN3eW80UnpKbjJhTWYwZERreHF5?=
 =?utf-8?B?THRFSW1OTXgzOGZEMWpreGRxZXE0UEpkb1BxRUkvYytlN2RBUVc3NHFMbUNQ?=
 =?utf-8?B?aGRpNWZFcERUREpXQWlsMzhhYnpVODB0SStLWmRhTnJrc2R2Mk9GRzRheFBy?=
 =?utf-8?B?TEw4Z3FOSnc2RURMMUI5QVRpeWhTUWxvWXh3OHFsSDUrY0xjMU96ZFRVZ2RG?=
 =?utf-8?B?cUNva2UrZVA2K09nYUlsZlNQWUViYlU2RmdsZXErYU1tUmhGY0lJZkxvTFE2?=
 =?utf-8?B?SlZORGRUUVJONjhSTVA3MkV1MnNrY1pCd25TVEhuUE5XWittWWI2NURlc1hD?=
 =?utf-8?B?c3lTNDhvbHlGVUVCL0ppVERXOVZoYjRvRGNML3o5OVFOd2J0TTVwWVc0YUdU?=
 =?utf-8?B?RXFQeWFGc0x1S3hKOVN1akZwSXpZb0kvT1ZDbmFOOGRubFBnLzBEZngvOXBU?=
 =?utf-8?B?cnRxZlBGZ2JkcmVNSW1yaGpwYStzMFZ2QmhiYzlGT2xYMm5hbkR3dDRaMmVM?=
 =?utf-8?B?L3I1QTM5ZzFnSUJqOXIzNGVGYzZWdHljTytxNGVkb082djFiZEhybHpaSXJm?=
 =?utf-8?B?SzIwUDg1RTlCdWN4eWtnalhnNmNNcjMwY0U3Sk1uUmJpandxR0dMN1BxSWZm?=
 =?utf-8?B?d1F4NHBJYzc1MWMwT2NTdzg5elhjcUpjaGMrMEhkaDFZK0lRTnRIWElPYm13?=
 =?utf-8?B?czlndm9HbElWd25MOGc1THVaaUl1R3cwL3o3bngwZmM5aVNtaHd2OG1vUjhw?=
 =?utf-8?B?WnVsdHdGekVZMFFNUzlIYlRkRGc5YXllZFdpZllnamk4R080MklyTTQ2Wng3?=
 =?utf-8?B?YitwNEsyVmpOTlh5QWhCNktPdDZJZ2I3dWw0dHp2eFE4ZFZmV1V4M3lva1Yx?=
 =?utf-8?B?L1dqOTZJNEc5QStsVytjRWI2bzdGSThTTlZkWXpVVHdacFo4bk0rRWhvWWQ3?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1786ca-e1fc-4107-7405-08dcc60b8922
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 20:13:22.8572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9CRx8v4V8HZ8WUDxOTbFYtW+aS97xuWG+3PsUeleipLBH3F8z6nMPa2plwQQuW8wMmXDBzOIB4chjpj8ruBPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7118

On 26.08.24 21:59, Nishanth Menon wrote:
> On 14:01-20240826, Jan Kiszka wrote:
>> On 26.08.24 13:42, Nishanth Menon wrote:
>>> On 13:31-20240826, Jan Kiszka wrote:
>>>> On 24.08.24 19:58, Nishanth Menon wrote:
>>>>> On 18:37-20240814, Jan Kiszka wrote:
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> Expand bindings to cover both the MCU and the main usage of the AM654
>>>>>> system controller.
>>>>>>
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> ---
>>>>>>  .../soc/ti/ti,am654-system-controller.yaml    | 19 +++++++++++++++++++
>>>>>>  1 file changed, 19 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
>>>>>> index e79803e586ca..cb9da3ec39a8 100644
>>>>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
>>>>>
>>>>> As per linux-next, this file does not exist? looks like you might need
>>>>> to rebase on latest next?
>>>>>
>>>>
>>>> "This goes on top of
>>>> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org/"
>>>>
>>>> Is that series obsolete by now?
>>>
>>> This dependency information would have been useful when provided under the
>>> diffstat section of the representative patch. :(
>>>
>>
>> Yeah, who reads cover letters? ;) Will try to do that next time.
> 
> Looking at what we included in v6.11, looks like the above series from
> krystoff will need to be re-thought through.
> [1] makes the patches un-necessary to an extent by modelling the node as
> a simple-bus - Looks like k3-am62-wakeup.dtsi was missed, but it should
> be trivial enough fixup. Did you try applying the series on latest next?
> it should not apply anymore (Doesn't apply on master either).
> 
> [1] https://lore.kernel.org/all/20240628151518.40100-1-afd@ti.com/
> 

Krystoff's and my patches still apply on top of master and next.

I don't mind via which patches we finally get to zero dtbs_check
warnings, just that we get there.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


