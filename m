Return-Path: <linux-kernel+bounces-435606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1B99E7A0E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3011887F0F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666401C54AB;
	Fri,  6 Dec 2024 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LnDmw7jQ"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39620458E;
	Fri,  6 Dec 2024 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517194; cv=fail; b=nL3FknecqavnA1GTLw5wtwYATCHVFiHpOYqWo9BnONnpVuX94DL3BQRvlthK+BvpHmOxftrQ8HUyQ+gTXD4SZcB53fs/bDNa736LaYUYlf4H/cGM1ZZbkM7quk5FJ+Yue3NhKysi8UEkbq5BIb0oi685g282Wl4R7s2oMhC6z5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517194; c=relaxed/simple;
	bh=kyLVKsODsOh8bmZpGdapyrX6y/DtJ0+kuJytfVaVGV0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IyeAilGhWDnXUmVG9+chAbBXmBUf1w81ob6Oe5oCpwNrSBbfbyv8iP2GIXznyFdOVfyu3QNKzeVwClN4p2e1UBlnCSb/aG91hGtemP1RjxtXwuMDQLrdOdIVqVTO0zICrrMpaCY6KtGmlm9HmXdRjwiq0jyNUs0/wd8hZ5caZRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LnDmw7jQ; arc=fail smtp.client-ip=40.107.249.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqLhL6mzpMq63laGKoM+0AJ4fX7z2ypMQ/3Jx0+4YEIOe5v5ORZ7hR+3EQHXNXikKGx3JjDjRvVCJ21nwpraEx2MDLxBuqvydHW1Kj6z5L/rbCwlOs+cSvD4MyBjN43w2zDCXOzkLBLC68IfgGfAu867Bc/K+Usyg1Ad7qQiwlO1p/08D/5wiuCz4MPeX/Kuqlxns0oKkmZVUmUkPx7fet8Adg/8VTQKS3/YSFaei/zJPPRQc1tFKvouH5VnTowq8auJJMzX2cQJbWjupbC7HU34GlMsU5G35vNBNiHPtN6eE4s2/09/xdYZR31CvxfZd7t95fdxHRKGDFGTzkA/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chJSHRMdbBt4Xne4EPecQedtDQowzIIQ2Oq1FcDOqxc=;
 b=uuAqC4GiQZjkssYXhOp1Pm/iEQCgEwRbxHqJOMIHAik+FNtU2IrNOsy4VGfg7NFbBfLeC96fnCiF4aC9TpLmFEi8YvW4oWHcUxduFNynX/jFH7HB5SF0YHQovH+mm5TRwDNh0Rgtcf+ptaVhv8kKeceVA5FuBMUHwS3Ohvf3pH1/5POuuTntDWQDh3Yd5yjswHWbEhTBnsYeiOM4apQnxka5YTdI8L4DfwvmbW91JV4Esd3giCtPsMkDC9FxN0E9XVxdz58DMIn4oz2E2gyBzYtoAfxD5ljB32zjgCOpUXsSOASNdT8i0dwyHdf9O/2I7m+1dhbLteeu11ruuOdYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chJSHRMdbBt4Xne4EPecQedtDQowzIIQ2Oq1FcDOqxc=;
 b=LnDmw7jQl47SXgj5maG4W95NUExmGcbZCg1wYElUwM4cW7gpK6iHwwdaPhuvwFhsME8flpLMu1gUGGmgJkyU2VZJmgJ9nbJLZ5R/AH9w2qEffvtvxRFV7SkgIpAZ8R/4ShfVt0EJQ9dEyatlcBpLvo9mIuF0pFqZkGPWlaiGyBtFnbynjL9rg/VTN2wa+cwN/J91wrie1GAitDfZPC//LwDf5NcOoMID2DYi4OZE9VCJI8VSnjsa5D3SuPGZ7HFJTdSTl0uoIyII/2i+cju4/CcQzLUIJgNuyAdPRMkafkM7iwOpl6r4FONmka0cVgMOe7faghA1uJYLMABNWJ4bSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10297.eurprd04.prod.outlook.com (2603:10a6:800:236::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 20:33:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 20:33:07 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 06 Dec 2024 15:32:41 -0500
Subject: [PATCH 2/2] regulator: pf9453: add PMIC PF9453 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pf9453-v1-2-1e4685114271@nxp.com>
References: <20241206-pf9453-v1-0-1e4685114271@nxp.com>
In-Reply-To: <20241206-pf9453-v1-0-1e4685114271@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733517178; l=28243;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=2i2JGPmdW6Zd1hfRD0XfBCHYvbW5Dc3oK2kCjT2QJVg=;
 b=IvubVzJHX/1qcFStzEQNkatUvPjpSW06x+dcah7bNGJqzEcP9WjrMtBGVPLGwXH8J3mc5yTyJ
 7fOIVT3qwtWDbh3vBsOoRTayxcZnat6Wz5H5aH50p0pwoyfj6VTNwEs
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10297:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd002af-e3c6-49cd-b7f3-08dd1635310b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkZPM3VQMU1ma1pjd0lGUThidkNyalFvamNxUFNyakxSc1RObVA1ek45c1VM?=
 =?utf-8?B?WURLTGJmNUdwbjNLWnlvYXdMOVhvaXlCWVhIbk95d3FEd3V3dHlMZXBnZ21Q?=
 =?utf-8?B?bzBmTzZlL2lqRGNOVXZhY0ErYkMxckl1MmpZS3JETjRlL2dpeWJmZEh0L00z?=
 =?utf-8?B?ZW1UM3E1RE5VcElKQVl6aWxaWW1mYk94UE1BV1ZIeHJiWjhyV3F4U3FUblN6?=
 =?utf-8?B?cjFLSnpINGRKaDJUdVdybHV6TE9jMi92Q3RJdWV5Z2E3V0VGYXV1RVJFZzNM?=
 =?utf-8?B?ZUhLUGVCa1JVZHI1VXo0TTNsVXkrYzVYSjhBczJxZ29ERlQwb1Bua0ZPN0xn?=
 =?utf-8?B?alhKeFpOYjdPNm8zeGZUVjJOR3B0eG82YXpiN2dkTkxOWkVPQ29KQndhVnR2?=
 =?utf-8?B?anY2Q0hjZmlsOU5zMmNCd3RKZHAvMVdjQXZlaWFka3I4NjJ0UHA2OGp6a2lU?=
 =?utf-8?B?LzJFaWtBVTN1Q0JXeWUyNkZyV2FrdldMZXkwYzdjZnRiKzY1T1hRZzFyVU04?=
 =?utf-8?B?aER3QUlrU2FFSzI5Qmc2c2NwRlZTcDhsbmZOSjYrd1hxaE9ubk95S1NPdHNk?=
 =?utf-8?B?MENoaXZ2SXBSVXVVd0tuY1ZNZ1lrbjNYUng1alFHV1NLVzdrU01EUzIraDVR?=
 =?utf-8?B?N0lGbE5Hc0pDUUVCYWxSZ0xvQnM0SUxNWG9FdkYrTmNhTkJLTEQzdVA3ZVhm?=
 =?utf-8?B?Myt2WmgwajVSemVRVkZyMVQrR0MwZGxreFZVWk12RmtlU2VCbmhUejB6VGZI?=
 =?utf-8?B?M0M0bEZNZWZQeVUxb0Fxck84cFVPdGVpNTVWSVR6VXViNTE5ZTB5QmVYWlJL?=
 =?utf-8?B?bEZITUtRNmpVVXo1aHZ3cHlzNW1wcG1yWkxVcFJ1WVpZUHZoUjg3cmg2YS9V?=
 =?utf-8?B?MnNWdHNUVnFhTUR0aU5vaGpwV2s5M3d4YTRqN013d1FWQnpaZ0ZubTIzK2pq?=
 =?utf-8?B?aFlnT0VBSXQwQUJ2bzdBNUJ4eHRiZnI2VHJ6VG9tbmFicjk1UXlvS2dDQmgy?=
 =?utf-8?B?RVVKSjM0K0F4QTU2YTFxWGdlQVUyWEpaakxraEpRMm43WmhOL0xHSUl6QzJD?=
 =?utf-8?B?VEMzVjBmbDRMN29VN2NaWU50K2QrQXFNcFV3bURuOXhjSG5WNSsxYnpROWth?=
 =?utf-8?B?VjJhNU9zUlNBd2FDeFVaQUc0Y2VLc0pYL2g1enVpRVlrYndNVFJFbG5xajdr?=
 =?utf-8?B?QVNZN2psdDIwM2hKWHQzUExNVkpnVkxjdXhBcTNnNFdGMUJ4SDJSMzBYMkRa?=
 =?utf-8?B?L1M5SFNmWHdOQUNFVnRJWmhjK2pPeG5QeTFYMDd0S1hyd0s1elpZNlpEVXB5?=
 =?utf-8?B?YU53U0JZbzhWOXpCSURGdzdkWW9qb001US9WYzhNMnRqNnM4YitYK1RDR3Qv?=
 =?utf-8?B?UXNqdW9OcTY2c2p0c3JLZmgzMUpSaXpvQ2tCN2VVdDNFd0dhWHRFa2FoYXEv?=
 =?utf-8?B?L1B4eEZ6TXNyaG9uQlFaU3RiQ2hvOC8za3ZKZXplbkhNNktKQVhyMkpnUnds?=
 =?utf-8?B?ajFSbHU1alE5aGoyT0xwS1lnUlNHWmRrYjYvWEp6ekFkbEpoVlVtTDk5bUdT?=
 =?utf-8?B?My8zS2lPTUdWaGJvRko3TzZsMWUyMWw4eXBDd2N0S2tjdkhwVjlSeUtHWStV?=
 =?utf-8?B?eEpaK25aVE10Z05jV0JYazI3R0lUTnZnQzlLeCtEb2c4QzBPMlJTTVdJUmNV?=
 =?utf-8?B?SHhuYk1JbnpCak1ZbFJvUHlmTUt0N2pVZXVnMlFtdUdoWU1DNUl1cFdFM29C?=
 =?utf-8?B?RHR1ckpjRmN5R3FMdTFHV2U1aC91MUJ0dE1wSXlPZUFhdGdrdVhSL2szbnM3?=
 =?utf-8?B?UFpoSWR5SW5TaWdsVEsrVTVHT0NvSDJ2T2lJTEcwWFdqZDA5K0hmTHlRTFA0?=
 =?utf-8?B?ejlDc0Y4UytmUmRKeGV5VDlUMXNOYXlWaXJBU2xsTGRhWkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE14SW5CbHF6aUU0UjZEekNWdHBhcjIyZVZqeFBOTU1ScGJ5ZXUxT0NVVWx0?=
 =?utf-8?B?TXl5UXdZZDBnRkZSdmdRTG5pMVBJMDI1RUh4Y1NvR2c2RlZ3c3RPeG5USFlx?=
 =?utf-8?B?dEZybFBSQWJKcHljY1FpUVZUYXhmSHc1b0ZwTENaZHF1UXRwaUQ0ZE1TTk0r?=
 =?utf-8?B?bEY0aHFSWUhkUHYzbk5wSlRNeWJJdWNpYkJBMEZQSGNISWV2VWRNaytIZnF1?=
 =?utf-8?B?MldhMFNydEw2UEFUeWJNSzZhOUlpWFROelNuNVJMRmUrdWdnZGpyN21VL01U?=
 =?utf-8?B?R2hONHRsZFAvejdHcDk3OEN4aWpLU1FVMkZyTXRnYmgyTEU4bHcvUnlEUThn?=
 =?utf-8?B?VytpdlpkSXpxQ04wR29rbGQ1RlNmMHU1b0x0MTQ0M3BUMjdORUM3SEtrWURQ?=
 =?utf-8?B?cFQ0R3lDZHN5b0NodVRzNThyMVExVXBnTkxISlVPQVBXTXdRQUF6YzlveHNu?=
 =?utf-8?B?ZVZpVXM2ZEhPOVFKK3RNRmNQb0NUSEIrT1daQmJvSnpFR3RlaUZucHE3cnFG?=
 =?utf-8?B?Rkw0OFpJR3hITUF6RHdGWmJDVHJPRTVIem5PNDQxK2c1M3BNS0orSTZsRmZt?=
 =?utf-8?B?Q1FzMkI1TkRlZWd2Q3Nxa0RXUm82TWdnYlJqSCtBN09xMHVCK08remRBNjNU?=
 =?utf-8?B?K284TmtPZTcvNnJNb0N2dnFGM1BIWmRDWFZDSU5PNmc4RFYzOWQwbzhxM2ZI?=
 =?utf-8?B?Ym00c0U5bnhrcTMyb1BzdTgzNHY2REltTmFLdDNTTVU0Y3dNYkwrWEgxOWZi?=
 =?utf-8?B?ZGdNaTJqTG5MOXloejN5UjNZWnRDcm1JUHkrODJtRzkxUlJJTnYwUWREdDNH?=
 =?utf-8?B?UmVRbkVXdHg3VU9OODZ6MVBycEQvWHp6Z1VXbnp5NFN1emFld2NmZi9nSEhB?=
 =?utf-8?B?aGlhamVvMXk3a2NTeStrcnVmc2l2TVliMHVkcTVoNzROL0Z0T2xTYklidE00?=
 =?utf-8?B?MVlOTVhFOCszaXQxWDR3QnNZWVE1SzBrcXAxcEsya3pEWlFxclRja1g1Z2o1?=
 =?utf-8?B?NVYxbE1LSHg1ak1VT0N0UGRoNU1LUFRPTW43WERVSWY2T245bGV6TnFTNm9x?=
 =?utf-8?B?dzlmUnN2UWJ2dm9KRzBHZUJLc2FSZ3pteGpkeDhNaW1KQ3NpbnRORFdGRDZ6?=
 =?utf-8?B?R0NTbStFVlc0Q0x0NXJYbGRjWG90MWw5Ny9LZU11V0t2RDJSV3NaV1VJUGtZ?=
 =?utf-8?B?cDRiMVcyRC9iMk13SHY0RDVmUU5DeGVkZ3lIcGcra2xvRXFUemcvV0pWdHJ6?=
 =?utf-8?B?VTJ5RXpPelJDUjV1OEFTT3ZlTkRwOUlMdXFrUnJRTy9ISzBHaHVJa3BzbktG?=
 =?utf-8?B?RUhvMmxtY3hhbFppNkZ2RW9pQkNGL05mM3g4eVJlaldCaDdCeDFMc3NsWmlG?=
 =?utf-8?B?K0M4R0VsSTVIQmZQaExEVVBqQmJ4NHZsbFdZVTFyUjJibVpzdDFrbmhtaW1o?=
 =?utf-8?B?UHRhVVJSakp3MVdxQ3hUeGJoTWI3eGd1bjJDaEd1MlAvY3hPWVorRDFsMUs0?=
 =?utf-8?B?elFGSkVJakhBUVNwZUl2YkZDK0ZLbkVoRVFiUDlmVkk1cjE3WXBoTElwdmNI?=
 =?utf-8?B?Qmw4NXNEWC96RHBPaitZek9iaG84OEg4MVRlb0I4b2JTdmpPL1BEL0gwb0dL?=
 =?utf-8?B?MG03NW9OMXRqRlFEZHFmSGpwMFQrdGxnOG0wa2xVelZxbllvN1BtY21lUThZ?=
 =?utf-8?B?QWFGanNGdGhpMlRneFh6d0pBN3hpRFNyOEprTm4yYzNPYmZnM1FjK2MyVW9N?=
 =?utf-8?B?YmlEbFB2Z1BaMFdxb0pUc3RPaDlRR3NWNmV2Nzk4TDM5M1lGNnlzUkJOMW5v?=
 =?utf-8?B?a2gzbTROSFkwanJRM0pjeUwzTGtRY1pJVDJtenViY3hUWnEzRE4wakRvS3k4?=
 =?utf-8?B?MW11Q1Y4Vm9KWVNacUtvaEtJd1VmVFlMaVR4ejcyWGJhayt4NjJ2ckEwS1RH?=
 =?utf-8?B?aDRuUTBtUnNNemlmN3BhTGY1aEtETE5pUzJ0ampvejlTQ0t1RG8wTjhSeDJQ?=
 =?utf-8?B?WjZWWW5GUUNGZmE1M3g4bzRmbXJMbFVjbk0xV0Z3bElyZExLTHdkc3ZDSFBG?=
 =?utf-8?B?OVBhRHlVRjhJai93YmxaVjcvb3BSZERRREs5UkRzQ0tvOElqZys2dEtYVHY2?=
 =?utf-8?Q?OyFkAfZIWs8jl8AyLTDxPCmIX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd002af-e3c6-49cd-b7f3-08dd1635310b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 20:33:06.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CT+U6xcQX2AivjtLrtUMURti2Gdlmkl+OvzM3ppvsgPH0evN49Y2r2pJD8wL5pusU+1iu1ZGlQG3iZy8uhqbVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10297

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
 drivers/regulator/Kconfig            |   7 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/pf9453-regulator.c | 723 +++++++++++++++++++++++++++++++++++
 drivers/regulator/pf9453.h           | 171 +++++++++
 4 files changed, 902 insertions(+)

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
index 0000000000000..6a4dac119b6f4
--- /dev/null
+++ b/drivers/regulator/pf9453-regulator.c
@@ -0,0 +1,723 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP.
+ * NXP PF9453 pmic driver
+ */
+
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+#include "pf9453.h"
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
+	if (mask != 0xFFU) {
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
+	unsigned int val;
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
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
+	unsigned int val;
+
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
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
+	ret = pf9453_pmic_write(pf9453, rdev->desc->vsel_reg,
+				rdev->desc->vsel_mask, sel);
+	if (ret)
+		return ret;
+
+	if (rdev->desc->apply_bit)
+		ret = pf9453_pmic_write(pf9453, rdev->desc->apply_reg,
+					rdev->desc->apply_bit,
+					rdev->desc->apply_bit);
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
+	int ret;
+	unsigned int sel;
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
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
+	const struct pf9453_dvs_config *dvs = &data->dvs;
+	struct pf9453 *pf9453 = dev_get_drvdata(cfg->dev);
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
+			.of_match = of_match_ptr("LDO_SNVS"),
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
+		dev_err(pf9453->dev,
+			"Failed to read INT1(%d)\n", ret);
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
+		return dev_err_probe(&i2c->dev, ret,  "Read device id error\n");
+
+	/* Check your board and dts for match the right pmic */
+	if ((device_id >> 4) != 0xB)
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
+	ret = devm_request_threaded_irq(pf9453->dev, pf9453->irq, NULL,
+					pf9453_irq_handler,
+					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
+					"pf9453-irq", pf9453);
+	if (ret)
+		return dev_err_probe(pf9453->dev, ret, "Failed to request IRQ: %d\n", pf9453->irq);
+
+	/* Unmask all interrupt except PWRON/WDOG/RSVD */
+	ret = pf9453_pmic_write(pf9453, PF9453_REG_INT1_MSK,
+				IRQ_ONKEY | IRQ_RESETKEY | IRQ_RSTB | IRQ_VR_FLT1
+				| IRQ_LOWVSYS | IRQ_THERM_100 | IRQ_THERM_80,
+				IRQ_RSVD);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret,  "Unmask irq error\n");
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
diff --git a/drivers/regulator/pf9453.h b/drivers/regulator/pf9453.h
new file mode 100644
index 0000000000000..14d6343d42658
--- /dev/null
+++ b/drivers/regulator/pf9453.h
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright 2024 NXP. */
+
+#ifndef __LINUX_REG_PF9453_H__
+#define __LINUX_REG_PF9453_H__
+
+#include <linux/regmap.h>
+
+enum {
+	PF9453_BUCK1 = 0,
+	PF9453_BUCK2,
+	PF9453_BUCK3,
+	PF9453_BUCK4,
+	PF9453_LDO1,
+	PF9453_LDO2,
+	PF9453_LDOSNVS,
+	PF9453_REGULATOR_CNT,
+};
+
+enum {
+	PF9453_DVS_LEVEL_RUN = 0,
+	PF9453_DVS_LEVEL_STANDBY,
+	PF9453_DVS_LEVEL_DPSTANDBY,
+	PF9453_DVS_LEVEL_MAX,
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
+	PF9453_REG_DEV_ID              = 0x00,
+	PF9453_REG_OTP_VER             = 0x01,
+	PF9453_REG_INT1                = 0x02,
+	PF9453_REG_INT1_MSK            = 0x03,
+	PF9453_REG_INT1_STATUS         = 0x04,
+	PF9453_REG_VRFLT1_INT          = 0x05,
+	PF9453_REG_VRFLT1_MASK         = 0x06,
+	PF9453_REG_PWRON_STAT          = 0x07,
+	PF9453_REG_RESET_CTRL          = 0x08,
+	PF9453_REG_SW_RST              = 0x09,
+	PF9453_REG_PWR_CTRL            = 0x0a,
+	PF9453_REG_CONFIG1             = 0x0b,
+	PF9453_REG_CONFIG2             = 0x0c,
+	PF9453_REG_32K_CONFIG          = 0x0d,
+	PF9453_REG_BUCK1CTRL           = 0x10,
+	PF9453_REG_BUCK1OUT            = 0x11,
+	PF9453_REG_BUCK2CTRL           = 0x14,
+	PF9453_REG_BUCK2OUT            = 0x15,
+	PF9453_REG_BUCK2OUT_STBY       = 0x1D,
+	PF9453_REG_BUCK2OUT_MAX_LIMIT  = 0x1F,
+	PF9453_REG_BUCK2OUT_MIN_LIMIT  = 0x20,
+	PF9453_REG_BUCK3CTRL           = 0x21,
+	PF9453_REG_BUCK3OUT            = 0x22,
+	PF9453_REG_BUCK4CTRL           = 0x2e,
+	PF9453_REG_BUCK4OUT            = 0x2f,
+	PF9453_REG_LDO1OUT_L           = 0x36,
+	PF9453_REG_LDO1CFG             = 0x37,
+	PF9453_REG_LDO1OUT_H           = 0x38,
+	PF9453_REG_LDOSNVS_CFG1        = 0x39,
+	PF9453_REG_LDOSNVS_CFG2        = 0x3a,
+	PF9453_REG_LDO2CFG             = 0x3b,
+	PF9453_REG_LDO2OUT             = 0x3c,
+	PF9453_REG_BUCK_POK            = 0x3d,
+	PF9453_REG_LSW_CTRL1           = 0x40,
+	PF9453_REG_LSW_CTRL2           = 0x41,
+	PF9453_REG_LOCK                = 0x4e,
+	PF9453_MAX_REG,
+};
+
+#define PF9453_UNLOCK_KEY               0x5c
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
+#define BUCK1_ENMODE_MASK		0x03
+
+/* PF9453_REG_BUCK2_CTRL bits */
+#define BUCK2_RAMP_MASK			0xC0
+#define BUCK2_RAMP_25MV			0x0
+#define BUCK2_RAMP_12P5MV		0x1
+#define BUCK2_RAMP_6P25MV		0x2
+#define BUCK2_RAMP_3P125MV		0x3
+#define BUCK2_LPMODE			0x30
+#define BUCK2_AD			0x08
+#define BUCK2_FPWM			0x04
+#define BUCK2_ENMODE_MASK		0x03
+
+/* PF9453_REG_BUCK3_CTRL bits */
+#define BUCK3_LPMODE			0x30
+#define BUCK3_AD			0x08
+#define BUCK3_FPWM			0x04
+#define BUCK3_ENMODE_MASK		0x03
+
+/* PF9453_REG_BUCK4_CTRL bits */
+#define BUCK4_LPMODE                    0x30
+#define BUCK4_AD			0x08
+#define BUCK4_FPWM			0x04
+#define BUCK4_ENMODE_MASK		0x03
+
+/* PF9453_REG_BUCK123_PRESET_EN bit */
+#define BUCK123_PRESET_EN		0x80
+
+/* PF9453_BUCK1OUT bits */
+#define BUCK1OUT_MASK			0x7F
+
+/* PF9453_BUCK2OUT bits */
+#define BUCK2OUT_MASK			0x7F
+#define BUCK2OUT_STBY_MASK		0x7F
+
+/* PF9453_REG_BUCK3OUT bits */
+#define BUCK3OUT_MASK			0x7F
+
+/* PF9453_REG_BUCK4OUT bits */
+#define BUCK4OUT_MASK			0x7F
+
+/* PF9453_REG_LDO1_VOLT bits */
+#define LDO1_EN_MASK			0x3
+#define LDO1OUT_MASK			0x7F
+
+/* PF9453_REG_LDO2_VOLT bits */
+#define LDO2_EN_MASK			0x3
+#define LDO2OUT_MASK			0x7F
+
+/* PF9453_REG_LDOSNVS_VOLT bits */
+#define LDOSNVS_EN_MASK			0x1
+#define LDOSNVSCFG1_MASK		0x7F
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
+#define WDOG_B_CFG_MASK			0xC0
+#define WDOG_B_CFG_NONE			0x00
+#define WDOG_B_CFG_WARM			0x40
+#define WDOG_B_CFG_COLD			0x80
+
+/* PF9453_REG_CONFIG2 bits */
+#define I2C_LT_MASK			0x03
+#define I2C_LT_FORCE_DISABLE		0x00
+#define I2C_LT_ON_STANDBY_RUN		0x01
+#define I2C_LT_ON_RUN			0x02
+#define I2C_LT_FORCE_ENABLE		0x03
+
+#endif /* __LINUX_REG_PF9453_H__ */

-- 
2.34.1


