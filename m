Return-Path: <linux-kernel+bounces-395125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E8B9BB8DB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FFE1F22475
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719751BC07E;
	Mon,  4 Nov 2024 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iFuD+KaM"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2078.outbound.protection.outlook.com [40.107.103.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAD1C07F3;
	Mon,  4 Nov 2024 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733823; cv=fail; b=MFlInGTe9++1dzfWfyrovnOQm362j0R+wULiA5NRZ7vnDLnOpdKhdh2VOQrf5ooBFoq2iySs7m8qO8aHrjsXlQLrkGnjEbookgR7UDO0FXim1mSPzaGs5Ly+ERCx6E+jZJci9EIuGNvEk0PpVVYujEi58lf1s4fUF+vSCerSMD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733823; c=relaxed/simple;
	bh=mAzNbzRWOh6wFu0SMI2UVtcJ4QuBAqfaQJrwAklpA20=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=e8Lto3Q2o1WdNxB92zsb42uTS5pXl+qkb78zfBwjCjcTVTcZE1bbAJJXVrcvCu+WLvGn97uAPmGfD1dRfJLXPXvOP805RuH1uik9FxzQI/0WEQmztKgzcQFTwFn1LG+L+pbB7p/YDptjofBhZN982UE2rxeSG5krvjdwJ6VbFPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iFuD+KaM; arc=fail smtp.client-ip=40.107.103.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sY8j//p1L7S6TC8RDJ3Ms4kYB8DUi0dV1JR2fErC6vrxDIEvVKsumksxkkHFZBcDB53y+K6Am5m2fHWj3mPEBXZJUDH6DSFIW0YqJqY0FhmmJ4/sRV7rjbbVRGdmOSlnOevbvLDvALOPFMhC4/7AK9erT4PJS/0Z/lmMBD08dGMdTJ+S5dx1iB9N0wmlXXGMp2goqaes98Vzvydy1KJOgpxgq3ODVSF4CSyK0u4bJCBFDcuC9jRdfcchtveTYT7n2yQYkXeUIoyWBMHmSSnQHJ1T0/wzXltB0meHHow8AmxM3UUkW+nhGzjGEWJFyEwmZkZUIisdnGtM9v10ZXp+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wK/QCHsvwxI5jajMDK5bmLW2wqApLKVfmMXXvNmjNTE=;
 b=TQplHTcp0OaMQitjTUt5x3UciwdgUifFC5lE96xWngHVDzk5zC2L4VNN9dlr3aqYH/20+tzwZDdTbudpQSDERMhJZUDEhsEIrB8BiPJt4yz9gtdFIjoarwl169NYXlR5Lcza/At2oUmtbZudWhCeSiLQlHk8F1TMUvdes5Qb5PUA6NYkjZDwV+6dhOqw+nT+PPtOSTV0ooudOmAnlEs531fyIsgho95xAh9bL5YyiN/ge0z1cAPeZ1IytZSAbHy+aMG1yg4bQN0GA+b29sb7QffkthRlE6GPjvLdck23TeTCa8+2MZGIuJV1JfmACybu6LlluLKvyJGxDd0EYcGMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK/QCHsvwxI5jajMDK5bmLW2wqApLKVfmMXXvNmjNTE=;
 b=iFuD+KaM7XLe7z/QC4HT40LPDlJBJmwVJ1u/6L4aKGwNQymg5D7Bv9iSspYc0xDE9jqc862KygffEhMIrvojaGryNg9pJWWfOnDIcze7YoJ+XBR0QW7eXA25i63B7fVpvhDMh2CrGJYIMSBUPGHGWPpOrojsdEKavU3Hjpuv2qT97H+WJdXWU948yxPLcE9Q7sbs+0Lt0xa2eLzAr79ogTytv1li8uxr0+bndMLOPueZIGzCxlX1Si9NTlx4+Obu1E03EAX9eKOZfre3r8L7YxU+hV6tTC5CPodWZhII4LXaYRr2VIgJnoDxyoK5GVUEPcuiCtb3JdH074DKpuG24g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 15:23:38 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 15:23:38 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Mon, 04 Nov 2024 20:48:40 +0530
Subject: [PATCH v10 3/5] arm64: dts: imx8ulp-evk: add nxp secure enclave
 firmware
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-imx-se-if-v10-3-bf06083cc97f@nxp.com>
References: <20241104-imx-se-if-v10-0-bf06083cc97f@nxp.com>
In-Reply-To: <20241104-imx-se-if-v10-0-bf06083cc97f@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730733536; l=2640;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=mAzNbzRWOh6wFu0SMI2UVtcJ4QuBAqfaQJrwAklpA20=;
 b=BwtpFkkyOcytse5DDIb/SGMFGXycJT9LT/bawrKHKQfcQ3IQdqFqwE2m8oT1pfwWj5UlHzgtU
 uk5TxsrqpYHAWb6RqCaM7R/siLtoxu8gZjyUfQYfzO9bxIF4tL7/9pV
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB9PR04MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ffb19fe-aae3-4e1f-5d94-08dcfce4a7f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmxJazN5NU0zNzVzTlp6Rmw4bk1zaVliOExpVy8rRytIUHp6bVAycGJwYnky?=
 =?utf-8?B?U2t4NEcrSUZRcVM0QjVScWROOXZTcDB1TnN4ZUxEQXNXS0NVZUJLNWpyc0NY?=
 =?utf-8?B?aGd2UUJCRjlVTzFHVkF0R3JWMi96YjQ3ajQ2SktXNzRpZmxKaWd3bmlkeFVu?=
 =?utf-8?B?NmFnVzlJL3ZOcHlJSVA3ZGF0QThmRm1mQUhwY1RubWtQOFhlREpJSFNLNWxx?=
 =?utf-8?B?RUJVRGJXWFZtbWRBcWZ4YzlRODhjSjZrY2dJM0tKTHJiU2NvM3dwNkI1bldR?=
 =?utf-8?B?QVRDQ29iSzhzc1RGNjJLZDBhTCtCQ1VsQ0dKT1k0cGY2U3U0VHBZZTc0RE1T?=
 =?utf-8?B?eUo4WUVSd1JtYi9HRlA4V0xvd2VMZ1dSQ3EzUWFOUm9RcXJidFR1Q2NxdjE2?=
 =?utf-8?B?c1ZaL0p0cmJVN1QwR2k2azNJYzgveXlMUnBMckpDUFNOeDBCTnJSaFR2QWp2?=
 =?utf-8?B?aUJMUHhHNlBCcHRZMzVNZW02OVQzQ3JySkd6L000MDZDQWZZbmlxd21oTlcx?=
 =?utf-8?B?RVA5UkMvOWNndU01TDNFWm9WeHdrZFd4YUwzUnpqNm1RNnEyRFcrblNRc2Nn?=
 =?utf-8?B?cXZlbmhzTVBmNWlXUHZjb1UrYVgrWWc2clRiNWpBTlJrVFhqNVlaVmZ1QjhC?=
 =?utf-8?B?U2FuOUsrRFRuZnFPamZKSVNZdVd4UVNseGd5d2h1bTRTbXdRK0hHUjRoeG1I?=
 =?utf-8?B?WlpVWE10d2lpQk9wZWorKzBmbUcvMTUyakRlUndrUUR2Z2hrK3kyUEZRWENm?=
 =?utf-8?B?TVVCRlhSQjFURWZzMkphQkZENUhZRHV2S2NrOUMySVJOM1luUXVFTXJlREw2?=
 =?utf-8?B?U3B2TVZYR2taMXllNUdnZkMxTkFSRXJNVktOdVE4a1pWZzIyd1Fya1NTSlVj?=
 =?utf-8?B?b0YzRk53UXJmRUtmOWR2TTdqT3U1bGwycStCSW9Xa0NNeWovajBxRHRUWGQv?=
 =?utf-8?B?OWFmVFJJTEZBSzB2eFJndGVobjF1ODMxZWxDL1d2UkRYY293cHg1YldhQ1RN?=
 =?utf-8?B?ZlV3MVNyTDFRQ0xlYmpNNHVPWHlRZzcxL09acnZDcll4R3RJUjlQSzFrNTlu?=
 =?utf-8?B?bDBsK1Jzek5OSEFFM2FscXY0QUsyd2dqclUzdmMrcjZYMmNveEtVM05GWS9D?=
 =?utf-8?B?TUpFbll5ZWdaYkVaWHNkVG5CUERKa1NwUGcxd0JFMUxBSGhtWHRuM3VhTWhS?=
 =?utf-8?B?WWR0SjhRNGZld0RKSEpHMnR4UEtaU1ZGYkFnWURUYkhFbXRNdHZ0Zk10TmNI?=
 =?utf-8?B?V1RhTVpjaEhyeDZwbWQ2UE94U21IWm9UUEhHMHdxWm9Yc2JIakJkMTFIbFph?=
 =?utf-8?B?UVlLS0Q5NkI1alZzRm5xSjhBWm4yZHZBZGJaWE9SNzRvWHBuL2VDVm8xTm0r?=
 =?utf-8?B?bkRMc04zWmFodC9qd3NlVDVoQnpjb0J4VWhzdllBRTN3MkNUSDA4K1FvR2ts?=
 =?utf-8?B?YWtKblJ5U0pWRVE3dTRvZ0V6M2N2YzBTQ3EvcHk3eGRHdzlMT1BjbGd0SFdk?=
 =?utf-8?B?SlYwSnluaVlMekhOUURRaThXOThjOGlHUjUveStQQndwVmQ4WU9TTGJCSThZ?=
 =?utf-8?B?cFh6WFcyOU92b0VXV01WZWo4UmhRam5hOGhHWmdRU0lOWDNhR2puK3hoV0VJ?=
 =?utf-8?B?bGZVcXJscE1Pc3QwbHgySHJBRnlYci9QWVhoMnU3OU1iall5UjhJaTljV0ZN?=
 =?utf-8?B?Uzl1QjRRK3lBbVFuTkUwNk5hd1RqVVBtN2xkWW9uYWV6L0RhL0RBaFFaOEF5?=
 =?utf-8?B?eVd1Z0dnbzlmLzNRckYrbzV6Y3I1T2p3VWsydmNlckhCVjh6Y0phYU9TQzN0?=
 =?utf-8?Q?Ql7OaK516Bqi/pjOG5hoZq6w25fjoiN2qhm/4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWVEZFdFbStQMS80THhPdm85V2lyZVM4MHEyQkpWN3lUUmhXdEpHRFRveTEx?=
 =?utf-8?B?ZnBQNXYrZjZickRDR0IxNTdySElHWUdxTnMzSzF2SHV0RGE2Wng1N01EdEF0?=
 =?utf-8?B?Mm5hY2k5TzZPQlhZd3FESUM2ZFcwTTdVUlFwcVpCNXFhcFgwaUVzVEtDMHN1?=
 =?utf-8?B?MXZPb1QzU2RPRXBMSHk3NXpPQk1yNy8vZ2pVS3FKaFJVMFZlVUVRUWZFSUda?=
 =?utf-8?B?bStydHlyYzJrWkY5ZUdtcGNiaTBsNlNYcmVGamZvM3MyMUx5Y2xIOVJlYi83?=
 =?utf-8?B?TXpXVkZCdUlNSnpvUDhiNWRzc3Z0NkdRbmdmeFdMRHgxZnVHY1dqUm9jQStE?=
 =?utf-8?B?SmNkRmZHZFZNU3lXNzBValRIanhtdzk3YWxFVVgwelN4WVl4K0prdzZWbWtv?=
 =?utf-8?B?dFB0ZHRJWGhUUHlJT0hia0hVUCtiR0I2REkwcldzNWVHaWJJQm1RT1IwSnR5?=
 =?utf-8?B?VlZXMmRiQUpkVXlXVlVVL3ZIaG5EYnBRTUdWTExsZ1hUdUE0VW9PSW5ZNFNV?=
 =?utf-8?B?KzRFRGhiMVF1ZkJQUHEvelQzWXprb05Qd0pKU0szNmorMGxYRTltS3RSd1VN?=
 =?utf-8?B?YzRDV0NoYjV3dnZESkJJY3hQNjZTL1A2empyTmFUY0VabWsxYTJmR0tkNk5o?=
 =?utf-8?B?L0o2Mi9ZWTRrUVVra085bmUyWkN0RVBMZ0duRGk2bWVWQTlkRk0vKzNwcWRQ?=
 =?utf-8?B?cmdkM1lLc3ZNRHlJd2lYUTZiNklHYUlPU3U5TjgvWE5SdDJsQVBxb1ZjcnpU?=
 =?utf-8?B?b3J0aENUYmcrOUhRa1BEcCttWDBsTXcxbDBNZUdmd2p3L0ZOWFliZkdwRG5W?=
 =?utf-8?B?WlRrNHpDTjVOc0ZrL3cyVUVPWVA5V0FadU9FRjVQUWVnc2Fjc1BRdzVqbVBY?=
 =?utf-8?B?V0dKaURDZVViY3Q0Z2dERVJiZGFtK0JKRjlQZUkxVHoyRzNnYWZpTnk2Undi?=
 =?utf-8?B?YU9HOHRKNWJjRUd1VlJzMWNETTRTUVJ4RXo3UWRnMHQ3OE1RVGFxdHZEVnRw?=
 =?utf-8?B?Zm92TWFsdUdhSnFpSGpLVUVzcm9oNmVRL2VaUVRPL3JoYzIwSkl2QTZxWVJv?=
 =?utf-8?B?OUl1Y0ExY3JBcXBQOTdsdldBcDl2RUt0c3oxK3lzYlNad3pjWmRudk1LQVlG?=
 =?utf-8?B?QnUraWZFYkNQM2V6M1ltMEJFMHdPaUFjaWJ2QW9EZUVxQWY4aVpOUm00eUNL?=
 =?utf-8?B?anR4L21GZFRaWUt4NjNYUTJJcVVWS0tDcTNXTTkvdXE3aDBnNWJPNWxPU0o0?=
 =?utf-8?B?bHNEcVVheWh6NkMzelkvK1kzNkhoa016dUhBNjJ5b0VFWmgzNnNLQkxJSURh?=
 =?utf-8?B?ai9VSElyYW5zdUxhMXlEWExtZWtJMWx0YXhnWSsxdDhwVThsc080c28rTmk3?=
 =?utf-8?B?d2tIMXVDRVM2SmI2ZWZLK2tORVhkc0ptSGUzL2dkdkxJZ29mNStLeGVKSHR0?=
 =?utf-8?B?ZVlKbUdCd2hYQVBLM2ZIY1BwSUh3ZThWeWlLeWZvbzQrdGpNS0ZrTjRKSFdH?=
 =?utf-8?B?RXNMYjg5THRkZUZsRUs4Nk1OeUhaeHZJTUp2Z2Uvc0lRZmw0SzFJMVBvYXF2?=
 =?utf-8?B?L2ROVGFLZTVTQTZ0RXRBZ3lHMFJSODFKeUZqMENzSHhQVkhDQnZ4VEJONkRN?=
 =?utf-8?B?djFYc0hpWHlJYXJCSk5oNUc3RHZDY3l0akM3cXAvVjZsQzRWUFBaQWxseEdq?=
 =?utf-8?B?S1ZCTU5UN3p3clRwMU5QTnJ1M1ZtaWFqVXorYW5zNE9pTE41UmpKUmpmU2Nm?=
 =?utf-8?B?anNoR0ZMOVg4VVBlOTJhdDFoZWRoMS80dDB0WS9NdzEzKzYvQWgzRzk1TDBP?=
 =?utf-8?B?MXpZU3huenZma2NpZENXWGZrY0J2SUtMVEo1M01DMHNZU1k1b0x1V0lBYWl6?=
 =?utf-8?B?UGIvRUYwNTRneU1ndGg1OWhBbUI1L3J2Q3d1VVFTcFNOS3ljTy93OTZkeE4x?=
 =?utf-8?B?NVZRUTNZd2R6eWVxUFBob1NpdkRidWFweDczWDJnTkl6Tmx4TkhjVEs1QlhV?=
 =?utf-8?B?cmx4T2djWmdOUWg5NmFscm1ETmsyZFdsaE1RVnlqM0hMbU9Xb2RJbno3dUFN?=
 =?utf-8?B?V1RjNkxJemNldG1BWC8ySFBPVE1IaEo1TXM5ak5jMWxHK01CdFh3WWZxYkp3?=
 =?utf-8?Q?/rERdEn5awbCiJE5JcNKs6fVl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffb19fe-aae3-4e1f-5d94-08dcfce4a7f6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 15:23:38.7134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6o6wJw3tPG5x5aWjvGiHXN/oKYGOzmqvKWTEOCQSLt6J7Z+TUZRCs6f1U1rgoilCc6QuqyvWcdLQjPvix6fmiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9451

Add support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx8ulp-evk.

EdgeLock Enclave has a hardware limitation of restricted access to DDR
address: 0x80000000 to 0xAFFFFFFF, so reserve 1MB of DDR memory region
from 0x80000000.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 17 ++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 13 +++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index e937e5f8fa8b..f5963f4043c4 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 /dts-v1/;
@@ -19,6 +19,17 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ele_reserved: ele-reserved@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+	};
 
 	reserved-memory {
 		#address-cells = <2>;
@@ -204,6 +215,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&ele_if0 {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index e32d5afcf4a9..f98629b7f4cc 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 #include <dt-bindings/clock/imx8ulp-clock.h>
@@ -152,7 +152,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -167,6 +167,8 @@ scmi_buf: scmi-sram-section@0 {
 	};
 
 	firmware {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		scmi {
 			compatible = "arm,scmi-smc";
 			arm,smc-id = <0xc20000fe>;
@@ -184,6 +186,13 @@ scmi_sensor: protocol@15 {
 				#thermal-sensor-cells = <1>;
 			};
 		};
+
+		ele_if0: secure-enclave {
+			 compatible = "fsl,imx8ulp-se";
+			 mbox-names = "tx", "rx";
+			 mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+			 sram = <&sram0>;
+		 };
 	};
 
 	cm33: remoteproc-cm33 {

-- 
2.34.1


