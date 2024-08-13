Return-Path: <linux-kernel+bounces-285049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361379508B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB7E1F23FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63481A070E;
	Tue, 13 Aug 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OVRF+nNX"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013047.outbound.protection.outlook.com [52.101.67.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0966C1A00EE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562129; cv=fail; b=MMdSX+rYWb3MBTIIWIGqXr9vOxRgw+KzYJIFpLu4sUSjWfCjs7li5NqSkPtXeuiBb9uBgel5E2HiXDfHk0noeoyaxuvAUJbgJZ/Rbn2B+fM2tFg4kCfs4LBLE2mM29e/B2l9/RKK6z6VJKYU9yAr8Vf83CdKW7qGgeZtyxpf1lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562129; c=relaxed/simple;
	bh=/JI8s94ok2z+hT6L0BfTNT5ICOc99IOP4jbZmyhmqiE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LNUAQeZAoZnmKIIhNseH/+LSzrdz9uWkwvC/0ZrLR2tbLTLWaN6Ydt8JdcQ51LJT7pRl+A/mBxaENGOeiDjfyMiQjyuwR4WNcr1cGiDZl83Ke7N3j6ECS3GAwdkdKJYOArMtDu3/PEhCqMZMS8eMZcuZ5QUaIAStozKYgRpNEdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OVRF+nNX; arc=fail smtp.client-ip=52.101.67.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBNoGK1wOQS8ud95bPNZhi0Na5s4ZKXqg6D6KPM0WPh4+t6E2Vs7WOaxSgz/N3i0U85vlrBr2v4ULFIBlAQSxFU0KydANKpgqpeY80h577WH/Fxs/bXzHivSjwr7Vh+fgqHqjaYn1aeVOJ2pl5bMsdt+5ZVBf2LUOwA4D833MSb7gJ9ITt63hflVXuh8AiWMte3fhF0l62PXYvjy4Kh5CVjJMHTVHXhUx5TL7SaYQcUMwwx2m18o0MC3NGxHG0C+b4cnNf+9o630X+I8OpZdKGu4TQa/euzvoxCXO5Q/YZeux8i778q1miW6PuGjqTJJAmKYGbvxyGjeumZqVp7NHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEH3AqOKfHzxwLjQgVs3Ok5rqhSw+ALKLhi5IuDAIjI=;
 b=UlAAoemUynI13Uu7KomUIBlkCnVTNv7RdFzaNWlLiv0qB8yq0e5riJgLzd3doE2JI7SS8ztbRwHWy58+WgG4tPtmSF4ITfvpF4TgdvrM9lWJ3rnYp91xeYze3L3+LVRq5l8k88avyLosXexb3caH702ZFQUvSGUxcp+1TX7OiIHP+YOZcIbDwtzm3Xf3I8LxUzzGuY7Z5jcol1IHH3CZCNTNlqXMwwyYfHdIYsDjtdFCSjRcY298xJAAcltdcYPfQVbF2MfGjIWtga755AkZBdhr6rHw1gr7rDwQMiAUwxcj6OCZe3gOATTacj9jyvCSAGj8pHC9JDOGAAyAEKTKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEH3AqOKfHzxwLjQgVs3Ok5rqhSw+ALKLhi5IuDAIjI=;
 b=OVRF+nNXq5xiY6xpOWZDOnopBWDK03/ZC7JH4b9fwxHyS/4Vh3PI7ZppaxCnJPxEb9uOxAOEVvP8ovz1DgnSvrswqlGpoX7cShByRlS8/jizX0nPohfbCkn1c1XrAwfK5XPBrlhdutKEtCmYVQSZ7dQRUX+OuJqnP8c33UBoZiJFFnkYp731drBPDJwatF+lGSkAuQaQkA1Mtak5bmVemsS6LBiYASKtS3WOgO439oN1Yd0q6E0RzzFoHKB1eASpfjJSc9+ujnxsNojLCq2t69yD7P+MdrY9L+EKWPvLBpewBdzeACahab+UHn0ERiA1QWAdhJzNQ1hRhWtfU2UnMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8416.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 15:15:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 15:15:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 11:14:59 -0400
Subject: [PATCH v2 01/11] i3c: master: Remove
 i3c_dev_disable_ibi_locked(olddev) on device hotjoin
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-i3c_fix-v2-1-68fe4a050188@nxp.com>
References: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
In-Reply-To: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723562115; l=1374;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/JI8s94ok2z+hT6L0BfTNT5ICOc99IOP4jbZmyhmqiE=;
 b=k+hcRgKRsY1SW+/ssQ/u3lmwyi7D60jBG6mT4m/rVcTv+BRIKr1ZEv0HDmSLSs4UUUa6BG3cD
 /hEz/Zhv9hlBnrCB/QEh/2ISubU+Bk0lICxlV93Dy8F4woNYMdHdSGb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec55771-8990-4e0e-7330-08dcbbaac076
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MldINFA0MnhGSFRJelVLVXl4S2g5RDZta1BXR1JxK3RMYkE2NHZacXFVeWZU?=
 =?utf-8?B?YW12R2FxeWJyZWxvbisvWmdFTVNXdjJJc1psbkZSZnJwY0oySXFGQzEwMlpi?=
 =?utf-8?B?aVRnazNUcnVld2M5MHdWY2FYai90bnRaa0tKRUVleEttcG1KWEdMSWpQNjFx?=
 =?utf-8?B?NTJoL0oxc2dHQ05uUkxJRnBqL3pkZi9xRkdaWEFPVDd5SVpEWEVmZmFHN2V0?=
 =?utf-8?B?bFNtandqQ1B0N2grcXFrczZlZlQ3bHpBUS9kcUhkMjZJTnB3clFwb0xkQnJM?=
 =?utf-8?B?MVFRWmh6cWY5eEtqZnlsM1dmRjBKMjh0Z3NvdG5zQjcyazhabUNYMHlLWnAr?=
 =?utf-8?B?NEN3N0ZmSmFEb2RtcnAxRi9XOFE1UGN5cDRhSHp0UkxvTWNjREo2SVZKbW4z?=
 =?utf-8?B?ek5ld1A5SXZ4WkNHNnRnVFRlaWF0OXhMQmxvZ1dUOHVNSWJ4ZEwvVEluR0c1?=
 =?utf-8?B?OVZ3ZmY3VjF3UDJEc09hWWdWNXYxOVVBcnBoNlNOMEd3M1lESmRjbGNzeExB?=
 =?utf-8?B?ajMvSlBYYTdMcnc3c1dJS2lhT1RKbEthQUo0V05pKzczemtJVXBXMW8wQ2gy?=
 =?utf-8?B?U2w2T1lQT1NtMTBSc1pwRHRFV01UKzFwS1RNZ25QbVpTZkQydU5DV0w1ZkVy?=
 =?utf-8?B?YUpRbjBtTXE1MGlRQ0dIK0Ryc0RWczczTUtHWmxJU21wUThGUzhobU1EakxO?=
 =?utf-8?B?dS9yb0VDNkp4RHRZaGh6SG1XOEVzeHVPdVMwbitLV1k4czlWK0JHQXlhVjBW?=
 =?utf-8?B?UzFQRVd1N0JjdGpPZGRwaVdINW93SWcrZnRxeXVvV1lMeHhSZWoxZEJKTjBM?=
 =?utf-8?B?ek1SVHFkU3U4VTh0SHRzWmo0NHFiU1duWXpONlVuUEs3bStJeWFNY252RHNS?=
 =?utf-8?B?VldaYS9PWE5BNWNLSmJQaEd4TGFCanpDWkd6L2FRdzJCem5GZkY5S2FKNE9I?=
 =?utf-8?B?K0RjZlVDclVOQTIyUGRKL0VCWmxVK250bEN6ZHJOMEpQNlpyRk1uV2xUMFZq?=
 =?utf-8?B?U2ZYOFgzei9ZVnc0cExkbkNhVXA0ZjJ4TnhzTzdOWmFpZkdzOENCK1prUFhz?=
 =?utf-8?B?WU1PY3gvWWpwZkE0UFV0THZza2I5YkozOUVFMU9IZjZmRXB3ZWsxSnlWc1lH?=
 =?utf-8?B?bk05Um02ajJhajJPODNOMURGektUUmJOckNQaW1lNEd0U24vYVJ5eHJpVWNz?=
 =?utf-8?B?R0xjcC81YXNvUUNjcXhHNVNSajRRZWdEZWowUnhwR0NqOHF1aDRKMVZIcDdp?=
 =?utf-8?B?Q3ZxWHh0VWc3cTM3cmhxTEEyald3ZnN2YWRVTzYxVkUrRFR5aU5aNDloZGE5?=
 =?utf-8?B?L3VUYjMxR3FQU3ZYdU9ScnlJdzZvVmN6NmE0L0N6TWNyTktlcVpzZjBobWdm?=
 =?utf-8?B?MERCT2ZocGlBQjFUZ0NqM0c0cVdoelpNZ2dSeHlSTE9ZbVpENHlHM0NJK0ZR?=
 =?utf-8?B?ckI3OHR4NVhWMldvemE4Z2ljODRxSGVWbXNKZkxSeWhONzB2em1VOFVIeGVt?=
 =?utf-8?B?WjhlVGY1azBzN2ZrQzlHMlBPcXVsWWptWk9Ta0ZiejI2dzc2S21nZWgzUUVP?=
 =?utf-8?B?QUM0Z1dSODNyTDdRMXlZVW1yME1iWGlFdjBkQ3NrcHZoUmJtQW9HS0hUczVj?=
 =?utf-8?B?V0l6Ty9wL281N2JHTFNUU3ZOSVpxV1UrMG1vWjlNVGVlbVdLcUh1UmNRc3R3?=
 =?utf-8?B?aUlBSlkvYTJiWFlwT1lYRUNSM3psNHA3MUtXV0psSWZKQmt6QXZYdktSaWpY?=
 =?utf-8?B?SkVZT2hHY3pmcUNiSm5MclNaQXRNYjkrdkdrSlN4K3g2bXU4OWNKSHZGMlpU?=
 =?utf-8?B?U21ydDBzWEV1N1QvMHd0dnk3OUNlSFZVV09qTVAyRHFVWjVBN0xyVUwrSEs1?=
 =?utf-8?B?WmdndFhWTlJ1TU9zeFduUS9YSkVodDN2bGIzRHdxaWg1WWc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZjBzZWZsdHV3TkFRMDlDbTBRMmN0L0V2a1VSWTVCOXk2ZEJuVmc0bUlCdS9W?=
 =?utf-8?B?SUUzSGNrQzRCc0VtdWM1K3VFb2tFWXBJL3lVS2F6WUZuN2M3QjZQZWhFd2JQ?=
 =?utf-8?B?VmVocVhDU0c2bmxhWUxCTGltd2RObngrYWx5SVZ6Um5ZNnJzSExkSU5zbmpx?=
 =?utf-8?B?T1hBbG1qclFjWXZobElqTURKVWNBeTZGZDJmL00xOTRDQmUwNC9qZUlDM0N3?=
 =?utf-8?B?RXNHOTdVcU0zamZndFVkblNNMlZJdGNsZEk2UE1XYyt1N3dCaW4xTU44TGd0?=
 =?utf-8?B?c1JJR21EdElldUZ4TVRuaWxpOGx2Y1VZMTVUempHTlNlRUdPRnFxNW1INjFF?=
 =?utf-8?B?L05rRlVpUmFMK1p2TDFWVVo3US90emFsN2s0VlZmVHBaVTFsYkZ6OUk4WHpw?=
 =?utf-8?B?S292YWlaTmtLeE1wNnNVUjVWQnAzR1QwRkNHRFNlYWI0M1ZTdDdhQkJOUnVO?=
 =?utf-8?B?SlM4OUN6Z1ZMVGtZU09yYnNoaC9VWEgwcTJ0S1NWNGdwWFF4MUJXVVdKaHRa?=
 =?utf-8?B?WVlnTTh1NWlkU1hrd0Y1L0w3RGJyY3FoL1FibCs2aFJHTjhEMWxlb3BVOTlQ?=
 =?utf-8?B?S3U5VU5tZ2h5OXUxV01FakpLN3RoZENrdVBTdzd2dUdGenArTzlSVXAwK3Nu?=
 =?utf-8?B?Y0VWUWpYei9pUkp3Sk1vais4bGw0T1NJUnhtdzkrS1d6TjBqVlhoaUtQNnZK?=
 =?utf-8?B?Z2JtVXJ3eHBRR2RoQ1Boa2h3aGNnMlI0dHEzWk8zSFVMN1kzRjhOVWM4TGV0?=
 =?utf-8?B?Zk5NWkRzNHVBVUJhUzJWSllnY3dpVlUycGYxaDA5OWhESzdmdUVLbnBjV0N6?=
 =?utf-8?B?dnc0UlczYklLZ3p6NHU3WURldVhDOFNsQVNML1JJT0ZGQkpDWllwZHo3ajRG?=
 =?utf-8?B?OStPT1l6TGxlWm00bGl4UEtCeWpyM3pYemVlUGtLeGgxb3Y3UUZHOG04U0x3?=
 =?utf-8?B?ZENGREEvcTVZbm1pQXFXQmNSV3FDNDloYk41YXhFSCtoYms3YkR4ZDBnRVFJ?=
 =?utf-8?B?VDRoNjhtRm9BbFEzSlZYRlcrb3VLOWt6UTMzUlNiY01TVlhYT3FpSHhIVE5L?=
 =?utf-8?B?UVJiUHVVajZJRHMwemlRNVRaWDJpNTN1MkFmTlU2bUtPelRoWGNBaHlnK08z?=
 =?utf-8?B?TXo1Yy9xZTBZL0l2NjZJMnlOS3pidFJKbzdja0RBbU9nNnVjVmxKYS9yQjlO?=
 =?utf-8?B?U0MxUlFLQnpTdkZVeVluWUo1NEd4TlROZjVBSHRFM3JML1BxL0JZcUJwYjRT?=
 =?utf-8?B?Y0syYlc0ak1XcFdHZVY4WlhMZnlDSHFKNm51MExZVzh0RzMrbjkrTlVhOEY1?=
 =?utf-8?B?VGR1NnVDVkJ0YXpiaDlscEV1M0h4enhCTi9mWVN0cUdhMXhmanN2VUI2SW9j?=
 =?utf-8?B?Y0huempJeFJXWDMycTFNNFNwZVEwbDhPY2U4ai9vRi9NV3k5cVU4cHZhZUVk?=
 =?utf-8?B?VU5pK1JLSkFwWWd2UXJmRmJNbkN0aWUvYW5tOXVaZ25acVJZM0xOR3U5UDlQ?=
 =?utf-8?B?dkRidytMb2h0bklkZTlwTmNmZ2FkNHU3R2M5aXQzUVBFWVR4Z1Z0KzN1N3hv?=
 =?utf-8?B?OElqaHlVcG5zTWphWUQvR29SY0VSVi8vUzBjU2QrRVpoa29icHBjU1FnQ2NZ?=
 =?utf-8?B?Ump4Mm40NkVVNGJZRXVmaFZqSjNXWEhxRlVkMjhwcERqM3ZwWWY2elkza1Ra?=
 =?utf-8?B?eTlDbVRMOGxYd0hNWFArTFZjcEp6amtuaFpjc1oyZndTdlhPMmx0UDZHOUp6?=
 =?utf-8?B?M0p3Wm95MDlKa203cGFWb1pjSXB1eDN6Z2EwaExnTnQ1ejd6YjRUWTN3U3N2?=
 =?utf-8?B?cjVNRSs5QjRpSytCZGxBd2hyaUlDc3pTYmZBcnl2Tjc5SkV5UGNLTWh6N2xQ?=
 =?utf-8?B?YzhaYnNJQjZiUmp0ZFJLb1p3WVd0TGZMRkFuM1E2S04wNmR6eG9HRStPUFFE?=
 =?utf-8?B?ZVdnQ09tcHpnMkNqdmhsU1ozckdhZGdlZWd5ZElaKzNXbHJJbzFTK2ZVWi9I?=
 =?utf-8?B?clluTVEwb1pyRW5DUHB3ZWRiWVlqZUM2ZDRuaUFyRnNUbDRrR3IyVldXZjRR?=
 =?utf-8?B?ZFlrVlIwVkh5Z2Y5Zkgvbkg5Y3pTRGx6Y0xWakhxaitsUlNVZWRNc0NzNTdq?=
 =?utf-8?Q?CMHs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec55771-8990-4e0e-7330-08dcbbaac076
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:15:22.8705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBba6ev70Gm2b/WQoF1ki7ddPJgBKGGNVatrJYpFGlQKdGlAEirtj3F4g+kG6Cf6B6/GvVrMYb9KI6bcIkRjiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8416

When a new device hotjoins, a new dynamic address is assigned.
i3c_master_add_i3c_dev_locked() identifies that the device was previously
attached to the bus and locates the olddev.

i3c_master_add_i3c_dev_locked()
{
    ...
    olddev = i3c_master_search_i3c_dev_duplicate(newdev);
    ...
    if (olddev) {
        ...
        i3c_dev_disable_ibi_locked(olddev);
        ^^^^^^
        The olddev should not receive any commands on the i3c bus as it
        does not exist and has been assigned a new address. This will
        result in NACK or timeout. So remove it.
    }
}

Fixes: 317bacf960a4 ("i3c: master: add enable(disable) hot join in sys entry")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7028f03c2c42e..852b32178b722 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2039,10 +2039,8 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 			ibireq.max_payload_len = olddev->ibi->max_payload_len;
 			ibireq.num_slots = olddev->ibi->num_slots;
 
-			if (olddev->ibi->enabled) {
+			if (olddev->ibi->enabled)
 				enable_ibi = true;
-				i3c_dev_disable_ibi_locked(olddev);
-			}
 
 			i3c_dev_free_ibi_locked(olddev);
 		}

-- 
2.34.1


