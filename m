Return-Path: <linux-kernel+bounces-408238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D655A9C7C75
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9639328854D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678B8206040;
	Wed, 13 Nov 2024 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rxykpc0u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fbf0ORii"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0386204096
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527804; cv=fail; b=O1bJrfrRhFn/qTQuwGFa2lpUOdFfygzREOs8UkdmEQzD8iq3pvQV6Bu5BUAgBye3peYN5i0u3Gg4ly0Ea1jVZgfaZztONf5NOEXJgmtQpTAghNCSSooWvK8cQOuF0qA+s0BbEoXiHndhHRx0/aQl0Qv94RP2UQF7wayorYIZVf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527804; c=relaxed/simple;
	bh=gsOg3x5yCsgTAVIEN26ObVM3Dgouy5ayG8VYssqO61Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ij5k5X3ZPRFqMfjf+/axsoo4HkC023/W0cBtk19E4L2alAI4JTeVPNydS359Fbs5zAtktgGBZFOcmtSzAO58oO04ZTUF42EqX28exfO3ZiJuSfWuOEuJY1+ylRlGTgcXZSVTr0pIQ1WWyAu9JbfWyljTJO1yQd/maMbFQhEk5Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rxykpc0u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fbf0ORii; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIBeOo007656;
	Wed, 13 Nov 2024 19:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gsOg3x5yCsgTAVIEN26ObVM3Dgouy5ayG8VYssqO61Q=; b=
	Rxykpc0ufFbkPc9b5d+Va0GSczGGxJwbzeR62qhj4X0CZjDohEY7SxW2dgXUoDXz
	Z1MCDv1m0l+/HIatDERjZs9sAU+Fgks2xZhJ9AmI91b1pXzWv0BQFgyzZf9vJNln
	CTi3ur6qfDyFCmfimF4+hJCqmom5LBFMx7LNZECUF9wonzKkzs0Q73IpZ8y2ZwMl
	yjcYg9fXR3AoiQ5V3R905H8FP3lzu4xY61/MM5STgumLNyRVfrF4w+t+ISICkCk3
	2v82GlHtYEjmA1/+Z08z9Iv5zpm5kvjwm5ONSWGntjm+dK7LNBE7rJpb8S0lJI70
	r3AWnvdnc4Q64WOagv7XNQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n4yqnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 19:56:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIabjU025962;
	Wed, 13 Nov 2024 19:56:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69tfr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 19:56:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVn2Xkj+oPb53wmyBRtcNaRCtL56zpNwhvvlhwP4Z5QzcOwuDpXO2i8uQSwI55Lch3Jv61r9M1o6AqcdKFXCzFtvcsjJMcB0itlMO4YkXlYOIzcM/C9nylEDo2WDb1RqnuSYdE1pqNBtnk7hwiqXyS4diSWEqNqJtRfROA21GOviRX4wNFw2Bd5gbF4NWUpjTCyn1fm/VN9DsAhP8VM1POJKzgWl7BH90zsp0dGK0uZ0U2Pot1gkCYMk5dUDbNSdF+XQPggwEzIcieofxUKbk/66kbnn/n8fiLvWtWqDh9u710CljN4TrMiBE1nL22GyVfLV9tHcr+4cvsil8AMZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsOg3x5yCsgTAVIEN26ObVM3Dgouy5ayG8VYssqO61Q=;
 b=YWv0uULv17HG2UjeBMre7NeS1agmwsgLs8M+Kco4kf8A25RnLF3LB8MkLH/PWVFCbOW2DEz+LXDoJalX9Abq+JCszD/J+qos+MkJk2oX5FtvOzcTH/dTUwyWepbiLBtSm6Y0RkJL7GFjTG49rQ4JeozmvQ5ym2nefu+aOZElz+qDAQ2uLXJ0W15vNONkrsm2ZyOn4qqpLST/y0j+mQ6py3dXyHHFANnvCbrULyn8vRwkq0gl4nRPMcHLFw1njX4rHd19Z2Lv3MBAb38wms8GXm++rZWlLDXRFDbadLH1dRl1u8RUpvzjAVlREH059gwMzeznztbIiD0ier2xAhL1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsOg3x5yCsgTAVIEN26ObVM3Dgouy5ayG8VYssqO61Q=;
 b=fbf0ORiiKu/yCVCJ+btWM1DpZv2N3oTjDXo14WXGkNrtxJgR5hOMDkmrZneAmJhdrj96DjX7DLmb6/DqnyOiJVTZI0ErDpTpc4pEaJziS4Q3pr2OooVcjCf0wzOkDPGQIVO/DRuVrRRGzEOUDxUT8aN5RbJusWdRNH1JwknuHhk=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by MW4PR10MB6299.namprd10.prod.outlook.com (2603:10b6:303:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Wed, 13 Nov
 2024 19:56:12 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 19:56:12 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org"
	<peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Daniel
 Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Topic: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Index: AQHbNV85xP8mG8bGMUONwn7IqXYau7K0sxIAgADuUIA=
Date: Wed, 13 Nov 2024 19:56:12 +0000
Message-ID: <008AE921-4D24-44B4-9244-814D65FC3416@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <a8b828bb-7e8d-1f57-3c9a-3c4e65a185b8@amd.com>
In-Reply-To: <a8b828bb-7e8d-1f57-3c9a-3c4e65a185b8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|MW4PR10MB6299:EE_
x-ms-office365-filtering-correlation-id: c643905d-0180-47f3-9425-08dd041d39a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?azJyYkpib050Yk9qM3l4aUxTSFMya2tQajVBVGcwY3FBMTJLb205aVBvdjRa?=
 =?utf-8?B?SlRTWTBnUWY0clhmMUgrWGNUQUkvWkg2NGdtQTV1OFJZeEovS0pTSnhyWG1Z?=
 =?utf-8?B?MjBKUEhGOHpnTUJzb2NET0xRMndtVklRSWpReXI3dVlQUlQ3OTMyQzRucW53?=
 =?utf-8?B?ckhqMFRnOTlhQnZxZ1lSTXVqdzdERVczUmpsYmVCdGFqTmc4MnBDZFJtOG9n?=
 =?utf-8?B?Yzd6WTRleHBUTzlUcnN1RnE0b2VBU2tGRnJTTDgyRnpQRERmWU9FQzBMaWli?=
 =?utf-8?B?Smg1M2JEUitHa3ZMM1BHenA0bXFPNFFHakNJMnBId1o4cmxCdDU3YnlXWCt3?=
 =?utf-8?B?VVJoQmdlc0xHOC91VFplbWlKd0lheGZrSjdMTzNCcCt2K2JnZmxwdWRGd3Q1?=
 =?utf-8?B?ZEpnaTREcklyUWd3Qk5ydFZNRC9wRTdLSEFLaGFUS05OQ2hZY3VyTVgyTzlC?=
 =?utf-8?B?TWpIeVM1UnBvM3owbGQxMytsRlcrbGc3bHVqZXhZTmF6WnR4YUl5YXFMWjV0?=
 =?utf-8?B?UWFjL2hDUnVWaGZweTJxYmNjay82U0ZVVVFvQmZtYWFDVkZ4dFZiQmJGdlp2?=
 =?utf-8?B?UWY4cjR4MXJPbmIwbmNhcTFPMmtXRHg2YXIwWXpwWFdtclFUTEdRYnpidksw?=
 =?utf-8?B?ZERyYmdOWE1OYXVJVE5PUm95TURXYkFwMlZZNk05ZkRiZW1LRS9UZVBKditW?=
 =?utf-8?B?bEZGS2doOTVRRFJOQVlGUEhDbldBcW5DOU1mckRnbUdXQ3d4N3BJbno3YVpX?=
 =?utf-8?B?Ukx2K2V5VmVPbk12eUwzQ091eHY0VjJ6NlZrRUs0T2ZzczBBck1nUTFETmV1?=
 =?utf-8?B?MDBmRHljUXhUY2tGaWhmdVZFczdoOG8yZThycDlYYTBvTHZBZ2NyUzZtM0h3?=
 =?utf-8?B?MWVBeFhnRG9wR1hzcHFaSkxvdzlzMHJUbFpBSGdQZ2YwczBYSmY2Wmw4THgr?=
 =?utf-8?B?MFBKQ0tuZ3l1THA4UEptbng3S1VtbmpiMkRqWGFRL0k1M0hocVQreThSL28y?=
 =?utf-8?B?a2E3RTdsZTNXcThXVGpBUjhkYUFGTDFHZTdTYWhlb2dpeGNYUStHRXJYUlZq?=
 =?utf-8?B?RHFyalB6YWVlSXVBbFpMOUNjdENER1BBb3Bha2I2L0dvUHZuRFVESGR1STBp?=
 =?utf-8?B?UTZIdDB1end5ZkFaU2x5NTdxK0xEZ3RkcFRYM3NsdFUrQUlza2g3WTR0SWsx?=
 =?utf-8?B?eUV1bHhPVEk3bWNSd1pSTURLRmUxeVFDMkNhc2orV01IemRyd1dEamx1Skl4?=
 =?utf-8?B?Y3RTUXNEZWJxZEZwVEt2RWxpSWExRHdTQnRJcVcwRklXZlZ5cUdLUEw1VmNP?=
 =?utf-8?B?RWJocE9wUVZLRVhhWkFRSng5TEtocnhaWGtiMnhDRkZGOEZuOTZuTFpNcXl4?=
 =?utf-8?B?L2RnMjVsTkxrRE5SSE55VWJWR0dWYVEzS01XZ0R4aGlNR3RjOElSNkoySWpS?=
 =?utf-8?B?bGxRSG4rNDhoUFdzQ0tUanZpT2JkVlEvOHFSYjMzKzhiM2JwSUVoL2FWMWIv?=
 =?utf-8?B?Q3ZIVUtJelFJZHI4U2YwZWFzaXA3eWJzNTJFUUxUV2xLSTd1d25KVmwzbDBJ?=
 =?utf-8?B?VnpYeG9MNlErY1FSYUNTUXBCK0g0clpycHBsdyswZGRrZU9GWkp0TFZYb25r?=
 =?utf-8?B?RWN6eGhwTElYdTBYNGpHSE80c1hYc2FxY21PRFFOM05NZEJ3aG5mTTBOVmFP?=
 =?utf-8?B?bVFHc05LUmwrUmdSR2VmSnQ5U0xkbDQ2S0dSK3o2emlCOVhKNTZZckJZUlcy?=
 =?utf-8?B?VmNVUnZHMS9XdUNuU2F1QlVkOTh5dVNQMityb1FhTkR6ajJFSDRKUE1xZW5z?=
 =?utf-8?Q?u4pEvqB7frZ2tDj2UT5QMlj4uGrtq6EpvBppQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3hPa29nN0h5S253TWdXRFQwZzRlMzROVVJrdFVHdE9MTGgyak1xYm0wK1R2?=
 =?utf-8?B?TFF1SjZDREJlSXJBUGNTZGx4WHo5SDNIa0dYNjUyeFZNdFRHYnJlM0VHbXoy?=
 =?utf-8?B?b2QvaC8yMFFvb1NuaWNMQlpMaGlMcGZGR2xaVlo2RnkyaWtOdW5tRXhDUVdR?=
 =?utf-8?B?dGl2bXRTcVVnVEkzendHSkpvOUlETDg2TGFWNE5jVllsZWhla3JTeCtSNzlB?=
 =?utf-8?B?OHNXOE5mYmRIelRNeFY5Z09NbjlSditFeTM5dVZoZE0yNDdac2lLNFFXdnZU?=
 =?utf-8?B?Z21mZERYU0FEeldjYW9wZG1VbVplRDltQjd4M1lRV0ljUG9sT3pvQVVsMDlq?=
 =?utf-8?B?M2I0NlMyQ0t1VDJ3UGJYWXVtb1YwMEdNU3dkWFhUNWhVVThLamdzci9BcE9I?=
 =?utf-8?B?L2Vob3U5Y1lPQ3k4aXBHZWViMGxtKy9GN1JBbGl0dWRWK2xjMUdXMEFzeE1I?=
 =?utf-8?B?SjlYM0d6cHdZdk9iRGpQcUVVY3kyeUw3eFo3d015cHVKYkQ1M0NTOHkrR3R6?=
 =?utf-8?B?K0p4d1pYN2lIQ2xTQ0ZRcDh0ZjZjbS9OL0VYOUlXWkcvNnM4N25YdHVURWFk?=
 =?utf-8?B?cWZHQUorTzN1cjI0YzBzUjRidzMrN3BVZjFIdmlBNkpHYnByVVRlVnExbmhm?=
 =?utf-8?B?YXpxc25VdlVYUnA0dWtMV0ZYRVZZdjJ0M1lGSjBESHo0NHJEdGNpbXRJeUFP?=
 =?utf-8?B?aXJYMTN6Nm9HTE1SVVpoMVhkSGVPU3owU25yckhoVitHR2FFNk54MXZtRllE?=
 =?utf-8?B?TWF4eW40TWcrTURsRzJrV1dLbFB6Q3Jya1I5aldlNko5cHZJaEJxMmY0VFh4?=
 =?utf-8?B?R3pubE1iT0xrNHl3ekh4K0tsRmc5bEVobG8vanptSlE4WmdBRzAzNUhrRnU4?=
 =?utf-8?B?d2xuMHRmL29ka2xUTlJ5Um42RzViOXJ1K1dDVityUjlIbkxDbnJtQVVnMjBi?=
 =?utf-8?B?VlFOMlYxUlNCaEFUbWxIR29XQWMzNFhBUWFNSTVVRmNWSURJYVBnOFhKZis4?=
 =?utf-8?B?TVBMY0phMUV3a050cnRVRlNhdFlDWS9DS1FCT2ExVm1pTGRNSkJqa1VOalpZ?=
 =?utf-8?B?aUJPUmVYVjErTy91c3BRQUZYOUdycUtDcGYwcEw5OEZUeThINWpNbDBaS04y?=
 =?utf-8?B?cGIzT3pDNVAwZk9DK0plblJqbzZ2djREaHNlMGk1Q1FENFpYSzNIL280QVVK?=
 =?utf-8?B?RVBYelhhMXpEOEt3c2RyUU4xMVZ3d0tLNEFWVTdCUnNSY0tsUXlaTTVTaHJ6?=
 =?utf-8?B?VzZPUFdOS2ZOeGNWWVZ3TzVGMDdaQmJNV04wbzRRTXVzSFZCWnNBTkU5VThm?=
 =?utf-8?B?Y2p0bzBqU21xbm5URFhkZW05bEgwdWJoRUE4UEFZRG1MczZWREJlZUN2VDN2?=
 =?utf-8?B?ZHljQ3N1cnd4dm50RSswZGRTVFlheko3dGtENGpIY0tnZHFFRFpKUW5lQksx?=
 =?utf-8?B?WThCakdra3BXT1hOUWNEMlFQL0Q3blZONExMVlpXYkJhdHNUN3RxUkhpVEJL?=
 =?utf-8?B?MmZlTHl3bXlrdkh2VHVMdExIdmtqVzVLNUZNMFhKeXBhZlBZM3JGSTYraFda?=
 =?utf-8?B?L3Z1SzM1VFltdld1VkhLS0ZEaGFKTlB4aGlrK2JOKzJUTHZtUk5DMmtYaG91?=
 =?utf-8?B?WlowZG1rOStFd1Z3VVJNUFhlL3pjaHBXVXUzWU5SNzdwWE5oY1dwc1ozTzl0?=
 =?utf-8?B?dVlYdWRYNGRuWlpCWmVTejZIVE14RG5wWjhKMlNPeTZ5NlkzWE9RM2hVMXAw?=
 =?utf-8?B?YmpsVWMxUkFKVktCekgxWnhZSnU1cUd2bUxNODAxTUhFZm0yNm9SMTFQeDdR?=
 =?utf-8?B?cVAwWGZHL2xqb1ZmdlhKekdIaHpWVkNkQnhpZUJ3bmdJQXZpNFM5VW9oZ1li?=
 =?utf-8?B?c0N2Ni91NWU3U0VQR1ZwRDVKN21XWjJmQTY0MFpURDBWYnoyMThGaDhTRDN4?=
 =?utf-8?B?eFI2Uk9vaXBxd3htZDdTYllRVUp0djJWVjE1MzZidnJKUjQ5cW00cEwxYk0w?=
 =?utf-8?B?cVU3c010VzJ0bTRUY01YNDdnMUJKdFljWGhBUVlQL1h0VzJ1RWZxUHZMc2FG?=
 =?utf-8?B?WE5YSjdLTklWbXU1SXRaNFNadDRrTWdISlVhVlpHdEVYQkZMTWtTYmg4blZs?=
 =?utf-8?B?V2dpcWgySVdxVlJ3NnNFYTFVNTlWdVVVeTd2Vm9odmVtS3lGaVEvdnJIck8x?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6B27FB4E079F84099F1966ADBC9CE90@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CwiMGZysyjFfAXoKBuo4+b1UFtPSSNeUOj8bPiWpdx3b5T+U5FzrH41o5dAUCHYvcUOropH5I6bdWF2LxnkNx82/RtJMKDRyJUHgrQ0yWiYVDTF3HtHBBOrPBqKO4PqamH2l9FXkXymNIJk8Sh53NiPoNhJ+yYqUCiL989AS7PPRuHQG10bTsHnnEIkPP6HxUr2PKi8g7q+Oj/F6+0RlVHiyDcRrP1MleWFW8jvBDQjQzLsm5cG7ZfKXMRX4tFy5kAP1jihgNm+NARVH4mssZeBfLw4C7+OW1cGt/EpqDVJwTd8KMv0GeGf4ilIR7yocHAyCmNePW3Pv3IzDCpSfldHDf+lSn99zwr8FN1h1Cf12CpAnbqtclOx8saqYNJUC5DPt5AxnfNnZA+VGeJFEu4trdy8VfXDOTIwAjR7YWflSh9GJmBgwZrlsIMqsCxYzAy+QSibb4UTh8bx8jYyyRgyq7s8SQ7a2Nju0zY0M3rFJNOpRUm2NhYepvB9H0WXSTTxVDqo+2aSdGr2DaOf/S+GV7Z7bofPg4cYxukjCMX9jY+O51/D/aVu4YaV+Lzy/CymwjVn+P3MQT0IxIIp7C5uZrL/GHFuvokjWBtu2YAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c643905d-0180-47f3-9425-08dd041d39a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 19:56:12.4271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhDkB9vzR+neFw0Cr8nnKd404IPLX3gGloHFjmmFXGHFvtLXG2ixJWHQa5payu9eID/+sWLoQtsNZ+G+wERUHGDBRlA/CAGafYp1C17Dido=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_12,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130163
X-Proofpoint-ORIG-GUID: 59qYLvmrU3yc0c8-T2XcD_YzWzbbmjs0
X-Proofpoint-GUID: 59qYLvmrU3yc0c8-T2XcD_YzWzbbmjs0

DQoNCj4gT24gTm92IDEyLCAyMDI0LCBhdCA5OjQz4oCvUE0sIEsgUHJhdGVlayBOYXlhayA8a3By
YXRlZWsubmF5YWtAYW1kLmNvbT4gd3JvdGU6DQo+IA0KPiBIZWxsbyBQcmFrYXNoLA0KPiANCj4g
RmV3IHF1ZXN0aW9ucyBhcm91bmQgdGhlIGJlbmNobWFya3MuDQo+IA0KPiBPbiAxMS8xMy8yMDI0
IDU6MzEgQU0sIFByYWthc2ggU2FuZ2FwcGEgd3JvdGU6DQo+PiBbLi5zbmlwLi5dIFRlc3QgcmVz
dWx0czoNCj4+ID09PT09PT09PT09PT0NCj4+IFRlc3Qgc3lzdGVtIDIgc29ja2V0IEFNRCBHZW5v
YQ0KPj4gTG9jayB0YWJsZSB0ZXN0Oi0gYSBzaW1wbGUgZGF0YWJhc2UgdGVzdCB0byBncmFiIHRh
YmxlIGxvY2soc3BpbiBsb2NrKS4NCj4+ICAgU2ltdWxhdGVzIHNxbCBxdWVyeSBleGVjdXRpb25z
Lg0KPj4gICAzMDAgY2xpZW50cyArIDQwMCBjcHUgaG9nIHRhc2tzIHRvIGdlbmVyYXRlIGxvYWQu
DQo+IA0KPiBIYXZlIHlvdSB0cmllZCBydW5uaW5nIHRoZSAzMDAgY2xpZW50cyB3aXRoIGEgbmlj
ZSB2YWx1ZSBvZiAtMjAgYW5kIDQwMA0KPiBDUFUgaG9ncyB3aXRoIHRoZSBkZWZhdWx0IG5pY2Ug
dmFsdWUgLyBuaWNlIDE5PyBEb2VzIHRoYXQgaGVscCB0aGlzDQo+IHBhcnRpY3VsYXIgY2FzZT8N
Cg0KSGF2ZSBub3QgdHJpZWQgdGhpcyB3aXRoIHRoZSBkYXRhYmFzZS4gV2lsbCBoYXZlIHRvIHRy
eSBpdC4NCg0KDQo+IA0KPj4gV2l0aG91dCBleHRlbnNpb24gOiAxODJLIFNRTCBleGVjL3NlYw0K
Pj4gV2l0aCBleHRlbnNpb24gICAgOiAyNjJLIFNRTCBleGVjL3NlYw0KPj4gICA0NCUgaW1wcm92
ZW1lbnQuDQo+PiBTd2luZ2JlbmNoIC0gc3RhbmRhcmQgZGF0YWJhc2UgYmVuY2htYXJrDQo+PiAg
IENhY2hlZChkYXRhYmFzZSBmaWxlcyBvbiB0bXBmcykgcnVuLCB3aXRoIDEwMDAgY2xpZW50cy4N
Cj4gDQo+IEluIHRoaXMgY2FzZSwgaG93IGRvZXMgdGhlIHBlcmZvcm1hbmNlIGZhcmUgd2hlbiBy
dW5uaW5nIHRoZSBjbGllbnRzDQo+IHVuZGVyIFNDSEVEX0JBVENIPyBXaGF0IGRvZXMgdGhlICJU
QVNLX1BSRUVNUFRfREVMQVlfUkVRIiBjb3VudCB2cw0KPiAiVEFTS19QUkVFTVBUX0RFTEFZX0dS
QU5URUQiIGNvdW50IGxvb2sgbGlrZSBmb3IgdGhlIGJlbmNobWFyayBydW4/DQoNCk5vdCB0cmll
ZCBTQ0hFRF9CQVRDSC4gDQoNCldpdGggdGhpcyBydW4sIHRoZXJlIHdlcmUgYWJvdXQgYXZnIOKA
mDE2NicgVEFTS19QUkVFTVBUX0RFTEFZX0dSQU5URUQgZ3JhbnRzIHBlciB0YXNrLCBjb2xsZWN0
ZWQgZnJvbSB0aGUgc2NoZWR1bGVyIHN0YXRzIGNhcHR1cmVkIGF0IHRoZSBlbmQgb2YgdGhlIHJ1
bi4gVGVzdCBydW5zIGZvciBhYm91dCA1bWluLiAgRG9uJ3QgaGF2ZSB0aGUgY291bnQgb2YgaG93
IG1hbnkgdGltZXMgcHJlZW1wdCBkZWxheSB3YXMgcmVxdWVzdGVkLiBJZiB0aGUgdGFzayBjb21w
bGV0ZXMgdGhlIGNyaXRpY2FsIHNlY3Rpb24sIGl0IGNsZWFycyB0aGUgIFRBU0tfUFJFRU1QVF9E
RUxBWV9SRVEgZmxhZywgc28ga2VybmVsIHdvdWxkIG5vdCBzZWUgaXQgbWFueSBjYXNlcyBhcyB0
aGlzIG1heSBub3QgYmUgbmVhciB0aGUgZW5kIG9mIHRoZSB0aW1lIHNsaWNlLiBXZSB3b3VsZCBo
YXZlIHRvIGNhcHR1cmUgdGhlIGNvdW50IGluIHRoZSBhcHBsaWNhdGlvbi4gDQoNCg0KPiANCj4g
SSdtIHRyeWluZyB0byB1bmRlcnN0YW5kIHdoYXQgdGhlIHBlcmZvcm1hbmNlIGxvb2tzIGxpa2Ug
d2hlbiB1c2luZw0KPiBleGlzdGluZyBmZWF0dXJlcyB0aGF0IGluaGliaXQgcHJlZW1wdGlvbiB2
cyBwdXR0aW5nIGZvcndhcmQgdGhlDQo+IHByZWVtcHRpb24gd2hlbiB0aGUgdXNlcnNwYWNlIGlz
IGhvbGRpbmcgYSBsb2NrLiBGZWVsIGZyZWUgdG8gcXVvdGUNCj4gdGhlIGxhdGVuY3kgY29tcGFy
aXNvbnMgdG9vIGlmIHVzaW5nIHRoZSBleGlzdGluZyBmZWF0dXJlcyBsZWFkIHRvDQo+IHVuYWNj
ZXB0YWJsZSBhdmcvdGFpbCBsYXRlbmNpZXMuDQo+IA0KPj4gV2l0aG91dCBleHRlbnNpb24gOiA5
OUsgU1FMIGV4ZWMvc2VjDQo+PiB3aXRoIGV4dGVuc2lvbiAgICA6IDE1M0sgU1FMIGV4ZWMvc2Vj
DQo+PiAgIDU1JSBpbXByb3ZlbWVudCBpbiB0aHJvdWdocHV0Lg0KPj4gWy4uc25pcC4uXQ0KPiAN
Cj4gLS0gDQo+IFRoYW5rcyBhbmQgUmVnYXJkcywNCj4gUHJhdGVlaw0KDQo=

