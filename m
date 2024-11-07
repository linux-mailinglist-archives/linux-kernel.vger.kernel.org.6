Return-Path: <linux-kernel+bounces-399225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC94C9BFC4B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04D51C22846
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F9A2940D;
	Thu,  7 Nov 2024 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DZjNLkzj"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5C168BD;
	Thu,  7 Nov 2024 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945051; cv=fail; b=MOE0CN9HwJ4nYCmUIi3lCx+WHlZfV8dDn8e4YRpC9jBjieaB/1UFGexSBtHKNR95GlAZUTdgjpIYhvLp2D1sqF4fdSpGpyXNxFcptqSOwjo3LuEdYqq8Z8xzdYgbCYFBQNg7XRzTmgItH3N69RAdHFO4F4YckrJICOaG6NQcbEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945051; c=relaxed/simple;
	bh=UJ2U7ZFboUq5ekNY9OkpN3eyo6BbH4HCEiTolzaMR8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k/Que25NFM0mq2w1svvhnQYDVaVN++4El/vkFJnIIUzMuCFoglhkPrwt3/bY8+0GLgYVpMeGGBql/jYdCdHYW9yj4PnYCTvXNNBNi+f+sQvFfouQjkaexpCPFBuZ+p7myBKD8utlcGuflJX2KDxgX+G3kuESWT8Ahw4bkag3Djk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DZjNLkzj; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6L6hdF023626;
	Wed, 6 Nov 2024 19:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=D99Z/
	83gMU8sfB9r3iPN0OG6BGLiP87P6hTg31NOCtQ=; b=DZjNLkzjMYxFMQyq9mK7z
	V4gz7kJV/6LbWsyNssPKfDYhJV2nRVZMbm3fA4YJ2mDcmoi2wc7Lsmo7kXNvyn0B
	H477ecQo0QmScBjpFpVVrSeDon1+EVpzxTRFV0tKzjZt3geBO06Z/W1Lm7nfDeC4
	OyIuBBZeDBrt1p0xvTa67mIe+BSzVkMm4k00+XCSrKmvxMvR0jAlv2CK9cqx6dsA
	5YLvbMqF5YkHhkP92U0VL8FvExt/rDD1wjcZYKo56SEQ+Ff4UgpDfWRT8pIzxy92
	cZY32JN7kUW22DcAMclFpykHHtzVSBeWqjEyKr3crbQij3SVKGVeKw5Cc4tY0HOG
	g==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42r0qkchkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 19:49:28 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNjmYhj6XzoQNW7b0rDZEdqPq3vxpKBQOVNVU906QtOhpp3ujK1DTT0zpNl6CgTzHNJ6c5XBb605cFOTE5eoy3rMYOR+7wEl7rJJ+2DR28WAmeEJQJukLp6f3ZeJFawMjac+8RXCc9NOxIeeWX+GpfluSbj6Nbo9ev5Rd5DuCXQGlwV30b8HULXrVTuIfXc6R/sD22Q+OmsKY1PMiAOna3pwYvQ0PiMDL2W/YQ1hriV0bbcvd+9ENeIJsBW30Oyw10qQVQy2fsXKod9ME786aIkcNfyZNzh3dJhX4/Tc68C2ICzFQiHFdEUVzkNLEb5LV/MI/UOCc0bvE2CRjTX2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D99Z/83gMU8sfB9r3iPN0OG6BGLiP87P6hTg31NOCtQ=;
 b=b6uErnYaDigxaogXAbOblh43Q7vltyOj+TWr/kEvAy1qQEde+dyB+GGOVyEsY344pTahZpE1aWICZFyV9gBY5nWkiR4qtVkY3MfM+ExmTXnmlzopP0eFOnCkH9amf6W+XZZ4yMzydP70aB689/lmE+WWRwKOwGH35cmw0DZUWfKlBgWfRUQgoAgPwRMik/P21O1ghh3WJQEAQVTHem014eVABj1PhIFEfAUJpQ3P6ocbJwge/pkGvgtw/0+iZP38gX3aOVepca9a9KdygAkWuATyOhin9rrYFo/gglqRkGDvOB9p3PBoZcnfJMr46hLNpJOhmTbbS0nQRvIU2w6R6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by CO1PR03MB5697.namprd03.prod.outlook.com (2603:10b6:303:94::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 00:49:25 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354%3]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 00:49:25 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Conor Dooley <conor@kernel.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "Sabau, Radu
 bogdan" <Radu.Sabau@analog.com>,
        Jean Delvare <jdelvare@suse.com>, Guenter
 Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: RE: [PATCH 1/2] dt-bindings: hwmon: (pmbus/adp1050): Support adp1051
 and adp1055: add bindings.
Thread-Topic: [PATCH 1/2] dt-bindings: hwmon: (pmbus/adp1050): Support adp1051
 and adp1055: add bindings.
Thread-Index: AQHbMCrMXCXi5s2C2EqrPjhQ/cnsCLKqZm+AgACTYoA=
Date: Thu, 7 Nov 2024 00:49:25 +0000
Message-ID:
 <PH0PR03MB63512F464B43A8F457EE0B75F15C2@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20241106090311.17536-1-alexisczezar.torreno@analog.com>
 <20241106090311.17536-2-alexisczezar.torreno@analog.com>
 <20241106-linoleum-kebab-decf14f54f76@spud>
In-Reply-To: <20241106-linoleum-kebab-decf14f54f76@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|CO1PR03MB5697:EE_
x-ms-office365-filtering-correlation-id: bcbcac5b-9627-4270-4b3c-08dcfec60729
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1bCmxyE6E+tSLCJqFLCjZehcjWsQOMuqT0D0PDZ3DLOMwVfeuS400F2K+9?=
 =?iso-8859-1?Q?sbWngNrNzokyfRViWx8hRo1EA0eUzKhHL0I5J/9irqlkUw6JSSGEX5UQ2O?=
 =?iso-8859-1?Q?cyU2AN/yKAuursBaZKP1uVihIcNhK/yY0WutKGsJOGXi8PSLZc57RsI9FR?=
 =?iso-8859-1?Q?MGKQ3mCCaBWXfSfrMBJmDfLY0PYm0TBeTCAHj+XfGMTSWktgwAKMb+Gb1l?=
 =?iso-8859-1?Q?my+DLp7cwUhMBQvS2JmWcOq3iIcNEArJIKwp2Tk+I3CGPgP8Vd/9fg1BPH?=
 =?iso-8859-1?Q?mneZ64tdIjsk0UhGCLbGREYmAO3iDUMAD8oaGGpOUZJksqSW6SRtEaVmUC?=
 =?iso-8859-1?Q?/ve/fE3FU3An2LldDgdYSZtkRrIFB8s5ca2PwcU3zRb87zPED1LFKu+utP?=
 =?iso-8859-1?Q?gN6laYh2B+nUEadpwOHjJus0V0ugZNA8aPqGK+9jvJCwTBT/iGVXnOewki?=
 =?iso-8859-1?Q?yi8UwW0WtyPlBO+oT5eEdhDv2JisJ2qbO2f7O5BANu6dU0WBkxRMaY1203?=
 =?iso-8859-1?Q?cU5/7qSEEHRnoIXYOh2VoV4jFeQ2h8HCAcvrGzhUf5O2svlb0kZFOcq0qb?=
 =?iso-8859-1?Q?mVOwAftoiNUDik56+9rmD5CW3DioQmeqVKDlcb6OMoyzR+18etzwBLyiTa?=
 =?iso-8859-1?Q?zajy3vL7pGAm9hGNcXu9BB0aJd4HCay+RGCwEolkGeIm/xHUz5zLgqz5Rn?=
 =?iso-8859-1?Q?l0l8eZqtsj+yHsFotTSuWxdh12PTO3Qrf2/dwVLrQ8KdN14cEKC/oVh73t?=
 =?iso-8859-1?Q?q/cWsS224IOqddbgAGJ8ukFpDACW5SRa6GllqWawVdIiiM3oga0kuAQRdf?=
 =?iso-8859-1?Q?LLK4yjAOF3unFobUGfhDFrNlpWhSmNbBqYEsBjn6rbHAMpjZSuMJi1q2Uy?=
 =?iso-8859-1?Q?9prqLppZ+YIog5A13/nMA4Lv+QBPvtk6dGZtxJxMvxy4a1Ujw5qK8jBUZ3?=
 =?iso-8859-1?Q?Qx9KEPDXQ98SsnbNXaZSdZZiHv7sEUPI5W2y3svFi7Dw2Y143exh0WBxK6?=
 =?iso-8859-1?Q?K4/Zr63tHL9kdrgeEqng9coej61I0AHt4lbuItulaENwOH72accXpYktYa?=
 =?iso-8859-1?Q?LBPF8CTb4lfEMaSbTtaogXVc8k8WM++NRZgLyFzGS8ZKm354iQxYK9/4ub?=
 =?iso-8859-1?Q?Xn8Ue2uD1X+eHVG9l8nnpRNKPT4ycTVHbu+cTM8X6+y/4jei4SiWsiaBXG?=
 =?iso-8859-1?Q?DkMAur3xkwA3uoWhY/G4DP9I+GaDxUX0ieSaUEvC1F5Bl7t+hefo2g0Q+R?=
 =?iso-8859-1?Q?U3nyOHavyrChWwmWsFk94O4ddXuZlsIdmt9KPOS3bxI+zPlSjfKcCuFVmp?=
 =?iso-8859-1?Q?p0F6D1NCciJ7i5l0Qw4wYnu0KZoGHJUU4nWRG4qJVzll9tjTEf1ZX4c6IY?=
 =?iso-8859-1?Q?vZNe10GcJAE+vOszusRKIKXG7Sx1AELW7IY1Xic4Xl1iU+it+cHpyaFia5?=
 =?iso-8859-1?Q?Scn56EPInylPqUH3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?b/qc6QrJG34yIOAKtRr4uhW9FiXzksWbxNIe/k3L7fbWkgc28R7drNfyDT?=
 =?iso-8859-1?Q?5B/t/Be8jr9KCTSX7jlCKZRMyAxjSbjgBo1jByT0yL7QzjM8wEBo38MfpL?=
 =?iso-8859-1?Q?nYAjll8eMYwpOWyzmLruU9Iyk0eJ0FveFzrrOGVftLNM86QFSzhWX8pdJz?=
 =?iso-8859-1?Q?yomQRcp+J8/LJgktUdlwkSVaQINZxG0jZsOadDiPLwlDx77Qdis3oUKYaL?=
 =?iso-8859-1?Q?RxwY3z7Vhhzfb0U8+hDzqSY0D/eML4veq8hC05USy4q5EcM3/ye58rN6xK?=
 =?iso-8859-1?Q?slyr3sGYPAjOM/A15G8cPB6DzsQNq2e+mwyy670Lc/9YIXxJK1A/ojL/bM?=
 =?iso-8859-1?Q?6XiZVajHzX4wYNTfLcyJlUEikfuJ5U9BF2pNqyD5Rhk4IwO71T9Lfc1hnw?=
 =?iso-8859-1?Q?sHuVRYaRYY3YBf2qFGVHCHAuNPK1fDDc67Dua3M1hd2tDa5JGQygW8QKcC?=
 =?iso-8859-1?Q?UsdjWEhINSIUdsmdgL1IueetfYECs9w85dJEwC5AKpiQkyyNj3yhtU/Jr7?=
 =?iso-8859-1?Q?jXhzvd3gMBkjRrXXDMKdCuwBWdShj390kuiiynFI16KlBsL8JAxNSLSsdR?=
 =?iso-8859-1?Q?YdPGEruDR3tNn81gSWtLHMm5gDvt1u3cBYrKbUxU32iu0C+cfnru254SEm?=
 =?iso-8859-1?Q?bpNlHbGcRIi8Xt/wa+Dz50V8eSzv4UUqYU7QHUaBPEyqZWmRf2hT9Etjpd?=
 =?iso-8859-1?Q?+QyrczMo2S1ylK2BEUl1S9h8dZra3kA4ZQv/wBANFgRN1v88o+zfDQEoBt?=
 =?iso-8859-1?Q?hn0jXzW4fe+h5LT3GUAu2iMX2rG1Ii8CKlsiJSVjNX0bdE6BissNFrkiZ0?=
 =?iso-8859-1?Q?Xc6b4K34q3gFcHd2KJiYa8Cmhh+NmzEXuFnw3E9brWS+wxJj0lWg9S6VNY?=
 =?iso-8859-1?Q?rb5ZlX41RpSAcPBAQWy3Pw7Z9/6z6TU3cRw3+sTvXIq7XaJXiPTJYH07pG?=
 =?iso-8859-1?Q?lxzLNRtZK/AWAY3zdXvLLEdtcX09f1SUqeaBOCaO4u1BekpHH36f0Kc9jJ?=
 =?iso-8859-1?Q?0ymLF/7g8B6ZU+hrs4odp67Tt3Wb/p03ameuj1GB/hGJlRa8TVzxhgMi2i?=
 =?iso-8859-1?Q?8A9XQ0JMOnfd6xEJE8T27FC/lAsuhNNRbUNjE4bbrHAL56hfP4hWe8ynCr?=
 =?iso-8859-1?Q?Ek+51H3JqlAW98/yVMw2SQhUNMeS/p/kLSCJE94mo4Rfl5NKu9X5HXwOZs?=
 =?iso-8859-1?Q?/N5W5IQQBtKbbGWOrSgSr0heqoYGiaIGJXgHfOiX/A2/CjiP7IME8AeOpI?=
 =?iso-8859-1?Q?Js/6dE7k4hQ63WYBN2KYKuKFneXvBOLLlQVETi6Ux+jJHbIehRziHuO3iK?=
 =?iso-8859-1?Q?81VlHEnLthlWgwBBMPyAPZzS7wdA46EvgO5Tmydvw4UZ4PEuejOBLzXcN6?=
 =?iso-8859-1?Q?OpJvto7hJiZz4JUl68f3PUDaoZ35uIh/Cxbz9nFpuYhTlRD/5t22SfoBpb?=
 =?iso-8859-1?Q?uZBSuUJzg4oGz9foqWcV21y/2xSJtarwbDO8MSKPlat1sgWuF2td2GCGsf?=
 =?iso-8859-1?Q?r00CQKpgiJ9NgMjjqIKJ/XfkaysiWHHiMLt68sJfaj1cXgaQ2luQBJhIzt?=
 =?iso-8859-1?Q?cCH/7MYnpvrMkBX0HcVjjYnOl9wqXrNwIqn8/Q1IKxqB0yJFV9vhkIuf3X?=
 =?iso-8859-1?Q?NekNZAGDDcGxsWbA8byhJg5+uJ+aEFvFJHWVvWNb32cAQ0euhVCbfA8Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbcac5b-9627-4270-4b3c-08dcfec60729
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 00:49:25.6293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1UddIIZT+UyE+BdvRQ8lTYH1P7zVonn2Bs6CnbsVQ67zwABgdhZ/CwO/qrYgdX5xZXU+sPM88MM6uIs+LOLeJklTZVhZFiwXrZT5EUdPYX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5697
X-Proofpoint-ORIG-GUID: l43s60viod2b3UwNuSm-N7Kaqz7TQ4ok
X-Proofpoint-GUID: l43s60viod2b3UwNuSm-N7Kaqz7TQ4ok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070003


> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Wednesday, November 6, 2024 11:49 PM
> To: Torreno, Alexis Czezar <AlexisCzezar.Torreno@analog.com>
> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-hwmon@vger.kernel.org; Sabau, Radu
> bogdan <Radu.Sabau@analog.com>; Jean Delvare <jdelvare@suse.com>;
> Guenter Roeck <linux@roeck-us.net>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; Andy
> Shevchenko <andriy.shevchenko@linux.intel.com>; Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de>
> Subject: Re: [PATCH 1/2] dt-bindings: hwmon: (pmbus/adp1050): Support
> adp1051 and adp1055: add bindings.
>=20
> [External]
>=20
> On Wed, Nov 06, 2024 at 05:03:10PM +0800, Alexis Cezar Torreno wrote:
> > Add dt-bindings for adp1051 and adp1055 pmbus.
> > ADP1051: 6 PWM for I/O Voltage, I/O Current, Temperature
> > ADP1055: 6 PWM for I/O Voltage, I/O Current, Power, Temperature
> >
> > Signed-off-by: Alexis Cezar Torreno <alexisczezar.torreno@analog.com>
> > ---
> >  .../devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml | 12 ++++++++++-
> -
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git
> a/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
> b/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
> > index 10c2204bc3df..88aaa29b3bd1 100644
> > --- a/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
> > +++
> b/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
> > @@ -10,16 +10,24 @@ maintainers:
> >    - Radu Sabau <radu.sabau@analog.com>
> >
> >  description: |
> > -   The ADP1050 is used to monitor system voltages, currents and
> temperatures.
> > +   The ADP1050 and similar devices are used to monitor system voltages=
,
> > +   currents, power, and temperatures.
> > +
> >     Through the PMBus interface, the ADP1050 targets isolated power sup=
plies
> >     and has four individual monitors for input/output voltage, input cu=
rrent
> >     and temperature.
> >     Datasheet:
> >       https://www.analog.com/en/products/adp1050.html
> > +     https://www.analog.com/en/products/adp1051.html
> > +     https://www.analog.com/en/products/adp1055.html
> >
> >  properties:
> > +
>=20
> That's an abnormal newline, leave it alone if you respin.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Cheers,
> Conor.

Will remove/revert the newline. Thanks!

Regards,
Alexis

>=20
> >    compatible:
> > -    const: adi,adp1050
> > +    enum:
> > +      - adi,adp1050
> > +      - adi,adp1051
> > +      - adi,adp1055
> >
> >    reg:
> >      maxItems: 1
> > --
> > 2.34.1
> >

