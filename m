Return-Path: <linux-kernel+bounces-343277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E499989905
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 03:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D191F21B48
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4512B640;
	Mon, 30 Sep 2024 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Bb7KBCDr"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2062.outbound.protection.outlook.com [40.107.215.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8F1CD2B;
	Mon, 30 Sep 2024 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727660939; cv=fail; b=C1UGRN7zZ5vspA21vf4FRw59H+sBwueVRhIxSPbj/qPyjHyBYTXOXbzGJk8kblZ69rAJNTa4aHGg/sWnFFNP2Ix+k3Rrp/YOPd130PE5nDKDohkuoomG944ZuoG6KKG9hE/4o11wBubBDmsew7i6mOeLBoNAHYzfhuTGSZ+zOXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727660939; c=relaxed/simple;
	bh=9ed/ORkBrTgSfQeEanFh2tAEyXYfG4LlYfP+bmWfpQc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MxYUUJ+PmTuhHLBNGrl4detRAv1BaH4N/fcIzoEOYYJAvdIuQUlctWduBEo3SWHx1S6R6s0h7CHETXozUfffFAHcVOL6wKoIlwk6DSaOaNC5h6gUQs1K+3NiH1Ktf4oKYBtZWzJpMe01gVRVJFgZ4pkF3pJgqFvMOeVix3vL5wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Bb7KBCDr; arc=fail smtp.client-ip=40.107.215.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2NpFQrmfWgfnNcoQ3MVb/9WOZ5IeIWcmYAWe8s7DpXifcxi9lcrSq8zFljB1vuAlFK3sN1UvgDaoLQ2FJ5dW59gphyqtwPQIyiv/R+uXvuk+nI9fYtkBFsDUGw9I5131kwtllwEj4tVGW3IHUimmE9biBrkXi3rpPwqSJfZfKo9FE+MrhgsCWnqugfhyKsHtAxW2juBJcX4V1uJIzno2Lz8Kv/o+PH1gzL/CALq6ZoC0/3iUuReG37nhhvDHZj6ceWVflCCx48Lc/pFm4yB+J/SwjBnpt8sHH6GYWnD9yybEAceT//r7iEPeyxeYjq2+rQuRoYzy7G0D1FQyiLKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ed/ORkBrTgSfQeEanFh2tAEyXYfG4LlYfP+bmWfpQc=;
 b=ke5K1h6bsqOfA+/Xq3+iTHmB6sdUddbTuDXAtazaNO2SqhJCSytWBaKbrdIt0STyxwolBhH1/qOpEUtSdoLUi89Xx+GzgTF/bdzYHjGei27+pGp6Bd4iFotSmi/fa4ulERY5W39dVGgLNUN98e1SvOwlNQp61hAlP99sHlPU9lEjlBwYLU0q42Eks8NAk5IM9jvhqQa/vmeiXS4Bbj5xqlKYA1rdepA/Z+QQWKSf441hJclV8KpR2wD6GLMiDLM1Ig4PxnAtIBzykO5C2mtrl3pz7Tgg/Ek2y0nMVHxWItMv88s4muK1QJ+SoSeQPV5LniMTZr6acnShiN4InWYE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ed/ORkBrTgSfQeEanFh2tAEyXYfG4LlYfP+bmWfpQc=;
 b=Bb7KBCDr/tST4dCfO5xWFJ4SvJJ1j4+yCaG/Y82cwVu5I3q95EfSwaOe1A4mXCt/3qUZoRSi7SgRyzwdhXtOhAsO6n/O9HC//ox9aLANk7xXEm613UQaTRVbfEBOeUNY4hloVsB2bPY9YX+PCVXLch9iJkXWj5nAty5lXHL25KRyW1Y05iXm/Qeibas8C5zW26XTdzoCxVaPePRzpxs14M4r4UfniUKgGjlpCkiICFbMdYzddKrcn3k+v/jUstFEdcEM+HsNEkLTHx7PgsHvrTqKRk7FsjHWC3SqbtbVvNV/CyZLlVFVxtwSofxQdH8qx91L5g7Nq4dbizU7T36pqQ==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB7024.apcprd06.prod.outlook.com (2603:1096:101:1f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 01:48:45 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%5]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 01:48:44 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>,
	Prashanth K <quic_prashk@quicinc.com>, "quic_jjohnson@quicinc.com"
	<quic_jjohnson@quicinc.com>
Subject: [PATCH] usb: gadget: u_serial: Disable ep before setting port to null
 to fix the crash caused by port being null
Thread-Topic: [PATCH] usb: gadget: u_serial: Disable ep before setting port to
 null to fix the crash caused by port being null
Thread-Index: AdsS2sv/KrbNWrYhQLGh2QI0DyN4gg==
Date: Mon, 30 Sep 2024 01:48:44 +0000
Message-ID:
 <TYUPR06MB621763AB815989161F4033AFD2762@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB7024:EE_
x-ms-office365-filtering-correlation-id: 4bc20a12-05a0-4ad1-3af4-08dce0f204ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UG1WZVJMbzBHU1ZIU3M4NmRob2paaHJ1UEsxS1hLUjNDY3hhbWdIYnpKVTVv?=
 =?utf-8?B?RkNjVGVKN1FFNlJMeEQ0QTFTZmd6WEhmMDJEVlFkWjhuQVhBbWxtTkFPNU5m?=
 =?utf-8?B?U2wrNVVmNVkwL2FaNFZWU2x6QUp5Z1N0dkFVL0lNNlM0Rzkwc1BCWTF5MFRn?=
 =?utf-8?B?cU9mVDFLSHpGWkJISnh0NmNYM3RENEFuS3cxSCtJK1RTemxrT094QjZvcFVo?=
 =?utf-8?B?aWhTem52NVVTeGxEOWowdFBOTGg5eE1xb202VlpETnNYUG1kdWdGdUlOQWY5?=
 =?utf-8?B?OC95Tm9OWHlrZjNoR0tBWkFra01XUEFJVWdaSk1kUHVhKysvWkdDdUhncnBv?=
 =?utf-8?B?OFBpTHdkdm43MXpscm9VbSs3UnIyKzVxQXV0R1dESzJ1MzMrVDhTVHUzSVhj?=
 =?utf-8?B?bk9rcUtzOExpRERBWjZlMENHNmdNa2YvZTRNVHRGL3lnQjIveG9UaE1uOUZy?=
 =?utf-8?B?ckxOV2xBMWJtUCtMSTFnbGluM25EcmtwaDgyV1dPaGs2dUlmVEpXalNsK1Ns?=
 =?utf-8?B?WFVpMk8zT05aYUpLOXVaQ3lZUmdmaWMwS2xxVUFtMU02SkdCSmIrYlNRWW5I?=
 =?utf-8?B?WnkzYUlQQkxXRmxaMVdBTkpDZHVMd1A4QmhyNzZEWENTU3AyZ0FCbjNxWTNB?=
 =?utf-8?B?QjlZYjZmdUZ0ZWptNmdNdHdyZ0hYa0dMdDZZVVVLT3ZrT2wxcWQ0VjBhVmNC?=
 =?utf-8?B?bm9jV20wbEk4WkdkWTJUU0NYUDB6K0xYcVJnc3RuUUYxd1FqL3oyNGVyTm1V?=
 =?utf-8?B?RkgzNndQaHEvMHd2UmJHbTJsVWhlUzcwMGtoUWtqbllwTzRCT290MlZzeVVq?=
 =?utf-8?B?dGxFSXkzSmtEcnhrUVgxenRGK0R1RlM5aEZoUHdnK0tMemtnWEZyNEZGK1RX?=
 =?utf-8?B?YUtlNkFrQkdJZXVPYkpUdXNoUW1BWE1KL3FYK2RRRllsM29MT2ppUXVVWHVo?=
 =?utf-8?B?TURTbDZtbTBIK3pld1E1ZDNCNGNRU1hLM3Ywa1JTd0tUOGZvc0pnMGRtTnlB?=
 =?utf-8?B?OVRuMmNMdlkwMzdQV2toeWc1N29uUDkyS3VvSnM1WXdFS1FSQlIwNHRaaHpT?=
 =?utf-8?B?WEd4bk94MDAxWWxJMldzQWdtTDlBTmdsRTQ3Ym01TEhqQ0NORW9EUFMraFlh?=
 =?utf-8?B?SnhPelZGMWxqQXlUSGN5bVNaRVkzSnJrbHlDRitLMjhHRFpFSVRiSVZXWGxC?=
 =?utf-8?B?ckNUMVpkbUNzNnRvTGlPbkFPS2NSVk5EbmU2cmxMQlRTd0d1N1VMTFQxa3NF?=
 =?utf-8?B?bG1rVjdsWjh3NXQweUtrL3RYM3VHYkJJYnpCRnNtZW1LOE4rTEVzMkRFU0pu?=
 =?utf-8?B?QU13c2haRXp6MHA0S2sreU4yUWtpbFJnbGQrQ20zQmJqK0RXbXZydThJYjNs?=
 =?utf-8?B?RU56MlJ0dSs2RUVwOXNkanAweGl1RkU1WUhRemhlbURtUUpqR0ZoL0F6dEZN?=
 =?utf-8?B?TkNXV1hzb2VjLzE4d2xZd1ZuMWNJcnpTbTQvWHd3SmFSS01nbU43bVRqc004?=
 =?utf-8?B?TWhrUnhGREtYZTNETUFXcEcwSzJ2NHpiODNVSHF3dys4ZUZ3SDdWVlBIVUdY?=
 =?utf-8?B?ZUNwM0ZGR05lWmtjUFZnczFvSmpPMktZSklkSlhjQlFQTTNhTEV2aUIrU05H?=
 =?utf-8?B?L2FvZ3ovZjFXV0pZOW44WHZqZzJyYWJ6eU8xNjRBNmFwUjExRVNjUG9BV1p6?=
 =?utf-8?B?QldGQ2FYYjVsZ2JIeDJqSE9rZExHZFo5T3MxWlFwK3ZmTGFibVZqcXRDNENK?=
 =?utf-8?B?RVB1UTF1SXZXU2dEVXNCNXpiZHdYSVNqT1dxWFBQeEtScHpsSCtSUTRrcmRq?=
 =?utf-8?B?NjE1SVZPNkNHR29DWjBVdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1lkWmFQYzdYYVh1Qm9KLytkb29QcTBnZUtRUHdGUk9qYVJvQkZrejNEekk2?=
 =?utf-8?B?SkJScVJZOGNpOEVSZDdiVU1HZ3lVNHhMRmcvb1UzV0lxU2Y3VjZacEJvQk53?=
 =?utf-8?B?TVhpeFVmWHYwcmNwUFlFbGd6c3dsWS81TUlvMVlmYWZVL3FBN1dWVHArZDBJ?=
 =?utf-8?B?OFBmbHVqeWgzWDFHL09MbXovV0kvdEVTUXNHNVBkaC91aGRkOTdCOVhKaUxu?=
 =?utf-8?B?ZEZ2eGYyUmx2akFGTVNxNmI1cC84Z3daUTkwNUNWVHp6ZSt3WGRmQ0Jpelhn?=
 =?utf-8?B?N1JTSXFybWJNbE5UQkRzVzNBK3E2TVZ2cVRjQ0s4aFJnaE0zSDM5TmpYRHlv?=
 =?utf-8?B?V2NBMWFtaU1XWFc0U3BYRERVODJOK01lUlVBVzM5ako3VVZ1d202NDhWd2hP?=
 =?utf-8?B?NW5TQWkreDRaZmFIdXNKYVVuOXVYUG9zWTJuclhGa1pXUFNwY2hwSHNXYmJ4?=
 =?utf-8?B?RTV4cGxBeEJNWlE4OG1naE5FK1FIL0NuT2JSQnBLOWxRc2Zza2lzRjFiOFF4?=
 =?utf-8?B?VUlMQWlFYSszSEJ6M2hFOERNSFFCZVB5azVWclZseTRIQlR2UEFyNGhGTllH?=
 =?utf-8?B?M1QzSmwzUSs2bHNFckpmYU9yNFZSVFpkM1FySWh0NjlMblQ0K0cxMlAwbFB6?=
 =?utf-8?B?MllFYVcyR3hrY3NzcUVHM29vWHorMHFzRWMxcTlQTlJrNDUvcERFYTE0cDNw?=
 =?utf-8?B?ZEtKYk5vZkE2Qjd4ZlZLVGJYMlkyQ29qU0h3Qm1McVozQXZzT3JZODBzbHp6?=
 =?utf-8?B?UUdpQ0hOYTIraU16OGRyWGNHS2ExWkpPYzZsTzQzakpDcjJlcGYzQ1N6RXZX?=
 =?utf-8?B?aGpkNUZodDlRaHVIeFpPSzFtQjVoZGg0TjluSnVEK2Fnc0xxbnVBU2RFZWln?=
 =?utf-8?B?RldCNnFlV2VtdytKOWVDV2lFQ1k1Wm1aMmxXd0ZaSFFoSjN1RDBXTURHZmNU?=
 =?utf-8?B?ajlNbjJJbGlHRjNNRTF3ZHlWTlFSRzd0ZWZhWWw1MnZ1eFV0VjZKUWVwdlZX?=
 =?utf-8?B?RUNxb1BSTzdtUFEwV0VsM3pmTmlBREpSQXdqWjljeWU3S1JMRWVOZUYrZlN2?=
 =?utf-8?B?MVYyenlRYTMvSktYZTFodkprM0xBbHlyRUVLS1I0UTdRQmYrdTB1VTY4Nnlt?=
 =?utf-8?B?NCtkNk9UYWdtUFlQdWU3c1kvQ0FDeWtNN29Id1NvYkg3ZFg5SURpQW9jRWtQ?=
 =?utf-8?B?NENwZkg2RWFsOFJtczZWTGh3Vkh5QXR5aTlDeGNUclU3czhQdzE2blVvMjFu?=
 =?utf-8?B?R1RSWGQyUnkwK2xhcVF2QzNFekdrblYxYjVObVNUZENJamhkUm55b3dPQVN6?=
 =?utf-8?B?NjRrQ3lDVkcwWWZqNTQwOEZqdytmK0YxdGFGSnEvTzZBZi90ZVJQWVJqOGhs?=
 =?utf-8?B?TkJGV1ZTb1VvVVQ1Z05SYlBLM3RBNzd0ODNqTDZ1S0RtZ3JDS1hOZXJlbFIz?=
 =?utf-8?B?MW9EUG5ob09OOGNFVURTdXNFUGZyOCsrQ2Evc21uSWtJWFVSakdhMzY2YUhC?=
 =?utf-8?B?Rk9VMzl6K0h3OC9wZkdnUTBWTml6aUY2Tzh5NzR0SjYvYU9TbnJWMGs5MmlM?=
 =?utf-8?B?MnJzZ1hJcjNXQ1BWRlBmTFhtWE0zNXVrVDdESVcxeUk1djFOS0VhUWZObU96?=
 =?utf-8?B?a1FKTjAwRUtBd2ZwSTZZeTI1Z0FGT3JJT3hBNm9VaCttNWt0aFlvS1BBY2lR?=
 =?utf-8?B?ejBNWmk3aEZqSHRQaERyRVc5cHdkaStkUzVVSytGWHJQLzVKT05aWGVpSlFS?=
 =?utf-8?B?bkEwMjRHODZQMnRhUGxjWDFVQm5vZEhtQ0RtV3ZxSG5rU202YWJZM1dhZ2Js?=
 =?utf-8?B?ZHBFOEhqcnJlM0JZcE84a216N01yN0FiblBmMktXdTVEU21SUjB6SW1JNUJu?=
 =?utf-8?B?Y1JDSXJaeFVMamFWVUFGWnpHYUMzQTE2djJTS1oxc3NSWGdxY0U4YmdUSmVi?=
 =?utf-8?B?L2ZuYTRaV1BweHdYelJHb1poSElQMEFUU1dxZUtpKytWRkFmRCtlc05YOXNM?=
 =?utf-8?B?SlVTOUVRRTZmWkxKRmhUNXlDMXV2LzNNVnpjcDh0TmlibUJrdUVUOEI1Y2VO?=
 =?utf-8?B?dTdtVzZHOC9tTlZvTk5tclBTd0NsOWxPdHh0cW9IYUNheDBqSWwvdTdnc3Fw?=
 =?utf-8?Q?x354=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc20a12-05a0-4ad1-3af4-08dce0f204ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 01:48:44.8746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8X0QAvmaSCm2u4tmw9BU5HZSFpqaUh/B3cwNL49cXb1cymZ9uwdzfIBAQLTRNZOyos4OfgjfcROmOkSZBy7hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7024

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpDb25zaWRlcmluZyB0aGF0
IGluIHNvbWUgZXh0cmVtZSBjYXNlcywgd2hlbiBwZXJmb3JtaW5nIHRoZQ0KdW5iaW5kaW5nIG9w
ZXJhdGlvbiwgZ3NlcmlhbF9kaXNjb25uZWN0IGhhcyBjbGVhcmVkIGdzZXItPmlvcG9ydCwNCndo
aWNoIHRyaWdnZXJzIGdhZGdldCByZWNvbmZpZ3VyYXRpb24sIGFuZCB0aGVuIGNhbGxzIGdzX3Jl
YWRfY29tcGxldGUsDQpyZXN1bHRpbmcgaW4gYWNjZXNzIHRvIGEgbnVsbCBwb2ludGVyLiBUaGVy
ZWZvcmUsIGVwIGlzIGRpc2FibGVkIGJlZm9yZQ0KZ3NlcmlhbF9kaXNjb25uZWN0IHNldHMgcG9y
dCB0byBudWxsIHRvIHByZXZlbnQgdGhpcyBmcm9tIGhhcHBlbmluZy4NCg0KVW5hYmxlIHRvIGhh
bmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0DQp2aXJ0dWFsIGFkZHJlc3Mg
MDAwMDAwMDAwMDAwMDFhOA0KcGMgOiBnc19yZWFkX2NvbXBsZXRlKzB4NTgvMHgyNDANCmxyIDog
dXNiX2dhZGdldF9naXZlYmFja19yZXF1ZXN0KzB4NDAvMHgxNjANCnNwIDogZmZmZmZmYzAwZjE1
MzljMA0KeDI5OiBmZmZmZmZjMDBmMTUzOWMwIHgyODogZmZmZmZmODAwMmEzMDAwMCB4Mjc6IDAw
MDAwMDAwMDAwMDAwMDANCngyNjogZmZmZmZmODAwMmEzMDAwMCB4MjU6IDAwMDAwMDAwMDAwMDAw
MDAgeDI0OiBmZmZmZmY4MDAyYTMwMDAwDQp4MjM6IGZmZmZmZjgwMDJmZjlhNzAgeDIyOiBmZmZm
ZmY4OThlN2E3YjAwIHgyMTogZmZmZmZmODAzYzlhZjlkOA0KeDIwOiBmZmZmZmY4OThlN2E3YjAw
IHgxOTogMDAwMDAwMDAwMDAwMDFhOCB4MTg6IGZmZmZmZmMwMDk5ZmQwOTgNCngxNzogMDAwMDAw
MDAwMDAwMTAwMCB4MTY6IDAwMDAwMDAwODAwMDAwMDAgeDE1OiAwMDAwMDAwYWMxMjAwMDAwDQp4
MTQ6IDAwMDAwMDAwMDAwMDAwMDMgeDEzOiAwMDAwMDAwMDAwMDBkNWU4IHgxMjogMDAwMDAwMDM1
NWMzMTRhYw0KeDExOiAwMDAwMDAwMDAwMDAwMDE1IHgxMDogMDAwMDAwMDAwMDAwMDAxMiB4OSA6
IDAwMDAwMDAwMDAwMDAwMDgNCng4IDogMDAwMDAwMDAwMDAwMDAwMCB4NyA6IDAwMDAwMDAwMDAw
MDAwMDAgeDYgOiBmZmZmZmY4ODdjZDEyMDAwDQp4NSA6IDAwMDAwMDAwMDAwMDAwMDIgeDQgOiBm
ZmZmZmZjMDBmOWIwN2YwIHgzIDogZmZmZmZmYzAwZjE1MzhkMA0KeDIgOiAwMDAwMDAwMDAwMDAw
MDAxIHgxIDogMDAwMDAwMDAwMDAwMDAwMCB4MCA6IDAwMDAwMDAwMDAwMDAxYTgNCkNhbGwgdHJh
Y2U6DQpnc19yZWFkX2NvbXBsZXRlKzB4NTgvMHgyNDANCnVzYl9nYWRnZXRfZ2l2ZWJhY2tfcmVx
dWVzdCsweDQwLzB4MTYwDQpkd2MzX3JlbW92ZV9yZXF1ZXN0cysweDE3MC8weDQ4NA0KZHdjM19l
cDBfb3V0X3N0YXJ0KzB4YjAvMHgxZDQNCl9fZHdjM19nYWRnZXRfc3RhcnQrMHgyNWMvMHg3MjAN
CmtyZXRwcm9iZV90cmFtcG9saW5lLmNmaV9qdCsweDAvMHg4DQprcmV0cHJvYmVfdHJhbXBvbGlu
ZS5jZmlfanQrMHgwLzB4OA0KdWRjX2JpbmRfdG9fZHJpdmVyKzB4MWQ4LzB4MzAwDQp1c2JfZ2Fk
Z2V0X3Byb2JlX2RyaXZlcisweGE4LzB4MWRjDQpnYWRnZXRfZGV2X2Rlc2NfVURDX3N0b3JlKzB4
MTNjLzB4MTg4DQpjb25maWdmc193cml0ZV9pdGVyKzB4MTYwLzB4MWY0DQp2ZnNfd3JpdGUrMHgy
ZDAvMHg0MGMNCmtzeXNfd3JpdGUrMHg3Yy8weGYwDQpfX2FybTY0X3N5c193cml0ZSsweDIwLzB4
MzANCmludm9rZV9zeXNjYWxsKzB4NjAvMHgxNTANCmVsMF9zdmNfY29tbW9uKzB4OGMvMHhmOA0K
ZG9fZWwwX3N2YysweDI4LzB4YTANCmVsMF9zdmMrMHgyNC8weDg0DQplbDB0XzY0X3N5bmNfaGFu
ZGxlcisweDg4LzB4ZWMNCmVsMHRfNjRfc3luYysweDFiNC8weDFiOA0KQ29kZTogYWExZjAzZTEg
YWExMzAzZTAgNTI4MDAwMjIgMmEwMTAzZTggKDg4ZTg3ZTYyKQ0KLS0tWyBlbmQgdHJhY2UgOTM4
ODQ3MzI3YTczOTE3MiBdLS0tDQpLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogT29wczogRmF0
YWwgZXhjZXB0aW9uDQoNCkZpeGVzOiBjMWRjYTU2MmJlOGEgKCJ1c2IgZ2FkZ2V0OiBzcGxpdCBv
dXQgc2VyaWFsIGNvcmUiKQ0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCg0KU3VnZ2VzdGVk
LWJ5OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KU2ln
bmVkLW9mZi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KLS0tDQogZHJpdmVy
cy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMgfCA4ICsrKystLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCmluZGV4IGIzOTQxMDVlNTVkNi4uMTcxMmU5Y2QwOGJlIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCisrKyBi
L2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQpAQCAtMTM5NSw2ICsxMzk1
LDEwIEBAIHZvaWQgZ3NlcmlhbF9kaXNjb25uZWN0KHN0cnVjdCBnc2VyaWFsICpnc2VyKQ0KIAkv
KiBSRVZJU0lUIGFzIGFib3ZlOiBob3cgYmVzdCB0byB0cmFjayB0aGlzPyAqLw0KIAlwb3J0LT5w
b3J0X2xpbmVfY29kaW5nID0gZ3Nlci0+cG9ydF9saW5lX2NvZGluZzsNCiANCisJLyogZGlzYWJs
ZSBlbmRwb2ludHMsIGFib3J0aW5nIGRvd24gYW55IGFjdGl2ZSBJL08gKi8NCisJdXNiX2VwX2Rp
c2FibGUoZ3Nlci0+b3V0KTsNCisJdXNiX2VwX2Rpc2FibGUoZ3Nlci0+aW4pOw0KKw0KIAlwb3J0
LT5wb3J0X3VzYiA9IE5VTEw7DQogCWdzZXItPmlvcG9ydCA9IE5VTEw7DQogCWlmIChwb3J0LT5w
b3J0LmNvdW50ID4gMCkgew0KQEAgLTE0MDYsMTAgKzE0MTAsNiBAQCB2b2lkIGdzZXJpYWxfZGlz
Y29ubmVjdChzdHJ1Y3QgZ3NlcmlhbCAqZ3NlcikNCiAJc3Bpbl91bmxvY2soJnBvcnQtPnBvcnRf
bG9jayk7DQogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNlcmlhbF9wb3J0X2xvY2ssIGZsYWdz
KTsNCiANCi0JLyogZGlzYWJsZSBlbmRwb2ludHMsIGFib3J0aW5nIGRvd24gYW55IGFjdGl2ZSBJ
L08gKi8NCi0JdXNiX2VwX2Rpc2FibGUoZ3Nlci0+b3V0KTsNCi0JdXNiX2VwX2Rpc2FibGUoZ3Nl
ci0+aW4pOw0KLQ0KIAkvKiBmaW5hbGx5LCBmcmVlIGFueSB1bnVzZWQvdW51c2FibGUgSS9PIGJ1
ZmZlcnMgKi8NCiAJc3Bpbl9sb2NrX2lycXNhdmUoJnBvcnQtPnBvcnRfbG9jaywgZmxhZ3MpOw0K
IAlpZiAocG9ydC0+cG9ydC5jb3VudCA9PSAwKQ0KLS0gDQoyLjM5LjANCg0K

