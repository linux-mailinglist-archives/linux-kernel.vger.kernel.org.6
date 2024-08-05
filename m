Return-Path: <linux-kernel+bounces-274957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC889947EB5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06941C21C79
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72711607AB;
	Mon,  5 Aug 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G6Yu+xe1"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F6E15F3F6;
	Mon,  5 Aug 2024 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873041; cv=fail; b=uhCZ+hgLqgPeJY2gnyY+nIf/QAt03oBVqOKDK9lgBAOUsNnoVwbW4PIfx+Fzu0SEpfkuIrsPqecY4z432xwWQSc5p9jOK6D0ThGkkT8ZRrYQClePOSv5nt4ED2+GNv0roQNxhAGIqGJfpibo8nK/J60bV74xLjkzRD4GiNP8SoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873041; c=relaxed/simple;
	bh=goNn7IcsRUWW3GWFxxPkQJlzDl8KH6mRI5NwFU7XL9c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aGkObJa85U6Cf1lD/qTprdAUXpJqXWpXEjqvvutHseY2dmwUIok6ZXInQYd63cJdHT0iL+I5ktB5p7OMkyYlAIdBFHs/t/wRXx+PkfBn/7ybok08R6Ti50P161z/Sfx5FZonKykxYvOZM0mt9ok5w4VHWwAdCOFGIbehEZewpuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G6Yu+xe1; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWUcX3ikrDQo0KZX3ycA9BUWN+Ij4d+e0YetmnCYN07OKc/dKPMhd3UaBjApkWCcWUEc/cCNyQZSbRljL05es/gkJ9Kod2sZB2IgRt7KhFnt4wfweVV0iil2PBsdsxE3oPc0KPA+6clrnaeH2wvaCY9j+oPED17Ltcb+bom34xDiZrVcdracpnHYClULyYXpHTN2iWBqai24G23XalLI0Zm/CqIDDi65fv58sHQTbjgVwwJILTqC8ptLM6GXEMcSs5D6WbjVbyoI0rmTlFpZotBywovhEpMeCUQO60dmDjGdQG0rpuyC0TUhzekB1qaN9PJsgh3ZeCcDkyWS7o8GaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je8QbsL1l73c3oVQtk/Ivn4IGIMwC/JN6CLbtcePtqw=;
 b=U797g9ssr0I6foCUgxY4+gYHeSO9tK3wUIRRwnDzjxiC99YTs2xQvPwnydjTILwe5H+EFxS46CFNITQtleCXgGSxXG6jOTRyhXdIr2XfIKqgo4aXFX88xIJT4DLCzNcfXiTSKepzQ1wRS4UMvWqAzS5XRC8N4yHcTnLomgU6FjRKPAkKXHrleANGqwdRsaHAd/Ep4WXzYbBFnk2+KKHBxN3y5/6z/VSwj1DiU92mhnnCNx1a+snSbxXS9sdM2Pqiwf5Dp4KNm6VWEpeoUofswN8aTNG558YPV2MqkQLj3FUZSOAFgN9W3lX3Uz+A4Zje/sTWO8pjhuXJflrAiqILyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je8QbsL1l73c3oVQtk/Ivn4IGIMwC/JN6CLbtcePtqw=;
 b=G6Yu+xe1blHoBWQnP9l57/xB6sN3Io+kuasf1YiAPa/cO9vUNvNXj0DybPRrfEXD6e7QC5ADzHqG+ABrs042Yivdie5lNQvMLnf6lCly5DY4FtsrVKqp9T7pwl6h8HkUxLGLL6W6P2UgLrt5kQcW2pRHB8OKAPk3RTQ0DekhePTxFJ3nd/YH1JHPFTxi1fL7I7Vu72dQzZuy8rwEj1lDVEygjiTKmjDu/XHEC3mfboz/Aub5DbUZclkBIPpwqtS/i0VLryZbBZMjPasAC0BNGOf+kVx7lRyO/COEmBaLxsHu/NH8BG03f71kTGnNOsrf14KHsDvNZDUa+E63RQxrEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:50:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:50:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Aug 2024 11:49:51 -0400
Subject: [PATCH 9/9] arm64: dts: imx8mm-phygate: fix typo pinctrcl-0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-fsl_dts_warning-v1-9-055653dd5c96@nxp.com>
References: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
In-Reply-To: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722873011; l=1777;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=goNn7IcsRUWW3GWFxxPkQJlzDl8KH6mRI5NwFU7XL9c=;
 b=k8aywbKAEx3UfzxigYVBdJI9Ll0Ze2lCjD2Dsyfwvjyn3XBO3CndcaA3FSxyFZNfs9iOCmCUw
 eif3GLSjZ7BDztzZZz08jLhKIQCv2jyEYzn//vWqRK/zqrl/6lXrflh
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:806:27::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: 4820a1d7-9078-4d29-b509-08dcb56656e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHlaMDBIRDBWYWJzYVRrK1VNYlUrS1lDYUVtRHc3T3d4TTZ5YlplejNXSVBR?=
 =?utf-8?B?V05kNDFFc0lPeXpOTjkvMCtPNVExZ2lwNXdzRUVJWWRUU01BRkV0U3NkdE1m?=
 =?utf-8?B?eXgxMW55OThCR0N0VFRmdStJeVhkYjVBbVlReTkvdmVQNVB2a2VNaEdUTHFZ?=
 =?utf-8?B?aE1zSW5acTArODVlZkxUN0FoSTZRbS9KS3U1R2NIbmlkN3VmQU1nd3BBT1Nr?=
 =?utf-8?B?YXdhM01CcCsrMmNUQ21RWFFpTStFcUVLcnNzQXd6VkVEbDZVZmlJZ2tycHll?=
 =?utf-8?B?TENBY3ZRMGJPZVJyaC9PK1p2ZTNYVVZvYUdiMzgzU3VSaHZzV1RtNTBDM3NT?=
 =?utf-8?B?QU4rSloxQkcyMkw2REFzajVPRjI4aXg2WDNxRXFuVzZPMUtJVVcyc1Y4RUVj?=
 =?utf-8?B?OEptZVJUait2d3dCZng4K0NQK1VONzArN3owWU1RM0xpZVZIT1lVZXpzZy9w?=
 =?utf-8?B?Q2hVV1JaTFRXZ1htQVYvbjh1SzJBa1NjNWpuWmhOQzhhY0g1Y3JjTDRwM0ov?=
 =?utf-8?B?c0pFb2NXNHc0U2NhUjRvNEVGcGRQNWVLYXlOa3lzSGxldTFRWTdMbkRCQnM1?=
 =?utf-8?B?dGdnYzRoVGJYMjlFTUJMQWtDeTVLcCtGYjI3OTlGSzYxVFUzcUo1dkZ5TmU1?=
 =?utf-8?B?WVNKMlA1T0dGYitxN2tnTGdBblAzTGU2b1d5SG5rZ05ydHg0UmJpM0ptNWRy?=
 =?utf-8?B?ZlFRMU5rV0JJOTZhQkNKUERqUEo0M2g4eGI5MzEwUVRudVZBV0lGdE81T0ox?=
 =?utf-8?B?U3M1ODkvS0pHWktYaFFwbDdQUFRua2tsanBUVkJsbW9TOVZ6d1N4Zno5UUpl?=
 =?utf-8?B?Mk5nbEIwbFlZMlZLOUkvLzkvT3VnQ0ZENGJYb3JPdy9JRUlIbmtGM0Fqb0pH?=
 =?utf-8?B?U1BtTEZZaUVob1FJM0E3dUZRV3E0T3NkMTE0NGhNN1FqdVNrcHl5MDVIVmFC?=
 =?utf-8?B?Tk93UmxKanAySi9La0tlcldnVnZscnNkYi9wbGhkWlZoUEx0ZVVqWmpwL3JP?=
 =?utf-8?B?bEliSE43VG5YT1BUUzA2WWxTaGE3REx6MEJXNkFjb3Z1eEt3TG1zUFQvWHFY?=
 =?utf-8?B?NWxDSXRhZUVlbVU1TEw2Sk16Uis2alY0c0RyQnYvZ0F0RnJHSkp4bzEwcEJ4?=
 =?utf-8?B?ckkxNUVUMFR5NFJRdExKcFRuZjdVNW13WkNLTDArODdaY0ZYTEdGTXJCd0Vl?=
 =?utf-8?B?dFVubEZabGo1ajdZMEZIRTNudVVBZ2NOME5JNUJRN0VLTXNjQ09hU2NtQ21I?=
 =?utf-8?B?YTJKMWx3ek4xRUs4L0pwOE5mQUNxbmJlMVdHaXlvTnJCczI2Zjh6c2x4N0dy?=
 =?utf-8?B?RXRQYWpHZW14MG00b1Q4anB2TnQ2eHM2NFhYMU8vZ2g2eUlxSVRtcnl0ZTlG?=
 =?utf-8?B?d3A1bndva0lUTjYrb3VYWGRTYndJVGZhdEpIQlovMlVYOE05dVdpNlNqV3d1?=
 =?utf-8?B?RW9DUjhxR2t1bUpzSENVeEtFT0dJLy9Yd0ZVblVtSUhUQzNPL1hCZUMvUTZy?=
 =?utf-8?B?VWlGdlNtbVRvWG5zN0NNcjVQZmQwWGpybkllNGRsUUVyVUQyRTFaWm1sQTBJ?=
 =?utf-8?B?VjI4YW10WFh4bm51aE81YVAvamJBdHc0eDVOb3hNdjVZMlhuQWtJTWp2TWpI?=
 =?utf-8?B?eUl3aFR6dDZRN0tUd1JhTC9DTHlBTkZUdmtGVlJlY1BXQnRQOEMrc0IvVDRT?=
 =?utf-8?B?UmpySEJHNFVoT0NHcFJnV05ZK3MycWoyVDYwUnUxc1NqWjE0Uysxb1Y0YjBO?=
 =?utf-8?B?Z01aZGhPYjJEZ1VTSDZ3Q0NpQUtraGRXZ2VFQmhQSWtzYldtbDQ1Q2d1VnBz?=
 =?utf-8?Q?0DRZ/giolt5DJwI1/uYeS0vPRaCO5SlXGCaFg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlQvcGxlZW4rdFdoOUdYZkEwcE1YdHV4VXZvRGJPZGs4dFprYjZ6UXV6SFFn?=
 =?utf-8?B?N2VYTU01K0hRdG1HM3IzdGxaL3dvT09LN1hPVFFKVmxpT2E2WWhReS83ZHJF?=
 =?utf-8?B?UFhQeEQxNVJvUE4yOW5pb2t2Q0padEhWbGdPdmpKNFVkMmdzZXVyZmU3MUw4?=
 =?utf-8?B?a1pJY3ArYkhHMExyZEpJS3VqRDNjalJETUNneHNmRUl2aG5CMkh2dFV3Z0Zv?=
 =?utf-8?B?UTMyTUhPT1lvL0lkVitXYzBjNktRQkFscCtseVRueUUxeEc5bTFxRkZUeEZG?=
 =?utf-8?B?RVpSMWlDSWpTaWg3anFwdlZRZC84b3I3MFpVVUgyYVY1Y0JmOGpIVTBCdks1?=
 =?utf-8?B?QzBCcmpaTmtVa1NKbWowdmxXR3JEVEY3RVBlV1lXbTU3YU1ySyszaDlSUndv?=
 =?utf-8?B?MzhWSnZYWHViWm1CQUF1eG45Mnh4bEc3eEZWTkN1a3J3U3VYSllrLzlpaGdS?=
 =?utf-8?B?OHd5eVpCbmRGTUVTZ2VCMDJ1OUJuWlFkdythMzlXZFc0V1pYRXNkeXdYMDNH?=
 =?utf-8?B?WFo2Q1VzTFc4NEUxL2FKZTFCblhwT3dXeUpIUEZjUFhVbFN0NGtHVXBldFFs?=
 =?utf-8?B?cFN2SnprZnYvYjJCVEFmNXM1b2UrN0lTR0dvWENCVmRlOVYxWTFzR2ZJaDBn?=
 =?utf-8?B?VklQSFVpSXl5cHFzWnRYTUFqTFg2ZkZNakNvaGh2QXZRS0Y3ZnlaSlRhZjkr?=
 =?utf-8?B?c2szNzRqKzBiL0k3VEdpVElMUUl0ZHJjdmcwcGlsOUJTMUl1K2pqWGdwNzF4?=
 =?utf-8?B?bW9tRTlTamRuejNZVVBrNU5McjFUbTB4elM5WU1tMGpaUnBaTklYNk16Z2hL?=
 =?utf-8?B?ZXFqUDNPYzFMT0pSL1lLR0g5TTdwbmgrbHc2WjNMdXJsMmRJeGE3WUxMNWdo?=
 =?utf-8?B?d1RVbCtNNktrZFdZeXRoMzJtdVNacVFPdEd0dFhrZG1EQmJjQ2pIL1h0S25M?=
 =?utf-8?B?T0RFbGJTaTNKVXR0TU9DaVFNQm9NeHVyNWI2OW4zRmUvS3VyeTF3SFE0VjVB?=
 =?utf-8?B?Uk5EeTRWMjZMZE0rSVJDUWFEVmN5a1ZoMG50eGNkUEdEaG9ickVxeUF5WnB0?=
 =?utf-8?B?V25sTlVIVkpFWGZGNG9WUGJvSEVpaDZkU2NjenQ3T3hIQkVreUFpbEtKU1Rr?=
 =?utf-8?B?Q21DTjhUWXFxVzBObWdNaHdVWWtFdGEreG81QmcvbXlFUXJPSW5tYi8xeXhX?=
 =?utf-8?B?NHBTK2docU4xT0pmR2Z6Q0VrZWRqTFp1NDVMTkI4aU8zSTFPQ2hXd1E5Y2Fl?=
 =?utf-8?B?Rm94SzI2Z3dZVThWN3lEdmxMSzJqR3ZGaEtSYmZvOVl5aE03bHhubXZoYWtZ?=
 =?utf-8?B?UmREYS92TG1idnFlMGU4N2VxaW90a1BSSkdxNnpTSWxGN2d1NVhMSEhzLzYx?=
 =?utf-8?B?YXZlaHg1OC9zYnFDU2FoL2RiZE5LaHljeVNXOE5GbUExQjV6elc4RGlZeExt?=
 =?utf-8?B?WGNVOEIrOC8xVnNCRnBTaU1UanNZcDFUTy92T1hLaHkra3ZaOCt2VGhJY1dn?=
 =?utf-8?B?cyttVTU2bytlVWs5MkhiUHJ2SG9XZ0FuQmFUVEc1S0ZHaXZSTWJkei96TEFH?=
 =?utf-8?B?NUlYU0pNUzE5K0ZjeG5ycHhQaXdiYjRRaDZYKzJwRVgzd0JZL0tLbUFkZy91?=
 =?utf-8?B?UWtRMFNROFYwTlZjSW42dm9qK1o1QjZHWTZESXpPMUMxQ1MwQzdDblJqYnhJ?=
 =?utf-8?B?Z1d3V0RaaHJQL0txYkVJMGRnVXpDRDE4MmlobGRMcmZIWTFiNTlsV1lMZjFC?=
 =?utf-8?B?K1E1L0x1dGhlWG44M2lRSHMwSzBNSTZLejZRdENlZjkyb0hXWUZIQUdkKzRB?=
 =?utf-8?B?dDJFc29iK0I5STJkTUxuMnd1RzVrWDl4dU83VW1XNEh5RkdOaEg4emc3Uzh3?=
 =?utf-8?B?VS93bDN1M3FEYmsvaC9Tb0JHdW1lOHA3SmIyRFlSOVJRM2xFeFlhQWxLMXNy?=
 =?utf-8?B?V083a3IrWTl2OXpQNXpJSVFsSHkvQlRKQ09YK0pqV0ZRTXhZdjFCWTgxaGw4?=
 =?utf-8?B?V2lBUnpPbWVZb2xTbXdKMWU0U1lqUm5oREZSQ3hsZ2NUNyszdWFaMEkvQVkr?=
 =?utf-8?B?WUR2QlJmek9rcUJHUHBsZVdSMi9CanlsUzUzVTdCakpBYkZmS2pMZ0VUNWZI?=
 =?utf-8?Q?oIa3ZUmaLGr7Sp007BfGUYuKg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4820a1d7-9078-4d29-b509-08dcb56656e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:50:32.9741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7MczZI1PmLzXqmT+G2MIr/thyHT/tHmuVBUcIwywDQSVnDOGAstb9pMl7pY6HuwUpr6HANLD6BrBLzcLBaFuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Fix typo pinctrcl-0 with pinctrl-0.
Fix below warning:

arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtb: gpio@30220000: 'pinctrl-0' is a dependency of 'pinctrl-names'
        from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtb: uart4_rs485_en: $nodename:0: 'uart4_rs485_en' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
index f246b0ba6af29..ce197266262a5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
@@ -22,7 +22,7 @@
 
 &gpio3 {
 	pinctrl-names = "default";
-	pinctrcl-0 = <&pinctrl_gpio3_hog>;
+	pinctrl-0 = <&pinctrl_gpio3_hog>;
 
 	uart4_rs485_en {
 		gpio-hog;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
index 67508ca14276f..f2a7811f1b9f2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
@@ -23,7 +23,7 @@
 
 &gpio3 {
 	pinctrl-names = "default";
-	pinctrcl-0 = <&pinctrl_gpio3_hog>;
+	pinctrl-0 = <&pinctrl_gpio3_hog>;
 
 	uart4_rs485_en {
 		gpio-hog;

-- 
2.34.1


