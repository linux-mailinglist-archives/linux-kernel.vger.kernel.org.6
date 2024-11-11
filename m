Return-Path: <linux-kernel+bounces-403578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486F69C377B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2091C2169D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B30814B956;
	Mon, 11 Nov 2024 04:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jF+ZQOd8"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7EC136E3F;
	Mon, 11 Nov 2024 04:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298771; cv=fail; b=Pd1g5e4DUmXQUcX4XYWcEVXFRxdrT24GT1+3OwfhVfoITy9Adn3pPOPBorOKBecI9n44zJwTI7vg79UunvOyxQyzbonjqn7aZGrUFXUzrOIPhZnqCuDB5dTjGJgt5ikWcR3HixMupdnBPHoeGxBSHJDn+/H7RS5FenUj3A2QhLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298771; c=relaxed/simple;
	bh=KJuiXHpQ+jFZzXur5Khogj/Cc2Ldg9IIIJ+Nt8HcFqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JBTIoUgjUvlGA9pihiXzhJobXOECpxaYiOFy28dxNScN2JPJxGH3YzuGS1/8V4uo2flZfl1kE262xPC1tNrcC53vK7qS/Pz4v498xtcIWxE7ESiqTeHvSEeddwj/0K7QXhXjW941JItroy9BMbaxq55fuIxGWBJFijbmZ/HPLFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jF+ZQOd8; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB4FH87024956;
	Sun, 10 Nov 2024 23:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KJuiX
	HpQ+jFZzXur5Khogj/Cc2Ldg9IIIJ+Nt8HcFqA=; b=jF+ZQOd8Vq3Oo/23BncN/
	L95fsI8B1T/c00ueB+0tZHarIX8D9sa1dc1SyGoX68K/pB1G4exe2aNa3qTzqjFo
	apLwLJs+aho3394uyshNauuDTX9zVzPknRwRijqeqmuBaqxbWDhnnfZpyR0hkicO
	3bzY+2KLdo5EhXOOd5k2HAGhqDMD8K8urDHFa+0Uz1FeOgUwqSuYtJM1r9/yUV0f
	L3BR59uYmG/03xlXSoFIAfWO2E0BEJR2cdI1f1UpR2qcK4koqknlnjjaZtdGeE4k
	q0UtHqrYmq2s7yek2P+vW+qsDmUstDLKGMUBCabSgb5FZ/acPzkKtuFZDY2z7JCi
	g==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013074.outbound.protection.outlook.com [40.93.6.74])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42uaqy00d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 23:19:15 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1ibwCPiq5j3JSniviOlsp0a1qHjE4ixLM5M6Oh3+Ttljo7f0GN2Qxu1upQZyRGcz+WLklQl0Yq3p2SGlA2/MgDsoDNp0QjzEFggxvS3Ct2LvQRdsC34M6BiuGRAqS8AdirG0b/liIC68vmADw/Piq0S37Vxb8xcsd3haID0KCKgA20CmiaJUlUB+nFUtb2MAEOdbq1S3tturTANwsQLP5Zftu+00i2bzM/QM4PZfXuKfzViZcf8TPXooJJiOx2d3zOKIm5juF7Ma47iIJsHyegspmd0CiyUwc9xe3eYYGxhihlmeJiNTZdBJOtiT/LBTF5IRY9Ubwk1YoeNtXyERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJuiXHpQ+jFZzXur5Khogj/Cc2Ldg9IIIJ+Nt8HcFqA=;
 b=RpBcjUbuvo3sujPxwsbE6mxPkGlDBPiDpKTD2dDDhtBkecGrCD5WhQNvI7BF7VNhNStyhbF+xQ1X1k6JMLxaeEPpMK8BJOq6jbtm4duStOrhg3RzOfCus8mkTmnKmLyUU9P1anwdP9nHQhH1UJtH03dlBQRIWC69Z/QoKxnalB2nqoYURfcSJvv3iDiEqHB35djX54N70aoQjDNRkFsPLdqDWVLvhr01gfbmDKB60qFN3owgp96teQK+9uxS4Ul5IPVTTwKY1uCy2UnQ/sLV4YaL9VPyhNgN6mJzvM9He795MfOlVFraBGOWAPINWQm3t4EJa0VQeSCi4gqCWc4a3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BLAPR03MB5604.namprd03.prod.outlook.com (2603:10b6:208:29a::12)
 by SJ0PR03MB6630.namprd03.prod.outlook.com (2603:10b6:a03:38a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 04:19:12 +0000
Received: from BLAPR03MB5604.namprd03.prod.outlook.com
 ([fe80::3c24:93fb:94a7:241e]) by BLAPR03MB5604.namprd03.prod.outlook.com
 ([fe80::3c24:93fb:94a7:241e%7]) with mapi id 15.20.8137.018; Mon, 11 Nov 2024
 04:19:11 +0000
From: "Calam, Ramon Cristopher" <RamonCristopher.Calam@analog.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown
	<broonie@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/2] dt-bindings: regulator: Add adi,lt8722-regulator.yaml
Thread-Topic: [PATCH 2/2] dt-bindings: regulator: Add
 adi,lt8722-regulator.yaml
Thread-Index: AQHbMcGk+onE/m24OUKzuqZ/zFWO27KtK1+AgARM8ZA=
Date: Mon, 11 Nov 2024 04:19:11 +0000
Message-ID:
 <BLAPR03MB5604B8864210C6DA21072F4293582@BLAPR03MB5604.namprd03.prod.outlook.com>
References: <20241108093544.9492-1-ramoncristopher.calam@analog.com>
 <20241108093544.9492-3-ramoncristopher.calam@analog.com>
 <173106106125.1193852.5591566183422782580.robh@kernel.org>
In-Reply-To: <173106106125.1193852.5591566183422782580.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR03MB5604:EE_|SJ0PR03MB6630:EE_
x-ms-office365-filtering-correlation-id: a2b3c41b-28d4-425f-3feb-08dd0207febd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFYrRDhUS3ZwckZkbXpnUWJReFFkc2JJR3A1N1RoYzgzYUp5cmoycENLQmNN?=
 =?utf-8?B?M21YNUFTd2RzV29mWmNLRDNnNDdDSVlKU1VMZVJydnBNbmF4YUZQVDQvRnpH?=
 =?utf-8?B?RmFqQmJOYmZPandCUkhpdHlmRGpWd1lJZXhpWUFvYnNqcTI2amdSNmJYVmpI?=
 =?utf-8?B?cy9ZcUtFUVYzQS9FNTFpL2k3a0xPaFpPRU9zOTFWSUlCWHJuUGlDc01HUGxv?=
 =?utf-8?B?QmViOE8yT0syMnIyKytDMzBnVVd1ZmRrR1liRGwrT1BJdzhsVEJaanFtalpt?=
 =?utf-8?B?cHhlN2dJSDhYTUZpbk5tVlRMOHd2RDI5RWI2S2hyRnZOWFNzSXBIWkFWVWha?=
 =?utf-8?B?d3M3c01SUjV4Vnhrd1U3bVYvYVd4WXF1SjR3VW1RRXhBd3NoOEg1T1VBZEs0?=
 =?utf-8?B?VXJDM09nb0RNMjZSMTA2SC9QN2hGSWVISjlXOWhRWnpUZmJqTlpQUVVYNVNB?=
 =?utf-8?B?NzVEcS9lVHZRTHpScmREbllmT1h2V0lQK0M5Q1RIU3RJOXFTRjVRc2dRQ2dq?=
 =?utf-8?B?REQxL0ZaWTRZQmlMNGY5Ty83Y0dLcmVFRk93K2hWcit3VUpqd3hVRUNQeWtm?=
 =?utf-8?B?eXErZm5UNk1DdC9BbllCL05TaXBDTmJTelpBR0RkYlVwaFVZNzkzS2lvKytH?=
 =?utf-8?B?TVQ5TkU2YUFEb0dYbnFBMlpSdnZqRUZpbHFYanZnZ1l1K1pYcXQ1QUFSSldJ?=
 =?utf-8?B?RHhxb3U3UXRsZWkwRDRIdlhJSlYrVU4zV1ZBYXRCeUNmYkpqZlRGVFRqblJi?=
 =?utf-8?B?c3hCNkFRdnYzamFMdUlFdXRXaTl4MVRiRjdZbzJjeUkvalFkbW90ZjZlWWRF?=
 =?utf-8?B?Z1BHQVFyNWp4Z0FGZG9ld09Xd2ZQY29rU0dDSzRYbjRTRll1VHI3OGZLa1dU?=
 =?utf-8?B?czc5ZFRUeGJuQzlxMVVvKytTUnlZVTJOdzYrcjUxSi9YelVtb01MOUZPa3BE?=
 =?utf-8?B?d3RTK0EweUZ1bG1yY3ZsbVdLdGxDQnd2OHJlNC9IdnJTTkRFTmxWa1ltZ0VT?=
 =?utf-8?B?em5tRGNwZGNjRWl0emdnQjdyU1h2eVRPU0hhWk04TTVwL25wT1JCRmdJTnBD?=
 =?utf-8?B?bnVqVUZjaThDSUdUREttTUlER0ZjUUd3QXJjRXJHc0sxUk90dXl5SW1UYmRr?=
 =?utf-8?B?SUlQSWJ6SzdZRzN2SWROWjJGdGRwY1gxRXVyRnZXQUtiRXpDU24xSlVaNnhX?=
 =?utf-8?B?TXVxdDJyMWVrV0hWU2lUSU05V3VUNEEvcTM1S3NXZlZvN0c5MzdvZ3VYUDl2?=
 =?utf-8?B?L21DZzBNWTZlMDU3Sk12YXJPRXdqRG1vbG9kaHp4VXdnUjA1SXBKdU1kYVVN?=
 =?utf-8?B?UFBaWCtGZEppTHlCc3F6REZDYmJMdFN5WmRQVTYwYzRkY3BXNi90VExLVlB4?=
 =?utf-8?B?WjFodUp5LzJlaXdDNkNOMktiWjhVTm9taUxCRjB0ZElPNmNGUlVWY2kwR2VG?=
 =?utf-8?B?UE82cnhaRCswTzZrZ0pNN1dabTJUYklHR2JsclUwMU1ERVdxMFZ2YXY0dXdm?=
 =?utf-8?B?b1V1WFBUenJtdGhpNDFhRTd3M29UU1pUSS95Z3VEMDcrRDQ4aVlnckFRKzRx?=
 =?utf-8?B?d2VxbUdkcWRYSVBkUm1HaXorWDlhNllsalJ5dERiZkx3bUZFQ09CM3NPZ0NZ?=
 =?utf-8?B?Wk51WXVvMDh0ODBxNmNBNmtEWFFpU3dRa3dIVkphWkNmRkNkSUZ1bWZ4eldZ?=
 =?utf-8?B?TDZtMWpZbjIydExNTlZjelFLcFpVbEFET0ZPdW5ySlRMN0xXUThZYWtabzVE?=
 =?utf-8?Q?/ncXGz8eXUasEHbUaYu/fohAXldMkICrR3w59zS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5604.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0dnZEdndEF5RGZUNUU3QTJhSWpRbnoydXNFdFhYTXk3cVFIV0wxc01yODRr?=
 =?utf-8?B?d3duVWV2MVhTaUVOaTFnTmk5QWJJaDRWQ0puZFhrRmJraDh3aGlCaGxsOFBF?=
 =?utf-8?B?OG04aExRR0xvTTQyNlEwTi9lMlF4UGpPeU5aM3NJQlBhUTRZMkNqSnB1dW5Z?=
 =?utf-8?B?TjBOTTF5QWlLY0xRWkV0c25yUDJ6aEJFdTBWK2k4WEk3VlZaMG9EWmdPNkdm?=
 =?utf-8?B?L3VuWGVBTFQydUxTcTlEVVBicUwxVXVicFdaQkRmVWxlbkJsWmFXOG51cXFw?=
 =?utf-8?B?aXhEVDlaK1I5RGxJS0g0cUNCWjE5YmYxU0hMVmx4Rko5MytSNWcwS3ZnRVJy?=
 =?utf-8?B?ZnhXd05SeWpjMW8zdzBIZ3VmWWJuWUdOTzRmVnNmSU1EVDhhQm9vajBSQ0RG?=
 =?utf-8?B?TXJzNE9MZ1NkS252MkUrVW5oOUtoek9uTk0zeG8xTmFtNEhxVC9ldDh3cUtX?=
 =?utf-8?B?VDBQU3hMclQxRlo1OUJoTEFHck9Ca2FtRFhPaVBqdUJPb2ZxR3ovR3IwTmoy?=
 =?utf-8?B?bTFmdHh3R3ZicCtUOS8yaU5aanh5M1MxZyt4WDY5Z1ppZGhZR0pzTHp6S09y?=
 =?utf-8?B?cWRGRStkRDd1Z1BRZ0tXMllIVFBqZnVpd3NGaHRuT3dpU3lXWVpvdHVlOURv?=
 =?utf-8?B?SEVsZ1VMY2RmeUlZUjhNczlVQkZKZDd1RGRUT3V3L3FrWmNrYUxpZTJwb2tG?=
 =?utf-8?B?OFZXd2tVZTllQWdlK3pVRllwN2pLamNCbmZOTDdCS3Z3UzZrS3Q3OVdaNDF3?=
 =?utf-8?B?Y1RwM1owK1hRMWx6dmh2UUpYdjNUZU5CSTlrTnVheUUyNmFEa2x2czdHR1BU?=
 =?utf-8?B?L29uTEp0MWhOQWoyVmczdU1sT0NDdUwrWXJNUlRTdWFRaFpVTXRSMVZMaWlV?=
 =?utf-8?B?WUQ2MGlPY2doc280b2pKeGNzaWNVUlF5YUpLQ3E4OS82MzBNRU1iSzNpeVBE?=
 =?utf-8?B?OEZkTlg5S3d5NlBMMm1yc0QwVmVwWkNKTHYrR1lpSy9wOG1LL3pXMEhmemtH?=
 =?utf-8?B?eXkzNncrTnk5czlFbFpoekE5YTVSOEVQeHJ0Z1dTZFdTbHVJZDc5dXhKaUdD?=
 =?utf-8?B?T3lOWEdJd2ord1BydTdDV0F3YllKUzIrVk5rRXpkMmdGQzVQY2lqTzI4SC9N?=
 =?utf-8?B?UVZGYmNWc3VEVzdCQmREYm9JMjVzaHVpVnhSZ0xlYVN5amVLVkRVbTlZTW5G?=
 =?utf-8?B?Q011VkUyY3JIcktOT3NqNVNKeHAxZitZV0NPQnhTUWlJRVhRRU9KUlZKc2hD?=
 =?utf-8?B?NFBDUllpeHlwdHdOaExvdW5zdHY5WGVxSHVhczJTOVdnVFlYS1RJNWpMdmcr?=
 =?utf-8?B?SVRtdXUvL2I3dzc0dGFzZFRQQm5XaHVsTnhLNTR5YWg5Snc0TlJNd1lGLzIv?=
 =?utf-8?B?VTlEUmlYdHVBb01sSUUxa1g5bjBsRWdqMW9vTXQybU9DK3lRcWlSaE5naVBK?=
 =?utf-8?B?dGVpYW1QMVJRdm1jZWVrc25vL1BORDZINzMvSGx3VWY1NDdtd1ovUFgyTUlo?=
 =?utf-8?B?Ym1sWEs0RmtQcDRzandwdzI3NWVCaGlOM01UNlA4TGlPcUVMWmM5aWQvVFFT?=
 =?utf-8?B?bGZxcnhTL2hWNzF2QmpGM0s1NnFIbERRMzdXNytrYVIydmZ2TmhURVZmblRX?=
 =?utf-8?B?VzZ4dlIvWC84RG1XbWxYcWVSWU9NcHFNR1Q2Y01VczZpREtlYTNQUnlvTzh1?=
 =?utf-8?B?RUZjOHVEWnRzNUxVeVluL3hVZ2RWTWxqUU8raHNMT2gyR1d1OXd6U3dJN1NR?=
 =?utf-8?B?UHRFZ0JwV29RYmszWFZ0eWRUY2RhNjRoYkZCdkdQbGh4TjJhRTFaQ1ppampu?=
 =?utf-8?B?Z0ozT2J4M0w0bVBjdHpmMzh3bHlHSytRSWc3Z3NjUUxlNHNzcGJJK0k2V2Ey?=
 =?utf-8?B?NFlxSzA5Z2I4UWVFdVNoeUk0T3p4NXBNRnZRNVRrVlIxTGlvRUNBWXAxRzA0?=
 =?utf-8?B?MWVVVXEybHA5cDZ2RTJ6d2ZXdzVwaFN5bVExdDNscEhWOXdyeHl6bWtiblMw?=
 =?utf-8?B?eWdLNnduTk1kSmszalNYNlhHTnNzMUJsSmVQc0hISlVwb3duQmpmckh0OFIx?=
 =?utf-8?B?alJpa2NYc0pNblR3S0dFTDk2YUxjMmM5STBpVm0rMFNCWTFXbDQvYldOa3la?=
 =?utf-8?B?SGNXYTRqTWZnYm9QSGFJNEJpUEtYMlVLcDYwWExpSUpWcXdteHhyd3hxL2x1?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5604.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b3c41b-28d4-425f-3feb-08dd0207febd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 04:19:11.8198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5150n+chBRKTDjR9K9j0SNrsB5xDvXEYX1xjBPYnz8Rmm9sT4X1X3fNOD3RZ5I7iOVDdV84Q5Zeq8peM1XcyLoNF2jkdNGXkp4JbN8ie9QvlJRNbxiBMZol9VI/qoVaf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6630
X-Proofpoint-GUID: aer041Dd6JrJmzU5Nf-tZ4whrJ95nx_w
X-Proofpoint-ORIG-GUID: aer041Dd6JrJmzU5Nf-tZ4whrJ95nx_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 impostorscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110034

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyAoQXJtKSA8
cm9iaEBrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDgsIDIwMjQgNjoxOCBQ
TQ0KPiBUbzogQ2FsYW0sIFJhbW9uIENyaXN0b3BoZXIgPFJhbW9uQ3Jpc3RvcGhlci5DYWxhbUBh
bmFsb2cuY29tPg0KPiBDYzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3Jn
PjsgQ29ub3IgRG9vbGV5DQo+IDxjb25vcitkdEBrZXJuZWwub3JnPjsgTGlhbSBHaXJkd29vZCA8
bGdpcmR3b29kQGdtYWlsLmNvbT47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBN
YXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZHQtYmluZGluZ3M6IHJlZ3VsYXRvcjog
QWRkIGFkaSxsdDg3MjItcmVndWxhdG9yLnlhbWwNCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0K
PiBPbiBGcmksIDA4IE5vdiAyMDI0IDE3OjM1OjQ0ICswODAwLCBSYW1vbiBDcmlzdG9waGVyIE0u
IENhbGFtIHdyb3RlOg0KPiA+IEFkZCBkb2N1bWVudGF0aW9uIGZvciBkZXZpY2UgdHJlZSBiaW5k
aW5ncyBvZiBMVDg3MjIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSYW1vbiBDcmlzdG9waGVy
IE0uIENhbGFtDQo+IDxyYW1vbmNyaXN0b3BoZXIuY2FsYW1AYW5hbG9nLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgLi4uL3JlZ3VsYXRvci9hZGksbHQ4NzIyLXJlZ3VsYXRvci55YW1sICAgICAgIHwgMTc4
ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTc4IGluc2VydGlvbnMo
KykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9yZWd1bGF0b3IvYWRpLGx0ODcyMi1yZWd1bGF0b3IueWFtbA0KPiA+DQo+IA0KPiBN
eSBib3QgZm91bmQgZXJyb3JzIHJ1bm5pbmcgJ21ha2UgZHRfYmluZGluZ19jaGVjaycgb24geW91
ciBwYXRjaDoNCj4gDQo+IHlhbWxsaW50IHdhcm5pbmdzL2Vycm9yczoNCj4gDQo+IGR0c2NoZW1h
L2R0YyB3YXJuaW5ncy9lcnJvcnM6DQo+IEVycm9yOiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcmVndWxhdG9yL2FkaSxsdDg3MjItDQo+IHJlZ3VsYXRvci5leGFtcGxlLmR0czo0
Mi40NC00NSBzeW50YXggZXJyb3INCj4gRkFUQUwgRVJST1I6IFVuYWJsZSB0byBwYXJzZSBpbnB1
dCB0cmVlDQo+IG1ha2VbMl06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5kdGJzOjEyOToNCj4gRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlZ3VsYXRvci9hZGksbHQ4NzIyLQ0KPiBy
ZWd1bGF0b3IuZXhhbXBsZS5kdGJdIEVycm9yIDENCj4gbWFrZVsyXTogKioqIFdhaXRpbmcgZm9y
IHVuZmluaXNoZWQgam9icy4uLi4NCj4gbWFrZVsxXTogKioqIFsvYnVpbGRzL3JvYmhlcnJpbmcv
ZHQtcmV2aWV3LWNpL2xpbnV4L01ha2VmaWxlOjE0NDI6DQo+IGR0X2JpbmRpbmdfY2hlY2tdIEVy
cm9yIDINCj4gbWFrZTogKioqIFtNYWtlZmlsZToyMjQ6IF9fc3ViLW1ha2VdIEVycm9yIDINCj4g
DQo+IGRvYyByZWZlcmVuY2UgZXJyb3JzIChtYWtlIHJlZmNoZWNrZG9jcyk6DQo+IA0KPiBTZWUN
Cj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5v
cmcvcHJvamVjdC9kZXZpY2V0cg0KPiBlZS1iaW5kaW5ncy9wYXRjaC8yMDI0MTEwODA5MzU0NC45
NDkyLTMtDQo+IHJhbW9uY3Jpc3RvcGhlci5jYWxhbUBhbmFsb2cuY29tX187ISFBM05pOENTMHky
WSFfS1U4dDJCRDVQX3Q3V2Z4WQ0KPiBqV3hPVUhuQUc3Yk81WG9RT0ExZ2JVQk1PYmZXTUxPOVNN
Nk5aVUN5VGdiU3hjeG1DOTNyWXJUcw0KPiA1T21idTBsdnliU2JBJA0KPiANCj4gVGhlIGJhc2Ug
Zm9yIHRoZSBzZXJpZXMgaXMgZ2VuZXJhbGx5IHRoZSBsYXRlc3QgcmMxLiBBIGRpZmZlcmVudCBk
ZXBlbmRlbmN5DQo+IHNob3VsZCBiZSBub3RlZCBpbiAqdGhpcyogcGF0Y2guDQo+IA0KPiBJZiB5
b3UgYWxyZWFkeSByYW4gJ21ha2UgZHRfYmluZGluZ19jaGVjaycgYW5kIGRpZG4ndCBzZWUgdGhl
IGFib3ZlDQo+IGVycm9yKHMpLCB0aGVuIG1ha2Ugc3VyZSAneWFtbGxpbnQnIGlzIGluc3RhbGxl
ZCBhbmQgZHQtc2NoZW1hIGlzIHVwIHRvDQo+IGRhdGU6DQo+IA0KPiBwaXAzIGluc3RhbGwgZHRz
Y2hlbWEgLS11cGdyYWRlDQo+IA0KPiBQbGVhc2UgY2hlY2sgYW5kIHJlLXN1Ym1pdCBhZnRlciBy
dW5uaW5nIHRoZSBhYm92ZSBjb21tYW5kIHlvdXJzZWxmLiBOb3RlDQo+IHRoYXQgRFRfU0NIRU1B
X0ZJTEVTIGNhbiBiZSBzZXQgdG8geW91ciBzY2hlbWEgZmlsZSB0byBzcGVlZCB1cCBjaGVja2lu
Zw0KPiB5b3VyIHNjaGVtYS4gSG93ZXZlciwgaXQgbXVzdCBiZSB1bnNldCB0byB0ZXN0IGFsbCBl
eGFtcGxlcyB3aXRoIHlvdXINCj4gc2NoZW1hLg0KDQpJJ3ZlIGNoZWNrZWQgYW5kIGNvcnJlY3Rl
ZCB0aGUgZXJyb3JzIHJlcG9ydGVkIGJ5ICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snLg0KVGhlIGVy
cm9yIHdhcyBjYXVzZWQgYnkgdGhlIG1pc3NpbmcgcGFyZW50aGVzaXMgb24gdGhlIG5lZ2F0aXZl
IHZhbHVlIG9mIHRoZQ0KJ3JlZ3VsYXRvci1taW4tbWljcm92b2x0JyBwcm9wZXJ0eS4gIEkndmUg
cmVydW4gdGhlIGNvbW1hbmQgd2l0aCB0aGUgZml4IGFuZA0Kbm8gbG9uZ2VyIHNlZSB0aGUgZXJy
b3IuICBXaWxsIHJlc3VibWl0IHRoZSBwYXRjaCBzb29uLg0KDQpUaGFua3MsDQpSYW1vbg0K

