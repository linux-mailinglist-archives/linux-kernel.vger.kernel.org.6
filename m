Return-Path: <linux-kernel+bounces-261200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 315E493B418
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C9F1F2490A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF67515B111;
	Wed, 24 Jul 2024 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HxcwoWmP"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816618040
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835973; cv=fail; b=C8JOftlbf/ViCTx0gL42tDO5AoOceIOww4QSm+yYHc5FNNHcp45wUqFN19DzwFedmIIOp3ukjr6j6BWzWRrFfpZ/Rad4/WEMQOQTMcUiDe/VL1HAJAH0NjKTm1ws8CrONgaOk4QS4d0CoiFL3T25U+JHTrwG8SAuyESfIvscbew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835973; c=relaxed/simple;
	bh=dtHxKJgSuUPP1HUYpHxsFiy9RWJEuwXONAcgw9f1mpk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=KCKAe9F6RE+q6vD3o9r4jVebQsl0v1G5Zl3w30KwcfmA4F9qmQ6JV4Y3aF6GGmD/iOI3svAf1FA89nzR7wV9to8P3zEsTStJglRxL6KJIzBL1LVCbiicldYmPVdwEsu82ZXQ6DSaoQYv5/mUpmc6Fg9h8t6w4UoqbeRbVp52Z8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HxcwoWmP; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MD81r6yU+BMmFJF1pUyOyOwyRF6AyyZJKbx7o10eiLItdUGT43VsTLoPt2/2J7gpYtVeGmLkCxWTqGdg9yN2ZbNvYZVR8sgbSnVZHPpixdNTfel8wz0A7LotrxdUpMkjp065S7fcbczB34v0DRDuGnDPRJWLH2bVRwQn3qdLjmoOsWNV6uHhs1849t2AdOFB7Spgckp+XSVjxUQG9EicjaEzNSPRjmVw+oKx0B46WIJK+5hsx1ORf364KPLW13qbjLnNUsXzEO6h+0jADomIhAlQmavAH8NgakCngLzsSRseEb+VSl4YvjnRX8PGVCK+dkXJFCswIWqaKT1spLr4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSL5r6hTHQi703eiuD2fMg6Gt4zgPLjs1uGp4Sf4U3Y=;
 b=mrM7/OWz6b/CJYjcQ5nH5oKCIbsPWsfwNJWokRARSyCZG6kKmXiqLhfWU0s4/rqTfwz55A7MA2FDy22MvIQEpsZDU575qpPcSbI/aeRlmVBM+SgWGBcnmxNghaADRyU0/sXHGukjnblKusIvPYZBo0a8jgJPuKD5Ug5SSltWe5WdsusqTI3cx9lNV94/fhh7dE8HYm+YLtg+0kiVGPI4c55NFWaYe6YeT4WjU7QAygCgPsLWcEexP95Q2rfIZM3cNO+2Wno+ZO55mzuwwuUIduemQaWio7ofMeOs9o1rO1eOVxfkmE8RS5AvwZMBJrCTvqoiXusrjhd08Ejw281WeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSL5r6hTHQi703eiuD2fMg6Gt4zgPLjs1uGp4Sf4U3Y=;
 b=HxcwoWmP6G49q5Yt++C3UTj1DDRt6cwxOV+7Wismc9cFetwH6BnC03+wJaUX2o+1naycodUT6eHtEUCil8+eFzgBClJKoo44zPdp9ikPlLow+dL8vhOnj3RTdSfTtz5mRkt9VuujVptTtqRZKPKYMTDXLnXzNl3zO/kJtyi4RKyZuTffBnDdWipVUrXEHMhgs8yEwpVOdINGamoCc78mtG65gLqO6xyjdaPGB3SbsUPGS15kW5NrzeFIgVY49UhT+lZDs9grRGIX/p/M6vMYrRFEIc0VWZaIRPhqkYLXrciYJiUns0grKhvLJIVolgIYotFcF8DvR0AFMGPk5g7T9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 15:46:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 15:46:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/7] i3c: master: some fix and improvemnt for hotjoin
Date: Wed, 24 Jul 2024 11:45:45 -0400
Message-Id: <20240724-i3c_fix-v1-0-bfa500b023d6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKkhoWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyMT3Uzj5Pi0zApdY3PDpDSLtETLVAMDJaDqgqJUoDDYpOjY2loAXy1
 KbVkAAAA=
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721835962; l=984;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dtHxKJgSuUPP1HUYpHxsFiy9RWJEuwXONAcgw9f1mpk=;
 b=AVeiZtgrriCtVzHWU5/7yvPT2a11mkZcKiNmXzbjeq8HflXMucSPeXIhsEISkf9AkFFSHf+zD
 mWg1bdXJlmEBPkYvoqA58gpdERDvluUUdfd3jJJrHNajFvilGhzyIVs
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0dd672-af90-4fc8-1c56-08dcabf7ba81
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QURtNzNFMWRpTGVRWGFoUFRsRW9WbkVWcmdUenpjR3JhNWp3RUkzbi8wSHBp?=
 =?utf-8?B?dVlpTm9iblJRRU03YTNOL3F6QXEyUmdOd3JWRWZoTU53UnpVWDNkeGVXK1FF?=
 =?utf-8?B?NHBvd2dwOEI2djd6OEhmL0lYZGRpY2NDS0ZaakpoYXJpY0xObnRERUY2aFU3?=
 =?utf-8?B?Q2FNN25CSFBuMjdQN0ttYmlZOGtKV001c1pTTlM4OFlPVVFNRVg0M0I5UVYy?=
 =?utf-8?B?YnNSU3BiQlRzWnR2ZCtGenkrVVpIanNjaU11ZzBrd1pMaW5SenBNMXFHQ2dD?=
 =?utf-8?B?Wkw2b2Z6dW0vUE93bm05dG5GQnd0eHhtNGVtZ01vVGVFL2paS3RwS05hWjN2?=
 =?utf-8?B?QW1ubnEwTllSTTRQS04vNXo2MFNnbnFCeStKNHlPeCt5Vy9mU3pLUXlSSkE1?=
 =?utf-8?B?RjErYkZXcmE5c2JKVDRxUnU0K0l0ZW95R1VqRThaMWZpNTZZajY0aGhYL2M2?=
 =?utf-8?B?VDdwTlAxUXFHRUk5L0ROVlVSRlNDMEFVbnU5TFBwTGF4Q25iWnJNQXdsdGFI?=
 =?utf-8?B?KzZzdk9FTU5Lamt4dnlPSkxyQUpoZ0FEdlVKQWs4YkwySi9EVllaaXNHc29s?=
 =?utf-8?B?NUZlMWQ0WExhdEo5c0lVVk1SVEZnVGxYYnFpS2dkNmlVelRKVnBwdVBMYW9X?=
 =?utf-8?B?UU1mSFRqcklyTFhmSHNGc2lhMFFTK0RUZldHTzhWTk1iRFgwa0dwRUV6THRs?=
 =?utf-8?B?UkhXUFZwNmJIVkN4b016dXlQaG94TWxiYmI5elZiRnB4WnhyZnQySTV3alBU?=
 =?utf-8?B?cXBxOFNhVE9kd3FjaGM4WmxaMDFNWVNvaUZLd2Z0Y1A4RkQrVDhrd2ZDRk1l?=
 =?utf-8?B?Qnp5aVJTM3hlZ0JWNjFYUGVEdWVZYXJHdWtwTDlGYWhXeWZDckN4ak4raWdK?=
 =?utf-8?B?R21MVUhoVkl0bEVmRW1ERi8zSUxOQ2t4NTkzWlppN1ExcitpU053b3pBS1ZO?=
 =?utf-8?B?Q3NSa0FoemdXYUptUjJJaFhIY2JndHNBcE1vM2VlcHBWbitUWkhNQjdaU0Zi?=
 =?utf-8?B?TkpVdFFvS0tNVG42dnFWM1ZIekREdC93RUkvRUZOQVFKcXB5OVRxVmFxTFdz?=
 =?utf-8?B?ZHozZHZmN3FsMjJxeDUxWnhsM0lCS3l0NDlWQXE5S0JiU0ZIbzNwcmEvZTd0?=
 =?utf-8?B?VWtIei9RWm4rVjE1azVSSzVaWnNzbGlWOFZCUzFXVXZ5czc0Um5vZW15SVhX?=
 =?utf-8?B?UFNIdFpTdnNjSENqNWNSSnROenBiOThBemtnRkdhcDY1RGJ6M3pGRGJmZU5i?=
 =?utf-8?B?UlpEQm53R3pDK2YyTU5NYjYvWDFyRlo1MjhMSkU0d0pTQW5zMzNxalNUcmR4?=
 =?utf-8?B?QUpvVTE4dmRESVdOdnJ5VEtrbXBocnpSVEVNaDBJTlJzTFJ2SXA3ZlZtWDRO?=
 =?utf-8?B?SFQ0QUhiNHFOTWJmWnd5OTNvYXkvMldYd0g2am9nRUdnYmtlT1dnN0JhL1l3?=
 =?utf-8?B?Um9BR05GVHZ5M2VmQVBhbFo0Q1BPUEpqVFlZbmU2WTRmazkzVGZ2WGdSdVBT?=
 =?utf-8?B?Q2Uzczk3c3IrQmo0TFdHZElJamN5eGRKSU12OW1pb3A1d3BEcktBaXJwQU5Y?=
 =?utf-8?B?OUUwemJDSG8yOGZwbC9NN25vZng0OEdwWUtrbHZDRXBLaHJEWkZLbFhuNG5M?=
 =?utf-8?B?R21Ja2kwUDYwek9mZ3RkNmJiUHFMaE5oUStUSnBObnBxS0F5WWw0VU81Q1JE?=
 =?utf-8?B?K1NhQ0QwNW56LzNjWHpralhlQ1RiTnNTTjB4N0Iyck9oR0RWTnlqWmpDOHpn?=
 =?utf-8?B?WnB5ekNyZTVwOTlZMTJ3RGMyTkhaa3lpYnNiRmVjQnkvdHRRZDZFMVRxNjg2?=
 =?utf-8?B?cTJ1MUZwSHN4NzlJNm4xRkQrTCtXayt4Q1Q2eDBWT1FGc0FlWnhxTjRFMTMz?=
 =?utf-8?B?c0NTMWFpSWR0Z1FGVUZkb3E2bDdZTVJBR291K2U5d2xQdEE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RkVmR0xuUXFxWFZBWmgwdGdNTEhSTGJnS3ljRHc3UWk1N25SMGhaNkZsYks1?=
 =?utf-8?B?NGd1TlJFZmtYR3J3b3ZNVi82cmpGS3VXWVROSStkVGxuYWRGaHFCOGtYYk9X?=
 =?utf-8?B?bm05eVpjSnFpVDhKRG5Bd0Z1L01OVkNZU1FKRXJWM2JoSElSN2ZMaHVCdy92?=
 =?utf-8?B?WTltTVBheUtSNTZwUmNxSTZicFpQUjc5ZzBGdS9CcmNsaEdWejZ5QzVXM0tZ?=
 =?utf-8?B?cUhRVXZCdFhWVUY2MnpMRDRPMlduek5peGUvd2ZsRzRMYytmazlMaCtVSW9V?=
 =?utf-8?B?S0VianpiVjcwTWlMMG4xU1doV0psNFR4YXJ4VWdiNGxLcHB6dmJIYU03VEZL?=
 =?utf-8?B?Y21HTkZyU2V6eTBKNmI4QUViNG5PSHJOYldBN2oyWm5TbTAwTk1FMGJMSEJ4?=
 =?utf-8?B?MFBpR1Awc0pzRTRCQzFIMFI0U3dMK05RcHRKT1k2bWxPQnBvREVCZGZQWllC?=
 =?utf-8?B?UVpqdVB6RlFpSGxtaW5EY3JNMUVqVEd0V0xnUUpyeWJaZHE0K1pwblo1cTJY?=
 =?utf-8?B?dlUzSnhiSUgvOS8xM0krNnIxZmxvZVcwOUplK0pJU1ZOL3U2STFPUUdtTWJo?=
 =?utf-8?B?TlhyNU0yQURxZWdLRklpYmxpWVMvZjBuYmpSODJHN0pQU1pKQ1VMbW91di9n?=
 =?utf-8?B?bTIzcmVYYnZ2WUZxTFRLd2pDa1VIRHBYSHBzTzdldGFYRWNDekhveEJWZGht?=
 =?utf-8?B?TUJqczZKZFZZZVp6V2ZZUHBEOFozcE4vc09CWDYvcGRQdzVpdllia05ZK3dr?=
 =?utf-8?B?endsMzZtYWhtSGtRTUUwLy9NRDF5Tm1NZ1V6NG8wR2huK0MwR1ovMFd2ZVFy?=
 =?utf-8?B?eTlLbHhYYTlOMkdTVS95NXlVbzNKS0FlaDZWMllubEN4dUFONTFCQllybmhN?=
 =?utf-8?B?NndvUWFBNGQ1eWZxZXNzeGI5QnhsL213T28yYTh2bWY5c0cxMnhFd3U5bkts?=
 =?utf-8?B?MWVBMmRZWm13TmVqTkpPVURiR00xOGpZbWlYRWkvKzZJTkR5bjNweFIzUCtV?=
 =?utf-8?B?QmMwTG8zaGpseHlBR2dJMGFreWpVVnBDaE9IUDBnaTBEVnVjamNUS1hPc1o3?=
 =?utf-8?B?cUpsSlFtUDE0VDFtS3NBUEkrWGtQVXB0RUxoa05uTU5Ubm9lOStYVkk5bUcx?=
 =?utf-8?B?czRMcUxGVmh5SFpsL0I2bXVjWnRqbDJIT29qUmwyY0xIekxMejF4V1NKVjJh?=
 =?utf-8?B?YkUrZ1VhQWw1b0oyYUIzdkF3Mm1JQUNqTG5nWlRtRUppckUrc2piSkFqeDJp?=
 =?utf-8?B?WjRET3NTSjJLSmd6MU5NbEJyTlIxZHRCMlhwRVdvc0lWa2ozMnEzdGl1eks5?=
 =?utf-8?B?RWtSMzVsUURudDhJa1hZRlFpdzI1VGgzTXluaHYxanIwTGhhL0NxZVVvYk1T?=
 =?utf-8?B?US9iOVk2RURrOHJYem1nNnVGZmNSdS9LMHl6djBWd1hhbjZXdGNldDFoQ1dl?=
 =?utf-8?B?QWtqRSt4K3RrUHNOMFZLdnV5TGJJT0xJS3k1WlF3VDVPTFdsNjZNb0VDaVAz?=
 =?utf-8?B?czRsbGJsMEZNR2NlL25LUmoxdVExMDZISXZjcDMwRE9MOGhJS2F3SWluZkVN?=
 =?utf-8?B?RkhkcGJ2SWNEcW4wOTQ2YzBEa3BZSTNDdm5ub2lRUWtvSk4rQzBmRExlUzhm?=
 =?utf-8?B?djhZQm5MRWtXc1l3M1k0U1hEUStUMXFyQUNJWXJSTWh0Y01mNUxaU1grQVdy?=
 =?utf-8?B?RDczNkI0bDdORVF0dnBITmxwSEduNFB5clFJYnpJQ1ZhN0lhNmxQT3Yva0VT?=
 =?utf-8?B?ci9FTFNOL3ViSHdxeGNkZ3ZmYjBHb2hrSTlVRVptTGU0M1F2Nlc3NDBtc0lL?=
 =?utf-8?B?Y0ZMb2JTZHVXRUIwMGNMZkU4Q2RlOERtSlJTSzkwWVhFdE9WV2F0K2M4clND?=
 =?utf-8?B?dUo0aFBTT3czZi9BTlEycS9rMFg2dFNFZnI4dWllRXZHdVhSYTg5aUEycjFk?=
 =?utf-8?B?WEIzdi9LUityYnE0cnc0WHQ4ampXRjlFTlNSZGFITlRiekpXOTFUd25Ed3NN?=
 =?utf-8?B?elVZMElRelZ6bW43eVhFaFRaK0tBd0ZaRytSWkwrSnBmaUtLZEQvdGtOdHBW?=
 =?utf-8?B?ZUFtTVRUWDVFWFRudWFhVjVTT1ZSY0lCVmVBSGhUcjlXalZYeEFkZ3FabXZT?=
 =?utf-8?Q?1jBa/M1f+KN33KtIWPOspNZrY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0dd672-af90-4fc8-1c56-08dcabf7ba81
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 15:46:05.5375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1QQAKhKCpbyI6UQWYuEINqai3SCdjgsuO5LKf7wwtMY7zgmr9Fy2RIV8ekv+ppKrl1mb2GPsc/cGSfYCmF2Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8599

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (7):
      i3c: master: Remove i3c_dev_disable_ibi_locked(olddev) on device hotjoin
      i3c: master: Replace hard code 2 with macro I3C_ADDR_SLOT_BITS
      i3c: master: Extend address status bit to 4 and add I3C_ADDR_SLOT_EXT_INIT
      i3c: master: Fix dynamic address leak when 'assigned-address' is present
      i3c: master: Fix miss free init_dyn_addr at i3c_master_put_i3c_addrs()
      i3c: master: svc: use repeat start when IBI WIN happens
      i3c: master: svc: manually emit NACK/ACK for hotjoin

 drivers/i3c/master.c                | 66 +++++++++++++++++++++++--------------
 drivers/i3c/master/svc-i3c-master.c | 44 +++++++++++++++----------
 include/linux/i3c/master.h          |  8 ++++-
 3 files changed, 75 insertions(+), 43 deletions(-)
---
base-commit: 41c196e567fb1ea97f68a2ffb7faab451cd90854
change-id: 20240724-i3c_fix-371bf8fa9e00

Best regards,
---
Frank Li <Frank.Li@nxp.com>


