Return-Path: <linux-kernel+bounces-242594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64843928A3F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAD4284044
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A32C15F41D;
	Fri,  5 Jul 2024 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LU3TBWDb"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AE515B14D;
	Fri,  5 Jul 2024 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187763; cv=fail; b=uQUJP5Rc/2i4S0ryh9obXsm0m6efr7w0dNgDRkw9GCKJvhLoCiwsHpu+168co5QQ+cOVeBZ/4eeW0/+5nZ6mQn3MKW1+M9QfN3JELhI6tJTp8x90Cf8aWsWbHTXEE8q7omh6eVjhUdU/LpfXCqdCB8q906xgAMNggOBZlGl+DsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187763; c=relaxed/simple;
	bh=FwHu8HOgjdeesS4jBLvkey7Y+WnnBYkcgUp1hGR75ZU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pUgSNbgCQm+FjpnTeDC/Isz/MHpdSzyiZHLo6RecLr1bOYnyaYMFRFLId1Ac7VE104rOA2xz0vHJ9Ke0M3Ae6EUD2IXFJ+4NpjdCcHA4hU47OrhgyEGS/aZzY9qU6FmAzURdF17kBEXeNNz+VL3w0PWJW79X3zOuZuWEi6kP4Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LU3TBWDb; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQ8r/4o0AE2oj0GRqOqbd8ibUuBVtnG1JJlQuqxR3YFbxYWxF1ZW0zeVo+EFx2/nO/DnjUpXSuOcwEU38fXHtFEbq4PaqTa3tC82WagDMBcMd+IFPstMEBvTmp+iwoFy+WSGiTd1DHItsf1aT+vrzJQmnBO7arxe8CjlWXSiK8d4CWbPkQNziwRhxYvschhg30tG8i99A1YiGJXljDgpFAleWRAvCJX1OORy6sK5jJuVd0RLz9efPpaZ9wKyHz7lJreI9xq/8oEuKso5eH0JuJ22Et+odqXOOOOtutUi2NpvdXeE6sPsfet4JTCVsWeWHztLe78LSiJNSaQadsqj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rydjPSyjFpE1b+KVUJhSPw9jPLhoKfIzwxtGoWGJhg4=;
 b=IDmwkJw8Zc8X22yQbLtCTXSEzMUXVt5IwpfUM3XbBP8CmSZvyLFfep+JvCEoBP64WKp1w4Bb8b+yVtsPuQJ8PQcBJlxgKIH+DUtaLTov7n6JQzZUUqcuLnaIddAuD30tBi+vGI/UPawrzjKEuTgrqcr55dUhmBdycA6LPiD7kN8AvjI7abymUWs9DH65UT5mTB1VL5ZRhTc7GRRw83FXMZnizh9qshh/uLj2G1tR6va3nZAMAO0mMIGB9Eosfh0nng9uJixrZiRPWnWQ5NpCKyAw0KsNNLb++nI3rvqrjby9U/SGh0bhmtN9faPhRNQM1uGi5OUcXjkvIjaBb9DAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rydjPSyjFpE1b+KVUJhSPw9jPLhoKfIzwxtGoWGJhg4=;
 b=LU3TBWDb8Y5u/QXYLv+fICSidhWzp6ain225H0u/V0usrTM7Wx66V9CqxV916wEHV7y7U6GSudMKjNxWrJgmHFLOMoxhVE2zgDtOot788zFtNCUPUl7Dv/jDZ8qM38oY/o5htMymSvJA7WFeC48eYuiEiOOIb1awf4YLwYqxQNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB9PR04MB9260.eurprd04.prod.outlook.com (2603:10a6:10:370::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 13:55:57 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7741.030; Fri, 5 Jul 2024
 13:55:57 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Fri, 05 Jul 2024 19:22:40 +0530
Subject: [PATCH v4 1/5] Documentation/firmware: add imx/se to
 other_interfaces
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-imx-se-if-v4-1-52d000e18a1d@nxp.com>
References: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
In-Reply-To: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720187574; l=6679;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=FwHu8HOgjdeesS4jBLvkey7Y+WnnBYkcgUp1hGR75ZU=;
 b=R9/0YCYU174roB+f20ugHh4UxZ1oK0oPF5gsNoQfv+uPZP0ubuzwYTgV3rz+i5HseFWwbAUiR
 BCU3h1oV+00DPD1jphwaGxvhXpZIDLg2n/DlHDaGF/NyAPH/Y9rhpUp
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB9PR04MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 487f3743-d422-4e52-ccef-08dc9cfa31f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmdEeGo5YjVWTFdvQnczRVQyMUtxODh0SkJlMkZObWV1UDV6cS9PMUJUSjNQ?=
 =?utf-8?B?QnpTMjRnT0hna2Jna2NaOTg1dHpmYkZwNHQ1L3QwbTVyb254bDJ0YTMydjl3?=
 =?utf-8?B?bjMyWWlvNlFwSXIva1F5a3dIb1U4Q0N4N0NVOTFia01wVlJvWVpmNEhZQlhu?=
 =?utf-8?B?bHFyWS9IdnFKeTk4dVorQ1VjK05VVUpueStJb0R4dlVpZVdWbVVtVkVYTVRJ?=
 =?utf-8?B?dDM5cTJhRTdrU1VNVG1Rc09qNE5LQ1lVb1VQb3lBTURzTm8zV3FNN0k5SFR2?=
 =?utf-8?B?Ky82czRVU1NFclZwQkUyOUhNU3IwMFN1eUdRRWhjWFhWMXRTNG4wMUJqbmkz?=
 =?utf-8?B?QVc1dXROM2NRZFNmd2UyV0pzNVB1bkc5SmVJdjNUa0dUajd1RG1xcXBWcGJY?=
 =?utf-8?B?Q1BlZ2d4bURXNm5XUnhiZ1g0N0Zma21idTc1N3ZVMEVvWitoRmhoTDJGclNh?=
 =?utf-8?B?Zk5SRXo5b21iWXVERGpmbzFDdmprOFFNanVpOENtUnJnUENKQUd4UFh1YVV6?=
 =?utf-8?B?dHZSeS9KNUlOL3NUdG45Q255Sk5hdmhubUc3QlJqTGlPVGszaUpoaHFYWkpW?=
 =?utf-8?B?RWUwWW9DUVNFYlI1L2t6S0I3M3I0eGJXL2h5ZTZnUkJQS1BGNjZVWTU4Z1Fp?=
 =?utf-8?B?a0ZmdE04cFgzY1cxY05odTAvRDU1L2hQVmZOYk85enJoQjRTMzdnRlBaaFRK?=
 =?utf-8?B?N1YrRXlsU0g3eSsvRkVtc0dEU1p6WmFrNHFmQzRueVhMWmp4dnZDRzU0K1BH?=
 =?utf-8?B?b0lIbkZJaEdpRVlhbkFpUHhPeXloVzhBakRCUlBsN0ZaQldOOTVSK0ZTVXR5?=
 =?utf-8?B?ZHdqVU1NOGZCRWF1V24rbkRwZVRoQW1Ib1hJY3JrQ0ZZQzNSeHZKOVlQbXJY?=
 =?utf-8?B?bVdIQlJjcjlWWUhSdUx6ekJyTW1ta2tWclVJaDRuNlBGblhHQUdHSGF5Y0Fw?=
 =?utf-8?B?Y3BNak9hNE43Zk5uUGxzLzZILzBScE5oUHlvdS9aSmlTVUVDd00wVXJMQ2JR?=
 =?utf-8?B?SjlJRGt1QnNmTDVvQXFDMTdKdE1DT1BONXpZUlJkdXVDbHhPUHliYXNCVEZk?=
 =?utf-8?B?b0w3YXczVXJnUUUyTGxwemRJa2RwVGpoU2hjSUVBbXpINU5RWHEzUlNRRkxu?=
 =?utf-8?B?VTdXT3htUGZ0Wm9PN3gyN0pwSzRkdXQ2RFpYUHBDR2JkUjBBaTluNjJrbTdh?=
 =?utf-8?B?bDBEMDJwSGM2cFdJZ0IzV0NaSVhBKzBaRGpRQ2kzTUUycHZTUTV2dGVWV2Ro?=
 =?utf-8?B?cDlSRlJ4MW5LOE00WDRUVUZ5bVNod1F6R0l5V05aaytYN1BDSmV5eUNNdWlR?=
 =?utf-8?B?QitWbkthNVBTWFBZNGtnVlMvUHhNYUpGcmQxOTVDeEFVM001ZDd4SHVVd3M0?=
 =?utf-8?B?WkJuRXlTa2U3NXdybG5POXh3VTlSNUo3MUhKWXpXNk9hY3E0YzQxVUdodlpE?=
 =?utf-8?B?SFkxdEZVdk9TUGd2WVlmSk0xdWJ4SE9aaU92bGtzTi9OczVRNlN1M2ZUY1lz?=
 =?utf-8?B?bjNNbDgvSXdaT1pjMDRRT1VES3VScmpybjZSWXpLbFVJSWFmMUUvN3I1UHFU?=
 =?utf-8?B?STI0Yzdzb3hkaEsrY1Z4SEpRNzJOcm02VG55ZExCNzdaUkJPRm0rOEsrQkFS?=
 =?utf-8?B?b3N3QTJmQkh6emtIci9DUHllZzVZRUZJcSsyTWRtU3FyeGoxNEZQMlBuamRC?=
 =?utf-8?B?UmJQcnpkSTRPK01QMVFmdWxNNnZQbU1QYU9kelVHOGFBamdlOU9pQTM2c2sz?=
 =?utf-8?B?R2pTQjNjU3lrYlhrME9kUjg2MHJtWjRLYm8ydzZ0N1JMZFRWcXhFR1pkNkl1?=
 =?utf-8?B?T0lucWIzZk1YRGpFNGhKTFZJenZWdGRQWXFsdDlPVWc3WVdjZ3IrZWYzaGwr?=
 =?utf-8?B?ODl4c3YwV1QrOHE2dmdva3FFUGcxdnR6YVdMQlZ4eXZ4T1lWVXdnRnFId3pS?=
 =?utf-8?Q?kK0iNuMaxIU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmJlOXNQZ25YL0M3UVlVYXZ0VVlRdytkMjBjNW9qaGp1N1c1V0g5V0dELzVl?=
 =?utf-8?B?U1E0Z1Q1ZVFNYVNjZ1N3bjF0L1h2Q21vUjUycHNhNnlWOGM5SDNDMVZ2cW9x?=
 =?utf-8?B?eUQ2djFiUlZXQy91ZW9QRzNUdnNlUFp4R2R3T0w3d0graUtTQkxlYkp6bU5W?=
 =?utf-8?B?ZmdsTnFtSDA0ZUFXb2lVaTE5WWNEQWhnbjZ0TUl4bG8waU9OWEZVWG1rM2FN?=
 =?utf-8?B?dkVMcm1rU012c1ZWTnQ0NUxDWmtGeGl2VWFUR0Y1d0lKVTVNYlNDOTV5L3do?=
 =?utf-8?B?MUhpamZpQzdVS09uQnR6cGQyb21MT3RwOFd0c3p5KzRpanRqWTJtazA5ZzhZ?=
 =?utf-8?B?Q3FuaEVoL0I0cTZQYndCNVA3WUgxdkpCa0kwN0lMNGhnb3hiZDgrSUJyb2pa?=
 =?utf-8?B?UXZkNExIYXFCSEEvQzdCL0ptbWJuTlJ0N3ZaOFlhcXFwWUxaY0lnOUJmZEJk?=
 =?utf-8?B?L0U1eUlvdXJTWm0vZVplZTFqMFBlZ0VOREw4ZEhITC9FcisvZGVrc3dSSUgv?=
 =?utf-8?B?T1U4UUh2TlVCc3NUejFHdkNINGIvRW84K3UyL2tlQTFtUkdJR2kwRHhOeCs2?=
 =?utf-8?B?aWdOWE5PZFpsL1lpRWRtSkpnNzNuZk9XdkQzT1B4N3BqWFBrcFdIalRlbHlj?=
 =?utf-8?B?MXZTZXJEZzd0NUtwbzRoN1JBcUNQdjlmMERPVE1rRW9tTGwvR1hBOEd3ZjVQ?=
 =?utf-8?B?MFplUjk3YXlBV2lqTTZXcG9qRzVhWG01M2Q3TjlPbTJnVjFXbjI4ME1GY3hL?=
 =?utf-8?B?QTB0ZnpWbWNreXE3Uk92UWRCS2tPdjIvc00vRXZGcExoZERGdnZYdTVnbXow?=
 =?utf-8?B?akhmM2dQWVZqY0VaN3lSb1VlWkNEcENNNGtKMVIrdGp6Q01NZVUxbTk1Ylg2?=
 =?utf-8?B?VForeU8zOCtKcXNEbkdEbzA3MnFnUGV6aGFHcENCYkl1YlV6K2Z1bGdaQmor?=
 =?utf-8?B?ZEVzR0pVbUFmd3FiWlVUNmRrSlpuMWlwYWxZQmw0NXZYSlZmQ0Rqd09hWkM0?=
 =?utf-8?B?ZWxVOXpPeml6MFRPKysrS0FWWHRScVZ2WkFvbk9UTUFEMW05cUZDc0YvYys0?=
 =?utf-8?B?NG13T3N5QTdNb3poRE9ONTNNK3JWWDkzMTZOd0J6UHpSaWJSMzA4VHpjdHZs?=
 =?utf-8?B?R1Z5V25HSFovZi9zTjNndWNTL01WVkJ3WVdwT01pZE1MZFNsdTVvQnRzWk5h?=
 =?utf-8?B?eW5IRGZISHYwR2U1TWlSbko1S3JyR09HcWhFeE9QdWFlWnJDVHVxZmgzUmNS?=
 =?utf-8?B?c2ZrYnpGMWRFOThwNWVnMEVPc25KK3NzeGo0bGFIMXVJMEFzNWhTdk5BOStw?=
 =?utf-8?B?d1VXMTRGL2JOUDB0by92NGY0ZTVpelJ0MmVVTGVydTlRQTN4N2dVeEdtOTda?=
 =?utf-8?B?RXBXYStWdXkwcXNQYmJLWjFUQm9Uek9jcHpIWlluWiszWjhoMStSWXBnSGdZ?=
 =?utf-8?B?NGJPNEhDeFhCTU82aklXTm9YdGk5RU16NGRJRFcwVlZ3NGFERlVOODdFQnVm?=
 =?utf-8?B?d3R1bFU4NUVoTEVsOXZqNzBnRHhrRy9oZUhrWUtOS0VjS3lVZi9HZzYxb2lv?=
 =?utf-8?B?ZGJFWW0wYU5HZ2ZVU3lHRWtkd2pTN3djclFWcEZwd0NHMzAzQklETkxjTUFP?=
 =?utf-8?B?aDloTjV6NFdBQ0s4amc5eFRyUGcxNGhBWkhrZ2ZNaTVyZm1RVkVTUjl2eERp?=
 =?utf-8?B?eWIyN0I2VCt5OE9vcnA1aGZYMEsvdkNkcDRJamtQU1lPKzJWTVFNMFpZWXVF?=
 =?utf-8?B?NVZDeGl0Z25pZXRWSlYxVzREWEpNeEpNL0ppYm5jdXJDbGttZ3NGd1BOUDlz?=
 =?utf-8?B?elVObDJaQ0lMUUh3NXM2K1VXNDhCb21TRE5PN2oraU5JTUp5c0tKMGl3VUdB?=
 =?utf-8?B?cnFsWGtPNkdaWFdaak5ZZ1ArdnQ4MHphTWxpQSswZ0hYV2F1eXhnakxUdHFw?=
 =?utf-8?B?V1djeTRadnBwaHJtdEVRWFl3aEZ2bFFWZHdhaDlTdXc0RTByQTUxcU8wcDgv?=
 =?utf-8?B?U0FQVjd4U1F2V0RPQ3VuNXlzb1lyeTdsbnAzUm1PZ3RuUlFKMVgxT0pBOU9C?=
 =?utf-8?B?WThndG9rZDJFNWowczA5aWszLy9XWnBPY09RdXFIbmExempuRWZFQXcxWVhT?=
 =?utf-8?Q?Y+/p/Kglz7kfZrLoysyLvNDv6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487f3743-d422-4e52-ccef-08dc9cfa31f5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:55:57.4484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9etNok/Bz7RiQX0bvCYjvPJYnE/5I+jt5/QZePiqW8q7OexgLqeW3yCTfvR+ALIfxmubb0hcwbYTshkrW285Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9260

Documents i.MX SoC's Service layer and C_DEV driver for selected SoC(s)
that contains the NXP hardware IP(s) for Secure Enclaves(se) like:
- NXP EdgeLock Enclave on i.MX93 & i.MX8ULP

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../driver-api/firmware/other_interfaces.rst       | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index 06ac89adaafb..a3a95b54a174 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -49,3 +49,124 @@ of the requests on to a secure monitor (EL3).
 
 .. kernel-doc:: drivers/firmware/stratix10-svc.c
    :export:
+
+NXP Secure Enclave Firmware Interface
+=====================================
+
+Introduction
+------------
+The NXP's i.MX HW IP like EdgeLock Enclave, V2X etc., creates an embedded secure
+enclave within the SoC boundary to enable features like
+ - Hardware Security Module (HSM)
+ - Security Hardware Extension (SHE)
+ - Vehicular to Anything (V2X)
+
+Each of the above feature is enabled through dedicated NXP H/W IP on the SoC.
+On a single SoC, multiple hardware IP (or can say more than one secure enclave)
+can exist.
+
+NXP SoCs enabled with the such secure enclaves(SEs) IPs are:
+i.MX93, i.MX8ULP
+
+To communicate with one or more co-existing SE(s) on SoC, there is/are dedicated
+messaging units(MU) per SE. Each co-existing SE can have one or multiple exclusive
+MUs, dedicated to itself. None of the MU is shared between two SEs.
+Communication of the MU is realized using the Linux mailbox driver.
+
+NXP Secure Enclave(SE) Interface
+--------------------------------
+Although MU(s) is/are not shared between SE(s). But for SoC like i.MX95 which has
+multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE(s) and their interfaces 'se-if'
+that is/are dedicated to a particular SE will be enumerated and provisioned using the
+single compatible node("fsl,imx95-se").
+
+Each 'se-if' comprise of twp layers:
+- (C_DEV Layer) User-Space software-access interface.
+- (Service Layer) OS-level software-access interface.
+
+   +--------------------------------------------+
+   |            Character Device(C_DEV)         |
+   |                                            |
+   |   +---------+ +---------+     +---------+  |
+   |   | misc #1 | | misc #2 | ... | misc #n |  |
+   |   |  dev    | |  dev    |     | dev     |  |
+   |   +---------+ +---------+     +---------+  |
+   |        +-------------------------+         |
+   |        | Misc. Dev Synchr. Logic |         |
+   |        +-------------------------+         |
+   |                                            |
+   +--------------------------------------------+
+
+   +--------------------------------------------+
+   |               Service Layer                |
+   |                                            |
+   |      +-----------------------------+       |
+   |      | Message Serialization Logic |       |
+   |      +-----------------------------+       |
+   |          +---------------+                 |
+   |          |  imx-mailbox  |                 |
+   |          |   mailbox.c   |                 |
+   |          +---------------+                 |
+   |                                            |
+   +--------------------------------------------+
+
+- service layer:
+  This layer is responsible for ensuring the communication protocol that is defined
+  for communication with firmware.
+
+  FW Communication protocol ensures two things:
+  - Serializing the messages to be sent over an MU.
+
+  - FW can handle one command message at a time.
+
+- c_dev:
+  This layer offers character device contexts, created as '/dev/<se>_mux_chx'.
+  Using these multiple device contexts that are getting multiplexed over a single MU,
+  userspace application(s) can call fops like write/read to send the command message,
+  and read back the command response message to/from Firmware.
+  fops like read & write use the above defined service layer API(s) to communicate with
+  Firmware.
+
+  Misc-device(/dev/<se>_mux_chn) synchronization protocol:
+
+                                Non-Secure               +   Secure
+                                                         |
+                                                         |
+                  +---------+      +-------------+       |
+                  | se_fw.c +<---->+imx-mailbox.c|       |
+                  |         |      |  mailbox.c  +<-->+------+    +------+
+                  +---+-----+      +-------------+    | MU X +<-->+ ELE |
+                      |                               +------+    +------+
+                      +----------------+                 |
+                      |                |                 |
+                      v                v                 |
+                  logical           logical              |
+                  receiver          waiter               |
+                     +                 +                 |
+                     |                 |                 |
+                     |                 |                 |
+                     |            +----+------+          |
+                     |            |           |          |
+                     |            |           |          |
+              device_ctx     device_ctx     device_ctx   |
+                                                         |
+                User 0        User 1       User Y        |
+                +------+      +------+     +------+      |
+                |misc.c|      |misc.c|     |misc.c|      |
+ kernel space   +------+      +------+     +------+      |
+                                                         |
+ +------------------------------------------------------ |
+                    |             |           |          |
+ userspace     /dev/ele_muXch0    |           |          |
+                          /dev/ele_muXch1     |          |
+                                        /dev/ele_muXchY  |
+                                                         |
+
+When a user sends a command to the firmware, it registers its device_ctx
+as waiter of a response from firmware.
+
+Enclave's Firmware owns the storage management, over Linux filesystem.
+For this c_dev provisions a dedicated slave device called "receiver".
+
+.. kernel-doc:: drivers/firmware/imx/se_fw.c
+   :export:

-- 
2.34.1


