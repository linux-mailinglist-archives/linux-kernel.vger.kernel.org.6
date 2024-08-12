Return-Path: <linux-kernel+bounces-282774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C89E194E871
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9801C2165D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4ED16849A;
	Mon, 12 Aug 2024 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="b6+Ag5L3"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2131.outbound.protection.outlook.com [40.107.255.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2AC1876;
	Mon, 12 Aug 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450984; cv=fail; b=W5CPr5QK0vvFWijdCnNs1WRXP71fBQV01XU7fKJ5cRLjCU3C4CSNfcaNpkm3lvb24JtUrGrTv9VfNwHT2nPDu47AdVJo6UxgayNxRfSDzJYU0m4eNvM/l2V90m81ymIDFIe0BNxG1Fm1RyT6QYtRkwa7nZKX/WblrBQ7BAA/quA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450984; c=relaxed/simple;
	bh=FZoQLPZ+xf6zgEiRiFcYdhtl+1Te7A56Xpiu2ABTzSg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DSXPVaNFMlW3MgJACRAkf396KhxxgNZnxhPJu14WdIcpU8xfe/Wk/gEh11DY1BNZDsb4z0ioMzWlol9gSDPaEMxMSYEIXa9/H86V3frsAV6BbmSPr1wUeNakTbnWWQHhlNJIEPaqNEAl786Mgvc1Ezei2MX/L+JsysX48k9LCgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=b6+Ag5L3; arc=fail smtp.client-ip=40.107.255.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJGH5N87mISVHt+WreJkqG2uRZX2GNH+OBqMMiePUqe9CzTy+kn8vSr2ziqtjbuR+NDICgu0OSVpC6xGxo/Asm7w/fskdVx9v9Mgl6WzNj9Pqw6MyqSGi6r0U8byg/fu90y1iPYMN1nsclmx2wuAvac+ay/kQSExBgctQ+oN6gTOm+gTPLJvwl+u/11/+xYjDkOrG1Fwd44QdwjsGn2Uu+svoAPf6q6nya9xTHY1PXn/ehv3/MOwCPs/hi3STnCqQuKVgRqGVBRayEsXR6Lbz4iToEt87laSJYCHQEkMrzjvMlz5wr2dr8LLHBenf2t+cbP8a88hk/QVn1kY/SID5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZoQLPZ+xf6zgEiRiFcYdhtl+1Te7A56Xpiu2ABTzSg=;
 b=wnPYgqndzP9o5xnh85neDn8rIrfq4eux4Yfd/3zZXvPsdJPxTuKPH5lH16pSwF5fu7D98fFr5/xDC0e608AaS8zU2AUigJoIfsS0IKems6yoCWhd5piOcP9v1H2S7exz/mvNiYjzhYIIivi8UoRMY4dSaDjsUta6isrCocXAEnUmqt3MW++KmXbP+e63S4HZnD6gFaEO21kUGMvl/GpwpExD9871ROKAAMrQ0sczxIM6FTsUcSIbugxrAx3hVWK9PO2geof0LDMz/kTDl217BPjmgBUVbjNdIpH5x7VcJphxWOqs1xtLPwV5sbr2j8cn4gixD3gnqPOttjjSGHOnsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZoQLPZ+xf6zgEiRiFcYdhtl+1Te7A56Xpiu2ABTzSg=;
 b=b6+Ag5L35IZe4v4FaHCs3ZvaS1t+hvO58ge56Ss+O7ryxnclAgj67IbGzO0tghFBQ2uKyDnN4wnz3srFbrAWz3pR17MiGAhMhPQcN6YfDfNpZq7pXcBvhaWsf+htrVb/I/HMaxrJJufkLYhMHrXM2VUO1Fia6Jurpp5cjNF+L2p+KFiQ1L6ZUPF9Mkken0QeTKl7PjQeu4IApa90J1WfLBd6zTah1ABeAXFU+535/duTz6XeitRxYl7W6+vb8M8OHwAEo+iow3Jbzl9LNhEH1QvWOopTNy1pF22DmAOg+r3YRL0+5WCrTdkAltp+9nFPr/odPKo53HOUpe9AlSHzYg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by KL1PR06MB6491.apcprd06.prod.outlook.com (2603:1096:820:f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 08:22:58 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 08:22:57 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, Lee Jones <lee@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Topic: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Index:
 AQHa6WjvtGERsBjdbUe0s1M0hUJcKbIdCjAAgAFhFjCAAAaDgIAABO+QgATIDfCAAA4pgIAAAYwQ
Date: Mon, 12 Aug 2024 08:22:57 +0000
Message-ID:
 <OS8PR06MB7541196D3058904998820CFFF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-4-ryan_chen@aspeedtech.com>
 <14ef9485-54ba-402b-9b90-5f10c1523d4e@wanadoo.fr>
 <OS8PR06MB75413728F0FCEE022B4B4F5BF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <eec21668-3674-40c6-b443-90c7c02262e3@kernel.org>
 <OS8PR06MB7541CA018C86E262F826B9E5F2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <OS8PR06MB7541B0D9A43B989DC1738F68F2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <5081c41b-dfbd-49ad-a993-b983d4c339f0@kernel.org>
In-Reply-To: <5081c41b-dfbd-49ad-a993-b983d4c339f0@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|KL1PR06MB6491:EE_
x-ms-office365-filtering-correlation-id: c4976519-816e-46f4-50e6-08dcbaa7f8e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGZjUWpvRXdGa3BjMGdhQkpoL0pIc25kbnlXd0w2SEhaZzVhWjArOUhmVVdE?=
 =?utf-8?B?L2JWZFV4NDhRQTJ5cU5vYmsvc05ES2J3Nll5TUZsS0NlRjJyZlJLeSt6QkRN?=
 =?utf-8?B?RndXLzR3N0R0TWFjZ3RGRm8zdFpKbFhyT0FPeDhNQ2pkSlRHUHBBK3BxVjF2?=
 =?utf-8?B?WUN3RlpYSGNWRWduQmxyMnQ3L0JBc2JEMkZHSWNZVmVuTHNyZ1o1NTN5aFcr?=
 =?utf-8?B?ZEtWK0hieGJrMW5jK1UwWjJrbllFa20yNkc5ZlM2cklJdUVQTUY3WTkyMytG?=
 =?utf-8?B?VW5vc2R2OU1IM3NWdXV4Z3FBR0d1UjM4Wm5tMDZSV0JOSFo0OHAreXdrelN6?=
 =?utf-8?B?NjdHaWxkRDI0Tm5DYndaTzM1OEkvZ3RGcEI1Mlo2bTkzaDlseU5od0plTUZR?=
 =?utf-8?B?clNhamh1a0FrRENBeE9ucEEyeC9PakFtaElwVUNoY2RsT1h2NWlVbUlTQTlR?=
 =?utf-8?B?M2RxRmV0Z2JGZ1ZjWlZIOVNKTFc5ZTRMM21PMmpzUUVOQyszbkJLYTZMckxh?=
 =?utf-8?B?WVM4bVZ6QWJqcXVUNzFianJ2QXdqRmF4SCtXRzl0TmNudmRZSWcyMTlyS1Jw?=
 =?utf-8?B?QlpOUHFDVFEwYWQ5T1FsQTRqbHZuUHJaWFEwb2d3bFBzeE1FSUJJcGdVd1RG?=
 =?utf-8?B?VWlSajV2amV4S045U3REMFV5d2Npem9wd0I1MzFzcXlaL2hZc0UwekFPWTA0?=
 =?utf-8?B?Y1lZYlA3N3lRR01tRFEvMFBTR09vTWJmRVB4UEVwa3EraDA3c2YvcGJkMW51?=
 =?utf-8?B?VExRMm1pZEdXWVdTUDZ3UFNxaHFKOXVNbUxZVm02RHA3eUY4MmVWSmg1Uy84?=
 =?utf-8?B?R1ErOXlONVNQeXlyMXJ4a0ZVTG5hZzZKSDZKaGxtSmVrTGkwN05PaUIza3Z4?=
 =?utf-8?B?RGtyNmVLcXgxaEhYUlpGUVRob3p5WnFqbkI3YUsySFZROGx1d1FYb2lkaU96?=
 =?utf-8?B?MmpxY1IwR0xRSzBXcHRCUk4wSWRBQzA4eWprMmIxVkNnbVdVYll4c080ZnhY?=
 =?utf-8?B?TjJJQUQveUlCelJteUIvVmVXQzRrWGVPM3N2SndId1ZQcm9pbmVXd2Z6VkxT?=
 =?utf-8?B?OUIvTFFwRC83OFFVd0w5OTJJblNKVUw1WnJETlJuR2ZlRytXa3EvV0plcHVx?=
 =?utf-8?B?bG1CMnVVbTNtUDNPOGtJTE8wYTlKS0FXS3ZxbmJtSWtZMXFwbFJYUElPM05n?=
 =?utf-8?B?MlUzV1loWEI5ZGtCd1BhU1NOV256bWRFbDhVek1UcmF3ZXUzNFIrSTRBa1R5?=
 =?utf-8?B?NWhpUC9MYmxKR1llKzdFTitINlhaKzE2N2xiSGZQc24xQTZ6Vy94cy9MVGFu?=
 =?utf-8?B?bHBXSFk3aHNrM0pvaC8zWFk5VkFFcWZ6ak5FeHRrZkt1RGtLeHk3d1BJQjkr?=
 =?utf-8?B?NklpRzhOYlpQRWZ5QnhhVVZhQjZnL2Zyb0ZldjM1cVNKREFSbjNWb25YVXU0?=
 =?utf-8?B?YU5nUUFqZENUV3l1cFNNbERLeXZyRHpDWXhPbW4yT05BclhoT1ZBNHBUNmcw?=
 =?utf-8?B?VjZoN01yQjBINHV1SnA0YTNFUnU4bjFjOEIyeEpPcElsWkF5RlJzL0JTdlBF?=
 =?utf-8?B?WEJnYlpPQ1dnbDFIMXpnOWYrejFzeEJmVmxRWGdVUWNXbjFGTWdtcUlFL01W?=
 =?utf-8?B?MVE1Sm5sVXgyR0VyeThQbzcrNm5FRkFVSUswMFk0UnZHWDJ3MGd2endpaFB4?=
 =?utf-8?B?VnUzdWpzK2szRTc1a0ZJdzdMM2VjRXpSL2dBaXh2aXVhdEgxekJUcytqbTU0?=
 =?utf-8?B?cklJVFd5d2ZvQjRzWDBKQXpiM3NRcFV3Z0F2bDVkTmxnSjIwUWNudnZwME42?=
 =?utf-8?B?bFdKeUJwRWZMVUE3Zng4L3pudDRPUG1KSGNobDdsMS9XQUhDanVsZTdEWndq?=
 =?utf-8?Q?3hcroJM5iXym0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rm55bnpzVjByY0tJUXQ4ZXNDNlVSNTFKbHdYbGJrZGdqQi9SM2laSzcyZTAy?=
 =?utf-8?B?N3FQVWI2dlR0SEJ1aHFIYzhNRXd4VXVobWdxS1pONjZpYWVHUkNxWGxsR21r?=
 =?utf-8?B?SzFrR252MllwWGVVL2drM1ZTZXlOSVlkcUZZQk9zS3JDeVNvWGRSb1RmVlk5?=
 =?utf-8?B?cW1PSUs5TUxoOURmUk9pdG12VzhMbUhMTENkNE1iZ1Ricm1XZ0dJQlk5L2VT?=
 =?utf-8?B?Q0ZPNzlYb2gwQnY4WnRTYW51MkNyL1l5REEvcldpK1F5N2pzNWErelFiVTlK?=
 =?utf-8?B?YVFJM1F0dUVQNCtreFBDYW1oZ2RNM3BqMTRieWZVN1oxZ21kaGZiQnhvZHV0?=
 =?utf-8?B?b1g3ODJqaVVLU3JXY0dGN3BsbTlWdE1hY1FJbC9tV2J2QkRTN0VCZXVMVFg2?=
 =?utf-8?B?b085QnduWW1Hd0JIUU5NWFVNOGtMclFxdU5WRWtIM2xvSWJsSlFZWlVJb0Vh?=
 =?utf-8?B?Z2ljS3JHajh2VXN4MXM3QkV4cjZvNVhOYVZWa2gzMWg5REZqZnlVSVF0M1pO?=
 =?utf-8?B?ek9NcllGNFZIc1M1ZEhJSSs0SE5wS3I2Y1ExdTFOdlNuZWRWVXdBMkVVTTZs?=
 =?utf-8?B?UkhTd0wzRWFWQXJLdGN0OHdzY1ZsNTR6bFlWT1FYeCtXWkZScVRFYUZFeG82?=
 =?utf-8?B?MWZFbkI0TTRDa3lKTWdqVnh6b0EvUkpYNlVQYnplNHcwcE9DQlE3YnBsMW00?=
 =?utf-8?B?bjVFclRsYnRUalZzaDRBZWlYMFdRTHUrWXk2L0NnNWlMdGhJZ2plVVJhaVdI?=
 =?utf-8?B?a3g4NzNJRllSc0JJSElabmJSWVVzaHVKRUNyUGJIOUhOeXltanE4bGwvQ2do?=
 =?utf-8?B?aGxWM283N2RkS1J0THU5TURkN0YvTG9mL2FvcmFQWSt2TjZHV3JtcDNCR0VL?=
 =?utf-8?B?VTV4M2ltRHU3NkM3T1p4QjIzY2NERlhMQWhaT1BLSjZuam0rMFhzRkl0WnFh?=
 =?utf-8?B?L09zUkRRT1JJMzA4V1BRUXNqR1ppME5aWTY3RkFDamk0a3p1TE9nYUhXU1NZ?=
 =?utf-8?B?SlovZzFiTWFEQktFNkFGREF0VXV2N2hDV0JrYzc5K1diS3B1WW8vSkRDMkFF?=
 =?utf-8?B?Tk9EMk1mc0IyRVpjcTlWZHdLMXU0M1NzV210QU0yRVJXQ295WFZBbFdyOFdy?=
 =?utf-8?B?MWw4Wjk3eit0bUlWNXZIWjVwVjlrV05DYWcweks3ZTZnWHptcmQyQ0dnLysz?=
 =?utf-8?B?WVc0RFI0YzI0RGJ6ai9BOS82WG55L2h0MnlJU2I2T1ZGWVFPMEpQQVpqL1Ur?=
 =?utf-8?B?WDhhTVpwY2hqNVF3Yk4rWHBRaWFsWjdNVmEyL01rSzlrSEZmY3pnU2tjcHRp?=
 =?utf-8?B?NU53VHd5ZkEzc1FJcG1BY0ZtZzJmTXdTdmdNTVJ4dHVxSFhvWU55a1NkSUsv?=
 =?utf-8?B?N3NlcmVuanZlRzdWc3cxNXNwWWNpT2FUMHBvNTVDZHVnOEVWOXU1RVIrUkZE?=
 =?utf-8?B?TCtYMlZNbTgvK3ZaUWxYUU03bnZVTHN0b0pPRi9SSjA4VmswOVU2VmxkRTJP?=
 =?utf-8?B?UU5acmxzKy9DditTcnZQMVo0MXZzMFRrVC9pSDh1d1B0L1JMeTR0Q21qcGZZ?=
 =?utf-8?B?NllUeVRkZ281ZG1xUU1CcnhYRDd5MzhyYkVOT3duSHhiM0NUN1d5K0o5V3FG?=
 =?utf-8?B?TEFqTERvMlAwS2xNc1JzdEx4Q202MDk1SG5sd0lYcDRDVjZ6MDV1eFdhU01U?=
 =?utf-8?B?QUtIZVhLUUw4WDkwVENacWszTitUMnJHbDN5OGpTVWpMRllJYWlFTFBoM0hr?=
 =?utf-8?B?aUNFZkw0SlFJZ2VHYkpWTzQyb3hYRDgwQVd1enNVT3BzTXgwUXMrMG1LZEFU?=
 =?utf-8?B?RzhQa20wMDhVMW9mVHczTHRlRlNGQ2NNc0t0NWZvOC9ORmxFc2xrMDQ1THpZ?=
 =?utf-8?B?c3VuMGE5NUw1YUhWc1cwSVFxVWZkclo4bm1BUHA3VTludUdFOUVRL3dkSTY3?=
 =?utf-8?B?VGFGbmxqbUdxVzZVUS9WaDFWNnk5RzBUb2hWRzNqM2RCcmlxZElGVzk3aDJi?=
 =?utf-8?B?YlA3UXg5bjExY1dzZFU4RFVQT1B5UlJTbFFhTWNUWTlRcGtqUVl1SkJMMFVN?=
 =?utf-8?B?MnU3d0hIYkdVUHgvZWR6eTRNMmc1cmVaektEQm9ETzM2KzQvb1RIRktmeVo3?=
 =?utf-8?Q?uZhCoDEAGLFYcWGhby+lbl76i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4976519-816e-46f4-50e6-08dcbaa7f8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 08:22:57.7632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RJCN7sALWcNvOVa8Ap0Icf4NA7UR2OOA4bZ+xgosNlW/mzDMW2Hqk7u31DfT/C7AdtTjriucmz6UWzaT8pETNhHdufHZWd5+lfXgA4eEd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6491

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcw
MCBjbG9jayBiaW5kaW5ncw0KPiANCj4gT24gMTIvMDgvMjAyNCAwOToyNiwgUnlhbiBDaGVuIHdy
b3RlOg0KPiA+PiBTdWJqZWN0OiBSRTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBB
ZGQgQVNUMjcwMCBjbG9jaw0KPiA+PiBiaW5kaW5ncw0KPiA+Pg0KPiA+Pj4gU3ViamVjdDogUmU6
IFtQQVRDSCAzLzRdIGR0LWJpbmRpbmdzOiBjbG9jazogQWRkIEFTVDI3MDAgY2xvY2sNCj4gPj4+
IGJpbmRpbmdzDQo+ID4+Pg0KPiA+Pj4gT24gMDkvMDgvMjAyNCAwNzo0NywgUnlhbiBDaGVuIHdy
b3RlOg0KPiA+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2Nr
OiBBZGQgQVNUMjcwMCBjbG9jaw0KPiA+Pj4+PiBiaW5kaW5ncw0KPiA+Pj4+Pg0KPiA+Pj4+PiBM
ZSAwOC8wOC8yMDI0IMOgIDA5OjU5LCBSeWFuIENoZW4gYSDDqWNyaXQgOg0KPiA+Pj4+Pj4gQWRk
IGR0IGJpbmRpbmdzIGZvciBBU1QyNzAwIGNsb2NrIGNvbnRyb2xsZXINCj4gPj4+Pj4+DQo+ID4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4N
Cj4gPj4+Pj4+IC0tLQ0KPiA+Pj4+Pj4gICAuLi4vZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLGFz
dDI3MDAtY2xrLmggICAgfCAxNzUNCj4gPj4+Pj4gKysrKysrKysrKysrKysrKysrDQo+ID4+Pj4+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNzUgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4+Pj4gICBjcmVhdGUg
bW9kZSAxMDA2NDQNCj4gPj4+Pj4+IGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLGFz
dDI3MDAtY2xrLmgNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1i
aW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0MjcwMC1jbGsuaA0KPiA+Pj4+Pj4gYi9pbmNsdWRlL2R0
LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAwLWNsay5oDQo+ID4+Pj4+PiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPiA+Pj4+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi5mYWNmNzIzNTJjM2UNCj4g
Pj4+Pj4+IC0tLSAvZGV2L251bGwNCj4gPj4+Pj4+ICsrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3Mv
Y2xvY2svYXNwZWVkLGFzdDI3MDAtY2xrLmgNCj4gPj4+Pj4+IEBAIC0wLDAgKzEsMTc1IEBADQo+
ID4+Pj4+PiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNE
LTItQ2xhdXNlKSAqLw0KPiA+Pj4+Pj4gKy8qDQo+ID4+Pj4+PiArICogRGV2aWNlIFRyZWUgYmlu
ZGluZyBjb25zdGFudHMgZm9yIEFTVDI3MDAgY2xvY2sgY29udHJvbGxlci4NCj4gPj4+Pj4+ICsg
Kg0KPiA+Pj4+Pj4gKyAqIENvcHlyaWdodCAoYykgMjAyNCBBc3BlZWQgVGVjaG5vbG9neSBJbmMu
DQo+ID4+Pj4+PiArICovDQo+ID4+Pj4+PiArDQo+ID4+Pj4+PiArI2lmbmRlZiBfX0RUX0JJTkRJ
TkdTX0NMT0NLX0FTVDI3MDBfSCAjZGVmaW5lDQo+ID4+Pj4+PiArX19EVF9CSU5ESU5HU19DTE9D
S19BU1QyNzAwX0gNCj4gPj4+Pj4+ICsNCj4gPj4+Pj4+ICsvKiBTT0MwIGNsay1nYXRlICovDQo+
ID4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX01DTEsgKDApDQo+ID4+Pj4+PiArI2RlZmlu
ZSBTQ1UwX0NMS19HQVRFX0VDTEsgKDEpDQo+ID4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRF
XzJEQ0xLICAgICAgICAoMikNCj4gPj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfVkNMSyAo
MykNCj4gPj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfQkNMSyAoNCkNCj4gPj4+Pj4+ICsj
ZGVmaW5lIFNDVTBfQ0xLX0dBVEVfVkdBMENMSyAgICAgICg1KQ0KPiA+Pj4+Pj4gKyNkZWZpbmUg
U0NVMF9DTEtfR0FURV9SRUZDTEsgICAgICAgKDYpDQo+ID4+Pj4+PiArI2RlZmluZSBTQ1UwX0NM
S19HQVRFX1BPUlRCVVNCMkNMSyAoNykgI2RlZmluZQ0KPiA+Pj4gU0NVMF9DTEtfR0FURV9SU1Y4
DQo+ID4+Pj4+PiArKDgpDQo+ID4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1VIQ0lDTEsg
ICAgICAoOSkNCj4gPj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfVkdBMUNMSyAgICAgICgx
MCkNCj4gPj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfRERSUEhZQ0xLICAgICgxMSkNCj4g
Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfRTJNMENMSyAgICAgICgxMikNCj4gPj4+Pj4+
ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfSEFDQ0xLICAgICAgICgxMykNCj4gPj4+Pj4+ICsjZGVm
aW5lIFNDVTBfQ0xLX0dBVEVfUE9SVEFVU0IyQ0xLICgxNCkNCj4gPj4+Pj4+ICsjZGVmaW5lIFND
VTBfQ0xLX0dBVEVfVUFSVDRDTEsgICAgICgxNSkNCj4gPj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xL
X0dBVEVfU0xJQ0xLICAgICAgICgxNikNCj4gPj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVf
REFDQ0xLICAgICAgICgxNykNCj4gPj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfRFAgICAo
MTgpDQo+ID4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0UyTTFDTEsgICAgICAoMTkpDQo+
ID4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0NSVDBDTEsgICAgICAoMjApDQo+ID4+Pj4+
PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0NSVDFDTEsgICAgICAoMjEpDQo+ID4+Pj4+PiArI2Rl
ZmluZSBTQ1UwX0NMS19HQVRFX1ZMQ0xLICAgICAgICAoMjIpDQo+ID4+Pj4+PiArI2RlZmluZSBT
Q1UwX0NMS19HQVRFX0VDRFNBQ0xLICAgICAoMjMpDQo+ID4+Pj4+PiArI2RlZmluZSBTQ1UwX0NM
S19HQVRFX1JTQUNMSyAgICAgICAoMjQpDQo+ID4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRF
X1JWQVMwQ0xLICAgICAoMjUpDQo+ID4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1VGU0NM
SyAgICAgICAoMjYpDQo+ID4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0VNTUNDTEsgICAg
ICAoMjcpDQo+ID4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JWQVMxQ0xLICAgICAoMjgp
DQo+ID4+Pj4+PiArLyogcmVzZXJ2ZWQgMjkgfiAzMSovDQo+ID4+Pg0KPiA+Pj4gTm8sIHlvdSBj
YW5ub3QgcmVzZXJ2ZSBJRHMuIFRoZXkgYXJlIGFsd2F5cyBjb250aW5vdXMuDQo+ID4+IEkgdGhp
bmsgZm9yIG1pcy11bmRlcnN0b29kLg0KPiA+PiBJIHdpbGwgcmVtb3ZlIHRoZSBjb21tZW50Lg0K
PiA+PiBBbmQga2VlcCBpdCBpcyBjb250aW51b3VzLiBUaGFua3MuDQo+ID4+Pg0KPiA+Pj4+Pj4g
KyNkZWZpbmUgU0NVMF9DTEtfR0FURV9OVU0gIChTQ1UwX0NMS19HQVRFX1JWQVMxQ0xLICsgMSkN
Cj4gPj4+DQo+ID4+PiBObywgbm90IGEgYmluZGluZy4NCj4gPj4NCj4gPiBJIHdpbGwgbW9kaWZ5
IGJ5IGZvbGxvd2luZy4NCj4gPg0KPiA+ICNkZWZpbmUgU0NVMF9DTEtfR0FURV9SVkFTMUNMSyAg
KDI4KQ0KPiA+ICNkZWZpbmUgU0NVMF9DTEtfR0FURV9OVU0gICAgICAgKFNDVTBfQ0xLX0dBVEVf
UlZBUzFDTEsgKyAxKQ0KPiANCj4gTm90aGluZyBjaGFuZ2VkLiBTdGlsbCBub3QgYSBiaW5kaW5n
LiBXaHkgZG8geW91IHNlbmQgdGhlIHNhbWUgYW5kIGV4cGVjdA0KPiBkaWZmZXJlbnQgcmVzdWx0
PyBEcm9wLg0KPiANCj4gQWRkcmVzcyBmZWVkYmFjayBzZW50IHRvIHlvdSBmcm9tIHByZXZpb3Vz
IHZlcnNpb25zIG9mIHRoZSBwYXRjaHNldC4NCj4gVGhlcmUgd2FzIG5ldmVyIGEgcmVwbHkuDQpT
b3JyeSwgbWlzLXVuZGVyc3Rvb2QuDQpTaW5jZSB5b3UgdGhpbmsgIiNkZWZpbmUgU0NVMF9DTEtf
R0FURV9OVU0iIG5vdCBhIGJpbmRpbmcuDQpEbyB5b3UgbWVhbiBJIHNob3VsZCAjZGVmaW5lIFND
VTBfQ0xLX0dBVEVfTlVNIGluIGNsayBkcml2ZXIsIG5vdCBpbiBiaW5kaW5nIGhlYWRlciwgYW0g
SSByaWdodD8NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

