Return-Path: <linux-kernel+bounces-278084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C3694AAA8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635C91F2188A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006BD8288C;
	Wed,  7 Aug 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hmrQBQQZ"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0DC8172A;
	Wed,  7 Aug 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042343; cv=fail; b=MkJ+5Bi2t0VdcelH/9IwXYKhzMy07elBCWhJE0vZMik0Z/HxO7v0LTWC7YqXW7wPE9rXe1vtZBw/u6qE007+l7wmckqc6EEkrkkVH426p3gvmWJ/OjhY6LZF8mjG0XAO15/zq8LdkHL7lLZTGS8fc6IlSVUR7gxNxXvk8I6Oi2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042343; c=relaxed/simple;
	bh=0hRFFCNzQn3epE2gKtCY4Dnaep18YQXkiTT1e9KP+mE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lRauoWlgksdEcTIrCWd88q7JBwtWaibfvOLTBWYAlKfdgcf8A8bnMdGVRn/6eONAxCQz7OL5GbZsKxid/fwejnAP54ODdVgmfWVyA4K892qaSxW4T6XubApbDrVnoc+IVlJO8MxsQSLrhh+khYt2eq+Pgf3TmcWlBRaaRs65UrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hmrQBQQZ; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvDJIybQ89UhHOAOXKIKoQfXH4kJXjH0fJcDj4b8Hp6Kk6K071SvadG9TzYDfstUtI9c8FmeEyVgRVbub8Jje+Qn4S7bT7kZ6JUdQ4r5nFatcRW4iWAT9EyiAbEx7gzOTQbIVSMDAV0ZLIIBvFxGhnTBJq7HkfFvfamKc1HgZjzyXxD6lbPLLK43Tb4WMwQGQd+2F/1Ucb5pNilvsxtnTOVfKEdBD5OBqlzXUG3Y42nVX31Cgv+JR+ndOmG1x1/y/D3rp9C9TnpMAaDSOqWfz7FltghHcc4iZlsfspA6EKQv2owsxXU7233mzA5pQnAGuOshJQkW2QqarwW7DpLzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxFBOzLjUSUqkpQ7HuTltSjTv5+m7Cn8IDvYJ6lxJm0=;
 b=hN3FeB9+TSgJF75NsgdEpD9fjvEyIjzBveiImIHfYI7MhvY4JceJqAZJ1PNtHgC9gtqcYAsk92IPuuZeBrq5Tt4OeOr+/MaoOMxC5lSjQWtsFpNrykrMEACHPtqu5VBoKNwJ8Wh0+ZEErtkX+W/qDnOE7SA2/H5kn0MF01K9YutjqfvSUUtJWnUFd+QyYwHR0x7oIFo1EyADd31Js+j6lw2pHC4O98aPW5G8O8gMZGDA25zlGi8l4aUsVTtNLZhp2cu/0hKfLoGgUxd9jmFlO5i/oDcJmGOnHvVX7neMU4UFKUXT2p5gHbbpHAvhVd5q+Wrt5Y1ZMhwBmmf80wSyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxFBOzLjUSUqkpQ7HuTltSjTv5+m7Cn8IDvYJ6lxJm0=;
 b=hmrQBQQZS7XQ1HfcucdRmNSAx3VYwipSnku/wx6CUdAVc3veKWiyO+DT0sXXPQBxuD/IpEuwK8+oMEXEmLUE5QRFnRq7iDK6zL+WdDlDQGRz91jsaG+IveyIicXn+d9+hTQNjxwAUivVOhZnLxMNApkcO9Tltaig837PlYfIoOlSbUJX4BU9tW6Ps8iNnjo2stLpmqk8gXlhHDRC3h/F9stib43sYP/yWvR1cRg7Jfv0BDrQ7xZTejeoSaC+y8oByCSsP34/WzgnmRcZiVb6bdK8krb2Scn9d/Lrc8vzco4ZDx8K6zvmpU+rbslsNJVZBpHmRwabI2PzdZTqzGLkTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7113.eurprd04.prod.outlook.com (2603:10a6:10:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 14:52:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 14:52:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 07 Aug 2024 10:52:04 -0400
Subject: [PATCH v2 1/6] arm64: dts: fsl-ls1028a: remove undocumented
 'little-endian' for dspi node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-fsl_dts_warning-v2-1-89e08c38831a@nxp.com>
References: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
In-Reply-To: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723042332; l=1397;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0hRFFCNzQn3epE2gKtCY4Dnaep18YQXkiTT1e9KP+mE=;
 b=h5cOQHFo1h5Gvv0uBDXDqdVPAQ223JP7psUK/dTT58eQiS9sLdw67D/wKN/jBtsUJV3W6Jxum
 DeVyEcmG36/DPGlCZovqh5/U+LH2CYCjhsfPfthD7IM3+oKS6HCXgW/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4b7825-4391-4326-58b8-08dcb6f088b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXBxSDh1aEdjNHpEQStqdTh4b241MXJDVW9kbmxsaXVZREkzUVRyeFBEeHlE?=
 =?utf-8?B?SDBJMU5peXlwZVRvQnd2c1FBbHdHclF5WXYxVzhrVklqdityUDE4M1RIcXlV?=
 =?utf-8?B?N3BTQU8rZklvc3UrLzZBaWNjYS9pVkRudWNnNGN1bUZ2ZXlaSFBUdUNCYVpE?=
 =?utf-8?B?MUdZRHh2dHk2ZG0xY2JyWjhBM1h3OFBDU2h6eGNYU2ZzalQ5VlZQSGRZYi9U?=
 =?utf-8?B?UWxKVFhvckg0Z2l6bTBmZ1BHbUJKT2R1cFNZRFdxVG0zTzQwVEp3T2VtWVFR?=
 =?utf-8?B?M1FnSkwwMmE0SjdUZzBpY25GS2hPSVFUOXZ3KzM3aTkxSGxMRHB3cFZLc3ly?=
 =?utf-8?B?WGhydEJ4dWpZUm9BM0xQcG1ieWJ2TFJlVE5WZmhWZzdsRkQzVjN2WEt2b1ZL?=
 =?utf-8?B?Q09DQ21XWkhNOWU4TEhDYzI5QkltcUFWQzk2WFZXTnlvQTFjUnM4NHZpUEd2?=
 =?utf-8?B?VkhjL2ljOXdndm5QMTBtTXNrWWhJRlk2RlE5QVpxZWJNS1BoeGwrbHU2Rnkz?=
 =?utf-8?B?cFEwK21JOWJNVzBjUWRnalZVcU51bVJ5dGJZR3RUTTUzckJEOUhuZWt5dDR5?=
 =?utf-8?B?TDM2eDRtSXZRTVR5Q3lIbWlsbzlHYkV2eXo5Snp5b3FYY3NIRm4zVG9PRUYv?=
 =?utf-8?B?R3hLQkQzaGQ5dkdtQzBHNWNZb2lTSk11c3QyZHFzaDZuNzhIVS9EQ3pnSk5k?=
 =?utf-8?B?b2kwcU0wbkxoNHNidXFvUUZ2UXovL3ROY1VmMmo4OEZlTHBQN0tYcEtPN2l0?=
 =?utf-8?B?U0pmeXFPdEo5OE0vQk1oM1FPT010a1JRQjg0UUQvYWcraFl3V0NEK0p2RWM1?=
 =?utf-8?B?a1RVVFVodWFWZmN4KzFMdkVobnFoV1F5bVdsek15YVU4ZzFvdmZKbVVEbzFx?=
 =?utf-8?B?UXVXNVBTbzZRTjlock1xSWdNN2ZmQlkrRlAweWllLzIzZ3VnQ1ZzYTdGSGNw?=
 =?utf-8?B?c2VxT2cwejczQlVBMzAzcXA1ZXZrRXlveHlkeVpYYk9PYW02Y3Fqb0hRRE8w?=
 =?utf-8?B?Mms5cWhwQnd5RGsrQ053c1pJYTBtTk8vQkY0b2hFOFowSWtaQkxhaXBMRUVr?=
 =?utf-8?B?eFEwUUNlajZGcWVNNE0waENrckJadVdsSG4zU3NyRzVGQXU0RVFuNHFFNnkz?=
 =?utf-8?B?allqcWluRWJ2RVdMN085T2tzZm5JQzRaUUQ3YnVVYzFYUkZJTEdZKys4eEpG?=
 =?utf-8?B?N2NnR29lcU90SlNURStwaVVHZ3lSOCtoanN6U2RRS3d4eXh4azFaUk5UK2ZI?=
 =?utf-8?B?TkhwR1p0eFR2YktMYVZGcHdHQUU0Ylh4TjJ0MzZpbVRONGJEMjR5NnRCNmVO?=
 =?utf-8?B?MlVteWx2K0RjQXVIcis1YmZkWWRZQ3Nwd3dHSHRTbFlZektjM3NiOHZTWld2?=
 =?utf-8?B?enZlQWhOMnVCY2YvMjNGa21pdnc2bkhXcDNieENsS3hscDM3UXhSdWpwVGh1?=
 =?utf-8?B?SXFxbDcwVXRFZ2lUUnZQTlhPMzBYVy8yR0g2aWNYL3BWSmR1dHhEeTAwMGpT?=
 =?utf-8?B?OGMvMUhzN0JaOVloMytsc1QvZk1yRXRGM0lacnA5WjZIMVlFaEVYT21UYzdF?=
 =?utf-8?B?RDllNktjaFh3WlJ0MUxWaTEydHhyWC84WUVJVmFNSU9TaHFETmQvNHdTTDc0?=
 =?utf-8?B?T3lHTlQwdHllRjR1VTFneHA2emtiK2x6aDdwUEVaQVVrNFZYR2pWeWpMVi8x?=
 =?utf-8?B?ejNwVjRqMGtqOHNxYmFQT3lFOHk0OFNpRE9ISFRwejVtMmJWUlFBOWRiTFk0?=
 =?utf-8?B?bTJMV0Zrc0c4eWFkSnBQcmtYMitPU0pRRzhhLzFqVFZWZWN1akt5amtqSkpi?=
 =?utf-8?Q?d0Ev4HjYfM7aHBWM6/KaomkDzy+PqOLgyWjhA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVNlS3ZSRlVMSlVOSGhNTjNGK0t1THRha2twTU80RndiVW9pZWJJVlVBVU9J?=
 =?utf-8?B?bGRieEFvMFVkYkNXOGQyTCtZcmdrbmxGL1psSm9RTnA3bmI2S013dWVzeUdQ?=
 =?utf-8?B?WmRGOFVLK1RTa0d4Nm90eVF4ZUp3WmIvazhmdXpPUXVRZUhQSTNlSENDRm9E?=
 =?utf-8?B?Z2JNOC9zTExzSEh1SjFNYjBLZnJ4QUNxcTNlV21OQ0EybEtPNDA3NHY5N2hF?=
 =?utf-8?B?VllIWUNjVVRMdi9hVXhGTXcyM0hTRzROb0QzOXd2amhjN2xHRnROdW1UMCtI?=
 =?utf-8?B?MFpNY2QwYVBRbHNSdVIvMEp2WTV0c3NDWFg5MEg5VVhxYkloZVBEdFovU0li?=
 =?utf-8?B?RjhPaVN2Yk00N3h6K2UyWUJvemxRM09UTUZVamJsa1AwL3o2ck9LQU9TZytR?=
 =?utf-8?B?cXZpSXNFZXFqaHRvSGFXUzNrY1V1eThKMDVqeStmTW9MbUpRdFdpb1h4Q2xM?=
 =?utf-8?B?bmE1T2pHUlUzeldmYUthSnlXMTBZYkJuN3NKREFYWjlLQXdseStncStBSHhj?=
 =?utf-8?B?WFN2eTA3KzJnM3NYK0FmQ0dhc3IzZ1g5UEY4Qnp0eWM3L2ZITUkvdHFkU0hC?=
 =?utf-8?B?dEFGQVlLdEluZXpic1h5b1pTQ3EzMTNzRE1FaytLYVFCY3RmV2JhbmkxUFVv?=
 =?utf-8?B?WWN2ZHNveFRDd1FTM2pHS0FYNzVtWjBRUUcvemI3SDR0Qm1uckJLdTBPcGc1?=
 =?utf-8?B?V0U5d2YzbzNpNjBmdkRGNDdRK1RCbDE3Qi8vOXJzVFZxcTlXN2hxalFmcFJB?=
 =?utf-8?B?ZTJGYTVoTDVUbFFKYmY2bVNMMlNPbzBZMEZxMHhYNXZERDBGY0JkZUlVbUZS?=
 =?utf-8?B?MWlwU2puQm0vR1M2NFhyb3RoQVplSkJoeHJBNjlFRlYzaEhYTklNMGV6aVp6?=
 =?utf-8?B?VHY0UGREb1ptNitiK2FRSWdkVlYvY3hSVE8xODZrOTlHRnhmbjEwZ2FIOWZh?=
 =?utf-8?B?RXpaOFdneEp3ZzgwMkU5OFZTdlFQZ0V2QS9QMDFHMEhoUzhHWVFUS2hDNlRK?=
 =?utf-8?B?QTFTM0c0WTdtMkhZWHB0Y1BrNElGYmhJejBDbkhNSDluWVpEZnhrUWRESDRn?=
 =?utf-8?B?Sm1EQ0N2bHVPYjI1bjhqeEVuNkJnZko1NFVxeHNRemx4RnlKYTVDWndUSTB4?=
 =?utf-8?B?eDlsOEtCNFprTEZmQUNFVEdFUko4NjRGbnk1SnE2SEw3bFczR2F4UHRlSTQ2?=
 =?utf-8?B?UDFQYm5IbmMwMURDaEp5eHY4WDVyRktKemh1L0poMllxVjRiZDZyK3RSNFp5?=
 =?utf-8?B?QUxlV2w0emYzQlB0NDdIMDc1NFVwR01rWmJqWHExZ1RnaUlmQVlSUjczaFFJ?=
 =?utf-8?B?UTBvUUhEUmhwVkR3TU51WUg1Sng3NDd3dURVR3J4YUx5TTU4ckxKTnlXclc5?=
 =?utf-8?B?YjNRRnhYUkVkQkxxc1QrbHBUZEVSUUg3ZGxNZGtCMDFPbjJvT2R4YWdySUtj?=
 =?utf-8?B?V0I4ajJWSVVPR1dwMm1JMVdPbEZLYXdhN0ozSFV5d0ZRSWRQNjdocGF4cnpu?=
 =?utf-8?B?dDhHWk8xbHpQVVByejNseVJjNmNuWm9zajY0aWRzR0hiYW9YdjlhS3piNW9Z?=
 =?utf-8?B?M3UrMXE1cFZBdmNVNCtKZmZ4czZ2R3JyWkZIV1NhSWxiQmorS2t2YXhxblNz?=
 =?utf-8?B?RG9WSi81ejdOdU1qYi9UTXhuaXcwelJRQXg1d1VRcXZqYzdhMkkwRy9GMTJV?=
 =?utf-8?B?RG9FRURqTG5QREN1QVFWbjFGOGRHNTBFOVVwZWhrQlVUUjl3K0xIWUNsVFJZ?=
 =?utf-8?B?MkhRbjJtZ3R6N1hnOWJQbHJDaU42OHpuOVBXa1dSZDJqZjFYY1VJclV2K0ZP?=
 =?utf-8?B?THpJMnptbGhKUnBiSTZELzdVa2UrTUx5bGJaSG03NFdOUzJUVVNOU2pPdXM1?=
 =?utf-8?B?a3BFNVJBSllPY2luNW1NeXlKRkhJR0RBUkx5OW82RDJXWFIwdkVBU2haVUhV?=
 =?utf-8?B?c2Z4elpZMjFlbEp4L3JpUFVGc2x4eVJxR3Q0OERnRVRwQ096aThYeTRvQXhZ?=
 =?utf-8?B?NUV3T0s1c2ZWWnlWMEJqcE1aTFVCQWFFQUVHVW9zcWkwMWZQS1FjM3VNcXMw?=
 =?utf-8?B?WUNwZXhpMFdpN0oxRjZodlVlN0hwdjAzcXZXUnNkWkpLODRiUTQyTFVCYlBY?=
 =?utf-8?Q?3fUY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4b7825-4391-4326-58b8-08dcb6f088b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:52:18.2541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzOgnGmZCAY29x/nYI2TBit6ZAwwZSwJ0ucs98mfLyf3ZXTyuQ9PKLA8wylYCfv6mwHZQBNbtt6jShPMGltqBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7113

According to binding doc http://devicetree.org/schemas/spi/fsl,dspi.yaml
and driver drivers/spi/spi-fsl-dspi.c, default is little-endian, should
use big-endian for big-endian system. Remove 'little-endian' to fix below
warning:

arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dtb: spi@2100000: Unevaluated properties are not allowed ('little-endian' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index acf293310f7a0..36e23d7b1676b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -381,7 +381,6 @@ dspi0: spi@2100000 {
 			dmas = <&edma0 0 62>, <&edma0 0 60>;
 			dma-names = "tx", "rx";
 			spi-num-chipselects = <4>;
-			little-endian;
 			status = "disabled";
 		};
 
@@ -397,7 +396,6 @@ dspi1: spi@2110000 {
 			dmas = <&edma0 0 58>, <&edma0 0 56>;
 			dma-names = "tx", "rx";
 			spi-num-chipselects = <4>;
-			little-endian;
 			status = "disabled";
 		};
 
@@ -413,7 +411,6 @@ dspi2: spi@2120000 {
 			dmas = <&edma0 0 54>, <&edma0 0 2>;
 			dma-names = "tx", "rx";
 			spi-num-chipselects = <3>;
-			little-endian;
 			status = "disabled";
 		};
 

-- 
2.34.1


