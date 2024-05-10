Return-Path: <linux-kernel+bounces-175824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35448C25B8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128911C21EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D458212BF34;
	Fri, 10 May 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BUanqYst"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBCA12C491;
	Fri, 10 May 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347806; cv=fail; b=VeFI3VWFmo9qstmUBP8xPmZm6Zw1TXUH7RaEHE0aUKuLATEFUe4wiAKja5BdsAUFwkgzMMxf3v4063oChsRd3n5p7ce/mNvns4FiRsytBP7h9zSUj9DiLq58fg5+IXsSXbP9ljTbk+wrSPEsRyKbAU9eLE5EDcdQKarkjhOU2gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347806; c=relaxed/simple;
	bh=jRb9hkx63cBBovA5OBhcBSDVUlY2RiZksRaCBeA1JzM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=N9F4cvdpGNOIO8J7sjJyMEZv/VpuuAeeb3CIAKENOhyRFkkc0+8GO5VTbn3Bizd0G22rx0VznSfNfdrrHsDlO+Yj/d2C+Y3AMVvKFGSdAEku5DhJruiIYOb92oWBIg8YLvEgRM80b/INtLwpb289H+IlBklzt1+Mm9JFw420Zt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BUanqYst; arc=fail smtp.client-ip=40.107.8.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7yAlSUCEnM87z90QUIMjKjDKanUm819n+IbNvYrCoIvDdUPkBRHIzXEGEp3Ha0NYgx83tjVD6oTewk4mLNQYLz5m19CWWAaNXoxWfRYbKkkTIdhEaqbjDRT6GZE/FdSCOOm0RaR+fTbxXlS9Y0flAhamW6liRVrTJX1wjHC7mJXMchgnhfaUNhWaYa7f9vAkDkvz6NvaB9Capi0anjAakP+5cTrHdl5tBL+Y2yi4+m3MF0mllPCXTR4/3DD6WD74x+Vz2X5HeHx5kq15g0wUxVw5j8xz63p7miw9bdXY/BIM0X7ONzkD1Xoyw/UNHhyFSaVaehPsiz8VEwRQo76RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tBlC/XR1f4RxxBF5JWmW+shNxBORK4iecFaaqtiQ+o=;
 b=duh9btrEwnQl06JkbdOJ+JYAnOlPYpa48emYUZrn0OX93I7DtZvesscUh8CtoZIEpHKz/MyKtNf8w8n9M0PYC7wjNoqTuUQrTHNz87mc5S7hi02Vfa9qO6Zc3cYt1vCPcMZsykICNZ5DKb87VYAoSLdrLDTcL0mkFF5/m0wQuIQ7Aa4Kgm6hM/ZD6qN9oJbYSi6hUHYSVjjXGhkmdfUexUwGvso29Fv0fPuRZfWMomcdAsWE9qJ/qw0SVxRRte2pMDrtr5SkIOT2MJHUxb73OARGOZ8M1gJruppdwiTxLYBUihavLlHjb2zSVEAeg4QMegufB42uwHV7vduDeUyBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tBlC/XR1f4RxxBF5JWmW+shNxBORK4iecFaaqtiQ+o=;
 b=BUanqYst0RLnz3IcMZogJ02Mo+twVI+eOTAouwB1MpAzwy2DhGB5XZkbsLSdJ6WYI5ujiQqK4+j9ZOtdXYopjuG0WpnK27M6MkAfTQQel0hugdWKfE2uanpt+jzKTHQp6IsavmgdwyCnCgkw3xPEfuLSAFG4wUncMixWoT2UpqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:30:01 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 13:30:01 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Fri, 10 May 2024 18:57:27 +0530
Subject: [PATCH 1/4] Documentation/firmware: add imx/se to other_interfaces
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-se-if-v1-1-27c5a674916d@nxp.com>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
In-Reply-To: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Pankaj Gupta <pankaj.gupta@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|AS5PR04MB10041:EE_
X-MS-Office365-Filtering-Correlation-Id: 7331c625-afb4-4dec-5528-08dc70f54b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|7416005|376005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2tZSkdqMWxsaXdHeFZlK3BWSDJtLysvY1hHVzAxTTU4cFczUEhXZ3ZqY0w5?=
 =?utf-8?B?REhOb0JLaXE2VzRKTi9EUUhhN0ROanYyM011UUl5bkNjUWp3dllGeDBSWjhu?=
 =?utf-8?B?NnpQbCtpZkJZNFNXc1J5bkhRaWVrT2l2Zi9zTHBSUTdtQi8rN3AwcWd5eEkv?=
 =?utf-8?B?R0ZkcXk1eEVNNkZ6OEQ1OFFiMGJjekdROU1jK0U4RzZ1VVM4b3p6L1hrYVZZ?=
 =?utf-8?B?SzcyazkzMTQrbTdvKzJkYzBtTWdJNVY3RmFVMER5dXZKWldZM3RmdmJHKysv?=
 =?utf-8?B?b2FTNm9tZEgvQjdnVkZ1YlpWZzZnNStNOUNsS0xuMFMwMnp4UEZmdFJmc08x?=
 =?utf-8?B?bTRXWUUwV01kT2c0dkFpc3lxdGpRWEpORzRIdnlCQnFTSEpLUGFFQndUVFA2?=
 =?utf-8?B?aTVuQ3dxSmNUNVFBN2loWnhGdUpZNC9rYjNib1hndGFqVS8zSCtQN240ejVy?=
 =?utf-8?B?ZFV4UUZaV2MyMFdRMm1wKzF0NFNXNzFWM0Z4T0RQdHZqTlMvUlZLUTVtcHk1?=
 =?utf-8?B?S2hKUWhid05WMEg4OTZKOUVMS0o3ZWVzNkZvWWk3ZEFVNldkcmxGSStQanp0?=
 =?utf-8?B?WlRDQjl0Z1lpSmFvZm1ueUxNN2FGdVpPYVpRY2NzcFRBcVRzRnZhSzh3VVpI?=
 =?utf-8?B?RGcvcGFweDRFdnpPTHZnSlRqTjYvMUNZaEg2c3FjSjVjUVdjbmxkdjcxS3Qx?=
 =?utf-8?B?MmFxVGZJWHJqNHgvajdvaHlIeWNRbXhOOTZOc3lKdTRRT25tTGsrdUl0cDZw?=
 =?utf-8?B?TjNQeVY3QU0xcEtpQ1BnY05yaHRZYVoybFo2Uno4YVZLcGluVUdseHRLYWNi?=
 =?utf-8?B?bXNoeG1tOEVQcTVNWHV3UWVCdHd5Z3k1RGVUTW4rQXV4UlpWSDRWQW1IdCtn?=
 =?utf-8?B?MWw5RVpWU0tXY1c0T3dLMEZXRXZEWlRaSmtielEvWDVhd2RsSU1IUzB3RFpF?=
 =?utf-8?B?K1Y5WU9BRzVUNUZBb09sUGFYcmJuNlVGakJUSmhHNVplTnBnUGJrYW1kc08x?=
 =?utf-8?B?cVVQM2JKa2FNVmpFb2RIQ1dRcXhTem1nOGg3OG1tTjFhT1dLTzlGQnJ5dFVl?=
 =?utf-8?B?RkdheHdseG81YTRVbkpOOEFNQTBNZ2E3NUZteFBxYlBFdlZydERMeVJQa2VG?=
 =?utf-8?B?d2FuTFp2U0tMQnU4RDA0OGI0UkYrbHpCUnY2NjZTb1pCUEFDUHZ4dG8zWGZq?=
 =?utf-8?B?cXhzVlZNK3NZTEtLWGxEWWV4akZoQWRieGFNTmJxYzFwZjVFRlpWVmZ1VzYz?=
 =?utf-8?B?aE9NbC9xM3VWb0FkNGVoNXB1VnZUdjU2bnhqMWtJVkJrdUdYZTEwMC9rTHdV?=
 =?utf-8?B?VzZhWGVGNTY5bmdwQXAzQ1JsZnFFRkY2c0lpQitjSXk3QzlaZzBBQVhFVEhG?=
 =?utf-8?B?bGVVeVFrWVNqd1FmUTNONlZpcFo0SnJjb3Y0YlFGaThNRXpYcWRzWUlPRjIv?=
 =?utf-8?B?MlJRMkpZaXRDZ0JDaTAzRVhqd0xZM1dOVm5iaXo1cXdHclhxSUpoakJRcnJ5?=
 =?utf-8?B?R3BGZS82ZWxZbDVjOGF2eHdOQXFSWVpLSWl4eG85akdURWxQbTJIc2Fob3NJ?=
 =?utf-8?B?VStDYndvTHErVkRxeGFOSC95TnJLdDlpek5NUkIxQ0VKdEJjMGFjSktPcmZU?=
 =?utf-8?B?VzM3RkRRaytFZ3Bxa0NSVDgyOXNiK0lKVU9mSHZxUU5JQ0w5bnF6NGltNS9U?=
 =?utf-8?B?YjNwM3EwcDFCYnYwRDVIc2l4T3JTMkMvQkVUb0ZwbHo4RjRtZlJPd3ZqWnh4?=
 =?utf-8?B?SzN2c00yWVRndkJXTVRTRWpsRWthMStGQkRVTjlOd1UwbytVMVd2TGw3OXoy?=
 =?utf-8?B?M3RCVC9ZN3V2YXpDbnNwQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUY0YStxa1ZyNWVLajFqZFpiYXdPYXJqdmxxQ0hCUURpWCtScFMzZFJ2cE5y?=
 =?utf-8?B?T2Y0blZycS9DZ010ak8xL2MzWmM1cHNyNy9DdjNyQlFsVTJHTFowUmdTcnZ3?=
 =?utf-8?B?bjVEQW05NGlEcU9vN0VQZVRwU25DNTY5Q3dBZ3BnZVBuWEJCSVByTlNEWGtv?=
 =?utf-8?B?ZHRyWUZVYzRZRkJEOTNnUExhSjdBWTdvRU1wNmR0OVBsTzI2WG5kbWxVaUdG?=
 =?utf-8?B?NnJmMHJ6S0VRQlpYSUNOSi9SVGJhWjM5b0FCN1pCRlZLaEhJZWlNeEFya3Zt?=
 =?utf-8?B?OW05QnppN3lIMDRQU2JEaUtXNThxbzZuVnBlN05hanQ0eUJLdnYxcStWODJk?=
 =?utf-8?B?Kzc0bmt3T2dvNjN3OWsrS3oxMGdzcmNzMURnYkNzQlJLenZsbGxxSmkyTFkr?=
 =?utf-8?B?RTlHbUE1RVlWeEIvTmpsN3U2RjVodDZJQVErT2RFeDdWZmg2SjE0RVY3ZU5m?=
 =?utf-8?B?c0RjMkcwaWJCbEVaSUYyTEI0cEFyVENLcXZRQyt3WUFHU1J2dlF0K0RKaldj?=
 =?utf-8?B?NVEzYllNTURMeE1yYmpsamFRS3hEci9KM0huMWpOa0ptRFV5cEcwZzdiUC9s?=
 =?utf-8?B?VU9CVWJ4V0wzclV5dzNGR3Q3dU43ZzFXMXNUNEFPUUtnVjh6MjlPSSs3MmRE?=
 =?utf-8?B?bTQzdVZCSVI2Y1ZNbHdxNWIreFVyQWxLQlZIblpqc09oVXB4YWoreDhGVm5h?=
 =?utf-8?B?cXhEUkVaQ3JuVFNSRno1VVNuOVdJY1JXcnBOZ2RKdkhCWnlpWTc5Z1VwaWJn?=
 =?utf-8?B?OTMrbXVYeUg0Zy9DTmtadzFFVGFBNHlaNXNEOGhKQVpXR2J0T3RuNzdNRmxB?=
 =?utf-8?B?VGdacHZxTDd6ZzBKSFNaUnoxMTJUQUZBT0g0WjN3NkdXZ3BYU2liZG9PUFVI?=
 =?utf-8?B?VUN2aVVtQmpnUlluc2JROHhFdWJhZXZyUDAxYVZyNDdhVHVqS1k3akxMMVp5?=
 =?utf-8?B?SU54Qzh2Zm5wVzJVb0NLTkpEemdKS0xaMEtGVFF5T292NzFMTDE1c0RDQTJh?=
 =?utf-8?B?T245Rm5XeDlMZE5mREhQR0xpS241MmV1Ykw1VG0rNDBZK1huOHp1UUt4enVR?=
 =?utf-8?B?dW1YRHpqTm1ua3doUW10Nyt3VE5pUE5lRVNla084a0ZTL0RrZTcrK2krYy8y?=
 =?utf-8?B?c1U1cWlEeXQrSFVnOVRIMDRTRnBST01OdWVJbE8zcXpwaUkxTVBvNitORVZ3?=
 =?utf-8?B?T2ZxQjJyNFBnR0k2Zk9FNTM1V3ZVZVpUSmFaeUwxeitFRktGZnc0eU03TjJH?=
 =?utf-8?B?cE53emg4am9lRXVIaktSOGI1THZMQVhNczUzSWI0ZnBKZzhCWVgxa2hDemx1?=
 =?utf-8?B?Q1pRMEwxenlweS9JeE5XeGhRWGRsYWRXaG54a3ozVkxYallQUjBKQlpXcHph?=
 =?utf-8?B?a05tVXA3bDF2KzgvREVSVHBHRkg1RVFobHE0YjVpRWxkaVI3aU9JcWlBanZv?=
 =?utf-8?B?WENzS2lFZDdRVjlNaVRpQWRHSVhnMlMzaUVTVm14RlU3dEJvUS91U1dGdVJV?=
 =?utf-8?B?M0prZTRJUy9nSkwrL0o1elBQaUpQbkxVSGtiWmF6NCtYMmI0SWRxaVIrYWZu?=
 =?utf-8?B?OEtpWGYvdmg0ZDdmR3dvL0l1NGRNSlF6b1kvbTVSbWNNRDJyYUlUYnl6L3Nu?=
 =?utf-8?B?TElPVHk4a3JCRzJFdzlRc2JLTTVPNzdjSzZtWG5hc1VRRzZHdmdhRTJoUk1v?=
 =?utf-8?B?V2k1TitZU3V4M2tJMlA5RVpGNkJ2V2RKZDZRc2ZyRUNVZlZXQ2NtUDN6OGs0?=
 =?utf-8?B?ZXF5K1k0c2lrL0hxbEdjVGNTUElQTnV1NVd6ekJvU2pqemU5L3FOY1hVcC9q?=
 =?utf-8?B?ZHJheHJ3RDZXSHAvd1BJYStKN3F5ZmtXcjFMMzk4aUQ2VnI3UjhVL3daV3Ay?=
 =?utf-8?B?MUhMM0JGY0NkdGZWUXRLNDVzRWtPY3hoazB3UFJoUkVZd2p4VnFvRnlsWTFI?=
 =?utf-8?B?MVgzTWNITmIzQk9VMXZramZqQXVEUE15MCt1RWlMVzVYa3RzcTQ3OU9ISDdj?=
 =?utf-8?B?d3FEYU9zTXpkVS90MXQrOTVtTExJWWFncU1DN0N5SHE4SUZoWDRabTl2bkZB?=
 =?utf-8?B?cSttKzExSWtwSUxEN1hVRGxBVEsvWmZ5MjBKdWwvV3BFaXQ4VzNGb0RCMWdq?=
 =?utf-8?Q?A3qt1vVqZmvOXMVF/v3cJCZkq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7331c625-afb4-4dec-5528-08dc70f54b8c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:30:01.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X7TXvoiMsWdOeXkyXNBMASPgI0C0cooKWu75yE/CbcwU1MIU0Dh0cTZxxKleBw6ovIiutbugj8jr2XzBGRVdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041

Documents i.MX SoC's Service layer and C_DEV driver for selected SoC(s)
that contains the NXP hardware IP(s) for secure-enclaves(se) like:
- NXP EdgeLock Enclave on i.MX93 & i.MX8ULP

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../driver-api/firmware/other_interfaces.rst       | 126 +++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index 06ac89adaafb..c18c2d3e6e08 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -49,3 +49,129 @@ of the requests on to a secure monitor (EL3).
 
 .. kernel-doc:: drivers/firmware/stratix10-svc.c
    :export:
+
+NXP Secure Enclave Firmware Interface
+=====================================
+
+Introduction
+------------
+The NXP's i.MX HW IP like EdgeLock-Enclave, V2X etc., creats an embedded secure
+enclave within the SoC boundary to enable features like
+ - Hardware Security Module (HSM)
+ - Security Hardware Extension (SHE)
+ - Vehicular to Anything (V2X)
+
+Each of the above feature, is enabled through dedicated NXP H/W IP on the SoC.
+On a single SoC, multiple hardware IP (or can say more than one secure enclave)
+can exists.
+
+NXP SoC(s) enabled with the such secure enclave(se) IP(s) are:
+i.MX93, i.MX8ULP
+
+To communicate with one or more co-existing 'se'(s) on SoC, there is/are dedicated
+messaging units(MU) per 'se'. Each co-existing 'se' can have one or multiple exclusive
+MU(s), dedicated to itself. None of the MU is shared between two se(s).
+Communication of the MU is realized using the Linux mailbox driver.
+
+NXP Secure Enclave(SE) Interface
+--------------------------------
+All those SE interface(s) 'se-if(s)' that is/are dedicated to a particular 'se', will be
+enumerated and provisioned under the very single 'se' node.
+
+Each 'se-if', comprise of twp layers:
+- (C_DEV Layer) User-Space software-access interface.
+- (Service Layer) OS-level software-access interface.
+
+   +--------------------------------------------+
+   |            Character Device(C_DEV)         |
+   |                                            |
+   |   +---------+ +---------+     +---------+  |
+   |   | misc #1 | | misc #2 | ... | misc #n |  |
+   |   |  dev    | |  dev    |     | dev     |  |
+   |   +---------+ +---------+     +---------+  |
+   |        +-------------------------+         |
+   |        | Misc. Dev Synchr. Logic |         |
+   |        +-------------------------+         |
+   |                                            |
+   +--------------------------------------------+
+
+   +--------------------------------------------+
+   |               Service Layer                |
+   |                                            |
+   |      +-----------------------------+       |
+   |      | Message Serialization Logic |       |
+   |      +-----------------------------+       |
+   |          +---------------+                 |
+   |          |  imx-mailbox  |                 |
+   |          |   mailbox.c   |                 |
+   |          +---------------+                 |
+   |                                            |
+   +--------------------------------------------+
+
+- service layer:
+  This layer is responsible for ensuring the communication protocol, that is defined
+  for communication with firmware.
+
+  FW Communication protocol ensures two things:
+  - Serializing the multiple message(s) to be sent over an MU.
+    A mutex locks instance "mu_lock" is instantiated per MU. It is taken to ensure
+    one message is sent over MU at a time. The lock "mu_lock" is unlocked, post sending
+    the message using the mbox api(s) exposed by mailbox kernel driver.
+
+  - FW can handle one command-message at a time.
+    Second command-message must wait till first command message is completely processed.
+    Hence, another mutex lock instance "mu_cmd_lock" is instantiated per MU. It is taken
+    to ensure one command-message is sent at a time, towards FW. This lock is not unlocked,
+    for the next command-message, till previous command message is processed completely.
+
+- c_dev:
+  This layer offers character device contexts, created as '/dev/<se>_mux_chx'.
+  Using these multiple device contexts, that are getting multiplexed over a single MU,
+  user-space application(s) can call fops like write/read to send the command-message,
+  and read back the command-response-message to/from Firmware.
+  fops like read & write uses the above defined service layer API(s) to communicate with
+  Firmware.
+
+  Misc-device(/dev/<se>_mux_chn) synchronization protocol:
+
+                                Non-Secure               +   Secure
+                                                         |
+                                                         |
+                  +---------+      +-------------+       |
+                  | se_fw.c +<---->+imx-mailbox.c|       |
+                  |         |      |  mailbox.c  +<-->+------+    +------+
+                  +---+-----+      +-------------+    | MU X +<-->+ ELE |
+                      |                               +------+    +------+
+                      +----------------+                 |
+                      |                |                 |
+                      v                v                 |
+                  logical           logical              |
+                  receiver          waiter               |
+                     +                 +                 |
+                     |                 |                 |
+                     |                 |                 |
+                     |            +----+------+          |
+                     |            |           |          |
+                     |            |           |          |
+              device_ctx     device_ctx     device_ctx   |
+                                                         |
+                User 0        User 1       User Y        |
+                +------+      +------+     +------+      |
+                |misc.c|      |misc.c|     |misc.c|      |
+ kernel space   +------+      +------+     +------+      |
+                                                         |
+ +------------------------------------------------------ |
+                    |             |           |          |
+ userspace     /dev/ele_muXch0    |           |          |
+                          /dev/ele_muXch1     |          |
+                                        /dev/ele_muXchY  |
+                                                         |
+
+When a user sends a command to the firmware, it registers its device_ctx
+as waiter of a response from firmware.
+
+Enclave's Firmware owns the storage management, over linux filesystem.
+For this c_dev provisions a dedicated slave device called "receiver".
+
+.. kernel-doc:: drivers/firmware/imx/se_fw.c
+   :export:

-- 
2.34.1


