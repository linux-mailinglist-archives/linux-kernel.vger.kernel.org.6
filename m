Return-Path: <linux-kernel+bounces-429416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7F59E1E5D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12474B39542
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260421E5735;
	Tue,  3 Dec 2024 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HF5H66Qc"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2060.outbound.protection.outlook.com [40.107.117.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288E1E500F;
	Tue,  3 Dec 2024 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228063; cv=fail; b=n/QaxcrGrp9AqVklsHuqfvFJSlbTg5s5kCX6ExhVWnuFSKrJfnXIOWX/dcm94wNRozTohdsig/yMTk1yx5MhzcVjcm7XnNlLS7WXdlvOTSDnohNckmUGywQ5kkCBrwZauwYsP9nf61jPUA3pPFNzJoYhpAkhzkYDt8IqPuXO1Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228063; c=relaxed/simple;
	bh=cPDQp4fRZr0Q9Ch110JzgbHSwxSMW1hMTLvuP4tJAII=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZDz/kaoUtKZ+rt3fw6maiOTH+mSjpFTXql33stXn2k6SUkJNwjW1V6Wdt1btKvqqDCl8XxiH/ENY87dw9thK790U/NUNjKGkXyO+TjIT9xc+po/p73fBMCDv0E+GLNoSVQjg0JaCu61aZ/WcwLKlKxiYmWhEOxJctFVanWGfGZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HF5H66Qc; arc=fail smtp.client-ip=40.107.117.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUeacYTM2MEpPmseLHRajDdhwWlN3ZpEBSsSneNV0Yp9AHUjIExz2DfpTH+yfmUCCejK1GkPxGoZKupn+6rKOVQ8xT+ZrcmKv8vLBViJXnXTpCAqQolcgUygmN1ZJhqnhfmASnN2AwHgDk6VN8/7WgIYCcCqGY1yjOlzypIYDMeRmCKBvw5oim9nAh8W8tPPB9sgtT5cxFgkWtXa5x5SMBg2Rk2UkFuyyXmTcyO07Zyka2eX5K7Mln5E9PjF9E8KNZGoVmH/Z6FvAu6nX5MMzHsDuNF/9FqSwsy6mWyVze/e4I++c9S83mgOsY56f+kpfaMZoy9sQn6RTodu5JA6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPDQp4fRZr0Q9Ch110JzgbHSwxSMW1hMTLvuP4tJAII=;
 b=b5R6Mede1MFw06dGtbBFLtF7vp6cXasCH8tXGKvfnK3e8CheViwEj+CP4q3I7pl1ZeOsNeQH2nWYZZmVW6EXBprG+hqrQHKSemZSetPFeMdj61XfOn7rwgY1WTIxnJQISr4y/F741Vr5RgzuH2kwhTiLM8B8wzcuu7iNwuOjhVdyFAkPg32fAihnRHhPkrwAtzT0Cc20JJkxa7T3cJCS7DDfrh/7gCBte2yRJ53e9i3iTJjLKIo/N+lJdr1BFQNnxQTexgz6we6r2xQQNK7iCj/Ig+LP2Rp+ODi5giWHfQa4eHHMwr3Wz2GniizAPlTABJxVlTrln9opq+s0YIRR6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPDQp4fRZr0Q9Ch110JzgbHSwxSMW1hMTLvuP4tJAII=;
 b=HF5H66QcLgucCiOkfAqbpjcpAQIXta1rTWlS/2R02iyr0l9kBc+p/hwNij6QlS8RJ1tDvVZSWktqVoEgxjpoiOT2zHzLeUN59SpmK4XGwIo12YY7qEav9NBJCCR3I6FNNN+2o8YTIzZ2uwV2SDrKEVbw68AKDOv9iPBCPUbq6bpzXCmRn2SyeyZfQWziCDQVgv6xyVzF7OleGrWLCon9CGN8ej9LgAkl7dJ6Fp/iS9HQzO5m563v7C0cQ8PRj4qhU//HGtvn7e8Wyfht19pCRs2NXJLrapz8V1mcGGMTUV+kvN26Ht0lsvzzhMV5Kx2LaHzPAMsXifjCi/PzXb5IbA==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by KL1PR06MB5882.apcprd06.prod.outlook.com (2603:1096:820:c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Tue, 3 Dec
 2024 12:14:16 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%6]) with mapi id 15.20.8230.008; Tue, 3 Dec 2024
 12:14:16 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Prashanth K
	<quic_prashk@quicinc.com>, "quic_jjohnson@quicinc.com"
	<quic_jjohnson@quicinc.com>, "mwalle@kernel.org" <mwalle@kernel.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, =?gb2312?B?uvrBrMfa?=
	<hulianqin@vivo.com>
Subject: [PATCH v4] usb: gadget: u_serial: Fix the issue that gs_start_io
 crashed due to accessing null pointer
Thread-Topic: [PATCH v4] usb: gadget: u_serial: Fix the issue that gs_start_io
 crashed due to accessing null pointer
Thread-Index: AdtFe+iVHwnkm4i8TKOizy92/U/fWQ==
Date: Tue, 3 Dec 2024 12:14:16 +0000
Message-ID:
 <TYUPR06MB62178DC3473F9E1A537DCD02D2362@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|KL1PR06MB5882:EE_
x-ms-office365-filtering-correlation-id: a7148f79-bd64-4932-d27e-08dd13940205
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?RG9URVR0dGlUYmlMclhLT3dMRGVkeDlaejBwcmt3NnNBM29MZzZGME5IZSti?=
 =?gb2312?B?N2xKK21SNlR6NHc3a3NxNmZUYm9kakhqbERsNUh0UURma2k3bTNDRDBwUzBq?=
 =?gb2312?B?OENuUEZtaVFQZklQeDlnYWVhYm50UkZFelZoUHVpNStRaEFYdDE2a2ZYSEJU?=
 =?gb2312?B?QWtGakp4WGt6SE03STRuemJqWC9EblJ0NjFtdUhpQTZPRGM5TzJObjAvSG91?=
 =?gb2312?B?NFJFTG9DOHV2T1ZHcUo5MEtjL3VvNG9seW9SS2FSNEdkMFRDdVEwS1JuNk5w?=
 =?gb2312?B?TkMzR0JmaERQdVBZbEc1d3ZlMmpmeERlVE9GQ2RLOXkwUHdiSlN5b1E3a2tZ?=
 =?gb2312?B?eEZGbWNIRkozOUQyVzZiL0NpaXBRZEdsSDZ5RzhlNVhjMUpqbUJUM0RFUW9N?=
 =?gb2312?B?WjM4d2MzUi8vUHZWb21uQlJ4RW53MzM0RExQWnhtdmRpeUJqbnhsc0Z1Z3FS?=
 =?gb2312?B?SVVOMmZUc2FOaEhSb0cxOTdQQlgwSUhnZ3Y2SVk3UCtqRFkydGM2VFJYSFAw?=
 =?gb2312?B?cE95bEYrdVRYNitETXdEai9LZ3hJTHIzN3hKUld2WkR6VC92bWVsM0I4OXVJ?=
 =?gb2312?B?Lzc5L2pUUTJCRmNaTzFCQlEwRVlBdHlPNk1TR0dKc21ZZ1hGT0NFUXNTNWZl?=
 =?gb2312?B?MnRCZkdjTjhQL0FSQVhhdnRjUjJ5ejhmY01WSmpkdytNdzBFdVVHTnRBVUE2?=
 =?gb2312?B?Qi9wc3h6bmZGNXdObVdDYlhDazRJMnd2U2QxZzBDd204SjByTW9Bc013YUxw?=
 =?gb2312?B?NG9kcjI0SFg3bFVTYXJrQ1B5NmxkMmJNM0dHRGFDWjFudmVEN2QyQTdtQ3Z5?=
 =?gb2312?B?czcxYUR4ekNrNjBBaHhuR0dsR0d5YTgxNmZlRGJVNUxJRERZRytsdEdOWmcv?=
 =?gb2312?B?eVZNekFvRnZqQWZpZjJtcGdCSTZyQnlCaVdLN0ZBSTAzc0ZTNHVPdlBuQUtw?=
 =?gb2312?B?c0hNdWFudnc1S3BXb25UeU1EV243c0lIblNobkdqaG05Z3FhamZkUkpHUmhj?=
 =?gb2312?B?YklBTVV2dVdMNmxzcEhwcE1BSmtRcTFUM09xaVp6emM5KzVlWXVjeEpBU3ho?=
 =?gb2312?B?aXBicnRlVDlsZVRFanZadytaTm5KZFMzRm5YNlRwNTYyOVBqVkpVejh1eitK?=
 =?gb2312?B?N0RnaCtva3QwYkxzVmNmVWlNeGtVOXBxY1QrZTlXUkd4djc0QjczcWtEaU5B?=
 =?gb2312?B?SGp4NzR1QVJTMGZFK2ozcmRRNTlYVXhtaEl2OVpiZ010RkQ2OWtoVi9mT2FK?=
 =?gb2312?B?STJ3cEp2bVBiYWhYYlQzYXVUL3RmMXFuVkxtdnFJWUlyQVEvSXo4ZEMza3F2?=
 =?gb2312?B?R01uQjVnT2lEdy8vdTlwNkRPYWdnMUEwVENiNXpkSzduTnp6UmhIY0xjQlBt?=
 =?gb2312?B?ZTlVeFRkdmR5SGRxT1oyZnkwT0dLRUkxa1lVL0taQ096SGI3b3hKQS80c3JR?=
 =?gb2312?B?Q042ay9LRjNsOGFTL21xTXhBeUtIT1o5VkdNd3l3dTA0T2RjMkh5aGdMR3NO?=
 =?gb2312?B?NXQzSUtRbDhTLy81WlF2RDhaUkM3QU14Qnp1T0tpM3VSSEdQcmxSbktma0M3?=
 =?gb2312?B?WUhOMS83ZVowWDlMY2FhUnVkRWN3VW9UazlaMTRwWEtzWVBlZE9HSVdWWkNZ?=
 =?gb2312?B?MnJpSkxJbHFuNmJUK01xN2ZlcGNpMDVMVzZjNjRsNkluQXg0NnZYdFd0YlhI?=
 =?gb2312?B?U3VoUWxLSVZUZG13VjllQVB3SEtYMU1CbUxzNUVXa25rWGlMSVMxL1hDbGdN?=
 =?gb2312?B?R0FMTEhxWUdYQXBSK2xXZ01NYkxETWhmYzhMQkZhbmdKdnRJQk1xZ0Z1TE1Z?=
 =?gb2312?B?NkYwRFpzMGpxYjBqVm9rNFBwanF5c1dIYW1jMjVWNFpkdVkzMysrcktodW9w?=
 =?gb2312?B?TDR4ZS92b2VaMTZteGtQM093bkZkSVB1dHFva04zdkxQekE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?b2dwV3ZWOWJibHFuU0kzeXN1QlRqVk9mVFJSRHl2NHpvQXNFY0Y3RjQvQnMz?=
 =?gb2312?B?SG5FanEyTWpxMHJ0emlORkxMd1RQaHBsSlRIZ3R4U1lxWVFLUExyT3BRR29n?=
 =?gb2312?B?T2lxMGpWQXNpbm0yb0c5ZjREa0RIcXptQ3ZnbldoQzBhRE11Wkd6aHBhZlkw?=
 =?gb2312?B?bGdOR3p6NDJBK05ndUsyV3FiUFBJUlJvWWJIMFdTaEpMSDJPbWhldysvb212?=
 =?gb2312?B?KytYendTaXpBNXUvMk1xTlM5QTFsZXlXcGtQYTFnaVFhSW0vZnE2ZWt1Z0cz?=
 =?gb2312?B?MThKVjNyVGlxMCthdloyc0thdkdjcDZ5QVRsSGFxSmZoaGZiNEM0S215U0Qw?=
 =?gb2312?B?aEMxR2lZNk5lemZIUk5tN2oyeUxNaVA5UEZqS2NDNFlFVW5ISSs3UFNrVXdj?=
 =?gb2312?B?MWdxbzViMHpYeGlCZDZYbFlpaWlBZDAxaHg4S09wKzFlTWp1cDUyYm1tVlFn?=
 =?gb2312?B?SytIVUJnL3dWSjV1dktuV3FPbjJqTDM2ZThCY1pLYlBMMjQrMm9pU2daa3B6?=
 =?gb2312?B?VEluaHJmMm5RSmZFL1JXdXVUSmZodHVmZkduSmpqWms3T0tCMkR1UWl6Y1ZI?=
 =?gb2312?B?aTJXblF2NCtETmNwcUNEdnpaY09VcDhtNUhQbHp6cW5MdFdCdTNSb3BQK1F3?=
 =?gb2312?B?SGcra3doa1hnRjB2SmMzMGVmcENDYUwxV3AzL1FoL1htODB2MUQ2d2lyYjR4?=
 =?gb2312?B?aHVxRWFOM041ZVl4aU1OOHdoSVZqZmhZa3FPYktCWmhKTUZqL0VOWjVRdlhq?=
 =?gb2312?B?U3RBWkF1d1NLcG1qSjg4c21tQ3o4NVFuRkhyVmZiL2NuU3NHeEphU04wOFBO?=
 =?gb2312?B?NG9EOFRnS1FaNkNZV1A4cHBwNmFoZWhDMSs1ZlJxMlA4blZCMkpCbVdhWlJI?=
 =?gb2312?B?MFl5U2RXNnJOYndKaGhLUktHQzlNcTJzVnEya21IaXpLdFgrRVUyNm9jdTE5?=
 =?gb2312?B?amNJQlNSbDNBeU9HcEFMaXJScGptaityL3FUOTdFUU56Z3RxcUVVTS8zbCtT?=
 =?gb2312?B?aDZjYmhXeGUxVzhFTTl2SFlOdlBDZU9raElUUmNiYzdvTWdGSjBBZTBaT0hM?=
 =?gb2312?B?S0JQczhIT3RRMHFoaWpoa0xaT294TG1KVjB4SHI4cG1JZHphck1JL0xJckpY?=
 =?gb2312?B?ajhxK2c4azhzWTcvK2FMcHRhK1piUk9Ya3kyUlRBZDhoK1JHMm5pa2thRzBj?=
 =?gb2312?B?OUoxN0toT1NrdjNSaEdEdndVdHR1TVY3VlhndklQb0pCKzJoUjdvbVJyZXhz?=
 =?gb2312?B?Y2hhdmlRNzhJS2FNcUZuMm9jaEtreG44azZtK0hiMHJBWU83TzFuTmozRldl?=
 =?gb2312?B?M1R4cjVzRW5mdllkRmkyMEJZdUZVaVI3d3E0R3ZnaURBYkR5dHMzakJnTmk0?=
 =?gb2312?B?TnQyQUxYbW5yYXA1U2dMaW8xMkRYTXQzSk9CdW5rV0I0U0l1NGY3Nyt0Mkow?=
 =?gb2312?B?M0F2Sk9zYVFUZ1A5aGZ3dXRoWFFhQmxzeEhaajlFVkNPSUpodEVyWWhNaHRV?=
 =?gb2312?B?Z0ZITzBHQ2M3RUt4SVo5L0wybE5zOWhFTGoxOWUzVHJSVnAwd1I0MzUyZkN2?=
 =?gb2312?B?TFlnOW5IdHpobnBpRkEvK3NSWnJkNGgwMGoxWDJHdlJON2VTTFhDYXFEYnYw?=
 =?gb2312?B?c3VuSkZNUWJoRktIS29WYVRQSzFreGtMUElyZ2Z2ejZWSk1BaTB2Rm1TQjhK?=
 =?gb2312?B?dmVvUmEzQmNOeElaZHpMQXVHSXJOZnY4eEVpcmRMN1o2TEFjK2VxZnJwdFRh?=
 =?gb2312?B?Q3JDSnRWenNDbGxFbStDMnRHbmE4a1VUR0tnL3pUSmw5R2ROZm96T2pURHBt?=
 =?gb2312?B?MW9hemhVa25jU2tCRXpzSWV6TnJOUGptV1kwMndGQ0xtbTRncEVjb2hwa2I2?=
 =?gb2312?B?NmQ5UkxXUXgveGkxVXFWbDVVRjI5R2Z6am1MZjl0YWYxVDZQVklVZHRyQjBa?=
 =?gb2312?B?S1B5UENYaGJ2Q2VlR3I5dmN4Y2NrNm84bCtqa3A3ZXE0RWFBVytxYkw3SnFh?=
 =?gb2312?B?bUYrTnVCWGlVTFdjRzZHYXA4TWh4aTRRaWR4R0ZkV3BjZHIzWGxGZXNTZXJi?=
 =?gb2312?B?UzhSRTFldzYyU1JOQlJnU2JIRnN5YjNneDAxREdiSE9MSmZlVDBaRXdmcUV0?=
 =?gb2312?Q?pBjI=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7148f79-bd64-4932-d27e-08dd13940205
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 12:14:16.5886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1TjzU6pE0gx2d5ynKvxNbmYobPubsXeMSy9lzcLCpfq7FRSsxxzy9VgzCG/LA5TysRXwrsXrrDJMObJtQIOfOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5882

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpDb25zaWRlcmluZyB0aGF0
IGluIHNvbWUgZXh0cmVtZSBjYXNlcywNCndoZW4gdV9zZXJpYWwgZHJpdmVyIGlzIGFjY2Vzc2Vk
IGJ5IG11bHRpcGxlIHRocmVhZHMsDQpUaHJlYWQgQSBpcyBleGVjdXRpbmcgdGhlIG9wZW4gb3Bl
cmF0aW9uIGFuZCBjYWxsaW5nIHRoZSBnc19vcGVuLA0KVGhyZWFkIEIgaXMgZXhlY3V0aW5nIHRo
ZSBkaXNjb25uZWN0IG9wZXJhdGlvbiBhbmQgY2FsbGluZyB0aGUNCmdzZXJpYWxfZGlzY29ubmVj
dCBmdW5jdGlvbixUaGUgcG9ydC0+cG9ydF91c2IgcG9pbnRlciB3aWxsIGJlIHNldCB0byBOVUxM
Lg0KDQpFLmcuDQogICAgVGhyZWFkIEEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBU
aHJlYWQgQg0KICAgIGdzX29wZW4oKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2Fk
Z2V0X3VuYmluZF9kcml2ZXIoKQ0KICAgIGdzX3N0YXJ0X2lvKCkgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY29tcG9zaXRlX2Rpc2Nvbm5lY3QoKQ0KICAgIGdzX3N0YXJ0X3J4KCkgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZ3NlcmlhbF9kaXNjb25uZWN0KCkNCiAgICAuLi4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLg0KICAgIHNwaW5fdW5sb2NrKCZwb3J0
LT5wb3J0X2xvY2spDQogICAgc3RhdHVzID0gdXNiX2VwX3F1ZXVlKCkgICAgICAgICAgICAgICAg
ICBzcGluX2xvY2soJnBvcnQtPnBvcnRfbG9jaykNCiAgICBzcGluX2xvY2soJnBvcnQtPnBvcnRf
bG9jaykgICAgICAgICAgICAgIHBvcnQtPnBvcnRfdXNiID0gTlVMTA0KICAgIGdzX2ZyZWVfcmVx
dWVzdHMocG9ydC0+cG9ydF91c2ItPmluKSAgICAgc3Bpbl91bmxvY2soJnBvcnQtPnBvcnRfbG9j
aykNCiAgICBDcmFzaA0KDQpUaGlzIGNhdXNlcyB0aHJlYWQgQSB0byBhY2Nlc3MgYSBudWxsIHBv
aW50ZXIgKHBvcnQtPnBvcnRfdXNiIGlzIG51bGwpDQp3aGVuIGNhbGxpbmcgdGhlIGdzX2ZyZWVf
cmVxdWVzdHMgZnVuY3Rpb24sIGNhdXNpbmcgYSBjcmFzaC4NCg0KSWYgcG9ydF91c2IgaXMgTlVM
TCwgdGhlIHJlbGVhc2UgcmVxdWVzdCB3aWxsIGJlIHNraXBwZWQgYXMgaXQNCndpbGwgYmUgZG9u
ZSBieSBnc2VyaWFsX2Rpc2Nvbm5lY3QuDQoNClNvIGFkZCBhIG51bGwgcG9pbnRlciBjaGVjayB0
byBnc19zdGFydF9pbyBiZWZvcmUgYXR0ZW1wdGluZw0KdG8gYWNjZXNzIHRoZSB2YWx1ZSBvZiB0
aGUgcG9pbnRlciBwb3J0LT5wb3J0X3VzYi4NCg0KQ2FsbCB0cmFjZToNCiBnc19zdGFydF9pbysw
eDE2NC8weDI1Yw0KIGdzX29wZW4rMHgxMDgvMHgxM2MNCiB0dHlfb3BlbisweDMxNC8weDYzOA0K
IGNocmRldl9vcGVuKzB4MWI4LzB4MjU4DQogZG9fZGVudHJ5X29wZW4rMHgyYzQvMHg3MDANCiB2
ZnNfb3BlbisweDJjLzB4M2MNCiBwYXRoX29wZW5hdCsweGE2NC8weGM2MA0KIGRvX2ZpbHBfb3Bl
bisweGI4LzB4MTY0DQogZG9fc3lzX29wZW5hdDIrMHg4NC8weGYwDQogX19hcm02NF9zeXNfb3Bl
bmF0KzB4NzAvMHg5Yw0KIGludm9rZV9zeXNjYWxsKzB4NTgvMHgxMTQNCiBlbDBfc3ZjX2NvbW1v
bisweDgwLzB4ZTANCiBkb19lbDBfc3ZjKzB4MWMvMHgyOA0KIGVsMF9zdmMrMHgzOC8weDY4DQoN
CkZpeGVzOiBjMWRjYTU2MmJlOGEgKCJ1c2IgZ2FkZ2V0OiBzcGxpdCBvdXQgc2VyaWFsIGNvcmUi
KQ0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNClN1Z2dlc3RlZC1ieTogUHJhc2hhbnRoIEsg
PHF1aWNfcHJhc2hrQHF1aWNpbmMuY29tPg0KU2lnbmVkLW9mZi1ieTogTGlhbnFpbiBIdSA8aHVs
aWFucWluQHZpdm8uY29tPg0KQWNrZWQtYnk6IFByYXNoYW50aCBLIDxxdWljX3ByYXNoa0BxdWlj
aW5jLmNvbT4NCg0KdjQ6DQogLSBSZW1vdmUgYmxhbmsgbGluZXMgYW5kIHNvbWUgYWRkcmVzcyBp
bmZvcm1hdGlvbiBmcm9tIHBhdGNoIGRlc2NyaXB0aW9ucw0KIC0gQWRkZWQgRml4ZXMgdGFnDQog
LSBDQyBzdGFibGUga2VybmVsDQogLSBMaW5rIHRvIHYzOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvVFlVUFIwNk1CNjIxNzBBMzA2NTFENjRFQjU5Rjk0Qjg4RDIyRjJAVFlVUFIwNk1CNjIx
Ny5hcGNwcmQwNi5wcm9kLm91dGxvb2suY29tLw0KDQp2MzoNCiAtIFVwZGF0ZSBwYXRjaCBzdWJt
aXNzaW9uIGRlc2NyaXB0aW9uDQogLSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvVFlVUFIwNk1CNjIxNzhEMDBEQzk2Q0MyNzAyMTE0Q0Y1RDIyMjJAVFlVUFIwNk1CNjIx
Ny5hcGNwcmQwNi5wcm9kLm91dGxvb2suY29tLw0KDQp2MjoNCiAtIE1vZGlmeSBwYXRjaCBjb250
ZW50IGFuZCBkZXNjcmlwdGlvbiBhY2NvcmRpbmcgdG8gInYxIHN1Z2dlc3Rpb24iDQogLSBMaW5r
IHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvVFlVUFIwNk1CNjIxNzM3RDE2RjY4
QjVBQkQ2Q0Y1NzcyRDIyNzJAVFlVUFIwNk1CNjIxNy5hcGNwcmQwNi5wcm9kLm91dGxvb2suY29t
Lw0KDQogZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMgfCA5ICsrKysrKy0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYyBiL2RyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQppbmRleCAwYThjMDViMjc0NmIuLjUz
ZDlmYzQxYWNjNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3Nl
cmlhbC5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KQEAg
LTU3OSw5ICs1NzksMTIgQEAgc3RhdGljIGludCBnc19zdGFydF9pbyhzdHJ1Y3QgZ3NfcG9ydCAq
cG9ydCkNCiAJCSAqIHdlIGRpZG4ndCBpbiBnc19zdGFydF90eCgpICovDQogCQl0dHlfd2FrZXVw
KHBvcnQtPnBvcnQudHR5KTsNCiAJfSBlbHNlIHsNCi0JCWdzX2ZyZWVfcmVxdWVzdHMoZXAsIGhl
YWQsICZwb3J0LT5yZWFkX2FsbG9jYXRlZCk7DQotCQlnc19mcmVlX3JlcXVlc3RzKHBvcnQtPnBv
cnRfdXNiLT5pbiwgJnBvcnQtPndyaXRlX3Bvb2wsDQotCQkJJnBvcnQtPndyaXRlX2FsbG9jYXRl
ZCk7DQorCQkvKiBGcmVlIHJlcXMgb25seSBpZiB3ZSBhcmUgc3RpbGwgY29ubmVjdGVkICovDQor
CQlpZiAocG9ydC0+cG9ydF91c2IpIHsNCisJCQlnc19mcmVlX3JlcXVlc3RzKGVwLCBoZWFkLCAm
cG9ydC0+cmVhZF9hbGxvY2F0ZWQpOw0KKwkJCWdzX2ZyZWVfcmVxdWVzdHMocG9ydC0+cG9ydF91
c2ItPmluLCAmcG9ydC0+d3JpdGVfcG9vbCwNCisJCQkJJnBvcnQtPndyaXRlX2FsbG9jYXRlZCk7
DQorCQl9DQogCQlzdGF0dXMgPSAtRUlPOw0KIAl9DQogDQotLSANCjIuMzkuMA0KDQo=

