Return-Path: <linux-kernel+bounces-368394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFD79A0F58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C11B2846C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265D620F5CE;
	Wed, 16 Oct 2024 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qiw1S7ci"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFD420E026
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094960; cv=fail; b=mct25lNzWKMqL8ccbqqeqerNSMVVDW+cCUXAMw41h0t1ALhyFl9jZ3aIFQAl8ZOF/Ue2bQi8z3oGFZILIQIHt//E3A7EuigLC/+lk5mq3frAx9DjO2MqjoePfN5N8C93b9FH2FUlr5Iqm7vgHoxSSxRbSKrdOsl0xmCdCWo/TX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094960; c=relaxed/simple;
	bh=qSrbBmFX8pgqN4fwTlB6lPPlHA8ary3gkQ3epwcK4ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GCQY4Q0pOHtAzJVVAidMQV14BMyu+qn2J9RlQ+KMbMShk+S8PP1F3BG/iVekyqewcjNsrVAAO68UNPm1kaVCaPFinnRzMZnx62rSlNkrrGdzMI9ndQ0kw4FyFDD5hO/GQEq6ZLFjOykWCR9KK2papzYp1kQ3lwKXESJ92Ah9JZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qiw1S7ci; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkQGZI6ItbfBD6LPmlEJzepb9D+GQOFTSlEVEXj89SeltlgvoZEaVglKUh3LBX4jlZ/G4x7GFOY+8hFf748ceSfat5pROOXDOjA+Mocu2fJUtYvUXBmoCsV2seQSciTYCgWeBuy6fJq3kE1Nyasj5wnFFwcV/ZH3FSEV1vILv6/4fefQUlVthIIscwwZ8tDKc576fB/+/hfcdvcy7aQpKHtdYdKzd9JaHwPazBRF/i9DegKW8pD+HacH/5QFTvnRE23Q5Ik8pOYzSPfnl0Lv6jTwtVPT9FfMadGIar0AIRLSIEE6VLJf5x3DqM0fHfKXYvjMVcnVyOyerDyGpwbhDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmHS+HI+Zdlt+zYjnmKV/J1HmAyjVOMN2PfOf6v2qdk=;
 b=KCHLGF8dn9N+DNoSi1HPSqnDIl9MQzwI7BZrsQ0rTCqdptpt0jisN1lCJZ82c2zCYDt/LvTxAGzcrdy4JwX0hbarTjHugijrG48DNMBYQs1RO9FIDTwxZBSBnpx/YibGh2GSfa55AdSnQY1E/Kl1DT3Wa0Bj4DC/GhOaLGnfoTdkAdNBQRzfy8o1i92nW/6gOFjlNfHR/YqBswyTHgaQBT8FbicqGAEc8anPDNACcqOtpWSTmJedm0NwT+vnRyYTzNPrkMIbQwo3jbKvSCkIfaEu5JugTl2Pq5N+56SYNXWcDhE/NiyELOZMrqA7leEheTzvPO01fTz0Gt2XyfOB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmHS+HI+Zdlt+zYjnmKV/J1HmAyjVOMN2PfOf6v2qdk=;
 b=Qiw1S7ciI6xYVT0oep1jVJGHeErLFo9+POlazEEXjTC+PX3WazO/WXztdSy+0GkfrOplHshWMCsL6vHol/yi0hZygrF9Wqp+FVnn86Gu5O0VVUFWWG6d1s5xx1zIC9Fx/JHLIp336Z9tJjfRD43EeuYfnsjxGktFMW6ftUAfLwY4PGjERKFX2KG6w+yQKo+dW/srj4FwxnK4VDwgi25JAoUMLY/iUgox9bpHTvwlF4Z5o48AkBwmmqn7UVLtr9aNJnx6X2ewvLIiZGtwKkAZLvOE0af+HVQS4OR4Mqfdqz/MNt3f64MmYsASyYvhAxsbsIWW1k2eToUSq0gmd83cPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU4PR04MB10789.eurprd04.prod.outlook.com (2603:10a6:10:588::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 16:09:12 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 16:09:11 +0000
Date: Wed, 16 Oct 2024 12:09:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com,
	conor.culhane@silvaco.com, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, miquel.raynal@bootlin.com,
	pthombar@cadence.com, ravindra.yashvant.shinde@nxp.com
Subject: Re: [PATCH v7 2/3] i3c: master: Extend address status bit to 4 and
 add I3C_ADDR_SLOT_EXT_DESIRED
Message-ID: <Zw/lH9pCrkFoXsbH@lizhi-Precision-Tower-5810>
References: <20241008-i3c_dts_assign-v7-0-96ec93d1f34c@nxp.com>
 <20241008-i3c_dts_assign-v7-2-96ec93d1f34c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008-i3c_dts_assign-v7-2-96ec93d1f34c@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU4PR04MB10789:EE_
X-MS-Office365-Filtering-Correlation-Id: 75770439-22cf-4ef6-c35e-08dcedfcdf71
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RUQ0VEtaeDJDc1ZQQ2VpRGgrTGhJVms2SFlGaGQzTTVDaDBhMW9aaEtjdjlE?=
 =?utf-8?B?V1N2aUwvZlZyczNqeTJPcTBQSzdGQmdzMnZGSHBySTArMGtPTG9pR0g4N0pP?=
 =?utf-8?B?UlJ4Y3kzWHVTYThGNS93b2Y0K285dmwvaUVGY1dDL0xRM1NaUFo0bzJqUGVS?=
 =?utf-8?B?M2hsN1RlK0JkSkZUZ1d2c2ZRdGFOZG5oQ01GN21iUmJIODloQUdWd0E0NHBa?=
 =?utf-8?B?Q0tmY0JlajJBdnh3WFl4WjhCOGQ5NUVDVXBOaG5RampUcE9WNHc3U0xkSS9U?=
 =?utf-8?B?b2FRMExrUE1qcWl6WCttN3JzMm1CM1dUZGZCdG8zVEVaUFM3aXQybm0wb2tx?=
 =?utf-8?B?R2YzOStpQVV4U3dDOGdZUTI0TVd6cU12VUttWjdqM0lCZStjS0JvUHkyRVF3?=
 =?utf-8?B?NmgreUJlY3VjSXpncGJnYnF1VjltWjMyNUdHVEJUWlBGTjNldjMyTnBxWXgx?=
 =?utf-8?B?Z3RwL09MS3BLd2dISm1nQlRKakQyWUtYbTNKQ2RQelpXU2V4WUoxSUJ6OEdH?=
 =?utf-8?B?TnBGUCtQUERKUmNBaXpzdmk3V2VSRU1NN1hUTHF4VWZmRCsvYXVoYzI2RU9X?=
 =?utf-8?B?cXEwODZXOXQ3ZWY4UWI1T3FGQlI1TFRPdDFIQ2FEQmVHN0ZvZTZrRXo0Z3d2?=
 =?utf-8?B?bjdoS3FwQ01pb0luWkt0QXZQak1CT2FNc3hiKzBIOTVMUmZDbXdDOGlFRFI0?=
 =?utf-8?B?SG1oL1VJd0oxdmxzWTdGNjlpbkw5WGNZbTVaM1AxUDczUVJzSElrL1RUREc3?=
 =?utf-8?B?Rk9pVU5rZ2xrc2ZKR2hOYkM5UXBoMXJEYUs5VTZyYm80MXhhVWZKeDR0Q3ZM?=
 =?utf-8?B?a0cvOC9BSWgyWWdOdXcxMGswQzJUMmMxdWs1cXVTYXMyN3BtTDlFM3V0MjFV?=
 =?utf-8?B?R1c4bGVsRkxUT2hLRkR1NmoyUVo5cVZNTUhobENRcFN5czhNbkQwY0ZEMi9C?=
 =?utf-8?B?dmtXVm1tZGU2K1BTT0h1U0lsK1VPbHM3aGJxNXBDWEp6TytxdVdWQmRBajU1?=
 =?utf-8?B?eUxGYnlhUEhOVHIvVld5Ykc2eXZ6UlE4VHBpMEhuV29HQUFiVnVpREtmRWEx?=
 =?utf-8?B?VWhtTTg2aU5meUhGQVA4SUxYK0UzZlBlVlo5UXhneXNVYTQrYXlwMWRPN0lj?=
 =?utf-8?B?bVpNWjF4TkZvbmxQNi9BbEFBck1TMXg4QnQrM2NLaytERFMya1pwUnlsSHlO?=
 =?utf-8?B?ZzdubDUrM3pzdjB5cUQ0RTJHVGlseWRPdE9IQ0JtUDUyNGhPTHVBMWlQc25r?=
 =?utf-8?B?ZXlhRjNzdk05K1FhSjdOdE5iNHc3QVNiWkh4NEhZUzRFT0hEUExFREJZdVhD?=
 =?utf-8?B?NTlZb3gzWEJVTGFveHhnV2ZBQXc2M1gySDNSa0RRUzloSDZsbnowZEsvM1VV?=
 =?utf-8?B?Q1YvMGw4WFpmMlZyeVpXYmdjQm8xLzNCNlZQQkFxUXZCQnJGWGJVOXhjeUZ5?=
 =?utf-8?B?ZjVJalRLNWlZUWY0NjhzemtTWFg4cnhCT29YNEloZklZbGZKbHdBZmNKQzY2?=
 =?utf-8?B?a09OcjhHbkQvdHpHR2ZKcko2a1V5VkVSbjg4QzlsTGxZbHMxbEZmcVRqeTlV?=
 =?utf-8?B?R3RHN2JvN0pQeFNXZ0t2eHg0SWFrMmJSdnFnazBiY1czYlZGTDdHWSswdUox?=
 =?utf-8?B?Y2hvdytIOXlWUzdoaHV2SUU1RGhHZG5WeTBzclVJTUk4VFVMWHF2SHdPUllk?=
 =?utf-8?B?bzlqZjF6VDdwSFFMWGFqbjRkRzh5NnpYTFpVU3hNRG9mWk1UaU5iZStwZkps?=
 =?utf-8?B?QllMTnBnZzZjQzNWRWVSMTNpTXA2TVZJQnpZWFdFYkw2ZElIa2RyRzZoTTdu?=
 =?utf-8?B?UHBsWkNBUDZLQ0xTeVFYQT09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?N1JtMnRGUkhvbDB1WFE1d0VBS20rTE9rOVhKczVlL1NzazFPczROcDUyeHlL?=
 =?utf-8?B?QWl3TTN2VEtMKzRmckJkMkdzQUZKUkJlamEreEhoY25OZ1Z3ZU1wbUNUMkdj?=
 =?utf-8?B?K25FL1RLZkdxZWgzSW9mUEthYk5WRjRZSldFM2FsLzhZY0YwOWZ3aXZiT29t?=
 =?utf-8?B?ZCtXR3FhNXpUcnZpRTN2eXE2Um9EQmJKTmptSm1ocU41U1YrUElxYmhHVzJB?=
 =?utf-8?B?b2hNWFVOanZ5T2ZWQmh1MlFvWDkzaE9QUm0zdU0xQmFES3R2VHMvMDJkVHRW?=
 =?utf-8?B?UVZOdUFjeWk0aC9Menh2d1JiVWFHVHBOSitFNVZLY0ovU2FoakxJMlNuWlBz?=
 =?utf-8?B?T0xjMEJNWUxCZkU3NnZRc0I1YnVWUTJCVGZPQWpwd3lUdWd0MGZYTnFDeEV6?=
 =?utf-8?B?ejdiWGZtQ2pOcE0wd3BQZC9tOHhOYUp3OFhUK2JHeDRCdzNjV2UxY3ZPWG5n?=
 =?utf-8?B?M3RXby96UUZ3T3ZUekh0OGk2aHV3aThjVmdHTklvVmQ4TzdQOGRMTjIyekNT?=
 =?utf-8?B?RUhteWZkZy9IZUxXMGZVS2JHR2gxZlpPbkREbm11SWVGRlZhTFFNTTRVUmNH?=
 =?utf-8?B?RFlHZU1uZlhsY0htQ0FLaDdZaE9wNjBYYkZMR0ZlY1NieExOeDdOUENESHlU?=
 =?utf-8?B?MTk2MG1vM09uRXphbnNqNXVlZjVvMktmdmZGb3NYcVk5Yk1YVjQ1QUJrM05Y?=
 =?utf-8?B?R0pnajhuajArVFFNYnE2dmpYcUpIU2hadVBIOS9EdkRSbUUrRWhiaXd2cmZE?=
 =?utf-8?B?WnVLZVlyZFdZcUpDUGVmYzcrSGltamZUb093Mnc1MTdXZE44UzVGTkhkTUg3?=
 =?utf-8?B?eGh0d0Eva01Uai8wY083RktZYXA1eDNhTjRsQ2tJQnNCRTFmeGV6RjBNcHZU?=
 =?utf-8?B?YkpJanNWdVNoTTJyaitXSGNHVXNJQWtSQkN3VkJ4VGZRckx6djBqMStrVkRB?=
 =?utf-8?B?UTAySlhlaFdxQ2kyNlhoamUvUTkvT3NFY1JPREhRd0dGZUx4d25tdE11ZHA3?=
 =?utf-8?B?cVZZM0RaS1ZuRTF6eXBRclhvREpHUDZDYXZmWm5Gd2RxS1lVbXlHT1ZrWGhv?=
 =?utf-8?B?QTlNRXhMZk55TDRUaEVWMTRnRmY0NDhhMjFzRXFPN3hSYlBuQTNvaUpWTmNP?=
 =?utf-8?B?TU9EQkZUOUFVZm9GU3QrSDlLUk9UT24wcE5MVEpPc0RRMEZaemJFSWVtMlZV?=
 =?utf-8?B?VVRNbU5VaDVlaFJCVktXUFNCME1UWTNkQ1NxYjdMRFU3c3FiZG1qN3RtVFlj?=
 =?utf-8?B?TFVGeTNmQkxUZTUwL2dMQ01zT3lZeXVjdFNGbmY5Z1VIRmRERmFvbVFsbEY0?=
 =?utf-8?B?dzlEWCszbVlQc1d5YXJaalFWckdjK21aVmpMdmFYa0RJYzF2b2tGU0d5enFS?=
 =?utf-8?B?RFdYVDUwaElQa01EVHJqc0dRT2Q2bUJLbTFiY2dIWVlObjQ5NGVORU5ESXZq?=
 =?utf-8?B?NnpFL0pHeThFdFdoTm1ISWIvbUNQUEhMRVBSektyNk9QSGJuSDRMZ3FBR0Zw?=
 =?utf-8?B?TFVmTC8yS2NmdTlGRVNXckVPZHVRbXhLay96bHZqNkdZT3A0ZG1VNGYrTjRB?=
 =?utf-8?B?cmVOSWRuT3JRb29zaVVsb2czYi9kV1Y4aXB1R2prQ2VKaEh1b2w4NmIzQ0hu?=
 =?utf-8?B?ME9KSzdyTXRaWlRubzhoczlaLzhZNk5URlFPSmpBVU5sbTdXQis0NTJ4U1ds?=
 =?utf-8?B?UFNYdEdZMGxMYmJ2S1pKWXc3T0x1enYzL1dQTERyUEc4T3VxKzFZdW1ML1lS?=
 =?utf-8?B?RFl3RU1CMWNnaGp3UURlaHgrTGN5VDdBU1Jhdm1LS0pWS0dDT21NZjg2NUxO?=
 =?utf-8?B?TXFnSGMxTGFLRkl0Y1o3SFVSWDlqUUQxMldKTDMxZVRaVHgveGpWamJHSnJZ?=
 =?utf-8?B?L25XSzVGTTlHYjNmd1FZNTJZVUkzWWxJQmYrcnd5Q0pmTXlRWkpZTjNWYmw3?=
 =?utf-8?B?MUFSR1UzWnhJWHlKMG45R0lzbmVRVm9NT3ByNkZ5M0NUaDFmZEprNUJIR1pC?=
 =?utf-8?B?Um9GMGxBMHhUMVZLdDBnR1daRmFJV3R3QmdXcFV5MVRPamF4OVpsL0Zoa3E4?=
 =?utf-8?B?OVpCQWRFRUJ0VEtTODFndHU2Y0JTTXljamxxaktDK09LUU5VeHdTT3dZMzVK?=
 =?utf-8?Q?wMpY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75770439-22cf-4ef6-c35e-08dcedfcdf71
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:09:11.7458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewtlBa0fFXWdCg1c7kr6ZZMfWFGTiEM2u33t8eUptJFq7vLPX+S0S17lYeLSpwaJbh2IkMJVgKcmMSD6gMj5pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10789

On Tue, Oct 08, 2024 at 11:18:25AM -0400, Frank Li wrote:
> Extend the address status bit to 4 and introduce the
> I3C_ADDR_SLOT_EXT_DESIRED macro to indicate that a device prefers a
> specific address. This is generally set by the 'assigned-address' in the
> device tree source (dts) file.
>
>  ┌────┬─────────────┬───┬─────────┬───┐
>  │S/Sr│ 7'h7E RnW=0 │ACK│ ENTDAA  │ T ├────┐
>  └────┴─────────────┴───┴─────────┴───┘    │
>  ┌─────────────────────────────────────────┘
>  │  ┌──┬─────────────┬───┬─────────────────┬────────────────┬───┬─────────┐
>  └─►│Sr│7'h7E RnW=1  │ACK│48bit UID BCR DCR│Assign 7bit Addr│PAR│ ACK/NACK│
>     └──┴─────────────┴───┴─────────────────┴────────────────┴───┴─────────┘
>
> Some master controllers (such as HCI) need to prepare the entire above
> transaction before sending it out to the I3C bus. This means that a 7-bit
> dynamic address needs to be allocated before knowing the target device's
> UID information.
>
> However, some I3C targets may request specific addresses (called as
> "init_dyn_addr"), which is typically specified by the DT-'s
> assigned-address property. Lower addresses having higher IBI priority. If
> it is available, i3c_bus_get_free_addr() preferably return a free address
> that is not in the list of desired addresses (called as "init_dyn_addr").
> This allows the device with the "init_dyn_addr" to switch to its
> "init_dyn_addr" when it hot-joins the I3C bus. Otherwise, if the
> "init_dyn_addr" is already in use by another I3C device, the target device
> will not be able to switch to its desired address.
>
> If the previous step fails, fallback returning one of the remaining
> unassigned address, regardless of its state in the desired list.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Miquel:

	Do you have a chance to check this patch again?

Frank

> Change from v6 to v7
> - always use i3c_bus_get_addr_slot_status_mask() in i3c_bus_get_free_addr
> - ((unsigned long)status & mask) in i3c_bus_set_addr_slot_status_mask()
> incase status bigger than mask;
>
> Change from v5 to v6
> - fix version number, should start v5
> - change to I3C_ADDR_SLOT_EXT_DESIRED
> - remove _ext function and direct use _mask function
> - rework commit message and comments according to Miquèl's feedback.
> - change mask type to u32
> change from v3 to v4
> - rewrite commit message and comment for i3c_bus_get_free_addr()
> ---
>  drivers/i3c/master.c       | 65 ++++++++++++++++++++++++++++++++++++++--------
>  include/linux/i3c/master.h |  7 +++--
>  2 files changed, 59 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index dcf8d23c5941a..e0962a17de7f0 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -345,7 +345,7 @@ const struct bus_type i3c_bus_type = {
>  EXPORT_SYMBOL_GPL(i3c_bus_type);
>
>  static enum i3c_addr_slot_status
> -i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
> +i3c_bus_get_addr_slot_status_mask(struct i3c_bus *bus, u16 addr, u32 mask)
>  {
>  	unsigned long status;
>  	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
> @@ -356,11 +356,17 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
>  	status = bus->addrslots[bitpos / BITS_PER_LONG];
>  	status >>= bitpos % BITS_PER_LONG;
>
> -	return status & I3C_ADDR_SLOT_STATUS_MASK;
> +	return status & mask;
>  }
>
> -static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
> -					 enum i3c_addr_slot_status status)
> +static enum i3c_addr_slot_status
> +i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
> +{
> +	return i3c_bus_get_addr_slot_status_mask(bus, addr, I3C_ADDR_SLOT_STATUS_MASK);
> +}
> +
> +static void i3c_bus_set_addr_slot_status_mask(struct i3c_bus *bus, u16 addr,
> +					      enum i3c_addr_slot_status status, u32 mask)
>  {
>  	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
>  	unsigned long *ptr;
> @@ -369,9 +375,14 @@ static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
>  		return;
>
>  	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
> -	*ptr &= ~((unsigned long)I3C_ADDR_SLOT_STATUS_MASK <<
> -						(bitpos % BITS_PER_LONG));
> -	*ptr |= (unsigned long)status << (bitpos % BITS_PER_LONG);
> +	*ptr &= ~((unsigned long)mask << (bitpos % BITS_PER_LONG));
> +	*ptr |= ((unsigned long)status & mask) << (bitpos % BITS_PER_LONG);
> +}
> +
> +static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
> +					 enum i3c_addr_slot_status status)
> +{
> +	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_STATUS_MASK);
>  }
>
>  static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
> @@ -383,13 +394,44 @@ static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
>  	return status == I3C_ADDR_SLOT_FREE;
>  }
>
> +/*
> + * ┌────┬─────────────┬───┬─────────┬───┐
> + * │S/Sr│ 7'h7E RnW=0 │ACK│ ENTDAA  │ T ├────┐
> + * └────┴─────────────┴───┴─────────┴───┘    │
> + * ┌─────────────────────────────────────────┘
> + * │  ┌──┬─────────────┬───┬─────────────────┬────────────────┬───┬─────────┐
> + * └─►│Sr│7'h7E RnW=1  │ACK│48bit UID BCR DCR│Assign 7bit Addr│PAR│ ACK/NACK│
> + *    └──┴─────────────┴───┴─────────────────┴────────────────┴───┴─────────┘
> + * Some master controllers (such as HCI) need to prepare the entire above transaction before
> + * sending it out to the I3C bus. This means that a 7-bit dynamic address needs to be allocated
> + * before knowing the target device's UID information.
> + *
> + * However, some I3C targets may request specific addresses (called as "init_dyn_addr"), which is
> + * typically specified by the DT-'s assigned-address property. Lower addresses having higher IBI
> + * priority. If it is available, i3c_bus_get_free_addr() preferably return a free address that is
> + * not in the list of desired addresses (called as "init_dyn_addr"). This allows the device with
> + * the "init_dyn_addr" to switch to its "init_dyn_addr" when it hot-joins the I3C bus. Otherwise,
> + * if the "init_dyn_addr" is already in use by another I3C device, the target device will not be
> + * able to switch to its desired address.
> + *
> + * If the previous step fails, fallback returning one of the remaining unassigned address,
> + * regardless of its state in the desired list.
> + */
>  static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
>  {
>  	enum i3c_addr_slot_status status;
>  	u8 addr;
>
>  	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
> -		status = i3c_bus_get_addr_slot_status(bus, addr);
> +		status = i3c_bus_get_addr_slot_status_mask(bus, addr,
> +							   I3C_ADDR_SLOT_EXT_STATUS_MASK);
> +		if (status == I3C_ADDR_SLOT_FREE)
> +			return addr;
> +	}
> +
> +	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
> +		status = i3c_bus_get_addr_slot_status_mask(bus, addr,
> +							   I3C_ADDR_SLOT_STATUS_MASK);
>  		if (status == I3C_ADDR_SLOT_FREE)
>  			return addr;
>  	}
> @@ -1918,9 +1960,10 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
>  			goto err_rstdaa;
>  		}
>
> -		i3c_bus_set_addr_slot_status(&master->bus,
> -					     i3cboardinfo->init_dyn_addr,
> -					     I3C_ADDR_SLOT_I3C_DEV);
> +		i3c_bus_set_addr_slot_status_mask(&master->bus,
> +						 i3cboardinfo->init_dyn_addr,
> +						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_DESIRED,
> +						 I3C_ADDR_SLOT_EXT_STATUS_MASK);
>
>  		/*
>  		 * Only try to create/attach devices that have a static
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index 2100547b2d8d2..6e5328c6c6afd 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -298,7 +298,8 @@ enum i3c_open_drain_speed {
>   * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
>   * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
>   * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
> - *
> + * @I3C_ADDR_SLOT_EXT_DESIRED: the bitmask represents addresses that are preferred by some devices,
> + *			       such as the "assigned-address" property in a device tree source.
>   * On an I3C bus, addresses are assigned dynamically, and we need to know which
>   * addresses are free to use and which ones are already assigned.
>   *
> @@ -311,9 +312,11 @@ enum i3c_addr_slot_status {
>  	I3C_ADDR_SLOT_I2C_DEV,
>  	I3C_ADDR_SLOT_I3C_DEV,
>  	I3C_ADDR_SLOT_STATUS_MASK = 3,
> +	I3C_ADDR_SLOT_EXT_STATUS_MASK = 7,
> +	I3C_ADDR_SLOT_EXT_DESIRED = BIT(2),
>  };
>
> -#define I3C_ADDR_SLOT_STATUS_BITS 2
> +#define I3C_ADDR_SLOT_STATUS_BITS 4
>
>  /**
>   * struct i3c_bus - I3C bus object
>
> --
> 2.34.1
>

