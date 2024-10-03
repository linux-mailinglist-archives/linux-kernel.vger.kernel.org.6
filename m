Return-Path: <linux-kernel+bounces-349722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0A098FA79
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8AFF1C23007
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9271CF5C0;
	Thu,  3 Oct 2024 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EzciljS7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mUKJyNnt"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99D1CF2A4
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998222; cv=fail; b=gitmLjZDwYWoJVlZBa3a+e624EykZOBl+PgWBd4jZQcpSucb/G5PfGZp2v/jpRWHrBH3L/xvqQmYU/KgPGOpV7F1bRzyjJbd+TvdblA0wpCHP+lcthVhY18wyevK18ENQnFaPkI9IRBiWL7fgNMyFKSMhWxYE15WDdbLhQb01wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998222; c=relaxed/simple;
	bh=oaMrny2GPt+K+099GeC8o/w2gyP9R3J3wH72KQz4j0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wq0Y12un1vTxCjVU0ibxMCjo3gaITMUULMl2fwS+IC651IVNhrnxSiMhvR59csgWRpbBV/wVyKtnfvO1zP1QPWzMOkrMUfS+OpSCAAE/w84WLSJp0Yqhql9b9eJkRkreN3Lw1ZRlJ9kZ4zgkKq8D47hwLjEuaqLjleFvQsnj51Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EzciljS7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mUKJyNnt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493JktSY021500;
	Thu, 3 Oct 2024 23:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=oaMrny2GPt+K+099GeC8o/w2gyP9R3J3wH72KQz4j
	0I=; b=EzciljS7z58Xn/qu4Z5bk8TSSPAJrUnzr340u55HKMxpfZvp/s2j6FWep
	SqDa2UcIErHA/FXx0wbbnXGJc6xmCZe0qwsERoWz8WJ0yfVubO7vRw++HKyE9j5h
	fB4wj+jwIr7H2AjGsl9KAhgfIiDvu71xoHWCw3j5ohS91B6+h60sDtN+mTmFJQ/z
	TH7MJ7C2LttRzh3C5f0PjSUJNneQJfKGPMBoRt8U7OdxRHuwuB3cShjUv84w8Em3
	UbFkMRvY1zMt+35YQaPnoq/D99QJOydAvOHIU3IFUt+cPmBzaWV/l1Sbxnf3rfIs
	fb6b4GhB22FiBqzi9HnH6dpqiKHEQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4220498hv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 23:29:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493LbdFb037378;
	Thu, 3 Oct 2024 23:29:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422054b15e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 23:29:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEp7HJeWXCOFlZCcZOcyG0a5iW94xygwU1s+nA1f7T3+5SDA/74/aqHzM0CJrmxJKp6tk2m0Om+t5Rm+xsJdXM0E48GsD4skY8IIvWlC2NsnPUxi6JL3H5QStRa21F27FHJgqX4M03mk5I6099aPd+xuMl52f2LBd0U9YcCpTNzvpRu//s5RjVhiHun0H0FNvMW43KzMTJBOazynZ1om8SGgvmxNPeBAbMmCNCOCBIYxYzvrAgPJTQK5vVzs1FIQ10hg2dd/BCA8JO9eCmUgf0wYI0zcM2fpKkwfqYVCoGCEfpDGmJKvhWLWzV6gaFlQbUDdsFb+7sUtJdD9C5OScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaMrny2GPt+K+099GeC8o/w2gyP9R3J3wH72KQz4j0I=;
 b=cZiX1SVZ0miz6aL8/RuXWrHhk6ixR8A8Nk8JAGUhFGBlYFgEen0GIu8IihTHWVhQhW71rM2HCiSRaIQ8tTY2MZYqRFvzcfSyGkZZJfVUPUo8AzaTheG/hr8ZXYudOXpphC5EA/mypAOkvL0Oy4HQvgqQewlzXHOsZ5ACRqvCh4WC7x0//UDqhr1mWdAAymoBK7Dfp7UjHpBZ5Q5QUsfzPgkofRGed863ZkHZdkqwAJkWWkcuKhLvyjtcYPft/M0Df+ReZ4QDTXThylMw/yPnRRmBAzET9yuAlBDZNuVgLXUASe5e99KmN2UaxPu6Au401UkoyUj7GEcMeoo2+ugWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaMrny2GPt+K+099GeC8o/w2gyP9R3J3wH72KQz4j0I=;
 b=mUKJyNntlxgjtog6G6kESlffelp7zzpEGMRib0nM1Yp+H91hvYFsO9ThEQV+Y6YHLBOIHmI9MqQpJkQqMhKsJ8qS+k1hPpul51AAzfEE2FGhDADOrkTVghkCMl8U+cPEJjym6E8Q/VlO2Oqc1/mlDrCblFT+581v06cSaKWg8x4=
Received: from CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7)
 by IA1PR10MB6242.namprd10.prod.outlook.com (2603:10b6:208:3a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.13; Thu, 3 Oct
 2024 23:29:54 +0000
Received: from CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199]) by CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199%6]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 23:29:54 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Keith
 Lucas <keith.lucas@oracle.com>,
        "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        =?utf-8?B?U3RlcGhlbiBSw7Z0dGdlcg==?=
	<sroettger@google.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v8 3/5] x86/pkeys: Update PKRU to enable all pkeys before
 XSAVE
Thread-Topic: [PATCH v8 3/5] x86/pkeys: Update PKRU to enable all pkeys before
 XSAVE
Thread-Index: AQHa5KMadnOLf7qDxEy8qHb8JyOUvbIfOnyAgBszQYCAO6E7AA==
Date: Thu, 3 Oct 2024 23:29:53 +0000
Message-ID: <EA166994-BD63-4147-9904-7189F5135149@oracle.com>
References: <20240802061318.2140081-1-aruna.ramakrishna@oracle.com>
 <20240802061318.2140081-4-aruna.ramakrishna@oracle.com>
 <CABi2SkV6AfxDNnuSKr_PCydZSyvKSmzmEeMnAXw3w1=w-kz7ow@mail.gmail.com>
 <CABi2SkWjF2Sicrr71=a6H8XJyf9q9L_Nd5FPp0CJ2mvB46Rrrg@mail.gmail.com>
In-Reply-To:
 <CABi2SkWjF2Sicrr71=a6H8XJyf9q9L_Nd5FPp0CJ2mvB46Rrrg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6708:EE_|IA1PR10MB6242:EE_
x-ms-office365-filtering-correlation-id: 40bea7c0-f857-46d7-71e4-08dce40348fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Szc0V2lqdkNrRi9SNnJZVVZzZDBoSy9vYVg5ZmcrY0xxQW5PU1hPSzlITm9u?=
 =?utf-8?B?OXNwSDNSZTAyblppWWlXcFE5ZEhPWjVSRlV0M1dsUzhteHhoa0xwMk4zZGxl?=
 =?utf-8?B?U2VkU0UrWDRDcWlvVVRGOVkvY0FzbTJ6NjhUYjB2MVQvaXluQmVIMktSQVhQ?=
 =?utf-8?B?bk5pWjJzc2lyL0FsNXk0Y0lQS3NOc1FFOGxuZUV5WWVOZjZGNEhsTFN3d0ZP?=
 =?utf-8?B?SFA3WUdpb1NDZTJEQXRYNFBHSWFqYnUwMGwzb0dpamY3cmZyVWpjZUhydENn?=
 =?utf-8?B?NjZmRlY4ZHFQNHpmRWJsVkdobDZyWWQ3bDNoVmlGbjl1aFUvcjllbFFhT0VT?=
 =?utf-8?B?TXhFcUNWRjgwbTFUYWhxUjNLZmMySEY4cFFZZmx1SlA4eHpMTTQ2TmdoaU1C?=
 =?utf-8?B?QXdHSURwc3h1L0FQdEVab2ZDRjR3ZHQrd2dmRHZFU2NzZzExN2hIN0dmZUpL?=
 =?utf-8?B?UDltUFhySFB0dmRDTWkyMHRVby9ZSEtmai84amlBa1hET2J2bnBYWEptaExQ?=
 =?utf-8?B?MVRFVWVnK2J1UHllOFNBTE4yOXAzY3hFL2RDRnpHN0d3ZEVJMnFNRkMweTdN?=
 =?utf-8?B?Z2NxU0RXM2tyc0hSMkgrZnRqL2R5YlgvTmhTTThobWxjY0I0TFl3YmYvUWVS?=
 =?utf-8?B?WmsvbEVqakxaY3NaNjBSYmM1Yys3NHRWUkZNNTVtSEdoRkZQUTdZRG5lT2Vx?=
 =?utf-8?B?WHNnMUJWWlRNTDNnZE5KTVB5R3VYbXk3TitEN2hGKzIyYzBRQjNNLzdlaWRW?=
 =?utf-8?B?L0dkNTJtczg5Y2o4Q0phMGhzR1RML3BJMURaYTdSWlpnaFFEUG5ZN1FzWHBQ?=
 =?utf-8?B?Rzg1R3o2TGxXUTlTc3ZtbFRydjYrMkNrNkZ3c2QwM1NXSTQ4RFFlNm1iV21q?=
 =?utf-8?B?ajVEenJFUnJHakt0b2h4TEh4TGZ1aUxSNE5YNCtpQU9MTFNyRmw4M3V5b2ha?=
 =?utf-8?B?S3ZIMTgwc3BvTnppMmJEbmkwWnVnZTdab09ndS8zZUN6cy9wK2ZYaXBHVWt3?=
 =?utf-8?B?R2lKNkhiODc2ejZhNmZvMzZ2eEgwenloN3ZqazBBcWpVY1ZNWnFIdEtxdDdD?=
 =?utf-8?B?WDY1QWtscFlXa1dzdXZqTWpRdHBmZ0UzU3ByNlg4T0h5NmlJM0VWM2UyRnk0?=
 =?utf-8?B?ellSTjd3aTNDSEh0dWhHSTJoUzJVMkhYYWVMNUdyUmRhSm01MUhTRjg2MWFZ?=
 =?utf-8?B?K2Y3VW1ISTcybURTSjZPaVY0QTFRRlJnNk1uTmxkSDVoNXVvZWZKNjl4Q0Vi?=
 =?utf-8?B?QWJkei9MbFN6WWJWUXZIMW50TXpGVS8zeXkvR2E5Y3RGZ084bmlldEdMUnhO?=
 =?utf-8?B?VnYvVkhaUUdFZExBV2d3OSt6RWprSTZ5U1VmY2ZSeGg1RGRKcWo3aldDNlhE?=
 =?utf-8?B?dEUxaGUvaUgrSU81YXVmNGZEUWNlWHhDaWNaenQwdFM3Zlllb0lKMmhhQ0JG?=
 =?utf-8?B?WDJRT05teklWSWdUNHhCbzYrbmZHQzZwRjZtZU5xWTNab3FqNmxBVERxb3Jn?=
 =?utf-8?B?ZUtTekh6QURJZ3JXcTc2blhlYlI0OXlLTUNqZTRSaFdSTXVUUnFIRHVKVTE3?=
 =?utf-8?B?bDBxSUtORlJjcE9wbm13d1B3NEI5dXhZRi8rSGhOY0p1cUdsUGNPWTBJa1Ni?=
 =?utf-8?B?cGw1Q2RIQXVsZkdxbUVNZDNYMDJtV2U2QnM5Sjd1dXFHenFSbkFNOCs2NEJu?=
 =?utf-8?B?UFBlWnhlM2NCTHBtTkRGMTgxN2RCMnR4c0JCaXVkY1NFeW5rRlk2YWtNdTU4?=
 =?utf-8?B?RXZMYzBoc0ZxQUp4V3dxblZWaEdURERERTlZTU5VMEc4T1FUZzhlN2JLL0c3?=
 =?utf-8?B?clRNSW82L1AwV0lWTXFjUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6708.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFVtenhGOUFDY3U1dlByS0MyemNnc1hLV1BNVVBqdE9sWVA4YWd3QWp0UDQ4?=
 =?utf-8?B?RmJIcUtFWWI0TXJpWlIwdFB1UUpZUzd4a3MwbGJKdjV3cE9tOC9FT1MwVSt2?=
 =?utf-8?B?SmRJandJQ2VWSjdSUklyZTNiTlYvRjdPUzdBOU5VTXV1aVZweTg1d1ZwWkIv?=
 =?utf-8?B?bWFWRy9tendUdFpoUGdjaG93UnF5Y3dtSkFBQy9LVElqbXdPOWFCblNhZklk?=
 =?utf-8?B?QzVYWEFKWlQrRms3N1dMREtSb1NqU29EbVprczdmbWZmZ3I5Z1p6K3RLYUo5?=
 =?utf-8?B?cU14Y0RLWTNIV1BaVVZrRktGSVFBb3EzL2VQMjVhenh5WUNwTE1wVkI3aGZi?=
 =?utf-8?B?L3poVVk0Y0NDVnNhQ2crdkMwNGlXeDJ4bkdnUzFoWGRTTTgxc1pBaW1Rd1dL?=
 =?utf-8?B?YmlaMVE4MFFWc1lLdUJiU1RnaFIrZGtDdnpsS1Nxd1dtb3R5YXp1RDJsQnFu?=
 =?utf-8?B?OXFEN1NHZDBZUUhGNkxZbWVxZXVXREZ2Rm9wZ3pqbEVERzR5VkVneG9YTEpR?=
 =?utf-8?B?MDBSQTA4V2tYZWVGbGxhaXdOeXNxNU1CbVJzV3BwMEpRaWZ0UzlMWnprMXZV?=
 =?utf-8?B?V0QzL1JuK2VnN0R3eUJwZkxZZ2JQcjRuT2ZycFBUdmR1eGo5a3RPWUJFM1Y3?=
 =?utf-8?B?VXNRazRJYmRRMXJySHEydEcvYnpwdHR6Z2FuMzhJMUY2YUhiWmwwTGE0eEpW?=
 =?utf-8?B?R0tNRndJTUJpSW1pdHFMVzJlTWd2VVppQ2RZS0hGY0oybW9WbE9YNDRUbDRl?=
 =?utf-8?B?ZTVZWVI3eEZ6NjZQU2VoSEV4cURpc1hRdWZTOG9aR2RqVVpTbHlBbzIwUU9w?=
 =?utf-8?B?NG9vQXlvbi9UdjZQMzdlOGlhSU5HRVkxcnc5TUFJVk9UTXJqRkhWcGQxVUpw?=
 =?utf-8?B?K0MxNW5uMlpreXhJTGdBSnBxZUF2Yk5rYzNqc2lnTTBlZ25UMWZuYTFINEox?=
 =?utf-8?B?QWpLNkg5UjV2TlVkRXFtS3dNaGRkTDZIZmR3NDZvREVSZHN5Z1Q4RkcyRGND?=
 =?utf-8?B?enNEUkZKS3g1ZDQ0YjZ0SUZIVjhlRDllTll0NWhxeXB0VjZoZHdKekh2S3ZP?=
 =?utf-8?B?cFB1M2pNcE1PUkkxUHI5bVl1bmdjMzY1TjFsRWZTc3BEbEgyc2JYeFdkdERl?=
 =?utf-8?B?M2FPWUlPS3pLVGE0NlJYa3A3d1JvUC9manIwY0tyT25xQmVlVldPVnpZOU1U?=
 =?utf-8?B?WXorblBNWHpvd0RxZlNqYzVSUGMrTEkrVDJoTEVRYkZXOGdyTGtjYVNaSGVN?=
 =?utf-8?B?ci9WZFhrWnBIcGNBTUw3bnZxOHo2N294UGRsQjhrdUtUZVBlYnZpdnNiS2lG?=
 =?utf-8?B?b0d5MERqN1lETUtrQSs0VG1lRU9IbHJlU3RYdWR2ejZiRHZ1YlBJSFR3MSsy?=
 =?utf-8?B?UG4wMkVsRFk2UEc0N1I4VVR3b3NXWjF2ZEpEUTlNRjZEY0Q5cnUzUnZ5bldF?=
 =?utf-8?B?YTBqV0xqOTFleXlwT2JGbFJnbnVaZFpmcGorL0dUVG5tZllvREtBRHBwL2Rj?=
 =?utf-8?B?NTlxNmp4SHJWakFPRXB1YWlXMTMyZHdtbVZBTXVabHpVL3VPNDBhSEtxU0M0?=
 =?utf-8?B?RW43b1VRUXZ2MG1KMi9Yc2YvZU5SM1lUZEVBSDg2eGNRWWgyM2drOERTd2dW?=
 =?utf-8?B?S3BlWHNnSGtoV1NocWVid1RuYWlqT2x2dDNkTHVzakRUYnp0VUFPYTgwN1ZE?=
 =?utf-8?B?L29WK3ZMNWo2SE80MUVueDFCaG16OVBuRS9rZFVnTWxwa0pGMDRiVFZZMjZw?=
 =?utf-8?B?UDJUYjI4T09ZbnJUaHFFaEhZT2ZrTGQwakIybGJxVFJGWEFCSjA0M1k1Yy9O?=
 =?utf-8?B?WGs5Q1lqOGEwRitxQXRDLzhRZm9RYkhQNjRDaVJhYk42Zzl5akZFdlM0dk94?=
 =?utf-8?B?VkhWcGlyNE5uZjdqR0VRYWdZdCt6dk9ITVp6S29FVDRoUkZGRGx4dGt5NGlC?=
 =?utf-8?B?TFFHdDJ0bVlJdHoxSUhwYWxQQ0hBMVFPL3Q0NVp0cUI3MFJsKzBXYnJVWldx?=
 =?utf-8?B?YUlVVkE2UWZ2M2xpSnY0dVREZHExdGJFeFFxZFJzR0R1NWFCYzVsMlFmWDI3?=
 =?utf-8?B?WTdXY2xramV3Z1BNTkRzU1F1NTBMVGhDV2VpdTRvRmlGZDl1V1ZHcFB4Tk1j?=
 =?utf-8?B?dUM4dmNaM3BzSTZLUDJpOGxkZExBNUc5QlZoQVRkVThHRVVkcEE3QkgvTVp5?=
 =?utf-8?Q?+SNGBrQOldcUzn/KQ0PojQizCmXHu6NAeB5LL+WgCL+B?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51DC5C5425195A46B78A851D846CE1F7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hV8b2tK8XbBTQ/BoL841szH2fo34/7Xrfz5V/zC0ZAT3wUWajJddQ0GMJ9p7HRKDfgVRfoxA3Aq4UADlWChZY7n+kMcdpo05/QQowxZ5ZUCmjY3nKmdf4zjd+3STkYYkvZHEmHl6lsQmgfS998ishdhD8fuzxlvTwEffaXfZc1cAsbXONPTR+xIIThxlzkRVO0Fao2amswkC1Ymu9LAuEIiw3XDiTztRSpztv8zo5jSiGtv8FXj8ShdRw3per76e0otEP0Gxw+iNFLUiQ+vb5GmnwHfXpp3lZ2aLzt1gefEVdFQJ3vN43xWglRjkVrvK0oYX87HeSiR1NZt8OlYMGKegjwtgDA/RLQBCMglJhaXj/i2qDKaUOhBvVJTq3jlO0uMklVU+678f+sfmY8LQvwQ6R+Oo4FWAkUGASIUk0JvywA/jLzQx0xTV5CyjrcL3sMr2GdGwfEUsFPttPSdAYcoRcLe8WfPYFNB4iU3ZIPDHNpWlsZ8NwNH9KtfymH2tQ9rF+u2cvW4OJUjJ9mvrTpZi37VgntvXui7P8fSaA54SG8A2gSbs5mHQACvEyrc70jz1Z7a8xKqXgCSeIzM9hKxPnsnebNTxjFeSlOGsAMM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6708.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bea7c0-f857-46d7-71e4-08dce40348fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 23:29:53.9619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5/BqTwPUC4nUbdHdwRnNBiWOqFEtnsPLgwhqfibH41TdefyEnyl9ihzEKczEVfdU+gLWyy1l/zjkjiP/0c8oAz9tGr/FacC2xA/aQYUFoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_19,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410030166
X-Proofpoint-ORIG-GUID: Xu3u72ctFPpOan7yrFx7mGlgxQZLozyu
X-Proofpoint-GUID: Xu3u72ctFPpOan7yrFx7mGlgxQZLozyu

DQoNCj4gT24gQXVnIDI2LCAyMDI0LCBhdCA1OjUz4oCvUE0sIEplZmYgWHUgPGplZmZ4dUBjaHJv
bWl1bS5vcmc+IHdyb3RlOg0KPiANCj4gSGkgQXJ1bmENCj4gDQo+IE9uIEZyaSwgQXVnIDksIDIw
MjQgYXQgMTA6MzDigK9BTSBKZWZmIFh1IDxqZWZmeHVAY2hyb21pdW0ub3JnPiB3cm90ZToNCj4+
IA0KPj4gT24gVGh1LCBBdWcgMSwgMjAyNCBhdCAxMToxM+KAr1BNIEFydW5hIFJhbWFrcmlzaG5h
DQo+PiA8YXJ1bmEucmFtYWtyaXNobmFAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gSWYg
dGhlIGFsdGVybmF0ZSBzaWduYWwgc3RhY2sgaXMgcHJvdGVjdGVkIGJ5IGEgZGlmZmVyZW50IHBr
ZXkgdGhhbiB0aGUNCj4+PiBjdXJyZW50IGV4ZWN1dGlvbiBzdGFjaywgY29weWluZyB4c2F2ZSBk
YXRhIHRvIHRoZSBzaWdhbHRzdGFjayB3aWxsIGZhaWwNCj4+PiBpZiBpdHMgcGtleSBpcyBub3Qg
ZW5hYmxlZCBpbiB0aGUgUEtSVSByZWdpc3Rlci4NCj4+PiANCj4+PiBXZSBkbyBub3Qga25vdyB3
aGljaCBwa2V5IHdhcyB1c2VkIGJ5IHRoZSBhcHBsaWNhdGlvbiBmb3IgdGhlIGFsdHN0YWNrLA0K
Pj4+IHNvIGVuYWJsZSBhbGwgcGtleXMgYmVmb3JlIHhzYXZlLg0KPj4+IA0KPj4+IEJ1dCB0aGlz
IHVwZGF0ZWQgUEtSVSB2YWx1ZSBpcyBhbHNvIHB1c2hlZCBvbnRvIHRoZSBzaWdmcmFtZSwgd2hp
Y2gNCj4+PiBtZWFucyB0aGUgcmVnaXN0ZXIgdmFsdWUgcmVzdG9yZWQgZnJvbSBzaWdjb250ZXh0
IHdpbGwgYmUgZGlmZmVyZW50IGZyb20NCj4+PiB0aGUgdXNlci1kZWZpbmVkIG9uZSwgd2hpY2gg
aXMgdW5leHBlY3RlZC4gRml4IHRoYXQgYnkgb3ZlcndyaXRpbmcgdGhlDQo+Pj4gUEtSVSB2YWx1
ZSBvbiB0aGUgc2lnZnJhbWUgd2l0aCB0aGUgb3JpZ2luYWwsIHVzZXItZGVmaW5lZCBQS1JVLg0K
Pj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IEFydW5hIFJhbWFrcmlzaG5hIDxhcnVuYS5yYW1ha3Jp
c2huYUBvcmFjbGUuY29tPg0KPj4+IC0tLQ0KPj4+IGFyY2gveDg2L2tlcm5lbC9mcHUvc2lnbmFs
LmMgfCAxMSArKysrKysrKystLQ0KPj4+IGFyY2gveDg2L2tlcm5lbC9zaWduYWwuYyAgICAgfCAx
MiArKysrKysrKysrLS0NCj4+PiAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9mcHUv
c2lnbmFsLmMgYi9hcmNoL3g4Ni9rZXJuZWwvZnB1L3NpZ25hbC5jDQo+Pj4gaW5kZXggOTMxYzU0
NjlkN2YzLi4xMDY1YWI5OTUzMDUgMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2Zw
dS9zaWduYWwuYw0KPj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9mcHUvc2lnbmFsLmMNCj4+PiBA
QCAtMTY4LDggKzE2OCwxNSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgc2F2ZV94c3RhdGVfZXBpbG9n
KHZvaWQgX191c2VyICpidWYsIGludCBpYTMyX2ZyYW1lLA0KPj4+IA0KPj4+IHN0YXRpYyBpbmxp
bmUgaW50IGNvcHlfZnByZWdzX3RvX3NpZ2ZyYW1lKHN0cnVjdCB4cmVnc19zdGF0ZSBfX3VzZXIg
KmJ1ZiwgdTMyIHBrcnUpDQo+Pj4gew0KPj4+IC0gICAgICAgaWYgKHVzZV94c2F2ZSgpKQ0KPj4+
IC0gICAgICAgICAgICAgICByZXR1cm4geHNhdmVfdG9fdXNlcl9zaWdmcmFtZShidWYpOw0KPj4+
ICsgICAgICAgaW50IGVyciA9IDA7DQo+Pj4gKw0KPj4+ICsgICAgICAgaWYgKHVzZV94c2F2ZSgp
KSB7DQo+Pj4gKyAgICAgICAgICAgICAgIGVyciA9IHhzYXZlX3RvX3VzZXJfc2lnZnJhbWUoYnVm
KTsNCj4+PiArICAgICAgICAgICAgICAgaWYgKCFlcnIpDQo+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgZXJyID0gdXBkYXRlX3BrcnVfaW5fc2lnZnJhbWUoYnVmLCBwa3J1KTsNCj4+PiArICAg
ICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4+PiArICAgICAgIH0NCj4+PiArDQo+Pj4gICAgICAg
IGlmICh1c2VfZnhzcigpKQ0KPj4+ICAgICAgICAgICAgICAgIHJldHVybiBmeHNhdmVfdG9fdXNl
cl9zaWdmcmFtZSgoc3RydWN0IGZ4cmVnc19zdGF0ZSBfX3VzZXIgKikgYnVmKTsNCj4+PiAgICAg
ICAgZWxzZQ0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvc2lnbmFsLmMgYi9hcmNo
L3g4Ni9rZXJuZWwvc2lnbmFsLmMNCj4+PiBpbmRleCA5ZGM3N2FkMDNhMGUuLjVmNDQxMDM5YjU3
MiAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvc2lnbmFsLmMNCj4+PiArKysgYi9h
cmNoL3g4Ni9rZXJuZWwvc2lnbmFsLmMNCj4+PiBAQCAtMTAyLDcgKzEwMiw3IEBAIGdldF9zaWdm
cmFtZShzdHJ1Y3Qga3NpZ25hbCAqa3NpZywgc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHNpemVfdCBm
cmFtZV9zaXplLA0KPj4+ICAgICAgICB1bnNpZ25lZCBsb25nIG1hdGhfc2l6ZSA9IDA7DQo+Pj4g
ICAgICAgIHVuc2lnbmVkIGxvbmcgc3AgPSByZWdzLT5zcDsNCj4+PiAgICAgICAgdW5zaWduZWQg
bG9uZyBidWZfZnggPSAwOw0KPj4+IC0gICAgICAgdTMyIHBrcnUgPSByZWFkX3BrcnUoKTsNCj4+
PiArICAgICAgIHUzMiBwa3J1Ow0KPj4+IA0KPj4+ICAgICAgICAvKiByZWR6b25lICovDQo+Pj4g
ICAgICAgIGlmICghaWEzMl9mcmFtZSkNCj4+PiBAQCAtMTU3LDkgKzE1NywxNyBAQCBnZXRfc2ln
ZnJhbWUoc3RydWN0IGtzaWduYWwgKmtzaWcsIHN0cnVjdCBwdF9yZWdzICpyZWdzLCBzaXplX3Qg
ZnJhbWVfc2l6ZSwNCj4+PiAgICAgICAgICAgICAgICByZXR1cm4gKHZvaWQgX191c2VyICopLTFM
Ow0KPj4+ICAgICAgICB9DQo+Pj4gDQo+Pj4gKyAgICAgICAvKiBVcGRhdGUgUEtSVSB0byBlbmFi
bGUgYWNjZXNzIHRvIHRoZSBhbHRlcm5hdGUgc2lnbmFsIHN0YWNrLiAqLw0KPj4+ICsgICAgICAg
cGtydSA9IHNpZ19wcmVwYXJlX3BrcnUoKTsNCj4+IEkgdGhpbmssIHRoZSBiZXR0ZXIgcGxhY2Ug
dG8gY2FsbCBzaWdfcHJlcGFyZV9wa3J1KCkgYXQgYmVnZ2luZyBvZiB0aGUNCj4+IGdldF9zaWdm
cmFtZToNCj4+IA0KPj4gZ2V0X3NpZ2ZyYW1lKCkNCj4+IHsNCj4+ICAgLyogLi4uICovDQo+PiAg
ICBpZiAoa2EtPnNhLnNhX2ZsYWdzICYgU0FfT05TVEFDSykgew0KPj4gICAgICAgICBpZiAoc2Fz
X3NzX2ZsYWdzKHNwKSA9PSAwKSB7DQo+PiAgICAgICAgICAgICAgICAvLyBzZXQgcGtydSA9IDAg
PC0tLSBzZXQgcGtydSA9IDAgaGVyZS4NCj4+ICAgICAgICAgICAgICAgIGVudGVyaW5nX2FsdHN0
YWNrID0gdHJ1ZTsNCj4+ICAgICAgICAgfQ0KPj4gfQ0KPj4gRm9yIHR3byByZWFzb25zOg0KPj4g
LSBXZSBwcm9iYWJseSBkb24ndCB3YW50IGFsbCBzaWduYWxpbmcgaGFuZGxpbmcgZ29pbmcgdGhy
b3VnaCAiUEtSVT0wIg0KPj4gLCB0aGlzIGluY2x1ZGVzIHRoZSByZWd1bGFyIHN0YWNrIGFuZCBu
ZXN0ZWQgc2lnbmFsaW5nIGhhbmRsaW5nLiBUaGUNCj4+IGJlc3QgcGxhY2UgaXMgd2hlbiAiZW50
ZXJpbmcgdGhlIGFsdHN0YWNrIi4gSUlVQywgdGhpcyBmZWF0dXJlIG9ubHkNCj4+IGVuYWJsZWQg
d2hlbiBzaWdhbHRzdGFjaygpIGlzIHVzZWQuDQo+PiAtIFRoZSB0aHJlYWQgbWlnaHQgbm90IGhh
dmUgcmVhZC1hY2Nlc3MgdG8gdGhlIGFsdHN0YWNrLCBzbyB3ZSB3aWxsDQo+PiB3YW50IHRvIG1h
a2Ugc3VyZSB0aGF0IHBrcnU9MCBpcyBzZXQgYmVmb3JlIGFueSByZWFkIHRvIHRoZSBhbHRzdGFj
ay4NCj4+IEFuZCBJSVJDLCAgZnB1X19hbGxvY19tYXRoZnJhbWUgbmVlZHMgcmVhZC1hY2Nlc3Mg
dG8gdGhlIGFsdHN0YWNrLg0KPj4gVG8gaGVscCB3aXRoIHRlc3RpbmcsIEkgd2lsbCBzZW5kIGEg
dGVzdCBjYXNlIHRvIGRlbW8gdGhlIHVzYWdlLg0KPiBBcG9sb2dpZXMsIEkgcmVtZW1iZXJlZCBp
dCB3cm9uZywgdGhlIGZwdV9fYWxsb2NfbWF0aGZyYW1lIGRvZXNuJ3QNCj4gbmVlZCByZWFkLWFj
Y2VzcyB0byBhbHRzdGFjay4NCj4gDQo+IEJ1dCBJIHRoaW5rIHRoZSBiZXN0IHBsYWNlIHRvIHNl
dCBwa3J1PTAgaXMgc3RpbGwgd2hlbiB0aGUgc3RhY2sNCj4gZW50ZXJpbmcgYWx0c3RhY2ssIGFz
IHNob3duIGFib3ZlLiB0aGUgcmVhc29uIGlzOiBUaGUgc2lnbmFsIHN0YWNrIGNhbg0KPiBiZSBu
ZXN0ZWQsIGkuZS4gdHJpZ2dlciBhbm90aGVyIHNpZ25hbGluZyBpbnNpZGUgc2lnbmFsIGhhbmRs
ZXIgYW5kIHdlDQo+IGRvbid0IG5lZWQgdG8gc2V0IHBrcnU9MCBtdWx0aXBsZSB0aW1lcyAob25s
eSB0aGUgZmlyc3QgdGltZSBlbnRlcg0KPiBzaWdhbHRzdGFjaykNCj4gDQo+PiAocGxlYXNlIGdp
dmUgbWUgc29tZXRpbWUgdG8gb3JnYW5pemUgdGhlIHRlc3QgY29kZSwgSSdtIGhvcGluZyB0byBz
ZW5kDQo+PiBvdXQgYmVmb3JlIHRoZSBlbmQgb2YgbmV4dCB3ZWVrKQ0KPj4gDQo+IHRoZSB0ZXN0
IGNvZGUgaXMgcGxhY2VkIGF0IFsxXQ0KPiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL3BlYWt0b2Ny
ZWVrL3BrZXl0ZXN0DQo+IA0KPj4gQWxzbywgY291bGQgeW91IHBsZWFzZSBjb25zaWRlciBhZGRp
bmcgYSBuZXcgZmxhZyBTU19QS0VZQUxUU1RBQ0sgKHNlZQ0KPj4gU1NfQVVUT0RJU0FSTSBmb3Ig
ZXhhbXBsZSkuIE1vc3QgZXhpc3RpbmcgYXBwcyB0aGF0IHVzZSBzaWdhbHRzdGFjaygpDQo+PiBk
b24ndCB1c2UgUEtFWSBhbmQgIGRvbid0IGNhcmUgYWJvdXQgc2V0dGluZyBQS1JVPTAsIGFuZCBk
b24ndCBuZWVkIHRvDQo+PiBvdmVyd3JpdGUgdGhlIHNpZyBmcmFtZSBhZnRlciBYU0FWRS4gIFRo
ZSBmbGFnIHdpbGwgbGltaXQgdGhlIGltcGFjdA0KPj4gb2YgdGhpcyBwYXRjaC4NCj4+IA0KPiBU
aGFua3MNCj4gLUplZmYNCj4gDQoNCkhpIEplZmYsDQoNCkkgYXBvbG9naXplIGZvciB0aGUgZGVs
YXkgaW4gbXkgcmVzcG9uc2UuIEkgaGF2ZW7igJl0IGhhZCBhIGNoYW5jZSB0byBvcHRpbWl6ZQ0K
dGhpcyBwYXRjaHNldCBvciB0cnkgbmV3IHRlc3QgY2FzZXMuDQoNCkkgYWdyZWUgd2l0aCB5b3Vy
IGZpcnN0IHN1Z2dlc3Rpb24gdGhhdCB3ZSBjYW4gc2V0IHBrcnUgdG8gMCBvbmx5IHdoZW4NCmVu
dGVyaW5nX2FsdHN0YWNrID0gdHJ1ZSwgYXMgdGhhdCBpcyB0aGUgaW50ZW50aW9uIG9mIHRoaXMg
ZmxvdyBhbnl3YXkuDQoNCknigJltIG5vdCBzbyBzdXJlIGlmIFNTX1BLRVlBTFRTVEFDSyBpcyBy
ZWFsbHkgbmVjZXNzYXJ5IC0gdGhlb3JldGljYWxseSBpdCBzZWVtcw0KbG9naWNhbCB0byBub3Qg
ZG8gdGhpcyBmb3IgYXBwbGljYXRpb25zIHRoYXQgZG8gbm90IHVzZSBwa2V5cyBidXQgdXNlIGFs
dHN0YWNrLCBidXQNCml0IGFkZHMgZXh0cmEgY29kZS9jaGVja3MgZm9yIHBvc3NpYmx5IGluc2ln
bmlmaWNhbnQgcGVyZm9ybWFuY2UgZ2Fpbi4gSSBoYXZlIG5vdA0KdGVzdGVkIHRoaXMgeWV0Lg0K
DQpJ4oCZbGwgdHJ5IHRvIHJldGVzdCBhbmQgc2VuZCBvdXQgYSBuZXcgcGF0Y2hzZXQgb24gdG9w
IG9mIHRoZSBwcmV2aW91cyBvbmVzIHRoYXQgaGF2ZQ0KYmVlbiBtZXJnZWQgdG8gNi4xMi4NCg0K
VGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrLCBhbmQgeW91ciBhdHRlbnRpb24gdG8gZGV0YWls
IC0gSSBhcHByZWNpYXRlIGl0Lg0KDQpUaGFua3MsDQpBcnVuYQ0KDQoNCg==

