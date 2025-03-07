Return-Path: <linux-kernel+bounces-550332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0431DA55E08
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F011E3AC787
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D972F18CBFB;
	Fri,  7 Mar 2025 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dpp+vRXR"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012065.outbound.protection.outlook.com [52.101.71.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58522E822;
	Fri,  7 Mar 2025 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741316932; cv=fail; b=pL2qwV+88XHvH36xlQ1dvFQlTGwPRjEtkWHZtWhdrLAYnTfqgCK4EYw5gVz81SRg1njHPS74UhD1QflZl9dJ6ksdx717HpkFgWIpETmlwaWFPMGg46wSDnQJ80tTpbm8flw4JxNewv2AJjJJtnPUGUa2apULgungpPh6LYvqFOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741316932; c=relaxed/simple;
	bh=MlPouEsM14KdZeoblRiHzlS+jVU0oZK0wSSAZ5hWuk0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fei9g+4vs+6GYQ2RkI5bAD4QJIbY7uywFDyoYBouNb27I0oV5NRha9vsbQdeEiJX8ikH6CwF8nG9oNKh1DlIAUMmVXKfBP7BJDu9jrKUygClMpdmeWVEVGtTHe0QvN/lF0wWXgSa1yhKhFiwm8vF/J4l6OXLHQWPe4fo9C+9BWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dpp+vRXR; arc=fail smtp.client-ip=52.101.71.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSQvbBwWoJjia/j/DDwPxu17tSmemgr8vP1kioczL0T7dmkgBlaMnxFxyFDpYcGQyBU6phRgKAO8UCWeDTiyDLGGy4tea3w13ngu0Xkw/n0OjR8ZpE04bs3pxmc3g3irAe0q3DGogFzOhLSD8HpG4BGmboJhQvwRb9DdLxvmSlEHE/5UBnEwklZ9vJ+8HrU8Xyvmt5TWSUOH89xQyZK45P8/2O1FK6ldnoyUlFxWDOOXFPuWZNzYl3eKGQjEeCUQHm+QPHZf7YgWP2DyrKdXFOzkbUuJBpzvL3ppzrZ/2gUGBs8arY3CSHEssbwEGG3mdp31JDjWlpuAdD5KjcGkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jNo5XoXy9b85ypbjBv3WAtpPgynrdx8Zq0/OJdsQKk=;
 b=Fr9yHasWcpg0Z3vuSQRrFZ//bXMKs0Q5xjqEjAHoAyY/Y1fKqCPykDzQIUM50cfu0eCpA+p+csR5OTzMw1bhkaDo8xnHIbEUObN5gWNC4G4H4cjhxyf0FqtDvyx8Y7She7ByFXYEVXhGYtu/paFkqMa6ctJHvweoOD/O/8ocyU+/hzzBpvRoWGPvNVwxOhjae2gFnRHFoUL7YH6/EY2Ekf6DNlrXVq+tHTOOK9F5nHR0YsDwPaH5PUrxERdrUpVcPCuXkRBSvxvQl639isDj9RfVJZ+Q5ONHfD1Fi0ofgAzgzQnANqFlhVJKSAMLyVsprnig716xABisJF2f9LzH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jNo5XoXy9b85ypbjBv3WAtpPgynrdx8Zq0/OJdsQKk=;
 b=dpp+vRXRAK6uY4NYmz2eILGnKcP+gx6NaQEX+opnJYDwdhHMuLqONMPKAVtOrIZgYaZnPWmILbN9PPugHePQ9JTd/4m2TVjLcocUdU2bN6OJBb3KaBYETcHQD2GI66PJyyFnvaMsNLklonm6ANrHzDPIQkHgTgimjpMI5j3fA1Y+FsTsB3eycYx69P6J4O14if8nlzVdjn0wCjvmUIIOMM1G1dMcXmkAMKfiAJPU4DxWXDgwNBWt7nXpdc6j13iH+clnbgyPTgXJSFuAv2rkdsntNp1vKhB3zOe4eFX7tlMkzRjwY9TbOcCZKlUvy/nR2PkdH7gSjVhQPufhPG3bkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DU4PR04MB10482.eurprd04.prod.outlook.com (2603:10a6:10:562::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 03:08:48 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 03:08:47 +0000
Message-ID: <0e82c4d6-8b93-4dd0-ae34-155e537ab344@nxp.com>
Date: Fri, 7 Mar 2025 11:10:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dt-bindings: display: simple-bridge: Document DPI
 color encoder
To: Maxime Ripard <mripard@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
References: <20250304101530.969920-1-victor.liu@nxp.com>
 <20250304101530.969920-4-victor.liu@nxp.com>
 <20250304152320.GA2630063-robh@kernel.org> <1891036.atdPhlSkOF@steina-w>
 <20250305163805.GA2071011-robh@kernel.org>
 <7d98163d-10c8-457d-92e7-6a1d6e379beb@nxp.com>
 <20250306-kangaroo-of-pastoral-typhoon-8aefb2@houat>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20250306-kangaroo-of-pastoral-typhoon-8aefb2@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DU4PR04MB10482:EE_
X-MS-Office365-Filtering-Correlation-Id: 3220b081-fb02-43fe-be4b-08dd5d2560c7
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZEIrSXdFV2xoY1V4Z0tWVHAzYnk5Vnc1eGNkb29Hdm92NWM2cmJNb2hQQkFI?=
 =?utf-8?B?UmJyVk1jcWpmQjFqR0hUdzM5T1IrQ2xJRHAxNzhNbnpWSmlEMHVBRXZjdXBR?=
 =?utf-8?B?TzNKWVp2VlN4eGJuemo3ajlkbUFWbmh5b3A4SXJ5dXh4RTU4eWFwSDVmR3hx?=
 =?utf-8?B?cmdjM0l3eEpZcTZuOGhEUExzcWloTHNzWmRrZjEzUzNaUzVlUzJMRFE5L2tQ?=
 =?utf-8?B?aFh1U1l5RytXR05xanVmREwzMUJzYU5qZzVnUHBLZ1ltcnljZDIweUE1Y25z?=
 =?utf-8?B?bk1ZTlJjUkt2RVV4VGwxR0Y3cFhUWCtFUDZoT29lVnNpVXlDUEFGV0UyK0J5?=
 =?utf-8?B?cExRSnF1N0lNMEY4aFB4YzlKT1lpSHB0WmZlSFY0OTdHNnlvZjZneFpiZ0M1?=
 =?utf-8?B?VGZMNUk0djNNZllSNmVicDZ2dHMxZGZaVXVOUTN2S0lHMUtOWndWQW9xZG4v?=
 =?utf-8?B?MXpqNTFFOVh5UDVQY2d4MkFweWUrWnFaWUNOS1NaRUJxWGlLNXBvd3htaWJU?=
 =?utf-8?B?RXNQWEtsR2Y2ZlNxQ3RvWExoa1FsMjAxVVJweENnWHFTL2NHRU8zMnlYVFBK?=
 =?utf-8?B?K1UxazRuZVAwaUJBb3FzL3pWbndWUEdQZ2psYlZod2YyMzUzNUVFNzh0cWlZ?=
 =?utf-8?B?TjVYcEdydEYxS1JrOXlCL2ZUQjd1NDJ4ZGE0b01qMDJvem53TFl5OFdJVC81?=
 =?utf-8?B?UDRDV2dTTGxTTXVTVTJsTkY0STZsQTVvaTN4QStWb2ZSK21TU0didEQ1NGN0?=
 =?utf-8?B?QUZkQWEwRUJVL1kzaS9FcE54OXhCTFZvMyt5VjJKZUJsdjIvK3dndnBxMWMr?=
 =?utf-8?B?U1B0YWVzYTRwQ1U3VGlRcXlDTnc3MVNlbERiUmZVLzNNT0VDNUUwYWkveXJ6?=
 =?utf-8?B?R2sxK0s0R0xDRjB4a1MvOW5ZUDRvOGRmUFlJYmVJK0NCWWZ2UUJlMUlzRkJk?=
 =?utf-8?B?ME5TQW5FNzFPeWFmUzFOcDJJTTc5VCtJWmorN0JyWjRzenNIbTVVcDNYL0VB?=
 =?utf-8?B?cHhWU09DRFZmMlBrZFR4ZVYzbmhVVjF6OWFNZ1FkeGgrUndYOC9rakN2eDJN?=
 =?utf-8?B?VUNBdWViSm9xZVczd25OV2EzaHJmQUk4N1VGS3hXMXRmenNnMExJT3UrSVlU?=
 =?utf-8?B?alBTQjBvZWVUWE1OejZ2bnUvT1Z0NTN5elk0aU1WOUE3MUxxWW1kWGJHVnFY?=
 =?utf-8?B?ak1pbENCaEJOd0c1d3hkdGVOcVpWbDUza05tcnhTZWtiU3hReE1ydlloUzdR?=
 =?utf-8?B?d0NzWDA5NFFxWEVvaUNhcmtYT1FweUFjZy9waEUvR1JwZU9zL3B2SkdhOFFu?=
 =?utf-8?B?bFVpYkZMRFFmYk5pQTB6SXUrOS8zRWY5OXVSRzZMUkVqT2hvYUJHa2tFbURZ?=
 =?utf-8?B?NENXT21mSXdIckszYkdqN3ZTZytmZGtQQ0NGRXMzcUMrWXA3bStka0FrUnRV?=
 =?utf-8?B?aE1uVXIxbDc4bENpSjR1bDY3bEZLQ1RabWxSRmRGbnJOZ3VYL0xqZmp6eC85?=
 =?utf-8?B?RFpqYnpDRHJUbUlRZ2IxYXc3L3lJeFZ3azN0d1pab3VBa2JKZVQ4ZHBVZktJ?=
 =?utf-8?B?Ui9MODNDOHdqK0U0ZVNhV0JjZmZBM2xqVTIrbU51TU9uQTQ2VTI0SWR1b0tv?=
 =?utf-8?B?VVhlMkhITXNFc1dnandZMjc5SlllNjAzbUJuQ3NjSXhDU2ZhN25aMVhOSFdG?=
 =?utf-8?B?K1BLTkFBNWZSOTd1aDRDampldWlHZ2hnK0swYnZyWlZxMDY3VGNvZVJuSjRP?=
 =?utf-8?B?ZCthYTNiaytTTmIvRmZiWEFUZmI4TlUzcWhZd21aSVQ5V3RsMk5pakhCNm1v?=
 =?utf-8?B?ZU43Zmxmb3B1cXU4aXNFTDJJRUZOM1BKYmJ5dm43azIvTUtCaElSd2RlRHZv?=
 =?utf-8?Q?OFTvYHX46EV4V?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ckp6eTZoMXBjWlNNVWhFS1pJV0NHdWd2NXY4elR5VjJOQjFVVE5MMzhGQXgr?=
 =?utf-8?B?M2J4YmZmUVZicVNNWEFYRDk4RWJ6bHN6dEtsS1JMRlFaaDBqUkdQV2xwWTRu?=
 =?utf-8?B?dWp3ZjQzOGpCeWRNSDlzRzJ5ZXBtbjhETWI1RE1EOEcrUFNERzFNU1dZSTMz?=
 =?utf-8?B?Vkt0RHZiQ2pUTm1kWjZxdnYrSzlQUFUxYW51b2x0MTQrWnRTVy96RzVJS0I3?=
 =?utf-8?B?UFpNSHpSNW9CZ2wzeDlUOXlCUHRlY1EyQVdXQ08zUGNuUXM1Qkw2NjkxOFlI?=
 =?utf-8?B?MXJJdU51amxRK0xHT1FXMzBCVUp3SFpaNFl5NzBuWjA4WHZJN2dHbkhzOFlv?=
 =?utf-8?B?a1RnV08wTFNrdnNUckdmVUJkcXVnVUUyTFc4bUtDYmRaUmlLOUxCL0ZtRzlF?=
 =?utf-8?B?QXhLWjRRRWdZaFBXTnlaMWxmOFUvaGNDMjhNcTNhalRXaktoQS92cFJlZkpv?=
 =?utf-8?B?WDlHN3JXdGEzQklVWFVVdHBqK2FYZE5qdVROUEZZVWZkSGdySkN1bVA0Y29D?=
 =?utf-8?B?SWcvZlA2bXpza3Yyclg2U2s4NGY3SXh1MXN1bU13RWV4cDY0cHdyVGw0S0FY?=
 =?utf-8?B?aTRucnNGV1hFalpNcHRjVU1OL3JBTXJpS0x5UnhyWWRQcFVzQmFLU3piQnlV?=
 =?utf-8?B?ZGhNQll5ZTJEd254ZXdGRDhZUThpVXJoTFZleTRoTjErTkNjMEdRWjFoWUFp?=
 =?utf-8?B?akxUVVd2bnVqTnFDR2tzVTJ1bW5WMFJIWmpuN1NTNmRURC96THNvRWU2SUFD?=
 =?utf-8?B?QmthcTJLSzZ6OVRaUnh3NVZPay9OUDk3Tjg0Vk4xSzRJb0VFRTErelFRRUYy?=
 =?utf-8?B?c09wT1NtMWVYNGdUYitZNjlzenVwem0wWkUxcE9EbTVsNk1VTFIrbkthVktG?=
 =?utf-8?B?MjFoaHhKK3dSWHlnWHN4bTBiQVEvMkZTcmZCL2FGVlJXS2VucktjRFJKRHE5?=
 =?utf-8?B?Vm83VENJN0lmTnNza2U2cis5TGs3eG1CT1Yrc21QWVhHbVgvdDdMditPZVVj?=
 =?utf-8?B?OU8xUW9Bb0I5OUxRZkFvTytEWmd2bkg2Tk9tTHo4MFNqTTFadVhWWk5mcjNG?=
 =?utf-8?B?SHlYdGZQOUlVV09YYm1JWFZ0emd0MTZsNnBXVWVCbkQ1ZU1Qb1gyK2ZVaWdH?=
 =?utf-8?B?aU5vZ2ovb2hSTE1KTUhFeFBLNnZRdXNORVlNWG5qOG1peGRrMEtEMU9YVEJB?=
 =?utf-8?B?L2pKUHJvUGJ6RjdCbnBtcmo1M2lEUXg2bWZFMGUwV3dhU2Yrakl3b0dUQjRW?=
 =?utf-8?B?QlVVNzJqdDNCWHp3U2tzK2JCMTRtMTdobzh1ejBDNytqN3RXdTFMdEpKa0xy?=
 =?utf-8?B?bUpSR1dBK0s5NFgvV01HUVNZcnRxcUYvbTVqVXpJdGVpclhkUi9sMEFyMFBq?=
 =?utf-8?B?SkdOM1Q3dXl2cElCRW5DTVJVRW42RTJwa0IzY0FPNlNQRThNbmhLQ0Rrd1hE?=
 =?utf-8?B?Q3dCYUxZUlVEKzRCZU5MeTZZSmQ2b0t5SDRhN0ZWKzl3Q3gzclI3WE1OLzRB?=
 =?utf-8?B?NlFGYTlmaTBxTVRqYmdRbGdnWGJnUGtKRGR6UWdhQnBTNm1XR1BFeUZvbFlh?=
 =?utf-8?B?NlhZZVdXaWJGY2x6UXVxRTJTWkl6cHMwZCtZb1RJZ2grbFBZTEV1cERlalN4?=
 =?utf-8?B?S21IUGJZQ1ZPUVNiS1JjZUZpRG5HVC9uYmc1RjJDU2dTMGU3VkNZaitQZE9S?=
 =?utf-8?B?cWR2VzB5ZlppcUFmYmp6cTg2NDNZL2p4WUR4cFNaRkxQQzBoMkZtcjlBcDFN?=
 =?utf-8?B?VFJrSUtHbEV4Ymt5UFl5dDE3cGNrdlNxVkNPd28xK2pUNm1zY1JXeHlQcjZu?=
 =?utf-8?B?RjFnVEdOWVg3NVhUZE45SzIwMzV0bnZPa3VENGx3TGJwUW9na1d0dzVEbit1?=
 =?utf-8?B?WGlvKzhDeHZ1VlY3eXcreTlDWjN1cWo2Y3gzU2tpN2dwYmtnc0xWWnBEbHJn?=
 =?utf-8?B?aFYwbStsQWw0M0dXWXA5Q0ZZNjF2eEhVSkVDRjBmVE9lei84N1pKSkhTTUF2?=
 =?utf-8?B?TG9QMWVtWWVyZmwrM2gyREdkTG1aVlR6c1J6SU4wVDNNL1dsWm1pUmlwdXh0?=
 =?utf-8?B?TkwwYTlaODcrSVAvYWU1QUNnU3B6NnVCREZQMldLbWg5cEpXem9oam9VUE5o?=
 =?utf-8?Q?nlT6uq2Wo0cE8EJJupS++uTYR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3220b081-fb02-43fe-be4b-08dd5d2560c7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 03:08:47.8873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plT8KUqKJCJfYaDz244g2Ygu8ov19VJRZjiCT0dmjdLBGr5k7rRR40NuxtUl14mVNptRYQJEOpE0HOWvClUOmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10482

On 03/06/2025, Maxime Ripard wrote:
> On Thu, Mar 06, 2025 at 03:02:41PM +0800, Liu Ying wrote:
>> On 03/06/2025, Rob Herring wrote:
>>> On Wed, Mar 05, 2025 at 10:35:26AM +0100, Alexander Stein wrote:
>>>> Hi,
>>>>
>>>> Am Dienstag, 4. März 2025, 16:23:20 CET schrieb Rob Herring:
>>>>> On Tue, Mar 04, 2025 at 06:15:28PM +0800, Liu Ying wrote:
>>>>>> A DPI color encoder, as a simple display bridge, converts input DPI color
>>>>>> coding to output DPI color coding, like Adafruit Kippah DPI hat[1] which
>>>>>> converts input 18-bit pixel data to 24-bit pixel data(with 2 low padding
>>>>>> bits in every color component though). Document the DPI color encoder.
>>>>>
>>>>> Why do we need a node for this? Isn't this just wired how it is wired 
>>>>> and there's nothing for s/w to see or do? I suppose if you are trying to 
>>>>> resolve the mode with 24-bit on one end and 18-bit on the other end, you 
>>>>> need to allow that and not require an exact match. You still might need 
>>>>> to figure out which pins the 18-bit data comes out on, but you have that 
>>>>> problem with an 18-bit panel too. IOW, how is this any different if you 
>>>>> have an 18-bit panel versus 24-bit panel?
>>>>
>>>> Especially panel-simple.c has a fixed configuration for each display, such as:
>>>>> .bus_format = MEDIA_BUS_FMT_RGB666_1X18
>>>>
>>>> How would you allow or even know it should be addressed as
>>>> MEDIA_BUS_FMT_RGB888_1X24 instead? I see different ways:
>>>> 1. Create a new display setting/compatible
>>>> 2. Add an overwrite property to the displays
>>>> 3. Use a (transparent) bridge (this series)
>>>>
>>>> Number 1 is IMHO out of question. 
>>>
>>> Agreed.
>>>
>>>> I personally don't like number 2 as this
>>>> feels like adding quirks to displays, which they don't have.
>>>
>>> This is what I would do except apply it to the controller side. We know 
>>> the panel side already. This is a board variation, so a property makes 
>>> sense. I don't think you need any more than knowing what's on each end. 
>>
>> With option 2, no matter putting a property in source side or sink side,
>> impacted display drivers and DT bindings need to be changed, once a board
>> manipulates the DPI color coding.  This adds burdens and introduces new
>> versions of those DT bindings.  Is this what we want?
> 
> There's an option 4: make it a property of the OF graph endpoints. In
> essence, it's similar to properties that are already there like
> lane-mapping, and it wouldn't affect the panel drivers, or create an
> intermediate bridge.

I don't see lane-mapping anywhere. Do you mean data-mapping instead?
data-mapping is not defined in dtschema. Only lvds-codec.yaml defines
data-mapping in endpoint.

With option 4, I guess you meant display sink drivers, i.e., panel and
bridge drivers, wouldn't be affected. Then, display source drivers, i.e.,
display controller and bridge drivers, would be affected. This adds
burdens for driver developers/maintainers(though almost no effort from
DT's PoV), doesn't it?

Moreover, why it has to be the display sink drivers which are not affected?
DT writers might choose to set the format at the sink endpoint, e.g., setting
RGB666 at the sink endpoint of a RGB888 DPI panel or bridge.

> 
> Maxime

-- 
Regards,
Liu Ying

