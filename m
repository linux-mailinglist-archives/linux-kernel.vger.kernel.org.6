Return-Path: <linux-kernel+bounces-349535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B1D98F7F1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62AA9B22C9B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB63D1AB6D8;
	Thu,  3 Oct 2024 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J4t2iVd4"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C71B85D7
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986494; cv=fail; b=UhIuPSYvtUJqE4XfeIIcld7QWRemTlRviVaf51hdqXKpkpAN8j5M+63w2uignqmEXRxsngAfB3AokLHx3cpc19IU0+Ctp9r77B4KWa9Lidn6WsUDSswHhYqkaZdlQRUi6hmGfrxapQbr55atOGzz+c4fdVBzJ5Cgw9gaT+sEE88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986494; c=relaxed/simple;
	bh=rzbrQPx0d2MOqsRyyCB0fUBaULbidlCEWYXgPMvvdlY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G7jKRe04iUaB01fBQcL5CVrSQTSexj8fgo1GgylKHeFAUYvsN54WRtAEb1wDGDAnT2o1OhmxtLNuBB4XTQKuDwFqhqz5mKW4CR8pZN2+Ql2KFPFQjuuZmc/D7m2YN8ZPTMECZ+pqFl1vzJh8ibGCQN+Cm25No6RPq5vXNJoIhAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J4t2iVd4; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyG6C6e8hB2ThZcvJmAGMuWutIhrgbAPATVEClEVqvt0Qb17yDW30gOmpIbEvYX8CnrmErusvTYIm1DbprDFfoyaOe9uHtqYKAcigvnCTvk6ojp8Nylu9ih1r0P7prqytmho/r1sRWzJ8rU12fQLjn2SVqwsBrerEOT4TswO1Ba7NuSA0Ogsr4rnlB40gf/dqB8Nt5CCKtj+xbYW92keMxFGv+jogjaS/yct64oOh82OrYPT36YOABNUc3/x0WYY5Tkz8UpctDfpeWzCTWojHuYYePEr4Me+S0bFp66p71RSsSYJzD5eU35C83FJd1t5auHLuJMVliOqdbRCt5x8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AutemPq5Uze2cW43m6UfBAV9GC9qmzLYuHVO74gWdc=;
 b=l0EmjAAnjeSa5C3oMseK8RDPStjjnIwvWZBxrzIM/hkviPNGFOIHQqdBUfKrlHWMeIjfB+5SPgGCTqhyNVDwZRmS7NhoukecWegDfPDx2o0aPDKMOQyJu1MPsxQKN3Bqkdyg+ZNejvS7Z/7FUUiwIhkgaDWpArM2GcWSFCeYjfeommLT1b4KAnbsTItR+7TvNp2MhrI6Lvut/rp6wtg49Ru8xrkecrIbw9zbX3BweGHjRFlpi+tTB69ijwEyIjF5g1qpLXJeKUkhSP7m43+Kt8DUfrbreE3/U8YCgqzA1VvmkJnvQzz7OSPKwGKeD65ifMNX5dpaBRtCXjkK2J+fQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AutemPq5Uze2cW43m6UfBAV9GC9qmzLYuHVO74gWdc=;
 b=J4t2iVd4j0ryeV4QUaoq721b5hjDBrQcgGdZ4xu0vYwUH+VDV/pEk+imtnkQJBh+SMXNag3I4Twho4cVPDnd/TJvzZgTytzPO1MZ/+Dm1eHFe93bOL1WQ2rtwT4syzSs0r7K/HpnaOLS9mX6wABOrfnJpEqlLZPLPyWsJzWGFWCz+yZUw9E7N6Kx5IkGNgNp146GYoaNHuzz+SMR1tS6gyX2058kMCQiwRiFc/SDDX8HQw9bskFEhQejAAM4sB1mfia0H57e4fyGqbqhJ0uDMRjX6P1owmCYCABM+LyDp8NG06NuJaqDD3/eXAPSPe6DU78Hrr0Y9YFxnSEUeheZ7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7481.eurprd04.prod.outlook.com (2603:10a6:102:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 3 Oct
 2024 20:14:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 20:14:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 03 Oct 2024 16:14:20 -0400
Subject: [PATCH v6 2/3] i3c: master: Extend address status bit to 4 and add
 I3C_ADDR_SLOT_EXT_DESIRED
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241003-i3c_dts_assign-v6-2-eae2569c92ca@nxp.com>
References: <20241003-i3c_dts_assign-v6-0-eae2569c92ca@nxp.com>
In-Reply-To: <20241003-i3c_dts_assign-v6-0-eae2569c92ca@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727986479; l=9085;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rzbrQPx0d2MOqsRyyCB0fUBaULbidlCEWYXgPMvvdlY=;
 b=eGcMTUdulnGr5kNKzZqZ4nRcY751Gpu3hXzHQNFg0+cppo9aKjmdGlkvaDYncqU1reU/pfGhq
 kxLbu9QdsW3DdkbHKSMkYMivPh4al2XXjzi5LRLzQ113N8ex6P9KYdl
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
X-MS-Office365-Filtering-Correlation-Id: f214ace0-38a9-4e08-f870-08dce3e80835
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QWR4M1dWRkJvQnRLcHJXSlYyeVlrR3JYSzhJVVBoNndDUjJZTmRiMzUyRDd6?=
 =?utf-8?B?N2N2dTZsdEpEeENyUWZnRkVLWk1mS3JZeU4zclZwN0hnTTRTNkhNeENwbTBu?=
 =?utf-8?B?cUw3Wk9pTCtzRjJpajhZUVZWUWlYaWpSZVdqdUdhUXpmb2J4NzhON1NnZUhN?=
 =?utf-8?B?d1E5Q0hMYWlkL2tvVHhBY0hqdHdUT3J1cUl5UjlHcGU4RWxIbjNwR2tEZXFC?=
 =?utf-8?B?QmRsZWRmUEp5Q09Yem9mbjVHMXQrUlpzWFV6dkU5WU1qa2VwZmFXb1Bjdmh2?=
 =?utf-8?B?cmx3WDBIRnQ0djJSdGpRaGc4bmxHdE4rZUwzOU1hcEgyVjJlMllTM2lCMzhI?=
 =?utf-8?B?TXRGWEI5WUVGTVVCV1lUUnVxMVlYaXdQcE4za2hpZFl2RG5CdGhvNmxNbGh1?=
 =?utf-8?B?THZQeDVUREkyWkZicjFkU0E2Q0FHZUZ1TTBrYjg4L1NORlV0UU00U0NyZjF0?=
 =?utf-8?B?YVZPUUNPa085UGtCQXhFV3FhS2xuVE5OVEQvemZ6d1I4Z1c2K1RRUjlZaVR3?=
 =?utf-8?B?WFEwTldPMDhsYmxDT0NBc0ZPakQ5Mk96Z0U3dTNWTlJSQ0dTM09XZWhDSCt6?=
 =?utf-8?B?OUp0S1lDdnJka0ZmcVlmVWlXWWg0NSthbG9sdHN0OW5URmZMdmNKMTFzV3BH?=
 =?utf-8?B?b0hLZjdBV09ULzl4d056TmdMbFNieWc5dmFNV3ZSOTE0MnRvYjlLZE9UVURa?=
 =?utf-8?B?ZlRqdVh5ellzMTBuVVRGQU5WTUl0ckoxQTdqY2tzN1FnU3JON1ZmeWJRWmtp?=
 =?utf-8?B?a0FheWRjV3ZPZ1libG0wNjg4VXZkMmJ2eWNwR3lya01GSWVqUVlyK0kvN0JX?=
 =?utf-8?B?a013NWMvS1FuRGY4WGNzSnRXRWRsOU9BTTBMM1ovWFdveWd5NHhlWGd4ZUFh?=
 =?utf-8?B?S1hER1pnY2FvNVpqU3ovelRaNFp4QllzMUM5ZVBNMjY0N0pFOWRwcThKa0tD?=
 =?utf-8?B?aWdZTkFVYTUzVFU1Z09CWkdrQ0x2MGkwT1lBRW9KQTFoT0JrbE1KM2tScElD?=
 =?utf-8?B?QkNPdTdyRWF6eW5lNHpGNHl6WEh5emUwNUlPblJ3S2NLV3J0UU9HaXdoanlo?=
 =?utf-8?B?TmppY05US05rVUduRVBUenFyOFlVSjg3aWlDbkRKUzRjc0NScDl5U2RhU1Jw?=
 =?utf-8?B?eTQ0djFPWnlJSEJMenZtZjR3M2gzSDlCS0lzYmxLNXNySXFWZGFVdFBDempM?=
 =?utf-8?B?Qy9vOUVSL252UjNXcG1uYStXV3RrZkh1VG1USmREeTJOZjArYStMcGswazZs?=
 =?utf-8?B?akhPblF3cy92QmJVZ1IrYVhNQ3ozVXp0T01ZTVVlbjluTzNKeU9uVnE1MlFE?=
 =?utf-8?B?V2lzRXgyVTM2YzMwc1pRNDZhV3dxenRtZm9JcFQ2bTJVcmNXclR2VU9saUtS?=
 =?utf-8?B?cVJIWCtxMTluL1VnQlFvY01JNnlINi9qYitsVGdPbHhrYzllc2NPRUZ6clcz?=
 =?utf-8?B?UWV2K29xbWZiYmp5Z3ltQ3d4cG04cFRXazY5S205MG1qMzZSYkxPZHBXcm5w?=
 =?utf-8?B?UE9uSGZXQWRKT3dZWEd3UGJIaDhXM0srMmVaV211STJGU1FYeFYvc3RxRVd6?=
 =?utf-8?B?Q0xTMG8wTW85cmRCc3pCbTF4cnQyUitXUVlvWjBlTnBCZG1GbkhUWlp0OUJ4?=
 =?utf-8?B?SzcrcHJTdHMrM05rVWNCMXBMUlhuVUdoTWZ3RWNIL2hvUEFSVXk4M3JlTC9k?=
 =?utf-8?B?SXN2QWtFOWxJeVpja2ZpRmc5YVJYZFlqR1FweXV6ekRQd0xOT1hERkloSDlY?=
 =?utf-8?B?T01pUVd3aWNWakZzSDVmbVY5MVh2ajNnTFhiZ0JGY0RRdnRUTndGTjNDeUJE?=
 =?utf-8?B?ZEZRZ29PQkJDSDkyOG1GQT09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QXpBa21iNzVCRkdubjBJSk8xSUlyVFhrd2pIV2dzZERwY1FDKzdrb3M5ei9s?=
 =?utf-8?B?aXRWQWtVSXp4UFpleDZ0NXljM2VoVFVhai8wdzIveUswWHdUREhDam5udWJi?=
 =?utf-8?B?VXpOV3A3bS9Pa29QSHY2YVJEc1plcW03a3ExMmh2anlJbG9velVRaEp5WjVO?=
 =?utf-8?B?WWY4Y1VDKzZKTkE0S0IxYStWZWJCbUptMGdSTmpHUnRMMDU2Wi9wNU5aYTYw?=
 =?utf-8?B?bklUM1lXTVg5MXI4SjlweEg5N2hPNDROK1hFVEVTZStYUHRYcWtHZ0Via2ZW?=
 =?utf-8?B?cHlFN3NtSUg5ajM2cDhLUWhLR0YwdlVsY3owTFpDWlJpVG9Za2ovcWg1OUNj?=
 =?utf-8?B?ZzZsV01yUjFhVTl6M1FkcHhlNUpZYlRLQlFUekxSSy96VU0wcy9qT1ZScG8r?=
 =?utf-8?B?Njl4R2hFMjRZclFRVlFXNVRxVzNFZG1ER2thbnZOQlV5OEIwY1NOTDVkQlBN?=
 =?utf-8?B?bUJkNUZMU0xpYU9vVlFTeHpmTmpYV1NSWWRscTJLc3FRaVpKUXBVWTR0di9O?=
 =?utf-8?B?U2d4N0YxZ1JFTmljeDRJalBpbk56VEtmRzVKMUIzRHdRY2xLNURYMTNFOFNK?=
 =?utf-8?B?THpaLy9yaUJ6Ymlwajd6UFFKZksxcHAvQU1RRFBEZWxRcEdXNUk4SjlIRlcz?=
 =?utf-8?B?QlU5bHprOTdGalZpMHR0TTlTa0c3My82RVhSMWFpZXdsS2ZTOFY5b3ZzUWMv?=
 =?utf-8?B?V1BuMTZQMGY0cGR3aThDRW1LZFpma0FzZ0ZvamR3eXlINHFFbkkxaVZIWEky?=
 =?utf-8?B?K3NlZk1sWnFvMGtlV1ZsUWJZYitUWFN1ODFVLzZrTTIrcWRwMHNCTXY1WXdk?=
 =?utf-8?B?YysxM3RrWVRGOHNhRElGRWU0dHovM3pzOG51Wm1KazEzTWhEak4yQngrSEpO?=
 =?utf-8?B?SVBEQ0N0SDk5bWFuSEFXRThSYXJwWHBUbkxXUWJHckdyVUxKWTczSkhXbFh0?=
 =?utf-8?B?WHRhb3kwaFJIaFRBMlg0SFZiUDgrT2E2czRRV2FFZ0dJM0x3WmthS3Mybjlw?=
 =?utf-8?B?SU4yMnNFcHlxbldLZmZoYzZFL2ZNd29xazdqRTh1RWdzelJqQkY1S0MxR0hI?=
 =?utf-8?B?eEJFc3h2TzB1WG55c2dGTFJ2c1lzUnJXUHA5SHI3TjZlUmt0Yi84NlZXUitN?=
 =?utf-8?B?ODZXbFZGZk03cTNQZ3BpVnJ6eFNKUXdqMElwdjY3R1d0YlNuWkg5M3BVN2p1?=
 =?utf-8?B?eXdIaGFUam02NC9Wb3JkbWg5YUlmeDdnM3pzL2x6WGJIcUozd3BrSWpqS0FL?=
 =?utf-8?B?aWJaOHB2cUl3U2tOeURKV0F1dW9lRmRzelZoYkhWcVM1VjZ6UW1qUEIrYXhr?=
 =?utf-8?B?RUNlb1BzdjBpZW9RR0YxQ1FHSmwzRkxCRGJBcU1PSG5YdTdUNEozTlJvd0RZ?=
 =?utf-8?B?QWVnYzV6U1REK0hBNVIxQkRtQ0V4YU1ZU1pQYm5HYmFCbGkxMVhOTjBFOE93?=
 =?utf-8?B?NE9IODIzZ3g0R3cxcjltanVOUUFtTHk2VzYxblNTek91RGxndG03Q0dWU1hG?=
 =?utf-8?B?Mm1pZVFXUWp6TnBlbXB0c3NIMlFEbXA2ck1YbHlsYzZIV3hrOXRpQ05wbWQv?=
 =?utf-8?B?NVRtVS9nbDRYN2JycXg2enhydkhLRVBQVk5LWVkwMFRQeTA3NU9rcjh3RkMw?=
 =?utf-8?B?Ly9vcFNiSWhrRFdZVWs0NDRxODkzYW9ldUpJZ1hQWTdERjZzRmtYN3hlbDBL?=
 =?utf-8?B?eFlMTHNLRkN6Nkh3MEZ0cUdyajhVVDhtTUtQQzlWdnNxeksxNnU5SGZTcFNC?=
 =?utf-8?B?cWlFUm1iMzAvZTZ5ZC9JNmp2WnpWc3ZxUVZQemRNaHZ1QTRRV01HeGE3SUVZ?=
 =?utf-8?B?OGYxdkxKbWNlMFg2d0hKKzNoN3diUGdnakc2Y2Y0QXlqS2cxaW5tMkFkMzdZ?=
 =?utf-8?B?eSs0alJKV0dkVVJqdDBIQTJsSjJ1Y3hMRkptYWdxdSt2dXlwUG5vUU1janFh?=
 =?utf-8?B?a1dVdGYvbktLWnJ3R3ZjUzJWTGlEdG5iR2YyeWJqcGttQkFJUENQM2ZtUVFU?=
 =?utf-8?B?eFBVVEdCcEYrbkpudXFCdFUvMThTTW5HVkwxbUVQemdtYmNNYjhGOTJyYzhF?=
 =?utf-8?B?eUNhcUZWaElTMEZ0NHZxSUphd2ZLTEUwQmlMV1hjUVJGby9xYVFBNWJoanhH?=
 =?utf-8?Q?lJoQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f214ace0-38a9-4e08-f870-08dce3e80835
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 20:14:49.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtealSHcvvDFkwYhNRVyuJU/y/8UzMhh7sfZvIrpUH0adq270tb1pd9qFREEaNeKuvGlCQKT4Apn7/5H61Tiyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7481

Extend the address status bit to 4 and introduce the
I3C_ADDR_SLOT_EXT_DESIRED macro to indicate that a device prefers a
specific address. This is generally set by the 'assigned-address' in the
device tree source (dts) file.

 ┌────┬─────────────┬───┬─────────┬───┐
 │S/Sr│ 7'h7E RnW=0 │ACK│ ENTDAA  │ T ├────┐
 └────┴─────────────┴───┴─────────┴───┘    │
 ┌─────────────────────────────────────────┘
 │  ┌──┬─────────────┬───┬─────────────────┬────────────────┬───┬─────────┐
 └─►│Sr│7'h7E RnW=1  │ACK│48bit UID BCR DCR│Assign 7bit Addr│PAR│ ACK/NACK│
    └──┴─────────────┴───┴─────────────────┴────────────────┴───┴─────────┘

Some master controllers (such as HCI) need to prepare the entire above
transaction before sending it out to the I3C bus. This means that a 7-bit
dynamic address needs to be allocated before knowing the target device's
UID information.

However, some I3C targets may request specific addresses (called as
"init_dyn_addr"), which is typically specified by the DT-'s
assigned-address property. Lower addresses having higher IBI priority. If
it is available, i3c_bus_get_free_addr() preferably return a free address
that is not in the list of desired addresses (called as "init_dyn_addr").
This allows the device with the "init_dyn_addr" to switch to its
"init_dyn_addr" when it hot-joins the I3C bus. Otherwise, if the
"init_dyn_addr" is already in use by another I3C device, the target device
will not be able to switch to its desired address.

If the previous step fails, fallback returning one of the remaining
unassigned address, regardless of its state in the desired list.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- fix version number, should start v5
- change to I3C_ADDR_SLOT_EXT_DESIRED
- remove _ext function and direct use _mask function
- rework commit message and comments according to Miquèl's feedback.
- change mask type to u32
change from v3 to v4
- rewrite commit message and comment for i3c_bus_get_free_addr()
---
 drivers/i3c/master.c       | 60 +++++++++++++++++++++++++++++++++++++++-------
 include/linux/i3c/master.h |  7 ++++--
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index dcf8d23c5941a..68411f1cf80d6 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -345,7 +345,7 @@ const struct bus_type i3c_bus_type = {
 EXPORT_SYMBOL_GPL(i3c_bus_type);
 
 static enum i3c_addr_slot_status
-i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+i3c_bus_get_addr_slot_status_mask(struct i3c_bus *bus, u16 addr, u32 mask)
 {
 	unsigned long status;
 	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
@@ -356,11 +356,17 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 	status = bus->addrslots[bitpos / BITS_PER_LONG];
 	status >>= bitpos % BITS_PER_LONG;
 
-	return status & I3C_ADDR_SLOT_STATUS_MASK;
+	return status & mask;
 }
 
-static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
-					 enum i3c_addr_slot_status status)
+static enum i3c_addr_slot_status
+i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+{
+	return i3c_bus_get_addr_slot_status_mask(bus, addr, I3C_ADDR_SLOT_STATUS_MASK);
+}
+
+static void i3c_bus_set_addr_slot_status_mask(struct i3c_bus *bus, u16 addr,
+					      enum i3c_addr_slot_status status, u32 mask)
 {
 	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
 	unsigned long *ptr;
@@ -369,11 +375,16 @@ static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 		return;
 
 	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
-	*ptr &= ~((unsigned long)I3C_ADDR_SLOT_STATUS_MASK <<
-						(bitpos % BITS_PER_LONG));
+	*ptr &= ~((unsigned long)mask << (bitpos % BITS_PER_LONG));
 	*ptr |= (unsigned long)status << (bitpos % BITS_PER_LONG);
 }
 
+static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
+					 enum i3c_addr_slot_status status)
+{
+	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_STATUS_MASK);
+}
+
 static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
 {
 	enum i3c_addr_slot_status status;
@@ -383,11 +394,41 @@ static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
 	return status == I3C_ADDR_SLOT_FREE;
 }
 
+/*
+ * ┌────┬─────────────┬───┬─────────┬───┐
+ * │S/Sr│ 7'h7E RnW=0 │ACK│ ENTDAA  │ T ├────┐
+ * └────┴─────────────┴───┴─────────┴───┘    │
+ * ┌─────────────────────────────────────────┘
+ * │  ┌──┬─────────────┬───┬─────────────────┬────────────────┬───┬─────────┐
+ * └─►│Sr│7'h7E RnW=1  │ACK│48bit UID BCR DCR│Assign 7bit Addr│PAR│ ACK/NACK│
+ *    └──┴─────────────┴───┴─────────────────┴────────────────┴───┴─────────┘
+ * Some master controllers (such as HCI) need to prepare the entire above transaction before
+ * sending it out to the I3C bus. This means that a 7-bit dynamic address needs to be allocated
+ * before knowing the target device's UID information.
+ *
+ * However, some I3C targets may request specific addresses (called as "init_dyn_addr"), which is
+ * typically specified by the DT-'s assigned-address property. Lower addresses having higher IBI
+ * priority. If it is available, i3c_bus_get_free_addr() preferably return a free address that is
+ * not in the list of desired addresses (called as "init_dyn_addr"). This allows the device with
+ * the "init_dyn_addr" to switch to its "init_dyn_addr" when it hot-joins the I3C bus. Otherwise,
+ * if the "init_dyn_addr" is already in use by another I3C device, the target device will not be
+ * able to switch to its desired address.
+ *
+ * If the previous step fails, fallback returning one of the remaining unassigned address,
+ * regardless of its state in the desired list.
+ */
 static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
 {
 	enum i3c_addr_slot_status status;
 	u8 addr;
 
+	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
+		status = i3c_bus_get_addr_slot_status_mask(bus, addr,
+							   I3C_ADDR_SLOT_EXT_STATUS_MASK);
+		if (status == I3C_ADDR_SLOT_FREE)
+			return addr;
+	}
+
 	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
 		status = i3c_bus_get_addr_slot_status(bus, addr);
 		if (status == I3C_ADDR_SLOT_FREE)
@@ -1918,9 +1959,10 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_rstdaa;
 		}
 
-		i3c_bus_set_addr_slot_status(&master->bus,
-					     i3cboardinfo->init_dyn_addr,
-					     I3C_ADDR_SLOT_I3C_DEV);
+		i3c_bus_set_addr_slot_status_mask(&master->bus,
+						 i3cboardinfo->init_dyn_addr,
+						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_DESIRED,
+						 I3C_ADDR_SLOT_EXT_STATUS_MASK);
 
 		/*
 		 * Only try to create/attach devices that have a static
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 2100547b2d8d2..6e5328c6c6afd 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -298,7 +298,8 @@ enum i3c_open_drain_speed {
  * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
  * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
  * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
- *
+ * @I3C_ADDR_SLOT_EXT_DESIRED: the bitmask represents addresses that are preferred by some devices,
+ *			       such as the "assigned-address" property in a device tree source.
  * On an I3C bus, addresses are assigned dynamically, and we need to know which
  * addresses are free to use and which ones are already assigned.
  *
@@ -311,9 +312,11 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_I2C_DEV,
 	I3C_ADDR_SLOT_I3C_DEV,
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
+	I3C_ADDR_SLOT_EXT_STATUS_MASK = 7,
+	I3C_ADDR_SLOT_EXT_DESIRED = BIT(2),
 };
 
-#define I3C_ADDR_SLOT_STATUS_BITS 2
+#define I3C_ADDR_SLOT_STATUS_BITS 4
 
 /**
  * struct i3c_bus - I3C bus object

-- 
2.34.1


