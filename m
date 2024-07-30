Return-Path: <linux-kernel+bounces-268330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 446EB94233E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A971F252AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA57191F81;
	Tue, 30 Jul 2024 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kJQw6D7X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gA5Q4NTg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE718A6CE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380851; cv=fail; b=Uvory4GcnoTMAZ7CBCEuKAXkbrVZDBwYcM5Ephddwndg2qeXtvGR9v3dPbvUlUEEunkKPNwszvFqxMgSmsUyFEn/oQFaVlh+6w+Wk73rW8eK5BfVgwrE7eno5GSWpkpskTxN54I6OuIk0bwGl5vQkmFt8N1G/pm55SVVbYuH9Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380851; c=relaxed/simple;
	bh=5jPEqDn0QJwFJPIBEAO6muH3Lj0+N8kdFEFSPW9WVtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hdMgLqq19ScV3C3u5YudIAluNSer7yOa3cE7ZTqznvHvWH1MytIWdLtbN0NbJ5QTubKLa0wEi+8hr+ozH4I1FKR4WNocW6i+IusRSAkSw4dD09kwqo6OhQLHAIkm2D8WdzqJlr6ooN2vdurQ3+2fjlGKJSkxw8X17ziP0EYZhXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kJQw6D7X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gA5Q4NTg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UFtXKh012452;
	Tue, 30 Jul 2024 23:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=5jPEqDn0QJwFJPIBEAO6muH3Lj0+N8kdFEFSPW9WV
	tI=; b=kJQw6D7Xxn9JVeCgjsA5TUZ6bPQ2TrwVUIDNktYbyaRFVRjBdahMg93Vd
	mGXVpdRI1xptkv2A5P+O26vKr6cvWdS1EffOylHyW0SIHaknKkVPPIdCpigY0wwf
	9/ucHsIhhOTSRCc5D1k/83rGWyzxzcXs4ah04gIfAFmkB+cOPktypnrCn7g3R9b+
	QdAjA1mqABDzqzUXmyXu6KVK8Wn+bI//Dgc88IpsmUDH47rnGMJD42oiqzhL6gMi
	Vjgg6p1eKOliDMvOeCSLRTzlXgQDWQVQ3ZpFE4eqa8rpmAjNbkE10AgjBbSaMaPx
	hPVTWPNzEpt3iF4ZNV3bDJpeYMWLQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqacp61u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 23:06:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46UMcQho038670;
	Tue, 30 Jul 2024 23:06:54 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40pm83wwbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 23:06:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7MKaykM56Dd7t9l+oaFL8eL3rfZshR6u+AmHOMNAUpzk0MjSs3YzB5jR7CEuprxYUAkYNj8lSlzlX9KXEpcTySf6x7QN5dmz1wT7bDUVeBW/3iW33pTHLu0jsyKjiW0/acJiHZXxAINkTWPp2uga1uiAEkMNwMpW+gyw660oYa8usMNbw9ZTyNCmnae8Jf/bdV+eAoTIvWSMhf1GUjsBp6BLSbGdLLW7AY5SqpNkjihWGqzHisIqen152jtLOGJA2RskA3hhdiXa0udBtgSHtCGhZnPG5tFcraneW5F3l4jl6Hu00NZWBiSLMafE9oM7k5PIRZcmsqbs4Owwae/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jPEqDn0QJwFJPIBEAO6muH3Lj0+N8kdFEFSPW9WVtI=;
 b=i4J+SiFVfD4mAgYnHQrYUScj7oDN6fyQcwhIBksjb5nG6Wn5LahVkw8v0Aq4zHeuUW39Q08ywP8e37SyrrQRnmhXSKw/Z4wyg4pOE+aWvCyxazBijbwlUtERrzqGD1tYhp0ePfvlTnfY3EJT+CV5Y1RBhIjLLoibsyM7PuKRrvljUtwT0M2/pAuT168//j7Dy7mnwcWiUPJb+zRKtycFjEoUSeyCI53GkB65WKVBFCZ3iApdqFXB01a7dBwnsEERWJDDA48U1j5dvL4HJnMgsEEmSuxSO3C1gFhHr0MZkRSh4PmGbkINUDe6sSXnomumZQNi3Bh5mWc/zjXmmYGuzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jPEqDn0QJwFJPIBEAO6muH3Lj0+N8kdFEFSPW9WVtI=;
 b=gA5Q4NTgYD1hNBVn+kKefCwQbC4AvjWYlmRCd9rzma3hM0v3ljx/ehw1fLKgH4D82jUme8pn10/XvBqkqn6JpNBNF2niliCW5Tz/qHndsE/dZVsJ0zvmTkNx0EtsrHWL9KuwHehCLNYSeSmNEAI5ESi+W0c07oH83c9YjdyCgs4=
Received: from CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7)
 by PH0PR10MB5580.namprd10.prod.outlook.com (2603:10b6:510:ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 23:06:52 +0000
Received: from CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199]) by CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 23:06:52 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@kernel.org>,
        Keith Lucas <keith.lucas@oracle.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jorge Lucangeli Obes
	<jorgelo@chromium.org>,
        Jeff Xu <jeffxu@google.com>, Kees Cook
	<keescook@chromium.org>,
        =?utf-8?B?U3RlcGhlbiBSw7Z0dGdlcg==?=
	<sroettger@google.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v6 0/5] x86/pkeys: update PKRU to enable pkey 0 before
Thread-Topic: [PATCH v6 0/5] x86/pkeys: update PKRU to enable pkey 0 before
Thread-Index: AQHayNdyz173SuST5UKEbcjLq4kySbH6cRgAgBWnf4A=
Date: Tue, 30 Jul 2024 23:06:51 +0000
Message-ID: <20B4F26C-A5E8-433C-A441-EAAEE8A31658@oracle.com>
References: <20240627211737.323214-1-aruna.ramakrishna@oracle.com>
 <CABi2SkVFpDK_Dugz68Vu4dZ+Jk5bhiEYDuPbNnGu8W9Nbw1m4g@mail.gmail.com>
In-Reply-To:
 <CABi2SkVFpDK_Dugz68Vu4dZ+Jk5bhiEYDuPbNnGu8W9Nbw1m4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6708:EE_|PH0PR10MB5580:EE_
x-ms-office365-filtering-correlation-id: 3357f81c-5233-4678-4307-08dcb0ec4c60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TkRER0p3L1dxUGtaTnpGRCtXbmludG9aSkZYM3BZcWdKbDErUmE1c3Ivd0p3?=
 =?utf-8?B?cjcvQXVCNGdpTDJvUU14Nm9aM0xPSjhGUE5iRFgyNWlQUWZKQ2tQQVVYaVJD?=
 =?utf-8?B?aU9UQ1VQVDVyUjYxRW52bFFIMGJRZlV1UUdBTXNtRWMydnlNbHU1K1FFWlhi?=
 =?utf-8?B?UXg3MnBoY0h2Tjd0VEx4ampHbkpwNXE3NU5ISFkwMnY4bUFLbXdvaml1cHFu?=
 =?utf-8?B?QS9mbEVSZVpnYWhOSUNGTkZBWURVU2NveHRXTUZETWRiT3d1OUoyd1daZ0dy?=
 =?utf-8?B?WWsreUJhSUdveTFyUnFqbzlHNXJqQkJBbEVZQnBaK0tEaUlTK1E1Y0N1eWJC?=
 =?utf-8?B?NnJyTVhuVEZaTGdSd2xvR2NGaDBVdEQ4cUNoVFhTK1plRTRGT3NLQ0hGeG9K?=
 =?utf-8?B?L2RxMkp0M1lNYytybjVBRVpXSnBTV1RsajRBcHMxZWVDb2V4Q2pDRFRsLzFq?=
 =?utf-8?B?bENRcnZqR2JweDhFemwvNG1PVEJvR2o1TGNiSjJqYkNhYWI4TVlDdXBOeTVr?=
 =?utf-8?B?MjRBcXJESzRwc3k1TUV4MDA4bUdYM1gzRlhsVmNtNTRJdks2SUJUckVnTGQw?=
 =?utf-8?B?YzJUZVBYSVl4clBSMmkrdGtxVER2eWRrV1NBVVJmQlZNWURKYnd3TGJQdTRM?=
 =?utf-8?B?MlQ4aUlDYi9HZEpGNWVzcHQzQkJuNFNHZ3FGK1diMUhCWmhXaGpqRllkcm1G?=
 =?utf-8?B?ODZsKy9XM0NWdEUzSFJHRDREcjBLUDR5R1hjNGNhWGs0a3llVkRVTnAydDBB?=
 =?utf-8?B?aU5xWS9HcG5PTVFzS3o5Qjk2WFcrNnBQN1pQVVBsQ1ZJK2lVSXdmTXNwY1gy?=
 =?utf-8?B?aVNyZXpzTFhyR0xKTVZielZSS3hGODBFUmI0UWxxb1ZFQ0NldHBYOVN0aXM1?=
 =?utf-8?B?WERmMkE1TllHeTZ1WTVyTlNYUmhUK1ozNVhsM1FoWXNNamI1TC9lZHduM1lZ?=
 =?utf-8?B?WkFWWGVjZDJ2WmZHeWRZaXhLc3Iyc1MvWEE2c0t3aDd4TlFTaGQrbDgxMU8y?=
 =?utf-8?B?MFFxMkJicVlqYmJ6aW1RdkgzQWdZSHNjcVR4UUtwQVM4dFZLMDdDM3NQaWZV?=
 =?utf-8?B?a0VmYjJmMkQrVHdFQmpKeTRuQ2RINXJpOFJLTUNSdStLZENNTG10UVE5Zngz?=
 =?utf-8?B?eHRTekNaSHdMZUlQYUNPV05ZS0YrS0tNWWVrdDZ2NUorK3dqNnp1Z284d1Nv?=
 =?utf-8?B?aGJnTE5hbnpKU1VMUHZBYXNCSjBUNzQreU9nMzZJL01zQ3p0d2paa2t5Lzd1?=
 =?utf-8?B?a1owUVBVc3B4NVJzRmhuV2ZvcngzcU81Q3JqOVVXWkU5bWd0VmJuY0F0a0Zx?=
 =?utf-8?B?YTlEYkd2UXgzdUoxNjc2TUl4YWtjK3VDZE1XbkY0OGl4dVNZM2dlM21xeTh2?=
 =?utf-8?B?RmxETHV3MjJvUk9xcTVnendoOTExUXJtV0ZhM0FRUDJpbk0yZG5wbnA3eitK?=
 =?utf-8?B?cGxROWpMdFNNSjNVdk10UXBQSzF5Ukx1a1VPd2dTZkQ4VDdQbGVzcmovYXdm?=
 =?utf-8?B?cGVUUW9kQ1ViNlA5UXRqQmh5ajJncU1XMDNlNW0rbUxuNEswbFhiYldnYlpm?=
 =?utf-8?B?dVR3UXNaeE90V3k0c1NNTlpjdzdwUWRTRHo3MVNtSzB4ckhuMm9MNlBheXZn?=
 =?utf-8?B?a1RmMGJuWVh6T2thUDMxNUdock50UUtURzdPeTNucGFFb3lLSGNKRUliR0xz?=
 =?utf-8?B?OW1KRkVIYWVEK0lzTFNTL05jbnRISUxNTHhibnY2MFZKYjFZcy9LaGE4L1lJ?=
 =?utf-8?B?alA5ZWU4TTR1WC9oTG5LMUpnY2YrTUJQN1Vyb0VEU0lhdVBNcWlxcWNGdUFC?=
 =?utf-8?B?blI5SW02UmszbE0wdGpoYlBNVk55UkZTZjF4TFRsVDFjREFmbVZaYWUvSVhG?=
 =?utf-8?B?REIwVUFDVDRDanVFNG5nb05IaHFjemdaZFFOWitWSzF5dFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6708.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlZrTE54Q0lrYnFLRmFxb3NwYS9nQ01HUGRCZTNXMENPWjRaaXlaemwyUjVF?=
 =?utf-8?B?OW1PWU1XeHRqSkd4b24zTHlZanYwTTh2VDg3MW9PME5VYjBNYVFzRndQbkti?=
 =?utf-8?B?YlE2VnVnNmlRbVFKb3V6anU0bVE3VE54MmIxN1EwS1dFdnNSV1NnWmJUUlR2?=
 =?utf-8?B?VWFSb1pDS3JwMkRDeXpmSWRnZXlxcmFzQUs5K0o5ZytTQTllY3dreFRRenZO?=
 =?utf-8?B?S2xVVUZTSUR3Q3VCTHBaVUk5cno3eDBXVkJXOFI3U0lDU0JjUEJMOGt5Sys0?=
 =?utf-8?B?ZkprTXNZZEN6QXZjajdCalpVWW10eE02cGZWTHRhMitHWlFOOTlGSktWK0tl?=
 =?utf-8?B?ODN5cEFYN2ZXSTk2UUFHZzNMUkFYRFc0WGpTQnBjeHdrZnhSaUVKdXR5UDJN?=
 =?utf-8?B?SG1MdUtjVk1tZ2xoZDN0RFlxblBwUlZLV1dpeHFkVlpLQ0R1TWVBSTVNVDBS?=
 =?utf-8?B?ZXhSeFdtQ0UrazhCYThLdWUvcXJLVlI5eGhYL0NGL3RyQWZ5dzBRZ0RvS0ZG?=
 =?utf-8?B?eGtabXRRbGVBU2JkaGZoM1U2cis4OHU1VU1ERG5UOTdRbDNIcnFxQmpwU014?=
 =?utf-8?B?L0k0SkplOHBnVEVXRHozdSt0OXNWcHh2YlVSVUdQNXBQTllKeFl2bDdFSHZB?=
 =?utf-8?B?QkpOczB3RnNzeVU5eUhjTmdKNGI5QVVTbTBLUXg2SFNMT3hKb3drY1pLZHNv?=
 =?utf-8?B?cGdqQVJwcUNQc3NxWi9wb2RQV1MrWXFsVHpleVdIT0hhcXdTOE5jdTJLUlJi?=
 =?utf-8?B?bHhUSW1mUXdSWW9vU2dkYzBFQXlmalI3aXVYeWdVcGpCajlxbG5CdjkxR1Ri?=
 =?utf-8?B?dDdNUWo4NlNMV2RVeFc0SFZlWFIyenE0N0I5cUJKTC9ISENaNFM2bFg3Y2J5?=
 =?utf-8?B?K2Z4SGx4b0I4T1VtSFpuS05Hc0RYVWhjQTFKVWVZTVVrRlVWcXQ3cmp0WVU4?=
 =?utf-8?B?QkhPSjR2dnBYNW1tOSt2WWhmYmE4RUpkQUF3WGR5dkpqNnFFNnUydjhYSCtX?=
 =?utf-8?B?QXk4ZlN6bGVLTC9CMmhVUXdJZ056NjRLS1dhTGU1Rm9peS9ZZERRZHNsTXIz?=
 =?utf-8?B?bW9rUTBoZWZaNkRUSWZBK05kbTNFNEhiN0MydEQ3cjFWMDhGRzVOQjlHRThG?=
 =?utf-8?B?N0pVamNEY1Y0Q1NDY2FGYUVGR1dka2o0c3ZjaUljYjl5T0V4aVRQQ3V1a2ll?=
 =?utf-8?B?cU95YlpSOVFvaThtbkVxaTRyRlplOVZpK1ZzUGFUMTVFQmJQWldraTNLY0lj?=
 =?utf-8?B?QWpLbjViSytmZ0xCbXBSNDBiY0hEcDNxN2hNTHVnUjVSU09hUUdnNHJsRktS?=
 =?utf-8?B?Yks3a0NxUlVzeENML1p2VVk1dlp2TVZPK3MxTmppN1RHaHRoaU9NSVFyamN6?=
 =?utf-8?B?QTdpMjQ3Rm5sbWVzR25UNWJ5WGRlR0o0Zmh3eXJlb2hwdEF3QkhPbk9BbEhB?=
 =?utf-8?B?QU9XQmV1ejlOOVFmOGJuTExoSmtObzkzNlIrek5iU1E2NHdGYTVrdkZMRXhn?=
 =?utf-8?B?cllEaURCMzNPYWhsYzl5dVp6SUhqRDd6d2d0SzN6eUprRWgzbnVvQzlvQVNF?=
 =?utf-8?B?bWhDbGhTbWUrQmtWdElGSWUzZ0FXTnRMeXdHb3Eyc1ZsVVVqaGdhR2wyZWJh?=
 =?utf-8?B?a2ZpbFI1S1M0TGJuSWd0YTlWaU1uenRDeGRBYU4yejhjWU5BdzlydjI0NFUr?=
 =?utf-8?B?ejA1K0RkZUVtUVd1NXYzL3A2Y1V2THlHd2NGT0tYWVNtYnJyRjh1dzYyYXVH?=
 =?utf-8?B?MngwSVBIdUNwcVREUzllTnUxZ0RzVEN3UDFkYlhQSlNKc0Rza0g4aFMxcnNR?=
 =?utf-8?B?RzVsNUE3U2tEVHhubzdxbVFZb0t0QVRaU2xMRXFFL1RRVkU5OUpxWE5EUWR0?=
 =?utf-8?B?c0hib2ZnZHVYekNKYXlQaWFFd0ZKbWcweXVLODFnaCtCSk9MWTA3ZXZBZnRF?=
 =?utf-8?B?RXY3L3FDaXp6Z1lBTDluaW5ZeXcrMTFJamg3bjFQWEd0TXBvS2NyeGtVdU1s?=
 =?utf-8?B?T0I4VFlWRFd3TXlvVTRqaVJ4VmdvQm5uWGpFSm1jeXJkMk1zZlJ1RjRQTEZ5?=
 =?utf-8?B?dm5WbkpTVkhBR0hBeVBRMjlVT2NUaEJTY3VWdm90L1RwS09idEFZclA5Z05n?=
 =?utf-8?B?L1pSb0NjZkIvQW5yRGlZZU9GUnhjc1FYREVpU0gwWWRUaEFJZHNYSE1vTkU1?=
 =?utf-8?Q?UJX/h7PY4FLRQYWUwL8ulPy1i5Dj9j4bzqoucwzW5bZj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B19B2D6D44821B4587D737EC40E00798@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nsa/YZiJrnCXgOQfRkAGLu9sXM9gHQ+uDE4GRDQTnO71XTyIQuJ20SibYLbicYiEog4Q8S/7okpDro5k5Wnn1otfD5My04bOh9GIt9FnvjmwkMDMvSzXvN0fI0LFZapPIFe9hzvCcGPSvxt9nMwMvM8e8ri8Hlc73Ej02dUCX6x/CXEhdNMtIDLgqifFpcSKkI9P0uiQRaz8PjK8ZYMvnT0eE1F7imn0L1oFyYPZyb8/esvwL0picTTMKVKohN6prt96sv6hqehzqKpKc3Nb4uRkDn9SWMy94gFNOVun3jSk489WZwX/T1qf+x0GGbM+tlID37rL9AdlRoZCenr0L0al+aqBXA4IuG6ZGjfUCe4J1hWttkZBlbqrjqvvds4PyEeMXPXRTmuzFI4EuJgCAd4H9c6GPi0MjBQtiUILE4iz9Iiob/DYP4S5966+d5IJw++nlL3lahHEH7WgQaKdeo1omzNQ2d0INKzcMC2WOfdfpcMidRbbYePuuZhSgCwtlqKPRa6Bak2AdavPirPwK2TANdIQl8NVzKNt5RXfyYv0e5RfKfdBgiacsSIIrwXfH0LVP8HcKVZFIy4IpbtQKDL6KFreRTn8muF6xLgUvDE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6708.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3357f81c-5233-4678-4307-08dcb0ec4c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 23:06:51.9493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: toBQRyNmuJ6KuADxMz/+mkQO/44gOQNVk91sll5pyzxxQ/mmXEZ6yaPcfNGnf6Vf9NPg38oyY0VtcCVaAtFNrwiwi2C1NAESi/qagBH9aSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_19,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407300160
X-Proofpoint-ORIG-GUID: r1_4OJBzVcbqxsM5oXYtMqsA7Q0sQCct
X-Proofpoint-GUID: r1_4OJBzVcbqxsM5oXYtMqsA7Q0sQCct

DQoNCj4gT24gSnVsIDE2LCAyMDI0LCBhdCA5OjI14oCvUE0sIEplZmYgWHUgPGplZmZ4dUBjaHJv
bWl1bS5vcmc+IHdyb3RlOg0KPiANCj4gSGkgQXJ1bmEsDQo+IA0KPiBJIGFkZGVkIFJpY2sgd2hv
IGNvbW1lbnRlZCBvbiB0aGUgcHJldmlvdXMgdmVyc2lvbiBvZiBwYXRjaC4gSSBhZGRlZA0KPiBL
ZWVzL0pvcmdlL1N0ZXBoYW4vWWFubiwgIHRoZXkgZXhwcmVzc2VkIGludGVyZXN0IGluIHNpbWls
YXINCj4gZnVuY3Rpb25hbGl0eSBiZWZvcmUuIEl0IHdvdWxkIGJlIGJlc3QgdG8ga2VlcCB0aGVt
IGluIGZ1dHVyZSB2ZXJzaW9ucw0KPiBvZiB0aGlzIHBhdGNoLg0KPiANCj4gSSBhbHNvIGFkZCBs
aW51eC1tbSBmb3IgbW9yZSByZXZpZXdzL2ZlZWRiYWNrIG9uIHNpZ25hbCBoYW5kbGluZyBwYXRo
Lg0KPiANCj4gT24gVGh1LCBKdW4gMjcsIDIwMjQgYXQgMjoxN+KAr1BNIEFydW5hIFJhbWFrcmlz
aG5hDQo+IDxhcnVuYS5yYW1ha3Jpc2huYUBvcmFjbGUuY29tPiB3cm90ZToNCj4+IA0KPj4gdjYg
dXBkYXRlczoNCj4+IC0gUmViYXNlZCBwYXRjaHNldCB0byB2Ni4xMC4wLXJjNQ0KPj4gLSBDaGFu
Z2VkIHNpZ19wcmVwYXJlX3BrcnUoKSBiYWNrIHRvIGVuYWJsaW5nIGFsbCBwa2V5cywgYmFzZWQg
b24NCj4+IGRpc2N1c3Npb24gd2l0aCBKZWZmIFh1DQo+IFRoYW5rcyBmb3IgdGFraW5nIHRoZSBz
dWdnZXN0aW9uLg0KPiANCj4+IA0KPj4gQXMgSmVmZiBtZW50aW9uZWQsIEknbSB1bnN1cmUgaWYg
d2UgbmVlZCB0byByZXRhaW4gdGhlIGNoYW5nZXMgdG8gdGhlDQo+PiAzMi1iaXQgZnVuY3Rpb25z
LiBNYWludGFpbmVycyAtIHBsZWFzZSBhZHZpc2UuDQo+PiANCj4gSXQgaXMgcG9zc2libGUgdG8g
IHJlZHVjZSB0aGUgc2l6ZSBvZiBjaGFuZ2UuDQo+IE5vdCB0b3VjaGluZyB0aGUgaWEzMiBvciB4
MzIgY29kZSBwYXRoIGFsc28gbWVhbnMgbGVzcyB0ZXN0IGluDQo+IG11bHRpcGxlIGFyY2hpdGVj
dHVyZXMgYW5kIGxlc3MgcmlzayBvZiByZWdyZXNzaW9uLg0KDQpBcG9sb2dpZXMgZm9yIHRoZSBk
ZWxheSBpbiByZXNwb25kaW5nIC0gSSB3YXMgb24gdmFjYXRpb24gYW5kIGdvdCBiYWNrDQp5ZXN0
ZXJkYXkuDQoNCkkgYWdyZWUsIEnigJltIHVuc3VyZSBpZiAzMi1iaXQgc3VwcG9ydCBpcyBuZWVk
ZWQgaGVyZSAtIGFzIHlvdSBwb2ludGVkIG91dCBpbiBhbg0KZWFybGllciBlbWFpbCwgdGhlIG1h
biBwYWdlIHNheXM6DQrigJxUaGUgZmVhdHVyZSBpcyBvbmx5IGF2YWlsYWJsZSBpbiA2NC1iaXQg
bW9kZSwgZXZlbiB0aG91Z2ggdGhlcmUgaXMgdGhlb3JldGljYWxseQ0Kc3BhY2UgaW4gdGhlIFBB
RSBQVEVzLuKAnQ0KDQpJIHdhcyBob3BpbmcgdGhhdCBEYXZlL1Rob21hcyB3b3VsZCByZXZpZXcg
YW5kIGNsYXJpZnkuIEkgd2lsbCByZW1vdmUgdGhlDQozMi1iaXQgc3VwcG9ydCBmcm9tIHRoaXMg
cGF0Y2hzZXQgYW5kIHNlbmQgb3V0IGEgdjcuDQoNClRoYW5rcywNCkFydW5h

