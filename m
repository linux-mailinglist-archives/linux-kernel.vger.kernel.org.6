Return-Path: <linux-kernel+bounces-237005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E42F91E9BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B1D282238
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CE9171641;
	Mon,  1 Jul 2024 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fkUE1KIS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MosawOrF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86818635
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866471; cv=fail; b=q6xKfsBcLtMtwsK+9k5eSNJHLrY4v6LcPfbjINGtdN02GB2ogWmr2STBfjmNj8xq5ptlrLG35Iq7o7DQwGq8Mox87Y8z4dcJyU3YGm4T6zuL7EkgaeV8xagb3/MUDPedHxXWD1PxVNd4zOidN1DX8W9G0Eunl+DIfMRRCgWWM1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866471; c=relaxed/simple;
	bh=rrb1gt0QCR0MosPyjwGMQAZ/VAxuBq9tCUerRrdrHHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oq13SSNAIpDH423xY5XTA9fLNnRDAKrjc9M5k/2ofWBLXBHqdzeBJIRfg5woN8uFuhuBGnq9W7Wl/uk+qtRTlYUfTYXMeAUDg9Sh51NqKOlUDmvOHt3th0SdgFCDdahjKbOFGD0Fap4ueM8wpcL3VR/UZEHnEqLL0/nvm3g/8h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fkUE1KIS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MosawOrF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461J9LMa016045;
	Mon, 1 Jul 2024 20:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=CNxuIQt7MJEG23B6h4Zgcd3QAGi5lJSRufOQXm3V2vQ=; b=
	fkUE1KISvgwhmTcZ4cSK3qu30VnCcDT3VKQ0gh+rft2LGFzsrkSVC8Oz/1G4aS2B
	sX0uNhBLGgbHzn7DOK7s30tGtEG/jTQ0xFNmLlKjp5tUV/qyh8WAp5C980HEt55K
	9WknZCR/2bgPlKOWVcMqI+W57QGWB+EDvlQifq38Jc7tFGMg0NrF2k0rYZXveSWj
	ZCzqe+3dtPw+bC0rWs/X2ncbRvGSjvtgP2aFwz2TnKM3HRSrDs1obcwFt22RQ0JD
	Ko2QEUDWAUA+IOynh6O7735rFTqBN00ysuWkR4dcwtYbjO04sLvF85BsKU12HQD/
	lLQjqIOYhFHeRoVc+KJrOw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296avjkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 20:40:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 461JUhWY019066;
	Mon, 1 Jul 2024 20:40:36 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qdacj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 20:40:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhXOwB1jn1zvXLoYV59KRdCltQF5+l4IpRk4k3djvWeQEkSrR3zNfIRtQ4l12TST6RUrnuHdNC1vTa3mBgqGE0mG2V2eSzq0oQ8AnFuT5S1Um6PZiYuwzqlU9NVqrrl9/UAOyF4kZCOh0+5foFRUYBeOY5zb5GSyw2EnnlvEgut/K4PCG1ZSj9H26N8YxleQMcd+EdADkevDZ6gZOvX5HL2VYwfbwVe4Q/7TSrlO+44opBSxBfiXWjX2oaoWpCk6Kmh2lKKdfXJD93LuTZVM8tHmMGrJfiasjg5MMLn42HnK4FRddz/dLga0En/BTwzZqh7Rselj+Q8gOJ+f4E2nUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNxuIQt7MJEG23B6h4Zgcd3QAGi5lJSRufOQXm3V2vQ=;
 b=JotAqY3pWjFzf7jAwvQc4bs05YXH98yhKBRoWDPtoxXU7fXzSVLZwYbwhtilG499vEJtRk3BBpIEPJuIEZ4dwX9DM5qxzEC3hLA+uVcJ64LKDYgIlFpe6fUnguepgma5KQw72XZ5SSPmEbTm96IV6F2ATZhbfC+7ZmN8ZNMqWybtvYxyF/2+9YvQgEyySwOOEset5M7CxMJSxJBPz9C1Gx6zVV/eKVywVLM+NGqXrhpCeOybK+db3QwQSFoI4THHgGicZW+Fsk6tdpe/7Deks0pX1Yb5HNwMXit8OMa4mS7o8vJZGNMh3SUUdrccUnrE3o0KJqnKkU1udy+Xz2URqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNxuIQt7MJEG23B6h4Zgcd3QAGi5lJSRufOQXm3V2vQ=;
 b=MosawOrF8zdjScBbXOcTTNY0UxEt3HAK8IXlaZ45oCa0YNeAvaBuRL2YOM8nOKUbqdfQvvsNE3CZ7Xg6YKXi1SvRF2q9Jm4LU03XKoMJTyMhVh99IEWaHdORywwsEL4iFzVl84YsJl44YAeEuCUBcWi0QASjVj1p/E9X/Fi0mJE=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by LV3PR10MB8059.namprd10.prod.outlook.com (2603:10b6:408:290::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Mon, 1 Jul
 2024 20:40:34 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%3]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 20:40:34 +0000
Message-ID: <4c9d4c00-1811-4100-89e7-5064e8bdc0ab@oracle.com>
Date: Mon, 1 Jul 2024 15:40:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: fs/jfs: Reproduction of kernel oops bug in JFS
To: Divyaank Tiwari <dtiwari@cs.stonybrook.edu>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        brauner@kernel.org, jack@suse.cz, axboe@kernel.dk,
        jinpu.wang@ionos.com, dchinner@redhat.com, lizhi.xu@windriver.com,
        johannes.thumshirn@wdc.com
Cc: Yifei Liu <yifeliu@cs.stonybrook.edu>, Erez Zadok
 <ezk@cs.stonybrook.edu>,
        Scott Smolka <sas@cs.stonybrook.edu>,
        Geoff Kuenning <geoff@cs.hmc.edu>
References: <CALXmgOG=E7Yk+j7KY5w_OVMFQ5S69XX+0BkW_V0kZngCTkj54g@mail.gmail.com>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Language: en-US
In-Reply-To: <CALXmgOG=E7Yk+j7KY5w_OVMFQ5S69XX+0BkW_V0kZngCTkj54g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:610:33::32) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|LV3PR10MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 194fb9d7-c835-4918-2e22-08dc9a0e0e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bFBMMStmbjdmdFE4WjNKb21KTjFYemVUTmJOdWlxUzZia2ZJRUFUSVdpSHF6?=
 =?utf-8?B?Zi8xUWIvYmZtOHFFYi84a0xoRDlROHFjanVMcWlFa2hvakJ2ZlFUTDNYUVBZ?=
 =?utf-8?B?L2V2OEdoQmFhSE53bktBbTlKWU52K0Q3UjYxMHZhaG8xMlRmOThvN1V6UnBZ?=
 =?utf-8?B?Wm4ycDVzcjFtWHlFeEZaaWIzUXpkRDlZKzFFc0FXeE1CeHA5aFNQS1FBZWs1?=
 =?utf-8?B?WXFVb21CbldXU3Bjc2ZTTjBoUXp3NEUrWGh3ci9DSEFlSlpmc3d1ZS8vQjRX?=
 =?utf-8?B?QS9mQmFPNVdDWEppL1lWL0JVWUZCejlRakVSSWladmxtNTYrOFBNWDExRHVH?=
 =?utf-8?B?WXJMV0d5cFZuWUVPZnJTbFEybmdvcTZXT1pqTGZaZkxyc0M2WWl2d2Erckdl?=
 =?utf-8?B?L0lhMExqSE5rN1ZSNXdhOUM5Rmk1cmpKNEVlVk9lMC9uSm1JN29HOUtOazRH?=
 =?utf-8?B?WEIzcmt0YWFiQnppY1ZsUnZyVUtmaTQxQ2ZKMmNjRXZFR3lScUU4RXVyT2Qz?=
 =?utf-8?B?SGo3bEVNc284NFk1ZDdwOXphNGl1cUtVaVJ1RndoeVRrclY3Tmk0cm1ra1Zi?=
 =?utf-8?B?SkdDUFZ3M3V0RGdjQldKTVlmYUl1Z1I5SGNLaXJyeGYyUGZsa2RuOFhBWStJ?=
 =?utf-8?B?dTBrYUFnbHNhNmMvVzk0eXNHU2Fvb2szaWlLVUFTekxLRDBIWG9BQlpMQlZI?=
 =?utf-8?B?RElDaHJ4VmJaM08rQmdwNmh2Tk4yQlVyZ2luYjEwRVlIeWFiRHJGWEtWazFv?=
 =?utf-8?B?Q3I5bWFaK1Z0UUxVdHFBN2hNTmxzU1R2STEzZFpMS3RxVVZtMm9CS2NCZEEw?=
 =?utf-8?B?YVFWcjlOcFd5R1FwTkRXakx3aC9EOTB1bmo2NWYxb1pwQnh0Sk5TdlhQRWVX?=
 =?utf-8?B?SHlsNER5Q3dtRmY0ZEx6ejRSNHdVZWozeUlIeHFuNlg2SEtsazh0dG9QaFB6?=
 =?utf-8?B?V21NYlJEWnZKWjk5Q1BsSm1LQzk5MXRTS0Q3dE1yUS8wc1EvRzdyTURPa2xV?=
 =?utf-8?B?cDdXU1lwTC93RXRtMDhiTDJlVmlVb2pnekg0cjZoRm9yS2ZVbTV6VlRLR2Vo?=
 =?utf-8?B?R2ZldGVDMjJyQ1pyb0dWQ3RRc1ByV3BZTTNFMG96Mm9vZGRPbmt2M2hiWmgv?=
 =?utf-8?B?U2tza3R4Rm02ZDV6SnBSVkJoMGZOanhyT0Jib0VER1MwZ2xYb1VCVklVbWZs?=
 =?utf-8?B?OHdXSTZ5eHBnS3NrbnpPbFdpTVpQWG5vYUZNWWl4NHJOR0ZIYllkWFVUdTBo?=
 =?utf-8?B?UzMxV3RVOUVWZ1ZPUlFXdmxWQmV2MTJJWWkwQWN6WXVWd3BVSjREeDRGN0pI?=
 =?utf-8?B?a0hNdWl6RXdzUnZCQytRWnRhQ0V5T05FQm5DVmZ0cDgwWnNSRDVvTS9YNzAr?=
 =?utf-8?B?eklXQTVaTkhKMHdYcjFiWkJSOC9sMk9GV2Q5dUJHbzdiMzZvdkxjMS9RcmZs?=
 =?utf-8?B?RFlMYjRXaHdDUVAzaldCMnJVRUJtSG9XQWpRTkN2Q0o4dWpiVFcwL3UrTXJN?=
 =?utf-8?B?OXYranFaT01EekxXanZlV3VuODBJNkowVDc2NTlLOUhTaWRCOUEvK0U0Q0N1?=
 =?utf-8?B?Z3Bic1hkUHo4bkxDeCtHVUZsMHBYN2VLKzh1OGV0UGUzcGV2ejlWclpJMngx?=
 =?utf-8?B?bVVXMmRXb24rVm9lYWNQdk1qQTErVzRod1JsbEJQTHp5ejdxM1c1QmRqRGIv?=
 =?utf-8?B?NEUyRU9NYjlscjhONEpXZDA2VjE3L2pWZEw4YUxYUnZWUGF4RXVoTkhNNmw4?=
 =?utf-8?B?aUljTVBWVDllbzhmYUpTT2JRMVl1NFJScmVaSStnMkZpdWx4V0hsK05INzFR?=
 =?utf-8?Q?laoZzIKYFxo0p6nlr8Kpj2JFVNr8MV0cMCMt4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TS9XSENDNzV4ZTlOSXBxc2hPK3Y4Z1NDNlZycDA1ZHlad2NZSUtnTGhCMXBM?=
 =?utf-8?B?c0RxY1Z0dWNoRWJqOWp5a05laFM5aUFpTTJyQ3p1V21Xc0d6Z1ZYT3RBd1NY?=
 =?utf-8?B?ZG9JRTZxQ1oya3cybnl5TzhYOHVNcjNRK3VMUTBib1NLMVdMZHZlLy8zcUlR?=
 =?utf-8?B?ZHlZQnRuZjhOcG5laE8wUU53WVNVQWtHODJjbmVYSEJrOWw2YWJvNHYrajNl?=
 =?utf-8?B?eDl0dmd1L3pzVlZ2OVJybndwSkdncDM2NnF1ay8zaStzTlZYY2g0aW9mR1JR?=
 =?utf-8?B?YW40Z1dzR1R6dkw3VU5aeXJRc3hsK1dESWlPckM5QUtCem9WMjlZZTBhc3pm?=
 =?utf-8?B?WWpZWDNITWphSVA4T2JwZG5qNkhaOThnM3NEVllzTGpNMnRETmRWdFNpUmF3?=
 =?utf-8?B?TnFxMmJGZHo3U1pCYjdZdktENjZYVXVvSG1rNzhXWGVXUmNVbG1qNzhGWXhO?=
 =?utf-8?B?UlhXOW5WU2pUVmxud1R3VmFoT09oK0hsOTFRMklUekJXNVpxMmljcnpqTHZO?=
 =?utf-8?B?Rnp0T1c2OU94eTlNOU1rWXJkcjlEbnozbjNXdnM0VUlqakdGc2NwRkVFR0Vz?=
 =?utf-8?B?Unp6N0YrZXNzVE5Sa2s1RVpkQWZDTzl4a3RKb0xYbEdDbDd1N203TnJoaW1n?=
 =?utf-8?B?OXJqQjJsNDBvV3dsUm5odGJQMkJwMEJaaDZDK1dsaGZPUnRKczZ6ODI5YWhu?=
 =?utf-8?B?WlhBUzB4S2tYTkhqQmYrd3JKbW5mNTBmSU02VzBGaThwVnpjcFU1V003Sk9G?=
 =?utf-8?B?eFVTM1VDZVcvUHF6bnZtYjVQWTViOFVCaCtlRFh2OUdheXZNdnA2TU1IRkNI?=
 =?utf-8?B?ZTE5YW5zKzl0YlBBNXR4THBZcXJjQk4velRmVmZqcUwrZXo2bDJjTkZTNWdN?=
 =?utf-8?B?UWF1RzhLQ2I3bk15aFh6ZHdNSERXeExlUVpRQS9jdTI2TWVnaEsxQTVsdCtK?=
 =?utf-8?B?bkJJc1E2SVpnMGZsSDhKditQWENZTnkyZXIxb0N5c01BSkRHbEU1eUtBTElo?=
 =?utf-8?B?L1BFcGRqa0c2NTV5amVuWVJvaGh0S0l3aldwWklhaXJyRWlBaFp4bm9rTVZT?=
 =?utf-8?B?Yll0R2pFb2R2cmxBa1dwYjhFYWl0b1U3TWc5OFNKcUZ2dUdzYXc0VFVML3cv?=
 =?utf-8?B?VzZUeUFrdE1OQXdlOEJTK2ROWFJ4dnk4dlpwTWdhUi9uZ29JRkU2RUd3VWpl?=
 =?utf-8?B?Q1RXREUxOUdMdGNkNTNIeW9VK2dWbnYzVTJLR3NJRzlxOUVaNWdlUFowbXRr?=
 =?utf-8?B?ckxqSVEreEZCTUJiVnpubzRraXUxU2laZ1dhTlRRUUlQM0lqRHFGMXU0cUNu?=
 =?utf-8?B?SzhiQW5XWWFocFlLOXZJUSt3QkZpZS92ajNwbE9zQVhPVDF3Q0NFVUsxZzlM?=
 =?utf-8?B?OTMwa0Zrd3BpeURHV0NoU3pya3VabGZ5dVRkbW1jT05pdHpZeVFSbElDMlJC?=
 =?utf-8?B?UU53R3FYVzJvTTZMay9COTVpNWRxY2cva2lvWkNQWlJSR2gxQzVKOGtoVzg4?=
 =?utf-8?B?TlhYYUJ0MHVwMGZqQ0FJVEtFalpjQzl1dnJnbDNrajlEdk4wMGdtVHFYTys1?=
 =?utf-8?B?Sm5OZVRqVnZPMU1CYWIxS1F6eWwxQXcvanRRQ3dTaXVBbDhEaHJqVVhCaEl1?=
 =?utf-8?B?a2FLTE1vczBGRktBUVNHbmhMNWJ3UGZUKytuK09ZU2h1cHh2WGl6TXlOclhp?=
 =?utf-8?B?T1NQZ3gwcE42REx2WW05STByVWJ3VENwR1FudGpLSFVUSXE0end4b24zZTRz?=
 =?utf-8?B?ZTNTb2xhUm56Zi9zV09BOHFiL0ttb0I2YlFVZnRMU1RwMjAyVEVzTDdkQ0N6?=
 =?utf-8?B?NUpaTlFFSjBBNFdiYVd5UlNIQzlmVXp5RGRYaXpvNld2UmIvUUlad2UzTUUw?=
 =?utf-8?B?VEZRZldpUmFjNnNUa1VwVXZWaGs3VEh5VFF0eXU0L1pzek4vRG5oSWs4VUlY?=
 =?utf-8?B?OTE1M0VFTk5sdG1ZS25wQUFWb3pETlVhOEE2VlJ6ZFVZQ2VDeXcxWDByY2tm?=
 =?utf-8?B?anlveUxUODhvbFBUSFVONVAyY1A1TGpOR0RVTnNILzVZN0JQTjB3MEJ4NWxj?=
 =?utf-8?B?TGlHcDMyVFlUT1lTdDhOeXNOUXAvc0xNcTBDRnlBUXNQQ2EwRkhHTUJGUENG?=
 =?utf-8?B?ejVHOFArR1JlSWhUVVAvdDZ1SldGSmNORmlRUHBRM2twS1hlZzh6Z2Vhd1VD?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/atbpzA6p1U8oigWmb3HZsN7DFN7A1B0QUwRuzHnfJ5iD+3CX0hNV1qsFnU0yqK1ZtjD0KqQ7Wm0X7PdrqNj6C+n7h48DO7/ZemX8skEksH/cD8fywUCByRHCifbhdwL9Gm0yoaAmcKTRQarxnv+A95c/0kqq+gs2KSHrSgifeUDI+/81mOUxvyMRAiM37Q/4j9TpxuH/FDcuJ8bkq8bimssnXXgULYrz1ar5MYzfoAkPZn50fGsHl4qRqvwIFi2J6j4j6DHchMAhwtbuk76asJsm0QIG8mr3Pd4dIJCuVHHVPkoJVZgnuSophxM7h6kzYkCF9AHWQ0887O6HikDNIIrOF6ctm63mRjcHHTDCoUTK0Oi4s+3FxlvWW73JRrQ9EsrnGhtHytbepKrm8/gst0Am4gmgAY5tYvoSNH92NGqqXdWTB6tOh8THjQQfJ2w9pMilQS9HJF6bQvckv3IcBjTBDdDo3VJyEuCSM2t4nPdCr6tZl84ksd++074jjuKs9u+CbfJwwUpldUtTndjCsF4kNQhzRTkWcM9OWAAGHxow7ef2UEvIHjJ9V8E8do+6Tz+NbuB+AWdc0bkzvwew8RTjpIQDE4tEBOW6z3ZD/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194fb9d7-c835-4918-2e22-08dc9a0e0e3b
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 20:40:34.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/t0xL5r7XX3LOfjJkezojKgnnnP5Bj4U21c/RSh/q3ysf3ZeMIdqxG9DLNuI0Kj0/cStib0guqdcf6uYY0ungsO5jksFTxve86D1z9V8hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8059
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_20,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407010152
X-Proofpoint-GUID: -eXWX_JnkaPEspFdfRvGjlU7xntspTCB
X-Proofpoint-ORIG-GUID: -eXWX_JnkaPEspFdfRvGjlU7xntspTCB

I appreciate the time and effort you've put into this so far.

Though I'm the only maintainer of jfs, I still don't have a lot of time 
right now to put into investigating this. I will keep track of the issue 
and try to find the time to look into it, but I can't promise how soon 
that will be.

Again, thanks! I do appreciate the effort.

Shaggy

On 7/1/24 2:54PM, Divyaank Tiwari wrote:
> On 10th April, 2024 we submitted a patch to the JFS mailing list for
> the lmLogOpen() function in the jfs_logmgr.c file. The patch moved a
> NULL pointer dereference of a log pointer in the txEnd() function in
> jfs_txnmgr.c, from being before a mutex_unlock to after the
> mutex_unlock, effectively postponing a kernel oops. This was confirmed
> by us through our file system Model Checking tool, Metis (Link:
> https://github.com/sbu-fsl/Metis). (Reference to our older patch:
> https://lkml.org/lkml/2024/4/10/1396.)
> 
> In response to that patch, Dave Kleikamp informed us that while the
> above patch looked completely safe, it was unclear whether it fixed
> anything, as releasing the lock shouldn't leave any references to the
> sbi->log data structure. (We noted that all other instances of kfree
> of that log pointer happened before the mutex unlock; hence we felt
> our patch was at least partially “correct.”) He clarified that calling
> kfree() is unrelated to the value of sbi->log (which would be the
> cause of the NULL dereference issue). Lastly, the patch might only
> alter the timing by holding the lock longer, but since nothing should
> reference the log anymore, holding the lock while calling kfree() may
> not prevent a use-after-free issue. Regarding Dave's previous inquiry
> about our experiments, we confirmed that we are not using an external
> journal for JFS, nor does any file system share a journal.
> 
> Although we have still not been able to pinpoint the exact source of
> the aforementioned bug, we have developed a program that can reproduce
> it with high probability on the latest release of Linux Kernel
> (v6.9.4). This program, which we call a  Replayer, is open-sourced,
> and we have extensively documented its usage. (Link to the repository:
> https://github.com/sbu-fsl/Metis-Replayer/tree/main.)
> 
> To briefly summarize our Replayer: from an execution of Metis that
> caused a kernel oops in JFS, we first extracted two logs—one
> containing a sequence of all operations up to that point and the other
> listing the relative paths of the initial files and directories in the
> mounted file system. We wrote a simple script, setup_jfs.sh, to create
> a JFS file system on a 16 MiB ramdisk. (A ramdisk has a much faster
> I/O rate than a regular device.)  Our Replayer (replay.c), implemented
> in about 700 lines of C code, pre-populates the files and directories
> and then executes each operation from the sequence log
> (jfs_op_sequence.log) line by line.
> 
> We suspect the bug is a race of sorts.  Specifically, the Replayer
> always unmounts and remounts JFS in between EACH file system operation
> (present in the sequence file generated by Metis, while model checking
> a file system).    We are unable to reproduce this bug without the
> pair of unmount+mount in between each file system operation.  Hence
> our suspicion is that the bug is a race between (1) some file system
> operation adding a record to the log, while (2) the file system is
> being unmounted and the txn log is being shut-down.
> 
> Due to the bug's nondeterministic nature, we have found that running
> all operations (823,178 in total) from the log file in a loop for 500
> iterations, results in a high probability of reproducing the bug
> within a day. In our experiments, we encountered the bug after about
> 60-300 iterations. Correspondingly, the time taken to trigger the bug
> ranged from about 9 to 75 hours (on our VM). For reference, our
> repository includes a dmesg trace (dmesg_jfs_kernel_oops_trace.txt,
> reproduced below) captured when the kernel crash was triggered during
> one of our experiments using our replayer.
> 
> Jun 22 03:56:08 hostname kernel: BUG: kernel NULL pointer dereference,
> address: 00000000000000a4
> Jun 22 03:56:08 hostname kernel: #PF: supervisor write access in kernel mode
> Jun 22 03:56:08 hostname kernel: #PF: error_code(0x0002) - not-present page
> Jun 22 03:56:08 hostname kernel: PGD 0 P4D 0
> Jun 22 03:56:08 hostname kernel: Oops: 0002 [#1] PREEMPT SMP NOPTI
> Jun 22 03:56:08 hostname kernel: CPU: 3 PID: 582 Comm: jfsCommit Not
> tainted 6.9.4 #1
> Jun 22 03:56:08 hostname kernel: Hardware name: VMware, Inc. VMware
> Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00
> 11/12/2020
> Jun 22 03:56:08 hostname kernel: RIP: 0010:txEnd+0x8d/0x1e0 [jfs]
> Jun 22 03:56:08 hostname kernel: Code: 03 01 0f 85 88 00 00 00 83 3d
> ae af 00 00 03 7f 6a 66 83 7b 28 00 0f 85 3b 01 00 00 8b 05 bb 16 01
> 00 66 89 43 28 41 0f b7 c5 <41> 83 ac 24 a4 00 00 00 01 89 05 a4 16 01
> 00 75 14 f0 41 80 64 24
> Jun 22 03:56:08 hostname kernel: RSP: 0018:ffffaf9300adbe50 EFLAGS: 00010246
> Jun 22 03:56:08 hostname kernel: RAX: 0000000000000008 RBX:
> ffffaf9301213500 RCX: 0000000000000000
> Jun 22 03:56:08 hostname kernel: RDX: 0000000000000000 RSI:
> 0000000000000246 RDI: ffffaf9301213530
> Jun 22 03:56:08 hostname kernel: RBP: ffffaf9300adbe68 R08:
> 0000000000000000 R09: ffff94c3ffba3640
> Jun 22 03:56:08 hostname kernel: R10: 0000000000000001 R11:
> 0000000000000000 R12: 0000000000000000
> Jun 22 03:56:08 hostname kernel: R13: 0000000000000008 R14:
> ffff9485d28cbcf0 R15: ffffaf9301213500
> Jun 22 03:56:08 hostname kernel: FS:  0000000000000000(0000)
> GS:ffff94c3ffb80000(0000) knlGS:0000000000000000
> Jun 22 03:56:08 hostname kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Jun 22 03:56:08 hostname kernel: CR2: 00000000000000a4 CR3:
> 00000001d7f1c004 CR4: 0000000000770ef0
> Jun 22 03:56:08 hostname kernel: PKRU: 55555554
> Jun 22 03:56:08 hostname kernel: Call Trace:
> Jun 22 03:56:08 hostname kernel:  <TASK>
> Jun 22 03:56:08 hostname kernel:  ? show_regs+0x6d/0x80
> Jun 22 03:56:08 hostname kernel:  ? __die+0x29/0x70
> Jun 22 03:56:08 hostname kernel:  ? page_fault_oops+0x151/0x520
> Jun 22 03:56:08 hostname kernel:  ? do_user_addr_fault+0x325/0x6b0
> Jun 22 03:56:08 hostname kernel:  ? exc_page_fault+0x7c/0x190
> Jun 22 03:56:08 hostname kernel:  ? asm_exc_page_fault+0x2b/0x30
> Jun 22 03:56:08 hostname kernel:  ? txEnd+0x8d/0x1e0 [jfs]
> Jun 22 03:56:08 hostname kernel:  jfs_lazycommit+0x292/0x380 [jfs]
> Jun 22 03:56:08 hostname kernel:  ? __pfx_default_wake_function+0x10/0x10
> Jun 22 03:56:08 hostname kernel:  ? __pfx_jfs_lazycommit+0x10/0x10 [jfs]
> Jun 22 03:56:08 hostname kernel:  kthread+0xf5/0x130
> Jun 22 03:56:08 hostname kernel:  ? __pfx_kthread+0x10/0x10
> Jun 22 03:56:08 hostname kernel:  ret_from_fork+0x3d/0x60
> Jun 22 03:56:08 hostname kernel:  ? __pfx_kthread+0x10/0x10
> Jun 22 03:56:08 hostname kernel:  ret_from_fork_asm+0x1a/0x30
> Jun 22 03:56:08 hostname kernel:  </TASK>
> Jun 22 03:56:08 hostname kernel: Modules linked in: tls brd
> vsock_loopback vmw_vsock_virtio_transport_common intel_rapl_msr
> intel_rapl_common vmw_vsock_vmci_transport vsock sunrpc
> intel_uncore_frequency_common binfmt_misc nfit rapl vmw_balloon joydev
> input_leds serio_raw vmw_vmci mac_hid sch_fq_codel dm_multipath
> scsi_dh_rdac scsi_dh_emc jfs scsi_dh_alua nls_ucs2_utils msr
> efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic raid10
> raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> raid6_pq libcrc32c raid1 raid0 vmwgfx drm_ttm_helper ttm
> drm_kms_helper crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
> sha512_ssse3 sha256_ssse3 drm sha1_ssse3 ahci mptspi psmouse mptscsih
> mptbase vmxnet3 i2c_piix4 libahci scsi_transport_spi pata_acpi
> aesni_intel crypto_simd cryptd [last unloaded: brd]
> Jun 22 03:56:08 hostname kernel: CR2: 00000000000000a4
> Jun 22 03:56:08 hostname kernel: ---[ end trace 0000000000000000 ]---
> Jun 22 03:56:08 hostname kernel: RIP: 0010:txEnd+0x8d/0x1e0 [jfs]
> Jun 22 03:56:08 hostname kernel: Code: 03 01 0f 85 88 00 00 00 83 3d
> ae af 00 00 03 7f 6a 66 83 7b 28 00 0f 85 3b 01 00 00 8b 05 bb 16 01
> 00 66 89 43 28 41 0f b7 c5 <41> 83 ac 24 a4 00 00 00 01 89 05 a4 16 01
> 00 75 14 f0 41 80 64 24
> Jun 22 03:56:08 hostname kernel: RSP: 0018:ffffaf9300adbe50 EFLAGS: 00010246
> Jun 22 03:56:08 hostname kernel: RAX: 0000000000000008 RBX:
> ffffaf9301213500 RCX: 0000000000000000
> Jun 22 03:56:08 hostname kernel: RDX: 0000000000000000 RSI:
> 0000000000000246 RDI: ffffaf9301213530
> Jun 22 03:56:08 hostname kernel: RBP: ffffaf9300adbe68 R08:
> 0000000000000000 R09: ffff94c3ffba3640
> Jun 22 03:56:08 hostname kernel: R10: 0000000000000001 R11:
> 0000000000000000 R12: 0000000000000000
> Jun 22 03:56:08 hostname kernel: R13: 0000000000000008 R14:
> ffff9485d28cbcf0 R15: ffffaf9301213500
> Jun 22 03:56:08 hostname kernel: FS:  0000000000000000(0000)
> GS:ffff94c3ffb80000(0000) knlGS:0000000000000000
> Jun 22 03:56:08 hostname kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Jun 22 03:56:08 hostname kernel: CR2: 00000000000000a4 CR3:
> 00000001d7f1c004 CR4: 0000000000770ef0
> Jun 22 03:56:08 hostname kernel: PKRU: 55555554
> Jun 22 03:56:08 hostname kernel: note: jfsCommit[582] exited with irqs disabled
> Jun 22 03:56:08 hostname kernel: note: jfsCommit[582] exited with
> preempt_count 1
> Jun 22 03:56:32 hostname kernel: watchdog: BUG: soft lockup - CPU#6
> stuck for 26s! [replay:257577]
> 
> Further details about setting up the environment and conducting the
> experiment are available in our repository’s README. We hope that our
> replayer will assist the JFS maintainers in debugging and resolving
> this kernel oops bug.
> 
> Note: All of our experiments were performed on Linux kernels v6.6.1 and v6.9.4
> 
> Signed-off-by: Divyaank Tiwari <dtiwari@cs.stonybrook.edu>
> Signed-off-by: Yifei Liu <yifeliu@cs.stonybrook.edu>
> Signed-off-by: Erez Zadok <ezk@cs.stonybrook.edu>
> Signed-off-by: Scott Smolka <sas@cs.stonybrook.edu>
> Signed-off-by: Geoff Kuenning <geoff@cs.hmc.edu>

