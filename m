Return-Path: <linux-kernel+bounces-252909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E80FB9319C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71F88B22B67
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4905550284;
	Mon, 15 Jul 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="S0xBnOYH"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021080.outbound.protection.outlook.com [52.101.70.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB7F22318;
	Mon, 15 Jul 2024 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721065660; cv=fail; b=ZjbDd2EUKyGlY4H/E8nHUjle4DrxcalfMtsH23UqogJ3dh1B9TbuivXBseGzWZ13BP+LkbMLAihngJuee54RG/lV9iEN++Iipt6DvOGZKkHPFwlU0BSiTUqHYtniY2ADeyKf0zVvsU3rY2uB8dxAhV/Z+JQv7l3s/MFjMd28bLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721065660; c=relaxed/simple;
	bh=mzmg0Q2JZfQUMAgaLrVRFPHZcA4tE2dOG0Obbg9JJss=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=eE7rQJSD90jmJ0KLv31My6jTSrczLz7iDYGUsQhLc2Rh/245KVWcLdyNRSs9psgHAmWctApS4XrFyqksIQO6PWaO4+pGik35qus46WEW62NfpEGCIhVHijD36CuCFVZl8SNHPpfo3eEgybfckEXmTW6zrejawrS3t0HaMfYsdB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=S0xBnOYH; arc=fail smtp.client-ip=52.101.70.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a60oB/xb0aoM135ntUyLMIfsfbtmjyaOA/LBQWrBVVGUpP42KgRQSyGJZa/KTBAJtY7OeJMBiecUYiaANd2GAEbzfGKLvEeLz5+B5AeOYlSjYkyVc1uNwRLuJ2CMj2MbGD4uVCec9bp+8K/gQ9OWhVUIFVr11h35zffxTg8wW/xQWf2oXkjuHUZKdL6pINZGKEpydkL3Xd+P7fJpfZrqEqFe0YF4GHZhkL+BxDfe3AoHrzkw7oxqqOVqfJE4LLpVkjZKMore5CBmgtJdRUOSaTtZNYnwu90n2fm2KS0GblUA29mx5yHQ8+4kXnoFNcbXspUyFJrjJBHJ0RzE4ou2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8ltleC3tcxghjXdochRLzUvVnTWi7IsSSyrdIN/Y/Q=;
 b=wSwc31jUrt4OBz284lLIh9YvyvNQaJg/h+QL8p4K69vpRFX2WO0Z0vfIN73rNFUgYy0NVMGjoCAixweaOui13MmiwqNfMOQ4qWgqWxlN+ZWagVp2wvv5altFiXKVbIVlwg9RMipFbhotnumhlDwwrDBALw1lEl4Fy71AweF+5Tf1XdyC+u1Wd2XdBrZ5KN4Cl7aYIgzC9BcAAVvvzvKU5S1xb+rrg4uRVpSjpJlsWCm8GDHv677wdQjrBFQQl2g0LlSbtShdQyvq6kYGmU0jTTTpFSw74AsVecG/Zh6T+vzb8SFjsEE8zBr79ia1WYt02P6NS8V6S1uU9zRw+t8A0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8ltleC3tcxghjXdochRLzUvVnTWi7IsSSyrdIN/Y/Q=;
 b=S0xBnOYH4Q/cXSVC/y1gpDukC7VPa9FoZp6r3CnOajONPhVJL1Lei3LExxV4gvvvqa8SIETJm/RoPZGmiU4lLrjzo7yjnunKmvqS812uFXj9Kd9jSDQMxKMIQWsBurcPt3ao5yGO0fD57aAnXFFOPVBDCk1qvVvo+NBgL369Qrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PA4PR04MB9271.eurprd04.prod.outlook.com (2603:10a6:102:2a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 17:47:35 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 17:47:35 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH RFC 0/2] phy: mvebu-cp110-utmi: add support for armada-380
 utmi phys
Date: Mon, 15 Jul 2024 19:47:28 +0200
Message-Id: <20240715-a38x-utmi-phy-v1-0-d57250f53cf2@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALBglWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0NT3URjiwrd0pLcTN2CjEpdA6NUCwNTy8S0VGNTJaCegqLUtMwKsHn
 RSkFuzkqxtbUAwsJFx2QAAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::13) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|PA4PR04MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4c96bf-c60a-415f-2fdd-08dca4f635af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2NKYUtSUTY3cEdNVisyMEIvOGNQenJQbWNmS3pyMUtwdWxWekFIQTJGSEpI?=
 =?utf-8?B?M1MyNjNPZjBTakJsQlVqbktOelZrUTVwNmFyYWh1bzE0Q2loSU41V3JaRFd0?=
 =?utf-8?B?NVhrZnNlVlJDK2Zpd2VMRzR6eUZnQ2R2VmRMVGhRSytRa1VZZUlGdTllQ2Qx?=
 =?utf-8?B?QTc1SE5qRStNQ09FS1pVUEx0Q2xhM2Q0cGk5dE5HcW9wcE1OcjVSWWxlZURE?=
 =?utf-8?B?T1ZaQTA3OE51NUhNSEhkVi9aakFHb25GUE9mYW9qZjVaM3Nrb0hLTm44d3Nu?=
 =?utf-8?B?Ny82Ulh0cENPVmswYzJPTEt1WTZodkVtMGFVSHZscVRNa3IrczE5dHpmYUh4?=
 =?utf-8?B?SElMYno1RE5HSTVxeFRhWlJkQlhjUm5rRldJUzlRb2RmQXJqbWxBTUlDYnRo?=
 =?utf-8?B?RWc1V1ZVenUwc0NlSEJaaVp6TWhyTk5IMVNudGpPWmNmWnJ3YTU0dFpWYllR?=
 =?utf-8?B?dE80aFpkVlRTelhYSzQ4V0ZtenhUZ3g5NUthTFhtMDR3TWdlVnlhaStKVGc3?=
 =?utf-8?B?dytFVUVVdVZiT3lOZHgzdjFtVzEwZ3g0NTcraHlwSFhrelFYYU9pRHpNY3dO?=
 =?utf-8?B?aXNGMStnekxzL0ZoRnR5Zm5wazVaQ2E1OVo2b2dCNHJOZ1BDZjVmazFWcDR0?=
 =?utf-8?B?WFZEY051QWdqUklwcjArMUhoTXUwaldGZUVVT2phZFdDTC9kWG45dmpaRXg1?=
 =?utf-8?B?U3FLVkFlUkI1QU44cEZKS2JEVU1OUk5UU3p4d0s0c1VUZXFCalJ5TDZhVW1h?=
 =?utf-8?B?bys5R2U4ejBmUXgvY2FUaUNBWDJjZjdwbDJ3MGlzaUR6cHowSStrRWNLMi9B?=
 =?utf-8?B?YlVjMVY2cEZZV3g1Sng1ZEhGMFpZeHBLRmp2b1JyK1pvQ1p6WHZEN0Qrajg3?=
 =?utf-8?B?OVpwOGZ2YitXODZ3bE5jTmhkenV4Zmdzb3Z0MEhxTnZnMGViQWRzcG51ODhr?=
 =?utf-8?B?Qmt0RytxdmdRT1hoWjNzbnNTNGc5dHduRVFGdE1pL2hVYnBScFVZbGpuMnA0?=
 =?utf-8?B?emhkTE1ISXUvZ1BVTDVZRmNDL0lya0dDdkV5T2hUTWFnbXZGcXVNTEl6YmFS?=
 =?utf-8?B?SnZQWGpqSzAvZDQ1aGhhbFAvN1doTDN3S29wV0RZUHRjSVNNYjhscldFOTZ5?=
 =?utf-8?B?T1FncmhJaUpvWVlqRHZIMC8xVW1yU0NkN3c4c05GbzZoU3MvbEh2WTZjMHRm?=
 =?utf-8?B?M1o2Q2src0RTN3dRQzd3Smg3aGx4QkNIbllNMkhZMGdMa2FoSlhHbERsRkc0?=
 =?utf-8?B?TEFFZEFzTURPaWgxcGdMYWZ5NldiK0xhWUd1ajVqWmVBMXFqRW9melAydGZq?=
 =?utf-8?B?RVJ3dmdmRmhad0NUTzk1WFptUWdka0tFZENNbitYUGt3TEEvVVZtTG9oOVRi?=
 =?utf-8?B?ekN4R1ZxWGpGU293RXBjczNjK0NZUm1rUGROdjJOT1pHdVpZZ0paQ3lDUFE0?=
 =?utf-8?B?T3JQNyt0UW5kTldnL1AyVEwvNTVDTXAzUW5ieGYwTXlsdkdSRlhKTnJtVUVN?=
 =?utf-8?B?WW1FL2k1TDRUMVA5bTBwUTFwVi9YMDhQbnZ0WVpQcHA0dzhPOTRyd0E4TXVU?=
 =?utf-8?B?MEN1b1ZUbm9DSUN6R3d4UlhWY1NSWk4zbmwvTFFWaFNUZ2kvUkZ5djZSeWEv?=
 =?utf-8?B?bG9xYXNKL0owVWRNSml5TE5wS2hqZ3hTcU9UUUo0N2dVU1NDM2hHQTRSUmRr?=
 =?utf-8?B?Q0p4SktmN2Z0NjhRcWlFblduMm1Tdk5ERjg5OVdjdHhwd1dWbVR4a05xdGth?=
 =?utf-8?B?dlRqVFNiejFZM1JhaHhGaG5JYm5tSUZDbGFDVFBjdEpEUU8va21VcVRKZVh6?=
 =?utf-8?B?azFWUDYwMlJsK3BwenVLbXJuY00yZnl6NEc0RUZSUVZrQW0vZkl3ZExRMTQ0?=
 =?utf-8?B?NXh2QlpwbkthdXpCUysyVy92RHgxL0VPVnVtNktLNllqanc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnVsMzF6d1kyRkRyNGVVSjIxanZQb1p6L1ZKK0Y3L1RuSzJkU1ZsUGdTZU8y?=
 =?utf-8?B?RnRGT3dkWEgxMFJyWm9qQVJydTlkbTBTVXRKdzFDQmd0ays5ekJWTHVXZjhh?=
 =?utf-8?B?UUNYY1Jqcm51YThKTm1yUGV1RU9LSC9saDBnYjlWV2tPelhkbENsZkMyY0lF?=
 =?utf-8?B?QjB5Uk9mWTBYMStIbTRaR1cvNGZHdWwxV0VvbmRXeHBXMmVhRmptSmthRXph?=
 =?utf-8?B?WVdLb3dOVzd4R1VDVHlEZURkalRiNG1ZdTNDR0YyN2xJQXo1Q1ZqNmY1YlRx?=
 =?utf-8?B?U3laSnpHZU9hSDVpdFBEVXNiL1NVQmdtMlJnYUZaTFFDQys0QllUaWwxQjFn?=
 =?utf-8?B?c1BUZTUzVjlyQi9tbW56SzJGMXhyZkpqWHBvcWxib2ZzVjV0bzFHZG9CSWpp?=
 =?utf-8?B?ZG5FYXZMc0pldHc1VnVxOGZGZkZSMHZRUE0rcXlCODhpdjNtUjg5WjZvNGMz?=
 =?utf-8?B?WkdjSE8wMnRla1JldlUwTmJ1dGpGQkprRmJ2bHpHQ3FuVFp1Ui9BRkRIYk1P?=
 =?utf-8?B?UkFZZzUrR25EUzltK29wUWJGWkxuMWkwK2hINmloWk9OTkVyR21pN2dhMkZh?=
 =?utf-8?B?b1hORlR2YVg3VU4zVDlIUUYySEY4Yk9yQ093VG1iSGpvSm1KdndrRzFtUkJM?=
 =?utf-8?B?dDV3STVGMVdFUTZCU2lkVUZFWnBLbmFsV3JYZ2twanlkckhjd2RQdHMveSt3?=
 =?utf-8?B?VnFCbjFlNk1NWnZJa3MrYUQyYWRIYVN0S3J2NWM5Tnpubm03ODdlMTU4YS9M?=
 =?utf-8?B?dHVlb1E1UDl4QUdmYXNlMGptUW1KLzdTeVlQVWRuQUtBdDlNWVQ0eWkvZGMr?=
 =?utf-8?B?SWp3ME9CaW5BczZOTHh6NGlVWXJhVW5ZVGZndDdicitCVGo0aGh3a1BEYisr?=
 =?utf-8?B?UjNBS3ovV1hTb2RYYTR1MDEvekx5RnEvZkxxTGVINHFHOXovbWFCb3AxNGI0?=
 =?utf-8?B?VkF5bHBWRVdQcTJQYXBITFR2a1RlN0NRNEhGTzNzQUdDOWpHVjRFVG4xQjd6?=
 =?utf-8?B?czBEL0JTd25Ccjlrc1pTUTVoWU5QcnJyeWczeXhrcnNxUE1TeC9TK2FFVnJV?=
 =?utf-8?B?YjJxU0VyRTZodnFQajNnbmtMR29ZQm50eTdBRXdVb3NTQ0pDLyswanlQUmtO?=
 =?utf-8?B?U2pEcTczbEN1WlBEdDFldnNwYUJDNnlLaG0zL3Q5Wkp5TG5TY0l0MDdyT0Fr?=
 =?utf-8?B?cXFLZWFzYlhBakk5a1RWazRGMFA4UG1RTWxmVTF4ZFFmMUZDQXhpVzF0NytG?=
 =?utf-8?B?Y2pKMnFZY1k5aStKRHBOdlcrWXllbTJxUm45WkJyVFduL3ppdyt1MVRMcito?=
 =?utf-8?B?ek5QK2IwNi9IdS9QVE8vQnJJQytzTnJFTUovMitYbmRYTHlnalJmTzV4am1y?=
 =?utf-8?B?RVhWMEEvNDhNS0s1SVhBeTZHTm9SQ2xiemhMTE1IcUJuM05PSEs5ODNuT2dX?=
 =?utf-8?B?a2hOc3dFOXFTUHhCbG5STzFYQ29uRldNZ3E5eGVuejloblRaMHdLaWEyYks2?=
 =?utf-8?B?NkZMSno5SEpsd05jck54Y1BxeEVaaHZYUCtjWXpacUhqeU1lNEt6TWRUc1FG?=
 =?utf-8?B?S3RZZ1JRbE1DZ2VvSVNRc3ZneGpmaXdRZ1pQdkFPVy9CWGMrSWFMUk5COHYv?=
 =?utf-8?B?TlRRTDFBM1Z0TmNBSDZtMVF5UERjNnljWElTQlRHU2NQcmVqOFBpN2lmSlNh?=
 =?utf-8?B?WEVaZnltSzB5Rkdpa0RlWmpNRXFGWVUwUi92Q3pRSzZsQ3BDcGl0QUZZVzVq?=
 =?utf-8?B?MFdLZ3pQbDJuMDA1NXRKaFpuUVdpeVIraXpzMXd2RE5tcHJ6U2R3eVB4Y1R0?=
 =?utf-8?B?WGhtNzFDcXlrZ29mdVc4VEZPOCtmTncyeEhMbXk3RXE0RU90NUlVMjVFZnds?=
 =?utf-8?B?WmoxY3VKNVFSR0lXM2QrSnBSbCtiSHlRMVdXZXpCSlN4TnhDWFdlazgvdnpG?=
 =?utf-8?B?WC9uUGcyUUlVSGpMdWg2YUpsa3cxZzUyUWdoRHRXcUdOVVRZdkFQVXNicEpF?=
 =?utf-8?B?WkY2cWJoUWpsaFc3Y2JvcWJzMG1kUno3U0FZK25yazlDMG1GQnhDdGRqSE5R?=
 =?utf-8?B?TEVEbmtDeEVXTis5TWFIZzNSd2RxN2dmbWJ3Y1dmZkZVRENWYzh0SlNUQTNE?=
 =?utf-8?Q?pYoSS0WmGsXSQ51glIfizspV5?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4c96bf-c60a-415f-2fdd-08dca4f635af
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:47:35.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWC44JRJUWiQU+rS1YlDacNbH+aRn8G7ieSF2FYCilH0os9ABtCTytopMFENLdJSu3W74fLz+9c3VDzX1LyzJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9271

Armada 380 has smilar USB-2.0 PHYs as CP-110 (Armada 8K).
    
Add support for Armada 380 to cp110 utmi phy driver.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Josua Mayer (2):
      phy: mvebu-cp110-utmi: add support for armada-380 utmi phys
      arm: dts: marvell: armada-38x: add description for usb phys

 arch/arm/boot/dts/marvell/armada-38x.dtsi  | 30 +++++++++
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c | 97 +++++++++++++++++++++++-------
 2 files changed, 105 insertions(+), 22 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240715-a38x-utmi-phy-02e8059afe35

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


