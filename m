Return-Path: <linux-kernel+bounces-448050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C139F3A67
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E12188F50C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F334E1D47AF;
	Mon, 16 Dec 2024 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F5VSWOkM"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AAE1CF5DF;
	Mon, 16 Dec 2024 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379405; cv=fail; b=HuLNih68lcUQhKCWm6K4sV2ac2yshD9+0I3ouix8dvWEbUgewTrdVzdAwHt8tTWFGSlSJLNochy8dgSLZoUbMDSc+fTHQ7wJ1Kpq5zVUnDzbtgg+ma7DOXGj+AkXGWJwprIt5Ll3eic7SICAUXIGv3ymGGjo4MsmEURKjXI6pb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379405; c=relaxed/simple;
	bh=QVWkJ+1VaelOfMcj7f1HTsLdsgzQpNiFBMk1wCBIBAY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=U/owsE+zj+f6oGdN/n1lTXmmjQDa7ZuSJnozPSLpQVutV3qIo32jt69FctLq50fWA0sVBsF9ObDHLkV7dcJKdFNJJ1obHHnBaxiscz54IPXmhlQ/jTitQM55RM9DtLc3vodrzyubtZCy/4901//npDptWg8To0jKQs8vN4J2CKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F5VSWOkM; arc=fail smtp.client-ip=40.107.104.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtFr19L9MfxG1bJ+0pSb+ivuVw0uVp5yad/X8mrBe7U59yRkid74KreRJ/yGY515r5qts0lV9wft12wiCGTLBr17vDKtWfzPUDpaXNlsrcfGnbEoX8LrPtjLmT41Fuxv2jIkVG/md0eUGqLrUM4Uls0GTeGDHrlGsRq06a3VDh0/jKqmadRuHAj0u+f0x6ZIah2/Hh5tH5hfJkSFwHx/4K0mdVrFsNzeNt5NEGcuAkF6pOsL7REVFsroqTyOq+k0qqklcaTbdUAVcCXrkVDOddKjqUvSGzmo8jMRr3YJt8sV9rS4vR/K7L9w34Tc6ncfLe+V0zJDW9OW6US+YRSbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ajQCMyACPgXG0K6J4inKJJeLM/orrc4E5tWyMR/iQg=;
 b=foBv61UeNWD9BxK0dZNnrYg5FdhLJHGVpAxxx9V5HHMuwaTItQOZjijaEoOQSK6hbfQ7tyMAROf+AdCqU94VW5GIAtDVh8DYWsBPyoH2Typ9hBir6kndB+RQhA0hJsKTaOOk7Usa/APajaupR0E6dKncp4V6TX0C7dveZcb6N0DdzDvWqCbdukSZu86EfA4oBw3B5SSOVW5XYCbYgR7u88KZndDYXgwfBY61DAPqu1248+9yIjDiv7O0BlaJ0lsrJRInLxDZB0EEdUBNWzCN5c2i44CUmPHOCnbKRPjEptmNZieYtVJ7aHjnWamVCiqxOSt+B5s6FuUe7KD4eQGJhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ajQCMyACPgXG0K6J4inKJJeLM/orrc4E5tWyMR/iQg=;
 b=F5VSWOkMmF8ZOY9zi2gceLL1FWwY7q+Kf5CdLX/lF93vJdjKUGkLDELOa+Y+C/LhpY7ZflHuesaR0sv1ylYkqOBVyE58XMzZRbr7iY2MsZclwxbJ1gvYIwxczqwWsZ1BrV4CxGb7YFA34OdY3HiVz5zHCbe0JeTCoChHT4DzEQ10SUDYJGQmhOYbWhNX10XmwOXPU7AFHkLj6bculae8TnkFM+TT0tWnfbFFjG8evQqFryksOyWhKqlpWcjPtNcOCEF7BQkfLfDd8TyLNXmOGuFPmfCWQolqWVppcGaLhNiOp8xm9aq2POpAQh062SlIUnSw0ZI7WqqSCemEDNrF8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7501.eurprd04.prod.outlook.com (2603:10a6:102:ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 20:03:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 20:03:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 16 Dec 2024 15:03:06 -0500
Subject: [PATCH v4 2/2] regulator: pf9453: add PMIC PF9453 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-pf9453-v4-2-a9fc8f0a0098@nxp.com>
References: <20241216-pf9453-v4-0-a9fc8f0a0098@nxp.com>
In-Reply-To: <20241216-pf9453-v4-0-a9fc8f0a0098@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734379392; l=27805;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1gV5jQRL1V15KauOyqWRLmnaARonWTxQPskouQ9QYOs=;
 b=z2nyn+SlbM6O43XSj8tkZ4iiBsNeg4k5ckOs2/IjWvAN4QecHpl8Ms++wt6e0dTuUXBcrpxHz
 QF36j9TF/D7Csqau/aBRou8q3GYZTMbKV+oYBK+KoBMhuRwiVhhHZ2g
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:254::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: c59cf63c-cf62-4ae3-d6d9-08dd1e0cb0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFBPWThLOWpUNmx1Vk9weWFxbXI3Q1ozZk9GMlJ3R3FlRGc2YlFpQUZtbWlD?=
 =?utf-8?B?UDFyT1BJM3dxM1Y0aVRQemJ1c0NJQndrcnNIVm9laWh1dldaQjQwa0tsazdT?=
 =?utf-8?B?czlYZ2tBQlR1SDcxa21KbkU3aDVKMlhYZG43R29PcGE5WU5ENzAyZWd1YVhZ?=
 =?utf-8?B?K0Z3NVh3WU5pMGpLbTdkTjdCQ09oUkxtZ3pXNkY5TTVtbGc5cDZTR1N0TXhm?=
 =?utf-8?B?WnB3ZTR3ZURZYUF6M2VOeU0vOGEzTzJwMGxHekg0V0JEdWlGblZCVFBrWjgy?=
 =?utf-8?B?NFVuRU5jKzloUUl1RGJkWGY0YVNDelIrUjdHdUZiOHBsWFl5Qm9rTTNKRGNX?=
 =?utf-8?B?OWhURlBGZVhzZzd1RGxGUWg2NGV4ek40dzcvKys3L3FtRDNoQUwyY0hNYWFD?=
 =?utf-8?B?R090a3YrZmpJcTZOSGpBMVo5cHpNUmdkVEtsemdWRFJETGdTWU9zdVpJYjh5?=
 =?utf-8?B?SGx1RlEwbzM2cE1XODcxUkJOTVV3L3hDVEkzUElpWUpCU2dIeklZc2o1Y3lQ?=
 =?utf-8?B?SmNTRVFoblcvanZJMFJ5eHpBeGdCNDhPQXM4eWZMcHJLUThVb1hibkJvTGxF?=
 =?utf-8?B?d3ZCRU11c3QrZDRsRHZ2N21ObXhySWxGMEo3VjVNcHhNYk5odi80M3Bxd2o5?=
 =?utf-8?B?ZUZiNTYrWnh2NUlTb1JHVjFSRlZUbksySi8zR1VWaFBnbWZyY2ZQRkRsZVM5?=
 =?utf-8?B?K2JwZUFrZk83YnNQd042eldZdVRKT3AvaG1QektiOG05cVNONGxFU3ljWGNo?=
 =?utf-8?B?cVNpdjJaQVBxaDlOYjVkUUowNmo0ZjR0bUlpUzBJQUZlUHpnRnpQV2JPRjJo?=
 =?utf-8?B?SHorZUE2QW9OZFR1OGQySXphU0xIanJuVUtKcHZPTG0wbGh1SWY3ZjhNR0lV?=
 =?utf-8?B?WURnNnFnVjQ5anM4WXJtKzhJZ21rajV4Ui96WHlGQ2lGMXN1bEtaT2hucXhE?=
 =?utf-8?B?KzlqVDdtN1BGY2M4MVI2UlJ3SGY3R3QwNDJnU01ESVlxM1RkU3IyTWlRSC9k?=
 =?utf-8?B?c3JhRlYyQy9tbGVnMi8xdm1yRUtaNjBQWk5OVHVwbDZmYytLNWxmV0VxSmJV?=
 =?utf-8?B?VlJLSjBiR0tvZHhIa3pQSCtuTFZaWFgxaTlHTWRCRmpBY0NSVU0rZXNNNVBk?=
 =?utf-8?B?TkZISS9xS2RRdGlScUhQdWJJRWlVMnVHYXo2andIUCsxRzlkSGhYRW0xdndU?=
 =?utf-8?B?QjNCRGt6MnczRDVKUEVGNk5MVWkyWFRRNEIrQ0lXTk1LTWJReXAxdm9vSkE0?=
 =?utf-8?B?NFkwajZFeGw4eGFFTWZITnJZd2VKaUdydGNpT1ZRa2VSSnAwTVN0bG1XbmVC?=
 =?utf-8?B?L3lNRnFRc3hvaUtJT3hZWjhMZDBwc2hWRzNteEQ4Y0ViWHNXRkJKWkNUYUE0?=
 =?utf-8?B?c1luQ2JEbHN4YlpmVDhkcFNpMis4aGh5VWhPVXd4ZSswb3ZOTUZiOFQ2ZFk3?=
 =?utf-8?B?eTY3V3NWNVRxTUNrV0hmRjlocXp0YkhlQU42MS9YcURkZjJXMUUwdll4RFEr?=
 =?utf-8?B?dEVRdUprVEJ1VUNyYkE4VkxWRVd3U2kzbVpqdHB1Z0ttRkdUOHYyR3NwS2VK?=
 =?utf-8?B?b29QYmFEMjZ2ZTBaenpyWDlSQTA0cFozNmhCNDRPUEtrdEhiK1k1NTRlUWRJ?=
 =?utf-8?B?eU1kZWNoeUFkVDVUSWwyY1IzaTh5MVBvMC9veTZMU09ZajV3VURhQnA5dWdM?=
 =?utf-8?B?UHdKUGVhZkkwY2kzK0NsdjEzNjBlYXpMZy9IcVFUS1M0ZHowQk81c2VXcnBP?=
 =?utf-8?B?NEdYdlVhakxaVVNVSnJyQWhrbzlQRTFNSnRrR2JDcmxZTVlqVTI5aWNDaUt2?=
 =?utf-8?B?VzlZWnZhTWM1RFFsbWRMcHdKZHFtQVkyMnltRkl0emdYeU54T05PNFkyemQz?=
 =?utf-8?B?R0UxT1RmdXNrVzlPR2l2elVEYVpSN25uMklJSFdZZE80NmpPV3ZHVWZYYWhs?=
 =?utf-8?Q?EIKQyEF9VmIyc7pjZb0eH0ev7VjW52uq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEtGc0FYQWlKYzc4VTlmdzhwRjhwbmxCZFdFZ3p3dWJaeFlva3Y2M2NlRGlh?=
 =?utf-8?B?TlF1OU0xWG92Q1hpeDdiYWFjY2czR2YwOFpSNTNjY1g1U3UzTEwyUDBXQ1Y5?=
 =?utf-8?B?TUlkZmtDSG55cnVLQ3graFFjUzhBSXU5UUVQN0k0bk01ckY2NjE0OWtRa2lj?=
 =?utf-8?B?Q3NvWDVrV2hvT0VLV3pIRFdsb3NDZUxMRDB5R3FTak05K2MvWmJnZE93Zk15?=
 =?utf-8?B?RmhJSERiSFBPeUdsRVg2aFhsVW5ha0NIaHhCZXQ1dEZJRXd1d3loMk1EZHla?=
 =?utf-8?B?MVNGMGtycEhtcVFUNC9ES3ozTzVRS1pHTjdyNnBpTklnOXJFQWUxN2JDOEdD?=
 =?utf-8?B?NkVMeTRGbjZGTExjNlVwTDlPRVREV29FWFpTT1ZyVEMvYUJGY0h5WS9hWUFN?=
 =?utf-8?B?SGpJQTl1Vy9TK0o1ZVFvOW13ZEhFYndYcXczcnZYclhtbDBQZTVxM3FZNzJu?=
 =?utf-8?B?SjdUR1Q5SzFFbmlmaENHcUNzcE02TlhNWnlFaHY3NzVaV0g5NnVtZVlpRXZm?=
 =?utf-8?B?T3I0WTVMaEE0SDNmZkt1cmV4QWVsUmo4QzFLL2lSMVhkN2RwVDQrcGtJZUlJ?=
 =?utf-8?B?eWpHcm1ITHljRXV3Zzl4WWV2bzN2a3hXck51bERKUUJlVlo0MXBUUUs1SWkv?=
 =?utf-8?B?LzArcXVOUVF0RUc3eHJGMkR1L0F5a0YvOGtpVUpMM0pNWW1EWk9tTEtFRU50?=
 =?utf-8?B?N1dUaHhkd3ZFRjAweGdBN0sveXhMR25wK0JDaGRYWlp5MmdkMW5oSCtSQXlq?=
 =?utf-8?B?MFlLVEdPWUkvaXEwdnZMQ2ZKL2FJWkkrdUNTcVgvb25tTmc4ZWlGeVJqdEo5?=
 =?utf-8?B?eHNPc2xqbndPbDF1a3JubEVqQXpacVZ5ejlaR3FEcUNvVlE0cjlQdklXUDJu?=
 =?utf-8?B?VjcxdjlmdHF3VFU4UkE5R2p4ZFhMeGZBSHY3ejFqaEdJSmRxc3J2M3NMeits?=
 =?utf-8?B?Y0ZFSnpTbXRiaHdXNURlTWRpdm5FYzA3VFRWUzRIaVRXckx6VEJudk50blpm?=
 =?utf-8?B?dUNDVHRBbGhwTnF5Um93MUYzR1Y5bzdaTCtYek5oRUMrOGROZHhMOGw3N0kv?=
 =?utf-8?B?Mkx2ekl3c3QzdDVLWmVLWlhraW8vMDJ6STZqWXFPOWk1cWcxSmR2L2dRYWRx?=
 =?utf-8?B?V1VFdlFmRHJDRCtrQVJYSW9SdFVPVGI5QVNRNUZzYUZ5dE8xQ1ZYZmppUnFy?=
 =?utf-8?B?NksvZnpWY3J4dFhLWERWZWxEYXRBUE05Umhjbk4vaUg0MVVPYlRNeWRxQlpD?=
 =?utf-8?B?M3hPME5xRklUbWtqd2FDVUhWUnltb2dLWFgxbkUxelcxMzkyazdvaTVQUzlm?=
 =?utf-8?B?SnpFUzN1M0hDOW8xZ3RPcGpIVTRtSmdoNkRPMzQzekxhZCtpUUdRRXdkQjNh?=
 =?utf-8?B?cmVCeDlKSmNLdE5KclF2M3pPbHE1eUNLT01Xcm81N2s5ZnVrQWJOZWtCci9Y?=
 =?utf-8?B?TzlyNUxBTXN4d2cyQmkwNklEU0Znd3hCQmIrRGdWV3pxcnRjZlByVHRhaGFG?=
 =?utf-8?B?UjNwTVIxSHJoYzFGbXhpelR6UDdRaEdNVXNsUXJpZFRHZmRXV3JTOTVWald3?=
 =?utf-8?B?a1loeE1WOUhSRXEzb3hPMVhLSTFEM3h0Tm1veTNmSUVwQTdEbEhlNXhkMkRD?=
 =?utf-8?B?MUk0QVJWRGpIemRYV1JVVGpBcllwWVhLNUg4NkJPM0tqbUdyaTJCaHdrU3lV?=
 =?utf-8?B?YTIxOVBlZHZmbHFEMXFKVjRhMlAxSzZxb3FJZy9GRExGR3pUc1JKRjlMWU5G?=
 =?utf-8?B?M3kwVWt6ck1IcyswY2dPNUovbE93VE5UaWNDY1ZRdW5TT1V6b08zSkRaSGcy?=
 =?utf-8?B?NDYrMzVyeXpBVkJldVhadGVWcDRFU01hbEFJd3JObHZkZm4rK3c1ZWZvTnVP?=
 =?utf-8?B?N1VmSWUyaW9Qbi9JeWhlZEV2K1RkNWpwZEJZM3I1NDZVbWhjbWoxTnVRK3cw?=
 =?utf-8?B?dTJZaEZDaHhuV1kxNzFHSFBnWnJkQnFzMWs3dXp6L2JMck9ZbUd4blZkTTRM?=
 =?utf-8?B?RkRPT1Y2UitycEJHWFYyRlhzcWF2Nkx3OVJpeFljSVVlYnI2VWhUdFJiNVpQ?=
 =?utf-8?B?RFNWRG5oNWMvQTRjYTA4Q3JxbjlIVzd6ajJFZWp4cDRnVzE0S3BnM29HZTFq?=
 =?utf-8?Q?h6jyK0AFq1fKiG4Zd1CMllP3f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59cf63c-cf62-4ae3-d6d9-08dd1e0cb0c7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 20:03:21.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vOrBzhLfTydYDxkSjydLpNynJLc4WOxPsMELQuNIGUsS92dQo58ZsT8FBg6xotw+PyW60E/v6+AcFqO0YfOaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7501

From: Joy Zou <joy.zou@nxp.com>

Support new PMIC PF9453, which is totally difference with PCA9450. So
create new file for it.

The PF9453 is a single chip Power Management IC (PMIC) specifically
designed for i.MX 91 processor. It provides power supply solutions for IoT
(Internet of Things), smart appliance, and portable applications where size
and efficiency are critical. The device provides four high efficiency
step-down regulators, three LDOs, one 400 mA load switch and 32.768 kHz
crystal oscillator driver.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- fix GENMASK(7, 4), should be GENMASK(7, 6)

change from v2 to v3
- remove pf9453.h
- remove double space
- use low case hex value
- remove , after terminate
- use GEMASK
- change to LDO-SNVS
---
 drivers/regulator/Kconfig            |   7 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/pf9453-regulator.c | 879 +++++++++++++++++++++++++++++++++++
 3 files changed, 887 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 39297f7d81771..74d11ca2d9bee 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -981,6 +981,13 @@ config REGULATOR_PCA9450
 	  Say y here to support the NXP PCA9450A/PCA9450B/PCA9450C PMIC
 	  regulator driver.
 
+config REGULATOR_PF9453
+	tristate "NXP PF9453 regulator driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say y here to support the NXP PF9453 PMIC regulator driver.
+
 config REGULATOR_PCAP
 	tristate "Motorola PCAP2 regulator driver"
 	depends on EZX_PCAP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 3d5a803dce8a0..5192f24796636 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_REGULATOR_QCOM_SPMI) += qcom_spmi-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
 obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
+obj-$(CONFIG_REGULATOR_PF9453) += pf9453-regulator.o
 obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
 obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o
diff --git a/drivers/regulator/pf9453-regulator.c b/drivers/regulator/pf9453-regulator.c
new file mode 100644
index 0000000000000..ed6bf0f6c4fe2
--- /dev/null
+++ b/drivers/regulator/pf9453-regulator.c
@@ -0,0 +1,879 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP.
+ * NXP PF9453 pmic driver
+ */
+
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+struct pf9453_dvs_config {
+	unsigned int run_reg; /* dvs0 */
+	unsigned int run_mask;
+	unsigned int standby_reg; /* dvs1 */
+	unsigned int standby_mask;
+};
+
+struct pf9453_regulator_desc {
+	struct regulator_desc desc;
+	const struct pf9453_dvs_config dvs;
+};
+
+struct pf9453 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *sd_vsel_gpio;
+	int irq;
+};
+
+enum {
+	PF9453_BUCK1 = 0,
+	PF9453_BUCK2,
+	PF9453_BUCK3,
+	PF9453_BUCK4,
+	PF9453_LDO1,
+	PF9453_LDO2,
+	PF9453_LDOSNVS,
+	PF9453_REGULATOR_CNT
+};
+
+enum {
+	PF9453_DVS_LEVEL_RUN = 0,
+	PF9453_DVS_LEVEL_STANDBY,
+	PF9453_DVS_LEVEL_DPSTANDBY,
+	PF9453_DVS_LEVEL_MAX
+};
+
+#define PF9453_BUCK1_VOLTAGE_NUM	0x80
+#define PF9453_BUCK2_VOLTAGE_NUM	0x80
+#define PF9453_BUCK3_VOLTAGE_NUM	0x80
+#define PF9453_BUCK4_VOLTAGE_NUM	0x80
+
+#define PF9453_LDO1_VOLTAGE_NUM		0x65
+#define PF9453_LDO2_VOLTAGE_NUM		0x3b
+#define PF9453_LDOSNVS_VOLTAGE_NUM	0x59
+
+enum {
+	PF9453_REG_DEV_ID		= 0x00,
+	PF9453_REG_OTP_VER		= 0x01,
+	PF9453_REG_INT1			= 0x02,
+	PF9453_REG_INT1_MASK		= 0x03,
+	PF9453_REG_INT1_STATUS		= 0x04,
+	PF9453_REG_VRFLT1_INT		= 0x05,
+	PF9453_REG_VRFLT1_MASK		= 0x06,
+	PF9453_REG_PWRON_STAT		= 0x07,
+	PF9453_REG_RESET_CTRL		= 0x08,
+	PF9453_REG_SW_RST		= 0x09,
+	PF9453_REG_PWR_CTRL		= 0x0a,
+	PF9453_REG_CONFIG1		= 0x0b,
+	PF9453_REG_CONFIG2		= 0x0c,
+	PF9453_REG_32K_CONFIG		= 0x0d,
+	PF9453_REG_BUCK1CTRL		= 0x10,
+	PF9453_REG_BUCK1OUT		= 0x11,
+	PF9453_REG_BUCK2CTRL		= 0x14,
+	PF9453_REG_BUCK2OUT		= 0x15,
+	PF9453_REG_BUCK2OUT_STBY	= 0x1d,
+	PF9453_REG_BUCK2OUT_MAX_LIMIT	= 0x1f,
+	PF9453_REG_BUCK2OUT_MIN_LIMIT	= 0x20,
+	PF9453_REG_BUCK3CTRL		= 0x21,
+	PF9453_REG_BUCK3OUT		= 0x22,
+	PF9453_REG_BUCK4CTRL		= 0x2e,
+	PF9453_REG_BUCK4OUT		= 0x2f,
+	PF9453_REG_LDO1OUT_L		= 0x36,
+	PF9453_REG_LDO1CFG		= 0x37,
+	PF9453_REG_LDO1OUT_H		= 0x38,
+	PF9453_REG_LDOSNVS_CFG1		= 0x39,
+	PF9453_REG_LDOSNVS_CFG2		= 0x3a,
+	PF9453_REG_LDO2CFG		= 0x3b,
+	PF9453_REG_LDO2OUT		= 0x3c,
+	PF9453_REG_BUCK_POK		= 0x3d,
+	PF9453_REG_LSW_CTRL1		= 0x40,
+	PF9453_REG_LSW_CTRL2		= 0x41,
+	PF9453_REG_LOCK			= 0x4e,
+	PF9453_MAX_REG
+};
+
+#define PF9453_UNLOCK_KEY		0x5c
+#define PF9453_LOCK_KEY			0x0
+
+/* PF9453 BUCK ENMODE bits */
+#define BUCK_ENMODE_OFF			0x00
+#define BUCK_ENMODE_ONREQ		0x01
+#define BUCK_ENMODE_ONREQ_STBY		0x02
+#define BUCK_ENMODE_ONREQ_STBY_DPSTBY	0x03
+
+/* PF9453 BUCK ENMODE bits */
+#define LDO_ENMODE_OFF			0x00
+#define LDO_ENMODE_ONREQ		0x01
+#define LDO_ENMODE_ONREQ_STBY		0x02
+#define LDO_ENMODE_ONREQ_STBY_DPSTBY	0x03
+
+/* PF9453_REG_BUCK1_CTRL bits */
+#define BUCK1_LPMODE			0x30
+#define BUCK1_AD			0x08
+#define BUCK1_FPWM			0x04
+#define BUCK1_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK2_CTRL bits */
+#define BUCK2_RAMP_MASK			GENMASK(7, 6)
+#define BUCK2_RAMP_25MV			0x0
+#define BUCK2_RAMP_12P5MV		0x1
+#define BUCK2_RAMP_6P25MV		0x2
+#define BUCK2_RAMP_3P125MV		0x3
+#define BUCK2_LPMODE			0x30
+#define BUCK2_AD			0x08
+#define BUCK2_FPWM			0x04
+#define BUCK2_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK3_CTRL bits */
+#define BUCK3_LPMODE			0x30
+#define BUCK3_AD			0x08
+#define BUCK3_FPWM			0x04
+#define BUCK3_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK4_CTRL bits */
+#define BUCK4_LPMODE			0x30
+#define BUCK4_AD			0x08
+#define BUCK4_FPWM			0x04
+#define BUCK4_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK123_PRESET_EN bit */
+#define BUCK123_PRESET_EN		0x80
+
+/* PF9453_BUCK1OUT bits */
+#define BUCK1OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_BUCK2OUT bits */
+#define BUCK2OUT_MASK			GENMASK(6, 0)
+#define BUCK2OUT_STBY_MASK		GENMASK(6, 0)
+
+/* PF9453_REG_BUCK3OUT bits */
+#define BUCK3OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_BUCK4OUT bits */
+#define BUCK4OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_LDO1_VOLT bits */
+#define LDO1_EN_MASK			GENMASK(1, 0)
+#define LDO1OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_LDO2_VOLT bits */
+#define LDO2_EN_MASK			GENMASK(1, 0)
+#define LDO2OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_LDOSNVS_VOLT bits */
+#define LDOSNVS_EN_MASK			GENMASK(0, 0)
+#define LDOSNVSCFG1_MASK		GENMASK(6, 0)
+
+/* PF9453_REG_IRQ bits */
+#define IRQ_RSVD			0x80
+#define IRQ_RSTB			0x40
+#define IRQ_ONKEY			0x20
+#define IRQ_RESETKEY			0x10
+#define IRQ_VR_FLT1			0x08
+#define IRQ_LOWVSYS			0x04
+#define IRQ_THERM_100			0x02
+#define IRQ_THERM_80			0x01
+
+/* PF9453_REG_RESET_CTRL bits */
+#define WDOG_B_CFG_MASK			GENMASK(7, 6)
+#define WDOG_B_CFG_NONE			0x00
+#define WDOG_B_CFG_WARM			0x40
+#define WDOG_B_CFG_COLD			0x80
+
+/* PF9453_REG_CONFIG2 bits */
+#define I2C_LT_MASK			GENMASK(1, 0)
+#define I2C_LT_FORCE_DISABLE		0x00
+#define I2C_LT_ON_STANDBY_RUN		0x01
+#define I2C_LT_ON_RUN			0x02
+#define I2C_LT_FORCE_ENABLE		0x03
+
+static const struct regmap_range pf9453_status_range = {
+	.range_min = PF9453_REG_INT1,
+	.range_max = PF9453_REG_PWRON_STAT,
+};
+
+static const struct regmap_access_table pf9453_volatile_regs = {
+	.yes_ranges = &pf9453_status_range,
+	.n_yes_ranges = 1,
+};
+
+static const struct regmap_config pf9453_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_table = &pf9453_volatile_regs,
+	.max_register = PF9453_MAX_REG - 1,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+/*
+ * BUCK2
+ * BUCK2RAM[1:0] BUCK2 DVS ramp rate setting
+ * 00: 25mV/1usec
+ * 01: 25mV/2usec
+ * 10: 25mV/4usec
+ * 11: 25mV/8usec
+ */
+static const unsigned int pf9453_dvs_buck_ramp_table[] = {
+	25000, 12500, 6250, 3125
+};
+
+static bool is_reg_protect(uint reg)
+{
+	switch (reg) {
+	case PF9453_REG_BUCK1OUT:
+	case PF9453_REG_BUCK2OUT:
+	case PF9453_REG_BUCK3OUT:
+	case PF9453_REG_BUCK4OUT:
+	case PF9453_REG_LDO1OUT_L:
+	case PF9453_REG_LDO1OUT_H:
+	case PF9453_REG_LDO2OUT:
+	case PF9453_REG_LDOSNVS_CFG1:
+	case PF9453_REG_BUCK2OUT_MAX_LIMIT:
+	case PF9453_REG_BUCK2OUT_MIN_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int pf9453_pmic_write(struct pf9453 *pf9453, unsigned int reg, u8 mask, unsigned int val)
+{
+	int ret = -EINVAL;
+	u8 data, key;
+	u32 rxBuf;
+
+	/* If not updating entire register, perform a read-mod-write */
+	data = val;
+	key = PF9453_UNLOCK_KEY;
+
+	if (mask != 0xffU) {
+		/* Read data */
+		ret = regmap_read(pf9453->regmap, reg, &rxBuf);
+		if (ret) {
+			dev_err(pf9453->dev, "Read reg=%0x error!\n", reg);
+			return ret;
+		}
+		data = (val & mask) | (rxBuf & (~mask));
+	}
+
+	if (reg < PF9453_MAX_REG) {
+		if (is_reg_protect(reg)) {
+			ret = regmap_raw_write(pf9453->regmap, PF9453_REG_LOCK, &key, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+
+			ret = regmap_raw_write(pf9453->regmap, reg, &data, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+
+			key = PF9453_LOCK_KEY;
+			ret = regmap_raw_write(pf9453->regmap, PF9453_REG_LOCK, &key, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+		} else {
+			ret = regmap_raw_write(pf9453->regmap, reg, &data, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * pf9453_regulator_enable_regmap for regmap users
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * enable_reg and enable_mask fields in their descriptor and then use
+ * this as their enable() operation, saving some code.
+ */
+static int pf9453_regulator_enable_regmap(struct regulator_dev *rdev)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	unsigned int val;
+
+	if (rdev->desc->enable_is_inverted) {
+		val = rdev->desc->disable_val;
+	} else {
+		val = rdev->desc->enable_val;
+		if (!val)
+			val = rdev->desc->enable_mask;
+	}
+
+	return pf9453_pmic_write(pf9453, rdev->desc->enable_reg, rdev->desc->enable_mask, val);
+}
+
+/**
+ * pf9453_regulator_disable_regmap for regmap users
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * enable_reg and enable_mask fields in their descriptor and then use
+ * this as their disable() operation, saving some code.
+ */
+static int pf9453_regulator_disable_regmap(struct regulator_dev *rdev)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	unsigned int val;
+
+	if (rdev->desc->enable_is_inverted) {
+		val = rdev->desc->enable_val;
+		if (!val)
+			val = rdev->desc->enable_mask;
+	} else {
+		val = rdev->desc->disable_val;
+	}
+
+	return pf9453_pmic_write(pf9453, rdev->desc->enable_reg, rdev->desc->enable_mask, val);
+}
+
+/**
+ * pf9453_regulator_set_voltage_sel_regmap for regmap users
+ *
+ * @rdev: regulator to operate on
+ * @sel: Selector to set
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * vsel_reg and vsel_mask fields in their descriptor and then use this
+ * as their set_voltage_vsel operation, saving some code.
+ */
+static int pf9453_regulator_set_voltage_sel_regmap(struct regulator_dev *rdev, unsigned int sel)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	int ret;
+
+	sel <<= ffs(rdev->desc->vsel_mask) - 1;
+	ret = pf9453_pmic_write(pf9453, rdev->desc->vsel_reg, rdev->desc->vsel_mask, sel);
+	if (ret)
+		return ret;
+
+	if (rdev->desc->apply_bit)
+		ret = pf9453_pmic_write(pf9453, rdev->desc->apply_reg,
+					rdev->desc->apply_bit, rdev->desc->apply_bit);
+	return ret;
+}
+
+static int find_closest_bigger(unsigned int target, const unsigned int *table,
+			       unsigned int num_sel, unsigned int *sel)
+{
+	unsigned int s, tmp, max, maxsel = 0;
+	bool found = false;
+
+	max = table[0];
+
+	for (s = 0; s < num_sel; s++) {
+		if (table[s] > max) {
+			max = table[s];
+			maxsel = s;
+		}
+		if (table[s] >= target) {
+			if (!found || table[s] - target < tmp - target) {
+				tmp = table[s];
+				*sel = s;
+				found = true;
+				if (tmp == target)
+					break;
+			}
+		}
+	}
+
+	if (!found) {
+		*sel = maxsel;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * pf9453_regulator_set_ramp_delay_regmap
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the ramp_reg
+ * and ramp_mask fields in their descriptor and then use this as their
+ * set_ramp_delay operation, saving some code.
+ */
+static int pf9453_regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	unsigned int sel;
+	int ret;
+
+	if (WARN_ON(!rdev->desc->n_ramp_values || !rdev->desc->ramp_delay_table))
+		return -EINVAL;
+
+	ret = find_closest_bigger(ramp_delay, rdev->desc->ramp_delay_table,
+				  rdev->desc->n_ramp_values, &sel);
+
+	if (ret) {
+		dev_warn(rdev_get_dev(rdev),
+			 "Can't set ramp-delay %u, setting %u\n", ramp_delay,
+			 rdev->desc->ramp_delay_table[sel]);
+	}
+
+	sel <<= ffs(rdev->desc->ramp_mask) - 1;
+
+	return pf9453_pmic_write(pf9453, rdev->desc->ramp_reg,
+				 rdev->desc->ramp_mask, sel);
+}
+
+static const struct regulator_ops pf9453_dvs_buck_regulator_ops = {
+	.enable = pf9453_regulator_enable_regmap,
+	.disable = pf9453_regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = pf9453_regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay	= pf9453_regulator_set_ramp_delay_regmap,
+};
+
+static const struct regulator_ops pf9453_buck_regulator_ops = {
+	.enable = pf9453_regulator_enable_regmap,
+	.disable = pf9453_regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = pf9453_regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+};
+
+static const struct regulator_ops pf9453_ldo_regulator_ops = {
+	.enable = pf9453_regulator_enable_regmap,
+	.disable = pf9453_regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = pf9453_regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+/*
+ * BUCK1/3/4
+ * 0.60 to 3.775V (25mV step)
+ */
+static const struct linear_range pf9453_buck134_volts[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 25000),
+};
+
+/*
+ * BUCK2
+ * 0.60 to 2.1875V (12.5mV step)
+ */
+static const struct linear_range pf9453_buck2_volts[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 12500),
+};
+
+/*
+ * LDO1
+ * 0.8 to 3.3V (25mV step)
+ */
+static const struct linear_range pf9453_ldo1_volts[] = {
+	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x64, 25000),
+};
+
+/*
+ * LDO2
+ * 0.5 to 1.95V (25mV step)
+ */
+static const struct linear_range pf9453_ldo2_volts[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x00, 0x3A, 25000),
+};
+
+/*
+ * LDOSNVS
+ * 1.2 to 3.4V (25mV step)
+ */
+static const struct linear_range pf9453_ldosnvs_volts[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x58, 25000),
+};
+
+static int buck_set_dvs(const struct regulator_desc *desc,
+			struct device_node *np, struct pf9453 *pf9453,
+			char *prop, unsigned int reg, unsigned int mask)
+{
+	int ret, i;
+	u32 uv;
+
+	ret = of_property_read_u32(np, prop, &uv);
+	if (ret == -EINVAL)
+		return 0;
+	else if (ret)
+		return ret;
+
+	for (i = 0; i < desc->n_voltages; i++) {
+		ret = regulator_desc_list_voltage_linear_range(desc, i);
+		if (ret < 0)
+			continue;
+		if (ret == uv) {
+			i <<= ffs(desc->vsel_mask) - 1;
+			ret = pf9453_pmic_write(pf9453, reg, mask, i);
+			break;
+		}
+	}
+
+	if (ret == 0) {
+		struct pf9453_regulator_desc *regulator = container_of(desc,
+					struct pf9453_regulator_desc, desc);
+
+		/* Enable DVS control through PMIC_STBY_REQ for this BUCK */
+		ret = pf9453_pmic_write(pf9453, regulator->desc.enable_reg,
+					BUCK2_LPMODE, BUCK2_LPMODE);
+	}
+	return ret;
+}
+
+static int pf9453_set_dvs_levels(struct device_node *np, const struct regulator_desc *desc,
+				 struct regulator_config *cfg)
+{
+	struct pf9453_regulator_desc *data = container_of(desc, struct pf9453_regulator_desc, desc);
+	struct pf9453 *pf9453 = dev_get_drvdata(cfg->dev);
+	const struct pf9453_dvs_config *dvs = &data->dvs;
+	unsigned int reg, mask;
+	int i, ret = 0;
+	char *prop;
+
+	for (i = 0; i < PF9453_DVS_LEVEL_MAX; i++) {
+		switch (i) {
+		case PF9453_DVS_LEVEL_RUN:
+			prop = "nxp,dvs-run-voltage";
+			reg = dvs->run_reg;
+			mask = dvs->run_mask;
+			break;
+		case PF9453_DVS_LEVEL_DPSTANDBY:
+		case PF9453_DVS_LEVEL_STANDBY:
+			prop = "nxp,dvs-standby-voltage";
+			reg = dvs->standby_reg;
+			mask = dvs->standby_mask;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		ret = buck_set_dvs(desc, np, pf9453, prop, reg, mask);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static const struct pf9453_regulator_desc pf9453_regulators[] = {
+	{
+		.desc = {
+			.name = "buck1",
+			.of_match = of_match_ptr("BUCK1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK1,
+			.ops = &pf9453_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK1_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck134_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck134_volts),
+			.vsel_reg = PF9453_REG_BUCK1OUT,
+			.vsel_mask = BUCK1OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK1CTRL,
+			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck2",
+			.of_match = of_match_ptr("BUCK2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK2,
+			.ops = &pf9453_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK2_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck2_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck2_volts),
+			.vsel_reg = PF9453_REG_BUCK2OUT,
+			.vsel_mask = BUCK2OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK2CTRL,
+			.enable_mask = BUCK2_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.ramp_reg = PF9453_REG_BUCK2CTRL,
+			.ramp_mask = BUCK2_RAMP_MASK,
+			.ramp_delay_table = pf9453_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pf9453_dvs_buck_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pf9453_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PF9453_REG_BUCK2OUT,
+			.run_mask = BUCK2OUT_MASK,
+			.standby_reg = PF9453_REG_BUCK2OUT_STBY,
+			.standby_mask = BUCK2OUT_STBY_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck3",
+			.of_match = of_match_ptr("BUCK3"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK3,
+			.ops = &pf9453_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK3_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck134_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck134_volts),
+			.vsel_reg = PF9453_REG_BUCK3OUT,
+			.vsel_mask = BUCK3OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK3CTRL,
+			.enable_mask = BUCK3_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck4",
+			.of_match = of_match_ptr("BUCK4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK4,
+			.ops = &pf9453_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK4_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck134_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck134_volts),
+			.vsel_reg = PF9453_REG_BUCK4OUT,
+			.vsel_mask = BUCK4OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK4CTRL,
+			.enable_mask = BUCK4_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo1",
+			.of_match = of_match_ptr("LDO1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_LDO1,
+			.ops = &pf9453_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_LDO1_VOLTAGE_NUM,
+			.linear_ranges = pf9453_ldo1_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_ldo1_volts),
+			.vsel_reg = PF9453_REG_LDO1OUT_H,
+			.vsel_mask = LDO1OUT_MASK,
+			.enable_reg = PF9453_REG_LDO1CFG,
+			.enable_mask = LDO1_EN_MASK,
+			.enable_val = LDO_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo2",
+			.of_match = of_match_ptr("LDO2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_LDO2,
+			.ops = &pf9453_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_LDO2_VOLTAGE_NUM,
+			.linear_ranges = pf9453_ldo2_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_ldo2_volts),
+			.vsel_reg = PF9453_REG_LDO2OUT,
+			.vsel_mask = LDO2OUT_MASK,
+			.enable_reg = PF9453_REG_LDO2CFG,
+			.enable_mask = LDO2_EN_MASK,
+			.enable_val = LDO_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldosnvs",
+			.of_match = of_match_ptr("LDO-SNVS"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_LDOSNVS,
+			.ops = &pf9453_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_LDOSNVS_VOLTAGE_NUM,
+			.linear_ranges = pf9453_ldosnvs_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_ldosnvs_volts),
+			.vsel_reg = PF9453_REG_LDOSNVS_CFG1,
+			.vsel_mask = LDOSNVSCFG1_MASK,
+			.enable_reg = PF9453_REG_LDOSNVS_CFG2,
+			.enable_mask = LDOSNVS_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{ }
+};
+
+static irqreturn_t pf9453_irq_handler(int irq, void *data)
+{
+	struct pf9453 *pf9453 = data;
+	struct regmap *regmap = pf9453->regmap;
+	unsigned int status;
+	int ret;
+
+	ret = regmap_read(regmap, PF9453_REG_INT1, &status);
+	if (ret < 0) {
+		dev_err(pf9453->dev, "Failed to read INT1(%d)\n", ret);
+		return IRQ_NONE;
+	}
+
+	if (status & IRQ_RSTB)
+		dev_warn(pf9453->dev, "IRQ_RSTB interrupt.\n");
+
+	if (status & IRQ_ONKEY)
+		dev_warn(pf9453->dev, "IRQ_ONKEY interrupt.\n");
+
+	if (status & IRQ_VR_FLT1)
+		dev_warn(pf9453->dev, "VRFLT1 interrupt.\n");
+
+	if (status & IRQ_RESETKEY)
+		dev_warn(pf9453->dev, "IRQ_RESETKEY interrupt.\n");
+
+	if (status & IRQ_LOWVSYS)
+		dev_warn(pf9453->dev, "LOWVSYS interrupt.\n");
+
+	if (status & IRQ_THERM_100)
+		dev_warn(pf9453->dev, "IRQ_THERM_100 interrupt.\n");
+
+	if (status & IRQ_THERM_80)
+		dev_warn(pf9453->dev, "IRQ_THERM_80 interrupt.\n");
+
+	return IRQ_HANDLED;
+}
+
+static int pf9453_i2c_probe(struct i2c_client *i2c)
+{
+	const struct pf9453_regulator_desc *regulator_desc = of_device_get_match_data(&i2c->dev);
+	struct regulator_config config = { };
+	unsigned int reset_ctrl;
+	unsigned int device_id;
+	struct pf9453 *pf9453;
+	int ret;
+
+	if (!i2c->irq)
+		return dev_err_probe(&i2c->dev, -EINVAL, "No IRQ configured?\n");
+
+	pf9453 = devm_kzalloc(&i2c->dev, sizeof(struct pf9453), GFP_KERNEL);
+	if (!pf9453)
+		return -ENOMEM;
+
+	pf9453->regmap = devm_regmap_init_i2c(i2c, &pf9453_regmap_config);
+	if (IS_ERR(pf9453->regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(pf9453->regmap),
+				     "regmap initialization failed\n");
+
+	pf9453->irq = i2c->irq;
+	pf9453->dev = &i2c->dev;
+
+	dev_set_drvdata(&i2c->dev, pf9453);
+
+	ret = regmap_read(pf9453->regmap, PF9453_REG_DEV_ID, &device_id);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Read device id error\n");
+
+	/* Check your board and dts for match the right pmic */
+	if ((device_id >> 4) != 0xb)
+		return dev_err_probe(&i2c->dev, -EINVAL, "Device id(%x) mismatched\n",
+				     device_id >> 4);
+
+	while (regulator_desc->desc.name) {
+		const struct regulator_desc *desc;
+		struct regulator_dev *rdev;
+
+		desc = &regulator_desc->desc;
+
+		config.regmap = pf9453->regmap;
+		config.dev = pf9453->dev;
+
+		rdev = devm_regulator_register(pf9453->dev, desc, &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(pf9453->dev, PTR_ERR(rdev),
+					     "Failed to register regulator(%s)\n", desc->name);
+
+		regulator_desc++;
+	}
+
+	ret = devm_request_threaded_irq(pf9453->dev, pf9453->irq, NULL, pf9453_irq_handler,
+					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
+					"pf9453-irq", pf9453);
+	if (ret)
+		return dev_err_probe(pf9453->dev, ret, "Failed to request IRQ: %d\n", pf9453->irq);
+
+	/* Unmask all interrupt except PWRON/WDOG/RSVD */
+	ret = pf9453_pmic_write(pf9453, PF9453_REG_INT1_MASK,
+				IRQ_ONKEY | IRQ_RESETKEY | IRQ_RSTB | IRQ_VR_FLT1
+				| IRQ_LOWVSYS | IRQ_THERM_100 | IRQ_THERM_80, IRQ_RSVD);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	if (of_property_read_bool(i2c->dev.of_node, "nxp,wdog_b-warm-reset"))
+		reset_ctrl = WDOG_B_CFG_WARM;
+	else
+		reset_ctrl = WDOG_B_CFG_COLD;
+
+	/* Set reset behavior on assertion of WDOG_B signal */
+	ret = pf9453_pmic_write(pf9453, PF9453_REG_RESET_CTRL, WDOG_B_CFG_MASK, reset_ctrl);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Failed to set WDOG_B reset behavior\n");
+
+	/*
+	 * The driver uses the LDO1OUT_H register to control the LDO1 regulator.
+	 * This is only valid if the SD_VSEL input of the PMIC is high. Let's
+	 * check if the pin is available as GPIO and set it to high.
+	 */
+	pf9453->sd_vsel_gpio = gpiod_get_optional(pf9453->dev, "sd-vsel", GPIOD_OUT_HIGH);
+
+	if (IS_ERR(pf9453->sd_vsel_gpio))
+		return dev_err_probe(&i2c->dev, PTR_ERR(pf9453->sd_vsel_gpio),
+				     "Failed to get SD_VSEL GPIO\n");
+
+	return 0;
+}
+
+static const struct of_device_id pf9453_of_match[] = {
+	{
+		.compatible = "nxp,pf9453",
+		.data = pf9453_regulators,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pf9453_of_match);
+
+static struct i2c_driver pf9453_i2c_driver = {
+	.driver = {
+		.name = "nxp-pf9453",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = pf9453_of_match,
+	},
+	.probe = pf9453_i2c_probe,
+};
+
+module_i2c_driver(pf9453_i2c_driver);
+
+MODULE_AUTHOR("Joy Zou <joy.zou@nxp.com>");
+MODULE_DESCRIPTION("NXP PF9453 Power Management IC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


