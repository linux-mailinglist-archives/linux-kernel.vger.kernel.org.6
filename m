Return-Path: <linux-kernel+bounces-349536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D713D98F7F2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76F91C20D0F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B431AC438;
	Thu,  3 Oct 2024 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZtBOLyJe"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C71B85F6
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986496; cv=fail; b=TtZjfquA/f2dJTjmiCR7rSu+vscWf+YHUxuB+/777qB6681DUdvtD/wmItQPMkyp4gy14AfkZ6HIQ6zTSOyGBftYAaxZqng07mxZbinH4iUiSFTdLOD1pyyoSvFuHs37H7f19G8RjShGR5gSlWpdvwfr72jQz61ocED+pEJi1iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986496; c=relaxed/simple;
	bh=Yb5+glUNRPlFHl6jLjq7YLk0v1GoaUIekn5edA0U3j4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RQbl/Yjn/nQWh6UjgU0fkIy0ZavLMDskkYqizG7xR21Tk8gRq1l2hbrXJYUqvIN3Zj7Fb+NXQLsUid6a3J+o6Zla1JkjcNHaEbbEDNHlxpCxb2AVQb/ib95+RqmwrVo9pDZS0kBuPawHMFBZOMBGZZ+xtTDB9B0jGL74P1Vnfno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZtBOLyJe; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1c83FSXWtwL3gNL37mEDlLKSfcLcKNEZtJVsbeUp0o+6awlU0HpCQDx1giXiNu5NS9yAKNHtOZqDoGCxB91pyu4Y72eopb9alrniZJxVc0AkRf0L/uC86IJBFJ0tuXVGqOk0TNUbzyS7uOBKt6q4qj6gLEKIJchdbA+RxKZ4HwiS0Vh9IBSCAe6BMDgTObst06BT8L63M7CpNpS364Vr5Zy8Ik8Mv3OWlU+jTM4vS0QdML8UMG33249vbjqDLNWfwKkbmqAhBDz1+VzVx19Ly7B0+zZd+9ZMdvc4qFfEHNdasGjN65GDcsthMpLv0Xq9XTqGF1BPIt/d48z3rSefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0if/ydm24wIbbYdZueK9zG2st0g0wGo5taHXKt9KGfI=;
 b=hW9fUyC/r09Mnt6GG2L9Lo467qc/b6H3A5VUnPym5ay01s7qIqiHrWUke5sTogeUays2mMckLnOrev0NSESynlZc5DnAjB1eAYYoR0KMrSREgOCmpp+jk94YQMdwv5MCSZYTnbFwtAGmt1aNsN3SWjVRilACArmh1gDGyyzrB2z9/C8Xzj67zcVjjY9F24AS13Z6oy9V7JLoWUZxe4i5K3N+P6RD2yK8WGUBafvQsdqhvdlpJTQylTsHpACjvyMcP9kRJboU1TPVR5J3DZvgVGznU8SlRqhPMafd2PUYBO3ZgE+S/aHJHtffTQcoSe1OmmcvSdvQdPPl6fzCm48vdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0if/ydm24wIbbYdZueK9zG2st0g0wGo5taHXKt9KGfI=;
 b=ZtBOLyJecUzODAFwknZE2zr+1ZJPkFt2U1DAuqVrIwi+fX2qdPkTGfTEzVygwaBbL+K5HL7jDCVj5bOzwy1wprqCk3wbnvbA95Ol3/tS/VfMdMngl5bIOzvzs67ZylnDulENJWo9YAMgC5RAOEHyfaYp6mVXNgPamGDzzW2Zpd/hDgtDmIst9E/gsy372fyf9MIrANVpg3rZHhVLsdVRz5OOJ7WjYk70MY7R29RY5TGb5QvdZRubwcnAqJdXo4aAcpIsC2QDmrbqxVvy2vwwrziywxK4ufYN4devC9Pp+dzrm8X+SvYyoQ7L9Wyi/dUgBpr8txJmd6Hq8xmSmUDvFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7481.eurprd04.prod.outlook.com (2603:10a6:102:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 3 Oct
 2024 20:14:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 20:14:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 03 Oct 2024 16:14:21 -0400
Subject: [PATCH v6 3/3] i3c: master: Fix dynamic address leak when
 'assigned-address' is present
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-i3c_dts_assign-v6-3-eae2569c92ca@nxp.com>
References: <20241003-i3c_dts_assign-v6-0-eae2569c92ca@nxp.com>
In-Reply-To: <20241003-i3c_dts_assign-v6-0-eae2569c92ca@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>, 
 stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727986479; l=3769;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Yb5+glUNRPlFHl6jLjq7YLk0v1GoaUIekn5edA0U3j4=;
 b=EiWoxD2VbobWJQpPxlrQ2U8mFYbrEU/I/ns6W1eQl9ac8bLf/0xgx6EY/pFbtZyPzJ2JDjEZw
 fWWUSlb+1tUCS60vhhhFSP9mUGdAqXsEKMzZFeiqDgylkopLXu9pjde
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b006c73-d064-42c0-cc31-08dce3e80a4f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?amt1WWd2SHRadzh4c29BNCs0VVFXTjRiNHV5am15a29jSGlnYlpmZkhHdGFK?=
 =?utf-8?B?dlAvekxCYi9sTUtDWmZpV292WEg5b21RM3N2TW9raVdmNkl0dGhnMnIvdE5N?=
 =?utf-8?B?V1dCKy9sWDEwbUxjSFJzdDUxYnltWk92ZG90YWhuZGhWMTdyV1VvdHRsZER4?=
 =?utf-8?B?ZGFOenE1aGJrOEl0UTNvR0lHM1ZGTUN5bjQ1SjZIL21XRyt2RmJlL2ZqL0p4?=
 =?utf-8?B?VDZWMFkwK1ZPbk1hZk9RVnZFNjlNU3gzV1ErY0l5Y01ISnQ5T2RQYU5Oa3Bk?=
 =?utf-8?B?WVJWdkEwU3JXL3VqRHFOa2NvM21IdkxvU3NPcGlYNlNYMjZ2Vm5jbWFESHdI?=
 =?utf-8?B?OU1zc3NqcXRxZzR6eUFQR0pOaWtwdmgzNTk1cjRPbzFTaTkvYWFQUVpMZDJ5?=
 =?utf-8?B?d2Z6V1A2Z0dWOW5KMUxSWU9vektpa3YvVUVFWWF5WDkrMU9qdXlLTE9CRzgv?=
 =?utf-8?B?RUdPMzUwUjJzdmZuam9vMWpiNUlZNm84SHhKM3hkVm5pTC9xNnNFd3lQeTZa?=
 =?utf-8?B?TjNKMVZ5dWtlZktvdTlqQmxJaFM1NXZUYWRqbDBEMGkwYlpHSVRKaUxLcnJj?=
 =?utf-8?B?U0VaOG5NekVTUDdpSW9mTkRDWHVNUytXMUhyZjNsS2FqY2M0SmlOLzUveFA3?=
 =?utf-8?B?UTVhL3E1KzJGTG5aRUpLMGVnaHRzYzVndzJJZG9jQ2xGaFhQNE5CYkZOTmdZ?=
 =?utf-8?B?NEIxQS9uYUNEN2VFUGk3bDJBT0FacmdyRHhJTnUzbjZiVWQvb0wycGZCeXZv?=
 =?utf-8?B?L21DUFMyR1pKZDR4NkhQcVRFQzQ4N1N3VmZGZExxc2gxQUZvWkI5T3MwcU16?=
 =?utf-8?B?d2x4Y1ZjcFJuTjd2dHdJdXZ5TXBzVHpYc3NNM3hYQUJHMjF0bWx4V1RrVDBD?=
 =?utf-8?B?ZjZ5dzUxRm0rckF2eTNyNHFNUkxOWXdyMGxRcjV6T0dsMDhzN1NoTVFBYzkx?=
 =?utf-8?B?aFZCdnJ3VXYrdTBBbW5pdGgwZDBxTzl4NEc0SHNpNG94UVZFR0lyU3pZcG8v?=
 =?utf-8?B?V2RZc25mYU5wM3Qra1BlTDRKUnk3MXBnZzdmbm92ZUtOWGsydXpsOXRtamxO?=
 =?utf-8?B?dTJPbnhhcTdBTC80V25qQWhxbTlEVXg1OXU5UWZSYnJzNUZiZDIrNFN6VnNq?=
 =?utf-8?B?UjNoa1NJS25Kdzd0TitiSGNveFdRVzl1emVzRXNGVnB5MzZqRHZ5bnliRi9i?=
 =?utf-8?B?SHpXWWFHVUZiMEJNWXJ1SDVGK0FrOHhQeEVhc3ZSejd5YXFjM0Q3RFh3Wk9w?=
 =?utf-8?B?M1NTYlZDM3ZqSGNtQStPdmpqQWZ2Z0NkeG9reXBCcDNWaWNKZDlGSW1rdngy?=
 =?utf-8?B?OHdSUzFYdE1xY3FSeko2S2NpZEpDOE9BN3AzR1ZoVVh6K0hJSm9tbVdERG81?=
 =?utf-8?B?RW5DWlBDaDVmaHZXMUQxSlBleC9qYTZaTVQzQlRHQ1RJUWZnV0ZDUUpjSHVh?=
 =?utf-8?B?TjdNdHNMRHVJbkt6WWZTZE04TnpjZS9XRm9xN1gyQ3g5cmlRdHkzVzFXM202?=
 =?utf-8?B?MFlMTnhYOWIzc1U3c0dDT29WZHJadWtXNHpnQ0Z6a0lUOW85ZXlIVlU1QjZm?=
 =?utf-8?B?YXpPcllNVlkyam9ZYmVTVUxNOU5jS2RVb2xJbGVhR1BLZEVLWnk3T01RaXF0?=
 =?utf-8?B?UjVZQnlFcjVOM1hzNnM2a09UL0xvM1FaM3lNNEkxTEZCbENZd0lTWkpUWFdt?=
 =?utf-8?B?bnRUb0h0dU52aUFqVVIxUHpzNXEwalZyekgzM29ZRzl2NUlIZGplYkEyeWZ0?=
 =?utf-8?B?YVZxeC8yNTI5dEJzSlViUGZvVGJrYUg0QmpUeHU4Wk1FR3R3T1ZldGpwVThr?=
 =?utf-8?B?azZrc08rL0w0VEduVXZtZz09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WTF1MWw4NE9UR3hhV3loNFJ2T1BkaXFzek5FckU2a1RpUHROWWthUHUrS09J?=
 =?utf-8?B?TUkyeldkd0R2aCtla2hQMi9BYkRiRDRZaDFYbUJhTm02NmxFd0lrdWdnMjdy?=
 =?utf-8?B?SlR2YkxBVEhMdEl1cDQwdzBOQ1YvUkRNcU9VMmR3TEZLYk5jMVlrdGdJL0hj?=
 =?utf-8?B?LzlIN1N6djk2NjhFRVRLT1N2OFhSVk5ZUlYxcmQxeWp6NExDTlYvQi9xV21H?=
 =?utf-8?B?engzejRUektNd1orTWd3bnFqam9ZNlFGM3hSUFRPRE8vMGl1T2FvYnJOczVD?=
 =?utf-8?B?NUgxWXhUWUlTQ3lqcndqNm9hSVZYNGdsTkRxVWkzSExERFpmU1UrL2RsTVR1?=
 =?utf-8?B?dm5KM3ZlUEREalk4R3VGengwdVZmeG5LNnBYZFNqSk5TbE1xbktJNG4ybjdm?=
 =?utf-8?B?T1FoMjRtRnpaZFFnN0tBRVZWQzRaRVRlRXRPMGE2OWF4SnVwYTFjVWpYc0sv?=
 =?utf-8?B?c2h4dXREeGt1M1g1NTk3dmN3RzVmSTQxR2Y2MUlvUWhWSXU3OWtVNmZ6alpn?=
 =?utf-8?B?N2J4Szd4TTl1WTdKM0tDL3Bta01VSTRsWGdLenNwMk1nN1NSWmNLYU90NGxs?=
 =?utf-8?B?L0xFNEVxUDhZTkxKaERRZFA4UjRCTGtja3YzSlFnVHpJNzJoSlM0UnFMRFZy?=
 =?utf-8?B?NElqTW5Db3lsSmdqYkNFN2dSY0VoVHgrRGtVby83eHIxRHY4ZTVsZW5pRjBK?=
 =?utf-8?B?Z3FQTUJ1ZnpPbXRPd2ZCdU9QMWZmK016MUNSOElVMDVxTmRxMWFFQ0xWVlVT?=
 =?utf-8?B?VVY4eG53VXkwcWU2MzByUjgwQ3hjOEVYKzFIZmpUUDJ1SWdRempqSkZadGJM?=
 =?utf-8?B?eEJHVUh3R0tFNU00NUFBOFkzajAyQTB5NDk0Q1B4eUlNSFh4cEkvOWNZUnpT?=
 =?utf-8?B?U0N4NlByMVJ6SUxiYTQ2aFljRnJoV0M5Tlh6T09MYUdiS0J0ZXBvL043RFl4?=
 =?utf-8?B?Y0psaFRiWFYzaktFMnBsOHJaaHlSUTNoeERMK0VzbEE3NHlVSCtRMEFBRFNh?=
 =?utf-8?B?ZlFxSFpza1laLzNxSjVMNEN4MDJQQ3pQTFVHYklHNGFmakhwbXhpS3pVMkhQ?=
 =?utf-8?B?V0pJVlZJM0U3NG41MUxWb2V2TktUQWR4aVBIR2ZWc3hJNHZkYVZWWkN1TmYv?=
 =?utf-8?B?R3J5c2ZPNFdKdHlleW5jbFAxUmlLU29sSzAxR1JYbHlSQVB6WG1MTC96Vjc1?=
 =?utf-8?B?V0dRTzFCY1NJdjdPR2cydWpTRUltUTNhdDZ0UHR1c1JjNm02Ry82dExJc082?=
 =?utf-8?B?aTRXNGVSTWZkdzk0ekRLa2kvZ21xZ1Y0c1hPYjhzRWRtdUMxNnFwenQwQUtB?=
 =?utf-8?B?eTJmR1E5N1ZPazZ3d2QwbWpiQVJuZXl0dTh5QS9sYVlTWURKOVNMOXA3N01G?=
 =?utf-8?B?UTR4bkpjY0NpOWo4eU02ejZMNTVPc1l2ckI5NDZBOXlXZGw1Ky9BTitTMEdU?=
 =?utf-8?B?SldFTGJrWlR2Zklmc21nbDNrWUhGVXVtZGlLcm9PT1dOMmlNdXFuU2xEL3Zk?=
 =?utf-8?B?ais5ZWMvTjdIUEtpcWQvL2V6c1EyK0pxZG5CVGJLUlNhRkM5b0NXTjYrTU1J?=
 =?utf-8?B?ZS8yRjMvOGk4V3VDczVyOXoxcXdTOS9RV2RURUZXVUVSaTlWY2FqZ3RsQ0xX?=
 =?utf-8?B?ajQ1VjNTemVOTlo5UEtidXlEVEJGenppN0FvS2h4VDdEdURaeXJaV1JRWXdl?=
 =?utf-8?B?anl1dFNUdVpsQjZNK3U1eDZUT2ZnM3M3R0ZsS0tUSjh2TUxLZVhZWDluMVQ1?=
 =?utf-8?B?bTJ4Ulk4YWQ1U0hxa0NueDIwNDdDdlJ2UTkxU0FJVURxZ09FQTJhb0d5VWU3?=
 =?utf-8?B?bk43clQ2YU5tdTNkRE5iWFZQcnVkSDh4VWxPNnlHbGdyM0J1OXpwbDV2TS9n?=
 =?utf-8?B?dW1INWZUL0xGZnZJdmtrWFV5UXBjVHZ3ZzJudXFxbUtNWU1teDRreStCK1BG?=
 =?utf-8?B?ZTFQK3FPZGJmdmI5RFpaOUE1SGlpMVZudm50YXlNWFNOWHVuR1RZdlVGUDhX?=
 =?utf-8?B?WXZWby9jVlVDYVJrSUZIMmprSkxPLzIvUWNRU2wrbytFZEdmekpURCtzOVJK?=
 =?utf-8?B?VWV6QTZYVjhPV2FRWmh6T2lKYkljTWhudU80UDVsaE5mWGw4QUMwaFByZzdS?=
 =?utf-8?Q?nI5o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b006c73-d064-42c0-cc31-08dce3e80a4f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 20:14:52.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdFY5mw48Em1/shn/mHPwrLpXSHPvbGPtKKWdsePYy9CpS/RazgKtTXu30g+KDbGZv0J1xHsh8A1pqBBJwhCIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7481

If the DTS contains 'assigned-address', a dynamic address leak occurs
during hotjoin events.

Assume a device have assigned-address 0xb.
  - Device issue Hotjoin
  - Call i3c_master_do_daa()
  - Call driver xxx_do_daa()
  - Call i3c_master_get_free_addr() to get dynamic address 0x9
  - i3c_master_add_i3c_dev_locked(0x9)
  -     expected_dyn_addr  = newdev->boardinfo->init_dyn_addr (0xb);
  -     i3c_master_reattach_i3c_dev(newdev(0xb), old_dyn_addr(0x9));
  -         if (dev->info.dyn_addr != old_dyn_addr &&
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 0xb != 0x9 -> TRUE
                (!dev->boardinfo ||
                 ^^^^^^^^^^^^^^^ ->  FALSE
                 dev->info.dyn_addr != dev->boardinfo->init_dyn_addr)) {
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                 0xb != 0xb      ->  FALSE
                 ...
                 i3c_bus_set_addr_slot_status(&master->bus, old_dyn_addr,
                                                     I3C_ADDR_SLOT_FREE);
		 ^^^
                 This will be skipped. So old_dyn_addr never free
            }

  - i3c_master_get_free_addr() will return increased sequence number.

Remove dev->info.dyn_addr != dev->boardinfo->init_dyn_addr condition check.
dev->info.dyn_addr should be checked before calling this function because
i3c_master_setnewda_locked() has already been called and the target device
has already accepted dyn_addr. It is too late to check if dyn_addr is free
in i3c_master_reattach_i3c_dev().

Add check to ensure expected_dyn_addr is free before
i3c_master_setnewda_locked().

Fixes: cc3a392d69b6 ("i3c: master: fix for SETDASA and DAA process")
Cc: stable@kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Chagne v5 to v6
- fixed version number to v5
- fix merge conflict because change function name and macro name.

Change v3 to v4
- none
---
 drivers/i3c/master.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 68411f1cf80d6..42f610636fb7c 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1547,16 +1547,9 @@ static int i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
 				       u8 old_dyn_addr)
 {
 	struct i3c_master_controller *master = i3c_dev_get_master(dev);
-	enum i3c_addr_slot_status status;
 	int ret;
 
-	if (dev->info.dyn_addr != old_dyn_addr &&
-	    (!dev->boardinfo ||
-	     dev->info.dyn_addr != dev->boardinfo->init_dyn_addr)) {
-		status = i3c_bus_get_addr_slot_status(&master->bus,
-						      dev->info.dyn_addr);
-		if (status != I3C_ADDR_SLOT_FREE)
-			return -EBUSY;
+	if (dev->info.dyn_addr != old_dyn_addr) {
 		i3c_bus_set_addr_slot_status(&master->bus,
 					     dev->info.dyn_addr,
 					     I3C_ADDR_SLOT_I3C_DEV);
@@ -1959,9 +1952,10 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_rstdaa;
 		}
 
+		/* Not mark as occupied until real device exist in bus */
 		i3c_bus_set_addr_slot_status_mask(&master->bus,
 						 i3cboardinfo->init_dyn_addr,
-						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_DESIRED,
+						 I3C_ADDR_SLOT_EXT_DESIRED,
 						 I3C_ADDR_SLOT_EXT_STATUS_MASK);
 
 		/*
@@ -2125,7 +2119,8 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 	else
 		expected_dyn_addr = newdev->info.dyn_addr;
 
-	if (newdev->info.dyn_addr != expected_dyn_addr) {
+	if (newdev->info.dyn_addr != expected_dyn_addr &&
+	    i3c_bus_get_addr_slot_status(&master->bus, expected_dyn_addr) == I3C_ADDR_SLOT_FREE) {
 		/*
 		 * Try to apply the expected dynamic address. If it fails, keep
 		 * the address assigned by the master.

-- 
2.34.1


