Return-Path: <linux-kernel+bounces-254431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81C7933319
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6911F247B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3712A13C80B;
	Tue, 16 Jul 2024 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="KO696+ja"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023087.outbound.protection.outlook.com [52.101.67.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E507580C;
	Tue, 16 Jul 2024 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163175; cv=fail; b=RNBH6lMWELBFTbXrDPmuMsgieQ0YRI26GKqd9m2/Vf20tdX8/OpLvDRq85xstoRHjPRILa3XAtW2iOy6YtsGURt7+PAtVwnw0ymC3VNElb8oXVVUKR8xS3flXsmuUbgqRaN1+Y0iklGrwVYsFulYsmVegpJxowyvTR5gj6RRq7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163175; c=relaxed/simple;
	bh=8OsJ7YBGk3EZJ8wXfjN1rhuCSdOY5+obH88N7lCFavA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UWIadiO6oSGMSz/+unl9kVBx+FS7xYuUMZlNQkLY87d5vDIcKheMQnPdAMmUKJNoRTRNNYdx80uGpNkfsBufdm+B28zlW71TbQtZoTizgLzy4ufJG9tz0IVOqZdK9dlTCvOtic3tMyrKJyNXTsxJU4U/F0xplU1UG4CqWhMHQgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=KO696+ja; arc=fail smtp.client-ip=52.101.67.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLFV+kO6hUFNLOgqv4sejJEmBsJBXUw3qaPdCy8blBNWOLuL2TVuYR3voPta1V9sZr2d5iNdFi7rUiTaMU9qhXqoDM9EDqjCVcy2oXOqG/9+bRupUzvxcNZQASBN5oZMd5zbOybQR3nHmi8gDvEAod/OkrXx1ooM28sLrRIRfvWoU2yVe3pEYNyinGU/uTJypRnj1zGTFzIPMjAmdOKLIU59vqJr7MFiDQETSgi2xD9Dp+LWiY5pdKt4mPxuMEtIuk6c0IuTbvosxPjWj7QLCVbcRw7n7okucgQsmuO4KLWfw3alS1Srutfrh4GAI15hGKMsz1MToWnH8bn020jX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnO1br3YbOnp05EKB+1CCxppNWloB0QOTZNpNYg4YjU=;
 b=hU3A8Dijw3Uv1BJYUz9iSt/mb7OrTYe8Xlj0UFAVVHbBXQt0NPDinGOvnnf2jrbmY8xamBkl1MtnfrNPANDrnC0Cs/bfIT+2Mt0yuLdFCDjjngkff6evygE6df9/4uK52UY2zsruJd+Am1eYjs5r8SR8zb809bgVoArNqShMXBIbESDG66X5M1Yb7dr/8Shra1gkZkETXHtMun35bzpdU1Kwr8+R9fBJ4xmC9mOdMsRaVhI7RisVryUiJIMaX0UtrD/1+HCYB+4pjPy6JJsqUvDNq2ZsXSw2lSFMuEmNiaj+7q9PdQObDi1OzCrKcI1+Uo+fLBgwU4k/QzYvlmZICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnO1br3YbOnp05EKB+1CCxppNWloB0QOTZNpNYg4YjU=;
 b=KO696+jaQZte5Zb9y/NN6R5JZnvlLNuDN2skmlteYIRvu1PYdfes9faCpjie/5qf+jJIEQbrIC5Lh5TzPRH5oscAnK1vCxrJ0Ez2rwD+2dyW51MoWAw0ltj+D4VtfMIma++F6Kyurl2vZyroEZx8iYV0lWv+PzNuOYS3F2BsMhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM8PR04MB7907.eurprd04.prod.outlook.com (2603:10a6:20b:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 20:52:45 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 20:52:45 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 16 Jul 2024 22:52:39 +0200
Subject: [PATCH RFC v2 3/4] phy: mvebu-cp110-utmi: add support for
 armada-380 utmi phys
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-a38x-utmi-phy-v2-3-dae3a9c6ca3e@solid-run.com>
References: <20240716-a38x-utmi-phy-v2-0-dae3a9c6ca3e@solid-run.com>
In-Reply-To: <20240716-a38x-utmi-phy-v2-0-dae3a9c6ca3e@solid-run.com>
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
X-ClientProxiedBy: FR0P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::20) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AM8PR04MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 97650bb0-a8ef-41bc-02ee-08dca5d93e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGZXazNYMldkbGdlbTJqVXFwTDl5Tk9UVHNlSGRYMDFDUzNBK1hpazI3OVkr?=
 =?utf-8?B?V3ZsUGlSQWZvbm9CRkxmTUp1bFJaL3JCZDFQKzBCRUpEY0Q0ekFRaWY2VmVS?=
 =?utf-8?B?d090OVl2ZnUvQkMvSmhzZklDZFRGb0dVQTlaWWdkMTdKcFZEdHM0ZGJxY1RP?=
 =?utf-8?B?V3lSdVhCc202S0U2RUIyVVZGTFVQV1dGaVBtc3dsSVZITW04Q1hOYXZneDEy?=
 =?utf-8?B?UW1vODlyT1VVc0VFbHI5QU5lWFpoMEswZDFQRlBwb0tabnBReXArcjRVaVky?=
 =?utf-8?B?eGdOYnNtek5ZQWJPUDV2NjBkaDlEVFVhb2hpcHljbzFya1hsM3E2ZnQwMzRI?=
 =?utf-8?B?Nm1uOUJPcVp2S3dpMkovYTNzUFBrNGdrcDVGczlaQnFSUnpsK3Q1cmhHbFAr?=
 =?utf-8?B?dTFhLzJYRDEzMXIycS9PaVVXTlU1bWlKQUJxN3RBWno5aW5sbWwyYzVleVpP?=
 =?utf-8?B?ZmNVUUIrTVp6cFBBQkxMVEovLzB2TTd1SzFzcWl2VkdraDRydTVDd1NDamVl?=
 =?utf-8?B?c2pKMGVkQ3EyWXNkWWR4WFNGdjBRQVZJR29NZ1RVWjJ3NUhrRGZUT3NuaHJT?=
 =?utf-8?B?eGdlMlQ1SDYyTFZOYVFvZTV5NWpRY2h0cWRCNzFBV3d5d1hHNVFVM1lQRDNv?=
 =?utf-8?B?ZkZDWnRmM1hhUHNnTkROcHBmL055TGJXUmhmV2dTcVVPT1Z4Mm5EdXVadkFT?=
 =?utf-8?B?Qm9ibExWYnlNd0tsQ3FIQ0c3SCtzS09tcC9FVVhuWlg5RTVQSVR2dGZ2VVJ0?=
 =?utf-8?B?VkpsSXpqTDlnVUhEdlNhL3ozWTdEejlsUERlR2R1VVpYTGtDNXdScTlWdGlo?=
 =?utf-8?B?cnJZVDNWbWxWUDlwUXlTbEJKZWhOSHdhYngxYzNxSjNJZFpGeitQcXE2Wita?=
 =?utf-8?B?cmJqa1RaTUNiT1Q5RzNSVzMxNEE3S1dzbHVYakdyTk1CUmRHZUlpTFVWUHFO?=
 =?utf-8?B?SklzSEJjZEJXN1FDYk0wN2RQUkozc2drcng5NStFZDU5dEVmRXg3eVJaWm5l?=
 =?utf-8?B?d1N6c1Y1WU1WS0F5Nzlpb0g3ZDR0ckV4bUlrSkE4aEx0Z0huNkVDQXh5WEhw?=
 =?utf-8?B?OWMyb05BNDBVcXhMMXFnbmh2VlM4bjJ4Yms5MWd1SE1ic3J4c0dqRytMU3Ix?=
 =?utf-8?B?dHNkRHVhYmlFWmd4U2NqblZQUlZCSXJ6OERHQkx4SXdxSzNEZTJnYlNYeStV?=
 =?utf-8?B?bzU2NDgwcGhidDY5NnpQUmVVbGx4Vk0xeExGM2ZCajNhS1ZnVmpLYWwwRWFX?=
 =?utf-8?B?VHdCR3NjeXNsMTVTWVdnSzFNUEQrMkdPeEhoQVo2aFVRVm1sNEtKOWlodlVR?=
 =?utf-8?B?bUxpRlp0SVJpTGJieXJmODYrRW1EMHBIYklyMWptZ0QvSmU4S2g4TzlKdkd4?=
 =?utf-8?B?MHFtcnpjU3NxYVFXQmRJMjBLd0RBV2lxSUQzbUFHcUhCNzJyTXRLNjhtR201?=
 =?utf-8?B?YkpMekxvNmE5cWVFTjhQS1QrcTNYVDRUMzJzTnFGOE12THIwT0Y4SjF3Q3c1?=
 =?utf-8?B?WjY0S24zQUpGQXFRbmE0TzhBZk1oTG42SkdQQ3Mrd2EzZ1FCS0F3WDVkU3NI?=
 =?utf-8?B?cGRPc0hHV0I2TTc3ZXRVckR6Nm5LYmZSK2VuZkZpSFRidjArenhpS0pTUTVr?=
 =?utf-8?B?K3MwUjVib0VMcEF1cXYyRVkyQ3JrbGs2MXBFQ096NzlPMWx1WEkxVUQ1YUNT?=
 =?utf-8?B?alRCWFQ4SCttRzh1R0tySXRCdXk4ek05elJVeUpSU3dxSFVYejBGR3dtNUUx?=
 =?utf-8?B?cTFCck9DUzh6cWtnSUcvWlFualkyc09VdlhHVU0xZzFFL3kxQnpodUh6RTZD?=
 =?utf-8?B?TUVuQ0NrU2x0dkY3ZHNEOGkvRG85c2R6Y0FxVlRUSzhTbFJ3Y0dNMXlHZHhn?=
 =?utf-8?B?WWxqbUdyQk11SGxzbFJHREtoWVcrbDJQUTZuS1YzQXY2WkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djVldDkrbzlCaWc2aDhBNGEvZ1VwQ25BNGw4YVVoUU5jMGs0TWZYbmVVMVFn?=
 =?utf-8?B?bzM4cW5jditaNEI3TWh6VHp2T3lFQ1BoN1d6N3prUjRFSHdwaGVCOGJNWlhS?=
 =?utf-8?B?b3BvUTRWL3BtYnhNcVMzeDVyeVJFbXVWcnhLS2VDR1ZXMGFLeERBY0ZRVzZP?=
 =?utf-8?B?cFhBSjdUOEgzR2w1MWF5dWRrRjlNWTdFbi9xRjFFYlpCak1PSU5hVlQ0a254?=
 =?utf-8?B?WXdKeDV1SzZlKzlCdEtySWhqZ2xwa1dmcm0zR284MXVYLzNvMVh0NU5Va3kr?=
 =?utf-8?B?aHF4RldzS0pRQXQzT0FtTDUvTUlmMDAwY3F4ZWU3WGFHZlF2K0JvNXBRTkll?=
 =?utf-8?B?TDZKYlZvWWVXWlFvRHFyZGtiN2xDbU1iamU1WUNxTVk1QmNlcHBzMVlJYVZ1?=
 =?utf-8?B?K0NFL01xaXNIRWRodW5hODhYUFJ1dmdvR0NKZiszdlF0V0ZhM0xMQXJsNnpk?=
 =?utf-8?B?L3FXWWFMdVphZExFU3RIVkNFUGpReWZqUzZYemJOb054aVFIc3lJdlF0cVdx?=
 =?utf-8?B?bzdIYWw2TUd3Uk9YR21YNFBjTGN5OThKeGQva3dFUVFmMzFxRi9LcmNxSHhm?=
 =?utf-8?B?b2Yzd3B1TnVkcEQ0dklydEhPdzBHTW8rd2NmM2hETzI4UlNyNFFEWTB0cjJQ?=
 =?utf-8?B?cGZyY3ZSb1ZpV1BNUFpGRU5kcDdqeUxNKzNyS1p3Y290UmxZQkI2eWVRNFpu?=
 =?utf-8?B?U2RrbTQ4SzAyMWZ2NWEreHVXOEIwNTJWYkZBZ0N6TjJnbld4MDhuVVZkcllq?=
 =?utf-8?B?NTdyL0lQaHp5cllWRkpyOWhJL1dOZEdKNlRPK0ZJNzJTWXEyZ25LZXp0SDdt?=
 =?utf-8?B?VmhZTTJFMExWa1hCc1IyVTJlb1hpSXJoeTVOcVhtY2dsMmtwVlRsQVZHdGhy?=
 =?utf-8?B?dVJVRFhRV2ZyUlN6LzF1WlpCSndHV1hMNjU4Z05qRENtS1VyMFozZmlwSlA2?=
 =?utf-8?B?clVqWllrTzB0L1kxQzdINDllb1VOVE9uZWduZjFtdjRiSzFPL0J5MTM4cFlU?=
 =?utf-8?B?cFdaY3ozcEtDN2c1L1QzNTZKMWhid0RjQkhGaVZuT2NiV21PV0llNXN5ZE1M?=
 =?utf-8?B?NlBGSHQxZVEwem5DM08ySWZtSmJWV2o0S3pRb0pQYVNldUQ3NmdVdkkvTlE0?=
 =?utf-8?B?RVMzVlZpM280ZDlpUmRUUkV3L0NDY2dYeHZ6QUM4SjhZRHM3YVdPRHhSVzFV?=
 =?utf-8?B?Z1VvVjNXMVgwY3RhL21PNG8rcDVGQ1NiODNKTklqR3lhUm5sVlQ1OHBEeUhx?=
 =?utf-8?B?QmM0dWRQcThBb2pBVWxqb282bmJaNlhncy9GQ2NyakpaZUl6djBWNElzaHJ4?=
 =?utf-8?B?RXpTc1hsbG1VNngxQWlDUmtra1FXbWZtNmVMem9JWWplSExlVmFpNUJ2MXAz?=
 =?utf-8?B?ejd5M0VJU1BBd1NzTzJNNkFJQzJxL09QWFdZUnpkeDg2Y0VvUjBHN0xFb3JQ?=
 =?utf-8?B?dHh0MjRhNzJRbXZmY0E5RGlIc2dIS2h1b01ERGt1R0E2K1psNzhhTEltaGFX?=
 =?utf-8?B?WTRxVlZWS2xpUkFLdXZSWkJPWnZ0aElkWitDR01lT1QvdkdRNzFVUEhBeG1l?=
 =?utf-8?B?OEx6MVhEdDI2UlNKZlNWa2VSanlBUjIrU2NFbkJYQTg2ckhYY0dqNHp5YW5B?=
 =?utf-8?B?VUg1dFdkWmhxWG1QWDR1T29Nb1NDMkJJWTNSeldsdVpybFlrYjFpVFI3b2gr?=
 =?utf-8?B?RWRJMndHdGF1a2RRMmtNbEVZZWcxdzRWNzBvT0JrcW9GSCtaREdzYTV3N3JH?=
 =?utf-8?B?RDJJZDhlOUZwcUZ1aUxiVHo0M2ZNcXZkdzVKb0lrT1ZGVCtxL0hTVWNxdlo3?=
 =?utf-8?B?U3Z6Zks0UExFNHRRMlZrcUpxSmtXWmI4cFFKNEZQbHEwcXZSTnYwQUd2OHBz?=
 =?utf-8?B?cmp0OGZ2R1Y0a2d5VEYwdjEyVnVwaHF1SXVMR09tVDg1K2cwTXI0RmhWdlhq?=
 =?utf-8?B?Uk9JVmJadmUxZ1kxcFdIOER6akZnMk9TUlBOV1BWWVNCQlZsb1NMR0RMdTNW?=
 =?utf-8?B?Q00vMW04TXUvQTR2eGRnVUpyb1RNM3ZCYXM3WWVsMUxKY3lUTE84RzBiUmky?=
 =?utf-8?B?Z042VDRpeVVnTnJGRS8zUTMvNnQzWVJKLytxdzdQSFlzTGZPQXVVMEladmlZ?=
 =?utf-8?Q?uyKZidqnl/Y+yllEj0ANx4r2S?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97650bb0-a8ef-41bc-02ee-08dca5d93e5b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 20:52:45.3013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrkBbRHKZcrRQFdjuEHa+pwbj3F9R3msoLO3ORidYNxwUzi5gkJxejLUeLI5wr1kkheBlqXd5CRSTaK6H8b1Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7907

Armada 380 has smilar USB-2.0 PHYs as CP-110. The differences are:
- register base addresses
- gap between port registers
- number of ports: 388 has three, cp110 two
- device-mode mux has bit refers to different ports
- syscon register's base address (offsets identical)
- armada-8k uses syscon for various drivers, a38x not

Differentiation uses of_match_data with distinct compatible strings.

Add support for Armada 380 PHYs by partially restructuting the driver:
- Port register pointers are moved to the per-port private data.
- Add armada-38x-specific compatible string and store enum value in
  of_match_data for differentiation.
- Add support for optional regs usb-cfg and utmi-cfg replacing syscon.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c | 209 +++++++++++++++++++++++------
 1 file changed, 166 insertions(+), 43 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
index 4922a5f3327d..4341923e85bc 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
@@ -19,7 +19,7 @@
 #include <linux/usb/of.h>
 #include <linux/usb/otg.h>
 
-#define UTMI_PHY_PORTS				2
+#define UTMI_PHY_PORTS				3
 
 /* CP110 UTMI register macro definetions */
 #define SYSCON_USB_CFG_REG			0x420
@@ -76,32 +76,44 @@
 #define PLL_LOCK_DELAY_US			10000
 #define PLL_LOCK_TIMEOUT_US			1000000
 
-#define PORT_REGS(p)				((p)->priv->regs + (p)->id * 0x1000)
+enum mvebu_cp110_utmi_type {
+	/* 0 is reserved to avoid clashing with NULL */
+	A380_UTMI = 1,
+	CP110_UTMI = 2,
+};
+
+struct mvebu_cp110_utmi_port;
 
 /**
  * struct mvebu_cp110_utmi - PHY driver data
  *
- * @regs: PHY registers
+ * @regs_usb: USB configuration register
  * @syscon: Regmap with system controller registers
  * @dev: device driver handle
  * @ops: phy ops
+ * @ports: phy object for each port
  */
 struct mvebu_cp110_utmi {
-	void __iomem *regs;
+	void __iomem *regs_usb;
 	struct regmap *syscon;
 	struct device *dev;
 	const struct phy_ops *ops;
+	struct mvebu_cp110_utmi_port *ports[UTMI_PHY_PORTS];
 };
 
 /**
  * struct mvebu_cp110_utmi_port - PHY port data
  *
+ * @regs: PHY registers
+ * @regs_cfg: PHY config register
  * @priv: PHY driver data
  * @id: PHY port ID
  * @dr_mode: PHY connection: USB_DR_MODE_HOST or USB_DR_MODE_PERIPHERAL
  */
 struct mvebu_cp110_utmi_port {
 	struct mvebu_cp110_utmi *priv;
+	void __iomem *regs;
+	void __iomem *regs_cfg;
 	u32 id;
 	enum usb_dr_mode dr_mode;
 };
@@ -118,47 +130,47 @@ static void mvebu_cp110_utmi_port_setup(struct mvebu_cp110_utmi_port *port)
 	 * The crystal used for all platform boards is now 25MHz.
 	 * See the functional specification for details.
 	 */
-	reg = readl(PORT_REGS(port) + UTMI_PLL_CTRL_REG);
+	reg = readl(port->regs + UTMI_PLL_CTRL_REG);
 	reg &= ~(PLL_REFDIV_MASK | PLL_FBDIV_MASK | PLL_SEL_LPFR_MASK);
 	reg |= (PLL_REFDIV_VAL << PLL_REFDIV_OFFSET) |
 	       (PLL_FBDIV_VAL << PLL_FBDIV_OFFSET);
-	writel(reg, PORT_REGS(port) + UTMI_PLL_CTRL_REG);
+	writel(reg, port->regs + UTMI_PLL_CTRL_REG);
 
 	/* Impedance Calibration Threshold Setting */
-	reg = readl(PORT_REGS(port) + UTMI_CAL_CTRL_REG);
+	reg = readl(port->regs + UTMI_CAL_CTRL_REG);
 	reg &= ~IMPCAL_VTH_MASK;
 	reg |= IMPCAL_VTH_VAL << IMPCAL_VTH_OFFSET;
-	writel(reg, PORT_REGS(port) + UTMI_CAL_CTRL_REG);
+	writel(reg, port->regs + UTMI_CAL_CTRL_REG);
 
 	/* Set LS TX driver strength coarse control */
-	reg = readl(PORT_REGS(port) + UTMI_TX_CH_CTRL_REG);
+	reg = readl(port->regs + UTMI_TX_CH_CTRL_REG);
 	reg &= ~TX_AMP_MASK;
 	reg |= TX_AMP_VAL << TX_AMP_OFFSET;
-	writel(reg, PORT_REGS(port) + UTMI_TX_CH_CTRL_REG);
+	writel(reg, port->regs + UTMI_TX_CH_CTRL_REG);
 
 	/* Disable SQ and enable analog squelch detect */
-	reg = readl(PORT_REGS(port) + UTMI_RX_CH_CTRL0_REG);
+	reg = readl(port->regs + UTMI_RX_CH_CTRL0_REG);
 	reg &= ~SQ_DET_EN;
 	reg |= SQ_ANA_DTC_SEL;
-	writel(reg, PORT_REGS(port) + UTMI_RX_CH_CTRL0_REG);
+	writel(reg, port->regs + UTMI_RX_CH_CTRL0_REG);
 
 	/*
 	 * Set External squelch calibration number and
 	 * enable the External squelch calibration
 	 */
-	reg = readl(PORT_REGS(port) + UTMI_RX_CH_CTRL1_REG);
+	reg = readl(port->regs + UTMI_RX_CH_CTRL1_REG);
 	reg &= ~SQ_AMP_CAL_MASK;
 	reg |= (SQ_AMP_CAL_VAL << SQ_AMP_CAL_OFFSET) | SQ_AMP_CAL_EN;
-	writel(reg, PORT_REGS(port) + UTMI_RX_CH_CTRL1_REG);
+	writel(reg, port->regs + UTMI_RX_CH_CTRL1_REG);
 
 	/*
 	 * Set Control VDAT Reference Voltage - 0.325V and
 	 * Control VSRC Reference Voltage - 0.6V
 	 */
-	reg = readl(PORT_REGS(port) + UTMI_CHGDTC_CTRL_REG);
+	reg = readl(port->regs + UTMI_CHGDTC_CTRL_REG);
 	reg &= ~(VDAT_MASK | VSRC_MASK);
 	reg |= (VDAT_VAL << VDAT_OFFSET) | (VSRC_VAL << VSRC_OFFSET);
-	writel(reg, PORT_REGS(port) + UTMI_CHGDTC_CTRL_REG);
+	writel(reg, port->regs + UTMI_CHGDTC_CTRL_REG);
 }
 
 static int mvebu_cp110_utmi_phy_power_off(struct phy *phy)
@@ -166,22 +178,38 @@ static int mvebu_cp110_utmi_phy_power_off(struct phy *phy)
 	struct mvebu_cp110_utmi_port *port = phy_get_drvdata(phy);
 	struct mvebu_cp110_utmi *utmi = port->priv;
 	int i;
+	int reg;
 
 	/* Power down UTMI PHY port */
-	regmap_clear_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
-			  UTMI_PHY_CFG_PU_MASK);
+	if (!IS_ERR(port->regs_cfg)) {
+		reg = readl(port->regs_cfg);
+		reg &= ~(UTMI_PHY_CFG_PU_MASK);
+		writel(reg, port->regs_cfg);
+	} else
+		regmap_clear_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
+				  UTMI_PHY_CFG_PU_MASK);
 
 	for (i = 0; i < UTMI_PHY_PORTS; i++) {
-		int test = regmap_test_bits(utmi->syscon,
-					    SYSCON_UTMI_CFG_REG(i),
-					    UTMI_PHY_CFG_PU_MASK);
+		if (!utmi->ports[i])
+			continue;
+
+		if (!IS_ERR(utmi->ports[i]->regs_cfg))
+			reg = readl(utmi->ports[i]->regs_cfg);
+		else
+			regmap_read(utmi->syscon, SYSCON_UTMI_CFG_REG(i), &reg);
+		int test = reg & UTMI_PHY_CFG_PU_MASK;
 		/* skip PLL shutdown if there are active UTMI PHY ports */
 		if (test != 0)
 			return 0;
 	}
 
 	/* PLL Power down if all UTMI PHYs are down */
-	regmap_clear_bits(utmi->syscon, SYSCON_USB_CFG_REG, USB_CFG_PLL_MASK);
+	if (!IS_ERR(utmi->regs_usb)) {
+		reg = readl(utmi->regs_usb);
+		reg &= ~(USB_CFG_PLL_MASK);
+		writel(reg, utmi->regs_usb);
+	} else
+		regmap_clear_bits(utmi->syscon, SYSCON_USB_CFG_REG, USB_CFG_PLL_MASK);
 
 	return 0;
 }
@@ -191,8 +219,15 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	struct mvebu_cp110_utmi_port *port = phy_get_drvdata(phy);
 	struct mvebu_cp110_utmi *utmi = port->priv;
 	struct device *dev = &phy->dev;
+	const void *match;
+	enum mvebu_cp110_utmi_type type;
 	int ret;
 	u32 reg;
+	u32 sel;
+
+	match = device_get_match_data(utmi->dev);
+	if (match)
+		type = (enum mvebu_cp110_utmi_type)(uintptr_t)match;
 
 	/* It is necessary to power off UTMI before configuration */
 	ret = mvebu_cp110_utmi_phy_power_off(phy);
@@ -208,16 +243,45 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	 * to UTMI0 or to UTMI1 PHY port, but not to both.
 	 */
 	if (port->dr_mode == USB_DR_MODE_PERIPHERAL) {
-		regmap_update_bits(utmi->syscon, SYSCON_USB_CFG_REG,
-				   USB_CFG_DEVICE_EN_MASK | USB_CFG_DEVICE_MUX_MASK,
-				   USB_CFG_DEVICE_EN_MASK |
-				   (port->id << USB_CFG_DEVICE_MUX_OFFSET));
+		switch (type) {
+		case A380_UTMI:
+			/*
+			 * A380 muxes between ports 0/2:
+			 * - 0: Device mode on Port 2
+			 * - 1: Device mode on Port 0
+			 */
+			if (port->id == 1)
+				return -EINVAL;
+			sel = !!(port->id == 0);
+			break;
+		case CP110_UTMI:
+			/*
+			 * CP110 muxes between ports 0/1:
+			 * - 0: Device mode on Port 0
+			 * - 1: Device mode on Port 1
+			 */
+			sel = port->id;
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (!IS_ERR(utmi->regs_usb)) {
+			reg = readl(utmi->regs_usb);
+			reg &= ~(USB_CFG_DEVICE_EN_MASK | USB_CFG_DEVICE_MUX_MASK);
+			reg |= USB_CFG_DEVICE_EN_MASK;
+			reg |= (sel << USB_CFG_DEVICE_MUX_OFFSET);
+			writel(reg, utmi->regs_usb);
+		} else
+			regmap_update_bits(utmi->syscon, SYSCON_USB_CFG_REG,
+					   USB_CFG_DEVICE_EN_MASK | USB_CFG_DEVICE_MUX_MASK,
+					   USB_CFG_DEVICE_EN_MASK |
+					   (sel << USB_CFG_DEVICE_MUX_OFFSET));
 	}
 
 	/* Set Test suspendm mode and enable Test UTMI select */
-	reg = readl(PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+	reg = readl(port->regs + UTMI_CTRL_STATUS0_REG);
 	reg |= SUSPENDM | TEST_SEL;
-	writel(reg, PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+	writel(reg, port->regs + UTMI_CTRL_STATUS0_REG);
 
 	/* Wait for UTMI power down */
 	mdelay(1);
@@ -226,16 +290,21 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	mvebu_cp110_utmi_port_setup(port);
 
 	/* Power UP UTMI PHY */
-	regmap_set_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
-			UTMI_PHY_CFG_PU_MASK);
+	if (!IS_ERR(port->regs_cfg)) {
+		reg = readl(port->regs_cfg);
+		reg |= UTMI_PHY_CFG_PU_MASK;
+		writel(reg, port->regs_cfg);
+	} else
+		regmap_set_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
+				UTMI_PHY_CFG_PU_MASK);
 
 	/* Disable Test UTMI select */
-	reg = readl(PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+	reg = readl(port->regs + UTMI_CTRL_STATUS0_REG);
 	reg &= ~TEST_SEL;
-	writel(reg, PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+	writel(reg, port->regs + UTMI_CTRL_STATUS0_REG);
 
 	/* Wait for impedance calibration */
-	ret = readl_poll_timeout(PORT_REGS(port) + UTMI_CAL_CTRL_REG, reg,
+	ret = readl_poll_timeout(port->regs + UTMI_CAL_CTRL_REG, reg,
 				 reg & IMPCAL_DONE,
 				 PLL_LOCK_DELAY_US, PLL_LOCK_TIMEOUT_US);
 	if (ret) {
@@ -244,7 +313,7 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	}
 
 	/* Wait for PLL calibration */
-	ret = readl_poll_timeout(PORT_REGS(port) + UTMI_CAL_CTRL_REG, reg,
+	ret = readl_poll_timeout(port->regs + UTMI_CAL_CTRL_REG, reg,
 				 reg & PLLCAL_DONE,
 				 PLL_LOCK_DELAY_US, PLL_LOCK_TIMEOUT_US);
 	if (ret) {
@@ -253,7 +322,7 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	}
 
 	/* Wait for PLL ready */
-	ret = readl_poll_timeout(PORT_REGS(port) + UTMI_PLL_CTRL_REG, reg,
+	ret = readl_poll_timeout(port->regs + UTMI_PLL_CTRL_REG, reg,
 				 reg & PLL_RDY,
 				 PLL_LOCK_DELAY_US, PLL_LOCK_TIMEOUT_US);
 	if (ret) {
@@ -262,7 +331,12 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	}
 
 	/* PLL Power up */
-	regmap_set_bits(utmi->syscon, SYSCON_USB_CFG_REG, USB_CFG_PLL_MASK);
+	if (!IS_ERR(utmi->regs_usb)) {
+		reg = readl(utmi->regs_usb);
+		reg |= USB_CFG_PLL_MASK;
+		writel(reg, utmi->regs_usb);
+	} else
+		regmap_set_bits(utmi->syscon, SYSCON_USB_CFG_REG, USB_CFG_PLL_MASK);
 
 	return 0;
 }
@@ -274,7 +348,8 @@ static const struct phy_ops mvebu_cp110_utmi_phy_ops = {
 };
 
 static const struct of_device_id mvebu_cp110_utmi_of_match[] = {
-	{ .compatible = "marvell,cp110-utmi-phy" },
+	{ .compatible = "marvell,a38x-utmi-phy", .data = (void *)A380_UTMI },
+	{ .compatible = "marvell,cp110-utmi-phy", .data = (void *)CP110_UTMI },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mvebu_cp110_utmi_of_match);
@@ -285,6 +360,10 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
 	struct mvebu_cp110_utmi *utmi;
 	struct phy_provider *provider;
 	struct device_node *child;
+	void __iomem *regs_utmi;
+	void __iomem *regs_utmi_cfg;
+	const void *match;
+	enum mvebu_cp110_utmi_type type;
 	u32 usb_devices = 0;
 
 	utmi = devm_kzalloc(dev, sizeof(*utmi), GFP_KERNEL);
@@ -293,18 +372,44 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
 
 	utmi->dev = dev;
 
+	match = device_get_match_data(dev);
+	if (match)
+		type = (enum mvebu_cp110_utmi_type)(uintptr_t)match;
+
+	/* Get UTMI memory region */
+	regs_utmi = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs_utmi)) {
+		dev_err(dev, "Failed to map utmi regs\n");
+		return PTR_ERR(regs_utmi);
+	}
+
+	/* Get usb config region */
+	utmi->regs_usb = devm_platform_ioremap_resource_byname(pdev, "usb-cfg");
+	if (IS_ERR(utmi->regs_usb) && PTR_ERR(utmi->regs_usb) != -EINVAL) {
+		dev_err(dev, "Failed to map usb config regs\n");
+		return PTR_ERR(utmi->regs_usb);
+	}
+
+	/* Get utmi config region */
+	regs_utmi_cfg = devm_platform_ioremap_resource_byname(pdev, "utmi-cfg");
+	if (IS_ERR(regs_utmi_cfg) && PTR_ERR(regs_utmi_cfg) != -EINVAL) {
+		dev_err(dev, "Failed to map usb config regs\n");
+		return PTR_ERR(regs_utmi_cfg);
+	}
+
 	/* Get system controller region */
 	utmi->syscon = syscon_regmap_lookup_by_phandle(dev->of_node,
 						       "marvell,system-controller");
-	if (IS_ERR(utmi->syscon)) {
-		dev_err(dev, "Missing UTMI system controller\n");
+	if (IS_ERR(utmi->syscon) && PTR_ERR(utmi->syscon) != -ENODEV) {
+		dev_err(dev, "Failed to get system controller\n");
 		return PTR_ERR(utmi->syscon);
 	}
 
-	/* Get UTMI memory region */
-	utmi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(utmi->regs))
-		return PTR_ERR(utmi->regs);
+	if (IS_ERR(utmi->syscon) &&
+	    (IS_ERR(utmi->regs_usb) || IS_ERR(regs_utmi_cfg))) {
+		dev_err(dev, "Missing utmi system controller or config regs");
+		return -EINVAL;
+	}
 
 	for_each_available_child_of_node(dev->of_node, child) {
 		struct mvebu_cp110_utmi_port *port;
@@ -326,6 +431,24 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
 			return -ENOMEM;
 		}
 
+		utmi->ports[port_id] = port;
+
+		/* Get port memory region */
+		switch (type) {
+		case A380_UTMI:
+			port->regs = regs_utmi + port_id * 0x1000;
+			break;
+		case CP110_UTMI:
+			port->regs = regs_utmi + port_id * 0x2000;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		/* assign utmi cfg reg */
+		if (!IS_ERR(regs_utmi_cfg))
+			port->regs_cfg = regs_utmi_cfg + port_id * 4;
+
 		port->dr_mode = of_usb_get_dr_mode_by_phy(child, -1);
 		if ((port->dr_mode != USB_DR_MODE_HOST) &&
 		    (port->dr_mode != USB_DR_MODE_PERIPHERAL)) {

-- 
2.35.3


