Return-Path: <linux-kernel+bounces-201182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B162A8FBAB6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A251C20D3D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A30F14A4FB;
	Tue,  4 Jun 2024 17:42:27 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00695F860
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522946; cv=fail; b=UO1ijaKBcSv8UgTYasiKXOOY28ui+i3yh0wOo8997skznsggFF18QTjRg3XMfIYp4d1/jtfnQUXwHl+N/wBrg4GtSuDquCJBe6JTV6QHMMoRKK+cOZZ37JEznvn4N6MZYPJF+33Hy6mmjE2uuJSQclyLs1ax4IJ41JqUbfVj7tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522946; c=relaxed/simple;
	bh=ERtIrYFeqm/Ne4Y0wrpSHj1zV2OoLy4etf7dtdzkA3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qjx/oz2NaI5Sj9sBQ2kFhX5R3vpHs586qyUV4JfX8z6g9eYT3YQZdnBpC5VKbp6APJoygrUBxXcP6OGZX8Xw5x4sa1smqECg3K99kV8vF03Qu+QiWUozYSnagVzZbKX014KKHIk6UG9ebrC2bXN2DQiZYbZcmF20Zl/0xpm+VK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BnWuW032255;
	Tue, 4 Jun 2024 17:42:04 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DJ2czIooQkE/g6w6qgk9SmtCs+2RK3cL0MxygBDJoS24=3D;_b?=
 =?UTF-8?Q?=3DTFj6PSl5ia9dSPD43pquTRwxDNVFUN1Fh/7n+SM44iPwcssTfS61W3nfXjM7?=
 =?UTF-8?Q?M0bFvMIh_YsnwEDmtm2B5/verpvAfyv8wGpMFMSjWwtBaXw/b24vIU8QjInAOg6?=
 =?UTF-8?Q?fejMTd8RMfcNLT_Ppu2AJ0eFC7aCmgxggK/CrPPeHfCYbfRp4sR+YrtVnRMck2f?=
 =?UTF-8?Q?uOa/vVg9rg+XU691pluG_l4jwDklxD3LrdarnuXANzb3F4QQHtjJVIIcM+L2/VO?=
 =?UTF-8?Q?WCR98LskK1MFvwX/erPJflaX6B_t4qelcJr5JRCZI60pQh7zk02aw8U4CShDbc6?=
 =?UTF-8?Q?dOLZxiF2XCk/pbqh5671xbHFAQsaBA7m_yg=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv6u5jg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HL73d016288;
	Tue, 4 Jun 2024 17:42:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsaf2s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imMNGlxodska4MKW+/c/GVXdCwTy1wscKfpLgWFogRWuFKkVdih4JcYWNt1luxDeStziLVXwreyonO0y5qhh0KSdD4CeHGl40761v0I2oIv+0adA2rnTcc8qM0l7gAi0TVKaHzwcoAAMS4Cnrx0+Gbd2srqtecuO4Klcdi3UeRAtGnT59QbCiqmFYEP8XFh7ABMNN/1wZqW6micajYHk8SkmfQ+ZTW2r48Jrr3Du42ZImJL/RUJ7FmV+SANKVydv69s/rGMIWVjGjxCw+hCSUHan+NfosP5YzdifFKCfSaOQT4CcNWTLwxgseE4ikVyCIvVbBiKdx9ijDh3nGOSkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2czIooQkE/g6w6qgk9SmtCs+2RK3cL0MxygBDJoS24=;
 b=D1IP5T/GJPREGxrXj2sANkBlS4LN2V0XCgmDo+MaAubzIyYrorOxh5PJqZllD70x1M1ajlH/upZl2PsRdvL70w3Y/Uisdyk9d5DYnJOra9fMTTxpnsRo36M4jp3U0/ztUwIRAghV56BOJA8tnHkqocL31rGOgZZG+XfMTvHdQe2POY7usdDpF+TxlebxIJx/NfTeZjvmjeJb8z9nJ+xn2x1itFo282DTVdd93M455N5uRB6zjcy+50G6u/I7ZFVkBm6u26QJJn+Tizt9p9c5hEcTk6DVQ4cNd5dfUGvI5ects1HJOCWYdRl8qft8HNmo1N4dRIOlxNRWIB9vrNEv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2czIooQkE/g6w6qgk9SmtCs+2RK3cL0MxygBDJoS24=;
 b=KzoQK3E7GSgCxaF4ojeYk8Rfk1h4/KZ++KrFezraO+Y6Ze9VUUCz/LpxdW8UZQNemae8h2+6Wzznw59khKo9+k6xaHtn51JrayYJfDeiMYV4r7GtbnVMPfdJWIwLIANIwS4c54K/vQTIGmIkx2E53ivYYG9H6l4kMhAOQ1IrzJI=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS0PR10MB7269.namprd10.prod.outlook.com (2603:10b6:8:f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 17:41:58 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:41:58 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 02/18] maple_tree: introduce mas_wr_prealloc_setup()
Date: Tue,  4 Jun 2024 10:41:29 -0700
Message-ID: <20240604174145.563900-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::25) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS0PR10MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d3113e-246c-4ebd-3752-08dc84bda21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iXDGFoBW/C25LblL/Bvqk1yv4kP+n+uR8Co1U9FDUM6Cdn98ecVADQxeWfA9?=
 =?us-ascii?Q?0fNo6aTtOUd26bVpJdk3miF/DOtzWDob6LsHNsXfd/nV1yQoPk1OFPZHMB+U?=
 =?us-ascii?Q?9iJGtCOqdPVIfLGkCtuakHyBg8qY3KelLWbAUdYlbsX1uHmrIPdJSEnuSjJU?=
 =?us-ascii?Q?OPnCkH8yMxID4jO3PlIZ5vTQGFFvxTQMb2dWb/FGmW8GSpvDI4pN4i44O7l9?=
 =?us-ascii?Q?sijl0p1FXfwcgG94Bl6E93v7GTw38I4xu2WVyOxjXL8d6M+tzGhDC0D/RA+J?=
 =?us-ascii?Q?tILT/6MAp1Ie3pQM2HtE1QXFWhWMhfCHt2yJ+D9Nq/Uf7dXISEGLDZTA0B1c?=
 =?us-ascii?Q?MU81KGuQcWR3OnqPJe1xVbzrgCGdE0rK4AvaEo0jVnn8ROWLfmwKOKu8SDW7?=
 =?us-ascii?Q?mugw8RLHu3CHjN8yA3+Oe6g/qKt/NAjfzuIZhmTxFFww2C5H+iTtRKvmE65T?=
 =?us-ascii?Q?Xu67/zz6RCW0QPRDArmiOIekATcv33tuPnspIouHTVBNLNquz70xX0JQtmS1?=
 =?us-ascii?Q?UAIoadocf3kEp5UdJGGGIZFXQSbzXypAlxgWe4sEpJIujiUlRkkxvO7AMhEA?=
 =?us-ascii?Q?Egc4u6ERXU425YhzKVa13S2svuA54wxgn8mXSGCev2Jqdx26MVyskGJzXOV2?=
 =?us-ascii?Q?XJNC2q939PqlS2/rDAVLxH6aixhO9smNGb2vaIyzXwmlK2IuEegnRF8n8RgX?=
 =?us-ascii?Q?LuL1o/f4cOm/P5LQzO32q4EkDt8bHYQigIRUbPQFAAVrfEnz6qSVfPsru+7e?=
 =?us-ascii?Q?0Bx3V62peud3HZFsc7tLjoSspAV5oLYUqwpCCPPHV5lCgMgbtelMOoubzRfn?=
 =?us-ascii?Q?nfnIw94iI+SOgQ/YiZ7At3m7j35JIZYYoZMkq4JbN3WWojy4gzvLCmYMkpu0?=
 =?us-ascii?Q?AyWM5tVU6iW3axcW0y5HyWYZrU8oPWZ11rNwviDMOFvlJfC5SraT264FbIGP?=
 =?us-ascii?Q?4qXhNW3QI5cBAQiULYAwIWO+pjFrT+UrrIrHZI59BfpBExA+AGAXhsLEV6HX?=
 =?us-ascii?Q?VCYahNzeS6enusb0KGj4zHIGSsNgDi8KEIKhoLWvDKN2WDh6jXOiUkOzw18U?=
 =?us-ascii?Q?JQAfLkyW2htmSednks2Y0PlCmuAflmQezWrRaTlS612x2QHijGWoh9aDihFx?=
 =?us-ascii?Q?NNs73Ck9n6Q722Inov6wvTQi3DpMcsjUQvd4+wnwGV5Kp3JgMTX+gqjIGRXl?=
 =?us-ascii?Q?WcZbYQPIBi9EdrZOx0yMLBxrS9O21U6wdE0pXVKJrxfNvprEqrZTs2FLmCdh?=
 =?us-ascii?Q?kkfaEGSmsY9dHCODyN9g/AtviZRicUTzzxuk/kWsFEc1aJR5zO5vy7QxtkNR?=
 =?us-ascii?Q?NPax2oSJMJYxcz8b23/8UBcG?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LIg/uQLUtEsQmWItXVqxiCjE/HZbRTndHGrxJf+iQkPHdb6xuaoRvNICOXHp?=
 =?us-ascii?Q?UIIp0osRE+Lpa1+EPzKnYlcEnMkcbtvcEY8H7FJu4qWivbKlL2MMYMV8bVCk?=
 =?us-ascii?Q?hB5XeqHITXP2p7+ICTzIzxC81WvXtEqTrWNUxwBo+j1waDUB4Vg5p6+mGwnE?=
 =?us-ascii?Q?kiZDiCcd8i3TXfEglgokqO/PniQxIAstbw1px3N+DA+Tzj0aQhRGMsqQ7oTM?=
 =?us-ascii?Q?EW4WAzhqvuJeWcYfcKeya0hpcxkpLkzFLD3dCutPBVsMasQB5bn0UXvwc1UK?=
 =?us-ascii?Q?sDilJ7PHMVlfvCE3E/NZjIKz4NwCzZYdK2v+RJpKLb3rRY6sY6c80aJpfbzI?=
 =?us-ascii?Q?4A8S1t7JiJ+MkKLtgpD29abFENSTwvEq8wMxDAVP96JZx0F6Y1bBxTgc6Z1S?=
 =?us-ascii?Q?BpR2KdQxp3RXWix9c7uN+AhiFblEWzprcjfEYlLwplpkFHTbQdFft2Dh+p3N?=
 =?us-ascii?Q?wjy4b1CYLVRIsV6P24dyi2irKUxLI1JTQdRcjOxYa6vNj0c2Irpi05wbipaJ?=
 =?us-ascii?Q?vXaW6cN/wV9InsPam8XsS8rr3fr/icwjunIBtPHOlftHkyYUHuNuT9FYFdaq?=
 =?us-ascii?Q?iN2IEAhACdAIwNt4NmkqYjXHiBcpwAZ5rNcAdVPHuMzcG0TD+N9Wqo4d6yhL?=
 =?us-ascii?Q?WTRUvbRvhujz9vNvMVh9IwLIC4koW4U/GLz6nnp0p6/xkXVmg0mvVDNnEUgG?=
 =?us-ascii?Q?x4W2U6xQhdtw1KtZjqZDiCS1cZS/llxnclaxXeGaN5D6rZPepa4R+7k7Ica+?=
 =?us-ascii?Q?33geF2UmKy3sTtcc9/x+lrV0tuYPTT+gognBFZ/WtMUC6X2MRxbZytyg2rZ8?=
 =?us-ascii?Q?AiSCLyOizvOLxPxoFhP2QstekHhiR7z32cq+gmp2gB/O669sFDjnbscw2lNS?=
 =?us-ascii?Q?fNq//Ui70+CG7VWYuKxpRDSWZZJPvukKkJMGyf7p1z442jsv/TvZmfRUZYPx?=
 =?us-ascii?Q?msJyL6xcmaHc48kaLSaALriFZeBAyTC+Vrcz47jlm8ni2oJISYtAB5VdL9jR?=
 =?us-ascii?Q?bOP+9Iz3WkauWCaXHRia+Mkd2yHyyd/FQ3mD1TWZn+LAHI3hvtCCQZJJp7lr?=
 =?us-ascii?Q?XINoGL9Zc6NThrxepijsNQnBeZ3wmsVK4IxM2g5m2rSruPzt+Kk6eacsdIY+?=
 =?us-ascii?Q?3AgyApLhCAf1lGCq4XGtTvYG+K9ghKOxx48nB/KbhDftpmlUJ9OUb8RNryxH?=
 =?us-ascii?Q?jCxUqw9jPyiW5MLIyh5+eJD6T3zhVkYtRE2XnJa7/vpYV/FuziuDfZHLy09c?=
 =?us-ascii?Q?LKxIvwHf41T+rpnZPhHKG+TSP1lFJ/uCLuAJykgVhUMyl+VUHONeY9wUDh2V?=
 =?us-ascii?Q?2sklrNrWAQHBIC6STtmPqsHoRcGjBiH9dKhDNjqRPdBPbXKx/lucSg8oUzLn?=
 =?us-ascii?Q?IoE8zougPzxytscHEWswmc4y1fjTezdBLB9DhOz/7gIW+zTenRktV06xHLhu?=
 =?us-ascii?Q?D4qp02gDPIA1RbWm73QwHhdb0fY4xr/s4TRcAF7grXqo2ZHmfMpoMNAVV8z6?=
 =?us-ascii?Q?IFWgpwBj3mpoUKjasGO12zRgJ1eAmpoO2w5MsfBfYMpDbHN5YVNXJUFn48lM?=
 =?us-ascii?Q?H0UCB1Lp9lyiSOhxrymI8JqDpKgJ7qwO6nRFou7eHAaYxVeY9xGrNOXsjrBe?=
 =?us-ascii?Q?poIFn4z7zOVRgEM3oDq70vg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bSKb+f8WdJN5s5kXb85jfPsOKNg3wHGKnpEQeXY86vJPSR55PVf+LPfh1HpV72pPpLVwIJAI+QXfP+8BcpsXKM1Bc/eTlfqYC4Uww3tMPPcPSzfspW3vF8f6WXgGG9F+ST/5YRJs7J5iuKUqhOffCxF6J5ATDezhIUJ2fxEO1jtrXicpmqbdAEtJ8Ltnka342ladJGSAchD1FoG5kcdbHN0hfAH/+rNS8n9ULCfPEp/0Og9Uruzhvena2FOnH+RM1+Nj5P7q584r0tJktJig95Yac7LMS5JnNiWXofUpOT1DJaHZY+TstUatHHX6F6nD1ewe9b8UWwL7hryOkdemOGY8z+sFTpHBZyS2nB1o71BWZorHpJzch8KflPW+zApnzxM7rrE7Bb+gtMWxd2XYius8MBGg9vQEj/7t7fbIUmsK4qM5j/gf6RV8TuaKPmCh32QD3MKyFnxjBdZMaKQWCLxT7FBb6554FtjG1VeaFVaCJ2J23tHfPy2/eGk9BYjykIO0KVDCdTzcAwgLmGzVlrZY+DeV/4j4Qy7EhG9ucPgAHdzs0wqbLLNuir6KkJjoYmY/Fn3Zo6sQ/QxTb0OpMIoMYj1gEj8UOrpLNtFpJ7Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d3113e-246c-4ebd-3752-08dc84bda21d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:41:58.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2e/tUSeSe91+pI5CP5Uk9gX109exqPNIg3EjDQOlALS5TNGXhwBQUBWr0/PvHl7FoDsKqs5N0Ffkg/DowowSAPZ26CxJSPh6MRSrtaoXqMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-ORIG-GUID: shO83HU9eRyOQbTsTHd4u37qy0g0M-R7
X-Proofpoint-GUID: shO83HU9eRyOQbTsTHd4u37qy0g0M-R7

Introduce a helper function, mas_wr_prealoc_setup(), that will set up a
maple write state in order to start a walk of a maple tree.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 2d7d27e6ae3c..ccbec0f66562 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5402,6 +5402,13 @@ static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 	mas_reset(wr_mas->mas);
 }
 
+static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
+{
+	struct ma_state *mas = wr_mas->mas;
+
+	mas_wr_store_setup(wr_mas);
+	wr_mas->content = mas_start(mas);
+}
 /* Interface */
 
 /**
@@ -5507,8 +5514,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 	if (unlikely(!mas->index && mas->last == ULONG_MAX))
 		goto ask_now;
 
-	mas_wr_store_setup(&wr_mas);
-	wr_mas.content = mas_start(mas);
+	mas_wr_prealloc_setup(&wr_mas);
 	/* Root expand */
 	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
 		goto ask_now;
-- 
2.45.1


