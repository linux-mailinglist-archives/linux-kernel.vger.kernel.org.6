Return-Path: <linux-kernel+bounces-416967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5630A9D4D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9AD1F237CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D661D86CB;
	Thu, 21 Nov 2024 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FVBZFwDT"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011020.outbound.protection.outlook.com [52.101.129.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994511CEAB8;
	Thu, 21 Nov 2024 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192869; cv=fail; b=ULdnXFzne2jUO2UgmxJXL34+jC+wkXztJfduhAONWHi6jDu9VcnRSBsVrdln++sFm0FOA3TwW2mwg8BSUdxWUUltEZg9NNwaDSPWfT0ooWWWKtzufdHir4HzirpCvUBlIL8U+hHrankbyjmU4h7MUb3gmLQcIuG7DaysGTEA53w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192869; c=relaxed/simple;
	bh=Bl2Vo2YAhKqhmGMeTvmwWtNsUkk1cM32tCOXMlVPwVM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VoBLA5gx7aCrGFYzRofCG4IMDOzLkH+e+z4ujkC34p+88plBKaIfQM1QVVMo6eW+674OJi/LB+esR3SpOzm7MwW2R59udizRUSTHvAQtfXNCwwzvTnSLtgXVET1U1ZIFUDG+NDmn1llC2dmw9QSXldhyudA3HRPWU8bbzEGeJ2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FVBZFwDT; arc=fail smtp.client-ip=52.101.129.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vdluo+6VMCV4irXTAFQMtXWXK8J9SnRR0pAmrqRb1uEzXLkx4Kkug1ElYnbxVfJao1WNIOi5tJQVCluOIONG7ufDRm+/B9vY0hSk9BR3dJp+e/FOul6lV5TuMSm/Ebh6zie+PS6e4dj7KY78q/UlsAcH7Cq1s+jMvKFH4IH5azQjOCVlu55cJsIhVswDUL9yfQe3k6wGxapXCSwMqMnLD1doe98zYog1IErGW+cxs1c8NxdlNyPNKkMx2w3j5uUt8x0bNkxEW3bsVOYfukxn+wmnnGrUGFsjhQ2bJ5wcff3NFsOvO/Z+Q6oeH9QqvqTy5lguoqi7YoHHB+R80vTu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl2Vo2YAhKqhmGMeTvmwWtNsUkk1cM32tCOXMlVPwVM=;
 b=FjwCjEYVNtdJswYXtHzpbWygd79fZXH2roSC91LFnnNQwaP0JJlS+9yuAfKYZ9Rk/wgw0Qdwi+Nkfb+3Mtfu1Mrc2Q//gChmWxAvi4lYQveNrgo4SrB+BuCx7QmBT+7INXvMFLmkch9RGFFKbeZIY1X14bHG0sqe+6Ak/3ooSnlePyr7SYfmZx9DNHWsQRTh2mPMwchNMdBnNLNx4aJxdapdYDgteLVEqHh2lxB6rWq2eprHXQ+MVTXsQEDC5BAJ2MNlogwTE/QaiCHSZeJ6xuMUn/d4XtJ0KHmAFeqxYqCVCZ+Qh782LuMvTPEXbIGbbYmZkr6r4BbU8jZAw6UxMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl2Vo2YAhKqhmGMeTvmwWtNsUkk1cM32tCOXMlVPwVM=;
 b=FVBZFwDTUYHWAQmVStqsCbrRDPJ6tDAowFxtp0A6b/oVPF4nY1WMPo2eus/PLX+Kl8hH9U0Zjin33/66ADrjzwIc+dnFP6wNGEXHTXLYh+sYzlThha+w0E6up6uT9URzLcJ+anowJs8iAvCLy29qh1A8matimqQwWDHvP0bGN6325sDpJU1ol+BTgsDx3sIS6pgei6BtJScdaepIQHpvHQ+sayaUiKBVDw/irTUmMOWRq2vzA23IQjyZLUSob7iSBpQmdUyuRjRFmCbkpUA2Z0scvI54xTqRU4BOcpklNnp/fXC5qs+c+nC27bCHHLTTML0gly2wobztV0DZnndW4Q==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by JH0PR06MB6966.apcprd06.prod.outlook.com (2603:1096:990:68::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.11; Thu, 21 Nov
 2024 12:41:01 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%6]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 12:41:00 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>, "mwalle@kernel.org"
	<mwalle@kernel.org>, Prashanth K <quic_prashk@quicinc.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, =?utf-8?B?6IOh6L+e5Yuk?=
	<hulianqin@vivo.com>
Subject: [PATCH v2] usb: gadget: u_serial: Fix the issue that gs_start_io
 crashed due to accessing null pointer
Thread-Topic: [PATCH v2] usb: gadget: u_serial: Fix the issue that gs_start_io
 crashed due to accessing null pointer
Thread-Index: Ads8EVVJRUOwpsmOSCeQNLdPNS2SOg==
Date: Thu, 21 Nov 2024 12:41:00 +0000
Message-ID:
 <TYUPR06MB62178D00DC96CC2702114CF5D2222@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|JH0PR06MB6966:EE_
x-ms-office365-filtering-correlation-id: 171d027a-58d1-4db8-063d-08dd0a29c11b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Um90OXQ5eDJRdEltbStzdXVuU2RqRkNTR1NCa1FMSFlacUdjTE9COGd3MDlG?=
 =?utf-8?B?NTdIMFdOT2xGbXhUcGE1anczb2ZYKy9TZmhCOVJ1R0xTRkhndk5iTmhaTzB3?=
 =?utf-8?B?dUtIS1NWSEVZR2czVVFodjViYW8yM0d1SklQN0RsOFBNb3RpY211NURoa0JN?=
 =?utf-8?B?WWlOOG5HNmNqVWRPWXpZU29DM2xLSS8zbTczTHVpVG9sVEJOakwwdkdwS1dT?=
 =?utf-8?B?MlArMHRqelRheElYMnV0NzhVekhyaVVhMWdhSDZSOWJjRmo3ekx6NkE4Yy9p?=
 =?utf-8?B?eUlSdzhIRHJEdE5NSnpKTmZOU1U3QmRDY2RXVmZhUmY2N09WQWNVQS9NTWk1?=
 =?utf-8?B?YjRoczdZNmlHaGRWelFzcG01Y3VzSnJ6WjdUNDUyTDRnS1M5S1htVGV5bU8y?=
 =?utf-8?B?SWpoRm1pYkVvV1hlK1oyZ2VPQzk2a1ZZWExyb0lxQURIMjh1MVh1MXRreGZp?=
 =?utf-8?B?U1pWa3pqYXBLT3VGenl3cjQ0T1Y3MmhVVzEzVEZhcWRud2JGMlpHSmN3YUpF?=
 =?utf-8?B?bVVOM3h4M2tadkd5d2YwRWQyajNCS2dvWlhSNkh3K2lKMCtVNzdpMUkzTFh6?=
 =?utf-8?B?cWZRcjZxaGEwV1RaVFpZQ0IrZndNMFdpUS9UVlVNTHVnTGt6OTFlREtHODRF?=
 =?utf-8?B?OXRkODJUTXFZUllRK3J4S1c0Q0h4Z2czS0FIZWpIbGRLS0tPbU9PdG04Mkdk?=
 =?utf-8?B?a3RRSzVXU083RWZDQnJ5di9RYVptSHdhSnltQzMzZS84SW96b3B6VDVwRWxx?=
 =?utf-8?B?bENsNGJpdHNMcHdydTIvODdFdnZJZ0Z2V2ZEU1dVZll0bVovc3NDWEFYVnhu?=
 =?utf-8?B?K3hidzU3bld4ZFZsS1NHVUNYeStCbXROSE9meDRyWjc5bHNsMHZGOVRiazZy?=
 =?utf-8?B?Zkp5TnNhOXR2Ym9ub0NFcDJCV2hDT05LNDJqZU5pMmQ1WFJDSkt3NlMyY1Ro?=
 =?utf-8?B?NUtlSUZyV2l4cC9oUXZpTCtJeVFNT3dpQzR1WXQvTHBJUndtbXIvZzRXenpO?=
 =?utf-8?B?OGJseDhYQnkrRzJON2VIRlI2QWM4NGdGU2JkaFdIYzNPYUUzSXZwMXVhOXli?=
 =?utf-8?B?TlFhSVhKSXJTWWhwU05SNXQzYnR0dmVtSS9rNWtKUEQ1WWQrTlY2ZEJ0VU80?=
 =?utf-8?B?ODFNL01Cc1BtWmFMMlpaeXdoWGtuRENoUEJMd2Vsc2c2dnJDQWpZQmhqWC9K?=
 =?utf-8?B?b2k0U0JVQ2JzOTluNURab2M3SmxnMUQvZlI3QStpOHQvQzhqNzV2anBla0tK?=
 =?utf-8?B?a3d0QlRuVVdzcHdlRnpJeVZZTHlRcUtnWW9OOXVkRndHRnhrQ1pNZmU2RG45?=
 =?utf-8?B?K250UVl6YTR6S2FONzgxTW9mU0htY0Q0UmhjVlRBdU5PNktnM1l5bTNiZ3l4?=
 =?utf-8?B?MTdHU2E3Nyt3RFhzZ2xYb2pZU2R3c0h4bmk3V0VpMm5rTHlBOEZBbVp6eWw2?=
 =?utf-8?B?STZ6NGlXTUM3TFFpUE10TnAyWlVialRmTkhIZ0hyYWsrMDlnVDVXWms2aEx0?=
 =?utf-8?B?cTFMQWQzazltaGhaM2lya0JlWkc4SnhBb3czL0FBSWNSZnRGVng0UTl4M2kr?=
 =?utf-8?B?ZXAxUVdoRjUxMUl2Y1dBcTNLNzhkK2FkY0s4ZmVBQ2N2SHFTTnVsWU96eVJj?=
 =?utf-8?B?NkdWREFyNUV1ZloyQnBXTTE0R2M4ZUtwaXdHZjMvNWR3bTcyZjYvRllEb3cz?=
 =?utf-8?B?WU1TczZvUDd5OE15VUl0UUlNWTgzZVA1eERtTGh0ajhFcGJRcTloalFuRDVr?=
 =?utf-8?Q?Psm/2NpNaD6vkiGmT5eQzhh/5n0K5e4vjj7X9vO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWNDNGtXaUxmK1dWbSt2THVQTWNxSWlrQW13ZmI4OGNFNTdQQ0JwRndtRHh2?=
 =?utf-8?B?amNXQmUxdTZDM0tQeVhsaDdRL3VKdUN1anRqQTdPeEM1R1FtL2pTT1NTTHh3?=
 =?utf-8?B?cDF2b2Q2VFIxTnJGV3djZjdub1NBeXBIOElZeDRaYVJTeHNzOHJvUUh5V0Nr?=
 =?utf-8?B?aVVad085TVJNZEpNMzYreVdxQldmdTJySUdXQ0NsYUg5VlJzRkJMUUJWd2JI?=
 =?utf-8?B?WXBLVm9UMGRlVERIS2RaaDdXYU5MeDRUM0hXNnBlVDh1MVh0dEZSZ2w0eHQ4?=
 =?utf-8?B?NUlvRU8yMkVnZHBRcHhJNmxFcFNVSDRFY2lid1VtSUIwbjJxb3NoazFmV1FF?=
 =?utf-8?B?aDN3UERNS0lhRTZKRTZIQzZ0cXRKeWYvQTd5N2x6cXBqVUp3RVZiZ2lTcVIv?=
 =?utf-8?B?Wm9YWXhBUnVUM3kvaFhpT1BiZkJxUVNSbjlZTm9UTTBUREc3eUlZaGZkQmIz?=
 =?utf-8?B?VFUvRzcyaU05MUwwNFhOdWFwT0xaWkhocFVJMGNoSjJvRk1wSWNMb2pFRjNL?=
 =?utf-8?B?YVQxR0cwQ1MyNEpJVFowcTBBVUlYbmVNcU1BZytUUCtQNEZVZC9QbnZ6RDUy?=
 =?utf-8?B?T2xvQWtEQkxwS2lCMjJKQnhkbGswbmlzM0RPS25FOTlzbFV4NmFzYmVIejU4?=
 =?utf-8?B?aDMwZXhHQjVHZm5OOG9VY2JaMnIyZ3lmUzd4eUtpbklQNjBRVzRDWUN0N3ZM?=
 =?utf-8?B?U21FQ3pCRGE4cThSTkpFTlVRcFN4VnZVaHBNSnA0R3d0K1MyazJ6UGtQRHJC?=
 =?utf-8?B?MUIxSEptS1BvS3RKWEY0T1gyU3N0S2hFakVROFkwNVJGSjh1bWhsKzdtWGxU?=
 =?utf-8?B?MHMwR2RnVXdEVUp5QXpRMzVrMTE3cEptMC94MFlrZXV4T2NobGRoUGpNakgz?=
 =?utf-8?B?V21pUm96WjR6NG9ScnhmZzFNWS9KMEtMVnNpdE9ONko4MFlrYkJJM0NXK2U0?=
 =?utf-8?B?YWNNazRxYjRBVnFFdG5NZk1NQ2ZkdEZqOFN1VzZTdUE4S0VXOXE5SEFXZXRX?=
 =?utf-8?B?VVBuWjJsTVUwajlKUnY0a3B6U3FZWmFWT2VrS1E2bGtRcTlHUVhDMGpBV1FG?=
 =?utf-8?B?RzJlMkhTWXRrZFE3SVdhTm1yakpOR0dxVW5zVXMvSlR1ZkNQclB4QVdOL3h0?=
 =?utf-8?B?eDVpNE0rc0VYankwTVVNbWozRnJmMFh4NnRtWHAvSG5rSnV6Z0pwRytnMmlx?=
 =?utf-8?B?ZFpVR09OZGJGZXdkRjVOT3ZyNjhEL29lS2RCalg1eWltU3gxSUx5SkpXclpw?=
 =?utf-8?B?aCtWY0lCQzZCQnkxZXdORU9lc0dpMTFFWlozNHg1Y1d6bHhKNW9MaHBjMFYx?=
 =?utf-8?B?ZzFIWjJMVkREMmlwOUdMVHVOVGtCSWFRWVpOVmQrZ2lMRzhLN3ZXU0VMcXk5?=
 =?utf-8?B?TDUydnJSaW1qNnR6Nkdla2NXRTVzWGpNWnhRV1ptbHBmM1FxdWVQbVJuMWNk?=
 =?utf-8?B?dlByOWpJQzFyU3FtbWNxUnVpalRLODBMc21jTE0yeEZJSFpGVGRWNTFmeEov?=
 =?utf-8?B?QzUySHcrRGY3K1hsTnYwdlVCTDhLVlczZXIrWnFPUGF4aUF6SHM0Zlk3eXRt?=
 =?utf-8?B?czFITFZ5Wk41STBjZ3NpZ0lXN2pscUs1T2dLME1hRHV6YXRNMmxNNENlRGs3?=
 =?utf-8?B?R0J3eGxSOGdRb1QvY2RVekJBa0VyY3VzMG9zSVhRK0I1aEJqaHhoc2FUY24r?=
 =?utf-8?B?UzEzanhKbUxNUjIwajdjaWw5VENWQnZqL1RFaW5IWXQ5d0k0djdhZXBhZnMv?=
 =?utf-8?B?RTZyLy9HUlRHVUZETFNGT2kyTTB0SFhjNFlBalI1cWE3MGFkREk3cWQ0Wk5h?=
 =?utf-8?B?alFzVWJ1emRCRnhpTjcydUVObEdFblpKWW5KRXcrNmF2eGVLS2g0VWU5NmZj?=
 =?utf-8?B?MXpJSC9Ick0ybVBlNzE4ek51aStTQjVtUk9oNGVmQ1RRbWhHaG5mRHFncWps?=
 =?utf-8?B?QkkrYlY4TmpsSHlGUzBuWEw2Qkt5U1A2V3gxSmszMnZQdXNEMnAxMHJJYTZl?=
 =?utf-8?B?RmVGQ1FWYWZpYVFyVFdTdk5TRnJTa2E2V2NYanFGdDliT3c5TGdOd01nY1dh?=
 =?utf-8?B?eFlLbUNvVlZyRUczdjdaNDZkRE93OTFpVlZPdFM4Y1diUDhIVEo1aWJQK0lE?=
 =?utf-8?Q?Sr4o=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 171d027a-58d1-4db8-063d-08dd0a29c11b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 12:41:00.5832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: euz/8mVhmgAUPsb/ihy1+PTr+JNdCzcrq1X1DqYWBpiB41jFYJsonaNbpHrr2QkW44dzLDleKQtI0ANhVlHjRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6966

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpDb25zaWRlcmluZyB0aGF0
IGluIHNvbWUgZXh0cmVtZSBjYXNlcywNCndoZW4gdV9zZXJpYWwgZHJpdmVyIGlzIGFjY2Vzc2Vk
IGJ5IG11bHRpcGxlIHRocmVhZHMsDQpUaHJlYWQgQSBpcyBleGVjdXRpbmcgdGhlIG9wZW4gb3Bl
cmF0aW9uIGFuZCBjYWxsaW5nIHRoZSBnc19vcGVuLA0KVGhyZWFkIEIgaXMgZXhlY3V0aW5nIHRo
ZSBkaXNjb25uZWN0IG9wZXJhdGlvbiBhbmQgY2FsbGluZyB0aGUNCmdzZXJpYWxfZGlzY29ubmVj
dCBmdW5jdGlvbixUaGUgcG9ydC0+cG9ydF91c2IgcG9pbnRlciB3aWxsIGJlIHNldCB0byBOVUxM
Lg0KDQpFLmcuDQogICAgVGhyZWFkIEEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBU
aHJlYWQgQg0KDQogICAgZ3Nfb3BlbigpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBn
YWRnZXRfdW5iaW5kX2RyaXZlcigpDQoNCiAgICBnc19zdGFydF9pbygpICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbXBvc2l0ZV9kaXNjb25uZWN0KCkNCg0KICAgIGdzX3N0YXJ0X3J4KCkg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ3NlcmlhbF9kaXNjb25uZWN0KCkNCiAgICAuLi4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLg0KICAgIHNwaW5fdW5sb2Nr
KCZwb3J0LT5wb3J0X2xvY2spDQogICAgc3RhdHVzID0gdXNiX2VwX3F1ZXVlKCkgICAgICAgICAg
ICAgICAgICBzcGluX2xvY2soJnBvcnQtPnBvcnRfbG9jaykNCiAgICBzcGluX2xvY2soJnBvcnQt
PnBvcnRfbG9jaykgICAgICAgICAgICAgIHBvcnQtPnBvcnRfdXNiID0gTlVMTA0KICAgIGdzX2Zy
ZWVfcmVxdWVzdHMocG9ydC0+cG9ydF91c2ItPmluKSAgICAgc3Bpbl91bmxvY2soJnBvcnQtPnBv
cnRfbG9jaykNCiAgICBDcmFzaA0KDQpUaGlzIGNhdXNlcyB0aHJlYWQgQSB0byBhY2Nlc3MgYSBu
dWxsIHBvaW50ZXIgKHBvcnQtPnBvcnRfdXNiIGlzIG51bGwpDQp3aGVuIGNhbGxpbmcgdGhlIGdz
X2ZyZWVfcmVxdWVzdHMgZnVuY3Rpb24sIGNhdXNpbmcgYSBjcmFzaC4NCg0KVG8gYXZvaWQgdGhp
cywgYWRkIGEgbnVsbCBwb2ludGVyIGNoZWNrIHRvIGdzX3N0YXJ0X2lvIGJlZm9yZSBhdHRlbXB0
aW5nDQp0byBhY2Nlc3MgdGhlIHZhbHVlIG9mIHRoZSBwb2ludGVyIHBvcnQtPnBvcnRfdXNiLg0K
DQpVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQNCnZp
cnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMGU4DQpwYyA6IGdzX3N0YXJ0X2lvKzB4MTY0LzB4
MjVjDQpsciA6IGdzX3N0YXJ0X2lvKzB4MjM4LzB4MjVjDQpzcCA6IGZmZmZmZmMwOGI3NWJhMDAN
CngyOTogZmZmZmZmYzA4Yjc1YmEwMCB4Mjg6IGZmZmZmZmVkOGJhMDEwMDAgeDI3OiAwMDAwMDAw
MDAwMDIwOTAyDQp4MjY6IGRlYWQwMDAwMDAwMDAxMDAgeDI1OiBmZmZmZmY4OTlmNDNhNDAwIHgy
NDogZmZmZmZmODg2MjMyNTQwMA0KeDIzOiBmZmZmZmY4ODYyMzI1NmE0IHgyMjogZmZmZmZmODg2
MjMyNTY5MCB4MjE6IGZmZmZmZjg4NjIzMjU1ZWMNCngyMDogZmZmZmZmODg2MjMyNTVkOCB4MTk6
IGZmZmZmZjg4NWUxOWQ3MDAgeDE4OiBmZmZmZmZlZDhjNDVhZTQwDQp4MTc6IDAwMDAwMDAwZDQ4
ZDMwYWQgeDE2OiAwMDAwMDAwMGQ0OGQzMGFkIHgxNTogMDAxMDAwMDAwMDAwMDAwMQ0KeDE0OiBm
ZmZmZmZlZDhjNTBmY2MwIHgxMzogMDAwMDAwMDA0MDAwMDAwMCB4MTI6IDAwMDAwMDAwMDAwMDAw
MDENCngxMTogMDAwMDAwMDA4MDIwMDAxMiB4MTA6IDAwMDAwMDAwODAyMDAwMTIgeDkgOiBmZmZm
ZmY4ODYyMzI1NWQ4DQp4OCA6IDAwMDAwMDAwMDAwMDAwMDAgeDcgOiAwMDAwMDAwMDAwMDAwMDAw
IHg2IDogMDAwMDAwMDAwMDAwMDAzZg0KeDUgOiBmZmZmZmZlZDhhZTBiOWE0IHg0IDogZmZmZmZm
ZmUyNjdkMGVhMCB4MyA6IDAwMDAwMDAwODAyMDAwMTINCngyIDogZmZmZmZmODk5ZjQzYTQwMCB4
MSA6IDAwMDAwMDAwODAyMDAwMTMgeDAgOiBmZmZmZmY4OTlmNDNiMTAwDQpDYWxsIHRyYWNlOg0K
IGdzX3N0YXJ0X2lvKzB4MTY0LzB4MjVjDQogZ3Nfb3BlbisweDEwOC8weDEzYw0KIHR0eV9vcGVu
KzB4MzE0LzB4NjM4DQogY2hyZGV2X29wZW4rMHgxYjgvMHgyNTgNCiBkb19kZW50cnlfb3Blbisw
eDJjNC8weDcwMA0KIHZmc19vcGVuKzB4MmMvMHgzYw0KIHBhdGhfb3BlbmF0KzB4YTY0LzB4YzYw
DQogZG9fZmlscF9vcGVuKzB4YjgvMHgxNjQNCiBkb19zeXNfb3BlbmF0MisweDg0LzB4ZjANCiBf
X2FybTY0X3N5c19vcGVuYXQrMHg3MC8weDljDQogaW52b2tlX3N5c2NhbGwrMHg1OC8weDExNA0K
IGVsMF9zdmNfY29tbW9uKzB4ODAvMHhlMA0KIGRvX2VsMF9zdmMrMHgxYy8weDI4DQogZWwwX3N2
YysweDM4LzB4NjgNCiBlbDB0XzY0X3N5bmNfaGFuZGxlcisweDY4LzB4YmMNCiBlbDB0XzY0X3N5
bmMrMHgxYTgvMHgxYWMNCkNvZGU6IGYyZmJkNWJhIGViMTQwMTNmIDU0MDAwNGExIGY5NDBlNzA4
IChmOTQwNzUxMykNCi0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KDQpTdWdn
ZXN0ZWQtYnk6IFByYXNoYW50aCBLIDxxdWljX3ByYXNoa0BxdWljaW5jLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IExpYW5xaW4gSHUgPGh1bGlhbnFpbkB2aXZvLmNvbT4NCg0KdjI6DQogLSBNb2RpZnkg
cGF0Y2ggY29udGVudCBhbmQgZGVzY3JpcHRpb24gYWNjb3JkaW5nIHRvICJ2MSBzdWdnZXN0aW9u
Ig0KIC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1RZVVBSMDZNQjYy
MTczN0QxNkY2OEI1QUJENkNGNTc3MkQyMjcyQFRZVVBSMDZNQjYyMTcuYXBjcHJkMDYucHJvZC5v
dXRsb29rLmNvbS8NCg0KIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jIHwg
OSArKysrKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFs
LmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KaW5kZXggMGE4YzA1
YjI3NDZiLi41M2Q5ZmM0MWFjYzUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVu
Y3Rpb24vdV9zZXJpYWwuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2Vy
aWFsLmMNCkBAIC01NzksOSArNTc5LDEyIEBAIHN0YXRpYyBpbnQgZ3Nfc3RhcnRfaW8oc3RydWN0
IGdzX3BvcnQgKnBvcnQpDQogCQkgKiB3ZSBkaWRuJ3QgaW4gZ3Nfc3RhcnRfdHgoKSAqLw0KIAkJ
dHR5X3dha2V1cChwb3J0LT5wb3J0LnR0eSk7DQogCX0gZWxzZSB7DQotCQlnc19mcmVlX3JlcXVl
c3RzKGVwLCBoZWFkLCAmcG9ydC0+cmVhZF9hbGxvY2F0ZWQpOw0KLQkJZ3NfZnJlZV9yZXF1ZXN0
cyhwb3J0LT5wb3J0X3VzYi0+aW4sICZwb3J0LT53cml0ZV9wb29sLA0KLQkJCSZwb3J0LT53cml0
ZV9hbGxvY2F0ZWQpOw0KKwkJLyogRnJlZSByZXFzIG9ubHkgaWYgd2UgYXJlIHN0aWxsIGNvbm5l
Y3RlZCAqLw0KKwkJaWYgKHBvcnQtPnBvcnRfdXNiKSB7DQorCQkJZ3NfZnJlZV9yZXF1ZXN0cyhl
cCwgaGVhZCwgJnBvcnQtPnJlYWRfYWxsb2NhdGVkKTsNCisJCQlnc19mcmVlX3JlcXVlc3RzKHBv
cnQtPnBvcnRfdXNiLT5pbiwgJnBvcnQtPndyaXRlX3Bvb2wsDQorCQkJCSZwb3J0LT53cml0ZV9h
bGxvY2F0ZWQpOw0KKwkJfQ0KIAkJc3RhdHVzID0gLUVJTzsNCiAJfQ0KIA0KLS0gDQoyLjM5LjAN
Cg0K

