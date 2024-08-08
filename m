Return-Path: <linux-kernel+bounces-278827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD2A94B55E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD12D2822EE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF93433C8;
	Thu,  8 Aug 2024 03:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H3GAIiI4"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013051.outbound.protection.outlook.com [52.101.67.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163D77E1;
	Thu,  8 Aug 2024 03:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723086812; cv=fail; b=gbUupmr7DS9IT59uYFtbCj3Td6CQjNPv1bB8Om5/8/jAv8ucocqejvIVULqypmGvqjy8o04HXdNOlODPCtkBGGKKev8oIj3pefob6KH34YP8TwXQ27Mf5b+X/BjYTKGP17BEnFQV8eVY+n17qwbaTcsev8ZNt8dhusSeQFdEzT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723086812; c=relaxed/simple;
	bh=JM5e56dO76+d9BBZ20thRIoqkzPNpC4pNcJFkEDdsa4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UkRY+nGNfN7zNDofhtb6pWMI+k9rFXiZpgXCxuL7//Xayg2oqSgabLbg6OgbzZt1uJStlzQQ07WTvoFqiuWTxgEtihJpMgUXbE3LmQgzvgQgR0Qq7lRWN5X+u0llbWkTfpUa6gEDg9B7hZeOJIfU6DFMPsyMc3x6RixqLF7Phw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H3GAIiI4; arc=fail smtp.client-ip=52.101.67.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bo8zNnL7bFo6CwOhFYKndogFwq9BSqMhMhRD5wfo+bEb2Af11njR/bnt+JHKnBe8oofGBWIGHsdO76JsaF4lSTmvhtAhHxpFNbJyFNHqRvGgHblnwIJrXxLIitTiWlflOx+r6Hst6jsYac13zyAmGjRUoeSyYQyioibR1yBKtPhixPPosw2wIvsQdbeq2Xo8qjgTow5oiykh+eHU4xeQloIngumzTvw4HyzAmhB3pZIVMlWJ+41vDboNAylh6aWGuMF09p4VHJ0Q1gS8YsUXXLxPJw9hfl2cDYGaupZihxy/WXWkqF+L1LLOpG1Wr86bXmgvLKP3efGdqJ4O9RnvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JM5e56dO76+d9BBZ20thRIoqkzPNpC4pNcJFkEDdsa4=;
 b=xJVlgs8VseGf39JbKPkBrRuPnjnNZnHtO89B/AkBw+p+NscviYr6lIx9k/kargZLSigfW5zub53QmHXLBaizU76bYK7viEn5YRhT6LcThFVYJXIRzT5o007R8qAPUdjohiSGZi2QQdOJtj7bi/2hbO2Q/ee5wj1cE5MCtWRy2w4Mb9WkWpm09ulWcfojiIaUkVSZaKkF7x/gwUEOhdyyVuHodwKzZktDLuNKdCnUiLy1/Nf1gPGMuUFcUl6TdrEH4/OZGhCvQQhOtsXqJ7mo9OqymEsGhvVopQQO7NhLzxf4SQzaJvXbjh22wxoVJNlxqCKNRH8oTqQ3Xbzq4PcBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JM5e56dO76+d9BBZ20thRIoqkzPNpC4pNcJFkEDdsa4=;
 b=H3GAIiI4bxp210PesZ3FjYnXvWJDl9Lncu7xe4PKuj8EM2ncAbtgUI5dP06zAhlG36qP1spDBjWJ4bey5wirOuTo1kC6BAO3pmtr2uFeu1qMfdXiK6bTGpEddREA82kxPKREydmNVMVTkgViSAvYEst5u4co/glz2cDm1jgetPsftiwM4AIuAGihASneGTDazNiPRE4hym26zJPtUcWNmUsvF1U/ruAeGe7p6tVxiX5KbUtReBVI7vHrUTaKSthreTwGXbxvxm3l95MuN9h7R7To3PQtcDkVkMSCGmIOJ2WmTMyiUZw4Rn+dC2m85NYTDMQLUvgZRQte9SQZdFD9dw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 03:13:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 8 Aug 2024
 03:13:27 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Yashwanth Varakala <Y.Varakala@phytec.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"robh@kernel.org" <robh@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"festevam@gmail.com" <festevam@gmail.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, PHYTEC Upstream <upstream@lists.phytec.de>
Subject: RE: [PATCH 3/3] arm64: dts: Add phyBOARD-Pollux dts for rpmsg
Thread-Topic: [PATCH 3/3] arm64: dts: Add phyBOARD-Pollux dts for rpmsg
Thread-Index: AQHa3nebqYEsgOX6LEC/YqoJ4w4XrLIRth1wgAn3ngCAARbRcA==
Date: Thu, 8 Aug 2024 03:13:27 +0000
Message-ID:
 <PAXPR04MB845915EED5916D7741A71B8C88B92@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240725094457.37739-1-y.varakala@phytec.de>
	 <20240725094457.37739-4-y.varakala@phytec.de>
	 <PAXPR04MB84593B109878D86B72DEB4AD88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <da0363d65457c1f1de26b9bc03117d667d6a578e.camel@phytec.de>
In-Reply-To: <da0363d65457c1f1de26b9bc03117d667d6a578e.camel@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB7727:EE_
x-ms-office365-filtering-correlation-id: 766ae6d0-80b2-4274-f100-08dcb7581239
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WEZGVTlaVzF1ZSsyY3RONGtIMUNtcG90czBOTCtDMWh0UGxSTDh4THJNQWxx?=
 =?utf-8?B?cG5TeGdSK1lYV3pOM0pRTC9KMCtHbDZzRG1QK3ZwcWIyQXhBcElRdnllZFo3?=
 =?utf-8?B?SVdyc3IweHpPQlUyOVcxdzNpL3FSY1hWOUN2OER3dFdXY0t5bVJiWjBqZHNZ?=
 =?utf-8?B?cTFMeFlFRTRRVTJFUU1HTjNZdk5GeWMxQUJ2OGdkaDl4c0JWY1lnQWF0WUtk?=
 =?utf-8?B?M09UY0dMdTRHSzVwL3JwWWFIU2JiU1lyTXhNZzNKOUZUSW5FRU92SklWQUhD?=
 =?utf-8?B?RFdsQklNYUFsY05lSG03NC9WNDdyL3R6bDVPZmlxNGpYOEJ3eTN4Y2Jha2xQ?=
 =?utf-8?B?WkI2NWlkRG81MWN2MWFoaUozR3pVd3lOaWZDaHRqUHRMcjQ2SStBVVp6eTlZ?=
 =?utf-8?B?bE1WZS84RVNQWVRlQzZUVUJvdDA3QmVTdHgwS01KZjlWSVBPWUxWWEIrN2o4?=
 =?utf-8?B?dnRoWWZhdUxWeFpTZmxodHV5MnI4dHFPNmhuaCt0OElvQUQ2SlRpcEpQTWtm?=
 =?utf-8?B?STcxc3V5NzZEWjI1dzJhNWl5bCt6emkxSEdqVFkxblpodGV2U1hhNnlpQUVm?=
 =?utf-8?B?d0pjRFAwNGZKOVlkTWF6RWxERy9Pand1Q1ZBQ09GSkZWbVVOVjBLNk1rMlBN?=
 =?utf-8?B?bVNuOEdRQU8yYVUzRnhPcU5XUm9pRmpsTXJVNjZFZDIzWUFyUVBHSDRWSDJX?=
 =?utf-8?B?RlpBWHMrLzN2VlcvcUtHMm9FbjlzaFMwYmppNlYvR21wWlVzTEswa0daK3lX?=
 =?utf-8?B?U255VmhYRzRkUmZjRHB5SlJ2alE1aE1lUnhxMFpZUDI2NnpRdFhHWUN5SXJE?=
 =?utf-8?B?dDRrbW85ZGVKdzNlNFA1bGJ3Njg1Tk1XK1BjQkZQLzZwOHk0bnNJTWZjMVcz?=
 =?utf-8?B?WCtRWmFVNTJVTUVlSkpsNGpSd3EyTSt2MWQxWGxld0tYN1BCWGVtd3BTVlRN?=
 =?utf-8?B?cUdZTGZWdGlMeVFuS2JZaFBiMldVZWR5ZXZ5ZGZrY0p3K2U3L0x4VlF0YTBT?=
 =?utf-8?B?NUN6ZEJPY0N6L0tibS9nRXRJaDZWMUxSNFVzVVNkeEhneEVzSzBXb21vOXNt?=
 =?utf-8?B?bGJRZjIybUZWSEZkd2diQzloZUpZQ2w2M0t6OFgzN3ZRQWxPQm5YTGwzN2pO?=
 =?utf-8?B?TEZ2N1RwOEZJeU1vL2lZczlCeTNQSUFxMzBKdDU5WkpzeGRMNnN2QlRSK1dR?=
 =?utf-8?B?ZXNCWUVNbEgwcXl6d0FhMERJTEpnNXh0MktsNTA0dDZoTDlra2RqaUtOQ2JZ?=
 =?utf-8?B?dG1hL2xmdUsxcjJLS1RJb0VkL1VDY0FVVXlnWlE0ZVgwT29UenlRSmpyY1Bv?=
 =?utf-8?B?bkJ3UXZuSTNZcUN4cE5zSzhrTHR6VTVoOGhwVDBiRzN6dkh3Q1JFZDVHeXdZ?=
 =?utf-8?B?aG1TY2U1MVZwU1g4aEZYWjN4YWlpQkxUQzJmRnpjeEFqdjYzK29NdnRXMXIw?=
 =?utf-8?B?d21sQzJJVGFhS0JFblJRV29sSkZReGNSWENLVnNHMzFhQm1mdC9wTEZ1QWNj?=
 =?utf-8?B?R1IxbmlxUDlRSTRCVnIwblhPRUJqQWNkbWtwdjhiQS8venN2NUxGM2ZZU2Z3?=
 =?utf-8?B?Rm5mSkRLZWtwcXp0aUhlTGd1bXI1ZzdFcGp4VExGaWgxdDJkMTBtN3NTNytp?=
 =?utf-8?B?UTJpYWhpMjlObzFLcHZ4TGVtRXR4YmdzcnJZeEgyVm5tVlRGWVJGUmdxMEMz?=
 =?utf-8?B?b0lyalp5bGRHRy92T0E3dVZaY2FDcUdSOFNlb1Q2VFpSY1R5c3VJUElSRjA0?=
 =?utf-8?B?cnVyb0h4QU5CMHMxUFNmNURYa3V3V0xtQjFtNHpmSkF1MTVhc2FuWDFkV0Nn?=
 =?utf-8?B?dFg1aC96cXNlamo0SUtKb2NmeDlIWUpLSElCbUdkWlJPSUpJN0xiMmM1OThE?=
 =?utf-8?B?NmNFR3VzanZjeVZvZVpnNCtpWGo1aW1JMi9DdDZ5QnJNcmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azZpaS9xWk5PKzZhaENBeE9lcEhwN242RE1rK0doZng4V0dMcWFYMTNQVUlx?=
 =?utf-8?B?Z0xTdytVdExab3BPV0o1T3BHR2puWHRzOXJRYjdwdEczclFEQTloREhCWDYw?=
 =?utf-8?B?alE2d2UzVlc5QUxDbWNpaHNVajAxcndoOHo5UWRpc2U4QTBOdVFEajcwblg2?=
 =?utf-8?B?aVNnU0ZKZ1AvYXAyZHVoSTlSRkdmL1V5ZUt0MDQ3aFlJeGhFVWJiYzk0M3BM?=
 =?utf-8?B?RFROTEJQdlhRSjZhNjNEUDlYaHVPUlZhS0czSnYwRTVyY3lNSnBiQ2c1SFVv?=
 =?utf-8?B?MWJhREFGTjhzNHRaTmtCR2hSa0MvTEE2dHFablI3bVNrOHdWak1yckU4QktS?=
 =?utf-8?B?L244T09mOVlkc3RYL3cxaURpRlNOYUlKdzhyNk8zZEhBVHp2Y3BrT0FvR1h4?=
 =?utf-8?B?R2R5K0JGTUNlVFhYVDlnYVBMTGd6MnRRVnc2amw0NGtvRElibmJlZm5zUSt6?=
 =?utf-8?B?aVJvUVl5dElxS3pCMDZMUlk0bXNJbGpWZFBnWHV6Y2RpTC9pTHRZc3dhMUdj?=
 =?utf-8?B?OUNMWERXTEtubWp2L1FqNVliZUhIQjA3RG53aW1RRzkvODhyby9xSE40Ymh3?=
 =?utf-8?B?N0x1RmpHWkVYcVhkaVNCaXk4NTNleXU5L2tnTW9NTzlnNjA3dXd0ZXJqSysz?=
 =?utf-8?B?UnM1SlZBYW1aamdZdm9qTFZtYVdZV1dQZjJVVXJZVHdiMG1wd1JVcHRhYUZY?=
 =?utf-8?B?ZjQveDN6VkJOVzdtTVdXZHA2dTFYVzV1STA1T2pycm9DREJEVlptSGY5Zm5k?=
 =?utf-8?B?YU5Pdm5xS0daa0VmU1ZPdDZxNmVFWEZlUFBKMk5uYnNMYkV5NTBvbUNNNnN3?=
 =?utf-8?B?dWtQN3k4alBpa05SRDVpY0ZERlBMamgzU3pUMUhvTjZudE82eWpyb2lUREdh?=
 =?utf-8?B?ekpscFA5QnFDWTdwcFNJVzFxQTMrcUhuUHZDSUgwRkg3NGpIWVdrdnRzSjZu?=
 =?utf-8?B?UU5kY1AvckhQUXdkT0p2eXVWaXZLeXdLRWN5UlJqWGl5MzhKd3FNR0NNSnF2?=
 =?utf-8?B?amtRR2RRVGI0TDh1aTBHbjhwVGhkbzF0QjVtbHJQUGhERDBCU3poTzZGWXdQ?=
 =?utf-8?B?Z1E3OVdEQUovbytWZWtOWlF5RkJoQjhSRDlPZ2NFUi9ZdEJZZ1NHNGdmQnFO?=
 =?utf-8?B?N3RHS0VqYzRSOU15cUtBaldaeVYzT3M3Wm1qRFY1Z3NBNWZaaDNiMlFHZVNW?=
 =?utf-8?B?WGJCTFY0WmY5b0phcUpkMzVmbEdqdlY2RVZucDFUbkJTNUpkNWJNNmlOMXNO?=
 =?utf-8?B?SjFRRVR5dE9VSzdSZmN1SDF0dUt1bDI3Z1dyODdxSktLTGVZWSthL2M1V0RM?=
 =?utf-8?B?TlIxMVE3V2M3cTdwZnZLUWFNMmZ5UUpPbEVGY09nYkNyRlRQY09DZE5qMlM4?=
 =?utf-8?B?aWZxd3dFL3pMRkVrTXorUTJEMDF3eE1YU2RUUjVjQWJuS2s2VEkzZ2hUaTBK?=
 =?utf-8?B?NTJqRlBUTFB3VDRveWNxd3NRVVhTa0xockl6UURyZytkUk5pbUdWY1NPOTRF?=
 =?utf-8?B?cUZrUWFKZUpYRU4wYkFvaVYrTngyZm55MVNMWHVBdDREQzdqejgxSm8wa3Uv?=
 =?utf-8?B?NVc0VVhjNHNyQTJrdS84Q2k2aDNqTU02Syt6Y0doak5XNDh3aXp1eFNhanly?=
 =?utf-8?B?U1RjMGcrN0xHYVRkQjZ1WDRRYUd6dGN6Zm9EbUxVUmFaQTRZcG1sYVo1d2hL?=
 =?utf-8?B?bGtrVW9ZT2pQOFdBbXVtbHQ1eGEvQXNKdkVsVGdXUktITkhTUlNZcjZyamF3?=
 =?utf-8?B?bm1kWVZJSWRSYk5pdVVaM2pnR1lVWlYwUjZJSkxLYXRFbnZtcEw2RllhaFZM?=
 =?utf-8?B?L285TU16RDZGMFpjbEx6YjJycXlFZVQwU0J4VVFvc0krQ2hCWWJ4ZlJ2SXBh?=
 =?utf-8?B?Mm1vTlN3cjJMbmk5U3FXeFJtRHJnVlllMHV0SHJ0Y3ByZGV6SkU4TktiSTBB?=
 =?utf-8?B?V2tqcXI1TUEvWnJhTyt2WlZ3WUdvVjc1WUI0bEkvcG5VUW16Um1jVUNxaGNK?=
 =?utf-8?B?ZmJmeTFyTkNJY1R6Q2R5SmFGUHFXZjVJQ1JDNStSdGRjaXVTYmxvenR0cjdU?=
 =?utf-8?B?YUw0MkdCbDQ4SlJ5R09YYnpvOGxobE9LbjhiMm1sQTVmN2JqUXUyUS95eHJj?=
 =?utf-8?Q?LLyA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766ae6d0-80b2-4274-f100-08dcb7581239
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 03:13:27.0319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h1Kn8Kr857KT4bzx1Jtw9jhrA9R/h4TUQ67FN23RBOcAqiu2tQey4alKt1b/kx+2ZRx7/H+w/CsOfPFV71DYrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gYXJtNjQ6IGR0czogQWRkIHBoeUJPQVJELVBvbGx1
eCBkdHMgZm9yDQo+IHJwbXNnDQo+IA0KPiBIZWxsbyBQZW5nLA0KPiANCj4gT24gVGh1LCAyMDI0
LTA4LTAxIGF0IDAyOjI3ICswMDAwLCBQZW5nIEZhbiB3cm90ZToNCj4gPiA+IFN1YmplY3Q6IFtQ
QVRDSCAzLzNdIGFybTY0OiBkdHM6IEFkZCBwaHlCT0FSRC1Qb2xsdXggZHRzIGZvcg0KPiBycG1z
Zw0KPiA+ID4NCj4gPiA+IEFkZHMgYSBkZXZpY2V0cmVlIGNvbnRhaW5pbmcgcmVzZXJ2ZWQgbWVt
b3J5IHJlZ2lvbnMgdXNlZCBmb3INCj4gPiA+IGludGVyY29yZSBjb21tdW5pY2F0aW9uIGJldHdl
ZW4gQTUzIGFuZCBNNyBjb3Jlcy4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZYXNod2Fu
dGggVmFyYWthbGEgPHkudmFyYWthbGFAcGh5dGVjLmRlPg0KPiA+ID4gLS0tDQo+ID4gPiDCoGFy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlwqDCoMKgwqDCoMKgwqAgfMKgIDIg
Kw0KPiA+ID4gwqAuLi4vZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Y29yZS1ycG1zZy5kdHNvwqDC
oCB8IDU3DQo+ID4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gPiDCoDIgZmlsZXMgY2hhbmdl
ZCwgNTkgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLQ0KPiA+ID4gcGh5Y29yZS1ycG1zZy5kdHNvDQo+
ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01h
a2VmaWxlDQo+ID4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlDQo+
ID4gPiBpbmRleCBkZWRlYTRiNWMzMTkuLjgwY2M4N2Q1MDMwMSAxMDA2NDQNCj4gPiA+IC0tLSBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlDQo+ID4gPiArKysgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZQ0KPiA+ID4gQEAgLTE3Nyw5ICsxNzcs
MTEgQEAgZHRiLSQoQ09ORklHX0FSQ0hfTVhDKSArPSBpbXg4bXAtDQo+ID4gPiBwaHlib2FyZC1w
b2xsdXgtcmRrLmR0YsKgIGlteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLW5vLWV0aC1kdGJzDQo+
ICs9DQo+ID4gPiBpbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdGIgaW14OG1wLXBoeWNvcmUt
bm8tZXRoLmR0Ym8NCj4gPiA+IGlteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLW5vLXJ0Yy1kdGJz
ICs9IGlteDhtcC1waHlib2FyZC0NCj4gcG9sbHV4LQ0KPiA+ID4gcmRrLmR0YiBpbXg4bXAtcGh5
Y29yZS1uby1ydGMuZHRib8KgIGlteDhtcC1waHlib2FyZC1wb2xsdXgtDQo+IHJkay1uby0NCj4g
PiA+IHNwaWZsYXNoLWR0YnMgKz0gaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGsuZHRiIGlteDht
cC1waHljb3JlLQ0KPiBuby0NCj4gPiA+IHNwaWZsYXNoLmR0Ym8NCj4gPiA+ICtpbXg4bXAtcGh5
Ym9hcmQtcG9sbHV4LXJkay1ycG1zZy1kdGJzICs9IGlteDhtcC1waHlib2FyZC0NCj4gPiA+IHBv
bGx1eC1yZGsuZHRiDQo+ID4gPiAraW14OG1wLXBoeWNvcmUtcnBtc2cuZHRibw0KPiA+ID4gwqBk
dGItJChDT05GSUdfQVJDSF9NWEMpICs9IGlteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLW5vLQ0K
PiBldGguZHRiDQo+ID4gPiDCoGR0Yi0kKENPTkZJR19BUkNIX01YQykgKz0gaW14OG1wLXBoeWJv
YXJkLXBvbGx1eC1yZGstbm8tDQo+IHJ0Yy5kdGINCj4gPiA+IMKgZHRiLSQoQ09ORklHX0FSQ0hf
TVhDKSArPSBpbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay1uby0NCj4gPiA+IHNwaWZsYXNoLmR0
Yg0KPiA+ID4gK2R0Yi0kKENPTkZJR19BUkNIX01YQykgKz0gaW14OG1wLXBoeWJvYXJkLXBvbGx1
eC1yZGstDQo+ID4gPiBycG1zZy5kdGINCj4gPiA+IMKgZHRiLSQoQ09ORklHX0FSQ0hfTVhDKSAr
PSBpbXg4bXAtc2tvdi1yZXZiLWhkbWkuZHRiDQo+ID4gPiDCoGR0Yi0kKENPTkZJR19BUkNIX01Y
QykgKz0gaW14OG1wLXNrb3YtcmV2Yi1sdDYuZHRiDQo+ID4gPiDCoGR0Yi0kKENPTkZJR19BUkNI
X01YQykgKz0gaW14OG1wLXNrb3YtcmV2Yi1taTEwMTBhaXQtDQo+IDFjcDEuZHRiDQo+ID4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWNvcmUt
DQo+ID4gPiBycG1zZy5kdHNvIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1w
LXBoeWNvcmUtDQo+ID4gPiBycG1zZy5kdHNvDQo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5hNTY5NGYzYWVjYWENCj4gPiA+IC0tLSAvZGV2L251
bGwNCj4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlj
b3JlLXJwbXNnLmR0c28NCj4gPiA+IEBAIC0wLDAgKzEsNTcgQEANCj4gPiA+ICsvLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+DQo+ID4gRHVhbCBsaWNlbnNlIGlzIGJldHRl
ciBkZXZpY2UgdHJlZS4NCj4gPg0KPiA+ID4gKy8qDQo+ID4gPiArICogQ29weXJpZ2h0IChDKSAy
MDI0IFBIWVRFQyBNZXNzdGVjaG5payBHbWJIDQo+ID4gPiArICogQXV0aG9yOiBEb21pbmlrIEhh
bGxlciA8ZC5oYWxsZXJAcGh5dGVjLmRlPg0KPiA+ID4gKyAqwqDCoMKgwqDCoMKgwqAgQ2VtIFRl
bnJ1aCA8Yy50ZW5ydWhAcGh5dGVjLmRlPiAgKi8NCj4gPiA+ICsNCj4gPiA+ICsvZHRzLXYxLzsN
Cj4gPiA+ICsvcGx1Z2luLzsNCj4gPiA+ICsNCj4gPiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
Y2xvY2svaW14OG1wLWNsb2NrLmg+DQo+ID4gPiArDQo+ID4gPiArJnsvfSB7DQo+ID4gPiArwqDC
oMKgwqDCoMKgwqBpbXg4bXAtY203IHsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBjb21wYXRpYmxlID0gImZzbCxpbXg4bW4tY203IjsNCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBjbG9ja3MgPSA8JmNsayBJTVg4TVBfQ0xLX003X0RJVj47DQo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWJveGVzID0gPCZtdSAwIDENCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgJm11IDEgMQ0K
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAmbXUg
MyAxPjsNCj4gPg0KPiA+IMKgwqDCoMKgwqDCoMKgIG1ib3hlcyA9IDwmbXUxIDANCj4gPiAxPiwN
Cj4gPg0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDwmbXUxIDENCj4gPiAxPiwNCj4gPg0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDwmbXUxIDMgMT47DQo+IFRoYW5rIHlvdSBmb3IgdGhl
IGZlZWRiYWNrLiBJIGNoZWNrZWQgYW5kIGZvdW5kIG9ubHkgbXUgYW5kIG11Mg0KPiBsYWJlbHMg
b2YgbWFpbGJveGVzIGFyZSBwcmVzZW50LiBtdTEgaXMgbm90IHVzZWQgaW4gaW14OG1wLmR0c2ku
IENhbg0KPiB5b3UgcGxlYXNlIHRlbGwgbWUgd2h5IEkgaGF2ZSB0byB1c2UgbXUxIGhlcmU/DQoN
CkkganVzdCBjb3B5IGFuZCBwYXN0ZSB3aGF0IGlteDhtcC1ldmsgdXNlIHRvIGhlcmUuIFlvdSBu
ZWVkDQp1cGRhdGUgYWNjb3JkaW5nIHRvIHlvdXIgdXNhZ2UuDQoNClJlZ2FyZHMsDQpQZW5nLiAN
Cg0K

