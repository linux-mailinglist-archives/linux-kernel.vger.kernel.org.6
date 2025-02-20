Return-Path: <linux-kernel+bounces-524169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4F9A3E04D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F7A87A4499
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A38D2066C1;
	Thu, 20 Feb 2025 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fbHfuteT"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708A01FFC71;
	Thu, 20 Feb 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067899; cv=fail; b=FRpBnzC/RGR80nPdKzD3NrWjEoO5EHQbAqiZuBKqFu02PsQT2vJdTU0Op6iaYz6MZ1+1CdCgF2V/Jmni+TD2uCu132IAq5GsrhD9I1uBwiUtP7ZcKbRErgyvhUohgUP/sutvFDS9QNWuANFbx7LQY0jarGTgNO89wkdSdYkw3gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067899; c=relaxed/simple;
	bh=FVvImlBnCwvuHh5+StqcL0YkcOOu0IjY04TLSO9qmJs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=X7swhbrgbI0OdfJmzBusp6dKuY3siK1EBuJNRvffTQYZ2JhnkAdh0lugyw7bxroiujkcl9JCFM/19LaXEeSesDrtc0jBfzYLe61cSbsx8SgsGxV29fkKIt5L4DaVIWicSjiQfi4OpuH6Cb7EqjJZYSB49HlCe9Qbblnp2XxhD2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fbHfuteT; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2hVR+nGEqVZywIQ7xEhZdD2d9vqg2X915arT3UAI7McpyccFvu6FtLnczJ1I4aeja/RxbtPjMqOdSQ8lsLJ81kI6Njm922jPy11aSHgiIB/q8I3jl78ZYBDE9Yek/KtPUuTE02z32lZ+dQ3tdBfFd75cm2GzIq7ipcVDxU3iKFT8lfnDDUe567q2NSFxY52Je6UBFMCnN3NrU7C7nuk+CrT4acjBaKCnaE5Q2Q9AaYLp75ihS30hDshTcKjnPIn5I8MtXKIB1hBYFT/tNLcmmIOw+AoD+bgdWDa4+7NtY2u4tDLaX+Vc/WhkDLMedym1eiZF9GctNZ0Y5dw3SyfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMspdVUID6YpFhR6lZsL9nRqlXIvo/zWTU47664Awlc=;
 b=BMYIT0WmIZfKFzq5Dnj/fyLrzmjKu6W8jG9A3jAhUeEmQmW+la73Jdn45nPiE+Zm98S0Vso9u1HRUNdPqGQnxsCj4+PRgzrldxVmEuoUJpfeZAdHsfwp6lmirEUDOipn1Bm7Enw6y+mf5eoo4DgX/Oek/l3kf1kwiogKQfB6ZrlEmiFN5toA7fzivCbEqIVEJVruFqrTZY0X8ef46QljyFvcvDsagPlV2tXWXT0r+3aK4R/9GqeCiK41kzR6xQT0uoeCALl4KBUcyubTOMGO1cU/uzsI+jfIrhK3TfqbVsxLV4SalMm9iFNATvkc+hyYTQnpsZS5uWcoz1KzZYLZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMspdVUID6YpFhR6lZsL9nRqlXIvo/zWTU47664Awlc=;
 b=fbHfuteTbcW/uOqZ7/JCc4cQ66cPyZX8LD84foxGnd7umll0C2Z0vXrHmlNmeiVvnl5SXwt5f34+hkG6Fg/8Q+YdbyaE/+XDyM32HZivi/g2qLcmPrUsR49CgymdJZaa3X1P5p1bqohlWGF7cPcA8FyJ/m48nYN6AK4JT+7dsIDM8sUw7LPgAp686adUrdGGfQcjAKYHiVGqV1RyHXTbzJqaFShyiSnhXhCaefA+rpZy/TCy47+GPKFqbNqTxsEKB1K1B+DVWB6T9hPnt8YxW70r3kH1f7BRZODABde2eY2CZTvf2TmfXoRtnQjLWYk+kzeRgVK1ce7WRTH8Pv1eAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7367.eurprd04.prod.outlook.com (2603:10a6:10:1aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 16:11:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 16:11:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 20 Feb 2025 11:11:16 -0500
Subject: [PATCH v3 1/4] dt-bindings: arm: fsl: add i.MX95 15x15 EVK board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-imx95_15x15-v3-1-247777ed91c4@nxp.com>
References: <20250220-imx95_15x15-v3-0-247777ed91c4@nxp.com>
In-Reply-To: <20250220-imx95_15x15-v3-0-247777ed91c4@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740067888; l=862;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=FVvImlBnCwvuHh5+StqcL0YkcOOu0IjY04TLSO9qmJs=;
 b=ypQDlhJp+rL7/mz/rbPD5Mm99tcWSzYCGRe4sXYi8DYG2fcgVHFopvlZzMTY9aOx14efJYqVt
 2KYLgUwB3KWAZYgfbM+xLJ43BK7A93ppBR29akGd23xucGitkrvYpfM
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 872edb64-e859-4e95-c8a3-08dd51c93f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHZqd3lEbnVhMFJvaXRUeWxBaThJSFZ5Z2xFQ044L1B6UkVhL2pGTGR1K2V2?=
 =?utf-8?B?bDBwa1hGQTJOdHM2OG4rUUdJRFhhcDlSbmJ2dXVJd3lQSmQrK0xDUFl3NHh1?=
 =?utf-8?B?cjRaWHBOUmdDMCt4Y0hPelhXZnNldDhUUXlONEZ3WWNhaWc1blhuV1ZBRUps?=
 =?utf-8?B?R2RteGp2emNkeVh3dERqOTJETGRGalBvNVV2NHVjUkhuWllYYzJhUEhXbVBT?=
 =?utf-8?B?Nm5mUmtER0JhNFRGZ28rKzB3L0RGL2o3U3FNUjF2UE9CTSs0Y3lMSDRHL3hS?=
 =?utf-8?B?V2FVYmxRL2hiSEk3VFg1cFh0MTU4YkpKODJZVm00WVhzWWdtc21KaHhWdERF?=
 =?utf-8?B?U3AwOVlGM1NoMmpHd01hd1V6YWNkNHB3UXlSUGNpZXZSQzdrOVA0REZzLzZo?=
 =?utf-8?B?VkpEWi9UOFo0WWFBakt3eVAzWHNhdlo3amxMVGJ3Nm1KNVBZTmRyNzMwZmJm?=
 =?utf-8?B?TU1tdTdpQjIzZTV3U29RbjRBek1TK2w2dHRJbTMzOHJuMjhTdXRORWtxTXRo?=
 =?utf-8?B?eHl5Tm9ic0gwU1ZkTmtkcE9vMnpvUm9kNDFsL0V4Nk5HSDhENlBWR210U1dh?=
 =?utf-8?B?WHlNT3Jab0NmaTROM3lDQkFvRGRiQTNtc2duOE8zS2EwWFRWYytDSkJLRm5T?=
 =?utf-8?B?YUc2VU5DU256OTYycmpBM1RzYXpLaW1tbVZRZUg4Nm9mTXk3cHpZeUg1aHgv?=
 =?utf-8?B?NjFnN2cvVldUdGRYRUsvRUJiaGlBaWlmUjgwUTA1N1RIYldaM0ZCOHZRaUhh?=
 =?utf-8?B?b1pzcXpUa01DbU1wZ1YxWCtqSVVDYzNrcGprWWVNL2tWdFBJK0lHTXNjUXVV?=
 =?utf-8?B?L1o3eUFKMFNHOS9ycEpqUWxDeG81SU9JRTIycXRQSlBqcVMvZVMrMEt2dWZU?=
 =?utf-8?B?akVScU00d29sQ05xbFVoZFpKaFBTUDV4OG5MRXc0K0trTG5uZ1NBSy9RbTFw?=
 =?utf-8?B?aEZVTlZ0dUR5V2hPem9HTEgrL21ENHp6THBvV0wzbTBBSmVtWk9nYzR0VmlI?=
 =?utf-8?B?NUJ5dlFjQ1dEUjEzdFlodzE1N2Y1TWpGbWRpWEFCbmVOSWZ0d2ZRYmdQYmZq?=
 =?utf-8?B?aUJoanpqbUtUNllCTXZYMit4dk83d3VnYi9hd1ZlcmtIWW5OOERFSnRJaURM?=
 =?utf-8?B?YXVxR3E5UEx2SVQrSmcxZnJ3Vyt0MjBENmtHNUN3b096YTdIODBQZ0JDOC84?=
 =?utf-8?B?NFR4dEViaDFrRzlHaFVPbVBUemgzcEI2aTkxYmhuTXd1OGlrR2dWZVdTd0o4?=
 =?utf-8?B?dmVhdUtYM056TFhENXRnL25haGFOZ3BDWVNydzZKOEN0dmRNcGMrV2IvNUg2?=
 =?utf-8?B?QlVjZXdSc1pZSVJPZkl1UTZ3clhMTmVPTUVBb0Q3aWVPSVc4MGt5SWtjMWZz?=
 =?utf-8?B?WEZsLzRTUXIrNTlxckdxSkk0c1FsQjd3SngrQWM4RUlKS2l2VFZCeXNBOEhO?=
 =?utf-8?B?QlFXREVmQ3VqZmQ5bkxsU2FRVUd4OElpaHA0THlONHUveWRBNExpdCt0Wndz?=
 =?utf-8?B?RWc1L1FqVENPdTJJQVVud0xCTXNBMngyN1NCVmNIQjR4V0tVcXhzZVl1aGli?=
 =?utf-8?B?dkJ5NFRUREUyNjdHbmRaUTJiYWVGL29KaVRaUUs1R0xqb2pNM2FQaDVjUmtt?=
 =?utf-8?B?cVNrT2JsNXIyM1RpWit4ZkU1NUVWNHdZaVRTUFFRTng0ZXVtYWU2aVl3RFVS?=
 =?utf-8?B?MTJNUXBMYXE3dWJzTjNXaStmRFRtbThOdmR0aFlkUGRyMkI3anpiN1ZWNnEy?=
 =?utf-8?B?MlZweG0zN1BreXRGMlcwaTRteGNrM2VFUEVUSldEZkdMb1RxR2Z0UUtNSEda?=
 =?utf-8?B?dGNxb0l1TUQ0VEhRcXA5N3ZCd3BZV1BtM2txMmdreUpieWdkSEx5dDdxNWRt?=
 =?utf-8?B?VlJaU1hTTWdrbXZ4NEJjbElYaHFJcVFHc2RYdDN5bllzY1JDaGVyNmYyZysy?=
 =?utf-8?Q?zr01GNjcaQsfOlkJRohs6x/B9ZAxOJN2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azFPWjNmeW1McitieCtJdXJoOHdwYk82QVNDT25FN2VaOXhlQzI3TWxtTVdW?=
 =?utf-8?B?MXZ2d0lySlBYUGl1SmZBZHpJWDBqUFBNWm80RnZkS2hBb0VUSmY4RXZiY0ls?=
 =?utf-8?B?dmZ3dVpUSnB3cUlBSVRKckNFVGw1Q0F3NW5FdEZzVFNqOHF2V2tQSnUwdExU?=
 =?utf-8?B?ZzFUVW1aZ1JaZXYrUzBFUk1RYjF6U2dKVFRGWnBoUHNHd1JjTXRNbVlFc0tp?=
 =?utf-8?B?R0dCcitlNVRzU3VFWWQwenhZeTdTcG1xVmRDS3FNYnVYMVQxczZNVGRTTkVJ?=
 =?utf-8?B?N2xTcVorMTVVWmZzaThDTXpHVi9kc21CcFJsTnFTbU50MW4xcTc4SGdrUlM4?=
 =?utf-8?B?WTJGSi93RHpkZUdwdjFIUXFuU29zY2QwNHcwMThpK1QvRFlHclB5QWVTYWpp?=
 =?utf-8?B?YVl2eXZEbWplSEcwNnl4SklPdmxRblcvL1grZVhuS3E1VmI3MEQ3U2NhbG90?=
 =?utf-8?B?R1FCZldiRkJJT3VjZ2FYdC9EWWt5bFdsUHRjZmx0aFRXcVVobDBoUzRIcGJa?=
 =?utf-8?B?bkl5cGhPbzE3WTllSFdDYXpaZEM3VDNPQlVJYW9EdjRFT0R4NTJLK0lCWkRY?=
 =?utf-8?B?QlZKUGNJNXNZRENMSHVpejRqUlJUNGpVZ1BFdnZTN3phbFd5aE5wZnhSd3Ja?=
 =?utf-8?B?Q1FUaXo0TmdqaDZOVlpPeWc2MXkyYlNFOUprc0VwNEgxUVJjUTRKNG9DUFFF?=
 =?utf-8?B?OUc3THE1Nyt0TDBtSnhDZGtrVGsyVjd0TzZSenQ5VVY0dk0rUXlRMzF3bnpj?=
 =?utf-8?B?c1dOTHV6ZTRrUm54RXFFQ21waXI2a2wzZXBSV2dzNjlrc3l3V3h6YlFuQzUv?=
 =?utf-8?B?cmlkWFJGbDlkOExWbFRnUmJ6Sk9RRnRsLzRPMCt4Q1NaOXJWTzNKbDc2R21R?=
 =?utf-8?B?MC9ZSmtsZGZMZkkrSGVyR0pYbUhMdWVZamxqZEVJQ1Q3SVRXbnhPZ08wcThh?=
 =?utf-8?B?REZHVzVISHhjL1pWRVkyc1VHbGlnZklLSXpRTGhDbTNQTjRTblluWStBTHBN?=
 =?utf-8?B?VkJoZkFqbml6bWNLbEJrUm43Y0h0c3dTdGo2UE52Z2d4bGptaTEyb01YVktH?=
 =?utf-8?B?ejcvOFE1em5ybUhDOUpBdC81UHpmbFJZME1KZ0NqL2tBUXZ5MEJLVlhFL3RU?=
 =?utf-8?B?Ri9zNjBnRDRhWnV2USs4cm1qSjJ2Mm1nWnNMVnRXazlvaktiZExzdGNmWHVH?=
 =?utf-8?B?UFBxRmpyQmN4TFk5aEJzMTl1MFQxejhXcXdCRithMURTYmFCT0FlVWVZTXhO?=
 =?utf-8?B?b3J3bzRrUmZZdnNrUURwd1NBRzdJNlhmckt3SXNFaGd5a1lUeVRMT05NUk9V?=
 =?utf-8?B?M0tVQzZOVDlIMk54VGpPa21TY0hqV1RYWjAxaUQ3VFRBWE01NG9ZUEVlZTg4?=
 =?utf-8?B?WStjd3g2Mk5aTU9Mb253Zko2MmkyTXorL2JmNVdMeFhwbmlIalRSU09nZ1gx?=
 =?utf-8?B?N2lZdm4xc0RPS0xuNXh3SW1rS3greDh0dU9Md3NiMTdEazlDY3BNalNPTzBB?=
 =?utf-8?B?U2ZVREJRcVhHU3dJU0h6RjdyUEpvdEhoOS91Ukl3aE5WT242bDFJVnpMSmFC?=
 =?utf-8?B?RXZDUEIzZVRFaUJsUzFyckRFdmtsTFMzYnpkbGFiU1RyWTYrUlI2cml1SEQ2?=
 =?utf-8?B?ZnViM0JxQk5JNGdXeDhHQWFkUmNIWnV3cGZuck5hbXJ5WTROV1czYWdSSFRW?=
 =?utf-8?B?Sk5xb2dvK0lhYXhuR1cvSmJZNGV0Y1Q0TlUrbjNtWERJWnNMRCt6aUt4QnV1?=
 =?utf-8?B?RmdtcTM4L0UvNTJleXdRejREeWs3MW4yUENnQjdQcGZwNlRCanFYWWlodGd0?=
 =?utf-8?B?cldEZnIvU2hTTGlrSTNpNlNBMHVKY1BFQWlIcEU2K0RoY3o2SGZSMkJKRUE4?=
 =?utf-8?B?K3JINmpQR2dwdTZmQk1KSnZnQzRqUlp2c2E3NXNLN1NwU2U0RXVON2htV2R4?=
 =?utf-8?B?WXpQQ0hVNUZQNWhDZ3pBKzlBRWhBOThIb1FwYnFFcFdrVUFCVERWdHNJNTND?=
 =?utf-8?B?RmlyT3FBdTdPYnZZMXg0c1c0WDdUZjNzSlZJcXJaQ1hYMWxMdTN0eTNGcDVT?=
 =?utf-8?B?Qk1WQUZ2YmZCVlVnMGhlOE1JaTgxZ2drUkcxRVUzYnJnK3BkMVgyK2JmSHlj?=
 =?utf-8?Q?ZorvPENBYAfiVpXa0CFi0hDJT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872edb64-e859-4e95-c8a3-08dd51c93f75
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:11:35.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3B1XfpCjheFkpNZqqbJMMaewi0gSWQKAllYDRGU8PFvJ3/f/iTHH1+nGEmRxUlF9QRS8++ezt+4ckmpxToj7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7367

Add DT compatible string for NXP i.MX95 15x15 EVK board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index db781d3156981..a3a0d8a0e1296 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1356,6 +1356,7 @@ properties:
       - description: i.MX95 based Boards
         items:
           - enum:
+              - fsl,imx95-15x15-evk       # i.MX95 15x15 EVK Board
               - fsl,imx95-19x19-evk       # i.MX95 19x19 EVK Board
           - const: fsl,imx95
 

-- 
2.34.1


