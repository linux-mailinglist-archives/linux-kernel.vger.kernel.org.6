Return-Path: <linux-kernel+bounces-248894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 186AC92E35B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754F7B22399
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFA415575B;
	Thu, 11 Jul 2024 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="GlCweC5Z"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2096.outbound.protection.outlook.com [40.107.215.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9506F14F111;
	Thu, 11 Jul 2024 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720689706; cv=fail; b=SZWrFToQNtKVEJM48lpu/wt4WbWkeSQMPnk/vM5PWo0kR6iKAyu1q5CZUbOeKdykwAYgHmU2F25LphPyTjCvc+ij2HmtE+Huo96LZBYIOiV4lsneWgsS0AGSfXJSJs/thOZbDt1keEFdHoaVZDRU5DVGVFN2ofW3qbXtDIBzJ1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720689706; c=relaxed/simple;
	bh=jCUtfLMdlGqQ+suhTTcn8QAoFelYt/p20Oen7Z0T9EM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Poc5gXGmlA+mDi7YuX3x39aY5HJKRZ4iMZYWj7kIIi5x3D1RlqGK9EQgod2lugr4guw185KJ4lrqfjPyjn1xGwxUiNRF/NKTmyA3kA/WMjbyGo0RGgS5e691oXSatdJrn2+PzHpDufs6BpWG7epQsQou6Bw5ZrJGzQqaExiWRGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=GlCweC5Z; arc=fail smtp.client-ip=40.107.215.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flmd6VnrK8NxAtA9eLyHQ80YzNjrBOy5kLjhYZLVHT4ED1PBmJJ+7g4Vvz2e52pghnztUlVqxOgldbHiRPtn0fVUt+9JpjBQB0du2eVWuGLvH9ZhOyOMVDehJhLpmNE7zK71AEUosyMUSVMWRAyMEvbiB575fi7j5Ze5LvhXS8s2kG6MemBYdr2Gysq2CUQR3Gg6WV1U5SyHq33MGlt8vOpdcE3pumSWwvTMEYMTzxcU66tQIzKMWNJdjexz8D5zGDgHcBp9wTfKqbqftTbLNPyTkqcDbFn0YmCwohi0+1BlRU7Zr7AFbJqgThYG1Y2TJOFa+QZtXWVuUgvHKcgxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muysqAzZnksQWdcYQMP/1nE1QtP26I0Yx30WrT8Jujs=;
 b=WCu12EFejOwvR+NvDwsXjLw+dJ9JnbXvIHASdlOSaBtUsOk0wP1+VfOah26qJk/y4mp1vtm/XznTbZ/FrFChjmLSQQDB2bs3eZvFNLdPOoqqy+h7ZfN1aRy2FfJ+6OfW+/1SuEg9+BGqKBEQS0+cXT3LaiM6if8nuqHQW959jpzOqrnh9vRFdHUL4weBkMp6MsFw2GQlPOy5wyVnBfl7RrJJCVzPySgQhc+B3+VeERGRjq6q3OkjxiRLfhCAsypRQInd4IqJaiQ5gwB7XCRQb1NXZ2F1ulCP0NlqNHbcINjdoq3RnylAE+9zMoWPocp9T8HRakAHbvRml1Ut2gmrcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muysqAzZnksQWdcYQMP/1nE1QtP26I0Yx30WrT8Jujs=;
 b=GlCweC5ZVRciyhzFxY3WZvhGfFdgqtNOyTWl369/4G56NGjOGh9Tl/ohaC8CJjvxtUNaKuLgLXNlSpfSJwRsELKvIq0xTIF/sAYARyb9eVDvf9WWyzUcdRGcliP8RdHWxsZxqekY+jqRLt4dK6/76Rurlao+yrfydYdTF3tEJ31g6sBGfP4CCeOF5cUVtq5OkXrSqUWlmjc+5PmdJWvoGuMs2tSyCtM6p/PpVxtwqdLDakLkdKwC90a4QMevzJMIIq56JFR+LWxVwwE31DlfYz7Vkb/dc/hwVLGj+1AvmZMyD6iNyse/tj2PWkOsik+vTYgK+CM1r7ZCkY08+ePPKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8)
 by TYSPR03MB7783.apcprd03.prod.outlook.com (2603:1096:400:411::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 09:21:40 +0000
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732]) by JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732%7]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 09:21:39 +0000
Message-ID: <89e1ec7c-0269-4795-923a-249013b2267b@amlogic.com>
Date: Thu, 11 Jul 2024 17:21:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add support for Amlogic T7 reset controller
To: neil.armstrong@linaro.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zelong Dong <zelong.dong@amlogic.com>
References: <20240422-t7-reset-v2-0-cb82271d3296@amlogic.com>
 <c11bfe7e-e917-4ecd-ab2c-548332a4d22d@linaro.org>
Content-Language: en-US
From: Kelvin Zhang <kelvin.zhang@amlogic.com>
In-Reply-To: <c11bfe7e-e917-4ecd-ab2c-548332a4d22d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To JH0PR03MB7384.apcprd03.prod.outlook.com
 (2603:1096:990:11::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7384:EE_|TYSPR03MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 348546d9-ff21-48b7-acb8-08dca18adea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmtPdGJwdDZBMlVQRkNrbUtONHhnMExJdWFHekRiZmlpMjRrWURxNVpVbGEw?=
 =?utf-8?B?cm1ZOFVpUkxXcGtKS1o4cUoyYkF4QXJpcGluTVlyNmdwbEZQVWxXeTZabmJv?=
 =?utf-8?B?c3RGNFN6d3oxRUVOQVJVbEZmYWFUTS9aN2xXVjJRaXVwRmUwTHkwelhSbG5h?=
 =?utf-8?B?d1pOL3g4ZEMvTmNoWXVZdThLVC9HUHJObkdzdjlKZmFCNGVjZHd5K1h1ZDdo?=
 =?utf-8?B?eWUzRGx0N0U4T3ZTT1BuZkdNMDBIYldGZVZ5bFJiazhXMkt2VXE0MGkrbzd1?=
 =?utf-8?B?dlFqYkFnSjhhc1hWZUcrNjh5cGpwN09hV2lBWjlXczZDSi80VzZXOStZOEwz?=
 =?utf-8?B?WmxCaWkxTkg4QlVRd05zN0lDN0JoRWJNWXg3R1E0UDkzSDFRdncyb2hhTHd5?=
 =?utf-8?B?Wk9PYnd6WjZRMVJqRnlkVkwzajM2U2ZEZzFNdENXNnlzdUZWUndUVFdrY2lv?=
 =?utf-8?B?eUNCR29DK0lJWlNhTmkxeWt5cHFBV1U1RkRlT2VEM3J5T1pOOU5pK2JJWVpV?=
 =?utf-8?B?eEF6NGlaNGhncmc0UUtWRHNDU3lPS0FheklxR2t1RjkzeWErYndqZzRSa253?=
 =?utf-8?B?RUZFK3M5QTltU3grbFhXOG9aeU1GQmg2RjlyYndoWS9Ja0l0TXFyRkhrK1Y2?=
 =?utf-8?B?VlBDbmJJMHZ0Q2xMUmdEWlZLUEtoRlVlNUgveHZ2NGMrR1kvbElxZFJCQU1S?=
 =?utf-8?B?OWxJWHdzT0kyNi9OdXc3WDNUZkl1SU1tZkpMZU4yYWZ2UkVxQXZybVhDWVkw?=
 =?utf-8?B?ZmdGUkozVmJqNDFjOGxtMUNTSmc2STQxcjE3Y2xva2RsZFc4VDJFbHZVWXIw?=
 =?utf-8?B?d1dHZ0VIOEtETEtzek9kc3hpcnIxNnJHcXpGSWR1cTAzdlJvRGxrNWErQ2wx?=
 =?utf-8?B?ZEFJa1kwUzJvbmV2c1RVNVVXdkNJTEMvQjkxUTljWjZBZmlqMXFFRStSV0NG?=
 =?utf-8?B?WWNqMlpCUCt0akJDMGJYbzlibHdIMGljUWVJNlEvdjIxQ2lyM25HOXBSaU42?=
 =?utf-8?B?UmY1OGNpdW9xR3RlNGFSeXNWOXlqckVqd1ZJL0N1UitJU0pTR1ZnT2hxZVV1?=
 =?utf-8?B?TXF2L1NCajUyM3hZbWJQODdRVnBxM0ZsWXNLVDlpaDc1d2d1M1NXRWx3eERr?=
 =?utf-8?B?OFhENGpMeGk4YkNRQ2dzS0MxU1JXbE5MZHpacDJBRDQzV25VeWdMZ1NHUlU3?=
 =?utf-8?B?bThwaFA5bTFxU1dlQWhreTUrSXZVMGZBb3J0QzNaUkZXMno3Nyt2QVdKN1Fu?=
 =?utf-8?B?TlYzM1NzTDA2a1pENHBEQnVRK3k1S1NQVW9iZnNVQUdWcGd1RDJRZitnSExV?=
 =?utf-8?B?MDFyb05MNjdOZndLRE1MWnBJSmk4V0dSS3prakl3V3dZQStPQjFwaThoNVcx?=
 =?utf-8?B?L28rY1AyQnpLQzVjaTZaSnNyYnJrM1JQU1k4bGdiUDQzVEtBQTB5ek9rSGhG?=
 =?utf-8?B?VjNVeDErUWdaeitIOUxnY0hoYVZXTkpJeTRlV0lyaE5ET08rRXZ5ay95bWNp?=
 =?utf-8?B?dXFrZ2Zramd1VXplVDVTZGZtYTg0ZU9aVHh6aVZ3dXdKNXdCL2ZRTjFBV0dE?=
 =?utf-8?B?ZzRqZ3lxU1d5a0tWU3B2dkp0MjdxeU5jelBqTExMQS82MXdobkp1eEI1aFhE?=
 =?utf-8?B?cFBNM0l4Y0JNZVZkVnBGMmh4ZHp5c0JkZS9BRTluem05djE5SE44d0t3ajZW?=
 =?utf-8?B?U1F1RGZaSTE2cGpJTkRUN1BsZE9QYmdRMG41dmovVjY1SVc0dG5ISHZqOHl5?=
 =?utf-8?Q?L8tXXtFDRjj6xi6HX8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QS8zRWZEcitaZXQwVy9NTHoxUElFeGcxbGxVdUZaRjlwWHdHUEVYaFg4Z2JI?=
 =?utf-8?B?Umg5RWN4YVQzRk54TURUTGJKWjVQNm1TYU8vVnpWMmo1a2xHVmE5dDhzOW5M?=
 =?utf-8?B?OU1QUHBGMTJiclFGaGlMd0l2cEl1Vi9FSDBoN0hmUkV6eWtuU0JCdlI2cDRP?=
 =?utf-8?B?K3d5Mm8yVmw3dytOZkZaSzB2cGxzcDRNN1ZqbzdCbVArRXdYTXREU2FlenRV?=
 =?utf-8?B?WkVOVGtFZVVUaDlFZHJrcmdhNkJFNFBvS3VpVVpseUVqUHJ6S3R3MnY3clQ5?=
 =?utf-8?B?Y0k1MUFzYkZMQWRyM2RRcjdQV2hneDVBMjNkdTVxOVRCT04zcFNGYkNDbmx0?=
 =?utf-8?B?KzlpNGtGWklYVC8yZ25qa3VXK2JYSzdUenA3Qm93Tm1uMUZ0OENYUkxSVGp3?=
 =?utf-8?B?ZjJBeHVZaElObjdYQlh1UmxEdkdHL25JcXlMWGxhVFlINDF6R1JXWVBpSGo0?=
 =?utf-8?B?ZEVmUnZmYlVZUGRKam50Nk4rNDRhZVAxcTZxcE1FYlR4NURQVzVuc1lhc2U5?=
 =?utf-8?B?Q0w4eHlCclZFVnA0SFJUTzJ3STlNRms4djZ4NFRtaXpBbE1XNWpiOVp1bXpK?=
 =?utf-8?B?MWRPdlRaQzhLWlQzaXFidlJYeFF3eVpuZlRxelVyekJqcDczalV6bzM5Y2Q1?=
 =?utf-8?B?RXBFNThSait4WWsvTHhqRVJaRzZSRjFybVkvK0ltVUpQZWVXSEdQMXI4OTNz?=
 =?utf-8?B?OHJVaUhUR3crdFRBVHo0QjU2RkxOUEkzcmVsMlFxTzAwbHR3YnpXMlRHMHh1?=
 =?utf-8?B?WElaRnlPWWlUKzcyTkZtV083b05nR2Y4eGFjdCtwUkcvMXVudzN6QnkxWlBI?=
 =?utf-8?B?dW5pYnBlZVRNS1AvVzdyMFEwOEpEd3hMQ0lXekZDelQ4Q0dpK213TytrY3ZT?=
 =?utf-8?B?K0VoQUoxY0NJdDBmTFVyYi9TNjhPQXJabXk2b2djK0RseTdkZEZVeHV6OGVN?=
 =?utf-8?B?ZlFUVWU4T2NBclBBdEVEeHFyaktMdTFpdTJDT0psR3ZlSmt0L3UzSXdNbHpY?=
 =?utf-8?B?VEJNTi8veFlqUE9aTnlJT3V1SFRFTnRyWlhzVWYwaTFCbjY5VWdVUWY4ZUk5?=
 =?utf-8?B?Qzh5cDcrcTBHUUZtT3dXZStyaXlnN1VnZFl5QUhrY1EzdDZzeHNJcTg5UENM?=
 =?utf-8?B?dG5ZNnVCVzlrZHVFWTArZHBtYjZRSHFXcEl6eTdOTU1VVjdxQ3ZyMk1Vd3Zp?=
 =?utf-8?B?TzlVd28ybEJJUVNUR1VYbXNGbGJMMEJLc1J4SThWTmlTaHV0UGlpMTFpWXo3?=
 =?utf-8?B?OWJyRkpNY2xBbmlNWFcrQzRPUmxwd2twVmZkZFFiKy9SWFJrTGZ5TlRzYmNY?=
 =?utf-8?B?L3V1UW9OWGl4bDRXQTlCdDJSZDV6SHRwSlJuOVVjd1JuTDZUcDREaGFXTkFr?=
 =?utf-8?B?MVNOdUxubjRDOCtKVUpqYkNtRThzUlJzc0JTejBLd0wzYWdXODhnQXRoYjVQ?=
 =?utf-8?B?OWpoTmUwMXdIaExBb2dOanp1bFRMYkJaZFZsZUlBU005UEVHSGcxbkd0L1Fs?=
 =?utf-8?B?QTUrUHZDMVdRb24rOFVzcWNXMG1ZNlM4STRiTFZyeEMrcmxlYXJxVnJPdnA0?=
 =?utf-8?B?YkZTckxqOU1kZHlFV2txNXFuYlBuRkNoblNtUWhaNjdWcElSN254RHNBd3Yr?=
 =?utf-8?B?Z3FsNVFqRmRRWnBDLzQ1UnhKSTZCOER2QVBzK3lUc0JsT1BTV2RoeTJNL0t0?=
 =?utf-8?B?S2tmMWJJZHpqL1hoMGNCaTZ5ckE3TnRDaTRZcUlBL0Q0UEdOTEl1eE1oNmZF?=
 =?utf-8?B?VDJHTTNMb0t1SmtQTmtBUm1ESGVWazlKb2h2NWVPOWtORVcyR2FvV05aS0w3?=
 =?utf-8?B?OGdQVFVTeHh5bjRTQnpUZjBjODI3TW9OMC9UekswQzRUV2poVDNpa1R4dDZx?=
 =?utf-8?B?U29VWFFSbDloNjBrUDlqc2FDUHQ2Z3AycU5rUVRaZ0pjZklsRC84OFhRcDVq?=
 =?utf-8?B?bEtUcDFDRE0wR3ZDeXpXdU93SHdBa2ZMR2FhS1pXVEI5a3lJbEE1TkdnckZk?=
 =?utf-8?B?MWxvVitlbmNwNGU3WHhzejdIQXhZdWhTNEI2cVZsK21ML0hEa0tnVTVUeE9V?=
 =?utf-8?B?ZWtWVDljWXRLd2VnS2toRlgwUmdZTEhhTHRzZ1R0QXJwNENmOTh3TWVPZk0r?=
 =?utf-8?B?QUp5dytLc2dRUHNDem5JKzV3MGV2aWNDbFdSQlVBT25MTWlIck1meEpvVlBK?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348546d9-ff21-48b7-acb8-08dca18adea0
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 09:21:39.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hP2zTbA0kdU0pUCTPTcox8ZneaGAylpLJ4DV+1oFuRCrwGCWOB4ygODccWxXW4Hx6D61xiUhDZXAg75K9hG/9ftnRmpW1mGjIQElscMheA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7783

On 2024/6/5 20:51, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi Philipp,
> 
> On 22/04/2024 13:11, Kelvin Zhang via B4 Relay wrote:
>> Add a new compatible and device node for Amlogic T7 reset controller.
>> And modify the driver accordingly.
>>
>> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
>> ---
>> Changes in v2:
>> - Drop the compatible comment in dt-binding.
>> - Move t7-reset.h to arch/arm64/boot/dts/amlogic.
>> - Link to v1: 
>> https://lore.kernel.org/r/20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com
>>
>> ---
>> Zelong Dong (3):
>>        dt-bindings: reset: Add Amlogic T7 reset controller
>>        reset: reset-meson: Add support for Amlogic T7 SoC reset 
>> controller
>>        arm64: dts: amlogic: Add Amlogic T7 reset controller
>>
>>   .../bindings/reset/amlogic,meson-reset.yaml        |   1 +
>>   arch/arm64/boot/dts/amlogic/amlogic-t7-reset.h     | 197 
>> +++++++++++++++++++++
>>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        |   7 +
> 
> I applied the DT change, could you pick the bindings & driver change ?
> 
Hi Philipp,
Sorry to bother you.
For patch 1&2, is there anything that needs improvement?
Thanks very much!

> Thanks,
> Neil
> 
>>   drivers/reset/reset-meson.c                        |   6 +
>>   4 files changed, 211 insertions(+)
>> ---
>> base-commit: f529a6d274b3b8c75899e949649d231298f30a32
>> change-id: 20240329-t7-reset-f87e8346fadb
>>
>> Best regards,
> 

