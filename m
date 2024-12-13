Return-Path: <linux-kernel+bounces-445540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE799F178E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1470188C2BF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5611925BB;
	Fri, 13 Dec 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PfAd8aIE"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865D18CBEC;
	Fri, 13 Dec 2024 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122789; cv=fail; b=kF/FDsBIUpCl0NRnqFbxy7V0D3pXXQ/8KhutrRykxUgbQ5tfKxEgUvgiPNtwf8mL9RN94CEUcGcWH4Ib2HvhBco3tb2FIpQ/inUS/sXHCBzCmM04D3SFPkhxxvQLFT8joCtbq9VYPQAd1MDH3rHXsKRxZzJBUMXW+8TDBDnCQHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122789; c=relaxed/simple;
	bh=T2V6XTE0LmIYFEOlJnvQA12OzOuhMuJKz/3jUtmLk9w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bh9oUubkOPf/XCPd4NlEhDBSC9Hgr7Zs+Wd94/+tawT/ZURQUz8hZKK516BPPYkQ3QII8eGIFiTxVa2Sd4vUQ9rqaYNI/Nby06vwco73GJL0CmCimWButXZbIwDaDG/XtMG9jWyOzvIECllBKmQWNJJn55N3VVMrEQhI2t0Ui7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PfAd8aIE; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiqNRXQSNU2YLScrfh/hp28KacwklrbEf201yaKX9Mc0qmaN2laFYRXIA0OJZDnQ0Ph5kvqBRA5JbzBbqYXuies0uoTWScyuvqaTQoCOcTLCzeSiij71jeRX/M30b0tgxK3p8daS8TnpbObSxZUi1pJZQv5KCdQU4wCfa1UP2XraWMjyoBDlRjcX7eSDZLliR3MDd3afVIO5Mvb9Ut74pw+WPQLZC9osQ75PSjH2UU228cqBvSePFT8S8VkU9tnJA2rhaUfejQzvrayBa8VsIRqidhYNBMhLYaNFFAGoOxmd8SuZlAdzBiTqwV9YH1pIHNeLo4gPldj68d5ebH+tqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmJaOxhwRJFx+OaM/6suI4BycWvktw34JgnSdHK7KvU=;
 b=gY7XIYmnS2tOZZ3plA6dJd09YytXtChQR0ZO/1c4uxRVJFqRCM+ewvJnNruEh8TThLW29PqdB3b5qFvUc5Be8ukesQyGE6JobMp09dW+xL2qqVCh+LpObx2Q7UcIBZyN6ApYZiPYmKvrT3h9+TyczT+ZsS/emP5fjKF8Kg4H9oOivW/nKOG5Fzpf/gGm4yA4R6pWomtzrETWladg3MZW4SdWRX1q02REv1K0W/skiV959OnsCUfzc8jhKKqwFpfHb1ujscpkzBm3uXSxnXUsWCP7fonLL/TrtzLt/fE2Phd4ifxBpGqe3MXrrh/Fi/Kt9kwE0LM43z0HJQHjZ/Y6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmJaOxhwRJFx+OaM/6suI4BycWvktw34JgnSdHK7KvU=;
 b=PfAd8aIEgVP3dNOsSDWXTmTgPyvY2OQ08Hu8bcH3yLf0HMuiIE9EoZRJ1HPy/YYyxkvRgoqoU/7fhhYnOfoTFYbvA6FgUdFAZe1/3ugGlHFP4kHw6nOdHIuqN85wOiZahSBEwwFU/NfD0lAeVRJqKGxLzbDA2v1eZ8misbTtKygtmN/7mJpTeAeR5eJX2eBBJTL4zcWg6NRhpgVZM16vzdAiev6Z4103CehJKEURtraud/YQzdSb7YohFu/BvSGn8R5IAuCGkIZJVDBtUF4X0RbD2ype9w+vq5Fn4w7LCzaKFLwDM3ta3XyKC9RoGwL4qy01vvZ8a+Ai8VhAdfpdwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10215.eurprd04.prod.outlook.com (2603:10a6:102:409::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 20:46:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 20:46:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 13 Dec 2024 15:46:08 -0500
Subject: [PATCH v3 1/2] regulator: dt-bindings: pca9450: Add nxp,pf9453
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-pf9453-v3-1-5587c1693155@nxp.com>
References: <20241213-pf9453-v3-0-5587c1693155@nxp.com>
In-Reply-To: <20241213-pf9453-v3-0-5587c1693155@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734122778; l=2158;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=T2V6XTE0LmIYFEOlJnvQA12OzOuhMuJKz/3jUtmLk9w=;
 b=M1oK8G8DS858RMI0UuqN++98y3/4Puj4poEPDhw81z9fFWYOpd44gEuGFGOiFXn45M54tBmDV
 w4pYJtnDQgXAGGBHi9ypiK0LxLkQiuLmYxe7VfTnQxqEFjjTYQtLIwr
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10215:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3a79ea-6215-4755-dc15-08dd1bb73566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnVhbkJPa1Y0SkNreVZ6VWlXbkplNlBja3dTM3k4bkFiTXNUL2wzc3RXNWlD?=
 =?utf-8?B?MHZoaWlDQ3VnRFlRTmNsUTU3REFOWnZPVkx3R1luUys0ZHN1NmxzSVptNW8y?=
 =?utf-8?B?TzFobUZQdWZDTUVPUVFVRjJzTEU1U1Z6anE3WDNEUjIyNGRqWmsxZUNpdFlj?=
 =?utf-8?B?aVQxUWtTSHBjMGlndjUxaVV0L2h5cnBBb09XdHNEaXl3YTV6cnR6K2FPemxR?=
 =?utf-8?B?NW4wMEd5WlpMSWZjR0g1c1JvR2RwcXc5MGZCeUxNQ05WVHFRSzcvcko2SU9o?=
 =?utf-8?B?S1ZSbDk1bEhsVEtPb3Y2SlJFUFhYcUlsYmtWM1NUZERpcFZoU1JoNmFDQUx1?=
 =?utf-8?B?K2trYnNHMlRvY3A4eFY4U0lrVkVqc1dNcEZqWldETnNnbDJrZFE3bTBEMlJM?=
 =?utf-8?B?bjhGWEZUbjAyQkpQc0RLbEJieXFLMkZ6dmRBNlE3TE45MTRZZDJyUHJneWcv?=
 =?utf-8?B?aDdwQi90VzhUS3pBUU9jQm96ZDZTZUhiZnFXWS9YZjFlcnlYVHNJQVg5OWEx?=
 =?utf-8?B?dzBsd0llZ0k3dndXSjFuWE9xSDFES01EQTBCODE2WXEraWxkWThNZERJdS9n?=
 =?utf-8?B?bUpkd2lvMnpLTlhrVVNnOUxIYU04OVhCU1oxbWt3KzJUOEU2NFFiZEtvYXps?=
 =?utf-8?B?VEx4d29mM0RpZ09tcXBBRGp2eGErbG5XbGl2UFAzdk9rWDJjR1BXd044cSt1?=
 =?utf-8?B?TDNobkR0VktWczJwZFB1MHg4aGJsQ2VCd0JIQ3doc1BNN1VkTWRzdkRySWRP?=
 =?utf-8?B?QW9DYjRkWG1lTTQyaHNFNlRhajhlNE95K1VaMUsxSVJnYmhBcXg2ZVAvYjlW?=
 =?utf-8?B?TFdGZ1hBS0l1VENVWURHcG9BbzcrL3VXcWxuUXA4ekNkNFNVNWFHa2duOFFD?=
 =?utf-8?B?SE1VL2JmMmYzTElyTjdqTXFSZldNK0t4M3ErdC9WVm9BeDFFZHVCMW42c3Fu?=
 =?utf-8?B?bXJKRFdWSWRVOWw3U1gxZ3BZNnhzekoybG02N3pzcDNOakI3ak9uS3NJb0Yr?=
 =?utf-8?B?ZytLSE05akJ4VjZweDY3WURmcG5KQ0I3YWo5UTg2cnVxWlRDSnpIL2tSUkNQ?=
 =?utf-8?B?QTFucVZPb0o2VjhGbWRXNStaOUhjaFQ3WnJ6UUErak9OYW1rUnhtMlV0UGYv?=
 =?utf-8?B?L21INGtRYlR1M3NOLzk5azRhWXhUUFpmMUpLaVdlTVN0aDFUVEowSEhIQlov?=
 =?utf-8?B?WGRmbGNGTHh6SFJjL0h2TXRiQm9OUTVja1hkeHltbzF2VGF1aXZjN1dza2Vn?=
 =?utf-8?B?UnFBNHZvY09LQ0xYd3FxR09pNHg1ZVE5N1hrVGNqSTZZdWdvdTJFMGs2NmtE?=
 =?utf-8?B?WGlTNkxDOFRueGk3WGgwM0tRdkp2MERqWU5tWER6ZVdFaTY4ZjA2T0RWTnkr?=
 =?utf-8?B?Uldld2d2QU1XTEcyV2RySFZlOWJFK2gzRy9vamp2TTVrUHdOb2gram45eVpU?=
 =?utf-8?B?bk5EQlUyR0N3VlBrV2ROWEJ4UE8zM0Z2U2ZPT2FNSFpUNEZjZGk5cnQ2VWZ6?=
 =?utf-8?B?T2l3S21FQ0QwU0tYVzhMNDZxZTBqSThlSkZOOUFjdG9kV0t4cGJLTjhPT21E?=
 =?utf-8?B?cGVLWXhzTDdiMTJtOWRlM2pwK1F2QUhLd20zMmRaMDYvdkc3Y3hpQVhmaHRy?=
 =?utf-8?B?cWkzcTlQR0l0OFBPTjNxZjNVOWhtOTE3ajhPcG1ZUEpJY05HZVVzcGxxdDFa?=
 =?utf-8?B?cEJ4RWJ4d2FKMUtubEtDOUszaXNGVWN6R055YjA1c0hwZDArQ2U5YWVHbGNY?=
 =?utf-8?B?eWJNSytqTVlPbG00U2ZNQzJoZE1KZ3lxSUxFSmgvUnNhQWY0Ui90R2xwQ1Jl?=
 =?utf-8?B?dHMwSU1SQzRYRGxGeE5sT3ZTMUx2L3JuRWNudzZMd1RjSy9iTUJudVNSdHNy?=
 =?utf-8?B?bytUbjJCSGREV0RlbGRVVWRyOUp0NU1mWjRwdVVKNVZuL0RJeGtJZDBKNGdL?=
 =?utf-8?Q?6olpYVgXzx8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE5uZ1h1OUpjWWpMMFlLRDJZTHdZdndRaTVuQm1TU2Jub3hpL1hacDA0RTRD?=
 =?utf-8?B?Y2gxa0h4ZHhWV2pZNDFLSTlpTkFyakNKQ1dCa2hoUnVsVi82eE02YkFQclNh?=
 =?utf-8?B?Q2R0T1FRSHBwYXk2cjBwNWRBS2lCWXdkQUZ0WnRQR1ZkU0NHRGorYnB1Zmdq?=
 =?utf-8?B?MVBJREVoUVdqMWNvQXdQWTRDRFFLVTBtUXFZQlR4OHdtNkE2R3J3clhVQWlk?=
 =?utf-8?B?RTNQUWF6Y3BneHhEN2Z6K2VNSzFHTjhKT1RvQmJIQzB1TUZ4Z3JTdnhhMll2?=
 =?utf-8?B?dFVhTVVkcDZBc1Q2TnhOdk0rbHVSZWlwSXVhb0NWTkJNZXozZXZXR3FvS3E3?=
 =?utf-8?B?NkJUaUNQQ0ZLV0E4dmJxUlBWTTZWU05uZjlseDAvT2lnQmFkZEsvZEl1b0Z3?=
 =?utf-8?B?dFVIaGhtb1ljdkl0aGVjUmZrNWpKaDdySWpOWTRycExqS3lIUmRqSk1lVTBH?=
 =?utf-8?B?bXFWekdvN0hRMzcwaU1VT3R5RzNiTEwzMjFWNU5YdjdTaWZ4WnRhWTlRZ09I?=
 =?utf-8?B?bWJGZHBkTDJhT01HdTJuUjhhZ1RMM0JyNkJDTkFNL2FNVWw2VDFOYm9kOTgy?=
 =?utf-8?B?dElOT1MxeGN1SDkvR1IxSTY2M2VXM05uTk5TaDIwWEowUW9YVklFVEQyQU5t?=
 =?utf-8?B?cUhKVGxPb01mbW5SSS9rbVNSSEo3cXE3RGpBanArWHdBN3IvZDJveEl2cWVL?=
 =?utf-8?B?akt5YXpiT2FySzV4MGNQZzl5dWJOWXhnVUF5ZzdDRU1lU2ZtcVVYTzNjTkNP?=
 =?utf-8?B?dGhST0VtSnFHUGJnelJSZExoeFNncXc1b21LQjN3UVg2dWxnc3VBU21CL3FU?=
 =?utf-8?B?bUhiSzFzZ0NMK25wV21jcTZmY1czWkVTSnIzRmhodXFtWkdFQWxyY1daVzJD?=
 =?utf-8?B?UEtvZmgwSHFsN1ZXb2ZSRFg5V2pldjVVbGVrZmN1bDQxSXMzQUxsaC9qWnBj?=
 =?utf-8?B?R2lucVNSZUpENnBvSkFMR3pxdUF5elNzYnRoVHdBTWRWT1ArUkRjKzAzS3l6?=
 =?utf-8?B?K0JEakR6QlJudkY2SzFIT1ROY0Z1blIySllpY08zc2NuRWpISTFLVWplVUV5?=
 =?utf-8?B?YmhVRkFRNko4cEluQmJGYzVmTEphYjgrMUpJeXl3Rm5SOWNhVnRtRFYvNmcr?=
 =?utf-8?B?cUcyQnZZUnA1Q0ljMERJTEJyaThlTU9QTEljNndCOVM1WGNPeE1pR05taDVH?=
 =?utf-8?B?bUVXa0NhRCtNNDI4Znl5MXlxQ2Q5aHE2bG9pbFBtUmlkMDY4V2VIbHpnejJh?=
 =?utf-8?B?Rm1VaXo1cmRKRWR4WjJjVXhyMkE0VFlBQ1RMR2tFeDJoNDJMVXFWMkc0UGE4?=
 =?utf-8?B?eksxQXNYT3NXOGJqV1dicUQ0MkZHaGd5Tk5hN1BVdHBlUnRZUXYxSklvOGVu?=
 =?utf-8?B?bTYxcFRFNEZLYno5R25wTTdmdWNpN012cWVxcWY5cG1GdUM4aWphY3RLREk1?=
 =?utf-8?B?Tm1kTmRvY0dEMWsxTXIzd1UrSi9HcUNOdWMzV1IxWkVyMXZpaldvSWgzd2RX?=
 =?utf-8?B?ZVhtUVNWRkcwcHhSZGM1NEh3N09HL3VIVjNPOFQ0a2EyV0tVazVSSFV0RSs0?=
 =?utf-8?B?TU5TNkhkY2pHdDhqMVFsUGN0MWRMSmZIaWR2QW9MUnBhSEtyNHlPQVlwU2Fp?=
 =?utf-8?B?dnpJamF1WmFUaGZWWUJ3OXJUcmlzRGYrMnBYRGF5Yk9CMi9KamhiMTRtcEE3?=
 =?utf-8?B?cDcrVnpVNkwrdlJ6bXhyakRlclZtVnFiQ3ppRWJpa2xHdnRoa2xZSnlYazRk?=
 =?utf-8?B?alRWRUtNUWV1ekRIaVV1K0wxSzh0R2RKdjB0TXBOT25NRE1mNU13UnRVbGhI?=
 =?utf-8?B?TGNYcGhuQzhtN1BDbXJ5WFlqUE84aW9mRDVSQ3RQM3U5T0xqRG5yMGZkYTRo?=
 =?utf-8?B?SmZDV05qMjM1UjlsM1RGTy9mYzhPWEtQR0FmWjVrMjJacGwwVGRTSzdkcGtv?=
 =?utf-8?B?ZXROaEdLZTMyRlp5NFlFVTRIdk9uTmhlVUxjT0ptVEJqYnBSYXJKYkJSSUFy?=
 =?utf-8?B?TFBLNGtqRW9JUldiM1lCa0tJS2JRdHZQY2drdWVJekNHNjhzTjlHblBvbkVH?=
 =?utf-8?B?VlRzbytHaXlhQXlXTXdUajBQWG1zM3hHejdLOGR4WUZHUitHaUdZSTZJVkp2?=
 =?utf-8?Q?Ov6tR/tHoq6gUg4WrnmIEMLDu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3a79ea-6215-4755-dc15-08dd1bb73566
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:46:24.6338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAFLAEGyitMmLnWsEt3/4x+eAzJUyi4rTGDudfyd2Fxmtw80dU4Pe2AyeZLDrqXJv4w0Ru6nkTmx1t+0ZYoAog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10215

Add the compatible string "nxp,pf9453" for the PF9453 regulator. The PF9453
is similar to the PCA9460 but supports only LDO1, LDO2, LDO_SVNS, and
BUCK[1-4].

Restrict LDO and BUCK numbers for nxp,pf9453 and keep the same restriction
for other compatible strings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v2 to v3
- LDO_SNVS to LDO-SNVS
---
 .../bindings/regulator/nxp,pca9450-regulator.yaml  | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index f8057bba747a5..a5466bece4cf7 100644
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
@@ -29,6 +32,7 @@ properties:
       - nxp,pca9450b
       - nxp,pca9450c
       - nxp,pca9451a
+      - nxp,pf9453
 
   reg:
     maxItems: 1
@@ -42,7 +46,7 @@ properties:
       list of regulators provided by this controller
 
     patternProperties:
-      "^LDO[1-5]$":
+      "^LDO([1-5]|-SNVS)$":
         type: object
         $ref: regulator.yaml#
         description:
@@ -100,6 +104,24 @@ required:
 
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
+            "^LDO[3-5]$": false
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


