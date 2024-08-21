Return-Path: <linux-kernel+bounces-295652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0D8959FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7A31C21623
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2981B1D59;
	Wed, 21 Aug 2024 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RAmmAkV/"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2076.outbound.protection.outlook.com [40.107.255.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94848196D90;
	Wed, 21 Aug 2024 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250146; cv=fail; b=Fr+K+VQEqM2UPCb2e7Y+db07SINJcx/WjnEkGtBafQmv5N554wHkZ9q7p+JL6enZ9nT6I0+UszWqzULRspMRF24SqVFKlfsChkg3cbPJsP6wXH4MZvKwM3Q5SJWdaKxFHUoBzsIqGriNSsUr76unPtEH/eSDuGZsjkRTjKoUdOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250146; c=relaxed/simple;
	bh=BP7nsvfHjwJSI4HafQ6N6NHlL5aZdVCiWPHIHNOJepo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=buu6205jvb3r6fTE4Wkt8DQFvqk3PgWbJBS3qeqEUjOaljE/b8LDYH6mLQogIddLembiaxS1lhD7bBuPHdG602MmI6mFaBo1Tis0XYLPsndf4OhNEmMWT2vAF1caUpDr/G/Mw0msJsFJua0c3s8ft8+WVneH8tF0Gggnu7n6Pps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RAmmAkV/; arc=fail smtp.client-ip=40.107.255.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBWjoEPwgpLeP1zdi2TvfBGaN8MB2S2256lKiMaXHmR+iEjpEaYKdtFe27TwA7ot3SeyBC7CwEiAEk/kw1PRqFggMhrAXLqkFiog5xd1ifEdbBQB+QuUE4xEKxrPYYcmAfAXGNilljO+jvC7EoA4HebAHjN4ziV5+6YovWV9NIdBtxnT/dSjlZn1IwzUm2wdQr4e9vHcwxsho77wZY9Jl8N4jXGD/MQjfn2CEAxQ628QoxhVh+KtywR+ktVRfKma0ubf0Dc1tX3rUwP4htX6VdX2phdOJYOiR/ib511oPECp1N9TejdoxG5m/47WTrp2pNL/TQ+dLlIgYvd1kylqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP7nsvfHjwJSI4HafQ6N6NHlL5aZdVCiWPHIHNOJepo=;
 b=m7iso5E+YA5EjaINrPiy1kX0HBm8Sb6h2Z2+tHqPghrIWxFjWqGraiG6rTDu8UiO6zvujqwChVLbKz/uQfQOXeoMZa8eQ/nFa1rG67VEdeJJspzyLsbEGEF4sCrfN10bDcvBetNthzOz8+/hzMSS9ZmDUfC79s3OHK7faEtlr4oDytA6PXg2b5oAMGXMNL2e4KQFlGCFMTrPWROR0BI0TiVA2QOpGUgJwV3+rNAum2kxlxVH0GjgAzNhyEH+B4hFNauXAr+aipOf5RWZcs+Ep+uMeMXpQvs4e8UtSztcqK939+TC5E0k9NW1VYclhr0GiHyb7pD81GXGU+EqIRz0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP7nsvfHjwJSI4HafQ6N6NHlL5aZdVCiWPHIHNOJepo=;
 b=RAmmAkV/iLoEUU9ajAhf8z3DsndEwZzlj4iMw96N55MFJ0e52tS4Ii/me+yFul0cGaeLaDliehkMHQG1XEdjUPy6yTCy6Y1t+Ae0tbjPZIKGZuEGBjh+kihEjFJTX75bKnbjZgXRSFduB9AewizWcM3ch3bfvS5R3rlfxi1+qyULYqFzuzyOq71+z6D6Pt7YLudY5CEholg4iGnKu4bxpguphSmGXlwzVhxMkYjGzR7UI1xmGB0iUr/DdSnlBbCXdFSS42IlbI7LlvEohOvQIKUsv/Tze43+hqXKVW3bvdoIrwXtDfYvZgbyveuM5BUv3ZlZU1OhBADbtDmmmSQJ9g==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by PUZPR06MB5698.apcprd06.prod.outlook.com (2603:1096:301:f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 14:22:19 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:22:19 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: Prashanth K <quic_prashk@quicinc.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>
Subject:
 =?gb2312?B?tPC4tDogW1BBVENIIHYzXSB1c2I6IGdhZGdldDogdV9zZXJpYWw6IGNoZWNr?=
 =?gb2312?Q?_Null_pointer_in_EP_callback?=
Thread-Topic: [PATCH v3] usb: gadget: u_serial: check Null pointer in EP
 callback
Thread-Index: AdrzDKh8N5M3/u4TSCCS0RPgLRR/KQAsTAqAAAXB1MA=
Date: Wed, 21 Aug 2024 14:22:19 +0000
Message-ID:
 <TYUPR06MB6217285F6A16850FA4E25861D28E2@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB62175A4C6BC97FBAAC9DA72CD28D2@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <971ae3e9-a991-7649-dfa1-a7156e7200d4@quicinc.com>
In-Reply-To: <971ae3e9-a991-7649-dfa1-a7156e7200d4@quicinc.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|PUZPR06MB5698:EE_
x-ms-office365-filtering-correlation-id: 8bb9f8d1-82e8-4126-5047-08dcc1ecaa6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?cnNJZU1kSnJ3NkhQWGN2M0drZzRPQ2tLa2VlZmlKUE1nd3ROeG8rZXlGMTZM?=
 =?gb2312?B?VmVHN2c5NHU1dkNGQjhIdWZGYWhDTzZFSkNXVzJxWWdEY3QveEltR0x3UWNB?=
 =?gb2312?B?dk04RjdxbTN4MjVkRXdMM3l4RDBoQ1g0SU1mN3NjY3pPeTJlaXNneVIwOW5n?=
 =?gb2312?B?SjJJQ3NUdVF4anhVOTlrSzU3VFh0QWJvb0Fxa1dYRm4wOWsyK2tnQlhhZjdm?=
 =?gb2312?B?b2EyVTBLZDRsbmVqNitreThiWFBMOUZ0WXNvNG0rTVExdUJvRWlBbjBXeG9o?=
 =?gb2312?B?Q2ZIaDFpbTkrZmtFNFJZeFgwd0k0Q3pCRjhjcW9iNnJhcHFvVXRrdEZLWUl3?=
 =?gb2312?B?bEp3OEF6dHcwY3p4dk5FZStUSk9DMFI0VTNLNlVqQm1mQUJpYnZTdXFVZFR1?=
 =?gb2312?B?QXZoQU9RK3JhREdwYmMyZEpHa2J5QzczSTdLQ29SVmhKOVNBTCtHTWptbEl5?=
 =?gb2312?B?ZGxYdHVmMDdTMzkvNlY2b2hNcTFwdUM5eDREVVk1eHlpRlhpSElpM012TW1h?=
 =?gb2312?B?bUJnV0NwcTlnK3BEd0xJamdjL09nOERwbHA5azVuZE9XM0F2dGxhZ2w1M21J?=
 =?gb2312?B?UDM4Slh5dXRqTDhpdGUxQThRbmpvNDFkSXRYN0dqUmJUTmE4RHJUTm9NNzU5?=
 =?gb2312?B?YjdReEdxNHM1OHo3RmM2bXRVaC93djJJK3ZEWGYyTjFZQlY2ZHEyeWFGSnBM?=
 =?gb2312?B?RUNFUU94STZkUkVRM1pEbEovalVKaG9YaGlqeXc3L3IrTmJWYmZDUnVJMlBS?=
 =?gb2312?B?c3RUUVJxWXVPT3ZaZkV5WTFobzdZcmlzNlVsanhUMWtFSFJuQ0FmU0FjVGw0?=
 =?gb2312?B?Q0dPL293MWszRVB4K01qeDhna2dsSGdGV2FmbnpCV3ppZFk3elBaUVY0V2hX?=
 =?gb2312?B?QTg5V1VtNGVNbjRsNFNXYUQ3SkFvS0V0SGhqLzFkeDVKd0NyYmMwNlgvWStv?=
 =?gb2312?B?Y3NXS2laSlNSOVB0V0NQa2tvNjlTU2kzcEh6M1Z4ZzdzVXFRYVNUaWlML3BI?=
 =?gb2312?B?VjlSelVlRnlsSkZGKy9Gdm5UU1hqbGFJaHBSTWV4Z2dUWkdDak1SQm0vcEE4?=
 =?gb2312?B?RUZrd3U3clF2S08yd2IzbEhSNkN1WlZLSUw1U2tKSjhmeHJMUG81aDAyZkRV?=
 =?gb2312?B?ZWF2c0dSMHhIeXU2M2IxdGw4aEpOOHh1OEN3U3RKVXBuemI4MCtQOXIxUWdw?=
 =?gb2312?B?THlZZ0VQZ3ZYUkI4MlpnQ3VZWDhlRDcrNWRlK3ppaWYyd3hGV1BHc0F0YlNw?=
 =?gb2312?B?dVBGSWtEaTNOMWNwUkR0eENuaWp1WmpQb3FTN3VPWEVXMjI1ZUE0TmJEWkw2?=
 =?gb2312?B?UWgwWXMrUEREQ1RBTWlncTJOcWNLaTFweEgxeWlzbGhtaWtXd1hjaDcwcFlM?=
 =?gb2312?B?ZldxS2t4SVVUSHoraEZ1aU9XZjNXZ0NnRjJ0SHR5QkF4YzFPcldmT0x0OUtK?=
 =?gb2312?B?NUVhT045K3JHbGc5eHc2QW9qUWp4R3NGQzN1Y1pESjJveEY4T3dIU3pDU01m?=
 =?gb2312?B?dEpqU1NzZkpFeUdOcFZhYmU2bEsvVHlrSHpQMVhkWUlOZHJXRlg0bU5KMmJS?=
 =?gb2312?B?dlNNWTgyZ2ZUYnkyMlZGd21qRnlYazJuRVpQMENyYjd3czhDVXMvVksvSnFI?=
 =?gb2312?B?VVlMTWxSN0hHbW9CM2doVi9yZTl5bGZVNGtWUVFsQUkwcW9XNFlEak9Wb0lL?=
 =?gb2312?B?RUhyalBkNHc4MnY3K05GcmhkbkNiVm1QWXdDZ2JQMlM1RkhXN0k0OWwrQVhO?=
 =?gb2312?B?Nkg3WHcrQURLaUJlWC9PSDgrMWNEVEl3MUVPUlZzYjl3UTdFRHZYZW1ZNnEw?=
 =?gb2312?B?b09JZkpBbFZzQjdaOWQxOU1yYllaTUxkdGVmMWVxV0ZvcUM3b3FScWpMRktm?=
 =?gb2312?B?ZWgvN29pREc5dGo2UlNzN2MxNGZQYzZ5QWpwbVR5STJUemc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Vm1LZDNaajIvNEYyQktPZkxPQUczKzRkWkM0b2d3bndJV21kYVRFK0VhZWxt?=
 =?gb2312?B?S0ZoZUdTZlZCeUNoWDRMYmxBaDZZVTIvRkY4a3QrRmFHQWsyaW12UURSY0FH?=
 =?gb2312?B?WjNZdlJsNlBvcXE5ZWNTQ0gwbG9jNmZmMmlhUWl6OWZJVVNoTkhuWXFqQitM?=
 =?gb2312?B?OTM1ZTlHVzgwSUh2RGRxM0owNnhQZERVaUF4R05oTkM3SXdMNGpaU1k1aFFV?=
 =?gb2312?B?MFg1Rk1HOVFWZkdMUk44dVFJeHNpUFZBMFNydXcrdy9pWEtKU1JZKzJpZjdR?=
 =?gb2312?B?eGRzMnMxVE4wM041ZXZiVTlwcFpUQS9ONGZ3V0p3cHBmb1lGbTVTRVVHV1dD?=
 =?gb2312?B?bUY1eHUrcjY0T1ZVSnRzaW5xN1VtMlFZNGZ3OWE0cHkzVGIyQWpSTE13VTQ4?=
 =?gb2312?B?T0ZOaUlYRmNZRU9mSHdMaHJHUTIvZVBNNy92MURUek1XRmVCY3BNNHdUeWhR?=
 =?gb2312?B?NUFsRWZiMjFQc2MyYmx6bXc1OHhGNnRQSkJLZ1pIZjUzUDZ3TGVpTUhKd3Uw?=
 =?gb2312?B?bVV1QXVvcFR4ODQ2aEp1aGdiQnU3YzRSdVRnc0dGWlpGc3pDVVpmb1FCMFBw?=
 =?gb2312?B?Vys5TDNINFJBNUYxcm4rRFlGWXJsSnRyWFZERlZtcmNtWThlTWNtby95N1Nv?=
 =?gb2312?B?VTl4WFBRN1NzTk9pb2tRNmViMWdiK2tqSXM5T2MyRGxPdHU0cytKYWNUbFR4?=
 =?gb2312?B?L2dHMWlSdDlCazlQZ1ZwT09VWGJ4RHRtT0dNN0l1Z0NzYnBKbnBVUlg0MFJE?=
 =?gb2312?B?UmtrNjQ5YngxK0dZSyszRFZ2VnlIcGhoR2dyYU5hNmxOejA5a3dBQitKTGZP?=
 =?gb2312?B?dnRCSExmTk9SWElwYXNFSmdYanVDMGpFL0RTdWwrd0Q4QnFoZ3NEWHFSc0Z4?=
 =?gb2312?B?NndEalFmblN3WlI4NDVZZ2lZUlo5N2xTaHJHY2txQmsyZHE0RFlxVHFwcFFj?=
 =?gb2312?B?OGJhU1lodzd4M2FsNzkwVUx5ZVdxeTBUWXpLZkdZbnVwbXVkUHBUT2Q5WTZ0?=
 =?gb2312?B?VGx4ZEhOWXJCSE5SSFRqbzJQZ0RjK3BZUU5KMlNORldJUTAzditiLy8xbVFl?=
 =?gb2312?B?K05xRmxnQ1d1eW81T0RIVnk3ZWk1M05ZT2toZW9RMHVnWWlUdjRjOENsSnBm?=
 =?gb2312?B?Y1hBKzlPOWdWWklQNHFYZ3E0azRkWVpraFg0TFhPMUFQTDY5L2Y2NkpwUkRM?=
 =?gb2312?B?QklGZnk5QUdUVkZpdGh1cWdqVlptbWJobVdzcENiVEpFLzVqLy9sQ3pLaTVp?=
 =?gb2312?B?OXNpOTJ0OStXcXNmbXltVmNGam9Pc0ozTGs4cEdKRlF6Q0oxRkswQnd2Q3I5?=
 =?gb2312?B?eUpFNmc4Ni9hWWcxSTZZWE56WmdwdXNYYjdJRWhUOTdQcW1yWHNVTllId1Vv?=
 =?gb2312?B?c01xVjU4TzFBTjFPS0hGWTBBdXlOdlBOL2NiR3M5dTBDUHVGTU8vZnVJRnpy?=
 =?gb2312?B?NVVubE1TS1EyTHEyOGMyUFRzUEtVZk5xS05IbndpYW91aHBlM0prK2pocEpG?=
 =?gb2312?B?UVozRVRDWTJSSDY0V2k3bDBsdEp5U00zOE92d1R4Ym02R2JucFcrTWxrS01v?=
 =?gb2312?B?bzZldm9DMzFITi9PZVdTZzExeFExUE1KKzdWQVkrcWIxdFBjWFdadlVnd1M0?=
 =?gb2312?B?MUp1LzFOUDBLd25Kc3pNemJkT01HNmFTTmQ3SUJ0RTllUGgzS2ZmckZKaEda?=
 =?gb2312?B?eWJyQW5zai80U3M5dGhRb0RNOThHeXBoTGwxSysyQzJXRXphOXFMR0JEM0ZG?=
 =?gb2312?B?anREeExkamdQczlZaEowL3ZZZTdZSGxWa2dGcjZVejhjZHRVSzZuRUJwa3Fu?=
 =?gb2312?B?QTNnd3N6NHV0cE1IeVJtRHV0Y1NCQWdKNkNxZDhxOHo5UDJNYXhybGFqSURT?=
 =?gb2312?B?amlOdE1KWE1mNUJXNVVFTE52VmM5aWtHUVgxS2Z5WEZ2Y0Q4TUE0cno5T0FL?=
 =?gb2312?B?NCt1TzNSTkRsdlRoang3c0FUNkJRSmlxRWEzNVZGUmFwWmh5MXlkKzVsSldM?=
 =?gb2312?B?ZmkxMmlpK3A2OS9pYTl0RUVEdDlPY1d6MTE1M25VQWxhUjcwUGlONWhGQ3FQ?=
 =?gb2312?B?K3hxNGZKVkFnOXpFbkoyVTMraHlEVEZ3MlhOU1J2VXVnbVluQTNyZUxlQ1dr?=
 =?gb2312?Q?z3uc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb9f8d1-82e8-4126-5047-08dcc1ecaa6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 14:22:19.4913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KVaCMzUR2WKKwT+9xu51oFMwL5+2otORyekXrTV2dVEqGHtP7iml6fHH3KHX4jrX0h4fRDPUTux+/3kQODZTig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5698

SGkgUHJhc2hhbnRoOg0KDQo+PiBBZGRlZCBudWxsIHBvaW50ZXIgY2hlY2sgdG8gYXZvaWQgc3lz
dGVtIGNyYXNoLg0KPj4gU3RpbGwgZGlkbid0IHVwZGF0ZSB0aGUgY29tbWl0IHRleHQgd2l0aCBy
ZWFzb24gZm9yIG51bGwgcG9pbnRlciBjcmFzaC4NCj5QbGVhc2UgbWVudGlvbiBhYm91dCB0aGUg
cmFjZSBiZXR3ZWVuIGdzZXJfZGlzY29ubmVjdCBhbmQgcmVhZC93cml0ZSBjb21wbGV0ZSBjYWxs
YmFja3MsIGFuZCBob3cgdGhlIHBvcnQgY2FuIGJlY29tZSBOdWxsLg0KDQo+PiB1c2JfZ2FkZ2V0
X3Byb2JlX2RyaXZlcisweGE4LzB4MWRjDQo+PiBnYWRnZXRfZGV2X2Rlc2NfVURDX3N0b3JlKzB4
MTNjLzB4MTg4DQo+PiBjb25maWdmc193cml0ZV9pdGVyKzB4MTYwLzB4MWY0DQo+PiB2ZnNfd3Jp
dGUrMHgyZDAvMHg0MGMNCj4+IGtzeXNfd3JpdGUrMHg3Yy8weGYwDQo+PiBfX2FybTY0X3N5c193
cml0ZSsweDIwLzB4MzANCj4+IGludm9rZV9zeXNjYWxsKzB4NjAvMHgxNTANCj4+IGVsMF9zdmNf
Y29tbW9uKzB4OGMvMHhmOA0KPj4gZG9fZWwwX3N2YysweDI4LzB4YTANCj4+IGVsMF9zdmMrMHgy
NC8weDg0DQo+PiBlbDB0XzY0X3N5bmNfaGFuZGxlcisweDg4LzB4ZWMNCj4+IGVsMHRfNjRfc3lu
YysweDFiNC8weDFiOA0KPj4gQ29kZTogYWExZjAzZTEgYWExMzAzZTAgNTI4MDAwMjIgMmEwMTAz
ZTggKDg4ZTg3ZTYyKSAtLS1bIGVuZCB0cmFjZSANCj4+IDkzODg0NzMyN2E3MzkxNzIgXS0tLSBL
ZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogT29wczogRmF0YWwgDQo+PiBleGNlcHRpb24NCg0K
DQo+WW91IGNhbiBhbHNvIGFkZCB0aGUgRml4ZXMgdGFnIGFuZCBDQyBzdGFibGUga2VybmVsLCBz
byB0aGF0IGl0IGNhbiBiZSBiYWNrcG9ydGVkIHRvIG9sZGVyIGtlcm5lbHMgKHN1Y2ggYXMgNS4x
NSkgYWxzby4NCg0KDQp1c2I6IGdhZGdldDogdV9zZXJpYWw6IEFkZCBudWxsIHBvaW50ZXIgY2hl
Y2sgaW4gZ3NfcmVhZF9jb21wbGV0ZSAmIGdzX3dyaXRlX2NvbXBsZXRlDQoNCkNvbnNpZGVyaW5n
IHRoYXQgaW4gc29tZSBleHRyZW1lIGNhc2VzLCB3aGVuIHRoZSB1bmJpbmQgb3BlcmF0aW9uDQpp
cyBiZWluZyBleGVjdXRlZCwgZ3NlcmlhbF9kaXNjb25uZWN0IGhhcyBhbHJlYWR5IGNsZWFyZWQg
Z3Nlci0+aW9wb3J0LA0KYW5kIHRoZSBjb250cm9sbGVyIGhhcyBub3Qgc3RvcHBlZCAmIHB1bGx1
cCAwLCBzeXMudXNiLmNvbmZpZyBpcyByZXNldA0KYW5kIHRoZSBiaW5kIG9wZXJhdGlvbiB3aWxs
IGJlIHJlLWV4ZWN1dGVkLCBjYWxsaW5nIGdzX3JlYWRfY29tcGxldGUsDQp3aGljaCB3aWxsIHJl
c3VsdCBpbiBhY2Nlc3NpbmcgZ3Nlci0+aXBvcnQsIHJlc3VsdGluZyBpbiBhIG51bGwgcG9pbnRl
cg0KZGVyZWZlcmVuY2UuIEFkZCBhIG51bGwgcG9pbnRlciBjaGVjayB0byBwcmV2ZW50IHRoaXMg
c2l0dWF0aW9uLg0KDQpBZGRlZCBhIHN0YXRpYyBzcGlubG9jayB0byBwcmV2ZW50IGdzZXItPmlv
cG9ydCBmcm9tIGJlY29taW5nDQpudWxsIGFmdGVyIHRoZSBuZXdseSBhZGRlZCBjaGVjay4NCg0K
Rml4ZXM6IGMxZGNhNTYgKCJ1c2IgZ2FkZ2V0OiBzcGxpdCBvdXQgc2VyaWFsIGNvcmUiKQ0KQ2M6
IHN0YWJsZSA8c3RhYmxlQGtlcm5lbC5vcmc+DQoNClNlZSBpZiB0aGlzIGRlc2NyaXB0aW9uIGlz
IGZlYXNpYmxlPw0KDQpUaGFua3MNCg==

