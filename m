Return-Path: <linux-kernel+bounces-561674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07264A614CA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B683B9704
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB92202994;
	Fri, 14 Mar 2025 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oO40tjHa"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2047.outbound.protection.outlook.com [40.107.103.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F95C20127F;
	Fri, 14 Mar 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965850; cv=fail; b=iH1mieiqk0CE9cnGtA86B5CkSuJZB/hnzqqqhjfrMdrKcKQJkk9IA8ps1k3S7YlPVMxPY5tGHoZ1EyVo1SfT04RNIX3Jq0y+cbQuT6kvtdD6bpJUT47wOsbbkqI+kmdNKtxt8Yekvu/j1YismZ3oRSSX14d7ngjgxDes2ENLPOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965850; c=relaxed/simple;
	bh=XcAmlH6AyfGxngg1gP0jQ6g4y+CQAEHvUM28V7pmaNY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aghFWvVnlQKU6PNMswNu6LU2g96i/TyAvO6zUF1B3E4/Yw+pOIsg2ud1YpU2s2JDOnqhp1cy6d2rX72oJlAVXSLhGKIdKv8l5ip4QY/12oHBAhFizJq0S8sTxqcsFeH2lNU42elgLS5EX0zAuNQ7wqJfYrHu2czpNZjABRolDJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oO40tjHa; arc=fail smtp.client-ip=40.107.103.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQJPa6nXCk1emu20ibpFixCbYmDoCfViCTse1ccY0t0gN17nFDZeDwWV0G6kbYNW+p2nHs56tVjVPvNqwALTiBtQXYZSPBc89FWgp12fKjMi6Dxb4RvaxiObjiOF4lgCmQmzWHKVthlzeYNxxpsx8pJNcVjHw1v8gRR5ipfupYZSilld5PtHYMHbL1SKk7/ZNV3p5nf5jzOSv/UVKlrRGTXd5R34dk/CZM6y5A7g3JkFtdnRRUSHZ4UlBzV/y6bybF9nL8GxyNwItcK8fBSXw10/7WGMdqUaK6f267mvMfIZiTYXpaLtaZx6K1YwNl/mHvsl09fXSJPGF/SLhHgi+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh6KGuWk8syDSXw/MH82ShtPOm8mHIgajJHLtJZFMzQ=;
 b=j2Wahrq7CB1soQ9lVDUbiSuMaTuiUX/scFkQfJ2KgwpMI2zewR4aLTOLqr6GcW6rI3tL8K+3i5yNcFjbRJxHPkZQ5WDZ/JqTg3l7oQx6VRFyL+fCFpj7ZLoCHi0ahZAwUa41v1bOJUh37sb7sWmLRp0gf7b+wktwrdq3h88N8JKTGxxxL9gaegIdgGiEMSY1lgrQehk3+ZMoRaEgNV6fC51LQcvGG+6bhOor0uOsCjaw1E0MfvuLAnRDD6UoNaTYMrFIcuI8TfNH1PZjlsoDRsft0cPtTzxFxCh4cHBjMJpdBzrhr7nAA/ttd/01oQEIqCiI4CvWA0J+VU5Dck/4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh6KGuWk8syDSXw/MH82ShtPOm8mHIgajJHLtJZFMzQ=;
 b=oO40tjHakk2muRyVDG8M5bd5TOkvMdNt/onfIWZVVtf/Mg/1l+nxCgwTyw5IbtXkbrqioEoMtvJDSeiQtnrACC208fKBg0FNrvgTwTsdZUtByYgIwoFsVzO89o1s8isnQjcrJOKxYE9xIjaxQ/6nrOeoOW5PKOmV70RDZBH4yOEovOPD9Q5sdP2XRnc4EVwD1v1X3ncRAxDU9Ju5ojiolcOazSgyhArhlG5yl3pGpsPlvipe3kEDnwGVW/ucpdTYdFWEGU9a48UAwqF5gBj3uxPmPPMPXx2JtEgo30zm9Ixs9IkMGcL3Qo5iWEoPmHBsxLrTrfvxqkoefLxpS+ud1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9730.eurprd04.prod.outlook.com (2603:10a6:20b:677::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Fri, 14 Mar
 2025 15:24:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 15:24:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 14 Mar 2025 11:23:46 -0400
Subject: [PATCH v5 1/2] regulator: dt-bindings: pca9450: Add nxp,pf9453
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-pf9453-v5-1-ab0cf1f871b0@nxp.com>
References: <20250314-pf9453-v5-0-ab0cf1f871b0@nxp.com>
In-Reply-To: <20250314-pf9453-v5-0-ab0cf1f871b0@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741965840; l=2330;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=XcAmlH6AyfGxngg1gP0jQ6g4y+CQAEHvUM28V7pmaNY=;
 b=J3fULztdgct1LM1pnCi+Nh6tKp3VtMM7KZhiMWimFlNb8RS+2jSviCpuVeb1gmmWIWMxjHWRH
 FaSLIAwJHp4D6irWhHT5fCJqkV/nyMMm/NQ9EqhwXcdIHDWWvUKXjcz
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
X-MS-Office365-Filtering-Correlation-Id: cc7a4ee4-9ae4-4214-c3cc-08dd630c4254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3JNYy9RZ2xmcEt1bjJERFduTkkyZXI2TDVERTQySzN4ZlRZODFlNThlcERP?=
 =?utf-8?B?czhadU9WVWJSWCtYZk1yc3ZVZDlCZWVWcW5MZHpJQks0ZHBVbVJOU0IwdUFE?=
 =?utf-8?B?eGltK21BMjRzNlVqU3prS0R3TEx0eGdOVDJOcHVNVGRMbXppL2c0Q0ZualB3?=
 =?utf-8?B?dWl5WkhXOXpPSCtySHh4QUdnVmVNZkVXZE01Q3lSYUROQ0RGS0ZCYUU2ZkRI?=
 =?utf-8?B?NkVGOHd1eGt5dFNCNDZCMlFmV01meS9nQ2pYa0ZLVnViNkowRURtN1M2cWhw?=
 =?utf-8?B?RXhRZ0g2SWROTms0V0N6RUJiZzZreldRck13cW8wM2sxbFVhSEd6emJ1NU1Q?=
 =?utf-8?B?cVM2NC9mNGZaNklkYkN2dnlsRHh3N204eFZDcUxRcDZHcTRGc1QwWHczSWxt?=
 =?utf-8?B?ajVHaGFBUXRrSVdiemduWDZIQ0dqK1VHN0FXVFBqSkVnWHFzSUJOQy8xOE5z?=
 =?utf-8?B?SkZ3bHpYQkVFNytzdTVJU1F3d2lnZFR3Yk12Sm9zclFkU1hVUlIxZ21EVFhP?=
 =?utf-8?B?aWRuRXpYaW54anp6cmxuTXAyS1ZobzZFT2hicis4V1BpZy8yczVOUUJGRUFG?=
 =?utf-8?B?WEhLczR5ZEltOEZLcVVPM2Z5Y0lRdTFrTXNQZ2Z2UmtLeFVKL3NFVGE0Zk4z?=
 =?utf-8?B?WTBhWHVKNDBmelRxSTB5aTZESTFQMGNsZ3NmbUlYQVVwTHZHYlFOTDRlOU90?=
 =?utf-8?B?K05wZUtFUVlUOXoyU05CVklDU2lOWVBuM2FyWE5TOEQrUjlMTGpNOXpCb1pR?=
 =?utf-8?B?VDVTT0ZWUDJCd1MybUdCZG1hVzRJMjJoMWxlOS8wb2U3LzM3WkREcG83WWV5?=
 =?utf-8?B?MklKeDdEQWh6b3J6Q2o1TUhLUUNqaU5EdHhVTnUwejB3WURWSG1yMmRaYVk1?=
 =?utf-8?B?WDFkMWJXcUFRa3puTjJWZi9hTjAvRE9OL0s2WTBWTU9rVGI4Vmx4TklmSCth?=
 =?utf-8?B?MUVUZjA3TGQ1VzhFaHh4NmU4RUNXT2NydjNMTXZLdVE3VXVZTzU4TmFFanQr?=
 =?utf-8?B?cHlZbzBpTkJFcFhPVlAxWTlaUkUxcE90RWVKbWc0TDlOdjAzYURONlZyUjhw?=
 =?utf-8?B?bWt5WWlaS1krdFJla0JLS0hJNnJXTkFmbEl1UnZPdzM4TmlPR0NzSVgwOUx1?=
 =?utf-8?B?U3JQMWZOU0gyNk9DNmd3L0RhdGV6QjZGUCtTYlBrT1AvQ3J2R0djT1NCTE5n?=
 =?utf-8?B?MWQxUVBrODNONjNFenRXMHZGVmtnNGJLeXIyZ2EzMUtnOFJQZVU4dFdUa3Mz?=
 =?utf-8?B?QjkxanNrbDZQOU93QmVMb2dXdXkxNEtTODRZYW50MkNJWmlDZjdqaHhkQXJx?=
 =?utf-8?B?cmM4Tkc3WjJPUkNtaHJVMXNhWi9JblFJaWpiZ1lPNUZUNHlFTkg2MDB1RDU2?=
 =?utf-8?B?ZE1ib21wY3lKRVVnQTJSOERJMVdwbjZWRGs2Qk4zWDRFc1VwdVRWclZXam9W?=
 =?utf-8?B?ZnRwQ2pzbUM5YnA1TlRYcWhkOW5FaWRXKzhFOVJ3SFdXQTRTWnhUWWFlSmU4?=
 =?utf-8?B?WkJuckJ1VjJ6cDJKOFowTFdJR3VxZWgxNFp6R21tSyswK1lQUVZyb1h4K3VB?=
 =?utf-8?B?SEhCdUE1ekM3cXgzYVZ4eDVoSHdnZVBYWnhqSGNMTXpvbFZGWWE1bk1RNUt0?=
 =?utf-8?B?anVOWHVWWWM0L1l4cGdFUktWSE05Z2ZjZHJQVzNsOHF2RU1KWEhRVWtMMGg0?=
 =?utf-8?B?YmZnZG13Mkl0OE1XZ1NKM094OElpcHdHdVJEY3Y3Q0JDSHlVYjhjTGwyN1FR?=
 =?utf-8?B?UmFSdkQwT3VTdEw3c01taGZBQytyQ0thSis4QVI0dnNSYjVhUFhrVzRLM0VW?=
 =?utf-8?B?disrWXBCNXVvdGZENkJVU0hidmpWQjU4M1FRVVJWVnVUTUpvWlZJZjA1eExn?=
 =?utf-8?B?SWQ1cENaYjVwMk1JR1hodDA2Zi8zeUNYUGJtRzFaS1FOZUVnYkU2UUcxZnFk?=
 =?utf-8?B?UlFib202ZjBlYVFoRCtNeTZZcE51TVJYRU5rcWR6eWIxYkVzT1lhQ1ZKdU5y?=
 =?utf-8?B?SXJTeFZNMGl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEl1UWxJU3ZBd0J1NkhvVEVINmF3elRaRGFyV3hZMkthWHhnUXI1d3RCeFpa?=
 =?utf-8?B?bVR1dGt5QjVpU3lmVEFEUVN1OVZiMVN5OEMzeC9wYlR4SGFtRVVqM2VmRnFi?=
 =?utf-8?B?WDZDRGdlSCt6RVVKSDhpZWgyS1V0ZFY5QWtCVUtsWDJlREYwcUZNS2ZkV2x2?=
 =?utf-8?B?NlJ1Z20yeFNhdTA4cDY5L3lqdXpYTDZDQm11YWZJbThveUxFWG1iQmhGcC9M?=
 =?utf-8?B?OTFPWmViREZFVnh1RExSRTdwR0wyc2QyQ09Ba2pReG50ZHR3MUdadldLWGl4?=
 =?utf-8?B?NDRoY1ZBSVgyL3orbmZQVVpoTjBoOUlkZW5tTmIxaWxCdThJbXNqN1N0VWJr?=
 =?utf-8?B?dmU3c1A0VlNTM2hxSThycHZkWkM0RlpoN2FORXJWTExxYmlaOEJTbEFOUDhx?=
 =?utf-8?B?K1cyRFlDTWIvVk5xZzk4Um5HelRHMWlqclJhanhGNms2UzhydGRKMkVDMWNT?=
 =?utf-8?B?RmFiTjdmZFc4NVpaMlpjejFqTFNTbU52eFRJQnc3cHJsNDNNWHBCaW5UZXN3?=
 =?utf-8?B?ZDNCRFVKejVKQUp3ZTdvN085Sm9aVkptbU9PeWVXUXVqREhzMHhvTTFmUjVl?=
 =?utf-8?B?QzR5SmdCOG1ZQWJoc3RzVzVRdnJ0SnBDQnNTbDJvWDdjQnlyWDJySkFKc0tX?=
 =?utf-8?B?QkJMVHZ4K09rekw4Zm9MWVU2ay9EZWsyVFYwVUhpUlpvTW0reGxtanZtN3BO?=
 =?utf-8?B?aHpHc0RXRGhhMzYvOTlCVXRKQ1Y2VEpDUE5NdXNTTU5vZ0ZhTU5XVndZd0FU?=
 =?utf-8?B?akFzOFJtc3ZyWEtMM2J5aGlpVFFGdEJIRUdqODlodFQxSlVIY2JWNm1YREY5?=
 =?utf-8?B?RElMRU1IaTNYbTdLV1V6WnFBdjd5blNhVDdsWFFqYzZzb1JMU0hBUkI0Q1A3?=
 =?utf-8?B?NVZtMTFuaUVNbmluQ0VrWER6TlFPUnFidm5KeXoxRFB6NDZDNTYzWUpReWMx?=
 =?utf-8?B?ZG1BT0JuSlU3Qm8vb1VnTmtINHJGRkQ2eE9hVGt0d3JWb0l4WmErV1lyU25j?=
 =?utf-8?B?MCs2ZTFQOS9XK20vV1pZcE52NU95Umo2ajJ5S25RK1QyUXlsS1ZDWC9uanZT?=
 =?utf-8?B?aG5GcDh6eUJUWU0zYlhvOXMzWmQ0N1FwcFovemd6eE84VG9FZ2ZrOVJSc2Ez?=
 =?utf-8?B?Mm1vZEo4OUJtMUFIYnpMZnBCNkI3WEdpY0ZLb0F2dlZnVHYvSnlpSllaemd6?=
 =?utf-8?B?OGxhcXl5UFlHU043ZDg5YnVOQkFCQzcwMTBUNnRkV1dQZXExZ1dyaXE5YjZ3?=
 =?utf-8?B?b0lCalphQnRDeEpaSVNmR09ONkNoZ2JzY1hBRFVMZml4YldnK1dISzByaity?=
 =?utf-8?B?SWR5cE91OGVLMDBPZGR2QkdoN2hYNEJvVTg4WHZ6TUVzcFhJMVlhODZodkdp?=
 =?utf-8?B?RG1vRzBCUTBrYUpnMGZOUjc0VDlmOEpoSzZEQTVJbVVHUmRuWWR5T0Zrbjky?=
 =?utf-8?B?eEFrLzVBRzF1b1JsNWl0Q1NPQlpOZVdUT0pFL0RSdnd0Mnc0bERhVHlQbUxH?=
 =?utf-8?B?Q0Z5Wm42M09tbmJEZWtiREJndVhuWDZqUWxCdmpCNURIWDhZUG5mSFlUbFY4?=
 =?utf-8?B?Wkdaa00wazVwUXc1aGZUTVFYNXFLS2tlUC80WkZuaXlyTzYzOTl4UGNCRzd0?=
 =?utf-8?B?SFhaWkREemZqamVCV2c1UjBnWjdCaGc2enU0SE5NQWF4a2V1dTRIaWNXSnhp?=
 =?utf-8?B?QjBWR3FZR1BWME1IK0VxSFZoZWcrZWhaWHNFL09UeTh4MkJUSXVkVDlZS2c2?=
 =?utf-8?B?R2RXNmdpSW9WbHkvSFhUU0xncGRTZ1VpdTBUd0V4WGhvOXk3UUlwZThvMlM1?=
 =?utf-8?B?SlgzRzd4c3ptWm9HY2JhUjZ0NzlCUlFFZVVVZ0ErQ0R4bmFmU2NXcDJ3UzJh?=
 =?utf-8?B?Q1dxMy9DNW10RWljd1pOUjlpemIzZEVQdmVmcHlHOS9tblVTcGxid1lnR1hL?=
 =?utf-8?B?N3YzR3NKK0pMazl5a2hPMmNKb0RkMFVHK3RvNnVhVERVVDNMK2dhUW9ydzJE?=
 =?utf-8?B?VThxckdMdWtRaWZhL1hKaWRqZzVTbUFDVmZjWjc3azBJL3VMbklKNzFzbWpO?=
 =?utf-8?B?czYzRXZScmJmejJESnduaXc3dUx2VC8yUUdsUU5CdHlqMXlPQjIwK0NubGFu?=
 =?utf-8?Q?uIUZfft6gKDaCnAMIT0sHXg3V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7a4ee4-9ae4-4214-c3cc-08dd630c4254
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:24:06.1324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuTz6AGEe26dL14G+O0r2jRn7YCNZePx6kz5tk+9aRO09YXlGtKv3+mMwcG7zmRUbNqzuS28uzE6Pl1W16csdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9730

Add the compatible string "nxp,pf9453" for the PF9453 regulator. The PF9453
is similar to the PCA9460 but supports only LDO1, LDO2, LDO_SVNS, and
BUCK[1-4].

Restrict LDO and BUCK numbers for nxp,pf9453 and keep the same restriction
for other compatible strings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change form v3 to v4
- rebase to regualtor/for-next
- last upstream remove LDO5, so remove LDO5 for nxp,pf9453 also.

change from v2 to v3
- LDO_SNVS to LDO-SNVS
---
 .../bindings/regulator/nxp,pca9450-regulator.yaml  | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 7605a05a9eedf..4ffe5c3faea07 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -17,6 +17,9 @@ description: |
   Datasheet is available at
   https://www.nxp.com/docs/en/data-sheet/PCA9450DS.pdf
 
+  Support PF9453, Datasheet is available at
+  https://www.nxp.com/docs/en/data-sheet/PF9453_SDS.pdf
+
 # The valid names for PCA9450 regulator nodes are:
 # BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6,
 # LDO1, LDO2, LDO3, LDO4, LDO5
@@ -30,6 +33,7 @@ properties:
       - nxp,pca9450c
       - nxp,pca9451a
       - nxp,pca9452
+      - nxp,pf9453
 
   reg:
     maxItems: 1
@@ -65,7 +69,7 @@ properties:
         unevaluatedProperties: false
 
     patternProperties:
-      "^LDO[1-4]$":
+      "^LDO([1-4]|-SNVS)$":
         type: object
         $ref: regulator.yaml#
         description:
@@ -118,6 +122,24 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,pf9453
+    then:
+      properties:
+        regulators:
+          patternProperties:
+            "^LDO[3-4]$": false
+            "^BUCK[5-6]$": false
+    else:
+      properties:
+        regulators:
+          properties:
+            LDO-SNVS: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>

-- 
2.34.1


