Return-Path: <linux-kernel+bounces-363346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F83C99C117
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED54B24629
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A406C13D243;
	Mon, 14 Oct 2024 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NBHLEHGa"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2066.outbound.protection.outlook.com [40.107.241.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75714885B;
	Mon, 14 Oct 2024 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890276; cv=fail; b=ZOKz1vNjAeDVHmIF2uLdouE/69jx6RNA2aJuAG/tiZd6VOTiz2hojw1EuRM3PAHx1YT8w9ncCWIL/k3rqSUHFA6098B4xqHifej2toju1DNIHAYkrvAe6mHtrwRWeRoauGBXuaMzWkp9Wl5+xxKaoouWYJNxBy8XtRk3ukkEWnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890276; c=relaxed/simple;
	bh=mCz8lOf3F3mECJEALNPua9Qq/vCPw21efSiaFCjdj2I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M0hMZGMNuXJ11n3HYcIN8X1E98jc9ZDxtpfgmaq4vHKwUWhKZKTgIDBKOCSyHpXh1vrua/471JlrGB9SewIuJYzQdCnS0Id4Wrm5d0XpMIQsliwOcB3Lq6Ep2WIc8M5McDEX53tnVbe35zlbyRs6Il0H4adxwdH++igFwOSVoeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NBHLEHGa; arc=fail smtp.client-ip=40.107.241.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGv82TgJvF7SZgKMjlzvm/Te0DOpyo2QdKA2VFJTmv2+LFPV2CVdfJGBQ0EkSZifKvdjWTxTIsx9ytidVatvtK8HDIbhU+wRpWzrDTFjE9h5jJNp9N0xd87gPFlx0hcpfOixw10gwHLr2WmcLNbSIbb4uTlgUjg3AFF/zHHayXY+12mhsqq2uJ99pyhi5VUHzsnY8/5+ByUneVXHpoKUcIPD5Pe/QYNlsi51IbyGAW9M/7CX5gpyTYg8a/Y/7HK3YgEnT6K/T5LYQZm0BdMsJwISovDT5ln97hZxXJXwWOVRzLKu1dVPIlGCfOIOBUykehyHMWf587KQFt6UbQys1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kf17/RUh2DAdbL9++vt1Arw2Bwo/2tZ1QU2/B9MnmBs=;
 b=cJseMQZNvEYLxvIl6vpOuA3hE6TxcEcRRea/1I0ATmYeh2kmHy4CnYYY8X4SWP+BKUaK5MlRRBZS0Tf8so6DK0c5B7mgMnd9l4r6o8i/TssItHn2jOMaJFv75/GEo10QVo3TPFi34rgJ9BzyUMkMM6bxkd6iFVGnGvHoobtFO46wvjyZ5MZJ6z3hc4eTLygq5Y0xd80EyQBfE3w6A1RzSsAkOn3rRpKEpyZOtEoTtAWPyEf3p+OVb9kv2eeMbHKalwz2Wvcvwdj0Cdq85HBgnbmgK60u4I+YU7koRc20d5Pmf9hbjxjmC8trPQvu+bOCxh5VZxKF6gKsBFj9Rz13AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf17/RUh2DAdbL9++vt1Arw2Bwo/2tZ1QU2/B9MnmBs=;
 b=NBHLEHGaULvJd4HJzKnHgOELWyicXMLsOzFErmw+a7Nckci/t3Rlrc7JHKZ5x6Q1IyD5OJyE34CxPoi2boB7CxO/3lTYZh/yrVbnNg4ASFYq9b/GEqNSJE99jcKw9N1ORp2mkwyEBZ2H85lESRXE5Z4+4YgadL9sNV4VirGauJyKUgO41ZmauBoF2bR9mBuWx+JtZXCTFDrV7EC5RSiD8Dpkey3JO/vBO9zivPeAxN69TWE6wkR5Y8MQIgdjUUhcq/MRfSWuwhQS2WS/h8tne53i3Jijiio0zQMolrHpn6OhR5NVAm6YM038B89WNFcqaJ3SUwOJBEXIP3SaJREbHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA2PR04MB10515.eurprd04.prod.outlook.com (2603:10a6:102:425::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 07:17:51 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 07:17:51 +0000
Message-ID: <f47bc3f1-20d9-4f7e-acdd-85eabdb8d743@nxp.com>
Date: Mon, 14 Oct 2024 15:18:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] drm/bridge: Add ITE IT6263 LVDS to HDMI converter
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org,
 quic_bjorande@quicinc.com, geert+renesas@glider.be, arnd@arndb.de,
 nfraprado@collabora.com, o.rempel@pengutronix.de, y.moog@phytec.de,
 marex@denx.de, isaac.scott@ideasonboard.com, biju.das.jz@bp.renesas.com
References: <20241012073543.1388069-1-victor.liu@nxp.com>
 <20241012073543.1388069-7-victor.liu@nxp.com>
 <dtloyyghjep5rm34qjjinvhvrar5jzj3n24czvpdmnkfesntjq@t2uijuez7myj>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <dtloyyghjep5rm34qjjinvhvrar5jzj3n24czvpdmnkfesntjq@t2uijuez7myj>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA2PR04MB10515:EE_
X-MS-Office365-Filtering-Correlation-Id: da4e45a0-ee56-4442-6856-08dcec205040
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?blRoZSsrM1JISnFnaWk3QUFva04yaUNsVzZuUmtHSGMyam5GdW5kL01pV0VU?=
 =?utf-8?B?Sk5oMUNLd0lMdUI5djJkZm5FR3dQbDQwR0NwMldkSUVMUzRVWWtKbE9mejJT?=
 =?utf-8?B?a3N0NFdGMHgzaWdkdG1LMTI1UkcvcnBQYXErK0huWVI0Sm1QeU5oTWQrM0J3?=
 =?utf-8?B?NGVsOXRpaXZ6eGxwWjhxRkNwUmpYdkdWMFg5OUVRV0U2eTRFbStDcGQ2OEVx?=
 =?utf-8?B?V1JYQnRid01ienI4NVlFNzdlcEE4UzhwMzROTnhFNCs1NkVGT3hhRWVNMDM1?=
 =?utf-8?B?WjViWnVUcE1VQlNWSkVGMjlBSE1UcDB4YTRKdnZIeU0wNjl4dHVGQjFqYk1n?=
 =?utf-8?B?MXlWL0o5cnJxN2E2NWtleWdTclVkZjA0S0c2ZGpJRm9mcHhla2VvekczL3JZ?=
 =?utf-8?B?cnduS0VIK0xzbVpBN3R6UU5HZExTSGNFdGhjeUV1djR1OGJSWFNUK3A3WEI5?=
 =?utf-8?B?bVJ3REVrSFVzK09zMDlCUlM4eVQ2Mmd2ZWIxeEtVVXFpaGNQZEpRZ3dPRUdI?=
 =?utf-8?B?dGJpbnlLaHhpQ3dZOVpxSzhiQXBSU0pHcjAvSXJWT0ZNWXJ4MTE5L2EwNHBM?=
 =?utf-8?B?Rlc1aVdNRW9VVHRHY2ZOd0VuRWJKTDFYQlZHV0tyallvNGhyaGhFUGZsK1k2?=
 =?utf-8?B?Q2U2Vyt6c1FRRjhTaStHa2NRZXpKWjZ6WktqRjc1cGRSYXlpSjdCVncrNndZ?=
 =?utf-8?B?RFZpWnhqK3NJdVpZMmVkSSs1ZFZOeVBjYlJOSGY3UmgzUE42NHlnOE11SDRE?=
 =?utf-8?B?dXZkQlJYWkl1N1hMYllLU0hxZkRPTDJpbHpNOXJoVFNBcE4vWUg3ZXlBendK?=
 =?utf-8?B?WmpMZE45cDZ2cTVHc0tDUi8vVnBoalRoSHBYMVh0Ui9vSkJzTHczSTM0RjlW?=
 =?utf-8?B?Z0ljUEYyOXVNaVdWM2VoWE5xY2VDYzNIYUFRcWVuanR0RlpNNTdtOXU5a3JT?=
 =?utf-8?B?UFRtR29rcjVUV1dLdlBObEl1cUp3aXZQZEJZdG1EYzlWOGxJajB1djVjTUx0?=
 =?utf-8?B?bGpxc3hSK0lBWkJJOHNudDNQcEpkT2N5bmJUTWZ5R1BVTjJtSTdZT0FLTkp2?=
 =?utf-8?B?SThvYk8rU0Yvak5RaXR0dUVXek9sL0IxbHlFZEw1K2RyQUpLN2FEcjljcVFR?=
 =?utf-8?B?TW5TOFpwODZQUFdIcnR1VUFGdUNZbExHdXFOUS9ySnp4WlFKZGpsK3F1K2o0?=
 =?utf-8?B?V3F4eVU4R3FueklTRnRMeGw5U3cxd0Z1cTVaQmtJaGUreVRHbE1kWTRVdUp5?=
 =?utf-8?B?aktDNmNwZENpdUFISlRGcyt5RVpmWnNZdFVtNWFzMlI2SHpwekVyTkhKY3dW?=
 =?utf-8?B?N05PbUhrRy9rcy8yU3Z0elMwVkd1SUhDM25IVGVMRS8rbVdqdXFndFZmc0dX?=
 =?utf-8?B?VHFTek5RTnA5UnkvNm4zbmZzZCthblRWUnFodkdncDZnTytVQlh3bWdORGtJ?=
 =?utf-8?B?ZzJBZExEdDROQVE3TUpvNkYrSjBwOGY5cWRKSWJ5a25oT1RBcFVSMjRlbUNO?=
 =?utf-8?B?WkorQ3NKRkUvV0xjVXFIV2FYQ0xma0ZrTitTQnJ5aTlVZ3RkMU1XV3lpbHBp?=
 =?utf-8?B?dm1YYmdPdmJHS3hraWkvMmpIblFmRVQyK3pxdjQ5M3hzYlJlckZhc1lNalRi?=
 =?utf-8?B?QjRraEdTVlpWWWcxdmhrR2FSUWZERjNqdXp2Kys3cnFWQThJVlVvVVRkZ1Rs?=
 =?utf-8?B?RmdvYndnT0NjdDVORVMvV0ZvK01jMXZLanJFQ0xiVUFqY2l4WVhUYVJ3PT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cFBXQUFSTmJNS3k3STJTaGdMVUNQRGxOTEdZVThESDUxZTNRYmkydFNNRE03?=
 =?utf-8?B?NjlMdTJyMkM1NXorY0RJcy95cURmZmkzVW1TMU5PL0Y3ZFc4YTRteHRjOGxv?=
 =?utf-8?B?L01VV1hNUHNCbTBKMUJiL0c3YTEvcmNlZnRGSHVRK2RjUWs3djAwaFNIclV2?=
 =?utf-8?B?V0JKUzMrV3ZzMTlWUGlPcjgzYVIydE1ySzhaSDBTUFdVUDlBL2QycVF3UVhF?=
 =?utf-8?B?TDRydDNIdkhjYkZ6VTJoZ0hqSFRQbkZMdHhHaUtRcHRQekRJRGpYaGJqWDJ6?=
 =?utf-8?B?NDVzeUU3SzFLS2dNYXAvYlVWaEF2VUc2UjFIWEVaMG5Qa1pUQVd3MDhRYTVX?=
 =?utf-8?B?UDJVNWVNd0hJTDlpQkRBWTNsQXFCMGxqVlJxUVdZUEhIT3d5RVZBQkRUZGQ2?=
 =?utf-8?B?ajhvT3NCTVA4S25xbnZ3M2ZVWnBleC8zcHNvNGFGODl3NU91dldISmRPMWQ2?=
 =?utf-8?B?UEJzQzhvS2FSMXRHSlNuZEdhQkY0RFUvbTFQL0tPQU5lUFc1TkE1aC9FMzdK?=
 =?utf-8?B?TmJzT0QwN1R0R2lITGhyOCtsUzNLaWN4WGNXdm40L3IzTFlpTThaVEw4RVhG?=
 =?utf-8?B?dzg5RFRkSmhiaENnWGVXbStjTU91d3ozQzdNQUsrN2h1dy9nZUowKzVHcU9k?=
 =?utf-8?B?QmJnLzJKTzU1ZFoyRXc1KzcybVo2U2FJTWFFdmNwVU1uZXk5ZTZGTHNueW42?=
 =?utf-8?B?ci9ySGFZSlNCUGwxaUFnNkx6cWlWU05GTlV3YnZCUE1GaWFBUFRJeXdQaDFJ?=
 =?utf-8?B?cDlVSFd3TkE3RXZVREhWcm1rU1RhUytPTGlUblBZalJITEZ5STRLQS9MNndP?=
 =?utf-8?B?VjZnbHZIUDJuWWN5YmhsR25LeWZNMEY2U3BoSlM2MW1UOE4reGxEQW0zeWhm?=
 =?utf-8?B?SzR1WVZ6VHpaanVScU1iMmVKdTg3Wm10TU4vam5WY0ZVQ0ZkZ0NzRDdjR1pO?=
 =?utf-8?B?a3p2dnlXUTFYUXNiWFQ2VEUwbkRabXZjRzJJQm1mRGhkaVpJdXhzZ05BZjZZ?=
 =?utf-8?B?WndsWkFIUXRHT2lNeFVYbFlUNTNiYUNONEFCbWZSQTczT3B0MnAvbzVJTFlQ?=
 =?utf-8?B?NlZZVWZ4SXRLTmtWNllzb0o0S3lSdU1XRWdQRGliNk1Pd2lZTnlVbnVCTTNy?=
 =?utf-8?B?cXdtSjR3dU1mT0JnV1EzQlZUOStReFpXSi9sNG9xUDZqU0VMMjRDKzAyQ0Za?=
 =?utf-8?B?cDU0Nk1JWnF3a0xhSmJNYjEyQXQzdGZ4ZS9kdjdpR3NrWlhqNFlVMXdoV2Qz?=
 =?utf-8?B?ek9XOU1MS2lvTVYzUFpzelJTTTQ1emE4WmNXVHBXeE82N0lsVEVHeGRmamRS?=
 =?utf-8?B?Y3JyRGIzdVZWNVU1SmRocXd5Um1WR09Fb1QwZUdpUklvdjdlQU1GKzR1MXYz?=
 =?utf-8?B?ZHlyQ1MwZ3ExbWxBZ2hFQWJoRno5MkhJczZRdjhOR1Brd0ptSGQ5Wm5yWkw3?=
 =?utf-8?B?RFI4di8zWENha0lrQityWlVxZzIzdUJaL3lnSWZTYW91TUZjTnJmbllCRFc5?=
 =?utf-8?B?Wm5zTlRjSmw3a0F5OWYyNXIwdjdpWUM4Q3liSjh5bGdlbUxWMmhqSXhvZkp2?=
 =?utf-8?B?eS9XS1drRU4vQ2daYllaSHFIek1kUmZrTm9BdkVlVnVMeWlwNzJmUWVEQ0Nk?=
 =?utf-8?B?SWNHYy9lRm9DS0NGbHFsbE5rL2tqS0QxbWtSbmdWMy9MYjhvdDVVZEZXaTJQ?=
 =?utf-8?B?aFVXZ213ZkpvL3BaRmd6WklLWTd1SE1XWlVjWGF3bTdobUZ2dDU2NjA2M1RS?=
 =?utf-8?B?Lyt2VG9Wc1cwdllrUzdJN2JLTkhGckR4Mm9uOXRZOVV3MUpYcTdhK2R0MEI0?=
 =?utf-8?B?OHg3T3hEb0FxU3U1K3Flc1hPNWtHd3ZsUlhaakdYdmIrU1dwTWtXekNiOWtu?=
 =?utf-8?B?OGZKcVdLZVRscGVVaWMrd0FMUUhQdmNrRnhNM3N4ZUZEV1BQZkZKa0hUcjRU?=
 =?utf-8?B?andjNm4xYWgvcVRUaE4ydWZQZUxOdXVpR0FKSWVhQS9nS05SZEZJR1dyK1Nx?=
 =?utf-8?B?ZWMrNHRHNGRuZ0RPaDBaVGhjajRNN0FPUG91dC9OVDliV29ibzJEKzBuc2V3?=
 =?utf-8?B?cnFsL0k2dmh0cnhSNEhCeHVqVnBhNlpMV0QxaUhFMFNxZms5SzYyczJCK2ZI?=
 =?utf-8?Q?PRYT9NIhXsZqM3vBQ4rUIMjkC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4e45a0-ee56-4442-6856-08dcec205040
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 07:17:51.2139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pw/A+yCFi0Ei6jMO2q09dx8wLJys+BZOxxst14ZQo8Yjr/lKef2vToUZumE4LmKG0z6b/hnkVnDn9wQsDAD8cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10515

On 10/14/2024, Dmitry Baryshkov wrote:
> On Sat, Oct 12, 2024 at 03:35:40PM +0800, Liu Ying wrote:
>> Add basic HDMI video output support. Currently, only RGB888 output
>> pixel format is supported.  At the LVDS input side, the driver
>> supports single LVDS link and dual LVDS links with "jeida-24" LVDS
>> mapping.
>>
>> Product link:
>> https://www.ite.com.tw/en/product/cate1/IT6263
>>
>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>> ---
>> v2:
>> * Add AVI inforframe support.  (Maxime)
>> * Add DRM_MODE_CONNECTOR_HDMIA.  (Biju)
>> * Rename it6263_reset() to it6263_hw_reset().  (Biju)
>> * Check number of LVDS link data lanes.  (Biju)
>>
>>  drivers/gpu/drm/bridge/Kconfig      |   8 +
>>  drivers/gpu/drm/bridge/Makefile     |   1 +
>>  drivers/gpu/drm/bridge/ite-it6263.c | 919 ++++++++++++++++++++++++++++
>>  3 files changed, 928 insertions(+)
>>  create mode 100644 drivers/gpu/drm/bridge/ite-it6263.c
>>
> 
> [...]
> 
>> +static int it6263_parse_dt(struct it6263 *it)
>> +{
>> +	struct device *dev = it->dev;
>> +	struct device_node *port0, *port1;
>> +	int ret;
>> +
>> +	ret = of_property_read_u8(dev->of_node, "ite,lvds-link-num-data-lanes",
>> +				  &it->lvds_link_num_dlanes);
>> +	if (ret) {
>> +		dev_err(dev, "failed to get LVDS link number of data lanes: %d\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	it->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 2, 0);
>> +	if (IS_ERR(it->next_bridge))
>> +		return dev_err_probe(dev, PTR_ERR(it->next_bridge),
>> +				     "failed to get next bridge\n");
>> +
>> +	port0 = of_graph_get_port_by_id(dev->of_node, 0);
>> +	port1 = of_graph_get_port_by_id(dev->of_node, 1);
>> +	if (port0 && port1) {
>> +		if (of_property_read_bool(port0, "dual-lvds-even-pixels") &&
>> +		    of_property_read_bool(port1, "dual-lvds-odd-pixels")) {
>> +			it->lvds_dual_link = true;
>> +			it->lvds_link12_swap = true;
>> +		} else if (of_property_read_bool(port0, "dual-lvds-odd-pixels") &&
>> +			   of_property_read_bool(port1, "dual-lvds-even-pixels")) {
>> +			it->lvds_dual_link = true;
>> +		}
>> +
>> +		if (!it->lvds_dual_link) {
>> +			dev_err(dev,
>> +				"failed to get LVDS dual link pixel order\n");
>> +			ret = -EINVAL;
>> +		}
> 
> Please use drm_of_lvds_get_dual_link_pixel_order(), it validates that
> the DT definition is sound: one port for odd pixels, one port for even
> pixels.

It cannot be used, because it get the pixel order for the LVDS
source not sink. IT6263 is the LVDS sink.

 * drm_of_lvds_get_dual_link_pixel_order - Get LVDS dual-link pixel order        
 * @port1: First DT port node of the Dual-link LVDS source                       
 * @port2: Second DT port node of the Dual-link LVDS source      

> 
>> +	} else if (port1) {
>> +		ret = -EINVAL;
>> +		dev_err(dev, "single input LVDS port1 is not supported\n");
>> +	} else if (!port0) {
>> +		ret = -EINVAL;
>> +		dev_err(dev, "no input LVDS port\n");
>> +	}
>> +
>> +	of_node_put(port0);
>> +	of_node_put(port1);
>> +
>> +	return ret;
>> +}
>> +
> 

-- 
Regards,
Liu Ying


