Return-Path: <linux-kernel+bounces-173585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C908C0271
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253651F24ED3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAFF46B5;
	Wed,  8 May 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f82w9eFQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g/HfWwfr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BBE1A2C2D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187643; cv=fail; b=VnySWt9oF9UMZPbiRnSvGgJrBmOuPi7gkfF+s3THPUAHzYLVV1sN8VRNio/OuVA4V3MuK9TqTCGKY2z8tRwz5nagTfdCONnSA/0pQOYHD7BC7HrkcM+9p8eh65djpfqTZEUMnWgK8+E51oamp4VJ8pBDbr0DxmxEDvf371xbRVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187643; c=relaxed/simple;
	bh=OkuJRGbVQVNVnEGwLttGH/9iJGI2sefB9j1Ru1CzJjQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D5DGNH/5NKWdiPTPzfbCfd851Q2jcs0DO5maTo9xtgiyKHGAJk223OC7ZGw0cIDmGPDbLWrhF4HY0At/OQC7vpp+fBzLfdl1altBZiw22pDSnIGMnc4lJX8Atj9xhrDlQjHKGKedOxfZyjU/nZQhzgqb4W6DP4E9TI/Kst5Jm60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f82w9eFQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g/HfWwfr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448CPNVT004123;
	Wed, 8 May 2024 17:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OkuJRGbVQVNVnEGwLttGH/9iJGI2sefB9j1Ru1CzJjQ=;
 b=f82w9eFQs8AkWUh0NQk51IuFXoEFb5/pTAStOgXmmEYRHafgU7xfLAD1IOzKQkJVc1dQ
 o1Ny9qzhHY1btVqgvElZXYjuISiWin4cQiDx584lmGU2XGNkeF8lTJL52eaijtvDWprw
 qgrVuviX24DmgZuioPzGvn+ve3FH1iMO6ic/m1aX/hZ5Of9UakEbc+gvhDxWKPEN8jXo
 A8/JnEFW/rMm3Clfk6XIJc3UaWfHp2U3ptpImFhH31TgQPfUPSX4R8HoHBN0SHofJDxD
 OSGI5FWCDSp0Me52w5+tK2pt0+wYWm7LuXgBVxyzcp75g4ksW8d0VlEkq1Nrgpx2cIhm 8Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfv29qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 17:00:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 448FZw38019868;
	Wed, 8 May 2024 17:00:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfkwred-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 17:00:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHayyOzZeHmkZU0Tkh6Ldj/js8XRppjUyC5EV9BzYLtIQ+Ns48yjtG+lDY/o/ZSSUc3Tc545K3GZidGLW/tU0jggtcqU9SEpDZuvagBZ1wONC2fHp2kXPCl5/ASGoRxoL26zDjS0DcFTdY4LzjFHyfugGaS/Qbi/y9cTJlV19kpN29feHCi4dy9nr5IH55b/VjJqvcnTwkuCS11Onkwa4/6Cq3Jh3PDNUKKBxw4pEwNCPLoen4OLgW4Sl2+s8vWHUhyojtaoWvpp5olfFSUBZ0rj7Bsl9xHvSXiPuZBH6/k13ZrLROpdFgJSBzTI4lylfCtZ77oMgWfRMj9P210Kgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkuJRGbVQVNVnEGwLttGH/9iJGI2sefB9j1Ru1CzJjQ=;
 b=Q8icFfXMCx0+r7p4RpoofVlji6NXW/yNG94WdpJqpKyCR4mpuRXOX2Ga+rzWDH6hM3tqNxbqR/D252eKAYvd8TvcAdXZbGOw4pG4GxgMmzMK/8ELbxwwXWAJgsMECb/rJ7muH/LrkpTlzgt9fm+O9qgKd+UCrHNGURcbgPZXJ24WYh58rM7DWDeKOR8yWvatpfjoc9mOGTWii3P4tafwi9PIVPx4ZVJm8G1Zs8bqXxi0vtTXZEag9KVigBO4s7UoV/HZqcHsdQwnVtCszLOfPoiNW9Oxy/b6GetNz1mY2ZbV7DFuPlzJ9BykOqTvj6hYZ7e1Y7mo7Ok0XvbX2OC2hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkuJRGbVQVNVnEGwLttGH/9iJGI2sefB9j1Ru1CzJjQ=;
 b=g/HfWwfrDLGz14EhKYDYzWD3PQmfwGI/NIX38NSFhyy6IcxI9VUWCT/6QOU3IJcD2GSfGOKPbkDmV0ev+Kt1WueCpDhL/fLG8En5cwCBi8qIislImUTNsVLcBPH1+bYAxguyGYyhM+ghZA37od6yRA/h8Xn59wmVCyT1+hLd080=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by BLAPR10MB5089.namprd10.prod.outlook.com (2603:10b6:208:330::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 17:00:00 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::e826:67e0:4e6b:51e9]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::e826:67e0:4e6b:51e9%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 17:00:00 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: David Hildenbrand <david@redhat.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "muchun.song@linux.dev"
	<muchun.song@linux.dev>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [RFC PATCH 0/1] Address hugetlbfs mmap behavior
Thread-Topic: [RFC PATCH 0/1] Address hugetlbfs mmap behavior
Thread-Index: AQHanPaLSH3Q8HWEDE6RoHi6GjNJRrGLsmaAgAHl8wA=
Date: Wed, 8 May 2024 17:00:00 +0000
Message-ID: <0C0831EB-AA56-49C9-9D92-460C0FFF9BB5@oracle.com>
References: <1714699270-7360-1-git-send-email-prakash.sangappa@oracle.com>
 <901d53f0-1cbf-436e-8ccb-875680dbc1d5@redhat.com>
In-Reply-To: <901d53f0-1cbf-436e-8ccb-875680dbc1d5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|BLAPR10MB5089:EE_
x-ms-office365-filtering-correlation-id: 1c55da71-e95b-4375-d6a3-08dc6f804c1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MW9tSFYxV3ZRRW82V2FyeHhPN0E4bmJLSWZoYjdDRzVXaXlqVGZVRGdDWFAy?=
 =?utf-8?B?b3QrZ3pocnJWaUJkUzBwVkJBYm5ST3NJd3dlakd4aXEyMkt1TzF0cmtzbjdL?=
 =?utf-8?B?NFovRFN6Qjg0SzZ6U0VMbTg3YTBPNDE1Z1ZTN2ExMUxmRHM3N0lVMEdiVzVx?=
 =?utf-8?B?MUJId21tU0QzWEFuUEx4YklzNHVjRDFQOUJVYkdHTGllcUtQQ2RWaTlKby9Z?=
 =?utf-8?B?VmpzTFptR3d6bHVtMEtvdGZyWk1OV1lxeGpqd3grTWJlSGd0aEVqK3N2Y2ZN?=
 =?utf-8?B?U1k4NkpzNENTMnhUS3ZJSEFkVzhCMWVaMlArSTVRdWhaa2s5d21xckVha3pa?=
 =?utf-8?B?SFhmQTlqMy9kYzA2a3VMTXJHN2hHU3Nsc3I1N1BrWS9nWGFDNCtwZFdaaUdQ?=
 =?utf-8?B?aHNCWStJZ1Q0aHNGUncwb2grMGZScmFHMmVMRkFOZjlBOTZ1bjF6SmRWZCtW?=
 =?utf-8?B?QUhlK3k0NmJ4RllWTFRVRnpWeUN3QndYVlcxSjhMRnFxUDBieEtreHNlMEYv?=
 =?utf-8?B?MS9CTUZNTTI3TXJLNEpnMDNORzVqOHpRNE1xRXplWVYzNlFRRGwxbWdWbmF5?=
 =?utf-8?B?bWNzNm5EclRGRk5qa2YvdXRBVUhMZU1rQ25EakdNNmhqemt5SWo0OGFrWU5P?=
 =?utf-8?B?aWxxdkRkbkY5TklJaGJ4c1h4cGdIUG4vRnIrUlhvZVFxM3FEb2FCUnk0VWhr?=
 =?utf-8?B?OCtJSVZYbmx3a0NKYms4NHYvRVU5N2s4VXhUVVVHc09pQnR5UG03c0wzREJH?=
 =?utf-8?B?bzU1TWErRFJmMXcrUzVKbFhxdVE5ZGFaaWRCRVNwa3BpU3NpUXRpQ29vN0cw?=
 =?utf-8?B?MnQwQWNMamxrcG1ESlRLamxTOFExNFVxd2R3Rzg4MzNTajNSUnlCWnVNL2ho?=
 =?utf-8?B?bTdkdVRGblZwUG9HVmpUZWNoNVFybXdScG1CUFN6V2pnbkFQUHYwSmFNd3p3?=
 =?utf-8?B?cHdTMWFvZ2ZUWXI2bWN0OFR2QXhIUTEvbEswSTRhVTkyWll1eWFObGRVMlcz?=
 =?utf-8?B?Vm9OQzNyRnJFcy9WZkVXdlEvYXFqcW0yOGNIbWozTVFEWGx3elgremRaUWg1?=
 =?utf-8?B?REhxQWlZbHI5Vk16elN5cnlHVXlWcUt5emk1QjJpcHBudk4ydEkva3ZZQlg1?=
 =?utf-8?B?eWdqVUl4ZjR0ZkJMaTZrck9VZUFvLzMzVkp2V3Z3SWxISENFOWV6cHhqSzdO?=
 =?utf-8?B?RkNsdlZ2aHZZU1F1SkM2R1JPZm1oVGNQdWJ6Y3IzL2tsbkIydnA4Y29kMzNI?=
 =?utf-8?B?U3hCRFlOaHhFbHhRWi9vb2NyLzA4aFB3aUxwcnc3eVdzOFdLcGFlMStPL1pL?=
 =?utf-8?B?eERVOEhBUXRLcDQ3cVV0Wm9NeHY1Ty9CSGZFNTRhN3lMTkptRGY0UGxielUy?=
 =?utf-8?B?MFZzVzd1ZlpOOU9QMS9FQmsybDJUdis5ZjJLcVhnSTh2UG9wWlFzZkFadWdD?=
 =?utf-8?B?dWsrbjFmZmhGVklxQU9mS0V0L00yUlkzbUJNM0Q4TmQ1VTdLcVFPY1duOXE5?=
 =?utf-8?B?NmFFNFhnN3E2bzJrZHkwYXRxL0RqWHk3ZEVCNStKdnVXVnhvOGE3OUp2MHlK?=
 =?utf-8?B?c0xqcFBnVE5JRDVlZTVBR0FhL3dGTUJGRkxyTy8zMkxwZ2E0dHUxQjF4Uk1x?=
 =?utf-8?B?MkpxVjIwL21EYmo5U2dnWGVnbFBBZzVmNSszcFlMUXBsd2RCRXM1MHNFa1g0?=
 =?utf-8?B?THZmaWhZZzBmN1JsUTFoZ3AyRXkvRTFyekFReWtWL09xV1pKaUQ5RGJGMDdX?=
 =?utf-8?B?MDk0eDdIZ3R2YWRyK0dqcFBaVXo3dkY3c3lwZUpYQXpKd2k1RXFOWWo5L3Nu?=
 =?utf-8?B?Mm9DQU1pWnl5TE5kbXdlQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Y1AxMW1OZHpUVzJwODNVVEJwcU5TdThmTkdoTUY5Ylg5SHQxTCtsYi9UQ3lN?=
 =?utf-8?B?dmQ4Q1JPc2RPU0VqYUROSHBQdE8veklDU1IwakhaU1hoLzRWM2lLd1EyMnBS?=
 =?utf-8?B?ZE9ER0pnTW8xUDZvTHJ6UUsrZ1dvcmMwV2JGZlRPZGdvWkR5TlVoYkVqaXdw?=
 =?utf-8?B?ZXBlVGU5cnk2aUFYQ1grd0NCZ1paSzFnMmIxQVNzRGxkS1JtTHlhWkZpUjFE?=
 =?utf-8?B?S0dpdVVoQi9SeUhPTjA5VnMvSytqMzlwWDc4dEhXZ2paaU1VeUZzYkEzRmNi?=
 =?utf-8?B?UmZpLzRKSEF5Nk4xVUdYcnR1WUVhVG5HY0xqOU92MkhEU1NNU29OaU1IT3gy?=
 =?utf-8?B?SWZJU3J0RVNxaDkycHRpcHl1a3JiM0dyME85aFZrblErRjMvUnhZYkxmZS9t?=
 =?utf-8?B?TFFGY2tGcm1BUWxxU0YyRmtIY2k5NHZDbWJiQkhwYkRZYURwM3JTdnZPcmRC?=
 =?utf-8?B?bG5VQXJuMStuSk1ZbldLZ3FIZmRTQkJSZkJ2NHlEY2t4SUkzMVZza1lCa1Bn?=
 =?utf-8?B?WlJBVDNyMTk3a3ZOV2pLb1FsZm1BL2pNRnJRak9wWktiYmEzdE9oZjJWanpE?=
 =?utf-8?B?aDc3M2s5ejFEKzVTRjl1WlQ2emJGOWdUSXFUYmp5ZWQvakJHZGhtRTd5NFRR?=
 =?utf-8?B?Q2JaNHhQWUpheWg1cnNtL1RwRTRNdko4SVNQM1FkaUxUWEE3WDhNYlhDT1pk?=
 =?utf-8?B?dU05bmVNdlFETFd4TnduMlB5U2JPWFlXT05mN0luVUdzUENDTk13emRvNHpI?=
 =?utf-8?B?Y3JBUDB1dWxyRFI3L0szdThKRXRjeDU1ZnVxZXlxS1FEWVZuWWxoeFQzSjlV?=
 =?utf-8?B?dVBsYTU0RlZlcHNIMlVab0tDMmlSeDVETkxtdUlERVd6cDRWYVFNY1ZZOTBC?=
 =?utf-8?B?ZFB2ZFJqSGovWW53Uk9OeFhGa2t4Qk9scWdibWNxRlBROHFraEtBT0NJSzJY?=
 =?utf-8?B?M2RadUU1SWs3Qkk0ZzVvUjQxN1IrdGcya3l0SnpXQUdzWWc1bDdUZEIyRjFp?=
 =?utf-8?B?ZjAzOTVDY1JyclhPQ2VJM2x4QmpUMThLZk5sOGZldUNYY1hiN21HSHYvd0xh?=
 =?utf-8?B?bDF1NGFXVlFmS2FXZnZMT096cjM4a2FMek0vY2EzOUxZcjlxc3psQklBdjVu?=
 =?utf-8?B?dVpxTTQ5TzhoUmR4a2JkTENoSWZsVG9UTytMZXgybG8wL1VEdE0yVUhXVnQv?=
 =?utf-8?B?RFNhS1hWY2tBcUQ3cTZ0eGg5QTNBN1QrYWhxMTlkSFdLWU8ycks2bS9LeHMy?=
 =?utf-8?B?bUxhK24xZmRhVWlzT201Yi91Nld0dTh2Y2RhR0svdUlKSWJOSU04KzhObVoy?=
 =?utf-8?B?QXVad2drdVV6WXRXQ3R0ak8vQisrRFkxUXVOamdHL1VvL1BSa2Vwblp4cUMv?=
 =?utf-8?B?NTR1RzFORmlPNGlhSzlpTHdCTWN6Z0hMdGFkZkJBQUVCeU1oKzRDSnpGV1hF?=
 =?utf-8?B?aHJZUEdyRXRtVk0zOEV2c3BDYVI2Tys4eEFaNWtndWkwd1p0R1BTV1BWbGZU?=
 =?utf-8?B?V09rT1ovNXFnVHNwVHlNRTJ1d1NybExuUzdrUzFBODJjS0JYT2Jnc1hzR1VL?=
 =?utf-8?B?eU5CYjV0STJjQStQQzhSSjdiNGpNRTNvcUNmTWFIMEw3QVo1a05XSW9NL3kx?=
 =?utf-8?B?b2JtSEo1NDh5Q1RBTkl3dWoxMTdxZW5JZVFTcTZ1K2EvS3dFb1BDVkhwaURp?=
 =?utf-8?B?UW9IaEExREpuTVhVQzVvdDAwWHp2WEV6ZC9NVXlpcGhwdGIxWld2cGZQdTVB?=
 =?utf-8?B?NXY0cGQ4L3RueU1IU2p2cGFWWGNkQTJZdTZJclU5dVozWWZqem5jbGpwZ2d5?=
 =?utf-8?B?NUNJUENVRDNjRGdZRERUNHViWWViUzllWGRmanNNOEdWSUZNZEcvWmV6dm5y?=
 =?utf-8?B?bGpNZTlGb1N2aVpwVWY3Ui9Tak1Lb08ra2w3TzBUa2NyMVk3VFMvWE1HOW9o?=
 =?utf-8?B?Z0FpSVBUQmNjemQ1WGpycW44Tm9yVGpaeWtleHFNZWlYSkNMd1BZdTdwWjhW?=
 =?utf-8?B?MVZaMEZMRWROWC9zTHdpNzgvaVhsaXk4ekJuVFh2alFsc2dZc0pDaFY3cFZk?=
 =?utf-8?B?eHVlZXlhYnFhVk9LUVEyc3loVU5qVHd1VjUzSmxqbkpvTXdsYWVHelBiNThn?=
 =?utf-8?B?U095OExBS2U0S09KdEUzMER3UHpBd3VGcW5mczc1b1M2eFN3dXhRWW16Mk5i?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <686E8CB0070BA44AB87FCC870AF093FB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	K2vI9pIS+iKDYDw3FQJnegwFBhJj+NitKwhssNenSyhgdhF+RhYLVjODVBIVChOYLdWSf+6bnmI3Q3DxSZ42DTQjnsuKOfjNAgYAQ7b27gUT47eYA7m+38nPtcR+zC9Yn++gq1RxnKDBy0ZHEmJX0unaoXBA0771Io0YJpWO+htup5WSEq8llvOeLVzlxUx3pq5GPVZp3G1stQzUWepfrdYsF7rKAQRW+AIad+P25y2YOTKZN2ymT0W8+SFnCRdua4NDouOJWXS/O7yItkNGNn9VeQ808QlcvtUjsM3bhbvnRxKFJDeXaPwNwUGzrvR0yqRKBJeoeAB5egy+fkXrwe0C/T9Hst7qgGw04De5/gVzvPyxIeHbZQ7Vu+PQI7ABQ0jdPGmlGgaBX6yhUvzxBdsbTKqF/VR8DbjCy8qN2lKteQoYpFh6miIYz+kL2kMkU0luXujFeLhqLRuq/is/EhEOT0R+k6Dh/5Hu2Vzc5Sh5ISQnGDB/ptLaCLfUCt6TRSeW6uimbTqdriQYqJ/YhpcsX/mWqU3D0ZfM/cgUvhTIE+SZNdaC5zcjt+9j55kXtcBkWUcTWQTU7HpzNL9RyjPQ3ToUvZ6DD774h9661bA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c55da71-e95b-4375-d6a3-08dc6f804c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 17:00:00.2721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxEdcmM8cXr6rq6cY63idgMU8LQcjDQVFRHEOTnKCcKYI++dHPvL1NjV5z8XRXpAyTKLeXjWQim5P5N0EA5u3VwUUXaPKmSNhvZQzlNxHvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080123
X-Proofpoint-GUID: 6WJFc2tRTEvjxizhzaHlIAVSHRSrYEoQ
X-Proofpoint-ORIG-GUID: 6WJFc2tRTEvjxizhzaHlIAVSHRSrYEoQ

DQoNCj4gT24gTWF5IDcsIDIwMjQsIGF0IDU6MDDigK9BTSwgRGF2aWQgSGlsZGVuYnJhbmQgPGRh
dmlkQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gMDMuMDUuMjQgMDM6MjEsIFByYWthc2gg
U2FuZ2FwcGEgd3JvdGU6DQo+PiBUaGlzIHBhdGNoIHByb3Bvc2VzIHRvIGZpeCBodWdldGxiZnMg
bW1hcCBiZWhhdmlvciBzbyB0aGF0IHRoZQ0KPj4gZmlsZSBzaXplIGRvZXMgbm90IGdldCB1cGRh
dGVkIGluIHRoZSBtbWFwIGNhbGwuDQo+PiBUaGUgY3VycmVudCBiZWhhdmlvciBpcyB0aGF0IGh1
Z2V0bGJmcyBmaWxlIHNpemUgd2lsbCBnZXQgZXh0ZW5kZWQgYnkgYQ0KPj4gUFJPVF9XUklURSBt
bWFwKDIpIGNhbGwgaWYgbW1hcCBzaXplIGlzIGdyZWF0ZXIgdGhlbiBmaWxlIHNpemUuIFRoaXMg
aXMNCj4+IG5vdCBub3JtYWwgZmlsZXN5c3RlbSBiZWhhdmlvci4NCj4+IFRoZXJlIHNlZW0gdG8g
aGF2ZSBiZWVuIHZlcnkgbGl0dGxlIGRpc2N1c3Npb24gYWJvdXQgdGhpcy4gVGhlcmUgd2FzIGEN
Cj4+IHBhdGNoIGRpc2N1c3Npb25bMV0gYSB3aGlsZSBiYWNrLCBpbXBseWluZyBodWdldGxiZnMg
ZmlsZSBzaXplIG5lZWRzDQo+PiBleHRlbmRpbmcgYmVjYXVzZSBvZiB0aGUgaHVnZXRsYiBwYWdl
IHJlc2VydmF0aW9ucy4gTG9va3MgbGlrZSB0aGlzIHdhcw0KPj4gbm90IG1lcmdlZC4NCj4+IEl0
IGFwcGVhcnMgdGhlcmUgaXMgbm8gY29ycmVsYXRpb24gYmV0d2VlbiBmaWxlIHNpemUgYW5kIGh1
Z2V0bGIgcGFnZQ0KPj4gcmVzZXJ2YXRpb25zLiBUYWtlIHRoZSBjYXNlIG9mIFBST1RfUkVBRCBt
bWFwLCB3aGVyZSB0aGUgZmlsZSBzaXplIGlzDQo+PiBub3QgZXh0ZW5kZWQgZXZlbiB0aG91Z2gg
aHVnZXRsYiBwYWdlcyBhcmUgcmVzZXJ2ZWQuDQo+PiBPbiB0aGUgb3RoZXIgaGFuZCBmdHJ1bmNh
dGUoMikgdG8gaW5jcmVhc2UgYSBmaWxlIHNpemUgZG9lcyBub3QgcmVzZXJ2ZQ0KPj4gaHVnZXRs
YiBwYWdlcy4gQWxzbywgbW1hcCB3aXRoIE1BUF9OT1JFU0VSVkUgZmxhZyBleHRlbmRzIHRoZSBm
aWxlIHNpemUNCj4+IGV2ZW4gdGhvdWdoIGh1Z2V0bGIgcGFnZXMgYXJlIG5vdCByZXNlcnZlZC4N
Cj4+IEh1Z2V0bGIgcGFnZXMgZ2V0IHJlc2VydmVkKGlmIE1BUF9OT1JFU0VSVkUgaXMgbm90IHNw
ZWNpZmllZCkgd2hlbiB0aGUNCj4+IGh1Z2VsdGJmcyBmaWxlIGlzIG1tYXBwZWQsIGFuZCBpdCBv
bmx5IGNvdmVycyB0aGUgZmlsZSdzIG9mZnNldCxsZW5ndGgNCj4+IHJhbmdlIHNwZWNpZmllZCBp
biB0aGUgbW1hcCBjYWxsLg0KPj4gSXNzdWU6DQo+PiBTb21lIGFwcGxpY2F0aW9ucyB3b3VsZCBw
cmVmZXIgdG8gbWFuYWdlIGh1Z2V0bGIgcGFnZSBhbGxvY2F0aW9ucyBleHBsaWNpdHkNCj4+IHdp
dGggdXNlIG9mIGZhbGxvY2F0ZSgyKS4gVGhlIGh1Z2V0bGJmcyBmaWxlIHdvdWxkIGJlIFBST1Rf
V1JJVEUgbWFwcGVkIHdpdGgNCj4+IE1BUF9OT1JFU0VSVkUgZmxhZywgd2hpY2ggaXMgYWNjZXNz
ZWQgb25seSBhZnRlciBhbGxvY2F0aW5nIG5lY2Vzc2FyeSBwYWdlcw0KPj4gdXNpbmcgZmFsbG9j
YXRlKDIpIGFuZCByZWxlYXNlIHRoZSBwYWdlcyBieSB0cnVuY2F0aW5nIHRoZSBmaWxlIHNpemUu
IEFueSBzdHJheQ0KPj4gYWNjZXNzIGJleW9uZCBmaWxlIHNpemUgaXMgZXhwZWN0ZWQgdG8gZ2Vu
ZXJhdGUgYSBzaWduYWwuIFRoaXMgZG9lcyBub3QNCj4+IHdvcmsgcHJvcGVybHkgZHVlIHRvIGN1
cnJlbnQgYmVoYXZpb3Igd2hpY2ggZXh0ZW5kcyBmaWxlIHNpemUgaW4gbW1hcCBjYWxsLg0KPiAN
Cj4gV291bGQgYSBzaW1wbGUgd29ya2Fyb3VuZCBiZSB0byBtbWFwKFBST1RfUkVBRCkgYW5kIHRo
ZW4gbXByb3RlY3QoUFJPVF9SRUFEfFBST1RfV1JJVEUpPw0KDQpBbm90aGVyIHdvcmthcm91bmQg
Y291bGQgYmUgdG8gZnRydW5jYXRlKDIpIHRoZSBmaWxlIGFmdGVyICBtbWFwKFBST1RfUkVBRHxQ
Uk9UX1dSSVRFKSwgaWYgTUFQX05PUkVTRVJWRSBpcyB1c2VkLiBCdXQgdGhlc2Ugd2lsbCByZXF1
aXJlIGFwcGxpY2F0aW9uIGNoYW5nZXMgYXMgYSBzcGVjaWFsIGNhc2UgZm9yIGh1Z2V0bGJmcyB0
aGF0IGNhbiBiZSBjb25zaWRlcmVkLiANCg0KSG93ZXZlciwgc2hvdWxkIHRoaXMgbW1hcCBiZWhh
dmlvciAgYmUgYWRkcmVzc2VkPyBXaHkgbW1hcChQUk9UX1dSSVRFKSBoYXMgdG8gZXh0ZW5kIHRo
ZSBmaWxlIHNpemUgbmVlZHMgY2xhcmlmaWNhdGlvbi4gDQoNClRoYW5rcywNCi1QcmFrYXNoIA0K
DQo+IA0KPiBJIGtub3csIG5vdCBwZXJmZWN0LCBidXQgY2VydGFpbmx5IGJldHRlciB0aGFuIG1v
dW50IG9wdGlvbnM/DQo+IA0KPiAtLSANCj4gQ2hlZXJzLA0KPiANCj4gRGF2aWQgLyBkaGlsZGVu
Yg0KDQoNCg==

