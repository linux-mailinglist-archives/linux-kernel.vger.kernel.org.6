Return-Path: <linux-kernel+bounces-347659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680FD98D946
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880F71C2318C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A557E1D1F5E;
	Wed,  2 Oct 2024 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="GEXxaDkj"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020119.outbound.protection.outlook.com [52.101.69.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D701D016B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877892; cv=fail; b=WDdK4iVEadK2kKK9UnFYXf5SBzoIMBgmLuduHBbOUU+h7ZiZsJJ+U7jyNbXX7IClmYDPzux86+tlLOWIcSySwv/EALl2RZIcKQ2cyd2+pPj3fGKK0mONKyMA5JWQvslFJZfQtp1DDw8jqnHHsj9TBoCWLcdOYu3+nCEXnjoTbec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877892; c=relaxed/simple;
	bh=KzPyi1ZY3agonU8NwcI4P7cyv1AZp2aSiYtNboisP0Y=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=NwDVsjCN9bDXtxFQtglNlaHVs8DR2HhcZwemYa82rWqX/ywVR5InHOMA/gFfFA6jFijZveIFtGgsVBLcEsAVpcbZvyzWJXfgCGER7dX1wjxP2d4LhvIUA4uttARF1LGhT8p7cdTfaKTTgSi8EbIYE97ap68Q3E2HMMS+DuLMENk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=GEXxaDkj; arc=fail smtp.client-ip=52.101.69.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxjGZgzCFeTfd0/MoI5CMqMI4CfcXqtF6ZisbvZKPemDjL18q2UggfRWkHDz+1QOjCBQp/YBBeoO0/CyBqaYOxIZykffDpcAXB/LsisOHeN15n1eTIELC9I2wlNALfHuGCRGnaY2Y8wDAuM6i7VsBKolUbKKpd9XBXhKThM7GglhB0dT76qyfZyGarRb82QLY/yekbR02/FGw9DBJM4zY9q4ID7tBJM0OnyqQFjAPsyquV8AoSE1NhUbaczobg5GPQ1j/Ns41dRXAiwRvssNkhht6marwhYPepuvZgrCSOjBQ9EihYT/wfbyGG0gWUBP8ALLh7NmxE1aWFfB4CMnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXn8zHlDp5tAHfmcC6ozjulSVRSZR5lEJb2jT4EQMn4=;
 b=KTMMZGYeTP1YSBO2CdYl8aiZj75Jf4IThrzgyjgy4Za4s5PeUa0zX81FU0i/s7IUv4fOwysw/+6p9rjvHTMbAtDcD11aRrVsw3ZnV4tsV/W760jYpp8VDfgVMIz+R6tvIV3XPZLDKUNFEdyNPBU+0fOXUGL+g10LwDXjQPnH+SffscUbTv0XEyR0o45us8bMRP8dhzaUMjJN3Qh/FUMrJzbY7I+XMiISWbhT9on4uy/YFTYzSBKmBOs3QtDkSmlGDN1U8s3jbX4Sr7/EyMQKFdM+yQ0TTRtJwPzGk+i8oiLztVuicQ/9UBWh28rLcbTE908LnbLa47cxdM7Fch7/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXn8zHlDp5tAHfmcC6ozjulSVRSZR5lEJb2jT4EQMn4=;
 b=GEXxaDkjBK8Y0kwZz6eflwXiPg3+TjNjAsfC0oGWIoJ11v9zqKhQPDRsae9ybr3opqavaJy6zq7PK1ELP4D6OCGEK6fhjiUFHb8Vk1+Vj+LP77JtSOGivhA2HZ/A8mFZo+8276MZ1mSkhD/Z60kD5dd93ZGYqhSmqE/kpn7eR+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI0PR04MB10095.eurprd04.prod.outlook.com (2603:10a6:800:246::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 14:04:45 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 14:04:45 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 02 Oct 2024 17:04:40 +0300
Subject: [PATCH v4] phy: mvebu-cp110-utmi: support swapping d+/d- lanes by
 dts property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mvebu-utmi-phy-v4-1-83783dc89b9d@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAPdS/WYC/3XMSw6CMBSF4a2Qjq3pC2kduQ/joLQXaSKPtNBIC
 Hu3MNGIDv+TnG9GAbyDgM7ZjDxEF1zXphCHDJlat3fAzqZGjDBBCiJwE6Ec8Tg0Dvf1hKXQmpc
 VV3lhUTr1Hir33MDrLXXtwtD5afMjXde/VKSYYmW5kQBanCC/hO7hLPZjezRdg1YusjehCN8RL
 BFFJZShnFbakl8E/yTkjuCJkNLkROUECsu+iWVZXnQEejs2AQAA
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|VI0PR04MB10095:EE_
X-MS-Office365-Filtering-Correlation-Id: 3791fec9-40de-48d3-241d-08dce2eb2b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVAxNjh3QU1ackh6Y082VzVoczNJYnNGTDB3RytsaGJQUkdEeHJTRk9xa2NO?=
 =?utf-8?B?YmtOVmpjSHJzclNLNVNaZE1qQkUreUY0V2pOK1NEQlpXK1JORVNZaFdFSGxN?=
 =?utf-8?B?cFJDMldseHhJRkRGQkprYUc0L0RTS0M5VlN1QzBrZFdKczRUY0d2eS9YRXFw?=
 =?utf-8?B?K3lBeTNaRXFOZUdOZXIxM2V1bG5kSGlTMmVPYnRIeUxtZ01ZQUdJcDBpUkVo?=
 =?utf-8?B?SkFoWGZrZFgxdGpKSzZzdmNacmlCRkRwMkZEY2hlN2JSWGdXUXhmTTBOYnhT?=
 =?utf-8?B?QUI5LzVLenpXK3R3cFRHYmttYXRJVTZmaTVBcDdkbjZFKy9pQkZ5Nnc5SEdl?=
 =?utf-8?B?RSsrZUYxMzlEcHhPNHBSTWR1TFhDdHNxdGM5eVFYWTlyYjd3L0hGV1FiK011?=
 =?utf-8?B?d1AwckovREVBZ3ZTZ0RUbjRGVE5rd1FMTmdQUno0eDR1N0l2djA0SWN2M3pv?=
 =?utf-8?B?am44ZDFwb2NUWlBjaURmUGNNQ2Y2TWdaaDhBRUc2UEs0elJNMllPeU9uU3hY?=
 =?utf-8?B?UjVvUE1UaG9EOWQvU1Q2WHVFSE04bGJ5Zjl4VS9PVXpZeFhuQ0d0YzlMcDZ0?=
 =?utf-8?B?elNYYlN0QkZFYVduUjkzMVRHTG9LSU0wdEdIRlgyVXdGOXFMQjFDTVFrVUpn?=
 =?utf-8?B?QnJKaStpa0pWaWlPV3p6Qm1kL2w4R3dxYm1ScXhpdm43Qllwd245dkNqUVYx?=
 =?utf-8?B?SWhNN0RDZGZiTkdPbHJjM2dEeGcvNjMzemxnOWlHbE1Lc2FGSDM1bWdwQ0N6?=
 =?utf-8?B?cDlyRVFHOHF4Z0lrMllIUnlyU1VSVkRnRjB3TWNuMFJVWUdla1FpRlcxWkR3?=
 =?utf-8?B?RVpaZlFSclJmSWFXZkdxbGRpQ0t0MVVZZXBjSTVMQ3JwQ3ZPN3pJb1BVR1NN?=
 =?utf-8?B?U2JwSDlkd3I4TEtEcTdmRDMzRHhkZjVFbG8yQ2VPbjc4Z25vYUlEQnozKzlO?=
 =?utf-8?B?clFQVEwwMDNvcXo5eGZnclBmLzZBUFhrdTZCeVNhUGtBOVpGaENkMmkzdC8r?=
 =?utf-8?B?WGpBTW9YdFg5MXcwKzNMM1pJaTl4dlhJMzVJUmFveFNIWGhNa1ZIcEF0ak95?=
 =?utf-8?B?MDU2YzJKcThtK2Q5M2RSQVppMkV0LytiNnFQQVZwWjBMVzlFNk5sUENQR2Vp?=
 =?utf-8?B?NWZtMEhZbllrQksraWx6SzRvZGhlWUtDZFo3M09nblBjOGE0OWFUTW9WZkpk?=
 =?utf-8?B?RnJUM2JaaVY4RFBtTE5EMDRaclVFd2ZCTWU2Mmsrb2Y0bWh0bjRxQ0J0ekdi?=
 =?utf-8?B?cmFVWUFJbmpZR0hoZlExVy92a3pPdnBKR2FzVWJxRGFaNmFCclR3cW9URHNC?=
 =?utf-8?B?aE5wQ0o0bFU5NEp6OWc3YnRVcWJYN1RhU295bXhkRVEwSnFjczU4QXRMNkZ1?=
 =?utf-8?B?VmxVLzdQT3JNWHczdzh0RlRJRkJwWmZkOVVSd25WTDRsYk0vbGxmYmFvaTJ4?=
 =?utf-8?B?RmNzY0kwYlJLOWJMdjRRenlVcWNhU09SQWlqSTRKYVJjZTZVRXprMnZibnox?=
 =?utf-8?B?ZEVxQmNFSzZPT29GMlA3QXBVeTM0VU1oSzUzZUx3UjZQd1NnWkpJUHRsTkFo?=
 =?utf-8?B?LzF1UEVoN0dhZHI0My9palhUMXZkTDVqRzdtUzZRMUtMbTJrTUsvVEE0K0JL?=
 =?utf-8?B?aU5idFZUM1RuMzNNdHBZallzNURFMDgybUljYTdQY0krNGx4dWtiMTNhak5W?=
 =?utf-8?B?Qmhmb0NhTmN2R09MYlU4T2xPS0tVNUM2THBEalpJd3RrbFYzMzJrYStoRDBq?=
 =?utf-8?B?TXV5UTZtNVA5REJQeHRhbGRSQlFJN1Q0WWtsYzcrdXFnOTBXeURDWnRITTlD?=
 =?utf-8?B?T245RGZaR1N2QlN6eUF4UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDRlOEFIeE04UzNzNDJSdGYybzcra2gvcWVwLzVYajYvb1VvOCtYcVd3TlI5?=
 =?utf-8?B?cTE2VndBSUdUb01Sdk5HK1h5OEVXay9veUpZRFVHUWhMbWUrQlkxRXV0OWFx?=
 =?utf-8?B?Y0FsNzJuVUQya0VyekpDS0oxQUZoMTcrQkZhdDZ5VVJiVnF3d0FXU1dOWDVH?=
 =?utf-8?B?eGxhbXJKVEFZL2Y0YUJwVHo3ajlyc1dkc1ZxeG54YzNFd3o5U0swYTQzWUc2?=
 =?utf-8?B?UDN1OVIrQndUaHk4cEVnZHhEQ050ZUxGRFpaTUZYM25WZi9DUWEwZCs4R0pq?=
 =?utf-8?B?dXFpQk5QWk5uQ05oTWlRajllKzRBNmdTL0NqbjFzK3YzTjlxTUNjdXNCS3dq?=
 =?utf-8?B?bzhPYWJaN3hibDBEQjhuNnJHSVY3VlhCYTdmRlhxVStNclZNS1NCSDYrbFRG?=
 =?utf-8?B?SFA5OGF6c3VMbGZ5T0JBTmJWcFpPSXZJREp0RFZGbTZ0SmxBNGxzdU5FTHBW?=
 =?utf-8?B?N1lwVzA4dVBoK1RzRkJWeDlVWUlPWVdGWUZ2aFFKb2crWUE0eDBzQ3VxU0xL?=
 =?utf-8?B?NEVoOTZOS3dzcEJndnk3UXZ0T2lPMjJETm16U0dzM09JQXhrbnhKVWVKelBp?=
 =?utf-8?B?cFZTazI1bWRhM0VrTjVLN1NJN0E1WlRjUUhuMGw5cXJLV0JCTXZSTFFPdHRr?=
 =?utf-8?B?UDJxS2pYU2hWYlZvRCtCbkZSUWRHdzBFMkV3cUZwZ09zdlErQ2JEc2lzaU9p?=
 =?utf-8?B?OXAxcHRNWmkrV2JlZXArS1A5YUd4Q0tsVFpNL2lJVFQ1VFpPcmNGVlo4RmZJ?=
 =?utf-8?B?bVI5REMvdmw4eStPUGkrUnBzNWY0UDNYdlBoY2NKK0hhaHBzejV5MzJpZEkx?=
 =?utf-8?B?Z2JWMWJVN0NFUlRRTVJrZ0tsamVlQ1d2T0UvZEhVWEpGOXhpNW5XTmhVL0s5?=
 =?utf-8?B?TGpzaTd1UUNBSGY4N2dPSUpiQktZZCt2blNScnhlQ1N5ZDZKa0I4TjhobVcy?=
 =?utf-8?B?NXBhNU1nS1NOWlhnUzM5Nlpwd2RlOTRON3ozd3BzelEvY3I1V0l2QTd5dHRu?=
 =?utf-8?B?c1F0cVZ4QUhWVlExSUdxK0F3YWxHVkRMcnlGbzgwZFp0K1ZsSnZvN1hlT0p6?=
 =?utf-8?B?NTNwWS84VmtnK05aU2xXYXRVS2NvcGZSWEkyZG9yWFB5QUdXaHJRMm5RWVEr?=
 =?utf-8?B?ejhIREdMNlBxSHdzK21ib2duSTdEU2FXNkhtaUgyZnBWK2x4OHNMYytaa3N6?=
 =?utf-8?B?a3Q4aGVreEdpaWY5UVFaVmN2a1FFSjU0Qy9UcDQzT1JRM0tReFFoWHRHUnlS?=
 =?utf-8?B?d0NQcWRMUlpaanV1eDFaMWZGNUtOZThOMy9RaDhRaWF6UmIrbnNzNlY1T3VV?=
 =?utf-8?B?eU1rZTBTdldvTmkwVkNkMlZ6NHNXMlE0WjlNK3NaWC9xaTloNmNreEU2Mlpq?=
 =?utf-8?B?NnVCTG5xcDl6b3VhWlpLcWdFK0o2TnRieFJvaTJsWXlEZUo0OHRqMTZKSFdi?=
 =?utf-8?B?OCtGeEdCKzZ3WFlNSEdGQ0J2OUo2cG9laVo0WUVDejhKVktmSHE5cGdYNUl4?=
 =?utf-8?B?TnBacFlLL2kzOGt5aVh4c0txU1YzbmtmU0wxdndMcll0Wk5BWHNuT29Vc2xv?=
 =?utf-8?B?QmFWdWFFTU81ZGwzYllFdFJIQUtLWm0vMlNGSG02SWhIRGJ4THFzbDB2U1ZT?=
 =?utf-8?B?MkU2bnlTc0R2VFRIWFJud3ozdVB1TXNnSmUyUmNoQlh5Nmd0RVB0UkdyWjdU?=
 =?utf-8?B?WlN5WFFQeWZXMFk1YUJpaStUeVNTc0kwekdRdWNOdmhodTNManlSY1I1TWJJ?=
 =?utf-8?B?V1VaZkZNMHJOT1R2OU9tTEsrdG41eU1ka3d3VzRXM1pGWXFrZVZsSVdxa3RF?=
 =?utf-8?B?UmxkVXoyOVRNTWM1Wm4ySWIyMm44QXBUSU9lUVpvTWdRM3NNVkw3WTNyM3p6?=
 =?utf-8?B?T3NUZEx4STRSL0J2MjVnYitKd2xBZ21nblM4VUpwSHNOeTRwbmtLS3BhZy9C?=
 =?utf-8?B?VUZpanRneERUcjNOVU1mM0RUNmxhVnVyMXJVYmkvbGpneU5Kck9CSWlBUWU4?=
 =?utf-8?B?UHVGTnhzODNHNmp0WmVOeDVFVTMwRDBRYldzRmdJSll1N2IxSmZtUTJLeVZT?=
 =?utf-8?B?NjhRVFh6VE1kZDAzUWNjNkI0Q2dMRjU4a2xSaS9vQmptNkhtSENzUUtRa0FY?=
 =?utf-8?Q?jvwu4+CrustMxe57qwzkHHvHd?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3791fec9-40de-48d3-241d-08dce2eb2b7b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 14:04:45.5460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzovsyoKUESYU9SUOqSSGdut/noHz448IFfqaNtk2qMZK906m+xGEOJ2AFIJOzJ7dWXpU6i+U65B4gyNMtL8gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10095

CP11x UTMI PHY supports swapping D+/D- signals via digital control
register 1.

Add support for the "swap-dx-lanes" device-tree property, which lists
the port-ids that should swap D+ and D-.
The property is evaluated in probe and applied before power-on
during mvebu_cp110_utmi_port_setup.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v4:
- rebased on v6.12-rc1
- Link to v3: https://lore.kernel.org/r/20240908-mvebu-utmi-phy-v3-1-88c50950e7d2@solid-run.com

Changes in v3:
- add description for new struct member
  (Reported-by: kernel test robot <lkp@intel.com>)
- Link to v2: https://lore.kernel.org/r/20240903-mvebu-utmi-phy-v2-1-7f49c131fad0@solid-run.com

Changes in v2:
- fixed compile error introduced with v6.11-rc1:
  parameters of of_property_for_each_u32 were changed from 5 to 3.
  (Reported-by: Vinod Koul <vkoul@kernel.org>)
- rebased on v6.11-rc1
- Link to v1: https://lore.kernel.org/r/20240704-mvebu-utmi-phy-v1-1-9d3c8eea46e5@solid-run.com
---
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
index 4922a5f3327d..59903f86b13f 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
@@ -62,6 +62,8 @@
 #define   SQ_AMP_CAL_MASK			GENMASK(2, 0)
 #define   SQ_AMP_CAL_VAL			1
 #define   SQ_AMP_CAL_EN				BIT(3)
+#define UTMI_DIG_CTRL1_REG			0x20
+#define   SWAP_DPDM				BIT(15)
 #define UTMI_CTRL_STATUS0_REG			0x24
 #define   SUSPENDM				BIT(22)
 #define   TEST_SEL				BIT(25)
@@ -99,11 +101,13 @@ struct mvebu_cp110_utmi {
  * @priv: PHY driver data
  * @id: PHY port ID
  * @dr_mode: PHY connection: USB_DR_MODE_HOST or USB_DR_MODE_PERIPHERAL
+ * @swap_dx: whether to swap d+/d- signals
  */
 struct mvebu_cp110_utmi_port {
 	struct mvebu_cp110_utmi *priv;
 	u32 id;
 	enum usb_dr_mode dr_mode;
+	bool swap_dx;
 };
 
 static void mvebu_cp110_utmi_port_setup(struct mvebu_cp110_utmi_port *port)
@@ -159,6 +163,13 @@ static void mvebu_cp110_utmi_port_setup(struct mvebu_cp110_utmi_port *port)
 	reg &= ~(VDAT_MASK | VSRC_MASK);
 	reg |= (VDAT_VAL << VDAT_OFFSET) | (VSRC_VAL << VSRC_OFFSET);
 	writel(reg, PORT_REGS(port) + UTMI_CHGDTC_CTRL_REG);
+
+	/* Swap D+/D- */
+	reg = readl(PORT_REGS(port) + UTMI_DIG_CTRL1_REG);
+	reg &= ~(SWAP_DPDM);
+	if (port->swap_dx)
+		reg |= SWAP_DPDM;
+	writel(reg, PORT_REGS(port) + UTMI_DIG_CTRL1_REG);
 }
 
 static int mvebu_cp110_utmi_phy_power_off(struct phy *phy)
@@ -286,6 +297,7 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
 	struct phy_provider *provider;
 	struct device_node *child;
 	u32 usb_devices = 0;
+	u32 swap_dx = 0;
 
 	utmi = devm_kzalloc(dev, sizeof(*utmi), GFP_KERNEL);
 	if (!utmi)
@@ -345,6 +357,10 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
 			}
 		}
 
+		of_property_for_each_u32(dev->of_node, "swap-dx-lanes", swap_dx)
+			if (swap_dx == port_id)
+				port->swap_dx = 1;
+
 		/* Retrieve PHY capabilities */
 		utmi->ops = &mvebu_cp110_utmi_phy_ops;
 

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240704-mvebu-utmi-phy-84aa3bf3957d

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


