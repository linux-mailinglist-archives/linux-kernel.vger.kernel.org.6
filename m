Return-Path: <linux-kernel+bounces-561673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09389A614C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E481B61761
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4B120127D;
	Fri, 14 Mar 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TZhX7U/N"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2047.outbound.protection.outlook.com [40.107.103.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE71FF5E9;
	Fri, 14 Mar 2025 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965847; cv=fail; b=G0kogRwRo6HPwlcZ9jZd9XylYuCdqnYprfTvWirVv4Q0TCdnVuvnDZdbjcIIMwL/TA2fnCLlJuVPbQpwdkWE3XdTabDZrIUApD6ppnuyDKU6TsXoF1N9h7QApPx4Bytmb7BOPOBaazIB0Y0bUg88wYGhrQR/Iw3OhQjbqAf1gJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965847; c=relaxed/simple;
	bh=kMQG1nWVlwJxYCJJ4idBxeCemmig8Phro/azmXSGBDo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=YQ2Ip0Tudn8Ia5qLqBHbAKs0IuRMtM3fLULrs1eoNWR9Fl1JoHSHkiR88yD6zVu1O5wHPrB1XwTi3JGNmyDjGy8rI98AVW08UxM1KiXeOQIipRzVrx4wiap4Jqg6zhwcBBtNu4xqwx3j2/cF08bUillsclatn/I2pxuBsbZ1lh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TZhX7U/N; arc=fail smtp.client-ip=40.107.103.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KO2zVdCuRHulppAi1KPJRzDFX2BQMfJI12zQK2K4oNIxlykzQ1P4SxTWdZ+83loYOwJPaF4DcVZk+RbgV8WxD65Fwc1tLX0nowQcadvti104udKpGh7hulCXAMJYc5hzuwFhc4EY9OnM4knw/JJoGE4WnPjenDorpu86Zovh4bCJz3CS6RxyuTXGqsRuuVYJf9Q13Bu2V9p3QsicdfebdFax9ojptzwag2yv5mHjOUa8fSUN86BojLjrOpbawRW5Hwd4b4MUCOn+lix0FJ2nCRCAq4XadVrbGvGJbxuqlgj6eKACOXpDkbk7SLnsCxMoHqFcKCrZQGJuA6bC1qSUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5U3IEn5YlIQ0KP6tURAdorjPz4QUolk13MC+CvC0hKA=;
 b=xUcczdB2JJ0AY+rzN5WKhPsS72U+mvwO08ZKOUnjNhRFsAuA/zTgUJNvTI6krfNMEgVXqm0PUmhO3HqMRzXiOiVxyntetIONQIsvAUsbMbTftphYxGMIRSiSzMmDYxila/DVdkoR1f3P80LvFDNSxqX2rNQB3008OhCABFLcFhJBBeh1VI5oz+/iKHfHoHpzqHXddPrCUFqISa/SlAhJ58pcCvrbUWHUWL7N+Pmpbm3mpg776jTGo4Z5MPoBFqQVgxm4ixu4VgXTMCnHDqxNlCo8omBCccuPKRPG7AslLQaiCjVeWB3PJANfuXJIunjWPWaqKf4FU7jv0Iow/forTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5U3IEn5YlIQ0KP6tURAdorjPz4QUolk13MC+CvC0hKA=;
 b=TZhX7U/NJHqxOkldDEANiMLB9uq0muQ6JrubFjgd/ooRcJDM8n9APZx/H0U8yfnHKuuT8/GCzRLBYeyUy6RmxkkplNaSxwjFR0mHsSofHPs25jLacJiG7YJlvzsT4JU4X2IwvuNAPu/vHy5C61uoRK0Rl8hYZxHQeDOHqk1KJcNcABYNzZcoitkDe5/kcRfFpxkWlm0weD/3OcS7KMKB09UdoBaZ+68TdkGb8tiPFAxUJS1mwybcVws5G9hwZkJMX6T12RbBL/Jfx4tc5gV9zbfhosPz7/M/4XYP4sL66WRnvwNg7Bjo5d/1hEcRwiE8DSe1gU9Tx1qWXb8Py1aWjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9730.eurprd04.prod.outlook.com (2603:10a6:20b:677::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Fri, 14 Mar
 2025 15:24:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 15:24:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/2] regulator: add new PMIC PF9453 support
Date: Fri, 14 Mar 2025 11:23:45 -0400
Message-Id: <20250314-pf9453-v5-0-ab0cf1f871b0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFK1GcC/1XOTQ7CIBCG4asY1mKYgUFw5T2MC6SgLGyb1jQ1T
 e8ubdIfl9+E5w0Da0OTQssuh4E1oUttqso86Hhg/uXKZ+CpyJuhQAUoiNfRKpLcimCKR+FIo2P
 5cd2EmPo5dLvn/Urtp2q+c7eD6bok9JLogAsOQWlDAArPcC37+uSrN5sCHe4Q4Iowo0i2QC+sl
 qT/kdwjuSKZEZE5e9BWAtE/Unu0fU9l5Gz0JgonhDUbGsfxB+DH3R85AQAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741965840; l=1642;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=kMQG1nWVlwJxYCJJ4idBxeCemmig8Phro/azmXSGBDo=;
 b=bdAOuHD/zP2syXrbCdkPPmtSf0yMPm4E5nfRhvxv/+6Nxk704pmCOuNuAzlGFHabPRY3WY1Mp
 8IxUuXHFmlwC+kHnvZBF2JP/WnfCdXjBMsyewzNHm1d9vG+spBLtRdQ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:334::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f06481-3ed9-45f6-0f73-08dd630c4082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2NuNUxXZGV4aEQ5OGNiYUVHWGkzNU9SSDV2eDNmQTFYK09HMVorSFUvUVFy?=
 =?utf-8?B?bzlUZmwzaG9GWlVVZzU1OW5vOHQyYXdTUFE3QWE0VGJYS3k1QWlTTXdVQmJJ?=
 =?utf-8?B?RVhVQy83UHBVOE0vdG9jeEZmbmNDWnFFUWM3di91cUtxY2U4Q2xac2lCNjhs?=
 =?utf-8?B?YWF6NkcyRDhwdzhKR2dra0VDWTJtWW9HUjJQUndTTmY4WmJvN2NyV2hrYTM1?=
 =?utf-8?B?N2tERHJSQm9FMHd2RWpUVDR4RzB3MjVqOWJQSHlHR0pObEpEYWxFT3NheE45?=
 =?utf-8?B?WTNCeXpnMXJJQWFZUHlvUE5ucDRrMFdjbHBBdG9TVGRLYkgwOW4xczBmb1pm?=
 =?utf-8?B?aDFHS0t5anNBeFI3RkNBSHV4WmNwd1NsdE9wdDhLdDczckhRWDZSVnVRL3BW?=
 =?utf-8?B?QlZPbnVZUkE1K3NSbTBjOUpPSkg2TzVYM3ZTZ2JwZlZHSUJZY3IvOENRNXEz?=
 =?utf-8?B?dlNEQjNndUVZV3lDOS9wTUI1czg1bFBFT2kvUEJTTjU5UWJUTDZKZlpYZzNa?=
 =?utf-8?B?MEtoKzRaOW5lZ1Zlb0ZXZXdlWGg1YUJpd2wxVTJtbmkrUVJyK1RnRjJCU2Qy?=
 =?utf-8?B?eWp0L1IwK2ZEb0lQTGJmY3AwNVJlNHJleEQvZ3MyaUQ3eGNWOXEvZGFRR3dh?=
 =?utf-8?B?MVJGdWV2RUdsZXEwSC9wWGdoNUd4VWNQUFJIQ1lYRHNURGFackhUekROV2lu?=
 =?utf-8?B?N0hzOGNkaE4zeGVZb25wNFBxNjAvNHRmSnVCNEZIVnNva0NNQzF2dHRKZUha?=
 =?utf-8?B?Nnk4ZkRYN0pvZUI4NHBDNzFEUDBKN3YvTERWQ3JvNHdacGJTS240UzFza2Nq?=
 =?utf-8?B?ejE5SGg3by9ZaVVOUXBCR1A0ekZ3bjlSVHNvT255YWxmczh5VUNZUHVtSk1w?=
 =?utf-8?B?dE1halA4SjF5Q2FraEpleElhSzB3QkRDV2RQVUF2V3FLblhwVml4aExzTXB3?=
 =?utf-8?B?SE9Fc01iZ1FBRjZNUTU0V2I2UUVXZE13ZmhjbWplQkNHNXBMZWNmY0kyMWxE?=
 =?utf-8?B?QlJ6NEI3VDNZYXBuTjlkdE9BaXJjbTZLUEVlZ0t3MDM5VEZ0VWJvYldVMHB2?=
 =?utf-8?B?SWc0blFuaTZhMDJnNzBianBjdUZKWUpvV1VJNDNiaTJhSFdxL2tKdUl4Tk5V?=
 =?utf-8?B?RVhWUytJNmh4Q2lBbTQydVVwZDl5b1h2YlVGbVZpN3lqRVZsMi9yc05FY2U3?=
 =?utf-8?B?dkJzMTVMZ2h4QzcxSHRlNm1ya3MzSC9ycTh0RWJsNkJnTkFBU1lXaTBsQ0ZF?=
 =?utf-8?B?MktRQWpEc2NsRU9FYnFNK1RkVzlaRGphSm93NXZodFNveW51ZUhHaHlxWklI?=
 =?utf-8?B?V1J1cEVHVmdNU3c1MkYybkliVmxOSk1zQ0RwUFJkN2xMRWFiZDQ5bnlObVAy?=
 =?utf-8?B?R3FGM1prK0J0OTBCclhtbnZoaGtQbmF5bDV0eGNGYjVKcXVBaHp3cHpYeGdo?=
 =?utf-8?B?M0tTMnhRTkxZcnpoU0t3TXZySDd4L25vVmlHNVN6SEtWRFpUTnRRcEJtYWJM?=
 =?utf-8?B?K1JONzAvdzltMjJsbjJ6QkVpU2lRYit5K0ZwNVdqd01yNFFBMmU0TXU3QWN4?=
 =?utf-8?B?VHVVVlByNmxqVTVldTZIV2poQ2ZSWFN6eGh6cHN3eDNUZU13bEgzK0w1Ujkr?=
 =?utf-8?B?QmlvNnkrbzEzek5wWVlDYkFlSks5K2k0WWpXeU52a2VqZEduRDhoT3BWVWls?=
 =?utf-8?B?bHNDZ1N6eksrRHZCQXdjNkJ1cEVsZnhGdjVMWWs2TWxsZVR4K2tycWRjVkVp?=
 =?utf-8?B?UUxlNkpPN1p5aXFHOTRWSFQxQ1ZKMk1ZMXlmWVA4Z2g4TU96VUVyNktEZ3dn?=
 =?utf-8?B?MU9rSjBDWllTL0dsbVg3ZmpWZndlREY3ODlpVlN2Y0JTVnBubXdRVityOFdM?=
 =?utf-8?B?d1BmMGcyY1UwMHVjUHMyZkFDQStXZzl1anhQMXQ2YTVUbENNeHd4VjZrV1Q3?=
 =?utf-8?B?K1JvNjkzK2pTaWUweGtYaksrb21QMllBdEZGTktMU2NUSEF2U0NpYjZxaVJV?=
 =?utf-8?B?RU1qSU5VbWFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWI4Ty9xbEtKL3VNZVYrNlQ5UUhGRjZ2NFF0d2lvWExobGpKNC9yZFNIZGpY?=
 =?utf-8?B?YTVWeTRrdlVkZEd5N3ZHN1lXRkVRdVowZG12dmt3a01NcFZtdDRMQ0Q0WkhG?=
 =?utf-8?B?a2ZwRjZiM1RBWTdmZXRZWHFpUHd6a3R6dmhuZEhWRmo5bTltWjRqdFA3REFy?=
 =?utf-8?B?NkExZDAycHpmUVlWc0hodjJvRGlaZlRvVzJDdHdGeURkN1hRaDJnUGlIelJi?=
 =?utf-8?B?bEpibzI2TjhRVlFlQWM4QmJtelZsUlFCUHkrUW1iU0JEN21ucWtQTk1DUU9z?=
 =?utf-8?B?OUNPLzV5MlUrV1gzdGs0VVF5M3k2Z3pqQVUzZUlOcW5OdlVtajQ2Z1lFVVJz?=
 =?utf-8?B?NGpMSW9MZ2FrSnlKWGYwdjY0OS9EcVJqdmwvUFZlanRGV3BnaUsxMFhUcVYw?=
 =?utf-8?B?dVRSQmlJVldLTnY0MUR0VTlJT1VLeFRHcDJTdmpuS2pFSmNwb2FQcGwzV3BW?=
 =?utf-8?B?bkplQ2lrbUxjQU1TcWJFZ2FTR2JuV0E1TkxCM25NVnRpSDhJZzNua2ZiSFR4?=
 =?utf-8?B?eEd0Y2dnbTd4Z0laN1dPZ09XTEdLdTI0NHZWQzdtYWxSZkxXR1VONklHdk1K?=
 =?utf-8?B?Qnd5Wkx3RDFCblo2WmJPNE1yNXdua2JBK3c1SndEUmF4NGpCODUySmgvZ214?=
 =?utf-8?B?Vm0yR09RTmxaelQyMmx2SVVETG1CdTF3RWpYcG1BZm5xR3NqNzVqN29BYjFO?=
 =?utf-8?B?cXBGZkdnR0VsZ012aXZVVkJ2M1hpTGZyYVFxWVlBR1FnWGoxSGlkTVF0ZE1m?=
 =?utf-8?B?WG5CZVBoNHZuVDdFNjlnVWs1T3lKUGwwbEdMZGdhSXlGdm5nZHhyWUNkc2N5?=
 =?utf-8?B?RTViV2hVc1lSOFZobUpnNThxQm5BNmRyRjUxV3dwVTZkd0k0ckhuYmZCc1dP?=
 =?utf-8?B?ZGZ0c3h5UW5ya0RJSzk3YXB2SzhxbDg1Slo4ZHRmZXRrd1BQb0xKMTMwL2dM?=
 =?utf-8?B?TWpwMjdMWEtLTGV2cUdMV2dNTnRveXVwVHFZRmtvOENRZndVQlpWcm1nWWVr?=
 =?utf-8?B?RTAyQlpTUmhzbk1KT2hFTEliUi9YeUJsOHlUcXcyeXltQ0dLY0Qrb09LMTMr?=
 =?utf-8?B?ZWlnM1BYT1JlRFpyLzhwYVRPNThzcmd2Rlpxa0U4YXVJcmJZaGVQMWlkK1dZ?=
 =?utf-8?B?eGVRM0lacmNsaGN1SDRBak1OeVBZMGg4VXF2VXNBZG5UVWNlRmN6bk15eGY2?=
 =?utf-8?B?SC9Vd2s4VmpRRnI5c2F6VjkrRmoxaVIrUVIvRnhydytzSHVSbDJ5dEtXVnUw?=
 =?utf-8?B?OW1MMGtpNE5uWVdwSit0YmRFeXdMZi91M2JSVVZjMVVxZXJzNlk5a0dwNkRm?=
 =?utf-8?B?Y003ZmVIbEJNTC8yMVZIeU9FQXEzUUd1a1dXQWtpRm1GeVVVZXViSlU5WWha?=
 =?utf-8?B?ZHZYUXFNb2xxcDF5T0tlTHFKdGRXazI0RGYxYlRCdS9GNGM3MFYvb1pLZGVG?=
 =?utf-8?B?OXVoRlczZG5kN01ocVVhazgyQ0hUWFJ4S09FUUdxdWp2dTRVZmZRdWx5VUha?=
 =?utf-8?B?bFZMWXRZNXp1WHlZOWUwMzBhdVI5K0tmOEVLazEyb3JMWDlLb0dEMi9Na0I5?=
 =?utf-8?B?RUZNSDRDaGVxK0hZK2p3eTdrWCtOQllCNFJpK204b2htVHU1L1U0aWlKekpw?=
 =?utf-8?B?T0hLUWs1eGNhN2RZY0hSOW8reElJRFlMSTJ0NXVzWjBJeUVMWVN3aUYwTk1I?=
 =?utf-8?B?ZzBMZXF3ZUovMUhJVmprWUVVdTJySTBOUDRRUWhpdjBqenJ1VGo4QmgzV0ky?=
 =?utf-8?B?Z01pbGRBLzl4NUJhYlh4N2JBUjBhTVV0WDRQQWdudlVKR1U3OWxpSHkzQUNa?=
 =?utf-8?B?WWhSS1A2OEw0bXRnY1FrdlgzcTJNT0N2NFNKWGo5Ly9xNUJpYlFqQWRxbFVD?=
 =?utf-8?B?VjRoZDE5bjI3dUZCZ0R2V3hOcEk0VDkvNHJ6R2RRaVNsVEcyMWxtOEZRNnhl?=
 =?utf-8?B?ZU5vZXVCazB2V1ZHeGJSaGVYcEh5ZlRKZ0oyYVpZMkRPNjVuTmRhY21sSXMz?=
 =?utf-8?B?UjJaWXpXNHgrcWxFYUFhTnBWYldoRjhkVnl6T2VZUnhESTBRSzNGdmtMWDhm?=
 =?utf-8?B?VW45QnNTRlZnRVdSQ1hxTXhXenZENnlpOG1ZYmdQbUNFTTQ1SWlXbmxoVGRS?=
 =?utf-8?Q?IXJ1EaHwS0yBOQ/Y2azy2wU9O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f06481-3ed9-45f6-0f73-08dd630c4082
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:24:03.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSHF9EsgdLWJqmIKLP7fhpjQQdSvQ/3y2BKIqQTr3HGBYo8gmmO5c5rW9zMMjQTjcb1r0sWwFJptoM1y+JAjtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9730

Add binding doc and driver.

DTS part wait for
https://lore.kernel.org/imx/Z04W5chGq5TitB9f@lizhi-Precision-Tower-5810/

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
- Rebase to regulator/for-next, upstream version remove LDO5 support.
- Link to v4: https://lore.kernel.org/r/20241216-pf9453-v4-0-a9fc8f0a0098@nxp.com

Changes in v4:
- Add Krzy's review tag
- fix GENMASK(7,4) problem
- Link to v3: https://lore.kernel.org/r/20241213-pf9453-v3-0-5587c1693155@nxp.com

Changes in v3:

binding part
- Change to LDO-SNVS from LDO_SNVS

driver part
- remove pf9453.h
- remove double space
- use low case hex value
- remove , after terminate
- use GEMASK
- change to LDO-SNVS
- Link to v2: https://lore.kernel.org/r/20241212-pf9453-v2-0-f59d2c096356@nxp.com

Changes in v2:
- Reuse nxp,pca9450-regulator.yaml. Add nxp,pf9453 in nxp,pca9450-regulator.yaml
instead of create new one.
- Link to v1: https://lore.kernel.org/r/20241206-pf9453-v1-0-1e4685114271@nxp.com

---
Frank Li (1):
      regulator: dt-bindings: pca9450: Add nxp,pf9453 compatible string

Joy Zou (1):
      regulator: pf9453: add PMIC PF9453 support

 .../bindings/regulator/nxp,pca9450-regulator.yaml  |  24 +-
 drivers/regulator/Kconfig                          |   7 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pf9453-regulator.c               | 879 +++++++++++++++++++++
 4 files changed, 910 insertions(+), 1 deletion(-)
---
base-commit: 50a9890fc545421f82a6ac894af4dfd1fbbbf7a5
change-id: 20241205-pf9453-90e8dbda562a

Best regards,
---
Frank Li <Frank.Li@nxp.com>


