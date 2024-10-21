Return-Path: <linux-kernel+bounces-374692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2159A6E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E8C1F21BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7E11C68A0;
	Mon, 21 Oct 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G2fWNOls"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BFB1C6888
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525539; cv=fail; b=pF0VhUTiAnsAch6iTfSGqSu1JV4lDr+KzefVsdlMDt1E5KDQnRI8MWnNVxSHMdomhVWm+gUAMpKIUHBwwHZPHn9V6xkhD6SdiuIMAEZGNsTsFCxGgInrg+c/EmE2CeriWzPi6LcAR62nQudh+LVNr91zvsFgKeoEVAHJCmlMYtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525539; c=relaxed/simple;
	bh=Tya2XmHY6NH6zMFyqVEsaXc69z5sFxx57Xl7UdOsNx0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uYWMlamZHOuvEVw7Xprnci70jbt660gZ6L568a293pooN3z6G6AFnfczM45icrnFYD78ElyXAWMIMfGzFQNJ+5YSKbG9Be/s43KmlHyZES3BaysJdgdHM5QNBFaT7/zBuDAlE2YlonzOE15C73B3hAaazxpH8n5wO7RcOxyKoVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G2fWNOls; arc=fail smtp.client-ip=40.107.241.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZcII9FCjwEP1qJSybE1NGLzIEGTQpUhbQlu5I63NmQCIpzO/QakS7upxUaIEq1QZdERXQqtTqqBD4Djo5nMTHuRqepBfaY+D6hk5KAcY8OUW2RfU3M/lmJvJbR+07ZNsS7+lwDVJJs603xkhaSz5EPy+M53jf//DkrT664EAdw5tZn0pFfBUNJ23EvFzRnGBcg3tyHhCs5E38NW4WLIMRiBUpcVeao1rQvbH9bPhWFpiDZ3XmiOMsQEnYWE1jbt5RbnABnibi8TD1bRkTBmWa9wkS/HGgIwbQJkL47Pyq34P7tHABJuS0l555reLdtSOZxKZSTz14e1aYL9AMbI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKVFTv98vNzXpRySipXp/ftAZEd9KVV6pcUGJ8L1bP8=;
 b=AKqYkbbL88IwnXDO6FQqLk68ZFhOkJqzCZlqufAUQZG/cnO6A0go/Xp2LhIjUmRG8IMhDLBt5dDfHCkB/+aVVUyISpAiO/f3vmGemrABl1XoQTPyKGWZWotjj6YPTaMNv1RIoxxlngC0b8eS0dS4u9hc1iwWMVYZdEQ3SLaYGbDhov2SLBZ51QDJrWqhHGe1j2mHBWHT7hC+TOrn5Y7z/L+friuQJiKIpl67Rz/4KxeCo51GYWGxOQIpgikn6pZa/CW0diQdXaJiyEvz2HXTN5q/HDy2HG783MvnQ7zXpTGBU8rNH9XGHIwRUKkIk/qeNKtpglR+bbVEzBWcQDKOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKVFTv98vNzXpRySipXp/ftAZEd9KVV6pcUGJ8L1bP8=;
 b=G2fWNOlsNlgzshf7J6CNrViCxpF/aPO1y4YqrZkioT6UxG+Y7LbNQI974nyBfg+l2fHGZ/01obqmpbuWDHQnIlweyyg37s0m2GnQVD1G/O3wrGYODUVtmpI36AXMseHyaxsoJEyn8PutRYbxQN9gJLfPBb4h0cGQbSVzBTohx9ZuAnGPrzV2omBwbjk36mY3njxx/jAUYzbGujZdo8jR9GA9IZ5gEk8J9W5pXZ5bu9imYwH/byU6Xuerxvzfhc+yfs2TqV9BPHdpx0kOc/iw9Mpj8aaTFhB4s1wBZHrHfBwr+hITBm5mzmSQUP47w7yTSQddFNBbI4fOPoED1ppd0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8417.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 15:45:33 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8069.018; Mon, 21 Oct 2024
 15:45:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 21 Oct 2024 11:45:08 -0400
Subject: [PATCH v8 3/3] i3c: master: Fix dynamic address leak when
 'assigned-address' is present
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-i3c_dts_assign-v8-3-4098b8bde01e@nxp.com>
References: <20241021-i3c_dts_assign-v8-0-4098b8bde01e@nxp.com>
In-Reply-To: <20241021-i3c_dts_assign-v8-0-4098b8bde01e@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>, 
 stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729525518; l=3908;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Tya2XmHY6NH6zMFyqVEsaXc69z5sFxx57Xl7UdOsNx0=;
 b=t6uTeFEwP7Ozw7qXtZDcbwHfNdOoyijvYI/e8WeP5EgRYpwboouO+X2Yg5vOjfl/Rj351bRPB
 mvO5kv1BAwnCaW1CB1zFqBO1KRBqRgauMiCn7Cigk7cglFeDN+nG6xu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:a03:100::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc3e037-4722-4d2f-7751-08dcf1e76642
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aW1Ga0NYeHpKTFloaWx0TDBvVjFXT2VINk9WbmhxS2JiZmpPVFlNZVpSRzFC?=
 =?utf-8?B?U3ptZWxlUEU5bUpCL0xMbmZOYkdCaGJBVzcvVXVLTmtPVnBJWGpGUHZEaCt3?=
 =?utf-8?B?SUlRdFFkR1hENXdXMzJSSWNRRDAyUGROQlcyVVc1bitEMGE1ZDFoNU5NSTNp?=
 =?utf-8?B?MkszUmxIc0pEcjFiV2hpUHlUSXRwdFJtZXpkWndJZWxHM1JmV0MyWkNVei80?=
 =?utf-8?B?NzBQeHdnRjlGVUtUTWlZNlc2UkYwNXFFcENBUlFrN0xkNWFZVWRJWTY1dHYr?=
 =?utf-8?B?KzFhak9OeUNKbnlobDZXT3F3TnBWUkhMMTdFRjVucEVWZlJZZUErcFA0Zzdn?=
 =?utf-8?B?SmVvQzFzYURmRWVBVjVmRGlmZ1hGWGNvKzZxd1N5VDRKaW9jRUE5eXd6cEJO?=
 =?utf-8?B?TjN3cmw0RGtRNUpPeGJaM3RSL1duTStCWDlzRUwwTzcwU1doaG1kajZjN3VR?=
 =?utf-8?B?NXFEbC8vQ2VTbmJPWThITkw5Y05OWERlQnYvUnluRk9zdHdTazEwNVZzOUJw?=
 =?utf-8?B?OGF4MVBHT0RGZGJpTk9TdGJ0RmEyZk9vZjJzeWFHK0Y0OG84QmkyTGxnRlVr?=
 =?utf-8?B?RnA2d2pjMFhNb25CTG9OT29hOTRSTlF2dUhudU9vMFoxam5VVEN5eVFyY0x5?=
 =?utf-8?B?bE1IM1R5NjZBUmREaUFFN04zemc0U2JIcGxnWnJhVktYUUNZelhTQm56MTgz?=
 =?utf-8?B?dWZKQ1VubjRVNjZsT0U1SFp4WGpFOTFhZWdlaFBYVzExREhMajNNUlFtYjVn?=
 =?utf-8?B?Mjk1STJrOWFvVmdrUVlIa3ZHYTVmZXJreVJHRHhJSS9DNEJaeUY1SkNFbDFU?=
 =?utf-8?B?K2JoM0Roeit6d3FGdFZhZGY4VHliT2NFcWpZK0VaemRGYXk1eWRwM0JjczFl?=
 =?utf-8?B?aGVLZzhBREVYWGpSaUZzNFlJc1VNdDJvQ08xZjRMQTFHeWlSZllMK2FtL25S?=
 =?utf-8?B?VW0rWllUWkZacE5yMTFjTXU1aTJST3Era21LNm1OdjVITXJDWmc1SjU1K1R4?=
 =?utf-8?B?aU5ubnI5eHFDSzNKbzdkZUpoVkUzOC90UzlRVjYyOFZnTTNLTU9pakVpL0tB?=
 =?utf-8?B?d1E5UUx0T2puTlVMMmpzZ3ZPREU3ZzVVR2ZOY1FORjJpanNQRjZ4bFZOUEtx?=
 =?utf-8?B?L0hKYW9MT0x6T2s3ZXJHdFBabWI3REZNSFg5Ykc1NXVqQnJla3RsKzNTUGR4?=
 =?utf-8?B?c2Q0bGsrdkcrWGRpcXZOYVNWZVlwNWdmYU9sUGYrNEVOM1pMN3gyM2RJRVRV?=
 =?utf-8?B?VjA0cUFlamU0dmVJTk5qQ3hpSCtJbm9MV3ZoYzdYendIYVZCTjVESWJTcnFC?=
 =?utf-8?B?SVRKekpxaXJYOVdEZS9kRTJWQUVUT2NCU0MwRkVFRy9KU24weU1SK0tzeWhS?=
 =?utf-8?B?YTdBVHdpRExKZWk4c2pTLzkzaXBCWHpjRXB0aFJLcHNlVDlSc0hQSVB3TzBl?=
 =?utf-8?B?THhtblRhSExVcFFEbUVKYnQ2NDBCOVpoVUF3NkdMVHl1MTU5K2ljVHNyaEZq?=
 =?utf-8?B?UlVSWWVkQnBGK2ZheDYvcloyRUdidlAveGs5Z3oramd0bENnVjNjRXZ1c3hw?=
 =?utf-8?B?VFNqNTJOUmJ3aWFWeUUvVGlQYzlUbkdHQ3VxR2tqSlNHekRmQStQSUFOOWll?=
 =?utf-8?B?WE1yeURpWTdSMStMRnpFOU8rNDNqNDJMWW80UHBIT2IzVWVGNTlwMlowOUUv?=
 =?utf-8?B?Tzd4VGt0Mks5NUFDb05yZmUvWFNvdDZIUlhlRkE4dUdEUm9KZjhiNDRGc0J2?=
 =?utf-8?B?UGFmOXdUYjFxQUc5VlY3aUZRbTJwZ1VlQlMxaS9vSTNiVmltNFdMMHd1eDdJ?=
 =?utf-8?Q?mc5yXEzL8GvB3bBHXHor2IqoxkWMd51gyk8/Q=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?enhKZXR3bTRWdGdsa0N6UnQ4cFNkUllsbS8vd3NMK29zaWo1aldUWEp2cFFz?=
 =?utf-8?B?eEkzTEczajhpZm9XQTc0VENNTHpJRlJzdGwwcStXSFcvZUl5MTVnUjJFOTNs?=
 =?utf-8?B?TlgydEdwTUZjQ3R1SlE1WEV5RUdyYWozM0ZNL3VkN3ZhSlJrTWFaaS9wMTk5?=
 =?utf-8?B?RjJrRng0SkFyUm4raFo0cEZhYmRxc3dUMTVENW9Ka1RQQUFmU2hTUzNTa2tG?=
 =?utf-8?B?SFlCSDRxZ2ZIN2RUWWhFVGZ6ajI0TjMwQXE4aEhSSnRrbW01ZzRzZm5jSHRk?=
 =?utf-8?B?WWxZYm1zQm03cTBhdzY3ODJacDA4U3Z4aUNxbGFET1JsaHZZaGgvSyt6UXpV?=
 =?utf-8?B?d0VncTJHNUZOSmI5dFlKb3dqcmV4WkJJUEdCdmJtdVdTRCt4OHgwZStVRUZS?=
 =?utf-8?B?NlB2VDkwNXVDbXdFajFaRlRkcmFlT2N5Mk5La2VROWR4M0YzU0dDek0rL0sr?=
 =?utf-8?B?UldPVmpQbEgxYmNtaTgrek82WDVHU2l3OURCM2IrREE2MEJEOTBuelJ6aW56?=
 =?utf-8?B?aVhRM093NXBEd2xwcWlvV2V5d09ZZEVHN0wvVXdsMGpvdTc0SVc5bk1CcjNC?=
 =?utf-8?B?VGVPTGVybkZPVzlMSXRKSi80aFpXYy9lenZMUStFdlU4TmFWeWNWKzRsTlN6?=
 =?utf-8?B?STlGbjU0dWZMdnVrNS9lNGE3V08xWm1uT3ZGRHBiNE9XME9WYXMxUlJKSVV6?=
 =?utf-8?B?SktkRHlYR0lPbkllbmJzVDZxZzNKNnU1ZzRzRWlQWkxwUEwwak1nV05jN1JQ?=
 =?utf-8?B?dGNnd21LSlQydDFkL2Y4RVRqbXVIL1FGMzhOTEFnOUdoQjZvS1NmUHlCWWNE?=
 =?utf-8?B?dVhnaisySlN3WXNjb294QytEeU81M2NBNm5tTk4waDZhdHZHTnNIdnBHSDFP?=
 =?utf-8?B?eW8zSVRIN2F5K3RLQmhRMFl5dm03NEhNdE5oYi9kaTk3QUN2aFgwNzd2Y2pD?=
 =?utf-8?B?cnJEMWQyLzFqTU85czV1RFFraDI0djZ3VmJxV294MWFrSjMxaVhQVFVKaDZi?=
 =?utf-8?B?V3BsSGtndXlrOEhsV0hrczB2RjVweWk3RmliZERMaGJDMllJVkl6NWhMNGpX?=
 =?utf-8?B?QWFmSGlOQk9wSG5rZmFrcTlxQzRreVhpWnNGa1ZVT3JFM0RpZWY3OXFGdi9s?=
 =?utf-8?B?SDNiNVJVcWU4NC82a2JCSTQzZG00VTJYdmlPVmtlM1ZGVGdXRWRKRVF1cDVC?=
 =?utf-8?B?T2NCem51WUxZYTNjZDkvWGp6S0s4QzRpdGtFNC9GcXlBaTFKRGJyUGd4TWxR?=
 =?utf-8?B?ZHN2OEZpSExtRXRyak9DUXVNVC8xUmV5eENsanVhRi82OW4wSXViYS9yZjRs?=
 =?utf-8?B?L0V6MHZ3MUVpRDhVbFZTK1IrMjkxT21mS2pmSU1YblAyUDlMclV0NFFTNWlw?=
 =?utf-8?B?aVB1NTJQN2wyMHZoNU9uWWhOY3FHbWdmSTNTaGZjcU1wSTh6Q2QrckZZQkNU?=
 =?utf-8?B?MTdDMDNKZFNLeFMrVFhIUHVLVHdqQkJiQ3hjbzFkYllpbktJQWdOOVRyTEx4?=
 =?utf-8?B?eFRXdWZiYjZCSXI4Z0xUMlNUS1lVNU5JN0Q4Y2RxWm1IeHVERXZSNHAvajV2?=
 =?utf-8?B?OStIUTA2bFNMVTRaL3V3aGVxRTVkWjZvaFJlc25nMzFicHE1K2tZWFdyY0FD?=
 =?utf-8?B?L2tib2lCZW94M2VSUEg5K0pWVWpkNXByOUdVckVWbkFZT1pRY1BMYW1UUVcx?=
 =?utf-8?B?VXlHQmpLS1dUSTJkREZ3VjVjR3QvYlU5eXc2bnkvS25mWkloTzVtUnpxKytu?=
 =?utf-8?B?SXJxZE9STVlWbXc1L1V2Y0lkd2tpb0xZOXFqSGJmdGJ2TGxaN2tDVEJaKzUr?=
 =?utf-8?B?THJKMmhhV0w4b3lvTTZIbTBGRFlvdCtTL20wYTJxOWdaZE13OGQ4WlhweGhs?=
 =?utf-8?B?d1BkblNvUDV5NjM1SzBqSUY2SDg2N3JmVUxEQktqbXBmU2tUZjNlTG50bngw?=
 =?utf-8?B?TldkR2tWZFJpRDNrNGVHSC9mWHNOdjhPQVNFMDdoNkViZjFMak9ocnJlU2Ex?=
 =?utf-8?B?OW5NWFhNeUNQQkQxT1dKaWpYV3llZkY0THA1eDgvNC84WWN5cjhjRTI0K1Er?=
 =?utf-8?B?LzRnekJYN2xYaE5hQ0pFcjZYWHpwdmprMnMzUUFNV0E1Q0NKUDA4YkpJZkdh?=
 =?utf-8?Q?ReY2IByWqVgnvAMx8ztDsgWV3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc3e037-4722-4d2f-7751-08dcf1e76642
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 15:45:33.7812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvcSn+Fteg0Ld9qCCTMphcg28P9u2NjWLBPSSeS9b5oYXevIy6ikTWgWJeDenIINaqYotn40rw0Ehfqmz1bXcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8417

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
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v7 to v8
- Add miquel review tag

Chagne v6 to v7
- none

Chagne v5 to v6
- fixed version number to v5
- fix merge conflict because change function name and macro name.

Change v3 to v4
- none
---
 drivers/i3c/master.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 1bf9cb138f77f..5a089be7e0728 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1548,16 +1548,9 @@ static int i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
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
@@ -1960,9 +1953,10 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_rstdaa;
 		}
 
+		/* Do not mark as occupied until real device exist in bus */
 		i3c_bus_set_addr_slot_status_mask(&master->bus,
 						  i3cboardinfo->init_dyn_addr,
-						  I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_DESIRED,
+						  I3C_ADDR_SLOT_EXT_DESIRED,
 						  I3C_ADDR_SLOT_EXT_STATUS_MASK);
 
 		/*
@@ -2126,7 +2120,8 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
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


