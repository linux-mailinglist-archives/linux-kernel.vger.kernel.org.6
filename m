Return-Path: <linux-kernel+bounces-312302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4F39694BC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14591C22491
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599CF1D67B4;
	Tue,  3 Sep 2024 07:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fakXzyVe"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914CA1D61B5;
	Tue,  3 Sep 2024 07:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347344; cv=fail; b=jnnB4yVcJkq/zSraTqIyCimBaINR9PrgHU8gn5MVB2RpyclvGgNu5hPqBKm6H2kPK92QgYSgL058Ghag/58NepBBQjxXBOyjsXNtgwyuKbV+85CopXu97fTt94168NpLyaOSmi97F8EFxezzDMtbito/1Tb9T39ETnqhS8mpuOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347344; c=relaxed/simple;
	bh=9c8XwYhm5kvlJFhXyu6JtIvTD0DkSwTghzUbNXmQeno=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TpS3WgHBfpZKAwKlBZlDpFPxLbzgnDZtX4kK/uts4XIxMx7OXcQcHnyQfwCZGnSFdu78+fPzqWSdPECjU0/nZM9gOnueVlm0lIHNkN76PfV3ybVXto2bt96syaXsz2ZTjQXbTId4ORoewjqn5/as/hWeeOVVojtU4EsRK+H5140=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fakXzyVe; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXfOAmM2keXF773mQFfMRVg+4uLa+tckr2t/fBY2B7JWwzaDH1hfiWWgvMC/FJpiemji+KNHa0Ghq/NBbxNRo3TRn1Xsc2gRdBKyiyHdi142H7Uk0UI6Djy/S2n6phx4AkRUf1bQaMk+/7h5j+9yaKksrB3izhaf9tZSXb97jnntBebsqOMkZJMHWXjTzGzyZU5wz6PGGQ5CQu8ze50KR90dN3gdmkYfCwy0D21g9NVtknJ7T/lIhpjuIUd/r2NoHnFsc8wG9hJagA4kCaSLVlxINaAOjyqp/IRZn+zaXrJKHaWYcmqhcse4eDR687tW/VUG2kYNzDsDRQEB8/OeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXXp6AWxkt/8VT8ysaqdRaNsxlkMeE0hMvpW2fB66H0=;
 b=SCRzY9hPzTNh7csdIWCDs73qPwYmjq6hlI1qYJI3ov33RlNT4QHC0NeRXa3tC8VF/gQtfN/P+C6Gcd2r8n295HGT7Lar5Ovot4vz8LvPR/r0CUBObfwAiyFrIdlofKnPPBis1KJWC2eDSHRcmRg3q9aTJQZEbcBEAmlG/sWSM16jKkQKoCjkHWbpYRKp89KnVHFH5HmqP9nbwP0Si/Ne4GDPA2HevhKbGyHr9n5voKq1pXbuauGnodpKw/9JWLvF3UZgKjipUzu0Oz2WTp/WpKwkwNsnzKIbLZgqJSEjhJNvxkJ47xfsuvASMafjOo+PRjsbkoSsT9he9+RvFZx45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXXp6AWxkt/8VT8ysaqdRaNsxlkMeE0hMvpW2fB66H0=;
 b=fakXzyVeqS+zMni1kZxHmsY/L6fCtWXDhNDdxTpR6Y8zXt/E5K49afEab/MiYmURUMIQ1rj6FzU9F9QYyFGKjoL1cWGbKJP+NZWfE7Y8j8E5K+ecFhzTob8cjzfTs0kiX9bGkO/H/vh55pBrB+z4wAvDaHE+mNSaRji0TSjDgL/806qZNDy0ch1mLnepKBlYHy/zH6ITP/Bx6ajn2TPDwuVtQ+we4YA4GMq9gNxcFSAcdjgRJFpIWW5dv9S3+QjA3tP8w3la5lF1Q4o7PK6icOwgB0VWaMCJcWQw+MKI5nZDENWSCvUOvZgK2cYS8MV2B7yWF//yFSvfSE+0BvnyYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9365.eurprd04.prod.outlook.com (2603:10a6:102:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:09:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:09:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Sep 2024 15:17:46 +0800
Subject: [PATCH v2 1/7] arm64: dts: freescale: imx95: set max-rx-timeout-ms
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-imx95-dts-new-v2-1-8ed795d61358@nxp.com>
References: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
In-Reply-To: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725347874; l=876;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Ae/5HixawuzT6tKqp+GLQZ8yZQ+B+M4UK9qykHcPCDQ=;
 b=G8ZpOxVNNaq2cTAyBTPnEchAKlGJA5aZ9+X6Yr5e/jSSz03sM33WQMGJPSzvHH5whuDm3ytYd
 AhjX2/lQQbvDJcSb1vUTRybFXJo4vo13A4sE2tpQGQU6r4Ne3Fk2KZV
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9365:EE_
X-MS-Office365-Filtering-Correlation-Id: befd4828-1746-45b0-65a9-08dccbe74964
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em1QTDE1dHdERWd0eFRTRWoza3dRbm82OG0xTmk0ZUJPa0RlR3g1TUltTmN1?=
 =?utf-8?B?YVhyMEQyNXdHeTZnT1Q4MTdlamxLVzhHMUpvV0ZUR1VvTVRldjRWd0VzanJP?=
 =?utf-8?B?QldZdC9QZjNqSnVpYTJuSTM1Q3ZmV1ZMTVl0R0JrUUg1d2poL1B3MmdDWFVS?=
 =?utf-8?B?NjdwQm5majNwcDFpUzlia0xtVXlvTktRN1dHTEI1V0cxTnBQR1B6bjN5amNl?=
 =?utf-8?B?enYwSi9DUkxlNWN3N1hGdDRxOWlzOVBrbHptRWpWeWxqem01d05KdlovL2Fi?=
 =?utf-8?B?Wk81c1dIVk5mak0vSkJqK0xaZ0F0RzJVa3Z4YTQ4WkRzNVcya0VaSmlMQ3dy?=
 =?utf-8?B?eldnUmtIK1RGL0U3QWZJOUtUNXdoL3dSS1Z0UVkwYXdHM2pUZ2RiYmZMcDN1?=
 =?utf-8?B?QjlSa1VsbUxDc2RPSkhmRG5VSnpETUhJNldjM1NUUGJnTzRXUEJNU2pidzJN?=
 =?utf-8?B?V05rSDRwS2JnSkRTbDd5cDUrS3J5MWtXVVBjWUE0U3dqS1RGZEI3TGQrUFJr?=
 =?utf-8?B?NXRlL0dtb3ZHUzRLci9BY3U1QWdWWmJTTWJEWUQwaGErV1hqZWRtMURrVkRk?=
 =?utf-8?B?RjBKeVJwSzNRc1N6dUdoWm5Vdld3MkdJVTlqVVpZcys1Y212QTZGeTRRdGJi?=
 =?utf-8?B?Zks1VlhiMzZyZkNMc0JEQ3pDd1ZWZmUwL2swaDljeGQxMTF6Wm5KKy9rOCtV?=
 =?utf-8?B?Z0lud0E1dVRkRlRPcmlHR1BLalg2aWJMbVlFN1EwdElXaWJaOVdhS2pzdEYr?=
 =?utf-8?B?Y3RZekpVMFZBNFR1dDdJVnE0UWl5T1pVcnhBZXgwTFZmanhQSWh1WldUN3JU?=
 =?utf-8?B?YytoYUJucEprNE5USWF0Nm5IenBRUDh1Q1pjWlNFdzJOZVpZNTZob1V1ZkRU?=
 =?utf-8?B?QlZDaE9uN05Ga2RWUDAvejhQbDBlTW5IQis0Q3FqcmMyMmI3NUR4bUptUUl4?=
 =?utf-8?B?b3ByQStLNVpRNjdRb21BeXpvVUdVNzIwd0lKNlNNZWQwQ3YvRWhEZ3U4UkJs?=
 =?utf-8?B?dGJZc2hBWWwyU2lqVXErczcvQTl1NTBrL1Zab3h1aDZqWTFyeEVJY2Uvb2pF?=
 =?utf-8?B?VWRjQ1NtNk51RHppdU5pa3NQMVU1UWhia1hRYzlBZktKOG0yY3Y4Sng2cjFR?=
 =?utf-8?B?cFBBa3lTTjdsRGlzcUtJRnBZZ2x0NWRaNFZWUVpLQWUyNkZJU2dIZnZnSlFI?=
 =?utf-8?B?RllYYVJtbWpENFFYUlg5ak9mdUNZcjJhVExGM005bWJMVjdrR1VldjQxelNI?=
 =?utf-8?B?eTh1eUdRenZHbGxXUnc0UjVqVVR3RjQ3WkhOdnNZU3M4R2hyQ1ZPdDc3NE8r?=
 =?utf-8?B?MVRsY1YwYnhSZEhSNlhRVFJZQmRwbnUrVDBiZUV4WTVkNXpKcU9wa3B3SmE1?=
 =?utf-8?B?TTNPRVNwdDA4ZG1LWDJpNlZ3amEranhZUHVDMzhtdjNaaU93MWR5WHZ2YTJH?=
 =?utf-8?B?dXAyMkRQeFpKNUp3b1BoWklnenhYL0Z3V3VHMjF2bXQrK3ZGdmoyN1h5MG4z?=
 =?utf-8?B?bjFVZEppRTNGTnFFU3Y1N01UbjZUSUlpY1F6STZUVzB5bGdGREtDemRUSTAz?=
 =?utf-8?B?ZndBWlNCb1RhL3JmdVcwanNZYjJUa2YxQkJkTFhsWGNDKzUwTUEwQ0NYZERX?=
 =?utf-8?B?V1RKNGVMZml6N093YVBGUVlRQ2hwbGRlMm9SM3d1Sm1UdG9HTHpTWG1Tcita?=
 =?utf-8?B?Yng1K1pUeGxQcW4wTnpQZWlBQ0FuK09LbXBWMWEzQ0NEMWU0RWFBMytvMUxG?=
 =?utf-8?B?Zi9vZmdzT3RtdWR2ZHZSWUF6WU5lVTU3NXRxMzlON2w3RHRvWUdZS0kwT0s5?=
 =?utf-8?B?UU1xTi95enE0M1ZaQnBGSE5mU3VsaitaS1dTL0FTVEZEQ1FyK2JIQkIxZUgr?=
 =?utf-8?B?M3BwZTNqQ2hqOWxMNnBnWHY4OFc0SVNwcGpqMk5td2xMQUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlhtWlR2TUQwWnBXaWZTUEt4dC9DTkk5ZXBKYWtLNVJzTlh4Tk9pb2F6V1hw?=
 =?utf-8?B?bVh0V0Via2ZrbmJTcXVFdjZvRm1iaHNJTXdwd0RwN1Y2MTZtd1RHWlZvb2Jx?=
 =?utf-8?B?Zkxyem5qYVRaNnc2Mlk4cU1iZDhJb0s5Z3RiTHMzR2hNV0ltVmNJdEZ3UDBK?=
 =?utf-8?B?UXVRSi84bnhlaHN6OU82dUNSbW5acVB2dHlQL0ViLzBQRmU1TWdINjUzaUhi?=
 =?utf-8?B?SnMwOUpka2lyT3hwMlBCekpCUll3L1llOHVrOWNjandTME9LVFhZVmJFaTc5?=
 =?utf-8?B?MW9xLysxbWxJdGo1VG5KamZiM1dYU1RUUCtxL1d4eWZlUy9Gb240eU9Dbk1E?=
 =?utf-8?B?SjZ2WWtVQkFRazIrSVlmQ096ZWhTbFVWeGFOcEtIRE5DUUI3MExKNmZmVzlW?=
 =?utf-8?B?UGhhRmJ3UXN6M2F0RHRQcGRkWTdQSUkzVVg3OWpQaGQ5cW8wdWdEUUV4QUhJ?=
 =?utf-8?B?QTdGNlpEb1ZpVlQwbm9oUXc0bjgyU01KM2xHbzhCOG1zTktsQkVDSStMQXZh?=
 =?utf-8?B?TVlUVlZ1RU9hb2pkaUNIKzYrMUF3UnNqSEs2dnNLRmdoYVFHbjM4S1dEWFhw?=
 =?utf-8?B?ajR1YnBRVGx5WTFIT3d1VlgxTENHTXNYbFpnejZxakRSSzg0dXJ2UlJKQXpn?=
 =?utf-8?B?T3pTMzYvWXh2S0pOZzRrV2wzSDR0SmhnendGY094OHFqTCtMVzR6YTBNbHBu?=
 =?utf-8?B?d3EwdHJOSXBzQTdJSXR2VEFXWmpFd21NL0ZNMENnb3piUk1Pd2lBK2MrTTJo?=
 =?utf-8?B?ajAxUXoyYXphOFBoREhJKzlRa3diYkhiWjloSHVOeXZJMENaQW5lTEhCNDBz?=
 =?utf-8?B?eGlmYjZuR3d2UnhvZkxUd2VydDI1WklMQjVHaDNiQzIvaTAyamp0TWJWR01t?=
 =?utf-8?B?MHpzQU5ZSUZtRytISUV0ODVKVFRzcGx6OUhMVDJ1eFBFeWs3MU1jRmFJam1R?=
 =?utf-8?B?bm10b1pPSWQvakFneVh1MkMxOHNZQ09xM3JLaE1idThQUUJiTG9UV0U5ZThY?=
 =?utf-8?B?YVlFcWFqUWliS3J4b2xqenYyY0dRNlVpemJrZy9CMEtRS2NoZXB3YTB2MkhJ?=
 =?utf-8?B?UVk0UVpUSTdQY29GS1ZBWTd4VFo2a00vdGxGZ0VVRlZQdnRFRSt2bzZveHl3?=
 =?utf-8?B?MFVvTVlzTitEdDNiRHJIYnRZNWdKMHhIelVpTGRVSE9lZ05DNkRCOVFvWUV0?=
 =?utf-8?B?bWtqa1pjLzV2dW5SR3l4RXZYVWlBd2tNWmgrWmZVVnBFRDlMd1hDa2xaMzI3?=
 =?utf-8?B?UXhJSmdhVzdHOVlxS0IwZUZpdTFCK2Rvb2s1UXcvZU1lcURNUGtPM1B1Ui9U?=
 =?utf-8?B?ZmptVnIyUGdrOUpCd0FOcW9uVnpzNUdJODd5ellNQzN5cENaUVZGMEYxZjhE?=
 =?utf-8?B?Qll2WHgyTFBmckZrdTZublNwL01FUDVNbDQvblAyME15ZTdVRnJ2U3VkYnY0?=
 =?utf-8?B?YlpacllvK0FoMCtXMHlyanlxaks0RDhScldCa0ttM3J6Q2xzMHRtWnVpMk10?=
 =?utf-8?B?NlhTUUNGMERzS0orVUJhWHFhSTlQWVpaamQyb0lsMDlYKytSWlcyclg1Q3RZ?=
 =?utf-8?B?UWhRNm5rYy90bmxNZVEzR1dkdnVkZ3FTcVB1V3VwcWdwWmFJYktiWnpCTlJm?=
 =?utf-8?B?bVBPam0wZjJWTkZ6eWhuVEZlWnEvSExyZ2Vvb1BnTjVsVHpjOE5WMGxIOElE?=
 =?utf-8?B?TnY4bG9nRUFXZG8yN1dGc3BrR3ZBbE12RnppbU80NUVXSGU0QkUwMnJ4T2V1?=
 =?utf-8?B?YkdqSTVMejNnQUtxM1djMURvakxaUHV1dCtjQmN0eTZuYXY4dk1vQjg3aVdY?=
 =?utf-8?B?U2I0ZkhjR2FHOXpmQkh4L0JqQ05jUzJBN3VFSkhoY0xicEIzZHFTWEs2WlFE?=
 =?utf-8?B?dGVGMnB1Z0hjZFJwZ0N5UGNFOUVtRndaam9lc1lTNmduTHV1YkNxcGt2NjJl?=
 =?utf-8?B?RlJjWE9XOFZnL2U1YWFXenQwczhqVXJTVmlkbFVvMlk2SUQvOUE4d2FzYWRz?=
 =?utf-8?B?VkYvSEpqT2txVi9uUm83NHpGZDU4VGx6T0QxbFBZajVYWERpMytlY1NweVI0?=
 =?utf-8?B?NTMrVEtJTWFZZGNaeTlxL0cvejBWWWNsczZ2N3RZS044bENFdmRvTGoyK1R5?=
 =?utf-8?Q?yUDjImAfm96/UvWNO5lxoGvd9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befd4828-1746-45b0-65a9-08dccbe74964
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 07:09:01.0529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95GbDSSQsVCpc83wPs6EFCAwJXReKhlkbEDJ+R7PNRvEHqAcWstxdnkYUB3MaSs0ZuN62fmnigvIDTtCoXkiQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9365

From: Peng Fan <peng.fan@nxp.com>

With 'max-rx-timeout-ms' property added in 'Documentation/devicetree/
indings/firmware/arm,scmi.yaml', set the value for i.MX95.

NXP i.MX95 SCMI Firmware designation does not allow timeout, it will not
recover if the Agents use timeout design. So set a large value (5000ms)
here.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index ecdc6b7b5129..7880d3efbd7e 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -294,6 +294,8 @@ scmi {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			max-rx-timeout-ms = <5000>;
+
 			scmi_devpd: protocol@11 {
 				reg = <0x11>;
 				#power-domain-cells = <1>;

-- 
2.37.1


