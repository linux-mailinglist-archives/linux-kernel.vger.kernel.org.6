Return-Path: <linux-kernel+bounces-289591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B44B9547E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D48280CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0451B86C7;
	Fri, 16 Aug 2024 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HDnte9DA"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2048.outbound.protection.outlook.com [40.107.215.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4F1AD9D9;
	Fri, 16 Aug 2024 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806975; cv=fail; b=GDo3R9zGRdSUIlDe5NhqskPy4aaZ26uBeNNssrceKwDry4vMoU68LV7suyAk5PTP5lbq21egC0lg2OdYz2VwnaLIuGCCRQO9wXH6Ls+W+q5zuLy/OXwgpnMJ2JclPewQsP2w0kdT7P1B1b5WtlNHAKzv9X6EH2LEsx0UnPrx1xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806975; c=relaxed/simple;
	bh=hzaKDi++phYGOfeWTEnfxqtb6WUfiBu8NyypBNFK3GE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kMQclOKygEpTsr8eHKcrArYquLuU3rUoJ3eYPryvz32SVKpj640uG1tSwxn/2y2wL3Inyzfm4zkoq0tDBhkw11tW40KzEeQNmOFQpEu78HEoATarlk1b2fFu2vVOA/8CTbFo2cd6PVv6YoMDN21ZTw+tqVBlZ19B64b/Q64fsmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HDnte9DA; arc=fail smtp.client-ip=40.107.215.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJ7wKKHExTrLw4CZVHsjoDtBXPZveRsJn1VoUhFmph6PVGdX/cbJt/CM6fcV/3M1oAfun7zyeWRrrqtz+e35ViPHENQsspLkTs64oUI6883mMRJ/JPJj8eJMxK+z/nTzRJ0uvRpCK5VejQwWo7hayp5X71OX3qZMPcmL+2eNcso3twHJ716hCQmTdoO5vFxSXkmWsgKevoWa8Iz/UqW+STVtcWPffM0htfrK45y1fZL5//P6eIXHazsh3IifhYlhIp8orlH0UN0tLglN75FIaHG9HO+0iY50ktmIec2yjHqBBiP0kulG+2zRK30ijXTHZwmn3e3h1lLCFXZXW9gipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzaKDi++phYGOfeWTEnfxqtb6WUfiBu8NyypBNFK3GE=;
 b=xwRiepkh/t7SqQjALA72tTQ19lR54+RNVjHqMAbq/DNI0e8TLbwevkDxPf3uCpVrKJ7+2EDF0O5ZNmwj1izzMKoVnW5EHUHVgX+ETrmXii9o4YBWZSsZYhNMyt6RDG+AsAz7/7lhBnuKFt7GGYPNQhkXNcan2k/Xmo8r7wnnRnJoX0ETSozhidcUq7IUGYy9E2lfa1l40yw5djErNyMj9teDEg51KIH+YURh/dvvj/zfr9lokeB8CYpc8nZE3tR1SjU828OD8KhAie2xEowLaVSyyoH+9IXJQ2CnYEvO/WXOTB3ADB3BWRSK6JFLePIv7NjEOeeAv8daX+fiAAyZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzaKDi++phYGOfeWTEnfxqtb6WUfiBu8NyypBNFK3GE=;
 b=HDnte9DAVDXLu0AJdId+8Wka+mlvcNV16rMCx1LLm+z9C4UOHAtl7ZQdt6usvscZJvf92hRlg46TMPIsarvYCpVqf4O3/J4JpQN4qm4a5V34TrnXDBjDJQmdoJ2FT9lRmYPoBsM2uufRIdKZM81QEjAAK5/H7OJY3l4kKi03AH9k4yTmqLxEeRWzzpZ4tVCuzyYwWUw52DhwOQsZtab/99uXSqZZo1VCdv4nqNm0tkISCczzU649PDI6RvhNih14CqyeQYHBJrOso5oDxRcQdsnby21+Wa6wLlTSotcGe3n3u4uYJlirDYhY73y7l9HQuumidkNH85Qwu9TVuuKnTQ==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by TYZPR06MB5076.apcprd06.prod.outlook.com (2603:1096:400:1c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 11:16:08 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 11:16:08 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogY2hlY2sg?=
 =?utf-8?Q?Null_pointer_in_EP_callback?=
Thread-Topic: [PATCH] usb: gadget: u_serial: check Null pointer in EP callback
Thread-Index: AdrvyMyJeJV7tcOcTkOYhAFaznDU/wAAsiUAAABmjmA=
Date: Fri, 16 Aug 2024 11:16:08 +0000
Message-ID:
 <TYUPR06MB621717DE00C464BE67650C16D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB62172CC6BA9647EF769D4DF2D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024081635-slacking-buzz-acce@gregkh>
In-Reply-To: <2024081635-slacking-buzz-acce@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|TYZPR06MB5076:EE_
x-ms-office365-filtering-correlation-id: 08342143-9d2d-494e-3546-08dcbde4d3eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WVBpSjRkMCtnR01Qck1nS3hRcVZnMlBreGVLV2t2djI4SnNoQXpTOXQ3LytU?=
 =?utf-8?B?OFpvM0VaZnExRVo0UTVnaFBrUkE2cmlkbk82WG5RRkJIVGNsUnF6azlOV0N2?=
 =?utf-8?B?M2JaaFg2cWt4bk1KWWI1MU9KaURoYWZLMFh2dkxwYVVyKytVUkdod1JkVFRS?=
 =?utf-8?B?bEhSbi9Ba0hDbnZRai9hU1NaWlZRTzFWenhYa2ZxTjRjR2NZRUhYQ3I0KzlX?=
 =?utf-8?B?SjROSDVVMjNUT1JvZk5mNG5oTGJ4ZGYxQklEdkFrMnREeExCTm1hOW9EWjVJ?=
 =?utf-8?B?K3VZRmkyYzJpeTU0d2tNUURITjNoSktFTXFQdHJkekt4MlVFSGYwV1NxZCtV?=
 =?utf-8?B?QlpnSlh0dzF5azVUTlAzNVRONGVEa3dqMWpoUHNLNXBmZTBIRXJHU00xQnJo?=
 =?utf-8?B?Mlc1QUhnVHhVQkpNNCtna0U2WTBUZ2lWVFdSY09iWXU4aUhhbnZkNXdRNi9V?=
 =?utf-8?B?Yit4M2NNb21uUGJFYkhvdjdSakVzblFlc0ZmMkZicnhhSjFvTmI4U2FSU1Jh?=
 =?utf-8?B?WWJXQ3ZINksvbzkxcUhiUzUwdGoyZ1NWaDFMWFpJQXZ1ZnVYeTUwV2tqdXU4?=
 =?utf-8?B?bGtHblRDYzVBS29waEZFTkhselRmcUZRR1VvVzZDd0YvQ25zR0RUcFg1L0dn?=
 =?utf-8?B?NEVteGZ4UVJxdmV4ZGNoRkxUSTc0VjBtRDZNSHJ5RDBzblFPK0hIbzZBcTN2?=
 =?utf-8?B?MUJDRlc4RkNaa0RScUQrcUhvMFpCQnZsMHhuVURSR1dUUFdTbEdoTWRIRWtW?=
 =?utf-8?B?RFprNnl1OVJPT0g4WDNjQW42MTZjU0tpSDVHc2VySTdTWlNjdlQvTUpFcGFI?=
 =?utf-8?B?V09lVkJqZ0pHaHNvSklhZXpkRHhBT3NnZDlISWdZUDlBUkorSk9XUlplN0tY?=
 =?utf-8?B?dERtNUFRMGRINTB6ejBwTGlrQk4wNURjN1BuMDFCOVZvbWx6ZVZ6bWlkK2Fi?=
 =?utf-8?B?WGZxbk4zaThZMWJ2eXVOc2xRdG43WmhnUlNjdzcxRFJ0Z0c2OVdoNzBoZXhC?=
 =?utf-8?B?RnFBaWRrdDZrLzhudmhyNEF4eUoydTE1RnNxUmVWZnA2MWM4c3JzY2hDbEMv?=
 =?utf-8?B?WmpiTHFiTlE3Ymh5Z3c4SVJSYU1qWGJndm5lNEZuZlJNdzdGcy9uRGJMR0xD?=
 =?utf-8?B?QUVsb2pEM2IvRE5FL1pkTEpOU3h0U2hMNGRrSm5IUDV6bmRWd2ExLzludGFX?=
 =?utf-8?B?dTZUdGRUSXBxRnp3Sk9aR2dMQXpJVGZxRUlSejlaRFZZd1MvQ3p2NklQR1Jy?=
 =?utf-8?B?dG5vRVhnOXpYWDhVRXJadzlFbFZ6ZjllTmNNMFR0QkZvanlDL3lLRG95bXhP?=
 =?utf-8?B?ZTh6SzI3T3U5YTJaTSsvaDRFQzd6em9TWUsvM25SeE1yT2FTL2JnUUJod3dH?=
 =?utf-8?B?SWJCWTBpUkNQaTdwV0lnTmNOUWpSaFEyc0hZOW1XdUdUV0liWGQ3ZmovcTJJ?=
 =?utf-8?B?TGpvMFh4ZlFTZDA0YWUxbitXcDJZRXoyZ1M3SmYrSnk1UTdVb1p3V3ZzRUFh?=
 =?utf-8?B?ek9tRjZSUVJGeVNsUys4cHNhNE1jazJhYmh1cVNhY2cwSGQrUklxV2NWTk1t?=
 =?utf-8?B?ZUE5Z2VadFN6VG9YR25nNTF0QS92Ynl4Q0lXT1hwMG5nZG5MZXRjVFd3MjR5?=
 =?utf-8?B?UWNBZi90aVBvNDFBL3ZPeFlHZFZoK1d3V21zY1VLL0NQRHZEMU1oaUxtV0JP?=
 =?utf-8?B?SnFqdFpSWm14U0I2QTJESHd6YXJmSGliSzNCU1ExdnpLMzcxV0hrQU54Qnhl?=
 =?utf-8?B?WU55SjZSOTlWU3JuT3BqeXYrMmljREl1bmV0RklLQk5vMmtMckgzbDVnUEtE?=
 =?utf-8?B?dGRvYmRCMHBNaWQ1aGdwU3dkUFREL0lrazUyck92S1FiK0RMaXIxVTI3YmFr?=
 =?utf-8?B?bDByMnZ3RmVyZ1NEdXk1SjNIb1Q5K2MyZ2xlWEpkQ3o3WHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFpuV3pKTVBwSnhJRVppaEZOeHZCcVdnNmlYeG14Sm9lZHdDcTlUbUNlM013?=
 =?utf-8?B?dzN5SjNKamcwd2JzM2M3b2RCVVR1ejR5YnhhZ0FWR3o3T085ZlowQ1l1VVcx?=
 =?utf-8?B?WUV2M09kK1RGdjUyWFplaGJKSnRJQzV0VEhuUFlUbFZTRzNpMEdkN3VnSzF3?=
 =?utf-8?B?dVREMXo1ckR6T0FWQnpRa1d2MjJpNDhsV25xeDNDNnFFNnlzV2MycnVSeFJp?=
 =?utf-8?B?RmpYUURTUzN6czhURlRHcWRWODc0NUROVjZUWkxlL29BeWprVHhGOENsMmFl?=
 =?utf-8?B?ZFM4VFNTM005V0xHUXVua0JWNzlFVVR3UVBUVnE0MjVTdWhlclQ1a0pLdUdi?=
 =?utf-8?B?UUtQVjBnY0ttbXJDNzF6bGpSbkREbUtCRXRzejlVNklyODIySTZORmRLQTBG?=
 =?utf-8?B?QVFNbmFMNVgrbjNuazZaQkZJeWkwVU5mY1U5UkJvV054ajllWlBQM1RQNzVP?=
 =?utf-8?B?cldOcXRZdWlXckZNNnhuenJoZjFDNmwwZVFzeGxJYlE3YTNZRTF0WURSTks5?=
 =?utf-8?B?RW8ySjRWZk9naU82V09Xb09rcHJjcHNXWlVpVjZCb3dYbkpEbGJsQ0ptNGYv?=
 =?utf-8?B?L0hDS05ucHNJbHQyY1J4TnAyZmFhK0EyTndlYThUWWZKSG1Sdk05a3pLcS95?=
 =?utf-8?B?NDlZL3ZBbFNBbWdzRTBIdmt3ajh1ZG5ZVEk0RFFNMG9tZWtqMUxqdXM2SkQ1?=
 =?utf-8?B?UUJmb3FUSU0xSVV6WWV3aWdRcnp1MXA0R0dJUnBaU1FnVmZDbkh4ZzZmbzB3?=
 =?utf-8?B?Vmw2MStiSXZpUFdnYmlEK1RSRnJkOWFockZhRWhncHpnUTh4WEt3NGREODRL?=
 =?utf-8?B?d0dZM1lyU3pzZG5va0hmbGRDU2Y3cndyVDBXV2huZWJseU05N0krZ2ZmUWdi?=
 =?utf-8?B?QklqWldhdzdNSGZNRFdqeVVqUWw0YnIvZVdYSlIwTWhMV1g1Vkw3d2tDa0NS?=
 =?utf-8?B?aGswNUVleEd6aS9LZEJhdURkU0dWU0lyWDRMdEJuaXdqd2F2WUpqMUhIWExz?=
 =?utf-8?B?eVZZVG1NbXh2VkJ0RFFwdkZuYzYwTUcxOThNZ3RIYmVwSUwrQi9tNEk0Qmww?=
 =?utf-8?B?dEtNYmJRVmxaQUVnNVNrUUorbFhJdTc1RE1hZE5GUkNaNnd1SXJFRW5KMis0?=
 =?utf-8?B?OXhwZkZXUTJHSnhQckRmUlExaHlHMXhtMHBZRVh4K2tNWEt3SjhPRnpaWmsw?=
 =?utf-8?B?RGdPWnJEYi9iOVFhNUVKbEUxRC9PZEVidDhsb3kzOEJtTExkVlRPRU1aY1lZ?=
 =?utf-8?B?SG93d0pVemVQUVVhb2M1UzJILzl5Y3F5UWZYWjJxWVBVUDNaTWFERkp1VjlN?=
 =?utf-8?B?RzQ1T1BhQ0toMUtrekpOMUJMQ1ZLOWtOcnd4bjZUS0NUeU5PY0dXbDhGb2FH?=
 =?utf-8?B?MjRyOWxocVVJNytZNVNHelFyMkhOaFNhMFVvRWNZYW9GVWI3N2E5ZU80NDRz?=
 =?utf-8?B?ajFJSno0dGFnQ2QzUm5WZ3JoVzZhQWx0dzFnaldOVS9uV2s1MHY5V3ZSdGFK?=
 =?utf-8?B?TWdjdFRVTHhVRUFZWkZ1Z05Qejk5UDNxTDhnMFNtRVVITnc1cVFWaFNyS29o?=
 =?utf-8?B?aGR1WEdDWkNObU9wazZXQkNIMWlBQ2JxcGtQQWhNaGxwVlFObXVtUWZnaHZO?=
 =?utf-8?B?NzRTa0Q4VXk3L2V0MGw2eGluTzUzeHU4Q3FNeCtMY1hVWHFZTE9SZ3Ezd2pn?=
 =?utf-8?B?bDE5VCtIWEVCS1czQVhvZXdDTjlteDZqbnllWEppVG1CbmRUTms5b1V1RkYy?=
 =?utf-8?B?dWJJWDRjOXQzVzFmUVg5NXVIdVdLbm5YVEZXeWErb04rK0h4alFJMG9NOEVh?=
 =?utf-8?B?Z2V5dWFza0xxMDJ3eGF3MHpDeEFVWEtpNlN1OWVJMjVnRkxOWW9uWlB1Z2gv?=
 =?utf-8?B?UHh3cXZFSmdZVGJsTUNYc1NhZ2RvQXJzU0RrVDJqM1BoYmx4bm85dXd6TDZi?=
 =?utf-8?B?YTcwalphTVNEY1BhVkVIN2k0d3R6UVl5MWs3RXVwaHZEY0RIdXdjb01EVml6?=
 =?utf-8?B?aFM3L2IyajFyVUZocytTRXljME5XUGdjd0lIUWFXS1RVbFk0eUgvaEtESUpi?=
 =?utf-8?B?WHFxQnZBKzBzK3YxQVMyMTZTL2ZkdjU2SExrL2lMODdKQlBieVhLejh2NHdB?=
 =?utf-8?Q?Aa4o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08342143-9d2d-494e-3546-08dcbde4d3eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 11:16:08.5100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4h3SRXGKj6ECt10Ix/gUqIuMuqpN6l/Wh6MttHWZ4QkM22qDRaOwZ/otPP2UA4HytG5V7ULa7nZUAlCa4++Bwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5076

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KUTogV2hhdCBpcyBjYXVzaW5nIGRyaXZl
cl9kYXRhIHRvIGJlIE5VTEw/ICBBbmQgd2hhdCBwcm90ZWN0cyBpdCBmcm9tIGhhcHBlbmluZyBy
aWdodCBhZnRlciB5b3UgY2hlY2sgZm9yIGl0Pw0KQTogVGhpcyBpcyBhIHZlcnkgaW4tZGVwdGgg
cXVlc3Rpb24sIGFuZCBJIG5lZWQgdG8gaGF2ZSBhIGRlZXBlciB1bmRlcnN0YW5kaW5nIG9mIHRo
ZSBjb2RlIGJlZm9yZSBJIGNhbiBhbnN3ZXIgaXQuIA0KICBKdWRnaW5nIGZyb20gdGhlIGNyYXNo
IHN0YWNrLCB0aGlzIHBhdGNoIGN1cnJlbnRseSBoYXMgaW1wcm92ZWQgdGhlIGNyYXNoIHByb2Js
ZW0uDQoNClRoYW5rcw0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gDQrlj5Hp
gIHml7bpl7Q6IDIwMjTlubQ45pyIMTbml6UgMTk6MDENCuaUtuS7tuS6ujog6IOh6L+e5YukIDxo
dWxpYW5xaW5Adml2by5jb20+DQrmioTpgIE6IHF1aWNfcHJhc2hrQHF1aWNpbmMuY29tOyBxdWlj
X2pqb2huc29uQHF1aWNpbmMuY29tOyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBvcGVuc291cmNlLmtlcm5lbCA8b3BlbnNvdXJjZS5rZXJu
ZWxAdml2by5jb20+OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnDQrkuLvpopg6IFJlOiBbUEFU
Q0hdIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogY2hlY2sgTnVsbCBwb2ludGVyIGluIEVQIGNhbGxi
YWNrDQoNCk9uIEZyaSwgQXVnIDE2LCAyMDI0IGF0IDEwOjQ5OjE5QU0gKzAwMDAsIOiDoei/nuWL
pCB3cm90ZToNCj4gRnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KPiANCj4g
QWRkZWQgbnVsbCBwb2ludGVyIGNoZWNrIHRvIGF2b2lkIHN5c3RlbSBjcmFzaC4NCj4gDQo+IFVu
YWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFs
IGFkZHJlc3MgDQo+IDAwMDAwMDAwMDAwMDAxYTggcGMgOiBnc19yZWFkX2NvbXBsZXRlKzB4NTgv
MHgyNDAgbHIgOiANCj4gdXNiX2dhZGdldF9naXZlYmFja19yZXF1ZXN0KzB4NDAvMHgxNjANCj4g
c3AgOiBmZmZmZmZjMDBmMTUzOWMwDQo+IHgyOTogZmZmZmZmYzAwZjE1MzljMCB4Mjg6IGZmZmZm
ZjgwMDJhMzAwMDAgeDI3OiAwMDAwMDAwMDAwMDAwMDAwDQo+IHgyNjogZmZmZmZmODAwMmEzMDAw
MCB4MjU6IDAwMDAwMDAwMDAwMDAwMDAgeDI0OiBmZmZmZmY4MDAyYTMwMDAwDQo+IHgyMzogZmZm
ZmZmODAwMmZmOWE3MCB4MjI6IGZmZmZmZjg5OGU3YTdiMDAgeDIxOiBmZmZmZmY4MDNjOWFmOWQ4
DQo+IHgyMDogZmZmZmZmODk4ZTdhN2IwMCB4MTk6IDAwMDAwMDAwMDAwMDAxYTggeDE4OiBmZmZm
ZmZjMDA5OWZkMDk4DQo+IHgxNzogMDAwMDAwMDAwMDAwMTAwMCB4MTY6IDAwMDAwMDAwODAwMDAw
MDAgeDE1OiAwMDAwMDAwYWMxMjAwMDAwDQo+IHgxNDogMDAwMDAwMDAwMDAwMDAwMyB4MTM6IDAw
MDAwMDAwMDAwMGQ1ZTggeDEyOiAwMDAwMDAwMzU1YzMxNGFjDQo+IHgxMTogMDAwMDAwMDAwMDAw
MDAxNSB4MTA6IDAwMDAwMDAwMDAwMDAwMTIgeDkgOiAwMDAwMDAwMDAwMDAwMDA4DQo+IHg4IDog
MDAwMDAwMDAwMDAwMDAwMCB4NyA6IDAwMDAwMDAwMDAwMDAwMDAgeDYgOiBmZmZmZmY4ODdjZDEy
MDAwDQo+IHg1IDogMDAwMDAwMDAwMDAwMDAwMiB4NCA6IGZmZmZmZmMwMGY5YjA3ZjAgeDMgOiBm
ZmZmZmZjMDBmMTUzOGQwDQo+IHgyIDogMDAwMDAwMDAwMDAwMDAwMSB4MSA6IDAwMDAwMDAwMDAw
MDAwMDAgeDAgOiAwMDAwMDAwMDAwMDAwMWE4IENhbGwgDQo+IHRyYWNlOg0KPiBnc19yZWFkX2Nv
bXBsZXRlKzB4NTgvMHgyNDANCj4gdXNiX2dhZGdldF9naXZlYmFja19yZXF1ZXN0KzB4NDAvMHgx
NjANCj4gZHdjM19yZW1vdmVfcmVxdWVzdHMrMHgxNzAvMHg0ODQNCj4gZHdjM19lcDBfb3V0X3N0
YXJ0KzB4YjAvMHgxZDQNCj4gX19kd2MzX2dhZGdldF9zdGFydCsweDI1Yy8weDcyMA0KPiBrcmV0
cHJvYmVfdHJhbXBvbGluZS5jZmlfanQrMHgwLzB4OA0KPiBrcmV0cHJvYmVfdHJhbXBvbGluZS5j
ZmlfanQrMHgwLzB4OA0KPiB1ZGNfYmluZF90b19kcml2ZXIrMHgxZDgvMHgzMDANCj4gdXNiX2dh
ZGdldF9wcm9iZV9kcml2ZXIrMHhhOC8weDFkYw0KPiBnYWRnZXRfZGV2X2Rlc2NfVURDX3N0b3Jl
KzB4MTNjLzB4MTg4DQo+IGNvbmZpZ2ZzX3dyaXRlX2l0ZXIrMHgxNjAvMHgxZjQNCj4gdmZzX3dy
aXRlKzB4MmQwLzB4NDBjDQo+IGtzeXNfd3JpdGUrMHg3Yy8weGYwDQo+IF9fYXJtNjRfc3lzX3dy
aXRlKzB4MjAvMHgzMA0KPiBpbnZva2Vfc3lzY2FsbCsweDYwLzB4MTUwDQo+IGVsMF9zdmNfY29t
bW9uKzB4OGMvMHhmOA0KPiBkb19lbDBfc3ZjKzB4MjgvMHhhMA0KPiBlbDBfc3ZjKzB4MjQvMHg4
NA0KPiBlbDB0XzY0X3N5bmNfaGFuZGxlcisweDg4LzB4ZWMNCj4gZWwwdF82NF9zeW5jKzB4MWI0
LzB4MWI4DQo+IENvZGU6IGFhMWYwM2UxIGFhMTMwM2UwIDUyODAwMDIyIDJhMDEwM2U4ICg4OGU4
N2U2MikgLS0tWyBlbmQgdHJhY2UgDQo+IDkzODg0NzMyN2E3MzkxNzIgXS0tLSBLZXJuZWwgcGFu
aWMgLSBub3Qgc3luY2luZzogT29wczogRmF0YWwgDQo+IGV4Y2VwdGlvbg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jIHwgMTYgKysrKysrKysrKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYyANCj4gYi9kcml2ZXJzL3VzYi9n
YWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KPiBpbmRleCBiMzk0MTA1ZTU1ZDYuLjY1NjM3ZDUz
YmYwMg0KPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KPiBAQCAtNDU0LDYg
KzQ1NCwxNCBAQCBzdGF0aWMgdm9pZCBnc19yZWFkX2NvbXBsZXRlKHN0cnVjdCB1c2JfZXAgKmVw
LCANCj4gc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXEpICB7DQo+ICAJc3RydWN0IGdzX3BvcnQJKnBv
cnQgPSBlcC0+ZHJpdmVyX2RhdGE7DQo+ICANCj4gKwkvKg0KPiArCSAqIFdoZW4gcG9ydCBpcyBO
VUxMLCBSZXR1cm4gdG8gYXZvaWQgcGFuaWMuDQo+ICsJICovDQoNCk11bHRpcGxlIGxpbmUgY29t
bWVudHMgZm9yIHNvbWV0aGluZyBsaWtlIHRoaXMgcmVhbGx5IGlzbid0IG5lZWRlZC4NCg0KPiAr
CWlmICghcG9ydCkgew0KPiArCQlwcl9lcnIoIiVzLCBmYWlsZWQgdG8gZ2V0IHBvcnRcbiIsIF9f
ZnVuY19fKTsNCg0KTm8gbmVlZCBmb3IgdGhpcyBlaXRoZXIsIHJpZ2h0Pw0KDQpCdXQgaG93IGNh
biB0aGlzIGhhcHBlbj8gIFdoYXQgaXMgY2F1c2luZyBkcml2ZXJfZGF0YSB0byBiZSBOVUxMPyAg
QW5kIHdoYXQgcHJvdGVjdHMgaXQgZnJvbSBoYXBwZW5pbmcgcmlnaHQgYWZ0ZXIgeW91IGNoZWNr
IGZvciBpdD8NCg0KPiArCQlyZXR1cm47DQo+ICsJfQ0KPiArDQo+ICAJLyogUXVldWUgYWxsIHJl
Y2VpdmVkIGRhdGEgdW50aWwgdGhlIHR0eSBsYXllciBpcyByZWFkeSBmb3IgaXQuICovDQo+ICAJ
c3Bpbl9sb2NrKCZwb3J0LT5wb3J0X2xvY2spOw0KPiAgCWxpc3RfYWRkX3RhaWwoJnJlcS0+bGlz
dCwgJnBvcnQtPnJlYWRfcXVldWUpOyBAQCAtNDY1LDYgKzQ3MywxNCBAQCANCj4gc3RhdGljIHZv
aWQgZ3Nfd3JpdGVfY29tcGxldGUoc3RydWN0IHVzYl9lcCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVz
dCANCj4gKnJlcSkgIHsNCj4gIAlzdHJ1Y3QgZ3NfcG9ydAkqcG9ydCA9IGVwLT5kcml2ZXJfZGF0
YTsNCj4gIA0KPiArCS8qDQo+ICsJICogV2hlbiBwb3J0IGlzIE5VTEwsIFJldHVybiB0byBhdm9p
ZCBwYW5pYy4NCj4gKwkgKi8NCj4gKwlpZiAoIXBvcnQpIHsNCj4gKwkJcHJfZXJyKCIlcywgZmFp
bGVkIHRvIGdldCBwb3J0XG4iLCBfX2Z1bmNfXyk7DQo+ICsJCXJldHVybjsNCj4gKwl9DQoNClNh
bWUgcXVlc3Rpb24gaGVyZSwgd2hhdCBpcyBrZWVwaW5nIGl0IGZyb20gY2hhbmdpbmcgcmlnaHQg
YWZ0ZXIgeW91IHRlc3Q/DQoNCnRoYW5rcywNCg0KZ3JlZyBrLWgNCg==

