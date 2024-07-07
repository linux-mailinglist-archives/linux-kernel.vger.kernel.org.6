Return-Path: <linux-kernel+bounces-243465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41293929675
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B90B21628
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 04:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5ABDDBD;
	Sun,  7 Jul 2024 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NcFCPMB5"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2102.outbound.protection.outlook.com [40.92.20.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED3CC8F3;
	Sun,  7 Jul 2024 04:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720325673; cv=fail; b=XPnOxDPevlyDvDNxk3t15fCkit+hHvrH1LlJiMa2njM//RmxTPDf147NPzzGLVX3pU4LB9pLy+aA/lUPuSf9x8xSkFgPa4hj5PjLOnVrS5sRYPqKubDX+OC1cK7HfnsNgJjIB6yb1zD/kwpm1j6krLtAdnAgHJ6iyMWkaPkIIGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720325673; c=relaxed/simple;
	bh=XBoww1ly45/5K04EdaiUbvOE+WUN+DbAPj+Q/NAk7rQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RYPpUFcQKZ7GauHGJa35bhEQrIw3E4T7UdVjAXduYididheVq+svM/xmb8B9bURTpEi81TQ/JISWNskEp4rcKakPG1onK2fHbEEwxqJIA8fTRRAkiEYOSeXHHGWRW91M+0hJyn7Na8UWhgcDMN3UCz9b1aGdlFEqL0cwIDcYiIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NcFCPMB5; arc=fail smtp.client-ip=40.92.20.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcY1Em5pak0Jn4rDlH4kVvYov7LMUKnE+8SDS4Cn+a5aUIFeamjlnepEOi2cejnrYq0pNzSay7N5Y7JpQgLONnoghjhvIbqmhBF3/mJXKo5NdDoRnGrbtmzMO/fRB/IaApdbhU3ENiVnNex0C09MNXGs8amdS15Baj+ZJjdMjmi3n1aAQtRL5j4UbbSUMSmVbThHNh1HwWT+U0pFbWSWk40SUEvl6R91GHIGOnaE+HhDl0RWWMddQJrbcOzDNjyoBX92tfJPcPJnvj3AlpSBRqoptnCUQDnN9CqyWYEm2e5xg8Glu/QVa2eXxtMzuLXDtQZk6tRFoGKQJ9WtRLnUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBoww1ly45/5K04EdaiUbvOE+WUN+DbAPj+Q/NAk7rQ=;
 b=l3IHZQ7QEoXLd71M95luGblUuxsDMQNBUjqNZ5FlyNJFNwaE5eAOdKWB9pEAyJRTuBKK9idIsZ3dSAuGRVa8iWyahiHJN9h79y3U42+Stb77h3FIPIHR/NREz59hH3sxajjHuJbpVqdRgIxfCvSsS3Wwtr5J3NoFeD8z852VSHc7d5aqG3Hw6ZuGbMOsQNfBW6KcMdBMDYvtjKhiAouUj1an8I6v9Pon8a5ll+4Y/7ve/Ah1urxuExczDozFt0cCO5HjAZmUMyg6lGIQLx+QTawgpVU9uqjJbKH0UCNjJmaPaEB42wkUAxEsf92t0SrZCSWS6MZUQpx+OObkT2zSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBoww1ly45/5K04EdaiUbvOE+WUN+DbAPj+Q/NAk7rQ=;
 b=NcFCPMB59BJZtnKieYCnFsovm8GwmJ8mT5TTYfERRyXEwxXfwrVaBrLjnP1eIY1f0N0XP9kEoUQeIKUGbC2yRFnoj042vtOUEqyha6mV9iRXRU5MYlAxEfx+xB/koAFa1HGuQumfow/l1dQ7fvX0Sr8BjgTFt/mQhq/sb+35xFa10HZJ3aMSEXC1ZIrkOqJWnAYB0VNfQdfcFck4OAn8+WbkiltgMp+3dtdEGXsHeCO8HxomTSZTrb25CKJ/OOhQ6UrQQl47MkplfOABy4iJurfQVqLcgwMgZ9QUZq+mtiNwlXfKRq7TVlmCC60GqmfuLPvYzAIVshle4Tf0hw6DtA==
Received: from DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:b3::14) by
 SJ2P223MB0798.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:545::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.34; Sun, 7 Jul 2024 04:14:28 +0000
Received: from DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM
 ([fe80::17db:c539:a782:454e]) by DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM
 ([fe80::17db:c539:a782:454e%5]) with mapi id 15.20.7741.033; Sun, 7 Jul 2024
 04:14:28 +0000
From: Gold Side <goldside000@outlook.com>
To: "perex@perex.cz" <perex@perex.cz>, "krzk@kernel.org" <krzk@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: [PATCH 2/3] Removed extra asterisks from comment beginnings, and
 removed unnecessary comment end
Thread-Topic: [PATCH 2/3] Removed extra asterisks from comment beginnings, and
 removed unnecessary comment end
Thread-Index: AQHa0CJvJ7T+vjvKPEWzT7C9hQ9Tig==
Date: Sun, 7 Jul 2024 04:14:28 +0000
Message-ID:
 <DM4P223MB054139F737887D40A2CA396FF7D92@DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [e3gN79xkaEdp9VbkGpgfAPvduLbt/IDw]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4P223MB0541:EE_|SJ2P223MB0798:EE_
x-ms-office365-filtering-correlation-id: d753cdf2-02aa-41e4-7ee8-08dc9e3b4b43
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|19110799003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 +xjsjEBOsUWBpkGMDnfQsDSuDHidLNq5e1KcqGPkMcL4XbmEa9xA2aC7okutG8JuSEu6QHlJf9J7Gnl63Je47ynbqmh9rdiMVPjL0jVIGVyMusXki2Psb3lR2qj7Wfw33iR2WFC79+flnNPNfE4w3qxlaS22R4afRXNaua8HCI3wqN8rqu0UfH0vAR01xHehb1IjDWXtycRqSisp1F2t3rZp1PzEIJD+kXbxPF93vXrk4oHnTfOi4SbepB9FRNz4Zi6PsSmKZwSC0zfaz6YfIs2V8qgIWuHyg8QCY/hAnz6Wfh0QDI5XJJObTnLLFNKWeqadYYdBuIjyzKLToQ3qUl33TpeGpukvecQUo5/lsdwNg0e8liPSK1dY9jwVJHHgK/SzmYlJX5/xq+PI7ZCunaSJbbOh8bhJe/IJT/PEhkBYeOkG4ABtQvL1rDXWV+E79BFh3HVLgBho87G6AXSbmPFd3bX8wMpg6F84FBfzr+cNpMp8Hh0FcP4ZNudnkIxKWvu2MSxywrlwwkXm/Fe3GsPzH9MESCRXeRzkux/BVLJSiQNn7eoa1O9z0B8NdMEtXa/J9CkHAMjNEKar0y8wiT3gVsxsbK8V26OQONpYzYToONAkC1W+8Yvug4F+YicLS6MgHCfNhumwByj7xujmUg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?m7bsQAQalB6X0TTvlZvC8ysw8ooitrCN5/Gc2GWa95yYkcFhV8RFaTnqLZ?=
 =?iso-8859-1?Q?Glq3EVyR+A3mdpaXcrahJj/qf46tlpAzzIQnS6BYBDp0/jtGIkrQm60wDJ?=
 =?iso-8859-1?Q?mC+6C6XDOpq5TSL9oDCIaD/5JDsXTo5ufL84Vc2xikKRitdQnwwb69D9HQ?=
 =?iso-8859-1?Q?yv2p4bWEYLBYTM0NlPTg2HajZ68Ms/v7RCFVEqlC731otPlSPxCfwg1mVx?=
 =?iso-8859-1?Q?PwAjMTvLM5eUoxU7dLf7MaiGj1M8EMVGXtw0YSJUVQO9qB3BqN9rpKZYkj?=
 =?iso-8859-1?Q?VMVykpvn9Jp4iB7H4ArQIJYlIZRDxxuYx75KMYOkWPeoNfe9GKoTq2gSpv?=
 =?iso-8859-1?Q?H+juiQDLYaQxNALDSmNnuhLyB3PzZWFQ4pzSILDpIiJYmlkyPRz+r6lfbn?=
 =?iso-8859-1?Q?8owxTen6q7cYHVNFb23tsMQA5MVCpfv9I5JpINI73fzKlmQ+NuJLN3glGv?=
 =?iso-8859-1?Q?uVbp6VO2bfg1+oNrT5VtrJcAHC+P9DQQVhfNUhH1+3nikS9P0PMKqxEMHC?=
 =?iso-8859-1?Q?tr5X1X09aGvKRgBkbLZeSlHHTrrgI+JSvP/Cg9g/aKLK8jq99YDNZuBRea?=
 =?iso-8859-1?Q?MSk/zhcsayF0oBLPbuEy16PIEXeUtssB49ogw1TkLkAU19pxrWF3rX2zsu?=
 =?iso-8859-1?Q?2O/y2r65+IL9UHnB6e4NbiD9Xq92x0N57xM03AWGoYJSNwSTscW6G94Tbq?=
 =?iso-8859-1?Q?FYrxwLulDoz+85A7tou1ItqThTnve8p7Jujo9WEXknK8P8R/PDz8hM8FWO?=
 =?iso-8859-1?Q?PMuAwR0XQuufaYPx6QQHywl0qhs5kJdICEK2H81uSQA/qUhj2USqhlM5b7?=
 =?iso-8859-1?Q?zJ1hyMon9mCF6WPdukNhsgLlrceYUK0tZycc9QEVzvrd924ZDT4N72xMsu?=
 =?iso-8859-1?Q?K+NOllBk7Ockg9Xu+7oVMw19e1xiTJmqUKTUtrPijeFDh0wtGOZ8Zuja+I?=
 =?iso-8859-1?Q?5qtpKWai80CuSIx14IX6C3cFkk/PskjA97G9vvk1KAnwX+MjCxTUQgzlZX?=
 =?iso-8859-1?Q?CKbHybCzashyWCB/uzbZKrlbAIESzsir4NYSKvsmWzfw9S04txHeFX2kUP?=
 =?iso-8859-1?Q?dOaafpoLPQz1ZXABT0PM/4uXtyq2P0weBP6Hu77N2y97bnPxMOzKDcNLJo?=
 =?iso-8859-1?Q?fTyIp88G/J3jIE8lEKQQ+psaObD8KgXhXjcRCofKbpyOWwYGbO6y11CiZV?=
 =?iso-8859-1?Q?sRo2BO/kqDsWZaib0c6GZfKPsED58aEpv0iCBaoDGzCnJ8XPpn3qcL5Zu7?=
 =?iso-8859-1?Q?OVDR/GOoT/ax6HJf+0Nw9oY52TaO50HnwK6WAPDk8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d753cdf2-02aa-41e4-7ee8-08dc9e3b4b43
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2024 04:14:28.2420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2P223MB0798

From 33dc0aa3973913f310840cc8f7d5d599d573c297 Mon Sep 17 00:00:00 2001=0A=
From: Steven Davis <goldside000@outlook.com>=0A=
Date: Tue, 2 Jul 2024 23:43:15 -0400=0A=
Subject: [PATCH 2/3] Removed unnecessary comment end=0A=
=0A=
It still works the same without that comment end, so why is it in there?=0A=
Signed-off-by: Steven Davis <goldside000@outlook.com>=0A=
---=0A=
=A0include/memory/renesas-rpc-if.h | 2 +-=0A=
=A01 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-i=
f.h=0A=
index b8fa30fd6b500c..591dd86f55f879 100644=0A=
--- a/include/memory/renesas-rpc-if.h=0A=
+++ b/include/memory/renesas-rpc-if.h=0A=
@@ -1,4 +1,4 @@=0A=
-/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/* SPDX-License-Identifier: GPL-2.0=0A=
=A0/*=0A=
=A0 * Renesas RPC-IF core driver=0A=
=A0 *=0A=

