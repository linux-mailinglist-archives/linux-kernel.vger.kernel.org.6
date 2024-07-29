Return-Path: <linux-kernel+bounces-266307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951E493FDF3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82991C223C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2421818A94C;
	Mon, 29 Jul 2024 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kd9+B2Gm"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC3188CD7;
	Mon, 29 Jul 2024 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279603; cv=fail; b=AGawnUoHh9kBv4fciA5Hxr9UFchvkhnJ3L6UHKc+y+Ch5W68oUxydrNGVVCoT/RY8Aj5RnyBLLHptNU38jN3AeMG7ikw+6cKEdgPVPrc6NsUTQJB2z6neNQWT8RrW/sF2HYL8gncSZoxjdsxJQ+6z+ZBkpleEZyh+z8AI9ctAHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279603; c=relaxed/simple;
	bh=ENBg5NygBJpBwWm9nMvQFvmDSS1SVOikPA8POJzgCnk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Yy8/yc1yiCnOaZVOKFh/SsobZAgFE1wnEv1flMXos1LZiWEtNGrC+EL53WNIXhR1zcs0FxvfuHbR4fl0QgS8gRoTtQTz8WNE6/1xtF0Pu3tsUSAcgAYlZsbXAD6tKgVHU1hRoO/t9Zcbo39j+DqAZG/niAwKvMTbSJ++fcuYPb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kd9+B2Gm; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdsL/jJ8cguhjni9glcS/h+gnb+66Fj9F0Xneogwd1fe+flAGL/MfB2MIan89GMtifekd2kNN/DtyNveHenL+NIKm3LaxesXyOPBjTf+5bgJ2JkSbGD/sl1PYahy+JQpmlj0F84G5rm66QY6aavOWphn4NVZNcZ9hITctcjuMP6vGN9AelfuBoDDMMYm6YUJuN8C73tDfpAnHQmhlZ06btKvNkFmFUR198GlQi/Y9olTUHgqkSS74kknFWjLZcZ7PP1MiSd4J+35//HMlqfJZ7K4a5FlT6w5XoEsbPXJpcEUd7SBlo/D32Xxj9dBCZ5tlpvB2WGX+62HhcsQ/QNk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t18MpiEGHSTGYTRnQVcQjvdb/4syXxpKNEUz10Tq4Vk=;
 b=mOWc9oxqEas0ZFFHtEtWFzcJ87wZ+W/BCwlxHhGmZf6DTqvJ1MV9ZnnE2fd2aY1O76OSwWUYmneDZ0JOSVuD7xvPn2tvmK18/Tx9SSKtS/kQE/4HYMJB2rrqft7h5AC6oa8ZoNMu2NqOr3HBJGoYkbb+LUArJ7Nl51ZEpitWBYwMDC3JA/F61M68aAStbqZNr7qcTBes9r9ZeKVX+B+vcssQoW59/BjGKjYr5r0TD42tywg8oV01/t4XUYfkCx0bEeYqr1o8LcsqKe/k1DvzpiRI0EJzeL1EkpR6Mr22xGO4VAb/80BSe8TeMoDRnHInUjRfq9t/j+V4qk7eiYfKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t18MpiEGHSTGYTRnQVcQjvdb/4syXxpKNEUz10Tq4Vk=;
 b=Kd9+B2GmKH5uaTLM9rVlhfXTSGw6fxyWGZ+BbPlYUUE2jGiWa/TwG6z4cr82bi8bc9zdakvRR37jwOxHVtxqGS8gQieIY0zQmhkGw2jC7f1iueMXeY7l6iyv0qALKv7exat7eTswG2IScf6L47khxSfZfQaEulsK65gLWZoPHuUXXcMyTErSLWWYtVTdAcKUtKoN9VD7agz/3YRXGjBpJkx5oh5bEN2hAyM0CXZAEcFhonlCrM88VFQW4gjOy12kH2zwvA9zPLdCymY09kXN4eQFcvxUigmPbJvk9SvysColTZ5It8d/0wG6QNdouGOM+Cy1Ud32TAgMdUKLTXDsEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6939.eurprd04.prod.outlook.com (2603:10a6:10:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 18:59:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 18:59:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 14:59:26 -0400
Subject: [PATCH v2 04/10] arm64: dts: fsl-ls1043a: change uqe to uqe-bus
 and remove #address-cells
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-ls_warning_all-v2-4-942d80ddd441@nxp.com>
References: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
In-Reply-To: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722279587; l=3115;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ENBg5NygBJpBwWm9nMvQFvmDSS1SVOikPA8POJzgCnk=;
 b=gGqmAFavrcbHvuh+1ONr33Ul0jaAePeHZMYusSPycemlvqcONrhED2Kk68QtgIo7tW0VkWEoh
 Puz+KE2JnBIAW/gMjFe6nMViAyJWdw4S802cRU9/UNnpZmCVDPHLiv+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 84db5fdb-0189-4db6-f6a0-08dcb000a4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlA0OUZYa2tOK2Npekw5a3B0dmlhZTVZZktmL21wSGwzRXpqQmJJcE5jU0hU?=
 =?utf-8?B?S3RTYU9CUFJFUFJRWXdpYUJ2QmRVbFJIVGJwdDBwWFZnSG9hZFJJZGtaWHF3?=
 =?utf-8?B?ZXpveFdIRkdsL2lFeUdSSmZ5OFM0T3lMQzBnM1F5UENiMzZhd1Btc25oMTJs?=
 =?utf-8?B?bWNzTjJLVUw5eTM1ZldlbDZrM1VJL24zSklaK1c4N1ZjdTJtTzZKWWlBclBM?=
 =?utf-8?B?Vk03TXg0UVBubk5KdzRuQjBQU2RMRFJJejF1Y2VzOGhmQnZucVdhTnc1dGxO?=
 =?utf-8?B?Zm83UHhPbzU4Sk1XR1hqM1BBeW5WNDZENmRWTUR0Y2t3cXJjUjRXcXU0dHRq?=
 =?utf-8?B?RFMyTWc5dkJyOFVpNlN0cnR4MDVZVlQ5dWlic1NaN0N0UnNjQzQrZFJ2dGxL?=
 =?utf-8?B?S0NJNjhOK3FDbUdjSEo4akNOZGdFTk9yOUhlczJySGZrdnQ5WktseGRiSi9M?=
 =?utf-8?B?M2cyVUlzY3l5d0NPRkliOTgyQWtJaFZjUVhmRjFwcVhwZ3BUZzU3S2cwU1My?=
 =?utf-8?B?RWZLdVVYSVJBaXQ3Qlg2SUhZSjdSWkkzRjRzZmVrWGlvUnB3SW51aFZiL2Vk?=
 =?utf-8?B?VEZrTHN0VXFsaWpoTVgwVkpOZDlObXBIb2wxNXFneHd0UWJ4dlNSamFET0k4?=
 =?utf-8?B?SUcxd3gvUldJTlVDVEwxTzZHUUE2SGRZWEJhekE4azZvM1UzZDlrR2FLWnhz?=
 =?utf-8?B?MzZOd3BiNHVDVW56TWtEKy90Q1FMNmVCcVhTVDdYNXRMZlNaV0ROM2QrRUpq?=
 =?utf-8?B?bjhaekljRk5oSEYvVlZNM2hXSHcrNHFUSHlmTzhMdTE3enppV3BoUkVCTHpm?=
 =?utf-8?B?YWY0V0IvUlNyR1VON0JHL0tRbzVJSVBOejFxUEEvV0tpZmtUeFVwMFZxU2Vt?=
 =?utf-8?B?MEFxKzFMdjdCa0F2dVNmNEY5UnJwcmNFdmVXMUlMNVBLKzRxcGp4YSt0VmM3?=
 =?utf-8?B?TEpTVHl4ZDlPam03R0ZjVmc3YnNnU2lQRGtUQ1RFZ0FBbkNPOEVHeHN2Z3FW?=
 =?utf-8?B?eGRqUUtBd3BFL1EvTFRKZlNKUnBSbFkrVVhkSFI4T25xT21WQVVUdDVCSFdj?=
 =?utf-8?B?N1RzVjdYcmNEaEVrWm1QRks4em5NcDBDQklNRTRXcGxiWGhEUkpFbUN3Q0lW?=
 =?utf-8?B?K0pERm9NNkQ4TVBVTmtTZksxeXJmcERPZDBTNWE1cHVnbEZOc3BWZmRnKzR2?=
 =?utf-8?B?U1A0ZG1DTU5oRnppZS92REJWWnZqL0lZelNMeUtHVTgyaTg4NWpUSTBackZP?=
 =?utf-8?B?cmdWbTB5d1RJVEVlQW44Q1UxMXpIMW1CM3NSZWNpU2NYa1g1eE5STnF4Z0JT?=
 =?utf-8?B?Z1Ezbzgwc1F4SU9NZ3BjdWdQMnhHcDE5T1RqZHA3UG40RWxjTXdCTzRrRzBz?=
 =?utf-8?B?VEVDbE9lL0hNbm1pU2YwTFByVGduSkZGYkdBZ0dJcUhnV3pWQ3BMRFJLalZ0?=
 =?utf-8?B?OGIzd2szSURUSkFYYVUveVhLZ0lVV3lFZEhxQ2VPZHkyUVBNSVFWQ3YxSlBJ?=
 =?utf-8?B?WTlqMjFGMGQzOTRacGV0TkxLTFFHM0JKQkdwbGc3Z0NzNzNkaGNYN240VUh3?=
 =?utf-8?B?MUdpVnFLaEF0TE85VDRQRFNWQzlFS0VxN1czdG84R285Y0FjZmJzSjlGdU5B?=
 =?utf-8?B?R1pZajZXWHdaWmVxSlp1RXpVVlQ0RURNSXphTmpmRFcvVHBKdGVoL0RrQ3ZS?=
 =?utf-8?B?cGVHN0k0UENGSU9Vd1A4Nk9RWjJMTnZaT0ZLRXRlaDZoaXNIcVlic2R4aFpC?=
 =?utf-8?B?QVFTbSszMVkxNHJRVThMREpDYUkvajY5K1AxSlN6RnpWWlBoc2VFOWFHeEox?=
 =?utf-8?Q?8ZSaJwkBFKSH4Qsd/NvJFGKvSQxep2NLLdF0E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmt4YkZ3Nmd4SUkwREJDdVFteUNwWlgvRk83bU1jbkRFRThzbmF5KzMwZlI4?=
 =?utf-8?B?VmtlN1pKYkI2Vk53UjQ0YXhDMEdNV081U0xhbXdXQnRLSTR2ZW84S29zdHZl?=
 =?utf-8?B?TDRTdHh0TW96bjdkK3RGQW1Ec0Z6Y0VSTGI5MTVLelBxenp0ald4M1RIZzNX?=
 =?utf-8?B?ZmcyM21TemtWQ000aExjN3pFRHo4QUxLVDJXSE5aKzdTRzQxa1dzWm5hdytj?=
 =?utf-8?B?T051cXBKUytVUDl6OE5hOWJSelR6N0dsWnpNY2laNHFSREtINVJBZUtUTFFj?=
 =?utf-8?B?VXp1Q0w3d0N4Si9JeUI5L2Y4cmp1VVNMMVFUR0VOcXNtamVFUGdqZFBtdUFG?=
 =?utf-8?B?NkFHSWZ3OGhxSk4zdHhLQ2g3b2xYTmVrYjgzWVJwdEVBZXZZS1YvL2l5eTVZ?=
 =?utf-8?B?bWdPeEIvd2ZkZ2NYN0hmajZ5TWhQaUFuZkVGZERBTkVFSExZT1QxTG5jWGEv?=
 =?utf-8?B?bWJFN1ZESVdtTlRFQ2ZTSlprZXNRaCt1QXdUNWFsZzJUbWVXeGxwK2t1WmhF?=
 =?utf-8?B?WVZiTTVyUGh2MUlGU0tNNXBXcEVwVHdUMEJBYVllbGpzQkV4ZXRReUtTeU9B?=
 =?utf-8?B?MEtrQjBka25TMjdPb0lRWDFRSkpzZmw5R1hsREJIWVpFQkd4S0VJMFlrVHJM?=
 =?utf-8?B?NzIvVXE2ZzU5L0x4ZjNJOUNhd2crL3hndllsU3U2SElKZGRDb1ZIcEdSYndF?=
 =?utf-8?B?UFplUEd0NGdkai9MOWpyY2JWK0dDZXIxaFpOeXJudXRzcFlTTE9tbTh4SUxh?=
 =?utf-8?B?RmJZeC91ZjlBODlCQ0xYb00veGptL0N1d2FobEhhSGY3VFFoY0VIQXNlQVNV?=
 =?utf-8?B?TkdjeGdGZ1ZNWFpHek5xRzJDbGNpeEpFd3d6VUc0TnlGWU9OZE83aGJvYVV3?=
 =?utf-8?B?eUxUdHVEUTVBdlYvLzRkdnBhZDVZTGxFVnRzSVRUSTBIMzU2NXZoNUlseDkw?=
 =?utf-8?B?Z0pONjI3T0NWdWNkcFBmankrS2ZDdjQrZjg1YVc3b29iSnVUS1luTzg1ejZR?=
 =?utf-8?B?UGN1b3pYZ3dod3hYOC94ajNEWkR2NkFUTi9wQTdUa2J0YmROTmZ3WU9rZHlj?=
 =?utf-8?B?T2M5cTFpb1QrT0c2ekNxMEZ0U0VSMzIxU1RmcUNmeTFuYmdQUnpDb2JTTlpo?=
 =?utf-8?B?ZDdIQXNQelRtR1FxMWNTVURNVEpHQWdCVnR5Y2VsYUtnQnMvbzQ2MHhTdTN4?=
 =?utf-8?B?Yk5PbzF0VFExcVBoTjZMblhPT1NUaWN2bzNHS1dHa2NydUFkVzJ6THdmdlBS?=
 =?utf-8?B?V0NHUWlyYWtNYVl0MGsxSVZOdXF5ZUVNL3dUeGpsR2ZiSlZBOGM4eGlSanpC?=
 =?utf-8?B?VnF3K25ieE5lYUUyWWJBZWl6NU5YdTRWWHVGV2pFUHpjMkVQN3R5QmNPRWdm?=
 =?utf-8?B?b214QTRjMDA2cTVYQVVPaHZVV3RxTll4TTV0akIvMzRWTjR2WURld0NZNkhw?=
 =?utf-8?B?TTU2Z3hZbk40emFjSzlyak5Dd0g0SXVGNnV2cm1ramthdzlaUmtOVlpCVWZw?=
 =?utf-8?B?b2dnOWhBdVdqLzZObnRyZTJFa3BGNVFtVGlvQlQ1d20xdWtnTm84SGxhOWJX?=
 =?utf-8?B?dGZQVGZ5ZU4xUTRXVTEvejFtOEMwRkMyTFduTFlxQUQxdit3UkVwYjQ3SEtU?=
 =?utf-8?B?MWwwYjZLbDZ6T1FLazhwZE9SQk52aXprRGRwQWhob1I5QmpTQ2MyLzhJNHRS?=
 =?utf-8?B?MUNBSXhjbW8xYzl1L2hXek94azR4R01RNWQ4UUVIYk0rOVZPbFVmbVgxRWFt?=
 =?utf-8?B?ZU5KWG8zc29zMXBMSlVPTHBkWkpsUGxZZHQycEZXSHRHdVREemVoZThjQXhU?=
 =?utf-8?B?MjVGV1ptWTNYMmFDc1hKSjR5YTkwN3dzODBiT2JUWXZoSkxSVU1CVCtFbExU?=
 =?utf-8?B?L2huU1hkNndmU2Mwenc0ZXBwUTNuaTlZTEJhV05TRjRDakx5ZllESnBjLzJH?=
 =?utf-8?B?bC9DQWVQc2dNR0RWVE5iaitQd2l4VDZpR2ZtbmI3ZEtONWRmTldkMXdjWlBR?=
 =?utf-8?B?ZmtBVVRlWXpmVC9jTVAzbXJ6czdaaUIwTTY5OTVpckNxdW1QbHp0MzlObjF4?=
 =?utf-8?B?dE9BRzJ6UkoxZWIvLy91R0RWSGYzZ25UOEtJM0RPK05zb3NvczdIa3RvVThz?=
 =?utf-8?Q?C2u55y37m1QugNcepDyX5DxhA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84db5fdb-0189-4db6-f6a0-08dcb000a4e9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 18:59:59.3895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtKog6oGo8lhcGJOYTKYzTG71fVYZNJh2W3umqYLAO42Z9KGBAljqRYJAK/28AfCwsVQwjQkOwOdgb7HBZWRzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6939

Change node name 'uqe' to 'uqe-bus'.
Remove #address-cells and #size-cells for nodes, which have not child node.

Fix below CHECK_DTBS warning:
arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: uqe@2400000: si@700: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: uqe@2400000: siram@1000: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: uqe@2400000: $nodename:0: 'uqe@2400000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: uqe@2400000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'qeic@80', 'ucc@2000', 'ucc@2200' were unexpected)
	from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: qeic@80: '#address-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe-ic.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: si@700: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe-si.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: siram@1000: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe-siram.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index c176d36f68437..6d89cb5ddfc9c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -653,7 +653,7 @@ gpio4: gpio@2330000 {
 			#interrupt-cells = <2>;
 		};
 
-		uqe: uqe@2400000 {
+		uqe: uqe-bus@2400000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "fsl,qe", "simple-bus";
@@ -667,7 +667,6 @@ uqe: uqe@2400000 {
 			qeic: qeic@80 {
 				compatible = "fsl,qe-ic";
 				reg = <0x80 0x80>;
-				#address-cells = <0>;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
@@ -675,16 +674,12 @@ qeic: qeic@80 {
 			};
 
 			si1: si@700 {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				compatible = "fsl,ls1043-qe-si",
 						"fsl,t1040-qe-si";
 				reg = <0x700 0x80>;
 			};
 
 			siram1: siram@1000 {
-				#address-cells = <1>;
-				#size-cells = <1>;
 				compatible = "fsl,ls1043-qe-siram",
 						"fsl,t1040-qe-siram";
 				reg = <0x1000 0x800>;

-- 
2.34.1


