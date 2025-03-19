Return-Path: <linux-kernel+bounces-568476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0161FA695FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB38216D4C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6563C1E572A;
	Wed, 19 Mar 2025 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FxwLcL0g"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9BC1AAC4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404209; cv=fail; b=hll5AbjNx5YNuFE+wAJnyTeOoVoYp7XkGqwyK3zU4qUPph3hP+5cSJKBt8EjheL8tTF0J6+qtbJ8x/uQfHi/I4HsfldU3ugVFlHAz5JPD4q/wchgPKiXX4GoR+IxExS+u+mXPciWankdXH4Plo5qHIHqOZ4NU00aQKTsGDcEpiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404209; c=relaxed/simple;
	bh=vGcg4OwZbQVQqlE+6sMiQsGRw6XtXzXQ+ChR0PiBFz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MX7GwprSvbcKYJ4EuZ48VFXwGpsWQRLcxT4bLVe92clCK3quB5i8SU4xMJF99xD63rSXjhUDP7C/lbjNL8xzhn4PY6pZydKg+otGjZ2NC4CaHc+p6CnocOZq53SpYTORQLT2chrnFHjlHwfpaRJ0LXJGrfUhKToNhzOj9Uv3Tus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FxwLcL0g; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JGCZVO017026
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:10:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=vGcg4OwZbQVQqlE+6sMiQsGRw6XtXzXQ+ChR0PiBFz4=; b=
	FxwLcL0gKesOOEV4+EO3tc3QbUz5QcWE4DCQpMs7Sd7CIydASuJgteQm7Z9kfjSn
	k77azlJXanKkd8vF75oscoN1iXy82ztH3gIrdUdHwazbR+5jrwZZeZWSfs09gAuM
	G8B+Er55yxdMB7ZrvntS84HWQaTX7O9MGJI/6WvAEjNETK3yI76H+mSFsy60jb85
	PZKTxNrljBDMHBR553KjSY8iY50FfPXbdojKyXBNwNKSRb73LeoSUkkGt4VOfvTi
	WsqIu4OdI1+xq+K8epVzKmjUDnKj1biI3OP6Hby83hPaHsYPjbr+lSI9UU+SbQDW
	R/i6mCFsqAKVWcw7LnkFMA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45fxbtswqa-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:10:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gt+OwzK7hulLNFnUVL3q+3/37sbk6jDEb85F/NVitNGKHzbisdoIB6HHURq3aAMD1VWcizuns4Sy/5j4YA6MjADckQa92quxmIxjwY1VZuj4zhwBTQ0CdCV3VS/8Hf5slXYc4s0q8ok+RwjteKHUPwbrd7JQ9aYMWdbC4VBA0rC7VEflmjIIrdJrC8ClisCK9CrVlaPOJBSwdJ/XSsI5qpA8VLrzdXq0cksk1YS9njnnLaeVo4yb0DPQua0fqp11BHJUWl+QcKU0Qp1vX/bvmUA5181wmD0hzppd4HdT45uOByuyrWAqiNM/DnnqzLh0aImW6ba4Rvl4BT41/6O27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGcg4OwZbQVQqlE+6sMiQsGRw6XtXzXQ+ChR0PiBFz4=;
 b=FNxuGHv5mTAUxaCOKM9H4xWvFiWjnlEJkqOrdWSr3u/uHPRYDv7nV6Kd9rPyez+vht8hU+qWTJMzu6GPG3O2KiUO8QOfcCSgkZfp2rvR54Hnm9AD1cOzJ+ptQtQiR3BFjdD/+mI1JXlIus3gNK/xyLK+DdXruwL+mUx/psIM+KV4KYaF3Xp6LTznxr9y3eg3R2A48F73KsSun+FulYY0HFx7hJ5j8w1mm+h9hhKVuV5rIwjrZv7Ao3Ycx0KIYn++psfE+1hxFQ/TTpZ1+QwcyvcwJfWK/oJhZWB20j2rzaAgsAKmHcegB4pPITq+k1fivroFBSfjayE2u9us9JXjVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by DM4PR15MB5379.namprd15.prod.outlook.com (2603:10b6:8:62::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Wed, 19 Mar 2025 17:10:02 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::f3ab:533:bb24:3981]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::f3ab:533:bb24:3981%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 17:10:01 +0000
From: Nick Terrell <terrelln@meta.com>
To: Borislav Petkov <bp@alien8.de>
CC: Nick Terrell <terrelln@meta.com>, Arnd Bergmann <arnd@arndb.de>,
        x86-ml
	<x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: lib/zstd/compress/huf_compress.c:1033:1: internal compiler error:
 Segmentation fault
Thread-Topic: lib/zstd/compress/huf_compress.c:1033:1: internal compiler
 error: Segmentation fault
Thread-Index: AQHbl0RWePPGiJsSGk2mauYganFNL7N6tOuA
Date: Wed, 19 Mar 2025 17:10:01 +0000
Message-ID: <4C937266-6136-4103-A53C-C313B5DBC676@meta.com>
References: <20250317135539.GDZ9gp24DhTKBGmkd8@fat_crate.local>
In-Reply-To: <20250317135539.GDZ9gp24DhTKBGmkd8@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR15MB4732:EE_|DM4PR15MB5379:EE_
x-ms-office365-filtering-correlation-id: 1a78390a-5f88-48cb-e6f2-08dd6708e29c
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NGhPTjA4QmVxQWljRFBUT1NSaUFNL1NPK29INGtMUzBLZlh3N01qM0ZWRVV1?=
 =?utf-8?B?STJPeURRa3VOb0xUWUNKSmF1MDBmQUxDbCtudGZsb0RHeDRIbDVGQldLNEgr?=
 =?utf-8?B?ZGhDME1iSytZMWM1c3ZSUXE3eGd0UVdEYTVkZS9GQTVodkFJaWtuRGxHRTVQ?=
 =?utf-8?B?UGRyNVd6bUFZSDgrVjREczdnUmx3SnFjb1VpMGlWc3VBZm1WSjdBQnB3RC8r?=
 =?utf-8?B?dTdmN1NnQXdFai9iMVR6b0h0cHBiZDZVMUNUbUc3RlFiZnQxK21ycEc0L1gx?=
 =?utf-8?B?QWFtWVZmd2Zib2JBbTlrQ3ZaS3hiS25CSUc3TCtCR0xJeU1UejJOQ25TaUhm?=
 =?utf-8?B?Tm92blB0SmRYYWUxdVRFVm1ucG1nNkh1K0U5QUYwbzU2WVRtd3ArNWE4WEZY?=
 =?utf-8?B?OWZBMzdTdi8zNGN5SE96YkVwTXFPekNSNStRamlWTlBMN1JqUGoydzM2NDdm?=
 =?utf-8?B?bFA1eFIvQTBCdWh0Q1lNMW1wN3NkSHQ0bmNZYnRzVlRZdjNiZldOallLUjlE?=
 =?utf-8?B?dWNGbkdFbnhPS3JPWDl2UzJJZlNVWVhPTFM0dXFOMkdhY0xob1c0L1Q0OE9z?=
 =?utf-8?B?QXI2S3F6aFFIWEUycUxYU1BFTkpNMXRkQlRJSGZIcytmNGFqL0htZkFQTXFC?=
 =?utf-8?B?QkRHSWxzZzVXbldPSC9UY0l4NDJuWXFZNnJFK0wxSU9SSnJTZkhpcGo5ajI2?=
 =?utf-8?B?Z3BQNHdCcFJteGVnN0pKOEM3eGRJSTJBbUh6Y1UzcVZUR2VxZnZ0Nm4zQlVx?=
 =?utf-8?B?TnpTYW5scTBtaklBZkhYSlAwNlI1YmxCSkFYOGc3UjNUQi9lWmd2dGd2MjZX?=
 =?utf-8?B?ZU5nWk1rMzhFS3p3dmN4OWNSakFhQm9zeDVOSWVIdmFXZXo2RXluSjhsVjQ4?=
 =?utf-8?B?ekxONUlraGY0Y0p5d3M4MW5kVGhNM0plZnlpYnFBZkJVdG5vRGp2Q1h6YzdC?=
 =?utf-8?B?cEo3S2sxVlVJTXBYZWJrWmJYMjZJVXpTdGM5Y0NFOHI1Z1c5Z0ZrZVhuSjVH?=
 =?utf-8?B?SG1LL2c1WlNrUEhibTRNS2ttUnkvYktiMUdGeTl3ait0UzVOS3JPdEpaV0FL?=
 =?utf-8?B?N09zM2luZDhGeDdEWGthcnpXVnRBVlB3S3ljOUtFRDJUbjM4clIwVDNtdms3?=
 =?utf-8?B?Y2IwREZMaXR1ZWsyYlVtRldlUVVXSTYxVTNNNHZLK2VwRGZEbFB2QXNvOVI5?=
 =?utf-8?B?SHhhc0d6VE83bnVVN1hUeUw1M0dDa3Y4MkhVYUJUVDROMW1UZDhrVnZqVFVy?=
 =?utf-8?B?N1pHbVFvU1B6YVBrWlRiRUJ4RDViS016NHFpbUhhZmhxQ0NKN1Y3bmZKYXhI?=
 =?utf-8?B?Y3FQOFd5TE9kNjUvNEpTSTdEOUN1SVZ6dW9IUnZGRllOUTlrTVN5Rm90MmNY?=
 =?utf-8?B?WG1SUmRTSU9zbmFiRkVGVzhDWnVYSEtEejVzcHdHTlRkZXNxTmFFUXhPN213?=
 =?utf-8?B?K2pOeDN3bHFEekJTekFyYVJrTmdSSGpZOFpYMXhvTUEya3ByRHNJUnUvOWNB?=
 =?utf-8?B?UFhsL3FpRHFrTkgyai9MY0U2SUd4THNiTUpZa01vQXplUWhXZHROTlpnVGow?=
 =?utf-8?B?VzY1TTFVbHBSSEdXdFE1QThvQm5mNlZ0NzkxSnRkMEdXZ29zeTE5ZFRkaVA3?=
 =?utf-8?B?TDRkeVdZdlI3TWZCSUxvNTQwOUVqV0lPbXJ6T0ZZd21WbGFwWU9EU0MyaVkx?=
 =?utf-8?B?SU5XSzNkVUFWN1c4MTJUVUloQzNoNUdKSXVzQVBNUlZUcXZzUkN5cTZpbkp2?=
 =?utf-8?B?TjNNS2t0SjdKcndaSDh3WVdOOHo1LzVIV0I2ZDUzdllWMTBIZEw2N3IxNm5z?=
 =?utf-8?B?bVd4VS92UkEvNG5OWm4zWHd5SWNsRzNLdzRqazBWWXViVzEvYnV6bmRCMmR1?=
 =?utf-8?B?RjZ6cEFhbjROMWRlOHVlMXFqb1Bza1NNOEpFbVhZdk54MDBtZlVFam9UUjkr?=
 =?utf-8?Q?ZGUdLfId6P5NGQGZxZtMrOl02Lyhwd7v?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZStDRDZwdkdNNkhOSitoNUlZaURsaGwrMVQ0aVJndmIvdHR4bUVWUk1ham5D?=
 =?utf-8?B?bTVlelBsR2tXYXB2K0FWM1doYWp1NXQ0eVgzRVBrRlIyZ0hYYm9MalpaTWI3?=
 =?utf-8?B?TTZHUE0yK3d0eXd0SmlrUTZWYjBOSnViMzFMamdrQVE3ZUlybDhwRFQwNExW?=
 =?utf-8?B?WXptT1FXdnNaVFJ6ZWNHU0ZLazJrQ3RxNVdlaFlpSS9zQnpxQkNITVFUdHN2?=
 =?utf-8?B?akJseTBScWo4Vm5TYXBQNVNmWVY0eFdWUmI1ZU1DZWRKVDYyQWdGR0N3WStM?=
 =?utf-8?B?T3ZmQWFYUVMvdzBveVFTbHdYSXllNTR2UFlpdTFya3k1NlZGTWNHd2xHT2N0?=
 =?utf-8?B?bW92Zk5BOCtKYlpKL3BkTjJudnQzYjZYbFRnTU13QU92NjJ4UVFaK3o4Z2hN?=
 =?utf-8?B?ZTU0aWw4N1JiOUxMNlRtbVFkMVhPMHU0aG96VzVtMzV6enVLZzVGZWV0RE9V?=
 =?utf-8?B?dUt6Zkh6aTdycVlHSkYxK2xjTXQzL3VBWUF0cVE0Z2hZT2Jjci9sd1hlQmVq?=
 =?utf-8?B?WE9MdDcvS3BOejJZMjExL0JlZENFWFh5SUtiNWkyVEM2VUtUc25OQm5NNW8z?=
 =?utf-8?B?M01nWGxjdERrVnE4Q0JqV0FIU2JPdnRJcDBrYlgrZXhmUlQvdDR5dityNWlq?=
 =?utf-8?B?bXBiSnZEc1pXeFgxblpqWnBJVE9IQVRSQ2IyeG1TdHVRSXVLelhXNUo2d1Vr?=
 =?utf-8?B?MHo5MzY5ME1rNzJjVDB4SHBKa2x2NStITWU0M0F1SzhsOCtvbXpoUGx3T2I2?=
 =?utf-8?B?QStkYjdGcVBmVVFWYTd6ZlQxZForU1hZR09jV3RxQ3RibkZuRUo3emhnbVpC?=
 =?utf-8?B?RTFFM1pRZ3JrY3R5YnlUQi94enZsV2hxc2tpOVNuSzNQZlRQNHk5VjFrR3hN?=
 =?utf-8?B?eFhmS2Y3cFZmc00zNEdVbGw1MHZtV0p6cXFRQ0UvS1U1MWRDU1BoUUhuNm5Z?=
 =?utf-8?B?VHh6VmVwdVVBK2xvSnVkS2pZeU9qcGlyTE5aRWQ1bjE1aldvMU9SVkJVNGV6?=
 =?utf-8?B?OHJvd3g4dkZ6bmJlYzVPV2s4K1ljZG9JNzBzS3U2MnBVYmFPMHRBS3VBcVNX?=
 =?utf-8?B?U212ZkxRaWpUS2QrZ1M5c3FqdEtGUmN5YUJQWmM4SXdhMk5haWFxUk0wbisz?=
 =?utf-8?B?R3RvSUJPOHVWNUtqRm81WHdFUFR5K21KczViemthL3JTZ3Z3dVEzOW94Q05J?=
 =?utf-8?B?MmNHUExqcFVqUk43SmgyZDc0dzNLVFI2bVRxUlBIdEd0VEtGUzFEYTdOTTlz?=
 =?utf-8?B?QjVZNDE5SkFwaGx0bDFtejV0MEVORzNhRTdqcnFLTHIrR294elV2YWR1b2po?=
 =?utf-8?B?S0hCUWpFc1psVVBVRUQxZVpranl3bU0zK2pCTFAvcWhyM01LOHJiUTNBWWEz?=
 =?utf-8?B?VGVuYVBpbWtLd0VVUTBBQStQeDVuMzlQN2U2K1o1YkwwSEs5ZUhaRmlQazdk?=
 =?utf-8?B?Vk55YVpJbG9INSszelVnbHliaXgxTDBlS3dSZlVVaDg3RUpTY3NlWU5POGZl?=
 =?utf-8?B?Uk5YcnViczVMSWhoUkZOaXA4b3d5djhDQ2tVOFRkd0ZqbndHUE43TFlUU1Ax?=
 =?utf-8?B?enl2YU9Sa2hWd0V5NVNsRXc4QmI2Y0p3VXZtMVRnbTRueG5Mb0JWUlo3Lzla?=
 =?utf-8?B?S0ZONzVDaVJGVXZ3NlBMdjVBdWtvWWo0MlM4NlJ5SEVrRkZPaDAxZmlROEFM?=
 =?utf-8?B?eHRhKzA4TXdSR0NacXhKM3l6eCtuWHJ0OUxNbnNyQ012c0FjMzMrS2EydFl4?=
 =?utf-8?B?cU5aNElJTHppaHFnaXphWXZpSWliQzI0d0RrYWRJMnpCYXpNaUd2QitBZU5s?=
 =?utf-8?B?Slp1QzUyQVl2Sm1abm5pTVdwb0EraDhzMHgyV0REUHR4K3JVRVpQNkdUZ0RW?=
 =?utf-8?B?VElGZWdzNDJCK29ZMEZaZmtXNFlyenVadjd2Z0tSMkJ6ZDlQOUladGVEZTBo?=
 =?utf-8?B?S1hiMCtYdDdzaHVkdnZWaEpnZjJ1Q3FvTHBLYXFsTjA3TVFqYnJVdUNjS0tk?=
 =?utf-8?B?eDNwSi9kS2ZnNkZwZHFSZnc3UzJ2QjVvekVWU09UUm5IRjdNUXU0RXVkNVl5?=
 =?utf-8?B?ZU81S1BBbHg0MmV3M1hCaGs1WTYwZzhJUThkRU4vRGVmbHFUL3pON1NtdDJF?=
 =?utf-8?B?MEpsWGp6MnJRaytzWVM4d1E3dGUyYWRKOVFWRFNDOXUyaXlRT0tLcUhueWhn?=
 =?utf-8?Q?fd4w3BMeISmJut51rocDAKY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1418EE3DC76B2F4D92468CA4096AFF69@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a78390a-5f88-48cb-e6f2-08dd6708e29c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 17:10:01.5385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elRkhGNNshcY0b4fneclL4R7qxHn54G1IH6VB1YyU1IM1J6dsrqEdkmN3sVVd0um7/bhISZvccE9uvmhm4mTsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5379
X-Proofpoint-ORIG-GUID: BU0RyJ6UVe8n_zDzxFD_PRg911P0sBwJ
X-Proofpoint-GUID: BU0RyJ6UVe8n_zDzxFD_PRg911P0sBwJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01

DQo+IE9uIE1hciAxNywgMjAyNSwgYXQgNjo1NeKAr0FNLCBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFs
aWVuOC5kZT4gd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+IHNvIHRoZSBiZWxvdyBpcyBuZXcuIEtl
cm5lbCBpcyAtcmM3ICsgdGlwL21hc3Rlci4NCj4gDQo+IGdjYyBpczoNCj4gDQo+IGdjYyAoRGVi
aWFuIDEwLjMuMC05KSAxMC4zLjANCj4gQ29weXJpZ2h0IChDKSAyMDIwIEZyZWUgU29mdHdhcmUg
Rm91bmRhdGlvbiwgSW5jLg0KPiBUaGlzIGlzIGZyZWUgc29mdHdhcmU7IHNlZSB0aGUgc291cmNl
IGZvciBjb3B5aW5nIGNvbmRpdGlvbnMuICBUaGVyZSBpcyBOTw0KPiB3YXJyYW50eTsgbm90IGV2
ZW4gZm9yIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9T
RS4NCj4gDQo+IGFuZCBpdCBidWlsdCAtcmMzIGp1c3QgZmluZSBvbiB0aGF0IHBhcnRpY3VsYXIg
dGVzdCBib3ggc28gaXQgY291bGQgYmUNCj4gc29tZXRoaW5nIGZ1bmt5IGhhcyBoYXBwZW5lZCBp
bi1iZXR3ZWVuLg0KDQpac3RkIGhhc24ndCBjaGFuZ2VkIGluIHRoYXQgZHVyYXRpb24sIGJ1dCBJ
J20gcHJlcGFyaW5nIGFuIHVwZGF0ZSBub3cuDQpZb3UgY291bGQgY2hlY2sgdG8gc2VlIGlmIHRo
aXMgYnJhbmNoIGZpeGVzIHlvdXIgaXNzdWU6DQoNCiBodHRwczovL2dpdGh1Yi5jb20vdGVycmVs
bG4vbGludXguZ2l0IHRhZ3MvMjAyNS0wMy0xMy16c3RkLXYxLjUuNy12MQ0KDQo+IGxpYi96c3Rk
L2NvbXByZXNzL2h1Zl9jb21wcmVzcy5jOjEwMzM6MTogaW50ZXJuYWwgY29tcGlsZXIgZXJyb3I6
IFNlZ21lbnRhdGlvbiBmYXVsdA0KPiAxMDMzIHwgew0KPiAgICAgIHwgXg0KPiAweDdmOGRkMTg1
YWY4ZiA/Pz8NCj4gICAgICAgIC4vc2lnbmFsLy4uL3N5c2RlcHMvdW5peC9zeXN2L2xpbnV4L3g4
Nl82NC9saWJjX3NpZ2FjdGlvbi5jOjANCj4gMHg3ZjhkZDE4NDYxODkgX19saWJjX3N0YXJ0X2Nh
bGxfbWFpbg0KPiAgICAgICAgLi4vc3lzZGVwcy94ODYvbGliYy1zdGFydC5jOjU4DQo+IDB4N2Y4
ZGQxODQ2MjQ0IF9fbGliY19zdGFydF9tYWluX2ltcGwNCj4gICAgICAgIC4uL3N5c2RlcHMvbnB0
bC9saWJjX3N0YXJ0X2NhbGxfbWFpbi5oOjM4MQ0KPiBQbGVhc2Ugc3VibWl0IGEgZnVsbCBidWcg
cmVwb3J0LA0KPiB3aXRoIHByZXByb2Nlc3NlZCBzb3VyY2UgaWYgYXBwcm9wcmlhdGUuDQo+IFBs
ZWFzZSBpbmNsdWRlIHRoZSBjb21wbGV0ZSBiYWNrdHJhY2Ugd2l0aCBhbnkgYnVnIHJlcG9ydC4N
Cj4gU2VlIDxmaWxlOi8vL3Vzci9zaGFyZS9kb2MvZ2NjLTEwL1JFQURNRS5CdWdzPiBmb3IgaW5z
dHJ1Y3Rpb25zLg0KPiBtYWtlWzRdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjA3OiBs
aWIvenN0ZC9jb21wcmVzcy9odWZfY29tcHJlc3Mub10gRXJyb3IgMQ0KPiBtYWtlWzNdOiAqKiog
W3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDY1OiBsaWIvenN0ZF0gRXJyb3IgMg0KPiBtYWtlWzJd
OiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDY1OiBsaWJdIEVycm9yIDINCj4gbWFrZVsy
XTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4NCj4gbWFrZVsxXTogKioqIFsv
bW50L2tlcm5lbC9rZXJuZWwvbGludXgvTWFrZWZpbGU6MTk5NzogLl0gRXJyb3IgMg0KPiBtYWtl
OiAqKiogW01ha2VmaWxlOjI1MTogX19zdWItbWFrZV0gRXJyb3IgMg0KPiANCj4gVGh4Lg0KPiAN
Cj4gLS0gDQo+IFJlZ2FyZHMvR3J1c3MsDQo+ICAgIEJvcmlzLg0KPiANCj4gaHR0cHM6Ly9wZW9w
bGUua2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCg0K

