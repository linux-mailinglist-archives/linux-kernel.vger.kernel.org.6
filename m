Return-Path: <linux-kernel+bounces-355503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 969E6995333
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BE21F25764
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9347E1E0DC1;
	Tue,  8 Oct 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cPuEWmBS"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51FA1E0B8C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400739; cv=fail; b=Bma+/0NQ+RE0UZ4QUP5I53tVXyQZH2p30+fFgvcDviuYda9Gw5n32fCl0bWAA0Ju580qZfSz+6xaQug76y6PrxflRCmJyk032y0EGh4+WH9WsJBCNcViC7KkhnHUbHhG84rea8q4EOCEFijj8wvE/E4eEEZobJ1vSuBDqeT4pA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400739; c=relaxed/simple;
	bh=fYQXCdK74snyRv7MsUE/w/+rHiPoijiH/nm36eU6gIs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TP7rl9GKQRGxz81d6WvAvoBo1Seqma1VDU0EhwhRSp5MmTvXOyzQeXpQmCjVmcRFh3HdHN2dzjpI+dyZP9shAGXz9MS2dVZfd447sC68gQs+vjRBBFTV/SFfojWU4bn1dxupSRWO8349WdNcMmjZN6ZW82c5UjPGtiZ+aVNtjas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cPuEWmBS; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqwLvup6EdrLHRJ414dPRWhGjnhrA1AkGTRUGFkWl7aKQrql83+lbSVEKcZCRibe3ML4hq4RnMphLG7e3RvLXEOC7hMjFV0i3zlJDSzeEYy1ONXBpntMoVcHpPxCKhBRSDyGIrhLGoqnx35jEwJKYL+ymH8pE4kav9tjaXlLVtg0Tqgjg9BCiR6JYZxM9LetYUuMOp8RUNONtEg5hs23/0rtsTaWntAthsL5RCrp6n28ilk595JvbO8F+njMfEO/Pn1A6H0LL6RDu9VpFOjHqu5k5g1lcF+Pskdr3TEqrjryiZfTkP8lBd7RFzKlcUlUE8CIVBPeli4oSyxDZLM6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seUGrhq7525Aji8QqixFCyRDtakFX5/Xp2TzxWHsoBo=;
 b=ZspkfjTWVEsxMGBpUOgZkJv/KhTx8NswpCAUSXPGyWKOhT5KzBE113DOwW/wDuoAXEXKJsdGMQICODBf1xWpSzSkOknB5+6uriAf6nowi8v+hwXaeJLppXcpgoMsQaTFxivUsEbK8pZf24IQG3c7KfJD83r2OfvdqYEtEwSOPZSIgdKs+50J2CTc6wAMMgvxYyDeH5AOL2T+HDq4mnMLxgGQKkD0AIBmL4w2+b8BSVT/NiaLmOiMo/8KXxmEwRiajNZA9E1j4jVa1kAxLOB6SfxYkLYgJxrzxG2t2BScRXFQApuT2pTnWvjk8hYJFlNCkzIPx24P4Vf7q/AdqPmj9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seUGrhq7525Aji8QqixFCyRDtakFX5/Xp2TzxWHsoBo=;
 b=cPuEWmBSz2OzFXF2vGAicNujW/AoF467Zg4+4IAYduv6Sx6SZ9/f0MJuyf5Bk5B+TaaOtBFSdso4l2RC9K2yeKFHaJRoCqrM10dtCllgMJTolvMyZ4v1N+k2h+YvwsPveFqE+IBfvMXgdlhRL8CktbrPYhmUQaHThB7SC9m+XR522sDLa5yverifAJ4Bz60KZTRobTh7JfXXj/WO1qmEg6qHtmF5NGXqjkgzV4C2HtN8Q7TeNmmLHT5uoHxOmsZzVf3BMjtKL8WWigK52oeULGzjZFWZwfON5NCqWzIYuy+ACIhoKCHwQqLlcTtMhDB0a5QcVBF4Ojl+smj66qkiiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 8 Oct
 2024 15:18:54 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 15:18:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 08 Oct 2024 11:18:26 -0400
Subject: [PATCH v7 3/3] i3c: master: Fix dynamic address leak when
 'assigned-address' is present
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-i3c_dts_assign-v7-3-96ec93d1f34c@nxp.com>
References: <20241008-i3c_dts_assign-v7-0-96ec93d1f34c@nxp.com>
In-Reply-To: <20241008-i3c_dts_assign-v7-0-96ec93d1f34c@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>, 
 stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728400720; l=3796;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fYQXCdK74snyRv7MsUE/w/+rHiPoijiH/nm36eU6gIs=;
 b=fWsH4+cyiVF/9mzhKugs22BvUe9clSOdxCT1bXI5Bgz4y689aIN7eUb0FtFKIHI6be7lQrHO3
 nuPZK+209xKCOPxfesfwwoMuXAU5Gr56ar5Dv4NqrtXME+t41GT0Rmr
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0101.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::42) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV1PR04MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 8985153a-0e14-4ddf-f2b1-08dce7ac8561
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SGZuamlGbTZpTWp1ZGR5M0hqdm5xRlBaVlRZVEhmbDhZcHYwaEgxMUduTXNj?=
 =?utf-8?B?clNkb1RaWk5vYlN2bWlKS2V5N3pzMTVqR2ZlY291NzlDRlE3WlpRLzhEaXJG?=
 =?utf-8?B?RE9QdHpmN0xlSU9NK0VLUUFaY2w4bTJaWFJWWGtqQk9RNGk1Z09ERGdSK0hP?=
 =?utf-8?B?N09yUWlvVEZDbE9hS3dORWQ3N3BBR1huR3pMVW9leGM4cDUveEwxeElITno1?=
 =?utf-8?B?aXRVQ1ZVNGZ2eU9XWEZYM2hVL2xBdE9JSmJ0Sm9zNTBwaXdjemtPSk1UTzIr?=
 =?utf-8?B?bk1FbnlwWTFmaFJCOHZHS080Y3prOEhjUUdOcjQveGQxT2RCclFqNzU1Qzg3?=
 =?utf-8?B?SVFaWVpzbHJlemM3KzE3Y2FUQWdVVWtEQVBxaDNJNlRHWTZsMFI2SStzc3cr?=
 =?utf-8?B?aDNLSFFXOUdFcFh5MTNVN2dRbkpMMGordVl3L05aYytGd2NQUnZhbmczcGZK?=
 =?utf-8?B?VzhKNWw0Skt6bHBGS3pKbzl3RHJVbkFScE5mbW1HQi83RE5TdjRscUpvdkVQ?=
 =?utf-8?B?alhZN1ErU0tMRFVlMWZrQ1htM09BNS8xdTliWTh0OWlrNWQybUZMQVF1bjMx?=
 =?utf-8?B?ZDhXL25BN0xwZmljMUw3MFZCd3JDSFcwU0ZOQUtXd1lCeU5EcjRqYlhLNzVa?=
 =?utf-8?B?V0NEVENuNFJjd2Nkb3gyS0IrQ1hVUDJoNGp5NG9qNmtOY1FIMzRCcmQ4eTJG?=
 =?utf-8?B?SGI3Z0orcXpVUG5HWGFNazI2QWFJTXpYSDA1NnhpV29nSHBFVjlPcWtwbmkv?=
 =?utf-8?B?YS9sdXVnaU04Y1RYaHc0K0lPMDAyVmFTbnNzbFc2eXVJaXRSTEwyWVhxZkpr?=
 =?utf-8?B?V2F2WlRmd3RoeVJVR0tQT08rR2NRVWZsUDY1akJFdmV2WEw3VjhJbVE1V3kz?=
 =?utf-8?B?dFNKcURjVWhjZHkrazNWTEtiVXNIUzVTL0JLVWRsL0lkTU1mYUFCcnNqTGdv?=
 =?utf-8?B?MWRzeUs5VnNrOGhXK0FzUDdONnR3V3V4cDd0OVR2enY1TCtob0pRSG5NSDMr?=
 =?utf-8?B?QUNvMWtnelhacmlnOUgwLzk1V3VqWlFqMmt1dERmSHd3RmxIemhGZmRXbU9Y?=
 =?utf-8?B?RExtMFJVbHB4cWEzRFREemo2L3BGQ0o4Tm5xajNoTlZId0VUcllla3IrNzVa?=
 =?utf-8?B?bGRuNE1aK0x3d3dicWVIMFRjVlhpTXRjbkc0M1IvUThyWnhMMzdOdzJIei9L?=
 =?utf-8?B?S3ZQSEdvZXcxK0tJY1ZtWXIxZFl0eUZVcElRRTVDcFFUME1JMDhMVGd2RTFx?=
 =?utf-8?B?TXdIR3FDaEs1ZFc4VDROZktZRjhZUmVBVDI3QmJXRm9QSDI2NnlZWHljcjFS?=
 =?utf-8?B?YWJFRzdaRGN0b2laa0JxUHdmVHdXV2ZQdCt0MVVKdEk4ZlJxTWVDWEd6MXFP?=
 =?utf-8?B?ZUNveWZXV2FhYnFjald3d080SzhJSUNkVnZMcWIvYjh5dURLQlFxV2dZeXVS?=
 =?utf-8?B?ZDgwa08xb2dmU3FoYjQwL2NRQ1hvbDB3M3E0NVJHUlluR0hsRXYraDh0amhF?=
 =?utf-8?B?alNGdGZkaG9peWJWZmhpaFYxYk9ZdjV3bU10TzN1b3RBR2pIb21CSzNwOThs?=
 =?utf-8?B?Qnp0TytZOHBVS21JdWxuRVArN1pJb2pySVNMZlJTMW4reFZCUHdEZG9WNGRL?=
 =?utf-8?B?Sks1eWpzZkdYeGdPU3BBY1Iwd1VsdUJDU25CM2x4YUl0Y1U3TUJaSUNmdzFC?=
 =?utf-8?B?UXRuNG5LZ0RVQmNrNEJSZXRiTytsMTNBMitYQlFaUk5kQXVQY2QydzdaRzJF?=
 =?utf-8?B?QzltNXNqVGEwbWpoUzFoQ1dXWUN4U2tNNWk0dnNpNkFLUXh2QmxvVjhpb0t0?=
 =?utf-8?B?NEw1MzMzR2NDaXNIS3VFZz09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?azFHZy9GQ0RGOXJnYnozWER6UUNTU0Q2SmpSeG40bDVld05RNjB5cXJHZk5H?=
 =?utf-8?B?ZUJLTzlvM3dERTJIK2tmQVgxcDRvT3psU0VMalFydFFDMGdSaXVYU0JSZmNk?=
 =?utf-8?B?RFZpNHRCak9DaUJjV1VaU3k3SzE5VGxRdDRZd3A5THZrc1Bjcm8ra2pnWU1z?=
 =?utf-8?B?TW9MK2hhUzVtdGltNmI3UnJUSkZ3Qk01MDBrYk9tM0xjZ0wvVnhyMTBwNE5m?=
 =?utf-8?B?THFwd29nV25xTTRIbmpvem5hT0RtK3VDWnZsK3ZvTG52RHJpbURXTXpBOWxH?=
 =?utf-8?B?M04wcHNKdTdwZ3NYSXlGY1pzOW9QVWF0TVh4N2pWRUlsSTVoeS9weWt3SFRz?=
 =?utf-8?B?cktZMUx0djhIQU5ZZE1nbFFYTXdmekxrTk9OOWhVVHp3dVIvYlhNVVI1OGNJ?=
 =?utf-8?B?dzlIRjNadWFkZlJrM3E3d3lTQUpBRmlaWjkvdnJVdVB3V09Ma1Jkc2wrdWly?=
 =?utf-8?B?aWV2YndyUCt4aVgwYS94M3VranR1M1BtTjVzUFJVV1JHd21uRHpMaS9lcW9a?=
 =?utf-8?B?U3NqZTdaSmpQdHVEekdneGRoanQ3STRTamZ5ZXZEV3VYczFsTlBzOXBYdk84?=
 =?utf-8?B?UWVubHpBU0p6enBMQmsrYWxyWkthazVHL0gzUzFCRXhyK1hlWlYyVDZVQmFS?=
 =?utf-8?B?VmxvNFNTcnFQMis2cnBuNHdsNEt5TXBSZE1UVkxEaFE4Zi9Ndyt5emwxci81?=
 =?utf-8?B?SDBtOFMyc0QvVytrYUNwa29jc0FlY2lUa0NLV0V0VlZKSEI0RmU2VENZZE1O?=
 =?utf-8?B?TWlPYnRWemxlMXhhNURvcmdlVWtDMk5scmRhdDdCbUhBK3dqWmdBWE9DWXVR?=
 =?utf-8?B?czJtQVAzTElNK24rOTdydUxsMGFONHB2cVRHSnJ6dDh1MTVORG5hcnZwanlP?=
 =?utf-8?B?K3dmdnVyVkY4UTJwcGpaRVNhTVhFU0FoTnc4L2d4RlhBdXlWamhpQlJFcTBu?=
 =?utf-8?B?ZUFDckFuVzdTZ2ZzQkNyWlVPNXRzWTVqUm02NmRSQ1dyYktTc0hZZmljNGtl?=
 =?utf-8?B?YjNpMG9yM0xONmZZQXc3Z0RpOHQ3ajZqZmtVeHQzbW94U1lvNGwzS2Jxdy9m?=
 =?utf-8?B?aFFJMFJzQUNQbkdjZTRiZTNaNk5hU2dJY21WZ0RCVzNjSm5HU3RrZnJQaExr?=
 =?utf-8?B?L0RVdG9ubjNHSTFieG90NGhpQzl2Y0ZwM0dpYUdJL2NadjBuOFFOODFXdU5m?=
 =?utf-8?B?YnVvcjlaa2ViYUVXem1CNnBxNGw1VThFSzA1UlFSZ245T1B0aUppZjlFdWY5?=
 =?utf-8?B?S2d3NFdRd0c3YXQxZld6Q2ZUU29hOHA1d21YTWtFMDhHbWYzbmxZajlNbGx2?=
 =?utf-8?B?SHFsTHJ2RDBRWG1INVhKZ0hacWdoWGFxZnl4azVIRVc0QTZGK3d6WDk1aDdH?=
 =?utf-8?B?VkM0M1BOckp4eDMrVzJVa0NOd3VtSG5ldjkzb05vQjUrV2UxMldBc0E3bFlG?=
 =?utf-8?B?QVJWQ0gzY0ErR2NQeEdVd2VLdkJoV3EvTlRkcU9vR3VQWEFyR1RtbHlSZUhL?=
 =?utf-8?B?Nk8ydEN5eEtlWjZsQXZNdnhweC9SQlVIOGUwTDMwT2E1Syt3cEJOc0QwQ0la?=
 =?utf-8?B?a0k5eDhyc2hidG5IeithcXJnb2oyd2RIR0IvWndFSy9HQzY5RDJ2dURiZmRF?=
 =?utf-8?B?ODIwL1Y4eG4yV3pjckxqYUJ3c3RaLzJ6eEQrKzhiNUtaSW9lWHF0S0VzOU5C?=
 =?utf-8?B?NEZ0L2o1R09Id0pkUkxDbStnbmJCeHNia2RLR0hPRmN0QXBDSWE2VDhPcnJn?=
 =?utf-8?B?U1dLdjlBY0RLTGdVV05vM2M4aWkrYUxuR2l5VUI4UkQ0VVhpb0lnRG1IK0xp?=
 =?utf-8?B?NFQrT050OUxqempOaitTOHEwcVBFMXI2UVZudEtoMTl5ejNUY1BVRFFXeE42?=
 =?utf-8?B?SVB3M09QeXFrQzZEYWxybnJHWCtsMC9xakd0ZlV6bTZvSlA1aEY5cEFtWkRE?=
 =?utf-8?B?cHlqbk1KOE9vNUVHa0Z6SkwzdkNjL01rUC9qTS9vY01hV3Y1WlczeUVsaUR1?=
 =?utf-8?B?OFA1MlllelYycGo0MEJqQVhSbTc3VHpRS1JjVzZNdUxIT0MydnpPNjcydjhl?=
 =?utf-8?B?a3FPUFRNbDFQL0lwaWt0VTEwbS9aWjVsLzA3R3JSQk9VbU5Qc3VBREdLeGlL?=
 =?utf-8?Q?dOig=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8985153a-0e14-4ddf-f2b1-08dce7ac8561
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:18:53.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2373gy8CNq5op3mKurhu64q+HZIqSF9+0gg/9Kjlit+VnXWEvhSbzjWCw4tLQxl9DhytBQXWc7dikFF8SaBxUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9151

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
index e0962a17de7f0..9ccfabf849c42 100644
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
 
+		/* Not mark as occupied until real device exist in bus */
 		i3c_bus_set_addr_slot_status_mask(&master->bus,
 						 i3cboardinfo->init_dyn_addr,
-						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_DESIRED,
+						 I3C_ADDR_SLOT_EXT_DESIRED,
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


