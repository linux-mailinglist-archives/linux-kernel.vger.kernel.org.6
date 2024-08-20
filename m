Return-Path: <linux-kernel+bounces-293597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D050B9581C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 348B6B227D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FC118B468;
	Tue, 20 Aug 2024 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FSvIpMCM"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2044.outbound.protection.outlook.com [40.107.215.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2B44595B;
	Tue, 20 Aug 2024 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145226; cv=fail; b=fYr4LMCGq5BxkMrrqsR20SRCY6yISz9BL5NNSWaMSmJws/8OiJAmWvN72W8XHpCsAwfRCr8OGHkkFCApE8BevoZSPtyt7GYarEQdIurCx6Satb/gdqR6EZ869pOplNK4YytTEy+9cbvqiP6L6wZepuP9ehqhCfvw/nu27jkJ/Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145226; c=relaxed/simple;
	bh=lyKSDoSYB0oIxqHFPvXuGwFMuIySYsD9BE2Qzh5zPLY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Iea8kA6GdKLvL7V17nnO1tdK3gzf8909hpwMQgNKQTWtRwfOZ4sAyBjcwcb0iimjBaslU3c9E16q++knO24PbnrcIGzDMNEzYEvoh97SMDxEMMD7Rxy3xC9fwg7u+rhne+MBaR+zdFf1EZW8F+iFRexe9S/ESyv8oXAmgwIuy3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FSvIpMCM; arc=fail smtp.client-ip=40.107.215.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McZtI58YVsYYjYlw95ZlZpQOFV6qyOZU5crAEe+oYprnsUSTezsLvXJpnUp5+xanJWufn92OdZtUjlhGUF3qQXOhu2Llg2T4E8LjGoMjOgMmtE7JBQbo1IrWrFb4fBYmymASEhMVhl4so2Nh/CqKcq7evFr4TO1o4Y846wC+In9InM1uGjtb8Hc+U+brtscWCmgfAluurLzautiDUREgQitCGj2h1keba2/jO6z/UjTpijKY1UceCuOIXrP6pc/NNLYd+L+r8pH7T1l+08Yw4RYxx7sm7kPT1yCUMOp/eEEjPGwDaQZA47E+vN7WaJmVASeSWS2bCFBppbq07h0Ddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyKSDoSYB0oIxqHFPvXuGwFMuIySYsD9BE2Qzh5zPLY=;
 b=MbC2GBXpXH1n0brEBXpe/HQv6dEXnajpje+76RMD0I1lGcsv2a4xKjH9fYFYUCxib3c1tYnQLVfFulMILPuERYpYWi52OoEDzModQJWkgkYFr8U91axikIFkdMbSitJExattHsNbwGmodARemWs4qDdc+Ng2/ZKit5BDsEE9dL/zZQod8i8xg9JZtuhG4RWTCers+Bg19VdeQCOTsfmYjcUkDbbC6VDUsNG735dfbblA7qPOeR26RnPiT2yROH+yQ2KP5f5VpSF/r4ln69biHLfDIm/NLPFP7nPrD/DJ1fzSOKNqMNGTmP2aaBDBnTfVzLqqYjvoO0oRxQJNhFFZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyKSDoSYB0oIxqHFPvXuGwFMuIySYsD9BE2Qzh5zPLY=;
 b=FSvIpMCMhjgqDKvyIiILHXfjqNO8SFcuT+Ui95GBF47G61GQKiA3GdmaDaCl9hx6BUqtqSY7o22qzP08cfnYoFNfyQCSa2We6GR8SQ6jeNpnftZrfk6kuUPFy41cICkhOEsj6hHPM/x5gj9ZaitUFbHKEtZh4WZ8PI42+waeU1geSpM+Jh4RxCUNSD4Q79w3WsxgfSsFFJsId8AFwrCeKH6zjiRS6YjK7x/lrFTxOqEDBRJFy9AU908EgOK4Yz3UTynwoI29wxRJQ6/L138dP6hE6ixkg4imY0ChL35d+kjsTpjImy3+9DW0kq4NU5ETZ+qFZcyCMTdCi1RDocworA==
Received: from PUZPR06MB6224.apcprd06.prod.outlook.com (2603:1096:301:116::8)
 by PUZPR06MB5745.apcprd06.prod.outlook.com (2603:1096:301:f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Tue, 20 Aug
 2024 09:13:36 +0000
Received: from PUZPR06MB6224.apcprd06.prod.outlook.com
 ([fe80::d489:3d1:904e:8b73]) by PUZPR06MB6224.apcprd06.prod.outlook.com
 ([fe80::d489:3d1:904e:8b73%3]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 09:13:36 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjFdIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogY2hl?=
 =?utf-8?Q?ck_Null_pointer_in_EP_callback?=
Thread-Topic: [PATCH v1] usb: gadget: u_serial: check Null pointer in EP
 callback
Thread-Index: Adry4M3h7bC0KrGtSX2msjjieYnaWw==
Date: Tue, 20 Aug 2024 09:13:36 +0000
Message-ID:
 <PUZPR06MB622403392E76A64749D068F6D28D2@PUZPR06MB6224.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB6224:EE_|PUZPR06MB5745:EE_
x-ms-office365-filtering-correlation-id: eeb9adfc-f601-42ef-c83a-08dcc0f85f62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmZwdXg0MlVCRi9GRThJQU03Qi9xSVRuY3BvUHhqUlJBSVlDV1Q5aHVpbE9X?=
 =?utf-8?B?dzhvNFk3WStoUVhjVGdtOXFpZ2RNaFdFVFc1VlUvME9IOHR0UVJTY0hLTFFN?=
 =?utf-8?B?d0lraTBJeHUxSStGYTJXOHZNYmwvQUdOY2lHTXlKK285V1hHV2lyYkxSSnpX?=
 =?utf-8?B?WEdmQlBraUk1TWFlTGwvMk1KMnd2bHBnL2RCdWI2NFpyTWhobTN2ZklXQUl0?=
 =?utf-8?B?bG1vUk14aVo0dWpiVGxTYTdBeVloODQ2MmVlR1pOdHJYa1pTK0tzcm1abXdL?=
 =?utf-8?B?ZGdTYU1NYTI0S1BKSFFFMTR5T2hhNWVEK3RUNitaWjMxaTZML1NhRmVGL1B0?=
 =?utf-8?B?alV5Nm5mdkkxRkFoNHd4SkJDY1VQcWNQS0R5clgwbEwvR2ZtZ0hQeTh3VG13?=
 =?utf-8?B?QkhWZUg5aFJ1YlljaE0wZlhFcUU2TVh3ZjRWTEhpNGk0MG1ISkRpcXFZVTRu?=
 =?utf-8?B?a0tJNlU1cjB5eE5zOVltdWZtUVd2bk1GNkpBQm5mRzNOT2ZFU2V0UFJkaFJ1?=
 =?utf-8?B?Tlo4Ui9zbjB5cm5xUklaTVU3RUVjSWRYeEY3azJ0Y3hmR29hNEpuY1lZY2xj?=
 =?utf-8?B?L0l6U1RzT0txTnhaR0F3bmFDUUFBVktFc3hIbnBteVFibVlqWDJyV1owcVdw?=
 =?utf-8?B?b3JlUVljcVJBckF5OU02alFIZ1J1cWZhK09JcS9QSFlJeWJzdWZnNEYzU1pI?=
 =?utf-8?B?dGZwSXYwRWJuVUo0bjZaZnBaMU1QdVlmK1BkOVlxektlV1VkdnFybVVjUDFG?=
 =?utf-8?B?MDdENm4xUGxZd0tiVFhEMzhoaU1pTEw0S0swSFB6S3ZmZjhxVVlKT1NpNlpa?=
 =?utf-8?B?UHRRbzQ3MXRzWTUrOE9qeHZlejBOcWZRQWxWQzB5MVlWd0ZBQ0hWbnJTaGdI?=
 =?utf-8?B?bzZLcW5lcW9ncHk1d2N5eC9vKzd3K1MrMXgzRzkxdTQyR3M4MDg1QS9kYnNu?=
 =?utf-8?B?ZlB1ampEajQrQVdCQjAxLzZGVmlDWVZmejdjOWQ0WVkvWDFYUmw2a3VYdDVL?=
 =?utf-8?B?cHdJTUt4SERTZXp1NFFNejhmbEk5Y2huOTNUWjk3WXZsT3Q3c25mM0FxU3RQ?=
 =?utf-8?B?czFlN2g0ajVzVXo1Q1hTdmVhYjllYlo0dlFwbktwMVhtMlQrSlZpNncydHNu?=
 =?utf-8?B?MEJkT09jSkRzSEpodEhiQ0lNbTl3T1dPdWtKWUxZSkJwbUp3KzUwRk9OSkYx?=
 =?utf-8?B?bkh1M2xENUQya2RybWxGaDNoL2xyUjRkeVY2czRuN1c1TmpVVDlCMS8rb0hm?=
 =?utf-8?B?ak9oY1ZmS2Z4aEJuL0VhY1lKRlhmWXJKR1pFNFQrandlcHgzMnNMeUNPbFcz?=
 =?utf-8?B?SStjZ2ppN1NLRUxNL21lL0ZxT0R3UnJ6MThHNmxPZy9YWm9qc0V5b3UwQ2NC?=
 =?utf-8?B?akQ4SDlkR1FzRzRldGNYK1hUS053dGhlL1N4SVFtTzdjWUdZVUU4aXJEWVZK?=
 =?utf-8?B?ajNGSHdPd0drc0xQM3Nua0VyUGpKVFpydHNEeG9JbTJmM2tkRWZKTkl1Mlp4?=
 =?utf-8?B?TDNHdUl3YjA2UFFtaE9CejVvMUxYSFJmTEpjSWI0V2hlSE5aNm9mdTg1WDVQ?=
 =?utf-8?B?bEl6WnNXYmVQVGgyMDlscThnQVlXckVUeHdLYktONVV0bWxCOVhaWlg2YzB4?=
 =?utf-8?B?RVZhWjlEVFQzdkVWMmQxcVgyVGFtWUVhVDVTQXU4NlEzTE1kbTAyZmdEbko1?=
 =?utf-8?B?V1VKRHVNcGxQSU50TnZQdjRYZ3hOSklSNkRVNFk2Z3pGQWJuUTMzc1hIVzQw?=
 =?utf-8?B?SGlET2Y2VmNJcnd5UWpGaEJLbXprT1d3THRhb0NUSzZ1Yno5dTFYYjN5RVQ3?=
 =?utf-8?B?cW8ycGFsNkdJMEV6WVVNdmYxV0pzMHhsdkV5VGNzdm9SVGphZE1LOWdmSnYy?=
 =?utf-8?B?U3hHMEdDRzBUbkdNNncrSlJBYlBXMGdZUVhaczJmbzZiYnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB6224.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUdzT2VhZlEvUDh1ZzJHZ2tSTUk3QytvdlcvR0tYOU8zWlcyeXZ2ZWpVcmJM?=
 =?utf-8?B?cWw5UlM3a0EzYkduTUtJK1hZcGtaejNFWVN2dXUybjBqQVUzTXVjZndrLy9H?=
 =?utf-8?B?bmVXVEJQbmJlZE50cDNzTklvTXRhZkZDeUpQSGVBMzZWVGpYdVM5T1k3MDFR?=
 =?utf-8?B?UllLV1lVcm1jQ3lPd3hucEhGVm5yZkRPR3QwTEd0eHUzK2pwUGNmU0N2MHNN?=
 =?utf-8?B?UjZFeElhUXBkMlBTY0NnRTRraDZ5Vk5GdjlsOG1pZE16TURtNnZOa25OV2pq?=
 =?utf-8?B?bGxlK21tck0xQ1VlT0NSc3paeHIydkpkR28xWlFuRitUeHFzS3hEOURsL2FQ?=
 =?utf-8?B?SEJnKzNqdVU3ZnpsOExlZmdlOU9mNG5EZGp1YXIxeVZ0RGR1ekdLYVZEM25r?=
 =?utf-8?B?d0ZHOExsS2tpekE5aFl6bmthU3RnRElYR29kRkRxNWN5QmF4YSswYXZWak9F?=
 =?utf-8?B?ZmkxZlB1YTJ2STJ5bFlvN1pwa1Fxb0Ezanl5ZSs3cS9lR2R3WkRNOU9uNjls?=
 =?utf-8?B?eVo0SWhZOHh5TmE2R3RKaXRhbUJoanZuMEJmYjNvcHI3NTdXb3pVK0VsT0Vp?=
 =?utf-8?B?TVdYVCtxQ1htb3VqMXhXV2YvN3pGaU92U1FWc2RzeDBXMDk1NzQ1cVVBckht?=
 =?utf-8?B?TmlQU3U0K3pmc2lxcDN1N2hySzhTd2hpSmpjajJVVnkwT2locGlWMHBvaVJx?=
 =?utf-8?B?RXNzN2cvcGtsODlZbElRTEU3T0xFRHF6NThRQlpyekNCMGtYYnNlMCtQSWxx?=
 =?utf-8?B?K0RFYXpRQ0Nkb3ZLQVJ6TlRMWnFuY242ZkFoOWpMYisrOTNzaTlRRG5aL0l3?=
 =?utf-8?B?anp1c1UrRTBRSUtaaXMybXUwN2tNM3lVTlBPa0l1Z3JnZzRMOGxFL2xtdHVl?=
 =?utf-8?B?SWJDTVNDUTczWDRqMTlSaXVyeG82eEN0OFduL3Z3eloyWWd5U0JOOElNMkhR?=
 =?utf-8?B?QjJyMU9DQ2VNb0dUak1oSWtEak1OTDZDK2J4K095dkZGV1o2Qy9OdzdqZXJO?=
 =?utf-8?B?UDV2eG42bUc5K21sd0JRTFBPMy9RMVIzWWc2OHFpdTRMRy91L2pqcjBCN05m?=
 =?utf-8?B?VlRLQXI5QXBIcDQ5cDg3aUtySWlvVlIvZEdrdk9mWW9lZEx3Q0w0aHkvLzZn?=
 =?utf-8?B?MklUbVdWZjM2L1U0a3hTNzB6VEVPTmlXSmZiRitsYk1NbGJOYmFkR3AvUmlH?=
 =?utf-8?B?VW9WbndCOEpBTFBIWk90MEtRZHFlQ1FORVJFeVZ0cTI3OVk2VHZRTWlKcHBR?=
 =?utf-8?B?eDlmZDVZUmtvbU1EM1RYc28vckdWbjd5QVl4OXRtTHZpZWxJWW43ekp5SHRS?=
 =?utf-8?B?dWI1dmp2MEF1Zk1aa2hXOVF0S2ZNd2ViSWl5VWVUb05SdTdJNmRSRUQ5THpw?=
 =?utf-8?B?YytkWjB5TmRDM2xud2djUjVzUmw4dFE3ZnlrWXNndmZoOU5Td0RqMWFLU3Nm?=
 =?utf-8?B?RFNjQk1HazNVY2VuTzNWeGlWdUxXWUZhSE92cWNPdk45QmptV0NYRjZQZFYx?=
 =?utf-8?B?OGZ4aW5mRVpzRjdFUzU2WU4rVXJFYWhCM2ltYUxNYTdGMXhXcEtmUzdkeXM4?=
 =?utf-8?B?dEV1WFZoRHAvUHFpYVhZOTFNc2szc3NveWNvRnVEbUh6anFaTi84RVd6cHBn?=
 =?utf-8?B?TDVEUWZqK2RTUTBJMVkzbWtyNmFPYnZOTURrYnYzdnpMclJjMmtJcCt1ajh4?=
 =?utf-8?B?ek5Wc1ViNVRwR2RvVHFlbDluL3hIc21kNVJRNk0yRjJOQWJmQi93ZXBKeHZM?=
 =?utf-8?B?WXpSdnkzTGs2cyt5Tkkwa2xQd2xSY2VlOHpydmkvekFhVnlITlFMN2M3ZGJl?=
 =?utf-8?B?OVFNNXdnOTVMNnBDL1hrcnk0bEw3eW52TzlMQnQvbUkyTDk2bTdLTUtGVDh1?=
 =?utf-8?B?T0pnUnJETjdVNEJWOVR4R1daeEZDV2JEaWtkWDEwdk5wdGdOQ0t2SWlhL1J4?=
 =?utf-8?B?Y2VrQm05Zld0TzRWd2NZaGZyOFpvdlc3SGlsbkdFUFJzeCtUTTRiSklKblQ4?=
 =?utf-8?B?TS9XUjRCUGtBZ0RIMkRLMzNMaGpISGltSEdHclk1TW1qbTlSei9BZ05vS0pS?=
 =?utf-8?B?SmQ3M1JuWTJEZUNBL09NNENrU2dadWYwaUxaYXdRL3grNlREK0dibldGWXdT?=
 =?utf-8?Q?fQoo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB6224.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb9adfc-f601-42ef-c83a-08dcc0f85f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 09:13:36.4024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgnG4k0+3fDo0oxOjNLf3S43EL1kyC8gLdp6zdffTZ3A+JmP62wzkSDFBj3KpnNWypYxooLSb/ha0K5R3E5Bjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5745

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KPj4gQWRkZWQgbnVsbCBwb2ludGVyIGNo
ZWNrIHRvIGF2b2lkIHN5c3RlbSBjcmFzaC4NCj4+IA0KPj4gVW5hYmxlIHRvIGhhbmRsZSBrZXJu
ZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0DQo+PiB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAw
MDAwMDAwMDFhOA0KPj4gcGMgOiBnc19yZWFkX2NvbXBsZXRlKzB4NTgvMHgyNDANCj4+IGxyIDog
dXNiX2dhZGdldF9naXZlYmFja19yZXF1ZXN0KzB4NDAvMHgxNjANCj4+IHNwIDogZmZmZmZmYzAw
ZjE1MzljMA0KPj4geDI5OiBmZmZmZmZjMDBmMTUzOWMwIHgyODogZmZmZmZmODAwMmEzMDAwMCB4
Mjc6IDAwMDAwMDAwMDAwMDAwMDANCj4+IHgyNjogZmZmZmZmODAwMmEzMDAwMCB4MjU6IDAwMDAw
MDAwMDAwMDAwMDAgeDI0OiBmZmZmZmY4MDAyYTMwMDAwDQo+PiB4MjM6IGZmZmZmZjgwMDJmZjlh
NzAgeDIyOiBmZmZmZmY4OThlN2E3YjAwIHgyMTogZmZmZmZmODAzYzlhZjlkOA0KPj4geDIwOiBm
ZmZmZmY4OThlN2E3YjAwIHgxOTogMDAwMDAwMDAwMDAwMDFhOCB4MTg6IGZmZmZmZmMwMDk5ZmQw
OTgNCj4+IHgxNzogMDAwMDAwMDAwMDAwMTAwMCB4MTY6IDAwMDAwMDAwODAwMDAwMDAgeDE1OiAw
MDAwMDAwYWMxMjAwMDAwDQo+PiB4MTQ6IDAwMDAwMDAwMDAwMDAwMDMgeDEzOiAwMDAwMDAwMDAw
MDBkNWU4IHgxMjogMDAwMDAwMDM1NWMzMTRhYw0KPj4geDExOiAwMDAwMDAwMDAwMDAwMDE1IHgx
MDogMDAwMDAwMDAwMDAwMDAxMiB4OSA6IDAwMDAwMDAwMDAwMDAwMDgNCj4+IHg4IDogMDAwMDAw
MDAwMDAwMDAwMCB4NyA6IDAwMDAwMDAwMDAwMDAwMDAgeDYgOiBmZmZmZmY4ODdjZDEyMDAwDQo+
PiB4NSA6IDAwMDAwMDAwMDAwMDAwMDIgeDQgOiBmZmZmZmZjMDBmOWIwN2YwIHgzIDogZmZmZmZm
YzAwZjE1MzhkMA0KPj4geDIgOiAwMDAwMDAwMDAwMDAwMDAxIHgxIDogMDAwMDAwMDAwMDAwMDAw
MCB4MCA6IDAwMDAwMDAwMDAwMDAxYTgNCj4+IENhbGwgdHJhY2U6DQo+PiBnc19yZWFkX2NvbXBs
ZXRlKzB4NTgvMHgyNDANCj4+IHVzYl9nYWRnZXRfZ2l2ZWJhY2tfcmVxdWVzdCsweDQwLzB4MTYw
DQo+PiBkd2MzX3JlbW92ZV9yZXF1ZXN0cysweDE3MC8weDQ4NA0KPj4gZHdjM19lcDBfb3V0X3N0
YXJ0KzB4YjAvMHgxZDQNCj4+IF9fZHdjM19nYWRnZXRfc3RhcnQrMHgyNWMvMHg3MjANCj4+IGty
ZXRwcm9iZV90cmFtcG9saW5lLmNmaV9qdCsweDAvMHg4DQo+PiBrcmV0cHJvYmVfdHJhbXBvbGlu
ZS5jZmlfanQrMHgwLzB4OA0KPj4gdWRjX2JpbmRfdG9fZHJpdmVyKzB4MWQ4LzB4MzAwDQo+PiB1
c2JfZ2FkZ2V0X3Byb2JlX2RyaXZlcisweGE4LzB4MWRjDQo+PiBnYWRnZXRfZGV2X2Rlc2NfVURD
X3N0b3JlKzB4MTNjLzB4MTg4DQo+PiBjb25maWdmc193cml0ZV9pdGVyKzB4MTYwLzB4MWY0DQo+
PiB2ZnNfd3JpdGUrMHgyZDAvMHg0MGMNCj4+IGtzeXNfd3JpdGUrMHg3Yy8weGYwDQo+PiBfX2Fy
bTY0X3N5c193cml0ZSsweDIwLzB4MzANCj4+IGludm9rZV9zeXNjYWxsKzB4NjAvMHgxNTANCj4+
IGVsMF9zdmNfY29tbW9uKzB4OGMvMHhmOA0KPj4gZG9fZWwwX3N2YysweDI4LzB4YTANCj4+IGVs
MF9zdmMrMHgyNC8weDg0DQo+PiBlbDB0XzY0X3N5bmNfaGFuZGxlcisweDg4LzB4ZWMNCj4+IGVs
MHRfNjRfc3luYysweDFiNC8weDFiOA0KPj4gQ29kZTogYWExZjAzZTEgYWExMzAzZTAgNTI4MDAw
MjIgMmEwMTAzZTggKDg4ZTg3ZTYyKQ0KPj4gLS0tWyBlbmQgdHJhY2UgOTM4ODQ3MzI3YTczOTE3
MiBdLS0tDQo+PiBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogT29wczogRmF0YWwgZXhjZXB0
aW9uDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IExpYW5xaW4gSHUgPGh1bGlhbnFpbkB2aXZvLmNv
bT4NCj4+IC0tLQ0KPj4gdjE6DQo+ICAgLSBPcHRpbWl6ZSBjb2RlIGNvbW1lbnRzLCBkZWxldGUg
bG9nIHByaW50aW5nDQoNCj5BbHNvLCBzYW1lIGNvbW1lbnQgYXMgYmVmb3JlLCB3aGF0Og0KPiAg
LSBjYXVzZXMgcG9ydCB0byBiZSBOVUxMDQogICBXaGVuIHVuYmluZCwgdGhlIGdzZXJfdW5iaW5k
IGZ1bmN0aW9uIGNhbGwgZ3NlcmlhbF9kaXNjb25uZWN0IHRvIHNldCBnc2VyLT5pb3BvcnQgPSBO
VUxMLCBhbmQgc3RydWN0IGdzX3BvcnQgKnBvcnQgPSBnc2VyLT5pb3BvcnQsIHJlc3VsdGluZyBp
biBwb3J0IGJlaW5nIE5VTEwuDQogICBJdCBzZWVtcyB0aGF0IHRoZXJlIGlzIGEgcG90ZW50aWFs
IGNvbXBldGl0aW9uIGJldHdlZW4gdGhlIGdzX3JlYWRfY29tcGxldGUgZnVuY3Rpb24gYW5kIHRo
ZSBnc2VyaWFsX2Rpc2Nvbm5lY3QgZnVuY3Rpb24uDQo+ICAtIHByZXZlbnRzIGl0IGZyb20gY2hh
bmdpbmcgdG8gTlVMTCByaWdodCBhZnRlciB5b3UgY2hlY2sgaXQNCiAgIEkndmUgc2VlbiBvdGhl
ciBmdW5jdGlvbnMsIHN1Y2ggYXMgZ3NlcmlhbF9zdXNwZW5kIGFuZCBnc2VyaWFsX3Jlc3VtZSwg
d2hpY2ggYWxsIHBlcmZvcm0gcG9ydCBlbXB0eSBkZXRlY3Rpb24gb3BlcmF0aW9ucy4NCg0KPkJv
dGggbmVlZCB0byBiZSBhbnN3ZXJlZCBiZWZvcmUgd2UgY2FuIHRha2UgdGhpcyBjaGFuZ2UuDQoN
ClRoYW5rcw0K

